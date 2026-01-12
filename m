Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B016C9EC80
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 12:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfH8E-0000Uh-9W; Mon, 12 Jan 2026 07:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vfH89-0000PM-Eh
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:34:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vfH85-00050l-Mu
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 07:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768221278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LP28G4NUOFSwzs2iYvgDZdy+2UTu3gq6I+xV1I8lLw=;
 b=PMF8bA+pv5sPUICHQ933kQJ1nJvZHa/ikDqAKQq1WHQXDXT6z2SYKMQIKpAQ7eSiOkUmtm
 2N72LjpSDFp76BDmSscoJiNNCzbu7VScr+vzI3y5AEjlQEndCE+4vFLTpzjyM1rCpZuzAm
 KcREtpmrv62+6ehteiRMZaBKMICGC4w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-cuGjvNZ8M2qrsl1SXiCVzQ-1; Mon, 12 Jan 2026 07:34:36 -0500
X-MC-Unique: cuGjvNZ8M2qrsl1SXiCVzQ-1
X-Mimecast-MFC-AGG-ID: cuGjvNZ8M2qrsl1SXiCVzQ_1768221276
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d3ffa98fcso42057925e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 04:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768221275; x=1768826075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LP28G4NUOFSwzs2iYvgDZdy+2UTu3gq6I+xV1I8lLw=;
 b=sMeJuU4JefodfKETORMjxSH7XNHijiik4ubuwqF5Q9uOiZgg1DZ1Nk/EFAb9R+XZmA
 2kijveCEjKsG5Jdy0d/Ajy3rNeFEqOiup/ybBPpbzo/nQN8FXMI3VG9AF3/tpJHC+gsA
 UTMwVotfYkSRg09hkMaaPcSVpKOsgOG1cVTg5I00lFH41wfza9e5BSgBuIrC3cCYWwfA
 nmB6bnl3C90uMe3jzLBzOlhGtmhSd4SGaor/mUAp7FQpyQ5gB1RZtu9pc8b3h1jKL1fA
 dmLtF3BFJAgBAA6NPPXfAAW0dAgkm7b0ebC2Ga90/jq8Ok2m2hlymP1YQ3kliIVH8uR8
 bQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768221275; x=1768826075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LP28G4NUOFSwzs2iYvgDZdy+2UTu3gq6I+xV1I8lLw=;
 b=gT7zOkW+u7wnRsb7qjAegvUN04F527zT3Ax+o0BGUU8M+BaRgih93sglFmY7PgXKQt
 cu2TMHTq7jG629QuCRDBusjnG2yo3NxB5Q8/WYJvjIYAzC0ezQnM4caL7VW2w0Murb1k
 2daxrQ5D+19cmR51asd+Uqu6imXGF1p+ajxti45jK1gYKvZFOzqmNPsrb9naHQoNvbLK
 AXgZ9lW4cTGSssHfh1WFySNeSdB579joALDtM5zy60liU4ooeiDMCEctPsfKj5Ammrnz
 W+lMhZRrnIJJwIj9ZYUp4WRG1vKM6591dYDFK4mRI2Ndyu6I87C7/yRrRDT8DzllE/P9
 2VmQ==
X-Gm-Message-State: AOJu0YxRdv/TQRnP+GOIl1ZCmn1M/TQ3tQ5GZh+yh9Mp/xIbw02ehako
 J2aYwp8N5hb7AdhJOGcFnXSIpvRRzwKDwtPvxuUBDXleHDw8GLWzvKNqOrkUwI+lkF+uoUuQ1Bh
 WytyuU5PVOSH/kevX0IfE4W10pwFGliU5mzjPIZLLyS/UgMrX5n7bfKSc
X-Gm-Gg: AY/fxX7kxk6yVVRW1uCQjCXAYetWFrwE4XaUm6+tbjfs9sKG2GRAhZgGt09XQesQgYk
 Iq45eqvSeD5jfg/eBJ1t966S8xXH1yPfZ2kySUoa+IYDHYbCxpZx6qd9CyEes/Y3jxTu1KofwFk
 ffohuIvyFYbaNsJzUbYGSIuMepL4F8QIJlN7TOgUWos5UiZZY42zaS2OSgEPvkbkgE70b+L82sE
 N8k723F2GtROHB1Uj2eWJ95xBQyL9ANrRrwoUGQUUvgGDOeA6Iw8+xQEiCgx5lafTHrSDHVjVZi
 rHf2oTFOxQyychKirYPg2QBfmnx8CnM4E/HIdYGk3COxceZxlPDDu1QMZtospAFw+FoSJ1dFBe5
 e6KXBAZi5guucw7d0ksQfpQ==
