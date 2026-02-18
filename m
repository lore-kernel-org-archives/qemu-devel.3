Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D6E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vso7d-0006OR-Dc; Wed, 18 Feb 2026 15:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vso7Y-0006O0-46
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:26:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vso7V-0006ur-IN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771446359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6b7N0ixeHsL7m50yy6yXfXwrT486E7jL8RjlXCfvj+g=;
 b=LPqVVFbbWN9vt212VzSvu0k9rF6tHFESEF4QJBP/Yi1zqNF0Db8uUa7js3sF2QleMCY6Z9
 IhxszqP2TVG72IfLQ41PDxvmWHuxx92p8/q4BKwf8r9AfczD3LSKNOO6/TBOCMKoYXQ+S1
 PEzynWZNSm+a8OP8IzU+BYZ7NeuTloA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-VCMzlH42Pe-1-X6JfWwxAw-1; Wed, 18 Feb 2026 15:25:57 -0500
X-MC-Unique: VCMzlH42Pe-1-X6JfWwxAw-1
X-Mimecast-MFC-AGG-ID: VCMzlH42Pe-1-X6JfWwxAw_1771446356
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-436267b01c4so232481f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 12:25:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771446356; cv=none;
 d=google.com; s=arc-20240605;
 b=Nk2GblJt9IOdR+gdRGU+hrBUcETdfq0WPLIekkZKnCESSmZJ7xjVdX0PlmZXJyH1J/
 7J/iR+n72y0z+q0sRq14tjUKK7jBGIjyShLB8lZzWcebXmOfbftha8P5h5sOBxL5VsWw
 eYEypFG/gWJX6YrZy/rUKZxGEzF2I49NZmm6qAQdhieJidbTR++te7ZR/4/YtXZgCIGF
 lS0uAhjN7D1xP8tXZMjAjCAMHlsL09amxvAOiTOi0boG9YygI5kMPRmDWX3hKXDNdAd8
 RsPIg12+tj4M4sLVHIe7l+d/gHPySdMuQDaLWk1aBfEUvlGUHSJxcCVaNTstYZciqIvs
 YcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6b7N0ixeHsL7m50yy6yXfXwrT486E7jL8RjlXCfvj+g=;
 fh=x6Mz7LKFGI1fzytJYuqKohItrHWx+XZmCrvOrhhVxTE=;
 b=diwNGR0YGEOKyKpWFqyGOaY16XWeobaZWaVdXF+n1yxfmAuwU61c5GJH20jpg/q0dk
 TlhqCvrharq4Q7Do6fBT1xtpbWT57hgDFKOzE1s0skLzysQx0n2wCepxtgl7hV3H8bWu
 zMBcCcsAeCoOfFPY/2BbuRH7dwnaxMXE0WPCS0Fqwx00pcQENXIkq/AzDO/WeNwTvSdw
 /sMnvDH7sNZjpVpy5RVWMdGlVTWC9kcro2ntFEpNSqZmAA2rYLs1NuL1PDOFnJzORVxO
 E1x8vOdEmcTGafzdgGKDDNUn2sxyCjFrXIuhRcVHl/Oc3HMV+FDF9sJR5luW5CsQWemV
 2Afg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771446356; x=1772051156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6b7N0ixeHsL7m50yy6yXfXwrT486E7jL8RjlXCfvj+g=;
 b=L8bH1S8uRnbIE2WRjGo1957ga1jN6TxSh0pC+fggcTnnOdB5T/ZJY/uqmlTbpOXsLT
 sduo017C/g85yyE/sLzCY54REMLyWIHrEORS0szpSgECtrXKTIgKIPcrJ73r/x14SOyH
 heUq+I09CPpsvQ+KB5L7Iw4tdDiU2pS8o9YMUeNVsScVYyJ4Lx3S+dHsqqKHkptFesKo
 Lx3WuV2RX0u1C5n7Uu3EL3kK1YPWOQMArQpT4GVob2FO6eVydUjMrz/pOsxP72sO9KT5
 EKSn1iUao3R4u+x/h4txpfI5fneB4E+d16BpVhX7193Eq6JpAgKmDnKEg3dFWxt6gwiT
 8kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771446356; x=1772051156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6b7N0ixeHsL7m50yy6yXfXwrT486E7jL8RjlXCfvj+g=;
 b=SM1uvWzsmlTE3RlbgewxdQJY/LUEyipR37doQ8Z2BIK4WwZqs7kRr13C+zEX2yMHR/
 21QExCMHjh/t6CODFF8Ny9lk50nnKG8aH+17VazPEQFDOMh2gXCaDMjoUvUEh9wTjQay
 i8tY+ENzKrsFXShsAf1qjRz3lTsqsh2eFWc4mHBVl7mjlArGdB+aUvq8hxVYGUPD6cTF
 dOUX6VmGUF+Sl8gj92yJ5FzB1ScyFgjPEr1Vuvci/sDI2ZoscERxb+zw0rdlP2zSNTL0
 8WCT9nGzdjUJP9Hp8WHZBjKKcFLr9FJjluswDjRvKM/Qi5LG7WbUyty1N5IFX/MQiHZy
 RSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbMoRZz7vtpU0zXzW1Q83fcC0DW+XjqPK5oCqU38p77US5jSk9rHYqQLyroWs/8cELJlLGa5UBnwGQ@nongnu.org
