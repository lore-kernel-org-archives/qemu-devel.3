Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9281DD49797
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIP7B-0005pl-EG; Tue, 03 Dec 2024 04:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP79-0005oy-ML
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:39 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIP77-0002iY-3y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:22:39 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d0bd12374cso2494964a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217755; x=1733822555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLnillY0LwsA1bGIi96aGqNPMbJhHjhH+14EVXV96qM=;
 b=BUFd7peRHkHPYt2kSwzpNFdFK0XR/pcaoCQJDxZLDQZEG0rikY7aWkKwGjZY5TuMsj
 jniqcUlGzNaw/mnG79PiC1kaenfa5Oc6GxfxSAWox+7zrqDQ4NKbdgwKz5oINwgyt9bo
 Vn1cNz5ie7sf+uLQheZMjnaQvCPcTbKYnx9lY84/DEzpXBHRc3pOkEkzEmtUSpclaSrP
 9OtZJ9XKmQ0ZghPhXFI2HdXAC76/o4CBfkvi6Aolvu6H+6hVXqnphroXkjzALJGbLRJB
 CkkqKbdL+eGhCmYigaZT7VvvwR/0y9ihBPPPPvtQzFWV1m2dFJZ5Ex0EK1ZQensWTLJN
 oPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217755; x=1733822555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLnillY0LwsA1bGIi96aGqNPMbJhHjhH+14EVXV96qM=;
 b=lfdUJD3ahDACPPcR3TdJP3C82ohPubHI1G6UuAEfXuucqiuoSVhxpS+gUu7p9MtxX8
 XAY7yqmHD9p5Fv3T/qClPVz0ibGyAIuPMISPV/aI9Ce73oLd/6pcf1nlixNsxXBedp3c
 VSx8HGpWetY6BNCc9py6pGPG1Ee8qqjkPieGQZC0+Z1HBjPCO0NPWxU4MEl0iif1FBPe
 YRJ9Ad7bLnUBD+OICYs2IfYX7goFxO/M5cUptVmAkKnNeDI6fEnYGpKotIlpP1sf2vKO
 8XHeY0SInQngIoKjIyhYnnuv6ZHzIdLWWPFloKO2a9RZrbIQbNjpFYeuN5H7Lm0ArNJ6
 2FYQ==
X-Gm-Message-State: AOJu0YwnTQMAzZlgg5sJA6ImRWvla6UbP0hur9vnU+Cc1VmFlR+NPswZ
 /kuZIXIsSczfcgUoENGR67AY82SH6mTPymuiNVE0Wp83f3SJai5+CdjvWY5s2ZiCBAmDJ0HaZNX
 Ra6I=
X-Gm-Gg: ASbGnct3neuxADZ+ACS0yF+TY72UD8LcybkpRKFV2FtUNiLqiz+4Py2KpvFgLGUfcR4
 GWSc+R5fSvM3AVoWeCdcVHNyjKHQ4OsmlLmQbHQYBIye55/YezQW4tOP7czUV18Cus191K6OnMv
 1xfza7spWCs84cswoF26k0wnFAYc8VeMGmENpGFoW7BxiJfb+HyGI09Z8Op8+x2GeBBq5FpDYsc
 fRVHug7V2gak+wBD5PoMtbVEOozSlgsEYrLAXAgFe4QxjPrnR9WNEvpJsVoJJEaUcTgQ0ZH
X-Google-Smtp-Source: AGHT+IF5ZHDt63zdyXLW6Zs/Jp904vDaPlOUCO3dMRciku/OnWILf9UyYpg15w7m7vgh9JrGFnoyKA==
X-Received: by 2002:a05:6402:34d5:b0:5d0:e9b7:170c with SMTP id
 4fb4d7f45d1cf-5d10cb5c39fmr1604224a12.18.1733217755400; 
 Tue, 03 Dec 2024 01:22:35 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d0bfa327dcsm4180475a12.83.2024.12.03.01.22.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:22:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/7] qemu-options: Remove mentions of legacy '-machine foo,
 accel=bar'
Date: Tue,  3 Dec 2024 10:21:53 +0100
Message-ID: <20241203092153.60590-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203092153.60590-1-philmd@linaro.org>
References: <20241203092153.60590-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 6f6e1698a68 ("vl: configure accelerators from -accel
options") we prefer the '-accel bar' command line option.

The new form started to be documented in commit 8d4e9146b35 ("tcg:
add options for enabling MTTCG"); it is safe to remove the mentions
of the legacy option.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-options.hx | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index dacc9790a4b..11f0aab1470 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -27,8 +27,6 @@ ERST
 DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
-    "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hvf, nvmm, whpx or tcg (default: tcg)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
@@ -59,13 +57,6 @@ SRST
 
     Supported machine properties are:
 
-    ``accel=accels1[:accels2[:...]]``
-        This is used to enable an accelerator. Depending on the target
-        architecture, kvm, xen, hvf, nvmm, whpx or tcg can be available.
-        By default, tcg is used. If there is more than one accelerator
-        specified, the next one is used if the previous one fails to
-        initialize.
-
     ``vmport=on|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
         to select the value based on accel and i8042. For accel=xen or
-- 
2.45.2


