Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA62DCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI754-0005Gz-J7; Wed, 29 Apr 2026 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wI750-0005Gn-Q3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wI74z-0002tC-4w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777477438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7MRepjFLJT74hAVA+oe3OARbWDyMeZACl0QFpDbepg=;
 b=PqlAJYvrSMsgDgZKTJVnOt7VQteUjDdzDNyXlRuMk/vuk/ATw2T85JbBUDYjTuSPlEnKyy
 nt7eNIfWRfGRTcDL7fZKxBYLWOH5oaKbjFZZmzUQNhdaX+NcOqgbl4ZfCNdZRBaQXzVrrd
 MCscppnxF5Phm82SlkQ5E1m5q8XmzdY=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-gSNzDmZ0PyatvVSM2gTF9Q-1; Wed, 29 Apr 2026 11:43:56 -0400
X-MC-Unique: gSNzDmZ0PyatvVSM2gTF9Q-1
X-Mimecast-MFC-AGG-ID: gSNzDmZ0PyatvVSM2gTF9Q_1777477436
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-953d479ea6eso15513253241.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777477435; x=1778082235; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d7MRepjFLJT74hAVA+oe3OARbWDyMeZACl0QFpDbepg=;
 b=p4UXlLqU2Ue6w498TvpiXQqXBZVkbf6iN9eKjHHC8W4xnpMSJdOPQEEVwudEKeS+/p
 QrwtqvQ6H7tnttLyaRPiC8T/ngkviLnQJswlA71J+mp4YPYPUyIONmfss80dJLSiZOsB
 Y4QAR6EU9Gva2Hp5SfdD5ZeieN1nRX8tner+pekKiyB8Hmsk3fmgrhqFRU7MQBtzU5jP
 xgoO89hwH66KLajl9txC3BDCjqDHVZuwfkMy8z7PNNsDXZPoFO089x24Rx50XVZjhlnR
 isjdbzi/2jeqMToO+gLXVtyE5Z7XSoEuwC4t4MuSvDgpqFloXu6sDMejzKdk+lYITW0E
 5T+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777477435; x=1778082235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7MRepjFLJT74hAVA+oe3OARbWDyMeZACl0QFpDbepg=;
 b=IODe48XUGPX5t2Kz5CAMDf3PlIuEnIlbpiarzq13ofNALjlQoiiDk244TGMfKg36JP
 6WoAK6A/zdaGHQ0xh9NeoG89t5ijpn0VVD4AVIzDbRJM0DEjXaDGOryNbRcKxifF/w5j
 rOA436LMpTZ0QKczkFOiZhml5knOPEoUDX9ykLChPDFgpVorWfmxMzvXV3a32JoKO6Ml
 /lnV5rVRePMTtfp2yCvTxc+kBWwkuRkFFbctLNm2wKJpa41ksWNB/R3kfPzccOyW9Y4c
 gNL0Mj8HRNaZFi51klEdZI/Ity39uwr+ir53AZcsAshCCsdCMTYiLjlYSft/7NQ6VJ5r
 WP6A==
X-Gm-Message-State: AOJu0YxwzfOt+h107qXGsMLuoW+LabuqVAw40NPvMuR6eNwXjE57jUnf
 yXJ9FPlZ3t6x7WdJ3n88wA1HdYNFUs+Bfb5V6L2fKgmzlTi35B2G05vM/g9AV75o2P+EJzlNhvf
 AreKp8E51z/vlm+RSrduisgcUi+nz4X3X7CHehf4dp390x7XtuPeASY+m
X-Gm-Gg: AeBDievCuSTuJQQvmPE1yJVNgB4QHtd5XHZ6Gc3WOmULm5jW1qRptTmm8lBmJCz9geb
 ODuHAveUJcDUAS6eglSoTBuFAUGl/P+5fEzyaougNkHWgxM/tRoLZivLoNPPRwNe+xSwGgjk9Rk
 LzeM7jJmGJbJVH/usNiiCj0Ol/8YBGCfYTasuXOXJig4meNyxQr33Sa3Q/MYWvC3HjfTWxSNKvN
 u6dWu+Mv87Hh9kcRoiSATevkZMQfAQn7Z/BlahhrTyMOvleQD25eXDqdIOoAdfz6be8+nj3f/Nr
 E+8u9Coab8mdr/uI56O/Gy3jaUe2R+9ZH7qbYSi4iRk4SinUUzLmgIYrHZNQU5omVZM3BxTXbsu
 GmOw/gKV1WGnC+ElAsEpFzb5bZR2XMYQVgajYHowY2Lr/dWQ2xBe60jaBJw==
X-Received: by 2002:a05:6102:149d:b0:612:164e:ab02 with SMTP id
 ada2fe7eead31-62924c7c009mr2781101137.5.1777477435481; 
 Wed, 29 Apr 2026 08:43:55 -0700 (PDT)
X-Received: by 2002:a05:6102:149d:b0:612:164e:ab02 with SMTP id
 ada2fe7eead31-62924c7c009mr2781057137.5.1777477434895; 
 Wed, 29 Apr 2026 08:43:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef71b471sm20700436d6.22.2026.04.29.08.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:43:53 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:43:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 16/16] vfio/migration: Add tracepoints for
 precopy/stopcopy query ioctls
Message-ID: <afInOIANAJLftQ7w@x1.local>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-17-peterx@redhat.com>
 <8943abf6-fdc8-4684-8e2d-3a8c95d59c19@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8943abf6-fdc8-4684-8e2d-3a8c95d59c19@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 29, 2026 at 05:46:19PM +0300, Avihai Horon wrote:
> Ah sorry, I just noticed this now while doing some other work -- if you
> respin the series, could you add the device name to both traces? And while
> at it keep the traces alphabetically sorted?

Could you help check if below fixup is suitable to be squashed?

Thanks,

===8<===
From 930723da46e16c2ed5405916a7e10d4f560e22fa Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 29 Apr 2026 11:41:49 -0400
Subject: [PATCH] fixup! vfio/migration: Add tracepoints for precopy/stopcopy
 query ioctls

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/migration.c  | 6 ++++--
 hw/vfio/trace-events | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 04d9f94edb..150e28656e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -350,7 +350,8 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
         ret = 0;
     }
 
-    trace_vfio_query_stop_copy_size(migration->stopcopy_size, ret);
+    trace_vfio_query_stop_copy_size(vbasedev->name,
+                                    migration->stopcopy_size, ret);
 
     return ret;
 }
@@ -374,7 +375,8 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
         ret = 0;
     }
 
-    trace_vfio_query_precopy_size(migration->precopy_init_size,
+    trace_vfio_query_precopy_size(migration->vbasedev->name,
+                                  migration->precopy_init_size,
                                   migration->precopy_dirty_size, ret);
 
     return ret;
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 854a7e4b19..ab27ff5ea2 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -162,6 +162,8 @@ vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
+vfio_query_stop_copy_size(const char *name, uint64_t size, int ret) " (%s) stopcopy size %"PRIu64" ret %d"
+vfio_query_precopy_size(const char *name, uint64_t init_size, uint64_t dirty_size, int ret) " (%s) init %"PRIu64" dirty %"PRIu64" ret %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
@@ -176,8 +178,6 @@ vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer
 vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64 " exact %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
-vfio_query_stop_copy_size(uint64_t size, int ret) "stopcopy size %"PRIu64" ret %d"
-vfio_query_precopy_size(uint64_t init_size, uint64_t dirty_size, int ret) "init %"PRIu64" dirty %"PRIu64" ret %d"
 
 #iommufd.c
 
-- 
2.53.0


-- 
Peter Xu


