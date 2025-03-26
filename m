Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DBC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWnP-0002Bb-Hv; Wed, 26 Mar 2025 15:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txWnM-0002Ay-SU
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:52:12 -0400
Received: from mail-dm3nam02on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2405::622]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txWnJ-0007KN-US
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coVdUfFGRoQvk92YTcgoecn95Z6ENfQKhXqD2q34ioSih1UQUjUxE4WkV3sXwNM+sfWyDFaR3i17EDfzRHqsW8RWv+L4jSecRPQKHIxh63kDDajXbjDin1lvoSrz3cIb/hIAOyzaWT7u5RLYw2eim0nflIC1fkG0r+LuMDs7EuAMAS/Ezww7AiL+hBqzK+vKBCy3t0IjbOKiEpDqhwdD5VP697KrIgpVmFNSHqVnyLA0x2KYmSbNr153j527/2uy66VG/+zB9PNQVCYW2XTUbj91EYS0SgZSuy4p/YklBXI7ZuW6Cw+dmtcjdLMmekX/uSETejdlLPhVIbGORnXLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6b4wvureRR2+McEzxss5tPjB4T2fUqJsJK3JuavCpc=;
 b=M2Bxu8npZLGWEOg2GVqpDBal4yDSSXTjCQoZEay/0+uwLEyeNsEsTd/an/7gVGnYxtfrTfNnwNsnVX7j9X0MAoa07FVOYuJOVSPefLuS/EWrxegGXNt5TVg/81R/NtjwJPm8xF/2uXP3Wo6+myhTbCiRS8PKhYmJnS33VgGfqcXP6Av9gxc9GludNIYq3tPAMA8PRz6xM+COQrJr4IpSV794xyOiW/8yOMFrMUSdiDs9R08XXSZU/OWx0KntiFrWR/PkOEBdFkTYWGfrDejNc2WmoXgo6v9bC8bJfZAKuy98RgwEG5KTi25umVLthJ5iqYb6mhOjJb+IcKjRgPL7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6b4wvureRR2+McEzxss5tPjB4T2fUqJsJK3JuavCpc=;
 b=hcSkrqWYzxRg1JK5d18/8LvFhPoh/7fkkyWHbPgZId2M97ALcxc1VR8VOcy00wNf1eRfqdkzol4nvZDksUONkJM9NslUWLCcyjGTmLGKEjUPBvpu2+DLpiiBMNhFvGsfTPWtzl5wVN2KSvGAphVqx/gC9GrOk1/8lJbrlT+XL+k=
