Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C92C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKK02-0002k7-7P; Thu, 20 Jun 2024 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKK01-0002jz-6P
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKJzz-0004Iv-6v
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718898413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fyf0dhV+KPyxfhnTiPCIf7+3nlf9IlLFdCmbwuNR9Pg=;
 b=i+JKNplXyVvziq9wzj5rX39aUSldum22Sen35gV5Xw80t4yGJQ3Ky6LrPd1kd+BVprGlpW
 HLt6Im+5/7FcfbcmclBF8Nol6lWbrFeEgUu4o7LBLB4Dv/Yhjy56gjVOBAntCT3E9NPGs1
 KtWA3X+tyWs8G1AZ/zEb4bPpXawVQiA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-gbWe36rvPvW4-nrQnlCRZg-1; Thu, 20 Jun 2024 11:46:52 -0400
X-MC-Unique: gbWe36rvPvW4-nrQnlCRZg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f9c3c61dc9so10650045ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718898411; x=1719503211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyf0dhV+KPyxfhnTiPCIf7+3nlf9IlLFdCmbwuNR9Pg=;
 b=MrWeGpbeP+lFwHEEcoGe+yJ1ejr+w59+olG82UUvUXxUY7K9/Ua1eBDmBxRjRZ5hyG
 dlxdng1ash+Pnc5bfvwAeZS7Th9ewvyIcUybdwbRcbbl2btA8HNWcaR2bXkqNIeKDXSS
 QH4aZ9SFR1ll6QWZVD2uiEQgN2/KESeWXdoOyiLW9141JQQY0CDm+mLQAMTdBeuTIv+0
 nsaVdLcThEj6okeogyx1bSAE/DaB0UWNE3/IjVVfHbbgkG8T4jafYCf7LBdyHjH/Raf0
 C/P6RyoLFt3FJdjwd9ZfDzZ/4csUTyewYXQW9DjJMs0xqWgrio3/eAPMv+Gc0gLqren1
 RrQg==
X-Gm-Message-State: AOJu0YzP890sIpjQUCskJsFtC0g0MYLU5LDM+cZOBMvIYcinueYIjFD+
 9sd7jdk1dAOc7RMy1kYhoA0W/yTopgv0GX+zsOQl70XknTBLGDb5GsUXDIpSxKkRcjPOiFhqKXR
 8RbH+JvXiPbAAm6w9uUWznD3b2K2ap9hos2fBVN7uTa4MvJMyU/wFIfiunb3pY70hxj1wqAIr7P
 YrcfA9K6F4f4ApZGA/RmIWExiIRoM=
X-Received: by 2002:a17:903:230c:b0:1f9:b974:cbd6 with SMTP id
 d9443c01a7336-1f9b974ce15mr46201925ad.1.1718898410848; 
 Thu, 20 Jun 2024 08:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElBOSPKvba4pYV33n5LBXDAVMZOB07Vs3Y9uXaTw/+Y70MyKgqaHADjZKXDoeoNpBt9fsToy/2dW6l1Fps1F0=
X-Received: by 2002:a17:903:230c:b0:1f9:b974:cbd6 with SMTP id
 d9443c01a7336-1f9b974ce15mr46201535ad.1.1718898410234; Thu, 20 Jun 2024
 08:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240619003012.1753577-1-jsnow@redhat.com>
 <20240619003012.1753577-10-jsnow@redhat.com>
 <87wmmlyu64.fsf@pond.sub.org> <87iky3u47v.fsf@pond.sub.org>
In-Reply-To: <87iky3u47v.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 20 Jun 2024 11:46:37 -0400
Message-ID: <CAFn=p-ZDQog-gS=oXPm2E+uQwa=AFodxP-TTCtLrXiOou3-McQ@mail.gmail.com>
Subject: Re: [PATCH 09/13] qapi: convert "Note" sections to plain rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>,
 Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Qemu-block <qemu-block@nongnu.org>, Jiri Pirko <jiri@resnulli.us>, 
 Alex Williamson <alex.williamson@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000260b8c061b5439b2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000260b8c061b5439b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Markus Armbruster <armbru@redhat.com> writes:
