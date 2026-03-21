Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A7E108B8FF
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 07:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3qNC-0004EN-6R; Sat, 21 Mar 2026 03:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3qN6-0004DY-HT
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 03:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3qN3-0001K3-UX
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 03:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774076620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chCzfoxndNEpoCM183oXU3EMjoreZmIhKdwZOEwL1Ho=;
 b=NqDs5gHHmz3pJZRwQU1BlyKq8NfRxSWjRTgnqwWrGE4qW7w4rWpUsgeeHp+zOr7pe5c3lH
 pG0zn2REhCR9NJJpT6PKE/qoi4HvmdJwf+I1O39KNc5bw7NJKaWthR3PczK2pZPOvyuRcS
 /yrFjqbCeD0TbDlnAEPOkKPU6LuVPCE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-vBwOk2gzMoWFMrPWAohOgA-1; Sat, 21 Mar 2026 03:03:37 -0400
X-MC-Unique: vBwOk2gzMoWFMrPWAohOgA-1
X-Mimecast-MFC-AGG-ID: vBwOk2gzMoWFMrPWAohOgA_1774076617
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35b9246248dso2344185a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2026 00:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774076617; x=1774681417; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chCzfoxndNEpoCM183oXU3EMjoreZmIhKdwZOEwL1Ho=;
 b=ZKqA8yH45L5JxW8IQxThdtC8uPK6ceeg7yR0nHDlR0uRvxCTVzqU/01r4fHCWCDwDG
 el7sGBi8BYJyjRSC6oquT4+km/Ghu+uuvALWME97lLRzl15OdoJLIoZy8zJsVLR/HWcW
 Yaa4NNof7UirLVYP/JWCbocmAGuKgAaAFdJLj+z0Vjlan8XMXTXKqz51tOrsilf4+nmA
 J4gWm1SpUV0Lh0oqws2+/iP8g2QKevI+b/PWI7D+6fbCAX5DhzdYRaBMOJp5lE4hb0Su
 wZLiOzzvY1Jb2MsBXOlLRGJKP7GyoOLoMle6YE0UgF2YNodUAx/K8cEn8gLfn4RDqD8I
 VIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774076617; x=1774681417;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=chCzfoxndNEpoCM183oXU3EMjoreZmIhKdwZOEwL1Ho=;
 b=S6/SgEmYi460Ld+oxev7F1dVg7Sg4RgR3WdImfqEeNCHQZidMgzBTzLf7ZqRT7UfWE
 4T7w5PnHGwLkYzFaJSZ4CRYarJwZ9mSI4ULub8jXrEOaapEb5Ijk0o/Use2daRen303R
 9GKx0wcy+Y7uips504Wn0U99m7ml39CR7kLMgaRCqB+8hDM62CjjbajMNDTDtVLceVQw
 QVJhF7ViGeiVOxDDT2NuUgGH1Adk9EA6W3o5R+tNPS5VxCmKD/qGAMoCh//iogItuihr
 dDiWEdz92lqukfddG6IaSmqJDdjzlQBLVrVEHlbEMBg/vrgeZCTqY/bgow07PbQ2stJ8
 lVQA==
X-Gm-Message-State: AOJu0YwFvtsZGuXKezOoC/JLN4ypyYBBR3B3hrtiZoNTd9JwRHi8k991
 VgJWPFnqlbeIP4lW++IkUyZ3DXfpPJtpPkabRxzLFRGNJKOzWZCvnIQV9ZyuP+AJlnNQ5J5dO1e
 sxupMAVGkSuUqq6dP0B5XwhJ5DOy/8vr0twv5kOzTaQmDu1H6ug90/O08
X-Gm-Gg: ATEYQzyoggPnhPVk9U8nHvvdkXOzTo/FbGWIeQ30mzq6OYS1SvuKhxMiqDpsQZmXSQZ
 zuogxm0nyWx1S8+5+5wz08zfyMzNP7BuiagusE390d9PqKZOu2Jw1S0ONCF83tqYiAd4NLRCFsg
 ix9/XlnltEK69cjFtLn3jr3uje1RhbJAgqdNRKPQXlGadYOHQ/6TQVb8Yt5huWyOcUX/qXbNmqs
 OkqXyEwsmUNSJ4cu1r85Qi7Z/LwIxbzhxNAWZvuPVvZZUYe2eo3dzGt9xZlcimJ/Hd5PPB3UMPE
 UijhXcv0E5TOVaLtltPosFiWOCYjF0ajOuOKcBLaEcMotl4+B/coyfXKzjq+2aahrXTMzLS8qLv
 io2uYW/KdQ4mijhGm7KrTDhFaoCPopkx0ZziMhHO0M/nFmbJEMKsGTl7D8/nN06dSxXz45qkImt
 H5oI8=
