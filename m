Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C10C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxrZ3-0007XS-Op; Fri, 19 Apr 2024 12:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxrYz-0007Tx-Mv
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:58:13 -0400
Received: from mail-bn7nam10on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2009::701]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxrYu-00037C-QC
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjY5fM37SyR+u30tGJcKbrwoDU+MHa1fL+CzO/RBmxbgCNyXv/UnVTxzPXO1dPb3cGxWF362TN5wHicZrNg9erwyV37zVzECZCo+dA6AMeAZCdu8AI6e+6aQRPf4xlbiB+e957jXG6cy7MR451e5ZHa87YOWHUYqLZS6XiizQcCrs8QOsQ3A3+7RyKX+iY8IM7xyTN4Djkd7mtBk8RW7obXZ9yJrohNTv+Wwej30r6Xmkw8WpdR5aV5CPIBjizfHzkGj463PD1pmP9X+R8fISglbp8cUgU1jQG7oWduy47AumkX2yKKDUM70BjZzcCOwsB3BgG71M5DbBRayzFcPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWwT+bP1AOazP5FRFoMz1TxIfNw7y8T+LeVM2hgWEz8=;
 b=eTwdVFE6n206+3Pyfzd3gDWMpFbWU/B2mlGiDhvNRDGneehtMyE5kVmhSUodE8ZpMV2MqCLjd0yC94A7cCDHRBMQd/KbhtmSAs4zeHOTN86+Y+HOsVnV+qqai/JEl94yrM8sznvyINUG1l6bk+UfjQu1wqeXBlTfyp5GPk3Sf97IzsUu56rkrsGWTey+DAtxSoz6NsyhI1dJB55tUYFroX+6ZuXgrKgnlwrnj+m2xDH5kpY7SdL1hPhmvhm6E/z+QfhO+goP2VUWomXV+sIndonVUKFE4lUcCgyh6R0sCF2e388IkdrG0zZQScuHRyffA0FibuQQxdCJ0sheu38yXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWwT+bP1AOazP5FRFoMz1TxIfNw7y8T+LeVM2hgWEz8=;
 b=gI03RCOKwCwbKolRh1k9h4WWmpNnBxUpA69vxYSx1PgTdnjt/8MEdfXn6m48Ie9r/QVqiWJKiKc6nx6SrmqqspYtPRm7/StQFOmxaEiTo0XxSj40lS6VlvaAsZQ7ZEJJKcneyPY53iwMrJklBGbEW75AFVOH/OLlF/5DjjkiBNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB4720.namprd17.prod.outlook.com (2603:10b6:510:88::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 19 Apr
 2024 16:58:04 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 16:58:03 +0000
Date: Fri, 19 Apr 2024 12:57:59 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 10/12] hw/mem/cxl_type3: Add DPA range validation for
 accesses to DC regions
