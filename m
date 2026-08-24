Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BCEC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNa6-0003dV-Cz; Mon, 24 Aug 2026 01:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYw-0001nw-Vi
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:40 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYu-00022i-TV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso2750249a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550574; x=1788155374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfECYY3QZRTyl/SOMv9+jWU3ydUdOrBVrmpFSQeHgA8=;
 b=lvSTiA7ocvo1DIrx2dPn2p6MT5KB1zGb2fNSepb6/Kk0SoSiny1DQ8VLaX105j7+5S
 Ia/JT66ILzjbQ2T5wYIPJcIc5wgqoe1L0ZuhhjwvjwXQesxL4idvGb2SqaBBQYcJhfB8
 PKHwXg5svHnW74Zzbjt8MjBw/wgCsYljfcodzHPRc/FZ+N7z4hTlpP48f9yxYRLOOHKo
 h7Oc32Q7VJhCoPnkCrPb6R364SB7cE6upJZH9YhKnxSdORJQGvwzJowZH5fK72H94h0c
 VhAn+AqlqZS8a0f5aHm1f7JxPG4kegDo4SG8GPFErSubLV44HN4Dyv50IueWON7n8zS1
 ckSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550574; x=1788155374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qfECYY3QZRTyl/SOMv9+jWU3ydUdOrBVrmpFSQeHgA8=;
 b=DqBWrjV2JVW1C2ocx//j8IZ0KoleTKyypY334OO6YShUBsafRc0gypTRYXf5R7qGUd
 5JpqEfoK3Aub/pbK6DSy4bIpEC4UZs2Rf6cZsR8DyfalRu8Qx7qkEoEYkkDKCqQmHA2N
 Wmlurs760zuJL9Ay8XKp3L4rXB2MFVb5GE5e8kw68+aNq3/+zUrSrY4RGJdtBIUkIgmS
 8RMRN5DPX59NtOR59bBSXBjHO/RABDnEeUo3dkYWD1TwPt2bgjpafB/I9Prm2pT8sZmr
 ooNxV8UxOdujyuiFB9+VZZOO+p6sd/kD2+jIvXyYhj9OuInFUgbkNIJe35vB4d7zNYtc
 iDZw==
X-Gm-Message-State: AFuF++mwWFNAzGj9oz2QJLs2/e9QWIniMVhdyKd1jveL1FQRqkf21+UV
 KQ9ZUnZCZsV1/Cr4gLRTQm6WhuYLoVp1Df7uiuUavBQOdUyZBDMdgPhZStUD1A==
X-Gm-Gg: AR+sD11lpNNJT244OuvjZ6+w2IObzXtuHkEYIzpLfQaLx2yLXS4tLxKCWT5RADzv+Lk
 zOJcv0/XYACGRCQeZ0twJ/eTaZXq2VzDOfhywEwiWSh/MotxSYI1YkI2m/PoU6aQlNWYSeOtCRW
 xkDCBvNu6U1JPzllj1iTKbugPsFtBF+lHrpLeR2KY9wjjZrKvO+WhH2oMEsSyZFoB+OSbYpahPJ
 8sTBe5bKiXLtW4W5XaxELjlxspFtFQ6cc8cDsAwTMEGtH3Lp9aho6CJmKlrdE/rAdRw8AZRyUyU
 vc4sVhKTx4tZg2uoAse6fh3oTiqTyAcDPVzyMElpMozfkB5NafW8X9NM9TOIs55YKV7AaiDsFoQ
 y4YCEuqrZDEWYNDprpc4Ni42x15DH8MxVkWVaEohoyoXLSmrDLaz49WZMh5OMnr2NMthHsyo8IV
 fX4x9HKiuT9IauJqTzu3nfjJCAdU/oVeLxteiXOkKt8mozxFKT82p0iojuOeH9zSygB6ZaVmDyP
 f+8dqut/1Xwi3zjlgUQado2HnYt
X-Received: by 2002:a17:90b:6cc:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-395c33d786amr46103363a91.2.1787550574495; 
 Sun, 23 Aug 2026 22:49:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Ivan Efremov <nendensu@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 24/96] target/riscv: Fix seed CSR sign extension
Date: Mon, 24 Aug 2026 15:46:54 +1000
Message-ID: <20260824054806.2790041-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Ivan Efremov <nendensu@ispras.ru>

The SEED_OPST_* macros expanded to int expressions. When
bit 31 was present, converting a CSR seed value to target_ulong
on RV64 sign extended the value and incorrectly set the upper 32 bits.

Make the SEED_OPST_* constants unsigned so that CSR values are
zero extended on RV64.

Fixes: 77442380ecbe ("target/riscv: rvk: add CSR support for Zkr")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4121
Signed-off-by: Ivan Efremov <nendensu@ispras.ru>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260802113130.7818-2-nendensu@ispras.ru>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3f146a43fe..c01050ce2b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1086,11 +1086,11 @@ typedef enum CTRType {
     (HVICTL_VTI | HVICTL_IID | HVICTL_IPRIOM | HVICTL_IPRIO)
 
 /* seed CSR bits */
-#define SEED_OPST                        (0b11 << 30)
-#define SEED_OPST_BIST                   (0b00 << 30)
-#define SEED_OPST_WAIT                   (0b01 << 30)
-#define SEED_OPST_ES16                   (0b10 << 30)
-#define SEED_OPST_DEAD                   (0b11 << 30)
+#define SEED_OPST                        (0b11U << 30)
+#define SEED_OPST_BIST                   (0b00U << 30)
+#define SEED_OPST_WAIT                   (0b01U << 30)
+#define SEED_OPST_ES16                   (0b10U << 30)
+#define SEED_OPST_DEAD                   (0b11U << 30)
 /* PMU related bits */
 #define MIE_LCOFIE                         (1 << IRQ_PMU_OVF)
 
-- 
2.54.0


