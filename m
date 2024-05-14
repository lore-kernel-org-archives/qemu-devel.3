Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E276C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6u8t-0001b0-1h; Tue, 14 May 2024 11:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6u8G-0001NN-Cb
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6u8E-0000b5-RW
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715700718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K50Sbx+baGUOM5ct96UQE3ekCjWLHex1Zj4JwbZd/y8=;
 b=Jha+iVbkMM7LyVmncwkfb76MWbGv7jtteW/We1A9fe6z9CkBGxx6kn46DAKM60fsGUrP5Y
 YNfbYqsf5qHy8IC8LVgdruB0WmtYa4KrQb2rD0xBblM8TxBVC2BcC0s2y7SsbDRIGfcwVW
 DknS9bpiKImfW5u9HFPIQNghPjN1sjc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-6GyP6KnQOcGQEw8UOabGOA-1; Tue,
 14 May 2024 11:31:53 -0400
X-MC-Unique: 6GyP6KnQOcGQEw8UOabGOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92D303C000BB;
 Tue, 14 May 2024 15:31:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE557200BD73;
 Tue, 14 May 2024 15:31:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 9/9] vfio: Also trace event failures in
 vfio_save_complete_precopy()
Date: Tue, 14 May 2024 17:31:30 +0200
Message-ID: <20240514153130.394307-10-clg@redhat.com>
In-Reply-To: <20240514153130.394307-1-clg@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

vfio_save_complete_precopy() currently returns before doing the trace
event. Change that.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index d089fa9b937e725307c1a56755495d5b8fae2065..b06d887df53155e676bf13fa03adaf0627841994 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -585,9 +585,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 
     qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     ret = qemu_file_get_error(f);
-    if (ret) {
-        return ret;
-    }
 
     trace_vfio_save_complete_precopy(vbasedev->name, ret);
 
-- 
2.45.0


