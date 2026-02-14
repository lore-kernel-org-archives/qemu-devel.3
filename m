Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AAFEDF142
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 06:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr8rh-0003Vo-Vk; Sat, 14 Feb 2026 01:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr8rg-0003Vb-5R
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 01:10:48 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vr8rd-0000aF-MD
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 01:10:47 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2aad9b03745so8250255ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 22:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771049444; x=1771654244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S/TdjhIX7ndaIiCITprzVCbcaXDOvqYMczYb6hGcNms=;
 b=ysOkIOMDMa4fl3qZ+u2n7efahtd/szdV4d5oBQIcit5H7GRVv8pTW8Spmt92GLJXJP
 4n6dmw/wqQNVlNWbLT38kMC5w4S85R8YYuz2yPrg9FD/AoCquTL1chsofoUjBIccjKUg
 +zy7tE22ii8KLN1lcPQRz+ZGGsCttDZgd79TrEj1ZenpkH6hJ5X6bxVsycjdEQ5u85Yi
 56wLqYpwro0tErvvDHumiWGWENV9l1WFZDL3vb3yt21hIYJNyQO3KXYM0xCzJQX8yIYA
 6z1vncNs1GebSYTLbGoPxzG5WLLe6b9dZ2jH/GSsZ9OY0uG6+BRdDwTU6j2/FbWm8bC8
 3inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771049444; x=1771654244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/TdjhIX7ndaIiCITprzVCbcaXDOvqYMczYb6hGcNms=;
 b=PmNM87uZb0B/3aeeaay8DUwL5lS5UpWIw860wRRBEtTQoF8LqfsKqeRItlffXFKXkV
 asvujaAfSeIxrsXnLaNY0zpfFcqg8zfwXWSzu/rWv4sriBC3yQdEKnhUNkiAgfv/FtMM
 HWKrZpYM/uVOIX4H59vQU8shgYUal/JAoHo9dHcCQkW4bq/1FdPrMmShwT5wP/cko7M0
 DievxzPGbV6+4sDs/cp1pIWEkhhkqWee0SqiPS4ky4wxfMrFCDddoBHVCJnwqDyQugSy
 gV0flcrs84R72Tk/AhRFivFG2v/nGVgc4Md0Tk37IF11hKSP2Vr/HdJ9a8fTArXNCu+b
 nx3w==
X-Gm-Message-State: AOJu0YwGmFVU9xsKKALF+JwXu8TZ/Z0nYy5Lfg2ScLgzzseSeJJMKubI
 LECEezPVulWD2FryW3+1oYPX7XGtPywWOnisnnEL+MUffQGMQB/1jJZf0ajG+VeiFQMSYG5mSQa
 vEAgs
X-Gm-Gg: AZuq6aJkEomlSTTLwH1PSkAdPl5CdKcgyq14BFBRcH/S5yEidvxhTSoNACqPKy0/Pxr
 PcrtMEiJnfYSbEVQ7yS8oIQluutZYT/1nr7hIt46uWakGu4tSCGFLZWuezdAGU+VNClsrwS9PUN
 koJJHe/gJFPpHHWOP5IwCfBW5jqz0rymQv4/K+nIYz0Uwr0RkV1hQhsEDk+6HrYTqusuaRsv6fw
 4pLVLXGaiEa748XLNe+l2xgE/Lhkbuz8X/1N46tdSz63bDnzWhUGhEfbuOsVjCkT0EdlmtJWl7f
 vL7I2ew0atgIOBbOR64svuj0Lwg3iV0xHHEO2iWmQRE3QzZwKuazI43leWFapIx9xUmG76/4Lao
 pylRUUvkQp8a9F3i/pLSpCznbUGV8nYJkdqWhH5z5h4AGVlpw53TFfpNwq4/oDRVtPtrljsVBBQ
 OsEg0M1/VwRRhew2P0nb5CtCXGT4fB/goiOMwecRXi1hYqzozBskf75nWZP1FAuNpR+qWmWmoR9
 MXQ
X-Received: by 2002:a17:903:32d0:b0:2aa:e1f0:5481 with SMTP id
 d9443c01a7336-2acba598d5fmr25974095ad.30.1771049443791; 
 Fri, 13 Feb 2026 22:10:43 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadbb9bsm8545945ad.62.2026.02.13.22.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 22:10:43 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>, jsnow@redhat.com
Subject: [PATCH] contrib/plugins/cpp: use __has_include
Date: Fri, 13 Feb 2026 22:10:24 -0800
Message-ID: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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


