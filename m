Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CA5C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viblO-0008Et-Tw; Wed, 21 Jan 2026 12:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1viblM-0008BN-JW; Wed, 21 Jan 2026 12:13:00 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1viblK-0002K5-Uz; Wed, 21 Jan 2026 12:13:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC2c4pV42ozfpZBRoOK49RBhgFRVzzzSiqHdx6sNBI50+szUAwxj5tP2PFlHIPivqmvjCwoObP9c5lrZKC32/VnArpWMU8F0uvj13/hqPR8rGsvdas5+TndD9EWTY7AKw5vnxNt8YVnlpz/W2Y35aF7cEKKl0ZEfRgdXpF7BCQQgxRiUR8qmmYJT+CE7FjtmPNdiS8IpKkIj2s6mzZhuCTCw8tjFJQp/RlC1dwEG65StsbbyHSOnKoXWskmlPCoqJkpgJeL8TW1djm/UsXT9zn0W4fT7my3F8ujTOqx406Xd5yx7RisdZBX4R/6HSUz06+M0UNYgVxzKtyxb4qEhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B9FA9Bi9WsqFt43ivYTbobdgr20bglUsP3UJbMe+0Y=;
 b=dXo/n5Ch/2iMR3e8Rpy/AMN74NhEbbzkpyhGMIiWLnlDNAtCGhCIj9LfcEpUIvWnWdSqCh60GxPSnKbhKbNyNiYTbGBZgjaxWzGhtt7Z5earpfbvnKH9fuhWwvqS5hYL73lSP6HObY9GzXwYiiUm+nsgVCckf+QxLN+fEWp4oUMwpDW1olSGel0IjKMO38RWf5i5EMm5YX4Mwr4vW9uQHh8GIbCUOo9t+kH/1nEPBbW+rQfj3jypHzFApFoZOC84OU1M3/SARSFarpY/a/Pw2yNTGjW0f32MD7EUBLjd218zOlS6UGHBIRQXNH3z+rr7STJrM9aVvEkGRcHZTeTHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B9FA9Bi9WsqFt43ivYTbobdgr20bglUsP3UJbMe+0Y=;
 b=rEa4H2PlO7f07IDCHmSgSvOSLb8fsQ0BJG8c9Z5qiXrJAz3CtUgjnlK3vroI2h4PfMC3ABVOkyh406n2A21Hy7+X1lv8f9Q5QNrhUWGsFIJu+2X5J0LmvpIa8GtiwwYV18yfCU9kk3vvbt2z4No+x68r2VTuF4219ihb5Ka1q6TlIPEvy1LeoDdv5bB1fHSlmROPgQXEDAQaSd49qv0FfGZT8YgG1b8mPORTVINCqbycvArD15x+23UKD24m69Ylj4u0trHbgvfz8thzO8X2b/5K4juHze4gutuWAARmmiG/BI6fsTbPVyptV6ltijhhjEg/ORYX77t+KXsqQLDpbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.10; Wed, 21 Jan 2026 17:12:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 17:12:49 +0000
Date: Wed, 21 Jan 2026 13:12:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex@shazbot.org,
 cohuck@redhat.com, mst@redhat.com, nicolinc@nvidia.com,
 nathanc@nvidia.com, mochs@nvidia.com, jonathan.cameron@huawei.com,
 zhenzhong.duan@intel.com, vivek.kasireddy@intel.com,
 kjaju@nvidia.com, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 1/3] linux-headers: Update to Linux v6.19-rc1
