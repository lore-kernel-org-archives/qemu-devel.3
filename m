Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013AECDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3df-0007B4-6a; Fri, 26 Jun 2026 06:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3db-0006wb-9L
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dY-0005AF-6Y
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/SUZ46ILgMpKxSzRAlv4EG43tnwctwIT3ZzriqakKg=;
 b=VDElvQqRbPLuelZij5imSGCpijkF2hsNds4snpNu3DR6zHikRlBNMa+oNmuyIn5RD0m2Ld
 oPFc+kR9OTXEak7Kvl5pdJb0/TdKr7kMwMeE0qYyl09YNnsuQBt4RDwAtDELP5TSK4VLTH
 2NGolwf+gbGns/jI7Cv3hz5nziNFaQU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-vfiC5pkrODW2kziXLqdvnw-1; Fri, 26 Jun 2026 06:18:14 -0400
X-MC-Unique: vfiC5pkrODW2kziXLqdvnw-1
X-Mimecast-MFC-AGG-ID: vfiC5pkrODW2kziXLqdvnw_1782469093
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ae461f8dso5122995e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469093; x=1783073893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/SUZ46ILgMpKxSzRAlv4EG43tnwctwIT3ZzriqakKg=;
 b=BQoGu+SjeXIi8BeGha8O87pxH+CWIetnLmEOxwsN4z5RMUyWFgT00pW63BcwwLMUeE
 bajQsegCx4O27aa2mZnUdXSJVY6cAppFA2QlvWGZqzt+N++eXjHJEl0ydzU15uMuZHbO
 JgXv+inwqAC7TngVeByhHxn600sW9liJzctzOHkQJlyAJjvi6Xg8tzp1IDaFVHH3lhue
 HCRgHEnokT+Qy0UK2FSdFMZ9FCkK5/4Gso9763KDTZz9sOSizeE66mRjE9Bh/+rPGZJS
 ajlpayQUbv/opkcFFjQNeRWnVpqxufxQ4iYN4ssAfKOvzQUgDG/ShvbLNcP3waTnGx48
 02kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469093; x=1783073893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/SUZ46ILgMpKxSzRAlv4EG43tnwctwIT3ZzriqakKg=;
 b=EpVfausHiQkI44LG309V38VPi4cAm3uIDtJQaJzXimGdR7GwTRaxDhaY/RjxoELD24
 Z0x/zCcASPbZH/zYJtN7w3ACNXEpkemnswenan/0b021lo8V8YOkFHjebTrEZVTeHrnd
 AqrYn8tB83ZBTvvGmcLPiosgifMIg+83bYpqWN4qOz/cRVBsYK0MgesJyHJAa3NyYbRT
 pQnDOFbq8l4ejbACZSQKoyTFD9oiy8pyS2ZjIqxUJcMAYc8clx4Z54Cjk+CeUyr59Bwb
 GyxEWa6aQSEZstCpY+4zk1mvUlvMv+e7FuYucGXSQKbMuVH/Cp4/UXoyn7yzCvc/M0Fa
 RkIw==
X-Gm-Message-State: AOJu0YzcHlqlHTZXAzmMlWeWwpLph0/o/gXtg/8nqWtWneGwRBp5h7RO
 tDvEPEiE4aMKVxL4Rq58mK5qfoHeStiVIBQkXXfIkg2m1/BkkCR8aZ6n/aV33UwTJXBL9s9foQb
 4T4Z83HXMFuI2s1SGRF81taGm+Zb/rhbx5ptbD1MNmBytc7HytiiVi+Tx8yw/jJuDkFLn0qg7tf
 l9QGAkZhM4tZGl4B0eFnEbQxDsjulrmgEBJGOiuILC
X-Gm-Gg: AfdE7cnmHzkLQe4BI/2cr9vPZjkk+LL4ud1b8LsZW4C7Jv/fofVzk9wQduwCYJhiykR
 71vWGUByulPUh7J4asJr6+omd/loj1A5GBrMl3blat60BNHhZlZzOGDLIxODJAbHdGGM9fs9FQi
 5N4nMF96WLJWJ0T9h/Kap89BFyXK+nThy5AcE+LZS84Pd2Th8HG5nlOwjPlFD5r9JkiYql5Qx3I
 eS0P6Psb2ssZEzFBqxyrXwnaCn1vMgq1KYJpqv5LB/JOZg18C6EgaqttiQlv8mIP8+pTt/MIK7d
 XM14AQO6pd7slRej5nqU4Vzur+wI6ZJedspzwkI/E8hHCA74bQHl631YR/NVd1MtRHiDBskPDSh
 QqOiFQ4Zb51yhD5t/YrQC7qLCuQmFJP17eVb1XRM8HaOKnfqyvu1QueFXIvSXGWKZHTbI5yDxda
 pLPA6NWKUhBIbxJW6z
