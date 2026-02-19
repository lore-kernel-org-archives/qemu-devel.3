Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4BAC531CD
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 20:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtAk4-0004OE-6w; Thu, 19 Feb 2026 15:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtAk2-0004Nl-Ja
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:35:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtAjz-00058C-7F
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:35:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad22a5e245so9992145ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 12:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771533314; x=1772138114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZ5P//QidrUfYIRqNX62u+eFOou5c90zjpKqF4TTZtI=;
 b=sBCUl9aNEmfVUn4hqP6dy85WZOwc4XFq7kO6CVcC7pYHzX6cpdgPID4OH5lXxcYYCm
 LcismMXLWyZCbFRoZPsKX9AvPaUT5HGH0Z8K2+762tROUWrX2CqZioo9/HbcDISliCrM
 GMZxRwmJuDcmarqGlhZ0hbCGwVOQs4oiwoD/Mt12d6NAChd7jQrnwM7pTz7SBKUrpMHc
 6qkTYletK5cA/TnQM1+ElK0tA8cFyxHd/lfaAWAYyBufzH3+0hIJQ+QXYYjMfTKnm8Yw
 9GZy+XVMNZrt992NqauscRzznQK8DclCWp2OqEX9bLd538X9SM7YDPIVnUks0t53Kp2f
 c35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771533314; x=1772138114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rZ5P//QidrUfYIRqNX62u+eFOou5c90zjpKqF4TTZtI=;
 b=YDZ07jJGi8aLKmkUfzyiFBJZrAy8yu2smJ12vB5DY+HqRxE48KQb6MW9ngbqeYf1AK
 vMdN2rLvZ92gggpjY317QspjCYzUGL7vciFMpFRHe1M85uEwaQ8+2k7A4yI9F/wIZdO0
 9+M+dLfGlU2nG4fQ/8ktyheLF6GSIf9eAWMgGB+yAR+URA2jN1aeYfvK6FoEsVNTkXYa
 B9uBwt057Pfx4xKoAVGnYJ9dJ32jVFSyHgdVabs8mCifqKOU43pN+Ewekk8insroOnZI
 ZChlBpTmRJ2EnBwrWaI7T7wGsKhGD9a3K/LGBQ5klU4qIOdaDHOCqqZ5CSV2QW4GRVIV
 ibfg==
X-Gm-Message-State: AOJu0YwhZ52wAyXK3237vbTLl+RtsW86bQSbX7bawTTwhRpId1Sfri3y
 Y7YeGSylpxnwaDPdqin0YaXqpiURasTBSYBfkf269SaKaj/rMKBZDkWjQx1ivZlCgIDMdVqBCv2
 Q+P0a
X-Gm-Gg: AZuq6aL5+uTmsQ9QJA3tO930sBNkht2uVTPDyUaRmyNGM4qTh7yfwtcmFqKjtlOyi14
 vEdFFxVv1mSq7PoX4l1igIe6yGPbcIrgnJEqe+kGd3fZTjkY330ykeycejuZP1DdpoIPBaQrqhN
 GainZNPnVbtyvfS86G794aWDW5zRvPi68HnUftDx32rahV83yaRGuqS/Zzdu5TtrNK19glUet0D
 NQZlFsCpORzjoLVNpjDE1n9h/5HCDsuSlFUmOkev0zxlmp4au4QzeOkUbDGQtOoJ6JJ+VMxKKB8
 zSR0w/VWBidZ29hTyrlyAU6XuH1SU6h7uoOeH7c+MQcikDOZStWo9PTIB2+Es/DDsSL4lycxFn/
 j+4OpXZJ4FiLY3V0cYNvhO2p736odTzKS9rHt66qWc/SWHcU+5KBYW0uAiN9eOnGbEvDD5jxHJ3
 McqbJmOOkfPm4OaHRohat3wSbMXilTS9Q5c62UPSp0gS3NBAYcG38hY6RgKaJX9TJGx9sHXtt8W
 bKl
X-Received: by 2002:a17:903:32c5:b0:2aa:d201:25f6 with SMTP id
 d9443c01a7336-2ad50f9bcb4mr64388515ad.45.1771533313664; 
 Thu, 19 Feb 2026 12:35:13 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadc7f8sm169325795ad.66.2026.02.19.12.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 12:35:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] contrib/plugins/cpp: use __has_include
Date: Thu, 19 Feb 2026 12:35:07 -0800
Message-ID: <20260219203507.3502009-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219203507.3502009-1-pierrick.bouvier@linaro.org>
References: <20260219203507.3502009-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

This make sure we can include all possible headers without breaking
build for environments missing them. It fixes compilation on openbsd.

