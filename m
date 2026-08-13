Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17F9C5DF66
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wufQk-00068f-RS; Thu, 13 Aug 2026 20:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wufQe-00068H-40
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:05:44 -0400
Received: from mail-northcentralusazon11010048.outbound.protection.outlook.com
 ([52.101.193.48] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wufQa-0002eM-TB
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:05:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUiSkZ8cxAViYgFhagZkS482Qo6b1jzPB4RuEFeKQEH35BO1RI//T3JwbmEQHVGL6AgnMndV253lLoOV6vb6tQTT3TzVcov8/9YUbDmucc/Ek3LEWhsGD6JHWByMiTeGhwh8Bt+fRrF3dWq2/JQ3ca6Zhh0ncOYbsBiwn5qpXMWYbrmNaYZ6lTIuZ+Sr5NVlZgKm5kQYOzmh8p5PLKa7CeK30HEZbL6KqNHJvtxsZLtRNt+MoNzCq9/w7nOjV9qRS7S5YaBBhz0DmeCFWLmwCNXmEEGdMDNyGrxiuXKCRVOZXAWPprCiAGNemv8MJ//qtYC/ofUtoBKOix05LRKKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1cE9vk1/ojbD6TvyxvNDNe90RLErKmRGkjAvspEJHc=;
 b=vdrfFBiaZZK6Syvg+chalwk8Lh+mcg0t1smZFfAva/1/8fIO2JPpYlgu0wof9Ng5YqluXxKfDJNwYqoqvi75XcsyBOS2ryPywmTL4Yd7pBV468UtGVS00lXlNXQ8kmuQ/jEfypEcG3UEXll9dpqzD6ctzCw4o3mSJo4UG6fGSlPikhwb6h5a5XA4HZJg6phF+gHUNtwkfb8VsRH6+Ld4ollsk8E6lCHVdVgNcX0fZh5MK5VFXxuN2m6f6DSzqBrgdbOHOE5vtYVMd1abj6JEP3c9R68QYyaysE1d2vNHL04rcIjHh6kPxESG+54SXjeH8degf5ZmSfR0qztAVICutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1cE9vk1/ojbD6TvyxvNDNe90RLErKmRGkjAvspEJHc=;
 b=WL+SLhf7nHfP6X7I+5eHjpbHQ/fgIKwANKdDUps404ldxb4PyxCaJixGtG4lz1pqo9Wwnx1TdWsyt5/GFWrr5o9x1wnbIqZFVShdDk6IVsvq/WS2tC0P1lu1sqjJFOZfDeX9axvNkkBfM20846gSv3FUdZPAPzGREKE8KamUlFc=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by SA1PR12MB6679.namprd12.prod.outlook.com (2603:10b6:806:252::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 00:00:24 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::69) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 00:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 00:00:23 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 19:00:22 -0500
Date: Thu, 13 Aug 2026 17:10:45 -0500
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
CC: Peter Xu <peterx@redhat.com>, <qemu-devel@nongnu.org>,
 <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <farosas@suse.de>, <aik@amd.com>,
 <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <tjzytooy2a52jaw3rjhaph5nunc2locecvjh6dp567hdb2qrjs@zmtebtnfpv6b>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an29FY93x45qnJuR@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SA1PR12MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 67452b00-54ad-4495-5075-08def99709ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|22082099003|18002099003|3023799007|56012099006|13003099007|6133799003|4143699003|5023799004|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: h6YrhqjuEydtBFNaAdNCKuSQDZt/1GbxB5t9mq4PzAHMXTEu5a1CbwdpqdFyFEumC0Rs9V0vwROBcmIOd8XPQb7wwCTsnfKBQ8jaGoqC3DVK02Zrt+rc9UexFYSn66mG7rBeCQ4lboB0QcJlHjOoypdLqijQAkh+Pi+80KtY8jDxw3EM+NT+AuqWeCOq3wzXquW3Nlp3husbfNBNxid3LBoF/frHxBFMDb+lBS3aJigREv4zpHGF/sd16RdyMCsNcv3RclYCNW3qn7e2mslXHG86UwTXCnydcPxY+yudA8n/OQLWT71j+hbpkIulDC4sREG8ctQwztLCKEv+to7v7E/nW9lcdsC0Xq9GteQvwtjyzKf42o6w/FrrhzPf0vgYmtHta4Yd04Pj9eVGapxpYy/5L+rTI0y0MZEd+Bq2Ck1YPv5uHm0//gTRicjgSVd1cqcW8mlkXVVUlLPMISnapu9ySXVlOwdctgfJZNTZ2KJVjXM2UeE0h5SW34ykuHxwxVeZ15BQ5ZSoh8UuqRuAmtQUFfIwaMik8SmJWGE3lG5WL+ec17cOO8lPee09tSZCDeW77GVZyfpA9+vpt/NlIGa3Trdky9T5rjz6v/5lEzgS3XX+aINUxzDCuT7Z7o2nfT15FsGbrL8nKfly0GZPyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(13003099007)(6133799003)(4143699003)(5023799004)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2DwsrIgPZ7kq2pnx5RPoxW1wBPT5uyMnSYRC4OE3722BNPmc0IBsGDL2Yu5F11wDge6HYfc4SOgsbJzdfgu3GgOEQFoFjYjG1geDxP213OkDcztl2SmYVRzxP9dnRt3zELB0ylLjx87pSLq5D4POzrWFBN3s/rlviJ+czQ/d8/0WueiftXiuHBYW/2+Qa1clzX9FMPV8bYru55/fIabEEuc+Uh2WoWOEVJ+JVJUReaDNk1WMFbgsq4P7xsPcZ5I/eqQcmL9CZ+e+kNxJF9NF0NQlItZ/jmCFgntQzOaHd/d+DZcY3aX9VqrVeusHxWj4ouKHo1U0aW4z/+2fWBbJnbqA5Ifzh8VYaQzNAalX5r7vgz1kuKj4lriKR/35wWs+j1hpKMZptQ0ovklfDjCeEsxBjgHX7fkn/cfQxgrVyzANFtKlIbE3vkJB5jm+bOQQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 00:00:23.1728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67452b00-54ad-4495-5075-08def99709ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6679
Received-SPF: permerror client-ip=52.101.193.48;
 envelope-from=Michael.Roth@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 13, 2026 at 01:48:21PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 13, 2026 at 08:28:24AM -0400, Peter Xu wrote:
> > On Thu, Aug 13, 2026 at 09:24:22AM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Aug 12, 2026 at 03:16:46PM -0500, Michael Roth wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > 
> > > > Host backends supports guest-memfd now by detecting whether it's a
> > > > confidential VM.  There's no way to choose it yet from the memory level to
> > > > use it fully shared.  If we use guest-memfd, it so far always implies we
> > > > need two layers of memory backends, while the guest-memfd only provides the
> > > > private set of pages.
> > > > 
> > > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > > only source of memory to back the object (aka, fully shared).
> > > > 
> > > > To use the fully shared guest-memfd, one can add a memfd object with:
> > > > 
> > > >   -object memory-backend-memfd,guest-memfd=on,share=on
> > > > 
> > > > Note that share=on is required with fully shared guest_memfd.
> > > > 
> > > > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > > > guest-memfd may return negative but not -1.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > ---
> > > >  backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
> > > >  qapi/qom.json            |  6 ++++-
> > > >  2 files changed, 56 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> > > > index ea93f034e4..fbe65b00be 100644
> > > > --- a/backends/hostmem-memfd.c
> > > > +++ b/backends/hostmem-memfd.c
> > > > @@ -18,6 +18,8 @@
> > > >  #include "qapi/error.h"
> > > >  #include "qom/object.h"
> > > >  #include "migration/cpr.h"
> > > > +#include "system/kvm.h"
> > > > +#include <linux/kvm.h>
> > > >  
> > > >  OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> > > >  
> > > > @@ -28,6 +30,13 @@ struct HostMemoryBackendMemfd {
> > > >      bool hugetlb;
> > > >      uint64_t hugetlbsize;
> > > >      bool seal;
> > > > +    /*
> > > > +     * NOTE: this differs from HostMemoryBackend's guest_memfd_private,
> > > > +     * which represents an internally private guest-memfd that only backs
> > > > +     * private pages.  Instead, this flag marks the memory backend will
> > > > +     * 100% use the guest-memfd pages in-place.
> > > > +     */
> > > > +    bool guest_memfd;
> > > >  };
> > > >  
> > > >  static bool
> > > > @@ -47,11 +56,29 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> > > >          goto have_fd;
> > > >      }
> > > >  
> > > > -    fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > > -                           m->hugetlb, m->hugetlbsize, m->seal ?
> > > > -                           F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > > -                           errp);
> > > > -    if (fd == -1) {
> > > > +    if (m->guest_memfd) {
> > > > +        if (!backend->share) {
> > > > +            error_setg(errp, "guest-memfd=on must be used with share=on");
> > > > +            return false;
> > > > +        } else if (m->seal) {
> > > > +            error_setg(errp, "guest-memfd=on must be used with seal=off");
> > > > +            return false;
> > > > +        } else if (m->hugetlb) {
> > > > +            error_setg(errp, "guest-memfd=on must be used with hugetlb=off");
> > > 
> > > Reporting an error without returning false like the other cases.
> > > 
> > > > +        }
> > > > +
> > > > +        fd = kvm_create_guest_memfd(backend->size,
> > > > +                                    GUEST_MEMFD_FLAG_MMAP |
> > > > +                                    GUEST_MEMFD_FLAG_INIT_SHARED,
> > > > +                                    errp);
> > > > +    } else {
> > > > +        fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
> > > > +                               m->hugetlb, m->hugetlbsize, m->seal ?
> > > > +                               F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
> > > > +                               errp);
> > > > +    }
> > > > +
> > > > +    if (fd < 0) {
> > > >          return false;
> > > >      }
> > > >      cpr_save_fd(name, 0, fd);
> > > > @@ -65,6 +92,18 @@ have_fd:
> > > >                                            backend->size, ram_flags, fd, 0, errp);
> > > >  }
> > > >  
> > > > +static bool
> > > > +memfd_backend_get_guest_memfd(Object *o, Error **errp)
> > > > +{
> > > > +    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
> > > > +}
> > > > +
> > > > +static void
> > > > +memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
> > > > +{
> > > > +    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
> > > > +}
> > > > +
> > > >  static bool
> > > >  memfd_backend_get_hugetlb(Object *o, Error **errp)
> > > >  {
> > > > @@ -152,6 +191,13 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
> > > >          object_class_property_set_description(oc, "hugetlbsize",
> > > >                                                "Huge pages size (ex: 2M, 1G)");
> > > >      }
> > > > +
> > > > +    object_class_property_add_bool(oc, "guest-memfd",
> > > > +                                   memfd_backend_get_guest_memfd,
> > > > +                                   memfd_backend_set_guest_memfd);
> > > > +    object_class_property_set_description(oc, "guest-memfd",
> > > > +                                          "Use guest memfd");
> > > > +
> > > >      object_class_property_add_bool(oc, "seal",
> > > >                                     memfd_backend_get_seal,
> > > >                                     memfd_backend_set_seal);
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index c55776af7d..ee981fc44c 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -771,13 +771,17 @@
> > > >  # @seal: if true, create a sealed-file, which will block further
> > > >  #     resizing of the memory (default: true)
> > > >  #
> > > > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > > > +#     (default: false, since: 11.2)
> > > > +#
> > > >  # Since: 2.12
> > > >  ##
> > > >  { 'struct': 'MemoryBackendMemfdProperties',
> > > >    'base': 'MemoryBackendProperties',
> > > >    'data': { '*hugetlb': 'bool',
> > > >              '*hugetlbsize': 'size',
> > > > -            '*seal': 'bool' },
> > > > +            '*seal': 'bool',
> > > > +            '*guest-memfd': 'bool' },
> > > >    'if': 'CONFIG_LINUX' }
> > > 
> > > We're reusing the 'memory-backend-memfd' class, and then at runtime
> > > refusing allow the user to control any of properties in
> > > MemoryBackendProperties.
> > 
> > gmemfd should be able to use all ultimately.
> > 
> > For seal, IMHO it's already implied, kind of forced seal=on but it doesn't
> > matter, gmemfd was introduced with sealing, at least what QEMU implies with
> > "F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL".  So IMHO we could ignore what
> > user selected and assume it's ON.

