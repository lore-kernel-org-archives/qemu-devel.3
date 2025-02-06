Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD255C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bc-0001u6-Is; Thu, 06 Feb 2025 13:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bX-0001r7-Or
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bW-0001Um-5f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7bt7RebNOzgP3cdASvIHwhn5WFSysOm0Db/LmQL+l8=;
 b=InQ7OIp1YW/xr9kObei7IQAGFVYp1ge+Drrjbj7rCZse3P3tk+X6tBaze4ScojOKMRAGO3
 C8ey4zuCo3+PcMy3uUJLbuByPxk72xweg9lBdk7PG6pgyc2fvi9HEg8+NSt+5yRoIKs6iU
 e1vJOwAyfS0nY/lk4Ec4fH0CHsCD0bU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-oIxild_HODiKlYv0LSUviw-1; Thu, 06 Feb 2025 13:27:56 -0500
X-MC-Unique: oIxild_HODiKlYv0LSUviw-1
X-Mimecast-MFC-AGG-ID: oIxild_HODiKlYv0LSUviw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38c24ac3706so801179f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866475; x=1739471275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J7bt7RebNOzgP3cdASvIHwhn5WFSysOm0Db/LmQL+l8=;
 b=Omy0zXIVFY52RISjCuQx7RO+DuAklaOWavEYJfqt7aYGg8DGhv5/ttCVWYxb0WnNfd
 K3n7LUjFAsFbN8G4AWWcJ57CMoQhx0NjVFRy+M7tXIaamYSmxdO9n8RBPqCFW1Qqt7/5
 2/bp/M0MKde6J0VhA+jxIVB4as7PPYpy885CMG/xl9c8huP7G41sdYtSygZ9InlSP33V
 Lj5ZfjVdd8RgwfgUm3uZFD5Ai3H6cQQCiW2/5l+SoDVzKYofoghocqNo2PX5BdB1Uil8
 kVua07JDLnSNjwM/fdgvXxiN589Nps0g7Y57/yWifZC+kPPD5w+P9cXxSBlh8yWgeC46
 LApQ==
X-Gm-Message-State: AOJu0YxB0Heri2VNFiHfHC84baPF1m/4ScKXx6sF1FyauhvCc+EVfcso
 4DPNBitsleTd7J7zZQkjEtnZcsQj3C0OG9Rge9pMwjxNORuofF+Py973GAmkikKDfeSebEDymxd
 KDCPlHkaJ23Qk7irM6DIMNWHTwu4H2F1x/yr+OfCVqelfNj8QzxE6BkJ9jldaDblDiIB1LYGb0a
 l9GMe7njoiVOLHWUZi2dX+jXWZ2w2ILiJ8vcZzI6Q=
X-Gm-Gg: ASbGnctxLeSP1Fg+cJoWWWaWM48oxyLYt1nqfit+eE8fA/TUNAR9exI7HHgd9bAP/VM
 I+IRegF0RXZCryOLcUgdCVoFJ0mAaPPDicKqPRHy24cfbvvMvSkoo63jwEO/UoPTVRK+b6klR5N
 O/LNBjYXWjA1Pr4v/eLl6hyEMczny5cfJszBsTh10CCHoZ86JbM0TovevbAhDDsF9Wb/0D8DuEV
 D90Ww07o0xN9oXToT9f7X/rJn+aqdOU9jI7dmRbmwdEOZk9u4+Ikd8ZdiEKmKvgmi7BzH16EASa
 AAKj2ys=
X-Received: by 2002:a5d:5f83:0:b0:38d:b448:8ffc with SMTP id
 ffacd0b85a97d-38dc90eec01mr33020f8f.27.1738866474835; 
 Thu, 06 Feb 2025 10:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzkbcYQaf93l9fGWaCxhmD/L/pjlBdNO8JU64gqlRixFqQIVNLLoASpdsEHUVmdku8OPY48A==
X-Received: by 2002:a5d:5f83:0:b0:38d:b448:8ffc with SMTP id
 ffacd0b85a97d-38dc90eec01mr33007f8f.27.1738866474426; 
 Thu, 06 Feb 2025 10:27:54 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc6b89ef5sm476311f8f.31.2025.02.06.10.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 19/22] target/riscv: convert Ventana V1 to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:07 +0100
Message-ID: <20250206182711.2420505-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 75 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b2b9b4f6e39..7ebf007c129 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,45 +485,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, RISCVCSR *csr_list)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_veyron_v1_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.mmu = true;
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.ext_zicbom = true;
-    cpu->cfg.cbom_blocksize = 64;
-    cpu->cfg.cboz_blocksize = 64;
-    cpu->cfg.ext_zicboz = true;
-    cpu->cfg.ext_smaia = true;
-    cpu->cfg.ext_ssaia = true;
-    cpu->cfg.ext_sscofpmf = true;
-    cpu->cfg.ext_sstc = true;
-    cpu->cfg.ext_svinval = true;
-    cpu->cfg.ext_svnapot = true;
-    cpu->cfg.ext_svpbmt = true;
-    cpu->cfg.ext_smstateen = true;
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbs = true;
-    cpu->cfg.ext_XVentanaCondOps = true;
-
-    cpu->cfg.mvendorid = VEYRON_V1_MVENDORID;
-    cpu->cfg.marchid = VEYRON_V1_MARCHID;
-    cpu->cfg.mimpid = VEYRON_V1_MIMPID;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
-#endif
-}
 
 static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 {
@@ -3089,7 +3050,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .satp_mode64 = VM_1_10_SV57,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEYRON_V1, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVS | RVU | RVH,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.mmu = true,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.ext_zicbom = true,
+        .cfg.cbom_blocksize = 64,
+        .cfg.cboz_blocksize = 64,
+        .cfg.ext_zicboz = true,
+        .cfg.ext_smaia = true,
+        .cfg.ext_ssaia = true,
+        .cfg.ext_sscofpmf = true,
+        .cfg.ext_sstc = true,
+        .cfg.ext_svinval = true,
+        .cfg.ext_svnapot = true,
+        .cfg.ext_svpbmt = true,
+        .cfg.ext_smstateen = true,
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true,
+        .cfg.ext_XVentanaCondOps = true,
+
+        .cfg.mvendorid = VEYRON_V1_MVENDORID,
+        .cfg.marchid = VEYRON_V1_MARCHID,
+        .cfg.mimpid = VEYRON_V1_MIMPID,
+
+        .satp_mode64 = VM_1_10_SV48,
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
 #ifdef CONFIG_TCG
-- 
2.48.1


