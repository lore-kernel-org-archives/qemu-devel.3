Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8401E69E9F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQT6-0005D5-4h; Tue, 03 Dec 2024 05:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQT4-0005Cq-A4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:49:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQT2-0003sR-UU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:49:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so48165415e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733222957; x=1733827757; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wm/2BwauvWNjIOQD2FBMUioIeCAANVQtcFcubAdAhJc=;
 b=l68LAsMAEUsyA7e7ebeIq9trytIO9xhsqIpSU96kBH9Hq95d8W+xipmXgypkp/ppVP
 KDNkFvqheTcJrnPZzFa8w+NV9LwyfP1VoOYKfUEUHcgurVyEG0PX1JZ8Jyc7/MNVc6XB
 yQJqjFx/qqPyO2lsELclQt//5Cp9wIRs1s94TYJ/ysb/6plBp9QApjcdM4yCVvne5lzo
 tNiJgF3ddu8la5CguWfpBPO1gS3C8yDArgED10rC3k+PX5hpMro4J1B5x+MszFb2e5eY
 I8PM4YhshKC9MnslRF5fnwKH0KumahLK2KrTOm5JrWJAOsyYUCSp/tSMOlj2YXYwxQBN
 Tcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733222957; x=1733827757;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wm/2BwauvWNjIOQD2FBMUioIeCAANVQtcFcubAdAhJc=;
 b=k5ArjfpZ55pa6ewijtxFyjbUmAxH0KT2ejZViwf2c+1NL+XoYl2uEzemHLLoKQ1xTA
 7Myn0l6TY68yrb2oY7vpMXhJe0FqHt4EmSsPZotuedKnwi1l+X2Sw1wB2rAWoqig9UF+
 AmBfJ+d/Qo3k0msxld5yVj/56iiq9Qzx9VFMP8LEEy4BY8qzjdBKYwOK2WdmwTdZ0oyU
 vel1GE41X9Px8UfCtNww+tVNChdJLcIr0C5WywhagBTECUpc0qzHGrbZIg/JJuryU2gL
 KRJILTeENsBTAzAwvh9z/tJ9R8fFFFlvIn/wxMpsYsVznCbejjG4GmFEPkMvIiE7Z3Qf
 Wzyg==
X-Gm-Message-State: AOJu0YyxagKR+OKhtgcr3OhxEnCI0KRFmr1yZdbble43NBWKwbX3j8WJ
 c8blXqqiyrZ65cZkR6UXDwBaljCD2QdqccSosUF2L7Nt18bq55Ap
X-Gm-Gg: ASbGncsyHMO+FeeVC/k6KapgtnivMuZM2v/CurV8reF2XTk02MivuowZ2p/99Rqvf6O
 1obUl3cc46pEBYqJzkzTcTGTQ6+rHsFM/OrDjVifOsar6LXaPZzfRrbUWeGP4tqRvXRa/cG9f34
 MvCLeFoXH2PdtjmV1VAcUPzo3tkAfzL4GFQQMoeNzH+MEGlBiztTmfK34Wdo9ibouh+JnbhTAOP
 qMoaVrCqFdIp8PwtUVLIA/X6AATOvfvM0QWCIqUCHHJk5pFyNzNuxN4O8oM04UztxY9shUTZMBP
 4c2vPKGv/D+GtA==
X-Google-Smtp-Source: AGHT+IEtCjcAPmZKIJm8xKynr2bQyQYlw61/dLlfVqOh8vRANBiZLeFf2Xis2zzpRaJ5IjU4Fz1QFg==
X-Received: by 2002:a05:600c:3550:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-434d0a0ece4mr13471075e9.28.1733222956978; 
 Tue, 03 Dec 2024 02:49:16 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d05b4909sm11472845e9.2.2024.12.03.02.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 02:49:16 -0800 (PST)
Date: Tue, 3 Dec 2024 10:49:15 +0000
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/2] Misc OpenRISC fixes for 9.2.0
Message-ID: <Z07iK13dCn7iJwSt@antec>
References: <20241201070955.223360-1-shorne@gmail.com>
 <CAFEAcA_mACDyLcr+ZDO5xVW9Od0Vh4K_yBeC31YnsnZ9z=1upg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_mACDyLcr+ZDO5xVW9Od0Vh4K_yBeC31YnsnZ9z=1upg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Dec 02, 2024 at 04:54:11PM +0000, Peter Maydell wrote:
> On Sun, 1 Dec 2024 at 07:11, Stafford Horne <shorne@gmail.com> wrote:
> >
> > This series has 2 fixes for OpenRISC that came in over that past few months.
> >
> > Since v1:
> >  - Use DIVIDE_ROUND_UP instead of open coding as pointed out by Richard
> >  - Fix off-by-1 bug in TTCR patch pointed out by Richard
> >  - Fix commit message and reverse registration order as pointed out by Peter.
> >
> > Ahmad Fatoum (1):
> >   hw/openrisc/openrisc_sim: keep serial@90000000 as default
> >
> > Joel Holdsworth (1):
> >   hw/openrisc: Fixed undercounting of TTCR in continuous mode
> 
> Note that since rc3 is due to be tagged tomorrow, fixes
> targeting 9.2 need to be in a pullreq on the list by
> Tuesday lunchtime-ish UK time (or if not possible, at least
> let me know something is going to be late arriving).

Hi Peter,

Thanks for the heads up.  I don't keep track of the schedule so this is helpful.
I will try to get my v3 series posted and the followup GIT PULL right now.

I am based in UK so there is a bit of a clash with my normal working hours, so
trying to get this taken care of on my coffee break.

-Stafford

