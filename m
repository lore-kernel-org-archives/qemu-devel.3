Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2325DC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwF6-0006sd-I4; Wed, 02 Jul 2025 08:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uWwEz-0006qN-4E
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uWwEr-0003Zz-VR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751458014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=31J1hjhz/sCnMXy7Rg7sf1mlj2DSfvoGGS2qbTqz4fg=;
 b=Svu6t9T5KdfFp/YuduN67N1+EqXT2iTPhW36i4Oe+TxxXObHi6GsLNzSi1iWEIRQPWasMT
 qOKUOBChIG8PKsno3gtTCMgzaWWPvVcfdYmUwHPk9gkifSr12lqf9dpia3IcWHUj2lhaU4
 04zN4wwEpVKrLb1H23PraVHDFYiWUzo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-uDiH_a00P_qIBRnI47sVfQ-1; Wed, 02 Jul 2025 08:06:53 -0400
X-MC-Unique: uDiH_a00P_qIBRnI47sVfQ-1
X-Mimecast-MFC-AGG-ID: uDiH_a00P_qIBRnI47sVfQ_1751458012
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso3414808f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458012; x=1752062812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31J1hjhz/sCnMXy7Rg7sf1mlj2DSfvoGGS2qbTqz4fg=;
 b=VEDLDbtBvAhhcB7GiGk3f6AKX0dDcbxaq1fnls0N6qz571Ohzltl3mIL9qAAJwwL5n
 q+TITz685+w+jQ8+OY2FEXi57M8YztEWcf4CDuJ+dFtdMknGMTxM4RXXquc4E3XBay3x
 64nrnAomgHzPpcgEH/NjvMlWdR+H8ZJLr8GZBl4dTXC9lmkg2B11/KoB0vfQ028wr4I0
 4nyzNflRQ8wCaqWnDbBfA6hdATvO/nEyGfUvUWzsY0Qg0Fe4B1xzzcMq6eRp1QJ4XNE5
 n1tcvBqQaB6wgtmnTez4KE4KBSfKNggzemiggrB4psvRI3cMEagoPhmClw3rG6hVjNHC
 mdoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBA6Xq0T59omgD+YG85EaPmD0pU8rJ5s5B77/1ms9zqNkUf8xAPc7lfM3ypQYDXMTeFf9g8pJpKa4o@nongnu.org
X-Gm-Message-State: AOJu0YxwtQ0lcRK9lAc0BjV/TXQxaRx+4kEYc8eD1wYbeUkS27IOxs7B
 01ccYMAniuL40rFAwq2KYL4t2BFC9qJ1brV5bjoKfBn9bNXemJVuS52qDVuGHSYnC2fl0uk1UPO
 l/Ks4mQvNRI+63RJRltrWdjFjIbiRNFNANRWw0i15Ni7t0MPr8bXboD2F+8+V1WngzNjO5OsTVj
 z9gBdr5/eLFOsNcjEUmYzmcsVfOPI8NL4=
X-Gm-Gg: ASbGnctHWtm4ZcBYgOeworGaCGdARSXHv2BWJ247jerspfsX1yN34heO7zfpVJvL+mR
 5LSAgcKklUkW0Dq1prRMDJ5IjEBiYxQeSahtjfTXUlA+SlWBO+Dpaly80IIrnh/iw7o0udhcWG0
 OAlw==
X-Received: by 2002:a05:6000:4409:b0:3a4:eecd:f4d2 with SMTP id
 ffacd0b85a97d-3b2000b0939mr1422503f8f.38.1751458012059; 
 Wed, 02 Jul 2025 05:06:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIMBzbcXLPAY9+1eA9RMgINutnny0JBf5go7YE3W3icvsMuQ/NSjH2rknd2ekw2N6dVqM69hm0kqwBVdv3PsE=
X-Received: by 2002:a05:6000:4409:b0:3a4:eecd:f4d2 with SMTP id
 ffacd0b85a97d-3b2000b0939mr1422481f8f.38.1751458011635; Wed, 02 Jul 2025
 05:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com> <aFpocfTpBLB34N3l@intel.com>
 <aGKryLSGlFTMSKHv@intel.com> <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
