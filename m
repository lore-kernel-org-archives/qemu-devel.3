Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ACAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLu42-0003kx-CF; Thu, 12 Dec 2024 20:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tLu3z-0003kX-Ld; Thu, 12 Dec 2024 20:01:51 -0500
Received: from mail-sn1nam02on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2406::60a]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tLu3v-0005lP-8U; Thu, 12 Dec 2024 20:01:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwCFodITFpfahua5ruClRhoTYsdBEQMsd+OzH6qmfQrTSffd2CG9lSJQRkaNVSkF0VwkAqWMcgt4teQl4XZ5JfkeqopcBKRNzhxix805qMUu07X/iut2owfmRQOWX76vuM8XqunsdgBmZ/HOTQ+ytRUqbWDbxxXWM5uqDGO1WwX58TPHEKnH0/w7ktEZJ8P7dwEkDzroL3QbatM3YTUXmwaK1rUATtbrPDTcna+8g1JRjOL7EB1I8H7w262wOFH7jTTjPjKQR10yyWi+0poF0RjPrjA5lQWEybY8/XHrgbw6m5MSD1tIWV56ajfitjL44OoT2aqkXwJaqYZB7T6UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U43rTMhn4MhAgiKMfffVkXlL/O99xcYGCGLNB5i/AAs=;
 b=yOOLPWN5zTnKP1KuQXrlGPZhgqaDFWUGPeJkNGiUMA728iSgUi/grGAjBah+nPUc8MFhJEkfcc/MaTGKr4mQg3/bRzRiS0HXKgqKwJiUvthc92K5iaKv9oDVyZLl8bCEPnMkafMkkT5cYqkqzNozBsAprHBt54h1Dm0bqqXh8Nv6IeO/dwEZ1kKN0Jpv9Q4NgLeWrHr8r5BBlP1/y8DRPvgYtsKGG7Y7itQLdsZ6SMRfvyMx3FC0NXrX+sJdVkkVC582vqJkdDNtEs3pdIDjJVPhOU1qkQoGTLtQ8pYP3GRJdK3BSpfoSAQEXjCQJSxjM55aWftH8Gm36rm5P2wgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U43rTMhn4MhAgiKMfffVkXlL/O99xcYGCGLNB5i/AAs=;
 b=ADG0wcRBTEYR+ruMxGtfA5kjBR5fuYBb2ls43TaP3y0ZY4YvL7ySRsJu3ZmQtd3V7NJr58u1nvO0FB1+SrbG8ygo6fM/ochdq0jgKrDthTiZV9+vRBFQG3chjPGLIV/RYrC2erE5N2NoG4SduAgVaZhmOBnHRSRfExpxDBryzjAQ5Z+/NtJPlXBEazjXvSr/Tq7TV6LIK2VbA5YYVSQjQP0TYvzXW6fbQY9hUCKnaPz5U3bcOf8wcMT0FbUtaqZVIQwaAs/AHasfFMydc6Z+o8assH/x3m1fttTOVkBtEYtv9y9NE0SScNoAApvmj79ks2T0Zlnni1qceeD9aEixlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 01:01:37 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%6]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 01:01:37 +0000
Message-ID: <7e1a61c1-10cf-4bf3-b87a-a61b8b3b1548@nvidia.com>
Date: Thu, 12 Dec 2024 17:01:34 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
From: Nathan Chen <nathanc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, ddutile@redhat.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
 <1d4cf9bb-ae4b-4c4e-9b33-23c4eda96d92@nvidia.com>
