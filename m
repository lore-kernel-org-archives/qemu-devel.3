Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6412E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 07:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW9Gk-0002rJ-2P; Fri, 10 Jan 2025 02:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tW9Gh-0002qP-TJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tW9Gg-0000QW-CV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736493436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJ/gQSOBAspcGk6u4zr3HLJbfFZXg0qX00OL4lqsJvw=;
 b=XzQGQV6wBOayscDlXFBUgO6rjTOXOSnVcX0IU19XiIlJGk8GUKokHnGZ4EFWl2wmn6o7UK
 dVkKVwK0Aqo00mJSSBHpof5XOfTGRdTXUOgL8Nz9XTWIT/SRIAfwgI+AHqS6/905Xi0BfR
 wFCjbDvC8XJVeQU77buNegAO4YL2J5I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-dd56rCHWN8SM-sPvN977hw-1; Fri, 10 Jan 2025 02:17:14 -0500
X-MC-Unique: dd56rCHWN8SM-sPvN977hw-1
X-Mimecast-MFC-AGG-ID: dd56rCHWN8SM-sPvN977hw
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab2e529dc35so26632466b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 23:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736493433; x=1737098233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ/gQSOBAspcGk6u4zr3HLJbfFZXg0qX00OL4lqsJvw=;
 b=otXgMy9qelXOXkrV+NdwokaBor0hYcITY7ozoQGpDjP8lUZiKiTaf2IOtpkWc6TlZC
 eNPExT7EWKDjEuxP3JTly6d6jCLT2t2PBMkkotCIldZXEQ1VaYn3WzzY681r2aPXtes5
 PF7cAAhovcw8kC7ncjeOkCX52g6oVAn8VTuWRaoVygJ3CnhlHmN1263K3ZzYoH8q5kEU
 e+hKf/Jdw7auamVk6Qth5BR+gN32eCkHGPC5Ck66H0upeH/Tcrw0KedP3qwlIn8m8YqF
 cbA0YYdwKqyBXbxjkWJveeJMdZTzcBWvCqVU1FfqHYMEMWTsH9Fbymw0QS4G4HTztJ8l
 xctg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViy2bnJN7stMEmDW1PZjk/8TOR9eerMLsrFMZbE+Z/uCuEEPvVkvzjE7EVxf6ilu58NugUIgmV+cJC@nongnu.org
X-Gm-Message-State: AOJu0YweZOtJwDE3IpyaFK2VGyWgE0PAl76I8i6pDwQvZkRnNfYNlb30
 hPHEN8dhwWxpOzmwF9ffDNBcnXLtFZ/3qilWixWI7h0TkvnaOLRpEUznYzpqmsk9wo0tSBW9bCB
 kE9ME/JbPTtr1m3Dblbfa8JJVezKKOQM7QS5JgvhcogIrloZxEGuykf8+dqcRIQu61C4eTcuTt5
 DRnqWbS26NS3E7bHuuD1NY3tEUr2M=
X-Gm-Gg: ASbGnctRRnq+o8kgAICGUMh3a+SWG6Ur4ypbFUvuv7WE90iqKq3Pg+zJ6oVfEvRRT8w
 U0Z+bsNH4fnyrHv0J4Z+sDd7C2nMoUiLElRFL4bw=
X-Received: by 2002:a05:6402:13c1:b0:5d1:2631:b88a with SMTP id
 4fb4d7f45d1cf-5d972e167dcmr9285133a12.17.1736493433377; 
 Thu, 09 Jan 2025 23:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRaZXqY1YevhtZ+paAEz1jIfdSVTZtoRQ/aNK6dnq4a1TAnqcOqbO66h5ildMme1H7bfZFD7SRunvBI0+baVQ=
X-Received: by 2002:a05:6402:13c1:b0:5d1:2631:b88a with SMTP id
 4fb4d7f45d1cf-5d972e167dcmr9285121a12.17.1736493433064; Thu, 09 Jan 2025
 23:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20250108-buffers-v1-1-a0c85ff31aeb@daynix.com>
In-Reply-To: <20250108-buffers-v1-1-a0c85ff31aeb@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 10 Jan 2025 15:16:36 +0800
X-Gm-Features: AbW1kvZCuilgIAkONM9eu9p7ASZtik1M7shoOzCkXoUa1caaw6uDtiPMJneZtos
Message-ID: <CAPpAL=zW7HtpDkBji26UuU_4nCLj5tgfSFUs=hyHtE8-6OJe6g@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Fix num_buffers for version 1
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
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

I tested this patch with virtio-net regression tests and tests
"mrg_rxbuf" on/off status with netperf tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jan 8, 2025 at 8:23=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>
> Fixes: df91055db5c9 ("virtio-net: enable virtio 1.0")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 06f096abf678..b241cd4bb48a 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1992,6 +1992,8 @@ static ssize_t virtio_net_receive_rcu(NetClientStat=
e *nc, const uint8_t *buf,
>                                      offsetof(typeof(hdr),
>                                               virtio_net.hdr.num_buffers)=
,
>                                      sizeof(hdr.virtio_net.hdr.num_buffer=
s));
> +            } else {
> +                hdr.virtio_net.hdr.num_buffers =3D cpu_to_le16(1);
>              }
>
>              guest_offset =3D n->has_vnet_hdr ?
>
> ---
> base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
> change-id: 20241227-buffers-6bd3493c287e
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


