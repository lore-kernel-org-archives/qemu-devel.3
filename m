Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32449C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLl-0005ga-GS; Thu, 01 May 2025 02:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLQ-0005Jh-HJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLK-0007Rb-1R
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso562051b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080661; x=1746685461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBI5uPHzYMY6eh2c7dgtwBog8gNzmSQclyZLzeP9xXw=;
 b=vh1od/XowRKZDxgjKHsmNFbqKlInOsj17tgvMwlRwjYqSETy/WSb0m9B50yjwwxeK5
 fthoYINy225J2O4MRVCOiyZT09mjRb/c9vlp7h4f7i4XD7ONyO6N9YlDb2XCXtfUpvhR
 T65XGnQdY1KaecDPG8fm/idOQSRjNybVe9GzgSxPaWqiltJFcDQzMUk1w4PCTXoMgAlb
 /DtGKV5NiaIyZbIm7mclY0Iiu3BVzN9JbPFbfECkrVyEoN2mpmJW9zSij7hZUphrfbRm
 2qFLxEuqIqcoC5nIvHce6JCYjCH+kzOp5hdlbHGO0NuGghu7xFV5sAZa5B9y6QK9uLGH
 ELNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080661; x=1746685461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBI5uPHzYMY6eh2c7dgtwBog8gNzmSQclyZLzeP9xXw=;
 b=hzbII2dE3pmhtqayBr4oyHUFUUA2Fw2KSrc57e0XhwQ57AXJkhfI/L9Z8gs/hjTC6b
 7ky4CrQOs8rrKktvJD2RXmIIzg2DPFeF+DfPkgP0PQRP2UqGSdsjrwCStduK4vWi0yuF
 W6OL3ljfkQt3+AAl25A4qXtMzAnfRblTeYQgO32+4+Z5yLvAUiGetcDm61L1R/WFttLW
 aCRsPYjAFkIje9dMuvamVuuQGsh9Ehhv14M0h/vzUDURRx42dB3HXx1ql8e8fT+pILKM
 uw8JPB+LZmux4sF9WHj5SO0dX26/LFMFf4hJvosGKNoTYz8P9EP224BgTYfChFdx5CKo
 Q7qg==
X-Gm-Message-State: AOJu0YxE8Uv9ECyPhF8Ign/rlkeFYDmfT0MoCNIyPsZCmyYJhD4HoOaX
 l9QrRlre5FdLqqg7uV0R8n3LwowTX85A3zI2O+KZde7kVaUAJUMU/8fkffc+qpVoy0eNLgvYX7O
 6
X-Gm-Gg: ASbGncs8E38LkS0FlzLmiH5poDkMQy33PhAhhJU8bfhZyMZuChyN4V4+4Ht0hw4Iq/1
 DoQgVxQOX4vdzcW5arRcwDh5Sjt3KsDqCPCCfmvT2lm7bpcDi76aLicGj288D80k2qdtYm+vEIF
 gDx2oSP0xb9mZg4li23IFncIf+E27aoi9bgkRCblqxrD4qqNI4PV8QAOEVufLcWMvJ2kzIQKIep
 7h4KejidOT2SWARsvJU3xrHg24jUF5LEdBrjs7Ev7fn7lK5muRhyBV9anzmk9h6TEZV4JcJ1+kY
 QvzS+nYswpYN58W+B491mtiY0tDO2qCkizClJObM
X-Google-Smtp-Source: AGHT+IET5AJXzcKAYJBSnisETMHpG9TeThJDNZVtwu2V5zDEzGbE3MiHWS/rW9B33TSjVTYXS9+vxQ==
X-Received: by 2002:a05:6a00:2286:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-740491af0femr1922678b3a.6.1746080660829; 
 Wed, 30 Apr 2025 23:24:20 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 33/33] target/arm/kvm-stub: compile file once (system)
Date: Wed, 30 Apr 2025 23:23:44 -0700
Message-ID: <20250501062344.2526061-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 29a36fb3c5e..bb1c09676d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
@@ -32,6 +32,7 @@ arm_user_ss.add(files(
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.47.2


