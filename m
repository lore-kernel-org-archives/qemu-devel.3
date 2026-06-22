Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2336FCDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZia-0002vd-V3; Mon, 22 Jun 2026 04:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wbZiS-0002v4-Cc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:09:12 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wbZiQ-0007T7-NM
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:09:12 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so7529901eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782115748; cv=none;
 d=google.com; s=arc-20240605;
 b=TMH+6AMrYIwxcAMoDylIwwuYHveAOWQlHWsnooN7vd6rMFoLb7xhIbcKgUvbja8E4+
 pkzAf/nF+904x9uQKn2afHHKbOqOaacZbVU4w17AbkVe9SsO8JuZ5ccUBiUoea6sQ2BU
 GUfW0C+MbP3GVrjaQ3L98stIV1s+uCAqczB5rTDMCBggjNaFSgtjIwYCgr8EYc4KhxyQ
 yqlIXtzgnbeStuNDl1Y1lD7pf+wbUjxEcYhVPoqm3QLevxPGveLHdKTdr5IcXaaExG8H
 D8Kj4Hi6dBJ0MS90zH5R0Vf2shgpy82hqzJVI2cExeFzNJr75gFt02TKfmkBg+qlNyUi
 QsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B0iUnjZ9VkNdo+AYrsklkEpMEbcyTC9YXNzaWrD+WNo=;
 fh=8fSEMV7LwR1ztofgn+X+NE6SPryjtm5tDVCyKdV//4Q=;
 b=LJwVi76uGFeogPFnRjyAGtRolvNoc3FUFyh+1hyjFSB7fBA164Q3A/CY2VbLTLFEvP
 Nbu7GqM64C9qspPXK+C4jVVkNhLbUi9nxEfiCE43etDZnWp1JtyosltbNMAX1gPSCq+u
 6NdWxmX7llPA2B/P+gRdiC2rnR8lgxqsGQjDhjl6OZWRZ18WlXHXoeCP7TZCSCU9o4B6
 6jwxKzR+km3wT+s5wgR2egY+nUzJ2vP2e/mFK4porCyudUQRuDu1nrh6e+T9KaQ4jxcY
 9TWDe1VRj6bH5KN31CtbmSgzGgKZ0jCPpcsAZlj2PUiXTuk6nDfEXZH2BHiSUX1Hj83m
 Lvyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782115748; x=1782720548; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0iUnjZ9VkNdo+AYrsklkEpMEbcyTC9YXNzaWrD+WNo=;
 b=frytUrn7S5T1uw0J+6m9BbJDGL1SYP5o7QJ6Q5i+KqPaj9teHLb45FhuEgLu+k3Cfx
 f/kHGjorcmWij1WvBuYRUJ4oZd5CwSrBYtHAiWwfQ1pvxxoZbMhji0ZBkcQ0lU8C+5Qq
 jwvumQR0YY3q5+1NqAH9yQUA0j8PYg8YVJuJ+VONy0mfMQ3cqYIF63aH/sfKsNbot+BR
 AdFe+WwzGBgZRoK+Ou6UGbgCHEs853hQmsfw5yY5pGB9+8MDeESQRGpMVwlsKjUdSsX/
 tJtr06sRd6njs8KNIqA75VuA/SIBThRnwwJtzYeOPl6Hr/+22ZUlT47/LY+ksoHdg6us
 B4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115748; x=1782720548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B0iUnjZ9VkNdo+AYrsklkEpMEbcyTC9YXNzaWrD+WNo=;
 b=iA2/I1rnmLZ6ri0JKgNyYrehjjm+kqKGjHc5fJnYRhu4UGjWuihcBOATZ1LE7hH6oN
 oHTBqqeRkWGh+8l1ZZpeAsUruVyx+WSvLAeMpgiuTRcVIcytIWtZfQYYHBH4k2LkcZLU
 hgslS8OoRsgro2JEmI0xtk6ed4kh2uzVF264M3215JLYD/ljSx+q25sNqVz7oM34VFVy
 Y7enUfqjTshWVzHiOUmRAxn57qaVX/VhOQx6JpuzxAG8KBcSdrobraMVQURLusoih0L0
 711oF/lsJGvgbFzFYcWe76dxZ3dzf61Ef0Zlc0c5urFqoNonB/46g2oukZQFOt2V/wO0
 vePQ==
X-Gm-Message-State: AOJu0Yxif0LYiToHZayjoBOOGnnQW7Py2vC9qordoSTnkHmZW6IWCdnp
 lnucKvNvEf9Cv6I5FQbHAuHC8TSakuMZx+bxSJ5+RNQUsbzaZyqRn/YBG66/cUHcccySLLoKU43
 +BlhYnC5UDEQpoOk2lMCmyIcXaFqGxwc=
