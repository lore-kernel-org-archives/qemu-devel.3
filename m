Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB7DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 18:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tubZG-0004d3-TS; Tue, 18 Mar 2025 14:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tubZ6-0004cG-Vu
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tubZ5-0003Jg-BA
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 14:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742322080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us4nk3fF8koMbxF8G+Cw7Ne2OQGvH4wm6Au3I7C6iwg=;
 b=g6Yp4G0n/SzcnOGwtMLt1/hg+/GtIG4s93UqHU3UT5kPaAIAP3p1i8ldiwk4TbbIB1xJHK
 QFb0LWfuP1QP5H+l744NgDXN4hwxIfA/EqLSxk1oM5EYgPohnybSRdgEdZIOX/73tpprQN
 lEuY/YsCLXY3OCYw99J34M5KmR/H7eA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ghuLe7JxN_61fVX00EkYcw-1; Tue, 18 Mar 2025 14:21:17 -0400
X-MC-Unique: ghuLe7JxN_61fVX00EkYcw-1
X-Mimecast-MFC-AGG-ID: ghuLe7JxN_61fVX00EkYcw_1742322077
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3d585d76b7bso107575ab.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 11:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742322077; x=1742926877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Us4nk3fF8koMbxF8G+Cw7Ne2OQGvH4wm6Au3I7C6iwg=;
 b=Xc8zqB/Rz+/t6Fpc3h4IoZm7rq0FtGBL8rqhVQks2ejdHy2hWYVbkGCQ4TIhnAG/id
 KARd8EgbEzlt7IiK8bdAHMwhJDpG8ut0g2NCYjxPFToA1MiSGQsm+jc/oDH7WpVy+USo
 nmBoo9yBLfF2r0l4CK69LFhxFjEdPozLJEGPFLjGgtXpkaegBDLPbkv2P18MQGJBYqSl
 tYtr1F9HG6wU24Rdg2/LnfFLBldeEpttXd5agG0HTXxBQ7N+k4Z8aM1PmYZp1D9Q3B00
 /pwCccmIWZNoTyH7HMCdpozxyBtkzJC+i1K4e+YHOiBUUEUqa5rOPCIT1qqb2DCgwXP3
 x3Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7OmhAXFuRFgbjLxUObkgXPhqBa9/Uv66ANlI6Ee6EExwWtoa3Stoye9VLsXBRPIXosz5L8ftZh5Y6@nongnu.org
X-Gm-Message-State: AOJu0YzRsu7WL18rqY0W3noirDxSfb5AOi6BCivtB+mWVT4NkUQXGfjK
 rOfG+uhfNgnbuNCQOUvcq4h2YG1XqbVKaAxF1SgoUO+BbQLbDBXyttHU9SK4txqdSzyViYmrZFF
 dS+3CAQTMon4p3lzuGBWwleAZV5LS4vdwgu9WTvjpZwzhm6W1hCn1
X-Gm-Gg: ASbGncsue4CkPKYNfIj5zmOfE88O2Lk9HG7w0/qQSHEogHX0Mzu3RGOAbMjjcTjuaK9
 r4PprR0U8Nzd1e7LNLTTvgNuiGotqqG9ECqpN05dRTlpV4ns7mJ6ADOAAxhMNH+JMXfWxNnjJ4e
 iKbcoB2kBysRVwNSAeihCWfzl+UxMd1Vf8VNL6/4tiX+Iejv+R8qJWZRuRQZYpbWIg3y/orfOPT
 H2Zcs86Qb4Ag03bqI+CLMk46/VNilx121NRze9x9defVlpZj9LVWM5Cby16qcCVZhtcChRiiptc
 Z36W/lyyEk91BKiN8VM=
X-Received: by 2002:a05:6602:1553:b0:85a:fdcc:571d with SMTP id
 ca18e2360f4ac-85dc4b35bf4mr640668939f.4.1742322076957; 
 Tue, 18 Mar 2025 11:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJu8DxKjI7RM0XeTYSeU5RgAEhHxGW9NeQ3JNEZ9L5UQw/KYPFv7cj8tPFk6ZUxIkatvhjfg==
X-Received: by 2002:a05:6602:1553:b0:85a:fdcc:571d with SMTP id
 ca18e2360f4ac-85dc4b35bf4mr640668139f.4.1742322076503; 
 Tue, 18 Mar 2025 11:21:16 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f2637196besm2839553173.43.2025.03.18.11.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 11:21:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:21:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: clg@redhat.com, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 vaibhav@linux.ibm.com, npiggin@gmail.com, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] vfio: pci: Check INTx availability before enabling them
Message-ID: <20250318122114.5e8fad2f.alex.williamson@redhat.com>
In-Reply-To: <174232032506.3739.465958546360660842.stgit@linux.ibm.com>
References: <174232032506.3739.465958546360660842.stgit@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 18 Mar 2025 17:52:53 +0000
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Currently, the PCI_INTERRUPT_PIN alone is checked before enabling
> the INTx. It is also necessary to have the IRQ Lines assigned for
> the INTx to work.
> 
> The problem was observed on Power10 systems which primarily use
> MSI-X, and LSI lines are not connected on all devices under a
> PCIe switch. In this configuration where the PIN is non-zero
> but the LINE was 0xff, the VFIO_DEVICE_SET_IRQS was failing as
> it was trying to map the irqfd for the LSI of the device.
> 
> So the patch queries the INTx availability with
> VFIO_DEVICE_GET_IRQ_INFO ioctl, and enables only if available.

The kernel should just virtualize the PIN register to report INTx isn't
supported, as we already do when INTx is broken, or for platforms that
don't support INTx, and as proposed for INTx set to IRQ_NOTCONNECTED.
No QEMU changes necessary.  Thanks,

Alex

> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
> Changelog:
> v1: https://lore.kernel.org/qemu-devel/173834353589.1880.3587671276264097972.stgit@linux.ibm.com/
> - Split the fix into two parts as suggested. Kernel part posted here [1]
> - Changed to use the irq_info for checking the intx availability.
> 
> [1]: https://lore.kernel.org/all/174231895238.2295.12586708771396482526.stgit@linux.ibm.com/
> 
>  hw/vfio/pci.c |   24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7f1532fbed..54de6e72f8 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -261,6 +261,25 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>      vfio_intx_update(vdev, &vdev->intx.route);
>  }
> 
> +static bool vfio_check_intx_available(VFIOPCIDevice *vdev)
> +{
> +    uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> +    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
> +                                      .index = VFIO_PCI_INTX_IRQ_INDEX};
> +
> +    if (!pin) {
> +        return false;
> +    }
> +
> +    if (ioctl(vdev->vbasedev.fd,
> +              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0) {
> +        warn_report("VFIO_DEVICE_GET_IRQ_INFO failed to query INTx");
> +        return false;
> +    }
> +
> +    return (irq_info.count != 0);
> +}
> +
>  static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> @@ -268,8 +287,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>      int32_t fd;
>      int ret;
> 
> -
> -    if (!pin) {
> +    if (!vfio_check_intx_available(vdev)) {
>          return true;
>      }
> 
> @@ -3151,7 +3169,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                 vdev->msi_cap_size);
>      }
> 
> -    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
> +    if (vfio_check_intx_available(vdev)) {
>          vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                                    vfio_intx_mmap_enable, vdev);
>          pci_device_set_intx_routing_notifier(&vdev->pdev,
> 
> 


