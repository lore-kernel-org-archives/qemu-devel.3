Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DAEC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZv-0008NT-BQ; Mon, 12 May 2025 14:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX8-0002ct-2c
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX4-0000B9-R0
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:45 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so4185202a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073141; x=1747677941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=wloxbsQz2ns3esnqjVAZ/e1Zzy8eHqigAJkMIM3kxpxnXWQeEfeWFncrgW1HqoRe5c
 /i1AkpCorgaT2Tte18D0Uj3GuaK5FSEC5xqUWsVP0RhnkNSxZmp/yzwTS+yghYlGtiV1
 ISioMsEcVF5iSBPFZHpYN5plEEeuXXXVezWQG6ZmoN/Kja5VfX/Ascea1msyBKS4vvXN
 lZ9fV6ETGclp4Is+a9iHlF9VdM/tFRxYaaLAq7o79XPRQU6gwtJNHRelSaHXkIvtOBHv
 4wRMGG6z1VL1dCtv4HiSUlh9qRyQe/nVcS2I2gCogiRHVwM+cK4ic5tENBiy6MuOfC3H
 fjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073141; x=1747677941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=V3PA34JwT7Iq4JUQXwmadPbghUuZzA7GYWIhZJq1w/akntcj84NdqQHvxg5AiFtSO5
 2/BtoiBGsqXKgwxmS9Y0pwDEfmBp/b1AcjLH92WXSHbPfpWC/6vn8WMzJYdJATCqZrFf
 BN943EER9uiyNDAdT0NFI+V/HWJWm/IiOO9FaglW4tLtU+HmmSIGSxY3/HsFJHkfign7
 Kpv0OK0DPxrhPRA4Cd06F+2jEKMk40E5AymsSq9lMddpM/aemtdRqJWRJryI42osjE9k
 ahPzMzGJdbTTeg6kiAtvSGdK1sOksvEzE+VMBMQ6CYTaTV/cuvBOuBnNjuu+L2s5EP7L
 6YvQ==
X-Gm-Message-State: AOJu0Yyi5ZNSfMSShcM0b5I2+cFPzbX+xl6Pq4MJiqis2k+pnwfW3KnQ
 VJa2Wa3GV7iJnN+w+ivPk42zZ4rW2EkOUjQpXEC+ooRENhWmHvZTxdcJsJEAJwnfjAP8QKW7+t6
 S
X-Gm-Gg: ASbGncsFk5bEqcKaUUA5BYXR5buyUOXN3Q+TqNq6BoebG3aYb29w3u3gQ/WT0QrMCKn
 WvYS7/Fv9lgdPNTSNjp/94vh7rdCOJSk6j+k5F0B6eN1lgOLNlFut3vFdhTVHQx5NRfMeykB445
 i32Qo/N1kWN1uMwYWTgmxVjFPygU0dlTwJZ421FzMQsT2j+6eXHcAGr5EHnLT6tDMgnCR8ILkK5
 VKrYFxDKcdC5t1WwViIyTAbkwob2u5Ys0Mte8E6+gYdYfmjXTyPywvlqTEN7/bvmUi86dAxoDVc
 27ejyeizHWliNiAUbrQSIEgXLHMhzxBsQxwrImlrOkoemj4j6Ys=
X-Google-Smtp-Source: AGHT+IEB4HGFgjrJqND6GkVuqk5sFWv3djL5NlKtJ/9FxV4Ne5ZgKlSvrPTD4P6BXHrMQGl/vG9WjA==
X-Received: by 2002:a17:902:dacd:b0:22e:566f:bca7 with SMTP id
 d9443c01a7336-22fc8b5192fmr194608985ad.17.1747073141166; 
 Mon, 12 May 2025 11:05:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 33/48] target/arm/kvm-stub: compile file once (system)
Date: Mon, 12 May 2025 11:04:47 -0700
Message-ID: <20250512180502.2395029-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


