Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB44C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJMI-0002Nf-Hl; Mon, 13 Jul 2026 12:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLu-0001yI-Gl
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLs-0008WO-0j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493f2e39e81so12997695e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959470; x=1784564270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=12ueNuGGre9LljejKgdqvwtaIl4TrORguIiMgP4ZRtc=;
 b=N11V/J3ho1houpK7PDI7Tz59VpydHjzxfgig9ZEw9Olw08hLQBHCtcF5Xon77AjP+b
 8pri7Kc8Ge7A5Piap51tbV1sJKF+OrONs20eAz1++vi91OMWgs4bEq5xBLd9my45x8Z8
 lWRQCrX5mR9yLO+xldeHBxzY5rjVZj51GEFW1q+u/cDQKQ6adAxlKJCF7dF6abBPux0S
 yo6kxyiQl7gZ/A9l19/rd8ewGQgRGgey2AwTadnt4R08TLtlXLKJ4/5Ei/WU/L2bWoMJ
 snlFRsjn1LmxYALsM4YjjJJZJqldfM/ZPrc7z8U1/izUE1vOdXZ0RFwycA/Q3gb9sq2F
 Kl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959470; x=1784564270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=12ueNuGGre9LljejKgdqvwtaIl4TrORguIiMgP4ZRtc=;
 b=Auusa6YEt0lmE8UA/pOkyn+j+zEiJmXlTJzGfysZrcSrTnEFvWtjd8++RK8zc/aAUS
 lGMmbcFdRwIkMnq++dbYGR7/BqPF5AqarhvfeYPBNq7eADHsEGmVdTJC+pEn1bUywrS/
 ilC2qekC1vrYCAZy0CKbQeAQJFJ/hfhOHS/OzGakWNotpoud/dgE61kveLkBPf2WT2pd
 jss4zyYf5rUAIJpYczyHFUTPkwIWZau97SLMsXx0k3ENxXOmGtJcJLfW2f9mRjSv8K07
 7YY9k0alzVBvR4970dBMVaNtZpWe31uQhPyFsybYfuRoG+3g+4vzztn5tftfrF29/6Xk
 xEHw==
X-Gm-Message-State: AOJu0YxV6HpgQ/0xrAASD0/0QhqmI1LGfNLwFUqkxhTz3gZgyBrC/Uv0
 +2NtzdIYlr3KV8+Wuuk5iSoypiSOV/NEkhXOBTBNC7/edwbjIx3iiSmQymzN+2Lpv1llAR6STtb
 URPNnYZw=
X-Gm-Gg: AfdE7clADv0m8y0kAWkUn5zMxHCWs2UgJvSGzRM0/S/Km7y7SXXCNyIwXIPmSxib0Oo
 +dYAw9KJVv8qkNT1mbRPWBPXqXJKHz3LKpwEgY1HWXc+iuPAr6qhf+4N93oQ2MDafSVnn8Gce9J
 R69A4LOqlpKOq1ezclEQ0PjK3g3LN9J4hEmnfhFh5V0gMNYYPpOD5WCWBPg9zWB2MJ79DxQ4y4n
 L3066FXcRnX85LIT5XxifcgceRJIPe8PjgisLnSF6VYhjkHMG+nf9erzpQMRPhNLYVch2vcnvCy
 2iLvQNEyxe4N6gJfbaiQVzq8j7BWNethGF3IyQt36gK1Bx1oG4ag4K6eVItPavc9+rhiDyFspET
 j51ubtiAYpATvoN/hlMxFrpmAihx29HREjW3HlOu/zUDr8YqbTMytImWyUN+547MvGFmqiTDGz3
 7RLrTGsXURd8/MGrOE2kSuns8=
X-Received: by 2002:a05:600c:638e:b0:493:dad1:e46a with SMTP id
 5b1f17b1804b1-493f88243a3mr99391275e9.21.1783959470376; 
 Mon, 13 Jul 2026 09:17:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f3a60404sm256727885e9.1.2026.07.13.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8E1E5F873;
 Mon, 13 Jul 2026 17:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 chen.zhongyao@zte.com.cn,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 3/7] mailmap: add fix for Zhongyao Chen
Date: Mon, 13 Jul 2026 17:17:41 +0100
Message-ID: <20260713161745.53889-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Fixes: c24f58d5322 (target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f)
Cc: chen.zhongyao@zte.com.cn
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260709080040.4157324-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.mailmap b/.mailmap
index 9ad072234ff..e5dc644623f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -40,6 +40,7 @@ Ryan Zhang <ryan.zhang@nxp.com> Ryan Zhang <mailto>
 Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
+Zhongyao Chen <chen.zhongyao@zte.com.cn> chen.zhongyao@zte.com.cn <chen.zhongyao@zte.com.cn>
 
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
-- 
2.47.3


