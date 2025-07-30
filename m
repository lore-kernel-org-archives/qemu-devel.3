Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41539C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDS8-0005Eg-1B; Wed, 30 Jul 2025 16:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCE1-0007Z6-Jm; Wed, 30 Jul 2025 15:12:34 -0400
Received: from mail-bn1nam02on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61f]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCDy-0007gO-Vr; Wed, 30 Jul 2025 15:12:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJyshfIu476+5z2OwNuWoyfviZagInJRjHptkNYFbde76UZPZL3w7yFSaHh4I55lAhq4D947DHDbGyrEY8easSiWYhzYatv4K5rh4pr6L8VIZ0R0Fs6oVe1fR4VQ9WqeAgUlyDspmTbtkBRujcOLCzX1NEa7JF/OCcT1P4xb9psU01nW0Jw2zENJgHE9/SX9wdBIz1vL+r8R8ShsLLpKF1ZX4/QWabWil+Hq35IHtcr4e9DGHFc2KS+N79kv/6RrHz/1vrKlUpuX1YAtewO2JzvNjL7RkUbd/c5xZlGB5EsYvaZ7Pl0Ew/cnBiKwRYKs1/xCRPiPITQzUv2t+9QgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJzb0X01tpRx6XcHCk4jepYNFfvogW3k8331V6aIiyo=;
 b=rLevn10ZC2tthTkC3UvnyzqKqG+QlTD+GT0krNtDoIv2e4Hem+WDbOHnausDg4R92cgtdEQNWYcyGL6GgS+yUnLsUcnWoaPGIdA9JeVNKHUf04OpDCS7LWZPBbRaceGCldNzci8sifUhs2IFviVlvQbkXHYSvJov5mv6qdk/v6jZWQr3h3QQQrIEcm76BhZgX1+DRwBMYMSGjGoduQXUHekn0UkeQ4U0P/OwcF5yyWOCjMnDcyaCBbyqShOPCdSMgNnuDg+kif/VOtCH4JqkJmhkYmrD6NshdJghAtuDJyvQt77OQ2JfFrFgkrGaE+MN74bUHYePQTEkDAssy61b5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJzb0X01tpRx6XcHCk4jepYNFfvogW3k8331V6aIiyo=;
 b=QfGHZbzn5AL8tWNxS7lod4fsa3IDvVBDiSOYZx5TigSxZm6EIVdU4DJgFCIWytfM7tPaTkSHY2l8xqBDLMg+GQ3YMEmbmBzKNqet+U+k0pzW0Hgevj0eUGN5mEzIXITeItAXWowzLMeHlXR9DpfIOXOfcxbhTncsP4tQzb/+v+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:12:22 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:12:22 +0000
