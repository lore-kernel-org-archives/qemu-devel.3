Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1734CC54F32
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 10:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uImWi-0006Qt-Vi; Sat, 24 May 2025 06:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uImWg-0006QR-Hl
 for qemu-devel@nongnu.org; Sat, 24 May 2025 06:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uImWe-0004wH-Jt
 for qemu-devel@nongnu.org; Sat, 24 May 2025 06:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748084087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FM8zIdqMag/fILXWK49jB4inIeNGGe7lrWhZ9Yj9lIU=;
 b=fODY1SyNkuPtqlRDNmPCiGW08NC0r/MT8oa4ijF//mEyNUsjQmwowgb/kJoneka9tf6lN/
 bFh9TIvqe0wW/G4N1MBrmRFDA8SAkG7p+zjUxlMEyo8QcwtuDDMx6Gg1Pt+isbYrFQKKtC
 ipKZRzGpoO6pEbQJ3r8Q+skdWTNFb84=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Tx9xUvAJNPeK-MArRu5q_w-1; Sat, 24 May 2025 06:54:45 -0400
X-MC-Unique: Tx9xUvAJNPeK-MArRu5q_w-1
X-Mimecast-MFC-AGG-ID: Tx9xUvAJNPeK-MArRu5q_w_1748084083
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a364d121ccso426743f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 03:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748084083; x=1748688883;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FM8zIdqMag/fILXWK49jB4inIeNGGe7lrWhZ9Yj9lIU=;
 b=pSDetpF1pmHH9alhoPzWPgzlQkLB3+mprb7DEHWTCfK3GttsCxhdDMV2MN2XxpPgmK
 G/h+1UpkObFM7sz+06gSgagr9jqNpju7HJVr6jJa+wIyDNf2IDF+gjG8u0JWZ0ttgU6g
 YeWsD+jFhRUbPG3S6wS++DpxRnZk+qF0G4N9qxJSiCCo7Quouw2Kcsu+djpFC+7B1oQy
 xYh4aqhzAGNbgUeMo7vEJbvfDOGo+8Cu0Hen7VgdmTN22F8lS4QspobNGO2Uw467GBSe
 vvoClGgklEvsa2xmuL/P+JZQZPzYiDKnnDs7FX5zZ6J8T6+FrTEyn/fGujOwUrLESXRc
 GegQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzEOHGaCehsmw/34cFJqNlsxSqHMdKIO81ll+tm7r6X3Exe4eECV1pXoD2ZefuOnGIoTVOG9GlJjtR@nongnu.org
X-Gm-Message-State: AOJu0YxpaN3lllOU3KCdPhmrSXy7AeH69Qv3x996qD+/AmI195G5jLN3
 tOyU/cN0OcbP37lVVj0utbg44YyBDn0EGNK7jutAZR9C4OLJ0WwsUjluZ1h+uEgz/+mSR/LO63V
 H2cwgzHn+/RgBJHGDnyzOM/KpQfHPHBI/GOfjyxsXvRsMX2dzHegRZ9//
X-Gm-Gg: ASbGncsHY9y6cdawUNeXHrFF3eJbpTHwJ6cU0nKTKczrJsyuuR8ozvZCL9iVa/Z8WWp
 MPI4ChEyLyizC2Ee+uDSyYefE1TrcwAVHttkJa7qnlbELMOayWyZ1n2ulhyT2n5BAL0/fOLeI3c
 TwgjKC1gVmD2ifXTYAuGQ6rrhiPeblaElE7cJdU2Jfl5Wkq36m0UzQDkl2jcYWwPXt+YmUgwuM+
 VnB33lNdZLO75GMgo3W4VGdk2Opiq88KTTp0VAwsDKmI6h39BPrnsxcN8kcyp0NM71gEdzbMwPG
 pVL/SQ==
