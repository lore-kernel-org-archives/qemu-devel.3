Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D9CC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Wwu-0000UU-6K; Fri, 18 Sep 2026 07:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wws-0000UD-OA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wwr-0001rB-3e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkBLN6iytHxigslhO22YLF7Mj8QQdsoSIRTOupiudCQ=;
 b=DWarsyvRPrEpCEApSj9vmdgyBRmm7dZ1zOLlXP7kBcKxtCLlAMA1w3Iqm8u3C8Ect0a+jq
 EonFhgtPPRhXlx+WCK+H2iL3vVw8bScS6ZxG8oW15M/GNdyq4TbAtLyP6tVdcO00MzC7fa
 kedIDJvGLRQh8wo0A0b4XlPvV2xT5Lw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-SQWKDgIkN7SFvf4sCEXbFw-1; Fri, 18 Sep 2026 07:40:06 -0400
X-MC-Unique: SQWKDgIkN7SFvf4sCEXbFw-1
X-Mimecast-MFC-AGG-ID: SQWKDgIkN7SFvf4sCEXbFw_1789731605
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52fb8f67601so6854561cf.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731605; x=1790336405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NkBLN6iytHxigslhO22YLF7Mj8QQdsoSIRTOupiudCQ=;
 b=KdswAop+ew0ZiMfCQYw7wBn5q5wWvh+l0Jzlogmms5PX12U85IBMs0D3gjHNYVzhOT
 WALedSYbNm7ZsYSerQZgcfBq0DqkiLN7c9FLvbDDS5VsoNHLuu+ZlfvU5t3EQAJTiAdq
 2W7trcOsk6xe4g5UyBz+zd1usmbTPu/1O3Ojgp6xGPkTr2TEJscwk84++Zk2T91JAt/4
 h7hhOdHtgJtcqVihkQNd8twnilCtyKzIvEypVWJ4L2uWbx1fVuqObY6o8iZL9vLek2uB
 bDpC9jYQw21PQ0VQQZ/5dl9S1r/+Ysh7xt9paUxoAsB3FfBjVYHpWbxl7qIlhq/IScSk
 otkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731605; x=1790336405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NkBLN6iytHxigslhO22YLF7Mj8QQdsoSIRTOupiudCQ=;
 b=szT5EQ2kRDXKEzJNOQ3a27s0/RSEu/Z9lbfPnEOFSeaw4587f1/oBdCOCA6E9++hlo
 kJU9sGFSc3adhFPOB8wHsJDQyShhxLtYXDLGMDtKYJXYM5fF4a0vsZH9haWBgXbheed1
 fj8EiKwbcvAYfXWPft5Tj6I7oT8TDaEENI+M4klWq6PJfa/II0jPqfnPAo+W1vDmJziq
 AUU9CBSskXDmTjarwfhFFRaiU0M5Ttd2rA6tbRfTPIyB6zn/fH8G7q6HO4wvQwbOqe9k
 Dy3atkOn7skb3qFHPKRA1ar/EiMxTFunfaC5vcdzEyW3CtgiyUztbzn3INP2s04EZH5T
 C1Ow==
X-Gm-Message-State: AFuF++kDJAKvseG/9Al5s8cCR0nxDoMabojrHSl2GU8wxGel9IIqhnci
 OHsHFd2T3rNLfXSFsLYjnKA4NE7Tcrvt87ctP5i9bDx12H+uMgOOQg58yG0oZ7lSsO4utqsU7lh
 m22nguRRPclb7FZrVcx4W4geQqb8aJeE8B3zaLVjlxcmJp054PMhRKor6sGOMxfydLEh3ggTn2O
 NUMyvHmivW50NfwynFIPuuDFdqZhXZTBCXtihlA2uI
X-Gm-Gg: AYBFou18CAwR+MN2TvYmVeq9r5l2N7F+acRqZTYhcsfmi+nFFNAjPgjJwCAw5z8GMaF
 0vOVlRe3RGACIxhpCxJr9wbd5TqMugDvV+WKLKJyZJothMxu0Navj2zaoOwYcEqkp4vOvG+PZVj
 IIS0Eb8805T2y7i7u2Ee1YyyHsUxz1eynBcYOKAZB8ujPPWeX6rfS0NJXSNgOgl7BMKn6/dn6AI
 y+MMQKyB1cC7W4xYZijTYFD4OxW8h38QzkF7k9LV2EWDq5o6rgtJxU7F4IBCygyddFTDuHT+Zjq
 aG5Z5NEMayVVYZjhcttyP9UwUNMoACBPmaCY60mOhQ/LKkYl+byefGA/ItcovWn0HZVv3GB1Xjg
 ZPF4mnzwttrg0sbaSBFLdRz8rgrpzf0ohdwWnOnH2pC4aCt5B6PTdGrOuwg4=
X-Received: by 2002:ac8:5dd2:0:b0:531:214b:42b with SMTP id
 d75a77b69052e-5329e48fed1mr32543751cf.40.1789731605365; 
 Fri, 18 Sep 2026 04:40:05 -0700 (PDT)
X-Received: by 2002:ac8:5dd2:0:b0:531:214b:42b with SMTP id
 d75a77b69052e-5329e48fed1mr32543271cf.40.1789731604756; 
 Fri, 18 Sep 2026 04:40:04 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532a19a4fa5sm11367371cf.13.2026.09.18.04.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL 04/11] xen-mapcache: Remove 32bit support
Date: Fri, 18 Sep 2026 07:39:19 -0400
Message-ID: <20260918113926.831204-5-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QEMU has switched to 64bit-only hosts for all system emulations.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260818172012.3052821-5-peterx@redhat.com
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony PERARD <anthony@xenproject.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/xen/xen-mapcache.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 85cf0cf359..e30c07c2ee 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -26,11 +26,7 @@
 #include <xenevtchn.h>
 #include <xengnttab.h>
 
-#if HOST_LONG_BITS == 32
-#  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
-#else
-#  define MCACHE_MAX_SIZE     (1UL<<35) /* 32GB Cap */
-#endif
+#define MCACHE_MAX_SIZE     (1UL << 35) /* 32GB Cap */
 
 /* This is the size of the virtual address space reserve to QEMU that will not
  * be use by MapCache.
@@ -151,11 +147,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
         exit(EXIT_FAILURE);
     }
 
-    if (HOST_LONG_BITS == 32) {
-        bucket_shift = 16;
-    } else {
-        bucket_shift = 20;
-    }
+    bucket_shift = 20;
 
     if (geteuid() == 0) {
         rlimit_as.rlim_cur = RLIM_INFINITY;
-- 
2.55.0


