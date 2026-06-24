Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54375CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGbA-0002v1-Tm; Wed, 24 Jun 2026 01:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGb0-0001rw-HR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:22 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGav-0007II-3e
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782280559; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=44C50/0Se7vXP5Nhn2G2jPr/8fZh0gQgqrmhK8ayb98=;
 b=qK221S3qRM3KwO56Cg3FpAPz2z+f41CHYUxg4BwDYdSMKX8ot65WutGa3rzx47IprSJlzrcyShRXv2UqdPDabmqyV/MQgI/m2UHQ5VRX3F+TOOKU4PC0ZwS8Bv0qGfXoiDA0cHrmtyeRDI9LlouMAoBhxIKhi5vPKzb6Qc4OF4M=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R961e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X5X45.s_1782280557; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X5X45.s_1782280557 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 24 Jun 2026 13:55:58 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: alex.bennee@linaro.org
Cc: mst@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
Subject: [PATCH 0/3] virtio-gpu: security, logging and UB fixes
Date: Wed, 24 Jun 2026 13:55:54 +0800
Message-ID: <cover.1782270919.git.guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

Three small fixes for virtio-gpu, each independent:

1. Add resource validation to CTX_ATTACH/DETACH_RESOURCE handlers,
   resolving the long-standing "TODO add security" comments.

2. Replace three fprintf(stderr) calls with qemu_log_mask(LOG_GUEST_ERROR)
   and trace events, consistent with the rest of the virtio-gpu code.

3. Use unsigned shift (1U <<) for scanout_bitmask operations to avoid
   undefined behavior when the shift count could theoretically reach 31.

Bin Guo (3):
  virtio-gpu-virgl: validate resource existence on ctx attach/detach
  virtio-gpu-virgl: replace fprintf(stderr) with qemu_log_mask and trace
    events
  virtio-gpu: use unsigned shift for scanout bitmask operations

 hw/display/trace-events       |  2 ++
 hw/display/virtio-gpu-virgl.c | 33 +++++++++++++++++++++++----------
 hw/display/virtio-gpu.c       | 12 ++++++------
 3 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.50.1 (Apple Git-155)


