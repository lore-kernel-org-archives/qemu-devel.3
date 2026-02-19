Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE27E9A05E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9yu-0007OI-C1; Thu, 19 Feb 2026 14:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt9yr-0007O4-Si
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt9yp-0006E9-I8
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771530390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grO1KrcP0Xk82oHicKubDcQrHT3B/k63JUfz8MfYh6k=;
 b=h6bATZ/itO3hFlhJaFNYWbvXj7tnxgjLgAbe8xOFJPC1yfrGgK2TbgnkT30LHg8m9cuIpI
 e/FceOTZUBGE9qxP0JdTj+x7oKzZn+LMOA93YAZ3EYf6oNpuwdhLUMKg/QJM/SMr1p1Jm2
 YYokFAUNsd1KVJuzWUSLSnmJcu2nb8Y=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-K5hGxQ0JMa2W-iG827pwRA-1; Thu, 19 Feb 2026 14:46:28 -0500
X-MC-Unique: K5hGxQ0JMa2W-iG827pwRA-1
X-Mimecast-MFC-AGG-ID: K5hGxQ0JMa2W-iG827pwRA_1771530388
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64ad18e7ffaso1953709d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:46:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771530388; cv=none;
 d=google.com; s=arc-20240605;
 b=PkpG/gyDMfeOTuQDszxuSGB4y1sz3PmzQScV/vxRcV3Doasy1g2Pbi25kdIAp71xFk
 5OFcojSxYwK160KZNzJ4jAoWwArEjweAmPRrW93AbH7RLwIzwZOxFyjPpNPFTUROvQzV
 bmxiyombqqljcrLzpbYz0qozzcy9Q9xbr/4Ir2wgODeHMhaikm00KCeGcRaF2N7/YDdm
 oRa0daFEaV1Os1/lh+qZkohz7lu1JUtQBGf44XxHCwUh9VHhAW1evlHMPJVNO7S3OTk1
 hfOtuYFMHQd6EbB0k8oP8+T3Yq4mRc2GZARFjxgtHWDwom1sR1qFnClX9Uz9QkmQtP0q
 Z4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=grO1KrcP0Xk82oHicKubDcQrHT3B/k63JUfz8MfYh6k=;
 fh=BOrBKWTVXG66wETpXxZnic/GRcGQC/4mTcHPOlgdvK4=;
 b=CNoi++7vDjMIxl0Oms+71fipvSmuefo96JEtebvhr9PQjTNlPD18jmIS88d0adkypl
 ljbaw9Y4klQKNPqNEGZon85Ud6K5ZWn7vXxK0mRtRVl00j2x5kCpAsOBWJ55mR5/ynIT
 hPhsx+XI0k1umLKNsNd3gNwZRvFuX9kxB2pmO5Mrpb6Gj1GlYGi2bkIGcWqwDduUayAi
 3RmpDhELTLiZ9ECIvVS/DfCFSSLAfOQvhUBPHXAiCPfgFFL4Lk9rZ2R0M1FVWwF7FVo/
 m0APTMrGXeIsLL4ZWQCTCI8HfDu9hTlQwxoWYCmj4+oKZ8+KOTb4518fhhDphdbeazDM
 zXTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771530388; x=1772135188; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grO1KrcP0Xk82oHicKubDcQrHT3B/k63JUfz8MfYh6k=;
 b=dDl2eY+3ujc1Y8aKRMMzaJyi+y1JjYU4AyMh9Y9zLXx0sVwHmcK0yhUb5azD5dzFTO
 pPQnv8oXuUic+AO+4zKLu2ZmX+WObSK8arwdKukbUXLYnf8uZqfgnqNrzlYRb6kIbmgj
 JLI9CLf4nGd03i7x9Ex+xHJZ8pAmOu6KfzYQMohezsIgH+xdUzk0I6nU4QSXsbDfOzqD
 sWraH6ck4mouQKYpqgIoQNkr3eY99svbdIc4N/QRNla10eUSGYN2zAtwxztZ1xtvS4+Y
 VnNQbavC15PB8uWN/eXXitGKI6rli5FKU3T14VukAs8ceRIde5Iy5BiNGcKdrczHuvjj
 wlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771530388; x=1772135188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=grO1KrcP0Xk82oHicKubDcQrHT3B/k63JUfz8MfYh6k=;
 b=EK/0IEtEsr90wYo6K/jDwChzoPbWXIxfzPW9bTv5Ta7LBtT8kuiNqXXGkqTQ8iA/Ed
 keNCJeFPJuUm1cWib0KUzIi3eysFALOtD9W85k3yLDu2nMEL6DJzpk7VVlOO3rVP0XVP
 VgITdQJ5CTe8awl1oTziuvEf970HhXLMeahg9O/fsnTIvsc1Uh0ccEYUVT1SHPPvf8i4
 Gt7n0kvkq5qKunBE8jY0uLkenbd/DURqyrzWNRyXu3cmJHIIHHuNT4KPIBcFYNAX6dy8
 /wGoYhNzQTjHzC8WgI2erTQG8O1/E7moiivIdaCDhe5rtvWjg5xtFMFRE/cx2AOZ7RKa
 atBQ==
