Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8BC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzi0-0006w0-L9; Thu, 20 Aug 2026 06:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhs-0006td-6i
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:09 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhq-0008Nn-5e
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:09:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso20744575e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220544; x=1787825344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mvbyu72RNCBKA30dtO0psq+nr2zGhTtycdQqI3vt+Gw=;
 b=egibajmtfmpvPdDxTh/OBfavbjozrOrsnzlNIvnqvzS5QcwBC74G/SFWIT4A8HdVK0
 QSK+KnWPZyV49vgTVZEcLhWl3ls27Uu1ZAkLQizjOmeTZsOqR6enUMaWrrgWcd5BUJz9
 WgFRdCx5L04PBX7ZWPmdF7xpUsaJJRDAFkO1+gxzWcVz/S5JRCJBo4U54phQTIsTaFKk
 s801wSB5mzO8JfJI02xD0vuJjZ2rMWloqyhSbF8HkbkWw3bDUpiP34DHTzzkq2Y14Y14
 qS7A14pSaCklBMLU1QglLk3ga5R67Mo43/5w9etzyCBK+I0hcNrBnMD1DqKB86HahkPt
 aaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220544; x=1787825344;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mvbyu72RNCBKA30dtO0psq+nr2zGhTtycdQqI3vt+Gw=;
 b=XW8Cgqe2sn0VjTf4KM8TJvof6yfrsik32/8ciFeH3UiD8GUkGa3+KCe4HF86hTH6Iz
 JGseLtI+th1J/fqoY3Ymv98jcpAiHcEMU1+8lYnZMQxY3Kd/TFDOF4E0NvOVtDGV2uJG
 IKgbwRgLWmrh7y+kQVknjwsjXvz4INybtB40cFVpbqrREb8YWA3IqV9JuBE6JH6b/WHl
 iJBAkF3bcs76SVyidyfuXl4x11cJD+/WF5zSV+v3nXb+fbJfSu5ppCqsCiqzjh+UFd2r
 e5s+fRaE/DiNmcFhgd5xR4MXB6+pCk5di0Xf+wKFfweCxFWVbuC8j2UIVM2N5JdCDQQV
 tEfw==
X-Gm-Message-State: AOJu0YzrLZEaSKzJ11tf5jKuLhhmlMbrtiBamyNvBcQYDdqroqpaB1u4
 /34p91OHrX03uvx3iGn5pof4oo91GsfF2JhLZ/mJNYnMmkspeM8ITRg6pVyKfirIq23aJoqzPY+
 xvxG7
X-Gm-Gg: AR+sD13mol90eJcN8TgNtpTjw+304dd3PhBcJuqcj+2ozGQxSuIvkN/EYLmzm5KrDru
 dEbyNY932gRT8WwX4a0PwVAJZ7KbQEDRJWGpQOwuyqarySCyARsFIehRQ/clQ0Yal7WpUWPHbv0
 +yYP3382qBVkXHhUFBOQUP720BkvKXlhgaHIyRSgStXSiGAp99BBZ7IGTq+yQWc7JAQMwZUadkg
 YYZ9Sj7Pu6UuQTdM90Vqv0/c4JpgvYcxPOrH7e8m6E7Y7p0GM8PJ7EykAdQYRucW9xUMMiWi6J4
 gXoZ5hRxauyM4q/H+RdB34E6ce5vt97LKxsHqeOn4Y0KF7kZt2juPGUXvdd3DgvSTkD3EouRwLQ
 l75qdyHcCK2/k/mNSIAPLdI++mjess0w6TpRO38lvRU2Fp3uiIY2EwyE/AU43LJzHcHOhNTyZ5F
 nJxtUg8MQ1+DXzh+OURUHJDmQ+9je097ptm/nCijh8dbC29uRnv8B7pGbQ1g==
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id
 5b1f17b1804b1-499aa1c7bafmr208408085e9.15.1787220544337; 
 Thu, 20 Aug 2026 03:09:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:09:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 10/17] hw/ide: migrate the logical CHS translation
Date: Thu, 20 Aug 2026 12:08:37 +0200
Message-ID: <20260820100844.411717-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820100844.411717-1-den@openvz.org>
References: <20260820100844.411717-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=den@openvz.org; helo=mail-wm1-x330.google.com
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


