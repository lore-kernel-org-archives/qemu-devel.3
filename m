Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3128DC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEW6-0001Tj-1v; Tue, 07 Jul 2026 18:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW5-0001Su-4s
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEW3-0004Di-LA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cabc0a1ab6so1139225ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464226; x=1784069026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy1WYXDMPJXXkl+s8HBgu7HsPDMpRrDpEl9BRUa+Lhg=;
 b=Cj27luMcmy9Y2Lr6MywbadVYwdWET386wKEyQOJpOTgZ2o4J9dGF0Saw30lShp2rmg
 +ukg02rRMb9IwIfi6Bz2EGbGSn5pZcmTj88POLcH2IDk4aP2r1XYx9YylDKhvGpQ814t
 0MNswViW5L/zaYRQZCDIcp84F3av+0zCgmAvUKnSWMOae/ifhbksqTz8Rl746Bvyl2T4
 55FHxCaV3/l2vYP9DZQoJayBYzGTbFC7URjUXgdIpP2wNcpcvp/xAtC3j6hY/mpVBxC8
 B/YLk7Jqmqmup11J7BHcSRYaY/Zrs5TNZI5gD1W1MJCrzd60N8Dlx9GhiNS8F5qMJ5+U
 zR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464226; x=1784069026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xy1WYXDMPJXXkl+s8HBgu7HsPDMpRrDpEl9BRUa+Lhg=;
 b=jfz4otUCw3oMgvurjkyY0Z/5mJm4aY5b6yADO4gQde1WT4xAph5hbM77JQ/z6NlzCE
 yHCxC7pynjR4V9Wjdg1Xyb/8AIy8jDAwa8i5o+JXwTczcTMwEHFKH6Xc6d3gxbz2XgoA
 9BUlHzECKruxANX7xZnOK1bfbhVhe4XakVju/PCG9UuqMr6wiFbcGuNLJ407GPph9z0Y
 qhFghYCTnjz6DoHTD4FtINGVPPmfDg8CalUzQDT+ndH5teMu93NwHnBUkaJe6dllTpFk
 HDWozB/Njs1/nIisnXk7gzyqbRQ25hIW2eIa1hE0WkbFHWBrXkMQNtB4zxin9yI1/nM2
 X6xg==
X-Gm-Message-State: AOJu0Yzk/JmHxw7Udmt+xXc5ZyMnEVzS4dMBgvV8xqKC+p4c7zlSu/fP
 fANdJEPDva9r0pnhK+UFv9NCA8loRCO/wToiItulFhWuTlKcSmYdBsAKGdwz6GYNnkY=
X-Gm-Gg: AfdE7ckRdAIt0OmE9D596MjbvamdQ1O21tBEx4cgIhJOJe/JjGa3pwlDR3lpJCmAZwz
 GJiAauEX5IAKJFLOLjcUT/SoSvk6cYLPQ7VqoLkwuGXCTy/erRZ6ynakRX+h+1BQaMazOczIhBH
 lKTjvaun9JEL7HQ5ed1DeRwby+sJdK8NjbQPmrcEpI1gw4INO+QM04MnpwMFtZsIzaiwyWbQ+y1
 1QUuIoEauQwwUTsrgHdXT0dovCrIQf6sgVpnRUpS3BD7Sm2yfNOQzTuwtAIjphH5AZPobEneQqx
 SKEscpKxWD7SRPCI6xpLtbgfaL3BMFYuCcpt+coQ9S6X73iqNIo7t46/Lwsx++IpyTXlI/EebIR
 /jOAECs1TN6qRxdIJxhRme9CN3uwiWIVKzyY2J3ooGyKcT9epW368BqpTh5AGGyd6JBTi1jCt0J
 5qXZ56gg27vFnMSdDhnefmd8rBB23ITEKb2Envp5E=
X-Received: by 2002:a17:903:138b:b0:2ca:dd3c:dd0e with SMTP id
 d9443c01a7336-2ccbe7288d7mr42932815ad.2.1783464226177; 
 Tue, 07 Jul 2026 15:43:46 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:45 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 18/25] hw/arm/virt: Reserve one bit of guest physical address
 for RME
Date: Tue,  7 Jul 2026 16:42:59 -0600
Message-ID: <20260707224306.1202330-19-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac16290b442d..d98d8108c8d2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4053,14 +4053,24 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int rme_vm_type = kvm_arm_rme_vm_type();
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    if (rme_vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4069,11 +4079,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.43.0


