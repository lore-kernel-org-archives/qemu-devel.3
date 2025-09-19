Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B69CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWnC-0000ve-6M; Fri, 19 Sep 2025 04:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWn9-0000vG-9J; Fri, 19 Sep 2025 04:48:31 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWn2-000694-UT; Fri, 19 Sep 2025 04:48:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVZ02GloE3X3cRjeV4ZuRR4C+oBug061If/hoUY57F8vhz5EIj9B/NBQsMaSpDCAKDjeDnTB1XXg772rxyZFn2XopMz1WG+bygmYbjXpzu/dABSll/JsGL44O80bCkGoRfO7dcRW24HHW55Dts+brqPUD4OuijXVTpHXtTg7kLr11+zGD/VQnePUQIwPAXGrAxJUwuiczryun/MOy610Hd5nzXoW2VmRwUCZhnsPf39xk9QiYvCSvJEfncrNxhNIvTuPpNFmVCcB8BtnnvqbsGutJD9cCdJ8AUi7vFLO9G7djbl6Vadl+XSTAViwBSGPH02ehhD1KgkmGUUdNt4mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNCtaOS2mzfGcy/QxEwiLkQU5eP6Xgl2kkTKWq+zO74=;
 b=rTE9qL0XtiEXNhD80+MEKY/dbMlUVQt915xc2oIVRwLcvM9f1WBveHmoCnFlGlK3i8yOY/Re2T1BUFFaJAsnMVuu7HFEsDE5Pr0ete+ZaogwAVbvEdUSpQsP/g6pOi22Cu31CGNLM+5/G/8v4zQ88Cw1VNVG4AvIXXRhmo2jFIVggmcj6m7xKvZ1Wg9tab8emR12wnatk2FV1CZSpr40kev0PdNmWxs+035XVc/NfkII7+7aXicWHKEdn2AV0MQUlXgPGxEHjUFHLLmjpMGQgnzMLYj72jPc1kYtm5iPVqXHlATygZ+dsSnG7f5ykABE/NI2BLASUXRcFBa1e+n/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNCtaOS2mzfGcy/QxEwiLkQU5eP6Xgl2kkTKWq+zO74=;
 b=oxTRBrcJxHJx5/zvBonknMFYrcXyERJl1P3eeyNZu1zAT4aFbHvOK49PG/Q9ZFvNe2mCvG3/PJVk7yMM2mMMvrVvYRtPRFKNgSQI+KB7XGYcmtLcN7+zCUtP3CHoXsGzfHR4WbW3yhmQOxTqdmuy50iQjEeIf24KAAWh7YSecsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:48:16 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:48:16 +0000
Date: Fri, 19 Sep 2025 10:48:10 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 6/7] hw/net/can/xlnx-versal-canfd: refactor the banked
 registers logic
