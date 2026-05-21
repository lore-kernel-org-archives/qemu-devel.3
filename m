Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C05CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPybW-0008M2-NI; Thu, 21 May 2026 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1wPybT-0008LD-WC
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:18:04 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1wPybS-0003zd-9L
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:18:03 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-63130466364so2071540137.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779351480; cv=none;
 d=google.com; s=arc-20240605;
 b=KLhuyScHezV+KOBmaonattobZQtJlxHEIUwiLWNixKc3JKvOW0d4ivQSZgXqqadEJU
 raAZsqjtJyBVw39qpuxxuqSvk2Gz/ZW0tED/N485k4Rdy+ze1FB0bYAb7PR5sl6W3mfE
 ncWHWYv+FDyLgLIaWBU+FXMvfwEc9MoKYJ0DKs/JsINewPiXcQ3WCqIqgu/9gfh9OKlN
 +8AOePCMpwA8Egq/fDBmrThVA70UzajKsMQkYnd6UGrQ+y3S+8sqi7s7/rT19jjB0ccY
 BQdk+pG1KRihGOstNRlBZg4h7bzXVddNhyoJh5OKKIOqUM7wwdp8Q2KZHrAspltMwFz8
 hP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vlnFXihsL2D2Wm5n6pcPDICunW+TjdXiheuaZnu+sGA=;
 fh=XWqz1pRCv12npratrwTRUC3CBDlPmqS6jXd8Cf1O3YU=;
 b=klzzRVIt20RLgjKZM47+qbapgvqk5wl+wVBx8JQ7qT+vYIYLIgrUYfAfsoIc0Ourgq
 5b2/XAcFX4nrOtEXbmVCBRNjv7f6NLhS6IJfNpKZ5Q2jOipl1EWpjfDjI3/ow9VDfCSU
 baXdtt6J5x9PW2/bcjU79ipO8awCJtbzsZuGdfffxTcke2QXWy4bwt+U6Dw009oB5YaB
 8ZIwjYzfKUMLPp54Ua5moYTlHYFk7kZd6e/+RnJ2X9Wi66ChlnyjgbjM13dRFSUfhVdr
 ilUIjIlW3KslEs8YwHD//FytdDwXC+p0zWE8uTxLmoR9MFMhOC6hXOlEKUABIN3f4yN0
 enXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scylladb.com; s=google; t=1779351480; x=1779956280; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vlnFXihsL2D2Wm5n6pcPDICunW+TjdXiheuaZnu+sGA=;
 b=aMEpg+TQQMcuY0essM3zBHm8rugeiuDtnhBWzB+v7CRhKbsaEUDD4c0hUA3wOKP66I
 HuIMPcGT1WbvqHOmt+6EG2PGPjJFHPNCAtt2Y6uEuBVbEPd/v7okW/EoObSvolfRGz4b
 qdbcaSyoTir2TNl4+WRX9qqsFQcwXQZhKzhUKDNIA46CjsAreb/729lHORDeOYSsHRdI
 zW+4d4XjYj/KTQvwgc07bJRsG0lA3F7X6XdFsn1UBqVhsxG1xu5UfugP6bvFjzs7V3tY
 uiRU6RsH38adEsl3B88fseBSfhEKtTFxseqByM1xhIwGjIYU1Zzq7AAZ9xYJ82he14vb
 eksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351480; x=1779956280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlnFXihsL2D2Wm5n6pcPDICunW+TjdXiheuaZnu+sGA=;
 b=DqmqXx46vVE8iqkAWO5X/UB38WdEhr9cj6IlJcyVzfjOTmku2fRIZEGFI/7A1qdWue
 etWoW0XuGzDPx+kDaVRDxI1P7vL0XJYyixqvKbx7RglrXBAgiOUWxiRynw4GmyIKUbmv
 +cJQ8b3t2tkTi0U7Z8x5RjRE8CaNKBAX1BRcLFJIIeCUynCuCNhrLim1TF4qzTM17mhE
 vYml6b9bM8OEq1F49afRb1CssfKgAubtPUARetsi6ge3y0wSet26eFhhuPKUFQrPyiJ/
 SyOJmwUc0c6fQ9aDGJuntMqTt2gSrIB3W9sgKdN0Ji1p/hcCN8tpuXnY/0/8obIE9noZ
 0/zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UJxP+I+EX6zcLlZEpo60tMmlizCOk3FtWYeoo2JTPV8VECKt21UWEKiD7QtT9EiXQ4E1CZUoWFBAI@nongnu.org
