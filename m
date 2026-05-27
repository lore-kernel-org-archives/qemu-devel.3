Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01530CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGlu-0000IL-TN; Wed, 27 May 2026 12:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSGls-0000Az-5Y
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:06:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wSGlq-0000Td-GI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:06:15 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-36b51e021baso578780a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779897970; x=1780502770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YwSQGpMS7TnjacMtNTAjbhseUfxxA5Zhhx/keg3j6+E=;
 b=kgsiV3fwlxvihLlRvcB8dngBTOZ1GjL/AbUqUqflTtRlHtGWPBm+F0v8mxb0G1OEyx
 tXMGEsCypdYYPX5Q961E+W4KAjPqYM+o1Hse60y1eqYR40lPvSjJdgQbZEGhu9KxMcRK
 oPTxEGqmfmliMF+H+kqfs7L7M+SkvmYFZdERwm+D4KB/R3I96hdJ/UxjX2L6wjBrig3w
 NW+Ybc559JtauPnDEcjWMQLywzTF5RhlFJ/YxrZM9VQrhtFyvSCYr7ogbdIvtpauT8As
 OsA6v24fdCl9vRPgwx/G4imkqb9PEKVuHSJil0p5DoXYmYLLznK23UErSA4IljSdMC77
 AKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779897970; x=1780502770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwSQGpMS7TnjacMtNTAjbhseUfxxA5Zhhx/keg3j6+E=;
 b=JqRCmYO24DQcaOdVW70/MJl6VWHUZjtqwzZNm7lF3BBhVM5I8m6Eu3xS1NqhYcLdT+
 JlpTznX/41iFwvMC9vtz8xyPZM9/Wi4YUb0XZhs25xeR4ZX3422KTtoPiJm8+VqDkMXz
 bmkQ1fo567WFRQucmKxi+dnhAyykPRRyeFMLSRq6HcCWNdOgm6tgDxRxLMX9E55tgwUy
 IdWwiPbsnVyO+OrxEbR+keUySobEX7nFRHenWL9SmvdtcxEPlcuaFUGiEMKXm9qy6h/a
 RTZiFF1AWg86JsTFFA7L8KzHyN6tcHFiBCeW/xGjo5hE65nIaPz/iOaYGGlixPvpKQ/Q
 S8vQ==
X-Gm-Message-State: AOJu0Yz9KlYR1hMM9aZN1Eo7HQqQIsJ8sZr9+X7y2+QxZNm0O3KlB8/L
 5N3GGindEp4qzOh7l4m3W0C0bFZTZVvIBIO41KzatHfHef3Ro2vFVqU8t3kF38IokJSWYA==
X-Gm-Gg: Acq92OFC7AplgCATOw1nZ8sl/JEBFvDb8TD9RQD3zjT6X/v3cuBwHFN2GS1eGh6UkU+
 Pc75Nn5KdGKA9JPmQYgzls8T881d8Icpe5RXtCtxlb/AmXQTHkTk0p+3UAaetmVhXh3I0RL6G4E
 TSYGP5PVIcWnhx9FuOZR2dZh0fHkZjwdH8cOiC8/oPiaPz9aYP/NpkbgP2BKWFgRFG/dj1XNWLZ
 3ItwrYDGsbHtyXWANTRHMnSao+gV1VxqUOPin8psWqgv1/cCjRdrBGsJoRhDcHQeMXeWhq7IMgD
 sWIWRI7GcLFztZchOQEWBITcfkeInptAJ0A64JewtghZHHyEUeP/lEsqJCCMJvR9G8vcvwexqhS
 tmREHLdtcqaSrxAS3aa16d1bIoBLic+xyHveOL0tGHbR8ZKiGJJVB+Ks2v2j0wqFxwuoVNXGnnj
 RRaAn5GyKwQLPKCuXQffYgTywS0g==
X-Received: by 2002:a17:90a:d008:b0:36b:203d:9755 with SMTP id
 98e67ed59e1d1-36b203d99c6mr5191518a91.19.1779897969502; 
 Wed, 27 May 2026 09:06:09 -0700 (PDT)
Received: from gmail.com ([188.253.121.102]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a723cfb57sm20773612a91.15.2026.05.27.09.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:06:08 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-block@nongnu.org, Jia Jia <physicalmtea@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] virtio-blk: fix short scsi inhdr host OOB write
Date: Thu, 28 May 2026 00:03:28 +0800
Message-Id: <20260527160328.315585-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=physicalmtea@gmail.com; helo=mail-pj1-x1029.google.com
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

virtio_blk_handle_scsi() only validates the input/output descriptor
counts and then unconditionally treats the second-to-last input
descriptor as a struct virtio_scsi_inhdr.

If that descriptor is shorter than struct virtio_scsi_inhdr, the host
still performs a 4-byte virtio_stl_p() store while writing scsi->errors.

This is reproducible as a host-side heap-buffer-overflow under ASAN:

  ==4022698==ERROR: AddressSanitizer: heap-buffer-overflow on address
  0x504000023570 at pc 0x5e4be9c09800 bp 0x7ffebf4d7510 sp 0x7ffebf4d7500
  WRITE of size 4 at 0x504000023570 thread T0
      #0 0x5e4be9c097ff in stl_he_p include/qemu/bswap.h:284
      #1 0x5e4be9c09c4d in stl_le_p include/qemu/bswap.h:331
      #2 0x5e4be9c0a48b in virtio_stl_p include/hw/virtio/virtio-access.h:38
      #3 0x5e4be9c0c201 in virtio_blk_handle_scsi ../hw/block/virtio-blk.c:207
      #4 0x5e4be9c1578b in virtio_blk_handle_request ../hw/block/virtio-blk.c:926
      #5 0x5e4be9c160e3 in virtio_blk_handle_vq ../hw/block/virtio-blk.c:1025
      #6 0x5e4be9c16529 in virtio_blk_handle_output ../hw/block/virtio-blk.c:1058
      #7 0x5e4bea713ad9 in virtio_queue_notify_vq ../hw/virtio/virtio.c:2507
      #8 0x5e4bea724bfc in virtio_queue_host_notifier_read ../hw/virtio/virtio.c:3981

The same run shows the short descriptor being mapped through the
bounce-buffer path:

  allocated by thread T0 here:
      #0 0x736faf8b4a57 in __interceptor_calloc
      #1 0x736faf1a5c50 in g_malloc0
      #2 0x5e4bea925458 in address_space_map ../system/physmem.c:3746
      #3 0x5e4bea6f7633 in dma_memory_map include/system/dma.h:212
      #4 0x5e4bea70610a in virtqueue_map_desc ../hw/virtio/virtio.c:1637
      #5 0x5e4bea70824e in virtqueue_split_pop ../hw/virtio/virtio.c:1817
      #6 0x5e4bea70c9a8 in virtqueue_pop ../hw/virtio/virtio.c:2039
      #7 0x5e4be9c0be03 in virtio_blk_get_request ../hw/block/virtio-blk.c:172

Reject requests whose second-to-last input descriptor is too short to
hold struct virtio_scsi_inhdr.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 hw/block/virtio-blk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2b..418e0dd9c6 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -197,6 +197,12 @@ static void virtio_blk_handle_scsi(VirtIOBlockReq *req)
         goto fail;
     }
 
+    if (elem->in_sg[elem->in_num - 2].iov_len <
+        sizeof(struct virtio_scsi_inhdr)) {
+        status = VIRTIO_BLK_S_IOERR;
+        goto fail;
+    }
+
     /*
      * The scsi inhdr is placed in the second-to-last input segment, just
      * before the regular inhdr.
-- 
2.34.1

