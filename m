Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3926A1076381
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zEJ-0003Mb-4I; Wed, 01 Apr 2026 13:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEF-0003Ix-2t
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w7zEC-0001In-VI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775063980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=56IhqZsu/XJJ3I4EtYsq1VusSGeD9z30b3U0IZEUjbM=;
 b=QXGj4tLqKr9IrFciSBIT5BKzu4xIqo+S7EAz6R+O0zQm9ND4194k0IVFcj7MELGWkhsVCY
 2uI/KyCFRYtvd6TAE7nDGyPsQu1MJ7Sse6g9FOhkwhte8jUKSjvFIOQSBJozA677xfrc2V
 R9cba+ryY1gzOgcyBiNSgHl1qy4jfuo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-jEBZpI1AOlOrabhYHjk-5w-1; Wed,
 01 Apr 2026 13:19:37 -0400
X-MC-Unique: jEBZpI1AOlOrabhYHjk-5w-1
X-Mimecast-MFC-AGG-ID: jEBZpI1AOlOrabhYHjk-5w_1775063975
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6421195608C; Wed,  1 Apr 2026 17:19:35 +0000 (UTC)
Received: from localhost (unknown [10.44.32.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7688730001A2; Wed,  1 Apr 2026 17:19:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, <qemu-stable@nongnu.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/3] scsi: adjust error_prepend() formatting
Date: Wed,  1 Apr 2026 13:19:25 -0400
Message-ID: <20260401171927.396672-2-stefanha@redhat.com>
In-Reply-To: <20260401171927.396672-1-stefanha@redhat.com>
References: <20260401171927.396672-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The error strings will be concatenated so add a separator to make the
combined error message easy to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a2316a5266..b55d068323 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -439,7 +439,7 @@ static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER: ");
         return false;
     }
     return true;
@@ -463,7 +463,7 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with PREEMPT: ");
         return false;
     }
     return true;
-- 
2.53.0


