Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E42DCD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVVyp-000286-Nm; Fri, 05 Jun 2026 10:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVyo-00026w-I5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wVVym-0005O8-SE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IK2zUvZzYstfygcBmDiaz9MR1+tuQ5L5vdZXT9nUUd0=;
 b=gvZMV1/SOC3Sb051239HVxwLRek7YxwMAK9UhbPDbILxUDUZG/14jZ7SX91CnHB5uk6R1a
 I7Il31Km1Sg9ADFsxnmButjF5d5Di7tLfOln3zX7Buk/wY2RKsBKJS5Y40jTfPmaeOu9Py
 ZLV2ASaKRTZWgPsk5LHwyp5ipa7KPnE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-ilsdAcdBOyeAwp1G5FMHsg-1; Fri,
 05 Jun 2026 10:56:58 -0400
X-MC-Unique: ilsdAcdBOyeAwp1G5FMHsg-1
X-Mimecast-MFC-AGG-ID: ilsdAcdBOyeAwp1G5FMHsg_1780671417
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E616518001F9; Fri,  5 Jun 2026 14:56:56 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.48.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 109D0180049F; Fri,  5 Jun 2026 14:56:54 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/7] hw/s390x: Fix memory leaks after removing elements with
 QTAILQ_REMOVE
Date: Fri,  5 Jun 2026 16:56:41 +0200
Message-ID: <20260605145647.272621-2-cohuck@redhat.com>
In-Reply-To: <20260605145647.272621-1-cohuck@redhat.com>
References: <20260605145647.272621-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20260511063825.53633-1-thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-vfio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7c754b656da0..db6de00bd285 100644
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


