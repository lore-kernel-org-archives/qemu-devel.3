Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B486BCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3e0-0007GN-Pj; Fri, 26 Jun 2026 06:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dd-00074X-2n
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3db-0005AR-3h
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jpxIFYk+jJh1Eu2hO0yA4J0IN9FE9t7jWDg+Y5ix4I=;
 b=eDIxtzd4EQYCEV7nhJ2eUSGUq22hGwMMjdGK/3f3GG9Ow6a11+7yym3usyt2D2VWfwA7wP
 T9/r92++A04eF38XcpCwAeLVzTL9qpzLXVHcF71Qp4cDDUmM58DUE7luP1h+A5a9Z8zzEP
 4nUXnHdpDNJB63DQWdiCQOmIrtTp8Ow=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-X4K65HJCM0eOyqamf_Jm6Q-1; Fri, 26 Jun 2026 06:18:16 -0400
X-MC-Unique: X4K65HJCM0eOyqamf_Jm6Q-1
X-Mimecast-MFC-AGG-ID: X4K65HJCM0eOyqamf_Jm6Q_1782469095
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46e4153b193so861107f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469095; x=1783073895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jpxIFYk+jJh1Eu2hO0yA4J0IN9FE9t7jWDg+Y5ix4I=;
 b=Yv1I2EunWtiNX9PLmr7iI4FjyOdPfwI2qtOWQgmEqUveiTXfECDN64st+p7zoq/yBX
 +EVvd/DkMFyUhqiQS7W3h6M8y4iQzX0m3sEz4sQT2Z2P9WNnaUnB25AatqLH7w+lpfEt
 bk85IcOgUrbL1aNP72Bcj5WzgVat0mM/b2VzX1/BEVH7xFkUN1SUR/JMAMN/VyqRz4a0
 kdl/h4qTRfXf0sSHqQKKNRtTeA7f5kW9wCSGVsZ6fHPJK3l9vYsh85QZG+KuiWubg7mq
 N+v+aR5UkhyIJpvUTX3ZRiRhGG7gUk0b7QuyDWkpRAfQONGZJ8aQbS/abds/P+sOYvRZ
 kSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469095; x=1783073895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9jpxIFYk+jJh1Eu2hO0yA4J0IN9FE9t7jWDg+Y5ix4I=;
 b=hwIQAXAvy+TKD5Qt1cDC4/Ky9e+0G5NsPnrgZa9q+D7MhEoGXCA6vWEtGdPtyrxG8Y
 vBN5HSCmbONMAAK1E+tSj+zwaY/sfzLB7FHdsCWfYnI6SCDg9VOQFkTkfTPhsDrBuaXR
 X6okqecB/XEzxoRxwQf3NTYxhN2xaUtsdTdNenaUNAF0wZkoeNlG+mlEc8Jb0Y4785j6
 it0ArxEED/WWputZIDOYABZpaOp50lOh/gG0zzGsHyEU7XQdmUsveY7fS+Luh35f3Sh3
 22cK/sgWGXY4oZPvGQm2Qia3yYBW+XGcHa3okCR6O9Gosc9t5cU3oyDj18kLcY7i4cS6
 OHlg==
X-Gm-Message-State: AOJu0Yyy0OYYwamlizqwCrOrkA6bZ66KZHh4Tgs/Lt9+cJDRkDPzw84K
 mz/q1dW+rXGq9Aty5q05CCbSxbgRMl43A8pwC95cBqPrNPOaQdl/qz6RF5ueHn3nSw5YBqpjXMl
 GI1WiE+V1qjAOCUyL5iMnNIYx7Wa/q8PNufMG/bMSvWPt4uBJZ2HL/+dtP3fDj8yEO+9Ec1/uop
 eDdY3fjUOTXt9dU+ICgH9S91lBES2q0ikx2EpyFjtL
