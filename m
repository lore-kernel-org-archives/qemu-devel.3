Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DA7C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 06:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTxjx-0004si-R6; Wed, 17 Jul 2024 02:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxjs-0004rJ-T0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:02:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTxjl-0001Ek-3p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 02:02:03 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70b7a528331so2568524b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721196119; x=1721800919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OG5tWqvD7v5D7eW6eQiZf6y3nPVRndjEp8rarTrxMPg=;
 b=zIdExSEqI6uIq5jW3qJTgJnlpeK+zdARBoTQmQKC2FMtjGONjAD9O3CEuItdaPBrL1
 o3gDiK0QVRnkvWwqDtUdWcS5Q0DXangpnS3SNmofUerA+9jFRTdUFcKbZSxz5REEWVUi
 7uim2sK35hxICGRx6rnX1fJs7Eyy3YnuoPJeQjEPdO0oTz2YydNlnbHQq47X1a0wpPA1
 AIcfiRGoK6l8DqR4RWlANWR2dvXxgb3hFcF/5nlzttdWUAWnLgGK5GFFDSeH0attfcwW
 A7SZAe2bWFwqaNspybeocCpbEd0vezKXLHpAE5dK//Gn87znCovFZTsfu1pGdI9kf+aS
 MpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721196119; x=1721800919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OG5tWqvD7v5D7eW6eQiZf6y3nPVRndjEp8rarTrxMPg=;
 b=hylWDcJnp4w2+uRjmDGjHwbBKd/GunwrKMBtL49pUUzOpV8iv8feSOMq0XMNo4QQWv
 58sr/jsM/YOMbbrHldUeb5Jv/dLuAqte3X28TErZoakc5vA5anbO4wK+aPXTqNCoB7Xd
 2BISwp/GJZZJ+1FALcvLuoR7HFHe08tVL+s97aFFVsP38Nan+5zUmibvYE/Xt4s8OdHB
 wivIawmYBRw/rSVLjN9c9bu6hcOjwCyPkomERQqzanWUdUqo+U0gg/JYWVuJ0/YQ7Yal
 MO+575GHAdeGiZ1jedioOSqlSFn1aueGSpv6V74TfJS7xg5cL++CbFEe0jnWIG+sdUsw
 ZJlQ==
X-Gm-Message-State: AOJu0YxUBBV8XiieS40UMkp1cYAJVefqFa06H6+aGHy9Av9nQg7S3M28
 tuUq87GRlkusR9yR3Pf2qV8psM8hYiRogmRely1m7nDByKSmXlLFPdYSBZIlmN3hTlZhyLTOS2K
 XwSg=
X-Google-Smtp-Source: AGHT+IEQHqRkPUBMvPq+WJqJHYOkyaWR2z1UYreRjWi09JYPBRXRoYr8+3JHeodzDnQ58Jxv2wTceg==
X-Received: by 2002:a05:6a20:12ca:b0:1c2:8cc4:908f with SMTP id
 adf61e73a8af0-1c3fdd5338fmr822946637.48.1721196118657; 
 Tue, 16 Jul 2024 23:01:58 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc27383sm68131575ad.140.2024.07.16.23.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 23:01:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/3] target/arm: Fixes for SME FMOPA (#2373)
Date: Wed, 17 Jul 2024 16:01:46 +1000
Message-ID: <20240717060149.204788-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Changes for v2:
  - Apply r-b.
  - Add license headers to two test cases.

r~

Daniyal Khan (2):
  target/arm: Use float_status copy in sme_fmopa_s
  tests/tcg/aarch64: Add test cases for SME FMOPA (widening)

Richard Henderson (1):
  target/arm: Use FPST_F16 for SME FMOPA (widening)

 target/arm/tcg/sme_helper.c       |  2 +-
 target/arm/tcg/translate-sme.c    | 12 ++++--
 tests/tcg/aarch64/sme-fmopa-1.c   | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-fmopa-2.c   | 56 +++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-fmopa-3.c   | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++-
 6 files changed, 194 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-fmopa-1.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-2.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-3.c

-- 
2.43.0


