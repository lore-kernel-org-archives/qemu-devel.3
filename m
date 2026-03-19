Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3341091931
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYV-0001PG-Bh; Thu, 19 Mar 2026 19:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYT-0001P5-V8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYS-0001ba-GB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773962007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhGfQJ/1tmgLlZlyqT2rU+eJDb8Vl/eOR9kvn1/xgAk=;
 b=Oxa81qr4bzVtofzce1JkvMmPPMCf3mBdTgw60OY6AiXokdSZSAodbdxIV3Ou6V3tjCSX9c
 VpAQqdpJku+EAjacsSlzIGe9Yisll2KH+B2j5oZoDLYRRgF7KZm4sNTLzt/T3ERYiZniTc
 7LRhqm5NdUGcrLQNn6P5WrSVabrKN0k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-I2wGZJvDNOS4RksiDia57Q-1; Thu, 19 Mar 2026 19:13:26 -0400
X-MC-Unique: I2wGZJvDNOS4RksiDia57Q-1
X-Mimecast-MFC-AGG-ID: I2wGZJvDNOS4RksiDia57Q_1773962006
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899f474fae1so229123626d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773962005; x=1774566805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhGfQJ/1tmgLlZlyqT2rU+eJDb8Vl/eOR9kvn1/xgAk=;
 b=Ds4YrvIDUyoZFHkUr7kD4h9KTYJK9CrUhFoIYKEpBTOTkcgMkDbwAVXirf4daN5sgb
 IZ8OPFja0MwpuQWQc0kKnltaKyxCW19tohZ8e7BJnwTAqfv038LbsUqz7r20OxtWbLhe
 nV9VfA1PXiFE2AnnJA75njVpLl45Y6Tp/f6mmh4OjUNOG6+pFpRJGR72DmyyOvzBu52Z
 aG9lu979kHencMQO3fRtb5i8ZVss3/2l0kbYbAokI7cjJKWdJmzaJyjApIRs/VOvpFJU
 FBhtRJu4Mtjvd7R4mpUiERVoadq9gB/ehE+Krc7cpkZ3rLh5xZl6czn2i8oZ57ErjzPo
 5pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962005; x=1774566805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qhGfQJ/1tmgLlZlyqT2rU+eJDb8Vl/eOR9kvn1/xgAk=;
 b=RWUER4bGm/zi2x2mOYh7V4AL312GrCkwjtvRMRDE/Il6THWBTt8G881lICDYf+4NRE
 87R6GTMyfpRKRIfBreDvOlRTlNsRvBC23j4Iils60ujv0BlbNK6G/SNc7rOzNcO9dQcH
 1sYhHWlIAUCgAGaYo+hIxoLhIcB+kz/6GRu9bIVGQuEOHPIMBpBaHaBYDyokaLVkqXe1
 pjPMnTyJsq4f/SX1t88k4pz8jyBT+qY08bfkqsNJ7QT1LveaBnO7H5z31JwfsnQjZ66x
 dTSCIUGX0hvGT4nR/1WzYejqVd0JfkiURtlClHAd/Dxn3iwAgNt/2XK4IrEEYibGE/qS
 b8cQ==
X-Gm-Message-State: AOJu0YxJC6kERdO0jUkBKpjKfhXZwscIi7zbtZAKikqK49J4c4koUbBj
 X4ayX/HA3miYwldkqDH8pfPifMsiMZgg450Zfsno6J1EHFwn6lWSDXULSk5ygyvhUmBdd77rCy2
 JC9NxxmUC5i6qaVyhWwjcv4jlW501xYlLHqVRSb5qxt4iAZ78olwud1C7vvdf+T0ozNBoJxGLe3
 e8b4yeyw2YOVVnxFv0E79TjX23Wa29H+GQCPL3UA==
X-Gm-Gg: ATEYQzzdKTVpxSJnmT+gsQCkxgwUcJiMOJ98hVIcotheTeXZiDLX47VuNCoso1Zg86k
 YWBfH/ZybPlY7MEWTwtNh9+XMVfq+8+GBpaLgR5G++Z6QRNGi6ZhtrzQP3isxRi7hunm4C5ORJn
 nzu479aa9As+hE9Z2iTR7yB+OYjXum4R6zOBQNvesgddBnmnLQ5GVT64gwXncGrbA8jyvfhreDO
 G0eK5SY37HLza8PfMDoT/q+nJ/AZYJ08GSsby4meXKgDR64oEKR0ZfkIJsuilwtPItkZPBxrSNq
 m7S10X92AvigUy1IgR1Ocv4VRNKEN4l05+NHbYtHr6Vuh+3tgOFnXlt6i/qp7wb38qmIKdCqU+6
 /I36EI6hSlF8CQw==
X-Received: by 2002:ac8:7dcb:0:b0:506:baf9:5dd9 with SMTP id
 d75a77b69052e-50b2461b5c6mr75315851cf.17.1773962005186; 
 Thu, 19 Mar 2026 16:13:25 -0700 (PDT)
X-Received: by 2002:ac8:7dcb:0:b0:506:baf9:5dd9 with SMTP id
 d75a77b69052e-50b2461b5c6mr75315341cf.17.1773962004654; 
 Thu, 19 Mar 2026 16:13:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH RFC 08/12] vfio/migration: Fix incorrect reporting for VFIO
 pending data
Date: Thu, 19 Mar 2026 19:12:58 -0400
Message-ID: <20260319231302.123135-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

VFIO used to report different things in its fast/slow version of query
pending results.  It was likely because it wants to make sure precopy data
can reach 0 hence trigger sync queries.

Now with stopcopy size reporting facility it doesn't need this hack
anymore.  Fix this.

Copy stable might be too much; just skip it and skip the Fixes.

Cc: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index c054c749b0..9dbe5ad9e9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -591,6 +591,10 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
                           __func__, migration->precopy_init_size,
                           migration->precopy_dirty_size,
                           migration->stopcopy_size);
+        migration->stopcopy_size = 0;
+    } else {
+        migration->stopcopy_size -=
+            (migration->precopy_init_size + migration->precopy_dirty_size);
     }
 }
 
@@ -598,19 +602,18 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t remain;
 
     if (pending->fastpath) {
         if (!vfio_device_state_is_precopy(vbasedev)) {
             return;
         }
-        remain = migration->precopy_init_size + migration->precopy_dirty_size;
     } else {
         vfio_state_pending_sync(vbasedev);
-        remain = migration->stopcopy_size;
     }
 
-    pending->precopy_bytes += remain;
+    pending->precopy_bytes +=
+        migration->precopy_init_size + migration->precopy_dirty_size;
+    pending->stopcopy_bytes += migration->stopcopy_size;
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-- 
2.50.1