X-Gm-Message-State: AOJu0YwtezwzwYctfyl9tkWPT4vCOBS56d3No+k5iQmx1NlBcXVBVEfX
 DCkWLopC1QAYfx8Tb4yazqbFyIL/CkZi/tcFft/6cgRdd//LQVjKX6rCeNvZysVhw1v1ldBc7dQ
 4A3n57/Pk3P5zys2RzMn0hHebCxsAmXbV/Elk5QqaZitmtIDSRSyBBzNaagd1UpDnblqrDiWBTD
 s0IIgWOlWEvNKRhIBIvpT9uj2wA7ks2hI=
X-Gm-Gg: AZuq6aJe2avIRffpiEfEfHk6ooimV8yhtSpANJRjG1hlGUY1TzGfaKUaRIECKNlSQiV
 l0nTNpRwPPmKcK6h4NiQr6jQMeqznmnBebKsLlQo8Sn6PHz/sxpxULQ0ml9u/fhNhbOKGT7Ndzq
 QhZklTgcrgyFREgJd71SKdJChgyJ2+flmhoS4LwGr4FEvIRbdzCnGcEQDHYRAHON4e4ONG/FhbF
 ZRB9fcoP/aaCAOG+XaM16EpTSrbsPfVpKKWzQ==
X-Received: by 2002:a53:e008:0:b0:64a:db50:fab2 with SMTP id
 956f58d0204a3-64c14dcbd3amr13643458d50.80.1771530387955; 
 Thu, 19 Feb 2026 11:46:27 -0800 (PST)
X-Received: by 2002:a53:e008:0:b0:64a:db50:fab2 with SMTP id
 956f58d0204a3-64c14dcbd3amr13643443d50.80.1771530387594; Thu, 19 Feb 2026
 11:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260214061025.1239457-1-pierrick.bouvier@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 19 Feb 2026 14:46:16 -0500
X-Gm-Features: AZwV_QjAEFGM8U_Bs_XGooiPZ1nrVmqAXnLdsErc8CvLXTX2a6FuM1bEl1HQ1MQ
Message-ID: <CAFn=p-ZUH+uG0mE_PGs-2Bwik+e_b0e5wf-bS4KKOE1SvP1=4g@mail.gmail.com>
Subject: Re: [PATCH] contrib/plugins/cpp: use __has_include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, philmd@linaro.org, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 14, 2026 at 1:10=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> This make sure we can include all possible headers without breaking
> build for environments missing them. It fixes compilation on openbsd.
>
> We don't want to pollute configure script, as it's really a special case
> here to make sure we don't have a compilation regression with
> qemu-plugins header.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Tested-by: John Snow <jsnow@redhat.com>

Thanks!

