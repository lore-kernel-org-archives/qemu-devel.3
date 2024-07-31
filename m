Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B426C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 17:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCne-0005Aq-LR; Wed, 31 Jul 2024 13:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZCnd-0005AN-Qf
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:07:41 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZCnc-0008EN-5q
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:07:41 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ed9b802ceso7419071e87.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722445658; x=1723050458; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W8KfsaU+RrpUdcyCoU1oVeno1sj4n+D8TgOb2VnQEfk=;
 b=qLaLzbfSm7WSdUXl0smPFFjFtYpD8KvOyL3jFvhR+r+XY5WXmqc90JwTLj9KAHrYt6
 VbGQR2dxd3Ww/v3GBrt4WKnVqGaeAnU+VOoyyW/G8kV8JG/EeP0058riwwYuSl9X+ZmO
 vN/723jjAvntXDfUlCUc+FWrn9+AbWni1GbG7OPPQ1wcPAiPIk+e4VrbCpuurVWkLNsT
 s/tMlLteLjsIhtktKBUzER81zsObo+OivUGWonhsLoHIlDcjjs4MYcl2ilc1z6HY9FAK
 LfvAdrRAtyNWEHVdiQkqNe5ur9WLDiKGWqrN10qOziCGAXwVXLWzIN44d5qCQBzXMrUh
 SzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722445658; x=1723050458;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W8KfsaU+RrpUdcyCoU1oVeno1sj4n+D8TgOb2VnQEfk=;
 b=odb56R4IUVup8Vj6eKoAFQ5fCss8YSDPy/1RdrBuvNyUAQim51g6yKNjaBXAxAfl8C
 +CdhHi70A3tUTvQNH473ggOftsrAVXrdrpGz5RxZIrZUhatzF4EtQ69QPmgBmT+RxPAE
 fRIGwerxaILeJ/fGeYV2xAiVLpa42TP34CcCPBk1PVVAIxrnBMChUehIA6j2Ptn91kpL
 eKbamp2yqdoDRDy8i/8qC7g/f0Wxlv6wLsg//AQqvLoPQjqj6EmkQ5253NSXB7n5E8fF
 DBMkHTxNKhWrmfczJvJJ5W2M6CXJNvlsm32jYbQYvd0B2Fq2ndBoUlQknf0dLPieI3zl
 4Njw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr6WgM/dWe7S4nDmWojQAiozBL4cD0qI5WCK/+7HaCOIHpPF1Ka36MHI+6Mc/q18m/cwV3SZIh0fMyIr7W9VKXtVydWJw=
X-Gm-Message-State: AOJu0Yx9HZXTOLI2q3RiuDDlJ5MH6tXJ1sf7cWLE9wwCKyrZQ55XPrER
 VRJI6RU20GjpU8ytphChZlL8eGkNoSmzA+FvQTyEjyAy30CPUfpfjJxw+B8vEQTGWfx/Cr6Er/n
 qfVWzGEoQGnP5NdlGlo0uUsrjceYLraY2DOKN5g==
X-Google-Smtp-Source: AGHT+IGg6JQEQPdLgDi4BvhJ+AtLtefTbxZ45PGOJEnEOjeF5KDWCgM7z8FnWH4us6zFamgo8c94k+Nj5nI3B8da0Kg=
X-Received: by 2002:ac2:5210:0:b0:52c:df83:ad52 with SMTP id
 2adb3069b0e04-5309b2809acmr11209147e87.36.1722445657937; Wed, 31 Jul 2024
 10:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230713120853.27023-1-anjo@rev.ng>
 <SN6PR02MB42058323403CE9291E40E005B837A@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB42058323403CE9291E40E005B837A@SN6PR02MB4205.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 18:07:26 +0100
Message-ID: <CAFEAcA_VttO0aEO6VBUAB4H9TVNH5tP5piZVq6F4Ao2MZF-UoA@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon/idef-parser: Remove self-assignment
To: Brian Cain <bcain@quicinc.com>
Cc: Anton Johansson <anjo@rev.ng>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Thu, 13 Jul 2023 at 17:21, Brian Cain <bcain@quicinc.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Anton Johansson <anjo@rev.ng>
> > Sent: Thursday, July 13, 2023 7:09 AM
> > To: qemu-devel@nongnu.org
> > Cc: Brian Cain <bcain@quicinc.com>; peter.maydell@linaro.org
> > Subject: [PATCH] target/hexagon/idef-parser: Remove self-assignment
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary of
> > any links or attachments, and do not enable macros.
> >
> > The self assignment is clearly useless, and @1.last_column does not have
> > to be set for an expression with only a single token, so remove it.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >  target/hexagon/idef-parser/idef-parser.y | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/idef-
> > parser/idef-parser.y
> > index cd2612eb8c..a6587f5bcc 100644
> > --- a/target/hexagon/idef-parser/idef-parser.y
> > +++ b/target/hexagon/idef-parser/idef-parser.y
> > @@ -802,7 +802,6 @@ rvalue : FAIL
> >
> >  lvalue : FAIL
> >           {
> > -             @1.last_column = @1.last_column;
> >               yyassert(c, &@1, false, "Encountered a FAIL token as lvalue.\n");
> >           }
> >         | REG
> > --
> > 2.41.0
>
> Reviewed-by: Brian Cain <bcain@quicinc.com>


Ping -- I just noticed that this patch never seems to have
made it upstream. Brian, could you pick it up?

(This fixes a Coverity issue: CID 976926.)

thanks
-- PMM