The naming threw me off, but looking at the actual schema description for
'seal', it basically implies 'fixed-size=on', which guest_memfd does
enforce. So, aside from the question of whether to reuse the memfd backend,
I do think it's more correct to imply seal=on for guest_memfd.

> 
> Then we should not have a 'seal' property defined for guest memfd
> at all. Defining a property and then ignoring it, or only ever
> allowing 1 value to be set is a design mistake. The property should
> not exist if it can't ever be changed by the user/app.

We have a couple examples of what seems like something similar with
memory-backend-file,rom=on,readonly=off and
memory-backend-*,prealloc=on,reserve=off. Granted, those seem a little
more obvious to recognize as mutually-exclusive, but as far as the
discussion around libvirt/mgmt/introspection: are there mechanisms in
place already to handle cases like that? Or are these special-cases that
would be problematic to try to handle similarly?

Regarding hugepage options, there will undoubtedly be kernels that support
guest_memfd but not hugetlb, so even if we introduce
memory-backend-guest-memfd now so that we can add options when/where it
makes sense, libvirt/mgmt. would still need to eventually handle a
'hugetlb' option existing, but not necessarilly implying that the guest can
actually use them. It seems like the issue exists in either case.

FWIW, I do anticipate that we will need something like
memory-backend-guest-memfd for some of the use-cases coming down the
pipeline, but for some stuff like CXL/HBM memory support where folks are
talking about stuff like custom guest_memfd allocators or special-purpose
NUMA nodes I'm not reasonably confident that memory-backend-guest-memfd won't
itself end up being too generic of a construct and be immediately relegated
to only handling the exact same set of options as memory-backend-memfd (give
or take a 'seal').

