Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31427D70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkL9-00061t-5P; Thu, 28 Nov 2024 14:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f2db23ede5b3015330c2314f796dd694f35c7508@kylie.crudebyte.com>)
 id 1tGkL7-00061J-Ga; Thu, 28 Nov 2024 14:38:13 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f2db23ede5b3015330c2314f796dd694f35c7508@kylie.crudebyte.com>)
 id 1tGkL6-0001jj-2R; Thu, 28 Nov 2024 14:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=WpNnfdMSmJ9VqxtVLFQyTz3SmuQbK7pH3Ndcci69wQ8=; b=Puspp
 OSMc4T3ovGoUq6/SNFfkbDTtXdwbzJGMvW6NVI2guEmwpcYQuArs+hfvsk//vCJR3NcRvpOKSTI6V
 PPuPtDEg8EjO5TPZx/5QYjSYIG6PX2Txqda5wZK9qzOtXV/C1YHJqZBTzMSpC+Mx+0g+Nkz5oXjBk
 MivrIS0poeVr3ydStFZjqhcwxH0dSy1EUmW1o+mfYtrikgzZytx0M8JnDE+gwbutSP4ojiEJD9e8c
 lWIvbV2yKWy0FepHd/spujSuvLDqrS7aihdsGZ+Yw49ZkJmi4itaVAC+usF5xP881Pnydu7PGUwbe
 LBwnxW2c2lZN3gSXVkwr0UMYPzVtyB/Y2lqqjBaYGju29SefG/FYzXquU6AEAb3OP1InB+DqLV0KP
 hIWOcjNF2ec7bHLVvrq+ovkbuBquq55c2jHzAlEz8klzywXLMgV08ZHdGI/k0HEG8Pdbnm92dPZ7n
 zP4O+asNR1nlVpMcqaJdvHdnQb/VyHAv8t+2pqruTndmElHpQ7o/b+ObL0QwQT6vjy/CQpSwP1Fgq
 AsS3tnvOUJfUWVYxB1UgeBxO+MIcU3gRvkhhsDjbYIDgjYC/9CDN5dCAIKxTL07blhq3BBQIXEofv
 BQuI5dDqBvPtFo2AdRQL1nMn6qWmxeg3cbqJHAY48meNMRwvb8KmuuxxGos2LQ=;
Message-Id: <f2db23ede5b3015330c2314f796dd694f35c7508.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 1/7] 9pfs: cleanup V9fsFidState
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=f2db23ede5b3015330c2314f796dd694f35c7508@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Drop V9fsFidState's 'next' member, which is no longer used since:

  f5265c8f917e ('9pfs: use GHashTable for fid table')

Fixes: f5265c8f917e ('9pfs: use GHashTable for fid table')
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <E1tE4v2-0051EH-Ni@kylie.crudebyte.com>
---
 hw/9pfs/9p.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index a6f59abccb..5e041e1f60 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -280,7 +280,6 @@ struct V9fsFidState {
     uid_t uid;
     int ref;
     bool clunked;
-    QSIMPLEQ_ENTRY(V9fsFidState) next;
     QSLIST_ENTRY(V9fsFidState) reclaim_next;
 };
 
-- 
2.30.2


