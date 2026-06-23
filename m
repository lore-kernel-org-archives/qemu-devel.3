Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA7ECDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0YL-0004UY-GF; Tue, 23 Jun 2026 08:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YH-0004Tz-N9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wc0YA-0006yj-8A
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782218899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NxxzS1Ry/8cdZldgWf/p8MR2BUoUQOLrlYZHskkcFmA=;
 b=BkynJU7piM/o+kYIj4rnlIge0MKevSq9PPuu+BhHuhR/g8ShrCnvabMylr3400m97G5CiF
 uvu3ZINYyR8s0JBNfYVS+7BeaqvnyIsrNIM1CW6MIxZKqF5GJ75e21qe0pB1q3iYcOv6XR
 4yC34EaFDrB9OECLGlXgiF2D1TW3MGk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-bL95UU_eMSCBRPrlFu4i_g-1; Tue, 23 Jun 2026 08:48:18 -0400
X-MC-Unique: bL95UU_eMSCBRPrlFu4i_g-1
X-Mimecast-MFC-AGG-ID: bL95UU_eMSCBRPrlFu4i_g_1782218898
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517d766e05aso21529301cf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782218898; x=1782823698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxxzS1Ry/8cdZldgWf/p8MR2BUoUQOLrlYZHskkcFmA=;
 b=fVJRLLPuaIfhbcufL9QTGT9oLErcZu6fAxz02CkEpFjCBfQytKcxu98qQP386vkC5V
 qeu9hL6SN8+NTayTWVaeGq327XG5EmI3sQjIhOGLV2aISJ9St2tteil3CQUK9DqKtMdL
 sDFuRHBayuVT/6qkEOWVf6AXs3b9KTLS9dkIxblRSdHLca4J9Ov/lLSynXhWFLv/BnJP
 ycpQx1xnHTFNBbb2a4J6gF2z0axxo5pyE9szI/ARLcR6mH/FFUa3wpjWBn7Z2ARUKGOd
 O9/Zy3I6Tps2RE0DdYhjriaIX04Y349An0reFoAjWa2O37R2R4w+10Ns/IKtIk5307js
 AWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218898; x=1782823698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NxxzS1Ry/8cdZldgWf/p8MR2BUoUQOLrlYZHskkcFmA=;
 b=qbzkLv2yGmSslmTtUts8U9iQcBCaii4QAUZ1uyFK2I/7c/9lFl16Fs+/GOZGBd4i27
 CBCkoTizc254fvaMQkfSxqY+OsoH2pSeOSFqyAEWtnXrdkIhN28LJjSiOFX3SKKel73F
 eRLVFh6vmGVI5Dx7FpfOJY5iNzu41kCvr0sJd7khdibtFonkIafG9men13qqt84maroR
 yd4uNP6i9OLLYVjhAydtBVGmmxSgOVFSSxOEPdeEU45T9GnXRYJWWjbOO/lAWeJar2dt
 ECLz30f152SEN68/zyxpGh608dIrAnzrC/E+UvpcwBPDC9e3nyoe1ezlCXEL/b5GrNWH
 G8Pw==
X-Gm-Message-State: AOJu0Yx2tl/pe3NgmcUSkNa70tKXtqVmTUfFaN6m6xOgKqNsaPBHPBAY
 K8I3nG/varMPTMwtz/0o6inZzOHg/hoKesw5wKtX7erCtWZ04dA5f3eBtQiZIa3g1TIZfyB9WbC
 +dPsWxSkSJYPHnNpKwuxVgIGy/vxBGJ1kP166vttWdtnF5xpYnEj+KdI6c8e1tE0qs09jPbedbI
 UOIW05M1Q7tNVN1y1r6yjie3j4jRgOMvih0mZG9Q==
X-Gm-Gg: AfdE7ck1drrnVyrapB5iUkuBwRkEAEUHQOs3WpqqYO/xyU5EkF2vHrBi2fSgvufjgyO
 ZjaS+QlDq1p8zjTFUPgd9KIX3pdlYeTBRqYWNrnafGbsOCGlvayn/3kWpywNuTf4g/DQTkYc1kQ
 zKWCr+sAi1SjscR85koEJLVljbpTkf3MEfCbI49FgXvJm7Ivbf6PnP/kMBKPtzoQNquRIVRezik
 rQnLcWnkc+GBz3x5P15OKyjUbbSODziZui6v/C4NCd7WSwxoKjr6gb2XwM2/hZ2iIKviuoMn1lz
 2diOF2/f+LGPqWHwVFCDHc5+1HVfl7gHN5nlEmPY5NHX0urM9fcXfip25uJ/6Z95/ssfMOdI5J1
 +2w==
X-Received: by 2002:ac8:5985:0:b0:519:b82d:fe6a with SMTP id
 d75a77b69052e-51a51b6891cmr48599721cf.28.1782218897829; 
 Tue, 23 Jun 2026 05:48:17 -0700 (PDT)
X-Received: by 2002:ac8:5985:0:b0:519:b82d:fe6a with SMTP id
 d75a77b69052e-51a51b6891cmr48598921cf.28.1782218897057; 
 Tue, 23 Jun 2026 05:48:17 -0700 (PDT)
Received: from x1.com ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51a51106a09sm22288351cf.0.2026.06.23.05.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:48:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PULL 01/18] thread-pool: Allow at least 1 thread in
 thread_pool_adjust_max_threads_to_work()
Date: Tue, 23 Jun 2026 08:47:42 -0400
Message-ID: <20260623124759.125399-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623124759.125399-1-peterx@redhat.com>
References: <20260623124759.125399-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

thread_pool_adjust_max_threads_to_work() is supposed to give each task its
own thread by setting the pool max thread count limit accordingly.

However, if there aren't any tasks currently in the pool the pool max
thread count will be set to 0, which will trigger an assertion failure
in thread_pool_set_max_threads() - because setting this value would
completely block the pool by not allowing it to process any submitted
tasks.

This also can happen if a task is submitted via
thread_pool_submit_immediate() to an empty pool but the task completes so
quickly that by the time this function calls
thread_pool_adjust_max_threads_to_work() the pool again has no unfinished
tasks in it.

Quoting from Maciej on reproducing this issue:

  It's difficult to reproduce in most setups.

  My main VFIO live migration setup never hit it for more than a year,
  other similar setup hit it recently 3 times.

  On the other hand, putting sleep(5) in the middle of
  thread_pool_submit_immediate() makes it reproduce nearly always for me.

Fix this by making sure that the pool is allowed to create at least 1
thread.

Fixes: b5aa74968b27 ("thread-pool: Implement generic (non-AIO) pool support")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com
[peterx: added quote into commit message on reproduce details of the issue]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/thread-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 8f8cb38d5c..4e75191c98 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -493,5 +493,5 @@ bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
 {
     QEMU_LOCK_GUARD(&pool->cur_work_lock);
 
-    return thread_pool_set_max_threads(pool, pool->cur_work);
+    return thread_pool_set_max_threads(pool, MAX(pool->cur_work, 1));
 }
-- 
2.54.0


