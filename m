Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AAFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlkC-0004va-Sd; Tue, 28 Oct 2025 11:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vDlkA-0004v7-4r
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:36:18 -0400
Received: from mail-eastusazon11011071.outbound.protection.outlook.com
 ([52.101.52.71] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vDlk3-0003dM-Br
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:36:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwDGtPtHkUA4WMNYzOmVHLVyY3KsIJ6KWcnJ5uvKVIEJAkjHsjfGd2gFM4N4MJ6RgYJZRnBVikdq6gEEJxIXgnESwL4EPlmucgQ2OW+zVTIfYuFl/6okmKrN1a+IVgRIyWnDnrqM9ZrhwEe0MT8AK94ZIekN0WS+QmPS1X+CGlZ8DN14Kz9jxo34pUvTE81G0Qo1vRE9dxhLTT9nwFSpobhplDzEV4fOZ10Rbc8Gi0cg2HZP3HjPpKWP2z2acITeMIjYqdTYXyz9B1BvA3ueNAMX7zYctsZ5+iGz0DE2O3l0o8YnUC2R7hGJhdYBNJl3ESDVBQdQDR8bPJrR49tMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yNvRd4GWMB6H/p989IsVhTdWyDBBgwj+LrtMiPPUmU=;
 b=oAbsIMp58Pjuqdcft7as14sbhDz+0ggvRvBRk9mm5LN+RskIZxsX3IyRq4cS3lLwRyFHWOa1k2nUdg+jCU+3BpmobcH60hTcH1VK5tOJOUZ651T1760x3He+dPqVCuXJWOlhJPciQvRW1O+XClhc3NWxvPfV0gj5CmesQoR6ftsU5htpsDF8bfnz+3MHG4P2EFo0IEfwygdYw29+NywPBjGcMMo42AJrCHqJnP/wlMEv8cA2h787XNQFKhm+aZk+ULbTQJhRUT+byDfG0ffhskW9gfcErZfIfjQeVeUWABqNBU9NAebYQTDhuOSPF02f7OIaYDIH4bPF0fq5OBRWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yNvRd4GWMB6H/p989IsVhTdWyDBBgwj+LrtMiPPUmU=;
 b=uX44ByuEdaEn6S/2hb2FInEDxQs3ASZu0X6IaTHHA+C5Xf3i+csD9j3fvaFnvXjNPmt35IzJmRxT8/PNFIT01LvIpi+6kG8AisjqZ+XywNDB2zg3mUkLDmDItoltjfm8H9Y8/6RIx+AVpEb4D4cww7rBitgNkuxnr7m7rJ90WQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:30:58 +0000
Received: from PH8PR12MB6771.namprd12.prod.outlook.com
 ([fe80::67f1:7121:7d5b:94e4]) by PH8PR12MB6771.namprd12.prod.outlook.com
 ([fe80::67f1:7121:7d5b:94e4%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:30:58 +0000
Date: Tue, 28 Oct 2025 16:30:53 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, alex.bennee@linaro.org,
 bill.mills@linaro.org
Subject: Re: [PATCH v1 0/5] virtio: Add the virtio-msg transport
Message-ID: <aQDhrYhXyArlsJjE@zapote>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To PH8PR12MB6771.namprd12.prod.outlook.com
 (2603:10b6:510:1c6::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6771:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb1b806-528b-4af4-d0db-08de1636fdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FDoHTi9FtT/ACMhZvQjgZXQK6T5oqe74qTyr7TaZgt+gyC2NcbvHYQ6rDpu0?=
 =?us-ascii?Q?tVccw4sjcwcC/qb0FAh5o9mu8lDAu45Fwvx8NYb27GivPVKy2lWmwRMkINnQ?=
 =?us-ascii?Q?0741XaF0LpYwEs6y5T8voE8crxRnl0+MNu/7y9Dveg0UV9c4DU0TBhEgrlGP?=
 =?us-ascii?Q?izhMZnaavh+SvD52y0BQ8q1aaAh/D6LKRdXUbmrUFm0Tz6yMPlpTA7vmrHwa?=
 =?us-ascii?Q?Z4CZBYMx6INflZONkZxrudigUzUTeZ28mZ4S2KkMdOAFUw7so+sFQHb0qhAW?=
 =?us-ascii?Q?DK9m1RfxxNkoAW3w3CS2BBhuGHosMwc0ctJ/pWI1hdQsV9ye3LkT29UhoAUV?=
 =?us-ascii?Q?FF/gQxuyrjCgvzc0p3xYMmaeteTVIRtpIWPg1nMQRelJ42uvaiCMzQkOOiLb?=
 =?us-ascii?Q?piDJywApKOBtr//JavZLbY6TxrjPugBxHntHNGVPDrCBymeSRdtWJvkHfaI7?=
 =?us-ascii?Q?QeAzMoyuSBpTKBbV4X9z0QM5z3R9xwzNhRSfL8oDn3rm0ur7zG7tJZ0La3rx?=
 =?us-ascii?Q?iF5XtHIdd6c1xsC2OBLQbUZeLiAg2Jq6jqlCbHG4NDjmhvaczo3GM7Esphz8?=
 =?us-ascii?Q?1PUjOr3l4x2sagm2q42qtsoAwcuD9H7fvDhWgF0/7Ztp/4l0Y4omZ9rGFm/s?=
 =?us-ascii?Q?JHiEx5OJlXhoegEZMqM2fb5NnxIW3W5f1a8EYtR/GC70Ijz9wHg1fdOQGQpk?=
 =?us-ascii?Q?DaoprjftV4IUQtwiJynvh+tXwQDh7rcJ9vXJak9piBN1yZ7zEI9M+TBe38no?=
 =?us-ascii?Q?2AexRzWUmtZfSAmBqjfX5hAzsezCoZFX5L++qdyeuhn6kR/X0AJ90jFvNeRp?=
 =?us-ascii?Q?uSYjZg40o+p2Y7mJZfsA1PjMkHFTbf/ayRCaWI9ijTcs/NCLLD64gr7/T/q9?=
 =?us-ascii?Q?o4/O7wNs7fJ2OOVpP4SMHDKJGXBxGEEkqQWT0YVam1+6/kr1geul6pdyO6h3?=
 =?us-ascii?Q?TM+QVO10peuZzFuXMAso6PREJmwlgWULS0WE6tPh3FozQ8QGWYYfftjpTK5H?=
 =?us-ascii?Q?13K00czR2qx+Mvma0MdVE4dJRDCazyf/jSdffe7xpkcQpOz9BmmyehJptbih?=
 =?us-ascii?Q?MnXMBloPn7E0yFeeOPCSIj/bTJpBWjeA1zNi3mcL2BAci34D80qgirrVdbxx?=
 =?us-ascii?Q?rmDJie0emD2jB5XV1/LUPbzXR8hQdSos2BgjMdcHSqXdW3ozr4WHXHVcXlmB?=
 =?us-ascii?Q?I3deZka5xwMtjs+krIa6VhYFjrOyBqd0NuqI95Lp2wWTPnCbpHLNeXVSWyXI?=
 =?us-ascii?Q?PcGfj3O4poL+uktvdJ9sHwz24L5pYeZNj+jmk4+ihCcbzyBIQUcvuwM5rSFv?=
 =?us-ascii?Q?ceCQe4accIkpHBdVSPzHLgZpk2mqhf3OoT4gTcTAEiUnPjGt447RhShhTCTQ?=
 =?us-ascii?Q?TXIDNY0mjAh34ewqe51Sqz2jWcaB55u8zmwp27xQgzUWR4M8Lh8VHOC9FGMt?=
 =?us-ascii?Q?WjI75Jeo1N4q07I9gQ2joP+hJ5N1KCp9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6771.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ffZKJXEvv/7+zgZsHLFYYx4k0QCVrV7LlUXMBzqRmo/MtYhT4fh4I5RotXFv?=
 =?us-ascii?Q?vb4MEF7WuKlncl9Z0QEDA/4vhfk85SAYdcE5+a/ZBr8lbPP+ygwpxUjPqSeH?=
 =?us-ascii?Q?473PWudC4UW7LJdArEXCqe5O1/ujQM66/pLShy942hulOIz0KKsS6KrPt1U3?=
 =?us-ascii?Q?nMFZ4A7XZ316UN1qkZ+x4CyKp7ENHoJL+uvGRXkd7o+m4FdejOOFDtdPAoA+?=
 =?us-ascii?Q?9rPsaiPrQUxXHNv2EzBOazkqi1SdrrvfKmf8hdYlKg7t/fSHbkXu2NOPoqvo?=
 =?us-ascii?Q?ktENvn1t7iJm3PnnbJhdrhIQ5ttO4ryfGytA3Hlbs2RGuRTyjKRWJCiqfLnR?=
 =?us-ascii?Q?InnDxAIxrNJ58QJBXEocJOJSo5C3lCc/2lCSinpiXfLTmvca2kzBqcgRqEqw?=
 =?us-ascii?Q?bDW/C6doQXxRMx+yp3EOiN6vuI2gXUzO7vzKhwUVm7w3jyE1C//s8KwdrKqW?=
 =?us-ascii?Q?lz+VaRinRu+H+8w5XElKAoc9vGvqXVltNyVjaUcKmtDO2kUd1nVqWR59gagL?=
 =?us-ascii?Q?QhI6igTr50KKRqXmCvfvvE1YobKl4Mt+hDMer4CUoOAHdc7TTIKE917PmuUn?=
 =?us-ascii?Q?XkGM26Y9TiFuAtHERUZ6NUNNQiQ386zMvkjgUKxcMIMSV9Ynr6SPJ1Fn9an+?=
 =?us-ascii?Q?XpiPDj2Q9fzVeIy0pV0xdOYpfbXSnPOje1v3FnRVg8gvSHiLrc76mwDbCqrJ?=
 =?us-ascii?Q?07ueRxICy70tP2dmnty2IshxRtjnNd4v2+EkoFum7QOQOJR45WSoQlogefF5?=
 =?us-ascii?Q?pr3Wzqi71ktuHk7Nfjt/h1ZyON0CKndihbFOSHGO+PWqdAF5LzYc47z5mC4Q?=
 =?us-ascii?Q?hD1/mEZU9lvKHMK1Y7nvjrPJyxfQGxDBlIfVuJvpf1chy31NloZONjn+4TRg?=
 =?us-ascii?Q?UphYYWS1awwj8+5ZEOrpEyMY+QCcdy5fkG27oZJvjZIl+KzGzSq7wR2rgoPU?=
 =?us-ascii?Q?OL3NhW96gQtAhldpeOEJHzmQSmSLY5Qfq4UUbLA8r3yLphEwh0QGGQqnhi66?=
 =?us-ascii?Q?MQStB0V9Nj/Af2VGCdmTm+Efp8lEZRhmeKq5v0Gquobwd4dlcavt89Xfrf77?=
 =?us-ascii?Q?Ngiz1BC/h2WNSHx9V/rWYcgtjDDlZnxccWRf3K1TC3ZZR44Y1Rdur7gPaRn2?=
 =?us-ascii?Q?FiFmIo6UP25pMct6+qCi25FSbfcFLcm12DQAWvJEOO6IfC2DrpQY7NO9pWm+?=
 =?us-ascii?Q?x77PN2A3uluY9uqdofIqmTaVI8etsb9r6W/PY8Vc/g5N/9ReSqlluwzNDvRe?=
 =?us-ascii?Q?VbvQ+Dldsh6u0+2jY7bTJVS91IgviIEbZTL+zd2sCnIpmM8ZzBw1DqxCq/R6?=
 =?us-ascii?Q?hOZE+jyHWc0eIiMuaqmLfOUBcfvW1/z6hHuTDbOgvRVVJDLMAJabyt36sI2M?=
 =?us-ascii?Q?UjMVwHeTng3GbnanZuFiHKRvnrd36U/0vjYztkAaz/+/73yC+ZqBOuYAqCza?=
 =?us-ascii?Q?CfvlFHEKwXl1IFWyTof87RZYjC2SUKC0HcRgAveBIgYCWytjH8bnyLOhI/Mj?=
 =?us-ascii?Q?Vj1MGNfpZCeUXeZeBUjjPpt0hSvMMuwmZEg6lcezYJA+Jwi9aAhLUCuJXKlg?=
 =?us-ascii?Q?8kpzEo8B686xcxxBLwg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb1b806-528b-4af4-d0db-08de1636fdf2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:30:57.9499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb7rd3+ulfsifKmdPfrRn6Hgmkz6Xx7u2NItPMHPJgqJvO/ukBcH+a/LRabyLwMi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
Received-SPF: permerror client-ip=52.101.52.71;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Oct 28, 2025 at 04:23:45PM +0100, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> This adds virtio-msg, a new virtio transport. Virtio-msg works by


This series was meant to be an RFC but I managed to send it out without the
RFC subject tags, sorry about that!

Cheers,
Edgar

