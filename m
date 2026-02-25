Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC5EEFD23B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBSl-0005a4-5S; Wed, 25 Feb 2026 04:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvBSa-0005Zu-Qi
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvBSW-0007Sj-Qk
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772012731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OlCQQbGfurZenttpd7jJ2HV53F8Mspw1FWCcMJvTOLU=;
 b=YRhxY3Q23X2ZR8El5UazY72aJBMhSy1oKN6bcp66NByaBXeTuakgbawjodlxRjfNUFAz5H
 I3M3XQgRcWagw8U9gqFfSa0K+1KR6+61MNStwj5IZcWS7m74J/0BoNxlu+dgTC2VW5fvM/
 f1mrkP+4eRtNKvG/V6NpQTY4CDiTJYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-ctBMvmMsNF6XE_3UhMALZw-1; Wed, 25 Feb 2026 04:45:30 -0500
X-MC-Unique: ctBMvmMsNF6XE_3UhMALZw-1
X-Mimecast-MFC-AGG-ID: ctBMvmMsNF6XE_3UhMALZw_1772012729
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43768240a29so708994f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 01:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772012729; x=1772617529; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlCQQbGfurZenttpd7jJ2HV53F8Mspw1FWCcMJvTOLU=;
 b=P9Rc0GsIffnlQ+3AmnknGTve8y0a+hBDUr2nv83Jw1CyHtComFhszl6XCvsw0TXaD6
 gPVnQ0f0YdHCmJ8q9Jf57Pwy/+1GCThcdWWrbkTMXICQuUXRaO5AzLvb4P3+QpH5Zxov
 ZEwXlhUwhrUwgWmSRlCGByt5aD8VV9wEX2ffH28vxgxwmK3WEb1eHbw21adPQQmbItnU
 +imEkn5PMXsm4+y8WAvDeSYSpwcB6m6yidtcwg6o3rtOuL2g6+9xtvzegxbc6nug6Z/3
 Dxt61muB1UvgETEo8ZXT+zmBAXzhYcAIbhYLDO/Oi0u7MmTl81ETWE8iFGv87jgedG8T
 J34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772012729; x=1772617529;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OlCQQbGfurZenttpd7jJ2HV53F8Mspw1FWCcMJvTOLU=;
 b=GCbs2WzvOB1ZLOBdehkGk7iU6o3xF/bwsY4j0Fr6RhpZsT32aWvn+KX7dRIlUHO0gk
 C73IORH6gzIFnm24bZWQvyo9sQaohOQG7SHic0lQiZoddsuKF/J7tH22TKdIUlTM4Jvb
 InQPiy5QFvYcrJQxjGT2CK0vX8KAAf5b96A/5+PMX+/sWeyKzO/TXWLuV/ILfVef9B09
 lG+WjpEZJ4U2z7UPgwguIG1kRmPmYPqESyIAH75PRXJvP0KZMJGYmIJyjYLodEa2112T
 q8XerQCZFcQwj5SkfnpBFw6DbPLAkF1B+LJEgzSCUiBhzw3lhj3GfwvcniRCBb2MIaqJ
 Gchg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKw0k+k5PTXRQRU/s/JZOY240v/5/boRekpIhwKEjgTilW3+3jnEgokbyV9C2FHHqc0sn7OdlZgCzR@nongnu.org
X-Gm-Message-State: AOJu0YxdQMV7w0Kv8CTubRcEq1uVzmdi2q8PVDZFnyMF1oZ5yr6vlWhF
 qUxlKTsQx1shU6yaj3gIRLp7XC1AUaVE6pGggbJNE2z1dPic/v06gh96f3vro8G5nFfBjr8uJ9N
 Q1lKKdFY7BO9ENiAj6ApnOjO2mvFnDgfBJ5gC1CuyZLcQCqMhNXWZyswB
