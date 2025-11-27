Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D2CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfes-00034L-Bs; Thu, 27 Nov 2025 12:19:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOfeq-000338-78
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:19:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vOfeo-0007qm-NJ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:19:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso9965615e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764263988; x=1764868788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dH/WmXxDkaW1X/U92TNSkTsfDOBPux2I9nEYPHlncEE=;
 b=DQvQF3+9XzMaWuXX7Fq5zaRBcmKNlvVQTt7PJgD72M80tJeAvyV17TsV6r0KD/mUYm
 1DB6yMbGxAuoXCpdZv+Rn04MpEin6Cvg3HKnkkXXXQXtrb6qab9CnP8E56MKgqePbqdT
 1s74IFSMC1/JcKMyTok6iok/CiDN/gVIbTaxIeuCpKnwRKT3v5mU3mDAvDsTzuhuwzvt
 KDOXPmupdVw44fP+4FjI9uJPUx29sYiWYxi8c0WM9t0n7wU2e2hFh1fbE5ncx5OIPOut
 fZsT7K8TrPue8BoG6zEZzrLZbnhCtetLv4shm5Zo55sMqrfyx3WCab8P8ZzEh71UufxP
 cmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764263988; x=1764868788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dH/WmXxDkaW1X/U92TNSkTsfDOBPux2I9nEYPHlncEE=;
 b=FwHMJoeDxu/0xU4LCkBvZQWlycFS17ZIG6BDHOQ3QVud9x0qtQL5xZvvsG9UDPvYFj
 90HmE+13VFJzgd5PjvQ5GPff6BmLAU9a8Q/IVXXnelrn7yYIVHgNaFibcEeQOAj/qEjX
 wm7cgNPqFwCJZC2Vn3ynDqRqWarEK618Onb9DtStetExiTAOk8DzCte7Nc2sTo0hsPHX
 4yg6QDALlMm0u+vrlT/kVZ2y8C2ZPzj4+5gQ6pPfvXlP/o0E5KIURtxohrwuDoqJpFkw
 HNenAbvfGOWhcrPH5SJeukjR3fJ54VOQZYMnJl8b3GszXFn14Nim2n/BHQDB0Mo9nZa4
 uPtQ==
X-Gm-Message-State: AOJu0YzKaNSUOyna+kV6JnAhL/jjkhCgcQs/voUlMVPZjkn98B85Gt7D
 Yn9qvoBIpJ0Qc/yObjJXTxU2QkkkyZwlJ28iL9V0Ji5dWpIabBKtZFfmZb/orwithj0=
X-Gm-Gg: ASbGncv+hpzFTSes65Uf0wzmiDkxA2azriZxffY4xW+YRVZQZWRofMjaN0dIr8CESrE
 N8Pdluzmodtb1sRZqBI++IMzs9fYfn9Oaadtu4jDmm/gbdqlc/8IMNMUlXHODqpByf8UMeL1Wsf
 +DFyD+h3Jp0OuriSaTl72/PHmgkWztaK2li1W+efoY9gYsG89/WWRS3h91Efhx0gQjSreofkNOl
 ZKS5w09lp45HY66K5TlvbVDkDArsXJXCjV/BC+Cp/5GMKQAoMMNE2lW/LTMoWFHW8VUU/xnMWED
 O63AzsUFHiKk9oDRbfxMlWPbeQKQ92H8hf8Oq77JDJVkn102b5zylXKwJ9cQLnTtg8yQbt5NM4K
 4cDzp0byuKuXYXV6Zv4sut5lfpl0gVPXS9C72FW/29MK3YR2XxLX1paL1nFsQIbR/6WCwuZrlT2
 jmpe03xZPNTjAx4gfvggsbUA==
X-Google-Smtp-Source: AGHT+IGsmO+kqLzirk+Pi2ETUUen+GUTuE4zkzepoajpxAot2Q9ZaX/f7K1s4KLMFpdntcbnlI14gg==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id
 5b1f17b1804b1-477c01ee405mr251605425e9.26.1764263988398; 
 Thu, 27 Nov 2025 09:19:48 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add608bsm108541775e9.5.2025.11.27.09.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 09:19:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 069E65F807;
 Thu, 27 Nov 2025 17:19:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [RFC PATCH] target/ppc: don't overflow SR lookup with 64 bit vaddr
Date: Thu, 27 Nov 2025 17:19:43 +0000
Message-ID: <20251127171943.3241635-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

One of the side effects of making vaddr always 64 bits is there are
places where we assume it is sized to the guest. As a result a simple
shift might bring in extra bits.

Using extract32 stops the crash in:

  ./pyvenv/bin/meson test qtest-ppc/prom-env-test

with TCI enabled but the test still hangs.

Over to you PPC maintainers ;-)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/mmu-hash32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 8b980a5aa90..ce9c86ceacd 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -342,7 +342,7 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     }
 
     /* 3. Look up the Segment Register */
-    sr = env->sr[eaddr >> 28];
+    sr = env->sr[extract32(eaddr, 28, 4)];
 
     /* 4. Handle direct store segments */
     if (sr & SR32_T) {
-- 
2.47.3


