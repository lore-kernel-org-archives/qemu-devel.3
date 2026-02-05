Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C087ECD992
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38F-0004WP-Fg; Thu, 05 Feb 2026 12:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38E-0004W8-FM
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:06 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38D-0001St-4q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:06 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-66a68106cc6so436400eaf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312424; x=1770917224;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FnsLIg23aMSoQlgSq669JG9s5MekauWlLu1wvfNLqhs=;
 b=Q77GIVU5UiH4PaOE/zK/xsMuu+hUScq/psW6cLJ/waEYysPIPnlSCpLsOq61LlCuTn
 u51OBtXIs0lFKG/Eu5mZGZWBPu4qMsw7NG4XPj7a1Z2JdGUnq8tHNWeC5NF2UULt8OgE
 z5WEGsGDhP8/kM2ZWEfed5Vf+0f9SAnGjRoXVwfy6fZlYDcjsjHhJtHPjvbS6PM/ec4I
 pHnc1Ig+scJKU0ZL1thbLVmNk9Zia8fQrOnA9zcAy0a/aMjot6gCeihJTefbtdShjJJY
 pjlFbhJMC2fYm7nY9SBW1REWjHXBMMc4DD5/5vfawXMN73H8aIkWYKZ2jQ/1DJbfo4B5
 KMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312424; x=1770917224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FnsLIg23aMSoQlgSq669JG9s5MekauWlLu1wvfNLqhs=;
 b=U8Ztw2m+Qgn0p6QaBGoGuRF9LNEH15d6l2lrYuJmIQrRdek49LnTP0wDXMTnh6lLZD
 5nLhDBiZ4STwrvYvkcJ98E8qsCjrNclCX0ELtSU/MbDciXtxwL2+CuobgdwZjmybe0JV
 ur4zJ5kJT4n+8jwh2PF05XQ55rJPUUahZjsSsPEjFZfi+UmCyfNbEZxpkwyLAPZ/Rg0S
 dgpdhagx9yGhlMqdarEkxSYGWtHaqZEkZu/sPve+YkDXKuRU6vn1JACje4EET8E8RmYy
 31PqdeoYmh7wgL6u6FU/w5QhTFnHEpVkiRW7sALwDmGRsiusAULE50uZKN2gxM9no7so
 wtzA==
X-Gm-Message-State: AOJu0YxSLm5C5DnzvpAxZRUwAAmePvI75xR1Jv2ssh0wj7T6RLhhhvy5
 wC1GDW3M5kJ4ERIRWhPDMy1ExjVT6JmeR2zwC3GuF2HgccP5W2DvxqzVsJQIQ0u7QAI=
X-Gm-Gg: AZuq6aKavgivYkv7t81lsiwSxebRxTr5FqW7IgzHMkaz1GjHI+kqxfIsTzMUO2onwrs
 cF6TCVRMBEP7ydB2kINJ9ZU4W8oUGhqRQLsXsH9QbM0k7i+1J1mG2ADdm3MFAQYqe8zGog6Tkdp
 5TnjG/ELm8udU1YH/OxmZNrFvhqR+aeUN5G7Cq35i69++mS8yvEvEdftST+O4eqrkTX/D9gt7b4
 eZBnrY571WgoyMS0CQOuk5Q+qcPjsmkixLrv3EyAp6fedbgBjzjZ1kUWocjKiLv8D8g3lB43duS
 oeFSJ515obwVITk1G2rC2ipCvR8/pya8sHW3Ln1mvDQWfIu+5kUuYIfIC+J4ZBfJqauCZVH2GqU
 15Q3ZxfEXtAwIIyQQZB0YsCPSm4vOOB+ydSitQaCcd+CK+lq6RZSMWTPH2lWpwDPymfL5m8lQxA
 ==
X-Received: by 2002:a05:6820:1808:b0:669:f023:c586 with SMTP id
 006d021491bc7-66d0a096323mr54694eaf.30.1770312423967; 
 Thu, 05 Feb 2026 09:27:03 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:03 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:54 -0700
Subject: [PATCH 21/24] bsd-user: Add bsd-misc.c to build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-21-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=609; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=GFQCbvPb0BoC4AcU0gd5HR14BGHlJIxi6pSz/Zl8QCQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbxSV43BuVxSU/DYcDf0Gm9sXAUfqvDJVms
 GEsQiFbj9CJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 AAFPEACtdDIKdo3V4QgnyHe+pbaDLyLaJ+iv9bHdGlB3OM+DtG7jrDS1YCOk3UpTb9MxLmNw0qT
 MYPWQGEXuLIku8fA5gkrcXpZUbqIuAhfkDsHzbCHrEHiLXuLFk7UPnDbOKio4UxcNaKRuS9zZOc
 LlVVhbpvYTxg07dPCABMgpOHnmO41FwwfIZ4RgtVxZzkt4MBGwE3YuSEinyOOAFyA1iQXKNSMPG
 Mk8zPNSiWrxB441XyqlwtYpRn3oEBYBj8MvUJ4ARg+x017kXsJ8tNMeIowl1fDGXEUgew9BUeM7
 LI3E9ngYOTAMKHebrKIyLKv9wk5oqlIuBZemoO7/gzFnTuoBFqdMTzb9z3NZSIo3wZZhqOLw+kB
 w/DdAzfML6jvisCwM5VWl/scbKCpGZI4MIXIyhmeFBIKa1VquBZJXCzxEa2QNVK9eARO4ClszG3
 pTI2124gC/dUT+fXbaMHIXOeGkRxiL3aMcIqnQS+u1VzshfSHYMGjikCGaflPMIaCdNNO5/31xN
 eNU7Zb7+R8ZuJRi+GnhojTBxYsIDAzuoBhrYmhQvOenfNT5VCDYpI8X73ldS7ta2ZsfJlSK+olR
 YjZXkgbRwa+DZKX/yMSdDXkmRy83pHC3eDTsRnA54LF6NI5fr+/Z9E6LXYtZpOO4XvPXOUGTH7r
 rTxUmtaqyKeWzAA==
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

Build bsd-misc.c for routines to support System V IPC, UUID, quotactl,
reboot and getdtablesize.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
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


