Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11016C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaAy-0002Xr-PC; Tue, 30 Jun 2026 11:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaAw-0002Ws-T1
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaAv-0008Nt-Cs
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGTJv8BibaaQwg0fFkStqS+PxU9L27C+O2oa1Tgv6o8=;
 b=RYlFKDftMYTb7XFRjs2o5i+1X5Q1atWQQKRhtUuZTs3p11K5JywyojDsis3sOkVyZZ5Utq
 JAI7S/gBeWX4OShY0u2Ie+xpWCeKSNkWgS/sY7TBnU+h64YMoi31j+D39FyU1lnB5To+0L
 Nncdljwtzw3bz3tpak4WPwNTYlBCw/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-KeRt_UYDOfq4Uo1prGO9KQ-1; Tue,
 30 Jun 2026 11:14:58 -0400
X-MC-Unique: KeRt_UYDOfq4Uo1prGO9KQ-1
X-Mimecast-MFC-AGG-ID: KeRt_UYDOfq4Uo1prGO9KQ_1782832498
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF54A1955D92
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:14:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9DF91956065; Tue, 30 Jun 2026 15:14:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:16 +0400
Subject: [GIT PULL 1/8] migration: add migration_guest_ram_loading() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-1-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6iybEM8W9c1zpK9W+Z63b64AjqD33BvV2hzwhGhl6cA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91nM9wwgrjXc4KNI26Y4SUqaq87Dj1pxB1ua
 BJd0ACHH4GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5Q8YEACVnkbmJ9DWzF8EVX0hg40DqQnakorDBlfV5E5djOnzcq4YxizVZOdT55Z6VYTdN9vkkAB
 hLyWvxELytytfP+eaaXVdb9brY/rEbfpzx4DFTzo6vLkMXCknlrOZV+wg8yMCBZuLOeD3+AMwI4
 +ta1NQXh4lAc/H56ljxGu3BJuw99sheThfBr9rCgtNxdhz3fyZMpdfkJ/8vBekkLseF2Ra8hROP
 WGaRfx4/AImFXB0nlYb4ZY0BJq/wnJ3ENSblGrz+wbL4sOXcH8rMJT+bQKanbBJLsX016DTrHl/
 IE3QbeziGpg7TQpNkzumt8z4BZezfnO/sVSRG95jhyTH7Dr5K1Dzg2ItwjeGEtwT2JeE2oHr6/h
 jDLTOFQAjykd5ErdyY/ZKKyogW6S+yz3EMDb2mBe+KofBLkPtS3O5jdgyfQFBv8H6CQynKNqDiG
 y1Z2HpCkz4pIATcKqwObvlKrhnfevzoMA8ujoTCrntDUiXM5yw1B0wb+WuG95EEybHZHtKAFIiM
 0z6USUTAdF/UADlqa3hXf3jj1P3erjiKgj+yTQch7cOWxm8m8sBZvVB8D/FgC5s32HMv6VyVi1h
 RGCZes/3tP4jSKFJMl3Ubrb5aaLkcg6SqIlDlQvLAsyw//tb37HlrQeRAoRsiJ5OkPd9TaT6+Bx
 waRO+jN6uH4KAfg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

Operations that read guest RAM (dump-guest-memory, memsave, pmemsave)
must refuse to run while the destination of a migration is still
receiving that RAM: during precopy it is incomplete, and during postcopy
a read faults the page in from the source. Provide a single predicate
they can share instead of open-coding the runstate and postcopy checks.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-2-den@openvz.org>
---
 include/migration/misc.h | 3 +++
 migration/migration.c    | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c3..d3d6e1f50d1 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -117,6 +117,9 @@ void migration_file_set_error(int ret, Error *err);
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 
+/* True while the destination still receives guest RAM (precopy or postcopy) */
+bool migration_guest_ram_loading(void);
+
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
 bool migration_incoming_postcopy_advised(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 278cad502ae..0f56432d903 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1643,6 +1643,12 @@ bool migration_in_incoming_postcopy(void)
     return ps >= POSTCOPY_INCOMING_DISCARD && ps < POSTCOPY_INCOMING_END;
 }
 
+bool migration_guest_ram_loading(void)
+{
+    return runstate_check(RUN_STATE_INMIGRATE) ||
+           migration_in_incoming_postcopy();
+}
+
 bool migration_incoming_postcopy_advised(void)
 {
     PostcopyState ps = postcopy_state_get();

-- 
2.54.0


