Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB6C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJn7-0007Se-IU; Tue, 20 May 2025 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uHJn1-0007SU-DE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uHJmz-0008LZ-6Y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747735295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBC6/ifpa1Hxu+6vgLiGQNEssho44v+AyDML+CQ4c/s=;
 b=cshq41PedHhVF6BrKa0LcxM9f8G8CQpCjkgzFmp5MdO8JvRL3ltJBWhy+FEJUgHb6/V4za
 CqAfj1lK4qL7d5Kwhy/xEnGjPLRLv3g64f98PSX47OIZ4dQO8hM5KUodftwqKC14e6I5o5
 hGrjJ3Hmwnjicp5NleyHfWsJgZ6sCgY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-Z3YZhO_qP9mY7S2E4JpH9g-1; Tue, 20 May 2025 06:01:34 -0400
X-MC-Unique: Z3YZhO_qP9mY7S2E4JpH9g-1
X-Mimecast-MFC-AGG-ID: Z3YZhO_qP9mY7S2E4JpH9g_1747735293
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b1ffc678adfso3484853a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 03:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747735293; x=1748340093;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBC6/ifpa1Hxu+6vgLiGQNEssho44v+AyDML+CQ4c/s=;
 b=gKEJ8O/yqqjHX3VhHqiogJBpfcb+RhR/3QHuXx2GNwRKY+drqmfwik3Q08Eb73podi
 oAqjUa34+DbcrHR3+qT4FLsTjq7tAUgZQ7ht33g/AWwhdZM48W5SLrDabv06PObWykzJ
 gA2hPg27/NCviabc+vLpryBW0xdUPLV4xesqqTgOoqwkIsWIGa36DzGn9C4VaQgiwuCe
 XMZz1uoAAFlRFTWrPvW/rPHXs80AQMHgexzoCHlSvReFDLObsQkmtSOJIQvvomgOUd+/
 gqnnGYY1KU8CsA7FR75dr516VyIZEYDIIeJHkfNwP+Sh3wNL3zVHZU5OJTzhcQsd4N/o
 8rKg==
X-Gm-Message-State: AOJu0Yzs+oP+Y0DV7zutzfbSOMnpgnSfyQ5GGwqXTgpe2UOqKa0vGWmi
 T9HLTGSskoEw5RCzknbVsODNbuzF4jPXqNEC9oV/rEf3FZyV8K1/sMuMk/A+XPAP3Y/YKKOXW8E
 c2xmrVp8ZgzoGYlJwXPAIGt2kDlmSfOt/uhSj7gPpNZRrUCLTV6wharVZ
X-Gm-Gg: ASbGnctpC9/Z/2lw/iixyUibhXTBxBmoRHmWfjAf/YMkmTLkp4X8MT0aex8uhkr+ct+
 FCpizFXK9SCrGKmwFDwmrXaLs/d5D33/sNAjh6ZLaIjkVWn8XHmB1JZvRhPxGfTHoX6aD2kIiTf
 fLmxiecWlvIHGXKSLLYmYCJ2km9npwuJhte0GqIrUXQpAF+J2s7ClUI/h/zw9GlTLNYCoEX7XwU
 b7swSIrC6EjvyrE0qHG4PLYYL+Ho/QX53bYJQfSmDTYUykTOHnO62ex19TjhwZecKNA9viCXg5V
 1fMJm66p6M/izuwnhK/greeWrcb/
X-Received: by 2002:a17:903:2449:b0:231:c2e8:89df with SMTP id
 d9443c01a7336-231d4535a98mr250550275ad.28.1747735292957; 
 Tue, 20 May 2025 03:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ZP6sRj7q7xM28TBTTsVS1/Qkd6+NDkV0uROoQuiAwwO6BPBJDSev6tTqYXV1Wqg6e6rU5w==
X-Received: by 2002:a17:903:2449:b0:231:c2e8:89df with SMTP id
 d9443c01a7336-231d4535a98mr250549905ad.28.1747735292545; 
 Tue, 20 May 2025 03:01:32 -0700 (PDT)
