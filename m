Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67097C3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRyk-0008Rn-Fh; Sun, 04 May 2025 01:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRyP-0007xD-Bv
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:33:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRyM-00050V-Dr
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:33:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-74019695377so2799369b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336785; x=1746941585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhP0z8+DVkBnlSxtMGbkJypdQb1sgmbB67l7Zk5LpFM=;
 b=n+PAxqhd73Hm/q7Lm8StyzQLHOFj0wvWVhKaDHPFSOdHw3jMoacO7VOQRAJGMd8TQ4
 p1/YxblnMNr4F664eVAQqYa0yd/rD5a+6f5hCPhlD7wj/p5PFRBQtJ4Eh7LtdOq/qm3j
 1bH2KPmzrkPQ2pbvJ1uUz+X6CiAEEtdSLtuSC5Jd9VydRjZMkuxmjbizdUOxVv/AkwY0
 j3iRYYjhHjqEUgWpcuadRdFaevSrCdYdji9UEH7crWN+4K5fafhG+sCQaZL3OwZArqqx
 E95/c1PjunwUp9lWuXlPcSP1cWDaLpgf9EVG2w4b0lEu8oAhfiG+NZq/XdxclbBvBhzM
 uMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336785; x=1746941585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhP0z8+DVkBnlSxtMGbkJypdQb1sgmbB67l7Zk5LpFM=;
 b=IA4nuMIPgMpgExBlcABNBOXRt/eQRMJk/MFTLfk/m5eXfyjQ1wwFOkd3oWQhteNqfP
 Zc10XxHOVT+1nVKxXrKrmBAk+d8qdUiwljIPoxHwSOjBoru5ZI5CqXF/xy88EDBhcE4i
 iUunE4aUVoI6tiL1XWH2X1I5kveUpm//NsXtUQkwy2fJtGB+mgzjDB+5nlqja3U1Yhcu
 jSNtfsd6pZSyvnso1fkDNSvq4IZolNYWd6PQWS8sl2FjhQzmeD7EWz1vkdDUpT7ZZ9MJ
 OqyTE1KgMY5V6bwne6ZSmCKtG7eEkL3TK4c2iVKGdovQ0GQuCNAYBuIDcCYCpQV88sE6
 lsBg==
X-Gm-Message-State: AOJu0YxQAyU0Xh8EGzD8af8QtAEueUScr6YeICA5gHb0QrYP9JHX/TM7
 m3Ei51sPQX+NiF/+aVcjVoytNk5aH7MMODbjr6NHbw65g8fwIVRZl0GSpWqUVCAeLXIDIHLNlPI
 lmd4=
X-Gm-Gg: ASbGncuVWwCbYvv1ZqFa4ICiQiPKp9LRJNEw1TwQqmqc8CWB5ylYkrESrYlMPD4Vbzc
 ATdcSUwCOfVNsnVVKDkI0J+ksWfzvT3kbB/QweSUQq5ATvh2EbRy0dG7d1W1dCRPtw5X2+DgqCe
 vdysN3dbUNYjCQ+f2zYl2jw0alPQ0MPJBcDi8/hVO9ZobOM+EUki9oyiSSRgwQpa6TNWuLinFxH
 89Ec6qSKBjlC3HrlaZ+EYbtDFp0vhwDBnRwhKTpDtBinbJQ5D0ttNmDPdqQiLrXvgpQTgxOt2Df
 kMk8bqgSYmY07hEG6mv9wXNArfN/XF9lJvGIaOlsnZUXxRFlz0c=
X-Google-Smtp-Source: AGHT+IFxzLf5brOirIah+E07icoYpHpD+eH8Rlgkwz7ETNho3CAMflgpUA/uxvEn58nCtyo036kx9g==
X-Received: by 2002:a05:6a20:9f8d:b0:1f5:8cdb:2777 with SMTP id
 adf61e73a8af0-20e9610a719mr4360406637.3.1746336784802; 
 Sat, 03 May 2025 22:33:04 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a1c09sm4237101b3a.168.2025.05.03.22.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:33:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 40/40] target/arm/machine: compile file once (system)
Date: Sat,  3 May 2025 22:29:14 -0700
Message-ID: <20250504052914.3525365-41-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index bb1c09676d5..b404fa54863 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'machine.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
@@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'machine.c',
   'ptw.c',
   'vfp_fpscr.c',
 ))
-- 
2.47.2


