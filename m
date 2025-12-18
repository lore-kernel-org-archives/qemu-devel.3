Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2135D711C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 21:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWLaY-0003Yc-KT; Thu, 18 Dec 2025 16:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLaQ-0003SG-8K
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWLaN-000074-BB
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 16:31:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so628541f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 13:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766093456; x=1766698256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UDoNz36ytEw3SWP/F06gz4u+iNapD8CT5jsZwHam4fk=;
 b=QUNUAJNA/nnes4m/1qJJKwGb0PFxdUXRAJ14yBMZFycNEWzC+H5zNrcxzUzVWLH9Td
 azPLDcQgXjGC1zQyvqQLAg9A/SWlUIqUhEtjYnuLNCva/JLAgkOaHGcdrwqQFbrFFAdo
 M4LKYwCqa8eUPZ9Rne70YwYYh1VCjceepLMl0GdgVgfdzmSLt7Asv3cdQNxDa6H3274J
 mSL8P5RuAIQ/R05zgN4LZnsUOgx1b/5ZBuGZNQ1+lab/pvTmjlE+GFi+xbbergqfvoUC
 jyVn3UWlo4dzzsbn3kdfDGEc5RhGHYytVMcgsEDEfvK2ay64NQe0qyE+Ypw4OoGx4Cqc
 eiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766093456; x=1766698256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDoNz36ytEw3SWP/F06gz4u+iNapD8CT5jsZwHam4fk=;
 b=QCB0q7YNdk70O8JL2sC+p9UvW/kuSSX1JZTlxcuNoX7J3kL2MW1Z5WH99SJmBsUQY2
 D+/nN+HRs5zEwaRwy6r2DVplIhpKgpeq8du/dm0A1XaOkTO8O8MOWYlJXNWiuK4gVg2o
 48oDxBGxp603+zAdzJiJILopes5VgQf+n8/UdfiOkzNsXG0xpkS/VRJ0g2Y836q+DDBS
 ZnT4eTjFINrUHSNhaxpzdbK+oz14t+odTdFMwBV1SydOJEueYF16JRuvtRu+TtiyV5by
 dzDfBnAWUUyv4AzLsinSnnRsTR6XRnU4gbJlIGR3PNK25mEsA9QMpyR8L9O8qiQcJEf9
 Tuyw==
X-Gm-Message-State: AOJu0Yx5KPIdasY8Eg/qWqUAwatdb77UPQ15nLt73fcAut+PJRZD20R2
 AjZ57EDiV9/37H2gU8EdyBeINvk/ffR11fEQ/da2eHnSf+uN0C29f+NbqAZEY7xg9T2Td3VE+RV
 /RjKFBMI=
X-Gm-Gg: AY/fxX6aIFJkwxYRHsa677GPD6cZQ8w+yK+6ZUmf4s+/QqQImxSXn/7iw/EDZygpiIG
 ZCYkgB3waZaGEAsoI3gwXI+fuAuVEJKBkV7ZgCvegfjimR6XGTDga+bbu1IpwkbRkZ6jlqHvx0+
 EbnRSNPOtoxP+ky6JrCLjiUSmw/+tXFRui84nU2+z6eLqiCW78I+/uhSYGZ7RoDMaBAmS09WKPG
 SfQaiC1Kk/7bbfAVhG3PQUaetze28Gej9HcW2YY/M+W/ADiaX1HqDr4H8P2UqspnDnfL/QHfFPo
 HcRI7PZo0BmtWccO2tWDbqGxgrwewnIte5neMX539SaLpHhRcB9M1GqcEdbzk/OYlklvOQXl9Ed
 8NenBai3f6llTWBLIsVVrqq2VzNl0vV2/5UJp+Zt8oY/V7mtcrrIIbbDJho3zrI4Dbh9AKYPyMs
 KlhYR70kRyxng0nJQonjMU6quMIaWk8e8IxpEEXrf4mO2KAGuRLQv9eGIfx9v0
X-Google-Smtp-Source: AGHT+IHRMj6j3GYfZ7A+X6FbIZCNysobB6XE4c/6dfnC28h6PRiH19P9dpfB93VtDy7XC2jucpquOQ==
X-Received: by 2002:a05:6000:2c03:b0:42f:bbc6:edc1 with SMTP id
 ffacd0b85a97d-4324e4c1230mr935572f8f.1.1766093456454; 
 Thu, 18 Dec 2025 13:30:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm1040765f8f.8.2025.12.18.13.30.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 13:30:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] target/avr: Stop using the legacy native-endian APIs
Date: Thu, 18 Dec 2025 22:30:50 +0100
Message-ID: <20251218213053.61665-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

AVR is always little-endian, making the conversion easy.

Philippe Mathieu-Daudé (3):
  hw/avr: Mark AVR-specific peripherals as little-endian
  target/avr: Inline translator_lduw()
  configs/targets: Forbid AVR to use legacy native endianness API

 configs/targets/avr-softmmu.mak | 1 -
 hw/char/avr_usart.c             | 2 +-
 hw/misc/avr_power.c             | 2 +-
 hw/timer/avr_timer16.c          | 6 +++---
 target/avr/helper.c             | 4 ++--
 target/avr/translate.c          | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.52.0


