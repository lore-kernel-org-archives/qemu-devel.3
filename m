Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4D7C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bP-0001Nm-2E; Thu, 06 Feb 2025 13:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bL-0001I0-Or
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bK-0001Dj-Bc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cM7JNJwSeGWDoIYZTZ4Zvcb/tG+r9uq48v256te/cKk=;
 b=LmEJ/KJLI1elOQ4FgzbGC+1BwOOe9Pm2LU3hLWvrEE6pzNvhW/L/O7Qc02+EOm896hNXmJ
 cAB9V0MsVPcW0SChwsdg0mjSByR/V5dVL5gne3uEfdt2HWm/JJx4AGgM1q71ZAXeofDRAo
 sZThq/z+5CReU0IoE9taWJynKLrjRvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-mniwpRCPMXm2cuDmof27YA-1; Thu, 06 Feb 2025 13:27:44 -0500
X-MC-Unique: mniwpRCPMXm2cuDmof27YA-1
X-Mimecast-MFC-AGG-ID: mniwpRCPMXm2cuDmof27YA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43626224274so7416685e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866462; x=1739471262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cM7JNJwSeGWDoIYZTZ4Zvcb/tG+r9uq48v256te/cKk=;
 b=YR9YW3CkdavBnQYuDL/ltjrjrm/sxhP/eFEuK2ydxw4zF8BTSrG86sR5M6qrjXXvim
 X0FMni53TTtUjbGPLlYonmA5pbrslgwEygQw1Jwi3sKIZ/vKEw8jN3EnQei3ZCN9FmX4
 FMFWlmh8UFxhpm/fuwgAp6Ka7Qzw60xrhNAUJmmVWORHA7GrF1KgAhcL15qi9UjHKIRq
 m+DYWdylQIQkp4IX0VG0cvPxF007l4zhV3tUZvLTminELY1/k9OMojCSxsLxU8tqQvSn
 ky6Q2fY7Ehe1KbMZJKw1BWVfCtmI0fAEzvTPDuq0tr/vK+AZUKvpDyC2EyUiDSpVSrdG
 qJcw==
X-Gm-Message-State: AOJu0YwwIHH23yFoDHDELx35QGPjWWKcpZLlhFRNcRx0sMQlW2Qf7CsK
 vU6cBdxO/RIS3el2WkMZxZaTHDrOGfZFsQf2LahdvqAyGqRD+Yu89CYSKn+LPqXXM049RaQiiOX
 wTIDIwkmswyHjdMQIFnP9xCQAGs19A5pvZpCjinzgEawHHvgZTMTk6aSIeOI4XPRN4jBgL9YbqG
 Fic/rbLCsEpGpIyUejM5+HZiV9IOrFgtdeeISq1wI=
X-Gm-Gg: ASbGncvRAlaBCjzuCRc90LkpLkyUmmQIul8xE4ViPn+ajzeiESSVuWHPAMTRE7WmifQ
 qvvJe60FMF96i4O9O/3E480Uj+jZNIiS2Dtxl2lBx1YY31XGfkipDJ550bYyMajgC0sA0X/IOaq
 NKOql8Rs2Zo87/ZOPJa2Bp/1W9U6OLKm5FlJclqifHBniqdo72tScRloP1WwlBzw9cfLgX1986y
 13kSKl3nN+quhrsTeGaG8GxiY3f+uw6pKmfCOzPJcZAyT8v3hYU0LYoTD4dd+deKpj3EDRQduy6
 oPZyn1Q=
X-Received: by 2002:a05:600c:3c9b:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-439249c385cmr3841135e9.29.1738866462469; 
 Thu, 06 Feb 2025 10:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELSxSf5A1j6D88ps+tF189RdUgec1FxTuWL2gDrc7qTLKOw5Z43sWg1MX84GKBIbv8fRykVQ==
X-Received: by 2002:a05:600c:3c9b:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-439249c385cmr3840955e9.29.1738866462079; 
 Thu, 06 Feb 2025 10:27:42 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4438sm64232165e9.25.2025.02.06.10.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 13/22] target/riscv: convert ibex CPU models to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:01 +0100
Message-ID: <20250206182711.2420505-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 target/riscv/cpu.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b47ca531503..a8aaa65f56e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -676,28 +676,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 }
-
-static void rv32_ibex_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-    cpu->cfg.ext_smepmp = true;
-
-    cpu->cfg.ext_zba = true;
-    cpu->cfg.ext_zbb = true;
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbs = true;
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3062,7 +3040,23 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV32,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI | RVM | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+        .satp_mode32 = VM_1_10_MBARE,
+        .satp_mode64 = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true,
+        .cfg.ext_smepmp = true,
+
+        .cfg.ext_zba = true,
+        .cfg.ext_zbb = true,
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbs = true
+    ),
+
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV32
     ),
-- 
2.48.1


