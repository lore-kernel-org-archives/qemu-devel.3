Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00485C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wlq-0007y0-5b; Mon, 13 May 2024 10:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Wln-0007vi-MB
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:35:15 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Wlj-00031u-Ja
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:35:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtdxLimy/sBalIZNOSDd52M5W8WdEo9Z7dQybEZDmu+OosRrNnsOxnyW/NevI/hNJn9157CQ54BncRlJsU4pV+KjJhcNJMYMdI7eduz2FVRGqzj1+QyU0q3RePHU01DqthVOkQl9wwUj/7MIaC7q8pFc1zatiM76uGEqbeOaXB2w8uzkaqWvd1/kMYhL0sycRKKfLgGoAHVSJX8nsirlv54kMjKFhpUTnMCTKUztWqrO4EVxiozgAbCFV6pe+sO/hxqsWhiypmKePYXuy1pkrGdRxUChXRk6fs1sXxez5ZnhWkpWyP7/JyMrzxnvuhzVWwS+nIBfyV6f1sFMFqMmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6s6LOJUfBn1LTRUQCHJc/hWmmic/FqBtqv7fQYg7Qc=;
 b=OSP3HsFdZvy/gytFAqKXeFagbc5UCr7RTCrAUW5OQzJ/nGjflf+ZcIKV2BoTY07Ch8QPzoU1Q/E7S+0Kw7J6ApZ2Oi5RtIQQFJA0+ua+cXJIECNJHzkszgtLg0wnJjckmRFGUsXs+f6xdsK6lLy3rGqmijQ92tw77BfzlxbrkGtFVznYN+1Sbm4Ukvb/LP7EF2FNbRIyHYOj9QCH70PI5rJnx3J3XEC6cijeoG1BZiYXMS5vM4mpHV3Clb8rCalhwOQCeBFzOuxilRV1xVIz3qdoTa3C0oKD74WTtD9Yl4VoOQnKqH1j8S//i7BDLrBR6EgcVx3AKjJRUxlurF3j5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6s6LOJUfBn1LTRUQCHJc/hWmmic/FqBtqv7fQYg7Qc=;
 b=kwTN8tOPIT1qPHUCLxbQj3fzbhkWDedCS7mzxBdKyPmUyTbhkroslbVkFuhu0iYcvDalb66z0HqVhTKO3GnmaaqlE3BGWkCV3+r1QF5fYByNdh56bBsOt2sdVOEIV/u4o1tAgVoUsGmUYHCpLyXava+gue3GNSV+n0IHlGV+KMqHaMBdEvAuv+UJwWANC0FH3y/MxgI/hA9nbjgrb9Iwlz4dPJ9CJCZ4UU4nHPfBspFUpZcb1Eli600pbPgOF9qTQvk1cZX/i9yG92J2DnOVdtR4rughGYaNhs/1cFZMzGPqps6QpiiLTq9bM9amb+M1227AcZGpijPNIlhdbWLqxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:35:00 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:35:00 +0000
