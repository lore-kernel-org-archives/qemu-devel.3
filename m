Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D993CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh6FB-00030s-43; Tue, 07 Jul 2026 09:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh6F9-00030a-1a; Tue, 07 Jul 2026 09:53:47 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh6F6-0007yb-Vo; Tue, 07 Jul 2026 09:53:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifgjbO5894n1fZzq4FJIhVfzPyw+QruryfkGABzPO96eqY8WZ9niMwZtp8PpXbp5zomLqjhV8MqRFz+BDcpqLEyo9Axsa0TOfPCycP4STnbcd7uv99lmLj5gnwmMwhQt9iGNiCSPD+0ajYyxIaf2QEsOnOrlbbvpMIVAHXJk7yTKIddASO0uSjF3NOGAKuF1Bu9Tba04UBvRxnmqA9FvLS9l/sY+TtH/VKgbNu6Ry2Hs6RzqEtqE9ptsaWwEJm7O0RyWv9YXQnW33IY61wfFT5MsEqTtnEt70NQ8P4mMHMZY5Km50Q2hcpzeOFAN/7OKlfWAY0JBZoNf/FTjyGq27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfghyVre3DJZ7EdqDClTX4FBQrdgGafaAHgRsuCbyGc=;
 b=LPyVIIbgYMBXwYQZ8BLskQSqaJIxePPNq/t+GRlH5og7FfUX+hdDi4bAXZU8cwEKcp7IU6Llp5sVMHYxTfDSVA/GtTqS0gLWcepkqP1O4yecqqAF/6TXFcVBHmIkcWaZPUb/iq6RsHvRrq3jrNGq8UH1W06RznvB5syEalKky+xF+QS5sbbrjc/YcVydcEBITrU/mk+u0nddcVu6kg6xKNxvd8JIyej5TI+AXyMcgeAYSqaWgd5G4PRw/pzoMamMUX4UeYEluRZVPj1CzST/5OuiPonXNzIb7ybaTQrifI7UU9zE0SCLq+ExI/IDsFdcQJX+Y0QnvWtWp2WCO3ZmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfghyVre3DJZ7EdqDClTX4FBQrdgGafaAHgRsuCbyGc=;
 b=JTp6+/omCF7ezVhqYk1Sq9z+cVFAn9gOxVt5AR/GWVkhN8P/bd6htCmhKhdmLttUJP56NyXWJ8sWkcVR1ciK+C/PKUs+0ohGwTPHiJqFlzx0hGVBlgCueZJOGbI+lE9lJEgOsczhE7usszdxpsYa3tLn4GZgk5M7bwx2y+YP7m+eGrkg3xVGD25ssOKUs/F0hS6RDEdWyKotH/Brjvl/mdn0fmpx1xnrygJ3mra2jr0ILguVnGAXucQP0Epoty4qteIg9aNR+NovI9ZRw5Usj4dlkGSzViYZtPVHlIfgNGyqzHdTGE9E7XxJH3iKLYUnmu+8ouFadVVYBNqAozVjVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by JH0PR02MB6369.apcprd02.prod.outlook.com (2603:1096:990:b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 13:53:37 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:53:36 +0000
From: Bin Meng <bin.meng@processmission.com>
To: chao.liu@processmission.com
Cc: alistair.francis@wdc.com, armbru@redhat.com, bin.meng@processmission.com,
 kai.liu@processmission.com, peter.maydell@linaro.org, philmd@mailo.com,
 pierrick.bouvier@oss.qualcomm.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH] MAINTAINERS: update Chao Liu's email address
