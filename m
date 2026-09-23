Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120E9C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MGc-0007iq-Nu; Wed, 23 Sep 2026 08:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxv-0004F6-Fe
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:49 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1x9Lxs-00079l-Cg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:20:47 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8cbb7b9cfso668236e87.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790166031; x=1790770831; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RQ7LqL6uIN2+w3MFU8dOf51u0da7idHTXofvzCxA5W0=;
 b=mXlm0/ZZFxg/M9xy/r+sizheOwDUYKFCFgxqIn/BVpxnf7esH6zQPObMqa9hrn7dau
 l5UPpDB3RL7CGFrnmkYzOdZLg2E/dwghS6yx1On9OKB5Z0DOTz6glSXuMQ3YYUExWQhT
 iljK4I+9msp1mJ6ZaXuePLuWGg3GJecDE860G/OvEEl31kvosyvl5dUEXce6KBChUMZv
 wt0jUtqp/dGqxIKrQuR8rBV37EleWlbgtLyty59E03OtOLD7jQIl17P+ZR7GrpTgy/30
 ZP4PtOAYTjscTXWIZUSjl/UuQ2FvL3/frcapDpEWG0jju7vZt+BLfmJ2LsnE78rIk7Sf
 fOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790166031; x=1790770831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQ7LqL6uIN2+w3MFU8dOf51u0da7idHTXofvzCxA5W0=;
 b=W5D4g3nDmf8QeZRLUVYxOD0oLTFzFd3E6CCPKYWJBiC2wqlN3nVWBD4rxZuR9MYg8P
 2IWfi5lwLu15y+dDbdMhAIudimoLPDXicqfRUUUlpzo5dvKiLrilJnPrOiDfKy9ql2qZ
 DNWZ53xAzxIAf9Yyw7Ub9WAyYsVxToGCyz6eGOt27Zahi7GW3cBbaQiPuezqakcyVpxO
 mZshwVmZZzKts8cfLFlcInqBj2iluphzaXlqrDRGo3xEQqtqmfjKHhR8pRcW6VS6opeH
 q2ndcBkR2Q1Y6oeRSJuBduWZ9D70+9+NbeTNao7J89hCvbEqlLUGOfP/sXZaifv6ddk6
 kRhg==
X-Gm-Message-State: AFuF++l6+/yQr7L5LJRTr/VBQHuBcsKWQDbrF0cihiGVEq781GYtzdqr
 DN7PYqNJtpoDUBXlPH3IVClv0wdIPfEpF6jDnsP93FS6jVGZWN8ZqLgJ
X-Gm-Gg: AYBFou0c38c3eAtQETJWz+x1DTmt4lusqgM2A5G9GtsI99c12dzE9IZ01anTpZczEJp
 5ELe+44VXDpc3kr0WSOj+j+4NBkB5nppIXGzHxGGIQRo+rIiSq4mbi+47mgwrnXSnhLmdHNIaBI
 jwU5H76eC/3XEJ9siALtP6Ce5vvIJlvAg416UjZHHIX4r41cmW/IgHbitBfd+tBT/l0YfFPMt6Y
 MHoWGlfMSd8bs0YDPEiBm8tSedZ5Za7ZptquBvUFfYzx9exkV8kTG4XMLoVpisAS3MA6muJWDhE
 uLUdxk52wfMLZ18JB4rX/KI+5e/Rd9It6LhEcVrRiR4PK2sekV9EpfgbKWBUnxWp9RNakCLC6V1
 9SDTu1BnP15JMKoMWBkAjhMR75mszsVCs2PMdQeLC2r5iRbfVnaqcs4as/DLdUkWw+Q4EZ2bfnJ
 7euzVOd63zsaNsZOK9ZAaJWeerHYFBQAs9Ipaaa/k4YvJOAk2ceKkCyAtgLBBCcNCtZsMG9mjPJ
 cMLSPKCDnhm8vAUogRozQ==
X-Received: by 2002:a05:6512:3d0c:b0:5a8:757b:80ee with SMTP id
 2adb3069b0e04-5b8d8978b32mr899492e87.17.1790166030275; 
 Wed, 23 Sep 2026 05:20:30 -0700 (PDT)
Received: from [127.0.0.2] (109-204-139-9.dhcp.ossk.fi. [109.204.139.9])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d85897aesm552138e87.50.2026.09.23.05.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:20:29 -0700 (PDT)
From: =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Date: Wed, 23 Sep 2026 15:20:02 +0300
Subject: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
In-Reply-To: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 =?utf-8?q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790166028; l=2083;
 i=mankku@gmail.com; s=20260923; h=from:subject:message-id;
 bh=L8d3cJ/s2+GgYwMG8LU0QUz+WFUIGxrwJZfFwvTOOKw=;
 b=tzUMhqcEYF7tf1ubewmn2NGfGwXCH8T/b1Ud7zVR71RN5fn8EOdfBsMWvy6TcZPfgT4J7YEED
 hXX78r7oNZmB6yr23kTHzPiHPu1dsRj2yVdL0kVPrek+7Y3y2tMGaHV
X-Developer-Key: i=mankku@gmail.com; a=ed25519;
 pk=vdAiS3IZFixKCwRmc+wfwUSPQWpEMkFYPH8m9evJZPc=
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mankku@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 08:40:05 -0400
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

cq_pending counts interrupt-enabled completion queues with unconsumed
entries. nvme_cq_notifier() and nvme_process_db() decrement it whenever
a CQ becomes empty, but they may also process a notification or doorbell
write for a CQ that was already empty.

Decrement cq_pending only when the CQ contained pending completions
before its head update. Otherwise cq_pending may underflow and
prevent legacy INTx from being deasserted.

Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
---
 hw/nvme/ctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c641226e27ad..2be4bab7eb5a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4782,6 +4782,7 @@ static void nvme_cq_notifier(EventNotifier *e)
 {
     NvmeCQueue *cq = container_of(e, NvmeCQueue, notifier);
     NvmeCtrl *n = cq->ctrl;
+    bool pending = cq->tail != cq->head;
 
     if (!event_notifier_test_and_clear(e)) {
         return;
@@ -4790,7 +4791,7 @@ static void nvme_cq_notifier(EventNotifier *e)
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
-        if (cq->irq_enabled) {
+        if (cq->irq_enabled && pending) {
             n->cq_pending--;
         }
 
@@ -8555,6 +8556,7 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
 
         uint16_t new_head = val & 0xffff;
         NvmeCQueue *cq;
+        bool pending;
 
         qid = (addr - (0x1000 + (1 << 2))) >> 3;
         if (unlikely(nvme_check_cqid(n, qid))) {
@@ -8609,13 +8611,14 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             qemu_bh_schedule(cq->bh);
         }
 
+        pending = cq->tail != cq->head;
         cq->head = new_head;
         if (!qid && n->dbbuf_enabled) {
             stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPECIFIED);
         }
 
         if (cq->tail == cq->head) {
-            if (cq->irq_enabled) {
+            if (cq->irq_enabled && pending) {
                 n->cq_pending--;
             }
 

-- 
2.55.0


