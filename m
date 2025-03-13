Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B05C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 14:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsj92-00056L-NK; Thu, 13 Mar 2025 10:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsj8z-00055K-OD
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsj8x-00058q-SA
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741874558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mSWLPJfiMyBjburTkW0OEGaQuq/A32kt6/KWjSZ2zb4=;
 b=QcssJtw886ZR9enCB9oNyX27W0+izsKg6dAjSJyxJo238JkCMT2tuQYZAbVNQmTTUQPlHY
 PsztEk6k+o2b9acqk9bEPh4MWtysHeokvaaL/86zPgEdjmrvRzWRZIIJ3ev8a7VTKst3gB
 f9o4RtKdHWbyqrU93IkkMHlqvl8tOhA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-PObfwsQGN4GLOOY6zOBpgw-1; Thu, 13 Mar 2025 10:02:36 -0400
X-MC-Unique: PObfwsQGN4GLOOY6zOBpgw-1
X-Mimecast-MFC-AGG-ID: PObfwsQGN4GLOOY6zOBpgw_1741874556
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2240a960f9cso17623225ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 07:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741874556; x=1742479356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSWLPJfiMyBjburTkW0OEGaQuq/A32kt6/KWjSZ2zb4=;
 b=B2Nve3UjoM3fkSSaSsF97O0UnzHPQWinXvyVCd4kQqhTwgoY/kyxqPiUu1Z7LXFJz7
 VY1e+ZXMjaLZOBWo/0DGgp0IwguttLPWrrbc4g120SrKWik7g7dtx75miIRvkUk5UPHy
 0sR0yGFrLMTfcBboGjMGJ/x24IMiIzQcYaz0xsasvXvUrc4jKuaqG+KT25W/BeUy/s2A
 uKWMqblOeCmAOp9qwbp5nVsB4H8JObDTkexd5tTt17kyr/1BF4Cjd/2+5jvakgOBg8H0
 L9YXP4GB9zBEM8wLUoVjm9J6VbNL/GdP/5Y55OpOYoRqv8eHbUpp0CflTBf+N346rr2U
 0HDA==
X-Gm-Message-State: AOJu0YxqBtUOD99UxrO6Pht/BLLArB3mTxpnz3S+Tbyx4LXdpheGUwiA
 CaHD4hQko1oc6V6k/K2+9Gd3G+oTOAJy7hY79iplcXtKDdxdyCbSl6GVPfRg4Ii+giCo7qTzDpd
 KkMrPmc/PQSXcTwyuCkmMsm3bi61w7jTkiEB3qVL1ceBbCyRb21tBKSsIMJjYwsTnEXs9UzFRWc
 /+FEh6/Bv0GP5x6P1rDr6ecJINd5c=
X-Gm-Gg: ASbGncvmB+reeZFDnqBvdlYuOPpW+T+4YYp0qQWZ+v/ByTjkcnf40/aMgwPcVmyI5yR
 d7g5uUV7DmjTJmluBOYdwjRXXd3NSDyfp+B9BJlS4t+ByMktPh6nnLCiY8b6Fi06OzP11XGGP0l
 /Pc3QyysJ7kRnZbYjUzIfGS/pDAW65
X-Received: by 2002:a17:902:e88a:b0:21f:6fb9:9299 with SMTP id
 d9443c01a7336-22428aaad15mr395756365ad.27.1741874555718; 
 Thu, 13 Mar 2025 07:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG68ACzZphCgA9T99jKJFoV9V4GpVRHan0fUBG5MIM4XFOX6oGA0YLRqTE0HvcB1+2BYu7rQZvE9NH/Oetpb/M=
X-Received: by 2002:a17:902:e88a:b0:21f:6fb9:9299 with SMTP id
 d9443c01a7336-22428aaad15mr395755725ad.27.1741874555167; Thu, 13 Mar 2025
 07:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-12-jsnow@redhat.com>
 <87y0x9cte4.fsf@pond.sub.org>
