Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2656CEA7949
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 21:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnkoP-0004Xj-PH; Wed, 04 Feb 2026 16:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnkoO-0004XC-AF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:53:24 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnkoM-0000PQ-Bw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 16:53:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so1497055e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770242000; x=1770846800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sknYBCP64s9QVQTe+Fne62Ll56HU4lCheY3HQiBTZHo=;
 b=VJ/RHMeT/XgiWQR31U/FuI5nNjx7If2jyKsSPDaW6gOQa/eYlyLWIu+LPvc5hlDgfs
 2eFjm7Ti9P8ujQ3ocvN0d2xCynJcffOFAG/z5kAAZW8oGTN0dfdVDRusDrrKECnS1S9U
 MuZaSW63vLE3PrI44qicMGXCgtV9SSrDQ2uRzHKGk1I0UGoaynqaYGdjtzBUd6agthwK
 RrzDvdOFuX4/k0/oKuPZBvmpAq1hlXUfVEm8KihUhcykr9mCzCXWF7PjTiC0jhT/dZXR
 exr9UYz6IdNavFu8h3IwY/oon046fDFehaNBac7DTlwkpQ9noFo6j/VfInwYWA+kJRdF
 rejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770242000; x=1770846800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sknYBCP64s9QVQTe+Fne62Ll56HU4lCheY3HQiBTZHo=;
 b=beMErfQfAWFth/M4njc60/AJGZ+lgP80cwnxRPdDCsyVofw7hHEbKohtLA0toHmAwq
 Zm70umF3M/TK1S/tT2rnZItZukSqzry6cRc8yojNvZ4DK5ZDjctQNLYLUJ86zuM3M0w3
 vpvf3fUMEqF38qvo5AaZ2DHh0eZ3g1X9gK1/ncQw6VeyJQCO15rqhWur0n8ERmvmrBHn
 qXXdW5zoBW9eSWxeCbB2KTSAD99CLsHHdznyvHdjgNqsRO7oVhaPVisyGKEUErnufnlt
 EImt5jqDOq/kL1ssJUtbqsNxfnzJ+lkPB1fXKFgJ7JCcqUNEd+pimI7xXl1KFbr1ckOX
 A2Mg==
X-Gm-Message-State: AOJu0Yyt0U+syYjwjTjlP/XjJeioEwog/qd5ulJoFN88L9Z8nKF8dRG8
 CnxfMIwH637fA7MfnPC/BdHS9OS91gctkB72zszu8auHtVmeL3Ct75TQV9aA6lTEog72GOofd0B
 +RPl6iOQ=
X-Gm-Gg: AZuq6aI/d1QONmR04rURxaDkB30Hp8t4eGR9U2FwtfUlAO8R7wS89DnEGHUlLii1VKt
 nOqM/o8wanTD/t/GDFN3aWgw8wQZ/C+eLkQfBH3/+H3CHxn5WPhfJc+29iQ+b2tyi+dg/864Dc2
 O6FlfmGolMjqhz70Vb/HOMzJIuXXrbPEzcYvZx2o52MzVfvDaxQ/tEBgNRMgSWFObrzP9kWjiOp
 xGB3loS3JQDX72WMhySnQ/ih+s7WUCPWa4IIr324bLHT2Y7ttp4geKgxNO6OOexvtb2LogUCSZn
 OJBE+4s43CqiuIxb9MiCcCnFL7bPy6tblGN8est2ZLUiktREJsbnuXT7Y57B72mdx+B+73qU/Ut
 4Hq9iqX8ra3Rr7t3mClKD4iuCZQMCIQEoTfqnkdGqZqvjvc6niD0ioSusohgV19rhvmrmoCEuYB
 W0fFWbW1beYF1mIsY71s1nzcsqvejEO4oOVAlSvsfABh0b9dfLiK/uqfAhiHKiuSf2wlf/6cQ=
X-Received: by 2002:a05:600c:1d99:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-4830e932742mr67162865e9.15.1770242000394; 
 Wed, 04 Feb 2026 13:53:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec42833sm49904755e9.1.2026.02.04.13.53.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Feb 2026 13:53:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] configs/targets: Restrict legacy ldst_phys() API on
 32-bit SPARC target
Date: Wed,  4 Feb 2026 22:53:04 +0100
Message-ID: <20260204215304.52757-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204215304.52757-1-philmd@linaro.org>
References: <20260204215304.52757-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Since we removed the last legacy uses of the legacy ldst_phys()
API, set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
hide the legacy API to the qemu-system-sparc binary, avoiding
further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 272fd46f6db..c4c38946d54 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,4 +1,5 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


