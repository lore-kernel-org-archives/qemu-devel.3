Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3F4C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 09:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0HSp-00038n-An; Fri, 26 Apr 2024 05:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s0HSh-00036s-GC
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:01:44 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s0HSe-0000dw-KJ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 05:01:41 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6eb6b9e1808so1187649a34.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1714121979; x=1714726779;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huc445Z8xFVx73tKKS30aR+cLtLJnKrTI8Kz4PO8eik=;
 b=3gDDx+TljbEytWvgC+zBRCWJ81CDwzA1lPP06d6eJgFKARvjftS+ZtHrRYJePyvSU1
 M3k5INu7PUDytfnB8dexe9VGl1pTMlYiyEmrwGKGbCpNxfM1Ug49o6jSFT7HP9EnawId
 FA9g9FCReEACtbH+rTkGGUdoKze2BqZuBEDGholr0ogKqwZRzfp7gfxH+LqDUvNC98CV
 Feq7uFtT1TtLn+RBqCEeIM1YREwzsWrkrwlYo1/SOuuTKmQiH06L1WZdZamD1UL09sV3
 3XmOZk69OznrsSDYsTyfaYeUrmK+OfVeE3ttTRQYm2q2yz3d0rYB7XwdZZhXSv3Vxt4P
 q2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714121979; x=1714726779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huc445Z8xFVx73tKKS30aR+cLtLJnKrTI8Kz4PO8eik=;
 b=T6xUEUkFMc3vQDb0M2tjoqmiRAZ8thJV+Ta1IiaB0ePEGreKTmJgALM9VNh7ufk9bQ
 HC1eV+rmsLTZM0OSqX29U+9CpIjLh5BEE0an9dDrjnKYkwLTcvzRnpD9rgRgfY0Tc9NA
 YHbXPqN3G7ZyeAg9QjBTlSYts/g9iDgmewFk5Pysi9UA/aZAWBfpAY4NuMS27TjYMEkk
 HQbhfiBic4EP8E+usaQvuBYQ8JdeocOa4n6bdAkxE3w/gzAqUuhCI7GU8WD1LYczS3jo
 w3PP8usmogBRy6aZHk6fyNIO0tnEGnR65QBaqS4HcNjo6YE7+bt+b35xFr/zyNXpfpHC
 Aqzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6D1utA4btZFmb9TFKWCRIkeBn6fPk2CClskwhRiV7Ohljm1a5Ae9QPFKIH2q2/nmbEADPvxa6ao1gRvxM7jgGPXd/vI4=
X-Gm-Message-State: AOJu0YwvUcMo6KHBlDPUtalIQdNA8hfvZkgjFP7QIYvvQGw2Y3yKReWn
 6zKzfs3mdGl81U0JBDPX4vOOUtgddd4NKA0b/j6bbl7AllpdzUv6d71YessZW4o=
X-Google-Smtp-Source: AGHT+IHFn+ruOtnxMrnvnF4H/zMbW2lbC5Uh1eCJCY3g68x8fUfd9wVMQYpMzLPIxQ3CJwaK7Kg6hA==
X-Received: by 2002:a9d:5f1a:0:b0:6ed:d1a8:11cb with SMTP id
 f26-20020a9d5f1a000000b006edd1a811cbmr1029386oti.28.1714121979161; 
 Fri, 26 Apr 2024 01:59:39 -0700 (PDT)
Received: from localhost.localdomain.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a63e44d000000b005d8b89bbf20sm14038848pgk.63.2024.04.26.01.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 01:59:38 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Li Feng <fengli@smartx.com>
Subject: [PATCH 2/2] vhost-user: fix lost reconnect again
Date: Fri, 26 Apr 2024 16:58:39 +0800
Message-ID: <20240426085855.665813-3-fengli@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426085855.665813-1-fengli@smartx.com>
References: <20240426085855.665813-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=fengli@smartx.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When the vhost-user is reconnecting to the backend, and if the vhost-user fails
at the get_features in vhost_dev_init(), then the reconnect will fail
and it will not be retriggered forever.

The reason is:
When the vhost-user fail at get_features, the vhost_dev_cleanup will be called
immediately.

vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.

The reconnect path is:
vhost_user_blk_event
   vhost_user_async_close(.. vhost_user_blk_disconnect ..)
     qemu_chr_fe_set_handlers <----- clear the notifier callback
       schedule vhost_user_async_close_bh

The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
called, then the event fd callback will not be reinstalled.

With this patch, the vhost_user_blk_disconnect will call the
vhost_dev_cleanup() again, it's safe.

All vhost-user devices have this issue, including vhost-user-blk/scsi.

Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/virtio/vhost-user.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c929097e87..c407ea8939 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2781,16 +2781,8 @@ typedef struct {
 static void vhost_user_async_close_bh(void *opaque)
 {
     VhostAsyncCallback *data = opaque;
-    struct vhost_dev *vhost = data->vhost;
 
-    /*
-     * If the vhost_dev has been cleared in the meantime there is
-     * nothing left to do as some other path has completed the
-     * cleanup.
-     */
-    if (vhost->vdev) {
-        data->cb(data->dev);
-    }
+    data->cb(data->dev);
 
     g_free(data);
 }
-- 
2.44.0