Message-ID: <20260121171248.GH1134360@nvidia.com>
References: <20260121114111.34045-1-skolothumtho@nvidia.com>
 <20260121114111.34045-2-skolothumtho@nvidia.com>
 <53a51440-c7a6-49f9-bf2f-b71c8e9f32ed@redhat.com>
 <CAFEAcA9+kp7K4cGeMx2PTGp1V3SkKoqyHEOZhFD-QQ2Y4WZHPQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9+kp7K4cGeMx2PTGp1V3SkKoqyHEOZhFD-QQ2Y4WZHPQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bde20a-a465-4109-a9cc-08de59104df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qb0A79RsLVhLWl3N/Za9xEd4TPDvszGNY4f15/v5Tyl2smj3Q+1i/QfTRpEV?=
 =?us-ascii?Q?cf122U/OWCBPUTIyhAChi6dBa9caJTAp3johbGnQyHvELktKUp870w76D4Lh?=
 =?us-ascii?Q?D5G30DXxjSWgdzz2uE/WGPW24f3z7yA6nVLRokbXTC1EIZh+cRmWl7bffOE5?=
 =?us-ascii?Q?8AeFk18zLxoNkuC0yZ5Bzj4Tms0a55WvtHxMfbHelsYuVAwUmoK907f6tQbZ?=
 =?us-ascii?Q?YPun+0dc4pRGwOrgwQ7fuL+jlfGpcyitMkqFNQz4CT2wI5K+Q7a4OwsZiiby?=
 =?us-ascii?Q?+wVGQqC1I+T9fmQR3NYpsUnvxTr9ZXaulUExHmI5xJzg8chTCNoHcq9jkauj?=
 =?us-ascii?Q?sOdXDZzK+IAzVngD7XRFHWeZAjASDnTJ2fRuZBHAJtDGtlZyGJU9w5uKXwaV?=
 =?us-ascii?Q?QqUnVBE9ZWqRkmbmTBlbCzv/5CeOqYHVdZ5Jz5aX1hK8Oi924zYKaR/aT7gK?=
 =?us-ascii?Q?NJkUn1h0G6V++zgs8cgfgK0wVdKBrHHgt9aHY37JK6W8m35Bx0y7f05zPJcJ?=
 =?us-ascii?Q?AryVOipgrr8pvNnZFi3ZsqH9SpvrS0w4Faai1gquCw0m3i1nUrvE2G9qtkc5?=
 =?us-ascii?Q?bpUUsL8eOnkX2FKnpxZJryn0unSW9+LM6JVnwo77AJJEczSaLy+J/zBAOnNo?=
 =?us-ascii?Q?KEQs7qMKNtLxWpCk4h2NQyTlU9BgS5Ys5x/PlcdbfueRw0iflmx/SBiTH1hp?=
 =?us-ascii?Q?5jIDJh8k5ciHb5rcVCGav/ez0muW0rvx43tEc1cBBTgfwUuSwcghi+qcUWeb?=
 =?us-ascii?Q?ictaNy1VkeZupGX0pnHJ9UOnNFqNUEGxGo8AD/QT/F16Cqu+yYlVgcYlXGod?=
 =?us-ascii?Q?fyG/wg5QjUI9pqGGVIakXhQAkl56qlaqd7h6E6As6YPI6Djx+ics5CTHPB1q?=
 =?us-ascii?Q?etmpPUnamc9C/iASbgv0H6Xhwo9XDV0yNaS+aRdomILjsi7+nwfR9jwVIDUL?=
 =?us-ascii?Q?gCVpOo5q5eXxy5yspu6t4zTZBmnIR/wDe3Mxfi4uB3T1eVwo1x+0FsyWDFFG?=
 =?us-ascii?Q?PDndgl+m8kpsp5oDuAUd8s3mfdUvgj035S27/0w6f/zbagOUt2nDPQ/7vSxw?=
 =?us-ascii?Q?NnWO3t/AIIHD8gUsEsJidrlB4ViPHIZTQMJn2GySFCNH3+Pg5C2yQnE8tQkQ?=
 =?us-ascii?Q?e07dYgV9T8GFrh1qP/zy23t3bW0+CH+9jNIpvW1DCMDqLIQFXpAdxi7RwQj2?=
 =?us-ascii?Q?cMn2uFmccBovmgxkTazHQg5oNOue1Eq1b1j5/u5xCY2cBUQAfoD8M2cs8V0R?=
 =?us-ascii?Q?wi6kNUu+4CKdNb/t7MzXuz2TtkojZRfa4FiBpZqBihpCCVMcRc76HxG3+8Q3?=
 =?us-ascii?Q?aJmlpB5whJK/CxTX/OyU3DPD2CfUdZIns7xhCn+oQeSGfFiyxKbLSA/Q4+25?=
 =?us-ascii?Q?XTx6pTA6dprwG1wSGRUndLHfs2XEX/Rp55fHTLexmUZWBuiZaQwRJtiF8rwM?=
 =?us-ascii?Q?I7hrqHLa4yBa4xO+tM0hr+VGHkGigIh7Rs1g2/jern3jerE6XEf5vD/nHm9F?=
 =?us-ascii?Q?gkRPStwlOOD2Oa9Anr+o+lvai81/qve5SinGr8UZo7B1u4vhpQ4s0jA53q9U?=
 =?us-ascii?Q?hSkATagVhRukv4d1rIo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2DVjRSuuPABvPrumm13OwQUVg7g8tMH4inP8lL/JyDRAMxKOU9JZIElEbGj?=
 =?us-ascii?Q?V6fxp4eLStoFUsSgzHIdko0M3zb5RZvUEmY3Qq/cvvn5PJUMViHZyxIQL4wX?=
 =?us-ascii?Q?64XyriJnNZ4WL/WMSZx6ZkpMhwWAa0nFQS+4yqELz+TFS6kzEoNNj4aTdYJT?=
 =?us-ascii?Q?2MYluf2uhSCajLicKAFhPereb/S/rvyhZ6KG0VQXrWuRwukI68nYFpzhzk4k?=
 =?us-ascii?Q?u7T0UEu4yYqqxZf68DQhlV4ZA8x82pvJeSZsdq8W0feVNV3IZQuAo7zQd/uN?=
 =?us-ascii?Q?1jBnRYKD/K+UlxjCbbWwD9OwM9htkx/U33Kv7E7p2QrBJRZ7sK1dX+rQRn8g?=
 =?us-ascii?Q?D/BHfp4aXD9tBtSVB501LJ+b6o9KEIy2yBAQ+aKdpxHuBTHs31E4LSREnckx?=
 =?us-ascii?Q?2swutjlh50iR4kJkPFIINg3TbRpRZFbAsz614Ba2nA9jvs+VVXZ6CwlgdQt3?=
 =?us-ascii?Q?XYjmDXPgiRf8FFb+wkGyn9zVm0amp+LgLcMkYJZy+z4Iky0ymg0K6Bu0oOzt?=
 =?us-ascii?Q?qRkpIR0AmUmY3jvX0ARELhp6L8jdOejmOBS7jXsuwwZDZ2U/dOFcGtYO0XmM?=
 =?us-ascii?Q?H6T9J9HtN6Yj9zxl2tziRTuwPUtBZCYKQicEtlZlwfKNVQhto1bU66gjrU4z?=
 =?us-ascii?Q?ndq8e1iSvyVqDfDc7YcropCRfqT8R4HeRVZ2T87O5sznNZzwedyEBuF0Mdqt?=
 =?us-ascii?Q?LNXFWAN4JPxcXAviUvCssurGsh0qflabj4J9GciHQmpjkFII7J9y4P+zKqd6?=
 =?us-ascii?Q?cvojS/m291D7FBrIwl2dOyicj6tZA/3zEpaKR/8jwSj/L/KehGOy7zD8cyzy?=
 =?us-ascii?Q?C6OW47JzvJ8x7mzJnEa9KEzzPPpDCZ6bCXiLG2Bz77JBnTVFap5WBThm/OU0?=
 =?us-ascii?Q?evvi+FS6u7xugjlcJoH0TD3owKngL7FN4P2HIBJxhnbkK3CAAnSCKuCblfl7?=
 =?us-ascii?Q?xjp3hrA+Z7qgn51jmf6ttusafAHNjKkfXlFvoWbvQYYuR66YVEeztwWL/hUK?=
 =?us-ascii?Q?dVjSBVyQGiIK6AUFPW9gBQECDrho2qwkoKT5NF1RIQ5Kq8slcmm+Mnp4E4W1?=
 =?us-ascii?Q?WukGwyuWg59AhBgHBbtlM9l2rdBVKRX6gH5enMRzgtx8L4d8XLdIK3aQC2/P?=
 =?us-ascii?Q?RIx1qeX0kpCv8cl6Ow0f0D7zjaFY6m/iDoFA0AvOoiOW/QNjkjOHAeQhLLuP?=
 =?us-ascii?Q?6Je0bjGQYx1AXNji3hd6GTuk/sP2c6YbxAxnNm+TdVL0qhGItq4mhtR4wibs?=
 =?us-ascii?Q?wsp1oIrW7ljKQRqc2UV28EQF9MG4G6zZmfTp/stm6cbMKZ0gwY0TpIIZkPPY?=
 =?us-ascii?Q?6Vqon7ZPvy16K93MTsjNv6XabZUbRpvO6XGH7uFGCrWUI+ABnBWbkvOPSmzV?=
 =?us-ascii?Q?RuBUIIaTu79Um6CcxeddoWJ7DA1iDBzy5KeWh0dKsGl6p1RrM7vDccYP9rSy?=
 =?us-ascii?Q?pKiYbVfbAg8Y9984y2Xx+uJ7t7Q25jS77mvq4ufN7acYJx9kZPbzSWmlyZhB?=
 =?us-ascii?Q?nExEpRv5fGcn0LTgw2qkwiCj5KypA2cWT9s3mrTVzmT8YfJa7PL9FKDpIseN?=
 =?us-ascii?Q?719ltoKu5ZN0sIPH0jJiyWRl8/c3U44TA8JKtMXRLk2f2FZXtQ02vNKC68kY?=
 =?us-ascii?Q?MiIMjKuuwZQ/SAf3kW7f3DMyh7TX0CoF847Ra23+MftAb2pBAOCt5/448C5p?=
 =?us-ascii?Q?UD2BjmXVLcQNx8jZgJAuXKbiCPe2QWvZLn1VQsWLskavXGz6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bde20a-a465-4109-a9cc-08de59104df1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:12:49.7193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9Vl0QC7Z0SaM1rnq6jeuGvnEhHUn3p0uEHaFzZeUmx8yMhm7pxH+6+c+Ej4v6rL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=jgg@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Jan 21, 2026 at 02:21:17PM +0000, Peter Maydell wrote:
> But it looks to me like this is a bug in the Linux headers:
> they seem to have changed in a non-backwards compatible way,
> and possibly even in a way that makes it not possible for
> userspace code to use ifdefs to handle "maybe the header
> is the old version or the new version".

Technically Linux doesn't provide an API guarentee, just an ABI
guarentee.

Ie we don't guarentee all old userspace compiles with the new headers,
we just guarentee that once compiled it keeps working..

You need to use something like configure and compile trial tests to
figure things out.

IMHO this happens rarely enough that what is proposed here as a single
patch is the best option.

Jason

