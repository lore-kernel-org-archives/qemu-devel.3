Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE42D3EE8A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vixTL-00075T-Ug; Thu, 22 Jan 2026 11:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vixTK-00075L-Jj
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:23:50 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vixTI-0007vW-Hg
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 11:23:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D8D27600CB;
 Thu, 22 Jan 2026 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C26C116C6;
 Thu, 22 Jan 2026 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769099026;
 bh=5gD7O1v/PNlDIENDuMG/XrZ0GlLsv5/v25ync/p1VTs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bo9Ltq4hEQoTKp4g++gPNOJRS/cX1Wx4A1zY7agOYKP55zO0cqwu8wu2+zfjyMfwK
 FIxubP/YCH9xqgdIV4of2ihy7ooa9HqzKtSbNWitPM89OOFOQIFcFcT2ux9Kbe7oU9
 T5IuR9k4Gw9TZE8Yp4Kr4NFVUIl1OZckzBk0GBYalL099UUUEK/PPaXw4i5AuE2z9N
 Ty+yGUmG3m/mx3kN2vDaZQvKfrrDBY+kJu0bJRxsfQTQ+vTxEjpGlU0MbNNcaPU36p
 SeRx/CrQVwucbO4yl8VPJGmoDXIVl/g2fhZU0r+X2OHEMKK53mlt5zS+pG8Pf/Wmkk
 zo38Nda6rDIAA==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vixTE-000000054fI-0o0C; Thu, 22 Jan 2026 17:23:44 +0100
Date: Thu, 22 Jan 2026 17:23:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Michael S Tsirkin
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, Igor Mammedov
 <imammedo@redhat.com>, Cleber Rosa <crosa@redhat.com>, John Snow
 <jsnow@redhat.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 07/13] scripts/ghes_inject: add a logic to decode CPER
Message-ID: <20260122172343.13339b35@localhost>
In-Reply-To: <20260121132738.00001293@huawei.com>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <71dc0f56a7856cc9fe9f0c9c915b56cd49d6f0bd.1768993993.git.mchehab+huawei@kernel.org>
 <20260121132738.00001293@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 21 Jan 2026 13:27:38 +0000
Jonathan Cameron via qemu development <qemu-devel@nongnu.org> wrote:

> On Wed, 21 Jan 2026 12:25:15 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20

...

> > +class DecodeDMAVT():
> > +    """
> > +    Class to decode a DMA Virtualization Technology Error as defined at
> > +    UEFI 2.2 - N.2.2 Section Descriptor =20
> As below. Feels like it should be=20
>=20
> N2.11.2 Intel VT for Directed I/O specific DMAr Error Section Descriptor.
> Same for other places this comment exists.

when reviewing the ghes.c driver, Igor requested to pick the oldest=20
possible spec when filling comments inside GHES. In this specific case,
the oldest one is UEFI 2.2:
	https://uefi.org/sites/default/files/resources/UEFI_Spec_2_2_D.pdf

> > +    """
> > +
> > +    # GUID for DMA VT Error
> > +    guid =3D "71761d37-32b2-45cd-a7d0-b0fedd93e8cf" =20

... there, at:
	N.2.2 Section Descriptor
	Table 227. Section Descriptor

Section Type shows several different GUIDs, including this one,
listed there as:
=09
	Intel=C2=AE VT for Directed I/O specific DMAr section
	=E2=80=A2{0x71761D37, 0x32B2, 0x45cd, {0xA7, 0xD0, 0xB0,
	=E2=80=A20xFE 0xDD, 0x93, 0xE8, 0xCF}}

That's basically why it is listed here for all the 9 GUIDs
defined at UEFI 2.2.

