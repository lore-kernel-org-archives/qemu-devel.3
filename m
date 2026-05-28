Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE984CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGr-0006IK-6I; Thu, 28 May 2026 16:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGp-0006HQ-5b
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGn-0004fV-J9
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49041fb8c23so54917265e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999836; x=1780604636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eaSEEknCZ8n7zZl3zMB/OCXzr1AvPDpeDEajcPfNsZ4=;
 b=Cu0jcDHxMdektfuJ4VIujWxQaFqXejpYKmZjdLav30UoxpOCkQC+XCVpdjlAWdb8TS
 16elZN0zSmbuxNcoKc1q82ZWXhGKEMrG7M3PvR2/stl82LVtOAXJKVou4C6E+to2yvht
 XhjAHtd77oqTcdg7UUrU+5xLKFhIZ2x7IVxcnepWtaNTTzuu2r3i7herPUsjCdZy/TeN
 gi5E7ayMbgV0G+86CXewZwJ8KlbdyZCK4gQtwZska41hm7O+hdkxGOYIacgpWvB5zrq6
 xEmlIX/AEjNwZGtFd5OqWEEMEJsD62NIa3MwoTtliG7WXosOPD+G66bKj/T8X1SzXdKy
 tKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999836; x=1780604636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eaSEEknCZ8n7zZl3zMB/OCXzr1AvPDpeDEajcPfNsZ4=;
 b=L3DPO454gYDuUzfnt9tmjaSIITE4Bs8OXDYPDXTBjFFAIz+4psjyvYMf4XQWECi+lq
 pUTGrhGcudkFG4yc97dVllqPI7l4ogDnox7FCja1pRQBIhoqawWtG7T0ZBP8XmwVDjA7
 Xjreg0+JYCUhX8H7Nu4nGQu/Tp/iae1lGAUCTsWZCNPqA8mABDdQ94lDpT1u7nRT63Jx
 HWQy3GE+XLuGOuyGQc1caKuULARd+rzZ5TZjJ6PLonLGEKP0wWgpwz+i92EQGKOhakvK
 daMlLFDYYKk/CAOm2LeSumMdytVhTpBzRJP/UX27iJE1IBcTZi61F1RShjAlojcqzs2w
 J4Tw==
X-Gm-Message-State: AOJu0YwGPah4UMa7V62vExa6Q68JevE1hJClc//oliKdekdSMWOKEv5v
 7wBQsntuFCoO1HViH1+tLdoIXfESRuBCySq2SOlc4wVqrpyd/TZTr3Yvlw4Ur+yn6pF0d/9Hflc
 SqUHU9vrabw==
X-Gm-Gg: Acq92OEMmHRtqQPvbgXiOZxYxUNSd5YmgNDVRfJgtyYFZXvJN1KaPki8SvJaGcJDYVl
 Zfxe9xQU8Ru8nAsVHtZm+0Pwyr2JZusHxLcVF0hemJHw+2lu9FaSGFLW9Gp/DYM3MSQne45MGwM
 wvqdOf27PriaOninIZM6Vn029jlYeTb9sVmN8wKj5vNzaI8rHBal8AImsFjEzP1IXHciVOq13pA
 N0znnv0vxTNy+zvxZDgkeYqBqYPWmVvNINBui5h7ASKmaHPECsFY8Vb4lS5As4XoH85hfFtnuVC
 puleEd5i5T8a/JUYFxjqnPUrUnozu4QZrQNiwkHGmsj0kdyyiJuTMmHIxOQ6HYn8H0j2DTrBitU
 wuOMfYrszAoDKx6xW5/bw/PDtsW+U+lltGPpwoKdwOR29YKpXhvWHOP8YyS9lWvSxNVzFjLmGqX
 nIdHVohLYdgMdUaPKfjzx8IhgiI7YuoB+sBnKUMTxHQwBhVD1MVHk2Mgx5WUWQJkKAsQ==
X-Received: by 2002:a05:600c:2113:b0:490:845e:3a6 with SMTP id
 5b1f17b1804b1-4909c0b706amr224095e9.25.1779999835923; 
 Thu, 28 May 2026 13:23:55 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49091d55972sm58891435e9.0.2026.05.28.13.23.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/22] meson: fix close_range detection on older glibc
Date: Thu, 28 May 2026 22:22:38 +0200
Message-ID: <20260528202253.49122-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Quan Sun <Quan.Sun@windriver.com>

The has_function('close_range') check succeeds at link time on hosts
with kernel >= 5.9 even when glibc does not declare the function
(glibc < 2.34, e.g. AlmaLinux 8 / CentOS 8 with glibc 2.28). This
causes CONFIG_CLOSE_RANGE to be set, but compilation then fails with:

  error: implicit declaration of function 'close_range'

Fix by adding a prefix that includes <unistd.h>, so the meson check
only succeeds when the C library actually declares close_range() in
its headers.

Signed-off-by: Quan Sun <Quan.Sun@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260522201850.1342167-1-Quan.Sun@windriver.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index eb074918193..e396394f4c1 100644
--- a/meson.build
+++ b/meson.build
@@ -2596,7 +2596,7 @@ if host_os == 'windows'
 endif
 
 # has_function
-config_host_data.set('CONFIG_CLOSE_RANGE', cc.has_function('close_range'))
+config_host_data.set('CONFIG_CLOSE_RANGE', cc.has_function('close_range', prefix: '#include <unistd.h>'))
 config_host_data.set('CONFIG_ACCEPT4', cc.has_function('accept4'))
 config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
 config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))
-- 
2.53.0


