Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669C5C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4n26-00028V-Qn; Thu, 10 Sep 2026 18:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lW3-0006SY-4B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVh-0003Bz-FR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyVf7JBB2VSLc3TqglYtvlBBQTxI0eqQCJH5aubruxE=;
 b=V3/cK8x1+daAJPIgaoHnn/9rL8TArOqqUTwryr0ZI/1uVowNKHvKVQpMWYpjNNkl5VXGXz
 viAcm2sWCdZkFiEJhHnMTqZvV3/99KnVubxFFqEQiSmM2si0W3hiWnEFMNujTBzkMv+GDQ
 C8c5iMmPZZxOClUYyuO2otemxzLDtiU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ODAcGmFOPiq0eEgTBDDsBQ-1; Thu, 10 Sep 2026 16:13:29 -0400
X-MC-Unique: ODAcGmFOPiq0eEgTBDDsBQ-1
X-Mimecast-MFC-AGG-ID: ODAcGmFOPiq0eEgTBDDsBQ_1789071208
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-482e2541c30so116345f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071208; x=1789676008; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JyVf7JBB2VSLc3TqglYtvlBBQTxI0eqQCJH5aubruxE=;
 b=V9kXaWkIgOCWYdxO6NgARwbx9TAV9iF+44MPrVrzhsgK/y6P+XksJgWC3pFkPPD1Q0
 l7g2tBRLRzd9+dFkE3duF01wPuywYhEwoKMUSXQF0by1YkV7oLSEszupfIXoRSBvhc1e
 blaVckKPLXxvD32BhQX9A0sLxzQDJHQ+nff3/FrSz29GRTgpfPDDfuF3Q3Mw8dRTYuzH
 B6m/soCC/6SU7J7fjfzblSejCv1Q+FWHGIlYGXNGAeIBWGnzsBsElSfvjkO67vlM+7Ns
 V1gsN/97a7v/NOPIUqqKzu2XKwAdmZwscNPt39zwwiy3p5JVEHj7zSM4dv55gh3AcxYY
 iT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071208; x=1789676008;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JyVf7JBB2VSLc3TqglYtvlBBQTxI0eqQCJH5aubruxE=;
 b=Uo6BBPDqTmPsr1AOTTOS8V+cpJINZATdy0D7oI367E+syoXckXaM7zGDcmkooCfUeN
 Xx+1IIfabwioKPj8TtoT8Unv9Ac3IdTOEOQ1luH+8K9Cfm6h18rbYX43FKWJPPm5wLze
 0SeaOCaDlYcDvgpOct9PiMypZKKX/zBfubscVYgEk8atDJ88RfWmFlu5OCmCkHcLWWA0
 KeGR6yzXcJvl6Qk4y6fzryAzlzhDTYkfX9f1Y8AEkjLmCmMYsMKUtdaaFU+odOYuwvwB
 MkaA/3Kfd9C1NeRCMckMjF+NZ66IYJSh6MhmK3V28XfnpxWQ0ZJV01q4A1tHWPPqtRBE
 JUwg==
X-Gm-Message-State: AFuF++mAdO8vESziM14LP2QP5QJACvZcw0Oq5o9DGF9X8LP+0KD3EZuQ
 +3JOvVwh9mJtdOJiqjAj7YZHeZCM6aKVi07CWYfAVwWLbsYB7CpymUP19tP0Mxh/fF4E2CLUC/m
 h2pvlhOkY+aBoXkZbhwCBy37U10Uewgln4/YCMb6KJNBZKJiFh8BtBMwPvUK/i4GTsLMOO4v8Vv
 VSrIbpjt+Sun2vtmETmxwmmQDXsrY9TUhkKw==
X-Gm-Gg: AYBFou1WNMTOrUI/XD58XBs1bB37QfyzeqgxcT2ArJteNqL5busnbGLnrj7dc2qRNDo
 wnNEH2+fiZbMWAwhryPRQxQ2KSvSiPsq5eTlNy9oFn2fEnRB5bc4P3XAAqyOjHsnKOIVtIEGUBQ
 u9IOU1t4Xf8AuYO/7c2AJQ2SkQUkwc+e22VYamFTzEL5k9mdqhr11C+j3KUDOEnSW3FUvFdeuVr
 PmuOqk5uOGgnaS1MONM+s6+mdZnG5SuWSd57rRJkBsvhj+uQg9IozJGu/wEYxmSqNGAWoBCsWFz
 aPKcdJflupIKghEwRmT4Nv+6nstJybpQemyd+4SwipWfPNSivPcOXWY/nrVFFd+sS9CXLneTP7i
 f5fxj8vY9bkUUrE9bgPxsiTY=
X-Received: by 2002:a05:6000:384:b0:484:42d7:50fe with SMTP id
 ffacd0b85a97d-486e9356aadmr1226758f8f.4.1789071208159; 
 Thu, 10 Sep 2026 13:13:28 -0700 (PDT)
X-Received: by 2002:a05:6000:384:b0:484:42d7:50fe with SMTP id
 ffacd0b85a97d-486e9356aadmr1226717f8f.4.1789071207458; 
 Thu, 10 Sep 2026 13:13:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35c071sm757260f8f.33.2026.09.10.13.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:27 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Klaus Jensen <k.jensen@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 48/90] hw/nvme: Fix block accounting for compare
Message-ID: <1a4014a9621f7be9b4231a337924078b66a615e1.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


