Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C7CCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 08:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF6sm-0000yv-AU; Sat, 01 Nov 2025 04:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vF6sk-0000ym-0k
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:22:42 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vF6si-0002tH-78
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 04:22:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so2931362b3a.2
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761985358; x=1762590158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/yBHTrJrMO56DmEqa5wp1on29U5TjU6FjVLIGGo7tTo=;
 b=kMybrxXKy45DkAWoEHBdo70KsiEi+npZ6PCWiCUf0P2NPtnJObV8c47QV+0WxBsbr9
 30WnCuoNsGSa5fLxSW3UOMQQllpFoqp5ENffV42ZGByIhT6y6dp9FAbEoQIWXsIqrLhJ
 RWl6rKDTMhbQyOmBCwUgXEKCu+rCpkM6dd7Sw0kyY0RYu8ujbeYeioaRlsl6G6VSYYn/
 buklAM6L+rzpN+0ZW9nqkpgY41O5QGhYX8dVsPlsLjj/f1d5tgLIsxpQeSCdp4xyNYQU
 jq9sUChRLVMm56tEr1n6jXlQN967fpNx+sLUSCjOWLAD7UCDxmv0YZdNMLF2c76ONjcV
 yfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761985358; x=1762590158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yBHTrJrMO56DmEqa5wp1on29U5TjU6FjVLIGGo7tTo=;
 b=vapHEUiEGNowKFy31KdDd5+EnLIPfvtTQUv9pe2f103SinSF3cPCqruezmGozGP8av
 CUiE3CFkx4eTZ6cN7dqKrcwiwEwxXjwpcKsYQxCFiayxR5hzPk5Apoj2QCjquht3Jyi2
 FVNrgHGc+hBJQq4fXKc1rwqbCjgrxXyw9blquurVRPHpDfhcE41ddXn1ly0avJQLDqyt
 cibnSNLAIHU1lcWnPhzGg/+oFqFwT5e8isGEtpX/4UiV0Qy09x9Ikv9OveyA94G8MLln
 XLAyfgm4aksyH5tm2YW5QGFWkVFYOOZW1wxN/+RO4HQj4KUUrIZgac/UcASJQaQeoAK7
 e3vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Wu5oNxyA1EJ1QmRDz8l+AmfD83SlcoQuHWul1Wj46ehYrpmOKKPIzkJ573Wb959fodxqHxAxJI8K@nongnu.org
X-Gm-Message-State: AOJu0YyGmCPEKzA41/ZNp3GOl6/tGCyAQUpZUh8Q/7lBrcC/uHbCsnrV
 Q6rp+kG1HKD7giUZaEntoNpz52PPrAEz0cTu+7kMhIDVG35ISf+XdPv8
X-Gm-Gg: ASbGncvbQSJJJOfIDFnZtGIm/WuSebdGIDgSFrlziH7vKBA5SAxD4pjZiwIO6DwaFZF
 Fi7Vajx/HZKCSBC2KChk1Gc700hc+hgVE9f3AaD66wECd7Bb5UhOR6c/skFbxgxsRxUEYjiN0HW
 yy9fEkGBW7K0rB3H9zgp0kyuNtjhpScyn7gE0RZtaWrv7ihV5kt/5+FO+0VkAaAK5T6dfdY/UWK
 YUUsirGBsM+NoCjWr1dqD176xBoC7DKm2EMbWSFWkDmk+Q6SEBhFgvBtzX9GV4lcF4EBnlokc3D
 +zRE4JZIU+YRD0xXHq/5Ry8zCkPruupEt1mmIuJNUer4PYL+8sFRNZfZCbH3W5nhHoA9kqJfjzj
 75CblZZfyJzd5FFz7UqQlrkWefHga3j8CGJ9trY08HcOPXoPev0/sw85toxOIzQWWiGN+fck9Sn
 SS5EYM98cevjhhOS+kb4vrjIfXIod796F6pTcOWYonuoY0ehiWKA==
X-Google-Smtp-Source: AGHT+IFCeYODO3tyqMNK+Kw/LvmH7vHC+D905bPchT3112nnpg12YOYKBiJAMXNemL9GZjiUMcXmig==
X-Received: by 2002:a05:6a00:98a:b0:77f:1ef8:8acb with SMTP id
 d2e1a72fcca58-7a777d3b6d1mr8414933b3a.13.1761985357819; 
 Sat, 01 Nov 2025 01:22:37 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db197335sm4582156b3a.47.2025.11.01.01.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 01:22:37 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 stefanha@gmail.com, sarkarsoumyajyoti23@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>
Subject: [PATCH v3] hw/scsi/ncr53c710: Fixing defects reported by Coverity
 Scan for QEMU
Date: Sat,  1 Nov 2025 13:52:31 +0530
Message-ID: <20251101082231.8681-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

Fixing Null pointer dereference & Async/Sync IDENTICAL_BRANCHES

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
---
 hw/scsi/ncr53c710.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index b3d4593b72..dd9884c8bf 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -834,13 +834,11 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
         }
     }
 
-    /* Host adapter (re)connected */
-    s->current->dma_len = len;
     s->command_complete = NCR710_CMD_DATA_READY;
-
     if (!s->current) {
-        return;
+        s->current = (NCR710Request *)req->hba_private;
     }
+    s->current->dma_len = len;
 
     if (s->waiting) {
         s->scntl1 |= NCR710_SCNTL1_CON;
@@ -1367,11 +1365,6 @@ again:
         case PHASE_DI:
             s->waiting = NCR710_WAIT_DMA;
             ncr710_do_dma(s, 0);
-            if (s->waiting != NCR710_WAIT_NONE) {
-                /* Async - stop and wait */
-                break;
-            }
-            /* Sync - continue execution */
             break;
         case PHASE_CO:
             ncr710_do_command(s);
-- 
2.49.0


