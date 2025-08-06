Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706D3C87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujfpQ-0000sg-0q; Wed, 06 Aug 2025 11:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ujfe6-0006YU-QQ
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:01:41 -0400
Received: from out-171.mta1.migadu.com ([95.215.58.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ujfe3-0004yW-KD
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:01:38 -0400
Message-ID: <8468541d-4e1e-4e97-aa2f-8ce1527f03bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1754492486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sutq6erb6aq0LVVg7vPfbLdn9gwJzvPMrNUsP83pe4U=;
 b=II2ip5Dvf7KsjKN0iOafSksRBQ0P9kByeoAsisd3EFimeFb8fO5fiDOrSRfH68Rin987TL
 zE25XTnH226U+Xt4eoyRYRmaAtvKrvkFTEzlxzwL3/IhTUdWocdZL6fmmIQ4jVzRlYaHaJ
 rXs4OC/pAVepDzzNy4EdRjTQCFKvYB8=
Date: Wed, 6 Aug 2025 23:01:17 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] hw/intc/arm_gicv3_kvm: Write all 1's to clear
 enable/active
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250729161650.43758-1-zenghui.yu@linux.dev>
 <20250729161650.43758-3-zenghui.yu@linux.dev>
 <CAFEAcA_xS6fy+rWt5g_uAgG0nBwEGFts1GZfqSLF0T668WLuiw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAFEAcA_xS6fy+rWt5g_uAgG0nBwEGFts1GZfqSLF0T668WLuiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.171; envelope-from=zenghui.yu@linux.dev;
 helo=out-171.mta1.migadu.com
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

On 2025/8/1 00:59, Peter Maydell wrote:
> On Tue, 29 Jul 2025 at 17:17, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > Writing 0 to GICD_IC{ENABLE,ACTIVE}R architecturally has no effect on
> > interrupt status (all writes are simply ignored by KVM) and doesn't comply
> > with the intention of "first write to the clear-reg to clear all bits".
> >
> > Write all 1's to actually clear the enable/active status.
> >
> > Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> > ---
> >  hw/intc/arm_gicv3_kvm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> > index f798a6e28c..6166283cd1 100644
> > --- a/hw/intc/arm_gicv3_kvm.c
> > +++ b/hw/intc/arm_gicv3_kvm.c
> > @@ -295,7 +295,7 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
> >           * the 1 bits.
> >           */
> >          if (clroffset != 0) {
> > -            reg = 0;
> > +            reg = ~0;
> >              kvm_gicd_access(s, clroffset, &reg, true);
> >              clroffset += 4;
> >          }
> 
> I guess given what the kernel has implemented that this
> is the correct change, so on that basis
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> I don't understand what the kernel ABI is trying to do here,
> though...
> 
> My expectation for user access for all these registers
> where there's a "set" and a "clear" register pair would
> be that they behave the same way. But looking at the
> implementation, GICD_ICPENDR seems to be implemented
> as "reads zero, writes ignored", whereas GICD_ICACTIVER
> implements the "write-1-to-clear" semantics.
> 
> This seems to match what is documented, but I don't
> understand why we implemented and documented that:
> https://docs.kernel.org/virt/kvm/devices/arm-vgic-v3.html

I think these 2 paragraphs exactly explain the reason:

    "This is identical to the value returned by a guest read from
     ISPENDR for an edge triggered interrupt, but may differ for level

     [...]

     cannot be deduced from purely the line level and the value of the
     ISPENDR registers)."

Does it help?

Thanks,
Zenghui

