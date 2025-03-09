Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295A0C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 09:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCdS-0004dI-M0; Sun, 09 Mar 2025 05:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trCd6-0004VY-5C
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:07:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trCd2-0002Ve-J7
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:07:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22349bb8605so59065095ad.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 01:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741511240; x=1742116040;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WXC7jHXrmI2PB7EBwXSVBnaIxiGgzOJU4pVaiRzMVdw=;
 b=J9GGcQ1HFxWY2ZLm76XQgw0ClLf9iQJqoZxPrtzxtKnAZmzpPLjOBYf5gA5kHKvqTb
 fO/VJpJ43h8vZiavB09W738CN+b5SOg5VXooziRgwUXjIShR6GbNiNZOFt0hydQ7vmgB
 i0fOnTDIgU83zpohWWwUD3M4vtNT11GloW6O7LKDg5oi1m7UeFcWxZBvdXji3XR21RGs
 +uS1fP+TmR3G5qcEjDsEtW8F92MCmxB7vXdLSZGptQpRPw/0OO9/bRVIF3yJwrqixiIM
 5sq/l1TEg9F+ikbWryt7W4gM1R/oLbo3PiKTI4YnmUt1aSbJn3RPo3zCmg3X8ZCKUXXg
 Y/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741511240; x=1742116040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WXC7jHXrmI2PB7EBwXSVBnaIxiGgzOJU4pVaiRzMVdw=;
 b=mT3+yEMzRktRVy7B/HzwXcUQxKqy4/htXL800v1zKJv/cFG4z8aFmiJJFgIEgFkUTj
 7v1NB2wPAKv4GpqkNzDokdcFZ/ig1CJCldYPdkC+hrLpMiuzIM/OUavGx48PhrknJcbI
 2K6iCW0tw9AjYDw+9lee75Ycy1bv5gR914sYlY4vuh0mbKk+ofjKh/M9cAbe0R4449kh
 cwxVhH6rMRmKJ0zgDhdf4JX/53xA6Vf82q6WIxUlPX5HzfsIkYWOxCdBDLFRWMS5Nstq
 0J2pfJtd3sBCqhpfXYsh7zq295vcfwkcL4henj0fHwL6AqAu7NNNL25gqM4AXflbl/Tc
 9R3g==
X-Gm-Message-State: AOJu0YwZtN2s12T1jvjZHM0N369lVjmJ3kkJkTAHs4x0EwNscW+TWx44
 0vvVYREX3TsvDSR3usE6vQ2Wx4PB8qad9KHw6Lc2DibfffnTRlEDgXlfnl2kgSIBFq3nEAhMgj3
 qQfpW0HEq
X-Gm-Gg: ASbGncs74MWyMX2Xu1yfPt/LKto+d/2TZmenUv+FEwWwspXx0AZQXsZaCWnutylyMxD
 t5jJksXMrCtVGJkflC8mPbzWMUaVyO2c4Feu5mw0brps4EB9aZ/PQ9q/FzPobpVlnKjFC49UWas
 pWCFpojRbdsIjMx74e84Kzf9n46aRBe6lIigWoRClDpsqaQSX2eQqw05+S4ToxACOVcTQ0HAxit
 PYnjAepqXe17xufNoGWoojfJv5MyKLoI+N5uP0WL7hOLrxL87sEvyiOHnZCi7KNhxnt6LQ+Aish
 3+rWZ4vw3s+mmErLMgk+NkEiigNf/Gg6u6aIbMwxY15gts8KUn+LOxrSug==
X-Google-Smtp-Source: AGHT+IFKPcEAvWmBEw+hpLViLLSiPKaD9/hqmzpNoBrWAOda9IKIiTdmHj2IyHB4L5PdWMBJqxeLkg==
X-Received: by 2002:a05:6a00:21d1:b0:736:34a2:8a20 with SMTP id
 d2e1a72fcca58-736aaae4d01mr17087456b3a.21.1741511240290; 
 Sun, 09 Mar 2025 01:07:20 -0800 (PST)
Received: from 9950x.taila029d.ts.net ([1.202.18.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b82f2663sm3435654b3a.130.2025.03.09.01.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 01:07:19 -0800 (PST)
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
Subject: [PATCH 0/3] vhost: fix the IO error after live migration
Date: Sun,  9 Mar 2025 17:07:04 +0800
Message-ID: <20250309090708.3928953-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x631.google.com
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
Currently, if the vhost-user backend crash, vhost device's set_status()
would not return failure, live migration won't perceive the disconnection
with the backend. After the live migration is successful, the stale inflight
IO would be submitted to the migration target host, which may leading to
the IO error.

The following patch series fixes the issue by making the live migration
aware of the lost of connection with the vhost-user backend and aborting
the live migration.

Haoqian He (3):
  virtio: add VM state change cb with return value
  vhost: return failure if stop virtqueue failed in vhost_dev_stop
  vhost-user: return failure if backend crash when live migration

 hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
 hw/block/virtio-blk.c                 |  2 +-
 hw/core/vm-change-state-handler.c     | 14 +++++++------
 hw/scsi/scsi-bus.c                    |  2 +-
 hw/scsi/vhost-scsi-common.c           | 11 +++++-----
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
 15 files changed, 115 insertions(+), 68 deletions(-)

-- 
2.48.1


