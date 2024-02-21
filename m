Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7425EC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 04:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcdnm-00087u-Pn; Tue, 20 Feb 2024 23:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcdnj-00087Z-JI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:01:43 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rcdnh-0000EI-4s
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 23:01:43 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2998950e951so1769375a91.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 19:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708487978; x=1709092778;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C8y19miCoDOxVQRvGGGVeuZfQLsxcA4rAZgLgCp7Ywg=;
 b=K3yWsrWYeSDHbAwqxoNvDgTQtnir9I9sLIxAEuhSdZzAfOcO3oR7L8K+jQz5mDjERK
 MMTT2R0I4EEf+W3HiBmmcVAPIa6HA3nVqM/YT7WAmxBplJjorvqoyYHQPN4cEgUb+gKi
 MTzlmmLM6T+aEeXkBkmtxMD1VitbDW6ZrOHiEPRtk5Da5tIwmmOWylIwNcDir/ABk/+I
 b8cSH88FcpbbnseE0dDp/jrxAKU6x2OxB4Ga0Z/bXsvodZc5upBaHllxmvkUqF/ocVHZ
 E3rrisuut3eMPc97g8UKxPqe3URIlZevxq0bk9n1/d8GU3UW0v56RPvcXdh+CxMkqVAZ
 N84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708487978; x=1709092778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C8y19miCoDOxVQRvGGGVeuZfQLsxcA4rAZgLgCp7Ywg=;
 b=Vomf5TerIpcVvS+xr2bfDbT32Utu2YRtI6ohNtopEzMlLuf1xaNscxkRoyptV9iysK
 xOQZ6/YIRowqZ/GsvlHnVguyXEqL3gn4rJDvB+HJLaw9Om4AExPCJivhODOzorfRgG15
 uxgDpBjNRQLk0O2NR8vPsukS/e4DO+9jYFvruXieGCd9q+57TkSC1eNdYxJv8zAit8gx
 BeFcf+770Nzz7XudjCvArBz8QJEUPB53QiqPYGHhYOnWPUxdk1+o1l7d56m7TQxeEcFy
 eo20gd6EEPScPuQhgC8ERTKu5KQJKnpJMoLyqjOjbBz14bztSiCd4IPh9gBhXYiWz8lj
 7xHg==
X-Gm-Message-State: AOJu0YzZkT5U1bVayo3V7HtzfzyM0psjV9RPJsaa8kH6FsqQlKU3XQD+
 nlz9DvFZA6BjDWMkZrCguUX7XZK9Xuhtx2aL6tP9v1CdIODQjKC/n5SA4+xsp4fhlAiG42dzpU6
 UP2EmB7AJKYAKff80ftM9SShlGdKlqnlElm4mOw==
X-Google-Smtp-Source: AGHT+IHSaE6B1vy7JA0xQogGloF3hDZbPFxq+8+g0oG4UrPjDL2fS3WPBl4KWSaH5uxr8Eb4dS8G3k25//RKAX/E+9Q=
X-Received: by 2002:a17:90a:9486:b0:299:9f5:ac1b with SMTP id
 s6-20020a17090a948600b0029909f5ac1bmr12165268pjo.24.1708487976334; Tue, 20
 Feb 2024 19:59:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706883915.git.yong.huang@smartx.com>
 <7b92f9ccc9ca5e4d6a2e2dd7804f172dc538f355.1706883915.git.yong.huang@smartx.com>
 <87bk8cihvw.fsf@pond.sub.org>
