Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE75DCF31AE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 11:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLgXt-00031d-ON; Wed, 19 Nov 2025 06:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXd-0002wI-T8
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:06 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vLgXc-0001ur-2m
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 06:40:05 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3720e58eso6056110f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 03:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763552401; x=1764157201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0d5xhWfIjdXOpWvZDeAgLXbA7VXttJjNtkylyOiLvA=;
 b=dj02lHrpVfVBWO8RZQTYgbuca+nuiau8jBrwxuBI/gchk3UErkJ5EqjDxnz2SbRdvS
 LMy6WgrRx+LQbbvhob0wttO2a0vJBA8t0FMMuW40gsEkSbm76bcelbOWwnCpXl5XpMDf
 ASZKYsoSIBpOr4JNRDiOHFGgTTdUZxjGR3tJlN61zv3FMj59a/WlkzP9eTZ1aAr6VwpY
 18OYYej/5LnOzxdfbDMFJNkhzuQrJirX2xJCtt2KYFUS8Yxj1YA0m0U4LzCInfQmAxF2
 0lsDKPLQZfAT7Kl4jDLreZkjabXcQEbX5jGZYMMHL55iKVcUhRWKbgVMUMzy0mzz/4Uv
 oSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763552401; x=1764157201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0d5xhWfIjdXOpWvZDeAgLXbA7VXttJjNtkylyOiLvA=;
 b=WruInFnbIJ4xm/EfO3MZa5l2saPJnt4pDt6P43WPNfIy+SXd6v3Je+9H5plI326gqg
 V8mfRfPAbJ6N3kENyhkdQXSpJvfM/lhfsCISi7DLGanKe7Tg6COktCTavVfp0dnp7SBt
 nHddS5JV19TpSFrM8hoAoXUX1AYKnwTdg2U9ydq+o+JrXumewsM4Dgt+u4DGQzuAqgbN
 88MYZU418Be5RJJ4lXur/QvWHSxPXk8Bx3/DffSK+gcjFmhbLMRxKT9pE0gp9NeX1x/j
 VXRyx8g0+nGHGZ3vAKW0yCTdYv6mzF+6PnJa+BjMKy1n/wqZUfk/2685sbAW0ESCQ9eC
 geBw==
X-Gm-Message-State: AOJu0YyOG+Zw2fn3o5kzIZ7nR/6GusDeFdM1Icd8Et3BWwJfG/D6vrTH
 fsZklrsIr82SW0eqfUtWfkYp7x4O0P0zr4Tw4AvvEsVudwmVHVJamA/9qxFRQKfpydg=
X-Gm-Gg: ASbGnctzhuQbN3pcr/LIjt8n0TMI7bgCc+hr02aMbWRmEWyEyABJj1UbWvkpUYWwY3H
 jxam2K7tqCTbhEJGRf7XlajQRz7rnaLiPe49WpUl4zH+vPcmP4RpWhp6R/pwSh7fFS5b70xor3w
 WFRTFO6K8QI9kkia2j+CidAAf9Qf8w/rSwTwGhRfTGcGd++C89htEvWKNeXVOpchJBuN/LYEOjU
 +qHCzUZ45u6ZbSBGnb98jdldhS6CVJhuNW8GC2GXHpCMVNVilErKGyXmLgzEWB/I4iaXbQPd+fJ
 gy2HNE6ydlKRqgZ/iU2GmbU6faFvcILhtzjI4RdwDG0YLCSrG75je8ITcbUuDVKLVNuZgc5fQkx
 6QPxkJlZdHENsZTWTmj3UDkg69UZ28GVCFzn/7Z6TlSTKmIDlMLjs8WHZWY06iPKsYdLtCLWjIf
 SLrxqccTl9bU+OXY7E0Ux4kA==
X-Google-Smtp-Source: AGHT+IGaqiwpbbAoySH5CK3qY7UOe0AHilUKRjydd4hi1fVtukTj4oF6INhAzPLAdn3oYVG76eB5TQ==
X-Received: by 2002:a05:6000:2888:b0:42b:3978:157a with SMTP id
 ffacd0b85a97d-42b5937876fmr19650689f8f.39.1763552401284; 
 Wed, 19 Nov 2025 03:40:01 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b8a0sm38200969f8f.25.2025.11.19.03.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 03:39:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B3765F94D;
 Wed, 19 Nov 2025 11:39:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Amarjargal Gundjalam <amarjargal16@gmail.com>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Julian Ganz <neither@nut.email>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Sean Wei <me@sean.taipei>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Jackson Donaldson <jackson88044@gmail.com>,
 Weifeng Liu <weifeng.liu.z@gmail.com>, Roman Penyaev <r.peniaev@gmail.com>,
 William Kosasih <kosasihwilliam4@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 9/9] contrib/gitdm: add more individual contributors
Date: Wed, 19 Nov 2025 11:39:52 +0000
Message-ID: <20251119113953.1432303-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119113953.1432303-1-alex.bennee@linaro.org>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

I'll only add names explicitly acked here as its quite possible people
are using different addresses than their company affiliation. Let me
know if you want contributions mapped to a company or academia instead.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Julian Ganz <neither@nut.email>
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: Sean Wei <me@sean.taipei>
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Jackson Donaldson <jackson88044@gmail.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: Roman Penyaev <r.peniaev@gmail.com>
Cc: William Kosasih <kosasihwilliam4@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Tanish Desai <tanishdesai37@gmail.com>
---
 contrib/gitdm/group-map-individuals | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index d7116f5444f..4ac0f99b87c 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -42,3 +42,17 @@ shentey@gmail.com
 bmeng@tinylab.org
 strahinja.p.jankovic@gmail.com
 Jason@zx2c4.com
+amarjargal16@gmail.com
+soumyajyotisarkar23@gmail.com
+tomitamoeko@gmail.com
+neither@nut.email
+ktokunaga.mail@gmail.com
+me@sean.taipei
+roy.hopkins@randomman.co.uk
+phil@philjordan.eu
+jackson88044@gmail.com
+weifeng.liu.z@gmail.com
+r.peniaev@gmail.com
+kosasihwilliam4@gmail.com
+linux@roeck-us.net
+tanishdesai37@gmail.com
-- 
2.47.3


