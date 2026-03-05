Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7D5EFCE53
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 00:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxwtn-0004gE-US; Wed, 04 Mar 2026 19:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vxwth-0004fp-Ny
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:49:02 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vxwtf-0000bz-GK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 19:49:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vet7qkzyVwXzNX0dFVcKbHFYfbXwG4ehSYVmAcWkU+9buyuTE3Wqp2vNNvBGJSGZkF/JwCDDuCdKJ9B1pW4lbSl2LSRBTO1Vnncgj9ZXt1EazMBxF4Zba42bHEo3+FNdWfMCBqyr+iFYrZZUHS2cwt252kyLKrCIvbNOXNM6Et3SuGcfAw2Z/Gps7XZ4VECR/xsOsvwsSdAUmxMkqDPIKsS+SSqAbIu49z+mzMFO+TK1Ivk7MylHvyW5my1bZyQcDt0jhJLxLOAPpvU47fygze30UgdObDzzqiYZPrsHfTW5UvxsPZYwIZuDKHh+6AHD2TDOxjTPHZ26G8k6iB//jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIRQPm886RSi0wUulemYEN6mW0bQtLHWBDnqeSXByvM=;
 b=CeeKE67Y2w1tV/7VUi1/u/oW0hG0j8lufPdIXJNSrCu6vv5JYqYJqiSU+yuRflPglUtUDMi8cAKir+/IcZWpNYy+S+u3zYEGMUzvVIT8cMFEMWpJWnIL1ZsT6pVYoK9LIE00t+dH/9Q6B0/1UFatizVL3VexF6mGkr54TINvDw7xCQpZDdtLIUxMXmtJhV+spQcW2bM7LMTQZxOjJQtKdB9O07ButoT6vdLGzxaf6YRo5yww6UcCeMZ9oi0+FsAsuu/VNAwwGx+CWRNV8LXmBIAPTwT9E8w+R17xYrPEmW8Lut7e0oDTGWxBFKi0kmZvXwzEZG4WVrf3xhMqQeSgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIRQPm886RSi0wUulemYEN6mW0bQtLHWBDnqeSXByvM=;
 b=DzJQBUsNCccr2eTfDj6O4Bst3yQixDU3jWTLjr5krU2jQwT8cha/1oXPHZ1fB66Pw/zby5Fd0Jqi8z0OXCXFalinKMa8SspCb/PBskSlGtcUaK+tVyMGThiptsqaRmk+Fz2DD6J7PrTmHbux7HCxOakiZZV+5C6rnjocLqcyFYo=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Thu, 5 Mar
 2026 00:48:51 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::ab) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Thu,
 5 Mar 2026 00:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 00:48:51 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 18:48:51 -0600
