Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4394ECA5FAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZNO-0006xt-Qd; Tue, 29 Sep 2026 11:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZNN-0006vN-6z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZNL-0005Gb-Ll
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790694251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/idTMvuA6rFwQ+F8Gojng9AyKsDBF0p3n4yB8mXyzA=;
 b=S3UUKO+JHus974f8v4bDkOMUZngJPVSRtpaYZXZtl2Go1gyFMPtyxMUaFljcJxF3NMGTgF
 PxhoHvZiiZ1btPINcWQHXJgBQf1a7TQGOi8cBG2yWa367fELwI3ZZOmOf5dwa4XRFookX8
 +rT6RQTPuFH3DNluNsXZqszImurmre0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-mL8f14AINLqj4PDRgWQDlg-1; Tue, 29 Sep 2026 11:04:08 -0400
X-MC-Unique: mL8f14AINLqj4PDRgWQDlg-1
X-Mimecast-MFC-AGG-ID: mL8f14AINLqj4PDRgWQDlg_1790694248
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8ab3f890f30so10548297b3.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790694248; cv=none;
 d=google.com; s=arc-20260327;
 b=NXV05hsT8OxY2Bs+DjILymWmiaEaq7BzfXhw/FKVpp8WhyHGmF6bY0yyrEADvzGX1W
 E4l6QwqjDgEVHxU+TSfXe1OV7kQ4E0a9+TKBejK1L1LnbyHkhrniEBxUkXuMo+DATcTk
 IQ+p/rSqtSUqCknkIwkCjSeibMhfJNYhMn8BtB0VQL/bvVxTXfuPX5LAAm+VwtzzTnSe
 tAwDoJ3fez1yHpror60cGF4vxZYWWIGVQYAm5WFiEtB4v3bRn8KqD7hqkC51uCjPe/hj
 eDziYjbelkwrGE9w9DnSRuQxSf8nZdrN5sTF4d0hjowSZXW3vEV17KOyFlo5LeVSfaC6
 rwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m/idTMvuA6rFwQ+F8Gojng9AyKsDBF0p3n4yB8mXyzA=;
 fh=n+2DAFMZlHp3F1d4nio56yaatBOIj9xQxACGOxQdYUk=;
 b=ECE9BOGYg8z8m3317MFXGxtDCrY5VeFjgRB4xLqxIR8rlqJdIfrAhqHCdAjP1ffGp/
 Dg0ZgsuBtwvwEeDHT9sRSjVnsIAWr8HRivi0YvvitymoicLM70RGrseVORBkGCx224Fe
 N3bLLxOVKU1eB1bntF4I2IDV8rsoNscrPaeW21ZCopCiGfVYI0jh4Y/f5Vfgt832t75Q
 FaI3XfKGRSUQrcLBqdi3LPJoHC+TmWQtjJb1MC0H6WpqQ7ZLC02qYbQ/kyS30fFBpFQI
 Qsm9nwVl0iUnPV2/XZDVgUhFXSZHOHvCyzX1fOrruFcvq9sQ2SnbH2YZlUbDW33vMGZT
 aAzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790694248; x=1791299048; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m/idTMvuA6rFwQ+F8Gojng9AyKsDBF0p3n4yB8mXyzA=;
 b=s6kBK26noC5eIPQikf8bQDnz/Q8sR0vPdLmGJfAvsuFAMgRD8yC6JGdVctYeEO2Ol+
 sPiJEH6RlkGXFJVyXS6eWlQeATl+P89jbr4xRP5TGTpnxZD3t7x3TaBw3SJcWoAUz5Nb
 nu/BAUZhH5TF2qcwI+FgmabltGZpdq9du9pDt23I2N1oSS6WGApuTfmvCHNGTw1WnMj6
 Nu8kDV4Lj9GE9A6VORWUY0I7pNp5MHWZiOrBh1/jK7y1OZtatqErhFw1nty0O32MGwBI
 NrC7QiB28LACdi8auuh5pBzDKKALdl8GC/uJfskrxwMm3xuSA0riWiTVj92Niuuc0E5V
 /nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694248; x=1791299048;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m/idTMvuA6rFwQ+F8Gojng9AyKsDBF0p3n4yB8mXyzA=;
 b=ShiBEPKHINK3Jx4ltoUA6g2fVwjOQ3C1XsXHRtSaN3MoFZCsr61X1mcjiMH6NAy+fN
 4GSYiF+NpyCvXnPPOgMoWYksFfeH2v4pS9u/EbEabD4tS4CDUij8D38ZhNximYjJSzLW
 rIkd9osa1I1ZCifYe53R5u60EUiUIrZUEWZK31RdrhMbn9ma22lX5ZLFIrw14qYXdfdX
 2wDXpoCsGkJkc6s06cMgbYfEjbx40bK7D9nLOUx1Y6FXJ7Y+JjI3+CuYBxthjDYSxdNR
 BmYXjVwz7SeEMYdknLkqy/VZQ1/gVE4/25uExhDaYsgV6B8vH+LRPlnrZObP7ENHNI6k
 WpsQ==
