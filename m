Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06516C28B21
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdy8-0004tk-SB; Tue, 04 Mar 2025 20:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdy1-0004fL-6w
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:37 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxz-00005H-6Q
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:36 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2234e4b079cso115239525ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139673; x=1741744473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFAmqPRQPWgYFzdVLR2UUIxIvDBtzJRXuo2E2Y5DFx8=;
 b=k7z7d1WlLPQ46qzBhxYixcmTaGMGI4AjELu0asB0PA2R8WVfxsDlUnohjHj0yuRj30
 BknK1Rf0fUt59mhPHqo/5EEA6qf2S1NDsYR53pjmT5zRnaxJ+iy7UgBqRykCHrrz9oZx
 HIpVhVWr0JEzaBYZff9RQkiH54BLprrsmMBUVtGxNVq2cRCY441YzmLgjeLRIb/JTXnF
 Kn6WnPjVrliflZN51ngUmrTnmI7DGaFOfN+4hA+376+95B7Cj/NmqYjcsK7WAirjrvJ6
 aHtc219SFvklDhLf7zttt+Be03wPGL3gSUdaTR2g/SsFcn3Qe47fvGCyi0C0qhgUzjc1
 9tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139673; x=1741744473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFAmqPRQPWgYFzdVLR2UUIxIvDBtzJRXuo2E2Y5DFx8=;
 b=cNFarSjgyLLr4nq8YukCE05N6UX1G1KgQeUZBPZBMtiLg2Gp0zYzEnmIWAE1ZQyLVu
 EyRghy0cWTMkTSZCXs07LZlr2XnGZTsES/RjbHoxsrlybTgG2znF+9SHJYoysWP/AzWu
 GTtMoYL8cqPN8ZS3kb4wlwe4rjvdmKSha6eSRiGVlv/zmLGYgW1KGwkxslUS6ZsjU43K
 xRUImQHgcEJjCExwV2j07HL8Y9X4LKksy88wEEVE5+NK9Cm8J7JEorClzk32hGBOIXqA
 ib2uXxrYny90d9Ecwe30y3aHeSvePzUnTum+b0JU/h202RGH/Qy7GLvms/tGI+HB8ya7
 l5Xg==
X-Gm-Message-State: AOJu0YyGXXSzW4VNOi4xUWDmRfU1a8wYakqw4FC6NBkRmATu2jZAlDcK
 JVK8OA/Ox2+prUCplLOPmvTWozUizumkxTi19Z2+FVnFQBLVmf5agjHK3EtiopQ=
X-Gm-Gg: ASbGncs9mTsJJ0jr7S63HHlZ06x87G/QwZGb5H1G3ahODG8C1I8Q58UNKJEVdkLa9e9
 hJENuDyuu3RjknxJh7t9ZZXjxXzj04z6Qa1g1B8OscqOWp6CZWwN6hkQNMSirQB+Pw4xt10eqkw
 joATb+xrENsrp5h6JSLWDb+eLAMJj87+S98oeL+V9pWtayRe9dcVE9y0+LWwBvKavrG2JDaQOJe
 exx3Z+x9LCbur/1qmkaAlOfr80aoluJLV4RVe7iCC5GkndpuDTh8W87gYtC/IG8yOSkl9xavG3C
 Z7BgxsQU71BkT7Nyr08bfThqb5eStBWR2Lcdwrc8ZyhJNTC2R5BAPbzMbpqo3GvlD4CEObJh+dC
 2O+ft10gr2RFBCAt7VSo1DCNdWHIHY3YUL30dNYlP89c5R3dpo5M=
X-Google-Smtp-Source: AGHT+IEMl8z7W1Nra9VXDBSJjUfCIv+l/mQPbl+1k8uT9NKB2EQItUYQuTwkGjufTSoqgAzAWkq+AA==
X-Received: by 2002:a17:903:1cd:b0:223:4a10:311b with SMTP id
 d9443c01a7336-223f1cb2068mr21551835ad.1.1741139673584; 
 Tue, 04 Mar 2025 17:54:33 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/59] target/riscv: machine: Add Control Transfer Record state
 description
Date: Wed,  5 Mar 2025 11:52:35 +1000
Message-ID: <20250305015307.1463560-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Add a subsection to machine.c to migrate CTR CSR state

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250205-b4-ctr_upstream_v6-v6-6-439d8e06c8ef@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index d8445244ab..889e2b6570 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -300,6 +300,30 @@ static const VMStateDescription vmstate_envcfg = {
     }
 };
 
+static bool ctr_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+
+    return cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr;
+}
+
+static const VMStateDescription vmstate_ctr = {
+    .name = "cpu/ctr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = ctr_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(env.mctrctl, RISCVCPU),
+        VMSTATE_UINT32(env.sctrdepth, RISCVCPU),
+        VMSTATE_UINT32(env.sctrstatus, RISCVCPU),
+        VMSTATE_UINT64(env.vsctrctl, RISCVCPU),
+        VMSTATE_UINT64_ARRAY(env.ctr_src, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_UINT64_ARRAY(env.ctr_dst, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_UINT64_ARRAY(env.ctr_data, RISCVCPU, 16 << SCTRDEPTH_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool pmu_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
@@ -450,6 +474,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         &vmstate_jvt,
         &vmstate_elp,
         &vmstate_ssp,
+        &vmstate_ctr,
         NULL
     }
 };
-- 
2.48.1


