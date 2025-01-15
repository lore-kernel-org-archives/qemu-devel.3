Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD72C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXwqp-0005eU-OV; Wed, 15 Jan 2025 01:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwqm-0005eA-Ot
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:26:00 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwqk-0006XB-GI
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:26:00 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2165448243fso138187215ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736922357; x=1737527157;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DwPNPMiit1+SXCCQTkug81gRYC66draPHi9DabeLSP4=;
 b=DbX9wFVXo8/LaDbefmpILmpIcCzuRUzhFqgvzbsBe0YurxBalwGaSQFu6L8M4NzetD
 Us88HYwFPudjzGKcNMWG/GCLlIjS4u1XAOI3wrGnAKbKIV1FyBV829ZsNxaOJfBeujCR
 BStAs+kaIlNcXbid/dcVKf45l3e2oqWqQNCwU/hEqJqoIwFjvAg2lsw0+gJz45pcM284
 FO/Nkfkxf96PJPO2W80+tURutYHP3h1T6p1EP2UN26kC1mrzx/hL2KQaOHSxSFprdy0J
 IFEwe++T/U9jr/WS8FjVuAQ5/D7N0p0zo1dmepmjZU8SGF6BjPvKYdtEVKWxDTmZMvZp
 415Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736922357; x=1737527157;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DwPNPMiit1+SXCCQTkug81gRYC66draPHi9DabeLSP4=;
 b=DpX0ANSlb/nIWaFwvb8l0/7Zx4+HAccFYg9Tgz/6tEaIsfRaqo25e5tCvG8WEskrr+
 7Y+yvt5NjRf2S5RlrVfCaBUz00Kt1Kzs+nfUOtzRqYXWOzk5bX0ISsBL1d2RLyFTDBpE
 aaDChVrmyV7kEUg8R/vNWmcerelkaOOp5StIn6U+DpZkhzaBNlSKAM+ICCm32rJGeTOs
 4Hrg3hcWk/6zZm2lVqg+8VRnzoMcZVUjf8uoElQkEfg5fxKO4zyUAwrssvhTgfqhQoFk
 PJFC11NIX6LvEZ9Ega4WRgktaq3pzoJAHyH9r7GGqOtuCLH7BohsCbhb69ubFqWQqZTi
 klLg==
X-Gm-Message-State: AOJu0Yw+HreUN18pPXNrdR7O7TwB2LHdR6Qp/hUiVh+nBrzSE6uc/DhA
 Dvn2q+oqqjcN9lyfalRvDz9oKMyOZaUccuL8QfEOaF21MjQM2rXqQrxGXiXz0+o=
X-Gm-Gg: ASbGnctfyRiI7yBCeXKKIq6/4QwiUdqmlvgYuG1FnItJmiD1r3MWr47q92JvLwmGi5o
 LbjQ3hllx3iLY6330XpVfJBZ30NNzBtIPQ0oKdJMPADjqmjwvbMLxZS6q1CUD6tHYlOM8j4uFFU
 Juwno1hclIN2DH9qrzUfIrpEjYnwOb7Vo3KM0b+zeyPFBkzkCtXBAFwajeScIQPEhpjSX5llBL1
 AyT8t6GLCtnGxJ4NMlsMfiUdnxCHuZfBPFeYyMh3zMOD3LbmqTcEayRPbc=
X-Google-Smtp-Source: AGHT+IGgSIj+5bfNjTKCeUh566yT356Y3Ni7Di1/ok2MFsc9zR0whW/QTGH43yyHepnMVGKP5DBK8Q==
X-Received: by 2002:a05:6a21:108c:b0:1e5:f930:c710 with SMTP id
 adf61e73a8af0-1e88d1d4a4dmr40961830637.20.1736922357014; 
 Tue, 14 Jan 2025 22:25:57 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a3184b68b3csm9099117a12.25.2025.01.14.22.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 22:25:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()
Date: Wed, 15 Jan 2025 15:25:45 +0900
Message-Id: <20250115-glib-v3-0-bd3153344698@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOlUh2cC/12MQQ6CMBBFr0K6tmZmWhRceQ/jgtICkyiQ1jQQw
 t0tRBe6fD//vUUE59kFcckW4V3kwEOfQB0yUXdV3zrJNrEgIIWEpWwfbCQoXSltDOS2EOk6etf
 wtGdu98Qdh9fg570acVv/AhElSDSgwVJxMiVebTX3PB3r4Sm2QqSvlQOC/li0WQSoGuXyc0E/1
 rqub6zpBJHPAAAA
To: Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

g_spawn_sync() gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Added GLIB_CHECK_VERSION(2, 70, 0) for patch "glib-compat: Define
  g_spawn_check_wait_status()". (Daniel P. Berrangé)
- Link to v2: https://lore.kernel.org/r/20250104-glib-v2-0-12013f3e5782@daynix.com

Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/r/20231219-glib-v1-0-1b040d286b91@daynix.com

---
Akihiko Odaki (2):
      glib-compat: Define g_spawn_check_wait_status()
      tap: Use g_spawn_sync() and g_spawn_check_wait_status()

 include/glib-compat.h |  11 ++++
 net/tap.c             | 169 ++++++++++++++++++++------------------------------
 2 files changed, 77 insertions(+), 103 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20231219-glib-034a34bb05d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


