Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB956C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 09:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukfeL-0006zC-Q7; Sat, 09 Aug 2025 05:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukfeK-0006xr-3s
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 05:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukfeI-0000ng-A7
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 05:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754730836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4sFaDBsAHltZ5GuEpzWGIv12hdloTvt8SSNHAGDhhvo=;
 b=YEXBeGPj/7iUc/CFobPx1ZhURlBEGlcY2bpn/2YxLrMtwXamQMSyXDMyrUC5ffIb3YC+uR
 ZZ/33Iv4wh47J9HD0XvNLsYquasWzLB85DgFzoTkGmk+aluygf/6twmXah/SCfbLessYxn
 yvFQSF6qAba6+QMDLeTwFoCGvEMwxlc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-HtPxs5zQO3eDhpdZqzJgVA-1; Sat, 09 Aug 2025 05:13:54 -0400
X-MC-Unique: HtPxs5zQO3eDhpdZqzJgVA-1
X-Mimecast-MFC-AGG-ID: HtPxs5zQO3eDhpdZqzJgVA_1754730833
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b78b88ecfeso1560061f8f.3
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 02:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754730833; x=1755335633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4sFaDBsAHltZ5GuEpzWGIv12hdloTvt8SSNHAGDhhvo=;
 b=Ky07qx90eJxn6LeBf7cBi982Ru+fCk4Orzms0kpjHmu7k50n6rDwoPTm6Xncll027j
 2S52LOnb0WFgsl/s9+i5Vp5KaO1jMx5IXg+iMYp784xIN6hmWX7znG4g+otNRZTy7N6S
 cbYcqaVzTw1+zZE1lDFHwZ07lhK/70gX4v1pIYWEeGGtdq1m7iCOEHFSgUgUCopSr9fJ
 HBIN9EJeOv6xIRrdeEIjxzXGIpe3qa9d5ndRTyHMdPUB5OmVJYgr32GN1Bl3js32hHKD
 h5fmWUfYLFaGfmu7uQszfhaOZfBxpGryZ7TTTyn4jGzl64shorkvjbf6pbMtFlwp5Cqt
 SK7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw0+V++HEj8MzNiJ/N9nPrEoxEXWl+knS/sRT3hwHliWVVMGoMPjfmaxT0429MNWCql9rBTcx6LCie@nongnu.org
X-Gm-Message-State: AOJu0YzCkdv9NIYwmlYo8mUpruBg7ZdifYJlK36z9qm+eDKPTIeo6uH2
 Xj9oh9StfOFoeIJ4QA6mBmDDRSImuh/ttcmfk5sFiKOa8hWP8KciA18+kliPruGkcE095a37Pvg
 Vs2as0lRbzVXCZtgZxAA2VdYurp3F7G7T+3EBAlNeiLAumfVCaEj3RxH7YHXtOHN/MnFcRexPhK
 Bz+33FBhMiyg72oxuicW6kcPOG1v6V+FA=
X-Gm-Gg: ASbGncsfXb9LXMXDXlOXHszz3X4SNnikOZHVRi7U16WNJDLAVPH5iAEsxS03JclhZEX
 Ke7ysDXf3GtWWtj3LdkTrE2tBJfd6A2axccX0QhztJxsICTOntGYkU23wPtkknRpyOGkSIv4Uwa
 dPJaqz5cxdpSHkIW/UjxxM
X-Received: by 2002:a05:6000:26c9:b0:3b7:8c83:db18 with SMTP id
 ffacd0b85a97d-3b900b4720emr4318027f8f.6.1754730832769; 
 Sat, 09 Aug 2025 02:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQSdhGXKP5KEhjz7St91N9z5Hg0rsI7LUVVm6PCySup0F8zLqIi5LkRQMA8os4UpTwrqu5HPsxGX0oJ5vPM98=
X-Received: by 2002:a05:6000:26c9:b0:3b7:8c83:db18 with SMTP id
 ffacd0b85a97d-3b900b4720emr4318007f8f.6.1754730832379; Sat, 09 Aug 2025
 02:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
 <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
 <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com> <aJb3C8qbXQ1zx306@intel.com>
