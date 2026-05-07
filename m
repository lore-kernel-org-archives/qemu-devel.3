Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F6CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 11:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKwvv-0001tV-6n; Thu, 07 May 2026 07:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wKwvs-0001sj-PY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:30:20 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wKwvq-0001wd-Io
 for qemu-devel@nongnu.org; Thu, 07 May 2026 07:30:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-83659d38e38so275958b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778153416; x=1778758216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GNci/FEXzK2TX91FHjuyqNH3Ne2APr7Uqd7z9jdmTkU=;
 b=Qii6sQiUonmIc4k4vcRxGYdhn/MJfF71/mm5LSrJB+nyQlAOvqzuZtwxaZEYatF9AV
 CyoUr2O1oPnbV0WshSkKhVSKEE27wpnaU0I5LY3yprwBc7+MTyvY1rXTwC/Y8pw8J9/+
 /FL3NHfPc63VyN66KnBRo9Yl2ATdY18oTnSm7qzr05SiAwwtEaHRWijPFJ4Ukk//mBOv
 4/KjDS0SjTjAqlAilDAroZlRT+TkvKRZvcId5SlcHdCKQYOqMwMsWELv+TPwiNUMcFl1
 s3bwncUfN4Z/ATfcDnbiLnBlkpJ3TbMtGpLMLyZzNvYzSFEcAtcxWNFjdeKiyCdmqVld
 t3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778153416; x=1778758216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNci/FEXzK2TX91FHjuyqNH3Ne2APr7Uqd7z9jdmTkU=;
 b=gVh0B3pbvjIyyVHdxyjxIikgfVNrUp9JN8FjHtG6swqHTmUkcbw6un0ajFeLLtO1jO
 SttDq9SsUORAvug04hOWFI9smPa92wZ1tFe4pKRMcUBHuh6QmdXxqWMFvqV8sANLME4d
 io9Ts1Prg3+CbQN7StwF4YyyfmsIZRW8poy1ABTZ0nkZG/WRUJrgvQYGwPzUIjVt9p7N
 u8hNlh9+BEDXHdo4vujdNfw6TnBrMRfGDIt0MLeA4i3oeFWsYfLS+KtaNr3TtDiJ+2GH
 UWVzjN4Sb+2h5HrK3RGxmJ0YChYqURJa1/Yr5Ay1E8/VgvDulBvhgUvIYNViFD8KwGpA
 HULA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/y2mKjphgd/OSN0OFpmI5yE4bNhQywoq8JenBUKUjaeuYfAZ96v8FDDm3nrIUgdrQfmumawJVrW5ca@nongnu.org
X-Gm-Message-State: AOJu0Yyokbd7giT3+RBUtP6ofLnIkEzbRPFmbYozvNo6DYZGKfT0iIIl
 5WgDIpx9r3m596XfwRTM6jgAj+9AzsqWW8gTnUNY0PYgKwrmRDJ30vTg
X-Gm-Gg: AeBDieuEYJK47by/nyN02as5yv/4YbdpA3PNg1Bk2IjgWccAC0/i5LJ1h+QXdPB+2Pk
 DAJCf5UCk7NSIE45B2NrEy8Sl3JJMnJnykIMIugwMMoQoRTMlROhnG/2yT4A7KiK76OuLmwHSzO
 a7+W9beOeAYmLEtLnjjB7hz1jg8Xx+aTOYID1X3Xiu6t2yRZznYaHD4SyDKqvY5xQK7yRgXWkEP
 lBd6kT4brUj97MTaP+B2cTF6odAx/Hpi2NZ4RW/CENg/ZFK06wJN+3fwbxfdDlMheRETfIs+BMy
 JmfA07z/zkfVwimHVYIkVOiepUFGuDxgrv53JSELDyuMY0Km+jlbyV+45HMA2UklPEcZGX1wV1U
 qfRhWl13XVgZ7QjUah3dSWojlfSgi7ENsit4XBLEol2sADGCW8dqF9ZpbD1K41dh3kUiMMK59CO
 W9drr4cT7pptGYHU0xNrVd8UvVBjEYB0bslXc=
X-Received: by 2002:a05:6a00:12e4:b0:837:75d1:a724 with SMTP id
 d2e1a72fcca58-83a5dd5637fmr7000597b3a.37.1778153416261; 
 Thu, 07 May 2026 04:30:16 -0700 (PDT)
Received: from gmail.com ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839683a6252sm8647852b3a.59.2026.05.07.04.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:30:15 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH] hw/cxl: Check mailbox input length before copying payload
Date: Thu,  7 May 2026 19:30:11 +0800
Message-Id: <20260507113011.3674785-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=physicalmtea@gmail.com; helo=mail-pf1-x42e.google.com
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

mailbox_reg_write() copies the guest mailbox payload with g_memdup2(pl,
len_in) before checking whether len_in exceeds cci->payload_max. len_in
comes straight from CXL_DEV_MAILBOX_CMD.LENGTH, so a guest can make QEMU
read past the mailbox payload buffer before the command is dispatched.

A cxl-switch-mailbox-cci reproducer trips ASan with:

  ERROR: AddressSanitizer: heap-buffer-overflow
  READ of size 1048575
      #0 __interceptor_memcpy
      #1 g_memdup2
      #2 g_memdup2_qemu ../include/glib-compat.h:99
      #3 mailbox_reg_write ../hw/cxl/cxl-device-utils.c:205

Reject requests larger than cci->payload_max before copying the payload
and return CXL_MBOX_INVALID_PAYLOAD_LENGTH instead.

Fixes: c9460561ed ("hw/cxl/mbox: Generalize the CCI command processing")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3478
Signed-off-by: Jia Jia <physicalmtea@gmail.com>

---
 hw/cxl/cxl-device-utils.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index e150d74457..6560fb146d 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -202,14 +202,19 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
         bool bg_started = false;
         int rc;
 
-        pl_in_copy = g_memdup2(pl, len_in);
-        if (len_in == 0 || pl_in_copy) {
-            /* Avoid stale data  - including from earlier cmds */
-            memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
-            rc = cxl_process_cci_message(cci, cmd_set, cmd, len_in, pl_in_copy,
-                                         &len_out, pl, &bg_started);
+        if (len_in > cci->payload_max) {
+            rc = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         } else {
-            rc = CXL_MBOX_INTERNAL_ERROR;
+            pl_in_copy = g_memdup2(pl, len_in);
+            if (len_in == 0 || pl_in_copy) {
+                /* Avoid stale data  - including from earlier cmds */
+                memset(pl, 0, CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+                rc = cxl_process_cci_message(cci, cmd_set, cmd, len_in,
+                                             pl_in_copy, &len_out, pl,
+                                             &bg_started);
+            } else {
+                rc = CXL_MBOX_INTERNAL_ERROR;
+            }
         }
 
         /* Set bg and the return code */
-- 
2.39.5

