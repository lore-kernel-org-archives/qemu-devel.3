Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B3FC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwKa-0002MU-0X; Wed, 02 Jul 2025 08:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uWwKW-0002M7-NP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uWwKT-0004ug-Nk
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751458362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCjk0vJOUwXgp3v+F6wr2QXDlh9uvbr0yADCuoWe3OQ=;
 b=LcAZvdMqC0mmq5j9FD6xR6TJy43321li+tKdYOWPGFfCmi2YDLxP5fN8v4dd+SPjyl6Oaw
 dTpUqrviuUmVQAwp6Aa7IK2u98dU/yRNtsNXvRQPA3L/kWgSD3YdJ9uOTrQ2Pf8x/xOqzy
 ZFFZi2Letkd7IvXwUwcXn9OJ7R1V970=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-h0M3ZBSOP4CpO_GeAfWc5w-1; Wed, 02 Jul 2025 08:12:41 -0400
X-MC-Unique: h0M3ZBSOP4CpO_GeAfWc5w-1
X-Mimecast-MFC-AGG-ID: h0M3ZBSOP4CpO_GeAfWc5w_1751458360
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so3289484f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458360; x=1752063160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCjk0vJOUwXgp3v+F6wr2QXDlh9uvbr0yADCuoWe3OQ=;
 b=Mfkb8yfMD8E3l/ew3MMgMw1PEsnYzravEZKYwKqzsBVUAN4m8V9Qyx9ihbDlvUlNJo
 vxlnBgWZE0zLcE2/5rBzqmtkxNTb+qYk7SqFPkxxISQroEs95IGbwLa4nts1OPpsccNI
 CqlyycHCJKuC88No9+bqFlZpSa28MIqbI1hrZtQJ+6i7sVVc1FDDd9Ubp/wMF59aLnyW
 93D4TUSeB3chgRHQfEt6xUaOm2Hbn4ezRx/OG5rzXUpcblIMkReSZomlQ1/xqd+k6f5d
 EKUsbzm68vQ872f2/xIs9IjVZRFD4MnpeQePtMtDNTWoRzQKFyetjqvt66uq0Y5tu2jG
 J+Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQIFLqG62IMivG85swmwhRkSH7+uYkzQTJWtBkQF6svGcveW9uDoagOsEP/hse1bKlbYZYjg0hNVgt@nongnu.org
X-Gm-Message-State: AOJu0YwfnS83lqN4+cDiBSOmkcWjfNti7i6UDHWmC+9vc3FS22jegG7k
 Tkk0eRQiHmQDupn5j+eWcg3LsBkaJSLakhwxgrqwBWoeKhOh3BodsS30hzMpEXUgXBdUjKP0tLG
 9aPE5WMJAu09ll2jMf4abSBmU4sF5bYFRbuEB41fcBjrJ8ODJQ5uBOXBFSOYqbVLaRuMY0sAbli
 nn6xDlCsRUAxZFPHNLcVeUVO1pj1M1HQ4=
X-Gm-Gg: ASbGnctdNY2E4cdoHM//je0GLbiEmd96ajbCOZSIotnyzSxC576ypqTTF0WJpuGUcfz
 eJ+iUQ01i5O30wgfKoJ2Qi9rLMUh2cNsIji0S2ZF02aMnp8dA85Jc0RMtg8llLSbyXAvLw+aRXe
 o0Ww==
X-Received: by 2002:a05:6000:2c11:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3b200b4663dmr2129890f8f.39.1751458359857; 
 Wed, 02 Jul 2025 05:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7EMrr32EdUd2X+zqxtn4vn2bkB5m6BCg0hRSHa305RXWgiFKDdoNcl1msStyHN6Ofa9spFn1ejtEEt/vGFfk=
