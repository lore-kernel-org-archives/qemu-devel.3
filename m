Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3445C1077612
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 20:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2xGx-0005Ma-7r; Wed, 18 Mar 2026 16:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2xGu-0005LD-Nv; Wed, 18 Mar 2026 16:13:40 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2xGs-0004b2-1P; Wed, 18 Mar 2026 16:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 32F595969F3;
 Wed, 18 Mar 2026 21:13:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id RT-ecY6mw7Xy; Wed, 18 Mar 2026 21:13:31 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B24D65969E4; Wed, 18 Mar 2026 21:13:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B0B5B5966F4;
 Wed, 18 Mar 2026 21:13:31 +0100 (CET)
Date: Wed, 18 Mar 2026 21:13:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pedro Falcato <pfalcato@suse.de>
cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] ide: Set IDENTIFY word 93 to 0 on SATA drives
In-Reply-To: <20260318162951.1060969-1-pfalcato@suse.de>
Message-ID: <3c35a0f5-1b52-5f1f-fb75-c7d6ec105667@eik.bme.hu>
References: <20260318162951.1060969-1-pfalcato@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 18 Mar 2026, Pedro Falcato wrote:
> According to the ATA Command Set specification (and the SATA specification
> too), SATA drives are supposed to set word 93 (which for PATA holds hardware
> reset results) to 0. As such, clear it when ncq_queues > 0 (which is only true
> for SATA drives).

AHCI is not the only SATA controller emulated but the only one setting 
ncq_queues so that's not a good way to identify SATA in general. Maybe 
there should be something else that SATA controllers could set which you 
test for here but I don't know what would be the best way for that. It 
seems a drive is SATA if it's connected to a SATA controller so maybe the 
bus should have a field set to say it's a SATA bus?

As for ABI and behaviour change, usually if you change something that 
would make a Windows guest detect new hardware then that should be 
introduced with new machine version with compatibity kept for older 
machine versions. I don't know if that applies to replacing IDE drives 
with SATA drives but seems likely.

Regards,
BALATON Zoltan

> Doing so fixes a quirk in Linux where it thinks the AHCI QEMU drive is PATA
> over a SATA bridge, and thus limits maximum transfer sizes for individual IOs
> with a:
> [    1.632121] ata1.00: applying bridge limits
>
> While at it, bump the device's firmware revision for IDENTIFY. This makes it
> so Linux can avoid enabling a quirk for fixed QEMU releases.
>
> Link: https://lore.kernel.org/linux-ide/20260303183337.1013474-1-pfalcato@suse.de/
> Cc: qemu-stable@nongnu.org
> Suggsted-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> Note: I understand the version bump is vaguely controversial (particularly
> exposing the QEMU version in the string) but I don't have a much better
> idea. Logically, bumping it to 11.0 for stable releases doesn't make much
> sense.
>
> hw/ide/core.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index b45abf067b20..89f62f301e94 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -211,7 +211,15 @@ static void ide_identify(IDEState *s)
>         put_le16(p + 87, (1 << 14) | 0);
>     }
>     put_le16(p + 88, 0x3f | (1 << 13)); /* udma5 set and supported */
> -    put_le16(p + 93, 1 | (1 << 14) | 0x2000);
> +    if (s->ncq_queues) {
> +        /*
> +         * This is SATA, which is required by the spec to return 0 for this
> +         * field.
> +         */
> +        put_le16(p + 93, 0);
> +    } else {
> +        put_le16(p + 93, 1 | (1 << 14) | 0x2000);
> +    }
>     /* *(p + 100) := nb_sectors       -- see ide_identify_size */
>     /* *(p + 101) := nb_sectors >> 16 -- see ide_identify_size */
>     /* *(p + 102) := nb_sectors >> 32 -- see ide_identify_size */
> @@ -2660,7 +2668,7 @@ int ide_init_drive(IDEState *s, IDEDevice *dev, IDEDriveKind kind, Error **errp)
>     if (dev->version) {
>         pstrcpy(s->version, sizeof(s->version), dev->version);
>     } else {
> -        pstrcpy(s->version, sizeof(s->version), qemu_hw_version());
> +        pstrcpy(s->version, sizeof(s->version), "11.0");
>     }
>
>     ide_reset(s);
>

