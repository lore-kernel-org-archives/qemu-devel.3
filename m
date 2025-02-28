Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4447C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnweQ-0008My-7K; Fri, 28 Feb 2025 04:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tnweO-0008MX-BK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tnweM-00019C-AE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740734836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rl0xpbNJQNrw4u13YUVtVf6l32NqVRw5Cce3Q1hcf4I=;
 b=jVreP9icxzAjkee8F7Lon9NMqZGerXxnN0J9F0p6GW+RwVrjA0e0zdCZfRjbG6mTTbBHUz
 c4GKckQScjkvWsHqpRfCWIzw1X+O+3m7jX+yx/hFjnX51qfsdD0wa7XWx/NE6zEtxt884z
 YNhER7Q+sUFJ6EgBuCfrMJQ7PYzfrww=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-HDeWyxHFNuuwCWFWO3PIJA-1; Fri, 28 Feb 2025 04:27:11 -0500
X-MC-Unique: HDeWyxHFNuuwCWFWO3PIJA-1
X-Mimecast-MFC-AGG-ID: HDeWyxHFNuuwCWFWO3PIJA_1740734831
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e60b75f87ffso657747276.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 01:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740734831; x=1741339631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rl0xpbNJQNrw4u13YUVtVf6l32NqVRw5Cce3Q1hcf4I=;
 b=h1i7RuYQV+nInAJ4wK9BBhBnpaMOzjLqRiR62KOeaxRc7EsQcJUXQgGdSU7h9GH/sJ
 Ym/MCiMMQhHEzqoMNscSOQDhnk3OaCjz0DgtwKhexpOzqSkLzxxG+frRP22CnlI9g3Kr
 n3H9tNnEjIKz6vfMPkqR0ZqxCjFv8FE066qtXuDBRYgfJ0OPTCZmso4n17b0jNiiUpKc
 n6MoYLktkYFeg88lQet7EjD2HEjO1ST+jcskNDutgmbb7L2cqj4CLH0ia7uvpu/gmc/6
 PPi3+2AkNFo2lVV7gbpzc8D9FpAtdXSE5G795K3PPCL2uOKjjAa9J0f3oUd8rTOFO8CI
 XQpA==
X-Gm-Message-State: AOJu0YwibOhgmnWPgfxdsYbEKSwKZNtwxcZNRn6n1W3wycwEWous5vzs
 T5Y3+yrKUnFQ9rx0Wo4w88oZ4YmeyOaEFwNmBhjT94A9OPVINCruxQCP8Gw/llMmOMN3pch2kyo
 Sl0HCZgbmwALrlUART3WKIEfQhx5lgU9bXpwN9VsLSqT3P2qjsx7fO+glafNuHRjR3AuKpNLmyD
 /zUUsX3S0ggEJgPeB1cumKKE5WMfI=
X-Gm-Gg: ASbGnctJFc2YjCHc1z0YHzQ5slg/zoNf+wvG88csabpTpnUeBdbAYikfQnhVzPpXg+I
 Bio8YastgNvJMkCJcgVIQqNTIzgyjiBM63hiH7vwztb8N5Rsvdn17EIvWUlxEFhRemDGT5cZd
X-Received: by 2002:a05:6902:218b:b0:e60:929a:51ca with SMTP id
 3f1490d57ef6-e60b2ebf1aamr2995301276.28.1740734831013; 
 Fri, 28 Feb 2025 01:27:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLip9su8r6JM3tXe/LSYJ7VeazkzLWvguo777jr27vpXgnBBssK35AHko02HYJEo/XIh1xAvpip25833NkAKQ=
X-Received: by 2002:a05:6902:218b:b0:e60:929a:51ca with SMTP id
 3f1490d57ef6-e60b2ebf1aamr2995292276.28.1740734830690; Fri, 28 Feb 2025
 01:27:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
 <ftgzr23cmis3sjwmbbfkw3ijrtythcwb3l6jg3aqsreebg46ll@mcm72sg3dbqs>
 <31de7209a08147e3c8d9fe3d17e118b727729587.camel@randomman.co.uk>
In-Reply-To: <31de7209a08147e3c8d9fe3d17e118b727729587.camel@randomman.co.uk>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 28 Feb 2025 10:26:59 +0100
X-Gm-Features: AQ5f1JrtjrJv7MN4-Wzj3jjEP9UsH-nTH6FggwlaI_3TEcOX_Ut7a9PXp53Q7Ew
Message-ID: <CAGxU2F4fqBN_0HSncRFLUkf3iC5RWn3RSFdi4bO75Zwv7UJPBQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Introduce support for IGVM files
To: Roy Hopkins <roy.hopkins@randomman.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P . Berrange" <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 Joerg Roedel <jroedel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On Thu, 27 Feb 2025 at 17:12, Roy Hopkins <roy.hopkins@randomman.co.uk> wrote:
>
> On Thu, 2025-02-27 at 16:32 +0100, Stefano Garzarella wrote:
> > Hi Roy,
> >
> > On Thu, Feb 27, 2025 at 01:38:08PM +0000, Roy Hopkins wrote:
> > > Here is v7 of the set of patches to add support for IGVM files to
> > > QEMU.  This is
> > > based on commit 40efe733e10cc00e4fb4f9f5790a28e744e63c62 of qemu.
> >
> > Thanks again for this work!
> >
> > I noticed that the last patch for this series is missing, also
> > patchew
> > didn't receive it:
> >
> > https://patchew.org/QEMU/cover.1740663410.git.roy.hopkins@randomman.co.uk/
> >
> > If you're using git-publish you can do:
> >
> > $ git publish --skip 16 -S \
> >      -R cover.1740663410.git.roy.hopkins@randomman.co.uk
> >
> > Thanks,
> > Stefano
> >
>
> Thanks Stefano. I had all sorts of problems getting git send-mail to
> send using my mail service provider. I've sorted it now and sent the
> missing patch.

