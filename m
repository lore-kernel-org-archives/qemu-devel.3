Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F827F54ABC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52Xu-00074a-HE; Tue, 24 Mar 2026 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w52Xj-00073Q-Jz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1w52Xg-0002xR-2r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774361735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/64dKssy+2JVdu02y1MExUHcfmSGjO6t/r9rgqjL3k=;
 b=Rgdlrcfpehj89G8La3mXsvHGMxTOVCmQolP92pvsukBeWJ5RFgoDEnVkGl/KFEzoaBDpac
 I4J1957CR6gH35fblgGC92VcAbC+ZQClVvz/JCeiycY6WNw6v9Jnq2FkqdKSgq9SBiR8kz
 dEFErUg8YjGyzHjgz0BitVrhc7TYFPY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-AkA2igYjN2SpTFknmKvx1Q-1; Tue, 24 Mar 2026 10:15:33 -0400
X-MC-Unique: AkA2igYjN2SpTFknmKvx1Q-1
X-Mimecast-MFC-AGG-ID: AkA2igYjN2SpTFknmKvx1Q_1774361732
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59e28288067so4681219e87.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774361732; cv=none;
 d=google.com; s=arc-20240605;
 b=WtCYjnsuPKsEXtDiO8KyFeNic/ycLrdqrRr1qMqx0x0NSGTpeGiZPg20jnixjgMQPm
 bPm8dz471ENHdoyCqLJPwovvVsxwmMj4VyTVHtzlkXgP6wVffCmuBWOv25/RDU6gVmMa
 v257K5htmLICIX2PUa0w6vQQS0waExVwEGUqLlBtPfXIQ36bpHU8e3xws0xfw0aCSiLY
 FOr6uRDeECM6FqO+NFOiC2KaW7awqxweu/0woPB4mjmbWUaTTiZNoZQ3iVnCr4gyuirH
 xb4oqzcbSvFlNLCbCE9BG1PBI7PJtrx3UZYYihkDBAqphQC57wMdz+6+T0DrYTOSScgc
 diLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D/64dKssy+2JVdu02y1MExUHcfmSGjO6t/r9rgqjL3k=;
 fh=iiPr74RpBdBgqW9MuAsqCF1syYEyaCnPwjsNoNDzUR0=;
 b=U8PEDspXipK2thomMcxH6NGe5Eq4NUh1/S+uN/WFha6SD/eyclQQj7yy81hR88vBRk
 HOhL4LxK4bn4MTfwzZk3gPF6ixFqzTorKupj6GZnkmiMPTlw0nr6KY1x8QluErEaplgE
 gORRzviiF+gjs0Ktjru7TamZbHyrG4l7Kaoo8mtlIDIONPLGsTlLviZDCxGCLjirk8Y0
 pEOJNsYqQz5zfw76dSNdywrHwGoyWmqojw+WDeS1/KTWPkydBnxZ2otZJIGbr/SjTP/a
 4Cx0hqXk2DylRx+GnWzUHcGHyizRyzzxbWgVORowiBImn/CqNbC0SSVD6/QE7GumDHax
 yVxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774361732; x=1774966532; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D/64dKssy+2JVdu02y1MExUHcfmSGjO6t/r9rgqjL3k=;
 b=FZ6s/CtQHAoW80o1Ys4gIsCM9ufgK/qE4dodZjRtpzgR9BBSUb4fw+6eZRJ1myKGgp
 +tTi2CHIpfotNiIP3aB8boyg2yi7RRGWmGSUrTJn7ukJwoGKut3CT9cA17WPPu7Txj7f
 icmF6PRlUR089/e6x7iPUWwv8bqX0Lw1nBRCmR0i2tu7+FQGdSrMmGLu70WGJkQlG7zD
 4lI636WEgizPd/q67UGCUa5izLIuTZoxruozxtMcLMrzvLZ5Ez1l7DxGiTp9GAkQeDhI
 0GUz47MBtgHFmtCWcnAeI2FBFl3mhkCwb5k8dt86+I+mlmHp3VIozNywLVTypjoeIESk
 Hi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361732; x=1774966532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/64dKssy+2JVdu02y1MExUHcfmSGjO6t/r9rgqjL3k=;
 b=rNEhbXogc6xHEu9NIectuJXa3w9GAfeFcduuhikU7/XjUtYZjKRsN8OFDVFgmdxxpA
 iEehBFDqhacHlep3ngnYOhbds9nEY9IvmYu0BVXtfPBUELHT5+THjrIVFc6HEl1AWcVS
 EdC0jqRmX+XKHvZwqJFuM54LWpeHvYGYb6FxCcSZEyrEHvCkpTRZ1BWmwosaL3ODjkyS
 HzpaWRHvjo0EByEuQ80JHPESld4tMBu0eBNivVVcXPMpEBo9Ayo3gutBZSd77IMPFo87
 W9CbcocniR/RZxh/XhZInEyS7TZVsVyjVVYVYos3HwQq6tVVyl/9pGnMYl76RTTFLPgQ
 5Xkg==
X-Gm-Message-State: AOJu0YwLTvqowJTtHMYOUHVDjceCoSsJEvFKhnvMi2IVqoAZtspgjo07
 PwJ+0pWGkhZWuc8OoeNQ3D1ArYJJWR+da6nbAf/OkvlqYDoSyhxRzHSoGWDGsokg4AAB6uZIoZy
 HKtc+CDXSoo9CYWj/7cPFNqMybGF4xQVKbwv8F81yOyTSSBVouDa0YCG5BpiRFOR+fsLLNMGqE/
 U4+h5Cmgb1UUOMNHOdGTu+zyAB7g/gRPxBQoQ8ow9jE6UG
