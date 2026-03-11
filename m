Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02E112583F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L6Y-00069w-Ab; Wed, 11 Mar 2026 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L5n-0004y0-5T; Wed, 11 Mar 2026 11:03:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L5l-00045i-Lf; Wed, 11 Mar 2026 11:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241304; bh=c+gqTMqLUfRdgr1Jk8Ff5A4mQWOYOUh3Ga7CxaI3CI8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TVJcSPBxKHNeir1pX3tJwqTU34mdOIo0Xps7s8YAZRrK4VRVmFWTXfhLC9HnmNUwF
 wNFs2Y6kX0VY2SU0ql6jv8Kx0PiH9xGd9kUPJmaYHUYaySythzZaO/733HpFyvKRnl
 R082fpVopW2c8b1is9JBKBMonolRE94E4DXUDe5BSYS8brHXfQsIhQZGesHyCbhZWJ
 hQHL4QnHae/D7i/HnJ2BJYhuxMRbXWGeCq07m9LIhwPOKhj6E2J7gFGVvnqq4gHGJM
 IPPmgoMp7DWZ619gHNT8Buv2LTRH9Z0Xb43M/6H97DJhC9XXZJGSpjuVMtB7CmHoTH
 bxcFHWH6GBH2Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7046C191E4E;
 Wed, 11 Mar 2026 18:01:44 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5C3FD37C2A0;
 Wed, 11 Mar 2026 18:02:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 DARKNAVY <vr@darknavy.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 16/44] virtio-snd: fix max_size bounds check in input
 cb
Date: Wed, 11 Mar 2026 18:01:48 +0300
Message-ID: <20260311150221.1084186-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

In 98e77e3d we calculated the max size and checked that each buffer is smaller than it.

We neglected to subtract the size of the virtio_snd_pcm_status header
from the max size, and max_size was thus larger than the correct value,
leading to potential OOB writes.

If the buffer cannot fit the header or can fit only the header, return
the buffer immediately.

Cc: qemu-stable@nongnu.org
Fixes: 98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3 ("virtio-snd: add max size bounds check in input cb")
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-4-207c4f7200a2@linaro.org>
(cherry picked from commit bcb53328aa70023f1405fade4e253e7f77567261)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 520fc7240c..4ea2d4db95 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1255,6 +1255,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
             }
 
             max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
+            if (max_size <= sizeof(virtio_snd_pcm_status)) {
+                return_rx_buffer(stream, buffer);
+                continue;
+            }
+            max_size -= sizeof(virtio_snd_pcm_status);
+
             for (;;) {
                 if (buffer->size >= max_size) {
                     return_rx_buffer(stream, buffer);
-- 
2.47.3


