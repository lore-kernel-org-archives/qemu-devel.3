Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BC0CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2wR-0003Gd-43; Mon, 18 May 2026 14:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1wP2wO-0003F9-9i
 for qemu-devel@nongnu.org; Mon, 18 May 2026 14:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1wP2wM-0006fB-Mz
 for qemu-devel@nongnu.org; Mon, 18 May 2026 14:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779129825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ujkKcm9SJ37D7TbGkriFSIS1MzvrH3bOzDjz9FqpvHk=;
 b=P9S9Ks9HktJbmlVbPY+rShsjwiaw3y7OYsk+3SjLKXMg5cgO2Oh0FHpRGtfTKwqBES8F1W
 SnmUFsZstxc7qmZJsVOr2WyZnC5lPHkvYBFzB/OzMVOw2shn8fIgFuI/GYGrGvSG20TWLS
 lHQg2P5rGoCcR6NmlBaQOCnsdqaRtHo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-1Rm4UOmcMdaVMnEKuvlnwQ-1; Mon,
 18 May 2026 14:43:41 -0400
X-MC-Unique: 1Rm4UOmcMdaVMnEKuvlnwQ-1
X-Mimecast-MFC-AGG-ID: 1Rm4UOmcMdaVMnEKuvlnwQ_1779129821
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD25D18002F3; Mon, 18 May 2026 18:43:40 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.44.50.109])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DF551800576; Mon, 18 May 2026 18:43:37 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, rjones@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, farosas@suse.de, pbonzini@redhat.com
Subject: [PATCH] system/exit-with-parent.c: Close the file descriptor before
 exit
Date: Mon, 18 May 2026 19:43:27 +0100
Message-ID: <20260518184333.8505-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
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

On macOS we leak the open file descriptor in the background thread.
Close it before returning.

Link: https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04286.html
Reported-by: Thomas Huth
Fixes: commit 886898baad ("Implement -run-with exit-with-parent=on")
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 system/exit-with-parent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/exit-with-parent.c b/system/exit-with-parent.c
index df65d2231a..d236944572 100644
--- a/system/exit-with-parent.c
+++ b/system/exit-with-parent.c
@@ -109,6 +109,7 @@ exit_with_parent_loop(void *vp)
         /* Behave like Linux and FreeBSD above, as if SIGTERM was sent */
         qemu_system_killed(SIGTERM, ppid);
     }
+    close(fd);
 
     return NULL;
 }
-- 
2.53.0


