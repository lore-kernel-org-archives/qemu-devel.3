Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95163CA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 11:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDKBE-0007Ww-Ca; Sun, 04 Oct 2026 07:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDKBC-0007W7-C1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:14:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDKB9-0007il-Ty
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 07:14:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so738128f8f.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791112489; x=1791717289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1VpyR0BGQCfSJVULm37WgDj1mYqGMQK4V5BWxw2Aers=;
 b=i4ucUd6tBjAXMvKJ9PLIg2X+4Tbza8MDGA6F9UkHRFk5tFESWGtFptc6AdEJrmRak3
 J7MEVcuMo07DenT2Rrz1lWKZ11gb94XgYE92KA8A/lQlEQ3dkoMDN3BxjEJYLLnksOx7
 F+Qq5CvSuD9N4GSP3p8489ghZdpobyb71qDo3TcmHXBv7/WWo0eR/bTlvkj/b961SYru
 TqAJBj8MiCG+lj9FhSQ/W3aO4PMzLMe0etWZRAX3jaY7y6sNCErAfrqxf/BIhy1r8u3p
 CTLePUfirMLN944fVwI7Lub8rgIBzsQ7nH/WC5uAQpzhs5OeMWApryNSgMlL25OpDRTN
 WOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791112489; x=1791717289;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VpyR0BGQCfSJVULm37WgDj1mYqGMQK4V5BWxw2Aers=;
 b=13cnqxcV4avhYmRiPLVSK4eCDsNMcVHjFmXriTN8rSqQUSNE7WH4er2JApthYHQ/To
 viwyxceSPqCaNEZhmyBTUw6suuAu9h4QmPHI1Tq660ZAxge9yrF+aHXk0hqPfHivU71x
 ufh0+wKXHpBpNnNK2bcJ2pHXTgm4zf/B4pBQ8oriXhB6JZJu26vc/l+au/uCV5UkpYs+
 vvAQcaMJw+vsuABlgCehLODcIHE6ZNmazwTjlD2ttI0WwcaRFWclJ7De5tLfPjGEhDc6
 pWfi/LjcEPeCCBJXkkbrcS//MheB270EJZ6rwZ2NB2U8TczYjwAAZOKEh7IkeO/lL2aB
 0fAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwpjZ1kNfmzbHBmLsd83GtybDc1bXKRd74QX9SBUxlV+X0F5qVyYhfE5Xx0/rLPYkXmp+bdKq/zNJ6@nongnu.org
X-Gm-Message-State: AFuF++n/tUyNhIIa7Lbe0SCbIJlGrCELDGf8i37XKFaJ9T406iDokexo
 /LKPLuLwnPACDb6vL2VZbpXy4i3iZqdOGE6/4Q6FPwd0pB/WC3Xw3T2eJEKdnQ==
X-Gm-Gg: AYBFou3vwqy7jNHAT2Ma5xwrMA3Vsznwy8iW+YCrsvvye/7xQsXeU03GFSbYSVPo1oi
 MwlK377KC1MCGbPn4EnjIOWXYvt83W2m8dXVfRCssqN0OOJ2sY0SwSkQ0VPfsvxQREpTl2ExnJ3
 gyIeE5IsLY5A/rPdq+yDncOXEzVT+fJvZeTrRP57YEAGh1DFvecZw+xCNdY1iPT2fDMOxvPucmd
 v5/cfKmrBw/B0m82yLLCrjEZNdw7RcmHEaVXyPVsUQ4tSf1YaZMq4b/c1t4pSRXfNqrYWbjWLOJ
 78GoolD5kUKqyyzKg9KT//8evbgkhRGEq3nmPLkc4oI6pifWY0dBRIg9N8CJy1dd3sU0sXfsPLj
 OWDxBn11/AH+i4Pf8gitcZ4qCn/pskI1bNtPhAbLXa5qfwHCyycW/Cni5RVseCTuZUgqnmoeZ+0
 oJU+nQqk8KzehOHMmagMnTkBoriCxLmhWxnHzhD8D5pKnfNefn1FUd0fLk3zthka9QL9hPALm+N
 F/qFoU1EzVe0SuxwlvMCTEeS9yQAHcu8+e21fKA5jI10OhXD2vBCRCI6rv8RXJco7LGrVs=
