Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF70C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyim0-0000Ib-Jk; Tue, 25 Aug 2026 00:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyily-0000Hv-92
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:28:30 -0400
Received: from mail-eastusazon11011014.outbound.protection.outlook.com
 ([52.101.52.14] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyilv-0004wU-P3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAbkLN56jBMBmxqNETWwbKjOozPwjswhinu/yP/NwaWudWm46tctxICJeNvqHk41jHwHoxVQx3AopSxDI8DzotwDlArEbo9yPtouSjxCU6oALh0GU8vu7G6/dRByC55T6FTXdwBbwFbtmhpjqRcvwnHVQTjS4Xp7/beWyEMMFrPM48Aab/KozxSLMRTq3ihRAZJz+ttKCuPF+9hhhBvQ5FEtaTU9ZDorqkOOUNJ5oKp767xJDvRZJAanFrnO48t/7L3r2Bik/f6MvoV10tTAItYEGJfqowIrBY4hhhuJPIzV1tejS2sKgYcDafbGHyjrhic39NDXE2JRRuA/o15L6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZusMZMR1qKVMl4/RdpTVCmYovRRUDMh6DX762OPWqg=;
 b=RXouUPjNEfZNLwiHVf4f92jYID5zSf/vfnvU4Fj2I4vJGDJgH4YrKrC58MXok2v0rWdMonJ6evItmWUE71utkIiNGM65WZNU603XM1u1EJCzAngDEte9I7dcytkVNRmraAYq5LD5rfnAoGEnj04o7VUcjXjcKfOUeyuG6pOVmBoQH8w4/HJnpAy8myAY/RkdviPqWXX29QLBK+UjI0dUbbP5kNybMsdkLFdIdqnDN+eMppV3FJ3VtmNbG30GttcxzQq1jn/jXHAiY327yNebcgWAMOvkTz9H3F4YrHpjYdrnVqA/KJ+gsJ1tp1h3k/phgi5Mt44x0gqBAMFpaSaFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZusMZMR1qKVMl4/RdpTVCmYovRRUDMh6DX762OPWqg=;
 b=xvmI3To4ROA90teDK/DG2dSNA83DWlDY0yfNhtqBLEfdnZC7WD2eqhjJvTn0uA2YTw+oNnbGfwT46gOhEYZMRYMsDBo8ey5h9t/yVD/49WDc0uHUa4eCKIoaEbkeh6BFfSoz3iP7cIKDFW6idxudOE6FINW4u9Xb0gT/SPwmVig=
Received: from CYZPR17CA0012.namprd17.prod.outlook.com (2603:10b6:930:8c::16)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:23:18 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:8c:cafe::88) by CYZPR17CA0012.outlook.office365.com
 (2603:10b6:930:8c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 04:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:17 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 21:21:30 -0500
Date: Mon, 24 Aug 2026 21:20:53 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, <jmarcin@redhat.com>, <david@kernel.org>,
 <pbonzini@redhat.com>, <chenyi.qiang@intel.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
Subject: Re: [PATCH v4 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <mjoftyyoki5ho7qwh5g2rlbizybf2yrumcjdrb2ycy3hgglqsx@4nphsdgorlc7>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <aoheMqE-RnH8sQ82@x1.local>
 <3fwr25hmoz7yicoh3o3x3ldeweapn2tbn4dnji67hgrnz7l5bh@rs7gqotxraef>
 <aoxEfKoYWtdOSwH_@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoxEfKoYWtdOSwH_@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6475fac0-7265-4414-71fa-08df026096c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|36860700016|23010399003|7416014|376014|1800799024|10067099003|4143699003|18002099003|22082099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: q8SV3fFUL2pSsCxvcYlR5cw1Ae9OPIPhWxve6TEV5ePHXJooMWDdvO0TjnknaJW/FjsBahePOdtEEbUKnkKxQBXu1k9RbkwBJ2pUFdjdK+PzFvBZBjcHIW8qxxJZEK9Atx0bhzZwg0Dc9AsG3AE16KLLwrVcZieg5TteGneWdLmeBrm1/3ZvJVYyCO2PEZmqi2ZP20lJpeC6kHXwF82oAsCStfPHNTBHlXZHTePpZvOteOAyUfjhXbuoWRlUu/dcr9OR//JJ8VY21fIbsE3LcTCEBQQZG15jhCgGWl1LdrQ2+RmpYyQ+f+mPy+l3wPRRjnmz0F181JKpMJmmAmvwebMbBwtqaoUPI1W9ioT5S2V4hGo3oAKIgTkL66N7clhd4An88szF9kZy9WgABJOWlWSbsV79oQB4JKbFUHu8TqhqEKfHhNzm63m38A5n57r2X0leuLtR9AoRad901a0KKc0ir42ICPlomFcUxFiqwMusKR6GAkJfn0KbI450JDenUmYK/jgqovhfOoMitRjf8A81HsPwafO0KAOfz/leou0eYwoKaRtz1430S5dobbMFQr476MUIE4GNsRJFT6lbHTq90jQmE1rV3XPszFtOgEYF/t+NuZmJIdbLvewZd/aXWIYMxq4NrTIPPVIskzGjJwx2TTBvigRkstte0oi2Oco5Anv/KGPMp4FB+T5aVD24hrZkXFdLPw8cqoFtX3esig==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(36860700016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yDu86C1FXBF0MxZJvBOSQy73tGixX5XHOtGXdEaA8kOF5SMFxWDnaSbM9fZNuR2HUdIsTd+Pyh8vAdITWVT2GUumEC31H9YlVcQb003zG+NakYH6xFfVaVNI1XYULPx3YRrz2ue3MNMp3yp3aQh9JZ0f3Qfin0+wxUNrfyxs91Uqwltl6TaGauu72LN+ejJSvVUIT/qQla7ZlIRO8RLfsqesdLx2roCaiTuA6ZTEghJ9mqnHoTjrHAi7n4bPjR8eFMGtFk/rSRZVS/2nuMCOs3vQt1mAXzjPeYL5QMM2jX8Azz3qxIbUeWKMfQwhcCJpRr5UvpK3cL00XcAa6f0uztrwjM59Mo3nkScoF2tbJTzVguBi+FjDjh5Iz8evZu46jhCSVAnaN0ATzCAoqziuOVuxJRGKOryhouSJ3EQn7f31ygG8dGCkKxwcFp+MS2dA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:17.8763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6475fac0-7265-4414-71fa-08df026096c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
Received-SPF: permerror client-ip=52.101.52.14;
 envelope-from=Michael.Roth@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 24, 2026 at 09:17:48AM -0400, Peter Xu wrote:
> On Sun, Aug 23, 2026 at 10:52:13AM -0500, Michael Roth wrote:
> > On Fri, Aug 21, 2026 at 10:18:26AM -0400, Peter Xu wrote:
> > > On Wed, Aug 12, 2026 at 03:16:38PM -0500, Michael Roth wrote:
> > > > v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> > > > v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> > > > v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> > > > v4:
> > > > - Picked up v3 series from Peter Xu and rebased on 11.1.0
> > > > - Collected pending Reviewed-by's
> > > > - Per-patch changes:
> > > >   [01/12] Fix blank space (Xiaoyao)
> > > >           Fix commit message typos
> > > >   [02/12] Drop duplicated error-handling for capability checks
> > > >   [05/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
> > > >   [07/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
> > > >   [08/12] Disallow 'seal' and 'hugetlb' options based on guest-memfd=on
> > > >           Fix minor typo in comment
> > > >   [11/12] Fix up typo in g_test_skip() reason
> > > >           Pending: Move kvm_guest_memfd_init_shared_supported() to
> > > >             migration-util.c (Fabiano)
> > > > 
> > > > This patchset is also available at:
> > > > 
> > > >   https://github.com/amdese/qemu/commits/gmem-shared-mem-v4
> > > > 
> > > > and is based on top of v11.1.0
> > > 
> > > Should I just pick this up?  I'll touch up the commit log that Phil
> > > requested.  Objections welcomed before next week.
> > 
> > Hi Peter,
> 
> Hi, Michael,
> 
> > 
> > No objection here, although I'll be posting new version of the in-place
> > conversion support later this week (~Wed-ish) and was planning to an
> > updated version of this series roughly the same time so which ever way
> > is best for you.
> > 
> > If you do post one though there's also the missing 'return false' and
> > dropping the seal=off enforcement that Daniel noticed before we started
> > talking about introspection fun.
> 
> I didn't mean to repost this series, I meant to pick it up for a pull.
> Sorry if it was confusing..

Ahh ok :) No problem!

> 
> I want to make sure balls are rolling.  From our side, we weren't rush on
> this one to land, as we'll need to wait for 1G to settle anyway, but if we
> have others (like your in-place series upcoming) pending, I think we should
> just land it sooner.

Agreed, LGTM!

> 
> You're right, we need to fix things, I noticed it right after I sent the
> email and then I found CI / unit test failing.. but I haven't got a chance
> to say..  If you repost please check migration-test with --full, otherwise
> the gmemfd test will be skipped.

Ok, I had seen migration-test passing but I didn't run it with full so
I'll look into what's going on there.

> 
> I have two fixups queued locally, I'll attach it here, please use it
> whatever way you like, I'll wait for your repost.  NOTE: I touched up the
> hugetlb failure message when I fixed it up myself, but since you'll repost
> you can decide; please just treat it as a comment then, I just think the
> new err message is less strong because we will support it.

Ok, I'll get these rolled in as well.

Thanks!

-Mike

> 
> Thanks,
> 
> ===8<===
> 
> 
> From 0a0dd0f808d4f668ac099945ab35a981e1a07bfb Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 21 Aug 2026 12:16:15 -0400
> Subject: [PATCH 1/2] fixup! hostmem: Support fully shared guest memfd to back
>  a VM
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  backends/hostmem-memfd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index fbe65b00be..6576331441 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -57,14 +57,16 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>      }
>  
>      if (m->guest_memfd) {
> +        /*
> +         * NOTE: guest-memfd ignores seal=on/off because it always
> +         * implicitly seals the FD by definition.
> +         */
>          if (!backend->share) {
>              error_setg(errp, "guest-memfd=on must be used with share=on");
>              return false;
> -        } else if (m->seal) {
> -            error_setg(errp, "guest-memfd=on must be used with seal=off");
> -            return false;
>          } else if (m->hugetlb) {
> -            error_setg(errp, "guest-memfd=on must be used with hugetlb=off");
> +            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on yet");
> +            return false;
>          }
>  
>          fd = kvm_create_guest_memfd(backend->size,
> -- 
> 2.54.0
> 
> 
> 
> From 66ac7b3f2268430106bfe8034ef8460215e9db91 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 21 Aug 2026 13:00:09 -0400
> Subject: [PATCH 2/2] fixup! tests/migration-test: Add a precopy test for
>  guest-memfd
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/precopy-tests.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 8146f37d61..d57ffcac23 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -184,7 +184,6 @@ static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
>  
>  static void test_precopy_tcp_plain_gmemfd(char *name, MigrateCommon *args)
>  {
> -    args->uri = "tcp:127.0.0.1:0";
>      args->start.mem_type = MEM_TYPE_GUEST_MEMFD;
>  
>      test_precopy_common(args);
> -- 
> 2.54.0
> 
> 
> -- 
> Peter Xu
> 

