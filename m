Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEA8CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 06:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz81o-00009k-Ey; Thu, 18 Sep 2025 02:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uz81e-0008Tu-Md; Thu, 18 Sep 2025 02:21:50 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uz81b-0007Qz-7d; Thu, 18 Sep 2025 02:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9lUTjmIfDUNpPkD0okryECOWCI0ef0hvs5hp4JU09Wv/qnJKI1qUbhEbfiUNxFzZ86FxLQNpLyX/ZCSAql20NuyIljGHk+QpAJXpMbdnogmbO3OTbHw/4ONFqZOA+ukmodbbG4cotPl5J2LaBPcsaJHTbC0vWupwB9bKkZMKc8Pkw6i8kCzI0Q6I3fUSmaDmZXDJa6SmDs8V+MA6uXvagEt7uu1Rs6W18jU4E/YdxlhIFfYifQt5NsydF6ZWT+xYC34tdgxVzjIxirnejotRX6NHPX6+ZxNlr2EF6/tqbeUaPYKp5XgoDvs/yd0eQN98TITNQL0VzX8qkJv4FJyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzP4oL0LpnsmV6ISwuCUKMQiYFLiiAHrUKwz4r6Kias=;
 b=Q6vQGmU5Kcia4yBxCMROq9VmlRUfj6Pe+K2VY2dUJKia5pfECPGggddB4ISGBSGkPiS60rdMzFq8mGKWHo06HfM/Md0k/qKCe5EsGhYuwP8+gtvvKsrqR4zF+iDDPsscW4bWaRbtFd5YbH2HCv8Zi+t1DU+/IftaGhfHJDFqX6vhPwEwOIZZLQ3ooJubcey7a3xwllxen6WJtDmhvzLG6S9sfjX0hqkLuLBnpFM1DHV+09yXTTcrhtPKpjiJgocjuWXzxZ9dkZqS8CgotrEItrmvvVhPze6fG7OJ+Xi96QTEEJv1xm7vegpnlZwJa4A+18MyfcEL8lJDwd++eLkmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzP4oL0LpnsmV6ISwuCUKMQiYFLiiAHrUKwz4r6Kias=;
 b=03C4F/WMOejgSu7vKCx5aRu6X6YFRMDMwe4inezUcQEXT4XPVzQZB1MvbfMF3t4jnH86YmdupxQE0XPrzLIChlglgGy8ZXzGmTnNm3dQAEhD/i72Sc/FHRJEDsd58wz9dy8VcufnVAQeOBYb02kEo2dsV/0rYQTjvWR4MMZ4cQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 06:21:38 +0000
