Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C01067042
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0hde-0002Bd-Qj; Thu, 12 Mar 2026 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w0hdd-0002BS-6K
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:07:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <15fengyuan@gmail.com>)
 id 1w0hdb-0000mt-NT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:07:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so5499225ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773328066; x=1773932866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UtZ2h2giWFWT59XsmszkkjhxggYv6cqaElG1EpuLZbw=;
 b=DqCq5yT7vf+aqX9IQI0h4vRlnVaWwRHjydn0SAP+yxXNyR/g+3toEfDJeP7/Teu0UH
 fLbeYjn5lDxcxnSE0OUu7xvSCVhcYsJVcN+ZZXUnG914fMVtX5/H7mCd7Ql/vKLXdNTz
 qeyJiRt44lVNz7mwo8cVkJ0WLt7WS4bkbvCmQcVosRdN+AqF1n+gt4UhM+fJzVCXUv9D
 TsCdWZAy3sK2V8xz3v0D8p9ISFCl2Ors0hd9k6sJJaupYYWLqP9y6RwzyiI8O56HUTxO
 NZ2Auo6SgZasQnAENERPcTdLrdHGkwgezR7dPZmOJ7ff7tFJ9BMyh/r/17A7HVLwU/gO
 7+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773328066; x=1773932866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtZ2h2giWFWT59XsmszkkjhxggYv6cqaElG1EpuLZbw=;
 b=wAWPFqJ2E0T4tW2qmjAoBF4T0L1Oq7KeFetTvNDynV6Q24G/tG/8wi+PSClv3M//b7
 Ivy+Yh5pRKCLaLs0fMSw2aqqCtFHK8/Y7D+mLq8ZitQgxo0deZt6IdG7rLp+NBlr7XK5
 GShxnY7zuFC1xg5tKYQc4MC1aCipGeSrhLLnaaLs98QBm9CIxrbb+9Avu5eUOPL3V/Pn
 gc+uTmvwHA2rC7VWvn7tVgJnw6FEg4yAjK3EZfEGKGvg8GSnHkw5D2bq6E3QVC+o2oHr
 ObuefltmghmJUpkxCHUuS/S69X1zy8axxL5aCpMoyOl6cPpk7PR8Cyxqa5eMzDkuVos1
 Mulg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYwldDsvOQeh9FElrQLQ3XjO32oWyx77dxc+a7O+Ov+o5qJdStgyR8j0fmDyeRZBVDfOLNGcpILwX1@nongnu.org
X-Gm-Message-State: AOJu0YzQoGOPlNof98+mXAOTy1j0NQLk2M6Y34IaifQxBHhF1u5AtzlZ
 WMacCy5m71dfE3ts4xQoQDO0PJ94yVA45NMjSLrW+FwEDmSTcsSoS8SJ
X-Gm-Gg: ATEYQzwy8oj0s5aPLQPwn8iODqh/xS4CdAkTkKCxPocY8DpHkQclyy2g7HIAjDAQ546
 e3rrdyvI8wvf9qzE3/5KBg2NCJ6Q6GVAM20bo1j4VbkyCU4uZZYinlWHGMrYIRKAmc1KgckXAtV
 DH3nYgzz8EzFIF87eyjqRGMsCgOFYKGiBWWBOTi08tSMDTLo8Lr6Bc+oemmc1QbLk/bgLHvhA6f
 tzYEsYR3hI32YseXKckkUlXnmU+NbPedfy/9CcrTs00RFGTGtS5KxWprGO7G1b7DURwVPbFmsJ/
 vjieXoJws+n/49ZZUqhqY03UTvDhs7vdIfWexfR7DPRX7C/KCM//LRilBz3LIEpNVBB32Zv6/UL
 AzjTKin2kFxKR5bQu4pc5/Iz6cYyKd1DypqQrwgPhUSwezW+YKVST/X3W00E0KBPF3TInTdedvF
 sjDGz+K5dkDGWD7Cm7d0IjzfZ+Gw5nrkzrqV02yA==
X-Received: by 2002:a17:902:f68d:b0:2ae:7fbd:3ae7 with SMTP id
 d9443c01a7336-2aeae8080b5mr65143895ad.22.1773328065656; 
 Thu, 12 Mar 2026 08:07:45 -0700 (PDT)
Received: from orion-o6.tail020997.ts.net ([2408:8352:441:f661::1004])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aec00ed91bsm24275845ad.24.2026.03.12.08.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:07:45 -0700 (PDT)
From: Fengyuan Yu <15fengyuan@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Fengyuan Yu <15fengyuan@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/i386: Fix VTD_ECAP_PT set in wrong register in
 vtd_cap_init()
Date: Thu, 12 Mar 2026 23:07:12 +0800
Message-Id: <a3c74c60e05f6a71138dcb7f39f015b17e065654.1773324526.git.15fengyuan@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=15fengyuan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

VTD_ECAP_PT (bit 6, Pass Through Support) was incorrectly OR'd into
s->cap (Capability Register) instead of s->ecap (Extended Capability
Register) in vtd_cap_init().

Per VT-d spec Section 11.4.3, PT is bit 6 of the Extended Capability
Register, indicating hardware support for pass-through translation in
context-entries and scalable-mode PASID-table entries.

This caused vtd_pe_type_check() to always reject PGTT=4 (pass-through)
in scalable mode, since it correctly checks s->ecap & VTD_ECAP_PT,
which was never set.

Move VTD_ECAP_PT from s->cap to s->ecap initialization to fix
scalable-mode pass-through translation.

Reproduce:
$ ./check-vtd-ecap-pt.sh ./build/qemu-system-x86_64

Before fix: CAP bit 6: 1, ECAP bit 6: 0
After fix:  CAP bit 6: 0, ECAP bit 6: 1

```sh
#!/bin/bash
#
# check-vtd-ecap-pt.sh
# Check VTD_ECAP_PT (bit 6) in CAP/ECAP registers of emulated Intel IOMMU.
#
# Q35 IOMMU MMIO base = 0xfed90000 (VT-d spec Section 11.4)
#   CAP  register offset = 0x08 → address 0xfed90008
#   ECAP register offset = 0x10 → address 0xfed90010
#

QEMU="${1:-./build/qemu-system-x86_64}"

OUTPUT=$(echo '{"execute": "qmp_capabilities"}
{"execute": "human-monitor-command", "arguments": {"command-line": "xp/1gx 0xfed90008"}}
{"execute": "human-monitor-command", "arguments": {"command-line": "xp/1gx 0xfed90010"}}' \
| timeout 5 "$QEMU" -machine q35 \
    -device intel-iommu,x-scalable-mode=on \
    -display none -qmp stdio -nodefaults 2>&1)

CAP=$(echo "$OUTPUT"  | grep -oP 'fed90008: \K0x\w+')
ECAP=$(echo "$OUTPUT" | grep -oP 'fed90010: \K0x\w+')

echo " CAP ($CAP)  bit 6: $(( (CAP >> 6) & 1 ))"
echo "ECAP ($ECAP)  bit 6: $(( (ECAP >> 6) & 1 ))"
```

Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c..7b2cead8f8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4998,7 +4998,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (x86_iommu->dma_translation) {
@@ -5009,7 +5009,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
                     s->cap |= VTD_CAP_SAGAW_48bit;
             }
     }
-    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
+    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
 
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
-- 
2.39.5


