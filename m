Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CBFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 06:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjWxT-0007Ge-15; Tue, 14 Jul 2026 02:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wjWxQ-0007GV-Lq
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:49:33 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wjWxP-0005ig-0C
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 02:49:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698beff7178so6815172a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 23:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011768; cv=none;
 d=google.com; s=arc-20260327;
 b=kH/iU1dEe3GBnB4ETS2qX6psdxzPiEktAMsTUj4KxZZ0PWqxR/HV6sF4KkT4u1Qhh8
 1pmST6FIqLovCIKhXUCdf0g58tLPBELQzndiprao4U+DaRxQX6BMKmL2t7ZZ/bcpx/fz
 7SqVSXVNwY8oaa70Tjca3gv95IbG0zB6PRKWEVJuHNGY2cVB3IaBxCRnBh5r12G/auD7
 xPPmi0JoexwIK6mrTY5aPA4sY3cDfiSNV/as7kwSMG0xvM8gmsrNrHiaK9axljuStVvn
 ZS1X8ZdF2rVFJHR6LHLSHH+6rRfdAUCMq3na8U3sgUUr2BaSqahHiukdTPOt+RaX8Upb
 yQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RK17H6tED2Z3i/OZlXC/g9njBhItcUvx550cGj8wuY4=;
 fh=PSGgbD/UzN8KyLFJvgx8N28zbUXg9sXP3vs4kb1tmR8=;
 b=Nvwh9xM7F7cJ+SHENPVwh1kYIghlJkm+HVPAJm+v+J3C4r2wdKy7XQqQrmwSIsKpYb
 Eeie6PYcweGkHjCZxzrnY8v8Hmrtt1HmdzBQIiQdW7poBC8lcG3e0gFFiyoPHwr+LAIW
 WoTX8kifXjqFbclHSUIxG+tT03b/Q8SQpOrbfBUarIfF4RnPXxAarYHTNGogZsr5VeKY
 n5RfpywPZcU1FM6chOXeMCgR0EsYroCr3E8fVS3RsfhOwmE9HNhdI6EzHYGJK5M0Qqot
 37nFR9fTO/CL8+ndbB/5phFXUyhdsak9rb0qccJgotdP85zkMoaAri1WEzktga5G9fSG
 CE5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784011768; x=1784616568; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RK17H6tED2Z3i/OZlXC/g9njBhItcUvx550cGj8wuY4=;
 b=SqH/CB9qjKfW7vph1ZmwNhlx2/NnkxEGDqkVC33F3oNHtWKcIXHfJKx5eBVeW5o3gW
 sewX71dOwHNhvtp5gyJjleSD7Bb5K00qSBo/zYMYK7GhofPPkuHLBQ+Z5sA8Jvs5lwq5
 e/fpRKflv0yvoC/d/ItjgRbAaKUG+j/2YO8IPSOJ54cvOe+Rp4Kav9m4JLMXT0+mkaAB
 QjVKhNtZ2tqaxWp4G9LZHAeFgycrG06G5HvdX7wlZBd9vlrqZL3Tla6vneOeovF1jxeS
 PPrv67pJYa84xSG2uEibqIo6p3qX4KVQArkxBPyEBHhatUbiWJUDqZNe0KPmA/lG5AJz
 EwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784011768; x=1784616568;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RK17H6tED2Z3i/OZlXC/g9njBhItcUvx550cGj8wuY4=;
 b=fKuVYn483aDA6H+3tx9OzPyDfJA3RMBQVrNS23L9kYDzQKMZDGFu6pLBLMiuv6Iye8
 1i1hjb/xkWCRtKXzu34VjFekqLFghv+YvN+n7W9dvBU3+w8BX97jMj396Y7lJoLw8MvB
 +hVVT0lAd6nPI93AzxLPPoxG2fPl+H2aOWrPsB/onwIlYcRYHC/7p1xgPfDvs9gumB5M
 iJP4wbSAzJ/K1eqhv5niw5elfauVSwbLfcEvnJMCxLA1xNh3Jc+ocEWGMAbbQwkS/flM
 UZGyhXkbosiNdWybicqwxulPyTsYIxzFruf4Bx+qaf6xbArWEq+YiCQj/1KNM9p8X0ff
 Pk6A==
X-Gm-Message-State: AOJu0YyrqzAUs71wuyT8BnugTWjpH60OwiQa9E+/2BW068ru7b133T7E
 Hp8LQ23WAAPvQTekn78dcx6aRA5fTybOOxY27nifJoJ9Qg8BNoq5lFe28yPDlyvPVdRNXC01EzN
 d8DNxfcGNld6nc3TkU56CIIuhx/G+W9I=
X-Gm-Gg: AfdE7ck1DWjqSTMJ/jvO/4QcqDuY2gNf5wkKIFGIf0ujtFHt2aX2tpell2xluHcNS77
 QRf6EUmoN9I92/V7bTZAVQT9hAGRjjNHORW7jvCGh3Dn5H5NHG490ofTCamQmf7ZLInFsvTHuzV
 FQVHy6gg2gBluCAFCInzF3NC7Wxu51CzSxzw//QKK1+rmaW5uXActRUxmhUv/yPVDKrCgqXhZq/
 utGnItlhAvKFXu37PzHLnO1vFp+1YsDMma2zlcmqRslFra5sL0p7YwapfiSX9e1wB4m4BDfUfoQ
 m2L1PZ8enGpqRmekyXDr2jE2xQyI
