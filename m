Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECEFCDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4cs-0006ZC-GW; Fri, 26 Jun 2026 07:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wd4cl-0006Y4-3H
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:21:32 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wd4ci-0007hC-Pg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:21:30 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 8B1D4240104
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 13:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1782472886; bh=T9tp99X2N0e7PCp0KnMjtCfLg4AjUB+MDRMgrXgoTQQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=JUcBohtmlVI3nkLJzw3M8MEZhsZW/Ru1oaVopxEkReIS+SCL0aXNGxL8lWqv0vleb
 TE1egE38UrN8qn8NTHQFsipGsWGEMF82tsb/fhoTvLQUMxW34AYlGdVnoMMvySXl9d
 8QP0+cQ7ogeo+CcbjYygERmDR7qcbDZiXeSCyaY4uxU+0KdiaYxp7Kc9QrynF82tw/
 wf9oxOnvwcgpkEJdyRXRD/GWXZaxY4ecw56brQ0eHiuuYFQCZSvaQbTCCu+ZFnk+Ku
 Mn5r7d6RF4ixyj3VNUzMSAcI8wIELkOi7WF0YiFKckqxbkV0vsJ88sL4R9WrDD3p/o
 L1Ak4trmgh34A==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gmtXh6YkWz6tsf;
 Fri, 26 Jun 2026 13:21:24 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 0/2] hw/nvme: add monitor commands for inspecting state
Date: Fri, 26 Jun 2026 11:21:26 +0000
Message-ID: <20260626112116.7621-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add two HMP commands for inspecting emulated NVMe controllers from
the QEMU monitor without attaching gdb to the QEMU process:

  - 'info nvme'        - per-controller summary (PCI, identify
                         fields, CC/CSTS/AQA, queue counts)
  - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
                         (size, head/tail, PRP1, doorbell offset,
                         phase tag)

Useful for verifying queue setup, doorbell rings, AERs held in the
admin SQ and similar driver/controller interaction details from a
running QEMU monitor.

Changes in v3:
  - Gate the new x-query-nvme[-queues] commands and their 'info'
    counterparts behind CONFIG_NVME_PCI.  They were registered
    unconditionally while the implementations live in hw/nvme/, so
    targets built without NVMe (e.g. riscv64-softmmu) failed to link
    with an undefined reference to qmp_x_query_nvme.
  - hw/nvme/meson.build: keep the source file list alphabetically
    sorted (Markus).

Changes in v2:
  - hw/nvme/meson.build: add the missing trailing newline (Markus).
  - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
    Armbruster on both patches.

v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowicki@posteo.net/
v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowicki@posteo.net/

Mateusz Nowicki (2):
  hw/nvme: add 'info nvme' HMP command
  hw/nvme: add 'info nvme-queues' HMP command

 hmp-commands-info.hx |  32 ++++++++++
 hw/nvme/meson.build  |   2 +-
 hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json    |  36 +++++++++++
 4 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/monitor.c

-- 
2.53.0


