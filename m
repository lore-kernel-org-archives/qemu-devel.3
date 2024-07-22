Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87497C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkH-0004oW-L0; Sun, 21 Jul 2024 20:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkG-0004hu-2R
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkE-0005mT-0N
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WC1Cgro28U3oLUDw8Qk8X84jYg2eBltkPTuz6OTl0qY=;
 b=T1YK+n1bzWgO5x5nWLZMqdBCiXx8cAVHi6nYZ1QkJqs1nyp9deN60Iil5hFxJ61qVrvHC6
 eCL9w22he07cmHevtMYVemInJ7PzfAMCcqGMO1zcBLuB5s0YmggUzK+fvbDehC5HPQnR6y
 iFhgz8Q4FnXk8Ul4h74scLkvrON4v/8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-9-1Z4KQIP8WAZSAi1yvGvg-1; Sun, 21 Jul 2024 20:17:35 -0400
X-MC-Unique: 9-1Z4KQIP8WAZSAi1yvGvg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-368442fef36so2960287f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607454; x=1722212254;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WC1Cgro28U3oLUDw8Qk8X84jYg2eBltkPTuz6OTl0qY=;
 b=ia5aaE657XQa3nx/kwzH1qpwnSyd0YqrArGw6bUg4LlUOCPhFBX51/KqEo5ig9HAq2
 b4Fj4lFbC9dqSCZZZ69ol160tzAJl8f2cVwEuumPQj4M6+r1IlIO7Qn2o33GJIMRtqq9
 6Qwuo+mAcZRjaW9vxpPf7qMD/QbUMxzzh3bB5fWaG+/7xqsZ6bIPKWFN6zNqL10iBGcN
 6n/Sp5DE20p3Eju7QqLtEttBmg/D7W1MGCM5zP3nb84msBA7ndjmRGhLQeQLgUGdXano
 7/ParfO0IOYpz4Z0y9mf1s42dLoloq0C76ro7c2ap/dRy8f+ST3cVouol4vFmk+CMQVm
 MI2w==
X-Gm-Message-State: AOJu0YxMsFRwfjidKxVFTAz0k+jW6/0XkhxwcsOguuGrnf9LeXYKyZbR
 qLbl2AVJ90XaTCJSxh3QNZ0QdihdKw4NfcBWqebH4oFewXM0ezSP73N3iQIJb76pB0NbC5doYTC
 94qJH8XF7GhXEMSti1B6Bf+yi77zajbMzKKXH8N4wyl7pU6XaLbq8ipX/VYk6MZpWinT3e2mY6a
 LXEfVQA3njr7FTPtN67phyDFI8S4qzQg==
X-Received: by 2002:a5d:64ed:0:b0:368:5e34:4b53 with SMTP id
 ffacd0b85a97d-369bae39577mr5053411f8f.10.1721607454212; 
 Sun, 21 Jul 2024 17:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhI25xxo5osTRvdNcXeoB9bvPfLQg2AUhQStlCujqDKb/VG+XxYCw1Q57Lft6axRvoWbrdpQ==
X-Received: by 2002:a5d:64ed:0:b0:368:5e34:4b53 with SMTP id
 ffacd0b85a97d-369bae39577mr5053388f8f.10.1721607453623; 
 Sun, 21 Jul 2024 17:17:33 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684801sm7066955f8f.11.2024.07.21.17.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:33 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Minwoo Im <minwoo.im@samsung.com>, Yi Liu <yi.l.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 20/63] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Message-ID: <d7258f7a250716231d23d5412dd6caf923936549.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Per the below code, it can overflow as am can be larger than 8 according
to the CH 6.5.2.3 IOTLB Invalidate. Use uint64_t to avoid overflows.

Fixes: b5a280c00840 ("intel-iommu: add IOTLB using hash table")
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240709142557.317271-4-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index faea23e8d6..5f32c36943 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
     uint32_t pasid;
     uint64_t addr;
-    uint8_t mask;
+    uint64_t mask;
 };
 typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
 
-- 
MST


