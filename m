Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EEDC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbT2-0002Nr-3a; Fri, 20 Jun 2025 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSq-0002L2-V1
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSn-0004VB-Fe
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so11768155e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424843; x=1751029643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33tTruwtHJUDsLE1NQEO6k6TPJwHdavbHWnexaTt8VY=;
 b=Qq25uDyIvkdPZJUmKwOzZ4cVYHJ9sqFuTfjEWthgqShIORKjuINriqj1xTU+sxWCv8
 ytjzNHjMaedvcSv8/kDoVTMLoycYpxPFtah3TD6OHcjUX4qBlVbdJeGNCYqEAqbjhDtr
 O2guymq1ZPQFCLsA8iPnOZfAEpzbotTO4dvJztzJ5NjwewhXrKlyx4uhiEgo19dKaOIW
 iBR74/TDfOfJA94KCAsYYGizMa91roObMq+rY6SobaHZ9z/s/jQuvLya30xcM4WDEE+Z
 3JdJb+KeCDSgLY8XnceJv11J8n3zyJdKfjqjSOG6DWgr4SCri395U4HAV/M+VTQGXGDC
 2nEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424843; x=1751029643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33tTruwtHJUDsLE1NQEO6k6TPJwHdavbHWnexaTt8VY=;
 b=XDi3wW5Mq2WBszZfU7nv9nN6f67Uyg5gF5CzimjjehdXzbmN+zAlmRAsDgX/twtC68
 A2Y1CToc/Xo9NPfPwxYzUbPB0r09ahEDFKY/ThDxTFJVPWzhXSEP77rYxVfpq0XgK4xX
 CPpFHAN2oZNXcoRMXEg+RfuYyxzhrjiDp5el9zUFe8rjCyBOQieqg+pj5S27tPSRVxMD
 xyuq+OeWqu4tThZ6jFFARuOvUOPIRSiC5UoMjUdDh7YnHsEOrKeqaxBMG8+tR2k6nRLS
 pszQv4Ljh9HwcOAzyFu9mfv0WfMxPCob/VuEwDIuJGmIXFW46exOS+PNz9NLu+i9VnGf
 jkLw==
X-Gm-Message-State: AOJu0YxoTudbL4k9uHJp99UCMbYCj8tjAv0Jp0QoOlbdkHCdjQEVNqFg
 mXnlTtFE5GkAlqgJriaxYE2Bhkxs/kh6l3lZjiR+CIuY7zEDixNBmGOi4DXGyQCbQUC2GPk8xfw
 cyHouZ+w=
X-Gm-Gg: ASbGncvcGts3KRTeeD9wVOhzmnQDjlNwDNHKxYCGqcnyg8JuUgkF6cDBBaxOCWkVxTn
 mSFrVYe4HtugtwweXXjyyPFFvqwkI3jIbuEkrPT0bW27d4H9QhKuwVZ454gTptKHkJwR9Khxh0e
 2ICkxg4wIkSOyp26etCkEFcUUxajS7NqkPkf7G30DdZQrKeE5iQhBocBL86hMlXK5Xj6Vz5X8+O
 fCnyr3e/WI2s3TzQAP+oieyVRUGKn5o7YzSaHbKdBl6akEnPkpv8bCCrxomu+SVQdYHCmTDSUUx
 5Y6SycK3q0A3jTiYKkGIekAJ315mCQuUHRUHP7FuFQeRdVmeS/YfCuyfXAU4mEIGTONyDLcu6+v
 uuiG2Xj76tnV5c+1EHxXBuV1W4+bho+sFeXS/
X-Google-Smtp-Source: AGHT+IEPb6wrdygh9iEg1xDu0Enz1glDmMWW79h8+hZ9AnnXvHvnm2dPPn2ChqyV+PmW9BY7cS4i1g==
X-Received: by 2002:a05:600c:35c3:b0:450:d568:909b with SMTP id
 5b1f17b1804b1-453653ba6a3mr28180435e9.14.1750424843244; 
 Fri, 20 Jun 2025 06:07:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e983c97sm60000735e9.9.2025.06.20.06.07.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 02/26] target/arm: Reduce arm_cpu_post_init() declaration
 scope
Date: Fri, 20 Jun 2025 15:06:45 +0200
Message-ID: <20250620130709.31073-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

arm_cpu_post_init() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 2 --
 target/arm/cpu.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e2324..c31f69912b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1150,8 +1150,6 @@ void arm_gt_sel2vtimer_cb(void *opaque);
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
-void arm_cpu_post_init(Object *obj);
-
 #define ARM_AFF0_SHIFT 0
 #define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
 #define ARM_AFF1_SHIFT 8
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241eda..eb0639de719 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1713,7 +1713,7 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
     }
 }
 
-void arm_cpu_post_init(Object *obj)
+static void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-- 
2.49.0


