Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C89CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhfx-0007jI-SB; Tue, 29 Sep 2026 19:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhfw-0007j5-KZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:56 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhfu-00086f-BY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdpkd06tOCeISTex+dfrLqEbH2ja1gsTUy7i7AnYVMAUebGV1qiVY8LoR2xZF6mAbJDLnvq+ctaXvSZR8M1ELuTFAGAtB9MluquIFqXx8C6adKp3Cvt/pviZNUoZwDYicBo7oElPyiYeumsalPbNRrDJI9IwmNFonc7ro9Xqqwt7LM/NtNfS9wWkhO0yKDKg30c64me79VGCK0D8uvliYLE04I8Wqa/FNU1tfnhQbIrJ6HorOua7T5dTx6schO46hCfHayt8G4RCHobQdqL7dr+klXEJMP+t4Ac0Tz2qfLt6T86NNg+OEjISSRwH2Zctid4x8jOhUvpbMgk566x1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAcFOEae/WRqhTf75IFX5CxC2B1LBRZZohSf4QTlgOA=;
 b=tl+Z9FBfP1BEorb/LWIZVzOFL5H1ATt2mLMl8erCMaDzC7TQQa9uahcfr/5F/lfPYkAa2pcAo7+51Nu99yJ6zzqvhZuix6OO/5hGuDRGQZHxA2FELMC5xq1CFEqwadDI1+PV5TLAvLUxzLlm56d/A2wSISM/g32XcVwlFE7Pt2WGxomzViJaH7G36ixGCzsgDhMRZYNrc1k7O+jb+d+gF9JKE8wA802bnV/ktV6xkUSQu2lm70lTBAYJld6xRe6KZyLRJQQkcEwU441LoLwoN5pWTLXs31SNFu7MkllqGZb+0vh7wZyPxEr/JtzI/4ZOQstkDeciOZdryQ5CxUvdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAcFOEae/WRqhTf75IFX5CxC2B1LBRZZohSf4QTlgOA=;
 b=nqHQHYYXx871NJXzFLPR3HYkMs75A51Wo3MXOczxJmqkpViyXRtB2CHJBKQyi0zNqnjGHiuhoFAfHRqXXfEXPRTSeLIPWlhxIN8KMryaNkMWSQBzltI4KsPrVme8fToQ9Yd16UNMykzMIuUXleiyRvng7ZMh4EBIfBtCyREoQvI=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by CHBPR12MB463627.namprd12.prod.outlook.com (2603:10b6:610:36c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 23:52:17 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::35) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 23:52:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:52:17 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:52:16 -0500