X-Received: by 2002:a05:6000:2c11:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3b200b4663dmr2129858f8f.39.1751458359421; Wed, 02 Jul 2025
 05:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com> <aFpocfTpBLB34N3l@intel.com>
 <aGKryLSGlFTMSKHv@intel.com> <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org> <aGTmFGC9vZB2yEwv@intel.com>
 <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
In-Reply-To: <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Jul 2025 08:12:25 -0400
X-Gm-Features: Ac12FXw8rkDOD3dnmoTHPvvVAo4ebor49eEyD7mHVx8RSE0EGjwRCEOIvmC-1BA
Message-ID: <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005a500e0638f12de9"
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

--0000000000005a500e0638f12de9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 2 lug 2025, 07:42 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> Back to Paolo's example of "a compat property will be set on a device
> *after* the class's post_init callback has run". I think the behavior of
> compat property is applied after the class's post_init callback is also
> what we want. If reversing the order, then compat prop can be
> overwritten by subclass's post_init callback, and doesn't it fail the
> purpose of compat prop?
>

I wrote the patch because of a latent issue with TDX. The issue was roughly
that a compat property was overwriting the TDX-specific modifications to
CPUID. I think this case shows that you *do* want the subclass to overwrite
the compat property=E2=80=94of course the subclass code must be aware that =
compat
properties exist and limit changes appropriately.

In general I don't see how the reverse order makes sense: the subclass
knows what the superclass does, so it can do the right thing if it runs
last; but the superclass cannot know what all of its subclasses do in
post_init, so it makes less sense to run it last.

Paolo


> So I think we might revert this patch, and document clearly the reverse
> order of .post_instance_init() callback.
>
> > X86 CPUs have the issue (e.g., "vendor" doesn't work) now because
> > they - as leaf class, don't care about the property values of
> > superclass - the DeviceState. If a property is just for initialization,
> > like "vendor", it should be placed in the instance_init() instead of
> > instance_post_init().
> >
> > In addition, if other places handle it similarly, the device's
> > post_init seems pointless. :-(
> >
> > Thanks,
> > Zhao
> >
>
>

--0000000000005a500e0638f12de9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 2 lug 2025, 07:42 Xiaoyao=
 Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt=
; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ba=
ck to Paolo&#39;s example of &quot;a compat property will be set on a devic=
e <br>
*after* the class&#39;s post_init callback has run&quot;. I think the behav=
ior of <br>
compat property is applied after the class&#39;s post_init callback is also=
 <br>
what we want. If reversing the order, then compat prop can be <br>
overwritten by subclass&#39;s post_init callback, and doesn&#39;t it fail t=
he <br>
purpose of compat prop?<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">I wrote the patch because of a latent issue with TDX=
. The issue was roughly that a compat property was overwriting the TDX-spec=
ific modifications to CPUID. I think this case shows that you *do* want the=
 subclass to overwrite the compat property=E2=80=94of course the subclass c=
ode must be aware that compat properties exist and limit changes appropriat=
ely.</div><div dir=3D"auto"><br></div><div dir=3D"auto">In general I don&#3=
9;t see how the reverse order makes sense: the subclass knows what the supe=
rclass does, so it can do the right thing if it runs last; but the supercla=
ss cannot know what all of its subclasses do in post_init, so it makes less=
 sense to run it last.</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
So I think we might revert this patch, and document clearly the reverse <br=
>
order of .post_instance_init() callback.<br>
<br>
&gt; X86 CPUs have the issue (e.g., &quot;vendor&quot; doesn&#39;t work) no=
w because<br>
&gt; they - as leaf class, don&#39;t care about the property values of<br>
&gt; superclass - the DeviceState. If a property is just for initialization=
,<br>
&gt; like &quot;vendor&quot;, it should be placed in the instance_init() in=
stead of<br>
&gt; instance_post_init().<br>
&gt; <br>
&gt; In addition, if other places handle it similarly, the device&#39;s<br>
&gt; post_init seems pointless. :-(<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Zhao<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000005a500e0638f12de9--