X-Received: by 2002:a17:90b:17c9:b0:359:fdc0:4621 with SMTP id
 98e67ed59e1d1-35bd2bc01eemr4909072a91.11.1774076616678; 
 Sat, 21 Mar 2026 00:03:36 -0700 (PDT)
X-Received: by 2002:a17:90b:17c9:b0:359:fdc0:4621 with SMTP id
 98e67ed59e1d1-35bd2bc01eemr4909048a91.11.1774076616135; 
 Sat, 21 Mar 2026 00:03:36 -0700 (PDT)
Received: from smtpclient.apple ([2401:4900:1c00:31c5:7843:8eb7:2c82:b9a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc610c232sm6679409a91.13.2026.03.21.00.03.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Mar 2026 00:03:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] hw/hyperv: fix SynIC not initialized for CPUs after the
 first
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260321062055.20839-1-souravpoddar93042@gmail.com>
Date: Sat, 21 Mar 2026 12:32:49 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 philippe.mathieu.daude@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B73F5E50-217E-4A1A-90FA-1E0FA1644A02@redhat.com>
References: <20260321062055.20839-1-souravpoddar93042@gmail.com>
To: Sourav Poddar <souravpoddar93042@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 21 Mar 2026, at 11:50=E2=80=AFAM, Sourav Poddar =
<souravpoddar93042@gmail.com> wrote:
>=20
> hyperv_is_synic_enabled() is a global flag that returns true after the
> first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
> hyperv_x86_synic_add() in hyperv_enable_synic(), leaving them without
> a synic object. This causes get_synic() to return NULL, making
> hyperv_sint_route_new() fail and triggering an assertion crash in
> hyperv_testdev.
>=20
> Fix by introducing hyperv_is_synic_present() which checks per-CPU
> whether a synic object is already attached instead of using the global
> flag.


I have sent this here =
https://lists.nongnu.org/archive/html/qemu-devel/2026-03/msg06300.html


>=20
> Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its =
not enabled")
> Reported-by: Xudong Hao
> Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
> ---
> hw/hyperv/hyperv.c         | 5 +++++
> include/hw/hyperv/hyperv.h | 1 +
> target/i386/kvm/hyperv.c   | 2 +-
> 3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 27e323a819..ff53cbc699 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
>     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
> }
>=20
> +bool hyperv_is_synic_present(CPUState *cs)
> +{
> +    return get_synic(cs) !=3D NULL;
> +}
> +
> static void synic_update(SynICState *synic, bool sctl_enable,
>                          hwaddr msg_page_addr, hwaddr event_page_addr)
> {
> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
> index 63a8b65278..23091301d0 100644
> --- a/include/hw/hyperv/hyperv.h
> +++ b/include/hw/hyperv/hyperv.h
> @@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
> void hyperv_synic_update(CPUState *cs, bool enable,
>                          hwaddr msg_page_addr, hwaddr =
event_page_addr);
> bool hyperv_is_synic_enabled(void);
> +bool hyperv_is_synic_present(CPUState *cs);
>=20
> /*
>  * Process HVCALL_RESET_DEBUG_SESSION hypercall.
> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
> index bd3c26d02b..420c76b5ff 100644
> --- a/target/i386/kvm/hyperv.c
> +++ b/target/i386/kvm/hyperv.c
> @@ -27,7 +27,7 @@ int hyperv_x86_synic_add(X86CPU *cpu)
> int hyperv_enable_synic(X86CPU *cpu)
> {
>     int ret =3D 0;
> -    if (!hyperv_is_synic_enabled()) {
> +    if (!hyperv_is_synic_present(CPU(cpu))) {
>         ret =3D hyperv_x86_synic_add(cpu);
>     }
>     return ret;
> --=20
> 2.53.0
>=20


