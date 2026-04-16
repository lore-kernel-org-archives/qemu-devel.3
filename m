Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BAEF43841
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDHWo-0002PS-Ru; Thu, 16 Apr 2026 03:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDHWg-0002Mi-0u; Thu, 16 Apr 2026 03:52:38 -0400
Received: from mail.avm.de ([212.42.244.120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDHWd-0002En-8M; Thu, 16 Apr 2026 03:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776325948; bh=+rQ6Mq8t9Ww7ybN73ZkZJV/J3RecsSjVW13aI7EZTJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lrx8xnsnEqRw6/yBtlo/q+VXeP7tkeXFU/e7l3D8WBaTcR79+zEnzZhrV8xAbnhGA
 2ZGKEH/rCcTVdLKAuSJKyAGNa0T5LmxVBAp/4z4wjkDE2qVUl+cxHBQ4krQCoVGmPb
 PL0LCh1hgyi6UDHimDOhBH1dpC5I4Sihwk5gcFCk=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e0953c-044c-7f0000032729-7f000001b078-1
 for <multiple-recipients>; Thu, 16 Apr 2026 09:52:28 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Thu, 16 Apr 2026 09:52:28 +0200 (CEST)
Received: from l-cspeich ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041609522884-1496 ;
 Thu, 16 Apr 2026 09:52:28 +0200 
Date: Thu, 16 Apr 2026 09:52:27 +0200
From: Christian Speich <c.speich@avm.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 4/6] hw/sd/sdhci: Don't use bounce buffer for ADMA
Message-ID: <t4mncbf2hpzecg23tmuu3rd7ha4zs7fftqyk54n7cfqltk66hw@gnnqucv72rbk>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-4-dc1cf172ee57@avm.de>
 <4e0536d5-d7a8-45f7-b2b2-bff9fe2d92cc@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4e0536d5-d7a8-45f7-b2b2-bff9fe2d92cc@linaro.org>
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 16.04.2026 09:52:28,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 16.04.2026 09:52:28, Serialize complete at 16.04.2026 09:52:28
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-purgate-ID: 149429::1776325948-71FF9960-689643FA/0/0
X-purgate-type: clean
X-purgate-size: 4910
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.120; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 14, 2026 at 03:51:24PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/2/26 14:22, Christian Speich wrote:
> > Currently, ADMA will temporarily store data into a local bounce buffer
> > when transferring it. This will produce unneeded copies of the data and
> > limit us to the bounce buffer size for each step.
> > 
> > This patch now maps the requested DMA address and passes this buffer
> > directly to sdbus_{read,write}_data. This allows to pass much larger
> > buffers down to increase the performance. sdbus_{read,write}_data is
> > already able to handle arbitrary length and alignments, so we do not
> > need to ensure this.
> > 
> > Signed-off-by: Christian Speich <c.speich@avm.de>
> > ---
> >   hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++---------------------------
> >   1 file changed, 55 insertions(+), 47 deletions(-)
> > 
> > diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> > index c86dfa281f4b0218bf6dda7a38d46abfc9638450..6e07711478cb6ca046a7d371a82e2c682ebbda00 100644
> > --- a/hw/sd/sdhci.c
> > +++ b/hw/sd/sdhci.c
> > @@ -775,7 +775,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
> >   static void sdhci_do_adma(SDHCIState *s)
> >   {
> > -    unsigned int begin, length;
> > +    unsigned int length;
> >       const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
> >       const MemTxAttrs attrs = { .memory = true };
> >       ADMADescr dscr = {};
> > @@ -817,66 +817,74 @@ static void sdhci_do_adma(SDHCIState *s)
> >               if (s->trnmod & SDHC_TRNS_READ) {
> >                   s->prnsts |= SDHC_DOING_READ;
> >                   while (length) {
> > -                    if (s->data_count == 0) {
> > -                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
> > -                    }
> > -                    begin = s->data_count;
> > -                    if ((length + begin) < block_size) {
> > -                        s->data_count = length + begin;
> > -                        length = 0;
> > -                     } else {
> > -                        s->data_count = block_size;
> > -                        length -= block_size - begin;
> > -                    }
> > -                    res = dma_memory_write(s->dma_as, dscr.addr,
> > -                                           &s->fifo_buffer[begin],
> > -                                           s->data_count - begin,
> > -                                           attrs);
> > -                    if (res != MEMTX_OK) {
> > +                    dma_addr_t dma_len = length;
> > +
> > +                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
> > +                                               DMA_DIRECTION_FROM_DEVICE,
> > +                                               attrs);
> 
> We know the descriptor is a consecutive range. Couldn't we map/unmap
> outside of the while() loop? (Ditto write path).

The loop is there to handle dma_memory_map mapping less that we've requested. I'm not
really sure if there are any guranteed cases where it always maps the requested length
fully (at least there are non in the dma_memory_map doc string).

Iff this is guranteed to always map the requested length, we could remove the whie()
loop completly.

Kind Regards,
Christian

> 
> > +
> > +                    if (buf == NULL) {
> > +                        res = MEMTX_ERROR;
> >                           break;
> > +                    } else {
> > +                        res = MEMTX_OK;
> >                       }
> > -                    dscr.addr += s->data_count - begin;
> > -                    if (s->data_count == block_size) {
> > -                        s->data_count = 0;
> > -                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> > -                            s->blkcnt--;
> > -                            if (s->blkcnt == 0) {
> > -                                break;
> > -                            }
> > +
> > +                    sdbus_read_data(&s->sdbus, buf, dma_len);
> > +                    length -= dma_len;
> > +                    dscr.addr += dma_len;
> > +
> > +                    dma_memory_unmap(s->dma_as, buf, dma_len,
> > +                                     DMA_DIRECTION_FROM_DEVICE, dma_len);
> > +
> > +                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> > +                        size_t transfered = s->data_count + dma_len;
> > +
> > +                        s->blkcnt -= transfered / block_size;
> > +                        s->data_count = transfered % block_size;
> > +
> > +                        if (s->blkcnt == 0) {
> > +                            s->data_count = 0;
> > +                            break;
> >                           }
> >                       }
> >                   }
> >               } else {
> 
> 

