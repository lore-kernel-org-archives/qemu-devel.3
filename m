Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DDAD262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viRDt-0001Xi-Iv; Wed, 21 Jan 2026 00:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1viRDq-0001Wf-08
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 00:57:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1viRDn-00021U-Iz
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 00:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768975057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6AUqIeE3prIiJgNRe7rcm1rLzXZQ8FiUKZcqQrIjUdI=;
 b=g3/ErTS26z6m2QQ75NSRh+/qjGY/uXWSYzm8qfvaeYQAr9Djb2XgeROkcOVXh824N/147q
 aMHcQWtC2IGEsdbHPlK3Hmz+6EU1DK2WsvA5BFtucjJupPRdJWSxhDs6L/jNVinLrqcDuu
 JDXWrbN8Ds2utGG4As1R/CU3eB9+8a0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-oSMfCxK4Pa6M7mbgTDvI9Q-1; Wed, 21 Jan 2026 00:57:35 -0500
X-MC-Unique: oSMfCxK4Pa6M7mbgTDvI9Q-1
X-Mimecast-MFC-AGG-ID: oSMfCxK4Pa6M7mbgTDvI9Q_1768975054
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso4916123f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 21:57:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768975053; cv=none;
 d=google.com; s=arc-20240605;
 b=ZbCL2ZASkSmQ4F6z5lyGVw9y/KB9fqHg+KwfVDxk7nUSzWAe6prNJNRwkVf8klXPYP
 bHxhsF7a7UkRTc0nT6PlzP5ky9Gyu/aaaNElifS+UkkS4eUbRY6eREbY9iSvq7YmXpGg
 e3LMLeSDIydNP0fDEJfEj717Mn8RqfppT8g3Rs7xAm8yCYZmwoV6ofIsQtGfTdowUdvB
 PIRXVTyA6t3Rw/of4tY72MiuTI56SPIwwaMTs1kZHL1wqx6d4syMF/0LjNPIjVzAYdzP
 mP3IvpM4iRjbRZF/K1TQCZRe3P7lCTbqfvoyaDsUqlalZnislnlgUE0AAs6ozsTvqQs2
 LKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6AUqIeE3prIiJgNRe7rcm1rLzXZQ8FiUKZcqQrIjUdI=;
 fh=l/5ahq63ElPRUtARqX8jqWP8irpUY6t+pJVsRBYFsiA=;
 b=idbLakI3egOneuFb3NCJ/zHPGB8QzDxLnIoh56huAMz1O/BOQ6YQoGQVRAAz82+k15
 Dxp8XXsSys+k49sXPC1F6SRj7wNDNF5kz1AYO3sz4/q24E7F0nrX6vFIJ8ch5T1zYhyz
 gBA08d550XMVxCT2PTdYLaaxBrKSs/F6AbLCyqcQlwGETq9h3CyRaA78h01EYX8gR253
 bqeTXrbZIK2cX6/+r6YbSCbf0yym8UFyPO+2n8io4bhYrx1kYNIy19ExSKE42PQbOxD0
 w4pg5ezVwhsHYG6sXdoeyO1lL/TlEbxkljGnyw0e2+0+Z62afqhcTt9Pwhk7I/u2TMvN
 rsNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768975053; x=1769579853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6AUqIeE3prIiJgNRe7rcm1rLzXZQ8FiUKZcqQrIjUdI=;
 b=e67QKVubGxSUmajxzzAvywXwBf2aGRXkJmIovaiZpL5MUKpXfR29ojOLLOCZ2ODVvr
 4MD4Tk1VoSM+q+IYbKqkyWmZcCVObxkbzzEdfFfNFejJ1y/9BQib54AvdPWCZb8hWad6
 fBI0AU1GISoJaeGNIaUecuyQAXc5zWeOkHs9m91PKLV3lAiVEvCVmzgrziwGRr3ZokgR
 8XutcVBb4GPsRVMBK1smIitUGAafPeUL+T7jl5hJt5QkWHDcsKj6fRjNEqN3TmKG69ba
 J/gH2nHTJZRNIyhROR9Xnar9unBZMVx5vRq8vlzUS3jyfkcA/Sr47a2G826YrsJ2ZFmg
 qkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768975053; x=1769579853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AUqIeE3prIiJgNRe7rcm1rLzXZQ8FiUKZcqQrIjUdI=;
 b=odZStVcv/Mzrnp6P/adjAO45+mY2CvuIfx/LEo66hniilNpbpN7pyo03EZkn2xeh4Z
 DmedK10JV2xsq1b6nr35q1we4fkyIn5p7UMtiywY+WUZg6jNwjc5Ql62xR5DI0FfP+/p
 yFTpcGYBw3QROD9cBlV4VYqg6mZeTEj6HQuoizXMFIlDmT8JKTJXhsjdCgMpRqKwML4O
 ZZHUPwOO+Y8BRYc4IpvS9XPWHY1A5996XB9Y8QCmkPGwT9nER1VTTsFphj2QSsuRl+EU
 NU2DwdUIOwf6CwDDe+hf74L4L6my5YHOW5tSofekfPdv3nzCAgufBoxAOIz7zXvIl6Fq
 SuWQ==