Content-Language: en-US
In-Reply-To: <1d4cf9bb-ae4b-4c4e-9b33-23c4eda96d92@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:a03:505::26) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: ea576f1f-44d1-4bb6-59f7-08dd1b11b20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFBQWXhqcEJwQUdYeW9hQk9MVFJyS2lIaEVjRVVXdFp5b3UvOUJWUG9ZdEVu?=
 =?utf-8?B?eFNrUWp5bFRSQmdtdjhvSThDWW9qWXhIc2NkenVPMHB4aFI0aTRaMFF6dFNG?=
 =?utf-8?B?KytYMm0rdklaREFONzJ2ak0xTG5tUWdBelZMYnk0ZUJhK3d1MTVvSkladFpW?=
 =?utf-8?B?MVZhajBIb1Zxdk4zbG9hUitrYnB6dkF1TDYwVm5JaXJmY25vcnFrTFY2aGhW?=
 =?utf-8?B?WHNsOHg3eFYzcVNhSmxvY0xSZ1M3dk43RkhyKzVET2JldXV0NzFZOFZrMjhn?=
 =?utf-8?B?b0s5VEx3YUVYaWo4dk5OTElncU9RbXQ3NllBUWJuMXBJM0NQTXluZzYzUFhV?=
 =?utf-8?B?SGdDaG96MXZBa0dhUHRqL3llTEo2T21iK1BZRy9UYWtiMEZtdzVwOHpQODhG?=
 =?utf-8?B?eSttd2I3RS9zWlB2QVRYTVBPaGJRbDZJdStRTDBrYWwwTUdRS0dpMmpmdm9U?=
 =?utf-8?B?K3pXWXpRUWFhblJQM0FQZmVBR3puWVJsZ0thaXNQQm9zZDlkdUlHZkJ0c0Zq?=
 =?utf-8?B?UDdsR2F6OW1FSnRWcnFwMDlVS2FCK29oOXliVFFDMmhBSVBUdXlBcWRzQTlZ?=
 =?utf-8?B?Z0J0K3BIbk4zNWpiWFFzVUY1bUczRlFEWHU3VUQ1WE84NWFsNzdabWJ0RVBF?=
 =?utf-8?B?Mm5XcGRqUm1vOEMxNjhPaUI0ekJHVkJMSEc1eUxSaWJrU1FiOU1nUE9Gd2ZT?=
 =?utf-8?B?aE03UXd5eWhGL2tvYWFRM0YyeWNnaHB1WFlHRzQ0aFdlS2huYXhOckFpZnRE?=
 =?utf-8?B?cUpUZTNFZFFERm4vV0RFKy80M1hCYVZrQTZYNGY0YW91Um5NOVhpeDUvZjlE?=
 =?utf-8?B?SFlNenJ0bmY0VE40dTNQNG9kcUJOMGlGRThoaW5XOUFNUnFqemt0TEZSUld0?=
 =?utf-8?B?Tnc5bG5zeXo3NXdWdUtKdnRHcGRNMXZxNVlndjAvRzU2cFpTMlV5dXFIRE9j?=
 =?utf-8?B?Vlcwd3p0dkhKY2w5ams5Nk1RNFY1ekR5L1hWZ0RTYm4rVkMxdmQrdmsycEUv?=
 =?utf-8?B?TTRsOTVPMnN0TlFsbUhKdUVhUmxjaXU4ZjIvQUMzbS9zc2lyalBhSmhsR2tI?=
 =?utf-8?B?UzU2L1F6U3YzV2RqWnFRRVJQMWdNbDIyUHN3SWtNaUF5eWFzbktBTEI3OXI2?=
 =?utf-8?B?S2U3UWNzNmJZdHdDV2dkM3ltZEtGbkoxd0NxSHp1OGc2QXVGMk9OUXN1dXh6?=
 =?utf-8?B?b29VcWZxYlc2WmFYdUxHbEd5YmhISHd4Y1dKYjhyTEEzMDFGaXMvTmJ3M01E?=
 =?utf-8?B?R01QQjdWelROaTEzT1FYMUczZWdrM2dhaXp1NkJRNkowTS94OVBBUEVYRHNR?=
 =?utf-8?B?ZExBY1c3Ris4aDViMHhBWWJOY1BZbXFJVWliUENxNEhSS2UweHh3ajd1NTJx?=
 =?utf-8?B?aEpybWFDd1M5V0dNc2YzUDhCM05PSFlNY2tTV1BWWkFtM0tuWEgxYUlzVVNO?=
 =?utf-8?B?dW0yVzhjaWJkL25lWG5XUXN1NkY5eDBTa1B1enVFaHM4QkM0WDgxZUZQZUI2?=
 =?utf-8?B?WUcra2pFL04yc3pyN1JneTlyZWxNbTVzYUxrNnRJZ1dQYnNzMll2dG8yYk1U?=
 =?utf-8?B?b2ZyRU1mblc3WlJqRTJpcWFMWjN0MDJIU0xhTGIrcC9TYWZTSXd1d3Z2Q2Ni?=
 =?utf-8?B?bmdEcGRNTWRwYUsxVHZjMXJLTmNYNW01c29NaG1WYlZsd2JZOU1JYUpJYzVK?=
 =?utf-8?B?UmtETmprVTRmMTZPS0doODc0MEZLM0NvSTZYWnhXT2YwV1h2TmRodU4veU9D?=
 =?utf-8?B?b05vRGUwV1ZueDlMRFBReUMrRXkyT3Z4L3lQMmhjUDJZbzB1TTRrdkNrREFm?=
 =?utf-8?B?ZmxvcGk0Ym5ML2c5eFFDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDI4STlBZE90SFNuU01CNGdPaXFnWVd5a05ZVFpYMnhoS0JIYURNOHFmY3NB?=
 =?utf-8?B?UTN4UGdwQkozbDlPNERuTnBjakVickpyUXZDc0NaU3Y3RkYzRlJVWVBIQUFj?=
 =?utf-8?B?bkFJejRqUE9XZkNBTG5ScFloZkZvVGIyd05GdFRqVG1adDRwQmo0SVA2SUZ1?=
 =?utf-8?B?SVV1RGswdklXUVA1TlI4TGJqLzlWRUtIYjIxWVk2Vyt1aFcyZjBtSVV2bDlK?=
 =?utf-8?B?NzIrUkdiY0F3WlJ3Y0h5NVU0dzlJK0d5cktDTnppWk04Z0pJcnc0Y09lakdm?=
 =?utf-8?B?djJLQXAxWEpvL2Z5OS9pbGlGemMxdVZ2UU5WcDBiZTQ3T3l1ZWNNYnN1Vk4r?=
 =?utf-8?B?UkNodm5vTCswWVprOG1BWEtZbm8yOUpjdnBpVEo3eU55L2p4T0hCeDN4S21G?=
 =?utf-8?B?Z0EwUnRQL09neVlEZmcyUThNSVV3U3hKMUJSc0pDTXg0Y29Gb3Z3MGt4Y3I2?=
 =?utf-8?B?K0VQaEFRSW9rdVZSTURDQ3pJbThtS3JMS3Z0a0UzbENIWkhvUXZPSUpOMU1M?=
 =?utf-8?B?LzIvd3E1dUl1eXoza3h5OXFLalRhdHpqRXpocWlnTngyamVlNTFpZ1BBWHFa?=
 =?utf-8?B?TFdhMEt0UWlkVklNeGg4YUJDaXJqNFFXTnkwYnA4VG5DVk1HVDZZTTFLN2N1?=
 =?utf-8?B?bHlreWhqNkY4MmlOcTNCQ091NEJVV2NTb05hS3AvV2piVkRIMU1LVS9qUkg5?=
 =?utf-8?B?RjJRMm16TTBIUHM3bEVxaG9yYk0ya2tCbExaYUVPZDdkdy94d0R5ZVJLSXBx?=
 =?utf-8?B?dDVnZkE0ZGR1VjV6MHVzMG45Vy9BbUFVbndrcy96YitYYWRJeGowNEZrWnVN?=
 =?utf-8?B?MC8wS2wwZm4waXZucEtCSG9yNWxMRU95REt2TkhnTEpsS25sMDVSWjB0Sm1I?=
 =?utf-8?B?Vkh5cjM3eFRZZThNNkJsb3MzNnVzd1VTS2lrQWRqa2RDaWVtSzhhellyeUFm?=
 =?utf-8?B?enRVRG9SV3lyQlhVVWpjNXpSakpzVkZWNS9TRkdnKzFmNXc3NUxBUGU3RG5n?=
 =?utf-8?B?cSs0MlhjdzJHTzRWUHovWEovRGhrd29xcXdDM1gyR0tDMGZrRTIwOW5UeDFJ?=
 =?utf-8?B?cWlscWhRUnhvZ0loTXp2ZGQ4RWJRM2h0eEJMa2FlUGtHZFdzQTZnaTJRN05Z?=
 =?utf-8?B?Y1pnVVViMGJhd1J4cmpYckhDc0UyTzNNc09kMFM4T0VTeXcyTFhTOFJiVlJ1?=
 =?utf-8?B?czJneTdMYmZYbTVzUkp5eFdyZWcxUk1BZTUvTW05eVRuYnl1UjZhQjM3YUdF?=
 =?utf-8?B?RU5WM2ZsZXEwUXBzQXJjaE1QcDhkdjZiODVwOUxhMFhyNE51bHdQNFpod2hC?=
 =?utf-8?B?clpteWZsOW04aXdxVnRFTG5ha1V6MXh0ZktMUXczREFQNlJTSURQd2cwTHdk?=
 =?utf-8?B?VzVmWVJsZ0NWd2hqRmtOQkN3NmZBS1hYRUh5T3J4cXNFL2VMN1FrMjdLY0gz?=
 =?utf-8?B?TmlER3p0Z3NVc3N0dG5KSHJ5Ym1CT2xZZ3h5K1gyMEVhZGczbmp6M3NCdU1T?=
 =?utf-8?B?aWplSzZZYkcwZUxNRGM1Z1liSGFoYVhtN3h2RmwzSFJaREJmajY3eXlPT3FF?=
 =?utf-8?B?TG80eUJqTEF4RERxZUJKNVdGVlA2MW1iMllvbWlQRGdUZFJuWVpaSm0zUEZO?=
 =?utf-8?B?alU3NVhmcjNsbVNPalRLYnpLZ3lFcFR4ZU56OHJMbXBTclVNOFp5YXlIRmM4?=
 =?utf-8?B?YU5PV0hWK2V2bkNxa1REZTdVK21maGlBUThYYTB3SGZ1T1g4RUl1bDR5ZFZJ?=
 =?utf-8?B?bWVmMnl6SmtjK1dUYmIxZWpWWWE3Nlk5QW9ZdFZmVnc2MjR4NzNIZDF0YjMy?=
 =?utf-8?B?M1ZOU1dDK2xXclNxY1gxOEtuV2M5c3N3NW84N1FwUUlEWXdYY1BUYWIzQzRx?=
 =?utf-8?B?M2hWTkNwSzdhZXhSUlVrMUxqaEdFWnZybFZHZTRwOVBZMC9maFdITU5QTHNS?=
 =?utf-8?B?b2V4Q1JzVDNzcmRXNXIyeXZKTitmakRVZE9yaTc5UnRieDRGcVh2OUZpR1c2?=
 =?utf-8?B?WUJaa0lGam8yWnRYTW81NzhYZE16NlBiRldTMFJpTk1yc0QzT2xmZi9XYzg0?=
 =?utf-8?B?UzZwN2VkaGFZMDM1RkZ0THFTZXFVQ3hNc3J2amI4aDNmZ00xZlBZKy9VZmdI?=
 =?utf-8?Q?4nTGfxrlvT7BWP5EW++fHPY9n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea576f1f-44d1-4bb6-59f7-08dd1b11b20a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 01:01:37.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJm19LE2ppBOk/Czz4G6tVXSegL1sDvt7L2VB6Kx88iQkKsolPXoFh+KVSy13leBqRGb1Ql2HxwNqh6eUphcrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
Received-SPF: softfail client-ip=2a01:111:f403:2406::60a;
 envelope-from=nathanc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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


 >with an error message indicating DMA mapping failed for the 
passthrough >devices.

A correction - the message indicates UEFI failed to find a mapping for 
the boot partition ("map: no mapping found"), not that DMA mapping 
failed. But earlier EDK debug logs still show PCI host bridge resource 
conflicts for the passthrough devices that seem related to the VM boot 
failure.

