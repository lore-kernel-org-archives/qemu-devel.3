Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E0C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TBK-0000aS-Ub; Thu, 02 May 2024 05:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBJ-0000a8-Fa
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:56:49 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBH-00016W-Pz
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:56:49 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-516d3a470d5so9640294e87.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714643805; x=1715248605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UwK0G9yt1YTQL9z94fm47aQHbAQEOf2bDQN+77IL9q4=;
 b=LE3qK27ifU3Nhw2d/ktthNaTwyN7U7+dT1RbB6RWoAqgRZo8gWnfAH9x4CvEtt/WxQ
 Igf/10egizWzY9wqp+rb2I99PtqXqU31ZTbczVOy8ioTZ/1ysEHveoAR+vhGAUNwALFv
 Ygg5+PvMZlrOUp/Hfe9ZaKnQShdZL4durDN8ysCYmTzi5Cumc66J2zcNkOeKC/zcZPHv
 qOHvyRJE1vCTaeTYrKMMJSCNDgBLsUzxtF5MsqFzQEZQFfe6gJ6ybQj7U887HxOrvyss
 OrTNLtXt7Z+ITbzBne7wy0gN8DrgTikiENPs7rrPtcQyRQT3gtZezO7ss6SJCuE40aZ0
 tzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714643805; x=1715248605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwK0G9yt1YTQL9z94fm47aQHbAQEOf2bDQN+77IL9q4=;
 b=qHqmHmCCLVpdDMrPFxdBJTzNVxAmJelC8YPzhdYHJdsmr9CEvbcMi+fOQjMkNFFQ0P
 C0/V8d44y8R//7H5FsqmfgRX5pQgCtFOGMvPRZTTrp3F7g2EXU7HDyp26M9NAZ43c5Yz
 5J3e2jJKb8v1SEk4ZtSKt3SbdVNwdmFcH4ju5+mSMYCD4Y625wPwhZ81l/DVkyYEUEkH
 xVskFGs8C5w0utVW2lxP63gstW3Rp7P1+19LwafRZQH7E3R08tYslREMHIzSR4frxEd1
 cDEfKYp0V89xWuphhCpI+GPwtQj0orEGIGsOXM7TcYFomujkAi4dAnc8flYjaKU055h0
 jrRA==
X-Gm-Message-State: AOJu0YzJuEW+Q6+eHN1zBmM8zkPiq5Di3sv6qfkNfex+Bx8WWDTLpHFR
 izaHlA2CU7qX8UveW9yM1gIJyuIbHO6BlpO2LZYsBLCMCfYtB4VGr7ky05jr4H16jWwrol8EpG0
 9
X-Google-Smtp-Source: AGHT+IGhX/ezVpKUOW+mf/eBze0m+XPWS3w6qKI1nNpYVW5lxoMRPIFnmdW7/y5NGMhFZL/vna2Q2w==
X-Received: by 2002:ac2:546d:0:b0:51c:cf2e:db1f with SMTP id
 e13-20020ac2546d000000b0051ccf2edb1fmr834333lfn.6.1714643805519; 
 Thu, 02 May 2024 02:56:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a05600c4fc300b0041aa570bcd3sm5158228wmq.35.2024.05.02.02.56.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 02:56:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] crypto: Allow building with GnuTLS but without Libtasn1
Date: Thu,  2 May 2024 11:56:39 +0200
Message-ID: <20240502095642.93368-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

Since v1:
- split in 3
- remove "crypto-tls-x509-helpers.h" (danpb)
- include pkix_asn1_tab.c.inc

Philippe Mathieu-Daudé (3):
  crypto: Remove 'crypto-tls-x509-helpers.h' from
    crypto-tls-psk-helpers.c
  crypto: Restrict pkix_asn1_tab[] to crypto-tls-x509-helpers.c
  crypto: Allow building with GnuTLS but without Libtasn1

 meson.build                                         | 1 +
 tests/unit/crypto-tls-x509-helpers.h                | 3 ---
 tests/unit/crypto-tls-psk-helpers.c                 | 1 -
 tests/unit/crypto-tls-x509-helpers.c                | 6 +++++-
 tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} | 5 +----
 tests/qtest/meson.build                             | 3 +--
 tests/unit/meson.build                              | 6 +++---
 7 files changed, 11 insertions(+), 14 deletions(-)
 rename tests/unit/{pkix_asn1_tab.c => pkix_asn1_tab.c.inc} (99%)

-- 
2.41.0


