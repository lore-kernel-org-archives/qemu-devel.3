Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD4BEF06E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASs-0001q2-4U; Sun, 08 Feb 2026 14:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARE-0000e3-P3
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARA-00007r-4u
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:20 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6610f407959so512956eaf.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578814; x=1771183614;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lKq/gG/+viO10N8HLqBDt3Ws3+oLoEWzmVBSf7JLh9w=;
 b=MhJ4G3g9ZhM8ISpMC468KnBOSCjPleVGv7pI19Td6ucq/q1TptS1hvkmzzDHSI62k9
 RMdXZZEMlEd/OTHhMWE3Ep5ohepB92ddf8E/Mk/tCgInkcY3m5Hex4kKiP4PRCtuDI8Q
 laXNGZFhU45PrxsBcDdE52InGJU8J9vSpyPMxouIg83f6U5DH4kXZqURpgBkpZYBqGRj
 jdTQ6WwDoUAQ0z+DSOUNyZZdoJhB3YkSWZ4wc+vlwmxEn8f89OD1arUCd6XRhRo4xu+Y
 wBXBchwrzUOtC+WfnoiAIdWULecl4c8JLvY9djsSMDblCO7yfEugRpi513ik1C2m1Gbk
 asig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578814; x=1771183614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lKq/gG/+viO10N8HLqBDt3Ws3+oLoEWzmVBSf7JLh9w=;
 b=G6dmunN9vMcpVrAsO737NT8KxRCcowbJrguy3bh+nLKBh2QFondnE3A5ULXaaHpv1M
 qTJvKMXpmwKKOrDQgqa5ZkmpWEudO3G4zMLzqGB3RZrop0wKA5B/CPVBAz2qUbGDKXg/
 13PE1yCHANUic4fo3TWgbAVAMHnuN22Yj2mfYM1LYcmrAbKxuQxaJc87z5tFgdiVvWzo
 eLbe+Mvnv/OZED0rRFmVOHh6qVRBe+3GGdo8m8xOiODcwStxTApXSGyZp8+xLLZPcLYe
 gyTKsslGbfxjU4EpkwzouUJ9ZbiOwKJDnXOYnSKSkua3woQwVXtGEqN6LEZDgeLA3eu3
 Uj4Q==
X-Gm-Message-State: AOJu0YwZOU7y00qSdTM89w3bjQvN1gXZYGZq5JmKjqzJvFdtAfwCr2c7
 Csh1ejEeBO5GNAUFOYFl59PsHsOjH95d4lJwcx1HPdWTfTnu3KJlnj4Ly7vkHmVXZ9w=
X-Gm-Gg: AZuq6aKin0v1Z3tMu+3U8V1JMo92q91ixG9LJkx2V62ytNd37hBkw7y906coevU9KyK
 J8RYA7MJl+jkhG4PNIS/fBjG5RC/MsdjadEDNSM/4MFSpNffOD2QZk+25d0KLfYFc1qS0ymoMHJ
 6xYZwWZ7oOZfTJeSGf3UT064rMbWlAeETAa+6As4ZEQVQTXnxR8wVy/rGxDQ4yP5lf0MjDrOoV3
 4IFdf0uiXEyG52oEXwL4e5ckPNWSBewPrzV7WYBbsS69G644P7Sy2+H0DQfIPCDVnDgfFCFzLKo
 INzPJnYRXLv5tABsJqN2Ql+7sfF2O0TzHAyZk1uY7ugflCnUcvDuEY/DeAB9VMAFCUsU4RUC5Gm
 8EWW2eou0LjXmbRtM9BzjOLGmlDEsPPrrEdEdaexuXAle9/A40i9L5pvDMNffADGD4xHfHkcbPQ
 ==
X-Received: by 2002:a05:6820:2299:b0:65f:6628:94fc with SMTP id
 006d021491bc7-66d0c667d64mr4112324eaf.63.1770578814208; 
 Sun, 08 Feb 2026 11:26:54 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:53 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:30 -0700
Subject: [PATCH v2 21/24] bsd-user: Add bsd-misc.c to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-21-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=672; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=lYzRsyug+gEPTEbXMUdsQyKOjOqAIW1H1r6EjiVoPYg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONhQxQ160lWosyKCBIi8Jd+Q8BOKSqyYKra6
 CjQyoMjTM2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 AJ+DEADbEV85rVvx+TIQq4SFnBL0nTicUBU1uvE9PvG3htVdqkIROuUO30i/bLDkHa/PHZsN5/Y
 vHZLMW+QUQzSO4HdDFYbpbZZ/9bLKrDLKqkpSSgT83iUCp7kUnguj4SO0xOmdxxDa9yRHuYRZIo
 ig9bLavmJAQ1dZdMnEtKHu1yC7KCYv12N5RHfJtQq2hQ1nJ134UdD4leHALLjIVMX9Mj6Ba9bQC
 tTcCY30fda/U3Z0SFZhJmdM0I3QXcnitvw9Pac0jzyOSq3lMLPWZ9VT6KMxaI33BDlZfb+2jZWh
 NJzI6GEE6vzR8M12UR5cSoqJh8TUaV94SWLmyyhgjQeh1yrqif/vfkl7sNGeQXocn0xcPHEidNI
 j0dr1nV4WTR9H3U7eFQUxU1NwJbfKoHNNXxfXRErMhOwgUlvo/AwD5G2Cug6cQz/FSVMSNjwSdT
 abIJOILJRIl3rmFXH5sbAFR0h/AsJdMYSX1DFGrX3Vjigb8ZYKF/3mHWgitEiBiwWYESRYxmQMY
 wnlD1xEyqY8farfwB7HkcZawUxDnojlOyYByRTGuIKk3Bdf5CnpmMFfG6XIZCGBCauenlTtombZ
 TMjzjDk+ZKrjhudClkrwXbz7INTb2mLp/W31LEYkNMzlCwpyGLCB3U5XgRZRmQ31mPMxxaN4PYk
 vF6UtLLAf4l6Xiw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2a.google.com
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

Build bsd-misc.c for routines to support System V IPC, UUID, quotactl,
reboot and getdtablesize.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 37b7cd6de8..00428fc2f8 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -8,6 +8,7 @@ common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
   'bsd-mem.c',
+  'bsd-misc.c',
   'bsd-proc.c',
   'bsdload.c',
   'elfload.c',

-- 
2.52.0


