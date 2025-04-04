Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC74C3601B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Xbp-0004UP-PZ; Thu, 03 Apr 2025 23:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0Xbo-0004U0-9N
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:20:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0Xbm-0002Jw-Jx
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:20:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2295d78b45cso20738795ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743736841; x=1744341641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgUeTNLvHnaSYD7jxE6qYJfmnVuKsV2rhD27f5vaV0A=;
 b=awVr48osBVHPRbjKFas9hMBAwm76r6FR0s99cZfFNMfVhFwi3pq2Vt76qrZGFTirb/
 4o0g7NPHWgRzeXnzpV7aWHCg6OsjSuryZin/xeNM3vDvWGElcayQzJWDczixFfD0p+pQ
 aqP96MoQCkjSJFgJUr0UxRHHlJhv8eJ/FentQ/WuDXBbobEqj4dSp5wPPJ/HN3qzZRSW
 aHLixALDniibFP9wn9T78DQ+1I3O2NRGb0iKt4a9KQst6tzviR/YEzEyuRS+HxcR1RgA
 OawnCeFEghF5T38fcd8PoOcFnWDSu+vlr2sNQ8Ju2VxB+b+ZBgmrX26w4Hv99UoUc7s/
 M18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743736841; x=1744341641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgUeTNLvHnaSYD7jxE6qYJfmnVuKsV2rhD27f5vaV0A=;
 b=l23vraEFs/jsf0EF4LUOwVjinWWqeXQgWXinc2cNrEyD/fyMDohHKAMY++epPwhtQy
 BzbxWmkVMLkWGJ5KVE+FoLUJr0V0qnv1nHH2+d4zqrKsvv8yKHZO7I67yi2+BJ4i4mva
 P4WmMLka5Hmsrb5wtWHoqleOirlRR7C/zbLsvkL1lGyMfAScNgM0K275rvXm8R2nck9T
 /1y9Lll/FQTi4zTNDbkk2d+OokcQUPvbfbV6fdugvgaWSoUrjR3Bfq/gYzz4ppo3Sl18
 qtQY8Y54+GwncNvRem5kM7as09MR9O5l6lFeL2glBJKqdc6z7B99ivTeVXTtbt+4PuMa
 5d7w==
X-Gm-Message-State: AOJu0YwPV3HqCtVQH8fE1vN/Bli8Xb4xhDhNN3DnGcgAhsS1ulXYpPYC
 h5eKjIdc8jYNJlIMeOBCRCfHzJltWtnCtugwDNmci8T5GsRVBCBAxVLO0VZ6m1oVM+eM6fYLigK
 t
X-Gm-Gg: ASbGncvHsfd++jp2TT2QHkw6u6pkm6fhv8EFSWdw4GMl+DSEwqigBu4HBAKLU6lUfcI
 r317D/zhtGv3tasNKfhxkZXSfpt1m+YG6Ti9DiQbu25RoKzJByqt2gBo+LWDnmkgESAzaixmxHM
 sgPoDeAslsgnSqUi/iQnd4+gZp6enQMjTfdqOKw7Sm8lPugVxb0JCSTfvsNuEomEtb0L9Z8yXfP
 i8K8Hb6iiDjSiZob2tKt8RngK+EE2bHJo72F9VoJOZ0oacRQqbb64HXMAL2FN+5bTZRwAEgg2d8
 KMVlnhhYhAmX5dAq6duQYWz8fzjPlT8wtXpYDPJJK7lG
X-Google-Smtp-Source: AGHT+IFltLtdtD8qzF32/0xwhld58MpVclYasfZbEn28Ie9mcDKT6nglPT9qAt2TO6TX+X5VgH8w7g==
X-Received: by 2002:a17:902:e890:b0:224:1001:677c with SMTP id
 d9443c01a7336-22a8a0429c5mr19544885ad.9.1743736840859; 
 Thu, 03 Apr 2025 20:20:40 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad943sm22325945ad.23.2025.04.03.20.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 20:20:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 1/2] plugins/loader: fix deadlock when resetting/uninstalling
 a plugin
Date: Thu,  3 Apr 2025 20:20:26 -0700
Message-Id: <20250404032027.430575-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
References: <20250404032027.430575-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Reported and fixed by Dmitry Kurakin.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2901
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/loader.c b/plugins/loader.c
index 7523d554f03..0d6e082e170 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -370,7 +370,7 @@ static void plugin_reset_destroy(struct qemu_plugin_reset_data *data)
 {
     qemu_rec_mutex_lock(&plugin.lock);
     plugin_reset_destroy__locked(data);
-    qemu_rec_mutex_lock(&plugin.lock);
+    qemu_rec_mutex_unlock(&plugin.lock);
 }
 
 static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
-- 
2.39.5


