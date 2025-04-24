Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB401C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u85Vn-0003nk-0k; Thu, 24 Apr 2025 18:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u85Vh-0003mm-3W
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1u85Vd-0004od-EH
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745535452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OmJl+eHA39iDOGeOtpg72ERwpcT2iXXC9e6r4cLflB4=;
 b=FKfQbeaBR921ZYvToeLlNfep0sYZcP7cdntV/+0Lz4MIPtV1sYuyVWD+8EnyPg+EOdUTs6
 H4hGbROfGYhmrDZreKCGWhQJCmni92VGub8yw1iFqyIfZOALd04sjG9B15n09MdguloZki
 yHqnUz4zpqZb8Nx9Mm/OGRMIdohcdVk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-j04IijEyOROQjXBQMKpSjQ-1; Thu, 24 Apr 2025 18:57:30 -0400
X-MC-Unique: j04IijEyOROQjXBQMKpSjQ-1
X-Mimecast-MFC-AGG-ID: j04IijEyOROQjXBQMKpSjQ_1745535450
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3d9044d8fa9so753025ab.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745535449; x=1746140249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmJl+eHA39iDOGeOtpg72ERwpcT2iXXC9e6r4cLflB4=;
 b=JphXWe90EDvbklPFbFvvHGQfPy1pnlf0ur0Mh7TVL6kv4k54z4U4FfoBz9AIihzQNg
 0KplgkCUNPfp9GkO1iQViZGNseM4gjHNa/d6V6bCu7m3evvpyBgwQxe5OiaCA5F4TEI1
 ynimlmC3Kwp/NC7lSL5qURg7QPr3g/WY2ukD4YJX7sLYfkVhbmgi/efQczHOpZyEFBl8
 weON0UsCY082Tiyj2+I8njYl8HjRCnn+lSDzaLv8OyCKU9wvwmUrkTXuF9KKEk4qgTlo
 9HBBlKb74ZWYicPq1JvqK2qn34xI4Fd139H0sVbkPsPQnu3kIcwK6xalr/8ppNJlqUZD
 dKfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGpDpaSdzHW0/94wypQ0YvcVkO8S9zkZQcFTX+eQd6jfl8v4HeW1Tf1rsYvGAFwU3mpIJwYd+0iX4R@nongnu.org
X-Gm-Message-State: AOJu0YyDxwosvdtYtbDNxVg91Wxe21c3J/JfFHilBjaIDsFTiKs4Im30
 mmiu8Vn7GdXy6zyqdXPxWCoc57csNGPVWZfh5C30S/LyzAkrkEV2a6eQ4kzgHZya4wgNh9rE3ba
 gAFuiFk+MAOMIkTAGRdgIbIEHv5yifMw0TN1sW+eEOg/Il/ZV9SWA722thjI5
X-Gm-Gg: ASbGncuovT8C+y3p4Phktbs0VCtsDKUvMZL13T2vi6GzQMqejgiovqaHge0F2tdkhJo
 bNEW/XMYxNi3BnmKn8fdnN0RVrtzQNy7mWGBmoGCYSO1zg0wgg4OUkKKnwj0oKjdA2ktHUdGHOQ
 nnNx0yzx9an4iHpEPs6UAO0Xpq19vH8i1r8Bd2XCr0rX3RfNtiFqLYns0WjmJFDk8no56JFzgbN
 MjaYGcIiOt9QoK0bQPdWYYy0E+4j2oqnzVSK1MXyIGUfor2FfQ+w1z4OB6s9jD/81HtgxNrW7PW
 1dYRO3SU6tpfMlQ=
X-Received: by 2002:a05:6602:608a:b0:85a:fe80:cdd1 with SMTP id
 ca18e2360f4ac-8645cabb96bmr6929739f.0.1745535449291; 
 Thu, 24 Apr 2025 15:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+2ZcHnF55gXA5inVzyDlaXmnnKufhO/Wjxw5ce7LSJcEzB+dqFZH5Leu/R9xkXOYVUnTCQA==
X-Received: by 2002:a05:6602:608a:b0:85a:fe80:cdd1 with SMTP id
 ca18e2360f4ac-8645cabb96bmr6929039f.0.1745535448966; 
 Thu, 24 Apr 2025 15:57:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f824ba0ec4sm482018173.113.2025.04.24.15.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 15:57:28 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:57:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH 01/11] vfio/igd: Restrict legacy mode to Gen6-9 devices
Message-ID: <20250424165727.62c8dc9e.alex.williamson@redhat.com>
In-Reply-To: <20250421163112.21316-2-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
 <20250421163112.21316-2-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 22 Apr 2025 00:31:01 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
> CSM support on later devices. Additionally, Seabios can only handle
> 32-bit BDSM register used until Gen9. Since legacy mode requires VGA
> capability, restrict it to Gen6 through Gen9 devices.
> 
> Link: https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com/T/
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/igd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 6678e0e5cd..01826acf10 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -516,11 +516,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>  
>      /*
>       * For backward compatibility, enable legacy mode when
> +     * - Device geneation is 6 to 9 (including both)
>       * - Machine type is i440fx (pc_piix)
>       * - IGD device is at guest BDF 00:02.0
>       * - Not manually disabled by x-igd-legacy-mode=off
>       */
>      if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
> +        (gen >= 6 && gen <= 9) &&
>          !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
>          (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
>          0, PCI_DEVFN(0x2, 0)))) {
> @@ -565,7 +567,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
>      } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
>          error_setg(&err,
> -                   "Machine is not i440fx or assigned BDF is not 00:02.0");
> +                   "Machine is not i440fx, assigned BDF is not 00:02.0, "
> +                   "or device %04x doesn't support legacy mode",
> +                   vdev->device_id);
>          goto error;
>      }
>  

It seems more useful to me to print the generation than the device ID.
A bug report where the generation value is obviously bogus or outside
the supported ranges is more actionable than a PCI device ID.  Thanks,

Alex


