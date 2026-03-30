Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EDD1061B1B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7IO7-00065X-W6; Mon, 30 Mar 2026 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7IO1-000658-9Q
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:34:58 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7INz-00016q-Tc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:34:57 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so5608882e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774899294; x=1775504094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bftrVlRCkBO3MiDQm70utbwn7FaBGkwSQdi8+5tsnqU=;
 b=R9YgtUjtELhjvEqJz/s4c5TN1bGSORKWrh4j0BY3Os7ISpZULvQla+8U7V87Rw2lKS
 utvT2gBHlATBMLM6nosZCofcfDsnXeLEhC2vD+jHoVtEkGsY6KBVM+4GW+Nw82ATy3MJ
 5VKDP/CIqG7LYexz0CIpO0ourN9uTU2E1bhhOTPV8GVJTor6FOPbEMnWg6w6bVOhTphz
 z0v944J6PiFvcO+i5bH6BvB6aOVdhDHpcrTlNIikvHeOvdXmvXOuh4bhUWUFxuFzRREm
 amcGdc1xS4qLXEq/BO+0vXf16nONgdelgXpPdeu6aKyr/4J1PsFpo6Nor6Zi616HruGH
 lE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774899294; x=1775504094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bftrVlRCkBO3MiDQm70utbwn7FaBGkwSQdi8+5tsnqU=;
 b=XZBDG27SCwrW173tgH4mvazoaDWdOsU2+LUhat2u6Frzfhik2Purq8k3C7a83fyEFy
 u6sFQ/CQrWmWOaEliEGLDfR86ePIt3aWxxTeVHbwjL5ikCbR6BH8U8AKOku6VnnqLbZw
 RINiXfv3NaDP2H90XDnhPSdOC11g8pn1V5wAubKQbyd98Q/jWwF3yw0FefPqNc4nYFCR
 VYcZ+hGtpP8OvUBW9ERE3NeO46MyL0qYpp0gPoK6q3ba3PC9njyWJQXJgMnzl6amF9KO
 ds/mTdaUQBlPqh2zqgN35D9QffDMWZRgU68fOHXz8dGOK3OuiIwiqf/QYpJveMG0xIgZ
 R2dQ==
X-Gm-Message-State: AOJu0YyUzA3ppcpyng+ALI7vOsluyEke3XMHR8ecWEVYWROZPB7wLVvq
 Ya0DbSQ+nMY+QSg3odHTesp+x29FApEtWxqI6r/mLbbO7nCbQTky9Yo3sF03ZBf+
X-Gm-Gg: ATEYQzwUNx6Q1BderF/bS8MUmcG0hK/AuK+tjbGWzkPQmLljSWBcd5zCnLOFJ7Zz+Qr
 +jvGLqID4jGYsj2cvEmUU8bB2McnshjMRejCpm1WTv74NeFyVmwoY3ZtT0PBM9H+uVPj1ArEGUm
 RQjQJzKxQ22j4RaMLOtDuJeH1V3MYlz0yEM9G7Cz+KgJNwFNP+Avv13N8gIiW2CkLzbziOWEBoB
 iz2kk9ekUPTiyq4yAKzvdeWy2+VcqgCs7RWivmFKUPI4F5T3jg+09Iz0OPahnQcDuRrJBbSQ/+2
 FWxaU3dzgyb5hir7UEwYWn71sXZtTrmRoldZDpcy0k5tUM/AVFWnzeG9cL0H3fIxUi3Hsyuu1VO
 fwneOhsJkT2o2MqWmbVH3HZV8Tc9h9Mlwaif4YcNb8YucK3xgSrfEElCACTeLtMnqLUSkcF5iAR
 NtY4zD5/wc3WuLMNKqtYlLO6hweo12NynSiPisYbyt3Ax9oQ==
X-Received: by 2002:a05:6512:6c8:b0:5a2:5b88:a8a3 with SMTP id
 2adb3069b0e04-5a2ab92854fmr5097955e87.31.1774899293462; 
 Mon, 30 Mar 2026 12:34:53 -0700 (PDT)
Received: from localhost.localdomain ([89.21.130.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f4339sm1886198e87.12.2026.03.30.12.34.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Mar 2026 12:34:52 -0700 (PDT)
From: Max Makarov <maxpain177@gmail.com>
X-Google-Original-From: Max Makarov <maxpain@linux.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Max Makarov <maxpain@linux.com>
Subject: [PATCH v2] vhost-user-blk-server: fix opt_io_size=1 causing severe
 Windows I/O degradation
Date: Mon, 30 Mar 2026 22:34:51 +0300
Message-ID: <20260330193451.76037-1-maxpain@linux.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=maxpain177@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The QSD vhost-user-blk export sets opt_io_size=1 and min_io_size=1 in
the virtio config. These values are reported to the guest through the
VPD Block Limits page as OptimalTransferLength=1 block (512 bytes)
and OptimalTransferLengthGranularity=1 block.

Windows respects these hints and splits all I/O into ~512-byte
requests, causing ~100x sequential throughput degradation (150 MB/s
instead of 15+ GB/s). Linux is unaffected as its block layer ignores
these values.

Set both to 0 which means "not reported" per the SCSI Block Limits
VPD spec, allowing Windows to use its own optimal I/O size defaults.

Signed-off-by: Max Makarov <maxpain@linux.com>
---
v2: Rebased on clean master (v1 depended on a separate size_max patch).
    Removed unrelated Buglink.
 block/export/vhost-user-blk-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index e89422b..67912a3 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -242,8 +242,8 @@ vu_blk_initialize_config(BlockDriverState *bs,
     config->blk_size = cpu_to_le32(blk_size);
     config->size_max = cpu_to_le32(0);
     config->seg_max = cpu_to_le32(128 - 2);
-    config->min_io_size = cpu_to_le16(1);
-    config->opt_io_size = cpu_to_le32(1);
+    config->min_io_size = cpu_to_le16(0);
+    config->opt_io_size = cpu_to_le32(0);
     config->num_queues = cpu_to_le16(num_queues);
     config->max_discard_sectors =
         cpu_to_le32(VIRTIO_BLK_MAX_DISCARD_SECTORS);
-- 
2.53.0


