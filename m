Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1DC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfH0s-00045w-To; Thu, 02 Jul 2026 08:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wfH0p-00045i-6q; Thu, 02 Jul 2026 08:59:28 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wfH0j-0001qp-6L; Thu, 02 Jul 2026 08:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=qvnNP8W
 ggEOAymlGd1sU7d9eLRlapZMKi+/1uDalnDw1ABhDIp8cann9IJQVI1NvwGE1uyXezXLOB
 XaLlbJTVScEKHc5aV4K1AIozKy4X0xCvWkv13QU35dwTj+g2PDdvvIqBBBudNc+uSw5rPL
 53HrBjsyOaOZTymlulK8CX+b7CIdJUm7APYQRQ8mHkBUyCxTHcesndVrDgGNZ57XwXC+jR
 F3y0zZJf+4fyEisN3DfbkNzi/S+OroOCYkz1w32okMbEGFzBQTfJbaPIWGsET5WIP5s85A
 lkh2DhjpEiyPd84xo/10gnxIUONvvBj0o1bjfKGZrZBjt4Oe4QqOdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=G
 5+/Il8je94hK8S3rj/kKrjhxH3B2v/6rxZ7JZetQhI=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=FWGb2NlIvZ+02O0bJduvuOB5l170X47g7NgO9HGuroREo7S6V5qIT1h4td/CI4mEZ6RB
 FZrZshKuD94LJpRDMUTemzU144+Mk87lEzZplhkoNokDJm2pZ5urU/LMqgl9V/FyjSYt/l
 8x/4ts2C0YpwxFh7js9zJyPa2wo+s+3geoMtuqP+2yS7OK1afeOjUhffZZ1u5RxKQC3Og5
 BObssQ7bO5DqehJz6YT5COc1nSeQuP5nNaJTQk4bATmYDGTbf16/qMik902xoRNFkq89Kt
 tHEqMLOf0BpNZa24OrgypNhW9spE48WH69J7ySBgh8ggo1l1fUPHIUm1kPdo3O6A==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=hKK9cZyp; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=Gbi/Pbh8;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=G5+/Il8j
 e94hK8S3rj/kKrjhxH3B2v/6rxZ7JZetQhI=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=hKK9cZypMbauaBWX1Lgmi6f3G/5l2p
 qxE/nRejnGgmrg/ghc6oumWFDJlDaGyAOq/DnoZPYZXfAMLL4G3uhLb+xp1jWTCTMM3db0
 vNrmXYL/opT7R23YouyHyxNWNK86nY4Fh0IDgVCztrBQlAMrzDgFf75z/TjZcGsjyBuPWj
 xFZEqDOyHdxjcOik7Mj52eUHSw0unK0Kbhjpc1rbwXoPkVxZ4Ai71CpnKRkHm4RZlaMKrT
 MmxhICaxluMB4iSkTxOHFYWgQF6PHiGkIfBuTEkGMYlRbTM+wPRbnTYpxlYBFh/G34OnvJ
 Hh+1t862w6sKtI0L5M69y7tNXL0/PHHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=G5+/Il8je94hK8S3rj/kKrjhxH3B2v/6rxZ7JZetQhI=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=Gbi/Pbh806Glx7MmJW
 ibadRn/NfUtnZqrWuFVkVaoiS0rETZ+vPwL4axQaRYIu8ShXcpr3oU+6i+ur+ShF2UCw==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b6515f46
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 2 Jul 2026 14:59:10 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id d717826e;
 Thu, 2 Jul 2026 14:59:08 +0200 (CEST)
Date: Thu, 02 Jul 2026 14:59:08 +0200
Message-ID: <87a4s9mtsz.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] powernv: boot OpenBSD on POWER9
In-Reply-To: <ajw1PJpTXiyJzcPZ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260616223148.38348-2-kirill@korins.ky>
 <ajw1PJpTXiyJzcPZ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
User-Agent: Wanderlust
Mail-Followup-To: adityag@linux.ibm.com, qemu-devel@nongnu.org,
 rathc@linux.ibm.com, harshpb@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, brad@comstyle.com,
 qemu-ppc@nongnu.org, "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On Wed, 24 Jun 2026 21:59:09 +0200,
Aditya Gupta <adityag@linux.ibm.com> wrote:
> 
> > 
> > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > @@ -817,18 +819,15 @@ static const MemoryRegionOps pnv_psi_p9_xscom_ops = {
> >  static void pnv_psi_power9_set_irq(void *opaque, int irq, int state)
> >  {
> >      PnvPsi *psi = opaque;
> > -    uint64_t irq_method = psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL)];
> > +    uint64_t irq_bit = PPC_BIT(irq);
> >  
> > -    if (irq_method & PSIHB9_IRQ_METHOD) {
> > -        qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported\n");
> > -        return;
> > -    }
> 
> is it required to remove this check ? afais, irq_method isn't having
> this bit set by openbsd too.
> 

It was very long try and fail process and it was a left over which is not
requried.

Thanks for catch it.

> > <...snip...>
> >      /* Calculate number of entries */
> > -    pats = 1ull << (pats + 12 - 4);
> > -    if (pats <= lpid) {
> > +    entries = table_size / sizeof(*entry);
> 
> nit: previously sizeof(*entry) == 1<<4 = 16 bytes. just to be extra
> cautious, should we have __packed in ppc_v3_pate_t, can compilers
> increase the size of the struct any arch ? i can't think of one just
> being extra cautious
>

Addressed, will send v3 shortly.

> > +
> > +bool ppc64_v3_get_pate(PowerPCCPU *cpu, target_ulong lpid, ppc_v3_pate_t *entry)
> > +{
> > +    uint64_t pats = cpu->env.spr[SPR_PTCR] & PTCR_PATS;
> > +
> > +    /*
> > +     * Keep the existing ISA v3.0 PATS interpretation first.  OpenBSD/powernv
> > +     * uses the PATSIZE value it writes to PTCR as one exponent smaller, and it
> > +     * only needs that interpretation for the bare metal LPID 0 table.
> > +     */
> > +    if (ppc64_v3_get_pate_from_size(cpu, lpid, entry, 1ull << (pats + 12))) {
> > +        return true;
> > +    }
> > +
> > +    if (lpid == 0) {
> > +        return ppc64_v3_get_pate_from_size(cpu, lpid, entry,
> > +                                           1ull << (pats + 11));
> 
> any reason openbsd needs to populate ptcr this way ?
> 

Added explanation to comment, I think it is the better place whan maillist.

-- 
wbr, Kirill

