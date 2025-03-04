Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B50C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiX-0007Ps-Fs; Tue, 04 Mar 2025 17:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah5-0005QE-Pu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:09 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah2-0006XG-BF
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:54 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e4d50ed90aso7213601a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127090; x=1741731890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MQuHd0qcU2J5poAhTVutiNlp9cSxVFs0o4bkyIqmvM=;
 b=xPbj2aQBugm4ORg4zRjkD3OMXB16L3CPgVdFVbSIJ7J6SkbtkQdWs4J3aBsoucclvX
 PVqCSjoD7QOwACPzupiBRmZdudgiZUJKzmFqMYGcd4xKL/ZkfliAqqynMREk7BYEEP9x
 ItZUHyVZaiIEQBeL9ALx8CU6XW4v3el5PrBeH9iFj1plDLQIE7jkfoe0FPm6uMw9DmJi
 hTAOdxDuWjVxjDTCOorEs0rt+fGaase4kfMpAM0bdQmFq4Ku0s85tfUlJ6HlTjsRx7ge
 k9M6W+eUn9XJnIB5GIjDG7EP/Kh2WZxN9ioayAaNRDJ2uc9szNNkmfcfJIHPnLr7KSQV
 uO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127090; x=1741731890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5MQuHd0qcU2J5poAhTVutiNlp9cSxVFs0o4bkyIqmvM=;
 b=jkqC9LgMDTEnUjm1XnXjAa8HFUQWHOY+xmJ1/TeH3sBD0qTdmKPpnY0AdJ6GrOOE69
 R8zzTSH9Ijo7sO5HfbSnni8OPOCnDxVK+A9nqHnBjWQbnfakm2ZhIptwzcZ9yJJo3ZRe
 TPHVmX9qpq7TZeTASCB06W01xfgSl13bmLahNFngc+7Hh2LeaMEs3zkzqZLDBAXeQCTS
 fhuglpZ2XCxfKeQhAOaXxTHHxG6b0ogtEOlUIdjGvAIanN0pizCPFbMv5c06yQJUBHdD
 dEY9IJobencCJ2AytDM9gYFArYTRqxxkTxwsWxw7CqH2OIGqMTAx5hEBk1lCsdsRX30J
 /upg==
X-Gm-Message-State: AOJu0YzY32wubiar49g0TJ2EDUQDrAzt9zIhdU5wLtv5wTnYbwqhaStz
 IG1s1wdUDW2dvIg3XNxqcNxkAEztaG0tjaSX8E7ONSaRBMuW3FcdxlLUL46cW+4=
X-Gm-Gg: ASbGncsr6XtT3WQmkIqJNh+GpH9r25q4ZPuDbiOqrw5JVm0pPzRtqIOrW7u2MQXZ/Cg
 mzxuRPIG+yVRC7qVMvB9sAguatkm9x27quo3K3CXANwy2CyKyTDc+eyDM3zU2i7hg5RRXXakByt
 igFzUz38SYLqh9s9IYCO64/qwKS7+nfaMgmVMV6CA+JdLZghldMlyd7aNfr9rbnvhaq6fe0q+rh
 LCCJrvk3aaeF3FXAwJCNOiVvkhoio60qFi3mPd8hnSW/sc/YG89T7cHXNNCHaiAjpsbP+hcWkb2
 2oMD7uxUtyn2r4/3ULSF6CAt+PfcfwVkkQR7x90SLRJZLa8=
X-Google-Smtp-Source: AGHT+IF1ZiuisnoznXxDurascLPnNdUoUs8Hl8vkZxl+e7wSuYPvG3eVVXhL9xZiwSReknzxBoYlpg==
X-Received: by 2002:a17:906:6a09:b0:abf:733f:5c42 with SMTP id
 a640c23a62f3a-ac20d852f4emr73755566b.8.1741127090386; 
 Tue, 04 Mar 2025 14:24:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf5a6e59ffsm629108966b.171.2025.03.04.14.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 068806013F;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 16/32] tests/tcg: enable -fwrapv for test-i386-bmi
Date: Tue,  4 Mar 2025 22:24:23 +0000
Message-Id: <20250304222439.2035603-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We allow things like:

  tests/tcg/i386/test-i386-bmi2.c:124:35: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
      assert(result == (mask & ~(-1 << 30)));

in the main code, so allow it for the test.

Message-Id: <20250226140343.3907080-15-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index bbe2c44b2a..f1df40411b 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -22,7 +22,7 @@ run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
 test-i386-pcmpistri: CFLAGS += -msse4.2
 run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
 
-test-i386-bmi2: CFLAGS=-O2
+test-i386-bmi2: CFLAGS=-O2 -fwrapv
 run-test-i386-bmi2: QEMU_OPTS += -cpu max
 
 test-i386-adcox: CFLAGS=-O2
-- 
2.39.5


