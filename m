Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzcz-0001VU-Oi; Tue, 11 Mar 2025 09:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzcx-0001O6-6Z
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzcv-00059Q-FY
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCMsquC2+bHD6SzCsnLY4O2720WG63JefOfU9U9aC90=;
 b=TUWFB/lEtSv7Z30FkJ/ZrU7Jw9cVYTXll4h/hxZRlImcejgPF8k7dY3rmIozwdOZxBrmtg
 f7vpCHqe2rot6tiddmKVDnFWXedQxuj04zrGbnwF4lUU++pqrUMl6NbqnZTAPYtLWzvRTF
 xaoX4WIsca//WWdstWzV2tCv5oSFm08=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-fLzxOZnjMDeZqaM-QneaDg-1; Tue,
 11 Mar 2025 09:26:29 -0400
X-MC-Unique: fLzxOZnjMDeZqaM-QneaDg-1
X-Mimecast-MFC-AGG-ID: fLzxOZnjMDeZqaM-QneaDg_1741699588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC8A61828AA2; Tue, 11 Mar 2025 13:26:27 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B6521955BCB; Tue, 11 Mar 2025 13:26:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 pkrempa@redhat.com, Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 01/13] scsi-disk: drop unused SCSIDiskState->bh field
Date: Tue, 11 Mar 2025 21:26:04 +0800
Message-ID: <20250311132616.1049687-2-stefanha@redhat.com>
In-Reply-To: <20250311132616.1049687-1-stefanha@redhat.com>
References: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Commit 71544d30a6f8 ("scsi: push request restart to SCSIDevice") removed
the only user of SCSIDiskState->bh.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7f738b484..caf6c1437f 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -106,7 +106,6 @@ struct SCSIDiskState {
     uint64_t max_unmap_size;
     uint64_t max_io_size;
     uint32_t quirks;
-    QEMUBH *bh;
     char *version;
     char *serial;
     char *vendor;
-- 
2.48.1


