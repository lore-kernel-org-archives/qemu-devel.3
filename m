Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A47CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUXCz-0007X0-NO; Tue, 02 Jun 2026 18:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXCv-0007Wh-F6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:03:33 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXCt-000718-Cx
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2g0Wh6beNWrILxTyE6DOpn5rAVLT+rpGeEG3kaahv2wzU1My76e8xvDFI9tUL3VSyAr+tgUUItqKjUYM/yeGvfjTzqG9q+wC1XiIdo0xd5pKVf835R98YJdCNiaHJJbgcOiA1ZmsqYoUqa0nvxkEJIjf1cgzlmxDhCdjblf3Vxz3/S+mjghbsssxJKaOKsKuM1Gk9IO521/1AgBJWryLJ8GZ8tj9yGEL31Q0+M/CQY3R29vO57vrkS2NHmWLQLpUsAyf8c/9RLpwfooD4+63nv4k5LH5bsk3Wo0VTOThG4W+dyBnW1LEB7+17a6kgAr1AWe5ikggxuYr8cmzQ/fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12vKlQ7hSH87Uby2IgGUAQIcVUHhgSEp47VITnZv4cw=;
 b=B2GANMMFJ4CVOZKYmh3WlmHY3BLajc48Dj37RPTA+6UvEHGzOdHi7yQpU7hA4gQ8ofQHZITiboPuWXUp1C66odfVemVrP7oRd0rlUusoaE34hfUDeLKLBms/JFcwtWSBWXa43sOPFzzKtcz+YYdhw26NwMPz0lDjXit4xhVAAOKC2/OcslwqKmQ6XMjFCD4SM7gIklSbnwTCSpgvDlTHbvvcPm7N/4gltpEW+qGvAlypTqxnePXa57G2vG62nmN2Z8T/shVyZF6l/t3/sJP7DslIDyVcLd9wQHpvAVZqxQfRIPNZ5kFnD0/x6eI/5LZJ4BJqBwT9rOUdJmtlGZ3YHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12vKlQ7hSH87Uby2IgGUAQIcVUHhgSEp47VITnZv4cw=;
 b=tmvcrBWjfsI0DQmk8YKgEpITca9MwS3pM11stAvdKbGT4wExwLF9eO3dlAtX88wg6o/iZXPowOMBiZdhPl8zLS/Es1rwtJ1Rf3jquN4B1/sfK7jBYNfYmvxS7Hi+aQmxDXHktiW3FRhy88nlgpuFi4Gemn8M6ydOnYMLqEPRp98=
