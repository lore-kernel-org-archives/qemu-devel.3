Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C02CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsOG8-0001HO-1Y; Thu, 04 Apr 2024 10:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsOFx-0001Fx-7f
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:39:58 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsOFu-0004Px-M1
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:39:56 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so1624570a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712241592; x=1712846392; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GibgvPlEf6K6Ev5wyGbWbItBdY6+6NVY04HUHJy7dQ0=;
 b=P23JsslgLA8OdHrwLwJQq1gWVsS3HOFMldB+/U+hV5WDL6QIaoZRAAOYoL+MCpnKX5
 AfuCu6aJ8gznZojDNzAsIr+KEgMxk8wEtY6l/0p8n5LeBjJe98EZOdmdDSNVUzEktAmT
 r/ctm+CsHTkwMkVCLtAkRO6kqFw8Bsd5XClaUc3AeKmx8RAuc3/VvNfzjLEyvPr31UtW
 v3t0yLCJHizpWt3Dpt/6g20WUfy5Gh3b8VJYV/j0FkI0e2+U2DljRpA+uq2RmzEB8PO3
 dc/P3nEZcH1DJVjOT100FrEF1N68PGW67KVGfWHVvjpYnrJNW8W39JITRWghUhgiUPlJ
 HG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712241592; x=1712846392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GibgvPlEf6K6Ev5wyGbWbItBdY6+6NVY04HUHJy7dQ0=;
 b=mJwgL/sbmb1Nz28/0VoTqN4cbj61llK83exLFJw5huJyCXd9ZitKnZLKjBxRAKVdKV
 XsfKTCyD/Vmq/o7oPp4XmqRDOkpQ6W2HEunF7NJ+cJ3SB4Gd4rhUC8ym2tlGfZVPAWRj
 Qjq+L+nwOElw8mhSSNB+mVQlJbrq5Vz9694T/sY9PWRyhEANFLI08Smr3Agf4GwA/pIg
 PIZBWpRnoCh5IEv1GzW8IrmYMLfCji0DP5cFH5cylQd4ylazVaeR4tokmkCb02Lcx4I8
 6QxG2iTXEoboJrMDJ1epV2GGD++rZPjPbEOnuZDsyVe+g6mgsUzcdN+w4+dAHjurM+6u
 MRUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyqIJaz6HVWVZp1iqb/6LUVXKjFdzdfigqzXZM8ws5OBJ06byxyCNkVmE7Eqc081y27UmlLhlcW30b19h1Vrxwx1H72Cg=
X-Gm-Message-State: AOJu0YyhPqrt2CCnmDW5g7x9bHKYhcafpbdcOc2/x+s/hBxwg5pIiiRq
 2e1+0PyGG3J6+RJNG5IbH9EdZW/kZqIy+aPYp2Y2Ro7N6MBOpf+tDG7ccSuhTN8KixMVi/Kb8Ze
 z+9GcTtV5UY+ibhx96c+pSUbY3ee87d6lJCydaw==
X-Google-Smtp-Source: AGHT+IG3X9lIianVEZ1H+9HJf4jqNbwejtjjr9PmW79Wj6tlrhzVDXF3RCKpjDiEyZY7HDKqIy0yoEZPhjrT3Zf40U4=
X-Received: by 2002:a50:c315:0:b0:56b:9ef8:f656 with SMTP id
 a21-20020a50c315000000b0056b9ef8f656mr1885953edb.7.1712241591805; Thu, 04 Apr
 2024 07:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-1-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:39:40 +0100
Message-ID: <CAFEAcA9w6JUyjCU7uqiaiwrGG6w0V4G6DxjUC+DcvcKcoBtFKg@mail.gmail.com>
Subject: Re: [PATCH v12 00/23] target/arm: Implement FEAT_NMI and
 FEAT_GICv3_NMI
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> This patch set implements FEAT_NMI and FEAT_GICv3_NMI for ARMv8. These
> introduce support for a new category of interrupts in the architecture
> which we can use to provide NMI like functionality.

Looking through the Arm ARM pseudocode at places where it
handles NMI related features and bits, I noticed one corner
case we don't handle in this patchseries: illegal exception return.
In the pseudocode, AArch64.ExceptionReturn() calls
SetPSTATEFromPSR(), which treats PSTATE.ALLINT as one of the
bits which are reinstated from SPSR to PSTATE regardless of
whether this is an illegal exception return or not. For
QEMU that means we want to handle it the same way we do
PSTATE_DAIF and PSTATE_NZCV in the illegal_return exit path of
the exception_return helper:

--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -904,8 +904,8 @@ illegal_return:
      */
     env->pstate |= PSTATE_IL;
     env->pc = new_pc;
-    spsr &= PSTATE_NZCV | PSTATE_DAIF;
-    spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF);
+    spsr &= PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT;
+    spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT);
     pstate_write(env, spsr);
     if (!arm_singlestep_active(env)) {
         env->pstate &= ~PSTATE_SS;

(I haven't thought about whether this fits particularly into
any existing patch or should be a patch of its own.)

thanks
-- PMM

