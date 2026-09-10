Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E05C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mev-0005HX-Dl; Thu, 10 Sep 2026 17:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWg-0006Zl-JL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWK-0004kf-Dz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnAlDO2QjRLH3bD583YkEJaCzSVpdg74aK2h0Y1Pq7U=;
 b=EaA8PtF+9QKF23MDdBat5qmYJ3QLGhWP8nCeL5/N9OpNDwQgHvl9CELvh3lQR5Oz9YANqp
 KEPQHEyWPSU4pYIek2o5VM3L7w28F7GQ0Pi3nas6IIZKBDTwM4QsvmjGHGoa+ZazabbWj9
 9j0FhVZkGyCaIkDJj69yA/4bznu0O9g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-PygtLgpcODS8YaFvv21ZYw-1; Thu, 10 Sep 2026 16:12:35 -0400
X-MC-Unique: PygtLgpcODS8YaFvv21ZYw-1
X-Mimecast-MFC-AGG-ID: PygtLgpcODS8YaFvv21ZYw_1789071155
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so2191925e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071155; x=1789675955; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qnAlDO2QjRLH3bD583YkEJaCzSVpdg74aK2h0Y1Pq7U=;
 b=BkfNXQE4m0a3R68mP9RlHNdkxFiDW9bNFoWzJkBH3OrjHNgyEH2WfsxlcuZWDvQPP2
 FwLce1kSCW6q1LMLeZQOc+tQlWTR5C6as+qBlESwnBdqW7eP9cq0HQ7X2SXIDybLYC4u
 F4DsskvSc/b1YMnZGMeeRMMs1A2woHPuSGYrw0OXYDZgjx0i8fdNMwJYCVGsjImiKvY7
 nDXBbH/7qRiQKEr0wt1pNWwk/tL/s7EumII2cEqbqsyECRg5ZNKN8Uc8xze6YU7bqCFA
 qqg0BsjT9+vAsmn3KpvZ8800AxHqVdt8sQRbes0NrkQipe7oLb92AtZX8VMbmehSesxo
 DgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071155; x=1789675955;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qnAlDO2QjRLH3bD583YkEJaCzSVpdg74aK2h0Y1Pq7U=;
 b=JjydlKVzfIl4PWy2v+jke8KvPDagyn6deXMR4c12URFeOorNYcs7X1tm2OOfByNg3F
 22FFVKmhgLEJRsKZMULkJHXreeC+HLzCBD3ZlCQ4IWzgqinPCj622o6WRTpct09HvAWr
 u2MXLRCsa21+cCQ7o2rrMOhKFMvwhKfptrjAKKdoOwE+RX8ML7gpTfgHhn5N+xlkSSAt
 kKjOvhUk+KTnnLpb93IXQS1WhVbP7In5oLGaBKfVnVRoEEXbajocgeGUBblUhK1dCGfi
 6Le7otjsEAUBryKbt32kmAzkQmieNrgajH7Dlgg7irEfALRqcgEdgl1ZR7l7KBEbRLxH
 Nx9g==
X-Gm-Message-State: AFuF++kwhp2kvj7L42qLZcrFvpv65q9no/o7dlW2rnAN0nnkmT+kj6lF
 3v9U45NJ5MprPrse9soJ9gMIpAgpTOM0kP0AfY167FpD1ZfT0SJs3BIM4y1gT45Nq33FRCWuQO2
 5lk2nPaF1UE9qP2o1BHgGO5SaxbgxvQ6b+PE/7kXSWYWbZ1TJNSEf8gofJDGmLGNeS9JGI7lOWr
 s8AvkK8RzkH+Ydr+nSfI+XwFHmXncrnWahfA==
X-Gm-Gg: AYBFou0RBTvKN5qZNLep3K7Nggub1mXM+W0Ze1bDMwRQBOkwGiVxHvbHqlxixOOeR67
 HQ5u1V8X0nY9CxPjBw2rLzRfnJA+nbKZdUYmnMD9t02gFjU/1WQNIf7Axdu4fdwob1xtVk3Sx48
 hVEp42lMb8KzqZu4JXCu2LJavyN4n4X/3/4h/K+tZNEVZ8L6Sey24yFBQXK/iSbJGzJL697wo++
 ahTSZ31bzKfZKQvmJi5oZSkILtqy9/uikeG53zsXHGH9I8zZqCcBHsPLUg3gNcfo7ULewXnTphc
 BUhZUfOIHx2YTB53VvAMR/XuSVR5p65/7HH8qr1uC454hjP2tyscT/swkVD/D4zaBYxtPpPf9QN
 lw22YEIzZl+JzBtYX58Q8Dsw=
X-Received: by 2002:a05:600c:c491:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49e619bb949mr8885745e9.20.1789071154587; 
 Thu, 10 Sep 2026 13:12:34 -0700 (PDT)
X-Received: by 2002:a05:600c:c491:b0:49d:827:e5b6 with SMTP id
 5b1f17b1804b1-49e619bb949mr8885115e9.20.1789071154030; 
 Thu, 10 Sep 2026 13:12:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm754511f8f.10.2026.09.10.13.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:33 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 28/90] migration/fd: fix fd leak when fd is not valid for
 migration
Message-ID: <7630e775908de3f4e9969234d0ca74360a00f872.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

Both fd_connect_outgoing() and fd_connect_incoming() own the file
descriptor after resolving it from the monitor, but forget to close
it when migration_fd_valid() check fails.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Fixes: f1fcc1c101 ("migration: Remove fd: support on files")
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-11-vsementsov@yandex-team.ru>
---
 migration/fd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/fd.c b/migration/fd.c
index f05f95992f..02b39b150e 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -62,6 +62,7 @@ QIOChannel *fd_connect_outgoing(MigrationState *s, const char *fdname,
     if (!migration_fd_valid(fd)) {
         error_setg(errp, "fd: migration to a file is not supported."
                    " Use file: instead.");
+        close(fd);
         goto out;
     }
 
@@ -97,6 +98,7 @@ void fd_connect_incoming(const char *fdname, Error **errp)
     if (!migration_fd_valid(fd)) {
         error_setg(errp, "fd: migration to a file is not supported."
                    " Use file: instead.");
+        close(fd);
         return;
     }
 
-- 
MST


