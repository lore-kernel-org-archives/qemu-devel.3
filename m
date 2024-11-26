Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196CCD6552D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxR-0007OJ-HD; Tue, 26 Nov 2024 12:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxP-0007Ij-Ch
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:35 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxN-00020n-LA
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:35 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38242abf421so3900202f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640551; x=1733245351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L2iIthzQ3Mqn0qPR+9i7K6uncY9n1uibxmIy4im4uGk=;
 b=eymfbaZxA2Lxx/40e2IviQuh/5HR1CupDENwLxulJoT/NhcmGQxeQ1idA5iG1AYw8l
 xrBw3zdJ6bdJCvnadezIIFTGakLDRKY+K6Fe2Zx86S4Zkv+OAm5u6LtiYLn6ICSlQnFr
 G7xS5HkwTN6U1mOHeEzEubpMQmm3xwlwWDLMSq6Ycsk4wLN6tqD2i1Szo9oz8r0/6JWT
 Y0g3z33acfgdM1dqfdvkBnpasfBKZAt4HFt5pUerxW0dQ317ec3DhF1EkcFobNpUUv0m
 ou82ydMMSjcrMwrVd92ngy5MpQYsouvJYgD8MDVM72Hx3+DOfn0AKsKmpPgeymgQvvl/
 TR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640551; x=1733245351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2iIthzQ3Mqn0qPR+9i7K6uncY9n1uibxmIy4im4uGk=;
 b=gCFbqYWPfwD6FNUN8vJG7x49woKoDR0JgRcmOpER9sw+DQGeDiyNyEr37OVXD8hzCU
 VVgZC0xvnPw8xHI42lQQ8ynI5OrqZsyesod/nxYYImdYXmlXi5r5bTYKJgXQSngirMvr
 W8nAXv8C3q/NVo+7KtEKAHT15535Cg+K64eXOztj9Y1Pgvu9myKyXPNjPilQtZmJyp6k
 vRh333kc1f68KIuYbAA+TgZVOzhIiGQ2Rc6/rL3AnvTsVs2j6UDbyA4+plE8f9kXbT3B
 6JIzuC7VvGXTOZ1jfhsP5lA2aGqBHFrzmYf0du7brhK/1t4bRuX9kfYZ5kSjgLyw+AjG
 iKDg==
X-Gm-Message-State: AOJu0YzB5+XAsmwBhwjM3qwuMdvr8r+Z+19bCfgpJ4ZXTKWHwadK7c0R
 ChNXrsfFFEpOCS71JWxQIyg90k1/A4WsyhB+IYs+aygQ+242/Tk2rZG+Iqy0SmR/OIn7mQ++W8T
 7
X-Gm-Gg: ASbGncsNAh/j8cnokMKN353TmRGR4bouGt+vowafRN3L+ATFqZHziH953/g7uBt7Sv8
 c38fa0NlVcd+GtR3+6sSw5GoGo38WIHHtN9qsJFEbtwQm3tzviAmvQS8qCnz9WPdiV6y+vg4nWb
 tc9Yb7e6Uf1tYGWsJfNn3aIG9fJ/WiOSpvRUj1EPlvF7VlfZBbq9dOtlrUxFc2/VUfnr1sS3QHm
 oWe7TDIeoAHCP0xP/1MYQTMJ3eaf9ysGo1ouNEpT3NA84Y9QM6/QxtA
X-Google-Smtp-Source: AGHT+IGNkxLq+Rc9juj3VQc8mjA7i1ZhvZ4GgfOGjFh+KFkRk3JhCeso9+JCt5JTPk8SM/d+0UuXeQ==
X-Received: by 2002:a05:6000:184e:b0:382:2242:7a8 with SMTP id
 ffacd0b85a97d-38260bcb00cmr14390861f8f.40.1732640551123; 
 Tue, 26 Nov 2024 09:02:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] docs/system/arm/emulation: add FEAT_SSBS2
Date: Tue, 26 Nov 2024 17:02:19 +0000
Message-Id: <20241126170224.2926917-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We implemented this at the same times as FEAT_SSBS, but forgot
to list it in the documentation.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241122225049.1617774-4-pierrick.bouvier@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: improve commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index af613b9c8b8..50d0250b1eb 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -137,6 +137,7 @@ the following architecture extensions:
 - FEAT_SVE2 (Scalable Vector Extension version 2)
 - FEAT_SPECRES (Speculation restriction instructions)
 - FEAT_SSBS (Speculative Store Bypass Safe)
+- FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
 - FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
 - FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
 - FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)
-- 
2.34.1


