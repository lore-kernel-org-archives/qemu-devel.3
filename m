Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1806DCC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGd9q-0002mF-UZ; Tue, 13 Oct 2026 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGd9o-0002lU-20
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:07:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGd9j-0001O6-Uv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:07:05 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DDucQI2251564; Tue, 13 Oct 2026 07:06:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kvs7+cDh9W2EZOSaTTc2HHJVcNT2xMce0DwXDOelB
 l4=; b=OMl94Soee692/53Ec/M0h8+114g8RJLZnaNyX5AWj+CmKDAVJzSumc6j+
 ksru6x2Lo3YQLX4ifmpRoRc8fZECoLatrYSEmkOjW3a1JmU5NGHUHjSrazsQoG1a
 xWhle6Y/rf9I+BapGOM+Q7/79ec+deiK90mNaBH6BkiTbLrHtPpe+9SYrAYk3g9R
 BJAwigVJjkqJ85lr2ns//6Vv06VMNKEDHvgyIKTmrZKcZ3wTwm8Ly8uawZS1Q3IM
 JtOxvjIbMV7vjvh256TE1SSkZbWDsUB62BDY+7I6BF4wFV/OivrIgKMau8GKHTl6
 E4+8n7Oi4I5qmWWeKVGWqLCJnWRNA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020083.outbound.protection.outlook.com [52.101.46.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9nym0176-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 07:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT9oU+qc8s9Nul41ky0Itb7ZrTeV9ED6hP5pzAk1H1TDwQkRuo1nQcI5TIEV1CPS1/z6vn+XEkfdPKltCuNX/4/CccbMx2oD1bqc6Gy88ddHoFpJwhEZkPGilG4kJdCglRIkMJdX9sLNXpvFJRpM6MD36eL/CvLBTMgn9A+Diqn+HZzc5j+NvrouNzL6dFr8YqbCCw3PDXSUIqInJpVk76CxjZUw2a27n3hnoJrT9jl5i7sb3aHSLdc96G2cdwisLxf+Zm4PEfzJzmQeeZw01jNFoMrzTBTK4dMXxlwmjvPBrNCE9dSVgGLaPGEPDY+zRFue3sC+rzonO+E0vFKBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvs7+cDh9W2EZOSaTTc2HHJVcNT2xMce0DwXDOelBl4=;
 b=upNxEGIIg2zYaTnfv16b6XNNG9os6x33gKp/c175Wk8o81G7DCsEFglNeKEkcXfZRBkwOg+2cUbLxup8usu43LKbzNOnGtglQAPvvWJtuvaiHgUobqCSvvJz4bSKln0wRG23ECZMDKftiFz/mMi4XadeluLbaqm8InTjq7bBk73FZMl3tMyfQzqDxrev0H6E3mzxsKt86IpZkSUnE/TJlXc9WK7y0ejdueWpYYYuokvAp5urzXt6fO+nftak4Lx2/2Ri5tUcIZWka9dydxaOwY7wNTEPWorrs1ULzGT2jnimPzlBz37EBVZk/pGZFuRIa8hMzdz9TmSSl/RAICNWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvs7+cDh9W2EZOSaTTc2HHJVcNT2xMce0DwXDOelBl4=;
 b=bkfC229SqEYtPCm5L1F4JdNIHLv1+geNva0dgO9mPhGMEMc7O3+zvyfFn9X4oDhmqZItUw7cZT0YuunU9HwjuLm2rnEFYAHu6yAfFDiAUeMXTU1Hz0goZf4gAejPYXFgRpt5ngFI1suDQfVF3E61qOJm9DvnoX6rmd4WkW9zCC3H3gY8gmLXyC2hxwfIGxKniTbmYeojGZu/hXgNxUylyM0IsufgpoBpJVOcVpyAePiVWBkuPWkIkE8FoZxThVUiZxoZOzuP+DCvUE6C5QZhWBMj42QDE7TbXnOTQXVazMW5YtLGXGHQsvkbq19M2RJOjrf6icAc3eLIKJ8arhtcvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8540.namprd02.prod.outlook.com (2603:10b6:303:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 14:06:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 14:06:55 +0000
Message-ID: <2e374fea-f1d1-4df2-9c5a-d4be050e7f6b@nutanix.com>
Date: Tue, 13 Oct 2026 15:06:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] isa-serial: acpi: declare shared IRQs for COM1/3
 and COM2/4
To: Michael Tokarev <mjt@tls.msk.ru>, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
References: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
 <be26d9c4-f209-4ccf-908d-e97e7863332d@tls.msk.ru>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <be26d9c4-f209-4ccf-908d-e97e7863332d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cfa527-a09a-47b3-6c28-08df29333d0c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|18002099003|22082099003|4133799003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: p1YDxyf9D2bSFlV2seIHlsTSMAdQ/Nbz90jFLecONMcMxxchdwbCSRHwCZwYKR+XV95lSooZA8AsQxElZLgod/Eb2NFYii0Ppr2ndxxfMfuJg2E5avpfsvSDhGSO9fm1un0A8RZ6yyvxpYAIFVIHFmp9hE+qwmSaWx2VODKUb1VPUUDcNVRfYUYB+3Frx8bLIwAY5NDAJ2V8qhCJBsRARAdWRX/Rl9/nWAnRIZHU+WtMbf8ZUg9tvvWhjwnbuVJxcyp85WRu5pPlsWxQBsvkwz/5KMecsJrZqomV7NfF6pbV2Ngiuz4OatUKbsbOqVeQxROxymBXyvV9eOcOuWjVl9jagEWGMJ1Ts9n4BqaxPPx4muuBfPBotBlzdl+aj7UKiKf5brVpkJNkpZg4edgFxWcE81eTHa2XPEiDhPgoxBukdooo/b/rQ8MnDHJWiMPb43bsCrkzCpGyi94v3PD1Eerx3joGdaTekSuFNlByiaJfwslz2G7J03UTmolcExhvJEitPJggJcPoU9q1xl+cw6LWoq1nj+d/ReV/ORSOcc5FH3JhEYAl4OyrS2+MxChJi1f7wn3QMRGJ+T2GVHkv6mAz6nwrk63M95oCJk8ZBov6O5AonsGR+IBFM2j4rTBD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(4133799003)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2pzd2pSOStJMmZPUm1nSXZCQm15U2ZvN3ZXN0dBRnNHRXpDZGRML2xNWW5W?=
 =?utf-8?B?UzZqSjZNSXY0S3lTWkh4VE5uL2VEMHdua045dUVtdGFxOXNEN2R0SzBKemlj?=
 =?utf-8?B?Z2VrRThBNzRabThiUDRKMVVvSDVObnBxZHl0bWxNY1FVSXVKUXFoYndZRWpM?=
 =?utf-8?B?RXNNRW5tcS8yVlR0NW15ZE5TMnZVeTZyK0lkQk1jcDQ3Y2tueVRkK0ZZTVpp?=
 =?utf-8?B?OXIrckxVeUloQkovUWVyU21ibmtReDJvaVNXNFR4Tk1Dbll3UDU1eGhiVHY3?=
 =?utf-8?B?emd2REVmRmtRQ0kwRFJKekFiaDZyd3BhMXJ2djZGRFNmLzBxbVgycWM1V1cz?=
 =?utf-8?B?WGJvTk4xQ29XU1JseHp1TFlxOHJiSzF1OVBTNUxKeVl1TGhqRXQxTEY0dlRU?=
 =?utf-8?B?UFNBWHBlU0NlZGppZlBYdmJ2UzQ0eTk5aG9obGhtckVFVWtkWkZ0ZG13WmlL?=
 =?utf-8?B?bnpLbUJjYmZScUtTTnAzOFgya29VVllnRjVEdFdma0FUS3BidjZJT1B4MXdo?=
 =?utf-8?B?MmZ1Szh4dER2OHFzL3dJeTJsSEVSZS9iOEdZb2J4UjVYc2NVWDhob2hhMUU3?=
 =?utf-8?B?R0VDTnYzRW1kRklJcW42aVlkQ1Q3QmhiTnFBbnI0dWo5bnoxcUE3cW9sQlFS?=
 =?utf-8?B?YW9SaG9xeTFCeS9wVUh0QjljZjBjeUJhc0c3cDJ3U085L1ZmWVNGaDhibW9K?=
 =?utf-8?B?N3F6YW5SMlJxeFlLWDFZTGdmRW5uNFhSaDE3UXdTUVUxZ2dxYWtFTzdqVjhu?=
 =?utf-8?B?Mmw5ajU0YnFHVCtiRUkzL3lDUmxyYndiQ1IrU1hCSmt1MGw4bFZ3bEhrTFNr?=
 =?utf-8?B?S0RQUFo2UGdCK3lnS0xxZ1ZmdjVjSm5nZFY0WVlsTVRqeVpWcjZraHNIdHNr?=
 =?utf-8?B?VnY2QkluZGpNb1F5UXhtSHZMTzlUcFFDeStUNzRBdTBGT1R5dU1hTW56d3BH?=
 =?utf-8?B?SlhxcFJtdjVCNnlDY2d4WGtUbDdFMVFFejk4SVlUQmU4cE5oWUZXUGtrbkJl?=
 =?utf-8?B?U2tDNmE1WXRDQ3pUWTUyZnhPMTc3bDMyTXdobzBMbjFlL1BZd1JXR0VCUU9U?=
 =?utf-8?B?bzVnY2lmcytodGtvVnhDcFhBYjhrN0lKbXEzdy9vVzZtelV2MUxmRHZISXow?=
 =?utf-8?B?WVJ5SjFzK0phaWlsclZCeEVCRzFxd05vRTdNaVVpaHA2MGpTT2JtSy9uSVUv?=
 =?utf-8?B?VEVZdUsxLzFSV2NvdzBVYml5LzlEa09KR2lxWFFkSFlVdEFVRms5d0cvOGpw?=
 =?utf-8?B?QU82cDZtQmtJUklZQjUvRFB2SXFSUEdKeTltNkNIc2VjTTJtbmt1WktGZXls?=
 =?utf-8?B?dXl0dDhQdWd0YlJDaldacjJFaFJYTmg3MnErY3JwdWdIVnd0WThURjJQU0FN?=
 =?utf-8?B?M3Q0YzBweWhleVpGVjA2V0Z2cHVrZGlrKzg1S1lmR3BMK3BEdEJOdFZkTy8z?=
 =?utf-8?B?cGZGdjhGa0ptS3ZFcnJtcVFqSk9VQUYwZFYzdHBIeGQ4Z1p4S3ZFY0VYcTNt?=
 =?utf-8?B?Tm9BZHlxL0pxY3lCMEhWdmJwUjMxdE9vellCWkZLOFVrRXpRTTgzWG5wRC9q?=
 =?utf-8?B?MU5Zb3Q5YjliVkRoZU5wU1E4NThicTZtLzJ4VTg4ZTNXR2FyN1psRW9sTFhZ?=
 =?utf-8?B?b29aUVh5Vk4xZmJjanBjT1FFNWlhM0pDKyt4Wmo3WkluY292eGg5UFpxbmtE?=
 =?utf-8?B?THhBREJXL0dqMllsL0VIdkNpVEsyTFQ3bHFhWDh0czlQMmJRMHNoTjBBNzFU?=
 =?utf-8?B?cG1lVnE3b3QvT3hvSFpyRnc5V3pEbmRHdCsrcWRqaHJpUkhqRkthQk5uSVRV?=
 =?utf-8?B?cVRFK1RTZm40dW1lMkxEdDluQXpSQnZzYjZpa2NFUFNORlhWbzVpSFRCMUx3?=
 =?utf-8?B?bC9PK1Y1bFFlQ21SallJVW5rOGJ6WUp4NGYyWG5oQ1g1TUozS1Fnd1V1L3hI?=
 =?utf-8?B?ZExBcVlVR0diUUpZbTN4Z1YrRW1vQXY0MmRXWjhSbllzY1dpZlhxTmtmU3Jo?=
 =?utf-8?B?dVRrNUQxNlFVN21yOWkwdHBzcUxHa2NscUh6WDU1b0dtWVNVclcvUE1yWTM2?=
 =?utf-8?B?a0hML21JQTgwOU9hSi9POUpkUUt4U3R0TmVXMmcxS1dnZERyd1hzVVkzaWJu?=
 =?utf-8?B?VDYwb0JEaHVjbUpsU1o2UGx2bkpHTXJDSHFXTDlyaEd0VGk4eDF4c0M3RHJJ?=
 =?utf-8?B?Ui9mdDVUSVc0TVZJM2JGa0dNTHNlR1FGQ3ZLb0tvaXkrNUJ4Yjk3bE5GWXRB?=
 =?utf-8?B?UmgveXhOc3BrMzVyUE1vSDZCRGtsc0RIU1orejBhMHptSjBWdUp6d0Q3R29F?=
 =?utf-8?B?L2VpalN3YXI3R096MllGS1BFcTBNWldrM2FGVktYMFdpbk00MkJueWcxZjhs?=
 =?utf-8?Q?jOuVHj43A8tbYuJc=3D?=
X-Exchange-RoutingPolicyChecked: b/g4g9KBwVa35QFBtVnS7pxN81BHcPJhFkUIFcV2UAFjF9hhfFx8Qy1s0wtK6bn9PHOnarsRHY3+hfMq3Q32KhTbEki9LKqezB1ucP5RF4JmAvzkMwTbcoe9QZvdpWyeWMp2fXuaxlpXTmqbDJCWs+qwQzcqKWIIiMBrGQZmWv8rP1An9idpGMKvNHWpX18D9aE26cVNyKStudtpndcSVW56MB5a0e/ZY3j1G6AhPtN5Jr5fy+h/jwsUl81wHbk+fotKXKBc8UlFUVAr5V9BgG0DtdEQnaVmB7awY/w385a0nH0sgxjxoNTr4RyvDdR9/IbHGRwiZqgHuaYRn4GZAw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cfa527-a09a-47b3-6c28-08df29333d0c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:06:55.6160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaYOf1PUYmWTlTzPUlRfHr3WfFIrPwFHTxZP0xUqjj76ioNmYHm9IHHcnTqI4JBQWljfwW+6dtEqRLCxP1LZman5wCHDzK6r0BLYxuLjtf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8540
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX8gm5uoKCp1ui
 O6rPR/OqLEtXaEZcHFwNz4pTe02o5GLMWdz3VvmuYENZkdJRW5HO48l7XFbQLYXwK2Cub1YLxQd
 oWUtvPNFknNU9hRi9w3F4uTnDT8Vc2ewoBvbKu2mDbX/xMX/Xq7Z/WlczVdkAn45nbphmEkUvld
 dBRHhnFthVUQCsYKIavAMQyGUBmFqRbbPbzZ/k3vMERj2vel47ndjlpWiHmxP/E4392dg7puSbC
 wffytQ6qO2xpj6TATKWMCMXGIwyW01amBbwLCEYVxV7GZ9zAmVj5JzmaoygZOJWyyYpGt/9Nd7t
 sZpd7SuY3LTkNP7jnuL2AvVEcUMXICSbqJnos2GVvV2kgmwniFZEeVI0INYF+MCXs3ZbGAAXnqj
 qCq2ZTxn8XevyqCU0v1az5tSeLO5+CVLLH+AOF2UAszWyYA8om2rdfPHJLdsRj3UpEs79Lma1th
 zmjKKrnjqOv/8uhRmCg==
X-Proofpoint-ORIG-GUID: Q9uBDx01PAjIUm-OL2Ho08lraNw9J-26
X-Proofpoint-GUID: Q9uBDx01PAjIUm-OL2Ho08lraNw9J-26
X-Authority-Analysis: v=2.4 cv=OIuyTiaB c=1 sm=1 tr=0 ts=6ace3b02 cx=c_pps
 a=pfgRl+3joWazjPSajX+lRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=RpNjiQI2AAAA:8 a=64Cc0HZtAAAA:8 a=cFMQe_JHzGnR9W5HXQIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX94NgxjmrYEB2
 drNKBhe3EtX0P87p0syc8U1XK0/hhfitc1Po5wka0Fkei4e3wnZPgam5l16/R0me6lLAVcAe5Bs
 /XxN0M09I8q9+cLbvCVElJYpEa27OK8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/10/2026 09:48, Michael Tokarev wrote:

> On 15.05.2026 18:05, Mark Cave-Ayland wrote:
>>> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI 
>>> Revision
>> 3.0 is used in the FACP table. The reason for this is that if a 2-byte 
>> IRQ
>> Descriptor is used then the interrupt is considered to be high true, edge
>> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 
>> share
>> an IRQ then if more than 2 serial ports are added, Windows indicates a
>> conflict in Device Manager and these combinations cannot be used 
>> together.
>>
>> Add a new 3-byte IRQ Descriptor to the _CRS resource indicating that the
>> ISA serial IRQ is low true, level sensitive and shareable. This 
>> enables all 4
>> legacy serial ports to be used in Windows without conflict.
>>
>> Tested on Windows 8.1 and Windows 11 with 4 instances of -serial on 
>> the command
>> line and copying data simultaneously across serial ports COM1/3 and 
>> COM2/4:
>>
>>    ./build/qemu-system-x86_64 \
>>      -accel kvm \
>>      -M q35,hpet=off \
>>      -m 4G \
>>      -cpu host \
>>      -drive file=win81.iso,format=raw,if=ide,bus=2,unit=0,media=cdrom \
>>      -drive file=win81.qcow2,format=qcow2,if=ide,bus=0,unit=0 \
>>      -device VGA \
>>      -serial tcp::4001,server=on,wait=off \
>>      -serial tcp::4002,server=on,wait=off \
>>      -serial tcp::4003,server=on,wait=off \
>>      -serial tcp::4004,server=on,wait=off
>>
>> Note that with this series applied, if extra ISA serial ports are 
>> added to an
>> existing VM then it is necessary to go to Device Manager, select "Add 
>> legacy
>> hardware" from the "Action" menu, and then reboot the VM for the 
>> serial ports
>> to be detected correctly without Device Manager indicating a conflict.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> v4
>> - Rebase onto master
>> - Redefine IRQ as Active-Low-Level-Triggered as otherwise Windows 8.1 
>> will detect the
>>    serial ports but mark them as having a resource conflict. Retested 
>> again on both
>>    Windows 8.1 and Windows 11
>> - Add R-b and A-b tags from Ani and Igor
>>
>> v3
>> - Rebase onto master
>> - Define IRQ as Active-High-Edge-Triggered (as seen by the PIC) to 
>> ensure compliance
>>    with the ACPI specification section 6.4.2.1.
>>
>> v2
>> - Remove _PRS changes (including AML build changes that are no longer 
>> required)
>>    and compatibility property as suggested by Igor
>>
>>
>> Mark Cave-Ayland (4):
>>    hw/acpi/aml-build.c: add aml_irq() representing the 3-byte IRQ
>>      descriptor
>>    tests/acpi: allow DSDT acpi table changes
>>    hw/char/serial-isa.c: declare IRQ as shared in ACPI IRQ descriptor
>>    tests: data: update x86 ACPI tables
> 
> It looks like this patchset broke earlier windows versions (vista and
> XP), -- especially the "declare IRQ as shared" commit.  Please see
> https://urldefense.proofpoint.com/v2/url? 
> u=https-3A__bugs.debian.org_1149858&d=DwICaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=9JId5t-AQ92toG7oKB6GqyPc1HhqN4AuPzUR1XJWOUjpYtI-SxCeTVVq6ohHAfhn&s=q6ueWpEp-vyNvdpIjw8HSnLT3H3Zd-nOcrLL8Dga4nk&e=  for details with bisection.
> 
> We're investigating still.
Thanks for the heads-up. I've had a play with a WinXP SP2 32-bit image I 
happen to have lying around installed on the pc machine, and everything 
works fine as far as I can tell.

Is it possible to determine whether this is tied to use of the q35 
machine and/or service pack level? If so, I'll need to try and dig out 
my original copy of WinXP to do some more testing.


ATB,

Mark.


