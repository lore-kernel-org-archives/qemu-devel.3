Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA9BC55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 12:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq8pS-0001zJ-GN; Sat, 01 Aug 2026 08:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wq8pB-0001sG-LY
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wq8p8-0000YX-LK
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785587296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9Ldg8XRWAStEwrKwEk229Ow21z+ZkX5wHxcNyX5Rnc=;
 b=CCgvKf2q4XuJAoNrDV17/OscBH3eWuwRrPxwXuxabDy4OIkHw1yOAGqFCbiln/Y4JkKWsn
 5ZkP2PDFZrj04c3VNxYPmKA/K4+Ma2w5BLKtuRl7pjc5sLdV+2kCgrV6/U6gsZqIIs+QRU
 LMH9UjFMrpeqYT/dRWVMbqLG2XV7Cak=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Mg0Sj_d3O-GV4zfHGGfLFQ-1; Sat, 01 Aug 2026 08:28:13 -0400
X-MC-Unique: Mg0Sj_d3O-GV4zfHGGfLFQ-1
X-Mimecast-MFC-AGG-ID: Mg0Sj_d3O-GV4zfHGGfLFQ_1785587292
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e2f61c09dso2780963a91.2
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785587292; x=1786192092; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p9Ldg8XRWAStEwrKwEk229Ow21z+ZkX5wHxcNyX5Rnc=;
 b=SIKxhbWfJEnjtwgaaPyLORicRiK4d+NH1J1emM7+J8wOJJ7mufPCxbV3Kx8A00sVXy
 lfoSltDxHUaxD9ZCGnlM666RlY1+0MughbwpYNLLKlhv18fKPVp/Izt5hLGIKrc2dsc6
 pGJqGCsdwMIMUNxD3jQp0lbLcMVf5owAlRDwLoyVNqbBMRJSrv4N+FZP89A2tHvm6mZ+
 UxfT26oPhL1LKcpqT+nDMcj0kGOCikhJfWJaCAqmPChvsphc84PXCJD84G9exz3j76Ns
 2qJmC2kpoL/j/qZBdYu0DaJ/T+QcXzVvUKcooazzuH1sTFjQ6JXUIxvmc3QBHdyv+khG
 kBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785587292; x=1786192092;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9Ldg8XRWAStEwrKwEk229Ow21z+ZkX5wHxcNyX5Rnc=;
 b=YbNx2MSbsTrafMxiJmwVX57LsMbgmmhzaoCLsYZTJIKYNhxYyxA90HlB8wQcBt3EbK
 1YxaEai1KcbDN92mlcWdcW+dpuX0TXKXiBtXe3xWpG/QsCHAGCtfXP9x1gJ4e6bdl4OE
 UxsJHvKks5g0iqmEKy6P8Pb/pWxrx8fPATQC4o5fpeAerQ2WjYMx3I9YLlfRFTV5gDRD
 9dbfS3mPnqeD3qlAWU7QUpPsE9/7j2n8TxbFb9LhqPoCaM0TnsWWja4RkzqTAcbYtxzk
 mHScyasKH9jJZ5ceWFu8fDERo+WcxuPnRT6XhqYjIbfhC8EOWhANiGYaKHBjTUIUpjsQ
 Rv/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqCDbMOSNSZVs0HIAUGKbCA1QGonmBP6C3QCgr6PaIcHcO/I5ueDarHIuMPPv8rNhafluM6Qha3YJI@nongnu.org
X-Gm-Message-State: AOJu0YyWhHsoru32DkAkQ05MYU3svwIx+3M4/wC7exAXQNmK6N7WedEl
 Zb2MbYxRi9qOgHYurO6pAw/VL+TXNWsruD5zMhT+TD+nSq78W0vDKAZq/zvO3kl3lip6EqJsinC
 ZEYEkc+WRAuLDnoumG1GYTC/ujdIlnglEoja780gEgeKqZANDYUS85ya5
