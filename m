Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33BAC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLw-0005vG-No; Wed, 05 Jun 2024 13:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLs-0005tX-J4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:08 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLq-0003pb-RH
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7025f4f4572so901778b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608185; x=1718212985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHJotesaXwGLwu2EOqL2F77EqNf5qS0c2hknFMUEE6I=;
 b=dc5mwgRx0SJ67sKHKz6TIcyitWrP5zhXt5ZFGfsaoVFh78heAzKoR2Nej3tw7z2ORr
 8ODKt2p9IOnzi9YtEiqhW2vU57uuGyENrijtX4aHyz2JU3qePBejEY7C783zwTU9dodU
 j2ldCXOjSd3MKFEfGuBbi7W2r9SrbhJ/4AZVVs71ryo/VhZFypsa/Y9GgFs9vDnkuttN
 0HWBiVuXwVxuT9S76x0DPcBP5oQ/1Rh+xjn+1gUC6h/JJ+xYOx0CmiD311w/ZnEBHspp
 TjS99upVv6VOEMRWhsJymy8hMNWcDr5sXs8jnVxvr7ZtARsM/DPb6wwOsPQzl1Qp6NLw
 3iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608185; x=1718212985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHJotesaXwGLwu2EOqL2F77EqNf5qS0c2hknFMUEE6I=;
 b=pUBj0KPaY3vBid1onfxS+EKVNt4ChKStN0DNNmhtwCdf3Pv4WKY1f9SRYFk4sKzUDq
 zh6cP6uU+uSqQTXEDR7aeG+uUgFmYo2BgWim/+amuWBeOoTZtRnQdHDsI+9N9hlagrps
 kduE5R6kndtlfhO9BBSCIGgyI8eZU2njPssDlc0vExgZi99wgkS6DAoxq+E/lrbV1vVZ
 f895bos4epeYW5wnpfttV/rrfH44fBNojKtDcxuuEd6IUSYbf88oOzrpGNsCygdMCS1M
 aQ3BS5dvLuUWOnSVDeMQj+CXyKaOW3MqBj+AGAC3unddGd/9Vus+qJUJGvy7vrpwfXsk
 Hl5Q==
X-Gm-Message-State: AOJu0Yy6y0Z2zbPgo96EEZkhS2kW3k9dqqj96JQHKnvj0U/OCdZXUmxm
 vJ2QNDurasFYisY2KaaFlCOAse14D8E4Q8yrqFR9iSRd1ki39G8mJcnaByIn33s2HEJl5vbvgte
 k
X-Google-Smtp-Source: AGHT+IGZ7UJd184z0i7ayZIKGigLyHWYbsnzKmYWuKM/BLRRq8y0KVuKW9t4MACpG41y/dicWLTbbg==
X-Received: by 2002:a17:90b:1bcd:b0:2bd:f4ba:fc3 with SMTP id
 98e67ed59e1d1-2c29998dd5amr399530a91.7.1717608185467; 
 Wed, 05 Jun 2024 10:23:05 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/38] target/sparc: Add feature bits for VIS 3
Date: Wed,  5 Jun 2024 10:22:26 -0700
Message-Id: <20240605172253.356302-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The manual separates VIS 3 and VIS 3B, even though they are both
present in all extant cpus.  For clarity, let the translator
match the manual but otherwise leave them on the same feature bit.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu-feature.h.inc | 1 +
 target/sparc/translate.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
index a30b9255b2..3913fb4a54 100644
--- a/target/sparc/cpu-feature.h.inc
+++ b/target/sparc/cpu-feature.h.inc
@@ -13,3 +13,4 @@ FEATURE(CACHE_CTRL)
 FEATURE(POWERDOWN)
 FEATURE(CASA)
 FEATURE(FMAF)
+FEATURE(VIS3)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5efd09f4f4..59b922c903 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2188,6 +2188,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 # define avail_VIS1(C)    ((C)->def->features & CPU_FEATURE_VIS1)
 # define avail_VIS2(C)    ((C)->def->features & CPU_FEATURE_VIS2)
+# define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
+# define avail_VIS3B(C)   avail_VIS3(C)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
@@ -2201,6 +2203,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_HYPV(C)    false
 # define avail_VIS1(C)    false
 # define avail_VIS2(C)    false
+# define avail_VIS3(C)    false
+# define avail_VIS3B(C)   false
 #endif
 
 /* Default case for non jump instructions. */
-- 
2.34.1


