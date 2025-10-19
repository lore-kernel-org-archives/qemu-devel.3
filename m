Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94D3CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZD-0007TJ-3R; Sun, 19 Oct 2025 17:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZ8-0007SQ-2f
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaZ0-000220-N7
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63befe5f379so4857703a12.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907817; x=1761512617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM6QgAOG34zDGb9jZI8DkkbGa1KuVCoA2kRHxsUOX8Q=;
 b=SZv5Vr0iMObu4BhFpJxKBcIKHvlnaHn6agsoUIRZ7N4nhYHrvWjVw58B8b52CghCAF
 SxwnHGJKygA1WZ9cumUg7PygRsypdBar8cVLaFAFWLiOiz7ik5mfj8vMcUx3aYSs8q0j
 YUEMOzjvcDmu7spZWJpscvOhkh1bdWcmQjnr3sSY9x0gGDZfy/b45olGS7IgwvopzjYs
 o8CDpW10IMnh4D8KlK17Vyv2r/hQUlkFVqYWaMnF4rKmxEyeUPcLW33N/Md5KE4djuRx
 HM4uBHbdoGsLJW97bv3LxslYx/LLGw9yar2wLZmsx4xsG1uAOC8OqAue9RotQQ6AClw7
 e/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907817; x=1761512617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BM6QgAOG34zDGb9jZI8DkkbGa1KuVCoA2kRHxsUOX8Q=;
 b=vUyZI9qb44/PXwxSu6uWEMnOmgxhmMMzi7kbWo8CNMSNouD4eHfZOw9ZXR/FocyhPX
 V05XJ9HoGYTpT6KqkDzXVhhwchbP6cZg04Q2pTFM4E7O2jEswMx9HhiSrvS9e5apa0pz
 I62kk14iscsan4tMADEVWQ3BdtDhR6CTlHQbcmqGAh6XklziWaD8J0uBFc/PV8vlM4Tt
 K+Nhq6A/gDc5nEl08fe9GXrCRK25hlfG+bOR7gFSWY/zzPV3LIyKHDaOp83rBEAfQlXk
 he3r74SMX+SukKRUSMgB0NM0PQ+feWWYHhBi2dUtMRBssPUzv1NmrkwlzixKk7nQkY6m
 RFEw==
X-Gm-Message-State: AOJu0YyGU+TbOoSLyk6IcbT6g7s7gJV1SJSiLPGsSw7eb+d/BRATaC52
 v3ZEawr+JMM3AZoXk4FWgRkJODUBU/EfXwKuHkuGRZkvppwbFQedr11r58rpb01Y
X-Gm-Gg: ASbGnctb5EGpTIm2mu2b5fzZfVkFGS52i9TP0NKwhb3U41Oh0+IP3hKmUuclT2qKtCB
 4vVDXNGOYrBGTd5JgmsTGFakHwgUqrHrIQ0seCdvDtahpfsyanqZB8jUYEs138u/QP4y1G683Hf
 MSIc8OhnQtD/mx3mqKKL8bPkfVUaBoPW94cSk6ru82bcbZkZeu8NNHPSdYZFPmMo+cFXDJDrFvv
 ozwweL5KOT2OXViegZSmjkwEsZEr7//o4DgIQjfqjTZ7vhKB9NjD0JFYxfHRtN08qorhFrBx4gC
 4cqBR4SSMHu4fQvXvYus0TGm4mZIhLGi1giAFOIcHLGlEo+mfcBUkOlQCPcf7MV88mtl08ANQQP
 FCX+dd4krGksss0Bfw+ngbtbO6DcqKZhnekTZWvpAa6lId9QAnwt6hMqx9b6xN8c+1cUl5n+Leq
 0m3CzS83yedZpt3Lf9VRizCoYMjZY+g3rjmFKMdo8Y6tY90guA3S7j2815Gw==
X-Google-Smtp-Source: AGHT+IHfMh7JlGToGTRe8mHgwHLoF57dHW5JvMJP8/YOMdu/h8U6uYCeh50ZViHOCSNzKzge6vlIQg==
X-Received: by 2002:aa7:df90:0:b0:631:bb4e:111a with SMTP id
 4fb4d7f45d1cf-63c1f6dbea3mr8083588a12.34.1760907816588; 
 Sun, 19 Oct 2025 14:03:36 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 06/10] hw/ide/ide-internal: Move dma_buf_commit() into ide
 "namespace"
