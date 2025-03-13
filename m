Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AA6C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgRr-0005pL-IQ; Thu, 13 Mar 2025 07:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsgRW-0005g1-H6
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tsgRU-0000Qh-Kh
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741864172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIjqCyyo3DQV+9PkQ+yIPFvQTOrMXmHMjeZUHHufvng=;
 b=coAHIHUioxRaXy63X0XHNolCBrIcEQFboQ4T7sSM9X1h6RGsH5XFFoM1pN7CVQ8tZC57UF
 FGRT08LmMX+QFeO+MSJjzq9txTrXQTasuC1BAuqadNWDkDTrAJT97ysfiUpW9yNoC4v+Cl
 8H1FMklKbng3lKJuTfE8HNKWCAjs1MM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217--VG7r-KrMbaJnWC7FJfagA-1; Thu, 13 Mar 2025 07:09:28 -0400
X-MC-Unique: -VG7r-KrMbaJnWC7FJfagA-1
X-Mimecast-MFC-AGG-ID: -VG7r-KrMbaJnWC7FJfagA_1741864167
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac2bb3ac7edso89249466b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 04:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741864167; x=1742468967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIjqCyyo3DQV+9PkQ+yIPFvQTOrMXmHMjeZUHHufvng=;
 b=hJ6Jy55UZPLcpW9ZOiNrog3y0QWQYnpTBe7owWABfzwsqG38NKYUFwOjnYiQPJ+Ih1
 VImUK4znWO8Nwa1u5LMTtLF9/h682HVWnRxbLYqbuNsWrsvM17E08VkomVql14N6oAXb
 s9zwdXPjPqUWB+tmTIodfHLG93pWd4NgT1MbVVpQUv8t2Nbe38i8/YowshEsMbw9n5o6
 Rt6I3ck0dLO8cRfGfy8Me0mvZzYW5A27bztnU/YJe5Fw5edxZXOj45NO+YKE/iKTPcfg
 09SZYERxrOpjqNzTcyn1N4Ocbtb/f8cLaZH9w0q1DUOg1w2sEBRyvVLkT8xIVMTlHxNW
 Xbvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHCIHYFsVlZ2d9UqVyZEp+MyjgNc83Dd0F24k48Qb8xfvUfNWwzgdKfjup6owe0mcWra97oLx8bQJc@nongnu.org
X-Gm-Message-State: AOJu0YzNApkkuttSpUnxhKyKFedJuUgjCygWmN2nAwnIrfw6wB0Xqgut
 yVVSbqGIbeUWj9gOHb2Vq7FTfRC/u9S7MRxI81en/uEia6RaRVVqG6Wq5Bu661d5gREU55rH9Ob
 r4CUpyWNPow2ycyhEEcD4vz8wKq2xKNOfd5mnhwxgJNJTD4yEe2imzcQwCIe0V5CyYKUTVqE/n5
 ScDw3QgV+rvGEPVZj4lJyR7nGS9Z4=
X-Gm-Gg: ASbGncvhg5KA25OZDdZf66h77Q99iwquUxE94bPtPHw6Jqy3HFba+ppzejw/CAqMOdy
 hyJ4+dYeArOlVUSpFfkfAlmS5+mGs3tZRdIdF0vIyoGAm1XCHB+/ceHTAsfJWOQMcL116kmUeI7
 I=
X-Received: by 2002:a17:907:9691:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-ac252a886dbmr2850322566b.15.1741864167257; 
 Thu, 13 Mar 2025 04:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELUIBo+XMBKjtDjf9ffKjzwhGCnwBaon95kO5nvewWS0NJrqor+OzNwzcKmw+nCXMb1L9f4a49Yrx7CC0iiJ4=
X-Received: by 2002:a17:907:9691:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-ac252a886dbmr2850318066b.15.1741864166851; Thu, 13 Mar 2025
 04:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
In-Reply-To: <Z9K6nrGwnyob9tED@8bytes.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 13 Mar 2025 16:39:15 +0530
X-Gm-Features: AQ5f1JqB80Ap8u66D15bJYTha1CNE7cZMkmRYpVZE6xkUbQguN_7eMiI8l2Fu1s
Message-ID: <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 13, 2025 at 4:29=E2=80=AFPM J=C3=B6rg R=C3=B6del <joro@8bytes.o=
rg> wrote:
>
> Hi Ani,
>
> Don't get me wrong, I really like the general idea of vmfwupdate as
> a way to implement BYOFW, and for non-confidential VMs it is great. I
> just think the interface design is not well suited for confidential VMs
> yet and want to discuss how to change that.
>
> On Thu, Mar 13, 2025 at 04:02:11PM +0530, Ani Sinha wrote:
> > Forgive my ignorance, today none of the hyperscalers use IGVM to
> > define this. How then the expected launch measurement is derived?
>
> There is at least one Hyperscaler which uses IGVM, another implemented
> support for it in their hypervisor (although not for a BYOFW feature,
> yet). In my view this problem is still widely being worked on today by
> the CSPs. If you are lucky, and since the firmware is provided by the
> CSP as well, they publish expected launch measurments for each of their
> coco platforms.
>
> > Our vmfwupdate interface does not make any attempt to define this in
> > any way or make this an ABI. Its intentionally open ended. It's really
> > up to the guest to set this up any way they wish. This is the same
> > when the guest provides the igvm file that defines the above.
>
> Without a way to supply user-defined setup steps of a confidential VM
> the host-VMM has to hardcode them. And that hardcoded behavior becomes
> ABI implicitly, because any change to this behavior will also change the
> actual launch measurements, potentially breaking existing users.

Right so what we are proposing is generic enough so that if the VM
wants to use an IGVM container as opposed to an actual firmware image
in a FUKI, that is totally possible. Then you need to have that IGVM
setup the memory in a well defined way like you suggest. Sure, the
IGVM is not passed through a command line but it can be loaded by the
guest in a well defined memory location and then its instructions can
be executed.
In our proposal, we do not want to dictate how the guest would want to
do that. So hopefully you see now that IGVM and our approach is not
mutually exclusive but can be complementary to each other.

>
> This happened in the past already when KVM decided to hardcode a
> different set of SEV-Features by enabling Debug-Swap. I strongly believe
> that with KVM/QEMU we should work in a direction which makes those
> breakages unlikely in the future.
>
> Regards,
>
>         Joerg
>


