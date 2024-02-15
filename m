Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916EFC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXYO-0003EI-JC; Thu, 15 Feb 2024 03:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1raXYL-0003E5-MV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:57:10 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1raXYJ-0005i0-M5
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:57:09 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id A562640F1DF3;
 Thu, 15 Feb 2024 08:57:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A562640F1DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707987424;
 bh=VocCQZjDRgYbFzv0Gkr/5z5r46XGNVUp80fC9jc2+Zk=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=bOsPn2V2myRMJlpcVjMYFJdu0f3JJXL5S/BXvn5lqYYClyyzDVdIIhDUeOTrT5Z/e
 XmdtKhPefhGLHRqV18j/iLZL6av6pSmmg8dySPRJ0dM0NNv61TzI//qP6QGhoQoPyJ
 NdhDxhHrf1iZipTp5H4mZji5/pYNAEKRntrY5oGM=
Date: Thu, 15 Feb 2024 11:57:04 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
Message-ID: <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
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


On Wed, 14 Feb 2024, Richard Henderson wrote:

> v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
> 
> Changes for v4:
>   - Keep separate >= 256 entry point, but only keep constant length
>     check inline.  This allows the indirect function call to be hidden
>     and optimized away when the pointer is constant.

Sorry, I don't understand this. Most of the improvement (at least in our
testing) comes from inlining the byte checks, which often fail and eliminate
call overhead entirely. Moving them out-of-line seems to lose most of the
speedup the patchset was bringing, doesn't it? Is there some concern I am
not seeing?

>   - Split out a >= 256 integer routine.
>   - Simplify acceleration selection for testing.
>   - Add function pointer typedef.
>   - Implement new aarch64 accelerations.
> 
> 
> r~
> 
> 
> Alexander Monakov (5):
>   util/bufferiszero: Remove SSE4.1 variant
>   util/bufferiszero: Remove AVX512 variant
>   util/bufferiszero: Reorganize for early test for acceleration
>   util/bufferiszero: Remove useless prefetches
>   util/bufferiszero: Optimize SSE2 and AVX2 variants
> 
> Richard Henderson (5):
>   util/bufferiszero: Improve scalar variant
>   util/bufferiszero: Introduce biz_accel_fn typedef
>   util/bufferiszero: Simplify test_buffer_is_zero_next_accel
>   util/bufferiszero: Add simd acceleration for aarch64
>   util/bufferiszero: Add sve acceleration for aarch64
> 
>  host/include/aarch64/host/cpuinfo.h |   1 +
>  include/qemu/cutils.h               |  15 +-
>  util/bufferiszero.c                 | 500 ++++++++++++++++------------
>  util/cpuinfo-aarch64.c              |   1 +
>  meson.build                         |  13 +
>  5 files changed, 323 insertions(+), 207 deletions(-)
> 
> 

