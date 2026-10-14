Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCE2CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGzyn-0003nw-CU; Wed, 14 Oct 2026 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGzyg-0003nU-2m
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGzyc-0002M0-3K
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791988144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg9hEvKYQmKTOW2TTZZJGOzdvmEUC5FTIssu/Te77Z8=;
 b=fmN0LOq72pbj8Bg0lp6uqzJJ7+Sf0Jhk78Z0dKsL1oda6nNt6WfoVhlHR1IiMzT6GWPnCD
 TmzbLFtw8+f841Cf+dW5lh5YgzdViOCCg2RaEFRo0BWfgYdHb5HWatrSRzFZaWErnjosWE
 IVOezwSUoZaXFw4AtdP2WwlqZQzQeo4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-JtpuyEf0PoGElcnL1JJX_g-1; Wed,
 14 Oct 2026 14:29:00 +0000
X-MC-Unique: JtpuyEf0PoGElcnL1JJX_g-1
X-Mimecast-MFC-AGG-ID: JtpuyEf0PoGElcnL1JJX_g_1791988139
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B60B180065F; Wed, 14 Oct 2026 14:28:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41A1126C; Wed, 14 Oct 2026 14:28:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: stefanha@redhat.com
Cc: akalenyu@redhat.com, berrange@redhat.com, bmarzins@redhat.com,
 eblake@redhat.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 9/8] scsi: document PR_HELPER_CLEANUP command
Date: Wed, 14 Oct 2026 10:28:47 -0400
Message-ID: <20261014142847.1354701-1-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/pr-helper.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
index e926f0a6c9c..d23c660159e 100644
--- a/docs/interop/pr-helper.rst
+++ b/docs/interop/pr-helper.rst
@@ -54,7 +54,8 @@ together with the SCSI CDB using ancillary data.
 The CDB has the following limitations:
 
 - the command (stored in the first byte) must be one of 0x5E
-  (PERSISTENT RESERVE IN) or 0x5F (PERSISTENT RESERVE OUT).
+  (PERSISTENT RESERVE IN), 0x5F (PERSISTENT RESERVE OUT), or 0xFF (PR HELPER
+  CLEANUP, see below).
 
 - the allocation length (stored in bytes 7-8 of the CDB for PERSISTENT
   RESERVE IN) or parameter list length (stored in bytes 5-8 of the CDB
@@ -63,6 +64,16 @@ The CDB has the following limitations:
 For PERSISTENT RESERVE OUT, the parameter list is sent right after the
 CDB.  The length of the parameter list is taken from the CDB itself.
 
+The PR HELPER CLEANUP command is a vendor-specific command without a parameter
+list that has the following effect on Linux device-mapper multipath devices and
+otherwise has no effect. This command is intended for cleaning up the multipath
+device on the source host after live migration has completed successfully:
+1. Sends "unsetprkey map <dm-target>" to multipathd.
+2. Sends "unsetprstatus map <dm-target>" to multipathd.
+3. Performs PERSISTENT RESERVE OUT with the REGISTER AND IGNORE EXISTING KEY
+   service action containing zero values for the RESERVATION KEY and SERVICE
+   ACTION RESERVATION KEY.
+
 The helper's reply has the following structure:
 
 - 4 bytes for the SCSI status
-- 
2.56.0


