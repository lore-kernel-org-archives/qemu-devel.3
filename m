Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BD3D1CDA7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38TM-0004sv-46; Tue, 22 Oct 2024 02:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t38TC-0004sQ-Ld
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t38T9-0004Sd-A3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 02:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729578853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tkkizOFNkGqNBWxkxM6UYEFFHHmKTfk4nImh4QleBvc=;
 b=SChOh6y9BxZRVkILTxRKB1Ql68ktk7VpEdkLCkaR8gnMBXQVIDlXMyFuqoy6/29gqPCW7l
 OhUUKqb1eaIy+5tEZLEgGRCo/wLCu4YRSCwpQCVNhNk5X4WW7dbSdhcsHdYkrer+PEr5+K
 qz3q+KBGhPa0aerG34yFtcIWmna7I6Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-A6RFK0RIO-yUBGOI0tZB3A-1; Tue,
 22 Oct 2024 02:34:09 -0400
X-MC-Unique: A6RFK0RIO-yUBGOI0tZB3A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44F3F1955F41; Tue, 22 Oct 2024 06:34:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD67C1956056; Tue, 22 Oct 2024 06:34:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
Date: Tue, 22 Oct 2024 08:34:02 +0200
Message-ID: <20241022063402.184213-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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

The linker on OpenBSD complains:

 ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
 warning: strcpy() is almost always misused, please use strlcpy()

It's currently not a real problem in this case since both arrays
have the same size (256 bytes). But just in case somebody changes
the size of the source array in the future, let's better play safe
and use g_strlcpy() here instead, with an additional check that the
string has been copied as a whole.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Check the return value of g_strlcpy to avoid truncation of the string

 migration/dirtyrate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 233acb0855..0f941024be 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -436,6 +436,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
                                     struct DirtyRateConfig *config)
 {
     uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
+    gsize len;
 
     /* Right shift 30 bits to calc ramblock size in GB */
     info->sample_pages_count = (qemu_ram_get_used_length(block) *
@@ -444,7 +445,8 @@ static void get_ramblock_dirty_info(RAMBlock *block,
     info->ramblock_pages = qemu_ram_get_used_length(block) >>
                            qemu_target_page_bits();
     info->ramblock_addr = qemu_ram_get_host_addr(block);
-    strcpy(info->idstr, qemu_ram_get_idstr(block));
+    len = g_strlcpy(info->idstr, qemu_ram_get_idstr(block), sizeof(info->idstr));
+    g_assert(len < sizeof(info->idstr));
 }
 
 static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
-- 
2.47.0


