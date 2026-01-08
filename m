Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D15D185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpiC-0008AV-7z; Thu, 08 Jan 2026 08:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdpi7-00085B-7I
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:05:56 -0500
Received: from mail-westusazon11010040.outbound.protection.outlook.com
 ([52.101.85.40] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdpi5-00071C-6q
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:05:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBFjGEYSNI5RYIoWkXbcYZp0Gm8SlMtB8/lwnKYO6LjTbJHDlqmzRss4zJv1mNfMPo4TKH9m0WVgvFoLRxn24JEx7JS3f5g6ecrgZLEmI6pvONJfme9YK6KGiUh3X7xdXst0zoEcsl9O3dx3H+Crzd0uNxcL3lkTKGjnNi2I40v5zr6oCXacV51Ihn035SMIEzb4abrFELZSkZ3njNV+46Cfn802UmgaAOtyZz7j4Nj+6Drm7IPHmgdqS0ZU14/0ECMbnyLd5RfWTOp5GuJ8jmnhtgRVWeugS8k2OCv9wyQ23sWBKGVaKaX/s8AF6WwMIrxLvJYNCqljfjfkCW2w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ug5bzzBjdn556ubS7o5Y/16NS0uVzt7N5cD9Iz7uu4=;
 b=dfnF7YD81wZ1twVD0mb6CTIhcwCITX36N4cftFAAr1cvFa+hW8JX18y2Kpu1VRlSIZF/LFPLTVRaWXzPceYKFTwwQUU2j467WleeKbwU9/GExZ2IRMBlya1MWhicH685l6/4738IdY3+tE4ka1WqJbBLFAU9lXEQ3DEzIgBickeb3EJJocNgU6/O526LgVCdiN6QFtxG9Bs2+UdhGL5N+JvEwLQeI4waxAfo3ty6+lDti2dd3XD6+EoYr3Skl9B4kOdvRyAF7Hlnp/SQwY1lkrnLLZdsvtS0Oyu4B+dhvPYJeGpoBf8uP+445r3VeCD4tBWBQ6aRw3mbZFe8MTUXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ug5bzzBjdn556ubS7o5Y/16NS0uVzt7N5cD9Iz7uu4=;
 b=DtWikNNpratq94zT42O3iNz4WCgHH8c3+G3KIBbTmlECGFKciT/wv+ihYiD+Md+f0s/p7f9S0vHDSy6nkpDHwyHrETLNfBFhWr4Vum3tq39f1Hd45mcdLRyg41VZ3gblmHML+SdUqYF3f4TTbTH9mrB+TSsd+dE2yLFTfV06Cbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by BN7PPF7B4E3DFF8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:00:44 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:00:44 +0000
Message-ID: <a46d9f5d-a543-4a75-b7ae-c1120f7241b4@amd.com>
Date: Thu, 8 Jan 2026 21:00:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Cornelia Huck <cohuck@redhat.com>
Cc: dmitry.osipenko@collabora.com, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Ray.Huang@amd.com, mst@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20260107075030.3453924-1-honghuan@amd.com>
 <20260107075030.3453924-2-honghuan@amd.com> <87tswxahdi.fsf@redhat.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <87tswxahdi.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: ced73529-6907-494b-c7fc-08de4eb5ef33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zm1Fd1YxQ2ZiRUJsb0s1V05abWdiMEx1d2tOdXh0cjhGUjBjVmNJMGllQklX?=
 =?utf-8?B?RXdMbVFuVDJPVFFldnBXVWxDdFlVci9lOTM5c1JPUmFhSnlGQ2dXUm1PZnlq?=
 =?utf-8?B?c2ZTcEFkbDRwb1RBVnJMU3VUdnBOZjV1VkQzSkJ3K09lNFp3WmoydUxNQ3lS?=
 =?utf-8?B?VWVxSWs5RHFMWmk1cEQwaG9kVkErUVk3RWg2eXBpZmtQL2pYVmd6ejZFZ3RU?=
 =?utf-8?B?Z1YrMmE0S0VndC9lVitLTFVueVdFTkFWS0xvNnBWMDNtRGhYaHgyS2xGSkpL?=
 =?utf-8?B?SUxzZng4V3ZDb0NxWFVxMUp4SzNDNTdUNjdYa0orMHQ0c2c4UFBQaE5qd2dZ?=
 =?utf-8?B?ZENGU2M2Q2NsTWE0SG5zcEJJTXY4ZkkvYm1EalBNKzFJMmQyME5ySDQ1Q0ZH?=
 =?utf-8?B?QTBNV0ovMGNlVlpqZCsvTjNJTEpkYTJnVVRxY2l1QnBVcU5Ud243Kytld0NP?=
 =?utf-8?B?TXJJZWF3TTBCQVBpdUJ1YTcrZ1FSRGxJMlo4b3lYZVRrUVVQY2g3aFhZYm5m?=
 =?utf-8?B?SlczaTgwT2k4bHpzYjdFVXJhMVRTeXhCTmVmeVE0RGxaWUExTWtvcGU0eXZB?=
 =?utf-8?B?V2V0WHpqU1lLUjZnRDNoR2R1S1kxTGpNemNydTN4aE5aSTFFRGpkNWsxOEVD?=
 =?utf-8?B?SWFVNFlmc1hGbC95eUNURGR5bXBwL3YxRlhZSERQb05McStoV0ljUHlLN3Iy?=
 =?utf-8?B?VUFFcXB3eVhUVXdZaU9WcUo0NEJodUd2N3hWUTAvb0NlWXAzWlBVOTVFeUFn?=
 =?utf-8?B?emQxdGVLaWtOVUl3Q3c4MlRIbDE1MzViaG9oVUo5dG5qaEUySXdaY1BaK0Q2?=
 =?utf-8?B?VkQ3Y2dOc0QvV0tPVFh2WWZON1g1MHppaXIvRDIwTTdaOTBBOC8zWTdhTVRM?=
 =?utf-8?B?d0VmckVObkhzYWREdTQyM1l6ajFWS3VpQTZWdSszMVpFRDB0WkpycmhHN3Jj?=
 =?utf-8?B?a1BnalczL0VIYTgwRWJJbWd2b2xxZjg0clBQK0h0dUM5Mngwejh2emhxaDBZ?=
 =?utf-8?B?ZXhpVG5zaGREYlFkSFRnNDd2a2pUK2hIOW9TV3QzeHRFbVluVDk4NlpXOUF5?=
 =?utf-8?B?YjVNWGpaL1l2cVRpVUtMOHcraDEra3FTZFltOFFrVmE1bmhGWk5nbVJXUWF3?=
 =?utf-8?B?UUE3WGJsSE9ka3NORCtoSm9TUjNKRUtRd2w0Q3lVcEhrTVdIYkxKL0NIREpB?=
 =?utf-8?B?NE9NY0FqUTU3amhxOWFhRE9XdC9PU29hK2xCd2RndXh4TExzYWlrcnRZaGUz?=
 =?utf-8?B?NStiblNWc0lESmt1RjBZU1pDaE16L2tIdXUvSUZJUklVWXdDUU9TdE5SU0R0?=
 =?utf-8?B?VHdiZkhwVWh4d0NFdXp1S2l6aktBK0dqVDdHYTMzVEFZMXRmVHJWWHdsRytF?=
 =?utf-8?B?MjZxQVRoT0Q0ZVdpRWNYU0l6VzhFVVo3NGhpRW93Tzc0UXNMbTYxUUY1L2Fa?=
 =?utf-8?B?UDFOY245NkxVQzFCY0E3b3R3Vis0R1pMRmMwZStJUTNnU2lGV3dRMVpPQnlz?=
 =?utf-8?B?YVdWNWlPem9maXdubStEb1Rwby8zTmUyZmxlbWtqK1BjOEczVVNyUUxQa0Z3?=
 =?utf-8?B?ZHcvVFFkalExZWozTkNQcXFodldNQlh4dFhzZ0M5ZDRqRzZKMXB4UVBNbzhm?=
 =?utf-8?B?U0llaGJ2NVhJRGNkQnpnbURyV1NjbXlPYUlDQ0E1Um1abEFlT3NIK3lYVTE3?=
 =?utf-8?B?Qm5UeHRKa0VaQzlqUm96ZVRQaGl5emM5Ykt5ZU9mejNFTS9aM0loZ0JwajB0?=
 =?utf-8?B?MkxseUhpYkhKR1E5VW5yYytsaWRDWXhnWXZqamhzMVlWQ2twVE91Y1ZrWjkv?=
 =?utf-8?B?NkFiODYwN3VGWlZQR0kzUmNnZnlzZEtmeEVkQXpDemd0aGVtUStTTTBlQ0Er?=
 =?utf-8?B?Y3FLZ1VjejA2MlM3MGtIdFFodVRXQWVoYkhEYUI4NGhpUXlJWU1IMTRwV3dU?=
 =?utf-8?Q?Qt8AXKQDlrhLIfa76YmKgXYn5TRiFa6p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3A3T1ZEN04xc08rc09BaEhCbU9ISHkwWGQvNjlTbC9CNlFnZFlIR0pnczgr?=
 =?utf-8?B?RlBuekhEdktsMGN1cFZFSTZPZXU2b2ZOTHFhRUdQMm1HeFFUd0NFYyt0SmMr?=
 =?utf-8?B?UGU1a2RWSU8xOXpZQUNSRUhhZTRMT2R3VmhSNzNNdEhEek1VZ0Q5RVpBWGZI?=
 =?utf-8?B?RW43Y0x0T09IN2krR0QzNjRuR01YWDBuWWFVZVpaMmN2RVpPbkNiNVVmakFG?=
 =?utf-8?B?Q0pOYUdDekIyRUU3RUZ4NzNkdCs0R0RVb0tHWU12RlhLa0ZzZS9vWXB6QnF6?=
 =?utf-8?B?cG8wRzlkU2d5TUVJQ0I1Y0E5K3BuL1VUVml1blphUFR6ZGt6SlFXUXJVMEI0?=
 =?utf-8?B?K1htR0s0STdKRGo3Zzgya09lZ2wxeHE5UU4rc2VvU0VCSXE5bW11U0h4N1FP?=
 =?utf-8?B?VnFVeWJ3U216b2tYRkx3M0NZZ0NHWWFUUkp5S0hFV1kvV3pVa3UvUW5HalBp?=
 =?utf-8?B?Rmk3cVhSbDl2ZFNjTno1TElVOUIwOGhBeWoyOWpBSTFhS0NEU0dLTlhCRzlE?=
 =?utf-8?B?VW1WaVJaSW9STU5CV0M2NUlLdHJlT2xnTWhCVnI0YXI3TFRBbXBkNHdOVCtY?=
 =?utf-8?B?Z1pMUjU0eTVEQ0ZVNVpFTno3eS9VNWI1S1U0M09GMllvQnIzOEZjRjFHOWJk?=
 =?utf-8?B?RGhGOURlR0hZVGNPSFV3a0NnRFg2b0dXZlhyQndGdWZaTlpOSC9lZm05L2xH?=
 =?utf-8?B?RVYvcTVtWEVPRThzVDUxdTVKWmhBVWJQVEFqNUNXdklyQ29BcmdTNFZsZXpu?=
 =?utf-8?B?enNJVklhMjNNdlF0UlExTFpYa0NPZ0pudDR0VjM3VGxKdWJHM093amlRZjkv?=
 =?utf-8?B?WDZvRnpTY2dDRnVvczRHNXFEN295WVRLNzhuRXJJajB0R001Z2Vxa21UNG5a?=
 =?utf-8?B?SHREVTBkQ0l1WGdydGhQRWI0SEpDSFRZTlU2TjR5aG96UVBSZ1RJbHlSV1N0?=
 =?utf-8?B?eTBMbkdleDZsUTR2SWJReWxhTGtCeXVkSTdjeXl3Rm0yMFRKTm9BYzlTb1lO?=
 =?utf-8?B?UjYrVWM5SHozZHlwL2FzUVFJYmJ2Mkk4MDk5UjBFdUxYcUJmMDBmQTBsbXJw?=
 =?utf-8?B?UVRBMFFVektPQlY2RmhzR3ZEalRFUlA1algyTjJlcWRVbStYOUxuSWNxbEdY?=
 =?utf-8?B?L0VUOU5qS3FRVHc3MHArVHo2cmpqbHlUbFprT215ekRjQ2JGSlo1WTFpM0Jl?=
 =?utf-8?B?SmkraHlSK1pWRTE2SElhQVJ5a25oVnVLUFVNamo3T0MrZTg2Y0VtT1lUMW92?=
 =?utf-8?B?TDFpVUtmdGJ3WElZcVJjWjQ4bThwVXhPWTFLRHo3S1J1L1VVV3RMRGdlS0F1?=
 =?utf-8?B?NGVoR2xFTzQ4aDNIVVd4SUk5elVvR3dia085VHc0dlV5TDNYb1F2MWl1Q2VK?=
 =?utf-8?B?Uktjcm5MKzhjQUVyRkc2UnVkZmtWeW10UHpSaFRWcFJaWW5yWjhhM2hYcUFl?=
 =?utf-8?B?Tll1WnlkalIyOWs1MVZwYXpkUk9PeHB0NmJOcFYwOVlyL3NQTkpyd0F1bVBh?=
 =?utf-8?B?RlJSd214b3NJS3dFUnpROHpuTFc1UDkyWUZEOWY2T0dXdG9wMDQvKzdKYzBw?=
 =?utf-8?B?ZTlNaGxVM3BiR2hZNnpRUWQvZzVlZGRoZHZlN2ZpblVwVFVNNUJmdmZKTjJH?=
 =?utf-8?B?N0hSNThpN25lUHI0T3IyOVlQeTIvRGVvRjM3VGdBRlAybSs4WngxQVRTRWl6?=
 =?utf-8?B?dy9FSk9hY0lzVW1aOUpvUGlNSXJsQ0EwbFc0MEovenRRcUp2V0M3Z3dBT3Mv?=
 =?utf-8?B?dG0ydUpaM1VQR3J5K3Z4UURDNzkvd0trSTF2ejJYWWd2NWQwU1Z0KytjZkNI?=
 =?utf-8?B?cnU0ZjhOUmZRM250b2YvSms3V3NlZ3ZTWHBoVFRWTzFmMSsxVGlMemkyd09F?=
 =?utf-8?B?VjhiNlZLVXdwdUNhTWw3czFLSllhUzYwQ3grTzhRTXVSZ3JsOTJQVTEwV3pl?=
 =?utf-8?B?MDdUMDhTaDcxdGc3TFNXQ2JaOXRrZXgyLy83MnJVcDZmRVZJYWRFbjJ2Y0ZS?=
 =?utf-8?B?SVJCb1RKVitzL0pZUWxMZndoT2plR3RZK1FWYTVmUGVndmVmUW0wbGFPQjR1?=
 =?utf-8?B?dmxEWFhjbmRXaUFQdnB3MkVOcUZna3Jqa3FRNHljLzRBZHpPU2g5bS80UEl1?=
 =?utf-8?B?MDFUMXBscWxrdithVWpTZjhXVmEwSW5BS2hIbDhsL3A3cHlHVDRmUDNqQzND?=
 =?utf-8?B?c2N6MGl0K2g2dU9FSzJvQmk3VldPcUxkWFU4UHlWTVpxckVIb1F1RDRlODc0?=
 =?utf-8?B?ODBVNHUwV1dlcTFCNk9LblFIODFOdWVZeVpXSWlQZHdKZzhJTjhzaG5IVkRJ?=
 =?utf-8?B?TVNFV25FUnZ5T0FMU21DN1JMZTg3SkI3U3IzQmpnbkttcFZLT3p2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced73529-6907-494b-c7fc-08de4eb5ef33
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:00:44.6443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6i4b8riLk+4QBeCtEZ3kv6j04o9c5a7lSJDsDKp7d1N3fZiBdzVdOfpkdix7WnDTBFDCyCI4VjfyudniIzQgyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8
Received-SPF: permerror client-ip=52.101.85.40;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2026/1/7 17:42, Cornelia Huck wrote:
> On Wed, Jan 07 2026, Honglei Huang <honghuan@amd.com> wrote:
> 
>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>> user pointer mapping for blob resources. This allows guest applications
>> to use user-allocated memory for GPU resources more efficiently.
>>
>> Changes include:
>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>> - Enhance blob resource creation to handle userptr flag properly
>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>> - Add conditional handling for userptr vs regular blob mapping
>> - Support guest_blob_mapped parameter for virgl renderer
>> - Fix value check issue in virtio-gpu
>>
>> This enables more flexible memory management between guest and host
>> for GPU virtualization scenarios.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   hw/display/virtio-gpu.c                     | 7 -------
>>   include/standard-headers/linux/virtio_gpu.h | 1 +
>>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> Please split out any updates to the imported Linux headers into a
> separate patch to be replaced by a headers sync (I thought checkpatch
> would warn about that?)
> 

Understood, will split the Linux headrs changes into a separate commit 
in next version.
Really thanks for the reminding.

Regards,
Honglei


