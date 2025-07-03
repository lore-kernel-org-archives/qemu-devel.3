Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A4C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 04:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXBvA-0006nt-6U; Thu, 03 Jul 2025 00:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uXBv9-0006nd-1o
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uXBv6-0006OK-VX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751518294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ct+Inu2oKNQFQC7lNKzyWMmdvjb0az+i1ZKimCaTU6U=;
 b=L0Y4/NtUckQV1QXv3ALyNBYLdhywo/q4dlI+/DI35YslgCeL6Q45w9jnXQ3zKlBRmjFZ3z
 P6UfyQd/LUM4e8ZXm97KDhU5h75MJ3/flTsB4S3AodAiAIZZlNVg9E91MRnBbceDMjclnh
 8bkhfN4ePC5P5+3jlf7+GHe0BQ7lCdk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-wXIopRgGN5uqlyzSoGoqZA-1; Thu, 03 Jul 2025 00:51:32 -0400
X-MC-Unique: wXIopRgGN5uqlyzSoGoqZA-1
X-Mimecast-MFC-AGG-ID: wXIopRgGN5uqlyzSoGoqZA_1751518292
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so1391453f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 21:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751518291; x=1752123091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ct+Inu2oKNQFQC7lNKzyWMmdvjb0az+i1ZKimCaTU6U=;
 b=Cxrnk4bjWiqDG5FiKYKDnRxA6d8LKuzKQUIJcyuA4oxMkL0Ol9gVxg9CPIiP0MZks+
 hNECJnI3BMbTGwncS9K7m9hXVUzI9U1NYRSJvH6zCrXioLYpNDIjLSJjT8WlU4WaGVu8
 2I9yMZbYg2Dp5FGsMJlszGEig1/MZgyLxBGtGCPbFr99qu/nN1YyZFMHFL3FKUB8UJZv
 7fKZi5ONffXtgbUo2QocMOFzBz+zz3AwQ2dB0iwrOQGrITAGj8kDDgNGlq89MxbBtD1+
 YYGr2Jja6z8YjIDgypcWIewxwB18d3Q8ViHllEluW1gL/mGQ6weLtdsYSY8eSKMWVSnb
 pNDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLg1zoDM4fKW3pnHvMziU84SbpomWC+s+658/FGppDhN6xijfCMSw3uC958Md5EyGM/ycObOWGkSeS@nongnu.org
X-Gm-Message-State: AOJu0Yx1TqXOjSEpPycercWtdBu9zwH/dHaIYGq9bVHEWHUAM3AWlB5f
 9BeC3uLydKziptVOkBbzy+LX2lwFHKEVHwsDToGxl6DWcduhkbh/mVlT31kF35/Xwu3CSAawZ2X
 rVChmLIsJcNfipVlnTY9IMbJTioaSaYcl0cGnOZJQOKx6g4VwBEGbxkWgaC9PDz8HgPn/MYln2D
 Wla5QXqTvK0WUBqdEMNJ/9Aip3Lj/poSs=
X-Gm-Gg: ASbGncuWxpSwijGlMIQy/vIYa1CODpf9Ik0Z+XubYJAaRSEK1zBS9JpQuyHHwoph/zC
 ElMH37uWl6M4lNAuwf9L+aBTjQZd7hnCP/C+eIRVLqKp81TYvMgwcldLIh1LwbRscjlFkX/7za1
 QeHg==
X-Received: by 2002:adf:e18d:0:b0:3a4:dd16:a26d with SMTP id
 ffacd0b85a97d-3b200b47c6dmr4322993f8f.38.1751518291528; 
 Wed, 02 Jul 2025 21:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8PyiQf5z6QpMKCLZNvnNG/iZvgy7PaBsDelpv9r9UBaouXMmq9VfnlNthEiRtUQaR2csst4jJFkexf6H5DEI=
X-Received: by 2002:adf:e18d:0:b0:3a4:dd16:a26d with SMTP id
 ffacd0b85a97d-3b200b47c6dmr4322983f8f.38.1751518291182; Wed, 02 Jul 2025
 21:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
 <aGTmFGC9vZB2yEwv@intel.com> <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
 <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
 <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
 <CABgObfax21xZDKGN9b8tH-HBVeEgTjWD-xLO6DRkr3uCvkyHQQ@mail.gmail.com>
 <a7d2691b-ce43-454e-aec9-3589787dea5c@intel.com> <aGX0Im2F6R4nTUh4@intel.com>
 <83c1bd59-8e61-4585-b68e-ba9de57c749c@intel.com>
In-Reply-To: <83c1bd59-8e61-4585-b68e-ba9de57c749c@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Jul 2025 00:51:20 -0400
X-Gm-Features: Ac12FXwaC9rg3tHx-9gkTrOXxVbkG01CWXefp1vTXFo-20yPSOZO3AZWjp_tXGM
Message-ID: <CABgObfZf=hK7gU_6yun2-rKCDU2d4L29A1fQKirGUj6_AaEqSA@mail.gmail.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000090671f0638ff218d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

--00000000000090671f0638ff218d
Content-Type: text/plain; charset="UTF-8"

Il mer 2 lug 2025, 23:36 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> The reason why accelerator's instance_init() was moved to post_init, was
> just it needs to consider other factors. Please see commit 4db4385a7ab6
> ("i386: run accel_cpu_instance_init as post_init")
>