X-Gm-Message-State: AOJu0YwPhUbzNqPF9gQiwkJvRmnsuVTBz3qWD8olgHVMkqJJmTD65h7q
 60HRoXULpMCPvKLUpE8M1wMiilj4Qy4y8FEb8PFcf8FETZ9xr5tJyEYuh1JGAOfWI8OYfLKruBU
 8D5sbF3S32zjf+5mXXHG7tXFiptFDwGo5K9G7SeeWCWY4PLs8t94nSHFQNf503b11ZfpSng3HC/
 f9BsMjatEthr4k/aplE0Cu7Cqg/QszkktDqEjM1YFe2+eCmPAvyfwdLaTdSE9HQMrlMbTSUNLpx
 n8DE3vfZvyi2qQhomofhttsk7MiILLmfp33juj80N7Z8ynYSU6KjvMV7/lC8oFg6rSaCcERYAjK
 uSkkfpELzsWYNGbPKDJapzFre5hB3ajxmW2pRZojCVDp+4MCe3FPqn7HLDytEa+0TxpGpGWK
X-Gm-Gg: Acq92OGXA1uUiErlr4oh1nntIxMxcc8o7aT/aoqmBMK5YNPrLjm83uJHdygTjHKs/2B
 myUauEFaihiansibYjtLePWZpT6TwskfdAl8q7mf8zscU8Zt+dUJCAUZLhauQWvqrxPykPOd4o+
 6rZTUZFxW5TC5/lrXMnzmhNqo3PXamXgOcpyXstgxXkkwiw93GFUzhVTa/71vRA0h0+BLzV3gbJ
 4NgTpwaV3dzr/V5atVZR8vLW9WAV57MNro7SGAzDXWRkD5c0e85zGEUSMOFDIXuov+e+d8Hbqq9
 4XOCkvc=
X-Received: by 2002:a05:6102:3fac:b0:639:3b08:d64c with SMTP id
 ada2fe7eead31-67391caef55mr933113137.13.1779351480505; Thu, 21 May 2026
 01:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260306165717.3360110-1-berrange@redhat.com>
 <ad0pQDzYIki56wUe@AALNPWKJENSEN.aal.scsc.local>
 <CAF950WJM4=n=L-cSEgTFWTkOFDJCD9+aWSVwxm3oaN5+rvR7+g@mail.gmail.com>
In-Reply-To: <CAF950WJM4=n=L-cSEgTFWTkOFDJCD9+aWSVwxm3oaN5+rvR7+g@mail.gmail.com>
From: Avi Kivity <avi@scylladb.com>
Date: Thu, 21 May 2026 11:17:49 +0300
X-Gm-Features: AVHnY4Ig9vxXF2lol6K3Oi_GEljnArYTjKd5WfowZ4k9lCQEbj6IhNz640jHwJ0
Message-ID: <CAF950W+xw+Zk-MT2-n0EN+sTwGTQUpWj_Q3F-SurUw-Nky=D1w@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/nvme: make model & firmware version cnofigurable
To: Klaus Jensen <its@irrelevant.dk>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ed2b8206524f8c0b"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=avi@scylladb.com; helo=mail-vs1-xe34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000ed2b8206524f8c0b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:44=E2=80=AFPM Avi Kivity <avi@scylladb.com> wrote=
:

