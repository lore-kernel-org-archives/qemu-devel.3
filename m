Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE9CC54E69
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl79G-00080U-P2; Fri, 15 Mar 2024 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rl799-0007zh-Ro
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:58:51 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rl796-0003w7-Le
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:58:51 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29d1380e418so1179881a91.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710507404; x=1711112204;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XRJMWo1jU+IFgi9oNUmSw/e4G0SJbGKlStVEOpGaRb8=;
 b=i29pXG+gc/TJeqiGC5lbo41izOnIpYbW3u+UrGL5rkofhcPoHLmo65S9zOCZJiNd1d
 OgQ0t+UFnWDCHSs4cWPdfF6cgOUwZ0Pi2qTfblcgEQnQT5EYHgeBwuEEk2rkFnxnCv1Q
 IYaElSaOmo9IPIv3ozvVFoUBJgTNawd3vJWzpwyWTbLIvLGmvk3Ci6a7Wp/XByo0nj6S
 ZeReyP30i9UKuylk+23Kcw912pHa+UuIUbD29pQM0BWKAgReSeJiGS2kLKFKAzE0GhUo
 rxarB3cQtWHKe9t5DfLe//yZsL6mEmnZ8AhgT+zYtht2qr1COOo4lUNsBR5N0uSIuqQG
 08Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710507404; x=1711112204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XRJMWo1jU+IFgi9oNUmSw/e4G0SJbGKlStVEOpGaRb8=;
 b=PfrNVfDU8XrpX7Fk1sRbudNmZTCEbJBeidQX/qJpK8rBp08wal8RLp3LV7kEPa+FMd
 E9VZhvcsJGtQJlfRwTVFEIsfhroTiY0TVWouGmXfJiBd4DTopV3ZvI1lWJ2KjKZPrPdb
 hqZR0BmypkTvYFpAYDp0Ni8ZhNRZfycmcPdN2pqUSIDG7s44FfjUMNp8ZLtvqmeWRazS
 2wbwOmgLxsuPR2s/mqbiXbUrz8Jyfu3I1nxJTUyRig+hWr97eW9T16HoBx880VJPGNTH
 spf3a9Id/gPE32ga4HsIUxLHm2adhZTVAAwjWS/Z3zAKwFnOX6cVbKB8bi7+eC5a6svG
 QNDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdk/Xl0/Bew5ySaJ90U6lUOg/AwiTSiL9HUnGdY8v1KUb3+K0w3w4QaqtpiBF9ljcdV1NFGAx5eVZ8WwJbxfjnwY7sLsk=
X-Gm-Message-State: AOJu0YynyxOiBTtl5rG4/Lp/uAHcyd0YYFCza6Vw31diIzoIY2kdPz7U
 lT8j+hTj+D9TpZUMuOhxzAUoqBGjHL7jX/ViXXzXcSQI72KQrtpBw0I8sjGby1wXUWyt30tOFzg
 AFrpqINg4Zq1k5jeMhmbPBfEGrXR2bMe0NLC/ig==
X-Google-Smtp-Source: AGHT+IEK+viTRZ50L41hgJYn1FRkpm0/AWfEYGpzlt/bKuLqvUd/td1YxqQ/d4h2F4TSOMmYHWS4XfiaW5xKJrT8kT0=
X-Received: by 2002:a17:90a:e547:b0:29c:7752:26a2 with SMTP id
 ei7-20020a17090ae54700b0029c775226a2mr6470258pjb.24.1710507403549; Fri, 15
 Mar 2024 05:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
 <87h6hah7bb.fsf@pond.sub.org> <20240313051034-mutt-send-email-mst@kernel.org>
 <87msr2fp16.fsf@pond.sub.org> <20240313070857-mutt-send-email-mst@kernel.org>
 <871q8cj5l7.fsf@pond.sub.org>
In-Reply-To: <871q8cj5l7.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 15 Mar 2024 20:56:27 +0800
Message-ID: <CAK9dgmYpyaXc_=xzGPziKeXObWsMRvBO3L4iWJupf+tO2nhHUw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002cb9a00613b28a0f"
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1029.google.com
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

