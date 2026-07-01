Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B3FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2S-00037R-MF; Wed, 01 Jul 2026 06:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2Q-0002us-Jb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:26 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2P-0004oH-1I
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:26 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-13b32f48e98so180520c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901164; x=1783505964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UU23G2QNNzv9k+7lsmvy4EtEqmdRUwkuD7RwIDHNhUE=;
 b=XKEV4Oegd6HLuF57DL4AKGU99ZCtEYHAnCj1ZTj8nT+aGipSmswyb4RhUerF+yI5qm
 Y/XkY6txYzyouAX2M0Xn0FLGt3Aj8YdutTQuvJ4FAfN+8IYNNDw4r31wm7W2+OlAEcOu
 Y1WLpFEAs6uKZZ4z84YwNg8i6siC8AkcX0eJkNXSXdzIsRotIohyyg2Y5L2Ah8dQvtgy
 jaI4cyIuKTtZ7g58fcFCEMqrzQ98U3bcR9TGxLgAZvOE4X89wnES5Td7EzNQPzUok8hx
 QwGr7lAHm/vQTTH+cRWs69uVqXtYIn1PSfFRQYVfscZS5cjGCWPAU7r4e1hTOWeAUKGh
 I94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901164; x=1783505964;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UU23G2QNNzv9k+7lsmvy4EtEqmdRUwkuD7RwIDHNhUE=;
 b=oLiU121JmFX1c2c8uoGVB99yEizLuYb7QN2Csb4FdhhSgu1TTNhbx6ep7ZFIynNh2i
 BiANRrnsrJvwwEUWWs91l4Q5qb+jFbKL184cEUwyq5v7j335ZeTjAs4DESZPw3R6lYNa
 qLZHivwivFBgf9NIFciu8Fwd4naGLD+A/czL+dxucoVtfkgiVELpiOyQmNBciRji+SkM
 wEB7JuWZwsvXykjqJTbre0RCT6dENV4ekKJNaMSysdzaRHsqMrwsFlTt3C2c4KXsk9K7
 M2K4LozN4hy+WINe6+5NWIcMntykJ9E1xnZGI+50ePqfo8n+vP9U4QicsfRu9dKZnyDK
 cJrw==
X-Gm-Message-State: AOJu0YxcnWOQWYksKTOydxyCbrnbikZKHUcb44udJ2tA2HP9aMcp2H70
 27fMEfsiQtvbsO8jWciodWhZKFeliMElTtMDXqq3GSfPiHYo+SGKlG9wYFu+fA==
X-Gm-Gg: AfdE7clxywg23JassAj55zfraje8X+2W3p1r/BWwFmGOKYrx5TlI/I/zqjdnQ75kYdq
 zySecZvIAMkcBjPB6osnBZSSlXxQfUQW0farPGkyF+0o9j+bHqA56GVXYd/UC5O0qcUQe0EpQ8G
 Pm2Py1UrPtEdYae+5C6631YVMg6DX7kxbVyUQb7aSiFcJ5v9HEse6XEAZUyTsWwLseHCVeNkwIg
 YsDDOgl2yzHgS/KO9dBX41z79cDtZzi9IlLrAp0DmpQ+3um/CI04y59E4FKhnnTIITosqKS1EzO
 Z6LCRSLeptQg78G02CXbIG9dDgburoSmY0glzh08vL8obWGU1wgXJBBMsK4B4VeINB32pK1uPrD
 Xmqrh19vbihiGZ0PlK3JKbqC2ZKoDoRUirwYPMXAto3kR5tMXlwfruHYoQ4swQU56XVs8m1Fqmt
 l2VATSmOVP+RDKR3uzSgu+eTCBKlXXYuE=
X-Received: by 2002:a05:7022:78d:b0:139:ed5d:5ca8 with SMTP id
 a92af1059eb24-13b39153118mr200421c88.49.1782901163488; 
 Wed, 01 Jul 2026 03:19:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Charlie Jenkins <thecharlesjenkins@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 25/39] target/riscv: Report QEMU CPU archid as 42
Date: Wed,  1 Jul 2026 20:17:38 +1000
Message-ID: <20260701101752.2522962-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1231.google.com
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

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

When a non-vendor CPU is used, report the archid as 42 which has been
allocated for QEMU in the riscv isa manual [1]. This can help software
check if it is running in QEMU.

[1] https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260625-marchid-v2-1-3821c351028b@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bff3ed5de1..de94f5d57e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -47,6 +47,13 @@
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
 const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
                               RVC, RVS, RVU, RVH, RVG, RVB, 0};
+#define RISCV_CPU_MVENDORID 0
+#define RISCV_CPU_MIMPID 0
+/*
+ * marchid allocated for qemu:
+ * https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
+ */
+#define RISCV_CPU_MARCHID 42
 
 /*
  * From vector_helper.c
@@ -1204,6 +1211,10 @@ static void riscv_cpu_init(Object *obj)
         mcc->def->profile->enabled = true;
     }
 
+    cpu->cfg.mvendorid = RISCV_CPU_MVENDORID;
+    cpu->cfg.marchid = RISCV_CPU_MARCHID;
+    cpu->cfg.mimpid = RISCV_CPU_MIMPID;
+
     env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;
     riscv_cpu_cfg_merge(&cpu->cfg, &mcc->def->cfg);
 
-- 
2.54.0


