Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B88E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3EX-0002i4-Cd; Tue, 10 Dec 2024 11:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3EV-0002hk-17
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:37:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tL3ES-0001lw-92
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733848622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8r9sKIbRLBLkrX/nPh9MYeccE5FBF71QvPNgtqreAk=;
 b=aiKJWzVwCDGp+cVcG1vf8qkpvEut2IRnxHy63Rr6EkIaI3DOfPHmVcQlcqQwfBK2tpI5As
 5u2FYliuF9jOnUneB3TppphlGINW0aAKwRCyicLnvuToa4xbJY1DNpDG/mRT8f3IQVLKts
 OmxU5Ssr200P3qQ2cuETIltOiG3I9qg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-D7d0UDrzNVGmLPO1emOzNQ-1; Tue, 10 Dec 2024 11:35:27 -0500
X-MC-Unique: D7d0UDrzNVGmLPO1emOzNQ-1
X-Mimecast-MFC-AGG-ID: D7d0UDrzNVGmLPO1emOzNQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-386333ea577so1366056f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733848526; x=1734453326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8r9sKIbRLBLkrX/nPh9MYeccE5FBF71QvPNgtqreAk=;
 b=KWkqTz2XgBp9DNnyOGVYW2E0Y6Ei8rEpzbvU0Bwut1RLArqOW6it2XJP7uB5zF1t4a
 fulXiEB0dfTMv7bm0ZUAmKMowt+QGUGZEQz2glsy+CvO+NEQBKvrL4i+0AcZ+iSyeIAv
 8BrfrEbyJC1c8u5UCkEPid06l0j6Pa4BF/HZpdWiiLnRp3qaHM1jT+SaTAXShhj/B2f9
 j7VMj1Ntk7LqIC3brAdUP4H/y6Kb2VIgCwQXWjQhnvrAbM3KGuB0c8YdrfePo3r/yoy3
 6V1dNN4u0l5S9cq4I66j5p2gtnvg5nn5MXAzPkU2CJm1PqXWt+ZeGo/gmXcelh+Tc+V8
 mklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtFEVZdzrs+Wo02EEiLe12mgYMMaBJ8LNe3Q1OERi3HdlE9m8M8+oYGR8ldCHkYjlKmdn9xaa4hf/c@nongnu.org
X-Gm-Message-State: AOJu0Yzr6XIde7E687vDef1GYmkwEP1Co+A41SzOmLzP7HTrmjSIb/6s
 muLrWCoKjYiDyVIlm4HDE5wQDbNjIOY5/yiJAo2Izqfunup+hrBniNPZEQmdO3zzP0Js6MgLYKc
 vmwj8qPNV9lcq7H73HXA6IV2/gAavKzdgnXOH6A4l7dpsI7ZVToOW
X-Gm-Gg: ASbGncsoQMW4daZk+nA2/GjnHiZQNrZk5ISAynU/mhjWxhx1VyF7y7KdT3xpnRgEaVW
 tY0Iuwdx964G0Xt7p8HxplBAxPZDxT8DlTzk9B8NaJISfvnKrft/Nkcnbid6HcAyTj0D6PbPAOq
 eCM6DDnQmkvsMd4F6BGS4ylFi+w4QAska61OHw8N0LAaMV/FA9Rp8VLINkuuzXwxMCnoK2LuBJp
 WSHh2I577PmTFuHEwLbGiutbfmyfB7Eh++PSpiIcs4Ul/lBEjtrJxaAkaWXZoZ561Wfaari01Qe
 KxvG0k7TwwpGT/8ZoT8M6z2rmQ==
X-Received: by 2002:a5d:5989:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-386453f67d0mr3799800f8f.36.1733848526460; 
 Tue, 10 Dec 2024 08:35:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA4HSM7u5N/YztOrffT/ewTqL4Ef0CmtwH5Y6kM0a/m9Eoaw/d7QmfYye9a/kNqz5+GU544w==
X-Received: by 2002:a5d:5989:0:b0:385:de67:2269 with SMTP id
 ffacd0b85a97d-386453f67d0mr3799792f8f.36.1733848526151; 
 Tue, 10 Dec 2024 08:35:26 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190966bsm16602668f8f.75.2024.12.10.08.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:35:25 -0800 (PST)
Date: Tue, 10 Dec 2024 17:35:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Cameron Esfahani <dirty@apple.com>, Roman
 Bolshakov <rbolshakov@ddn.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 2/4] i386: Extract a common fucntion to setup value
 of MSR_CORE_THREAD_COUNT
Message-ID: <20241210173524.48e203a3@imammedo.users.ipa.redhat.com>
In-Reply-To: <f9793791-2aaa-42b8-9830-86401a020205@linaro.org>
References: <20241205145716.472456-1-xiaoyao.li@intel.com>
 <20241205145716.472456-3-xiaoyao.li@intel.com>
 <f9793791-2aaa-42b8-9830-86401a020205@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 5 Dec 2024 22:38:41 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Xiaoyao,
>=20
> On 5/12/24 15:57, Xiaoyao Li wrote:
> > There are duplicated code to setup the value of MSR_CORE_THREAD_COUNT.
> > Extract a common function for it.
> >=20
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >   target/i386/cpu.h                    | 11 +++++++++++
> >   target/i386/hvf/x86_emu.c            |  3 +--
> >   target/i386/kvm/kvm.c                |  5 +----
> >   target/i386/tcg/sysemu/misc_helper.c |  3 +--
> >   4 files changed, 14 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 4c239a6970fd..5795a497e567 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2390,6 +2390,17 @@ static inline void cpu_x86_load_seg_cache_sipi(X=
86CPU *cpu,
> >       cs->halted =3D 0;
> >   }
> >  =20
> > +static inline uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu) =
=20
>=20
> Please do not add more inlined functions in this huge file, the
> inlining performance isn't justified at all.
>=20
> target/i386/cpu-sysemu.c looks the correct place for this helper.

ack

>=20
> > +{
> > +    CPUState *cs =3D CPU(cpu);
> > +    uint64_t val;
> > +
> > +    val =3D cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..=
0 */
> > +    val |=3D ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..1=
6 */ =20
>=20
> Personally I'd change to:
>=20
>         return deposit64(cs->nr_threads * cs->nr_cores, 16, 16,
>                          cs->nr_cores);
that I wouldn't do in this patch to make it easier to compare apples to app=
les
That however could be a separate patch on top

> > +
> > +    return val;
> > +} =20
>=20