Date: Thu, 5 Mar 2026 01:48:49 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 <anthony@xenproject.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v1 3/5] physmem: xen: Conditionalize use of the mapcache
Message-ID: <aajS8ahPOaE_g5q1@zapote>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-4-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2603041606480.250016@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2603041606480.250016@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2026-01-25)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0530a134-e785-4650-3aec-08de7a50f870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: aSrjvPGButsZ6z+3LAFs0fUt93q7c7LKl2Oqb9IfDHPbPOHPMb1/ZRa/2N/AfZtY9RNLgpfhop9RmUa75iIMZcvFuulRQJv6+XCfPC85eBVwbFC+1ZixclHldjripAAodUid9ku1mgXnIWahkQ14w/8rZ2itCTnQiX1AiV51PHTBxyXXR8yTFop5rTlV9IqF+tqpeJHRQBN7H5pTNk5Lbt96kjh6HTgp/GlNoptG5u1+9gp/5DQ7j/QNgGmssNfE6XfuEL3Y4AraHLwzZLt5WZk6t7OVyEOxTisMJA8mJlR4mM9d4DDB/Marz/mIzyREoCG5mDVdH/yjtHwT/CazaKV6r5oB6gniUprVhX2qvKX8yghNTqtsim0bQXcxwuF0TNVGVnAuI0yCxQy8RKjP9aEFFTWnhQFM0b/uJMhi/hncHzhSJJMXHgcEh3kCILANc6ItS3KCWdtPw2m/ZcxVHgYO+9wL+dxTuGnQFtF0KdBHXexchIjSyz8AoQzXRaUtB8zreNybdrsYMUMpcuvk+AnMY4vL0dQc+GDaM7X371sxiiTBXBoOmWuiE3HZW17WPrk+qyDALsTbwRNBnSRY1JrIDAS9o1R2fllWWcRpWU4qE13eUuqAUUpgUdXwO48cZF1T4z18Jxtb4J/ZpnL1WtJFeNKz72+eEeb0BysNdlOVhSYI6ZUHWc0THo4tbaJbEBX5ts5BxV0afKwNxiWo9z+kcjuEHou0czbBZX0gHUrGbJFAHLE/S+yoNJMwFvcZSf4HEaoibpH+xU2QRiLjMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: txNWR7aYI+raqgKNKqS7mD7AT6urrqvmst5MvXsT6fATdPzWPCxssEkmkAPqoy3qjMWzJthY06ngIyifu/0tthYQfHEoI3pqlFL00r5dGU6rpP2vvM7F+yxqiBSckHh/MGQ1TN/n5wcL9dm0AQME55kiOcbTvL8XOt0nsakxWSHwvKE2dUaAVtk/doO4UiekFVW1ChtRN9O8JZkN3nkfnULGz8acaI6y0G269D16QwbeZv2xwco0U2nwfsIg1lfKS9kA8P4Iik8+j1tCkhJe+jOgT/eKC8+Dlh0WCg+nGgZHP6EiO9fIbQtwT0bA8vfaF0b4NcyJawLXKbox6KmI5Ng0WwAxcENDCLf5knaZXFEhFOIUoBHh94fCTTphypYDkbF6ljefH8oHPOVqzpxIsLejmB1JwrTpFOKo5oEYvZUVjvfVXkDUzhYZ1NvJfpVQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 00:48:51.6454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0530a134-e785-4650-3aec-08de7a50f870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 04, 2026 at 04:07:23PM -0800, Stefano Stabellini wrote:
> On Wed, 4 Mar 2026, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Conditionalize use of the mapcache. This is in preparation
> > to optionally disable the mapcache at runtime.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  system/physmem.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/system/physmem.c b/system/physmem.c
> > index e5ff26acec..64e6d50f8f 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -578,7 +578,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
> >                                      is_write, true, &as, attrs);
> >      mr = section.mr;
> >  
> > -    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
> > +    if (xen_map_cache_enabled() &&
> > +        memory_access_is_direct(mr, is_write, attrs)) {
> >          hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
> >          *plen = MIN(page, *plen);
> >      }
> 
> All the other changes make sense. For this one, the code inside the if
> check is not strictly related to the mapcache. Are you sure it should be
> changed?

Hi, yes, when the mapcache is on, we limit translations to the current page
because the next page might not be mapped/locked or could be in a different
mapcache bucket with a different virtual address. When mapcache is off, guest
RAM is fully mapped (same as non‑Xen), so we can skip capping plen and allow a
larger mapping.

Perhaps we should add a comment to clarify?

Cheers,
Edgar

> 
> 
> > @@ -2577,7 +2578,7 @@ static void reclaim_ramblock(RAMBlock *block)
> >  {
> >      if (block->flags & RAM_PREALLOC) {
> >          ;
> > -    } else if (xen_enabled()) {
> > +    } else if (xen_map_cache_enabled()) {
> >          xen_invalidate_map_cache_entry(block->host);
> >  #if !defined(_WIN32) && !defined(EMSCRIPTEN)
> >      } else if (block->fd >= 0) {
> > @@ -2736,7 +2737,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
> >          len = *size;
> >      }
> >  
> > -    if (xen_enabled() && block->host == NULL) {
> > +    if (xen_map_cache_enabled() && block->host == NULL) {
> >          /* We need to check if the requested address is in the RAM
> >           * because we don't want to map the entire memory in QEMU.
> >           * In that case just map the requested area.
> > @@ -2785,7 +2786,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
> >      RAMBlock *block;
> >      uint8_t *host = ptr;
> >  
> > -    if (xen_enabled()) {
> > +    if (xen_map_cache_enabled()) {
> >          ram_addr_t ram_addr;
> >          RCU_READ_LOCK_GUARD();
> >          ram_addr = xen_ram_addr_from_mapcache(ptr);
> > @@ -3787,7 +3788,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
> >          if (is_write) {
> >              invalidate_and_set_dirty(mr, addr1, access_len);
> >          }
> > -        if (xen_enabled()) {
> > +        if (xen_map_cache_enabled()) {
> >              xen_invalidate_map_cache_entry(buffer);
> >          }
> >          memory_region_unref(mr);
> > @@ -3898,7 +3899,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
> >          return;
> >      }
> >  
> > -    if (xen_enabled()) {
> > +    if (xen_map_cache_enabled()) {
> >          xen_invalidate_map_cache_entry(cache->ptr);
> >      }
> >      memory_region_unref(cache->mrs.mr);
> > -- 
> > 2.43.0
> > 

