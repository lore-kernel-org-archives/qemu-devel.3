Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D128FF36C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEnJg-0003CN-Jp; Mon, 20 Apr 2026 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wEnJH-00034O-Tf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wEnJG-00028g-6u
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 08:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776686459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCvyvrDsYdstEu3Z7Kd6yULIgBNCbzGzTjhdB8mUGaE=;
 b=VmdZ0LvKYzaR3rV1hTFJjMTq6apyzpRJ1jC6BI9XfMtcYkC4m1tvyaMcoTPyfgsWJ9j8oz
 j0c45yndBurfrWfg0cwjymTPOwMzGZrQPAaWlp9KD2gt4WyG93Ehk98N1S/39TeAncuedL
 Hhz63n3hBlnDQbIf6/qAR0vGWCWeZ5s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-H9ZYkhp3O1Cc-APwfceR0w-1; Mon, 20 Apr 2026 08:00:57 -0400
X-MC-Unique: H9ZYkhp3O1Cc-APwfceR0w-1
X-Mimecast-MFC-AGG-ID: H9ZYkhp3O1Cc-APwfceR0w_1776686456
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso486988f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 05:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776686455; cv=none;
 d=google.com; s=arc-20240605;
 b=lWyWnx9TtxEofa7b0HVzKL/yz763rss59Hgc6ib3KsGryWRFSfqL/TqQX3ZG21syHt
 sDuHIA4aoR3c8BEicnBr0VWHZK4dOoMDj16XZGHuNY2Q3PhL5jQMn0pwtMaW9fwQEgsr
 B32T1WcpkD+zXcdVafPFlUJNQWIGFtzS0hlSijfWGXAVPaUL1VSm1nsgjm7Bg5NfgkM+
 bFKXd8y22mxXFJZVsC6awIZOF3QHlIZz9Ii25yLA9YVwBz5t5OA0fMSK/3RyzUzBLUpt
 SQP7JoKsQBjzb/3348RxqL6zZRDiMnE4M6os0AilxT937wvXbSnLfcjr+RN3X9KBww5w
 QA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uCvyvrDsYdstEu3Z7Kd6yULIgBNCbzGzTjhdB8mUGaE=;
 fh=Xm1ao//qklFdOPp89/6xUzCVv6E/EI6O1lKNAzhngcE=;
 b=lYGtuU/euabujjHIousfIc/vPH2P/lcy+GxdsBQW1cp7dXFRRdE7KB1lueiS91/Rm+
 mcFog32f0yzmWNFUVelWgscBH46GLjUWvlQN9cGUucdb7IU6NHPM6jaEH1tAhmpSxrNQ
 et5T29WL0ko6MaM6u1D2xUgl7NCfPnweuXmMlQvS5/MCYdSZsi7C4kPJPa2t9MJR8kqm
 GQlM5tTeSB9s2zUR3N+g77TEwA+pv7HwbSaE2ijW36XN99nen5/EFWPaJdJQPMQeZvBo
 mb2T6fpFsDARPgZMH3tBwJTUox5jIaxeMWQ6TD3py2ijrsZ3KNPj8svK0MfuXl94yMkh
 3BjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776686455; x=1777291255; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uCvyvrDsYdstEu3Z7Kd6yULIgBNCbzGzTjhdB8mUGaE=;
 b=Nbm2Q0pHixA/HHAQAFjsy4oj3pUSQaqaWBMe3go5b7QjPc7iTcSf9oXSO7UfDWjxJA
 p3EezSZXNwxC/UthODsVic0TuDQSPqFBmvdvYAFKbZ2FlYoS/46Lh/ZiKH3+eVzITv7y
 8/2LxnOqlnLYLB6TVILt5wa9d4i62HPQGlIDm9sYkQn4knwvP0B48IJQLhNLbozSkh3i
 VvFN6pBKFiAhy5ZLaRheqOjqg/dsUsGH0LVEnA2RXppQ3ne5iU6ZvsFT1Y0tb1wnm8Ft
 YBTDNurhvI5SIQyL3qDih60kvDMTsg+HcdN3gcFp+fK7ESeLAgWzL3uBpbUsSFdDiF87
 g/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776686455; x=1777291255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCvyvrDsYdstEu3Z7Kd6yULIgBNCbzGzTjhdB8mUGaE=;
 b=J70aNBqQwJ5Lvf4BYJnBZYDAKlZwkJ+L0ma/D9vTnOcNZ8AoaseCT7Zs08SMCDSnID
 5clQEPHLp2dG1lZxUoUsBNVZkY9o6qHBJ87YgPebiDvnosMa2DkchbjU7ZYWkI2Nb/st
 u/SBL4KthM/QXzQb/fqtCjNyFKGfyoVvhLXNphn9T2K7hMc7xbDnTYlWvYRX5VEnCVKX
 BwjbU/QLdIcwhuJ96cUFbWsZlL20cOiJjYqXFR/QkxCQNxtNwuNR59ETn/LiCSvbVoTZ
 D8mGTdKGQZ49ye+qx7IG7zLiRN7h2V3FAcHu/0LDUk78keKzxZAyTavCd1Uk3Ka4kJZN
 9ptg==
