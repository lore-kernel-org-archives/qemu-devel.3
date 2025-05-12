Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD9FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMHZ-0002wz-Bc; Mon, 12 May 2025 02:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEMHY-0002wq-5Y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEMHW-0007TO-Fd
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747029893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjAk5Tau8mvj+da8kl84b7W9qhFF2kjgfE7CbnegdBI=;
 b=cGGh0Tn1m9jyPIXxTgt6b7WowEuwHL2dpWtDaJf5Scr/gG5ukEISDY+GdyubxvXH1kXCz8
 K55hQM8BK5+oo5cLomGnd42zCOuTe8hvN99CxfJmegvwnSPikx6uhI304vJi3O6RbpCi1v
 9i/GOn/PkqWjYd6IH9KfGWbspyMjmEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-GtwoCftZPg631BzpJEPDKA-1; Mon, 12 May 2025 02:04:51 -0400
X-MC-Unique: GtwoCftZPg631BzpJEPDKA-1
X-Mimecast-MFC-AGG-ID: GtwoCftZPg631BzpJEPDKA_1747029890
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b1798d69so1272284f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 23:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747029890; x=1747634690;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjAk5Tau8mvj+da8kl84b7W9qhFF2kjgfE7CbnegdBI=;
 b=NAhEjr2w8sAy3yPY1qrbSh6QRmFvDi94RIRY/oi5+E/deHxbxK8cu2gjljj7xgWfbF
 u3xoRyJFy8qw3ZhQBPZN9B8lPoII89vIYyD7Qg+gXNHKbp+dR8B2V13khsw15lEPvuWm
 +Kwnep5d7xBXCCdLwUzJRJHYC8F2YHFafGpYMvDZbuueMzelBsMAa+tQiUDlRObW54UJ
 Jenxxh+W2/YXX3oGulODq8B6YQ8ApOl5zgqVYbQ8RDa/pr6tM38P3/py6HTuhgNoEcnp
 gNr10AZy3xGDxJqMHyQ04E9XtDzg1odwIsscN8LgzqKHrJpQjtp9y0/XKLYLHKiboc68
 4z0w==
X-Gm-Message-State: AOJu0YwfOqvEADG+R5uAmouziodFPN9LcmtUrzqF8PxKkmakKzzcWEg6
 byuPyCvyLztRlZTmtrThEYDaSRR6rfyQhB3NZZ7B8GAXvCXGCabK7kb35iz1GGydAuemMeW17Ii
 qluGvRSUy9zosOPGkftk7Owi/OuWwdwlBbKUStUYX1RsvKxUX0H2o
X-Gm-Gg: ASbGncsp62T39CDKloJ8bEkBmhCa1QjItSYssY3O5/CGxXkNHkfrkrwvvmbd3p0uMuZ
 g2IFyT6SbxK6tjW8fORPAtmxAJJopVqNJwJvClSAL2Nud2KUsredzTSAGj7PGajB8rDKnRlVub7
 0nOgTKbv+vku12gEBtQIEVzsaGyT1GkRRDeHu8IF5DkeY8RVk2iCQ/ZwyCdeTraKajZYtJsndz8
 lbdBWn0zLrqH8hY3Rb0cSQebVvCFxiqSOW8xiSUAC9ChecZNyxtrY50HTb8aJeLpvlalA1ZWnwx
 aj4NgQ==
X-Received: by 2002:a5d:4081:0:b0:3a1:f68b:60a8 with SMTP id
 ffacd0b85a97d-3a1f68b60ebmr7095355f8f.10.1747029889992; 
 Sun, 11 May 2025 23:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlVbyJkaP/aVazp3pM7F5TQbSH/I4Bc/WzRLxayXAUHiObARXrKkQrRziz+Y9rYO/0pdW8jQ==
X-Received: by 2002:a5d:4081:0:b0:3a1:f68b:60a8 with SMTP id
 ffacd0b85a97d-3a1f68b60ebmr7095336f8f.10.1747029889675; 
 Sun, 11 May 2025 23:04:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2fe6sm11497472f8f.58.2025.05.11.23.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 23:04:48 -0700 (PDT)
Date: Mon, 12 May 2025 02:04:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
Subject: Re: [PATCH v2 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Message-ID: <20250512020427-mutt-send-email-mst@kernel.org>
References: <20250512040537.15557-1-sarunkod@amd.com>
 <20250512040651.15590-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512040651.15590-1-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, May 12, 2025 at 09:36:51AM +0530, Sairaj Kodilkar wrote:
> From: Vasant Hegde <vasant.hegde@amd.com>
> 
> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
> But if vCPUs <= 255 then it won't call kvm_enable_x2apic().
> 
> Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is
> broken as it fails to call kvm_enable_x2apic().
> 
> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
> 
> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>


You did not actually Cc Philippe.

> Cc: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index df8ba5d39ada..af85706b8a0d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>          exit(EXIT_FAILURE);
>      }
>  
> +    if (s->xtsup) {
> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
> +                          "the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>      pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>      amdvi_init(s);
>  }
> -- 
> 2.34.1


