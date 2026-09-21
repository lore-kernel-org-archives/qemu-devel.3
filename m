Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99604C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8Y-0002Q7-7U; Mon, 21 Sep 2026 06:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8W-0002PJ-DG
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:36 -0400
Received: from mail-oi2-x1b.google.com ([2607:f8b0:4864:32::1b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8U-0002fC-QY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:36 -0400
Received: by mail-oi2-x1b.google.com with SMTP id
 46e09a7af769-7f4f0d37dccso1480811a34.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986033; x=1790590833;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UYe6sBnG4kIobRX7QWTzvfr4slonQK5LIp21zrSiRdY=;
 b=MLAk3OThmUjuHmoTfTkPrbo0xjIWf9ihUzcmcoxarOxXojsh8fruc3BvgZzMWYZ1T+
 t6RAW1R4D4t5yyNAx5DDJoZtBD1Cbg4RcbJFmwvkRJ3Nr+OCHD85oWcp4eBOIvdMcUdQ
 7FMwt4Z5hQ7CpbG8rhrfc9G8rr0OnzsmSR8TZrHOpT783xId+C5GNKdGmHfGhvfyts5o
 KAmUD7XaPnAkp7/d+scpsDnzVq83qHFuM+hByrvVM1DLnJNzpvkQJTKfQzrfQUAa81RO
 Z727H/6qiAIUAZN3A7XmlFQYDQrMKmqlKlXPs4Y1YFUSD42Qa/+zqCw1HFAsrbuQFwYH
 DPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986033; x=1790590833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UYe6sBnG4kIobRX7QWTzvfr4slonQK5LIp21zrSiRdY=;
 b=bj+p6n3H6g9/K+XAn7mpjunSoTfmhyX5mkuGGX8I4TFNy65P0eNWVycvCcR2nbE2a0
 ySl7WabuKCIfaS3u5IhM3MrbOSxQLhzMyk4Y+YX/0NvjUZ63hegtDcklC29XJRZRURzd
 xoVwTprEiVYkH5mC+fSgdSujv3bdHUbnzW+4o2Px3sFjSqOnUIwWOIr88dSJE268guk/
 nfQEIET/WVru3sRsYG69cO7b3DzFF1DMJZVbeoVDdlsARjOfjlztTvwvagV11xp6vxf4
 voWfLdmvlxa/lE41qTnTtP87nlCi9CQcCjr1u/k4SCr6css13KG3WOZJpn79Sk3cESB0
 4UBw==
X-Gm-Message-State: AFuF++lbX1yNPTDXbPKn2tZXuZvg7litEbhu9cktE/qXbrwUCMEfPE2U
 k4khSvVZBrlsuugBllwFMRgeml8EU16W0nSHfpFDWZiaKsraFR9Pl6Capky6s4wJap8=
X-Gm-Gg: AYBFou2ZGyF+pps9gsmE/gwB6a6D0xFCCZ14b7bVUUwHmA881ijw6TtTmp85JrIZUZC
 sskzITttLYZsV2COMkOkBKWR41CE0zCHOYIs4fBBsPuZYVPevjGRvFW/FoOeIYtdW9GUqChLbRt
 VZwiWA0VgqXqUMKKzegeeDWJ9r1hqK+ogQuIujSPI8eV7TjLz1TEtncPPSKd59uTjy7tI1x4iFE
 W3gGlfrJBuApnu28quPVhEvJabDIScbej8xhMzGghhmaYtpIQBDTgcU7LZs7IgOAUGAlMzXBtMr
 iziu4dzSerWCW5TW3rd+LeSzzpNLtMe0JyJuL/LEmrliC+Vy8Md3wp+ALHVltRgnLpw/O6jJ2eC
 CbRol7VZF7Wg25A/OssUrzco7n0Fj3aYBk57pzi5WWklDbCQq7/6GpG8QPkXkRGB/KdmxrhffGu
 fYfWk1iR0zsWP1B+InUtztm6PxPwyFdYcfsH/Z0SHlDZrihl/rDSwq48GI9g==
X-Received: by 2002:a05:6830:2a87:b0:805:2785:fad5 with SMTP id
 46e09a7af769-80de32ee435mr12452633a34.27.1789986033537; 
 Mon, 21 Sep 2026 03:20:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:45 -0600
Subject: [PATCH v2 03/11] bsd-user: Flag shared memory as needing atomics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-3-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=R1d7F7J68W20Y/SivRrAonnLdqR7jMMfGp76nrz6DGM=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTdR/zrCIJBeQnrGIcyUhy2CiDd/szFO55i2
 S4sMe/uSCqJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCMcxAAk4HOeh0LT6Lk+yt76PCxQDo1+DO9uZV
 SDaZAWMdgrspSt1As2E34rzjMdJBhX/9Zt3dUkhFlJ1kF41P4UxjXg7SbTDJHO8jx7Of67goWfX
 RDq/PklLhjjaBhh0ejIhunSak3KNwYkWJyu4tdLH1EdYllTnd6aiMqo8fdtW8Ln81kY8GPCCDZF
 xj3YPJJAX0+P/7k7L/Kgygq9538hyD8okgPAA8a9A1ERm/GXGNKxfd7n8BYksheglM/4XTVtxEB
 W4dHz5xnsQzo3kzS9upbO54kqu1GX2npu1ecr3Nx3LLusqI/EILboe4Emjaq/Ft2fXXGPbuhQgt
 z2wROoncbl5Nobh677bVoF4np2pejokuLIgELGdTrxhe19Lhvj6Gn7838ZQbAugvqC4MqCrIjBQ
 XTZ9ZD3IL+Jz5dqsi+0E0WGY5CA3QztDbuIVHx4cO//KgmCT8IajjKv81uF4u38GRghPiTO3TSJ
 73SjSpiRmLFodOOzMDnL5RQl+me/rgNVb755qDtyeZGJWnDsS02h5Ze73i+2tksUypG9Ii+YKbw
 ZvyKDYFimtJZTP0VoMoCcOnLsffQ97ywJ+RFSIT9aC1Th2dL3kejTrIEra2LosHPjkxTJueBDTT
 KKnL6GuR9g9I5Yft8dBQhLspkPjyGiks0djRWdFFwB4YYjkMGXG8=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::1b;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x1b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Catch up with linux-user 228168cbb7c:
    Signal the translator to use host atomic instructions for
    guest operations, insofar as it is possible.  This is the
    best we can do to allow the guest to interact atomically
    with other processes.

as well as subsequent tweaks and adjustmentst for bsd-user's code
structure (we don't have one exit path linux-user does and could frankly
stand to resturcture a bit to match the evolved code in linux-user). On
non-private mmap(2) sharing and all successful shmat(2) calls we tell
tcg that we're in a parallel context, which changes how it does atomics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h | 8 ++++++++
 bsd-user/mmap.c    | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 3086143d40..65270e2cdf 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -389,6 +389,14 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
         }
     }
 
+    /*
+     * We're mapping shared memory, so ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    begin_parallel_context(thread_cpu);
+
     return raddr;
 }
 
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index fe77eceb48..548b4824df 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -662,6 +662,15 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     printf("\n");
 #endif
     mmap_unlock();
+    /*
+     * If we're mapping shared memory, ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if ((flags & MAP_TYPE) != MAP_PRIVATE) {
+        begin_parallel_context(thread_cpu);
+    }
     return start;
 fail:
     mmap_unlock();

-- 
2.55.0


