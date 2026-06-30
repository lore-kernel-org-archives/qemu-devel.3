Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65344C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weU9P-000559-Np; Tue, 30 Jun 2026 04:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weU9N-00054R-Ne
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:49:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weU9M-0005Gg-58
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:49:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49395888c7bso37195255e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782809338; x=1783414138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XvEU0FPin7QB6Q5HnPfo28IjZrKBw4f5C+XqucQQRbI=;
 b=h2vSKShmIq3fg+YInZiLg6+ruYCULUCNpDm5LyDct1P9ndKYciMmIhA+d3f6rGvnqx
 3tjCR/Or62nf7LU4aI7bu9nrdhMXXCbETXqtCozyuqS9ilvkBmjr+8n0jdZIyW1zYRYO
 s2Ohk0FQKycfuaM6BPZS1UFFL2tLwGB4+FUpVrvUaloFbWkYb+MLBp+bpiEzC86cHxJ+
 o4O7FdiokOaQHdWMfZqUPOHMLOP5seOVQC+kisSzGUgrCdtNf1isCk78S+NWiHWjYEwR
 lU6RV2nfwff+8GnFnbKBvHoP1xWTHWvF7Ngfz91uEDLxeokvNcuzMqlWKaVZJP7dUbuq
 NNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782809338; x=1783414138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvEU0FPin7QB6Q5HnPfo28IjZrKBw4f5C+XqucQQRbI=;
 b=WlY1lJ6AVLmMg3IBgIo4GWizm+Fs2qVyx0xOZcHU5vWysWwxOq2G0rKfpff1n8w08z
 dFLJtsTeLkl23FsPb7rAanonYMRNgIlLLK9ZgBI+2uMNpyd6TqSKyx0d/l7V4nnkBAru
 IvqblarRop7T8WT5w038Ozk0kO6R5NUGTkhUnXtOc7hJHFKd+sKyUmGcUcf/pPE4Et2S
 bNqJ8lqX61FnQY1DjfUoQd2ZvAHgagiXq50v/1CF2gTlJeC0Zo557gq8eoNFHcdT9oFa
 QreSgTrqQPZ75WLsWPeIEViC03kbNF4oXoIdsTD7EJPaYJvSH4eneqVzsyUabAP1Cz+k
 k50Q==
X-Gm-Message-State: AOJu0Yxi5U3qFM595pG6/xbLzdJ+1VNpNsZfl9Xh2ISXCzCWATEz1ltS
 dIN1GoK3lFFb3cZ/HnBQ4ULoXLL8i+/y3e5aMuXixwePaPY2D+zJcQ2o78go2R3FXhqiLzfFxgx
 zo6kq
X-Gm-Gg: AfdE7cmHtFcqbFOk5yn3IH39sjEuqX13sCVUph1f1ERhKRKYRXTCCxhmi8vQN71fjSi
 h7jo+f3iK1aCEcSbzWPXoxexyleDxe6b06ZBf913wcc8q8sgmfrUyNjAmyz9/A4gZfqIse8aUq+
 hwZUchzQb/9RIAsvW/swfstznWQzhDIIvfAl9M3wdqGZ3zA/FTejAD/oFHQn1xJZLPITVSm/I2l
 GmoXr59ZOw86vTYM1v0L2wcvX0vvRRQ7H6gvEhQMUvEeiEz/VaPVd1CqB0KQJG5eAydSXjg9AMc
 4lPySqUmdE1QvrrTdfYmca2tzP9oNFbYiH6lR8xSEe7d6nuh8gMJQwEe0kin4xZN4Vb+xJvlPxI
 vPl348K9mOK6h+niW1bH6cPAu2pYi4dp+UJEdAKCyqCeZc0ZOEriF9d3lZxDHt2FLUuwE/Kr+mU
 pnpFFU7zKNDRbqAUjMCE0dQF6d3HdJX5mnlNwub9jEgw+u+t+8OWqpz5GvR0izsPPZSybw/Wj/g
 uySKwKGWD5nd4aqI0xDPWsZT2L7jUeX
X-Received: by 2002:a05:600c:4e8b:b0:493:b84f:9c28 with SMTP id
 5b1f17b1804b1-493b84f9ccemr38881175e9.4.1782809338351; 
 Tue, 30 Jun 2026 01:48:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bc7c91d1sm11550665e9.0.2026.06.30.01.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:48:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH] hw/hyperv: Avoid crash if hyperv_find_cpu() passed invalid
 vp_index
Date: Tue, 30 Jun 2026 09:48:55 +0100
Message-ID: <20260630084855.2319838-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The hyperv_find_cpu() function finds a CPU from a CPU index; this is
basically a wrapper around qemu_get_cpu().  It is allowed to fail, in
which case it returns NULL, which its caller handles.  However, it
includes an assertion check which accidentally assumes the CPU
pointer is non-NULL.

We could assert only if cs != NULL, but the assertion here is not
doing anything interesting -- hyperv_vp_index() is a trivial wrapper
returning cs->cpu_index, so this is effectively asserting that
qemu_get_cpu() did what it claims to do, i.e.  returned us the CPU
matching the index we gave it.  qemu_get_cpu() is a simple "iterate
through list and find matching CPU" which is unlikely to be buggy,
and we don't feel the need to sanity-check it in any of our other
many uses of it.  Drop the assertion entirely.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3568
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Checked only with make check / check-functional...
---
 hw/hyperv/hyperv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 4d90032785..900ff80213 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -237,9 +237,7 @@ struct HvSintRoute {
 
 static CPUState *hyperv_find_vcpu(uint32_t vp_index)
 {
-    CPUState *cs = qemu_get_cpu(vp_index);
-    assert(hyperv_vp_index(cs) == vp_index);
-    return cs;
+    return qemu_get_cpu(vp_index);
 }
 
 /*
-- 
2.43.0


