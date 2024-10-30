Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBE0D6B6BF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 18:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6DuA-0001Rm-DE; Wed, 30 Oct 2024 14:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1t6Du4-0001Ok-Jq
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:58:48 -0400
Received: from mail-dm6nam04on2081.outbound.protection.outlook.com
 ([40.107.102.81] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1t6Du2-0005nd-40
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 14:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXKXzr4yTFBwNQBp1i9ZLtagiimI1wzmx32uWawUhEb71z+Tktwd25cUXARbHNuHsn0z13yKls5cUqc2aITYJx2h/+g3pzp/+55dAAfWKR9onuQt8poJMgRyzVbfnDBNN6ITfwX8x1SHEm/XgCtu1rHjGTFSCa9dMEU4H6hkQkeuD93Pzg28cn/PtbCZ5g0OskefNw69bUZ7i05wCQoaunFbByRRcaQPYFM9FngoaW0nTf/x9WwXp7G1bZiY6VsIlidZAoA7p5lFxdtktR+ewmQ/eohMwMRgQPRfHGTHSQvD/DJE70CcEmFezToHLzHHQHu3x1V7CfDv0617cY/Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GiqJ3eoo1I/nerVik9cXXidtMQ6sXRof/TkWZWyXVs=;
 b=L0jqPvyZV3IS7NCI0BHXuL47kMdTYU1iDfqcZ0HYwvgZJdrktYk8uzujPO4hXwxR6UHXqP0IgRMfEEdFNi6Eq8tK2SpGn5Y2RaLyTGdUy2bJ0gJR0yt7ktHg5yuKhaRrKi7Mxq6lHLZj/oF+0YJnpxYM2rWFrebMFaoXbLDLTg2TLzWs4DwtmzwlhUUm2tT0Pi4JV28Svwtf+mYwiBAEEybqfHJV0cNDdDfcWgSePgZLAT32116zlvZrIVhFvrB6byccbN0nGvnrbRrjPII/b52VQi71mjClT28RVj/D7V/SELw4HlC7oRWITe6nB0cuNmSHtxZNAvyTaBtJyVCD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GiqJ3eoo1I/nerVik9cXXidtMQ6sXRof/TkWZWyXVs=;
 b=km+izFB9Y/i34Muahb4UJr363aVNpwACaI+LVawX2uI53weNUkEsuG+Tiqidty4s+DQjN7QBlkrDtj2I076Rg2XuY+Hru+lQD937A9ZoXTiqGDd1WdRpAFkuA4zdwb/pGZhUiC9c3PiHc/vI//u/bzN1u95nnMnpMfJRGwp/sMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Wed, 30 Oct
 2024 18:53:39 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%5]) with mapi id 15.20.8093.021; Wed, 30 Oct 2024
 18:53:39 +0000
Date: Wed, 30 Oct 2024 13:53:35 -0500
From: John Allen <john.allen@amd.com>
To: Zhao Liu <zhao1.liu@intel.com>, pbonzini@redhat.com
Cc: Babu Moger <babu.moger@amd.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/7] target/i386: Add RAS feature bits on EPYC CPU
 models
