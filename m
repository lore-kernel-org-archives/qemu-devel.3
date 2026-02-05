Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF7AECD98C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38L-0004bf-Hi; Thu, 05 Feb 2026 12:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38I-0004Yx-Tj
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:11 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38H-0001Tp-IP
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:10 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so575028fac.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312427; x=1770917227;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DNXsVGuKsqirsutaZJpQ3DbxGjpczR1SLSZinZf0pTg=;
 b=dO1d0Q+NXgqrJrBEgS5BplfGGZsrW5nQPghU8Mdji4Vib/hUjV9NFQ5VVTe4uchYE8
 TD+ERTkyDcQvsSX02fOUvWPhus0gpOxTdd2VMeehNR2Vdb1qXaCJ1CGLMYXF8AroIJ0V
 pijjjPUmoQ5pUT25OnaxOY8C0d1ZO1+7QcXQW015BXZYDzEv+ID2NzVxM+aVQ8zmvU6t
 ns3KjdK+VK1XPbfXX57X9Krttn4RMAmHv4dTfMuLvMgLIyz4+DQSsDee9Ekm6hyzUiRe
 hR6bwRGXCMbrhM7/mZP73eQUNjROnjiYWsUxdJubRsKy6nk7oCDpaf2roDqQI9alGn5D
 ZGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312427; x=1770917227;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DNXsVGuKsqirsutaZJpQ3DbxGjpczR1SLSZinZf0pTg=;
 b=NRzRwFhAjKD2cOw0B7+c1OFdcWfkdqiAfBt9+Hod3OnjfKxC5YYcVNBG/fTChhu70t
 jW/wziCUKsC0Bjpwe3kiRf4MPApkndmjSkGT1kGtJbt0mGUlZrtkRAdjIJjZtRTB8SMT
 Ra9c3OiocchAb2vDVAoZfpQewpKf1w0rs48F5A2JCoJKCY1UTnnzFOKFl4P9bcfGBxZ8
 //J5/4OD4bP6g0z6W6bDqdcdvwUHEVCvtNLSRS54ze9xVC3hAwjaDWR0K8pVuS4W/oGF
 BCr1/WCg0mGFd7s7DVHi9FWzgQIPM/xaN3JQ2/YJ2PqF0eyanoRKC/8xjmWXp5VDKgTy
 4ukw==
X-Gm-Message-State: AOJu0Yy46+zuEu3BOWyyHfvquxRqOCFPjoRlzAYw8KfF2fZW3xs9GQ1+
 MIibECK0+7vMNNCa47YlPTvlXICJy5shtOEzpDo7fJqwFW++qsq3xo8ANTRdZcjmvP4=
X-Gm-Gg: AZuq6aI4AKYQb+R/u2xmsDulGGcT/26N06UF54E3NPXOTFzE3DUsI4IDv44IbGGkZUe
 YQAXaV8oNFwmCbvJqxXNxOxx2kXc62s60hfBRnD+hLbamKw+HYnUhCD1YpCP0Wx6RuwG+Po+u81
 D5cPy3N9XjTym++j2B89Giq9BVxUUzUynnsmnOlkLXZ/7kmxQN5fGip3jvO8pbiK0jd2ercX7I0
 Ya5uYSHeZAXbA0IyHBcLxid2WDj0GxTcOed1FcbCT1woWZ8BaVN1cBQckHozI8gLvHCpGhvLOJ8
 nCiV5/V8kx/i2vtShJOyC6tO47HHjyuPDn8BwpY1ypH8ML15Cww1gU2EgEaEQ3J3IlnF+IWjUvf
 QloVRat6PNL7CE3/2nN9lyV543K6kalYjajoEFMZnXeJtzYRYH1tSyR3dN+tTRVaOYY7Uu1vyNQ
 ==
X-Received: by 2002:a05:6870:1f05:b0:3e7:eee7:948f with SMTP id
 586e51a60fabf-40a96c5d707mr20433fac.9.1770312427321; 
 Thu, 05 Feb 2026 09:27:07 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:06 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:57 -0700
Subject: [PATCH 24/24] bsd-user: Add miscellaneous BSD syscall implementations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-24-8d8ff0035372@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=279NpZbks/nlpnHHL4V6je7RQ+ARxHJmSBvv10lL1YE=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLc5ReVtK8bkaZKGSU9Cesz6psePIH4n902u
 aedEEpaEHOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS3AAKCRBsHNEofbAR
 AHYjD/90jH07XIBQyNcS3/kynpZX/+zVyVQonVFW2HH50U5zkraDO6oCecXmJtdXghSw4Znxcnd
 u0tf9lbUYtsMWTQ7PeUllcMJZUa1C3T6vOBtH1PbIKe68L5tU4qOxKlVbEOxcA/eFAjWgoueEA/
 5A0usZr+ZvLaqYQiMjS9PcS0Xbm78onE/17b5U1pMSpVFgQmnG3KqFobpjCpTz1JIaaYHhrIIMl
 3NBy/DPBG1kd0bwq7H9Mw/bLWB2Qujy1GLcZeCh81C2zOpD70gMYWpZVQMJvGMKmHPz1AqWF9BQ
 0+eJDIggEUKNdPrNKnXGFDMqfucx6PeD9CsDDFAkNbiNfE07PDTKJRyjGurGKJ1Ew9rfwJXJkCI
 nbwgRwmj/3wU41Uaef3+Dn0ES329lJN56QIf7hBuQ/gRvE0pdWXfHzSvWT0FtfYIx98OFhD5qw7
 KlXuYky3ObaW9f0f+OK1Duwof4/EeB9WZg11X+Llat0NFU2Fhtfcit62Yw5h1cN8tOrne6ZNCbR
 LMieyS1oQq8FAd5r9mCkNNK7szWVnjSsIyx+ymoHLr0qtpY+l/WX2VBLpi0RHF1m7RZHF/vIuZG
 8SNV+6nWWv5YB9QqizYE7yWQpZWZmLyot5dDiGlw0ZLx3i1gYKJpjduOYTvQGeyLfLQrPHJHsZY
 xj8XJfMUP7Z5LgQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::30;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x30.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Wire up the remaining miscellaneous BSD syscalls:
- quotactl(2): Quota control (stub returning ENOSYS)
- reboot(2): Reboot system (stub returning ENOSYS)
- uuidgen(2): Generate UUIDs
- getdtablesize(2): Get descriptor table size

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index c9b2fadd55..66945f3c52 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -941,6 +941,22 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_obreak(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


