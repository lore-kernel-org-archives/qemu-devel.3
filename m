Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C83C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoUQ-0001gA-1r; Wed, 07 May 2025 19:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTZ-0000Wf-LW
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTX-00038L-Kt
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:46:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e4d235811so6476715ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661614; x=1747266414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsZT/scaGxab+Vo7Y7hWrcYUC7iBy9GgtXflG2/7Eik=;
 b=ElAB1ULkFfk+Y6scvy+lMhqMr+gMYfrN0UOB0GjxrXqaooGnsKu2VdolEYaLVlq283
 RdzaubjTkD4YKW/JRF7CmQ8D4MbPzgYozAfQvxiRsn9IjEd/N/nVARghpTcC3w3jfyHm
 NVY+IqXfqAAfTSmbVyxFFZpeqS4GDHw5gsumHU70CnjmBJYboUifYJLnm4v5R1uhehCD
 VffUHfKSncSmLG1C4s+pLXoduC3pmX7VprbsLeOijUlZIstiR+xJwhTYjOnKRNPUOhxs
 s8Tk4fNbwdCyVwli4nNvOtDGUrF+un8Pn/tGIhlzrjqt5aGayVbNQjXcXK8LKtnphxXq
 XVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661614; x=1747266414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsZT/scaGxab+Vo7Y7hWrcYUC7iBy9GgtXflG2/7Eik=;
 b=FDGYP7K5bTLQb7z73XZF8lxf1keFkainlaLITXKJKcibU2gTPKsfS2xJxCMpzQC6Ut
 5UBBniymfWUC9Pr5kmptlk+1Vhsv8l+9s/h3xZ3iNZqoA4YouxqOVQEBCZzPiqYgI58d
 +emofd4WOdSiMsWI4wUHS+ZhyYa/zIpLHAMAehmdCKnQiqnJi5Hs+Cdw5gFPjOlj/MpZ
 p7jOHmRALMAlLXn3GvlnSVqtVHSXYLOO8ZtHr2cdCiw82KJzuwPrB8e81fKAvSE0Cs6V
 Fxqpv/B+rwfzt+SM/9qRHCtV2sbzK4qFhoO4YnWQPqKY5gTQPmRrKUeAwOgpzXt0Bqfv
 b4WQ==
X-Gm-Message-State: AOJu0Yxgy5T/rCYOWzdPbmwVHydj+nYDacZ5jPO2eFjIZmB38gqJiX6u
 7lYSHKM8sELCAXvhVbu6oH9/J+fvBB45JkEXsr/BmjP+YeRE/p7U6/8cLJhf66jGKOXqctLbNWh
 tryh+ZA==
X-Gm-Gg: ASbGncuENsAEQPAqaM/pNdM+EuIh/8oQeN8VBBt+CHRCGuX3snz+3L90OxPYeGc2BEP
 0Qqo2BZSHIkq3O3E3OEqzNeHMZIom+aG+xqzxOzD1kjtfwSH4i1HyuIU0rf+U4K/fB9pQzfknTH
 Xx+Sl2oUQvlApN26JjvBejTnJ0/mLtzPYr5+fwGgnguC5xoZ3/604I3iCC/do8uJyG7voMty6RU
 AcwLIfQ9SACbXMZOQb/ETjs0XeBMArlBq7Sr6YKLxMRgoALAvssYHJf4erM0w5TLEtXD+UgBoia
 fnuhPQCiRwbZiIPuZ2/l0oTWLBR+602+a2MYKNQ6
X-Google-Smtp-Source: AGHT+IFL2cEF8uWqAwFWksJ6sodfxO21NIRA2iSBkFtqqdnEK0CiHPjzx/0QR8TPRq3IFPVB09ZJeQ==
X-Received: by 2002:a17:902:f60e:b0:22e:7c8b:7e66 with SMTP id
 d9443c01a7336-22e864ee727mr14841735ad.26.1746661614429; 
 Wed, 07 May 2025 16:46:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 43/49] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
Date: Wed,  7 May 2025 16:42:34 -0700
Message-ID: <20250507234241.957746-44-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/arm/tcg/iwmmxt_helper.c | 4 +++-
 target/arm/tcg/meson.build     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103e..ba054b6b4db 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,9 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index cee00b24cda..02dfe768c5d 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
@@ -68,7 +67,9 @@ arm_common_ss.add(files(
 
 arm_common_system_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
-- 
2.47.2


