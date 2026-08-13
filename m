Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A38C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuTTf-000778-SX; Thu, 13 Aug 2026 07:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuTTd-00073v-Bm
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:20:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuTTb-0002RL-Lb
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 07:20:01 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D91Vb52255411; Thu, 13 Aug 2026 04:19:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=fnfQCYixzgyOpYvQOtkyNQJaqovXcF0jyRTUhgV/W
 n0=; b=ft8MrPP6OFeMP7AUYpzOnRvcaVPuEX2XZOC0v5pYCAgGo5xDIslyrdSdV
 uOMR6EzgWDRcvGrJ/Q0JyDmxKLKaJ5rwWzTtYEmWGSFIdFjmpt61K3gIW+4tiCI2
 ZuPPMV3om0lYGdKncvDIMm//NJ6UQ1KGFHPBpoM2UzKmwPQ4DxbOAYlxvCZCf/CM
 sfrVB/qm3R+xMsjeae44gWKPPhukryYT/ZVqcZRmv9ZaUY4JtjdtGupIqW5TBBTj
 mj9oLHV48pwF5THPU9DrYWuIX7+le0K3+Amogtl8lQLwAFWEeC/+OqEQTJNJrbjo
 FQMll2PhbCg0Lj3LVkohp7qSSHtSw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022110.outbound.protection.outlook.com [52.101.48.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g0gfs4322-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 04:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF7znT5Lm1IDmO1bzcls99WFaYIu/QuRdr0HuaAlpxGylHKZPTiXyTsRU0gNyXIUSI7HQzWXdv7Zs+frU6UvTrnmmE0JN8d+VI+AP5PEMcVVdXs3eOQeUXpHWUBbykK6GORqMUPZWt4v9q+GnQzCZJoAKCuUa00045g70q2Z4IW8TQU0bwxE4gaCDMDZjb3Z/vnT3rZMnX5r+ML/zVMFFJqgZrKkxpvUt6RH7w7VuEYxbnH03cW9ifxRNcNYbRrL6erFZWeuHxn/lX5fVbjPPaV1I5C6fVgiHqZFh6YHsMYi8yR3aLXu3LUL/BAuAjOOZYJQxU7LULh7LwySPxy+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnfQCYixzgyOpYvQOtkyNQJaqovXcF0jyRTUhgV/Wn0=;
 b=i5OpQdgS9qf/BaJiDxEhVM46kbkZqrj6+Jqz1qP7iJcbQgT8zrEjZtjZtKdxSdqeIIz9G4CihdvXzVCBLYJb1lmV2cumkJZKAq6P2ElZORwB05RTRVSpnPcgYLjhlv93f1SKfVEeT9qSX0m8KgostincgmfpsWY0r5edTsF01JuIGWbSRTbO1bKAJ9M8EeSKYKBAF1MQ2C9QRpZuYsDaJcXUqyUPGHnAj0nhDoiN+BLozPqub+r1pZMNGfNXbhPGrpZ4Lc+QKN32cT1vwcVum3Yy2oGq6xHzhZVNRNAS8nVrxvF0oP7PtTsdljraNmWjArPDq9R+NCAetlo6lSdi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnfQCYixzgyOpYvQOtkyNQJaqovXcF0jyRTUhgV/Wn0=;
 b=qm1xPYnubO9oom6V/VoH1JJJ85d3wpBJKIVnGnLDXM60nyBmaRFbKYdG41rtRfUssl76gZbdty7byl80yN5EC3Ur2M+QyNlnleZsDAj1/BlUq9Ad32kXSAsX5PzNo9u7xJ/pFqcbloP9EuRzOSPB1UPEHjRQgWHr69894Vqvri5wo5BHXEJCs7D7FI7SaksO0pkROgYpiffMmucFnQlg/OZjtj1qoJ6ZHxvRZUODfGAt1VPmkTmgTuJnrqRy0nA/gNZSUcexwRQWKCS100aoZYxb+33/t1rPztnzEyR7Kj5saTgXL6eYH6UQz9CZ80G0FEReUHnwwmOn/yqpDISDPw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9413.namprd02.prod.outlook.com (2603:10b6:a03:4d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 13 Aug
 2026 11:19:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 11:19:53 +0000
Message-ID: <56808ce3-169b-401d-8e0c-84f99ec1c070@nutanix.com>
Date: Thu, 13 Aug 2026 12:19:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio-user: reject failover during init
To: Hugo Komatsu <hugo.komatsu@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20260813110731.80-1-hugo.komatsu@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260813110731.80-1-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:806:6f::30) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 9133e6f1-1eae-4d0c-4a2e-08def92ccbfe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 78cBBkdsHJynp20iZ+jywPwfNkafj7pNIJs/QOUack1p066UX18l8+pA0oNKUdsb73XaWNWE734o98ZKW3WWR+Yw7SGMIoUad2wt+2qYgufC/lf7trGfQQVCiIg56TFTLzQomy6yquVr8uJ2i1hGzHn3ztTNBAiFfYYBg6fk9o2/H6Wzg7nm34WeFKzG7E2PHvvSVcbjy0A2nxUWmJ01sij8DdadO70qbESi8Z9GpfWCGJ26nORB3VeECGY1v8pKqF+PzUV8EqYmPf7kLADieDUddnzMlAM66UUA5FHEr7w0ldc6V433AWMvc1I4GPFgq/lOWPnciWgjqt3KVZnsBbYefRGs6jumBxqWLVE44Bldc5cNKSqhjo+hYu+R4uLgd8KbpiZkBkJlSv76BcuIEmzdwRKNabWfTWkFMFXGUGioc29hCX1vwVz6HTa0m9LZq6dp5mDSHPI8oVo386iDE/KEvj+oT780J7aABxJs9yTPAZ8dtJJtlSeImIkpaJbBhOVenmVjmjacIDcPdzrTywMro420Ziw8et9nGIpUfwQGKBixtMx4mCE4RvHKZ+wQE4DAueBv5OJzxH6iYzV/gJPS1USyQXwz8+pVIcfKVWCQV2GCxTU7zCg8Oyt68udu/th0DcZcbVAYfIg4J5jS1GK17VkI2PsLk2oxbxHrif0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFiNkVuM3hQT0lKZXAwNUplVlhudVczNlJyWXVzM0I4MEdVdXJWUlIwYnJs?=
 =?utf-8?B?V1FXOFBvcU1pck0rNTFpd0hrRDNFejlpVlFiMXlJR2xDQmFqYnI4SHhyQ08z?=
 =?utf-8?B?WXZsbWcvNU8zVUF4VzkzaElZNWp1a2V4dDVRemZiZkpYZGxDRHQzKzg3NkYr?=
 =?utf-8?B?bXMwMC9raExkN25uTTBTZUNSYjUwMEN2S0N2bE43eDlwV2xyOG5nOThVTVgx?=
 =?utf-8?B?VFhYN2NDTVRuaGtKZFFBYVBvNTUyOWpZVEFZUVVHZlhHckFCZ0VtL09GdDlp?=
 =?utf-8?B?MkZSdjJ3MWZKc3lDY2Y2SEozM2dTVUk4bVh3NnQ4NmpNdlRGSE1pbUN1SEds?=
 =?utf-8?B?MGZCME5yZlBNeDhrNEM0aEtFOExQa00zNjJGbmNwNjRhcjBCU3hOaTdtamUz?=
 =?utf-8?B?U25qdFRIeGFsWUcvd0NRMkJjOUJGYXBGenI4azJaTU8zT2RubkdTamx4YTI0?=
 =?utf-8?B?dDF1eEVHNkNSK0d5c3loN2pRcUJnUjR2cW5mR3JzUGtrblJvYkNKR3o1ekVL?=
 =?utf-8?B?ZUZMdkx6c3VpbWZXMnBmcUZCQktrVCtjZEJqaFRLWnp5Lzg3TVBkbXMyWGR5?=
 =?utf-8?B?amNYaHBScUtxbENYMEQzVE5xSHhzNjJ3QnlqaFprNitXM2tDald1aW5OdHdv?=
 =?utf-8?B?VE9pSW15dW5UUFBWa1YxOHVEWXl2cmNlbEgxUGhIM0lwMVRiWllrWlRFV2xQ?=
 =?utf-8?B?OHNjRVBFd255czZJaFFORUVERGtDdmoxUGQyQTd4SnZaSWxVOEtXZEErQ0c1?=
 =?utf-8?B?VHROeHFZS1BJU1RvMFVTYXZFY1B1YU5GTm1zRjBMKzMrakRQSTVZWlNUY1N4?=
 =?utf-8?B?MFlQZ2dQR1N4TGFYWjJheFh1cG9VeWpJL3BSL1U2cVhEZmY0R2xoTGpZWFpF?=
 =?utf-8?B?b0tQbXlIbkswaWRwM2FlbGJWczd1cHNudUtwbTMwYmQvcTdMVHMwN3hQaVlU?=
 =?utf-8?B?cjEzK0dDTzVWR2xGS0pQSFVMZUZBbHpRMklBUjdEZkJXbWxUbjQyaHErS0Iv?=
 =?utf-8?B?UDhoUUg5VDRBTGg1ZXVXekdBTWxHZmJkZVp5b2grVUErOU1rUXhzbTFQOHZO?=
 =?utf-8?B?VXpaUUdSM3VnQS9CUEI2NXhCOTc4ZHZrMjZKRFF5ODlwY0NwdkI3QVpMWnRk?=
 =?utf-8?B?YktpNktIeWM4bFR6bk1mZDlQMUJoYmwzN2l5cFNaT3dqdFBOUFRjYzc2QVRX?=
 =?utf-8?B?L056L3ZCajQyanlQTXpac0JqaGxBNWd0eHpWeHFPS1dQMEROZDFRSzJwc09y?=
 =?utf-8?B?aWxJb1FnN2R6ZXpUWEloM3hkeXZXdmltcDEyK3lEellwVHZuQ1N6TG1BNzgx?=
 =?utf-8?B?bGxRbHBmWlJlaWZpOHVadHlRVVJIYmVBYmdjd3FqNjUyRFNyU2dUaFZvcUhE?=
 =?utf-8?B?dnJoTHdibFVibXo3K0lZenpNVnRNLzJEWVlWUHYyYjZQQ2xtNHlvWGxTUmVC?=
 =?utf-8?B?dk5SNjRmYzVVRFNqSTdhSFlQY1h5UGorbmVXeThRRVpHbmZFKzNEQ2pDL2N2?=
 =?utf-8?B?OFcyK0ttaUJkTW9la0ZXTjZOT1FWWlNQK3g1S0FKOFRJcllOem1uUXl2TGFz?=
 =?utf-8?B?U2pTOXptNjdubUxzSldVdDFVQkxYSEp1eEZUaE9OeUYvdUVad1FmRm8wUWFN?=
 =?utf-8?B?YlFqUGZGTjR1ZnlJZlZ0cXU4eUVoWEozNGt6Y1FYbUpqckpaRk9lNVZRQW50?=
 =?utf-8?B?RFhnc2dLWmVCbm1uZVE4QTJRV3hoNnFXTnVpbHB2cEZjVWNBYUVrMFNWa0dE?=
 =?utf-8?B?VGk2VTFZenV0Mmo3VG1sUWhWcjBsY1lBWThXK3ZVaUwwYlp0K0tvSXd5cHFa?=
 =?utf-8?B?RWU5ajNXSHVRRTRIazgvRWM0RWkwSWlKSGhJNGUyMWlWaXBRalMvQ2FUeVVG?=
 =?utf-8?B?a1FCQXZTY1dUYW1DSWNmWk1GeU9NR1IvYzBmQ3BtaEJHUkdDTHdJT1dNYmla?=
 =?utf-8?B?R0Q1S1ZaR1hzbTV2dGJ5OEdyOGxyVUFGQ0ZNWWdPOTdXekRCbmFIemZOdFlE?=
 =?utf-8?B?VE9vSUdObGJjVDlJdXBuSU11ekRTQnJ3MXNCWkZFK290bHB6VDY4WDlBR05K?=
 =?utf-8?B?VUlaSmNMbU5aWUphWHRHYll5WnpRVWRNSmhzbktacVAvUjYrVUVicXNHTTBt?=
 =?utf-8?B?bDdFZG55dFdxYW5sUU9NL2padG5kbURTN3hVeDZXaWhlOTVEMk1Uc1owbTRj?=
 =?utf-8?B?TzkvR3duRUpXTHU0NWF3YnpNSUV3M0VxcUVEUWxZcktZTlo5UWVvRks1VWsv?=
 =?utf-8?B?Ry8zNTJvMkI0aGZNQWp0WXlWZnJUNHd3VnE3ampzUm9LSVBLUVdDM2NCLzFo?=
 =?utf-8?B?cHh2VFZIUjR6WEhRN3pLNklqMUlubzRxZTVtR01Rd2ZkM2FVWVliOVhkeXpt?=
 =?utf-8?Q?a0pN5EbtwoTTf5BI=3D?=
X-Exchange-RoutingPolicyChecked: iCuyHY/9iS+Pwa0IFUcqsuZPa7GfV7MMBdnoIJF8rOQVKP4Z4mhzYcz0oFZ3mtVRhSlhdhLVx1/K94HJBuK79bjRzPJ8hwafZ4ZByzdF+Xb7z1jImqs0Ko3Mov3/S0cGNcDM5kcvtu8zHofSe+SU4mjqL6CRv1nY17UmnwfNmHo5I6mm5PxKCuuvNoSyyxUs4KEFzGjX59uXac+fj37W4BOzpJmHunT0eDumkt0p9uTxnia7FUze2ZqkaBvMsVs8hZfbRA2Pdnh9NtgGbGLftUkFnmWfNTDvno/hpDcKImHPj2nRhOAe65YWhS2RiYH3fkzQ7wpmEv8KSCAs7NpTKw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9133e6f1-1eae-4d0c-4a2e-08def92ccbfe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 11:19:53.1735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /quZpwseZIi8NszgcMPPAziwWTxXAx/fepcQocmpZVLuHHmAThcubGHYJnCfhmDaU56amTgEqDYYo8f5VASftiqJ2M0gUggRgjhr0oLn+SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9413
X-Authority-Analysis: v=2.4 cv=eNwjSnp1 c=1 sm=1 tr=0 ts=6a7da85b cx=c_pps
 a=ylTaWg/OuTOBUQxDHB/KXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=OLB9oBBcv8A_8ZSJLlkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fgwIvvvY3gXpwprv_HVwNCC4IatB1PD-
X-Proofpoint-ORIG-GUID: fgwIvvvY3gXpwprv_HVwNCC4IatB1PD-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3OSBTYWx0ZWRfX+t8yUoCgow/h
 x9k+0nQbYNAbyMUOnnoidkTH9HL8dJswGTn36WR3crcMB1/SmmobRIeZHGFBcjc4PVHb/zfU4US
 PtZpdA/rOwivLWawLi8XsUX5WaWrBTA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3OSBTYWx0ZWRfXxiIDRclNFy8z
 zxQhZ6H5TovkZljjVbx577LPnBKxVBZPJAFxTX5lGAPRIK6SLJJMIz/47ZkfqbyNfo0+KA8ZLeC
 qlnKdsv8Tr6cejn5pFgiLBVBSPsypAZDl6cPHZZKBiTt8a2IF8RHtu6XEGhpiWLkEmCWRtV/MJX
 YTr+aLtpa/BMD5L3/9mXoMYkYdDzLMWm0MM88ftopa3V6ZRe8/y6uYchjke8MB4Rz/hOLxVEg/A
 wq7t7cyLtBlxznRkBNq8FDe4bdu64jMmGGiEr7Y4th+wZz/PSwR2KIx6KfpjM0exNSHoMH8Jfpi
 VIMjy+SJbTPKqqwhel+hwPtHHk7L8noMZOaPDpNW9otkKo22bKZCaQFfbxEA+lcZ2o792admUpw
 kbfbzfl+GBgR+Dma4lVonx97+4L6ppczD8HhP/n6gxhpsjMDO4p+m5t5dJQoXbTtfNTfq4wq0TO
 BHm2gJbbXTQaVoFkktA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

On 13/08/2026 12:08, Hugo Komatsu wrote:

> Virtio-net failover is a networking feature that relies on a primary
> and standby device pair. This is not currently supported for vfio-user.
> Refuse initialization if this property is set.
> 
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>
> Reviewed-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/pci.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 8e7ce5a92e..975d754597 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -251,6 +251,11 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
>           return;
>       }
>   
> +    if (pdev->failover_pair_id) {
> +        error_setg(errp, "vfio-user: failover is not supported");
> +        return;
> +    }
> +
>       sock_name = udev->socket->u.q_unix.path;
>   
>       vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


