Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E758C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QX-0000yW-1J; Sun, 26 Jul 2026 17:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QR-0000V9-JC
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QP-0004dW-Dr
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HTWgk7EXa34p1tk+4HvPhCGo4PcXqBHU3O7qJ9slsjo=;
 b=HCL1axSUL7R9ZAVBecYWoPIzWKtBRdTUByqgqoxJifdoz3oc6IcXMAGkFx+Y9MDXekoMoV
 4pvKJZ26bGkKvDZpIx4LEM1juUZBgNQOREs6YbgjqMddAaeIjci4rTeuzrByqqX9Sg5fCp
 O6gNK5QUHaOHg0o/XVxt4BGyi9Uxb/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-5bkbU6k7MSuTpPpvi_ziGw-1; Sun, 26 Jul 2026 17:30:18 -0400
X-MC-Unique: 5bkbU6k7MSuTpPpvi_ziGw-1
X-Mimecast-MFC-AGG-ID: 5bkbU6k7MSuTpPpvi_ziGw_1785101418
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4729d2a64efso1757319f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101417; x=1785706217; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HTWgk7EXa34p1tk+4HvPhCGo4PcXqBHU3O7qJ9slsjo=;
 b=H2wvD6mRfddENQ8989RzTxIuOzgPa0RH4kfBXzaPdzgvNmZhL3/2lJzp5LqQdr8c6j
 MHCo3yKiWjlXCwOS7vNtuzAY6k6kTBx9xZHn7RGw9r5UOosAvo41WpQQVX2peK95NyBx
 KxOgzyyrWtDV1C3NTEUHyj8yjxViTLUzL/1X65LlbLcUnz3eDxypBaomciRBNG0PEcH8
 c/rYK5Py+q2WX2u7QW63CoXltVYFQqkL4SMAU4EJ4JBlWQ84Xlr7nq0fGoKyCFevpfzi
 OcwxIw41/avC7p09sAXlAsz38PLHs5joFRTKZ2JYhCqGa/Evv8quK1Ye2w6ZYB9bdjd1
 kS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101417; x=1785706217;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HTWgk7EXa34p1tk+4HvPhCGo4PcXqBHU3O7qJ9slsjo=;
 b=EsgdigqCF56R1jl6STnBQWM1wYW3r33atHQDsQIRL1jDdPNvYDKhJhvWRlMGKFFSWc
 D+vdlqDqVgKPLcjMW5kPNFADOrwTIinKQk8PhvKtwr/UiT208JT7ZezfsMOotLm3FPY4
 8EP1kupALYnSoKKYCMEchhCByeAFuoAF4W3GGWoi5OakSSADBey5AbvXBQJ70bw5NIDS
 0FgL5i3DwhUmijmYuCNkaF6vzu0EQLsKBW/rfuMwOxW8n7JyAnEeVZWk6s4q7Rbe7pr7
 ayqzWt6xx5e5O01xhlBSm8yDEEgN+i01OIOKi79HnZlKstkVmfxPtVGUVFOS/e5b15DT
 uJPQ==
X-Gm-Message-State: AOJu0Yz00tbVXeNOw8uVcpEV/mV4TsPjyPZFxZHNyeKSupC69juXuypu
 /aPUPYCE6Of8l/boDK2cIvz5wXYeI2wU6MyE8lKlJ7CQcNUyGKuawRPh0gyC0udyNqFHSGase/K
 huYsqbGoiSAq3COkkhdbP+Wd2YbLQfUXCBVzL/Gf2OgMOGricD1TIAPOiZxYR9sZdSVypuRNUC7
 Rdpgw2hvck22JZ6KyITrZdEXCOIkUJsZW9vQ==
X-Gm-Gg: AR+sD10NsgIdXXw8ZTMAO6sjXDYwWg0CtgqnPaLdLKdW8z2MDXd86LxY4yOEjfoFtHK
 Q1uEpa/+qyMDX6LrwBPi3OxjEVKgkQv4++jPtJI7OjsButFHoIUhUo84RU5IXb23Qaz93n3M+0b
 pFrD0P+3H1hXb11rdDyqY2N6qUl3nxMQlXHlm1yRG9as4hJ2/lP48Ab8f+t6p59tk2T4K0PT2FK
 ziXYxamBFC2Xl79FepufeSkenYJk5a5VT2+dVGssoNGR2h1FDt1QcluTWA9fu6sBenACCWxUrdz
 Gg4xatqZDOJpBHb6kIVsAJlOGAmABA/dhflDX4OQnR7ySLJPl51Ba2C/aOJED+1u4toOT6dXPpd
 V1UvkLdI3TptRxzRXprP71w==
X-Received: by 2002:a05:6000:4a06:b0:47f:9159:f1f3 with SMTP id
 ffacd0b85a97d-47f9d018716mr10851261f8f.29.1785101417518; 
 Sun, 26 Jul 2026 14:30:17 -0700 (PDT)
X-Received: by 2002:a05:6000:4a06:b0:47f:9159:f1f3 with SMTP id
 ffacd0b85a97d-47f9d018716mr10851229f8f.29.1785101416933; 
 Sun, 26 Jul 2026 14:30:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm46661600f8f.19.2026.07.26.14.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:30:15 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:30:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Amit Shah <amit@kernel.org>
Subject: [PULL 30/30] backends/rng: cap request size to avoid oversized
 allocation
Message-ID: <13342b9c4104f3bf93c2e52e7de4b383971d7bd6.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
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


