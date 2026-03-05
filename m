Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3985CF33A70
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9db-0003t7-3B; Thu, 05 Mar 2026 09:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dY-0003su-Ry
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dX-0001lF-5s
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ae45a4cc54so31261145ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720709; x=1773325509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SSyAoIoLrDpNT2lbSWeLlIzYN3HHf0purpHK+hYIs1g=;
 b=keFHMSufT6wcw8a+RGiKBudxWjtqyS6n9BfLowk8N297DSdlNU7PdZNKJyVb93Y39g
 FQqx7A5ld+EdeUq1DHNgo6Ix3+N8y7S3gsmPEjT7Wkgam32oHZwzf9nLgHI3WDqnPC24
 c4sn26bd6ChZ3i/anwQ0rmgxajOqps2fCihE0bonl6i12KNS5vhfo0XMVX/QwbCt752N
 cQeHTb3JRaM9PaGMReTVziz32miF/3e1Y6CB6RffIX1uwAFDjwJIIl9JyjojTUt5fOeT
 zJjLddS2o5GNn8Vd7MB8colsMI4+Fbbimdj9Ij0ndLwDHBV8tpF7dVLYbVY+nsuwQuqz
 8clQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720709; x=1773325509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSyAoIoLrDpNT2lbSWeLlIzYN3HHf0purpHK+hYIs1g=;
 b=e1QHpjdcHESMvbarom4DkRPyCZ/qIMxVmJ/kkZDwKr1krTwjBjIrwReCRGZKFM7ZTr
 XjGZ7wkb7JlWImDAZyDgHHrEixyYfdfyvCtssxwjE+RBySjZxbkBTXgajqtEMK9NlgJE
 VzgVRHO5p/qmiFrJdYwRpS4oYCjryoUQLsqaZPcbdmOo1P1bsMNDyzoJ9dLkI9CF5BKc
 01lErsPBFdqVqnvWtDv3C6cu1J4vGT3QHLkcLYeUvsGwmWBC+/JVmPjsCKWxP+zt9pmD
 OcE23C/w5C7hexKM6KuHasRAz4KIpR7Xu5NtyYellUdzu+TostZrSD7rIdIaMx0czlWi
 RRMA==
X-Gm-Message-State: AOJu0YxOGaFTtpiFaV6qnheJHX2yn18jdiVcUKaPMiTsna6/yPsccYZL
 NweBaQ2CvWRUcj1t3CX/bydzs1j21xcv2GFiIjYw+zr4Jjq5aBef+0Br9SJJ1K4K
X-Gm-Gg: ATEYQzwKp3Gwa/E6SAmhW6QeDR7e/ayYPsEm+Szmz7xyDBQNGZws1FCMKJxxF4zbwlG
 6fg7/983AVBcaS4xR5bTjXtoMDK4UkMzU/+CBAC02jyWF2prD1uxvO+eo9msoZdh51BxWwisbgi
 S5401uw0xn+JSaDmxO+gGWascoYYAPqLg3na86TFRRprRiLitoZ1N0PqkpQ0IykHo4eLIehNX/9
 JCgtdYyEj13T5BbPLT0sNgWFrk+DaG1i3UtDKt97kaUrwU/Ceh79ZufDi+7P+Ia4Tu3QdCXFyX2
 Njl7wVoZMgx7oRprbv8s3JSzyRPbQ78xBxRE12gNmSBXfPB+evNbTnM0fRqDXOEwkf20oKKQon1
 FGRfqxEsdcU8tOwCnvOkzFlBedDko1bLS6O7lzGZjdoY+dPk3O2Xuhd761C22KN94KuQs2f/pcV
 t/IeT6hDXAuxE7wIeqA3kpzR6QqfCLjJAKi30IR861tV9OjrU9+WpbFxcgckNqjQPya5A=
X-Received: by 2002:a17:902:f546:b0:2ae:4d23:3364 with SMTP id
 d9443c01a7336-2ae6aba6ebfmr50720495ad.52.1772720708751; 
 Thu, 05 Mar 2026 06:25:08 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:08 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 00/13] iothread: Support tracking and querying IOThread
 holders
Date: Thu,  5 Mar 2026 22:24:46 +0800
Message-ID: <20260305142459.52559-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Motivation
Currently, IOThread references are opaque. This series introduces
"holder" tracking via QOM paths to improve observability,
especially for persistent thread pools.

In hotplug scenarios, users often pre-allocate multiple
IOThreads to serve as a pool. When devices are hot-unplugged,
IOThreads are released but remain available for subsequent reuse.
This series allows users to monitor exactly which devices are
currently attached to which IOThread in the pool.

Changes
Core API: Replaced raw object_ref/unref with iothread_get/put_aio_context(..., holder).

Subsystems: Migrated Virtio (blk, vq-mapping, balloon), Block (export, xen),
            Net (COLO), and VFIO to the new API.

Observability: Added holders (a array of QOM paths) to query-iothreads
               and info iothreads.

Thanks
Chen

Zhang Chen (13):
  qapi/misc: Fix missed query-iothreads items
  iothread: introduce iothread_ref/unref to track attached devices
  iothread: tracking iothread users with holder name
  blockdev: Update tracking iothread users with holder name
  virtio-vq-mapping: track iothread-vq-mapping references using device
    path
  virtio: use iothread_get/put_aio_context for thread pinning
  net/colo: track IOThread references using path-based holder
  block/export: Update tracking iothread users with holder name
  monitor: Update tracking iothread users with holder name
  virtio-balloon: Update tracking iothread users with holder name
  vfio-user/proxy: Update tracking iothread users with holder name
  xen-block: Update tracking iothread users with holder name
  qapi: examine IOThread attachment status via query-iothreads

 block/export/export.c                   |  7 ++-
 blockdev.c                              |  9 +++-
 hw/block/dataplane/xen-block.c          | 11 ++--
 hw/block/virtio-blk.c                   | 15 +++---
 hw/scsi/virtio-scsi-dataplane.c         | 17 +++---
 hw/vfio-user/proxy.c                    |  9 +++-
 hw/virtio/iothread-vq-mapping.c         | 11 ++--
 hw/virtio/virtio-balloon.c              | 17 ++++--
 include/hw/virtio/iothread-vq-mapping.h |  6 ++-
 include/system/iothread.h               |  4 +-
 iothread.c                              | 70 ++++++++++++++++++++++++-
 monitor/hmp-cmds.c                      | 13 +++++
 monitor/monitor.c                       |  4 +-
 monitor/qmp.c                           |  3 +-
 net/colo-compare.c                      | 23 +++++---
 qapi/misc.json                          | 25 ++++++++-
 16 files changed, 198 insertions(+), 46 deletions(-)

-- 
2.49.0


