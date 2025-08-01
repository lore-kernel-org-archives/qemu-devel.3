Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FE3C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhubt-00065k-7l; Fri, 01 Aug 2025 14:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uht9H-0006Qi-Lt
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uht9E-0007Wk-RI
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754067743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTZ8cBeLzqTe1O39WadGXcC9o9ALnNZNi7JydoMf858=;
 b=Uro8VKr7H8b3P3Z4MIuPD4aWjb1eL1tJl4ZTO4nna7aH9Zuz0VYG5kZ1uAoQ5K14m9jLO6
 nkl8l7eOSbVoXH3xjb8QXt8MF5BaCDPaj9gX6qxIdws/TnrQeig5xfmo7KH4dMvoWPGmDz
 kLVWdf4ssCIMwILGfPf6N1KoQi2JPcg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-N6Q4S3DZN-KSsKTnbq-7HA-1; Fri,
 01 Aug 2025 13:02:19 -0400
X-MC-Unique: N6Q4S3DZN-KSsKTnbq-7HA-1
X-Mimecast-MFC-AGG-ID: N6Q4S3DZN-KSsKTnbq-7HA_1754067739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B210919560B2; Fri,  1 Aug 2025 17:02:18 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.64])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D524A1800D8C; Fri,  1 Aug 2025 17:02:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] migration: simplify error reporting after channel read
Date: Fri,  1 Aug 2025 18:02:11 +0100
Message-ID: <20250801170212.54409-2-berrange@redhat.com>
In-Reply-To: <20250801170212.54409-1-berrange@redhat.com>
References: <20250801170212.54409-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The code handling the return value of qio_channel_read proceses
len == 0 (EOF) separately from len < 1  (error), but in both
cases ends up calling qemu_file_set_error_obj() with -EIO as the
errno. This logic can be merged into one codepath to simplify it.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/qemu-file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034..8ee44c5ac9 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -348,17 +348,13 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
             } else {
                 qio_channel_wait(f->ioc, G_IO_IN);
             }
-        } else if (len < 0) {
-            len = -EIO;
         }
     } while (len == QIO_CHANNEL_ERR_BLOCK);
 
     if (len > 0) {
         f->buf_size += len;
-    } else if (len == 0) {
-        qemu_file_set_error_obj(f, -EIO, local_error);
     } else {
-        qemu_file_set_error_obj(f, len, local_error);
+        qemu_file_set_error_obj(f, -EIO, local_error);
     }
 
     for (int i = 0; i < nfd; i++) {
-- 
2.50.1