In-Reply-To: <87bk8cihvw.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Wed, 21 Feb 2024 11:59:20 +0800
Message-ID: <CAK9dgmYV6Z=X-W0z0ryFdAbJwaBpy9-oWEAdzwV2UtBVyHneDw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] virtio: Declare the decoding functions to static
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eec6d80611dc5acf"
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000eec6d80611dc5acf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:38=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()
> > are now only used in virtio-hmp-cmds.c.  So move them into there,
> > redeclare them to static, and replace the qmp_ prefix with hmp_.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  hw/virtio/meson.build       |   3 +-
> >  hw/virtio/virtio-hmp-cmds.c | 677 +++++++++++++++++++++++++++++++++++-
> >  hw/virtio/virtio-qmp.c      | 661 -----------------------------------
> >  hw/virtio/virtio-qmp.h      |   3 -
> >  4 files changed, 670 insertions(+), 674 deletions(-)
> >
> > diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> > index 47baf00366..6665669480 100644
> > --- a/hw/virtio/meson.build
> > +++ b/hw/virtio/meson.build
> > @@ -9,7 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV',
> if_true: files('vdpa-dev.c')
> >
> >  specific_virtio_ss =3D ss.source_set()
> >  specific_virtio_ss.add(files('virtio.c'))
> > -specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
> > +specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c',
> 'virtio-hmp-cmds.c'))
>
> I think you can also move virtio-qmp.c, i.e.
>
>    specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-hmp-cmds.c'=
))
>
> here, and ...
>
> >
> >  if have_vhost
> >    system_virtio_ss.add(files('vhost.c'))
> > @@ -74,7 +74,6 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI',
> if_true: virtio_pci_ss)
> >  system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
> >  system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
> >  system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
> > -system_ss.add(files('virtio-hmp-cmds.c'))
>
>    system_ss.add(files('virtio-qmp.c'))
>
> here.
>

Get it,  I'll try in the next version.


> [...]
>
>

--=20
Best regards

--000000000000eec6d80611dc5acf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 19, 20=
24 at 11:38=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Hua=
ng &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huan=
g@smartx.com</a>&gt; writes:<br>
<br>
&gt; qmp_decode_protocols(), qmp_decode_status(), and qmp_decode_features()=
<br>
&gt; are now only used in virtio-hmp-cmds.c.=C2=A0 So move them into there,=
<br>
&gt; redeclare them to static, and replace the qmp_ prefix with hmp_.<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 =
+-<br>
&gt;=C2=A0 hw/virtio/virtio-hmp-cmds.c | 677 ++++++++++++++++++++++++++++++=
+++++-<br>
&gt;=C2=A0 hw/virtio/virtio-qmp.c=C2=A0 =C2=A0 =C2=A0 | 661 ---------------=
--------------------<br>
&gt;=C2=A0 hw/virtio/virtio-qmp.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 -<br>
&gt;=C2=A0 4 files changed, 670 insertions(+), 674 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build<br>
&gt; index 47baf00366..6665669480 100644<br>
&gt; --- a/hw/virtio/meson.build<br>
&gt; +++ b/hw/virtio/meson.build<br>
&gt; @@ -9,7 +9,7 @@ system_virtio_ss.add(when: &#39;CONFIG_VHOST_VDPA_DEV&=
#39;, if_true: files(&#39;vdpa-dev.c&#39;)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 specific_virtio_ss =3D ss.source_set()<br>
&gt;=C2=A0 specific_virtio_ss.add(files(&#39;virtio.c&#39;))<br>
&gt; -specific_virtio_ss.add(files(&#39;virtio-config-io.c&#39;, &#39;virti=
o-qmp.c&#39;))<br>
&gt; +specific_virtio_ss.add(files(&#39;virtio-config-io.c&#39;, &#39;virti=
o-qmp.c&#39;, &#39;virtio-hmp-cmds.c&#39;))<br>
<br>
I think you can also move virtio-qmp.c, i.e.<br>
<br>
=C2=A0 =C2=A0specific_virtio_ss.add(files(&#39;virtio-config-io.c&#39;, &#3=
9;virtio-hmp-cmds.c&#39;))<br>
<br>
here, and ...<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if have_vhost<br>
&gt;=C2=A0 =C2=A0 system_virtio_ss.add(files(&#39;vhost.c&#39;))<br>
&gt; @@ -74,7 +74,6 @@ specific_virtio_ss.add_all(when: &#39;CONFIG_VIRTIO_=
PCI&#39;, if_true: virtio_pci_ss)<br>
&gt;=C2=A0 system_ss.add_all(when: &#39;CONFIG_VIRTIO&#39;, if_true: system=
_virtio_ss)<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_VIRTIO&#39;, if_false: files(&#3=
9;vhost-stub.c&#39;))<br>
&gt;=C2=A0 system_ss.add(when: &#39;CONFIG_VIRTIO&#39;, if_false: files(&#3=
9;virtio-stub.c&#39;))<br>
&gt; -system_ss.add(files(&#39;virtio-hmp-cmds.c&#39;))<br>
<br>
=C2=A0 =C2=A0system_ss.add(files(&#39;virtio-qmp.c&#39;))<br>
<br>
here.<br></blockquote><div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Get it, =C2=
=A0I&#39;ll try in the next version.</div></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex">
<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000eec6d80611dc5acf--

