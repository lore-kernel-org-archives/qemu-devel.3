Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A807EE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYW-0002EJ-M1; Wed, 11 Sep 2024 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYU-00027L-Pl
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYT-0003fF-6t
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:58 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so62239a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073456; x=1726678256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWl7Xv2JGXBckAdLaFuhNWtujP2/LH0xkeEqhVhx7Pk=;
 b=cTnzXQ3tFsRr2YACtK5S09dtpXU64mhaoMeXSU6bhHFk9/hrfxBF1SXnjpYg6qP4vQ
 rkeHr6yRbs5PQutjnJpW7x+U77IzVsZHLhpwXD33x/D3uCGetBNFycDCBBJcox92U38M
 +9Zpgf82cgsiIwSU/ynYPMj+cqweZ/Got6ApdrzkGO3dYVwC+hATP+aj0d6ur6Pgxpaw
 Vs1ODoSLefB2G1VKc+86TwvMpEa+oVf6VvSjBenrmaeHGrsx7KFN2VyENq/ZXp0MIJSs
 EgaAPX7sBleNpaLqtIfB2Tsyh3Bt2ToA8XjLB8yYMk3D8iscs81NojV0HYKD5kr7ZC4w
 n21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073456; x=1726678256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWl7Xv2JGXBckAdLaFuhNWtujP2/LH0xkeEqhVhx7Pk=;
 b=jrPEY8WXiV+vFmpwPGWpMCDdUSJLAqXiGq7eW3i+0QUgHnEwIJORaRGXJVVZ7Z9q71
 h/O/84oGiMbGsqu554e8XZaRU/6l2aHhnTLygSYlxij+OUn/W0/TLTvxMFiyTP2RIT/U
 CWjoqopvs3MzN8yvUKxvARfjWMwcsrZZyamKacFEbkoRDTJut3catVU9bp6P/F0kltgz
 dz0BLp1SIFRc52kSYVs23d3RdtWEkmiMJXVnX6QhokIAbYGGJAKZWxEtb/uXfTw+yTGR
 BCrQkCOrsr6rSRVWvfQ/4kMqxX32ONs92kIA6O3cCZiB9RB1+fwVZtm0LB/kWDx8xbAy
 /B4A==
X-Gm-Message-State: AOJu0YzBR2S6KmQAqPv9BPWQhH2ZZm6kApE5EIjlilhnCXCzQQhrzhdh
 9VvMDh29DLfwvezqsMepipZg72tzBm161N5r01D1MYE7+r+pjhZwrddtmHRPzG4waXnefl1Khgw
 I
X-Google-Smtp-Source: AGHT+IGC2AL6z0GKInsRR+HteUSB03nd4G2bjhHWkkNJSRlq7DkDuQkM9t/SbCX3LBZzcNtF4vSZYw==
X-Received: by 2002:a05:6a20:4499:b0:1ce:d418:a45c with SMTP id
 adf61e73a8af0-1cf62d88a65mr4115749637.50.1726073455567; 
 Wed, 11 Sep 2024 09:50:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 07/18] tcg/optimize: Fold movcond with true and false
 values identical
Date: Wed, 11 Sep 2024 09:50:36 -0700
Message-ID: <20240911165047.1035764-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

Fold "x = cond ? y : y" to "x = y".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ba16ec27e2..cf311790e0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1851,6 +1851,11 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
     int i;
 
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
     /*
      * Canonicalize the "false" input reg to match the destination reg so
      * that the tcg backend can implement a "move if true" operation.
-- 
2.43.0


