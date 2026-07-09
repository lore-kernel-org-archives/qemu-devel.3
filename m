Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0CBC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgf-0007i5-5b; Thu, 09 Jul 2026 04:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgc-0007hE-Qz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgb-00088d-7e
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso7851745e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584042; x=1784188842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fmk6ngmIhKhQaMXTa6OG3w8mjfROFdkNNw8ohK7dDoI=;
 b=O/L/GBZcUC13l42VDr8z2pcJlqcgq/D3DKvypkwOBOqhOa4ngQ/QR/4YmlBJtPxgDp
 r7rUEbtslk2kXkzVUAwztRHwfCHXcuZeEBc1thxraAKim7G2zTRYsACQDBXRbo3U6rRp
 osxEJR8EuACUYpF7UVilKTXd5543wYuxe0zcUx4xub9gWdYYzaNr7Ku8xAMAXvvd8tNE
 y00oc0NxOsnL5SivLS6f+4iTG4IxmopKLXNEgIOlwr/uZE9+cI8tu+if3+rJE2yPotVK
 rAPx2eS3SMJEU3X4r+0TFMZ/9p/7XsYFKLSHlu4OakCaagvDHpjObZO+H7JAUR2DPAUh
 yu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584042; x=1784188842;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fmk6ngmIhKhQaMXTa6OG3w8mjfROFdkNNw8ohK7dDoI=;
 b=Oq3CKP7yuOm1h3+7Gw4fbwnsnCOQP8p2YRHdPiN2933uCjsdNG/AoI4kONGZHIhEZq
 0Px4XjIT9zKvcfnAnVyWgkGFex/vBtiaCqACpCUU4HpH/OtpkSXWhrWa2Fqe59HLIo/G
 APBxqxo5rC9teZsn8KmmMPafj8Y4S2ye3NJA9fBmFaymlI6V9pMctWfFvQpLoiTxA6Oa
 g0zavxshKiekHj2tD8J1CUT3hSBWpS1fr034zzauXVXkcaFD8+0bSgnjuML2cDaYyXTc
 G/0Gu+3zwkEVZ08YBvw1pv7YApM+kNBTwB4h37u7NJPShXnCQvAgbMi7L+BG7sd1+ws3
 tNWw==
X-Gm-Message-State: AOJu0YwNchv9a3wm6TN6JGJaqLCd9dH/ZXaI0Y9Z1iEhMriv3mXUjHqx
 b+jnXjHf+eEfH9D3PUnhtD7baoC/WcWPKcBrVtzzejtFp9dbqAsRW2ouvZKdJeRn8WTeQ2bwxNi
 jrObZf2Y=
X-Gm-Gg: AfdE7cmP0Z02SMrHwSpiBnV0pbKBuWpzVlKcDzbDDrWqaAeY79iE71et0HhODl6n0RN
 b5JjuCkb5K3jxcNpauxhbU8B9gQqTGulDzXywesA4oM/nZWXmb6Cumn5pvyivYDx0UNUg1POcR3
 NyIlKBSZ00VAYFfh2UeoRGhph0xlUHVH6dqZfs0xnBkAXJBxd6g932Ec5da0G7fMaZv7fp5eo9F
 pyZG1pGIP8DLACw4FPsDtyP17IoMpiLtEFfiLNe7Iu/UDYegpU07BlA9/NJ9ZdSYM3qvMMBi5tO
 xUHik0wNWN16/y37whfOCLiVpKMCIVQ5YJpU2MYrpbW/A+uNVKfKQnLmJJWFUPg4S5lsOx9g0z/
 ERq1NFEbn7nDctT6JsUsxdPcGVimKy5o2+Xjw2nRpQJdmefu5llktfVRQgdjIosLT2VdUCBhay1
 0NISghje07AxT5
X-Received: by 2002:a05:600d:8444:10b0:493:ba6b:b6e6 with SMTP id
 5b1f17b1804b1-493e689b0bemr44544495e9.31.1783584042114; 
 Thu, 09 Jul 2026 01:00:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm46947458f8f.19.2026.07.09.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E2726004E;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 chen.zhongyao@zte.com.cn
Subject: [PATCH 3/9] mailmap: add fix for Zhongyao Chen
Date: Thu,  9 Jul 2026 09:00:33 +0100
Message-ID: <20260709080040.4157324-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: <chen.zhongyao@zte.com.cn>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

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


