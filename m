Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39277CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 13:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unzea-0005iT-AM; Mon, 18 Aug 2025 09:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1unzeW-0005iC-LY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:11:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1unzeR-0002uq-Na
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:11:56 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-323266d2d9eso3032184a91.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1755522696; x=1756127496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FbgFlks82+K7QdkLz2cY3GBIQNowq51x6EYWWVh6KVQ=;
 b=kq5yMzZZpOx8fSg6Ld0miH9R3XXpEzW7vH2D3+vDJg7jRNHzjLAQv1TvQxYdKt+2p3
 H7WPajnz55pvO5RsgGzzGHrKcf/Zk7kPWa9f4erXbElgx3pLj2sd6RMuHQ30VyG+FRYt
 OERwIzl3/9mRLSWUHbLFz8jsDBXIiWZtMlqc5CWhtyvOiInOaRofubWPNY23AVZBaPHS
 jf7jRc8O8p10soLDWP3Zu8gtK6WRhthMq536486cF5n7E+/ZeVliSXBVgsKgPY+bfK58
 Z8nRbH/k7/K4KdqQUQ237mXOWTc96+QOoMjyvspWsR/A1bOSqPV3lawbsMgp4h+BDigI
 iyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755522696; x=1756127496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FbgFlks82+K7QdkLz2cY3GBIQNowq51x6EYWWVh6KVQ=;
 b=Nkw2C/4tUPKEFw9SzXPU0u75v7xr2w2Bx9KiyCdho3LYbND3Db3AGWXRUFP4a3avtZ
 +K3s+Z94l3i2+PAp6PphcQditJfIlFC+IV5Mawru28oKn5w2YJh3dd4uvROYh1ukRn5g
 jhjhxROU8kkUEEm8GVHQRsxO1dTvfTcfzp81FIc4OrMsG2wKp8/c7V+NZHwtCloinsJf
 KlFXXJs4UK2+8Ow3TZa0aaTRw/2CaFs/fPbNrjBcx4R32F0PLGfduRFuHVOpmnBUHOYF
 bWM+5sI5LyuOnYsYrSMRwD+qmFeOHibNlIcPmLqMw7h6HxJ3JdzVqKn6/JoXg6kvZ9qu
 Mvdw==
X-Gm-Message-State: AOJu0YziL22nNTcQ6u4AT2CZi3HR9zgWxGxKijTMbmfCePgGO6yVNhJA
 f1xyghE5iCCpNQfooxNN/nNORX/rHLfM48khqbtZXeEcoAsUS2APfPvbgzO7XqRo/BE=
X-Gm-Gg: ASbGncu0hLsmzexp31IsxLC73xeC9KXLMYtO1k/2PU0gym/ni3a/cq30QU+4n2bFlt3
 ZHEHD7fzbTpiRfKCh8nnQlmYBIkzlG+mr3WKYEMTcnxtEYyUCVa2fz61gGarf3zFSFPvNezadiP
 fSrS20XWLPpTrPhaj0ctfut6xKpkA/QuiboYBHv4NBTc8MWMy2LoW+MBSe886g0/0oEWrYm8ish
 gdaVes4SvOL15pnGy3rFVoU7N27Lq8AC+AturXbJp+tW4E6eDUYirx2pxHyh8KrakNc0gj0iWP5
 keaLiPWWOZGtW7QjA1B8GK15J7ScOdh+4dgZInnGj0u12a/jJb+rSz1Ylw7Zcau5Ku23sgmhM9b
 /spN1I0/taw37DDjdQ0Gfmzeq3cDe5zA5kiez8EXv
X-Google-Smtp-Source: AGHT+IHdNJj8/I49cpTlgjsAOvF69TOVtCpzK37YO7N22KsOOcNT32Wf8xaun2npqt8zIy8Dkuv9iw==
X-Received: by 2002:a17:90b:5101:b0:31f:6682:bd28 with SMTP id
 98e67ed59e1d1-3234dc3b9a3mr15381331a91.16.1755522695910; 
 Mon, 18 Aug 2025 06:11:35 -0700 (PDT)
Received: from n37-071-053.byted.org ([115.190.40.12])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3232a7b890asm5596361a91.4.2025.08.18.06.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 06:11:35 -0700 (PDT)
From: Yanfei Xu <yanfei.xu@bytedance.com>
To: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org, yanfei.xu@bytedance.com,
 shenyicong.1023@bytedance.com
Subject: [PATCH] migration: ensure APIC is loaded prior to VFIO PCI devices
Date: Mon, 18 Aug 2025 21:11:27 +0800
Message-Id: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yanfei.xu@bytedance.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/intc/apic_common.c       | 1 +
 include/migration/vmstate.h | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac4..22e988c5db 100644
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
-- 
2.20.1


