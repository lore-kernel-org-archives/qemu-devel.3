Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC01C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vib0l-0004l6-V9; Wed, 21 Jan 2026 11:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vib0a-0004je-Ik
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:24:42 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vib0W-0002QQ-RU
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:24:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E53160130;
 Wed, 21 Jan 2026 16:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84774C4CEF1;
 Wed, 21 Jan 2026 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769012674;
 bh=hzsMhai3Qf5qpFxmQ2bfSHLieOPGV76AdLJQZVg4J88=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EWSEogrNicqCJ7zIyxMqYgjMPgw2/XNGuJN+x0GAkObt3G2o2bVjzKynIMuRrWwsQ
 seQgvgwqznvYcW2m+L0oR89TON1qDkHxZ8zcKaiH7fqbb/olHGVlKD4tzJsxUWZM/8
 PlbaxKPyGFzZROPvDJRCuRFZQy/h0CxUchKcn5kV9ilD4XDd7oW6Csx3hgk/+BlwdG
 xhihAdnIHgc02C1OAiwTJlQgToPekklOkZL9syx/uMeQ0ONG7d/lytCw6NS/SBrctM
 KrqubiWhl6fnABQQLkl6RdhufkKJ/Glf2072Azr6qOFWXG4C+UWz6z5n4pEHVzRx1k
 zTKx1pFCv34tA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vib0S-00000003u5H-2Ixb; Wed, 21 Jan 2026 17:24:32 +0100
Date: Wed, 21 Jan 2026 17:24:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-devel@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 07/13] scripts/ghes_inject: add a logic to decode CPER
Message-ID: <aXD4dXctHZSVW1_f@foz.lan>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <71dc0f56a7856cc9fe9f0c9c915b56cd49d6f0bd.1768993993.git.mchehab+huawei@kernel.org>
 <20260121132738.00001293@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121132738.00001293@huawei.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 21, 2026 at 01:27:38PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Jan 2026 12:25:15 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Add a decoder to help debugging injected CPERs. This is more
> > relevant when we add fuzzy-testing error inject, as the
> > decoder is helpful to identify what it packages will be sent
> > via QEMU to the firmware-fist logic.
> > 
> > By purpose, I opted to keep this completely independent from
> > the encoders implementation, as this can be used even when
> > there are no encoders for a certain GGUID type (except for a
> GGUID?
> 
> > fuzzy logic test, which is pretty much independent of the
> > records meaning).
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> A few minor things inline.
> 
> I checked the specs, so all that stuff is fine including the spec bug
> you mention (which I'm sure you've already reported :)
> 
> Jonathan
> 
> > ---
> >  MAINTAINERS            |    1 +
> >  scripts/ghes_decode.py | 1155 ++++++++++++++++++++++++++++++++++++++++
> >  scripts/qmp_helper.py  |    3 +
> >  3 files changed, 1159 insertions(+)
> >  create mode 100644 scripts/ghes_decode.py
> > 
> 
> > diff --git a/scripts/ghes_decode.py b/scripts/ghes_decode.py
> > new file mode 100644
> > index 000000000000..6c7fdfe84e3a
> > --- /dev/null
> > +++ b/scripts/ghes_decode.py
> > @@ -0,0 +1,1155 @@
> > +#!/usr/bin/env python3
> > +#
> > +# pylint: disable=R0903,R0912,R0913,R0915,R0917,R1713,E1121,C0302,W0613
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2025 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > +
> > +"""
> > +Helper classes to decode a generic error data entry.
> > +
> > +By purpose, the logic here is independent of the logic inside qmp_helper
> > +and other modules. With a different implementation, it is more likely to
> > +discover bugs at the error injection logic. Also, as this can be used to
> > +dump errors injected by reproducing an error mesage or for fuzzy error
> > +injection, it can't rely at the encoding logic inside each module of
> 
> rely on the encoding logic
> 
> > +ghes_inject.py.
> > +
> > +To make the decoder simple, the decode logic here is at field level, not
> > +trying to decode bitmaps.
> > +"""
> > +
> > +from typing import Optional
> 
> 
> > +class DecodeProcX86():
> > +    """
> > +    Class to decode an x86 Processor Error as defined at
> > +    UEFI 2.1 - N.2.2 Section Descriptor
> > +    """
> > +
> > +    # GUID for x86 Processor Error
> > +    guid = "dc3ea0b0-a144-4797-b95b-53fa242b6e1d"
> > +
> > +    pei_fields = [
> > +        ("Error Structure Type", 16, "guid"),
> > +        ("Validation Bits", 8, "int"),
> > +        ("Check Information", 8, "int"),
> > +        ("Target Identifier", 8, "int"),
> > +        ("Requestor Identifier", 8, "int"),
> > +        ("Responder Identifier", 8, "int"),
> > +        ("Instruction Pointer", 8, "int")
> > +    ]
> > +
> > +    def __init__(self, cper: DecodeField):
> > +        self.cper = cper
> > +
> > +    def decode(self, guid):
> > +        """Decode x86 Processor Error"""
> > +        print("x86 Processor Error")
> > +
> > +        val = self.cper.decode("Validation Bits", 8, "int")
> > +        try:
> > +            val_bits = int.from_bytes(val, byteorder='little')
> > +        except ValueError, TypeError:
> > +            val_bits = 0
> > +
> > +        error_info_num = (val_bits >> 2) & 0x3f    # bits 2-7
> > +        context_info_num = (val_bits >> 8) & 0xff  # bits 8-13
> > +
> > +        self.cper.decode("Local APIC_ID", 8, "int")
> > +        self.cper.decode("CPUID Info", 48, "int")
> > +
> > +        for pei in range(0, error_info_num):
> > +            if self.cper.past_end:
> > +                return
> > +
> > +            print()
> > +            print(f"Processor Error Info {pei}")
> > +            for name, size, ftype in self.pei_fields:
> > +                self.cper.decode(name, size, ftype)
> > +
> > +        for ctx in range(0, context_info_num):
> > +            if self.cper.past_end:
> > +                return
> > +
> > +            print()
> > +            print(f"Context {ctx}")
> > +
> > +            self.cper.decode("Register Context Type", 2, "int")
> > +
> > +            val = self.cper.decode("Register Array Size", 2, "int")
> > +            try:
> > +                context_size = int(int.from_bytes(val, byteorder='little') / 8)
> > +            except ValueError, TypeError:
> > +                context_size = 0
> > +
> > +            self.cper.decode("MSR Address", 4, "int")
> > +            self.cper.decode("MM Register Address", 8, "int")
> > +
> > +            for reg in range(0, context_size):
> > +                if self.cper.past_end:
> > +                    return
> > +                self.cper.decode(f"Register offset {reg:<3}", 8, "int")
> 
> As for arm. Probably need sanity check it's the 8 byte version.
> And for giggles even on x86 some are 16 bytes ;)
> GDTR, IDTR
> 
> Meh, I don't care about those 16 byte ones, but not presenting the 4 byte
> ones as 8 would be good.

