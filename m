Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C25CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbf8r-0002PC-L2; Mon, 22 Jun 2026 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wbf8o-0002Nv-3g
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wbf8m-0007wH-DR
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782136602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/URF9nfbf9hl1uNYYwQxU/heW1PoSsB716FltVdjwqg=;
 b=PkgroGLX877tJxImvtDNe7lAekQ/xM+U9CxuFzJzbH35zUt9UMtdLcfYGMZdFJYc4oF4zR
 AOGKHIpSEuFKkznNoPrjTu5gQNq29gxxG2W400A3ngrypzmAsgqa0rtzCi91PypiNwDydb
 T4QvQDaiW66hqbsCq7TkxxnVIGhdkTU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-HOt69wpuOA2YDCWGIqlB3w-1; Mon, 22 Jun 2026 09:56:40 -0400
X-MC-Unique: HOt69wpuOA2YDCWGIqlB3w-1
X-Mimecast-MFC-AGG-ID: HOt69wpuOA2YDCWGIqlB3w_1782136600
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef4931de5so3197300f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782136599; x=1782741399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/URF9nfbf9hl1uNYYwQxU/heW1PoSsB716FltVdjwqg=;
 b=flsDYqaiy/TudWu9BnJFj9fLqXXgj/83PRADEv81ak5eBWngav7u3gvyKWkFxUc7/P
 ap1pfXvzUZPPBM0jJ0LtVyapEyQFmx+WvjKkz32l0nua4cyALP4YG+lHwadTBnzpMmji
 KrDJ1NH+1AaMPQgwQM/TMLL1fmyOw1UIu0nW2B+GQ+B1dmdENUwEFT3sppa0JbztQ8IZ
 UJHOGuakCJZ0KFsCJPoCQFH0zzorjZBz59rJYhtoe5wWoIDycf33Tg+jDaYgews7KbTq
 r7CP9NnJRGhAZQ55Id/jtf5oNZoTrbgdk7ORM7D0M0Fn8VhO2JlDAkYAiepybkdQY2+S
 lZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782136599; x=1782741399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/URF9nfbf9hl1uNYYwQxU/heW1PoSsB716FltVdjwqg=;
 b=KKccHlTVTOY4fLNs34uQHh2VExmjrebS3D0UIjf/miZZfgC+LsonaJR950zx1UMiZI
 xunJe7G/dcKOean+4RVmkVLQvirJeaXHx0tHD4OCIcAmoIONwhaEazp4aVbdJJKW01a7
 /9gzZtkP9TuofMNnz5hTJbw5P6LdAyhjW4Y2WXeM6hWYpMzs1Xehw9pJJRCAj6ZTp9dC
 onPyu6rcptcb0Bd0gfhLIcJYumc091pC8IFX3sZoZDso6TnQziRP50BSfw9r43+GVUy2
 9pFyQR98lUhLkFzG0+vCoCP84X4MI/kYf7j95vp5+W70E/dn567GLp+1LR7dC4aziCQA
 cLHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRl2CQvDcRDT6SGAn2c1ZkX3+sCg2X8PPYtIlDug/K84BFo73gtv2qP/ak84/gueLqQbkQMcjrNUPq@nongnu.org
X-Gm-Message-State: AOJu0Yw5As1rIbV5VI9xGEzfhXswd7Ahgg0QuhZyDj5nIBZgdPO0hIIN
 vG10/GEYhaxF1oPyQ2v8eBOU0qCt0m39YVbD6bhy+VtbetOCPbUz5I2+4vowhnL8mbwJlKBPPG2
 nxv0hgxlQV8DiJVMTQga6/QbDF7a5wBc90Cun1vYRS7QY1/HtZy0Zy1g3
X-Gm-Gg: AfdE7cllZM2ToLut4IuQWJ3aKveXOJA1VrsqU0MOO4cBWSDXnR3O0gyVQ/zvZSrq0p9
 +IDzkbGVUIkYi4OKej/idAUkSn3KbVYj1J1SVh3qLIAQdce5TNVAqkNEPiYomTNIe7Ao3JzfquX
 w5ab+9gh6Na84AH5XBVRaB1uWohpfl4OWEQauvLr7gnj5HD+nDA5mWRCo9NGPGwn4Rjn9xjpNOZ
 kEJkOFgb8J43z5qTG5PFSMJQ8Y8HCefoHDOTdytdlZtXiBG75YDHQwdkDrVtVX6Hf+nBI8jmzK3
 iOMZwbkdRGn/a0rOLXCedNOvPqgJwp5EtvKegywLCRDE6mAUs4SBoPzrFT2Xs3+bOp1A0UGNGF+
 pnPqMg8lwiZxAV/qMSCazHTT/s0+8D01Org7XicnJXWQVHbLPvWAtJHQh2HFwcvtL7ibBWQz4tu
 8=
X-Received: by 2002:a05:6000:1889:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-4651c4275bamr21841266f8f.10.1782136599643; 
 Mon, 22 Jun 2026 06:56:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:460:21e7:330e with SMTP id
 ffacd0b85a97d-4651c4275bamr21841229f8f.10.1782136599279; 
 Mon, 22 Jun 2026 06:56:39 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm25162303f8f.1.2026.06.22.06.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:56:38 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 3/3] arm/kvm: get demuxed ID registers from kvm
Date: Mon, 22 Jun 2026 15:56:27 +0200
Message-ID: <20260622135627.40573-4-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622135627.40573-1-sebott@redhat.com>
References: <20260622135627.40573-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

We now have the infrastructure in place to handle demuxed ID registers
from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a54ef51ec2..059d361d88 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+
+/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define CSSELR_MAX 14
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
+        if (subindex >= CSSELR_MAX) {
+            return -EINVAL;
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
@@ -286,6 +313,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     bool pmu_supported = false;
     uint64_t features = 0;
     int err;
+    int i;
 
     ahcf->target = QEMU_KVM_ARM_TARGET_NONE;
     ahcf->dtb_compatible = "arm,armv8";
@@ -454,6 +482,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             /* Read the set of supported vector lengths. */
             arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
+        /* Grab demuxed registers. */
+        for (i = 0; i < CSSELR_MAX; i++) {
+            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
-- 
2.54.0


