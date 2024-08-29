Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BF9C83010
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjakF-0006il-BL; Thu, 29 Aug 2024 04:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjakE-0006eQ-6k
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:43:06 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjakC-0000DZ-Db
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:43:05 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso271185a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724920983; x=1725525783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=hzwj0V5NlWMLNKBqS9AV7JN7q1fpiKRjSIfkG6UqhRSJiKQzTq4GrOoAfQGbjVKGmw
 BzCaLkrVLY6zTnbU9U/iY9pejUiIn8de850MDR1kXoQLl9BsO31WVWCf3EeRlOcCL+9k
 CaqToPhM8ews5wNi2LxBYJp+0DIfku7ODsW3UBjx5inc/HN3TXLT1nxbiCyt0ASHyqhf
 oL8pAuN//qznJr4rhve5NM7oLvA9o9u0f5M7chVLN5oJSHRCSyVQYNZdTg3GQQMdm3Pb
 r1KOcBhR4XVTFx2YKdD+A2uvB6t6JQko1vMHqo/Doe/Pwo88lMO3SuyEjo3egszu7gm/
 60WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920983; x=1725525783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNfE2FvcIsikcgtI6Krtxtj2etktds/RmL9xP+AY0Zg=;
 b=u7ZmMy8G9A5EEmRTZcF0Kkb8CU5bEMYAcIq8y7tgYMdOgqQ9T4ZaTgyIr3x7Qa4iW9
 xS4odYPU6XFWg44vjM8/vvLCh21E7BI0tlV/6+cGtrdBRrHFjeCOZwagytF4N0MoxeJB
 63X5MuD5dzfeovf1/twsbSd3CCLzW/fGDG0H42+MYK465NIL4q01Cswenl5PiQqRCf2a
 2XqA3WUNDqn+voMAcxVVoK2CkaWmNjNRh4U6ILjF1Cw8SCjF7o/l11RRCazTw0XuyWZM
 fSVQrDrCDhZddsxFsE/GOzVyHleBKd9cOyVQ0yydHujqu9FXBUngywRcg82hULXmJMwV
 /HJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkwwDrJlYD8JUqnD/uBjAwwKPV5Z7ezN4HqmseaEXXPFx9opoXBk5sgOGXulE/SSBl8zgZ7vc8N5Fe@nongnu.org
X-Gm-Message-State: AOJu0YzWxd/OXzNJ1Fo8dZk/7r3paHsSxsG+Icg5dZC1lBmPGkCVW8sZ
 ClcJpDhQYnE4NykQDIOcUzXd28pVfBzffxaJ7zp8dHyZkVun4U+f9RyT/7yDvY4=
X-Google-Smtp-Source: AGHT+IEkX3Y5gn4NSHa8xXuwvxeULy9gbQFimDiK0ihdGwSveBgePUFT5ckvUMRMCpzFDfW+yNq/Vg==
X-Received: by 2002:a17:90a:8409:b0:2d3:d4ca:62f6 with SMTP id
 98e67ed59e1d1-2d8564b3cf2mr1964392a91.42.1724920983009; 
 Thu, 29 Aug 2024 01:43:03 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3897sm3431856a91.49.2024.08.29.01.42.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Aug 2024 01:43:02 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v10 06/10] block/nvme: add reservation command protocol
 constants
Date: Thu, 29 Aug 2024 16:42:10 +0800
Message-Id: <20240829084214.50548-7-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240829084214.50548-1-luchangqi.123@bytedance.com>
References: <20240829084214.50548-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add constants for the NVMe persistent command protocol.
The constants include the reservation command opcode and
reservation type values defined in section 7 of the NVMe
2.0 specification.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/block/nvme.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9a..8b125f7769 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -633,7 +633,11 @@ enum NvmeIoCommands {
     NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
     NVME_CMD_VERIFY             = 0x0c,
+    NVME_CMD_RESV_REGISTER      = 0x0d,
+    NVME_CMD_RESV_REPORT        = 0x0e,
+    NVME_CMD_RESV_ACQUIRE       = 0x11,
     NVME_CMD_IO_MGMT_RECV       = 0x12,
+    NVME_CMD_RESV_RELEASE       = 0x15,
     NVME_CMD_COPY               = 0x19,
     NVME_CMD_IO_MGMT_SEND       = 0x1d,
     NVME_CMD_ZONE_MGMT_SEND     = 0x79,
@@ -641,6 +645,63 @@ enum NvmeIoCommands {
     NVME_CMD_ZONE_APPEND        = 0x7d,
 };
 
+typedef enum {
+    NVME_RESV_REGISTER_ACTION_REGISTER      = 0x00,
+    NVME_RESV_REGISTER_ACTION_UNREGISTER    = 0x01,
+    NVME_RESV_REGISTER_ACTION_REPLACE       = 0x02,
+} NvmeReservationRegisterAction;
+
+typedef enum {
+    NVME_RESV_RELEASE_ACTION_RELEASE        = 0x00,
+    NVME_RESV_RELEASE_ACTION_CLEAR          = 0x01,
+} NvmeReservationReleaseAction;
+
+typedef enum {
+    NVME_RESV_ACQUIRE_ACTION_ACQUIRE            = 0x00,
+    NVME_RESV_ACQUIRE_ACTION_PREEMPT            = 0x01,
+    NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT  = 0x02,
+} NvmeReservationAcquireAction;
+
+typedef enum {
+    NVME_RESV_WRITE_EXCLUSIVE               = 0x01,
+    NVME_RESV_EXCLUSIVE_ACCESS              = 0x02,
+    NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY     = 0x03,
+    NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY    = 0x04,
+    NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS      = 0x05,
+    NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS     = 0x06,
+} NvmeResvType;
+
+typedef enum {
+    NVME_RESV_PTPL_NO_CHANGE = 0x00,
+    NVME_RESV_PTPL_DISABLE   = 0x02,
+    NVME_RESV_PTPL_ENABLE    = 0x03,
+} NvmeResvPTPL;
+
+typedef enum NVMEPrCap {
+    /* Persist Through Power Loss */
+    NVME_PR_CAP_PTPL = 1 << 0,
+    /* Write Exclusive reservation type */
+    NVME_PR_CAP_WR_EX = 1 << 1,
+    /* Exclusive Access reservation type */
+    NVME_PR_CAP_EX_AC = 1 << 2,
+    /* Write Exclusive Registrants Only reservation type */
+    NVME_PR_CAP_WR_EX_RO = 1 << 3,
+    /* Exclusive Access Registrants Only reservation type */
+    NVME_PR_CAP_EX_AC_RO = 1 << 4,
+    /* Write Exclusive All Registrants reservation type */
+    NVME_PR_CAP_WR_EX_AR = 1 << 5,
+    /* Exclusive Access All Registrants reservation type */
+    NVME_PR_CAP_EX_AC_AR = 1 << 6,
+
+    NVME_PR_CAP_ALL = (NVME_PR_CAP_PTPL |
+                      NVME_PR_CAP_WR_EX |
+                      NVME_PR_CAP_EX_AC |
+                      NVME_PR_CAP_WR_EX_RO |
+                      NVME_PR_CAP_EX_AC_RO |
+                      NVME_PR_CAP_WR_EX_AR |
+                      NVME_PR_CAP_EX_AC_AR),
+} NvmePrCap;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.20.1


