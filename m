Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7814BC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8f4-0001sP-ET; Wed, 12 Aug 2026 09:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ef-0000wA-Fh; Wed, 12 Aug 2026 09:06:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ec-0004xd-CY; Wed, 12 Aug 2026 09:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=YLJwKxSB3vXemu0yIF4FzB2GoP6wgCrhgKepy0hx3io=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=frvspU3XUxsdnupEuSengc8qDJOYcRh7ipclToFTxNwVwNnelwmXphpnhiVUMdC0R
 awnjLN16rLCmO0vCQHzALsGGu5lMrzIwUkFvVgNOknobdkVzG71HQnOa+c3imkjPEB
 EZ/Taeq4c/0jtS3CqwvnH/98JB2AHd3cvjEsH5wMOpOi1edXDTbIiTu08caj+55t9c
 bb5FjwT7clIQolakvjZvluTQ3tBpL70bgVfiFvmXFrBcEMTjml9PCog/SwaFhQzA57
 lIH+muZZJ4QrHlZLsljMakSXN+JTG6C/Ucxa86SZRYEAz2rqtwmQ741FsKa2EahSae
 ClDGFwXx4T+Bg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA6231CA4A0;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E0D19409B83;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 21D792F8D6; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 033/102] hw/display/virtio-gpu: Initialize blob
 mapping for ATTACH_BACKING
Date: Wed, 12 Aug 2026 16:01:08 +0300
Message-ID: <20260812130233.621965-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

It is necessary for blob cursor and scanout.

Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-backing-v1-1-5b584bf7df5a@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 4ae1c5c7d6f33d1e9c030ec4d24ab272609188cc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 598ee4026c1..c34a09e82b1 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -988,6 +988,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
+
+    if (!res->image) {
+        virtio_gpu_init_udmabuf(res);
+    }
 }
 
 static void
-- 
2.47.3


