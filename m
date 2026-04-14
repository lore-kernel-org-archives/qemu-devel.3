Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE2BF9D0C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcch-0003Fx-Rp; Tue, 14 Apr 2026 08:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCccf-0003E4-DY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:12:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wCccc-0005TY-MC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:12:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso67178135e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776168721; x=1776773521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+Gvc4ZIfyLzU7ILGQM5ksGs3WaLDY+fGxbCYym0yzY=;
 b=tAADHMP/AZXINEzKUdibu1dRXkWeP6I/y1nDOhEiaqr/45NOil7WCsbddYy5osj84z
 WUhzlCAwG92XBlcc7oXE5bCuGxA5+k3jiff0EKgv+cj1XOWXXU9lj/WflIKgA4LgMtlh
 cr9Yu97ZcUUY+4vhNPoDjM7RHCQg632SqA/L9KLDyxIHGEwPOOEnQZfXK3VyoIbhXap6
 zRuhPAfOxRAjjJHDJQyUD2pDaSr4GvWVhLa1q3ptCB1hp4ipym1xbgv9R9B6xZSeL0xj
 sMbhH50XZ5bEu08Y/LsgQeUv36dMkTZTP1/nappE3fCIi+4jmC3dUiStBhUyWxMQndVM
 L9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776168721; x=1776773521;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+Gvc4ZIfyLzU7ILGQM5ksGs3WaLDY+fGxbCYym0yzY=;
 b=YvGodFClpHPZjWYXYTyBAEfl8Pt7Vvt8RiKAPT8iFlDx5B8V+p8Lw5AyXnycKDHLjU
 0zN+hs4t1J+VGpTjtkFgMhaic8o3NLX91aPc55MsBdVm8yMocKG7l2/e5HSZRJxU4eIp
 7/CnBDgJNU15rly3yC/8vIjCHzmqlidRHv/7ByGsYxxy0O+Amq8yMg0O29JtZ5wFrzZ4
 35T00LdvcIVd3zkYiWyJffHI2jya3B/FIG/EhxPfQf6idbH440FLkPeedw2OadtpDVMr
 q4GoVXAn1VWgmZb/NWBkKshEN8xHt5BtlPYX83ErSC/zUK1q6gp94kGaxJ4dQebrpF65
 VzEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HpgYhls2nBvrV49buLCdE2cMvOKhxCYfu698S6LXjAod9WEYnF93cBhX7R7EbmdxpJiE3QY/WDGj0@nongnu.org
X-Gm-Message-State: AOJu0Ywm67brZkOQxZIcJx5LA3Pgdh+WgEOEYnZf/qe+Lh/TDW5vc664
 OOcfUiqFgCCe4Q4irIhROF4sHKbTSdJf9doL3KSzx2vy3/Hg6CfdatDH
X-Gm-Gg: AeBDiet6jDZGb8tjFptyfGWaoR6E567u9sxskie/MVaO5N9mzYNcweHMYp9f3xA/Jsk
 QKxbGVlxA+guxi1FMQDlYBkc+WQTf3NfKuJhxiLXcmOAwH1sJoqt1rze73Sgk/hDBd6izRMaln+
 0PsKy8wzhRyJzYM0O4WJ4HM02E5EqCr4Jq6+OOKoXoKh7PKJOJfTevdCuJ3+ZWYIcUVEUgQEvAM
 Y53NejvOhmp4yiQ2lJaxsKTd2+chDauNnjgudLSbcNlA3pRTBVgvIACpDvPplDFVTODbi1iHTTd
 3P/B6ZYTEAGL+I0WbWcZA6+XObMdMHmojYFPTl/xabDtlQshN2INEmMUX3Rh1y8gSkpGUCoSAp/
 tCop9ERx0nO+L4PCaYLMEOsZMhB/uQFGXGJbgxg0+fgKZXoVdsD7k2v6X2OBosx1O0KcFae4aoy
 uf1ElhBIkNCjqQJ/PO7PRA5SdbdL19weXZUBcCyS2FTfx7FiiVhyhBFMQfTgExc7zX8ub4uLwHx
 EoFhQ00dCaeO4jjkqLKN8qZNaZ79Ec=
