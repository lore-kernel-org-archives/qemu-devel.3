Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA18CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcRGf-0000kL-6Z; Wed, 24 Jun 2026 13:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcRGB-0000ek-SP
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:19:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcRGA-00080E-7G
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 13:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782321572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtMLCtzjA/39OFjR+u8jNOolPTxscPUsC+f1CJEqbyQ=;
 b=THHEgva7bcheybCJz5AC96hxf14yezjaIg0QVWHJnIz8yU2k7iw3upyygB9LL9dzzqhfnI
 ig46SOtsz7lJ28PRmJgnxp9YWGuO4ji6JS7tbjoY6QdiuSpNIL1xUPoxhxzhlRB1Q8dttg
 YgNFGYmP5rAyOaJnn/IPoKt98cALNHg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-JLwiWmkgNa6rkf1qCdqQjg-1; Wed, 24 Jun 2026 13:19:30 -0400
X-MC-Unique: JLwiWmkgNa6rkf1qCdqQjg-1
X-Mimecast-MFC-AGG-ID: JLwiWmkgNa6rkf1qCdqQjg_1782321569
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c7edb8505dso5197405ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782321569; x=1782926369; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtMLCtzjA/39OFjR+u8jNOolPTxscPUsC+f1CJEqbyQ=;
 b=JN9xB2RFrPbCFDCVQPzc2nUqJFgoExNjtdDI4cf4XozCzy4thiafze1lqG5yIOalvT
 AQNFclVvan67W9Jzi/vfsqqVigl42bDZIBI7SzgOX6rwPFoT5DvSPY7DDBtRHF9kx3Q6
 SOJJZ50ZeVq2RbBpM9nOeSjOYIzySvdHs177zCNndrg7XcWyW3Mof/+meVVr0eoXu+rp
 KS3JbSbx1BHnKXmljAc4tf7j7MCEibOWxr7zNdGCTCMdemsNViJDvLA3Er7QgT8AUpzF
 bLIb/N4XMUY2eV7vVxzijece4E5mFyi4LZqq3WAEdCMONcM+o3MwShpERrBhi63wc9dE
 J2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321569; x=1782926369;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DtMLCtzjA/39OFjR+u8jNOolPTxscPUsC+f1CJEqbyQ=;
 b=TFgL21pj9pEuafRKmJOLdb/TbHFwyhg1RNUuizvi+wbVawWf7VKPC18aHJ9VtANoxD
 ZYggje8pLth+3zyK4AgU+K5txcRF4ZIHXRoP7Drc7TTcL7gtVbb3UDMIwkbDTzIlNjpR
 A1NOuXpyschrpLbRb1Mgi4S4vpNTRdR3FBSnCjVw73Vc8djUQy0QPozmRo9wGaf8P+Ue
 4jMGTT/I0ExLwOD0SnbMLBwBUEC5daWHsVu9R0Aoi+FPifWzQLRbkBJwNjJEyZBtd1Qc
 EgdZ6h1VrjOaw/QidXhtuQDwlTd0SXxRw/gqhBkg+bUm+Sxbk8rK2SJAYrnHodnRFOuU
 sT8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpcoa3wqE652Fcb5nQ3C+F1ljfnHW8ixQA2hmBVME2kmDVP7YvA1Jpoul6cj8kWbGrXcUbnjGu+THWh@nongnu.org
X-Gm-Message-State: AOJu0Yzed9b5XtcU5kynWK6EESOsW5+rOnfp3U0JZDi8BkJuBkO15pmH
 VoPWexZGn7S6CSNSnxjXoi0Z7tWs0yNKfspDuvulEO+Dy7RI7VDIxx1sFMjphhtfrhLyJia9vth
 2G6mtja+QSh5ctFwmgxQYo18gdR1Evk1A1H3Z6+972one5odQWvD9UOKV
X-Gm-Gg: AfdE7ckLwqyhGl6x0X1D3E2wPASFNaHlJIVs5tZQp6cybAbBvJu5iLHq9ZZ+2NMpNKt
 g3CZmAAWQrix/Q/s/w+8R3mqt0AYqUVuuTeMJ+zmQyYGRn7lheuPujKEpLaN8hoxgt/fxe7oNDZ
 J7rISpUlw9tHM82iPgoCIXG6z946QKkVxe9q7oEw7/5ukQEPozpHLER1sOAXvuMM1X7p9ujV2P+
 PlhThFe+632Ud4HWrX8GSlL0DDzbcHkD2KgCwLLV374mRUx2HRMORKOv/9c15lIQyLDRk4FqXzm
 WyTedVM2NbyrcZYIysb4X0nCfkPmpbP+VI62ZT3dYpmF0aWdogINDKjb5ZzQZ9VfKZrcwXcfXDu
 D+JK1TrfkDR5z837bsqaNq2fzgGvLm0e0thnVZWNQ57lokQMDVuLvqZEu0utDlbMD
X-Received: by 2002:a17:903:2309:b0:2c7:9ba7:a39f with SMTP id
 d9443c01a7336-2c7e1599b78mr44484475ad.17.1782321569396; 
 Wed, 24 Jun 2026 10:19:29 -0700 (PDT)
X-Received: by 2002:a17:903:2309:b0:2c7:9ba7:a39f with SMTP id
 d9443c01a7336-2c7e1599b78mr44484135ad.17.1782321568886; 
 Wed, 24 Jun 2026 10:19:28 -0700 (PDT)
Received: from smtpclient.apple ([110.227.100.91])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f650aa8esm2191775ad.82.2026.06.24.10.19.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2026 10:19:28 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260624055339.46862-5-anisinha@redhat.com>
Date: Wed, 24 Jun 2026 22:49:14 +0530
Cc: Alex Graf <graf@amazon.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BED75716-809E-4D5E-9279-AEC22954EF7A@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
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



> diff --git a/include/system/igvm.h b/include/system/igvm.h
> index e219f1a4ed..e6879550b1 100644
> --- a/include/system/igvm.h
> +++ b/include/system/igvm.h
> @@ -22,6 +22,8 @@ int qigvm_process_file(IgvmCfg *igvm, MachineState =
*machine_state,
>                        bool onlyVpContext, Error **errp);
> void qigvm_cleanup_memory(IgvmCfg *igvm);
>=20
> +void qigvm_free_memory_regions(void);
> +
> /* x86 native */
> int qigvm_x86_get_mem_map_entry(int index,
>                                 ConfidentialGuestMemoryMapEntry =
*entry,
>=20

This hunk is completely not needed and is bogus. Will remove in next =
spinup.=