X-Received: by 2002:a05:6402:26c1:b0:698:be17:3790 with SMTP id
 4fb4d7f45d1cf-69c5f25d146mr5695470a12.37.1784011768353; Mon, 13 Jul 2026
 23:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPF+SGe9jOaGs1Mu=+_7CbDBKYAeELp+NEQJ1u5XmHADDo+dyQ@mail.gmail.com>
In-Reply-To: <CAPF+SGe9jOaGs1Mu=+_7CbDBKYAeELp+NEQJ1u5XmHADDo+dyQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jul 2026 07:49:16 +0100
X-Gm-Features: AUfX_mzDrmoPBweayJvKHQFL5qNG8AxngIh4VekE97mAyNP3lq89UbAx7F0g0Jg
Message-ID: <CAJSP0QX4bFcNEDgi=4XWuOehs6uzXV0aBLk9YCs58SdHcksqnQ@mail.gmail.com>
Subject: Re: Questions in Blogpost (Coroutines in QEMU: The basics)
To: Irtaza Hyder <irtaza.hyder@10xengineers.ai>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ba593c06568c9b27"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000ba593c06568c9b27
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 13, 2026, 12:38 Irtaza Hyder <irtaza.hyder@10xengineers.ai>
wrote:

> Hi there, I was reviewing the coroutine blogpost (
> https://blog.vmsplice.net/2014/01/coroutines-in-qemu-basics.html) and had
> a few questions about the example given. It states in the blog that it
> makes the code sequential, but aren't the co_* requests in `void
> coroutine_fn say_hello` seperate callbacks we need to implement, still
> leading to callback hell?
>

No, say_hello() is a single function. You read its code sequentially and
there are no explicit callbacks, just say_hello().


> Moreover it is stated that coroutines have to be explicitly yielded or
> terminated. In the example we are using blocking functions (send and
> readline), so how are we defining explicit yielding in such functions?
>

Any function that is declared with coroutine_fn may yield and must be
called from a coroutine.

co_send() and co_receive() can yield but they do not block the current
thread (e.g. by sitting in a blocking system call that is waiting for a
single thing to happen at the expense of other coroutines being unable to
run).

For example let's say I am waiting on a data being to a Chardev Frontend,
> perform some operation on it and then respond to the Frontend when I am
> able to write, how would I write a qemu_coroutine to deal with this? Are
> coroutines even the right approach to use for such a flow?
>

I'm not able to respond in full right now, but have CCed Daniel Berrange,
who worked on the QIOChannel APIs. If you search the codebase your can find
coroutine users of QIOChannel that do something similar to what you
described.

QIOChannel is lower level than chardev and I haven't had time to check if
chardevs are used by coroutines somewhere in the codebase, sorry.

>
Stefan

--000000000000ba593c06568c9b27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Jul 13, 2026, 12:38 Irtaza Hyder &lt;<a href=
=3D"mailto:irtaza.hyder@10xengineers.ai" rel=3D"noreferrer noreferrer" targ=
et=3D"_blank">irtaza.hyder@10xengineers.ai</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi there, I was =
reviewing the coroutine blogpost (<a href=3D"https://blog.vmsplice.net/2014=
/01/coroutines-in-qemu-basics.html" rel=3D"noreferrer noreferrer noreferrer=
" target=3D"_blank">https://blog.vmsplice.net/2014/01/coroutines-in-qemu-ba=
sics.html</a>) and had a few questions about the example given. It states i=
n the blog that it makes the code sequential, but aren&#39;t the co_* reque=
sts in `void coroutine_fn say_hello` seperate callbacks we need to implemen=
t, still leading to callback hell?<br></div></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">No, say_hello() is a single functio=
n. You read its code sequentially and there are no explicit callbacks, just=
 say_hello().=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><br>Moreover it is stated that coroutines have to be explici=
tly yielded or terminated. In the example we are using blocking functions (=
send and readline), so how are we defining explicit yielding in such functi=
ons?</div></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Any function that is declared with coroutine_fn may yield and must be=
 called from a coroutine.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">co_send() and co_receive() can yield but they do not block the current th=
read (e.g. by sitting in a blocking system call that is waiting for a singl=
e thing to happen at the expense of other coroutines being unable to run).<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"> For =
example let&#39;s say I am waiting on a data being to a Chardev Frontend, p=
erform some operation on it and then respond to the Frontend when I am able=
 to write, how would I write a qemu_coroutine to deal with this? Are corout=
ines even the right approach to use for such a flow?<br></div></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;m not able =
to respond in full right now, but have CCed Daniel Berrange, who worked on =
the QIOChannel APIs. If you search the codebase your can find coroutine use=
rs of QIOChannel that do something similar to what you described.=C2=A0</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">QIOChannel is lower level t=
han chardev and I haven&#39;t had time to check if chardevs are used by cor=
outines somewhere in the codebase, sorry.</div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"></div></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Stefan</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"></div>
</blockquote></div></div></div>

--000000000000ba593c06568c9b27--

