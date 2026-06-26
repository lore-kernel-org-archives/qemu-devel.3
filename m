Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8460CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eO-0008Ir-TX; Fri, 26 Jun 2026 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eC-0007iQ-47
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eA-0005I9-E1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUildyp3TUPi9XOxQ9Vei4gm0RWYOEVpQJ4nVR0PZPc=;
 b=GCBZZRpCMIUSyo/SOZiFzdExtmr5IHNy18eyLYnma15VW73Hv+/jfSw0No2bn+DyOctbxU
 3r0xz2pCvDwqx4PS3kD6Q8HBdqNv2XykgZjU3oku90o+krSxBUIfjUSpHtryb2cOgeKOey
 fwLhBg5BIwpwlALVjQKHWT9UdPHf2VA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-torXdF0YOvyD5SAy-nWG5A-1; Fri, 26 Jun 2026 06:18:52 -0400
X-MC-Unique: torXdF0YOvyD5SAy-nWG5A-1
X-Mimecast-MFC-AGG-ID: torXdF0YOvyD5SAy-nWG5A_1782469131
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so5386355e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469131; x=1783073931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUildyp3TUPi9XOxQ9Vei4gm0RWYOEVpQJ4nVR0PZPc=;
 b=AisAVjHToxNvyrNWWAn8SXcA3uDZ9B9VNEQR/SB07oi6sQdU1u1oS/gwId7+VD/eag
 hkacfXwmPY1a93aCIuzoW55g+/0ZhJl2db3OniDV2aj4vGco8HiZP2C34XFfUgAxokeD
 WJ3jvSUhmILwHNm7cRz0tfB8y2dOmwHWWEmcbVKCjLma/SmKX3q2QNtMFqqfbZVigbO3
 VZoZO6ZPd5Y9iB7KP5vpGn6MvOqFxPPmEVl6kfXCkm9cclo/wNQhFBmp3R5R6glmYnVU
 g22RMxICe2FoW4yhQZ+Zeqy+lU2HobYbfgggoidlymLmZ12njoztOZ5m5MFiI+RVXYJZ
 G7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469131; x=1783073931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUildyp3TUPi9XOxQ9Vei4gm0RWYOEVpQJ4nVR0PZPc=;
 b=c/aB1MUVJweIBMeQq59ADR8f4BovKJGpc5V1D23eMB1lq+cgEgflmUFqAGjy1Xhhka
 lxEuyoA/GjAtzHgsM3/1ElnS0w+gRc0n4VEizVlG16D3p9RZiqG6OxCIOr3HDYkAvxCF
 9Pheb0Jf/kPGEs5pevcaNJL8oOOwTvMcQzOj/4d9w3d4ZEuH3dbUdU092VxBoY1DWNsY
 H6WxKbxL2cnmz70VLyvPnV0Z4oBkxXxyUYQbKpYs4qRMB1n2gpNgf5gRkwRUaHZToYSl
 Ik+j4fuynKuyL0XuiPDXVmbq+vEODfcGGJ68A8qjKSzGqpOgZGGHO0VkVwSH0lHddFoS
 IDjg==
X-Gm-Message-State: AOJu0Yxxcu40U7yUlSsghbu/XIP0T3LLpjbohLJgg6iHWPZEG7pLIAYM
 L46xz+DEwjQLUj35Pv0hPXe+bKWakWtg+dhT3++wqa7zHZkB1sATAf8RpheAWhWa2kbJI0fiTfT
 +EDnw2cadfr6ZQk3wFyrh+NuS8CACADqxrt0maVNPj7I0aE8mf74/KQg4uGQfUB7s0wqmi6BKKI
 Mb4l8GNyFMCGkDlPIE1qgWqi+2k0RqIxA5h2DKEMDt
X-Gm-Gg: AfdE7cmboT/NKwknGdLeWZReetHswArtIFLbDbuweRcwuxbCs8IGag3UaMRJupjZfND
 Gej2wc1ixMKiRzdOd1Oe9X1OSBAQyJ+sJTP05mac4/e+FtnOtTRz3EQIxlMZTF/YFxgXGkuBSuh
 jFPT1X8tFST3wNU5yTP2z0nLMzFHqseOFvdWwdcpuT22PAu7VCjfPPvQReTrB5cVNID3m1JZbfQ
 fsHxdDIBiObGEZqM6e32TzBFyhn0d/biHg0c2gmboXOdl1NvgZ4K8rjN+FChKQb8/tH72MYPAz6
 5wxjZGbZ13xLC6Jc948LivH7Sk+YP2m2SAygO0RIvbBad5vvikIel1Ezj1/wHo3UqnEYhOweU1a
 5P5hWHY/TuAQIAjr9G1u45kpM6e/Z4OtLv+JqbQOWNbLZK/GFe9KzN9HQtzW4uJyt0rvPO4+A4M
 F9v6L0Ls8SFpw/pYse
X-Received: by 2002:a05:600c:1c05:b0:490:ea8a:32da with SMTP id
 5b1f17b1804b1-4926689ee78mr82398625e9.26.1782469131439; 
 Fri, 26 Jun 2026 03:18:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1c05:b0:490:ea8a:32da with SMTP id
 5b1f17b1804b1-4926689ee78mr82398205e9.26.1782469130997; 
 Fri, 26 Jun 2026 03:18:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49269086ab7sm96886425e9.13.2026.06.26.03.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 22/45] accel/mshv: remove redundant msi controller
Date: Fri, 26 Jun 2026 12:17:25 +0200
Message-ID: <20260626101748.1728079-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

The remaining MsiControl infrastructure can be removed now

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-14-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h |  3 ---
 accel/mshv/irq.c          | 11 -----------
 accel/mshv/mshv-all.c     |  2 --
 3 files changed, 16 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 68b84ce2c8d..5eef2e6e2cb 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -120,7 +120,4 @@ typedef struct MshvMsrEntries {
 int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
                        size_t n_msrs);
 
-/* interrupt */
-void mshv_init_msicontrol(void);
-
 #endif
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 52b8ac94790..4828ac51ac2 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -25,17 +25,6 @@
 #define MSHV_IRQFD_RESAMPLE_FLAG (1 << MSHV_IRQFD_BIT_RESAMPLE)
 #define MSHV_IRQFD_BIT_DEASSIGN_FLAG (1 << MSHV_IRQFD_BIT_DEASSIGN)
 
-static MshvMsiControl *msi_control;
-static QemuMutex msi_control_mutex;
-
-void mshv_init_msicontrol(void)
-{
-    qemu_mutex_init(&msi_control_mutex);
-    msi_control = g_new0(MshvMsiControl, 1);
-    msi_control->gsi_routes = g_hash_table_new(g_direct_hash, g_direct_equal);
-    msi_control->updated = false;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 19a44bb13de..b06eea2a5e9 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -505,8 +505,6 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_init_mmio_emu();
 
-    mshv_init_msicontrol();
-
     ret = create_vm(mshv_fd, &vm_fd);
     if (ret < 0) {
         close(mshv_fd);
-- 
2.54.0