X-Gm-Message-State: AOJu0YxhWI+XoSZNoZDfJeVbWcY5Mxx9miwhUR5JWRkca2L/G+FP8Y18
 kZjNDekz0hWPP1CKG1oOqEHJdSVKlhuRoKm2CNTe6ekh6RzOsWzsVOnPBCm/sSGHFlEaIu4/9Kh
 20RpxUIdPGcfsiGWdT78Wy5stBVAmmbC8pS7pxQjEhL+HJEwbbGN2z2pG48aCUKxnyWQWe+tJ9P
 YBckE0eGND1KQDcuyl672Rjo4PEZFOo7Q=
X-Gm-Gg: AZuq6aILVsUCntqP+oEbLWtWnSTBB3ATVjqzM50kgTkghmbDOHRDO2FPE9DnnJNx3rx
 lya8fz7mjyHKb1J3I7JfGQ14zHOQrifuvC5cqLpsQKmYTHVHupde7k/zf/73VlIN923C74wJb9t
 HxBjj4ZtQwxy4UjENjDGfNaWBJsoO2TdDN0fujZEPB22OA9WH0TyYTssISFMUfeuWs5cXe5cn1d
 pU0viXqaa7yqhZx+ghH8GIJ6HSEQ/1v3blYY++7wilk9ejRXTUnm95jRbLHtuDiklyWBesX/9/d
 2xRfe5k=
X-Received: by 2002:a05:6000:2911:b0:437:71b2:6f34 with SMTP id
 ffacd0b85a97d-43958df112cmr4836546f8f.1.1771446356045; 
 Wed, 18 Feb 2026 12:25:56 -0800 (PST)
X-Received: by 2002:a05:6000:2911:b0:437:71b2:6f34 with SMTP id
 ffacd0b85a97d-43958df112cmr4836503f8f.1.1771446355481; Wed, 18 Feb 2026
 12:25:55 -0800 (PST)
MIME-Version: 1.0
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
 <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
 <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
In-Reply-To: <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Feb 2026 21:25:44 +0100
X-Gm-Features: AaiRm53HF6lV9A-Z1qwD-JzTYAWVJOyaanOd4uRXaCr9QLz2hW2NfRnY6PYkcZw
Message-ID: <CABgObfaRzjaGTdXGHG=BeHFgGJaC4tt0eKOJu=L=SYWpQmm+6w@mail.gmail.com>
Subject: Re: CentOS 9, Python, and other Fairytales
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c1eac2064b1efe47"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000c1eac2064b1efe47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 18 feb 2026, 18:10 John Snow <jsnow@redhat.com> ha scritto:

