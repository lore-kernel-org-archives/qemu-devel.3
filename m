Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF21E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRXS-00034K-PF; Wed, 24 Dec 2025 11:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRX6-0002jX-9o
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:16:21 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRX4-0001dj-HF
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:16:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3218376f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592973; x=1767197773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6gwBvmvKoTiZ5BGD5jUCL61MgQtrvFZ8I5LHCNGerU=;
 b=FEZT1swAaLSUWI6eYquSnP9i8U25mt1NeRcSw1VamDKQmRsstQBCi1H17fxd/DiER7
 18CVqL3SumK7RFXziI1mQZG/GL3Ldgi1+VA8C5rtNB6Nc+CoRhbM+3Kw9UJcF6hCtWTE
 P59q6O9iwGpQztkEMXEwyPKobCwMASICgdzrAnAe7oRTppAchpJSsf92HEI/ZEgVfmKl
 Xx5VPZtTKh2u5nNSOEC11KNHXIBOSyHvzOZjXMRcXEsZ8Z6C5XK9Lw4u1YA9LaogeXqB
 dB86x2cAyZUvegxqG2A9zALrUiReV4rSwyM5A5dHK8JHrkZQLyR8PwrWvpaizdsDqain
 R++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592973; x=1767197773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q6gwBvmvKoTiZ5BGD5jUCL61MgQtrvFZ8I5LHCNGerU=;
 b=abbdgt7vuX+Zbep8mFmb4g9jcY7QqON1W/yg306QMRioKck9yC5nxuJ1NryK/DYPOA
 md62G20Y9tQpe0aO3ouBBUVTl3kfIrLj5Wz8MyOCaHgA4ahHFDWTFRXakNrqKHc89MFN
 +zX9jeWVZ8oQyNMk5wxIii768p60ddgCvGJO16h0qeOtby/+F3hLvWoiDVLyFnivi1Zh
 hIbnNUumDgrNm3Ec3ahKaVr5BF9A1xekoZKhLkWhqXTSa9gtku1quoHTI7enCL7V8nFF
 KddX6kGbHbwcgZTa9eCjcUQkmKlxSWDU0e2MLEbfo4FhgFV8P2hCsuaZ84kCm3ZYRwCo
 LehA==
X-Gm-Message-State: AOJu0YxmhPDS1FkBEFot5s9m6UyWNLJ/xOc4U2RdUMoWczW0KbPlFCU8
 2/ThcKRakZSZqiVf8MkJmUtIoYaMfPy1Pgopr31bhWrcISzu4PFzkjyFB/Q8cSidtXy8cB0VcBz
 PHVTlIEQ=
X-Gm-Gg: AY/fxX5ApSjgFzTHqbvbojSnS84WW8tFPGlp/syPmTtFb0eBtF4+1d0zsVhxh4i8boQ
 n2KhHNZKKdWHAkW0nia6vtmTZuX+4LuITE+l6zyxqujyRH2McMFJBFqXshoE0aYCH0jVLOJsg9r
 jDyGxOGHpZs7vUG1P9Vy/H3f6GY5FbbaMopJPMYWlpHdFeZtbVPWUNZQo+LRgYvhWjmx3NZrVzj
 HdzRbeKEiZL8zBCjFemTbWNlyyohCRPHr1EryIFwPXzoTCJeXEq5We66j92tIcA4pPVY9wsLRqF
 jaBW7w9AGLHi8vwqrvoXq5jDAVBn8Kq7w7771hQgdQ1bG2ST/Otwzy9+cZr0Gpzp8N1RJ9Nsecr
 Hzrq+hgYGVZWLY4pi8vkrNbzg8sabiMEGD8cgCAxbHTekT3Ow27miNJPsZWux5aD4K45m3bgbit
 FZIvpYLoGmwtnOAWNl5N0vh5RDOf1h0eA4zaYIvEHZVUnzwpzAO778tSNzYO94VWk+1g==
X-Google-Smtp-Source: AGHT+IEYtK6N8mDzsq26QOi+N4o8wJTbTZz2+TxQH94SyRbYQy2Rs4jck/WT4ZKuJcSRmoAdyUIxpQ==
X-Received: by 2002:a05:6000:2204:b0:431:a0:7dea with SMTP id
 ffacd0b85a97d-4324e4fcdd7mr17834399f8f.40.1766592972632; 
 Wed, 24 Dec 2025 08:16:12 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa477bsm35024487f8f.36.2025.12.24.08.16.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:16:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] configs/targets: Forbid LoongArch to use legacy native
 endianness APIs
Date: Wed, 24 Dec 2025 17:14:56 +0100
Message-ID: <20251224161456.89707-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

All LoongArch-related binaries are buildable without a single
use of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/loongarch64-linux-user.mak | 1 +
 configs/targets/loongarch64-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 249a26a798c..4ea12794705 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,64
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index fc44c54233d..38c0f68ddbc 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