Received: from PH7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::9)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 22:03:24 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::a4) by PH7P220CA0067.outlook.office365.com
 (2603:10b6:510:32c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 22:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 22:03:23 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 17:03:23 -0500
Date: Tue, 2 Jun 2026 16:40:54 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <mvats5prlo3jb4qpu7liekphunyura5hqs5rm7smgwkmqbzgro@tzo2t2md2jzh>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-9-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d70d4e-0c89-4735-2f67-08dec0f2c434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|11063799006|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: PWlnnmvaRlGSvcArSK2GD7zzAWPd44lNU6O4myCr6hI8b5zptYnP8D5uRM/uJHVocjpd5EXwveXQ/a83t5KXP1I8oFH+qmSh2uejlJdZ8J2+pv6Qlni5lkDhaH1AGLgBa23QTijihWxRKrJfWNrmblFcY39UupKQANfjS1o6Je8oVKQv257pf+DSgFxJ68waCOmUuMLdvSriAknzWUamkFY4fbcgzFagfLaTcXJ73p9WrWuYgkx+rFXKewDmtiu7UNV+Z5IXtUSjIu16JfdNtlzIDdmjFrvn0sYO1UEZ/qDzzkNV2Hecb25mrzx4eqEcMliYkUD8j/FiUQl9SWpZm5ce7qxVYMwvVcK+t9I0cy/7LtbvInRkIM6yYeO0TOqBZ2oFse2nUCeuKyv7HJ/0TqOiDgBC1bD6s59kstcXY39ULSGrFfR/LPH3CHUveJ0mXjmdQG9N7l1Z0jib8gfjM4qXl95d562BiM5AdMa0GSMF6ea0ZocvL0aYWQK7iJ2NvDF2BnyzGmBfZpIjgkRcf4lH3sJcZWHnxlrcKN3xsH1R6iGWR0oDZhhzWTBCuQdTFqwxKJ/ddgAbHS6hA+EMYR2V/oV11Iy5WwWnQ1jo/skatgfft7feL1JfynylWVoWge3jmtGTczlVTaV8rek5Sxrlwa6p90lPiHvF1EVhb9aG6nOgc23BGRW1+omv5AOpkYdl36qJ7PnB1tzep80GGS6lGij1YuiOFfGpf/k623Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(11063799006)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H8+2Yz5zz5ZBY1TgLNzpxMINUVguKDLpaDZWNKsaWH3/KXvh0QwZkkE8OeCsIhSSG36zFbke00cXlSiNl/UBb2ID4hUbCsqXD8y1nGzdHNpt9t8NP+A9nySlu8wnaH1+YcVy5Zw7qhRZ7na0U31MCY2KeZh9f5tz9ikBmVaF0/lgc6ft5ilkO7M+m4f28EKgYy5ehXatVhMmt6y/XnOU4C2zeJS+Hn45oi5db07ErRn3tYF17OF3mk+Aj2FJsT1v/6m+qpm/rilxCGGhyvoFCQvdAgf/MLzkWjcmNAMnDpjyb5VhUoWu3+v0pHd+xOH4XTdRWvf80N2f+XQP7olNOA/rOXH/j+Eosydj8pJ0qp+of50LuwF9VbmFMH7mVZiFEisemtiH5wQM6upgm7f4yxujZUE73kOo5CQDdFMO/1jVKv19AaFHaBEcJJDAK8Qr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 22:03:23.8676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d70d4e-0c89-4735-2f67-08dec0f2c434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Michael.Roth@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_LTC_HUSH=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Dec 15, 2025 at 03:51:59PM -0500, Peter Xu wrote:
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it fully shared.  If we use guest-memfd, it so far always implies we
> need two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
> 
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, fully shared).
> 
> To use the fully shared guest-memfd, one can add a memfd object with:
> 
>   -object memory-backend-memfd,guest-memfd=on,share=on
> 
> Note that share=on is required with fully shared guest_memfd.
> 
> PS: there's a trivial touch-up on fd<0 check, because the stub to create
> guest-memfd may return negative but not -1.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/qom.json            |  6 ++++-
>  backends/hostmem-memfd.c | 53 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 6f5c9de0f0..9ebf17bfc7 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -763,13 +763,17 @@
>  # @seal: if true, create a sealed-file, which will block further
>  #     resizing of the memory (default: true)
>  #
> +# @guest-memfd: if true, use guest-memfd to back the memory region.
> +#     (default: false, since: 11.0)
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'MemoryBackendMemfdProperties',
>    'base': 'MemoryBackendProperties',
>    'data': { '*hugetlb': 'bool',
>              '*hugetlbsize': 'size',
> -            '*seal': 'bool' },
> +            '*seal': 'bool',
> +            '*guest-memfd': 'bool' },
>    'if': 'CONFIG_LINUX' }
>  
>  ##
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index ea93f034e4..9299cd7675 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -18,6 +18,8 @@
>  #include "qapi/error.h"
>  #include "qom/object.h"
>  #include "migration/cpr.h"
> +#include "system/kvm.h"
> +#include <linux/kvm.h>
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
>  
> @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
>      bool hugetlb;
>      uint64_t hugetlbsize;
>      bool seal;
> +    /*
> +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> +     * which represents a internally private guest-memfd that only backs
> +     * private pages.  Instead, this flag marks the memory backend will
> +     * 100% use the guest-memfd pages in-place.

I think there was previous discussion in v1 or v2 about reserving the
"in-place" naming for "in-place conversion of memory" rather than
mmap-able guest_memfd backends.

> +     */
> +    bool guest_memfd;
>  };
>  
>  static bool
> @@ -47,11 +56,26 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          goto have_fd;
>      }
>  
> -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> -                           m->hugetlb, m->hugetlbsize, m->seal ?
> -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> -                           errp);
> -    if (fd == -1) {
> +    if (m->guest_memfd) {
> +        /* User choose to use fully shared guest-memfd to back the VM.. */
> +        if (!backend->share) {
> +            error_setg(errp, "Guest-memfd=on must be used with share=on");
> +            return false;
> +        }
> +
> +        /* TODO: add huge page support */

Until that's added, the related options should be disabled. m->seal as
well doesn't seem to be applicable for guest_memfd case.

-Mike

> +        fd = kvm_create_guest_memfd(backend->size,
> +                                    GUEST_MEMFD_FLAG_MMAP |
> +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> +                                    errp);
> +    } else {
> +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> +                               m->hugetlb, m->hugetlbsize, m->seal ?
> +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> +                               errp);
> +    }
> +
> +    if (fd < 0) {
>          return false;
>      }
>      cpr_save_fd(name, 0, fd);
> @@ -65,6 +89,18 @@ have_fd:
>                                            backend->size, ram_flags, fd, 0, errp);
>  }
>  
> +static bool
> +memfd_backend_get_guest_memfd(Object *o, Error **errp)
> +{
> +    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
> +}
> +
> +static void
> +memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
> +{
> +    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
> +}
> +
>  static bool
>  memfd_backend_get_hugetlb(Object *o, Error **errp)
>  {
> @@ -152,6 +188,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>          object_class_property_set_description(oc, "hugetlbsize",
>                                                "Huge pages size (ex: 2M, 1G)");
>      }
> +
> +    object_class_property_add_bool(oc, "guest-memfd",
> +                                   memfd_backend_get_guest_memfd,
> +                                   memfd_backend_set_guest_memfd);
> +    object_class_property_set_description(oc, "guest-memfd",
> +                                          "Use guest memfd");
> +
>      object_class_property_add_bool(oc, "seal",
>                                     memfd_backend_get_seal,
>                                     memfd_backend_set_seal);
> -- 
> 2.50.1
> 
> 

