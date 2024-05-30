Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E068CC27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChAR-00079E-5k; Thu, 30 May 2024 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAP-00078t-Pv
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:09 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAA-00020E-K0
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:09 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52b8254338dso499386e87.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717080832; x=1717685632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JDUMrKLIPsISoVu0sguAFcKS6fcO/ixLXajxTcHbSMs=;
 b=vEOvckVVA0ZIU2Hn0btmHLZVNoUrTWXVeXLiumR6LbGs23LhldIR7xF6TL/Ve7phI6
 zk24XAWwjRiNCyMcqHRu3rjXThBUsAbBPm6D3Vqu6XeAFQirk931MdICEaZs/Tohi+Ex
 gaJa9kxgoE1Ut2AhVfGsk9p/GiZR1A7QhFbF9UrK9XXgge+dsAIONvrpa1eUyQ8a7tvH
 kw1sCN9MKnlRGCrf9R083o5RlCYSHLhHN1I/9aQ9i6dPZKXyCyB7GYH3cmWA7YhGDouh
 TvFWxCmoxSRMR171FZLubdnBIq9EXPkBm2ElklKTHoMxwOnA3SfN5pxAXJhAecbGsMAe
 erMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080832; x=1717685632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDUMrKLIPsISoVu0sguAFcKS6fcO/ixLXajxTcHbSMs=;
 b=CgV51socpNe5rkqE0cntS+Nr3qgn3HK6I6vY0RtKbVtrZczSqT2m/SZHoVlMd9jjKY
 wJ3//sg+iv6KWCg8m8x/3V4ezoRg2Ud6DkgsleLNLnfSWSQVpqo+G7USXOjulsg79al8
 YpLvfmOV4Rvb5VYo2idiiR1/ML9uK6eSJnjwY8kNLhbdOCFCmYLD7WBb2dhEPyoMQbe5
 3O2YCrKLxYcUahLHhpOy+2JWf+ermp8vRr7sX64dhMp+Dbtevnbz7GTEmE+WvOWvsFyK
 /ybjNKBdMwTYW73bCp5WjdsMioDIz8zQl+0P/qqOqsMWB6zoQy+vUz+Q+gncWpFUJ5gm
 xYfg==
X-Gm-Message-State: AOJu0Ywag9QuGUv0GIjvryAQgUrgP8RzIbdnuTA2m7YezaUKwYBe08/O
 LWaw7g8zNVCzNjLz6ZQs9ThqU8oyysyhN19aJfL/Sc2gfNZYd4KFiaz71nBg35uAGnL8ofIohvu
 I
X-Google-Smtp-Source: AGHT+IGNvX9MpiUecHh+Ih0HKfaJmezdOJ+j+VsPuICRNW74JOWujyOf6wtuO0hRICYZqO7Ssombjg==
X-Received: by 2002:a19:ac02:0:b0:51d:1d42:3eef with SMTP id
 2adb3069b0e04-52b7d434f4amr2519871e87.29.1717080832158; 
 Thu, 30 May 2024 07:53:52 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a673c9bede6sm13551866b.192.2024.05.30.07.53.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 07:53:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] semihosting: Restrict to TCG
Date: Thu, 30 May 2024 16:53:46 +0200
Message-ID: <20240530145349.41309-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2: Address Paolo's comment

Semihosting currently uses the TCG probe_access API,
so it is pointless to have it in the binary when TCG
isn't.

It could be implemented for other accelerators, but
work need to be done. Meanwhile, do not enable it
unless TCG is available.

Philippe Mathieu-Daudé (3):
  target/mips: Restrict semihosting to TCG
  target/riscv: Restrict semihosting to TCG
  semihosting: Restrict to TCG

 semihosting/Kconfig  | 1 +
 target/mips/Kconfig  | 2 +-
 target/riscv/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.41.0


