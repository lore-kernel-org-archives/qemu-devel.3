Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8B9CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDLi-0005sL-KD; Tue, 21 Oct 2025 10:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBDLX-0005ob-QO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:28:21 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBDLP-0003pZ-Kd
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:28:19 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-88fa5974432so777620885a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761056890; x=1761661690; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOkDZIYP624hXJ84QvSPoENvTgmCF83wfkY593GGoOU=;
 b=QUdK5Stl2zYXVQPt5bFRvNrHAo4oyeSdDOkTiXrn05Pr9rNn6GY5parIxFPYQST4e0
 +gjlvrc7m3JP8//WWuOG55vLri7NDyLHBcqzwLgK/pMqENNA8BIq/zns1k7e3tEBgnAs
 5vy6laYEOHgElibV5X/UsMW3qYTpkfBq3CSqXovfOMA2cUkUjWZ7lDSeJ8pOozKdxTeN
 j8kdgD8k4EXGM6lv+oLgCiJj0W5t3lH6urGME/7kYi3eKPvqan14No6v8AqJjNR4HqjP
 rR+SsYHwAp+BjoBCJEyjqVtXkzJ67NRNi0h5cy2M0lMy6sUZ87LXU1HSs9QvVNrewU5O
 gCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056890; x=1761661690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOkDZIYP624hXJ84QvSPoENvTgmCF83wfkY593GGoOU=;
 b=JNxOgq5MC22J5qAlnecfNDZXUi0N7NHzFewdqSwslTZ6BgLsEa7YRLHdbtvrD4uOg5
 6s6uhCQFs9EE8SfFrLsbfhdGblI+5YI49Qaoaflqa11n//BuYiyJYDTXjFDlPkeqvQd4
 tZEvnBUuE4sA2TkeBHxoUM438RmuogQbnlNoaQBBGlzLEgy7lV+lbIGzRxeIdaNGdC0F
 R6JObAhMtLebvz+HQE0B1BqnbGjQwErpRbA37sM7Nv7105ITMGi3nnZNjKEkmSCImNsr
 VS2QE/nKhIdmN2gUhrvNnLX/B/ihbPB2moyqNggqz7zebBS7YYOqjjo+/olawyhzOc/r
 zVvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5H/amvC4ae6dsbL/NvB4CB+1xhiK6Wuyn3FHRC6PfyGDREX1QPU8t4ASP+c+qfiOcgF6toSWa9YTe@nongnu.org
X-Gm-Message-State: AOJu0YxA5iCJLt63JasIYHoIUCI8vnsWX0fZMcpl1aT04XwdXsAkOqwi
 03Xd+yQzxwOhtmu894JETRHRpa/WdKdc0KqcT2RGZuAfxLUA0WOcU6JEPPyEZfQC4mU5GclHSXm
 A6oNnExw6FKrWRWPNSG9sZiPszVX4ff0=
X-Gm-Gg: ASbGncvTsWgt8VadHtwHEq3LB8l+biRIDbnqhYFN/rfNZgu+6J3/LIm3y8+ARcCA7hr
 kRRQjFhSBJGu6/jNAbgHutM/BAop7VoqBqSaaVSYXgbuCl7v/eyXhoc7aB5H0F2aTWDqA3d+kFl
 fMj2r69D+gElSnlYoRLWfWae6602v7wW806ges9uHIhFWZGEGlCJRToMRi8uwYG3b6tjVZIV44H
 oBryDWwjUqvO4KbN/tciU3ZW2U8pOIrYxQ6dpTN8fOAUykyQAsD5xxUgzJy55HxFMJVnV7nwKrW
 QL1dFz96zR96PbKf
X-Google-Smtp-Source: AGHT+IGp+zf0u9SIF08iLE3a5Asq68ZbyrbibcTK8YXdD3xNkn5pXcBzDMuiMfZHuV9n++d97YerVbPf0S+nqo2EBIc=
X-Received: by 2002:a05:622a:310:b0:4d9:dea6:4ff0 with SMTP id
 d75a77b69052e-4e89d3d5924mr245955091cf.56.1761056889597; Tue, 21 Oct 2025
 07:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251021122533.721467-1-marcandre.lureau@redhat.com>
 <CAFEAcA-jPE_onLYLMxgcAOB7dWRXOLJrWcGPnR0NUdjYytPDVA@mail.gmail.com>
 <aPePcTKl6s4FoLCL@gallifrey>
 <CAJ+F1C+bGKtY6nf3LCXrwhZ2aEdu2npXJ9FapmsqgX0uLL5TUw@mail.gmail.com>
 <f764e4cf-d134-4c4d-a313-a5b7dd6620d0@linaro.org>
In-Reply-To: <f764e4cf-d134-4c4d-a313-a5b7dd6620d0@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Oct 2025 18:27:58 +0400
X-Gm-Features: AS18NWCtKDmDRRz11NBqNv3KECG8ofxt09PdE7ub3r-ykIF5WUP85WNT3b3fqdE
Message-ID: <CAJ+F1CKG1G=5o+bDBXmLm6ywWDD19z1OFBwQQnDMxMFytFQ2SQ@mail.gmail.com>
Subject: Re: [PATCH] char: rename CharBackend->CharFrontend
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Zhenwei Pi <pizhenwei@bytedance.com>, Laurent Vivier <lvivier@redhat.com>, 
 Amit Shah <amit@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, Alberto Garcia <berto@igalia.com>, 
 Thomas Huth <huth@tuxfamily.org>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Magnus Damm <magnus.damm@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Corey Minyard <minyard@acm.org>, 
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Michael Rolnik <mrolnik@gmail.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>, 
 Vijai Kumar K <vijai@behindbytes.com>, Samuel Tardieu <sam@rfc1149.net>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, Lukas Straub <lukasstraub2@web.de>, 
 "open list:Sharp SL-5500 Co..." <qemu-arm@nongnu.org>, 
 "open list:S390 SCLP-backed..." <qemu-s390x@nongnu.org>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 "open list:virtiofs" <virtio-fs@lists.linux.dev>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On Tue, Oct 21, 2025 at 6:23=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 21/10/25 15:58, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Oct 21, 2025 at 5:52=E2=80=AFPM Dr. David Alan Gilbert <dave@tr=
eblig.org> wrote:
> >>
> >> * Peter Maydell (peter.maydell@linaro.org) wrote:
> >>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >>>> The actual backend is "Chardev", CharBackend is the frontend side of=
 it,
> >>>> let's rename it for readability.
> >>>
> >>> I always thought the "frontend" was the device the guest
> >>> saw (the 16650 UART or whatever). invocation.html has bits
> >>> talking about "virtio hvc console frontend device" which
> >>> seem like they also use that terminology.
> >>>
> >>> If we want to clean up the naming it might be helpful to have
> >>> a comment somewhere documenting the different components and
> >>> what names we give them and how they fit together (or even
> >>> better, something in docs/devel/...)
> >>
> >> Or something more descriptive like 'CharGuestSide'
> >
> > If we are talking about the Chardev frontend or user, that's too
> > restrictive. We have generic stream handling code (think
> > mux/hub/tests/client/server etc) that do not fit that usage naming.
>
> Isn't it
>
> - backend -> host adapter
> - frontend -> implementation used by guest
>

Sort of, but I think it's too restrictive to name them after "host"
and "guest", as they also have different purposes than strictly VM
components/side usage.

I believe talking about backend and frontend is usually the preferred
convention.


--=20
Marc-Andr=C3=A9 Lureau

