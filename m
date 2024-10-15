Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE2D1F9DA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 22:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0pd5-0003Lm-Qe; Tue, 15 Oct 2024 18:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1t0pd3-0003LA-M7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:02:57 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1t0pd1-0005lk-Kp
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:02:57 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6dfff346a83so53945127b3.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1729029768; x=1729634568; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gg8LKTt/1xJtdcNkyRmFS29tbj+Y0qIhX6poY08tUA=;
 b=hJJuY2fFlefJIWxqZnRQRYRYsIBjWZm2Mskwqfb2eOl0oUPkpGGJ7/M1VGr4+YcU4c
 GRF9IU5SGPdh8a81vgiqY+B/yIz9bdsPPK7015VtgWIwcs9wJ/Ku1O1q4SldvlUVM/R4
 EsJLFfz2c3iaKVyHODHvSygd2k/M3SXiTfmKUDm8jirp9vw+wySg3iCLDo4M8cJuC2qV
 Hmb2AlulWhWiziZ03ZDyNL9IClJ7iS2NZKaKXlzjc5lZFd0+ZAf6D9HoSCaNc9eJUO0H
 vkigv4j3ehrdNY389gleMuRpUosurxY5q65yZoOqEuYco73eQnLNliqomvU0WBd25fy2
 DSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729029768; x=1729634568;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gg8LKTt/1xJtdcNkyRmFS29tbj+Y0qIhX6poY08tUA=;
 b=OeGziuWuz7F1lmLBnm6ZOUCQQ8Tjev67XLH2Fy8HJM4+u+dNYeeoRJzDOVr1yVoNzN
 ScnwEcIjhsd8A3vqRtBol79bfmOo4d9nio6YYaIbEOvaWyWLCK10FbSg4a6QLjrWQ9gT
 cIwoTnK7k3/ERsIN6B74W23FZUrA0EucI+2pviFzIO/1Ehvu7TjPE/OQRIjijvZ5rNrB
 hwv8BRoQtZzuQwbb7Hfg/9F+8akLu4zwl+ELkvbAyZMnuWihj243vsEe5ZNE/9UZPPWa
 /hQrJn85InZUk5HoEFh2hOO5HuX2h+3apzux4tA/q8mRPh7ZPeoyTG9+jGoeCF5jneZ2
 O2SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRTK+qe4dPrj8Chl2/9QualDFr/HHqZclIKQqER8rPxxMr6Tlzfg5Xuto70dJ54hAS8o3teGPxAGDL@nongnu.org
X-Gm-Message-State: AOJu0Yzub8pLMi0uDEcIcoRWB3Op3GBESTHPIyLDeB63MewK3JpPXOxb
 1vKQz9eipmkzM1wYwj4jGDHXhRyWsOChjrd20jUF8lxurhaTLPHtpd0MptvmWW+kEdvw28duRhJ
 6U94orec26O/8Kc02VJ0Htai68It/TOgJ1onpyw==
X-Google-Smtp-Source: AGHT+IFlQLYTMGta+gh5gDMI+GB10rhgWTJar7vVPGx14GplP7T+FSDB79yHThmy2aIrB1+b9TKWwwJpD9wZHi79ELY=
X-Received: by 2002:a05:690c:6704:b0:6e3:167e:c70e with SMTP id
 00721157ae682-6e347c6e807mr124734807b3.45.1729029768289; Tue, 15 Oct 2024
 15:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <ZwlTCgqjbFbJduyI@x1n>
In-Reply-To: <ZwlTCgqjbFbJduyI@x1n>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Tue, 15 Oct 2024 15:02:37 -0700
Message-ID: <CAHObMVbmQt6U_16dYG4y_9kt76fk_W+OSSe34SRmFrC0bGNOVw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 00/12] Use Intel DSA accelerator to
 offload zero page checking in multifd live migration.
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 qemu-devel@nongnu.org, Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x1134.google.com
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

On Fri, Oct 11, 2024 at 9:32=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Oct 09, 2024 at 04:45:58PM -0700, Yichen Wang wrote:
>
> The doc update is still missing under docs/, we may need that for a final
> merge.
>

I will work with Intel to prepare a doc in my next patch.

> Are you using this in production?  How it performs in real life?  What is
> the major issue to solve for you?  Is it "zero detect eats cpu too much",
> or "migration too slow", or "we're doing experiment with the new hardware=
s,
> and see how it goes if we apply it on top of migrations"?
>

Yes, we do use it in production. Our codebase is based on an old QEMU
release (5.X), so we backported the series there. The major use case
is just to accelerate the live migration, and it is currently under QA
scale testing. The main motivation is, we reserve 4 cores for all
control plane services including QEMU. While doing 2nd-scheduling
(i.e. live migration to reduce the fragmentations, and very commonly
seen on cloud providers), we realize QEMU will eat a lot of CPUs which
causes jitter and slowness on the control planes. Even though this is
not happening too frequently, we still want it to be stable. With the
help of DSA, it saves CPU while accelerates the process, so we want to
use it in production.

> There're a lot of new code added for dsa just for this optimization on ze=
ro
> page detection.  We'd better understand the major benefits, and also
> whether that's applicable to other part of qemu or migration-only.  I
> actually wonder if we're going to support enqcmd whether migration is the
> best starting point (rather than other places where we emulate tons of
> devices, and maybe some backends can speedup IOs with enqcmd in some
> form?).. but it's more of a pure question.
>

I tried to put most of the code in dsa.c and do minimum changes on all
other files. Even in dsa.c, it has the abstraction for "submit task",
and the implementation of "submit a buffer_zero task". I think this is
the best I can think of. I am open to suggestions of how we can help
to move this forward. :)

> Thanks,
>
> --
> Peter Xu
>

