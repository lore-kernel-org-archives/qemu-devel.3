Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3943BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVfE-00012x-D8; Tue, 02 Jul 2024 01:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVf5-0000he-Ut
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVf4-0007Ew-5V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso17654665e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896555; x=1720501355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eas6wsShgW42jSmZDNlDNzwrh4Tvlo8xVG0UAKG97gM=;
 b=lW0kAK1ZqMbz/E0DoTiJaMZTbJkjawuhX8aDYi9wBn14te1r1yINMB5X+Us49B/SQF
 LxisdfsABYb+/h9v7W9Gh/UO5YFrbAzDq2EIK3fH8kt3bdzdvbMxG9asVMzscZoqo7pU
 WHlTvISt7Qqlqa2JvIQQ/tAg8UagBH1M7EEWst8DTw0XvzdigOZIN82lBJA3fE3vnGeT
 niPASdHK6JCJB1Vrwdy0PeeSEE0hjXUPeHK6XN2DjBS7Q4s5YLHZqZPkkJcqbPJk5C+c
 oJg9y5FDlsWm6kaxm2UXvE7gK6wlJuY8ASubrieJKR4jwzARYk1jrPufiz0cL1Yqdmu9
 9uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896555; x=1720501355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eas6wsShgW42jSmZDNlDNzwrh4Tvlo8xVG0UAKG97gM=;
 b=dl20ibR0Rvy+r3814JOh4MJTD+3ZrLhF3VIJ2lXncduLTZrYFxpTNptz2d8vEnHhbf
 Jyg4+a2WH4tc9vvT4ZFX62wcYar0vNLeHSFn7LTO/u28mAokSFTNGoF1Str+sMfN2qk3
 LZDQbZ5mjoPckdmRWHkdmegQG2p3uONzEU1JuKSQYmEN0xfxjVyy8U+C9D38H4IZPTTO
 2L1ZqjN4KFc7ycB5HR7H/+HWajUGParhwbbJuyuBd6Dbmf62OIGWxw3xjuNbm4GhzDpe
 XfMwTsmFnfjbxbIjsvyK3YuLJipElbNiW6n73kweGZL0ZyzszpdPV2OSU3iJhUkaYItJ
 u1yg==
X-Gm-Message-State: AOJu0Yw0IqJi4kdHg9poxeXsbc3xZKryAsPm2H3asXez6DkBKEAu0puS
 BYraiWNh7mFJg5TCMYu8U5n5cWH/s+beGCRbvxJ0mN3H5C+Tis0zN3YgvPTV1bDegTnor8GPoH4
 V
X-Google-Smtp-Source: AGHT+IEkLClfvhCpvr9H30CpGvp3cfM/yrAuqZjU+z2QTi2KTGkWuQ8lEOPAUiXvIv4iwdT/EvVNZg==
X-Received: by 2002:a05:600c:1989:b0:425:7a0e:f63 with SMTP id
 5b1f17b1804b1-4257a0e11e7mr49860665e9.3.1719896554928; 
 Mon, 01 Jul 2024 22:02:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09aa32sm181009225e9.34.2024.07.01.22.02.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/22] hw/ppc: remove obsolete manual deprecation reason string
 of spapr machines
Date: Tue,  2 Jul 2024 07:01:03 +0200
Message-ID: <20240702050112.35907-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The automatic deprecation mechanism introduced in the preceeding patches
will mark every spapr machine upto and including 2.12 as deprecated. As
such we can revert the manually added deprecation which was a subset:

  commit 1392617d35765d5d912625fbb5cab1ffbed8e140
  Author: Cédric Le Goater <clg@kaod.org>
  Date:   Tue Jan 23 16:37:02 2024 +1000

    spapr: Tag pseries-2.1 - 2.11 machines as deprecated

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-13-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 044e6a8d9d..98fa3aa6a8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5156,7 +5156,6 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
     compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
 }
 
 DEFINE_SPAPR_MACHINE(2, 11);
-- 
2.41.0


