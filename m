Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B040C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbq-0006CA-0n; Wed, 17 Jul 2024 22:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbm-000628-U6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:03 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbl-0003SM-4O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-79b530ba612so84887a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268659; x=1721873459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MURTYc3GhQ8xUvt5I/QPqguLyHcGs+Rdgu0cao83RwY=;
 b=Pi4dwaa8o5ey8qiv15wReG+IAzV27kUNE4e62lSHn2hiypv2h0ASf30sUpK7y8wB1F
 MsncYK6cFLwAgQFJIUMu6B87e3EgK2Hqb2xQpf4tI62nvl1Y47GvMQWa7nRq6qgz0MUL
 0hsNfTv/2aLTCllwD8RThYu6cnngO60RzlJCT98DmhEtV14CihMy4g5FmfCBvK/Yc8kd
 td+sdYDWayfI66jtNU5kqaQONPl9b5HlR4+4ds9NoEjboxv1Z5EbGLkgy3mPSJFrublN
 5BX7AFxe7am3xxBG9b6MuqxAFRgaxfm9pJ0QOs65q9KQ7aCZ8QXoNHSBIP/siXR1l0/z
 L+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268659; x=1721873459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MURTYc3GhQ8xUvt5I/QPqguLyHcGs+Rdgu0cao83RwY=;
 b=MYOuRLipgw9Uum6iQeR59tKpUW6dhsHwfnmNWhZzuUK3ZQiPOA72boFo1pK9t1S1KE
 uur2Ac0NVFLxivcIPhOfTDsX4DD92yJ9rsXpuGju/DCXnoidEjAcww0iA5yY3i6L/3AW
 1Tc7X4f1u92qNvfdwJjfN6vVyvSw9j7bSMnovSdnYIx3Kb6k2Bc3A1sgv5NlAfEP0cRl
 FB99rB4hMNtw/MGLpR30wX+gyYFX9TkENconIMK7w+ovgT2JkznT8bNic7DGOUcXUSrL
 zm6tKVlGE6b+AWqu/NpH8uJLobsFWdhHsxxStcCSf+4WWEa8zMMFcktCYzEIG6HF4wEY
 mVYQ==
X-Gm-Message-State: AOJu0Yw0QjOO4vXYaA2OdaQgtY6cbwsdLSSKIj4xSu2WWpfE4kXWHg8w
 5zu/PYgHb8nVt51zYXs64Iij6IVuBkNywx8zpRpX+5oVg82+vjkdC/+/EKYh
X-Google-Smtp-Source: AGHT+IFZVuk1F8xbeETAKA4bOc3Z9OEy8NQTfWp0MjpiKC+RE9sg7yLzNd33gZHTL0kh7VjVBa6BSQ==
X-Received: by 2002:a05:6a21:6f02:b0:1c0:f1c9:6835 with SMTP id
 adf61e73a8af0-1c3fddcd3abmr4196102637.51.1721268659369; 
 Wed, 17 Jul 2024 19:10:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:58 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jiayi Li <lijiayi@eswincomputing.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 12/30] target/riscv: Validate the mode in write_vstvec
Date: Thu, 18 Jul 2024 12:09:54 +1000
Message-ID: <20240718021012.2057986-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Jiayi Li <lijiayi@eswincomputing.com>

Base on the riscv-privileged spec, vstvec substitutes for the usual stvec.
Therefore, the encoding of the MODE should also be restricted to 0 and 1.

Signed-off-by: Jiayi Li <lijiayi@eswincomputing.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20240701022553.1982-1-lijiayi@eswincomputing.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 432c59dc66..f9229d92ab 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3791,7 +3791,12 @@ static RISCVException read_vstvec(CPURISCVState *env, int csrno,
 static RISCVException write_vstvec(CPURISCVState *env, int csrno,
                                    target_ulong val)
 {
-    env->vstvec = val;
+    /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
+    if ((val & 3) < 2) {
+        env->vstvec = val;
+    } else {
+        qemu_log_mask(LOG_UNIMP, "CSR_VSTVEC: reserved mode not supported\n");
+    }
     return RISCV_EXCP_NONE;
 }
 
-- 
2.45.2


