Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D9CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squ11-0005pd-Ft; Wed, 18 Sep 2024 08:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1squ0q-0005ls-Tc; Wed, 18 Sep 2024 08:42:30 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1squ0p-0001Sa-3t; Wed, 18 Sep 2024 08:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=+r7dyvHWThLZe1RWZ/JHkiHU7O+B/uytsFKfrn39a5w=; b=krhxYKhW3lQUFuxh
 ethFifTrCmue3H8WHf9fzab74Tw6qeiU53Fyb90bNM8jQDiFwl4nlotwLhe7wUiN2M/h4G88FOjSY
 o9DVM07ItwG+xEnfnP7HSYe/RgezmvzAieJB3qXemzaAStPQpSrbEEjJm9NeV73rDvJekYKr+GYEL
 Dpip5XRwXJFzcPhJ7Dk2qHct+nOFz08nMv99ce+NwVY9hP/jZRL43HckS7FT783VT2KTlqcXqJ2DY
 XQ2I0INY6L2LiA4MZC8uI15aPh3LRlNnfLQu/2cFH9gRnR0CQZT+ar0rkV+H1p4/dgfncAEXofyZv
 XfgjxBN2jA92UDARuw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1squ0j-006HoV-1h;
 Wed, 18 Sep 2024 12:42:21 +0000
From: dave@treblig.org
To: jsnow@redhat.com,
	vsementsov@yandex-team.ru
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] util/co-shared-resource: Remove unused co_try_get_from_shres
Date: Wed, 18 Sep 2024 13:42:20 +0100
Message-ID: <20240918124220.27871-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Dr. David Alan Gilbert" <dave@treblig.org>

co_try_get_from_shres hasn't been used since it was added in
  55fa54a789 ("co-shared-resource: protect with a mutex")

(Everyone uses the _locked version)
Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/co-shared-resource.h | 7 -------
 util/qemu-co-shared-resource.c    | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/include/qemu/co-shared-resource.h b/include/qemu/co-shared-resource.h
index 78ca5850f8..41be1a8131 100644
--- a/include/qemu/co-shared-resource.h
+++ b/include/qemu/co-shared-resource.h
@@ -44,13 +44,6 @@ SharedResource *shres_create(uint64_t total);
  */
 void shres_destroy(SharedResource *s);
 
-/*
- * Try to allocate an amount of @n.  Return true on success, and false
- * if there is too little left of the collective resource to fulfill
- * the request.
- */
-bool co_try_get_from_shres(SharedResource *s, uint64_t n);
-
 /*
  * Allocate an amount of @n, and, if necessary, yield until
  * that becomes possible.
diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
index a66cc07e75..752eb5a1c5 100644
--- a/util/qemu-co-shared-resource.c
+++ b/util/qemu-co-shared-resource.c
@@ -66,12 +66,6 @@ static bool co_try_get_from_shres_locked(SharedResource *s, uint64_t n)
     return false;
 }
 
-bool co_try_get_from_shres(SharedResource *s, uint64_t n)
-{
-    QEMU_LOCK_GUARD(&s->lock);
-    return co_try_get_from_shres_locked(s, n);
-}
-
 void coroutine_fn co_get_from_shres(SharedResource *s, uint64_t n)
 {
     assert(n <= s->total);
-- 
2.46.0