X-Gm-Message-State: AOJu0Yxl6XMbU19OJirrR8SFdug+yfkgodSDPdVLlsAKGWUXZ/T+ipzp
 rxdOwf1uo1kOXLYIaaAZSIfIgPffZy2ojOBtKv8508mJ9PoxSlKqH3YGykzEEeurapi3PmxR3vb
 SOi0MeLmEHssaSbXJ7e9q6MDP2oNXew+zqZbWvWc5dadiPxmvh74mS+WXec1aBkI0VimaQg07aI
 2ubs6HR5sOFdrc/8SwFgVa/SrYXf23Bjt419TDwxk=
X-Gm-Gg: AZuq6aL6BLd9HfuMG9N+fqW7H3ilUBFq6d2WW8vavfckRu7BXddXoO9u5/wdUoKfF+R
 oNUaYM2qjS5HwZhDSG+grU3yRa9BEvlRb+CORX/fXcUnIPNJ6aEqCDa8RUZkz8FTCC7mfvaPz7P
 3ILGtZYawQKf8Y/Iy6Ro4H771VQm+hjPb2sIwKVNXlSl2lpbaIE+0jUgW+irZP2HBCLuadzvhMz
 oE9xXkdBCJPEbZX1hqEvETQf6rEeHQy5tDU1ZG/gypYxDP8JmmFpDa3tMz0KQCKmvr6Gg==
X-Received: by 2002:a05:6000:230f:b0:430:f7dc:7e8e with SMTP id
 ffacd0b85a97d-43569bbec67mr20835018f8f.34.1768975053197; 
 Tue, 20 Jan 2026 21:57:33 -0800 (PST)
X-Received: by 2002:a05:6000:230f:b0:430:f7dc:7e8e with SMTP id
 ffacd0b85a97d-43569bbec67mr20835001f8f.34.1768975052792; Tue, 20 Jan 2026
 21:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20260107084840.150843-1-pbonzini@redhat.com>
In-Reply-To: <20260107084840.150843-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 21 Jan 2026 06:57:20 +0100
X-Gm-Features: AZwV_Qg_GcWDQipJOkGY-dDY9qXlmkXAiAC6aLNMWPQFPywh3FiWYMDqa-GgYq4
Message-ID: <CABgObfaLA37=kKNreJO20pVZ5iGd7+xiKYQdj6WkvL2zfOvk4w@mail.gmail.com>
Subject: Re: [PATCH 0/5] qobject: switch JSON parser to push
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Armbruster, Markus" <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a3786c0648df99ac"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
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

