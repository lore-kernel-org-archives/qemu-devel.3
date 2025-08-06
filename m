Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8222FC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujfkr-0000rW-LQ; Wed, 06 Aug 2025 11:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ujfY0-0004TL-Ln
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 10:55:24 -0400
Received: from out-180.mta0.migadu.com ([91.218.175.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ujfXy-000402-8m
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 10:55:20 -0400
Message-ID: <9806e26b-e4cc-4617-868a-0e09101a802b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1754492113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQWbFnekPI7AraPk2x4esrQAS3a7zlopreYltkTn5wo=;
 b=fihXbn4jrrR1mlF7pyW2AD40VFQNapxyPjiABbruWs0r1ehOrlBtYjH2BCn6dMhPL3NWLF
 RPrjgZ1SrsGtwjj7UciTmwRRE1IS5WxaS5Ddbmue8qwyBDpXHRsSAWHuyOaPvAEmJ2eZUV
 FSiTo7jNTnL6wOVkNUws/ofJ9lmmuz0=
Date: Wed, 6 Aug 2025 22:55:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] hw/intc/arm_gicv3_kvm: two small fixes about register
 accesses
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250729161650.43758-1-zenghui.yu@linux.dev>
 <CAFEAcA-dRAViFBSvmYS+FSMKPhP_ej5Sv90n6+WLaR=jeQeiAg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAFEAcA-dRAViFBSvmYS+FSMKPhP_ej5Sv90n6+WLaR=jeQeiAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.180; envelope-from=zenghui.yu@linux.dev;
 helo=out-180.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/8/1 01:11, Peter Maydell wrote:
> On Tue, 29 Jul 2025 at 17:17, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > Zenghui Yu (2):
> >   hw/intc/arm_gicv3_kvm: Remove writes to ICPENDR registers
> >   hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
> >
> >  hw/intc/arm_gicv3_kvm.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Did this cause any visible bugs, or did you just notice it
> by code inspection ?

They're noticed by code inspection. I agree with that patch #2 is
guest-visible only when doing a system reset.

> 
> Applied to target-arm.next, thanks.

Thanks!

Zenghui

