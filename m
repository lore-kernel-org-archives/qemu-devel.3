Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AA8C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugeIA-0002CK-DU; Tue, 29 Jul 2025 02:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ugeI5-00028E-9p
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ugeI3-0002gw-6s
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753772301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6bXEycGxrweoSjffj68ANTMmIwgmbop3om08l0bvsXk=;
 b=Lx8woeQKS6Y746NJhjCax3lR4vBtZDzFpHSF1BFMuJ/Dsggwgy7WdbiVuL44LKpFrmGnlj
 jqRKSm2jO9s3knJL8sEX/tTo+FHNvGLfR05PxjyU2Kl1PKrMGzKA0/jJAhtzhvaw9a6WmD
 dKczKr0AMcrXnMh+oCkkE1VciWkCnkU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-EANKvWU9OrSN4KVNJCSKDA-1; Tue, 29 Jul 2025 02:58:18 -0400
X-MC-Unique: EANKvWU9OrSN4KVNJCSKDA-1
X-Mimecast-MFC-AGG-ID: EANKvWU9OrSN4KVNJCSKDA_1753772298
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70732006280so46924346d6.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 23:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753772298; x=1754377098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bXEycGxrweoSjffj68ANTMmIwgmbop3om08l0bvsXk=;
 b=Jvbj7oUgSdr++jf6kpIJpXqLvB0JWjqnjj2UrHU3CVJbABBzzq+gEERxSboL0A4FUW
 cW2qXANydcfZby2ndv2Drhi5b+meUg/juH6kzwRNrajLAk2xID88qTavJ+UFiclG3sWH
 mKZzITqmYKsNeR0sGtCD2Nk9MmTbvrjZ1ZeK8DHmAmdvVcpQPAaqTFfupoAdx7Ob7GQo
 qGUAjCK4RMBlfGMQngigMAtG8rsXPRRDxqw+qKfOtDJxQPWBDHYfY3YCDcmml8Fd/v8O
 LcwI9+FyWpO/aWlgpFBexpB//1v7r7nhPqN4FREUW2Oz1gNeJfktqTH0dPOYQ4ZGTAzn
 HthA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJViZcNtNXyrIjXFObBFIvA9TlF0r6deXsEasz7eZmZ+7o/syMTOP7JEiEXUH9Gwix70qBTg5QRl8Y@nongnu.org
X-Gm-Message-State: AOJu0Yy69FrZIcoM8apRBzTBZqc1xG1TG/SJnoDv8xZsO04XhBlNtBCu
 +bAEoxnk/A0DuJV4YbQUT/bkhdXEcHLzDJYkDCY56aB4CsSv35Ls6mNPcJASE9le1XkW+wpLkzU
 sDmW3v7zK7qkSAXTzpylp5hP5fxxlvNDPKk4ry2qaL2rLGJnT4gACKKWO8pK9Sf4UtbSBmUQTzE
 nlvW9nLGiiCF6D+aC/sYzdRANBW1Yevb7paKKYT14=
X-Gm-Gg: ASbGncs2SqgpTQUWGvUtCLBriGrCbe7Dvw37YqqVA/ybf9i46PIwrtyy0we0pvGHcwN
 kCR8j0PNjPWUPw24Nx/9r4lxt4CC2YTpNUn800gSAXtu5/ez6tGFJjWniLyrGFJNtCez4fEUZ8V
 u/XKTpD1iGzhxxcaNE/lltKjs=
X-Received: by 2002:ad4:5c6a:0:b0:707:43cd:4a63 with SMTP id
 6a1803df08f44-70743cd4c85mr104478296d6.18.1753772298017; 
 Mon, 28 Jul 2025 23:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc5o8PDzY7yqC+m6RWeFRqnlBN/C+KPwj16LIZAzKcsNGhdsoDNmvatCvchZN0UL8laawvZw9WkfCE3haG6AU=
X-Received: by 2002:ad4:5c6a:0:b0:707:43cd:4a63 with SMTP id
 6a1803df08f44-70743cd4c85mr104478176d6.18.1753772297702; Mon, 28 Jul 2025
 23:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250728173016.314460-1-thuth@redhat.com>
 <aIe5E5NaMCGhoiLZ@redhat.com>
 <1501b69c-6920-4319-bd8a-550243cb3daa@redhat.com>
In-Reply-To: <1501b69c-6920-4319-bd8a-550243cb3daa@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 29 Jul 2025 09:58:05 +0300
X-Gm-Features: Ac12FXyBFnu73O1atrqeFeyVWBHzZTfGCXgfUyk3delvXup2LR4MJsqFCLyK3KM
Message-ID: <CAPMcbCor6zVh+C8VoprThvekd17s_HC4rVMKO4KnOi+cnyH84Q@mail.gmail.com>
Subject: Re: [PATCH] qga: Fix ubsan warning
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d265ce063b0bee54"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000d265ce063b0bee54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM

