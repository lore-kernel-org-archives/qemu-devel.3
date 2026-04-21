Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D91F8FA80
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBzw-0006At-KG; Tue, 21 Apr 2026 10:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzu-0006AI-Ia
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wFBzs-0007OE-DO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:22:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so28108825e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776781357; x=1777386157; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=egd/L7I5n1WW9DP/TOR2ZsWDo+w+DZjeEY3rG+pIgHc=;
 b=ddyOeV0vW/o4i+8OuNp1YQxp5io/59raGR3DwKtAdJWKafL+IQqrgonA8/BIqOoltI
 jeEmNpDqavbbJAmi5+FBQ9GHRjeNx92+byI/glvf9tkCWfOriB0pNoo3s+no0+q7Cm2t
 X8T5enXksAL8n31kGGwfYsKa7zeiaITJG9aeAEPe4UK247UdnN0sbbtqpr81PmaDCmmj
 947INkRryZlxb0G0CXcoviyf3DA7QxxMSUPf/DH1AvttkPgi/TiVr7a6/pSRR1vtGXrU
 KNfBir3nph/Oles7N9OFlGAOpUxafMknvyZMtYwftq4SZ3gnG34TN5hdTparvyOTRY1L
 oUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781357; x=1777386157;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egd/L7I5n1WW9DP/TOR2ZsWDo+w+DZjeEY3rG+pIgHc=;
 b=Vzs/wEiZ93bjHe0Ik5tiqdr9C6xX6uI+pUc23bd/uU5XJieix4U2U26XOj8Ivd2W0I
 3zRkitsa97clMr5V9lVg42VuwkSHp/6Wx+HaMQrIKvga3wwY9rmqlUs7zNWD6fNa8tNt
 0Y382q6zoSLEV7rctET0kT1D71/BHAkFHCi40c6L22x3DEs1rYbF8nHAJ+OFQJ+XRN5H
 AtH85oK/97JbkdGPRnCTqNeaPpw3FJ36gYsekfhLQLc8WIi47Q5wSWYnQV09A4vfpCmi
 NB95MvKuQrH/fJmemmZ6GWUD/VpIRXUHBTIixKYLsE+51dtHUImblQ5Ou96FF83OYpo0
 Fr0A==
X-Gm-Message-State: AOJu0Yxrro8hgJmvZFhuHzTo/f64OrygqLKBLMfxduNQLjyehrl2RPTT
 gc5VnMd+kh7RUgOyOcfG6PT/1q8cp01x6/xWFPNgQBr4sNOVRq+Xn08X5upK9jXEnsg=
X-Gm-Gg: AeBDiev8bBChFbpaPzMeuJuZNHl/db7tryMy/Nepc+Lt1mFY4J311u/tg+icvx9QTHZ
 7A8LII5CEHDe9VGRHYihPwlg4pOWBQoJo5fae/RYAnpdTAMtH8FgdR3YNXdWyJbO/CCuE4YuIg7
 fR79mhOau5Y2al9uUG6TpsNJJNiuD6i2doqoWJ1qMvM7TPyYSp7Y2m2BjD4fFVimJ52kuCrSG5a
 T62D1ufi5qv3/rqFw4pXM17Z0SPmpgKxeyWaJZdz3G0QA/Vqvlws0X2ilWxBGL2yVecaeYiJojK
 2RnkV2RWewCWJqTxmyw7uOEHvhgRcJ2j4QeeoRst/uXkdROZe8wcPIyx719IQfSmcjg7CFu2Q0J
 OAdgaiaCCD1ZsKCavV4vIOnQKaVLL2VST1kdmaLBvIuhf3ctglWasAGOVJuNPgOKqthNbFC0NUL
 UlK7ilGa3ChJaMVEkJWUuQMfMNrqfHZjDA7hz4+w==
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id
 5b1f17b1804b1-488fb77faacmr224625365e9.20.1776781357441; 
 Tue, 21 Apr 2026 07:22:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:5364:f814:f749:9bf5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cca5743sm164250465e9.9.2026.04.21.07.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:22:37 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v3 0/4] FEAT_RME_GDI initial work
Date: Tue, 21 Apr 2026 15:22:33 +0100
Message-Id: <20260421-jmac-feat_rme_gdi-v3-0-ecd20c77eae1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmI52kC/33N0QrCIBTG8VcZXmeoa7p21XtEDNPjdqLN0CHF2
 LvndlUQXf4/OL8zkwgBIZKmmEmAhBH9mKPcFcT0euyAos1NBBOSHbikt0Eb6kBPbRig7SxSxY2
 wwlqpFCP57hHA4XMzz5fcPcbJh9f2IvF1/aclThm1R6eZqjnYqj7dcdTB733oyMol8UmoX4TIh
 DKu4iXXcJXsi1iW5Q3wPk8V9gAAAA==
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32d.google.com
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
Changes in v3:
- Test logic changed to accept any level of RMEGDI >= 1.

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

 target/arm/cpu-features.h          |  8 +++++++
 target/arm/cpu.h                   |  5 +++++
 target/arm/ptw.c                   | 20 +++++++++++++++++
 tests/tcg/aarch64/system/rme_gdi.c | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)
---
base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
change-id: 20260416-jmac-feat_rme_gdi-71c2d2dd6770

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


