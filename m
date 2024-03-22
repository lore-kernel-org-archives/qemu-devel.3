Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED45BC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhHm-00017s-2K; Fri, 22 Mar 2024 11:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhHf-00015u-TS
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:58:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhHd-0005a3-3T
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:58:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33ed7ef0ae8so1307899f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711123093; x=1711727893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+fOM1vzhhoXwFohG+Qy5/7EBij4qwGl2aH9+HP9YMpY=;
 b=tTOAULZMWZu8CC8X8JNGyLWLOvl6BnStOgFzUfgfutUobxFuTeEtC0cLMJOChQlxJp
 5HjIzxAhxKNOtt9ZRjBvkGGtSFEjtxFMz21jJPUT4bWGKvm2Fglnp02nG4jKcVwvCaOh
 T0AM3mHxg9F4nYnKvRO6hQzvOtdtGIeek1bh8IwvpsWCjqWz6PG9Ku1iBbV/vw1p05fV
 LIA5C1hXAVvMRCz917BYt8DKKUwBhErzNF671p3ByGxQqPlQ1MG5fq+hBdfY5gGzsuQC
 3wfWHBr8jJE/vD4Ydu+/q1yeHws1jrmK2DtiMJ7IdS7mndu3exmjHFIBlZfCDN6Y8+2n
 jQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711123093; x=1711727893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+fOM1vzhhoXwFohG+Qy5/7EBij4qwGl2aH9+HP9YMpY=;
 b=p3STzrN9oz6zQHKq0DcQQbex34y7HJOcKjSjGL1V7F6s26QFTHsYRaWbe3bAghjuIu
 hBeUtCxfKXE/Tmtx+wO8CYSRdYeynWE6v5X5G5OuWfmIkXYwfsBJpxdN2I0iMxyHnOJC
 mJV5LNGRUDdvkHohRP6b09QvpukkHobYM5QqpJIvRLjCNMWz+zRjZ1GUSscvyF9U4q4G
 eigE2zpcyd7IrGYEGK9HSla1d003WwdlTiGrNP+P3Sq7uIQkXgD+gIqX9Wpq2l7kSgBr
 0cjqTQn58VdS4wyo95zlZAxRVAhqsv1mBZOIRqKwkzWsi13YevpLEc8tu5DbWiWpCvhZ
 V/2g==
X-Gm-Message-State: AOJu0Ywk+kKEuD6V4haBRgoWNXnLgHyLfkQtZv6LcZFwem5NP5ybKLY7
 goQLXc5rgolWgl3UQuKZ8nLpA6zWV6SqwU2Y72UYcDEXe4nmQF05hryua+w31WfZjOaNZLWAcje
 m
X-Google-Smtp-Source: AGHT+IHCbbDsBqYp/cjGppD/nQiCUXRTZhlbABe5fehn6DcL1QxPpssPl5ZC7dtHZp0zht0TaR83HQ==
X-Received: by 2002:adf:e54f:0:b0:33e:d8f:3466 with SMTP id
 z15-20020adfe54f000000b0033e0d8f3466mr2098172wrm.33.1711123093568; 
 Fri, 22 Mar 2024 08:58:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a5d6107000000b0033e9e26a2d0sm2333672wrt.37.2024.03.22.08.58.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 08:58:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc@lmichel.fr>, Luc Michel <luc.michel@amd.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 0/2] hw/clock: Propagate clock changes when STM32L4X5
 MUX is updated
Date: Fri, 22 Mar 2024 16:58:08 +0100
Message-ID: <20240322155810.5733-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Per https://www.qemu.org/docs/master/devel/clocks.html#clock-multiplier-and-divider-settings:

  Note that clock_set_mul_div() does not automatically call
  clock_propagate(). If you make a runtime change to the
  multiplier or divider you must call clock_propagate() yourself.

Fix what we forgot to do that in recent commit ec7d83acbd
("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")

Arnaud Minier (1):
  hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock

Philippe Mathieu-Daudé (1):
  hw/clock: Let clock_set_mul_div() return boolean value

 include/hw/clock.h      | 4 +++-
 hw/core/clock.c         | 8 +++++++-
 hw/misc/stm32l4x5_rcc.c | 5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.41.0


