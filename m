Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81109C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl08-0002gd-Oz; Fri, 05 Jul 2024 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzs-0002Zr-FJ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:16 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzp-0001GX-Uj
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:16 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso197590366b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193832; x=1720798632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNf7s8R2vDveHCOH4mOfJzT2WATK9n15xFa8GFpeYac=;
 b=Akjlxt9uwyCF3QueVHdJ6ox/TaI7VGdVyJ8+X6SNy2Ai+3pVAVKCtwAezaFF61DHD6
 V+9DYteSLwDdANn2PCMApmjw3QydGjKaLqDS2ayd3CO2Lb1WuzYP6hAz8JudbiaGQJHp
 zh2PE5HZ+B9yV3oqUUqxW1+BOQcwSvS2afgtDEU/iEDzgV91l3L3x5/GvDNp5PPe5Z8M
 osOI9FY5zvHzTJfUifceUv+lbggcj2tDAAxb05YFahmndJk2ipEBsLVZ8rj8pWld11EY
 8j/zMboPl2QF5mxwb/zEEL3qq0lgl1vZdbq+2Re8quxNc408rsbn9OkMSEN7uCr6PoE6
 IoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193832; x=1720798632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNf7s8R2vDveHCOH4mOfJzT2WATK9n15xFa8GFpeYac=;
 b=L1YyDrl5pvh9fwe2ARqcLsN0XqdBfi4JvtVwnhmGzFDortOuwImaRfQOaXukKAMX3i
 zbaYuPoTZRo5vKwaroJo+U5003gQn++OHeSRaRluO5XEa49nLwsvap+gZK0armmFjgkv
 6cOyyYl7kT6Zk2gng2mly7QDHYkOR1D7PpzC5o2zFfkQdeyKXCjaVa2y48SxF3sIB+Ex
 Wo86vrihqvJU7+TRWjivux5VBlkQ/J+kLMJY2KwsW3mMa4q0lbCELdudCg1rA7685yk/
 cg/kH05zBEg6pmvuz7SKZ8zOFQa2gr8yu9qr1IDa8DmynU9+7M52VlZzwnp6OvTcePHL
 2ozQ==
X-Gm-Message-State: AOJu0Yyp5EJciGM+P1pGqKJkLTatq+BzKjLsQUqHGucCJkgFVV7DVutq
 fMusXO332mbM+20V+PhezdYuvvVjIZT+nL53XWAZYNZSDVj+nQJGJHmhTKWoKjs=
X-Google-Smtp-Source: AGHT+IG9Y/VNO3PfLfponUYjg1F1xZWW57EaId1cUQm2sVSeLvimHixh5ICb+jRSN1qlIx70AQjb+Q==
X-Received: by 2002:a17:907:97c8:b0:a6f:b5ff:a6fd with SMTP id
 a640c23a62f3a-a77ba46133dmr424780166b.12.1720193832252; 
 Fri, 05 Jul 2024 08:37:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77b6c8b69csm149544266b.45.2024.07.05.08.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DEFC6214B;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/40] plugins/lockstep: mention the one-insn-per-tb option
Date: Fri,  5 Jul 2024 16:30:37 +0100
Message-Id: <20240705153052.1219696-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

This really helps with lockstep although its super slow on big jobs.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-26-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 8b90b37f67..1765fd6c36 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -14,7 +14,8 @@
  * particular run may execute the exact same sequence of blocks. An
  * asynchronous event (for example X11 graphics update) may cause a
  * block to end early and a new partial block to start. This means
- * serial only test cases are a better bet. -d nochain may also help.
+ * serial only test cases are a better bet. -d nochain may also help
+ * as well as -accel tcg,one-insn-per-tb=on
  *
  * This code is not thread safe!
  *
-- 
2.39.2