X-Gm-Gg: ATEYQzxvx2gO+V+Qofbt6ShW4Ps661yIaJETn77+y7g4uo5XejsSPQpJsgj8YjVxu5o
 TOmzpHoaiOHSwKHzDUxbhaSkPEyeAUNwGZ3i2kJwwTanPoGUNwjJ/64fW/yK9Ka3gxy0MDdtHwU
 txQyWM3OYPZXrgMnUwKTKzDGDaJ4ziioiITdrtgZIZMirx6CJx3zeebLtsjEg8krhLxvZB+JM3e
 R5m
X-Received: by 2002:a05:6512:4007:b0:5a1:3bd2:7330 with SMTP id
 2adb3069b0e04-5a285af4a19mr5266955e87.2.1774361731504; 
 Tue, 24 Mar 2026 07:15:31 -0700 (PDT)
X-Received: by 2002:a05:6512:4007:b0:5a1:3bd2:7330 with SMTP id
 2adb3069b0e04-5a285af4a19mr5266942e87.2.1774361730730; Tue, 24 Mar 2026
 07:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260312141657.1701801-1-eashurov@redhat.com>
 <20260318154752.1880933-1-eashurov@redhat.com>
 <ab1EhBoyvM2YVftM@redhat.com>
In-Reply-To: <ab1EhBoyvM2YVftM@redhat.com>
From: Elizabeth Ashurov <eashurov@redhat.com>
Date: Tue, 24 Mar 2026 16:15:14 +0200
X-Gm-Features: AQROBzBOzptb6DNpzwS0DW573toCJyU4NPOz6XnTJfdPTOaR31_eeepw_ArFIFk
Message-ID: <CAK957kF9NWKAdV32D-jX59N-4_NmLYpq__5YDa0tt=mFDiD+4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] qga: replace slog() with standard GLib logging
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, yvugenfi@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a9e1a1064dc5c839"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a9e1a1064dc5c839
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ll update accordingly.

Thanks.

On Fri, Mar 20, 2026 at 2:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Mar 18, 2026 at 05:47:51PM +0200, Elizabeth Ashurov wrote:
> > Replace qga-specific slog() calls with standard GLib logging APIs.
> > Use g_info() for command execution messages and g_warning() for
> > non-fatal failures, and remove the use of "syslog" as a log domain.
> >
> > Rework ga_log() to route messages to the log file and
> > syslog/Event Viewer, filtering by log level. Debug messages are
> > excluded from syslog even with --debug.
> >
> > - Default log level includes ERROR and CRITICAL
> > - -v/--verbose enables WARNING, MESSAGE, and INFO
>
> IMHO "WARNING" should be enabled by default too.
>
> > - -g/--debug enables all levels including DEBUG
>
> Since we can't use the natural '-d' short option, we can
> probably do with only the the long option.
>
> >
> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > ---
> >  qga/commands-linux.c   |  6 ++---
> >  qga/commands-posix.c   | 26 +++++++++---------
> >  qga/commands-win32.c   | 60 +++++++++++++++++++++---------------------
> >  qga/commands.c         | 29 ++++++--------------
> >  qga/guest-agent-core.h |  1 -
> >  qga/main.c             | 39 +++++++++++++++++++--------
> >  6 files changed, 82 insertions(+), 79 deletions(-)
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000a9e1a1064dc5c839
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I=E2=80=99ll update accordingly.<br><br>Thanks.</div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, Mar 20, 2026 at 2:58=E2=80=AFPM Daniel P. Berrang=C3=A9 =
&lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Mar 1=
8, 2026 at 05:47:51PM +0200, Elizabeth Ashurov wrote:<br>
&gt; Replace qga-specific slog() calls with standard GLib logging APIs.<br>
&gt; Use g_info() for command execution messages and g_warning() for<br>
&gt; non-fatal failures, and remove the use of &quot;syslog&quot; as a log =
domain.<br>
&gt; <br>
&gt; Rework ga_log() to route messages to the log file and<br>
&gt; syslog/Event Viewer, filtering by log level. Debug messages are<br>
&gt; excluded from syslog even with --debug.<br>
&gt; <br>
&gt; - Default log level includes ERROR and CRITICAL<br>
&gt; - -v/--verbose enables WARNING, MESSAGE, and INFO<br>
<br>
IMHO &quot;WARNING&quot; should be enabled by default too.<br>
<br>
&gt; - -g/--debug enables all levels including DEBUG<br>
<br>
Since we can&#39;t use the natural &#39;-d&#39; short option, we can<br>
probably do with only the the long option.<br>
<br>
&gt; <br>
&gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat=
.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-linux.c=C2=A0 =C2=A0|=C2=A0 6 ++---<br>
&gt;=C2=A0 qga/commands-posix.c=C2=A0 =C2=A0| 26 +++++++++---------<br>
&gt;=C2=A0 qga/commands-win32.c=C2=A0 =C2=A0| 60 +++++++++++++++++++++-----=
----------------<br>
&gt;=C2=A0 qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 ++++++-----=
---------<br>
&gt;=C2=A0 qga/guest-agent-core.h |=C2=A0 1 -<br>
&gt;=C2=A0 qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 +=
++++++++++++++++++--------<br>
&gt;=C2=A0 6 files changed, 82 insertions(+), 79 deletions(-)<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div>

--000000000000a9e1a1064dc5c839--


