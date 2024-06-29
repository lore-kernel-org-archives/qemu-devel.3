Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A9BC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRW8-0001Ao-Tf; Sat, 29 Jun 2024 02:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRW6-0001AT-2R
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:24:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRW4-00006c-AL
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:24:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f65a3abd01so9714185ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719642294; x=1720247094;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fRjUgTd51th/h0XNgf29yfxHYHLJ7O7+iS3b4QJilnc=;
 b=VUqY8cAuZXu1YXSpIai5vtqeZm+UkUDQl6RamhlHqlsiST9rWIo4LDavFkhGUj135k
 cMiYqS4Vu8dDr864bc8uabtcp9GmF8DJwjZfVVXEGohm8q26eBJXWIkA991rkDD4pft9
 Rm6fGHmfcfR6HulEPYUatDARYY0Lzscr2gkNwtg+E8ZX/sH8TrvYfRqBJEBfKpitRqnV
 VuSZL49VST8WM3dWcQDiKeZwqAk+nMfjv5n9XrFmqFLHAW27LhiKIPGkVK4mlUJs/IRo
 qp4LJOilWVk7B35YyhA3fU+s9wGFpL3v0TaM/HMgKCkQRTqJeQGTrB+yPxh4XjCBdSU2
 32/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719642294; x=1720247094;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fRjUgTd51th/h0XNgf29yfxHYHLJ7O7+iS3b4QJilnc=;
 b=Vd0VW/R/IZz7d1T+vtBa8uu2qa0iMf8QhsaAZyfkE6L1p+g2ZUl2urlmfxhpa1ms1L
 6SIRc2eDuThU5+HViKKvlT14gtDPhanCsRuwhWuwHMHsX786fhk6yURN9MnBzzcFdblr
 jCozs7v73XtjfoDyI64Z4t494VVVnrDt2aNRKD7J7vZLygQ36Usn/8P0nENDLf3O0SIR
 oUSFfOdN4kddmIADzHCuCYuALj0leyItj+ItgDHNEo+8AJbnUB/Y5FE5z3xRXO7bhVOp
 e9V0QROjRMbNe5be20pqm2+Tw0jYz82oFF9amtTGP2HqaW1fWio1yvX8wFsKHsNbmtQk
 aE5g==
X-Gm-Message-State: AOJu0YwSylqittOPJ2qZpwRgtTsvWGiyBaZy1lRUVw+dJfqrnzyo36Ef
 MVVazOEwXC/HhTih1Ssu4W/EWARxN2+/EMdodKioX3kGGfKmU2ixvqmF4EFKEq8=
X-Google-Smtp-Source: AGHT+IGTTXE7WVmsvWnPktZecUjpXHSBvr0YDZuv7MUCVvwJBgzP9gVokeBTwbdMKzHFSjVArn/1rQ==
X-Received: by 2002:a17:902:e892:b0:1f6:e4ab:a1f4 with SMTP id
 d9443c01a7336-1fadbc5c269mr1938825ad.12.1719642293992; 
 Fri, 28 Jun 2024 23:24:53 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1face441a1dsm18442735ad.39.2024.06.28.23.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 23:24:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] Drop ifdef for macOS versions older than 12.0
Date: Sat, 29 Jun 2024 15:24:43 +0900
Message-Id: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKuof2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyML3dzE5Pxi3RRDS5MUEyODNAPDRCWg2oKi1LTMCrA50bG1tQBp/5u
 pVwAAAA==
To: Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      hvf: Drop ifdef for macOS versions older than 12.0
      audio: Drop ifdef for macOS versions older than 12.0
      block/file-posix: Drop ifdef for macOS versions older than 12.0
      net/vmnet: Drop ifdef for macOS versions older than 12.0

 accel/hvf/hvf-all.c   |  3 ---
 block/file-posix.c    |  5 -----
 net/vmnet-host.c      | 24 +-----------------------
 net/vmnet-shared.c    | 13 -------------
 target/i386/hvf/hvf.c | 23 +----------------------
 audio/coreaudio.m     |  5 -----
 net/vmnet-bridged.m   | 13 +------------
 net/vmnet-common.m    |  3 ---
 8 files changed, 3 insertions(+), 86 deletions(-)
---
base-commit: 046a64b9801343e2e89eef10c7a48eec8d8c0d4f
change-id: 20240628-macos-d194d420f01a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