>
> > John Snow <jsnow@redhat.com> writes:
>
> [...]
>
> >> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> >> index b3de1fb6b3a..57598331c5c 100644
> >> --- a/qga/qapi-schema.json
> >> +++ b/qga/qapi-schema.json
>
> [...]
>
> >> @@ -631,8 +632,8 @@
> >>  # Errors:
> >>  #     - If hybrid suspend is not supported, Unsupported
> >>  #
> >> -# Notes: It's strongly recommended to issue the guest-sync command
> >> -#     before sending commands when the guest resumes
> >> +# .. note:: It's strongly recommended to issue the guest-sync command
> >> +#    before sending commands when the guest resumes.
> >>  #
> >>  # Since: 1.1
> >>  ##
> >> @@ -1461,16 +1462,15 @@
> >>  #     * POSIX: as defined by os-release(5)
> >>  #     * Windows: contains string "server" or "client"
> >>  #
> >> -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
> >> -#     @version, @version-id, @variant and @variant-id follow the
> >> -#     definition specified in os-release(5). Refer to the manual page
> >> -#     for exact description of the fields.  Their values are taken
> >> -#     from the os-release file.  If the file is not present in the
> >> -#     system, or the values are not present in the file, the fields
> >> -#     are not included.
> >> +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> >> +#    @version, @version-id, @variant and @variant-id follow the
> >> +#    definition specified in os-release(5). Refer to the manual page
> for
> >> +#    exact description of the fields.  Their values are taken from th=
e
> >> +#    os-release file.  If the file is not present in the system, or t=
he
> >> +#    values are not present in the file, the fields are not included.
> >>  #
> >> -#     On Windows the values are filled from information gathered from
> >> -#     the system.
> >> +#    On Windows the values are filled from information gathered from
> >> +#    the system.
> >
> > Please don't change the indentation here.  I get the same output with
> >
> >   @@ -1461,7 +1462,7 @@
> >    #     * POSIX: as defined by os-release(5)
> >    #     * Windows: contains string "server" or "client"
> >    #
> >   -# Notes: On POSIX systems the fields @id, @name, @pretty-name,
> >   +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> >    #     @version, @version-id, @variant and @variant-id follow the
> >    #     definition specified in os-release(5). Refer to the manual pag=
e
> >    #     for exact description of the fields.  Their values are taken
>
> I'm blind.  Actually, you change indentation of subsequent lines from 4
> to 3 *everywhere*.  I guess you do that to make subsequent lines line up
> with the directive, here "note".
>
> Everywhere else, we indent such lines by 4.  Hmm.  How terrible would it
> be not to mess with the alignment?
>
> If we want to use 3 for directives, is it worth pointing out in the
> commit message?
>
> [...]
>

Let me look up some conventions and see what's the most prominent... as
well as testing what emacs does by default (or if emacs can be configured
to do what we want with in-tree style config. Warning: I am functionally
inept at emacs lisp. Warning 2x: [neo]vi[m] users, you're entirely on your
own. I'm sorry.)

I use three myself by force of habit and have some mild reluctance to
respin for that reason, but ... guess we ought to be consistent if we can.

(No idea where my habit came from. Maybe it is just because it looks nice
to me and no other reason.)

((I have no plans, nor desire, to write any kind of checker to enforce
this, though - sorry.))

--000000000000260b8c061b5439b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jun 20, 2024, 9:35=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">Markus Armbruster &lt;<a href=3D"m=
ailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@redhat=
.com</a>&gt; writes:<br>
<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
<br>
[...]<br>
<br>
&gt;&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt;&gt; index b3de1fb6b3a..57598331c5c 100644<br>
&gt;&gt; --- a/qga/qapi-schema.json<br>
&gt;&gt; +++ b/qga/qapi-schema.json<br>
<br>
[...]<br>
<br>
&gt;&gt; @@ -631,8 +632,8 @@<br>
&gt;&gt;=C2=A0 # Errors:<br>
&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0- If hybrid suspend is not supported, U=
nsupported<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# Notes: It&#39;s strongly recommended to issue the guest-sync co=
mmand<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resum=
es<br>
&gt;&gt; +# .. note:: It&#39;s strongly recommended to issue the guest-sync=
 command<br>
&gt;&gt; +#=C2=A0 =C2=A0 before sending commands when the guest resumes.<br=
>
&gt;&gt;=C2=A0 #<br>
&gt;&gt;=C2=A0 # Since: 1.1<br>
&gt;&gt;=C2=A0 ##<br>
&gt;&gt; @@ -1461,16 +1462,15 @@<br>
&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)<br=
>
&gt;&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;server=
&quot; or &quot;client&quot;<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# Notes: On POSIX systems the fields @id, @name, @pretty-name,<br=
>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant and @variant=
-id follow the<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0definition specified in os-release(5). Refer=
 to the manual page<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0for exact description of the fields.=C2=A0 T=
