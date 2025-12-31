Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE05FEE57D5
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqiu-0007fI-V8; Wed, 31 Dec 2025 02:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqit-0007eI-M1
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:23 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqir-0001CE-DO
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:23 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so8241458b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166460; x=1767771260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+AxFbchQtu+7N2YMcrXUf/7RNfk/wHHqGPJI7NpXWg=;
 b=nEr92oQXtE2daAJRi4cUbd3QD4RkOsumPW0EPQQSAvW84S803N81BjvxbCgyisjpgK
 TCk9I/QnxoglQhRaK40wuvxdJmlqe16dTKmu5xDSobwPyb9xRVArX7B7MUPeMBt9XDEy
 2Z2AzHtRIuOMztmEXPJJ/gBvpepfdJoSl4V8PK2nl7uWt9ic24re6t4X5jcwAOWDPsi+
 grAgTiTMotdN0U2u0gvp0oWMFOhM8WMiazc1WaljoWBSoQesl5jeLlM9kZ9CKdYDOKvJ
 4+vGT/VvS2Ah0uLjifNxpKW4N+LzvA3jYq6XpcbDeazv3JnH7c2gB5KVMQnhEa+amMTH
 wlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166460; x=1767771260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4+AxFbchQtu+7N2YMcrXUf/7RNfk/wHHqGPJI7NpXWg=;
 b=hhheUYgnc/RegVc/k+/HAv1yMRpCWlLadk383vkQioIsoTnCodSqCY39IqlZHwUids
 ShlpC4QZSOQGFApgAj5782svqgbHhNtcmPOB63ozW2WBH49ivAj6eJDXU3Gge8NhX5fT
 FEGtCIaIcb+rPnliOBBBuxClNsbEPfI+IeIn5q9w0NgPPLEZxt9y7IK6nI9cGA8JEcz2
 cO9UBhiYF2KvchL1RukF1W4vqCcRUjATAixiAaEQo6ZBi+hOFLuJexSfIuEbHY47qofm
 N1nccdKAVpCV3VO3D6BEckwrFH3+c0ByjUm/pXwEWsTTdd6oWG2SwzYKM+mrL9yiKX+0
 8tFw==
X-Gm-Message-State: AOJu0YzIkyFs/d7xRVes83f6vTVQB8th8U38w37H8j7KGxHEz6APEFG5
 q7Dfw4GizCf5BjFMbLTHaMcQK5d/+L57wCa2qNZrd3SU7cYa0bMMnKuAvbqh8o1h3j1AdmB/aHf
 nayK4
X-Gm-Gg: AY/fxX7KqpGX7m78PHkeoe4Mnfbyz5mg3tTUFrw8qyn+UZ6K2IOA8vaqI84q75jE/p7
 p0PCYzvmTneNxkcAKeqQya76zA0z1tyjnX0GgDZRtjaIz4pIwRUsgZbyPAWNk0+VjUdzHdU7+tk
 uC5ELcoT9C5sJEjscTHvdRH4mhbYyR8JqgcBX4IAtdc8y2ezTFiD/8udrSgJNnfvFQ/OlJbWScF
 QjZJD+i8RD9MMPqLj508LVS+4BWwWUknBcvJ7vE3TXBxb8d+Y8fxfGLX2vHXu7FiGQMkOG+pGac
 rT98bXCGNNlmPHNuZ6t1RDpUqStceemmFuX5icET3Etzt2TVy+ZitJ7kJsFoCjHtOYp85++fk5R
 yA5tJbbdefKCPwhIwfXahoAau6OoIj8CVxeQCGI/g2nGl3A5Cvcq07BnZANvCpNLRRe/T/RsDCM
 axpXkznmcFHycw/mADdqD5n0dqhBHDFk7EhW2e2i6YoKyy1vX91HewGa4XQSuZMUaS
X-Google-Smtp-Source: AGHT+IGg5UJc0A/y9zYSpRzeW8pcLR7j+AdujAa4Cmir2i7yTsLcAC8ERQF67ckJV7TtFCUTdAt02g==
X-Received: by 2002:a05:6a00:228a:b0:7ff:acc0:869f with SMTP id
 d2e1a72fcca58-7ffacc0879bmr30377724b3a.3.1767166459875; 
 Tue, 30 Dec 2025 23:34:19 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/11] contrib/plugins: add empty cpp plugin
Date: Tue, 30 Dec 2025 23:34:01 -0800
Message-ID: <20251231073401.2097765-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: <qemu-devel.nongnu.org>
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


