Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8F4C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VLN-0003qB-AK; Wed, 09 Apr 2025 09:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLJ-0003pH-EP
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLG-0001OH-FS
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso47655045e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744204784; x=1744809584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXmh4Pz+JdKMkMoqi+bpTEVJj0ToleTDtvfkr+bT2oU=;
 b=zXm1MRXO1FdSGbBHjVkjn48Pw87aG7ZvY1wYcev3hrdWlSpSyOH5RSVVtbgSWja7HB
 Z1HmAtiTlKDBIzYTZZpOgshsYU+JrXjjgLBesCrMfqUypJ8Wi6VXAtvtKm2DBRzwGjiC
 lCACcq3fk0pIeIrqGtlz5Ye5ih7QxbeQEGmmOvDYHey4dhOKIkz+YCabOJVDi9iX8Uv7
 gQQB3Dw1b7dQpoKo0xTg4OGJ6nQ09Y5KvDidaFLxxieFZ5VY3VefGWtRo0hwV0jkKlVy
 brWQcx8jiWZviAdWhYGIAswxaalGWjk0IxKjVROxwrEKLK+iZGmPb30ncXPg2v+gJjAM
 SdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204784; x=1744809584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXmh4Pz+JdKMkMoqi+bpTEVJj0ToleTDtvfkr+bT2oU=;
 b=XWznjHc8ExehPBF4kXcYlfcPu7XtbrdHsQXx6dzePEAR4Qm3mNa33AceN3pOO0+qsD
 I79TwhHpLRCTefuodu0/uhCc208CKCOR1MB04j06TKCphNtowlkEhH7L20abOQhr8mCr
 EagwouRa0BNHyE5Chf3BblCFwTJWk6SgDGKF3S/uV8isJ3Z+giZGjfrAoVgATKZl7786
 Y6wzre95tIW0R+JJ2vEigHiOmqstKblIOWPBd5TgxpBrB8+inIR8I4m6faOE4szF0bvH
 fBRyx2sgsJH3L5oFfjssJRfsvQXpIqYQqpu3U49MjqK7Jes/7QqyIRiha7lTYytMIySV
 HJHQ==
X-Gm-Message-State: AOJu0YzMnL+9MgQugOZt7Y+V6IKfoI3VUkmM05h7/NqmVnv0yl+LbWgx
 8IECYpA1jDfcdplPPTMr9W5YVOvcwlmj0PSeDg6H7bcJtcjkAqW3/RSvFNmtEhA=
X-Gm-Gg: ASbGncvBdEDw/x70cHwCLeKMIFtpKVXz/ffVcmZFCOkKHXR4mPuukZr63ULQ+meOIoA
 GiJo5fPhOsoPMWypBCu8PcFIMQ2T7IMjGM/xmayxDcBtfj04+LDJZkKvFNVY0DtphIJ+liRVe1o
 7uyzlw9XLKQzYqx7lO5kIFz8NQxc+rLWUWuDeiaAhirAq4YzQjhN2ke/VaensES5doaoScZqSwJ
 2Qo397Fe0VNUy2P+vMMenZ6ezinc3H4pj+gvr5QDY1T8ZUHQtY9AnCSmzUN3A9hrCrZbWcVrkkr
 XvVJHq8xH6Cdyh++nHXaTSYVMpR2pcQ+3b8PfEV/lT0=
X-Google-Smtp-Source: AGHT+IHYpgKexWRdwsFyKGnraCSE8mga5rua+aPA1nHwnn17ot5chqURInbbVaP5X+nvu4/I5cz65g==
X-Received: by 2002:a05:6000:430c:b0:39c:1257:c96f with SMTP id
 ffacd0b85a97d-39d885652a9mr2349953f8f.59.1744204783833; 
 Wed, 09 Apr 2025 06:19:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d8938b5e7sm1659443f8f.55.2025.04.09.06.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 06:19:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84A0B5F8FE;
 Wed,  9 Apr 2025 14:19:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 1/3] tests/tcg: fix semihosting SYS_EXIT for aarch64 in boot.S
Date: Wed,  9 Apr 2025 14:19:40 +0100
Message-Id: <20250409131942.1706923-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250409131942.1706923-1-alex.bennee@linaro.org>
References: <20250409131942.1706923-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We don't expect to hit exceptions in our testing so currently all the
vectors report an un-expected exception and then attempt to exit.
However for aarch64 we should always use the extended information
block as we do in _exit. Rather than duplicate the code on the error
handler just branch to the _exit handler with a failing status code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250404115641.258048-1-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 4eb1b35b88..a5df9c173d 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -73,9 +73,8 @@ lower_a32_serror:
 	mov	x0, SYS_WRITE0
 	adr	x1, .error
 	semihosting_call
-	mov	x0, SYS_EXIT
-	mov	x1, 1
-	semihosting_call
+	mov	x0, 1 /* EXIT_FAILURE */
+	bl 	_exit
 	/* never returns */
 
 	.section .rodata
-- 
2.39.5


