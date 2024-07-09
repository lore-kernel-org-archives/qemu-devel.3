Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B40C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR7bV-0006EP-6N; Tue, 09 Jul 2024 05:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sR7bP-0006BO-EJ; Tue, 09 Jul 2024 05:57:39 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sR7bM-0008B2-0N; Tue, 09 Jul 2024 05:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720519056; x=1752055056;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ql3XWi50DdULpswcLK+rmYBSYuNy0QrKcY67jvFg2+g=;
 b=ap57HpPEYs3Z4opA5a6hgzLAy/UdCbZUlr/katMMuDULZK+kDRjeMAi7
 W748wsR8MOxVa9LSq5I76e1eJiqzXWmb39hMe8nDnPStOW3Qe8n2MQLoS
 3ya2RWkCHlV4nv8igSfiQEA9fJz/GgboMBOcZolryrBvU0a/oigfdukBR
 TSQEF7dfBcV/cr5zTe3VrxuY4QNrgJG8X0r3k4QXj08ho1ZUz97rBADil
 aIwcfsH1RlK7DAwTLu8v4H7yoH3E71IPSga6/k6MxHPAExLrPoz/bs71l
 9m6RNKoj+pDYnHCrmza70kZTny8AWzKlOXjXl73gXT5Cyz/8Wdlx7fqBA g==;
X-CSE-ConnectionGUID: dVM6ljAhTWObC80TGxcm5Q==
X-CSE-MsgGUID: FwULKwtaS+SQiYef0GL4Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21630499"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="21630499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 02:57:30 -0700
X-CSE-ConnectionGUID: ijrOueipQbWj08U6YPj+LA==
X-CSE-MsgGUID: GQMV+uZ1SlynX0EEJuSMAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="85349963"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 09 Jul 2024 02:57:25 -0700
Date: Tue, 9 Jul 2024 18:13:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
Message-ID: <Zo0NMDmYKRVWe9Ht@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704031603.1744546-3-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> diff --git a/hw/core/smp-cache.c b/hw/core/smp-cache.c
> new file mode 100644
> index 000000000000..c0157ce51c8f
> --- /dev/null
> +++ b/hw/core/smp-cache.c
> @@ -0,0 +1,103 @@
> +/*
> + * Cache Object for SMP machine
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Author: Zhao Liu <zhao1.liu@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/core/smp-cache.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-machine-common.h"
> +#include "qom/object_interfaces.h"
> +
> +static void
> +smp_cache_get_cache_prop(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    SMPCache *cache = SMP_CACHE(obj);
> +    SMPCachePropertyList *head = NULL;
> +    SMPCachePropertyList **tail = &head;
> +
> +    for (int i = 0; i < SMP_CACHE__MAX; i++) {
> +        SMPCacheProperty *node = g_new(SMPCacheProperty, 1);
> +
> +        node->name = cache->props[i].name;
> +        node->topo = cache->props[i].topo;
> +        QAPI_LIST_APPEND(tail, node);
> +    }
> +
> +    if (!visit_type_SMPCachePropertyList(v, name, &head, errp)) {
> +        return;

Oops, here I shouldn't return. Whether it succeeds or not, I should
continue with the following free().

> +    }
> +    qapi_free_SMPCachePropertyList(head);
> +}

