Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E5AE9539A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnd0F-0001vg-Pq; Wed, 04 Feb 2026 08:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vnd0B-0001v9-1V
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vnd09-0005iF-IE
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770211980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+syS+GxUclP8EdbREjab5UTXYUS0sMyMOX4XUbJwMA=;
 b=flCm5EFFHXEua1aLaxtYPnZ7LKDaWi1HIhh+L05MpLu/rYRYHJLh4t0m49llrh8HvwSNV6
 7CIZXlDqY+KyVmP6Eik6v/AUikX399Zpk5oX0RTCPGb6rXMv/tdituis3n8b/6HEGzAuCI
 mhtmIWyCKHeUibXk57SJkMmwOpu0ttc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-MD2oCXt4O7mJ1j5dv-XLhA-1; Wed,
 04 Feb 2026 08:32:57 -0500
X-MC-Unique: MD2oCXt4O7mJ1j5dv-XLhA-1
X-Mimecast-MFC-AGG-ID: MD2oCXt4O7mJ1j5dv-XLhA_1770211975
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CA64195609F; Wed,  4 Feb 2026 13:32:55 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-192.str.redhat.com
 [10.33.192.192])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E28281955D85; Wed,  4 Feb 2026 13:32:52 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 3/3] arm/kvm: get demuxed ID registers from kvm
Date: Wed,  4 Feb 2026 14:32:29 +0100
Message-ID: <20260204133229.297061-4-cohuck@redhat.com>
In-Reply-To: <20260204133229.297061-1-cohuck@redhat.com>
References: <20260204133229.297061-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0828e8b87bac..9ed51969f075 100644
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


