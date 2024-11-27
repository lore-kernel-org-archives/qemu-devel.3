Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622F2D6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGM4Q-0006wt-0q; Wed, 27 Nov 2024 12:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tGM4M-0006qO-0Z; Wed, 27 Nov 2024 12:43:19 -0500
Received: from mail-db8eur05on2096.outbound.protection.outlook.com
 ([40.107.20.96] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tGM4I-0007Gq-Oh; Wed, 27 Nov 2024 12:43:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6T8Fk+v5zfZ6azczsT5DAR6hJ4bGpLu1v8IvY0MJ3yAWByInuDuDhdg3v+YTSHiXVpxD91RCbmvOAEVeY+sn+jFh4V5EcBrRERMomSGM17kTROs/m6wTI61dMpkCQ8QLwiC0GxdD2GnDc+VfcjWer2tYAFbt4Zj7JN3o/9YuYaTH1K8wkWHbfUNgFokUIF0R9l8jp+p9LMKNkSknR8u5bV3IFGqvN76ilm/1Kz0EnbE8+IK1uMrk+fMCy7UhZOl75kDIbViuA0H6C3Eip1qBYQnAwka9hWCGxf5hcxaVLN6wnVMc5PvrmTp8L6LhPE8yA+JZSqKuKVs45o+6Zdd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jfsj+gzJLWPIYS0TFF+Q8nN34aw8Df8VUhXect/VGc=;
 b=FaH9notP7mulEhDYIswJaoshoZ9VcHY88ZUxGKJbE3H/p49iZdrpvwkTjN2Bsai4c6XYyQvj4Se4tR1pEsNQvH+a4+pll3tD9Axp0u5BXBzAcwBYVM9gUTDWhX4yAlyzrGPQU1wUsvsajL+Jq6WHmBlM3sCADJk5erSLfXY4FsOu41dFAIILg3P0j4gNZIgSEprm52hQ7AG2pjElRaTj0pBzPtnPhY5VXYL4EfhoB6UIEE4DteVtQ6fmW+psTYEoiBxKf6MeFUnM79gWSRpd++3qyTwtc6iv+yEavT5hlnhOcFMcJimGS6PZiECqw9Ab0SjoTKLnXIa2VwUoIdRWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jfsj+gzJLWPIYS0TFF+Q8nN34aw8Df8VUhXect/VGc=;
 b=XEPxHpaVNIruQmzo3aYfojEOF8OFGZJ3xui3Q4+DSKlGFa6hZVN+QSvSdoNTxrl0AkGsgrYM06juotcP0ToZsZd5j4FcCdAT/p0vxgtPpnDAmdJ7Vs5rzg7FzWUx/vg+P2cC69jO1v7gwhZv+sh9Jju7AGSLStVe6gR+PF2sguYNHOOPXI44OfbQ+3XFfZKXP809S+X9A1H/lxJeyN2Ns+YADNQybs2TzBExNjppGJe3IPGT6yh4ao8CuU66nPdmUg40aGkb0AoekUmsSkX+hHyrOfxNntlMctMDw5K2jY+Cxpwmdg1U8HytkExfoWYt8SRKFCBWBysK4+HxcZNqRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5586.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 17:38:07 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 17:38:07 +0000
Message-ID: <24840b1d-7bd5-4ab8-b7d7-8736b913732b@virtuozzo.com>
Date: Wed, 27 Nov 2024 19:40:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] migration: Activate block devices if VM is paused
 when migrating
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 den@virtuozzo.com, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20241125144612.16194-1-farosas@suse.de>
 <20241125144612.16194-5-farosas@suse.de>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20241125144612.16194-5-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 894c85cb-0de4-49d9-7654-08dd0f0a40c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?My9taWRwcVIzRUlUMGhYVm1GZTQ4U2hNZTBiL3VzNDlNSXQ3cGJ3a0htNG8w?=
 =?utf-8?B?bXFEa2NjTHlVcmhFZkliUDZkN0pVRFVqR3BYTEEvVU9ON01tbTJCSEdFKzYv?=
 =?utf-8?B?ZEpSVmFnQTlSWVJYOVM2akM0ZDJzMldld0RsOXBaMEFHYS9HSGNmRjRNUnM3?=
 =?utf-8?B?aldGcGhHanVkUGRzMnJzdW5QVDJSM0ZJL0JjWEZwdE1VWndBTjBXQ3N2TURF?=
 =?utf-8?B?a3A2VEo0Vnd5T1pNS1dmbkRjc2xZVmxaQ3NKZ1o1bFVjUGxDQW9lUmk2TTQx?=
 =?utf-8?B?NldUUG9nTVFCb1BjOEFWODhWNi9qVm4yL2hQU1NxeHdzaW8rTjk5V3RNdDJN?=
 =?utf-8?B?WGxzdWtKQkptT1A2YUtxSXp3S2g0VllYTnJLT3VOZ29kQ2JtVHhwQ3JPUkdG?=
 =?utf-8?B?aWhiTVNxNnBTckN1OFVtL0xjM01PTHdjbTNCQkt6UDVLdXBWTHV6QXhTQng0?=
 =?utf-8?B?QTR2Vmk2VzYxbHptK2V2UHZKK3Z0d1lzNGd0Rk1nMkZ1cDQvYzBPYWNuRHUx?=
 =?utf-8?B?WGNJQ3dNdERxTGczTVZ6L0R5ME5VNWI3cTUvK21rL29NZGxwK05xWm1LMll5?=
 =?utf-8?B?cUpaczZjTzlmbjZSUmcwYjhQTSs0YUIrT0FITnYwbEtnM0szdEgrb291Tkh3?=
 =?utf-8?B?bE9mMkxXc0l2VTRyUjZRVGlhLysrb1VEVCtPb3JvN1JkSHNxR3cydTFtZVo5?=
 =?utf-8?B?YTBGaEpkall2Yys4TXhlSERlcXBwTWg2dWlua3J2TEwyTFNWeVRMRUUvZTVq?=
 =?utf-8?B?SnM2K2FZT09nTFNYSnR4Nm9kVUhqUVJHVmwyWWQ1S081WWhUQkMvRzVEdzlw?=
 =?utf-8?B?UTZBN2ZkUElYbTh3MzgwY0Qvd3JzR1F1U2FtVjh1UjhoRGhRNE5iSEVXeXlr?=
 =?utf-8?B?RW5Ja0dFamNNZWFXRlFrYllpMFBwb1JZdlJRRVRwblVSZGN5MVJrSGpaNXFG?=
 =?utf-8?B?YWwwOXlHendZVnU0azBxSi9Mc016OVNWQXAxSktHSzFwMitQYmdETUNOVnJF?=
 =?utf-8?B?UG1NTTArRFRVVnVTNzlzaHB1ejB3ZENxMXVEZjJwbUZKMEFybXI4SXRGT2c1?=
 =?utf-8?B?M0hMb1NRV0hQQzdlQ3FTUlFVOE1LY3Axc3Z5YTlncWR1S3plMDl2QytLRno4?=
 =?utf-8?B?ZW9yQTFERXdWSFN6TFltRnNNU2ZHUkNhdFZjSUNMWklnVDhwY2xuQlkrZS9p?=
 =?utf-8?B?K2x1MGdWTVhIek82ejd2YjIzL05BTFRBTmd1MVo2QmdjeHd5RTAxSFdyeUNl?=
 =?utf-8?B?cVNJYjVpd2dlUVJkMG9JN2MvTUE0UDhPSU1LdWQ2ZE5Pb3dob013amRqQ0l3?=
 =?utf-8?B?bEpvR09uTDl4QXVVNmtocEtpTHFNVkFHaDV1K1lvSVh4Si9zRHZyWXFEM0Nr?=
 =?utf-8?B?OGQ0cUxJNVd0Nk1jVXdOT0NzVnBNUEZ2Vlk2YlE2ZlRHcjZlSUp1eG4vb2Fy?=
 =?utf-8?B?RCtyRFVoQjRGUTg4OUJyY1FCWXVvNitJWWZ2MENObXF2dFFyeHJXQjVDb3pw?=
 =?utf-8?B?aDNNV3JyMVNhT3I4aXRyQlNuZkpYMmNXQmVLL09ROXQ3RTdCcVpqL1p6clZN?=
 =?utf-8?B?Tzl0dk9CRE1mbkR1emt2U3djeGQyL1phc2RNREFjUW93YWlYbFRxcTlhSWtL?=
 =?utf-8?B?UjVvbmdzZ0ZDWUpXZEM0L29LUlNCRkpjbmVqdGtjNHZpcnJEd2dKQnZtUlRD?=
 =?utf-8?B?MnN2blNiaHhwNk00YnI3WERLTmlHclc2N1BQRUhzbm15dDFWVFZhUHlpcnVQ?=
 =?utf-8?B?NkxTRDZmdktnUkZtRmppTnIzaWgxZWExOFV4RkxWYWUzU1p4S0phK2J5S1B4?=
 =?utf-8?B?QlFZbEZCbnoxM2c0dzFuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGN4bEJHZXJtQTI0ekJPb2lOS3RPRCtYaFJaU3FtRmErVCtNNjFhK0traUR0?=
 =?utf-8?B?NFJJcGtRUHNBYjZVV1hra05RelJDdU53N0o2N25vYmhWUnVGT0hGRGNzaXMr?=
 =?utf-8?B?VWgzTnZvWW5RdVZYTXR0ZW5VSTJ1dUk3Uk4rdGFYdUpLUG5HRHZ1RTJFSmNG?=
 =?utf-8?B?dkRsTkNyTkIrZ21ZNnNEc3VaV0I1WmdsRWcvdytmQ0tUcWJjdVNLQzd5N1RZ?=
 =?utf-8?B?YXVWY1E3VkwzTVI4VG5FV3NoUjVPaWYrTUNYRmpjd3BBV3pwWXdjUllhNFF5?=
 =?utf-8?B?amFURXZrTDN3RjZ0aTl3YkthM3ptT0xiQ01GSjhOMTVYNnBPaU1FajMwbkJz?=
 =?utf-8?B?UVYrb1RzWW9jSnYyUWZadFpiMDBjdkRqZUo4bXNvOG10aDlXMk1EbDBwRVpy?=
 =?utf-8?B?RGZrc1dNaFVrNldXYlB4U2orUlhCWjJFcmNJM1dPMTlFZ1htS0xwL3pFbUlN?=
 =?utf-8?B?RVlNbldvNmltRVpuREtrSVVUVWV5MlU2bzBHQlRxNW4xOGluTTg0SnNWQ3Ns?=
 =?utf-8?B?N0JuMHRBSjlibWorcnlUVkpRdjRUZWNFc2JMdmJUQWdLQTlYcXVNM3NlS2Z5?=
 =?utf-8?B?d2hJK2RSRG8rczFRbHVDZ3Z1T0FTL25FZjJ5aDNPVDIrSHRqZU13c2pzN0Js?=
 =?utf-8?B?OXJmaDEwOTErZVlYK09WZlJZKy9YSHFEbXNpc29FWURCU0JaMDVuWHgwaVRp?=
 =?utf-8?B?c0k0UGtYM0RpVG5HY1ZOK2ZGQTBvOCtPYWtBRFdmNExESkE0Z21NSTByZkxa?=
 =?utf-8?B?QnpwSDlTTXNNbFhzZEhoZ1hQd2RUTTZ4cldtRWVRTk1JM3NkMHdZS2tWTDlj?=
 =?utf-8?B?djc2TXVnd1ZwSWhuV25kMEZSMWNGSTZHWnovb0M1ODJIVFFkZnFJYi9vNDdJ?=
 =?utf-8?B?NTlzT0h1L1ZmVmpkSEVyamc2Um1LajgweFZHQnFZL1pmdk5xN1ZEM2xkTnkw?=
 =?utf-8?B?a3VPQjFVZW0xYVhuVXZWd0JEcWlaY3p6dkE0aXAwWTBId043aGkzTXEvZlQz?=
 =?utf-8?B?ZzZ5U2xQcHFBM2JPNjVvSmNQNGR5Nm9ENHlWd1FvL2JGR2hkZjBNUWFkYkdB?=
 =?utf-8?B?NFZBQlRVemdYaURrV0p5b3pVcVRJSjdMSnloSDRZUUs4LzgyMi9HQlVOZE4x?=
 =?utf-8?B?Mld3dVVmWXdWVnpTNlZpUWhYRE51ZEswZDlSMmpkTjFTdmVsZkdiVktDZU1Q?=
 =?utf-8?B?bW1ISWtBUFByclZsT3JsRm8yMDJZQ3lyRHdGL1JYR3AvMVZEZTlsTXphejJE?=
 =?utf-8?B?a0lJV09aL1dTaWhQeUg3dVRSdXR6UVNzbHgrYXI4WENGU0svdWhTcnBmOGVr?=
 =?utf-8?B?Wjdkamk5UkdmRk5oQ2gzSTArYTliMHk0bWtMTVJVaUI2WWRXRHByNjRyY3Av?=
 =?utf-8?B?eXVtcTMvajlCa1lZOUVhNkdsUHBiOWU3VFF6anAyNlY5M3g4OC8rVExwWlNz?=
 =?utf-8?B?NkxyeHNsenhjMm45b24xVjJ0c01zOVNIdUJaNVJuTUk3Q3Vid0lPdFJvbENV?=
 =?utf-8?B?UnZ4SFJCYmhnbUxpaDNGWVBleEo3Zm8xNnVPdTVxMlVmMERDZzlCSkhiS2cz?=
 =?utf-8?B?T2x6Z05xK3lJNFVVZjNrakI5S1R1TkdnUGc2aU95b1VuTC9GdWMxb3VTNSsw?=
 =?utf-8?B?dzZzM0Izb1ZpSjg2akhZTjVLQUpaQndMNzVSOWtLTEt0eDhDb2pZeCtVVEtk?=
 =?utf-8?B?TWVBbUVpN2Z1NG45U3ZrZWFDTHE2MUw0cEdONGNHZUMvZ2xXUVFlN3Rvblgv?=
 =?utf-8?B?Y3FtK3FQcmlXT09iMk4yc2l5RTcwZjd5VVYvVmRmekVBUkZUbDBHazR2MnhK?=
 =?utf-8?B?TG1vUTBieUc4QjNJUmgyOXFnRFMzVWJmNlhmYXZHUVhweWJYK3pqbzBKSmJ4?=
 =?utf-8?B?elg2VWhWNWRLV0ZGTktNUnpRNmU2MVR3QzhpVy9ZWUNuQWpsK1pERk54SVJE?=
 =?utf-8?B?ZEM1Wkxvd290NzdlajE4VmpXVjVpbVNPck40bDBIaTc5SllDVm9zSFZCZFQz?=
 =?utf-8?B?aTFzSkJrZ1dLQVJFb1BEY01VSnl0VlFTQmtFYjdMd2U3Y0dVQnhHT1MyUFpv?=
 =?utf-8?B?NkNpMFVmM3ltdEl1UmtybG5yVzVmU0ZuR0g1RnVxSk03QWoxZngySWdITTM2?=
 =?utf-8?B?dGhuNjhnMWJtd3lSWk51S1AzR2l1bWIzblFVQkxHQVFxOUdkbHhKOHpHODN0?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c85cb-0de4-49d9-7654-08dd0f0a40c7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 17:38:06.9407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2H1QOkKz/icxtMnS3sojLhvc1/trjBaOdPMMvPcUp9OW/Iz1vV3Ry69USTrnZ/rMPxPc5eSO53b1a9jGim7UWloTxQ1ZoK3bH/H+YOWv/aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
