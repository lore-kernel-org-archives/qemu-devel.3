Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E4BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTg-0000ZX-DR; Thu, 06 Mar 2025 10:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSd-00085i-JI
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:38 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSW-0006Gj-5F
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso5087065e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276104; x=1741880904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0uHoLbJKeoI2RLyZ0VsturTTj7TY2KrFP8jv6ZyXsKo=;
 b=Uv/IIi1L8UKegMrXxmlDmZSM/gZ7NR15KkyjWc95g9VpO/l+LVxeoJ6oEmMLIF14hl
 Im2Wiu4kOePyIneK0kaJ8+OctZSn6qFN9GQ6qxZpCEMg76VnppNoI4AmETocupbcIRvF
 OhrmIbibExFquRkHUHWyKu7MpBa2A2nH3S7TJv3mHBzU6pxKF6o7ErPdgXW3yc7Kt+yI
 lHjRmwyp/K8CCfBTe6JCw27mi2vd5rFZovuin2DqUYDHm+zU3HgAxSw8HfA+HGadOCmJ
 3tSvMU+zIkFwA7aYTQ4s/evpJri4IVITXaeCzuDhmJGXW5inTDhuWQo9KN2w7N2g1J0z
 RNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276104; x=1741880904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uHoLbJKeoI2RLyZ0VsturTTj7TY2KrFP8jv6ZyXsKo=;
 b=Q76nZevEsN1p+8dPhnzFXt4WbexPyqHpI9GnjiyYokG6lqtfzfrIrIOXJwSbKIg4E9
 kMzU/adYZqQHEMiWgPWrVVQmP5HUKi249ln0I5BLGcdJfnDhLtw+wM62gMyqtOmDEY/J
 aM6io3Wu2TtJf945/ARw4zWlZ0ZsM1BiF6dj965WywHXBW2sWtiqEBoqn/Ec4GkUU2lD
 I/AhdPCenMOv2i5qTUdIJqD47cLNIAQp3AcO/lXsVJqLvWkVGzqAThDgdOZA8C10ne8b
 SiKV5dLyZyExPyV8Ci61fg+MIfU0xd/8YJs9+ziGWTwaKGYcitWFB7/3qgJ6vK0H8mKG
 BbvQ==
X-Gm-Message-State: AOJu0YxInMKSC9PKIcGnHzeDi2I/QzjdJn7MbS8a3O5FxhSrnwugH5G7
 YKpOxkrY7EtELRTfZZLnbPXDWYkqJ/jUnz/imOKaY99ArhjqZqGhhfZYQOSSkiFk139P85PiYFw
 MEfE=
X-Gm-Gg: ASbGncsX6HtvwR6kisX5Fq26DvMDMITJRLsfiToRFMq/28zl48OpEAbO/jzc5mt+/Wf
 sPNHLeslq4zh5ivuTzD5Za1wRMn18qkPl9EWKft7vFzvYQYypPSzoOYBmJC6qunxveNtibreM32
 zk8qvTWD3QuLpO/cMhdqsN1QP26qkAIzwP2yQjViKP9vSrZsJHfAga7FpgDnkUjBzkkQNYQip65
 YALPGoSZEvIxW0LGCTC18LR8noqpOqer+xBN02g1HLiSlYlvat/LAwpDXflaIVKyz5cZtFpUV1s
 3NcJC9iZPn+kFhQj/qtPOM3jln8U2f0mBO05foZcbuhcUlf9dpvDkAZBOGlifucg9JIPGnoCzQ5
 dMFnR4bhc1Q7jYDvJuNQ=
X-Google-Smtp-Source: AGHT+IE62mBFs6VDo7VzM9Bt49/BJrCSPbAMZg9GQeXMwQgyH897kJlKcDCEqM8ZTt88MwsGS5ZWFA==
X-Received: by 2002:a05:600c:4f87:b0:439:685e:d4c8 with SMTP id
 5b1f17b1804b1-43bd29931b4mr66975095e9.15.1741276103731; 
 Thu, 06 Mar 2025 07:48:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd831719sm25094075e9.0.2025.03.06.07.48.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/54] accel/tcg: Restrict 'icount_align_option' global to TCG
Date: Thu,  6 Mar 2025 16:46:52 +0100
Message-ID: <20250306154737.70886-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Since commit 740b1759734 ("cpu-timers, icount: new modules")
we don't need to expose icount_align_option to all the
system code, we can restrict it to TCG. Since it is used as
a boolean, declare it as 'bool' type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-10-philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 include/system/cpus.h       | 2 --
 accel/tcg/icount-common.c   | 2 ++
 system/globals.c            | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index d3186721839..7ef620d9631 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -17,6 +17,8 @@ extern int64_t max_advance;
 
 extern bool one_insn_per_tb;
 
+extern bool icount_align_option;
+
 /*
  * Return true if CS is not running in parallel with other cpus, either
  * because there are no other cpus or we are within an exclusive context.
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3d8fd368f32..1cffeaaf5c4 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -38,8 +38,6 @@ void resume_all_vcpus(void);
 void pause_all_vcpus(void);
 void cpu_stop_current(void);
 
-extern int icount_align_option;
-
 /* Unblock cpu */
 void qemu_cpu_kick_self(void);
 
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index b178dccec45..402d3e3f4e8 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -48,6 +48,8 @@ static bool icount_sleep = true;
 /* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
 #define MAX_ICOUNT_SHIFT 10
 
+bool icount_align_option;
+
 /* Do not count executed instructions */
 ICountMode use_icount = ICOUNT_DISABLED;
 
diff --git a/system/globals.c b/system/globals.c
index 316623bd20a..9640c9511e9 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -58,7 +58,6 @@ unsigned int nb_prom_envs;
 const char *prom_envs[MAX_PROM_ENVS];
 uint8_t *boot_splash_filedata;
 int only_migratable; /* turn it off unless user states otherwise */
-int icount_align_option;
 
 /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
  * little-endian "wire format" described in the SMBIOS 2.6 specification.
-- 
2.47.1


