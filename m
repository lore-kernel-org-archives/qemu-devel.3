Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CE2C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 16:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX1eE-0002Sm-L4; Thu, 25 Jul 2024 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sX1eC-0002Rd-Cv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 12:48:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sX1eA-00021R-If
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 12:48:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3685b9c8998so606535f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721926133; x=1722530933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LfWAFPsC7N3rrME45NZOd2dUXZkhdvT7AY8cGau49bU=;
 b=SRaPYG5vgtTWo2f706hQVOQjD8gu58ieASd1BtDLT3MLyc9fu26KuEl0uDBxJx73MV
 XdV3CHOOi2SrR9nBupoXEpyAYZ/ZGEfUfp1y24yaAuSsHmCWLl/BdqniJ0Fp74ictci+
 ktgpZqUxSPhedb02syE6XiFnr/XFpzden5o7Jb92eLKSzCpbRtjxpFgcdSX5Vf51ey3M
 ITtpotqbPDQ9AozuMx48blHfeygwfxpYC/YEzWyHFXuJI2fWo7vmGKNsqyVvbkcqK3p5
 O/ySsWph9czQ7j/bz6cMjk/WU7HR+cUSSc6PIMQc2wYLTtN454Th/dDicWfEf7Brzv9t
 8ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721926133; x=1722530933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LfWAFPsC7N3rrME45NZOd2dUXZkhdvT7AY8cGau49bU=;
 b=KPCI+7DHCK2R+JKHHVc8Q9VqtprUPGpOVyvgvY1i2b9z6SyeucOv4R/e/DCjqvMF+G
 RGC8oTPMeDCAwSx8AP3OvV3UdElh1PO5OABdfNcuk3pFKwlB/3iFV1sIUxmh805c7K9i
 9YtdAHgPL5kgamxkWXYpx7M6TvR6N3H/V/fdUVjnODWWrPO8MTIK5x76POelAlrYbx9y
 JcdCWYXzFtd+OyrrBNgH6S51nXyYWFdkWOy3kAwPVUjONXyOhZ6YXgEeKFuMY0fQiz67
 ItEidwBL0MmchRPFYDERUw22L9/xwWSlXfQYYpBTm+kaer0z1GD1TgOZWa1MXjeSj0yN
 GKVw==
X-Gm-Message-State: AOJu0YwbKtj5P7+YynMcUiTBkT2HiPxOGrqg7GvHPtSgeR7HQlkGESA0
 P7QFA4pafLipZQcUI2O7kk+URgZqdfMGzcab4jrjFaPRsKg9CyGY3OtvYEsGtISpSEhuifWIxvT
 a
X-Google-Smtp-Source: AGHT+IHyRSopSDhypE0XDyDU9VX3ltvoWxBWuLv5fCxSB/WVwmvett32o3Anm/FMULkamJsPQsr20A==
X-Received: by 2002:adf:a348:0:b0:368:41bd:149b with SMTP id
 ffacd0b85a97d-36b319fadf0mr2479687f8f.34.1721926132590; 
 Thu, 25 Jul 2024 09:48:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0889sm2764360f8f.22.2024.07.25.09.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 09:48:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] contrib/plugins/cache.c: Remove redundant check of l2_access
Date: Thu, 25 Jul 2024 17:48:51 +0100
Message-Id: <20240725164851.1930964-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

In append_stats_line(), we have an expression
   l2_access ? l2_miss_rate : 0.0
But this is inside an if (l2_access && l2_misses) { ... } block,
so Coverity points out that the false part of the ?: is dead code.

Remove the unnecessary test.

Resolves: Coverity CID 1522458
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/plugins/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index c5c8ac75a9c..512ef6776b7 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -558,7 +558,7 @@ static void append_stats_line(GString *line,
                                "  %-12" PRIu64 " %-11" PRIu64 " %10.4lf%%",
                                l2_access,
                                l2_misses,
-                               l2_access ? l2_miss_rate : 0.0);
+                               l2_miss_rate);
     }
 
     g_string_append(line, "\n");
-- 
2.34.1


