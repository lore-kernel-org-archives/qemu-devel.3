Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48119C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWH-0007wx-Vo; Sat, 22 Jun 2024 08:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW8-0007lQ-MV
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW6-0000Jo-J7
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-361b376236fso2038305f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058009; x=1719662809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6E/MYKEkb0DMERGi+2DNA1yRwtK5eQJJPT+gNFpw4l8=;
 b=VptqaLFBGfPrAa/kwgjtfmxwLAuYAYtuMNi/WxdKVgxVHxez4pInqIc9GCmeEN2cUv
 R90/r4tABn8cz61xg2QH5EDfo+F/lCH9m19YPctLbt/XiUvwYat3g714/+p5fiX0pfy4
 RA5s/JN2vXzko+Rb2KrY6MZS53wGnO00X63auLekxzdO832f2+Pp/K1UoiYdXBEhvVU1
 udRb66gwZpQn+VgFdF8w+7xlYUz43uKINc40j0wUkbV6QX30Zq4M41jizjmqVzsFG40O
 Bj0H9OMOrvtlQj2qQjOy75u3BQtFkVhjrFL+1sxviq8IoXu7OMg2w6ZTRQLz0SJEQXZH
 sBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058009; x=1719662809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6E/MYKEkb0DMERGi+2DNA1yRwtK5eQJJPT+gNFpw4l8=;
 b=MRSiGuEa7LbJRtXriDcMl454PEAUvIrT7ju5IoXBVyKykVZbHT8uYsXpryvPvHh2mc
 V4hG+nhLAWwTvPRJrByfvZSiGwjWv1xMf8wzyX96+OCsejxR6FQ5K14fD4b9GY+qvdP+
 6gvCMM19QJ/5k9VB3EDWcNl8ssOIQyq3o5TvFf/Z04LhbAZ/AFWfYHjFTvnzTHUfWcPq
 GiMdikcO0u+q16hvDTj0ULDdkNfYPwfs/zHrEJ5Wpa1DeijbaV8+E5G45IKHCP9182OO
 b9tdyzJ9xgN8aa6Lf+lNh6Ye3i5op9WTo/GjniJZfbwAa08sV+PMfMnzBATtQcjSMq5k
 H8cw==
X-Gm-Message-State: AOJu0YzF4uOS7HgS3AlHAt22vwQivuqKsQlV3AFOHr7urx//Wc6KLV1/
 bk/HSQ5D8eSum1Ocf6j3TZ5gRucs7Vky39P8S9zTilt6wws13+Wz8nbif1IHVdo/gFLZjaosrHR
 5OGY=
X-Google-Smtp-Source: AGHT+IF3meglMdsaLZsfubTWaKrlu9frC8BQ07fzr0M9VYX5Pu4Y3XRnzZyRAViKgJ367Ut+OWXe0w==
X-Received: by 2002:a05:6000:1363:b0:362:dbc2:9486 with SMTP id
 ffacd0b85a97d-36319c6f86emr6856978f8f.68.1719058009172; 
 Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] scripts/coverity-scan/COMPONENTS.md: Fix monitor
 component
Date: Sat, 22 Jun 2024 13:06:33 +0100
Message-Id: <20240622120643.3797539-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Update the 'monitor' component:
 * qapi/ and monitor/ are now subdirectories
 * add job-qmp.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240604145934.1230583-5-peter.maydell@linaro.org
---
 scripts/coverity-scan/COMPONENTS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 205ab23b280..3864f8eda07 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -97,7 +97,7 @@ migration
   ~ .*/qemu((/include)?/migration/.*)
 
 monitor
-  ~ .*/qemu(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
+  ~ .*/qemu((/include)?/(qapi|qobject|monitor)/.*|/job-qmp.c)
 
 nbd
   ~ .*/qemu(/nbd/.*|/include/block/nbd.*|/qemu-nbd\.c)
-- 
2.34.1