As this decode is for debugging purposes, I tried to keep the code as simple
as possible. So, I avoided adding too much details on it. What is important,
IMO, is mainly to be able to quickly check if the Kernel report and rasdaemon
are properly decoding the message.

Also, to be fair, even on 32 bit systems, the size of this register is
8 bytes. Nothing prevent them to have values filled above 32-bits.

In a matter of fact, when using the fuzzy-testing command, the logic
there won't care about what is valid or not: right now, it will either:

    - place a random number;
    - place 0, if used like:
            ghes_inject.py fuzzy --zero

Btw, if I'm not mistaken, currently, RAS is only enabled in QEMU for arm64.

> 
> 
> 
> > +
> > +    @staticmethod
> > +    def decode_list():
> > +        """
> > +        Returns a tuple with the GUID and class
> > +        """
> > +        return [(DecodeProcX86.guid, DecodeProcX86)]
> 
> > +class DecodeProcArm():
> > +    """
> > +    Class to decode an ARM Processor Error as defined at
> > +    UEFI 2.6 - N.2.2 Section Descriptor
> > +    """
> > +
> > +    # GUID for ARM Processor Error
> > +    guid = "e19e3d16-bc11-11e4-9caa-c2051d5d46b0"
> > +
> > +    arm_pei_fields = [
> > +        ("Version",              1, "int"),
> > +        ("Length",               1, "int"),
> > +        ("valid",                2, "int"),
> > +        ("type",                 1, "int"),
> > +        ("multiple-error",       2, "int"),
> > +        ("flags",                1, "int"),
> > +        ("error-info",           8, "int"),
> > +        ("virt-addr",            8, "int"),
> > +        ("phy-addr",             8, "int"),
> > +    ]
> > +
> > +    def __init__(self, cper: DecodeField):
> > +        self.cper = cper
> > +
> > +    def decode(self, guid):
> > +        """Decode Processor ARM"""
> > +
> > +        print("ARM Processor Error")
> > +
> > +        start = self.cper.pos
> > +
> > +        self.cper.decode("Valid", 4, "int")
> > +
> > +        val = self.cper.decode("Error Info num", 2, "int")
> > +        try:
> > +            error_info_num = int.from_bytes(val, byteorder='little')
> > +        except ValueError, TypeError:
> > +            error_info_num = 0
> > +
> > +        val = self.cper.decode("Context Info num", 2, "int")
> > +        try:
> > +            context_info_num = int.from_bytes(val, byteorder='little')
> > +        except ValueError, TypeError:
> > +            context_info_num = 0
> > +
> > +        val = self.cper.decode("Section Length", 4, "int")
> > +        try:
> > +            section_length = int.from_bytes(val, byteorder='little')
> > +        except ValueError, TypeError:
> > +            section_length = 0
> > +
> > +        self.cper.decode("Error affinity level", 1, "int")
> > +        self.cper.decode("Reserved", 3, "int")
> > +        self.cper.decode("MPIDR_EL1", 8, "int")
> > +        self.cper.decode("MIDR_EL1", 8, "int")
> > +        self.cper.decode("Running State", 4, "int")
> > +        self.cper.decode("PSCI State", 4, "int")
> > +
> > +        for pei in range(0, error_info_num):
> > +            if self.cper.past_end:
> > +                return
> > +
> > +            print()
> > +            print(f"Processor Error Info {pei}")
> > +            for name, size, ftype in self.arm_pei_fields:
> > +                self.cper.decode(name, size, ftype)
> > +
> > +        for ctx in range(0, context_info_num):
> > +            if self.cper.past_end:
> > +                return
> > +
> > +            print()
> > +            print(f"Context {ctx}")
> > +            self.cper.decode("Version", 2, "int")
> > +            self.cper.decode("Register Context Type", 2, "int")
> > +            val = self.cper.decode("Register Array Size", 4, "int")
> > +            try:
> > +                context_size = int(int.from_bytes(val, byteorder='little') / 8)
> > +            except ValueError:
> > +                context_size = 0
> > +
> > +            for reg in range(0, context_size):
> > +                if self.cper.past_end:
> > +                    return
> > +                self.cper.decode(f"Register {reg:<3}", 8, "int")
> 
> Maybe check it's not a 32 bit context?  Don't decode it if it
> is but don't try to decode it as 64 bit.  Can get that from the
> Register Context Type.  Anything over 4 is fine.

