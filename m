Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6301ACCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lCp-0004pQ-O6; Fri, 17 Oct 2025 10:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCk-0004kq-B7
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCS-0005iI-0y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:13:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471076f819bso16192775e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710372; x=1761315172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM6QgAOG34zDGb9jZI8DkkbGa1KuVCoA2kRHxsUOX8Q=;
 b=R8xaQlwxjPSDpG+QCgRTnsSTb6EPzF5/uzVgemcl2m8GOWrzJO0HDemtBfj/CGHzjE
 Fe0YdqmevhyXOZdGTxx2yFkgZI5ACj0XCuZnM8dLxJkU4dYZ1YG52AKn88lnZNpqjIDV
 yN0LUJKQQfH4RnNbMWVrxOtdvMMy+EyhjNXKogz45NiuUXZuMRW1LEHarrXdpmxr/4cq
 81LqkIKW4rlqcqvrBXQGoFWLMf6E1RwBKSOTmZE23A2xezPE77TSXdmWLf03WoNcH547
 XdUCmkZOEO7uTQS1K+cL32VZVhjFT1EawBqowrdZcShjGGhGpGRvsufM91KpcKqBVkZg
 BwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710372; x=1761315172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BM6QgAOG34zDGb9jZI8DkkbGa1KuVCoA2kRHxsUOX8Q=;
 b=tJ/kHuGhVwsuxdpBAdb0iiT1w3ipywKtQ+zGCnWDh7Nl4HUwAXR3ZlTN/Wuks0P9A3
 1UoDD5FjbgdeHyhP9qxJELNYc6ue3rUE/h+MdC0lQlrBAswCPW5ZHcdwW/4d440TdQ8B
 CY0c+qONGIc/bFkmBckbvE4USklImPXZKzY55xc09B6e+dsZfybGjJHMbNDRV7qJB0L6
 VWVQZv+axTL9qmeUlyBPQQC/LWIlk35Mv9FDG2VbgqDNkaGf7fMk3Hn4h8ixDjxHCLTo
 YNwi3O0svhat2HSlrKgPpJq+sTRBoiXHUX/1uOVp0KeCXaURMMWNbS9Eyx3qvo4pLSiQ
 RcxA==
X-Gm-Message-State: AOJu0YwwxQa+U2RdYM/FvTLuNEEMzTEzE0kXazpPNCVqgJVrvGHhQZeG
 ABPqhOAchGUguAV5pgbFqapIvt4JoF40oGd1yfXJiMAAp0KYJtGbPj9/iIbIHw==
X-Gm-Gg: ASbGncvdaq1Fip9IVIb0Gv6bb25hqF9st5XnTthBQI6LDez22t/T5Tfxc03tuS34F1w
 Q2DlFUTUlyDa6s9FlvROzczUsLhFBn7pKKf0QSCLkiVrwJlAl3gENmCTPpx5V8mJDPd0CbtoZSB
 jPpAbSLvzeJ0yPfFvtEeEwDx7D54mkD/F1UEz55G89P18oWu/DG+6IkQqVbIjM6tIel2VgapOSY
 GOdPYLbY+8V4EuC0+SIsRFwhZWUCWeGEPV2tciRyQ0jYqEw8bvqBULaGaLxePW8SAGsvC93fCns
 ce0UMOis77U3N5r80YzhCTZch3GrHHXBqgtAD8yAr91h+CtsB78/vfHzEO00Gxxl/EnsidJY+T+
 XsNXcQQABb9Br6Xb3RfcaY8f4ou2MEMYfT+Ns+rPeWV4bY32NmYxeFls6W15l/znkLn0qWJfuvO
 RUm3aNFJO8QsXMrsTLrI86PutORNkf/o5bmPhRLKjxKVY=
X-Google-Smtp-Source: AGHT+IG5nxpyCZb86JulC3CK6XBAxAajZvuOX8OdfguJ75zkQr/jxOZUNh4OU/knYFxHTDCsaxeKIg==
X-Received: by 2002:a05:600c:34c7:b0:46f:b42e:e360 with SMTP id
 5b1f17b1804b1-47117931edcmr33177805e9.40.1760710371445; 
 Fri, 17 Oct 2025 07:12:51 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:51 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 06/11] hw/ide/ide-internal: Move dma_buf_commit() into ide
 "namespace"
Date: Fri, 17 Oct 2025 16:11:12 +0200
Message-ID: <20251017141117.105944-7-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017141117.105944-1-shentey@gmail.com>
References: <20251017141117.105944-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


