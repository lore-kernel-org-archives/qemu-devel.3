Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C1ACDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLOU-0006aO-QL; Wed, 24 Jun 2026 07:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcLOT-0006ZW-3b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcLOR-0004z0-Gs
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782299022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAuJQeDI1ET89MnncSAnJANGC2hjZsyjNFcamlpACtk=;
 b=GF+NaQnp5cC9QZnHFQ4osia2RS5jQh3XaFp+FvB3UfmDxBdpF0zbsydFFjh0e3yHb+uSUO
 Xbfti4iNXLi9JSguVgVLi30HpABN8HX8tcUIrCtGSSHwl2gS7btkbDbDIQKwNsMZOvfM9A
 trVq77zVp+3DtGUNJwCQCPpfEM5QB10=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-cqYX01WMNaSP6uE68n855g-1; Wed, 24 Jun 2026 07:03:40 -0400
X-MC-Unique: cqYX01WMNaSP6uE68n855g-1
X-Mimecast-MFC-AGG-ID: cqYX01WMNaSP6uE68n855g_1782299020
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8428419982eso1124777b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782299020; x=1782903820; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAuJQeDI1ET89MnncSAnJANGC2hjZsyjNFcamlpACtk=;
 b=drn69fq9/RG1iCvTkkkLe59okZXh5rpOmf5AxYyW8TTUcXHytvIofA9LKQ9Ucs5KQw
 QvjcsqvbTyfXtrvOzuZ07qIkuCSVkhA9qIzTMMZ/QSL7RLD5DgUPC85Ik71EvHNBI7JJ
 SepfuoitYQBVzQFdHtWItpW6BmnHpngCYfjgZpCBqJ8AA81zLrNaBpOQM9/MtBApLlh1
 qq9Sk1NJhmR6Lu+WYl7kCrDwB/9cUTszdNHUdYfzjiiKDDbt/8SHdJ6Yk+cI9nib7H7w
 K4ICZYRNF0k1jbkpAvgm9lD+bOtgurIuFKMeLEn1EJ242smkMQyxS1CiMihLfBtyLtoW
 Ro8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782299020; x=1782903820;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bAuJQeDI1ET89MnncSAnJANGC2hjZsyjNFcamlpACtk=;
 b=bWDlUWcijUXQNbCteOE0+SIIATtNKWMBEJ0lpG80QpfDZRihw2xKLsoqMQ/RLy2zaB
 caQJBV3uwB9wAbJlYt9uyN4HuFAFSQ2DmyVj2OJP7eb6adrkLijIGvXmf25szigwI1rJ
 0vMinuj7htXCYNzBjVPySGNaX6F4u2Pxk1bmvLa6L18ikLYyi7WHe+paRvcNjOpHkSpg
 Hbb9Gp0aP4ALqrKDcwi5D9Boq5vWB28NIjZo0WZP8hB8Q55aT3J/obi2TmWiumlvOCS3
 qlQoQDdlcar2M/t9k6Orv4pOOpwDtdDgYRpl9C6TvkAcbEEQUEBl+hWVxI+xEO12V/Gj
 tT9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wpNR1Da1CXUCMrlvQDzDVjnynDlGEmdgTuTZyrV5wmMyftqOPITOIG2htBQDqEHtXjurJCNgTDB4C@nongnu.org
X-Gm-Message-State: AOJu0YwOrYBY6uOyCD2f2QUFoMU6SxzIdLHbPKeOws4Y8Ex9sI+JAKuQ
 3CUhAYx1m8yxG/lV4H2y2cxZx75F2kxWKNT1xtp+Xa/UoWxELE3Qxa2rS/FSsJUie0Sz7zxvoDX
 d8vd2sq6Neebo+8FCmbu/9c42FzETM//3KlM7DD4iTC/DU+BjCjD5eHEU
