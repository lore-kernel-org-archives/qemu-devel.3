Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C68DCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ3-0002fw-7S; Tue, 26 May 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYq-0002bF-5z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYl-00069L-Gi
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso25101115e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793373; x=1780398173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVKvvcFZA7qeNP1zeIYLgBVKsLe8igaQLT3KMhNnesE=;
 b=ts/5J7rPkqtqjA81NzA4BrnBkCvsmQshMT1uCBqbjL+mmHQ+FvG4mcL+TtD5/MFEiW
 2d2HHhT9GOm5Wr3Tp8P0eX/pwMlKvIVXN09mI/G+t0J38uFHuuZ1iYD7AtKG/uDutCeb
 /Hl5kUJY41w3XsB5iYLh9DCwui+dT8Wa0KI9qOkHwCr2V1iiJN8RSF1zLhSz0iHr3MyL
 Q+0JyKqLHyloXc4cS1ZABaFayTzitbQuOVg7kn4rFXTonBzCx14L4nPM6tJnQ030GNqD
 dsbanrGj6aUG3kwcRgWZP2jwgKJlLprmYetYLZCSPffwkwgo1dCtnHRr2zmrsglaG3Mv
 B4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793373; x=1780398173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wVKvvcFZA7qeNP1zeIYLgBVKsLe8igaQLT3KMhNnesE=;
 b=l6S5gzW3wVRbMiAf4IUkWx98sXXFM8kuDhuaIXwC2jyeEMtZhcJGr2H+jpqquGrrwV
 z8LWqQcyGn1q3na8v6X27hdiyxZFTkE0vL1Tvv5EzFrkVvuQtPfXd+r6AJzROfAhMkIf
 YgE9Bv71tY8ZhKGcp2aX12cbWGzZgMeGuI1um3EALgsmb3uONJive3+vQHpjB8xu5yHY
 baKKCi5egSm8pfcLSILn/KxwS4CJDll2zcB47WpEinWoizVd85hL4nTRSS4To26XPwOB
 SYMpBmYPwkYMXH9pvWV3mOk3NAVMn8FCaXhjMEQtUIB/XtCd3HIwPMqa+MZKULFTyImi
 0SiQ==
X-Gm-Message-State: AOJu0YwzLh5uqAUIzSFn4jgEQh0dPyDXIej0v78W/g5InNGZGehQCtye
 t3cVeSZd/Z6RgQ2AvXVwXsNG0ZubfomT/DVs/OlES3o2xS/dGJNLx7Lv6Q/Ckj682gs=
X-Gm-Gg: Acq92OFFufv82HAsQI8n8d03cM1wewuVryKK92+KCONRtNelII/26ES4+UH/+68eGsU
 Tb0fD1bl7DQYpnM/OUdFsYfZBNJQD7GJRLmxSL34+oa8b+tN8vdC8BU8FCsVIjChGTOyyq/hdhC
 0dnDwGoi9OmTQZoeccErfczYAW4xOEs0Ying3nuk8JuQap8C4rv9mrkMqDt+fQf/Z1HFCEz0YFN
 OeAVrr9MAljbvEic+/orMTsMGl0LO3zs5YIPUqBjKnOAKq3nvsNzXlhw7i7EaG5Meo4AgmRQ4ld
 sf6GqqGNN1djI9smjDwtzxJiaeSBYYRtPhsBkELokKeZso5Y1XVbPEpt3pLaeyO1Numw1SIxuHw
 D1nOa4J7W7nwUhXmeSgYQAn4hFZ0w/dLTtn3ngCdF9sSg3ntR/q1Mrdy2p7b4fLAJhZvy/RHlNG
 AyR3kuOi5VcUmc182ezeV5pbA=
X-Received: by 2002:a05:600c:a402:b0:490:3d62:eb0 with SMTP id
 5b1f17b1804b1-490426d7019mr248024605e9.24.1779793373391; 
 Tue, 26 May 2026 04:02:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5cb9asm37363433f8f.27.2026.05.26.04.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3A81604B4;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 13/14] MAINTAINERS: Cover debian-tricore-cross.docker with
 TriCore section
Date: Tue, 26 May 2026 12:02:41 +0100
Message-ID: <20260526110243.470002-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-5-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a534f91e87a..08363ab5449 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -458,6 +458,7 @@ S: Orphan
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
+F: tests/docker/dockerfiles/debian-tricore-cross.docker
 F: tests/tcg/tricore/
 
 Multiarch Linux User Tests
-- 
2.47.3


