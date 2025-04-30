Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77985C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8u1-0002N3-4R; Wed, 30 Apr 2025 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8ts-0002Hr-Gg
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:04 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tp-0002hG-Kt
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:04 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso8052194a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025140; x=1746629940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=A/dzlhys+itIts4Ds3wlgHsHfdEicCCa9TU6OK+gxtEJXU7npZq57+gyNjO95cnsNu
 JwTUgcJYkz/uOAFiJRKqyU2ylhJnYhmttgtWF4B8Zx73eIVLS5hXagxEQum5QY52CByR
 /ntT0CJV8GsK3xEd1XNwhtC9Ax6EqSrQkq6TS/VRQH9V498YwlxlGjdlcy3GHEBU5TmK
 bX6WQ37mX/zkst+mxRmxGF65L6l5MCLF2mQyVgrMuc4N/UMMmvf3iYVxNZLYs1yzKqen
 2bnZIU5pq4FDdDwT2VpICs1u4yGir4uyIjVygL7O/1awDBJetccVYi22J5r4gcfjA7lF
 Y/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025140; x=1746629940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k54PyA3qe+UbX4AzHMockqDzIGWdHV1GUXIbKPo2M9I=;
 b=jBTxtPOV0tz5KF7Jl5FMRCh6A5U2mePt7W/Swb7EJvglvhlLs4M3/vo6IPSjyv9dTu
 k2IFv+kralgIOqJ1RV7m5D5E3K6s9XRy5+WamUyfGE9+07hRJbwCD+4fgreWdTynIlCV
 HtJdPIiI6e7nWcCgaA2cFbR07GaLqueMlSViHsMaSkVzPEJgk5czr6IfqbV4ykNJZnU8
 YnB1BAXdXSEC3Mnq14inPpabyHIOfjMkH0tsd12AaXxKlMXBZtRYhc455eEhjdz5X6BW
 PGT3osLmqqvUSuzBTG5DdDkTVv0Yv8pBNjgEbXIXkTk4H1AiP2ubkkD4KPmr1hHGJVBL
 8meA==
X-Gm-Message-State: AOJu0YyiF+CqoyZzXzERYwMMl08xl6yoLF5MAYxdDcN52jwMFrxL1WYw
 kJhNP2rEmbDvNzMjo0Pn1QaSkYFTx24uZLq84g5GvCMHeTprx1WNEzEMFE98Of6o9ITZk3litKO
 O
X-Gm-Gg: ASbGncuEvhHHKyO7tFnO5vEFn9JUoxQ3Kz+zekeuQ0ufeSJWac4UwCc+GjUTV0/gh/Q
 qyR37t59rmRlRm2GN9JVVJ3SDL9jkRzEZ/BP43YSd5GhTXchNLzCKXjvSz1hHyrqTdxyfKh4QY5
 jpjuZi2aRDzKJ4buKyFGJQt8sHV4yeFTcPxDsYb9WJRch1vlmaZqnpIbdO1QIPpxoS+aFTVIZpd
 n3Exve+khmuJqD50kAFiSFDQfSpbi3OlMPqA345JUmodeVuT9/DSQ9ndmFTn7rf1uKCDNupFXZk
 y9p4hwQkq5bsljb4yfVoxrlakQyi0bxAyvKjFijM
X-Google-Smtp-Source: AGHT+IGmjmmRsSFucpW6qri+F9auxx0+hHGSx2UjPDyii+qX2/kTJTo22ZL7wgay9LB50sdG7A4YsA==
X-Received: by 2002:a17:90b:2644:b0:2ff:52b8:2767 with SMTP id
 98e67ed59e1d1-30a33300e3bmr4611242a91.19.1746025140211; 
 Wed, 30 Apr 2025 07:59:00 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/12] target/arm/cpu: compile file twice (user,
 system) only
Date: Wed, 30 Apr 2025 07:58:36 -0700
Message-ID: <20250430145838.1790471-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c39ddc4427b..89e305eb56a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,6 +1,6 @@
 arm_ss = ss.source_set()
+arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
@@ -20,6 +20,7 @@ arm_ss.add(when: 'TARGET_AARCH64',
 )
 
 arm_system_ss = ss.source_set()
+arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
@@ -30,6 +31,9 @@ arm_system_ss.add(files(
 ))
 
 arm_user_ss = ss.source_set()
+arm_user_ss.add(files('cpu.c'))
+
+arm_common_system_ss.add(files('cpu.c'), capstone)
 
 subdir('hvf')
 
@@ -42,3 +46,5 @@ endif
 target_arch += {'arm': arm_ss}
 target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
+target_common_arch += {'arm': arm_common_ss}
+target_common_system_arch += {'arm': arm_common_system_ss}
-- 
2.47.2


