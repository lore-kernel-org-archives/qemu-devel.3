Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E2D0BB5B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 04:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3pWt-0006hI-Bg; Thu, 24 Oct 2024 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t3pWr-0006gy-5z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 00:32:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1t3pWn-0006lo-Qn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 00:32:56 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9abe139088so57996566b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 21:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1729744371; x=1730349171; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zYwcK6UaKCWjz/iydUwDAr6ukpMricO8db6Oq8G9d20=;
 b=ZNZoZuYXQRyDJsn3RukoHpqp95pxNKp+j4tzPEBQlT1IEqb3wfO45pvV951QSua/t1
 idqx4zgZLbb6AC1h4AHgbOSp8BEoqmHb59kBpuNvKKXisq2nct/OdZgvcpxS0Pypvjhf
 PCKr7xoQVnQru+yIe4ZZw37tlzEoVjKI07dcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729744371; x=1730349171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYwcK6UaKCWjz/iydUwDAr6ukpMricO8db6Oq8G9d20=;
 b=EjCL/ZbhbFwiiOTv6+KSsZktJDjKVXi6R+PJuDcx1HfX/pteoTRQzf0cUe9r0mu2BA
 ZQ5nLZKjd2hlGIwoeQ6QQLtAXSWRBET3pTNkd6FLCZp0HKy3E/kHfhhkyCqX6AQVzJ4o
 72cnfXsxVe992hNKG8mIlpavbOWi2MGt7leeKlP7wDOgynDmrZDTufk2Yy7ORogG4sKj
 QdSxvKNlv8cwUjxTTmPACs3eVKFCKuPGRIcG/3P3DbbPidb+DiHZn8rSN34uY4CJniY4
 KZB0Yog4eZBWYt7ZZJ7IMCWTBf/oIj1d4dpmDlyuENtZV4xyMFojqQT0hyHBcyyjt5KC
 lTTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5oiAhyAVyPVJcAbo4FGV9ddcSynk5rPEIYX/qlO/4iKJTgw7rJjWFociZgV4RNiju/SkJ6bng1/6d@nongnu.org
X-Gm-Message-State: AOJu0YwptC5prYSzU9JTotRstWZAMefiHgh1AZp5NihPTb942qxGKTse
 n55IRQpkSu23KvUWi1cibH68PsWW/+9OBW1sJRVByH3PjExZ55qRf5P5CyvqRuSMk98m+YQBO+X
 06ciKqIjhGx6DzqQptPeGa56Llmo=
X-Google-Smtp-Source: AGHT+IHWA46ZexMdlXj0rvfCpTj918vm0GFVs6viy6I6aC2KDtdWzaaT3GHYFvLvTO7VUA/oFl4BQYrvZqGf4w2mmaw=
X-Received: by 2002:a17:907:72d5:b0:a9a:bed:e564 with SMTP id
 a640c23a62f3a-a9ad2816383mr56610166b.48.1729744371246; Wed, 23 Oct 2024
 21:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241011053825.361544-1-clg@redhat.com>
 <eff3385f-6d43-42e7-8b36-7225e2fee7df@redhat.com>
 <SI2PR06MB50412DF87611BDBC21003BF6FC452@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CACPK8XfB=tfSBnPVUjJgAR23W3GXS_hxMiamPJT=7qL5Pgw8zQ@mail.gmail.com>
 <f7a8c0ed-27d2-4a0b-af2a-30f427812896@redhat.com>
 <CACPK8XdM-RrT4wJFEokD+mbYU_vus_Pwoq9kiUwpQbdM9WLVWA@mail.gmail.com>
 <b54e4ef3-2619-4c5a-960b-f57c4028e72c@redhat.com>
 <SI2PR06MB504160BC5547E56C9C108077FC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB504160BC5547E56C9C108077FC4D2@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 24 Oct 2024 15:02:38 +1030
Message-ID: <CACPK8Xe7NuLvXXfJevz9930mUQWuqY7PaK6Od=NjYC1qvH5aRA@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/aspeed_hace: Fix SG Accumulative hashing
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 "kris.conklin@seagate.com" <kris.conklin@seagate.com>, 
 "jonathan.henze@seagate.com" <jonathan.henze@seagate.com>, 
 "evan.burgess@seagate.com" <evan.burgess@seagate.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Alejandro Zeise <alejandro.zeise@seagate.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.17,
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

On Wed, 23 Oct 2024 at 19:50, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> > > Someone (aspeed?) should take a todo to resolve the HACE situation in
> > u-boot.
> >
> > I will build a br2 image with upstream u-boot. The ones we use for tests have
> > an OpenBMC u-boot IIRC.
> >
>
> I used ASPEED FORKED OpenBMC pre-built image and hardware hash engine was enabled by default with u-boot hash command.
> https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.03/ast2600-default-obmc.tar.gz
> https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2019.04/arch/arm/mach-aspeed/ast2600/spl.c#L46
> I added "printf" in "do_hash_operation" function and ensure this function was called in HACE model.

Thanks for clarifying Jamin.

It would be great if these u-boot changes could be submitted to mainline u-boot.

Cheers,

Joel

