Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C940BC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGYR-0001zO-HH; Tue, 21 Jan 2025 10:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taGYN-0001zB-Vk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:52:35 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taGYL-0001VB-Bk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:52:35 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ycs9h2b2sz6M4fG;
 Tue, 21 Jan 2025 23:50:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A869B140B30;
 Tue, 21 Jan 2025 23:52:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 16:52:25 +0100
Date: Tue, 21 Jan 2025 15:52:24 +0000
To: Zhi Wang <zhiw@nvidia.com>
CC: <qemu-devel@nongnu.org>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <ira.weiny@intel.com>, <fan.ni@samsung.com>,
 <alex.williamson@redhat.com>, <alucerop@amd.com>, <clg@redhat.com>,
 <acurrid@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH 1/3] hw/cxl: factor out cxl_host_addr_to_dpa()
Message-ID: <20250121155224.00005c8b@huawei.com>
In-Reply-To: <20241212130422.69380-2-zhiw@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <20241212130422.69380-2-zhiw@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.086, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Zhi,

> index 945ee6ffd0..abb2e874b2 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -268,6 +268,9 @@ uint8_t cxl_interleave_ways_enc(int iw, Error **errp);
>  int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp);
>  uint8_t cxl_interleave_granularity_enc(uint64_t gran, Error **errp);
>  
> +bool cxl_host_addr_to_dpa(CXLComponentState *cxl_cstate, hwaddr host_addr,
> +                          uint64_t *dpa);
> +
Other than this being a really odd place to put it (in the middle of interleave
granularity functions.  This change seems like a logical enough change without
the reuse.

Also, I'm carrying a patch for 3/6/12 way support so I've merged this on top of that
in general interest of reducing patches flying around when then are reasonable
on their own.

Jonathan


>  hwaddr cxl_decode_ig(int ig);
>  
>  CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);