X-Gm-Message-State: AOJu0Ywsekyhm7ahrsI7hoR4PwHBeH/kKyDFyJ7mymXi9kgKhBKHXbon
 NwrAR9gzR/jEiyAjgzLNW1sZvwH4LUQqTEk9QclK/nZABbPtZh0tDxdkb+iZEs+3AWy6o1zbycV
 7Ue1VhMIWiSX1OZeFauZZ5ydMbWWQT2+dWd4cN220CH//gPONWf9lryXufWUuOZ963OFwH7/MCO
 uudaDXstEWZBs0RW71qy5HCq6B3CctHUhWAiMJ2lBaUQ==
X-Gm-Gg: AeBDiesZ62O8bV318KnsKfcH9Ew6N8QBrXe/vL+1N8aD2MA1deKMBGvFcxefFqAomdy
 STcSa2zV4IwrWvAAnCKLdOfJo//sGbvwLwu/6XSaEunkW84toN4k2XSKwS/sf3r+QAHCix/oHuE
 /396Rzj/LnbgFlQJLXPui5J/XWyY9frPLHumurVzFEiNyDa9glapP+HYUGPikrp/lndKwmOhkqs
 waDJCoLfMP9ptmo8/yR4NEAD152Wuj0H2Kj+tyrL8f2br3FIfG8kR9PQtJjz1R1QgzJk76BzgwS
 h2xT9Z+uC7t2IXiU
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-43fe3dc54ddmr20266716f8f.10.1776686454476; 
 Mon, 20 Apr 2026 05:00:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-43fe3dc54ddmr20266488f8f.10.1776686452808; Mon, 20 Apr 2026
 05:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260331095950.512326-1-pbonzini@redhat.com>
 <877bq1df03.fsf@pond.sub.org>
In-Reply-To: <877bq1df03.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Apr 2026 13:00:40 +0100
X-Gm-Features: AQROBzAE47Lio9ePHZ-T13dAQKwAY7I8YVnTkZ-oPtQhbeIwPOnAtMM0Amctvhg
Message-ID: <CABgObfZQBj5tpi49E83fLs9+azwDE-aPiD_Jue7bzOXAPSXntg@mail.gmail.com>
Subject: Re: [PATCH] tests: add test for json-streamer.c error recovery
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e5e30d064fe30cc4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--000000000000e5e30d064fe30cc4
Content-Type: text/plain; charset="UTF-8"

Il lun 20 apr 2026, 12:53 Markus Armbruster <armbru@redhat.com> ha scritto:

> > Before rewriting the error recovery code to work in a push parsing
> > setup, make sure that we have tests for it.
> >
> > Cover various cases of invalid JSON, to check that structural
> > recovery based on balanced brackets and braces works; and
> > lexer-based recovery which documents "\f" as a sure fire
> > way to reset the lexer.
>
> How is this related to tests/unit/check-qjson.c?
>

It tests at a lower level, talking directly to the json-streamer.c API.
check-qjson.c only uses qobject_from_json() so it never tests more than one
(attempted) JSON object in the input.

Paolo


>

--000000000000e5e30d064fe30cc4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 20 apr 2026, 12:53 Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
&gt; Before rewriting the error recovery code to work in a push parsing<br>
&gt; setup, make sure that we have tests for it.<br>
&gt;<br>
&gt; Cover various cases of invalid JSON, to check that structural<br>
&gt; recovery based on balanced brackets and braces works; and<br>
&gt; lexer-based recovery which documents &quot;\f&quot; as a sure fire<br>
&gt; way to reset the lexer.<br><br>
How is this related to tests/unit/check-qjson.c?<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">It tests at a lower level, =
talking directly to the json-streamer.c API. check-qjson.c only uses qobjec=
t_from_json() so it never tests more than one (attempted) JSON object in th=
e input.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
</blockquote></div></div></div>

--000000000000e5e30d064fe30cc4--


