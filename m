Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46706CF31AE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXf-0002xZ-On; Wed, 19 Nov 2025 06:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXY-0002qY-DI
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXW-0001tP-1E
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso33662095e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552396; x=1764157196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5Ua+OldA3Po2qJSLFhhp2ZpO8rQAQdKGbUvM+/U0S0=;
 b=XvSmcFxdu2Bm+r2aMXMtUczxkDUPpKiZY6YoR/uqKYDNRu/FCcvpHSJNPjopYuNE3+
 dQyso0CSWSegGDvQ+u5QMRLwx/vaefrkF3kQjkns/TelUIqTmTgkUMCoqJ73wq5wT6N0
 E6gM7O7zu386Ut0cPcjQrudmQwaK7m48yWMfIx/dJHsVKaLkDY5A0JRbnD7Z4lx+mX3J
 RLFes1tlA86OfgsChda5Fr6RQqwufGzXE9XsjKdqWjABt+3eysMYg7hSR86f7TiVlWYR
 TMeS6zPR/uSSLGL4IV4pg+PUwyycBxP+bseE9fr5ocEYeov2cbKOjD6WXBZHLupFp1jA
 pRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552396; x=1764157196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a5Ua+OldA3Po2qJSLFhhp2ZpO8rQAQdKGbUvM+/U0S0=;
 b=JE8eXLQMY9hrToBdIS0QnXHf4EEM39VhuV9Uf+5zZ02cX7mRM7TNcC5qHW/CDXDEVA
 nednYSdf3JvQEKWpWURH9U2lB04f445UCyec7tVSl6xLEuqgt7iXJXQHXeqGaTgZMbh2
 SI05PPj5DQQlIVA5oMsTBBG6DdZcRDXLcFPgwAbI+hnXAQja85BV0s8551r2e0TwUynx
 6eWAidKi4KBaWoZwKfo6NjYIGJ7dUFJF/a3obv9rPPTKS7RLC3qduJk8baI5H1Kj1d3f
 t7wzX+v4ZRH81PWYQQdTM4w3cf/MdfFYb/hiGAbe8nY4wgJzH3hPhW4GrrJDwFMW5QxA
 JmoQ==
X-Gm-Message-State: AOJu0YwiWRwNdHE2dGzU9RFcxefGsDjNgvZ3a0wWkQaNX+bFi496JXa+
 RaCZBUH6vP3sES2madK+VdaMLLOIZz2ykLgPeKumVIK4mJ2a03j3+aNfWgD38fAY7KikaBwp5t6
 2HNXO
X-Gm-Gg: ASbGncu/LOv4G737/LTQZ0eXRvZoaYwweE1E4q0RJejp3C+N/gc99raQjrYGEUdOOd6
 RyuhH4noNI5wY34HtXAJsqKrM/pjTfA9n2z5uLQf10igD+5hOcd9FHQSwn6eAM3jR8KYAzJm+Xf
 McuDHrTFbWwJ2yD4alzJGQygDt96+k50vFNh14OJTgOg83OBExN6ie5yf9KdKT+u8qGyZ/wHjMa
 6xbmr8zFtim1OIJmFIkItlyadutPqBXkGBYkfKwoaai1/96miq78BAT5d0zdWUQOoPlYi/8PlaG
 XB+cFZ2zdV8LBcLfuXWdlUHuPwuUfeqlIT6u9pX5X3bvGO+L/dKDUmH6/Si7mlyPhX7PCn65l3P
 sgltHGh9SKtSp3cOZoUO6OIYJW9e7JHh9RMCnZ4Rsc0CL3srWF7hRhLx4gHHGT2OS5D933dMZ2D
 1hrDTWn0q+wmBdJ8A7fvB09Q==
X-Google-Smtp-Source: AGHT+IGsEwlg0WQ+gw17kLw65C+QnZbgEAgj6/uNv8BbtRLyRa0ewmKqKVOYWkn85cSBOdOJ85j+Sw==
X-Received: by 2002:a05:600c:1c20:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-4778fe5db1dmr171622995e9.14.1763552396306; 
 Wed, 19 Nov 2025 03:39:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9723a6esm41690495e9.1.2025.11.19.03.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69FCE5F8B9;
 Wed, 19 Nov 2025 11:39:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 eopXD <yueh.ting.chen@gmail.com>
Subject: [PATCH 1/9] contrib/gitdm: add a group map for SiFive
Date: Wed, 19 Nov 2025 11:39:44 +0000
Message-ID: <20251119113953.1432303-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Some SiFive contributors use there personal emails. Add a group map
for those developers. Please confirm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: eopXD <yueh.ting.chen@gmail.com>
---
 contrib/gitdm/group-map-sifive | 5 +++++
 gitdm.config                   | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 contrib/gitdm/group-map-sifive

diff --git a/contrib/gitdm/group-map-sifive b/contrib/gitdm/group-map-sifive
new file mode 100644
index 00000000000..6ba761eb225
--- /dev/null
+++ b/contrib/gitdm/group-map-sifive
@@ -0,0 +1,5 @@
+#
+# SiFive contributors using non-corporate email
+#
+
+yueh.ting.chen@gmail.com
diff --git a/gitdm.config b/gitdm.config
index 9db43ca1422..06ac729c7bc 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -40,6 +40,7 @@ GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-netflix Netflix
 GroupMap contrib/gitdm/group-map-redhat Red Hat
+GroupMap contrib/gitdm/group-map-sifive SiFive
 GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
 
 # Also group together our prolific individual contributors
-- 
2.47.3


