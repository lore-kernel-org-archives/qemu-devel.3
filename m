Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA261C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 14:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsjwm-0004M5-5G; Thu, 13 Mar 2025 10:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsjwk-0004Ld-Ja
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsjwf-0005Jr-HQ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 10:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741877638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVlROKxnPSlo2oo+eo3Fp/0j9xCKLHilQ0jYMudkNEk=;
 b=aw7NtKn4+VycgymraYl4q556RQH7BnqSNxoGhfcbl/diZNKZflZB7gbO/fyh1Mfm7kTvox
 nlRVNb10I5YPrTV3G8sMbbdihNjXjpX2DzbX8rBcLqKZcHeLXGGzkUVTPYOKLESbHHhaqD
 IfOgTX6H7Je9p9okU8+VFuHz5NA3QFw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-_uETFKVqMeefh76VmVSRSA-1; Thu, 13 Mar 2025 10:53:57 -0400
X-MC-Unique: _uETFKVqMeefh76VmVSRSA-1
X-Mimecast-MFC-AGG-ID: _uETFKVqMeefh76VmVSRSA_1741877636
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac313093ed8so83941366b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 07:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741877636; x=1742482436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVlROKxnPSlo2oo+eo3Fp/0j9xCKLHilQ0jYMudkNEk=;
 b=T62l7oBjQN+0XHwZuivesxPgVTP/BryyM9InH9a8nKPmUPrlTK1AfGjfm+zRhwvvUP
 /69AvEszxHRCv+gV5QjlTP7Hsw+Fa2l6XBulFzKMD/galj92btBwXkaNeIOFA7mJug7x
 gVoSQzXVxJ/nEcWEjy/6T5kVBrLr0OhKaibsG5RKjY1jtRrBvNdrNSJmYMZlVU0xR3tr
 kq+j4DGCn3Hw+ohx+aEnwXG03ZnjArHTzQ+IOwAwqUBGvO3OnIUWuNEchwZGOWMZzU5M
 u7qSFdo2u969TnWh8XFuNLO+0A5WY77XH4SBkZ+ig7JS6R8NYXx97xwUbth19N8ZKgip
 evfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRnY0OrOrtshNE/w2zaNcix9tK6uGAsGi75/wyWg4bu5/mo8rqgfz+TyH7zOetyJvs3p0kogJEjRXn@nongnu.org
X-Gm-Message-State: AOJu0YzfzaBYgmSUtOe+YEXKyrpC1EGNwAGEOHceuPgRhugOdtldCx+v
 mjUKBmLRwJVaL5FK5zm3Tt4Mq+CdPz1vEBKAc2WyaCwHBA5HJ3iMqfK/7tlanTgwgX6LUHExaMS
 fAGxkEbkmfeWGLf+9kcVwpxOffaYw5T+nCJlT/KROPB6AQvW5EFFJMH29OiAm3RPBYn9TuJoG7r
 RGbfyOLfSH4/1nK/LlgUAPGsVJJ1k=
X-Gm-Gg: ASbGnct46MEoBb6PAow+eCi8MmCo2wCA0GHYVBoaPzjaOQwURqVZrT/SnvUSuiqPwJH
 iuD+zCEckH5BvyJ8DQ2mWVgWHlY1swWGP/pu7LLhR62brc6+g85T+jxAJANJd0SmlxMPw616Gyr
 k=
X-Received: by 2002:a17:907:3da2:b0:ac2:ede5:d0d3 with SMTP id
 a640c23a62f3a-ac2ede5f85bmr668286966b.27.1741877636479; 
 Thu, 13 Mar 2025 07:53:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW3PdhnBSRqJ7iKtkWP5nZmZ9ezfxvWR5012Lz+6s/0Y21i6l8A9fYZKOsZqRV8Uwow/DS/1ShM+GvixSg+sw=
X-Received: by 2002:a17:907:3da2:b0:ac2:ede5:d0d3 with SMTP id
 a640c23a62f3a-ac2ede5f85bmr668283266b.27.1741877636080; Thu, 13 Mar 2025
 07:53:56 -0700 (PDT)
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
Date: Thu, 13 Mar 2025 20:23:44 +0530
X-Gm-Features: AQ5f1Jp0PtyecosV52PPV91b5Q4YBPpJJkCdXxD0RSChoR2WIO2VdGJ-8r1oDdM
Message-ID: <CAK3XEhMa3Bvy42ErqAhf9vE+oUH1ZkHhv8JZRv1BpyfdejYMYQ@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> an IGVM image instead of a firmware image? As I understood the current
> documentation the defined behavior is to copy the guest-provided
> FW-image to the BIOS region, no?

Note that even with this approach where the hypervisor *thinks* it's
dealing with a real firmware, you can imagine a small rust based
firmware image that is loaded by the guest in the firmware region.
This tiny firmware then jumps to a well known address (chosen by the
guest) where IGVM is loaded and then starts executing the IGVM
instructions.

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


