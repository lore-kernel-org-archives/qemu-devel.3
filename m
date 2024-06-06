Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63297C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 16:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFFd2-0006uE-5w; Thu, 06 Jun 2024 12:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sFFd1-0006tm-Et
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:06:15 -0400
Received: from mail-dm6nam04on2078.outbound.protection.outlook.com
 ([40.107.102.78] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1sFFcx-00033j-5L
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 12:06:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laIuLMVl7dSxq9VNEd+Ia1nQoPPauzGxdsr7ILRcMBdvH/gjJzD3h1t3FdofUekqoegga88dQmnRltjEpsnWOZtfwVxBSdTHzqgcxUaDTZfZe7+GGBh2yhrO78A4nVpOAXrwgyISeLlntyr8mJJ0c/EIYzeD4WOvdR2F84f0SofZAYIugm//KFvJNKpXWr7Du6PI8FqfCz0E0O7MwNFWqU5KmM7eymHzjvwhLZU0jmR+kvm2PM8FIs02DxGuLpY2Xm36DJuOf1bQvq763fJOO9opKukVE2gKkPV+46h3dOs577ZCy9LJxNczs0kM2Remdk4INnZNZHPaeM9J4mT5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDtKkK4+rnfpr7EBeXhopT8sBGOaaQfWgDixMBjwXsg=;
 b=oBfB1r0lfElTpbfZaMCtprFqG+ZwMVY9igQavj4UjKngtajOyFGwtMI0jGU3WOvtPd9eqoTVzs2GcDrKAIX33xOWeTnjzN+R/Y8QAxMSvyfddCvsBtHnzOSs/y6o4R8GomlCJe0rJAhVVxCp9ZM7vzyi5lPWeC/edJ/BihJGs+ND+f/jNgsWT/qvBXhXWc4b8JqLFfXB2eqZGXaWd+cjsjCOMl+jGWm12dIkUrYMKUxGmeoq3zLrItbV6FtYBUvOD+sQPkT8ati4eUpgk7CGYC7l689kFVqtslBLLt0pP0DD8DCgfLUq6EDdyofMj16ThuKSyhp4eruA8EP1Qkye9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDtKkK4+rnfpr7EBeXhopT8sBGOaaQfWgDixMBjwXsg=;
 b=v36PjGwn9TaCluu7rTY05cLM+ghYetGReauSw4RmpB0ux2TGG0AEaohXGCiXD2Z0TdVS9CCb+UXQuOSCF9/KPF6tShPogfZvmRBT5SR04pMltD57HoRO3XxzViumAjVqKmLlTmw7ndCihw5amuIKymTTW4AABZpHCNZ/qine0wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) by
 DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Thu, 6 Jun 2024 16:01:02 +0000
