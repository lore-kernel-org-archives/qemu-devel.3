Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0DAC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8tk-0004VX-LH; Wed, 30 Jul 2025 11:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uh7qk-0007kZ-IT; Wed, 30 Jul 2025 10:32:12 -0400
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com
 ([40.107.236.65] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uh7qg-0002Bg-Sg; Wed, 30 Jul 2025 10:32:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfP5qu5dJvbfALIGbqnF2x0z4MPzMa8CIIu7vc/qruiUnnwGZKWbWD9wk/zZkNqzWIJweO8oLWifD/VdCtDZ8hxT8HcwXrXcMbTOBIZ+IVXT9CpWrvSaFhp8SYNYAkzcmUH2pexj/q1CBVPkZnngWey8k6N9OEI6Ltk7JgYCA6leS+bskAk9KEOeuz0abpeb4VTE5pokmt/e1tufJX+QUR/JXf/R8oO6sr+SkD5voSRibJx8vFg+ojNWrJ8UWL/3nIT6wLsIJmXjsawPDdPMxh3iU/odZmr1CbJ7+IeacOa8YSbhIYfK4hogRfp6UYLh8iyZ05Js9vtGxkpTRZK3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVUSQXOc3gcM4ToooCisdnX+hDCXQmrOF5sw62bvMhU=;
 b=iJJdVZe9U7+wn39hN7upLlGB3p1wLweIrTJGHQtd/gIO5M5gM3l9PYNAU991iRL/OG3rpVbAqNQ6lq9nRA1IhzuWyjIbZTM036CbE9fjiMei4ScT3t8W1YSr1KZthpWWPJvPzVXI+3vQwLoGoQfDyopJKSmJCezPY8YIXwAB00YKaZkifiI8Y2FLHhO6yz2N00axY8tvF9RAZCDOEjiKQfeuKiVr9qfGsdv6U/Fbu+ugOIqApJ1zp0r6/olk6VJzHZO7dB7fkvNyE/5rhxAMHmV3WjkOmiC2kZGpIo9BGxqDcdm7ltJUQ7NZMT5+C15TA+6XG5uUkhtkQtTLksIoIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVUSQXOc3gcM4ToooCisdnX+hDCXQmrOF5sw62bvMhU=;
 b=ILHPghHlDcGKc7kj+nLfwvlyJrCjal6A/ULYpoqRiGBpALYRNlhg/8mxC0koZPdyUkCUE5moixgc2VUiFImY9PWWm8uZ1D4WHKlP451yW7oCdayxC52m7x7yGa2Xsydb2o/pDj91KuCXDXqs5ca77wjdr/fJrHgS1r0JcSlt6dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 14:26:59 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 14:26:59 +0000
Date: Wed, 30 Jul 2025 16:26:53 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 25/48] hw/arm/xlnx-versal: add support for multiple GICs
Message-ID: <aIorrXAfFFPj9nto@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-26-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-26-luc.michel@amd.com>
X-ClientProxiedBy: PA7P264CA0217.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::18) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 7441891c-8911-44b1-c1ab-08ddcf7524d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDBQcE9IYjc1RTJtN043cnNkSVV4NUtRdWM1QVBwYVJjMDdzdS9ObWtuSlY4?=
 =?utf-8?B?a2x2QWpGQ1N4OHVRVWMyUkM4ZHF4bG9QUkNLbVJQMnR1Qkw4eXFUR3lmYTBo?=
 =?utf-8?B?WTZ2OFdRZUlIWE4wU1pEQXhDbjdoaGVaWHVqY1A3SjJhOEtucjFWQzhIZVU5?=
 =?utf-8?B?L3hQbG1EanNYWmF0dUVmRG9LMWFwR3ZTUkJoNGZlWDUra1F4VWMvQ0hBMjBG?=
 =?utf-8?B?WUUzaGd4WWJqcm1iTmNETjdndlcvaUwyQ285T2NoZUJPOTBrU0NYVmNRc0d6?=
 =?utf-8?B?dmxvK1hXQUZiQlBtSnk3cS95YTM1dlBlSWZhTzI1ZjNKMnhYcndFNU9DSE84?=
 =?utf-8?B?VWhCNWhlaDNhcThpZHp4bHBRR3pnNmNpZDBIZWc0dXUrZC9nUG9oNTdSSzJ4?=
 =?utf-8?B?dHVRRnVsMzZxN3RQbW84bng4dENPc1FiL3VUcE5GanBMRFd3T2l2SVFRQUIz?=
 =?utf-8?B?RW5ONi9QYlVXKzd5UU0xaEhDL29zKzJ1TEZYOUIzS3pHZ1REaVNQais3a0dS?=
 =?utf-8?B?ck9OMFN4Nk9idEMxbzljSERMSWwxUGdhRVpCNzdzM0x6NmxLcmFnb3dUaWRD?=
 =?utf-8?B?d0lTUnB3a2dHZnNadmEvWHRaUkUzRFlWR0MrNjh4akxIVDFyQUM0L3VPaENq?=
 =?utf-8?B?Mkx2OTkvSFd6M1BpWE1tSVpXUitCNUVFSDRyTjNwaVVjQVZLeit0aEJYR0tN?=
 =?utf-8?B?R1l1OGc4K3NKVW1FZkx2VXN0aEdvb3o3NDRvZEpmSXVHWWNSb1VWQUtGcm1P?=
 =?utf-8?B?TUtGQjk4cTB4MytwVktobjRJclpmOVI4aW8ydEZRWVhBNEo1ZGpCMGJOMFU0?=
 =?utf-8?B?ZGJHeXg1aTNEaGdBQjMyREFWaHorRE9sVWNxUVdma2JWYjd5VXZ2U2ZBdnJ1?=
 =?utf-8?B?QjBHRTFqTkU0czIzckd4UWxjUWI3VWREQ3pXb3lBOW9wcS95VlN6L3BFeHU2?=
 =?utf-8?B?a3BVbTNGb0ROTzdKMG8xZ0NTL1Rlcm13dlBHY3ZYOGxnRnlvc0gzOHhOcWh5?=
 =?utf-8?B?MGRZYzBKN1NTVEpOVUo0TktBRU1IeGJDZS9vTlNrUkhLdFlhaWdBYVhXYjZC?=
 =?utf-8?B?S2t5RjlDMkUxb21MODczenptN1IxNzJTdzZNcE5ib0tqQXFVSU0zMDJ2a3dL?=
 =?utf-8?B?UU04NDVIamJTMzVYY01LVFdxbGZjOUxVZ3F4Y2plODg5L2dpVFFWL01mME4z?=
 =?utf-8?B?UkNHWXdEMlRnVGtTdUIxUnhjK3VIeEhPRy9xcW1jK28rVGJQWlh6d2RqOVNP?=
 =?utf-8?B?ZDJxUVNFOWZXb1JMS01NMllwUTE5R3ZxR3o2NjlqNGNuWDdrRW5WUG1BL2J2?=
 =?utf-8?B?Skx2QkQwRWZTb3RTNEt0WFRrQmRMNTRsdDlMbHlwTXRMeUVhSmxmMVcxY2Rp?=
 =?utf-8?B?cm9WQXcyUGxiaVVOSnlsZXN3SUgvWjEreWpVSUpKRUc1NG44NnJzejRUTVRF?=
 =?utf-8?B?VUFhUk9CVmk1MC9UTGgxa0JWMVZUQ1FEck5nQ09lZ0o5UEo2V1YzYXNaYTZH?=
 =?utf-8?B?MERmMVlEbGlRdUwrV0lWUWV0WFVxWGFnUlZvTGNYcUVKUTFGMHlKS3JBdzhs?=
 =?utf-8?B?NWJpdWZKYjhqL3R1SjlNMWh5UjhzUlhjRXNCVFF2ZUtGcUNJTFFWNkJvRXRR?=
 =?utf-8?B?VWMzaGJ1YnlSZ3dTVDc4VkdmcUc2TXk5YStFdEtjNDJldWkyU3hRMGl6czhp?=
 =?utf-8?B?c1BoSjRqTU93bWxmNDNqWlcrTXhnVlNra29MUkVXa1BNSFJuMWdhS3JaRGJP?=
 =?utf-8?B?aW92ak5LZEFvRFQ4OFo5SlBHb2FrVEw5TUFNZjZBREVMcUNCUEtsYzdEZG9M?=
 =?utf-8?B?ZWEvUVpGVHBGbWxtckZmNW9MUU5RS09ETEdzUkRSWFJ1TjI3VSs2M0RDNUdL?=
 =?utf-8?B?RzZibVRlU3lHQzBGUnJSR0d4R2FpUWJONHlCQVlOdkxnZkJ1VjB3YjQ3eFo5?=
 =?utf-8?Q?25o/5kku3NQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmhsOHE3OWxGVW1pSS9SWURaSDNlRXBQbnlUdUxZaG9lNjhMNkRIMW1wRkZ3?=
 =?utf-8?B?T0xtQU00TlJxc0MrVXFhMHhTak12RjlXaDN0amdaMUVNWDdLS0JQM0JzRTh3?=
 =?utf-8?B?TnJXZUJSSTE5UVJaa2NRNlFiS1JIa0laVjc1cFRkSXlqTDhlL0NDTVBvYkhj?=
 =?utf-8?B?TTFaaUVCdlVKZGxoN2JzMjNENkhjVFZWWGtwLy9ZUE5jbjAxenpLbisrN0E3?=
 =?utf-8?B?V2NmcGxXUVIvRnRYc1psbGZjaEl1SGVDTkFtblFtc1MrMG5hM1RKdzZqMGJu?=
 =?utf-8?B?SVlOL3R6VVJQK1lFRWxXN0hMRTkwZjJnZFJVbTMvK0dkVDgwa0dibWZXT0lV?=
 =?utf-8?B?UUp1SmdNeGZtMENZRVFnSlExblg1M0J4dk1zSzAwTEFDZmJBeXNUd2djdWNK?=
 =?utf-8?B?azJiazh5cFh6Q0ExT3pJeENSeFhJWkhZTHNKZzJSam5ZYjFVdS9ObGZaQzNW?=
 =?utf-8?B?cXJtck9XY0NucDhzR3o4Z0F2cU9QdjZnaGpBUkE3dlRnMUJvSDEreml2RUp3?=
 =?utf-8?B?TWREUlVuaVBkeGJTYjV6ZmJzQno0RDcyUFBYdzJnUUdNNGdOeUJHNkFxdDBG?=
 =?utf-8?B?RjRYU3Rtc2ZNcnc0djFzRTVld2xhTHErQldvaENON3h0U25QYVphdHI5VVM1?=
 =?utf-8?B?byticTFoVTF2QUdWSVM4cVZ2bnJyNHp2Y29zRWZTODV2VU5QQzRhWUJLcllR?=
 =?utf-8?B?TnFLU1RiR0lITUticFd3YUNaMUNkRm5nK09Kc1BLVmNqd3JaVUFCVnBwR0tw?=
 =?utf-8?B?ZStDczVNM2lSd0pZVDFSZmFycGlSR0ViQnRJdXYxYVRoRk5rUC9BRk0xOXVj?=
 =?utf-8?B?UXBPVE5oWUJxTmVETmhOZUNwTTNJTHVPNmtIb3B2b0pNcEhvT0Q2OGJQSG13?=
 =?utf-8?B?L3NublNSVkFObDNQeURJbllzQkg5cSsvRlUwWnppTnltTEJEbTR1VlpGNXlv?=
 =?utf-8?B?M2ExQ2VlRUJqaThYRWpVcmhWcXdNOGZmM21pV0QvK1RzeVdRai8wdUJDWGFK?=
 =?utf-8?B?a0dIMEoza1pFTlhEdENEeDRWQXJXZXUwV2NoZ2ovNlJGbU5mY0Y3cmV6QlVI?=
 =?utf-8?B?YkJ4TWlqU0trTk5laTRLTk9jVTlJaitrWnR1RDRNemNsRVY4a2l1YWFCQW1I?=
 =?utf-8?B?dC9nb1FxclRUalpmS1RhVkJWYU9RZHFXMTEvdGtaSHJUOU1ML0JSNHF1Z1Ew?=
 =?utf-8?B?SWxDVk9EREZobGd4VnE1WEREU3V6a2hzdUdPN1Z4aUZVMWJhQUpVdytEbGpF?=
 =?utf-8?B?L3d6TlRIbmpMSkI5YUtFdk4rQVBPTjQwTXZDVjJHd1RpYmFKNm5DaFkxSWwz?=
 =?utf-8?B?SEJyRUw5NnVxV2JWVmsybFRvVEphbFhUYjRXYjJjVkQwekFoVWpONjJhODMz?=
 =?utf-8?B?V3RUV05kTXhXYnorWDEwV1FsN1k4V2ZzNEZUVC9ucUpPYWg4UzgyWnQzdUMz?=
 =?utf-8?B?dGJjK2tpeGg3bDFKNGxsb0JBNFllakkwTjJ0WEEra0VTSGFTNlF1ZXBQMDdE?=
 =?utf-8?B?WWF1cVBhcXh0RnUrUEtudFNJbVZKZklMMHRydW4vNDE1ZjNtY2ZqSmtMRWt5?=
 =?utf-8?B?OEh4SWNCR3QzVDNoMUg0bHlGMlFXL2w0UE00RWhWT0VyMzhaUDExcm1sQ2NY?=
 =?utf-8?B?UWVtRThGLytGcnhyZjd6N3d4UVAweWlpK1VYQkNwbTRkaEJaV0VtZEJaY3lh?=
 =?utf-8?B?NUwycWMyMXkvc2hVK3VobW1VOUx0eS83WVl5cERJdHh6bjQrMyswRCthZzY4?=
 =?utf-8?B?MVdzandmTWFGa0ZsZXdUV1BiMnE5MTZUWlRXQXoxQmhPSVphSWU4MDRsTkFY?=
 =?utf-8?B?RFNZdGFReHk0U1ZjMWdheFdSVldZVTliV1hPb0Z1NDJ3dzdPaElDTmdHOWJL?=
 =?utf-8?B?Y29VV0pnT1JoQmlYaWtKTmluV3lEY25vQzNMZmhHdnlnSEEvWDNNVzZSbjhs?=
 =?utf-8?B?MVh0a2tXbjZaNDRKQjk4aHBSVjRxbzVaOTg3d0N0MDFIanQxejFMMjZtbTVo?=
 =?utf-8?B?eG94eldHc2VZekpzQ0lEM0lCMGhqR0ZSWXlwemdzUnBXZWJNcnowSnIyNTE1?=
 =?utf-8?B?anN4YVZuenlUUHF2R3ZER2d0Mk9xNFY4dWUzenVOUnlueSt0UjhtMDFrV3l0?=
 =?utf-8?Q?HLm7oWh6RA7v+6GN2IOCnJ8mE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7441891c-8911-44b1-c1ab-08ddcf7524d2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:26:59.6011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Afff9nXv0sH1FmhwvIpXZ06P82vgHgvft8QUj0RxFGThX7RLvVS68D91+YdQ7zrSX76gUQAEOBuguI0m3w5a+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