X-Received: by 2002:a05:600d:82c7:b0:4a1:714d:ef9 with SMTP id
 5b1f17b1804b1-4a1714d114emr11372535e9.27.1791112489234; 
 Sun, 04 Oct 2026 04:14:49 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf09ae00fd0d4fbec0f27aee.dip0.t-ipconnect.de.
 [2003:fa:af09:ae00:fd0d:4fbe:c0f2:7aee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02773ba02sm245933295e9.12.2026.10.04.04.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 04:14:48 -0700 (PDT)
Date: Sun, 04 Oct 2026 11:14:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 07/24] hw/sd: sdhci: Run ADMA independently of MMIO
In-Reply-To: <20260904155758.3833179-8-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-8-bin.meng@processmission.com>
Message-ID: <8D7F1DAF-0133-41A6-A665-8EC8D4078273@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
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



Am 4=2E September 2026 15:57:26 UTC schrieb Bin Meng <bin=2Emeng@processmi=
ssion=2Ecom>:
>The SDHCI model processes the first ADMA descriptor batch inside the
>command MMIO write, then resumes pending batches before every later
>SDHCI MMIO read or write=2E This makes register access perform bulk DMA
>work and can delay a status read even when completion bits are set=2E
>
>On the Icicle Kit, U-Boot uses ADMA2-64 and CMD18 to load a roughly
>19 MiB FIT image from SD=2E It can report:
>
>  Timeout for status update: 00000001 00000001
>  Timeout for status update: 00000003 00000001
>
>The status already contains the requested Command Complete bit, and may
>also contain Transfer Complete=2E However, reading the interrupt status
>first executes a pending ADMA batch=2E The MMIO read can therefore return
>after U-Boot has reached its one-second polling deadline=2E
>
>Turn the existing transfer timer into an ADMA-only engine=2E Starting an
>ADMA command arms the engine directly, and each timer callback runs one
>bounded batch before yielding=2E MMIO reads and writes no longer perform
>or schedule ADMA work=2E Keep PIO and SDMA synchronous=2E
>
>Cancel the engine and clear ADMA activity and error state on DATA or ALL
>reset=2E
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>---
>
>(no changes since v1)
>
> hw/sd/sdhci=2Ec | 143 ++++++++++++++++++++++++++++++--------------------
> 1 file changed, 87 insertions(+), 56 deletions(-)
>
>diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>index bd74c60f72=2E=2E14c312a691 100644
>--- a/hw/sd/sdhci=2Ec
>+++ b/hw/sd/sdhci=2Ec
>@@ -277,6 +277,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool=
 level)
>             }
>         } else {
>             s->prnsts =3D 0x1fa0000;
>+            timer_del(s->transfer_timer);
>             s->pwrcon &=3D ~SDHC_POWER_ON;
>             s->clkcon &=3D ~SDHC_CLOCK_SDCLK_EN;
>             if (s->norintstsen & SDHC_NISEN_REMOVE) {
>@@ -348,7 +349,34 @@ static void sdhci_poweron_reset(DeviceState *dev)
>     }
> }
>=20
>-static void sdhci_data_transfer(void *opaque);
>+static void sdhci_data_transfer(SDHCIState *s);
>+static void sdhci_adma_engine(void *opaque);

The second forward declaration isn't needed=2E

>+
>+static void sdhci_set_transfer_active(SDHCIState *s)
>+{
>+    s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
>+    if (s->trnmod & SDHC_TRNS_READ) {
>+        s->prnsts |=3D SDHC_DOING_READ;
>+    } else {
>+        s->prnsts |=3D SDHC_DOING_WRITE;
>+    }
>+}
>+
>+static void sdhci_schedule_adma(SDHCIState *s)
>+{
>+    timer_mod(s->transfer_timer,
>+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELA=
Y);
>+}
>+
>+static bool sdhci_adma_transfer_active(SDHCIState *s)
>+{
>+    return TRANSFERRING_DATA(s->prnsts) &&
>+           (s->trnmod & SDHC_TRNS_DMA) &&
>+           (s->cmdreg & SDHC_CMD_DATA_PRESENT) &&
>+           sdhci_get_dma_type(s) !=3D SDHC_CTRL_SDMA &&
>+           !(s->admaerr & SDHC_ADMAERR_STATE_MASK) &&
>+           !(s->errintsts & SDHC_EIS_ADMAERR);
>+}

