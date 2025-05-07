Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD32C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQ3-0000af-WD; Wed, 07 May 2025 19:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPt-0000B2-MZ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPq-0002Xt-4m
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:09 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e70a9c6bdso7571365ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661384; x=1747266184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=kUTqWuh9N5nGtiRye1efdHsZqW3tpxjiWjBO0FhbilvYjxHdaQF1ypixYQ7seBdoCG
 ExMPNWUMGjMU0jrdJ1/lAtxIQi0zriTt9digG1aem2yv3LXoCiLBxXAhAXteiVxHKQMU
 aYLmqLR7mcvEflSpZTTED24nWed287J6SvTatagUKiUCPnGIC71mo4psmJtPwDyMIdZ2
 go6lrbxZi6UFHgIMg1wFPjozTLPO4dPV9CuWiW1Ghs4mybERXsdyGmY7wb68hpwaP6AA
 6J+0ly0knvKkyroaEon6/OMxr05mJ6sfPjL7X/CidP6mXQbXEs81q5zrtS0XfOHye8P1
 hXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661384; x=1747266184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DYtSZEbP1atLGb677pRK4UuiMz1CYlbqC5aWBJkLTc=;
 b=hyLfkDEz7sClb8cmlEhqTIlotpNyhfu/Cv++Ujx7aCxTk8Dh/d72R4tD4Q8DCNXhUS
 Y9QjDnAA9okjbumHpdAOEseUCFAi/iIAVtR+3I4CtqEJm0L2rS4nvG8vtz0oZU88lsGy
 azw2Ykb+iCdbHV8VqdNcHNAPD/BnsJDOjpdGCBXIpBFLWpbmpHeKljFcL+ughltd35rB
 BqoUXb/KesPi8Ibh8fCXNTs2mIEYI0s01AH5KLNt4t/mECvV9/u3porkzUj8NVF+TjuO
 IlGQ8N4qsS+MUrngZ+2M/XBWKnBA/sQE9yxvVzXL72FccVfZ0EUUx4DzdoIgTVDLGlpa
 JbHA==
X-Gm-Message-State: AOJu0YxuP2nElaVzNDxK/+fufk31OVvafuS14lGTuwlYbfa272DsJ6Zh
 AX04CjVJ9RTrs56S1bec4rBpZsF8VjtZ20aNtQtdd8T7EdCY0bd+34M5CeSifxZFS4g+ePrS3u1
 pHxJiWg==
X-Gm-Gg: ASbGnct9X9XmWqYFjK25fVyjCmvQpNjCqeYiOC07z8kyC5bpBENBrta34GzX/6ga54j
 DOXT9CDOxVrj3Iq4fjWz4jDyufT+LYAmFU9OnfigSohnOWintsh2NclAyKB2x23AcUYNXUIIUIQ
 diTeqLPVz80qFYPHPlR1yCxpzasLRw7WwrMwfbohlOPKwnz4eztuIvZyqL4x+h4qndiI6B5p9fN
 LOMa+iBEbWAmZauszmzL5ZOLYgRBrdLBNKL8Bj2qDDIPySJwINJDwMqI5GY2x96LRXromtjn/Em
 crPVpeZVJSEFB92tF1sJqSwsrybgo5Tqr+rGmcGw
X-Google-Smtp-Source: AGHT+IHBsVE+hlS2uD6FYqTOaq37pTfP8GERyb8nhVUO8aPu33fEdCr6kj7WpBfV+u7FbuN+nl8ukA==
X-Received: by 2002:a17:902:e88e:b0:21f:dbb:20a6 with SMTP id
 d9443c01a7336-22e5eccc4e5mr70654935ad.33.1746661384268; 
 Wed, 07 May 2025 16:43:04 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 24/49] target/arm/helper: compile file twice (user, system)
Date: Wed,  7 May 2025 16:42:15 -0700
Message-ID: <20250507234241.957746-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 48a6bf59353..c8c80c3f969 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'helper.c',
   'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 ))
 arm_user_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -39,6 +39,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'debug_helper.c',
+  'helper.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


