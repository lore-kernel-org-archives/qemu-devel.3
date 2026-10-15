Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DB0CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPKg-0002c4-3X; Thu, 15 Oct 2026 13:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHPKe-0002bW-Mq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:33:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHPKc-0006Y0-SC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:33:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso7865817a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792085609; x=1792690409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y6ABTVUhHxcGXsofoTtZ3OO8wa0qZQVPTlhUYjeYDiY=;
 b=bYLSf4F7pB5jcQERxwdtAQHOmha+Fj/l0u69wSnhEd66opaKS2b5so7hz0C/o4zt1v
 QYUgvXv45vFi6tLAUTAc/P76VV1qu0uoELeEZ5mTco5yeV1MEGVLKrw/o3P/qM0rMJU5
 sMpaChQSrcd2fVbng/uMuwpYhCk6cTLuN+pphZPozeIsIHpXb0nTFtRq79mmeDEO3pNi
 I45V57pK5ZMcTXAsZXVh5QGoYz8qW/PdEeZwrzy71ZV8h5hB013uqsY4xCiHVT/z+gUW
 D4wh+0SomxE6xbirehQ1y3c2AATOCACT+mK13Hrj9YuRj38azwrbvNkHZ/Ru6XGaoV89
 VPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792085609; x=1792690409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y6ABTVUhHxcGXsofoTtZ3OO8wa0qZQVPTlhUYjeYDiY=;
 b=LOoCyz7KEXlMOY+oY3m+IUGYiaXixv5i0aNZqtlwaoBRg3DDVkkWn57EouDvqUChqO
 AS2NxIllcx8uY4iQJ3mQRbdNZgzNIJIKm+JcKc4yXIwvegiC5HOeG0pfdMwPm5U3k348
 nW5GQOKuylMFaY7sjbS8zDEodAvSTUcpkjJetux073HmULHCwSvx8yiP11qX1uw+MN0F
 cLjsc8zAqouK/xGHrEIBqe7VU418wimG2rjZiO/1spgBx55vkcX44d9wXgkFNGectJwz
 +aKFkHXgfx4X3c6UIeBeuERn3kyKKnyg0teQiSAOZtL5Sxf59WivvFTPMMIIvowst+kA
 +oYQ==
X-Gm-Message-State: AFq9FYI7c6JhTWWh1PkgQ2qOHppZpHik/H81Td4p/aUso875Qy0nBdHw
 Y/SX/gjNpnXoEp0nDanFu++bngHVByoWhSfwEEB5ARj7u13oCnIoWu7YHacK5FzUuzc=
X-Gm-Gg: AYBFou33rGXgCKWtaKeqTaUYxkY6JoU5bV2MLLf6KBTv4t0S9iJTN//T9iLhIZOoWfh
 9J44S91i7XWQUFC4kcX6rfR6dXsDQot0jaHrmBjfhnRxwoXTJMQwa0DjWcEkhj+KApeTG3J4dlY
 ak6mPur9sbVWe8mo6htuswJj1KR/6U3PkUp8DRcLSbmnLHKPfHohbKk2UTd3GOUilT+LjN4bXmA
 sWw+jLhhrcOMcReabmhmTO8wljsrbeJZcQJsjhWZJNnkKYc6wSVNDYXhJXiRW3IE4lfggr+4ezV
 5Jv8uzqRtRWAzUDlNG7977SMnyTLWoGD1r8SawIXqn4CjGO56LUZRJET6isXPMZkZawIkNP/vgQ
 TbUMUwOv+xlcn3bEwUlNCoCf5httaoImlsVZt+lm4qG7m0GmxhfSFcXIUXpftDkx4fDeu3IWMjp
 rKBTPmLkoggRFgM7CgJAksxD22ePj9eC2RBAhey0rtrXJGO0CGxVzYSPsUhupgN/ZhIvtx1jDTw
 VZa6V8YbsOn4RN0UXscbsO2OwcYyvkzf7iOUY46ciTu+IknvGbOz7iiyH0WqlS4g70iwEAiYSuH
 cYa8Vzeqnw==
X-Received: by 2002:a05:6402:194e:b0:6b0:c1d:a7ce with SMTP id
 4fb4d7f45d1cf-6b17c237fc2mr15829744a12.12.1792085608854; 
 Thu, 15 Oct 2026 10:33:28 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b20388cfe6sm2791433a12.28.2026.10.15.10.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:33:28 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, michael.roth@amd.com,
 kkostiuk@redhat.com, Roman Bogorodskiy <bogorodskiy@gmail.com>
Subject: [PATCH 0/2] qga: illumos fixes
Date: Thu, 15 Oct 2026 19:32:48 +0200
Message-ID: <20261015173250.65942-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I was testing my other qga patch [1] on illumos
and noticed a couple of issues I addressed to unblock testing.

1: https://patchew.org/QEMU/20261015142342.50436-1-bogorodskiy@gmail.com/

Roman Bogorodskiy (2):
  qga: fix build on illumos
  meson.build: fix getifaddrs() detection on illumos

 meson.build          | 2 +-
 qga/commands-posix.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.55.0


