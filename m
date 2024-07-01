Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B08BC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIhB-0003pT-Qh; Mon, 01 Jul 2024 11:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOIh9-0003o7-Gy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:11:55 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOIh7-0004k8-N9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:11:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57ccd1111b0so260250a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719846712; x=1720451512; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/zTOOiD/4/u55xwqGvpXQpsPKDJWiZmM0afNZYqXJM4=;
 b=aL9N6MMlvowOxqeo7u5Ubk8uFESaTHLU+W4meaP63+rrN3nlzTeDXZg8g0QCNbLz9O
 kzc3K/3pYe1k4bo+EoREKFIk47k4TybzjB7CT/UBIbN31c5bYAGqAHr8YExRGPfkkjcc
 0WZ3TU3WkA3YlR0k57Q14ramLJA9AUXU8x9C84EW8qxIEhbC+asCLMz1vOp0ynzf+6yB
 sEYwFvp0ASqIhuC4YHulQkuaPqFkEN++f8Plv5wbpPAg3/xU5286EtAq3a13qRLSJ2X2
 lHtesu27DgnGw6T4BomTIcpw1H64IwVzA/JlqomD2meBWkxEaF+zE9K1J+NsOqBxvoGv
 FaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719846712; x=1720451512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zTOOiD/4/u55xwqGvpXQpsPKDJWiZmM0afNZYqXJM4=;
 b=w0sE+JJmfCUFX+TBwwIhQI5AY3sUDXQ4a/ufdNp3IOgXeKZgcxCcNb8rBsiONzFkFM
 efln9q4Xx82WLfsjXMalFFXqpTOWSJmTAdj+vsyTphuUzeGtInSBrYwQ8Iy5yXTNSH4N
 eFXZW7HvYwHtg9MTVw80KU2ZHhV7ttVEGNckE9i0kGvs7VdAnQvXfcwo2lij5NW24Imc
 cWH6wVI2wq2peilv/oYxxAIJ6ZeWZWWjrH/u0o3ADbV3s0s6Vuf2E5s5EsOBE5QzmgCO
 m9WYwI4kg9+09XJIZfy72YJZYRfFjOeOcm2jVf6aEjuvvTZdQp4bpaZzmS1PzSWJhmqx
 fNCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrlDY/uO7mKsyYXVFQhGucQijWBOToqXapmXXBLTFEdWdCooFWkm6BOJB0jaueb+AAF86cHRjfgjqqnEX/C6kAHzkQ+1M=
X-Gm-Message-State: AOJu0YwCQUPJYO+Mk8O1mQLXEb3lO/LBN7HdZJaQ7BP+k8SC3Gwv90iK
 ItSQ3eZxBeTaRhpxct/Gx9J86hZ31OTZBAuZcMBYGKROyIkDjCRU5vCrbzN7v+XBmh8XwRVC3V9
 zb4WodMAa4ric9qqEdwoDhyfpNgcXWD4RCty78w==
X-Google-Smtp-Source: AGHT+IG/aj8/aDYC5rvTBrEvkZPIrXgOTxn8wG7VkOwiGyzuvnCP1N7jAmNzV7vilw6FiB9gI3G0M947vG+0PKIbjAc=
X-Received: by 2002:a05:6402:27d1:b0:586:f67:df29 with SMTP id
 4fb4d7f45d1cf-5879ede2658mr5629655a12.1.1719846712014; Mon, 01 Jul 2024
 08:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
 <CAFEAcA88ALQNOrdCmMV5z8mNN2hydarMwSx1P-43Hn7hEzca8A@mail.gmail.com>
 <4a83ba64-accd-41db-9d88-2c02a8ce541f@daynix.com>
 <20240701-vehement-eggplant-bison-a3c1a4@lemur>
In-Reply-To: <20240701-vehement-eggplant-bison-a3c1a4@lemur>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 16:11:40 +0100
Message-ID: <CAFEAcA9Mh3pK8tMvz595oYmGSH6QH4nfKQSv-kAPNaobgUgwSQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Drop ifdef for macOS versions older than 12.0
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 1 Jul 2024 at 16:07, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, Jul 01, 2024 at 09:00:48PM GMT, Akihiko Odaki wrote:
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > >
> > > PS: you don't need to put a signed-off-by line on the cover
> > > letter, only in the individual patches.
> >
> > I have been using b4 (https://b4.docs.kernel.org/en/latest/) these days and
> > it automatically appends Signed-off-by to the cover letter.
>
> Many subsystems use cover letters as templates for merge commits, which is why
> b4 puts the Signed-off-by there. It has no impact on subsystems that don't do
> that.

...well, except that it sends the implicit signal "this person
or tool doesn't know how QEMU's patch workflow works, maybe
check more closely", which is slightly unfortunate.

-- PMM

