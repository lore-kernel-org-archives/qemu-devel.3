Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BA8CC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGv6I-00005r-4W; Wed, 14 Oct 2026 05:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGv6C-00005W-AW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:16:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGv6A-0007Cc-7o
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:16:36 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E8ZGbK3450376; Wed, 14 Oct 2026 02:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4A8Oq2na9HotKWpw73aM4Ju6PG6/35YrER0U2aU0X
 co=; b=s7+jVZ76C9jLmeekl52LGDTvJJzG/kcR1X4ErJVdrTN9okFWlREK5N5g/
 NpxW87RiGZ529xMK1h7is13mTHfmx4EytP/YX0dMrrFLEnoxB9BLL60EJhW+GEKS
 4TrWBxf1GCayoc9iAyhQ5IWOup42hZrL2cce4y9B/eLWyx7/MDEzpnFd7nelqUmg
 7aVi7Up3SLASFNVrDzwi4knw8YKbGTkwGe0Onh0XsLuIGDAwsAwhsmXiYpXxG5rk
 s2TrpHHHPm0CAy3xgDu7Z+oZIiSdBWg2vRmU/QcL/5b8ocvn1HJLpJSVZHU5MzKh
 P+7/S30Uq96E4VUsm4KpRT5F8bFdg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020103.outbound.protection.outlook.com [52.101.85.103])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9fy93jwq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 02:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yg48LJ6HadO0zW8RsWRNe6UocDM1fjwTUp7CPMs6AC67GrELMAMz7CRfo9V5bCimUVlDvTUiLsBMLqOSP6TYz0LPOPb6l/nPxUifrXuCtG/sLFHDEDHgLNMMmdi4IpXoafnnGLldXQk7JpwZP8S/wLV2uld2JB+oGkNRFgJzSP4Ds02RrZK8+2qG4HyylCyZsEX/j/fhlj8s5hG2oBkJ+LvMAc2IcHDhvhrLs2QLmpb3dc8XBbDQYa5twI6ZkZZWnEBuJhgIWlZzAG/ve7pdgraWrAudX8aJWnZWOgHJQJRNdmMNguGIm3wRvP4bZv3+abn24vger2hhETLzpo06mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A8Oq2na9HotKWpw73aM4Ju6PG6/35YrER0U2aU0Xco=;
 b=dZ0Lw3T20JSxx87wvcQuiyj1IbAIJ1WUx5/a+KURmN7FYql/CSLm+C21TRAjbwd1hjdafI2YqrXQ0SIH+1GyoKxh67Xsi/PTHN8aCADuOgwrb2yuQam6SrlWx4h7cYo0FB/Rl1W2livJuEODmTY0sIbfIjfX8//0BSp0zqZkdiSzNfGGaRekubGh7eyI35bBPfTY7Z7JCyXSWnkfvatAJW6tfbiEqMA/ilfnZ/ypLRDyuu4FS0blOgrPydPQvNkVlZfWMsvWivxDER5TIRxl0u0Yze0sDNiBlpspS/bbdjOK/m3XuHQ7S0g+aR1xdkbfYTXmDxtIKjn+4R7LOKFA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A8Oq2na9HotKWpw73aM4Ju6PG6/35YrER0U2aU0Xco=;
 b=Qdj4w/pr5gJ5yjZFtlKJVcWaeAVsD7eN9Cd74vub/Rzq9JnYXKn7Qn8wtwiCI2kN1OVqnaNiDStJNzug8w/bUxBgsPBTNvFzz9M0YK+i6SJZ/pO8RWqGI2ZR5PywyrDmhFSywmJ2AduxOzTjHVCjUdFZvedxNtp5LPIVBEjGUnboiRDTMTypcEzACIZYeb9wewfmTKDxT7KgcQryHsvFgFIzNyqGy3Hx1MiXEBqu4lp6TU2qt9itLYbhY7M+rglaOKA9vzYPq0PYmfsNZM5Hk81+sznLcZr/y6WDK4A7/vy3tSystixSmmv23W8i7uJyQjhxAA55ISiBKlqBfA0b/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW6PR02MB9819.namprd02.prod.outlook.com (2603:10b6:303:242::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 09:16:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:16:21 +0000
Message-ID: <996de2ff-4b91-4866-91ea-5f51818d2352@nutanix.com>
Date: Wed, 14 Oct 2026 10:16:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: deprecate use of instance level properties
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20261013120638.855671-1-berrange@redhat.com>
 <cd31fd3b-5b54-431e-971b-ee9a680a8c40@nutanix.com>
 <as9HQCmHipYncIpq@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <as9HQCmHipYncIpq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW6PR02MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 10632f9e-0751-4e96-1b2f-08df29d3cf8a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: AHSkq7hWVloRYjhQOUXgxCJth6/QnN67YPDFwo1vpxpiOBMLMfm9os6nAPR7nbf3AvTkSlj4O89Gq3Z1wzE1cAxxlE7KEIr4cLWLMC7DvzAnSIq+l/rcoIkN9hWwmnIsg9sIzzwfil3jG/xLnrZx7xjfb5Lmu9/TVIB56l9Kj+axmtNptethnrkiHFhpKhsFhdOGjwp6uLmaoXaegrgA9AAtaprPNP2uWaMjtieLYU56reCIDgY/CG9jNqsdqmbIG5RyvFD/+HM0MilWED9b76nOnni3D7yVN2Q/+nFGLkgECq8795i9ruTRXtI22wnFhwucpZb5s6VydUz7UDo9u6E1y/fDRCEC23Yaiic47Bq46GkulgdIGUEYrYrmv4y3QuIh7JR9RRGwXLkJk2g83HjoR5n3JIyLhELKuu9Y07k6hdLULudvE2OLLR9tHLcFQ1cydcdM/FG/bIGgkemDhLGMm+Dzq41V03fOIS8LwLNakwoNSLcYq1zHAUuVkWOvcRV9bOu4CpTvU56GKbGObJia6q1p4Aq84lM+BElS1tsDnApIRayrDIIXa2loFMQpl4pMjkmrU3u1m933ooU0u8omTuhu+W/hNEcp2UzNrn3LNdzJz1u0pcyuKo5NFOucZXL0wGV5CmPDNqydMKUEWxBJXm4wUblP4DVKACNKAeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckMrS1dKdVQ4RzhSK1RXSlY2MWtyUkhmclduRXBkMGI5aGVnZTVTMGs5aEJh?=
 =?utf-8?B?NXh3QlNTVUcwbC9YS2tmd05sWlNUZVczVWFhcmZwMFREcHRTL1lZRDVBSXps?=
 =?utf-8?B?OE0zY1dVMzlwTzRxalcyQmZlTWprVTJ0RmhwbTlnN0JLUTdjRnNZRko2dWhR?=
 =?utf-8?B?S3Nxa2hWQldybFN1LzU4VWl1RUFDM2Q0ZitNcUNhaXRZdVdrYTZpT3RraVRy?=
 =?utf-8?B?WVpFTlFPTkVjQVJVdG5lWUxBY2xTdy9BcDAwaGNTc1FPSjZEY09YbUhocWJo?=
 =?utf-8?B?T09TK2JoVE9LMnNsTExwNHVPQmxxT3BRZUxpUUJvRkhxZUdIMlB1TEk5REg2?=
 =?utf-8?B?a3d6UkJMeTRhbEg1VE1ScUszU0Q3YnJtR0VFdWM2eEUwL0UzRHk5NE1jU3VP?=
 =?utf-8?B?Vmc5WjlDeHExZzJlZWFjMk9reHVPakIyZ0lvWnp3RVcxYkJIZTN5d0ZETFJ3?=
 =?utf-8?B?SU9KeFNycEFjZjJBOFErUHpBWXAxcjZzMTg0MDJTeVJMVndkcEkxSkYvMlU2?=
 =?utf-8?B?ZUVGeWZjSDBWQVRpdUNYUVZYcWx1dURyMGlCakZXWnlTcnlWV2tKdXJ1b1JG?=
 =?utf-8?B?eEtjMi9oWUZieFhrSzIzUXFMTG83ZytEak1hNHhDcmJCS0JaUGJ4NmF4SE40?=
 =?utf-8?B?VHJFcVFMU3ZFTjh4S29lZmtxNDlQS2s1QlVTSk9OVWg3VUw2QWF2c1pLY21C?=
 =?utf-8?B?N2JIcUVQUVZYSEZLbVNsamN3Yml0a3o4NUZEd0ovQkhncG4zSlZNL25VSGQ1?=
 =?utf-8?B?S2tMeHhWdE9pU004R0VwZGZ3WVI0U1NEWWdlbVgrbjQxSE1uNjdlUDRLcThy?=
 =?utf-8?B?WmludnY5YUdNWFdndDltM1pHWlEwNmxmd1NHb2JlMlRYWjRkazNjVnpHd2lH?=
 =?utf-8?B?dDY1VlpGYXFCZkwxYmRadlFXajUvT3VCcUJ2b0xyeFh3TFlUNnV4Z01VZkwy?=
 =?utf-8?B?WjR2TFVPdTcxVGxlMlI1Z3JDWDFxR2laeHovU1RXWVVRQ3VIZ2ppZVdrd25Q?=
 =?utf-8?B?WmYvd0FjeUFwd2xsUUJXYlFqRDZxNmxRVHlMOXBqdGpXYWpuNlRrMmFXY2Q3?=
 =?utf-8?B?a2lBbjh4OTVVWFdCSXV4a0JTVnRmR0pSVjVQQkNwS0hYOTVPNXV3UWlJei83?=
 =?utf-8?B?UGFJWldHNXpWV29PZUdPQ0ZidHNqais3YklGN1I3bUhpQnVTbU5lT2phY0k2?=
 =?utf-8?B?Z0NOZ00xeVdQcXBscDFBWFZtbG1UUFJXZ3BXTjc0cDFhMVppZjFkYzg4NlE3?=
 =?utf-8?B?R29XT2JBanlBZzMxYXNFZnVtYlpmVHpielVQQXpLTFlDWnI2dzZjY3V1a1pB?=
 =?utf-8?B?TWwwa1d4Szk3NDJWM3oybVpiT2F4QXZ5Y01yYmN0TUVFOVN0N3IvUkF0eG42?=
 =?utf-8?B?YlZOcjBQUzE1YXlpNGZyNmNEOFNwTlhxT05YRTJxYm1VbzRIMVJvU2N3UkdT?=
 =?utf-8?B?NVo2QkpEKzJleWZkdzZTQ0YxdlQrcTc4TDFlMzJVZkZ2cHBlQUJGVzh3RGtu?=
 =?utf-8?B?NkVUNUZaeU5mQ0dsbUdLMEJjU3FjMTBYNHNDS0o2RXlzVDI1cWlBNHFhdmlp?=
 =?utf-8?B?RGkyODZNcThGQms5WGpiZGE0c1JBUHJtejZXdUlpdGsrOU9WVVFOWHIvMXFx?=
 =?utf-8?B?S2ZSbk5jRnF5RnNneWFPS0VnVDBCTk9ycEx1bDlla0ttRndGUGoramZGdFIr?=
 =?utf-8?B?UXk0N2pHQy9xWnJHQ29kNXMxbnpGZEhYV2orMjJUSjJJMWd4aWJ1QTFBMTNZ?=
 =?utf-8?B?MW1ZTUNPMXY2SzMvRlZmMzh5bi9uUWE4VmhBZmtqbnIxeTE0cUdtQk9Za3kr?=
 =?utf-8?B?Z3dLV2labE5Eci8wT0xPRVNUUVhMc3hHbm9PL2pvMmxIMWJkejVnS0RGc25a?=
 =?utf-8?B?YVVHdU9MMnBpc0Q3N3RROHpwdGZTaXk5OUVsK0J0VElZMEY4aGZsN0xvZzVJ?=
 =?utf-8?B?cEpzc2hPc29nNWovVWhGYlRqMzRwV0hOMEtIVmU0OEdZTDNVOWU2VExyL3lB?=
 =?utf-8?B?R0NMaVJsL1d4NmhTV3VBVzNmdUxZUkhuRUVOY0d6d0kwZmlDQ3hSMlpXUDkz?=
 =?utf-8?B?OFpaNGVabnltTEFXdHM4SEg0TkhJZTUyVEdoNG9aWjVMSmVSR0g2RnJLUXV5?=
 =?utf-8?B?N1FOZEFFSHNtYnkwbVFadzB4NXlENVZDc3ViUVV5UC9OSmRWaE9BMEJFbjRJ?=
 =?utf-8?B?dldVQ1Q3MnpYZkRMcDhuMDFJbGx5bXFNWUNzamdWcDZoYmhiei9GSHBlQXJ5?=
 =?utf-8?B?QWhRd1lDaklDQ2I1UkxMWExQRHJWTFprZGNYWG9YUHg1enIrNXJtVXR4L0JW?=
 =?utf-8?B?YkdPWldHb2crVW1hR2hlbyttSDdFbXZXc2Y1cGd4WFFuZEFCL1gySHk1eTZW?=
 =?utf-8?Q?vjWlRpr6ru55rrFo=3D?=
X-Exchange-RoutingPolicyChecked: lWjTF1aFJCgx1+oyD3W5DqIsnkuqOil7xxKtsurlNdea5YqXcSSW13EOqmD8AG4jjA9QFAblGdtXJfh4ssluRzCospCJaoJy5LGuFSC78WnbSjC/BFN14yvA1dxxCcbK7xcym2UC1cRjTo+eG9gD8ANnZKAGWfCChUNpUZooho6KAXzBG8gfI4ZajwzlcJBQoopdFfnwvyXeioHlgGxfsO4UsZdM1dW1ULeoKVLhr3+jFvGbGSD+2hmT4X+UNYwrHsKa5ncPJ9T+Fo4BW8TlP11lbxQGS4Wc+zPWPKlU/S65w2L72v23Wc+fkepjmB4V1LlkdmnN+JYaxRH31+uu0A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10632f9e-0751-4e96-1b2f-08df29d3cf8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:16:21.4075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGJBnqOv0lJJIlQt1P2r80DZRMJlXgdT0N66ARDIJ1TxkmAe6GyHNsa6KzVhZRK5wrSDsneb+I1KxdWssJygW1LRpdrsAy2/u/zOc1Qd9/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9819
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfXya0mdFJrI784
 D2wTJdlKeYHfc+osyOhe8285CCum/WNLQGHgFN06Enya7Iq94Jr7G84ZP9hyQVCJE6Vk1vVzvs3
 QVt+/T2wFl+AB5yqSyVCTDL6ZcA7cgc=
X-Authority-Analysis: v=2.4 cv=G6uJgNk5 c=1 sm=1 tr=0 ts=6acf486f cx=c_pps
 a=/LfXjj9SJEtuRzurF2V9tA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=20KFwNOVAAAA:8 a=_MNQYyC6rkjJSMFfC5oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZQox33eOzb4o8MLrQeDBizZ68nV3GcEP
X-Proofpoint-GUID: ZQox33eOzb4o8MLrQeDBizZ68nV3GcEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX5Q46alxwN4Re
 dIAeouqtp+WHipigFqXKTiuVnuTJ3QGGhALA3O5aW1KRN+lbUE3movDwkw+9zbNMEFTRtyeIaUJ
 p0ItazOzrsH+gp9uOqnlKQ6XTZV8NBg3T5uyfdHXCzIARiLUSvINU/iuJO0OxOekFykoiIjcq4+
 vKYor20QXOG+9bbQaP/ZCZe6uUT0l0jt7R8Mufrj4cPwGwkDxV9Hgkl2h8TG2PgSsbjCbjf+GO9
 mshQAe0B56vp/rbQQAF6yEVpSiCoHYKPYKpQCE6I3qs+T2B6dBBQDo+EI5psF1tXZgIlgyG5r1d
 BHGrPVhgqRVwIL0OSnzp01Y1xaUaBEfvlKZA94FAkXvPUOAMar7rN4ijwNahsRGHROYAxJVUF1K
 7aCFTOMYO4Q1OoWpvE+42SHtcDTMPQUoF3NjguAMbJX2vsXOJosex+DPVrZtqLsQhsWlzIIbsK3
 L2LT/D8xXkMajXZ6p5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 14/10/2026 10:11, Daniel P. Berrangé wrote:

> On Wed, Oct 14, 2026 at 10:05:01AM +0100, Mark Cave-Ayland wrote:
>> On 13/10/2026 13:06, Daniel P. Berrangé wrote:
>>
>>> Add API docs to object_property_(add/try_add/del) to recommend
>>> use of class properties instead.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>    include/qom/object.h | 25 ++++++++++++++++++++++---
>>>    1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index 4c0645817a5..d3fddb449f5 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -1171,6 +1171,16 @@ void object_unref(void *obj);
>>>     * @opaque: an opaque pointer to pass to the callbacks for the property
>>>     * @errp: pointer to error object
>>>     *
>>> + * Further use of this method is deprecated. Properties for an
>>> + * object should be statically declared against the class, and
>>> + * not be permitted to vary at runtime. Use the
>>> + * object_class_property_add() method (and its variants) instead.
>>> + *
>>> + * If usage scenarios require differing subsets of properties
>>> + * to be present, this should be handled by creating further
>>> + * specialized subclasses instead of dynamically registering
>>> + * properties against instances.
>>> + *
>>>     * Returns: The #ObjectProperty; this can be used to set the @resolve
>>>     * callback for child and link properties.
>>>     */
>>> @@ -1183,9 +1193,6 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>>>    /**
>>>     * object_property_add:
>>> - * Same as object_property_try_add() with @errp hardcoded to
>>> - * &error_abort.
>>> - *
>>>     * @obj: the object to add a property to
>>>     * @name: the name of the property.  This can contain any character except for
>>>     *  a forward slash.  In general, you should use hyphens '-' instead of
>>> @@ -1202,6 +1209,12 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>>>     *   meant to allow a property to free its opaque upon object
>>>     *   destruction.  This may be NULL.
>>>     * @opaque: an opaque pointer to pass to the callbacks for the property
>>> + *
>>> + * Same as object_property_try_add() with @errp hardcoded to
>>> + * &error_abort.
>>> + *
>>> + * Further use of this method is deprecated, see
>>> + * object_property_try_add() for details.
>>>     */
>>>    ObjectProperty *object_property_add(Object *obj, const char *name,
>>>                                        const char *type,
>>> @@ -1210,6 +1223,12 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
>>>                                        ObjectPropertyRelease *release,
>>>                                        void *opaque);
>>> +/**
>>> + * object_property_del:
>>> + *
>>> + * Further use of this method is deprecated, see
>>> + * object_property_try_add() for details.
>>> + */
>>>    void object_property_del(Object *obj, const char *name);
>>>    ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
>>
>> Looks good to me, and at least it means LLMs should pick up the recommended
>> usage going forward. Do we also want to update checkpatch.pl to emit a
>> warning if someone uses these legacy functions so that it gets flagged
>> during local testing/CI too?
> 
> As long as we have piles of code still using the old instance level
> APIs remaining to be converted, I think a checkpatch test will be
> too annoying.
I'll take that as a hint to continue chipping away at converting devices 
under hw/ then ;)


ATB,

Mark.