I can, but see above: this can actually be a 64-bit number even
when only 32-bits are valid (when used with fuzzy injector).

> > +
> > +        remaining = max(section_length + start - self.cper.pos, 0)
> > +        if remaining:
> > +            print()
> > +            self.cper.decode("Vendor data", remaining, "int")
> > +
> > +    @staticmethod
> > +    def decode_list():
> > +        """
> > +        Returns a tuple with the GUID and class
> > +        """
> > +        return [(DecodeProcArm.guid, DecodeProcArm)]
> 
> > +class DecodeDMAVT():
> > +    """
> > +    Class to decode a DMA Virtualization Technology Error as defined at
> > +    UEFI 2.2 - N.2.2 Section Descriptor
> As below. Feels like it should be 
> 
> N2.11.2 Intel VT for Directed I/O specific DMAr Error Section Descriptor.
> Same for other places this comment exists.
> 
> 
> > +    """
> > +
> > +    # GUID for DMA VT Error
> > +    guid = "71761d37-32b2-45cd-a7d0-b0fedd93e8cf"
> 
> > +class DecodeDMAIOMMU():
> > +    """
> > +    Class to decode an IOMMU DMA Error as defined at
> > +    UEFI 2.2 - N.2.2 Section Descriptor
> 
> Odd reference choice.
> This stuff is in N2.11.3 IOMMU Specific DMAr Error Section
> in 2.11. I'm too lazy to find it in the older spec.
> 
> > +    """
> > +
> > +    # GUID for IOMMU DMA Error
> 
> Maybe call it the IOMMU Specific DMAr Error
> 
> > +    guid = "036f84e1-7f37-428c-a79e-575fdfaa84ec"
> > +
> > +    fields = [
> 
> > +class DecodeCXLCompEvent():
> > +    """
> > +    Class to decode a CXL Component Error as defined at
> > +    UEFI 2.9 - N.2.14. CXL Component Events Section
> > +
> > +    Currently, the decoder handles only the common fields, displaying
> > +    the CXL Component Event Log field in bytes.
> > +    """
> > +
> > +    # GUIDs, as defined at CXL specification 3.2: 8.2.10.2.1 Event Records
> > +    guids = [
> > +        ("General Media",              "fbcd0a77-c260-417f-85a9-088b1621eba6"),
> > +        ("DRAM",                       "601dcbb3-9c06-4eab-b8af-4e9bfb5c9624"),
> > +        ("Memory Module",              "fe927475-dd59-4339-a586-79bab113bc74"),
> > +        ("Memory Sparing",             "e71f3a40-2d29-4092-8a39-4d1c966c7c65"),
> > +        ("Physical Switch",            "77cf9271-9c02-470b-9fe4-bc7b75f2da97"),
> 
> As per earlier patch review I'm not sure we care about this and the following.
> I don't think we'll ever see them in CPER records, unless going other something
> else that encapsulates that format.

As I commented on patch 2, UEFI 2.11 accepts those in CPERs. So, except if
a new errata will drop them, from UEFI perspective, all those tyepes could
be found on CPERs sent to OSPM.

From my perspective, for fuzzy-testing, we'd like to be able to inject them
as well, to check if those won't cause any troubles at OSPM implementation.

See more below...

> 
> > +        ("Virtual Switch",             "40d26425-3396-4c4d-a5da-3d472a63af25"),
> > +        ("MDL Port",                   "8dc44363-0c96-4710-b7bf-04bb99534c3f"),
> MLD -> Multi-Logical Device
> 
> > +        ("Dynamic Capabilities",       "ca95afa7-f183-4018-8c2f-95268e101a2a"),
> > +    ]
> > +
> > +    fields = [
> > +        ("Validation Bits", 8, "int"),
> > +        ("Device ID", 12, "int"),
> > +        ("Device Serial Number", 8, "int")
> > +    ]
> > +
> > +    def __init__(self, cper: DecodeField):
> > +        self.cper = cper
> > +
> > +    def decode(self, guid):
> > +        """Decode CXL Protocol Error"""
> > +        for name, guid_event in DecodeCXLCompEvent.guids:
> > +            if guid == guid_event:
> > +                print(f"CXL {name} Event Record")
> > +                break
> > +
> > +        val = self.cper.decode("Length", 4, "int")
> > +        try:
> > +            length = int.from_bytes(val, byteorder='little')
> > +        except ValueError, TypeError:
> > +            length = 0
> > +
> > +        for name, size, ftype in self.fields:
> > +            self.cper.decode(name, size, ftype)
> > +
> > +        length = max(0, length - self.cper.pos)
> > +
> > +        self.cper.decode("CXL Component Event Log", length, "int",
> > +                         show_incomplete=True)

... here, we are not actually decoding the CXL-specific part of the
message, but, instead, displaying as a byte sequence.

When time comes and we implement "cxl" command(s) to the tool, we
may want to decode the event log according with the CXL spec.

For such purpose, we won't need to decode all types - just the ones
that makes sense in practice.

> > +
> > +    @staticmethod
> > +    def decode_list():
> > +        """
> > +        Returns a tuple with the GUID and class
> > +        """
> > +
> > +        guid_list = []
> > +
> > +        for _, guid in DecodeCXLCompEvent.guids:
> > +            guid_list.append((guid, DecodeCXLCompEvent))
> > +
> > +        return guid_list
> 
> 
> ...
> 
> > +class DecodeGhesEntry():
> > +    """
> > +    Class to decode a GHESv2 element, as defined at:
> > +    ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> > +    """
> > +
> > +    # Fields present on all CPER records
> > +    common_fields = [
> > +        # Generic Error Status Block fields
> > +        ("Block Status",           4, "int", None),
> > +        ("Raw Data Offset",        4, "int", "raw_data_offset"),
> > +        ("Raw Data Length",        4, "int", "raw_data_len"),
> > +        ("Data Length",            4, "int", None),
> > +        ("Error Severity",         4, "int", None),
> > +
> > +        # Generic Error Data Entry
> > +        ("Section Type",          16, "guid", "session_type"),
> 
> Why session_type? Is idea it's the type of decode session we are
> doing? Feels a bit too much like a typo from section_type.
> 
> 
> > +        ("Error Severity",         4, "int", None),
> > +        ("Revision",               2, "int", None),
> > +        ("Validation Bits",        1, "int", None),
> > +        ("Flags",                  1, "int", None),
> > +        ("Error Data Length",      4, "int", None),
> > +        ("FRU Id",                16, "guid", None),
> > +        ("FRU Text",              20, "str", None),
> > +        ("Timestamp",              8, "bcd", None),
> > +    ]
> > +
> > +    def __init__(self, cper_data: bytearray):
> > +        """
> > +        Initializes a byte array, decoding it, printing results at the
> > +        screen.
> > +        """
> 
> ...
> 
> > +
> > +        # Handle common types
> > +        cper = DecodeField(cper_data)
> > +
> > +        fields = {}
> > +        for name, size, ftype, var in self.common_fields:
> > +            val = cper.decode(name, size, ftype)
> > +
> > +            if ftype == "int":
> > +                try:
> > +                    val = int.from_bytes(val, byteorder='little')
> > +                except ValueError, TypeError:
> > +                    val = 0
> > +
> > +            if var is not None:
> > +                fields[var] = val
> > +
> > +        if fields["raw_data_len"]:
> > +            cper.decode("Raw Data", fields["raw_data_len"],
> > +                        "int", pos=fields["raw_data_offset"])
> > +
> > +        if not fields["session_type"]:
> > +            return
> 

-- 
Thanks,
Mauro

