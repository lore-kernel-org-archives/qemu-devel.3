Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB4BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzdNu-0005vm-Fc; Tue, 01 Apr 2025 11:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tzdNr-0005vL-Fh
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:18:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tzdNp-00059b-90
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:18:34 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22622ddcc35so36257595ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1743520710; x=1744125510;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovSzhMp4DABOfKsIdmvqMUGiFV0+sG/fv+dA7kJuTo8=;
 b=hcbkEI7VyC6YX0DnOGniuFTMDVH+C/s01qw1hXfsWJsOPMRWK2lIEL7aBi2mAAoGM4
 VD+64y3YlTql/i4Th2EMlyyvYslAD54HfSYhsw9q6ZDBohVPznW2Rv4JPUp75hU1g/H6
 OqkZK+4xQBNXX5dE0LVDxZRuJ/UTRx4cuRnmqi7t41mTiNOSBnAZoBP3WmeUCc6YmuYn
 ecEqRxv2hLSXlriWPhgBNIXWi9dl3u5t2Z/oziHGJ58jXAwNMTqhXyBw/eF9NZpuU2xO
 Xwhr0I1klzUnDk9F1UaM2TDa/bwADDKUklQ2MGxtMUxoMOOq6f9NVK6oNSA/IYpeRB/N
 AO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743520710; x=1744125510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovSzhMp4DABOfKsIdmvqMUGiFV0+sG/fv+dA7kJuTo8=;
 b=N7MflcKRTq0JhRCzECuUZXl6/Av0L0PnWjfjnBL5BiWOU58z+AoCaoXCWbfP/BlHSR
 fIkFjb8eljOiaMjbKFYOiG9QL8UXu9Vz+Wz2AqptKKIjW4cC6iqPQaVGbLf5a+GD8HrS
 +Ozp3Wr4BLJVTH4dyx3ebFwOjBv8yX7N+mw6Tg6zcNbpU6f+jkWaKsuXU+29GqsG7McL
 P20d8YmC32JNfcU9zOzowQL0aMxKqVN1dKpdKqf4kpSOARhZCoo5L/hNgmQJ2/GNS21K
 am1uYQ0RpVHFcxeFzum4moMqWtLKFk5+Jx5onDKm1SXxcftCWA013RrxWYxSFSGbzJ1N
 Iy/w==
X-Gm-Message-State: AOJu0YxFFoKtF9eZDVwdNNNZrazf0SkyOxIgqgxOxxiL4JdSVzKgU6gk
 ChMaEna0mRwc5VQ9XrKOmxx+C6ArKw+P1W4C66TzDh99pU9Obpo7ZgjQIZKtT1tTgBrfotC46Sj
 DeVAx6A==
X-Gm-Gg: ASbGncsBgcvWUcHR1S82Newwra/+hCoRdn+jvJGwsyy9P7u3WtcZZ76EbrKiUqE7qWx
 uzRGWaOUZXf0BXK94inCnUQ0qCCb7BNTHBUbHuyCwLibzqx4VtUo5oQW1lR/JEOrGQezMw46RSX
 cXFXSQnVE3CgC3I3jFV4B/55C1slU+C1qq0JBABsdjDp9poyVPuxF+azU+rpYtuMQ60Hw6AsKiM
 9hQybgmoKtEBUl5fNmTX3OB6/RKSkcW4ArRQln/UbLsCemM0BY7j6UYf0baJTsjfgJKE2y5XXkz
 n0xI7yEVVih5b1pw111tt0vvdVijD+M=
X-Google-Smtp-Source: AGHT+IFFYki8X3Y8/rj0kDpcNOEsUXZVQm84B9BuMdr0KhiMxdmiAnI1Msp7yenmFaTzBAQj6QrEcQ==
X-Received: by 2002:a17:902:da84:b0:21f:1549:a55a with SMTP id
 d9443c01a7336-2292f942cbfmr201169085ad.1.1743520709922; 
 Tue, 01 Apr 2025 08:18:29 -0700 (PDT)
