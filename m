Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E07AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE73o-0005eV-14; Sun, 11 May 2025 09:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE73l-0005dR-T6
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE73k-0002xQ-5l
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746971379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oeGpKGElYWdXPzY44xLkHOg5kh0ZxJrvla0lMfzEXOw=;
 b=TnrxiwW1MVJu5a3Hbmlp1uxgdv+fNT4NbkzzEkWck7O1391jMrmwpJ7KduWbz4YYQs3KmT
 f6lLnV4ENhh0DL5V/68f78R9JQNFQkuM6rPVulQf2rxy9XVU9oV21+zepXNHrq2GsDim7D
 J0d4Cms+K6vdJuTMG4j9wJpiMNdH1cs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-K7Q3aITyPoCjqN-LLsZ1Nw-1; Sun, 11 May 2025 09:49:38 -0400
X-MC-Unique: K7Q3aITyPoCjqN-LLsZ1Nw-1
X-Mimecast-MFC-AGG-ID: K7Q3aITyPoCjqN-LLsZ1Nw_1746971377
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso25544855e9.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746971376; x=1747576176;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oeGpKGElYWdXPzY44xLkHOg5kh0ZxJrvla0lMfzEXOw=;
 b=BPy4o4Wjue2vuXLm4eWgLx3IuM4peOcpdO7u3gY7HHbia7sGc5/fuJV7z+cCQR79FZ
 Jy21fomZrZbInZeD5KarBGZ61JfRHPoclDwfzKhoRqj5EjkPADM12R3N6qdE11asMD3D
 u0R6jHLWXSnajLPvSjXVyxTpxT6smCiGq8HXgrGtIkesfHWEM5w1dzpXy1e+Xs5vvBLe
 AYo9n+BC1g6FMr62UtOHFzmUlEW39bWlY/upzi5t3mHFA8YYiSFNZSaWYxUw+L0JlK7D
 hfvhrZubjE7QazYR3DFFe31Oq+ORFcHi/PfyiOaDjRwhMjR266ZTGLEqKSB3wObbCieo
 vqGA==
X-Gm-Message-State: AOJu0YwelAA00qgrVaE7/PVXMd6jUM9BEdpq/qY/gM5WxsX4DRssKGDu
 91zcYrj5IX18Yz/eTs0nNj/2kPovbhyO0gk71vjqF0N8Ys4fjye2Yhfo8uZe2HGaERlvOGaAqcc
 iNVeXTK9852m2AnzwkL4QRV0G+cjtdGm7gagZIqe9ArSKQjw1iCNo2BbSPJW6
X-Gm-Gg: ASbGncscrlP8MieAlLUhJwjB54fvFVCmk/cHyjmlVvHEUvF6tugjBFKjkA0zUB3Fujq
 v10zOVuLSJ11duLQqlb7BgexEFJX0COrKTohDsL5h4FrdA9Onw94H0GDkJQ+rNl7c6xdT1+KUUx
 x+zWd1+4B7OnrJvVUXNWEKECNuuMLiOq9S2/LalNNSD4BaxF9AZG7qIKATHAYE2hcR6ncBUP2SR
 gtBJg3j5GcFzN5RtQmHyYNimyXvNUPlPbA+0OJSl4P9SqeyXfgoQxT0LG67Rz5F0bBopxHoSoXG
 32gwVQ==
X-Received: by 2002:a05:600c:3482:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-442d6d1fb46mr95610435e9.12.1746971376621; 
 Sun, 11 May 2025 06:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2NXC9IiTkxQvIIZmNC+D37RbKV1hathZfceRhRAG+N+asE+0YvEQhdohdgfaxzzsKXhKTRg==
X-Received: by 2002:a05:600c:3482:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-442d6d1fb46mr95610295e9.12.1746971376213; 
 Sun, 11 May 2025 06:49:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d6858626sm94596225e9.27.2025.05.11.06.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 06:49:34 -0700 (PDT)
Date: Sun, 11 May 2025 09:49:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:MCIMX7D SABRE / i..." <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] Integrate IOMMUs with PCI hosts that have ATUs
Message-ID: <20250511094907-mutt-send-email-mst@kernel.org>
References: <20250307203952.13871-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307203952.13871-1-jason.chien@sifive.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Sat, Mar 08, 2025 at 04:39:33AM +0800, Jason Chien wrote:
> The struct PCIIOMMUOps is designed for use by an IOMMU, but many PCI hosts
> also utilize it to implement their ATUs, preventing coexistence with IOMMUs.
> Overwriting a PCI host’s PCIIOMMUOps disrupts its translation rules.
> 
> This patch series introduces a mechanism to route inbound transactions from
> PCI hosts to the IOMMU, enabling proper integration.
> 
> The final patch depends on another patch series:
> https://lists.nongnu.org/archive/html/qemu-riscv/2025-03/msg00003.html


PCI things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


given the dependency, pls merge through risc-v tree.

> Jason Chien (4):
>   include/hw/pci: Introduce a callback to set the downstream mr of PCI
>     hosts
>   hw/pci: Introduce an API to set PCI host downstream mr for IOMMU
>     integration
>   hw/pci-host/designware: Implement PCIIOMMUOps.set_downstream_mr()
>   hw/riscv/riscv-iommu: Connect the IOMMU with PCI hosts that have ATUs
> 
>  hw/pci-host/designware.c         | 18 +++++++++++++++---
>  hw/pci/pci.c                     |  8 ++++++++
>  hw/riscv/riscv-iommu.c           | 15 ++++++++++-----
>  include/hw/pci-host/designware.h |  2 ++
>  include/hw/pci/pci.h             | 21 +++++++++++++++++++++
>  5 files changed, 56 insertions(+), 8 deletions(-)
> 
> -- 
> 2.43.2


