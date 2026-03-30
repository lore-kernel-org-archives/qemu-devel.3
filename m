Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4581061B1D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7IGS-0003at-QT; Mon, 30 Mar 2026 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7IGR-0003aG-6U
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:27:07 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7IGP-0008GF-JV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 15:27:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a12cd0bcd8so3508405e87.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774898823; x=1775503623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O84wtaC2zyHfbP85d7pv0VHeETj9qzSLnqvEcLsal64=;
 b=FMg2kczLvg75pJZ4+kaOUqfhYBmhKe4dPW9HU90bnCZi/jxpEG73+tl4sOURiHEFHB
 bgg6PnuXUNQosmnjDpyhK4+hXk4PwnkLdGg2UERmT1E/gVTq3dJ1sQ1oXUzc08tUa77V
 hwh+VuKkSHQh3z8BnnstpfG7xGn/bluE8iOT5d6RpO+QF/NLQtSVwJAJEZqpzbjDzL1h
 Vbor5rCMUE5lqm468HzfHH3y9OEE9m2VSuELSa5bxPW1s3nsoMtmCOvr5IsyMtRRvzLY
 SvmhcnIVvBUVBqqZhL72KVPMbOP0EKI2QaQs2UhLaazpn43zzyi3MevErTmY9IT1jGbb
 WZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774898823; x=1775503623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O84wtaC2zyHfbP85d7pv0VHeETj9qzSLnqvEcLsal64=;
 b=gFB6YEeF8ETo6quZ0cHSBdsQ73OVUKh3aY7E/QkWsXz7rE7/bjgTSY1h0Cl/3A4Pbx
 KAdOJ5z1qHYXu6CPDgJtcca4jMmswoiOG32BaWa4D9pWo0Rqwtnpx4Cz9ZE65TcQwB6z
 fq6wCxicp+ZyRKcUxbI2pcV8tbtUZWP+AysT/4wgKfYbMv3yxttEypspFsWpYPKCF6m/
 44d+i+jEur2GeRVIUcoOKpK+hA6c+HEjvcDzw+Rir09FA7D1wiMwDcjKJZfVT6DkfiYT
 QKmlaFc6StfI0NaujfD/uUzWjIfCehgxT3Gmcdgwj2GsK85g4zj0XJMJFYlfnxR0NpIY
 in9A==
X-Gm-Message-State: AOJu0YyczCzeGT3tAEMTfKe12YWLxT5Iz9X1fbGgcF4fkJ0nHYTfYVz+
 rvWjAMQhFx+hJ0WhCMJJG8ZcAbztLny7VXl96ngOrf1VrbLj3kbu33kpHiuIqF5J
X-Gm-Gg: ATEYQzzQ4t8aIOAkFz738rcr9vkFgE/10mcBMZ6Y5u6/UuZutW32YQ0QIC92zbn9dwI
 KUMMseZYJEEiz3MPYoVmio5+TZKwswP73lwPqg3GDkPftL/oTgXWrega7x7uBunZa7z0jJwCDDL
 zXjE8cynsCIUpnDFpZ2EeXGOc4s5sAXAyc7OqIVQz7U3wxIZ/veDkvdotTtIpQCMdJE1aGnCV16
 BNR/fj5mpC3vkusjpnp9G1lO8HvckunLWaztqkqoQEi2Mt7DnEz4hfeou7uGMztF4zNlg3hHdPa
 nvkmC93jD0Fq6DftRRDbhPEDUJ88YNU2YM/ukpvGWgUoNHpyAN6g+LtiHD1T/3vexWksdysHvZ0
 eNT/JLw+gV6RwdPFzRYS9kD4eOMXpo7b+JlfcOv1jFF+WbD9H4HAAsr1GB5NBmDV5R3hEwHvuty
 fn/3I+civQtCQhUzFL8WmifhIUdLV5xnrjqh+v6B/kkG7m1Q==
X-Received: by 2002:a05:6512:33c7:b0:5a2:b2e1:39fa with SMTP id
 2adb3069b0e04-5a2b2e13a66mr2650137e87.12.1774898822793; 
 Mon, 30 Mar 2026 12:27:02 -0700 (PDT)
Received: from localhost.localdomain ([89.21.130.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1455e14sm1846904e87.64.2026.03.30.12.27.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Mar 2026 12:27:02 -0700 (PDT)
From: Max Makarov <maxpain177@gmail.com>
X-Google-Original-From: Max Makarov <maxpain@linux.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Max Makarov <maxpain@linux.com>
Subject: [PATCH] vhost-user-blk-server: fix opt_io_size=1 causing severe
 Windows I/O degradation
Date: Mon, 30 Mar 2026 22:27:01 +0300
Message-ID: <20260330192701.75780-1-maxpain@linux.com>
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

Buglink: https://github.com/spdk/spdk/issues/3199
Signed-off-by: Max Makarov <maxpain@linux.com>
---
 block/export/vhost-user-blk-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 827502d..e421f72 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -242,8 +242,8 @@ vu_blk_initialize_config(BlockDriverState *bs,
     config->blk_size = cpu_to_le32(blk_size);
     config->size_max = cpu_to_le32(4096);
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


