Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE54C3ABD2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUgx-0004oy-MV; Tue, 17 Sep 2024 05:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqUgv-0004mo-Uk
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:40:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqUgu-0006ub-8h
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:40:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so6965816a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726566010; x=1727170810; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcwpRtt1+Ds3KwlSF38JVJVBrJu4VTvKRsmKU20Kw0M=;
 b=EW3zIAdwnlHvUNokmE6D6jpnnAbBJn9Ujaw+dU2xDVF1QPulw7XKdLR86iV5IIGG2O
 AiA+0McXDj8UFTLphdMCC5QHwGbvgiJWAuM+S+Dv9uQIURgEpErWJR4wzFZVx0UxzCtk
 kGsQRbT/egAiYoAJVfn/xD5FIPxiwlL8EYIMzVjuj/1OGo2aDN6glFRzDJ4E8gAErMJ2
 kHJqCPNMmi7YDY6hwZUwe3sw1fB33v0xE2HvQJDlnb+IPZeR6Q2jIRlgdz+8xt5JBOdn
 MOPVErUaSmQ8d0giCTi9IFvHE99V2NaG1sPSAfjpI/3DXVEa+sfNixBuKLOr4ZGJ8DAs
 QM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726566010; x=1727170810;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcwpRtt1+Ds3KwlSF38JVJVBrJu4VTvKRsmKU20Kw0M=;
 b=D/jilwz0oEZMc58S4DaShzeX0paS6FHT9xtNOhvC5a2nmrzZ1TqxmA6biinWkbr4QP
 0Z9QDzHNluRMKS7Xrj4C3wmMmQD7QHspB5nXExfPr5efiA+n5KHxTUYlpt5C/VjkEktc
 MgWAjB+UdbVdEbkDUrNt5SzX6XXrPBGraxiO6XHlBbsWpECT5tjhHfJUDd8SnT8S6W70
 1hb5qXBnagBfaGzIA2OfCWKPdyGHDXGvPI8dU5W8LK2l8/gB7mlxia4ua7Ovnu5RWfws
 CzU6rGiezBRdqBydRpHGojiCu92LLIh4yfhfcf7BdOEiM52uaYwsd+EOwDiAc66Bd/ZF
 HKsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLxvfL/V7jZ5xyH+z1FXocMqBnx2ret16On9snn6ZtyEszvH53akC347OWYvaQ4mUiZXyyNaH5bE+O@nongnu.org
X-Gm-Message-State: AOJu0Yzd/O/l/yToJ+mwEAIjh6sXO1uBzDuZguCYd/Xy5GUhffNQhSon
 3Vf0uUL4RQbkGyvXooZgXM12K58wX9ibDiaxEmuABfw8pTSTVj610kZ70anL2ksGh8SiQ25b5LW
 U2c99WKTsTXCmNmItrfh6XZ2dre+avNY2ssfqMQ==
X-Google-Smtp-Source: AGHT+IEVGii+uHQRlzUgRZOQf97m1MqlJKDH3wrqcGoANl5JYntRoxj2mFSYoWWUtMwoW+/CBk9/LSd0C5VET95xdsI=
X-Received: by 2002:a05:6402:34c7:b0:5c2:6c2d:3fb3 with SMTP id
 4fb4d7f45d1cf-5c413e5ed94mr13515652a12.36.1726566009804; Tue, 17 Sep 2024
 02:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240915125725.33099-1-ines.varhol@telecom-paris.fr>
 <10b98c97-ff2a-430f-ab76-66cc5948b0f8@tls.msk.ru>
In-Reply-To: <10b98c97-ff2a-430f-ab76-66cc5948b0f8@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 10:39:56 +0100
Message-ID: <CAFEAcA_xsqUbCcgstwJWmF2uUWJGskZ04r6dNkiNpQPYbrMg2w@mail.gmail.com>
Subject: Re: [PATCH] hw/display: Fix mirrored output in dm163
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 17 Sept 2024 at 10:11, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 15.09.2024 15:57, In=C3=A8s Varhol wrote:
> > DM163 is an emulated 8x8 LED matrix. This commit flips the image
> > horizontally so it's rendered the same way as on the hardware.
>
> Picked this one up for trivial-patches, as it is, -
> I've no idea if it is correct or not :)
>
> This is an interesting device, I wonder if it is used by anyone?

The device is used by the Arm b-l475e-iot01a board.

thanks
-- PMM

