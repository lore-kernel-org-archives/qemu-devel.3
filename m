Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC90BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFED-00018t-MT; Mon, 15 Jul 2024 02:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTFEB-00015i-Jj; Mon, 15 Jul 2024 02:30:27 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTFEA-0008VH-34; Mon, 15 Jul 2024 02:30:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fbc0a1494dso22599145ad.3; 
 Sun, 14 Jul 2024 23:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721025024; x=1721629824; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPcFtUwjn08CIhdLjhuQj730r0v8eBXex0TsGGwmZuE=;
 b=j/brKHFfwIem1OgwdOJ2Tx2ybkLOQtjbMYi0UFgG5eDht9/hQODVs7T3F7gjzw/6gM
 U/plDzNAQLxBpGV/90+JVhTUp+7y6AFk79FskDMGDSoVRuJQ7CPtAYGlziBpvfQsHY5M
 v1zsl0K5s6b+QGWLDiYtI2OPRM6vrOwnm72ADu4Pa5gXjW1+2AJghojQIWlz58ikr9aT
 ZKau6V+Ujkm1iKclNN0LlnDIx2/2TzT+Y+2Qb1O29sJsm2od+K6YOWDuXyQaG6WvtDhj
 ojkk+DMZHGApA7sarchsUSAOtTxjUuseVfS6aJvbv7LVQaSaTCPYkkZzP9SxYFf3IEne
 M7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721025024; x=1721629824;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kPcFtUwjn08CIhdLjhuQj730r0v8eBXex0TsGGwmZuE=;
 b=O7pmfZOa0bKvtAJ/UUeykifhjzAc7tHp2rab0r0ZS4JDCzHdUt+pIS5MqHd0JSs2P5
 NXT19rNxLuGRFtpsVMD5W8wSK1XVpb0Hj5+ok1UC921Us9si2I+3pLrVjWcOUUvsh70f
 xBmIms3Y07ouiHtnWV5ufkcW2PKoV9bnZrh4g+PX5EWdbvV21qtrkm8syH1uHOH8tZwW
 w+IAyW5h3O3Asqv55yMvtI4qRxtmhq/oNzFj4bD/OZuHFqR517sszaBXY+cbgbiAoZ5u
 GRdCXxnfGRkqM+RM6n5qrDiUg1Er5YfhnccjCo8xbb++2RxD/w4qi/sDx0Ls2Fge37bE
 eqGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPtP8f/yu2gZ2ZeEzX7Oco6DjcKYPEjuhDZaDDGgF8jhEphZNxScUovnhNw0vjsQMD4/AQGgh6JzjFGdYAN0hhp7XGLbvGIkFcbQ2hh5YhKlTs9rjJQW7XK0E=
X-Gm-Message-State: AOJu0YzOMWBgQc8bwlex872PYArLBiU2b+rN3vr5nzE84Ez1PwyetYKs
 66eTSif3foVv7dqDYUry4CSxuzWX1BE8Nf2bOeCmGHeYxceQOUE8
X-Google-Smtp-Source: AGHT+IGgKP6oFihz3AxpNVVxAe2WRgrjWE5r6BkkF7SBLznX3T93Yh0+dy2FA3sDEbKKJb/L2Zvw2A==
X-Received: by 2002:a17:902:da89:b0:1fb:a388:38e1 with SMTP id
 d9443c01a7336-1fbb6d893bbmr124721135ad.42.1721025023610; 
 Sun, 14 Jul 2024 23:30:23 -0700 (PDT)
Received: from localhost ([1.146.120.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bc271a9sm32900515ad.172.2024.07.14.23.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:30:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 16:30:17 +1000
Message-Id: <D2PWGA4AB747.1I96QV6NN0XVQ@gmail.com>
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 03/19] ppc/pnv: Move timebase state into PnvCore
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240712120247.477133-1-npiggin@gmail.com>
 <20240712120247.477133-4-npiggin@gmail.com>
 <050c0324-0886-4848-b7eb-039578561ac1@kaod.org>
In-Reply-To: <050c0324-0886-4848-b7eb-039578561ac1@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Fri Jul 12, 2024 at 11:40 PM AEST, C=C3=A9dric Le Goater wrote:
> On 7/12/24 14:02, Nicholas Piggin wrote:
> > diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.=
c
> > index 39d397416e..52f9e6669c 100644
> > --- a/target/ppc/timebase_helper.c
> > +++ b/target/ppc/timebase_helper.c
> > @@ -19,6 +19,7 @@
> >   #include "qemu/osdep.h"
> >   #include "cpu.h"
> >   #include "hw/ppc/ppc.h"
> > +#include "hw/ppc/pnv_core.h"
>
> I am afraid this header file is pulling too much definitions for
> qemu-user. It breaks compile.

Humph, sorry I obviously wasn't testing it. I might just ifdef it for
now.

Not sure the best way to do it cleanly in the longer term , Power
specific things could go into their own helper.c file, but I don't
necessarily like to move them away from similar/related functions.

Thanks,
Nick

