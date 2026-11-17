Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEC7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iXdDRP6z;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z+falvjT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTG4u-0003j7-7i; Tue, 17 Nov 2026 05:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTG4r-0003iq-2a
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTG4o-0008Kb-UX
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 05:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794909969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5WNiC/7ExOCg2GugQt2AGmKEgpBvUjTWJvlJ87HKBIE=;
 b=iXdDRP6z1oiaVHIHRTjGJLYGmqf5nJ2cUEPUGI8RkbkH/ObR88RRniDH0qVYUofZhjP2Zp
 sk62el3U/2uVBiad90kcmBxqpgvwD1k30KBXx9lCI+ocySfxs6toyjHe4hSJF444nsr3FX
 ksQbhlp23q5MKUnIe0guZDzGgAx7hhE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-K_g96U_bPoivUceJjnl4sA-1; Tue, 17 Nov 2026 05:06:07 -0500
X-MC-Unique: K_g96U_bPoivUceJjnl4sA-1
X-Mimecast-MFC-AGG-ID: K_g96U_bPoivUceJjnl4sA_1794909966
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5be3e5b8cbfso1769923e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:06:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794909966; cv=none;
 d=google.com; s=arc-20260327;
 b=PPMagGhf3QhUu13bZVCk5fuDf/V0qh9csgzen8CHlBS6LTb7y6hKk1RLD+Xop7D+Xn
 I2lrg2sB/JnaRPjm7e1LZ9FetOarEAFRDuHgjyb6gfudEHwIFXQ81YKo31Ry5dXc33j1
 lR1RHuGIFpzfmZx9VtUr7PTQkXbxSQxPrLzGh8jiLYYzMGW7Zy3Oq4KC5NpGwI8TAz5n
 Pwea/Jj37GxBGnDh479F/vyb0cWkd1F87M3FUfg8rE7S+nNMBCpNXQp16VayOzcmtRko
 tBCFYJ3/8gwHEV+AuTFSepty1IfazXZ/WGAp1BMvJ77eJz5ALHh7KeleviTI0rxLqUCx
 pu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5WNiC/7ExOCg2GugQt2AGmKEgpBvUjTWJvlJ87HKBIE=;
 fh=vGW0x/LIyq+JGE/jf62yfLKeIt/+RvVMH51dc4quSPk=;
 b=MHVsQfMAg3SiQlR6rUQQ8LiK4hDqsVAdYbBJD253CIZBooZcyTfZYBSHQrQydM6JgS
 AGpPZW6BgAC4sA7LEUJCjxLmZcTkqTqg74VRji3vZv5/cryBX4qMxHcDYzrDygGAcMfF
 2VaOy4nA4yVpjGjuurFY8LPzSauZEbKoqmmskQ/yshCLvMCRoRw354ZdzNMfusUp5Mmt
 2enrTqLiO3ZAxKIl/FNvUWqlZEtPkqgZTO3RuJIWajg33DiKCTy9ol+mXgLDA6FsgL3r
 MhvnRx0DvtvS8zq5bJLjMp0LIGkammjtT72XYxYraMThQ36VZdCGc4gv9AHtPxKwUg5U
 wngw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794909966; x=1795514766; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5WNiC/7ExOCg2GugQt2AGmKEgpBvUjTWJvlJ87HKBIE=;
 b=Z+falvjT/ybU6TPNTu5j7V7iD/GalLaokzViGAi6xycpqI6LPvQhN+gK05QII7rTv5
 i+d1q+poZlDJvmTNm4b+avrWPK5B6M2JQO08Iuv7/pOR2JD68HGyzYx4mriOsGPqQwbv
 twoAaGA3PyFwZx29uqIGzt4FtXPQzrUtzEbxC00IDyAWWAsx8O0lAtkdIQ6APM7Jv4Th
 SWSPWog3EDnxzcdefezqhELLcZaw2HWUm0qHOoVAcn8/m/T6fvHHTAUV6A7jjwhQOHoX
 fIOA4YsAkSolWoKZtLpfmphNXCU+5qHzohG5lxa1TOwfEXAMER0PeSzZt0ZSuiUPxWl9
 e6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909966; x=1795514766;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5WNiC/7ExOCg2GugQt2AGmKEgpBvUjTWJvlJ87HKBIE=;
 b=uE9I/Li5W6m+g1QQW8/p4OEwtHUrO2xECuN/INczTBjcbszEV+qOa/a6FBfIKzHrvB
 Z2SmZ661BmOOG9mRvz7n3b9SzrtQm9tbZUSC/4qTDxjoMH5iFBRznTrQn1iObcZNsPhO
 AfXbC6xq6X7t1TcgiH0zzALxcRN7a7IBrQLlp6LQh35/AougI/HfhUTbLrovrEgpLMO5
 JqnCB8ZRH5OlsmV4mNRSjCUPYF7fEghH1yxBlxpTWwFfe0n+ahTtjurVIeLvxIxGlp4/
 WlpL0U1YYRgbKZokYXzQzeDLHLeMUFizxo6AJ24uxhyvLGF1itERoTm2S9Bi1fb87pdT
 tzeQ==
