Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCE5C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBj-0004KP-MG; Thu, 01 Aug 2024 06:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBa-0003V7-V8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBX-0001rU-Rp
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DU7KGa++gwwIicNjWXeVcClxHOVzOhaCuJuqsj2Fe7w=;
 b=KDz2JVjwlr+8bTymPzToQoNzqico5ub2PtdV7HnIg88erGmIcA8q8mUcDs41sCQU3wiFFn
 q5H0ArZR+GIebH+Rvu5jwFDa6n9MPTyKNYHcgbKqS88NxCIj+GIeVHKfknwUMwL7AUJnwt
 81X0g59ftBIY2WDKQowrEUZOcd8UrbI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Rx_PeyNjP9qwG9AlXwhU_g-1; Thu, 01 Aug 2024 06:37:26 -0400
X-MC-Unique: Rx_PeyNjP9qwG9AlXwhU_g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7aa5885be3so605015866b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508644; x=1723113444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DU7KGa++gwwIicNjWXeVcClxHOVzOhaCuJuqsj2Fe7w=;
 b=viQBc/hNRqvvAOxLxA+bXb6cvwW7N2qeFaQk5kAT1K6V46WXw88oD+WEnDMeEa8E0W
 TvnwqkasjmqjcXoqWACbBS0ktoz4H94/cSwodPKVzpN+Z7EDMB51RcrThPLEUVsqdiDU
 Qs3ICM10zHp17ujGPjANVLTZZxOunqUlpL7UCy68AIBRWrzLqV2ZElDfXuvMj2swocKV
 JqvtY3nq5XfqYrCANB6SrGHo4oBOgQiXKV8BF7oclyUyvD4/iijthbbZJ+FQDNOGW2em
 HMPGiQKUylPiEenoc6Dh98UrS6E9/Km11YUl2SPS8ABjQJp5DRf6cB3hqVEqRBHg4RYs
 5Lwg==
X-Gm-Message-State: AOJu0Yx7aj5PjVUlkWRioPAWps07Uv/F7cgywDb6avOLSYlEbBw+WnPF
 FikjSD0TJXm3aI+9hMM5nVpBBHcDVD4dj/LvIo3Hzuhfitkp77rsgfI+06NMn4hzTFJyjmdIFIg
 2jbCT0IWl0eoSarlLMSCVcJ0eNQ+r6U0oJoHucBZ5FXcskoLrd/ctnVl8Qq8nNwb9jUivOwDRI1
 81FhBIzZni2ICzyGw30p6fl6Ny4WQLXQ==
X-Received: by 2002:a17:906:caea:b0:a7d:a25b:31be with SMTP id
 a640c23a62f3a-a7daf51ccd8mr155638266b.39.1722508644608; 
 Thu, 01 Aug 2024 03:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm9R6o8hktFQi7D+CHwbuIk0rKKqyF/OtdLHMoscFAYnHfDKTsnT2hEUwJ6C6nK5RVj8s2Cg==
X-Received: by 2002:a17:906:caea:b0:a7d:a25b:31be with SMTP id
 a640c23a62f3a-a7daf51ccd8mr155634466b.39.1722508643923; 
 Thu, 01 Aug 2024 03:37:23 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm876174866b.7.2024.08.01.03.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:37:21 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:37:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 yeeli <seven.yi.lee@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 19/19] intel_iommu: Fix for IQA reg read dropped DW field
Message-ID: <515457757ff8540c524ff39ea1d9564b251c6532.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: yeeli <seven.yi.lee@gmail.com>

If VT-D hardware supports scalable mode, Linux will set the IQA DW field
(bit11). In qemu, the vtd_mem_write and vtd_update_iq_dw set DW field well.
However, vtd_mem_read the DW field wrong because "& VTD_IQA_QS" dropped the
value of DW.
Replace "&VTD_IQA_QS" with "& (VTD_IQA_QS | VTD_IQA_DW_MASK)" could save
the DW field.

Test patch as below:

config the "x-scalable-mode" option:
"-device intel-iommu,caching-mode=on,x-scalable-mode=on,aw-bits=48"

After Linux OS boot, check the IQA_REG DW Field by usage 1 or 2:

1. IOMMU_DEBUGFS:
Before fix:
cat /sys/kernel/debug/iommu/intel/iommu_regset |grep IQA
IQA             	0x90		0x00000001001da001

After fix:
cat /sys/kernel/debug/iommu/intel/iommu_regset |grep IQA
IQA             	0x90		0x00000001001da801

Check DW field(bit11) is 1.

2. devmem2 read the IQA_REG (offset 0x90):
Before fix:
devmem2 0xfed90090
/dev/mem opened.
Memory mapped at address 0x7f72c795b000.
Value at address 0xFED90090 (0x7f72c795b090): 0x1DA001

After fix:
devmem2 0xfed90090
/dev/mem opened.
Memory mapped at address 0x7fc95281c000.
Value at address 0xFED90090 (0x7fc95281c090): 0x1DA801

Check DW field(bit11) is 1.

Signed-off-by: yeeli <seven.yi.lee@gmail.com>
Message-Id: <20240725031858.1529902-1-seven.yi.lee@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9a768f0b44..16d2885fcc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2947,7 +2947,9 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
 
     /* Invalidation Queue Address Register, 64-bit */
     case DMAR_IQA_REG:
-        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
+        val = s->iq |
+              (vtd_get_quad(s, DMAR_IQA_REG) &
+              (VTD_IQA_QS | VTD_IQA_DW_MASK));
         if (size == 4) {
             val = val & ((1ULL << 32) - 1);
         }
-- 
MST


