Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C6C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 21:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rajPL-0003yc-Ox; Thu, 15 Feb 2024 16:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rajPK-0003y5-Bf
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:36:38 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rajPH-0003t5-Lt
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:36:38 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 9EDB640B2786;
 Thu, 15 Feb 2024 21:36:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9EDB640B2786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708032991;
 bh=yJaFkJFpprkqJ9exL+hNei8zfitvkXBxga4iqaxOtKI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=KdmYJHcMBEriQQMY3xpVPUebQnLB83lvXeOtTOBrOBm8qYQeLohwP1X8yPqxV6369
 WXqh81ihRLfCY/POSVtACuK+nudcfsmZ68/bVXWWuhjdEhygqte4PX5FPExJ45WQOE
 Lw661Bs1A9/bLQjQCwZALw6iWpkqdVDwI1wBiyKo=
Date: Fri, 16 Feb 2024 00:36:31 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
In-Reply-To: <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
Message-ID: <fa83e6cb-7270-0bf0-99f4-68d21dbdaa1c@ispras.ru>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
 <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
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

> On 2/14/24 22:57, Alexander Monakov wrote:
> > 
> > On Wed, 14 Feb 2024, Richard Henderson wrote:
> > 
> >> v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
> >>
> >> Changes for v4:
> >>    - Keep separate >= 256 entry point, but only keep constant length
> >>      check inline.  This allows the indirect function call to be hidden
> >>      and optimized away when the pointer is constant.
> > 
> > Sorry, I don't understand this. Most of the improvement (at least in our
> > testing) comes from inlining the byte checks, which often fail and eliminate
> > call overhead entirely. Moving them out-of-line seems to lose most of the
> > speedup the patchset was bringing, doesn't it? Is there some concern I am
> > not seeing?
> 
> What is your benchmarking method?

Converting a 4.4 GiB Windows 10 image to qcow2. It was mentioned in v1 and v2,
are you saying they did not reach your inbox?
https://lore.kernel.org/qemu-devel/20231013155856.21475-1-mmromanov@ispras.ru/
https://lore.kernel.org/qemu-devel/20231027143704.7060-1-mmromanov@ispras.ru/

> It was my guess that most of the improvement came from performing those early
> byte checks *at all*, and that the overhead of a function call to a small out
> of line wrapper would be negligible.

qemu-img invokes buffer_is_zero in a fairly tight loop. Let us know if you
need numbers how much the out-of-line version loses.

> By not exposing the function pointer outside the bufferiszero translation
> unit, the compiler can see when the pointer is never modified for a given
> host, and then transform the indirect branch to a direct branch.

Okay, but that does not make it necessary to move byte checks out of line.
I was preparing a rebase that does not expose the function pointer to the
inline wrapper. I was completely unaware that you're taking over the patchset.

Alexander