X-Received: by 2002:a05:6000:4023:b0:3a3:621a:d3c2 with SMTP id
 ffacd0b85a97d-3a4cb49f1a6mr2013461f8f.58.1748084082790; 
 Sat, 24 May 2025 03:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX8EYuox5coAhaaceVZdowhqgUDiksbKKbuhFPFHNZEmFE1/adce5XjwP2h0QUT5O2igSMFA==
X-Received: by 2002:a05:6000:4023:b0:3a3:621a:d3c2 with SMTP id
 ffacd0b85a97d-3a4cb49f1a6mr2013443f8f.58.1748084082307; 
 Sat, 24 May 2025 03:54:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c002e937sm6976914f8f.29.2025.05.24.03.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 03:54:41 -0700 (PDT)
Date: Sat, 24 May 2025 06:54:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org
Subject: Re: [PATCH 08/22] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Message-ID: <20250524065230-mutt-send-email-mst@kernel.org>
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-9-eric.auger@redhat.com>
 <e1ec0e15-ad26-456b-a8d7-16f683290651@linaro.org>
 <ed823ddc-6faa-42dc-bae5-c765d21c3cca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed823ddc-6faa-42dc-bae5-c765d21c3cca@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 21, 2025 at 06:12:34PM +0200, Eric Auger wrote:
> Hi Gustavo,
> 
> On 5/20/25 4:09 PM, Gustavo Romero wrote:
> > Hi Eric,
> >
> > On 5/14/25 14:00, Eric Auger wrote:
> >> gpex build_host_bridge_osc() and x86 originated
> >> build_pci_host_bridge_osc_method() are mostly identical.
> >>
> >> In GPEX, SUPP is set to CDW2 but is not further used. CTRL
> >> is same as Local0.
> >>
> >> So let gpex code reuse build_pci_host_bridge_osc_method()
> >> and remove build_host_bridge_osc().
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> The DSDT diff  is given below:
> >> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
> >> index 3224a56..fa7558e 100644
> >> --- a/dsdt.dsl_before
> >> +++ b/dsdt.dsl_after_osc_change
> >> @@ -5,13 +5,13 @@
> >>    *
> >>    * Disassembling to symbolic ASL+ operators
> >>    *
> >> - * Disassembly of dsdt.dat, Mon Apr  7 05:33:06 2025
> >> + * Disassembly of dsdt.dat, Mon Apr  7 05:37:20 2025
> >>    *
> >>    * Original Table Header:
> >>    *     Signature        "DSDT"
> >> - *     Length           0x00001A4F (6735)
> >> + *     Length           0x00001A35 (6709)
> >>    *     Revision         0x02
> >> - *     Checksum         0xBF
> >> + *     Checksum         0xDD
> >>    *     OEM ID           "BOCHS "
> >>    *     OEM Table ID     "BXPC    "
> >>    *     OEM Revision     0x00000001 (1)
> >> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ",
> >> "BXPC    ", 0x00000001)
> >>                   {
> >>                       CreateDWordField (Arg3, 0x04, CDW2)
> >>                       CreateDWordField (Arg3, 0x08, CDW3)
> >> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
> >> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> >> -                    CTRL &= 0x1F
> >> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> >> +                    Local0 &= 0x1F
> >>                       If ((Arg1 != One))
> >>                       {
> >>                           CDW1 |= 0x08
> >>                       }
> >>
> >> -                    If ((CDW3 != CTRL))
> >> +                    If ((CDW3 != Local0))
> >>                       {
> >>                           CDW1 |= 0x10
> >>                       }
> >>
> >> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
> >> -                    Return (Arg3)
> >> +                    CDW3 = Local0
> >>                   }
> >>                   Else
> >>                   {
> >>                       CDW1 |= 0x04
> >> -                    Return (Arg3)
> >>                   }
> >> +
> >> +                Return (Arg3)
> >>               }
> >>
> >>               Method (_DSM, 4, NotSerialized)  // _DSM:
> >> Device-Specific Method
> >
> > The problem I face with diffs in the commit body is that tools like
> > b4, which are
> > based on git am, get very confused on how to handle it. I'm surprised
> > nobody ever
> > complained about it. I'm wondering if there is any catch on it,
> > because I have to
> > edit commits like this manually, removing the diff, to make it finally
> > apply to
> > the series. Anyways, do you mind at least removing the valid diff
> > header, like:
> >
> >> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
> >> index 3224a56..fa7558e 100644
> >> --- a/dsdt.dsl_before
> >> +++ b/dsdt.dsl_after_osc_change
> >
> > from the commit message so it doesn't confuse b4?
> Thank you for reporting the issue. in tests/qtest/bios-tables-test.c it
> is written at the top that we shall put the diffs in disasembled ACPI
> content in the commit msg. I will look for previously landed patches and
> see whether the current layout can be fixed.
> 
> Cheers
> 
> Eric


