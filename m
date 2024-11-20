Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A329ED743E6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDshW-0008PQ-H6; Wed, 20 Nov 2024 16:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshS-0008HB-CG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDshQ-0006Sx-JK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732139843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EHmLep7AvvNAIAY6Sg1hRRUPZ6LsfZnIsPCnbrbppo=;
 b=Nidy4+8Uc55iLPtVvyoczRRIcV3ht7H0HObWBmD45lQ5bAMJkbmmiLJDYhMghU1q3QQiLm
 AwGmQ4454L9lqF9ngDqtYCKneUnosc8TTsNyaM5QtVyY8uWAAxjTtxiN4EARicx3ySsY1G
 RHyCXbVtDvo8Qzg3YWU0wrqCEJTTDFM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-igXLQSU2PE-GW8_ljdmJ7A-1; Wed, 20 Nov 2024 16:57:21 -0500
X-MC-Unique: igXLQSU2PE-GW8_ljdmJ7A-1
X-Mimecast-MFC-AGG-ID: igXLQSU2PE-GW8_ljdmJ7A
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4608a1a8d3eso3806091cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139841; x=1732744641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EHmLep7AvvNAIAY6Sg1hRRUPZ6LsfZnIsPCnbrbppo=;
 b=Pl1LjtKfC3F8C8th92t+OJkevE6CRMtH1Nl4vUfK3Z8ubPFtphxwOr6BbDwoLZ9dE6
 iJKKXXjzS3nFb7GKuY1BOfWYmCKi5Y32vApucFwWsMi8jme9utdtSECePi7VbtT1pekO
 cFRXS+ZXtBdmudbLTp+x4Wx9w+tMxLPVyoFbItfV55Nk35Lrm3sAGpPUxTiaeLWB25x+
 7PhrfqMp++TQEYE/tpr2WfNYh4ClIopqEZGSrecb/B9jcRYQ1svvPSwiooxZ2s8bb4MB
 fTYOk2tD7uZLi+PVGkK9/KhjG1b+cUrsQM5ioMDMTBc7Y8spwKlHA4E8CgNwzaEOeRiL
 XGUg==
X-Gm-Message-State: AOJu0YwJ5CB4ESdsFwrL9uYmefz+LbrC/GB3VJYuAvvk/HvrVIkrUvct
 4RsF+71ivWLEyxWe8ShDFTBtw3Cb+gGCBRS0s2yxEhsKF9dy8PajShZDcI98vkiISMvi783x3JE
 ApB4y73ESd/zSyfAyq25gyzxzwB6Ex8mAD5ocRxYfWcFtYwZEiddOxr/rWyUB+P+7UwNUj0NrtI
 UDdo0sHypSqQRddbZic779MHEwyAayiTOBfA==
X-Received: by 2002:a05:622a:90e:b0:460:a82a:39c9 with SMTP id
 d75a77b69052e-4652f4223b1mr18963541cf.10.1732139841039; 
 Wed, 20 Nov 2024 13:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhTpJFYFPaqKrCGOnAQRP/66QSpuJXauYaNnVDsD42aETz7S6mjdkTaLvKyjx4avskcOkRBg==
X-Received: by 2002:a05:622a:90e:b0:460:a82a:39c9 with SMTP id
 d75a77b69052e-4652f4223b1mr18963051cf.10.1732139840694; 
 Wed, 20 Nov 2024 13:57:20 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-464680d6826sm14632881cf.15.2024.11.20.13.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 13:57:19 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bharat Bhushan <r65777@freescale.com>, qemu-ppc@nongnu.org
Subject: [PATCH 07/12] ppc/e500: Avoid abuse of container_get()
Date: Wed, 20 Nov 2024 16:56:58 -0500
Message-ID: <20241120215703.3918445-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241120215703.3918445-1-peterx@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

container_get() is going to become strict on not allowing to return a
non-container.

Switch the e500 user to use object_resolve_path_component() explicitly.

Cc: Bharat Bhushan <r65777@freescale.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci-host/ppce500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index b70631045a..65233b9e3f 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -418,8 +418,8 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    PPCE500CCSRState *ccsr = CCSR(
+        object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
 
     memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
                              0, int128_get64(ccsr->ccsr_space.size));
-- 
2.45.0


