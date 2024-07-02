Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41D3C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeBU-0004CN-HB; Tue, 02 Jul 2024 10:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBR-0003pj-U9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeBQ-0008Cf-2m
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=BnxtlM91yj03wI9asrZvP0JwFIKHOuRaVmjS2HP6UbuYVWSJmjsI23rtMTekHGGvLJJ6D4
 nRsYceCA1EQOJMCV04IJLagHWtlSj1Mq34nVFdpXRRjPHTjv+9yBnLJ5eQ6ZwV4AdxwMMW
 BpnlHsJxtGe3GBbMhoaS/f0z8UMNKH0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yJWFgpvlP0e8Lp9KKyadrA-1; Tue, 02 Jul 2024 10:08:32 -0400
X-MC-Unique: yJWFgpvlP0e8Lp9KKyadrA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso19222955e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929311; x=1720534111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=IwJtvy7+x6VdX0ieXCBjpxK7YKtnAvKV+cXjVVy5x5eIQaWEiBVpaVzVZMYOt50mpi
 6yB8iSSXNDDeNTDpkHND5Rw8YN3nJThGv8k6nWLVKCn23rtoIpRWGMM3mbniW7rTfbVb
 kURgSkF+ZZCvwU7CEnqwmNdBb3BXbJladScpyKA5aVZK4wfT34H0qXo4gkdL6gvPUpQ6
 v5INpna9uyD+6nS5vNb+9AlvwzOHLaKAUEG3Y0Y54JHogN5qUaKiN8+Jy3ulBj+e4MxS
 FV5/FBPUgwFO7RsBrvQAdQyX3UeFrf+OR+1a251q/OOa0RtunYb+Bug7iPcXmwoGQmDM
 P+Cg==
X-Gm-Message-State: AOJu0YzFPeJgRJpuighXRjxgNIGQ9DFTGNbpZMcWNNqOkxvsP6DbwE9N
 GYzhHcuFw24OdDcitqtzNGhuqZuu/716wjQU7A/CfGDJIiML7R4mWMwcVCzRiXBV47DnIo6Lfle
 xXBrDwV6X4QQF5dLBRL+E/iNfrD0vLgT4/RXnUk8QTqY7czJMLBX7GqRlasc4K+mxd2OsGNfRgH
 QVqno77ASEVTZMIHO4ZNyzS0nwPUsXxw==
X-Received: by 2002:a7b:c458:0:b0:424:a655:c8b with SMTP id
 5b1f17b1804b1-4257a010ab5mr58862765e9.19.1719929311402; 
 Tue, 02 Jul 2024 07:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8VuEGxyfX1E4eygZUT+D6B9/QgjkiBFNHFLZX/IlHRAeYyEiWkuA+aZweZmup7TL3k3Q7Hw==
X-Received: by 2002:a7b:c458:0:b0:424:a655:c8b with SMTP id
 5b1f17b1804b1-4257a010ab5mr58862525e9.19.1719929310849; 
 Tue, 02 Jul 2024 07:08:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b12sm13309086f8f.44.2024.07.02.07.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:08:30 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:08:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 29/91] hw/mem/cxl_type3: Allow to release extent superset in
 QMP interface
Message-ID: <c51dca04281f9be6eacdad8fc8f9c7ddc87dcf3c.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-15-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0d18259ec0..5d4a1276be 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1947,7 +1947,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
MST


