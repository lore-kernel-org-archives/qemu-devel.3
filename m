Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28364D68BCB
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8NY-00063l-3x; Thu, 18 Dec 2025 02:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vW8NH-0005x6-2j
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vW8NE-0002HG-BG
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 02:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766042670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3ZtEPXMm9tmuJEBCrK1OA4sYdQysjzwD7qLV1aPcTA=;
 b=Wqh4eIuIjm7G4zi+WoZoSc0QxiNq7m332s7/jPYXhmpIy0HjwRE283MNiRXzYobxtXywwJ
 D+578w32kZLIh7vnt3gQNhnprH73m9n1ITr3T/LH90dHz0uvucw4fo5nNnWAd5NDS5LYzH
 3hxOtGCoqHZveHVKwWsmzAG1n+618Ng=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-LJE4sHKCPCaZ3sY7_sUrAg-1; Thu, 18 Dec 2025 02:24:29 -0500
X-MC-Unique: LJE4sHKCPCaZ3sY7_sUrAg-1
X-Mimecast-MFC-AGG-ID: LJE4sHKCPCaZ3sY7_sUrAg_1766042668
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a0e9e0fd49so16107065ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 23:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766042668; x=1766647468; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3ZtEPXMm9tmuJEBCrK1OA4sYdQysjzwD7qLV1aPcTA=;
 b=jNTYLGX+GWrYKfAURpmM9OTwBT5IVrOi5cuGTSwU9/quGitpG/HOA2VAWMZYS3GF4C
 xZO8bfJ7IBw8fNWzQ4+J76qnXldaV460I5Abcdbzxi9BnXA+xc8+Hhv4UDIxdlF0joq/
 y+4TT7cGmF5wV2pFEBH3kxskztZ3Oq2ymtRagY5mAvRWrXAvoM79oE+1qVxnugZD/ztY
 hC2VpRq5BOgr7REQPZOS2OwB7ezzkrUoJB+Pv8WPeHicqrKRw09UIoIWXm680TilC5xP
 Ss9TZ/useBVQ4YmbNZ25ksKTDqkoZks9KtKproEzR+tx6aDxLlN4GActRKDgOb8y5b+r
 iQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766042668; x=1766647468;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K3ZtEPXMm9tmuJEBCrK1OA4sYdQysjzwD7qLV1aPcTA=;
 b=RzP0WkAdygxBzNyws924OtKbjs9o9QQ7EuhSwWVY/A9U34fIywUKOjI7vLo1K+MSTD
 qr9KiJmOePGFL/EWWgoP5VUoAmGCq8SyWWZss5O5Bzgpd4ixdX8juhsxMke1p8t9mWpN
 hRBQ7zDetohNlxHBsJZdQTiOjMZTjM+FoObLD12+E4J5y7LVp8taSjYAC78m39QZNfzd
 ai9tCUbW/Jq3c45Cz0ttVcw1FOvRUUIYtszvKsik2u3jeaN3+RwUrLiblWwe3+o3lmKC
 K1SzGEiW5IofnKe0l0gaQP7Z2Pb1oQfGF9VEN6MlfiSRb5+m0ENFm5LRpdRLNaESMIva
 NDDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdQihz/JgWWwPKHcoIfwyyK3yaUoxJ3IKYQVacUJqUWmXESUMvqtuh0BIkf3eXPZzP3msiTKSOQqdW@nongnu.org
X-Gm-Message-State: AOJu0YwdtZQkSujX2LVxecira3jiJV8eC+lDfYZHBGHk/aTiERYpGP0d
 C2XQdHxfNfcRgzNpAHVjTI0JMEPgzUOZLmwcf5ONtfwKzwGJUE8DRkJdlaDWP8D2QTxa9w89/qq
 1/X0WCgOzaAXAwPUtPwXi8P0y7+Ekbler45kdbDTcduUoWDghTAi/R/a/
X-Gm-Gg: AY/fxX76RZJUoaZQrbe7cMgtjKpzD3sZEshvn9ne8Dks1BPsMDoqgb60A8dKCWXCLsY
 NCczj2yI2YcRVWeOc7UmVoJgc47k9tX4hem38gehA85+5e5AEi13JKGQE0jyTkRh7lR/Kw77dXd
 MUB5z4YHGbYCcyFrh/v/lzQINelrqsdmfJUPDr8jtbVutk4KITUespzFZ4K7LeKBIvhKgfvreYN
 LKmr0Ge2Mal3wXoJU3/6MGWu2Siasa/98mRuc7iQ0b3rhdIuLpk/emBom7Nei45s6nhUUd6qpoV
 h9gQorMkRx22M9xER7+Da/kScGwfCHqEzi0dZmchWkITCINT9HAgyLW8zOsME96NCcVRlVKDw05
 GwrYrM1uBaSar1zfndvgshp3br0DeuXuzlWmluACbRZaKUJdHw2Y8Rw==
X-Received: by 2002:a17:902:e74c:b0:299:bda7:ae45 with SMTP id
 d9443c01a7336-2a2cab60b33mr20575415ad.25.1766042668188; 
 Wed, 17 Dec 2025 23:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI2RTezR/dqNDhaoWlutMlheYpW/nO7+H9OUpA9k3cy85NbWYu2XEhR46dmM79PrgCRvt8lQ==
X-Received: by 2002:a17:902:e74c:b0:299:bda7:ae45 with SMTP id
 d9443c01a7336-2a2cab60b33mr20575265ad.25.1766042667791; 
 Wed, 17 Dec 2025 23:24:27 -0800 (PST)
Received: from smtpclient.apple ([27.58.53.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d1926ce0sm14633185ad.80.2025.12.17.23.24.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Dec 2025 23:24:27 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 15/28] i386/sev: add migration blockers only once
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <aas37tpm2yrqueip7mhgqd7lzy5f3ckk6zrt73bzq6dawpjoox@47o27xg5acqt>
Date: Thu, 18 Dec 2025 12:54:13 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E81A25E-841B-43AE-9A85-206088A305C5@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-16-anisinha@redhat.com>
 <aas37tpm2yrqueip7mhgqd7lzy5f3ckk6zrt73bzq6dawpjoox@47o27xg5acqt>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 17 Dec 2025, at 5:14=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> On Fri, Dec 12, 2025 at 08:33:43PM +0530, Ani Sinha wrote:
>> sev_launch_finish() and sev_snp_launch_finish() could be called =
multiple times
>> if the confidential guest is capable of being reset/rebooted. The =
migration
>> blockers should not be added multiple times, once per invocation. =
This change
>> makes sure that the migration blockers are added only one time and =
not every
>> time upon invocvation of launch_finish() calls.
>=20
>> +    static bool added_migration_blocker;
>=20
>> -    error_setg(&sev_mig_blocker,
>> -               "SEV: Migration is not implemented");
>> -    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>> +    if (!added_migration_blocker) {
>> +        /* add migration blocker */
>> +        error_setg(&sev_mig_blocker,
>> +                   "SEV: Migration is not implemented");
>> +        migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>> +        added_migration_blocker =3D true;
>> +    }
>=20
> Maybe move this to another place which is called only once? =20

Where do you suggest? sev_common_instance_init?

> The
> migration blocker should not be very sensitive to initialization
> ordering, so I'd expect finding another place where you don't need
> the added_migration_blocker tracker variable isn't too much of a
> problem.
>=20
> take care,
>  Gerd
>=20


