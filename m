Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FF8C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQHa-0006o6-7m; Fri, 07 Feb 2025 10:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1tgQHP-0006nS-J3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:28:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1tgQHL-0001J0-IF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:28:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dcab4b0e1so656290f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738942105; x=1739546905;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YNuSvlIi2eH0IATCfdiQOsDtFgKiJypecWcAgoJwHY4=;
 b=y3jEncWiQ+UtL+QDuKvJ+ru70LeY9MoWj68FSA08M604RC963yOJt3/iczRyEHSP32
 3asgaLoQLIxh/W7oG3na9AdkYeB0t3a9ESaCeUmHnXRnj2Prc7v9rxAHWoHex9LQ9JkE
 ZxmNxcbEjITY1MVCJ3Rw4kXZq7dNTm3n2GyhEFcftM+KUh3wKkhkBALvXOzm37E654Ze
 zSSS5m7mb2s1CYIr01TtpOcfWMfEqU3Fm12z8RqwKU66guzyunFex6RWjNZeNBA3Y6iE
 pP9a+Zr3DoDG/FLXpDqEWXOMEcm5lVB7plKIerydZRtw1NgrgDh1hEIcV7XREdmGYGkE
 ZY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942105; x=1739546905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YNuSvlIi2eH0IATCfdiQOsDtFgKiJypecWcAgoJwHY4=;
 b=RMNvqKIO5+cihuJkWfvsRTxwwXsDr6EdNaa42Nt2vrV+Cicm+wkYFvYrSlE+7+6t0D
 4OcrRuHn0gpSuc6ZxUBA/fZuJR4Y1lOhk62KfYaOe+TP+YbJwZMDSyoK6vxgyUeM0vUB
 m5lnxNNCqHICX/cDcPf9+kZqfRmwI7+B7DK2qRdz7vLwoXtlskftvmHRe4FjcDarVQx9
 gJ2V6SeM5RYKVEHVSEiUQ0R37s/qDx5mmOXmhlSD/wKcFlO57puMiN13J78tje7A4dc/
 lN/iBToXc2oBKADHr2dRXLzf5HrkiudU1FcExvuayMmTzYdADd4Gt1u7CNDyLZ1R+jVH
 1xJQ==
X-Gm-Message-State: AOJu0YxH2wSq7dGx4jqYp2PRlNIQywU71sCZWMgxQZ7MHqn4K3kF9Bmm
 VGS41IusJ6ZtBeRiQ37uq9y9AuP0Qn29lS/dfECFAW79dQLctRXEidZTKMglIV1gnVSvisN3g25
 T
X-Gm-Gg: ASbGnctlQqlO0Jrk76DLmQJe/1kPL88cwoOU32plr8Lx/2NtrOxpgg5nNzuawV35O75
 mTQ20jqU29uqxoDXAdmGzpl6b5DzO1RqQnkKAXy7JELPbODo5GBSw33Vf03Vr6ADSRGGZviW4n/
 maz6XtXPaQH/cscEWyZM5ICob0msW8H+aJEwCSwHsSINjSK9B1eWexdXVx8Sl4sh/rEYpZjN6zy
 GGETt0jtFP+XP5F1tEG/Lvu/9XP8ecSbNJInR4ymYfKk22yZY+jCK9jCePfvBtp2Lq2BaCbyZkA
 lEY8+xOFczoVPgCpTdbeeBZR5xe7K902T7zkeNQhKLdV1MwAb78wzkSjiYootJEGejs=
X-Google-Smtp-Source: AGHT+IEqlgL2igzW+RGqkuKw0zFmkmZS7qpbuqrgKXWWoJf+Je0i/KOhxbHdhi5F4xrR3Z+AHIELoA==
X-Received: by 2002:a05:6000:1acb:b0:38a:4b8b:295a with SMTP id
 ffacd0b85a97d-38dc9101923mr2851991f8f.31.1738942104771; 
 Fri, 07 Feb 2025 07:28:24 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5839877sm3301079f8f.3.2025.02.07.07.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:28:24 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH] target/riscv: Fix minor whitespace issue in
 riscv_cpu_properties
Date: Fri,  7 Feb 2025 15:28:23 +0000
Message-ID: <20250207152823.265068-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=rbradford@rivosinc.com; helo=mail-wr1-x42b.google.com
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

The mvendorid/mimpid/marchid properties have the wrong amount of
whitespace ahead of them.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
---
 target/riscv/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2..cca24b9f1f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2844,9 +2844,9 @@ static const Property riscv_cpu_properties[] = {
     {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
     {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
-     {.name = "mvendorid", .info = &prop_mvendorid},
-     {.name = "mimpid", .info = &prop_mimpid},
-     {.name = "marchid", .info = &prop_marchid},
+    {.name = "mvendorid", .info = &prop_mvendorid},
+    {.name = "mimpid", .info = &prop_mimpid},
+    {.name = "marchid", .info = &prop_marchid},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
-- 
2.48.1


