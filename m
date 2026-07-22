Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5157EC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmZap-0005yh-Jq; Wed, 22 Jul 2026 12:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wmZan-0005yT-7K; Wed, 22 Jul 2026 12:14:45 -0400
Received: from smtp6-g21.free.fr ([2a01:e0c:1:1599::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wmZak-0002aJ-P1; Wed, 22 Jul 2026 12:14:44 -0400
Received: from [192.168.25.24] (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id C0BB1780368;
 Wed, 22 Jul 2026 18:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1784736876;
 bh=M4fYMY3codWalAEjEaj9FT5BSDKYvDCRwS3kiqcWIR8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kI0BX+VPIhDIbOrY7m2rIT+c5BvHv0CkAiH/dPssplM+BADCqt+DQo+ca0ZkwhmnK
 yd1Yon9yzLRtL5jF9UdNI1DKMprN4up0UtBBh8BZke6GDOEp5FONetlmVFCyutl+WW
 Yz4STp8/PjBACq/41qO/KkzVcOEi0rGE6/PKDxScFUN3Uva9TKbEcDAB+k3cRImnZm
 p6x+ijl/eoPNpT1DcGTBXd6HmyeAVvO98AyJe6pyq3vzn+pgIo4kAPxNI6kSBSNdPD
 JHZK/mmM2YObIykE1cCKa4s6JSBT3/Q+LEEkkvN6yOcmy8L6vo+anlcVP5igO7v1ta
 j/OSE5bADgdLA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: Alistair Francis <alistair23@gmail.com>
Cc: alistair@alistair23.me, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] hw/block/m25p80: Perform a size check before erase
Date: Wed, 22 Jul 2026 18:14:27 +0200
X-Mailer: MailMate (2.0r6290)
Message-ID: <B93701B0-043C-4385-A7A1-2B80796E436E@free.fr>
In-Reply-To: <20260722151503.491139-1-alistair.francis@wdc.com>
References: <20260722151503.491139-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:e0c:1:1599::15;
 envelope-from=emmanuel.blot@free.fr; helo=smtp6-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi,

I=E2=80=99m not sure the proposed fix fully matches the actual flash beha=
vior.

Many SPI flash devices accept any address within the sector address range=
 to define the actual sector to erase.
It think the offset should first be masked to the sector size, then only =
this new test may be be applied.

Excerpt from M25P32 datasheet (section 6.9):

> The Sector Erase (SE) instruction is entered by driving Chip Select (S)=
 Low, followed by the
> instruction code, and three address bytes on Serial Data Input (D). Any=
 address inside the
> Sector (see Table 3) is a valid address for the Sector Erase (SE) instr=
uction.

It seems it is already implemented for DIE_ERASE, but not SECTOR_ERASE va=
riants for some reason.

   offset &=3D ~(len - 1);

Otherwise, last sector could not be erased if a non-zero sector-relative =
address is specified.

Emmanuel.

On 22 Jul 2026, at 17:15, Alistair Francis wrote:

> It seems like the erase operation can write off the end of the storage,=

> so let's add a size guard to make sure we don't do that.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4049
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/block/m25p80.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 545e0b5728..54eb12ebbe 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -648,6 +648,13 @@ static void flash_erase(Flash *s, int offset, Flas=
hCMD cmd)
>          qemu_log_mask(LOG_GUEST_ERROR, "M25P80: erase with write prote=
ct!\n");
>          return;
>      }
> +
> +    if (offset + len >=3D s->size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "M25P80: erase operation overflowing storage siz=
e!\n");
> +        return;
> +    }
> +
>      memset(s->storage + offset, 0xff, len);
>      flash_sync_area(s, offset, len);
>  }
> -- =

> 2.55.0

