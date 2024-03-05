Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F20C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaF6-0004uB-6V; Tue, 05 Mar 2024 14:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rhaF5-0004tT-10
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:14:23 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rhaEz-0002vo-VM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:14:22 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3bbbc6e51d0so4273753b6e.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709666056; x=1710270856; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5AmI5o6uN6wUjJHHxKQUVG+rfMUG8i0cxQVyFCVsnL0=;
 b=bC/iHztMAW2ar0zEPteXB5hMKnkGsjRtWJR+gmAez50hhzw/wGo2qm6JAyFuFnB2SD
 rMQtFt8KiZIaqLUuCnpHzJnjb9aJziOAtK1Fs8cwEoHc3Dw1dnGoh19w0L/fw+UNj19b
 ++nX00FwZ+UADnAny7VfjSdxw10tdDp8I8hgCUS0eyL3jaJC+sduP7AzULD3R4D8JX3H
 xFahFai+zTyGR0n8fTqFLyvuEAGXLIzsox8MBXIx7ptauEsJL/xKPtFUHOoBfiOFv0PF
 kdtll4XQ2WHmbgVB58/J5kb7z2dZvaJH/+PK5BlWhC5E+hCjl/ABKKFAQPKAhCOemIMT
 hTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709666056; x=1710270856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5AmI5o6uN6wUjJHHxKQUVG+rfMUG8i0cxQVyFCVsnL0=;
 b=d/YVBWnyzD0ab9kML/wr3NbvZqA0NLa7uWZR13waBA47VnbMie0RFs1eEjIJLkvOIz
 QkcngmcpdMByX2uqgan0dT1LmHQINhjbdcT+XKSLImzLzjAgYPUgNoYWX0UusDknPxGg
 bie37jHTF0C3nYthbtm14iaFe3XqwMxwXXBpQS65ie2rGNvien39xI46jxcA9+bNgrie
 qqijwtYrnneMgb8ryJFTEBwnqsP6SB8PhjYQbFpYi6dggwNrtXJ9VEt63goN2X0cGI8Z
 0JKz5lmVIUKRZ9Gpg/S3tg3BPb8/zq0o+O+BBHdfQXrBYWVFEQWZUcglYnfuHEjTXosd
 XQBQ==
X-Gm-Message-State: AOJu0YyttA5SorE/J4nY8KnCozFqj6z0UXS3i4QLtHNqIE4y5Ox0rkfU
 hMNVKtYG7b3gHpxRuY+ez2ipdIAXRBSD8duewyG4TZMkV4HrvW8lo81TU6wAXR1lseKdst9p4lH
 pc1KNQrDU9S7iBMfA42R3J5GQ2YY=
X-Google-Smtp-Source: AGHT+IGtK2+zNIhCpCkDbvjYeB0jbU72b3sYelW0sQp8TWs2ISfRrS6BwC7vvLR9Aux24cioZMjqPxPVGuV5/jhRwGo=
X-Received: by 2002:a05:6871:4399:b0:21e:bbdc:cc80 with SMTP id
 lv25-20020a056871439900b0021ebbdccc80mr3074199oab.8.1709666056288; Tue, 05
 Mar 2024 11:14:16 -0800 (PST)
MIME-Version: 1.0
References: <CAK4oD7BPCf5o-OR8WThb3QGJbrJnYpHipjKv-hY9rkWNOSAHjA@mail.gmail.com>
 <CAFEAcA8wQK_jfj+q-70TJ9Mnu+JHan_oNPYTDMMUmsBm7kMcOw@mail.gmail.com>
In-Reply-To: <CAFEAcA8wQK_jfj+q-70TJ9Mnu+JHan_oNPYTDMMUmsBm7kMcOw@mail.gmail.com>
From: RR NN <rnn59437@gmail.com>
Date: Tue, 5 Mar 2024 22:44:04 +0330
Message-ID: <CAK4oD7AJYesHPRY3ft3cXQkqW9RAvCZVcnLSC-rfFbnpUGykAQ@mail.gmail.com>
Subject: Re: ARM hypervisors
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f83fc30612eea511"
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=rnn59437@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f83fc30612eea511
Content-Type: text/plain; charset="UTF-8"

Awesome, thanks for the info!

On Tue, Mar 5, 2024, 17:29 Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 5 Mar 2024 at 13:40, RR NN <rnn59437@gmail.com> wrote:
> >
> > Hello
> > ARM hypervisors (pKVM, Gunyah) can run x86 OSs?
>
> No. A hypervisor uses the host CPU's virtualization extensions
> to allow the guest code to run directly on the host CPU. This
> is why they're fast. This also means that they only work when
> the guest CPU is the same architecture as the host CPU.
> So you can run an x86 OS on an x86 host CPU, or an Arm
> OS on an Arm host CPU using a hypervisor, but you can't run
> a guest of the "wrong" architecture.
>
> thanks
> -- PMM
>

--000000000000f83fc30612eea511
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Awesome, thanks for the info!=C2=A0</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 5, 2024,=
 17:29 Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.=
maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">O=
n Tue, 5 Mar 2024 at 13:40, RR NN &lt;<a href=3D"mailto:rnn59437@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">rnn59437@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello<br>
&gt; ARM hypervisors (pKVM, Gunyah) can run x86 OSs?<br>
<br>
No. A hypervisor uses the host CPU&#39;s virtualization extensions<br>
to allow the guest code to run directly on the host CPU. This<br>
is why they&#39;re fast. This also means that they only work when<br>
the guest CPU is the same architecture as the host CPU.<br>
So you can run an x86 OS on an x86 host CPU, or an Arm<br>
OS on an Arm host CPU using a hypervisor, but you can&#39;t run<br>
a guest of the &quot;wrong&quot; architecture.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000f83fc30612eea511--

