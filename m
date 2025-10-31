Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1B7CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEprj-00043d-5r; Fri, 31 Oct 2025 10:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vEprd-00043G-KR; Fri, 31 Oct 2025 10:12:25 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vEprS-0005A9-I1; Fri, 31 Oct 2025 10:12:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVHOXXnoeRM3DVXG187jGkQ+AxrpsvJjXfFLhp6QsZAC1TxaK9xxtmG5/tJ9fNKAT3IEGl1eMzZEdUkiLTIz/BboRUmmdzkgICjo6MjaYomE46i8WJSHMjT9/RlIDaBeHqxfw7NO18XtdOnymd6pm9kFCkdQa4Db35SN8wce19qgLmPm+OHbqMzujOg8kpqyaYfUjF8KmDT7Q1I3i1qtD79bHdIOm7hGSPeT2T5PCyndGFRqMA3VgAq7gxLwrT6BpQKsUjK49FbgJWHW8tvG8ZXS44QtekGmmXVVegWJvIRRaAxfq/i4JypE9Ntl1fM+ekXrkofK9QfbbVP9ZJcCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHde77zbtdVo7Eu2xSho0ntrX0mGPUiBWinH+9LN5Ho=;
 b=ctz5X00Ppmm3nh8cBrfG9a1IvvRqGMT+0Ky36ILFAcdECr7bWq4BoK5cv81eL8TVrRWKT3P/2HqscFI6Fw6v+97zb2H0sSiGWkQu47P3PM5mHtNYs57aqjt8shBuGN+IBfWT6roFtc67l929cx6DS/Err+ZnHYNJbhD0HIUH6m4uP/nX1YCmrXyOr3YFpLC46CeIcZX3ACNaxmALxhQJUFXdtcZqAvWVgnvstNuID5jJe0KB5gRlhYdKCY7Eo7p2y4xN9NgfjLiO6axy3LnevsIsLE3YvkzSD8qZxOWwKs6S2m5NrAs1HzVIvdYlBAZyYxgzV5PLUcxcA32Q7iFgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHde77zbtdVo7Eu2xSho0ntrX0mGPUiBWinH+9LN5Ho=;
 b=LKUcJhK9oMJb/ybymrbK4F4jyqUC3MbpDlH1EAsXkAJ7eZzg1BQE0UW3YnNCL+A9hEO86fsVv8uDXG899FO182CEVxIhcnE/5Lnv/iB7rkrz20zZ/QnfAuiHIZ4nDMPal2PTwHQcu0b76QW/qM4O+mVnsPHusPKpaIoRZGPoNnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:11:56 +0000
