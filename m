Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8FFCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7PT-0006lk-0n; Thu, 21 Aug 2025 11:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PQ-0006l5-5X
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:41:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7PO-0006xi-BG
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:40:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso4540515e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755790856; x=1756395656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ivyq8HIrADRss3L+Kc6mo9FT93tCIt9/qyePlgGYjoA=;
 b=Gdy/mcdWcvhrm90GxM31Q7Rhvr0GYSuaUR8kXGRxeGKqX8FouhmoZTJmYfuP9JsYJO
 W7Vdu1kAi3noe3Pc29pA66SOxuShr36FgCt4Zvtkk98IjoHqqdRTEsWzgIKG+RwtrnKh
 ckq1RA8KuD7X1kCNmJvXn1AAZBt9jdJWjWuUipAscMXLvxnRFm3jFdO8xQwwPkrhmuxF
 5XuwmT9oNyq9sv6QqBNRGmgPV+F3MpsBU7d8brp8nC9ZCXfA7Icfd3/y1UTUGUSes4FF
 7/VrfCMLMbVIdhDS+FAAoPDDch37KKkDSX5IljGUqz1pJmtTPYMeguJM2ACPLX7u7kDP
 39Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790856; x=1756395656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ivyq8HIrADRss3L+Kc6mo9FT93tCIt9/qyePlgGYjoA=;
 b=RQY7+KYasKCwuy19F6VARqnT51C+GobHbgNnqwKMgl1vX6NmqwFpdvC61VxPG50F4y
 XdOdXcaN+3yMoLJ6p6Zhi6sfhPiQUzWSmbMBbl6QDX1LMBxA/3JdVbOsmmW7/X7+JEze
 6a49QVhKwSxrEhbE7p+4tOVWSi+oC0gqgynbqX25LjFR6ZO024BQ9VnaQIxHYzwSO9aq
 dbxKSWKHvU+/OZDqD7oz7aWdSW3+7uCOvmkKa8vruh9C4Dlgr+R7RAKvnUU6R99N5biE
 Z9T66iJv43PXBNRjiEQHvSd9gHaVlxdbxKaQLLk6IV7jJ7sz41GXCtRpyNPZ+psxP+zT
 QxEg==
X-Gm-Message-State: AOJu0YyGygSRTNFF2wEnyUk0SZdiKq8OF6DgzEkGr4OIIS5OEJvP8r4U
 xqV5Y21qSs/9WX6xm1AV0HrE5Gg/dL3EPf6hiommcKBR6p5NyXS7nB6jhKmudzHw9y8c2grGMMZ
 uc6JS
X-Gm-Gg: ASbGncs8kNI/U/vC2ZlY5pA85rStlIoqAMx8l2rksDVVVN/kHrFu+rhbrDr5xWYkZtT
 c3ggkj1a/rCNNa461BDbqZCHkpEdBEfBadwbemJ9WwyYB7Mm1s5e7Gx7Dw7ZK+5XaZl5/hweGUG
 ge27MGNfc5+aYMqnkxDqiCJlqFiuGalCyxCW01qRDkGfAySkWGPUx8VhgzFiSDheN+rROIUNf6T
 QJZjbthHDj4V7H0XSOWQbIUM4R9v6wKJisU3WsyCwY1dvhooZIv8eJ4N8lpaoBN7NzkRuQpAUNh
 jqK8tO3X3SIcgtrpnN2kmaggoVPAc3sngu1kqkVs+N5MJrfxuLQ7eiDtJ+3w6VUUKR2HtrreMg/
 3y7XBllTb/dS4p8tSDYmiwqFAkFtqASmnSUjDdMw=
X-Google-Smtp-Source: AGHT+IF5XM6WDSnOlD6tYNvIXU35S7OPEy+Yqxk/qlj89png5ZDK1WNtlfKHMW05QnQlmjrMSPuTlw==
X-Received: by 2002:a05:600c:3b14:b0:459:ddad:a3a3 with SMTP id
 5b1f17b1804b1-45b4d855353mr25672555e9.25.1755790856360; 
 Thu, 21 Aug 2025 08:40:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50e0a479sm1443285e9.21.2025.08.21.08.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:40:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw: Fix qemu_init_irq() leaks
Date: Thu, 21 Aug 2025 16:40:50 +0100
Message-ID: <20250821154053.2417090-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The qemu_init_irq() method initializes an IRQ object, but
the caller is responsible for eventually freeing it by calling
qemu_free_irq(). Generally we don't remember to do this.

Implement a harder-to-misuse API, qemu_init_irq_child().  This is to
qemu_init_irq() what object_initialize_child() is to
object_initialize(): it both initializes the object and makes it a
child of the parent QOM object.  If you use this in a device's
realize or instance_init method then the IRQ will be automatically
freed when the device is destroyed.

Patch 1 is the new function; patches 2 and 3 are bugfixes for
leaks that show up with ASAN in device-introspect-test (which
does an instance_init -> deinit on every device).

The other callers of qemu_init_irq() could also be changed over
to use this new function, but they don't cause in-practice
leaks because they call the function in realize, and they
are devices which are never unrealized.

thanks
-- PMM

Peter Maydell (3):
  hw/irq: New qemu_init_irq_child() function
  hw/char/serial-pci-multi: Use qemu_init_irq_child() to avoid leak
  hw/ide/ich.c: Use qemu_init_irq_child() to avoid memory leak

 include/hw/irq.h           | 23 ++++++++++++++++++++++-
 hw/char/serial-pci-multi.c |  4 +++-
 hw/core/irq.c              |  8 ++++++++
 hw/ide/ich.c               |  3 ++-
 4 files changed, 35 insertions(+), 3 deletions(-)

-- 
2.43.0


