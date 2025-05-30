Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C4EC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKyGY-0001Ld-Of; Fri, 30 May 2025 07:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKyGW-0001LM-SZ
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKyGU-00036D-Hw
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748605869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKx9OfLEwrhrxYqaPx+nIo9gZomyutfo8mU8vnyRzRs=;
 b=FIQvoYkAT0E0kfYs+PnIhKhhJW67LWPOAi0ZumAVoNsOHD7W9EO0UHVago+HNNMvIBFBe+
 OFfstBArdtl9eWpNmOFi13i9OoaImjojfsaRs0/vxuCmNxYpifsZxCQp2E8cwyZRmb88h4
 KU8mK8729TXUSScqVOA/oeE+00AQqSw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-7jlDbxOVPhOBIoVFxNGTnA-1; Fri, 30 May 2025 07:51:07 -0400
X-MC-Unique: 7jlDbxOVPhOBIoVFxNGTnA-1
X-Mimecast-MFC-AGG-ID: 7jlDbxOVPhOBIoVFxNGTnA_1748605866
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f858bc5eso406821f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748605866; x=1749210666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKx9OfLEwrhrxYqaPx+nIo9gZomyutfo8mU8vnyRzRs=;
 b=ET8veFtpvYb8PxlUHdZ4xHw7inkZWhPFlV2CFHaQHk4FJN7e4tYgacIYI7zZwkXhOS
 2vptFsAZvx/+WCGngqipMQdh37EmnMVfywhPTZxJ9axKwUHS796x5zwNvGwr6l9IfwJg
 lRT5PoGeNf6yUXLIMX6O0ZBg5sr2VnN1WWXBacPPH/BLsuzz95fIil2xqgGrcjAQBoLG
 9BllsYF5wUkxvdbH4Gea/pkkcDS0LdZg78kQWD0LTZQi+Ph7lyOi470OnF2XtT35PXpF
 j/CSH9vjW9Nvs6kgLOULmg6MW6mJdLX0FMPw7Nu1PwTRvD7XDnZT7w/TZVkN+yAldheG
 xE7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDTPBgVCxARE5cv4S7nOgTC2hmiSX7RUmrsbxvg/WgVm+NvWWuEFDuEnhrn1yUjxF1tl3g3xUHXWLT@nongnu.org
X-Gm-Message-State: AOJu0YxARcHBA9bR5YBqYinQOZAot3vo8hZj5tmehM1styMUJ1URZjiW
 F2OSkS1azeNt/DAEn8HsPw2as2a7zcR7+cay2fkZlQSY3DaunEdk/qiH5kQZQ3bBDCP+eB6tlc/
 QhPa22UdxyapL/GUUkE7ZZVZ/YMRW19HNJ8B92dFoaVttC9P9JLV1RlUmDnZN3H4PxLo=
X-Gm-Gg: ASbGnctE2lOt+Sapk4Vk8HdVSSP9MFu8Vsg1yd+F9jv6YwDCtnyLUbieESiGJH8HPRi
 tq2cUsZJYjhuCQ0jPM1TfMd0UCkf4iaCwtL+gIeuAqkwY+tTCvtjLJHyti2EH+kZRb6YyBFW3lo
 UR2KvpMXlxl/3A0Wxym/xKuU53lR21+mJheuWoKXHRYGyqMh+NTjZBWZDh4XT00E3+uFvva+eGO
 nUHvwYvWvPvyk20lxrieewUM6MuGL7wVCudUnj2etdnxDLheqRiPt2yhcnWWq1zuhZ0WK+DRv1x
 CBV18Ye0aYE1ukRRYk5Xo+pOhrvaoVMx
X-Received: by 2002:a05:6000:2505:b0:3a3:7749:9783 with SMTP id
 ffacd0b85a97d-3a4f7ab14d0mr2429065f8f.51.1748605866124; 
 Fri, 30 May 2025 04:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Sm9xv3UE7hXSz8rBIfIFy5so480NXTvpFi2tuDgqHgoGtffue90eNMOcTWeE8xcvgNPSuQ==
X-Received: by 2002:a05:6000:2505:b0:3a3:7749:9783 with SMTP id
 ffacd0b85a97d-3a4f7ab14d0mr2429041f8f.51.1748605865644; 
 Fri, 30 May 2025 04:51:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009752esm4618481f8f.74.2025.05.30.04.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:51:05 -0700 (PDT)