Date: Wed, 30 Jul 2025 21:12:16 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 29/48] hw/arm/xlnx-versal: ddr: refactor creation
Message-ID: <aIpukMOXsbocNfpg@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-30-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-30-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0298.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::15) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: be91f151-8f39-4718-88f8-08ddcf9d02ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0diOG1zM25ZbUhCSGo1ZjlUZHNxL21raGsydXhWa0RxVERhcUM3b1dsUEpo?=
 =?utf-8?B?TlVoWFVvUE5mWkxHUUlqU2ViMXhjcjJXczVaQzd5d1BJbVZCaXQ1Y3NPcXJT?=
 =?utf-8?B?RlZMYmhKcDdwcjdMYkJ3ZkI1VDJoU09iclBrMjlMSU9JZEJNMENGbzZ4NnFJ?=
 =?utf-8?B?M1RUNmtIM3Y2OFNjNkdmVWV2TzlZck5FVVEwTklaV0ExeTFXc1RLN09qWkh6?=
 =?utf-8?B?U3phdWJ5UmwwbUhLOUJneVRhbG0wMmFYREZJaFNpWHhKR0xkUFU2S1NXd1Qv?=
 =?utf-8?B?Y2ttb1BhMTBqV0xDR29pLzZaUUx4M3BRRnI4L3pEeDR1VlJUOWhIUkpvTHRC?=
 =?utf-8?B?dFBTejdEYlNSbXJDWUo5R2IzcXlTSCtqYjJudGFLREJJSXVydENjUWxoVmxL?=
 =?utf-8?B?ZmpMOGdld1hTdzJQcUtWRCtMVUlzcTE2S3FsTGF4OUNTaXh0VkVnYk90VGJr?=
 =?utf-8?B?azlIOGZWb3didjlDUktzTm9NUnlBMXZWdmwvWjJnTitWWTExSTdnZ3JpU0ov?=
 =?utf-8?B?Y3A2UDh2RzZKRWVsa3FVUVlnWXovV1g2d21pRUZyN3FsNGxXdGwyQW16ZUR3?=
 =?utf-8?B?MUdZUGp1cWU3Q1dTN2RGR3FWUnE1bE1Gc3VhN0JYeXNXcWFWb1E5VVM5aGRs?=
 =?utf-8?B?TXYweHRESHZqTGpSSzdKYi96STQrcnoyaGZVanhGTDNwQ293eUJBdGgwZXB1?=
 =?utf-8?B?MTRISHlaSzNQcUtzdEhvNnN3ZFpxUmluZGZ4WG1vZnhzOVdIUTh4ZVFXQU1W?=
 =?utf-8?B?T3h1S1hUQWVwbTMxY3A2RXlBZXNOanhNNkM5bkF5RktCS0xIR2huTWY1LzVj?=
 =?utf-8?B?V2lWQmxKTEIvMFZCVVl3QUk5Z1NJWmgxRmw0Y0kzMXpwS3ZmeDV0TWpFYTFY?=
 =?utf-8?B?ejgyeHVXS0xaU1lGU3M3cEdLVllkaW5TME9vMDNPVTFzWkVqek45d01mZzB0?=
 =?utf-8?B?cWZpTlpsY09yQVdmRmFra2VBUkNLNHdBckVFNkpmTjBkUzhlNGpZWGFzb1dt?=
 =?utf-8?B?MlR5YllRQnFHd3hYbnNVV2ErVytUMjZJbEROaldEd2tLRHdSSXVlUXJwbEpa?=
 =?utf-8?B?MFhsZ3pMREZRZ0trekk2MkhSc1ZlcDE3SUI1NGlHVUZlMTA3eGgrNUVFZ05G?=
 =?utf-8?B?b1FKSDBPVHVpUm5HazNMSUdhZXVaQnF0TFZYc1ltYjJlSW1yUTBtbVF3TG9I?=
 =?utf-8?B?NWw3WVhxdmRPeERHYzVSS2x1R2t3RUpLUVBodVlkRTJoOVdmR1R6LzY2R0F0?=
 =?utf-8?B?WTZidXBxSGhwUlE0T1liNVZDOGFRSEMxOU9yYjc4bWRpTEFQT1JiQmJrTm43?=
 =?utf-8?B?Qk52TWZWZnYzVXBFbGc3Tk5WY080UzNDRDVhUk5DRi8ycUpzUWYwZFh2YjBO?=
 =?utf-8?B?dTBiTUp2UFBscWxpcndBYnhOZTFYS2NCLzZyZU41Si9VeEQvc0FxTGRvVzBv?=
 =?utf-8?B?aTkzZmpRZEEzeUhBQjZWQ0lzQVkvRC90YkdZaWljMTJEQUxBV2IvZ2kzdTNU?=
 =?utf-8?B?aS92a2J5aWJYRGdBeWFoa3lvbnlPRVNsZXpYVUlzQk55SGpHcTlMdlR0eCtM?=
 =?utf-8?B?SUVsN0x0bEtMNkRhanJlUGxsT2RZR1lpV25qSVRJU0Z2T0xaRlhIM3FRTUFR?=
 =?utf-8?B?dUVIV3J6TitpVHY2a0k3MEdmclhNNE84UXJEUmtSN01YYjVtRGp6M0xBZWRz?=
 =?utf-8?B?bFpZcytDVUxJaytNNzVDMHRNc2Jxa3JKV05STERnc0hzUzFkcmFKYithTCsy?=
 =?utf-8?B?V2hHUHZKckJOY1o1OWNKQlJwUDJtTDdNMlQ2OWJXN3dpdXpZdmlRdU5UcjJ0?=
 =?utf-8?B?VXNna2hubmUybGgvYkcvdjByejZoamEyRHc1QlRDYWRvNnVrcjNaQU00OGpp?=
 =?utf-8?B?dXRJRytRbUVoN21RSDNVQ2VuVU5sMWdENWVKSGk4TXVNWWE4dlB5N3lOR2Iz?=
 =?utf-8?Q?FOmx/j/WxfY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tmTktUV0pScE5QVGcxVjRCd3ZPRVNqMXJPdmJYVjlzSEQ5ZkpPRmJwdkQy?=
 =?utf-8?B?OXFSb1oxZmhRN3F2SjhEZlY4MXc1RTVWZFQwQ0JXV01HaXN1MnhRSlAxM2xn?=
 =?utf-8?B?S083cEhQUU9DSjZWdTRNaFpwWVZxamFmY2pwZ0RrRFE5WlZwbGV2UmdDdUdh?=
 =?utf-8?B?ZWp6QXJHWFhINFZmUjlrejd4bXJCb0dYbGM5K2JyQjJpeldVTk9uYzJMUlhH?=
 =?utf-8?B?RU4ycHlrVk1XN1RVR1UvaktESFVRRGxFamFJTEQxVHY2TjFvblhUNzMveEJz?=
 =?utf-8?B?MDlkRzVuN2QzUml3QWp0MTRGWFFZYVJBbG5uclNqUm9uZ3RUTEZhZEhJMEl2?=
 =?utf-8?B?S2szQldJT2U2b2V5ZWErMnVKZ2RjQjlxd3UydFpybGdtOUt5Ylh6ZjQ1dzJu?=
 =?utf-8?B?YVFQck5HYytJUDJBSFNYSUxiU2NPL0ZPdVZRVTVMczB1alQ2V1JUUlJpK1VW?=
 =?utf-8?B?Ujd2TVJKcTA0UTRuNE1TekFnNmY4c3JtZXdOL0tGWlhIdEJtN0tiZHJvNFVW?=
 =?utf-8?B?RDJJOVdDbGMxVjBkdEhTak4zN1YyYm5TZXpsWnZPZ3RTRkErYzJXVElVNlpv?=
 =?utf-8?B?YnJVMkpEdGxDQzZmaTZuVTdHSmg4bzIyWFBnMjV5WkF5NWwzTHBDVU5xVHdl?=
 =?utf-8?B?VWdvU0lGS2sycUEvVzFSdncrblcyV25qWnFEY05BTVVTUGE0aDR1N3dCYjhw?=
 =?utf-8?B?M3dBTHV4WGlFcEpBVUxPeFVFaUhDWGoyb0VOUFU4Sy9vKzRONG15cFpmYzJ0?=
 =?utf-8?B?TGFxQnN5TFl4Uk92VGtLNlpzcjdzcHpZdC94Q2NLejEzaUFkUUNiVjBpOFB1?=
 =?utf-8?B?cFhEY0p0T3JuSjdZRVczOFJjMWkraDMzS1BDWmszYUxJZml6SWQ2QTQzSWgx?=
 =?utf-8?B?amNjNTBxNXlYem5CMmhkMm1OdDV3cWNKaGp6Y0dDamhDbjllSWxmS2NUUHZq?=
 =?utf-8?B?N0gzd2YraXFyeHFDQzg1TlpiN29uNFdxcVIxV3ArVDFIem13KytTK01Ud2I2?=
 =?utf-8?B?NWY1ODU0QVRjdEY1ZVBYelFsV2RxYjN0RFlHQjVESnhEVE1jNlFxcHNySmF4?=
 =?utf-8?B?WjlndWRWaU1hRUEydXBGTXVBZTg0MkVkc2Y3UCtIVWQzcFFqc25yWTVTV3RJ?=
 =?utf-8?B?VG9STmV3QzVGbEJWS2hGNWRxb1g0YTMyZ0VoU0VldDB5NC9BYjkvVnhyQUg5?=
 =?utf-8?B?d2NsK1RRRFk5NzlxdUZrNGVEdVBCeFYzMll0bHVIL3RnZ21WY0JvT3p2VTJl?=
 =?utf-8?B?QStYOEw3R3k2dEdxcVR1VGZMRWlHZXJRVmZuQ1BLU1lWV203TjB1WUdwZ0xk?=
 =?utf-8?B?MDhhdEpPbGVhSWV5aGhGelhZbDlRUzhoVWJidTlBSCthaldGQkwyZjFsMEhk?=
 =?utf-8?B?UXlXV0REQzNrWjFKMWwyZFVKZUZDcVpRMkp6Z0pIUkU1LytWYmFiR1gvWmJU?=
 =?utf-8?B?YUZoVGlxaGhvK0xrOUltNnFJaE10RHV4eFY4dHlMR3dqWTN5U0t5eUN5ZC9r?=
 =?utf-8?B?cUJFc1lQQ1ZZcnFvQ3dhUmJGUDVGQWEydHNDSWVQWEVOb2E5U2dXelEzVzdQ?=
 =?utf-8?B?U01ORSt6Wk96aVZzV3FEdk9BdjY4RHdmRWZ1bGgydGVXYURvMWxMOVlmaW02?=
 =?utf-8?B?MkUwNnF5aXlpcENHSmdUMUowRDBXY214c2hRRC8zdndSUGlUMDA5UzNUTys5?=
 =?utf-8?B?ZEx3eDVYSFVzQVB6UCtNYkJTMi9jb2d4U2ZETi9MdjBydGdSZTNoajkrbW5F?=
 =?utf-8?B?YkdZa05iU04xWUdTYTkraEt0enpiLzRvQjRzVmJRKzl1VlFaaXppUERzZE9y?=
 =?utf-8?B?QzA1Z2hBanlmZklZTkozdEUvbm45UTltMXg0R1F1Z3BHNFRRNFVWUTZPRHJS?=
 =?utf-8?B?UmtNTm1Mbnc1Y2VwT2pSY1dPVXlCNmN5YjdiMUF5dlVDY1RyUjZJbjVpZWpD?=
 =?utf-8?B?YWdnNEIvSUNEeUFZcFFYL1pXVStUN054bCtySlo4eGJkWE1rWmtlYkp3Z0Zz?=
 =?utf-8?B?cW9rODhXOGtLOWZuSHFzT1hEM2d0Rkk4M2lIOHV3K28yNURsUkN5Sjc1STk0?=
 =?utf-8?B?eGRQVm9TZEJva3BBUzhsaHhCVXBGbE1OZjNURVZ0S2oya29NeVc3RE1yMFRL?=
 =?utf-8?Q?qfrtbEmHUVRkKkcG/XNOQ9uH6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be91f151-8f39-4718-88f8-08ddcf9d02ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:12:22.0777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBaMXjLDfz86oGXCvZ6dHFJEl2rfcUULOhcLSn6Wf0unKdQSSeZWHag9ZQdv8iaOYAJ404Q9a7GMEWup5ucLbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
