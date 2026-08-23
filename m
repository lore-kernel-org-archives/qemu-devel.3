Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275F0C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyAaC-0002je-1h; Sun, 23 Aug 2026 11:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyAaA-0002jP-HE
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:58:02 -0400
Received: from mail-westcentralusazon11010061.outbound.protection.outlook.com
 ([40.93.198.61] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyAa7-0007eg-82
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:58:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUZbOW9uQ6oyjXfyzArTXn9ALrDj8DmKDptLXkgKNrv5AHIdch6VwGuXAwj0zizfh1nB8HUe2auUAqEYCfOft2CbhAaZvyBrRMyen7donTKezzOZWkaBJhL4OUyATwtMkgzbfDAM9QZjIOHR9Ut4ybQP0MhG8QLEmtw+Xn+dQUQr9MeRAcMxzvJdpypmGvWwc4ykr0CCLycTGCH9RgqsDBiFAp1LVQVe/rUpFsvRIHXTBYGvCvPtMULV9UaVXl2A1Yi9XpoCi9SnvAH56yv5QWIxIrGvgPvrXWInkqXzJW4y08GLxx6yEUxFaVQ7cOtTVb2aT+AJ6/u3QbEo0dIKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6XqINf3CsuVmUuUiFyvxL056t+lY/mEqPhGqrcnbVY=;
 b=YB2csizO4ENP4LI8OF1ZpykN3sWqKUiMo+Keic9GjpsQD/ACwHQrUk63Ow3dZ3+tK6rkZkFiLSWb/GJTthv+JxoAIxuZu3O8m+nxcvRKrzOtsK0CPurisM0AeJbWovlxN4lSX7FnplyP2G/3IyAc9fw8tsmpI+v6guY7nGrAedou4XVqaJooKRHV6sZEPmOhuolB4s1XooK7QfA6YpLFoQ5Vf7pX992YhxQ3jE+LMTjeZN31TDVAr0uA3cKJPwNYHTp3Pzo0euZGksG3jY8egLaCVELTOsWYEl4LpOeJ6gqerdEPE6S0NgK7tYQefYjxfzO37nRj8eZ7xWJAmEIHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6XqINf3CsuVmUuUiFyvxL056t+lY/mEqPhGqrcnbVY=;
 b=P0AKz1at5V6w3KxVdcj2j+lZvjpsva88wEbxg6fasUle4hAdVmwhC9lXX11an95Cpv2qbx9cxihoURS4qbqsdMNjHAGZrqpJ8O30N3gIhH2DPuQ82SigTuJJjbLGA5+3NeYsMrqxH3qHHz0YFEIPT1RFNNzHQwBwzhi3GC8euyQ=
Received: from DM6PR01CA0028.prod.exchangelabs.com (2603:10b6:5:296::33) by
 PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Sun, 23 Aug 2026 15:52:49 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::54) by DM6PR01CA0028.outlook.office365.com
 (2603:10b6:5:296::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Sun,
 23 Aug 2026 15:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 15:52:48 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 10:52:48 -0500
Date: Sun, 23 Aug 2026 10:33:36 -0500
To: Peter Xu <peterx@redhat.com>
CC: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <jmarcin@redhat.com>, <david@kernel.org>,
 <pbonzini@redhat.com>, <chenyi.qiang@intel.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <2k6hph3cnf4djvjd72g26sdgxluixhm2mpyf2emvgmkrfturvj@ctnctjaks7jq>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com> <an3PWdPIdb6afDsS@x1.local>
 <an8yCp9qZ498aLu2@redhat.com> <aoMGNz9AdOnDQkKE@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoMGNz9AdOnDQkKE@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: ef96907c-afe9-4206-991f-08df012e94ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|11063799006|5023799004|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: Ke7hEAqqm0q1TOclT11GKnT+QM7osOlXVOgPY04xkAqJy9z5iJZdbA1spr9MTlK/kN7hA9tuh9CkSdczi7NVqq9ftPJsIdmpsKDu7cZ4QKpxlWBKhaYTnU4hOSjttVymXifPIg0yKEd9MEz/fyUV5Cv9fs22AQ4+MK/L1GxiTPZ751lkx+tjk16SMvQEAn/oQhJFgCHNMl3l+UxO8liXtWWfOYUNz23V8dFujUkrSabUMwfd9TIQctD088gIdlOhGNOCwNqY4OWyPIKRHvs1GGLTV0MsyBP9kIXLO4Xh1DODT3ljWzhFjMAyOtJm4GfO487R3ocLOYaFaZcus6gUaPCBwRxfrlZHo/ltwE/l0jeBzFF7TsCMKdF3EKQFLRlkqeDJAe4hFFn2UMxoMIE+eF0pjgre9U0m+88qC5tUHV/HTKrTIDw6gxCXdn0p/Z2u2eha2RQyBeqNhc88zoqCH2+Sv4omZKVZcjr+kgX7vwMF8L2sel/6LyVtkRCOUSSrzwAyWsQr5HQE376ezbQX0uLEYEm5fszWVrQdbt9DkH0yOpgqldQvTHk+QXKKbCadiqN/Eybb8VaGj3VM8Ft3escpuL37WsDuFytvGNxwg/4KkFQiIBqcxzAZsyd3A83EE0Qh8BGbTFfOe5HFlCXDUVZFAqxDMTgY9FBEMlGcNg3JV34o9Eek2Ql0F7iUCx0os9ceU5ryMio0wxsjV3Zr1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SJhWnf4PVMtvcAGU1ARtEFAkgUqb1IvegE3BZq/Iq47l6QBl3t9cLnckaNcYBksf56mLj1dMRVt5ZK4yvmRehM/WrASWNW/PuByND7YIpDaifM3mfE+OhhapFKFq3AqZFpbRyBUlF9P+at8dsgWwxMRzOz7rFtx4bpD4FAQUPQdvfbBR1Ct2CvoJNNPvGzq+rcUPTBIiCcjnCqbdKnw5JW0i5ilgc4HHcOVPhr2JOUgyhV0JVIy+TysgjgXRQBzwq3i2WDQACMMotyTn3b1mmMPvu+j0BHEUM4jxUkeV1w1BsFHbG0d9OosnL66CCxBOmZ5fIqYNYmC08H7Cw3AXEnsLHD+L88MBEshMnQW2SKKvLmOHqNH0oX648j1QcXLhMgsvQNVGTtjAHDnZ5iSCgQuJljN6K1rlsi0+DrIQsxFtysJa88GdTVntznsFW9rS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 15:52:48.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef96907c-afe9-4206-991f-08df012e94ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984
Received-SPF: permerror client-ip=40.93.198.61;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Mon, Aug 17, 2026 at 09:01:43AM -0400, Peter Xu wrote:
> On Fri, Aug 14, 2026 at 04:19:38PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Aug 13, 2026 at 10:06:17AM -0400, Peter Xu wrote:
> > > On Thu, Aug 13, 2026 at 01:48:21PM +0100, Daniel P. Berrangé wrote:
> > > > On Thu, Aug 13, 2026 at 08:28:24AM -0400, Peter Xu wrote:
> > > > > On Thu, Aug 13, 2026 at 09:24:22AM +0100, Daniel P. Berrangé wrote:
> > > > > > On Wed, Aug 12, 2026 at 03:16:46PM -0500, Michael Roth wrote:
> > > > > > > From: Peter Xu <peterx@redhat.com>
> > > > > > > 
> > > > > > > Host backends supports guest-memfd now by detecting whether it's a
> > > > > > > confidential VM.  There's no way to choose it yet from the memory level to
> > > > > > > use it fully shared.  If we use guest-memfd, it so far always implies we
> > > > > > > need two layers of memory backends, while the guest-memfd only provides the
> > > > > > > private set of pages.
> > > > > > > 
> > > > > > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > > > > > only source of memory to back the object (aka, fully shared).
> > > > > > > 
> > > > > > > To use the fully shared guest-memfd, one can add a memfd object with:
> > > > > > > 
> > > > > > >   -object memory-backend-memfd,guest-memfd=on,share=on
> > > > > > > 
> > > > > > > Note that share=on is required with fully shared guest_memfd.
> > > > > > > 
> > > > > > > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > > > > > > guest-memfd may return negative but not -1.
> > > > > > > 
> > > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > > > > ---
> > > > > > >  backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
> > > > > > >  qapi/qom.json            |  6 ++++-
> > > > > > >  2 files changed, 56 insertions(+), 6 deletions(-)
> > 
> > snip
> > 
> > > > > > "memory-backend-memfd,guest-memfd=on|off" is switching between two
> > > > > > separate implementations of the class.
> > > > > > 
> > > > > > This whole thing is just shouting "use a different class".
> > > > > > 
> > > > > > There is no meaningful sharing of code here, and the sharing of the
> > > > > > public interface is offering apps no value as the impl prevents them
> > > > > > from choosing the value of the properties - they have to be set of
> > > > > > certain values which are not introspectable.
> > > > > > 
> > > > > > Please introduce a "memory-backend-guest-memfd" backend instead.
> > > > > 
> > > > > This is indeed what Michael used to suggest, and we were discussing in
> > > > > previous version on which is better,
> > > > > 
> > > > > https://lore.kernel.org/r/rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk
> > > > > 
> > > > > The hope is this is also easier for either libvirt or most users, but
> > > > > please correct me if it's not the case, especially for libvirt.  The plan
> > > > > is when CoCo flags are provided, all things will automatically switch to a
> > > > > CoCo-friendly implementation within QEMU.
> > > > > 
> > > > > It also means here the guest-memfd= parameter shouldn't be needed in real
> > > > > CoCo contexts because they'll simply be implied (no cmdline change needed
> > > > > for the same "-object memory-backend-memfd" one used to use without CoCo).
> > > > > It's only needed for only special use of guest-memfd, in this case
> > > > > init-shared is the special case where CoCo doesn't use.
> > > > 
> > > > Reading all this, IMHO reusing memory-backend-memfd for the current
> > > > Coco support was a design mistake, it should have have a
> > > > memory-backend-guest-memfd object from the start.
> > > > 
> > > > Given that we need to be able to control memfd vs guest-memfd for
> > > > the non-Coco case, it is still worth introducing the new object
> > > > class today.
> > > > 
> > > > Even if the two classes shared all their properties (which they
> > > > don't given the comment about 'seal' being always on), then a
> > > > "foo=on|off" that toggles two separate impls is still creating
> > > > a pair of sub-classes by the backdoor. 
> > > 
> > > The idea of that, at least in my mind.. is an user shouldn't need to worry
> > > about differences of guest-memfd and memfd, QEMU should just do it for the
> > > users, based on the machine configurations.  Memfd is a concept more widely
> > > spread, the hope is anyone using guest-memfd should simply treat it as one
> > > memfd, no matter it is shared, in-place converted, two-layer-backed, or
> > > whatever is happening underneath.
> > > 
> > > Now we do create guest-memfd via a separate ioctl, what if we can create it
> > > via memfd_create() syscall too?  Then do we need to do the separation from
> > > QEMU layer?
> > 
> > If QEMU automatically did "the right thing" choosing between traditional
> > memfd and guest-memfd, then I wouldn't have even started this thread :-)
> > 
> > The "guest-memfd=on|off" is the trigger that made me think the design
> > was wrong from a public interface POV, as that explicitly says that the
> > memfd vs guest-memfd distinction is not automatic - it requires the
> > mgmt app to understand it and choose between them.
> > 
> > > IMHO that is now an ioctl is not required; it really can be part of
> > > memfd_create() syscall, it's just easier to manage, e.g. it's completely
> > > KVM alone, and it also has attached to the KVM instance.  The idea is still
> > > similar, and we can see that from possibly shared properties here on huge
> > > pages and so.  I don't treat seal= a block just to introduce a new object
> > > for that, and I expect as gmemfd evolves it will gradually get most
> > > features memfd supports.. like folio migration and so.. but I could be
> > > wrong.
> > > 
> > > IMHO one major question to ask is, is it more convenient for libvirt to
> > > have that new object?  Please keep in mind that after we introduce this as
> > > a new object, we may start to introduce even more *-guest-memfd in the
> > > future, we roughly talked about DAX in the previous discussion.  My goal is
> > > to make it most convenient for either user or libvirt to maintain the
> > > cmdlines for QEMU, but if you think that makes libvirt live harder instead,
> > > I've no strong feeling to go back to what Michael initially suggested.
> > 
> > It is no more or less difficult for libvirt to use different object
> > types vs using different guest-memfd=bool values.
> > 
> > What makes a difference for libvirt is understanding whether QEMU
> > implements a given feature or not.
> > 
> > If we have the situation with
> > 
> >   memory-backend-memfd,hugetlb=bool,guest-memfd=bool
> > 
> > with this series, IIUC,  libvirt can introspect to see the new
> > guest-memfd property, but it has no way of knowing that it can't
> > use the hugetlb proeprty when guest-memfd=on
> > 
> > If the next QEMU release now permits hugetlb=on at the same time
> > as guest-memfd=on, then libvirt has no way to know the restriction
> > was relaxed.
> > 
> > The QAPI introspection data for memory-backend-memfd is identical
> > in both cases.
> > 
> > To deal with this, you need to introduce a workaround to QAPI
> > by declaring a feature flag like
> > 
> >    features: ['hugetlb-with-guest-memfd-works']
> > 
> > that libvirt can probe for to determine the functional improvement
> > in QEMU.
> > 
> > By comparison, if we introduce a memory-backend-guest-memfd
> > object today, then it will omit the hugetlb property entirely.
> > 
> > If the next QEMU release adds a hugetlb property to the
> > memory-backend-guest-memfd object, this change is now visible
> > in the introspection data, and thus libvirt knows that combo
> > is possible with QEMU
> > 
> > (yes, there is the issue that this might have kernel dependancy
> > that is not visible from QEMU's introspection, so not perfect,
> > but at least libvirt can determine what QEMU is capable of)
> 
> Yes. Due to that, I was expecting Libvirt will always need to query host
> capabilities on its own.  In this case Libvirt, if preferred, should also
> be able to probe standalone with KVM_CAP_GUEST_MEMFD_FLAGS.

Yah some generic routine to probe for guest_memfd flags seems
unavoidable, and likely that probe will need to be per-VM-type (e.g.
confidential vs. non-confidential) to be reliable.

> 
> It's also more involved for sure when hugetlb is involved, if it will share
> the same hugetlb reservation with hugetlbfs, it'll also somehow need to
> make sure there're available pages later for allocations.  Also IIUC not
> all default users are accessible to huge pages..
> 
> From QEMU's POV, personally I still prefer sticking with the memfd object
> with guest-memfd=on, then expose the "features" in QAPI, that seems cleaner
> to me.
> 
> > 
> > 
> > > For example, if libvirt wants to detect hugetlb supports for an object, it
> > > can still pass in the parameters and test-boot a QEMU and then IIUC it'll
> > > still correctly capture an error for gmemfd case.  It might be that I
> > > didn't really get what will make libvirt complex by reusing the object, but
> > > I'll definitely follow your judgement on that.
> > 
> > Trying parameters to see if they fail and then boot again with different
> > options is not a viable approach. That is an indication that QEMU's
> > design and/or introspection is flawed.
> 
> It'll be the same when introducing the new -guest-memfd object per above
> complications, IMHO.  I'm not sure how hugetlbfs pages were managed now
> with Libvirt, maybe that can help us understand how guest-memfd (when
> hugetlb pages will be supported) will affect Libvirt's mgmt.  For now, it
> doesn't seem to me that the new object will help in anyway, if we have
> QEMU's "features" option.

It seemed like the guest_memfd support for directmap removal[1] might be
a good test for how this all look like once new features start coming
along for confidential vs. non-confidential so I've been trying to get
that up and running to see.

If we keep everything in memory-backend-memfd, there's a little bit
of awkwardness, but the following schema should cover discoverability of
QEMU support at least, and then libvirt/management can branch into whatever
routine is needed for probing actual kernel support:

  diff --git a/qapi/qom.json b/qapi/qom.json
  index ee981fc44c..4777f09ad1 100644
  --- a/qapi/qom.json
  +++ b/qapi/qom.json
  @@ -774,6 +774,19 @@
   # @guest-memfd: if true, use guest-memfd to back the memory region.
   #     (default: false, since: 11.2)
   #
  +# @no-directmap: if true, enable support for unmapping backend memory
  +#                from the kernel directmap to better isolate it from
  +#                host activity.  This option is only available if a
  +#                corresponding Features value advertises support for
  +#                the intended use-case.
  +#                (default: false, since: 11.2)
  +#
  +# Features:
  +#
  +# @no-directmap-for-guest-memfd: If present (and if the hypervisor
  +# supports the feature), the corresponding option is available if
  +# @guest-memfd is true.  (since 11.2)
  +#
   # Since: 2.12
   ##
   { 'struct': 'MemoryBackendMemfdProperties',
  @@ -781,8 +794,10 @@
     'data': { '*hugetlb': 'bool',
               '*hugetlbsize': 'size',
               '*seal': 'bool',
  -            '*guest-memfd': 'bool' },
  -  'if': 'CONFIG_LINUX' }
  +            '*guest-memfd': 'bool',
  +           '*no-directmap': 'bool' },
  +  'if': 'CONFIG_LINUX',
  +  'features': ['no-directmap-for-guest-memfd'] }