Date: Tue, 29 Sep 2026 18:44:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <pbonzini@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v6 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <2axqkai2rceb6c7mq57wafa34juogaur2nn5toig7ubpjjo5qm@nkublrmsqpgv>
References: <20260925015700.1260501-1-michael.roth@amd.com>
 <arZxTrbF9ElYuVNu@zhexu-thinkpadt14gen5.rmtcaon.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arZxTrbF9ElYuVNu@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|CHBPR12MB463627:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a0c0eb-7d88-4e02-7bcd-08df1e84b1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: 697pe0F1kAm5P4E9YKfrV6miI3DNsEfzrVGOZLsNPz4VcdnU8xr+lZRGT+cWhNU5zONimKyeab+3bBmRSxOkmVgPKMz0dzREtlywR66id/iVaFT5wh2W2xPjYcjx5hr7OuhbmpA0lKws04C1I6bEAVKuF0hKvjCtgzgK4UmGZ8U+2UrlhGM1emJUE9eB4BWOBX+nXxhCzRNicahziGtHmRp8kDAqzTKGGgWL5H/nOQesS0HjS51f+EDrOCcUVldydclaYe9F/3e8Q70r8XMfI2GPq+EB0xDoc5P5kCVGo2BXScqjkXzmyc1NtofcwXezbQR0n2rB+CTWpFbN2wq9DcFFBCcbIAtXvOfjTpxdNMIaQUJCvt0Z7DteExOjatIWHDPGagxEbbACq/PhMV6rVFpSCLER6gSNoSNNvDkY5xMMNI+74+XXkvxDdlEQDzpHrpxDzLpt5itHYlVGiNFZbJyatAARl4rPE42idfBuwINApujMPfPlib5l7RWhO4UhZdwqJZFRdo60K+4TDl7vPmX1SWVv9qgRwVmtrAr+NO7hJj5TzoLaFxgZMVQDqqXlHqAMum3t5ZuBkyUzEPwCU36BmP/E8pTlk1tU+00px2V2Ln8RApE6rLDSg4A/2MlS4uJ/Uj0hfh8KGjuSUrGv4K/i1+IzmJ6KINbJWlHBXK4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3pHJ+jRK9udP0kM792aM/hvH9aDTLooK481D9WTY0Jbkj8ZwDrt9InC6inL4p9ESyFJAX/h+to4WdEXpjVRH8h3+PEHXz4EOiY2LFH7Ro+A6n9X63/tnpK6H+d5HxRt7wEuVL7Thiz2hIK4KNAWT/vHVDl6OgwTTU3KuVyTLxBzhad2ci9BZmRuzqD+V/sBNOmoMnd1pkJkbSKEdaSOmN3vt8q/26NhWsqfeAivrwIFgwBe5rVOvNrtLkxFKkHMvIFD4pTr8sdX3viJVb7pL7xmva4xvtEwztN7sCHNR2urTDHgajI1RoOSgu82vRlbIBIZfmys4PEMNC8iJV79RMEwjLYX4SxsRD9ySS8DrChT+ON0Mm4u6Ag5PGKXPXWpA0QiGTso9y/QhXc/P1g2UvA2yovPwYUNNQQpS6NHVVj1smuJCpi87vNFfnuk4CqHZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:52:17.4119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a0c0eb-7d88-4e02-7bcd-08df1e84b1aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB463627
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 25, 2026 at 09:04:14AM -0400, Peter Xu wrote:
> On Thu, Sep 24, 2026 at 08:43:06PM -0500, Michael Roth wrote:
> > v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> > v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> > v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> > v4: https://lore.kernel.org/qemu-devel/20260812201938.198915-1-michael.roth@amd.com/
> > v5: https://lore.kernel.org/qemu-devel/20260908133151.836685-1-michael.roth@amd.com/
> > v6:
> > - Rename the hostmem property to 'x-guest-memfd' since initial users
> >   are expected to be developers or early enablers (Markus)
> > - Introduce accompanying 'guest-memfd' RST doc and reference it in
> >   the QAPI schema documentation for x-guest-memfd (Markus)
> > - Move all renaming patches toward beginning of the series for
> >   consistency (David)
> > - Fix mispellings in commit messages (David)
> > - Drop ramlist lock in new ram_block_add() error path
> > - Collect Reviewed-by's
> > - Rebase on QEMU master
> 
> Michael,
> 
> Sorry, I missed your very last discussion with Markus..  only notice until
> I saw the repost.  I agree we can mark it experimental, but just to mention
> we should have moved to use "unstable" rather than prefix "x-", then we
> don't need to bother with the ABI change, see:
> 
>     commit a3c45b3e62962f99338716b1347cfb0d427cea44
>     Author: Markus Armbruster <armbru@redhat.com>
>     Date:   Thu Oct 28 12:25:12 2021 +0200
> 
>     qapi: New special feature flag "unstable"
> 
> No need for another repost, I can manage that with two fixups when queue,
> please shoot if there's any objections.  Attached at the end.

Thanks Peter, the fixups look good. Since Markus pointed out a couple
other things to fix up I went ahead and squashed these into v7 which
will go out shortly.

Thanks,

Mike

