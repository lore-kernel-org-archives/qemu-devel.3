Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A751EC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 13:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkO4b-00060d-Dy; Tue, 18 Feb 2025 08:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>) id 1tkJ2o-0004qn-RR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:33:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>) id 1tkJ2n-0002bL-58
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:33:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c92c857aso80900285ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739867607; x=1740472407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SOltQryFNQSMGMN53NvBCGByy/u489tUeoJSX0NlizI=;
 b=CrWJqe2Ld+w9qxjaKg4lWG6pnR8DHx9A1I0MkfE1xjiv+d3wQ/M+LVaPWQUAtPpeHn
 Yx8SjhdapUARjXe65BojPTRUw/osn32ACGcPuPcEvkSA4XLEPBgyug81qttFCMmIrDPB
 JKHTMdYhGV4CEVzsgK7kAb8lb/4I9WHdSvxgcIp75i8hbBSUrSkr8eWUdbllfSC1Sazh
 J+dn5HSfQf+fx4unJPEeTsHN5fPtvm9Q0ZhnfwN/kWyhzkYJ/AWOraiVyrGZ6cAB9y/Z
 q/6gzJBUo8G/nyIBAHx3fo1iq+iXUOS8T5h1MDunlvfc+WApzU2S7hFKgyIGTdf9JCtg
 yfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739867607; x=1740472407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOltQryFNQSMGMN53NvBCGByy/u489tUeoJSX0NlizI=;
 b=nKsfHRBGHj0TI9FOgGkVZWBZ87RnM94E4uLBSyWvlHu79sjH9mlpO0WQFMxvAuZ5vC
 ljUn6gO9WqJQO+tJMTM2ZQpMH5G3l5S6YVhhfJZgbLeEWYZ8ShXm4qTUXSTnfqm8bK3X
 skVrFVT0iy7mDQYtxhGX60etPVV1PBGOVlzwB754xQYnIbMMtvlcTkHCPlKHp5b1GiBp
 dsRhYEo+ra6MiCM9zUQPxpWTnyqwHz/pIJ/xGbdP+t8yYBUNxUk4iOAYAjDOh7EHQIvc
 OSXKf8PESjXrJ55A+hWSDegODTe5BIl35M0bgxC4oc7yvoUs7rG0prYqRUoQ9kTp8i9j
 0HTw==
X-Gm-Message-State: AOJu0Yz8Sv1yaRksDqIKURf5ngXxcxmaqtKxpEBfwb6UTgMClQfoEN/X
 XiVvOUGAaROE6yOmPZbFBEgCcaB4PClvRc8UeNl5S9cniYUc5opp
X-Gm-Gg: ASbGncu4dLOTLjwk7Pp5PnjHUZF5HZqiuuW/uNJ6pZjze4FQ88/GZkbSum7AcjKTS96
 ylnzi87cz3q/j1V7+3h2KCH84VQInQuzpL/bFkQfw04lUf0FNE34voTj8NiKMxRUE2UpZIbZMkj
 Ti+uSGVtE0lqDqYSan21qEzBYGDxBzQxNW0RnY1IvFoBOFjYg52vHSW0W6ZXkyZ0si9czvEVGFg
 ul3m0HXyNbFg0gYodz/Np2eyH6grw9f/9yMt9B2MRT5UO6TxTmM6p6l1acjiKOioAIW2J3cE56t
 bGWB6Y6tAiNBkURpdqYatlcYdOfIdJA749OKlK6tOuOPkz7rPJfCjoP8Nn1r2TVhseOzR3Oauw=
 =
X-Google-Smtp-Source: AGHT+IF9n5luPvR4x3NZzuzbiZfJ8ovT5kJVjcYGbVtt947882dUEVF4zKTz1Hmh+rBG+6e2QrqhYQ==
X-Received: by 2002:a17:902:f60b:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-221043951bbmr180884075ad.5.1739867606991; 
 Tue, 18 Feb 2025 00:33:26 -0800 (PST)
Received: from localhost.localdomain (172-234-80-15.ip.linodeusercontent.com.
 [172.234.80.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545c8d1sm83315925ad.113.2025.02.18.00.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 00:33:26 -0800 (PST)
From: oenhan@gmail.com
X-Google-Original-From: hanht2@chinatelecom.cn
To: mst@redhat.com,
	sgarzare@redhat.com
Cc: qemu-devel@nongnu.org, Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Subject: [PATCH] vhost: Don't set vring call if guest notifier is disabled
Date: Tue, 18 Feb 2025 16:32:08 +0800
Message-ID: <20250218083208.78465-1-hanht2@chinatelecom.cn>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=oenhan@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Feb 2025 08:55:39 -0500
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

From: Huaitong Han <hanht2@chinatelecom.cn>

The vring call fd is set even when the guest does not use MSIX (e.g., virtio
PMD). This results in unnecessary CPU overhead for handling virtio interrupts.
The previous patch only optimized the condition when query_queue_notifier was
enabled and the vector was unset. However, if query_queue_notifier is disabled,
the vring call FD should also be unset to avoid this inefficiency.

Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..d17e7cc6fe 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1342,8 +1342,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     }
 
     if (k->query_guest_notifiers &&
-        k->query_guest_notifiers(qbus->parent) &&
-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
+        (!k->query_guest_notifiers(qbus->parent) ||
+            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
-- 
2.43.5


