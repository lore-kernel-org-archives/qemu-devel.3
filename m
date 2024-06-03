Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65185C27C50
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsc-0007B9-On; Mon, 03 Jun 2024 13:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsL-00070M-Vl
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsH-00009t-7g
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42121d27861so1167275e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437215; x=1718042015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KRfXE/oVtlnzDt4+VcBXOC8p+C9OfeddYY4ThUlh64=;
 b=BB6MK6n1YqKqv9uB5WscHGQ0SaLj/vATi5ZC24gilyxpSrDC6NiV/hN2WWZeqw+h0A
 F9Pw038Cw39oE+2NrXoNjJlRgCQFqkldjUlgyLhSyEy79D0kiAmhvnm0kRI2tpF7p9fh
 asUXLrqmJpLTfSKuSzMBw01lkzaqQzy/KtRH+jNERnLKCIJ0/AgFvyyVjOCFgUk4nkb0
 0fhqCUV3ZFLUwYgWe+Urd0MYK8P0KwSiDjwe/t2G5kF75CGyvsqR7Ep3IrH08TcIT/6k
 EtpBl93egESRnDTwNddw3blDNtfj7/pXHyhCW5rJ7fuKD0F+CKR6ishbkKOdM5oh+gcc
 Up9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437215; x=1718042015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KRfXE/oVtlnzDt4+VcBXOC8p+C9OfeddYY4ThUlh64=;
 b=nUfHdl5DjoJkWt140jAii7V6GTjMv+86Uiw8dkER3ZhKnzsX8xmvOBn02UYsqeA5W5
 Auqac9zKYr8J3TFcAadwGC3UYScm4MGo763/1fvVZlGmx8T/k25v1BRW1+KrPXaiovS/
 XhV1Svtn9cDfF9MSNVx5SPvWvHMwgG5knG3eGlHk56bkgduEQXEuGfhXh1e9P4ojeN65
 f7ZcceRxwMBGKmbM1jMvuRNgfNBO+QRvJb2cNDRE9MUpiD9mxNHl9RUuxpXtg7xDLnbd
 OuUJufqsfPq7IrPVb94cZV5FNbq1psOiGKl5Mgj7ulqk97s2vDYUX8vG/VbL/UuMm5CC
 m4gA==
X-Gm-Message-State: AOJu0YyWbM5OIOrHWi7pS2DQRxqv5qAtvoK8I14SbK8+kc1VOoWzhDej
 RmzzAUePWrXvMI0JN8g3j8kQnIYeKic9loDVovnAFurBOctA9fTW/zeQU12L7Mc=
X-Google-Smtp-Source: AGHT+IGyZdIQEfHdp9u5swINaBBzgo8dcyRSI6VfEevC4uMYiFPOA4JifExa5rRMj86gHWFySSotOg==
X-Received: by 2002:a05:600c:474a:b0:41b:285:8417 with SMTP id
 5b1f17b1804b1-4212e0be702mr69738275e9.40.1717437215050; 
 Mon, 03 Jun 2024 10:53:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b85c628sm125954845e9.25.2024.06.03.10.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 47C145FA01;
 Mon,  3 Jun 2024 18:53:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 08/12] .gitlab-ci.d/buildtest.yml: Use
 -fno-sanitize=function in the clang-system job
Date: Mon,  3 Jun 2024 18:53:24 +0100
Message-Id: <20240603175328.3823123-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The latest version of Clang (version 18 from Fedora 40) now reports
bad function pointer casts as undefined behavior. Unfortunately, we are
still doing this in quite a lot of places in the QEMU code and some of
them are not easy to fix. So for the time being, temporarily switch this
off in the failing clang-system job until all spots in the QEMU sources
have been tackled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240601070543.37786-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91c57efded..0eec570310 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -432,6 +432,7 @@ clang-system:
     IMAGE: fedora
     CONFIGURE_ARGS: --cc=clang --cxx=clang++
       --extra-cflags=-fsanitize=undefined --extra-cflags=-fno-sanitize-recover=undefined
+      --extra-cflags=-fno-sanitize=function
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 
-- 
2.39.2