Message-ID: <ZyKAr/KTkX7vgh16@AUSJOHALLEN.amd.com>
References: <cover.1729807947.git.babu.moger@amd.com>
 <63d01f172cabd5a7741434fb923ed7e1447776ee.1729807947.git.babu.moger@amd.com>
 <Zx82ReAE9h7bLSNN@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx82ReAE9h7bLSNN@intel.com>
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf6d3e5-4b61-45ec-4828-08dcf9142ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yNf0CXLzL0FZW9AUDiaGKu8oidW5cgyK65Fd1U0UQmcS/pVMeiWcqvS5gEo1?=
 =?us-ascii?Q?tKNNomWP+gXvZbfPEI6C8pGiHk/VfVHeFHOwDKOmExvut7HIaHcH2tfKq6H8?=
 =?us-ascii?Q?yKu1I7/5CQDl4FpRYshW0CI4/4jMfiBm7sKGv94CIyyjlMvg23SrQjqj9UvF?=
 =?us-ascii?Q?tJHFBCWG5fgZik/791EScGdbuCmllsWip9O1IRldzEx178hnZP6oIJD9XeNT?=
 =?us-ascii?Q?SGBplAxTjxszHbS1IJ2c1Sbinlylez3WnR9iFi4m2EYa1Z2JdljbgddwJFDJ?=
 =?us-ascii?Q?0UswKbur14tVmjx3N5E9xSKqkv71PoXQfvgByMcPtPRYdL8aacK+xBm2sOMl?=
 =?us-ascii?Q?7TpXfuvByJw0dOXVP+RLD8KpZQS+oAXY+iopO9a5LyaCHzizZ2MjwhvE74x9?=
 =?us-ascii?Q?QRloybFiyvd/3shJId7UeaX6cp0gFDeiP8x0FCAjS1UgkWwhKgm9XxnrwEfH?=
 =?us-ascii?Q?lmYXhv1GFGTR45amSjnYtxvc5E/VRSTdkyzZF5KCh4G9xbhJhoCQNm5z5F7A?=
 =?us-ascii?Q?W6vQdLnS0d1itSa+4vGhorBfrn8ARvHFVfNI9KXMBUEhbSgDjhWD1Ee25wBu?=
 =?us-ascii?Q?ZJ9ioYRbXSVGmQmQTPKNHYVYw7muS7CqMi0qSRj77GCW1X+MB7eBjmfFvSAJ?=
 =?us-ascii?Q?Q97/ZVsL6JhwHyGtGg3F7PPe/2l+ON4f5CZgUm9y2bMMH6C9B7xmVA99nn+T?=
 =?us-ascii?Q?X5vm6GDnqH5EjJHaoBz0Ls+ioxhGN8Cig8irk54KrQufWvqV0Cs8q6nPBB50?=
 =?us-ascii?Q?+TcC9KzA5oJU+EXWQZZltuvFSQG7S/H5ovM2asqllXxMbiC4gyNxqOmK/mKQ?=
 =?us-ascii?Q?ptWxfchr+qWWeN3XUUPO6xhgXJyQFxIcDNepQ5vs2W/9aIdb7fD3uGa0BtPB?=
 =?us-ascii?Q?QZHRayLgVin7bF4XZjiyeQQbr8rEn73oOAKd/UrbIxG8nmMW8FAp8w4JxhJx?=
 =?us-ascii?Q?WAjIxafhy77/VMdutsiVCs1r2dTKtlmYR2n3LRUW+hRPotlHchxcbEFhzRRQ?=
 =?us-ascii?Q?4L9wjKQUaiW+1JlzjapuSz8C2IYQUs70BYmWSgkKyjaNQrYXKTUwSU/jz9A0?=
 =?us-ascii?Q?Z/L7Pe4txW5t+J44UEn+tncJvM2595jcuqtaklRnpJRxAZ17pdPgGyZ3hHOA?=
 =?us-ascii?Q?vvqBVW4mDR/RWRrWP9i7l8CZjS0c7n2zEsW3fWpwuv/JmfpXWa0CLZaWYnFH?=
 =?us-ascii?Q?WvQBT2urZZsT3TeC/wYYhbIB9//UJ9JpXelk7EXR4fLMBU+vhofkyXll2oAS?=
 =?us-ascii?Q?gFlZqCq59TWTZkL68pQXGdOFVI0o85kICBGCZ8wunMFHcf9S7kDZQy8iauts?=
 =?us-ascii?Q?8CnVMC7h9M2b/dojEZ7eDEml?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PfF5HVVudwzAnjYjMEaM9AmpVNQ1BA99i6xSYN+1xNTHUcO0VRWsblcNbuKT?=
 =?us-ascii?Q?ELFPtJ7MPVK7Gv3WBLkJo6e7lcA5D0ag6H4yibLDALrFWZHQ27PCsLuR4ifP?=
 =?us-ascii?Q?L3MFVjRgwkbnoo08THx4pooafCqgbRnJqjhhSKUinFsMUY0Qp3KUGxk5cYsn?=
 =?us-ascii?Q?bwcgr12PnLKh4UASlyUhxDK9+Z5IovJoTBXQALwORU3zXFERoQWv04Gq3a68?=
 =?us-ascii?Q?uZBuklGEukPjMO3EqQryQ0wfmuZw+8Ekll2bOh1QqaAGCv93bYptBxsHdKA4?=
 =?us-ascii?Q?rdNeb8is54imbek/Dqvns8SVtcGsp3LBqBtDOkoRhyTrVgkwAwXSLZzrD1bf?=
 =?us-ascii?Q?BpCcIy78bDqRUeD/tczkdqq158X4uaiPIabU8nN1/fyL8TvzwMpuQYSnt7D4?=
 =?us-ascii?Q?bcveOnm0nv6MlBwQwE9YjBgk06gJMRN7NbHoM2h3XlkmM5XaIMftOrwjsA8W?=
 =?us-ascii?Q?1UATC2wwTR1diNwBLQOCB9b13aaQcFeCJEpkp/gkxjX//yNeKo/mhc3uvWoj?=
 =?us-ascii?Q?PvdXhhViWVcBM0Hvj/kxzpPE4TTG0lTy0tE9ouAdczsX3I9e8gDDoHX/qUfw?=
 =?us-ascii?Q?McEHFyBer3vTxv/zHZxfpPQEw8jVaXSk5Qbt3zHIJFNT094GtRo3U8eV33/q?=
 =?us-ascii?Q?48KLmMvrqtlLark5ArCW+7xyC8khpvdehlEUDNTL8FZPJ4iwqh/eyNv4K65R?=
 =?us-ascii?Q?E/AgTwYpzv/EceoJVxh8+cCpAjs2eAzMQIFKsGzk+rzsYxTRPfqRdaQQVtyp?=
 =?us-ascii?Q?jPYRZYbLudVqHFVyYuUjzl1eF+0Cj07ylt8KIJyvzoUaqlYb9GCalsH+V9ao?=
 =?us-ascii?Q?y68vSFQAa8psJ/F+jXJSb8mDOzQuIAKwyR3CpK1efSw7Kg0t5DfUtEWs/MiK?=
 =?us-ascii?Q?JsEhqSc1gG1UuxkgfIWq4sizUZxEDPB0CF9Jo8WnUwW9bnK6mzFR0eus0k2Z?=
 =?us-ascii?Q?wO9ox63Pq56i3GuK5/wWDBYWEWpjQKx3TPyu0hHzwn9e2717d8GpCmB5P3VC?=
 =?us-ascii?Q?2fOeZpYLHI3g9OEwMUVhTp+0jGBywweTrPO/xRUHQfsa7rXbkXDANELf++2I?=
 =?us-ascii?Q?aoOB6JF08puHI7NhUfeo5LXHZ2E+CvyAfWo5WA9mT2SIsI5Mei/77xmg1ahw?=
 =?us-ascii?Q?JAQE82c8pZ9ARu7DtP8U0aTgoWTIz82zZb4NgaqJO6t67JkHwmepKZgik57o?=
 =?us-ascii?Q?Io7/24sMhvXHRYmjW6kPnRVzD0ZajAG5lg+aLHOpdWuFLlZGWP2U5i8rAy6H?=
 =?us-ascii?Q?jkSsKg306E616MGvLvEsv8EX1o2+S/2S4kGv6D6dKtsCi6Ye7D2a18ecz6d0?=
 =?us-ascii?Q?DifpAdpD35lWg7X1WCss74cKViPN1sg37IHnOOTKIOP7lEStvdmnHGK/dK23?=
 =?us-ascii?Q?kMtYKb7yf8oikVl1tfpo6tUSlakhkws1IKjVlMYfwk51A/Uzygc9vuWwhs6m?=
 =?us-ascii?Q?8IZtEaURG2uMPB/sOi6y0UM4ZOgKexwFJNbzm4C+7j0bHq+3eYjMfVhV69IG?=
 =?us-ascii?Q?t6HLgzYis/C6hfOYfZyGez6G/733LjE46/whkR8CfsmpVEHkXp3SB/Am0z3G?=
 =?us-ascii?Q?vi1nUB/bwLmgLR6AlQP/1YqGmTYWYNxrkGSi0ZaS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf6d3e5-4b61-45ec-4828-08dcf9142ae4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 18:53:39.5813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B63aqgOWbzLTT6PMjn27hFpQOa+R4SXreWFWi6chY878fybYixg8rEMB3Z2AHExrNENtPR8VToMdhbk4iEdCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
