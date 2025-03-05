Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716A9C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdx3-0001Ta-2t; Tue, 04 Mar 2025 20:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdx0-0001P9-Nw
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdwy-0008MC-LV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22328dca22fso94312025ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139611; x=1741744411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/GPSEwp58vGbM9OWIiwI6PEo6VDjJTBjv2Albcbic0=;
 b=GOCHhFknPD/fOGOH63wWPMo8yBr1isHGKroKG1/Qj+5gxc28VReg57uLLr+/TWQpAV
 OJA+k/erdT+Q7gt4ti+yOe7NSmSQUEOPn7A1RkYI1a/agdcMB24JvvlO2I9Ax89DMgRx
 +cAOtqO61uhnRddeOYFMXGWy8X8KKsAzFZccALJuRQZafeigab41XlDCHxUqylbIG/Eh
 I2sgyqVBNcgXHWdNyS8Fgk1G7hWAW3BD4plWAKPrmTAuUK1BVMBD3JzpA8wYTninHPn6
 q5RRAFDGLqELqG7gFcvyjGvSUnmbkBPbF+9FOz4RA8ADDMnKQGh8+UEpXRp1vhC7WrBZ
 Kkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139611; x=1741744411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/GPSEwp58vGbM9OWIiwI6PEo6VDjJTBjv2Albcbic0=;
 b=PiA7FeOmLhPqimLxDdnKntLFS76czR7+USVeSUisT5KtjUF02Vt9f4DpP2GunTy9Kf
 /k0HYmTM0Mj7aW8c4m46+XlJcKs/d547unq2iE4rXii66qs6FL7qVh5hfMbeF4ZHM6M/
 RU6bAqPWVHcR+/8U2TGxR+z4i3kZTqVAl40HzaW5VZ3Z3oTLkWvZ2oZX10VrhdTeEJkA
 PFAVJkne/geyjYn16nPb88XouJzZ4PHfJIXN5dFbI07iQI+YRzfQxquOHhCb2csjpsEw
 t1WXgUdJa5Zr+eHPX4MGYPqY3OukotQ7/So6V1z1zLWymCf6rjMHONNjg14Wlc+mZurn
 z1Mw==
X-Gm-Message-State: AOJu0YyX71+ymZ5PvXrZTz/8+QtMpaPutsgThZBJLdspdE1ZRhLKJiJX
 p6r1SfblP1sFIMi1+zyxymTN8HyZq2ujWpMipE0m72vlUPI09v4aaRlHmOIfTus=
X-Gm-Gg: ASbGncujTmd1dlhH1mFPFB1ogihXna/fsWD8YFcI9szDp0J00Bs9d669t2LUdYQeIiv
 qPIBKlI8kcZ7XJWI6q7G8wqMbd9gQcOiCazGsYHV7/XE+rMGlW9wsLjMvZu/qfTSxv6sJDh4QtS
 IRcarizlgtOV7M/UYZYedQ5O6V8OcAzbIEvnv8aI4dSr/Ed7pIQ99CBAGeBIuFjxaQZvUc3ucYX
 lMXp0mvnGMZoRcYRMDx4IFKs5woREyf22dzotI4gixp4Q3eZgT19I/Ur7S1QsqwzK4n/Wvabju2
 wTlKllJApqKyunSWJEJN8psMRXmpFP9MNMuYY0uQHY97kcDO9DgmYcN1e3PbEp+qgMTvH0bI42h
 HD+sLebvd0nZ/+WXFFJuvg+IEwsjtLlEG5JFCGoWM/1ovN8ZqhZ0=
X-Google-Smtp-Source: AGHT+IELaGdZ4+7yHT16IlRLo6gLdp/8yiTQ+hfmt0QgZ/OqZCX0mLQ1Xgp34wJGTJoY60z+QKi0uA==
X-Received: by 2002:a17:902:c943:b0:223:37ec:63bf with SMTP id
 d9443c01a7336-223f1c992c2mr17514095ad.25.1741139611102; 
 Tue, 04 Mar 2025 17:53:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:30 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/59] target/riscv: rvv: Fix unexpected behavior of vector
 reduction instructions when vl is 0
Date: Wed,  5 Mar 2025 11:52:14 +1000
Message-ID: <20250305015307.1463560-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the Vector Reduction Operations section in the RISC-V "V"
Vector Extension spec,
"If vl=0, no operation is performed and the destination register is not
updated."

The vd should be updated when vl is larger than 0.

Fixes: fe5c9ab1fc ("target/riscv: vector single-width integer reduction instructions")
Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250124101452.2519171-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5386e3b97c..7773df6a7c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4659,7 +4659,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
         }                                                 \
         s1 = OP(s1, (TD)s2);                              \
     }                                                     \
-    *((TD *)vd + HD(0)) = s1;                             \
+    if (vl > 0) {                                         \
+        *((TD *)vd + HD(0)) = s1;                         \
+    }                                                     \
     env->vstart = 0;                                      \
     /* set tail elements to 1s */                         \
     vext_set_elems_1s(vd, vta, esz, vlenb);               \
@@ -4745,7 +4747,9 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
         }                                                  \
         s1 = OP(s1, (TD)s2, &env->fp_status);              \
     }                                                      \
-    *((TD *)vd + HD(0)) = s1;                              \
+    if (vl > 0) {                                          \
+        *((TD *)vd + HD(0)) = s1;                          \
+    }                                                      \
     env->vstart = 0;                                       \
     /* set tail elements to 1s */                          \
     vext_set_elems_1s(vd, vta, esz, vlenb);                \
-- 
2.48.1