You're right and this can be a problem with the simple split that Zhao
proposed. But the root cause is that post_init is confusing many kinds of
defaults (the KVM vendor case, globals which are different for compat
properties and -global and which CPUs also abuse to implement -cpu by the
way, max_features handling, maybe more; all of which have different
priorities).

TDX added checks on top, and instance_post_init worked when applying class
defaults but not for checks. But as mentioned in the commit message for
this patch, cxl_dsp_instance_post_init and
rp_instance_post_init have similar issues so reverting is also incorrect.

Maybe DeviceClass needs another callback that is called before Device's own
instance_post_init. The accelerator could use it.

Or maybe, more long term, instance_post_init could be replaced by a set of
Notifiers that are registered by instance_init and that have a priority
(FIXUP_CLASS_DEFAULTS, APPLY_GLOBAL_DEFAULTS, and a third for TDX).

Paolo

accelerator needs to do different tweak for "max/host", "xcc->model".
>
> Of course we can split it and put specific handling at the end of each
> sub-class's instance_init(), like below:
>
> - in TYPE_X86_CPU instance_init()
>
>         if (accelerator_kvm) {
>                 kvm_instance_init_common_for_x86_cpu();
>         }
>
> - in "base" instance_init()
>
>         if (accelerator_kvm) {
>                 kvm_instance_init_for_base();
>         }
>
> - in "max" instance_init()
>
>         if (accelerator_kvm) {
>                 kvm_instance_init_for_max();
>         }
>
> - in "host" instance_init()
>
>         if (accelerator_kvm) {
>                 kvm_instance_init_for_host();
>         }
>
> - in "named cpu model" instance_init()
>
>         if (xcc->model) {
>                 kvm_instance_init_for_xcc_model();
>         }
>
> Contrast to the current implementation in post_init()
>
>         if (accelerator_kvm) {
>                 kvm_instance_init_common_for_x86_cpu();
>
>                 if (base)
>                         ...
>                 if (max)
>                         ...
>                 if (host)
>                         ...
>                 if (xcc->model)
>                         ...
>         }
>
> The reality for the former might be simpler since "base" doesn't have
> instance_init(), and "max/host" are same to KVM as "cpu->max_features"
>
> But I still like the latter.
>
>
>

--00000000000090671f0638ff218d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 2 lug 2025, 23:36 Xiaoyao Li &lt;<a href=3D"mai=
lto:xiaoyao.li@intel.com" target=3D"_blank" rel=3D"noreferrer">xiaoyao.li@i=
ntel.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">The reason why accelerator&#39;s instance_init() was moved to =
post_init, was <br>
just it needs to consider other factors. Please see commit 4db4385a7ab6 <br=
>
(&quot;i386: run accel_cpu_instance_init as post_init&quot;)<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You&#39;re righ=
t and this can be a problem with the simple split that Zhao proposed. But t=
he root cause is that post_init is confusing many kinds of defaults (the KV=
M vendor case, globals which are different for compat properties and -globa=
l and which CPUs also abuse to implement -cpu by the way, max_features hand=
ling, maybe more; all of which have different priorities).</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">TDX added checks on top, and instance_po=
st_init worked when applying class defaults but not for checks. But as ment=
ioned in the commit message for this patch, cxl_dsp_instance_post_init and<=
/div><div dir=3D"auto">rp_instance_post_init have similar issues so reverti=
ng is also incorrect.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Ma=
ybe DeviceClass needs another callback that is called before Device&#39;s o=
wn instance_post_init. The accelerator could use it.=C2=A0</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Or maybe, more long term, instance_post_=
init could be replaced by a set of Notifiers that are registered by instanc=
e_init and that have a priority (FIXUP_CLASS_DEFAULTS, APPLY_GLOBAL_DEFAULT=
S, and a third for TDX).</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><div dir=3D"auto"><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">accelerator needs to do different tweak for &quot;max/=
host&quot;, &quot;xcc-&gt;model&quot;.<br>
<br>
Of course we can split it and put specific handling at the end of each <br>
sub-class&#39;s instance_init(), like below:<br>
<br>
- in TYPE_X86_CPU instance_init()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accelerator_kvm) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_instance_init_c=
ommon_for_x86_cpu();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
- in &quot;base&quot; instance_init()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accelerator_kvm) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_instance_init_f=
or_base();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
- in &quot;max&quot; instance_init()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accelerator_kvm) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_instance_init_f=
or_max();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
- in &quot;host&quot; instance_init()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accelerator_kvm) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_instance_init_f=
or_host();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
- in &quot;named cpu model&quot; instance_init()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xcc-&gt;model) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_instance_init_f=
or_xcc_model();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Contrast to the current implementation in post_init()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accelerator_kvm) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_instance_init_c=
ommon_for_x86_cpu();<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (base)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (max)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (host)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (xcc-&gt;model)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
The reality for the former might be simpler since &quot;base&quot; doesn&#3=
9;t have <br>
instance_init(), and &quot;max/host&quot; are same to KVM as &quot;cpu-&gt;=
max_features&quot;<br>
<br>
But I still like the latter.<br>
<br>
<br>
</blockquote></div></div></div></div></div>

--00000000000090671f0638ff218d--


