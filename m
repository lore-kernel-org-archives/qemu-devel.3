Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C9AC54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXkp-0007yU-10; Fri, 23 Feb 2024 10:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdXPE-00066e-Vj
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:24:09 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdXP7-0002Wm-7i
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:24:08 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563b7b3e3ecso1206262a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708701839; x=1709306639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yBUCS7B8iy7ibXpK9yUUdtBoP55z0gbi12cHeE1kR7g=;
 b=MfqZFNySox3w1GxCoKY8jc3HoE37XAlcJ6LNQ9wVnvo/CHdwGd5Jmy3KC/SrhcwLZZ
 5X3vk0cp3KzMqBqiXQC7tuDCbUpNV2x8bZIO8auJxJGZoFbx9vtIzYWAfAuwayXhzoHi
 NLiqN71q9AvGZeBX4RiIXnVOr33wICwRyFTt6yqQJkm1monu5VL43FMkxbVM/SGRwPJN
 klGKLdYX6qerjVN02+1F/pTaIpaAUcKNfrfabjYUPf4oH9sM4sRno7/nuN2M3Jhb5I/w
 b+dQ1uh316bKf0FBHIVeXtlGb1o+4eL1R+33TUEj2luyM+AHuAuxrVEDZJ3qQNhYUcXc
 Cywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708701839; x=1709306639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yBUCS7B8iy7ibXpK9yUUdtBoP55z0gbi12cHeE1kR7g=;
 b=vJ1AtlyDkNPoIOM5C61xVynzWwwSTjoF+Z3GNs4eUqhgUUozVLFtJya4JBx6JZy2pM
 /vfDkQJAegLGZaPcamSu2CxKmJLJl/p1or3SqQZTo/Fw1UGtadkvkNS7rZxyjGUe1xD9
 Er4BgzC5E5YHwQHzP4wUZUzH4mnJO/5EjoCF+gUVadiRL+Esq4PyfaCNrl7DpKucNsl9
 fKDGNP7onLssdofQKdqSU4uhdAGVvecZmDgAl0dXvENMBgoOwGCwBCNdLJrnNVh3zuu/
 /Pdejd5+RS4pqmPePkY1Nj4EADLvjpViylBVwPBZM2iwZe3/HvDmBtWoPlB0puSRxR7W
 ko/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVow+H2ikQlB+0wYAWVdW3SGtRQHPnYWwIgtU9qV1lZWejDG9C+3uUD+0XfU5LN39L3t3OA7l07EkAwPwlOIQL4ttnrbD8=
X-Gm-Message-State: AOJu0Yw/o0aa6dIEy0lr1SaYRUxWmF962Yp3wSrNlDT/ye5TbSL/L3Ob
 buG03hDpHEzDfD8wWiXtBcoUZmrqpOQMCingdC87ZLljnldZbJADtmoJLLk0PvYLiMhDgqQzj3T
 W41IZ85PrQt68IAQN6CiAoszU+lKBIRvCxdh3lg==
X-Google-Smtp-Source: AGHT+IH7temx+tKeK8MDwX1cSyUnt99xrzJxmbFlQXafRO8/tgZD/ZEiUUF+ToiDavdMSdvMgrRTQ3VSaJRZoe9AJLk=
X-Received: by 2002:a05:6402:695:b0:564:21fd:2710 with SMTP id
 f21-20020a056402069500b0056421fd2710mr97916edy.37.1708701839147; Fri, 23 Feb
 2024 07:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20240221173325.1494895-1-nabihestefan@google.com>
 <20240221173325.1494895-3-nabihestefan@google.com>
In-Reply-To: <20240221173325.1494895-3-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 15:23:48 +0000
Message-ID: <CAFEAcA_peQktO-PHcyEcGZrvDN7_Zdg-x_ZBwJ5OCETE9hBr-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc/arm_gicv3_its: Use send_msi in the
 GITS_TRANSLATER write
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 21 Feb 2024 at 17:33, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Roque Arcudia Hernandez <roqueh@google.com>
>
> This is trying to achieve 2 things: To be able to redefine the send_msi in a
> derived class of arm_gicv3_its and/or to expose a method call interface to
> inject interrupts from another device.

But there is no such derived class, so what's the purpose of
this infrastructure? If you have a specific device model you want
to upstream that uses this, you should include this in the patchset
adding that device model, so that we have the context to see what
the change is trying to and whether it's the best way to do it.

thanks
-- PMM

