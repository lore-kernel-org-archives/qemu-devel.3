Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F31410F2865
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 22:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6FZF-0003CE-O5; Fri, 27 Mar 2026 18:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w6FZ9-0003Bu-PF; Fri, 27 Mar 2026 18:22:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w6FZ7-0007c1-Vk; Fri, 27 Mar 2026 18:22:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D46B596A1D;
 Fri, 27 Mar 2026 23:22:00 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 9gnkhO3JE5zl; Fri, 27 Mar 2026 23:21:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D9EC9596A2A; Fri, 27 Mar 2026 23:21:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D84FD5969F6;
 Fri, 27 Mar 2026 23:21:57 +0100 (CET)
Date: Fri, 27 Mar 2026 23:21:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH 02/16] lsi53c895a: do not do anything else is a reset is
 requested by writing ISTAT0
In-Reply-To: <20260327212547.460420-3-pbonzini@redhat.com>
Message-ID: <44d61914-365d-b93b-1ede-f1684461e5dc@eik.bme.hu>
References: <20260327212547.460420-1-pbonzini@redhat.com>
 <20260327212547.460420-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 27 Mar 2026, Paolo Bonzini wrote:
> If the device is reset, anything that is done before will not really
> be visible.  So do the reset and exit immediately if that is one
> if the requests in the value written to ISTAT0.

Typo in above line: if -> of and in subject is -> if

Regards,
BALATON Zoltan

> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/scsi/lsi53c895a.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 90643b26ab8..81b4f93f4d3 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1949,6 +1949,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
>     CASE_SET_REG32(dsa, 0x10)
>     case 0x14: /* ISTAT0 */
>         s->istat0 = (s->istat0 & 0x0f) | (val & 0xf0);
> +        if (val & LSI_ISTAT0_SRST) {
> +            device_cold_reset(DEVICE(s));
> +            return;
> +        }
>         if (val & LSI_ISTAT0_ABRT) {
>             lsi_script_dma_interrupt(s, LSI_DSTAT_ABRT);
>         }
> @@ -1962,9 +1966,6 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
>             s->dsp = s->dnad;
>             lsi_execute_script(s);
>         }
> -        if (val & LSI_ISTAT0_SRST) {
> -            device_cold_reset(DEVICE(s));
> -        }
>         break;
>     case 0x16: /* MBOX0 */
>         s->mbox0 = val;
>

