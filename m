Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E04BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huo-0005LU-B3; Fri, 03 Oct 2025 11:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huH-0004yO-JC
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htn-0007ig-AJ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxJaUUvR8Jzy7NoPSeCmrpnAUB4ePBT5Wy/APf3vO3Q=;
 b=JdM5maXfn4h+0rwqZ26OidBEbXrWvwfh0Ejmm466MxFE+yUC8huDpLMtVrRlXRrp6Ana9T
 E7wpnI70GEhiOgRCWB82B4waB6W7WIiMG9as3Ml1uJgyybuTGZCAQYB16fHEC4T1+SEoQv
 /Zmj5zcj57pSnaBe805KRaSflNFcUCU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-YWUwBKh8MNy_h856AiSVng-1; Fri, 03 Oct 2025 11:40:38 -0400
X-MC-Unique: YWUwBKh8MNy_h856AiSVng-1
X-Mimecast-MFC-AGG-ID: YWUwBKh8MNy_h856AiSVng_1759506038
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-78f6250f0cdso45401146d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506038; x=1760110838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxJaUUvR8Jzy7NoPSeCmrpnAUB4ePBT5Wy/APf3vO3Q=;
 b=B+/nGp4hUbJfw2rvdO6LEkLIUdejkTXoOOxCGt8iqqYs8WUjVUXzQ/eWy3EBEeoZ67
 hZ70Aht8f44Aa1CzxAwfKercqX3VywB3Ydm5Bdo4rbe1JVZCN1tsdNzNWuRRy8K+72zm
 a5/x8kH7rGTTD/EawTwSGProx9KxJ9KR/inqmJXDP+3wqnjlerGH5wBeTakGSFiaaSPQ
 LXn2ErOY5gu6o3dZ+SGM3GNR3ZSsWrT0orNzGSZu28sukkAWCf9QM2ZCDpAiJIx/ac4V
 6XjjGp5C/CrCW4OsKmUb9nwhkMuPSyOxD5hBS7GTBve/lNO6uKE64JmmQf88DFQ8KwNz
 99Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtSNwi0TP9vxQK0C8cQpy93JhgE8x65A9AjQhXtXqzMJ4MDZpa1Z1RQB1igOvh/Q5vhR+o2FfeIQrR@nongnu.org
X-Gm-Message-State: AOJu0Ywn3c1/222iEz/D6UopvfJOKMRhf92fXLbZi8FbWw+yNRpLOupR
 ejiTvEqz0Px0Gg1yA6c4sbmrzuLkinHDgDsG3uI7JdLXFNmzZcMUt2PTyBl3j/MGl3H9JApaLma
 nvFt0MxWFJTkyWSXvHXrJEGhgXOs2G/ckRQRvj5fy6CnopJ8zyUrxqRTmT5B7pOh7
X-Gm-Gg: ASbGncvnGiJ1cpdXzSsr/z7bAFCn0OgooxlRFdKjTBatpgcWD1upt4ZwaIMbZBUzDjJ
 ufBjFzEMp6H4ubtZSWNOJf2F3pN4a+QVsUVRpuDclDjn6O1dQWP/cUtbOa6Mo3BHfrUpvk4x3Tg
 m/lfm7Rn+alL5llHHxSgAy7G5BgYoQQV3eF77f1Iv1xDOag9FE4OVDIdgCLjKC1eCNCtD1/MgVe
 YD9FqYaS+VGKs5dwPCSaFiEIQXZhYMyB5JPCLxgOTnx0IGxG4z7DD3X7ov4JJDHfLnzpLoYSVKd
 yPwGpf2iU06JY7sX8SwGXaAoLgaE9w2dXXc1uA==
X-Received: by 2002:a05:6214:1247:b0:71a:e4c5:72c7 with SMTP id
 6a1803df08f44-879dc7a4431mr43670926d6.7.1759506037836; 
 Fri, 03 Oct 2025 08:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBEB/XKX0oYsEy6bWg/KnQG2T8+1QcxivxEltvumZfK/uuNsyDazwLiAbOimNq0WIt7bvjQ==
X-Received: by 2002:a05:6214:1247:b0:71a:e4c5:72c7 with SMTP id
 6a1803df08f44-879dc7a4431mr43670356d6.7.1759506037309; 
 Fri, 03 Oct 2025 08:40:37 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>,
 Yicong Shen <shenyicong.1023@bytedance.com>
Subject: [PULL 32/45] migration: ensure APIC is loaded prior to VFIO PCI
 devices
Date: Fri,  3 Oct 2025 11:39:35 -0400
Message-ID: <20251003153948.1304776-33-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yanfei Xu <yanfei.xu@bytedance.com>

The load procedure of VFIO PCI devices involves setting up IRT
for each VFIO PCI devices. This requires determining whether an
interrupt is single-destination interrupt to decide between
Posted Interrupt(PI) or remapping mode for the IRTE. However,
determining this may require accessing the VM's APIC registers.

For example:
ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs)
  ...
    kvm_arch_irq_bypass_add_producer
      kvm_x86_call(pi_update_irte)
        vmx_pi_update_irte
          kvm_intr_is_single_vcpu

If the LAPIC has not been loaded yet, interrupts will use remapping
mode. To prevent the fallback of interrupt mode, keep APIC is always
loaded prior to VFIO PCI devices.

Signed-off-by: Yicong Shen <shenyicong.1023@bytedance.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250818131127.1021648-1-yanfei.xu@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h | 1 +
 hw/intc/apic_common.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 5567fd78d0..6f5a9fed68 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -163,6 +163,7 @@ typedef enum {
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
+    MIG_PRI_APIC,               /* Must happen before PCI devices */
     MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
     MIG_PRI_GICV3,              /* Must happen before the ITS */
     MIG_PRI_MAX,
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 37a7a7019d..394fe02013 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -379,6 +379,7 @@ static const VMStateDescription vmstate_apic_common = {
     .pre_load = apic_pre_load,
     .pre_save = apic_dispatch_pre_save,
     .post_load = apic_dispatch_post_load,
+    .priority = MIG_PRI_APIC,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(apicbase, APICCommonState),
         VMSTATE_UINT8(id, APICCommonState),
-- 
2.50.1


