Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87546C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1a-0001Pp-IM; Wed, 26 Feb 2025 09:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI12-00015M-0U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0y-0005iq-Qu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:59 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43948021a45so59956985e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578635; x=1741183435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BNemPe9wlDrqgAM6P13rVeo/N+AN387KhyfuJfKu9A=;
 b=n86RQzFIbECQbbsWpBFcyA5J3K7UWS5UvLgRC8pCrEQCKbjPTD3Ngdu+wkBlZBO2EZ
 fif9S0zcC6cN0Tni38FHbBkm81WK0DgBqsPshd3JgAxIcos6VUVJKq2bpPIAJjsczVlS
 SO0o3S/5YiBEuxi+VBeFWZ/eEsj+5TAOqf2u6zefMdbdEPDD3Rj3bXhHfnlPbiGfkYSV
 HOfB8iB2So7GU/rQ8px5pI5L6CGroYghWU73OISsVo6u5+2iSl1io9vnDxX+lAB2Ni6L
 WUPYphS3ox4oEnyo4RUSna4+dZxf8AgyC1CrO92EaWrtMqmFg+mEo7khFMpZh7UfFJrS
 tghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578635; x=1741183435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5BNemPe9wlDrqgAM6P13rVeo/N+AN387KhyfuJfKu9A=;
 b=eRSlD5YSpYOpwIiFnART+pP02l+ap+0hD5H6mnmgFEJfD3zPf/yF5lwXuaTcVicEYx
 msmGAUHNr+fusfVBS70DZieYza8Kf/6x8CDmuA/9FO2w8xb+Zi4/qn0Uq8IXjSyvSu7W
 HYz/gmhcgMhFids7onKo5j6y7cEMr2Wo5RANYMcE+Xdtj9ZTJyHmy9h2BJ/qf5iLp5oH
 J6HBchMvz3KcsrS4+PLAy7k9hzAGK9PSViwIbfczjATXzI3z3b8u+s6aA3L1ni/xqPgD
 3jTWIveyR0B5FJUCK9sqmDSKUG7esUHnYg16TjNAypBkkH8S99zO6quej8wl4Qd02q/y
 Bw5g==
X-Gm-Message-State: AOJu0YzYV9ivkpznA0QxGXjpqPZbfz/hlcoOEQ0YqUx8AuDR+0EZheXw
 YchVAseOD7J51A6mrS+AeHm3guO3Ns8i1T/MQcpDiWfGgwPmrYY+YHhqKcvwU8E=
X-Gm-Gg: ASbGncuSWEITmKgqmzJgYpb6AbArEhF/Q/c2vWUHw0YyKSisjq5GM1KNoGZtIYcjPXt
 4uvttZ25lSVoWarfRGTRCpw6Fb/P4w/V7mLjbfO+xlzsT+d5DpPDOUOI/jdXluCCoTKb3f7VlaF
 KQSTg1UKv4qJir1pOJq8yK9J4ls+D8vmX7cJyCCDZwlzlsvEYLXlVu7HWcIARAJZgI2lE7UaZAn
 uTdnGcDarmCsxlaEwtqJFmMINh31d1UzOgpvMTay5eNkaN4AoLyefebzOsusaME1JQ57OEGPBNy
 ER2k8t349fTd4geTB41QPZzX3QE/
X-Google-Smtp-Source: AGHT+IEpA9WUnuiSyFwlj6mIeSqMthiIy5xrUvdcSYXriEO4NOyos4Gl6R3UEVHo0fohPqm9cJq8cQ==
X-Received: by 2002:a05:600c:4f86:b0:439:967b:46fc with SMTP id
 5b1f17b1804b1-43ab8fd73f2mr29573115e9.8.1740578634856; 
 Wed, 26 Feb 2025 06:03:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5710c2sm22311775e9.32.2025.02.26.06.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4BC05604F0;
 Wed, 26 Feb 2025 14:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 14/25] tests/tcg: enable -fwrapv for test-i386-bmi
Date: Wed, 26 Feb 2025 14:03:32 +0000
Message-Id: <20250226140343.3907080-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

We allow things like:

  tests/tcg/i386/test-i386-bmi2.c:124:35: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
      assert(result == (mask & ~(-1 << 30)));

in the main code, so allow it for the test.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index bbe2c44b2a..f1df40411b 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -22,7 +22,7 @@ run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
 test-i386-pcmpistri: CFLAGS += -msse4.2
 run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
 
-test-i386-bmi2: CFLAGS=-O2
+test-i386-bmi2: CFLAGS=-O2 -fwrapv
 run-test-i386-bmi2: QEMU_OPTS += -cpu max
 
 test-i386-adcox: CFLAGS=-O2
-- 
2.39.5


