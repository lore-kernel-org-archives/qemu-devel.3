Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ABCC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 16:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4jFz-0007JS-FX; Tue, 15 Apr 2025 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbates@raithlin.com>)
 id 1u4jFl-0007HF-PY
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:35:21 -0400
Received: from mail-canadaeastazon11020087.outbound.protection.outlook.com
 ([52.101.191.87] helo=YQZPR01CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbates@raithlin.com>)
 id 1u4jFk-00083b-4Y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 12:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUpwxnnZnxRxOMiC38pi4IXtVyzGqiGg9wt/17UoNP7bXDSqZzYddQUbf9vu8teQ1u8Vyq2lzglkNT+u54rTWgx/tYTxbv9ov913zBepC6527SbA1bCZnBsTSGXOdPJMZD/jWmWQg/fkybkocvXRJ9U3wCsPVnibRFtJb1CMfmdprdIzJNenIwCOI4BhjkaqrgL2880C0MuZoswgcYDvLQpZNvbbZ2tg8MRt+OqV4pwIcvCDmxnR3veX1vj/OV+OuOfeGMtSAUDmOUG0vdc3+NTKjBavTcA0dVV5qJWsaQk4ZETMRvjSE3zjUvkgKe/QjdLSJXoaT0VreH5Tdk0F4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evPcCQHRGYQK4Keg3AF36uFbvO83tIKos/Mhf23SQsA=;
 b=HS0fZtYe7rAkzy6VR/akP9fPUYR9TI41SM/hGS1kF8zhOYcyHKUPHQhrKrSov0jHNdCRXWQ5EErVS74+/bwPdFHOluQni8g3V4T+ZE5Sw/ynLfgnUj5rXOE88kz6GOAmd/48wOxCsEB/ys6dRlx8cAD4ZcWIoR5VPibH+VVs0QGNXQnT1sJpVyz1zBNa7HblRC9Zj5nbzO7AtuiQ4CyDdJZXrLYwRpzyLXU2ll/FKECEGWR3+1e2FJXTN03wuQukmuZPoj6qViNVnpHsM1n6muAioJZBYqfzasgFFEMLgivUA25nGY7xna7Au3dYerLUlI23ioj/HngWcV41renmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evPcCQHRGYQK4Keg3AF36uFbvO83tIKos/Mhf23SQsA=;
 b=o1FkFQZQE9gshfxGe1kTquHS0jxCsCgv61I+UVAdYtN3CQCAeCKasPEpG3dRtMPOfBs1uca5GZMkso99OE7G0YeuSNtGGStogGo1ZD8wRC99Ras1+zqce/5Wr8IAYnVeVsjfk/RsHdPKkg2VW05Nv/LBswk7qg7z1KUGGpTlBXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YT1PR01MB8891.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 16:30:01 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2671:57c7:e28d:98cd]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2671:57c7:e28d:98cd%8]) with mapi id 15.20.8655.021; Tue, 15 Apr 2025
 16:30:01 +0000
