Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A05E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2c1-0006ff-Ec; Wed, 18 Dec 2024 17:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aE-000441-Gf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:00 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aA-0003Tw-H6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:57 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-215770613dbso1239555ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561111; x=1735165911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpxyP5OtZx1/7mNrIEtgT3kG1pw2Ci9w2qc+YV9JYFc=;
 b=ig5FXi29SOx1FMnfILXHtcdujHJ3WElYc5o/leBNU/qU+CuMItL60hKninSJCa2CkL
 oYVT876MAUdZIDuOrhuCtDMEpbwtt72d6YPOzdHxQ3WoOfDdcRJd94kGbA3ycBm78OVB
 h7MqIkll0tqbeA5OUwwPiig2mV4mMVuyWEcbLQ0HqOWXRSFls9FdeFaO7+95F1vb1/Iz
 /g4XYZA2u1Kp38INV36MvS5i2PZj0/o/hxGg8lflgLXDai9zCkw9Rn5Z0VzY++A0H1PN
 DiEBEMbxSIoApM7Ga5Ib0MWqYjfx6NMp5pNTp57/pFCkTgxrtp778azrWPv3NJKJARgc
 Ab1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561111; x=1735165911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpxyP5OtZx1/7mNrIEtgT3kG1pw2Ci9w2qc+YV9JYFc=;
 b=qJ4pSZg9WCAqpM81ne03ZzT33XytSBfEA9uBtnYyjbr1crQ9msPPkyQJjZAuTcB7cS
 OkXK5nGIr12DBvN9iikoPJw6wGIwZq9Hi7GM9eYUKCRxald+sCUtD5wwUrKRaFK3K5s8
 Gyhy3+zQShaTpIXOPWupxHb0FHWJ6xl5Qy5MDk3JtuVwh5MvQIegfOM8hn6uBg0VoRxc
 H88CSM3Zb+cPVzxNMdj6zatojpIVreH+/jmBcRpshbUpVK2gDWBNhMYW0vWc6CxhRfoQ
 w9Wb2H9E40GXma20o3+0hn/BXB/p3e1PYaOGf3qy6wHBm97MZVSS8wnuYYK1Qkhphoka
 JrNw==
X-Gm-Message-State: AOJu0YxINTHgj8CttniI2G4mm51tZxNwHDzNpuO08Z5/OE+GG7+HOqAE
 KH44BvwIXJEBRiZgjIZ2D1UVxniaf2XigDZ0hiQeXAeR+GFcecjg+WeBhJJe
X-Gm-Gg: ASbGncuZX2P5v89svn5P5UYmVnuIkqfiGL4BG307kr/F/MD/no8/CfyLB+QcL4Dsn7V
 0Fj/HJENfpcSbSxDK0pn1fmm8GLNMkBgNOvgY+VtIo2rnp1KE+g2+Syvsx1e7iV4RXo23TOihwb
 20coNm+06OcoGJMgK+OevPAo/l9jIIsqTCafvcSEYZFXRlvu9A6F5BsdGGPKlk7CzJr5hPNduKz
 AMBeYLOArejJlWeLA2y3Sy9F7dzsi/OZEKGCWbFpNXEC0QBL1op99Y9NCDWHg696cqD+k89bhyl
 kdkTe2+rsV0TKR4wUFD05EijPIe6+X3FLfX6sqOX0VmxbWK4pTMPVG9b1Hz/vOM=
X-Google-Smtp-Source: AGHT+IGd2bS6tkivm0DDO4XCSU3CnWu3XfKpOFdFtOzIceI0e4H5HBxt8HNy37P0dQID1G6rcoRhYQ==
X-Received: by 2002:a17:902:dac8:b0:216:50c6:6b42 with SMTP id
 d9443c01a7336-219d96c4ebdmr14644855ad.56.1734561111644; 
 Wed, 18 Dec 2024 14:31:51 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Fea.Wang" <fea.wang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/39] target/riscv: Support hstatus[HUKTE] bit when svukte
 extension is enabled
Date: Thu, 19 Dec 2024 08:30:01 +1000
Message-ID: <20241218223010.1931245-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: "Fea.Wang" <fea.wang@sifive.com>

Svukte extension add HUKTE bit, bit[24] in hstatus CSR. The written
value will be masked when the svukte extension is not enabled.

When hstatus[HUKTE] bit is set, HLV/HLVX/HSV work in the U-mode should
do svukte check.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241203034932.25185-4-fea.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 1 +
 target/riscv/csr.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4b9f899217..fe4e34c64a 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -604,6 +604,7 @@ typedef enum {
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTW          0x00200000
 #define HSTATUS_VTSR         0x00400000
+#define HSTATUS_HUKTE        0x01000000
 #define HSTATUS_VSXL         0x300000000
 
 #define HSTATUS32_WPRI       0xFF8FF87E
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1936a6f32a..b6fa8ae53f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3540,6 +3540,9 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
+    if (!env_archcpu(env)->cfg.ext_svukte) {
+        val = val & (~HSTATUS_HUKTE);
+    }
     env->hstatus = val;
     if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
         qemu_log_mask(LOG_UNIMP,
-- 
2.47.1


