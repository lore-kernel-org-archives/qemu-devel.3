Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCD6CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxVy-00076W-ID; Wed, 30 Sep 2026 12:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVS-0006OI-46
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:12 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVP-0003VH-PC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:09 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b042e00f7so409918f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787006; x=1791391806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/ucdW8y7gbahjmT+R0rE/I3juMJxREJdmg4f8wpT3c=;
 b=OHzIEAm6pLQ/MOtZ0rCWQ17GFrZgvVnsZdgc566UjoWYtAswkcMkeOg0olqkuxfvqR
 TwZDQ8B0qnlhCaXGyvs9OtP8X8ARU+plehRSrGOlnJvuTibJzrmQXxtsDh3NcsfcD6ht
 20FMrdrzPHAApSCSTF15TlzN0RnyIMuxeltcl5Ez1eyhZKm+vZ8hh9G1EpltbOZbPFWL
 r7zvx6LzJ1VC4I8cAZNcypYzHkabTi33yTfD1ebNj8ENIMZBaZMzGb572yTvXOn7Nfej
 v+I6p/aiXmoTPdPRJdxbJfo9498hTWSTwvRWAbD9vj021f1VBzq0usVUUfSG/QIbWf/X
 99sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787006; x=1791391806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4/ucdW8y7gbahjmT+R0rE/I3juMJxREJdmg4f8wpT3c=;
 b=hkuR/pG88N1/YgIrEvXtsV63MZ/wa4tb1DZ4S025bFtkvFUUn23F6PE7x69+AFW89j
 Ms7li9Pzltih4k2DWTPj9T9NqOUSSaBm14+WE1uo51h6/5XxDIc+a8cyJlwKAS8r6+O1
 FppLJ5gbS7sbGmJ2PL+HHyQ+Rl9BHbfUFQ0mkNiBQ1HtOJK/q/hi4gdZLpziHP3bLyr/
 v7Zd+VV1ukbRJrPcrGUZ5oFdrFWScI7PMnII8o13N4H2u+I7GdgKnk1dn0e5Jgasw3Dx
 H175X0nqctB85zDhp12+m6/bukKZ7rdvESZvLztiEq20q9y3PSMYwblY6J1HtkwsYz97
 zrlQ==
X-Gm-Message-State: AFuF++l6rvL3c+ZJWK04mQFvA1HYkS4jqVauAsk2GC4ffGM2O/M+VMmS
 n+Za+SR17bzuHRQCDwU3Av/2T9qKtTpzbTK/bG/6E8UiJOzinmWMAWvOiFBTA3Kpds4BhGfwZN1
 2deJK
X-Gm-Gg: AYBFou0KeTHxUZcHzisPgWqsJLcUoycvh34GUswVMWpNicd8vtqJx3+9vF0v+X+Hw1A
 l8olMUk1i+QrcdbJEh/itYARhRxRqYh3OFbKplMwGMPtLm1nC0KBku6CnlXwcOQAQon0F5qK9uS
 Iqa7L1l5lNhYOkwe1c/jdtwIkIvf9KUS/+SMFqmELOeBe5fx5Pxo7qI7brSixteC3s6xcPBoyky
 tFZzXjk33XgdrO4k659YKKKULWpM1SL+5LxIEm7l5gxZLR4Ih+wgJy5qfQ8J2T+kxCWimE3Vac2
 JLCIosZCeypcb34NUFPKbndEIbbkEgSL8j8x5K9LBi8UJanYDU9aVu6J7M5GfQqaruJNk+/R8JH
 Rj0vINqwEfut+lVhUEU9kTTHgGWOwu2jafPmeba3tbcNDuJZziEp1TveAaYNpv71v/6B9tevZLZ
 jsKfe+ADSfMcFNJh/2RxiAX77y6n/o1t46i75hZOWMdTdWTpookJhyGDmMjLjWRLNQQ10=
X-Received: by 2002:a05:600c:3b21:b0:4a0:1a7f:2ab7 with SMTP id
 5b1f17b1804b1-4a01afe1ecemr35372175e9.10.1790787006194; 
 Wed, 30 Sep 2026 09:50:06 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:05 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 02/13] block/preallocate: keep zero_start above written data
Date: Wed, 30 Sep 2026 18:49:48 +0200
Message-ID: <20260930165000.303236-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f; envelope-from=den@openvz.org;
 helo=mail-wr2-x0f.google.com
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

The filter records where the trailing preallocated zeroes begin, and
skips a write zeroes request that starts at or above that point,
because the range is zero already. A plain write below data_end returns
before that bookkeeping, so a write into the zero region leaves the
mark behind it.

The guest then loses an acknowledged write zeroes over the range: it is
skipped as already zero, and the plain write's data stays. Reachable
from qcow2 when a cluster is allocated again after a discard and the
allocating write zeroes straddles data_end.

Move the mark past any write that reaches into the region it covers and
leaves data there. want_merge_zero is what the function already uses to
tell those apart when the write extends the file: a request that writes
zeroes leaves the region zero and the mark where it is.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: qemu-stable@nongnu.org
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/preallocate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/preallocate.c b/block/preallocate.c
index d215bc5d6d..99bd6b1ae7 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -347,6 +347,10 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
         }
     }
 
+    if (!want_merge_zero && s->zero_start >= 0 && end > s->zero_start) {
+        s->zero_start = end;
+    }
+
     if (end <= s->data_end) {
         return false;
     }
-- 
2.53.0