>
>
> On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>> >> With most of the new sticking points being debian 12 (EOL in June) or
>> >> FreeBSD (timeline uncertain for when they'll re-modernize their pytho=
n
>> >> stack)
>> >>
>> >> One edge case here, however, is Sphinx, which does not actually have =
a
>> >> modern package in centOS stream 9.
>> >>
>> >> CentOS currently ships 3.4.3, but it would not be usable if using the
>> >> optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian 12
>> >> have sphinx 5.3.0 to offer us, which is a reasonable version jump, bu=
t
>> >> it means that CentOS would not be able to build docs unless you
>> >> enabled `--online` for configuring QEMU or sideloaded Sphinx
>> >> otherwise.
>> >
>> > CentOS 9 reaches end of life on May 31 next year.  I do not think
>> > keeping its ability to build bleeding edge docs offline out of the box
>> > for its final year (give or take) is worth your time, or anybody's.
>>
>> That's exactly the reason why we (John and I) introduced mkvenv.py,
>> except it was CentOS 8 and SLES 15 at the time
>> (https://www.qemu.org/2023/03/24/python/):
>>
>> "Some of these tools are run through the python3 executable, while
>> others are invoked directly as sphinx-build or meson, and this can
>> create inconsistencies. For example, QEMU=E2=80=99s configure script che=
cks for
>> a minimum version of Python and rejects too-old interpreters. However,
>> what would happen if code run by Sphinx used a different version?
>>
>> This situation has been largely hypothetical until recently; QEMU=E2=80=
=99s
>> Python code is already tested with a wide range of versions of the
>> interpreter, and it would not be a huge issue if Sphinx used a different
>> version of Python as long as both of them were supported. This will
>> change in version 8.1 of QEMU, which will bump the minimum supported
>> version of Python from 3.6 to 3.8. While all the distros that QEMU
>> supports have a recent-enough interpreter, the default on RHEL8 and
>> SLES15 is still version 3.6, and that is what all binaries in /usr/bin
>> use unconditionally."
>>
>> So yeah, there's precedent for doing this, and it's the right thing to
>> do anyway.
>>
>> >> My plan:
>> >> - Wait and see what happens after the current QEMU release
>> >> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
>> >> - Gleefully drop Debian 12 in June
>> >> - Hold my breath and see if FreeBSD happens to modernize by this poin=
t
>> >> (They have until October 2027 to do so, so it's a dice roll if they
>> >> will or not)
>> >> - Do a big round of Python modernization all at once; either to 3.11
>> >> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray fo=
r
>> >> forgiveness that I am removing CentOS stream 9's ability to build doc=
s
>> >> offline so I don't have to wait another six months and then do anothe=
r
>> >> big cleanup round
>>
>> The main nice features of 3.12 are improved f-strings, which are nice
>> but not really a necessity.
>>
>> If I read it correctly, https://www.freshports.org/lang/python says it
>> has 3.9 on PPC and 3.11 elsewhere, but
>> https://www.freshports.org/lang/python311 says 3.11 exists on PPC as
>> well.
>>
>> I'd go for 3.11 and Sphinx 7.  For FreeBSD we can require Python from
>> Ports.
>>
>
> freebsd ports is currently at 3.11, which is the main reason I am saying
> "see what freebsd does by June"
>
> if they update, we can have Python 3.12 and Sphinx 7.x. If they don't, we
> get 3.11 and 5.x
>

Why can't we do 3.11 and 7.x, and let freebsd also get sphinx from pypi
until they update?

Paolo

. Both are good jumps, but on the chance I can make the bigger jump, I'd
> rather do it in one round instead of two.
>
>
>> Paolo
>>
>>

--000000000000c1eac2064b1efe47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 18 feb 2026, 18:10 John S=
now &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini &lt;<a hre=
f=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonz=
ini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">&gt;&gt; With most of the new sticking points being debian 12=
 (EOL in June) or<br>
&gt;&gt; FreeBSD (timeline uncertain for when they&#39;ll re-modernize thei=
r python<br>
&gt;&gt; stack)<br>
&gt;&gt;<br>
&gt;&gt; One edge case here, however, is Sphinx, which does not actually ha=
ve a<br>
&gt;&gt; modern package in centOS stream 9.<br>
&gt;&gt;<br>
&gt;&gt; CentOS currently ships 3.4.3, but it would not be usable if using =
the<br>
&gt;&gt; optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian =
12<br>
&gt;&gt; have sphinx 5.3.0 to offer us, which is a reasonable version jump,=
 but<br>
&gt;&gt; it means that CentOS would not be able to build docs unless you<br=
>
&gt;&gt; enabled `--online` for configuring QEMU or sideloaded Sphinx<br>
&gt;&gt; otherwise.<br>
&gt; <br>
&gt; CentOS 9 reaches end of life on May 31 next year.=C2=A0 I do not think=
<br>
&gt; keeping its ability to build bleeding edge docs offline out of the box=
<br>
&gt; for its final year (give or take) is worth your time, or anybody&#39;s=
.<br>
<br>
That&#39;s exactly the reason why we (John and I) introduced mkvenv.py, <br=
>
except it was CentOS 8 and SLES 15 at the time <br>
(<a href=3D"https://www.qemu.org/2023/03/24/python/" rel=3D"noreferrer nore=
ferrer noreferrer" target=3D"_blank">https://www.qemu.org/2023/03/24/python=
/</a>):<br>
<br>
&quot;Some of these tools are run through the python3 executable, while <br=
>
others are invoked directly as sphinx-build or meson, and this can <br>
create inconsistencies. For example, QEMU=E2=80=99s configure script checks=
 for <br>
a minimum version of Python and rejects too-old interpreters. However, <br>
what would happen if code run by Sphinx used a different version?<br>
<br>
This situation has been largely hypothetical until recently; QEMU=E2=80=99s=
 <br>
Python code is already tested with a wide range of versions of the <br>
interpreter, and it would not be a huge issue if Sphinx used a different <b=
r>
version of Python as long as both of them were supported. This will <br>
change in version 8.1 of QEMU, which will bump the minimum supported <br>
version of Python from 3.6 to 3.8. While all the distros that QEMU <br>
supports have a recent-enough interpreter, the default on RHEL8 and <br>
SLES15 is still version 3.6, and that is what all binaries in /usr/bin <br>
use unconditionally.&quot;<br>
<br>
So yeah, there&#39;s precedent for doing this, and it&#39;s the right thing=
 to <br>
do anyway.<br>
<br>
&gt;&gt; My plan:<br>
&gt;&gt; - Wait and see what happens after the current QEMU release<br>
&gt;&gt; - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)<br>
&gt;&gt; - Gleefully drop Debian 12 in June<br>
&gt;&gt; - Hold my breath and see if FreeBSD happens to modernize by this p=
oint<br>
&gt;&gt; (They have until October 2027 to do so, so it&#39;s a dice roll if=
 they<br>
&gt;&gt; will or not)<br>
&gt;&gt; - Do a big round of Python modernization all at once; either to 3.=
11<br>
&gt;&gt; or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray=
 for<br>
