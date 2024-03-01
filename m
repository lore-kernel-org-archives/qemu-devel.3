Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C31C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 10:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg01Q-0002T1-R9; Fri, 01 Mar 2024 05:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg01P-0002SF-BV
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:21:43 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg01M-000637-Fn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 05:21:42 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso2976757a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709288498; x=1709893298; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXZCdJhl+MszfFCQiqPABiD8VGtntDwPs8z8rJpPnC0=;
 b=KdznxIYKe2CmiU6dnBtJ1tznNYN0AXExs4USNIaqsK+1/4E8Tia1G9B+hsertounnJ
 kxUPBLvH9ebmUrD4upit+Y9VsNJDte2cSRo4d2nyZekz5Mh/Xz6wRFn8UsJ9JBUuWxoF
 toj7lttClaY9ghbqLfDhhleiluY5ng7/ZYXKmw2LNYMCLTcaOVUe/C18gGspat6md3jh
 GSeY/ksgHlT97eXd7/81zKBJCCqKXxU0AYuqGrw+SIIqyfDn2itBVuMhxEsQDmDmNDpx
 YDGJ1mslHmrjkmWu8GQCuiyPaMkuqlQwsabBrAhzaOXbkf8RjGFlDlTdihPUtP8VCCad
 TuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709288498; x=1709893298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXZCdJhl+MszfFCQiqPABiD8VGtntDwPs8z8rJpPnC0=;
 b=q+niX9Lvq6WG6/ecVk39Ax9HSPeSC/4Oz90lCI4Bq/nAOK5st/TGLe0hzdsxoMlWfh
 iIga6sOUvr5ql3OkEoUPhKX0MsNdN4i+t6YHATMvxXEIBnSK5EiyxBxdzoBQz7sCHikI
 iky8AMGyMJ4oPERAX9V3y1NoOqrimWMlm8akFilkc387AGb7OUtsImc4Hbix0T2akED9
 oGivi6mxeTAHiEgWVtdafgcXbMFtXJCQ3vYA6HQF3kE/0spz57AZ3apDurYLq5nLFB3B
 myTaqtPo9Q7wyDROF4fd2yU44YjO07PCy2UKp/5PxBBR0BVehhXyvi0LOvymoeb4YZgq
 JTDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqmOVwlEZOu/Vf1KvanMF/notvBhaAnTskI5SdYSTeSDVtxtqxvH9btw5lkrVOrxzMpZiuwPO1KRwn8lpam30G5RimQhA=
X-Gm-Message-State: AOJu0YybqTpPaUBlXicpq1bYPh8E+D7XCBgHWTIVCcooWNPdi0qFVsYX
 7ZAmsT6NgZnaE2AtZVCtvmK5wZM+ceqhnCPOt5s3ZzeywQ4v3LkyOYmNR9SllBxoxalYIQNqqp5
 IN2buvd+mcthw9C668OFw7PKRYiaraWOVKu2Aew==
X-Google-Smtp-Source: AGHT+IFiR/8cLElCEWLxg68JADYiOF8qvSuX7fxnwoJBKW0e+MVH4d6jV1v+VAWuPd5MWvDc4GFYoRDPVigyKbWtRwE=
X-Received: by 2002:a50:8dc5:0:b0:565:98c5:6c38 with SMTP id
 s5-20020a508dc5000000b0056598c56c38mr919784edh.7.1709288498324; Fri, 01 Mar
 2024 02:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20240228114555.192175-1-ines.varhol@telecom-paris.fr>
 <54fe3a53-5bb8-4907-94ca-817c3000048d@redhat.com>
In-Reply-To: <54fe3a53-5bb8-4907-94ca-817c3000048d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Mar 2024 10:21:27 +0000
Message-ID: <CAFEAcA8Lbqgp1d3DCp+qXz=E51CfnAp_rbA7eF7C2BivJrGGtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add device DM163 (led driver, matrix colors shield
 & display)
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Samuel Tardieu <sam@rfc1149.net>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Feb 2024 at 12:06, Thomas Huth <thuth@redhat.com> wrote:
>
> On 28/02/2024 12.31, In=C3=A8s Varhol wrote:
> > TLDR: how can I provide a test or an example?
> >
> > I've tested the display by running custom executables and
> > comparing to the result on the real board, but I don't
> > know how to test it using a QTest.

> I'd suggest to try to take a screenshot via QMP or HMP. If you need a thi=
rd
> party binary to get something on the screen, it's maybe best to write an
> avocado test instead of a qtest. See for example
> tests/avocado/machine_m68k_nextcube.py - it takes a screenshot and then
> converts the console messages from it via Tessaract to text and looks for
> the expected strings there. Alternatively, have a look at
> tests/avocado/machine_s390_ccw_virtio.py - it boots a Linux in the guest
> that writes a string into the /dev/fb0 framebuffer, then takes a screendu=
mp
> and then tries to find the string in the file. The latter could maybe als=
o
> be done via a qtest if you know how to set up the framebuffer without a
> guest kernel.

The other extremely popular approach for testing display devices
is "I looked at the screen while I was doing the development,
and it was fine" :-)

-- PMM

