Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C76C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2bW-0001Vo-B2; Wed, 02 Jul 2025 14:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uX2bM-0001Jd-Er
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uX2bK-0001ic-6w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751482471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWpPA+/Hn8njnJ1tCrLg9w91wEBQlvmdEnGXHKOD3uc=;
 b=agJzpQjaYh6tqlje34/UccZyu6z5Q2ni+WRpDJXiflvkGfJL2ufr25muFYH3agnFDWZ+xX
 0rjtIojOSkkvlwf7P0DbidL4exey8QVFzu2CCPzOvUihgKvN+Sno7CUkRfbaQuJ/c+CqMs
 XKJkPEyHT6pT7lk7IeCsad/bRUd9274=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-b5B08DuZNCa0Hvzo9BT_aQ-1; Wed, 02 Jul 2025 14:54:29 -0400
X-MC-Unique: b5B08DuZNCa0Hvzo9BT_aQ-1
X-Mimecast-MFC-AGG-ID: b5B08DuZNCa0Hvzo9BT_aQ_1751482469
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so3558994f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482469; x=1752087269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IWpPA+/Hn8njnJ1tCrLg9w91wEBQlvmdEnGXHKOD3uc=;
 b=RZhqMm8nwwbjQhBOC0ne/VJtzdCL6QkhZQ3LCREqEy1oWvuMCbS/LI3Y9EZHp5JU1S
 OKbsH/cT2Bs12/eJD+oZRKoCpAVE9SL+WfmFQtMpXMwV4dViy21nHemioQ5eYc2tq4+Z
 I1NmPWQr1B6sHX9N5msqgzkKdXUBCXJjwOGc061VDx8fnDOmfQHrdcQ+cLbEY5wj5hxO
 BcXYIIJYBZGA3QIJ4E31GmRhmxgtMLkx9m4+BqPqNj/TDJsFMkvdFjbC5w7y/24mR/3J
 dvJ3RwIWNpehnb+YClaLg4kr0EO7Mnssvl9YHtE+eoKCgK/ZvzhsT0mXawHuIetuMFSq
 xR/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrrQzQ9dQr1qeGcs7qHDkYTIaftz3/SUrqcs0dyZ6ZwsogR1SxInLdqZ9WJ4lAoP/43TRNZCUB2APw@nongnu.org
X-Gm-Message-State: AOJu0YxxvjK7MIdPtJ+WeqrqDQ7bfA5LFmTFfOEXoEC3/XBQ/jY/tEyN
 leTXQmHnaeTsDx3FVtSa/3DYYbuKaaDd5B/fFeQ93PavtozoE/bXdRLgOKw1+hXgLoiHUfA1Fwi
 OSj51FUEHvGHLKqrdLRjSE2SQFYZ3UYOtB1/5bZV55ZO6mqrm0QitVKSPHi3wkq/lLtrp/adfHm
 +yLzYxIL0AUo6KcDU+eW7d6p0ESwzQWKA=
X-Gm-Gg: ASbGncuX5A7KvmwQaFjgjWUrzC899Pcr08aNKCZmeLVqp7ELIvdPDnf8nayvwWhNpYk
 mYsZIWjIQ8UDoK/AHKqUte0o/xwjPjhqqa2t7tYoskI26wePqHz96PbLXriLr6C1qJoPuwZ+Vcr
 caCw==
X-Received: by 2002:a05:6000:2d09:b0:3a5:26fd:d450 with SMTP id
 ffacd0b85a97d-3b20110b55fmr2109472f8f.47.1751482468621; 
 Wed, 02 Jul 2025 11:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq2je9fXlnnuSRE0rEsDTjEfgJxiXfI0yI1NCxQUav4ZBkNiIwwyBZh7yzljmw+IawlpqYSQPBRcRO/16gvg0=
X-Received: by 2002:a05:6000:2d09:b0:3a5:26fd:d450 with SMTP id
 ffacd0b85a97d-3b20110b55fmr2109463f8f.47.1751482468203; Wed, 02 Jul 2025
 11:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com> <aFpocfTpBLB34N3l@intel.com>
 <aGKryLSGlFTMSKHv@intel.com> <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org> <aGTmFGC9vZB2yEwv@intel.com>
 <76f8e877-e203-421f-b301-4b321534bd8b@intel.com>
 <CABgObfY-sDqw3kPSgr8b3OycA2wZVYQLcxcavierdbr-U0S_Dw@mail.gmail.com>
 <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
In-Reply-To: <f7545434-f51f-4cb5-b1b9-afbaa26d11e8@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Jul 2025 14:54:16 -0400
X-Gm-Features: Ac12FXy8bxGUFDfN3GKxitQDLCMDQE7_B-TvmwRHGpBkH0NcxWA3_rxaO4d9g_I
Message-ID: <CABgObfax21xZDKGN9b8tH-HBVeEgTjWD-xLO6DRkr3uCvkyHQQ@mail.gmail.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005916a40638f6cad6"
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

