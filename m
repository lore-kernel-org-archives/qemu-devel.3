Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD37C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 20:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb4hN-0007hA-GH; Fri, 16 Feb 2024 15:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rb4hL-0007gg-8T
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 15:20:39 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rb4hI-000543-Qe
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 15:20:38 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id C4C4140F1DE1;
 Fri, 16 Feb 2024 20:20:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C4C4140F1DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708114809;
 bh=NdlHK3QKBrOKG8bIgGv6bPB7b63BEMoorK+8HWg0Tfk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=H9tAhN//uhP00ZMzOVB5bvEZgadQ9iReR2U2sfXQxr1OWB+CFp5QXo/n1kFMWgSt2
 mgQ+aAylE9akyGjRLOnqCNmKygmlDMTwq5T5PBUZVR164sepe0XT66v3arn7ViLvtH
 P0brYf1mw/GDbp5hocJPoEZmEEDXv7alQ9W41HTE=
Date: Fri, 16 Feb 2024 23:20:09 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
In-Reply-To: <08ce9292-75a0-4092-a12e-9a12826847b0@linaro.org>
Message-ID: <b313b1e3-a8c7-a409-5a9f-ab9ce3853e40@ispras.ru>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
 <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
 <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
 <2d211317-873e-43c6-a246-bd8bf84f048b@linaro.org>
 <aa9996fb-a5f8-25aa-96dd-48e4797967e1@ispras.ru>
 <08ce9292-75a0-4092-a12e-9a12826847b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On Thu, 15 Feb 2024, Richard Henderson wrote:

> On 2/15/24 13:37, Alexander Monakov wrote:
> > Ah, I guess you might be running at low perf_event_paranoid setting that
> > allows unprivileged sampling of kernel events? In our submissions the
> > percentage was for perf_event_paranoid=2, i.e. relative to Qemu only,
> > excluding kernel time under syscalls.
> 
> Ok.  Eliminating kernel samples makes things easier to see.
> But I still do not see a 40% reduction in runtime.

I suspect Mikhail's image was less sparse, so the impact from inlining
was greater.

> With this, I see virtually all of the runtime in libz.so.
> Therefore I converted this to raw first, to focus on the issue.

Ah, apologies for that. I built with --disable-default-features and
did not notice my qemu-img lacked support for vmdk and treated it
as a raw image instead. I was assuming it was similar to what Mikhail
used, but obviously it's not due to the compression.

> For avoidance of doubt:
> 
> $ ls -lsh test.raw && sha256sum test.raw
>  12G -rw-r--r--  1 rth  rth   40G Feb 15 21:14 test.raw
> 3b056d839952538fed42fa898c6063646f4fda1bf7ea0180fbb5f29d21fe8e80  test.raw
> 
> Host: 11th Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz
> Compiler: gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
> 
> master:
>   57.48%  qemu-img-m  [.] buffer_zero_avx2
>    3.60%  qemu-img-m  [.] is_allocated_sectors.part.0
>    2.61%  qemu-img-m  [.] buffer_is_zero
>   63.69%  -- total
> 
> v3:
>   48.86%  qemu-img-v3  [.] is_allocated_sectors.part.0
>   3.79%  qemu-img-v3  [.] buffer_zero_avx2
>   52.65%  -- total
>     -17%  -- reduction from master
> 
> v4:
>   54.60%  qemu-img-v4  [.] buffer_is_zero_ge256
>    3.30%  qemu-img-v4  [.] buffer_zero_avx2
>    3.17%  qemu-img-v4  [.] is_allocated_sectors.part.0
>   61.07%  -- total
>      -4%  -- reduction from master
> 
> v4+:
>   46.65%  qemu-img  [.] is_allocated_sectors.part.0
>    3.49%  qemu-img  [.] buffer_zero_avx2
>    0.05%  qemu-img  [.] buffer_is_zero_ge256
>   50.19%  -- total
>     -21%  -- reduction from master

Any ideas where the -21% vs v3's -17% difference comes from?

FWIW, in situations like these I always recommend to run perf with fixed
sampling rate, i.e. 'perf record -e cycles:P -c 100000' or 'perf record -e
cycles/period=100000/P' to make sample counts between runs of different
duration directly comparable (displayed with 'perf report -n').

> The v4+ puts the 3 byte test back inline, like in your v3.
> 
> Importantly, it must be as 3 short-circuting tests, where my v4 "simplified"
> this to (s | m | e) != 0, on the assumption that the reduced number of
> branches would help.

Yes, we also noticed that when preparing our patch. We also tried mixed
variants like (s | e) != 0 || m != 0, but they did not turn out faster.

> With that settled, I guess we need to talk about how much the out-of-line
> implementation matters at all.  I'm thinking about writing a
> test/bench/bufferiszero, with all-zero buffers of various sizes and
> alignments.  With that it would be easier to talk about whether any given
> implementation is is an improvement for that final 4% not eliminated by the
> three bytes.

Yeah, initially I suggested this task to Mikhail as a practice exercise
outside of Qemu, and we had a benchmark that measures buffer_is_zero via
perf_event_open. This allows to see exactly how close the implementation
runs to the performance ceiling given by max L1 fetch rate (two loads
per cycle on x86).

Alexander

