Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3EECAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWoX-0001ok-Tw; Fri, 19 Sep 2025 04:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWoI-0001a0-Ry; Fri, 19 Sep 2025 04:49:43 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWoB-0006L4-S2; Fri, 19 Sep 2025 04:49:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF3hmSEhTmKz1yciCNOSX54Xr1qyQUeSjZaHl5KLMAdUlkwL3LxIl7tW04QFZ5iaa6OQv8B0DsurjC+AINehRp9+0d/QvO9DNJ5b2sRDWmhCo2ZSDreO3ZX+eMx3gazdBDyQOvAL6juo30VmrV/vspGmP0wIKH91jN7LoPa3AoMuh3zbiHO42jQuquQf8dondIV7HPxEBjuIxrQc0ywEZfRoK8HWH/YGsHYxEN+fVLWH913V2Euwxi8/skWn2yF1qWFXrGITeArPFglY17ifqgG4MvJ2pch848YqEblOf2qs7gw+Ca8KnR1HJBNkTZUIZ1OhL5ufC1jfQIQTHV1PcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dMjEPSkBZY34Oew6svqoZl7Lo0z8xCzrnAYLC3wkVU=;
 b=mPHfko9T3+rRe5hrRcN1oARYN4D1wal/3J0NQX38mVaLGVJDLPZuhx/+dZ1jwQdLi4un/uT73opXKoYdZhG2p7KEj3c+DIzUl9y2jjofsgYrQb9Nir60I1SQLjD44yktUHt4EsNecRjQWsHvXWrzw2bvya54fd/imEu+Z4hu5BT/us31XqpCwt2fp76WkttZKxs7tALpU3ynESagQJdC9KzofsbOdWsgFXwEEmA8JR9k5U3wjNW6J9OGZoW1dbQ9HEbuSn7qcyNMbvNJMNAXQlz8yoROgeeDuTGW/Qegwr4q+rRlctxfD4eixHE2CxwVRZBYuwwIoiCWT9VyfdexAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dMjEPSkBZY34Oew6svqoZl7Lo0z8xCzrnAYLC3wkVU=;
 b=Q1ZRXFHMsfjSA6A01quI7NeyYVXXTk0uj6m/ld8vgdTlj8KiIAWed91SkiLsU4rhLh3uLtLOc2X6FPDOTrGj4IH9v5c4krrqesYXmau+qa+NAK7q6sBUqzH3M1QizmwS6gTRgYql6REQZkShpvpIa2zXund+XOakomfa5+VFqFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:49:32 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:49:32 +0000