Received: from smtpclient.apple ([203.163.235.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e977f6sm73349505ad.131.2025.05.20.03.01.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 May 2025 03:01:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH v7 00/16] Introduce support for IGVM files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
Date: Tue, 20 May 2025 15:31:13 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Berrange <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Joerg Roedel <jroedel@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFD6A252-EF5D-453F-B4F0-2911DB693C9E@redhat.com>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 27 Feb 2025, at 7:08=E2=80=AFPM, Roy Hopkins =
<roy.hopkins@randomman.co.uk> wrote:
>=20
> Here is v7 of the set of patches to add support for IGVM files to =
QEMU. This is
> based on commit 40efe733e10cc00e4fb4f9f5790a28e744e63c62 of qemu.
>=20
> Firstly, apologies for the amount of time between the last version and =
this one.
> I moved roles to a different company and, although I always planned to =
see this
> patch series to completion, it took a while before I found time to =
setup a
> development environment and be in a position to send a new version. I =
will
> continue this series using a personal email address for now, hence the =
change
> to the author and signed-off-by emails.
>=20
> The only changes in this version are to rebase on the current master =
branch and
> update commit metadata, including Signed-Off-By and Author emails for =
my
> replacement email address, and to include the final Reviewed-By that =
were added
> in the last review. There were no requested changes on the previous =
version [1]
> so I believe this series is ready to merge.
>=20
> As always, thanks to those that have been following along, reviewing =
and testing
> this series. This v7 patch series is also available on github: [2]
>=20
> For testing IGVM support in QEMU you need to generate an IGVM file =
that is
> configured for the platform you want to launch. You can use the =
`buildigvm`
> test tool [3] to allow generation of IGVM files for all currently =
supported
> platforms. Patch 11/17 contains information on how to generate an IGVM =
file
> using this tool.
>=20
> Changes in v7:

It seems no v8 was sent out?=20
=
https://patchew.org/search?q=3Dproject%3AQEMU+Introduce+support+for+IGVM+f=
iles

What is the status of this patch set to support IGVM in QEMU? =20

>=20
> * Update version numbers for IGVM support to 10.0
> * Add Reviewed-by to relevant commits.
> * Update Author email and sign-offs to my new email address
>=20
> Patch summary:
>=20
> 1-11: Add support and documentation for processing IGVM files for SEV, =
SEV-ES,
> SEV-SNP and native platforms.=20
>=20
> 12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file.=20
>=20
> 16: Add pre-processing of IGVM file to support synchronization of =
'SEV_FEATURES'
> from IGVM VMSA to KVM.
>=20
> [1] Link to v6:
> =
https://lore.kernel.org/qemu-devel/cover.1727341768.git.roy.hopkins@suse.c=
om/
>=20
> [2] v7 patches also available here:
> https://github.com/roy-hopkins/qemu/tree/igvm_master_v7
>=20
> [3] `buildigvm` tool v0.2.0
> https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0
>=20
> Roy Hopkins (16):
>  meson: Add optional dependency on IGVM library
>  backends/confidential-guest-support: Add functions to support IGVM
>  backends/igvm: Add IGVM loader and configuration
>  hw/i386: Add igvm-cfg object and processing for IGVM files
>  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict =
with
>    IGVM
>  sev: Update launch_update_data functions to use Error handling
>  target/i386: Allow setting of R_LDTR and R_TR with
>    cpu_x86_load_seg_cache()
>  i386/sev: Refactor setting of reset vector and initial CPU state
>  i386/sev: Implement ConfidentialGuestSupport functions for SEV
>  docs/system: Add documentation on support for IGVM
>  docs/interop/firmware.json: Add igvm to FirmwareDevice
>  backends/confidential-guest-support: Add set_guest_policy() function
>  backends/igvm: Process initialization sections in IGVM file
>  backends/igvm: Handle policy for SEV guests
>  i386/sev: Add implementation of CGS set_guest_policy()
>  sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2
>=20
> backends/confidential-guest-support.c       |  43 +
> backends/igvm-cfg.c                         |  52 ++
> backends/igvm.c                             | 967 ++++++++++++++++++++
> backends/igvm.h                             |  23 +
> backends/meson.build                        |   5 +
> docs/interop/firmware.json                  |  30 +-
> docs/system/i386/amd-memory-encryption.rst  |   2 +
> docs/system/igvm.rst                        | 173 ++++
> docs/system/index.rst                       |   1 +
> hw/i386/pc.c                                |  12 +
> hw/i386/pc_piix.c                           |  10 +
> hw/i386/pc_q35.c                            |  10 +
> hw/i386/pc_sysfw.c                          |  31 +-
> include/hw/i386/x86.h                       |   3 +
> include/system/confidential-guest-support.h |  88 ++
> include/system/igvm-cfg.h                   |  47 +
> meson.build                                 |   8 +
> meson_options.txt                           |   2 +
> qapi/qom.json                               |  17 +
> qemu-options.hx                             |  28 +
> scripts/meson-buildoptions.sh               |   3 +
> target/i386/cpu.h                           |   9 +-
> target/i386/sev.c                           | 850 +++++++++++++++--
> target/i386/sev.h                           | 124 +++
> 24 files changed, 2454 insertions(+), 84 deletions(-)
> create mode 100644 backends/igvm-cfg.c
> create mode 100644 backends/igvm.c
> create mode 100644 backends/igvm.h
> create mode 100644 docs/system/igvm.rst
> create mode 100644 include/system/igvm-cfg.h
>=20
> --=20
> 2.43.0
>=20


