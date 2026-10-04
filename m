Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E94FCA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 03:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDD5q-0003HG-MJ; Sat, 03 Oct 2026 23:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDD5o-0003Ga-CO
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 23:40:52 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDD5m-0005NQ-97
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 23:40:52 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ace0741488so5626387b3.3
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 20:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791085249; cv=none;
 d=google.com; s=arc-20260327;
 b=rhPRDmQzbsRql5yrLvwqBl1c2FCUJjpUk1z+2sUMpuddvqqoV4WwDXOQuYkHRhbErn
 osX1tyYZ35xzy7xwFEoW9N4fYY4FxODEd72jxeWgJW3GlXJpAacs1zAzN8AmqYBHJCrn
 x3vOWYFBuElBYnP7KgGV9gpINvxyZ124bP8+lo+3FMvc23T0Dy9iVTi3V7lpP+nlOE1M
 xYTzVoC7atq7LHLPK1q174dvfYPC5BHka21CtWivfeGcedP/WyX6wCW0Dm9TDeE5bRXd
 I4ElltINFS4138xJ7YdhW31vnK5JXmXIg/Xu7FBsHZvS1Lhhq69CvPr8DArAy1MIlZem
 wnWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Uid2z7vz20leNRCMWHfPz+Dth+6UA7CO4Qzfqwwmclg=;
 fh=Ityztm/cSssfBACIWW25UJ+vWCLjNR/EIOYsBMoOeP0=;
 b=f3HMUd+ZCeUN6V1h7RoBh60fkEvzElwkyIkFn/Bc3tWZ0M8GtYPn/qTGnQE7aJYG+1
 pJ/hruv9tI53/yV9E52xqAbw1ywNfFrZjSI+7MMBAGZxAgas6sJZZopj8aBtFA7js/+v
 MaYCj0VN1N2Y7xPyUeyu1KoKatgHlwuL4OqPMxZ+mwPvulczqdKQL/D3UjVUS3MRzM+j
 gLDNy4/IHVT4YngxV6cJ25V1Uzja9CQkozFdu/JWRdX6cWUhTHVaYLuljfOusLJsFVmr
 03ZshEMqYSIhZH6wIqmqwLHM5kUlc1pD0Z8vTITiZLkl/DDo/Dy8ulmZJt7KMayn1FVt
 SxhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791085249; x=1791690049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uid2z7vz20leNRCMWHfPz+Dth+6UA7CO4Qzfqwwmclg=;
 b=JUPT8kOzWYhvDNJwt6N6aVZRoixcTWofPd8JjO+hzc908qDXrtKsCLRi33z3156rfi
 SOgcjDCSPSADFOk5BQsdNb2mztMFeh1DslZ31ajAbq9fm/OskwUOzuL1oI3NawlJf8S/
 RQ+K9eUhMlNXY6mc6QNDueiVK4uO5G8A0ERteSbbQmVvQWwEpfF4ubaWTzuE5VXxu2Uc
 ISt22NNpzxlIriQXpE9mhr54wHIm/OmAwtDEruEam6LArk3cLR6M1Krsdj0FwcIyFWrJ
 Bio+h3IsCn0qnxJ8wk+kZq1faAYAIEJIH3jHQLYVEIoph0W953bZMQwJWfmaFXARSj26
 y9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791085249; x=1791690049;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uid2z7vz20leNRCMWHfPz+Dth+6UA7CO4Qzfqwwmclg=;
 b=ImMsZkuOlfSaHukMal427f0PqA/5S9z9i4649mq0UyDsySyFCdYxCTemQG1wEAegsz
 amO7/ow9oVBFVNzYB2XE6u6TlReSzSieC82lWFgvrFdLcZsAkDDHV83JlUsSIO0IZObz
 B66UfgjDLee9o6GJ7zCgmCtr5SYCvRa6w/Mt53aOoSylKGTcjb2uEHT9AktTNv+aKcGJ
 a0trehYz6Jr+57UN4S12pG+j1KbV/ZmsWzNkljxD1ByJYgosl8fQFTybFdNTtVrcYDCp
 7PkRQ0allqO1iRt5Pb504dLgQVwj8EI84DYW0728EGnIeZcs3fFfwc43kexgw1kXJBiW
 wMAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHT1rlbiQectw+W7loLeYq12QLdYXc9CbmR6XBRH6yjLSo8GUBn/XcPrAn3aLk2uCPMEQI/O4KMLl+@nongnu.org
X-Gm-Message-State: AFq9FYIq6TKtsU2Gdod48qN3tyntf6Bh77+qExY1NNiFh+Dzy5sxoQ+w
 pIxcFx/3metZRMBqsO39bVSKpmmz51ILmRFlZEnUzkEkiQPBneMG9Pak5Ysvbn5oeel6jPI3Oj0
 aMBZprujLbJZwprbxV2dcnNdUwcHbM08=