heir values are taken<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0from the os-release file.=C2=A0 If the file =
is not present in the<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0system, or the values are not present in the=
 file, the fields<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0are not included.<br>
&gt;&gt; +# .. note:: On POSIX systems the fields @id, @name, @pretty-name,=
<br>
&gt;&gt; +#=C2=A0 =C2=A0 @version, @version-id, @variant and @variant-id fo=
llow the<br>
&gt;&gt; +#=C2=A0 =C2=A0 definition specified in os-release(5). Refer to th=
e manual page for<br>
&gt;&gt; +#=C2=A0 =C2=A0 exact description of the fields.=C2=A0 Their value=
s are taken from the<br>
&gt;&gt; +#=C2=A0 =C2=A0 os-release file.=C2=A0 If the file is not present =
in the system, or the<br>
&gt;&gt; +#=C2=A0 =C2=A0 values are not present in the file, the fields are=
 not included.<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0On Windows the values are filled from inform=
ation gathered from<br>
&gt;&gt; -#=C2=A0 =C2=A0 =C2=A0the system.<br>
&gt;&gt; +#=C2=A0 =C2=A0 On Windows the values are filled from information =
gathered from<br>
&gt;&gt; +#=C2=A0 =C2=A0 the system.<br>
&gt;<br>
&gt; Please don&#39;t change the indentation here.=C2=A0 I get the same out=
put with<br>
&gt;<br>
&gt;=C2=A0 =C2=A0@@ -1461,7 +1462,7 @@<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)=
<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;ser=
ver&quot; or &quot;client&quot;<br>
&gt;=C2=A0 =C2=A0 #<br>
&gt;=C2=A0 =C2=A0-# Notes: On POSIX systems the fields @id, @name, @pretty-=
name,<br>
&gt;=C2=A0 =C2=A0+# .. note:: On POSIX systems the fields @id, @name, @pret=
ty-name,<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0@version, @version-id, @variant and =
@variant-id follow the<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0definition specified in os-release(5=
). Refer to the manual page<br>
&gt;=C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0for exact description of the fields.=
=C2=A0 Their values are taken<br>
<br>
I&#39;m blind.=C2=A0 Actually, you change indentation of subsequent lines f=
rom 4<br>
to 3 *everywhere*.=C2=A0 I guess you do that to make subsequent lines line =
up<br>
with the directive, here &quot;note&quot;.<br>
<br>
Everywhere else, we indent such lines by 4.=C2=A0 Hmm.=C2=A0 How terrible w=
ould it<br>
be not to mess with the alignment?<br>
<br>
If we want to use 3 for directives, is it worth pointing out in the<br>
commit message?<br>
<br>
[...]<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Let me look up some conventions and see what&#39;s the most prominent.=
.. as well as testing what emacs does by default (or if emacs can be config=
ured to do what we want with in-tree style config. Warning: I am functional=
ly inept at emacs lisp. Warning 2x: [neo]vi[m] users, you&#39;re entirely o=
n your own. I&#39;m sorry.)</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">I use three myself by force of habit and have some mild reluctance to r=
espin for that reason, but ... guess we ought to be consistent if we can.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">(No idea where my habit c=
ame from. Maybe it is just because it looks nice to me and no other reason.=
)</div><div dir=3D"auto"><br></div><div dir=3D"auto">((I have no plans, nor=
 desire, to write any kind of checker to enforce this, though - sorry.))</d=
iv></div>

--000000000000260b8c061b5439b2--


