Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5AEFF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI6C1-0004i9-P3; Wed, 29 Apr 2026 10:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Bt-0004VJ-A1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:08 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI6Br-0004aZ-0e
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:47:04 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-694891f8f75so5626582eaf.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777474022; x=1778078822;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X+vpUTgmmUCDm+9ikvEVgt8ooJ9JXNNdESCppn40+QE=;
 b=l05BuCCut0s1RmASxsI1VpEV60h/aN2xrJXBzKtIdZRU59kebtc7nTn0CpXZTRahGI
 RHbW1RbNkTT//CKhimh5fnxqLRe7N69P8ZiXsSAGpZ2CirB7AyoO6Y+OXvwN6ZiFJ8tZ
 sOzCXI6oGoQmCaX7hdTkRzfobn+H7M/2+aYXpHSnQz5RpbINVX6EpoZGeeXN1cCVCkWm
 bb4uejkKKcM9nVewRRL8Eo+/YpLOtmhV8fkmV4aNdtcBS0XwmpRZA4VqwWuYmjIpvb2O
 m1IQT6hZKeuaxqdF1CkSPbm+oJIxHZ1ie2xAp/vygWEZxTDsCYsd9KtwU7IPIvI0w74X
 zy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777474022; x=1778078822;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X+vpUTgmmUCDm+9ikvEVgt8ooJ9JXNNdESCppn40+QE=;
 b=WLMOr6kHNOMwU1qpdlA9K9qSkonPAt4kDrU6j2QipGO/x7LrKJq37mil86uDYKj0RP
 LC94pupRbOMpaavySJ/QWcafPturez1NY7XdtIIkS6kTvMnY8rCvVyl+ruSRpr4MJr6i
 AD9/q+7BeFQWs+vkOkyxgSx7HL2jlO/xhJeksXlpnV16cxDtj0NSjBGTU2LaFavyWQOf
 ZFoUgEChVkndq9KmLvlta+nBTig9J/OzLBM5C5l6zajLczk+vinryF/gp9Z5b3HjinMg
 58QFQSfzG9JRf71jLE55BGDmVU87gArkD0hQxvrLdu5WtUJKOD7GTNw8IQVD7hzz/edQ
 GIEw==
X-Gm-Message-State: AOJu0YyqCFER3ly7HyY4/cwYEP5pvDtC673HKI3eOExkKVH39f3vqpBk
 9zuXRDc690I3DoN7uFK1pwhCzK6FfsRB0raYKcGyFYP+uF1Eo8YODAHahhdfugEIjek=
X-Gm-Gg: AeBDieuZF9Y7bv6oNssyLBFZzXfOBVqlRkzuNsNPeu4DaEmW4b1otqn4npSDKLvUcSs
 EzN3LUs8iKU6mGm1xPKkZku5zxZ+tmvGYe9FeyeWWw5wSWtiifTA2XXUcAeA6TGdOGY2Kb7Wa/x
 G7xXQWoOEiVxBAJDWmOMyxmN/Fa/TWuMu14Jzp/Z+ZOfXTZ2rOjczL5QHZn19biFfAaMpzp1mAV
 eju0ErtEC5WNh+RzdTdy74yGSOJTBSBpfC8+xowyVLHTux/zVd0FgTp0LvcbBcr2snfCYeUb7cI
 MJ/ELHi8iSWBTx6E8D+HEtPX4krclaM+qIIzP0oChnsbqSnd8jz+NvJRq47tShi6S5oaoCwRhCH
 xZxI0mcUNcIuyMKFydJ2VqikIIJGLcztVYfDrX0RB/lIUBdo+9/o0kYga8javxa9m3PCbljHYn4
 2Q42dCwRHb2RTb5odD4eOAkNhDt91sG7s=
X-Received: by 2002:a05:6820:1989:b0:696:25d4:1e62 with SMTP id
 006d021491bc7-6966838808amr2229839eaf.2.1777474021924; 
 Wed, 29 Apr 2026 07:47:01 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966b93d58csm1313984eaf.0.2026.04.29.07.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:47:01 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:45:16 -0600
Subject: [PATCH v2 10/17] bsd-user: Add target_sockaddr and safe_ioctl to
 syscall_defs.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ioctl-v2-10-288639bc2427@bsdimp.com>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
In-Reply-To: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, "Stacey D. Son" <sson@freebsd.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=1aWdqqfETnObSvDu3kjSpmHIrNfg8gEN8mkXnAbEnzk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hl96AQn+PECZiJ3RTtcNWN4DC2Ob+vVr71kZ
 46fnIrc0qqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIZfQAKCRBsHNEofbAR
 APZ/D/9pP4M8CMNUN0jI1a7vXqmzGPcS8MmcYjWoWAR3AU4RkiOBAbYo19vGLigKWJf6ga/kA3P
 IpB2cN7wojN2I7XQ/ygnABxOoEjawOezdKkD751Njb8fvSzdI7TL92QfGnTS/Aa+h4uCltQ9leh
 2qDrnstDYsJAlQoMCTJ1auEOlR9kI29kObJzfUjH+PUR0pxOFsaKD2tMiucLa1j06UCHuQk8rhf
 M2xPkgUeG2Qe1r9DuIzHcsxpH33bavyp/JonyFGypOLigHa10BFDCui39cyrfrTOP10C9IRXQMc
 cfkIbaTrY7ucjB07u+JqdZVMcPVOmCrlv97Cq6GbwOHR9w/xJiK3Np/Ao/yArp1b64McAp+z/QV
 MP6OZZsplt+2NSlTSpOFoY9WX6FN7ijoGcZdefrMTUjr4z85wDdHGhcmC3W2Lja3jUI/zkJTau0
 lDzG3YlCG1KwKz3hUD4+fiXNFGirnTCWztIxmtTAMNqwGBTiGVKo3ivPS80y1D1VogzxhGEco93
 E29na0zdtRnAlaU4lXTUnyxh2S8YGUu6y1VgFu4yO276EQyFK5oB4SD0QNi4vZ5WkeeTJY9gtWn
 KZEnRU7uoLSde2LMLbNN9gL2ZOFaAJaOlcgP1gsTYP0Nb8wq9xQAizIIWB3xKoQJimD8P0CVVyR
 9fdjpL5f7BBdYHw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc32.google.com
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

From: "Stacey D. Son" <sson@freebsd.org>

Add struct target_sockaddr definition for socket address handling
and safe_ioctl macro for safe ioctl system calls. These are required
dependencies for the ioctl emulation subsystem.

Signed-off-by: Stacey D. Son <sson@freebsd.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4dbd90c2f1..873aea2fdd 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -565,6 +565,16 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+/*
+ * sys/socket.h
+ */
+struct target_sockaddr {
+    uint8_t sa_len;
+    uint8_t sa_family;
+    uint8_t sa_data[14];
+} QEMU_PACKED;
+
+#define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
 /* So far all target and host bitmasks are the same */

-- 
2.52.0


