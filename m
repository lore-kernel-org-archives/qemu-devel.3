Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911AAE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt6uA-00068v-P2; Thu, 19 Feb 2026 11:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vt6u3-00066E-FB
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:29:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vt6tw-0005eH-Gd
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771518553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwD+0CQ3e63B6VTocbVysS2FDMDju3mAHzD6wESirjA=;
 b=K8s9Q19RmNbr1pCnPbmAk5TzLGFP7mVyhfuQXJ81mloQshPAkTOTqGA5zvTOQZQxY3qUnG
 0sxaCPmXWrqUc5GRMXgVpGshGBucF5m4nE4S9+4S+ElJMiRLGP3MSwGgZL3/s/4KICwZhv
 3/sD+whzfWfV7J8IP2qfgRljOHUtols=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-UpqZk7_2N8G-pMFFLjRAnQ-1; Thu, 19 Feb 2026 11:29:11 -0500
X-MC-Unique: UpqZk7_2N8G-pMFFLjRAnQ-1
X-Mimecast-MFC-AGG-ID: UpqZk7_2N8G-pMFFLjRAnQ_1771518551
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so6542875e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:29:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771518550; cv=none;
 d=google.com; s=arc-20240605;
 b=FL2aLKXOdHUSO3JeyiEPxO5/olintskfitKVha5O9tBezJf6m5W+KyEXnD0L3tM/4b
 1a8VHbxAUHHPmuA9vEj8Q1f4qVW/cvbFcusHmw6Vq/WEg97x4ZVEpSKblh6kFYoIsRNr
 FTBfQ0v/9jXYj8OkOnIOUB3XkISP00jxUKODRQOAujxn1f+9y+Wdjmm7NmP9CnyeIuNW
 7+PP7z8RqcbPIW6FyMmgIIEiURDJHBvysGEuRT8mi/tbq4FcYJzr4CbVmwHKa3/mQ5yk
 60BkeYApyjM313iTXO7sxsGmrjINafGvRqwhtwWmrTiIsIFk+vlvtwp3duDYZJnxtAvK
 bqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XwD+0CQ3e63B6VTocbVysS2FDMDju3mAHzD6wESirjA=;
 fh=Mkkr66XCtiupVyLaeq0gy6M3nlaHK+QB/HhP1nhgLK4=;
 b=EJl1Yh7dMGbiYw1sb6kg7GsoMKzWiYjQVEl36s+mRTMyolUFCIoaFYFJt4iXIw8V9Y
 1uACWwCPiTMlwiOvyQ/uv6C052WuPQwQrIH5Ziz1u5uwjs+fyiQI8e4rboHftkKd2PJR
 sJC8Jgwtc6cPQclB+6dKEouKqey7MMUSVZuFzfAhXG71isGmohD7kVtGLDXERVZw7TGw
 rcSENdTH6Om/3nViB3+Vs3WP3Qq6yn8yFIpczJY1ZpXH9DOQ79kJaQMneM8QOV9poPbJ
 aDRxYwtkeaaXVp0EGwpKyfwJqfNu0S6mg3Y4kjeWFdODvp73+KS4uBKLHH0jGIEvG8SS
 qMvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771518550; x=1772123350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XwD+0CQ3e63B6VTocbVysS2FDMDju3mAHzD6wESirjA=;
 b=QnCS/wOvuRFHJuHE+qypM+m+5pccnvusL7k7/ee3WBl8irKjfU9tJtfiiZkKZnMlnQ
 WR8AwDxg0ZsCiLuPB7gvne57vI1dats+oHuCPnD2LyklSZuuFjxqM1hcytgy2jLA6QO6
 +m2QhkRwSeN9zUQxaTbhqmeFALBqaGBlKv86aBbBAu1AFBiJJDPt5Nf3MfquxxZ6lBf7
 rsgNIG2QqrAoAzqtuZvhXGMQ91Ad7gt6bkTykGhfbHEVMSeoHzpV9oZyAmMyJz7SrJqN
 Cmv3g3385EtlNe0IhpoAqA3hCNObvFIinkJHOQpKMXWUWnLJ1Shq17C/2R6AjjrQyQLy
 BYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771518550; x=1772123350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwD+0CQ3e63B6VTocbVysS2FDMDju3mAHzD6wESirjA=;
 b=NWniJAeGavN0aotnzHJx0q1PmMr8p8xoriNSwtLrMv4tVXj8ELkCRMFqFuP66opv7R
 8X7yXyLzsL9yoCeWTgOTH5juxtkc7gir5i5qSSvwQzq5Qn4wyvttsbiMGqiXs8JbP6n0
 JTsZ5i83hAXjB9BVP7c/XghNizeU1kgc1W9DqZaTujNVYNzJituAhPiCtkmvatTe2bw9
 WWZgJIDaW60YLswZz+zPibiE3sdyIi91AUYKK9awrnWkwDxMR2dongt0nIHSh89/goPV
 omWvhDuLkBYXuGtIRS6Tl5zsVizh5wpxWB5HEhyB2Vbwf6Bf7og7uFPdDnh1iGXRqLXm
 +8hQ==