Eric, to clarify, the diff is supposed to go into commit log,
not after ---.
This will make it apply cleanly.
Also, removing the "index" line as well as date diff at least is a good
idea: the diff should be clean, not include irrelevant information.

Pls feel free to clarify the text in tests/qtest/bios-tables-test.c



> >
> >
> >> ---
> >>   hw/pci-host/gpex-acpi.c | 60 +++--------------------------------------
> >>   1 file changed, 4 insertions(+), 56 deletions(-)
> >>
> >> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> >> index f1ab30f3d5..98c9868c3f 100644
> >> --- a/hw/pci-host/gpex-acpi.c
> >> +++ b/hw/pci-host/gpex-acpi.c
> >> @@ -50,60 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml
> >> *dev, uint32_t irq,
> >>       }
> >>   }
> >>   -static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
> >> -{
> >> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
> >> -
> >> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> >> -    aml_append(method,
> >> -        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> >> -
> >> -    /* PCI Firmware Specification 3.0
> >> -     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
> >> -     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
> >> -     * identified by the Universal Unique IDentifier (UUID)
> >> -     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
> >> -     */
> >> -    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
> >> -    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
> >> -    aml_append(ifctx,
> >> -        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> >> -    aml_append(ifctx,
> >> -        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> >> -    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
> >> -    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> >> -
> >> -    /*
> >> -     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
> >> -     * and PCIeHotplug depending on enable_native_pcie_hotplug
> >> -     */
> >> -    aml_append(ifctx, aml_and(aml_name("CTRL"),
> >> -               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 :
> >> 0x0)),
> >> -               aml_name("CTRL")));
> >> -
> >> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> >> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> >> -                              aml_name("CDW1")));
> >> -    aml_append(ifctx, ifctx1);
> >> -
> >> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"),
> >> aml_name("CTRL"))));
> >> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
> >> -                              aml_name("CDW1")));
> >> -    aml_append(ifctx, ifctx1);
> >> -
> >> -    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
> >> -    aml_append(ifctx, aml_return(aml_arg(3)));
> >> -    aml_append(method, ifctx);
> >> -
> >> -    elsectx = aml_else();
> >> -    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
> >> -                               aml_name("CDW1")));
> >> -    aml_append(elsectx, aml_return(aml_arg(3)));
> >> -    aml_append(method, elsectx);
> >> -    return method;
> >> -}
> >> -
> >> -static Aml *build_host_bridge_dsm(void)
> >> +static Aml *build_pci_host_bridge_dsm_method(void)
> >>   {
> >>       Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> >>       Aml *UUID, *ifctx, *ifctx1, *buf;
> >> @@ -134,8 +81,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml
> >> *dev,
> >>       aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> >>       aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> >>       /* Declare an _OSC (OS Control Handoff) method */
> >> -    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> >> -    aml_append(dev, build_host_bridge_dsm());
> >> +    aml_append(dev,
> >> +              
> >> build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
> >> +    aml_append(dev, build_pci_host_bridge_dsm_method());
> >>   }
> >>     void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >
> > Otherwise:
> >
> > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> >
> >
> > Cheers,
> > Gustavo
> >


