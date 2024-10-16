Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE5D2A530
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16Z2-0008Ej-7J; Wed, 16 Oct 2024 12:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t16Yv-0008EU-Ll
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t16Ym-0005Lu-M0
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729094858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OUiQTidSLt7dFmySd4wxNT/xXVcKjjg6Vxf4t9f576c=;
 b=GX+KjcToWijz9ZAGwnkGc9mvZmJuplWcPo1XUu7xHB+czbuLYtjRy9u9bSGlC5RCUDb/2g
 hgJL1nAPFtN4E9y6cprmm33OYRQt+6Iqc47dOuYt2HQn8Xc2o3UhFAVQ48pfckOcDnIhN1
 5d+3OZvuDYEyO6DsfDhoNA4UpoGxPmA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-bCGmpcBJPSegvq2BR2NNcw-1; Wed,
 16 Oct 2024 12:07:35 -0400
X-MC-Unique: bCGmpcBJPSegvq2BR2NNcw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9713B1933188; Wed, 16 Oct 2024 16:07:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.199])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BF971944B27; Wed, 16 Oct 2024 16:07:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] migration/dirtyrate: Silence warning about strcpy() on OpenBSD
Date: Wed, 16 Oct 2024 18:07:12 +0200
Message-ID: <20241016160712.962407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The linker on OpenBSD complains:

 ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
 warning: strcpy() is almost always misused, please use strlcpy()

It's currently not a real problem in this case since both arrays
have the same size (256 bytes). But just in case somebody changes
the size of the source array in the future, let's better play safe
and use g_strlcpy() here instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 migration/dirtyrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 233acb0855..090c76e934 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -444,7 +444,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
     info->ramblock_pages = qemu_ram_get_used_length(block) >>
                            qemu_target_page_bits();
     info->ramblock_addr = qemu_ram_get_host_addr(block);
-    strcpy(info->idstr, qemu_ram_get_idstr(block));
+    g_strlcpy(info->idstr, qemu_ram_get_idstr(block), sizeof(info->idstr));
 }
 
 static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
-- 
2.47.0


