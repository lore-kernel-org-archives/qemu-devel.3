Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A84C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTA-0002Pu-2Z; Fri, 20 Jun 2025 09:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbT5-0002PV-0u
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbT3-0004XH-Gw
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so11651025e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424860; x=1751029660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XksfEnABhqse0vfJxYZJ+Lf0uyahV9aipIl1Sny7z0o=;
 b=UBwtG0MudX4paiA7gOqGytVjb/JBmLANjQuB1aKXFyqhMJFF7GYAvtkxI4VsYosuIU
 eW1219lN4RME1JE/9lbiOnFmJ5lPIBcKtvJ3ISTEYLuqz776gdbGzjC2Mhu93UT3TBxi
 3sEmdeBXbNDT/4xrOZ4isfWIusul6IGI74XnkWgv0Z354xutGYP1+40gE7i3nqqjbcKH
 zsz8JEzYUG91A6zdR1qV9dXjRwo2QKgRCh93lYUsiIxWD05TF84em0ezhGdUkIiBMVNY
 m2X2mX0qSpchbTEnyeL4emsEAJYAybzOYnScDoyUs01AyHm+eYPyPyjKC0JP5AJORDVf
 SK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424860; x=1751029660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XksfEnABhqse0vfJxYZJ+Lf0uyahV9aipIl1Sny7z0o=;
 b=pYCS4+Yd1o8Rc3Jcn4fzLwxHsCwFYAa8LTGFI5lfeecuqFEqJpgYs8BhRQQpVj8XUz
 oXuBedszppZvQnFJq/uWdNyAxm87JynqpklSN4yn3mPkPfdQmmhgATjlWx2k4m0EyUjM
 wzyM31cSjnuJEi55rmECL8u/H9MyTI++P8lon3yHE1/n6wj55V2JBpz7vEAiRhvAFEhi
 fX2pOmxhsME6Q/ZkL/Y//SWT1OwTZDfLXLMq16JBTbeMkHoC+6e0PXEsIiejO9Xw7eVE
 mtBzb9GOW7QphtBcJzUkGwd+EMhReQnalrCsLSSD4doIq8MJsUhwa5ndzvLnxp3jgnU+
 ZPfQ==
X-Gm-Message-State: AOJu0Yzk4yQfduAFsvmpnuHQGZX2qgRmCIMtSva/GETHOO60CBoQH7Fo
 L67VHNT0zi8KljKTGAm1quxHUCOQGB1Y7Cp9mBmi3a22Xj3H2qxWMxRuc+i7/gzWDZYDuSx3Ykn
 AMistKhA=
X-Gm-Gg: ASbGncusJbl/KemDfGvd87HZlM+T3IPklt1lh2iA7ECbe6pltjszu9MPKqVkPbedyuO
 D+WVUKXIYNQySXxFqmiAch+2/BSuGk2osJggJ7Zxuj1DltxhXNyQzDlO7ujpfxU9dL55R9oIl/m
 rW4cJfRtrjTe7fDvbvlL7C/ne+NHVI1QOnxSzWlAiCKrC65fzKTVYq2maRwO7mfwdjViNzo7Wpj
 Y4IN5XpPLQ+3rSlWpolMXdfQypnCcX6WP2N2DhDebUL0pZBRgyAoKF7tnfLpXZnAzluLAagt9df
 wuhvnaoa+euuNs2UOYKX/KbBZM1MBKxPtK5G8yVztQGY+o41JcStBQ8VmIq9i5NPOWJBZD+6Dx5
 9slvsG/hk5Npr6EQF0qBFSzLpOi0FW0krRZan
X-Google-Smtp-Source: AGHT+IE/7BsLb9TONAHrydupa8DFXSIV1OrSggLSDyPpvWjke04D0dS/jXyuRBj9Ay/VLjM8ny9caw==
X-Received: by 2002:a05:600c:c103:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-45368787924mr6185275e9.19.1750424859628; 
 Fri, 20 Jun 2025 06:07:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8edbsm58978705e9.24.2025.06.20.06.07.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:39 -0700 (PDT)
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
Subject: [PATCH v2 05/26] target/arm/hvf: Directly re-lock BQL after
 hv_vcpu_run()
Date: Fri, 20 Jun 2025 15:06:48 +0200
Message-ID: <20250620130709.31073-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Keep bql_unlock() / bql_lock() close.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c1ed8b510db..ef76dcd28de 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1914,7 +1914,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
-    assert_hvf_ok(hv_vcpu_run(cpu->accel->fd));
+    r = hv_vcpu_run(cpu->accel->fd);
+    bql_lock();
+    assert_hvf_ok(r);
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
@@ -1922,7 +1924,6 @@ int hvf_vcpu_exec(CPUState *cpu)
     uint32_t ec = syn_get_ec(syndrome);
 
     ret = 0;
-    bql_lock();
     switch (exit_reason) {
     case HV_EXIT_REASON_EXCEPTION:
         /* This is the main one, handle below. */
-- 
2.49.0