I'd implement the new functions just before the first forward declaration =
above=2E This preserves the position of the forward declaration to stay jus=
t in front of the code where it is first used=2E

N=2EB=2E: Ideally, no forward declarations were needed and the functions w=
ere implemented in topological order=2E

>=20
> #define BLOCK_SIZE_MASK (4 * KiB - 1)
>=20
>@@ -405,7 +433,13 @@ static void sdhci_send_command(SDHCIState *s)
>     if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
>         (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
>         s->data_count =3D 0;
>-        sdhci_data_transfer(s);
>+        if ((s->trnmod & SDHC_TRNS_DMA) &&
>+            sdhci_get_dma_type(s) !=3D SDHC_CTRL_SDMA) {
>+            sdhci_set_transfer_active(s);
>+            sdhci_schedule_adma(s);
>+        } else {
>+            sdhci_data_transfer(s);
>+        }
>     }
> }
>=20
>@@ -850,7 +884,7 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
>=20
> /* Advanced DMA data transfer */
>=20
>-static void sdhci_do_adma(SDHCIState *s)
>+static void sdhci_adma_run_batch(SDHCIState *s)
> {
>     unsigned int begin, length;
>     const uint16_t block_size =3D s->blksize & BLOCK_SIZE_MASK;
>@@ -956,15 +990,17 @@ static void sdhci_do_adma(SDHCIState *s)
>             }
>             if (res !=3D MEMTX_OK) {
>                 s->data_count =3D 0;
>+                s->admaerr &=3D ~SDHC_ADMAERR_STATE_MASK;
>+                s->admaerr |=3D SDHC_ADMAERR_STATE_ST_TFR;
>                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
>                     trace_sdhci_error("Set ADMA error flag");
>                     s->errintsts |=3D SDHC_EIS_ADMAERR;
>                     s->norintsts |=3D SDHC_NIS_ERR;
>                 }
>                 sdhci_update_irq(s);
>-            } else {
>-                s->admasysaddr +=3D dscr=2Eincr;
>+                return;
>             }
>+            s->admasysaddr +=3D dscr=2Eincr;
>             break;
>         case SDHC_ADMA_ATTR_ACT_LINK:   /* link to next descriptor table=
 */
>             s->admasysaddr =3D dscr=2Eaddr;
>@@ -1012,50 +1048,52 @@ static void sdhci_do_adma(SDHCIState *s)
>     }
>=20
>     /* we have unfinished business - reschedule to continue ADMA */
>-    timer_mod(s->transfer_timer,
>-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER=
_DELAY);
>+    sdhci_schedule_adma(s);
> }
>=20
>-/* Perform data transfer according to controller configuration */
>-
>-static void sdhci_data_transfer(void *opaque)
>+/* Run one independently scheduled, quota-bounded ADMA batch */
>+static void sdhci_adma_engine(void *opaque)
> {
>     SDHCIState *s =3D (SDHCIState *)opaque;
>=20
>-    if (s->trnmod & SDHC_TRNS_DMA) {
>-        switch (sdhci_get_dma_type(s)) {
>-        case SDHC_CTRL_SDMA:
>-            sdhci_sdma_transfer(s);
>-            break;
>-        case SDHC_CTRL_ADMA1_32:
>-            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
>-                trace_sdhci_error("ADMA1 not supported");
>-                break;
>-            }
>+    if (!sdhci_adma_transfer_active(s)) {
>+        return;
>+    }
>=20
>-            sdhci_do_adma(s);
>-            break;
>-        case SDHC_CTRL_ADMA2_32:
>-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
>-                trace_sdhci_error("ADMA2 not supported");
>-                break;
>-            }
>+    switch (sdhci_get_dma_type(s)) {
>+    case SDHC_CTRL_ADMA1_32:
>+        if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
>+            trace_sdhci_error("ADMA1 not supported");
>+            return;
>+        }
>+        break;
>+    case SDHC_CTRL_ADMA2_32:
>+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
>+            trace_sdhci_error("ADMA2 not supported");
>+            return;
>+        }
>+        break;
>+    case SDHC_CTRL_ADMA2_64:
>+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
>+            !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
>+            trace_sdhci_error("64 bit ADMA not supported");
>+            return;
>+        }
>+        break;
>+    default:
>+        trace_sdhci_error("Unsupported ADMA type");
>+        return;
>+    }
>=20
>-            sdhci_do_adma(s);
>-            break;
>-        case SDHC_CTRL_ADMA2_64:
>-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
>-                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
>-                trace_sdhci_error("64 bit ADMA not supported");
>-                break;
>-            }
>+    sdhci_adma_run_batch(s);