> 
> Thanks,
> 
> ===8<===
> From 94884f136d9d42044e3f4cfcf440df8016ad3e99 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 25 Sep 2026 08:51:13 -0400
> Subject: [PATCH 1/2] fixup! hostmem: Support fully shared guest memfd to back
>  a VM
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/system/guest-memfd.rst |  4 ++--
>  qapi/qom.json               |  9 +++++++--
>  backends/hostmem-memfd.c    | 10 +++++-----
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
> index f7cef19283..d62a214a91 100644
> --- a/docs/system/guest-memfd.rst
> +++ b/docs/system/guest-memfd.rst
> @@ -38,10 +38,10 @@ exposed by QEMU command-line options.
>  For non-Confidential guests, guest-memfd can be used in a manner that
>  is somewhat interchangeable with a normal memfd. Currently, this is
>  handled by using the same memory-backend implementation as memfd, but
> -with an additional 'x-guest-memfd=on' option. E.g.::
> +with an additional 'guest-memfd=on' option. E.g.::
>  
>      qemu ... \
> -      -object memory-backend-memfd,id=ID,size=SIZE,share=on,x-guest-memfd=on
> +      -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
>  
>  Note that the share=on option is required for guest-memfd, since it
>  does not support anonymous memory allocations or COW-like semantics.
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 602b17ad83..7423acea8f 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -780,10 +780,14 @@
>  # @seal: if true, create a sealed-file, which will block further
>  #     resizing of the memory (default: true)
>  #
> -# @x-guest-memfd: if 'on', use guest-memfd to back the memory region.
> +# @guest-memfd: if 'on', use guest-memfd to back the memory region.
>  #     See the "guest-memfd" QEMU documentation for more details.
>  #     (default: auto, since: 11.2)
>  #
> +# Features:
> +#
> +# @unstable: Member @guest-memfd is experimental.
> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'MemoryBackendMemfdProperties',
> @@ -791,7 +795,8 @@
>    'data': { '*hugetlb': 'bool',
>              '*hugetlbsize': 'size',
>              '*seal': 'bool',
> -            '*x-guest-memfd': 'OnOffAuto' },
> +            '*guest-memfd': { 'type': 'OnOffAuto',
> +                              'features': [ 'unstable' ] } },
>    'if': 'CONFIG_LINUX' }
>  
>  ##
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index a164bb659f..666593ff6c 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -59,14 +59,14 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>  
>      if (m->guest_memfd == ON_OFF_AUTO_ON) {
>          /*
> -         * NOTE: x-guest-memfd ignores seal=on/off because it always
> +         * NOTE: guest-memfd ignores seal=on/off because it always
>           * implicitly seals the FD by definition.
>           */
>          if (!backend->share) {
> -            error_setg(errp, "x-guest-memfd=on must be used with share=on");
> +            error_setg(errp, "guest-memfd=on must be used with share=on");
>              return false;
>          } else if (m->hugetlb) {
> -            error_setg(errp, "x-guest-memfd=on doesn't support hugetlb=on");
> +            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on");
>              return false;
>          }
>  
> @@ -203,10 +203,10 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
>                                                "Huge pages size (ex: 2M, 1G)");
>      }
>  
> -    object_class_property_add(oc, "x-guest-memfd", "OnOffAuto",
> +    object_class_property_add(oc, "guest-memfd", "OnOffAuto",
>                                memfd_backend_get_guest_memfd,
>                                memfd_backend_set_guest_memfd, NULL, NULL);
> -    object_class_property_set_description(oc, "x-guest-memfd",
> +    object_class_property_set_description(oc, "guest-memfd",
>                                            "Use guest memfd");
>  
>      object_class_property_add_bool(oc, "seal",
> -- 
> 2.55.0
> 
> 
> From efb5a9d33373e0dcedbfec3dce28844164ccb8c8 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 25 Sep 2026 08:51:26 -0400
> Subject: [PATCH 2/2] fixup! tests/migration-test: Support guest-memfd init
>  shared mem type
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/framework.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 93225e3720..b7aef6b21c 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -301,7 +301,7 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
>          backend = g_strdup("-object memory-backend-memfd");
>          break;
>      case MEM_TYPE_GUEST_MEMFD:
> -        backend = g_strdup("-object memory-backend-memfd,x-guest-memfd=on");
> +        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
>          break;
>      default:
>          g_assert_not_reached();
> -- 
> 2.55.0
> 
> 
> 
> -- 
> Peter Xu
> 

