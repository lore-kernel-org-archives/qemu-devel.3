Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E546BC54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBAP-00064N-5t; Wed, 29 Jul 2026 16:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBAO-00063n-6A
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:46:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBAM-0001wS-PV
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:46:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso15386175ad.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785357973; x=1785962773; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCbmWZ0w0nVpnefOo1teG9dHXtfZHRXQHypQ7yNGJiM=;
 b=mELwvWrWAxAn2Ix/KaypEJ8pkPDiRmNhI/VHxYXS7UATcRXFR1lVb7Tg5PNUauDk16
 nxOcchsUHEYPaIEU7w9/sfFhUWoWG3Q0xWbNbtiNXsOGHY4DWdYIKdY2jYqYHrVJXkFd
 8QRE9gHb5m4chsmf0AKnSmFM1oooUfmcBiPu8qS3QPLT6LoDk9/PGtZVzzXuuvkPPwcZ
 eH+Gw0rCJi9vxCCSnanjNeICuFMWPgBqck1Y/a/K7QOBMv7QotcWrxat6ExM3WkMTB7Y
 9yZMACeOH3D0XdDdsq+kitlYi9L271cBlAuzpQRSs0N/zWCUy+2+2MBF0oXy+oD2Jwxq
 u6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357973; x=1785962773;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PCbmWZ0w0nVpnefOo1teG9dHXtfZHRXQHypQ7yNGJiM=;
 b=VI0MzD2BZ6orBCUiLjUh5ElbgwjbL/uKuaZVp0t5W0Rf5HcQX7rZTD3di/KRKoUtm3
 Z+G4Vc9B+JI/eKBE3m/0/j8swNsUt/f8ElIDF8KofPKClIuCBHwffmCpfrO63nUlWWZa
 jmjULkkcC9MH3NXkOkX+zmXkqQPyRA5lHAlQRqwOKw3P0ijXkGYBqj37mzrx6SRDzUf/
 toQc6/uxu2aqHqDfeN0bvsMXC102q1U+RmYj9heZS9l6EyL7qdnrO+MNL9TsjzO/ah8w
 S46P07zhe9CeSOFYJLBClFJ2CoNzqhYZ7D2P0/pYANUf7m+KJo6KhNUd2nXX1u/7kokX
 gAMA==
X-Gm-Message-State: AOJu0YwkoIZ1nl3PhTUmuIVDq9Q1inZz3w2fax5NBw8utGiN90WCqp69
 GZyXI1/1ihJMEMVcJW1HZA4ePBZP4G29+fAsFQmUugVLDGlsWS8t8jio
X-Gm-Gg: AR+sD10CA68BugzZ3rtA6DDGCz9Pp65Ko0FlrF4VaG0ISjTSfNSXlsy1fM0IgdO1wJT
 uRU53id/6zdVa2684KMx3i61BYnEJZQGxHOreAa8gJ53BOq7j9aLnwihd+TjsRnXdenWW7Cb9Dg
 /M9g0uqIjTs3mTilD0AbIQc4KmiPlWrAoAppSvEe4HaBPz40kRtOImdtbu7mKDOBQFFLz/0iunz
 wr6wEOaWgYkpRGUUudC0k4rPxpToHJTghDoSNXBl2xxVSMsHI7xpCiYBTM5NII/WIdtzSAM0HU1
 cTwgTvVQJRXEyKXgb0zPSqR6awCqQ/3tg/cz773r9Aih9ziHToO2cEEcDEZwiiGX38DU6qHUxn3
 x2Rqb/5cUiROeWC/JIcRY9RPeXWyCFtNWBWsMiBv0+N/KkxqYiY5xi6fDZQIftg7zojXHi+o6x7
 0819zXz9ajjuafrXX6GSOiIAG4EuKJuMF2AcPIOWsZlCTaZSHoKJ9bCvuZB6jE+sl8MIZdK64=
X-Received: by 2002:a17:903:2284:b0:2ce:ceef:6632 with SMTP id
 d9443c01a7336-2d0340a096amr4069815ad.26.1785357973220; 
 Wed, 29 Jul 2026 13:46:13 -0700 (PDT)
