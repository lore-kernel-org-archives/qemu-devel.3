Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A3EC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9P-0002aQ-Ml; Fri, 11 Sep 2026 05:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9C-0002KK-D6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9A-00087y-TW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f254NehgLbY8bvUcUnlxHVuzEfFRxr1y8JaeM6VB6uw=;
 b=SxnhtHK7E36RlO0IOVgb26GDx/wmc+j41pecSmvVfSLqPYkgFzAZ01nAuOqTFoESdGu8ng
 oE7wX+q/d5XOXutVKrOPqRXqWQhEN1o1B5m+X3v16q82e8e/RQ8vjEL7FtJGYfB1/W86a+
 sVYd9CDpSSj8AM6qVV4q/NTGJHdmsM8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-1i56fiqTOUC8hKBAfrsRgw-1; Fri, 11 Sep 2026 05:02:09 -0400
X-MC-Unique: 1i56fiqTOUC8hKBAfrsRgw-1
X-Mimecast-MFC-AGG-ID: 1i56fiqTOUC8hKBAfrsRgw_1789117328
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c2939e341f7so82902666b.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117328; x=1789722128; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f254NehgLbY8bvUcUnlxHVuzEfFRxr1y8JaeM6VB6uw=;
 b=AEyixg4UKx+8gntK449twoxPvawcg61mzuLbtGrZHmK3BWT52k7zXiALq9RrkhhvuF
 W/4e4oqHFBClp1RTV741hOTgrFSh+6/ifFL9PE29XvE3NTkidF8VpSeQk/fpBUNS3qEX
 4ZcGKgZE9c9cOMWzq4qKnvSYGHPn2Fza/NiCIzjRyhRq/dwVzkcYlaogf/n4MzDpe8Dz
 8GRJZGOGwuo9YnpJJ9jSQWeO0NNSl6eo7AfB1IqmqGSEXxRuy8YzmOQIKLGp3VxE2kqT
 aWYbtRtX8LnFTP3Rd3bugkUR+mvotGTv+FQCp8UBWUQAONtbp6vXF0TnWxRejWblQEMk
 aTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117328; x=1789722128;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f254NehgLbY8bvUcUnlxHVuzEfFRxr1y8JaeM6VB6uw=;
 b=ooQBUvPiTLnjq8wGT9l98LDfpNpJmVlK0tns674v7//wSahcBfa7L7dpc5LU9NTUDg
 0CsmOK1zMpUoQw+ijCit0jWBg9PW7Ygz+lynSMvQySPnfpE9AOef01y3lO9XcLKgOkiw
 Vq9iHOs8f80jLOCQc/cZzbyvd9M8YfnqEYMK4qw2O+z6epy7ZgHE7B5I0dut5EHSSpvY
 cDgttdCcYJWx3OewWAdTFD+8LA/DBGWkf/x+vzd7XPANWb4jA1swjwZ2TNWxzvNH2sPE
 sTmNFpaF2eaTCR3bri7Ya+Hekwrm6c13otII1SE6XDX6W5ARl4LNPNyvV06W2grSI3cX
 rX7g==
X-Gm-Message-State: AFuF++liucr9yHdcnInoCZVuMyTNBHKFTWPGk01xlOh2QxVO3rBumSHg
 V+DK4Jm/27Z7f6bC7EQEkJT7Ss1px8ros/noNX9s2S70JG9Oc7sdV9m2H//Gu0ERzYd05FK6Fel
 XCr+3FNKGreqBlTMHa5Fcl3aJFTjPRpSkdN7I++kWpCf56M4hnkhLbzSJzecs60aPDPRQocjWEg
 c8HBkysBE7lYJkgIKFtRyN/jH+flK7EVyNfQ==
X-Gm-Gg: AYBFou2agT3/IBh5MTu4w8jP/rJB/MOiI8Zl9ysIL4v10zc7YctOPEDZsQKqDTD2P+W
 /B4KESKGCPhQ2wlYqMw6y9iQ1AI8WjiWLeGcDXi9G4lTpDaPwYMx9k2nVF7/96wEMbodgRnekDr
 KOVfGkzgk7TO1aDLY1fajHby3YOLDgs2NYd3CCeBRETp2DN7rmMeTFrC1phx2eiIwvxGAmF8ZRv
 H+caVY/gUK5fujyY1U0pC2o27b1sooMMRDTFgh/uUIC4Y1BdcsJITl8n2LlyaoSWgZZdKu9lRRi
 Wh8mRNyB7/VxUZrpnySvGv3tGNVgZ7qdogWX6LIp9ig8ehgIaJOiBs+8tY8YjvvJcR8OChY5s5m
 xniwkDm18VkL61VWTycxnzMk=
X-Received: by 2002:a17:907:c48d:b0:c26:19de:9133 with SMTP id
 a640c23a62f3a-c2966729628mr135538566b.38.1789117328026; 
 Fri, 11 Sep 2026 02:02:08 -0700 (PDT)
X-Received: by 2002:a17:907:c48d:b0:c26:19de:9133 with SMTP id
 a640c23a62f3a-c2966729628mr135534466b.38.1789117327365; 
 Fri, 11 Sep 2026 02:02:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bd1esm4525977f8f.31.2026.09.11.02.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:06 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 20/75] migration: check that transfer is UNIX socket when
 "local" set
Message-ID: <f6e309e025515cb0710124b3d6e85b8b20ea2f86.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

As documented, for "local", the migration channel must be direct UNIX
socket connection from source to target (except for CPR_EXEC mode). We
can't check for it being "direct", but let's at least check that we deal
with UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-13-vsementsov@yandex-team.ru>
---
 migration/fd.c        | 14 ++++++++++++++
 migration/migration.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/migration/fd.c b/migration/fd.c
index 78a27caca2..4a891e814a 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -39,6 +39,20 @@ static bool fd_is_pipe(int fd)
 
 static bool migration_fd_valid(int fd, Error **errp)
 {
+    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC) {
+        struct sockaddr_storage ss;
+        socklen_t sslen = sizeof(ss);
+
+        if (getsockname(fd, (struct sockaddr *)&ss, &sslen) < 0 ||
+            ss.ss_family != AF_UNIX) {
+            error_setg(errp,
+                       "local migration requires a UNIX domain socket channel");
+            return false;
+        }
+
+        return true;
+    }
+
     if (fd_is_socket(fd) || fd_is_pipe(fd)) {
         return true;
     }
diff --git a/migration/migration.c b/migration/migration.c
index b413d28622..d8418e4582 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -260,6 +260,19 @@ migration_capabilities_and_transport_compatible(MigrationAddress *addr,
                                        errp);
     }
 
+    if (migrate_local() && migrate_mode() != MIG_MODE_CPR_EXEC &&
+        (addr->transport != MIGRATION_ADDRESS_TYPE_SOCKET ||
+         (addr->u.socket.type != SOCKET_ADDRESS_TYPE_UNIX &&
+          addr->u.socket.type != SOCKET_ADDRESS_TYPE_FD))) {
+        /*
+         * For SOCKET_ADDRESS_TYPE_FD we do check the fd itself later
+         * in migration_fd_valid().
+         */
+        error_setg(errp,
+                   "local migration requires a UNIX domain socket channel");
+        return false;
+    }
+
     return true;
 }
 
-- 
MST