X-Gm-Gg: AYBFou3urHD0M6v9IdCdUwq5LlIacr3eVve4AlCimvfu2dLn0gB7ql3ZPLuApGWdMKo
 1mmWJReXYRKFUI6724LKivMUBt6NJ6Ihpi0xC4mbvH91j6sN61w7LHE6ErjpmNHxD2w8qzYNhFM
 4lBRqVYKHdDVdNPxZT+C08pTMvsMGayj9o6p/ziAkSPsOghAy8AckNuc03MGpyPKX4+rBrBV2ty
 iRa0efby3acQBIQZlxS3+usLo0P1qd3bv8CCbKsv3QGTka3ibrrX/Di6BVebRyn+X2C2aigu60k
 JDcKHVGxTNuweopU9HdHAXVJPMiyEh0bHL6SftqpcDmxB9ygMrABfldPp3OWeYdtt63mq0zXlYC
 ONLLQeym68brGLwUzO2PHgWUPQg==
X-Received: by 2002:a05:690c:a610:b0:8a2:496:1985 with SMTP id
 00721157ae682-8ae958d73d3mr12153977b3.54.1791085248833; Sat, 03 Oct 2026
 20:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260904161438.3838261-1-bin.meng@processmission.com>
 <20260904161438.3838261-9-bin.meng@processmission.com>
 <6F7614BD-BB6D-4F68-B9EA-F762F54B1FB5@gmail.com>
In-Reply-To: <6F7614BD-BB6D-4F68-B9EA-F762F54B1FB5@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 11:40:35 +0800
X-Gm-Features: AclHuK_4wGVy8sLjVZoBpLsRdxVI20dwy-BwNo419dY0Ht-746thzklP5IBPirk
Message-ID: <CAEUhbmUDuH-bf4m8zFuXEhj+rJNXS40QYhDR-WXzjwQpQpXS_w@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] hw/sd: sdhci: Skip SDMA boundary stops for i.MX
 uSDHC
To: Bernhard Beschow <shentey@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, Sep 19, 2026 at 10:32=E2=80=AFPM Bernhard Beschow <shentey@gmail.co=
m> wrote:
>
>
>
> Am 4. September 2026 16:14:31 UTC schrieb Bin Meng <bin.meng@processmissi=
on.com>:
> >The standard SDHCI Block Size register encodes an SDMA buffer boundary
> >in bits 14:12. The generic model stops at each selected boundary, sets
> >the DMA status, and waits for software to rewrite the SDMA system
> >address before continuing.
> >
> >Freescale eSDHC and i.MX uSDHC instead expose BLKATTR without a
> >programmable standard boundary field. On both controller families,
> >bits 14:13 are reserved and bit 12 is the high bit of the 13-bit
> >block-size field. Linux masks the standard boundary encoding before
> >writing BLKATTR.
> >
> >Despite its name, esdhc_write() is the shared register translation
> >helper. usdhc_write() delegates common register accesses to it. The
> >existing translation inserts 0x7 into the generic boundary field so
> >the common core sees a 512 KiB boundary.
> >
> >For i.MX6UL uSDHC, BLK_ATT bits 15:13 are reserved and bit 12 is
> >part of its 13-bit block size. DINT reports successful completion of
> >the whole internal DMA transfer, not an intermediate boundary pause.
> >
> >U-Boot programs one contiguous DMA address and a block count, then
> >waits for both DINT and transfer-complete. It never rewrites the address
> >at an intermediate boundary. Reads larger than 512 KiB therefore reach
> >the synthetic boundary and stall with blocks remaining.
> >
> >The missing field alone does not establish whether every older eSDHC
> >has a fixed internal boundary handshake. Limit the new quirk to only
> >TYPE_IMX_USDHC, where the reference manual, U-Boot behavior, and the
> >observed failure agree. Existing FSL eSDHC and standard SDHCI behavior
> >remain unchanged.
> >
> >Reference: IMX6ULRM (Rev. 2), section 56.8.2 and 56.8.13
> >https://www.nxp.com/webapp/Download?colCode=3DIMX6ULRM
> >
> >Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >---
> >
> >(no changes since v1)
> >
> > include/hw/sd/sdhci.h |  5 +++++
> > hw/sd/sdhci.c         | 37 ++++++++++++++++++++++++-------------
> > 2 files changed, 29 insertions(+), 13 deletions(-)
> >
> >diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> >index 83d465774b..6664822398 100644
> >--- a/include/hw/sd/sdhci.h
> >+++ b/include/hw/sd/sdhci.h
> >@@ -118,6 +118,11 @@ typedef struct SDHCIState SDHCIState;
> >  * SDHCI clock-control fields
> >  */
> > #define SDHCI_QUIRK_CLOCKS_IN_VENDOR     BIT(1)
> >+/*
> >+ * Controller completes contiguous SDMA transfers without the standard
> >+ * intermediate buffer-boundary stop and address-update handshake
> >+ */
> >+#define SDHCI_QUIRK_NO_SDMA_BOUNDARY     BIT(2)
> >
> > #define TYPE_PCI_SDHCI "sdhci-pci"
> > DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
> >diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> >index 4d7bbdbe7a..de0883497b 100644
> >--- a/hw/sd/sdhci.c
> >+++ b/hw/sd/sdhci.c
> >@@ -687,12 +687,14 @@ static void sdhci_advance_sdma_address(SDHCIState =
*s, uint32_t bytes)
> > /* Multi block SDMA transfer */
> > static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
> > {
> >+    bool boundary_enabled =3D
> >+        !(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY);
> >     bool page_aligned =3D false;
> >     unsigned int begin;
> >     const uint16_t block_size =3D s->blksize & BLOCK_SIZE_MASK;
> >-    uint32_t boundary_chk =3D 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >>=
 12) + 12);
