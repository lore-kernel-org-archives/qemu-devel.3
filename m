Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB4D591AA
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5gr-0000FK-GG; Mon, 18 Nov 2024 12:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gV-0008Gh-Vi
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gT-0004n4-5f
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kniq6o51rC52CTgEXZF2VX5mVrF5y8QD9cn/IfAcJw=;
 b=Ysq7iVnkjoF8xfZ95Rul9FMk0NgrKQqPi/13GDPlnrRvCmc9MLLl1GkPNOYk7NBzAp25Wv
 XaXhZ+zTACi9RBHRz2ucr97C0FtgsKociFJ2e13aGdr6uH66hnxxCw6GWN8+s0FV5TMQjV
 GR8VxSzTOOJR/Oh3nBBzgbyzMjIZ734=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ruSFp_pMOMK8Dwwe-Zgr0Q-1; Mon,
 18 Nov 2024 12:37:03 -0500
X-MC-Unique: ruSFp_pMOMK8Dwwe-Zgr0Q-1
X-Mimecast-MFC-AGG-ID: ruSFp_pMOMK8Dwwe-Zgr0Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ACD71954ADF; Mon, 18 Nov 2024 17:37:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10EEC195DF81; Mon, 18 Nov 2024 17:36:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 08/12] pc-bios/s390x: Initialize cdrom type to false for each
 IPL device
Date: Mon, 18 Nov 2024 18:36:30 +0100
Message-ID: <20241118173634.473532-9-thuth@redhat.com>
In-Reply-To: <20241118173634.473532-1-thuth@redhat.com>
References: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Clear information about cdrom type so that current IPL device isn't tainted
by stale data from previous devices.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241108194136.2833932-1-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a4d1c05aac..7509755e36 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -242,6 +242,7 @@ static bool find_boot_device(void)
 static int virtio_setup(void)
 {
     VDev *vdev = virtio_get_device();
+    vdev->is_cdrom = false;
     int ret;
 
     switch (vdev->senseid.cu_model) {
-- 
2.47.0


