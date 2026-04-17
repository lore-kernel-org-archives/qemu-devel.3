Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A0DF4368D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgyZ-0005o6-UE; Fri, 17 Apr 2026 07:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgyX-0005nZ-7I
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgyT-0002lg-MB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so7596285e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423780; x=1777028580; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Fqw+v51cfo42HTqJlkbcjWxF+GsvxvBBfYyIDWMDPg=;
 b=r1bpWHlRMti7NiQvN2f/Kukt5F+xcGSyORdogXd13eYXIEZ3s464f+7nwyEivRNuAj
 +8JTN/uVxuEgqdeDmk4u/qTGBR4QKXwKIG8cig14vnBRWaV09gQJzjKQboMHufpjogvh
 Zk891aWoZZjGK3DtwqMWEhUGaSjmCQvidDy4HQtUUeEu8Ple1oFqT1tNAj+m+1LMxWhq
 2VLW+BX5Q396STkJ61Qf9A//keRetO+bjNKBeSzf7MegViee3576emOZJKLQ+axyR/Wb
 1gKv4vJ9PXUPGdo1HYh+3Jbd0FtxGvJIjCcTestKN4GFf4mWxhNU/6CBdIxrtN7wCxU2
 lzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423780; x=1777028580;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Fqw+v51cfo42HTqJlkbcjWxF+GsvxvBBfYyIDWMDPg=;
 b=I9OHXg0k34S8t6ain+B+NtEyewsLhT1gh8lQSkAfB6tIJ8iy/dtjcZyHiCppK9VYsm
 NlRDzTPWgUd6kSdaffG7nxkrnZJU6Xaqj99E4GBW7j8EGwf/hpJfCSpVcWeQ8YP2gMc7
 D/+4z1mpmeDpPZSP+JrXqDqVCqq8hw+Z1nK1FKGSbMHa1YmK2gk7kkC8rXrnLpegs6NF
 qsv5flpmptkxQU5TUSeZBFldcLHQbyjuddjc0NSn+q63urGY9OfqxbX+FPowRt6St3fU
 kwbG/LcK5mipHfZHi2lezIXhWLCY+A+5mawxb8MexJUwbIxF6Zz1cfwFkLMR/vPf0eYw
 hFhA==
X-Gm-Message-State: AOJu0Yz4bx2cCYM6eDkU60iy5XrsVae30kBJJi16F+RNYs0s/cvZCTrZ
 vBzcYzMr0Ewbf+v7Fg3E6M06xIfZEh40D4BVAfsDlbF+L2j8QBUUNaGfdi1QxrB2U/J6EP4JubT
 Rq/nj
X-Gm-Gg: AeBDieuKptm2kmR0nBXdfrnDo8XusN0lm8xOdXsYpWsttikRNgGWK11L65pEiKndLCC
 QMCBfAOY6vTCVKtYNoP3ENUChxetsgzFuHKEichyJfBKoeuUCpLcFb856SLdLPHBdqQqxgZ6PKV
 OdvL3zh+UeKHAY58SefrncjLyNjqsklGzDoZOpaNaZYcdyVlBAKd8TgRWRcMnw8edVxx8EOefMR
 g52HiBLrycjMLrDmNpBf/of9UgwAfK8ZlWCVN4nG4BOCxAlqVVISecnYm8HFHeLgCEVNZGg+Ygc
 c3+NaXIiNBNm5fZEY8UsohrEqjHwn5cwC+bR1tQoUXm36sEt7is4Gs4UhNPZBMqSX4nxVnI5IMB
 cf0FEPL5VCrWhbrvdIHYvv44dOIGPsa/X0Zdne16EVxzIqlY4Opivzwxz89FyX09MOImsZWGic/
 UZ38uqnIRD3hBOEazgw7g2OVfNWQMnuyEUJDgpQg==
X-Received: by 2002:a05:600c:1da1:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-488fb785204mr36117425e9.22.1776423779645; 
 Fri, 17 Apr 2026 04:02:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d023:c0db:d3ea:590d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm3811934f8f.37.2026.04.17.04.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 04:02:58 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v2 0/4] FEAT_RME_GDI initial work
Date: Fri, 17 Apr 2026 12:02:52 +0100
Message-Id: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF0T4mkC/32NQQrCMBBFr1JmbSQJ2lRX3kNKCZlpO2IbmZSil
 Nzd2AO4fA/++xskEqYE12oDoZUTx7mAPVQQRj8PpBgLg9W21idTq8fkg+rJL51M1A3Iyplg0SL
 Wzmkou5dQz++9eW8Lj5yWKJ/9YjU/+6+2GqUVXnqvXWMIz83tybOXeIwyQJtz/gIEtRjkswAAA
 A==
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32a.google.com
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

Adds FEAT_RME_GDI, some extra cases to arm_granule_protection_check,
and a very basic TCG test to check the prerequisites of FEAT_RME_GDI:
FEAT_RME and FEAT_RME_GPC2.

FEAT_RME_GDI is not enabled yet as no functional support has been
added; it can easily be enabled in cpu_arm_set_rme in future.

In the future we should correctly set bits in the fault address
registers such as PFAR_EL2, but I don't see any apparent support for
these in the existing GPT mechanism. Testing this also gets tricky as
I think this would have to be done from EL3 (e.g. by modifying
test_rme_virt.py)

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
Changes in v2:
- arm_granule protection_check now checks SA, NSP, NA6, NA7 and
  goes to fault_fail if set for the appropriate GDI encoding.
- New fields for GPCCR: SA, NSP, NA6, NA7 and GPCBW
- Since we're touching AA64MMFR4, added in all the new fields not
  currently listed.
- Link to v1: https://lore.kernel.org/qemu-devel/20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org

---
Jim MacArthur (4):
      target/arm/cpu-features.c: New fields in AA64MMFR4
      target/arm/cpu.h: New GPCCR fields
      target/arm/ptw.c: Add GDI spaces to the granule protection case
      tests/tcg/aarch64/system/rme_gdi.c: Very basic test of GDI

 target/arm/cpu-features.h          |  8 ++++++
 target/arm/cpu.h                   |  5 ++++
 target/arm/ptw.c                   | 20 ++++++++++++++
 tests/tcg/aarch64/system/rme_gdi.c | 56 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260416-jmac-feat_rme_gdi-71c2d2dd6770

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