We don't want to pollute configure script, as it's really a special case
here to make sure we don't have a compilation regression with
qemu-plugins header.

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260214061025.1239457-1-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cpp.cpp | 261 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
index 1ff54896d97..0673c4f074d 100644
--- a/contrib/plugins/cpp.cpp
+++ b/contrib/plugins/cpp.cpp
@@ -6,103 +6,360 @@
 
 #include <qemu-plugin.h>
 
-/* https://en.cppreference.com/w/cpp/headers.html */
+/*
+ * We include all C++ standard headers (without deprecated ones),
+ * taken from: https://en.cppreference.com/w/cpp/headers.html
+ *
+ * To update, copy page text, and then:
+ * grep '^<' |
+ * sort -u |
+ * grep -v strstream |
+ * grep -v codecvt |
+ * sed -e 's/\(.*\)/#if __has_include(\1)\n#include \1\n#endif/'
+ */
+
+#if __has_include(<algorithm>)
 #include <algorithm>
+#endif
+#if __has_include(<any>)
 #include <any>
+#endif
+#if __has_include(<array>)
 #include <array>
+#endif
+#if __has_include(<atomic>)
 #include <atomic>
+#endif
+#if __has_include(<barrier>)
 #include <barrier>
+#endif
+#if __has_include(<bit>)
 #include <bit>
+#endif
+#if __has_include(<bitset>)
 #include <bitset>
+#endif
+#if __has_include(<cassert>)
 #include <cassert>
+#endif
+#if __has_include(<cctype>)
 #include <cctype>
+#endif
+#if __has_include(<cerrno>)
 #include <cerrno>
+#endif
+#if __has_include(<cfenv>)
 #include <cfenv>
+#endif
+#if __has_include(<cfloat>)
 #include <cfloat>
+#endif
+#if __has_include(<charconv>)
 #include <charconv>
+#endif
+#if __has_include(<chrono>)
 #include <chrono>
+#endif
+#if __has_include(<cinttypes>)
 #include <cinttypes>
+#endif
+#if __has_include(<climits>)
 #include <climits>
+#endif
+#if __has_include(<clocale>)
 #include <clocale>
+#endif
+#if __has_include(<cmath>)
 #include <cmath>
-#include <codecvt>
+#endif
+#if __has_include(<compare>)
 #include <compare>
+#endif
+#if __has_include(<complex>)
 #include <complex>
+#endif
+#if __has_include(<concepts>)
 #include <concepts>
+#endif
+#if __has_include(<condition_variable>)
 #include <condition_variable>
+#endif
+#if __has_include(<contracts>)
+#include <contracts>
+#endif
+#if __has_include(<coroutine>)
 #include <coroutine>
+#endif
+#if __has_include(<csetjmp>)
 #include <csetjmp>
+#endif
+#if __has_include(<csignal>)
 #include <csignal>
+#endif
+#if __has_include(<cstdarg>)
 #include <cstdarg>
+#endif
+#if __has_include(<cstddef>)
 #include <cstddef>
+#endif
+#if __has_include(<cstdint>)
 #include <cstdint>
+#endif
+#if __has_include(<cstdio>)
 #include <cstdio>
+#endif
+#if __has_include(<cstdlib>)
 #include <cstdlib>
+#endif
+#if __has_include(<cstring>)
 #include <cstring>
+#endif
+#if __has_include(<ctime>)
 #include <ctime>
+#endif
+#if __has_include(<cuchar>)
 #include <cuchar>
+#endif
+#if __has_include(<cwchar>)
 #include <cwchar>
+#endif
+#if __has_include(<cwctype>)
 #include <cwctype>
+#endif
+#if __has_include(<debugging>)
+#include <debugging>
+#endif
+#if __has_include(<deque>)
 #include <deque>
+#endif
+#if __has_include(<exception>)
 #include <exception>
+#endif
+#if __has_include(<execution>)
 #include <execution>
+#endif
+#if __has_include(<expected>)
+#include <expected>
+#endif
+#if __has_include(<filesystem>)
 #include <filesystem>
+#endif
+#if __has_include(<flat_map>)
+#include <flat_map>
+#endif
+#if __has_include(<flat_set>)
+#include <flat_set>
+#endif
+#if __has_include(<format>)
+#include <format>
+#endif
+#if __has_include(<forward_list>)
 #include <forward_list>
+#endif
+#if __has_include(<fstream>)
 #include <fstream>
+#endif
+#if __has_include(<functional>)
 #include <functional>
+#endif
+#if __has_include(<future>)
 #include <future>
