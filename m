Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21145C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZVj-0003Wo-1x; Tue, 04 Jun 2024 15:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVh-0003KO-Lq
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZVg-0000xr-09
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=W0Gt58qV/FEigNP+5udIrmtxE5r/NgRxVTUdqRm6V+Vo6lYFfa2Y3Md3TdX/oKa6ApBijh
 jDJRxPH4eIcm4WqiohQC5mzTiadlvEp7518B1XWrlO8wNlMHs+67UcYzTERJ8ALNOGY1cS
 /AL4dweFaGEOimX32ylBwtT/YyGncn8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-_Zk0_7QuPFuD8eiOzYJShA-1; Tue, 04 Jun 2024 15:07:50 -0400
X-MC-Unique: _Zk0_7QuPFuD8eiOzYJShA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35e7cce4c32so1055328f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528068; x=1718132868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFUPapk07PnJ8CLhVhbjjsuC+NoP2UxN6SJb+Hfxl60=;
 b=s4sV7GQAz6FRvhM5r9O+xaE6/WohwmC76c1/sanu8c7zbv9QyWKEROMrg+y/lk6BxK
 qJ+3nJxq3ezQciG0pnAfKRy7BpoiRdorfQvHMeRjuo6cweL4lhXz6c7Xzdebx8J9zxVn
 JlaiCEKv4ZMFrgOvuuJvY2roA1cNJ6UeIgzbodx1gfEBn1ELXXDQ7z5lrxI65E4oukHz
 vste7Os2JwXoiw3cowDY+sd6KcjPclLjDiTEywiF3ARImJMXgTbK+P3ZF/1MZ9Aw0GGn
 S1nYLUgsp2O9eRKSrKONT+AKlDxakXr+cunAm3cW6BydxXYsNd30Czv4KKg0UubaEQyt
 /BJw==
X-Gm-Message-State: AOJu0YyBVyoTuS+DiEAHTok02P0FnLl/yVpeLJg7bZ1Mu8Jkk5h/D6ux
 w7OQIKs2m7o4m9C97yGSSIhmI9BIWNNSvWOeFrsUiYEaaGwKK5kel01r+L41wKlBCQ0AhJaGN/q
 1dn3DBJcAo5GZMsSypj5HOwCaxKyQ1j3OWZQegrN68GiMkOJPNL1jBdTrUv+/kzBNfDmxq9/LXo
 CGYl5nvMGeMZEpAS98H7EOcK9PvbC/lQ==
X-Received: by 2002:a05:6000:d0e:b0:35e:83c3:48cb with SMTP id
 ffacd0b85a97d-35e8ef93fedmr235716f8f.67.1717528068288; 
 Tue, 04 Jun 2024 12:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQp0e7dBdyt71188NymBMa3QkPpuGkRfzjcqcU5FZ0eBtRJjlLpDwgNGnYcCtOA4LwbSOC1A==
X-Received: by 2002:a05:6000:d0e:b0:35e:83c3:48cb with SMTP id
 ffacd0b85a97d-35e8ef93fedmr235694f8f.67.1717528067837; 
 Tue, 04 Jun 2024 12:07:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04caf05sm12262706f8f.42.2024.06.04.12.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:47 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 30/46] hw/mem/cxl_type3: Allow to release extent superset in
 QMP interface
Message-ID: <ed2a51d1e637171208b119b0d81164da1af7da52.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