X-Gm-Message-State: AOJu0Yzo9D9MKYKU2/VYkhN1vAohqzjAKjoMVAB1IY2FJbMq6cPOdSdo
 BLXmTsSLWCJ1/BRMTGKT7EKvFP7ora1qbTtfSUHFD1EDsdgsfTiIczhNGKSng7GdNgZYLUcuMFc
 TrJYzJuRwzYXczWjeCCQU6CRRFezVA0hYz3bKy8eF4yufafFFXO5qyQT4BlQ967qfLzvVQBbEEh
 yrrMrcHDQ5T8hBvUrrM0oAbuVNVmcwH/U=
X-Gm-Gg: AZuq6aKtwxK3jsmLNIjb7vH8W/5aWdmmZa/2iGcqtcbNayxlm51FzD/PBNEKK9nizUB
 Kxk56kIPYZvRQs6CO9M/9Ynjia2+N0pwXHj5bxZSQMGHAcp0R/hWBNb1w1yKrZ6ELhLJip5M6ma
 B5O3eA+oeljmW815pQ4Z0BOcBkL9avlXuNIToeVelo+TOEX7JVBGOVz+EgzPf2PbSwtsLjRNadO
 bqRyrj0Va2iLGsn01DhuilGXJuoYd1sPcoovAuy8OYZaBMakOEgBHRAmGpTmV8pdNKViEb0rv0D
 3bXvOPA=
X-Received: by 2002:a05:600c:491c:b0:483:7eeb:4558 with SMTP id
 5b1f17b1804b1-4839fe8e8cdmr24246455e9.2.1771518550515; 
 Thu, 19 Feb 2026 08:29:10 -0800 (PST)
X-Received: by 2002:a05:600c:491c:b0:483:7eeb:4558 with SMTP id
 5b1f17b1804b1-4839fe8e8cdmr24246165e9.2.1771518549975; Thu, 19 Feb 2026
 08:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <877bs8rgwx.fsf@pond.sub.org>
In-Reply-To: <877bs8rgwx.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Feb 2026 17:28:58 +0100
X-Gm-Features: AaiRm52hbEv2OYk4t7_dHMn2_YlDa02QhjIrHGlosPokXS_KprGZzx6uShFyOuE
Message-ID: <CABgObfYEvZnTHBhz3VrN61Wqa21TV+JV_HF=1Y8iMzvx5LQ_RA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e27a72064b2fcdb2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e27a72064b2fcdb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 19 feb 2026, 14:39 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > This adds two related parts of the Rust bindings:
> >
> > - QAPI code generator that creates Rust structs from the JSON
> >   description.  The structs are *not* ABI compatible with the
> >   C ones, instead they use native Rust data types.
> >
> > - QObject bindings and (de)serialization support, which can be used to
> >   convert QObjects to and from QAPI structs.
>
> To and from generated Rust structs, I presume.
>

Yes, or enums=E2=80=94and actually any (de)serializable Rust type, of which=
 QAPI
structs should be the most common case.