X-Gm-Message-State: APuU4Z8djrFDuV0GAeS18vEqguh8hz3rB4aA0vKCkPUumBMUVWc5fTJo
 vKoT9WSSGDAFhk3pErejpHe08seBYmU2GXRbSU5gL3WVgkL6jE8mQ3+OpCo34dsD3PUevOi0moR
 PItKpMTnqGNoeMXsg6gc0kFKKF4YMfLJI6T5HvmziMMGkcnSO8AjAu86rzRiUoBGmmIfecQkEsM
 Q0gpwlaM2GaycNgTYuI+0vBPkii5tg67w=
X-Gm-Gg: AYBFou24yCRcui1upN6xL7D4Hncj49syjRrtTlEg2BgwtqxX5MugRvxCOVWtB7LLcuv
 EYaU/E61Bx6NrG4kSpa1O1ccWcmmhxid2DiFe1DP/HOW2713r1OCRCJei9yMHvUbF9Cd8U2k4S7
 gfP2RyJ/bwEJbhAVB47ZKU6oPo58Uv4vxB3WpQ1SIrsnxzQEmxyMOaGTeSYA==
X-Received: by 2002:a05:6512:669c:10b0:5bf:d063:608 with SMTP id
 2adb3069b0e04-5c1a132425cmr566983e87.17.1794909965696; 
 Tue, 17 Nov 2026 02:06:05 -0800 (PST)
X-Received: by 2002:a05:6512:669c:10b0:5bf:d063:608 with SMTP id
 2adb3069b0e04-5c1a132425cmr566967e87.17.1794909965206; Tue, 17 Nov 2026
 02:06:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116161608.1145725-1-eashurov@redhat.com>
 <20261116161608.1145725-3-eashurov@redhat.com>
 <878q2slzf4.fsf@pond.sub.org>
In-Reply-To: <878q2slzf4.fsf@pond.sub.org>
From: Elizabeth Ashurov <eashurov@redhat.com>
Date: Tue, 17 Nov 2026 12:05:54 +0200
X-Gm-Features: AclHuK9rOANHGxverhVhm29ahZz_QaUu-EqWownXCtE7I1flpAYMLRdjcmFmXnY
Message-ID: <CAK957kEZBwoLKGALKtFVkXTEc7EkGRY=-00Am+PWGgPiV52AZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] qga: Add guest-get-driver-services command for
 Windows
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 dholler@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com, 
 kramdoss@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e15ba00660760a00"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e15ba00660760a00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, we can simplify the descriptions to "four-part version of the driver
binary" and "driver vendor name from the driver binary".

