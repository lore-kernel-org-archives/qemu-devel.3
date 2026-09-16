Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDC6C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJO-0000np-ON; Wed, 16 Sep 2026 17:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIi-0000iX-I2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIh-0007ao-17
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nwNhbSo70/X0tJPmtDCKCPQvZwR26DjNXeNb2q93IA=;
 b=Ag+bnBwe9t4deeVo8x6+EGFUMKmg623Q05YeWqwNqcBaoMtXFh0awVjUkdFL91EXorAj/q
 TKXUCRHXwquwlRDry5Sd8ssYpX/++jU5sovTOz7Ufvl8Sv1HqHHD3oxtnpWnp7aI+SIwxO
 bKsBO7uX7Jr/ag81b0iABQgmWVRxvFg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-AF_Suwq-P1GyQcNZltXmFA-1; Wed, 16 Sep 2026 17:36:17 -0400
X-MC-Unique: AF_Suwq-P1GyQcNZltXmFA-1
X-Mimecast-MFC-AGG-ID: AF_Suwq-P1GyQcNZltXmFA_1789594576
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9123be39eeaso2058336d6.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594576; x=1790199376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9nwNhbSo70/X0tJPmtDCKCPQvZwR26DjNXeNb2q93IA=;
 b=MBUDcXfmvrHtji/Lonk+sousi8ih/hyzW3djonEnZ0/4TtIpJD38bRwuV5JSkf6QF7
 1Tbcmq5y0cCXJAPsHSKWG6RAKrCunY9Qy7JWtdYmP1V+yxtr8HWB1qXqqUyBPWsYd1jy
 QHhgipLZ6kTi0CA3lcVnSnFVCJlwSiFDMcOA/isDBMJrC+KYTwk1b7j24If2b+Nss8xI
 TZ2Ffl2qBjO6zmnf/OskFQUCEJrr5a9cYsXuzZUmWc7zvcVLqDvBscwZL4Niax7mK2fW
 SSAnHe8nxwRZ3kIrghi9shn+Xo4x3JtesiOUz7E2WpJmIgVrt23JtnFt0twbBMLgl2Dz
 oNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594576; x=1790199376;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9nwNhbSo70/X0tJPmtDCKCPQvZwR26DjNXeNb2q93IA=;
 b=zSQDiwyU5Grye60eI4QPkQ0l7sSWgyHmgkpojxRKQu1ymXJ3lUD5WRSB+O7uRDghWK
 Yk7jmOSmVPABwFxerc61O+AvYbdRdRbc6McnCvQZ+HXuvt6Arqp7eRuuv2g1KMO9JLTq
 8sOz+ULSrHPCWzVyt1mweYH+uzGM/p6PnnsV9de/b7hLSWn3KCJ07cakZSWUd0DvBLYM
 C3kLihP9PmfaUpzWjPvJgAN1sLjMhNW1jzH3LnYWF2kLDZ5b9j21hj1OVQtS25yY97id
 n2vB2UI6+rjvwhB8baS2GeTLJZKJPC1+9oA2G0lKAmjPkMziv7HVPSFQz//fFNLynPO7
 iVbA==
X-Gm-Message-State: AFuF++kL45jln7dHoFhD+ca1dvLuO32L9Q9bGTlGM/ESpCXThA//082K
 UgOPlAvH6hHXhKHoaoE1naIA5W6CmoKyaqFrPNwqcdwH0eOHjwx1cmEvYyZX8ib6ozcOIV/Xx/B
 1smMgrzrAbUGvLMzSfYRmSbb/Msr1sD/W5WkuHcqKBgATDZbfZr5Ncj3fvZ9r9lSWUvAdX+2+/v
 k9mlj72yuStrxZLp0J7ROV9fyi8rpN7FoolZ9ilo17
X-Gm-Gg: AYBFou1VOTOLO/sH5DKRPOWdeGGZRsjxd/CgRhYcNzwqIDpuuSH9W5MyiY+518tyZdC
 p8+8Zlgy1tVfywPKsMfvbIHtubiFrbNlNA6M09upBzsgba5Hu4CXKFimRUBdpUXrK7IEnQb8T9I
 Oo6Rkpo0iLCROTU748NipAVkzbgCG/Yp/S3ziE4YWY/AX+Ud62PJ2UAPTKJN1Utfmn8S3pBHJ+s
 AxuWQLq5n9EcXtrhNRMgv31NNrAfVywxu8BwVvxG2AG1ocQIU/wrn1YUHubfMYq3wTVZbP7xOrh
 MlwkxsqX4lo0jc6R6Fgec4Ip+rHGAuhD+k7xhA+k37nNQaja2Db6L56tSFdt2AIXt11i8rC72De
 5s/3P7amXPOzrNbU31zzYhjZv+2FnBc+dg2GUOFHuGIhfwUf67ePHotWbsDo=
X-Received: by 2002:a05:6214:62d0:20b0:912:407f:6a53 with SMTP id
 6a1803df08f44-912407f6b2emr49120746d6.17.1789594576334; 
 Wed, 16 Sep 2026 14:36:16 -0700 (PDT)
X-Received: by 2002:a05:6214:62d0:20b0:912:407f:6a53 with SMTP id
 6a1803df08f44-912407f6b2emr49120376d6.17.1789594575827; 
 Wed, 16 Sep 2026 14:36:15 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123be9ca82sm34619076d6.32.2026.09.16.14.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:36:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/7] migration: Fix socket listen backlog
Date: Wed, 16 Sep 2026 17:35:54 -0400
Message-ID: <20260916213558.587304-4-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213558.587304-1-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

QEMU incoming side may have set a wrong listen() backlog.  After the
support of multifd + postcopy now we have four possibilities on setting the
backlog, some of them are wrong:

  Vanilla:            1 (correct)
  Multifd:            N (wrong, should be N+1)
  Preempt:            2 (correct)
  Multifd+Preempt:    N (wrong, should be N+2)

No real report for this, found by code observation only.  Logically the
backlog (pending accept requests on destination on the listening sockets)
needs to be the maximum of possible channels.  Otherwise if the accept
queue full on destination, source QEMU may hit connection errors.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Fixes: 0705e56496 ("multifd: Use number of channels as listen backlog")
Fixes: e274188612 ("migration: enable multifd and postcopy together")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index f57f1a8e7c..31bfa1eeeb 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -139,21 +139,32 @@ socket_incoming_migration_end(void *opaque)
     object_unref(OBJECT(listener));
 }
 
+static int socket_get_max_channels(void)
+{
+    /* The main channel is always wanted */
+    int num = 1;
+
+    if (migrate_multifd()) {
+        num += migrate_multifd_channels();
+    }
+
+    if (migrate_postcopy_preempt()) {
+        /* The preempt channel */
+        num += 1;
+    }
+
+    return num;
+}
+
 void socket_connect_incoming(SocketAddress *saddr, Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     MigrationIncomingState *mis = migration_incoming_get_current();
     size_t i;
-    int num = 1;
+    int num = socket_get_max_channels();
 
     qio_net_listener_set_name(listener, "migration-socket-listener");
 
-    if (migrate_multifd()) {
-        num = migrate_multifd_channels();
-    } else if (migrate_postcopy_preempt()) {
-        num = RAM_CHANNEL_MAX;
-    }
-
     if (qio_net_listener_open_sync(listener, saddr, num, errp) < 0) {
         object_unref(OBJECT(listener));
         return;
-- 
2.55.0