Received-SPF: permerror client-ip=40.107.102.81;
 envelope-from=John.Allen@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 28, 2024 at 02:59:17PM +0800, Zhao Liu wrote:
> (+John)
> 
> Hi Babu,
> 
> This patch is fine for me.
> 
> However, users recently reported an issue with SUCCOR support on AMD
> hosts: https://gitlab.com/qemu-project/qemu/-/issues/2571.
> 
> Could you please double check and clarify that issue on AMD host?

Thanks for the heads up. I can reproduce this on an AMD host with
kvm.ignore_msrs=1. It seems like kvm will need to block this feature on
the guest when ignore_msrs is set, but it's not clear to me how that
should be done yet.

Paolo,

Do you have any ideas about how we should handle this situation?

Thanks,
John

> 
> Thanks,
> Zhao
> 
> On Thu, Oct 24, 2024 at 05:18:20PM -0500, Babu Moger wrote:
> > Date: Thu, 24 Oct 2024 17:18:20 -0500
> > From: Babu Moger <babu.moger@amd.com>
> > Subject: [PATCH v3 2/7] target/i386: Add RAS feature bits on EPYC CPU models
> > X-Mailer: git-send-email 2.34.1
> > 
> > Add the support for following RAS features bits on AMD guests.
> > 
> > SUCCOR: Software uncorrectable error containment and recovery capability.
> > 	The processor supports software containment of uncorrectable errors
> > 	through context synchronizing data poisoning and deferred error
> > 	interrupts.
> > 
> > McaOverflowRecov: MCA overflow recovery support.
> > 
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > v3: No changes
> > 
> > v2: Added reviewed by from Zhao.
> > ---
> >  target/i386/cpu.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> 