--0000000000002cb9a00613b28a0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 3:51=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
> > On Wed, Mar 13, 2024 at 10:40:21AM +0100, Markus Armbruster wrote:
> >> I could be awkward for the use case described in PATCH 1's commit
> >> message:
> >>
> >>     However, we sometimes want to compare features and status bits
> without
> >>     caring for their exact meaning.  Say we want to verify the
> correctness
> >>     of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We
> can use
> >>     QMP command x-query-virtio-status to retrieve vhost-user net devic=
e
> >>     features, and the "ovs-vsctl list interface" command to retrieve
> >>     interface features.  Without commit f3034ad71fc, we could then
> simply
> >>     compare the numbers.  With this commit, we first have to map from
> the
> >>     strings back to the numeric encoding.
> >
> > So, consider how guest kernel presents features then. Do you happen to
> know?
> > It's actually a binary string:
> >
> > static ssize_t features_show(struct device *_d,
> >                              struct device_attribute *attr, char *buf)
> > {
> >         struct virtio_device *dev =3D dev_to_virtio(_d);
> >         unsigned int i;
> >         ssize_t len =3D 0;
> >
> >         /* We actually represent this as a bitstring, as it could be
> >          * arbitrary length in future. */
> >         for (i =3D 0; i < sizeof(dev->features)*8; i++)
> >                 len +=3D sysfs_emit_at(buf, len, "%c",
> >                                __virtio_test_bit(dev, i) ? '1' : '0');
> >         len +=3D sysfs_emit_at(buf, len, "\n");
> >         return len;
> > }
> > static DEVICE_ATTR_RO(features);
>
> I'm willing to accept any reasonably compact representation of the bits
> that is easy to use for the comparison use case.
>
> I strongly prefer integers as long as their width suffices.
>
> Since out integers are limited to 64 bits, and you want us to design for
> more, we need something else.
>
> I'm fine with array of integers, but you don't like it.
>
> We generally avoid encoding stuff in strings, but using strings for
> "overwide" integers isn't as bad as using them for structured data.  I
> guess I'd be okay with it.
>
> I'd use decimal simply to keep these "overwide" integers as close as
> possible to regular ones.
>
> If using base 2 enables string compare for the comparison use case,
> that's an argument for base 2.
>
> Hyman Huang, can you show us example output of "ovs-vsctl list
> interface"?
>
>
Here is the output of an active interface enable the dpdk feature:

# ovs-vsctl list interface port-testvm2pn8

_uuid:            xxxx
admin_state: up
name:             port-testvm2pn8
......
status:           {features=3D"0x000000017060a782", mode=3Dclient,
num_of_vrings=3D"4"......}


Yong


--=20
Best regards

--0000000000002cb9a00613b28a0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 15, 20=
24 at 3:51=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">&quot;Mich=
ael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank=
">mst@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Wed, Mar 13, 2024 at 10:40:21AM +0100, Markus Armbruster wrote:<br>
&gt;&gt; I could be awkward for the use case described in PATCH 1&#39;s com=
mit<br>
&gt;&gt; message:<br>
&gt;&gt; <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0However, we sometimes want to compare features =
and status bits without<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0caring for their exact meaning.=C2=A0 Say we wa=
nt to verify the correctness<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0of the virtio negotiation between guest, QEMU, =
and OVS-DPDK.=C2=A0 We can use<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0QMP command x-query-virtio-status to retrieve v=
host-user net device<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0features, and the &quot;ovs-vsctl list interfac=
e&quot; command to retrieve<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0interface features.=C2=A0 Without commit f3034a=
d71fc, we could then simply<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0compare the numbers.=C2=A0 With this commit, we=
 first have to map from the<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0strings back to the numeric encoding.<br>
&gt;<br>
&gt; So, consider how guest kernel presents features then. Do you happen to=
 know?<br>
&gt; It&#39;s actually a binary string:<br>
&gt;<br>
&gt; static ssize_t features_show(struct device *_d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr, char *buf=
)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_device *dev =3D dev_to_=
virtio(_d);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t len =3D 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We actually represent this as a bi=
tstring, as it could be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * arbitrary length in future. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; sizeof(dev-&gt;f=
eatures)*8; i++)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len +=3D =
sysfs_emit_at(buf, len, &quot;%c&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __virtio_test_bit(dev, i) ? &#39;=
1&#39; : &#39;0&#39;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len +=3D sysfs_emit_at(buf, len, &quo=
t;\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;<br>
&gt; }<br>
&gt; static DEVICE_ATTR_RO(features);<br>
<br>
I&#39;m willing to accept any reasonably compact representation of the bits=
<br>
that is easy to use for the comparison use case.<br>
<br>
I strongly prefer integers as long as their width suffices.<br>
<br>
Since out integers are limited to 64 bits, and you want us to design for<br=
>
more, we need something else.<br>
<br>
I&#39;m fine with array of integers, but you don&#39;t like it.<br>
<br>
We generally avoid encoding stuff in strings, but using strings for<br>
&quot;overwide&quot; integers isn&#39;t as bad as using them for structured=
 data.=C2=A0 I<br>
guess I&#39;d be okay with it.<br>
<br>
I&#39;d use decimal simply to keep these &quot;overwide&quot; integers as c=
lose as<br>
possible to regular ones.<br>
<br>
If using base 2 enables string compare for the comparison use case,<br>
that&#39;s an argument for base 2.<br>
<br>
Hyman Huang, can you show us example output of &quot;ovs-vsctl list<br>
interface&quot;?<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:&quot;comic sans ms&quot;,sans-serif">Here is the output of an activ=
e interface enable the dpdk feature:</div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"># ovs-vsctl list interface port-testvm2pn8</div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><=
div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,=
sans-serif">_uuid: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xxxx</div><div =
class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif">admin_state: up</div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif">name: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 port-testvm2pn8</div><div class=3D"gmail_default" style=3D"f=
ont-family:&quot;comic sans ms&quot;,sans-serif">......</div><div class=3D"=
gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">s=
tatus: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {features=3D&quot;0x000000017060a=
782&quot;, mode=3Dclient, num_of_vrings=3D&quot;4&quot;......}</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif"><br></div></div><div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</div><br cle=
ar=3D"all"><div><br></div><span class=3D"gmail_signature_prefix">-- </span>=
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=
=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--0000000000002cb9a00613b28a0f--