In-Reply-To: <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Jul 2025 08:06:38 -0400
X-Gm-Features: Ac12FXxYsEnf8dvpojMOHATVJ3DA7FTnwwun6I5hpoMmXvIFuTWvrVs_dcKjwDg
Message-ID: <CABgObfZJztWmXQBzetLKsUyqRS6yL23OpeLvAm1GWpSbXwFsKw@mail.gmail.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009f7ea90638f1186d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009f7ea90638f1186d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 2 lug 2025, 02:54 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> >>> Back to this commit, I think current order of post_init  makes sense.
> >>> Instead, the place of host_cpu_instance_init() doesn't seem quite
> >>> right. So, I think this commit might have exposed some drawbacks in t=
he
> >>> previous x86 CPU initialization order:
> >>>
> >>> f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using
> >>> AccelCPUClass")
> >>> 5b8978d80426 ("i386: do not call cpudef-only models functions for
> >>> max, host, base")
> >>
> >> To fix this issue, we need to initialize "vendor" property in the init=
fn
> >> of max/host/named CPUs instead of current post_initfn.
> >>
> >> This will need to split the cpu_instance_init() of x86 kvm (and maybe
> >> hvf/tcg)
> >> into 2 hooks:
> >>   * AccelCPUClass.cpu_instance_init() - called in x86 CPUs' initfn.
> >>   * AccelCPUClass.cpu_instance_post_init() - called in x86 CPUs'
> >>     post_initfn.
> >
> > Split accel.cpu_instance_init() into cpu's instance_init() and
> > post_instance_init() does not seem right way to go.
>
> Yeah, please don't. I'm trying to consolidate this code but it takes
> (too) long.
>

Unfortunately I agree with Zhao. The globals, being user provided, must
come after the AccelCPUClass initialization.

My hope is that it's possible to avoid a split and move everything earlier
as in target-riscv/. I will take a look next week if Zhao doesn't beat me,
and/or discuss with him.

Paolo


> > The reason .post_instance_init() was implemented and put
> > accel_cpu_instance_init() in it for x86 cpu was that, we don't want to
> > scatter acceletor specific instance_init operation into different
> > subclass of x86 cpu (max/host/named cpu model).
> >
> > I think something like below should be enough.
> >
> > -----------8<-------------
> > Author: Xiaoyao Li <xiaoyao.li@intel.com>
> > Date:   Tue Jul 1 13:33:43 2025 +0800
> >
> >      i386/cpu: Re-apply the global props as the last step of post_init
> >
> >      Commit 220c739903ce ("qom: reverse order of instance_post_init
> calls")
> >      reverses the order instance_post_init calls, which leads to
> >      device_post_init() called before x86 cpu
> > specific .instance_post_init().
> >
> >      However, x86 cpu replies on qdev_prop_set_globals() (inside
> >      device_post_init()) to apply the cpu option like "feature[=3Dfoo]"
> > passed
> >      via '-cpu' as the last step to make the '-cpu' option highest
> > priority.
> >
> >      After the order change of .instance_post_init(),
> x86_cpu_post_initfn()
> >      is called after device_post_init(), and it will change some proper=
ty
> >      value even though "-cpu" option specify a different one.
> >
> >      Re-apply the global props as the last step to ensure "-cpu" option
> >      always takes highest priority.
> >
> >      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 0d35e95430fe..bf290262cbfe 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -9044,6 +9044,12 @@ static void x86_cpu_post_initfn(Object *obj)
> >               X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)))=
;
> >       }
> >   #endif
> > +
> > +    /*
> > +     * Re-apply the "feature[=3Dfoo]" from '-cpu' option since they mi=
ght
> > +     * be overwritten by above
> > +     */
> > +    qdev_prop_set_globals(DEVICE(obj));
> >   }
>
> This patch LGTM.
>
> Regards,
>
> Phil.
>
>