Peter's suggested approach allows us to assume less about how things will
eventually look by reusing existing options/command-lines and handling things
underneath the covers for the more basic use-cases in the meantime. Once we
hit cases that clearly have no business in memory-backend-memfd, we won't
really have lost anything as far as our options to introduce
memory-backend-guest-memfd at that point or maybe some subclass or something
else entirely.

So that's sort of my angle here, but despite the walls of text I don't have a
strong opinion one way or the other. But I do want to make sure we don't make
things harder on libvirt/mgmt than necessary.

> 
> > For hugetlb, we will support hugetlb (and allow specify hugetlb size) for
> > gmem in the future I believe.  It's only that this is done one step at a
> > time so we haven't supported it yet, while the kernel support is still in
> > progress.
> 
> The problem with this idea is that it makes it impossible for a mgmt
> app to know if hugetlb is supported or not, as QEMU will always
> report it supported against memory-backend-memfd.
> 
> Having a memory-backend-guest-memfd ensures the public interface
> matches what is actually implemented/permitted for guest memfd.
> 
> > > "memory-backend-memfd,guest-memfd=on|off" is switching between two
> > > separate implementations of the class.
> > > 
> > > This whole thing is just shouting "use a different class".
> > > 
> > > There is no meaningful sharing of code here, and the sharing of the
> > > public interface is offering apps no value as the impl prevents them
> > > from choosing the value of the properties - they have to be set of
> > > certain values which are not introspectable.
> > > 
> > > Please introduce a "memory-backend-guest-memfd" backend instead.
> > 
> > This is indeed what Michael used to suggest, and we were discussing in
> > previous version on which is better,
> > 
> > https://lore.kernel.org/r/rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk
> > 
> > The hope is this is also easier for either libvirt or most users, but
> > please correct me if it's not the case, especially for libvirt.  The plan
> > is when CoCo flags are provided, all things will automatically switch to a
> > CoCo-friendly implementation within QEMU.
> > 
> > It also means here the guest-memfd= parameter shouldn't be needed in real
> > CoCo contexts because they'll simply be implied (no cmdline change needed
> > for the same "-object memory-backend-memfd" one used to use without CoCo).
> > It's only needed for only special use of guest-memfd, in this case
> > init-shared is the special case where CoCo doesn't use.
> 
> Reading all this, IMHO reusing memory-backend-memfd for the current
> Coco support was a design mistake, it should have have a
> memory-backend-guest-memfd object from the start.