Received: from fedora.smartx.com ([2001:df0:a640:1::4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee029bsm90172195ad.62.2025.04.01.08.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 08:18:29 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org, sgarzare@redhat.com, mst@redhat.com,
 raphael@enfabrica.net
Cc: fengli@smartx.com, yuhua@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com (reviewer:vhost-user-scmi),
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 virtio-fs@lists.linux.dev (open list:virtiofs)
Subject: [PATCH v4 0/3] vhost: fix the IO error after live migration
Date: Tue,  1 Apr 2025 11:18:14 -0400
Message-ID: <20250401151819.1526461-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250327064348.3595732-1-haoqian.he@smartx.com>
References: <20250327064348.3595732-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

At the end of the VM live migration, the vhost device will be stopped.
Currently, if the vhost-user backend crashes, vhost device's set_status()
would not return failure, live migration won't perceive the disconnection
with the backend. After the live migration is successful, the stale inflight
IO will be submitted to the migration target host, which may be leading to
the IO error.

The following patch series fixes the issue by making the live migration
aware of the loss of connection with the vhost-user backend and aborting
the live migration.

---
  v1 ... v2
    1. Fix some grammar issues in commit message.
    2. Remove assert in vhost_scsi_common_stop and return error upwards.

  v2 ... v3
    1. Added more detailed comments and commit message.
    2. Change the newly added type name and parameter name.
    3. Remove set_status_ext, change the return type of set_status to int.

  v3 ... v4
    1. Call set_status() only if the function pointer is not NULL in the
       3rd patch.
    2. Add the more detailed commit messages for the 3rd patch.

Haoqian He (3):
  system/runstate: add VM state change cb with return value
  vhost: return failure if stop virtqueue failed in vhost_dev_stop
  vhost-user: return failure if backend crash when live migration

 backends/vhost-user.c                  | 20 +++++++--------
 hw/block/vhost-user-blk.c              | 27 +++++++++++---------
 hw/block/virtio-blk.c                  |  7 +++---
 hw/char/virtio-serial-bus.c            |  3 ++-
 hw/core/vm-change-state-handler.c      | 18 ++++++++-----
 hw/display/vhost-user-gpu.c            | 12 ++++++---
 hw/input/virtio-input.c                |  3 ++-
 hw/net/virtio-net.c                    |  3 ++-
 hw/scsi/scsi-bus.c                     |  2 +-
 hw/scsi/vhost-scsi-common.c            | 13 +++++-----
 hw/scsi/vhost-scsi.c                   |  5 ++--
 hw/scsi/vhost-user-scsi.c              | 18 +++++++------
 hw/vfio/migration.c                    |  2 +-
 hw/virtio/vdpa-dev.c                   |  5 ++--
 hw/virtio/vhost-user-base.c            | 23 ++++++++++-------
 hw/virtio/vhost-user-fs.c              | 23 ++++++++++-------
 hw/virtio/vhost-user-scmi.c            | 27 ++++++++++++--------
 hw/virtio/vhost-user-vsock.c           | 15 +++++++----
 hw/virtio/vhost-vsock-common.c         | 12 ++++-----
 hw/virtio/vhost-vsock.c                | 11 ++++----
 hw/virtio/vhost.c                      | 23 +++++++++--------
 hw/virtio/virtio-balloon.c             |  3 ++-
 hw/virtio/virtio-crypto.c              |  3 ++-
 hw/virtio/virtio-iommu.c               |  3 ++-
 hw/virtio/virtio-rng.c                 |  5 ++--
 hw/virtio/virtio.c                     | 23 +++++++++++------
 include/hw/virtio/vhost-scsi-common.h  |  2 +-
 include/hw/virtio/vhost-vsock-common.h |  2 +-
 include/hw/virtio/vhost.h              |  8 +++---
 include/hw/virtio/virtio.h             |  2 +-
 include/system/runstate.h              | 13 +++++++---
 include/system/vhost-user-backend.h    |  2 +-
 system/cpus.c                          |  8 ++++--
 system/runstate.c                      | 35 ++++++++++++++++++++++----
 34 files changed, 240 insertions(+), 141 deletions(-)

-- 
2.44.0


