Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC2E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIxym-00068M-Ig; Wed, 04 Dec 2024 17:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxyi-000659-UG
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tIxyg-00084f-TG
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733351773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvmQwXJlc2d6x71WYFbbz8RLKYdXQ34xl9yttxybnSE=;
 b=JbBSwzEfgVm/meL1jXk89o9jD6IZWvva3L7AuPJgTxvH6HDWXhjaPEuE86yWzl1MsCeMsO
 dsQ91KxpbPCqY4DMR1KjmctiFafR56K9lXnK3iD+nUs0sy/v8WdkVrFR4y8R5zCzFDW+Ge
 oyxRr47MPQMLL1Qd79L8wUZk3R7ErV4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-fx8vxjosNSuK34jiXwpL2Q-1; Wed, 04 Dec 2024 17:36:12 -0500
X-MC-Unique: fx8vxjosNSuK34jiXwpL2Q-1
X-Mimecast-MFC-AGG-ID: fx8vxjosNSuK34jiXwpL2Q
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-843df54fd9bso4014039f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351771; x=1733956571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvmQwXJlc2d6x71WYFbbz8RLKYdXQ34xl9yttxybnSE=;
 b=Or/+iIWc5j/s95f/XYWyYjxSO/lwt8bMjkiI0hoYy5LRr6OXwE+ucpPlxJHTYDgDfz
 2/xVdSN8ye1N/ENpUdhtnHQdEIQwvZZU8OsHpt4hdBb2v7NVMlP3kkLZttn2xXCzVZL/
 fw3oU16DYFt+otadia/LttP9X5dgP3zRJocvDaOS/dJVgQJhOjSaANwD6YfqbNKBDBFy
 DevWi2E/61iGonTTBUXKCUuQAv7l3Dua4DZ+HuhwrpvVSyqIksAZU8OKYdax18MtIkDT
 sNwQizffeIsC3svOL27zDtewaaZIgJ0DsnPPgMf7QQUatiBaa4BXj9vljnblY/Agyq5H
 zIXQ==
X-Gm-Message-State: AOJu0YzHEysIjpHqzsTm6jaNv9AwoQph2K5bEy1RFQOAp+DTfKyWbtMU
 Q54FpwHO7NxQQGf9a+t8knMlUWFq3nyNUHMH3PlsUGqb5O1svwCDJ32r2nmAVCu1zTV+RErfpKm
 vV5d/0kRwziDoEEjj0avSoGTuBjl6SW37Eb8Fb9ViJpSBc+z+KYng
X-Gm-Gg: ASbGncuUq9QkhKDsPEVlsTGt06Ua0g281uNZWWpke/qxFSsqHKGCBDm2mCSzmMx/GaP
 uuZWBhWCI2MU/2gsdWG+tlClqW7KqUjLKOGsON54RXTeCkhsQQgT2j1YbEdpt0aI3cVxh9WXozD
 OzTEnAV8UrGnAfbOidbVnYJ4hDbV3pGAlSPG2xLv0UVyu25pKYfGC2iNVztq3AWqqpLVXhFjGNH
 /HU54R5Zy2geq5bsSJYTzj5ntCnCc54R9DoovYo/f6oa6/sEcHNVA==
X-Received: by 2002:a05:6e02:b4f:b0:3a7:81cd:5c4a with SMTP id
 e9e14a558f8ab-3a7f9ab968emr23010585ab.7.1733351771591; 
 Wed, 04 Dec 2024 14:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgA7xSvTiUVoSm7EMGIyz9iZVuCLjqwL9D1/OEP8taxPbi8iEgDuLRGcEX8e+Hzalz4YEilg==
X-Received: by 2002:a05:6e02:b4f:b0:3a7:81cd:5c4a with SMTP id
 e9e14a558f8ab-3a7f9ab968emr23010515ab.7.1733351771258; 
 Wed, 04 Dec 2024 14:36:11 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808db31a4sm564285ab.40.2024.12.04.14.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:36:10 -0800 (PST)
Date: Wed, 4 Dec 2024 15:36:10 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v2 2/9] vfio/igd: align generation with i915 kernel driver
Message-ID: <20241204153610.09764d56.alex.williamson@redhat.com>
In-Reply-To: <20241203133548.38252-3-tomitamoeko@gmail.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-3-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  3 Dec 2024 21:35:41 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Define the igd device generations according to i915 kernel driver to
> avoid confusion, and adjust comment placement to clearly reflect the
> relationship between ids and devices.
> 
> The condition of how GTT stolen memory size is calculated is changed
> accordingly as GGMS is in multiple of 2 starting from gen 8.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 6ba3045bf3..2ede72d243 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -59,33 +59,33 @@
>   */
>  static int igd_gen(VFIOPCIDevice *vdev)
>  {
> -    if ((vdev->device_id & 0xfff) == 0xa84) {
> -        return 8; /* Broxton */
> +    /*
> +     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
> +     * and 0x5a85
> +     */

Your comment from review of v1 would be useful here that we can't use
the test below, at least for 0x0a84, because it conflicts with Haswell.
I'd forgotten that.

Since we're being more strict about what we support now, it may make
sense to list specific IDs rather than this sloppy match, as Corvin
suggested, but that could be a follow-on.  Thanks,

Alex

> +    if ((vdev->device_id & 0xffe) == 0xa84) {
> +        return 9;
>      }
>  
>      switch (vdev->device_id & 0xff00) {
> -    /* SandyBridge, IvyBridge, ValleyView, Haswell */
> -    case 0x0100:
> -    case 0x0400:
> -    case 0x0a00:
> -    case 0x0c00:
> -    case 0x0d00:
> -    case 0x0f00:
> +    case 0x0100:    /* SandyBridge, IvyBridge */
>          return 6;
> -    /* BroadWell, CherryView, SkyLake, KabyLake */
> -    case 0x1600:
> -    case 0x1900:
> -    case 0x2200:
> -    case 0x5900:
> +    case 0x0400:    /* Haswell */
> +    case 0x0a00:    /* Haswell */
> +    case 0x0c00:    /* Haswell */
> +    case 0x0d00:    /* Haswell */
> +    case 0x0f00:    /* Valleyview/Bay Trail */
> +        return 7;
> +    case 0x1600:    /* Broadwell */
> +    case 0x2200:    /* Cherryview */
>          return 8;
> -    /* CoffeeLake */
> -    case 0x3e00:
> +    case 0x1900:    /* Skylake */
> +    case 0x5900:    /* Kaby Lake */
> +    case 0x3e00:    /* Coffee Lake */
>          return 9;
> -    /* ElkhartLake */
> -    case 0x4500:
> +    case 0x4500:    /* Elkhart Lake */
>          return 11;
> -    /* TigerLake */
> -    case 0x9A00:
> +    case 0x9A00:    /* Tiger Lake */
>          return 12;
>      }
>  
> @@ -258,7 +258,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>  
>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 6) {
> +    if (gen >= 8) {
>          ggms = 1 << ggms;
>      }
>  
> @@ -668,7 +668,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      /* Determine the size of stolen memory needed for GTT */
>      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen > 6) {
> +    if (gen >= 8) {
>          ggms_mb = 1 << ggms_mb;
>      }
>  


