Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B70EE6B45
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPxR-0002J2-AL; Fri, 06 Feb 2026 12:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPxP-0002C6-Kh
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:49:27 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPxN-0005Rr-Fb
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:49:26 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34be2be4b7cso1389824a91.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:49:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770400163; cv=none;
 d=google.com; s=arc-20240605;
 b=fBmXMwFSkB6i79/SCa8D/D73Pd6XpzvqdRZ8GsUZzGcHDICTCaxAs3jVSW2QkjY0/v
 8lX+wIr9lG0k7zV9LMg9ybLs3Wka1gGD9w2WoDhrvCDf2rPpSWumIDXOR5kKgwlebepK
 D/KkHCvrH2fn3zONMa2rhZkrNtgFXmg28plvRhmu7mtZOD9k91ubIhrM0k0QhzV1KBHV
 QZb+yqA0Tw7WL6uANNpvULqr9if9d7pNG+U3+eVJf9uJb1ClkqoCr3Q+gsc+4lBtmz6e
 ayh3O6FLXmQj9siGTy+RKSqBp6ItDosVHYOv7haIKrj8cHx1F0A50TYLa7H6ESpFPh0M
 rMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZTMVztiD88Zq/8BA0XwI4410TcwDLl8RZXNipWI6e0=;
 fh=KZjezXCSrxx39dO31pbOeDiyxGEGLz3PIZWBEAGptp8=;
 b=KQn0/gMClIy3Axh6VLXkKu1oFhkj2+z0Gawn+gaqx057RQZMSksHkI/go4q3NKnvuO
 zmSgRjVYrUOeMUaAIFr4o00dl/m99Qx3Yi455M+4e5eyffruqWGCtgkBcNk8PGpmVFyI
 o2Xx8VL71I9SlH7lJfMJXLvLtRbpuaM1phO/ArZNna9lqTy0MKd5hynr2NWBscL6I0DW
 XAlJthh4djZ6OP4s2uYmkTladaoLoOOluN5JtY0Y2iPX2M4pTWW4avz7oYJ5Rd1YNvZM
 S2Z9zwPdsvePxL3Yj3TNi9X/q86VrwbS8VA4Qw/tbMpcWLGVGCrTzHU21POK9Q/6hA7Y
 6keg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770400163; x=1771004963;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZTMVztiD88Zq/8BA0XwI4410TcwDLl8RZXNipWI6e0=;
 b=OYy96PZGIm3SuKSDswC+T7/0MqtmzysWHSATez7sxEfuIWvcHN0P10T0KoVab2tK+M
 8i68+gjWR+IAbvxDoRD/6JHVm4IdqU7m4sXZ58PQrs3ZQ+40/OWUqfnefGLYUSPzb2YK
 MuX9qdoXAwXuSYrz1OKutuK2ETpr31ncsacnyd51BfBFaVbk8vvW1Ms/r/NoB5WQXhj1
 6xP6Lkop+swfa4R8/xFzh2J/VHfzEvUrISnzDZAh7qXBuq37TiJbkCKWtCZ06q80U+Iu
 JP5NI7npfflNCCiuNQWXYSwNGD70lGq3MdYdfWtphZQdASP9uotzxCz9ZRdSJUWK59u/
 JZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770400163; x=1771004963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZTMVztiD88Zq/8BA0XwI4410TcwDLl8RZXNipWI6e0=;
 b=jSvSmTb7RYRnzsVLjRZCPcbfaKK6oaWglkMGFariKqSIUVvAdWa7KLwd6KbE85hJla
 qjxG06J7MJeOZFQ9/xRLpvNKm68ZvZE/CL1Ldae1wrQe/9v5w0XAXwDGIn25r7g7HN6/
 dbSBELHra7rBm7QcCUmtq4QCLBzD9AH3tdUpQtoVfCP14eKvXBn+R4HUH+RaBu08BQnc
 aMMSlchSbCkDs9vcn4i7E1MZOIwZsTxlSVbPGRq47B5GXES5ZpJ5ByinD9alU6L2/50y
 kb4Qt2AsVcvSHEw8SQs3lXRgnvf+FodypZq+oD5bC0s1d8b4WpC3cCkBx0B5DXDScuaY
 5nXQ==
X-Gm-Message-State: AOJu0YxCavgwcXJEs7bMQ7P7KbYKDHD/kEz9hrw2/zBTh0yaCAp7Ws50
 g1Nhro4ZvIHVX3GDaTR2m3xNjS7HtlD0vswqLPoNfD+TDO9p4g/rJBcf4kh8ZIzaHabvw2fUkKu
 5b7yXgqpVjy1Ilzo72YIFQWl1D6r6/AMu9sAVLv52eg==