X-Gm-Gg: AfdE7cnbWd26ePk1LUSrJn11b0PWrNJ2Jmg5KcXOAnH16Zdz3wg+T3GR4t/gFhWwcor
 a7TaB1Uw0xCan8KHTyr8HZAg9xhbkGhgTCsnq9t4yFIB40jY4PuuV0oNE0sqWcnVQt/Xvzz7LCM
 HvAIhbjWO0XQRtch37TQrfW+Zfq/KEYfiFnjkhouSSulIKKhRJ3iZnJr9A12vaK1xQm7a99Cy03
 4izICy+Mvglds72bLa4KEXLqnEEWU25PLjBT8PKtLcrE3yx3gOyOdxPGvLMC84ak3xAV6hexh2X
 pGqavaKD8o1ZE+NSsGPkpHYvyOD6ZbNg+OUAVqSYodGyXuflIDynsZORIGvK4fAioEHzDA5jpCL
 EGTc0ZnfUVJcXeIjReYMXEq/Gzwpli1ViUHOOMkU+/SDl3d6+PD/zkMJ2F4PCOEv6tM14tQOn1u
 h+bOMKUa2wrGnVetrh
X-Received: by 2002:a05:6000:2489:b0:460:10f6:a554 with SMTP id
 ffacd0b85a97d-46a806bc9e7mr27745607f8f.14.1782469094962; 
 Fri, 26 Jun 2026 03:18:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2489:b0:460:10f6:a554 with SMTP id
 ffacd0b85a97d-46a806bc9e7mr27745531f8f.14.1782469094409; 
 Fri, 26 Jun 2026 03:18:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01c3bsm25046563f8f.10.2026.06.26.03.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 09/45] accel/mshv: disable la57 (5lvl paging)
Date: Fri, 26 Jun 2026 12:17:12 +0200
Message-ID: <20260626101748.1728079-10-pbonzini@redhat.com>
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

This change disable la57 paging on the mshv hypervisor on both the
mshv processor feature bitmap and mask the cpuid feature leaf to the
guest.

Since the removal of hypervisor-assisted gva=>gpa translation in
1c85a4a3d7 we have seen MMIO errors in guests on la57-enabled hw. We
will have to investigate and test this further.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-10-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  2 ++
 accel/mshv/mshv-all.c       |  7 +++++++
 target/i386/mshv/mshv-cpu.c | 15 +++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 35386c422fa..ca156cdf4be 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -94,6 +94,8 @@ void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
+void mshv_arch_disable_partition_proc_features(
+     union hv_partition_processor_features *disabled_features);
 int mshv_arch_post_init_vm(int vm_fd);
 
 typedef struct mshv_root_hvcall mshv_root_hvcall;
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 0f65b65d9ca..52623be5d93 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -142,6 +142,8 @@ static int create_partition(int mshv_fd, int *vm_fd)
     int ret;
     uint64_t pt_flags, host_proc_features;
     union hv_partition_processor_xsave_features disabled_xsave_features;
+    union hv_partition_processor_features disabled_partition_features = {0};
+
     struct mshv_create_partition_v2 args = {0};
 
     QEMU_BUILD_BUG_ON(MSHV_NUM_CPU_FEATURES_BANKS != 2);
@@ -177,6 +179,11 @@ static int create_partition(int mshv_fd, int *vm_fd)
     }
     args.pt_cpu_fbanks[1] = ~host_proc_features;
 
+    /* arch-specific features we disable regardless of host support */
+    mshv_arch_disable_partition_proc_features(&disabled_partition_features);
+    args.pt_cpu_fbanks[0] |= disabled_partition_features.as_uint64[0];
+    args.pt_cpu_fbanks[1] |= disabled_partition_features.as_uint64[1];
+
     /* populate args structure */
     args.pt_flags = pt_flags;
     args.pt_isolation = MSHV_PT_ISOLATION_NONE;
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index e85311af2af..3523cfcb70c 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1129,6 +1129,12 @@ void mshv_arch_amend_proc_features(
     features->access_guest_idle_reg = 1;
 }
 
+void mshv_arch_disable_partition_proc_features(
+     union hv_partition_processor_features *disabled_features)
+{
+    disabled_features->la57_support = 1;
+}
+
 static int set_memory_info(const struct hyperv_message *msg,
                            struct hv_x64_memory_intercept_message *info)
 {
@@ -1707,6 +1713,15 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
         ret &= ~CPUID_EXT_VMX;
     }
 
+    if (func == 0x07 && idx == 0 && reg == R_ECX) {
+        /*
+         * LA57 (5-level paging) causes incorrect GVA=>GPA translations
+         * in the instruction decoder/emulator. Disable until page table
+         * walk in x86_mmu.c works w/ 5-level paging.
+         */
+        ret &= ~CPUID_7_0_ECX_LA57;
+    }
+
     return ret;
 }
 
-- 
2.54.0