Received-SPF: pass client-ip=40.107.20.96;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.931, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 11/25/24 4:46 PM, Fabiano Rosas wrote:
> Currently a VM that has been target of a migration using
> late-block-activate will crash at the end of a new migration (with it
> as source) when releasing ownership of the disks due to the VM having
> never taken ownership of the disks in the first place.
> 
> The issue is that late-block-activate expects a qmp_continue command
> to be issued at some point on the destination VM after the migration
> finishes. If the user decides to never continue the VM, but instead
> issue a new migration, then bdrv_activate_all() will never be called
> and the assert will be reached:
> 
> bdrv_inactivate_recurse: Assertion `!(bs->open_flags &
> BDRV_O_INACTIVE)' failed.
> 
> Fix the issue by checking at the start of migration if the VM is
> paused and call bdrv_activate_all() before migrating. Even if the
> late-block-activate capability is not in play or if the VM has been
> paused manually, there is no harm calling that function again.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index aedf7f0751..26af30137b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2029,6 +2029,25 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          return false;
>      }
>  
> +    /*
> +     * The VM might have been target of a previous migration. If it
> +     * was in the paused state then nothing will have required the
> +     * block layer to be activated. Do it now to ensure this QEMU
> +     * instance owns the disk locks.
> +     */
> +    if (!resume && runstate_check(RUN_STATE_PAUSED)) {
> +        Error *local_err = NULL;
> +
> +        g_assert(bql_locked());
> +
> +        bdrv_activate_all(&local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return false;
> +        }
> +        s->block_inactive = false;
> +    }
> +
>      return true;
>  }
> 

Hi Fabiano,

Thans for the fix, I can confirm that on my setup (2 nodes with common
NFS share and VM's disk on the share) this patch does solve the issue.

Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