In-Reply-To: <aJb3C8qbXQ1zx306@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 9 Aug 2025 11:13:42 +0200
X-Gm-Features: Ac12FXziZgCk9yQBpnRuv1n97z8bDRBJ6nSJ5YngkSgY9GG0XrVt7H4BVWY4jQA
Message-ID: <CABgObfaVoYi09-HkwojkJT_-AJosdKNPwxMySHn6yn2cuS1Z5g@mail.gmail.com>
Subject: Re: [RFC 13/26] rust: Add RCU bindings
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: multipart/alternative; boundary="000000000000f0dc73063beb1bc7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000f0dc73063beb1bc7
Content-Type: text/plain; charset="UTF-8"

Il sab 9 ago 2025, 09:00 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> >     pub fn get<'g>(&self, _: &'g RcuGuard) -> Option<&'g T> {
> >         unsafe {
> >             self.raw_get().as_ref()
> >         }
> >     }
> > }
> >
> > Using this is a bit ugly, because you need transmute, but it's isolated:
> >
> > impl AddressSpace {
> >    pub fn get_flatview(&self, rcu: &'g Guard) -> &'g FlatView {
>
> IIUC, this lifetime is using the "branded type" pattern as ParentInit.
>

No, it's much simpler (that one uses the combination of for<'identity> and
PhantomData as explained in the comment). It says that the lifetime of the
returned reference cannot exceed the guard. It's just like

pub fn get_item(&self, array: &'g [u8]) -> &'g u8 {
   &array[self.0]
}

Except that the guard is only there to limit the lifetime and not to hold
data.

In addition, about rcu_read_lock_held(), I thought at C side, there're
> so many comments are saying "Called within RCU critical section" but
> without any check.
>
> So I wonder whether we should do some check for RCU critical section,
> just like bql check via `assert!(bql_locked())`. Maybe we can have a
> Rcu debug feature to cover all these checks.
>

In Rust you would just pass a &RcuGuard into the function (or store it in a
struct) for a zero-cost assertion that you are in the RCU critical section.

Paolo


> Thanks,
> Zhao
>
>
>

--000000000000f0dc73063beb1bc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 9 ago 2025, 09:00 Zhao Li=
u &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha=
 scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;=
=C2=A0 =C2=A0 =C2=A0pub fn get&lt;&#39;g&gt;(&amp;self, _: &amp;&#39;g RcuG=
uard) -&gt; Option&lt;&amp;&#39;g T&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.raw_get().as_ref()=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt; <br>
&gt; Using this is a bit ugly, because you need transmute, but it&#39;s iso=
lated:<br>
&gt; <br>
&gt; impl AddressSpace {<br>
&gt;=C2=A0 =C2=A0 pub fn get_flatview(&amp;self, rcu: &amp;&#39;g Guard) -&=
gt; &amp;&#39;g FlatView {<br>
<br>
IIUC, this lifetime is using the &quot;branded type&quot; pattern as Parent=
Init.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">No, it&#39;s much simpler (that one uses the combination of for&lt;&#3=
9;identity&gt; and PhantomData as explained in the comment). It says that t=
he lifetime of the returned reference cannot exceed the guard. It&#39;s jus=
t like</div><div dir=3D"auto"><br></div><div dir=3D"auto">pub fn get_item(&=
amp;self, array: &amp;&#39;g [u8]) -&gt; &amp;&#39;g u8 {</div><div dir=3D"=
auto">=C2=A0 =C2=A0&amp;array[self.0]</div><div dir=3D"auto">}</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Except that the guard is only there =
to limit the lifetime and not to hold data.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">In addition, about rcu_read_loc=
k_held(), I thought at C side, there&#39;re<br>
so many comments are saying &quot;Called within RCU critical section&quot; =
but<br>
without any check.<br>
<br>
So I wonder whether we should do some check for RCU critical section,<br>
just like bql check via `assert!(bql_locked())`. Maybe we can have a<br>
Rcu debug feature to cover all these checks.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">In Rust you would just pass a &=
amp;RcuGuard into the function (or store it in a struct) for a zero-cost as=
sertion that you are in the RCU critical section.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000f0dc73063beb1bc7--