Date: Fri, 19 Sep 2025 10:49:24 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 1/7] hw/core/register: remove the REGISTER device type
Message-ID: <aM0ZFAuCzyU265S+@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-2-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-2-luc.michel@amd.com>
X-ClientProxiedBy: FR4P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::19) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf6fdf7-641f-4620-9858-08ddf7597354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VC9OR0NjVDIzd1Zvb1ZWYSt5UkV0N0VaRXVvTHNxV0VNU3hCZ0hYZmVpWEdR?=
 =?utf-8?B?d1d2YWVNSGkyY1A1WitPa3RYLy9LUE9EcGpPM21JeU80L1ZGeitnQ3JzcmRH?=
 =?utf-8?B?bWRXWE8vcWlHNyt5TTlWNHVIaU9kL0lpRW5EWUt1VmNNb3hvRFhFbVdlL0V0?=
 =?utf-8?B?QUF1a2k3SmZRSmgvSWpOTW9QSklkQkpqK1lBYnYzNlZOeitoL0Q5cmZncXBn?=
 =?utf-8?B?Y2RHTFUvdk5FWmNqbzJyS1NlYUhFUVJpNURUZHBzZDdBTnJNM0J0Lzh5ZlVS?=
 =?utf-8?B?d3JaeXVqVkI4UllWRW1tMkJKWm9MOHhFOUt0RkcyTTRXZmVxU2dMU29hQmZo?=
 =?utf-8?B?bC9FenJ3SkxVeU8xU1d4YmJtVEljOUU3Mzc4NmZ5RzZkZXAvcit4N2Q4S0o1?=
 =?utf-8?B?VE5rbGcvNWdsS2x1MDlWYkJsNkMrYzM5ajJnZVowM3ViOFloa0gwK1hwNHZE?=
 =?utf-8?B?V3AyMTB5eXBvemU3cElmN09WZDBiM1NrN3B2cHFyWUpTMlBXbTVuY3MvVGhM?=
 =?utf-8?B?U3JTbXJ3c0w4TjZYRy80cktZblp5cXNMaVhOR2ZZV0FXWnN5aFgzdWtyc2p0?=
 =?utf-8?B?R1hOdEFHOGI2Nm1WbGhEZThiUlJ6QTJuSGRYeWFHMXNvVUt3YkNvVW9vc2pW?=
 =?utf-8?B?dzFjM2R2ZjVDZUxhWW1wNURSMGpVN0QrSmh4N3pFcWRYbjNTVFBnZVhNaVBF?=
 =?utf-8?B?UDB0V21talU0dzRxMm1UQlcyNWxvdUFuc2pmNDEwQ1J0aVRSMnRQbC9zRytR?=
 =?utf-8?B?NFgyV3Q0aVpQYnAxajJpblZIZWhReHd3S1o1a29CckRtTVJmT1lMMFd6VWFC?=
 =?utf-8?B?WXlnb0dka2JIajRFZnpvSzVNSk5uaWdmc2QyWDhKUlJvY2hLd3ordEhLUE8x?=
 =?utf-8?B?eHpJdkkvVFEraVpOT3BpZUZnUmtFdFplUE0wN28yUjE1V3BLWlBqMHM4WTJx?=
 =?utf-8?B?eGpYOXFUcy81bnlmVzBYZ1ovbmpwT25FK1dYcHB3b1hvQ09WTXp4eExDeVM2?=
 =?utf-8?B?Vjh0ZkIza2phOEZlOTl3b2xuZWZVWVJGVjcxaDhsemtpM2hUT1FCTTRrSk5u?=
 =?utf-8?B?SldVUlV1TGdHRGZZOWZrWVBGQ3RDWk5yWW1GeWN1NHpnL0NxZVowUjZsU2RU?=
 =?utf-8?B?MHFhUXNkaUpsTDZCOXRVQzJEQ00yNGg4by8zTEd5NkR3Ry9SRUduRjdlbEpo?=
 =?utf-8?B?c3IrTHVISm1JWFQxS3l1WDZNc3pqVEdYNm9yTEdRREU2dDBHWGRYVk1KM2Rx?=
 =?utf-8?B?WjhaSUpRcEZhWU01eWhickNjYkpRaEtNcTJqckYzV1o1L0hpeTlmdC9yVTIv?=
 =?utf-8?B?MDRzNW5ldjE3cnN2ZjF2M1pwY1o2UTYvamlVM0UxU1hKZUsyM0lLOGFNdzQr?=
 =?utf-8?B?NlNRcXM3bUMveDMvekJHKzZiOVFPWmZHbFBHSkdsQ1JjU01aMVcyZDBjcWNL?=
 =?utf-8?B?ckVvRGZpaUljNlI4czg5OGVyVjR5SHVocU9jODZEdmVOQktqVkxvaElaTVE3?=
 =?utf-8?B?OHZSZDlCVmFTMzZnNFI0V1Y1bkU2L3pPWUtYWlR2U2xORi9BYUFzUUVTOTAy?=
 =?utf-8?B?NmFpZWFDNGxkU3BxYkJHNGxzQVJmYzdUeXc5M2U2dGpxblR1anlRd2VjZmww?=
 =?utf-8?B?ZHBHMFF3c1JqUTlrSXNOa29hWldPMEdjYjluaW5BUHYycW5veVFkUzlwUHpP?=
 =?utf-8?B?Mk9LT0FuL3RpTEZBeVptd2t4OXRLLyszTG90R2tlbjlFUGNGNzlSWUFPT1lp?=
 =?utf-8?B?WVh5NE8ydzhsU3BWKytDalB3Z09kT0cwSTROTUFMSXppSHkrMWtTcEh1TFFZ?=
 =?utf-8?B?bG1iTHcyeEM4V2xwb09raTEyM2xyMEY5K1BmY2FKZEY0a29LbUlVQVkra1JE?=
 =?utf-8?B?MlY0Yy9QN1FFTCttWExzOEFDQWRMeGNrU1dTS3RrOUNkMFVJdmpxSHpGK3NT?=
 =?utf-8?Q?4Y4Q4xNjZ5M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lpd2hDVWpLVlBGMTREUWNZSXdwb0dTK0lnL0ZzTnpwdCs5cGt2V0V3Zmx3?=
 =?utf-8?B?bEFIR3ZHMUc4T3Q5QzhSZVVLbzVTbHkxZ29BOVNTcVJhTEg4bmJ5dWdvNGEv?=
 =?utf-8?B?TmEyY1RoMHBzd3lzRWFZcDh0TTNva0ZvVEpVYkhTSTNsbEkzRUtkcyt5Q2VS?=
 =?utf-8?B?UWh1Y1FxT3V6LytKWjVkSWM2aEJJTVlrZmU4RHRLak1STWFZK1NWcXViZWxJ?=
 =?utf-8?B?a0ZSdWhyb0pzUHRqZXpxMkp5SDhGZFhvM3JBbEtNY2ducUF2VGZ2MkxWaTJZ?=
 =?utf-8?B?S1JsaU1CS1NPb3RSZm1iTk5waGx3bjdOZHU5dVhIaEQ2YmJTazMzS1JNY1NM?=
 =?utf-8?B?ejdrQmRmaFFUNzhQQkpycWhFVDE5dHBET1VDMzhvTmNCdkdLbDlLNGxvM3NX?=
 =?utf-8?B?MlRPMmtNOEhOblM2dFpTcG1DZ2tqUEw4ZDhweW9OQXZ4R1JqQkR2cmRKM1RQ?=
 =?utf-8?B?SE5scDc4cGdLRnMrRlllM2d1eUdSN2d4NkVnWThWV3Z0Z3F2dmRzTzJ4eVpy?=
 =?utf-8?B?cXk4TGZrWTRqaW9PcFphZkRSV0JnRHVMWWZRUWl2RHlLVEgrRkFkRldaeVZ5?=
 =?utf-8?B?eW5kWUxvd3EyZVFSc252YmJ0cnZTMEZ4MjVaaGpROHNDYWQzYWVsKzAvRU04?=
 =?utf-8?B?TGM2WU1hREdNaUZTYyt6TC96WlM0czdrclpOSFVudkpPQVRlTUtDT2kzTmlx?=
 =?utf-8?B?LzgydHFldmZyRlVBNWNSMHM4cWxPQnlUMW1id2NUMDl2cHZWZmxyclJXVzFI?=
 =?utf-8?B?YS82U2IyVFFiaDZwbUNLOUJVZEFUaVNSRm9tNzBGUU9scC85cklyY3hLcHIr?=
 =?utf-8?B?MkZzckVZdGd0MzFnUzkyaUZKbkMrcUQyZUlFN2ZDNjcyZldDSGoxbi93amFk?=
 =?utf-8?B?MkVaUGEvbksyTUFRS1ZLNzVDSW0xVW1KelZVSDdSS2Jrd0JTT1kyb0RUakg2?=
 =?utf-8?B?SXdSVVNPMnNZa0FRT2xKenJERnpidCtJZGwxK3hSakVZbXlKWlVCZHl5VUtN?=
 =?utf-8?B?cDdoRzhWcHczb21senVUQzdXdFFsdXZ2TVI2aUdScGdwaFllcllubHVCRnJ1?=
 =?utf-8?B?QlA2enNyKytTSkdZQXJnTGlCcklpT0p4SjNTMnoydFJiYXZGTkR2YzUyOWxV?=
 =?utf-8?B?Yks1WEJ1SVdsd3hnWDFHSlFqVXVzZ2ZZWjNEaU83Z1FxZ3FpWmdidTFaOW5F?=
 =?utf-8?B?eTZBZnRmMFZoMjNvWG1VL2h2SWxUWU5vbTVsNkM0Ujc4WXpPZjhIWk5ncmo1?=
 =?utf-8?B?eHFmNi91eVRmTnFiSEh5aDB6T3ptbHRhM2k2a2g3Um14bmRPNzMxQm9oRUtT?=
 =?utf-8?B?VjJpSU9JL1g5Nlh4OU15N1M5T3BKY0RHT1NENnBHNmRRN0NFNGxKcWhzN1VR?=
 =?utf-8?B?U3V4Qi9PRUFqbUlTNWdvWEZ6VFptVFYzMUl1STFKd2VrdXdJWjAwVWZZR09N?=
 =?utf-8?B?aE9uZGJTa20ycWpTalppWmo0U3hLK2tSZllvSXoweG5wZ1dIWThvVHlGbGhi?=
 =?utf-8?B?R3RZNkpLT1BTTWF0YnBYUmY0dEZjR0w2VThBUDZiYUF5d0tRQ2YrY3MxTWEx?=
 =?utf-8?B?ZWFWanFCTndYa3p1UEdTZTErUGkyVStkRTd5aDlnNVM1UXk1N1JoVmxpWUN3?=
 =?utf-8?B?QlJ3WUYrUEtqS3RGN2xybzBRUkY1cFdtUzVKd1NTWHluVGZKVDkvajd2Mkpw?=
 =?utf-8?B?MktrTkdFeFIzNk84Y0l2bzZGdEhvWWV1Wm93b2sxcHJoRC9BN1RNRVFiUVE5?=
 =?utf-8?B?SU9BOGdxbVRJRGl4cU1DNStHMlAvcUl0a2UzQitiQXpha2VjaUpYMlpRaTBO?=
 =?utf-8?B?VFhrRGVVcDRPSTJqMW1GSk1ldlFya0piWk5ybHZSaElJa3VjbGtrK25ycksx?=
 =?utf-8?B?Qm51RFluSEZtNFdVRWF3bDhJRnBlZGFZRm1OYWxXbXE2ZE04Sjk2aXFLc3Jt?=
 =?utf-8?B?TjJxK2RQS0FnWDRQUDJLZmE5L1hRb1pHdlNwcyt2TmNSUDZ4eUNrdXozU1Jt?=
 =?utf-8?B?VUJjaGM1bVNTNWFMK1YzR3F0OVhLWUlwd1hjeHVIb0RuQTBUUVlBS2RhNklu?=
 =?utf-8?B?S2RDWmVsZGIrWFo0NlJSTE1jRWlFZmM2alllNUVwZndNVWNJbCt6L2MxMmZu?=
 =?utf-8?Q?coTDtF5m1n8FAqVzjDt8Jrw2C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf6fdf7-641f-4620-9858-08ddf7597354
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:49:32.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6R3/YrSQaHoYk9C/lF0Cy+hZNe2G2/N6Psfza+ys9rOXDv/7jo/1T8AGtWiCRE0h5yoiAcMde7kOQsT/nKIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=francisco.iglesias@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 17, 2025 at 01:44:42PM +0200, Luc Michel wrote:
> The REGISTER class (RegisterInfo struct) is currently a QOM type
> inheriting from DEVICE. This class has no real purpose:
>    - the qdev API is not used,
>    - according to the comment preceding it, the object_initialize call
>      is here to zero-initialize the struct. However all the effective
>      struct attributes are then initialized explicitly.
>    - the object is never parented.
> 
> This commits drops the REGISTER QOM type completely, leaving the
> RegisterInfo struct as a bare C struct.
> 
> The register_register_types function is left empty here because it is
> reused in the next commit.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
>  include/hw/register.h |  7 -------
>  hw/core/register.c    | 18 ------------------
>  2 files changed, 25 deletions(-)
> 
> diff --git a/include/hw/register.h b/include/hw/register.h
> index a913c52aee5..4d13ea183c7 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -73,25 +73,18 @@ struct RegisterAccessInfo {
>   *
>   * @opaque: Opaque data for the register
>   */
>  
>  struct RegisterInfo {
> -    /* <private> */
> -    DeviceState parent_obj;
> -
> -    /* <public> */
>      void *data;
>      int data_size;
>  
>      const RegisterAccessInfo *access;
>  
>      void *opaque;
>  };
>  
> -#define TYPE_REGISTER "qemu-register"
> -DECLARE_INSTANCE_CHECKER(RegisterInfo, REGISTER,
> -                         TYPE_REGISTER)
>  
>  /**
>   * This structure is used to group all of the individual registers which are
>   * modeled using the RegisterInfo structure.
>   *
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 8f63d9f227c..57dde29710c 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -256,13 +256,10 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>  
>      for (i = 0; i < num; i++) {
>          int index = rae[i].addr / data_size;
>          RegisterInfo *r = &ri[index];
>  
> -        /* Init the register, this will zero it. */
> -        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> -
>          /* Set the properties of the register */
>          r->data = data + data_size * index;
>          r->data_size = data_size;
>          r->access = &rae[i];
>          r->opaque = owner;
> @@ -317,26 +314,11 @@ void register_finalize_block(RegisterInfoArray *r_array)
>      object_unparent(OBJECT(&r_array->mem));
>      g_free(r_array->r);
>      g_free(r_array);
>  }
>  
> -static void register_class_init(ObjectClass *oc, const void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -
> -    /* Reason: needs to be wired up to work */
> -    dc->user_creatable = false;
> -}
> -
> -static const TypeInfo register_info = {
> -    .name  = TYPE_REGISTER,
> -    .parent = TYPE_DEVICE,
> -    .class_init = register_class_init,
> -    .instance_size = sizeof(RegisterInfo),
> -};
>  
>  static void register_register_types(void)
>  {
> -    type_register_static(&register_info);
>  }
>  
>  type_init(register_register_types)
> -- 
> 2.50.1
> 

