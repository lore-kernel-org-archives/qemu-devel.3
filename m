Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA263D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghsl-0002ec-4h; Fri, 16 Jan 2026 06:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghs6-0001yz-7K
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghs4-0006ZA-P1
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:20:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso12977095e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562403; x=1769167203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f7vtYZjTZIbM1emS2SExissy1xMjac0XjSqy3auA5as=;
 b=BuP2e8XU2h3zy30Fzj4Vt2+NN9a6BqCXZ7GtUzp/k+HBfSxBjWDvEHgUDTWYFSXlDz
 sR0RVKx9yQl5rSPubA8XAg0VSWofXIP4Jvpm0yV6MdBayvnL8RyfjcTjEK2Mru7q8U+4
 L08b1uZKmUxo4cnrev8LDzeqb06BeJL8nxQ7UcIFvLlNhpBpmO5YHad7RebK6ECf1KQq
 SZtoU3KW/vWngJlPYMwAEpjdtoMHIOm7ln9wwg0QrC81sSClYU6e4rFI2rabf4rdOLuh
 7IPJFfa004RVQDS82SbidWzWDJK0U4gDsae52xRwfzhJAe4Y/Y6xNbpke8khdmLlqcN3
 xyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562403; x=1769167203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f7vtYZjTZIbM1emS2SExissy1xMjac0XjSqy3auA5as=;
 b=TdjuR4JEk6jOQqvvaPt3xBsewhZ7o0aaLqK+LwM4pHQZh9stDHUlXa/z7g/6rJX53g
 sffMdVB0HZ3UgkyButqe7fdlaMdj6V7YUFxvJvHCblmqGqlyKrssSQBO18/zUPGZsBJd
 tSSHTQ88rHx0BevIhVQuL0LHqZdhMqk5AXAfX4kU56fXxbHyYNArBUjY1K6WOK5mddlI
 vxqMahGPSw2CoZBIseNN2Gq9wcRDsw0C86bAFq2SAdz/T8+Hp9wCewAw3SS1a9BgZZgF
 BMobL81ij2W/45EGAxNbYKo+LpCy8BRpA2ZtFkUSfxXkJIvr2TlyJgb22qjaDRMf+dNj
 sMVA==
X-Gm-Message-State: AOJu0YxZ177Y4DfgVoAgvKdy9Hfe8Kcvv5/VB7iA6rzmMxqSSr7a8L6N
 7yKDBlyArzZ0Ff8gEi9tyygvcbgpOR+KIN5ZNigpDhce9lhxJ3te1GCYibD14JXchZjVnQn2OZ+
 F5ERmJhQ=
X-Gm-Gg: AY/fxX7YMwD96GYMfB5JmOdiZbZ1DMB6/gy7MnqnuqzoWrp3/TjzBQUdq7LyJJPvuNS
 4ZckeUa/5VQHcjYkcvZKyacc4FSMcNk2QuW0BmcZmjjdgbKQV+ByhhcHcK3SobirladPkkdqt3q
 k3d+yiPgv8DIlcn6jLou7G+dBdw2w7JK3DDkpQUG5qUB8PRDa4L22uibV95Au6ep6cBqa35RI+o
 Da4XBw9JFRKbo3kc9Rn/FZUcW96a48ox13XMoKqiSoMrasnWARMm/GYN1fualFgSbITxK2oMDOq
 3e4uVSP53hiwIFTxm9Pvl8KXXra27Ceum0TuFALxy+LOmsquG67NLSnlXBqPnEVrXLlYwD4It2b
 8hfUn9Xk5X77VjqgB0eyt3ngtCMWWrMTdQgdTBiFVOz48OFGpsm+Hc2DcCikIkObOfghc+PNlKe
 Ml9ZamxDtM2ScJoMfLTvR5KyLj4WKrE/JcvA1H9+askywoTK9eLcxzu3HPRiSMXNyX7TkylrE=
X-Received: by 2002:a05:600c:1f12:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4801e34ce8emr29339485e9.30.1768562403023; 
 Fri, 16 Jan 2026 03:20:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428acd0csm93501945e9.6.2026.01.16.03.20.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:20:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/30] accel/hvf: Remove mac_slots
Date: Fri, 16 Jan 2026 12:17:54 +0100
Message-ID: <20260116111807.36053-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This data structure is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-11-philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index dd9ea641ea5..0fbe27dfa26 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -22,15 +22,6 @@
 
 bool hvf_allowed;
 
-struct mac_slot {
-    int present;
-    uint64_t size;
-    uint64_t gpa_start;
-    uint64_t gva;
-};
-
-struct mac_slot mac_slots[32];
-
 const char *hvf_return_string(hv_return_t ret)
 {
     switch (ret) {
-- 
2.52.0


