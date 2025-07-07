Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A809C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYoHw-0001Kg-SK; Mon, 07 Jul 2025 12:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uYnyn-0005IL-RM
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uYnyk-0005UO-Ia
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 11:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751902917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1bEPp2GKT7T8VOS9kKxycYzQjJ5MzMf5vCzoG2U6fM=;
 b=aYBGWohv3Io3NvtR8/ORQ5JBhzvChTz5F58rzR2H6Me/zRQnO0TZE88gfAM3BujUHOBeuy
 uhbxmd//5Wc/A6F06zZyJ9H9dFCWLQ3INEeLdLdq/VgI2TimvkGvkA+/lVY6AWuY6exLAG
 06amgzfs9wSKNRXxG9kLhtx6gXzR4PY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-VciJuSb9NCevS124pX6gnw-1; Mon, 07 Jul 2025 11:41:55 -0400
X-MC-Unique: VciJuSb9NCevS124pX6gnw-1
X-Mimecast-MFC-AGG-ID: VciJuSb9NCevS124pX6gnw_1751902915
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so1923633f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 08:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751902915; x=1752507715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1bEPp2GKT7T8VOS9kKxycYzQjJ5MzMf5vCzoG2U6fM=;
 b=D6Xg94YylTXB0zAEsjwW3bzdet84DOXyGKWTnKRR4fzyEMtpfsltLYJKnF0X1jrL8G
 k4qTFkLAxm+RNwPCI2RNZhpGK35RzyDRHg3HBSAOPIkcC74/sbOd1m2srimX5aM58yb+
 4UeL4Zh7dbASHaxgjnM26t0cjOZB5ecgLk1i70irRx/y9qkJwpNhb/oqBcCUIWx6tuM1
 qQESMWgz3CXoRMK0mvJI6aDRfMGz4kMBIDcMM+yETda0Iws61rPfGqGNjlfkryNY4JsT
 GYUXyk/wyuGVPkkCEHCEElpfLH1ZuGZfaH+7UR+45o0HSN3grRGtYPibnTp3WpSgDEg5
 TAkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoNFKNRXUWGWfjmjenACmbvkzV7d28twAOElT5zZxO0MgeMgd8saHOP+KiRcuBYpv//oDy6+X0J/Wb@nongnu.org
X-Gm-Message-State: AOJu0Yycgs2rVZM6yVVxf3J+ZHlRoYpheCKXQjKQcA5ny58A6VrYfRVi
 nSvdJtCRlQSTgUTM9fqyZhyMx5oNNv90di+iTUnzZlD4JnBIOt4PEXl+xRKEYJZBT4PQKBoUepw
 PgBl5v5YhOLCPIwDvEPJNOtT0kql3y9JYFcpa1tSBED5fIbtuV0VkdcqSZxA0sjZrKjES/EVYZ0
 Q7Wu/wlNXczDDj/S6P0wlZkPp4g5ti7fc=
X-Gm-Gg: ASbGnctMJMVEcUYGmzjhSxHBQ6Szo9i1nXEwX5IRxjpEzY+y7kyiL1QEpQLzzD76YpZ
 pMP2w6Gx06iioLcVAuv3q5hk2L9+horoFzQrd60GvkAVMkSvEjO3acFAxSJDqMZCenjJf8N886V
 lq6Q==
X-Received: by 2002:adf:e189:0:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b495cbca06mr9976831f8f.19.1751902914639; 
 Mon, 07 Jul 2025 08:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFzTWgBma65zaIV4vq9tz3mzYgfeBNzGFOCFCDxgoqb4chvP0q2n17ZcDBcAuc5ECRvnhnJYU1Dt5RPumUXvA=
X-Received: by 2002:adf:e189:0:b0:3a5:8977:e0f8 with SMTP id
 ffacd0b85a97d-3b495cbca06mr9976813f8f.19.1751902914238; Mon, 07 Jul 2025
 08:41:54 -0700 (PDT)
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
 <CABgObfZf=hK7gU_6yun2-rKCDU2d4L29A1fQKirGUj6_AaEqSA@mail.gmail.com>
In-Reply-To: <CABgObfZf=hK7gU_6yun2-rKCDU2d4L29A1fQKirGUj6_AaEqSA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 7 Jul 2025 17:41:44 +0200
X-Gm-Features: Ac12FXxlv5BQenCN_Lm994SshyJxyjR6V5NYgixqKkcqRA_tMExHtPcz9DrUi8g
Message-ID: <CABgObfYfNCtRFyCKuOLed3C58iGGVgw32VFOrWfjj5pXiLLxgQ@mail.gmail.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e26f2a063958ae99"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--000000000000e26f2a063958ae99
Content-Type: text/plain; charset="UTF-8"

Il gio 3 lug 2025, 06:51 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