Date: Tue, 15 Apr 2025 10:29:56 -0600
From: Stephen Bates <sbates@raithlin.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: sbates@raithlin.com
Subject: [PATCH] pci-testdev.c: Add membar-backed option for backing membar
Message-ID: <Z_6JhDtn5PlaDgB_@MKMSTEBATES01.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: PH0PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:510:f::34) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YT1PR01MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e634f0-e6c0-4d51-57fe-08dd7c3ac51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFpFR2VVTUVoY21aWWM4Umd1Nkl2dFhLTnlGbjlkdU5vQmd1UVRJbm4yS25J?=
 =?utf-8?B?V2I3SjFleUZkS0pWb1V2cW5DalRoOTM2V2EyaWlwb1Z2bHpiWSt2NnVUTXpK?=
 =?utf-8?B?Q3JZekVOZ0lVQlo3WXIzZElKd2NpakxxVml5YnE4UXFoaU13ZEEwMWVzM3Fr?=
 =?utf-8?B?YnBNUjlyOXJSbkhObWd0bGk3a1gzQzdSY25jYXVmMUpZWEU5eEpGT3VHTHE5?=
 =?utf-8?B?TmdaNW5wbnFhdSs1dG4xUnBZaDVadVQ1aXp3VnFZaFJkT2pkdGpWL0ZWeFBD?=
 =?utf-8?B?Q3Z3S3djR3NUdk4wZkZSMG96Slo5N28rYzZaMHcrczRtZFdZaFRUdEZ0Yy9J?=
 =?utf-8?B?ckxQRkNKVEJJOXlVZDZGZmVjYjhSUnFEYWtaQndQdW9sYUZ6T21UcFhSZzBz?=
 =?utf-8?B?QWhzYjhkMkJKczhMbFliOFZXWlEzN20vRFVQejRpZkhqajRRNkozOC8rQnM1?=
 =?utf-8?B?d05pOFgrYVBPK2FRc0x4TS9ieCtyOHB3cEJLaFB1YlQ5TStQSDhyVFZ4ZE4x?=
 =?utf-8?B?aUZPakJsYnhrSTlDcVNiR1J5ZU5EZVZpZ242ZC9UTUpPd1NOeEZlTzNBZ3Rw?=
 =?utf-8?B?RHBoclprRlBIYTFqUkZTWmNudjAxeFlMNUFTV3ZQUVRqclVFWUFyMjlPT3Vx?=
 =?utf-8?B?Mm56Z2JkaTZCajBkRGVWeDRMeE42VFdTRHZsdEZpRG53V2RWSWNMSTNqN1NP?=
 =?utf-8?B?TTB4d0JOdi85WklUSm9kZ0htMGE2R2N3Z3JRdHplc1R5MnBaYmZEdmlVT3pJ?=
 =?utf-8?B?S29TNndHcW5MdlhudFZPQXVQSDRiVXFhWEQ2ZSt5eXpuQXg4S2l0eHNoNkZ5?=
 =?utf-8?B?ZTdqT1ByamZRamROcTZtcDRObmE4blZRMTFYb0ZUYUxKQVliMDNickZkZ0Rv?=
 =?utf-8?B?cmxNYWNqZUFlU2VkVWpZSUhqUEpkWExXRWxZOHBZSU0yVFNUMkhOaFk5V3dK?=
 =?utf-8?B?eDJXMnBMcStRQTJKaWsvN25CZzBQV2dYTlVLNGJuV1BaWDNxU3VZWEJmVEY2?=
 =?utf-8?B?M1NZbS8xdDNrMXo5V0owK0tydU44bjR0aXQ1UUNpUVdhM04yblNMYU1qdFpj?=
 =?utf-8?B?cTJUUTRzcEV3SGxnQmh0cStWcFlYblYrZXp1WE5XM216L0tLZlpEQ0dnZmVN?=
 =?utf-8?B?QWpNZkpCVS9xbkZNaG5oZG5yTlp6VjR6M09BV1NLcmVIUnRKNzJmMzdGZzJx?=
 =?utf-8?B?Nlh0b2xjSVlkZmZtM0dWL2NKQ1BNTnZZeHlzWSs1NWtiTEF0Vjl6NnVQRXkw?=
 =?utf-8?B?bjEyOERKSGtyb1B6WWNNaHU4dEpBOG4yWkVST0trd2tJOHRXdlBsRldRM2pL?=
 =?utf-8?B?Z0s1OVljbnN6K0E0bXRndjlvNGhkMFZYYnpRSnltNWo0VEJ3ZjE0Y0lwK1Bq?=
 =?utf-8?B?QlQ2REc4clJTc1Y0c0FNWUtZZ0hIc1FHZWVkdkJRbWd0bkxDMjcvZXU0cGpK?=
 =?utf-8?B?R1dWbVUvbTVhNzdrTnlULzV5RUFjTnMzMmNiK3JmWWdBTVRNRllJa2lIUXFK?=
 =?utf-8?B?bUhJam5nR1gvNzQzNHpYN2JXWFc5OWNTZ1lhblZ0UE95WXFRTEJMek1DU28y?=
 =?utf-8?B?aW45U1BNRlR4M1YwRzlyUHdKb0VTQUdIcFY1Mk0wUE1QRVNkbytVcjhDd2py?=
 =?utf-8?B?NTVVa05vNTRhbHJ1S3dUU1k3eUZTWmNZazlORkh2Qk1SbmFvZ3N2d01nUk9l?=
 =?utf-8?B?R0NENXg2UGIrc2J5Z1ExSkE3NDQ0S1pHODBEZDVJcjRXNnNNVTU1dGRncFJK?=
 =?utf-8?B?aDZnNWRjdmFrNk1Bc1dEZWZtaUQyQTRZR21CdWZzNUx6THdVYzA5WWdCUHJW?=
 =?utf-8?B?RGtPZ2xPbWd0cUpvTEZWLzZveFV6R0pwcDFUank0OVdqUklVZ1hGRStRdUg4?=
 =?utf-8?B?ZjlMaGFyU1FjYjVoZzgvdGtiRWVPT3Z6cWRuN1R2Zk4xbmkxdnFjbmpNVXlU?=
 =?utf-8?Q?c2yAOcr+ilI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFY0OEw4VVVMa1NDVUxNYXozczVueGN4cDQzWjg5ZzdFNFZIQmFLYXFpa1FM?=
 =?utf-8?B?R1VzSlh3dEFZR3lxK1lQRzJ2QWJZdjZ6OVZCak42K3JBSTlBSkoyNE9GSUt5?=
 =?utf-8?B?dFBNNXJBdjhOMjkvUERhcit5R2p5Y1QvNnN4RlcrWUcwblRSUURXYWtaZ3Zk?=
 =?utf-8?B?L1NKTEQ5SXJtczNtSFRManZuTkNIT0Fxdmp1VFd5c0Z1NHkyZHN3MDRZdHUr?=
 =?utf-8?B?MDFLU2JxZHNqeFRXT3FZTXhHMlI4RmtCMzVGQkNyTXQ2a3V2Rk1XK3dyeHZl?=
 =?utf-8?B?dlZpelpMeStMc0NPbVVpYXRoSWVZSzhIOFN1TEZISE9RTjlTR3diMlZKOTRr?=
 =?utf-8?B?cHg1UzJJTVNLL0hwbllWRHBLdXlNNkt4T0JGUDRWOUNxYXV1NmYxdDNqd1JL?=
 =?utf-8?B?U0Q0eWwvQWFsNnF3RWptS3QvYnBNcFBEZjQ0N1RSM0xWMmJiNXE2Z2F0T2h1?=
 =?utf-8?B?dkM2ajYvZE1DZ1dtNjZjUFdhWXF0dlMyaXp0OHcxVlpJOTNUZmVNTFVMcWw3?=
 =?utf-8?B?R1VHRTFBb0t3YWIrVm1PYWJ4U085dVF2REFkcGlHcU1jbjJBUEs0bFBoQlZv?=
 =?utf-8?B?NGcxWjYvR3lGNG9JNTZ3NXVqYXFPMzVGREtUcmRIcVVReDlXdUplWElZUWZ1?=
 =?utf-8?B?WEk0a2RxbWNyR2hCcTN5bGFpRDZ5VXB0N3VMQVhCenZ1QXlBbmRYVVh1Y0l2?=
 =?utf-8?B?dzFDRG5pbVpUaEpmcW4vTVVBZ0JrcDdJSUdab2Uwamx2TittV0F3SGFtaGdn?=
 =?utf-8?B?NjBoZVpnUStkU3MxMlpyMUN1WEdtVVpEc1BvTFF3V1g5czJ0eHhlN0tSZTRi?=
 =?utf-8?B?YVVRWi9GZlVtTTR3SWJxT0I3akphdy9RWGxNT3NFTElDLzExK3JzNHVyd2RE?=
 =?utf-8?B?NzJPY3k1eU01V3NuMjlzMyticlVtditSTEY5ejdseCtOS0xJWE1ybjlWdXBX?=
 =?utf-8?B?Q0RWb2VCL3ZvelN2MXpvMmJINkszRXA1blh4citWWEJlNjluQ0VTYjJuQmQ4?=
 =?utf-8?B?V2E3ZXM3Z21SRDNWMlE4Njd0ZWlpUjZCZmtybGloYWE3Nzg4eWlZaG9mM0d1?=
 =?utf-8?B?bitNdWxNV3cyUE83MENjeDNSRkQwamNMMUVVd1BoRUdCbmROSC8xMVYrTllE?=
 =?utf-8?B?T3YxZG1hUHNXbWF1bWFaaHJUZEpzd0RZVExZRzVrTHJSTDVrcHlTKzR3blQy?=
 =?utf-8?B?aTNBdFlDbFQ3TWlFaHVWbWE3LzJYTWcwU2lqZ0N4dmgzeld5dXk5Tmo1b2tI?=
 =?utf-8?B?SlBtUnlhN21aajJYVEw1Rk9FWUw0bzNpWFVtTlZxQlQrZTcyNk9sWEpXR1F5?=
 =?utf-8?B?SkZka0ltdmtLSG0xZTQ4eExrd0s5cGE1Ymt3OUMyNk9hR1Y1NzdJRDd1Vzk1?=
 =?utf-8?B?Y1hDQUxzMS9CWndIemozNzBkRTNTK2RsWEVTV284WVl1b3lsNlRYdGd6Y2Zu?=
 =?utf-8?B?Qm5uejFWNDBZWEJSalVVcElBZFZSLzhCbnZINlVXbklpVno4KzNVMWVzcFFz?=
 =?utf-8?B?NFVab2lBR0tZWThnQVB0dERUbnNDdHBqaXJXSjNyVFNmRUozYzBGN2l1dzdh?=
 =?utf-8?B?eUc2VGZCTjg1c3Z5bzhhdW1YeFk1c09KZXdsWkNzTkVqQmpQSXZKZ0dNdDJi?=
 =?utf-8?B?aWVJcmxGaHR4QVEyQS9yVll6blZoQy85V0xubGFKb1pmNjU3THJ1QlJObnBj?=
 =?utf-8?B?Q3ZhNG9aOVZrb2VRNzBzZTl1dTRwQjdEVzMvRXNZcmZqMGNHNm9tNGZseExN?=
 =?utf-8?B?a0JlOEI1T3JsZkZ4N3RlZzJtYjRNTHVjTmVvTnM2dXVoVG5HbzNkUlJFQ29u?=
 =?utf-8?B?ZjhMQlIwN1UvTUpnT3VnRnFZMm9laUNmZ3Qxa3k0UUNuUlJDaDVJWWswZmpv?=
 =?utf-8?B?Y0FKYlhTYUVFRHpyTGYzUzZBR0lHd1VLV0Vic1BObFVOaXVlNEpBeFBmUFpx?=
 =?utf-8?B?YkR3eThiUmpwbkZpS1djK2g1ZEozZVE5ZmVDb2hTRCtPdjM1dmdXclNoc1Fs?=
 =?utf-8?B?OVdCTXJhb2lOdFB4TE93c2tNbW9DMUFrVWs3dm1CSjBqVnl4VnU4Y0szcit0?=
 =?utf-8?B?Y1RCdEdJK0Vxbm1MTm5oMXFlWGxidlJaajlyUjkrL2JxN1JZSGdmZnR6elpq?=
 =?utf-8?Q?n0ACNm9cwdzbZKsf8gPR+PmH/?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e634f0-e6c0-4d51-57fe-08dd7c3ac51e
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 16:30:01.5479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BQr/7yEQvJxWUAevjHh8jXz9nZ4P/swYcDfgTebG7a/2KS9ZIBLV/RaGg/dC0bm5/LBN0Zu2d//47JOe3FpiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8891
Received-SPF: pass client-ip=52.101.191.87; envelope-from=sbates@raithlin.com;
 helo=YQZPR01CU011.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The pci-testdev device allows for an optional BAR. We have
