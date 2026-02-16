Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FCE83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Aa-0005YT-4R; Mon, 16 Feb 2026 16:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6AY-0005YK-Qj
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6AW-0003q1-QT
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771277411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oz5Ts3Qyazr1Fg/apL0t/XQrjQkc6Mu38D7gvg35lFc=;
 b=Y3JidwJBpU32VPdn39GI8227r8HKAvApNY8oyiGxKxGjKnqptIIaBaLL5n3W4SUeAlw3kY
 aMjUAdaT2kQXN8XHObp/MP7teZIA4T89cHIvQCnM2BCjbHwD//LCaXmWXqyl1ZC14cE/ne
 EVwq9voICZgAH400oG8n6qnPIgglaT8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-YzvmLm6xMIKZm_DY6Iw3Rg-1; Mon,
 16 Feb 2026 16:30:10 -0500
X-MC-Unique: YzvmLm6xMIKZm_DY6Iw3Rg-1
X-Mimecast-MFC-AGG-ID: YzvmLm6xMIKZm_DY6Iw3Rg_1771277408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABCDA1955DE7; Mon, 16 Feb 2026 21:30:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AED919560A3; Mon, 16 Feb 2026 21:30:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 01/19] [do-not-merge] contrib/plugins/cpp: use __has_include
Date: Mon, 16 Feb 2026 16:29:33 -0500
Message-ID: <20260216212952.420120-2-jsnow@redhat.com>
In-Reply-To: <20260216212952.420120-1-jsnow@redhat.com>
References: <20260216212952.420120-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

(Included for the sake of proving this series does not cause any VM
building regressions; this patch has been submitted separately upstream
by pbo; this series does not otherwise depend on that patch. --js)

This make sure we can include all possible headers without breaking
build for environments missing them. It fixes compilation on openbsd.

We don't want to pollute configure script, as it's really a special case
here to make sure we don't have a compilation regression with
qemu-plugins header.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.53.0


