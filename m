Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F87F99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqxW-0005Dh-NP; Thu, 23 Apr 2026 06:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxU-00057M-C9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFqxP-00043r-VF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:06:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891f625344so49231515e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938810; x=1777543610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krTNXvx6wJKZ8OrO+RAzjGuvckVSQtTVVbEpnkD/WMg=;
 b=NTGnr1a6j/dBH8AJQbvuzh7KvoCuV2eAsLXuOebN2BPX4WLn7i5ngnmNXOMY0Wj6jp
 lpWkVEemzq/fs5EfhiBU6meLqN9/ZwkgEZu4ScXPzvkvsHwrGC9Q2ZKgR6UianG/DBTL
 T18t8b5PIiWHmuW2GRJTl7yaj24ChW5/U2RSvhTmyMOOsqm8mnXbgkR9lGq6RKC2MF0p
 g0uZneTU2gnuHyjKEP8NwEZfIR3dukUQfc6niYdM0yNeoSzhVHwJUlxfMWXZptCkhP6k
 px6TMGH47O3uvMZac3bmIKS5GVVVvm3yomIgtm+mRRLps7P4j5B10wlriy3u6sOco30u
 2K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938810; x=1777543610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=krTNXvx6wJKZ8OrO+RAzjGuvckVSQtTVVbEpnkD/WMg=;
 b=sdQq4lbeLzJ6Evc+F2yz73i+gcJXBhrw7QBzGbmVyiHjEfjJj6ViCAYD0AXVFc1EPC
 48pgzBHopNHZRDi87d6EMlRhA1Ivu6THk78csJcPdqsYD9KfpsxnUlXAViF6ccvxKNHr
 dVcNC6R3MfmNryBcpddLYrkU+uTiLkxTfWGkUCz0PZACjF3/0jU5v7KURMYVXTdDRpOz
 jYIZBnZk4Mlh5G+BDzJ1npa0AOGL15P7Z4fMRr1Sor447z8R3Uw4B/Epxc+o9BenZUhS
 xEzT3CaWt1sCCTFvQxI3vbKkrHtHkofPKdmqPYcCRyOtDF60eXorVU4XRsZBVeLJ7lN1
 KwPw==
X-Gm-Message-State: AOJu0YyJpysDc1i2g+9DMrA/JIGnSM6fAWV3srpxt2z1ag/mU2//050G
 JdKzl4nbj+t5gHwtmyKqZHGFxJjae36oc0koNYXoZwOoTSdN1oj0LUG5NZ4S0DtojsQeFS5TPKo
 DWIsToHI=
X-Gm-Gg: AeBDies5xKjozZ3uunUNmY8WxYFUM1bt/PBLFxhsprTxruZQccu2V4RdSfQNCaWnK5Y
 P8O2J0xz4BX8cGVQ6kiF435LyYQwI2ZHXz5xd/B4MndIkhCAjMDwtohjt3/TPN67YskYzCGr2SH
 zEELc4gqSIe4aybVyA7Q4s3cYUQHklmPIAP7JJMFH4JLiAH3cDFb4+Aphke69nBRRWnHesflIfI
 cXuslm+YSIFMe2iHVA2GiKBvwXvuvvsTFi5eeU50GmSSbUAz2rqZzpFs5/4wJyzcPgPhOJDEC7s
 NZskfQM0cfAfsx2J0Jv2HOVCSTvFXUlsgRCxuy3H3V5X8hb4B9G7KP2zdc3Foo9JhtgBkON6i1z
 2kJBD6KsOSu031Rpj58o16DbuG61ZDb1muiOu2V9SKdrLavavBM1ec0406bTFWvKEw0FH7oOAmG
 E5SpWgAxth2kHiiUtvV/UO9Y5O2UZQIevIebNGmGNnyK4dddM3DBZrDOQuBiAmg0ujoXLSX8dOg
 V+URUGoMmrowNq4bMuO4w==
X-Received: by 2002:a05:600c:34ca:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-48a07615b87mr182857515e9.8.1776938809882; 
 Thu, 23 Apr 2026 03:06:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm523032185e9.4.2026.04.23.03.06.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 03:06:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] target/microblaze: Compile helper.c as common unit
Date: Thu, 23 Apr 2026 12:06:08 +0200
Message-ID: <20260423100612.27278-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100612.27278-1-philmd@linaro.org>
References: <20260423100612.27278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Nothing in helper.c prevents it to be built as common unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 7f7d27d4efa..94c76de39bd 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -3,13 +3,13 @@ gen = decodetree.process('insns.decode')
 microblaze_common_ss = ss.source_set()
 microblaze_common_ss.add(files(
   'gdbstub.c',
+  'helper.c',
 ))
 
 microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
-  'helper.c',
   'op_helper.c',
   'translate.c',
 ))
-- 
2.53.0


