Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61D4C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qs4-0005h2-Ks; Tue, 30 Apr 2024 13:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1s1qs0-0005g4-LT; Tue, 30 Apr 2024 13:02:20 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1s1qry-0008Hw-HE; Tue, 30 Apr 2024 13:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=tDKBkG44YSzfpOn9a4MZ6LcgUI4Ai6XVtCcEDcawmck=; b=pzIVfXHMc4JH
 nyYNfyTBUIPtPt0X/q0GkYS6/Ch+S0X9+8B9Lvc6OaMcxDvhd4rtlFAkxHlbsa4icQ8OWP4ihklnT
 X3rg7/uW4oYbBwUNRc70AC8+0zlmeamxQ8i0TAtS2HniK41wyuZWOFCCqa3/qaVvK1jSMzJalUyL9
 3oNP3kA+yy4d4I87rxGkiQy0zOZJebn9ivEeFtGRfnDDglaX3MdjvS4oU5Z6a61LSG53OQu35sVJg
 SWd5uaHA7CCUHEptBZPckXLdWgDHpguCMDSg5+B7iBYG3T2PL6Wqug/wXAafW7BcpuP8LTdQlyeRs
 qv6meSz4FJm9Tv3FIZqbUw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1s1qoW-00G7Yj-1S;
 Tue, 30 Apr 2024 19:02:03 +0200
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/1] block: drop force_dup parameter of raw_reconfigure_getfd()
Date: Tue, 30 Apr 2024 19:02:13 +0200
Message-Id: <20240430170213.148558-1-den@openvz.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This parameter is always passed as 'false' from the caller.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/file-posix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..5c46938936 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1039,8 +1039,7 @@ static int fcntl_setfl(int fd, int flag)
 }
 
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
-                                 int *open_flags, uint64_t perm, bool force_dup,
-                                 Error **errp)
+                                 int *open_flags, uint64_t perm, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
     int fd = -1;
@@ -1068,7 +1067,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
     assert((s->open_flags & O_ASYNC) == 0);
 #endif
 
-    if (!force_dup && *open_flags == s->open_flags) {
+    if (*open_flags == s->open_flags) {
         /* We're lucky, the existing fd is fine */
         return s->fd;
     }
@@ -3748,8 +3747,7 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
     int ret;
 
     /* We may need a new fd if auto-read-only switches the mode */
-    ret = raw_reconfigure_getfd(bs, input_flags, &open_flags, perm,
-                                false, errp);
+    ret = raw_reconfigure_getfd(bs, input_flags, &open_flags, perm, errp);
     if (ret < 0) {
         return ret;
     } else if (ret != s->fd) {
-- 
2.40.1


