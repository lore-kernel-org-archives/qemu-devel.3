Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADB8CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBPm-0005UF-Md; Mon, 30 Sep 2024 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBPk-0005Iz-OW
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:05:52 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBPi-0004Nd-N0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:05:52 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5399675e14cso520450e87.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683548; x=1728288348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke80z1hBRrKSp3+ZYDR0R7E2LnwfnPIGBFgkH62rA90=;
 b=C5r/7SiUMKdP9LYyE+n6etm6LGFye8mtX0VXb0DFgJIFs9PIgtq5mU1ANf1dpm+K0D
 LAAS/C+PX5qqkNiwqJlT8JJIr4r4qellVhVD+T3W6CKuKkZSAy0/2gtpox2SJW5MsMup
 x5okHDioBJcx9lmLVVEhcKe5z4WMnT6ihS/gQF82V1jABwn0N+T481LO0MUwSFXISiFx
 fEHE74zpJIoge0h/zLG3cvpdHApM62Z9CKIXJt64BcPuStZAL8hYgdDpo0H7GGQ0Ta4w
 6aiFeXR4BLa/cWnZ4gNfinRlnsLpcaaW4WAF2auqh+hdv9JLFRDTONlW1KVBwcYa6MdW
 7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683548; x=1728288348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ke80z1hBRrKSp3+ZYDR0R7E2LnwfnPIGBFgkH62rA90=;
 b=Y/bmhOWJbYA0ij3NSKu+ll8d8W5A5M7qZtvk/1t0M23/DSMCwMm4njdW/ePNTraL1+
 kncVFk7O0/CpTusmACMrJnDWghQr7jEQ4FL0Gq8IEWqC3BCbSs23NvO3PbdBIYurUZtB
 Ot6m4HRBAbuinHcIDptjA5GMxBrK/8zc/SD1tD98h+DCSF8lWJXk7xBpavUV73HKVlsg
 4AIMulVPGnPNCt+WePWQgOnvnZh1FDsckZYMdco9KJQZYz4tXVUc/ri+6ymlOoDDVgyq
 utc5PVAZe1smQgu/CbbPEeIdEnnwuc4bEAR45kMSub41sBB2mt0llUGisFTD/GelnXRJ
 3XcA==
X-Gm-Message-State: AOJu0Yyrv5e+mDaqFRrPKBNMBRDJrml8FTkyd6tbKjbDJLFVHxNb8Dkz
 lI/rFifzjIa+xAnVCa5PkLv6DhFpu/GaoCxjyWykbywFny4elh8DSikYPLib2/pnfTlzfM9xfCC
 K4Zo=
X-Google-Smtp-Source: AGHT+IEtjPiT/vdhmDvKy5kyiLLj+B2N3ZG+taBN5or5yvAqA67A1U8MeeGcBTLFaojCJ5TT1R8r8Q==
X-Received: by 2002:a05:600c:1d20:b0:42c:b6e4:e3ac with SMTP id
 5b1f17b1804b1-42f5840ceedmr70234335e9.3.1727681745463; 
 Mon, 30 Sep 2024 00:35:45 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e9025c517sm147896025e9.0.2024.09.30.00.35.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:35:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 06/13] tests/tcg/plugins: Use the ld/st_endian_p() API
Date: Mon, 30 Sep 2024 09:34:43 +0200
Message-ID: <20240930073450.33195-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Refactor to use the recently introduced ld/st_endian_p() API
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/tcg/plugins/mem.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f27..3586d05587 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -163,13 +163,9 @@ static void update_region_info(uint64_t region, uint64_t offset,
     {
         uint16_t *p = (uint16_t *) &ri->data[offset];
         if (is_store) {
-            if (be) {
-                stw_be_p(p, value.data.u16);
-            } else {
-                stw_le_p(p, value.data.u16);
-            }
+            stw_endian_p(be, p, value.data.u16);
         } else {
-            uint16_t val = be ? lduw_be_p(p) : lduw_le_p(p);
+            uint16_t val = lduw_endian_p(be, p);
             unseen_data = val != value.data.u16;
         }
         break;
@@ -178,13 +174,9 @@ static void update_region_info(uint64_t region, uint64_t offset,
     {
         uint32_t *p = (uint32_t *) &ri->data[offset];
         if (is_store) {
-            if (be) {
-                stl_be_p(p, value.data.u32);
-            } else {
-                stl_le_p(p, value.data.u32);
-            }
+            stl_endian_p(be, p, value.data.u32);
         } else {
-            uint32_t val = be ? ldl_be_p(p) : ldl_le_p(p);
+            uint32_t val = ldl_endian_p(be, p);
             unseen_data = val != value.data.u32;
         }
         break;
@@ -193,13 +185,9 @@ static void update_region_info(uint64_t region, uint64_t offset,
     {
         uint64_t *p = (uint64_t *) &ri->data[offset];
         if (is_store) {
-            if (be) {
-                stq_be_p(p, value.data.u64);
-            } else {
-                stq_le_p(p, value.data.u64);
-            }
+            stq_endian_p(be, p, value.data.u64);
         } else {
-            uint64_t val = be ? ldq_be_p(p) : ldq_le_p(p);
+            uint64_t val = ldq_endian_p(be, p);
             unseen_data = val != value.data.u64;
         }
         break;
-- 
2.45.2