On Tue, Nov 17, 2026 at 8:55=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Elizabeth Ashurov <eashurov@redhat.com> writes:
>
> > Add a new guest-get-driver-services command that returns registered
> > driver services from the Service Control Manager
> > (EnumServicesStatusExW).  Each entry includes the service name,
> > configured binary path, current SCM status, and FileVersion and
> > CompanyName metadata extracted from the driver binary.
> >
> > Normalize driver binary paths from the service database before
> > reading version resources, including SystemRoot,
> > environment-variable, NT-prefix, and relative path forms.
> >
> > Unrecognized SCM service states are reported as "unknown" with a
> > log message rather than aborting the enumeration, so that future
> > Windows versions do not break the command.
> >
> > Link against version.dll (-lversion) for the GetFileVersionInfo
> > and VerQueryValue APIs.
> >
> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>
> [...]
>
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 081c99bc74..913fe25924 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1590,6 +1590,33 @@
> >    'returns': ['GuestDeviceInfo'],
> >    'if': 'CONFIG_WIN32' }
> >
> > +##
> > +# @GuestDriverServiceStatus:
> > +#
> > +# @stopped: the service is stopped
> > +#
> > +# @start-pending: the service is starting
> > +#
> > +# @stop-pending: the service is stopping
> > +#
> > +# @running: the service is running
> > +#
> > +# @continue-pending: the service is resuming
> > +#
> > +# @pause-pending: the service is pausing
> > +#
> > +# @paused: the service is paused
> > +#
> > +# @unknown: SCM returned a service state not recognized by this
> > +#     QGA version
> > +#
> > +# Since: 11.2
>
> 12.0
>
> More of the same below.
>
> > +##
> > +{ 'enum': 'GuestDriverServiceStatus',
> > +  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
> > +            'continue-pending', 'pause-pending', 'paused', 'unknown' ]=
,
> > +  'if': 'CONFIG_WIN32' }
> > +
> >  ##
> >  # @GuestDriverPackage:
> >  #
> > @@ -1610,6 +1637,26 @@
> >              '*vendor': 'str' },
> >    'if': 'CONFIG_WIN32' }
> >
> > +##
> > +# @GuestDriverService:
> > +#
> > +# @name: service name
> > +#
> > +# @driver-path: driver binary path configured in the service database
> > +#
> > +# @version: four-part FileVersion from the driver binary
> > +#
> > +# @vendor: CompanyName from the driver binary
>
> Are "FileVersion" and "CompanyName" established technical terms?
>
> Are they necessary here, or could we simply say something like "driver
> version" and "driver vendor name"?
>
> > +#
> > +# @status: current service status
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'struct': 'GuestDriverService',
> > +  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
> > +            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
> > +  'if': 'CONFIG_WIN32' }
> > +
> >  ##
> >  # @guest-get-driver-packages:
> >  #
> > @@ -1621,6 +1668,17 @@
> >    'returns': ['GuestDriverPackage'],
> >    'if': 'CONFIG_WIN32' }
> >
> > +##
> > +# @guest-get-driver-services:
> > +#
> > +# Retrieve registered driver services in the guest.
>
> Please use the revised syntax for introductions:
>
>    ##
>    # @guest-get-driver-services:
>    #     Retrieve registered driver services in the guest.
>
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'command': 'guest-get-driver-services',
> > +  'returns': ['GuestDriverService'],
> > +  'if': 'CONFIG_WIN32' }
> > +
> >  ##
> >  # @GuestAuthorizedKeys:
> >  #
>
>

