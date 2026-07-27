Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454C7C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQt6-0001wi-JV; Mon, 27 Jul 2026 15:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsb-0000uK-UB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsZ-0000h3-AR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yAMl0TJC2lTfXtPmX3khS6ok/xChyA7rdCzEl3eAPrg=;
 b=fnEtB7eW6bH6aXNBKNiliMGhKgviDt0RovZ21hw9p3kXDU4q/uENYSwbl3S7eyXWLXtHWj
 Jd0zL6PzCfksCdvH8pQEIzI67JSSV7lLJeIab/CeSRCa7PE6OJYJ60pe5n+4GF7YCQtZMR
 KqWI+IV4BtgvU3p6sQINAlED7GAPiYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-kGoGJUODNY2Ffaw0vqQBsg-1; Mon, 27 Jul 2026 15:20:43 -0400
X-MC-Unique: kGoGJUODNY2Ffaw0vqQBsg-1
X-Mimecast-MFC-AGG-ID: kGoGJUODNY2Ffaw0vqQBsg_1785180042
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955843c6cdso34164025e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180042; x=1785784842; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yAMl0TJC2lTfXtPmX3khS6ok/xChyA7rdCzEl3eAPrg=;
 b=S0UtN9DXRPRDEKsK95ZZ37CrZHU37WX02OnyEPRFy13RQfLY/iQ65NLe0S4mZ116rU
 hEwDfimApI/0lMwCOKJKuXihtFyouk2yZEhybBB7/FFA6wvjM912i3xSLJYD3rog5Yq4
 gBmXcBTtEmLBbf/rVUZ4ZBjVnzGEjB9rCYeXWWR/Xe1iWcZJhi/u8TAmbD69VGgGUYOz
 R39kX41MG0XRuywcnSQizt/1XNlNoBr8LTuqDNHLY25idu1FKgmQ2l2ERvDcwe3HpaY1
 DO89cSDIvIdjSF7NCjIaeaBEyIZh3NZ8s4zQ9hI7asSCD6rfHRw4opKqouHyabWwPzI9
 XNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180042; x=1785784842;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yAMl0TJC2lTfXtPmX3khS6ok/xChyA7rdCzEl3eAPrg=;
 b=OvwYxyIiN4PnntFLAeTu3UugXdIBABs3LKr32Eja2ESVSgPn+2EVjStzKKXLUr+9bw
 ejmac+vGWTpoQx7Pt8lGb+gX3NmG0UThylFwS0xO+btleJa37VGJ7AlS+HMSUCqdYI4a
 0aWBfrMbmplxI9UiWUK1TGKkjZU+yGKhZh1k0TasovPeTjpK/WuhK/HsXbUoIgrZNNay
 sNusxOXUJShvZIODfb7ljKTXp/4X+mTnFGFFDZrJaxr8pZut0p1VHF2XJdjySI24e8Zu
 9pD0Tthp3EZ8Rc8EttDRV4BmulFMGCFRDvoaPjwblVieTzzPkQNxYeCCj4IMiZfDRe/k
 I1rw==
X-Gm-Message-State: AOJu0YwVPsgbxMITXtlh10ts0djypOeK+ZenYnKdpa0DE2/sCNzGxKW4
 5MU3cGzVdDWAir1X3yMud/08YT81sGSNHiEfQ+x/1G6cM4O3FZo55qV3FbTdQgJSTPlEEp4n8g/
 TGISuzVuTIJfPvmcOCFLm2zeIdIghzDQ3ydH6AMHxRXTDp1Kta3s3iA1O+nnqDBYCGV3H9oGT4n
 mk62f2wT+I0miOXNBbcYtqwa26h3XKN2Q9fA==
X-Gm-Gg: AR+sD12Lrhk7p5Vby4PI4jtzTkVvX/vyUEec5Jerqq2WFFADDbna89dFjH/bb0gOiz4
 KtzFAQyWM2ynfJZ5NOMN7eNcXFM9Zp5DLL9KSSuqTi8OibJFj0JYlg2kETp/HOkAxHuQ1/b9TTd
 IYZkouboQDGC8jDTKUHihSwjWsxk31kRgITMHF86udmrI49+PUXvKW3AgbigkxrOt0AN+IWczRM
 1qSzkShpWrNh1Tp3xXcbG1oanMaM9PV6eu+ToQzbN3HCzooKMwIx76+lNwhZpZnagEW22Jv9C5G
 GFU6ocSPMt/rt10OEoL412F54qRNzVVKx2iePUV84fJpiGOPcrjny7jXgjuBopyzc9bELmTcBxg
 rl2FKh+pGTJOaws7irjpPGQ==
X-Received: by 2002:a05:6000:2313:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47f9fc8840bmr12978628f8f.13.1785180042286; 
 Mon, 27 Jul 2026 12:20:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47f9fc8840bmr12978592f8f.13.1785180041712; 
 Mon, 27 Jul 2026 12:20:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6287csm52087602f8f.25.2026.07.27.12.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:41 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 dong ling <dongling226655@outlook.com>,
 Thomas Huth <thuth@redhat.com>, Amit Shah <amit@kernel.org>
Subject: [PULL v2 29/30] backends/rng: cap request size to avoid oversized
 allocation
Message-ID: <70074cc48f450e6c95881ac534e67013c8773cb2.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: Laurent Vivier <lvivier@redhat.com>

rng_backend_request_entropy() uses the requested size to allocate
a buffer with g_malloc(). With virtio-rng, this size comes from
guest-supplied descriptor lengths. A malicious guest can set a very
large descriptor length, causing QEMU to attempt a multi-gigabyte
allocation and abort.

Cap the allocation to 64 KiB. The virtio-rng queue size is
hardcoded to 8 entries, the EGD backend protocol limits requests
to 255 bytes, the Linux kernel hwrng framework requests at most
SMP_CACHE_BYTES per call (64 bytes on x86_64), and the Windows
viorng driver uses a 4 KiB buffer. The worst legitimate case is
8 x 4 KiB = 32 KiB, so 64 KiB is well above any legitimate use.

Fixes: 14417039653d ("virtio-rng: use virtqueue_get_avail_bytes, fix migration")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3983
Reported-by: dong ling <dongling226655@outlook.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260715141300.2295392-1-lvivier@redhat.com>
---
 backends/rng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/backends/rng.c b/backends/rng.c
index 7bed62616a..bc9c7a5ab3 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -11,11 +11,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "system/rng.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
+#define RNG_MAX_REQUEST_SIZE (64 * KiB)
+
 void rng_backend_request_entropy(RngBackend *s, size_t size,
                                  EntropyReceiveFunc *receive_entropy,
                                  void *opaque)
@@ -27,7 +30,7 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
         req = g_malloc(sizeof(*req));
 
         req->offset = 0;
-        req->size = size;
+        req->size = MIN(size, RNG_MAX_REQUEST_SIZE);
         req->receive_entropy = receive_entropy;
         req->opaque = opaque;
         req->data = g_malloc(req->size);
-- 
MST


