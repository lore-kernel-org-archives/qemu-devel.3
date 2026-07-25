Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163F3C5321C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ02-0000bm-SC; Sat, 25 Jul 2026 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ01-0000bC-CW
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnYzz-0004Sb-5w
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e13Mb7maGRAJH7OvnZ926KOz18CeSHnJdJR1T7xC40A=;
 b=OaSzfBgFNs9KlK7E+phbfC0LkLkgBa5j6739GwSxWJnfbxPb774/Bl5We9BwBIBV5SYhEW
 UEZkhk3VXr2Y4OS7p+fMJ+zI9OJPgZWF+rfWP39vzijqTMMoa1QKe7XZEUfKeOVRRoRYBl
 KebcfMIeRHTfr3XeLoNFOB39rNea6cQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-kYzblYh9M3msHOtqaHQbsw-1; Sat,
 25 Jul 2026 05:48:44 -0400
X-MC-Unique: kYzblYh9M3msHOtqaHQbsw-1
X-Mimecast-MFC-AGG-ID: kYzblYh9M3msHOtqaHQbsw_1784972922
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E85A1800BE2; Sat, 25 Jul 2026 09:48:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED020180058C; Sat, 25 Jul 2026 09:48:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/8] coroutine: add missing annotations
Date: Sat, 25 Jul 2026 13:48:31 +0400
Message-Id: <20260725-co-v2-0-d3552ddb3931@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw7CIBBFf6WZtRiKfagr/8N0AcNUMLEYQKJp+
 Hehrlye5NxzVwjkLQU4Nyt4SjZYtxQQuwbQyOVGzOrCILgY+Cg4Q8cG0evTEUeNPUERn55m+94
 i1+nH4aXuhLEuq2FsiM5/tpfUVu8vmFrG2SyV6rQ6oODdxZM2Mu7RPWDKOX8BIeJuKacAAAA=
X-Change-ID: 20260720-co-625d98c7dc5e
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2835;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UiBNZ2dLsT27ndVIEPrVDVYPrIaCaXetKCB0PHn/T4w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZyxijLscQgf5Ye8jfY1pGaTGwVtCUvcZaXR
 XseaOgh4JmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcgAKCRDa6OEJdZac
 5RA2D/9tOiNq4Y1Dun+iWt0u/fLZLPiBlkO8/pPVYU0awhd4nKjGWPkE5n8jlnOaVh81URwKVKj
 XYYSM5ErwIzwsIsPGpZK/MZeqMxdEOWcM/upxb016g1pArAW7N7k00hpVMU9ZyLFkXH/GkfBNPl
 V48RG54Y2Skh+gGyNN/1M3kzwa2O7yCEzCSaBEJ367Pftcqpq80UqJBbMkfOKxAe1FYXMh/BzoX
 k88Jxapps8SnPJTWLj0MQr1r41T8BSIbdG6MfbsresjGaNVtObS7zV0xlrSh2fIsb//B2jzl2L4
 j7M9HZt3DIAiqUu2MdamDVvWfa7Ot9CyF6BWRzas2XZ8tqjWOgbiIvM9Qic2kFi35145EfSnBPy
 hNx4WmyJZ3yhkIdsGFQ8q/xerfA5XCYRSW2EajQY5QVcdItN28GUYu4ORHDQWHWsk7V/WaGxPNi
 z2rcinlUWJ7j7FHaO4J3SaViHIDbObYBK1WRbfSjhMYSMEhyDpPD1+gKVcA+TbUyBJgvFFz1Tmh
 GieBbjf766JH70LbrLi59p1+geD6Gjf7L4X+BTvJV0xaQGM3TRjA1avvzqjsdOteR24ISCT/KF1
 Mdd3bw32N5ri4n0SK4hrqKYhDDFuKQygzvZULKve53ivl7+zI7P9L+ciuM+lJ/wu69hiYcsqP6h
 hCe6gb7FKA7kd7Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

Hi

Add missing coroutine_fn, coroutine_mixed_fn annotations and fix
a few related issues across monitor, migration, io, block, and
9pfs subsystems.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2:
- fix some annotations in patch "block: add missing coroutine annotation"
- collect trailer tags
- Link to v1: https://lore.kernel.org/qemu-devel/20260720-co-v1-0-fabb4db3c204@redhat.com

To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: "Denis V. Lunev" <den@openvz.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org
Cc: Li Zhijian <lizhijian@fujitsu.com>

---
Marc-André Lureau (8):
      monitor: annotate monitor_qmp_dispatcher_pop_any() as coroutine
      migration: fix qemu_get_counted_string annotation
      io: add missing coroutine annotation
      block: add missing coroutine annotation
      qcow2: remove invalid qcow2_check_refcounts calls
      block: add missing coroutine_fn annotations
      hw/9pfs: annotate V9fsTransport callbacks as coroutine_fn
      migration/rdma: annotate and simplify wait_comp_channel()

 hw/9pfs/9p.h                 | 26 +++++++++++++++-----------
 include/block/blockjob_int.h |  2 +-
 include/io/channel.h         |  4 ++--
 block/commit.c               |  5 +++--
 block/crypto.c               | 13 +++++++------
 block/io.c                   |  8 +++++---
 block/parallels.c            |  5 +++--
 block/qcow2-snapshot.c       | 18 ------------------
 block/qcow2.c                | 12 ++++++++----
 blockjob.c                   |  3 ++-
 hw/9pfs/9p.c                 | 31 +++++++++++++++++++------------
 hw/9pfs/virtio-9p-device.c   | 24 +++++++++++++-----------
 hw/9pfs/xen-9p-backend.c     | 34 +++++++++++++++++-----------------
 io/channel.c                 |  5 +++--
 migration/qemu-file.c        |  2 +-
 migration/rdma.c             | 12 ++++--------
 monitor/qmp.c                |  3 ++-
 17 files changed, 105 insertions(+), 102 deletions(-)
---
base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
change-id: 20260720-co-625d98c7dc5e

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


