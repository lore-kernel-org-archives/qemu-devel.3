Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4615C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6ii-00007K-Ub; Mon, 03 Feb 2025 19:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6ii-00006G-0h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:16 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6ig-00073j-Hl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:15 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436249df846so34231665e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628593; x=1739233393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xv7ipWNRcN94Y6xBwaNhx1NocVKRwkP8HpWZV1TV6v8=;
 b=YQb49VKlfFoQKQJXUnmUnn4SJYX6Yaef9mri4ah1sZ8d9AtIKnmsVwL3earvL1NtdJ
 ZMWNcUzRtg4L1NwCp91QA7l0+tCt89Zc2r+Zb71HUEqzuIGGdT+7c0z+vDQxFIvtQ2Am
 QvHzVB3E2/UqCeZ6hjnOr+QPrMz41ZZfzpLQaibTIbnKLCxx1ddWoQ/JJs8SFuQcsfrr
 fiu0VGMLetMVAVbOOgsBkwVDqoS4g8N1ol5kYz5FmOD1JNGxzL708zxfMjKm3bfQ9R1K
 pWfvki+bqHlf8knQkOxaaCw86XzBklpup4vZA4w8Z/QyD827EoYawia0qdF1ZkSBGVwN
 i5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628593; x=1739233393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xv7ipWNRcN94Y6xBwaNhx1NocVKRwkP8HpWZV1TV6v8=;
 b=CGl10mmoje+UukE3lH4JKJ933sNlbM9uE1lZfPkUvJ423udVH19fYoT1Feaa7xpMuZ
 ru1YZDr7BIAy9AIOa6+za7/LYGNAuca/JOFXe5CHAUy/uFrUvjBIyQToR6wtlXUUNljq
 KtpNsulLIqgnOi+8dYaZbwdexS1AKp7UqaQG9wJMOEU6eHlVeDPye44Py904uVw0eiS6
 B8PLe4gXkP/3hLkJnmEeYf/7GRUkFDAKer9wbci3fL9QfFwgT5dDBtkIY91XCIWhs+y5
 Vq+zR+o+wtLnA5nLASjsZS9Y+og6HfRCKkmI3Evhn7B/VfpA9c6Etz4i4Tl2WuA+V/hj
 SAww==
X-Gm-Message-State: AOJu0Yxc/fsVgA1ZeNvi0o6MeRYe31Hd5FyQYrBHFWPaiLLv+fohIxo3
 818bisE1Zof9M2AKwg4vRLobwAtOx+jiJGIjmKQknpytgI53cgFg5SGQfEGp+Uv8BdOr4iVb3s7
 nz+g=
X-Gm-Gg: ASbGncswBgNrad3OaDl6/KXKd+tONJm5jpQ4dYxlsktjSfXv+4WQKhYf7yudKzGW/VF
 TmbN9DSRQ9VxtgeGbVqDbTkjYgqkjNG3VSb86uldRjaPMlYjPDu7UYUaXE097eBVHzw5hJkxt57
 ZIdPUd2CDb8bWDucf1Vg0caxruziGwBTf7azoY0dMA/4A6RtpXZNuLAgy+GN4P6etq67EEbw4Nh
 Dr6ZBzImp8L3s2UO2N2ZJnnkQwXbrfvO98XmCjIM+arhPH4W6ypns0nosXFRRIhPAyYdMlW00eJ
 wv+1e2JZhEY3poxzLf9JI4zz4lmkgvHMKJZUZr8avxIGWL3mrWW/zBUE7G4S42O4Tw==
X-Google-Smtp-Source: AGHT+IEShj5+5fuL+Ca7d6FxwDebMD6TRS7A+W6gouISzty2rbwluQWaZ7ht+ESAAxKMO6d+ZuQ0Ew==
X-Received: by 2002:a05:600c:470e:b0:431:52f5:f48d with SMTP id
 5b1f17b1804b1-438dc436f30mr214083465e9.31.1738628592858; 
 Mon, 03 Feb 2025 16:23:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390692a4bdsm3295685e9.0.2025.02.03.16.23.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 05/12] hw/arm/raspi: Consider processor id in types[] array
Date: Tue,  4 Feb 2025 01:22:33 +0100
Message-ID: <20250204002240.97830-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Expand the current type2model array to include the processor id.

Since the BCM2838 is indistinctly used as BCM2711 (within the
Linux community), add it as alias in RaspiProcessorId.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 571b50bef7e..1a6a1f8ff22 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -70,6 +70,7 @@ typedef enum RaspiProcessorId {
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
     PROCESSOR_ID_BCM2838 = 3,
+    PROCESSOR_ID_BCM2711 = 3,
 } RaspiProcessorId;
 
 static const struct {
@@ -82,6 +83,30 @@ static const struct {
     [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
+static const struct {
+    RaspiProcessorId proc_id;
+    const char *model;
+} types[] = {
+    {PROCESSOR_ID_BCM2835, "A"},
+    {PROCESSOR_ID_BCM2835, "B"},
+    {PROCESSOR_ID_BCM2835, "A+"},
+    {PROCESSOR_ID_BCM2835, "B+"},
+    {PROCESSOR_ID_BCM2836, "2B"},
+    { },
+    {PROCESSOR_ID_BCM2835, "CM1"},
+    { },
+    {PROCESSOR_ID_BCM2837, "3B"},
+    {PROCESSOR_ID_BCM2835, "Zero"},
+    {PROCESSOR_ID_BCM2837, "CM3"},
+    { },
+    {PROCESSOR_ID_BCM2835, "ZeroW"},
+    {PROCESSOR_ID_BCM2837, "3B+"},
+    {PROCESSOR_ID_BCM2837, "3A+"},
+    { },
+    {PROCESSOR_ID_BCM2837, "CM3+"},
+    {PROCESSOR_ID_BCM2711, "4B"},
+};
+
 uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -110,16 +135,12 @@ static int cores_count(uint32_t board_rev)
 
 static const char *board_type(uint32_t board_rev)
 {
-    static const char *types[] = {
-        "A", "B", "A+", "B+", "2B", "Alpha", "CM1", NULL, "3B", "Zero",
-        "CM3", NULL, "Zero W", "3B+", "3A+", NULL, "CM3+", "4B",
-    };
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
     int bt = FIELD_EX32(board_rev, REV_CODE, TYPE);
-    if (bt >= ARRAY_SIZE(types) || !types[bt]) {
+    if (bt >= ARRAY_SIZE(types) || !types[bt].model) {
         return "Unknown";
     }
-    return types[bt];
+    return types[bt].model;
 }
 
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
-- 
2.47.1


