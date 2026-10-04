Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C363CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDPIh-0004NV-E0; Sun, 04 Oct 2026 12:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDPIg-0004NF-2u
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:42:58 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xDPIe-0003FQ-Cy
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:42:57 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-155b6c7d49bso139412c88.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791132175; cv=none;
 d=google.com; s=arc-20260327;
 b=V4cDoERYdIAgDdEpE8+ShP0zLqwQKJqTGVh8+i3xov+raS6LgkVnMKhTtQhZWh57/w
 1Br1bZgiI97zJkslAykXKNdoJWBExNx3iqh6194Q7mLA7HiQzaAUQH69/ximhdvS9E0T
 F+N8mX4gB/5KWxO5bAPBpT0AjtWMLYrasQX5Y0npxqKjqiP/hSDZpiGM9H14IHZYko39
 TphV5gOd8rV/EQbq7BxnDDx65pQmurrXqUl81bt5O4mxGBd8M+gyHMG1VlPcV0ftsTzz
 hs3pQIGES4PsCRmVnMJDPL2ZR4a5Ck6Rcq0O2RouReTGL7R5KSQaC6ezaXEi4Jj73o14
 M5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hmgic5qi7BBolWQLBsBWjzRO0saIMkTYG9u1KiWY0MY=;
 fh=9J/Gwyb/4zJKC8CPj6CIAWvqsyEhLveUFmTr6Q7ERwE=;
 b=P2L24telZ32mticAurbPleNyAcK5lZ7SsA5LE/eU7OWwWRuScacc0bj9pvncruA/fn
 /O8KZcnWqaGhlwRYA0rXe2x00qfVZUYT5tm9du/TdIMASivBjnDQKj9PjFgB4lPQRGhJ
 1oeHiP1VHjkT5DCtkJNSV+lRxisE51iybvKE2Z5uzjhwNzhmCJfQ/Xtx180t3GVpZxLR
 USc9RF/ddJiWlR6M52jmv5qSJ6HcgvLSgaBW+fX0f49wM+cQ0/JAwDBY73/nhyQimXvN
 fwaVSY/svRh+gLCoC8zf1AOL0XQS2/9HEAEOcgEzGnSixUTt8ppZOcpHewRaU0eLiDmQ
 h6Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791132175; x=1791736975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hmgic5qi7BBolWQLBsBWjzRO0saIMkTYG9u1KiWY0MY=;
 b=FCfWykRFV2TU7GwYKP/kTuDCOIZwsW/rt0s7jqu8OK1gEAvXGMu4ZCr2aE7aQtI1H1
 c+KXRHwahoHpqn3qqnHP71LKpd0cFuobkbE0bkAvLC7VlFYPEZ2H1z+qHK2GECkRS7+L
 tq9fzZhl545Le1WfFBPMfUbwqTtfeXg0UxRs/zBo/bsYoqMelvZKIK3pVsRh23YvkQGX
 3rteQ+9JnLjLqiZ9awvPgWTP+Ryn8j+/LqdxOH4OvP0M9ANW7FbJMvMGSrHoU9zdM00D
 YOQe611Up/oWD6ZRQ9WEvDCewAHy8+aCo7ouPeGivV1ZNKh01+0mqTt+8QXqLemma7LH
 McQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132175; x=1791736975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hmgic5qi7BBolWQLBsBWjzRO0saIMkTYG9u1KiWY0MY=;
 b=hKssSMouo7kguPnFerHWQdxzgVi9l9hxoS4/sNlM5NC3SPnNAYTyih7DEl4Ozg8c5A
 qK8pJug2B8ndTapCwbQh4sQGGgq2P1ocXtEwM4hRgyXEEHgeeTuokMSl0SqMgGcB95G4
 zo5B4uNwuzNGrmTLymKweX3qks9bcSnCOBO8oK+5VxriE9WCAK+xi3uTa5XHe+y1MkJF
 nLiZkXRgANTi0qHHx0pMi4J2ZI+w1K6LdYtvig3+huDETuNLm775/OewlxtLw6T2R0QA
 1Y5F6Rdux9tIA7wWAMOiR7+LztE1fwejvDimedR5D8x0Um0X/b/s1WY3olALajvdHyCj
 r3hA==
