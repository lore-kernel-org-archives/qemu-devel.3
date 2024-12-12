Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D28E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfTB-00004r-MA; Thu, 12 Dec 2024 04:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfT2-0008VZ-3s
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:26:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLfT0-0004JF-Kc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:26:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43626213fffso1532435e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733995601; x=1734600401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fcVPgvimFEsFW71qxmndkzKREqPen94Au3/alZtzNY=;
 b=JNd/6yM0b9YBNnW/8bCQpFEFPSdhJgFHK/mpWgAu+B0osxAaAGPre1v7+sAX/zm/jV
 itelYweNPTKGPvP9cjCdm6LlS6VQ8U0b9gUDsZlMrnm36u8RQMrxp8O3KarwiBSRFDs4
 tbR7b6P7i+y+SWFVBvhWxqI43NoV2rjDKuxSsRB9jmJjN0hHr+cEls/UFYVWkCwDArwz
 fqoeDASLU2ifhN1lB7qArviubUccNFFzYHWTa/V73qwHRfY/wKA8XNeAD/URkwiutGX8
 wmD+HwWumx7aPvtAkdoVwz9RCKiC1MT3sK8dsY/FdSYqPYECB8wUvLvotL78WSJrNRk8
 tcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733995601; x=1734600401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fcVPgvimFEsFW71qxmndkzKREqPen94Au3/alZtzNY=;
 b=mEakGe4D9a0FqWrPdwrLGBJVkiPJrwSsKc1NdSWOrRhF+M5mPn1+pjOivlVj20KZ3N
 shwkSylrC9v2jfpyIa9u8iHqHTY6nfk6lFfq4x4e/041BzAbnAGfdEzY5nT2Yqidsna3
 V36yqyBdYiipVpBciXSsod8lZZnBVqvH4nBFMOSn0Bmc8eYTd2pMc2WF8uFo7cT9YSUV
 L6k3NVBpr+NTYzvMU0n7lv9M8ZT4FKozITmVOXcOBsfSfbvMLyOQqOEE+gXL2KRLSrXP
 S96hBQht6VtqrdhXg9eTk46UNJ9ARCscWWYuNe2y5y5IU3RrMuSlexNf3I+yXdwS8C1v
 VApQ==
X-Gm-Message-State: AOJu0Yw4d0Me1QH2pk40C2m0FY6gt0mqCJhC00TFGn8aWkVr06I2YVv3
 00k1IYyy107nSHmeIJWBG4WRnCEww7tAXL0DmZjqtu1I5AC1wlKdXml8EpD5SSbjhxVvn+CpCi2
 X
X-Gm-Gg: ASbGncvmb3Ll86K/s5cmxIqVEKBJw3MmP0dIpUNwvU9nfnoky4nw9PYY8Ha8Ix+4qtN
 TB3DyOith6ulIcaEtc1IBbtpWdpi07ki4JQ8Xd26NbTlF4wqATJhLKjfGhI39rZoKXe809yLLEA
 yVjCRH258QKgIfC2hv6tM1Ikq0OMrijXZiQtQF73UYVe5iM70qFvPMdO6FbUszAk59RSPqsqui+
 pTuzI3vmN26lcNI8lecysgQLYekvE45QHuxc+qF2Yp++tR3UZaNiZHrwaR0A9FhrHiACO9LzsI0
 V5LOvMjRk4dUAUV0yApK+ZBbHp/mH1o=
X-Google-Smtp-Source: AGHT+IH+7wT4QKwhXpLgzamPaEXG3F3Fzq66ExLhqDLRG4bF4F+LWZXAQrKRa5NU3nnyZCVPtHd6qA==
X-Received: by 2002:a05:600c:c8c:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-436230dfe7cmr16098915e9.7.1733995600683; 
 Thu, 12 Dec 2024 01:26:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c151sm3476412f8f.90.2024.12.12.01.26.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 01:26:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Haozhong Zhang <haozhong.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] system: Restrict libSDL CPPFLAGS to vl.c
Date: Thu, 12 Dec 2024 10:26:31 +0100
Message-ID: <20241212092632.18538-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212092632.18538-1-philmd@linaro.org>
References: <20241212092632.18538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Only vl.c includes libSDL headers.
No need to pass them to all system_ss[] files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index 4952f4b2c7d..f7e2c8b826f 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -23,8 +23,11 @@ system_ss.add(files(
   'runstate-hmp-cmds.c',
   'runstate.c',
   'tpm-hmp-cmds.c',
+), libpmem, libdaxctl)
+
+system_ss.add(files(
   'vl.c',
-), sdl, libpmem, libdaxctl)
+), sdl)
 
 if have_tpm
   system_ss.add(files('tpm.c'))
-- 
2.45.2


