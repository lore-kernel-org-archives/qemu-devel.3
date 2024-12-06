Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF16EE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 23:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRL-00032A-I1; Fri, 06 Dec 2024 18:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRJ-00030P-Bs
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRH-0005od-P9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ei3jTCfsOHArePmV6xGiFJK6jrCceSkuxpU8srZa3AM=;
 b=bW1wyex20bRPv3t5ZAtZVop2fTB5Nmc561hfy/GaY90qi+96nLpkT61aXAIHXFY7BfP3dt
 rDLIqfdI61xvR5Z9FRLSGUG+KYT6AShsAk+CnjTes5b1CgQojaNsuB9HzcndcOiD4L8sbC
 7E9wtkf06SWM0HhCJK5oxN3fu1j36Qk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-v7NFAoYIM12E8tAYHP2k5w-1; Fri, 06 Dec 2024 18:08:46 -0500
X-MC-Unique: v7NFAoYIM12E8tAYHP2k5w-1
X-Mimecast-MFC-AGG-ID: v7NFAoYIM12E8tAYHP2k5w
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-843e5314cb8so236175239f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526524; x=1734131324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ei3jTCfsOHArePmV6xGiFJK6jrCceSkuxpU8srZa3AM=;
 b=DK1bZXJuEWdFoUDonAHY9lHiI8TXPfSBis/HxuJpytcyRHhFlJdL9WF5lP8/UP3TwC
 uu/QgbkQz0J8+grcWSfC+CLCXGVWvyIfSYXku0jJTTW80ClNfJrYEk28VQIDxJluDLhJ
 R56ZJj6/7uf9/eIbd4PRy9M1pt+QEd/fs053VjayYpic3I9Byc8K9XKFaMnMYTiL38fC
 sS2CMdgeNtTS/y6PAcB18UhqanYMU76HBIqxalwOw4Ng79ezEG9ffrzsn5KqGhEtOP44
 vE+nA1g1KbSZqQGHL5+HQ2UVeXJARGnbgbPClBxmBVNzNFsmmgUJWFciDzlX4XgvEa7D
 strw==
X-Gm-Message-State: AOJu0Yz8PD8SROuR+urs73jXuG/Zy6khoijGjXo3idjWbgGYxBP+X9Zl
 foPVwPn+RkWLwrjIQDm9nt0jF4fcfee9g1hvy2Bscm94HHeYqdqyBWzUUkA2wymbLOxT2R6ainl
 EXpjGXlV6eJDCd3zKkMAa00jZ/aa9/YbvuvhvbdNGFirlprdfeZ+kOwNsyBUlS9nKDn5kcXkCRY
 mBPSlOXd2wkode0Ob+QkOhh1nbbEIZ4F17nw==
X-Gm-Gg: ASbGncuCJzE3dX7tRLC+jnfypKZ3VUz/GokoF9V9UNA6l7AHX9ZcXrg8bll/3brINcw
 te1zqA7lsSIPv0JJPG/15WBy5cAKXzJg4i0ozOllNzgwuAE6rN/lYZ6qu7WMSnNajJXQj3TDDik
 00RzTuq3IuD+gv+8Qu8K7QaIcDe5ST9zg7qvlrtF8/vL20bY6kQ50XrhPrrU7d/ji/o+Ecq0EEt
 IRXEvJR2XcL8za93a/pI2ehN2mv0y50tBsQcNJR0osxWcqb3Fwmoe0uld4YiGmqsXWdCr9DkI86
 iJ09O03oF7wqtKt0bl6RfsJb1Q==
X-Received: by 2002:a05:6602:6b10:b0:83d:ff89:218c with SMTP id
 ca18e2360f4ac-8447e23c40bmr558746439f.7.1733526524543; 
 Fri, 06 Dec 2024 15:08:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElYceywDKXSww4XW5Xm8jXV1AUqUnfAH+yucG7kZdg7Rnp3sbDc05RnxLyAqlVKujDTb2a+w==
X-Received: by 2002:a05:6602:6b10:b0:83d:ff89:218c with SMTP id
 ca18e2360f4ac-8447e23c40bmr558742639f.7.1733526524065; 
 Fri, 06 Dec 2024 15:08:44 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:43 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/6] qmp/cont: Only activate disks if migration completed
Date: Fri,  6 Dec 2024 18:08:34 -0500
Message-ID: <20241206230838.1111496-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206230838.1111496-1-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

As the comment says, the activation of disks is for the case where
migration has completed, rather than when QEMU is still during
migration (RUN_STATE_INMIGRATE).

Move the code over to reflect what the comment is describing.

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor/qmp-cmds.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index f84a0dc523..76f21e8af3 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -96,21 +96,23 @@ void qmp_cont(Error **errp)
         }
     }
 
-    /* Continuing after completed migration. Images have been inactivated to
-     * allow the destination to take control. Need to get control back now.
-     *
-     * If there are no inactive block nodes (e.g. because the VM was just
-     * paused rather than completing a migration), bdrv_inactivate_all() simply
-     * doesn't do anything. */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         autostart = 1;
     } else {
+        /*
+         * Continuing after completed migration. Images have been
+         * inactivated to allow the destination to take control. Need to
+         * get control back now.
+         *
+         * If there are no inactive block nodes (e.g. because the VM was
+         * just paused rather than completing a migration),
+         * bdrv_inactivate_all() simply doesn't do anything.
+         */
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
         vm_start();
     }
 }
-- 
2.47.0


