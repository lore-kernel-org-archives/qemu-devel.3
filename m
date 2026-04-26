Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE81FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpR-0007NF-Jn; Sun, 26 Apr 2026 09:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznv-0005s3-Mt
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznp-0001Qy-JI
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b24fdac394so90576135ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211140; x=1777815940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITXVWTswHK0ITcm+gabq4ujW8XFmcTy1jBekq3ZfSNY=;
 b=vHZTGL+digeFM3tEYqXhI9LY/6eqyVwsM59CKQRQoONwMQ7AP0VUQqdZxTXgEPDPY1
 ME9bDy63Xxx94FKss2hTcxasiZV0scYRE9I5FDKdoMiCbJBzHO6rDDFrcbz3zCM++V9M
 wpWVMjUMnBEbZjFrv8IqXQ9hO+zobQIIJ1vWRCagpkOsuwIhrWOCZd3bIRifWux0+6Jq
 xE9fPYjJxuJ50gtCVkDLmcdfGqIgOSfLco7ex1nuDSrmFtduoeRVjzIwxJqVjUqD9rAZ
 h4NBVObU1LuYDoUpiWboCNew1AvH5ytaKJalXaqe2XOqUObPeNIEDVpVp3W4GWKveH9Z
 D1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211140; x=1777815940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ITXVWTswHK0ITcm+gabq4ujW8XFmcTy1jBekq3ZfSNY=;
 b=R7pi1rfu6buAYIxHceNVi8XPV+nswE6Fh9EppUAx4NCcUHJHDnRzYC4bt/0ujQ9n2B
 3zBDyNz8EeyKyx0qKofRwcSWaMwvps8+7m+zYoGC4o9cZ9whZ3zjSTMB0JAJ25+7dlZX
 W+DGDhGBf1QhwQpui45LM3r9MBT0Wbrqyqt+pD52vlq/xksbXQL8fbPI9vYhorZ9QflW
 jljXeFE7PzDelyHnfQJ7LCtYPfMYG626KgVm2JIMPDd7UNLgFsFHR0sPEfDx1AjfgqoN
 etLSJIauhsLFZ7R7mqvwLePkZ5KoQo1NPc0AP5LoHSRsrjvELIskctSLMbQ18f+Heg30
 J0VA==
X-Gm-Message-State: AOJu0YwnydBN+Gz0DlruBMJEIHH9WCmqaJJLTgT51ycfSU/LgoiTVBIY
 E1ujAIOSImsj5RwzWHSzVXEAMcdqb8gNeL8EIQMEsTWERgmOPUS9GUBLwjzS84I/H2e4m9E//Rd
 qr9KImes=
X-Gm-Gg: AeBDieumPwg19MeBY+HZqa6j0zjD3dQWXtHfWK0vDa0qp5mROeMeuNhvtyQh9+wkV8S
 HMLXGxLsCDdGDOCveKcC27MS5b2tlybwrlxiCXc8qaRl+JXScCgjEZfzdZ9jUdgkBEXSSwZDUvn
 xypzE2biJfERa2SmHPzyrxziAjMiCI1sp18eQYAGvJR2gxzik+ecRmgxXoZMzD9sOmLeRPpCv//
 mGv8JgT2SkJSPAfnE/dED9u1uFKXhNNwP8sAVAsGR1MD8XgUOU80xhWhmP4oMYK/QyUFTo1VB9f
 4gs1LpaTvHq4hvd6UVmKvt4IdSbl11shfAULGofZaEw8bmqt5u/W7hoznbFD0NMesXZfOu0oBKR
 3VCFYS3VPmfh85FaRqPugQiqRQW7i07C+6fVPTV6Me6WDLSsljAQpo96vtWSG2Q5txwphD40HwJ
 N0JyeSb/MWb5qA+4ltU5GIBkyTndwCTf8WT9tiX2TQ
X-Received: by 2002:a17:903:3c24:b0:2b7:a3bf:b2a0 with SMTP id
 d9443c01a7336-2b7a3bfb415mr161832115ad.5.1777211140195; 
 Sun, 26 Apr 2026 06:45:40 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 55/84] fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
Date: Sun, 26 Apr 2026 23:39:32 +1000
Message-ID: <20260426134002.865628-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This is almost always used with a constant FloatFmt,
so inlining pulls the constants into the shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 302612fe42..63697ab3db 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -633,7 +633,8 @@ static const FloatFmt floatx80_params[3] = {
 };
 
 /* Unpack a float to parts, but do not canonicalize.  */
-static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
+static inline QEMU_ALWAYS_INLINE
+FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
-- 
2.43.0