Received: from PH8PR12MB6771.namprd12.prod.outlook.com
 ([fe80::67f1:7121:7d5b:94e4]) by PH8PR12MB6771.namprd12.prod.outlook.com
 ([fe80::67f1:7121:7d5b:94e4%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 14:11:56 +0000
Date: Fri, 31 Oct 2025 15:11:52 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v1 0/3] Microblaze signed division overflows
Message-ID: <aQTDqOKzH5q7e9R8@zapote>
References: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
 <982e5492-6fc4-4a9a-b655-753edc365d6b@tls.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982e5492-6fc4-4a9a-b655-753edc365d6b@tls.msk.ru>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To PH8PR12MB6771.namprd12.prod.outlook.com
 (2603:10b6:510:1c6::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6771:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e22cc31-f17d-41bb-2b10-08de188772f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f6HZdmdTdqJghAKeG5ZuLRWc01f9vMKQ/mM83yeWopYij/rq7cmhP3gleO5c?=
 =?us-ascii?Q?CbzWhUCEF013RcH3NRE433yJDJyRrmXhE4VuM7yG1BYbvecPM+I7r1K7/GdM?=
 =?us-ascii?Q?9dVsBwIQtmrA5xVmKSc3CiSAJ88bPGkaMphy6NoCPiYXw+pDmXTMu+2VIsqB?=
 =?us-ascii?Q?gPFjGWHaJu2RR65YsB0MuT9rh8rJGK+ZYvJcvxpdL88Ljk0m1wGtTLlQSt/G?=
 =?us-ascii?Q?IrHFO4Y3nJi1fpGwnHi9TZlpwu/eZRQPVLekH7g3t0K8dAxdlP50ey4AKDBt?=
 =?us-ascii?Q?JPfWNzMM6ijrqV8Q4ymMU9WAXAYTBZ5nctZH1ulfAfCUCwrpO9KaiQydptn2?=
 =?us-ascii?Q?XppNoyolyR2QAGCPXWGPFUYawxBlbyDV8A+/B6NuQdn2KCSegxn0ou7qxtr9?=
 =?us-ascii?Q?SuaHfoWE2RoAk2pnSJwlm429aRNk/hEmTRdRT7l477/8tXY20y7U+QQ90ZH3?=
 =?us-ascii?Q?M6/yrPvsD4wNeYPAo1zXCm7m2QaWNMuCrwcgFJm/fezaCSkGrKL8JAUxpEH3?=
 =?us-ascii?Q?dpTiWTSaaMNzhkmC3hwXql/Jfks/l4pagS6ZezfBx40T+bEMdlySqZUomH+5?=
 =?us-ascii?Q?igzY9hgTJlQpCfLb/R40Z8uYfECZgUYDTrWxeKvXoY/VEwYMHQ/0PFHuODCA?=
 =?us-ascii?Q?VAOnO7HDl7+Es+EfNzqByRnBVW56d9i3HgSTvEQ5uwIxneXA3PNrIj+QhYc+?=
 =?us-ascii?Q?4012yGDLPCLHwIgLa6+yMs4NzKSSgJJwZugeQyNvRV5wxKOiI9y4dSS4zmOt?=
 =?us-ascii?Q?50kXHWz4Th/EzVTIrIQy8lEBC2dSUr0FfjvZU8pMi8aPxzlr5BPErmtzzqpw?=
 =?us-ascii?Q?IrzdLv/SO+OG4OUG5fGG+hZ+sqXIEQKzuzleBKOPrajmIMEwj+ind+AWyYuR?=
 =?us-ascii?Q?jeOAoHXbUg6QV/g1+xyCsd9CYEtotAAme+nsH7HVcc2QMKzbDPH/6QNFhp6E?=
 =?us-ascii?Q?XbHGedC765Keq2d63wWbLe+kiIAi0caBlfiFNNP/hDu0TlBmLaCUVlQg+hMk?=
 =?us-ascii?Q?wb1cECaU4/yQNwwc9o3kqkcDOBFEXghkt2XUHy1vw97ZQAArIkqoouOgZ8Rm?=
 =?us-ascii?Q?HvyXnVpajm/p8H8oKXYf2Fbdy9h/ec2AqNcWAdNN7kmL6NW/Mccez4k71ASU?=
 =?us-ascii?Q?YxS/Bw15t8dXYGwLR3kEHEX4z7fcn5b8ogi210vPAUWrsn+mD/p5QBHs6DlQ?=
 =?us-ascii?Q?QqUUGpadRrb102VzDKGg5qZ0koz7ImXJ5k7//Co1BiqTwXetKFQbh1coDVhJ?=
 =?us-ascii?Q?04wF8Kd9nU1nqP/efbFTn7xvJBGlWNfuUaIkIr2J5tezbSA28ZyQioK9dRih?=
 =?us-ascii?Q?8rYCCLDScRyc2wdgw3JYAFu4K7YIgsV0QpNwZsT17B3qqB9Nn+6di5OzOIVg?=
 =?us-ascii?Q?zb9268BA+0EZ3FVQ5wzbmdU8NxI3FlALVf7+vzpvk5zfzPkQkdmLqfzlfV5y?=
 =?us-ascii?Q?LlOrAbmcBqlx6MkCsMN4zvww40n4eI7+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6771.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGjzta7Q2vKFOP7fwpMSLndoPR4Fw30Og7B0xPKrDsnpGNmfep/qBbgBPw6z?=
 =?us-ascii?Q?HzZiolaiH6q0u0s2xv/OIVcS97DMjFMKOPbgLkmFw/5S/rr96Az7RxqAhDM5?=
 =?us-ascii?Q?stlY/CvgP/NoC4rPmPhumlzf65SVOCQ/BOgxvUq9hDj9bDJuRZYlAOpJgu6O?=
 =?us-ascii?Q?6q6JfucgJ4vzOH5u7/gO0RdUzwNdgF4wwgR2pnHiBcJDZ/XkJWpt9mFtvA9+?=
 =?us-ascii?Q?NzQLcrnCgS6INMDQvDgxzEahcR3v7bbJamDa+8DQ/NO15JBzcdY8VQs+cZJX?=
 =?us-ascii?Q?9Q4jrLMXxe9huoozqWUqmZGbbDkf0jrUn1OXq4PlyuBGRuK7Xk61z2aFnIRF?=
 =?us-ascii?Q?e5SQ77c7OvL7VuKZE+7v7jKCwMD8PmQ7ovCxpfw/A8Pr3OnfntPnAuNsTgCH?=
 =?us-ascii?Q?G+wHQTXqDf/pbfmdsCp8yodP/EyIdhIgzadhKmqgALoI74KXYNXggMhpOlOk?=
 =?us-ascii?Q?ZiG+lBhF53G3gnLzYdlDyX3DZWygqxp2CX+f8JEkN/BaYbVUci5lmLCaSVjK?=
 =?us-ascii?Q?PuZzwGCu3eD6kQS3LXVcjncj0lJSAlC/HtRI33NDGEi8yy2jie1Jg7ctkx87?=
 =?us-ascii?Q?aQ/cOXLO7TYI7N1JnJd980qoEaCuMNw8QbPxWMTVXk/zQbcY1OnvUqLmInCx?=
 =?us-ascii?Q?oAVga0JvohXkb9oLtZ/cR3Gn4SEMRAR2CvITSDfxA/P2xNNtwttwOCaz9fdE?=
 =?us-ascii?Q?BUw67ujk95ve73aFnkyIVmbt0S9qo4W1Lne6YQ5sdxsGqKnGQ6esz5sJxsO2?=
 =?us-ascii?Q?8iwGtrsG9Fak7dLJBH6M3GaPXA27TXM/rbzYpAe7bgmmxZIw0SzXAWqCtfm2?=
 =?us-ascii?Q?8OHTmG6CcYFfh1WLWk4qQASUvzUXFKQeIfz+Nxr/QzQ7lGAcrD0CvucRvLQk?=
 =?us-ascii?Q?ZTPbpqmQDesNbY1Sbc6ckV0CgmQzBa232RfESWga+eB7o4ZsnSJtwF1dkFBT?=
 =?us-ascii?Q?kOfzMHUMUETDj7OkSXW8VBV9JsC+Tbt9gGYID+/m74LLvIoOYalRYJBxs4FX?=
 =?us-ascii?Q?gv7aEk1Hj6Qgf7nwiD+XhGI/Hu2Ea6HE8exSKcHUZSQfSDzk1rm/wfdP0dwD?=
 =?us-ascii?Q?XGFHaBu4P/yyhxg42fB/teuM01GVc9VzpetdmdkiZz/OL9m+1sjWfBKJyPou?=
 =?us-ascii?Q?cr/jt6NUFjXexofJs1Jf3AUaD6CMc7qkR/9saoWJrpR8TfgUELyoEMEK5yKA?=
 =?us-ascii?Q?fTa0Dqne/OrsSffmfVXTHLs8AokG5L0std9ODg3o9SJnFpQD3We8tvEIXM/k?=
 =?us-ascii?Q?dyYTxrEn6LMEibEJpbLWWsZPa6jFv0cOfcJ4p1zzfZX9iAywJFlZi+0VzxPh?=
 =?us-ascii?Q?BTe8fPuuBFj93COCIF8uThT1bqQMOyoulqPhLePihZ72MF09ZsxKm/bGA7kw?=
 =?us-ascii?Q?yhyNafJpKc7XecJkdHc9S/1v2nV04GsygU6UGU/uEKJrDor8ff9h/fNLZQ0h?=
 =?us-ascii?Q?EtaVi2Jha18rvkLpc81k26FZShZrhjkkWjoQ0GFjR/cB3DnDVU25t1G+bM6L?=
 =?us-ascii?Q?r5qVpkWIKViTqeT8vXJXkJwGCXc86Vt63X3exQDLjlTt4Nm55dhAIWwiGy7y?=
 =?us-ascii?Q?0ShanF+LX13lU4vyDgg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e22cc31-f17d-41bb-2b10-08de188772f9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:11:56.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF8cVDp42BLhgLGnri7FJNJMFyXrvBnOFogq9TTaDpGCNECdd2Z9BEVB1nZORQhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

On Fri, Oct 31, 2025 at 01:23:38PM +0300, Michael Tokarev wrote:
> On 10/29/25 17:17, Edgar E. Iglesias wrote:
> ..
> >    target/microblaze: Remove unused arg from check_divz()
> >    target/microblaze: div: Break out raise_divzero()
> >    target/microblaze: Handle signed division overflows
> > 
> >   target/microblaze/cpu.h       |  1 +
> >   target/microblaze/op_helper.c | 53 ++++++++++++++++++++++-------------
> >   target/microblaze/translate.c | 12 ++------
> >   3 files changed, 36 insertions(+), 30 deletions(-)
> 
> Is it a qemu-stable material?  It feels like it is, even
> if it's a sort-of "new feature".
>

Yes, if no one opposes I'm in favor of backporting it.

Will you pick it up Michael? Or do you need anything more from me?

Cheers,
Edgar

