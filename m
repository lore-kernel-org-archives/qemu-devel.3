Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD45FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC0F-00071k-44; Thu, 06 Mar 2025 09:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0B-0006tl-N7
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC09-0001lg-W2
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRAn4E0ADclT5NKArQvMv+JwT4fuP9snV/n8bxajaCQ=;
 b=NwfRbTaB0Qkl9TnKQ5LzKbk+gYqQjuIGD2q7VSEvF23p/SupUVtqyno636UC53nWGv9wiH
 iDfalGejbDTALEOGteRRdPH5cE65P0Ozkt37L4ijYhGwcKhClF+9YPgZFZKTyGd6qhTx75
 MvmmWRSZ1cY2CeYOwOTa4D37fM/xdSY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-TN0raHs7NtqJiiXAoXRzbw-1; Thu,
 06 Mar 2025 09:15:02 -0500
X-MC-Unique: TN0raHs7NtqJiiXAoXRzbw-1
X-Mimecast-MFC-AGG-ID: TN0raHs7NtqJiiXAoXRzbw_1741270501
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B398318001E3; Thu,  6 Mar 2025 14:15:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09B3618001D3; Thu,  6 Mar 2025 14:14:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/42] migration: Clarify that {load,
 save}_cleanup handlers can run without setup
Date: Thu,  6 Mar 2025 15:13:46 +0100
Message-ID: <20250306141419.2015340-11-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

It's possible for {load,save}_cleanup SaveVMHandlers to get called without
the corresponding {load,save}_setup handler being called first.

One such example is if {load,save}_setup handler of a proceeding device
returns error.
In this case the migration core cleanup code will call all corresponding
cleanup handlers, even for these devices which haven't had its setup
handler called.

Since this behavior can generate some surprises let's clearly document it
in these SaveVMHandlers description.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/991636623fb780350f493b5f045cb17e13ce4c0f.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index f60e797894e5faacdf55d2d6de175074ac58944f..0b02927383208d1457f21da7ad4900ba53e93638 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -69,7 +69,9 @@ typedef struct SaveVMHandlers {
     /**
      * @save_cleanup
      *
-     * Uninitializes the data structures on the source
+     * Uninitializes the data structures on the source.
+     * Note that this handler can be called even if save_setup
+     * wasn't called earlier.
      *
      * @opaque: data pointer passed to register_savevm_live()
      */
@@ -244,6 +246,8 @@ typedef struct SaveVMHandlers {
      * @load_cleanup
      *
      * Uninitializes the data structures on the destination.
+     * Note that this handler can be called even if load_setup
+     * wasn't called earlier.
      *
      * @opaque: data pointer passed to register_savevm_live()
      *
-- 
2.48.1


