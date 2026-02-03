Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35683E8B37E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPOw-0006QY-C8; Tue, 03 Feb 2026 18:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOt-0006Mt-Dp
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOq-0006CN-6H
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee2715254so33879025e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159694; x=1770764494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lVf2Ne20e/kD4Ls0zcv2d2Eydg6wNhvuHPWCgbwKjk=;
 b=ZNU9M+UzzJpE3i0YLSxeEveu1DTHK2WvcHrmyBFz1jsVaI9e4Ygdy1T/NN25Pq5O+v
 mWK+QZuaMKd29EcWHb9WdewbscJski4AXZ/TBL8XyZdpVZ5sgH5r+icwy+6Dt+yaiPxq
 9jKpEtvvKwjlXOsbNCgF5FPSnIUyOgLFgQs75kaWcJ/aCccSOUSHvjWo7ha5P/2dl9Yy
 KeS0VPcxvtezj8z3qupNiBihB/w+j/4oilFGCvtBzwp8Hmty7tycGtu478MGBoJr+r6C
 ux/PNJB1V0ydPlU6Uz491ALsKqIt0xfhIh70EzhZxqSO7sUFA+Eq1kiUiuQvAisuTgWm
 NWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159694; x=1770764494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5lVf2Ne20e/kD4Ls0zcv2d2Eydg6wNhvuHPWCgbwKjk=;
 b=gOnkRhJ1+sv96udQKOWCcYUNHEQ9JzhjwlxRdsIjHnT8o5pyRMQt++1P9AjJYiid6X
 pgKQLAfVZdlPrtQYopUZ3HcH78SqgEOzK8Ox9KM0ryJUH7XZmhexo3gYvR0ZCkdArDu4
 WhWcCYTTfCjmUjV3S1XfjCXx0Qhip/4rT8INI/PW0kYUTweIutziji4EJ+lwE7KDyCsb
 ADuayH4PDm3K9VBw/MPJHEBCAjWQgRQqDYE8ewW/s3hEvXfipUBepv3/6p2u9nwHRptQ
 3+wEyRS6ZLXeB61iXIGbZpESy1RO5mxJpbyX+S3jM+N0mkuxQhiAV3uCkDvZI3XcmMU5
 sacg==
X-Gm-Message-State: AOJu0Yz2rUNph306ssfnq5dUFDCTAHtxxZzXt1pMHOI3bwHrYLjS/HSC
 +Q+nlUCSoPZT40Q5Sj4rlO5xysG0YldJGDVmU9EcUnjhdW36ngaeZnWdzLK0VPs701bJxZVRvyx
 lbCHvk6M=
X-Gm-Gg: AZuq6aI8J+j3QCzUxfvjIzVJBuacJ0klDMjeNIW17ntioi/WDtMbsWAswKsRaIfgq1i
 Us0/7TKQxnocxIkW5KRsCjDODWMsMaJCZQIXm0E/72dS3z8nJH7mk76OGnWKnQ3A4/hvGzOMa2P
 NCUNOVGB9v6UhMh8zaRDCUQOhDlhAcDR+81zjWebrrAc0P10gTYD8lxtqPycUfSXoUclduy3Rqr
 gYiWSTXEEI+q7Qv6wWE+4MMOhBx38sSNFLXodQYEMcZHMNRkrx6pFYulBECaQvhJcODvi5f4S2k
 w5K1jWUZMzn6/wbf3miXUlOTlDam8J9qtwmi7gziN9RCEMzME5w/jDXdsqAZmsySIFeNsxLtIVU
 9KqweRWId90DTE4genih9WVz8Ui2MBf4HvPdQ1E1Nkkfws8nsno5JtQptBvhKddJGdAh/BHnMqm
 LbtgzyzTO7ACXgUWASToURcDwPKzm3H+aKBZvzyHM312P5uc9nakiG8Ny8dPEy
X-Received: by 2002:a05:600c:a011:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-4830e93ea9bmr15551755e9.8.1770159691462; 
 Tue, 03 Feb 2026 15:01:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4831089f212sm1904875e9.15.2026.02.03.15.01.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 15:01:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v4 5/5] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
Date: Wed,  4 Feb 2026 00:00:54 +0100
Message-ID: <20260203230054.23667-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230054.23667-1-philmd@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

All SPARC-related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 configs/targets/sparc-linux-user.mak       | 1 +
 configs/targets/sparc-softmmu.mak          | 1 +
 configs/targets/sparc32plus-linux-user.mak | 1 +
 configs/targets/sparc64-linux-user.mak     | 1 +
 configs/targets/sparc64-softmmu.mak        | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index 4ff4b7287d2..d3f0716ca2d 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 57801faf1fc..272fd46f6db 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 7a16934fd17..3e6c72e793e 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 7c2ecb7be06..3bbd8495210 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 8ee6d057682..8a0290c2093 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