Received-SPF: permerror client-ip=2a01:111:f403:2407::61f;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:11AM +0200, Luc Michel wrote:
> Refactor the DDR aperture regions creation using the VersalMap
> structure. Device creation and FDT node creation are split into two
> functions because the later must happen during ARM virtual bootloader
> modify_dtb callback.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  7 +---
>  hw/arm/xlnx-versal-virt.c    | 79 +-----------------------------------
>  hw/arm/xlnx-versal.c         | 73 ++++++++++++++++++++++-----------
>  3 files changed, 53 insertions(+), 106 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 7be5a6ccf4d..a3bc967c352 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -41,15 +41,10 @@ struct Versal {
>  
>      /*< public >*/
>      GArray *intc;
>      MemoryRegion mr_ps;
>  
> -    struct {
> -        /* 4 ranges to access DDR.  */
> -        MemoryRegion mr_ddr_ranges[4];
> -    } noc;
> -
>      struct {
>          uint32_t clk_25mhz;
>          uint32_t clk_125mhz;
>          uint32_t gic;
>      } phandle;
> @@ -71,10 +66,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
>  {
>      g_assert(!qdev_is_realized(DEVICE(s)));
>      s->cfg.fdt = fdt;
>  }
>  
> +void versal_fdt_add_memory_nodes(Versal *s, uint64_t ram_size);
> +
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
>  void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
>  void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
>  void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
>                                BlockBackend *blk);
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index cad345b98e0..7f40c197072 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -104,92 +104,17 @@ static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>          n++;
>      }
>      g_strfreev(node_path);
>  }
>  
> -static void fdt_add_memory_nodes(VersalVirt *s, void *fdt, uint64_t ram_size)
> -{
> -    /* Describes the various split DDR access regions.  */
> -    static const struct {
> -        uint64_t base;
> -        uint64_t size;
> -    } addr_ranges[] = {
> -        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
> -        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
> -        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
> -        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
> -    };
> -    uint64_t mem_reg_prop[8] = {0};
> -    uint64_t size = ram_size;
> -    Error *err = NULL;
> -    char *name;
> -    int i;
> -
> -    fdt_nop_memory_nodes(fdt, &err);
> -    if (err) {
> -        error_report_err(err);
> -        return;
> -    }
> -
> -    name = g_strdup_printf("/memory@%x", MM_TOP_DDR);
> -    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
> -        uint64_t mapsize;
> -
> -        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
> -
> -        mem_reg_prop[i * 2] = addr_ranges[i].base;
> -        mem_reg_prop[i * 2 + 1] = mapsize;
> -        size -= mapsize;
> -    }
> -    qemu_fdt_add_subnode(fdt, name);
> -    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
> -
> -    switch (i) {
> -    case 1:
> -        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> -                                     2, mem_reg_prop[0],
> -                                     2, mem_reg_prop[1]);
> -        break;
> -    case 2:
> -        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> -                                     2, mem_reg_prop[0],
> -                                     2, mem_reg_prop[1],
> -                                     2, mem_reg_prop[2],
> -                                     2, mem_reg_prop[3]);
> -        break;
> -    case 3:
> -        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> -                                     2, mem_reg_prop[0],
> -                                     2, mem_reg_prop[1],
> -                                     2, mem_reg_prop[2],
> -                                     2, mem_reg_prop[3],
> -                                     2, mem_reg_prop[4],
> -                                     2, mem_reg_prop[5]);
> -        break;
> -    case 4:
> -        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> -                                     2, mem_reg_prop[0],
> -                                     2, mem_reg_prop[1],
> -                                     2, mem_reg_prop[2],
> -                                     2, mem_reg_prop[3],
> -                                     2, mem_reg_prop[4],
> -                                     2, mem_reg_prop[5],
> -                                     2, mem_reg_prop[6],
> -                                     2, mem_reg_prop[7]);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -    g_free(name);
> -}
> -
>  static void versal_virt_modify_dtb(const struct arm_boot_info *binfo,
>                                      void *fdt)
>  {
>      VersalVirt *s = container_of(binfo, VersalVirt, binfo);
>  
> -    fdt_add_memory_nodes(s, fdt, binfo->ram_size);
> +    fdt_nop_memory_nodes(s->fdt, &error_abort);
> +    versal_fdt_add_memory_nodes(&s->soc, binfo->ram_size);
>  }
>  
>  static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
>                                    int *fdt_size)
>  {
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index f46c73ac8e7..bf680077e48 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -115,10 +115,15 @@ typedef struct VersalCpuClusterMap {
>  } VersalCpuClusterMap;
>  
>  typedef struct VersalMap {
>      VersalMemMap ocm;
>  
> +    struct VersalDDRMap {
> +        VersalMemMap chan[4];
> +        size_t num_chan;
> +    } ddr;
> +
>      VersalCpuClusterMap apu;
>      VersalCpuClusterMap rpu;
>  
>      VersalSimplePeriphMap uart[2];
>      size_t num_uart;
> @@ -219,10 +224,18 @@ static const VersalMap VERSAL_MAP = {
>      .ocm = {
>          .addr = 0xfffc0000,
>          .size = 0x40000,
>      },
>  
> +    .ddr = {
> +        .chan[0] = { .addr = 0x0, .size = 2 * GiB },
> +        .chan[1] = { .addr = 0x800000000ull, .size = 32 * GiB },
> +        .chan[2] = { .addr = 0xc00000000ull, .size = 256 * GiB },
> +        .chan[3] = { .addr = 0x10000000000ull, .size = 734 * GiB },
> +        .num_chan = 4,
> +    },
> +
>      .apu = {
>          .name = "apu",
>          .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
>          .num_cluster = 1,
>          .num_core = 2,
> @@ -1480,50 +1493,62 @@ static inline void versal_create_crl(Versal *s)
>                                  sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>  
>      versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
>  }
>  
> -/* This takes the board allocated linear DDR memory and creates aliases
> +/*
> + * This takes the board allocated linear DDR memory and creates aliases
>   * for each split DDR range/aperture on the Versal address map.
>   */
> -static void versal_map_ddr(Versal *s)
> +static void versal_map_ddr(Versal *s, const struct VersalDDRMap *map)
>  {
>      uint64_t size = memory_region_size(s->cfg.mr_ddr);
> -    /* Describes the various split DDR access regions.  */
> -    static const struct {
> -        uint64_t base;
> -        uint64_t size;
> -    } addr_ranges[] = {
> -        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
> -        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
> -        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
> -        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
> -    };
>      uint64_t offset = 0;
>      int i;
>  
> -    assert(ARRAY_SIZE(addr_ranges) == ARRAY_SIZE(s->noc.mr_ddr_ranges));
> -    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
> -        char *name;
> +    for (i = 0; i < map->num_chan && size; i++) {
>          uint64_t mapsize;
> +        MemoryRegion *alias;
> +
> +        mapsize = MIN(size, map->chan[i].size);
>  
> -        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
> -        name = g_strdup_printf("noc-ddr-range%d", i);
>          /* Create the MR alias.  */
> -        memory_region_init_alias(&s->noc.mr_ddr_ranges[i], OBJECT(s),
> -                                 name, s->cfg.mr_ddr,
> -                                 offset, mapsize);
> +        alias = g_new(MemoryRegion, 1);
> +        memory_region_init_alias(alias, OBJECT(s), "noc-ddr-range",
> +                                 s->cfg.mr_ddr, offset, mapsize);
>  
>          /* Map it onto the NoC MR.  */
> -        memory_region_add_subregion(&s->mr_ps, addr_ranges[i].base,
> -                                    &s->noc.mr_ddr_ranges[i]);
> +        memory_region_add_subregion(&s->mr_ps, map->chan[i].addr, alias);
>          offset += mapsize;
>          size -= mapsize;
> -        g_free(name);
>      }
>  }
>  
> +void versal_fdt_add_memory_nodes(Versal *s, uint64_t size)
> +{
> +    const struct VersalDDRMap *map = &versal_get_map(s)->ddr;
> +    g_autofree char *node;
> +    g_autofree uint64_t *reg;
> +    int i;
> +
> +    reg = g_new(uint64_t, map->num_chan * 2);
> +
> +    for (i = 0; i < map->num_chan && size; i++) {
> +        uint64_t mapsize;
> +
> +        mapsize = MIN(size, map->chan[i].size);
> +
> +        reg[i * 2] = cpu_to_be64(map->chan[i].addr);
> +        reg[i * 2 + 1] = cpu_to_be64(mapsize);
> +
> +        size -= mapsize;
> +    }
> +
> +    node = versal_fdt_add_subnode(s, "/memory", 0, "memory", sizeof("memory"));
> +    qemu_fdt_setprop(s->cfg.fdt, node, "reg", reg, sizeof(uint64_t) * i * 2);
> +}
> +
>  static void versal_unimp_area(Versal *s, const char *name,
>                                  MemoryRegion *mr,
>                                  hwaddr base, hwaddr size)
>  {
>      DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
> @@ -1687,11 +1712,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      versal_create_trng(s, &map->trng);
>      versal_create_rtc(s, &map->rtc);
>      versal_create_cfu(s, &map->cfu);
>      versal_create_crl(s);
>  
> -    versal_map_ddr(s);
> +    versal_map_ddr(s, &map->ddr);
>      versal_unimp(s);
>  
>      /* Create the On Chip Memory (OCM).  */
>      ocm = g_new(MemoryRegion, 1);
>      memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
> -- 
> 2.50.0
> 