Date: Sun, 19 Oct 2025 23:02:59 +0200
Message-ID: <20251019210303.104718-7-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The identifier suggests that it is a generic DMA function while it is tied
to IDE. Fix this by adding an "ide_" prefix.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ide/ide-internal.h |  2 +-
 hw/ide/ahci.c         |  8 ++++----
 hw/ide/core.c         | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 0d64805da2..281d07c9d5 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -398,7 +398,7 @@ int64_t ide_get_sector(IDEState *s);
 void ide_set_sector(IDEState *s, int64_t sector_num);
 
 void ide_start_dma(IDEState *s, BlockCompletionFunc *cb);
-void dma_buf_commit(IDEState *s, uint32_t tx_bytes);
+void ide_dma_buf_commit(IDEState *s, uint32_t tx_bytes);
 void ide_dma_error(IDEState *s);
 void ide_abort_command(IDEState *s);
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1303c21cb7..14bc66fb7f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1417,7 +1417,7 @@ static void ahci_pio_transfer(const IDEDMA *dma)
     }
 
     /* Update number of transferred bytes, destroy sglist */
-    dma_buf_commit(s, size);
+    ide_dma_buf_commit(s, size);
 
 out:
     /* declare that we processed everything */
@@ -1482,8 +1482,8 @@ static int32_t ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit)
 
 /**
  * Updates the command header with a bytes-read value.
- * Called via dma_buf_commit, for both DMA and PIO paths.
- * sglist destruction is handled within dma_buf_commit.
+ * Called via ide_dma_buf_commit, for both DMA and PIO paths.
+ * sglist destruction is handled within ide_dma_buf_commit.
  */
 static void ahci_commit_buf(const IDEDMA *dma, uint32_t tx_bytes)
 {
@@ -1511,7 +1511,7 @@ static int ahci_dma_rw_buf(const IDEDMA *dma, bool is_write)
     }
 
     /* free sglist, update byte count */
-    dma_buf_commit(s, l);
+    ide_dma_buf_commit(s, l);
     s->io_buffer_index += l;
 
     trace_ahci_dma_rw_buf(ad->hba, ad->port_no, l);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index b14983ec54..8c380abf7c 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -827,7 +827,7 @@ static void ide_sector_read(IDEState *s)
                                       ide_sector_read_cb, s);
 }
 
-void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
+void ide_dma_buf_commit(IDEState *s, uint32_t tx_bytes)
 {
     if (s->bus->dma->ops->commit_buf) {
         s->bus->dma->ops->commit_buf(s->bus->dma, tx_bytes);
@@ -848,7 +848,7 @@ void ide_set_inactive(IDEState *s, bool more)
 
 void ide_dma_error(IDEState *s)
 {
-    dma_buf_commit(s, 0);
+    ide_dma_buf_commit(s, 0);
     ide_abort_command(s);
     ide_set_inactive(s, false);
     ide_bus_set_irq(s->bus);
@@ -893,7 +893,7 @@ static void ide_dma_cb(void *opaque, int ret)
     if (ret < 0) {
         if (ide_handle_rw_error(s, -ret, ide_dma_cmd_to_retry(s->dma_cmd))) {
             s->bus->dma->aiocb = NULL;
-            dma_buf_commit(s, 0);
+            ide_dma_buf_commit(s, 0);
             return;
         }
     }
@@ -912,7 +912,7 @@ static void ide_dma_cb(void *opaque, int ret)
     sector_num = ide_get_sector(s);
     if (n > 0) {
         assert(n * 512 == s->sg.size);
-        dma_buf_commit(s, s->sg.size);
+        ide_dma_buf_commit(s, s->sg.size);
         sector_num += n;
         ide_set_sector(s, sector_num);
         s->nsector -= n;
@@ -944,7 +944,7 @@ static void ide_dma_cb(void *opaque, int ret)
          * Reset the Active bit and don't raise the interrupt.
          */
         s->status = READY_STAT | SEEK_STAT;
-        dma_buf_commit(s, 0);
+        ide_dma_buf_commit(s, 0);
         goto eot;
     }
 
-- 
2.51.1.dirty


