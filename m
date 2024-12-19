Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F133E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOCwI-0001TC-LX; Thu, 19 Dec 2024 04:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOCwH-0001Sn-Gl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:35:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOCwF-0002PD-JE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734600922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRYyCqZfvQdX4M1TT8Ahjz8812RNiR3DOAdMOQ7S+zQ=;
 b=goXrb0C7frAdObnifBkQF1UUHym7uZI05aEQDKIf9KmFqhxUtUdFtUQ+BUJsPuzdnIb0HN
 3XO46/GUFxzEWhhN+SyDh9azLne0qrRRN7M3CSCYGxEWhshht8AZWVKOu7h7KPrA1HBjyR
 YT54uSCr0Puvxs8ZcQz60J0SAieNoqE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-PDmX8SN_P5Ofbt-KC-xaOA-1; Thu, 19 Dec 2024 04:35:20 -0500
X-MC-Unique: PDmX8SN_P5Ofbt-KC-xaOA-1
X-Mimecast-MFC-AGG-ID: PDmX8SN_P5Ofbt-KC-xaOA
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-725e3c6ad0dso967748b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734600919; x=1735205719;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRYyCqZfvQdX4M1TT8Ahjz8812RNiR3DOAdMOQ7S+zQ=;
 b=RQyj+CMw27cuyBUe+Nnnu5qUKSN2tCCb8NLH7EIhxESehgKjzhJbr1HNM9aEqFT3fC
 bXx9bUcOItQcrZRengx5ShoELHjD0bF42JfO5Rvl/ND8/HyficopUGwRajutvAg8zjVv
 SZmhbeMUb3zLCQCJ5VOcEa8w3IkLEQR6jv9rNr3wNPVLGik4fI0zFs7W+42n82BpAxhG
 k1UVNbBdcmqrtLQb/SVCBVJsyGEjI4H9bpnPLDGQOE7UpFqw7vMEOGvbXFjU0+a/H6LE
 eP+SP+hhgY6hbfrBh3qszvyLtvfo7OYgswEJSSpaoNS39LQfnFlJbp/yZdg4FsIoHKYD
 UuPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9h9nNis2atDB1ptnGWy8XyGp8PmQl+JPbqeR7g2L58HmPqBu2EPcVm+WIeOWUWOyB0H+zmxN9i6i2@nongnu.org
X-Gm-Message-State: AOJu0YxPx4YzEDESVHcHpd/p6OKjwRpfSokSc2meBVbEYpOPBHvRHfas
 rtpuxY3oBzLcsfa1dW2sdEdLd+3egO3Fjhy4W/78bC7CGhfv6JmGAGAKgEEeT4ghXbGWzYYBW4J
 lw+8sTD0mQgZ0+AIlhy5sbvyptntGjuARQtmxrI2f7H1MRSbAiSRj
X-Gm-Gg: ASbGncumitA0ESl5fs/XU29ET4/BVxJkHsClrBeYLi9nH5SX2ZL/M7PT94V9vgUmdDC
 DyuO40v4z6Kqd795gZBlKyXg28KoLYuFRwt27s9ow5JQ7UqggV/LlAPi3WcKwFZ7poyCirGMDPo
 +eqDsVTx6T+sZT1Yfd3nX9aVB5dw5zDtGkM8ftHXRbv0xINtfhfp8/CeundukG85ObBsTEMBQFm
 8bFObE8CVE6q+kmDNMcbF+/XGpDpKuxjrYVtcgg5t1dTzSlTLPs2R4bKwLK1wZ68PPLHbSeUg==
X-Received: by 2002:a05:6a00:398a:b0:725:e499:5b88 with SMTP id
 d2e1a72fcca58-72a8d2c9b7emr9208063b3a.25.1734600919402; 
 Thu, 19 Dec 2024 01:35:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0gz5LMWoidsMO9FYWabga4L0dzROPDNh4jSdL8z09CNMuAl9qVaJ+luvgTsWDfDCNh36v8w==
X-Received: by 2002:a05:6a00:398a:b0:725:e499:5b88 with SMTP id
 d2e1a72fcca58-72a8d2c9b7emr9208036b3a.25.1734600918990; 
 Thu, 19 Dec 2024 01:35:18 -0800 (PST)
