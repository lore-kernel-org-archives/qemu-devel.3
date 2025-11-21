Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A1CFA474
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJwC-0007Ki-7d; Fri, 21 Nov 2025 00:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMJw4-0007IN-Mf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:43:59 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vMJw2-0001ZZ-2C
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:43:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvT20uoOcfVuTB1/w5eiPrsnSJDYcO2uIGtv7KGD0Eue3J3QZeuNYiFOt8hzUycUF5DSjrWdftPOjiMPRMSjcp3blEqqu9rSK3RH4S8tH28DWVTPClfO9iQjo4kcJoMS6EyYpeBDiq3vFAFoFzo4xDADuQiOMR3Briwa5OwnwlGmmDcU9r6srMmbz4yS5ZiWwqHOcTwNrTu8RTP0+37fnmwrCEHusZP0j+CR2R35r4Hh6/BKjwMpfbaAsH6c0Zp14Vni8Mssr2ynTIRW+9YJ91cU08YxaYASlF4qZJK15SEBJQC9JFvM35IgAMdUHMpnTjtTnr1cP5Gdpv3GYyfghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSIheU4x0qfiGaXluGyseBAeVRVoGK1e6QuuCVuP2TE=;
 b=P6N4uQ6EXdnBFf+SCDi1SJLoKIGD0cFBRrscwxGJWNOl1ft2X8cYX9vTQp1LCAytZQ0Uvfh8x97Crd76UHWPVPU8ZheWHZMJXCQ8ZCmnKC7V9FJrxVgILTA/M2Pl+7uzXonLQdL+m39C3BKHntE5IFUVpCypOk4d3Dsic/gwFAYKZCi4xSbXnqnkzmOuvXQ13E+FZb2wD0qWtG+IEGm+fEZrcmuysNl4eISgdczAIVLhJdg6qhHdGZWfh3wqhboZdrXo9arKXnko6ApCT2fbZilUc6AtIrDd4GaxEbRPc75/STd0xoUlUkQuRSlbN0QFzoILI5uRgOcAgxsjT6Fe4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSIheU4x0qfiGaXluGyseBAeVRVoGK1e6QuuCVuP2TE=;
 b=wU6XmqYpACRzv2g+8hrcAy6XxhFXxpWp6sY24DkJ7HOoOCpMC7FrEWXJe2g57enZIFaogqDl7gqSSqVUwNgNPGZRKXVUgWQ23A2q0FqFGGMGYsuhtmuTYovH53PKQOOvs/W9iLxqXEcD2GqRcWKMbpa1vNy0XNPABnvBCLZZ0I4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 05:43:49 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Fri, 21 Nov 2025
 05:43:49 +0000
