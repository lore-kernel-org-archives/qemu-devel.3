Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDEDC624C6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzH-0005Z7-LO; Mon, 02 Mar 2026 03:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxS-0003Nd-2r
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxQ-0002Go-9k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAJCcHg9GGW3sUVSr2tHEQLB2IHA7/8o0P4+m86PMX0=;
 b=Y6bSf4/FLiQNr3QpLlPivHSTybja1ckVZZqFnwsD0unCnVfAZBAGbfMqLjJBzsqEPt8ywT
 Fvka7ddXzIZqmS63hYH91JnBq0Z45iSYIWy5aUiso7+gqlkzUVaB+QVkDmPb0v7+oGGZbP
 lLXGLoJbGrJ8FVkbmaZzNjROWWmSBrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-n-RybIg_PQqGixSm8vlfqg-1; Mon, 02 Mar 2026 03:48:50 -0500
X-MC-Unique: n-RybIg_PQqGixSm8vlfqg-1
X-Mimecast-MFC-AGG-ID: n-RybIg_PQqGixSm8vlfqg_1772441329
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso34683735e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441328; x=1773046128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAJCcHg9GGW3sUVSr2tHEQLB2IHA7/8o0P4+m86PMX0=;
 b=XPBXfHHJRoQqve9yBmDrbWy1Z2oz6e2H6QITB8oYY/wJz12nm1Ms86+M64l/+3yGPq
 nWRB2pBJbWukQcoXnLR9rSbJdAPfHAxs5WKog+Yz+qhZ08LoSg+GxqGLxk1zs654vAG+
 NeLFzXfmuhv78qh0YPPI7+Kywzo1swh1yY1EE6eejei65DiFp4vigyMrv1HYkRwb+OaD
 eQFtIp3pNqYxWCoCahNqhWiZ7oJ3LEqtmrEUXQ/fD1OtqNc7pFUZI+yXTMFW7jEVMejy
 fLKbTvvruWpRcChAvv9SZTBebUzCpUDvdnZhhWXttH2rHdG+PbkXtLJ7U2x3weVDRAPH
 wX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441328; x=1773046128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAJCcHg9GGW3sUVSr2tHEQLB2IHA7/8o0P4+m86PMX0=;
 b=v3yMyw3wigZ6JtkMbXmLnhDBXuzNUJiKUoQ2eGp1bmW8zrxxlyH62FoE3iwptsql30
 NoPOqP82X+ulwJ+joF+WnnXBt2ONcF8sipBpMe6DgsctAqO5zwni7xwQD8VsYJ0x/kKI
 ShcLWD62YJ/+o+sYk9BHZtbAG3zGGfZIdMBF+ektReuwI57lqxywfkmsxQRFt18hskF9
 +tPKcFEhXVjEp1I160+Me1wXTpdaTrv3rMwmuSzLifejp+RUMxh39Db98NjM4F/VIHqv
 /15fsKgSaGF88MzgBchPwFWD9EUDZART7aFZ+RaNg8lPALxwX93R9C2ODbdHFbwQ9pmn
 9Yrg==
X-Gm-Message-State: AOJu0YzpTi9xWS6jJTtQFH07lp+Ts8vYRW/RsaDuFmlX25JJMwU/oP/q
 anJSfxxV5xdz4GvOVoUSTmeSs71NDlrnkH2wN3KJmtUd6MhUEwEAXhPIH83sZBsV2ET1qaBOLCi
 qEefhbN5wZmXuc2pHWwAO+sOcRk/XxGNxBPKu8MOBWicgUUC27p7ezfL/Qv21o8M295NjCrONsP
 6EndN/krEb+7z/rEprwiJUsPMDeDLMZalhlr1DIrSn