Date: Fri, 30 May 2025 13:51:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
Message-ID: <20250530135103.09030cf0@imammedo.users.ipa.redhat.com>
In-Reply-To: <6a5776b4-73ef-427b-b4e4-b25031b0ce53@linaro.org>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
 <20250528113813.47086516@imammedo.users.ipa.redhat.com>
 <375cfbd6-e585-4b6d-bf10-6571aa40370e@linaro.org>
 <20250528150239.5f6b63d0@imammedo.users.ipa.redhat.com>
 <6a5776b4-73ef-427b-b4e4-b25031b0ce53@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 28 May 2025 12:04:26 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi Igor,
>=20
> On 5/28/25 10:02, Igor Mammedov wrote:
> > On Wed, 28 May 2025 09:41:15 -0300
> > Gustavo Romero <gustavo.romero@linaro.org> wrote:
> >  =20
> >> Hi Igor,
> >>
> >> On 5/28/25 06:38, Igor Mammedov wrote: =20
> >>> On Tue, 27 May 2025 09:40:26 +0200
> >>> Eric Auger <eric.auger@redhat.com> wrote:
> >>>     =20
> >>>> From: Gustavo Romero <gustavo.romero@linaro.org>
> >>>>
> >>>> ACPI PCI hotplug is now turned on by default so we need to change the
> >>>> existing tests to keep it off. However, even setting the ACPI PCI
> >>>> hotplug off in the existing tests, there will be changes in the ACPI
> >>>> tables because the _OSC method was modified, hence in the next patch=
 of
> >>>> this series the blobs are updated accordingly.
> >>>>
> >>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> >>>> Signed-off-by: Eric Auger <eric.auger@redhat.com> =20
> >>>
> >>> it would be better to test whatever default we end up with.
> >>> (like x86) =20
> >>
> >> hmm maybe there is a confusion here, Igor. We are actually planning wh=
at you =20
> >=20
> > perhaps, see my reply to Eric about my expectations wrt tests. =20
>=20
> Yip, I read it before my reply here.
>=20
>=20
> > (i.e. default tests shouldn't have any explicit CLI options,
> > instead it should follow whitelist blobs/set new default patch/update b=
lobs pattern) =20
>=20
> I see. I agree with that. But this patch is not about the new test. The n=
ew test is
> _not_ in this series. Patches 8/25, 10/25, and 24/25 are _not_ about the =
new test but
> about adapting the _legacy tests_ (native acpi) to the situation when ACP=
I HP becomes
> the default, because this series makes acpi-pcihp=3Don the default, hence=
 the CLI option
> "acpi-pcihp=3Doff" added to them. An update to the blobs are also necessa=
ry because of the
> change in _OSC method, even when acpi-pcihp=3Doff.
>=20
>=20
> >> said. This patch and the other two in this series related to the bios-=
tables-test
> >> (i.e., patches 8/25 and 10/25) are for actually making the current (le=
gacy) test pass,
> >> since the new default as per this series will be acpi-pcihp=3Don. That=
's why here we're
> >> adapting the current test here to have acpi-pcihp=3Doff.
> >>
> >> The new test that will test for acpi-pcihp=3Don (the new default) is n=
ot in this series
> >> and we decided to merge it separate. It's in the patch 4/5 and 5/5 of =
the follow series: =20
>=20
> We're doing the "blobs/set new default patch/update blobs pattern" in the=
 new test, which
> we can merge later, once this series is merged, no? The step "set new def=
ault" then will
> not be necessary because the new test will be merged separate, after this=
 series, so when
> acpi-pcihp=3Don is already the default.
>=20
> Please note that although we're using acpi-pcihp=3Don in the new test, it=
's not necessary,
> we can dropped this option, making it implicit as you say, and it will wo=
rk. This is the
> new test:
>=20
> >> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
> >> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5=
 =20
>=20
>=20
> Thus, there are to "acts" of modifying the bios-tables-test:
>=20
> 1) Adapt the current tests to when acpi-pcihp=3Don becomes the default (h=
ence the addition
>     to them of "acpi-pcihp=3Doff".


that's what I disagree with.

1) Instead adapting majority of tests to legacy before switching defaults,
just do whitelist/modify default/update so all of tests run with new defaul=
t.

and then

> There is also the need to update the blobs, but it's because
>     of the _OSC method change in DSDT table, which will change anyways, e=
ven with "acpi-pcihp=3Doff=C2=A8,
>     hence the need for patch 10/25 in this series. This is _done is this =
series_.


=20
> 2) Add a new test for testing the default (i.e. acpi-pcihp-on). It follow=
s what you're
>     saying above: "follow whitelist blobs/set new default patch/update bl=
obs pattern",
>     because we can drop the acpi-pcihp-on option from the CLI in this tes=
t without any
>     prejudice to test. While the step "set new default patch" was actuall=
y done in 1).