Received-SPF: permerror client-ip=40.107.236.65;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:54:07AM +0200, Luc Michel wrote:
> The Versal SoC contains two GICs: one GICv3 in the APU and one GICv2 in
> the RPU (currently not instantiated). To prepare for the GICv2
> instantiation, add support for multiple GICs when connecting interrupts.
> 
> When a GIC is created, the first-cpu-index property is set on it, and a
> pointer to the GIC is stored in the intc array. When connecting an IRQ,
> a TYPE_SPLIT_IRQ device is created with its num-lines property set to
> the number of GICs in the SoC. The split device is used to fan out the
> IRQ to all the GICs.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  1 +
>  hw/arm/xlnx-versal.c         | 55 +++++++++++++++++++++++++++++++++---
>  2 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index ba5719d80f5..9b11ffb845d 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -40,10 +40,11 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>  struct Versal {
>      /*< private >*/
>      SysBusDevice parent_obj;
>  
>      /*< public >*/
> +    GArray *intc;
>      MemoryRegion mr_ps;
>  
>      struct {
>          /* 4 ranges to access DDR.  */
>          MemoryRegion mr_ddr_ranges[4];
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ba8c69bd435..58cd874f81f 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -43,10 +43,11 @@
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "hw/or-irq.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "hw/intc/arm_gicv3_its_common.h"
> +#include "hw/core/split-irq.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -318,10 +319,47 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
>      g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
>  
>      return versal_get_child(s, n);
>  }
>  
> +/*
> + * The SoC embeds multiple GICs. They all receives the same IRQ lines at the
> + * same index. This function creates a TYPE_SPLIT_IRQ device to fan out the
> + * given IRQ input to all the GICs.
> + *
> + * The TYPE_SPLIT_IRQ devices lie in the /soc/irq-splits QOM container
> + */
> +static qemu_irq versal_get_gic_irq(Versal *s, int irq_idx)
> +{
> +    DeviceState *split;
> +    Object *container = versal_get_child(s, "irq-splits");
> +    int idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> +    g_autofree char *name = g_strdup_printf("irq[%d]", idx);
> +
> +    split = DEVICE(object_resolve_path_at(container, name));
> +
> +    if (split == NULL) {
> +        size_t i;
> +
> +        split = qdev_new(TYPE_SPLIT_IRQ);
> +        qdev_prop_set_uint16(split, "num-lines", s->intc->len);
> +        object_property_add_child(container, name, OBJECT(split));
> +        qdev_realize_and_unref(split, NULL, &error_abort);
> +
> +        for (i = 0; i < s->intc->len; i++) {
> +            DeviceState *gic;
> +
> +            gic = g_array_index(s->intc, DeviceState *, i);
> +            qdev_connect_gpio_out(split, i, qdev_get_gpio_in(gic, idx));
> +        }
> +    } else {
> +        g_assert(FIELD_EX32(irq_idx, VERSAL_IRQ, ORED));
> +    }
> +
> +    return qdev_get_gpio_in(split, 0);
> +}
> +
>  /*
>   * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
>   * used to return the corresponding or gate input IRQ. The or gate is created if
>   * not already existant.
>   *
> @@ -354,16 +392,14 @@ static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
>  
>  static qemu_irq versal_get_irq(Versal *s, int irq_idx)
>  {
>      qemu_irq irq;
>      bool ored;
> -    DeviceState *gic;
>  
>      ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
>  
> -    gic = DEVICE(versal_get_child_idx(s, "apu-gic", 0));
> -    irq = qdev_get_gpio_in(gic, irq_idx);
> +    irq = versal_get_gic_irq(s, irq_idx);
>  
>      if (ored) {
>          irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
>      }
>  
> @@ -502,10 +538,11 @@ static void versal_create_gic_its(Versal *s,
>  }
>  
>  static DeviceState *versal_create_gic(Versal *s,
>                                        const VersalCpuClusterMap *map,
>                                        MemoryRegion *mr,
> +                                      int first_cpu_idx,
>                                        size_t num_cpu)
>  {
>      DeviceState *dev;
>      SysBusDevice *sbd;
>      QList *redist_region_count;
> @@ -526,10 +563,11 @@ static DeviceState *versal_create_gic(Versal *s,
>      qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
>  
>      qdev_prop_set_bit(dev, "has-security-extensions", true);
>      qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
>      object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
> +    qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
>  
>      sysbus_realize_and_unref(sbd, &error_fatal);
>  
>      memory_region_add_subregion(mr, map->gic.dist,
>                                  sysbus_mmio_get_region(sbd, 0));
> @@ -552,10 +590,12 @@ static DeviceState *versal_create_gic(Versal *s,
>          qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
>      }
>  
>      versal_create_gic_its(s, map, dev, mr, node);
>  
> +    g_array_append_val(s->intc, dev);
> +
>      return dev;
>  }
>  
>  static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
>                                 DeviceState *gic, DeviceState *cpu, size_t idx,
> @@ -609,13 +649,15 @@ static inline void versal_create_and_connect_gic(Versal *s,
>                                                   MemoryRegion *mr,
>                                                   DeviceState **cpus,
>                                                   size_t num_cpu)
>  {
>      DeviceState *gic;
> +    int first_cpu_idx;
>      size_t i;
>  
> -    gic = versal_create_gic(s, map, mr, num_cpu);
> +    first_cpu_idx = CPU(cpus[0])->cpu_index;
> +    gic = versal_create_gic(s, map, mr, first_cpu_idx, num_cpu);
>  
>      for (i = 0; i < num_cpu; i++) {
>          connect_gic_to_cpu(map, gic, cpus[i], i, num_cpu);
>      }
>  }
> @@ -1540,10 +1582,14 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
>      s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>      s->phandle.gic = qemu_fdt_alloc_phandle(s->cfg.fdt);
>  
> +    container = object_new(TYPE_CONTAINER);
> +    object_property_add_child(OBJECT(s), "irq-splits", container);
> +    object_unref(container);
> +
>      container = object_new(TYPE_CONTAINER);
>      object_property_add_child(OBJECT(s), "irq-or-gates", container);
>      object_unref(container);
>  
>      qemu_fdt_setprop_cell(s->cfg.fdt, "/", "interrupt-parent", s->phandle.gic);
> @@ -1710,10 +1756,11 @@ static void versal_base_init(Object *obj)
>  
>      memory_region_init(&s->lpd.rpu.mr, obj, "mr-rpu", UINT64_MAX);
>      memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
>      memory_region_init_alias(&s->lpd.rpu.mr_ps_alias, OBJECT(s),
>                               "mr-rpu-ps-alias", &s->mr_ps, 0, UINT64_MAX);
> +    s->intc = g_array_new(false, false, sizeof(DeviceState *));
>  
>      num_can = versal_get_map(s)->num_canfd;
>      s->cfg.canbus = g_new0(CanBusState *, num_can);
>  
>      for (i = 0; i < num_can; i++) {
> -- 
> 2.50.0
> 

