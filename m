Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF721CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDPV-0004NU-I5; Thu, 21 May 2026 20:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOZ-00031R-RR
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOU-0004ms-QN
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b788a98557so42122825ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408337; x=1780013137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9iTbzlI41JSlt4+yiHQ0Q6TI9ZFzV/ZAd4qULhbdxM=;
 b=XfMYkQUKtx0z4KVHNM6E31u7h0wwTRsMa7jfrpnvRRnzOsGonEz6VGHi1IqcV8ZuA8
 fnkTGhvFisC/2Sk4jaldee/9U+txsbnernfqTsy4PJiEk6nCx+/e9R+R8wA1hwz6kFLl
 MOwkc0rug1rNqDw058ns13SMxb4otmJ4AkDqGsupT0sID3rm+/OlDFN4j9OeN8O0dXI/
 T3pBSR2/lB64VdYEiLlu4AJZfO7F34e+U1Z0r+10xanLGdT4XVN4qhwVqRysXe8CAVJ9
 c4zdRXWtzx1JHL0fRlyjOYSY57TC9mEFTW2ApwQ99yh8GcFazODcRzPB+vbM8xhB3Q+l
 +4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408337; x=1780013137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f9iTbzlI41JSlt4+yiHQ0Q6TI9ZFzV/ZAd4qULhbdxM=;
 b=iHWJn+g8dwUheNhLXfhT9V0Yee66hfFh9UCEjT9E2BHK3JidWRsZgk/4yB9YuJKJFN
 rFwa+svcXviP43fsVy0mTgl7HXXTKI1LejBvTBAl9zJCToenln23BJfMoGk7DhJVkLkK
 lYxrhSDq0yxU3uXTckGerxTsQ6AUd+avsjNJlfhJa+sVJRL0jQZO9Udlmdusc8k1x4wj
 yLPWrDNRV12L5flGjUPGIDFBApKYS+q6YeojzjDHc26EHxMKDn/ulUn5p8FcYbjT36Wm
 sksNrYKWeyKuZ9eSIMiIp4xwM31VNZWi2NvdKwMmlVvMqTg+pmY+oxiKuMXc0WNZ20YK
 Myng==
X-Gm-Message-State: AOJu0Yztd+BnF20uUrrMTAmOj6sJtEmbQJ6tigImpih75TIin57W8DpR
 +uMaV68CcybcRB4IBPnz5RCRw/i+OTjbYT/sd67Sf9gHYBycV0iKE63QNYi95ukD
X-Gm-Gg: Acq92OHvlbfNnLEk/zHwbrdJpc+SzP36qCacNrz80QdDM8BG2CL2RLXaO6CDLUzSrkS
 IJG7ciqZSM+elWm5KdlZuD8AnEkVnDWZz4yVvBcjqDDg4o/PbzP0hzbcTIhfrPYSQzAoHPFJm/N
 llQrXfF8gvIJ9uYctXRJmH7hBi+p7a6gslMD3cxNnMAdLO+RDVT7DfmaEgbroi5BwRAL2m8JIJ/
 JzBLzBZUd1XGlLjDjuvGlYtdg8t3eFcxyyAgZjnnY7P9mczLO6KZEM/T/pJRfhZjFOd6WVpLJgc
 rWm3g7/hWKufaj/J8htpMmpMMHboerv4inCuk93YWTK9mc85OkizNIp/4EIw5Tqh+6deJC1NE+y
 5/NrAMFcnNefcQM5puAlKx0PM8X4+Ke26X6rXDjacZeIw8lGoxLU2hkbIWpJeABE/ewozg3BHG9
 dP0CJFGJ6J9eA3DKyok+LhtVdz79ezLapI9nkncQ+iaMKZvlqsaS8U
X-Received: by 2002:a17:902:fc48:b0:2b0:c45a:bc2 with SMTP id
 d9443c01a7336-2beb059cebcmr11522315ad.16.1779408337123; 
 Thu, 21 May 2026 17:05:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:36 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/48] target/riscv/tcg: use isa_edata_arr[] to create user
 props
Date: Fri, 22 May 2026 10:03:14 +1000
Message-ID: <20260522000324.23255-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

This change has been done twice now: one in riscv-qmp-cmds, another in
the KVM.  We're now ready to do it for TCG.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512032926.1978818-14-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7575884d7e..3e22e7ed53 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1550,27 +1550,6 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
-static void cpu_add_multi_ext_prop(Object *cpu_obj,
-                                   const RISCVCPUMultiExtConfig *multi_cfg)
-{
-    object_property_add(cpu_obj, multi_cfg->name, "bool",
-                        cpu_get_multi_ext_cfg,
-                        cpu_set_multi_ext_cfg,
-                        NULL, (void *)&multi_cfg->offset);
-}
-
-static void riscv_cpu_add_multiext_prop_array(Object *obj,
-                                        const RISCVCPUMultiExtConfig *array)
-{
-    const RISCVCPUMultiExtConfig *prop;
-
-    g_assert(array);
-
-    for (prop = array; prop && prop->name; prop++) {
-        cpu_add_multi_ext_prop(obj, prop);
-    }
-}
-
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1579,15 +1558,22 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
+    const RISCVIsaExtData *edata;
+
 #ifndef CONFIG_USER_ONLY
     riscv_add_satp_mode_properties(obj);
 #endif
 
     riscv_cpu_add_misa_properties(obj);
 
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_extensions);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
+    for (edata = isa_edata_arr; edata && edata->name; edata++) {
+        if (edata->prop_name) {
+            object_property_add(obj, edata->prop_name, "bool",
+                                cpu_get_multi_ext_cfg,
+                                cpu_set_multi_ext_cfg,
+                                NULL, (void *)&edata->ext_enable_offset);
+        }
+    }
 
     riscv_cpu_add_profiles(obj);
 }
-- 
2.53.0


