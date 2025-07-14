Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D595FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubS6w-0007av-JC; Mon, 14 Jul 2025 18:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ubS6v-0007ZH-LI
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 18:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ubS6t-0003FB-1u
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 18:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752533839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKyZAq4pdwBfJ6Q1QwFC71krqpHYodFPSDVsG9yLQXA=;
 b=epyCBrrkdLH1sy2XY4aXFaDuRLuCZKc6G9z11p4LFVFe8hrr0UkXJVyAIe3EdsR+MDD1td
 z7t0WJ5BMhFyYFPFYimnDaeLydGkMkMD5fvEQhixgBzwE+hSVzI6R5+h8XL2/35gRNE6Hr
 XqCrLE3BJyM1RWZfr+Pv4EWS6F82h0U=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-FZbEkkc_O1KGmPPI8sj05w-1; Mon, 14 Jul 2025 18:57:17 -0400
X-MC-Unique: FZbEkkc_O1KGmPPI8sj05w-1
X-Mimecast-MFC-AGG-ID: FZbEkkc_O1KGmPPI8sj05w_1752533836
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-86cff09d29dso87350139f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 15:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752533836; x=1753138636;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKyZAq4pdwBfJ6Q1QwFC71krqpHYodFPSDVsG9yLQXA=;
 b=dF3uwBpBEEZ+UmcnTwYFldP0aXL5fHq6MVd6FWyip9UJyGgBf1JtJnb2wH0Sk9ZfLX
 Q3ph/ALlEhDrlEGXG5DX3lKdFFdascVo23i2aIfP4Ci2UuVgcqdK8ImYJ5BOQl15J3ul
 m5SKthmuEmQXMheHr77Q7845wSbXjZfqFpxXCqV8SXdetrVQrI6GfF3WkOAJRdaNMSbW
 yPZ+iGWJ0toA6pvG74dVAbN6jLjqu0aYmar0PqMZTAJTEzFDFTc5/xt0BZdgtmia6uD5
 YEmUt/zOvDb5QHSKYtiLFKZNN4CjkO8BMdaSRRoiLRommLpCGMIcLRsMFhxxiBgz6XSg
 zgeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsbfdxcfUXLiLzysiz8UKBdLRue3hNL8j9nBgLgfQDt/x98DUSGPpko0HPiBjcJ/wqBpgy/hoAAq7o@nongnu.org
X-Gm-Message-State: AOJu0YxmtJjhm2xpoHNl/nsTTcfP6g2Gch761ei+fbZllBh3WheSUvoG
 XdkGo2Usn0eiXjNM/d57WpJ7b9nYX9/1mwe8SN6JwYu95COCqWBIcHUuLVr2it7wNB5SRD7At2q
 1+hDxQ9Cfcw+72ij3twIG91nQJ6L6vGRVEy329ZkIp8569+rh6HKD7Qwz
X-Gm-Gg: ASbGncsa5bSYsC+5WAM5OmVxCSCq+KWvkJsdPGDOiQ9/k5M0pnbwvVrY2pdWxw/bHOp
 NM2CkI3TtSpQY6K1HeEroF8CVPtBvrRsSNHdIiwGGUV5eTEjHRc4PIi10GAh7QuJeUvpZzebqno
 hErpQjxmvE7yLpZnhMnHBsI7eObuxZlWsEgp7H/gYjYVWXhv0+XP08TBKkZypMLKiggQXPito69
 gGy6EdofKsb7JfXi/N/VyhLk8Y4St+UO1EmdXhfQa48SYp9Kf8DqoM7yj+YlC3w59SALAAvFJlu
 bufoLzzt1w8kp4cEbYxr5vpcawt8UwpCir1NkRmYuM0=
X-Received: by 2002:a05:6e02:1c28:b0:3df:3208:9698 with SMTP id
 e9e14a558f8ab-3e2531642bamr47883355ab.0.1752533835881; 
 Mon, 14 Jul 2025 15:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG72/d3IyCtQpB/8xQ5x+qjHVkqzE5Kk8JsgXWPyj8aE1RrEY3wDEDJDYyeRz7uMEDD53adzA==
X-Received: by 2002:a05:6e02:1c28:b0:3df:3208:9698 with SMTP id
 e9e14a558f8ab-3e2531642bamr47883295ab.0.1752533835461; 
 Mon, 14 Jul 2025 15:57:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e24611b128sm32930845ab.11.2025.07.14.15.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 15:57:14 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:57:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] vfio/pci: Introduce x-pci-class-code option
Message-ID: <20250714165712.3ea616ce.alex.williamson@redhat.com>
In-Reply-To: <20250708145211.6179-1-tomitamoeko@gmail.com>
References: <20250708145211.6179-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue,  8 Jul 2025 22:52:11 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> Introduce x-pci-class-code option to allow users to override PCI class
> code of a device, similar to the existing x-pci-vendor-id option. Only
> the lower 24 bits of this option are used, though a uint32 is used here
> for determining whether the value is valid and set by user.
> 
> Additionally, to ensure VGA ranges are only exposed on VGA devices,
> pci_register_vga() is now called in vfio_pci_config_setup(), after
> the class code override is completed.
> 
> This is mainly intended for IGD devices that expose themselves either
> as VGA controller (primary display) or Display controller (non-primary
> display). The UEFI GOP driver depends on the device reporting a VGA
> controller class code (0x030000).
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> v3:
> * Save the vdev class code when it is unspecified.
> * Call pci_register_vga() in vfio_pci_config_setup() to ensure VGA
>   regions are only get exposed when vdev is VGA.
> * Check vdev class code in vfio_is_vga().
> Link: https://lore.kernel.org/qemu-devel/20250528155548.29344-1-tomitamoeko@gmail.com/
> 
> v2:
> * Add vdev class code check in vfio_populate_vga().
> * Fix type in trace-events.
> Link: https://lore.kernel.org/all/20250524153102.19747-1-tomitamoeko@gmail.com/
> 
>  hw/vfio/pci.c        | 29 +++++++++++++++++++++++++----
>  hw/vfio/pci.h        |  6 ++----
>  hw/vfio/trace-events |  1 +
>  3 files changed, 28 insertions(+), 8 deletions(-)


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


