Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD00CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe2C-0000ri-Mo; Wed, 20 Aug 2025 04:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoe2A-0000rJ-Rn; Wed, 20 Aug 2025 04:19:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoe29-0007to-8u; Wed, 20 Aug 2025 04:19:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24456f3f669so8055905ad.1; 
 Wed, 20 Aug 2025 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755677937; x=1756282737; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dlFZ/zbWWVV5xnLjqaKAPyHKBgFzyQX+1VIxCOmD+qw=;
 b=DNILvaYA3YeywSDxCq8+P+TrMYF7g+RntxQjqhzM3ZAmdIU3i4wjdNk/9LzL6VRkwS
 h3EFrkloaPnB3eNTGf4xTOKYz7/+N1oizTliHo4dmNqRbrrAQvn52u4oQenYHq+GI6O2
 zu6iAlB8ERcynJcK/YBGNOuFKYDn9dSuNWRnjs/X4vv0Ff+L8KG9VFSA0je8hKE5+q/F
 3POyfwndvSZIs72UAl8E8PhD1oBGB8YHGtVBrbtr1rdk7b49k/y3Cw5eIWvZq8yUirSm
 Y21SLzCNtyTKNx9Ps0ATLNbGjHRZ9aZwZfeitVLMSGFc1wH+5QaChPzPa2FvpMyE29fT
 AIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755677937; x=1756282737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dlFZ/zbWWVV5xnLjqaKAPyHKBgFzyQX+1VIxCOmD+qw=;
 b=WyNfJocCwpKsTpJgBnREWvUkZlETavfJ7D3GbB/LQgk1R12TrjqmcstiSinq9hdAPF
 YjhCjauw4OCBrriB3dJndgtBqQuH/pT0jEKcCmlqOLyU6QieIqJdO27McJTve/mmK8d4
 l/aDeVNAgD7nYir6s1/lzourh+zYIPnWfmBByebXz6P8VILGN1EC/a612mPHmwc6GhqF
 h2x85LQzpTPv5JQ4xvLr6zuv8wMa/td1Iia9ciZFG6kxDx3Fk1m9VKJwdUjl+3ceSFYv
 XIDS9HivGyPPMEnQnZmorhkaeAeL+ql4BxofY2XX/j69FCq3VcFwZKu26oGkPE50Urnf
 Wrcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0hiLzUQh6bXgnSopS/2CGt3Wlc5OJhlfDd41wRqqeZPkGU6HMNlpdeYaAwtV7Hav6eaduXliwSeIVog==@nongnu.org,
 AJvYcCWl1Phx1ng3wsnlkQQ4u/jD76xcVImPk2fIoZE+B+uXLZ6X/9t2ZaDeBVVoOFgtj0uo/6bTqPUmLw==@nongnu.org,
 AJvYcCXplV0auErHBgZEc1jHhh224jrQXkkygDgflBxJFq0q8/OSP1fNBf8YbCaAWO2y3lEevu6PVzAxI4pe8w==@nongnu.org
X-Gm-Message-State: AOJu0YzarrjvNftgiERDilWKxei4JebLUi0Z/r4+PRBtodP/XzR7Kq95
 nYXiAoM+Mr+aCwHC8QP0X5LoMg3F1m/ISS7MoQ9OQ6+DVmre7frEPgX8efEFoVEVoZQu8SY67bX
 mRF7PoSQJcDn/5UaBkcl6qGiTxorQug4=
X-Gm-Gg: ASbGncv5sJ/C6eQ+96qwV1lzh+VLjrlJ0+k0btgaxXkKyt8KpSD4cBSeJ5bR6g/07/L
 aYElBsmlcTKdvw5VrTL65lY9UpodEhRVYeweyjeVPXcSf+3SuP9o8vNVma8/ZnqNnc4uED3M98x
 XDGGAcHaYL8DrYCK0yGT1ogeRdDiJrHWCwgRSZ1R9lggIK6P7Va2AYmYJYAH/MqskhjN1f6DJiU
 nNmFYAv3DtSfeYG0a2uqL4krH61x52j0Nh6I2e9GiqWEM/3fk60ndkR6W0=
X-Google-Smtp-Source: AGHT+IEDwQvJXRH8dMOFx+/LEJGJKbx9Q2E/2AN2g1g/ErWejmyJHtPwuD2LsqS/fW+ag85ekPm4RrmBBvyfCGjRk4U=
X-Received: by 2002:a17:902:e751:b0:242:c66f:9f62 with SMTP id
 d9443c01a7336-245ee194c5emr29895235ad.26.1755677937006; Wed, 20 Aug 2025
 01:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <630c91852939acf3c7fdd95c37b363fa5d4e60fd.1755623521.git.ktokunaga.mail@gmail.com>
 <fa2566d9-0102-4de0-aa33-18154c623d56@linaro.org>
In-Reply-To: <fa2566d9-0102-4de0-aa33-18154c623d56@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 20 Aug 2025 17:18:45 +0900
X-Gm-Features: Ac12FXzrGVb06YV0isx8qyr0HPFVKHhab70U6J5hRQM66Ng0Hsa0Dpg68RlD440
Message-ID: <CAEDrbUbLEtbSWH19Uiz4h+Mx6YY1c89Wdzd3pLuDMzsR8t2XZQ@mail.gmail.com>
Subject: Re: [PATCH 05/35] tcg: Fork TCI for wasm backend
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, 
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c67f3b063cc79fe5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000c67f3b063cc79fe5
Content-Type: text/plain; charset="UTF-8"

Hi Richard, thank you for your review.

> On 8/20/25 04:21, Kohei Tokunaga wrote:
> > The Wasm backend is implemented based on the forked TCI backend with
> > utilizing the TCI interpreter to execute TBs.
> >
> > Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
>
> This is the wrong way to go about things.
>
> Don't copy the tci backend and replace it piece by piece.
> Start with a clean slate and add the pieces one at a time.

Thank you for the suggestion. I'll reorganize the patches and add the pieces
one at a time, starting from scratch.

Regards,
Kohei

--000000000000c67f3b063cc79fe5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Richard, thank you for your review.<br=
><br>&gt; On 8/20/25 04:21, Kohei Tokunaga wrote:<br>&gt; &gt; The Wasm bac=
kend is implemented based on the forked TCI backend with<br>&gt; &gt; utili=
zing the TCI interpreter to execute TBs.<br>&gt; &gt; <br>&gt; &gt; Signed-=
off-by: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com">ktok=
unaga.mail@gmail.com</a>&gt;<br>&gt; <br>&gt; This is the wrong way to go a=
bout things.<br>&gt; <br>&gt; Don&#39;t copy the tci backend and replace it=
 piece by piece.<br>&gt; Start with a clean slate and add the pieces one at=
 a time.<br><br>Thank you for the suggestion. I&#39;ll reorganize the patch=
es and add the pieces<br>one at a time, starting from scratch.<br><br>Regar=
ds,<br>Kohei<br><br></div></div>

--000000000000c67f3b063cc79fe5--