Date: Tue,  7 Jul 2026 21:53:21 +0800
Message-Id: <20260707135321.33878-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707132701.71164-1-chao.liu@processmission.com>
References: <20260707132701.71164-1-chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|JH0PR02MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 47731ca8-9eab-456d-d317-08dedc2f245e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|34096008|376014|1800799024|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: efX5MTlmGbHI8fVR0UPKgMNrVpjo1nZ3mOJzmuqZYnhKkfhFMAyHiDJfbgzC0E4qMDgFuuBp/Y8wNJvs2/bicd4nAnkVoPXku2ZyzXK3PXGp3tPjDw4uxtA9Je7WGCRb7lhuoPgmBdPQcyBvSjuddDwNd5adDaIBt8Ui97XmcqTR6bFqtrStt6wEYqli/a5ncE/zGKnhMe0z1IVY/2uOL07RpuFPWzY8wJAhhAANeHLPqDHA/chr6Z/veRWlA0xZhtHDruVZlE7YpFx2+gsJZsmGhepZp+DKJBU/eHLGk+cbqsdxx8PZeJT5dwF0/PYreIVu25yB8l8cgrq7v3zqiQ+6mLnW/aI2daY8eaoWBbcOZafSVUqvAOJ7In2vTTo0X1ZZxi9t3Ew2GSgIlpA8khaaiuarev+hoBcyMn795pPyUr6n4vnPCl/g4eQbpd4cGT5B151jqNYuMAqJVD0bArsoYbkQZz93WmJEgqUKO4mvf+UW8X6VDgoaPl3V9SR7yqPKmJNicHifzt7HkJt3/2JbXwpqmz06w1wRMo2RiWtH59tD8JwhLegnMpeGylLY9AawBonumFVf8Eosho0Ffl6BvUkCGV1LNjY106he6ecyzSJ5AorzMr3VmRaB5phwkhQHalm4TVgScCVk5uX7yCkCZp+wyGK+6VfdoAIT4jA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(34096008)(376014)(1800799024)(10070799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTR1Sk9wNkJZTHhwSWY5Z0k5R0hFa1I5RnBGOHpjQ1VEY0psYjBmTjVROFBv?=
 =?utf-8?B?NjRGUEQrekVlSXBRWVlvWERtMmNhN3VSWXY1VXVDVFNGckFXNXdWSUZhQmFh?=
 =?utf-8?B?QmRJN3FSeVFtc0tyWmIxQUlPQXR1UG1zRDQ2SUlFaVpGVE1JVU9wQzlJM1h5?=
 =?utf-8?B?N2tDQTdjM2ZKeGlDTGgzOXJKem9LWEdDWk9jRk4vdGV3eWpXOG9aQU1QK0tQ?=
 =?utf-8?B?RDlxUzJmYWJzVjc1K3AvZmNpSGVaa1B0M2VSZXkwdVV6RUFwc3pBYWI5R0wy?=
 =?utf-8?B?U3g4VkptTWFKSDlzYWlMQnVESGVqNTcycXRLN2JaZDRkOFV3ZVo1QmJSRFJw?=
 =?utf-8?B?QzVjZjZicEMvUjRxWUJ6TTdYNmlvRndnK2pJVTlndWpuTytoQktrZWNGTXpX?=
 =?utf-8?B?eXVmV2RWL3F4ZlRqZ3c0NzZWcVRXZE1heHdSajJBazlPOFNCUU9mK0RndUpj?=
 =?utf-8?B?VFVTbW1ZU2dHNllMWVlYbmRoRVUvVFQrTUVLNzc2QlIzMEVsQ1hrcEJyUWV3?=
 =?utf-8?B?YUpISm9iVkxLcWtCRnRNRk5zZFVxbG91STNsSnA1Y3RlYlV3ckRSWEo2bjBM?=
 =?utf-8?B?K2IvdE1VWkpTS1lIWCtoMnpMZnBycCtiSmtsVFdnRlF4bDBGWEpaY1J5TDRt?=
 =?utf-8?B?ZGkvNVhqZml6WVpRUktnTjJ4RVZOdGJFNjhDbUdFd082NGQ0SlFiNlVIK1Aw?=
 =?utf-8?B?VHI4ZXZhc1pzOThJYjZTMzRnbHV5dzYwQ1JMeWdqdVRYR2wyRWNscnBLZ2Ex?=
 =?utf-8?B?WWU5WngvU3UxZCtWdElRZGpwakczODQ5WW9MM1MwZk1jSTluK2ZXQXMzZXh4?=
 =?utf-8?B?YjFwM2lKZzMrTmlxaUYraFlBMlptcjdsRmhRNTlqYWhxYVVLRVNVbFdRU0tq?=
 =?utf-8?B?QVdLc25Pbk5QUE5BZk9yK2NTZk85RGo4VmxvbENuN08wYnp5V21rMlBZMDkw?=
 =?utf-8?B?SmJxd0ZHaGF0bzB1QnNLclBMOUpvcmkwNU1DTHJFeW8wbUpMTlE2b0VhWFAz?=
 =?utf-8?B?Y0xYaEpxZ1ZHNWJmK2I0dzB5OS9pOStFSXlCZ3hVMFAvZEs2bDZHWHl2WmRk?=
 =?utf-8?B?TS9wWlZKQ25mZzhzSi9QTlhDUXN1dFZuYTBnTFNqZk0yZkJLcTNYclJ2MXM1?=
 =?utf-8?B?S1dPZkpzaWltUzZrOC9XQTJVWGhxSDhrZEsvNWRLV0kzWi94LzJYN0lNbmgx?=
 =?utf-8?B?Nkk0ODlzbCs5VDJ5WHI3Z1ZGUS9lWE5KRHVVbXNkQ0lLZnBtTDZFcUQ0Ny9I?=
 =?utf-8?B?V0NTSWNGd3AyeWMwTWgyc3pnS0g3VjRrNmtIb3N5a25FdXEwU1RkdWQ3V3E2?=
 =?utf-8?B?YS9tVDhIK1Rkd3VIOGNVTkdZMFpGeFYzeERoNXU3ODBKNkQ4MkUrSUJ1YkRr?=
 =?utf-8?B?VkxpeG9rdEJpaVpPN1VzUEN4S0t5NTdTRzQ5eEMreFQ5aDI0QUQreTVFTzhz?=
 =?utf-8?B?emhtYWd5eTVNUWkyZjd3cFNJQUgxUjBmZHlrdUxHeG12cGlaVElSc3ZHZHVi?=
 =?utf-8?B?YmZZMkNNSEtqUUlPZ0MxNzhvejBmYjdoRlQveWRhTHQ1YXJPeEpPREUyQWU3?=
 =?utf-8?B?T0F3WG4zNlI3RkdkWlRsdWQ3RHNmNWZBVnRZbTB6YlNvWGFla012YUdGTGIz?=
 =?utf-8?B?NVczVVlaSGp4cm9zb1R0K1NNV0FWcjBHdFA5MDhJZ05FenlGYlFxTFd3Z0N3?=
 =?utf-8?B?OWlxWmN0Y3BEcFh5bzB2NmY0blJQL2ZOaHlxMG9JeHQ3NzlpQjI4M01rSFhY?=
 =?utf-8?B?czFHVW1vZVVrckhDUDhwQVlmVjVKd0NBVFBvRld2SHFBZ29WbXU1Nmg2ZmNm?=
 =?utf-8?B?aEc4dE5RN21hUFNhb3JBWm5qYnRNZ0hxL3NNNWZ1QXNmaldsRStlTk44WG43?=
 =?utf-8?B?YWppUGlnN3dWellXQmxCS3pkN1V5clQ2ODl3akdhak5rSkY0T3VqaDNtYktq?=
 =?utf-8?B?UEllcjl0dVU0N2V6TldTZjVVZUdsZWZjemdYTzVZeExwSTNvYTlkMko5Wk13?=
 =?utf-8?B?ampVVzZ1T3VrSURQRm82WlRlWjBqaG5MdjRWNXVrSVk1eTF3OXErNFlHZU1T?=
 =?utf-8?B?Z0RqT2xEYmZQemkvQ3YydkwvcTJrQ09aWTJySjlPbEljMHU5eUVaRGJjeERL?=
 =?utf-8?B?MjkvR1ZMWWJWOXlLR0hJdTR2TzZFODl2Z0o3TUdXWFB3V25BUEpkMFdLYXVX?=
 =?utf-8?B?cWV6QmVWbGN5STFDNit0Smp6T3RLNHBuMU5UQlA5WTZicERiZFNTMlkxNmRQ?=
 =?utf-8?B?dVR3aW4xbnQzbTVuRis1bkZKZFQ1WS9SQTd6aFljNWtaOEN4OEJPYlV1eDhJ?=
 =?utf-8?B?Q1NwRkZnUnR3OG94eFJYTmxjZ003eVlXalM1K0NYZGRJZTZzUXRFWUpnaldw?=
 =?utf-8?Q?XtByooJcaaFYCpgc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47731ca8-9eab-456d-d317-08dedc2f245e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:53:36.7474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKdHu+x3Y15238HBRg7yu1IDqh6vEvXS+w6xaX4gqVAb8v7BG8cplDzyYY6VhpUy5+HXkVPFpDoPZ3T/0N/62LvnGT4xUkMSbsW9uiWP798=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6369
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 7, 2026 at 9:31 PM Chao Liu <chao.liu@processmission.com> wrote:
>
> I joined Process Mission over a month ago and have verified that sending
> patches from my new email address works as expected.
>
> Update my MAINTAINERS entries to use the new address for future upstream
> contributions.
>
> Signed-off-by: Chao Liu <chao.liu@processmission.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

