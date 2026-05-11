Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29782CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 06:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMKHm-0007T7-T6; Mon, 11 May 2026 02:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wMKHl-0007SS-3Q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 02:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wMKHj-0006ul-3c
 for qemu-devel@nongnu.org; Mon, 11 May 2026 02:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778481513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GBu72odyTGge0+42NyrnTkyvavVr/t3/dkGBZgxa4r4=;
 b=LvXxZquNyBAH5BFbPBIM9P0wsiX8hn7khFtgm22LjakrzTA9S4sDN/quATphJ9Bea2yj8C
 LRyuFcKR6COdCLI5z8ix8BIx0gxB7eCTjRFpfByfsITp0ZjfgvJNVG/koPEMyITgAtQKke
 uCm0RBDf3RuVc3p+LnG+RtxT9+SMpyo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-f0hPScj6POirtfobSMmAhg-1; Mon,
 11 May 2026 02:38:31 -0400
X-MC-Unique: f0hPScj6POirtfobSMmAhg-1
X-Mimecast-MFC-AGG-ID: f0hPScj6POirtfobSMmAhg_1778481510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9F5A19560A1; Mon, 11 May 2026 06:38:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.145])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AADF30001BE; Mon, 11 May 2026 06:38:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v2] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
Date: Mon, 11 May 2026 08:38:25 +0200
Message-ID: <20260511063825.53633-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The elements that get removed with QTAILQ_REMOVE are never referenced
afterwards anymore, so the corresponding memory should get freed.

Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop change to hw/s390x/s390-pci-bus.c (since it needs other rework)

 hw/s390x/s390-pci-vfio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7c754b656da..db6de00bd28 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -101,6 +101,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
     cnt->users--;
     if (cnt->users == 0) {
         QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
+        g_free(cnt);
     }
 }
 
-- 
2.54.0


