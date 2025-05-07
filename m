Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925B8C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPt-000076-2B; Wed, 07 May 2025 19:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPg-0008Gq-QG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPe-0002TI-Vz
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:42:56 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so603497a91.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661373; x=1747266173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=gpa/51Y/gUuaX2w3TS30N5fxX99odMZXAiYAvnPfxTWzQWbIEkqPUzc1YDrRdcyq4h
 PVmCD/CKtz25hT1y6KRZlrz5FyVi/pBaIvLsW8SiGkQFTwS5XuJPxjjt2YzWx+Idz4s3
 98z2FHElIfxTnh1VEpzEYuHG4Pz7Z96nKrPcyVVNAyiPqcINpBUW5qYbYXn08AGOUi91
 QqkBn7w5Q7sOxmwCZ0Ksk1r35AmShLDVj+y+l6fdv9PA9FuYDvvNQpQq2RFoTcZ8WluS
 pplf9j/UMjrOrinb2rl3sFzed6MYf20sGU1kLhwiZFOA+7z5m9Ok9ChpmrW/3ppoucjJ
 KnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661373; x=1747266173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mduWzGcqrbCCMCYuVdtTD2ZBid0+LWN3eUl0cLQ5HO8=;
 b=A1g3PfXgN46Nc4YLWIFq8RWLp6PI5sMsWhu4Q0uocY2LVntjG7I1E269HKrvtTmBc3
 cm1aeFMNSC1ORVA8WLnSynIF4Fntru1b+XkmTTi5YfhjZDmPrU+Nq0K9ZQpFuZpaZ6pm
 OlZkEgyhC4qsrdSwrSzhI9bXMi4RwUXXyuf9ljmcI7mKt0IeBJc3p4kuepVgf9xGD2sa
 mIsJ92NBzAl/ejw2oYP5TJ8p57PJQcCgIXBnUZHQweS2S/IbJAK2qYUvxzChve6dQOQc
 OA5fBsN+X8awp0pJhErTAK7Kj7uh+Uu8SoS249e10LyQ1rvoB8aP0mbCv/hKL6P5HJXX
 cGtA==
X-Gm-Message-State: AOJu0YyqXHQpQLwlIqPIQwblmPvs4i48E1rFpJ1Qne10jPT0WJ2PiPGK
 65r2lJybGB1/TeColkqzpXFZbS3lrmw7zCPqdMIed6+qCLHjTsWMPo6CyQfscmqQehCcA0hNLKY
 Gpl8VmA==
X-Gm-Gg: ASbGnctn+eKzzyHtaLuQnv+Sg8M0veMEUGkVl5D4rzxPrAi1ofLy4Ew9acSwCE3oWVQ
 T72ZO3MljF9uQz0zpKukApuEtvQV3ezFDGYG5INl363LDBVOETXxu/4tdvWmOwvZ/7zmTzrIdRo
 /MF4xTOZDB07qj3zB3riEzduBsz0C9FLNpJXzbtOWohS1lMz+rwP0k5uDnteDl2wtzxcjOXmY/f
 oGLhZ25q+/DKYuODn7/x3okETpEMMSDGF0sDuCaq9+k9k0aqTZmzkjKCzZEewlrGCIYc1Ot/4DQ
 XjaJGkHk2lOeIfumVIu0HPMX1njfHXAAD+oco1yR
X-Google-Smtp-Source: AGHT+IGT9jj0uwCiSn5aHiR6pkWAiqIqY3mUNfD2ufhi6mS0ZBXJtvhfq5oYsu0oWVVtjh2cwW1W1A==
X-Received: by 2002:a17:90b:38c6:b0:2fe:b174:31fe with SMTP id
 98e67ed59e1d1-30aac18622dmr7695290a91.2.1746661372934; 
 Wed, 07 May 2025 16:42:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:42:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 11/49] target/arm/cpu: compile file twice (user,
 system) only
Date: Wed,  7 May 2025 16:42:02 -0700
Message-ID: <20250507234241.957746-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


