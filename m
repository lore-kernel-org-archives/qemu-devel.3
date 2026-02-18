Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E30E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoML-0006KH-0O; Wed, 18 Feb 2026 15:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsoMK-0006K5-7Q
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsoMI-0003zX-Ck
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771447276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vN5lEzGTb0I8e+yC5843zEN0VCKqJ5uq81Enc0Gzxlw=;
 b=Gz/Uy8u3LA02fCaWgebDH9ti6m4fDyT7qllxovPugjw60wC0NanMIR/IwQleDIotAIIaac
 Gue6utE4qOoyP3ZriLtFzDRXsTBYXeDfqfqOFHwAkh7hvoCM0aU0/5vWTTYwgLmykOgurQ
 X22jWc8Rt5ixnT0BvHpBCDb32SzBrTY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-dkXCUaR8MlSAP1VQvtStfg-1; Wed, 18 Feb 2026 15:41:14 -0500
X-MC-Unique: dkXCUaR8MlSAP1VQvtStfg-1
X-Mimecast-MFC-AGG-ID: dkXCUaR8MlSAP1VQvtStfg_1771447274
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6445cf02fcbso261020d50.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 12:41:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771447274; cv=none;
 d=google.com; s=arc-20240605;
 b=EED5qdhdDmgLnv5yYKUHNtvLv1LpiLVMI0LnTJXMaHYS/u+4GpsmAJnqbvP9XmGYs4
 gmxTFWrkkEvyILubPxcuAZqJDmAuLPeSt9qIoaQNHUSoVab/LQG/DYokOPYJxDZk4BtE
 25wN1YS9AnFAnf14ypqFdy7frPoolJtcAmDPa1kXr4VW236fU84p3aUzRmZLzTV2YSI3
 yyWfQ3BRSdfcc4lEw5cQBlgYEZ1zvsS558mKsRcpJLKatPo/x2F0/uElroXFcznrMv8t
 NGvFZWL0qa07K6zrI1p11DMdPLs4D5LLfqRiollpjcOQHsbqSD1nlA8tnm5/1d3ncSzW
 gMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vN5lEzGTb0I8e+yC5843zEN0VCKqJ5uq81Enc0Gzxlw=;
 fh=Ubek74/ERqoEnvcold+F5UyZ8yi7ORVmtBmAUr5TTKg=;
 b=VQG22bC475b6ubX/UsXSlgH54gBVt1UQqoCPRqp8SvEO0hBbi5LOpzWyeQ9nmb8YOV
 rAXRPqnZjS3FW6Lngs7aNmgn1TcLeDz9svr4MRQFOreHKkxtlxttz/pq4VNSnecpizTr
 xM2TyPHGsDYWXsR/oRxmZzpizKl8gd0/4duelEbU92gWiGtg/jB3LTATG9IY5U7FOdga
 nQKmnDOr+gstWHOIKUevPo3A0dJjB+r0MIaV/Hbw3vy0H6Omh6USMe0A/IMF7tJQ3zUb
 P2PjHF2CVA5dlikBOp9BiCb0VhPUqW25JDjQhEv8LJgcUjWLUXqXSXz95/qPMLLnN71m
 Im4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771447274; x=1772052074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vN5lEzGTb0I8e+yC5843zEN0VCKqJ5uq81Enc0Gzxlw=;
 b=NwaoNOyXE5D+hgy66vMfE1X5eHV4w3NsfT1/bvIsKnNgXfdQup0bw2fbi+S5KWt01S
 5gjnI+yMbs6LMXla65aFHtljAhXmDzJ6v4fEwlx0PNI9C/JCt392sdUROf5bAAfpLafU
 E8ZSNlNYpELN8MdjqB9YSyEIMf9bD4vyFbrrhGRgdXWCFPH54E8/uG/XFHYMuid5Awpk
 l05s76Wu20iW/OpRz70HEgpPy2Q2YrgpOF+oWsifLFcPZCJYmowpRdMTPXoJYPxVURem
 mwu68BSBtsKxBGMKUSeFKPBuBsgNHJNQpb9wJfRIPb+8WErxT4k49SATyHZxFY8NclUT
 5AEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771447274; x=1772052074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vN5lEzGTb0I8e+yC5843zEN0VCKqJ5uq81Enc0Gzxlw=;
 b=Clf8ZlqvyHj4mMpl45/l5FzbHZnNrKnw9rvLfhSpcpvBkXsFkpouyPFaYBuuIAg4aJ
 XStAiuKHciq5tNMZixFgS8QL/NZdOVWYG8G27ffC4fzX0HNSB060lxdsBz6fGOdCckor
 7RqlU6rnVTyfjvr9qN/1vQ7vkPCWBFMc/9E96wFcyYP9W1F7/QBLMbRML2NdIKI+MSjk
 INj1149uBomBZfJRvPcyLLvVvP7iC0MwairhBA5S9lbn8U4U93m/OF2x+B2dXL90Rk0R
 k2OERnWIcB0dsE1vS9ebDgebe+dWx+sYGt1d9PaJyhwdo8/R1vDXWFdyE+qwOs6uuvRC
 p60w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU15NkMWasKYyTPKYOGSPhkJneUBxEdR+iND2AbLZAWKko8CiWzpXc/5zE4lU/Jg4UQ38slUe75gxnW@nongnu.org
