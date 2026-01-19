Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBDCD29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufQ-0006rL-36; Mon, 19 Jan 2026 14:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufO-0006qT-KG
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufM-0001VA-If
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f30233d8aso30956365ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849915; x=1769454715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZctqSppWns1zLh31eFRQsbIoY++9vlsorD7HNDzT7s=;
 b=TaiQd4PIkGsYhY7tc2Gkad664E21ae/YHlcWby10WLSLxhH02p6pCK/XxZD8o+gh7z
 YKcrnZ/QC66pLt2bbyY0ubbOmTTHdp6Ook7Ncy0EKJYDSanbQAv/We5R7MgZvDujC1hK
 379vArzMMM4Ws6Qn+7BDshPFJkDF2GaT+c+yPL4uLsEbTzK5CAf2M7Rue4xVpuWqdjFw
 GX+ihNb4kRZ5f8ozSDWzGDjeKkmIgyKY4ZjLGs9U5zM5VeHCiJdkllHU7uFGQ6w4tffM
 NUeI/X1wHbCh6nKOhHu+k2cpfyCZJxUryS+gI8WkCq0JSjtRQLbPDgne8UXimhaY/o42
 rZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849915; x=1769454715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZctqSppWns1zLh31eFRQsbIoY++9vlsorD7HNDzT7s=;
 b=aOr3oc/CjIOD9GOyXHbc4pbEJuu6Fj0kQbZ6Q+QLxfePCK9RsAuUO08sxfiwqRggoW
 fJU63cjq+gQEI9KoC2/10SUJLToqRpjfz8XWOzdj/7/ppQqxhAxStrcFz7pLqnpgm22M
 qZEpa09Tj2EJSKcWV+3gp3kDs1CMRpOTvHRyALgbOUuYM5bsVbv/CN7toDyd6TxVT7kz
 sbjnsu/ZsV56sFxZAUEUrULVd6Z8NjPPjpd0NDKz+Rwua/+lZAfcZ/bSGB+ksnAqDPyQ
 /7VAKwD25Dr7MOKT9u7ZWfPw2LhZ5FA+tV4y851U2bqO5DU8f9GUZTK11qJOQT60jAoQ
 6d2A==
X-Gm-Message-State: AOJu0YzxNTIk2Y1teSEBbnr5F25QqjRX9IlyMNnOEqHeXjx8uagnRxM5
 rrlBt3QtQ9RNk8eCKCwtLy4Y83hyYi+biWc1XyV2E2aUCJaJZL3/rFsOVJa12Hdsoa+sBrpA/ff
 rs1F0
X-Gm-Gg: AZuq6aJyr7dCPJAxB/GtTZwfctzSCnhEc8et53CGgW4UnB5UAmXSTIZmGV1ya1JL+Y9
 h3KTvcVuhErJC8DcvTq0wLUTDV3O4NO3KiWd+3wIf3vl4MFtqy6iuleKIByPTAkr4cKIDmOjy5h
 ATklRZ9JYo6j7CvWRLkIdE8h8fomCphwnFitGGFmu8oDoos3pru+FR+kKCoGRXaQ1f2/yRkRF09
 KefOzs08BlBOGITHMPAUtBVokv5vZvCWpw138tb9awQEwQa7TYmYYexvOKnnxswMBmCajzWUlBm
 4HquUFfVF0GpO/2DuZhGBOB3wd/juD6NmYpcCqmH+sNxJ9Dao2lQU0RuWinQfl186aBKe+DlnwQ
 AD5BGts1v8w155Xs8bSYn8MOyxnJsovfCYhy5XB+/Bjb8wv61z/MwcH37hE2zvLC4/R3r3jTNJU
 zePSXwhD4TqRfmcP4RmL6Yhh+r2IC+1AfEXgiBILpWGn79hhP4FmdSPvCByRyAaBm+
X-Received: by 2002:a17:903:24f:b0:2a1:388d:c084 with SMTP id
 d9443c01a7336-2a718949647mr95861445ad.42.1768849915079; 
 Mon, 19 Jan 2026 11:11:55 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:54 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/11] contrib/plugins: add empty cpp plugin
Date: Mon, 19 Jan 2026 11:11:37 -0800
Message-ID: <20260119191138.811069-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This plugin makes sure we can compile in C++ while including qemu-plugin
header. It includes all C++ standard headers, up to C++23 standard,
minus the ones that are missing in the oldest environments we need to
build for.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cpp.cpp     | 119 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   4 ++
 2 files changed, 123 insertions(+)
 create mode 100644 contrib/plugins/cpp.cpp

diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
new file mode 100644
index 00000000000..1ff54896d97
--- /dev/null
+++ b/contrib/plugins/cpp.cpp
@@ -0,0 +1,119 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This C++ plugin ensures we don't have regression when compiling C++.
+ */
+
+#include <qemu-plugin.h>
+
+/* https://en.cppreference.com/w/cpp/headers.html */
+#include <algorithm>
+#include <any>
+#include <array>
+#include <atomic>
+#include <barrier>
+#include <bit>
+#include <bitset>
+#include <cassert>
+#include <cctype>
+#include <cerrno>
+#include <cfenv>
+#include <cfloat>
+#include <charconv>
+#include <chrono>
+#include <cinttypes>
+#include <climits>
+#include <clocale>
+#include <cmath>
+#include <codecvt>
+#include <compare>
+#include <complex>
+#include <concepts>
+#include <condition_variable>
+#include <coroutine>
+#include <csetjmp>
+#include <csignal>
+#include <cstdarg>
+#include <cstddef>
+#include <cstdint>
+#include <cstdio>
+#include <cstdlib>
+#include <cstring>
+#include <ctime>
+#include <cuchar>
+#include <cwchar>
+#include <cwctype>
+#include <deque>
+#include <exception>
+#include <execution>
+#include <filesystem>
+#include <forward_list>
+#include <fstream>
+#include <functional>
+#include <future>
+#include <initializer_list>
+#include <iomanip>
+#include <ios>
+#include <iosfwd>
+#include <iostream>
+#include <istream>
+#include <iterator>
+#include <latch>
+#include <limits>
+#include <list>
+#include <locale>
+#include <map>
+#include <memory>
+#include <memory_resource>
+#include <mutex>
+#include <new>
+#include <numbers>
+#include <numeric>
+#include <optional>
+#include <ostream>
+#include <queue>
+#include <random>
+#include <ranges>
+#include <ratio>
+#include <regex>
+#include <scoped_allocator>
+#include <semaphore>
+#include <set>
+#include <shared_mutex>
+#include <source_location>
+#include <span>
+#include <sstream>
+#include <stack>
+#include <stdexcept>
+#include <stop_token>
+#include <streambuf>
+#include <string>
+#include <string_view>
+#include <syncstream>
+#include <system_error>
+#include <thread>
+#include <tuple>
+#include <typeindex>
+#include <typeinfo>
+#include <type_traits>
+#include <unordered_map>
+#include <unordered_set>
+#include <utility>
+#include <valarray>
+#include <variant>
+#include <vector>
+#include <version>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 3d2d7862e0c..53d52c97967 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -6,6 +6,10 @@ if host_os != 'windows'
   contrib_plugins += 'lockstep.c'
 endif
 
+if 'cpp' in all_languages
+  contrib_plugins += 'cpp.cpp'
+endif
+
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-- 
2.47.3


