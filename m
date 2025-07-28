Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69CEC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSQZ-0005YE-3R; Mon, 28 Jul 2025 14:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPC-0004nK-Lw
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:06 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSP9-0002nI-C5
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:16:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7600271f3e9so206075b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726613; x=1754331413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XxB0yP1OlO1HjQOnyDyn0Y4fdorVW+/9i3XgPVNzleI=;
 b=SVDVvAB+tr3yiwJXo1jTRKNnzT0syG7Jn7V6t6Ab0lwPLdX5vcFpgmpEpmlTgUhrKF
 /DDnpCkbIYCYfi8k/wOaxa8dvR810wRCDlFn49VS1sv+1XUonUeQnmkTL4X4CC2Vh+EE
 EW/V5TknRpEN18q+b4e0ezaTWMtO21QsqvoWZ1KtveYLeoM+elFQCNj+4l9+c+6sAJtT
 nMz5+H/6pgtWX/cegsJG4aPCHSuHm6ZsyIMe5FXPIdvMPXWNrBh7G84XBi8kC33eDMHC
 6Z/cRc3uF4NFyLsf/O9q37n/+HaHZlzEnXE8U1w1yCtq+iTz76Apt7/mCYn7n8KjARSh
 GtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726613; x=1754331413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxB0yP1OlO1HjQOnyDyn0Y4fdorVW+/9i3XgPVNzleI=;
 b=OXd20QihP7EUWwEip3CL4OQ3Or7Wmi57Jwyx4AmjqNtxJjx1HO1OEeWmXRAqOwSSpJ
 +kVRhGsEABdXy5XHJC3X30eJ4w93XCdXDnpIyyv1jXQqN1GDINj1DrXNQr1Jnqk1AZmM
 FJydGVH3E4m+yuFEZRVLuXGypuoFLHOCSBhgYse2IhpNXFEIkbmuII9AynE9LEbmZ14m
 JUCaJMtryGQEG52Wde20CetsXCSSia/UwFnjQfX2AzXeh7M2MLFjxkQZzYFHNDfPmOZT
 349+UwaNfTVY0ZsAlFN6wXBOubbAQuGU/wOAMosJxoGfbrXPQucUOkXWr9tKz1QR5qhE
 NvlA==
X-Gm-Message-State: AOJu0Yz7pdABBCeNUu2juUtGoJU/jDg0ifjCcTGUc4TMslFzLE3d6PCN
 7eYTal+a8cJrigP+FajSfiu91TZHLQQvAroGpQ8rYNSRL/GeTt/kaQRhxycHQi5D6E3ymrq2+78
 h/Iia
X-Gm-Gg: ASbGncsaR+Si/oGFX9Iczi2aZNiZXboFzqxLwJlSQVc2zR27WtKJR7ZLpi2PEOVZ7qA
 gxC95fcW2iuMPWFdpdTQKWUBal+PP/vvXpTVGR+J9DAflc5xgdz1daA1QWpr/6yfHero66c4gSi
 mZjtqkl4byNCMYFmbZuOXft26AA5iNSaafieE7nXl9se/dHRDXhfM5gU8VcIvHEMnFunjSoXj9K
 57zCw6qJeYPyPKf+D1Qgv17dBzjDun3EpJYsRWkZ/xcV5yliSot7BjD1TYP4cI/r/QcXhztt+Vl
 54/g0KgbatvCTxE6MJp9AggSNyz7ECmpWBwFk1He/SGNJbHu21Vi3ZCi6+rcgaAKx0dtuHhMpvA
 AeueVv6JVKbGv9Jd/yA+wV0b5RfgxeJKrLbRpd9POEbrFWtDPftccmV2VlnU7woQ+FX8BgpodQy
 sNt9u2CPCS1/69MRKNEA8P
X-Google-Smtp-Source: AGHT+IHISbkSEJPq8gK/BBAq5l4GTjJQAww5wGlvNk8Jxzy5xtiuZ8M6RoRgroQPI+d91g+no8YVfw==
X-Received: by 2002:aa7:9ec6:0:b0:74a:cd4d:c0a6 with SMTP id
 d2e1a72fcca58-76965af187emr649319b3a.5.1753726613427; 
 Mon, 28 Jul 2025 11:16:53 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:16:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru
Subject: [PATCH stable-7.2 0/9] linux-user/aarch64: Backport TPIDR2_EL0 fixes
Date: Mon, 28 Jul 2025 08:16:41 -1000
Message-ID: <20250728181650.165114-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Hi Michael,

Here's the aarch64-linux-user TPIDR2_EL0 fixes backported to the
stable-7.2 branch.  Including all of the aarch64_set_svcr cleanups
is probably overkill, but I think it was clearer that way.


r~


Peter Maydell (2):
  linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
  linux-user/aarch64: Support TPIDR2_MAGIC signal frame record

Richard Henderson (7):
  target/arm/sme: Reorg SME access handling in handle_msr_i()
  target/arm/sme: Rebuild hflags in set_pstate() helpers
  target/arm/sme: Introduce aarch64_set_svcr()
  target/arm/sme: Reset SVE state in aarch64_set_svcr()
  target/arm/sme: Reset ZA state in aarch64_set_svcr()
  target/arm/sme: Rebuild hflags in aarch64_set_svcr()
  target/arm/sme: Unify set_pstate() SM/ZA helpers as set_svcr()

 target/arm/cpu.h              |  2 +-
 target/arm/helper-sme.h       |  3 +-
 linux-user/aarch64/cpu_loop.c | 11 ++-----
 linux-user/aarch64/signal.c   | 55 ++++++++++++++++++++++++++++-------
 target/arm/helper.c           | 41 ++++++++++++++++++++++++--
 target/arm/sme_helper.c       | 37 ++---------------------
 target/arm/translate-a64.c    | 19 +++++-------
 7 files changed, 95 insertions(+), 73 deletions(-)

-- 
2.43.0


