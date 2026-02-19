Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09BBE9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e7-0002Ib-Ry; Thu, 19 Feb 2026 14:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9da-0000aI-ME
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dW-0000HJ-TG
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:33 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so12331145e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529069; x=1772133869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JRsko414QBZVYQS3HsPHPbEprHkq3bhc/tGcxJzzq8=;
 b=PfxYcGHlfUVZBsFuT/PhLYvHszxCsdcOIpU7m+6/STNkkRsx0RyykRw9H2im8nw8Kh
 CNU0GvoHdHVU/gLSRs2c0KfhJMtIJitNm1V8wP4y2QQpxEH8cYX2Y3sbkL3Gq+kG4odv
 c8KR3HaOrsfUkig4AwzmfjnpWk5lESF1c82dtbUT8Ib+pHaE32jcCmnd/W+WtOur+eGQ
 1PzQYYuklpucMiyf6Fgu2MndYl3fy8x8ozRBPK6uT68Ergwjm3ZMPAxirmhbgqVslywe
 2/JUYkVN49tRRuG11yA+5/axYmcaQpVvPPislumPfJfgt52MwhJHqKd5jLmiOQpecLUL
 jUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529069; x=1772133869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6JRsko414QBZVYQS3HsPHPbEprHkq3bhc/tGcxJzzq8=;
 b=iGOHk844uihITSrU7Q5FHfrULVx1b80rXU4rsQ1I5skT4YXQphiO9WEWUGoBFG4+Ix
 vCI1bUTm+/Zp853lMNX47yTqqTnJ2NbdN2w5sJh5RdXhogY9E/q8jgcBNTe1maVaLmtj
 Ls9SNbEvLeCwzD6BOAKp+thKzMyGmFDNte8mDf+vwTXK8ZkelHMd0ESKCoXuuKQcT9Uo
 19RQAF49/lu1IoC6SEqHIqbkTmBuXxo9nB/pa9mWqpETG4kL4188duiKrKiFXpJ0YQEQ
 Z4JY1JBNZ+ahY/cbqY7K3EfJx1iH6mP1yWo4RLxZugFVc1Wjp7Qfl4/H96tIXHJ7vzzx
 /LUg==
X-Gm-Message-State: AOJu0YxIcyS47iVSi2QI8AUYvzQDfgvJ7Zugfj4MUDdw+4/jg9rnPdUD
 vqq4ycKWZaojLqTJPKAGl+0xypCyFuvsTgiiVLqvN/mBMwLpA/pbQgFOsyK9NZjped5VPW/mbbZ
 UWNHAxewE1w==
X-Gm-Gg: AZuq6aJ78W4awvztPz+4zSBNuSE00tcttLvhXf9UR0OW1LXyonnqPrx4qRB342U/Fry
 SUeyhsne+ZAdE37rpLF+G3Kn7RVINGx2T4nV9mEP0aXJY9fUOBIHvzvU7fsSPJpWP1I3cmboWM5
 lKslrg1XEgIbMMFJ2NLTBGXQoTzWG0EVjcIpf6zeH80XOXz2fWqodNeoTN0v7hoahxQ8F5LC7mB
 b8b1sRlq8EsIf5KW/QabYxGEg2LZXehNafZNODgognuq76YHsrQpcj79xQWxGpdhJmMj48iQkQQ
 +KKeUaW0N1t/u/oP0uO8b/17QqvIK/3g1wG3lyXs9LfvxXb0C952WcyGrtDr7aDtg/pYIK33OAC
 aatkq2YPZh6vCzXWH1FKFSuTwUFUWNFxCAnmx1cPWds56CF7CbvZwuQej+A6DyGHR+1TYCQgfHZ
 J7FXpeNzK4HLt7gb9PV+PzrDEBboljvBTSuLh/sFkebNY1gYIa8K/0ypL5K7+1EMR1x/sD1pDg
X-Received: by 2002:a05:600c:4f0e:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-48373a1029emr410812305e9.15.1771529069051; 
 Thu, 19 Feb 2026 11:24:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b1712sm19017025e9.1.2026.02.19.11.24.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 38/50] target/microblaze: Build 'gdbstub.c' once for system
 binaries
Date: Thu, 19 Feb 2026 20:19:40 +0100
Message-ID: <20260219191955.83815-39-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

'gdbstub.c' can now be built once for all qemu-system-microblaze*
binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index b30b8f70ace..b86b37d9238 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -4,12 +4,17 @@ microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
-  'gdbstub.c',
   'helper.c',
   'op_helper.c',
   'translate.c',
 ))
 
+microblaze_user_ss = ss.source_set()
+microblaze_user_ss.add(files('gdbstub.c'))
+
+microblaze_common_system_ss = ss.source_set()
+microblaze_common_system_ss.add(files('gdbstub.c'))
+
 microblaze_system_ss = ss.source_set()
 microblaze_system_ss.add(files(
   'mmu.c',
@@ -17,4 +22,6 @@ microblaze_system_ss.add(files(
 ))
 
 target_arch += {'microblaze': microblaze_ss}
-target_common_system_arch += {'microblaze': microblaze_system_ss}
+target_user_arch += {'microblaze': microblaze_user_ss}
+target_system_arch += {'microblaze': microblaze_system_ss}
+target_common_system_arch += {'microblaze': microblaze_common_system_ss}
-- 
2.52.0


