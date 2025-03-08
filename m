Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F79C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr273-0003Iv-Kh; Sat, 08 Mar 2025 16:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr270-0003GO-5Q
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26y-0000vw-Ku
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so17137425e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470815; x=1742075615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twLgsdoYXw0iYp9SZBJQQb16zThCNIayzujKHpj3usY=;
 b=guiBvZtigzrJKJEfRsGXmSfkyS/g/8LrBr9aUhWdlz4pRpbp3F5FVFWPoLd2jpyZEM
 wX0Vct2qr9tXJxLBfDq1W3ne7yUuUOQDcDIxv2Kzpdr3tjSiA359sWm0wPVydqBzAgSX
 L+kj2/3VPLM6LN24zrxI8YiaORlLecrws/E8lskWTtzRD8M6r3j/WBRTcfUgUCGamZBP
 Fdej7qxcBOSgb2/qlq2wfcXucoQhy/cVc+nLdn0AWUUDN6vYe3SQ/mc2SZXMpd5bL9+E
 r4DJT6hxaxuv7azrbBS6HMuYCL5V79rEKr23RmMUEtBuU9lOJHGw6rbuI3xNmiVqEx3C
 XtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470815; x=1742075615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twLgsdoYXw0iYp9SZBJQQb16zThCNIayzujKHpj3usY=;
 b=ZM8kJp6ql2MlO/8HAxinpj03qZaFQzGfh4R/1KM6JbqIoZyKtngAjxOzrDGYzl0pFA
 FL59phg+6EMlfrQQECfUffSaTt0AtUOZWuZzycVfrTnmio1IBwmvn6KPKZ1FYqaQVUch
 abOZguCnOHfIC0yvFo4qRuYOVOx2kuocNi0erjkKbdepiEYvDrkolbfXfe7P4qghOHdy
 VinD8LADZiyHbmqgXyn/VNi7rO5VxglNRoUDMu76kilLStEVXcAJI8ca2psS7/LzZJ5X
 fq46In+bfOV/FFAj2zUneMZEBTP3JJpH1Xfes2faZKTLUsFsOTE8lUkwJOwxKVDq1RQA
 GNsw==
X-Gm-Message-State: AOJu0Yz+h9hTwIeXzrvAZO9VmB/bXsiyWPAaxw1BuQiEDq0aNjkUufy7
 lYlFsn9Mq7sSHrSQC/rKIHehCxkIG+ygMsFjThvxdt2z71FHyMrueZM9gS0FhAcJE7bSqwsHW87
 R
X-Gm-Gg: ASbGncvY+U5ZXiU/NULIzroA7s6/UAnqa6ABrfcWv3AqAJ3xnHftDofhyDDx9npgkCY
 Igc6JCe+UchINqE0ILg9Err2LS1z/FG2wxika/X3v8AOHzD6Kixjf+UI6TiWkto1stsrkL+s4sv
 lgXrMxQJBxxF8KPVXxwcE9TMatkyFQgSkNBXDLpv8j/OkeX2yMjCyvP9m49r6GduvFuRoEiqxOZ
 IWAtQxLAutpFB1fUarJbL4bt0GJC6MFvO+QikFtd4VVgdIEDdPntVumUGkZZoDfiGtn9MAYjonO
 FZOzClp5omfggGccB8nHRVT5fDYZa798QWc668bgrA/BSkc=
X-Google-Smtp-Source: AGHT+IFmEyHDFPYJXxoMSWSSFKMgLBM45GJeF7ra7IRdLDN35hQOrcwQPs52jzXoQUr8Q9OQELBI1w==
X-Received: by 2002:a05:6000:1f8f:b0:390:f6aa:4e80 with SMTP id
 ffacd0b85a97d-39132de2a58mr6030732f8f.53.1741470814894; 
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcfbsm9693452f8f.28.2025.03.08.13.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E8696604F0;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 14/31] tests/tcg: add message to _Static_assert in test-avx
Date: Sat,  8 Mar 2025 21:53:09 +0000
Message-Id: <20250308215326.2907828-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

In preparation for enabling clang and avoiding:

  error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]

let us just add the message to silence the warning.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-15-alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index 230e6d84b8..80fe363cfc 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -244,7 +244,7 @@ v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
                0x0000003afffffff0ull, 0x000000000000000eull};
 
 v4di gather_mem[0x20];
-_Static_assert(sizeof(gather_mem) == 1024);
+_Static_assert(sizeof(gather_mem) == 1024, "gather_mem not expected size");
 
 void init_f16reg(v4di *r)
 {
-- 
2.39.5