> ---
>  contrib/plugins/cpp.cpp | 261 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 259 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/plugins/cpp.cpp b/contrib/plugins/cpp.cpp
> index 1ff54896d97..0673c4f074d 100644
> --- a/contrib/plugins/cpp.cpp
> +++ b/contrib/plugins/cpp.cpp
> @@ -6,103 +6,360 @@
>
>  #include <qemu-plugin.h>
>
> -/* https://en.cppreference.com/w/cpp/headers.html */
> +/*
> + * We include all C++ standard headers (without deprecated ones),
> + * taken from: https://en.cppreference.com/w/cpp/headers.html
> + *
> + * To update, copy page text, and then:
> + * grep '^<' |
> + * sort -u |
> + * grep -v strstream |
> + * grep -v codecvt |
> + * sed -e 's/\(.*\)/#if __has_include(\1)\n#include \1\n#endif/'
> + */
> +
> +#if __has_include(<algorithm>)
>  #include <algorithm>
> +#endif
> +#if __has_include(<any>)
>  #include <any>
> +#endif
> +#if __has_include(<array>)
>  #include <array>
> +#endif
> +#if __has_include(<atomic>)
>  #include <atomic>
> +#endif
> +#if __has_include(<barrier>)
>  #include <barrier>
> +#endif
> +#if __has_include(<bit>)
>  #include <bit>
> +#endif
> +#if __has_include(<bitset>)
>  #include <bitset>
> +#endif
> +#if __has_include(<cassert>)
>  #include <cassert>
> +#endif
> +#if __has_include(<cctype>)
>  #include <cctype>
> +#endif
> +#if __has_include(<cerrno>)
>  #include <cerrno>
> +#endif
> +#if __has_include(<cfenv>)
>  #include <cfenv>
> +#endif
> +#if __has_include(<cfloat>)
>  #include <cfloat>
> +#endif
> +#if __has_include(<charconv>)
>  #include <charconv>
> +#endif
> +#if __has_include(<chrono>)
>  #include <chrono>
> +#endif
> +#if __has_include(<cinttypes>)
>  #include <cinttypes>
> +#endif
> +#if __has_include(<climits>)
>  #include <climits>
> +#endif
> +#if __has_include(<clocale>)
>  #include <clocale>
> +#endif
> +#if __has_include(<cmath>)
>  #include <cmath>
> -#include <codecvt>
> +#endif
> +#if __has_include(<compare>)
>  #include <compare>
> +#endif
> +#if __has_include(<complex>)
>  #include <complex>
> +#endif
> +#if __has_include(<concepts>)
>  #include <concepts>
> +#endif
> +#if __has_include(<condition_variable>)
>  #include <condition_variable>
> +#endif
> +#if __has_include(<contracts>)
> +#include <contracts>
> +#endif
> +#if __has_include(<coroutine>)
>  #include <coroutine>
> +#endif
> +#if __has_include(<csetjmp>)
>  #include <csetjmp>
> +#endif
> +#if __has_include(<csignal>)
>  #include <csignal>
> +#endif
> +#if __has_include(<cstdarg>)
>  #include <cstdarg>
> +#endif
> +#if __has_include(<cstddef>)
>  #include <cstddef>
> +#endif
> +#if __has_include(<cstdint>)
>  #include <cstdint>
> +#endif
> +#if __has_include(<cstdio>)
>  #include <cstdio>
> +#endif
> +#if __has_include(<cstdlib>)
>  #include <cstdlib>
> +#endif
> +#if __has_include(<cstring>)
>  #include <cstring>
> +#endif
> +#if __has_include(<ctime>)
>  #include <ctime>
> +#endif
> +#if __has_include(<cuchar>)
>  #include <cuchar>
> +#endif
> +#if __has_include(<cwchar>)
>  #include <cwchar>
> +#endif
> +#if __has_include(<cwctype>)
>  #include <cwctype>
> +#endif
> +#if __has_include(<debugging>)
> +#include <debugging>
> +#endif
> +#if __has_include(<deque>)
>  #include <deque>
> +#endif
> +#if __has_include(<exception>)
>  #include <exception>
> +#endif
> +#if __has_include(<execution>)
>  #include <execution>
> +#endif
> +#if __has_include(<expected>)
> +#include <expected>
> +#endif
> +#if __has_include(<filesystem>)
>  #include <filesystem>
> +#endif
> +#if __has_include(<flat_map>)
> +#include <flat_map>
> +#endif
> +#if __has_include(<flat_set>)
> +#include <flat_set>
> +#endif
> +#if __has_include(<format>)
> +#include <format>
> +#endif
> +#if __has_include(<forward_list>)
>  #include <forward_list>
> +#endif
> +#if __has_include(<fstream>)
>  #include <fstream>
> +#endif
> +#if __has_include(<functional>)
>  #include <functional>
> +#endif
> +#if __has_include(<future>)
>  #include <future>
> +#endif
> +#if __has_include(<generator>)
> +#include <generator>
> +#endif
> +#if __has_include(<hazard_pointer>)
> +#include <hazard_pointer>
> +#endif
> +#if __has_include(<hive>)
> +#include <hive>
> +#endif
> +#if __has_include(<initializer_list>)
>  #include <initializer_list>
> +#endif
> +#if __has_include(<inplace_vector>)
> +#include <inplace_vector>
> +#endif
> +#if __has_include(<iomanip>)
>  #include <iomanip>
> +#endif
> +#if __has_include(<ios>)
>  #include <ios>
> +#endif
> +#if __has_include(<iosfwd>)
>  #include <iosfwd>
> +#endif
> +#if __has_include(<iostream>)
>  #include <iostream>
> +#endif
> +#if __has_include(<istream>)
>  #include <istream>
> +#endif
> +#if __has_include(<iterator>)
>  #include <iterator>
> +#endif
> +#if __has_include(<latch>)
>  #include <latch>
> +#endif
> +#if __has_include(<limits>)
>  #include <limits>
> +#endif
> +#if __has_include(<linalg>)
> +#include <linalg>
> +#endif
> +#if __has_include(<list>)
>  #include <list>
> +#endif
> +#if __has_include(<locale>)
>  #include <locale>
> +#endif
> +#if __has_include(<map>)
>  #include <map>
> +#endif
> +#if __has_include(<mdspan>)
> +#include <mdspan>
> +#endif
> +#if __has_include(<memory>)
>  #include <memory>
> +#endif
> +#if __has_include(<memory_resource>)
>  #include <memory_resource>
> +#endif
> +#if __has_include(<mutex>)
>  #include <mutex>
> +#endif
> +#if __has_include(<new>)
>  #include <new>
> +#endif
> +#if __has_include(<numbers>)
>  #include <numbers>
> +#endif
> +#if __has_include(<numeric>)
>  #include <numeric>
> +#endif
> +#if __has_include(<optional>)
>  #include <optional>
> +#endif
> +#if __has_include(<ostream>)
>  #include <ostream>
> +#endif
> +#if __has_include(<print>)
> +#include <print>
> +#endif
> +#if __has_include(<queue>)
>  #include <queue>
> +#endif
> +#if __has_include(<random>)
>  #include <random>
> +#endif
> +#if __has_include(<ranges>)
>  #include <ranges>
> +#endif
> +#if __has_include(<ratio>)
>  #include <ratio>
> +#endif
> +#if __has_include(<rcu>)
> +#include <rcu>
> +#endif
> +#if __has_include(<regex>)
>  #include <regex>
> +#endif
> +#if __has_include(<scoped_allocator>)
>  #include <scoped_allocator>
> +#endif
> +#if __has_include(<semaphore>)
>  #include <semaphore>
> +#endif
> +#if __has_include(<set>)
>  #include <set>
> +#endif
> +#if __has_include(<shared_mutex>)
>  #include <shared_mutex>
> +#endif
> +#if __has_include(<simd>)
> +#include <simd>
> +#endif
> +#if __has_include(<source_location>)
>  #include <source_location>
> +#endif
> +#if __has_include(<span>)
>  #include <span>
> +#endif
> +#if __has_include(<spanstream>)
> +#include <spanstream>
> +#endif
> +#if __has_include(<sstream>)
>  #include <sstream>
> +#endif
> +#if __has_include(<stack>)
>  #include <stack>
> +#endif
> +#if __has_include(<stacktrace>)
> +#include <stacktrace>
> +#endif
> +#if __has_include(<stdexcept>)
>  #include <stdexcept>
> +#endif
> +#if __has_include(<stdfloat>)
> +#include <stdfloat>
> +#endif
> +#if __has_include(<stop_token>)
>  #include <stop_token>
> +#endif
> +#if __has_include(<streambuf>)
>  #include <streambuf>
> +#endif
> +#if __has_include(<string>)
>  #include <string>
> +#endif
> +#if __has_include(<string_view>)
>  #include <string_view>
> +#endif
> +#if __has_include(<syncstream>)
>  #include <syncstream>
> +#endif
> +#if __has_include(<system_error>)
>  #include <system_error>
> +#endif
> +#if __has_include(<text_encoding>)
> +#include <text_encoding>
> +#endif
> +#if __has_include(<thread>)
>  #include <thread>
> +#endif
> +#if __has_include(<tuple>)
>  #include <tuple>
> +#endif
> +#if __has_include(<typeindex>)
>  #include <typeindex>
> +#endif
> +#if __has_include(<typeinfo>)
>  #include <typeinfo>
> +#endif
> +#if __has_include(<type_traits>)
>  #include <type_traits>
> +#endif
> +#if __has_include(<unordered_map>)
>  #include <unordered_map>
> +#endif
> +#if __has_include(<unordered_set>)
>  #include <unordered_set>
> +#endif
> +#if __has_include(<utility>)
>  #include <utility>
> +#endif
> +#if __has_include(<valarray>)
>  #include <valarray>
> +#endif
> +#if __has_include(<variant>)
>  #include <variant>
> +#endif
> +#if __has_include(<vector>)
>  #include <vector>
> +#endif
> +#if __has_include(<version>)
>  #include <version>
> +#endif
>
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>
> --
> 2.47.3
>


