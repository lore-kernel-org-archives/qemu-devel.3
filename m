Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A00C982DC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Wwb-0000Rm-EX; Fri, 18 Sep 2026 07:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WwZ-0000RO-Gy
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WwX-0001d0-JP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfu1MBXsRmVP1HEFbBooqDFu2xyDHNFt7BQUuf2IFiw=;
 b=ZAGJhbRMOFF1NmfnQR2tEYChj+GLMfx/KgVl+vidi/Xpx5+lmJrTqgaIucK38oY1WygJkq
 Wz0hVZLibMWB8qYg43NM1jXUxbrMJrMeYgxF600HwlPao8ENhwiu/A6C75alun+GT2zAiA
 oHeKtgb9YsK3y8xOCVDLU3SDfQnOa6I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Gs9fzMA8M4iEiGaDW6bE2g-1; Fri, 18 Sep 2026 07:39:47 -0400
X-MC-Unique: Gs9fzMA8M4iEiGaDW6bE2g-1
X-Mimecast-MFC-AGG-ID: Gs9fzMA8M4iEiGaDW6bE2g_1789731587
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-530f65ddee1so12388501cf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731586; x=1790336386; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yfu1MBXsRmVP1HEFbBooqDFu2xyDHNFt7BQUuf2IFiw=;
 b=Ii5gfaJPplqCXWjzp+POKKOsMeCYtPDviYVCOr4oEVsqPt4QZWfxs35vvE0EryTkwl
 DAfgYFCGy1NazDgYLTDMNd24/rZmZou9e+vemBSd8g+o3NGFZUgd5UfTG9NhyeQGMUWb
 +u8vNKzqKLH56Hu45VqEZnwka93XQ/092wv7SydcQua25ZYhGNkB/moVkntaXRUJyV5F
 XgxajDWkma9mquHJyF698LXfVVZ5v4WRS4C8uPOPJn98NVrzfBx1qmrgoy7nPojt1wze
 61z4wsAopRMGnn/mu6zynsE3nZJwvBHlfWRQkmVluwCgdNNXRQit9vLk5ysBUL5UDkAv
 14ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731586; x=1790336386;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yfu1MBXsRmVP1HEFbBooqDFu2xyDHNFt7BQUuf2IFiw=;
 b=decJt2HQzt5dj9Vi6IxZd8g7iEMOzmFDoQJfyGsdG4sG6o9zHEcrVdlzwXWRio5sNz
 6zKHWG4CHah6fjy9eN3EKPSdoTdZjOeBoEzSMeGYoD31MtV5mX1IPZ7jAygzP4qp2yoN
 1L2Y9dVifdPqHsiqTX/iIe56Y4jjYjP7ZxuClV67G7Qb/ijx24dd9LE4aCP2Ernlbd9X
 R40IRV3BvLjgNRaMMKU1tkL2LK4N82RYSG/Cf+cblU2UfT5TorBtFJZe6ZoKcThG04/X
 TuziiY0l5+WbTwwvIyGx1haCBQ8hYOxguQVZbmuAkbPL5B5P8KOpph+gsL95EJhXaFFi
 UKpg==
X-Gm-Message-State: AFuF++kiXN1HzulH36IGK87f4g8HL9F4ha2rK8qtLvhdajXof/J4S80Y
 5R1l22zH3UTwKC/Mzp9mKt5Omzjb6luRXXGcDo1hu28I20g0mtJQxEVbBgvRNCG3HTK5dUpMO9C
 yOiVSiqdmnc7dZIdALInhljr6XIR+PpmGgJKK4uahFKyMLe3V3n0J9Otn2pmn9RIEQgzGutEtH1
 1irctWTuYjN+pO2ZrS11ZP50FqItdPK96LYEj9h1Xu
X-Gm-Gg: AYBFou3VGHUMuWQu0jDkoWHI6VGQKUYi8H4tBPwJsVtfP0nDZhmUGsaSpNL6fnxUl+m
 4Xt76HtDpoxU3kkvC6l5tWwK61X8UbCnR+AH3OkE+wDl8TATCIhh+Qi3rS+NUMc20ZxU89KX8Le
 6M8Gg6Z26uj6lF9mnTfgg9Y63f0TA4Prb+MUISVO5VE2l6V/qbA4VxkwLiic+ex98C+TE2eLlKS
 Tnk7dM+iSMSaQqk2mHFDF/tcufA3jVB0i2vS+xC+L5iulPSr2f3z9rVCDeZ4cMSVJOWHFOfqP31
 3QZDX/KPbyhkj611n5MW9KqdUJE1XxfVmhaKvcx+QkMbfs9Zc4mZ+O5BnuornC48QQzgW3/tc5/
 YafccWHiw92Ott9jb7bw3XD6XMGvGz1x/IzccSPby+zr8yoBH61GD5jN9yC8=
X-Received: by 2002:a05:622a:587:b0:530:ea70:39f8 with SMTP id
 d75a77b69052e-5329e47e893mr32013241cf.40.1789731586556; 
 Fri, 18 Sep 2026 04:39:46 -0700 (PDT)
X-Received: by 2002:a05:622a:587:b0:530:ea70:39f8 with SMTP id
 d75a77b69052e-5329e47e893mr32012811cf.40.1789731586002; 
 Fri, 18 Sep 2026 04:39:46 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532a19f19f1sm11263171cf.22.2026.09.18.04.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:39:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PULL 02/11] hw/vexpress.c: Remove forced cast to u64
Date: Fri, 18 Sep 2026 07:39:17 -0400
Message-ID: <20260918113926.831204-3-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Now since ram_addr_t has switched to u64, remove the forced cast as not
needed.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260818172012.3052821-3-peterx@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/arm/vexpress.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 914cda66d2..a4328ec74b 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -362,16 +362,9 @@ static void a15_daughterboard_init(VexpressMachineState *vms,
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
 
-    {
-        /* We have to use a separate 64 bit variable here to avoid the gcc
-         * "comparison is always false due to limited range of data type"
-         * warning if we are on a host where ram_addr_t is 32 bits.
-         */
-        uint64_t rsz = ram_size;
-        if (rsz > (30ULL * 1024 * 1024 * 1024)) {
-            error_report("vexpress-a15: cannot model more than 30GB RAM");
-            exit(1);
-        }
+    if (ram_size > (30ULL * 1024 * 1024 * 1024)) {
+        error_report("vexpress-a15: cannot model more than 30GB RAM");
+        exit(1);
     }
 
     /* RAM is from 0x80000000 upwards; there is no low-memory alias for it. */
-- 
2.55.0