Received: from devone.local ([2600:8801:100:1910:66a:cb3f:f6a7:d5f0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b88e12sm13032389eec.11.2026.07.29.13.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:46:12 -0700 (PDT)
From: Randy Schifflin <randy.schifflin@gmail.com>
Date: Wed, 29 Jul 2026 13:45:06 -0700
Subject: [PATCH v2 2/2] Fixes TCG generation for sh4 `fipr` and `ftrv`
 instructions.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-2-2c1c0fe04672@gmail.com>
References: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-0-2c1c0fe04672@gmail.com>
In-Reply-To: <20260729-fixup-sh4-tcg-fpu-instructions-b4-v2-0-2c1c0fe04672@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-trivial@nongnu.org, 
 Randy Schifflin <randy.schifflin@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1785357969; l=398;
 i=randy.schifflin@gmail.com; s=id_rsa; h=from:subject:message-id;
 bh=eX88J2x128SVDs6GH7jLMgLqSu2FOli3NICLpONnwR8=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALXHj1ozDvr3TmWcPoueK1kIy
 Q3yQ7HL5bbiu8J+P0QBzcchmw5nwN0avQmreXhYuMhz40g0dhCJPnJqNHg1FBflQPz2cgY7Utm3
 9lQrK/CQqWsjRwXMinMR7LrmtMFp9+up7MzdXoxmTLgPsKJ/dQmx0rUHx++mUSl8zl7lHO50YVD
 hsw1RHrkrXlxnUjRi+jtjgErRHvoRwSZpKc44yR62wV8chkTMnHtrn8hgL0Hh+jhHteNn4JTQB/
 wme8MghhliXR5oh9xirpeLlS9S4TBY3Vdk6ccgvncSS4uF/y2ZAAV5sNiLZ97OFkBhIQ0bXhVx9
 w1LPMkho650Iu9da5/0koNheHS2KAVC2FdPTyaxvqeFAsAB8fCprfh4lpShdcVpyChdd2KXFS53
 s9MAUQmZjG0pQvS/dqGCCDWqo7cY3J3VTMXwVtdzYkgZt5eMajL7z8VljXQ08ZgAStdizC/rHNg
 wy+fIL+6kgxvL/NhJwoiAWhC4D+xQY7SXjJGTvwAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgC8bvn3/ATj2Gq3xAyi8Pb5EjhKEmh69JDhIg/w9wBNOx+DIa
 DG5yhFEtl8JX5q2u96PhKy39IvteyogtiB8wHEWLEkzywIGUUYNYh9RAzrxRnvCBSOtEe+/zEL/
 ngNJi30rFjx1nQbjDNDLAmlNbM6G6RYPYZ9hZfA5KuF3XZBu8Km3r1QQR7deLsLx+KLf+zuAgU0
 bV9gGNpCBSWVGkTE6+IFxMuIoloHGtBHDM17HfLUCuvc1tEjKDGQdw/eUHv0Nh1fB4MeIELdknJ
 M/3v98M7SiYu4Q6bmP8X+0n0fXQMIjrCqWdXso4UfJT7HpZiaHjgSdcBlS1talQPtaW9py8l90q
 NiHe4QGdT9lw0fYlC+TgR2GTPxIszJSMCQQmLmHt6qaBvcaKOvYLPrti5r0yi6V+V1GHNSKFy/J
 Dt8RVEc/VVPC9umXvYUF74rGlNQPWpmKiyar4F/suxlqVNsINrcxba8gaxjj9BbHmff9FDhefbO
 /8DnLPZ3dH/u6lQ==
X-Developer-Key: i=randy.schifflin@gmail.com; a=openssh;
 fpr=SHA256:7gww1tlDoVPb7symWGdTNhRWcHyTORA23OcjS8eyd8Y
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=randy.schifflin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Updates the current logic for these instructions to check the
FPSCR register appropriately (according to the sh4 cpu manual, `fipr`
and `ftrv` are only defined when the FPSCR register PR flag is 0).
Also fixes the mth/nth-vector operands by multiplying by 4 to convert
to the correct floating point register offset.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>

-- 
2.43.0


