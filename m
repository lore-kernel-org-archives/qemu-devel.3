Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A8AC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaUV-0005fH-IP; Thu, 31 Jul 2025 17:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZky-0006XK-Dt; Thu, 31 Jul 2025 16:20:04 -0400
Received: from mail-dm6nam11on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2415::607]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhZkt-00050c-PX; Thu, 31 Jul 2025 16:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk4KigeF68L+BSI7yAznQzvsaAMVN+yX8C+xQjiKzUo+u0PaP01/tokd7WYXbvpoxXBl3bruVD2NptilPAMYaE5ECJrgxOJMpiYPMTBTVSOrm4ACzdV4jD/Rn4eM2L6DEA2EABKvy6U1FHn99ZdDRtMgV5RG5rfZdCLMtBX8BszmE4ltpV41oFW87Mbw1zNQyuNGjx6ASYa/bYhCsSYxqxByDCbCj1wAzkQJoabycc2JZmZd5iIs02moqghetzfIxG5mrDUsFsD0xcsSF7D7lks7IYZ29NKA/i2K4Fq0GFQiQ5j4g5O98GPgufhDtUkbk7jLTklnavgmUltXNGFGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=watUp2y4PkmZk18l/TuR+GuMF1sgUjamf0OjfH+cA20=;
 b=GIZm3d8l7D+DP52eu+8dX5O9a/8a+QBiRU8mVnYLpgqMZ5VBPZ3Ao+9AEGvupgq3dtlN2jVU2Mxxc7nSXi7CmcigzHll5RnmchJ7Hecu0GNSvnA5vyyrDW60mlKtdGciXx2/zR9ncDFruT48IIh3yjueSDtOCbfEXWLTfogr6FwFxSDnlEkg8gMwnxQWS2mJKmsfrvAPOaEyMdvY1HesdAiA0rwBO+En88UktbUo2v+tGegIlwDSuibmBCAMIzN4ICzUxurQXwBOxzXVsdGSnloLcqgBx6MxeecYpFVEwx2VF8Z8XeNvKCmt+ERdVYmk+C/SURL2RWVPhYG1e7WqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=watUp2y4PkmZk18l/TuR+GuMF1sgUjamf0OjfH+cA20=;
 b=yI1RIcxgdyAccikFDU298wsd+2vAxycAR+2gvUkB7GeDx9tJAcpzgOhUOolvDQtpM8g+DxdY6r97NWoWkylKBbiCy31hSuILyg+t6WLQIO/vF+M92xhoMs3JLJ/HtU506yR1DeQyCSk4YV8DgYQfGZSh8iFclf4PLDFnOvUmEIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 20:19:53 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 20:19:53 +0000
