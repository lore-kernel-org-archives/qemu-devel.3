Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91C0E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvmh-0006mx-Be; Wed, 18 Dec 2024 10:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tNvmf-0006mV-Cq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:16:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tNvmb-0002ys-D2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734534975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwXIZishcwsIQ2vpQtyWln10JipKaQ2tOqBP86ZJOZE=;
 b=Amlk5w9deQONEUxpkD77zwk/RlkweugRehWqzjrM+gTBfsyLBCMPAA03WIQFKQTrv+rraB
 nVdIPJXf4WrIdsltAzm9eMmPD/5iymgjzSvn2jb+9qKUzAt6fIxGoYPQWtmeRT3Z66TAl8
 /0qxjH1EBxO7KNQXI5oeOCdbUDt7794=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-w7__4Fr3PwmlSxu2NUo5dA-1; Wed, 18 Dec 2024 10:16:11 -0500
X-MC-Unique: w7__4Fr3PwmlSxu2NUo5dA-1
X-Mimecast-MFC-AGG-ID: w7__4Fr3PwmlSxu2NUo5dA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef9dbeb848so5921200a91.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734534969; x=1735139769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwXIZishcwsIQ2vpQtyWln10JipKaQ2tOqBP86ZJOZE=;
 b=E4TN2xuom3hBaSJZY5m1n1it/UWk5eVwTlLAr/fubiO3IACravsjfBD3o5g8wbICOa
 mLMB9ABcFnGUI65gnU25vdJDNA/GecYiYOalrtM/AJtziLK1drYNGibeTwTE70M+Qu2Q
 GYX5D4TebMj+riwtSu/isnUAI4QMr5A86Flmg2Nn85R8dG8bgrd0CShgj5hBChcLd6X2
 aQjnNz9niORBC/nR1Vj+jITj4hiuOoqT9958WqMmy5hrnzAUomnfq1HswRkmMKlN7DeG
 /T7xcMH9M4llHWW7H5L21nqhua+oZP3OM1xQ8pgtYsUN8kU0srwZAHRW7AlRgMyC8T9b
 yrCg==
X-Gm-Message-State: AOJu0Yy38iGJRQw4CqsCglE38UJyts3e9aethEbLFQuT1U4QThJHQbKi
 Q2mneVYzyATwDV4n6bOPqN08419V5XIGdCH/JA0HRf59HRw7BY6gypWJagU2oyDu00LLWoDDuyJ
 L6RLJftopQFTY/NQ5FUHWYrbPwjvy8Z6FlWrrOlq+CTHPohGx/74dsDgf+O2k/hH9WQjhyo7DVV
 KvcDCGrU65QitcLY13qKXsj7NOKcJ2QiUEbdA=
X-Gm-Gg: ASbGncue4zdogzI6Gs6fxeCIJm9a3GDBFoqIeAiTxHfYqB89HE8L/XsjyGaW011mPMD
 77mw+5oCctlvvBCcm3rp1urMzqiOQ2F9Aq0F6OhfTSW1XvGHzxmXSb9itE6NIgpTz3W225A==
X-Received: by 2002:a17:90b:4d10:b0:2ee:a04b:92ce with SMTP id
 98e67ed59e1d1-2f2e937d3bemr4072741a91.32.1734534968696; 
 Wed, 18 Dec 2024 07:16:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt4n0C9PfNC003cJ2GnkVVmOcxsuyvsXQJ+8Zn8I0WTVtpu1ozVHy5UGjFWoSHpxNNEhuewnCnZxrSyKkFxqA=
X-Received: by 2002:a17:90b:4d10:b0:2ee:a04b:92ce with SMTP id
 98e67ed59e1d1-2f2e937d3bemr4072717a91.32.1734534968434; Wed, 18 Dec 2024
 07:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-4-jsnow@redhat.com>
 <871py5tbve.fsf@pond.sub.org>
In-Reply-To: <871py5tbve.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 18 Dec 2024 10:15:56 -0500
Message-ID: <CAFn=p-a-VVvU32C7qXqEpGDcj9ypKx1fqoJsiurUq9Upkt3xKg@mail.gmail.com>
Subject: Re: [PATCH 03/23] docs/qapidoc: remove example section support
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000a4f51806298ce410"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--000000000000a4f51806298ce410
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024, 7:27=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Since 3c5f6114 we no longer actually generate Example sections, so this
>
> Suggest s/generate/support/
>

I meant to say: because the parser doesn't support them, it no longer
creates such section objects, so there's no need to handle them.


> > support in qapidoc is now dead code.
>
> Oversight, I guess.
>

O:-)


> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
>

--000000000000a4f51806298ce410
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 18, 2024, 7:27=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Since 3c5f6114 we no longer actually generate Example sections, so thi=
s<br>
<br>
Suggest s/generate/support/<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I meant to say: because the parser doesn&#39;t s=
upport them, it no longer creates such section objects, so there&#39;s no n=
eed to handle them.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
&gt; support in qapidoc is now dead code.<br>
<br>
Oversight, I guess.<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">O:-)</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000a4f51806298ce410--


