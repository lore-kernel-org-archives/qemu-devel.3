Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A405C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SeS-0005pX-Ns; Mon, 13 May 2024 06:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeQ-0005ok-S8; Mon, 13 May 2024 06:11:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1s6SeP-0006Nl-5R; Mon, 13 May 2024 06:11:22 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59b81d087aso1036142866b.3; 
 Mon, 13 May 2024 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715595077; x=1716199877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3yXxmMXz6raz0yk5kfkPN65fGosWmMze3CL97q/kGb8=;
 b=OsJ70k2LDdxPvGdXRxlNKyTZV5Okg0OyrMrCf1pe7djzt164GPyehr2ajxzBf9+D/d
 SFHrv90wjC3Cg7X/jzN277rOetRkQgsV1uJj4GapfBFAEcnXZDF3KOgQ6XSkUoSm5MYX
 0s6TMOXxSPUxuabKF237K8k6MTsI72wDEZVHKgE8dOUJCLe/l9++cOTiJfBZFD2XyAtA
 6Fh7Z3zhkR5QKaD9kA8vSNqZGg2//THGNz1OhtQ0pKOx1NqzuQEid5oe9Xa4HsRjGqGq
 2v4dNQkTUqfxDs/aSnHc1i/++uQ+Ty0+e7koq0i2xy/r16cIRw/d9ITpZZ1zVtt5vcFw
 iT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595077; x=1716199877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3yXxmMXz6raz0yk5kfkPN65fGosWmMze3CL97q/kGb8=;
 b=vTW8Ltyv1rIJKz1NMOg2o2IXfxy4ru2WBpHuVt9C5NErqiIKrodd+x3Vm4Lq+0eoMl
 lkojoMPnEBMQF2i5z+qRZ097mhcwceGwRlDJm2cU1aU6bkdw++E68H2R0eP9DptXG3v+
 vHqNCqKp0iCSw42rf4K/nR/3oFKjTOmGgBY2BJXElusoW8Lmv8DYpxKkg+0bYfSpQ1xJ
 fXkS2KBsVwGCSx1dnUcoAcD705IDX3d5bQbgbZZFvm9lvaIurDU/AevZGBKZk0cq7IkY
 KrMqdlm/dns/WKfXdHqt5YvPOQYzxSjeVDo1+BUeRHUaMu15f5UVeJCunG2xnV8Efcw3
 wC6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP4ou7g0dE7knRM/q0UC+S9qADl0SIvAzoYO2x3aqrXIWExKhfiCi9sJB8FKCWdhpF2d8xFsT92CmGSNqZt93SJqZCDa0P85UcDjLBi70+5BvLSI5JZZJ3gRVHEg==
X-Gm-Message-State: AOJu0Yzb7VVj9LhuyqIgH30gXBJM3QCQ7gqC+RdcHIuq67Lnt6DV/avH
 zpKEJdvGcXhCgwqJyAPyJxaKybdOQtyQDfcM9KHUuI6JfBvYTCPbOy7f2w==
X-Google-Smtp-Source: AGHT+IEx8gcj5bGokGVyKMB/94BfU3JzwTai1LOpxID13VP2mRwyneYTT+NcVZ755kI00lz1gAfmxQ==
X-Received: by 2002:a17:906:f59a:b0:a55:6602:e3a9 with SMTP id
 a640c23a62f3a-a5a2d53b27fmr1096572866b.1.1715595076679; 
 Mon, 13 May 2024 03:11:16 -0700 (PDT)
Received: from archlinux.. (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17894d2asm574906666b.87.2024.05.13.03.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 03:11:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/3] Trivial ARM changes
Date: Mon, 13 May 2024 12:11:05 +0200
Message-ID: <20240513101108.5237-1-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series improves the tracing experience in two devices used in ARM cont=
ext.=0D
It also removes a duplicate statement in an IMX watchdog which may indicate=
 a=0D
bug (see comment underneath commit message).=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
Bernhard Beschow (3):=0D
  hw/rtc/ds1338: Trace send and receive operations=0D
  hw/timer/imx_gpt: Convert DPRINTF to trace events=0D
  hw/watchdog/wdt_imx2: Remove redundant assignment=0D
=0D
 hw/rtc/ds1338.c        |  6 ++++++=0D
 hw/timer/imx_gpt.c     | 18 +++++-------------=0D
 hw/watchdog/wdt_imx2.c |  1 -=0D
 hw/rtc/trace-events    |  4 ++++=0D
 hw/timer/trace-events  |  6 ++++++=0D
 5 files changed, 21 insertions(+), 14 deletions(-)=0D
=0D
-- =0D
2.45.0=0D
=0D

