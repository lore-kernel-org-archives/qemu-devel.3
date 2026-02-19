Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB84E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vszze-0008FJ-4g; Thu, 19 Feb 2026 04:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vszzc-0008Ew-Sr
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vszzY-0004EM-Ul
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771491995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//CLmZZ8qSIX6Fq2xQcNGyheAN6sXF/2VX1I8HuYAUI=;
 b=gZDC0fTlhnlWEzekPocl6pu06fdGdNCo+MtBrTX5KucO+ufVEOV1zufLXv9lAv+EeIQlS5
 wb7JOe0UDnvE0xZ+QbPKuNBRaYEGEb/abDJ7aWeictTF2fTAVHm9AmBzTms2oPx0yUKP4m
 Z1X90L4LvX2gGcXi/esgfXYfTYv4xY4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-0_IOPN4BP_6dj19VjHF5-Q-1; Thu, 19 Feb 2026 04:06:33 -0500
X-MC-Unique: 0_IOPN4BP_6dj19VjHF5-Q-1
X-Mimecast-MFC-AGG-ID: 0_IOPN4BP_6dj19VjHF5-Q_1771491993
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-824a0ea2025so386889b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771491993; x=1772096793; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//CLmZZ8qSIX6Fq2xQcNGyheAN6sXF/2VX1I8HuYAUI=;
 b=qhVzMnp7+yFmixCnDZMpgXXwHsVyKK7/8QzjWlHIOK1uOOyZbmUvHyml/z8/ZRszQB
 HsI0KRoUjh+tL78MKTx5fhzgIEXui5VldBtrx2RaGk4UeGhmGZb8tyMi+bKcEwt4XB+R
 WmUgADKebufnuu18W5H/tuS+EYyUHlMEebEh7vk5E9er5VM2mupJh1uEtgXezHbZ5jrT
 mnOA5aAEE6gZ/4f26Z+X1N2jF4a7U20PCm+e5bYkWEvXTPjMarVn86zMtlDgYOjbnNNh
 2Z3ryEddGWeflylABvqZEy6Zw3esMqiQggl9lNLBTVJp0nwfBJe+SJn1GyZCe4NWaA1Y
 lyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771491993; x=1772096793;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//CLmZZ8qSIX6Fq2xQcNGyheAN6sXF/2VX1I8HuYAUI=;
 b=lnS/k5pKlpBDGxjmy1UpjeuLgH+EvMBBv+/Aei65W2hUiar22H7ZzQ+U48IQJnHOFm
 v7S9LoJ20JpsS1CmhTUpPjCyPyS6dXP9ET+LJ6wEFGB0bcukULOtgk4DufuCW7bGk42G
 wu2Zoh/7IEpCdLT0EVO4y7ci+IX3mhXiwqr1vpdV8dUCDMG4gTOdg7d0rIejsODR1MvN
 pG4B+1xN65LHEs46+qtW9uRFpwO94BJaK1phcxaBtU4SHI9PLQeJksG/zAerbHWtihtL
 jp+RR8GTgd0Oaqnv1G3jdsxWCUUKTUU20eB8nHXQtoLOBISPZhgg7jFt9tuI/Pe5xY5g
 kKzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx+Bs8Hlcj+M4RoW6UkGLcEwsThFK6YWypJ1YWGrCSmHbVJGfQu7+4fOMKR/r5uRi85wEKuhC6xI7I@nongnu.org
X-Gm-Message-State: AOJu0YyNYoyjp1ZLVjgsWytn4f2/bKhtbSXKbJrdu1qOLg5TXy3v3pry
 e/BcUaE5X1e9eu+Am2opcXdPFP4v1w8mXqhT3A0VUe7jThnqXqpt1y6sKkeGgf+ObOqtn7k3a9c
 H3xuZU789Tbymu9HcPU80q1qU/go/Wk7Uf1rNH9Mg/FkMww+jv3+iyFQB