I think your point still stands, but the current CoCo support doesn't rely
on memory-backend-memfd, the private guest_memfd instance is handled by
QEMU completely separately as a function of whether or not we are running
a CoCo VM. The backends are only for shared memory, which aren't relevant
to guest_memfd (without in-place conversion support), so users can select
whatever they'd like.

However, backends like memory-backend-file tend to get used for special
cases like persisting memory, where there is a high chance of surprises
for users trying to make use of these sorts of things for a CoCo VM.
That's why memory-backend-memfd is the configuration we normally suggest
for CoCo VMs, but it's not required, since nothing stops users from
persisting shared memory ranges if that's actually their intent.

The need to enforce the backend more explicitly becomes much more apparent
once in-place conversion however, where even shared memory goes through
guest-memfd and so the backend necessarily needs to be
guest_memfd-aware. The in-place conversion series tracks this via a
RAMBlock flag that can be set by whatever backends we decide would be
appropriate for managing guest_memfd instances based on these
discussions.

So, at least for users following the recommended configuration:

  qemu -object sev-snp-guest,...
       -object memory-backend-memfd,...

they can then switch on in-place conversion via, e.g.:

  qemu -object sev-snp-guest,...,convert-in-place=on
       -object memory-backend-memfd,...

and we can flip guest_memfd=on automatically underneath the covers
so that both shared/private memory go through guest_memfd as
convert-in-place would necessarily imply.

It's not necessary that this happen automatically, but from a user
perspective it seems clean, and aligns with the above goals of trying
to defer the introduction of new backends/options until we have a
better idea of what the relevant uAPI bits are going to look like.

Thanks,

Mike

> 
> Given that we need to be able to control memfd vs guest-memfd for
> the non-Coco case, it is still worth introducing the new object
> class today.
> 
> Even if the two classes shared all their properties (which they
> don't given the comment about 'seal' being always on), then a
> "foo=on|off" that toggles two separate impls is still creating
> a pair of sub-classes by the backdoor. 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 

