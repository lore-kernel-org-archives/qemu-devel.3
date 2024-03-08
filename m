Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C30CC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rie88-0005Fq-B2; Fri, 08 Mar 2024 12:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rie7q-0005D3-Ql
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:35:18 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rie7o-0007go-5Y
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:35:18 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5a142375987so853897eaf.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1709919315; x=1710524115; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=42z1c6En4OMO73HSWbt9qhFCGOY4c7z3vfsZqA96K6s=;
 b=hQwekRr6Z/WyJww+zzRgKagXY/asdvATDc4wzv7WRHHT4cHqhpwA0tzMtbOSfBwdv4
 nwdf0hHZGZF6g4MRHHqPoUvwzzXVucJ3wqQ/dIk6RqWNMteWmNHpG/Bdoz9Cbg0ifR60
 mqTmVmKZDmOJ4jrZPhJBEsLmGrt33PDroLCj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709919315; x=1710524115;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=42z1c6En4OMO73HSWbt9qhFCGOY4c7z3vfsZqA96K6s=;
 b=cAZf918Nln8EeBr2XheoP9Y6m/BJteSnRidTA0oSEid9bYD24DcfewJghsppW/xzUT
 rsWr4vfvqgpBmsFF7yr2Qt22O5RC0FYHzLYoGQULiZkqOEiRjf/qXEx7TOrEBqKI4wWd
 tb3eAMH6awoHYBMF0t52UG4nEpWZqAt3b7mYZn9Xgav6TNcjSx9MrzTtjxWSnbGM7n7o
 oUeubjgqmosW56YfM7fsVc+aYvZJsFeXRIcm+8sp41Vq0frqA782yCm7Xf5z4BjBhqIE
 r8YhFfNCQoWqk2f6ymy0nGYFEDmbK3vHonkea/uNVeBkSMAWrWPDqTTdMdvOvTPazj69
 6gQw==
X-Gm-Message-State: AOJu0YzEGdrkI/qLwskTvYf9KaBDhLt4k+dN2azn7xndPyER1/b/pl0p
 +JwtA5kXVGfir82BeEBxXfa8QtBtxKp1JfDmBacTT8dTeSkDusHw5DzX0QuvYvM=
X-Google-Smtp-Source: AGHT+IFP+iIn7ziPACo/W5ywuwt3jU9vKOJI+Md4melHw3m+IPRBayOOv3MnfyWInvHuBqQD34WXQg==
X-Received: by 2002:a05:6820:2227:b0:5a1:34cf:400c with SMTP id
 cj39-20020a056820222700b005a134cf400cmr12525786oob.9.1709919314653; 
 Fri, 08 Mar 2024 09:35:14 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 z5-20020a05683020c500b006e12266433csm2248064otq.27.2024.03.08.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 09:35:14 -0800 (PST)
Date: Fri, 8 Mar 2024 17:35:08 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, mzamazal@redhat.com,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 01/29] bulk: Access existing variables initialized to
 &S->F when available
Message-ID: <a495a2c8-0259-4a44-8ac4-9cb6052074b6@perard>
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129164514.73104-2-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=anthony.perard@cloud.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 29, 2024 at 05:44:43PM +0100, Philippe Mathieu-Daudé wrote:
> When a variable is initialized to &struct->field, use it
> in place. Rationale: while this makes the code more concise,
> this also helps static analyzers.
> 
> Mechanical change using the following Coccinelle spatch script:
> 
>  @@
>  type S, F;
>  identifier s, m, v;
>  @@
>       S *s;
>       ...
>       F *v = &s->m;
>       <+...
>  -    &s->m
>  +    v
>       ...+>
> 
> Inspired-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 36e6f93c37..10ddf6bc91 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -710,7 +710,7 @@ static void xen_pt_destroy(PCIDevice *d) {
>      uint8_t intx;
>      int rc;
>  
> -    if (machine_irq && !xen_host_pci_device_closed(&s->real_device)) {
> +    if (machine_irq && !xen_host_pci_device_closed(host_dev)) {
>          intx = xen_pt_pci_intx(s);
>          rc = xc_domain_unbind_pt_irq(xen_xc, xen_domid, machine_irq,
>                                       PT_IRQ_TYPE_PCI,
> @@ -759,8 +759,8 @@ static void xen_pt_destroy(PCIDevice *d) {
>          memory_listener_unregister(&s->io_listener);
>          s->listener_set = false;
>      }
> -    if (!xen_host_pci_device_closed(&s->real_device)) {
> -        xen_host_pci_device_put(&s->real_device);
> +    if (!xen_host_pci_device_closed(host_dev)) {
> +        xen_host_pci_device_put(host_dev);

For the Xen part:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

