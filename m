Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55555EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 14:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp5nN-0000bI-B4; Sun, 08 Feb 2026 09:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5nL-0000bA-7f
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5nJ-0003Bz-3M
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770560987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4l24u92egrx51FqHblJ2umETTN6Z7KRsSIJnViUTmW8=;
 b=FQVHrRFAZtEXAz/340IvJYTw4SSdzn1n3G7O+HsvOY2lMpt7s5QrOVjFczYnd/1D0p4mYK
 vRAL6JKAypOhE7s5S3jBPZMY4X2NXASwFOnQJokJvleSxfrxa6qxQxcoxvUj75h/mR8mTQ
 eugUNILPFeoz0s47Fruvq8KKKKibIow=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-I43arvK9N76-cBHOkCLYsA-1; Sun, 08 Feb 2026 09:29:45 -0500
X-MC-Unique: I43arvK9N76-cBHOkCLYsA-1
X-Mimecast-MFC-AGG-ID: I43arvK9N76-cBHOkCLYsA_1770560985
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-896f2e45fb0so19509756d6.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 06:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770560985; cv=none;
 d=google.com; s=arc-20240605;
 b=bkmYnsDywg5cxSQlew3Pi8BWc+BRXje5Y2z7o8P02Y9YzmeVzXvY8WOPVMUv8AyySC
 8FthP4qX+b82tV3aTdq6hlPBXJN2mN8SciLOApueXTlh9NlRansh7DAyAtnfEp56Dl7C
 TCg5hdkr8S6OMZ+LZBbHqamDoE+AxIVm3XQpd64CWrlxP/y/ALew5x26wFQ4I7lS7Qyb
 LreuJQ4BUQm0l5JZph3qw37vO93aceyLZrKD7nzIVjjZ/Ga1D9LgEtJAmiAED/aO5kmH
 cU7de+q0A5GQc25849MdRwHierwLG1hsoAyNpLPtZ8+sfpzKbcXCLEwzf85nyjitukyo
 BXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4l24u92egrx51FqHblJ2umETTN6Z7KRsSIJnViUTmW8=;
 fh=r5iv8mbU4L+ZIg1Jzs3uT4g8P2onVU1mUxpJdx2IfDs=;
 b=BVQ5H4k3LJzWt+/pjqQSe/poMnypnLBIys1Vx8RhTpdi5Wi5e6GP90vSjAs7hfAn5b
 I95xUykq7BS4XRhjucFZbWnugCGdkH7dxI44CSFoWx25oBFjjS/Ah7lxy9Y6FsRE7aaW
 iYjj0aKgyo80vAZi4bziwQegi/gQl/3BM6mwvWkjKzhzDo0WmsU+4yPFDmZWZiKGWuO3
 D4liRPt6ZbJqVwh1CI6CN0snPDGMype1IiwYYPd6A89MYBJHSzDr8z1tM97gvvvGQNo/
 NZNkwZmikK7BvgZ5lbyCdEuheEZeia3+Z7bI2ZPDSEZZUbISGA7n+uoBRmy1+u9jfvfi
 Re/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770560985; x=1771165785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l24u92egrx51FqHblJ2umETTN6Z7KRsSIJnViUTmW8=;
 b=YTA3ptoShl7OvBAUyIEZn9m6QnYwFfj2/3AttNVVaNpcig+WS2PD6wyB0+n475jcJp
 tAYJNA00eTUtL4/+u9cLC2VAoY8VC0qMYqG+puJrdvDnABbuNj0PzjGTQHFqtMM+zBjR
 v8F0GFERO92E6t64FF8L1+u23dbv7G+6h2zJ15DsevsHz5ZPRKRSd6/l9aNfAIyxnDk2
 K2HpTwV2qqNDu1AGt1Rn/gEMLCaok5Zwpf8yZK56V5qrM/YvTZi+Ya4CL5l4VmoUI5dB
 A4HG6PbbxWtie/Vd49yW4fLvHYcl5emzSmVnW+ueSOOMKx5ctjolLLlAD8aiQaX9bBVG
 Molg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770560985; x=1771165785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4l24u92egrx51FqHblJ2umETTN6Z7KRsSIJnViUTmW8=;
 b=uw87E5LwC9jnYUUPqD5UjWRWuvHdk1akIbq6R1qVE1uvnCCoPVeqpqdpfQDGSxrSSi
 tMg3mF3I5qGYPUu01U8N1NAl0zIuwUMphroJAXkTt3tqifT/pSCdpr4bPDbYIOJl85Rp
 Kq9qo5IRfLcUFeOAziejHRA0pZFmw2SZaHoOp4MPcQNZ8lhZ9CCZTizXUT4NFJkpqT8x
 IU5Wmah2zhQhKtaIcoQHRBZGHT16QWH34E+x7Zn3lIeosKmdmilyAcaHkOoZDmYAnJpE
 5eR6h8ZBkwl8lNbXRbOy7lzS5UxsmlO804A3fm3U4g7g9EPu3Be4Nzpq+oHc+kI6ts1N
 Ns1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw0ZrXynCEx2NRo+W4BS+FUq5a1+fRRV/XbSxDGONSbQa6SAh+aJ6D1j0tx/nZ9v5aDERjTG04+6w+@nongnu.org
