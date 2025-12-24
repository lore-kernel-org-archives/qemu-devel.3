Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C367DE776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRib-0000Fj-S6; Wed, 24 Dec 2025 11:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiX-0008Tu-L7
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:28:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiW-0003tc-2J
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:28:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so28515965e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593682; x=1767198482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UC3Yrm7h9DtMfXVQz3f10GYZ8/dRUZPiSUf8qPFazoU=;
 b=i+c5n79crW6BjtmSQG5QgWRsp5Ba+9XbFhLaAwpVAt8I2FPPwLsnrEYlVWphCfTXte
 UH8YQMSbQtd+ECeI8Kbw0iOxQtG7g9OEENJJ1GBvwsGDli9NmVwTLbMPPkUNMZikTuFM
 wcmi32Gmyrvh0FNXbwbU6t7UITSCefLyi8Yons2XRP514EQWvfnhPOn+LeRMBW2+zxgy
 IHNSmcnohTBuPubvj6P+nBX8MLA07ip7OApGljY1iqpHslYPGkA/5Ibs0huxJtCut+H/
 I35DuaPCwn2DKrHTFM9V0oXVzz9WiZtfb9s2lLnqADs88mj9l75rJdNDT4WNvZ+Y34m5
 m+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593682; x=1767198482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UC3Yrm7h9DtMfXVQz3f10GYZ8/dRUZPiSUf8qPFazoU=;
 b=DEpY7eLAPjPD+kcpFIef3liLRxeAOXXUjBnPN/hXEhLsvtxoJJKRZUqOwGyUYmpNfg
 fifz51t3341XxUpETmuY8LEDj0ZPeyOAqszJJzx4cb7AK2QdCuX9crf+RGclD0IsKvAG
 HsMVBTPReE2AD9hh05BLYUVp8sGIWO8ut+Wm8ISeTHLOkibumxWNxfUil4VwqC5vB6ua
 jkh37ZgtzBAD0DWackji5xENlZCwoJ8oI53umFutQebIp7lBfiClA0DRLZWMZFoMFwkY
 FRH8OoNaLtbJd8T4HcZfEEKSt2igXej2bS+LUwxsU/FKQXD9qjPSdHNYaDWqP7yEtr6G
 F7sQ==
X-Gm-Message-State: AOJu0YwH1W61heuZm/NHxp7woBOFNHvKuBonb3rHEqzDa2xGA5aOiv5X
 Uok6w/jib2KlBkE39af/Gq/wK1n+YkiGWT5v15ct6/qeXBoNKd+RZ/mFHUh5kwt9S0+4zVaMz6P
 SP6qFS44=
X-Gm-Gg: AY/fxX5WAy2GYrUBFkhTajKa+SlnjvaOVBmWxFJOlknSoX0Sx4zMr8IkwQe5F9XdATx
 YkAQxp14XaIszrM9y4qErBEiB7Rpl2TQINldJckc674Yo7kZERhVwLjDZuHv5DogB0cSbEgYnKk
 WOKhL6OFN8CpTCK4DyDazT2kmkX7MqRM4LtjhgizwqvPpapmax9E0hfPpuo2H7JfNp3Xzij0p7+
 s83hjnNzFSKTvZhv9HTDTo39oSFJT/DJMEFJzwVn0ZcyOlb6gpkyIHnLNI4pZnUJwn6VUqdwxB+
 B83zHNUteMsx3bFgtQeLXgerp0OLHgHcH1qlJOfyLAPbx65NJNL+DTUCXQOA4rbCDNTjXqGSKgy
 Ri4t3PBW5PKf77xvtu/dVv5K2aFDmZQhz6ySAKepe0sHHtztDc3CZ/0/JwKyzJgKgelYH0TkTSM
 g6Moztyw67lYpN6J8l3uMITfGrcsbb5prexMSoYgj8WOFl2Ln2srHfMIM=
X-Google-Smtp-Source: AGHT+IE+wbNJkINQSGVCULVimC39Zrsy+4A+dCtemnDW9V1HyQBXZqQaxqlMqnWwj9wFnRFvGcGuJA==
X-Received: by 2002:a05:600c:b99:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-47d195a6369mr189503315e9.36.1766593682208; 
 Wed, 24 Dec 2025 08:28:02 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2ebfsm34660739f8f.40.2025.12.24.08.28.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:28:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 9/9] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
Date: Wed, 24 Dec 2025 17:26:41 +0100
Message-ID: <20251224162642.90857-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
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

All SPARC-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


