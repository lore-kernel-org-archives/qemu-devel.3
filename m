Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6AAC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdocV-0006Ha-Uh; Tue, 13 Aug 2024 06:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdocS-0006F5-9H
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:19:14 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdocP-0005ni-EN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:19:11 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bd1a9bdce4so3423603a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723544347; x=1724149147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S4gqtzN0g+Peu+kfHBMaU05Kz8NthaJxJJdcasZ0kms=;
 b=Ll2HOfUyihIZrfJrenDM5hMDtvNl5WG6pQG54T1h/G/xtVS4vwD/2ft2S0vmNNEdNd
 8lvKtE8PYUwet10NeYpKHa0JJROOt/GqIGBociN0lxUuy6SaFrfIvV9mFuWubbGFZExi
 Nrlkb5XFD0p6vriRegOf+GtCS66dSPIDSLT8MF3X0xkOJUGREb5XWHiy3+LBq7bIEK2X
 EyTlZ5P11fVlWNQlEORwptmRMvC18faORfMC0wk/8qoWT2q3nvrFnvUxdeJFNVfmpjUF
 hShGGOYRli1962PlK7I78AdIvxzBKzunkFHoyLJaFmM2rjnLBtNYbhdo1sqsITLmDFvw
 3LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723544347; x=1724149147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4gqtzN0g+Peu+kfHBMaU05Kz8NthaJxJJdcasZ0kms=;
 b=MNjPglAlh5D0bXSH7RFdcxegiCq5rVgqFW7KAV5OiTFQrmGF+Gli+IwFUa5nXr1Djz
 2kf6/+TYAF+o0dff5z4RwdYGrHANeLIjwy4Xs2SzYa7JAHKSXv4uqIAg9kTOHvtm9GLl
 vG/CdXJ0EIDprAnINW3vg0BDIQbmIayErkEx4VpGVb/QjrvQdrik/LQ1ZsuugR2Kdoqw
 WlfBJTQ56Zz7PqKr/mxEwaeQ4FRnZAeUArPuPc832kGh8IYaf7Tub04+NaywIPj9Ptg0
 pwqHYakKcTPwA9+EVhEqDLughLmaJ8V1KUM+Sm76NMXp/5ARBLNQM0kthfWmp4B3dVg1
 o96Q==
X-Gm-Message-State: AOJu0YwK4QH213BcZN9F1IRwDxpgcO+UZrNRIc94Yn3GweFxevfgYdjt
 mV4VAAqMEvJu/EIFTI5n7yitjkrXLod/vPiFNEYM2dTcPUIMdNNA8FqcDtgMd/ca3ATVbnciwn7
 YGmY=
X-Google-Smtp-Source: AGHT+IGd0Ng921ehikKq7GI5wea7c+yxEc9jSRNxH0fXsXHHKXDVKfQ5ec6fhtBT4WONre0Q7sXfvQ==
X-Received: by 2002:a05:6402:2791:b0:572:9962:7f0 with SMTP id
 4fb4d7f45d1cf-5bd44c7c7b2mr2321922a12.34.1723544347115; 
 Tue, 13 Aug 2024 03:19:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd196a61e2sm2845362a12.51.2024.08.13.03.19.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 03:19:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
Subject: [PATCH-for-9.1 v2 0/2] target/mips: Use correct MMU index in get_pte()
Date: Tue, 13 Aug 2024 12:18:54 +0200
Message-ID: <20240813101856.49469-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

Propage ptw_mmu_idx to get_pte() and use it via
the cpu_ld/st_code_mmu() API.

Philippe Mathieu-Daudé (2):
  target/mips: Pass page table entry size in bytes to get_pte()
  target/mips: Use correct MMU index in get_pte()

 target/mips/tcg/sysemu/tlb_helper.c | 35 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.45.2


