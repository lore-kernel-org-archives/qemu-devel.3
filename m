Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33AAC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoVG-0003SS-Hi; Wed, 07 May 2025 19:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTd-0000cF-RP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTb-0003AD-SR
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22c3407a87aso5763805ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661618; x=1747266418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D50FgSNi0pKqcQ8O05hlTOFeOSvMmvlw2mBrg4KVMZU=;
 b=PczF5md7b2S24W6pfAm1wCaneXOf7KlDzpkyeRUgV9QpOfPOu5LY+B8j8qltCGX52Y
 +Vb1nDcuHkdomFsIlUdFS5+TBvxzwE0m0amvgNfS8PLpdaNcCMRuj4c9UmYNUXgSzZpR
 uR90NEEvNKXNp6K/mr7OsUSva/gWDBjhaWI+HlLUvaAtoxauHs7r9fz54c0fC7SlcSyP
 1hEnjGRBb+BFbJ2d8SuhtvHQHUpbcDueZC1csf8Yns3I2+9mep7lqGzWogqZBV5BGFA1
 inEBdlvM9I7Gba6npvb4IVCIP5gQoIU/Nb/vd3/OTH8gG0SobQxA+H2XZc6NQL23yzMs
 Ur7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661618; x=1747266418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D50FgSNi0pKqcQ8O05hlTOFeOSvMmvlw2mBrg4KVMZU=;
 b=gQjrpHPM674ioDwg5Y2RuBODNmxNXDvZEXHL+cXphPWj/6xLDwhfUlleg/gcsAQDDK
 hnrYC8aX8se6i5POmEeJEODo3enfMO35Cqv80hB5cppq08Pn5UMVzzKdfDlKXanQSaMp
 bkKMCKqyRhclthK/A/pR5aaxdrDsYfu7M0xxlmAIKkQcjYMhx5bMz9wYku8s5mDyuUQi
 F78+LWwX5rPoF0MggyzAE8dZXVLIPAyCY2bS7DGARgI7MpJpqeFE7mpjHZExXIBUtJIQ
 C6+QSMg3eot7IC9Y0RSaMVsLJuxZOcguFtl6+u2McPMz5T7fxTxeSrVJInIpfN+LE6qq
 IHog==
X-Gm-Message-State: AOJu0YydIYJvAk3l0khc70qd1GQA9Wd2TCF9CH9ueAOjwViyALZ5HyPX
 ZgIOhfTWwnFeGgIoRRr3aap7Vwjl1AWzcpzIUB7YCCYgn9Rn4zev4K/T1V5+3B/7MBvzcqzCsPw
 Sgt0ZRQ==
X-Gm-Gg: ASbGncuKPTo2auzc4TNMoWmpuP8cv7IIjizLaSX+unm4WAvCALbzcGKqYIWrEQB0dev
 Vw9L6hMPAAAKg7cX9pyp/Wl7+OwLPKHhblsL2TXBMBeko7uYZL/7b9V007LKAXSe/gmNWFOYlo6
 voK1Fz08vbSC4Q/Td1D6fWDGQCy1AEy6L8YH/HSTc86lg151G9XAPaYK3Ag6E5r0qnt7ZFUn34b
 YRSnGtY9tiOPlGoOno2u3wzaANAdv4T/03vBZIVpMxD3r/SFCMJFOhJgSg2L+01FkZW5hzkoDfa
 tNGolwdLz4cSwxwwQHYBCOGC5p+OuN8mVCQQsaiWVhViEy0xY8g=
X-Google-Smtp-Source: AGHT+IE28ol+YDSzIaHNx/fWYHVNSAxgPO8DVfTcMd3Ok+UpVl+BHuET78YD7yz4jHw8Fo5Kw2Cbmg==
X-Received: by 2002:a17:902:ec8a:b0:224:23be:c569 with SMTP id
 d9443c01a7336-22e863f13bdmr20015575ad.22.1746661618682; 
 Wed, 07 May 2025 16:46:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 48/49] target/arm/tcg/arith_helper: compile file once
Date: Wed,  7 May 2025 16:42:39 -0700
Message-ID: <20250507234241.957746-49-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/arm/tcg/arith_helper.c | 5 +++--
 target/arm/tcg/meson.build    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 9a555c7966c..670139819df 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -6,11 +6,12 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5d326585401..7502c5cded6 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'arith_helper.c',
   'vfp_helper.c',
 ))
 
@@ -59,6 +58,7 @@ arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(files(
+  'arith_helper.c',
   'crypto_helper.c',
 ))
 
-- 
2.47.2