Message-ID: <aM0Yyiy3qaEYjf2V@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-7-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-7-luc.michel@amd.com>
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d95f23-a500-40cc-5ea1-08ddf7594661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3N3OGdyUUNEVkpOODZ6Y0RXUk5Wekh3YUV1TFhjM0ZkNUpPenk2Ny9NQS9N?=
 =?utf-8?B?RVJXK2RIUUdwTzNEVVYvKzBYendRQUgxMGd3R1NoS3NRRk9LZ1NsYTNvL1F6?=
 =?utf-8?B?b0RLazlkNFQxR2JQeDRRbXVvL0ZOSllaMFVrOFdCVHlpakhBbjRaazA5L2or?=
 =?utf-8?B?MXV2d2cyS0pvQW5EYlNVYjJmR0NtR1BySVVLT09UZlRXU21lZnpyUm5iY1Bs?=
 =?utf-8?B?SWMxZzdvUXdoMzBkZ2NIdkplZ0lBL09OTG1tNkdtZFNqT0tHTVl4NHIwZmRj?=
 =?utf-8?B?ZDhaYzNSZFhzcVhDV3dtL2JJbHZPTDdZb29JR0VzZTdab2dZRXpRdUJmOTRS?=
 =?utf-8?B?clJRVUZQUXlzZHF1R3ZkS0VJdm1nNHVZeDR2SUdmMVhOK0N2MTBiQmJGT0N6?=
 =?utf-8?B?VUtUM1o2L1RkYWVrNElVcWRudWpmdUdod2p4U1VZZTBEcWVMTlhpWEsxTnpI?=
 =?utf-8?B?WmxhcWFZS2U5cm5Rdm5vVVNtOGJVd2VFUTQybHBHWEtLc2VKZE84ZTlyVmVB?=
 =?utf-8?B?Ym1TcU9DcmpBOWtHSTJUOXRpU1dEd1c0S01VM3pZVjBwS0pndHhEU1NrMjJs?=
 =?utf-8?B?T0ExQ3VHbnJCdWdMSWVMYnRMM09KZUNyWTd0NHBNWWxya0UrdzN4TkVWVUlJ?=
 =?utf-8?B?SzZveUhya1N1RXJ2SmdPSlJyS0ZyQUdrbGIzWnFmZUlWekx6Ri9lOWRFeVFk?=
 =?utf-8?B?Y2lwY05YT0hBT000U2dmdHFOSGQwQ0xuWEcyUFM1MTg0WTBhcGZtRVlmNzBY?=
 =?utf-8?B?eHYzdzJYTHQ3N21hQU1TMDVrUHpHekFhcnNkdkplZ1RRY0JBYk5tUkYvYndu?=
 =?utf-8?B?a1phSnk3aFRlSGRMQ0p0RU1oNm1peUg4Y292Z3lpcVJLRC9hQTNlLzFSSHE0?=
 =?utf-8?B?aThIZE5KdnRnVFpLUGt5WUpVRGZveGdVMkZvUjhod0pjN3duNHE0TjlYTUEx?=
 =?utf-8?B?bisyY2RtM1dGZUNEbFM3YTJwZTVZY0YzenM1Q2dnaGFnTlArck5kc3NzZVU2?=
 =?utf-8?B?UmVYcEhtUVBIL0NXN015SVd0Uzg1VVpFZjl0RlBTYUN2NUpWbHU2QjZOeEU4?=
 =?utf-8?B?Q3U3RWpDcWtCandYTVQrcWEySFdybTU1dVFvVTZmVDM2dUZ5QXA4WjJuRlhY?=
 =?utf-8?B?N1hVOHZlZ2VkTFY1eXBFOFlaNDE2SDhYNVQ2bUkzNGdzeTZWVWZ6bElVQ1RE?=
 =?utf-8?B?SHlvd1BEelEwV3RZTHpYcWtnd1M1c2IxNjJVNG95KzdOZFJ4TGVkLzNCQk1u?=
 =?utf-8?B?M1V5UnJ6Z0ZENVBkaUp0U1Q4QkxMaHhLVlVTRkc2cktPOUhaY2c0U2pzSVFC?=
 =?utf-8?B?S1l2NUQ5QldLemtIWE5ncU0zN0ZPU1ZTUER3UGtnL0FNS3NwRE5pelFiWWly?=
 =?utf-8?B?Y3diaEFlSnRqMzV0amZlemFMb1VyVVNQb2J6ODQvMzcyRlB5MEczSEZFNDhw?=
 =?utf-8?B?N042emFjemdzbXJKYm9HQ0R0ZmlMVVdLbFBnK0h5YUxhSW1objFpMnZGaU8r?=
 =?utf-8?B?bUVSb0Q4Y0dCdXF5MmVMVHlvYlVJL2hFSU5NOHlOME1wMlVKaWhncTFXNk04?=
 =?utf-8?B?VDJjRVdlTE5tbXJULy9LUWNmTWhRVldZOG9vL2VWd2xsZ2ZmVk04akNCclFn?=
 =?utf-8?B?MFZlZE8rQi9ZaHpEQVF4SEtpSVFIcm8wQ2NXMmg2b3FSdktFVzF2aXdGeGl2?=
 =?utf-8?B?MFo4OHFUNnEvKzJrQjh4bFgxRkVFSnNtdmNwMjA5ajRsUmpwRHYxSlN1YnlZ?=
 =?utf-8?B?SjNWWnRiaUhtU3Jndlg5WUM3eGhReW1URUlWemtRMlNybmhMS0VyWW5PcG14?=
 =?utf-8?B?RlI2emZIZU8vYkVkMTJrNjhpZDhBTS9xTE8rcG9la0pUL2lNdksyREJWN1FZ?=
 =?utf-8?B?SnAzbkUvSXphUXR6MnppdFl5MCtoK0oybW9sS1E0TW5vMnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlRmNklmWmN0cWdnQVpOS20zM3l2ZGsrNTZraldjQU9kdWVVT1RUdUFaU3FV?=
 =?utf-8?B?OU1MVjJvci9sdzNwcTJvR1BwWFR5bEdLNkxWaGlISzFpU3N0NlNOL2U5UU9Q?=
 =?utf-8?B?T1VLNU85VHk4L1BJejlVaXVpc2NocDl0bVVhM2xOUFFadHlMS3JYQVhVY0NY?=
 =?utf-8?B?UkN4Wk15WWtXMElhdFh5djMvSXhzUEs1ZmJmaVo1eVFIeFhJS3B1cmJHWEIr?=
 =?utf-8?B?eElOS0lvM2F4bXN2ZXBoSzBKaWRGWmM2ZHFIaXNVMDdsVU5pVmxxSURZQ3FW?=
 =?utf-8?B?UUtDNzZBWXhtZnF4b1FuNGFZYUg5encwRkt6MklCdWU0Z2lDcGZpNnVGbWVU?=
 =?utf-8?B?MjZDbmFaUzhZUlNibm80bVRzaGJBd09zK3h5U2l5WGlsTTNpa0hlT0JyaE9h?=
 =?utf-8?B?akUzVDVHTzdXbnI2OTJTeGdoWmhEREtWdnlMektTRDRMaHRjK082eDJIVFQ2?=
 =?utf-8?B?ZFkwZGI2TkY4QjNwMGNNZ1lsWXJJZGNCMThGOWRUWTM4Q2VvdlZtRm81SFdT?=
 =?utf-8?B?NDhCQmZoZVNpbGdMM2puN0M5UVBIcHl5TzBUTytUUWVUV3l5RUJlVUpBcDhw?=
 =?utf-8?B?eEpTNEJjbTZoWERHcHhsb3hjZTJBWHp6Si9mMTJTWWhKR1pVbXl3Ry9ja3NW?=
 =?utf-8?B?TGduZW9hdUtHWXNlRVdiaDhtenczdHZkZTFNM0VLcXAwNWVKSlY1NGxJcDdD?=
 =?utf-8?B?d2Z2N1VUMDVHZlFZODI2RlJDTVp4WFZhM1Z3OG9Pcm4zb3FBdW82QjByeVZu?=
 =?utf-8?B?NlN6bmxMUXRrVTV6VnQzUWhnZXZnMURUQm5tTTBzNC9JZkdvQkRheldxajhG?=
 =?utf-8?B?bGNYb2VtNXJwUHRudzFGVzdPWHdOalU5aEVGM3BoSnZGYzZ6dkdoTWNhamhw?=
 =?utf-8?B?bEplQ2wrUzFUVUdteXZkVDJjWmFlSm5RdmJrV3cyc29JME1GVnB1K3VrcXFr?=
 =?utf-8?B?RkZsRDZWTjdKU0RrSkZJRUhXS2hJZnFwQXNwemljVUl0dFhsaGFlcWVLWUw0?=
 =?utf-8?B?SzhXSDdCOVJtcVlKL2Z3Q2FjK2RHaEVoZFU1UDQ0SzF5NmIxYTZjUGJRaWMv?=
 =?utf-8?B?NldkM0Vla0dpanlrSGVKTktkZ09wZm9DZmU3Q3FNR3daUzIxV3hRdEN0SFNy?=
 =?utf-8?B?Uk9oOUV0WFZIQ0VXMEVxK1ByNm10MWRoWUp0WUZYNC82MnhGUTZocHk0RFRn?=
 =?utf-8?B?SXFqVkphQlNUTy96VmZUYm5vSVFxSGJWRHJvazRuVEx5RzlxZER2MkhrUjhX?=
 =?utf-8?B?dUtPeEdUNEkwNkNBVXpCNTVrbmNQTjV6eHQ4aVJBVERtcjBZM1JCTXVTWTBQ?=
 =?utf-8?B?VGpxd1pwRmk2NitqVkI0NGNSMVh0TGdOTlVLcjZxK3QvbjhsSWM5L2VMVFJa?=
 =?utf-8?B?R1ZjcHZPVmZ2OG5LaFQxeGUvWHphdDhtUS95TUxPcG44Ym5VS29BN1E0YXA0?=
 =?utf-8?B?MVV2ZWUrOTNGQWVaLyszN1lvSUE3OUQwcXRlUk54aDhOeWJNWUdUMnlRZUVL?=
 =?utf-8?B?QXFMc1FnbmFlWFprRFQ4R3pId2dhMkpuWWhoUEtucHNSckVyWVc5VUFjd0lI?=
 =?utf-8?B?c0xWelIyRlh4cng5Z0hBdnp1Q1c5OVl1c3gvV05OWEVzRVNzbldQYlgzL0JF?=
 =?utf-8?B?L0dmMFJIR0xhamt1TUJQdmxIeEhkWHpUT0djUUVvQjJHdXNTeFpYcXpNY1E4?=
 =?utf-8?B?ajZQMGxGblcwakVZeEFrS2VkMkNYT3FQdkhUVmQ1NDl1anJxRmZySndCNVRv?=
 =?utf-8?B?Q283bDZHYWxadmtlTGt6Wk1ia2VuQURJZ3BaK0YxR216VTcwSlNVRjZLNTEz?=
 =?utf-8?B?eVF0ZTFJMWhyRW10NnE3L0ZLVmE4MWtnaUtxVmh1ZVIra2luUmJ5R1FKNkpH?=
 =?utf-8?B?NmZKUmx0UlYxbWN6VVZGOXhlT3NCZ05xQzlqT2J4dGMvRlJ1RFlKUnJEL1pD?=
 =?utf-8?B?a1pqanJpekhzYllOM2hLbGdvS1B2bkNDeG5kQjVtL3lHR2FiV1lHMmFxUnZu?=
 =?utf-8?B?TjhzcWhEWnY3RVlqZWlKNmp6enlybzRDdWN5SlVjTS9qSUVQSXR2ZXNrd3Y0?=
 =?utf-8?B?VGxNdXlpYVdCb3NmS1c1U0I4cDdZMFA1YkZCNjRxTEd1dDF5QnByVjQvMTJ1?=
 =?utf-8?Q?4UrY7FzkpW+CygTONl2WvefgO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d95f23-a500-40cc-5ea1-08ddf7594661
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:48:16.4429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJo7TwO2taZafQBqVsbpFjIQD4jIf361UviCxqJTe9AZTJ45aHgH9WDw57mMFNfYbgBBSNra0FddH8vdgz2PHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=francisco.iglesias@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

