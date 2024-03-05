Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF25C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSci-0007Z2-N6; Tue, 05 Mar 2024 06:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSch-0007Yi-7B
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:15 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhScf-0002iN-E7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:06:14 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d220e39907so83195581fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636771; x=1710241571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qLeWVtzKE3nxjK10RRIHsRO7jnOuemZmSYkd2ZBvzwU=;
 b=wW3jyGnKSDKAWlnz7UN3zb72fjaKR8XcwIk5krxoNnQgWDY7KxS/IPZ94FGC3L7KkA
 KTbNVI7dxd/bYlGfTAIGdNYU6YMK9oNm7G2JfZXgIKZXCotDGRFydE6e4V81CGKwj3v6
 oL+fu27ntrv8QS0NTwm2IFLrgOfRHOkueXCllZ0sLdPsff33puZOHCg3BhtvfibZsh5+
 0wiUBTwwIoP3CCBVUk7+ranFCSMXDrXLu611cmn8ThgacSSWHbOGlaepfUywK5wXoY6P
 YeZ6//jwxL0s1mAswnEPf8+T51Mr89E4ZD5uRCP1do1dOlM2jy08krBtOJpP66rrhmra
 jOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636771; x=1710241571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLeWVtzKE3nxjK10RRIHsRO7jnOuemZmSYkd2ZBvzwU=;
 b=ps3juEx8IifxRldLXBM3D6PoT8uFHpOuN1HBK666BIPEtGTxDq8ckWJ4KVNmJM8Cek
 KkN7zfhvbsvrmrcr6ZmKVOBEqZ2ZyyDHn+lkUKvexHsCRTxNinrib6dovuG3Ed0afhMr
 pLYm9rjAhqsijZpq4xESIHi7OsbCqdFvpI6ZPT7471c4qZI5955b9I+VvwU+n++015XL
 v7CHX278k9c+VIA3o/Zjh6Nl491Si2H+GBMJxeaAKuZZZGJVr6YVnuAlebpE95Ne3qEp
 Jv7RIy400keWb9P1DJSOUthHNrGFBD+GXUN6JWLWjbGc860qWw7b5v+/YJ4mk36J7o+L
 qVNA==
X-Gm-Message-State: AOJu0YwMN5/cam0bMJdzvTYV1dJTIIV0p7tfXwACUk8gXVcpJKN1a5Cy
 8UEvwj/1zGp/8WK6FdVA4xvhIeXjpCYPoG2v2E0ZzLSrPHVRC3Au9YE/dT+7siZw/YHqKASM8io
 B
X-Google-Smtp-Source: AGHT+IEj1i94AuB+zpsPCfe9J1yIjHWtEDzQSTujnJ5m1hiRf2UrF0s2O/SHQXMziL6avMamQT5WdA==
X-Received: by 2002:a2e:9f07:0:b0:2d2:f5fa:f37e with SMTP id
 u7-20020a2e9f07000000b002d2f5faf37emr1137769ljk.51.1709636770902; 
 Tue, 05 Mar 2024 03:06:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a05640214c400b005660742bf6bsm5708346edx.52.2024.03.05.03.06.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 03:06:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/12] Cocoa patches for 2024-03-05
Date: Tue,  5 Mar 2024 12:05:55 +0100
Message-ID: <20240305110608.21618-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

The following changes since commit 52e7db443bd8d233acc3977bd150bdadb62db86c:

  Merge tag 'hppa-latest-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-03-04 16:01:33 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/darwin-20240305

for you to fetch changes up to 5576663208b7c31766c580520df506375d00103e:

  ui/cocoa: Remove stretch_video flag (2024-03-05 12:04:41 +0100)

----------------------------------------------------------------
Darwin Cocoa patches:

- Add 'zoom-interpolation' to smooth scaled display with 'zoom-to-fit' (Carwyn)
- Set clipsToBounds on macOS 14 to fix window clipping (David)
- Use NSWindow's ability to resize (Akihiko)

----------------------------------------------------------------

Akihiko Odaki (10):
  ui/cocoa: Split [-QemuCocoaView handleEventLocked:]
  ui/cocoa: Immediately call [-QemuCocoaView handleMouseEvent:buttons:]
  ui/cocoa: Release specific mouse buttons
  ui/cocoa: Scale with NSView instead of Core Graphics
  ui/cocoa: Fix pause label coordinates
  ui/cocoa: Let the platform toggle fullscreen
  ui/cocoa: Remove normalWindow
  ui/cocoa: Make window resizable
  ui/cocoa: Call console_select() with the BQL
  ui/cocoa: Remove stretch_video flag

Carwyn Ellis (1):
  ui/cocoa: add zoom-interpolation display option

David Parsons (1):
  ui/cocoa: Fix window clipping on macOS 14

 qapi/ui.json |   6 +-
 ui/cocoa.m   | 578 ++++++++++++++++++++++++---------------------------
 2 files changed, 273 insertions(+), 311 deletions(-)

-- 
2.41.0