Yeah, now the other attempts of patch 16 have also arrived xD

On Monday I'll go through the series, test it and come back!

Thanks,
Stefano

>
> Regards,
> Roy
>
> > >
> > > Firstly, apologies for the amount of time between the last version
> > > and this one.
> > > I moved roles to a different company and, although I always planned
> > > to see this
> > > patch series to completion, it took a while before I found time to
> > > setup a
> > > development environment and be in a position to send a new version.
> > > I will
> > > continue this series using a personal email address for now, hence
> > > the change
> > > to the author and signed-off-by emails.
> > >
> > > The only changes in this version are to rebase on the current
> > > master branch and
> > > update commit metadata, including Signed-Off-By and Author emails
> > > for my
> > > replacement email address, and to include the final Reviewed-By
> > > that were added
> > > in the last review. There were no requested changes on the previous
> > > version [1]
> > > so I believe this series is ready to merge.
> > >
> > > As always, thanks to those that have been following along,
> > > reviewing and testing
> > > this series. This v7 patch series is also available on github: [2]
> > >
> > > For testing IGVM support in QEMU you need to generate an IGVM file
> > > that is
> > > configured for the platform you want to launch. You can use the
> > > `buildigvm`
> > > test tool [3] to allow generation of IGVM files for all currently
> > > supported
> > > platforms. Patch 11/17 contains information on how to generate an
> > > IGVM file
> > > using this tool.
> > >
> > > Changes in v7:
> > >
> > > * Update version numbers for IGVM support to 10.0
> > > * Add Reviewed-by to relevant commits.
> > > * Update Author email and sign-offs to my new email address
> > >
> > > Patch summary:
> > >
> > > 1-11: Add support and documentation for processing IGVM files for
> > > SEV, SEV-ES,
> > > SEV-SNP and native platforms.
> > >
> > > 12-15: Processing of policy and SEV-SNP ID_BLOCK from IGVM file.
> > >
> > > 16: Add pre-processing of IGVM file to support synchronization of
> > > 'SEV_FEATURES'
> > > from IGVM VMSA to KVM.
> > >
> > > [1] Link to v6:
> > > https://lore.kernel.org/qemu-devel/cover.1727341768.git.roy.hopkins@suse.com/
> > >
> > > [2] v7 patches also available here:
> > > https://github.com/roy-hopkins/qemu/tree/igvm_master_v7
> > >
> > > [3] `buildigvm` tool v0.2.0
> > > https://github.com/roy-hopkins/buildigvm/releases/tag/v0.2.0
> > >
> > > Roy Hopkins (16):
> > >  meson: Add optional dependency on IGVM library
> > >  backends/confidential-guest-support: Add functions to support IGVM
> > >  backends/igvm: Add IGVM loader and configuration
> > >  hw/i386: Add igvm-cfg object and processing for IGVM files
> > >  i386/pc_sysfw: Ensure sysfw flash configuration does not conflict
> > > with
> > >    IGVM
> > >  sev: Update launch_update_data functions to use Error handling
> > >  target/i386: Allow setting of R_LDTR and R_TR with
> > >    cpu_x86_load_seg_cache()
> > >  i386/sev: Refactor setting of reset vector and initial CPU state
> > >  i386/sev: Implement ConfidentialGuestSupport functions for SEV
> > >  docs/system: Add documentation on support for IGVM
> > >  docs/interop/firmware.json: Add igvm to FirmwareDevice
> > >  backends/confidential-guest-support: Add set_guest_policy()
> > > function
> > >  backends/igvm: Process initialization sections in IGVM file
> > >  backends/igvm: Handle policy for SEV guests
> > >  i386/sev: Add implementation of CGS set_guest_policy()
> > >  sev: Provide sev_features flags from IGVM VMSA to KVM_SEV_INIT2
> > >
> > > backends/confidential-guest-support.c       |  43 +
> > > backends/igvm-cfg.c                         |  52 ++
> > > backends/igvm.c                             | 967
> > > ++++++++++++++++++++
> > > backends/igvm.h                             |  23 +
> > > backends/meson.build                        |   5 +
> > > docs/interop/firmware.json                  |  30 +-
> > > docs/system/i386/amd-memory-encryption.rst  |   2 +
> > > docs/system/igvm.rst                        | 173 ++++
> > > docs/system/index.rst                       |   1 +
> > > hw/i386/pc.c                                |  12 +
> > > hw/i386/pc_piix.c                           |  10 +
> > > hw/i386/pc_q35.c                            |  10 +
> > > hw/i386/pc_sysfw.c                          |  31 +-
> > > include/hw/i386/x86.h                       |   3 +
> > > include/system/confidential-guest-support.h |  88 ++
> > > include/system/igvm-cfg.h                   |  47 +
> > > meson.build                                 |   8 +
> > > meson_options.txt                           |   2 +
> > > qapi/qom.json                               |  17 +
> > > qemu-options.hx                             |  28 +
> > > scripts/meson-buildoptions.sh               |   3 +
> > > target/i386/cpu.h                           |   9 +-
> > > target/i386/sev.c                           | 850 +++++++++++++++--
> > > target/i386/sev.h                           | 124 +++
> > > 24 files changed, 2454 insertions(+), 84 deletions(-)
> > > create mode 100644 backends/igvm-cfg.c
> > > create mode 100644 backends/igvm.c
> > > create mode 100644 backends/igvm.h
> > > create mode 100644 docs/system/igvm.rst
> > > create mode 100644 include/system/igvm-cfg.h
> > >
> > > --
> > > 2.43.0
> > >
> >
>


