Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB2AE7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOoo-00056H-1A; Sun, 22 Dec 2024 11:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoW-0004rf-4B
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:20 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoU-0003jD-FI
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:19 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216281bc30fso36608935ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884897; x=1735489697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJ/bJ4QtRBGimmagW6AK+8fKAALk7Es9Y22KVQwNalg=;
 b=A1SN7r3Qu7YO7+523yRwv5uth/RRN0GkPoNBX2A43rMuE+WRS9EtUdoMBELFvQ+4rD
 /4akMU8YQD0ps24R4YlUjYZABOj3b1eKiVCaNa06tZnJ3C8u8l9i5PFvc9WYpNRJH7IP
 BvbYlQKJafqiM8KMItCnM++aJck3vVybhAJmMw5U/f45GDsHgGcFr+4WENTsGKpmEYkT
 ij+twVzqF9h05H2AyZhGJvfrFgnp1zrWoQfAT3XgZMybPT6VvUXhucOsPUjmNRIi0fa8
 A4lYWqYJ/IpTnM0q9oM7eSI0MyosLnavHvLEFzpfsOeA07HqYkjTwQew8FEvE4kNxfy5
 wc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884897; x=1735489697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJ/bJ4QtRBGimmagW6AK+8fKAALk7Es9Y22KVQwNalg=;
 b=lrXLbYON+yuH9D65PZOxsbRQ/CsKrC0I0ITOFl0g3E0I9ofedcUadDa5Sc2ce4+hGq
 Z1TDZF6LRkOl84ExYSlU/2iKrI2NeabG71FOSawKzEjiw/3cOFmUeowIENTsSiufdkMg
 EDfjghjLcs6dgJGZji4jbUY63fXQ8EXt6qMBW5A68XoXxjCnL4vBUePo87A+A4mI1G1J
 1UeS1shZqw91UbqJ7P/RNJ1XQTJpkIO/cU+WZyxuyg1BF4FOtkRZGG8WKN7iZM1FfBuX
 ZfdEvy/snAw5UwXcVJ+3dWWhVYjZ/sWEUmdKfuoQZgR3Wdq3jaLstHnsG9+OBnz/DyDZ
 jJTA==
X-Gm-Message-State: AOJu0Yz/R0eXGC2Xsizn2Q1jfD9bWfDN/xloPZt5/U10/PWhFC9YTF2N
 /MWNqT8U73OV3uDidQeXaM31tR6frOS67i2kUAi9RiSDZY9grBwtWDrqid3iRATtRhL8hsFn3yG
 rrxQ=
X-Gm-Gg: ASbGncukGwkrxsSzQoHhN+d48z144bGWpz7TBmCce83sWw0dBBcu4G9+rxxJjh71RzP
 yYdFqd7By9kflP9jlAh4IysXvZEHZbu34x3m6r4FHcdpYcgxzczdGpeYtzSrmnkL4w8T4cO/a6N
 DGzHU5DxofEjvtUpTujU6S7DePBw58Qx6m0uFODB8Y8pZULlARGmbLSClIz4xbJ155GK4frJcZC
 h1OU3WKSX8DDTFDXKfO/mfIydJhTtp7AtlbpUzTH7P9zxIf/1kFUWq8ZjCRTzw=
X-Google-Smtp-Source: AGHT+IFPWADZquWpIhChxtLvPFgnriSnDbeQZUKOkVD++xGaNu/lc/44dIFYd7/iLUvv683FOKOgzQ==
X-Received: by 2002:a17:903:3203:b0:215:5d8c:7e43 with SMTP id
 d9443c01a7336-219e6f497b3mr137544525ad.54.1734884897265; 
 Sun, 22 Dec 2024 08:28:17 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 44/51] tcg/optimize: Use finish_folding in
 fold_tcg_ld_memcopy
Date: Sun, 22 Dec 2024 08:24:39 -0800
Message-ID: <20241222162446.2415717-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cd12985537..48324f122a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2668,7 +2668,7 @@ static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        return false;
+        return finish_folding(ctx, op);
     }
 
     type = ctx->type;
-- 
2.43.0


