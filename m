Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01392C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 23:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvPsF-0003r3-K8; Fri, 12 Apr 2024 18:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rvPsD-0003qp-AX
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 18:59:57 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com
 ([40.107.94.97] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rvPsB-00032r-MZ
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 18:59:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFyRl2XcPjyQpgA+Y94/hpzgmGr0f3y715KM8+Ad3Zmf2rbcHvGVfNVeKue+S9JM/PZstt870+wIrVUb5saSBaXP2H2+DlfqBfemx6vmVTOZkTY46ITGQiBNsuN2dE4ukpRZg7aS8joadcd6UuReJs57IkuQ/3IaQFiG8k7RZ6Qlm29b8jQGAWZp//rCM/2FoQCde7uEKb7ut4aUk6perPa4Co23u0c9WKyLBCzUvutP7gkUq00CAVuHAS0HbiSu8NupFDiZwEMz8y5k8vmn/6PZY6ayFaOnbDi6l7EJlnKsPDJE81G/oKxmKzkOAEXDVrzMQVsm8IGyVigGnt9Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLq5sxbm7RmDjFL5VRnPOV4oIAc3W4RHcZAYqP73FVk=;
 b=ntgz7etFkYSltkS+ZAd2jKO67k+nYQ2Jkzi78shP1afQndoPdNox9leEwOwR5MiPDS5uxkHuQPBQ3WnCTwxhmKAmyljhvpL6p/1pfJc4Cl5LqiNmf3aKRwNOOuntgqHnnDRag4qyyzlIdQ7oAa7tNc70gPzu56Y9GK1bVmYBqwVj0vqGEESkrhHd2NG51cSwvElYxy+dzEpQ9Pt7uKy4lymJ+BWXiu/4J6xMbgJ4b2f+bS2TGLjMy4KAo2aIjjSynmf7IRVZyLAJLPAA0mRnN1sSuRmdD+GDX+IiYkN9H8Sua1Z9bgERnou6WI6sPdPPJeMH9f1Mw0oSBEDA2W3FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLq5sxbm7RmDjFL5VRnPOV4oIAc3W4RHcZAYqP73FVk=;
 b=xYMdGhl61Cqzh9AFhN49OOwtzbEcAfdPusrglk6NFtXIqtcHw9JjM0HMBlvkW7trV/3horpVXacqXFuHfMjNzVjAB9jLGt8h6LGE5+2gG25mCFl/GK8CkxWsdnEpK2L3s+FzUTtzb8KP8egH0NpCPSqoqTNKeTDoukx0f5EQSac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB7037.namprd17.prod.outlook.com (2603:10b6:8:127::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 22:54:46 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 22:54:46 +0000
Date: Fri, 12 Apr 2024 18:54:42 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <Zhm7ssKVGdGlR9Iq@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325190339.696686-11-nifan.cxl@gmail.com>
X-ClientProxiedBy: PH2PEPF00003850.namprd17.prod.outlook.com
 (2603:10b6:518:1::72) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 9385b449-6e6b-47ab-a075-08dc5b438cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 108n2QzEBEE5gh548Z4UHatffyY5BDxkjL/ayca4NP/auTbWGRzavxB/TiA1zfAJfyMswuV1erhEZ/IiweyRFLo/sB2v1/68vCzfHgIqV0/yyhlFEsWBv1JOrW/tL1zD37AJREYSUALxKN1vkJjhwQCMuHzFEa9L1wn9SVMtT+B7D+4ZO/UvdKART6CITwmnOhLnmPdu1w/Tm2+JHHMILtM/sX7isjiJRFRA09tqaQ6TDAZb/L8ZsSdY4rp66uNwMsOoxTtJ2TZQzq8xqfiIa/M0N8Z7FqKxl3Py6gX1wq9ETKy33Z2XfWCvbZvGzV7Hs4Z+sTeh4J7M8aqk+1Bth4LhtWUiqFdFQBYppkZXJ53EiWZhuGJfn+JwGxbsMs/HdIigw01s04V2wHym1Q45FV4+k8Sspos4VXxKYUCvNgCnErWKzhvzcnXa0TLgxOItojbcXmwLKHdOdd3HUDWVTj3RKDdUoRsx372UBixa2rOlzUbZseJtqu1foMmIewyv4omPrzT4F40Z4v60gNs1Z2ZWS9arL+n+M2vwCkfYUOeh9pM1c31TN9IV6hK/W5ojw1Efor6coVxgnlhhqjv1ucknKIs25skhrwsiDqWyOp5RKxG10tqJapRMqB2COAz5mTS89Eld1vLtCqWdBj+eVhdQ4GpEfb+hv0wcD4YunNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FISanQxzyGASZKg0fZa9iayHx2s5CDwR56geTC/30bN4Sr8ibYIuZIT8aOKT?=
 =?us-ascii?Q?6HCAYyP7I75C2QgptEKpsZ6yP++z2bipXuTzMe0iZK7OJTe92NHNex5ioXc3?=
 =?us-ascii?Q?bSf4HhybHaWAXCg3XV919KVxw7sONK2CosYEtZAUHYOzyTtdmVHEziyMVTMl?=
 =?us-ascii?Q?jv++s2zSqQwjpR1dIiGZ1Ly+W68zUNIhoYIfRaOMETyHZN/TjwsrjSFxSAVG?=
 =?us-ascii?Q?Nna5NN0sz08p+Vjflue4ssyQeBVwTFTSPSNPZFL4crqMGfrasJrLM0lBqHTL?=
 =?us-ascii?Q?+TgIbDaDQoGBj7Ca+2jXNNRayRWVhERKmFQJEb0trxmgjkVFbyxrZMA/8ee2?=
 =?us-ascii?Q?J4ietaY1bc58Q5mf2FTDXnja2hE9w5JIhUkx9WGQRZANy6bUAYpzUYxaPXJA?=
 =?us-ascii?Q?YQM5YFFaBIQwe7wctXYxY1Ll1/rW2UyBZBlPAB8KjLfB1bqxykhPypNh001E?=
 =?us-ascii?Q?rQ5dfAbLNCxw/74RjMb471J2OFtq8WBOVQCt9KLNaKqJbRn5TvmMTbQ4TV0E?=
 =?us-ascii?Q?AOy7TOgL+7Zi6E+pZ3QZBo8oZbAWrNw5iKtbjoxVZ/DhLf4Xu0s1gUOQz09q?=
 =?us-ascii?Q?D9CRbp4TcaqPVsTRQ57bdWQtnkk8mh7AvHZvClUCUsNfwkKXjFOD8GMZtx6r?=
 =?us-ascii?Q?3/sSS6pjut06idHTxhWYuZh6QNEfxy7mkq++XmVIq2oU/1wtk3PStY5ytxvH?=
 =?us-ascii?Q?sr2ikOucf9ENg0PIwj4tpwAShRALAjKjDVSSupocHQHSf+jUvvyuaU0HRRJa?=
 =?us-ascii?Q?UWPadMbEiuVjuzCwJGoWqlu0VoCT/VrJbgBbTwUlrinHgiYnVOBZVvmBaBzb?=
 =?us-ascii?Q?wWQnyfEE+kyHNeaml4PaDyLu1Grhmr1Ih6w7b50+wnFgDfaHv4MQjHnsLtpd?=
 =?us-ascii?Q?NQ87iZXvZC+bvW1dTIP2bva86vHVxx8m5nGYmuIyfICoOjRN30eIWHK5m2mM?=
 =?us-ascii?Q?u2oE3maT0Bk6FU9KlIMllMQXH25fLZg2nVeMZp8Ke6NlIbgfBXiKFy0NGE1N?=
 =?us-ascii?Q?RMttaV62U81AgJ61S6MUSl343mMWcAA5WmG57cLnmwcf3hPPVWwyS4CrRgr5?=
 =?us-ascii?Q?dw2lbHsWZ4o7ryDCAK2A0Wk3F4BQy8ulke6FdCAcPx+o2XQrIw0B2LIlFtMG?=
 =?us-ascii?Q?3ziQAHMEnc15KTNd7RunlOAGfn192yc8oTg9Eslf0o7yMMrezJHLwWwJu0Iv?=
 =?us-ascii?Q?KhH86vQcA05oR70+8wT4v0SU4d9ljvy1/ARnztugaQz1AVSlM7UPKoLuRJz3?=
 =?us-ascii?Q?U0tsRDl4KepRXBNlfmeTrfZoalYITvUXSDlPe/fSQYC2avPBdf0bqH1SjSyk?=
 =?us-ascii?Q?lpvG9bYgzJg5Bx1cAPVyPXf/1DOdCBZxR8cN4oWg6UvmN90TGmfIRmFf3wqp?=
 =?us-ascii?Q?NSDg0wRgp7eidOBbZ3VfhntG6qifXz9qodwqbW8tN6nQxsXsW9nXSPjRdYZq?=
 =?us-ascii?Q?hMypZ6sZ0HAJ/iVeDhNgTp8o+kKlWUbfL8uNT5uL9kDjnvuLlGh5GCGb0wfO?=
 =?us-ascii?Q?ftujdUqs0eTdtmQ53Q5tM89InolXzaSkKv/M1jfkz9esBu6bcNIOIae7ihTX?=
 =?us-ascii?Q?3fxIOwHlrIjrhsNnnZV9iH35orJn0jmvqBEpom5G1hZ+vqgONHqv7uNiakrs?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9385b449-6e6b-47ab-a075-08dc5b438cb0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 22:54:46.2810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unMLEMLQFLMV+/T589R8cdkmPNKTVUCoEQqQpiTzXOP5PNCSdhFVesvF22Xlk+omBFqZ7yxTAHSjWVufXVcD7AgKXfem5aV2XthDmFBv2rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB7037
Received-SPF: pass client-ip=40.107.94.97;
 envelope-from=gregory.price@memverge.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> All dpa ranges in the DC regions are invalid to access until an extent
> covering the range has been added. Add a bitmap for each region to
> record whether a DC block in the region has been backed by DC extent.
> For the bitmap, a bit in the bitmap represents a DC block. When a DC
> extent is added, all the bits of the blocks in the extent will be set,
> which will be cleared when the extent is released.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  6 +++
>  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  7 ++++
>  3 files changed, 89 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7094e007b9..a0d2239176 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>  
>          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
>          ct3d->dc.total_extent_count += 1;
> +        ct3_set_region_block_backed(ct3d, dpa, len);
>  
>          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
>          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);

while looking at the MHD code, we had decided to "reserve" the blocks in
the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
prevent a potential double-allocation (basically we need to sanity check
that two hosts aren't reserving the region PRIOR to the host being
notified).

I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
to prevent pending extents from being double-allocated.  Is this an
explicit choice?

I can see, for example, why you may want to allow the following in the
pending list: [Add X, Remove X, Add X].  I just want to know if this is
intentional or not. If not, you may consider adding a pending check
during the sanity check phase of `qmp_cxl_process_dynamic_capacity`

~Gregory