> >+    uint32_t boundary_chk =3D 0;
> >     uint64_t sdma_address =3D sdhci_sdma_address(s);
> >-    uint32_t boundary_count =3D boundary_chk - (sdma_address % boundary=
_chk);
> >+    uint32_t boundary_count =3D 0;
> >
> >     if (!(s->trnmod & SDHC_TRNS_BLK_CNT_EN) || !s->blkcnt) {
> >         qemu_log_mask(LOG_UNIMP, "infinite transfer is not supported\n"=
);
> >@@ -704,8 +706,11 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
> >      * possible stop at page boundary if initial address is not page al=
igned,
> >      * allow them to work properly
> >      */
> >-    if ((sdma_address % boundary_chk) =3D=3D 0) {
> >-        page_aligned =3D true;
> >+    if (boundary_enabled) {
> >+        boundary_chk =3D
> >+            1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
> >+        boundary_count =3D boundary_chk - (sdma_address % boundary_chk)=
;
> >+        page_aligned =3D (sdma_address % boundary_chk) =3D=3D 0;
> >     }
> >
> >     s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
> >@@ -721,7 +726,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISt=
ate *s)
> >                 boundary_count =3D 0;
> >              } else {
> >                 s->data_count =3D block_size;
> >-                boundary_count -=3D block_size - begin;
> >+                if (boundary_enabled) {
> >+                    boundary_count -=3D block_size - begin;
> >+                }
> >                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
> >                     s->blkcnt--;
> >                 }
> >@@ -746,7 +753,9 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISt=
ate *s)
> >                 boundary_count =3D 0;
> >              } else {
> >                 s->data_count =3D block_size;
> >-                boundary_count -=3D block_size - begin;
> >+                if (boundary_enabled) {
> >+                    boundary_count -=3D block_size - begin;
> >+                }
> >             }
> >             dma_memory_read(s->dma_as, sdhci_sdma_address(s),
> >                             &s->fifo_buffer[begin],
> >@@ -2015,13 +2024,14 @@ esdhc_write(void *opaque, hwaddr offset, uint64_=
t val, unsigned size)
> >
> >     case SDHC_BLKSIZE:
> >         /*
> >-         * ESDHCI does not implement "Host SDMA Buffer Boundary", and
> >-         * Linux driver will try to zero this field out which will
> >-         * break the rest of SDHCI emulation.
> >+         * Freescale eSDHC and i.MX uSDHC use BLKATTR without the stand=
ard
> >+         * Host SDMA Buffer Boundary field. uSDHC accesses reach this s=
hared
> >+         * register translation through usdhc_write().
> >          *
> >-         * Linux defaults to maximum possible setting (512K boundary)
> >-         * and it seems to be the only option that i.MX IP implements,
> >-         * so we artificially set it to that value.
> >+         * Keep the largest boundary in the generic representation to
> >+         * preserve existing eSDHC behavior. TYPE_IMX_USDHC separately
> >+         * disables the associated stop semantics because its DINT repo=
rts
> >+         * completion of the entire transfer rather than a boundary eve=
nt.
> >          */
> >         val |=3D 0x7 << 12;
> >         /* FALLTHROUGH */
> >@@ -2168,7 +2178,8 @@ static void imx_usdhc_init(Object *obj)
> >
> >     s->io_ops =3D &usdhc_mmio_ops;
> >     s->quirks =3D SDHCI_QUIRK_NO_BUSY_IRQ |
> >-                SDHCI_QUIRK_CLOCKS_IN_VENDOR;
> >+                SDHCI_QUIRK_CLOCKS_IN_VENDOR |
> >+                SDHCI_QUIRK_NO_SDMA_BOUNDARY;
>
> Given the above comments please also add the quirk to both ESDHC variants=
. Thanks!

Will extend the quirk to eSDHC variants in v3.

>
> With the above fixed:
>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
>

Regards,
Bin

