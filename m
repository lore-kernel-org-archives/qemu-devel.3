Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D518C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 17:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRxCG-0001P0-O5; Thu, 11 Jul 2024 13:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sRxCD-0001OQ-St
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 13:03:06 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sRxC7-0005Xp-LN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 13:03:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab63so1927266a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720717378; x=1721322178; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wETisyh9GyMnQN2K84a+9d56iko12Lbicq2jC+Tk7iE=;
 b=K/blYv0BQrIiZCjU3ZVbVG7MJkJ8ZVM2sIQ2SsqtNE93B2RlI5hz+Dqf5t8CsmCxb6
 ZKyp+pSL0GQRmYYnhFMNmh6I3t8iIrOgsqaOuOKvguMBX4WkPKy+x5KeP7Qa8A6UzC4F
 /n00QTu/qX8/jiP+QLuI11ibcXGDx1uIXwQm/sxwes/lXaJSgtt0JlRu1rqD/CnOTMgV
 5nINdR8Z2JEpwg8ZskTx4rlI+2u4XS17cypF8nlAguHBEeupkAac8L4WCCvCIhpYBzBE
 9epS7n+YXCX945dttBkbv/9qVevn+Y8C1a6Jr78T29OOxiP2RWI+gGNVT2tUBvazfaG/
 h+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720717378; x=1721322178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wETisyh9GyMnQN2K84a+9d56iko12Lbicq2jC+Tk7iE=;
 b=NlPnWxgWnTVrNxhQCTf0bAl8Ne/UbZZK7oSAMnzXGshpftREvgMdZr/ycJJNiI2AAk
 Y3po55JuERwWhzU4Wd08Vz0IfT/L0kYaKbVkys/b5hdRYSgt9qIPSSfTLkNeRmC5AhXt
 ny7R3HMrbciKJEiknpfvNIHVDoGo0pHmeK1Iu9yDmUDvbpsofMLl7rnM5rtWlDQMiYPX
 79oSNaUN2R++XQpEQBDPWV4xjoepM5UbXbAQ4+RGKUmmlXvKqBm2SJfmwu3/sMHUcPmR
 B99QgqKnSPCHqQZ2Q/6uhHVlrQJdgzza1xvmtabEzSeTjYEbI+RGtYLV531T4fPVYNAr
 b8rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHkzxZDqrhXQPK6KVkrUP8RXz0mrNXe+cg4OKWe3mHs5lAZgsU3aZqUqa+9C3Bor0pDaCWGTGZ6U8RLFI/KNHCErEtjGY=
X-Gm-Message-State: AOJu0YwJeAKTSIcXZN8vIMZGHUc8e5P9D4eB/IKRDG93QJt3ruZvOtPw
 1/a1/gYPPNf9koXVKZYr31NXvD0Bcw4myxTojPkPk77C16qJwGGH9x4cZURhb8UJitazk4thher
 joayvefLr0xcasmF5zspOq8phezI=
X-Google-Smtp-Source: AGHT+IEsukcI36T6elG/LvNqbD0c2N7wco6+EuItCMh7tL6k4STu3i+3KSa+3NPKbB3XsuChEvHmNkQm3mWBLU5kihc=
X-Received: by 2002:a05:6402:2787:b0:58b:fd23:7065 with SMTP id
 4fb4d7f45d1cf-594ba0cbe1amr6543946a12.16.1720717377450; Thu, 11 Jul 2024
 10:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
 <87frsgqly9.fsf@draig.linaro.org>
In-Reply-To: <87frsgqly9.fsf@draig.linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 11 Jul 2024 19:02:45 +0200
Message-ID: <CAJy5ezrjciMzCbKGz64ofynTJwNxCousRLSgVT-g1Jbn7fYqyg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Edgar as Xen maintainer
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 stefanha@redhat.com
Content-Type: multipart/alternative; boundary="0000000000000ab810061cfbbc4c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52d.google.com
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

--0000000000000ab810061cfbbc4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 12:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:

> Stefano Stabellini <sstabellini@kernel.org> writes:
>
> > Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
> > maintainer for years, and has already made key changes to one of the
> > most difficult areas of the Xen subsystem (the mapcache).
> >
> > Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
> > are very happy to welcome him to the team. His knowledge and expertise
> > with QEMU internals will be of great help.
> >
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
Thanks all!

I'll put this together with the reviewed mapcache fixes into a pull-request=
!

Best regards,
Edgar

--0000000000000ab810061cfbbc4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jul 11, 2024 at 12:09=E2=80=AFPM =
Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@=
linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Stefano Stabellini &lt;<a href=3D"mail=
to:sstabellini@kernel.org" target=3D"_blank">sstabellini@kernel.org</a>&gt;=
 writes:<br>
<br>
&gt; Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU<b=
r>
&gt; maintainer for years, and has already made key changes to one of the<b=
r>
&gt; most difficult areas of the Xen subsystem (the mapcache).<br>
&gt;<br>
&gt; Edgar volunteered helping us maintain the Xen subsystem in QEMU and we=
<br>
&gt; are very happy to welcome him to the team. His knowledge and expertise=
<br>
&gt; with QEMU internals will be of great help.<br>
&gt;<br>
&gt; Signed-off-by: Stefano Stabellini &lt;<a href=3D"mailto:stefano.stabel=
lini@amd.com" target=3D"_blank">stefano.stabellini@amd.com</a>&gt;<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br><br></blockquote><div>=
<br></div><div>Thanks all!</div><div><br></div><div>I&#39;ll put this toget=
her with the reviewed mapcache fixes into a pull-request!</div><div><br></d=
iv><div>Best regards,</div><div>Edgar=C2=A0</div></div></div>

--0000000000000ab810061cfbbc4c--

