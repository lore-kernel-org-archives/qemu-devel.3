Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CC2C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 22:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdz6b-0002Lo-IE; Fri, 31 Jan 2025 17:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdz6a-0002LM-8u
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 17:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdz6Y-0002LZ-5i
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 17:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738360992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DSqWvPm5uuod36/74I+gSIdP2xlkiJP+wBOzTwsZ8E=;
 b=NulTTLIjskdFexB2QRWgVVRabzkIrmW0qwVa6cIzn5lHz2jXWa9056sVNxaobtWUif6vjZ
 GAcbbEsL2kjAIz0Wlhpznx1zQ7k/+hvsZPyN01uhMZ5VXgdg7FMXjL3PHS+6NE1FdXskvm
 nkK5NElA4d6hbkC1F5+S5aX6M8dM7v4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-BqeZ3Zl-O0a2dDS8uxHIkg-1; Fri, 31 Jan 2025 17:02:04 -0500
X-MC-Unique: BqeZ3Zl-O0a2dDS8uxHIkg-1
X-Mimecast-MFC-AGG-ID: BqeZ3Zl-O0a2dDS8uxHIkg
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3d0003f4972so2657465ab.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 14:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738360924; x=1738965724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DSqWvPm5uuod36/74I+gSIdP2xlkiJP+wBOzTwsZ8E=;
 b=pyyk9sFfH1HHXhNvz4bARA7Y8odIBJIKgtDpkmvu9jfwZhHZ/mh6WD923jJ40v2vHP
 aBEgMvcHyjPFVUj6qv591r68ZBNQVAthjcb9G7/19EkCDRhnBv+LGrrDG9dmY3D3qNm7
 LIlvZSaqzvV8m6fq8XUewP8grTmGYzLzVMz5KKJGJjQjg2ncKTOHlhSNaGrrnR74noDZ
 5EoBCMRBOMCpRIDEFrkE+6XIZj8ZLKSG4JauB/zvnM/zu1Tz2Ix9pfy8cr+zUovhf5I0
 JWt+jzD7dV7ezT3Rs2giDyia6CtyKatOCQvlmZorslrxDDrg5pjx1FwB02CUMOLU3dOu
 MxJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyzKSNbZgDvpLqpePTzGntebEACl1dLUlO71fnOi20L+R8fV6wHvVzBNJO8rxAIiKRuCguwABoB1wL@nongnu.org
X-Gm-Message-State: AOJu0YzuImFfghW3eJ0qLwCiagxxsxsBgjGKtVcaZt4M9uEn/AL72UkI
 aQjAq6tO8LEXYaEh84sECFzBUl5yAbAUSH1qxBNCrbW6NxxgAV8vvJEoOZeBriWZ+KRnk4T9RbJ
 OPblokaimkBjtR572Sm14hbFSVPDK9i6kTvjO6rO57roPRLqs8iUD
X-Gm-Gg: ASbGnctxWXFhOHy3cs5Ns5ZmO5drq9VUB9y/CYBNUj2H4wk6wUmSHzaM1wj3HgK9A1s
 faulkGiPx6yWTD79xtI0CSsw5u3/OJ8HY272NIJPz+5fv3WixkW8jq3Moj6fDyY5XYdhtwpm7kq
 Eh8JES/2FDqY0Uu5j6VItyr1eMt8ir1bP9NWu2P/GHAnWM0gPgB+cmoTmiOJiWijA8j/4sxuYa8
 u5jxaod8UgLewfHl3qEXZ7EvOC5MWclKoOBe9xa04aIwkhURdhBytV9hT4/oPhfSpP8ioRDnZfB
 HI6XdK75
X-Received: by 2002:a05:6602:1782:b0:83a:e6b2:be3 with SMTP id
 ca18e2360f4ac-8549f72e4e9mr208816739f.0.1738360923944; 
 Fri, 31 Jan 2025 14:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBLsOgCraVbGtXNuqslsyzS03v1aIM/mhRwNzs7ELSZwl9OhK1zR76XTX8Ktx6phlijpmuaA==
X-Received: by 2002:a05:6602:1782:b0:83a:e6b2:be3 with SMTP id
 ca18e2360f4ac-8549f72e4e9mr208816039f.0.1738360923543; 
 Fri, 31 Jan 2025 14:02:03 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854a16078a3sm103935639f.19.2025.01.31.14.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:02:03 -0800 (PST)
Date: Fri, 31 Jan 2025 15:02:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: clg@redhat.com, vaibhav@linux.ibm.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/pci: Skip enabling INTx if the IRQ line is also
 unassgined
Message-ID: <20250131150201.048aa3bf.alex.williamson@redhat.com>
In-Reply-To: <173834353589.1880.3587671276264097972.stgit@linux.ibm.com>
References: <173834353589.1880.3587671276264097972.stgit@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 31 Jan 2025 17:15:01 +0000
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Currently, the PCI_INTERRUPT_PIN alone is checked before enabling
> the INTx. Its also necessary to have the IRQ Lines assigned for
> the INTx to work. So, check the PCI_INTERRUPT_LINE against 0xff
> indicates no connection.
> 
> The problem was observed on Power10 systems which primarily use
> MSI-X, and LSI lines are not connected on all devices under a
> PCIe switch. In this configuration where the PIN is non-zero
> but the LINE was 0xff, the VFIO_DEVICE_SET_IRQS was failing as
> it was trying to map the irqfd for the LSI of the device.
> 
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/vfio/pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab17a98ee5..69a519d143 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -264,12 +264,12 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>  static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>  {
>      uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
> +    uint8_t line = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_LINE, 1);
>      Error *err = NULL;
>      int32_t fd;
>      int ret;
>  
> -
> -    if (!pin) {
> +    if (!pin || (line == 0xFF)) {
>          return true;
>      }
>  

vfio_intx_enable() should be the backup that catches users trying to
configure INTx, but we should also be indicating there's no INTx
through the IRQ_INFO ioctl.  The value in the line register is also not
defined by the PCI spec, it's implementation specific, therefore for
what architectures is this interpretation of the line register valid?

Should we at the same time virtualize the pin register as zero?

Maybe it's also time to implement similar checking for dev->irq ==
IRQ_NOTCONNECTED.  Do Power systems make use of the IRQ_NOTCONNECTED
convention?  Thanks,

Alex


