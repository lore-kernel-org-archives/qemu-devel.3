Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C5EC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 11:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjGYM-0007bt-1p; Sat, 15 Feb 2025 06:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tjGYJ-0007bX-PU
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 06:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tjGYH-0004xO-Fb
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 06:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739619698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQNn+ySMPSnapUKYoGDM2fjYmGPzosrqKxoXAka8cE4=;
 b=aod9PzhKaiT3SY+gcbhS+m8nOJr8dZNPu1whWVdhp6086CK9brOb/S3vAaCC9jL4Xh4la/
 FAVFJNYve138BRFQFEfVFKpPqlfwCcZtL3HFqY0G+PQVB4JvTMIbcijQ2RnjP7Yz2VCHvv
 u8hCTq26xNfQgtjrjdz90jT6NurLvww=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-zlYrjeo4NqSouU_8cFOz5A-1; Sat, 15 Feb 2025 06:41:35 -0500
X-MC-Unique: zlYrjeo4NqSouU_8cFOz5A-1
X-Mimecast-MFC-AGG-ID: zlYrjeo4NqSouU_8cFOz5A_1739619694
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab7e718b232so216725466b.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 03:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739619694; x=1740224494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQNn+ySMPSnapUKYoGDM2fjYmGPzosrqKxoXAka8cE4=;
 b=U5YBqHEBYl8bR7cS9jiKFX4ID/wXqOmOEwbp2F1p9vlb5xPasnq1th/8A1Z7DjhJgS
 dn7mv6Iub8UVe0dhmS26KUlaCI3XUy71aeZMJgkYfRZTkM5zgB40mv9uD+jMNKjBWU+H
 b4A2D29NKFHf6WXIOTNpilw4K6UMf7pxxf3gg0SriqMzGCZEt4jd5DKUY1KOx2HHYC4B
 xxIeNPwlC2kZnvYE4mW8dGLep55pb33pzCzftIqvjd2F0/xQKb+5+539WZJZyPhFz3el
 jpoJoPIjCECFQCKQ5NtfR8dvft7zy4MOE+5sXTLokhO8+gCJ1llH2/Gau12MBsnb3uI0
 cLLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXww2o30VnzEszX2LpFoHSnVrnk6mUz2BmuMznuTknoNiat04UJO7XLbLi3DO/FCSJxKbLq+nbPL72N@nongnu.org
X-Gm-Message-State: AOJu0YzGY0QFU/a/1hON6Edscbk98iTTqg16fLJC4pARKsvz55WPuomg
 zNW37dDxUEhjtsSakT/CdBmzMlYdnO8tI3lm8AOys79IXLqRwFpHttEfleJKNBM6f/QGNHmQf6y
 fURJWzit4yVArJN3EPPw7ybGeghS450zRFlZi8o5Cu8DuFWGSOnHmNz9sj+PCozLmQ83R3ZlYPk
 TgGqLTggKotnfcCgnlUhdPZnMIyMI=
X-Gm-Gg: ASbGncvZsmpMm5jdqWl8Dhk7YVsuaZy+ZrYihncvF2hXlJnaLoYzWTbW6klC0TAhpCK
 Ar8ECOzd/orH1FNlQSGcXf6LSafZgYGoA9rMIpeHuvSiIeaYD/oiWx/3DRMoINaI=
X-Received: by 2002:a05:6402:26d1:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5e036063de6mr5622616a12.17.1739619694284; 
 Sat, 15 Feb 2025 03:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4Fe5K505evc4aGXoB9+/3PyQSD9P28x7nYpV49h0HzfgjTMa8MU93Msh6JZ0r5gvQOQKBw+zdX3m6iMx6BhQ=
X-Received: by 2002:a05:6402:26d1:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5e036063de6mr5622589a12.17.1739619693883; Sat, 15 Feb 2025
 03:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20250129063153.3967220-1-anisinha@redhat.com>
 <efbd2dce-b4c7-4c5e-b6b6-230761eefce8@amazon.com>
 <CAK3XEhMcScorAeRFjRmmt2Wx_ehvw3-Onq_VrJTc=pwD2HoVQw@mail.gmail.com>
 <549e04b9-584e-4165-a3c8-b9b667059f78@amazon.com>
In-Reply-To: <549e04b9-584e-4165-a3c8-b9b667059f78@amazon.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 15 Feb 2025 17:11:22 +0530
X-Gm-Features: AWEUYZl53jorMvxUbs3IYwRysBdY60Hhu4MN3w4bbqXLD45bT1PkrfGlzVl8XQ0
Message-ID: <CAK3XEhNY_0ehWU6Vw4LYvigKW67uO9+JC3mqtb5di-fpd6LH4w@mail.gmail.com>
Subject: Re: [PATCH v5] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Alexander Graf <graf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 14, 2025 at 9:26=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
>
> On 14.02.25 16:35, Ani Sinha wrote:
> > On Mon, Feb 3, 2025 at 3:50=E2=80=AFAM Alexander Graf <graf@amazon.com>=
 wrote:
> >> Hey Ani!
> >>
> >> On 28.01.25 22:31, Ani Sinha wrote:
>
>
> [...]
>
>
> >>> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >>> index c23b399496..0eaf8aa3ba 100644
> >>> --- a/hw/core/machine.c
> >>> +++ b/hw/core/machine.c
> >>> @@ -34,6 +34,7 @@
> >>>    #include "hw/virtio/virtio-pci.h"
> >>>    #include "hw/virtio/virtio-net.h"
> >>>    #include "hw/virtio/virtio-iommu.h"
> >>> +#include "hw/misc/vmfwupdate.h"
> >>>    #include "audio/audio.h"
> >>>
> >>>    GlobalProperty hw_compat_9_2[] =3D {
> >>> @@ -252,6 +253,7 @@ GlobalProperty hw_compat_2_8[] =3D {
> >>>        { "virtio-pci", "x-pcie-pm-init", "off" },
> >>>        { "cirrus-vga", "vgamem_mb", "8" },
> >>>        { "isa-cirrus-vga", "vgamem_mb", "8" },
> >>> +    {TYPE_VMFWUPDATE, "disable", "1"},
> >>
> >> If vmfwupdate is opt-in anyway, why disable for older machines?
> > Some older machines does not have enough slots for new fw-cfg files.
> > For those machines, we cannot add this device. Unless we disable the
> > device, QEMU would crash on an assertion.
> > This particular case was caught because the CI pipeline was failing.
> > There might be other cases where we need to disable it but CI does not
> > have a test case for it.
>
>
> Please find a better way to fix that. You can have better error
> propagation when fw-cfg fills up so it's clear that the problem is the
> additional vmfwupdate device. But silently changing the behavior from
> "Device does what I want it to do" to "Device is attached, but not
> functional" based on machine version is a big no-go. You *must* fail
> loudly, because you can not honor the user's wish (expose vmfwupdate).

OK I will figure out a better way to disable the device if there are
not enough fw-cfg slots availble.
Meanwhile, I sent out a v6
https://mail.gnu.org/archive/html/qemu-devel/2025-02/msg02982.html


