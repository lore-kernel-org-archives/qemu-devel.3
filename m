Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC0C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6srH-0000EC-Na; Wed, 16 Sep 2026 12:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6sr6-00007T-TG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6sr4-0001dK-Bs
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789577489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DceylnPw8tnbzv24tzOsmyILBNWMpDPlJWn3IRyqBt0=;
 b=dCUmM534JUsgehSy+mqlZZjgE0Y+PjJXP1K9SIOKoyLgY8HtaRLE/tpYRzdURDtMVh2QIc
 TwlzRU/gDAGkUwWC51DsXivCMksTc3h2ihdJRlE1PIpo610Es5qvosaa/ZTG2NFMQr1NEO
 gFRI8uZEjPYPHqmzN5ufyjcHBNnAQ1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-98UCRXtTOlaUTur01Ul_bw-1; Wed, 16 Sep 2026 12:51:28 -0400
X-MC-Unique: 98UCRXtTOlaUTur01Ul_bw-1
X-Mimecast-MFC-AGG-ID: 98UCRXtTOlaUTur01Ul_bw_1789577487
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48709a1fbd0so1763596f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789577487; x=1790182287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DceylnPw8tnbzv24tzOsmyILBNWMpDPlJWn3IRyqBt0=;
 b=nlQu29mcEw/2liKzDVQCBiWVdML63fm2kcETsN8hbUxSXKfixJbXqzj+IlwXenPzhj
 j3ufA7M+eUPEQQkVEGGW5+3KAVtFRYCqHUmuyIw9+Z2QskcMgaMCsz/KEZyX0agO4pqX
 i6RuMwh7OitQ+LSuXqHRBvZc/Vu5tC6Ndz3ng4SnAdBhI/BDkS/S/v2vy6y4JSskjIPR
 +G5+dZ9kRJI5IAs7m+0c59+ebOmn/m7iP3pVEkiRJUzORguljsZxnMC7AZTs9VzJtDD6
 iXQANnnY1Q+PTqwQ2ezZ8okJpcrGowdabnPRsfckqaqjgSmjb5oG+t43GIvxUMOqaw5l
 hNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577487; x=1790182287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DceylnPw8tnbzv24tzOsmyILBNWMpDPlJWn3IRyqBt0=;
 b=JBMeybKeGwW1218ZQJn/IeH939/ZNbKA/RzMpbkOm/54KSa9rP4Bk6+AoZe7kswStL
 hj4ygYGLuBK8FSV7vAjXTrjjQmVCZTnJfIOMfwAv0LjmQ7e/iO3ch1VwHC7MC28ih4GG
 +eFJCiq6UntA240cW0AM2nvYAA8Gj2jIIdFOT2HnwjJWTgA+bDL+88+zLrdmBbEtIsUZ
 rHnjvRttcXWAbJfUWONdqrknZ9JxmF8+yqQeW8y7ZzOnn3OjYFR/bhVdiNc2iX2BAjP4
 gHImL20m2frW+zGXYG3lpW7Bd60DP6AZGXXaQYkOw7USDqfjG1DJ24yKWHR0W2dpD5VD
 wOAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDPFqjtSMGiOnuZMb6W8AAVevdw/02OcOhY3+MPM6j6Xyzjtk39Cu32x81t+K9xfh0SUVAVp9VZNPV@nongnu.org
X-Gm-Message-State: AFuF++l3RXJo5TdrR/k548lWOM/basNAqp5XffB831FG8j6r/0cL41DB
 aO3cqFG3NNHceAMn4k6/ba3DUb3Ma24mrOAvJqE7ymEiOfN4rKjM6oDrH4alHwCcA+O1sn+DRJp
 BHq7oVbXIuOiyz0hVGt3AysTyQJ73WroBQQpLofJRzUU95N6tkRzkWvcn
