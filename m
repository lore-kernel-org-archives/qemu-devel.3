Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9297C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683d-0002en-Nw; Mon, 14 Sep 2026 10:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683H-0002bt-Rr
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:00 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683E-0005kN-Eq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:52:58 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so11019295e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397575; x=1790002375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRgsZGjFcRabgUhVMnu6mZsS+vJhVWDRtCtPb6hG3D4=;
 b=nXGqG2SiQ1wSpauXC+8fNft9d/j/IWjQPQ0YuZAk5P7E1b1No39MHsMPQHLq0CW19Y
 YVj3UZmr86eBGmJt3NGEAxLQ/zhXWQV4ZZ7gB52kN4tIhZUU9S44A7KTJKk6nG1+YzGi
 qE12nQtXc4ZEPJ5RsdWgH/1pOy8JSI4tl4EDZZs1OxQhCKwSK/FCDP0LzlSd0koQ908u
 qEzDGCPTvC8uhcmzmd1FzJCYmZx8nG/0H8jmAlfUT7HgSHUIq5kc3y7bZCnjD4biHB0S
 bRiuRcYT1UoLERpHRIwYJcxFCEpPH/UPTIvEDzq751T7qDQiGiQGhIrCMg6+UR4sjM8W
 OJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397575; x=1790002375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nRgsZGjFcRabgUhVMnu6mZsS+vJhVWDRtCtPb6hG3D4=;
 b=QgPRSKGh67eQIrH1rZV3+1Tdd8C2Mrhj+sU5Sk8zLBfNrsqCrWJy5+UcA7GVdchaSD
 dXfMtYNybD9Zbd5oBH8hwSvRRMpWrS3RTs918bIj2Pz40EVIihV1gppu+IxddCjgbPXx
 rT0vB9uqYkzNNERZfkVrI9Svl4j3BmJnAgq+1rvX/wcG8Kt4zALuYrpaq5+aTEnEB8cS
 vmEMxFUXj8Fuo2659mJGf5i6rsnz2+ah1nZB04tghMFPWbyvVkD7bCgJk2VL68iVmmSf
 TUWdod+eU+vYS/Tbfv+Pa+odWBJB8Ac5asVuQISpGF5Sb50TEhM4owIKc69TC/xDvHnb
 CIRQ==
X-Gm-Message-State: AFuF++mdQz7l/20+fVMYv1ZWd0h0ZzyaSP3QfMqGH192S7UUDcrc0M/5
 znKLIB1s7SHu7CVVp5CcP7SJ3F3kzPg3mLTSQ0/UjDadT2zGu3jOcONfF6F+4JpQs+l6A4sDSe3
 jaTF3
X-Gm-Gg: AYBFou0AHzqyD55/tiba6cKtEWrxIACEkCLEgYSzpuFrbBxS67vLo2Hm/P0mzA5OKgn
 sG5sc1OS8ttNY+a8wDWW4CJ+Z1l4dmAum+LLjTRtquCoRQ7psxDFop7VpevhMGYpvdHHRbL1HPR
 DnJMzVftDT3Sbf+veyR2XDqghgojC2J+wz4o4H+uzyJZuFfHTSQcs33CcxSKC6DT3ECHzHb3pJP
 mZ7Ze5r8z5Jppv908kGd9uN+kPRejob1AwoXmLjK9v4jMNynNLr0x/IQ5bBFojUAnt8bo0ZVC8K
 fhmnPs4MMq/hcsucNI62edRX9Ipi3Kjh9/6qiNCgaUrjrZVRprSe20zOKfofMTcBsk1dS5trKVT
 lX64OXYgmVBZhjQfh4dVmCOquqkK6+X/UYuKv8/vncHU1TblNlLef891YpGgKvj/h5OSQIsklg6
 PlZYH8ah39J4EzRKTNA+7Q1ztGm79CTHjrtIymj2XrqyPp2faKzTk5+hrqzZhRUNrxlKi1
X-Received: by 2002:a05:600c:8012:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49e7a67c769mr36701575e9.31.1789397574858; 
 Mon, 14 Sep 2026 07:52:54 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:52:54 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 1/9] block/commit: pass BDRV_WANT_PRECISE to block-status
Date: Mon, 14 Sep 2026 16:52:42 +0200
Message-ID: <20260914145250.2792879-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

c33159dec790 replaced the want_zero bool with a bitmask of BDRV_WANT_*
flags. block/commit.c was missed and still passes "true", which is
BDRV_BLOCK_DATA, not BDRV_WANT_PRECISE. Convert it like the other
callers.

Fixes: c33159dec790 ("block: Expand block status mode from bool to flags")
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 2d52c39594..4e0b0f9029 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -140,8 +140,8 @@ commit_iteration(CommitBlockJob *s, int64_t offset,
     /* Copy if allocated above the base */
     WITH_GRAPH_RDLOCK_GUARD() {
         ret = bdrv_co_common_block_status_above(blk_bs(s->top),
-            s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
-            &bytes, NULL, NULL, NULL);
+            s->base_overlay, true, BDRV_WANT_PRECISE, offset,
+            COMMIT_BUFFER_SIZE, &bytes, NULL, NULL, NULL);
     }
 
     trace_commit_one_iteration(s, offset, bytes, ret);
-- 
2.53.0


