Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C1C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCw-0000Bz-RZ; Tue, 23 Jul 2024 06:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCe-0006u3-IQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCc-0001nq-Dr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WC1Cgro28U3oLUDw8Qk8X84jYg2eBltkPTuz6OTl0qY=;
 b=FF7hEwLlmZ43G008jmf7cv1KSINLu1NUmspkMudW3NIyJCMnJn1SE0vSZXjkvKelJce2h9
 TJmRfFfx06esNi/9Lax0VWSrWIxtbcR51ndG+gh0mKoCEZr7lziWAKcmmrEsm5Xu+uZJyM
 gZeO8BXpySGt5E/TR36MyDhTxG6wW0E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-fyRdH6TVNZ-x-MstMVQ81Q-1; Tue, 23 Jul 2024 06:57:04 -0400
X-MC-Unique: fyRdH6TVNZ-x-MstMVQ81Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a2a0e94a66so3994082a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732222; x=1722337022;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WC1Cgro28U3oLUDw8Qk8X84jYg2eBltkPTuz6OTl0qY=;
 b=ItuQA0GanUAoiwA3d1CKR+Sda7Y/jHD1U2PwBpzM5Jk6iRMqw5Ijffy128xReh4LOf
 v2z7EfEBuKMETmUGm87dOHT+/tC+qHMJfu+XK0+SeMnbx43AxjcJN4sqcCNzYGi5NsTJ
 SbOvYMPg3USY7cyE7fKJJ32D+noLaKvxQenHik5jVrxqsK5nQoYksRPBGiqOVrZ9oUYn
 lfa83rK+oLu/9t6zYCRG+HWvjGr40WtfUCIyfQUwEC05eHQFV9o7eK4l9tdmP6YCYweC
 PcQY0uND7PVER72wH5DXfKiQ5ZFG1/2nbBVtu31jO1B1KfrKj8JDtD9YH5X2jt/jdn7v
 7xdA==
X-Gm-Message-State: AOJu0YyRAlNE8+ndKz1QzAZHsAHPDUxBbqTaDGXVQ7RgXJJsPwCCVCKk
 kgK23AIYIT6ipgjwVP1uTmM1Ndtz8HS06ZXBoShL21VMsjW6crbdiw6bg0NWek+JniieneAr2uJ
 /NEw7E9e6YQdL+V2VMkwVm09Tk8uqHAgioRN6RxZyZx+rFxN/frs+YbxvgJO0zUrT1++4mwOdJk
 nSZ1nlOLebNhlrkKN1pLDgNjKeOInR+g==
X-Received: by 2002:a50:9fa8:0:b0:5a2:6e1c:91ed with SMTP id
 4fb4d7f45d1cf-5a47a61f401mr6277824a12.27.1721732222516; 
 Tue, 23 Jul 2024 03:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFngaLEWVNAm2xW3IjAH02fubLsBqMy5kprjDrw0tjkKVvh094BB0CqQbSXa190El3/pM08WA==
X-Received: by 2002:a50:9fa8:0:b0:5a2:6e1c:91ed with SMTP id
 4fb4d7f45d1cf-5a47a61f401mr6277800a12.27.1721732221895; 
 Tue, 23 Jul 2024 03:57:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f8645sm7313748a12.72.2024.07.23.03.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:01 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Minwoo Im <minwoo.im@samsung.com>, Yi Liu <yi.l.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 20/61] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Message-ID: <d7258f7a250716231d23d5412dd6caf923936549.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


