Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2704BC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshBN-0004oP-AT; Thu, 13 Mar 2025 07:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tshB2-0004gv-0i
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tshAz-0006cw-Q2
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741866994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9ZH4R6ScKbfPg7rsxi8yC1VpAsREO3YuquH+ZEZz6c=;
 b=T7DNhnFfTKCgV8KiOpwygE9gSCBp/7Xe+remTq10QYVT+0IZHt0L8Fypyo8CzzAf3hKwv4
 Q1u7oA2HTZNapl1smYbF78CkwWIiNV2K+mhYv1uUN77HQ7BJ2vHl3tRiDUA0KTZxYzsfEd
 ETS426yzJWC9/w57sLi2srkTQoM+nP4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-OC2g4IyIMpqvbRNILTs4_w-1; Thu, 13 Mar 2025 07:56:33 -0400
X-MC-Unique: OC2g4IyIMpqvbRNILTs4_w-1
X-Mimecast-MFC-AGG-ID: OC2g4IyIMpqvbRNILTs4_w_1741866992
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7f6f6cd96so95113366b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 04:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741866992; x=1742471792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9ZH4R6ScKbfPg7rsxi8yC1VpAsREO3YuquH+ZEZz6c=;
 b=e0RjhTcgi2OHeISSTjf3Cnf+MOY02Vvd/7Z1bjzQP/8iVy/YGrpxxG0SlP/JXJwPh6
 ysY6wg3r/4Oh8ZsH/uuj1gc+5y704VuUeH4nIc0m1/At5dfgGYrOYZTPuX6xFus1jl/u
 3+PcL9+o82ZkG+5PbkYv8Vt3lqEOu9mtgDz8GUQ2x2wupil/K6zu/xXXJsKFxOfO0vMY
 8uCzafDtC7fOYNjQKCy8YOINNVW21N04Zo3Kf9trIDTb7U3f8UNAhLAoYICnshnBCInc
 3TX8W7sTcPxCgx6xEONMHaUY3CWDcmvgQ5B7zYtEOKQxSAy2Ae8IO/PjjKOsLBqZzq1C
 mD1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUQeMMS5Qty17pdsznGpRYOkhuYTMdxdhUhx5coomtQABgy1AclnSBXWGecJ094m7CqO6Ztm6ejWQW@nongnu.org
X-Gm-Message-State: AOJu0YzU/FPP7xJ63ZkCnhEOM270g3MtLGklcKK/bXFNDcMJ7KZZzuyG
 Bdr8XI5M3TUIM8Yv5qpkoDy8vd1maLD9pu6pYtsSkPlQA8qrMx6aDQlxKmbUGj9Ebswmei5dXkQ
 YikjgEbXGDA1mZ1fcvdshl1gDLf1DrcIoZoNdiH4hxrrA2xNkWPJLeAbFLkjUXGNWq4HtEY66w2
 T4DmwPvKWuKWjfMH5V3+wppfqxOlc=
X-Gm-Gg: ASbGncugci9zg/YC7psO8Heiiy3MZCRf8QWj0aPGSkpiGZCHlwfbpcRvY/IlXiFmqBx
 eZcmWPg9utNO9XxV34zC9TgJyz5X0BGLWIFM2ggOYoP2NM03Npl2PiH5F9N7DGBdZH4V+LqZW1w
 A=
X-Received: by 2002:a17:907:9694:b0:ac2:7e56:5ca5 with SMTP id
 a640c23a62f3a-ac2b9e22119mr1631472866b.34.1741866991799; 
 Thu, 13 Mar 2025 04:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtb9WwhJc8w7lQFYrcvGLwnRGGvD8scNZaARXSPBZYKuYD6p7btaXuQDrAMnbhiHkw1xO/BzGLBC1JqQOGofo=
X-Received: by 2002:a17:907:9694:b0:ac2:7e56:5ca5 with SMTP id
 a640c23a62f3a-ac2b9e22119mr1631468966b.34.1741866991384; Thu, 13 Mar 2025
 04:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
 <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
 <Z9LBD_FnO2Gi2vMK@8bytes.org>
In-Reply-To: <Z9LBD_FnO2Gi2vMK@8bytes.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 13 Mar 2025 17:26:20 +0530
X-Gm-Features: AQ5f1JrpLCeJtRg59aSqwJVCQ5M_i2-zbQyKiCmMb1n4Y85e9mJArrdXPRpubKw
Message-ID: <CAK3XEhMUuKKpWo59uWspJLjW+Vgm7e4JVKXJrAQ4zTtsWtyqKA@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Mar 13, 2025 at 4:57=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> On Thu, Mar 13, 2025 at 04:39:15PM +0530, Ani Sinha wrote:
> > Right so what we are proposing is generic enough so that if the VM
> > wants to use an IGVM container as opposed to an actual firmware image
> > in a FUKI, that is totally possible. Then you need to have that IGVM
> > setup the memory in a well defined way like you suggest. Sure, the
> > IGVM is not passed through a command line but it can be loaded by the
> > guest in a well defined memory location and then its instructions can
> > be executed.
>
> That makes sense. In this scenario, how does the VMM detect that it got
> an IGVM image instead of a firmware image?

VMM does not care but UKI which the guest brings in would since a IGVM
container would be part of not .efifw section but .igvm section.

As I understood the current
> documentation the defined behavior is to copy the guest-provided
> FW-image to the BIOS region, no?

In the latest proposal which Gerd has suggested, VMM does not know or
care if its bios region or not or what kind of image it is copying.
The guest provides the target private address at which to copy the
blob from the shared memory region. So the FUKI which bundles a fw
image would provide 4G-size for x86 as the target physical address. A
FUKI that bundles an IGVM can provide something else.

>
> > In our proposal, we do not want to dictate how the guest would want to
> > do that. So hopefully you see now that IGVM and our approach is not
> > mutually exclusive but can be complementary to each other.
>
> Fine with me. Just note that supporting the current non-IGVM process for
> confidential guests still causes the implicit ABI issue I mentioned
> before. But not being a KVM/QEMU maintainer I can live with that :)
>
> Regards,
>
>         Joerg
>


