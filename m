Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5A4FF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 08:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIjEI-00029d-8w; Fri, 01 May 2026 04:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIjEH-00029O-0L
 for qemu-devel@nongnu.org; Fri, 01 May 2026 04:28:09 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIjEF-0007oh-MT
 for qemu-devel@nongnu.org; Fri, 01 May 2026 04:28:08 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7b4ee3a88e1so25421297b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 01:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777624086; cv=none;
 d=google.com; s=arc-20240605;
 b=hufFWJDJxt/P6Rp9G7o6b6Aef1IqD/g31gmXeg7WbxMui6KHub8gVlvP6GdqO1p2FU
 k0e+rWGNFZj+OnDuGPSAv33kgVTMcZGICTuG0v4SOM89f97rAH4Hdhghx4jl/Q7oi9fD
 6ANjCGo/daQbFCZD8OMEVdlyVdErdEOmFnt/H/gyCtRA+TzLZW/7vuSXPqnMVBhqnBsF
 x2Insnx/0JDrv+WE399s8Dz84A98KLhYGqPCm3ShGfUzdfeJKJnmXzlNP1YQnrml9TqG
 J4S+3dXUnBHAsHOm1+HHtxyhNSoyrIQGFNjuRc+fO6Y4PuVFLUCOtmna058xF8S7qeYq
 ChWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zdQB4DaMRDeYxlRocZwZMiI/ETSV0ATJmp7CBqXalRg=;
 fh=67FIEAxCuvQIamkfYfieYWW8UW8BrMCsPo5FDyEN3kQ=;
 b=aU1GtdMaIo7NLfbHuvQyy5EDPF8P7Bphl4EjU+87PWzY6ASHbw/u2Rd/5a0xdU8Zw9
 vpa38a+ss3KjuHOpMlZmTXQdts6sl+cTQvR2iumabSk6AaawOnQDLnxHuWBJHKII1m1r
 x3wa22+esdwwT17Xzk8TqxZt5EA7HPORs//PKh+NG5BsD+d0YuG45B6Yhxdr+8ZwYfv2
 U7EAfjleUa1DL6qS8A+jZXurdDZTWlfY8/876zBjMyZxEpQyl8NXsIwJfUoiyrpnSeeP
 d/M8d9T0m1ZZm1akl8j/9hXREc8LhFocpkm1us2gCeWwjsOjWsl97nsqU2pAuWYhsGFm
 20/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777624086; x=1778228886; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zdQB4DaMRDeYxlRocZwZMiI/ETSV0ATJmp7CBqXalRg=;
 b=JDvOfX3Kd4dy6Lfhwe0ZDkPJMAun4hyYRANkzkrrnLUQKf4kD+NjBOt9482JN5JJDK
 sUhicMT5WGbor2B3quD/TLFyoVRUrYlAhfxv566Bs315rb3T7oP5SLTgC7/CFOvjWknZ
 /uRkGumc2hwbQjYx2aJsmB+pUsS1euaxmg+gVoCS8fHuIexc6jspQSY+GiV+ZIC7yfff
 jPR+CLejTlumpYGPCSgjFdtTwJGA11D8DwqBoRqhawvvOw53Sywtl9B2YvT56gSNXsv0
 9zYtdfqLiNlZcGGhvMRNkG0all03fzSn/Lgvc56sXqTexSaa0pQ7msCqzHN87idolwyF
 9wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777624086; x=1778228886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdQB4DaMRDeYxlRocZwZMiI/ETSV0ATJmp7CBqXalRg=;
 b=SqNIvpb45XdrhyrB2txTHGT/Je9TB2Et4Zm4gOOebH4a3oJ4kXVr4gGH8ykGizjIef
 Rw/jUkSltouFdX6FIU/Xpk9mOIXl+l0X+owlWahut5n0o2b/zE6pr+f+7Zc9MYujGndI
 toNbCLmk8pJcMza11xS3p/iDDlSpNDJTw+KerqtsZBAeEAW6j1szdGB9lWdovtTk4KxQ
 wutI9AYSNS0KnaLyAuCVBQ7vO9fSskQZ10jYcz0lppkTMPzhV1840V6EUD5x+mjHWF2B
 MlgmkjJ2pDhqlgIdswfPkMrH0UNNgYq4plm/RHptN7WJmgjRBqPudg7sPwfphikY/7+H
 pqHw==
X-Gm-Message-State: AOJu0YwJyUIu+dfNTwu9vPZadEPriRax3vp985/0jWKM2qrlWN6pbHil
 A0juGUmrW8q8ZzYgvKU2i5o7nFR6NOqBpuZtwzVFE4Oy1hQaYC8RzFC9g5by1WlJak+01wf7NVm
 IHPeCFIf0KMvWm7ZH+zDBERpp7DtM+MaUDzYnys9OVQ==
X-Gm-Gg: AeBDies15idB8Yk0Br6GBpzGF+Qmo5XGofRDKYPbTu7CsXqB77A9AFQFY/nCXz0ieNJ
 oMldAiMsvvOAPwsuEBHzrJeKCzs1lLcGbKFSlUw5pKe8lD7CjbuD4t4DdynL77huJsj8nZW7K+Z
 6tH+y1HMHAstT0gJfP3gvUghp0KgqoctCNtklu0MFzZz0EvujFA5zcHBoJbqf0exwVaqbWa7p+R
 ldBOYN6Id/pNQJhk1e5l0Dl0E9bdzuL0N7V5cJrV/7EJQmW7m78BdMOycKHShNxELy+ltm6m9cE
 +bUXOGklJvkwjx/E3EFGequMX/pnB5uQavhDIEz9+ES7wZ/rRmq7v5Mtp/M6K7oaURXWBlQur92
 oqQ==
X-Received: by 2002:a05:690c:93:b0:7bd:6432:dab with SMTP id
 00721157ae682-7bd643214a6mr30724147b3.43.1777624086066; Fri, 01 May 2026
 01:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
 <20260429190532.26538-14-mohamed@unpredictable.fr>
In-Reply-To: <20260429190532.26538-14-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 09:27:54 +0100
X-Gm-Features: AVHnY4LD9doMrkdvVfXyBUewM98Q9OeB9-W6KyQfg_-jN2Yig-EndN3N3AkaTdA
Message-ID: <CAFEAcA-f21a7hHcGNrAAA=2x_AUtQDOs7jUkmv=gxnLSM39c5A@mail.gmail.com>
Subject: Re: [PATCH v21 13/15] hvf: arm: physical timer emulation
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 29 Apr 2026 at 20:06, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Enable this through leveraging TCG's physical timer emulation.
> This allows nested virtualisation to work with a kernel-irqchip=off + GICv2.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

The TCG emulation code looks like it ought to be OK called
from an hvf context, though we do seem to be gradually
extending the set of TCG sysreg implementations that are
now silently required to work with HVF too...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

