Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9331ED74EE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbw-0004Gd-2h; Fri, 23 Jan 2026 09:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbs-0004DX-M8
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbr-0007mB-5j
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:04 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso23957205e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180282; x=1769785082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKDjyRCg+cd8tsWJxtS527dnA8ZjwwQ9JRmbvue6S9g=;
 b=zJIlFQ1a0W2Mulz9RX9OCnGQliFXwyWHTDM94tDdI1dCmar2UazZI8HATbQgY15ksK
 Jfyr808MZ+yIIsUO0EM1IHG9NhUouH6oJR2SWcFAOofCWvGosmUmgKbHmGuU0Qh8ssrZ
 pu0B3ltGV50LQNuRVVbxMhAUuHoHI7OSop1ZVT+MsCPKI5mWYnibweBsRB2GtI9PTDXx
 ZxD2tzHveylEmGQhAMgc6fTYhmg2WVwkqyDg71a5WebO6QgtvXbefjA2IMWJitHGfkgb
 LlyZazx1Dg62xXe9OxIivMKu9dbe4+LZbBV/cabdeMwzPukwlJBRpzFMJPNzXDjGUIR6
 FQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180282; x=1769785082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PKDjyRCg+cd8tsWJxtS527dnA8ZjwwQ9JRmbvue6S9g=;
 b=El760eP3QOdkd/Spo2NHWYu2lK0pGy6kMndFLN7nqQ+hAo+Cz0qMbmHpgNcP3Ohj/4
 UsT43HS4V0tu5Z8kC8q0Zqf5X3VSFsujS1Q6gaU+9bZXmQzQmx6JUnPQzJPDePzzAZDK
 eBX0XWsiwxehRsEi1yXjtDk1JKMJ46Kesn+jjsOdmlXV6OgTebkZNJVXuwA3JjJXVr8O
 HqXh3BdZeomjwX89L6harwGVUs+DrO0+RbizNcvWQEUz0MD1Ctnx6VTRXZKfIDGdyins
 ZmkYHokQJKzo8BZoRHLWUKu+lWhRdrZIS8Dzm8pVvjgswsOjN58r1LmCEufaN7cxBaki
 dQ3w==
X-Gm-Message-State: AOJu0Yx5BHTbwbyffdBO+J8AFin0N8BNVQCsDf9qEaFimRsxgP+OENfI
 3SwXTE5nUB0arJwWEkosh5g881iojWfCj5+yaDLnCKm5g5emCl4pfaLITnDjvMWUtYA=
X-Gm-Gg: AZuq6aK4LDXdxarOukFBZwUVu4yft6tZXFORZFTVbC5YecuEDj8XACQQgG1I8zkNXbH
 oS7TPeNZhIqe2D+3LERDvnawtJp5w8+zd3wfyW6aXzZoZhJYpBZ0yfxETL16EaLT4Ijtol54e4O
 p9l/VhNoOh5cIusY/eaZOg/M5wz19HCL8UI02QFUlDxbcJ1lK+ElNNlMWsqDqYZKK1b9fOCCaOZ
 eBR6T3jsLFWiyjiznqT4wsZnLMdtOTlhW0J6fvf7/QLjMR0ofnbg0zhu6OSpBR+niXCkTHocSCR
 3xobqMfz779hGeeC+ytrDow4s3D+1Zs35zdOXxAp7+K4uK1jsDdeB2cQbaptf9rSLDLge+m3nQR
 R1S/lr4kU5QBUZsGuIAI3Pzja9US+ZdNRoUu+AG+NIkA3EWOXO3OVUX3PpPHGFhxTC6Veu2ZwM7
 EjmJ+i0qaKqi/r
X-Received: by 2002:a05:600c:8691:b0:47d:7004:f488 with SMTP id
 5b1f17b1804b1-480470b7d42mr70391195e9.10.1769180281646; 
 Fri, 23 Jan 2026 06:58:01 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8c0aebsm60924395e9.15.2026.01.23.06.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D54EB5F8DF;
 Fri, 23 Jan 2026 14:57:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v2 05/16] MAINTAINERS: add maintainer for docs/
Date: Fri, 23 Jan 2026 14:57:38 +0000
Message-ID: <20260123145750.1200879-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I would like to help maintaining qemu documentation and I've been
invited by Alex to apply as maintainer.

Files in docs/ that are already maintained will continue to be under
their respective maintainer. The goal here is to have someone that can
help on all other files that don't have an official maintainer.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260115203529.2713193-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3604422f8b4..a691e3511c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4511,6 +4511,11 @@ Incompatible changes
 L: devel@lists.libvirt.org
 F: docs/about/deprecated.rst
 
+General Documentation
+M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+S: Maintained
+F: docs/
+
 Build System
 ------------
 Meson
-- 
2.47.3