Date: Thu, 31 Jul 2025 22:19:46 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 37/48] hw/misc/xlnx-versal-crl: add the versal2 version
Message-ID: <aIvP4o3VgIDnWMB6@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-38-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-38-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::33) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 105c923c-5be3-4fee-52cd-08ddd06f9ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVZvY1EwaVJadWpvZ05PdkQwSXdKdUY0WDhnRWdEM3NOVzZmaFp4SEs5bXRP?=
 =?utf-8?B?aTZNcTF0a09MdXdZVFF0eWd0T3VwMDNuRkJDV3BuTDVWaWxJbUhBb0VCNW1H?=
 =?utf-8?B?a2orQU9rdUhEU1UxdnJpV2t1dm1hSTh1WC9Jclp1UmVleDczOHVQbWkyL3VW?=
 =?utf-8?B?VUhDMDhTSjdHY2hWandzVWdpRFpiUWV4MEtzaitMT1k5L05oY2tHL3FDdnlk?=
 =?utf-8?B?YUJBL2g4c0h4cHdSaS8vVHUvWWpWWW5IQWhoalN2enJwdDFJZFVPZWxxZjJt?=
 =?utf-8?B?UnBQcERtOERyeng3MWxZaFdKZUlxQTI0T2ZNRWt0bC9wYjB1cVkrclhCYnp5?=
 =?utf-8?B?a0dka2lZalpXSVRaUW1tZXQzSHkwMWVqQVQrWUpkNUlLWDZobk9Da3MwNnh6?=
 =?utf-8?B?ZTFSVGRHZDU3d3QrS2tXVzlYc3pnb2JtWkphdW5Oekt0dE9EVmNoOXR2OXJJ?=
 =?utf-8?B?VWQ3TXcraGdXTWN4SU8rRkhOckR2ZGJramlrS0pBdU5XTHpqVTR3NDNUQmRp?=
 =?utf-8?B?d1c0dnNMc3l5a2NtYnZRRGFMLy91OTU1SWdmL1dyeU5FYTJmZ3pXZ2hpaEs0?=
 =?utf-8?B?OFBmaWpzN25RajUxOEkvdnFrSFR1ajRPSWR3aUQ5QzRUTjNleE1qOFJuRkpS?=
 =?utf-8?B?S2FFOVN0U0tRWnVkU2JhZGN5dy93bkJXbG53MnAwNHY0a3QxRHpMdm16NmpJ?=
 =?utf-8?B?NlRDbjVtYXVyRUNZL0tnWTZmTTVzdlM3d2lSN3lGMnhZVHdpL3FHS3hsR0RW?=
 =?utf-8?B?RXJTcjU2dmRTS0JTQ1B4aWt6RWpzKzhWemZVdFJsS3RRQ1ZPYk9CZk1CTERq?=
 =?utf-8?B?OE9zaHBrWVArUzZVQzljM3ZmQmZDZXJ5Vk1EZFEzMGpjbm9wMWVDQWJJamxF?=
 =?utf-8?B?cmxaSURKOEViOWptTytTeG8zRTFDM3BPUEtKbW1hMDNJV0dLcElhMkFTY0kw?=
 =?utf-8?B?ZTBHcmFzaGNBUVFzalJ6TVI2dWNkY3A0THRudjFzVzZsVjIrcERGVDh5c3do?=
 =?utf-8?B?eEFGT3ZPNGJ3TE4rbnZoSklmdnJZVjlxNU5JNnZQYW91MFpBYncySUVyamFQ?=
 =?utf-8?B?MzZOV0xPR0tqaGhqckZHTkNaWjNPemtWVk9kb2MvV2NSN1Bjck1QdDkrT0lj?=
 =?utf-8?B?TkxOOEJkOGtMRHM2aXRTVG5OeDBrL3UxMEUrSm9yTlBNK2Y1TWQ4ckNMTGN2?=
 =?utf-8?B?QUFtb3dacXovOEZHMjl1MDIrWVcvUUZ0K2NQOG5qZEhJT2ZHMFdGemo2dDg4?=
 =?utf-8?B?dVFkUEpGM3ZzRXVNeXp3cU5jbVRNMXpzUXJFdEpaRGVSMlBoeWhHOFRUMENq?=
 =?utf-8?B?U0lVakRUbHZIWUw3MXNxcXN6WlI3SXRPUmxWMHpiMGNSWitGZzVZUldKTHkw?=
 =?utf-8?B?RjU3MUtKOEdZNmdGNDlTUnE3UU1FMlZzMmtwKzMvR1kxU2JUc3FzaDZDUk9h?=
 =?utf-8?B?U05ONnFyZERSd1dHcVV4d1NWSUt2aVZUZzhwdGJNVlJuaDNER0VYMFBPenVH?=
 =?utf-8?B?YW16SWZwWDJwV2xNZVhNa20vVXR2blg2WlRSUnNIenVkMnFLbndwMzRxMjdk?=
 =?utf-8?B?ZE9laGFiS0pzV1VoMk5UYzRXM3VDZkgwN0pERUVqU1BNTytmOCtSRE1OWGln?=
 =?utf-8?B?alVHOVBMSjJsNEVGTjBaTTFoMS9qTU8yRTN0bkF6Y21mRWtEMXkvYWZIb0N0?=
 =?utf-8?B?VjhNZk9mK1hSbDJIVnk4OXVEWlYvVmdZNGp5ck9CV1hJVlBiRlM3aUk0Tmho?=
 =?utf-8?B?bmpOZjlramJtY0tzdjU4dDFtNVBGYm5DWEgwaXk1TGx2eVZackNSQ3FmV0li?=
 =?utf-8?B?RTFhd0pKamF4NWVlYlcrR2tZQ2lUZzZyZCtnNVBNUWREelcyOExlcnU3RFZ0?=
 =?utf-8?B?R0dmanY5THc0ckkrNkVySXJJNCsxMEM1cm5TYWlMK05TY09mTis1QlRFaVEv?=
 =?utf-8?Q?uoi8tkwl0fQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEg2TkRSK1N3N2RPWWkvSWtnQXRTMVYwakFPVldVVG5KbVJBcEN2cVhza1lY?=
 =?utf-8?B?QTB5cGFGWC96ZXM3T3VYZzdGMnE1c3RFZmFzNEd1cDJRdGhiTG40K2ZNQkdP?=
 =?utf-8?B?TFltcHpEK1JaZmVDclV0MGhlaThTdTdkUWl3ZzJJSGVuNEtQbTVKM3lnRnBx?=
 =?utf-8?B?dVVzWithWXhqVzQrS2E1T0ZJVlkrVGsram1LYmZLZHRwODZXZVVLWW0xZ0Vt?=
 =?utf-8?B?b3pwcUFpYXhzMWVyWTZoa3dYVmVYdHNMNXk4dHo1REh2a01TbFZ4K25jZ3BN?=
 =?utf-8?B?UWRYR04wZGxpWUM1TzRMNXM3aSsxQ0tuN0RFUG5LOHZBclpZNFZsZDJhYS9j?=
 =?utf-8?B?Y3NteDJ3NUl1Y2gzNXRLUHZMTWNXMTM3NkFYeWd2TnhjeWRlMHBwR2N6Q1J0?=
 =?utf-8?B?MVNYNFkwbTBoSUpva05yazlFUE0vKy82VFQrOElDZ1BuK3Bhd1AxRVlZS08z?=
 =?utf-8?B?cldrWW8vRm5vS09HOXRpU2szNXZGemlDR1pUdDY4K0dEVkxkN2NuTHlJY2oz?=
 =?utf-8?B?TVJMdzZORVV2aGFSVVJKTFF2eTVIQ0NNSlBJTFhnY2x1WjhtY0dZQXFNQk5j?=
 =?utf-8?B?ME9kSVlHdkNJcHVRMWlZMmZNSXVpVHJGMGpNYTFQM3FQbjBwcEVjdXlOSlBZ?=
 =?utf-8?B?eElOYngxeGxaS1N6bllaQXBuNXVxN3ptQTRZTU5mSHRNRHJSUXk2cG05MGpG?=
 =?utf-8?B?MHlnSXhwaDBrenNjN0ZRSVh1OEg1bERwWlFvQkNNQVRxWXF0N2FTT1BKOHpy?=
 =?utf-8?B?V3loem01ZTJPb2w2MGJEVGp1WnlvaS9PdDdWWGRnb1J1aHpqQlYycFluQ1dj?=
 =?utf-8?B?UmNlK29DLy9rcit3Nk5GenFOV3VsU3k2a1VOT2FOMlFRMjd5enRveGx0Zkxr?=
 =?utf-8?B?K1UxektjNlJCb1pDNmRsQ3NIaGxxTU5LRVRXZ2ViakhYYUFHeWVYYnp5Z0xu?=
 =?utf-8?B?UUZtcFEzZWRtQnNDY3gvOUR5RGM3T0dwUmxjY29LZktFMW14TC9VRnF6WEJK?=
 =?utf-8?B?R1AzZFRtN2RhVmY2dlV1N201SGFKTEhsL3BWNDE2Z0l2M3BiYVd1eTR4Q2xj?=
 =?utf-8?B?NU1qQU1rLzQ4OTNDV09sbmxPMlJNc1E3cUZTSkZjQTd1SmVoZERJZmZyV3Zj?=
 =?utf-8?B?V0dkVFJhZnh0VnR4UVpyQjluSitwWUIxZ1Eyek5ndUE2RXdKaUhzbG5odVVw?=
 =?utf-8?B?UHFldGh2UWVsdXVqY09nWHZySmdrTWFUTmcyc2xucjIrWisrRzQ5eklxQ2p1?=
 =?utf-8?B?MmpZQ1FCRTF5dUU2ZTdwdm82cS9PWGFHbFF3b0VqM2Rici8rY2pZUjRaa3pC?=
 =?utf-8?B?ZHBicUVJcGFhNndQTXgxTjIzNUxYbWhXS2hjblN1ZmswL0x0bjNzY3AvUGlV?=
 =?utf-8?B?NlZsTlc3V3FPMFZNRWVHLzA3OVkxNFBLeTk1MjZOR0N0VWhwM2UxcHMvTHNa?=
 =?utf-8?B?T2pMaFd0Q3NtRXpUcWFOYSs3UDlUdVhjYkFUUGJlYWdSZjMzdmlwVUpTcVdG?=
 =?utf-8?B?L2I5eDNKcXFubWhqb0p1Rm9lcjlGWFMrYkVyUkFMbTd2d0lXUFdYd1dHMGQ4?=
 =?utf-8?B?cVd1U3ZWU2ZCSVdXS2FMYW13Vnc1QW5MSGNRNXJYZkM1ZEhxVFcwUkRqeFBn?=
 =?utf-8?B?Q0RmcU5CVjBIa1pGb20zd01rZGgzbnJJVkx1VEJHajlpZU5xcXpRRmhOd1Y5?=
 =?utf-8?B?OXRGelgwTFZNcGJIZzlxbzI4MzBmVE9OcTZrR082UFh1MVcvblkxcnYvZG8v?=
 =?utf-8?B?UEE3WjZ1MGNOWEhEL0lOdUNlRVdvSGMwaDd3WldLbTcvUTNKQktQMnhTOFlV?=
 =?utf-8?B?Q2Q0eFgxSGY1ZjdSSEY1UlAxenlldEVKZ0oyODRwNzA0T1JaSlRQUGZwQ1cw?=
 =?utf-8?B?dUd6bHNPQ2tYemg1WDJEQ3pObXlnaG9YV3FzQkxQSGg3UTdId2xHcm11RDFq?=
 =?utf-8?B?aFlnWXhNK3VWL2pwNjA1Q3B5TFJHUUNBb1NOVDJzUEkwK3h6YjJ5U3FtQ054?=
 =?utf-8?B?OUlWSXlsV1NjM2lrOUM1a29QazJCRzVBSTdqdWZKd3lDRlg5Z3Z5dEJLVlk4?=
 =?utf-8?B?RG40elk3WHcwZkVjME5uU3dKNVQ5Sk9XRStUQjByeGU2Rm1NaWI3endla1pp?=
 =?utf-8?Q?6yIRtj7Nz+bkIYTxRGQva5kMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105c923c-5be3-4fee-52cd-08ddd06f9ba8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 20:19:53.1610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seWaLMqR8GXgbtJ94/O0Iw0FnOXS5Hq4CWkqhHt/yhCKerJN2CM9+E6V3IuMxHZ53n043VRvEKW16jcGTw2XNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709
