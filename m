Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7D5C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOC-0008Kd-HP; Wed, 16 Sep 2026 09:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNc-0007E5-Tq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNb-0001Xm-CK
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2dd68a16955so22364995ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564130; x=1790168930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cGXdUEQOC61/qzWZyYSkL07ZmwnJ9LrsaDSe4ilYxYo=;
 b=ZoRpQlQmMrVB8Buk5J4EfA7fQyNRz+J9EWsta2SOUXfgNjvNvexENdvjSyxVy1bciP
 MPV42eIQ9k6AYvPB7sfHFlmLQzP5S5JUOThlj9PIeaoAeFcgUEQJlUwMXmx3a5v7dAeF
 5XCrq+rcF7BKeBLxBCZWu6MsTtgiosl+ztO/w1hDWnfJJYFx2OTgVTS0V5njV4qeReWk
 ISURUE0oX1JJDbqwD1JnG7U7/fnuKSB3HCvd/SFWmLHgvRxAruythfx/5MX2BHkWn9aT
 YDcERbdI19eCIAf2OOUv9ru0AKq6op6WGA1yuHW4C1oOIVDCMETbBBMgCAA8c+u/zTuR
 tH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564130; x=1790168930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cGXdUEQOC61/qzWZyYSkL07ZmwnJ9LrsaDSe4ilYxYo=;
 b=YefL9Nk4oFt+pfVTjCasa3IfbykRqL13Rgl3cthANwR9uOOjq/pPi43d7CyCNNiCBP
 JmWyqPbvkpuyT42NcveCNBm3AaeJbyAhVpuqxc5xH34UDeMOnyqyE4nbR/THqSF5Qg+a
 Wz+rLznMjKyJZD6iIE06DE+yYg0gCQrfeOy0aRCZ07d5EdFC79k/X8fY5KDb2kQfP3P7
 n8BUqAy/rjLr5ltK4pEqaTQsPhk6zhPbTwyDLe0bUsBTAn+11EcKusDa3HsVUHYo2p0N
 I7E3zfWeE3pWUtjqV9OEeHGyCwHMhQee6i2to865qhE2ZW1ty5pRB8e3TBIY21M87dP/
 elWQ==
X-Gm-Message-State: AFuF++lKL5hgWroOk1gpde74pyNRris7hLEaQhN0phg08PLqUUi5tz8S
 0wOZAv+YZhFuJEswEZCmf5wXjWqyeyC8SwJjnWRlajo41Ufp4y1DQkKY9e1LOs6AuGfjrHYpqza
 Bhp3IHk4=
X-Gm-Gg: AYBFou2psZcqk58RhFuVaAz24SJq4XMopKpU0pLaxsFKjBpe978nAA05XRxsX7wuVYB
 Es6ieb7TW6WFdXkfoiBWdW1SEMbmFZewgSP4A6ZjYVTYqzSNT6F/MQROQ8EV0rNPJWJ2uOqI0GF
 MWCFsblLWmzEMibkkGboQmbQKuMukVQnI2+jDmingVJzrhw9MNk/W3Yg0pyOm3FK41BqJIcYzRO
 3vhl+uaJnzabYO1Oh06nzl0zelCewYa3LsrI8Yu0/O5mAB9aTnpq+qWEanIQKbXQu1xZcCt4LiN
 tFy6EmBOtMGCqgEnW+9gYPfEQFxNJS5gEUOpGjUddwcuBnQmW+GKBqcseJBIajLF+xEnMOpITWm
 VmWAHi4TA+ULwRyFRD1tkFbXXIwjUpZRgjD8ly+GjJ0KB4m74iay0H+xa0L7Su5NR4+E6rZA5GK
 m+0zrADNAMsqvYYrs5bFdN384d7TIeAEdM4hZpeavWV23eO8efXsMbVvodm07qoE/yk7fQJQ74J
 Aqf/1U=
X-Received: by 2002:a17:90b:5706:b0:39e:1a96:bbb0 with SMTP id
 98e67ed59e1d1-39e1a96d303mr4992297a91.29.1789564129752; 
 Wed, 16 Sep 2026 06:08:49 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 76/92] tcg: Use smax in abs if available
Date: Wed, 16 Sep 2026 03:03:51 -1000
Message-ID: <20260916130409.3382710-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0993d100f00..335af620dc3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -418,11 +418,16 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
-    int width = tcg_type_size(type) * 8;
 
-    gen_sari(type, tmp, src, width - 1);
-    gen_xor(type, dst, src, tmp);
-    gen_sub(type, dst, dst, tmp);
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_neg(type, tmp, src);
+        gen_smax(type, dst, tmp, src);
+    } else {
+        int width = tcg_type_size(type) * 8;
+        gen_sari(type, tmp, src, width - 1);
+        gen_xor(type, dst, src, tmp);
+        gen_sub(type, dst, dst, tmp);
+    }
     tcg_temp_free_internal(tmp);
 }
 
-- 
2.53.0