>=20
> > +class DecodeDMAIOMMU():
> > +    """
> > +    Class to decode an IOMMU DMA Error as defined at
> > +    UEFI 2.2 - N.2.2 Section Descriptor =20
>=20
> Odd reference choice.
> This stuff is in N2.11.3 IOMMU Specific DMAr Error Section
> in 2.11. I'm too lazy to find it in the older spec.

Heh, most of the time I spent writing this patch were to seek
what spec version introduced each GUID ;-D

>=20
> > +    """
> > +
> > +    # GUID for IOMMU DMA Error =20
>=20
> Maybe call it the IOMMU Specific DMAr Error
>=20
> > +    guid =3D "036f84e1-7f37-428c-a79e-575fdfaa84ec"
> > +
> > +    fields =3D [ =20
>=20
> > +class DecodeCXLCompEvent():
> > +    """
> > +    Class to decode a CXL Component Error as defined at
> > +    UEFI 2.9 - N.2.14. CXL Component Events Section
> > +
> > +    Currently, the decoder handles only the common fields, displaying
> > +    the CXL Component Event Log field in bytes.
> > +    """
> > +
> > +    # GUIDs, as defined at CXL specification 3.2: 8.2.10.2.1 Event Rec=
ords
> > +    guids =3D [
> > +        ("General Media",              "fbcd0a77-c260-417f-85a9-088b16=
21eba6"),
> > +        ("DRAM",                       "601dcbb3-9c06-4eab-b8af-4e9bfb=
5c9624"),
> > +        ("Memory Module",              "fe927475-dd59-4339-a586-79bab1=
13bc74"),
> > +        ("Memory Sparing",             "e71f3a40-2d29-4092-8a39-4d1c96=
6c7c65"),
> > +        ("Physical Switch",            "77cf9271-9c02-470b-9fe4-bc7b75=
f2da97"), =20
>=20
> As per earlier patch review I'm not sure we care about this and the follo=
wing.
> I don't think we'll ever see them in CPER records, unless going other som=
ething
> else that encapsulates that format.

I'm adding a notice before this table.

>=20
> > +        ("Virtual Switch",             "40d26425-3396-4c4d-a5da-3d472a=
63af25"),
> > +        ("MDL Port",                   "8dc44363-0c96-4710-b7bf-04bb99=
534c3f"), =20
> MLD -> Multi-Logical Device
>=20
> > +        ("Dynamic Capabilities",       "ca95afa7-f183-4018-8c2f-95268e=
101a2a"),
> > +    ]
> > +
> > +    fields =3D [
> > +        ("Validation Bits", 8, "int"),
> > +        ("Device ID", 12, "int"),
> > +        ("Device Serial Number", 8, "int")
> > +    ]
> > +
> > +    def __init__(self, cper: DecodeField):
> > +        self.cper =3D cper
> > +
> > +    def decode(self, guid):
> > +        """Decode CXL Protocol Error"""
> > +        for name, guid_event in DecodeCXLCompEvent.guids:
> > +            if guid =3D=3D guid_event:
> > +                print(f"CXL {name} Event Record")
> > +                break
> > +
> > +        val =3D self.cper.decode("Length", 4, "int")
> > +        try:
> > +            length =3D int.from_bytes(val, byteorder=3D'little')
> > +        except ValueError, TypeError:
> > +            length =3D 0
> > +
> > +        for name, size, ftype in self.fields:
> > +            self.cper.decode(name, size, ftype)
> > +
> > +        length =3D max(0, length - self.cper.pos)
> > +
> > +        self.cper.decode("CXL Component Event Log", length, "int",
> > +                         show_incomplete=3DTrue)
> > +
> > +    @staticmethod
> > +    def decode_list():
> > +        """
> > +        Returns a tuple with the GUID and class
> > +        """
> > +
> > +        guid_list =3D []
> > +
> > +        for _, guid in DecodeCXLCompEvent.guids:
> > +            guid_list.append((guid, DecodeCXLCompEvent))
> > +
> > +        return guid_list =20
>=20
>=20
> ...
>=20
> > +class DecodeGhesEntry():
> > +    """
> > +    Class to decode a GHESv2 element, as defined at:
> > +    ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> > +    """
> > +
> > +    # Fields present on all CPER records
> > +    common_fields =3D [
> > +        # Generic Error Status Block fields
> > +        ("Block Status",           4, "int", None),
> > +        ("Raw Data Offset",        4, "int", "raw_data_offset"),
> > +        ("Raw Data Length",        4, "int", "raw_data_len"),
> > +        ("Data Length",            4, "int", None),
> > +        ("Error Severity",         4, "int", None),
> > +
> > +        # Generic Error Data Entry
> > +        ("Section Type",          16, "guid", "session_type"), =20
>=20
> Why session_type? Is idea it's the type of decode session we are
> doing? Feels a bit too much like a typo from section_type.

it is meant to be a dict key, but I'll just drop it, taking a different
approach.

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
> > +        """ =20
>=20
> ...
>=20
> > +
> > +        # Handle common types
> > +        cper =3D DecodeField(cper_data)
> > +
> > +        fields =3D {}
> > +        for name, size, ftype, var in self.common_fields:
> > +            val =3D cper.decode(name, size, ftype)
> > +
> > +            if ftype =3D=3D "int":
> > +                try:
> > +                    val =3D int.from_bytes(val, byteorder=3D'little')
> > +                except ValueError, TypeError:
> > +                    val =3D 0
> > +
> > +            if var is not None:
> > +                fields[var] =3D val
> > +
> > +        if fields["raw_data_len"]:
> > +            cper.decode("Raw Data", fields["raw_data_len"],
> > +                        "int", pos=3Dfields["raw_data_offset"])
> > +
> > +        if not fields["session_type"]:
> > +            return =20
>=20
>=20