X-Gm-Gg: AYBFou3GWzKXP/bZUPMAQF1zErrm+cfXVK+0h4EjR9gaTHL7+8g2s5lyInqzaG3iYqY
 YXl/7WkW7cGzLjdf4rsB7QyNEYLRiXMmhVCn/1NK5FKNL3lqags/GmPO+qAb6eXC9TVbiqPuxT7
 KYBhQpxaGA1iIHYWsmONjnUsoosg5rPXPp2asiI/2E+rL+P0IhvvfSY2DFtYTR0P3G1Bh9Dg+g1
 bvX8PZa1YMI94gvugD6h/Pp8jsQwqaRRCNW2/nvkeRcYijIYjarGiBE75c1vmqGLuD0mOps9PmG
 fNjuupC3xdYt17u/dl4nKr9bb0f3F0dmboSUQE7ueMpbRb1nxcUt5GBGcGR7rfAfdzprcg+q+Yh
 vDQHgrT12imBEntK9XZoCuExVdoNCA56HCiDkPJKU7i4MKziYEvbeEpDqh1TLTQoXQw==
X-Received: by 2002:a5d:584b:0:b0:487:1004:3935 with SMTP id
 ffacd0b85a97d-48710043962mr3063707f8f.25.1789577486875; 
 Wed, 16 Sep 2026 09:51:26 -0700 (PDT)
X-Received: by 2002:a5d:584b:0:b0:487:1004:3935 with SMTP id
 ffacd0b85a97d-48710043962mr3063676f8f.25.1789577486519; 
 Wed, 16 Sep 2026 09:51:26 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af00a400b6f52cb1a2e89932.dip0.t-ipconnect.de.
 [2003:f6:af00:a400:b6f5:2cb1:a2e8:9932])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm9655089f8f.23.2026.09.16.09.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:51:26 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v6 3/3] arm/kvm: get demuxed ID registers from kvm
Date: Wed, 16 Sep 2026 18:51:17 +0200
Message-ID: <20260916165117.39764-4-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916165117.39764-1-sebott@redhat.com>
References: <20260916165117.39764-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Cornelia Huck <cohuck@redhat.com>

We now have the infrastructure in place to handle demuxed ID registers
from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ed99be7fd8..e4ef11945e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -244,6 +244,44 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+
+/* CSSELR values supported by kvm; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define KVM_CSSELR_MAX 14
+/*
+ * QEMU historically supported CSSELR values 0..15. This difference doen't matter
+ * since CSSELR_EL1.Level == 0b111 is reserved and thus CSSELR values 14..15 will
+ * make CCSIDR read as zero. Larger CSSELR values will only be necessary when
+ * support for MTE Allocation Tag caches is added.
+ */
+#define QEMU_CSSELR_MAX 16
+
+static int get_host_cpu_reg_demux(int fd, ARMHostCPUFeatures *ahcf,
+                                  ARMIDRegisterIdx index, int subindex)
+{
+
+    struct kvm_one_reg one_reg = {
+        .id = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX,
+    };
+
+    switch (index) {
+    case CCSIDR_EL1_IDX:
+        if (subindex >= QEMU_CSSELR_MAX) {
+            return -EINVAL;
+        } else if (subindex >= KVM_CSSELR_MAX) {
+            /* CSSELR_EL1.Level == 0b111 is reserved. */
+            ahcf->isar.idregs[index + subindex] = 0;
+            return 0;
+        }
+        one_reg.id |= KVM_REG_ARM_DEMUX_ID_CCSIDR | subindex;
+        one_reg.addr = (uintptr_t)&ahcf->isar.idregs[index + subindex];
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    return ioctl(fd, KVM_GET_ONE_REG, &one_reg);
+}
+
 static uint32_t kvm_arm_sve_get_vls(int fd)
 {
     uint64_t vls[KVM_ARM64_SVE_VLS_WORDS];
@@ -454,6 +492,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             /* Read the set of supported vector lengths. */
             arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
+        /* Grab demuxed registers. */
+        for (int i = 0; i < QEMU_CSSELR_MAX; i++) {
+            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
-- 
2.55.0


