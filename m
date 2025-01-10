Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23578E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 03:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW5wO-0000gS-G2; Thu, 09 Jan 2025 22:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tW5wN-0000gJ-CB
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 22:44:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tW5wL-0001Iw-Qn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 22:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736480642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=usqWzBORKAf6gLugqnYhFz6KePYWI3eczL+TJeQyYnk=;
 b=ds9czTSWC8puw66hpFyX4lh3ERsURUiFc6iE22pHA0tvDt++fN/x0NrKhfHXNToyv0SLRv
 xWPZnRCtQUqVzpzQOqwtErPOEmNDDifuYvDzgLRbsmvXfS+kHvYnfu85XYb4zPcAcCItRU
 fuqx8gIVnQMcqmSAZEIzjkza5UPIXYo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-Siockem6Oh-8mXEeneJqjg-1; Thu, 09 Jan 2025 22:44:00 -0500
X-MC-Unique: Siockem6Oh-8mXEeneJqjg-1
X-Mimecast-MFC-AGG-ID: Siockem6Oh-8mXEeneJqjg
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2166a1a5cc4so27224175ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 19:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736480639; x=1737085439;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usqWzBORKAf6gLugqnYhFz6KePYWI3eczL+TJeQyYnk=;
 b=KAUsUat+2lXTiTIb+N6brlZyfqsBHWbzo5TS7qfFCfluDFpEM10zLST8OrBWvJAKiM
 XzmmPKtIhMhMQ2urSHoGrHCc3K8cESqbVHSLxEmQ4RLH/Tp0Ao8dIYa1fxThjePq5yyF
 tnfgdx85mxuRM+z6tyIcFyMxr9jJvZ+CL6ZEnY8Bh34caNkGnn8V6Q5nzaD9MW4BDS60
 GL9klxta8zdTahEbk6t1qKr20zcNP7uKZgURIX+gaCYMuSZW5BlLgSvZC4hwmdGUN0XY
 ZBalEKUHOhQ+guh2dR7UWKJ5Vplm0khORW3JSmZ72icu6Y2EosuHzVzGJsiAz+IOv72L
 o1YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+HT4XeB8sqYQro2KdPqvvmD4+4mPjtKVX/+7+y7FgMO3HRk66DdGZBcKVjoWvkXJoGrgaJj6YQ+Dc@nongnu.org
X-Gm-Message-State: AOJu0YxBfibn7rbl74X/OMMiuEyOhQS8ZrCllNuTMvfYSJA2KBEJM6Ms
 /UOfmH9InZ+Lw9bNev8RubZp+DEiyDzDk70vkbc3sHigITNwRFG04TrXQxcFBBuNkT8/XQ2Rpte
 yamij4T69WfTvhiBSKBC0a7cmwrJbNKyNX5XA0PWjEP6oIX08xmxz
X-Gm-Gg: ASbGnct1i9P/4lwUJYZbpPbseb5SMRJhG1IW9Y70HWG7o5JI6WeO4hdp95v2KnLghsr
 Bh7J1493GHxlTA/hfQo7/Jw4kLmqROhEZjbvodJV+OINevIkIPep/CZqWfnDaYDW1OizZ2eCyW9
 3lL/OmLp13RMYo5g+hUQClv3qtJio/FinytHGmw5TkCr0xNUG40LvebYheWUwC7ka9hAWOMj6ax
 +6d9diNQQZ7zeNEzI87lyTDMmVNKCGuUfx2FP2gQVzxKjPobYSdrFYpGOxtR7mtrh78Q7Vx0g==
X-Received: by 2002:a17:902:e84f:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-21a83fc6db1mr125081605ad.41.1736480639565; 
 Thu, 09 Jan 2025 19:43:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu2a+eAslfoSbkjtqO4fSZRIwOH+vSnvJ57g7NPGYJbUnOAtw/A7p/KtBfS0rVJvft3wRSlg==
X-Received: by 2002:a17:902:e84f:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-21a83fc6db1mr125081405ad.41.1736480639214; 
 Thu, 09 Jan 2025 19:43:59 -0800 (PST)
Received: from smtpclient.apple ([203.163.238.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10e406sm5156205ad.51.2025.01.09.19.43.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2025 19:43:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v4 1/2] libqos/fw_cfg: refactor file directory iteraton to
 make it more reusable
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87ldvjeozi.fsf@suse.de>
Date: Fri, 10 Jan 2025 09:13:43 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A06D2E73-EDED-4038-B885-F3C1987BD4E9@redhat.com>
References: <20250109074929.252339-1-anisinha@redhat.com>
 <20250109074929.252339-2-anisinha@redhat.com> <87ldvjeozi.fsf@suse.de>
To: Fabiano Rosas <farosas@suse.de>
X-Mailer: Apple Mail (2.3776.700.51.11.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10 Jan 2025, at 1:31=E2=80=AFAM, Fabiano Rosas <farosas@suse.de> =
wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> fw-cfg file directory iteration code can be used by other functions =
that may
>> want to implement fw-cfg file operations. Refactor it into a smaller =
helper
>> so that it can be reused.
>>=20
>> No functional change.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/libqos/fw_cfg.c | 63 =
++++++++++++++++++++++++-------------
>> 1 file changed, 41 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/tests/qtest/libqos/fw_cfg.c =
b/tests/qtest/libqos/fw_cfg.c
>> index 89f053ccac..f1ed4898f7 100644
>> --- a/tests/qtest/libqos/fw_cfg.c
>> +++ b/tests/qtest/libqos/fw_cfg.c
>> @@ -60,6 +60,39 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>>     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>> }
>>=20
>> +static bool
>> +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
>> +                uint16_t *sel, uint32_t *size)
>> +{
>> +    g_autofree unsigned char *filesbuf =3D NULL;
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
>=20
> g_malloc already aborts the program if the allocation fails.

ok good point. Will remove them in the next patch spin-up.=20

>=20
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
>> +    pdir_entry =3D (FWCfgFile *)(filesbuf + sizeof(uint32_t));
>> +    for (i =3D 0; i < count; ++i, ++pdir_entry) {
>> +        if (!strcmp(pdir_entry->name, filename)) {
>> +            *size =3D be32_to_cpu(pdir_entry->size);
>> +            *sel =3D be16_to_cpu(pdir_entry->select);
>> +            found =3D true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    return found;
>> +}
>> +
>> /*
>>  * The caller need check the return value. When the return value is
>>  * nonzero, it means that some bytes have been transferred.
>> @@ -75,32 +108,18 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, =
uint16_t key)
>> size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>>                       void *data, size_t buflen)
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