On Wed, Sep 17, 2025 at 01:44:47PM +0200, Luc Michel wrote:
> The CANFD device has several groups of registers:
>   - the main control registers from 0x0 to 0xec
>   - several banks of multiple registers. The number of banks is either
>     hardcoded, or configurable using QOM properties:
>       - Tx registers
>       - Filter registers
>       - Tx events registers
>       - Rx0 registers
>       - Rx1 registers
> 
> As of now, all the registers are handled using the register API. The
> banked register logic results in a convoluted code to correctly allocate
> the register descriptors for the register API. This code bypasses the
> standard register API creation function (register_init_block). The
> resulting code leaks memory when the device is finalized.
> 
> This commit introduces decoding logic for the banked registers. Those
> registers are quite simple in practice. Accessing them triggers no
> side-effect (only the filter registers need a check to catch guest
> invalid behaviour). Starting from the Tx events registers, they are all
> read-only.
> 
> The main device memory region is changed to an I/O one, calling the
> new decoding logic when accessed. The register API memory region still
> overlaps all of it so for now the introduced code has no effect. The
> next commit will remove the register API usage for banked registers.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  hw/net/can/xlnx-versal-canfd.c | 155 ++++++++++++++++++++++++++++++++-
>  1 file changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 343348660b5..81615bc52a6 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1408,10 +1408,27 @@ static uint64_t canfd_srr_pre_write(RegisterInfo *reg, uint64_t val64)
>      }
>  
>      return s->regs[R_SOFTWARE_RESET_REGISTER];
>  }
>  
> +static void filter_reg_write(XlnxVersalCANFDState *s, hwaddr addr,
> +                             size_t bank_idx, uint32_t val)
> +{
> +    size_t reg_idx = addr / sizeof(uint32_t);
> +
> +    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
> +        (1 << bank_idx))) {
> +        s->regs[reg_idx] = val;
> +    } else {
> +        g_autofree char *path = object_get_canonical_path(OBJECT(s));
> +
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter register 0x%"
> +                      HWADDR_PRIx " changed while filter %zu enabled\n",
> +                      path, addr, bank_idx + 1);
> +    }
> +}
> +
>  static uint64_t filter_mask(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
>      uint32_t reg_idx = (reg->access->addr) / 4;
>      uint32_t val = val64;
> @@ -1761,11 +1778,145 @@ static const RegisterAccessInfo canfd_regs_info[] = {
>  static void xlnx_versal_canfd_ptimer_cb(void *opaque)
>  {
>      /* No action required on the timer rollover. */
>  }
>  
> +static bool canfd_decode_reg_bank(XlnxVersalCANFDState *s, hwaddr addr,
> +                                  hwaddr first_reg, hwaddr last_reg,
> +                                  size_t num_banks, size_t *idx, size_t *offset)
> +{
> +    hwaddr base = addr - first_reg;
> +    hwaddr span = last_reg - first_reg + sizeof(uint32_t);
> +
> +    *idx = base / span;
> +
> +    if (*idx >= num_banks) {
> +        return false;
> +    }
> +
> +    *offset = base % span;
> +    *offset += first_reg;
> +
> +    return true;
> +}
> +
> +/*
> + * Decode the given addr into a (idx, offset) pair:
> + *   - idx is the bank index of the register at addr,
> + *   - offset is the register offset relative to bank 0
> + *
> + * @return true is the decoding succeded, false otherwise
> + */
> +static bool canfd_decode_addr(XlnxVersalCANFDState *s, hwaddr addr,
> +                              size_t *idx, size_t *offset)
> +{
> +    if (addr <= A_RX_FIFO_WATERMARK_REGISTER) {
> +        /* from 0x0 to 0xec. Handled by the register API */
> +        g_assert_not_reached();
> +    } else if (addr < A_TB_ID_REGISTER) {
> +        /* no register in this gap */
> +        return false;
> +    } else if (addr < A_AFMR_REGISTER) {
> +        /* TX registers */
> +        return canfd_decode_reg_bank(s, addr,
> +                                     A_TB_ID_REGISTER, A_TB_DW15_REGISTER,
> +                                     s->cfg.tx_fifo, idx, offset);
> +    } else if (addr < A_TXE_FIFO_TB_ID_REGISTER) {
> +        /* Filter registers */
> +        return canfd_decode_reg_bank(s, addr,
> +                                     A_AFMR_REGISTER, A_AFIR_REGISTER,
> +                                     32, idx, offset);
> +    } else if (addr < A_RB_ID_REGISTER) {
> +        /* TX event registers */
> +        return canfd_decode_reg_bank(s, addr,
> +                                     A_TXE_FIFO_TB_ID_REGISTER,
> +                                     A_TXE_FIFO_TB_DLC_REGISTER,
> +                                     32, idx, offset);
> +    } else if (addr < A_RB_ID_REGISTER_1) {
> +        /* RX0 registers */
> +        return canfd_decode_reg_bank(s, addr,
> +                                     A_RB_ID_REGISTER,
> +                                     A_RB_DW15_REGISTER,
> +                                     s->cfg.rx0_fifo, idx, offset);
> +    } else if (addr <= A_RB_DW15_REGISTER_1) {
> +        /* RX1 registers */
> +        return canfd_decode_reg_bank(s, addr,
> +                                     A_RB_ID_REGISTER_1,
> +                                     A_RB_DW15_REGISTER_1,
> +                                     s->cfg.rx1_fifo, idx, offset);
> +    }
> +
> +    /* decode error */
> +    return false;
> +}
> +
> +static uint64_t canfd_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    XlnxVersalCANFDState *s = XILINX_CANFD(opaque);
> +    size_t bank_idx;
> +    hwaddr reg_offset;
> +    uint64_t ret;
> +
> +    if (!canfd_decode_addr(s, addr, &bank_idx, &reg_offset)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, TYPE_XILINX_CANFD
> +                      ": read to unknown register at address 0x%"
> +                      HWADDR_PRIx "\n", addr);
> +        return 0;
> +    }
> +
> +    switch (reg_offset) {
> +    default:
> +        ret = s->regs[addr / sizeof(uint32_t)];
> +    }
> +
> +    return ret;
> +}
> +
> +static void canfd_write(void *opaque, hwaddr addr, uint64_t value,
> +                        unsigned size)
> +{
> +    XlnxVersalCANFDState *s = XILINX_CANFD(opaque);
> +    size_t bank_idx;
> +    hwaddr reg_offset;
> +
> +    if (!canfd_decode_addr(s, addr, &bank_idx, &reg_offset)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, TYPE_XILINX_CANFD
> +                      ": write to unknown register at address 0x%"
> +                      HWADDR_PRIx "\n", addr);
> +        return;
> +    }
> +
> +    if (addr >= A_TXE_FIFO_TB_ID_REGISTER) {
> +        /* All registers from TX event regs to the end are read-only */
> +        qemu_log_mask(LOG_GUEST_ERROR, TYPE_XILINX_CANFD
> +                      ": write to read-only register at 0x%" HWADDR_PRIx "\n",
> +                      addr);
> +        return;
> +    }
> +
> +    switch (reg_offset) {
> +    case A_AFMR_REGISTER:
> +    case A_AFIR_REGISTER:
> +        filter_reg_write(s, addr, bank_idx, value);
> +        break;
> +
> +    default:
> +        s->regs[addr / sizeof(uint32_t)] = value;
> +    }
> +}
> +
>  static const MemoryRegionOps canfd_ops = {
> +    .read = canfd_read,
> +    .write = canfd_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static const MemoryRegionOps canfd_regs_ops = {
>      .read = register_read_memory,
>      .write = register_write_memory,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
> @@ -2018,12 +2169,12 @@ static void canfd_realize(DeviceState *dev, Error **errp)
>  
>  static void canfd_init(Object *obj)
>  {
>      XlnxVersalCANFDState *s = XILINX_CANFD(obj);
>  
> -    memory_region_init(&s->iomem, obj, TYPE_XILINX_CANFD,
> -                       XLNX_VERSAL_CANFD_R_MAX * 4);
> +    memory_region_init_io(&s->iomem, obj, &canfd_ops, s, TYPE_XILINX_CANFD,
> +                          XLNX_VERSAL_CANFD_R_MAX * 4);
>  }
>  
>  static const VMStateDescription vmstate_canfd = {
>      .name = TYPE_XILINX_CANFD,
>      .version_id = 1,
> -- 
> 2.50.1
> 