This is the only place where sdhci_adma_run_batch() is called, so  sdhci_a=
dma_engine() could be merged into sdhci_adma_run_batch()=2E That way, the l=
ogic stays together and we don't have to come up with a better name for `sd=
hci_adma_engine` which somehow misses a verb=2E

Best regards,
Bernhard

>+}
>=20
>-            sdhci_do_adma(s);
>-            break;
>-        default:
>-            trace_sdhci_error("Unsupported DMA type");
>-            break;
>-        }
>+/* Perform synchronous PIO or SDMA data transfer */
>+static void sdhci_data_transfer(SDHCIState *s)
>+{
>+    if (s->trnmod & SDHC_TRNS_DMA) {
>+        assert(sdhci_get_dma_type(s) =3D=3D SDHC_CTRL_SDMA);
>+        sdhci_sdma_transfer(s);
>     } else {
>         if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus))=
 {
>             s->prnsts |=3D SDHC_DOING_READ | SDHC_DATA_INHIBIT |
>@@ -1098,21 +1136,11 @@ sdhci_buff_access_is_sequential(SDHCIState *s, un=
signed byte_num)
>     return true;
> }
>=20
>-static void sdhci_resume_pending_transfer(SDHCIState *s)
>-{
>-    timer_del(s->transfer_timer);
>-    sdhci_data_transfer(s);
>-}
>-
> static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
> {
>     SDHCIState *s =3D (SDHCIState *)opaque;
>     uint32_t ret =3D 0;
>=20
>-    if (timer_pending(s->transfer_timer)) {
>-        sdhci_resume_pending_transfer(s);
>-    }
>-
>     switch (offset & ~0x3) {
>     case SDHC_SYSAD:
>         ret =3D s->sdmasysad;
>@@ -1235,7 +1263,10 @@ static inline void sdhci_reset_write(SDHCIState *s=
, uint8_t value)
>         s->norintsts &=3D ~SDHC_NIS_CMDCMP;
>         break;
>     case SDHC_RESET_DATA:
>+        timer_del(s->transfer_timer);
>         s->data_count =3D 0;
>+        s->admaerr =3D 0;
>+        s->errintsts &=3D ~SDHC_EIS_ADMAERR;
>         s->prnsts &=3D ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
>                 SDHC_DOING_READ | SDHC_DOING_WRITE |
>                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
>@@ -1244,6 +1275,10 @@ static inline void sdhci_reset_write(SDHCIState *s=
, uint8_t value)
>         s->sdma_boundary_paused =3D false;
>         s->norintsts &=3D ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
>                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
>+        if (!s->errintsts) {
>+            s->norintsts &=3D ~SDHC_NIS_ERR;
>+        }
>+        sdhci_update_irq(s);
>         break;
>     }
> }
>@@ -1257,10 +1292,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>     uint32_t value =3D val;
>     value <<=3D shift;
>=20
>-    if (timer_pending(s->transfer_timer)) {
>-        sdhci_resume_pending_transfer(s);
>-    }
>-
>     switch (offset & ~0x3) {
>     case SDHC_SYSAD:
>         if (!TRANSFERRING_DATA(s->prnsts) ||
>@@ -1521,7 +1552,7 @@ void sdhci_initfn(SDHCIState *s)
>     s->insert_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                    sdhci_raise_insertion_irq, s);
>     s->transfer_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>-                                     sdhci_data_transfer, s);
>+                                     sdhci_adma_engine, s);
>=20
>     s->io_ops =3D &sdhci_mmio_ops;
> }

