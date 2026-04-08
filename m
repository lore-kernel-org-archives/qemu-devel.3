Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC51310F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYT1-0006Ki-FO; Wed, 08 Apr 2026 15:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY3x-0006DI-1z
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCO-00028m-10
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNWsc1Vb2/FFVZ+FiEtlLRVcdly+39Jh6AgLzzLmjt4=;
 b=J1uRNKP2ox37xyMjv2mMxewoFLmpwYSSxI41bNf7OlVMPuN9w1bFutS7KjgyKWYazGrXLs
 h7mk8xC6BNZjeEWv3rlUPHIhIj9Jj50aBPHkazyXLdZ4dRsiu5nzLJCq4yseKn6+jhjdQR
 5l0qs8SktWpzf2YqaVwf/G0iAnu7tV0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-dXVsTwTdNWKNF-JbTlEzdw-1; Wed, 08 Apr 2026 12:56:14 -0400
X-MC-Unique: dXVsTwTdNWKNF-JbTlEzdw-1
X-Mimecast-MFC-AGG-ID: dXVsTwTdNWKNF-JbTlEzdw_1775667373
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b31cff27fso996151cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667372; x=1776272172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNWsc1Vb2/FFVZ+FiEtlLRVcdly+39Jh6AgLzzLmjt4=;
 b=Pa5mFaiEcJUkhajtukqU36QUOsB8NfJKx5t8d2SHOTacWimWC0bRUphCosbP0QfqTA
 tUSWBA3yqbcOnp1FMuUJhalAQ8bLo1XhEHChSkWHqD/iDmBZFcMgNa7HcoVy2Z9EbY5G
 3HOs6Rl9XLb5ByRfmaWbazDMpvrUClwl8uXlASX3Dmb4zfq4y61+505HUG672OpRmIYG
 kLhgtNwsNFcN/SStNCUoMszciHvqEq7m2tS3otA60b63ledkSTt9vUbywDd+Fx4RExBq
 z26+yqwJGUTqpaTihVvPJHJtJ4PApGPCZdSvHLRwxZ1GMfNXiH8AVDs31b4OSla29uBX
 6JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667372; x=1776272172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JNWsc1Vb2/FFVZ+FiEtlLRVcdly+39Jh6AgLzzLmjt4=;
 b=FO0gvPdcZmN6NqKmcq8cGqHKSpgJPROxYhoesVHdSHlK9lpfKqlgTenAbkmNwGr2cP
 O82IyE4vxBGRb5fGAwsriEqq2KboE0FaZqW+ZkB83WPkWKPhQLU7kWln/ijr0M6LMLaP
 TP/q7XDfDbef8lRgDrwKUv3Ofnxw8xQDo9EEs6UOAAUJc2aj0As8FXV9XnjGqv/ZD1S1
 5YcfayyLkjlw6KxoE7Ulu7Iag+iIM3YExB86VmdX+zLNZNj+igee1nrBK1kM7vzbDlly
 HSyq4gEv+Vxm+a0N78GjCmv6ZFFmG/sSL15pn7V7RBfELYLztDlhaLbMFClUoGFX944/
 aoPg==
X-Gm-Message-State: AOJu0YwJtUfjHI++PRHhqqHJRRn+PbXbQBudrNHf4t0X8zxZVb9zUFSM
 f+G8OoyKV/U7th9OPYbtduKoBbmogfFqYIeakjnuqg7R1I2XVWN69QHAeZiLrdXggY4ixPdAFkq
 7NBZorQPzhtHS89l1xT5SIeuaQyWsxrWJXzvg1eUsbr8mtc91kNDFIGfRLsrqAcrlC20QaLy5JJ
 /PzpRQwZUFDrwLBYGGBOuxfbFqNohq5QuBkfoTqg==
X-Gm-Gg: AeBDiesL9ThOjRAKZTQPrg0eQmhA6vNL72kSrO76+thJe2HDcrfj4sg/myBakjqZ3r6
 PGY3LY97Tz6ScEKWadrh6ptkICyNM8sSLkRL1dyNDcEGD6Lj8zkU1oItfvmYZ9HrXc1SDX1DM2x
 W+ZKgoGvXuE474Esew+Z1NCspOh/aWKlOZYdx8ZYpL4sbJbcRANIa2S9vO7RrRYeCWNiMkPGoZZ
 O+AYk1J2vUlSUw1Q5+y89/+ddI/DkftSPyWIQz6zr3u9HX6ptuFn5iu9P8V8LrE0MDfpDl66b1F
 YV2F5SyI1udSYpTV5CCxYrf8pRHrHa+UmkxQbt8UNsEThCzt2x6veVkQYQgh6ulug1dTXwDCoKT
 p8UIVEpusJWBgSzOJPCRkeucvEZuv7LFuYcid+a5MSkl0
X-Received: by 2002:a05:622a:4cc8:b0:50b:37a6:4f0a with SMTP id
 d75a77b69052e-50d62b7b3c3mr324406131cf.57.1775667372452; 
 Wed, 08 Apr 2026 09:56:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc8:b0:50b:37a6:4f0a with SMTP id
 d75a77b69052e-50d62b7b3c3mr324405301cf.57.1775667371693; 
 Wed, 08 Apr 2026 09:56:11 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 07/14] vfio/migration: Fix incorrect reporting for VFIO
 pending data
Date: Wed,  8 Apr 2026 12:55:51 -0400
Message-ID: <20260408165559.157108-8-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VFIO reports different things in its fast/slow version of query pending
results.  It was because it wants to make sure precopy data can reach 0,
which is needed to make sure sync queries will happen periodically over
time.

Now with stopcopy size reporting facility it doesn't need this hack
anymore.  Fix this by reporting the same values in fast/slow versions of
query pending request, except that the slow version will do a slow sync
with the hardwares.

When at it, removing the special casing for vfio_device_state_is_precopy()
which may reporting nothing in a fast query.  Then ther reporting will be
consistent to VFIO devices that do not support precopy phase.

Copy stable might be too much; just skip it and skip the Fixes.

Cc: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 1e999f0040..57e88c9dcf 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -587,19 +587,23 @@ static void vfio_state_pending(void *opaque, MigPendingData *pending,
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
-    uint64_t remain;
+    uint64_t precopy_size, stopcopy_size;
 
     if (exact) {
         vfio_state_pending_sync(vbasedev);
-        remain = migration->stopcopy_size;
+    }
+
+    precopy_size =
+        migration->precopy_init_size + migration->precopy_dirty_size;
+
+    if (migration->stopcopy_size > precopy_size) {
+        stopcopy_size = migration->stopcopy_size - precopy_size;
     } else {
-        if (!vfio_device_state_is_precopy(vbasedev)) {
-            return;
-        }
-        remain = migration->precopy_init_size + migration->precopy_dirty_size;
+        stopcopy_size = 0;
     }
 
-    pending->precopy_bytes += remain;
+    pending->precopy_bytes += precopy_size;
+    pending->stopcopy_bytes += stopcopy_size;
 
     trace_vfio_state_pending(vbasedev->name, migration->stopcopy_size,
                              migration->precopy_init_size,
-- 
2.53.0