X-Gm-Gg: AfdE7ckb7Opuf5gke3QFAg++wp+jpTX1uBkjt58/W1osbcGOqvGSgx2nhpqi9uForuC
 ZHMivwAGWsI8iZQo1NOorrqpN2phlFVTZH12PKDUxXQZnI5vAIWJT9jVSqz+Wvd2Twa54bSP1Ib
 VuIFr1tTz1Nxp34xQuJUIF50J84MiF0GeyTboJ2faaAUXHK4mMFUimUZU69fFEfH+lk1E90QF5s
 esMqlSV24FV/MxZJ9rOIOZ4h0gYfgDs2LyZDuE9bZLzCnJvSgwiUrJaokxpBEz7309bWhS5I84w
 Vu9h95KuD6LbIJMw5V68GRlPIWUA
X-Received: by 2002:a05:7300:cd96:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-30c0d11470bmr8970663eec.33.1782115748358; Mon, 22 Jun 2026
 01:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260618110119.3084296-1-caixiangfeng@bytedance.com>
 <20260618110119.3084296-2-caixiangfeng@bytedance.com>
In-Reply-To: <20260618110119.3084296-2-caixiangfeng@bytedance.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jun 2026 12:08:56 +0400
X-Gm-Features: AVVi8CeslLtwtpZjMBaBFz7G7cOB_S27CW5tcTq5cROWTbg0QH_1BrkPZunCzU4
Message-ID: <CAJ+F1C+v_mRD5f_d+CTL_rqeOSjTXOm12yqGXLeVBYJ+vvD_tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/usb/hcd-xhci-pci: break host link cycle so
 device_finalize() runs on unplug
To: Xiangfeng Cai <caixiangfeng@bytedance.com>
Cc: qemu-devel@nongnu.org, yanfei.xu@bytedance.com, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, Jun 18, 2026 at 4:49=E2=80=AFPM Xiangfeng Cai
<caixiangfeng@bytedance.com> wrote:
>
> The xHCI PCI wrapper embeds an xhci-core child via object_initialize_chil=
d()
> and, in usb_xhci_pci_realize(), points the child's "host" link back at th=
e PCI
> device:
>
>     object_property_set_link(OBJECT(&s->xhci), "host", OBJECT(s), NULL);
>
> "host" is a DEFINE_PROP_LINK property, which qdev registers as an
> OBJ_PROP_LINK_STRONG link. A strong link takes a reference on its target,=
 so
> this creates a refcount cycle: the PCI device owns the child, and the chi=
ld's
> strong link pins the PCI device.
>
> On unplug (guest ACPI eject or QMP device_del), pci_qdev_unrealize() call=
s
> pc->exit() but never unrealizes the no-bus child. object_unparent() then =
drops
> only the parent/bus references, leaving the link reference in place. The =
PCI
> device stays at refcount 1 forever, so object_finalize()/device_finalize(=
) is
> never reached. Symptom observed under gdb after eject:
>
>     p *((Object *)dev)  =3D>  ref =3D 1, parent =3D 0x0, realized =3D fal=
se
>     p ((XHCIPciState *)dev)->xhci.hostOpaque  =3D>  points back at dev
>
> Fix usb_xhci_pci_exit() to tear down the embedded child explicitly: unrea=
lize
> it first (so the set-link-before-realize check passes), then clear the "h=
ost"
> link. This releases the strong reference, lets the PCI device refcount re=
ach 0,
> and allows device_finalize() to run.
>
> Fixes: 8ddab8dd3d81 ("usb/hcd-xhci: Split pci wrapper for xhci base model=
")
> Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
> ---
>  hw/usb/hcd-xhci-pci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index c5446a4a5e..b124251ae3 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -196,6 +196,18 @@ static void usb_xhci_pci_exit(PCIDevice *dev)
>          && dev->msix_entry_used) {
>          msix_uninit(dev, &s->xhci.mem, &s->xhci.mem);
>      }
> +    /*
> +     * The embedded xhci-core child holds a strong "host" link back to t=
his
> +     * PCI device (set in usb_xhci_pci_realize()), forming a refcount cy=
cle:
> +     * the PCI device owns the child, and the child's strong link pins t=
he PCI
> +     * device. On unplug, object_unparent() only drops the parent/bus re=
fs, so
> +     * the link ref keeps this device at refcount 1 forever and
> +     * device_finalize() never runs. Unrealize the child first (so the
> +     * realized-check in set_link passes), then clear the link to break =
the
> +     * cycle.
> +     */
> +    qdev_unrealize(DEVICE(&s->xhci));
> +    object_property_set_link(OBJECT(&s->xhci), "host", NULL, &error_abor=
t);

This reverts the set_link/realize from pci_realize, it looks correct to me.
Could somebody else check if this is how we should handle the embedded obje=
cts?

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

