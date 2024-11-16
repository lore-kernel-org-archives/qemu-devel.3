Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC97D68BE1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 05:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCBWn-00061i-H4; Sat, 16 Nov 2024 00:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCBWl-00061Y-HQ
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 00:39:23 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCBWk-0004ey-4S
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 00:39:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so26119655ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 21:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731735560; x=1732340360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1lZiCiZf87Qs/9fUS6Yc1O4ZeocfPecUDBI/qiCE46c=;
 b=tD7Ec0fcRV8QF1O+1bsGm+lTv8VLIV1h9hAqjfIKEaK7ZbF1HIJw2fueqItmryx8v4
 rLuuRAGRKpwj4yPA1ul3BspgzHmPIiaEOpo+NhwYbjs+c7Nh/OmFxUGTxSouw07oPuhl
 rIBLP22WB7xMz4mAj3EQZ49B2jp27guCfRCQPPZfCHU2yNf/2ioLDTnPeUd0I+GWocoz
 senwRmPTnSGhHYHn0i83sQ2Z1R3YEl01EDMSnzf/y/GABbWP0kS014bm9uiZF/TBWRZ7
 3F4dvdxOu9UBAfE9pxsjNI0BtAl/bsrSmuQg/YKQSuYKITkn9IGbylba6WS443aluIT6
 okIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731735560; x=1732340360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1lZiCiZf87Qs/9fUS6Yc1O4ZeocfPecUDBI/qiCE46c=;
 b=kF9ZSgX9YgZ2FH6r2qYixxA1vj8VA472vA71XH7Q48wdOpRAj4X+ynLkl8HC9LbbZp
 hV0QjX8bqgkcEpyapJZ7z6047yYMRCzcxWvCFaVLvHGYiyXca3ZM7+2HGgR6jKUZEMKP
 Snv4QG1DU377qXrmz6qUrIKFzS4Y+7TdwoJ0qvFmDYfdC6UIvGsebSwExG9jbdWeaBrg
 rF1cCo4JvPtqoAj8rMa6Wx5OwI+SW1VwtmeXn7SE3DSusXHAh2fwj6wLX9sDuKOgfU6a
 pL6H5iU06kMZjWYOw9w6+kSOyOzXExMMN7DEib/XtY95jXRZanRWF1LrX2OAbitMZ3Dv
 eqkQ==
X-Gm-Message-State: AOJu0Yy43keL35G3bjm/Snf8zWJT5k1cta4ktvzifVmVC4oes83FJHVF
 K6wOYyXEyNculgU5I1BVlR9RFEudr1cbQbNk114aXXV61ZD3UzU8Arn4Q47gJGtn0Tv0GYOLWvr
 O
X-Google-Smtp-Source: AGHT+IHLeiFKZntwx11lhayR7ZIaUh1KQUF4dtKKjjP+DLyM5VSLwWN8NwuYOEi9YnlBtfTBRWuyJg==
X-Received: by 2002:a17:903:285:b0:20c:c1bc:2253 with SMTP id
 d9443c01a7336-211d0d861c9mr87360235ad.32.1731735559871; 
 Fri, 15 Nov 2024 21:39:19 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72477120aa5sm2280879b3a.79.2024.11.15.21.39.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 21:39:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH RISU] risugen/aarch64: SMULH and UMULH require ra == 31
Date: Fri, 15 Nov 2024 21:39:18 -0800
Message-ID: <20241116053918.420404-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Do not generate ra other than 31, as it is UNPREDICTABLE
whether the instruction will trap as invalid.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 aarch64.risu | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/aarch64.risu b/aarch64.risu
index 8f08cd0..87d9c72 100644
--- a/aarch64.risu
+++ b/aarch64.risu
@@ -1887,7 +1887,7 @@ SMSUBL A64 1 00 11011 001 rm:5 1 ra:5 rn:5 rd:5 \
 
 SMNEGL A64 1 00 11011 001 rm:5 1 11111 rn:5 rd:5
 
-SMULH A64 1 00 11011 010 rm:5 0 ra:5 rn:5 rd:5
+SMULH A64 1 00 11011 010 rm:5 0 11111 rn:5 rd:5
 
 UMADDL A64 1 00 11011 101 rm:5 0 ra:5 rn:5 rd:5 \
 !constraints { $ra != 31; }
@@ -1899,7 +1899,7 @@ UMSUBL A64 1 00 11011 101 rm:5 1 ra:5 rn:5 rd:5 \
 
 UMNEGL A64 1 00 11011 101 rm:5 1 11111 rn:5 rd:5
 
-UMULH A64 1 00 11011 110 rm:5 0 ra:5 rn:5 rd:5
+UMULH A64 1 00 11011 110 rm:5 0 11111 rn:5 rd:5
 
 # - Logical (shifted register)
 # 31|30 29| 28 27 26 25 24 |23 22| 21| 20    16 15      10 9    5 4    0
-- 
2.43.0