X-Gm-Gg: ATEYQzxkoEsuxpujWAydQSHvcwTcfEVx1MrbsllWUcu20wHySiyujKxR+ebJSbh+wmz
 8aFxFic3x9A8bkdDUZ+UoJ326mATSG2kONVVpowGhGqvipCWhjQKSyZIYx7fDMVgW4OItl9XsN8
 7nLIypN0+Yy1QiWjTzf1u6Vn5OVo3X5vv0RwBXulahLTrRqUgWYFOfpeWooqfBLhsjJ6QwAzinf
 WyD3V3QI/xg9xShC3G+eDkyHM0qAfJceJgwTDG75xaFDLDVpFUJO5d20dNCVcVRITbxGGxfhWRH
 5gDDA9ao4OknDl3qyFcpGKvmPEBzOt1RDlIpC6U4wro/OaHw+552hC9blGTflSdzEC+5yiIsNaL
 P2grSHI64y/8erlfI0dYjTpDEj9NU2ryMy0pxae/lakRCQnx8U8h3yRbFuE/eJHgem1uzdXpgJH
 28yacedP+HouN6QMt0ZdZRmplRVv4=
X-Received: by 2002:a05:600c:8b11:b0:483:6f7c:19f4 with SMTP id
 5b1f17b1804b1-483c9c0b6c4mr197152525e9.30.1772441328395; 
 Mon, 02 Mar 2026 00:48:48 -0800 (PST)
X-Received: by 2002:a05:600c:8b11:b0:483:6f7c:19f4 with SMTP id
 5b1f17b1804b1-483c9c0b6c4mr197152055e9.30.1772441327851; 
 Mon, 02 Mar 2026 00:48:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df90sm404799165e9.14.2026.03.02.00.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Jon Kohler <jon@nutanix.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Aditya Desai <aditya.desai@nutanix.com>
Subject: [PULL 089/102] target/i386: Add VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC
Date: Mon,  2 Mar 2026 09:47:35 +0100
Message-ID: <20260302084749.474955-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jon Kohler <jon@nutanix.com>

Enumerate ability to enable Intel Mode-Based Execute Control (MBEC)
on secondary execution control bit 22.

Intel MBEC is a hardware feature, introduced in the Kabylake
generation, that allows for more granular control over execution
permissions. MBEC enables the separation and tracking of execution
permissions for supervisor (kernel) and user-mode code. It is used as
an accelerator for Microsoft's Memory Integrity [1] (also known as
hypervisor-protected code integrity or HVCI).

[1] https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity

Code is mirrored here:
https://github.com/JonKohler/linux/tree/mbec-v1-6.18
https://github.com/JonKohler/kvm-unit-tests/tree/mbec-v1

LKML thread(s) are here:
Original RFC: https://lore.kernel.org/all/20250313203702.575156-1-jon@nutanix.com/
V1 code: https://lore.kernel.org/all/20251223054806.1611168-1-jon@nutanix.com/
KVM unit test changes: https://lore.kernel.org/all/20251223054850.1611618-1-jon@nutanix.com/

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Co-authored-by: Jon Kohler <jon@nutanix.com>
Co-authored-by: Aditya Desai <aditya.desai@nutanix.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Link: https://lore.kernel.org/r/20251223060834.1618428-1-jon@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 065613722f1..c384302de32 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1414,6 +1414,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000
 #define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
+#define VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC      0x00400000
 #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
 #define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9b9ed2d1e38..619ed0de322 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1656,7 +1656,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-apicv-register", "vmx-apicv-vid", "vmx-ple", "vmx-rdrand-exit",
             "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
             "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
-            "vmx-xsaves", NULL, NULL, NULL,
+            "vmx-xsaves", NULL, "vmx-mbec", NULL,
             NULL, "vmx-tsc-scaling", "vmx-enable-user-wait-pause", NULL,
             NULL, NULL, NULL, NULL,
         },
@@ -1971,6 +1971,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
         .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST },
     },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_EPT },
+        .to = { FEAT_VMX_SECONDARY_CTLS,    VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC },
+    },
     {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VPID },
         .to = { FEAT_VMX_EPT_VPID_CAPS,     0xffffffffull << 32 },
-- 
2.53.0