>
>
> Il mer 2 lug 2025, 23:36 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
>
>> The reason why accelerator's instance_init() was moved to post_init, was
>> just it needs to consider other factors. Please see commit 4db4385a7ab6
>> ("i386: run accel_cpu_instance_init as post_init")
>>
>
> You're right and this can be a problem with the simple split that Zhao
> proposed. But the root cause is that post_init is confusing many kinds of
> defaults (the KVM vendor case, globals which are different for compat
> properties and -global and which CPUs also abuse to implement -cpu by the
> way, max_features handling, maybe more; all of which have different
> priorities).
>

I checked and it seems to me that all of the accelerator-specific
initialization should be doable in instance_init (which risc-v already
does), the only problem is the max_features field. But max_features is
*not* a qdev property so it can be moved to the class side.

I will try to send patches tomorrow.

Paolo


TDX added checks on top, and instance_post_init worked when applying class
> defaults but not for checks. But as mentioned in the commit message for
> this patch, cxl_dsp_instance_post_init and
> rp_instance_post_init have similar issues so reverting is also incorrect.
>
> Maybe DeviceClass needs another callback that is called before Device's
> own instance_post_init. The accelerator could use it.
>
> Or maybe, more long term, instance_post_init could be replaced by a set of
> Notifiers that are registered by instance_init and that have a priority
> (FIXUP_CLASS_DEFAULTS, APPLY_GLOBAL_DEFAULTS, and a third for TDX).
>
> Paolo
>
> accelerator needs to do different tweak for "max/host", "xcc->model".
>>
>> Of course we can split it and put specific handling at the end of each
>> sub-class's instance_init(), like below:
>>
>> - in TYPE_X86_CPU instance_init()
>>
>>         if (accelerator_kvm) {
>>                 kvm_instance_init_common_for_x86_cpu();
>>         }
>>
>> - in "base" instance_init()
>>
>>         if (accelerator_kvm) {
>>                 kvm_instance_init_for_base();
>>         }
>>
>> - in "max" instance_init()
>>
>>         if (accelerator_kvm) {
>>                 kvm_instance_init_for_max();
>>         }
>>
>> - in "host" instance_init()
>>
>>         if (accelerator_kvm) {
>>                 kvm_instance_init_for_host();
>>         }
>>
>> - in "named cpu model" instance_init()
>>
>>         if (xcc->model) {
>>                 kvm_instance_init_for_xcc_model();
>>         }
>>
>> Contrast to the current implementation in post_init()
>>
>>         if (accelerator_kvm) {
>>                 kvm_instance_init_common_for_x86_cpu();
>>
>>                 if (base)
>>                         ...
>>                 if (max)
>>                         ...
>>                 if (host)
>>                         ...
>>                 if (xcc->model)
>>                         ...
>>         }
>>
>> The reality for the former might be simpler since "base" doesn't have
>> instance_init(), and "max/host" are same to KVM as "cpu->max_features"
>>
>> But I still like the latter.
>>
>>
>>

--000000000000e26f2a063958ae99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 3 lug 2025, 06:51 Paolo B=
onzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">Il mer 2 lug 2025, 23:36 Xiaoyao Li &lt;<a href=3D"mail=
to:xiaoyao.li@intel.com" rel=3D"noreferrer noreferrer" target=3D"_blank">xi=
aoyao.li@intel.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">The reason why accelerator&#39;s instance_init() was=
 moved to post_init, was <br>
just it needs to consider other factors. Please see commit 4db4385a7ab6 <br=
>
(&quot;i386: run accel_cpu_instance_init as post_init&quot;)<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You&#39;re righ=
t and this can be a problem with the simple split that Zhao proposed. But t=
he root cause is that post_init is confusing many kinds of defaults (the KV=
M vendor case, globals which are different for compat properties and -globa=
l and which CPUs also abuse to implement -cpu by the way, max_features hand=
ling, maybe more; all of which have different priorities).</div></div></blo=
ckquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I checked=
 and it seems to me that all of the accelerator-specific initialization sho=
uld be doable in instance_init (which risc-v already does), the only proble=
m is the max_features field. But max_features is *not* a qdev property so i=
t can be moved to the class side.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I will try to send patches tomorrow.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
auto"><div dir=3D"auto">TDX added checks on top, and instance_post_init wor=
ked when applying class defaults but not for checks. But as mentioned in th=
e commit message for this patch, cxl_dsp_instance_post_init and</div><div d=
ir=3D"auto">rp_instance_post_init have similar issues so reverting is also =
incorrect.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Maybe DeviceC=
lass needs another callback that is called before Device&#39;s own instance=
_post_init. The accelerator could use it.=C2=A0</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Or maybe, more long term, instance_post_init could =
be replaced by a set of Notifiers that are registered by instance_init and =
that have a priority (FIXUP_CLASS_DEFAULTS, APPLY_GLOBAL_DEFAULTS, and a th=
ird for TDX).</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
><div dir=3D"auto"><div dir=3D"auto"><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">accelerator needs to do different tweak for &quot;max/host&quot=
;, &quot;xcc-&gt;model&quot;.<br>
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
</blockquote></div></div></div>

--000000000000e26f2a063958ae99--


