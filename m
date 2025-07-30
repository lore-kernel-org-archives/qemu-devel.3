Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42868C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDN8-00007C-7E; Wed, 30 Jul 2025 16:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCGX-00057s-J1; Wed, 30 Jul 2025 15:15:10 -0400
Received: from mail-sn1nam02on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2406::621]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCGV-00085j-5v; Wed, 30 Jul 2025 15:15:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVgd2c+QRW7C1lXZDTr3+7/kp9bn55O2zW1VBR68K5K8JgSo2O79wc3yY2RoeJewmBnS0Gjpf5jrs8QOt/p3Aw8yX2BSR4xaTewqt07zxpi7W7bbaRLSrPutN9V3GA8M1kdAaY7oQqzB84p+Ifqdo0tFFUnOoCAxptyIiXdfBU0mOfSw3RR5QWu38wGM3pAoVYPo1Woi+ejP3qEJKxaFHdUuX3uSxMIuhv8m4CfdwZUJGle5vstQbOdpwX2xc8iIeqlScKl5D9IBZSCJBdyROC6YydWACmbfbYEHigTMCs0M7iuQvhCij5tFXzg+dcfZ78VHGkWpiaFp0x6BeooLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3za/c/TsSCIAUsnqPlqBDjpESjhauJX2Q2V4UlwcUZU=;
 b=AmFC2pmppWHSss+vHzF0EuH7/mERx4nzO868J/eXkNrCtAV0EYhkf6qv2ufGb0cGgzXPa9xmEaOlTBV2XH9hMlSLUe9dU/RB1R6EiI6PO1nWcYNZIw667VZCJ2H7tkNottbReEUmlZgV5ehgKankmC6Ks9A4mI7bLwBNRYtIHA3iKMHBa5yFrndU2cGkOP28X+/djZcPHmn23vpXW3H9Ysq96CSfXBJ6BAnGTQHLfkmBYGapuO1whfcUIB2Cn+79lrPmkxoCBragFt3CkjbDsGEaObgu72WnEryTN3Yw570EA+yqekwZb1bBqMvTIPoObSy1dCCYqid4oursl8R7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3za/c/TsSCIAUsnqPlqBDjpESjhauJX2Q2V4UlwcUZU=;
 b=upfRYN9hmt1m9HKQrVmtiEKbv0dqL3553gxjIejik2HOCer0Nv8KQWvDva1CLF2uVQTz8KirOjzJys9pvxIj9oyT2UnZSCa3CgkhlcEZRJRnTmkjg5TZbcA4WAFpFMjGqPq5bxl22qjx6S5/PdqFofBDXA4zXT4TG1KeahUKShs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:14:57 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:14:57 +0000
Date: Wed, 30 Jul 2025 21:14:51 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 31/48] hw/misc/xlnx-versal-crl: remove unnecessary
 include directives