+#endif
+#if __has_include(<generator>)
+#include <generator>
+#endif
+#if __has_include(<hazard_pointer>)
+#include <hazard_pointer>
+#endif
+#if __has_include(<hive>)
+#include <hive>
+#endif
+#if __has_include(<initializer_list>)
 #include <initializer_list>
+#endif
+#if __has_include(<inplace_vector>)
+#include <inplace_vector>
+#endif
+#if __has_include(<iomanip>)
 #include <iomanip>
+#endif
+#if __has_include(<ios>)
 #include <ios>
+#endif
+#if __has_include(<iosfwd>)
 #include <iosfwd>
+#endif
+#if __has_include(<iostream>)
 #include <iostream>
+#endif
+#if __has_include(<istream>)
 #include <istream>
+#endif
+#if __has_include(<iterator>)
 #include <iterator>
+#endif
+#if __has_include(<latch>)
 #include <latch>
+#endif
+#if __has_include(<limits>)
 #include <limits>
+#endif
+#if __has_include(<linalg>)
+#include <linalg>
+#endif
+#if __has_include(<list>)
 #include <list>
+#endif
+#if __has_include(<locale>)
 #include <locale>
+#endif
+#if __has_include(<map>)
 #include <map>
+#endif
+#if __has_include(<mdspan>)
+#include <mdspan>
+#endif
+#if __has_include(<memory>)
 #include <memory>
+#endif
+#if __has_include(<memory_resource>)
 #include <memory_resource>
+#endif
+#if __has_include(<mutex>)
 #include <mutex>
+#endif
+#if __has_include(<new>)
 #include <new>
+#endif
+#if __has_include(<numbers>)
 #include <numbers>
+#endif
+#if __has_include(<numeric>)
 #include <numeric>
+#endif
+#if __has_include(<optional>)
 #include <optional>
+#endif
+#if __has_include(<ostream>)
 #include <ostream>
+#endif
+#if __has_include(<print>)
+#include <print>
+#endif
+#if __has_include(<queue>)
 #include <queue>
+#endif
+#if __has_include(<random>)
 #include <random>
+#endif
+#if __has_include(<ranges>)
 #include <ranges>
+#endif
+#if __has_include(<ratio>)
 #include <ratio>
+#endif
+#if __has_include(<rcu>)
+#include <rcu>
+#endif
+#if __has_include(<regex>)
 #include <regex>
+#endif
+#if __has_include(<scoped_allocator>)
 #include <scoped_allocator>
+#endif
+#if __has_include(<semaphore>)
 #include <semaphore>
+#endif
+#if __has_include(<set>)
 #include <set>
+#endif
+#if __has_include(<shared_mutex>)
 #include <shared_mutex>
+#endif
+#if __has_include(<simd>)
+#include <simd>
+#endif
+#if __has_include(<source_location>)
 #include <source_location>
+#endif
+#if __has_include(<span>)
 #include <span>
+#endif
+#if __has_include(<spanstream>)
+#include <spanstream>
+#endif
+#if __has_include(<sstream>)
 #include <sstream>
+#endif
+#if __has_include(<stack>)
 #include <stack>
+#endif
+#if __has_include(<stacktrace>)
+#include <stacktrace>
+#endif
+#if __has_include(<stdexcept>)
 #include <stdexcept>
+#endif
+#if __has_include(<stdfloat>)
+#include <stdfloat>
+#endif
+#if __has_include(<stop_token>)
 #include <stop_token>
+#endif
+#if __has_include(<streambuf>)
 #include <streambuf>
+#endif
+#if __has_include(<string>)
 #include <string>
+#endif
+#if __has_include(<string_view>)
 #include <string_view>
+#endif
+#if __has_include(<syncstream>)
 #include <syncstream>
+#endif
+#if __has_include(<system_error>)
 #include <system_error>
+#endif
+#if __has_include(<text_encoding>)
+#include <text_encoding>
+#endif
+#if __has_include(<thread>)
 #include <thread>
+#endif
+#if __has_include(<tuple>)
 #include <tuple>
+#endif
+#if __has_include(<typeindex>)
 #include <typeindex>
+#endif
+#if __has_include(<typeinfo>)
 #include <typeinfo>
+#endif
+#if __has_include(<type_traits>)
 #include <type_traits>
+#endif
+#if __has_include(<unordered_map>)
 #include <unordered_map>
+#endif
+#if __has_include(<unordered_set>)
 #include <unordered_set>
+#endif
+#if __has_include(<utility>)
 #include <utility>
+#endif
+#if __has_include(<valarray>)
 #include <valarray>
+#endif
+#if __has_include(<variant>)
 #include <variant>
+#endif
+#if __has_include(<vector>)
 #include <vector>
+#endif
+#if __has_include(<version>)
 #include <version>
+#endif
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-- 
2.47.3


