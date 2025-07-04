Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D29C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLv-0002AH-PZ; Fri, 04 Jul 2025 07:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLc-0001rf-Pm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:53 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLa-0002hV-4R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:51 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-313eeb77b1fso801265a91.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627568; x=1752232368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6KX8jP7UkcyaoRzueCmnlg+C4AdUvngebBI+d4Y+5g=;
 b=Kw67Sy4Fp7UG9hHqQT5LxG8cZfA80Fk88HKdH//lwKRxuOv3XujHhbXgB2hBr0zFBw
 YUQXAb5ySkHNivqauRBbZkPGin7M5MR5IQmbesgus3w/k1mwrcAIe0vWpjVOhEajmLB/
 S+iMtN8bPlG+5gdR83wgjWcrEkpQh42KquCXEZzZ4ArZ1+8M1GWKj6tSGaiiGsPK4YPY
 Z7JrEGaFYleNt9HJTc1nJIbBhR3/7+E4Nl5kRxbSCUm+t8RnmWV594DgSNeRMOtIIls6
 A1QPkPOrVrAnZZHagO2AIVb01dOWmwV9b7fWGXwFS9D/ipZunL6K9u+7v7qN9qOlN0Od
 RJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627568; x=1752232368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6KX8jP7UkcyaoRzueCmnlg+C4AdUvngebBI+d4Y+5g=;
 b=exwllr3NvZSs+nPVwGivWloP6ioggtfLJayM6eH5lw4kmMy3ExuF5rh5sjZRoGGSL3
 ho0G2dt/oKBcSltVGqLlb9mPFj9Py4/Z7I8vcuy+vnObqjKLxSNPZiarp0Gv1ah5CAx+
 hkiqXsvWJc+hNLFn4AXstkup3nBtKb8gDHwNhNjVA2mf9+8hqHpWiLrOhpYK9GTQWVYs
 7UDHKNb6iTqdiJIFJkj8ZcmqDoMHE9bJIkbH/5tyW3m9AOKPZK37PD/kyoyjGwbph/jr
 UMbdYR6OkQ9snUDTfJhjSY3m2FcSuP6LeRN/hrKxxbH/awICmptMFu/Vxubu6r10ablm
 K4ig==
X-Gm-Message-State: AOJu0Yy9sOWIs1qjRQ/2S5ZjJ5JIMCqQXDkXA3t0hzIk8TnYtA7slPmn
 eiXhHgEt9ThovT6cBRYBXt2MHhaYhY0ui0/Tav/DZ/M10x/g9num6zKyVUO+0g==
X-Gm-Gg: ASbGnct42nVaXhOrqjo3s9dz9bsddDy8eyK2V5lxsJhlqqBo3rCSY5gDTafpUxs799D
 vducK+IHWeIOE7z7WfP/nxnWtndCYzur0ncy4VM8KO+n+TVHPt4KWXYBsexxxj2uERnj4vJYTcR
 Ds6vjoc6niGbDnxnavgrJO2ZUMTLOwgtWbsm9jlihtMbgj3WEWKIqXp9UUQ40AyVmNGHLtk8IoP
 L/jekZVmak5PreV27RWYrAvFirMnCXZhT9pEtFAQfKG5xk69h/wJd5/ohJEI8QNBhzihdtpwYSs
 M8AwEeBVa42di63yLGFS+2g3X04GrjlIZDbU1uK8RpYXd+JabEzWs/kQo69Il4HlZ8HNDtTNjk9
 hE0ZA2A8qsQ+BNvHQXnwKgnz9HCuAs8lsz5UIqRAwdVvFppOXtKimNqUgwmelxmTyMJU=
X-Google-Smtp-Source: AGHT+IGgRY28PWwgmSkXeDvpdbwEVulbOWWy5S6yZxXZsaN4O+fWEN98L3TDaBed9BrLfOS3QVrWkA==
X-Received: by 2002:a17:90b:2ed0:b0:311:c1ec:7d0a with SMTP id
 98e67ed59e1d1-31aaddba4a9mr2547159a91.25.1751627568232; 
 Fri, 04 Jul 2025 04:12:48 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/40] target/riscv/tcg: restrict satp_mode changes in
 cpu_set_profile
Date: Fri,  4 Jul 2025 21:11:33 +1000
Message-ID: <20250704111207.591994-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We're changing 'mmu' to true regardless of whether the profile is
being enabled or not, and at the same time we're changing satp_mode to
profile->enabled.

This will promote a situation where we'll set mmu=on without a virtual
memory mode, which is a mistake.

Only touch 'mmu' and satp_mode if the profile is being enabled.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Fixes: 55398025e7 ("target/riscv: add satp_mode profile support")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Message-ID: <20250528184407.1451983-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 55fd9e5584..39de32cf76 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1365,16 +1365,16 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
     if (profile->enabled) {
         cpu->env.priv_ver = profile->priv_spec;
-    }
 
 #ifndef CONFIG_USER_ONLY
-    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
-        object_property_set_bool(obj, "mmu", true, NULL);
-        const char *satp_prop = satp_mode_str(profile->satp_mode,
-                                              riscv_cpu_is_32bit(cpu));
-        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-    }
+        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+            object_property_set_bool(obj, "mmu", true, NULL);
+            const char *satp_prop = satp_mode_str(profile->satp_mode,
+                                                  riscv_cpu_is_32bit(cpu));
+            object_property_set_bool(obj, satp_prop, true, NULL);
+        }
 #endif
+    }
 
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
-- 
2.50.0


