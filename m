Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD91C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNwQ-0005Wd-GJ; Sun, 05 Jul 2026 10:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwO-0005W2-Us
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNwN-0001PI-JY
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nMXYW48LA6fV03UPNCuWpcdWlH4nBmPiXP0Gti6mM1k=;
 b=PCuwbnbNVYBa0Br5up60BE1tTpD9tbub0p3M2INgaly5lQ6ic8iRqZOb5HnFknaWT4X++E
 L3F6gFkmwiFS9Plbo6gPV8F853WKLc7FRDf6U6XQ9lw1FvgEbqI4ILU+qbj92wwOg+PSzC
 o4HvALVZpwTDO4Nzyh0y+yr5KXoyqdM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-5utvMBdnN7Kw7QZp0KWXwQ-1; Sun, 05 Jul 2026 10:35:23 -0400
X-MC-Unique: 5utvMBdnN7Kw7QZp0KWXwQ-1
X-Mimecast-MFC-AGG-ID: 5utvMBdnN7Kw7QZp0KWXwQ_1783262123
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-475e540a0ffso1212426f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262122; x=1783866922; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nMXYW48LA6fV03UPNCuWpcdWlH4nBmPiXP0Gti6mM1k=;
 b=cxyUbf4Pkzq01m4dRG6E5AJIIjVLd85RYHRlXALlOvQenxZQNG6FKVtPsHIcP3qSGH
 rq11TjWx5zPNi9zDjtK+t0l9C4B63fkUWtDwJSFIaUR8A1IxJuBHpou6hWBbyoMvTYrA
 5mRxrYXs84SqktNpWNn70onjf9pESj7KVZxPOROxd7uwEYPu9w0hXmbE9gQCEuXd6k1T
 gT3mHKGx7cg54hHWZWUVq15UbgxMlxMdZ+YmZws3kmxZ1iyHHNcCVhxSV9qKkQ6S70eJ
 1al8jXpuHDP1iO9gr6RD2AvWtDHmkWp4RaKPp4fDGreeNkoi0ZH9ErZBy/yu6D+MYhnq
 BXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262122; x=1783866922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMXYW48LA6fV03UPNCuWpcdWlH4nBmPiXP0Gti6mM1k=;
 b=hEfhGTyc95kizrLkHHJr2vhlPWjtaX2LqAOEk0Y8cjHc+6hDFq1TioOmVwaVMhh7+R
 sJX8b3gjPk1xGI8G9g/q2TOn87PDnpq/p8+r7Oqg1WYDZHO/teyHPZa9XK0B6VI+GVW2
 8I/1ocx08YbfIF4oYyyo2SnZUtJmj4ZyigK6rtuLp+Yr8a7fbgg4tpepH/KaSl4RQmEi
 yeWTmQtSpvtwDHpdbUdDl6NHUgeI4iMAEH2WtYX4bLTOtcL85IPZkq+MOhhjzkXwSZuA
 zN7JsZM+p/vqfiLlIOyGUGDg4vx8tNQpikx6Hq7uI3oOEGXkCODdAIVTcRLD/+gVf2lq
 QKxA==
X-Gm-Message-State: AOJu0YxoBwO1jGCsMmKyHaGdG2lpCSZGxdwtzMq5lyevC0DVLnX8JkXu
 6IVWUYSrM/3p6r7NNdYCgESLGtJYu1+aRBvuFuXV1lesFSwcEa1Yzq9W747UY14FQWHZfm8A9YN
 WyRRlAU0RAbesS/us2W1DPVzQERot/1qspFI+mViIoLIoKiJDPJigdZ0RaTlAdnZV/EKrd9kgEu
 Ww/+De/6Uvk8TgqpX+uv6Dg62zwF4/o81nmA==
X-Gm-Gg: AfdE7ck2M5LwrDcy43Tbxh+wMxo+bKBOIC/qD6SDUhykq7HID+ZozIW9ZnnFQN3LfAi
 jwIrA9TBDIj0wi1yjpMUGj5KWLNxM5q6Rf2dcBb6VkZr0QFjUv8c17uce/6zfVQ1752yyzZIC+I
 MYJ423EuduSvnUomZ1PB7Kc1utb2sBea4s3uKRh9h4P9Yoe4PeXfXGWssRpDS3DyqXdq6IGUApg
 M+EpRCIaMcLmbQ8YXWU39bx7M2Rda+TOxCUSRh/TMdtEcxEQSjlulOnqVW0qjG7mlCnafqa3Z/D
 C7hfNxFhILvTWrXEBEGtN32e1QKeomSX69U6VRXjPs6pqQf8HLFt9y7ckUoZ+EoXr7YQuOyj6p3
 6xeI8n2TZdHczjzO1cAlAi0ftLcKdBg6P
X-Received: by 2002:a05:6000:718:b0:474:4525:eb32 with SMTP id
 ffacd0b85a97d-47aaa60dea9mr7176658f8f.11.1783262122412; 
 Sun, 05 Jul 2026 07:35:22 -0700 (PDT)
X-Received: by 2002:a05:6000:718:b0:474:4525:eb32 with SMTP id
 ffacd0b85a97d-47aaa60dea9mr7176611f8f.11.1783262121790; 
 Sun, 05 Jul 2026 07:35:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm16150051f8f.22.2026.07.05.07.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:35:21 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:35:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, no92 <leo@managarm.org>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/44] intel_iommu: Correctly set pt bit in extended
 capability register
Message-ID: <dbc0ed56223011281e14b5cb8c02453915d35d12.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: no92 <leo@managarm.org>

With the changes in c7b2e22bd957, the `pt` bit was set in the (wrong)
capability register, instead of the (correct) extended capability
register.

Fixes: c7b2e22bd957 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field")
Signed-off-by: no92 <leo@managarm.org>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260624103933.1793586-3-leo@managarm.org>
---
 hw/i386/intel_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 744cdfd2e6..d1af7a3135 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4988,7 +4988,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (x86_iommu->dma_translation) {
@@ -4999,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
                     s->cap |= VTD_CAP_SAGAW_48bit;
             }
     }
-    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
+    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
 
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
-- 
MST


