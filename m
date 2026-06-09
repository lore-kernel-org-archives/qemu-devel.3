Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0D2CD8C85
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWnGy-0005jq-2L; Mon, 08 Jun 2026 23:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wWnGv-0005j2-Mx
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:37:01 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <munkhuu0825@gmail.com>)
 id 1wWnGu-0006RB-57
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 23:37:01 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3967726bc47so46663871fa.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 20:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780976218; cv=none;
 d=google.com; s=arc-20240605;
 b=k8dvIlFD9sGIBcGcW4VGfmCzST26nSp+ih861oBvmJihEBoa2mxFcwWIbLjNXuXUEn
 y32KqPz/Vz0t5o8u8dMaog1kW45Ci4FrCBduMWDfbN4uDO+ZOy4VKzSsSDUelvPJL3V6
 QcxGxoWhwYYUMjIO4GWYDSKJysWEtSS+yNyi8kq2WZvEW+rgYpOQPMkWFGl/MgEuVeMb
 kb2aVJCifY9rZHfLGEzoxc8L+l/ASGqt8JNI3eWSQeeYgFOomGNDo9D4UmUKKTJ+44Nj
 TWjCnnqBmhpv+bjHYiNULXA1yseIzk5Qq/QiJLREU9vjRqylwEaR6bbEFbEpK/odDnrE
 MKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WK0BvBXoStLhfb4C1Ft0P8LCSGHMaSDHNsCfMGSDoRw=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=P4skth45nXbH5eqE2JI+Zg/pjQ9j3EKXIZp8i3+uZVuTyijsvDkpDmyNKI+OGuVYD8
 rPvYMt9BvPRbO6sDeRaYsUTFzqYkfCrf9HUxlAnOONy6gVWmMTj3+UrWezJWzVAu1uG7
 uptWHS7DeWM5gmPkdiWuxsd/W7KIfHpcIoLL6mFJvTR4ukJ5PpdowIDbTE/oK/C2sOQz
 IcJNrtiG8bC5EUibwEk8egP5Cwop/wmVGMjhBXqjFVRWrw5c/4KAHrLzdSafwSoF7BGD
 gaEAeGgvuDyrFwPgHuz/oV/bN35d7GSfj37lh2t4ixWJvgHR6MtJhmHpe4WCLM8r6Wd8
 vCbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780976218; x=1781581018; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WK0BvBXoStLhfb4C1Ft0P8LCSGHMaSDHNsCfMGSDoRw=;
 b=TRtfgsufS6M35q8+U4HvvofltCzs+Iz4dKSeVgX2XrPYxZnGuhF9GYg3Zg/bYTPsYl
 Fdul/2GAJ5UfvPaF2GzSTEdjkwQq9I1mn7cjTiz34lprNpouLIgQ/tsyhCiPBngu6Awd
 hnw7PlhkOhU0+mqNnTIGH16TuCyIc0mHUQy9hQmsJBCKULkGs3dmxdp4IWXaGg8h+2qB
 1QycVyMNV8+G130dCSQmDLHQxm0TqLGwCBxLtQctZRjdM2O1PHQwafGIyT5nIHlYewAh
 pVMAfwrh+LE+qj3A5CpCFFt8l74HmHoiH9fKGqRd+NBDUJmXqwuX1pgrg+IGFPX3oE9L
 2pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780976218; x=1781581018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WK0BvBXoStLhfb4C1Ft0P8LCSGHMaSDHNsCfMGSDoRw=;
 b=UeuYHW7noNojeivgQxyMU8FtJ4BNDQUBoKJsSr8CtMJu+Jb9fJk3/Oi6Be1tvSurrw
 fNyR6DN2oy7YyHlnpklyb5/AS8JQwZemnKALFoZn2N3hEMo/i3B+3Vb6YXvXpDn2VmMq
 qWBJsrshUGpgtJ8K8L+ufJZArgiJLdLnkQ1TWSsnixGTVuPmm2kWlrQjUnXS3fthk5sH
 2dOHhiVjUa7J+pPSzYGuokKX38wQez7tu8GFIpNt6bMBrcfJWtixqI1j69/8rKeQJCmT
 dKCrVqzTr2q9b2+wnqAV7rqpLLtbz3c6prP3YOJAgh27bTQOTs1UsE/fVpMRIrmlY1XV
 YMrQ==