Message-ID: <d4252893-905f-46ec-8113-a39ef5623d34@nvidia.com>
Date: Mon, 13 May 2024 17:34:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/migration: Emit VFIO migration QAPI event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240509090954.16447-1-avihaih@nvidia.com>
 <20240509090954.16447-3-avihaih@nvidia.com>
 <8fe65dfe-dd9c-47c0-8769-3479484b3e5e@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <8fe65dfe-dd9c-47c0-8769-3479484b3e5e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0301.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ebf888-0534-41a5-374d-08dc7359de72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0ZLcmVyaTVTTXBuMmlxZWVMWE9GajE4TVdxVGQycTdyMldmSzZhTVdpWkdu?=
 =?utf-8?B?WXh5VldCcnJJWXQ5VHowVDJoTGxBVXhkVVNtZnpieFBDWkZzZUEwU1I0RGxX?=
 =?utf-8?B?Z2pBdkJpRGh6R3R3YTBFdkdlZkVWTVJmVVdibjRjVzNOWExsTm9VRWtVUjYx?=
 =?utf-8?B?azlOMG4yUmFvVlB6ZlZUekFaWUFVaHFHaDNuNXlzSU9jQzNwSGFBZ1RKV0di?=
 =?utf-8?B?WkxEVnNLa1RLMmJiTmlsVituYUhPSGF6UnE0em84RTc5RTZIazNHUDA5Ny9G?=
 =?utf-8?B?dVQxV1FKUWtmdFF0SlRSb2xRRFUxWmptMGVKOWVUbVdKMVRtMkR5TWd0Wm1m?=
 =?utf-8?B?ZVdZNTIxQStnRWtWdkcwaFNPL1AxRW1jaDl0QkIwZVJWVUNsUFRmdGtaa3FJ?=
 =?utf-8?B?cWdmY041NU9nMHc5Z05Wa1VEd2VJQVNPWkN1d0lLb2E0cjJUczFickYwNGNu?=
 =?utf-8?B?Y2gzRUlRV0Y3WGRkdlIwUmxTNlVuYWMyV2JCZUVOOVFFUWVJakZjcVlEa01k?=
 =?utf-8?B?RU5WOWJMUWRpRWR2UzZSMVhKQW1VMXJ4U2pVWTV2SDU5bGJPVTFZQ09NOC83?=
 =?utf-8?B?RmI0V0hiNTBzYllNWkpmcUY1THBVV0tVaTdEQmxmVmdZMWx5ZWJBWUg2bWc4?=
 =?utf-8?B?bWo5cDFYVGhYNnY2R29lcVo5cmF5Rk02azFlZzVFRW42YThjNk9kcExIR0dK?=
 =?utf-8?B?TzRSMTZuc1VtNFBvV0FIbmlhSkFhNmxWbkZHT1ZTQm1GWkdRZXpSc3UzbThu?=
 =?utf-8?B?cWhsQnM3dUNMbWt6Z0htNmVFeHh2Zk5wdU9TSXd4ZVBzV2FRY3BIODllODhK?=
 =?utf-8?B?cW1LclZsMi9hTDNkbVVpREVrZHQ4a0l4eExwZFA0em9Cd0ZEbUpOY3F3R2dw?=
 =?utf-8?B?WXVMOHFIUkY2cXc1KzZSRWJwcC9ZTVRqWFUxZDRnY2pjZnFDdjZ0Ylh2WUpk?=
 =?utf-8?B?YkNMa0lncEJHekxxbnpqbTd5TFBHbmhTRjJFVExSOXlIL3hsN0xMWjV0SXdr?=
 =?utf-8?B?R2hGK1BCU21UWW9KbVpkYm5DVHdQOCtYd1ZIZDVmZUdIVHRDZXIvckRkZ0Ru?=
 =?utf-8?B?Kzg5TmFSanRJamM5MzVtTlJ5Y0pYYUNCY2kyMmMwWjd4ck5XOXhKMjJtU3I2?=
 =?utf-8?B?UVJZNXdaczRBWWVCSlBVeVVhRC9wdVQraVE4cnZvMlROV1kyN0dhZ08vaU43?=
 =?utf-8?B?Nms5a3JLR1VLbGF4ZTBBN3hmVjk0UDU4Ny9Ca3ZJa3J1NjM4d1VvWFROTEpL?=
 =?utf-8?B?S2llNGtpeVg2cEdUMXQzU3FnZDZGUkYwaUdGcXZzU0tSUzdocUM5VythQ0hO?=
 =?utf-8?B?di9wK2VMa08xWXBpMnRTVWVkYlF5LzErU01hbm0xTXIxUVZWVmpuSHRvTndM?=
 =?utf-8?B?bXB0VHAzdGxwTUdIQXVSR3hGMkI2bXgwaWNYNVlNK2l5YmNnMU9FV3c4c1hH?=
 =?utf-8?B?ODlBODRxNVJGdlpCcGxtRHVIeXBJNUhia3Ewa3V6TzNhSitiYzEyMkZFOHRK?=
 =?utf-8?B?RDN4dFNZcE5Na3JwUlNGMmNneUZDeWNBaHhrdml4V3pQU0VyaTJJbjlZTGFJ?=
 =?utf-8?B?cE91SVpWMHNETFRyb1hkam1IcWdmelZYNlNzQkpER3FVRCtmR0RxSmhYbS84?=
 =?utf-8?B?WlBXNXBieHhqV0dLSFo2YTZ0VGdLUWI3eG1HWEJYZ2xNVUdVSEFPN2V2Qkcr?=
 =?utf-8?B?WXdZZlVmeUoya05sdkU2MG1Ydis2dXN4c0hyMVhDak1ycllTOFF5V2VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJlZEJqQkxoZDZrRjFPU2xkVjZYL20rMWtvZ25YazdUVVZ6RFplOWxyWWFj?=
 =?utf-8?B?ellIWVhmWlI3S3huWkoxUy9LS0Q1dzhrTUV6VEhwNGtEOUQzckpmTGlMdCtB?=
 =?utf-8?B?Ym1wdnVvSUpRS3FwSGN6aG5LRElDUXp4dnFaazRpUG5mTngxN2xIK1QweTQ3?=
 =?utf-8?B?ODMvMzBTMTZvODZWZFdlL0I4ZkltcC96YXN1OE5lZ25vL0JzUldtYzYvcTFR?=
 =?utf-8?B?NCtNWWpVcXpSN3crcm1UVFIwMVZFZlRFazhPSk1paExsZFhvNkNPdVFZUnBE?=
 =?utf-8?B?T1l2akNzVW94QVRqWGxycGFadUpUazhsd0U4R3RtNmdhNjZnaE43UkduV0ZE?=
 =?utf-8?B?SW1jd0lZdTRoVGhneldScUNmSUdQYjlnMHQ4WURHeTdMZGx1ZEphNktIK01F?=
 =?utf-8?B?L1RQbTk0WHh5WWRZVHhCemFoZEVYSm8raHhVczY2NXZKVHllNUZBazlqR1ZW?=
 =?utf-8?B?Vzl2SnNTRVl3UUxDQ2FpaENIRGI4Y2g1d2Y5OHg2b0QyRVFJeVF4WkF5elRE?=
 =?utf-8?B?TjlsZldsOHFqWS9JTnlZOUNvZnJ4bDhhUVBpWk16Sk95QURUcXZyWHcwY3k1?=
 =?utf-8?B?QSt5eXVNaDJobXhOTU5zZmJBMVJrWTNJeDZtVFFwYWdWdGZTSUxHRUF6OXNU?=
 =?utf-8?B?SUc0Y1VmM3dmU0pQaTlJdDlzTCtiTXRIajFLenNPaXZ0K2syalhQYk14Zmhs?=
 =?utf-8?B?aktMcFo3TFR1c3dOc1RTeTNGZ2V6dGQ4VENoN2xzdVg5aWxBYXNFOUY3UE5u?=
 =?utf-8?B?RzkyL09wMFhLUWRrMm1IdTU0VGd4emVyRFpNS2VZNFkyUUhQem1aeUVkcGQ2?=
 =?utf-8?B?dURoRVRwMDBxWVRiSFdwZElSRFhsZEVMbnBSWjBXMUJrZnMzYThrcUk2OWZ5?=
 =?utf-8?B?aWE0NHBzSDNxNU4vSnIzcUpvZVI4NGtWUElCUWhES2lDd0ZXdEFZaGNpV08z?=
 =?utf-8?B?VVJmNTZqMkI0YWNtbFEvUzAycVV6c2xCWmVOSEVzS2xXTjNaWlVPZ3gzbFlI?=
 =?utf-8?B?anh6NGpIOElBK3RvbXNMUXZhbTlKZjhCTDRnSU1DWTdWT3NSNmRiQ1UybGlZ?=
 =?utf-8?B?c0QzQjhlOUE1MjYwanNhQXZVNWtYWHU2SW5FbXBueDgxZEp2eDlUNmZSbUVh?=
 =?utf-8?B?aEdveTJrMUtLZ2Z0UDZId1BwR2xEcXIzYWc1b2pKbWpFQU5ibW9Hand4N0dP?=
 =?utf-8?B?YklDeEF0KzlHZ2NtQ3Zoa1JzSnRuN2xZN1dnajB1Y1kxZEszODh0OTVLdDdi?=
 =?utf-8?B?L3BlQjJwWk4xMDA1NHM5d1hHTHJodzAyMHBwdFBSSllrRUgzaWR3ZXhnUHp1?=
 =?utf-8?B?QWJvdnVyN0U4cE4xNHpSQS9zbjRaK0cxOWJnb3lnVkYzcnpPTitYUnZEd3NB?=
 =?utf-8?B?NEFjRzEvdDAxUEcrakRQN25adEpxdTZhUUZXZTNTT3RhaHVPRUNGM2IrdWtL?=
 =?utf-8?B?SjZuY3NYQ2hrdmprV2x3VEVjM0dhK0NkQjlWZEd3b0JxZDFxckdKVkZ2RGhq?=
 =?utf-8?B?UnJTS2daNjhqNU5lTWJsOXJNbHk5STNHSGpsM1pVVFBxQkEvRHlKVXQxVVNS?=
 =?utf-8?B?bVNCdWlZRGVUTVoydzBYbHRGS1IwTmZxYXBOS2JnTzZERmc2a2lPb3ZValc2?=
 =?utf-8?B?OGVmdWp5clB0NEtFSlJiZkpZSG02eDUwOE84RXhUbFU2ZDN1ZVhRSXM1V2Fv?=
 =?utf-8?B?eVJUbUhmU3E2RkZpMU94M2svM05LK3R3TitFYVVIMFZhOEk5eEpVNkZWWENv?=
 =?utf-8?B?eVdqM2tsNnYrVWhBbHowVEsrRmJVUEExbzdROUxGa29kNXZnTkpxUzMrZSty?=
 =?utf-8?B?SUc5VTZqN243SU8zeURHbnVEcWNQMzg5MTB5d0lWbkZGMFpqRWF0aVQ5d1ZY?=
 =?utf-8?B?ZUJYdUhncnhEWE9TVHJHMVpVSDBDSlFlbkRmMTZsQUtqN01EVDNFbXJJSEhp?=
 =?utf-8?B?ZHUxdHRoUzdxa1Q5ZVg0dDl0YUxMQktRRXowTUl1MjRoeDdjYk50SWQxcnFI?=
 =?utf-8?B?Sjl3Q1k2N3UzN0tHdHBSM3pjZk9EZkQyNnA1VmVrSGY1amtxSXZvQ2tXQnRz?=
 =?utf-8?B?em9aNllkZDhxUlZjL01xTElQVDFlMVRrRDlzOU1IVXlJeXV6MTZxRVhBRGFj?=
 =?utf-8?Q?GDkTKyvJkyHpNHLNfaJNCGyv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ebf888-0534-41a5-374d-08dc7359de72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 14:35:00.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFW53EtpoUoOmZdveJKtKtginpYSpwczAY8DU5cGVAdWhJ59JVlTGbbHVbRlC7VYrXfTGA3Y4VN2Cpoth4iodA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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