--0000000000005916a40638f6cad6
Content-Type: text/plain; charset="UTF-8"

Il mer 2 lug 2025, 09:25 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> IIRC that's on rhel QEMU which ports the TDX code before it's merged
> upstream. Now TDX is upstreamed, it works with upstream compat property
> and I think future new compat property won't affect TDX or anything,
> since it's compat property and it's to guarantee the existing behavior
> when introducing new behavior?
>

It's a compat property that is only added by RHEL-specific machine types.
But the bug is not specific to RHEL, it just happens that no upstream
machine type has compat properties that overlap with TDX adjustments of
CPUID.

> In general I don't see how the reverse order makes sense: the subclass
> > knows what the superclass does, so it can do the right thing if it runs
> > last; but the superclass cannot know what all of its subclasses do in
> > post_init, so it makes less sense to run it last.
>
> I agree in general the parent to child order makes more sense,
> especially when we treat .instance_init() as the phase 1 init and
> .post_instance_init() as the phase 2 init.
>
> But the original purpose of introducing .post_instance_init() was to
> ensure qdev_prop_set_globals() is called at last for Device. Reverse the
> order breaks this purpose.
>

Not "last", but "after instance_init". Anything that happens in the child
class's instance_post_init can be moved at the end of instance_init, just
like the refactoring that I did for risc-v.

Paolo

It seems not good option like the reversed order from child to parent
> that can achieve it by just putting the last step in top parent's.
>
> I'm looking forward to seeing a better solution.
>
> > Paolo
> >
> >
> >> So I think we might revert this patch, and document clearly the reverse
> >> order of .post_instance_init() callback.
> >>
> >>> X86 CPUs have the issue (e.g., "vendor" doesn't work) now because
> >>> they - as leaf class, don't care about the property values of
> >>> superclass - the DeviceState. If a property is just for initialization,
> >>> like "vendor", it should be placed in the instance_init() instead of
> >>> instance_post_init().
> >>>
> >>> In addition, if other places handle it similarly, the device's
> >>> post_init seems pointless. :-(
> >>>
> >>> Thanks,
> >>> Zhao
> >>>
> >>
> >>
> >
>
>

--0000000000005916a40638f6cad6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 2 lug 2025, 09:25 Xiaoyao=
 Li &lt;<a href=3D"mailto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt=
; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">II=
RC that&#39;s on rhel QEMU which ports the TDX code before it&#39;s merged =
<br>
upstream. Now TDX is upstreamed, it works with upstream compat property <br=
>
and I think future new compat property won&#39;t affect TDX or anything, <b=
r>
since it&#39;s compat property and it&#39;s to guarantee the existing behav=
ior <br>
when introducing new behavior?<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">It&#39;s a compat property that is only added=
 by RHEL-specific machine types. But the bug is not specific to RHEL, it ju=
st happens that no upstream machine type has compat properties that overlap=
 with TDX adjustments of CPUID.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">&gt; In general I don&#39;t see how the r=
everse order makes sense: the subclass<br>
&gt; knows what the superclass does, so it can do the right thing if it run=
s<br>
&gt; last; but the superclass cannot know what all of its subclasses do in<=
br>
&gt; post_init, so it makes less sense to run it last.<br>
<br>
I agree in general the parent to child order makes more sense, <br>
especially when we treat .instance_init() as the phase 1 init and <br>
.post_instance_init() as the phase 2 init.<br>
<br>
But the original purpose of introducing .post_instance_init() was to <br>
ensure qdev_prop_set_globals() is called at last for Device. Reverse the <b=
r>
order breaks this purpose.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Not &quot;last&quot;, but &quot;after instance_in=
it&quot;. Anything that happens in the child class&#39;s instance_post_init=
 can be moved at the end of instance_init, just like the refactoring that I=
 did for risc-v.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
It seems not good option like the reversed order from child to parent <br>
that can achieve it by just putting the last step in top parent&#39;s.<br>
<br>
I&#39;m looking forward to seeing a better solution.<br>
<br>
&gt; Paolo<br>
&gt; <br>
&gt; <br>
&gt;&gt; So I think we might revert this patch, and document clearly the re=
verse<br>
&gt;&gt; order of .post_instance_init() callback.<br>
&gt;&gt;<br>
&gt;&gt;&gt; X86 CPUs have the issue (e.g., &quot;vendor&quot; doesn&#39;t =
work) now because<br>
&gt;&gt;&gt; they - as leaf class, don&#39;t care about the property values=
 of<br>
&gt;&gt;&gt; superclass - the DeviceState. If a property is just for initia=
lization,<br>
&gt;&gt;&gt; like &quot;vendor&quot;, it should be placed in the instance_i=
nit() instead of<br>
&gt;&gt;&gt; instance_post_init().<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; In addition, if other places handle it similarly, the device&#=
39;s<br>
&gt;&gt;&gt; post_init seems pointless. :-(<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Zhao<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000005916a40638f6cad6--