On Tue, Jul 29, 2025 at 9:02=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 28/07/2025 19.53, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jul 28, 2025 at 07:30:16PM +0200, Thomas Huth wrote:
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> When compiling QEMU with --enable-ubsan there is a undefined behavior
> >> warning when running "make check":
> >>
> >>   .../qga/commands-linux.c:452:15: runtime error: applying non-zero
> offset 5 to null pointer
> >>   #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev
> ..../qga/commands-linux.c:452:15
> >>
> >> Add a check to avoid incrementing the NULL pointer here.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   qga/commands-linux.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> >> index 9e8a934b9a6..caf7c3ca22b 100644
> >> --- a/qga/commands-linux.c
> >> +++ b/qga/commands-linux.c
> >> @@ -449,7 +449,9 @@ static bool build_guest_fsinfo_for_pci_dev(char
> const *syspath,
> >>           has_ata =3D true;
> >>       } else {
> >>           p =3D strstr(syspath, "/host");
> >> -        q =3D p + 5;
> >> +        if (p) {
> >> +            q =3D p + 5;
> >> +        }
> >>       }
> >>       if (p && sscanf(q, "%u", &host) =3D=3D 1) {
> >
> > q is always non-NULL if p is non-NULL, so this is safe, but I would be
> more
> > happy with this changing to 'q && sscanf' to eliminate the indirection.
>
> If we agree to do a bigger change here, I'd rather drop the "q" pointer
> completely and use a new integer variable instead, something like:
>
>      int offset;
>      ...
>      p =3D strstr(syspath, "/ata");
>      if (p) {
>          offset =3D 4;
>          has_ata =3D true;
>      } else {
>          offset =3D 5;
>          p =3D strstr(syspath, "/host");
>      }
>      if (p && sscanf(p + offset, "%u", &host) =3D=3D 1) {
>          ...
>      }
>
> WDYT?
>
>    Thomas
>
>

--000000000000d265ce063b0bee54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>LGTM</div></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, Jul 29, 2025 at 9:02=E2=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth=
@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 28/07/2025 19.53, Daniel P. Berrang=C3=A9 w=
rote:<br>
&gt; On Mon, Jul 28, 2025 at 07:30:16PM +0200, Thomas Huth wrote:<br>
&gt;&gt; From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; When compiling QEMU with --enable-ubsan there is a undefined behav=
ior<br>
&gt;&gt; warning when running &quot;make check&quot;:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0.../qga/commands-linux.c:452:15: runtime error: applyi=
ng non-zero offset 5 to null pointer<br>
&gt;&gt;=C2=A0 =C2=A0#0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..=
../qga/commands-linux.c:452:15<br>
&gt;&gt;<br>
&gt;&gt; Add a check to avoid incrementing the NULL pointer here.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com"=
 target=3D"_blank">thuth@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0qga/commands-linux.c | 4 +++-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
&gt;&gt; index 9e8a934b9a6..caf7c3ca22b 100644<br>
&gt;&gt; --- a/qga/commands-linux.c<br>
&gt;&gt; +++ b/qga/commands-linux.c<br>
&gt;&gt; @@ -449,7 +449,9 @@ static bool build_guest_fsinfo_for_pci_dev(cha=
r const *syspath,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_ata =3D true;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D strstr(syspath, &quo=
t;/host&quot;);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D p + 5;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (p) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q =3D p + 5;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (p &amp;&amp; sscanf(q, &quot;%u&quot=
;, &amp;host) =3D=3D 1) {<br>
&gt; <br>
&gt; q is always non-NULL if p is non-NULL, so this is safe, but I would be=
 more<br>
&gt; happy with this changing to &#39;q &amp;&amp; sscanf&#39; to eliminate=
 the indirection.<br>
<br>
If we agree to do a bigger change here, I&#39;d rather drop the &quot;q&quo=
t; pointer <br>
completely and use a new integer variable instead, something like:<br>
<br>
=C2=A0 =C2=A0 =C2=A0int offset;<br>
=C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0p =3D strstr(syspath, &quot;/ata&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (p) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D 4;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_ata =3D true;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset =3D 5;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D strstr(syspath, &quot;/host&quot;);=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (p &amp;&amp; sscanf(p + offset, &quot;%u&quot;, &am=
p;host) =3D=3D 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
WDYT?<br>
<br>
=C2=A0 =C2=A0Thomas<br>
<br>
</blockquote></div></div>

--000000000000d265ce063b0bee54--