X-Received: by 2002:a05:600c:19cc:b0:47a:7fd0:9f01 with SMTP id
 5b1f17b1804b1-47d84b21227mr221225835e9.16.1768221275472; 
 Mon, 12 Jan 2026 04:34:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSIv/YVrI3F1CuJ1neX54aCZ2PcfOjaqDop2oAdNGNWB0y923eY7phci0m/71Xv8yG33sjWQ==
X-Received: by 2002:a05:600c:19cc:b0:47a:7fd0:9f01 with SMTP id
 5b1f17b1804b1-47d84b21227mr221225515e9.16.1768221275033; 
 Mon, 12 Jan 2026 04:34:35 -0800 (PST)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87167832sm136279605e9.7.2026.01.12.04.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 04:34:34 -0800 (PST)
Date: Mon, 12 Jan 2026 13:34:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, Joerg
 Roedel <joerg.roedel@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 0/6] igvm: Supply MADT via IGVM parameter
Message-ID: <20260112133432.0a1fb87f@imammedo-mac>
In-Reply-To: <20260109143413.293593-1-osteffen@redhat.com>
References: <20260109143413.293593-1-osteffen@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-apple-darwin24.5.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri,  9 Jan 2026 15:34:07 +0100
Oliver Steffen <osteffen@redhat.com> wrote:

> When launching using an IGVM file, supply a copy of the MADT (part of the ACPI
> tables) via an IGVM parameter (IGVM_VHY_MADT) to the guest, in addition to the
> regular fw_cfg mechanism.

I've had some questions wrt using MADT in previous version,
and possible ways to avoid issues.
not of those where addressed though.

So questions stay the same, see:
https://patchew.org/QEMU/20251211103136.1578463-1-osteffen@redhat.com/#20251219140933.7b102fc5@imammedo

> 
> The IGVM parameter can be consumed by Coconut SVSM [1], instead of relying on
> the fw_cfg interface, which has caused problems before due to unexpected access
> [2,3]. Using IGVM parameters is the default way for Coconut SVSM; switching
> over would allow removing specialized code paths for QEMU in Coconut.
> 
> In any case OVMF, which runs after SVSM has already been initialized, will
> continue reading all ACPI tables via fw_cfg and provide fixed up ACPI data to
> the OS as before.
> 
> This series makes ACPI table building more generic by making the BIOS linker
> optional. This allows the MADT to be generated outside of the ACPI build
> context. A new function (acpi_build_madt_standalone()) is added for that. With
> that, the IGVM MADT parameter field can be filled with the MADT data during
> processing of the IGVM file.
> 
> Generating the MADT twice (IGVM processing and ACPI table building) seems
> acceptable, since there is no infrastructure to obtain the MADT out of the ACPI
> table memory area during IGVM processing.
> 
> [1] https://github.com/coconut-svsm/svsm/pull/858
> [2] https://gitlab.com/qemu-project/qemu/-/issues/2882
> [3] https://github.com/coconut-svsm/svsm/issues/646
> 
> v3:
> - Pass the machine state into IGVM file processing context instead of MADT data
> - Generate MADT from inside the IGVM backend
> - Refactor: Extract common code for finding IGVM parameter from IGVM parameter handlers
> - Add NULL pointer check for igvm_get_buffer()
> 
> v2:
> - Provide more context in the message of the main commit
> - Document the madt parameter of IgvmCfgClass::process()
> - Document why no MADT data is provided the process call in sev.c
> 
> Based-on: <20251118122133.1695767-1-kraxel@redhat.com>
> Signed-off-by: Oliver Steffen <osteffen@redhat.com>
> 
> Oliver Steffen (6):
>   hw/acpi: Make BIOS linker optional
>   hw/acpi: Add standalone function to build MADT
>   igvm: Add missing NULL check
>   igvm: Add common function for finding parameter entries
>   igvm: Pass machine state to IGVM file processing
>   igvm: Fill MADT IGVM parameter field
> 
>  backends/igvm-cfg.c       |   2 +-
>  backends/igvm.c           | 169 +++++++++++++++++++++++++-------------
>  hw/acpi/aml-build.c       |   7 +-
>  hw/i386/acpi-build.c      |   8 ++
>  hw/i386/acpi-build.h      |   2 +
>  include/system/igvm-cfg.h |   3 +-
>  include/system/igvm.h     |   3 +-
>  target/i386/sev.c         |   2 +-
>  8 files changed, 132 insertions(+), 64 deletions(-)
> 


