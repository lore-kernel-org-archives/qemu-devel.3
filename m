Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE7E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFVV-0000ag-At; Thu, 05 Dec 2024 12:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tJFVS-0000aO-CG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tJFVP-0006pu-LW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733419149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7G5VUqIZtmFkf8fucejyN+Lu/ii3lXwvQQ47lE8X6M=;
 b=gJRiPuYxqWsUxj0VZ0vE4j4iyt1JR2UJPTO3gWSErqS/417IYDhXCpmji5YpGki8Ul584d
 Ssw5ixWPJMJ4mg3rfKFWh3ypsdk4+neZw6qfjQDqJ9vbmTvaqCofh7USdZmjAEFxxoT6z3
 BQkVAtWFhm750Ht0rJMjqmC5Dmk2jqA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-AsD_A7LiPMiYrkTvOeeTmg-1; Thu, 05 Dec 2024 12:19:06 -0500
X-MC-Unique: AsD_A7LiPMiYrkTvOeeTmg-1
X-Mimecast-MFC-AGG-ID: AsD_A7LiPMiYrkTvOeeTmg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-841a803534fso18582839f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733419144; x=1734023944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7G5VUqIZtmFkf8fucejyN+Lu/ii3lXwvQQ47lE8X6M=;
 b=m3Utgf99c4FBl3zJaDcbgdcd3Aut0/tXLzbphufjwT7WqK3HmWDUqyKuvcVtfYp9Ri
 3Seg5uUpMbG05GvvFJkyFbeOg75aDNg0okW8Y15cuS5bTUanJ+B74ljEuUifVwh1pdeJ
 YHBcAv4/q89oESuHpbZYx5Fkz1G/YVc9aYZ3ujujRMhEPUpaF6sAbHkv9f9FKR2XfytA
 M5PFvt5+MAgAsaENL1RKb7tfu+tlI3ERxoWlnuvcuDqbO4mSGx/i8bazQAXUnbRY+UO0
 +JVy7ovIL0RfdyXnMgWSS9Ii4pSlATM52dAfhm/brW6ncK9Rgyo2k3I8lQ5VJLVLBunZ
 Ls0A==
X-Gm-Message-State: AOJu0Ywl5CBocOAbQStHeu/D0KkFaeNy9HJHd5HFT32X9IsKNZmodAF2
 2dsmmkzJ81OqJRw1Ao3tuz4CFfiHMwfSi+NaLPEnAukqs7MJldywLcEIBVv3gECyvBOGu0vTjuj
 Y2bq59R442CuIvwIrQmHuhgr9z1tChriseDh4G7f1sR288t0mLlOQ
X-Gm-Gg: ASbGncsnULl3VjMnPvWq+2B1MsZRdi42QGc0dGafMypCiNWhfNeCTX1hqlwD6VLv2+U
 0CbpGypU/2lNhseYVCfMOpopZ4T7veAmDml8Zcz3c/Xp2CVsWATUsEVlSlmh0dupfNcxwwEoycz
 OOg1x8iroBz+d5WpttqmtRVotjM6gGdzWXNMF9mJLGKAys8ZQItw5QgxJ4o6pTqICSIBZQaWlsu
 Z4lS9RFZ3mAXgrfYdtgc8pTgEJ/0WFRKyDB5yz/wyWIg489LFIkRw==
X-Received: by 2002:a05:6602:1509:b0:83a:aa8c:4ebb with SMTP id
 ca18e2360f4ac-8447e0ec6edmr3467139f.0.1733419144478; 
 Thu, 05 Dec 2024 09:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIMkDVK9OrYp5eJDcGFD0yM8udtOwsRf4pEUWn8BuOSTpwnu2pTRYLmX6Wme2c409NcZY7Ig==
X-Received: by 2002:a05:6602:1509:b0:83a:aa8c:4ebb with SMTP id
 ca18e2360f4ac-8447e0ec6edmr3466739f.0.1733419144132; 
 Thu, 05 Dec 2024 09:19:04 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9403sm381133173.99.2024.12.05.09.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 09:19:03 -0800 (PST)
Date: Thu, 5 Dec 2024 10:19:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH v3 03/10] vfio/igd: fix GTT stolen memory size
 calculation for gen 8+
Message-ID: <20241205101902.48a4d66d.alex.williamson@redhat.com>
In-Reply-To: <20241205105535.30498-4-tomitamoeko@gmail.com>
References: <20241205105535.30498-1-tomitamoeko@gmail.com>
 <20241205105535.30498-4-tomitamoeko@gmail.com>
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
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Thu,  5 Dec 2024 18:55:28 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On gen 8 and later devices, the GTT stolen memory size when GGMS equals
> 0 is 0 (no preallocated memory) rather than 1MB [1].
> 
> [1] 3.1.13, 5th Generation Intel Core Processor Family Datasheet Vol. 2
>     https://www.intel.com/content/www/us/en/content-details/330835
> 
> Reported-By: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This should come before the preceding patch in the series so that we're
not making a fix dependent on other code churn.  This makes it easier
to backport to stable branches.  Also we should include the tag:

Fixes: c4c45e943e51 ("vfio/pci: Intel graphics legacy mode assignment")

Otherwise the series looks good now.  Thanks,

Alex

> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 18d179bc83..09bd4e5383 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -259,7 +259,7 @@ static int vfio_igd_gtt_max(VFIOPCIDevice *vdev)
>  
>      gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, sizeof(gmch));
>      ggms = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen >= 8) {
> +    if (gen >= 8 && ggms != 0) {
>          ggms = 1 << ggms;
>      }
>  
> @@ -669,7 +669,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>  
>      /* Determine the size of stolen memory needed for GTT */
>      ggms_mb = (gmch >> (gen < 8 ? 8 : 6)) & 0x3;
> -    if (gen >= 8) {
> +    if (gen >= 8 && ggms_mb != 0) {
>          ggms_mb = 1 << ggms_mb;
>      }
>  


