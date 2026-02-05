Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AEEEA795D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnphM-0002wu-3x; Wed, 04 Feb 2026 22:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphK-0002wY-1d
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:26 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnphI-00011E-FT
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:06:25 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8230c839409so421458b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260783; x=1770865583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TOmq9ynBIs1UpkjlR5dpWP01i9jgcpO6pCB7ICL/4ns=;
 b=TSDs5B/UtdCyTKfvE82WWwcEhfILnfOqN7FUToBMKGuuf1LFHM+FSC/6RZG1LqTkcG
 rO1VLiWnQp2BwshzVM0oTC8b/ALJIJjnopOFt80yz7EDCagWo1gh3eWo6+Y8Lf3N51q3
 FSSa4N3jRo8xul/S/xwpTpWulcKOIB6sjAaAWRj7qPeUD6nBWejRr94v6IqAuC2ZEkyb
 TI24DODrKAfMJcrQdfyMm/cD8Rvgk4VGgztflrHJmBB5yASXxFNZJHajk5kKEsfbCmuG
 do7lS0vdxH6OtAMUXYhte8nOQ4zpHpFFJE64P7qtOlUh0fJXDo5GgLDKhtdfS6rVg9am
 HsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260783; x=1770865583;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TOmq9ynBIs1UpkjlR5dpWP01i9jgcpO6pCB7ICL/4ns=;
 b=FBHc+tWp1auTsM0U0GrcyAOTJeyRgmRCJrMATQ7x85m27Ccfdt5gATETI0ar3Kh6N9
 QBoPx8twcrmJ6Q06ZNebLZFTCQWv/HomYPYh866RMKpE12Kv6C/nR5UUXDawWap3E/uS
 nNWu9PTwrEh+4fBVS5fDEO+JRoIAy/GAjO9aI8zGLTMJ+YlfdOGR8gin9g60xotaA5Vu
 EBhKDzyW1yMvQ+jSG/w2JExMuMjICWJmFt6tYrMNRj5TDeUHzPkMu/pC5gjXZRoDs4NK
 +xYykt9KoQl0urQZ1cOsmpD+ua5tm5CjrGcPWd5cSqVDbE4v1L940MnxPlzGrkTxRldJ
 KY7A==
X-Gm-Message-State: AOJu0YxbIWxMxFUOrCLB9dDA46gFr8Mp/Jb3OLBQ6e/50LLCTBz0KBku
 JGC3DkmZTX3B/c4C4xizC9VbEIFZ3f5qieTBNdm/+77wO7OinGqoymtywp1fs29sgZAc+CcmXed
 T51PoOMHfFw==
X-Gm-Gg: AZuq6aLQt6Zy68OzCsZJECBoQP4I8zqFIcDDlxKeg+ijdqirBb8nbYSLcn8Cjpoa176
 /rPBhW+QCM5OuI7GwiYKXiTVZT1UmYaqu/hoJxz36ogJ4JooYQ+ICSKOwkyDw1oZ0shjwDHbeJ4
 TQLVtvgPpRBp7GYxrP4qDuoHrLs2gxZnXQK5qydSlewVmyJkcB74Vurwk3n4PRuPcRLfnknqZ8L
 KslMx/jwSIfdimgsYLWXRk3nNVUWgXTNdr41RdUfKsaXCFXIMY6B0kDlvApaS1/XDK2+vrzAgeD
 t3gBeeEkoAH0p16+BnTVV23IEihHe3mzQOCpNq+0xa7udWevVx1CLs2Q/IqnaoKGeVPYb0Pw3Zo
 iMr7lHhmJMoQ89/q17utUIvIGgMmP4SzyqUYTGBhEUy2RnrdqxhVko7lO2k40Kt4NPnMxb75MkV
 TYDXOTxyNNvZOotXRv3xldTnpZhjbgN4/ryt12X6ETeKAbN0z6Uk95ggkggfjVoA==
X-Received: by 2002:a05:6a00:1949:b0:81e:ef16:b26e with SMTP id
 d2e1a72fcca58-8241c64c756mr4441340b3a.56.1770260782659; 
 Wed, 04 Feb 2026 19:06:22 -0800 (PST)
Received: from stoup.. (bg30dhzygc4twf4fscxk.ip6.superloop.au.
 [2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d1694c8sm4003544b3a.8.2026.02.04.19.06.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:06:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target-info: set target_arch statically
Date: Thu,  5 Feb 2026 13:06:14 +1000
Message-ID: <20260205030617.266625-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Based-on: 20260205030244.266447-1-richard.henderson@linaro.org
("[PATCH 0/6] or1k: Rename the architecture from openrisc")

target_arch() function would reparse target_name() every time if
it was not set to a proper SYS_EMU_TARGET_* value (when using
target-info-stub.c), which is not efficient.

This was found when doing changes to virtio_access_is_big_endian()
function, having an overhead of 50% after switching to runtime checks.
With this, overhead left is around 3%, due to indirect function calls.


r~


Richard Henderson (3):
  qapi: Add hexagon to SysEmuTarget
  meson: Add TARGET_ARCH to config_target_data
  target-info: Statically initialize target_arch

 target-info-stub.c | 2 +-
 target-info.c      | 8 +-------
 meson.build        | 4 +++-
 qapi/machine.json  | 4 +++-
 4 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.0


