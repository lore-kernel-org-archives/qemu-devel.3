Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA7C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woztF-0003IQ-37; Wed, 29 Jul 2026 04:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woztD-0003G0-Lz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woztC-000088-5Z
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785314624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DAGGP5QXxi3mhB7GbwBrdNAdCNNISFOhsYV+1bzHjIw=;
 b=UaMd3aBOWeqEOAcqFJBSOjrdcB1SxBsCDS0QpFhKvgTcUO0NtYWMECnkOHhIiQ1z/RzWDi
 QMlqwIdaAGrlMcB849EuZy70aDZZbKXJNaRY70wwfk1LmXo6UsV6LQY3HgLbaHC3IMpEeU
 T//l+WdFgZ1iX8J2T3hFOu1Rt4x3Hhg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-E9vYkyY7OSi_69yrCqXABg-1; Wed, 29 Jul 2026 04:43:42 -0400
X-MC-Unique: E9vYkyY7OSi_69yrCqXABg-1
X-Mimecast-MFC-AGG-ID: E9vYkyY7OSi_69yrCqXABg_1785314621
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954fd771baso11626275e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785314621; x=1785919421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DAGGP5QXxi3mhB7GbwBrdNAdCNNISFOhsYV+1bzHjIw=;
 b=s3CqN1I1Yj52Gq3pv33D7ZJhMbkniU2Vns8NURBsqSusJ0IGoKfZ+5hWlN39L6qR87
 /Ppw3oBFhyU5aLoRSZOq3mX4Fxj4/BHh8vVJ4CU3r6CUyX/o1JoMAnJS7zLl3bSIu25y
 kpkeMGHP//rfjLdvRleEA4L8SUJYljSBUuXSDUZTr/A/ngufj4eUSGfwjszKQjyaW3si
 lzgyxerLKRr4Z2CcJ1VbNjmqs53Z8wf3Sixdi3VPMacIiET3KgLBa3AZoOYsrc2YLXfc
 bYCpV6jY/HsWmlRDOOJuLzQUMoyN7Yr3N85meGNgyo8GHogspU8xVmPqcNXQtBfc9V8b
 j4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785314621; x=1785919421;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DAGGP5QXxi3mhB7GbwBrdNAdCNNISFOhsYV+1bzHjIw=;
 b=SHErW4BZyBi8wV9j5MqfbyIdEL0F5zLMJCnAxTV6SUHgP65HC+f9oqxLVwtJf5s9/b
 C0Fgyqe9dPDTvFZJBB30u9hVRcbHMPS4Dpr5GOh7sxuM25efVJ3BLHAC5lh9Ob8A1vIJ
 HTdYF7+bE4WJBS5QNxtCk1IxolMjwwAzCn0Q0LBJ3tmRybbumI1PjVYUpKcVFa/O2boi
 n8U5ZkP5ODqI8DD6Eov3XojSOTyQqfVnPCwh7ucvPGOr9M2eooCKDzyWIPXnV+JcKWWG
 Xgnrx5UhvGGlGEk1ZcxYLyujoZFzQFYpWDPO+fQ8oqk1SuALFYdlhMBenMKczgu/FA4J
 tlww==
X-Gm-Message-State: AOJu0YxK2BiAQAIug6ZBTIaxE8fDRigRwdLaR+3UkCWquN8J5PxsspXv
 gzodKxxqKhY0PgAqn0nHwrRSqFmmQ4wEOoLJKZCA4vvb8Eqf0jVpUefv+Se1wWSzbtW2gmZA7+5
 Mgw9OR3pQunEXAeTM4hia43YWbbRLk3XXmBgK45rlEB4jG2UT+EPK9ghWyVrt9n1QF+B0fPwuDC
 4f61tS5pryCydZ6j9Tmczdi8DFRInmPCZY9Q==
