Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D71D69113
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfGb-00056P-Bm; Thu, 28 Nov 2024 09:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGU-00053j-PA
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:11 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfGR-0005kV-Kw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:04 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21263dbbbc4so8496415ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803182; x=1733407982;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4JUFLTOJhJslmXjXCGh+2VEFVmYCejzSQzv/yR+Yn0=;
 b=vIkFETEstjkOlotQ7m8WscOZeWQd0wUhXoRCJVt7MnxHfzMU4R/wuVJHnzRrNbOFs+
 0CZGGhD3NBlka+OxSxst3ZD0z6e/Trz8omCHXqnUYtD4rA2GZIw2kVxTwmLVajJ3g6zK
 qnconk+tf/JhHiT3wt+Hd2mq0inrXXZ+3cbFxBEDurE9Zlxajk+krpZsV01TeIr/0GjB
 ZmQLW6MCRip15rY2VNRW926oj+NE9/T1Is8JiX3ZG5W3bUCETarI42CbnnubBAAssfRX
 NomHEnhl8ddJ+Ma/gveXciF0cIIX1KmkvE+7PRdPbX9BW5lk8g9ESaBWLCAZbuWmj6dF
 yzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803182; x=1733407982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4JUFLTOJhJslmXjXCGh+2VEFVmYCejzSQzv/yR+Yn0=;
 b=J44DqBGBBW/xD9XXfS7zQbLnpYcSzU+t8m8M2nNiRmYRZXfH0jIqXyFueES9FncGlW
 oAJVkedz3VSLI25awrNtD8MyyR6I4iDJMIzO2TGtyMTFMMAEoxp0ehBnsi88U8bGRHG9
 vSalk4gXydvqlKOn6aGeDbXPmaYRgp5MmrdM8q2/yLnSnfznViy+wjt9bZZ0NakIlej2
 EDi1gOQdTRDB/Ozjwvx3V72kQNj2OzdiW7epaGb6k+A3YXDJ/6HuvwEyH0k8aEGZwYo+
 ZzTvhq28JJGD6ui/KthkU9mEUehQJ72PtYkBS6EiySEAQbDPwMTJeN7mToG4WPg1FOU9
 AJOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYUgLRqil50bVFD+t/cV+7HS2wM2mp/FUeZGNdL1caMmnmek7zx50GtBJfwcyxZWV1TFelmrXqAG4A@nongnu.org
X-Gm-Message-State: AOJu0Ywc/GkjYKSHwKLi8QIWXf3sdb6U6Ir4PcvAPi+/pOR245nL/m1G
 bpxg4M3seynjTV4BCkv2H1whnCyWeOSke+zBSd3qhF+hori9Bl5Jupz6vmVyoNE=
X-Gm-Gg: ASbGncvpkqm9/mi7uCDoKCvdKquL9VHY4dYOesIjzXgr8IG6oHNRhnynxDC1nA40pLH
 p/mu13mYRluWY4OGq6rrblMOk1I4NBdPLUUggoemQ/j2XOOKgXN+OmP4XYAPcqu7vAaXlG6gMAQ
 3WB+s3Vz7WnxRf6dcBuQQPKgz+Z26mrJnFJRM9+BYoHOgBLPPyPAaDfSlXt8LAS+Afy6tDB0jkM
 zJjhScTTkhe+Efapbyy4I1+aRojV902hS1hmPdfY9lJRt7593Y=
X-Google-Smtp-Source: AGHT+IEBvrCQoPSVZ9VjdSgKjU7C86n9zuigE2JYsVRZBB5oQ1RemhVbYcsZR4FVdgb24Mqkqw2tiQ==
X-Received: by 2002:a17:902:ea08:b0:212:63db:bb15 with SMTP id
 d9443c01a7336-21501b593b5mr106675755ad.38.1732803182166; 
 Thu, 28 Nov 2024 06:13:02 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:13:01 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v6 1/9] target/riscv: fix henvcfg potentially containing stale
 bits
Date: Thu, 28 Nov 2024 15:12:21 +0100
Message-ID: <20241128141230.284320-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

With the current implementation, if we had the following scenario:
- Set bit x in menvcfg
- Set bit x in henvcfg
- Clear bit x in menvcfg
then, the internal variable env->henvcfg would still contain bit x due
to both a wrong menvcfg mask used in write_henvcfg() as well as a
missing update of henvcfg upon menvcfg update.
This can lead to some wrong interpretation of the context. In order to
update henvcfg upon menvcfg writing, call write_henvcfg() after writing
menvcfg. Clearing henvcfg upon writing the new value is also needed in
write_henvcfg() as well as clearing henvcfg upper part when writing it
with write_henvcfgh().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/csr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5d8d0d7514..98c683df60 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2383,6 +2383,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
@@ -2403,6 +2405,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
     return RISCV_EXCP_NONE;
 }
@@ -2414,6 +2417,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
@@ -2424,6 +2429,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -2513,7 +2519,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
+    env->henvcfg = val & mask;
 
     return RISCV_EXCP_NONE;
 }
@@ -2546,7 +2552,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
+    env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.45.2


