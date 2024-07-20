Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7029CC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sV6Qx-0008Gv-Bk; Sat, 20 Jul 2024 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6Qv-0008Au-Rd
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:17 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sV6Qu-0006vY-62
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 05:31:17 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cb5243766dso1518458a91.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721467874; x=1722072674;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5yjuBamw9n461E4jaC/9ANa+4rItgiwUD6BgGhyaSGo=;
 b=FXE/MnpFIugeUtEmU+tFf0y2XxjCd0TxBo/kREaBCQBF+93rU2oeFBmYKtDh3Xv+Iw
 K1SNW37PmZzl4rPMnFasKSYkNzYN908s8vRTS9BbjU5v9zVIhyoIVWROHZu0MeNh3W5h
 EhkZ83T287C4jgidRxDwq66dh3iyDqXNGJ2VppYh53xHV+6zxZ1WY0gqv70aHn5p2hBh
 EJ11Lz/kjGlhd8PcvkAfNHGmYgy8XmOBP95fHxfSPh3TpDCeUvjn5tMvvqonbHJ9tH/t
 c7Cmc2su+kd6YdX7QV6HPnvJI/UINZnO1ZVkyV36DdWjZanCVF6vn3Ky4dQfl2Gd7W74
 lKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721467874; x=1722072674;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yjuBamw9n461E4jaC/9ANa+4rItgiwUD6BgGhyaSGo=;
 b=LEUlGmTCYlqdwqXfOTygbZPrkFtuOzC9Fo/wLYAAIifse5EF43LmkAK5eanS3w0t7C
 hOejtN19DPFhroxj7M+6MGcZcb5blDFUxUdfc4On4/UYACr1r9baZCCoq+Gny9FTClb4
 O/QDKbGQB7O/a4A0fpH+hTFYit+wi05Rkkz1G5BqjSnkQLUX2BZqUxP/ILK6/wYkponn
 rBBCR1Wj50nwqf/Jvyr8DdxoGUDLiO8Hk6XEjlyGTvQfsGmotcRgBRbhbTAzJZYKaCWq
 F6eFGfGfypEfrXS4UctF+WXD33wDJVGeqD5rQYELSVKRrup95EvWqMabojARBTeofn/h
 GjGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqp7kFccmZHscMr8VZytXGkMwMz9wCKJFgCZKZ5LdBs2Mxkh7Cjl8s1u17pBM73I9FuuFUG7oOz2P+b/+KdCSqwypJINk=
X-Gm-Message-State: AOJu0YzTr47SfZYNMZbr2VtrZ455oCR+HhQeEEq8E2Tz9cKHIp/tmBmD
 SKDTqljcUFrPYcVGccJJjccTRhuplkiB3PfQbMJhXwxOUvsKQQf45hH9grHfVA8HRYs1sMnuzVt
 Ky08=
X-Google-Smtp-Source: AGHT+IHR+NQTRhR3a2TfSAWIUHqlrVOnxn0GDTljibq5mmgHHmG24+/gEcCQ+grdVEK0g9Y/FvpQug==
X-Received: by 2002:a17:90b:518e:b0:2c9:8891:e128 with SMTP id
 98e67ed59e1d1-2cd1603776amr2182284a91.4.1721467874472; 
 Sat, 20 Jul 2024 02:31:14 -0700 (PDT)
Received: from localhost ([157.82.204.122])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2ccf808f08esm3099636a91.36.2024.07.20.02.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 02:31:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 20 Jul 2024 18:30:49 +0900
Subject: [PATCH v4 1/6] target/arm/kvm: Set PMU for host only when
 available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240720-pmu-v4-1-2a2b28f6b08f@daynix.com>
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
In-Reply-To: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

target/arm/kvm.c checked PMU availability but unconditionally set the
PMU feature flag for the host CPU model, which is confusing. Set the
feature flag only when available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/arm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 70f79eda33cd..b20a35052f41 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     if (kvm_arm_pmu_supported()) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
+        features |= 1ULL << ARM_FEATURE_PMU;
     }
 
     if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
@@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     features |= 1ULL << ARM_FEATURE_V8;
     features |= 1ULL << ARM_FEATURE_NEON;
     features |= 1ULL << ARM_FEATURE_AARCH64;
-    features |= 1ULL << ARM_FEATURE_PMU;
     features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
 
     ahcf->features = features;

-- 
2.45.2


