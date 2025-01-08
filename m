Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1762DE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVVx4-0001gX-QD; Wed, 08 Jan 2025 08:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVVwy-0001fn-AH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVVwr-0008VW-Tw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736342291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTP7qy7fRiKgoruIX8IBnlVO9yZstkYPYCicj6/pmfE=;
 b=K6suIfEKdCPShCGXDZ5WWroqih8gnow5ujI2An+YEWUPhtjEv7Q0I5DpCoJ6PWGhi8u3Rt
 cVVJMBQOaVdipxF0YMr3sSoEdF1EdAx8gam3vYqfwrYNdHXACvT92sUDndSWXHJv7x9R4M
 aEQBaeHuFplv2S8x4iwUYOTcQuG5WMo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-tYXoCYfINA2MRwB0e0HJIQ-1; Wed, 08 Jan 2025 08:18:10 -0500
X-MC-Unique: tYXoCYfINA2MRwB0e0HJIQ-1
X-Mimecast-MFC-AGG-ID: tYXoCYfINA2MRwB0e0HJIQ
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2166a1a5cc4so227377595ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 05:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736342289; x=1736947089;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTP7qy7fRiKgoruIX8IBnlVO9yZstkYPYCicj6/pmfE=;
 b=IeN63LUEy2PpWdM//7VT8bz5eelcXenZrUU/MF/bRBPN2bThMrVqi0ThlY/qA6xbCk
 uunsh44ftn4y+OfcH6Xa8U4icR1D5wOSRcp5bSK3PZ45dRHrKdSz5KKfNCmPW1c1v95v
 emKgGO2eEzia6sqVQt/ntjbiDgU81+dEgt+Z8ztmoKDO14Ro+qqUQYFQuvbJG9n4nDgF
 sKl49PC9p8dSTB12KUL9Lw3HmhSwp4GOdS74+RbXfG6TtT8LoVJJqq/Lcl8MgI+oGqrB
 iANATTETzoFKc0RSPWIbI9FNV2IzSGoUOYfYtxlipVBsGCdj+uIR4EWGEcEqqWET1nad
 iwkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL9+zf1vEPrhVtRPcaBN3PXJn+kc30d1ZkNQWPbzr3HIKuPFIG6S9SFE2Cv6yRPwmNf7mi9pZjgRrO@nongnu.org
X-Gm-Message-State: AOJu0YyZDQGC3isrz9c9VUA0uLQKR/MS4EigoSkOqBRKPCri06AiVqkO
 vJPt8UqxRt+Ab6fglNLD0uF4yuMV2fOalaTdpbtbZxSCgYiNCeMd7xHyKx36AKNTamhtU+zNM+B
 sFRqPvBjygu9Ci5JB3CNKR6zxS61eTQLJ+VYf2mMFk/etsufKH8/f
X-Gm-Gg: ASbGnctWtbANr0ZeAxqKx8e6hePsMuRWonJOCZd4maMWKc4YkpYDDBU5IQ7J9Cp1B9h
 QpKpd40VPuDtHD5+vXVHsjyrqQCUNKq/jRlWYMs7/x88pKxM+vYT0ugvnS5KuLYn6jbAVxdxka0
 sqGMfo9SrdcVSxk3dV2aW3iTO04HLF6kyaX2O27IMK2p9pfp2ulZxajV3zJqBrJgAKloZ2Xhjct
 MDYN3e42PXDrSf6E6RhjWgEFPItHXRt8MMzv5iwcPyHUcE/eDe4JCENaHre4E1vP89Q2PIucQ==
X-Received: by 2002:a17:902:e84f:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-21a83fc6db1mr34751025ad.41.1736342289087; 
 Wed, 08 Jan 2025 05:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWOuuYqAD7QoQJSD5OFzZDFxFnYDaLo+h39tEJwUcsJOTC4N+lkfBMj2fl0QbRjb8Ji+XlKw==
X-Received: by 2002:a17:902:e84f:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-21a83fc6db1mr34750735ad.41.1736342288688; 
 Wed, 08 Jan 2025 05:18:08 -0800 (PST)
