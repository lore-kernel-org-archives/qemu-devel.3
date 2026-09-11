Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32754C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAY-0004Kg-2a; Fri, 11 Sep 2026 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9j-0003Yk-Nr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9i-0008Dx-5e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyVf7JBB2VSLc3TqglYtvlBBQTxI0eqQCJH5aubruxE=;
 b=PzgUFEL1osVdJ/MH3VY56Qxyw1qXQmE95NKR5n2BUbQ91JT3ncfU3n8zxjZ5yf2UPFaDg7
 sCPfVJaGlcTgvLf/B4bXRDvQoyW4qWAsbehOeJ9TW3asVxcuLqGsuEwV/gCEI8lDW/SGRx
 FZay7hJxEcU5AhNVmG2Q13oH5/9HLzM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-3qbwktSHP_aaAa2Y9ZzaTQ-1; Fri, 11 Sep 2026 05:02:44 -0400
X-MC-Unique: 3qbwktSHP_aaAa2Y9ZzaTQ-1
X-Mimecast-MFC-AGG-ID: 3qbwktSHP_aaAa2Y9ZzaTQ_1789117363
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4839f9edb08so340091f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117363; x=1789722163; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JyVf7JBB2VSLc3TqglYtvlBBQTxI0eqQCJH5aubruxE=;
 b=qqk9MlebkAR6TRyG4GCibRxVOJha/Ei1KdS1+NVQLVbaVGKB7JYWUXo6ivP4LNyyxa
 90BscyMrKhMrSL5kWuZTg/M4TFTVX+li1DKK0k0g4X/8vzBhnvz1ozyLAVkFjF8hhNNx
 hH0LRTR9jhSMobmzhylu3b2RHn4nsTqM08vuYB/x6KVQBRfqGDbmaDryQxCIzzqLstvF
 US4HB4okePSALM6ielXT3ttjc8rk4TjuVH8EUAOcYeuJs1mIeDW4IAH5gEwAQ1/9wCkp
 IWKgWIP2xLG7x/zcu3JPuRaXCCRnLIslCmbpfURdASrPnVg5GaNiqrzRUfUXYQMef8Nv
 rwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117363; x=1789722163;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JyVf7JBB2VSLc3TqglYtvlBBQTxI0eqQCJH5aubruxE=;
 b=De4sYECyG4Qq72ToItmgrkN1Yc9PDiuejlsjDskoqMCWILPQHa4h4v3suK6jOqK8fL
 RHK6jkF3deYIkaf0bOM6rLt1dvLDGfwuQF9zqzNebgR8sg7U10sdYkZtwZihJ81eM3HN
 S0+kiLbc8BpMfTrBhhLyuSkL/JYNh4fp6zZRDLz1vXoW2/ogy+/c5ROoOGBLg2fT4iN/
 9wKWJYqi1LIiiBqfzv6ttBOKHmjEU7PC+1TaiWNll0/laYWZVVY2JPfNTogKAI3V2+FS
 xWXMKZExYlg3dGRgUShENkgdEV4EkccgMVf2w/X2BRE9mtcQMFafVD6s00mf1Ko3tNoP
 Dxsg==
X-Gm-Message-State: AFuF++lTHaG+tc46DCjJe82BhIRqBrWR6ESmqHh7WMvXawoBYvCULmrq
 MShqtoVTO85hPEgv7Fc/3E+qsyaHPKWGusuWcApvwtfeCAZgtNFZy5Q4w6bOzxyAbQzqHs5/HMr
 NdxBp2FUPUe/M4NK1QiLaKJkO2WJzqRXdbkPsIsObinBuqyqao8HdDHmysqUAiqRLvE+2k/9aGu
 6htvpzth6lFY+z/1NMl1sMjjb388U8XG5ZBQ==
X-Gm-Gg: AYBFou3RBfF3gp3RWHXz+8wt89rCG6KeFwY4ObaJCrEpc+fyykkJajOCAs5CjcDgdoj
 6hMPkJGGtaQiIPV4jcRcqRZB5zeOJEVx902y/v6lx7BGJBgsQ8HX+AmhX2xDfSWD8UZCYDik3XG
 uCYIYduTekRFZm5Gr5pJkyEAW0Vc0pFY/NoCxeo3iqjPSYUTfW0j0fI0VOUq6wX9T96y/YGj1fx
 K9l9l2iZPDVFz/2Uk4BA2uPMVjebm5bG2RayNgwHFnwsx6IAntzbyrXhW4fknTW0kRIIZDhU929
 XFPpGzQW7nuaVJZ1VpVQochCFU+SkkySKE5rTDz91nTeeRlshz9hVbljuYuteIk5g/V4ajUtFe7
 ztvyJ/25CJ0PUwKn9sJsfoUY=
X-Received: by 2002:a05:6000:2912:b0:486:e708:2e5d with SMTP id
 ffacd0b85a97d-486eb1d5c5fmr3799934f8f.18.1789117362790; 
 Fri, 11 Sep 2026 02:02:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2912:b0:486:e708:2e5d with SMTP id
 ffacd0b85a97d-486eb1d5c5fmr3799847f8f.18.1789117362090; 
 Fri, 11 Sep 2026 02:02:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e8d1sm4440197f8f.11.2026.09.11.02.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:41 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL v2 34/75] hw/nvme: Fix block accounting for compare
Message-ID: <bfc1ed231786f1d0617f80d7860d8311e69d6213.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

nvme_compare() starts block accounting for the operation, but
nvme_compare_data_cb() (and nvme_compare_mdata_cb()) do not always
finalize the cookie.  Specifically, there are a lot of error paths that
do not call block_acct_failed().

Fix this by putting block_acct_done()/block_acct_failed() under the
`out` labels of nvme_compare_data_cb() and nvme_compare_mdata_cb().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-5-hreitz@redhat.com>
---
 hw/nvme/ctrl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c56725947a..7478f0b33a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2389,7 +2389,6 @@ static void nvme_compare_mdata_cb(void *opaque, int ret)
     trace_pci_nvme_compare_mdata_cb(nvme_cid(req));
 
     if (ret) {
-        block_acct_failed(stats, acct);
         req->status = NVME_UNRECOVERED_READ;
 
         trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
@@ -2444,9 +2443,14 @@ static void nvme_compare_mdata_cb(void *opaque, int ret)
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
 
@@ -2474,7 +2478,6 @@ static void nvme_compare_data_cb(void *opaque, int ret)
     trace_pci_nvme_compare_data_cb(nvme_cid(req));
 
     if (ret) {
-        block_acct_failed(stats, acct);
         req->status = NVME_UNRECOVERED_READ;
 
         trace_pci_nvme_err_aio(nvme_cid(req), strerror(-ret), req->status);
@@ -2513,9 +2516,13 @@ static void nvme_compare_data_cb(void *opaque, int ret)
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
MST


