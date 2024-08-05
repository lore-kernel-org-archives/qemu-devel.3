Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF1DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xt-0003NT-Tx; Mon, 05 Aug 2024 17:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xJ-0000Z8-1W
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xG-0008VV-LU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fUnXN9vjFAkhcC+JDQXUlQenfUijIgKJLPelVxzZjo=;
 b=X3SOcUSg0q5thCYLlzkDUjy3La2GYhGoGfmqRsHAB+LdQoEGtqeTR8oIS5vXlVDZiTDXyg
 wOJtv+ysIjjfoP8Xk4zFDNydd/SExvqHKpFrnQyOOWRk3+79e4zFF0XZ/m43yttdw4Dvp/
 1zmdd5f4UAYvHRk0EVDi8sUjfwHMuBc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-IIpnlJlcPuaxNyCw5H5PLA-1; Mon,
 05 Aug 2024 17:09:18 -0400
X-MC-Unique: IIpnlJlcPuaxNyCw5H5PLA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B57AC19560AA; Mon,  5 Aug 2024 21:09:17 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E96430001AA; Mon,  5 Aug 2024 21:09:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/13] vvfat: Fix usage of `info.file.offset`
Date: Mon,  5 Aug 2024 23:08:47 +0200
Message-ID: <20240805210851.314076-10-kwolf@redhat.com>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
References: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Amjad Alsharafi <amjadsharafi10@gmail.com>

The field is marked as "the offset in the file (in clusters)", but it
was being used like this
`cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <72f19a7903886dda1aa78bcae0e17702ee939262.1721470238.git.amjadsharafi10@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index a67cfa823b..cfde468c2e 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1408,7 +1408,9 @@ read_cluster_directory:
 
         assert(s->current_fd);
 
-        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
+        offset = s->cluster_size *
+            ((cluster_num - s->current_mapping->begin)
+            + s->current_mapping->info.file.offset);
         if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
             return -3;
         s->cluster=s->cluster_buffer;
@@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                         (mapping->mode & MODE_DIRECTORY) == 0) {
 
                     /* was modified in qcow */
-                    if (offset != mapping->info.file.offset + s->cluster_size
-                            * (cluster_num - mapping->begin)) {
+                    if (offset != s->cluster_size
+                            * ((cluster_num - mapping->begin)
+                            + mapping->info.file.offset)) {
                         /* offset of this cluster in file chain has changed */
                         abort();
                         copy_it = 1;
@@ -2404,7 +2407,7 @@ static int commit_mappings(BDRVVVFATState* s,
                         (mapping->end - mapping->begin);
             } else
                 next_mapping->info.file.offset = mapping->info.file.offset +
-                        mapping->end - mapping->begin;
+                        (mapping->end - mapping->begin);
 
             mapping = next_mapping;
         }
-- 
2.45.2


