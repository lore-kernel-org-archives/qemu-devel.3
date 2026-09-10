Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE6BC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pcZ-0006Gu-3x; Thu, 10 Sep 2026 21:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x4nyq-00020A-Ud
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:15:08 -0400
Received: from mail-westus3azon11010056.outbound.protection.outlook.com
 ([52.101.201.56] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x4nyg-0007pJ-Kt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoEurEHR+nNSs13sFnBtAFqo+3gLunuzMRrfIHDu586+A751dnKxSpu7j1mZSVxS3GieAddtafXO8IrUWSunO5cLLsCMqxeLH8M2iudbulx3eKek8VNMc9nZ5VP9WHAQOG8aSxM9XEs5V13SY4g0LCISRBfr9mVFNRLsEUFAW6PUATXAeSUaXnjCnQWerpuPdN4HWMDQcD9RUZ1tgl30BSFkzO0zTgPJoCqZPNlvZmNF403lIKm7TdIf9fKIvOwvTud/GiyX6mlbJnNcLCN0V9YL4y12OSyZ+G5AmRUKEYa3nSlOGaEikKAsIU41l/EBc21GBMbtO6+wETEtXUYVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7rbPZVHm0BCCH5kbIqXx7ETi5+3PFSCD0vYMCc72Hg=;
 b=XhYI/9EHuYcgLAz+vpIeTBEajSyC4Lr214saa8OpQU/YYI5xs9rWhMP0X+OUGoFREOx/rf3WqF4Mb67ZwXAM/XAH/tMVzga07qhwc0Qxxq+9fHC4+I7R0xxe3YrXDjykgtJF+w6aHsDju0cM9Zw2eo8hAjPBZf+wPn1kV8QdeIB0veUJjLg2zKlfPkpU+rXw+JmniVvwuTJox4Mbbs8qE3hYZ18See3I5fPEkzTqNzUDPA95ahpXgHm1+vsCmAmlLG96hu3z8YxytdPllRwGjOPlejs5GDhntJqsEn15lRBUgHSAQ+ItkLEWsbZe3iHGevTjKTGUwFd6Qwk4qCb+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7rbPZVHm0BCCH5kbIqXx7ETi5+3PFSCD0vYMCc72Hg=;
 b=uQn8h7RPAuT+t3Y0FAQbyV1tjH0fHw0KpeK1iSxUVLxmNkt8tQXXGgOu1C+GDb6W1hGjKa38wSfhWAdH/iTeId851b4QkpiO86G2hRo6caHEdYNeyfWOXYSve+Ze8NhOeEU9foiMFDLcJ9SC0SYcOcBcvO60i3PnWEoX9hNtYCs=
Received: from SCYP152CA0106.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:144::19)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:09:25 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10d6:300:144:cafe::8f) by SCYP152CA0106.outlook.office365.com
 (2603:10d6:300:144::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:09:22 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 18:09:22 -0500
Date: Thu, 10 Sep 2026 17:58:56 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <wli5vbctw6wxsqlxs6e5ojarvxq3xj3xv6ottjfenios2ndxld@etwnuqkbvmzf>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
 <87ecf3rgb3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87ecf3rgb3.fsf@pond.sub.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b5aaf5e-cf05-43b0-b638-08df0f908d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|6133799003|3023799007|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info: 3rwZcnrl3o8TdDw53ikaqT7kJ8bTldLWhmc565upgHG+VUZC5bjlhiRksSm2IQdzLpxbx/i4YBTtSvoRCO95qPnKSc5mLBt0xlTuWcIkxuxpya3oQjy8oAv5mV8lbEjGi1+iNtwtAjbmWyJjUB09RkLR3UFcZbbVNtG+xDUctR4F+Y7D7lpAh5dJfbLHimurogjB9qN9FHV31/QM5ibaeuEyAR59IyTpWgH/nw0GnJ210Xtw4LSmwWeLVv9+0RanqK3jcQHtSk7OePoz4jp9fJMf2RP39GeFUiLoMWdAj1GUGkq8HwU6LCzCxKBwSmGjD90CXOkZLLRRFyPb89QO9X4eBhsO6YiuPlRiBlGX2bLq/7cf2lXgyvDzuDob65ah22B5ZtFeGBPEourWrydU46pp3A5sfmvUkioyg51JHadUU1ANjssbxh3x8PUax2c6lVFopYLRKXqFFpm0xx3yDtHIGuXbVysmikp0g2Rng8IaurVtoMEQamgpRJelx1QwUiABakl00qLrHFtrCIBRDPDm69+PpEiJNoAH96aLPWxVp4m750ZOgsbRmI4khhjpyqtkSS4DUW2vZYatbVcHNvfei5eUSOHcmDQLLvAcWeMCt1EdwdK8NLTHKzFjWo/eaQYQ5wNOr9jzt+iTUC1lysotdg6OFA3D4KZwTiYLAd2ZIkubszawfO69V+EQmnOry36xJL3KwkJiYyCgYHPPJKtyZ8cwDue8iJnKsOLODF4IEyro/DaRYPcCImDNJdbyh8W3+9V7+uuMwRp45tMy6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(6133799003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aMQzCdS9nbiBp+GfLkwdeXCdYJO9UF+jSrnr9/LkQEpeUprarThLT/4vTmBmy1WlnkDdge/zI2hFw4Hnbpels1COJg+6LnBfBsuyZtzwM2D14Aeai6z6bF9NNIFgNt0QdZEFEXcVlIqLfmYTDu4XH8OpS6hVmS0v4ZZnY4nmeRAg8xuPmaoDm+zX1QjKebAlDSzz5IbSUjHbNMDynR+rWfdx2cJQf7kKihAxr7Q/SAA8SA9x5L01wBCja2OtxvaJSFGTBUJVy9ZpZCNjMRqgU9ZwNuAcLbtuNV7oDe6WJaqCrlckdLnKqB2rcW8zjeWuZFOkEkUnDR5oKiXgvLPYdDinj9zl/tuFoe9euvTB9++kHqn5GBqMHULqsDGLM8GVNYqNKyjDadQ2ryRSnmUXWc8l0ai15/UUEFwFTGVmpzMF8wfiOjUl0KMM9tQwu0Q6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:09:22.9496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5aaf5e-cf05-43b0-b638-08df0f908d50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
Received-SPF: permerror client-ip=52.101.201.56;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 08, 2026 at 04:03:28PM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > Host backends supports guest-memfd now by detecting whether it's a
> > confidential VM.  There's no way to choose it yet from the memory level to
> > use it fully shared.  If we use guest-memfd, it so far always implies we
> > need two layers of memory backends, while the guest-memfd only provides the
> > private set of pages.
> >
> > This patch introduces a way so that QEMU can consume guest memfd as the
> > only source of memory to back the object (aka, fully shared).
> >
> > To use the fully shared guest-memfd, one can add a memfd object with:
> >
> >   -object memory-backend-memfd,guest-memfd=on,share=on
> >
> > Note that share=on is required with fully shared guest_memfd.
> >
> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > guest-memfd may return negative but not -1.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 4a9b7f9088..909add4299 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -771,13 +771,17 @@
> >  # @seal: if true, create a sealed-file, which will block further
> >  #     resizing of the memory (default: true)
> >  #
> > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > +#     (default: false, since: 11.2)
> 
> What's guest-memfd and why would I want to use it?

I'm planning to squash the below documentation patch into this commit so
it can be referenced in the schema documentation for the @guest-memfd
option.

I think it explains the "what", but the "why" is a bit awkward at this
stage because we anticipate a lot of use-cases, and potentially it
becoming the general default for backing guest memory that doesn't
specifically need any functionality provided by the other
memory-backend-* implementations, but admittedly at this stage it would
be primarily for experimentation and getting infrastructure in place
because there are feature gaps like hugepage/THP support that would
prevent it from being a drop in replacement for memfd users.

The first 'real' use-case will come when either one of the features
mentioned in the documentation below (or something else) goes upstream,
or (more likely at this point) the in-place conversion patches land and
the @guest-memfd=on functionality becomes a requirement for Confidential
VMs that want to run in that mode (which does have immediately tangible
benefits like not needing to reallocate memory after every
shared<->private conversion and will likely deprecate the existing
out-of-place conversion mode currently used by SNP/TDX fairly quickly)).
I plan to add that use-case to the document as well, but it seems more
appropriate to do so in the context of the in-place conversion series
where I can talk about it in a non-theoretical context.

But hopefully the below documentation is enough to at least let people
know who should/shouldn't care about this option in the context of this
series though. If that seems acceptable I can it into this patch for v6
to compliment the schema documentation.

Thanks,

Mike


From: Michael Roth <michael.roth@amd.com>
Date: Thu, 10 Sep 2026 17:03:20 -0500
Subject: [PATCH] docs/system: Add documentation on support for guest_memfd

Document how guest_memfd is used in QEMU for both Confidential VMs as
well as normal VMs.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 docs/system/guest-memfd.rst | 49 +++++++++++++++++++++++++++++++++++++
 docs/system/index.rst       |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 docs/system/guest-memfd.rst

diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
new file mode 100644
index 0000000000..9fc4ffb015
--- /dev/null
+++ b/docs/system/guest-memfd.rst
@@ -0,0 +1,49 @@
+.. _guest-memfd:
+
+guest-memfd support
+===================
+
+Recent kernels allow for the creation of a guest-memfd file descriptor, which
+can be used to back VMs in a similar manner as a memfd file descriptor, but is
+intended specifically for this purpose and allows for closer coordination
+between KVM and the management of this memory to enable more
+advanced/VM-specific use-cases.
+
+Initially this additional functionality centered around providing a
+common/centralized place for managing kernel-side memory handing requirements
+for various Confidential Computing architectures, but it has since evolved to
+become a more general-purpose way to allocate/manage guest memory and
+potentially allow for things like providing additional memory isolation within
+the kernel[1] and support for persisting a VM's state across kexec to allow for
+live-updating the host kernel with minimal VM downtime[2].
+
+Usage
+-----
+
+For Confidential VMs, guest-memfd is currently utilized internally by QEMU to
+handle private guest memory, independently of whatever memory backend the user
+has configured for normal/non-private/shared guest memory. To avoid doubling
+memory, QEMU discards memory in response to the guest converting GPA ranges
+between shared/private. (e.g. if GPA X is converted from private to shared, the
+guest-memfd FD offset corresponding to GPA x will be truncated since the memory
+will be provided by the memory backend the user configured for shared memory,
+and vice-versa). This is handled automatically/internally for Confidential VMs
+that rely on this handling and is not directly exposed by QEMU command-line
+options.
+
+For non-Confidential VMs, guest-memfd can be used in a manner that is somewhat
+interchangeable with a normal memfd. Currently, this is handled by using the
+same memory-backend implementation as memfd, but with an additional
+'guest-memfd=on' option. E.g.::
+
+    qemu ... \
+      -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
+
+(Note that the share=on option is required for guest-memfd, since it does not
+support anonymous memory allocations or COW-like semantics.)
+
+References
+----------
+
+- `[1] directmap removal <https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/>`__
+- `[2] LUO <https://lore.kernel.org/kvm/20260728121138.1103610-1-tarunsahu@google.com/>`__
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 4509630fa4..060850a739 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -44,3 +44,4 @@ or Hypervisor.Framework.
    vm-templating
    sriov
    qemu-colo
+   guest-memfd

