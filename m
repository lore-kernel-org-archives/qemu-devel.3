Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B11091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYJ-0001Mk-Bo; Thu, 19 Mar 2026 19:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYI-0001M0-4M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYG-0001PH-Gr
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773961996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CYpOBSw137WiL2qGC9SqFhoCArm6dY0CTE+aFxRoEQ=;
 b=gT05cvnxZqavhW7fjHozwfdVGCoFfl40SH/W/kQsPan91dhzhGKds+XtcmKDZEgHjFDiVT
 ihdyb4d+WMPK6W7k/h0wUHbkkVOVr5k3E628H11cgpe1ZevG3Ame8q7NyPx5Qn+/sqS8SS
 LmpO3lPR95X/HBQj5H3bDLnJNOPB4Mk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-hBW159fKNMyhENBhL-PmCw-1; Thu, 19 Mar 2026 19:13:15 -0400
X-MC-Unique: hBW159fKNMyhENBhL-PmCw-1
X-Mimecast-MFC-AGG-ID: hBW159fKNMyhENBhL-PmCw_1773961994
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50911c94db1so83482231cf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773961994; x=1774566794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CYpOBSw137WiL2qGC9SqFhoCArm6dY0CTE+aFxRoEQ=;
 b=EeW4pNeEQvgQPZDcfuf2K7XyxURrO2Ajxz6N07+DiOSx7Ik4ZJB4FFBm3MdX4rIBWK
 8Fx+cp8ydUVfGJEph2rq3bqG+5WD0gFvL2FB66/DuSaUgwULRCOx8QjvAldnx5g2ZPPh
 qFj6ya5NPDVNlo19ITSPtmdJ4CC5+bUmxC+1ApaUJ7nc4lTv6ooysUXI1kV69l/ver/E
 GCqKmDsQBy7n50CyMqHvCRX6JsZ1XghlEgDVClw5anrAuXZBBcMp1gZXkVcYzdbgaq0m
 9aEkIiTcU+GBCvFSKhv6M02PgwSpDesVzhBDx41EV13Gq9Bl1GgMq6pz6lc4gl/hLXSF
 eX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773961994; x=1774566794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7CYpOBSw137WiL2qGC9SqFhoCArm6dY0CTE+aFxRoEQ=;
 b=oB/uj3jaCryzJCQCr4aFbYsKXzDceHEws5cOq1bOwwe5Eq4zcnMQUaR8jtECvpIAiN
 F9L2YFfwMnINFjRj+LQNKPvDadmx7LxF6FwnF5Oq95iI8N3SKtSH/Al/YXPGuyBQ5DS2
 GnmDp6QPlWdUeZ2L65tAIm5ySpu6tV+7EySG3ailqHR0vYGhWSafXENaQl11TbUt18zD
 VvjNuY2EZ24DZz/K4vszuqYZN8zk/gPnw1KtJIttlPJv9pwP2w20HDTU2I9fpI5jFOp6
 Y3dxmT9wEwncdgEuMbkxTxi2PQ9Y2HJItasSdp6vXHam49QSMX/FZSChgeZwsBlkn52J
 tSRg==
X-Gm-Message-State: AOJu0YyyEVlfwoVyXt9QYDPajxk545yB04ENey5zumt3rYgVjMnRrkNR
 +xVS4/hhEZHw2myTRA67LbrNXHcjrsu0whtHUBpsj4lPvvW1emjzB8D8Qk00xKgazZNnWqpTNf+
 8x/2J1YTA/L/QhL/4vFJ/3DwLbNiHz0pjA0sAvCBIBkHEfaLeL0QNgy6JDiMHZ4sRZTEMeAL+ip
 v4c/bLebgsy0dgFu4G7bYM8MFo/ZyUvAUB89OylQ==
X-Gm-Gg: ATEYQzx3PyViHPJ2HvoPYUdcum2veVHnfbtZhH/k2KhIdcZvDfFGj9hvA83EFNVbhwz
 vZlJ//GXZt3QgWOulzIbrVPLDuAOCoecJ0PqyL1p88SW1+khgA3RNzPdh0/qyhZmbzcqrQUgCz7
 y9X5ikKEtnIDnXEgqFw0kNuZEHiyL4Ukj8o66sA1KootcfjoYl5K2AbxRtqDKilecKshfN3zJQp
 PAPdxBaATvjM7yCt/GFtw5SUY3b65W9dSmrl/UOcjl465/9aRncN5My811S+pqydLIgZhndJYwA
 9v0pmPtaKOGG95tQgPXkwzginU5B83hiSOaZmhAj4n3qzMugwEnw0dNiYy4jo9Bc+CKHPyPeVNY
 Ydiw9Q/e6k2W/Kg==
X-Received: by 2002:a05:622a:118e:b0:509:3fc5:a847 with SMTP id
 d75a77b69052e-50b3738ea69mr15533601cf.12.1773961994183; 
 Thu, 19 Mar 2026 16:13:14 -0700 (PDT)
X-Received: by 2002:a05:622a:118e:b0:509:3fc5:a847 with SMTP id
 d75a77b69052e-50b3738ea69mr15533181cf.12.1773961993612; 
 Thu, 19 Mar 2026 16:13:13 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:12 -0700 (PDT)
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
Subject: [PATCH RFC 03/12] vfio/migration: Throttle vfio_save_block() on data
 size to read
Date: Thu, 19 Mar 2026 19:12:53 -0400
Message-ID: <20260319231302.123135-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

During precopy phase, VFIO maintains two counters for init/dirty data
tracking for query estimations.

VFIO fetches data during precopy by reading from the VFIO fd, after
fetching it'll deduct the read size.

Here since the fd's size can dynamically change, I think it means VFIO may
read more than what it "thought" were there for fetching.

I highly suspect it's also relevant to a weird case in the function of
vfio_update_estimated_pending_data(), where when VFIO reads 0 from the FD
it will _reset_ the two counters, instead of asserting both of them being
zeros, which looks pretty hackish.

Just guarantee it from userspace level that VFIO won't read more than what
it expects for now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 83327b6573..851ea783f3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -357,12 +357,18 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
 }
 
 /* Returns the size of saved data on success and -errno on error */
-static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
+static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration,
+                               bool precopy)
 {
-    ssize_t data_size;
+    ssize_t data_size = migration->data_buffer_size;
+
+    if (precopy) {
+        /* Limit the buffer size to make sure cached stats don't overflow */
+        data_size = MIN(data_size, migration->precopy_init_size +
+                        migration->precopy_dirty_size);
+    }
 
-    data_size = read(migration->data_fd, migration->data_buffer,
-                     migration->data_buffer_size);
+    data_size = read(migration->data_fd, migration->data_buffer, data_size);
     if (data_size < 0) {
         /*
          * Pre-copy emptied all the device state for now. For more information,
@@ -623,7 +629,7 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
         migration->event_save_iterate_started = true;
     }
 
-    data_size = vfio_save_block(f, migration);
+    data_size = vfio_save_block(f, migration, true);
     if (data_size < 0) {
         return data_size;
     }
@@ -667,7 +673,7 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     }
 
     do {
-        data_size = vfio_save_block(f, vbasedev->migration);
+        data_size = vfio_save_block(f, vbasedev->migration, false);
         if (data_size < 0) {
             return data_size;
         }
-- 
2.50.1


