Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3ACCD711C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLc6-00056h-78; Thu, 18 Dec 2025 16:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLbw-0004qX-2y
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:32:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLbu-0000bs-Fy
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:32:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47755de027eso6874155e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093552; x=1766698352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=54KYr2e+XgR3khgSV11sMu/Z5RVOcSDXb+i3+37ZTyg=;
 b=NKe2S1pHz3BYRS3j0nfx9cODAKG9U62I6j0wczTtX+IchXOcSQjv7aHP/Vz91r5h1D
 K/bIm6S0i4bPEC2DEDBUeMB/vptkG2z1yJsalQ0w5TV2YjLRYsM3vljNMNTXPOMUpWAu
 8O6ilyTkR9tvPlNVcjVMvq3hG34yIbOsVzToyi9ni9ZCKD4sCUGeht6nw29WmMz1ATxG
 /zVbsEVe/wECbb6LcEE1nrq6uHe0tUYCE2lq077yvD20m0eVLGYLbY035t3FAAInsXU8
 Z1Nd9epAzI+8ARM1TUipNoRO7GeqTfau48uEl0IgQAgRuvKRYnGcGzKp6ciowMWxjFFq
 9neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093552; x=1766698352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54KYr2e+XgR3khgSV11sMu/Z5RVOcSDXb+i3+37ZTyg=;
 b=QiC4lDutdgH1SRgUv3jGj5Dy34UvlBZysK2pI9nj5GM4kuRXrXgNqNmjGPHrHqDiak
 kRdWcp9+ADTbhx2rhp7MSN/gqiXH2CpKInVb6MvAGU9KIJUM+xUn9qe5ezhq4N43ORQI
 zz72P+6fyBd4J2g733WNuMzJOaiH1Eshu4Z8SP/JEbfEmMiNMdwaKxoLcRo71cVx2IeE
 6t7ioKbOnuo+SCbetU4vXKT5M6SMMOMuiKjDyX5rZ75q0vE6JPCzHOTgg7wmGmKAsR3L
 OGe9XYUxBW8ehwN71WJrCK+hHBuf4VlNkwQI6I28TFMx531Z4nj6bjU9MmtxUMVrv9o4
 KELA==
X-Gm-Message-State: AOJu0Yz9IJCq6TjpgAnQVMrgs2waxhmDkdVWRf2LqNuO6bZ8Hsf7M+lu
 XhnnF/T9SWNZaQ8yUPl+5tYbVvKb12zQ1g3Q9/FBabwvwnkCPOH4TX9KUolg7qTLwmsNz94Nktb
 qPQxMzuc=
X-Gm-Gg: AY/fxX4iXVzC6ujiEVAT+t7UZYe6s6xLtObi/8deZby3scXbLfm+BOLG1Kbt1bvQwsg
 S2QerlCKmhPdrnzHah5Ly9E6IvVsoki3MKbgGCxnBbdJYSxwnLBxgCCngaXUayQmWwzvNJNknEi
 Rrcmcl/fUHd5V+3/xKTuwIuTDrRO0pO11S8Aea22pTUEe99DioC3UJlbG0uZv7+AkD7v/bquFy9
 8Z1EFQHj0xXmrlVNshUEh9H8IjPKXiRWTwJKjqqrLMdMBkpznZVDmSJHwQTBg5Mr0mgAq+c1gwj
 +VtpaiJptrCqOIGntQ5URhCPRw7NnJmlEBiz8b6fW6oNpZJCa4gT/ZzpUU8Ki2e2JAv5Nl9yNZt
 Uum3Y6yU9b7NlWcIYzkkS1FEa/Ic71iYyC9EexEK53SSwYi9rnXm2tYxvYWkpNM66D0T6ANqIJp
 Fnl5Lma+squ1dj7VurRsDzXvtvViXbSZ8BItiwESYuSBDVpb8fh2AALsfZm81l
X-Google-Smtp-Source: AGHT+IFItfB9ednsh59ka105DR7F4sPUc6RVsxH2ryECRaHXMK5nRiOMNauinYgsgMixCF+i25rU6w==
X-Received: by 2002:a05:600c:5246:b0:477:54cd:2030 with SMTP id
 5b1f17b1804b1-47d1957f707mr5481475e9.21.1766093552411; 
 Thu, 18 Dec 2025 13:32:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm981143f8f.33.2025.12.18.13.32.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:32:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/tricore: Stop using the legacy native-endian APIs
Date: Thu, 18 Dec 2025 22:32:26 +0100
Message-ID: <20251218213229.61854-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The TriCore is always little-endian, making the conversion easy.

Philippe Mathieu-Daudé (3):
  target/tricore: Use little-endian variant of cpu_ld/st_data*()
  target/tricore: Inline translator_lduw()
  configs/targets: Forbid TriCore to use legacy native endianness API

 configs/targets/tricore-softmmu.mak |   1 -
 target/tricore/op_helper.c          | 152 ++++++++++++++--------------
 target/tricore/translate.c          |   9 +-
 3 files changed, 81 insertions(+), 81 deletions(-)

-- 
2.52.0


