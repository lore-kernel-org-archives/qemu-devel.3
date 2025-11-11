Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7756DCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vItA2-00089L-Ef; Tue, 11 Nov 2025 13:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIt8C-0006Fn-60
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:30:17 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vIt88-0007t4-Cy
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:30:15 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-782e93932ffso14941b3a.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762885810; x=1763490610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9kMTzoN65dlain1bTNm87ZDV/HJs09TZ+pMQRYsBP0=;
 b=d6TE/NQqVGkho+/X7wFJHxKCB6uOPw5uz7jqvkkKSp7kumoWSnWADJSlk16fzXj6J/
 YazgumkjV+oa7SCIGazu+9y8aj/2LMe7sSBallTr8xgi+WauovOsYXf/XflAljIzqnW5
 8gCVDTBjf3cOOu/mIU6jBEWLxhrDOaIzHKiKMoboDOB3tb2ud3qUcJfekY9wuY0WWx/k
 IUqjy4oahSAdKfvCgTLczROByZxOvn446g6t97rSUXrowVRGSf91dn/2Ji9lrRbhq2Db
 lllt4nXN5pANXH5hrEM9aFXsHMGSJ36pwcsu8iZZc1T+8CZBQb9Okd3aijutXZY5BC43
 PANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762885810; x=1763490610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9kMTzoN65dlain1bTNm87ZDV/HJs09TZ+pMQRYsBP0=;
 b=LX2PpaEcjOT/EZPCXtnXzAeUlV00sBu7PPEKqY/EEus7FARU5n16nvPfAO6OBkM57w
 zDwu0hDkFTtB49hrBItCdKVKoSbfyx+7qlNpUdiL2p29VKWvefwCwfpcnjczOFan2HuN
 t6DXKwQOaem5D4IsAszzKESt3vEgP4j7+4aTvZAhP/gZDcBKeWGDtsBGHlPmas0qIFui
 3PbGmwDRZxSyRr25T48OYP76O+EgV+ax45TNOY3ULFXPK0TDRxS6t2Je/tj8gt0d742K
 Af/Rk02XVXnQYNtQxJKXTbWtcRsXXzdSfnMlt9aESELjLOOjLBrSDBm/QDCNIiDCjkRY
 20CQ==
X-Gm-Message-State: AOJu0YwaVgpcME+swtkxS9AAV/GKLyGsMAFna86Lmu1eggOx6g2jrFrH
 rwCU6liUfjSgBEtGhTt79WStwi2K8acswn/o1F8ApuVfty4/e66iMCeJYAg1qOKXoT5olVlo+h3
 ivmwXMLQ=
X-Gm-Gg: ASbGnctyAf3ifUJlJsfsjB/x3I+o04ZkSKiAPE8sKgMGTn/y0rvH97KN7u/zCkaSK46
 E2vrwgOLEUTSP7MDh6L30aITbp+BX+uDLg1S65ChaBU5oS70jigdQWtxHImahn8nJ6SjBtKzisf
 PEbJBIsiwREhI8DKagpzhYxjduwCIUB3rmtYXJk2JoZciJap4HeicMJKtc82QjJmWUQDsOAo1wK
 J9D3Oqu8KoLzHOhGKvGTw/BX6q6BpfcD2RU8UE6ZBQ9fHwnKongR9BXBa22/CrJr8WBjaPU2Rl9
 t0GNu24UuM/oMN5TKwLLH9EcAGXKBn4YWYG3dDKn0Z3aVlAX0lh3356qilDZoJHxcQY2go2+jD8
 cPvd4kYgj9DWnzvT71J5m9/P4GyQCFNmn1F42p2FSNdnhYT9NECvhNV+loQ8WoABcPeSvI3O2/E
 ZyWDn3BKtD26+rHBPMyEXhs4hFgT0=
X-Google-Smtp-Source: AGHT+IEtZlNC4h6GQPwETbNQjISmZJs5gOlHG2HXdbnynyvy/i7dGdQalKkNAEAMbXnoIvYdVC+eRQ==
X-Received: by 2002:a17:90b:4fc7:b0:343:747e:2cab with SMTP id
 98e67ed59e1d1-343dde07e6bmr308851a91.8.1762885810096; 
 Tue, 11 Nov 2025 10:30:10 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c2ffdecsm15207419a91.2.2025.11.11.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 10:30:09 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Fei Wu <wu.fei9@sanechips.com.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 2/5] target/riscv: Add server platform reference cpu
Date: Tue, 11 Nov 2025 15:29:41 -0300
Message-ID: <20251111182944.2895892-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
References: <20251111182944.2895892-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fei Wu <wu.fei9@sanechips.com.cn>

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support, plus Sv48, Svadu, H, Sscofmpf etc.

This patch provides a CPU type (rvsp-ref) to go along with the rvsp-ref
board.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Signed-off-by: Fei Wu <fei2.wu@intel.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..07e96a14ba 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
+#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 975f7953e1..3ddb249970 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3305,6 +3305,20 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSP_REF, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .profile = &RVA23S64,
+
+        /*
+         * ISA extensions
+         * NOTE: we're missing 'sdext'.
+         */
+        .cfg.ext_zkr = true,
+        .cfg.ext_svadu = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV57,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.51.1