2) add a separate test case for native pcie hoplug (preferably within this =
series)

3) even better would be to add #2 before #1 (right after 10/25),
this way will guarantee that old native hotplug tables stay
the same regardless of followup patches that add ACPI pcihp aml.


> Cheers,
> Gustavo
>=20
> >> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05828.html 4/5
> >> https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05827.html 5/5
> >>
> >>
> >> Cheers,
> >> Gustavo
> >> =20
> >>>>
> >>>> ---
> >>>>
> >>>> [Eric] also added acpi-pcihp=3Doff to test_acpi_aarch64_virt_tcg_num=
amem
> >>>> ---
> >>>>    tests/qtest/bios-tables-test.c | 13 +++++++++----
> >>>>    1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-table=
s-test.c
> >>>> index 0a333ec435..6379dba714 100644
> >>>> --- a/tests/qtest/bios-tables-test.c
> >>>> +++ b/tests/qtest/bios-tables-test.c
> >>>> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(v=
oid)
> >>>>        };
> >>>>   =20
> >>>>        data.variant =3D ".memhp";
> >>>> -    test_acpi_one(" -machine nvdimm=3Don"
> >>>> +    test_acpi_one(" -machine nvdimm=3Don,acpi-pcihp=3Doff"
> >>>>                      " -cpu cortex-a57"
> >>>>                      " -m 256M,slots=3D3,maxmem=3D1G"
> >>>>                      " -object memory-backend-ram,id=3Dram0,size=3D1=
28M"
> >>>> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem=
(void)
> >>>>        };
> >>>>   =20
> >>>>        data.variant =3D ".numamem";
> >>>> -    test_acpi_one(" -cpu cortex-a57"
> >>>> +    test_acpi_one(" -machine acpi-pcihp=3Doff"
> >>>> +                  " -cpu cortex-a57"
> >>>>                      " -object memory-backend-ram,id=3Dram0,size=3D1=
28M"
> >>>>                      " -numa node,memdev=3Dram0",
> >>>>                      &data);
> >>>> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(voi=
d)
> >>>>         * to solve the conflicts.
> >>>>         */
> >>>>        data.variant =3D ".pxb";
> >>>> -    test_acpi_one(" -device pcie-root-port,chassis=3D1,id=3Dpci.1"
> >>>> +    test_acpi_one(" -machine acpi-pcihp=3Doff"
> >>>> +                  " -device pcie-root-port,chassis=3D1,id=3Dpci.1"
> >>>>                      " -device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.=
1"
> >>>>                      " -drive file=3D"
> >>>>                      "tests/data/uefi-boot-images/bios-tables-test.a=
arch64.iso.qcow2,"
> >>>> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hm=
at(void)
> >>>>   =20
> >>>>        data.variant =3D ".acpihmatvirt";
> >>>>   =20
> >>>> -    test_acpi_one(" -machine hmat=3Don"
> >>>> +    test_acpi_one(" -machine hmat=3Don,acpi-pcihp=3Doff"
> >>>>                      " -cpu cortex-a57"
> >>>>                      " -smp 4,sockets=3D2"
> >>>>                      " -m 384M"
> >>>> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
> >>>>        data.smbios_cpu_max_speed =3D 2900;
> >>>>        data.smbios_cpu_curr_speed =3D 2700;
> >>>>        test_acpi_one("-cpu cortex-a57 "
> >>>> +                  "-machine acpi-pcihp=3Doff "
> >>>>                      "-smbios type=3D4,max-speed=3D2900,current-spee=
d=3D2700", &data);
> >>>>        free_test_data(&data);
> >>>>    }
> >>>> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topolog=
y(void)
> >>>>        };
> >>>>   =20
> >>>>        test_acpi_one("-cpu cortex-a57 "
> >>>> +                  "-machine acpi-pcihp=3Doff "
> >>>>                      "-smp sockets=3D1,clusters=3D2,cores=3D2,thread=
s=3D2", &data);
> >>>>        free_test_data(&data);
> >>>>    }
> >>>> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
> >>>>        };
> >>>>   =20
> >>>>        test_acpi_one("-cpu cortex-a57 "
> >>>> +                  "-machine acpi-pcihp=3Doff "
> >>>>                      "-device virtio-iommu-pci", &data);
> >>>>        free_test_data(&data);
> >>>>    } =20
> >>>     =20
> >> =20
> >  =20
>=20


