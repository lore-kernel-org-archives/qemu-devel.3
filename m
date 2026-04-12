Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD012E937E4
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBvo6-0007ow-C5; Sun, 12 Apr 2026 10:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wBvo2-0007oZ-DK
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:28:58 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wBvo0-0003Pq-IS
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:28:58 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66e6d960ff5so4913897a12.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 07:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776004133; cv=none;
 d=google.com; s=arc-20240605;
 b=keuQ1rmh/wWLKcRbEwbGlJLhHRIgB0rNP5i4BhAQf6mOjbcC/ssz/EYYnolf5TCTnD
 AedsdX7ucFzob9u7AMy5KXzaIi8Nnzp2wINERJhsTpKagn3R3qnYS0MDSBalb6JUprVA
 BzvxcC9iQcn5Uk4sGeMXMdyAhXwlYLPsKLtLlnSgzCloFSlmAB/k24DlVt5UMOHIw6x8
 drBCUVg6VWXNl9ha03lXyPw3XYDWyhS205sC2XKy25fccoSi007XXeRpwbHfK9b1ny1E
 f4adXpO20snP7OYK9sY1S1Y0AuLDGkl8bYlCeRiZ/ORxgWqxkDAGjanmMxqZr3kAw8Y4
 oouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LtmHrTDKJKxH6Mg8m+Cy/eWeyiTIDZxsFndhl6ldrIg=;
 fh=sw/7RVPyOSLjyOG17SxTuf/m7iIXEQ/KHyJ8Hz07+Rw=;
 b=Ofyod0PYbpsH3JMvQhvf6TFE34rGo1lMICU1ohIGTW/4qK4cR/yq0E/LLWAqhbndui
 krbchKswVVn1HAeyzc+mIk+diWNdko2DatuQZNgOykJkBfL1LxbHHaSA9xWKn+vvzSt0
 hXuw385TiOwG4oRhzxy0h5FRcwmWNoKZd7zYSqmayw98WKJ5dga47huOGKn+ZelW65xS
 VUYW4SP6TFk2XF93qDoR0WpHCyO/AQ0DoEdD8FyTiPslkxs5fUKO6GG6lEQTV0rFD0qO
 cdtfJHjxUzitxPhuwzJVtj3NCZQ7A6te98oBj4LZNSDdkimvmqE/YfE54aofm8autMb6
 ebLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776004133; x=1776608933; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LtmHrTDKJKxH6Mg8m+Cy/eWeyiTIDZxsFndhl6ldrIg=;
 b=J32cg12rLDVMfinHZDzXZeojIfEccn/GPlIl03n+L6KBey4Ls8oMwEAqvUtXfMaGwm
 IIrmZIsMociV8qnFbX/2YHGRPGCRC3wmxQz2XUzK2ihn0vC7wS7noZGlXJ2CTJBkPJVu
 FazoWQ1ShPPAonisyEjhOJzPuWYoOv0x//EPvt7UdJFYWyjyQ1+3fD+ja8UYahem5WQs
 SM8j7JdcpPjHiBzFheKY6sdwbhxkiO3KiPzR61Q3piZamoVHsyOP2nM51piH5/PcvafR
 +Ap6VRErxd4NvRrsv02aUybU4yoDBul6l7qpeCVFlXWnA1ugJPixHtMd+7xoY6TZOadI
 yqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776004133; x=1776608933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtmHrTDKJKxH6Mg8m+Cy/eWeyiTIDZxsFndhl6ldrIg=;
 b=VW2djm/Dzk3ENLjroUaNqDsAWuIeIFHmlcM9qw+dpHWQ5wVMYKrgJuXUFmx5UJ7hD5
 /1H93DUx+YsiHWafqLptM+L0JetLil4OW/AihD2VOBsAKfw3dBxUWBTnt5LcZKKVocRX
 XeR+AgJf5ucm7ANGppDorrhz2ekt36UptSZBI+MUfnzmZEs+3W9z4g56YYNaIcZT1xO3
 Zz8KI6DbAdY0R8/9Kyw5NMZQdPFVn/w9f6w+kWf143HaD6p5vsYph6ED0iIN3QSHnZWb
 JZ89RIWdpnotB44psRJQo1/5Dkqn0LUaMQLzoBsFKgUSnwqYAPCAM1renUXu6/KQEq4l
 qJlA==