Message-ID: <ZiKil1/fqBesVO4b@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-11-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-11-fan.ni@samsung.com>
X-ClientProxiedBy: PH8PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::15) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: b50dda78-9df0-40d5-b8f0-08dc6091e0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnol2o/PbbCaniq4xCKAr7RACFVaQZlFsNmfki41nhX0N+8YTOnL7sh7wy01nlbNovhl+v/lFl1BmFuNMcylKSG1AJ28L6c/k3xvDvN8yMtgvtycsletDVH0qdtVLXNJaE4JRiKAHsYkF7+kp2zVQvgTuLeOJSQbQpr46ocvvYv61nnWwxY3hCBRnda7umpnJlAv4PvQttzOUXahQL4VGmyrRoSc+VqwdVehOlR8SXmwzauhKAVL7wYj5IJKxNMACS/spGylE1S9FYo6bFfTi+tgJOlTr6l73TxeZVtczpywQXFAICIsrZ8nJdZPsUawlaeC6z+9ejGDramHT/BPfzKyTFclkytu6DfExjCSmwZjeVFBWOyhByizAhPOrMyQ1fjDgwwb2sXwxvzR2wmAj2IHcSTjM8u3Rp52ELUABdEKjWPovsir2Auy2BVGq2vRbV65Z8vCaIhvisvTKLuULr/rQZDMCMnolXQjrSEGunsxdg+3fssXsLdM5j6q17IF4Z9xEeXE7sgUVoeuhAGm81XAPDb+LqeIaJrdy7D0jW4F3sMcTfjESVLFufTWO1qVGUOYoBK3LJmjuRWYEnKgl1SqDZMAhn8n5RPo59ZG1pvFMbwMJ7ozgyzEIHy5M4RMae71IAv9fDadxJow6vEV8QdxWGo9EpI/W7vLEvWUNCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8iKXvhRvvbb5Zg7z4vAu0Kj+aETM99smPSAkeax+lnA/1DNM4aAgETZqH/7m?=
 =?us-ascii?Q?MPeNjcLQO6eaeDC2ekaf9w2EycZCqYY1mR40dQnODbCpT2sB7HIrVHuzp6du?=
 =?us-ascii?Q?SF3qlkmMOv7Q6zMeX6zlb3hJfHQn/Ks3eE2HbLc8lbMb1II+00fUjRtfm78X?=
 =?us-ascii?Q?SfXkvz9Fl+0o47v9MFeMsdNdTW6KTybAQ1bHvXXqaspmhqYeMnEV2xM1w21I?=
 =?us-ascii?Q?i8PsRS26FhHfyZd6K+6YIoT6nyK+jgM8n7iLHA8gkiVKVnB6JjdsP6pL0IZM?=
 =?us-ascii?Q?pnzS1GNX+sLDqZ639Jcp6jiefWblTo045HFMMIz8J9PcALT8oizt2kbs3sa6?=
 =?us-ascii?Q?qyfLyp88KZowpg9PphyG8zJSCiZ+W5E9N/dBcYnNIPIRAPdapmO/MJs72tsy?=
 =?us-ascii?Q?WBh9C0LO5dWd4GetskPblBurapShcNlxNi2YFF8Jv+NUrsSawsX6MoSU8Jx+?=
 =?us-ascii?Q?NxtC5moS+rFaoBmDyzisi0y3aPiveFfE+B0NzvqPWU6iPgw9uqNhN2FpSwXX?=
 =?us-ascii?Q?td/G71A9auTi1Y8ZSWnikcSah0xaau1fsfKm3Feg0PzYL8XfkKPtG1sDJ24x?=
 =?us-ascii?Q?Ma44p+Qox2hrTkUPz3KQY9zJWUzazP7F0HMPMKnUAFSowNO/lWICStS9HHJX?=
 =?us-ascii?Q?k0O9j+XJjRaK01tMsz8tiVe+UUCR8/dstY/OZMsSUpuRc5raQPMm22doag3B?=
 =?us-ascii?Q?0ajbJnhT410UDPuE+YlEcfNxX1h/aQZwULKQroA/g5u6bL+Wqhujh5Zv0Qgg?=
 =?us-ascii?Q?o8l2vY3BJ31XYlN5Hg297anU1njPMzRJAccA/65fksPZk/7gZzyPTipszObv?=
 =?us-ascii?Q?DfSC5epG6zWnRHuW32u0wkxHyPlpDW75bdvIVC2NiW8kcw/PYyzUv6Z6RiKF?=
 =?us-ascii?Q?y5b7HN5xDUKONW+dR9Jhr9Wuhu6QISg3U9xtWQWXK83D5HBSV4zfkhqLRhdg?=
 =?us-ascii?Q?bF0y0eDS1A+jf2T2RuMW29AqhwJ8CaUWmk1Ka8qkHWgSjRs7JoxxrBj0XSLz?=
 =?us-ascii?Q?cbmOzumwjGQUtgDXVTnzPMT73vgtyuruB0kPn0wV4aiQNshz2k7PemPe2sXg?=
 =?us-ascii?Q?EntaZUApMXHJc0Y17ziMfOzSRmODAB8bU0Dgah/smueCypZ+MdmpdK3y/PS1?=
 =?us-ascii?Q?p6csaLc7RiQf0ROwppbBnG+KV35rSeVZ+UM7dkOmAYi9trjYmkTw7qeG48QD?=
 =?us-ascii?Q?z48hWkf80gnticm3pyCiIa9Pl5cjC/uAr0xuiqOPJhuoX9jBvIZYLm7hFgLY?=
 =?us-ascii?Q?mPWcTIZ3JGEXJDlMFJimgrSHfHR7vPGeTO2w9W/fFLDraFF5pcXgPdQQvITo?=
 =?us-ascii?Q?4Fb7cVySI/BurWKB4ot9ZcimennctdTXNr0cqYAmg551mX+9SSVtlB6buSFt?=
 =?us-ascii?Q?KAyLhI1Tyr9hzABYovm9DVHv7NW7qWiHtYrMtSQGeia215sSr7aFu6vhvMZF?=
 =?us-ascii?Q?RK+z5b5Pf4zgtU6RqVYzsj6By1GDqTl+dmuDJLlEzIf02iOzWZfLM5n5t0ru?=
 =?us-ascii?Q?4/rMOK9tyY2gk+50WPslQ41lDdW7zJ9/5tYeK3m3/55Bt+/RnavugL2fBWET?=
 =?us-ascii?Q?zU+p7NVHQyPRUa6HqE3DKyTkkKdtkPlg+IKBxBbSzCH3hM4FjIpwpVAAvpqu?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50dda78-9df0-40d5-b8f0-08dc6091e0ab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:58:03.6665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DADHwhGh+MnflnL1bM3x95gHIJU2A58kG2UW7jByOBRfPXFIOwmbPNbprnYREYIwsD5NUGys/Fmw6OPzfsW1QocUhmzgKKF8keR6+supkgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4720
Received-SPF: pass client-ip=2a01:111:f403:2009::701;
 envelope-from=gregory.price@memverge.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, Apr 18, 2024 at 04:11:01PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> All DPA ranges in the DC regions are invalid to access until an extent
> covering the range has been successfully accepted by the host. A bitmap
> is added to each region to record whether a DC block in the region has
> been backed by a DC extent. Each bit in the bitmap represents a DC block.
> When a DC extent is accepted, all the bits representing the blocks in the
> extent are set, which will be cleared when the extent is released.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  3 ++
>  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  7 ++++
>  3 files changed, 86 insertions(+)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>


