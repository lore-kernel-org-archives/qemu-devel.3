Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7084DD31A29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwLq-000061-OY; Wed, 14 Jan 2026 03:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfwLi-0008VW-5e
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:35:30 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vfwLd-0000VI-Or
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:35:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so4581695f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768379722; x=1768984522; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i8UvDsIKv8ncHB1APuXS4hiPJNqWLucIdun2VF7bmx4=;
 b=hofXTtdOAyhrOgdz63aJnrODWSchZGelP7g04Tkoj030hYo0/BnTP964Mox4Zqr14d
 zGehhoRHkt9ufcth7Q9apXCU9Uw20Wy3HrweIPWhBRITF3JydWQ4AcT22zAWi5q9fPpw
 nDLQcCQnTKds60P1rM6/QPJC+ZPcMYpYoCePmsME42zO+ljb8SpfWnEZJVioiLLJzjua
 hEHv8Z6Ck4aX/hgwl6nYiCqlR18Ttg7bwjUIf0KD9nUzcsoY6e8D47Gz2ItfZFLxtwhI
 zF5q0HbD99EsycaIneoS7bl5Qtd5oR6lPdCvAIR5FsT9zNYZX7iZeRQknqM4HSNbLOQK
 u/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768379722; x=1768984522;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8UvDsIKv8ncHB1APuXS4hiPJNqWLucIdun2VF7bmx4=;
 b=WhuEifJ1bUYZhudOFnhdzJgY+cfMoZn6f2mRRladuyxSFSRAi/SDvhMzyYShiiS/bH
 MiROrvyiIUlH1usa0bUJkFwwzaTrSZ5rMNOedKoq48Cah7Kl6BbDAwe/IMWdOqp/ceON
 amF/2rSbPuWjdGTwIeUjgIFF0rQFh8ndQmoFNWFy+g80WPnW0gstpTxfdfLcKMmp+Hp9
 uR7V+AUXtRqUm7N9lmXuTMj5hrgj2QNy+3pHgyXJt/MFdEBSWruFiVlNeQCs7fODQDwH
 fLLOmBWoyojiuxSDIomSzL+4kXYBUSOib4WOOOUgBI/qnDW6Aa2z5Q2vPUjAmI9c+Oj0
 WOJQ==
X-Gm-Message-State: AOJu0YwSZnpTJCDkIQrCrWtQksw2RHu3YTZfvXi8JoTKn/qMg9YJpo/G
 aJnSg1WJBjOSQ+9YblamW+amtTi7vIcvI6wfyHSSwpUe+ptltWN3MgZN83YBTROkcdI=
X-Gm-Gg: AY/fxX7oRHYcW+02aNM3dCiJDuQncBgj4vFCDnn8qLQacxXGcM/uNZl+R7v0hmkSz/R
 HLLYvIx4wuSdCW8lIsy0r7kZ54CkzhUdH56b4d/haOdVUzAFgAUwkgN2TJfGXzCT0b/t1Q56I4/
 06A4O8ymuxxGvpH0VQg/TS+KrwnOguRaL/oePd3dajH25XxMiP8aPcwCPzcF1VPndN+JJzOihSo
 TZwKYtW4rIsduMft9X//eCnxxAO1eIe7Fiek00/tWc+wMeuhU2w5tL14n0+M9C+mF+RJsWTwzps
 CdyMZDHJN1l92+3plaLqaa9xQvkzJSIVLgyCkilIk750TdI+91JOoEP4a8pRnIhWPDg8fCzYHVX
 nIktUpks8pyT2sfkOfGbdvpPod79JOXQ/SOXkd037APrr/o3jJnlRUrjt95firA1AU0lFTMeNt6
 FkEdHvQumbrDFSgVlx7OsCZrtLjo1IE/4OevzGQg6JZ1bmy4/7W0+K95+dRJ68B61HwTHMEk7kk
 9ZZAewrsEaqOPPutBmRmzUh
X-Received: by 2002:a05:6000:2302:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-4342c549c3fmr1560739f8f.34.1768379721705; 
 Wed, 14 Jan 2026 00:35:21 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-214-23.home.otenet.gr. [2.86.214.23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm50121053f8f.22.2026.01.14.00.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 00:35:21 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/2] arm/hvf: Add SME2 support
