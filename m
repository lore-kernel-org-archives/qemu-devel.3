Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F60CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4u4-0003iI-Si; Tue, 24 Sep 2024 08:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4u3-0003dw-He
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:27 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4u1-0005u2-V7
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:27 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-848769482c9so1512623241.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727181864; x=1727786664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=677keSA/AToPRkUUTw9YbPGSGOCBACjoAMcuiE16UlA=;
 b=dm0wh8aJdkfcWN7bYBjIO/TIDxYEd9MRBoTfdPXGiKa2nWRUQdyESYWaR9l9txXMF4
 YSbt83i5BCJg7mAP90ZWQgCnAMlHi3M3gqiYNBywnFUYiHB310LWmH8hAkdnCgXCgAQq
 rpiJRW+GXReT5txj2UN0yuufigZ6Yyykmi172MGrLK+ukI61Ha/P2vNrx86bv6L3lWTQ
 iaalt6+5g7HKs0W03QCVkqGru1Px23E0INpnzQCQujKBGdC4Ypji9QjZz1kJzndH57wn
 MDWxNBQGDViTecvBdS5mUF/iXNz6DSsHND/O+cuZYewWu1sXDU+0cXGf6wdUzUk0iFR/
 NL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727181864; x=1727786664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=677keSA/AToPRkUUTw9YbPGSGOCBACjoAMcuiE16UlA=;
 b=RL2wOQH54rTEtRMTGMJKx954ZjYXsjCdRAk4F8eYX405BzllZ5ec3TrpW5VSeL396h
 cHc/WCDvHCghiphBTqqGNEPBA9U8rSkSPP8HE5YDGWNW2qDBQ0p3Yvc6205tSjlzYNJx
 gLYeoL/z9Rv4pgKuDLyyMHlQLJOTLrGjnrMyhdNoXaIHZD+tpeVxDS1owN9avtpqEScx
 W0v5JtS/+HFkCHszBW8AN4vWP0ae0SX5gsZQanUjoQzLlk6L2CTTc50Vwau8kT9vCeW8
 2tCVgdG/dKElusNP9rhHqVwl9Qf9cWgQstm6Z/3eqnsUX945mh0jEeqklH6A1r/TNMLG
 RMUg==
X-Gm-Message-State: AOJu0Yz6jknWDSdAKw61cMn/Scm4WcAfW08hNCDoogcIbh/aLR8ZtVYr
 /UhTAQ48tVh5zFuvn763dGvJbq6VEFwcgwfCIXxHQWArYL9F+5SX1aC/6+5Bm3lg8y/Cf2vWoUl
 p
X-Google-Smtp-Source: AGHT+IHJrUXccfy+/7KatlTRAS8FofVhz+Za3zDzoGS4SijTtO2Qh/kpFqMqU0zMuUqIAMhQeIT5tw==
X-Received: by 2002:a05:6122:2523:b0:502:bd0d:abe2 with SMTP id
 71dfb90a1353d-503e040bce8mr11968512e0c.6.1727181863848; 
 Tue, 24 Sep 2024 05:44:23 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-505aa10a8fbsm767830e0c.49.2024.09.24.05.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 05:44:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/4] target/riscv/kvm: add kvm-aia bools props
Date: Tue, 24 Sep 2024 09:44:06 -0300
Message-ID: <20240924124407.766495-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924124407.766495-1-dbarboza@ventanamicro.com>
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x929.google.com
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

Boolean properties are preferrable in comparision to string properties
since they don't require a string parsing.

Add three bools that represents the available kvm-aia mode:
riscv-aia-emul, riscv-aia-hwaccel, riscv-aia-auto. They work like the
existing riscv-aia string property, i.e. if no bool is set we'll default
to riscv-aia-auto, if the host supports it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 77 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 32f3dd6a43..e256e3fc48 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1671,6 +1671,62 @@ static void riscv_set_kvm_aia(Object *obj, const char *val, Error **errp)
     }
 }
 
+static void riscv_set_kvm_aia_bool(uint32_t aia_bool, bool val)
+{
+    bool default_aia_mode = KVM_DEV_RISCV_AIA_MODE_AUTO;
+
+    g_assert(aia_bool <= KVM_DEV_RISCV_AIA_MODE_AUTO);
+
+    if (val) {
+        aia_mode = aia_bool;
+        return;
+    }
+
+    /*
+     * Setting an aia_bool to 'false' does nothing if
+     * aia_mode isn't set to aia_bool.
+     */
+    if (aia_mode != aia_bool) {
+        return;
+    }
+
+    /*
+     * Return to default value if we're disabling the
+     * current set aia_mode.
+     */
+    aia_mode = default_aia_mode;
+}
+
+static bool riscv_get_kvm_aia_emul(Object *obj, Error **errp)
+{
+    return aia_mode == KVM_DEV_RISCV_AIA_MODE_EMUL;
+}
+
+static void riscv_set_kvm_aia_emul(Object *obj,  bool val, Error **errp)
+{
+    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_EMUL, val);
+}
+
+static bool riscv_get_kvm_aia_hwaccel(Object *obj, Error **errp)
+{
+    return aia_mode == KVM_DEV_RISCV_AIA_MODE_HWACCEL;
+}
+
+static void riscv_set_kvm_aia_hwaccel(Object *obj,  bool val, Error **errp)
+{
+    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_HWACCEL, val);
+}
+
+static bool riscv_get_kvm_aia_auto(Object *obj, Error **errp)
+{
+    return aia_mode == KVM_DEV_RISCV_AIA_MODE_AUTO;
+}
+
+static void riscv_set_kvm_aia_auto(Object *obj,  bool val, Error **errp)
+{
+    riscv_set_kvm_aia_bool(KVM_DEV_RISCV_AIA_MODE_AUTO, val);
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
@@ -1681,6 +1737,27 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         "if the host supports it");
     object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
                                     "auto");
+
+    object_class_property_add_bool(oc, "riscv-aia-emul",
+                                   riscv_get_kvm_aia_emul,
+                                   riscv_set_kvm_aia_emul);
+    object_class_property_set_description(oc, "riscv-aia-emul",
+        "Set KVM AIA mode to 'emul'. Changing KVM AIA modes relies on host "
+        "support. Default mode is 'auto' if the host supports it");
+
+    object_class_property_add_bool(oc, "riscv-aia-hwaccel",
+                                   riscv_get_kvm_aia_hwaccel,
+                                   riscv_set_kvm_aia_hwaccel);
+    object_class_property_set_description(oc, "riscv-aia-hwaccel",
+        "Set KVM AIA mode to 'hwaccel'. Changing KVM AIA modes relies on host "
+        "support. Default mode is 'auto' if the host supports it");
+
+    object_class_property_add_bool(oc, "riscv-aia-auto",
+                                   riscv_get_kvm_aia_auto,
+                                   riscv_set_kvm_aia_auto);
+    object_class_property_set_description(oc, "riscv-aia-auto",
+        "Set KVM AIA mode to 'auto'. Changing KVM AIA modes "
+        "relies on host support");
 }
 
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
-- 
2.45.2