X-Gm-Gg: AfdE7ckKstUYVOu1YxeNA7lgjhr13KBUiAtiMKGkgRHpOfVxvErsZJwIEI4V1FY0yji
 nIS16hugewkcI6Cz5pXLto8xo1CHdJ8zQ8dhXtuEA3puS9rTX5UmAiADU4hyBWMoTgkNdmDpA45
 ztFC8AzM1nC3zARxc4qM8MfRDAqP+XtzxdVXBvDGy/BKM1WOk0meU+JiVijYMteSZ5oKOpd0wTm
 ojtSwOAZ+ePBfOIXHIw/ok0kTfigchj7A7z3yfb5+7A5LYIFMgen9RvAJW0pGjTT5j+mrwZvtpC
 EjEj5fgW+QAfMpkXEV4DueXR0VCBA30PRkRWn3pGBdigGiyItnFGCvM1isPDlOV4jYYl+KkSC7u
 i2ISCbRgJ3W6Nb+nOGVFDh+I8Cy3zrvLpVpy94z1dHBrq6PyQET3kaX+pk/eKuU6d
X-Received: by 2002:a05:6a00:10cf:b0:842:6849:2180 with SMTP id
 d2e1a72fcca58-845a27c32cemr3559109b3a.37.1782299019464; 
 Wed, 24 Jun 2026 04:03:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:10cf:b0:842:6849:2180 with SMTP id
 d2e1a72fcca58-845a27c32cemr3559067b3a.37.1782299018957; 
 Wed, 24 Jun 2026 04:03:38 -0700 (PDT)
Received: from smtpclient.apple ([110.227.100.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a413f604sm1874882b3a.60.2026.06.24.04.03.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2026 04:03:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ajudPOcejMvGTTJB@sirius.home.kraxel.org>
Date: Wed, 24 Jun 2026 16:33:24 +0530
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alex Graf <graf@amazon.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <602FAB73-36A1-41A0-97AA-7541102F23A4@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
 <ajudPOcejMvGTTJB@sirius.home.kraxel.org>
To: Gerd Hoffman <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 24 Jun 2026, at 2:54=E2=80=AFPM, Gerd Hoffman <kraxel@redhat.com> =
wrote:
>=20
>  Hi,
>=20
>> +static bool disabled;
>=20
> Why is this global?  Should be in VMLaunchUpdateState I think.
>=20
>> +    /* free previous file context */
>> +    if (igvmc->file >=3D 0) {
>> +        igvm_free(igvmc->file);
>> +    }
>> +    g_free(igvmc->filename);
>> +    /* set new context */
>> +    igvmc->file =3D igvm;
>=20
> I'm wondering whenever we should better keep the original file, so we
> have the option to switch back.
>=20
> With a boot workflow like this ...
>=20
>  (1) boot qemu firmware
>  (2) some efi app loads igvm with guest firmware + kernel
>  (3) reset
>  (4) boot guest-supplied firmware
>  (5) guest-supplied firmware boots into the bundled kernel
>      (without even looking at the ESP).
>=20
> ... you are now in a situation where the guest can't load a different
> IGVM file (say with an updated kernel) using the same workflow.

Why? Why would the fw-cfg interface not be used again to reset to a new =
IGVM that loads a new kernel?


>  The
> next reset will go straight to (4) instead of restarting at (1).
>=20
>> +++ b/include/hw/misc/vmlaunchupdate.h
>=20
> I think it makes sense to have two include files, one for the API and
> one for the qemu internals.

Where would you put the api header file?

>=20
>> +typedef struct {
>> +    /* api version */
>> +    uint16_t version;
>=20
> uint8_t padding[6];
>=20
>> +
>> +    /* VMM capabilities, read-only. */
>> +    uint64_t capabilities;
>> +    /* control bits, see VMFWUPDATE_CTL_* */
>> +    uint64_t control;
>> +
>> +    /*
>> +     * address and size of the IGVM image.  Will be cleared when
>> +     * the write completes successfully and IGVM file is correctly =
parsed.
>> +     */
>=20
> I think we should better have an explicit status field, something =
along
> the lines of ...
>=20
> enum VMLaunchUpdateStatus {
> STATUS_UNDEFINED =3D 0,
> STATUS_DISABLED =3D 1,
> STATUS_NO_IMAGE =3D 2,
> STATUS_IMAGE_LOAD_OK =3D 3,
> STATUS_IMAGE_LOAD_FAIL =3D 4,
> }
>=20
> .. instead of signaling success indirectly by clearing fields.  There =
is
> room anyway right after the version field.
>=20
>> +    uint64_t fw_image_addr;
>> +    uint32_t fw_image_size;
>=20
> uint64_t?

I would leave this as 32 bits. 64 bit idvm file size is too big, no?