One notable thing there is the current code only enables it for
non-confidential VM types, so that's where the KVM_CAP_* checks would
need to come into play to distinguish between what's supported for
specific VM types.


On a side note:

Ideally we'd be able to do something like the below so we can have one
'supported-for-guest-memfd' features that could be associated with
multiple options, e.g.:

  +# Features:
  +#
  +# @supported-for-guest-memfd: If present (and if the hypervisor
  +# supports the feature), the corresponding option is available if
  +# @guest-memfd is true.  (since 11.2)
  +#
   # Since: 2.12
   ##
   { 'struct': 'MemoryBackendMemfdProperties',
  @@ -781,7 +794,9 @@
     'data': { '*hugetlb': 'bool',
               '*hugetlbsize': 'size',
               '*seal': 'bool',
  -            '*guest-memfd': 'bool' },
  +            '*guest-memfd': 'bool',
  +            { 'name': 'no-directmap',
  +              'features': ['supported-for-guest-memfd'] } },

But it doesn't seem like QAPI is wired up for that. I guess we could add
that as part of enabling directmap support if it seems useful enough but
the above should work as well.

Thanks,

Mike

[1] https://lore.kernel.org/kvm/20260410151746.61150-1-kalyazin@amazon.com/


> 
> Thanks,
> 
> -- 
> Peter Xu
> 

