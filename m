Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EF8D29C4F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vht2f-0001KK-08; Mon, 19 Jan 2026 12:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vht2d-0001GG-LN
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:27:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vht2a-00009q-94
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768843667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPvnPaaK0u+4ohUVkIOSAe2b7NOHsNsQPRfXZZ57nGg=;
 b=iax16mGFLwM4DWl4RytHc8lM8TwST8dzZbqja1fK9360DzhFhws/O9xBKZpdnH9+yJm4sC
 GRVuz9643h6PbdVaIOLlMZlMU5hvo+UFIH3Qcjc4Xq99EyZlmge/lgHYQdS8XIZDXVcb1k
 Pev6xkaqXRddZhHB+bmXoRweTnwevOY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-3vyIL3JZNGqiYUmB6tx-Qw-1; Mon,
 19 Jan 2026 12:27:46 -0500
X-MC-Unique: 3vyIL3JZNGqiYUmB6tx-Qw-1
X-Mimecast-MFC-AGG-ID: 3vyIL3JZNGqiYUmB6tx-Qw_1768843665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E28C71956046; Mon, 19 Jan 2026 17:27:44 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-210.str.redhat.com
 [10.33.192.210])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5697419560A2; Mon, 19 Jan 2026 17:27:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH RFC 3/3] arm/kvm: get demuxed ID registers from kvm
Date: Mon, 19 Jan 2026 18:27:32 +0100
Message-ID: <20260119172732.140613-4-cohuck@redhat.com>
In-Reply-To: <20260119172732.140613-1-cohuck@redhat.com>
References: <20260119172732.140613-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We now have the infrastructure in place to get and save demuxed ID
registers from kvm. Use it to get the values that kvm emulates for
CCSIDR_EL1.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 48f853fff80e..ab73b3a29f0f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -243,6 +243,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
+                                  ARMIDRegisterIdx index, int subindex)
+{
+
+    struct kvm_one_reg one_reg = {
+        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
+    };
+    ARMIDRegisterDemuxIdx demux_index;
+
+    switch (index) {
+    case CCSIDR_EL1_IDX:
+        if (subindex < 14) {
+            one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
+        } else {
+            return -EINVAL;
+        }
+        demux_index = CCSIDR_EL1_DEMUX_IDX;
+        break;
+    default:
+        return -EINVAL;
+    }
+    one_reg.addr = (uintptr_t)&ahcf->isar.idregs_demux[demux_index][subindex];
+
+    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
+
+}
+
 static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     /* Identify the feature bits corresponding to the host CPU, and
@@ -256,6 +283,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     bool pmu_supported = false;
     uint64_t features = 0;
     int err;
+    int i;
 
     /*
      * target = -1 informs kvm_arm_create_scratch_host_vcpu()
@@ -416,6 +444,11 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
              */
             err |= get_host_cpu_reg(fd, ahcf, ID_AA64ZFR0_EL1_IDX);
         }
+        /* grab demuxed registers */
+        for (i = 0; i < 14; i++) {
+            /* KVM only allows 0..13 */
+            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
-- 
2.52.0