> On Mon, Apr 13, 2026 at 8:34=E2=80=AFPM Klaus Jensen <its@irrelevant.dk> =
wrote:
>
>> On Mar  6 16:57, Daniel P. Berrang=C3=A9 wrote:
>> > These are both currently set to QEMU specific hardcoded defaults,
>> > and in common with other block devices, should allow user overrides.
>> >
>> > The pre-existing serial field should also be length checked to
>> > detect & report invalid user input instead of silently truncating.
>> >
>> > Daniel P. Berrang=C3=A9 (4):
>> >   include/block: define constants for NVME string fields
>> >   hw/nvme: report error for oversized 'serial' parameter
>> >   hw/nvme: add user controlled 'model' property
>> >   hw/nvme: add user controlled 'firmware-version' property
>> >
>> >  docs/system/devices/nvme.rst | 10 ++++++++++
>> >  hw/nvme/ctrl.c               | 31 ++++++++++++++++++++++++++++---
>> >  hw/nvme/nvme.h               |  2 ++
>> >  include/block/nvme.h         | 10 +++++++---
>> >  4 files changed, 47 insertions(+), 6 deletions(-)
>> >
>> > --
>> > 2.53.0
>> >
>> >
>>
>> Given the reference to prior art on introducing error checking in these
>> cases, this LGTM.
>>
>> Applied to nvme.for-11.1. Thanks!
>>
>
> I don't see it in master. What's the schedule for upstreaming it?
>


I see it's upstream. Thanks, silent maintainers! Looking forward to 11.1.

--000000000000ed2b8206524f8c0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 18,=
 2026 at 2:44=E2=80=AFPM Avi Kivity &lt;<a href=3D"mailto:avi@scylladb.com"=
>avi@scylladb.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">On Mon, Apr 13, 2026 at =
8:34=E2=80=AFPM Klaus Jensen &lt;<a href=3D"mailto:its@irrelevant.dk" targe=
t=3D"_blank">its@irrelevant.dk</a>&gt; wrote:</div><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Mar=C2=A0 6 16:57, =
Daniel P. Berrang=C3=A9 wrote:<br>
&gt; These are both currently set to QEMU specific hardcoded defaults,<br>
&gt; and in common with other block devices, should allow user overrides.<b=
r>
&gt; <br>
&gt; The pre-existing serial field should also be length checked to<br>
&gt; detect &amp; report invalid user input instead of silently truncating.=
<br>
&gt; <br>
&gt; Daniel P. Berrang=C3=A9 (4):<br>
&gt;=C2=A0 =C2=A0include/block: define constants for NVME string fields<br>
&gt;=C2=A0 =C2=A0hw/nvme: report error for oversized &#39;serial&#39; param=
eter<br>
&gt;=C2=A0 =C2=A0hw/nvme: add user controlled &#39;model&#39; property<br>
&gt;=C2=A0 =C2=A0hw/nvme: add user controlled &#39;firmware-version&#39; pr=
operty<br>
&gt; <br>
&gt;=C2=A0 docs/system/devices/nvme.rst | 10 ++++++++++<br>
&gt;=C2=A0 hw/nvme/ctrl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 31 ++++++++++++++++++++++++++++---<br>
&gt;=C2=A0 hw/nvme/nvme.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 include/block/nvme.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++++=
++---<br>
&gt;=C2=A0 4 files changed, 47 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.53.0<br>
&gt; <br>
&gt; <br>
<br>
Given the reference to prior art on introducing error checking in these<br>
cases, this LGTM.<br>
<br>
Applied to nvme.for-11.1. Thanks!<br></blockquote><div><br></div><div>I don=
&#39;t see it in master. What&#39;s the schedule for upstreaming it?=C2=A0<=
/div></div></div></blockquote><div><br></div><div><br></div><div>I see it&#=
39;s upstream. Thanks, silent maintainers! Looking forward to 11.1.=C2=A0</=
div></div></div>

--000000000000ed2b8206524f8c0b--