> As an example of how this would be used, the marshaling functions for
> > QMP commands would look like this:
> >
> > fn qmp_marshal_query_stats(args: *mut QDict,
> >     retp: *mut *mut QObject, errp: *mut *mut Error)
> > {
> >     let qobj =3D unsafe { QObject::cloned_from_raw(args.cast()) };
> >
> >     let result =3D from_qobject::<StatsFilter>(qobj)
> >          .map_err(anyhow::Error::from)
> >          .and_then(qmp_query_stats)
> >          .and_then(|ret|
> to_qobject::<Vec<StatsResult>>(ret).map_err(anyhow::Error::from));
> >
> >     match qmp_marshal_query_stats_rs(qobj) {
> >         Ok(ret) =3D> unsafe { *retp =3D ret.into_raw(); },
> >         Err(e) =3D> unsafe { crate::Error::from(e).propagate(errp) },
> >     }
> > }
>
> Scoring 0.23 UOUPNBL (uses of unsafe per non-blank line).  SCNR!
>

Well, that's why you automatically generate this! You could also use only
one or two unsafe blocks but I preferred to mark explicitly the code that
requires it.

Paolo


> > Despite the long v1->v2, the changes are mostly cosmetic; there are a f=
ew
> > small differences in the detection of types to be wrapped with Box<>,
> > because Vec<> is now considered to break cycles.
> >
> > Available at branch rust-next of https://gitlab.com/bonzini/qemu (which
> > is now almost empty other than this series, yay).
> >
> > Paolo
>
>

--000000000000e27a72064b2fcdb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 19 feb 2026, 14:39 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; This adds two related parts of the Rust bindings:<br>
&gt;<br>
&gt; - QAPI code generator that creates Rust structs from the JSON<br>
&gt;=C2=A0 =C2=A0description.=C2=A0 The structs are *not* ABI compatible wi=
th the<br>
&gt;=C2=A0 =C2=A0C ones, instead they use native Rust data types.<br>
&gt;<br>
&gt; - QObject bindings and (de)serialization support, which can be used to=
<br>
&gt;=C2=A0 =C2=A0convert QObjects to and from QAPI structs.<br>
<br>
To and from generated Rust structs, I presume.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Yes, or enums=E2=80=94and act=
ually any (de)serializable Rust type, of which QAPI structs should be the m=
ost common case.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">&gt; As an example of how this would be used, the marshali=
ng functions for<br>
&gt; QMP commands would look like this:<br>
&gt;<br>
&gt; fn qmp_marshal_query_stats(args: *mut QDict,<br>
&gt;=C2=A0 =C2=A0 =C2=A0retp: *mut *mut QObject, errp: *mut *mut Error)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0let qobj =3D unsafe { QObject::cloned_from_raw(args=
.cast()) };<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0let result =3D from_qobject::&lt;StatsFilter&gt;(qo=
bj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .map_err(anyhow::Error::from)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .and_then(qmp_query_stats)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .and_then(|ret| to_qobject::&lt;Vec&=
lt;StatsResult&gt;&gt;(ret).map_err(anyhow::Error::from));<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0match qmp_marshal_query_stats_rs(qobj) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Ok(ret) =3D&gt; unsafe { *retp =3D re=
t.into_raw(); },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Err(e) =3D&gt; unsafe { crate::Error:=
:from(e).propagate(errp) },<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
<br>
Scoring 0.23 UOUPNBL (uses of unsafe per non-blank line).=C2=A0 SCNR!<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Well, =
that&#39;s why you automatically generate this! You could also use only one=
 or two unsafe blocks but I preferred to mark explicitly the code that requ=
ires it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_q=
uote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Despite the long v1-&gt;v2, the changes are mostly cosmetic; there are=
 a few<br>
&gt; small differences in the detection of types to be wrapped with Box&lt;=
&gt;,<br>
&gt; because Vec&lt;&gt; is now considered to break cycles.<br>
&gt;<br>
&gt; Available at branch rust-next of <a href=3D"https://gitlab.com/bonzini=
/qemu" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/b=
onzini/qemu</a> (which<br>
&gt; is now almost empty other than this series, yay).<br>
&gt;<br>
&gt; Paolo<br>
<br>
</blockquote></div></div></div>

--000000000000e27a72064b2fcdb2--


