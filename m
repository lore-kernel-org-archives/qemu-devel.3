Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4365C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDqD-0001Te-Hz; Fri, 24 Jul 2026 07:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnDqB-0001SR-JA
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:13:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wnDq9-0001lT-AY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 07:13:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso1967255e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784891596; x=1785496396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QSz9ULdBhCoTeM0qoNiUS/2WEzeqnZtRmE889KhJ2pc=;
 b=t3Bi/phtXkRmBzqX/DvIal3j6aK4res6N1QGSoLz6YoGjgLFbtzzbG4Eh7+u7s0fHU
 A2TZ1PNU99Q4Z40evrVkrpVfXW6BRh3Cf9EqRqcnXfRgxKreuHzeQ6t8fR8qDQJfxYji
 ZGZ394CsXUhf4wnDNwu2m4rz25o8PJZuEGj00zrQiVu67ruxUfFvsdXTDZjXVi/s6RCu
 kjayRiPnZRop3C6ilNkWk08ifCcXJGh73cl8eL4BEQ2fUibday6Vfo3aFWBtV3IrfIcA
 NLFDzWqBFNK0WeFnYCs424VSvUcgPMqDY7z9BG5ObIrRloAQHtedxb3BuIY0G+PEJLhZ
 VNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784891596; x=1785496396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QSz9ULdBhCoTeM0qoNiUS/2WEzeqnZtRmE889KhJ2pc=;
 b=bA1B8Z9qDVmQmPna0y9A/wnpr1zzp9O7ndPv9Sntiil5hnNSUStZcIzR+JF6cKJrIp
 mCy4pjjopQ8SlK++bDXiS9PwQHuF1yx085BR3Ozu3iCKwtH9HvCqcLulHb2Wf954x8Z2
 HuD0YqVWwCaMOm+xLjuevCdRbRE2nju0nnfCfliGFotVh1kFQeKSptaqTyg70PBp+Hf8
 5T9Bo72x8CRJFM3ryqbsFLrhyecvE5atceEb0klXtO6/le5Wdy+kfEOs7udWRxVMgS4w
 EnJHIEKmqNz5XL3VbDk+1gCGr0Bsuf+PGuTbrdyryiUhVqp5eMaa7mhAGUv+8O9fKStM
 anow==
X-Forwarded-Encrypted: i=1;
 AHgh+RroQUIY6WRCpbwmv8P1b9/BPQDGhedwplhk4nRtmBYvepa/8oCMYfCjYUaLyuoVpGaIkejLlB/SILgr@nongnu.org
X-Gm-Message-State: AOJu0Yzn9mJr5xuEMMoNP9CXil3fM01eOFDz5CLwItDggMWFWJ0yjdKf
 CNJ8WKSx2gPgWXjHlHp7l3XXnZ3DVQpi70zxVCTxfj2djEoBWA3orZKl8kBvhwnphWE=
X-Gm-Gg: AR+sD13D0tTr+ZGSqDyAsO2atFC3ZN7jnnzqJVwrKbC+GJ++ZqnA5asNtGNz8Fi8Mxh
 R61+0xY5bN40LaiMHfV3O7A3wvFSBkTmao074Pvw62361OSwytiLkdplIoWkpoWDGKfnz8PcsKn
 UHxSvcl+W0esICi+Ul8zVBE6eovtz/A6GavY+zm6mBkkPcBm0iByOAbI/wDtHcEzB9DLTB3OgSB
 7DDQJ45nW22BPPH/UwB6g3teVB/CaTJ1bDT5idELNv35J8iDkOFMuOQMac0rrga7IcO3IgLU2DO
 +nAakErdX4qqxQWvk/cbYxcCMLHxzn7f+aMI6Q0vP3CUae12LDmDrsSioeavxAdlODwbSFNdZrt
 oAw1uWy9dwxwStlUD7+NMo4Ha+Nb5/ITFjdYbgpAciejoFp6yy1SEYfqYpSqAg42vlN9t2f12bh
 I=
X-Received: by 2002:a05:600c:6b6a:b0:495:3f0f:d515 with SMTP id
 5b1f17b1804b1-49573cf4d25mr57614815e9.36.1784891595808; 
 Fri, 24 Jul 2026 04:13:15 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f7d:7b60:9d07:3a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm23792473f8f.19.2026.07.24.04.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:13:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 1/3] block/accounting: take stats->lock in latency
 histogram setters
Date: Fri, 24 Jul 2026 13:13:09 +0200
Message-ID: <20260724111311.4086859-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724111311.4086859-1-den@openvz.org>
References: <20260724111311.4086859-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O. The result
is usual use-after-free and qemu crash.

Take stats->lock in both setters, matching the lock already held by
the reader.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/accounting.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/accounting.c b/block/accounting.c
index f00fe99740..6e06c7609e 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -194,6 +194,8 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
         return -EINVAL;
     }
 
+    qemu_mutex_lock(&stats->lock);
+
     hist->nbins = new_nbins;
     g_free(hist->boundaries);
     hist->boundaries = g_new(uint64_t, hist->nbins - 1);
@@ -206,6 +208,8 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
     g_free(hist->bins);
     hist->bins = g_new0(uint64_t, hist->nbins);
 
+    qemu_mutex_unlock(&stats->lock);
+
     return 0;
 }
 
@@ -213,12 +217,16 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
 {
     int i;
 
+    qemu_mutex_lock(&stats->lock);
+
     for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
         BlockLatencyHistogram *hist = &stats->latency_histogram[i];
         g_free(hist->bins);
         g_free(hist->boundaries);
         memset(hist, 0, sizeof(*hist));
     }
+
+    qemu_mutex_unlock(&stats->lock);
 }
 
 static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
-- 
2.53.0