Received: from smtpclient.apple ([116.73.135.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fd7afsm858508b3a.139.2024.12.19.01.35.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:35:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
Date: Thu, 19 Dec 2024 15:05:03 +0530
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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



> On 18 Dec 2024, at 11:13=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 16/12/24 12:48, Ani Sinha wrote:
>> VM firmware update is a mechanism where the virtual machines can use =
their
>> preferred and trusted firmware image in their execution environment =
without
>> having to depend on a untrusted party to provide the firmware bundle. =
This is
>> particularly useful for confidential virtual machines that are =
deployed in the
>> cloud where the tenant and the cloud provider are two different =
entities. In
>> this scenario, virtual machines can bring their own trusted firmware =
image
>> bundled as a part of their filesystem (using UKIs for example[1]) and =
then use
>> this hypervisor interface to update to their trusted firmware image. =
This also
>> allows the guests to have a consistent measurements on the firmware =
image.
>> This change introduces basic support for the fw-cfg based hypervisor =
interface
>> and the corresponding device. The change also includes the
>> specification document for this interface. The interface is made =
generic
>> enough so that guests are free to use their own ABI to pass required
>> information between initial and trusted execution contexts (where =
they are
>> running their own trusted firmware image) without the hypervisor =
getting
>> involved in between. In subsequent patches, we will introduce other =
minimal
>> changes on the hypervisor that are required to make the mechanism =
work.
>> [1] See systemd pull requests =
https://github.com/systemd/systemd/pull/35091
>> and https://github.com/systemd/systemd/pull/35281 for some =
discussions on
>> how we can bundle firmware image within an UKI.
>> CC: Alex Graf <graf@amazon.com>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Gerd Hoffman <kraxel@redhat.com>
>> CC: Igor Mammedov <imammedo@redhat.com>
>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  MAINTAINERS                  |   9 ++
>>  docs/specs/index.rst         |   1 +
>>  docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>>  hw/misc/meson.build          |   2 +
>>  hw/misc/vmfwupdate.c         | 157 =
+++++++++++++++++++++++++++++++++++
>>  include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>>  6 files changed, 381 insertions(+)
>>  create mode 100644 docs/specs/vmfwupdate.rst
>>  create mode 100644 hw/misc/vmfwupdate.c
>>  create mode 100644 include/hw/misc/vmfwupdate.h
>=20
>=20
>> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VMFwUpdateState *s =3D VMFWUPDATE(dev);
>> +    FWCfgState *fw_cfg =3D fw_cfg_find();
>> +
>> +    /* multiple devices are not supported */
>> +    if (!vmfwupdate_find()) {
>> +        error_setg(errp, "at most one %s device is permitted",
>> +                   TYPE_VMFWUPDATE);
>> +        return;
>> +    }
>> +
>> +    /* fw_cfg with DMA support is necessary to support this device =
*/
>> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
>> +        error_setg(errp, "%s device requires fw_cfg",
>> +                   TYPE_VMFWUPDATE);
>> +        return;
>> +    }
>> +
>> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
>> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
>> +
>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
>> +                             NULL, NULL, s,
>> +                             &s->opaque_blobs,
>> +                             sizeof(s->opaque_blobs),
>> +                             false);
>> +
>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
>> +                             NULL, fw_blob_write, s,
>> +                             &s->fw_blob,
>> +                             sizeof(s->fw_blob),
>> +                             false);
>> +
>> +    /*
>> +     * Add global capability fw_cfg file. This will be used by the =
guest to
>> +     * check capability of the hypervisor.
>> +     */
>> +    s->capability =3D cpu_to_le16(CAP_VMFWUPD_MASK | =
VMFWUPDATE_CAP_EDKROM);
>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
>> +                    &s->capability, sizeof(s->capability));
>> +
>> +    s->plat_bios_size =3D get_max_fw_size(); /* for non-pc, this is =
0 */
>> +    /* size of bios region for the platform - read only by the guest =
*/
>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
>> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
>> +    /*
>> +     * add fw cfg control file to disable the hypervisor interface.
>> +     */
>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
>> +                             NULL, NULL, s,
>> +                             &s->disable,
>> +                             sizeof(s->disable),
>> +                             false);
>> +    /*
>> +     * This device requires to register a global reset because it is
>> +     * not plugged to a bus (which, as its QOM parent, would reset =
it).
>> +     */
>> +    qemu_register_reset(fw_update_reset, dev);
>=20
> Shouldn't we use qemu_register_resettable() instead?

OK will do in v3.

>=20
>> +}
>> +
>> +static Property vmfwupdate_properties[] =3D {
>> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void vmfwupdate_device_class_init(ObjectClass *klass, void =
*data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    /* we are not interested in migration - so no need to populate =
dc->vmsd */
>> +    dc->desc =3D "VM firmware blob update device";
>> +    dc->realize =3D vmfwupdate_realize;
>> +    dc->hotpluggable =3D false;
>> +    device_class_set_props(dc, vmfwupdate_properties);
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +}
>> +
>> +static const TypeInfo vmfwupdate_device_info =3D {
>> +    .name          =3D TYPE_VMFWUPDATE,
>> +    .parent        =3D TYPE_DEVICE,
>=20
> What is the qdev API used here? Why not use a plain object?

I wrote this taking vmcoreinfo device as starting point. I will leave =
this as is for now unless anyone has strong opinions.

>=20
>> +    .instance_size =3D sizeof(VMFwUpdateState),
>> +    .class_init    =3D vmfwupdate_device_class_init,
>> +};