Received: from DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d]) by DM6PR12MB4090.namprd12.prod.outlook.com
 ([fe80::671d:f94e:1c92:2f5d%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 06:21:38 +0000
Date: Thu, 18 Sep 2025 08:21:35 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Subject: Re: [PATCH 0/7] Register API leaks fixes
Message-ID: <aMuk76olZRwI0Y0t@zapote>
References: <20250917114450.175892-1-luc.michel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-1-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To DM6PR12MB4090.namprd12.prod.outlook.com
 (2603:10b6:5:217::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4090:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 711006cd-73cd-401f-620a-08ddf67b9fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QiWyM98Dfco1VKRWeZnBhn8KvO4aU/cWHWRSHgcNH9INGwu79ptLBztJliWK?=
 =?us-ascii?Q?01jCrHJUmetmOrnEcOo7o0binhMe2KI2g3/cU+9In/WE8Cn6vOjkFLQnBlWo?=
 =?us-ascii?Q?EG5aLdzleNGkBZCpVtad10Hmew4wFclwBuWsMHSac+//E7BEzwOCHvneDoCA?=
 =?us-ascii?Q?DYMbkzYYDnLuWhWdgSwEu+zVdusEO7VbkpvtYa/81AKtgENNwMy8zXehkHmT?=
 =?us-ascii?Q?LNebNyhFsPlY8kZhT1D3itfHMzLRC6cXKtNRkzV8DVam03FEYGcCeVS4CoaD?=
 =?us-ascii?Q?EU532+cv0dFe2fIaqTs8un/T2C6L3rJzlsLVIXU/ZGEYs392Xz+J/YOORaU5?=
 =?us-ascii?Q?7M6oyUy2c3BgrIg5tE8Eaw9Xx7ScSxqdXNaE2FiG02tEL7R1EPYk5zmOCbTq?=
 =?us-ascii?Q?4hi5XU7zdIAwxnACh+nQfgOfvYkTK+YZOAOGK6T7e0+weZDjimEfNKTsVBGM?=
 =?us-ascii?Q?PL0OKQOXuzq+C4B09gVp/GGm6G68rQYobwMOpesgJXcqV4Tj3zmAmG0TqhT+?=
 =?us-ascii?Q?0HZQh+uPD0B4Y1yZ4qUhWb24dOrKXh6s215rr93rL+Pu+9YXr9PJcN39DKPw?=
 =?us-ascii?Q?9tpJkGT2UPu4ir4/hQvPRi794FyQ9M46lsXVdeC69FTyTR6ZjB4Aei3nMvy3?=
 =?us-ascii?Q?1ElnGGnF/tH1/33RdtMlByVGBmTN5ukWW5h90UNA/+A39SB0CMHqgeEeL/Cq?=
 =?us-ascii?Q?V3ST7p7RAO7BodzbGb7CwVYXXTYfzE49WqI10jmDgZs5nXsbGJw4CIVJV4mz?=
 =?us-ascii?Q?0hLZrFHpID4vkbKBkshZpARQXADVQbrVSSwEC7zHKMbjQXm5RGlIaZkKWds1?=
 =?us-ascii?Q?jzZwa4SDOCVNW+KYafCg0dVDgBQBSNl0ia8D3WRrO1dJzJp3J+7Nq0nCKy4S?=
 =?us-ascii?Q?tEyLE8Ld/0Y+VGtmLwKfA4BgEEOHtmDRYUbebk9yW9ehZer9JRPQ9U/NGiuE?=
 =?us-ascii?Q?j+J7VPxf0ldcUIjlXKAKw1OF/Sl+T0OTwKaRab0271Bsv1hL3MIZ+h02Bu3M?=
 =?us-ascii?Q?0AHnFQVNa6W3oYfnfZrhQcprrgPzCWGOB7bJ/XpIbnMJg1aEoV2Z4zSol4nB?=
 =?us-ascii?Q?/kAKeUsJjT6Zho4zqN/7XQpS07bZkqNd/NWxQzz09RhnHAVQujlfBgYo7KUi?=
 =?us-ascii?Q?La7FrdvxdGb/isu9Tq1zagnt/QRCrV8MUspzGulA6AvWZt7vc/iR/Dl7DuLb?=
 =?us-ascii?Q?wxwMgnzM78vj8ZfALb5B38M5WTDbt5phbF8qqIwbII+zBesMneGR2bQW+r35?=
 =?us-ascii?Q?2AQSu1b6ZoImcwjb8rLi8/GkNwR02/SXQLICnnfd/kLWUlmkl7Sd49M3//xY?=
 =?us-ascii?Q?1TYLYewpG5YtxC7ea4oxwLJ7gY7nzOZ8YLzDV1yqXEGE8U+hrZ40XxksjLDf?=
 =?us-ascii?Q?FwT70x1HCJT60l4i+JMNIEJ0S3pAnQdT2kiOBIxfsZl+VSHSe26Cf4IwxczS?=
 =?us-ascii?Q?tA3RU5fUO0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4090.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hj+fa9I7OaCeOZftwe1wIM1p7bnHwpAJlzlcU+hEQIEFOnrvt1tYNk932KOa?=
 =?us-ascii?Q?83J9wNBONb+xMkQhBu1atTUke3lyNYPqdXuCNh+8+tN34BbjHaf7OM5Q/BBJ?=
 =?us-ascii?Q?bKDO0AKMOEzLGo3mb77b5hKNCe71IC747jJlV6TgxYtOYn3WyLXuLI3UiTch?=
 =?us-ascii?Q?fNS2AN6cyQod23XeTnAvvyHDeK6GVkeId4A1XXJhKLFmig9Gq7ixnC0uGrUP?=
 =?us-ascii?Q?IPI6GpOMqDuz5rOF5IXFM4ZLhSOUNV+HVsAvAc9MwQqlHI+jpUI5M+2iPNAO?=
 =?us-ascii?Q?chEaNDHQ9BC6zbdrqNU7IdZPDn+GnmURSajIFQoH5r/HWdaqHnaBk90sfidX?=
 =?us-ascii?Q?bPB/z/ombH/kKCc1VjVNYMpdis9i4OaRPXmtYEl+ScI3kLp94wJ29N6KqADL?=
 =?us-ascii?Q?0+D86q/LXzuD/qtqNukwHQURNJMUKiz+U1byOC9HsZFo2lu9t8Tya/nBCcmR?=
 =?us-ascii?Q?ufnLdwH6kH2Bw7YXIYLJjZLQQyqBibjyVmEnGet5e7YxFgNyAo8N3ngYHhGx?=
 =?us-ascii?Q?3ZCa2iVNSkqkVJn9LCs2ww74qh+N+auV9E5VPIjI9DNoxi3y6SiAmV9LxS8Y?=
 =?us-ascii?Q?qMtyOPzBPUbsozVkpdntnN/UNMdsp/a0XAVYllicxFYTgUP9JWZcdJICq83e?=
 =?us-ascii?Q?PIl1qU/EV0ntGmygOYd3nlPIPNSeZueF7Y+CYq5YJMlIA0gwKWRBczo/U+6I?=
 =?us-ascii?Q?L+0YDn5DjALpVpRub25XfWNe2HsLFa5swdJMHL4iHx6Pvzv56WcyBsxKvqZg?=
 =?us-ascii?Q?vO508AvHT3lpfCcCuqNnXog+NkzlxVKbSO2xIK1U7nej8nfoneIoRVrLH+/8?=
 =?us-ascii?Q?OIFtk5x1/ySOuquu6jWEPiqczP1WnaFxK8tkRiY9Lj/WDbdrhCpSb9/Cap/j?=
 =?us-ascii?Q?y0lSdmAgzZ6teGwFsxzVpLjruRlcvh2N2RNc3zGjHaiB8t8VH2w3bJyFmPDC?=
 =?us-ascii?Q?FKDWrzOZ9LL1fCJhpofh7tsHt6z9+W5NxsXhy4H+wWc6kjSOThjNPrkakjHU?=
 =?us-ascii?Q?5p90/kd6kvwIMQm78QZhF1E9SEo7NvjJ2crJBNXcSqyrmH5/D18ag1sZG2W5?=
 =?us-ascii?Q?USvj6/4KiSH26AqyJvNmxeAsdV4rWrUaFw5sJ885ZtJQUSWgeS0CYgIoqp25?=
 =?us-ascii?Q?c22DXbWhvZKFQJ1/pLZkag2cUO+yAPXuOs/WPyJqFlcxpigsXL4kKXP1qWSv?=
 =?us-ascii?Q?Du8i6CGGk/AufIoAzJK4g6NyKSQk/stV5rtTHgEmnix9Q3jgYKrjVLLdxTm9?=
 =?us-ascii?Q?jjk8MRPqc2vFzPOTxBetCYouYJLlH5qu9RjQpZ8JXTWlfK2wXjBEeHSg+E0I?=
 =?us-ascii?Q?kd/bH71DJ2HHraYuenOSDrh2GCey+hL0gJ/60O10lz/RKhhNBM8U1YFX2Mxd?=
 =?us-ascii?Q?vbMlYCkYm71BlgbIae/XKPJjhUtqvCKtDVR5A0GAzVxuR+DH9Y0pj6H29Hcj?=
 =?us-ascii?Q?T2RKY66A6zvlIc0DgGnB5Et5HvrX7cXP6K866LgA6S7RVOm5baWcHtMc480/?=
 =?us-ascii?Q?Izq7V7Cu56fCd6/jAp0PE0utVGott7A3B7QYp1xh/qrFNzhBD/xyFXXYl1jc?=
 =?us-ascii?Q?qxTypG6tjz4qzVYugWw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711006cd-73cd-401f-620a-08ddf67b9fbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4090.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 06:21:38.6436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8hj0OHVgoidqzqNGeYK2wnIjfgZVNsuqn/7lN2y2D1vlRSsyNmYlUqJ72hGjKmj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

On Wed, Sep 17, 2025 at 01:44:41PM +0200, Luc Michel wrote:
> Based-on: 20250912100059.103997-1-luc.michel@amd.com ([PATCH v5 00/47] AMD Versal Gen 2 support)
> 
> Hello,
> 
> This series addresses the memory leaks caused by the register API. The
> first patches fix the API itself while the last ones take care of the
> CANFD model.
> 
> The leaks in the register API were caused by:
>    - the REGISTER device being initialized without being realized nor
>      finalized. Those devices were not parented to anything and were
>      not using the qdev API. So in the end I chose to drop the REGISTER
>      object completely (patch 1).
>    - Register API users not calling `register_finalize_block' on the
>      RegisterInfoArray returned by `register_init_block'. Instead of
>      fixing all the users, I chose to simplify the API by removing the
>      need for this call. I turned the RegisterInfoArray struct into a QOM
>      object and parented it to the device in `register_init_block'. This
>      way it has its own finalize function that gets called when the
>      parent device is finalized. This implies a small API change: the
>      `register_finalize_block' function is removed (patch 2, 3, 4).
> 
> The CANFD model needed special care. It was rolling out its own version
> of `register_init_block', including the discrepancies leading to the
> memory leaks. This is because the register map of this device is
> composed of main registers (from 0x0 to 0xec), followed by several banks
> of multiple registers (Tx banks, filter banks, Txe banks, ...). The
> register API is not suited for this kind of layout and the resulting
> code to handle that is convoluted. However a simple decoding logic is
> easily written for this, those registers having basically no side effect
> upon access.
> 
> Patch 6 introduces this decoding logic for the banked registers, patch 7
> removes the register API bits for those, keeping the one for the base
> registers.
> 
> Note: this series is based on my Versal 2 series. It modifies the CRL
> device during the register API refactoring. It can easily be rebased on
> master if needed.
> 
> Thanks
> 
> Luc


Hi Luc,

Entire series looks good to me!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> 
> 
> Luc Michel (7):
>   hw/core/register: remove the REGISTER device type
>   hw/core/register: add the REGISTER_ARRAY type
>   hw/core/register: remove the calls to `register_finalize_block'
>   hw/core/register: remove the `register_finalize_block' function
>   hw/net/can/xlnx-versal-canfd: remove unused include directives
>   hw/net/can/xlnx-versal-canfd: refactor the banked registers logic
>   hw/net/can/xlnx-versal-canfd: remove register API usage for banked
>     regs
> 
>  include/hw/misc/xlnx-versal-crl.h      |   1 -
>  include/hw/misc/xlnx-versal-xramc.h    |   1 -
>  include/hw/misc/xlnx-zynqmp-apu-ctrl.h |   1 -
>  include/hw/misc/xlnx-zynqmp-crf.h      |   1 -
>  include/hw/net/xlnx-versal-canfd.h     |   8 -
>  include/hw/nvram/xlnx-bbram.h          |   1 -
>  include/hw/register.h                  |  25 +-
>  hw/core/register.c                     |  36 +-
>  hw/misc/xlnx-versal-crl.c              |  38 +--
>  hw/misc/xlnx-versal-trng.c             |   1 -
>  hw/misc/xlnx-versal-xramc.c            |  12 +-
>  hw/misc/xlnx-zynqmp-apu-ctrl.c         |  12 +-
>  hw/misc/xlnx-zynqmp-crf.c              |  12 +-
>  hw/net/can/xlnx-versal-canfd.c         | 434 +++++++++----------------
>  hw/nvram/xlnx-bbram.c                  |  13 +-
>  hw/nvram/xlnx-versal-efuse-ctrl.c      |   1 -
>  hw/nvram/xlnx-zynqmp-efuse.c           |   8 -
>  17 files changed, 196 insertions(+), 409 deletions(-)
> 
> -- 
> 2.50.1
> 

