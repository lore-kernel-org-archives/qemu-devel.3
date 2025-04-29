Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFDCC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ofY-0004rN-UC; Tue, 29 Apr 2025 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9ofW-0004qt-31
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9ofU-0001O1-AM
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745947370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xC9WujVyKXi4RcXNvA45rCyg+WHI06NVm7w+fH3lihk=;
 b=G/Xj1jAWKT4lmd67HhBdNNMSiz3Kc0WNpJ/Zxxzknydgb9D3op2thodDtbBFuvonmfAEeZ
 XqFTtTJp7W+wfUR0SGGtF/y1zGM2cQS0/Km8e3MiRZ1PqW3xcf63+XtSjwIuIsN9PZXOUv
 cEZjkmAjFxKwAYCtw4uzrKe0HtrNmr0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-yUPAK8PcMIqw0SZ9_s9Qfg-1; Tue, 29 Apr 2025 13:22:49 -0400
X-MC-Unique: yUPAK8PcMIqw0SZ9_s9Qfg-1
X-Mimecast-MFC-AGG-ID: yUPAK8PcMIqw0SZ9_s9Qfg_1745947368
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4767348e239so121295541cf.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947368; x=1746552168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xC9WujVyKXi4RcXNvA45rCyg+WHI06NVm7w+fH3lihk=;
 b=EHY/Of2Uy1VUNnyLjytO+tBs45jm7iBAOXKweHt8OoBCQaJ3CrM79KYipmACsMGi7B
 u19+ZhsiV6h0rXpX1rNB3T62jzkiwpNt/Q06QpsBOOb5f2gxHxgvz0CM58tjL62miOQ1
 hJroq+LpfvinirvD/g5xZE/dBthUIontAYE02Mx9KAD3Elazt04TKp1ijODie9pFVfnu
 E4cWp/NXjjQFDkfXX2zGz4O/9sNLFEwahS0uXXwReKuVs0EXubOj1mW+TDjQU25Ive7p
 dNV8mVd+EaJ6Cau1B7dVh861lIjv3N02JZ67Fin3gat7htfecuGmotORyES4amR+0Tj7
 ppig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyXkcP8nYIOyqAtmUYezCqBcOgDVBiYzJvPay1LK8voF0Au36t+f4wmhZg+EAd+zokFE6Zaq6VIx2t@nongnu.org
X-Gm-Message-State: AOJu0YzsOgSWapNlZUMokbiZGQIDdKWG0Grxi+/Ytg+o7UEHWVDsoCaP
 VcScOcii46zLySoiCG24+GTzkYgKDRqdLMbCTZs+eUPAtC0BscJzXP0vUoDlvBbWBSfaKd0bdjS
 mKz2N2VlMbxaaK3L8X0Tj5UOZHjS2rKUMzvo6aa/58q8SG8t+gQRn
X-Gm-Gg: ASbGncvrU+noAtSe5Fz4anF6WzRp3UZLo5EjeGilhdDUnDkIbzPrq/cOXDQj7QWYRJ8
 HkqTv1/F7xI++E0hIq6yrWbXEf043Mo6Q3PTWk/U2oxmNlj9BhW3khrnl8B36e5r0EeyQXXi4tB
 /wCOVBjazSUkLtCINPgGsHwVIzTnJesVT6zKVhmMJ0BZs9fUmawqIWUg9VjxB3vSlBITYF7qjDB
 RO0MBjYy0uuxOpRSZu0dH5mi37ZRiU6ZZdQoOjz9eGtiyjIeSB62qd7BhzUhGwkie0gyZ2D1f6y
 xHU=
X-Received: by 2002:ac8:6f13:0:b0:478:f736:f545 with SMTP id
 d75a77b69052e-48874946e93mr53349231cf.51.1745947368508; 
 Tue, 29 Apr 2025 10:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY/GnQdbrrqwbffV9zOEWX0Cqlm6CVs9IIRCy8F7Jpj2I/HECCVZ1PrK0wdgJvBcx2M2Ct4A==
X-Received: by 2002:ac8:6f13:0:b0:478:f736:f545 with SMTP id
 d75a77b69052e-48874946e93mr53348971cf.51.1745947368232; 
 Tue, 29 Apr 2025 10:22:48 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47e9eaf4cfbsm82532071cf.13.2025.04.29.10.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:22:47 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:22:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
 Yu Zhang <yu.zhang@ionos.com>, qemu-devel@nongnu.org,
 michael@flatgalaxy.com, Michael Galaxy <mrgalaxy@nvidia.com>
Subject: Re: [PATCHv2] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Message-ID: <aBEK5bVzuJn3QR9U@x1.local>
References: <20250402051306.6509-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402051306.6509-1-jinpu.wang@ionos.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Wed, Apr 02, 2025 at 07:13:06AM +0200, Jack Wang wrote:
> I hit following error which testing migration in pure RoCE env:
> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
> systems and your management software has specified '[::]', but IPv6 over RoCE /
> iWARP is not supported in Linux.#012'."
> 
> In our setup, we use rdma bind on ipv6 on target host, while connect from source
> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> fine.
> 
> Checking the git history, the function was added since introducing of
> rdma migration, which is more than 10 years ago. linux-rdma has
> improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
> back in 2016 seems related to the issue, eg:
> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")
> 
> other fixes back in 2018, eg:
> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
> 3c7f67d1880d IB/cma: Fix default RoCE type setting
> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
> 
> So remove the outdated function and it's usage.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Cc: Fabiano Rosas <farosas@suse.de
> Cc: qemu-devel@nongnu.org
> Cc: linux-rdma@vger.kernel.org
> Cc: michael@flatgalaxy.com
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Tested-by: Li zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
> ---
> v2: cleanup unused err, update comment (Fabiano)
> v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by

Queued with some cosmetic changes:

diff --git a/migration/rdma.c b/migration/rdma.c
index 28def620d9..2d839fce6c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2502,7 +2502,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         goto err_dest_init_bind_addr;
     }
 
-    /* Try all addresses*/
+    /* Try all addresses */
     for (e = res; e != NULL; e = e->ai_next) {
 
         inet_ntop(e->ai_family,
@@ -2517,7 +2517,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     rdma_freeaddrinfo(res);
     if (!e) {
-            error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
+        error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
         goto err_dest_init_bind_addr;
     }
 
Thanks,

-- 
Peter Xu