X-Gm-Message-State: AOJu0YyuaRc3a+aaSdpN765bPBtrfKKzihxpUgeP424ylM60T40MjcXV
 hW6F/3NCIcYAfwThe5bLCPGpk6cYThPsWL60PwNy1P3TWYX5/sLkXulBBlYPJXgYxA+7tFxpmbi
 GRsNWuVOgG1ykSEJgYPHxI5vqcTnUjMci44/RcNzylY0XFuCwPvfn/2wpSCRyeXV4Dtle1vhAmB
 QwIWn3CXZ5qFsH5slwkwCAamj2KKidCP19/OMz8DM=
X-Gm-Gg: AZuq6aLdhhTa4cxH3/qY1AFRyzVd3m2eQXfj4ONSiI8sRZkQdyI5J7kcM9mYLZ2Eanr
 tcFxSalsWWM6sYahVQV8SqnimGNOp+Z9+9wSQptAeOgNW/XtiF2Hu8cb3eDtXJeh2C0s05xG0Gq
 UuFFXYZN5Fv9jWAvFHcEFqwtWr1rvzJos5s19IAze5S9lTfq9mUrQ7S5VX6YC7sHivh0rTxB2gM
 WkPp5Thq6PkqUJly7NIJh36XBag
X-Received: by 2002:a05:6214:20e6:b0:896:f79d:ae4f with SMTP id
 6a1803df08f44-896f79daf54mr23083676d6.26.1770560985109; 
 Sun, 08 Feb 2026 06:29:45 -0800 (PST)
X-Received: by 2002:a05:6214:20e6:b0:896:f79d:ae4f with SMTP id
 6a1803df08f44-896f79daf54mr23083396d6.26.1770560984724; Sun, 08 Feb 2026
 06:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-26-anisinha@redhat.com>
In-Reply-To: <20260127051612.219475-26-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sun, 8 Feb 2026 19:59:33 +0530
X-Gm-Features: AZwV_QjDBPAheMWA1wayYFPT0EJSoanr2VXiVZ0cbVfNGDhQ25XFxnHtxEjZDgs
Message-ID: <CAK3XEhORZM0jR4hBDxKDW+tXjvGtZrXzhoajhw2_=P=8b5RhjQ@mail.gmail.com>
Subject: Re: [PATCH v3 25/33] hw/hyperv/vmbus: add support for confidential
 guest reset
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> On confidential guests when the KVM virtual machine file descriptor chang=
es as
> a part of the reset process, event file descriptors needs to be reassocia=
ted
> with the new KVM VM file descriptor. This is achieved with the help of a
> callback handler that gets called when KVM VM file descriptor changes dur=
ing
> the confidential guest reset process.
>
> This patch is untested on confidential guests and only exists for complet=
eness.

I have been able to exercise this code in a non-coco environment and
also will add a functional test for it in the next spin-up. So I will
adjust this comment to reflect that the code has been exercised/tested
in non-coco and will keep the change.

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/hyperv/vmbus.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index c5bab5d245..ff1b6f805c 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -20,6 +20,7 @@
>  #include "hw/hyperv/vmbus-bridge.h"
>  #include "hw/core/sysbus.h"
>  #include "exec/cpu-common.h"
> +#include "system/kvm.h"
>  #include "exec/target_page.h"
>  #include "trace.h"
>
> @@ -248,6 +249,12 @@ struct VMBus {
>       * interrupt page
>       */
>      EventNotifier notifier;
> +
> +    /*
> +     * Notifier to inform when vmfd is changed as a part of confidential=
 guest
> +     * reset mechanism.
> +     */
> +    NotifierWithReturn vmbus_vmfd_change_notifier;
>  };
>
>  static bool gpadl_full(VMBusGpadl *gpadl)
> @@ -2347,6 +2354,32 @@ static void vmbus_dev_unrealize(DeviceState *dev)
>      free_channels(vdev);
>  }
>
> +/*
> + * If the KVM fd changes because of VM reset in confidential guests,
> + * reassociate event fd with the new KVM fd.
> + */
> +static int vmbus_handle_vmfd_change(NotifierWithReturn *notifier,
> +                                    void *data, Error** errp)
> +{
> +    VMBus *vmbus =3D container_of(notifier, VMBus,
> +                                vmbus_vmfd_change_notifier);
> +    int ret =3D 0;
> +
> +    /* we are not interested in pre vmfd change notification */
> +    if (((VmfdChangeNotifier *)data)->pre) {
> +        return 0;
> +    }
> +
> +    ret =3D hyperv_set_event_flag_handler(VMBUS_EVENT_CONNECTION_ID,
> +                                            &vmbus->notifier);
> +    /* if we are only using userland event handler, it may already exist=
 */
> +    if (ret !=3D 0 && ret !=3D -EEXIST) {
> +        error_setg(errp, "hyperv set event handler failed with %d", ret)=
;
> +    }
> +
> +    return ret;
> +}
> +
>  static const Property vmbus_dev_props[] =3D {
>      DEFINE_PROP_UUID("instanceid", VMBusDevice, instanceid),
>  };
> @@ -2429,6 +2462,9 @@ static void vmbus_realize(BusState *bus, Error **er=
rp)
>          goto clear_event_notifier;
>      }
>
> +    vmbus->vmbus_vmfd_change_notifier.notify =3D vmbus_handle_vmfd_chang=
e;
> +    kvm_vmfd_add_change_notifier(&vmbus->vmbus_vmfd_change_notifier);
> +
>      return;
>
>  clear_event_notifier:
> --
> 2.42.0
>


