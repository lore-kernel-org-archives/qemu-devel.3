Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69BEE69E90
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tID5b-0000P5-Fp; Mon, 02 Dec 2024 15:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1tID5V-0000OK-Im
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:32:10 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1tID5T-000304-4Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:32:08 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-724e7d5d5b2so4477299b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733171525; x=1733776325; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yi9J+VaKO6hnJ726rUwzaa9vE/G/T5Gbu8o3guk3+5o=;
 b=H5DfLW+1gpsLOrDdiK1H54i9LN3vGVnJ0DSsXxrhyqg1ENOJWWgHMGqtrEiErgjBGI
 d3Kjiaou7BWBDsTOMoM9Ts+v4FJnPrji3rs3scv/Ev0ZYcEvtMmCoPvXUfNh33ReCzGY
 iagiOPG0/YbQhRB2rVKkaXQnuqcDnguvmTETy9jzPjcXhIWrNGuJHmmFKPZqt3ZuptRs
 cwofaclf9Q3Kivglk/fLrGi5rGhNmbjMT6HDqrifUJh/Ij+Azlf+hzpG3FEwJct8UXE5
 WUcXFxaIDxUuLXqRl8pqEqkWKnO1C3xfHNC8fkvcodcFL1YY4mfQR9/j3NIeUBayutAX
 k8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733171525; x=1733776325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yi9J+VaKO6hnJ726rUwzaa9vE/G/T5Gbu8o3guk3+5o=;
 b=Yazqx6RTTpbtOqoNiTwQ4jG+LCEFM1ZfwvoeBrOF/zJw3eRhnzoWYQNn9ubJP07aXX
 QAncv7rxaSxvDCxVgBZhaYFs5iE7yNSde4h52G0WyITGw4bNhyuPolOh+o45cwpnJJ/+
 pVLEByyHhOFchQG+HPUPrDOCWUGE2birh9esmzVQUllTvFdfKBFdgSuH6Hf1rKCHCbJg
 seZwT+KbOSrzQGlNdeej5phJjXUdsBUyTbJGgo1o/si7WH48Rv5igPPBQJnqUgOYqLEc
 6Oh5L2+wF1JTuEXgXaXRKBtlmZLrfH/I5NL1PB4ai+mcErc2QvGqb7pzLJDuHNFudXoU
 9w6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaWznWdJ8r5WiCMaqM0FU+NcFzMWPoOgz6CWIYuPTdk1Y11MPCsKeOq8FNBFA3Z/I+Xn5uwaWYXeyo@nongnu.org
X-Gm-Message-State: AOJu0YxIXuQpKkOc0367qWWeMUilCw/0S3CHV6UPhzCka+Mx0eIbPmWQ
 7LYOOWqtAwoj92qLE6eh6Dw5glzN0xHEMkXhGcP50iqOzFt80fjMa1e2DFxQnI+sSSB4XXmc+4H
 cpdr5P5rWv9KlH544O75X4QIEDvbcf194A/k=
X-Gm-Gg: ASbGncsDQviVIeEjx0DupkEZCw0seoXRYsWxdzXifIT0Z6KZPF/aCqa/NKyXSeS1cAI
 KmmFgAYU4iknCP5VwTar7Rx3/c1uGWQzr1eKoCZo9472YqpiY1lmqpUrjFpb/9SM=
X-Google-Smtp-Source: AGHT+IHyuP6qS7n+CdFbPhItgDdSsMYx5B4iUxovoQln2czGhuK8u8w/ljT6v/4KzJN/Rielqw62lCdcOuLXwv78Liw=
X-Received: by 2002:aa7:8883:0:b0:725:3bd4:9b52 with SMTP id
 d2e1a72fcca58-7253bd49c15mr25953548b3a.3.1733171524437; Mon, 02 Dec 2024
 12:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
 <Z0RnuVKPHO1T2BfV@redhat.com>
 <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
 <Z0XxYpvj49colIIy@redhat.com>
 <CAGZECHMEYjL56AZebqOK4dTgQbLtwA=9=yZ0qi0ymSpMS2x7Gw@mail.gmail.com>
In-Reply-To: <CAGZECHMEYjL56AZebqOK4dTgQbLtwA=9=yZ0qi0ymSpMS2x7Gw@mail.gmail.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Mon, 2 Dec 2024 15:31:53 -0500
Message-ID: <CAGZECHO0HmkM+zPudFKU-dYZi9LqhfgVqaONn09DRW07sNkLVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="0000000000000d242b06284f710f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=ankeesler@google.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -179
X-Spam_score: -18.0
X-Spam_bar: ------------------
X-Spam_report: (-18.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000000d242b06284f710f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again Daniel. I have a follow up question. Can you help me
understand how I can declare this "outputs" property?

   -device '{"driver":"virtio-vga",
             "max_outputs":2,
             "id":"vga",
             "outputs":[
               {
                  "name":"AAA",
               },
               {
                  "name":"BBB",
               },
             ]}'

I thought DEFINE_PROP_ARRAY would do it, but I can't tell what PropertyInfo
implementation I should pass. All of the PropertyInfo implementations I can
find use scalar types, or simple text decoding. I am wondering if I am
missing
some sort of "JSON" encoding capabilities that can happen behind the scenes=
.

On Tue, Nov 26, 2024 at 4:07=E2=80=AFPM Andrew Keesler <ankeesler@google.co=
m> wrote:

