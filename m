Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7ABC28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 11:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyrEd-0004Yx-44; Sun, 30 Mar 2025 07:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tyrEa-0004Yi-1o
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 07:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tyrEY-0004B9-JJ
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 07:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743335624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAKgY6AgpsAtsU8/g6bWCu3wRTFW8cKREhDmG+0WvKo=;
 b=DFLVLh6CGOaJLcXnEn57Ij+cYJa8ZjFJHgMrQpYP4qoM7VV1WI0L50RU67pZGTaAK2F8rt
 u6TtGb8R0HDPRbqbvqdO52rZJPWRVEthpNu3GuRN/dWdVG4PcKbUCAz3+Y0C+k6dXtb16N
 Iv6kq1v/pniN58bp8uIWGnHAISkHOVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-mHXpSoJkMHiQjxjV0rzVUA-1; Sun, 30 Mar 2025 07:53:41 -0400
X-MC-Unique: mHXpSoJkMHiQjxjV0rzVUA-1
X-Mimecast-MFC-AGG-ID: mHXpSoJkMHiQjxjV0rzVUA_1743335620
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so30085535e9.2
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 04:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743335620; x=1743940420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAKgY6AgpsAtsU8/g6bWCu3wRTFW8cKREhDmG+0WvKo=;
 b=Qu4u4tHy7pfIazkly6Dna8nb2EX4f4mmc2N/rA3K6aLjCIlkOXb6oy4L+z17yMEC2S
 R5U863MTrCz/Q1FMr51YXqdbEEbNCuQQI3jF2TLtNdPTayA/puctvbbSkxDatFUnQkIl
 8Oa4LnrToeKi0aDB00Qo3epoiHHwLCde4W9u4wa+GAHO9k00cLiKn75D3jrNF5uSNNwY
 Bc75MQSMFkohWAY19eNhIp3KGm9XfhrnX3+fmlh7OMi6m9dexpQqR0Blm9qy+j41kvGK
 YF1S99tdJfvzJXuTn9kHzJROKtGmuhOP5Q/Qx1iXVAL/PELxCdmZQZ6o+S+l5jh/HtNw
 Mj/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpuhoMLxvim7kghmtX7h2bris9wgCfBRvZUMYTACEOVfFU0hd8V3UESraZz693ce51sjcbFrRJLX5i@nongnu.org
X-Gm-Message-State: AOJu0YzDxND/ypFtpnraRZ0tWaSR4A6B0lYV17leowHUBvZovXfHkIUb
 ErF76sE+28s9N2VdrWJ5HitEsGcbq0Fszv3gS2mhtuBLY7MABXq7XjYqJb6UpdpHzziSlxYFlmm
 MLCedghU5JBI5Bn3Tbl2gigC0qJj0aPpS6OW+2cUiIHPW/n6MzAHcRi0eM2MixrQBSIsK4XsiUJ
 kmuM1iEiz2jbv4XvFoBr34yXZCusM=
X-Gm-Gg: ASbGncvB4v9ktC/2H5FFRhzfe+GT3PGlb2UkA30bGHMCSqxFdkBZN/Az6DNje2KjBjL
 d0tzSCYdiks3VZrcmAMOQF7ucMcRksmFAHwevXQYaKUtxhS2ex0iQPjKAarbKH5vJdTy1IHw=
X-Received: by 2002:a05:600c:198f:b0:43c:fb8e:aec0 with SMTP id
 5b1f17b1804b1-43db61dffcamr35725495e9.1.1743335619753; 
 Sun, 30 Mar 2025 04:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfxIq4lR1iJAyhkL/svUdyAHXysacUR4XIoP+4GG27TPSBI3GvAoDH0MOSfA5SfMccnEwTenDyUl1f/B5Sq0E=
X-Received: by 2002:a05:600c:198f:b0:43c:fb8e:aec0 with SMTP id
 5b1f17b1804b1-43db61dffcamr35725355e9.1.1743335619304; Sun, 30 Mar 2025
 04:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
 <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
 <CABgObfbL0b7G-Okq=0xnbDMJ4viu0Uk8gduuTUeCS0C4Xtn6aw@mail.gmail.com>
 <3956f3b4-2317-4e7f-a2b4-e53546473d62@linaro.org>
 <CAD8nu1gB2sBPCNaWpycXRp1sC+kasN_T1E=0x-=3vLmTwThY_w@mail.gmail.com>
In-Reply-To: <CAD8nu1gB2sBPCNaWpycXRp1sC+kasN_T1E=0x-=3vLmTwThY_w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 30 Mar 2025 13:53:27 +0200
X-Gm-Features: AQ5f1JolR98UKX0vPFiNcPPaPZsvzKZGgxhJJD2AVhxVqzVMXYeSjG_zJmeemm4
Message-ID: <CABgObfbrtZa3JhycioL1uRzMvg_q42Y5Et5SiTDZLg+qHuN5SA@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: Rakesh J <rakeshjb010@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.077,
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

On Sat, Mar 29, 2025 at 12:31=E2=80=AFPM Rakesh J <rakeshjb010@gmail.com> w=
rote:
>  Paolo: You pointed out the size issue with .min_access_size =3D 1 and .m=
ax_access_size =3D 4, where bswap32 was wrong for 2-byte accesses. I=E2=80=
=99ve fixed this with size-appropriate swaps (bswap16 for 2-byte, bswap32 f=
or 4-byte). On the extra swap idea, I stuck with a single swap since it ali=
gns PCI LE with guest BE expectations without overcomplicating it=E2=80=94l=
et me know if I misunderstood.

The extra swap (compared to what the "regular" PCI data ops do) is
exactly what you were doing.

>  I=E2=80=99ve sent [PATCH v2] incorporating changes:
> 1.Removed gt64120_update_pci_cfgdata_mapping() and moved initialization c=
ode
>   to gt64120_realize() for a simpler MByteSwap check.
> 2.Removed unused pci_host_data_be_ops and a misleading comment in dino.h
>
> 3.Size-specific swaps (bswap16 and bswap32)
>  I included bswap16 for 2-byte accesses in v2=E2=80=94should this be rest=
ricted to 4-byte only (bswap32) per the spec, or does GT-64120 expect 2-byt=
e config swaps too? It=E2=80=99s a minor tweak, so I left it in v2 for now=
=E2=80=94happy to adjust in a v3 if needed.

Which swap to use is not really related to what the GT-64120 does, but
to the interface between memory.c and the MemoryRegionOps. When
access_size =3D=3D 2, QEMU wants the result in bits 0..15 so you need to
use bswap16. With bswap32, the result would be in bits 16..31.

Paolo


