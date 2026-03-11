Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05D21125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LJs-0000Mf-DO; Wed, 11 Mar 2026 11:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LIm-0008R2-GQ; Wed, 11 Mar 2026 11:16:54 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LIb-0000Td-B9; Wed, 11 Mar 2026 11:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242179; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QDMYEVrlJwbcXce5Yk7h/LeJRAE8tg4VM5w2nM3XM/E+1XRQs03iHk2Uwk8XoyBLPXkMeK1BfPq4LZByYzxLdlwX5ZympU4WfLRrdsCGFWmzweDZOcWJnTHSlnO4GwueqoeHnj4F6ZtWbObZduLpF0Vs6SP6XFMD7MlJZqy6+6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242179;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nnxi2E4Xn74nsogu63Kucnhb6M6Yf3N0O05qPW20wss=; 
 b=M3oiPHwbybrbxn/u3Aqm9+NsmsnlN0TRf21oy9QEHQXBBet46Oh+mZnBf7BEQOsUBWWzbpvdDRf8dU4qpjgG6RcBYKTMPrQxtkeSnUuwSFXrP3QqBE/NeEiu8r/piG3AQsSc+dzYB51dMb4VaiwDC4Eu54XlXblayMBcudDcqd0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242179; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=nnxi2E4Xn74nsogu63Kucnhb6M6Yf3N0O05qPW20wss=;
 b=QP5qb4GGklg4FKd5uiRlEp3rHI1rFLHyjordBO9H/2Vzv1XrqFDVvUDS9fNHKb6V
 E3eiVz5xlyb4Uxn8uLfkyo0IQR/65jHMT5Hxm0L0T4Ps8/s0iBshK/RbR2faLALODvD
 mbYXyCfnvG2TRme2/xWMkf+gYPWD7j06nhCXuExA=
Received: by mx.zohomail.com with SMTPS id 1773242177382941.9424272222914;
 Wed, 11 Mar 2026 08:16:17 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Wed, 11 Mar 2026 15:15:28 +0000
Subject: [PATCH 01/14] accel/mshv: provision guests with the same features
 as host
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mshv_accel_arm64_supp-v1-1-c31699b7bc1f@anirudhrb.com>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Query HV_PARTITION_PROPERTY_PROCESSOR_FEATURES to obtain the feature set
supported by the host and pass on this feature set to the guest during
partition creation.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/mshv-all.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d4cc7f5371..3b8b9ef116 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -110,21 +110,64 @@ static int resume_vm(int vm_fd)
     return 0;
 }
 
+static int get_host_property(int mshv_fd, uint32_t prop_code, uint64_t *value)
+{
+    int ret;
+    struct hv_input_get_partition_property in = {0};
+    struct mshv_root_hvcall args = {0};
+    struct hv_output_get_partition_property out = {0};
+
+    in.property_code = prop_code;
+
+    args.code = HVCALL_GET_PARTITION_PROPERTY;
+    args.in_sz = sizeof(in);
+    args.in_ptr = (uint64_t)&in;
+    args.out_sz = sizeof(out);
+    args.out_ptr = (uint64_t)&out;
+
+    ret = mshv_hvcall(mshv_fd, &args);
+    if (ret < 0) {
+        return -errno;
+    }
+
+    *value = out.property_value;
+    return 0;
+}
+
 static int create_partition(int mshv_fd, int *vm_fd)
 {
     int ret;
-    struct mshv_create_partition args = {0};
+    struct mshv_create_partition_v2 args = {0};
+    uint64_t host_proc_features0, host_proc_features1;
+
+    ret = get_host_property(mshv_fd, HV_PARTITION_PROPERTY_PROCESSOR_FEATURES0,
+                    &host_proc_features0);
+    if (ret < 0) {
+        error_report("Failed to get host processor features (bank 0)");
+        return -1;
+    }
+
+    ret = get_host_property(mshv_fd, HV_PARTITION_PROPERTY_PROCESSOR_FEATURES1,
+                    &host_proc_features1);
+    if (ret < 0) {
+        error_report("Failed to get host processor features (bank 1)");
+        return -1;
+    }
 
     /* Initialize pt_flags with the desired features */
     uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
                         (1ULL << MSHV_PT_BIT_X2APIC) |
-                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
+                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
+                        (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
 
     /* Set default isolation type */
     uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
 
     args.pt_flags = pt_flags;
     args.pt_isolation = pt_isolation;
+    args.pt_num_cpu_fbanks = MSHV_NUM_CPU_FEATURES_BANKS;
+    args.pt_cpu_fbanks[0] = ~host_proc_features0;
+    args.pt_cpu_fbanks[1] = ~host_proc_features1;
 
     ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
     if (ret < 0) {

-- 
2.43.0


