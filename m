Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D860C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrvz-0003YY-66; Fri, 19 Jul 2024 14:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUrvy-0003Y0-9f
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:02:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUrvw-0001gH-Kb
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:02:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266f344091so14803505e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412134; x=1722016934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q3BFRcvZPpvowrLbpkNo3GnPVjILgIvCnujVvjQOW4Q=;
 b=WjP5vzlgY8KjaST3NAjnQPqLMi9jzUJx6OOoNn1N7zxcGIuQIAJiz8DDs2JsOA77nV
 VaDpfjCOuvqBCvgooC4xTV1GZPGLIKAs3ukGSd56Y9tLE+FjDK2K5vfqA6qqL0lCt/5x
 XLbZ8ntp8YcIPb5Y4kgQH97iAsWeBJHywAObs8HxrekB/HErnjeQl9pbRHM8Dh4fFVC6
 uWlSI7efTtdbUADjHjR5Vjm8USyDd/QkNDJGkiVc5oFE6wlCsVSbNAAbSvWT/HNTFYQT
 OzKot4RvoQhlIbQfdsCzLUUHGZpnyriLjE5wAlFc5FINrBXxSEWahgCENOtDviUsUtnP
 WAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412134; x=1722016934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3BFRcvZPpvowrLbpkNo3GnPVjILgIvCnujVvjQOW4Q=;
 b=ocfqn6Sx86TUZ8wVN3TU8NSikRr9n88txcjmZNcbeyP+nzT6PmGwhOlkq4CAP6WVHn
 mtrsr0aNiFkwkdazxl7BSwfeISCxOu5VI8d9Oot9fyhpZ7p9Z3mmpKl3rsSd3r73y4IA
 r6v16GZmEaVigd6fpxNDdAoSHlwut0HwzjG5f9OcNE6p7GB7XA0dxLrm+dgLD9YInDNL
 tvIvwI2zDPEXrhWPSjlOGuuK3OFWo4rursk14nA5KLOJWMcjyTbcCqA5ujEf4V0USk+c
 RhMFDdHVsEgsubFR3hbReRDGsNDY80gHLYmLcIiwpz2JrbPlQ/eQlhbXXTKQT1+MSHgi
 fJig==
X-Gm-Message-State: AOJu0Yx9FLC4WtdNcecrNFdfCeGzdTIF05fUT3ZrSpig/Nn/L5fVgbBu
 F4yoIM+iBYLxh5CFz5Zo+j+vCi8ABWt0tdULAh/HrtlzOT6upiEB/iI1BpfgWSdjC1m7SBSJVfE
 /
X-Google-Smtp-Source: AGHT+IGvUjtcLELSWbb8hLxKEOBP+BcAaIFpxlqeI4+l1NQiFYGtlycFKKiT3eR+fqkq2HjhePOFzw==
X-Received: by 2002:a05:6000:1841:b0:368:48b2:95f0 with SMTP id
 ffacd0b85a97d-36848b29f6bmr4967588f8f.13.1721412134326; 
 Fri, 19 Jul 2024 11:02:14 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d8f1cf7esm21827895e9.39.2024.07.19.11.02.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:02:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/avocado: Allow overwritting AVOCADO_SHOW env variable
Date: Fri, 19 Jul 2024 20:02:11 +0200
Message-ID: <20240719180211.48073-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The 'app' level logging is useful, but sometimes we want
more, for example QEMU leverages the 'console' logging.

Allow overwritting AVOCADO_SHOW from environment, i.e.:

  $ make check-avocado AVOCADO_SHOW='app,console'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d39d5dd6a4..6618bfed70 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -97,7 +97,7 @@ endif
 # Controls the output generated by Avocado when running tests.
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
-AVOCADO_SHOW=app
+AVOCADO_SHOW?=app
 ifndef AVOCADO_TAGS
 	AVOCADO_CMDLINE_TAGS=$(patsubst %-softmmu,-t arch:%, \
 						 $(filter %-softmmu,$(TARGETS)))
-- 
2.41.0


