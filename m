Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0118C5DF7F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4Kh-0006dc-5M; Mon, 17 Aug 2026 16:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KL-0006YJ-Mj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww4KI-0006ho-71
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 16:53:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so36653985e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786999976; x=1787604776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=si+YseqNQY0eMz7hqP//9pL06dURzQ3fH0WqmuMmqXU=;
 b=qQqpDb3SrnZG5FzRU6A1zqO1T0ZURIiltkoWjjQBVLzmSc1p4ZbNGRkqn6+pGw8C8p
 WH/HnTq7mvEn93vaGpcsMNJiMshd/yqbB2lAEGO/QqxpkWjnmq0EQK+ZLIANGCGmHF0j
 80ZNQZHrVrv3ucPglvDF8d764ysHE52ARJzmMzzg6uZJHkFEYBzZM7EVb9Er+UC9nuvo
 S/svwHTLsYcnFPeKLwjr+gDLs3tQOUH7Zd158oG/jRC8UHR2fakc67TG5wOlOQERQ6px
 S6EJWCMgtRQJjxDMoKqv7CoMYJTLdhWejpYNyaZMQ/HxzJTa8jcB13/XrOgNt4CXVbKJ
 IGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786999976; x=1787604776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=si+YseqNQY0eMz7hqP//9pL06dURzQ3fH0WqmuMmqXU=;
 b=mOcQRmOpMn6ZFKe9GlI4Ix7t/aJLUyPbrcF2AcXxBHlgXF+ZAkdWeuO8TZ6XRHs0T7
 /jjDgic9A7BjFNLuA+MafH6qf5o68kHPNfq0qd/QnjTrqoqBtG8rhptPiitgoAmqaqjo
 uHtNfdySuAwOh8If/oWC5i34K+bIrnDOULzNZGLFWyTdyoTZe55UQNgOGGl81Wgym+Pv
 f89gTvm0UaP9Z1Lki05dztiVGY4JWNQ6gp99ESXVJBEw2nh9K+kVv4fmpfAm3dx+Q1vD
 DD+CKp9tRUWtTSikN/plvfeRYfkDkybeC+u1PIjelSG7AG+QYpg5z/CD+WtUnhny+jyG
 Qmgw==
X-Gm-Message-State: AOJu0YxJ31JIDUYsoLvnIXWzEONFirF7CvRZ/eaLKNf3yNv/DeQwWbsf
 f+J0m1F7tDCfvmdrNvj/RCeN6Hn2f+Cxb3isL8x450R1G9K74k8dIX8DUVnbsuzNJ2VQXbDvWR4
 NDWoB
X-Gm-Gg: AR+sD13NEAtD2oKi1xzms4FG5EBW6ewiBoFxSKAWzZ6Rzl1LD1/YjvPaCRy7xciIwth
 N//LX75u/XBY4d6dk5XLB3sqvnrilNoezETc829sdVRu4ZpGPPeNWQUu0dHbT3aOmJs+NtP91ke
 7fyEbVu83LWGZsTzn/eHOgBuKIhSsB4je0bgNK1VJ3jbHWeaFWGeEDCanomli904F7RqrSlfSJU
 Q5S+9+yi8Y39O7WsFhcRtOXh8Rjw0ma5vCzPzRsh8mHaxgmGhjrs6mnpy3945hz+g48I01kQxtC
 7h54TZZKsDnlabLhNBzePJKHCUFko6OzQiZhhw92pEBqV4fBWaSmmEyhIptQ97Y8kBtKhdRqnwD
 Hphnh70yMvG6ixnNf4P+nCGjocPhEPUJqVwaWsmKoK3pH4TRd/tti1UPFht3BKltOvXD3we6Zw/
 IkO5ALWL+hTTGUqO3P/004Rzku2sZjQezneK+B7czQ64ypyacj6g==
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499879298c4mr286625005e9.1.1786999975953; 
 Mon, 17 Aug 2026 13:52:55 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm202573365e9.6.2026.08.17.13.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 13:52:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 08/15] hw/ide: migrate the logical CHS translation
Date: Mon, 17 Aug 2026 22:52:35 +0200
Message-ID: <20260817205242.1199851-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817205242.1199851-1-den@openvz.org>
References: <20260817205242.1199851-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

INITIALIZE DEVICE PARAMETERS lets a guest replace the logical CHS
translation used to turn the CHS registers into an LBA, but s->heads and
s->sectors were in no VMStateDescription. The destination rebuilt them
from the drive configuration, so a guest that had selected one of its own
kept addressing the disk in it while the device translated with the
default, landing on sectors nobody asked for.

Add a subsection for it, sent only when the guest replaced the default, so
that migration to an older QEMU keeps working for every other guest.
s->cylinders is left out, as no command changes it.

Validate what is loaded in the existing post_load: ide_get_sector()
multiplies by these fields and ide_set_sector() divides by them.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 3b67409eb4..ab8c23e5b9 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2879,6 +2879,13 @@ static int ide_drive_post_load(void *opaque, int version_id)
 {
     IDEState *s = opaque;
 
+    /* Only a disk has a translation; an empty slot and ATAPI keep these zero */
+    if (s->blk && s->drive_kind != IDE_CD &&
+        (s->heads < 1 || s->heads > 16 ||
+         s->sectors < 1 || s->sectors > 255)) {
+        return -EINVAL;
+    }
+
     if (s->blk && s->identify_set) {
         blk_set_enable_write_cache(s->blk, !!(s->identify_data[85] & (1 << 5)));
     }
@@ -2962,6 +2969,25 @@ static const VMStateDescription vmstate_ide_atapi_gesn_state = {
     }
 };
 
+static bool ide_chs_translation_needed(void *opaque)
+{
+    IDEState *s = opaque;
+
+    return s->heads != s->drive_heads || s->sectors != s->drive_sectors;
+}
+
+static const VMStateDescription vmstate_ide_drive_chs_translation = {
+    .name = "ide_drive/chs_translation",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ide_chs_translation_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(heads, IDEState),
+        VMSTATE_INT32(sectors, IDEState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_ide_tray_state = {
     .name = "ide_drive/tray_state",
     .version_id = 1,
@@ -3025,6 +3051,7 @@ const VMStateDescription vmstate_ide_drive = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_ide_drive_pio_state,
+        &vmstate_ide_drive_chs_translation,
         &vmstate_ide_tray_state,
         &vmstate_ide_atapi_gesn_state,
         NULL
-- 
2.53.0


