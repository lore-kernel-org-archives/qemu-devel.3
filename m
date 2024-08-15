Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191E3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYsT-0007li-T8; Thu, 15 Aug 2024 07:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seYsR-0007kv-MU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:47 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1seYsP-0002CZ-UX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:47 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52f025ab3a7so1122398e87.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722164; x=1724326964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YraZGJ9bJr3ONnmuBTPkzJUV2p5ou6G6xUlSy78rDf8=;
 b=Ha268RC/nbCamBmzUQemSFSSvdVmijfUYjoM3KrbL4rILZwizgAn5p36oEYt/e/Cbs
 E9PPgqOP8dbqCAlddqvvzZyqqeZXzCyuVCgaJ6YQ+dkE37+HS7VsHc0luuSY7g3+ZvHR
 RpiHvoprFekeywPhkakpxTD9OlP6LOlAwUZT3pJCn9NbRMVAIDCic0T7bmFM/aeJD24a
 LV2u8OY/b7MxKFYXV8xv4DrqgqcsoASYg1tMsQ1rrIYwxhfYxPLGyLkesax0UH0Oc+6e
 NMaEN8lGQXHOss74Lr2cjbqmkBWxZmp6+dsP3sq2CouxvY13IyS091WUnWna9PG3p/ty
 R/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722164; x=1724326964;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YraZGJ9bJr3ONnmuBTPkzJUV2p5ou6G6xUlSy78rDf8=;
 b=Gmq/nYsnXLt5MiN0G1inPW/dHix8eszwjbQ1QeKOr8lg0gQcZ9fGdIRLJCYwTelvTZ
 Ht98I9alxg1FfNL7zOLqEB9Lcw1xsYVMmoAnzPx7McoHZFaJg8cTTcl1ml1zJSQxFiqk
 OxboFu6R9kqU0QDY5C8ln0lZdtKYdsRJUZEsTz11XrSXA1nFKXwjII/nQn2xiV9ttlzg
 LlfNiibbZAh0Foxi+Fkz7IXf074a6cwCk12W6CISABMhikDpb9kJDrkVwszeh8tENhr/
 N4shhICftMo4nXCU8rcZYDi9M/QfxnMUzo8Jy4Z8YmcxudzI9xTGoHW4R6EI6dfoy8bD
 Eiag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa+VJghdLbGI0sC+i8miLJnGMIUHv35ocdPld/ydRooDBdlc+qgHg75TQbLHO6mkTTY80i2dYIOP4m@nongnu.org
X-Gm-Message-State: AOJu0YxTb5W9B2Rpz1IVyVWJe6AXi2VEIjtM2wEimVCxZVOjL1FXuTvU
 B4YfdSUX/x1XtkhQrqaU59+pLneS/M/acW3CO+e5vRKgTpig0JSQou0WN1tfw6Y=
X-Google-Smtp-Source: AGHT+IFT13DNS+3kg9UcIuGDMqYgKU7AOrfp3pff4jCyTU6dRD71sfdy/v41514fk8sgKbi0whPhaQ==
X-Received: by 2002:a05:6512:2216:b0:52c:cc2e:1c45 with SMTP id
 2adb3069b0e04-532eda6bda2mr3636529e87.15.1723722163660; 
 Thu, 15 Aug 2024 04:42:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839464ebsm87914866b.155.2024.08.15.04.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEA1E5F8E4;
 Thu, 15 Aug 2024 12:42:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Thomas Huth
 <thuth@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
In-Reply-To: <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 15 Aug 2024 08:00:00 +0200")
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
Date: Thu, 15 Aug 2024 12:42:41 +0100
Message-ID: <87y14y2ery.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Thu, Aug 15, 2024 at 1:37=E2=80=AFAM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> Contrib plugins have been built out of tree so far, thanks to a Makefile.
>> However, it is quite inconvenient for maintenance, as we may break them,
>> especially for specific architectures.
>>
>> First patches are fixing warnings for existing plugins, then we add meson
>> support, and finally, we remove Makefile for contrib/plugins.
>>
>> Based on the proposal of Anton Kochkov on associated gitlab issue.
>> Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
>
> Is the bug actually still there?
>
> The Makefile explains why it was done this way:
>
> # This Makefile example is fairly independent from the main makefile
> # so users can take and adapt it for their build. We only really
> # include config-host.mak so we don't have to repeat probing for
> # programs that the main configure has already done for us.
>
> In other words we should also take into account that there is a
> documentation benefit to having a Makefile that works across Windows,
> Darwin and generic ELF Unices. Anyway Philippe, Akihiko and Alex are
> the best people to decide.

We could keep the Makefile as an example but the meson file looks fairly
easy to read. However it keeps growing warts to adapt to the fact its
not integrated with the wider project.

> One argument from moving contrib/plugins to meson is that the Windows
> case depends on libqemu_plugin_api.a which is built with meson(*);
> that said, libqemu_plugin_api.a should be installed - which would
> justify it being used from an "external" makefile.
>
> Paolo
>
> (*) by the way,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

