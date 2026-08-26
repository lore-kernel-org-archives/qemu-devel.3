Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6A1C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfE-0004Gm-5o; Wed, 26 Aug 2026 07:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBf9-0004EZ-Ko
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBf6-0005cS-6w
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:22 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso1253043a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743158; x=1788347958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mvbyu72RNCBKA30dtO0psq+nr2zGhTtycdQqI3vt+Gw=;
 b=LHZFIH2THge+OHRK9RVgcwStRB/Q5LBXC/AWQCYhsoaAdBYvjrgSXvkt7FxuYpWvPl
 AEiBiUqHG4h6AaqKan2SKrlgcgjosurXeoBNVa3vnJ3Gb+UZZhxkCk0agnLjAcgiwu70
 cxPOQKeAvDktuaqbhWpw3AE73CMKNySK2At1pkiX3IWSQRMlcuP1yNNHffU7HGTusci7
 WsrLJq2YiUQK/VhTRMHIr8WA+nUNTbBocOdrqxuo+zRU7k2cC23+d/aLDzjdbCUtCSLS
 VcY6smh5qniAlT6NJihM7wTRr/Jmwaxx/TmSg+rDlUlZuKNtYPpaIEvYQQDnWzzp9f29
 n2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743158; x=1788347958;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvbyu72RNCBKA30dtO0psq+nr2zGhTtycdQqI3vt+Gw=;
 b=tQWSQKE6pExAjVnhnkznI5fVpoihVYcymqhdT3Bh4Xz8ZllIlgEuxWu950DflGXxnI
 DHOqqdj6gHXt38RL0tx+5ognI9gOTnzzwP6ekfTiD5SFDcxt7MCk/jKby7JUGawFIM82
 yap81hmf+UQpu9lhuPBBGyP7yBloLvlAt1PPgR0E5LjA3THJ9xYlVoD2F1Lrh0OC5zs5
 5Ta17jzKv/ol/oBbb0oVVkLWTTSbSYLJG+3kMGZAtQ/IiXcICvuYOgJ+PHQ3/cFwstZu
 7prvXSO0yvG/XbMb+VTcmP24czfzV/ui8KJUTQfliMtctqZnzbXcEj9PGNvrGlKTNTrv
 OXLA==
X-Gm-Message-State: AFuF++mYO3MogRo+oJswlKKl8b491HcAdCo1wzmP5RH6Oml7w1LtAEE1
 x0NHaAAdW2nq7pfvg0OxP/M/S2OJxYKuKx4plYRteiTFgsSkEQCJo2nJPjQ940I3OUYCfiEbKdG
 GdtYj
X-Gm-Gg: AR+sD13Yw5bKNc90esepINIxnD334XD/HJwUthR4+RfLffgwm8SpXaAQRaujKk+J/l0
 tOJGOU5iEQ3N7Z8KOB6uKGqhZGTvJ89yQl2FDRFKLy89E+RPu735SP/T2i6KD7tJ5aqtXaLk9b1
 13lOJc01dXiWecPywEQZRoeUOPIhRlrSEYFe2WiqI6DAIBFzTshAtP9kVv6ejq/LmTgAqg8GoYU
 wPoG4iQZFbXokHntr9oKGVLxbNWrRa5C4trFDN0ZmRJS5tDhJBJizM118gvlU01D7RkFR6Dd4TA
 pY1dmu1/OVQVH0kY720eDavTcvBa7wPirAoLPh5s9hlBDjZatFd4M3YeGBgZtvuAKbXQfNKi9FZ
 NHaLPLR6pkfE5wWBp+gxpH0pj//p7MxqFDfayQ4Q6ie29IA3GPnQ1+HI65k5pbsDHyBF5NirgTK
 /nNZA7c6fB4+yqOFbR2GHKVqtMJgmkwSD9Cal196YSSGL+BEXnDqddm0cLVGk=
X-Received: by 2002:a05:6402:2804:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a5df5af56bmr7522991a12.1.1787743157945; 
 Wed, 26 Aug 2026 04:19:17 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 10/28] hw/ide: migrate the logical CHS translation
Date: Wed, 26 Aug 2026 13:18:57 +0200
Message-ID: <20260826111915.3387926-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111524.3383479-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=den@openvz.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 28219f5ef8..b074325afa 100644
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