X-Gm-Message-State: AFq9FYKBkQCQIsF7HJ2HHmK2TR0hxEc0c14wHi/HWLcpP15eKbqG5vEj
 Yzci3ejhTFyeIXhpi1ucxMQaPgiIPjxtO9G4zV+ND/lNe5QB9fB7574+qH/GJsqnS88VZKRthB1
 wNwG4FN9XfemSGH81xv7+HO88K2ruEa+hIOfHQYj/EndGDlIF1FT0leReB9agnjSyoWFw6gUh/v
 7j4L9PXcYb5HUEeJYsC/WXMj6YO+sJbCY=
X-Gm-Gg: AYBFou2KmlRAdQB6G3aWSqp2evQFoC8vXYuu2aPeHxHkBHC5x1+wyTKOK+0AxUxWdXH
 7EAGVDbhsiXdWVfDwjlNDOegquFoE9gLBBuDjcvxxRyNbidZlrZJ3mhnezRj5htn418PZQwox7j
 VmVGUMlHIkKNPWwH8rEqp9LOAPLa2Y91siIaCwPbz6cOS4GqYb7OzMXyaYYoI89SgV58zVJA5fP
 FcUoGITZjlsb40=
X-Received: by 2002:a05:690e:11c3:b0:675:47ba:2182 with SMTP id
 956f58d0204a3-67547ba269dmr2476071d50.88.1790694247701; 
 Tue, 29 Sep 2026 08:04:07 -0700 (PDT)
X-Received: by 2002:a05:690e:11c3:b0:675:47ba:2182 with SMTP id
 956f58d0204a3-67547ba269dmr2476018d50.88.1790694247200; Tue, 29 Sep 2026
 08:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260928192557.509157-1-jsnow@redhat.com>
 <20260928192557.509157-11-jsnow@redhat.com>
 <875wzo378n.fsf@pond.sub.org>
In-Reply-To: <875wzo378n.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 11:03:56 -0400
X-Gm-Features: AclHuK_5ErbMBr2p9Srem-0xCgT94jZnUaKHfIefG4XpmhEijPBEeTOKiqrbW6M
Message-ID: <CAFn=p-bfvqDqdsqHWF7QSF_v-gWHcZ0ZKCt+nfwg4dhjhGzXwA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] qapi: split intro sections for inlinable structs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="00000000000081a499065ca07e38"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000081a499065ca07e38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 2:24=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch splits the intro/details section for structs which are used
> > in an inlinable context; i.e. structs used either as arguments for a
> > command/event, or used as a branch of a union. The QAPI documentation
> > block for these entities will have their intro section left behind
> > when inlined into other contexts, but will still display the intro
> > section on standalone documentation for these types.
> >
> > In general, this patch does not change how the rendered documentation
> > currently looks, except:
>
> Suggest to scratch "In general".
>

ACK


> > 1. MemoryBackendShmProperties and MemoryBackendEpcProperties see their
> >    member descriptions move upwards to just below their formalized
> >    introductory sections.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Happy to adjust commit messages without a respin.
>

Yes, please!

>

--00000000000081a499065ca07e38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 2:24=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch splits the intro/details section for structs which are used=
<br>
&gt; in an inlinable context; i.e. structs used either as arguments for a<b=
r>
&gt; command/event, or used as a branch of a union. The QAPI documentation<=
br>
&gt; block for these entities will have their intro section left behind<br>
&gt; when inlined into other contexts, but will still display the intro<br>
&gt; section on standalone documentation for these types.<br>
&gt;<br>
&gt; In general, this patch does not change how the rendered documentation<=
br>
&gt; currently looks, except:<br>
<br>
Suggest to scratch &quot;In general&quot;.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">ACK</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt; 1. MemoryBackendShmProperties and MemoryBackendEpcProperties see their=
<br>
&gt;=C2=A0 =C2=A0 member descriptions move upwards to just below their form=
alized<br>
&gt;=C2=A0 =C2=A0 introductory sections.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Happy to adjust commit messages without a respin.<br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, please!</div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"></blockquote></div></div></div>

--00000000000081a499065ca07e38--