Received: from SA1PR05CA0014.namprd05.prod.outlook.com (2603:10b6:806:2d2::23)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:51:59 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::1f) by SA1PR05CA0014.outlook.office365.com
 (2603:10b6:806:2d2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.27 via Frontend Transport; Wed,
 26 Mar 2025 19:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:51:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:51:58 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
 <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
 <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
From: Michael Roth <michael.roth@amd.com>
CC: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 <qemu-devel@nongnu.org>
Date: Wed, 26 Mar 2025 14:50:04 -0500
Message-ID: <174301860426.2151434.16431559419990134889@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: f978c7ee-9746-440d-678b-08dd6c9fabce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUplTVhFRUpyOEVyVFFGalpMcjZSZ1A2b3FOTU9HMGY2WXRDYm1PTlYyS3dP?=
 =?utf-8?B?NE1vajhpcGYwdEJhTk05Zkxvd1hDc2lUdk5YNlhkLzVNY0FTVTJZMTJnSGlC?=
 =?utf-8?B?QThWSVozZS9pbHVndnU3VGN2NytQRkZtRUppblZJc2NKUkxrSG1OS1FWNkZ1?=
 =?utf-8?B?ZkdxMUY0V3ZwN3dma0xFN2hMYThIMlN6YVBRd2hzaGdYMzJTRzRZdVdTZWVD?=
 =?utf-8?B?Q21LS051dVljSmhyR2Z6M00rbXh5SkEzMkNEcVR3eDd2ZzhhaVlQZ082c0x6?=
 =?utf-8?B?NHJjL0I3RDZnUTY1azkvOU5pcU5IclhtZDVqUWNMRTdnQzVhS3pNb1NlVEtK?=
 =?utf-8?B?UHpzU3R0STg3dWRkTGxJRFpYblV5ZVQ4ZXVUZ2hZVDZVdmlWWnF4WFc2ZjAz?=
 =?utf-8?B?QlVHWWhkbERtdU1SWDhDSitzMjVSamkyeVVpY0h0NkVseGl5ZTlZMkZFTFRQ?=
 =?utf-8?B?MzJlMEM5QUJHeVllZHR5WE1ySTF1dWk2dmtvaDBQTUkvck9ZK1BUQkpVT1pZ?=
 =?utf-8?B?M1phMHpJK3l4OVlVYVVnSDdzcXB4RFlKVnA2bVdWY1FkQkl6ejVOS2lmYmZh?=
 =?utf-8?B?QkliS3lxWWV5Rjh2eDUxRjV3V1pmOWJKQ2FPQXN5cHZQdWlEck9EMW1HUnlP?=
 =?utf-8?B?a0VuTnphd2JrOWJWLzRnMGlETnhEeWl0V1A5UlRHWDVLNHVxUVhqYU5JVlFH?=
 =?utf-8?B?aXRGeVB6SGhraTBETHF4OVZrZlluY0J2UlBrNGo1bndYTS91bFlWRjFBcVc5?=
 =?utf-8?B?ekE0V25UWnAyS1hIVWtiYmJkVElJUEo1YWY2VkxoNTNXK1BWZ3pXNTRKZ21o?=
 =?utf-8?B?NVJVUng5YUZUek83aklyMW5rcG14QlRSSE9pSlltSkxheHlTYmthblo2U1Fw?=
 =?utf-8?B?R2UzR3c3bGR1UExZYUhPaXNseDZJZEdPYzMrK2xvb1V1bFlXODNRaVJxRTA5?=
 =?utf-8?B?d0tUL1BxZzJiTW81Y0s1bVp2Q3B5NVF6eTBIVncweTdrVk5mY1c1bjZFZzY3?=
 =?utf-8?B?aDk0eitVc2dyUGx5bW5zaFJNdmRTWFVVdlRRcjl0c0NWTksxQW5GQXM0Uit4?=
 =?utf-8?B?RDFaOUV3QjB2bHBPOGlVZDJCYzRodEZZUnFvRzlKaXVaSjJJRG1JNlRqcnlW?=
 =?utf-8?B?MDZtQkRFbTV6RDltTnhnMWYzSmxJck92M0ZTK1ByVlVwUStFNnJXVWJFRVZH?=
 =?utf-8?B?YWg1YXg0TUk0enBhRk5CSmJaYUJWdnBUWkxHdHNEZzdrK2Vteis2dWdxSm5B?=
 =?utf-8?B?RFRhazlPS29FemRvWkNlT1I3c1pFM084eElNRjJOVytNL0NMNjZmNmVmM1k2?=
 =?utf-8?B?T0VxVmtJUWZ6Y1A2UjVMYzk0VVk1cGl4SU5XNWRoTlNFL29pRGtZT3dYa0hx?=
 =?utf-8?B?a0VkOU5YemUzemIxSW5uMnlFbHEwbmJEVHVTU2dIRTI0a3Q5bVNtYWs4d2I3?=
 =?utf-8?B?T1JxbThsQi9VMVk2N2IrQ0NraXVNS1VjU2FyNVd6VXppSlFIWmo5TXB0UFZo?=
 =?utf-8?B?VmVES1JUTk9HckNRV3JydFRDNGgzNTNyQWhEYlNKOTQyTSs5cEhmd2VFT2NU?=
 =?utf-8?B?VzQvOGxjalIwMDN4VDVVRGJJRmppM0ZqMlQrczY4bHk0Z3hTM3JxVS9pVGF3?=
 =?utf-8?B?aEExeTJmY0ZQcEx5dFpVZ0FOYm1xSmtIUi9OZGxSaUdxMnNiMzJ1b2UzSjNI?=
 =?utf-8?B?ZEJMN3hYaDU5a1ZYMlo3WTdtSzNYek15NTZQWHF1VXoreHprTm56RnY3My9J?=
 =?utf-8?B?aUt6SFJlakxtZGtwNUJOczIyWFBycmw2bzlhMjRzdXdwQUFGa2FUWGVqSjB6?=
 =?utf-8?B?eVNJd2F6WTB0R0RpdEVreXZWeS9Dd0h4MnNESkFDNnhWcHB4NzEvT3ZMQ2Fm?=
 =?utf-8?B?d0xrUmI4eWRkUkk3ck9ZVzhkQlVPWURzVVhKOVZKZnpGNGJVcDNNQUhXOFYx?=
 =?utf-8?B?eThubElKaFZPSy9lT0xkbWplSVJkeEljQzdKVWVCYm1aS2d4b29iN0YvdkZ6?=
 =?utf-8?Q?k9/J5mMXX2r64B5bXTwB8BKaJQn6ro=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:51:59.3884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f978c7ee-9746-440d-678b-08dd6c9fabce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612
Received-SPF: permerror client-ip=2a01:111:f403:2405::622;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Quoting Tom Lendacky (2025-03-26 14:21:31)
> On 3/26/25 13:46, Tom Lendacky wrote:
> > On 3/7/25 12:15, Fabiano Rosas wrote:
> >> From: Steve Sistare <steven.sistare@oracle.com>
> >>
> >> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blo=
cks
> >> in the migration stream file and recreate them later, because the phys=
ical
> >> memory for the blocks is pinned and registered for vfio.  Add a blocker
> >> for volatile ram blocks.
> >>
> >> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
> >> sufficient for CPR, but it has not been tested yet.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> Message-ID: <1740667681-257312-1-git-send-email-steven.sistare@oracle.=
com>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  include/exec/memory.h   |  3 ++
> >>  include/exec/ramblock.h |  1 +
> >>  migration/savevm.c      |  2 ++
> >>  system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 72 insertions(+)
> >=20
> > This patch breaks booting an SNP guest as it triggers the following
> > assert:
> >=20
> > qemu-system-x86_64: ../util/error.c:68: error_setv: Assertion `*errp =
=3D=3D NULL' failed.
> >=20
> > I tracked it to the err_setg() call in ram_block_add_cpr_blocker().
> > It looks like the error message is unable to be printed because
> > rb->cpr_blocker is NULL.
> >=20
> > Adding aux-ram-share=3Don to the -machine object gets me past the error=
 and
> > therefore the assertion, but isn't that an incompatible change to how an
> > SNP guest has to be started?
>=20
> If I update the err_setg() call to use the errp parameter that is passed
> into ram_block_add_cpr_blocker(), I get the following message and then
> the guest launch terminates:
>=20
> qemu-system-x86_64: Memory region pc.bios is not compatible with CPR.
> share=3Don is required for memory-backend objects, and aux-ram-share=3Don=
 is
> required.
>=20
> The qemu parameters I used prior to this patch that allowed an SNP guest
> to launch were:
>=20
> -machine type=3Dq35,confidential-guest-support=3Dsev0,memory-backend=3Dra=
m1
> -object memory-backend-memfd,id=3Dram1,size=3D16G,share=3Dtrue,prealloc=
=3Dfalse
>=20
> With these parameters after this patch, the launch fails.

I think it might be failing because the caller of
ram_block_add_cpr_blocker() is passing in &error_abort, but if the
error_setg() is call on a properly initialized cpr_blocker value then
SNP is still able to boot for me. I'm not sure where the best spot is
to initialize cpr_blocker, it probably needs to be done before either
ram_block_add_cpr_blocker() or ram_block_del_cpr_blocker() are callable,
but the following avoids the reported crash at least:

diff --git a/system/physmem.c b/system/physmem.c
index 44dd129662..bff0fdcaac 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -4176,6 +4176,7 @@ void ram_block_add_cpr_blocker(RAMBlock *rb, Error **=
errp)
         return;
     }

+    rb->cpr_blocker =3D NULL;
     error_setg(&rb->cpr_blocker,
                "Memory region %s is not compatible with CPR. share=3Don is=
 "
                "required for memory-backend objects, and aux-ram-share=3Do=
n is "

-Mike

>=20
> Thanks,
> Tom
>=20
> >=20
> > Thanks,
> > Tom
> >=20
> >>
> >> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >> index 78c4e0aec8..d09af58c97 100644
> >> --- a/include/exec/memory.h
> >> +++ b/include/exec/memory.h
> >> @@ -3203,6 +3203,9 @@ bool ram_block_discard_is_disabled(void);
> >>   */
> >>  bool ram_block_discard_is_required(void);
> >> =20
> >> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
> >> +void ram_block_del_cpr_blocker(RAMBlock *rb);
> >> +
> >>  #endif
> >> =20
> >>  #endif
> >> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> >> index 0babd105c0..64484cd821 100644
> >> --- a/include/exec/ramblock.h
> >> +++ b/include/exec/ramblock.h
> >> @@ -39,6 +39,7 @@ struct RAMBlock {
> >>      /* RCU-enabled, writes protected by the ramlist lock */
> >>      QLIST_ENTRY(RAMBlock) next;
> >>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> >> +    Error *cpr_blocker;
> >>      int fd;
> >>      uint64_t fd_offset;
> >>      int guest_memfd;
> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> index 5c4fdfd95e..ce158c3512 100644
> >> --- a/migration/savevm.c
> >> +++ b/migration/savevm.c
> >> @@ -3514,12 +3514,14 @@ void vmstate_register_ram(MemoryRegion *mr, De=
viceState *dev)
> >>      qemu_ram_set_idstr(mr->ram_block,
> >>                         memory_region_name(mr), dev);
> >>      qemu_ram_set_migratable(mr->ram_block);
> >> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
> >>  }
> >> =20
> >>  void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
> >>  {
> >>      qemu_ram_unset_idstr(mr->ram_block);
> >>      qemu_ram_unset_migratable(mr->ram_block);
> >> +    ram_block_del_cpr_blocker(mr->ram_block);
> >>  }
> >> =20
> >>  void vmstate_register_ram_global(MemoryRegion *mr)
> >> diff --git a/system/physmem.c b/system/physmem.c
> >> index 8c1736f84e..445981a1b4 100644
> >> --- a/system/physmem.c
> >> +++ b/system/physmem.c
> >> @@ -70,7 +70,10 @@
> >> =20
> >>  #include "qemu/pmem.h"
> >> =20
> >> +#include "qapi/qapi-types-migration.h"
> >> +#include "migration/blocker.h"
> >>  #include "migration/cpr.h"
> >> +#include "migration/options.h"
> >>  #include "migration/vmstate.h"
> >> =20
> >>  #include "qemu/range.h"
> >> @@ -1903,6 +1906,14 @@ static void ram_block_add(RAMBlock *new_block, =
Error **errp)
> >>              qemu_mutex_unlock_ramlist();
> >>              goto out_free;
> >>          }
> >> +
> >> +        error_setg(&new_block->cpr_blocker,
> >> +                   "Memory region %s uses guest_memfd, "
> >> +                   "which is not supported with CPR.",
> >> +                   memory_region_name(new_block->mr));
> >> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> >> +                                  MIG_MODE_CPR_TRANSFER,
> >> +                                  -1);
> >>      }
> >> =20
> >>      ram_size =3D (new_block->offset + new_block->max_length) >> TARGE=
T_PAGE_BITS;
> >> @@ -4094,3 +4105,58 @@ bool ram_block_discard_is_required(void)
> >>      return qatomic_read(&ram_block_discard_required_cnt) ||
> >>             qatomic_read(&ram_block_coordinated_discard_required_cnt);
> >>  }
> >> +
> >> +/*
> >> + * Return true if ram is compatible with CPR.  Do not exclude rom,
> >> + * because the rom file could change in new QEMU.
> >> + */
> >> +static bool ram_is_cpr_compatible(RAMBlock *rb)
> >> +{
> >> +    MemoryRegion *mr =3D rb->mr;
> >> +
> >> +    if (!mr || !memory_region_is_ram(mr)) {
> >> +        return true;
> >> +    }
> >> +
> >> +    /* Ram device is remapped in new QEMU */
> >> +    if (memory_region_is_ram_device(mr)) {
> >> +        return true;
> >> +    }
> >> +
> >> +    /*
> >> +     * A file descriptor is passed to new QEMU and remapped, or its b=
acking
> >> +     * file is reopened and mapped.  It must be shared to avoid COW.
> >> +     */
> >> +    if (rb->fd >=3D 0 && qemu_ram_is_shared(rb)) {
> >> +        return true;
> >> +    }
> >> +
> >> +    return false;
> >> +}
> >> +
> >> +/*
> >> + * Add a blocker for each volatile ram block.  This function should o=
nly be
> >> + * called after we know that the block is migratable.  Non-migratable=
 blocks
> >> + * are either re-created in new QEMU, or are handled specially, or ar=
e covered
> >> + * by a device-level CPR blocker.
> >> + */
> >> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
> >> +{
> >> +    assert(qemu_ram_is_migratable(rb));
> >> +
> >> +    if (ram_is_cpr_compatible(rb)) {
> >> +        return;
> >> +    }
> >> +
> >> +    error_setg(&rb->cpr_blocker,
> >> +               "Memory region %s is not compatible with CPR. share=3D=
on is "
> >> +               "required for memory-backend objects, and aux-ram-shar=
e=3Don is "
> >> +               "required.", memory_region_name(rb->mr));
> >> +    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TR=
ANSFER,
> >> +                              -1);
> >> +}
> >> +
> >> +void ram_block_del_cpr_blocker(RAMBlock *rb)
> >> +{
> >> +    migrate_del_blocker(&rb->cpr_blocker);
> >> +}
>

