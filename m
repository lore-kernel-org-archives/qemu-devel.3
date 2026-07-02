Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5406C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHaa-00087V-Dc; Thu, 02 Jul 2026 09:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHaX-000860-TA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHaV-000186-Rw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782999379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HITbRUTeXA1wLotn5EvEHiy6VVopLkZs61O7SoCF+I=;
 b=De0/HWMUh1+UFvmV5jjwIeru/aRH8vCIrpBXPmClYLfste0WYYsnQctQJsvNziwBNedsIo
 oEbEtOEBO6eLiIUa8ESOmG5ROBzTrVV34Iso3KyIYIbNDWvMvJDnJTRJKNSkxit1S6FfND
 b+2OBGRl/WXPJ6YNNNkR0Qgc5kjJvs8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-oY8aCXILMGORJVPMmv6LNw-1; Thu, 02 Jul 2026 09:36:16 -0400
X-MC-Unique: oY8aCXILMGORJVPMmv6LNw-1
X-Mimecast-MFC-AGG-ID: oY8aCXILMGORJVPMmv6LNw_1782999376
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c1bc7a70so17770385e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782999375; x=1783604175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HITbRUTeXA1wLotn5EvEHiy6VVopLkZs61O7SoCF+I=;
 b=ronR+u5OAbSpdBPO1xDAemNgJkQTBsGXl2BWjwtsLOS00ODvWEGDT0IKyqSGVeD+RZ
 cyqwCbqgea3nNR9ne8BihV7wUQaGvr3wO+wvqK8Q7Firi1yO/E9ylt2ruvu+6+Rk0qrn
 u8JdhXuaZtnTtFJ1OwBcWE2xcVOD+5jJg1ilBMW0C2KJ4X0jaBcO9yc3wVHXxqgSH1Eu
 ea6mubtnp6AvLHn4uIR21NuKMoY7UZK/WXmFbABULhFlJc5gL7Zd4s6q21GmEwZLJyKb
 9BOtJ6ivAayWnDP3nTQJ//Zo83YlFXKLqf+vrTaZ/AnmXmFc2vHMwUqgCPdVbvAS0T1c
 J6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999375; x=1783604175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HITbRUTeXA1wLotn5EvEHiy6VVopLkZs61O7SoCF+I=;
 b=qjhaAbaUMQRqS1JhCxgAzXqZTBE4Tz+HjSr1Pf9lVsCHOQg40/Aomd4ON3UIQvltJt
 5uISQ9HnYHAobqK9j+rMvc3h57p9mvHxo+xZZz/iUdVWCADepucJizqujF6A19dzwAIZ
 OgtRVzyTb7jhC/U1iFh4HkXD2/TzIoLVsmaPq7XZcatPLHNXRVI/p3CKvD8O/F88Lf/o
 OAh+v6EkLVL3ToTQQ9lX6slTHGCtt6CdpGQQaEFhCzixXSW/mMGnjY6mlUGcBk0OMESW
 7DbEti6kKvjI2FNWWM2JJ0Zqh32lITaye6/dcmQ1U4QDfbViszv5JEBTugL0yLDPi6ml
 /+aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7xN9eHMNzSTchfAItDw6q0EtPzMslLcMMRCskUooaoFvDPY3PyXDeNJB6Y/M9C22Ff6nF+iIyFy8p@nongnu.org
X-Gm-Message-State: AOJu0YwluAzhN6LksRsYA6by5DMR0kUSgcgKXHaVI7uzU36YBq6NLFNU
 6N1/3UaDtEej1FNNQKcMF4DjxuLFTS/86i6Zx3GWdV7MWm0XFRH1x2bG4djB1foS4F7hy7GVXR9
 GEOACWpILx7YsJPXW+WWf0xhGDFmx5ykVJbiRr9Y/eDkzgadthJAk3x5j
X-Gm-Gg: AfdE7ckqX9pGMDMUHqusXXsuv+yEf0HrqrxcoxThwKErizPnZiGJ18TmzmmUaQ/wBBD
 FrtenK9w1KFm4FJ4+DrvyBZD52pplfhAf67Cl1hwBr5BXH0PFANwClKDBlXlMxSrO0Zo38Vt/n+
 w2ZGnsh4fea8HisQH/cBunzngCKGgKfsRA9xJStpACxS+Kp1Dp2UaztzYmYW0aecGw5I19db4VC
 ZlL2IzF6vhN+Y95OT/G+g5rbBwbbjLSGMeum8VclZOvVDw7vQZIYlipYoDQrr4zUhqHAiwbR749
 OlsA8OvsIfTbPHQnXQbX2nmYYCLiJv3ThITMRMFOqES6cHuaxLsVAluMiz8L2h28FlhbVNOCuZM
 UuFxKyyZhlF3fUYpQ+wfCNihWNYbe340ObktBpvHptFT+GNWQ1H/3KS0SrAO+/1Yow3I4Jcf3ew
 ==
X-Received: by 2002:a05:600c:820d:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-493c83a5b92mr16574235e9.28.1782999375455; 
 Thu, 02 Jul 2026 06:36:15 -0700 (PDT)
X-Received: by 2002:a05:600c:820d:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-493c83a5b92mr16573725e9.28.1782999375055; 
 Thu, 02 Jul 2026 06:36:15 -0700 (PDT)
Received: from rh.fritz.box
 (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb01sm9135980f8f.1.2026.07.02.06.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:36:14 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v4 3/3] arm/kvm: get demuxed ID registers from kvm
Date: Thu,  2 Jul 2026 15:36:06 +0200
Message-ID: <20260702133606.34529-4-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702133606.34529-1-sebott@redhat.com>
References: <20260702133606.34529-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
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

From: Cornelia Huck <cohuck@redhat.com>

We now have the infrastructure in place to handle demuxed ID registers
from kvm. Use it to get the values that kvm emulates for CCSIDR_EL1.

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a54ef51ec2..f57e86b441 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -244,6 +244,33 @@ static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
     return ret;
 }
 
+
+/* CSSELR values supported by kvm; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
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
@@ -454,6 +481,10 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
             /* Read the set of supported vector lengths. */
             arm_host_cpu_features.sve_vq_supported = kvm_arm_sve_get_vls(fd);
         }
+        /* Grab demuxed registers. */
+        for (int i = 0; i < CSSELR_MAX; i++) {
+            err |= get_host_cpu_reg_demux(fd, ahcf, CCSIDR_EL1_IDX, i);
+        }
     }
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
-- 
2.54.0


