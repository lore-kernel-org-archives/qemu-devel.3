Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93495C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVT-0000ha-DV; Fri, 05 Jul 2024 04:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV7-000059-Pd
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:05 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUz-0003E4-F0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:05 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58b447c511eso1826305a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168856; x=1720773656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FfVguGP0p6xgM9XriF2Mad9KHJXeUAUG8KZ4GyS1NQ=;
 b=ea7ozpptbws+5K7sVD0qN2OvSgQof2ArzFRMQVJ8sHOfXdXUk0CP2Gm6m1sNCHdTSF
 uRsj8D33m6I+vhq+huwMOQw2VkFVZqlKsu1O85Qwo4yXea3txAtfpREAOm24qWHtV+wm
 ahBpohmM+MXyFO7LKys8ZceAlXSrj5MVJWaPscxlirOFp7rdSiuhdswQrmYrl4G/DV6B
 G8Ri2lB2aa7hg+ky98xXy6T4S/MfcIEhIibF161pvURDtv3oJrEHET1J32/hzUzEYUOd
 IwzaHi1DB+2dZBw7SwsMVRLnhns1+AJowYmwa3px+6+xG2UFGH8GDJ/1snashXsumlGx
 OD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168856; x=1720773656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FfVguGP0p6xgM9XriF2Mad9KHJXeUAUG8KZ4GyS1NQ=;
 b=cnsu2sp6lVgzkJgsKXp7diI9VGFZVBzOUk/TAEy25KfoPEkVmRG+rbj0WRfa1+upol
 GVnHSq4km9RIgZ3P9tvfgvPWNe96oCsaIryZJ9U1DkVGduiYGNaEXOc06cOuQIgWxCXv
 +x31u+k7KqbMc2wWBSVQAU2LPfhKfhXNNFy5ICMcG7smI+98Q1VfppmucmSBhJ5nU1N9
 iHpk6HVfG6o2WIysq2xJGbCX7aITLl5VxuNQO/8mnJ4pVB3+K3W9KlamPdOxc/1BkUiQ
 P3Z2RsHTVs5jWsFPkiaADD5NEAmNHK6o2TNSqku03i6g+rGZiV8ePNzpqf4R2ufdiS+V
 1jwA==
X-Gm-Message-State: AOJu0Yx8kR/kAzYhxOtPJ/+Mx0alau1VrZjQjpZx+z+uUncTeVgURlgb
 SqYrG4JSEPel4zg9u4wvx4F+z0EhiCkGxhn+Q6MiUPJPMdqBCHhDen56z2bxxdo=
X-Google-Smtp-Source: AGHT+IEWJTEbeYlTlz9FLng0GJ9cWgzVYh+mKF5kwzys5yCxHDoethpxpMHVSuur1WnYnMRq7mH+Xw==
X-Received: by 2002:a05:6402:2747:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-58e5c8269e4mr3506527a12.33.1720168855792; 
 Fri, 05 Jul 2024 01:40:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c834e1sm9418172a12.1.2024.07.05.01.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 72CE65F9ED;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 08/40] tests/tcg/aarch64: Drop
 -fno-tree-loop-distribute-patterns
Date: Fri,  5 Jul 2024 09:40:15 +0100
Message-Id: <20240705084047.857176-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This option is not supported by clang, and is not required
in order to get sve code generation with gcc 12.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-4-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 39d3f961c5..dd6d595830 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -39,7 +39,7 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3 -fno-tree-loop-distribute-patterns
+memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
 TESTS+=memory-sve
 
-- 
2.39.2