On 13/05/2024 17:01, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/9/24 11:09, Avihai Horon wrote:
>> Emit VFIO migration QAPI event when a VFIO device changes its migration
>> state. This can be used by management applications to get updates on the
>> current state of the VFIO device for their own purposes.
>>
>> A new per VFIO device capability, "migration-events", is added so events
>> can be enabled only for the required devices. It is disabled by default.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/migration.c           | 56 +++++++++++++++++++++++++++++++++--
>>   hw/vfio/pci.c                 |  2 ++
>>   3 files changed, 56 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index b9da6c08ef..3ec5f2425e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>       bool no_mmap;
>>       bool ram_block_discard_allowed;
>>       OnOffAuto enable_migration;
>> +    bool migration_events;
>>       VFIODeviceOps *ops;
>>       unsigned int num_irqs;
>>       unsigned int num_regions;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 06ae40969b..5a359c4c78 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -24,6 +24,7 @@
>>   #include "migration/register.h"
>>   #include "migration/blocker.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qapi-events-vfio.h"
>>   #include "exec/ramlist.h"
>>   #include "exec/ram_addr.h"
>>   #include "pci.h"
>> @@ -80,6 +81,55 @@ static const char *mig_state_to_str(enum 
>> vfio_device_mig_state state)
>>       }
>>   }
>>
>> +static VfioMigrationState
>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>> +{
>> +    switch (state) {
>> +    case VFIO_DEVICE_STATE_STOP:
>> +        return QAPI_VFIO_MIGRATION_STATE_STOP;
>> +    case VFIO_DEVICE_STATE_RUNNING:
>> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING;
>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>> +        return QAPI_VFIO_MIGRATION_STATE_STOP_COPY;
>> +    case VFIO_DEVICE_STATE_RESUMING:
>> +        return QAPI_VFIO_MIGRATION_STATE_RESUMING;
>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +        return QAPI_VFIO_MIGRATION_STATE_RUNNING_P2P;
>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>> +        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static void vfio_migration_send_event(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    DeviceState *dev = vbasedev->dev;
>> +    g_autofree char *qom_path = NULL;
>> +    Object *obj;
>> +
>> +    if (!vbasedev->migration_events) {
>> +        return;
>> +    }
>
> I would add an assert on vbasedev->ops->vfio_get_object
>
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>
> and another assert on obj.

vfio_migration_init() already checks these:

     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
     }

     obj = vbasedev->ops->vfio_get_object(vbasedev);
     if (!obj) {
         return -EINVAL;
     }

Do you think these checks in migration init are enough?

>
>> +    qom_path = object_get_canonical_path(obj);
>> +
>> +    qapi_event_send_vfio_migration(
>> +        dev->id, qom_path, 
>> mig_state_to_qapi_state(migration->device_state));
>> +}
>> +
>> +static void set_state(VFIODevice *vbasedev, enum 
>> vfio_device_mig_state state)
>
> to avoid the conflict with vfio_migration_set_state(), let's call it :
> vfio_migration_set_device_state() ? We want a 'vfio_migration_' prefix.

Sure, I will rename to that.

Thanks.

>
>
> Thanks,
>
> C.
>
>
>
>
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +
>> +    migration->device_state = state;
>> +    vfio_migration_send_event(vbasedev);
>> +}
>> +
>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                                       enum vfio_device_mig_state 
>> new_state,
>>                                       enum vfio_device_mig_state 
>> recover_state)
>> @@ -125,12 +175,12 @@ static int vfio_migration_set_state(VFIODevice 
>> *vbasedev,
>>               goto reset_device;
>>           }
>>
>> -        migration->device_state = recover_state;
>> +        set_state(vbasedev, recover_state);
>>
>>           return ret;
>>       }
>>
>> -    migration->device_state = new_state;
>> +    set_state(vbasedev, new_state);
>>       if (mig_state->data_fd != -1) {
>>           if (migration->data_fd != -1) {
>>               /*
>> @@ -156,7 +206,7 @@ reset_device:
>>                    strerror(errno));
>>       }
>>
>> -    migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>> +    set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
>>
>>       return ret;
>>   }
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 64780d1b79..8840602c50 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>                               vbasedev.enable_migration, 
>> ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>> +                     vbasedev.migration_events, false),
>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, 
>> false),
>>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>                        vbasedev.ram_block_discard_allowed, false),
>