&gt;&gt; forgiveness that I am removing CentOS stream 9&#39;s ability to bu=
ild docs<br>
&gt;&gt; offline so I don&#39;t have to wait another six months and then do=
 another<br>
&gt;&gt; big cleanup round<br>
<br>
The main nice features of 3.12 are improved f-strings, which are nice <br>
but not really a necessity.<br>
<br>
If I read it correctly, <a href=3D"https://www.freshports.org/lang/python" =
rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://www.fres=
hports.org/lang/python</a> says it <br>
has 3.9 on PPC and 3.11 elsewhere, but <br>
<a href=3D"https://www.freshports.org/lang/python311" rel=3D"noreferrer nor=
eferrer noreferrer" target=3D"_blank">https://www.freshports.org/lang/pytho=
n311</a> says 3.11 exists on PPC as well.<br>
<br>
I&#39;d go for 3.11 and Sphinx 7.=C2=A0 For FreeBSD we can require Python f=
rom Ports.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">freebsd ports is currently at 3.11, which is the main reason I am=
 saying &quot;see what freebsd does by June&quot;</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">if they update, we can have Python 3.12 and Sphin=
x 7.x. If they don&#39;t, we get 3.11 and 5.x</div></div></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Why can&#39;t we do 3.=
11 and 7.x, and let freebsd also get sphinx from pypi until they update?</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><d=
iv dir=3D"auto">. Both are good jumps, but on the chance I can make the big=
ger jump, I&#39;d rather do it in one round instead of two.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div></div>

--000000000000c1eac2064b1efe47--


