Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C04CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZP-0006i1-PE; Wed, 27 May 2026 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZ6-0006VN-RT
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZ5-00015p-1W
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso59494955e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877961; x=1780482761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=22gwZOybvrKrfK2aS/mr9JxouLp7Ia0VBR9l/gz7dPE=;
 b=LJKOlHCfX7+q9k5uy/bawKRiTiu+lDGR8q40K3YorZvd3udq1PLIew0FOBjYhQxXt7
 Btev2Sz5K087RLVY8u+sG1VtgwliQc9CErDy7+mOyQZhatR/HSoXKHMijbuozHnEauur
 kwCSq2TXI581G9pLZ5wakhhSSDlMWhN477ufcNTxFtNvjKLi/vsDy9OYd5z7zclaqzhv
 4t1FhRkqYu44+9s0ElS4clF0VZYAks6YMAmOsEQbekODpAFFk7sqI/01Wpv0TaXzMgDk
 DGmg7iEhkbcrYVveLr4QmUB6Y2aQWDhzFTu/V2kI9sqSfi218jlVIWX8MkuS1+cJp9Uw
 Axag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877961; x=1780482761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=22gwZOybvrKrfK2aS/mr9JxouLp7Ia0VBR9l/gz7dPE=;
 b=q7BFOswxso+6H8yDZe7T5PWkUMgCnRWr8RvkrDiAqf6sfEUwAX1ZHnt3l757ybGgtK
 Z5GM6mrf0GBw9uGURV+VoINQxk58sKxoYSUlO2t6Wf2KVX9pWvmbvvDWr7+ZFymCDeQW
 nfUGke9m7nKk6AJkL2FPQ3Otq7RrRqSz2MS+OxiGHRUjaC1duDBiajfar7uei7d5Y8Hv
 WYElZOuH9HOHQCMGUqzWAzhJLApLbYydN1SMxRVC+t/JgBO/aeD7+UK/FaLlb2A2WEE5
 VvixweymnITif0MdmabujV+A/28NR2xH7GhUKMmKYOSI/qrwdBr7LB7B99G/p6qpbrVP
 KAog==
X-Gm-Message-State: AOJu0YyDfbRvb5AWyvQRGUwG9mwd5NT2fpZpGvwtqgO5Tq8bu8iZtxOB
 DnFVIO0I+305ysYFFPg0qgMbwC7a6pxxmS/S7fk/hIYSGU0CK30Ym+oXEbtngCTQPh4tJXOze+U
 e6lawfl0yVQ==
X-Gm-Gg: Acq92OENy6q/jdnbcQYODGOKfwfHyKVyXQkcbmId1MOfGxCI41RAKzi568PXqIQgSsj
 WpjponOwwjSDUF1mTlAV1bxNCGDSJmBGuyXM81nOkY/AEYZMjTWAnVBmiahWLIBoJARL5f6DYA5
 gB90IREXUmub/ziKaPQcWSkshtN8aEb7p3jvFTQ5qN0f3dW58nVTweaffouwe0jJtU16UhQ40HJ
 Gw14ouGTQjJjfnAkvCSfQAGCoPqDaQjlZe5SaK13TunFofG1LlHrpqrxdHqFOz3BcOznD6msTsL
 jA8oFgxZtoa9KiBkHATswsdQsWw2zhFsu6+MdcRIXOnP3ZNq4FQIv/4EKmZr4wp2YKFMUEverBQ
 96kT3eIAnOAghwSqSX9flHhRM/ExrPUBXHJdYhNUoNSLhnQ5Sy0Zyrsx8VbgshZ80TXjNIRhtkX
 fMTN0bsB6t5P3Tlj2UQjo5opilJ1URJ/TSyNePvYagn1fbwEn3x6Cxm9I=
X-Received: by 2002:a05:600c:5298:b0:48f:e230:c3fb with SMTP id
 5b1f17b1804b1-490428ddd40mr397499855e9.33.1779877961537; 
 Wed, 27 May 2026 03:32:41 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527dbf3sm366986835e9.6.2026.05.27.03.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/32] target/arm: Build gdbstub64.o as common object
Date: Wed, 27 May 2026 12:30:22 +0200
Message-ID: <20260527103037.4461-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

While gdbstub64.o is already built once, build it as
common object, reducing target-specific set in arm_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-8-philmd@linaro.org>
---
 target/arm/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index e56fc943bdf..5376be2e3bc 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,7 +11,6 @@ arm_user_ss.add(files('gdbstub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
-  'gdbstub64.c'
 ))
 
 arm_common_ss.add(files(
@@ -24,6 +23,9 @@ arm_common_user_system_ss.add(files(
   'helper.c',
   'vfp_fpscr.c',
 ))
+arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'gdbstub64.c'
+))
 
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
-- 
2.53.0


