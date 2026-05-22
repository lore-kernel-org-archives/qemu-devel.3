Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6238CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQy-0006fn-EB; Thu, 21 May 2026 20:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOV-0002ya-1R
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOP-0004kw-DJ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:37 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2be75f658f3so22072575ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408330; x=1780013130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMTCEA+VZyNulHLWiJGLsQAKOr4i9pEs4NabySUgtM8=;
 b=rJurYL6YRlXGwGFuJgGXOKb5fUZHGXTgqUEazziTLZ7ZKtmr1tvou599IVvS7euV+E
 hEudYEWx1sJNxjsM9MfKB8Z68NWryNhKWnrVM9zcEa10LkxUS2MF34HvIB47FQ4JqEl9
 QhnDAOJgG2OZO/ygTkfZjVlDErlhoew/QuztRTpmTsRJ/gymcqPrsTp7kHvtLFJT0b0Y
 qJl8aOYXEC4C6jj1INr0+Xymh+5j6QLSvaImcFUB/bGlJgEo01XH2h+4Op6cIjUhLbsn
 o9T0Ji4ZWKEqlVMJr+PtMJqQ02M+29da4o5k8pe0EgAs1ich3Tyibmj1ACXTXpYGwhW8
 wOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408330; x=1780013130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HMTCEA+VZyNulHLWiJGLsQAKOr4i9pEs4NabySUgtM8=;
 b=LyiM8mUNE9DWQcYN2a+gC63yeai5yTk8XOt4x/A/KwVCHViORzEQE3WsrpTnS/loXN
 3UOE9wPBnupq7Qa5s8WPJfpMNT9N9DMFywe7TRcOZO+HbD9RDH58lJNNyOJ4/8dnmQpK
 wa1O4OFflu7JDB2U4BIho7vp+KielBzkWOLtTvZXkDPAaFHH9ElUTyMByYsNSRSh7WoL
 RAYnJj4WaXvORjYCpkaOkAcdmzohHe/uzyc9Ub5yd3raKs0Rt16AuSblPShXdZvXZCoO
 171cjET7cr2yVhSLPs8oRCFF8z4XeHj16SJz470Apd9o7WDW1qGVYwjQ+7dBAqyNuVQk
 w7Bw==
X-Gm-Message-State: AOJu0Yx1ZloTxzCwrayVYG7j+REfgQngO1/OkApAmuP8afMsy8aIxBSC
 uDIWxWzfV2yvPhgWDRUjqooCa7iyKwfyNz28lh+WfIYui8sgMsgSqQjAVh0dxWWv
X-Gm-Gg: Acq92OH94DZFxJN81F2ZfZlJXFh3m5k+pHETZL4pKbP+Btl/lgJRfFe6dVZEF8vH0SV
 RPIJiguurVjtPX3co8aqb5p/J0ynGwmcKZ1pH0G6fflIq013Gn8V5+jKIhL2l5AFu1hVW1xhmYy
 IjS5FzPQq3GW684Ap4CXrfFMaifRJR1DzKSPZgFFZtWiSDHLXZ/psi4GwQXMh3v5U27jaR6azuL
 ZazdTN5KfO+yVX3OGH7nieNnIsoj7SYcxkyP9KgGUyC/VrIpinE6fKedcNiXTM+Ycb8ueE0Rxvt
 rg0ZXwDITsViN3mPfeRoxcSXAPoeTpy2zpFNR7RebCDeYjaSPmO3uhtRTlg7O7EvwTq8UBsFqqF
 PiD+S3ks3gEU0Of8OwiPaPD1iMawxG1yqwHfE/50vIFd9s46VbMNT+GyXBDlyjLF3EqwXdKaHEL
 63Cxyqk/zH5WfenZ8dkWVcK+F4seIDikqt7tA2rJ9QNQ==
X-Received: by 2002:a17:902:e74b:b0:2ba:359a:9b8e with SMTP id
 d9443c01a7336-2beb06bddd3mr10398135ad.10.1779408330569; 
 Thu, 21 May 2026 17:05:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/48] target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb
 opaque
Date: Fri, 22 May 2026 10:03:12 +1000
Message-ID: <20260522000324.23255-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The cpu_get_multi_ext_cfg/cpu_set_multi_ext_cfg callbacks are using a
RISCVCPUMultiExtConfig pointer as opaque, but internally we're just
using multi_ext_cfg->offset.

Use multi_ext_cfg->offset as opaque instead.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-12-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index eb48a76a6d..50d9218a75 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1510,8 +1510,8 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
+    uint32_t cfg_offset = *(uint32_t *)opaque;
     bool vendor_cpu = riscv_cpu_is_vendor(obj);
     bool prev_val, value;
 
@@ -1519,9 +1519,9 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
+    cpu_cfg_ext_add_user_opt(cfg_offset, value);
 
-    prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
+    prev_val = isa_ext_is_enabled(cpu, cfg_offset);
 
     if (value == prev_val) {
         return;
@@ -1535,17 +1535,17 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
-        cpu_bump_multi_ext_priv_ver(&cpu->env, multi_ext_cfg->offset);
+        cpu_bump_multi_ext_priv_ver(&cpu->env, cfg_offset);
     }
 
-    isa_ext_update_enabled(cpu, multi_ext_cfg->offset, value);
+    isa_ext_update_enabled(cpu, cfg_offset, value);
 }
 
 static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
-    const RISCVCPUMultiExtConfig *multi_ext_cfg = opaque;
-    bool value = isa_ext_is_enabled(RISCV_CPU(obj), multi_ext_cfg->offset);
+    uint32_t cfg_offset = *(uint32_t *)opaque;
+    bool value = isa_ext_is_enabled(RISCV_CPU(obj), cfg_offset);
 
     visit_type_bool(v, name, &value, errp);
 }
@@ -1558,7 +1558,7 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
-                        NULL, (void *)multi_cfg);
+                        NULL, (void *)&multi_cfg->offset);
 
     if (!generic_cpu) {
         return;
-- 
2.53.0