Received-SPF: permerror client-ip=2a01:111:f403:2415::607;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:54:19AM +0200, Luc Michel wrote:
> Add the versal2 version of the CRL device. For the implemented part, it
> is similar to the versal version but drives reset line of more devices.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal-version.h |   1 +
>  include/hw/misc/xlnx-versal-crl.h    | 329 ++++++++++++++++++++++
>  hw/misc/xlnx-versal-crl.c            | 392 +++++++++++++++++++++++++++
>  3 files changed, 722 insertions(+)
> 
> diff --git a/include/hw/arm/xlnx-versal-version.h b/include/hw/arm/xlnx-versal-version.h
> index 46eb165a2bd..1e8d31b3248 100644
> --- a/include/hw/arm/xlnx-versal-version.h
> +++ b/include/hw/arm/xlnx-versal-version.h
> @@ -8,8 +8,9 @@
>  #ifndef HW_ARM_XLNX_VERSAL_VERSION_H
>  #define HW_ARM_XLNX_VERSAL_VERSION_H
>  
>  typedef enum VersalVersion {
>      VERSAL_VER_VERSAL,
> +    VERSAL_VER_VERSAL2,
>  } VersalVersion;
>  
>  #endif
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
> index 7e50a95ad3c..f6b8694ebea 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -15,14 +15,16 @@
>  #include "target/arm/cpu-qom.h"
>  #include "hw/arm/xlnx-versal-version.h"
>  
>  #define TYPE_XLNX_VERSAL_CRL_BASE "xlnx-versal-crl-base"
>  #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
> +#define TYPE_XLNX_VERSAL2_CRL "xlnx-versal2-crl"
>  
>  OBJECT_DECLARE_TYPE(XlnxVersalCRLBase, XlnxVersalCRLBaseClass,
>                      XLNX_VERSAL_CRL_BASE)
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
> +OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersal2CRL, XLNX_VERSAL2_CRL)
>  
>  REG32(ERR_CTRL, 0x0)
>      FIELD(ERR_CTRL, SLVERR_ENABLE, 0, 1)
>  REG32(IR_STATUS, 0x4)
>      FIELD(IR_STATUS, ADDR_DECODE_ERR, 0, 1)
> @@ -218,10 +220,318 @@ REG32(PSM_RST_MODE, 0x370)
>      FIELD(PSM_RST_MODE, WAKEUP, 2, 1)
>      FIELD(PSM_RST_MODE, RST_MODE, 0, 2)
>  
>  #define CRL_R_MAX (R_PSM_RST_MODE + 1)
>  
> +REG32(VERSAL2_ERR_CTRL, 0x0)
> +REG32(VERSAL2_WPROT, 0x1c)
> +    FIELD(VERSAL2_WPROT, ACTIVE, 0, 1)
> +REG32(VERSAL2_RPLL_CTRL, 0x40)
> +    FIELD(VERSAL2_RPLL_CTRL, POST_SRC, 24, 3)
> +    FIELD(VERSAL2_RPLL_CTRL, PRE_SRC, 20, 3)
> +    FIELD(VERSAL2_RPLL_CTRL, CLKOUTDIV, 16, 2)
> +    FIELD(VERSAL2_RPLL_CTRL, FBDIV, 8, 8)
> +    FIELD(VERSAL2_RPLL_CTRL, BYPASS, 3, 1)
> +    FIELD(VERSAL2_RPLL_CTRL, RESET, 0, 1)
> +REG32(VERSAL2_RPLL_CFG, 0x44)
> +    FIELD(VERSAL2_RPLL_CFG, LOCK_DLY, 25, 7)
> +    FIELD(VERSAL2_RPLL_CFG, LOCK_CNT, 13, 10)
> +    FIELD(VERSAL2_RPLL_CFG, LFHF, 10, 2)
> +    FIELD(VERSAL2_RPLL_CFG, CP, 5, 4)
> +    FIELD(VERSAL2_RPLL_CFG, RES, 0, 4)
> +REG32(VERSAL2_FLXPLL_CTRL, 0x50)
> +    FIELD(VERSAL2_FLXPLL_CTRL, POST_SRC, 24, 3)
> +    FIELD(VERSAL2_FLXPLL_CTRL, PRE_SRC, 20, 3)
> +    FIELD(VERSAL2_FLXPLL_CTRL, CLKOUTDIV, 16, 2)
> +    FIELD(VERSAL2_FLXPLL_CTRL, FBDIV, 8, 8)
> +    FIELD(VERSAL2_FLXPLL_CTRL, BYPASS, 3, 1)
> +    FIELD(VERSAL2_FLXPLL_CTRL, RESET, 0, 1)
> +REG32(VERSAL2_FLXPLL_CFG, 0x54)
> +    FIELD(VERSAL2_FLXPLL_CFG, LOCK_DLY, 25, 7)
> +    FIELD(VERSAL2_FLXPLL_CFG, LOCK_CNT, 13, 10)
> +    FIELD(VERSAL2_FLXPLL_CFG, LFHF, 10, 2)
> +    FIELD(VERSAL2_FLXPLL_CFG, CP, 5, 4)
> +    FIELD(VERSAL2_FLXPLL_CFG, RES, 0, 4)
> +REG32(VERSAL2_PLL_STATUS, 0x60)
> +    FIELD(VERSAL2_PLL_STATUS, FLXPLL_STABLE, 3, 1)
> +    FIELD(VERSAL2_PLL_STATUS, RPLL_STABLE, 2, 1)
> +    FIELD(VERSAL2_PLL_STATUS, FLXPLL_LOCK, 1, 1)
> +    FIELD(VERSAL2_PLL_STATUS, RPLL_LOCK, 0, 1)
> +REG32(VERSAL2_RPLL_TO_XPD_CTRL, 0x100)
> +    FIELD(VERSAL2_RPLL_TO_XPD_CTRL, DIVISOR0, 8, 10)
> +REG32(VERSAL2_LPX_TOP_SWITCH_CTRL, 0x104)
> +    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, CLKACT_ADMA, 26, 1)
> +    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_LPX_TOP_SWITCH_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_LPX_LSBUS_CLK_CTRL, 0x108)
> +    FIELD(VERSAL2_LPX_LSBUS_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_LPX_LSBUS_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_LPX_LSBUS_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_RPU_CLK_CTRL, 0x10c)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERE, 24, 1)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERD, 23, 1)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERC, 22, 1)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERB, 21, 1)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, CLKACT_CLUSTERA, 20, 1)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_RPU_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_OCM_CLK_CTRL, 0x120)
> +    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM3, 24, 1)
> +    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM2, 23, 1)
> +    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM1, 22, 1)
> +    FIELD(VERSAL2_OCM_CLK_CTRL, CLKACT_OCM0, 21, 1)
> +REG32(VERSAL2_IOU_SWITCH_CLK_CTRL, 0x124)
> +    FIELD(VERSAL2_IOU_SWITCH_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_IOU_SWITCH_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_IOU_SWITCH_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_GEM0_REF_CTRL, 0x128)
> +    FIELD(VERSAL2_GEM0_REF_CTRL, CLKACT_RX, 27, 1)
> +    FIELD(VERSAL2_GEM0_REF_CTRL, CLKACT_TX, 26, 1)
> +    FIELD(VERSAL2_GEM0_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_GEM0_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_GEM0_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_GEM1_REF_CTRL, 0x12c)
> +    FIELD(VERSAL2_GEM1_REF_CTRL, CLKACT_RX, 27, 1)
> +    FIELD(VERSAL2_GEM1_REF_CTRL, CLKACT_TX, 26, 1)
> +    FIELD(VERSAL2_GEM1_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_GEM1_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_GEM1_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_GEM_TSU_REF_CLK_CTRL, 0x130)
> +    FIELD(VERSAL2_GEM_TSU_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_GEM_TSU_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_GEM_TSU_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_USB0_BUS_REF_CLK_CTRL, 0x134)
> +    FIELD(VERSAL2_USB0_BUS_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_USB0_BUS_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_USB0_BUS_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_USB1_BUS_REF_CLK_CTRL, 0x138)
> +    FIELD(VERSAL2_USB1_BUS_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_USB1_BUS_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_USB1_BUS_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_UART0_REF_CLK_CTRL, 0x13c)
> +    FIELD(VERSAL2_UART0_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_UART0_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_UART0_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_UART1_REF_CLK_CTRL, 0x140)
> +    FIELD(VERSAL2_UART1_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_UART1_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_UART1_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_SPI0_REF_CLK_CTRL, 0x144)
> +    FIELD(VERSAL2_SPI0_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_SPI0_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_SPI0_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_SPI1_REF_CLK_CTRL, 0x148)
> +    FIELD(VERSAL2_SPI1_REF_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_SPI1_REF_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_SPI1_REF_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_CAN0_REF_2X_CTRL, 0x14c)
> +    FIELD(VERSAL2_CAN0_REF_2X_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_CAN0_REF_2X_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_CAN0_REF_2X_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_CAN1_REF_2X_CTRL, 0x150)
> +    FIELD(VERSAL2_CAN1_REF_2X_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_CAN1_REF_2X_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_CAN1_REF_2X_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_CAN2_REF_2X_CTRL, 0x154)
> +    FIELD(VERSAL2_CAN2_REF_2X_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_CAN2_REF_2X_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_CAN2_REF_2X_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_CAN3_REF_2X_CTRL, 0x158)
> +    FIELD(VERSAL2_CAN3_REF_2X_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_CAN3_REF_2X_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_CAN3_REF_2X_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C0_REF_CTRL, 0x15c)
> +    FIELD(VERSAL2_I3C0_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C0_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C0_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C1_REF_CTRL, 0x160)
> +    FIELD(VERSAL2_I3C1_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C1_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C1_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C2_REF_CTRL, 0x164)
> +    FIELD(VERSAL2_I3C2_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C2_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C2_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C3_REF_CTRL, 0x168)
> +    FIELD(VERSAL2_I3C3_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C3_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C3_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C4_REF_CTRL, 0x16c)
> +    FIELD(VERSAL2_I3C4_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C4_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C4_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C5_REF_CTRL, 0x170)
> +    FIELD(VERSAL2_I3C5_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C5_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C5_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C6_REF_CTRL, 0x174)
> +    FIELD(VERSAL2_I3C6_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C6_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C6_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_I3C7_REF_CTRL, 0x178)
> +    FIELD(VERSAL2_I3C7_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_I3C7_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_I3C7_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_DBG_LPX_CTRL, 0x17c)
> +    FIELD(VERSAL2_DBG_LPX_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_DBG_LPX_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_DBG_LPX_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_TIMESTAMP_REF_CTRL, 0x180)
> +    FIELD(VERSAL2_TIMESTAMP_REF_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_TIMESTAMP_REF_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_TIMESTAMP_REF_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_SAFETY_CHK, 0x184)
> +REG32(VERSAL2_ASU_CLK_CTRL, 0x188)
> +    FIELD(VERSAL2_ASU_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_ASU_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_DBG_TSTMP_CLK_CTRL, 0x18c)
> +    FIELD(VERSAL2_DBG_TSTMP_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_DBG_TSTMP_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_DBG_TSTMP_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_MMI_TOPSW_CLK_CTRL, 0x190)
> +    FIELD(VERSAL2_MMI_TOPSW_CLK_CTRL, CLKACT, 25, 1)
> +    FIELD(VERSAL2_MMI_TOPSW_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_MMI_TOPSW_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_WWDT_PLL_CLK_CTRL, 0x194)
> +    FIELD(VERSAL2_WWDT_PLL_CLK_CTRL, DIVISOR0, 8, 10)
> +    FIELD(VERSAL2_WWDT_PLL_CLK_CTRL, SRCSEL, 0, 3)
> +REG32(VERSAL2_RCLK_CTRL, 0x1a0)
> +    FIELD(VERSAL2_RCLK_CTRL, CLKACT, 8, 6)
> +    FIELD(VERSAL2_RCLK_CTRL, SELECT, 0, 6)
> +REG32(VERSAL2_RST_RPU_A, 0x310)
> +    FIELD(VERSAL2_RST_RPU_A, TOPRESET, 16, 1)
> +    FIELD(VERSAL2_RST_RPU_A, CORE1_POR, 9, 1)
> +    FIELD(VERSAL2_RST_RPU_A, CORE0_POR, 8, 1)
> +    FIELD(VERSAL2_RST_RPU_A, CORE1_RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_A, CORE0_RESET, 0, 1)
> +REG32(VERSAL2_RST_RPU_B, 0x314)
> +    FIELD(VERSAL2_RST_RPU_B, TOPRESET, 16, 1)
> +    FIELD(VERSAL2_RST_RPU_B, CORE1_POR, 9, 1)
> +    FIELD(VERSAL2_RST_RPU_B, CORE0_POR, 8, 1)
> +    FIELD(VERSAL2_RST_RPU_B, CORE1_RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_B, CORE0_RESET, 0, 1)
> +REG32(VERSAL2_RST_RPU_C, 0x318)
> +    FIELD(VERSAL2_RST_RPU_C, TOPRESET, 16, 1)
> +    FIELD(VERSAL2_RST_RPU_C, CORE1_POR, 9, 1)
> +    FIELD(VERSAL2_RST_RPU_C, CORE0_POR, 8, 1)
> +    FIELD(VERSAL2_RST_RPU_C, CORE1_RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_C, CORE0_RESET, 0, 1)
> +REG32(VERSAL2_RST_RPU_D, 0x31c)
> +    FIELD(VERSAL2_RST_RPU_D, TOPRESET, 16, 1)
> +    FIELD(VERSAL2_RST_RPU_D, CORE1_POR, 9, 1)
> +    FIELD(VERSAL2_RST_RPU_D, CORE0_POR, 8, 1)
> +    FIELD(VERSAL2_RST_RPU_D, CORE1_RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_D, CORE0_RESET, 0, 1)
> +REG32(VERSAL2_RST_RPU_E, 0x320)
> +    FIELD(VERSAL2_RST_RPU_E, TOPRESET, 16, 1)
> +    FIELD(VERSAL2_RST_RPU_E, CORE1_POR, 9, 1)
> +    FIELD(VERSAL2_RST_RPU_E, CORE0_POR, 8, 1)
> +    FIELD(VERSAL2_RST_RPU_E, CORE1_RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_E, CORE0_RESET, 0, 1)
> +REG32(VERSAL2_RST_RPU_GD_0, 0x324)
> +    FIELD(VERSAL2_RST_RPU_GD_0, RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_GD_0, TOP_RESET, 0, 1)
> +REG32(VERSAL2_RST_RPU_GD_1, 0x328)
> +    FIELD(VERSAL2_RST_RPU_GD_1, RESET, 1, 1)
> +    FIELD(VERSAL2_RST_RPU_GD_1, TOP_RESET, 0, 1)
> +REG32(VERSAL2_RST_ASU_GD, 0x32c)
> +    FIELD(VERSAL2_RST_ASU_GD, RESET, 1, 1)
> +    FIELD(VERSAL2_RST_ASU_GD, TOP_RESET, 0, 1)
> +REG32(VERSAL2_RST_ADMA, 0x334)
> +    FIELD(VERSAL2_RST_ADMA, RESET, 0, 1)
> +REG32(VERSAL2_RST_SDMA, 0x338)
> +    FIELD(VERSAL2_RST_SDMA, RESET, 0, 1)
> +REG32(VERSAL2_RST_GEM0, 0x33c)
> +    FIELD(VERSAL2_RST_GEM0, RESET, 0, 1)
> +REG32(VERSAL2_RST_GEM1, 0x340)
> +    FIELD(VERSAL2_RST_GEM1, RESET, 0, 1)
> +REG32(VERSAL2_RST_USB0, 0x348)
> +    FIELD(VERSAL2_RST_USB0, RESET, 0, 1)
> +REG32(VERSAL2_RST_USB1, 0x34c)
> +    FIELD(VERSAL2_RST_USB1, RESET, 0, 1)
> +REG32(VERSAL2_RST_UART0, 0x350)
> +    FIELD(VERSAL2_RST_UART0, RESET, 0, 1)
> +REG32(VERSAL2_RST_UART1, 0x354)
> +    FIELD(VERSAL2_RST_UART1, RESET, 0, 1)
> +REG32(VERSAL2_RST_SPI0, 0x358)
> +    FIELD(VERSAL2_RST_SPI0, RESET, 0, 1)
> +REG32(VERSAL2_RST_SPI1, 0x35c)
> +    FIELD(VERSAL2_RST_SPI1, RESET, 0, 1)
> +REG32(VERSAL2_RST_CAN0, 0x360)
> +    FIELD(VERSAL2_RST_CAN0, RESET, 0, 1)
> +REG32(VERSAL2_RST_CAN1, 0x364)
> +    FIELD(VERSAL2_RST_CAN1, RESET, 0, 1)
> +REG32(VERSAL2_RST_CAN2, 0x368)
> +    FIELD(VERSAL2_RST_CAN2, RESET, 0, 1)
> +REG32(VERSAL2_RST_CAN3, 0x36c)
> +    FIELD(VERSAL2_RST_CAN3, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C0, 0x374)
> +    FIELD(VERSAL2_RST_I3C0, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C1, 0x378)
> +    FIELD(VERSAL2_RST_I3C1, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C2, 0x37c)
> +    FIELD(VERSAL2_RST_I3C2, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C3, 0x380)
> +    FIELD(VERSAL2_RST_I3C3, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C4, 0x384)
> +    FIELD(VERSAL2_RST_I3C4, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C5, 0x388)
> +    FIELD(VERSAL2_RST_I3C5, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C6, 0x38c)
> +    FIELD(VERSAL2_RST_I3C6, RESET, 0, 1)
> +REG32(VERSAL2_RST_I3C7, 0x390)
> +    FIELD(VERSAL2_RST_I3C7, RESET, 0, 1)
> +REG32(VERSAL2_RST_DBG_LPX, 0x398)
> +    FIELD(VERSAL2_RST_DBG_LPX, RESET_HSDP, 1, 1)
> +    FIELD(VERSAL2_RST_DBG_LPX, RESET, 0, 1)
> +REG32(VERSAL2_RST_GPIO, 0x39c)
> +    FIELD(VERSAL2_RST_GPIO, RESET, 0, 1)
> +REG32(VERSAL2_RST_TTC, 0x3a0)
> +    FIELD(VERSAL2_RST_TTC, TTC7_RESET, 7, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC6_RESET, 6, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC5_RESET, 5, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC4_RESET, 4, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC3_RESET, 3, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC2_RESET, 2, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC1_RESET, 1, 1)
> +    FIELD(VERSAL2_RST_TTC, TTC0_RESET, 0, 1)
> +REG32(VERSAL2_RST_TIMESTAMP, 0x3a4)
> +    FIELD(VERSAL2_RST_TIMESTAMP, RESET, 0, 1)
> +REG32(VERSAL2_RST_SWDT0, 0x3a8)
> +    FIELD(VERSAL2_RST_SWDT0, RESET, 0, 1)
> +REG32(VERSAL2_RST_SWDT1, 0x3ac)
> +    FIELD(VERSAL2_RST_SWDT1, RESET, 0, 1)
> +REG32(VERSAL2_RST_SWDT2, 0x3b0)
> +    FIELD(VERSAL2_RST_SWDT2, RESET, 0, 1)
> +REG32(VERSAL2_RST_SWDT3, 0x3b4)
> +    FIELD(VERSAL2_RST_SWDT3, RESET, 0, 1)
> +REG32(VERSAL2_RST_SWDT4, 0x3b8)
> +    FIELD(VERSAL2_RST_SWDT4, RESET, 0, 1)
> +REG32(VERSAL2_RST_IPI, 0x3bc)
> +    FIELD(VERSAL2_RST_IPI, RESET, 0, 1)
> +REG32(VERSAL2_RST_SYSMON, 0x3c0)
> +    FIELD(VERSAL2_RST_SYSMON, CFG_RST, 0, 1)
> +REG32(VERSAL2_ASU_MB_RST_MODE, 0x3c4)
> +    FIELD(VERSAL2_ASU_MB_RST_MODE, WAKEUP, 2, 1)
> +    FIELD(VERSAL2_ASU_MB_RST_MODE, RST_MODE, 0, 2)
> +REG32(VERSAL2_FPX_TOPSW_MUX_CTRL, 0x3c8)
> +    FIELD(VERSAL2_FPX_TOPSW_MUX_CTRL, SELECT, 0, 1)
> +REG32(VERSAL2_RST_FPX, 0x3d0)
> +    FIELD(VERSAL2_RST_FPX, SRST, 1, 1)
> +    FIELD(VERSAL2_RST_FPX, POR, 0, 1)
> +REG32(VERSAL2_RST_MMI, 0x3d4)
> +    FIELD(VERSAL2_RST_MMI, POR, 0, 1)
> +REG32(VERSAL2_RST_OCM, 0x3d8)
> +    FIELD(VERSAL2_RST_OCM, RESET_OCM3, 3, 1)
> +    FIELD(VERSAL2_RST_OCM, RESET_OCM2, 2, 1)
> +    FIELD(VERSAL2_RST_OCM, RESET_OCM1, 1, 1)
> +    FIELD(VERSAL2_RST_OCM, RESET_OCM0, 0, 1)
> +
> +#define VERSAL2_CRL_R_MAX (R_VERSAL2_RST_OCM + 1)
> +
>  struct XlnxVersalCRLBase {
>      SysBusDevice parent_obj;
>  
>      RegisterInfoArray *reg_array;
>      uint32_t *regs;
> @@ -247,15 +557,34 @@ struct XlnxVersalCRL {
>  
>      uint32_t regs[CRL_R_MAX];
>      RegisterInfo regs_info[CRL_R_MAX];
>  };
>  
> +struct XlnxVersal2CRL {
> +    XlnxVersalCRLBase parent_obj;
> +
> +    struct {
> +        DeviceState *rpu[10];
> +        DeviceState *adma[8];
> +        DeviceState *sdma[8];
> +        DeviceState *uart[2];
> +        DeviceState *gem[2];
> +        DeviceState *usb[2];
> +        DeviceState *can[4];
> +    } cfg;
> +
> +    RegisterInfo regs_info[VERSAL2_CRL_R_MAX];
> +    uint32_t regs[VERSAL2_CRL_R_MAX];
> +};
> +
>  static inline const char *xlnx_versal_crl_class_name(VersalVersion ver)
>  {
>      switch (ver) {
>      case VERSAL_VER_VERSAL:
>          return TYPE_XLNX_VERSAL_CRL;
> +    case VERSAL_VER_VERSAL2:
> +        return TYPE_XLNX_VERSAL2_CRL;
>      default:
>          g_assert_not_reached();
>      }
>  }
>  
> diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
> index 115327cfcf4..367e42a30d3 100644
> --- a/hw/misc/xlnx-versal-crl.c
> +++ b/hw/misc/xlnx-versal-crl.c
> @@ -87,10 +87,55 @@ static DeviceState **versal_decode_periph_rst(XlnxVersalCRLBase *s,
>          /* invalid or unimplemented */
>          return NULL;
>      }
>  }
>  
> +static DeviceState **versal2_decode_periph_rst(XlnxVersalCRLBase *s,
> +                                               hwaddr addr, size_t *count)
> +{
> +    size_t idx;
> +    XlnxVersal2CRL *xvc = XLNX_VERSAL2_CRL(s);
> +
> +    *count = 1;
> +
> +    switch (addr) {
> +    case A_VERSAL2_RST_RPU_A ... A_VERSAL2_RST_RPU_E:
> +        idx = (addr - A_VERSAL2_RST_RPU_A) / sizeof(uint32_t);
> +        idx *= 2; /* two RPUs per RST_RPU_x registers */
> +        return xvc->cfg.rpu + idx;
> +
> +    case A_VERSAL2_RST_ADMA:
> +        /* A single register fans out to all DMA reset inputs */
> +        *count = ARRAY_SIZE(xvc->cfg.adma);
> +        return xvc->cfg.adma;
> +
> +    case A_VERSAL2_RST_SDMA:
> +        *count = ARRAY_SIZE(xvc->cfg.sdma);
> +        return xvc->cfg.sdma;
> +
> +    case A_VERSAL2_RST_UART0 ... A_VERSAL2_RST_UART1:
> +        idx = (addr - A_VERSAL2_RST_UART0) / sizeof(uint32_t);
> +        return xvc->cfg.uart + idx;
> +
> +    case A_VERSAL2_RST_GEM0 ... A_VERSAL2_RST_GEM1:
> +        idx = (addr - A_VERSAL2_RST_GEM0) / sizeof(uint32_t);
> +        return xvc->cfg.gem + idx;
> +
> +    case A_VERSAL2_RST_USB0 ... A_VERSAL2_RST_USB1:
> +        idx = (addr - A_VERSAL2_RST_USB0) / sizeof(uint32_t);
> +        return xvc->cfg.usb + idx;
> +
> +    case A_VERSAL2_RST_CAN0 ... A_VERSAL2_RST_CAN3:
> +        idx = (addr - A_VERSAL2_RST_CAN0) / sizeof(uint32_t);
> +        return xvc->cfg.can + idx;
> +
> +    default:
> +        /* invalid or unimplemented */
> +        return NULL;
> +    }
> +}
> +
>  static uint64_t crl_rst_cpu_prew(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(reg->opaque);
>      XlnxVersalCRLBaseClass *xvcbc = XLNX_VERSAL_CRL_BASE_GET_CLASS(s);
>      DeviceState **dev;
> @@ -305,20 +350,270 @@ static const RegisterAccessInfo crl_regs_info[] = {
>          .reset = 0x1,
>          .rsvd = 0xf8,
>      }
>  };
>  
> +static const RegisterAccessInfo versal2_crl_regs_info[] = {
> +    {   .name = "ERR_CTRL",  .addr = A_VERSAL2_ERR_CTRL,
> +        .reset = 0x1,
> +    },{ .name = "WPROT",  .addr = A_VERSAL2_WPROT,
> +    },{ .name = "RPLL_CTRL",  .addr = A_VERSAL2_RPLL_CTRL,
> +        .reset = 0x24809,
> +        .rsvd = 0xf88c00f6,
> +    },{ .name = "RPLL_CFG",  .addr = A_VERSAL2_RPLL_CFG,
> +        .reset = 0x7e5dcc6c,
> +        .rsvd = 0x1801210,
> +    },{ .name = "FLXPLL_CTRL",  .addr = A_VERSAL2_FLXPLL_CTRL,
> +        .reset = 0x24809,
> +        .rsvd = 0xf88c00f6,
> +    },{ .name = "FLXPLL_CFG",  .addr = A_VERSAL2_FLXPLL_CFG,
> +        .reset = 0x7e5dcc6c,
> +        .rsvd = 0x1801210,
> +    },{ .name = "PLL_STATUS",  .addr = A_VERSAL2_PLL_STATUS,
> +        .reset = 0xf,
> +        .rsvd = 0xf0,
> +        .ro = 0xf,
> +    },{ .name = "RPLL_TO_XPD_CTRL",  .addr = A_VERSAL2_RPLL_TO_XPD_CTRL,
> +        .reset = 0x2000100,
> +        .rsvd = 0xfdfc00ff,
> +    },{ .name = "LPX_TOP_SWITCH_CTRL",  .addr = A_VERSAL2_LPX_TOP_SWITCH_CTRL,
> +        .reset = 0xe000300,
> +        .rsvd = 0xf1fc00f8,
> +    },{ .name = "LPX_LSBUS_CLK_CTRL",  .addr = A_VERSAL2_LPX_LSBUS_CLK_CTRL,
> +        .reset = 0x2000800,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "RPU_CLK_CTRL",  .addr = A_VERSAL2_RPU_CLK_CTRL,
> +        .reset = 0x3f00300,
> +        .rsvd = 0xfc0c00f8,
> +    },{ .name = "OCM_CLK_CTRL",  .addr = A_VERSAL2_OCM_CLK_CTRL,
> +        .reset = 0x1e00000,
> +        .rsvd = 0xfe1fffff,
> +    },{ .name = "IOU_SWITCH_CLK_CTRL",  .addr = A_VERSAL2_IOU_SWITCH_CLK_CTRL,
> +        .reset = 0x2000500,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "GEM0_REF_CTRL",  .addr = A_VERSAL2_GEM0_REF_CTRL,
> +        .reset = 0xe000a00,
> +        .rsvd = 0xf1fc00f8,
> +    },{ .name = "GEM1_REF_CTRL",  .addr = A_VERSAL2_GEM1_REF_CTRL,
> +        .reset = 0xe000a00,
> +        .rsvd = 0xf1fc00f8,
> +    },{ .name = "GEM_TSU_REF_CLK_CTRL",  .addr = A_VERSAL2_GEM_TSU_REF_CLK_CTRL,
> +        .reset = 0x300,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "USB0_BUS_REF_CLK_CTRL",
> +        .addr = A_VERSAL2_USB0_BUS_REF_CLK_CTRL,
> +        .reset = 0x2001900,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "USB1_BUS_REF_CLK_CTRL",
> +        .addr = A_VERSAL2_USB1_BUS_REF_CLK_CTRL,
> +        .reset = 0x2001900,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "UART0_REF_CLK_CTRL",  .addr = A_VERSAL2_UART0_REF_CLK_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "UART1_REF_CLK_CTRL",  .addr = A_VERSAL2_UART1_REF_CLK_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "SPI0_REF_CLK_CTRL",  .addr = A_VERSAL2_SPI0_REF_CLK_CTRL,
> +        .reset = 0x600,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "SPI1_REF_CLK_CTRL",  .addr = A_VERSAL2_SPI1_REF_CLK_CTRL,
> +        .reset = 0x600,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "CAN0_REF_2X_CTRL",  .addr = A_VERSAL2_CAN0_REF_2X_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "CAN1_REF_2X_CTRL",  .addr = A_VERSAL2_CAN1_REF_2X_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "CAN2_REF_2X_CTRL",  .addr = A_VERSAL2_CAN2_REF_2X_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "CAN3_REF_2X_CTRL",  .addr = A_VERSAL2_CAN3_REF_2X_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C0_REF_CTRL",  .addr = A_VERSAL2_I3C0_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C1_REF_CTRL",  .addr = A_VERSAL2_I3C1_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C2_REF_CTRL",  .addr = A_VERSAL2_I3C2_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C3_REF_CTRL",  .addr = A_VERSAL2_I3C3_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C4_REF_CTRL",  .addr = A_VERSAL2_I3C4_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C5_REF_CTRL",  .addr = A_VERSAL2_I3C5_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C6_REF_CTRL",  .addr = A_VERSAL2_I3C6_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "I3C7_REF_CTRL",  .addr = A_VERSAL2_I3C7_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "DBG_LPX_CTRL",  .addr = A_VERSAL2_DBG_LPX_CTRL,
> +        .reset = 0x300,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "TIMESTAMP_REF_CTRL",  .addr = A_VERSAL2_TIMESTAMP_REF_CTRL,
> +        .reset = 0x2000c00,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "SAFETY_CHK",  .addr = A_VERSAL2_SAFETY_CHK,
> +    },{ .name = "ASU_CLK_CTRL",  .addr = A_VERSAL2_ASU_CLK_CTRL,
> +        .reset = 0x2000f04,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "DBG_TSTMP_CLK_CTRL",  .addr = A_VERSAL2_DBG_TSTMP_CLK_CTRL,
> +        .reset = 0x300,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "MMI_TOPSW_CLK_CTRL",  .addr = A_VERSAL2_MMI_TOPSW_CLK_CTRL,
> +        .reset = 0x2000300,
> +        .rsvd = 0xfdfc00f8,
> +    },{ .name = "WWDT_PLL_CLK_CTRL",  .addr = A_VERSAL2_WWDT_PLL_CLK_CTRL,
> +        .reset = 0xc00,
> +        .rsvd = 0xfffc00f8,
> +    },{ .name = "RCLK_CTRL",  .addr = A_VERSAL2_RCLK_CTRL,
> +        .rsvd = 0xc040,
> +    },{ .name = "RST_RPU_A",  .addr = A_VERSAL2_RST_RPU_A,
> +        .reset = 0x10303,
> +        .rsvd = 0xfffefcfc,
> +        .pre_write = crl_rst_cpu_prew,
> +    },{ .name = "RST_RPU_B",  .addr = A_VERSAL2_RST_RPU_B,
> +        .reset = 0x10303,
> +        .rsvd = 0xfffefcfc,
> +        .pre_write = crl_rst_cpu_prew,
> +    },{ .name = "RST_RPU_C",  .addr = A_VERSAL2_RST_RPU_C,
> +        .reset = 0x10303,
> +        .rsvd = 0xfffefcfc,
> +        .pre_write = crl_rst_cpu_prew,
> +    },{ .name = "RST_RPU_D",  .addr = A_VERSAL2_RST_RPU_D,
> +        .reset = 0x10303,
> +        .rsvd = 0xfffefcfc,
> +        .pre_write = crl_rst_cpu_prew,
> +    },{ .name = "RST_RPU_E",  .addr = A_VERSAL2_RST_RPU_E,
> +        .reset = 0x10303,
> +        .rsvd = 0xfffefcfc,
> +        .pre_write = crl_rst_cpu_prew,
> +    },{ .name = "RST_RPU_GD_0",  .addr = A_VERSAL2_RST_RPU_GD_0,
> +        .reset = 0x3,
> +    },{ .name = "RST_RPU_GD_1",  .addr = A_VERSAL2_RST_RPU_GD_1,
> +        .reset = 0x3,
> +    },{ .name = "RST_ASU_GD",  .addr = A_VERSAL2_RST_ASU_GD,
> +        .reset = 0x3,
> +    },{ .name = "RST_ADMA",  .addr = A_VERSAL2_RST_ADMA,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_SDMA",  .addr = A_VERSAL2_RST_SDMA,
> +        .pre_write = crl_rst_dev_prew,
> +        .reset = 0x1,
> +    },{ .name = "RST_GEM0",  .addr = A_VERSAL2_RST_GEM0,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_GEM1",  .addr = A_VERSAL2_RST_GEM1,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_USB0",  .addr = A_VERSAL2_RST_USB0,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_USB1",  .addr = A_VERSAL2_RST_USB1,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_UART0",  .addr = A_VERSAL2_RST_UART0,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_UART1",  .addr = A_VERSAL2_RST_UART1,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_SPI0",  .addr = A_VERSAL2_RST_SPI0,
> +        .reset = 0x1,
> +    },{ .name = "RST_SPI1",  .addr = A_VERSAL2_RST_SPI1,
> +        .reset = 0x1,
> +    },{ .name = "RST_CAN0",  .addr = A_VERSAL2_RST_CAN0,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_CAN1",  .addr = A_VERSAL2_RST_CAN1,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_CAN2",  .addr = A_VERSAL2_RST_CAN2,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_CAN3",  .addr = A_VERSAL2_RST_CAN3,
> +        .reset = 0x1,
> +        .pre_write = crl_rst_dev_prew,
> +    },{ .name = "RST_I3C0",  .addr = A_VERSAL2_RST_I3C0,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C1",  .addr = A_VERSAL2_RST_I3C1,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C2",  .addr = A_VERSAL2_RST_I3C2,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C3",  .addr = A_VERSAL2_RST_I3C3,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C4",  .addr = A_VERSAL2_RST_I3C4,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C5",  .addr = A_VERSAL2_RST_I3C5,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C6",  .addr = A_VERSAL2_RST_I3C6,
> +        .reset = 0x1,
> +    },{ .name = "RST_I3C7",  .addr = A_VERSAL2_RST_I3C7,
> +        .reset = 0x1,
> +    },{ .name = "RST_DBG_LPX",  .addr = A_VERSAL2_RST_DBG_LPX,
> +        .reset = 0x3,
> +        .rsvd = 0xfc,
> +    },{ .name = "RST_GPIO",  .addr = A_VERSAL2_RST_GPIO,
> +        .reset = 0x1,
> +    },{ .name = "RST_TTC",  .addr = A_VERSAL2_RST_TTC,
> +        .reset = 0xff,
> +    },{ .name = "RST_TIMESTAMP",  .addr = A_VERSAL2_RST_TIMESTAMP,
> +        .reset = 0x1,
> +    },{ .name = "RST_SWDT0",  .addr = A_VERSAL2_RST_SWDT0,
> +        .reset = 0x1,
> +    },{ .name = "RST_SWDT1",  .addr = A_VERSAL2_RST_SWDT1,
> +        .reset = 0x1,
> +    },{ .name = "RST_SWDT2",  .addr = A_VERSAL2_RST_SWDT2,
> +        .reset = 0x1,
> +    },{ .name = "RST_SWDT3",  .addr = A_VERSAL2_RST_SWDT3,
> +        .reset = 0x1,
> +    },{ .name = "RST_SWDT4",  .addr = A_VERSAL2_RST_SWDT4,
> +        .reset = 0x1,
> +    },{ .name = "RST_IPI",  .addr = A_VERSAL2_RST_IPI,
> +    },{ .name = "RST_SYSMON",  .addr = A_VERSAL2_RST_SYSMON,
> +    },{ .name = "ASU_MB_RST_MODE",  .addr = A_VERSAL2_ASU_MB_RST_MODE,
> +        .reset = 0x1,
> +        .rsvd = 0xf8,
> +    },{ .name = "FPX_TOPSW_MUX_CTRL",  .addr = A_VERSAL2_FPX_TOPSW_MUX_CTRL,
> +        .reset = 0x1,
> +    },{ .name = "RST_FPX",  .addr = A_VERSAL2_RST_FPX,
> +        .reset = 0x3,
> +    },{ .name = "RST_MMI",  .addr = A_VERSAL2_RST_MMI,
> +        .reset = 0x1,
> +    },{ .name = "RST_OCM",  .addr = A_VERSAL2_RST_OCM,
> +    }
> +};
> +
>  static void versal_crl_reset_enter(Object *obj, ResetType type)
>  {
>      XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
>      unsigned int i;
>  
>      for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
>          register_reset(&s->regs_info[i]);
>      }
>  }
>  
> +static void versal2_crl_reset_enter(Object *obj, ResetType type)
> +{
> +    XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
> +    size_t i;
> +
> +    for (i = 0; i < VERSAL2_CRL_R_MAX; ++i) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +}
> +
>  static void versal_crl_reset_hold(Object *obj, ResetType type)
>  {
>      XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
>  
>      crl_update_irq(s);
> @@ -386,10 +681,77 @@ static void versal_crl_init(Object *obj)
>                                   qdev_prop_allow_set_link_before_realize,
>                                   OBJ_PROP_LINK_STRONG);
>      }
>  }
>  
> +static void versal2_crl_init(Object *obj)
> +{
> +    XlnxVersal2CRL *s = XLNX_VERSAL2_CRL(obj);
> +    XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    size_t i;
> +
> +    xvcb->reg_array = register_init_block32(DEVICE(obj), versal2_crl_regs_info,
> +                                            ARRAY_SIZE(versal2_crl_regs_info),
> +                                            s->regs_info, s->regs,
> +                                            &crl_ops,
> +                                            XLNX_VERSAL_CRL_ERR_DEBUG,
> +                                            VERSAL2_CRL_R_MAX * 4);
> +    xvcb->regs = s->regs;
> +
> +    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.rpu); ++i) {
> +        object_property_add_link(obj, "rpu[*]", TYPE_ARM_CPU,
> +                                 (Object **)&s->cfg.rpu[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.adma); ++i) {
> +        object_property_add_link(obj, "adma[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.adma[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.sdma); ++i) {
> +        object_property_add_link(obj, "sdma[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.sdma[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.uart); ++i) {
> +        object_property_add_link(obj, "uart[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.uart[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.gem); ++i) {
> +        object_property_add_link(obj, "gem[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.gem[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.usb); ++i) {
> +        object_property_add_link(obj, "usb[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.usb[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +
> +    for (i = 0; i < ARRAY_SIZE(s->cfg.can); ++i) {
> +        object_property_add_link(obj, "can[*]", TYPE_DEVICE,
> +                                 (Object **)&s->cfg.can[i],
> +                                 qdev_prop_allow_set_link_before_realize,
> +                                 OBJ_PROP_LINK_STRONG);
> +    }
> +}
> +
>  static void crl_finalize(Object *obj)
>  {
>      XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
>      register_finalize_block(s->reg_array);
>  }
> @@ -402,10 +764,20 @@ static const VMStateDescription vmstate_versal_crl = {
>          VMSTATE_UINT32_ARRAY(regs, XlnxVersalCRL, CRL_R_MAX),
>          VMSTATE_END_OF_LIST(),
>      }
>  };
>  
> +static const VMStateDescription vmstate_versal2_crl = {
> +    .name = TYPE_XLNX_VERSAL2_CRL,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, XlnxVersal2CRL, VERSAL2_CRL_R_MAX),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
>  static void versal_crl_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
> @@ -414,10 +786,21 @@ static void versal_crl_class_init(ObjectClass *klass, const void *data)
>      rc->phases.enter = versal_crl_reset_enter;
>      rc->phases.hold = versal_crl_reset_hold;
>      xvcc->decode_periph_rst = versal_decode_periph_rst;
>  }
>  
> +static void versal2_crl_class_init(ObjectClass *klass, const void *data)
> +{
> +    XlnxVersalCRLBaseClass *xvcc = XLNX_VERSAL_CRL_BASE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_versal2_crl;
> +    rc->phases.enter = versal2_crl_reset_enter;
> +    xvcc->decode_periph_rst = versal2_decode_periph_rst;
> +}
> +
>  static const TypeInfo crl_base_info = {
>      .name          = TYPE_XLNX_VERSAL_CRL_BASE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(XlnxVersalCRLBase),
>      .class_size    = sizeof(XlnxVersalCRLBaseClass),
> @@ -431,12 +814,21 @@ static const TypeInfo versal_crl_info = {
>      .instance_size = sizeof(XlnxVersalCRL),
>      .instance_init = versal_crl_init,
>      .class_init    = versal_crl_class_init,
>  };
>  
> +static const TypeInfo versal2_crl_info = {
> +    .name          = TYPE_XLNX_VERSAL2_CRL,
> +    .parent        = TYPE_XLNX_VERSAL_CRL_BASE,
> +    .instance_size = sizeof(XlnxVersal2CRL),
> +    .instance_init = versal2_crl_init,
> +    .class_init    = versal2_crl_class_init,
> +};
> +
>  static void crl_register_types(void)
>  {
>      type_register_static(&crl_base_info);
>      type_register_static(&versal_crl_info);
> +    type_register_static(&versal2_crl_info);
>  }
>  
>  type_init(crl_register_types)
> -- 
> 2.50.0
> 

