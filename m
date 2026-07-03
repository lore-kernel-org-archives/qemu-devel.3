Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4D0C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfagY-0000FP-BB; Fri, 03 Jul 2026 05:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfagX-0000EQ-De
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:59:49 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfagV-0006ns-VK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:59:49 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664b84118d5so584270d50.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783072787; cv=none;
 d=google.com; s=arc-20260327;
 b=CX3HSe62WaK5PguGSZmwYonLN0M06F69Gy6jfpwFhwUOjNC86ztTJQyb9m6w2rjRz4
 5QUc9sMDf79mIaWTYfOLJhqrbH9WLQhHWCfXN+vNg5Dabi4bB6asM4EzwcWW8/RCf6N9
 XU5QFERBSbH7N1aOBpS0KKmW7HYPmZ82srfB4Cn3xvsq6XHD090oUKzXgT/8rNnQjbDc
 KJEq+/cVQ20HvcSzR3ZwfJLrQEQngTITYG0YQKp+YLN20XLSiltclvsTv65w/lnQIi6S
 XjGFJJKtT7msjHiZh/CZEewjsd86lS9owlhnPYRCuU2fIE0XhoJyB9X6URQgVNs6jHCr
 pvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
 fh=7ZV1lgql/1dR2B7XZ30UasIsf14UH1mNfXQW2hGxu8Q=;
 b=YBCOPzYj97qM5ZGlDKxmiCI7KeR9p50KUETO4skJ8Dyrn0zB3JXqGSH8RXM5XTOU9D
 KQUjM/7GBB8JTzuwLOmGJYTk8zbZu49VXta8x2XOVITEn7ROXstli8SLNKqdyzLZGTFX
 4ri5gcGslAgM1BlqVIT4W61sBM3ml/ff7TSFLWdnxr49QRLtlQ28TXqmSmobFQyfRqWK
 VoEuAjtiMZx3k6M/dZcdPqxJqmRjfaUGLeArLcXY6Ggmg3BO6VVWpcSw4UdCnltas3pd
 FWzcTsmArvDB7BvbodaJy+GpjFda0Vuiks/6774z/3fkx7RXM93dnIzb+vsJm0m9QvGp
 Sw2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783072787; x=1783677587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
 b=l2Fk68kQDLVnHSc/htFBJbGbs2Qrnp0rBdSb34f4Jvj3DO6QS+mI6WdEIQwym0+nil
 cdu7vWJmtce1Wy9jA5CfNTS83tHYEyi2niqlFv4Iv9VUw9wX3oO9lwKo3Q3J5WccocNR
 lIrcqidXYIfOGuMhFqer72E2avMD+pxizJxxgpCRFQxCP/e0cwefazZtXcTnXvhVZbjK
 CN/pTYpkJUATqdNkguHS7wxBa6/0h1CBsVNYyNIbPuNdBwRnO1ypWMdpDKmHY48YerxK
 /5pAPsaQufWB6lIkR7jEOStWI8dwHVxUgTAzfwlBFPEMtScId5tS0CabhrOBUY3Uflh0
 x3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783072787; x=1783677587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a3P3Tr5cp7+7D8TJqnA3Mjf9GQDMQvB2MGmfRIaPWhg=;
 b=Jo/UB+70VzMmeXly9IMwUVPzvCx4tgLlnocaNvAv2E5009jMRm4WKDAs66uEa3/SJO
 4Vo3fbIh+NQjx6TokfajeB5YRt+RYuarMyvOUdK4WcJXRdeNjP5wRw2xJDVASPEZjGDX
 Uj+/htUXItczc7qMisMksWr2LJk/BBhzo8k3W3EPY1VGx+Yf5luzAVG4Z2iHRjEjLFUW
 s/KkZLbcYWUsiT2piWNdqnZ9rOn6AzGhzgTqlidH0sCgO6qgy4NNIvhVBUnOBi3O/uaM
 ijdI/AO1SNY7hUmEQ4l29+pTyNJ6P7Z40JHK54gjZKp9b2tM6nQEBzgYsXeboFoUcu7p
 YieA==
X-Gm-Message-State: AOJu0YxyAwzcVJQiijECj/fhyY4Sf+1esh+618bI97D3S2nYO1DvH5lt
 vBHi6s3pSXqVMjudHFE3WNUyIhDrvag57M/uTWnpTrfesuJASc6yYgFTMEmnHI1YGDKZWOQ4Kd2
 lnvaANr+JKT2f5GCBmgcgpTu/ENMusG72yQiDJ857/w==
X-Gm-Gg: AfdE7ck9Aik9OC1DX4vogPR2kuExPf3jD2deGFdqOgMHRfHWqsd4YFOM/cTU+6P77s5
 qfwcnuK12m3ceGx15B1gGSmHj4C9uEm8Anb7lMjVFcgNHvJdnlyoThP+0lqRDdU1+cXv7IyYuys
 TXRgZVN6GZ4dbcFPomlK604S1rT0SwiQzZs/8NLdqOjmzyUV84YJ4/xqFQv8xi1sTM5eKAyWXML
 7uBtgRZLFG2/ptb5zbRL413FLORT/pGiA1hRbI5udL7fOfkuKz0LnaNsZJd1T1lACuqBSSYehfo
 tD/Q4twVqn9SaD03BR14XSH5nRXqliKLJOeyXdlouqMQZ6b3ShkIZWhR
X-Received: by 2002:a05:690e:4188:b0:664:b5a9:eef1 with SMTP id
 956f58d0204a3-66521b3a729mr8538474d50.64.1783072786955; Fri, 03 Jul 2026
 02:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260624103049.884930-1-alex.bennee@linaro.org>
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:59:35 +0100
X-Gm-Features: AVVi8Cc0-9na2SVpfaB0sZbkOU-6Sk1x4LYlRjdp1IEN46Q2BYvTDWcdA-jULA4
Message-ID: <CAFEAcA-JmvT-S8q4F65+E1Ghf+DrUtB+WMqjpBF1xd9hcN5Bag@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] target/arm: fully model WFxT instructions for
 A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>, 
 Hao Wu <wuhaotsh@google.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 24 Jun 2026 at 11:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
> The refactoring from the previous iterations of the patch have now
> been merged.
>
> I've dropped trying to fully model the global monitor in favour of
> taking advantage of the architectural flexibility to have an IMPDEF
> event wake up for any reason. We treat the setting of exclusive_addr
> as such a reason because it indicates the current vCPU is in a ldstx
> exclusive region and we don't want the guest to deadlock. This does mean
> the system won't sleep on WFE enabled locks but people shouldn't be
> relying on QEMU to model real world sleep patterns anyway given the
> efficiency of emulation compared to real HW.
>



Applied to target-arm.next, thanks.

-- PMM

