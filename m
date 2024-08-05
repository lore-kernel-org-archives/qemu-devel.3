Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29869C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 22:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb6dJ-0002CG-Rj; Mon, 05 Aug 2024 18:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb6dG-0002AZ-7O; Mon, 05 Aug 2024 18:56:50 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sb6dE-0005iR-Dt; Mon, 05 Aug 2024 18:56:49 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso18044a12.2; 
 Mon, 05 Aug 2024 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722898606; x=1723503406; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAypq0cvaaxTr4rAIa6CPIgNCbq6t9PnXz+V01OKgeo=;
 b=TpdcyP7X8L9J7ME0EF2AwhBMU+zBdIA0B+3wQ2C9mUYnenkOmpM+pKZc+GGo0IP0Tn
 pnT1iCXVYdkIJD7r0W5VQzOaWgRZpdR2H2aMG4qS0sceyn7Emlb1eP1bjXfE6ZREhLi5
 463c4XbAf1eMqi1yzsDNiklB416DFcuGHuHS4SUMPZPhTNtkItTi7l3KYzBvqjL2C/JZ
 a/dScZczt6GMQXXC8ysFl0XPkN+JwiiWkeJCAWIxbnulN+huhA2thZZ8L0O7C9ip0+zK
 UVaE2eB/PbtdB8DuXS1BYKIwdsol/JIVXRlcQNGYkQC3rH273VUF+qABI1V8AFKpg2v6
 zbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722898606; x=1723503406;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JAypq0cvaaxTr4rAIa6CPIgNCbq6t9PnXz+V01OKgeo=;
 b=l2TY578DeIMNBs2dGFhvTn9ntNhrAHebCzXy/YRC3kUeehBs2os2d/Vz4LD4eH63qE
 lLu2+/xsJEpFTLcmRW8aY+tCfmvFDHdylAETsUv93M2MSBk+u9KNa54zar5ajJxq0vei
 PWeK4HXP2xxWhZgYXvCLGPp2Kcm1t1roC+fS3TaVZZDrsS7XysJxUHbnfaimc6mi9d+o
 8lwsV2mJNoWokmmFgkTf9P1Dwq5NeFiSuHz5VrszOr5nQrugAIJqEIVTBqqVQRwX1mbu
 kxh6Z4tPyamy7BliwjwQBt1jNDEKgbnMVKgWg0fg6OlZ4v9Oq9Ie01IdyYhUpI53akJI
 y+ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCW09RyRB5Og79LBdSnfrA6DffXtBHZ75D/WsRmG3jLuwQI0i73j8w+uUgDROf5CDSsB19NWyApvG4XG@nongnu.org,
 AJvYcCWCAErKk/sig0pOdmURlT5HzMtjMydth0UeA9gjj2NzaA+9l0j4j78lyL6v9y/tG+etPgRFvDKywFc=@nongnu.org
X-Gm-Message-State: AOJu0YwcMa0ARumbdZAb0mvt/LzztcwuYs24Hb+jWRLYW53GRYmDYyPW
 ZEoSSjkiRp/sJbr0nedhujHa5GyR/3Sjq+gDK7GYgKljlVrvu+lD
X-Google-Smtp-Source: AGHT+IFYybzQnC87k29DkP5SdJgoYftZjvw8s5GrR/DYJ+w10I7eTnAmSpWO2oK6flLvcmVtWyMOug==
X-Received: by 2002:a05:6a20:c997:b0:1c2:9554:fd07 with SMTP id
 adf61e73a8af0-1c6995551f0mr15834577637.1.1722898605554; 
 Mon, 05 Aug 2024 15:56:45 -0700 (PDT)
Received: from localhost ([1.145.206.202]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b76346d931sm5931394a12.28.2024.08.05.15.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 15:56:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Aug 2024 08:56:40 +1000
Message-Id: <D38CKY8VZYDW.6M3KDSQTX0VZ@gmail.com>
Subject: Re: u-boot-sam460ex fixes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "QEMU Developers"
 <qemu-devel@nongnu.org>, "QEMU PowerPC" <qemu-ppc@nongnu.org>, "BALATON
 Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.18.2
References: <142f2839-578c-4dc5-a837-ffacdc18d8c4@tls.msk.ru>
In-Reply-To: <142f2839-578c-4dc5-a837-ffacdc18d8c4@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

On Sat Aug 3, 2024 at 6:40 PM AEST, Michael Tokarev wrote:
> Hi!
>
> It's been a long time since everyone's fighting with u-boot-sam460ex code=
 which is
> very bad, suffers from countless issues.
>
> For one, it does not compile for quite a long time with current compilers=
.
>
> For example, here are changes which I apply to this code when building th=
ings on
> Debian: https://salsa.debian.org/qemu-team/qemu/-/tree/master/debian/patc=
hes/
> (see u-boot-sam460ex-* files in there).  I just created another patch,
> u-boot-sam460ex-build.patch, to address numerous new issues revealed by g=
cc-14
> and its new defaults in Debian.
>
> Please note that most of the last patch are actually just workarounds, no=
t real
> fixes, - real fixes needs much more than that.
>
> For example, there are a LOT of *conflicting* function declarations in .c=
 files
> where the functions are being used, instead of writing them in a common .=
h file
> and including in both users and where it's defined.
>
> There are a lot of free conversions between pointer and integer. Some of =
the
> functions almost always used with a pointer but expects an integer, or vi=
se
> versa.
>
> This code is awful.
>
> But.
>
> Can at least this minimal set of changes be comitted, to let this source =
to
> be compiled at least somehow?  For the benefit of everyone.
>
> The last patch (-build) also fixes a real bug:
>
>   	char arr[8] =3D { 0 };
> -	i2c_write(0x68, 0x08, 1, &arr, 8);
> +	i2c_write(0x68, 0x08, 1, arr, 8);

Not sure about u-boot. Have you tried to get the patches upstreamed?

Thanks,
Nick