X-Gm-Message-State: AFuF++mtdoSGuUwgF95yBQCz6e/KOTzrF6ftGsMt8N6L1t/kISQgubVM
 HN314MvjmfZtUNlnrvYZ0NgkwUZCFgF9A/d5Mf5wDNe5G/VTBh5z7c2IixbTTkmNG/YzgiLTGyJ
 chEumEo8CaepF1gARk38DcB2M/maq4Go=
X-Gm-Gg: AYBFou19GLmrkeYVtGcYLR05yfILkHZE+7NwSdG+wCm6qRD/8GTkvjOAjkfDFB30Xbn
 5Wz6dFOfcvS7Bo99vu+eZeJrmu/mC2T9s8uPKJfSP016PQe7rZTePAgUDobHp6bs+asjzX0wgnf
 By+YrO7WNfmJIy+9qr6qOXSECmdTUh4N0pNt1PMJ9klHpP8gAdxAsAp+NdoznyBz4/4FuPRQvmQ
 y7bxj9QstWNGow+YmtZ+r/Gaha7x3q17kjimP9GhkrYVLAEHdyXEYr/5rH6VWQHPzGcIKZ0FKkY
 XNqmYRqFPkGEbPgMDVcq31kWxLAbwMSv0kreKiddQmcA0hb+ZaI8EUaOWf3jYMj5Hx2ZLYp9l/N
 QLiMiSoxfkTQ=
X-Received: by 2002:a05:7022:f51b:b0:14d:c7ae:85df with SMTP id
 a92af1059eb24-14f5b9fb621mr9714646c88.12.1791132174636; Sun, 04 Oct 2026
 09:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261004042722.6937-1-junjie.cao@linux.dev>
 <20261004042722.6937-2-junjie.cao@linux.dev>
In-Reply-To: <20261004042722.6937-2-junjie.cao@linux.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 4 Oct 2026 20:42:42 +0400
X-Gm-Features: AclHuK8ltQITox6JOp6J6eFbQg3kefyhQ3DPqcn8Odb-SftfbvCM0Ar9iQyP5r4
Message-ID: <CAJ+F1C++dNBVKbwcXPsBqoOGOENMHcB_CrqgQD2-ybNqdEm=1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb-host: validate interface number before indexing
 altsetting
To: Junjie Cao <junjie.cao@linux.dev>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, kraxel@redhat.com, 
 philmd@oss.qualcomm.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Sun, Oct 4, 2026 at 4:11=E2=80=AFPM Junjie Cao <junjie.cao@linux.dev> wr=
ote:
>
> From: Junjie Cao <junjie.cao@intel.com>
>
> usb_host_ep_update() indexes USBDevice.altsetting with the interface
> number supplied by the active configuration descriptor. A descriptor
> with bInterfaceNumber >=3D USB_MAX_INTERFACES reads past that array while
> the host device is opened. Skip such interfaces before the lookup.
>
> Record the descriptor's interface number on its endpoints as well. The
> loop index identifies the descriptor's position in the configuration,
> which need not equal bInterfaceNumber.
>
> Fixes: 0dbe4768b95 ("usb-host: use correct altsetting in usb_host_ep_upda=
te")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3975
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  hw/usb/host-libusb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index 629505c6d3..fd4a16ee8a 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -895,6 +895,11 @@ static void usb_host_ep_update(USBHostDevice *s)
>           * then correct the alternate setting value if necessary.
>           */
>          intf =3D &conf->interface[i].altsetting[0];
> +        if (intf->bInterfaceNumber >=3D USB_MAX_INTERFACES) {
> +            trace_usb_host_parse_error(s->bus_num, s->addr,
> +                                       "invalid interface number");
> +            continue;
> +        }

unlikely to happen, but better be safe.

>          alt =3D udev->altsetting[intf->bInterfaceNumber];
>
>          if (alt !=3D 0) {
> @@ -930,7 +935,7 @@ static void usb_host_ep_update(USBHostDevice *s)
>              usb_ep_set_max_packet_size(udev, pid, ep,
>                                         endp->wMaxPacketSize);
>              usb_ep_set_type(udev, pid, ep, type);
> -            usb_ep_set_ifnum(udev, pid, ep, i);
> +            usb_ep_set_ifnum(udev, pid, ep, intf->bInterfaceNumber);

ack, it happens to match generally by accident

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>              usb_ep_set_halted(udev, pid, ep, 0);
>  #ifdef HAVE_STREAMS
>              if (type =3D=3D LIBUSB_TRANSFER_TYPE_BULK &&
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

