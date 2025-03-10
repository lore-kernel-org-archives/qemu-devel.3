Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68430C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZqE-0006Eb-3Y; Mon, 10 Mar 2025 05:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trZq4-00068K-5T
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trZq1-0003Rk-9o
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741600458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tR0W3AO0rtff4oh62slL6VIU1K2VGl5ZuTDMwGnr9WQ=;
 b=a/nD+Dx/IhpBLUVX5NRenDwpdc0yf6+HEA0RAJjPnX7Hvac1UpgBVxwI7nNPeZOsTXfxpQ
 5ZKF9c2P0Vmb5ieuXmKb7RYLIFTBb+dLPws3MdoIWYYzkCaDfwx40rPvwDlBKFPYUnaE29
 6G1wVJ6cm8dV4XKkoo6/rVY4BaZUtd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-w6BIYLVgOK-52JL1F9IlpQ-1; Mon, 10 Mar 2025 05:54:17 -0400
X-MC-Unique: w6BIYLVgOK-52JL1F9IlpQ-1
X-Mimecast-MFC-AGG-ID: w6BIYLVgOK-52JL1F9IlpQ_1741600456
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912d9848a7so1596784f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741600456; x=1742205256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tR0W3AO0rtff4oh62slL6VIU1K2VGl5ZuTDMwGnr9WQ=;
 b=jVvGYf/TWhFuoBEaOt8/e/aQO9aAMHSr+ghTO5dXTwx1RyDz1m8QKP7NsT117iNQ3a
 F4c+0YZU9kZDUQ+2YT9Vlo0zKnigU0ygygGd+0NxZKbYW4qst8J4ykSUXPI7ZX+dDS58
 k6fuKr08mdTbto8fhUHRYVBxViBYZzcXpWuvD6S41jihq1jYy+x7hYijD0vBPoLpVIYY
 H6aW8EFbzPuGelhB2ihd45AM0IaDjck2J1Qk4zez1xUj1V8JltFcWrI4Q13fKTCLtZKY
 9o1rihWCC2ndRA8s8G/ZB8LERk8D3sdwe3cnsfEknj9kdVak7aRjL+kX8mlklam95lnT
 vZSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXntF1XjXgv4vy9U/oakELD5Bw/7MOPTZCsXmIVl21tO7SI0DATBoc6FWZwEkWR91BqJuZTclHUS2g@nongnu.org
X-Gm-Message-State: AOJu0Yx4uBbGF0mlmqekQgIbHSN/lDylQ+vq4aOi2gaWXy8Bs/u7z7FZ
 L09/TINCCbCBffOyku1Ub2A/H67P67wztx/WhkC0FNvqXsuJDbFBoPv0qvN9lG7NDp0bM3JvrZ5
 Z4lj5bcUYKnGysXbC5MXxcYoVZrGam8uskmcsPNB5tsigrsYjvWOm
X-Gm-Gg: ASbGncso0Kpc0Q1pC9vnb+N6D/cTP+QNBSsfQ/Ykqa/KnRUHJuUXvLHj3jNwHkpa4p/
 0Tkl8diYPnhQwukFDCgK+j2ylRgGLTN1KYPeyZIf9kPv6YmGwNN3q8BcjTlKDJkwSmf6lfTZQG+
 /hMbSXDlOaYD1DgEtrzfAXQrHQVT30In0m0Dh8Ghas1KSZTUe/7x801tD0jj7JdV2chGfFThd8l
 12mAg3UB1o8JEjXueZNPyItmnqp0tTHIvtc0R1KDjX+7dt2tdzED0dS3F5r6AYgubcGZICwU2Qc
 tROp1UqAKw6oAqovA3K28cI+NlBeLzIJQWLVqDBNUazA+tAo4jimQvHAfShwqgs=
X-Received: by 2002:a05:6000:156f:b0:391:27f1:fbf3 with SMTP id
 ffacd0b85a97d-3913af3d5e7mr4701969f8f.27.1741600456234; 
 Mon, 10 Mar 2025 02:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBwMz5OAHxD3v4jQKjBgjVWOLGr7PcCA4jbJyJk6K4hEfZpzb5fBnmL6u2Po0UZEfWnTksjg==
X-Received: by 2002:a05:6000:156f:b0:391:27f1:fbf3 with SMTP id
 ffacd0b85a97d-3913af3d5e7mr4701924f8f.27.1741600455800; 
 Mon, 10 Mar 2025 02:54:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7ae4sm13985560f8f.5.2025.03.10.02.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 02:54:14 -0700 (PDT)
Message-ID: <28c102c1-d157-4d22-a351-9fcc8f4260fd@redhat.com>
Date: Mon, 10 Mar 2025 10:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/21] hw/vfio/pci: Convert CONFIG_KVM check to runtime
 one
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-10-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> Use the runtime kvm_enabled() helper to check whether
> KVM is available or not.

Miss the "why" of this patch.

By the way I fail to remember/see where kvm_allowed is set.

I am also confused because we still have some code, like in
vfio/common.c which does both checks:
#ifdef CONFIG_KVM
        if (kvm_enabled()) {
            max_memslots = kvm_get_max_memslots();
        }
#endif


Thanks

Eric

>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index fdbc15885d4..9872884ff8a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -118,8 +118,13 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>  
>  static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>  {
> -#ifdef CONFIG_KVM
> -    int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
> +    int irq_fd;
> +
> +    if (!kvm_enabled()) {
> +        return true;
> +    }
> +
> +    irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
>  
>      if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
>          vdev->intx.route.mode != PCI_INTX_ENABLED ||
> @@ -171,16 +176,13 @@ fail_irqfd:
>  fail:
>      qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>      vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
> +
>      return false;
> -#else
> -    return true;
> -#endif
>  }
>  
>  static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>  {
> -#ifdef CONFIG_KVM
> -    if (!vdev->intx.kvm_accel) {
> +    if (!kvm_enabled() || !vdev->intx.kvm_accel) {
>          return;
>      }
>  
> @@ -211,7 +213,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>      vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>  
>      trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
> -#endif
>  }
>  
>  static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
> @@ -278,7 +279,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>      vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
>      pci_config_set_interrupt_pin(vdev->pdev.config, pin);
>  
> -#ifdef CONFIG_KVM
>      /*
>       * Only conditional to avoid generating error messages on platforms
>       * where we won't actually use the result anyway.
> @@ -287,7 +287,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>          vdev->intx.route = pci_device_route_intx_to_irq(&vdev->pdev,
>                                                          vdev->intx.pin);
>      }
> -#endif
>  
>      ret = event_notifier_init(&vdev->intx.interrupt, 0);
>      if (ret) {


