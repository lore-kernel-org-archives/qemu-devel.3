Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21704C021A0
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtV-0001vQ-84; Sat, 08 Feb 2025 15:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtP-0001th-Ss
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtO-00058S-3K
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:35 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f6d2642faso16292215ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048253; x=1739653053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLitLdlmGvTcmycuDS6Q71bKYSkfaIiONi8PyJuH2g8=;
 b=y7sE+bEMnGa45uncQBP0jC1O2YfFj7joR73i7gSWmYNo/NgP73SIO6Kmmznf4ysiyE
 sAkrTzYWsfgcnMSLAnxBx95l0Pig5oP+xg3rv+EwaEm7J49myanCkNsdGFw6NIVVQJkn
 tr/w833SB9zkiKIvxgkZ1wNZW2vwbL+4D7yRFOxq082aQckDNnb0QtWcrnKYU8njW1z7
 6vEYrcoL/+xyNBgulhu4yYXD12vKITm0rhATXid03Z9VhkdXomBDA2F+yVhk6r0Bb4Ks
 DQ76cB9EQFW9W092a3zBUT3D2ywcPDdD8mRHDMJTNaoYI/15nRCn6v7nqqFAW/Z7+qcC
 502g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048253; x=1739653053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLitLdlmGvTcmycuDS6Q71bKYSkfaIiONi8PyJuH2g8=;
 b=UqCCx93G30iHFUtdrq8qNdauZmuWbBZEyQ7cUZ/P/JBFH2Zkj0tn0ZWIGMRciPdE/6
 bkUT/AfO9MZ5C7FXZAkZV8S9jnZMNVI069bJyviLGxD5y+ETWcc2Ip6/54aYctzINQ/A
 yGerXlmJSJlDU7BmdjgGtULP18a7XzAJ/qDz6vpE+ihLPFlJ0nj+X/T1yFdbwkCrWZ5H
 L1/f/IkTo8w4GYPd+Mj0rDftVE62F99Szxd1rGqs/kwkYkbE4G+E3BK4cySayipRRTeJ
 NJRqH+KmR/UH3Q7iJhQ3FNiJT80TwzKn85D13y7L3gs3nr6NzWhc95VlsJ5BXIN6PYhW
 vGfg==
X-Gm-Message-State: AOJu0Yy/3fo/NSgx+J/ocHlU2uWokNbHAR/8mA6k6T7pr4mexVxYLNcw
 RfP+dDo6zeUjlT3lXDsUrau1aZifGU44JBFSFTEGccrlFxL2lszUbCnuGmtl+mFufmrelvxcwOr
 i
X-Gm-Gg: ASbGncsldHX9E+Q/U1SBOCnmXR4SiDQFW9b6Plmr5F04VDSLcgiMpcHjBR39JEJv0jy
 Fb34wRZRWKlQH5YvOhS9NrVzkS6R9XMCudru/BLIUXLBRulZmDGcHDn13L2DqvA1B2wPZv0FZoc
 Z9dOBxT6vM7xpsajg5xVExeh0oiStwCGW3U8YWfjw7sR1N0EkOIJHfqk9aRalrWLQrKFAS2uvGu
 crP+YX5uBvmB1RSJHZl3TbwKfJM0KjHJwmhKeROUYvm7z04tB9lQrh4pn10bPQOPHMERyZ5pIil
 4RPc+AQD1xdAxIyo+EWdYX7x3Jxbn5kzTbFMjimFaFx5QhA=
X-Google-Smtp-Source: AGHT+IG8EMSw1/ZEdMrPh5rCbaH5f97Utm7YW63kNGvIPDBonlah5kWbsL80pCJgjuVmT3uDOgLsFQ==
X-Received: by 2002:a17:903:1250:b0:216:4016:5aea with SMTP id
 d9443c01a7336-21f4e7059damr128566395ad.29.1739048252771; 
 Sat, 08 Feb 2025 12:57:32 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 9/9] meson: Deprecate 32-bit host support
Date: Sat,  8 Feb 2025 12:57:24 -0800
Message-ID: <20250208205725.568631-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

We deprecated i686 system mode support for qemu 8.0.  However, to
make real cleanups to TCG we need to deprecate all 32-bit hosts.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 7 +++++++
 meson.build               | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..7c61d0ba16 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,13 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+32-bit host operating systems (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+Keeping 32-bit host support alive is a substantial burden for the
+QEMU project.  Thus QEMU will in future drop the support for all
+32-bit host systems.
+
 System emulator CPUs
 --------------------
 
diff --git a/meson.build b/meson.build
index ec51827f40..387490d922 100644
--- a/meson.build
+++ b/meson.build
@@ -4841,14 +4841,12 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_arch == 'mips'
+elif host_long_bits < 64
   message()
   warning('DEPRECATED HOST CPU')
   message()
-  message('Support for CPU host architecture ' + cpu + ' is going to be')
-  message('dropped as soon as the QEMU project stops supporting Debian 12')
-  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
-  message('that QEMU will compile or work on this host CPU.')
+  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
+  message('to be dropped in a future QEMU release.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.43.0


