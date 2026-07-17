Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB0EC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 18:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkn6N-000615-Gu; Fri, 17 Jul 2026 14:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkn67-000609-Mo
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 14:15:45 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkn65-0007Mf-NX
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 14:15:43 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81062fdeaf5so19446657b3.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784312140; cv=none;
 d=google.com; s=arc-20260327;
 b=lw5li3aCYZao46QLiIwhL2vhrDtANjxTgLjCARErbyAKWI4ThxtJcLXi8kKNXxh0Sr
 f+QbbijS3mxyQrtFiofZUYkyvIChEOa9I6NQxlgUvTVEkzy3CSeMGlqNiCAxb8y0uhKy
 srIyt7bLlu3hR6mxymw887BYOP+vVRHBpwqt4VWxHEO79RSVFpeM3eSFTFJccLwdnCbq
 NVKm8pD2VyyVysVmAHhtwz1DtGmeVA4/o9WTV6kclJ40R/g1uCtlWEhQO8R6QmWnVZIc
 FF191Jrg/Ba9joqL3tFkP9YT1R7alGnxGUpJJEcv/j3oExkovA1T+SHRZKaJtL4AMIqf
 InKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u5/REWPssNQzJgBC/rzOpgJs6qngnLwQxtd688bC4/Q=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=KsglEQqvia/MypXsEAHdLXsj4MapZUYVV++/MWwarz4ublaIRub2ClI6LMBX28xLJB
 EziWNWm3uswu4SA/4yZGsnHShUXAGNaMprTsQ/L4unctyNCrKoo1/W5v4GuVHtSvX1WC
 +cfsqg6KsOKqk3lAftxx0+jwLkOWbVCkSMAvHqf0Ycq0JhDL9qxnoTN4bCkiyG0U+j4I
 5YB6LJIFcks6Y7n6/RLpCYxT7wiSKADbCpE7qoyVt+3HcDiRMf9gRP5dsBD83qjj7Xv0
 E35Xbbs2dAcaT4284V2ClJvLcnlvk5g+nv9pesc7YO/6SSisa6qI1VPPtQsOQXr0ibWJ
 yoxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784312140; x=1784916940; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u5/REWPssNQzJgBC/rzOpgJs6qngnLwQxtd688bC4/Q=;
 b=goAS5oilKCaVhbYcoExHaWaARJKr1IW8oWzcjqX4l4fq8N5+VFTKSIGGagzKZXNhEQ
 JdDIjflMzv9xPbp2NatAsuy/7yzV+gBgwRkXhajjcRUb0AUbEixHpxOqNDyNL9kaM+ga
 G8kdlgOEozWynV4JMdi3giCCZJBoy48T+TcE9ciSPBFo9Dh4XmPMgBBqyXe4ihSLGEsW
 fH6oQrz6ZjxzgXPCxXJJcQ/+sffF6tRtsia2axANQNMuciRR3AZNF14rHLjeCA9Gfl9m
 peuiekWncvoGbEYwUHSYe+VmjwV6gdrgK1RcSHC/2M2hoFrQk9vEIqjVIvDFWuwiV5mK
 UUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784312140; x=1784916940;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u5/REWPssNQzJgBC/rzOpgJs6qngnLwQxtd688bC4/Q=;
 b=gJVCfyWfimIuy/bKDrn24fwWZgOKdLa5xvUWSzSMidLgWdGiREyIOrlIMjvJttpflN
 +cwRzZ+2HZ0R2OYKohgNcr0ZGD3ZsG2VlNTBikcdPg5SQdKokF4fN2IlfAdjKITVkma9
 PXhClrjKpBTT5JK4M88NbL6Vxo13ThDfDX6RUUoiy1hmCgEGYfqhpHTchgPCL2PcEEta
 UgOZh+m/Wu/jSJvvu460oP8DUHFdFvjo3eP0Vbw0lCIoXShG1Q3vM/J8di3zLiBK4vAV
 OZHDmDhrh4Vt0cylI4CdqscskfpthV7t1cigiXQa7vgySToP4KNXq2a2BjshGXj587ZP
 n+eg==
X-Gm-Message-State: AOJu0YyuZWC9Tf9mIgViQx7bLDpsJBpH2pPgmaFMWK0WpwTkx2zyvsMn
 +9vhgM29GMM57gUTB0vGOD+6oqQTlDvCBcjh+wcHfP4uZDndjnfLR9kEfvnfbOgyMHZBFjZ57F0
 MMVoWlehjGXOhgQ4sjkkegM87NUNOEnN/zuNSiTaHVA==
X-Gm-Gg: AfdE7cmLR2ezeVsOoOpzG4ZgWTjKIUabt6OXvwf4T+Lmi0enLn7Qp7eDLcFGCKOLRpi
 MmpBAtZRUYaaxJp1V2su1YYTmboawev0pZDWzDmIdOcUqNGNrjpyL02C+Qnx9UQU+REJmf23zMC
 RsTcjyf1O2cSdhe8tR605PU4kJi5ZVuwOUyLaSrNRX4ROYF7DYM9zvkfxid8+bKyu4n1aEmm3kv
 RAzrUqQsLZ9zRjQm1cmrWSl1A/M7xEbUC66d42JEoCDlUJFCz3ElFDUk/cOC57L0pN6vgWuOnXi
 AW2AJwwBKyFaJK41hTRHpPsPTVb51JB1Dcf43D9PYv7IKg==
X-Received: by 2002:a05:690c:298:b0:81e:fdf7:bfbd with SMTP id
 00721157ae682-81efdf7c075mr2136617b3.15.1784312140192; Fri, 17 Jul 2026
 11:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260717174412.88258-1-dingtao0430@163.com>
In-Reply-To: <20260717174412.88258-1-dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 19:15:28 +0100
X-Gm-Features: AUfX_mwvy6Bm57SptJAU93Z67tGAtKynfjEmcQN_hV5dGGac_QI_yKzkZwfBGVk
Message-ID: <CAFEAcA-ZLB8+N_ud+6V=DkDrOvPznc75eoGHwQhMhYk7Cgf8MA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Aarch32 TCG CPU: secure register migration
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 17 Jul 2026 at 18:44, Tao Ding <dingtao0430@163.com> wrote:
>
> Hi, all
>
> In TCG mode, the xilinx-zynq-a9 board cannot recover normally
> after migration during the uboot phase. Some secure registers
> did not recover their correct values after migration, causing
> the CPU to enter an abnormal state.

Yes, this is a very long standing issue:
https://gitlab.com/qemu-project/qemu/-/work_items/467

Thanks for submitting this patch -- I'll have a look at it later.

-- PMM