X-Gm-Gg: AZuq6aLL/chtiS2y0YzPuP0lijtG5ZewTnYWV9MkEbsAQO3WiOJSmFbmIj8EaOcr8zV
 fD/ShAmUZRtCistGeMGsTqPGDv+KGhu5D1zKofRGmU7SAWgVqOePNq8jQDY+hQuARFMel/7c5qJ
 0Xqmko8PgSZ28baU1O5ZyAk1fUjZcMcbkTEpe/Vz5qUYuzzGxw4cxRTQ+4pCi3r5DwkbySuX7Qo
 pCFj0+XUFcftFuroeMY3Jn0dR5PBAa1K6442HQHm43BpMVgywL+orL1XSDXl149EIKPCq3hCNWh
 i9cdTblarz79/cyHHlzVTksputVmIC0SuhpPZk6wtc453b6BunnqyWZM61zeaTXzjxBrFl+JTG1
 drLml/YJSC+fyZWpXZ9VHB15rGWPYM560srck9ABpJYSb4U7OeL7+vuJBah5YjXz7j7g=
X-Received: by 2002:a05:6a00:3cc9:b0:81f:3957:2770 with SMTP id
 d2e1a72fcca58-824d95f9e8cmr14770420b3a.38.1771491992791; 
 Thu, 19 Feb 2026 01:06:32 -0800 (PST)
X-Received: by 2002:a05:6a00:3cc9:b0:81f:3957:2770 with SMTP id
 d2e1a72fcca58-824d95f9e8cmr14770401b3a.38.1771491992324; 
 Thu, 19 Feb 2026 01:06:32 -0800 (PST)
Received: from smtpclient.apple ([117.99.83.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b935c6sm20543872b3a.47.2026.02.19.01.06.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Feb 2026 01:06:31 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <b7c1cb1e-7ca8-4d79-94f1-8f6e3bee4b65@redhat.com>
Date: Thu, 19 Feb 2026 14:36:17 +0530
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6CE0C83-89CD-4967-AD8F-E4CA2A5FB1B9@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
 <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
 <CAK3XEhOFvXUEiO3z1MhGqjBQUH3hB_3u9suLpweBs9vaTr1zog@mail.gmail.com>
 <61f1dfa8-705e-4f2f-ac9c-35da4e8eac02@redhat.com>
 <3D89ED00-C696-4ECA-BE4C-7ADF04631900@redhat.com>
 <a03128b2-ce06-3e22-08f2-2eea68f0afe1@redhat.com>
 <b7c1cb1e-7ca8-4d79-94f1-8f6e3bee4b65@redhat.com>
To: Cedric Le Goater <clg@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 19 Feb 2026, at 1:44=E2=80=AFPM, C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>=20
>> please try this patch on top of my v5. It should fix the issue. I =
tested
>> on a RHEL 9 host and a fc43 SEV-SNP host, 1 or multiple vcpus, two
>> different guests and all looks good.
>> =46rom 26db44eba8c727160dd9e97c9d5582a0ddc5884d Mon Sep 17 00:00:00 =
2001
>> From: Ani Sinha <anisinha@redhat.com>
>> Date: Thu, 19 Feb 2026 13:12:02 +0530
>> Subject: [PATCH] Call cpu_synchronize_all_post_init for coco as well
>> Fixes issue reported by Cedric
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  accel/kvm/kvm-all.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index d7ea60f582..0610bf8434 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2816,7 +2816,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>      }
>>      s->vmfd =3D ret;
>> -
>> +    kvm_state->guest_state_protected =3D false;
>>      kvm_setup_dirty_ring(s);
>>      /* rebind memory to new vm fd */
>> @@ -2872,6 +2872,9 @@ static int kvm_reset_vmfd(MachineState *ms)
>>       * kvm fd has changed. Commit the irq routes to KVM once more.
>>       */
>>      kvm_irqchip_commit_routes(s);
>> +    if (ms->cgs) {
>> +        cpu_synchronize_all_post_init();
>> +    }
>>      trace_kvm_reset_vmfd();
>>      return ret;
>>  }
>=20
> Tested (OS reboot, system_reset) with a RHEL10 guest (2 vCPUs) on
> a RHEL9 and a RHEL10 host, using a SATA device and active NIC VFs.
> All Looks good.

Excellent. Also tested on a TDX host with RHEL 9.6 and seems good as =
well. Tested running my integration tests on non-coco and all is fine =
there too.


>=20
> There is still one message :
>=20
>  qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
>=20
> which seems normal.
>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20


