Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763ABCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNX7j-0008Eo-E0; Thu, 14 May 2026 10:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNX7f-0008CG-GV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNX7a-000125-QW
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778769185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4uv7GnQz5GSG67tsap8gp8SaeNT30zZaHENAZr25Ef8=;
 b=hkVZPHJy2hMSfO577ymlB2oZU9TLf0OyJA+5GCxZXQ9XsfLCl3gnoQYYWr/+TH6Of5JOms
 LPAfN3Id1FTwqQ/Y7mENg+ZEMM4H0ud5l95YeqADQMtHB62X3aF1mcwVVfQ9ZeX9bMBbQr
 yUoYA48H27axhXP2/ywQjfwi3Hsgo1E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-z_MwXqn4PP6q4OhVzkLLPA-1; Thu, 14 May 2026 10:33:03 -0400
X-MC-Unique: z_MwXqn4PP6q4OhVzkLLPA-1
X-Mimecast-MFC-AGG-ID: z_MwXqn4PP6q4OhVzkLLPA_1778769182
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd8162ed7so7346355e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778769182; x=1779373982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uv7GnQz5GSG67tsap8gp8SaeNT30zZaHENAZr25Ef8=;
 b=nM1P/dpkWuxgHMaRn7i0UHlwsuRANaDwaSjTEQnIuc3RC9uyVfu4++ERRz+kN3PZBE
 fcBRqTwRUZ7OIXmms/hgil8C5qj4LiUQ+E7lJFl0MDqcyhnF39o4+VdJosDxeaMHN5yg
 HagD26EpYG//tbZzdsc3Wfhv2aCYKET7o6sV5J9tlVuEntvQ90T7R3KaoKOwXpA5thBV
 mWf5h6p1ZQPpqvUxew6Q3aGUG7zl8Hs3BF50Zj68PxEXYp9QVrctOkhQYd5/+Q64YTUu
 dY66K+lPXp8Ok3IOfHd5wR+Srv/VkjHmezE7NChZRWVWxhIFNJDEid7M0Ngk90gcYKSF
 CCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778769182; x=1779373982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4uv7GnQz5GSG67tsap8gp8SaeNT30zZaHENAZr25Ef8=;
 b=gC4+woQlcN+VuXIsMYndqx13tdSz8RwtQOCD7RGV+StARd+AtesGj/OTX+jfWuaoG5
 9eFNHBUonU9JAvN+J4/nyErqgfMRwZlNDRSzWANtUTVt723wfeDlq2W4UY74FUVd2Z87
 KeGx4TkeQkflaSaUv4IwIjX0FxOZgr6x62nLxyigOclqwfR9nDvObAnYYKj05BhgMnvy
 Oc3Fl/RK+QJhXIKH3IgrpIzSdUH0Sv3EKTF+9GnkPwQ2Lfg/DxLf0SwAFaADZvjm1h+5
 HjmmBmMeGoHhxKUOz1ZgrUPniXXnDA4UGLIAeCJ5CsCY9RSSVB0dewxdlFerfeQrcirT
 cW3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h/zH9zj0CqaYx9GFErTFZ3z8Mik/sLp/0mCWKFVhVSoCKIEwMufO8YMssU+RZP5CA3epBudAjn0A4@nongnu.org
X-Gm-Message-State: AOJu0YyUAEArnLbtlpIJefdTV+QC+wP69OxVfoh4GJPz786yma7a4xwq
 IpveEX5vrwQ79AMTwQOPnUEyQ2rXnE6IghJBIrR7u5iwruVJGWDTJd95TeQ/oVc3uLLIHyeBIDj
 taRhNC7j/XJOmbnlbaM9XTeVu6Fyr6kKG+/AL4+mQYjEy9VRw2EJL5Oup
X-Gm-Gg: Acq92OErzGqAhOC4aBgqM4G7hqhCpxZo2fBEdhCYQutFAONVJXCpTISpS0kd2FzbJmg
 GvGYs9erSpe3POvR0QdVsSK4nynn4iRZA61uJNdWbyRReQigwiyGl3SBDe9V4iqMUaIjTxUdDjS
 hJ17ECRKeQLW9jARysQpNHHXnAyIHtVZt057ndnSsbd7fKeTOSknGDQNMpMoOECv7XSIPLAnjQt
 AsQxmUO3K7MVoCmYZCU9Too47ixMsbtd9oeXQL/RMi/88VDysKNkLTeamj7rTKp0BkDewe7vCBv
 tHHAu9I7H+TQtHaRQ1IR2tl/quoblQfBrR1JhogNMYkM0kZlNOD0LQTZV6kKFDCDYe36/SHFe08
 cIImLlw==
X-Received: by 2002:a05:600c:4f88:b0:48f:e230:2a22 with SMTP id
 5b1f17b1804b1-48fe2302b60mr20238665e9.33.1778769182178; 
 Thu, 14 May 2026 07:33:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4f88:b0:48f:e230:2a22 with SMTP id
 5b1f17b1804b1-48fe2302b60mr20238065e9.33.1778769181694; 
 Thu, 14 May 2026 07:33:01 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4614d53sm2451125e9.11.2026.05.14.07.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 07:33:01 -0700 (PDT)
