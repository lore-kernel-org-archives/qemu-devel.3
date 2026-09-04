Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08329C79F84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLP-0005QL-QP; Fri, 04 Sep 2026 01:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLN-0005Q3-5B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:05 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLL-00013S-Hl
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:04 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8525efa7274so455349b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499202; x=1789104002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+bb+95qH7qZRzLFgl4n5ClvvF8UbWewF7qWhEVC+emI=;
 b=CdLWRTaYHTAb5XDUFBQ4+wMz0A3Ip5PoksNfSBKeB05c0XtEpV8K2XoNRynPXtZYwc
 gZBGk7KGuIBMQM7X5WB3j/lUeZTezR636vFaCtFOLnIkMBg2XyloGxo/PnK17vOPs7jI
 Ka0sav3f+bEl7ysFtE5KfYPfB44++w8mltQ58C71d2mx9n7aszzhbaiCZNA9iHas1HS/
 qiBXBktRo3QujgkPmL4W32fakln/rKASZwssBbSiWuWjy7uZhIvsW22CR5FZ2L4W5wGE
 ZM3ymTD2XqBSygeW/czS6HhpYAVHhcNPJpakm7+q6goiezATuGjicLUe8hPdc6VgRK99
 KLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499202; x=1789104002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+bb+95qH7qZRzLFgl4n5ClvvF8UbWewF7qWhEVC+emI=;
 b=E7kcEeAmn5aPEM0d1H4JzRF0mJQ5acf0/t7KcVO12wDTNV1709CX+5JTE2fSVgL4lY
 SaNvV7f9M0dhK3QeMwkO/pMf8M+GAX5fBR0n4koUZid55vVktwsmECASSY47Btiu9fKd
 eQgcntf+t7niCBBlGclOdXNaZKzbBsTvsz3753W87wxC647sFpkLmbpgiji0QWjhPIwK
 dL13W6kRMDhJ4ToWj9EB4OxJr3tq9LX67RJ8mCo1mQQTZwCIStU0Ha4HnpsDyOtU9Pc/
 Y7JAPgUoWCo0namzZRjwk96WK1aCRnD2q4WHa8viQ0W6wbHx1NxPB5ij6nxQfpFIW5Vr
 TdAA==
X-Gm-Message-State: AFuF++mIjl2RyV2TihVmzDqvtywJgqjaieKZngHqp3e4B+0UVJlXKWWt
 yt3Jj09MBTgawTwXlPeiMDb/roPKtDcC/QTidnNR90TB5kllZYdem0e+2aCz1w==
X-Gm-Gg: AYBFou37xWphUTIcGgk/T0fd59KzHrIhu9jTjxbwTOD3H9KRXaRkLvDFkwvlyCrb8wA
 74IBDMyMxqueZV/xXBrZMk/KtR3qILQ4/EJ5Jy5aAqjvq+jrmNOPcFzaymgI7SUJ+WdRVwxXMwk
 fZ7jps98ENQTO959VbAKKPOCOI8Z8l1pwfYIG2PDWLCsTgjwctezX8GH/EXuzRTcWXBw9EgZBGI
 7vRKYqO9ehSpnakH/z1+h+TqgE+kjBznH1suDpuS11TvABROBJhOFaw7Y3oU8LsYXUt5k1sorg7
 GBmuxaryGWLG/1M1U/JerD46W/f295mJYBB/kPs4vHJIIYj9oa174cBh60VNHnF7OIPdMDENzS4
 Mh1bJyf3GWn8mWttVQd9zOpggMBfKhU4BaxLZSfS4rTI7wD9HS7WsTHzK6MCnvwSHqNfSedMe0k
 SYbjlYJZYoNlMDejUHAOOcl3+49b/+BdPGATn1vYBZ86u1wJkGpRlgMsOBC571An+8P+ZaLMfFd
 rMaFA==
X-Received: by 2002:a05:6a00:6c9c:b0:857:727c:a1f6 with SMTP id
 d2e1a72fcca58-8616997ee79mr5765512b3a.24.1788499202015; 
 Thu, 03 Sep 2026 22:20:02 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/47] target/riscv/tcg/debug: adjust 'timing' bit for Debug 1.0
Date: Fri,  4 Sep 2026 15:18:59 +1000
Message-ID: <20260904051943.799041-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Version 1.0 changed the 'timing' bit.  It is now bit 18.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260805182506.2943757-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.h | 3 ++-
 target/riscv/tcg/debug.c | 7 ++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index a25d099b37..eb635bc277 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -98,7 +98,8 @@ typedef enum {
 #define TYPE6_CHAIN     BIT(11)
 #define TYPE6_ACTION    (0xf << 12)
 #define TYPE6_SIZE      (0xf << 16)
-#define TYPE6_TIMING    BIT(20)
+#define TYPE6_TIMING       BIT(18)
+#define TYPE6_TIMING_0_13  BIT(20)
 #define TYPE6_SELECT    BIT(21)
 #define TYPE6_HIT       BIT(22)
 #define TYPE6_VU        BIT(23)
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index d40db381e6..9b2e5b19d8 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -584,10 +584,15 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
     warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
     warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
-    warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
 
+    if (debug_trigger_version_1_0(env)) {
+        warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
+    } else {
+        warn_always_zero_bit(ctrl, TYPE6_TIMING_0_13, "timing");
+    }
+
     /* validate size encoding */
     size = extract32(ctrl, 16, 4);
     if (access_size[size] == -1) {
-- 
2.55.0