Message-ID: <aIpvK23gQJZ6V02T@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-32-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-32-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e19df97-d8ee-4de0-afdc-08ddcf9d5f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2lIZzNaNXJoZG4vTWp3NzJhaEdxL0h0MjJHOXdsWVVCMHpkSHZlM2J2N3VF?=
 =?utf-8?B?Vm9KL2lMSHhTQ0VaU0RYVjYvY2M1OTBKaGczMCtmMjEvVnhNU1diK3ZPWStU?=
 =?utf-8?B?N3BTOXJoNlZjMCtoYVpoWHZwdlN2QWpJS29IUTgwTHI1OFoyVDdzeFJIWksy?=
 =?utf-8?B?NTBpRWtjczZzMXpvY1JSaVBoV00zMWN3NDVzdDZlRlpGZUliVS9QZTBZWEl1?=
 =?utf-8?B?YUV2RXBCR2hhSXh6aDJPU0k5UHRzSjQzdW12TGNZVFNBaUFxb1R5bVFEMk9l?=
 =?utf-8?B?T2tLYVNkcmhXUTlmRy9CWDhYdjdYTEFUTTJ0TXlKNXRZbHZNellUNStpQU9l?=
 =?utf-8?B?ZkRKVjRiV1dGVDhvaVJ0bExZcndqRnZMdTBSbU56OUx1Tm9mWW1zWWg5M01C?=
 =?utf-8?B?OVhnb2VTTzI3TFJxNmdqb2l5MjROazd6L1B5Y1hkSkE4d1RJREVQVitVQWVJ?=
 =?utf-8?B?WDgvdzY3dzhTU1oxN0NvZW5GZkgzUkxHM0RCSzNud3lWaWM2dGhKWks3b2Zv?=
 =?utf-8?B?QTI5cUJLZk9OUEhtdlcyN1hIUE5wTE1PbGNtNitUa1pneTByejhBK0JIQUpD?=
 =?utf-8?B?UlFCNGdoMlJLdWlCQ0drMUpYWStueDhZc0xtem5FaXQ0eTFhNWxVYTV2NGFt?=
 =?utf-8?B?TkUyNEg5bU4vUUp2OWJaR2tYMTVzbHkvUDdTOGNJamhXK3ZDNUQ0OXBPM3k0?=
 =?utf-8?B?NUplUUUxM3RUVWVETFFWL2tyK3JFeHhzR3g0aytZaWkwcHhYdjArVFljQWM2?=
 =?utf-8?B?Ny9hK0huRW9nSEpLTXRsQXJtVjlMdldmWDduR3BFNTlCL0dISGExMFRYNDVM?=
 =?utf-8?B?NnhDS1VyamY4OVo0WVRTcDBIcUI4ajNoNHJNZ2huVmc5MUhUazFsRzF0VUxk?=
 =?utf-8?B?OW1Ea1lYUGNpVXJLZmtMM09BYjJMTzNCMVJ5eWkvWXY0cmF3S2FPYnpzV3JE?=
 =?utf-8?B?NW5DWXdjN0xJLzZGb0xxYm1EZERWbkFQTFExcEI5U0tkME5RVnFacmh1elBX?=
 =?utf-8?B?L3NCZjlKaURyN3d0UXBjVHhQYkRFR3VOMFp2QTgvTWV0bW9pMDNzRHliUTU3?=
 =?utf-8?B?cDM1WmNGUWFLNTR1S2pGbnJYRW1QMzhseWUrazR3allWRG4rQXVGOUdkd253?=
 =?utf-8?B?MGJDMGxBeG0vOUJYbzZoRVhxSU5UUVM1U0ppa3pHbVJrVm1IL3JzcVY1bEYy?=
 =?utf-8?B?Z0U4T2ZLV1RuQlN1QUNDTEZVVFI0RUZUMmozbkRYcDZ6aHc3Z2w2S1RuUVVJ?=
 =?utf-8?B?Y29VWEhhMzdKMWdTV0NESlFNQitxTlE0cUtIMVdUVTVjT3E0d2tRWGVEYTh3?=
 =?utf-8?B?NVRUeWNxYXoxcmlPMkQ1cnV4eWJTUzNjb2pHWnlQMHZWNDRlc0ZtejVHbUZH?=
 =?utf-8?B?SFBNeFQ0Y0pJdHJJK0RRNGV2UW1uT3kyYm1HL3daSGYwTFhWSVh2WTFUM2ww?=
 =?utf-8?B?Mmd4N2VSR1lubi93VStEWVlDK2dQaUhyd2xXcURTc2x2S3BmaXdQT2l3NEh1?=
 =?utf-8?B?S1NsQU5QaG5nbVE3MWhQNjZWc3hHeE5adit0K2ZZRXJzajQyMHFwRUd1UWNy?=
 =?utf-8?B?Q3hlNzBjbWhjUk04ZTI1SmlUTnFpSzh4M3ZuVDVSUDZFTFl6R0ZKbGdUeFIy?=
 =?utf-8?B?S1ZlQWdwd0NLVUJsc2pLM00yVG5LRENoVDUzVlBucE5mN3pvS2gzbzZKVUQw?=
 =?utf-8?B?LzBBRVFVUGFwRFNnS25CNmVwd0pEMXd3SzFvTURHdENyLzhPcTJmcUZPdW4w?=
 =?utf-8?B?OGkyK3E1WnROQ3dXKzY3VjRMVmNDdUJhbUZDdWZyV1o2Y3pUbWRhSk1vYzF5?=
 =?utf-8?B?SWVDbkpFcjJRaWdtOWhuaUZua25zY084cnJzZXlVT1lyN2ZzRjd5eDNKRkd3?=
 =?utf-8?B?SU90dmJqckN2RWF2WktoQlYxR2hvbjVTWHVHdFZJTEJqZXY4WGMvbERGL3VI?=
 =?utf-8?Q?dfpykGasvQQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUEwN2RibU5hR09FcE1tTDZVNmdwd205KzA2RzhPT2trVUMrbm42ZnZhcGhZ?=
 =?utf-8?B?NEZ6QzhJYlR5bDc4ejZpMzVEZ2MrU1NRWFgvTzUvVjhsZTd4UFIwK0V0VDl5?=
 =?utf-8?B?dVlSWUc3WTFVQWlZdmdXS1pGVXhYY1lHbng0cmI4STAyQ3oxQ1FQM0ZpbGs1?=
 =?utf-8?B?WE04dDJFeGpzeHhCcXNxd0xtSUZ0NnFMeW1xOTdxTmpvWXo3d01ZaVRhcTdC?=
 =?utf-8?B?V240dG5aU0daSHlMeFdUV2kwMDNidkJQUmhwL21NV1dhOXV0NmI1aXRidkxR?=
 =?utf-8?B?eHhkNnhXbHVzaVVwSSs4UllmRFF2RFRZZ3IxZllVZXAxZDhQYVRUQWtablpB?=
 =?utf-8?B?bWRnL0dwQmw4OHRiZUszZzJpTTV2Z0tHWW1haHlXSlVTeDdHNHdnVWgrR01w?=
 =?utf-8?B?amVoeDVZRmZRU3dMVi9XRXFkYkh6YkVwM2hpZ0dzYWltN1VUbU90MEY1SFhO?=
 =?utf-8?B?ZExRSlpSQm12emsxdGRVM3Jibzk2aGRxWHFnNXlTSTJ0ZW9zL1R6VnZDTVFq?=
 =?utf-8?B?dDdpL2pIais1NzRaeGJwZ1JMdHB5aTVCTENlcXpQM3FieVIrYVBDajd1ZEp3?=
 =?utf-8?B?ellRc1lDcjVmbWJkT0dmVFVSaVNwZmtjTGlsSGVSa0liUmpiVUpxUjZDODdx?=
 =?utf-8?B?WGZUUVVDYVJ0b2F4d3Z2MHhhSEtUeVFYN2k0d2F0T0hqRFFNckkrVFh1U3Qx?=
 =?utf-8?B?N2pHMmw4Unl3VWhCalU2elIzdEhBWU0rL2ZOa0cyQzhUT0IwUHV6NXM2Ny96?=
 =?utf-8?B?SjR0MGpaQlJBYkRqczJOOUlsbGhXT3V0UkZyMm9xOTlRVUhwczhTNzBJb0xz?=
 =?utf-8?B?QU5MN1JobFhpaTU4MGgvYnROQUx6QWdPQzk1VzFSbTF5RTJnUGdIczcvSHhC?=
 =?utf-8?B?em4wN2lSVGc0VGZYMXNiUG9URkljenlQaW02SnAxVTR3clFaTDMxOXQ3NTFi?=
 =?utf-8?B?VFY1Z2w5MStnV21NbnZoMTlpbjBzMm9aUFlqOTVmN0l0Z3hUaHB5UUJ3cUps?=
 =?utf-8?B?OFhsWTZSZVMrU09KdUtyWkJXRGNzb0NhQ1R3cFh0VjVKenRRVkhqamtrMUVu?=
 =?utf-8?B?Y2NRRHNIY0NwV0Z3dXdDa2cwYkdiR2p0ZVc4bDV6dXh1Si8wQ1gwNFBIbDRV?=
 =?utf-8?B?cmZ3cmJnMkErdUdoMmdxMzdWZ3FXNDh5R0U0c3hxbkVwbTRuazJ3UWpjOG8y?=
 =?utf-8?B?K0MwOGZETEsveWkzV2JoWno3Znc3ZVp6VkVvRURPR2ZqeTB5YnhORXBDZmZr?=
 =?utf-8?B?eEU1Rm11L1hwNFpZR05TUHVXTmZOOE5LUDBmVjdxclREWGhzeDF6eTBQakJM?=
 =?utf-8?B?MFVoNGpIazR1SUVTODRuajJjd1IrN3Blc2ovWTRoaDErTVlBbXhRRFJGbFlR?=
 =?utf-8?B?R0wxU3lUaFNHSTJzUFgzSVB5NEQ1VkpjUG9BN2dpelRBQURxN0NpdHJFSmY0?=
 =?utf-8?B?NDQwZVRYR25qVGNESmVLTDZ5WWZ4MmJlUUtHeG85cFJGdFBRV3JYZUN3ODda?=
 =?utf-8?B?b1B0bXRnQkhlL3lLcXpSV2x4ZmEyUjl2Mk43Qk4zNWI0QnV3Q0ZvMHZibHA4?=
 =?utf-8?B?eXNlRXo0UmtHRDZHV2xjV2F2RHlOcEdHNjNncTV6MGNDcHZHNVp4UmlJRjFH?=
 =?utf-8?B?TjZZYjM2blltR2VPRGMzWHY4bUI4SG5jV0ZQVDRnVXptdzMrTGhOMlZPZk9Z?=
 =?utf-8?B?czVOVHpJaDlkcHNUSnVOMEhvazBaOXcxK3E3ZTVlY0FZSW13dVZsL0l2MjFv?=
 =?utf-8?B?RHlNaDVxZTNkNGFOV253d1BRS1pTTzhRSktaak51eEFoeGVPbjJ6NytnczQy?=
 =?utf-8?B?bnNIdktnazdSZ1RNZ0k5dlpQbng3K3NicmpCMFZPMEdXSG5FVEhJK3lQR0ZX?=
 =?utf-8?B?eHFmS2NiRXY4QWhKNXJPMzg5cEdzK0xqcnI4SEI5N2oyaXNhZ3NKN1MxMFpE?=
 =?utf-8?B?MlZScVZQZFZUUE41VGFxdFVBSnVjdUs3bDA0NFh5ZS9wR0IwaE5oTlBJcUxP?=
 =?utf-8?B?M1dqOWZSUUV3MjNhbXRsVEc1YmNSQVF2T3BJQzAzcTZuTVhqSFQ2NnpyK3JS?=
 =?utf-8?B?SmRMaFNuKzVKdzBEMHlNbjF2bU5mV1ZIbWdPcDNoVnVXTjZxUnpRWEsyZWE4?=
 =?utf-8?Q?qPL95xRHBZquKRLfWO9Awg7Ch?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e19df97-d8ee-4de0-afdc-08ddcf9d5f28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:14:57.3049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+Z2SwnfB6LtISmYR35srKAGJya6wuiZFdsJ9kVoOmOK/waP5FBZozAfjyeWjAEnKxzQb7j8Pp+YYy4c7lsM3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
Received-SPF: permerror client-ip=2a01:111:f403:2406::621;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:13AM +0200, Luc Michel wrote:
> Drop unused include directives from xlnx-versal-crl.c
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/misc/xlnx-versal-crl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
> index 08ff2fcc24f..f288545967a 100644
> --- a/hw/misc/xlnx-versal-crl.c
> +++ b/hw/misc/xlnx-versal-crl.c
> @@ -1,18 +1,15 @@
>  /*
>   * QEMU model of the Clock-Reset-LPD (CRL).
>   *
> - * Copyright (c) 2022 Advanced Micro Devices, Inc.
> + * Copyright (c) 2022-2025 Advanced Micro Devices, Inc.
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
>   * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qapi/error.h"
> -#include "qemu/log.h"
> -#include "qemu/bitops.h"
>  #include "migration/vmstate.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
>  #include "hw/irq.h"
>  #include "hw/register.h"
> -- 
> 2.50.0
> 