--0000000000009f7ea90638f1186d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 2 lug 2025, 02:54 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt;&gt;&gt; Back to this commit, I think current order of post_init=C2=A0 =
makes sense.<br>
&gt;&gt;&gt; Instead, the place of host_cpu_instance_init() doesn&#39;t see=
m quite<br>
&gt;&gt;&gt; right. So, I think this commit might have exposed some drawbac=
ks in the<br>
&gt;&gt;&gt; previous x86 CPU initialization order:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; f5cc5a5c1686 (&quot;i386: split cpu accelerators from cpu.c, u=
sing <br>
&gt;&gt;&gt; AccelCPUClass&quot;)<br>
&gt;&gt;&gt; 5b8978d80426 (&quot;i386: do not call cpudef-only models funct=
ions for <br>
&gt;&gt;&gt; max, host, base&quot;)<br>
&gt;&gt;<br>
&gt;&gt; To fix this issue, we need to initialize &quot;vendor&quot; proper=
ty in the initfn<br>
&gt;&gt; of max/host/named CPUs instead of current post_initfn.<br>
&gt;&gt;<br>
&gt;&gt; This will need to split the cpu_instance_init() of x86 kvm (and ma=
ybe <br>
&gt;&gt; hvf/tcg)<br>
&gt;&gt; into 2 hooks:<br>
&gt;&gt; =C2=A0 * AccelCPUClass.cpu_instance_init() - called in x86 CPUs&#3=
9; initfn.<br>
&gt;&gt; =C2=A0 * AccelCPUClass.cpu_instance_post_init() - called in x86 CP=
Us&#39;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 post_initfn.<br>
&gt; <br>
&gt; Split accel.cpu_instance_init() into cpu&#39;s instance_init() and <br=
>
&gt; post_instance_init() does not seem right way to go.<br>
<br>
Yeah, please don&#39;t. I&#39;m trying to consolidate this code but it take=
s<br>
(too) long.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Unfortunately I agree with Zhao. The globals, being user provide=
d, must come after the AccelCPUClass initialization.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">My hope is that it&#39;s possible to avoid a s=
plit and move everything earlier as in target-riscv/. I will take a look ne=
xt week if Zhao doesn&#39;t beat me, and/or discuss with him.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; The reason .post_instance_init() was implemented and put <br>
&gt; accel_cpu_instance_init() in it for x86 cpu was that, we don&#39;t wan=
t to <br>
&gt; scatter acceletor specific instance_init operation into different <br>
&gt; subclass of x86 cpu (max/host/named cpu model).<br>
&gt; <br>
&gt; I think something like below should be enough.<br>
&gt; <br>
&gt; -----------8&lt;-------------<br>
&gt; Author: Xiaoyao Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com" target=
=3D"_blank" rel=3D"noreferrer">xiaoyao.li@intel.com</a>&gt;<br>
&gt; Date:=C2=A0=C2=A0 Tue Jul 1 13:33:43 2025 +0800<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 i386/cpu: Re-apply the global props as the la=
st step of post_init<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 Commit 220c739903ce (&quot;qom: reverse order=
 of instance_post_init calls&quot;)<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 reverses the order instance_post_init calls, =
which leads to<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 device_post_init() called before x86 cpu <br>
&gt; specific .instance_post_init().<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 However, x86 cpu replies on qdev_prop_set_glo=
bals() (inside<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 device_post_init()) to apply the cpu option l=
ike &quot;feature[=3Dfoo]&quot; <br>
&gt; passed<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 via &#39;-cpu&#39; as the last step to make t=
he &#39;-cpu&#39; option highest <br>
&gt; priority.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 After the order change of .instance_post_init=
(), x86_cpu_post_initfn()<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 is called after device_post_init(), and it wi=
ll change some property<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 value even though &quot;-cpu&quot; option spe=
cify a different one.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 Re-apply the global props as the last step to=
 ensure &quot;-cpu&quot; option<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 always takes highest priority.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 Signed-off-by: Xiaoyao Li &lt;<a href=3D"mail=
to:xiaoyao.li@intel.com" target=3D"_blank" rel=3D"noreferrer">xiaoyao.li@in=
tel.com</a>&gt;<br>
&gt; <br>
&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; index 0d35e95430fe..bf290262cbfe 100644<br>
&gt; --- a/target/i386/cpu.c<br>
&gt; +++ b/target/i386/cpu.c<br>
&gt; @@ -9044,6 +9044,12 @@ static void x86_cpu_post_initfn(Object *obj)<br=
>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 X86_CONFIDENTIAL_GUEST(current_machine-&gt;cgs), (CPU(obj)));<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0 /*<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Re-apply the &quot;feature[=3Dfoo]&quot; f=
rom &#39;-cpu&#39; option since they might<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * be overwritten by above<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
&gt; +=C2=A0=C2=A0=C2=A0 qdev_prop_set_globals(DEVICE(obj));<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
This patch LGTM.<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div></div>

--0000000000009f7ea90638f1186d--


