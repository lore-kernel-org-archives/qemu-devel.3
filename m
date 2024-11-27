Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E925BD609A0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAmK-0003rc-HA; Wed, 27 Nov 2024 00:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAmJ-0003rC-BG; Wed, 27 Nov 2024 00:39:55 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAmH-0002O8-QL; Wed, 27 Nov 2024 00:39:55 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d071f70b51so1574870a12.3; 
 Tue, 26 Nov 2024 21:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685992; x=1733290792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XXw+Yt1fukKiKcNXQZr+JHMytivTBC/jlST45XFrnBk=;
 b=MlQiNeRqBhowi3OhrwIpCH5DbxPoEca2CXNiyi0k9kYJEkY1xNbxpmeqY+trZbZ9Uq
 1woclhk6SyxzwrvXSUuQg/sipNzPlk7IA0k/6We/4ubYWE0XLrSxe+2x0ltQ9KdaUUAq
 9k1lJ02+YUwp7OVRhpwO6IEtb1VCpUf8cXysQ3n7oVuJjxn0j3aH8nKDuMwWegODfOa6
 97AsdeGCN2erR1FJOn/mcMt6NWXD1UazWEvb+Pht0CTRHS+F9X8cIpq4X81fMhDnqTVr
 nEN77PJ4dqTmMkNEQTsvo4KiuhM0+pVN/lcrnPCqNjLDlSWzUgAGbQtgDv3S5BJ7HSh2
 z4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685992; x=1733290792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXw+Yt1fukKiKcNXQZr+JHMytivTBC/jlST45XFrnBk=;
 b=hBuj9/rqwqIWCNFejZFIyqBFi05+oibXe0UttobzP7aOj9Xw6rrdf36J39gXV/NBnQ
 uRdjbR720wcFLUNkLO+Dkh5tRlYS8yF6F6ZITXICuTsD3xGg5RLi3cF11TmDF62UKySN
 c2To8AwjEfvkR5jFCCAImInKtuNUIIFdJJ22A6W2ffKcGHnv2aqQzI2r0mNGt+17+rxi
 WWq6YpfQ309AT6M7pZOKl/7bfNx0vdAkQTviEWbIquOx7vnwxr6d3VAGDlOx38vMnrYZ
 eQVh1L3ZgvwFhLVCen/A7Eh7iQLrzCrGFf3noAILeTWs3c6/VmRZ7xYTKYiM1lPkDpmo
 Qdbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrRhbVE9fh3/GdkTDfQSaCjCfD9YmV+QHJ76vwjEKjZ6OAMfHsRgzov4ny91YY4Mv8x2cq4tvieV3Zww==@nongnu.org,
 AJvYcCX9q9bNoAgUsuzXDGCBYGD8PAAY9KV5TtFHKhUYur1a3TR49f1IK85AEEoZKi+zMLfuRHBmvMrpwibn@nongnu.org
X-Gm-Message-State: AOJu0YwDtw9FOpyzJRc9F4Zvt0yS//Uu9Zc5mSHXgqPMH9bre//YBXCr
 M3fueNEwhtIG97r3FcGTpylLgMeax6L6ylncvt9RZut2maaetKFh7P9c3rzCs3vYvH4MHB2Wa1g
 78cQ5HeJus+mNnjAAASty1NY/8RI=
X-Gm-Gg: ASbGncs1AXcEPd8gYnbrd67ELod8P5MJfvwLtzWyATAVANIoY/8Fiv8GRIxe3KANkNx
 1DBUDHO5C/9xeTe2CJXkHNBKvYl/4hHk=
X-Google-Smtp-Source: AGHT+IFRrT+GeYM05jeW66nQJCVXmehVe2WZqh86XZlkLqZnAYv73NWMevXmuKyIJpjTFqIKzcuVk4r+S4G3lg4Te1A=
X-Received: by 2002:a05:6402:43c9:b0:5cf:e3eb:5153 with SMTP id
 4fb4d7f45d1cf-5d080bcbf86mr1295857a12.16.1732685991740; Tue, 26 Nov 2024
 21:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
 <20241121061259.4043177-2-baturo.alexey@gmail.com>
 <CAKmqyKObuwwp7AGrUgNWO9PdzBW0f8FFTrhFBVqij8ZOy+RQAg@mail.gmail.com>
In-Reply-To: <CAKmqyKObuwwp7AGrUgNWO9PdzBW0f8FFTrhFBVqij8ZOy+RQAg@mail.gmail.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Wed, 27 Nov 2024 08:39:40 +0300
Message-ID: <CAFukJ-CUUi7tC8srp3E3wtbP0LZBC5ytFgGzD+T2ywV2p0LTAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] target/riscv: Remove obsolete pointer masking
 extension code.
To: Alistair Francis <alistair23@gmail.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000b8b4e0627de657e"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x531.google.com
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

--0000000000000b8b4e0627de657e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

You're right.
Initially I thought it might be a good idea to do the whole process from
scratch, but as @Daniel Henrique Barboza <dbarboza@ventanamicro.com> sugges=
ted
I resubmitted the series with a proper version tag and added some
reviewed-by.
Sorry for the confusion.

Thanks

=D0=BF=D0=BD, 25 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 07:0=
1, Alistair Francis <alistair23@gmail.com>:

> On Thu, Nov 21, 2024 at 4:13=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
> >
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Zjpm extension is finally ratified. And it's much simplier compared to
> the experimental one.
> > The newer version doesn't allow to specify custom mask or base for
> pointer masking.
> > Instead it allows only certain options for masking top bits.
> >
> > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>
> Wasn't this and part of this series previously reviewed?
>
> Alistair
>

--0000000000000b8b4e0627de657e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alistair,<div><br></div><div>You&#39;re right.</div><di=
v>Initially I thought it might be a good idea to do the whole process from =
scratch, but as=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" hr=
ef=3D"mailto:dbarboza@ventanamicro.com" tabindex=3D"-1">@Daniel Henrique Ba=
rboza</a>=C2=A0suggested I resubmitted the series with a proper version tag=
 and added some reviewed-by.</div><div>Sorry for the confusion.</div><div><=
br></div><div>Thanks</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 25 =D0=BD=D0=
=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 07:01, Alistair Francis &lt;<a=
 href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt;:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Nov 21, 2024 at=
 4:13=E2=80=AFPM &lt;<a href=3D"mailto:baturo.alexey@gmail.com" target=3D"_=
blank">baturo.alexey@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Zjpm extension is finally ratified. And it&#39;s much simplier compare=
d to the experimental one.<br>
&gt; The newer version doesn&#39;t allow to specify custom mask or base for=
 pointer masking.<br>
&gt; Instead it allows only certain options for masking top bits.<br>
&gt;<br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail=
.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
<br>
Wasn&#39;t this and part of this series previously reviewed?<br>
<br>
Alistair<br>
</blockquote></div>

--0000000000000b8b4e0627de657e--

