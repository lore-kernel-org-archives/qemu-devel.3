Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F56C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiXp-0005fc-8u; Tue, 15 Jul 2025 12:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubhrS-0003ph-7w
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ubhrK-000540-QG
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752594381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeKZ0KmVhAbqsdVN0qJho6dSv0EDr6zEMDxOmyQv/m4=;
 b=g3hSHevVhhIdpY5gRhWw6zhs66tqjjY51Pk7vPG/fX0laNDzYj90SdzRJ7O9u3FbxJ0u72
 TaErtrej/2RpamJ8nm67w8xcQeC1hGDgTWMMs+e+Rhf62wHOxEZs1vmO3rHoHDoJQsdoc6
 1bx8x27GH5/lkqcGSSFh4O/HmLS60qw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-aOzxedLhPAeCKgtC2KnEww-1; Tue, 15 Jul 2025 11:46:19 -0400
X-MC-Unique: aOzxedLhPAeCKgtC2KnEww-1
X-Mimecast-MFC-AGG-ID: aOzxedLhPAeCKgtC2KnEww_1752594378
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ae0a0683d6dso609215366b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752594378; x=1753199178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeKZ0KmVhAbqsdVN0qJho6dSv0EDr6zEMDxOmyQv/m4=;
 b=fZhCYZOsA5dL3C5C/BCj+BW9r63C8DZwiYwQ8dBYAHm/XoIop0YLJf3joR9wKeIFvs
 mQ36iu4R/QeQOAEIIYSZFON/OQIqvwNZz8g7TF4A5xIyVjcgMxzJXsHfMgL+pCFWFsWr
 hFOrzeZm7A2eopNho/QrcWSog84giXq3l6ezDksKKxGGB1S79Fb5Oj6bdTA1UR3uE2ED
 7w/+RZkxfwry0AD7oOjuetrYtIbf4sK7PhMkTIMP0anHG8wnRPx7d+KY9oDN6m63pQoY
 AMg+2qaqpeNsy2R33nGY5BuOrnqFz5VKvsaqNkZgtgupCCrxWqiry2gldP/GfIlIuBBk
 3JJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP4+OvmYdLTQao+JElHkDDkbbTc4K+mR7/gtYNz3AQYZLH0xOv0KdvejpAFVsMkSJogpdtAPVQK2+u@nongnu.org
X-Gm-Message-State: AOJu0Yzth14iR7NHxu4x5wbCBSEGAcYzuYYL4jjbi8wsC92sHXBUo8eM
 5KFDLiUJGk78L0bhjo6Xgpo1cvWFNY6XZOglthU3jct8I4IgG2jpxzQ/A48qRe6ADbv093K1Lbd
 qGX0aO4NcGoNwZzqZ6miTWi7Vd0E70SuK8hh8TYDa8aBs+gQQxSNXI8GrSwv/ZUJoQ5HgM/y8cR
 xWlcijA4ezieIKA0a46GJspP1oIstRq10=
X-Gm-Gg: ASbGnctUSu5dib7OhEZ/Wbglr4DqiKANXCsT7G+C5RHxX4v0V0JF2HkD85ewFuQGawv
 RFIDjqRDrHeX7P5AmDWbQZD0zDH3l5pBZV085+p1ms7MOBRg+441QVeoD/Hian5EhWvzF5UeSos
 YgBDo4b1PnWz+Grzadyr6DqA==
X-Received: by 2002:a17:907:962a:b0:ae0:3f20:68f8 with SMTP id
 a640c23a62f3a-ae6fcbc2c32mr1887245366b.39.1752594378047; 
 Tue, 15 Jul 2025 08:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlCyXikNssAjjTBsAdIH0MIVmRcQfeT4dCIv8bEKRZETD1LqB+ZQ3r062eu/OZ/7fnE746+1I/QZe0sQ3hiM4=
X-Received: by 2002:a17:907:962a:b0:ae0:3f20:68f8 with SMTP id
 a640c23a62f3a-ae6fcbc2c32mr1887243166b.39.1752594377707; Tue, 15 Jul 2025
 08:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
 <ae225e65-0a13-47a8-9bfc-0f8497af2e58@linux.ibm.com>
In-Reply-To: <ae225e65-0a13-47a8-9bfc-0f8497af2e58@linux.ibm.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:45:41 +0800
X-Gm-Features: Ac12FXxAVi3H2kkwLzNgapGt3HL99l3IuWXYcy9Tgg-NKyIA1vi-6LvLTL1aVjA
Message-ID: <CAPpAL=wxV0RmFq+nwSjsYbmYpBkaXE3TPLrxNfrjYrr0hCjkjQ@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio-net: Fix VLAN filter table initialization
 timing
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 yin31149@gmail.com, 
 eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com, 
 virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 5:34=E2=80=AFAM Konstantin Shkolnyy <kshk@linux.ibm=
.com> wrote:
>
> On 13-Jul-25 06:52, Akihiko Odaki wrote:
> > Konstantin, please see if this patch fixes your workload.
> Yes, it does. It delays vlans[] initialization until
> virtio_net_set_status(0xf) which later also calls vhost_net_start()
> which is where the NIC is actually programmed.
>
>