X-Gm-Gg: AZuq6aIlyscd3nBydrQerDmbxf4t1svH30zq4xyaPwLMYP+0cMVOvmNqQZhie37BA+J
 hMM7Ll4P/mvrO4NXdqAhlzIu32GQ3whNUk3K4hWByd6FHl5L5Ol6/50oL/b0U5P9512pHLDqj2d
 UxW4pbQfJolj1NTn9MjQJzLFFRXXt/XnyvHPszct5CsDzxcrMo4y5taVvH/6c/BkcZ37mzTWUo/
 zuLaxAPlsa812rg9EouwIMsxOl0j+vMwQbQOUuSOrFtx5KLjzhOawSK0me/4CjcZkfUndo=
X-Received: by 2002:a17:90a:d40e:b0:340:bc27:97bd with SMTP id
 98e67ed59e1d1-354b3c84050mr2561166a91.9.1770400163113; Fri, 06 Feb 2026
 09:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-15-8d8ff0035372@bsdimp.com>
 <4c338621-eb9e-4048-9f1d-cb4f3ab6b259@linaro.org>
In-Reply-To: <4c338621-eb9e-4048-9f1d-cb4f3ab6b259@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:49:11 -0700
X-Gm-Features: AZwV_QgmKTsuK-R-qnyTdNjpNsHJ3RbEMDjnTbAOXU_Bwzhqwfaa6KdscQ_i9nY
Message-ID: <CANCZdfqeJ1kKXTZtedUdbBZg-ygviGRGJN03kBDHitSPQW=RHA@mail.gmail.com>
Subject: Re: [PATCH 15/24] bsd-user: Add do_bsd_uuidgen implementation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d53c9e064a2b68af"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d53c9e064a2b68af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 8:08=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add implementation of uuidgen(2) syscall that generates UUIDs and
> > converts them to target ABI format.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > index d81b4fbaef..b722c63437 100644
> > --- a/bsd-user/bsd-misc.h
> > +++ b/bsd-user/bsd-misc.h
> > @@ -43,6 +43,40 @@ static inline abi_long do_bsd_reboot(abi_long how)
> >       return -TARGET_ENOSYS;
> >   }
> >
> > +/* uuidgen(2) */
> > +static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count=
)
> > +{
> > +    int i;
> > +    abi_long ret;
> > +    struct uuid *host_uuid;
> > +
> > +    if (count < 1 || count > 2048) {
> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    host_uuid =3D g_malloc(count * sizeof(struct uuid));
> > +
> > +    if (host_uuid =3D=3D NULL) {
>
> g_malloc will never return null.
>
> > +        return -TARGET_ENOMEM;
> > +    }
> > +
> > +    ret =3D get_errno(uuidgen(host_uuid, count));
> > +    if (is_error(ret)) {
> > +        goto out;
> > +    }
> > +    for (i =3D 0; i < count; i++) {
> > +        ret =3D host_to_target_uuid(target_addr +
> > +            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]=
);
> > +        if (is_error(ret)) {
> > +            goto out;
> > +        }
> > +    }
> > +
> > +out:
> > +    g_free(host_uuid);
> > +    return ret;
> > +}
>
> Can be improved with g_autofree instead of goto.
>

Will fix both...

Warner

--000000000000d53c9e064a2b68af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 8:08=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add implementation of uuidgen(2) syscall that generates UUIDs and<br>
&gt; converts them to target ABI format.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 34 +++++++++++++++++++++++++++++++++=
+<br>
&gt;=C2=A0 =C2=A01 file changed, 34 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; index d81b4fbaef..b722c63437 100644<br>
&gt; --- a/bsd-user/bsd-misc.h<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -43,6 +43,40 @@ static inline abi_long do_bsd_reboot(abi_long how)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_ENOSYS;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* uuidgen(2) */<br>
&gt; +static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int coun=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 abi_long ret;<br>
&gt; +=C2=A0 =C2=A0 struct uuid *host_uuid;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (count &lt; 1 || count &gt; 2048) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 host_uuid =3D g_malloc(count * sizeof(struct uuid));<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (host_uuid =3D=3D NULL) {<br>
<br>
g_malloc will never return null.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_ENOMEM;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D get_errno(uuidgen(host_uuid, count));<br>
&gt; +=C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; count; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D host_to_target_uuid(target_addr +=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (abi_ulong)(sizeof(struct t=
arget_uuid) * i), &amp;host_uuid[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +out:<br>
&gt; +=C2=A0 =C2=A0 g_free(host_uuid);<br>
&gt; +=C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
<br>
Can be improved with g_autofree instead of goto.<br></blockquote><div><br><=
/div><div>Will fix both...</div><div><br></div><div>Warner=C2=A0</div></div=
></div>

--000000000000d53c9e064a2b68af--