historically used this without backing to test that systems and OSes
can accomodate large PCI BARs. However to help test p2pdma operations
it is helpful to add an option to back this BAR with host memory.

We add a membar-backed boolean parameter and when set to true or on we
do a host RAM backing. The default is false which ensures backward
compatability.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 hw/misc/pci-testdev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index f6718a7c37..da9126a8a7 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -90,6 +90,7 @@ struct PCITestDevState {
     int current;
 
     uint64_t membar_size;
+    bool membar_backed;
     MemoryRegion membar;
 };
 
@@ -258,8 +259,14 @@ static void pci_testdev_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &d->portio);
 
     if (d->membar_size) {
-        memory_region_init(&d->membar, OBJECT(d), "pci-testdev-membar",
-                           d->membar_size);
+        if (d->membar_backed)
+            memory_region_init_ram(&d->membar, OBJECT(d),
+                                   "pci-testdev-membar-backed",
+                                   d->membar_size, NULL);
+        else
+            memory_region_init(&d->membar, OBJECT(d),
+                               "pci-testdev-membar",
+                               d->membar_size);
         pci_register_bar(pci_dev, 2,
                          PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_PREFETCH |
@@ -321,6 +328,8 @@ static void qdev_pci_testdev_reset(DeviceState *dev)
 
 static const Property pci_testdev_properties[] = {
     DEFINE_PROP_SIZE("membar", PCITestDevState, membar_size, 0),
+    DEFINE_PROP_BOOL("membar-backed", PCITestDevState, membar_backed, false),
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void pci_testdev_class_init(ObjectClass *klass, void *data)
-- 
2.43.0


-- 

Cheers

Stephen Bates, PhD.

