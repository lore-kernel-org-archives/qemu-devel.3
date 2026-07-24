Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8FEC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHlq-0004vI-IF; Fri, 24 Jul 2026 11:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHln-0004p4-UZ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlm-0008So-Ew
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784906701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWcZLxewRjil85dJfv3jFzqe8q0vXbspbRXQJFv8Ii4=;
 b=ifapd6TnG/g/x0VJB8rF9RJFdjH9tVxzxJVRJCr03t2ai0yImqylbvjJkJEr3yCeic9b3G
 mHWZDcNqWZ0RRh278KuDzeKKlSDU0yDh5jnNt6jMVfZv0KNp++DetC5q6MlrtWRsO7H9im
 zGNWXA1lrYEre56E5S21mxGVusBYDgE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-zA3eRKXMO1GRh4s9Y7pvrw-1; Fri, 24 Jul 2026 11:23:29 -0400
X-MC-Unique: zA3eRKXMO1GRh4s9Y7pvrw-1
X-Mimecast-MFC-AGG-ID: zA3eRKXMO1GRh4s9Y7pvrw_1784906609
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955ecd8a10so6229725e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906608; x=1785511408; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nWcZLxewRjil85dJfv3jFzqe8q0vXbspbRXQJFv8Ii4=;
 b=VYnE3f9fePGm52k4fBcIWS3CJL6kBhsvIcUbePAfgcpUsSapEnnOqkLXWPY2rzyYem
 /mLGHg3N0szeNCQTfF5dUTenmyucKH05ADpOyAIcDJt2in/s0y+jsBzSj/qOrsTNz9ja
 lXYgd2nPICwx1OUXGocJGFQ0XPWP9R0XDKqnxkbE41ttM5CciuQOfCKEo8cw71fgGYkj
 7JdeZtQq+yYKoE6oCCKzbIr1pmMEehWYPf5GHLFtZqQruBnKlB5Jn4bX3bIngpqITHYl
 poY7xFDgru+XK+F/5skApiFC0hBKuojlU8r/B2dij46LnPoT4ft1oW5G1FlfknlXehQN
 ec2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906608; x=1785511408;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nWcZLxewRjil85dJfv3jFzqe8q0vXbspbRXQJFv8Ii4=;
 b=Ml3pWBsj3BVxGGeP8gx4xheXIKRt9dPfHre0bCwXklckAKFwiDSZG1zRHTWXBylhtq
 94Taewgj+ZA0rejp9E/h3H1hjqF2bcHsaswHigooj7CPzwuOnlJhxgt4DsxNuM5LAjSr
 +6ONXkoDhqFth/iN0CWp7GysSoZx21bMquXh2LBBCiM36Vyy/2HR3MzK4Cwz1xSGDjMV
 rN3fAaAaZNjHPXrC1jgaHhevFE2OFSbeeHkT7NHNcgmuynfHfl1NRFJmcqdA5FLE/Ver
 5DYj5lDHNqnxbuJfVnvUdiF9IClxdzQs2Iw+rsKjazaYeoL69RXA8qOB3BgxYKMpV5wv
 VI7w==
X-Gm-Message-State: AOJu0Yxqz0LHJY9pVDvHEcxxxMOsfgGeqlpehusIjPWMvyaknU1z9LkL
 zHtMLYkWw9qai4hR9cDxdeqFbeRMo8nHfLwrKWmIULs1uHwn1c/Q8ZM7BlKIfEY+4rGkew+KGIl
 7ck4QBTavYjxuxYIRwj5qU5c4F5cbJMXzpGkQmqUdeouk85QHP7EzL5WX
X-Gm-Gg: AR+sD12g8O6/+05kr+t//8MCNdALwGD7ObyneMHxQlV7UwhvAgdnGhvdgfz1K3vh+uL
 36PY9oaRMWSpGWts4/Cu5s4ULf9pYzu89vXZe33d21h7ISoYOKSImxaPJorZiUqsU6B2v0yWPUp
 jfQbNERwO6nqiBbzsqp3oI3VziAJZpbl+ZZ3qpneaTpUBFrVMNi4FPAmCv0P02r9V4jcvCsL1E+
 vxBkGbcszEl2456NJ1MBM7z/pHxPCuToyRqwINeuyLsg0U4xlFtCKsyjoyf58XcBVBE3zhaLpqW
 Ix00RmbdNKKhvJev0beFK9Gn0giwEY72U9gdZSOm/ufmKiF+o95i2eVmfIdigeGPK894bcPwLBk
 jonNCpzktU3JbJod83Y0broAcgSfv8+n3h7d4ZJq/iHhK8pBqflEevmt/xoM=
X-Received: by 2002:a7b:c7d7:0:b0:495:5858:e163 with SMTP id
 5b1f17b1804b1-49573d0cd7amr67841375e9.27.1784906608569; 
 Fri, 24 Jul 2026 08:23:28 -0700 (PDT)
X-Received: by 2002:a7b:c7d7:0:b0:495:5858:e163 with SMTP id
 5b1f17b1804b1-49573d0cd7amr67840945e9.27.1784906608160; 
 Fri, 24 Jul 2026 08:23:28 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b406ea4dsm840355e9.8.2026.07.24.08.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:27 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 4/6] hw/nvme: Fix block accounting for compare
Date: Fri, 24 Jul 2026 17:23:13 +0200
Message-ID: <20260724152315.234183-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

nvme_compare() starts block accounting for the operation, but
nvme_compare_data_cb() (and nvme_compare_mdata_cb()) do not always
finalize the cookie.  Specifically, there are a lot of error paths that
do not call block_acct_failed().

Fix this by putting block_acct_done()/block_acct_failed() under the
`out` labels of nvme_compare_data_cb() and nvme_compare_mdata_cb().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/nvme/ctrl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 32e78881234..335498a2d73 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2388,7 +2388,6 @@ static void nvme_compare_mdata_cb(void *opaque, int ret)
     trace_pci_nvme_compare_mdata_cb(nvme_cid(req));
 
     if (ret) {
-        block_acct_failed(stats, acct);
         req->status = NVME_UNRECOVERED_READ;
 
         trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
@@ -2443,9 +2442,14 @@ static void nvme_compare_mdata_cb(void *opaque, int ret)
         goto out;
     }
 
-    block_acct_done(stats, acct);
 
 out:
+    if (req->status == NVME_SUCCESS) {
+        block_acct_done(stats, acct);
+    } else {
+        block_acct_failed(stats, acct);
+    }
+
     qemu_iovec_destroy(&ctx->data.iov);
     g_free(ctx->data.bounce);
 
@@ -2473,7 +2477,6 @@ static void nvme_compare_data_cb(void *opaque, int ret)
     trace_pci_nvme_compare_data_cb(nvme_cid(req));
 
     if (ret) {
-        block_acct_failed(stats, acct);
         req->status = NVME_UNRECOVERED_READ;
 
         trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
@@ -2512,9 +2515,13 @@ static void nvme_compare_data_cb(void *opaque, int ret)
         return;
     }
 
-    block_acct_done(stats, acct);
-
 out:
+    if (req->status == NVME_SUCCESS) {
+        block_acct_done(stats, acct);
+    } else {
+        block_acct_failed(stats, acct);
+    }
+
     qemu_iovec_destroy(&ctx->data.iov);
     g_free(ctx->data.bounce);
     g_free(ctx);
-- 
2.55.0


