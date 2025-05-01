Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93C7C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLr-0005tL-5x; Thu, 01 May 2025 02:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLQ-0005Ji-Ic
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLJ-0007R7-5h
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso721690b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080660; x=1746685460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyqibr5WTwLzvCspC/7bIausnrARYT0xJa7lj0PHF3Y=;
 b=duwHQq62cz3JcHmfi9ssy6jt5eLc+WsR96rBcwTFmM216D59WvoHMh1cOL9/jvSoot
 TaiZfTmKiuxoNk9D/QYKG4poa05GfdW79+cBktpz+vsLc3EgW3MsyewPNiLSTURQfBAx
 RB1toEGgf0jWBjo4U25GdXceCeRr0oN22Mukv54n+hw1uSEM+YQ4hhDEE/psujyyHaTG
 L+Br/2AhtuRRQ3HOYOMFI8Pve7rugMTy7IMOUwHYYaCp+Uh7XD1mwf4AMTmA4wO/VQLV
 gmsaZukx1qMd0YoYydqatVI3VmUBib5EbS9hSWLB6d8teZxPKwdiHAYCBrehxPlM9CUo
 8NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080660; x=1746685460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kyqibr5WTwLzvCspC/7bIausnrARYT0xJa7lj0PHF3Y=;
 b=ivxF7TmBQuvAPi6NA6uTHXfrhAgZx7BIiO8pQsSNP1BBOwtWtXSF/3+r6AesKcXSwX
 PiI1+zNjKLSkmzCWNe5Vx1CoqFMCbIIqkqQfAdPGVujnDKw8n7A6FmgSqJDzKG+RKP6o
 4dA5zDp72mD5jmz8yBmc0nAu+4rd2GcZYwH0t4QuZh4CY7KNlk3vFcAAspAE+11clz1p
 50B4DzXO4U8Yx+cEn7Pyb74cAYNGrLeN+eoJcEvoai1TRyvz4cia/Prm7y4gAGU00qw+
 HTQT4KSwyoYj1ps7QHX95eCVS1t175o6GKLc5JUwE4RyeTfBjNMbm8om5yN2r5Vr8Tud
 7ADg==
X-Gm-Message-State: AOJu0YyY+MqiDcsk2lZVYH2IXgOPV9NRw2oM6+v9fwzr8eVvhR98DdFp
 8zDlEKYc5ztZ93I2Crx3hOTVwjoBOER3GGHA8c01EZxPbh4JrSo2wSUs2Vam1B9xJ2K/UeMtR4F
 K
X-Gm-Gg: ASbGncsW8BrkbwzacRap1wrPKcea8vUIxsU6/2yo1WvFhRfI/I0merfZhePsyAhx3mi
 8zGPydm/6ZlTudGNyRZoKaKamYTi0bWJoW1f1So6Pg3EK30ZHHaDc9QdG+dTO4ZrF++Hy3f6Upa
 74jvptE3+isUQIIsWh1tSweXxjinrqUK32CEU19OkdlOvyA0t8yyewuSFDEVnYIdw39cHC0+rSR
 sXSaeS2X+KjJJxEgE4+ffTOS27fwFBf8Rq/x3ZykHz4aSYq+AyswrsLAOSZavS443GyQ6B/qI39
 c406+Jq83+TyUlZXtHdT7mZtw/9UFNtj2YO1YrjJ
X-Google-Smtp-Source: AGHT+IGOIfzA8NxqRXdsP35Dd5N84asOZwmvhx3Jb02bYWpAaIstZgl+JozJSaaWgqMUtX5FhbNeUA==
X-Received: by 2002:a05:6a21:a4ca:b0:1fe:9537:84a0 with SMTP id
 adf61e73a8af0-20bd6d3c490mr1900241637.15.1746080659993; 
 Wed, 30 Apr 2025 23:24:19 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 32/33] target/arm/meson: accelerator files are not needed
 in user mode
Date: Wed, 30 Apr 2025 23:23:43 -0700
Message-ID: <20250501062344.2526061-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.47.2