X-Gm-Gg: AR+sD13tH3gihlTZiFTm3ivkICn45elenpL+HTs5LK82NZNOWlmN8D5RU4HusG1vOEE
 vyMP7m9RakdNnm0FN7ONEDrtmz0pmMRMkSdXQB8090rHp8+fxtzkfxoOmltl/H6RFUmZJ+K483P
 9G0j5eGJ0NgFVQXUvbva11cMXyBSFumlJq1KA9ngBkeg3KJfIxCaW7tQTRj73t2IDY1k7k99yHs
 OpJHxLWQq/45/x3iP5ZtyFdi+6AOvsPW46fcHqVWZoUEnIEOcVF3MsNlzqS6AcO+N/gYckrdxCm
 GQw65cmvb2SL8EyrJg+olNr26HamZt3139XySH67FlFvX0Bq6+5nUvJAqOuwCvR6aoLusjR/CbS
 TkaZ4O/7OUuxsaPZvuSlpd0iStMkla4yttL2+DGG9ZghpukD9tUGurjc=
X-Received: by 2002:a17:90b:524b:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-38fbc3e5c67mr2847914a91.9.1785587292120; 
 Sat, 01 Aug 2026 05:28:12 -0700 (PDT)
X-Received: by 2002:a17:90b:524b:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-38fbc3e5c67mr2847892a91.9.1785587291654; 
 Sat, 01 Aug 2026 05:28:11 -0700 (PDT)
Received: from smtpclient.apple ([223.236.229.143])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06fc98sm16791963eec.21.2026.08.01.05.28.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Aug 2026 05:28:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 2/9] igvm: track memory regions
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <96ad911f-6f07-4616-b911-617dde2f12de@csgraf.de>
Date: Sat, 1 Aug 2026 17:57:56 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alexander Graf <graf@amazon.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1C5D784-4C75-4FE6-BEEA-F879C73E0D7B@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-3-anisinha@redhat.com>
 <96ad911f-6f07-4616-b911-617dde2f12de@csgraf.de>
To: Alexander Graf <agraf@csgraf.de>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 31 Jul 2026, at 3:28=E2=80=AFPM, Alexander Graf <agraf@csgraf.de> =
wrote:
>=20
>=20
> On 30.07.26 09:12, Ani Sinha wrote:
>> From: Gerd Hoffmann <kraxel@redhat.com>
>>=20
>> Memory regions added by the current IGVM needs to be tracked so that =
they can be
>> freed when a new IGVM is loaded.
>>=20
>> Reviewed-by: Ani Sinha <anisinha@redhat.com>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  backends/igvm-cfg.c            |  1 +
>>  backends/igvm.c                | 20 ++++++++++++--------
>>  include/system/igvm-internal.h |  6 ++++++
>>  3 files changed, 19 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>> index e1f09855f6..38438a7b1e 100644
>> --- a/backends/igvm-cfg.c
>> +++ b/backends/igvm-cfg.c
>> @@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, Error =
**errp)
>>      IgvmCfg *igvm =3D IGVM_CFG(uc);
>>        igvm->file =3D qigvm_file_init(igvm->filename, errp);
>> +    QTAILQ_INIT(&igvm->memory_regions);
>>  }
>>    OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, =
OBJECT,
>> diff --git a/backends/igvm.c b/backends/igvm.c
>> index 534032fed8..9e7c90d386 100644
>> --- a/backends/igvm.c
>> +++ b/backends/igvm.c
>> @@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>                                    int region_identifier, Error =
**errp)
>>  {
>>      ERRP_GUARD();
>> -    MemoryRegion *igvm_pages =3D NULL;
>> +    IgvmMemoryRegion *imr =3D NULL;
>>      Int128 gpa_region_size;
>>      MemoryRegionSection mrs =3D
>>          memory_region_find(get_system_memory(), addr, size);
>> @@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>           */
>>          g_autofree char *region_name =3D
>>              g_strdup_printf("igvm.%X", region_identifier);
>> -        igvm_pages =3D g_new0(MemoryRegion, 1);
>> +        imr =3D g_new0(IgvmMemoryRegion, 1);
>> +        imr->mr =3D g_new0(MemoryRegion, 1);
>>          if (ctx->machine_state->cgs &&
>>              ctx->machine_state->cgs->require_guest_memfd) {
>> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, =
NULL,
>> +            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
>=20
>=20
> Please make sure to track them with owner set to =
OBJECT(ctx->machine_state).

This will not work as the owner will have to be of TYPE_DEVICE not of =
TYPE_MACHINE.

> Without owner, reference counting is disabled and we end up leaking =
memory regions on cleanup you introduce in patch 3 later.
>=20
>=20
> Alex



