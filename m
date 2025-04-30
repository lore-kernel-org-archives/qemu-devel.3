Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B04C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8u7-0002Sm-Ht; Wed, 30 Apr 2025 10:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tt-0002J9-Of
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tq-0002hf-Ik
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:05 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so6829704a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025141; x=1746629941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihSbjG4MVG/rPWJxnirZVcYWQR5uI9SkbcEMwpHCSZo=;
 b=NpSPKJEAurCkEaDsEhSUWJe1Y7GDuZyAOIQW/oz7Bbgn2J5+eqGhblrPM8XoCD4HHq
 J3fldJVEhTOpMMGfocZKBDvvLwe6DjqgBGRyEMy1ILS+I0v7ksPuev+VzFVbQOk1G6Gg
 XwaWS0bkL8SXRaHh8jU9yLBVBrexsA+Uxg4jLUt9RksuqTgUs2YxgiwSl13h8Ah8F6b4
 lRBDOc1LvcydsgFXdv2F2B7np8bop2mFNQJruhb3iz2rspESno/WLy2XJItVJjt9L6DA
 QoeGGx0XeHF4JkON83FGe8UYqSrkgrUcDxZLXlPjvSKPPjwykcRq4xjQb2h/HEHgNkIT
 JMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025141; x=1746629941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihSbjG4MVG/rPWJxnirZVcYWQR5uI9SkbcEMwpHCSZo=;
 b=PO8PZbnrxLhyiFChKGYhPQyd44F/G21XC1vkiziEuOCombugxKNUS4TdcHMg2L10Kt
 6DBRqmeUdcgbSDmkThn+uG6XLhzGMrmN9hNcYykDcZL9nYO+2JDYpViFihjdRU4TuoCF
 ct7B8UviBLsUqLUaLxY+FaeBidKcFSw2T1hzrEX+OuS+JSymXiPsCgBtoxMlNYaAWo19
 aRjvELH41oQMrVbWBr3kG3GXuJyAYEPfDQZhDlt+kP4nitCBo2W7/8JcqkGxo7mGbHt7
 KZOYB736J+IOHyUaNCNp+rxYAo1fieE8uhnYH/Hog6wtPFupZW2LWKSWQV03bZsMtf7u
 AH7Q==
X-Gm-Message-State: AOJu0YyHmSTK5QiH4blsihOmoBkkG04f0LifEBsJzhEophseO+MDjcfS
 CBdx9HgXzOrXpIjjsxxo/sCSBytE9a1cZNXt0g//Ag1tndpVPS65W+QTI3t2quEMxc3+LyBuQag
 1
X-Gm-Gg: ASbGncvnLQb+/D/KAHo9iEkgxaiqtLCk2/bPnCRZdLUPKeef/PZLYTzk1EnWT+Vl6uU
 kKTLNJfOv1b4gdM1dGedJ03DAn8Y3ScKuMAj5wuNcB6N5YHkmclTNxuxqTko3aQQ8ZGVYqgdTmn
 fqOWWb5j1/2vU1WIWNU+x2iG/6IrnCQaMB7PRFyjC8/f4xH3Kvb68KAwEbm+a7LPqBg5SJAY29R
 D298IaatUwE8/1xuWO8BG9Xl+ULW/WxTyLcG7wUM8bN0U/cXmQwUMjids1NPUt0kKEfZBVgJqml
 KxiaSUgYvjLWnKRJuXi64Q9JRg8XQg7X39zmZdTA
X-Google-Smtp-Source: AGHT+IGA9pNdoHeLJn92OPL0IB6b00oQl3HQsDFWbKDFlsnsZMi2Ohq9Db4ZFbtPnsSb3wjiFMJj+w==
X-Received: by 2002:a17:90a:c2cd:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-30a33351198mr4339010a91.26.1746025141034; 
 Wed, 30 Apr 2025 07:59:01 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:59:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 12/12] target/arm/cpu32-stubs.c: compile file twice (user,
 system)
Date: Wed, 30 Apr 2025 07:58:37 -0700
Message-ID: <20250430145838.1790471-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

It could be squashed with commit introducing it, but I would prefer to
introduce target/arm/cpu.c first.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89e305eb56a..de214fe5d56 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,13 +11,9 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64',
-  if_true: files(
-    'cpu64.c',
-    'gdbstub64.c'),
-  if_false: files(
-    'cpu32-stubs.c'),
-)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+  'gdbstub64.c'))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
@@ -32,8 +28,12 @@ arm_system_ss.add(files(
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
+arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
+arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
+  'cpu32-stubs.c'))
 
 subdir('hvf')
 
-- 
2.47.2