X-Received: by 2002:a05:600c:a403:b0:492:4e1c:120 with SMTP id
 5b1f17b1804b1-4926689988fmr77417575e9.32.1782469093163; 
 Fri, 26 Jun 2026 03:18:13 -0700 (PDT)
X-Received: by 2002:a05:600c:a403:b0:492:4e1c:120 with SMTP id
 5b1f17b1804b1-4926689988fmr77417135e9.32.1782469092703; 
 Fri, 26 Jun 2026 03:18:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm17463314f8f.17.2026.06.26.03.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 08/45] target/i386/mshv: use hv-provided [0xD,1+2].EBX
Date: Fri, 26 Jun 2026 12:17:11 +0200
Message-ID: <20260626101748.1728079-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

We cannot statically set the responses for CPUID[0xD,{1,2}].EBX, b/c
those are dynamic, dependent on which features the guest enables.

Hence we mask EBX when registering answers for those subleaves at the
hypervisor, which will result in the hypervisor providing us answers,
considering XCR0 and XSS.

The reported size now reflects the field masks properly (without the
mask they were 576 and 10728, which is wrong):

$ cpuid -l 0xd -s 0
CPU 0:
   XSAVE features (0xd/0):
      XCR0 valid bit field mask               = 0x00000000000600e7
      ...
      bytes required by fields in XCR0        = 0x00002b00 (11008)
      bytes required by XSAVE/XRSTOR area     = 0x00002b00 (11008)

$ cpuid -l 0xd -s 1
CPU 0:
   XSAVE features (0xd/1):
      ...
      SAVE area size in bytes                     = 0x000029c0 (10688)
      IA32_XSS lower 32 bits valid bit field mask = 0x00001800
      IA32_XSS upper 32 bits valid bit field mask = 0x00000000

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-9-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 66733390c3e..e85311af2af 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -528,6 +528,7 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
 static int register_intercept_result_cpuid_entry(const CPUState *cpu,
                                                  uint8_t subleaf_specific,
                                                  uint8_t always_override,
+                                                 uint32_t ebx_mask,
                                                  struct hv_cpuid_entry *entry)
 {
     int ret;
@@ -543,11 +544,12 @@ static int register_intercept_result_cpuid_entry(const CPUState *cpu,
         /*
          * Masks specify which bits to override. Set to 0xFFFFFFFF to
          * override all bits with the values from the QEMU CPU model.
+         * A mask of 0 lets the hypervisor supply its own value.
          */
         .result.eax = entry->eax,
         .result.eax_mask = 0xFFFFFFFF,
         .result.ebx = entry->ebx,
-        .result.ebx_mask = 0xFFFFFFFF,
+        .result.ebx_mask = ebx_mask,
         .result.ecx = entry->ecx,
         .result.ecx_mask = 0xFFFFFFFF,
         .result.edx = entry->edx,
@@ -582,6 +584,7 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
     int ret = 0, entry_ret;
     struct hv_cpuid_entry *entry;
     uint8_t subleaf_specific, always_override;
+    uint32_t ebx_mask;
 
     for (size_t i = 0; i < cpuid->nent; i++) {
         entry = &cpuid->entries[i];
@@ -589,6 +592,7 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
         /* set defaults */
         subleaf_specific = 0;
         always_override = 1;
+        ebx_mask = 0xFFFFFFFF;
 
         /*
          * Intel
@@ -628,8 +632,22 @@ static int register_intercept_result_cpuid(const CPUState *cpu,
             always_override = 1;
         }
 
-        entry_ret = register_intercept_result_cpuid_entry(cpu, subleaf_specific,
+        /*
+         * CPUID[0xD,0].EBX and CPUID[0xD,1].EBX report the XSAVE area
+         * size based on features currently enabled in XCR0/XSS. These
+         * values are dynamic and must not be overridden with static
+         * results from the QEMU CPU model. Setting ebx_mask to 0 lets
+         * the hypervisor supply EBX based on the guest's actual state.
+         */
+        if (entry->function == 0x0d &&
+           (entry->index == 0 || entry->index == 1)) {
+            ebx_mask = 0;
+        }
+
+        entry_ret = register_intercept_result_cpuid_entry(cpu,
+                                                          subleaf_specific,
                                                           always_override,
+                                                          ebx_mask,
                                                           entry);
         if ((entry_ret < 0) && (ret == 0)) {
             ret = entry_ret;
@@ -1688,6 +1706,7 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
     if (func == 0x01       && reg == R_ECX) {
         ret &= ~CPUID_EXT_VMX;
     }
+
     return ret;
 }
 
-- 
2.54.0


