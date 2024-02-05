Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E452CC48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWotq-0001QR-92; Sun, 04 Feb 2024 21:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWoto-0001Q4-Gk
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:39:56 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWotn-0003bA-11
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 21:39:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so24340305ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 18:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707100793; x=1707705593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AMMlFgqsZNPtDtWn5DIIlxa/o409HpGjsrkpZQYmfIw=;
 b=dJdJUT831pyDaxJ5Z3WEN9JyhLS3MUlU1QEnrWrSCVqsJtoPWKjyxaAgib0/CuylYS
 A8VIvosPqvO3+Gsm/9M+c5ivQkbrVfk/KLc80Bf9BZmwFRMM/1zx/Bs4hse/ctifDCcU
 PeajDnBxTTza87bdqHnF5hrDfZz4o0ue5N5wBOq5BPztVhy4x43NjI73RIQv+xfnEX5T
 QaEWlvKfRMkrslrCnGC03lXHFd92HjKC81zV3axj0UwN2UFtVDe7SGBmUx2a+025UbfE
 SrQY9nA2YgUA+vrHTNUyizO7yGaS39GYXdu3+LDMeF7kGuohqIhHrkVyu9hs+9LvRwhB
 YftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707100793; x=1707705593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMMlFgqsZNPtDtWn5DIIlxa/o409HpGjsrkpZQYmfIw=;
 b=IczfOHwRPLnvo2b34EotM8tDglIpJOw98ok/+JUUIgaaLe6n7J6HmR9W80cVbZgOQo
 25ovncS8wC46yRNNBNYMATzv1CiQpZCjyrT/Y5AuYmhsggNiBg+KrY3Z62xpiZCllBDY
 FbpIqyPlC9z5aWIsbMEuihIGnGvuYAxq0ApCP4b1E0ySajNBEsKOZgQ2IQPyYGKPJB8b
 5nXObQOjcoee3I6VbyMloGmejmqkHvNJCR0FtH4mwiUCKq+mWTbaBycKz0Ghp61UTnfG
 6x5I+3rMQPi5L2eSMtDLkqdNZDgGMscpt0/51OhWMChI0m0JQis3KDNhXTtiE3983C0G
 rh4Q==
X-Gm-Message-State: AOJu0Ywbe2q+lj78nopWV0/OLuM3z6bLNfDYj4ivN4oIm9I435u7Ek8t
 fRmnA6tnJyeQR6IlIHNrv7XkH2AppAZHaDb4iA7MOsyUADXDbWi756FxiCnpEODro6PqtZnhO6f
 QdT0=
X-Google-Smtp-Source: AGHT+IH7YrNU15rSukXULgFHUYJ7dqvtjQ5/zhOmc6fssru6yci7aMu/CLyOYNsOMGFXCPA0pV1spw==
X-Received: by 2002:a17:903:94d:b0:1d8:b6c8:d9e0 with SMTP id
 ma13-20020a170903094d00b001d8b6c8d9e0mr8979739plb.68.1707100793165; 
 Sun, 04 Feb 2024 18:39:53 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 d20-20020a170903209400b001d98942d290sm3292130plc.124.2024.02.04.18.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 18:39:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 0/3] target/arm: Split mtedesc from vector desc
Date: Mon,  5 Feb 2024 12:39:45 +1000
Message-Id: <20240205023948.25476-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This aims to solve an assertion failure in simd_desc() that
is triggered by overflowing the 22-bit simd data field, when
SVE vectors are configured to be long and MTE is enabled.

Gustavo, can you please run this through your test case?
I looked back through the irc log and only see the
memory-tagging-extension.rst test case for PR_SET_TAGGED_ADDR_CTRL,
not one that tests MTE+SVE together.


r~


Richard Henderson (3):
  target/arm: Fix SVE/SME gross MTE suppression checks
  target/arm: Move SVE/SME MTE disable checks inward
  target/arm: Split mtedesc from vector desc

 target/arm/internals.h         |    8 +-
 target/arm/tcg/helper-sme.h    |  108 +--
 target/arm/tcg/helper-sve.h    | 1255 ++++++++------------------------
 target/arm/tcg/sme_helper.c    |  155 +---
 target/arm/tcg/sve_helper.c    |  431 +++--------
 target/arm/tcg/translate-sme.c |   33 +-
 target/arm/tcg/translate-sve.c | 1246 +++++++++++--------------------
 7 files changed, 926 insertions(+), 2310 deletions(-)

-- 
2.34.1