In-Reply-To: <87y0x9cte4.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Mar 2025 10:02:21 -0400
X-Gm-Features: AQ5f1JoAJA2wWMXwXsnfz1bAbSElHR9EYUhZXjAExKieP0i7JbpWZP9OMec2dM8
Message-ID: <CAFn=p-YBB-Qvmm4Tw2Kq4gNwLrjgY8-_sw7ZJAYnakQ7MDhc-Q@mail.gmail.com>
Subject: Re: [PATCH 11/11] docs: enable transmogrifier for QSD and QGA
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001aca5f063039c6c4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000001aca5f063039c6c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:54=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This also creates the `qapi-qsd-index` and `qapi-qga-index` QMP indices=
.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index 995594aaf43..35ec0e7db31 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -3,6 +3,9 @@
> >
> >  ##
> >  # =3D QEMU guest agent protocol commands and structs
> > +#
> > +# For a concise listing of all commands, events, and types in the QEMU
> > +# guest agent, please consult the `qapi-qga-index`.
> >  ##
> >
> >  { 'pragma': { 'doc-required': true } }
> > diff --git a/storage-daemon/qapi/qapi-schema.json
> b/storage-daemon/qapi/qapi-schema.json
> > index f10c9494906..2a562ee32e5 100644
> > --- a/storage-daemon/qapi/qapi-schema.json
> > +++ b/storage-daemon/qapi/qapi-schema.json
> > @@ -13,6 +13,14 @@
> >  # the array type in the main schema, even if it is unused outside of t=
he
> >  # storage daemon.
> >
> > +##
> > +# =3D QEMU storage daemon protocol commands and structs
> > +#
> > +# For a concise listing of all commands, events, and types in the QEMU
> > +# storage daemon, please consult the `qapi-qsd-index`.
> > +##
> > +
> > +
> >  { 'include': '../../qapi/pragma.json' }
> >
> >  # Documentation generated with qapi-gen.py is in source order, with
>
> Compare qapi/qapi-schema.json:
>
>    # =3D Introduction
>    #
>    # This document describes all commands currently supported by QMP.
>    #
>    # For locating a particular item, please see the `qapi-qmp-index`.
>    #
>
> Suggest to pick one phrasing and stick to it, unless there's a reason
> for more than one.
>

Nope, just free-handing it. What's your favorite? ;)

--0000000000001aca5f063039c6c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13,=
 2025 at 2:54=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This also creates the `qapi-qsd-index` and `qapi-qga-index` QMP indice=
s.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index 995594aaf43..35ec0e7db31 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -3,6 +3,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # =3D QEMU guest agent protocol commands and structs<br>
&gt; +#<br>
&gt; +# For a concise listing of all commands, events, and types in the QEM=
U<br>
&gt; +# guest agent, please consult the `qapi-qga-index`.<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 { &#39;pragma&#39;: { &#39;doc-required&#39;: true } }<br>
&gt; diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qap=
i/qapi-schema.json<br>
&gt; index f10c9494906..2a562ee32e5 100644<br>
&gt; --- a/storage-daemon/qapi/qapi-schema.json<br>
&gt; +++ b/storage-daemon/qapi/qapi-schema.json<br>
&gt; @@ -13,6 +13,14 @@<br>
&gt;=C2=A0 # the array type in the main schema, even if it is unused outsid=
e of the<br>
&gt;=C2=A0 # storage daemon.<br>
&gt;=C2=A0 <br>
&gt; +##<br>
&gt; +# =3D QEMU storage daemon protocol commands and structs<br>
&gt; +#<br>
&gt; +# For a concise listing of all commands, events, and types in the QEM=
U<br>
&gt; +# storage daemon, please consult the `qapi-qsd-index`.<br>
&gt; +##<br>
&gt; +<br>
&gt; +<br>
&gt;=C2=A0 { &#39;include&#39;: &#39;../../qapi/pragma.json&#39; }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Documentation generated with qapi-gen.py is in source order, w=
ith<br>
<br>
Compare qapi/qapi-schema.json:<br>
<br>
=C2=A0 =C2=A0# =3D Introduction<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# This document describes all commands currently supported by =
QMP.<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# For locating a particular item, please see the `qapi-qmp-ind=
ex`.<br>
=C2=A0 =C2=A0#<br>
<br>
Suggest to pick one phrasing and stick to it, unless there&#39;s a reason<b=
r>
for more than one.<br></blockquote><div><br></div><div>Nope, just free-hand=
ing it. What&#39;s your favorite? ;)</div></div></div>

--0000000000001aca5f063039c6c4--


