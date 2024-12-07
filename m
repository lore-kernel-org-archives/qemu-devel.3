Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2FFE7717B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 19:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK0o0-0003hi-5z; Sat, 07 Dec 2024 14:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tK0ny-0003hH-Fx
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 14:49:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tK0nw-0001T1-2T
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 14:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733600966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJ38KFxeEicoe26CJnuslmuwfs1D+iB5zikfUjgUXl4=;
 b=T5T1nwHx6RuVNY8kAjSTNgV6BzfhTtvXg7nCDKChFy4lgX1PnNA03q7oNrxjCkJHN/lENo
 mY+IlsgiaXxOR9O33X6Yczn81fqruRiBThMe4drqnFSZjnznLuZAgOLbbO2Jvt7DEd7jm4
 kQS1xpTtr6/eQjz7gK09am00l1ztgr4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-oX4YGx9gPASCTa6DQPYcdg-1; Sat, 07 Dec 2024 14:49:24 -0500
X-MC-Unique: oX4YGx9gPASCTa6DQPYcdg-1
X-Mimecast-MFC-AGG-ID: oX4YGx9gPASCTa6DQPYcdg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso584617f8f.0
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 11:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733600963; x=1734205763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJ38KFxeEicoe26CJnuslmuwfs1D+iB5zikfUjgUXl4=;
 b=ZMCHO2dk3cRCg3IRQbLqyzRVcXws02JH8+7Do2DGXdeZjvLuPs6aLDRwOgGbY+RWFY
 OBMlovtpT/FiYj5bLj+YATvjytkM9KpSHrIlsWTWohhKJlOGxps9J/fsM2Dlwi7ss5gJ
 /zwVbT9v6FGb3mIsaW9/2oETVz7zcZeY1k3oaWR+BHyEmynzPKDqWBq7+64On+6CEnGu
 E7sSwtvUO4DDVX4Admpm9WwqPtjSs3Ze9wLVj3RPfv7r5ZLTp2p7R16IhEA55WzpsBSG
 SqTJw2jeY3gL9uh0/QVqmUaEi7PjYZk4y4We8ru49FO1E22usdPLzP3DzR/ITgAFXDB5
 HHSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqplrGxpVMHBkLtQF+MLU1WW/18jcIOMywRTv5UWH+XLL+oNxy+PY1JRI9EXCBWo6w0za/I32wcOpD@nongnu.org
X-Gm-Message-State: AOJu0Yy1nrD1D1RHWf53w9kLB/KCyDDWuVFGiWxkdutieaolH7oLP58l
 zAg/2T/kyRAt/MYjnEjEuFPEDgv9/EtcqOI+Ra+UIMw3Dv4cjtxazeI3uNdElqOTr+SSpqVj+l3
 BD+12Okn37XkqL5cEGKxkwVmmVtkdBMxBqJbr5h2NVQlr0sE0H+i5AGkZDPhijvVWiz1qHYGmWG
 RU65HJzjFZg19TNT+/S2INiFsW8FSwHklTDGXMoTzN
X-Gm-Gg: ASbGncvcg+y0uyEdRrrqi4L8AsmTTTxZLw1mmuGfTSj0jvnPqFEucwXfxDDSt9vo7zO
 jQHNEk2T68WDQedSL8DG5QGXD04QFKA==
X-Received: by 2002:a05:6000:70a:b0:386:1cf9:b96e with SMTP id
 ffacd0b85a97d-3862b3f6940mr5688076f8f.55.1733600963108; 
 Sat, 07 Dec 2024 11:49:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEt1u/JBIIrOPpfqteBxobI36Du+0+EnSE2cCmrDz7/8HoWcn3N3qzd11mbe436Rl7v7OO2Z8zfhJi6IyfSW8=
X-Received: by 2002:a05:6000:70a:b0:386:1cf9:b96e with SMTP id
 ffacd0b85a97d-3862b3f6940mr5688061f8f.55.1733600962685; Sat, 07 Dec 2024
 11:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-4-zhao1.liu@intel.com>
 <75edc6e5-e65f-40c0-90ee-6ac1fa018f5c@redhat.com> <Z1RwOR3RWQTjrnYs@intel.com>
