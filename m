Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA35C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayen-0003tC-MG; Fri, 16 Feb 2024 08:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayei-0003se-R1
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:53:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rayeh-0002Wz-9l
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:53:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so16667635ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708091607; x=1708696407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eGTFgthADuFEDGsVToLpWo8eIP+mMwNuJhAAehV1sFk=;
 b=UN+HmB5lQNKjkziWQ2cU/o6KNaQ52lZgb5Ji8j1rY5V5rtHgaI0abF19NA9clwZZJX
 3bN6RHJlrQY6eHMCGwPpKbN2OiOJjK/8LqNBDG8TzMslmb0ZEhfqmJ8vdefkvD26+s4L
 VSF5bQpTJOtoVGe3Dl85Eqpt5LFeRdoOjF+6gGWXSAx9XR4G7UF2zYj77QVxur2rx3fQ
 sn8wqbhRxdN+dhk6u2YPn8a3syx/lI0/6qBLBT1JAJu1nYCo16Kv0kSoXyZ7URWR2xt5
 zfD/R7+zimgpNPljCn3lXHPrir7tSKcvO0rTwmbQ2R6GqGo478Cbpi1CdzP2rmTnW0rc
 6GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091607; x=1708696407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eGTFgthADuFEDGsVToLpWo8eIP+mMwNuJhAAehV1sFk=;
 b=uKFt3SHlWOsvW7JI8OCXTFzNMyOaiwd0MKC5P3w5dUWT+QtviE6XB4QDZz14gCwsXD
 EOGOA5C4+ACcMhV9ubPb6AtoFKtFK9dEevz6bE6xy0Dy5/Pm3dxl1qfat84WYL1rtZC+
 AtW7kjGnL7AaGp+6mWlapHyjxEES+GzBvHD9/1kBl/mpwhEWsM6n46X9Aopgd1pC0VWu
 aixp33VKq2CiQpiVRelT3sr6A77Ijy+L4g8Z8RMCxdJpepCeLNxUA9BPJvRlGh2BZu2q
 UxLlkrC7CBwES+eqTUo6JXtBQrBV82EJEb6aEY04fua0AE7bMk9rCf5sR75sZgyp6gub
 g4GQ==
X-Gm-Message-State: AOJu0YxBVvlAdC1/yVGc7NjEM5JZO4QNAQgs7WD6BtkyH9GEwzAQsrO3
 RndwfmkC2sqO6/BkQWy2l5gF2QeTwxc4zh9rxcT1VE4L3f3b0cN2PKr9BVNQYpE=
X-Google-Smtp-Source: AGHT+IE81uTDiFqfZ0vyYoVX4LPKP2aUA05lhftfFqzGQeC6DKQGl3ngWKUmYAmf5d8rvoyg7QpS6w==
X-Received: by 2002:a17:90a:f40d:b0:298:a0a5:d9bb with SMTP id
 ch13-20020a17090af40d00b00298a0a5d9bbmr5036723pjb.18.1708091606709; 
 Fri, 16 Feb 2024 05:53:26 -0800 (PST)
Received: from iuseotherswifi.notpua ([14.139.82.6])
 by smtp.gmail.com with ESMTPSA id
 gv8-20020a17090b11c800b00296e2434e7esm3382844pjb.53.2024.02.16.05.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:53:26 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH 0/3] Misc: Make watchdog devices using
 qemu_system_reset_request() use watchdog_perfom_action()
Date: Fri, 16 Feb 2024 19:21:36 +0530
Message-ID: <20240216135137.8668-3-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=atp.exp@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

A few watchdog devices use qemu_system_reset_request(). This is not ideal since
behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
to reset when a watchdog timer expires, let watchdog_perform_action() decide
what to do.

I am unsure about the changes in `spapr_watchdog.c` in patch 3, it would be great
if any of the maintainers review it.

Abhiram Tilak (3):
  misc: m48t59: replace qemu_system_reset_request() call with
    watchdog_perform_action()
  misc: pxa2xx_timer: replace qemu_system_reset_request() call with
    watchdog_perform_action()
  misc: ppc/spapr: replace qemu_system_reset_request() calls with
    watchdog_perform_action()

 hw/rtc/m48t59.c              | 4 ++--
 hw/timer/pxa2xx_timer.c      | 3 ++-
 hw/watchdog/spapr_watchdog.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

--
2.42.1