Received: from smtpclient.apple ([202.88.221.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cdeb6sm325370775ad.163.2025.01.08.05.18.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2025 05:18:08 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <Z354ytFhuJnohBXx@redhat.com>
Date: Wed, 8 Jan 2025 18:47:25 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <591DC037-7D47-4DE0-B83E-E1A1BC452175@redhat.com>
References: <20250108125751.199929-1-anisinha@redhat.com>
 <Z354ytFhuJnohBXx@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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



> On 8 Jan 2025, at 6:38=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Wed, Jan 08, 2025 at 06:27:50PM +0530, Ani Sinha wrote:
>> At present, the libqos/fw_cfg.c library does not support the modern =
DMA
>> interface which is required to write to the fw_cfg files. It only =
uses the IO
>> interface. Implement read and write methods based on DMA. This will =
enable
>> developers to write tests that writes to the fw_cfg file(s). The =
structure of
>> the code is taken from edk2 fw_cfg implementation. It has been tested =
by
>> writing a qtest that writes to a fw_cfg file. This test will be part =
of a
>> future patch series.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/libqos/fw_cfg.c | 204 =
++++++++++++++++++++++++++++++++----
>> tests/qtest/libqos/fw_cfg.h |   5 +
>> 2 files changed, 186 insertions(+), 23 deletions(-)
>=20
>> +static bool
>> +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
>> +                uint16_t *sel, uint32_t *size)
>> +{
>> +    unsigned char *filesbuf =3D NULL;
>=20
> Use g_autofree here instead of later g_free.

OK will send just a refactoring patch with this change.

>=20
>> +    uint32_t count;
>> +    size_t dsize;
>> +    FWCfgFile *pdir_entry;
>> +    uint32_t i;
>> +    bool found =3D false;
>> +
>> +    *size =3D 0;
>> +    *sel =3D 0;
>> +
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
>> +    count =3D be32_to_cpu(count);
>> +    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
>> +    filesbuf =3D g_malloc(dsize);
>> +    g_assert(filesbuf);
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
>> +    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
>=20
> I'm not familiar with fwcfg data format, but I'm wondering
> what the initial 'uint32_t' data field is that you're skipping
> over, and whether its value should be validated before this
> loop ?

This part I left as is from previous code. =46rom =
https://www.qemu.org/docs/master/specs/fw_cfg.html

struct FWCfgFiles {         /* the entire file directory fw_cfg item */
     uint32_t count;        /* number of entries, in big-endian format =
*/
     struct FWCfgFile f[]; /* array of file entries, see below */
};

struct FWCfgFile {       /* an individual file entry, 64 bytes total */
    uint32_t size;       /* size of referenced fw_cfg item, big-endian =
*/
    uint16_t select;     /* selector key of fw_cfg item, big-endian */
    uint16_t reserved;
    char name[56];       /* fw_cfg item name, NUL-terminated ascii */
};

So the code first reads the count and then allocates =E2=80=98count' =
entries for =E2=80=98count' files.

>=20
>> +    for (i =3D 0; i < count; ++i, ++pdir_entry) {
>> +        if (!strcmp(pdir_entry->name, filename)) {
>> +            *size =3D be32_to_cpu(pdir_entry->size);
>> +            *sel =3D be16_to_cpu(pdir_entry->select);
>> +            found =3D true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    g_free(filesbuf);
>> +    return found;
>> +}
>=20
>> +
>> /*
>>  * The caller need check the return value. When the return value is
>>  * nonzero, it means that some bytes have been transferred.
>> @@ -73,37 +168,100 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>>  * populated, it has received only a starting slice of the fw_cfg =
file.
>>  */
>> size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>> -                      void *data, size_t buflen)
>> +                        void *data, size_t buflen)
>> {
>> -    uint32_t count;
>> -    uint32_t i;
>> -    unsigned char *filesbuf =3D NULL;
>> -    size_t dsize;
>> -    FWCfgFile *pdir_entry;
>>     size_t filesize =3D 0;
>> +    uint32_t len;
>> +    uint16_t sel;
>>=20
>> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
>> -    count =3D be32_to_cpu(count);
>> -    dsize =3D sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
>> -    filesbuf =3D g_malloc(dsize);
>> -    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
>> -    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
>> -    for (i =3D 0; i < count; ++i, ++pdir_entry) {
>> -        if (!strcmp(pdir_entry->name, filename)) {
>> -            uint32_t len =3D be32_to_cpu(pdir_entry->size);
>> -            uint16_t sel =3D be16_to_cpu(pdir_entry->select);
>> -            filesize =3D len;
>> -            if (len > buflen) {
>> -                len =3D buflen;
>> -            }
>> -            qfw_cfg_get(fw_cfg, sel, data, len);
>> -            break;
>> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
>> +        filesize =3D len;
>> +        if (len > buflen) {
>> +            len =3D buflen;
>>         }
>> +        qfw_cfg_get(fw_cfg, sel, data, len);
>>     }
>> -    g_free(filesbuf);
>> +
>>     return filesize;
>> }
>=20
> I'd recommend refactoring of existnig code, be a separate commit
> from the newly added functionality.

Yes will do that.

>=20
>>=20
>> +/*
>> + * The caller need check the return value. When the return value is
>> + * nonzero, it means that some bytes have been transferred.
>> + *
>> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
>> + * buffer, then the first len bytes were read.
>> + *
>> + * If the fw_cfg file in question is larger than the passed-in
>> + * buffer, then the return value explains how much was actually =
read.
>> + *
>> + * It is illegal to call this function if fw_cfg does not support =
DMA
>> + * interface. The caller should ensure that DMA is supported before
>> + * calling this function.
>> + *
>> + * Passed QOSState pointer qs must be initialized. qs->alloc must =
also be
>> + * properly initialized.
>> + */
>> +size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char =
*filename,
>> +                         void *data, size_t buflen)
>> +{
>> +    uint32_t len =3D 0;
>> +    uint16_t sel;
>> +    uint32_t id;
>> +
>> +    g_assert(qs);
>> +    /* check if DMA is supported since we use DMA for read */
>> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
>> +    g_assert(id & FW_CFG_VERSION_DMA);
>> +
>> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
>> +        if (len > buflen) {
>> +            len =3D buflen;
>> +        }
>> +        qfw_cfg_read_entry(fw_cfg, qs, sel, data, len);
>> +    }
>> +
>> +    return (size_t) len;
>=20
> The size_t cast is redundant, since we know sizeof(size_t)
> will be >=3D sizeof(uint32_t) on all platforms
>=20
>> +}
>> +
>> +/*
>> + * The caller need check the return value. When the return value is
>> + * nonzero, it means that some bytes have been transferred.
>> + *
>> + * If the fw_cfg file in question is smaller than the allocated & =
passed-in
>> + * buffer, then the buffer has been partially written.
>> + *
>> + * If the fw_cfg file in question is larger than the passed-in
>> + * buffer, then the return value explains how much was actually =
written.
>> + *
>> + * It is illegal to call this function if fw_cfg does not support =
DMA
>> + * interface. The caller should ensure that DMA is supported before
>> + * calling this function.
>> + *
>> + * Passed QOSState pointer qs must be initialized. qs->alloc must =
also be
>> + * properly initialized.
>> + */
>> +size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char =
*filename,
>> +                          void *data, size_t buflen)
>> +{
>> +    uint32_t len =3D 0;
>> +    uint16_t sel;
>> +    uint32_t id;
>> +
>> +    g_assert(qs);
>> +    /* write operation is only valid if DMA is supported */
>> +    id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
>> +    g_assert(id & FW_CFG_VERSION_DMA);
>> +
>> +    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
>> +        if (len > buflen) {
>> +            len =3D buflen;
>> +        }
>> +        qfw_cfg_write_entry(fw_cfg, qs, sel, data, len);
>> +    }
>> +    return (size_t) len;
>=20
> Another redundant cast
>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|



