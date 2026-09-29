Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AD0C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7X-0005ws-Ca; Tue, 29 Sep 2026 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7E-0005kt-44
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:36 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7C-0001Qg-0i
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:35 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so33215185e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697092; x=1791301892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRgsZGjFcRabgUhVMnu6mZsS+vJhVWDRtCtPb6hG3D4=;
 b=IyP2BB8/PJezG8YgTAMepURdV7g1VdNa68BluF8c0wb/qbmc41S48Xi7KXS5ZUKiiz
 Nl4ufjannb+6vA3KKvsmHwCP4MmkMWHOQimXhvlUdgPnxnWad7K1n2P6+4CgAsKB65l5
 YHXhPfOVzWITLwVa+4FV6yoriN+6YKnNDvqT13lB54NC2QldL3W+Ee+wKONdlVsbnNWM
 qcYSlUAm6GjBWcZIn6nlpesMHIOaCvyeQJJnR9m7+Gbo/gDmYJiN/DyxAbNQdVBGmLG2
 xDu4u8H5xefTvfFUB5QFRlez0z7rPb8QNQehHSUYF4gr2ENW94sEzPC3jSQloJm5Xl83
 g9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697092; x=1791301892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nRgsZGjFcRabgUhVMnu6mZsS+vJhVWDRtCtPb6hG3D4=;
 b=anj848SW6Q+omtrGRVJcj+62l8KYwYIi3Dv26TlCdrUMEtlTX/Jdp6CifouHisuehv
 lqbOn1flUljxcfdOS/ddwzWHhN+H8RB3Xax2D4TG/VWdk9OyqCDp/jHYTJc8SjKIfYce
 XfB4VBkKTsKvsh4hsUebSJ3Ys8Qg4bggs3uFX/XdPTn0REBymXGJeLsNSIOctBf0T0Nu
 5PTtZRzl9bJMDW/VtKC9fbbjZ90IW9kiFqdeYKliF3rtSvz8lAtozudaUl51kS8ilL0B
 nz6H4Z5UQC2EPVKqZjZJzrupiyFLMHbr2AiCtz8Atg3Ahg0poq2UeWVZzwB0l9EgRgNM
 cucw==
X-Gm-Message-State: AFuF++lS8lykB8FAHC3iLGqffZOFzJUHPHWAEBqdG2Uu1sKiLeJXzHY/
 hTH7EJ3pC4p2f4vhVYSUT4DhICzWwB/SwgSsOH8Z1ARXLgZKub/dbuaNQiMJ1XDko62Rrb0k9CL
 WvHL/
X-Gm-Gg: AYBFou1QvMqNq2xyc/TUWX73vKWBTbohEZqLXd6XAa1Az6xSkCvfzwc5Q99qqH9ewdU
 z/JJYkXmfiw+SZ2ozewy+QaOASb9lUd3UEJa/jBKCdttompuFdT5GFTdulQpkFk3ED3+peb+zFc
 9j1gJk+iZM4O844dU/Fb3YbKdioG9WGp0U0VM3X+h3PeyVnKSW20309CUYNTvQ9Fm3zncREYuTf
 B95grtkwLrgRd18NEDrZ8TGwP8cCFJG5Xp5Uj+8rSxtaoAvLFf9ePda+l7m4Hl9XyBtwRIaMMeP
 keORkp414yo4qcQOFfABnYdH+s0TDWHXutEybWriZ7bTeZZ5pSNcVsbhp+7ftOx4HczqwazWP8e
 WLdIYmnRMHVixD/1Nj4pXYCSj5KSc0aghKU2cQuuCZLHpXVH8188jsgmPy+ETNlIt0S6CHvaOZX
 IzxuKppCY+2cAOrXU7F5kfv4rwQ85s2aILHJ2enh0gM0g0HAjhUGtJ8vvUEQ==
X-Received: by 2002:a05:600c:83c4:b0:49f:c331:39e4 with SMTP id
 5b1f17b1804b1-49fe66ca101mr283651795e9.7.1790697092261; 
 Tue, 29 Sep 2026 08:51:32 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 1/9] block/commit: pass BDRV_WANT_PRECISE to block-status
Date: Tue, 29 Sep 2026 17:51:17 +0200
Message-ID: <20260929155125.3151111-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
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


