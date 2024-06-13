Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543FDC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHctn-00060X-45; Thu, 13 Jun 2024 01:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sHa6e-0006Oq-Jk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 22:22:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sHa6d-0000Lo-4q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 22:22:28 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7046e87e9afso438505b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718245344; x=1718850144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VVRjRXdInkrNhgtrZkzcikgyiKaWkYOFgYpR9Y90K9w=;
 b=A0qBoT6EYzeI6sySnKKNNSXZOwsrUiR+EiJ2tbVR37XfUHpmDBjqYZvKGtJUmTd2FL
 msDEAmXSx9pAJ60WkjESr6JzQfcc37oHjNemkTQryAbJhTfOe+3nyFFNyqPyPU2/6RZE
 RU1lHYJzuzKwG3wY4I4FiArsCjtgCds9j3blwN3Tini3k//i4sMsW/WQWh5eu3Wiens4
 Sd37z/sdHJ65UOjOWKxpcRV29eeHOcjK5iZee1lTQq8mu/T5xnaCxPG0zPjGnF0jQza1
 q9J/hdGVXBhHN1y5dwQ0NKbGfaLRl9v8+0OUDm/EzupBcufbC1giukdm+0BCHhZQTPXT
 nEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718245344; x=1718850144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VVRjRXdInkrNhgtrZkzcikgyiKaWkYOFgYpR9Y90K9w=;
 b=pfSit76z4gohAiWViG6xPazWlrQ5Bnuie4BHRmGgUmEFmyEKFVwrb1OS/wqOreOYGL
 kwBqE4pj/tc+cVK9rq45wnxXG8TlzqSE0qtx/WqtpKll+nAyhp97reuNUFlX+EjxUcpb
 9nT85pwMdz5+oS8I5Fhzl5hXEjOOw9ZMBUnUqmhOBw1HROJ4QboklwHewHft7R69UK0L
 weIyX/GfD/GUGs+vYcfNmz90hrISiIhlHamtJg4ADi3ZGlRI9qBRex2tAzKrAdwoAOgy
 z00Q8VUSSsVyW4iLZGjTVfqWvGQUJrpyCQ+YF8sh9gAajPMcMsZ3dlkhr0NoQfLg5osJ
 Vkaw==
X-Gm-Message-State: AOJu0YzkMa3yfygA4hkR0Q/N+D8tiM7/S2zSjgZPT9euOOFDEon6BoC0
 B92LRlYzX79wVDxYZT2gouycgu8Ezh85aAj2ieqIhBvnJT/Ci6fkDbzatKdJbtc=
X-Google-Smtp-Source: AGHT+IF5U+SXFit98Q6rJiQxZRrlIZ8GhZvc98iGDiQOtCdOfyg+3JmtD/kKmF6S143UqUIMdr3Drg==
X-Received: by 2002:a05:6a20:96cb:b0:1b7:dd1f:b7fe with SMTP id
 adf61e73a8af0-1b8a9b8754dmr3171663637.29.1718245343979; 
 Wed, 12 Jun 2024 19:22:23 -0700 (PDT)
Received: from localhost.localdomain ([118.242.3.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e80eebsm1731175ad.117.2024.06.12.19.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 19:22:23 -0700 (PDT)
From: thomas <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, thomas <east.moutain.yang@gmail.com>
Subject: [PATCH] Update event idx if guest has made extra buffers during
 double check
Date: Thu, 13 Jun 2024 10:21:47 +0800
Message-Id: <20240613022147.5886-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Jun 2024 01:21:21 -0400
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

Fixes: 06b12970174 ("virtio-net: fix network stall under load")

If guest has made some buffers available during double check,
but the total buffer size available is lower than @bufsize,
notify the guest with the latest available idx(event idx)
seen by the host.
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..23c6c8c898 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1654,6 +1654,7 @@ static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
         if (virtio_queue_empty(q->rx_vq) ||
             (n->mergeable_rx_bufs &&
              !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
+            virtio_queue_set_notification(q->rx_vq, 1);
             return 0;
         }
     }
-- 
2.39.0