Received: from DS7PR12MB6008.namprd12.prod.outlook.com
 ([fe80::4aa0:3ad8:9aa0:d1fe]) by DS7PR12MB6008.namprd12.prod.outlook.com
 ([fe80::4aa0:3ad8:9aa0:d1fe%5]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 16:01:02 +0000
Date: Thu, 6 Jun 2024 11:00:35 -0500
From: John Allen <john.allen@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, pankaj.gupta@amd.com, william.roche@oracle.com,
 joao.m.martins@oracle.com, richard.henderson@linaro.org,
 eduardo@habkost.net
Subject: Re: [PATCH v5 0/3] Fix MCE handling on AMD hosts
Message-ID: <ZmHdI2SbXiv173fB@AUS-L1-JOHALLEN.amd.com>
References: <20240603193622.47156-1-john.allen@amd.com>
 <20240606090903.2464525-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090903.2464525-3-pbonzini@redhat.com>
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To DS7PR12MB6008.namprd12.prod.outlook.com
 (2603:10b6:8:7f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6008:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f1bedf-8864-4745-df52-08dc8641d1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ziAHe7o0hjqFHWonuyGf5u3RPfRYBRcXuNW28PHV94UcpjRVsNBPI2uSbimL?=
 =?us-ascii?Q?j+hEc1V2RzZcdeVnByn3UWSErngvmS8RxFc1+msB53Y5a8fByQAc2mZyqEGJ?=
 =?us-ascii?Q?nU/yerlsc8HfrGe4p4w4gmI8LXrNLoOqm2gf8pU3eXgdLzyMDj2vfba81/rD?=
 =?us-ascii?Q?YVnWdsGb3lRNBwIbequi/UDupwzBov5ykHo8atETFflHbnKR1eWThD/UiJ7k?=
 =?us-ascii?Q?e9I8S6MK5SO58Z8yiQeY4thlb/iMDGQ1XCGUZG4y+4zINxQqq4Lg88/1xgOw?=
 =?us-ascii?Q?N8lGKvOmKnW+0PnAkJxzxRxpuyhhzvyWxi0xbAHk9spistAwuAbq0r7mTiUl?=
 =?us-ascii?Q?GtWHdVQeoYtWtOlHpgtuTDOaBriBVmOX7sCeAYEXoaK96+IRAtz75Xx5B8t/?=
 =?us-ascii?Q?N6Nbe9NxoHpzGEpVNHCL2sTDyTcU6L11eV2rBO1aZZ+FKZEeQR1r9Qsra9lA?=
 =?us-ascii?Q?07fChkTIUeveBbOWJzCy+eM70qU8H9LLH+IGmsXXBK+5N61D3ZuMDSajW2JU?=
 =?us-ascii?Q?R782DuyAXTY58jZqbfpLRICloZtja4faS+EUisaH1UBsD0UX9O1yUGw3X3RA?=
 =?us-ascii?Q?PnHotygXTkqxYMznfkmhOvHW61Kz35Pb5x9/C3pdkKEyCAkwHkY2MosdZz2h?=
 =?us-ascii?Q?CdySvbvIPKhjPn7Ahz9F3EjFAXCe0PdBWjZ2Ifa05XjJRKSlFriJUIMKeue9?=
 =?us-ascii?Q?uEf/bJug4ZnxoLUsLXqCP8ps6lXP6imB+riq13lrAZipfpvErD5cKAUJn7h9?=
 =?us-ascii?Q?oJdYCS3fZST6VoqTHcWzkctJrBmAljG390wyGb2LVE6k1Sb7tQQrsXjZFk7P?=
 =?us-ascii?Q?YzH8pDKWvzDHR906Iy/4vnFiFDamWitNznV0d7zwcRQqLnchPvvmD86mBJZp?=
 =?us-ascii?Q?sXc/cpJbTVGAQi4BGLsim/puURxV5wRMCydbIlBm1GmCS3wSXUKx4TPirzUU?=
 =?us-ascii?Q?wluPLGeEkbSsnLHM1B0+NWVpfe6ckH0EcEpuz4md0INIVu3WbBXIfd2YTWnG?=
 =?us-ascii?Q?mg70v4DWuW4PMtIrvXJy7bm45C82FWpnuAsidSh2TZexfUC4HdiKEvR9uw+G?=
 =?us-ascii?Q?pYVv3rnsLXSXmWZPp8qiniI1M8/zQMBKxQbtN8f6fxQXyO7iO3j4cPO4fTId?=
 =?us-ascii?Q?cbK3jpIkhbjD8fNx8Gc3Z5riwqYzs+lkCqn7S9WKI6+aq7mgeQvBcvmHHT7A?=
 =?us-ascii?Q?RZk1ERuPrpAFPUb9uITMQIa/xaw2q40+oFjjMN9YBSru3TKNKrcqaHKdcp01?=
 =?us-ascii?Q?OI/62QmrnmRh+sq5/goZuIsnpBRIDo5S+eXMDrSP4aYfBhdu+X2g8xyJkl+y?=
 =?us-ascii?Q?Me1URoaT3xdd9SjSB6NPNKBf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6008.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hdc3XaMKVp2f8bZkf3cMvCOqZgLP9V6TCI7nhQOYGEn2QUOxQyQ1ZyWCKyoy?=
 =?us-ascii?Q?8aox1R0yhLaJBuC9O5+C1hLy2xN+OgLBqgn4IMxEjCltJJQoiEyL5/mgIDLQ?=
 =?us-ascii?Q?VydIUZZEHiB2Q3CFlGEV0ZuwbP5uUYdgXfj+KZVY1IWhZwxPvlqLKx1wApYD?=
 =?us-ascii?Q?zU3BJ1lnrRoxcpj2N2nRu8fV/pXMdY2/wY7RQiadoFoSL+1ALRBoC9uUaji4?=
 =?us-ascii?Q?NEQCo6NqKgOM06DexDhry43PhfuTD5DnvxMOtDaik/D0QWf9PtiTn/yKPUiB?=
 =?us-ascii?Q?ZwiDrduxeDraK8xfBGeoFkkUOKgL6iwwFOFQtcilxL6VXf7yz7FU8b0vX0rx?=
 =?us-ascii?Q?v/bC2s3xxcKVsxZJpybaPBBAXaEqeqmYsEEVczgjCxTaSL62dRighDLWASG8?=
 =?us-ascii?Q?lDlYYfb77YCi7cqAadbLnFWtIHqehKkpCJc7nASH80LpPwwFRwLNWmXY4cHS?=
 =?us-ascii?Q?z2zfhoBoK3Ez07XkmcAanPXEKvOXZDcgaybEGc3dGnATXG4UGnzUH4ZJNCpC?=
 =?us-ascii?Q?A1cO1YYiu8YYHu7IvFFvcnNEQOjVQoiicrO8u2zv/U+VeFi6oaNCSMcPcqXJ?=
 =?us-ascii?Q?Y8uQXqaRM36LROflNQPOVJ+Gzg6tx/wVL+VXBWDWPRvnou2ivP1jqVxh3ba0?=
 =?us-ascii?Q?tjVZD/nPL2mCVqKgU9KcZbg/RsH6zlC9WlddZf2chdfX7z9eaNU848Skqed7?=
 =?us-ascii?Q?oWAn9D5QL09bwFwPrtx8hZPeCYb1BwC0pO31UAQhCYYjK0NltSvX7wWArN+q?=
 =?us-ascii?Q?wVGZezgRQ0SbaxZMRFzKGEKIYusFmu3tMS0owLH2920KnFOxEkYZ6dP6TOLw?=
 =?us-ascii?Q?iQuwV3WjO58aUEN5/etIw5fSfDcKn93RM3mSM6+L6UgWCKWBeIn0vzEsKDeS?=
 =?us-ascii?Q?ZTLqYyqhHbSI6lrIA5aWzkm/gM+LJppOjJu5pMNVSTQaskbv/XJRYYIvlrjP?=
 =?us-ascii?Q?xgGe+1RTsmND5kpcTmJgL0YA0qvAtuZKmRFzYZClrmtJ2z721s/gskJPOsA6?=
 =?us-ascii?Q?UR5H7faYE7/QA1AooGqfRLhU0LFQUFbhpMFxxzlHTMJr6PYJTEb1UHJ6OEvz?=
 =?us-ascii?Q?cmQkKnOnNYU5I78UgNxEj0+1mgZ3GSuJcVW69+5OIxHvDyxfexnOegt9xZgv?=
 =?us-ascii?Q?CfEgaD7ZxdzOTKVionBfEzUcBE9S1e+PkSi4PWH3oxK3U3Q4a+jnQdyPpFTk?=
 =?us-ascii?Q?PgXiOtAVqJ4HvJxXZDBjVGbW6qXW0aA6Q2w2KX4UD4I9QlAFJBPIEN6jatlf?=
 =?us-ascii?Q?1C+eTbYA/C0T2ovfXi/1phHXYqpQwUK9vdhvC/CpzyYJcGq2BLdZF0AiQViS?=
 =?us-ascii?Q?fEtx/fxOfEp6W1tSe9czWoijEMN498pF4JlLvYhdz+CS2bXpShAp+vIOzrik?=
 =?us-ascii?Q?3ObfAI3dPHcEhozo1zyGonvVmg0SJgtCv3V4voGSACShva4bAPU19U7IEoP1?=
 =?us-ascii?Q?0kRChv27ry8usPhwqQeVEjtVhUpuoIGlXyBKdvVfzqKhWESW0O9wfyBSBP9W?=
 =?us-ascii?Q?t/zcrlVCudmF7Owwv5qCjbfCP7kqE3cxF9RM/lxIWZurtIlynB+RRl2NPEGt?=
 =?us-ascii?Q?bkQhZ0/kU+az6UgKQown95bs1YCjZn3oeURh9i31?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f1bedf-8864-4745-df52-08dc8641d1be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:00:43.1852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glXslQFdWHer2gh8IyrP0nMroexc6i0SzrdbNvsiQ7o+UAPIQ3Hsvfm8IQ7xI0R87AoWDjgEuNFd7vWKmKxCBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
Received-SPF: permerror client-ip=40.107.102.78;
 envelope-from=John.Allen@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 06, 2024 at 11:09:05AM +0200, Paolo Bonzini wrote:
> Queued, thanks.  I added a note to the commit message in the third patch:

Thanks, Paolo!

> 
>     By the time the MCE reaches the guest, the overflow has been handled
>     by the host and has not caused a shutdown, so include the bit unconditionally.

I'm not sure I understand this additional comment. Is this talking about
the case where the host gets an overflow? If so, yes, if the host has
overflow recovery supported, it should handle the overflow and won't
require any overflow recovery on the part of the guest. For clarity, it
may be nice to prefix the above statement with something like:
"In the case of a host overflow, ..."

If we're going to bring up the host overflow case, it may be worth
clarifying further that host overflows should not propagate to the guest
and this patch is specifically intended to allow the guest to handle
overflows in the MCEs that are injected from qemu.

> 
> Advertising of SUCCOR and OVERFLOW_RECOV in KVM would still be nice. :)

Sure, I will send a series for this.

Thanks,
John

