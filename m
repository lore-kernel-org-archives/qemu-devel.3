Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18481CD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Hr-00046B-Sm; Thu, 21 May 2026 09:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hi-00043e-7E
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3He-0008WD-Vd
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:57 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso2992774f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369471; x=1779974271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hda4e9PNEMyhesRE8+tUzLA86UmpB6c7B/SqvsDjFos=;
 b=Iw0OBqbOaQB7gu8p1FvR6Ev/HOcfO5LwT7+isn2mv2mhyqBqJugVeBB97lmj7sXsE0
 g6GeScGGkAiQIvsz2P5x2Az8m6Fjxdg5jK+l6jbm8LPX68lksMivLZ7bo5A6OjNuuVP0
 5KBjxu0LWVz7AkoxvSbMcs60DldH5XeJHsRXWfTwCl1ChouLHdhpYFrg/XM6AzXSfYIf
 2XKq0rDQru/Dqj/QKtaEmp/H2gYmgmps2UkSrdrigE0g3ggmJIbRJGUgXRyux4faVTjr
 7VRQyeV1BgU7TTqdJfuVYIbbO1Zjj7bCcaW6EC6JULAxsdheKig6k1ChtRl1Zs6JBHop
 rTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369471; x=1779974271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hda4e9PNEMyhesRE8+tUzLA86UmpB6c7B/SqvsDjFos=;
 b=Xy10hSZVzwckk/b9Mk/XmP54DbH8uGHmwU8kbxLuhNQKRwDeJuJGdYtNJ2TVGx9ub+
 qNFFIGhHsk7DQedxb7AIUgOkwazDE4ge/AxEKnBEbVQez1K+dWinVLYR82q7IpbRhZDE
 78Wh2mhKqaN3eZzhHWlVNN8IfpdwYmOt7zBuA8eDNnFvqd70IO+//qEA4ZmtSaZqxdjH
 66+CkXpDTgr3uXpa4Bpozmh+hmFN6vGWDtMjXtajpRyW8vWyXw8Sw+fufVh+drtnZutk
 +s2afxQHahF0VXRdU5m3dZrQSYjRiaBUvdD67KrBhYYdr921LmQsZm+NrHxzUJL+0zNu
 dyJA==
X-Gm-Message-State: AOJu0Yx8zj0T9TfswvC85Q2Kh5Mr/MzPQGnQg1uvBTGFUy1QVuA70/Gq
 46DgA9pUvW00D+fXSSGkSDKwe3Em0Va8sKnpiLazjTQDuoPwtw1GBQOTE7Xoa+F6AQA=
X-Gm-Gg: Acq92OGjx+6l7UfB2xjEB1U0zmJjzC9yLng5me+5ub+6Uos3X3ZwCOdUaEQP28xFsud
 5alsEwpbtrAbcZh/J9CRcYyiy5b7O5ZW5ZP5jQ7THh+TK7S8/bq7dVHdjv8n+YU7b7aIhuWYb79
 OMhmc72Wg1R6JS/f6YF2A8kF5B0pMPRQt8r1Iz0XL76gui9XSoehD7JnVAIKT94t6//uzlJ7B7e
 H+QopudbU+NKi+IQOBT2L/48LnIFmXyy22Z5Y6CpQZNYANhjV292PipYMtBpzg17d85u3HGgkQx
 YXC6o8FAzcu7lh+wXUAB0PlYwcfQlPphKRcT+mz+5KN6icIqyH1nOdndD+aOI7DPew1Dz2IVpkK
 uNIUT7FkZHhSm3j48XwPKVHLyPG1iwDrvFfmdlK3Kd8TOUI9PoVYt4p0nUqUcssGzXYNDzfDsd8
 2w6HKPEBEeSXnn+cEWRnE5lPg=
X-Received: by 2002:a5d:5f44:0:b0:45e:739e:499 with SMTP id
 ffacd0b85a97d-45ea37be6c5mr5360918f8f.13.1779369471436; 
 Thu, 21 May 2026 06:17:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92dfb1sm2856162f8f.20.2026.05.21.06.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A28660E4E;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 13/16] MAINTAINERS: Cover debian-tricore-cross.docker with
 TriCore section
Date: Thu, 21 May 2026 14:17:35 +0100
Message-ID: <20260521131739.540157-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
index c04fc1cd2e8..62754d18341 100644
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