X-Gm-Message-State: AOJu0YzVesREtCBNMDntIoavB/HvXZYGhTNnFEY9Vkqja8P5DbIWa+M3
 iUauNR1i+of//IlocaxGzKbiaHakhYEWdavHWxtGzK0hGp2kyj7wSF/I2i6uRIwbFWkwJ5JGHrB
 K05ugQaPTDENLeYCdxYC3w+aRT6kGJ18=
X-Gm-Gg: AeBDievLyTulqVrkJ2J2TTGnmtKRqVsfiv9ZtQ7vipLAU5+/JLT6PDHvdeHWKJhGGI0
 hbIG8D+xWwC894DPqXGhXUeNMgZkFAJSFDXpVriWpvNUePaWUFW/NK9JWHR6Mo0Sr+q+RenLskU
 riPfuChKo2mI+K0IlX5pevQVIGcsVxmY6EjUe9SPuXcWFO0/nFWGA7XvPjy1NHv1dLUDvRVrI0w
 +3i+m+YNn44s7sahDyjUROX+lPFTWEEayp9NmJk2omCB6uMc0ge5MHPQxnrXdB615UHQAYU4wKK
 rx4qjWFyWfo3/m67BgG49nJyUcULw1xruJQao8wqfkC+Cs+O
X-Received: by 2002:a05:6402:370a:b0:670:b6f0:8894 with SMTP id
 4fb4d7f45d1cf-670b6f08b05mr3390473a12.20.1776004133182; Sun, 12 Apr 2026
 07:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
In-Reply-To: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 12 Apr 2026 10:28:41 -0400
X-Gm-Features: AQROBzBM7ZFL5CG1RsyiX54ge10xMDfDjUywWABi0-ruoS5K6txrcfH7SEHY32A
Message-ID: <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
Subject: Re: Cirrus CI about to shut down
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007a6806064f442fd7"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
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

--0000000000007a6806064f442fd7
Content-Type: text/plain; charset="UTF-8"

On Sun, Apr 12, 2026, 08:45 Thomas Huth <thuth@redhat.com> wrote:

>
>   Hi,
>
> according to https://cirruslabs.org/ :
>
>   Cirrus CI will shut down effective Monday, June 1, 2026.
>
> I guess that means we have to find an alternative for doing the builds on
> macOS and FreeBSD?
>

It may be possible to use QEMU's AWS hosting where we already run Linux
x86-64 private runners. EC2 can run FreeBSD and Mac instances.

Sponsorship is on an annual basis though and it would be a shame to redo
the setup work once AWS sponsorship ends.

If we decide to use AWS then I can help provide access.

Stefan

>

--0000000000007a6806064f442fd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Apr 12, 2026, 08:45 Thom=
as Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
=C2=A0 Hi,<br>
<br>
according to <a href=3D"https://cirruslabs.org/" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://cirruslabs.org/</a> :<br>
<br>
=C2=A0 Cirrus CI will shut down effective Monday, June 1, 2026.<br>
<br>
I guess that means we have to find an alternative for doing the builds on <=
br>
macOS and FreeBSD?<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">It may be possible to use QEMU&#39;s AWS hosting where we=
 already run Linux x86-64 private runners. EC2 can run FreeBSD and Mac inst=
ances.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Sponsorship is on=
 an annual basis though and it would be a shame to redo the setup work once=
 AWS sponsorship ends.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I=
f we decide to use AWS then I can help provide access.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Stefan</div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
</blockquote></div></div></div>

--0000000000007a6806064f442fd7--

