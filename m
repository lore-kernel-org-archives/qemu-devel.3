Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F21CE81A3A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs14y-00029M-K7; Mon, 16 Feb 2026 11:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs14l-00027S-6J
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:03:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs14j-0005n1-3c
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:03:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48069a48629so31818125e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 08:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771257831; x=1771862631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dJImaBRf1UQRC+k31lYt80mk2JUrwPwtKKmyLVRtziA=;
 b=bzBU40EZZZz7YLGYGl2psVSkoDoyfgw8qG0t9eBSEkHu/H2QLzU6jA/K2hw03DgY5n
 BT6CitBO2MrpALiDqWEhO78oYYCf72MYnaMsUMVeXtCsACJQqYx0Sn9jkeBmekA4cR3a
 zoUnrulQ0eIRUpDC7bKrg5H28oSDQsDCA5xLnHHzffntXp5T7DtS7dUF/Q4vCN2Kssmn
 Y/uD4awQ8/SI/VG/oWgcAWM1akw8GVLgZ6L9KSayRCpFFWrUmysohsziJxuN4XkLoLZU
 Rv3kWRo4+auReR1Q8BJfY4aogSiiccGxpNPuKvBj8mAgB+dutM17qiYVeqTpSuCG4wjV
 Jr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771257831; x=1771862631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJImaBRf1UQRC+k31lYt80mk2JUrwPwtKKmyLVRtziA=;
 b=axrTbOonXyUz0MrtrQEOA52cbRp1Bke+mli7JTxRZIWVyzWApnVmSJ+lUCyaWo+L2w
 PhADxAKalRZ6eRZVMze6hE96Vi1bdOmscDdGeN6c3VgrNRfnYu9SWH8wNxM6zQhfVm8p
 M6s8BUAK1ogEEYCZ5RkgqkUl1rNXgyNGY5+8jryGq7hwQHCF6XaJhFSrlzf3H2U6l0z7
 qRS2IioZDbooaIvTXcSZ240dxW98wo+EglB6MCgwRYXAyBvRHlX+AWBuqvhD7pJUyoC9
 cgA+m5/3wPl+xYYdKU5StfHADp3q0Pwh8EkHi6JZ/FYDaAnO6J/qNPS6JJ2stpjU3S2a
 DuPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjPm98ady63DrWb90IlpUq23tXrMdioZs7lpmKyzfdqJ9tidSMWqNekBgfU0XO7NTKtD4jfw8abK1x@nongnu.org
X-Gm-Message-State: AOJu0YxnpQtbzwOEc/mUKhFWINzPII5mTOIoOXAzFR5cJW0kg/LCPkiX
 gvSQudJPR07LtjsNq45S/mnZMDEWXwsSb9E7ZQUiPTxVjjpKlE0yfvDjJHkzbrLDg40=
X-Gm-Gg: AZuq6aK00PkZdxZHySmOhxFPftypQMz1KlDEzdSfQpwrreH9YWa4EOkKjNgvu7Sa/4m
 tHozPD51+1WrYE7MvBrMHy8VScR4VHRBcZrLWUuJNOdhv8SSMWjVmchYsAjyd5+76UeLWdtKKZn
 7mvZGvldgXeLnNgArb3mXMeHiFQiXQDzfS71j1x3Qhq7Vq81WwZ0qiAxk4/4aMWZnAFyr012Gvh
 E+UpATeYsaRTCJONR0SHCn2SjqSYmQZYRuptema07sxgOZS7gb0/2cGhYNMUK/c5Knv/dZnTL7C
 LMcd9aB6DJp1Z2811s0m+eiBvak3GGk4o92Cm0CIizXd+drUsh2DPenaYgCv/MtcuwzBf/yOXdV
 b8uKzBnuv/ZV0LjH8a1WWRk0pb2tyhfD1I57w2a7y17toW2odBVQfiNnn0zKrYdUZrzwIWqHE+A
 DCSvZwLgYRu7xW1CnPYuElIhACa5x1SZx0zPMN3Vk2PFWsizyGivQxL8ogj8fxWKeEBZWvBoZZD
 4B8adzVddcYv9pRsi7128DCrzpGiVo=
X-Received: by 2002:a05:600c:3e87:b0:480:32da:f338 with SMTP id
 5b1f17b1804b1-48373a0f961mr165584795e9.14.1771257831360; 
 Mon, 16 Feb 2026 08:03:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm661713185e9.0.2026.02.16.08.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:03:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] target/arm: Don't use HELPER_H in non-tcg files
Date: Mon, 16 Feb 2026 16:03:47 +0000
Message-ID: <20260216160349.3079657-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

This patchset gets rid of a couple of uses of HELPER_H to pull in the
TCG helper function prototypes in files that aren't in
target/arm/tcg:

 - debug_helper.c has a lot of TCG only code that can
   happily live in a new tcg/debug.c file instead, and only
   the CONFIG_TCG code was using the helper prototypes
 - helper.c was calling exactly one TCG helper function
   directly, and can be made to call a different function
   instead for the same effect

Pierrick: these might be helpful for you with getting the target/arm
single-binary series to compile when TCG is disabled.  I think it
might be best to avoid having a single helper.h that gives both the
helper_foo and the gen_helper_foo prototypes, though: even if it
doesn't cause compilation failures, only translate*.c need all the
inline definitions of gen_helper_foo. If you take that approach
then it would fix the compile errors without needing these patches.

(I did wonder if we could move target/arm/helper.h into the
tcg/ subdirectory, since it really is TCG-specific, but it looks
like the machinery in include/exec/helper* assumes that the target
has a helper.h in its top level directory.)

thanks
-- PMM

Peter Maydell (2):
  target/arm: Move TCG-specific code out of debug_helper.c
  target/arm: Don't require helper prototypes in helper.c

 target/arm/debug_helper.c                  | 769 ---------------------
 target/arm/helper.c                        |   5 +-
 target/arm/{debug_helper.c => tcg/debug.c} | 542 +--------------
 target/arm/tcg/meson.build                 |   2 +
 4 files changed, 4 insertions(+), 1314 deletions(-)
 copy target/arm/{debug_helper.c => tcg/debug.c} (53%)

-- 
2.43.0