X-Received: by 2002:a05:600c:a105:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-488d6839821mr168465795e9.19.1776168720862; 
 Tue, 14 Apr 2026 05:12:00 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf1c6100004fcff454cbdf8f.dip0.t-ipconnect.de.
 [2003:fa:af1c:6100:4f:cff4:54cb:df8f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488eddb9751sm77832905e9.0.2026.04.14.05.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:12:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:11:58 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, qemu-arm@nongnu.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 6/7] tests: Add qtests for FlexCAN
In-Reply-To: <adzuRHcb4BVIRAS8@redhat.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <33d03d96698eb7511321690d9b5a054f03aa8bc7.1773866323.git.matyas.bobek@gmail.com>
 <4244E4A0-CCE2-4E23-B32E-B6B9242FAA60@gmail.com>
 <adzuRHcb4BVIRAS8@redhat.com>
Message-ID: <FB523542-A8A0-4B5D-B757-2C6F7F7AD981@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 13=2E April 2026 13:23:16 UTC schrieb "Daniel P=2E Berrang=C3=A9" <berr=
ange@redhat=2Ecom>:
>On Mon, Apr 13, 2026 at 01:16:20PM +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 19=2E M=C3=A4rz 2026 19:13:13 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <=
matyas=2Ebobek@gmail=2Ecom>:
>> >The tests do not test all of the FlexCAN emulator functionality=2E
>> >
>> >Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>> >---
>> > MAINTAINERS                |   1 +
>> > tests/qtest/flexcan-test=2Ec | 424 ++++++++++++++++++++++++++++++++++=
+++
>> > tests/qtest/meson=2Ebuild    |   1 +
>> > 3 files changed, 426 insertions(+)
>> > create mode 100644 tests/qtest/flexcan-test=2Ec
>> >
>> >diff --git a/MAINTAINERS b/MAINTAINERS
>> >index e723863a6f=2E=2Edbb159f031 100644
>> >--- a/MAINTAINERS
>> >+++ b/MAINTAINERS
>> >@@ -2090,6 +2090,7 @@ S: Maintained
>> > F: hw/net/can/flexcan=2Ec
>> > F: hw/net/can/flexcan_regs=2Eh
>> > F: include/hw/net/flexcan=2Eh
>> >+F: tests/qtest/flexcan-test=2Ec
>> >=20
>> > EDU
>> > M: Jiri Slaby <jslaby@suse=2Ecz>
>> >diff --git a/tests/qtest/flexcan-test=2Ec b/tests/qtest/flexcan-test=
=2Ec
>> >new file mode 100644
>> >index 0000000000=2E=2Eb5880d4119
>> >--- /dev/null
>> >+++ b/tests/qtest/flexcan-test=2Ec
>> >@@ -0,0 +1,424 @@
>> >+/*
>> >+ * QTests for FlexCAN CAN controller device model
>> >+ *
>> >+ * Copyright (c) 2025 Matyas Bobek <matyas=2Ebobek@gmail=2Ecom>
>> >+ *
>> >+ * This code is licensed under the GPL version 2 or later=2E  See
>> >+ * the COPYING file in the top-level directory=2E
>>=20
>> IIUC this license text is redundant to the specifier below, but again, =
IANAL=2E Daniel?
>
>checkpatch=2Epl  should complain about this=2E
>
>For *newly* written files, only the SPDX-License-Identifier should be
>present=2E   Traditional license boilerplate is only permitted if we're
>dealing with historical files where we're required to preserve existing
>license text=2E

Thanks for the hint!

Though checkpatch=2Epl doesn't seem to catch this particular case=2E Is a =
patch needed here?

Best regards,
Bernhard

>
>
>>=20
>> >+ *
>> >+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>> >+ */
>> >+
>> >+#include "qemu/osdep=2Eh"
>> >+#include "libqtest-single=2Eh"
>> >+
>> >+#include "hw/net/flexcan=2Eh"
>> >+#include "hw/net/can/flexcan_regs=2Eh"
>> >+
>> >+#define FSL_IMX6_CAN2_ADDR 0x02094000
>> >+#define FSL_IMX6_CAN2_SIZE 0x4000
>> >+#define FSL_IMX6_CAN1_ADDR 0x02090000
>> >+#define FSL_IMX6_CAN1_SIZE 0x4000
>> >+
>> >+#define FC_QEMU_ARGS "-nographic -M sabrelite " \
>> >+                     "-object can-bus,id=3Dqcan0  " \
>> >+                     "-machine canbus0=3Dqcan0 -machine canbus1=3Dqca=
n0"
>> >+
>> >+/* used for masking out unused/reserved bits */
>> >+#define FC_MB_CNT_USED_MASK (~0xF080FFFFu)
>> >+
>> >+#define FCREG(BASE_ADDR, REG) ((BASE_ADDR) + offsetof(FlexcanRegs, RE=
G))
>> >+#define FCMB(BASE_ADDR, MB_IDX, WORD_IDX) (FCREG(BASE_ADDR, mbs) + \
>> >+    0x10 * (MB_IDX) + 4 * (WORD_IDX))
>> >+
>> >+typedef struct FcTestFrame {
>> >+    uint32_t id;
>> >+    uint32_t data[2];
>> >+    uint8_t len;
>> >+    bool ide;
>> >+    bool rtr;
>> >+
>> >+    /* rx only */
>> >+    bool expect_overrun;
>> >+} FcTestFrame;
>> >+
>> >+static const FcTestFrame fc_test_frame_1 =3D {
>> >+    =2Eid =3D 0x5AF,
>> >+    =2Elen =3D 8,
>> >+    =2Edata =3D {
>> >+        0x01020304,
>> >+        0x0A0B0C0D
>> >+    },
>> >+    =2Eide =3D false
>> >+};
>> >+
>> >+static const FcTestFrame fc_test_frame_1_ide =3D {
>> >+    =2Eid =3D 0x105AF5AF,
>> >+    =2Elen =3D 8,
>> >+    =2Edata =3D {
>> >+        0x01020304,
>> >+        0x0A0B0C0D
>> >+    },
>> >+    =2Eide =3D true
>> >+};
>> >+
>> >+static void fc_reset(hwaddr ba, uint32_t mcr_flags)
>> >+{
>> >+    /* disable */
>> >+    writel(FCREG(ba, mcr), 0xD890000F);
>> >+
>> >+    /* enable in freeze mode */
>> >+    writel(FCREG(ba, mcr), 0x5980000F);
>> >+
>> >+    /* soft reset */
>> >+    writel(FCREG(ba, mcr), 0x5980000F | FLEXCAN_MCR_SOFTRST);
>> >+
>> >+    g_assert_cmpuint(readl(FCREG(ba, mcr)), =3D=3D, 0x5980000F);
>> >+    g_assert_cmpuint(readl(FCREG(ba, ctrl)), =3D=3D, 0);
>> >+    g_assert_cmpuint(readl(FCREG(ba, ctrl2)), =3D=3D, 0);
>> >+
>> >+    writel(FCREG(ba, mcr), (0x5980000F & ~FLEXCAN_MCR_HALT) | mcr_fla=
gs);
>> >+    writel(FCREG(ba, ctrl2), FLEXCAN_CTRL2_RRS);
>> >+
>> >+    /* initialize all mailboxes as rx inactive */
>> >+    for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>> >+        writel(FCMB(ba, i, 0), FLEXCAN_MB_CODE_RX_INACTIVE);
>> >+        writel(FCMB(ba, i, 1), 0);
>> >+        writel(FCMB(ba, i, 2), 0);
>> >+        writel(FCMB(ba, i, 3), 0);
>> >+    }
>> >+}
>> >+
>> >+static uint64_t fc_get_irqs(hwaddr ba)
>> >+{
>> >+    return (uint64_t)readl(FCREG(ba, iflag1)) |
>> >+        ((uint64_t)readl(FCREG(ba, iflag2)) << 32);
>> >+}
>> >+
>> >+static void fc_clear_irq(hwaddr ba, int idx)
>> >+{
>> >+    if (idx >=3D 32) {
>> >+        writel(FCREG(ba, iflag2), (uint32_t)1 << (idx - 32));
>> >+    } else {
>> >+        writel(FCREG(ba, iflag1), (uint32_t)1 << idx);
>> >+    }
>> >+
>> >+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << idx), =3D=3D, =
0);
>> >+}
>> >+
>> >+static void fc_setup_rx_mb(hwaddr ba, int mbidx)
>> >+{
>> >+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_RX_EMPTY);
>> >+    writel(FCMB(ba, mbidx, 1), 0);
>> >+    /* the data value should be ignored for RX mb */
>> >+    writel(FCMB(ba, mbidx, 2), 0);
>> >+    writel(FCMB(ba, mbidx, 3), 0);
>> >+
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), =3D=3D, FLEXCAN_MB_CO=
DE_RX_EMPTY);
>> >+}
>> >+
>> >+static void fc_tx(hwaddr ba, int mbidx, const FcTestFrame *frame)
>> >+{
>> >+    g_assert_cmpuint(frame->len, <=3D, 8);
>> >+
>> >+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_INACTIVE);
>> >+    uint32_t id =3D frame->ide ? frame->id : frame->id << 18;
>> >+    writel(FCMB(ba, mbidx, 1), id);
>> >+    writel(FCMB(ba, mbidx, 2), frame->data[0]);
>> >+    writel(FCMB(ba, mbidx, 3), frame->data[1]);
>> >+
>> >+    uint32_t ctrl =3D FLEXCAN_MB_CODE_TX_DATA | FLEXCAN_MB_CNT_LENGTH=
(frame->len);
>> >+    if (frame->ide) {
>> >+        ctrl |=3D FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
>> >+    }
>> >+    if (frame->rtr) {
>> >+        ctrl |=3D FLEXCAN_MB_CNT_RTR;
>> >+    }
>> >+    writel(FCMB(ba, mbidx, 0), ctrl);
>> >+
>> >+    /* check frame was transmitted */
>> >+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << mbidx),
>> >+                     !=3D, 0);
>> >+
>> >+    uint32_t xpectd_ctrl =3D (ctrl & ~FLEXCAN_MB_CODE_MASK) |
>> >+        FLEXCAN_MB_CODE_TX_INACTIVE;
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK,=
 =3D=3D,
