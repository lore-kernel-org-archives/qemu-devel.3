Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B61C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xr-0002Zh-K0; Mon, 05 Aug 2024 17:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xJ-0000d1-RA
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xI-0008W2-6R
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imRy/cCkdNUHP3mYUYZKXEbSa2NYjKrWcecXWJ8m3RY=;
 b=cVNjjo779+4NHjUTYo6lET6syufY5GhAkQ//7pY7Rszk1puZ4bhznyAmddYataq9fRB10/
 vAAMq1U3PlaJ9c/7JlEGohHEoMBROf8FKA8pfZ9lV+TG6RKwHVRojesWKrkmioHc30BQqq
 BR+7iP/CBI95uvswHQ5UT6hrRdEup9w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-1bx2gr0iPhKokF0Vph--fg-1; Mon,
 05 Aug 2024 17:09:20 -0400
X-MC-Unique: 1bx2gr0iPhKokF0Vph--fg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EA671956046; Mon,  5 Aug 2024 21:09:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F02930001AD; Mon,  5 Aug 2024 21:09:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/13] vvfat: Fix wrong checks for cluster mappings invariant
Date: Mon,  5 Aug 2024 23:08:48 +0200
Message-ID: <20240805210851.314076-11-kwolf@redhat.com>
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

How this `abort` was intended to check for was:
- if the `mapping->first_mapping_index` is not the same as
  `first_mapping_index`, which **should** happen only in one case,
  when we are handling the first mapping, in that case
  `mapping->first_mapping_index == -1`, in all other cases, the other
  mappings after the first should have the condition `true`.
- From above, we know that this is the first mapping, so if the offset
  is not `0`, then abort, since this is an invalid state.

The issue was that `first_mapping_index` is not set if we are
checking from the middle, the variable `first_mapping_index` is
only set if we passed through the check `cluster_was_modified` with the
first mapping, and in the same function call we checked the other
mappings.

One approach is to go into the loop even if `cluster_was_modified`
is not true so that we will be able to set `first_mapping_index` for the
first mapping, but since `first_mapping_index` is only used here,
another approach is to just check manually for the
`mapping->first_mapping_index != -1` since we know that this is the
value for the only entry where `offset == 0` (i.e. first mapping).

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <b0fbca3ee208c565885838f6a7deeaeb23f4f9c2.1721470238.git.amjadsharafi10@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index cfde468c2e..e3a83fbc88 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1880,7 +1880,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
 
     uint32_t cluster_num = begin_of_direntry(direntry);
     uint32_t offset = 0;
-    int first_mapping_index = -1;
     mapping_t* mapping = NULL;
     const char* basename2 = NULL;
 
@@ -1942,14 +1941,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
 
                         if (strcmp(basename, basename2))
                             copy_it = 1;
-                        first_mapping_index = array_index(&(s->mapping), mapping);
-                    }
-
-                    if (mapping->first_mapping_index != first_mapping_index
-                            && mapping->info.file.offset > 0) {
-                        abort();
-                        copy_it = 1;
                     }
+                    assert(mapping->first_mapping_index == -1
+                            || mapping->info.file.offset > 0);
 
                     /* need to write out? */
                     if (!was_modified && is_file(direntry)) {
-- 
2.45.2