X-Gm-Gg: ATEYQzxtK8ZibEfwW/05X5OjgUyawpKOwtNz96HWHKfMkqcrKYHaRz59yeIfrIy3dOu
 fZHlhicvEyU0P7Sc6Fury5htbeZ/YN7I1Aff8yTmfEXI1t12JVmhQL0mz/dtknwcDMiMSU+5uDO
 KYRF3iE/RJx70QqEomNTeZ0Q7z8IvbmlkPLPA099Jv8zJGdcilk81xaG69HIBo5LebK/QH8hcN6
 aEGdLTourzEzZ+a1FbpDywdqUBsDYOE/meEIy8OvZqMX6ovJbfD+UTeFQIeNws2z9UqKgXL2EhV
 OzZ5JGve69oSoviGJnFqhBm1erargYM/qT2IFmcUH3IPb9ShQA7E12UtBu+6MHHW1lUyn6q0oZx
 kK8v7p9AX/B5PahJbbkdLNOrmtTgLpV8rzhpneoyeWKh2Dk8sdD84VN+nF+G0Az5oy1jU7w==
X-Received: by 2002:adf:fe90:0:b0:435:9635:2943 with SMTP id
 ffacd0b85a97d-4398d84773cmr3856398f8f.17.1772012728987; 
 Wed, 25 Feb 2026 01:45:28 -0800 (PST)
X-Received: by 2002:adf:fe90:0:b0:435:9635:2943 with SMTP id
 ffacd0b85a97d-4398d84773cmr3856357f8f.17.1772012728524; 
 Wed, 25 Feb 2026 01:45:28 -0800 (PST)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43990c38516sm2693130f8f.30.2026.02.25.01.45.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Feb 2026 01:45:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87342pw4l8.fsf@pond.sub.org>
Date: Wed, 25 Feb 2026 15:15:08 +0530
Cc: Daniel Berrange <berrange@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, Prasad Pandit <pjp@fedoraproject.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17EC5D9A-9C8E-49D9-AA54-682616691872@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <CAE8KmOyjB1NEtBVQ2QDiDZrPoem3eTWEi-Ht_mJZQNa-H=5iNQ@mail.gmail.com>
 <aZ670CAG40j1r2PJ@redhat.com> <87342pw4l8.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
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



> On 25 Feb 2026, at 3:02=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
>> On Wed, Feb 25, 2026 at 11:35:15AM +0530, Prasad Pandit wrote:
>>> On Wed, 25 Feb 2026 at 09:23, Ani Sinha <anisinha@redhat.com> wrote:
>>>> Currently the code that adds a migration blocker does not check if =
the same
>>>> blocker already exists. Return an EEXIST error code if there is an =
attempt to
>>>> add the same migration blocker again. This way the same migration =
blocker will
>>>> not get added twice.
>>>>=20
>>>> Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>> migration/migration.c | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>=20
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index a5b0465ed3..1eb75fb7fb 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, =
unsigned modes, Error **errp)
>>=20
>> This method has an  '**errp' parameter.....
>>=20
>>>> {
>>>>     for (MigMode mode =3D 0; mode < MIG_MODE__MAX; mode++) {
>>>>         if (modes & BIT(mode)) {
>>>> +            if (g_slist_index(migration_blockers[mode],
>>>> +                                 *reasonp) >=3D 0) {
>>>> +                return -EEXIST;
>>=20
>> .... so using  -errno for return values is not appropriate - it must
>> set 'errp' and return -1.
>=20
> Yes, it must set @errp on failure.  Returning -1 would be wrong,

Ok so just

diff --git a/migration/migration.c b/migration/migration.c
index 1eb75fb7fb..dc75d2eeb6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1704,6 +1704,8 @@ static int add_blockers(Error **reasonp, unsigned =
modes, Error **errp)
         if (modes & BIT(mode)) {
             if (g_slist_index(migration_blockers[mode],
                                  *reasonp) >=3D 0) {
+                error_propagate_prepend(errp, *reasonp,
+                                        "migration blocker already =
added ");
                 return -EEXIST;
             }
             migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],


> because:
>=20
>    int migrate_add_blocker_modes(Error **reasonp, unsigned modes, =
Error **errp)
>    {
>        if (is_only_migratable(reasonp, modes, errp)) {
>            return -EACCES;
>        } else if (is_busy(reasonp, errp)) {
>            return -EBUSY;
>        }
>        return add_blockers(reasonp, modes, errp);
>    }
>=20
> If callers don't actually care for error codes, the entire nest of
> functions could be simplified to return 0/-1 or true/false.
>=20
>>>> +            }
>>>>             migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],
>>>>                                                        *reasonp);
>>>>         }
>>>=20
>>> * Looks okay.
>>> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>>>=20
>>> Thank you.
>>> ---
>>>  - Prasad
>>>=20
>>>=20
>>=20
>> With regards,
>> Daniel