X-Gm-Gg: AR+sD11wSLb2laiOgTfy2jtGNwV8gPNoOGnJdWnJF0Vt+B0ARvmHy/AE9YxGHuM9Rk4
 C8VtnCWd0QZefXd2ePtQwQQWsyQGKsIEuNniVyy2taMEXZq0U8Z7UNxseI5AsZPlak5LtJNd5m2
 DvlmRYV3go/7Ky5kk7Z10RxKrCsRR0zGEvCYb/HOvtotePE9fwmGjMf6+SBymKwiMRrFxlBReyZ
 5LWaDVRMudfUlKAHr6ld3H2va4LLZEzpaR8VRQFkjH9PPH98zh2aEGnVliU/7JYWxMzjUy8OMLC
 VS/xHMJ8uOsPzGufvkBXPqIk1rmNgEgO7eh7MjHOBIjGyeEVWgocTIA8h+EFztT/Xw6hZEw//75
 jdXvUcNbD+t9AXQzLTfX8BjQgoUL5RWdCMOP8jbo=
X-Received: by 2002:a05:600c:c4b7:b0:496:bc89:f0f1 with SMTP id
 5b1f17b1804b1-497fd310ff4mr14040935e9.14.1785314620747; 
 Wed, 29 Jul 2026 01:43:40 -0700 (PDT)
X-Received: by 2002:a05:600c:c4b7:b0:496:bc89:f0f1 with SMTP id
 5b1f17b1804b1-497fd310ff4mr14040625e9.14.1785314620224; 
 Wed, 29 Jul 2026 01:43:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-497fecfccc7sm3464815e9.12.2026.07.29.01.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 01:43:39 -0700 (PDT)
Message-ID: <e524352d-d155-45fb-9389-1844602ac5dc@redhat.com>
Date: Wed, 29 Jul 2026 10:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Guard accel_irqchip_begin_route_changes() calls
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20260721105026.3932297-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260721105026.3932297-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a regression with TCG.

VFIO needs these changes to correctly fall back to userspace interrupt
routing, as before without aborting.

Thanks,

C.

On 7/21/26 12:50, Cédric Le Goater wrote:
> Since commit 49b2dcbd2422 ("accel/accel-irq: add generic
> begin_route_changes"), accel_irqchip_begin_route_changes() aborts when
> no accelerator irqchip is available. This causes a fatal error when
> running VFIO passthrough devices under TCG emulation:
> 
>    qemu-system-aarch64: can't initiate route change, no accel irqchip available
> 
> The previous kvm_irqchip_begin_route_changes() was a simple inline
> that did not have a fatal path. The VFIO code already handles the
> absence of KVM MSI routing gracefully by falling back to userspace
> handling, but the new generic function aborts before that fallback
> can take effect.
> 
> Guard the call sites in hw/vfio/pci.c with
> accel_msi_via_irqfd_enabled() so that route changes are only
> initiated when an accelerator irqchip is actually present.
> 
> Fixes: 49b2dcbd2422 ("accel/accel-irq: add generic begin_route_changes")
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 380dd8c15f8d5bb98b725075978eef2e4e1e6c2d..a3147d28665abd29fd804bd08bdffc3c7440033c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -699,7 +699,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>           if (msg) {
>               if (vdev->defer_kvm_irq_routing) {
>                   vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
> -            } else {
> +            } else if (accel_msi_via_irqfd_enabled()) {
>                   vfio_route_change = accel_irqchip_begin_route_changes();
>                   vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
>                   accel_irqchip_commit_route_changes(&vfio_route_change);
> @@ -801,7 +801,9 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       assert(!vdev->defer_kvm_irq_routing);
>       vdev->defer_kvm_irq_routing = true;
> -    vfio_route_change = accel_irqchip_begin_route_changes();
> +    if (accel_msi_via_irqfd_enabled()) {
> +        vfio_route_change = accel_irqchip_begin_route_changes();
> +    }
>   }
>   
>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)