X-Gm-Message-State: AOJu0YzrgrHgiFFFmKV3TNppM97JgpYfwDEAp/TJ1o1cryxwV7YidL1w
 60GDKFVQ07gxJtAR0EI7MnHSpN4YyVc2jZgRBgxUs2OAxE78kbiwbbVSySVpqFZpGULetnfmSQ+
 RtYgW2wIaezyyqSKgUo4gJWLwzJ1B/mScdT43LYKQOLEN+YPlTfwXIqDtERx82fRWbJ18/M+sSI
 yXrfvmAel58TGS9q4ZvHs1eH8X675Ra04=
X-Gm-Gg: AZuq6aIobl+hsGSYBobGqaeenoo6q31S7sxP9uGl7CmKn7k6cHH4oeRuIlZZMS/FSYD
 KukqtsnqvnEpmpkAUYG2Ha/GRyGzX1uO91wLV6K5LsM9ZV9yCiV4w6otizTVK0HSFjxgGPSrFK8
 DRiASut1QnoHY6B5V0q5tXVDrteOuwUdbIiIxBPoXroCKoILSI9NHWHuHqx0KQCZLPztFRd0H/s
 Y+kgRL27zx02gmfKt6kudQYWtSIX8y96BFs5Q==
X-Received: by 2002:a05:690e:bcc:b0:649:b9f3:9fb1 with SMTP id
 956f58d0204a3-64c556d4517mr1932822d50.76.1771447274225; 
 Wed, 18 Feb 2026 12:41:14 -0800 (PST)
X-Received: by 2002:a05:690e:bcc:b0:649:b9f3:9fb1 with SMTP id
 956f58d0204a3-64c556d4517mr1932803d50.76.1771447273793; Wed, 18 Feb 2026
 12:41:13 -0800 (PST)
MIME-Version: 1.0
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
 <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
 <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
 <CABgObfaRzjaGTdXGHG=BeHFgGJaC4tt0eKOJu=L=SYWpQmm+6w@mail.gmail.com>
In-Reply-To: <CABgObfaRzjaGTdXGHG=BeHFgGJaC4tt0eKOJu=L=SYWpQmm+6w@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 18 Feb 2026 15:41:03 -0500
X-Gm-Features: AaiRm524_j6NRbJvxZ1sBYkwMNRelHPMQgJgmPBgBsAhLnpmyoIaZk68ghH3MwI
Message-ID: <CAFn=p-ZdzRuisd6g65A+VXyDKXnTuBc0gnt0ApbhVBZG5GhJZQ@mail.gmail.com>
Subject: Re: CentOS 9, Python, and other Fairytales
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 18, 2026 at 3:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>
>
> Il mer 18 feb 2026, 18:10 John Snow <jsnow@redhat.com> ha scritto:
>>
>>
>>
>> On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>>>
>>> >> With most of the new sticking points being debian 12 (EOL in June) o=
r
>>> >> FreeBSD (timeline uncertain for when they'll re-modernize their pyth=
on
>>> >> stack)
>>> >>
>>> >> One edge case here, however, is Sphinx, which does not actually have=
 a
