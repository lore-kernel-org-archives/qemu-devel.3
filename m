Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4227BFD4609
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvSLC-0001w5-80; Wed, 25 Feb 2026 22:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvSLA-0001vs-Tf
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvSL9-0001cI-Cu
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772077622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUuRHlWNvAPIAbIBs9rvGgo8roSfRT9XxNcFJ5AjB0M=;
 b=hXrn0MqOGtOIxOuf5FMgIlEKHbNREIk0xrgpO3Q9u7ynCUUU3TVBo6DTNvaysSICZvGboD
 PgmWUXvtzCYlH6QONHpeawIFLJRpToF9eZv/LkBD2QFSB9vTbxTmrXz/QH/cZdywYWDziW
 0Yr2/QKT2G7QuAPYm2fgRJCPbUdbUO0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-_ZQbbYYhPISHjMiNDBHCbQ-1; Wed, 25 Feb 2026 22:47:00 -0500
X-MC-Unique: _ZQbbYYhPISHjMiNDBHCbQ-1
X-Mimecast-MFC-AGG-ID: _ZQbbYYhPISHjMiNDBHCbQ_1772077619
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c70dd30025fso1296093a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 19:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772077619; x=1772682419; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JUuRHlWNvAPIAbIBs9rvGgo8roSfRT9XxNcFJ5AjB0M=;
 b=gcMKlkDt7/tc3GKyhjxEpMA8DUjyPOKPh0fTLn+UPuyZLM/2W1V3enoJU60N3/Pdgq
 xp3VOn+q3Nwl03irbCf6/BoMpmhL6rPjy5nILHQzeaELDOk1YlvfZQqmrBxZCV06EKyt
 W3Wn3SYCHRxJ+T3G3WrU7LBmOBBNvP/M4ucnYcvpw3dqKojqDCGzTP+AJofQGYXlrZPx
 VZPfAbIjogIGexmLjlPKCiH/3Gp9dYU8avmKDw3lE4oaS5HJhv3ERgChOhn7DkNXTyVf
 OYl5qvS/YB+N3R8amcWwZJ1K8Cu3W83ObImfVCGX+hMTVGKhywkj5z3X8lODJ/DdxC+0
 8izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772077619; x=1772682419;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUuRHlWNvAPIAbIBs9rvGgo8roSfRT9XxNcFJ5AjB0M=;
 b=p3dldiL5EXF1R11jow2vMyg+t94PC7kzx2g38zLCPWxq00Auu5A/3CerMWjSrPG9KC
 /T+7qMJ9VbC6L7JyiviHfgto7m0DoK8JD61qlCnRbqslcIro552BsVtnsyAnq6JeUQAZ
 w7ICBOSr+DUEwPRtH11PGmCkx7jkiBYiZApJgYfQN4tZojHUljqfyr1zxXlWCwYxDP4t
 iaBGg61sYGNXTyZB4izD0o7mU4Qo34dvlj8Syv9KPU/RQW6c/iR3umpTRFe+ctoX04z6
 DAK+aC5e1G2hJ7K/OWI81qJC4V8trfU1AGpq+2pSof7M38WhVTxRg0jgXbv/eauPGDj3
 TZXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXPjJ+Zg3pv34eCIOLTP/3/cmhDfGphvlpRscprDYl42o1bBDG4LPx9aBWsSiPZyAaSYJqkymDe6MH@nongnu.org
X-Gm-Message-State: AOJu0Yw9Y3zirBhbcWyJkBADp7VMb7mtosxzuxFdbDrj/viDoce+x4lN
 23xfxfEJmNYKuUgB3f39fLTXw+BChnmeEipW9nEy2+uzlDCHr8Wqs26RomGI22yFjcTUWe/OBie
 vLQnUrD0U7Oz3ENyCC+gU6E7x/qAJh7zkVRxzlt3/VIPoQD0NezDewm6P
X-Gm-Gg: ATEYQzzlYdui2P3bqElXiO2r1urVdzNI3BukqaUYuPuR+KKKcAjV/7WEjsq7TE9i2Uo
 QmCXOJ0PZraequoo4qPOVpbbPQy8WWXjViNyvBNwi/l+Eh+i/THOVgWP0c0cq5PrOK1hrIL8uut
 fBhkZKAij9tkQw9W4wtjLswbS8Mzl0VPhb/s0B81eXPbu7ntZkp2goDX3oU3x0Cn6TBrWhJMpto
 rGtkoilpsAj9yvTgTmwad4TnoGT++Xbf8zlrlEzrTa1uFgr8hexEFFksgtKoAx9NA8cmkiKxQat
 XyE5wKucVwmfdoARmetn4pAhWsZ2AL4mArZM95EMEEOcnuo/MJ95sYfyUn94t4leoUN0EZhJfEd
 p/Wt7Pnzz9fJuaI8SRpm6SGPubEbF1QZL9t88xe+Bf0eijKCMyorgjMwYdISHSRPKwW2odg==
X-Received: by 2002:a05:6a00:6c91:b0:827:2d0f:1eda with SMTP id
 d2e1a72fcca58-827337b8a96mr2637021b3a.47.1772077619409; 
 Wed, 25 Feb 2026 19:46:59 -0800 (PST)
X-Received: by 2002:a05:6a00:6c91:b0:827:2d0f:1eda with SMTP id
 d2e1a72fcca58-827337b8a96mr2636997b3a.47.1772077618984; 
 Wed, 25 Feb 2026 19:46:58 -0800 (PST)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a056544sm761554b3a.57.2026.02.25.19.46.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Feb 2026 19:46:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aZ8xlrL2xQtoN9MI@x1.local>
Date: Thu, 26 Feb 2026 09:16:43 +0530
Cc: Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com> <aZ8xlrL2xQtoN9MI@x1.local>
To: Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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



> On 25 Feb 2026, at 10:59=E2=80=AFPM, Peter Xu <peterx@redhat.com> =
wrote:
>=20
> Hi, Ani,
>=20
> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
>> Currently the code that adds a migration blocker does not check if =
the same
>> blocker already exists. Return an EEXIST error code if there is an =
attempt to
>> add the same migration blocker again. This way the same migration =
blocker will
>> not get added twice.
>=20
> Could you help explain why it will inject two identical errors in the =
first
> place, and why the caller cannot make sure it won't be injected twice?

Likely due to a bug in the code. For example if the init function that =
adds the blocker is called again and the caller does not handle the =
second init call properly.
This came up as a part of the coco reset work where migration blockers =
are added in init methods. They need not be added again when init =
methods are again called during the reset process. The caller can handle =
it of course but adding a check further down the call stack makes things =
more robust.


>=20
> Thanks,
>=20
>>=20
>> Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> migration/migration.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a5b0465ed3..1eb75fb7fb 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, =
unsigned modes, Error **errp)
>> {
>>     for (MigMode mode =3D 0; mode < MIG_MODE__MAX; mode++) {
>>         if (modes & BIT(mode)) {
>> +            if (g_slist_index(migration_blockers[mode],
>> +                                 *reasonp) >=3D 0) {
>> +                return -EEXIST;
>> +            }
>>             migration_blockers[mode] =3D =
g_slist_prepend(migration_blockers[mode],
>>                                                        *reasonp);
>>         }
>> --=20
>> 2.42.0
>>=20
>=20
> --=20
> Peter Xu