--000000000000a3786c0648df99ac
Content-Type: text/plain; charset="UTF-8"

Ping.

Paolo

Il mer 7 gen 2026, 09:48 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> This rewrites the json-parser to use a push parser aka state machine.
> While push parsers are inherently more complex than recursive descent,
> the grammar for JSON is simple enough that the parser remains readable.
> There is therefore no need to use e.g. QEMU coroutines.
>
> Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
> to consume JSON values", 2018-08-24), I kept the json-streamer concept.
> It helps in handling input limits, it performs error recovery, and it
> converts the token-at-a-time push interface to callbacks---all things
> that are more easily done in a separate layer to keep the parser clean.
> However, there is no need anymore for it to store partial JSON objects
> in tokenized form.
>
> Another benefit is that QEMU can report the first parsing error
> immediately, without waiting for delimiters to be balanced.
>
> On top of the benefits intrinsic in the push architecture, it so happens
> that it's really easy to add a location to JSON parsing errors now, so
> do that as well.
>
> Paolo
>
>
> Paolo Bonzini (5):
>   json-parser: pass around lookahead token, constify
>   json-parser: replace with a push parser
>   json-streamer: remove token queue
>   json-streamer: do not heap-allocate JSONToken
>   json-parser: add location to JSON parsing errors
>
>  include/qobject/json-parser.h |  12 +-
>  qobject/json-parser-int.h     |  13 +-
>  qobject/json-lexer.c          |  11 +-
>  qobject/json-parser.c         | 493 ++++++++++++++++------------------
>  qobject/json-streamer.c       | 107 ++++----
>  5 files changed, 310 insertions(+), 326 deletions(-)
>
> --
> 2.52.0
>

--000000000000a3786c0648df99ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ping.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">Il mer 7 gen 2026, 09:48 Paolo Bonzini &l=
t;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This rewri=
tes the json-parser to use a push parser aka state machine.<br>
While push parsers are inherently more complex than recursive descent,<br>
the grammar for JSON is simple enough that the parser remains readable.<br>
There is therefore no need to use e.g. QEMU coroutines.<br>
<br>
Unlike the suggestion in commit 62815d85aed (&quot;json: Redesign the callb=
ack<br>
to consume JSON values&quot;, 2018-08-24), I kept the json-streamer concept=
.<br>
It helps in handling input limits, it performs error recovery, and it<br>
converts the token-at-a-time push interface to callbacks---all things<br>
that are more easily done in a separate layer to keep the parser clean.<br>
However, there is no need anymore for it to store partial JSON objects<br>
in tokenized form.<br>
<br>
Another benefit is that QEMU can report the first parsing error<br>
immediately, without waiting for delimiters to be balanced.<br>
<br>
On top of the benefits intrinsic in the push architecture, it so happens<br=
>
that it&#39;s really easy to add a location to JSON parsing errors now, so<=
br>
do that as well.<br>
<br>
Paolo<br>
<br>
<br>
Paolo Bonzini (5):<br>
=C2=A0 json-parser: pass around lookahead token, constify<br>
=C2=A0 json-parser: replace with a push parser<br>
=C2=A0 json-streamer: remove token queue<br>
=C2=A0 json-streamer: do not heap-allocate JSONToken<br>
=C2=A0 json-parser: add location to JSON parsing errors<br>
<br>
=C2=A0include/qobject/json-parser.h |=C2=A0 12 +-<br>
=C2=A0qobject/json-parser-int.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 13 +-<br>
=C2=A0qobject/json-lexer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<=
br>
=C2=A0qobject/json-parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 493 ++++++++=
++++++++------------------<br>
=C2=A0qobject/json-streamer.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 107 ++++----<br>
=C2=A05 files changed, 310 insertions(+), 326 deletions(-)<br>
<br>
-- <br>
2.52.0<br>
</blockquote></div>

--000000000000a3786c0648df99ac--