>>> >> modern package in centOS stream 9.
>>> >>
>>> >> CentOS currently ships 3.4.3, but it would not be usable if using th=
e
>>> >> optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian 12
>>> >> have sphinx 5.3.0 to offer us, which is a reasonable version jump, b=
ut
>>> >> it means that CentOS would not be able to build docs unless you
>>> >> enabled `--online` for configuring QEMU or sideloaded Sphinx
>>> >> otherwise.
>>> >
>>> > CentOS 9 reaches end of life on May 31 next year.  I do not think
>>> > keeping its ability to build bleeding edge docs offline out of the bo=
x
>>> > for its final year (give or take) is worth your time, or anybody's.
>>>
>>> That's exactly the reason why we (John and I) introduced mkvenv.py,
>>> except it was CentOS 8 and SLES 15 at the time
>>> (https://www.qemu.org/2023/03/24/python/):
>>>
>>> "Some of these tools are run through the python3 executable, while
>>> others are invoked directly as sphinx-build or meson, and this can
>>> create inconsistencies. For example, QEMU=E2=80=99s configure script ch=
ecks for
>>> a minimum version of Python and rejects too-old interpreters. However,
>>> what would happen if code run by Sphinx used a different version?
>>>
>>> This situation has been largely hypothetical until recently; QEMU=E2=80=
=99s
>>> Python code is already tested with a wide range of versions of the
>>> interpreter, and it would not be a huge issue if Sphinx used a differen=
t
>>> version of Python as long as both of them were supported. This will
>>> change in version 8.1 of QEMU, which will bump the minimum supported
>>> version of Python from 3.6 to 3.8. While all the distros that QEMU
>>> supports have a recent-enough interpreter, the default on RHEL8 and
>>> SLES15 is still version 3.6, and that is what all binaries in /usr/bin
>>> use unconditionally."
>>>
>>> So yeah, there's precedent for doing this, and it's the right thing to
>>> do anyway.
>>>
>>> >> My plan:
>>> >> - Wait and see what happens after the current QEMU release
>>> >> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
>>> >> - Gleefully drop Debian 12 in June
>>> >> - Hold my breath and see if FreeBSD happens to modernize by this poi=
nt
>>> >> (They have until October 2027 to do so, so it's a dice roll if they
>>> >> will or not)
>>> >> - Do a big round of Python modernization all at once; either to 3.11
>>> >> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray f=
or
>>> >> forgiveness that I am removing CentOS stream 9's ability to build do=
cs
>>> >> offline so I don't have to wait another six months and then do anoth=
er
>>> >> big cleanup round
>>>
>>> The main nice features of 3.12 are improved f-strings, which are nice
>>> but not really a necessity.
>>>
>>> If I read it correctly, https://www.freshports.org/lang/python says it
>>> has 3.9 on PPC and 3.11 elsewhere, but
>>> https://www.freshports.org/lang/python311 says 3.11 exists on PPC as we=
ll.
>>>
>>> I'd go for 3.11 and Sphinx 7.  For FreeBSD we can require Python from P=
orts.
>>
>>
>> freebsd ports is currently at 3.11, which is the main reason I am saying=
 "see what freebsd does by June"
>>
>> if they update, we can have Python 3.12 and Sphinx 7.x. If they don't, w=
e get 3.11 and 5.x
>
>
> Why can't we do 3.11 and 7.x, and let freebsd also get sphinx from pypi u=
ntil they update?

Hm, I guess no reason, beyond my recalcitrance on breaking docs on a
supported build platform unless absolutely necessary. It'd still be my
preference to align with the native distro repo/ports versions if at
all possible, but I suppose if FreeBSD doesn't fix itself by June or
so that we can consider dropping docs support with ports packages at
that time.

(I think I just have Stockholm Syndrome from arguing for "unnecessary
version bumps to get shiny new toys" and prefer to let those arguments
come from my seniors ... so I stick with very safe changes when at all
possible.)

>
> Paolo
>
>> . Both are good jumps, but on the chance I can make the bigger jump, I'd=
 rather do it in one round instead of two.
>>
>>>
>>> Paolo
>>>