> Thanks, Daniel. We'll get this patch updated and send it out again.
>
> > it makes sense to allow for a data structure
>
> Whoops, I misread your original message - data structure SGTM.
>
> On Tue, Nov 26, 2024 at 11:04=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrang=
e@redhat.com>
> wrote:
>
>> On Mon, Nov 25, 2024 at 03:54:40PM -0500, Andrew Keesler wrote:
>> > I follow what you are saying. I misunderstood what a "display" was in
>> the
>> > domain of QEMU. Yes, this makes more sense now.
>> >
>> > > the user should give names for every output at startup
>> >
>> > I see DEFINE_PROP_ARRAY exists. I can use that to define the new
>> "outputs"
>> > property. Any reason that each "output" would ever need to be an objec=
t
>> > (rather than just a string)? Nothing comes to mind, I'm just taking a
>> second
>> > to think about API forwards compatibility.
>>
>> Currently we have 'xres' and 'yres' properties set against the device
>> for virtio-gpu.
>>
>> If we're going to extend  it to allow the name of each "output" head
>> to be configured, it makes sense to allow for a data structure that
>> will let us also cnofigure xres & yres per output.
>>
>> Hence, I thought it would make more sense to have an array of structs,
>> rather than the simpler array of strings, which will let us set any
>> amount of per-output config data we might want in future.
>>
>> NB, I'm not asking you to wire up support for xres/yres per output,
>> just that we anticipate it as a possibility.
>>
>> > > upto whatever they said for "max_outputs"
>> >
>> > Where is the best place to perform this validation? I would imagine we
>> would
>> > want to fast-fail if the user provided more "outputs" than
>> "max_outputs". I
>> > can
>> > perform the validation in virtio_gpu_base_get_features but that seems
>> late.
>>
>> I'd suggest putting it in virtio_gpu_base_device_realize, as we already
>> have code there to validate 'max_outputs" is within limits.
>>
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-
>> https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-
>> https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-
>> https://www.instagram.com/dberrange :|
>>
>>

--0000000000000d242b06284f710f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi again Daniel. I have a follow up question. Can you help=
 me<div>understand how I can declare this &quot;outputs&quot; property?</di=
v><div><br></div><div>=C2=A0 =C2=A0-device &#39;{&quot;driver&quot;:&quot;v=
irtio-vga&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;m=
ax_outputs&quot;:2,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quo=
t;id&quot;:&quot;vga&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;outputs&quot;:[<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;name&quot;:&quot;AAA&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;name&quot;:&quot;BBB&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0},<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
]}&#39;<br></div><div><br></div><div>I thought=C2=A0DEFINE_PROP_ARRAY would=
 do it, but I can&#39;t tell what PropertyInfo</div><div>implementation I s=
hould pass. All of the=C2=A0PropertyInfo implementations I can<br></div><di=
v>find use scalar types, or simple text decoding. I am wondering if I am mi=
ssing</div><div>some sort of &quot;JSON&quot; encoding capabilities that ca=
n happen behind the scenes.</div></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2024=
 at 4:07=E2=80=AFPM Andrew Keesler &lt;<a href=3D"mailto:ankeesler@google.c=
om">ankeesler@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr"><div>Thanks, Daniel. We&#39;ll get=
 this patch updated and send it out again.</div><div><br></div><div>&gt; it=
 makes sense to allow for a data structure</div><div><br></div><div>Whoops,=
 I misread your original message - data structure SGTM.</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26=
, 2024 at 11:04=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:be=
rrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Nov 25, 202=
4 at 03:54:40PM -0500, Andrew Keesler wrote:<br>
&gt; I follow what you are saying. I misunderstood what a &quot;display&quo=
t; was in the<br>
&gt; domain of QEMU. Yes, this makes more sense now.<br>
&gt; <br>
&gt; &gt; the user should give names for every output at startup<br>
&gt; <br>
&gt; I see DEFINE_PROP_ARRAY exists. I can use that to define the new &quot=
;outputs&quot;<br>
&gt; property. Any reason that each &quot;output&quot; would ever need to b=
e an object<br>
&gt; (rather than just a string)? Nothing comes to mind, I&#39;m just takin=
g a second<br>
&gt; to think about API forwards compatibility.<br>
<br>
Currently we have &#39;xres&#39; and &#39;yres&#39; properties set against =
the device<br>
for virtio-gpu.<br>
<br>
If we&#39;re going to extend=C2=A0 it to allow the name of each &quot;outpu=
t&quot; head<br>
to be configured, it makes sense to allow for a data structure that<br>
will let us also cnofigure xres &amp; yres per output.<br>
<br>
Hence, I thought it would make more sense to have an array of structs,<br>
rather than the simpler array of strings, which will let us set any<br>
amount of per-output config data we might want in future.<br>
<br>
NB, I&#39;m not asking you to wire up support for xres/yres per output,<br>
just that we anticipate it as a possibility.<br>
<br>
&gt; &gt; upto whatever they said for &quot;max_outputs&quot;<br>
&gt; <br>
&gt; Where is the best place to perform this validation? I would imagine we=
 would<br>
&gt; want to fast-fail if the user provided more &quot;outputs&quot; than &=
quot;max_outputs&quot;. I<br>
&gt; can<br>
&gt; perform the validation in virtio_gpu_base_get_features but that seems =
late.<br>
<br>
I&#39;d suggest putting it in virtio_gpu_base_device_realize, as we already=
<br>
have code there to validate &#39;max_outputs&quot; is within limits.<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>
</blockquote></div>

--0000000000000d242b06284f710f--

