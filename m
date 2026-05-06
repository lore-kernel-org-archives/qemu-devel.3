Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF940CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZco-0001Zj-8u; Wed, 06 May 2026 06:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKZcl-0001ZO-Jw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:37:03 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKZcj-00032S-JJ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:37:03 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651c366f7efso6056290d50.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 03:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778063819; cv=none;
 d=google.com; s=arc-20240605;
 b=TIgX6nIQ2iraNsuiCjyb/8jHbhdGjlpLdrktx0XSx2qLXHTSxZ+/9MM0DfejEjuBjD
 kw2um3a1vpz2DxJ5blvJVXQMQArVzL5tXsOJo40zOQNUIvqkO301KBUjzpxTG3qyUz3t
 1XtHSSUxUbt5hm8oTk5Sxx7X8D3yPjrxajCzQzMJt7vMKeP5qPEeGyvqSlhA7HZ1m0VT
 5DuenHPXpXhitMlqdjwvmKxt5yb5CxfexwPR/Y3teY5XhZVL50CEaPJj/2rmTCvY4mYP
 n9nXEnvxruZ4WXqzg27EPWC9+eraHF8XHHokAiSKtcPkvDm4McY2o/Fx91S8TCFzczrH
 vlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uehqBscnlsAYcfmKVzu327/V0Gnd2AQf4u/ItpyzPrU=;
 fh=1Lgk9xC87vuwEzuciB1UFM1d+YDIGjF89BF/5ZfQYzg=;
 b=BQMp3sM32iuDlR7m7YJBn+l/oTm1YsWo+xcj7KGBj+2+pMNdXgPPQJobA87uj+e4wx
 tlsEMqPIBm7+MzG2SNec8TsGDa/DksQzFWLajq9lljZVSh0WQLSk2Azryx9YGNtvXL96
 kEns2t0x4U0hFKLiq9xMo1KeVIoJz565nRds8IeS7Br+w11+fvqLAGcX2z096M2DPD6Q
 0CYMZ8OpRTOnJ3FB1oUN4LotV24Q9110XTmngkdhUDTeh9v8+SHwT/rquv1mZmICIjZj
 zk8adk0B+YKmymBj7pPMiiAqN54oiHIReQ0+yAC6eFUSO0nLxqeou4IPOgxGLAYPrQ0G
 Ta+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778063819; x=1778668619; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uehqBscnlsAYcfmKVzu327/V0Gnd2AQf4u/ItpyzPrU=;
 b=QtiXdeYYoYh1ZKg6S/as+dDRdgSfZ3QgwfyvxsMghC/xec+ekCwsStPilMYXoO0nuv
 15uyOC+V7g82VP9cumUVs2FZEYWRXAL7NFEPlP2mUo1Ka4qf8N5Fi0cqU7/Fc5TE8h4P
 evRSQaqbFwpP6Nl54R0q3vUzlRObjv+Gof4rfFWLsQDC7FFV/roqrbz3dua+tkUvqGjA
 ivWNlQ5Atg9JuZ2S5DWdXWgMcGtjx/TMjRWzGC4ozmx722nQFTN+89/ef+MyuovSjCUG
 m6FfMYE64z02+GBXaXj8rl27ROpro6uyd7FwQJwnWi/PzOlge4iEejHU/nwNtMuAbPrl
 Po5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778063819; x=1778668619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uehqBscnlsAYcfmKVzu327/V0Gnd2AQf4u/ItpyzPrU=;
 b=H/WxSixxAYz097TD2jksKmTQ+wU+kQpA5oc3JHODJ+Pkdd+rt3Ayeon2UH1Q/JDlPi
 6Nq+PoFDjBlNOXQFKTnp3lqM1Dw/HD8Ss3gl3EEJ1GBKCWrHoMaQuwnh5zwcKN0AWMtV
 3tEkV5GUGyp6sFQ/XyCAdXUj7d0KovGUyKC+etqbgUnYqwKczwBvAaNgwEwne6Lz2Hpi
 ruHKT1+wh6lVTeajp72zdlS64jDLAMQetT9WEGpRLBZ9nFxsngjRWrPlmYUCFj3cB6LW
 5axu+KiU2Qt5Po94j3XvY5qRoguCzSH2VeJiUNKtw888TnScXOTY+kztyMKEMKD4Kocr
 hiuA==
X-Gm-Message-State: AOJu0YxA8FXMdUbakyL6BsfLvN3Opxl2dcn5lPDtH9KLu+Ee89bHlzx8
 zMpXDJNCl1h2Cf+6q3Z+3yREqQ10vC2Tcv1FuSWiqalXHzqbuPjP5GtKw3EsiYCF6XRthqow4O+
 OoQJ6LoUhQks4i0sX2IHmkPKqez0DfCcMt7237neYLg==
