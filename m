Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19782D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfSK-0007Wv-RK; Fri, 19 Dec 2025 13:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSE-0007WU-Vp
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:43:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWfSA-0000yA-Vy
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:43:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso18632805e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766169828; x=1766774628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sQvEBkRJhOB9T8OAo7Ghxbc4t59uZfawKd6nFdcJ67I=;
 b=TBbDvc7vTsdi/KS44QGPArzMZNp/17Wk93WzyA0q9JLleSKDAZztQtasALgl4j0QMW
 4RxqmVJ2+2W8CpNpeyPB+GrDqDE+Se2OQPjTg4nwZBrslmcixZxAhHyCFpc8R48NQHBi
 VuNudDH3jvghrEJkSkePLEDvcrmyOE43RcrsFGuUTn6E2Qzje3rEycCYcdvbx1uZ3ypj
 r2fw1YXTLOW/6u+WN/tKKRiXXj2HHSZFFRfKqkBQFg0ly9S1Xa7TKOILthb9H2vPGA3J
 6TzHtwMBPdDj1ILwA4D/hLsO1UcJhT0odikhKUWF62qpPjfIuFKLPbbMe9BW3TIcz7T8
 SWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766169828; x=1766774628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQvEBkRJhOB9T8OAo7Ghxbc4t59uZfawKd6nFdcJ67I=;
 b=qCnfHaSZ1ULc446HCSXPZZQuY7Mb7JjAxD9QPmH6Vnc05qC7ALhQfBef9tJspHG+by
 qf81OlOV2/vKKUN9aiyg8MSZvYXHuCVp7F4OnJh5GPjPwvGSENJCmAIWPg+LmC59F3F3
 SSTFxmXRWxEbXv8MwfI/nrH42W/o89MHxjzLisx/0akK4X8Er0/Osj5MNhlGxrcJtzC2
 UTcl5hII7qqhhyiMA0f0K9uSOwvaygGqq2m3Es1MlCqgQHPuamZhc0Jju3rTGhIODcmq
 nqU7+K6DUTSPOG2ivjC6ih1vtH2zDahrXWDrr8IAGSxA3nVT4FIGp+HKwZaVex7ftakF
 fWOQ==
X-Gm-Message-State: AOJu0Yxn8uY1GULwwbKxH6Y0AxTQNme+0H7sgSRwlG7sA5a+z1wyAA03
 M0cmlpYyiqQlXiOB3yodftcH4mlvMKTvKwqi3aQa17fihz8Aq6KBasXKk2D0sopRca9iBpyqhAb
 I+AFgOHw=
X-Gm-Gg: AY/fxX4DMECjS3mNmG+6P/DTYurdbALMd34kk6q0y/+68pa7LMMmPHv+mXHA2ic2Egr
 qBpsIWJS32AF7z0mc9gZtbnlS5qDMdHZOjS8uQHSJR/9lYkYjQ2gzLWohSKgtPvBhr1kK0kC9aQ
 A0gUeovoQdE3q5zyqMF2SdBOTSfU7U7YX5WgkYjv+F0kdpgrIbCpHwSPM3IloTUvyCfqYynMZ2+
 DzU0AUFbuvLOZnH7r9aT2HkKY8y+xX203G/SD0lhY4YKzhAQJg311du2hmm8SpqDLbMEW4AvUwW
 7ckEtO8qmFaSt7XjhR+LbNGIC8Q2qKKnvEdYrTBPV/45A0nxWbtLQMPJqeDbceAd3d+k21Vjppx
 rXtBh6W8WFP75xKdeIqtmt5tVH3ffbQneSC9zxYy7D/7xdwW8uR7GJ9gRnj0jWv/Yf9HPvai3J7
 QFHpcPWX0FLAgiuKX9OzIqFLdOABGHglA39WShuOUUKAcQ3LHbIX0upBolfCSq
X-Google-Smtp-Source: AGHT+IH7f4IpUdRAkH/EhttUC8xAbtH8hCtRp5zGeBQzAeMNF+gOX84sROWxQjlzrxUwnvjUqcEufw==
X-Received: by 2002:a05:600c:5249:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-47d19595e32mr41990385e9.21.1766169827843; 
 Fri, 19 Dec 2025 10:43:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm108332165e9.5.2025.12.19.10.43.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 10:43:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/hexagon: Stop using the legacy native-endian APIs
Date: Fri, 19 Dec 2025 19:43:42 +0100
Message-ID: <20251219184345.96786-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hexagon is always little-endian, making the conversion easy.

Besides a lot of preliminary cleanup are already merged:

. beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
. fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx

Philippe Mathieu-Daudé (3):
  target/hexagon: Inline translator_ldl()
  target/hexagon: Use little-endian variant of cpu_ld/st_data*()
  configs/targets: Forbid Hexagon to use legacy native endianness API

 configs/targets/hexagon-linux-user.mak |  1 -
 target/hexagon/op_helper.c             |  6 +++---
 target/hexagon/translate.c             | 11 +++++++----
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.52.0


