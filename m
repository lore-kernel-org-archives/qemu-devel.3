Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DEBCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 10:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQN8N-0002Wu-TO; Fri, 22 May 2026 06:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wQN86-0002UI-W8
 for qemu-devel@nongnu.org; Fri, 22 May 2026 06:29:24 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wQN84-0004q7-Hh
 for qemu-devel@nongnu.org; Fri, 22 May 2026 06:29:22 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 84456240101
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1779445754; bh=8rgLVyMWiF6vYMxHwKHEH9146asL+RQWByJkVT8SeZ0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=GvaG6gSNIQmNf+3KjJjD+IEiZZC7O6iQedtpELZNHFH6GhhejyLkSpZzKe6NeM4w+
 ebEifBYSGtIU1x7l+PHrqeOr6K9Flv88S7la8CceJ4p0mv+IvImtwpZbHZ92ZhvGT4
 oIVsta3E4P6OeOnEr06MoLKkBZ9lgOfXNZ6bWOYnrpZOsmibPYnvSsZj9wC6bKJUiP
 l2u9/hUdYdnoryvVLrIrBosn7ouBXFRgAxxUmzCoo6CjtgG+C6OSaZEKOxaFXtadrU
 gW3sUE8GO5qfkPeFrP+n7sdv6xpBuQLyHnF/c/HQw1CCphM4W1uiRXIjqZTKf4qrn9
 NfmF5Af5Fch4g==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gMM2b3Rdxz9rxS;
 Fri, 22 May 2026 12:29:11 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v3 0/2] hw/nvme: HMP commands for inspecting emulated
 controllers
Date: Fri, 22 May 2026 10:29:13 +0000
Message-ID: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
  - Iterate on n->conf_ioqpairs instead of n->params.max_ioqpairs so
    the listing reflects what the guest driver actually sees,
    including SR-IOV VFs where conf_ioqpairs is the negotiated subset
    (not max).  Same fix in both patches.  (Klaus)

Changes in v2:
  - hw/nvme/meson.build: add the missing trailing newline (Markus).
  - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
    Armbruster on both patches.

v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowicki@posteo.net/
v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowicki@posteo.net/

Mateusz Nowicki (2):
  hw/nvme: add 'info nvme' HMP command
  hw/nvme: add 'info nvme-queues' HMP command

 hmp-commands-info.hx |  28 +++++++++
 hw/nvme/meson.build  |   2 +-
 hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json    |  34 +++++++++++
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/monitor.c

-- 
2.53.0