In-Reply-To: <Z1RwOR3RWQTjrnYs@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 7 Dec 2024 20:49:11 +0100
Message-ID: <CABgObfZfDtThE2pEUb0KDEJRLDYS=u9kOh9851uY0JKHeOE=Qw@mail.gmail.com>
Subject: Re: [RFC 03/13] rust/cell: add get_mut() method for BqlCell
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000904a7b0628b36d2d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000904a7b0628b36d2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 7 dic 2024, 16:38 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> Thanks for pointing that out, I really didn't think of that, I
> understand how that would break the atomicity of the BQL lock, right?
>

Yes, but also the function seems unnecessary.

> impl fw_cfg_config {
> >     pub(crate) fn assign_hpet_id() -> usize {
> >         assert!(bql_locked());
> >         // SAFETY: all accesses go through these methods, which guarant=
ee

>         // that the accesses are protected by the BQL.
> >         let fw_cfg =3D unsafe { &mut *hpet_fw_cfg };
>
> Nice idea!
>
> >         if self.count =3D=3D u8::MAX {
> >             // first instance
> >             fw_cfg.count =3D 0;
> >         }
>
> Will something like =E2=80=9Canything that releases bql_lock=E2=80=9D hap=
pen here?


No, there are no function calls even.

There seems to be no atomicity guarantee here.
>

It's not beautiful but it's guaranteed to be atomic. For the rare case of
static mut, which is unsafe anyway, it makes sense.

>
> >         if fw_cfg.count =3D=3D 8 {
> >             // TODO: Add error binding: error_setg()
> >             panic!("Only 8 instances of HPET is allowed");
> >         }
> >
> >         let id: usize =3D fw_cfg.count.into();
> >         fw_cfg.count +=3D 1;
> >         id
> >     }
> > }
> >
> > and you can assert bql_locked by hand instead of using the BqlCell.
>
> Thanks! I can also add a line of doc for bql_locked that it can be used
> directly without BqlCell if necessary.
>

Good idea!

And if you also agree the Phillipe's idea, I also need to add BqlCell
> for fw_cfg field in HPETClass :-).
>

No, that also breaks compilation with CONFIG_HPET=3Dn. The idea is nice but
it doesn't work. =C2=AF=E2=81=A0\=E2=81=A0_=E2=81=A0(=E2=81=A0=E3=83=84=E2=
=81=A0)=E2=81=A0_=E2=81=A0/=E2=81=A0=C2=AF

Paolo


> Regards,
> Zhao
>
>
>

--000000000000904a7b0628b36d2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 7 dic 2024, 16:38 Zhao Liu &lt;<a href=3D"mailt=
o:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Thanks for pointing that out=
, I really didn&#39;t think of that, I<br>
understand how that would break the atomicity of the BQL lock, right?<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, b=
ut also the function seems unnecessary.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">&gt; impl fw_cfg_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0pub(crate) fn assign_hpet_id() -&gt; usize {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert!(bql_locked());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// SAFETY: all accesses go through th=
ese methods, which guarantee</blockquote></div></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// that the accesses are protected by=
 the BQL.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let fw_cfg =3D unsafe { &amp;mut *hpe=
t_fw_cfg };<br>
<br>
Nice idea!<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.count =3D=3D u8::MAX {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// first instance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw_cfg.count =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Will something like =E2=80=9Canything that releases bql_lock=E2=80=9D happe=
n here?</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">No, there are no function calls even.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
There seems to be no atomicity guarantee here.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s not beautiful but it=
&#39;s guaranteed to be atomic. For the rare case of static mut, which is u=
nsafe anyway, it makes sense.</div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fw_cfg.count =3D=3D 8 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// TODO: Add error bind=
ing: error_setg()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0panic!(&quot;Only 8 ins=
tances of HPET is allowed&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let id: usize =3D fw_cfg.count.into()=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fw_cfg.count +=3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt; <br>
&gt; and you can assert bql_locked by hand instead of using the BqlCell.<br=
>
<br>
Thanks! I can also add a line of doc for bql_locked that it can be used<br>
directly without BqlCell if necessary.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Good idea!</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
And if you also agree the Phillipe&#39;s idea, I also need to add BqlCell<b=
r>
for fw_cfg field in HPETClass :-).<br></blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">No, that also breaks compilation with CON=
FIG_HPET=3Dn. The idea is nice but it doesn&#39;t work. =C2=AF=E2=81=A0\=E2=
=81=A0_=E2=81=A0(=E2=81=A0=E3=83=84=E2=81=A0)=E2=81=A0_=E2=81=A0/=E2=81=A0=
=C2=AF</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000904a7b0628b36d2d--


