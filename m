Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101A5F55102
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 10:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzAxf-00054q-Up; Sun, 08 Mar 2026 06:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzAxe-00054Y-1u
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 06:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vzAxb-0002lm-Gl
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 06:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772964124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=s5oOmyJ7GDywcCZW2d/HUaKfm+0stme6E5UgPupt0uM=;
 b=R5C4E8QEKDG9WUHbBW+1qIzi/wau0MiIJD/fx+nkeDWajj5w7R1STWewWEBSpaCxvUyjcW
 Qkg/BQt2T/XS6F7ry5vNAImYsVTgxu0ruZ16+3ImxkAI513kL2Eitt4kDjW/Cx+wj2JXIU
 7rSn36fmzQYetNhZntlFAgfcLyV+ZVM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-j_2gj6J_PHeO6xG9t2LQdA-1; Sun, 08 Mar 2026 06:02:03 -0400
X-MC-Unique: j_2gj6J_PHeO6xG9t2LQdA-1
X-Mimecast-MFC-AGG-ID: j_2gj6J_PHeO6xG9t2LQdA_1772964122
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7391540c49so1871143a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772964122; x=1773568922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s5oOmyJ7GDywcCZW2d/HUaKfm+0stme6E5UgPupt0uM=;
 b=A5TSMJjfJR5k4eRRzs3JWI4DlQ9cfnQQFlqgMQLtWYInmWMkaFLQQrvrDObs7RhPxD
 EDeMPgYhthq0wPoFENRiA4MlhS+I1yDRG+ENQEVUrw+GRbHgr1kzv3twMRXK8AFlCEpQ
 pYMPZSSMc5TA+KX2vS3nipOWiTmp22KPTdZQOA9hLB6GTuyPR3oTYY6Ty7uIKDlIzs1s
 d6gHO1QOaPXhLCt4WOgGPdhUom04rr+umB0UqIX1WofkocIoQFOr9N0Cso8xOSyanUZS
 lpmukhfET3M0L66+TTm0i2cU4aINlzKOUsYkI9qs91cXqLFenz2QSG1sFcX1sekbnpII
 vdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772964122; x=1773568922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5oOmyJ7GDywcCZW2d/HUaKfm+0stme6E5UgPupt0uM=;
 b=ogBW/Se1S9f03xku5Xir+fukJNcjXVm8RmlucIc3W8HUs6WQ9BJxkC2mF+LkQItETb
 0Hs253txUlWEDTNGQTWL1IuRr3rLaXgFRHtBG4fLqMZPlmQMOZT8vrICMPVf2lfvxbPK
 lNAIev+ZyGTl0MZRHDN/ejuPtX+LPmcROYpFrBIU3bwje1fKOxspZQP14gBgSvKVoTMK
 xsbQnfLY2AS87J9A8JHz2FwKQHmq/00/rXvjelDOOLa4SZAvXWVyt3eLEZ2v6o5DBHK2
 Ex/n71zLNHlNSbsu/D/7TWjntRri1Q2Q636MbOryooUXV8JkSg4yWj08xPgOncE+eiGL
 KzAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVxGK+N2cIpB4XO1dTzbBGFgsgCSgCNhyDmQ/9hXSa3z+kfxFvwn+BUPek3thHCK/b5ZtPTVI8I+Y3@nongnu.org
X-Gm-Message-State: AOJu0Yx1wpXrEnPMPqCM7UUZIHpbqr2U4ZLa3CS0F0lPQuHtSDKpkIpx
 GAsf9rJ+X6wh5IocMdWqCo44rUUtCYpnu0Mfw3397OHuDqqOOR1bNA/8hRaklWnQgaxOH9vhY6s
 2A8n2hp5AJxhXz6H/WlWOGWmRBMzqkg/3aIaqW5ESyVeDG6+xP8/+LHXz
X-Gm-Gg: ATEYQzyaTjGPcudYSCc3mbXcb5eT6x0hJg3rcJTTWTY7UxJa6eChzOyX5fAqttFuIDs
 qie9PazQD3+DS4Uk0xiUwb5C68plQFXfMB4Zce9yHSo1jz5jUzNUWxq5TL0dGvuHpFGLwtGLx6m
 8cGINOo35wv+j70naHKzIhYnlxI0ccoMkNzenmYCpxGFBuCb0DSuEltiy2lSkvOdyLNZVZRHGEZ
 53YBXTE8oXOrtVZyE2puQ0ntdzlggGqHdno/hiquKvZrJ7Cii2F+QwT7ePsqSIaDMavAP62NoMc
 OY13r32ImYN1U5miQUZzM8pi07OJEk6CxFgIcHm6s5IjCl4G3o3gnOE8YWdIHRXk1y1eb7w8l0i
 WaewYmLgYuMthtSeDzL3cJA0GALLD9kKy4+H8VXuawYbh03e0x5NDM4kfyg==
X-Received: by 2002:a05:6a00:4b53:b0:821:853f:b9c3 with SMTP id
 d2e1a72fcca58-829a30c203emr6973545b3a.58.1772964121865; 
 Sun, 08 Mar 2026 03:02:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b53:b0:821:853f:b9c3 with SMTP id
 d2e1a72fcca58-829a30c203emr6973524b3a.58.1772964121453; 
 Sun, 08 Mar 2026 03:02:01 -0700 (PDT)
Received: from ani-lenovo.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-829a467239asm7035509b3a.26.2026.03.08.03.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 03:02:01 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org
Subject: [PATCH] migration: assert that the same migration handler is not
 being added twice
Date: Sun,  8 Mar 2026 15:31:48 +0530
Message-ID: <20260308100148.162503-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently the code that adds a migration blocker does not check if the same
blocker already exists. Assert that the migration handler being added has
not been added already.

CC: Markus Armbruster <armbru@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index a5b0465ed3..840cf0dfe2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1702,6 +1702,8 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
+            assert(g_slist_index(migration_blockers[mode],
+                                     *reasonp) == -1);
             migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
                                                        *reasonp);
         }
-- 
2.52.0


