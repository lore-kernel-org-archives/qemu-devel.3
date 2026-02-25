Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3FBEFD210
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBIp-00033C-5b; Wed, 25 Feb 2026 04:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvBIK-0002nv-4P
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvBII-0005WV-8E
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772012097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+3GxuGGseWyeTKJtdu3NZS4G6r5UzFnP7ehE1z0SUQ=;
 b=RQb4WWRexFeJoyk1aAxwa3iDL4HWYlbXEpS1yfYuCGIM1A9Qk1g7e+fJu60rHzQeBl0tyJ
 NVs3iMElmFioFxlkA7XZKZRqu6WhDoFbWymG0xvht1onzMTCZup9YvFR1Tr5d6x1cQyw7q
 kWA+y9iCsar6qCQMwK6SAlDOEw3k6Js=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-UU-AtRviPpeVbj9kbMD-9w-1; Wed, 25 Feb 2026 04:34:49 -0500
X-MC-Unique: UU-AtRviPpeVbj9kbMD-9w-1
X-Mimecast-MFC-AGG-ID: UU-AtRviPpeVbj9kbMD-9w_1772012088
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so58886385e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 01:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772012088; x=1772616888; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+3GxuGGseWyeTKJtdu3NZS4G6r5UzFnP7ehE1z0SUQ=;
 b=YdXR/ccf+g2k8Jm2McXkafwo3XwayWu08f9KEdTDUQgVjxRtIfnHqsSgR62QYW/Jbe
 afFMIM95Dl/z4hduk9vAVE5Uh676Ud7PSedtJOQqQFgAujzF8PW5VdCCObPuw0uaTUrs
 BYs7ZMMgiYmE8f7Lt4Ru+UHSx7Nr60vlT872SoC6OgFa/+x+rTnJlSZhb9bnAEGPzvPo
 5OuhiIClAk7XeOqh1mtnOZnwsmjt8+ERFOiIuCUkmzb/KbFJV2myVPmFtwSP9Nr7PbwK
 XSWYNCrQSweej5PwURKI1SYnp4Ogfc+K9PdQ937sOUP6/wmmpDoaSgqmGwOvIs1PJgOX
 52ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772012088; x=1772616888;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+3GxuGGseWyeTKJtdu3NZS4G6r5UzFnP7ehE1z0SUQ=;
 b=cW4ms4u0c0ZThsRd2hjUz+NEHt1/KfedkMuasrPGtPHBbuUk0CskdX96z+Q6D2nLxk
 j0jGeL9X5wTuvfgCTBaNAje/4u7ZMV/siI0c4Ht91/wGiC7TSvfyY5+s9sgd60uA5wUK
 YoyClsHBSXTDkXuY1sVepa6cg1vMeLhB2jtDfuy7wBOwP0irePp8D5/Ry/NR7tVKbUjy
 nHu9ESR5regh7vOg4G9zcl5ru6KKz9XvoX4cOaUXNU1zlwa9OitLPw9h5+N/57a9lzww
 V2NbdYHGdC8yEAtcDlxDg/21hJb5UOCMUDSZJzuLFXuJieGzXRMqsnhT93rqiJOdS0QX
 fMOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/TQwPUdoHLY/MP+W0qqJ9pD+ji2VedAQVXYebL2Eu2oHqjFZJb1VjNq0P8VGLti+rmWMIh9mznRwq@nongnu.org
X-Gm-Message-State: AOJu0YzYMjZ+t0W6BXtRlcJEXvIGlF4+J1KqTr0Hlh9o8Gii+fGwVMFl
 WuJ0iu8lFghqENahKiIacW5czx9+UWUioLUmMSA+EqpPatQtJLUy/nXPJGsdefkjvANZR3WSRxo
 WcCCrleVesv01Y7FzqE97Ym/AZlYBr14f/zNlwLQPAxyZAc03wtVD5Rzj
X-Gm-Gg: ATEYQzw4IiQgaIFMexQxyqVzFQv4GlBl5cC7DuR4bFJXNCBc1GdAzr+HTcO74eFe1ex
 ZIrsiE8aj6UXxFRpLcgF6N2qOIWXnusZlueQiMIYEKAoJfZJ2rvXQcehoqkUn4+/QWkP/SRsULI
 El8NWcW/sEqA0KY0uuSvUS7zFQEVMVJJQ4q1zYdR6/a+5o5Nl5oDleLWCnT0HXs350SFYzuClXt
 Waz6dshqYMqMvjMZYIQbWoTcPmgAlrufHG+3ozQf/hni6m8Akmw+0jYjrYsEn4rXOmMde3zDLso
 gch3FmYJQIa+w7FeD54lwt4sTg5Tv3CQxr9B69IHApeg0/GvY69kc5xQM7O8rjLlpIfM7xXYsq8
 EBEhKJ/nI3w3mYRFMB27ooIJ+gbWLRiFW3pCsCILNaPnZe8eWYCKy5aSB7AeLiYOs9nauBw==
X-Received: by 2002:a05:600c:4f94:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-483a95a8762mr235220355e9.3.1772012088389; 
 Wed, 25 Feb 2026 01:34:48 -0800 (PST)
X-Received: by 2002:a05:600c:4f94:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-483a95a8762mr235219845e9.3.1772012087900; 
 Wed, 25 Feb 2026 01:34:47 -0800 (PST)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd739087sm55577335e9.14.2026.02.25.01.34.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Feb 2026 01:34:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aZ670CAG40j1r2PJ@redhat.com>
Date: Wed, 25 Feb 2026 15:04:27 +0530
Cc: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F4C962C-7068-4F78-BC70-07F0731B1FEB@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <CAE8KmOyjB1NEtBVQ2QDiDZrPoem3eTWEi-Ht_mJZQNa-H=5iNQ@mail.gmail.com>
 <aZ670CAG40j1r2PJ@redhat.com>
To: Daniel Berrange <berrange@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 25 Feb 2026, at 2:37=E2=80=AFPM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Wed, Feb 25, 2026 at 11:35:15AM +0530, Prasad Pandit wrote:
>> On Wed, 25 Feb 2026 at 09:23, Ani Sinha <anisinha@redhat.com> wrote:
>>> Currently the code that adds a migration blocker does not check if =
the same
>>> blocker already exists. Return an EEXIST error code if there is an =
attempt to
>>> add the same migration blocker again. This way the same migration =
blocker will
>>> not get added twice.
>>>=20
>>> Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> migration/migration.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>=20
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index a5b0465ed3..1eb75fb7fb 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, =
unsigned modes, Error **errp)
>=20
> This method has an  '**errp' parameter.....
>=20
>>> {
>>>     for (MigMode mode =3D 0; mode < MIG_MODE__MAX; mode++) {
>>>         if (modes & BIT(mode)) {
>>> +            if (g_slist_index(migration_blockers[mode],
>>> +                                 *reasonp) >=3D 0) {
>>> +                return -EEXIST;
>=20
> .... so using  -errno for return values is not appropriate - it must
> set 'errp' and return -1.

I see functions migrate_add_blocker_modes() or =
migrate_add_blocker_internal() that do not do this. This is why I =
thought it was ok to just return -errno here.


>=20
>>> +            }
>>>             migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],
>>>                                                        *reasonp);
>>>         }
>>=20
>> * Looks okay.
>> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>>=20
>> Thank you.
>> ---
>>  - Prasad
>>=20
>>=20
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange =
:|
> |: https://libvirt.org          ~~          https://entangle-photo.org =
:|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com =
:|



