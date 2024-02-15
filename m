Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A601C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabmz-0004Ns-O8; Thu, 15 Feb 2024 08:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabmy-0004In-G1
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:28:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabmw-0004mc-Lc
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:28:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so1003509a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708003708; x=1708608508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=igEHQnAv346IZm7Tdu46vcLhm+Op4iNJOlIOq4u/X0s=;
 b=eTMZlKnc4AQ36w+aYWqUzHprC4eSz3eACN6qOuyiPhit3upre7DsmtG69GOWEjR5Fe
 XYU86T2Hkow12X6AUNMKa8TohIdxbSJ+9RXN0be2n3bl8EIpVFU6PExWDITNkzHYkGyt
 YKCAPZtqbI0AV0EreRcY/90UjYPBC31kcaiuj6DDDsrqdoltuTpeiVNNIuFtGNXxMxlb
 U1zM3ehjQcY6R9Q88NabYmXeiX29m8PnxygnewNOxS5l9B9O4xrzDNB1B1cAd3p+PuPo
 6JRfHRPdHcmMpt1Umm0IWagyAjUlbp7AVBGrDQEnfWgwc8/HNw1FPqmco5f9Pjilr5sc
 cckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708003708; x=1708608508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igEHQnAv346IZm7Tdu46vcLhm+Op4iNJOlIOq4u/X0s=;
 b=G4g8IPQojD/jlK6UYo8w9bzfntx6so8Dw1R54dBvR1j6+omkLywW0j5+yxFK9PsIAF
 J3oZQhSaTqgNDhbppMj2g6SasLH7yOTvEJahcm+ntqJBr3Iz3YLSfHvJJziusrC5LDfu
 FcNBpuwjo91IdK3MSu1ttRA/ziRBUOlIZuLE/XPPwqYro99UlUOq6hvfGeZgeYx911/D
 txmEin/ouLCRhIUy3XVngPw34QDC/4a5vqCOKt9dJNaP8G9TADtLnHc/kjsDSvM7jjUP
 lt7r93jI3kbWz+X0W4NzFmAenmpjtnkcd+e8D9qzXmZydqzmPQSDFpzXQxUUXPXRSwO/
 /8cw==
X-Gm-Message-State: AOJu0YwLm52cRbDYgQVLZtVu9Ky0MjGeB5Dkw5ChlD2Fp9KNiWsICB/z
 eQWk1w2fBWeLnK9VMzLn7uOzFSUNdsuc0XLK76HYAE/1S0X3FhWGadYWUuIvjJkYJYl+fM/4FRc
 ckis=
X-Google-Smtp-Source: AGHT+IEzhPVoqDc9Q/t9OGcFbIymUj3ZOYlPw0O9NHyu5IbU80obK8cxFaP0280UajBLW/urtjxJbw==
X-Received: by 2002:a17:906:5905:b0:a3d:481c:7d45 with SMTP id
 h5-20020a170906590500b00a3d481c7d45mr1260498ejq.16.1708003707789; 
 Thu, 15 Feb 2024 05:28:27 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 sn24-20020a170906629800b00a3db46018a4sm107162ejc.71.2024.02.15.05.28.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 05:28:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/sparc/leon3: Trivial cleanups around write_bootloader()
Date: Thu, 15 Feb 2024 14:28:22 +0100
Message-ID: <20240215132824.67363-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Have write_bootloader() take a void* and remove unused 'env' arg.

Philippe Mathieu-Daudé (2):
  hw/sparc/leon3: Remove unused 'env' argument of write_bootloader()
  hw/sparc/leon3: Have write_bootloader() take a void pointer argument

 hw/sparc/leon3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.41.0