>> >+                     xpectd_ctrl);
>> >+    /* other fields should stay unchanged */
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), =3D=3D, id);
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), =3D=3D, frame->data[0=
]);
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), =3D=3D, frame->data[1=
]);
>> >+}
>> >+
>> >+static void fc_rx_check(hwaddr ba, int mbidx, const FcTestFrame *fram=
e)
>> >+{
>> >+    uint32_t xpectd_ctrl =3D frame->expect_overrun ? FLEXCAN_MB_CODE_=
RX_OVERRUN
>> >+                             : FLEXCAN_MB_CODE_RX_FULL;
>> >+    xpectd_ctrl |=3D FLEXCAN_MB_CNT_LENGTH(frame->len) | FLEXCAN_MB_C=
NT_SRR;
>> >+    if (frame->ide) {
>> >+        xpectd_ctrl |=3D FLEXCAN_MB_CNT_IDE;
>> >+    }
>> >+    if (frame->rtr) {
>> >+        xpectd_ctrl |=3D FLEXCAN_MB_CNT_RTR;
>> >+    }
>> >+
>> >+    uint32_t xpectd_id =3D frame->ide ? frame->id : frame->id << 18;
>> >+
>> >+    uint32_t ctrl =3D readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK=
;
>> >+    if ((ctrl & FLEXCAN_MB_CODE_MASK) =3D=3D FLEXCAN_MB_CODE_RX_EMPTY=
) {
>> >+        fprintf(stderr, "expected frame (id=3D0x%X) not received\n", =
frame->id);
>> >+    }
>> >+
>> >+    g_assert_cmpuint(ctrl, =3D=3D, xpectd_ctrl);
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), =3D=3D, xpectd_id);
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), =3D=3D, frame->data[0=
]);
>> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), =3D=3D, frame->data[1=
]);
>> >+}
>> >+
>> >+static void fc_check_empty_multi(hwaddr ba, int idx_count, int mbidxs=
[])
>> >+{
>> >+    for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>> >+        bool check_empty =3D true;
>> >+        int ctrl =3D readl(FCMB(ba, i, 0));
>> >+
>> >+        for (int j =3D 0; j < idx_count; j++) {
>> >+            if (i =3D=3D mbidxs[j]) {
>> >+                check_empty =3D false;
>> >+            }
>> >+        }
>> >+
>> >+        if (check_empty) {
>> >+            if (!(ctrl =3D=3D FLEXCAN_MB_CODE_RX_EMPTY ||
>> >+                  ctrl =3D=3D FLEXCAN_MB_CODE_RX_INACTIVE)) {
>> >+                g_assert_cmpuint(ctrl, =3D=3D, FLEXCAN_MB_CODE_RX_INA=
CTIVE);
>> >+            }
>> >+            g_assert_cmpuint(readl(FCMB(ba, i, 1)), =3D=3D, 0);
>> >+            g_assert_cmpuint(readl(FCMB(ba, i, 2)), =3D=3D, 0);
>> >+            g_assert_cmpuint(readl(FCMB(ba, i, 3)), =3D=3D, 0);
>> >+        } else {
>> >+            g_assert_cmpuint(
>> >+                ctrl & FLEXCAN_MB_CODE_MASK, !=3D,
>> >+                FLEXCAN_MB_CODE_RX_INACTIVE
>> >+            );
>> >+        }
>> >+    }
>> >+}
>> >+
>> >+static void fc_check_empty(hwaddr ba, int mbidx)
>> >+{
>> >+    fc_check_empty_multi(ba, 1, &mbidx);
>> >+}
>> >+
>> >+static void flexcan_test_linux_probe_impl(hwaddr fba)
>> >+{
>> >+    /* -- test a Linux driver-like probe sequence -- */
>> >+    /* disable */
>> >+    writel(FCREG(fba, mcr), 0xD890000F);
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xD890000F);
>> >+    g_assert_cmpuint(readl(FCREG(fba, ctrl)), =3D=3D, 0);
>> >+
>> >+    /* set bit in reserved field we do not implement (CTRL_CLK_SRC) *=
/
>> >+    writel(FCREG(fba, ctrl), 0x00002000);
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xD890000F);
>> >+
>> >+    /* enable in freeze mode */
>> >+    writel(FCREG(fba, mcr), 0x5980000F);
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x5980000F);
>> >+
>> >+    /* enable Rx-FIFO */
>> >+    writel(FCREG(fba, mcr), 0x7980000F);
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x7980000F);
>> >+    g_assert_cmpuint(readl(FCREG(fba, ecr)), =3D=3D, 0);
>> >+
>> >+    /* disable */
>> >+    writel(FCREG(fba, mcr), 0xF890000F);
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>> >+}
>> >+
>> >+static void flexcan_test_freeze_disable_interaction_impl(hwaddr fba)
>> >+{
>> >+    /* -- test normal <=3D> freeze <=3D> disable transitions -- */
>> >+
>> >+    /* leave freeze in disabled, FRZ_ACK should stay cleared */
>> >+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>> >+    writel(FCREG(fba, mcr), 0xB890000F);  /* by clearing FRZ */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xB890000F);
>> >+
>> >+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>> >+    writel(FCREG(fba, mcr), 0xE890000F);  /* by clearing HALT */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xE890000F);
>> >+
>> >+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>> >+    writel(FCREG(fba, mcr), 0xA890000F);  /* by clearing both */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xA890000F);
>> >+
>> >+    /* enter and leave freeze */
>> >+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x7980000F);
>> >+    writel(FCREG(fba, mcr), 0x3980000F); /* leave by clearing FRZ */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x3080000F);
>> >+
>> >+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x7980000F);
>> >+    writel(FCREG(fba, mcr), 0x6980000F); /* leave by clearing HALT */
>> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x6080000F);
>> >+}
>> >+
>> >+static void flexcan_test_mailbox_io_impl(hwaddr ba_tx, hwaddr ba_rx)
>> >+{
>> >+    /* -- test correct handling of mailbox IO -- */
>> >+    const int test_1_mbidx =3D 0;
>> >+    fc_reset(ba_tx,
>> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_=
COUNT));
>> >+    fc_reset(ba_rx,
>> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_=
COUNT));
>> >+
>> >+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
>> >+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1_ide);
>> >+    g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 1 << test_1_mbidx);
>> >+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1_ide);
>> >+    readl(FCREG(ba_rx, timer)); /* reset lock */
>> >+
>> >+    writel(FCMB(ba_rx, test_1_mbidx, 0), 0);
>> >+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 0)), =3D=3D, 0);
>> >+    writel(FCMB(ba_rx, test_1_mbidx, 1), 0x99AABBCC);
>> >+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 1)), =3D=3D, 0x9=
9AABBCC);
>> >+}
>> >+
>> >+static void flexcan_test_dual_transmit_receive_impl(hwaddr ba_tx, hwa=
ddr ba_rx)
>> >+{
>> >+    /* -- test TX and RX between the two FlexCAN instances -- */
>> >+    const int test_1_mbidx =3D 50;
>> >+    const int test_rounds =3D 50;
>> >+
>> >+    /* self-receive enabled on tx FC */
>> >+    fc_reset(ba_tx,
>> >+             FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
>> >+    fc_reset(ba_rx,
>> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_=
COUNT));
>> >+
>> >+    /* tests self-receive on tx and reception on rx */
>> >+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
>> >+    fc_check_empty(ba_rx, test_1_mbidx);
>> >+    fc_setup_rx_mb(ba_tx, test_1_mbidx + 1);
>> >+    fc_check_empty(ba_tx, test_1_mbidx + 1);
>> >+    g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 0);
>> >+    g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, 0);
>> >+
>> >+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1);
>> >+    fc_clear_irq(ba_tx, test_1_mbidx);
>> >+
>> >+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1);
>> >+    fc_check_empty(ba_rx, test_1_mbidx);
>> >+    fc_rx_check(ba_tx, test_1_mbidx + 1, &fc_test_frame_1);
>> >+    int tx_non_empty_mbidxs[] =3D {test_1_mbidx, test_1_mbidx + 1};
>> >+
>> >+    fc_check_empty_multi(ba_tx, 2, tx_non_empty_mbidxs);
>> >+    fc_clear_irq(ba_rx, test_1_mbidx);
>> >+    fc_clear_irq(ba_tx, test_1_mbidx + 1);
>> >+    readl(FCREG(ba_rx, timer)); /* reset lock */
>> >+
>> >+    for (int ridx =3D 0; ridx < test_rounds; ridx++) {
>> >+        /* test extended IDs sent to all mailboxes */
>> >+        for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>> >+            fc_setup_rx_mb(ba_rx, i);
>> >+        }
>> >+        fc_check_empty_multi(ba_rx, 0, NULL);
>> >+        g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 0);
>> >+        g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, 0);
>> >+
>> >+        for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>> >+            fc_tx(ba_tx, i, &fc_test_frame_1_ide);
>> >+        }
>> >+        g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, UINT64_MAX);
>> >+        g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, UINT64_MAX);
>> >+        for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>> >+            fc_rx_check(ba_rx, i, &fc_test_frame_1_ide);
>> >+        }
>> >+
>> >+        /* reset interrupts */
>> >+        writel(FCREG(ba_rx, iflag1), UINT32_MAX);
>> >+        writel(FCREG(ba_rx, iflag2), UINT32_MAX);
>> >+        writel(FCREG(ba_tx, iflag1), UINT32_MAX);
>> >+        writel(FCREG(ba_tx, iflag2), UINT32_MAX);
>> >+        g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 0);
>> >+        g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, 0);
>> >+    }
>> >+}
>> >+
>> >+static void flexcan_test_tx_abort_impl(hwaddr ba)
>> >+{
>> >+    /* -- test the TX abort feature -- */
>> >+    fc_reset(ba,
>> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_=
COUNT));
>> >+
>> >+
>> >+    for (int mbidx =3D 0; mbidx < FLEXCAN_MAILBOX_COUNT; mbidx++) {
>> >+        fc_tx(ba, mbidx, &fc_test_frame_1);
>> >+
>> >+        writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_ABORT);
>> >+        g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), =3D=3D,
>> >+                         FLEXCAN_MB_CODE_TX_INACTIVE);
>> >+    }
>> >+}
>> >+
>> >+static void flexcan_test_freeze_disable_interaction(void)
>> >+{
>> >+    qtest_start(FC_QEMU_ARGS);
>> >+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN1_ADDR);
>> >+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN2_ADDR);
>> >+    qtest_end();
>> >+}
>> >+
>> >+static void flexcan_test_linux_probe(void)
>> >+{
>> >+    qtest_start(FC_QEMU_ARGS);
>> >+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN1_ADDR);
>> >+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN2_ADDR);
>> >+    qtest_end();
>> >+}
>> >+
>> >+static void flexcan_test_dual_transmit_receive(void)
>> >+{
>> >+    qtest_start(FC_QEMU_ARGS);
>> >+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN1_ADDR,
>> >+                                            FSL_IMX6_CAN2_ADDR);
>> >+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN2_ADDR,
>> >+                                            FSL_IMX6_CAN1_ADDR);
>> >+    qtest_end();
>> >+}
>> >+
>> >+static void flexcan_test_tx_abort(void)
>> >+{
>> >+    qtest_start(FC_QEMU_ARGS);
>> >+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN1_ADDR);
>> >+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN2_ADDR);
>> >+    qtest_end();
>> >+}
>> >+
>> >+static void flexcan_test_mailbox_io(void)
>> >+{
>> >+    qtest_start(FC_QEMU_ARGS);
>> >+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN1_ADDR, FSL_IMX6_CAN2_AD=
DR);
>> >+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN2_ADDR, FSL_IMX6_CAN1_AD=
DR);
>> >+    qtest_end();
>> >+}
>> >+
>> >+int main(int argc, char **argv)
>> >+{
>> >+    g_test_init(&argc, &argv, NULL);
>> >+
>> >+    qtest_add_func("/net/flexcan/linux_probe", flexcan_test_linux_pro=
be);
>> >+    qtest_add_func("/net/flexcan/freeze_disable_interaction",
>> >+                   flexcan_test_freeze_disable_interaction);
>> >+    qtest_add_func("/net/flexcan/dual_transmit_receive",
>> >+                   flexcan_test_dual_transmit_receive);
>> >+    qtest_add_func("/net/flexcan/tx_abort",
>> >+                   flexcan_test_tx_abort);
>> >+    qtest_add_func("/net/flexcan/mailbox_io", flexcan_test_mailbox_io=
);
>> >+
>> >+    return g_test_run();
>> >+}
>> >diff --git a/tests/qtest/meson=2Ebuild b/tests/qtest/meson=2Ebuild
>> >index be4fa627b5=2E=2E33239f1880 100644
>> >--- a/tests/qtest/meson=2Ebuild
>> >+++ b/tests/qtest/meson=2Ebuild
>> >@@ -246,6 +246,7 @@ qtests_arm =3D \
>> >   (config_all_devices=2Ehas_key('CONFIG_MICROBIT') ? ['microbit-test'=
] : []) + \
>> >   (config_all_devices=2Ehas_key('CONFIG_STM32L4X5_SOC') ? qtests_stm3=
2l4x5 : []) + \
>> >   (config_all_devices=2Ehas_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspe=
ed_fsi-test'] : []) + \
>> >+  (config_all_devices=2Ehas_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-tes=
t'] : []) + \
>> >   (config_all_devices=2Ehas_key('CONFIG_STM32L4X5_SOC') and
>> >    config_all_devices=2Ehas_key('CONFIG_DM163')? ['dm163-test'] : [])=
 + \
>> >   ['arm-cpu-features',
>>=20
>> I like that the test attempts to mimic real device driver behavior, whi=
ch makes its intent recognizable=2E
>>=20
>> With the license text comment addressed:
>> Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>=20
>
>With regards,
>Daniel