Date: Wed, 14 Jan 2026 10:35:02 +0200
Message-Id: <20260114-sme2-hvf-v1-0-ce9599596736@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADZVZ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MT3eLcVCPdjLI0XUMDU3Mzc0MLS1MjQyWg8oKi1LTMCrBR0bG1tQD
 VLNQKWgAAAA==
X-Change-ID: 20260114-sme2-hvf-105767189521
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=3xdukIEOCUPtNcBt1H1Mv4dhwzYE4xjPXdIZZf6PcTM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBaMVZJNm1SNzZ2U3d4UlFwRGUrN0xxK2h2NHhWCjhMS3dsdU9SZFlRdEhteTVy
 ZVdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVdkVlNBQUt
 DUkIzS2Nkd2YzNEowRVA0RC85MmFhbTFIb05tVkxybVpQSkh5U1oxZHYxdUVvWmxuOERhR1h0RQ
 phK2lleG93N0JJVmVZaUhGUm9BdFBPWTBtVkkvTWg4OU1YU3VNN0RqSjdkakp5N1Y4cnhYaEJaN
 UFMUHBFQWlpCjdFcWwzaHQxbFJpTnNDdXRBaW1vNTl0L2xVN01QRkY4dGVHNmpuZE1TQ2ZITUlK
 dyt3ZWowQ1hHbGd3L3dBU2QKTEQrbnJ2ZDZreHp2VldXN0tpRXVxN3VlZXhRQ0ZLWWo2RExkMmR
 6dkJ3Z0MvVU0vRm04N3dvYXQ1YWJsbzVsLwpvYTducEkvTk1hT1krbHlVSktxUzdkOW1aOFp2dW
 hDektsVHFmWTFjcnVDMm5Qc1lTR2dVT2ZlenlkbWpPcUd2CldZWkk2RUVTdTQxczRzT1Exc2JqK
 ytKSm9UTEtCQmFOV0c1UWlCeHZzRkVCUEs0ZXp2bDdMQTEvVlZSenZxcSsKVjJzWGNBbW85NllM
 Um1XNkxMRXNGLzFNNC9UbkZ6T3R0TG1YaUFhTEpsZndxUkhrbFQxQjhqWWpIY0R3TTczVwo0a1l
 qQXFQbjhmRzZudDRiT2JGRHdkWmhDNkM2Umt4Z1Mzd3RoWk1CQmtmb3NxSktERDdzRkZORHplQU
 I0U1NsCkV0TXB3dStCYngvbDV5YmErd1ZyYVJXdnNPNHdvc1YzK0xvZDVsMitUQkJuc1ZkNGdIZ
 mR3WWJqNG9NQXliTFYKTXBjQ2NMNHY2ZVZranppRmZvZmxPcnJQcFFJN1ZEUHlLUzhNZlNjWlZw
 UGFGdjZMMW05aEliendmZ0NLOWs3dQpNdlVQSDhYcEFxeFAzRTlta3ZPT3NQbHVBN1Zpa2tKYU9
 KWTc3VUo5MlQ2UVlaQ0hHWFFEYk1jcU05R3hrT25rCmpzOTlRQT09Cj00cHg4Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
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

M4/M5 Macs support SME2, and HVF exposes this functionality in its
public API.

Add support for it in QEMU.

This was tested by running an SME2 benchmark from Arm [0]. savevm and
loadvm during the benchmark's run were used to verify migration works.

[0]:
https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/1-get-started/

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (2):
      hvf/arm: handle FEAT_SME2 migration
      hvf/arm: expose FEAT_SME2 to guest if available

 target/arm/cpu.c            |   4 +-
 target/arm/cpu64.c          |  13 +-
 target/arm/hvf/hvf.c        | 318 ++++++++++++++++++++++++++++++++++++++++++--
 target/arm/hvf/sysreg.c.inc |  10 ++
 target/arm/hvf_arm.h        |  46 +++++++
 target/arm/machine.c        |   2 +-
 6 files changed, 376 insertions(+), 17 deletions(-)
---
base-commit: cf3e71d8fc8ba681266759bb6cb2e45a45983e3e
change-id: 20260114-sme2-hvf-105767189521

--
γαῖα πυρί μιχθήτω


