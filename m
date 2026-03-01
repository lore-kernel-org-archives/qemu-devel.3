Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE06FFD0075
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmI8-0001Os-A1; Sun, 01 Mar 2026 14:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHx-0001GV-TC
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:13 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHv-0003Yx-Sn
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392612; x=1772997412; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RaLheKABVK17otyAeTrFqQT6iXkEVt4t+zmb00K3oXgujTqzMvfQGzWXyA6LFAPh
 wahoKTi2tHne86OygzeGnTVuvTZ/LtkOJjFn3vMT0pl47dltQzzw4wSbR5tkD1g9p
 DqwYDLiD3/jPQGa/nIvXqEIfE33Jb2ko1eEehXlxoiIltPWrImByYg6bDuqLdu2Nq
 Rj7+BH6+jpgZnVEdvHi5Di/vYOtnpuqvlOL7ODYDabKJutOmAqB84GwtEnGyjg/UL
 CZ3XznVn8hAz9Ul9lyQsT4uvQUuHZifoHjDBBm2P4QJGPFf5scNB8Hy4BFEP7hdxL
 8Q7C4VJami3daxDQeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1wLaZN3CkU-00KqbY; Sun, 01
 Mar 2026 20:16:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:34 +0100
Subject: [PATCH v11 09/21] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-9-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdym8oa5CF6PlQQVhJe2F/cdK4lhJeZiIzN
 ORG8QgQ4dKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WLQ0EACe54OwS6tW+TI0miLYDoOa8fuuPtgvAmQ3wNmLWqynmCracOWUIBwT2HYossZSnOmJRQy
 IwYI2DkIswR4wPxDQWEJXqwR0mNZNS9P6u42yxO3Cc6H0VvnvoCO/YLsDn+pzg+9j7HukZAQq9z
 JniBajWYH+ahMB7NuzZNbEL7qmng7RL5Ha3rwMSEJ6tWDVZWgVeT6lbzuILslma9VAuCJSqBm3W
 52jkLa55Ds3PIGYxETQa/x4HMtv/10iSpmM0jO6OX8Uf+VxNjmfXVMPRcuN0V8emrrrY0+dI6I2
 KLEDVgLt4YuHI64F3EE0oLzg99JXw0/TImtD+/JmxayeeMBz4naaXvlWnfTZjnIfIOcLswQh6x/
 pTx/rH2xnBHvf3W8n9kb4Z4cS1vyw7GHwNNkeZCbeV7XkqPW1q2lQMRu7kKpYqhq7esLlUZ4oMl
 fqNbwWdXBDpmTIrm8063tWzs0DYmQxO+f6T1WWuNCU+fE7uG5IIJk/j3du4I4HEqSYbWgwjxVi3
 ceB9MTcJN2DHp2dE0PRDSBBx61qx9tho5835OelYjO7F5lpSMK2bbH9qb1BzELsUVUDEkDwhBhz
 Xh+Ve2Vf4eutnYz8V/7sA/mAJHM/hwd20VagPWLSmzynECb37HalV6ugnwhoI6XmVYV67zJeExs
 C/J7am45cq5uNVQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:723TaCl2UWx5Y9uFl4JSfRwofMQK5VjbPHJo6nRJIxWZN55n5UG
 Y6E9koUqURXLp1JS2gEtA87s9RYl7o/IZd86I5J0J9mLPcV7P5l/Hg5t2hjiV4ST9Ke5Vtf
 ZHMzdbVF3PxANIe7kkhtWd4dRBpYNLkQXn4ZMY5IR+uvPLKmcXwOTQHDFjIBjz2jJkDPUpH
 GkM+/fFN5qlJumxJ1azww==
UI-OutboundReport: notjunk:1;M01:P0:VO1NRXe33Es=;yvEQgLk0cfSPBuaHvBIbrsF5s1U
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 97a224c39c49ff2269f375db47112458cab0b4cb..96102c9d0fb3b60e063c81ce07=
b730011bc4919f 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -949,7 +949,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index dba5d6ede579da42693d5270ede9660fb145238a..f36d42ef657bdf26d78ca642d7=
7a9b76e1c0c174 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