X-Gm-Message-State: AOJu0YxNlcKVzTe3EbgoliOGA7sGQadbUmA6COhcvad+aK+pfwfjn9qY
 7JVZrU4sBarz15pc28jL7xQnk/BtDpEQYsoITGnFfoyroCL+Bil93topC8CpUPz3zYmD57Vb9ma
 //9sWcswXurO7IInxsWbkr/d8iuc4uUc=
X-Gm-Gg: Acq92OEcxSfG3vtxBaHp3etE1oW75punPOZWng+kn2EEKKnj7O0vWfnIHcy4Dsz8uW9
 sMqBiC81vaUqR+CUWdN/jiQFy70fGvZ8Gan9sKBY3E/NWwGxJGz/y5AAwYJelcNQGn59Z4oEU88
 4c8Z9DZ+Jak3H7RerEF4u4jQWHf8OLxX9yp3jcjcYPqBBUew++5r+0bwxc+5pYQH+LTuLEXdhmD
 RkpXwsiyq6PTPeFB2IkFp3jkvmJF/ckIkhsjcuN+QWMjViBaTlBpxiZkHqlJkG68IMPWEML0xzX
 VszAzQaRbX0Vi1W4+okfSuACURwReg==
X-Received: by 2002:a2e:b8c2:0:b0:396:9966:50cd with SMTP id
 38308e7fff4ca-396d0925d42mr55907121fa.8.1780976217324; Mon, 08 Jun 2026
 20:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
 <20260506152247.82336-1-munkhuu0825@gmail.com>
 <CAFEAcA9v+AShcRTr34C-oDNuWH42W0zxS6mzkW_WO65_xCfgvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9v+AShcRTr34C-oDNuWH42W0zxS6mzkW_WO65_xCfgvQ@mail.gmail.com>
From: Munkhbaatar Enkhbaabar <munkhuu0825@gmail.com>
Date: Tue, 9 Jun 2026 11:36:46 +0800
X-Gm-Features: AVVi8CdvHb5SGGwfBuBHCfJgIILylgmKYHhSkT_4Jn2WGR4tBhfPcHFdEM9ahDI
Message-ID: <CA+0p-Wzp0WFdaZpbL_E48F7zsQ1HsH+WG8ME1JUXyZETwnAU7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/usb/hcd-ohci: Fix ISO TD USBPacket handling
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c981ae0653c9d64b"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=munkhuu0825@gmail.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000c981ae0653c9d64b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi PMM,

Thank you for applying patches.

BR,
Munkhbaatar


On Mon, Jun 8, 2026 at 7:30=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Wed, 6 May 2026 at 16:23, Munkhbaatar Enkhbaatar
> <munkhuu0825@gmail.com> wrote:
> >
> > This series updates OHCI ISO TD USBPacket handling.
> >
> > Changes since v1:
> > - Split the original patch into two patches.
> > - Replace the USB_RET_ASYNC handling with an assertion.
> > - Keep usb_packet_cleanup() only on the synchronous completion path.
> >
> > Munkhbaatar Enkhbaatar (2):
> >   hw/usb/hcd-ohci: Assert isochronous TDs are never deferred
> >   hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
>
> Since nobody else has picked these up and the main user of
> OHCI USB is arm boards, I've applied these to target-arm.next.
>
> thanks
> -- PMM
>

--000000000000c981ae0653c9d64b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi PMM,<div><br></div><div>Thank you for applying patches.=
</div><div><br></div><div>BR,</div><div>Munkhbaatar<br><div><span style=3D"=
color:rgb(0,0,0);font-size:medium"><br></span></div></div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Mon, Jun 8, 2026 at 7:30=E2=80=AFPM Peter Maydell &lt;<a href=3D"ma=
ilto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 6 May 2026 a=
t 16:23, Munkhbaatar Enkhbaatar<br>
&lt;<a href=3D"mailto:munkhuu0825@gmail.com" target=3D"_blank">munkhuu0825@=
gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This series updates OHCI ISO TD USBPacket handling.<br>
&gt;<br>
&gt; Changes since v1:<br>
&gt; - Split the original patch into two patches.<br>
&gt; - Replace the USB_RET_ASYNC handling with an assertion.<br>
&gt; - Keep usb_packet_cleanup() only on the synchronous completion path.<b=
r>
&gt;<br>
&gt; Munkhbaatar Enkhbaatar (2):<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ohci: Assert isochronous TDs are never deferred=
<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD =
packet<br>
<br>
Since nobody else has picked these up and the main user of<br>
OHCI USB is arm boards, I&#39;ve applied these to target-arm.next.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000c981ae0653c9d64b--