Message-ID: <dd14c464-bd74-4d0d-9578-e28367319475@amd.com>
Date: Fri, 21 Nov 2025 13:43:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com,
 alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
 <db263884-6159-4d25-8c40-44dd78291714@amd.com>
 <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
 <c33300b0-b4db-44b0-be07-4e4382a0c0fb@amd.com>
 <21b94d50-79c4-4942-84f7-f4c96f432dd8@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <21b94d50-79c4-4942-84f7-f4c96f432dd8@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d6c575-3b89-40fd-f10a-08de28c0f1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTAwVUFlSnFzb1VjSlV2UDdRNVk1K1FibWdsSTlDYUh4MXRwbnhsMHFaeHFQ?=
 =?utf-8?B?UkNmY1JhcHE4dThhMEIvVlp4KzZ2emV2QTNsRi96TnZDa2x2T29IaDhPYTdZ?=
 =?utf-8?B?eE00YmdxbXQyVERwNTNEMDF4ZGY3WENTZEhweHYzV3FyY2JLeTdXcGtTQlVo?=
 =?utf-8?B?NWpFZVd2d3FlcG5uOXFHNHJIYTFNNHB5SG8rSExnTmNQOWJ6eHZjVExBZ1Mx?=
 =?utf-8?B?dkRjYnV1Tmd4c3ZlTTFiYmFqYnRGbTdoL0tnRXJ4MG9SdW5HWVhzOVcwVmda?=
 =?utf-8?B?TGVQVzZvMU1nU2xUd1RLNnU3ODdQYWx1WXZacFd4emRWbWRHSTJlRGxKbnhV?=
 =?utf-8?B?YUIvTmF4K21kbGNSUXB3ZWcvT1FOa3Y1RW1FZWJrOTBXbEJLV0pIV0pmakdT?=
 =?utf-8?B?Zm56dDEzYWpVL0VLSW5odHJWZkhZM1NtbjNnNTBxWEpwRVUrSWNpcnZXZGVH?=
 =?utf-8?B?NXVyeks3MUtjRnlaZysyMGFpaXYrcUtOZUZzYkhvVVVGZXp0SHhhd1FyaXBZ?=
 =?utf-8?B?N1Y2R3l6T1h0NXJXT1NFZkY0TUtxWkZSeFM1dysrSkFoTnZJekZwME4yS21S?=
 =?utf-8?B?Snh1YjRuR0QxL1pFN3Q5TERab29UbkJYWWdNWXBQMmk5ZStrTzQ1RFVCQkhC?=
 =?utf-8?B?WC9CMzgvVHBCcUNzVThhRU5uT2MwYmZQTWloZUJGcTJJa0FuM3ZrUUhVN2Rv?=
 =?utf-8?B?Y200Q0gyTXBZRjVJTUc2Q0IxeTFhRVUxSGszeWtPODRhcFJzNUN1REtiNTJk?=
 =?utf-8?B?QVFhQWpjNFU0N3NnOUYzMU4zMlRTdlJVa1JUSjFROTZYN2NGQmNXTGhYZnBX?=
 =?utf-8?B?NFZwaWVxL1BuM3BqZzNOY2U3Vy90VlN6cFg1aHptbDFXYmg4ajR6Mys3eC9C?=
 =?utf-8?B?cGdYaE04S3dQTlVPUjBjOC9sWTNvY3Q3QmZseEFNOEtOcjc2MXVRblFPUFc1?=
 =?utf-8?B?OVlIanUya2plSE1jd1p6dzhaSkFmTW1INERIK1BkdmMzVXhHVlkvK01WMHcx?=
 =?utf-8?B?RGpnZFlCQklaMmtRSkQ2bjMwbWM1UFJ1YUxwbFJndWZyM0NvYjU5aUNUTXF5?=
 =?utf-8?B?TnN4MUFKZTVDSHNQQjZ2ejdOWFdKandlMFV3KzBybEo3VGFjR2d6K2pLTHU4?=
 =?utf-8?B?S3UzajRoUCswVTcxTkd6aDVPeW5YWUhKQlBwV05wd0dzRGs1bHJjQlBKQ0lQ?=
 =?utf-8?B?cVpqYlRZcTc4Y0FPUFd1N2lKdFRXVWpkcUMzdHF2cHkyaVRhVXM3eU9JTk54?=
 =?utf-8?B?bVNmUFdZbC9raWsvRC85WjRML1FqYW4vaU15c3NDUE1kTlNNeEk0ZkJFUlZG?=
 =?utf-8?B?UUFscmVjeUNDQlVDeW1lVSswOFhxWkNRcDJhRFNMZmNLWHlLUWRTd1crZ3JZ?=
 =?utf-8?B?d3g5S2JtZEM3UVpOMElsYUdCRzRTSzQyYU1JUXJMZ0F5cjBad09xaXNXUFhB?=
 =?utf-8?B?R0YrNjcvN3BxaDdXSmhYaUdJOGtzaGdSVmVSVS9kOEIyUkZPNndENVdLVE9C?=
 =?utf-8?B?WDFBVFZVL0RBeDdlRFp3MmdwTHo1NStCWXZ4clRHMFErWlc5Q29LYTdFcnVI?=
 =?utf-8?B?ajFzWnlZdGJiN2Y4Sjk5Q2p3ODAraFA5bUdpdEhWL1AvNVlxY3liK09GbDNL?=
 =?utf-8?B?SythV29QbzU0eDFpTnd5ZzUzeEZMdFl3a0poOXVoSDMwSHV2QmFMMlFFZHZq?=
 =?utf-8?B?SzloQ3lGSm9mZ09od0xadTVjanRPYUR1VHZDRGQyUitOYUhISXdrYi9EQ083?=
 =?utf-8?B?cUtjMkttU1l1dkVydndLcjEwN0NrdGJHRkNmSTNVS3FZSldJOXdiNXBrWCtN?=
 =?utf-8?B?Z0tTMytEVjVvREgrS1hmTnVHTUJIbi9KU0t2MDVXeW15ak9leXdRUlc3WFg3?=
 =?utf-8?B?YStwUDBGeVVHYjM5bG0vUENoN3lZSzlvWHVIeE93Uk44Ymc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1BkV0lmaUdEMzcxYTVvUDFvZUZlWisvM1g2eVVOMWZMTk5Ocm5ndmUvQXky?=
 =?utf-8?B?REpNdUJsTDhMSCtKeDZJUkoxNmRWMmNtYmM5c2hIZEF3aVY0Z0Y0N0FzdHVK?=
 =?utf-8?B?LzNLbVA1Q1k1UFduckUyNTBlZ29reFR4aGY4MkNPR2NHRHBUVjRQVThMclRY?=
 =?utf-8?B?d0dsd2RnWENwakE4WUdDTk0rbmNKQ1hJdHRzQTJLWnFRcE00aVlMWFk5QThs?=
 =?utf-8?B?U0FxeTl0S3dlUFNNOS9FZlRib3I4VHMzRHIyd2lGcEJNVzczeTl5ck4vK2hp?=
 =?utf-8?B?c0pRbHpncGRYSzFvVjFXRzJjN01ETnNIeW14UThFZVBobUFGYkJLS0RlMUtw?=
 =?utf-8?B?R3lNWUZRRG5qRWZxcTZaaW1rRDJMTlM3eGE3aXU1SEtoOE5xaFF3SmtGL254?=
 =?utf-8?B?OWVNYzgrcnNLRDJIUGk3bVpGS2Rwa0ZJKy9jUW9QWURiTHBiSnBsZU81Ti9X?=
 =?utf-8?B?dzdNckhqaXdBdTZBYlBSdFZweTZJS2owd0lHK3IwbTUrbDNwN1FxMWQ2SGE4?=
 =?utf-8?B?bW1JK2JsZ0RLcTd6MkFVbjloSm5UREU5allLNEo2bnhncksvZkVqeldTdjRL?=
 =?utf-8?B?cllhMVJRS3dvMmJYcDlSSXFoQ0pNVmxoTE9rSTR2MlV4USswUkJPTWxsM2Jx?=
 =?utf-8?B?aURHRFN5M0hVYmFKY3BidGhQNXgwOXRCb3JtRDFNRkZuL3hBRU1nODIvNGZG?=
 =?utf-8?B?SkRHT0piVHFSbDJ1QUl0K28xaXdTTnZXOVhhcGl5Ymg4MkhwN1p5Ui9UR1N4?=
 =?utf-8?B?TjVObDZ4QW5vNUR2aFVrT2VUKzd0V2dsUFVpVjM3Z1hyU1UvT0sxaWRad3pk?=
 =?utf-8?B?VmZBT045WUVKZitDcWxhcytxNk5uakU5NGk0R3h4VDk5T3lKRk9IWVYwZnJk?=
 =?utf-8?B?Yng0VzErOUs3cXNYTUdGUEV4U1JhOXc3b3JxR1A4RE5Ob1hQNCtTVW9rTHVy?=
 =?utf-8?B?S0h2WWViMW9lUlpNZjBLRzU1TlJZenovSGd5V293VVlWM2lVeitland1MThu?=
 =?utf-8?B?ZUt5eTZZZHBLeXhpR0JaanNrdHRGb3BCTGlhSy9ZZUZ4UUNjdGJlVm9BL21q?=
 =?utf-8?B?cFoxbnAyRTkwcHJCSldTbDdzNlNab0IwYnNObkZYT044TWxMdG8xaG8waTM2?=
 =?utf-8?B?ZXZqSGp0bzN2WDcwaGY0UDVmN3JvR1lNL3YrYXRiWVloeTROcVpkTW1CM3do?=
 =?utf-8?B?SXBnZTZpQzNZbVk4d2oyWW9KS0FrNkcwaXpROTBlT3RUcm0rMTAwVkRGaDRF?=
 =?utf-8?B?aXlRZHBiQVRDVjA4VGdaWEJENFFYcGtGNmFWa09zL1BhRE1MejhIa1JPN0V4?=
 =?utf-8?B?RmtyNW0yNWFscTN0cVFlRG9SZFQ2akNLVU8zY1VuWERlUDBlbmI5dTRoSm9z?=
 =?utf-8?B?Kys5OTF5QWI3Qlo5UzE4MzFuWFFrYkVuUGE3eFpnS1dSaGM3N2NyemxaWGxC?=
 =?utf-8?B?R3FLUWVQK3VyVUpCRmRlNHFFVTBOT2R4V1BDRWdCZHVGMThxWGpxeVRBQTZi?=
 =?utf-8?B?czdhdVNVV0FXVzFQcG1qdkljRlE4RTl0eGRPeThNS1VDaXc5QklOUlFTUXFQ?=
 =?utf-8?B?K1NSQVJ5K2RpcFczTmQ3YzIvTlVxV0thelZEZDNoVGtyZ0hBYW9iNWNBRTdY?=
 =?utf-8?B?WS9SdUNDcTBRYlA4VUdVT3NMWHJ4Umd5TC85bEJnU1g4ZTl4WlFaREo0OWwv?=
 =?utf-8?B?RmN5WjhwRVE0c1E0dTFKeSswa0xIWWU1WFVrTWNaaWJrZitiQWJTRGJjV0pJ?=
 =?utf-8?B?MkdJWExnbFV3RGhrdHBKSDhTLy9IQlpjcHdZSVBQN2hyOEpMRWQ5UWlBOVFX?=
 =?utf-8?B?eThYQllVV0o5SFpPZVZIMjBYSGF5SS9IbmFkQmlMNExwN3A3RzVFZmNvOG1W?=
 =?utf-8?B?Znk3K1l0aUlHYkRCN2V4VTlMTkhzeGZFZFNQMVlzSVVNZ2s4VnhGbmMxQ3dK?=
 =?utf-8?B?V0Rta00wbjVZZnk2bENoVUsxanVHNkIrK1BLbzJkSlhvRGhiOGp2M1BjTVdu?=
 =?utf-8?B?aUtOWExseDV3L1NFMVNOVDlEQTA5cmVQaFQzZmduMmNUS0w2Z1B5b3c5aFlo?=
 =?utf-8?B?UzVKSVhJdzBSU21WME56aHduaWhrTld2TjJUUVpSRm5MeEFXMU9seWRMU1Fa?=
 =?utf-8?Q?GiUtna+lKMkZVkvZw80v6oKUV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d6c575-3b89-40fd-f10a-08de28c0f1cd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 05:43:49.2333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKViBEXJD6tYo5WFva5LtD9aRRBSj5njdvQ23x+0Wzabr6F6yfafma88ZA8anFn7Po3oOnVOvXLE16zPxgYqBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=Honglei1.Huang@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/21 13:28, Akihiko Odaki wrote:
