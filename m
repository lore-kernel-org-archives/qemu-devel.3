Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449DCCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBp1-0002LK-Fv; Tue, 21 Oct 2025 08:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBBos-0002Kk-Bz
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:50:32 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBBop-0007oY-O5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:50:30 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-88f8f346c2cso807432785a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761051025; x=1761655825; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zl0245IK2GF+7h1re7WVBDXaXhr/dNqDllLhljoKa5M=;
 b=QajVv6f9a7qjcPR+RjLQJn3jfwVqOXgjMwr4D9++OcJ1wFpdGYmCUO0RBqFEaSXS7U
 V3IBhgIH/v2X+8ytXBpu8998r+uVoXJj59ZTUHK7lRXAds5a98QER9+lmtOAUlu1wdHS
 Rl1FFH/poqZLL5jRE37QgK6pwchy3ZnsE2O4+oHxWAt6wu8orfUCOP6h6sDwQuUVwHxY
 il39WmhOTbzqEmbQgB1xiMpuQilEFD8RbxB7Lpl+tuns7X6XHIQYqPFc+feI3FHn+ORD
 ItBZiQupRrGEcglhZSJF18VigRKRUJT9i4lVzOImeinbAs4pOH/8RmozZBfkM3LeeryD
 L8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051025; x=1761655825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zl0245IK2GF+7h1re7WVBDXaXhr/dNqDllLhljoKa5M=;
 b=G8JsNwtfBdrduK6O0gUuip4lxjMkV36CXgJwQQ0SFFZOu2cQdLiYmuCDvpPuMAQVhq
 7B8HmuKQkrmt08Z1nEXnkXszHqdsrCWMcO6TUK8FYsRVBph1kv//34nh1VE8DB/HrrDn
 hcBvX6RT6Px2+ychnwpAtoQg6xjHWYT6sbH5zak7o35nj0fP3SlX/rI9yGPdNXC8ZO73
 ocewewc51nzsn0bnI1fmGOWEqrx0bS2o2j8SJb2TjGOCXtWuC4puka+2BxC67AjQk5/i
 pMm3wkW2Vm0BGmAipZ2dJTX09HjJXhjPFYAIxdnHft6gagVsW0/fW8x3pUgI026hbdWP
 utuA==
X-Gm-Message-State: AOJu0YzMkx0yHQG0FORzxTkDgj/oqOCoD64I/5CJFCcyK4XRBTfpifVA
 R0NzP832ais8Olaev+UqP0kocVvdK+1qseTEf+fhLGROfA3yHtohcVFc+D6ctaDuQKwwGjqFFhG
 vVUL0zzKXQQLgsW8+2pkIFels+hQtSvM=
X-Gm-Gg: ASbGnctEQkIo8Sr/dgPMOhbIGE1+GD0DKkfcPrRKJb3ozQTv3VunZ4B7BczX7hggiC4
 xI2ODlhx0fc6bLns19VZWz4VSQembya+FTgVgjCqBWh4PvvpkXUmVm9OdpH9ORY0oz3LNVxJSGC
 LbBRlh0I5NXneoMoS3YufLyplb3tklXdgbPUrT0uHoy8PctvWzSo3vaVo5emnh2nlUouIA7qF2t
 0JaDRq9R0EndoFePFPmcvOCiG2SDCjaElU5Hxp3o/LDXBVgTXyCWsn6thcmiLtHqbOkg/AA0DEy
 c05fJwNsc/wWqv/A3RecFD/C+RY=
X-Google-Smtp-Source: AGHT+IGy54k8deJ/RF2YJODfqE4tqhnzOVgVuNTCD7KgXFjj5vCLzq+QpBp/ROGZfemhru8/sJVoXYZ0Yq0ZZYDPMXc=
X-Received: by 2002:a05:620a:4621:b0:850:4384:d1b1 with SMTP id
 af79cd13be357-8906ea9b4d0mr1600850085a.4.1761051025457; Tue, 21 Oct 2025
 05:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-35-marcandre.lureau@redhat.com>
 <1bd34160-d034-465b-a1ac-0e734ed40484@redhat.com>
 <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
 <CAJ+F1CLoaufD_1tFUd_1uckWZLXVQ7E-GpRDZRDXtfi6unBw7A@mail.gmail.com>
 <32170b83-473c-4eb8-96dc-9180c51fe872@redhat.com>
In-Reply-To: <32170b83-473c-4eb8-96dc-9180c51fe872@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Oct 2025 16:50:14 +0400
X-Gm-Features: AS18NWD7VxK2uwz0vMnZyiqbVVMtLGKfyXghjMeC1snVrynyw--Vq65KYBWcOgc
Message-ID: <CAJ+F1CKoi5iYZHTxMWKUtx=kRbW2BjtoAzMVGLe8by0Dnmb+KQ@mail.gmail.com>
Subject: Re: [PATCH 34/43] audio: rename AudioState -> AudioBE
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
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

Hi

On Tue, Oct 21, 2025 at 2:49=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 10/21/25 12:40, Marc-Andr=C3=A9 Lureau wrote:
> >>> BE and FE aren't used in existing code though.  Looking at current us=
e:
> >
> > There is a top-level backends/ though. I meant to say that it's
> > usually clearer for everyone when we talk about "backend" vs
> > "frontend" (or not?), and I wish we would follow that naming more in
> > the code.
>
> Yes, but the front-end should have a *pointer* to a backend.
>
> >>> - BlockDriverState*/BlockBackend*
> >
> > I am not very familiar with the block subsystem, but it is seems
> > BlockBackend is actually the backend and BlockDriverState is
> > implementation data detail. Correct me if I'm wrong
>
> Yes, note the "*".  What I meant above is "the frontend has a
> BlockBackend*, which itself has the internal BlockDriverState*".  Same
> for character and NICs below.
>
> >>> - Chardev*/CharBackend
> >>>
> >
> > Those are actually always confusing... and I remember I attempted to
> > rename it in the past... CharBackend is the front-end side..
>
> Yes, they are confusing.  I'm not sure why it failed, but
> s/CharBackend/CharFrontend/ does get my vote.
>
> >> QEMUSoundCard's name field is basically unused, and QEMUSoundCard shou=
ld
> >> be just an Audiodev*.  There's no need for a separate AudioFE struct.
> >
> > For audio, it's pretty obvious that we have "backend" object to
> > implement the host audio subsystem details, while "QEMUSoundCard" is
> > the "frontend", or "client/user" context.
>
> I agree, but unlike character devices, QEMUSoundCard is not needed at
> all.  So you can drop it and only leave Audiodev*, or AudioBackend* (but
> I prefer Audiodev* which matches both the option name and Chardev*).
>

I see, I'll try to remove QEMUSoundCard.

AudioState can't easily be renamed to "Audiodev" though, since that's
the QAPI type name. There are slight typename differences between QAPI
types for chardev and audiodev. Is it breaking QMP APIs to change
typenames? I guess not, I might be wrong. However, this will likely
break external code generators based on QAPI (qapi-rs etc)..

--=20
Marc-Andr=C3=A9 Lureau