--000000000000e15ba00660760a00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Yes, we can simplify the descriptions to &quot;four-par=
t version of the driver binary&quot; and &quot;driver vendor name from the =
driver binary&quot;.</p></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 17, 2026 at 8:55=
=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armb=
ru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com" t=
arget=3D"_blank">eashurov@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add a new guest-get-driver-services command that returns registered<br=
>
&gt; driver services from the Service Control Manager<br>
&gt; (EnumServicesStatusExW).=C2=A0 Each entry includes the service name,<b=
r>
&gt; configured binary path, current SCM status, and FileVersion and<br>
&gt; CompanyName metadata extracted from the driver binary.<br>
&gt;<br>
&gt; Normalize driver binary paths from the service database before<br>
&gt; reading version resources, including SystemRoot,<br>
&gt; environment-variable, NT-prefix, and relative path forms.<br>
&gt;<br>
&gt; Unrecognized SCM service states are reported as &quot;unknown&quot; wi=
th a<br>
&gt; log message rather than aborting the enumeration, so that future<br>
&gt; Windows versions do not break the command.<br>
&gt;<br>
&gt; Link against version.dll (-lversion) for the GetFileVersionInfo<br>
&gt; and VerQueryValue APIs.<br>
&gt;<br>
&gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat=
.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index 081c99bc74..913fe25924 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1590,6 +1590,33 @@<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestDeviceInfo&#39;],<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @GuestDriverServiceStatus:<br>
&gt; +#<br>
&gt; +# @stopped: the service is stopped<br>
&gt; +#<br>
&gt; +# @start-pending: the service is starting<br>
&gt; +#<br>
&gt; +# @stop-pending: the service is stopping<br>
&gt; +#<br>
&gt; +# @running: the service is running<br>
&gt; +#<br>
&gt; +# @continue-pending: the service is resuming<br>
&gt; +#<br>
&gt; +# @pause-pending: the service is pausing<br>
&gt; +#<br>
&gt; +# @paused: the service is paused<br>
&gt; +#<br>
&gt; +# @unknown: SCM returned a service state not recognized by this<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0QGA version<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
<br>
12.0<br>
<br>
More of the same below.<br>
<br>
&gt; +##<br>
&gt; +{ &#39;enum&#39;: &#39;GuestDriverServiceStatus&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [ &#39;stopped&#39;, &#39;start-pending&#39;, =
&#39;stop-pending&#39;, &#39;running&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;continue-pending&#39;,=
 &#39;pause-pending&#39;, &#39;paused&#39;, &#39;unknown&#39; ],<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @GuestDriverPackage:<br>
&gt;=C2=A0 #<br>
&gt; @@ -1610,6 +1637,26 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vendor&#39;: &#3=
9;str&#39; },<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @GuestDriverService:<br>
&gt; +#<br>
&gt; +# @name: service name<br>
&gt; +#<br>
&gt; +# @driver-path: driver binary path configured in the service database=
<br>
&gt; +#<br>
&gt; +# @version: four-part FileVersion from the driver binary<br>
&gt; +#<br>
&gt; +# @vendor: CompanyName from the driver binary<br>
<br>
Are &quot;FileVersion&quot; and &quot;CompanyName&quot; established technic=
al terms?<br>
<br>
Are they necessary here, or could we simply say something like &quot;driver=
<br>
version&quot; and &quot;driver vendor name&quot;?<br>
<br>
&gt; +#<br>
&gt; +# @status: current service status<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestDriverService&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: { &#39;name&#39;: &#39;str&#39;, &#39;*driver-=
path&#39;: &#39;str&#39;, &#39;*version&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*vendor&#39;: &#39;str=
&#39;, &#39;status&#39;: &#39;GuestDriverServiceStatus&#39; },<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @guest-get-driver-packages:<br>
&gt;=C2=A0 #<br>
&gt; @@ -1621,6 +1668,17 @@<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestDriverPackage&#39;],<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# @guest-get-driver-services:<br>
&gt; +#<br>
&gt; +# Retrieve registered driver services in the guest.<br>
<br>
Please use the revised syntax for introductions:<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# @guest-get-driver-services:<br>
=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0Retrieve registered driver services in th=
e guest.<br>
<br>
&gt; +#<br>
&gt; +# Since: 11.2<br>
&gt; +##<br>
&gt; +{ &#39;command&#39;: &#39;guest-get-driver-services&#39;,<br>
&gt; +=C2=A0 &#39;returns&#39;: [&#39;GuestDriverService&#39;],<br>
&gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @GuestAuthorizedKeys:<br>
&gt;=C2=A0 #<br>
<br>
</blockquote></div>

--000000000000e15ba00660760a00--