> On 2025/11/21 14:21, Honglei Huang wrote:
>>
>>
>> On 2025/11/21 11:39, Akihiko Odaki wrote:
>>> On 2025/11/21 12:14, Honglei Huang wrote:
>>>>
>>>>
>>>> On 2025/11/21 10:56, Akihiko Odaki wrote:
>>>>> On 2025/11/21 11:47, Honglei Huang wrote:
>>>>>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>>>>>> user pointer mapping for blob resources. This allows guest 
>>>>>> applications
>>>>>> to use user-allocated memory for GPU resources more efficiently.
>>>>>>
>>>>>> Changes include:
>>>>>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>>>>>> - Enhance blob resource creation to handle userptr flag properly
>>>>>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>>>>>> - Add conditional handling for userptr vs regular blob mapping
>>>>>
>>>>> I don't see the added conditional handling.
>>>>
>>>> Sorry, the additional handing is replaced by the fixing of value check.
>>>> I will correct this commit message in the next version.
>>>
>>> Not just the commit message, but it also questions the utility of 
>>> VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and VIRTIO_GPU_F_RESOURCE_USERPTR. 
>>> Neither of them adds a new functionality. They should be dropped if 
>>> they are also replaced with the fix.
>>>
>>
>> Yes totally agreed, it is my mistaken, I shouldn't mix the code for 
>> fixing and the code for adding new features in one submission.
>>
>> Actually this patch set are for another components upstream test, for 
>> the sake of convenience, I have added both the fix and feature here,
>> that is a bad idea.
>>
>> Will split the fix part into previous thread.
>>
>> And for the check value fix thread, will send v4 as the final version.
> 
> Splitting fixes and features is a good idea, but that's not what I meant.
> 
> What I pointed out is that, it seems that one of the "features" you are 
> adding, namely VIRTIO_GPU_F_RESOURCE_USERPTR does nothing at at all. So 
> I'm wondering if you forgot to add a real implementation or the feature 
> is just no longer necessary.

Understood, actually the resource of flag VIRTIO_GPU_F_RESOURCE_USERPTR 
just reuses the feature of VIRTIO_GPU_BLOB_MEM_GUEST: using the 
virtio_gpu_create_mapping_iov function to map the iov from guest.

In qemu, the handing of VIRTIO_GPU_F_RESOURCE_USERPTR and 
VIRTIO_GPU_BLOB_MEM_GUEST basically same.

The VIRTIO_GPU_F_RESOURCE_USERPTR is from guest userspace, but the
VIRTIO_GPU_BLOB_MEM_GUEST comes from guest kernel.
So in VIRTIO kernel and virglrenderer they are different, see VIRTIO 
kerenl: [1], and virglrenderer: [2].

May I need to change the organizational form of this patch set?

[1]: 
https://lore.kernel.org/lkml/20251112074548.3718563-1-honglei1.huang@amd.com/
[2]: 
https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1568/diffs#14086999aaf57fc68a3d7d639ab280c3a2672430:~:text=if%20(args%2D%3Eblob_flags%20%26%20VIRGL_RENDERER_BLOB_FLAG_USE_USERPTR)%20%7B







