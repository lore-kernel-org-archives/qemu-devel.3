Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2A4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH4bJ-0004wy-5J; Mon, 19 May 2025 13:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH4bG-0004wQ-2D
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH4bD-0005HZ-9A
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747676906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+NDp0ur7A+6GA6KD0ioYu3I/AZm9L4v5VKH+B0fBHk=;
 b=FJYXmq1N0gLMs9DAmMdEwWvWJ1RCiBAzyEMe1woWs5K7dT7WIh+xMk71v/Z9T+ihxA3pA8
 SwjkPcOp1iCRiM7IpagYvE2j+M8iKy+IduLdGSf7Z1BcocALnAWGrocdHFH1OZW/94pt6Y
 cFHZICYBzkRYeBfyUSum1GnWAjyg8+o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Csz1-4hXPLq71yp_KOy9HQ-1; Mon, 19 May 2025 13:48:24 -0400
X-MC-Unique: Csz1-4hXPLq71yp_KOy9HQ-1
X-Mimecast-MFC-AGG-ID: Csz1-4hXPLq71yp_KOy9HQ_1747676903
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-231d7a20b31so32358595ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747676903; x=1748281703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+NDp0ur7A+6GA6KD0ioYu3I/AZm9L4v5VKH+B0fBHk=;
 b=aMRQD90jPATTVnwhRxFq58+7Qf7tScqHjG4KpiVng385G5FcEj2j3ijE8KRfq5EOsQ
 IVLPQAO/rTMTKG5sFeQPG4+Wvm2iR2n6JLjTcGQKCvE0I1Z4oNwU5yoOkYGuP+mRiUwK
 P6s7Eb/uWRWgG+YyTODT7ckZYWHXrZtYzE3ejhwGqLv/3JfSL2qee/PUd+3BeZCp1s9V
 zEV4gCIkz3MNxoW9JImFqXzntt0QuEOOJcmKGJfGkVzDoO07Jw2hkgwNTqGE3Qiofagn
 V0YVxOF3IozGLuG48d9Juxh+kkl66qJLfuA5xnQLhFzMnvQ7FM4RoIDRFtkgfFwGnM0J
 UkkQ==
X-Gm-Message-State: AOJu0YzOu6oUiFpzRggT7jxInrbJop5UCHScU89L0/JY5qOQ295ceKE6
 8qjqn3ZB+fvSUNMPhS0HjZInnuaEniesFEi1gdLnRWcJ6qAEqB1nCLRZw56HrfT7TGt/nLGS/XR
 Ap2zG+OYW1Bz7E8JVyS4EpcKPQCgg7kDTWb8/ySUiBYbCkMLP8gwfjdaIx5brwZ5eOUdAD7ghFz
 bL3dE83E8XqK220ElR8QhNORPJfQD5vi8=
X-Gm-Gg: ASbGncuFqVoGaXLTihtCT3bZBVenvn5HQwQvAtgHRtbRIW5bao5MII+VE8mnySSBcUm
 lcMBL5XJ7YdxeEJRweI6hCXB1fQPWvIHLSSO9aEX1UbRIZhsgilM5ER5eeizPh/VlUTqeJtix23
 tURGCoTUro7NA22nXP2VKZFdfn
X-Received: by 2002:a17:902:db08:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-231d45c4e39mr216008945ad.43.1747676903354; 
 Mon, 19 May 2025 10:48:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxueigNJiQzI7rH1EHoN5ubB8N0j3ueMbhb3poPpy/JMwHlYe0B0QtNTSgdDPjB8tsPzVImMTMNxlPeHKrJVk=
X-Received: by 2002:a17:902:db08:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-231d45c4e39mr216008675ad.43.1747676903045; Mon, 19 May 2025
 10:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250512193357.3388514-1-jsnow@redhat.com>
 <87o6vu2rqd.fsf@pond.sub.org>
In-Reply-To: <87o6vu2rqd.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 19 May 2025 13:48:11 -0400
X-Gm-Features: AX0GCFtVcQpWNKJRYOgVPFilBj_orR9FR8G1D0vEZpdXBmmNtsor9zkcEXLXmTM
Message-ID: <CAFn=p-bbk4cN3sJ7m6ZLgV3i+c+ZjYKz=wR1=e5jWGnRVYbUWQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] python: add QAPI and qapidoc et al to python tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fd1fc0063580bc5a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fd1fc0063580bc5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 4:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Hiya, this series turns on automated linting for scripts/qapi,
> > docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py.
> >
> > This includes flake8/isort/pylint/mypy for scripts/qapi, but omits mypy
> > from the Sphinx plugins owing to my inability to strictly type the
> > extensions given the wide versions of Sphinx we actually support.
> >
> > [Maybe this will change soon, but it's not true just yet.]
> >
> > Though I have been using black in my own development, I have not yet
> > enabled it anywhere automatically. Maybe soon.
>
> You lost my series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> :)


My patches tool broke and I was doing things manually for a bit! I've got
it squared away thanks to Stefan Hajnoczi, and sent a PR out with the
proper message IDs and SOBs.

Thanks!

--000000000000fd1fc0063580bc5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 15,=
 2025 at 4:38=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hiya, this series turns on automated linting for scripts/qapi,<br>
&gt; docs/sphinx/qapidoc.py and docs/sphinx/qapi_domain.py.<br>
&gt;<br>
&gt; This includes flake8/isort/pylint/mypy for scripts/qapi, but omits myp=
y<br>
&gt; from the Sphinx plugins owing to my inability to strictly type the<br>
&gt; extensions given the wide versions of Sphinx we actually support.<br>
&gt;<br>
&gt; [Maybe this will change soon, but it&#39;s not true just yet.]<br>
&gt;<br>
&gt; Though I have been using black in my own development, I have not yet<b=
r>
&gt; enabled it anywhere automatically. Maybe soon.<br>
<br>
You lost my series<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
:)</blockquote><div><br></div><div>My patches tool broke and I was doing th=
ings manually for a bit! I&#39;ve got it squared away thanks to Stefan Hajn=
oczi, and sent a PR out with the proper message IDs and SOBs.</div><div><br=
></div><div>Thanks! <br></div></div></div>

--000000000000fd1fc0063580bc5a--