X-Gm-Gg: AeBDievrzXszVdSS+3PxJTlb7W0B3X59Jb8kIM5NlKGafGpI65qpqVRLt4GtcYnwAtB
 +irMvxUCJpBqYhGY4xnh+3l1uN3YFQ+XtI19h5HdDgSnMcqM1f1SMZJl9iho4ikwIeuZkYiYVQY
 VuOnME/OntaxLSaMYIclKHw6cFZy8hl7PiRB8itZMk4TsE7lm3DFg7M4jZX7u5dReuut9EK6Uj3
 feoKpacUDZG+ABXVh9nCpvQqoPWSiBrWBQXuJWUVI8bYEKjc7yaJHc4y34N60Bre8lHhaJkXYYy
 RJiToojZvJd/Yvdq1P6nkOoFqn32NxIp4BX0+9b7RW3t9RkGvY4914AQ99t0JGbYA37ghnWa8+T
 5fvMdKwtOV9tv
X-Received: by 2002:a53:b6c9:0:b0:654:6a61:fb36 with SMTP id
 956f58d0204a3-65c799e1717mr2170918d50.58.1778063819188; Wed, 06 May 2026
 03:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260505110036.47574-1-munkhuu0825@gmail.com>
 <CAFEAcA8s+YW9n78=75VMetVP-10mMiTkzrxCHgHK7kdvP-50jg@mail.gmail.com>
 <B987731A-F30F-4B6F-8069-86BF3377910D@gmail.com>
In-Reply-To: <B987731A-F30F-4B6F-8069-86BF3377910D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 May 2026 11:36:47 +0100
X-Gm-Features: AVHnY4Lidh43VsAOpQqAxW2N4npbwaMAIsCAwuN9s3G64QuEAub9fUH3ZtBcOj8
Message-ID: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix memory leak in ohci_service_iso_td()
To: =?UTF-8?B?0JzTqdC90YXQsdCw0LDRgtCw0YAg0K3QvdGF0LHQsNCw0YLQsNGA?=
 <munkhuu0825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 6 May 2026 at 05:13, =D0=9C=D3=A9=D0=BD=D1=85=D0=B1=D0=B0=D0=B0=D1=
=82=D0=B0=D1=80 =D0=AD=D0=BD=D1=85=D0=B1=D0=B0=D0=B0=D1=82=D0=B0=D1=80 <mun=
khuu0825@gmail.com> wrote:
>
>
>
> On 5 May 2026, at 21:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 5 May 2026 at 12:01, <munkhuu0825@gmail.com> wrote:
>
>
> From: heropd <munkhuu0825@gmail.com>
>
> Fix a memory leak in ohci_service_iso_td() by calling
> usb_packet_cleanup() before freeing USBPacket.
>
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463
>
>
> ---
> hw/usb/hcd-ohci.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 6ed8046fc2..43c49a42ec 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -748,6 +748,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struc=
t ohci_ed *ed)
>     usb_handle_packet(dev, pkt);
>     if (pkt->status =3D=3D USB_RET_ASYNC) {
>         usb_device_flush_ep_queue(dev, ep);
> +        usb_packet_cleanup(pkt);
>         g_free(pkt);
>         return 1;
>     }
>
>
> I don't really understand the USB subsystem, but something seems
> odd here. The case when usb_handle_packet() can set the
> p->status to USB_RET_ASYNC is when it has added it to a queue,
> either directly ("QTAILQ_INSERT_TAIL(&p->ep->queue, p, queue);")
> or by calling usb_queue_one(). The usb_device_flush_ep_queue()
> does not (as far as I can tell) remove the queued packet. So it
> seems wrong to me that this code path frees the packet, and
> also if we call usb_packet_cleanup() it will do
>    assert(!usb_packet_is_inflight(p));
> which I think will fire.
>
> It's possible that we can't ever actually get to this code --
> the usb_handle_packet() has a claim "hcd drivers cannot handle
> async for isoc" and some assertions about that, which suggests
> maybe that the intent is that we won't ever return USB_RET_ASYNC
> for an iso TD. But if so, we should be asserting that.
>
>
> Thanks that makes sense,
> I tested the USB_RET_ASYNC path locally and usb_packet_cleanup() does ind=
eed hit the inflight
> assertion there
> OHCI ISO ASYNC branch reached
> Assertion failed: (!usb_packet_is_inflight(p)), function usb_packet_clean=
up, file core.c, line 657.
>
> @@ -756,6 +757,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struc=
t ohci_ed *ed)
>     } else {
>         ret =3D pkt->status;
>     }
> +    usb_packet_cleanup(pkt);
>     g_free(pkt);
>
>
> This one's probably OK -- is it the one that fixes the repro
> case in the bug report?
>
>
> Yes this one should fix repro bug in report

> For the async path, I can leave it unchanged for this fix, or add
> an assertion since ISO TDs are not expected to complete asynchronously.

I think we should do this as two patches:
(1) change the "if (pkt->status =3D=3D USB_RET_ASYNC) { ... }"
    to something like:
   /* The USB core guarantees to never defer ISO TDs */
   assert(pkt->status !=3D USB_RET_ASYNC);

(2) fix the leak with the usb_packet_cleanup() call that's
    currently the second hunk in this patch

That way if I'm wrong about the USB subsystem's guarantees
we'll be able to just revert patch 1 without undoing the
fix for the leak.

thanks
-- PMM

