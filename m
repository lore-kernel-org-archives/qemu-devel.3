Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85892C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt256-0005mP-0x; Fri, 14 Mar 2025 06:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tt250-0005kP-Kc
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:15:50 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tt24x-0002z0-H9
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:15:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225df540edcso9505495ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741947344; x=1742552144;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opiqrpnO7vMjzM2WONF0yYqPnTwjiMcMPD2r9uI5yS0=;
 b=Ljt1uuJbBk1FF3g9gWBx2ryBHAeLzg8Lx7fjXKjmiJHz8Wft+kfFEC3FMwIoM5RoHP
 /BcbBhr8p0gav9SVK6Pv9oHYOTogZeoa25PESycSVNXwQUyxMgfB03FOuuw5sZWq6xvk
 gO3x8CFEUc7pwjMaLlGRAAdO07vEGk445Y0/gRIaPTWsCwD4enHPsnzo3H0eVu5ZijR8
 NxWaxi61/vQJvSZgQnLzSYvnvqMpQXH84CmULkyGRMXjJaqwaCAQRynYtKT3f0GvcibZ
 Xbop5PDVuouHR2xwrlHm0HzYEQWs2zVZ4xLcGsrhrr+WibqUHyGE3OZO8ypPsBNHR8co
 9XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947344; x=1742552144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opiqrpnO7vMjzM2WONF0yYqPnTwjiMcMPD2r9uI5yS0=;
 b=QZ0+IycYpscJ8e855AvcGMMd/1n3wGAqHXo1PW/pbO2lnZ7QkTjpripiOafQpAsqbE
 dYyCgowxKmmJNjDRhySucxvfMAr9GRHNnx6DdjKc3e5fXFmhRWho7ugvio8814D5p/jr
 HObw+CMsb24Ius1+5+8Jz95MLNHa1Dmudqlnx62DXxS+AP69So/PZMdOf/Q632CKexfh
 rBP8Q5QdR+8kZJ6PxKDuf5ZULA+MMBIg+J2LQAhfimqRybq/DCsbpkOOVDyqDC0S0QzT
 ZeNYV/LX7bLYpsLCqY/H7hACBaTrho20ojDrcKg+lHbSdydOytV/3xT6LOSfbBOXiAgB
 QZxw==
X-Gm-Message-State: AOJu0Yxr+vnXEO3+GZ0ZoFqDLVvJU2xqwEtPzjMAD/2+B/JyWwADKZAX
 LaGgan9Oi8iteG+5QpQuiZQEtUJtoeCa5Fc2UZTjMZu+x9BYPhER3szR1tQqPyf8wrYEgdDsdwZ
 4kvBg0dhHCvI=
X-Gm-Gg: ASbGncsmQdw2cJx9xR8dlQowJ/VfHTOV0NDBhpR6TdXUh02NIyfJyVyk3PwoTxncrtc
 1vz2GaDz/0p5Yb3LAhQm9lgxQf3Tt4v4mmDSsp/oiclzP9vR89hES0SKRVnjuK166NZwExy/tot
 NendsLsbwBAL940ZpHXHfS4rHGuqQFMyl9hIU5uBPHRFEUrlmwR5dw9lnFfIknanl1qB2+O7pCH
 vaiOezlu/anTQeaxLPhBaM0izvVBJ3u8XnWHIL3c5Ic/1Ric7LTHiBW59KUAfo8qfiahFjEIJ7r
 ccnjKtMknQf0ZitLT3Ws6kgTryZyDRa5KHn3+tgwIWctsuGWvcJk
X-Google-Smtp-Source: AGHT+IGfIVYJwWUQpqbKf/odK458LQVX7lnZjKc1Fga4gkM1lUZtOz8nxpY9UvAOCZA10F2q7syM0A==
X-Received: by 2002:a05:6a20:9f0a:b0:1db:822f:36d8 with SMTP id
 adf61e73a8af0-1f5c279be7amr2446467637.3.1741947344106; 
 Fri, 14 Mar 2025 03:15:44 -0700 (PDT)
Received: from fedora.smartx.com ([103.85.74.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371169549fsm2698898b3a.131.2025.03.14.03.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:15:43 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, yuhua@smartx.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 0/3] vhost: fix the IO error after live migration
Date: Fri, 14 Mar 2025 06:15:31 -0400
Message-ID: <20250314101535.1059308-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250309090708.3928953-1-haoqian.he@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Currently, if the vhost-user backend crash, vhost device's set_status()
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

Haoqian He (3):
  virtio: add VM state change cb with return value
  vhost: return failure if stop virtqueue failed in vhost_dev_stop
  vhost-user: return failure if backend crash when live migration

 hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
 hw/block/virtio-blk.c                 |  2 +-
 hw/core/vm-change-state-handler.c     | 14 +++++++------
 hw/scsi/scsi-bus.c                    |  2 +-
 hw/scsi/vhost-scsi-common.c           | 13 ++++++------
 hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
 hw/vfio/migration.c                   |  2 +-
 hw/virtio/vhost.c                     | 27 ++++++++++++++-----------
 hw/virtio/virtio.c                    | 25 ++++++++++++++++-------
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 include/hw/virtio/vhost.h             |  8 +++++---
 include/hw/virtio/virtio.h            |  1 +
 include/system/runstate.h             | 11 +++++++---
 system/cpus.c                         |  4 ++--
 system/runstate.c                     | 25 ++++++++++++++++++-----
 15 files changed, 116 insertions(+), 69 deletions(-)

-- 
2.48.1