Date: Thu, 14 May 2026 16:32:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 anisinha@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
Message-ID: <20260514163258.37b025d3@imammedo>
In-Reply-To: <20260513112745-mutt-send-email-mst@kernel.org>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-4-imammedo@redhat.com>
 <agSdBwKQh3C9UgdF@intel.com>
 <20260513112745-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 13 May 2026 11:28:01 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, May 13, 2026 at 11:47:19PM +0800, Zhao Liu wrote:
> > On Tue, Mar 03, 2026 at 10:25:14AM +0100, Igor Mammedov wrote: =20
> > > Date: Tue,  3 Mar 2026 10:25:14 +0100
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Subject: [PATCH v2 03/21] x86: q35: generate WDAT ACPI table
> > >=20
> > > It will generate WDAT table [1] customized for TCO watchdog.
> > > This allows Windows guests (Windows Server 2008/Vista+) to
> > > use TCO watchdog using built-in generic driver, which
> > > alleviates need to install vendor specific drivers.
> > >=20
> > > Given that enabling it might change guest behaviour
> > > (both Windows/Linux) the feature is disabled by default.
> > >=20
> > > Users that need it can enable the feature with
> > > following CLI option.
> > >     -machine wdat=3Don
> > >=20
> > > 1)
> > >    "Hardware Watchdog Timers Design=C2=A0Specification"
> > >     https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Reviewed-by: Ani Sinha <anisinha@redhat.com>
> > > ---
> > >  include/hw/acpi/wdat-ich9.h | 15 +++++++
> > >  hw/acpi/meson.build         |  3 +-
> > >  hw/acpi/wdat-ich9-stub.c    | 15 +++++++
> > >  hw/acpi/wdat-ich9.c         | 90 +++++++++++++++++++++++++++++++++++=
++
> > >  hw/i386/acpi-build.c        | 12 +++++
> > >  5 files changed, 134 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/hw/acpi/wdat-ich9.h
> > >  create mode 100644 hw/acpi/wdat-ich9-stub.c
> > >  create mode 100644 hw/acpi/wdat-ich9.c =20
> >=20
> > ...
> >  =20
> > > +void build_ich9_wdat(GArray *table_data, BIOSLinker *linker, const c=
har *oem_id,
> > > +                     const char *oem_table_id, uint64_t tco_base)
> > > +{
> > > +    AcpiTable table =3D { .sig =3D "WDAT", .rev =3D 1, .oem_id =3D o=
em_id,
> > > +                        .oem_table_id =3D oem_table_id };
> > > +    struct AcpiGenericAddress tco_rld =3D  TCO_REG(tco_base, 0x0, 16=
);
> > > +    struct AcpiGenericAddress tco2_sts =3D TCO_REG(tco_base, 0x6, 16=
);
> > > +    struct AcpiGenericAddress tco1_cnt =3D TCO_REG(tco_base, 0x8, 16=
);
> > > +    struct AcpiGenericAddress tco_tmr =3D  TCO_REG(tco_base, 0x12, 1=
6);
> > > +
> > > +    acpi_table_begin(&table, table_data);
> > > +    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Head=
er Length */
> > > +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> > > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Numbe=
r */
> > > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Nu=
mber */
> > > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function =
Number */
> > > +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> > > +    /*
> > > +     * limits/resolution are defined by ICH9 TCO spec
> > > +     */
> > > +    build_append_int_noprefix(table_data, 0x258, 4);/* Timer Period,=
 ms */
> > > +    build_append_int_noprefix(table_data, 0x3ff, 4);/* Maximum Count=
 */
> > > +    build_append_int_noprefix(table_data, 0x4, 4);  /* Minimum Count=
 */ =20
> >=20
> > Spec said: The time-out period before the WDT fires is recommended to b=
e at
> > least 5 minutes and is required to be less than 4,294,967,296 count
> > intervals.
> >=20
> > Here we encode 0x4 * 0x258 =3D 2400ms, less than 5 minutes. But I
> > understand because "5 minutes" is just "recommanded" by spec, so 2400ms=
 is
> > okay.
> >=20
> > LGTM,
> >=20
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com> =20
>=20
>=20
> maybe a comment why it's shorter?

it's not shorter nor arbitrary value, comments already say it all.
and provide enough context for spec lookup:
 WDAT:
   /Timer Period/	Contains the period of one timer count (in milliseconds).

 it's timer resolution.
   iTCO spec says: "The timer is clocked at approximately 0.6 seconds"

   and then MIN/MAX aren't default value either, they are limits per iTCO s=
pec,
   as comment above says. The guest OS sets actual value within declared he=
re constrains.

So no extra comments were added (just enough for spec lookup).
But my view is obviously biased,
just say what more you'd like to see in comments and I'll post fixup.









