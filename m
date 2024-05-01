Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96213C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s294o-00069R-7W; Wed, 01 May 2024 08:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s294l-00065a-5T
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:28:43 -0400
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s294h-00086B-6Z
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:28:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEUcqZ5iCPEMaemvwOQlf88+mnyOHrClZogwrUkVtKoHyr2rQn8Ze4+mSJ+8RyjIT5LIMSDFQ6hPtF14q/xlNqidjwjYL9Pmo/x9Y2djqCk6trgGS+wZEB821wyEmRB+Ll7h88ImpeFsCQ778qUuaWtpHCH+nTfVPckDHfrd/CQqEZEBmt8N2pk7h+II1wu1pZ6HRx0wmtwKcg2w2gpx1TJEMex7ZS/oest+fBJzoLadq1QHXGsw+2wErIgjpfyjctLYl8VvML280RqIPh6iApFdVRQOMiAFBewKXLLGKlBHPyfloMrwq1CxBmTPf2LFSdiIIW4EsuwwD2c6+34VwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NE9MHucrQ70hzocbQciubuTPCtTIvpDhR8v1MOnk9g=;
 b=HDS70KCuT4oP102AYe9k2CKRLj3qT2mR8gASpAlNe1X6iHm4Z2YzslD7tRvGH1TvSdqmVXaptrzwM3Ew5xpaWcTmYUVP7fib9usRw3Zk5UnqjUvnwZ4sFHnRp2Y9rSC+Y8Y6mS9Lskr36fTpsc6cHpaIEJSVMfcFyLNBN+kzrdwhvY7C65V7iAw0OQlOAwMPbxrH9RDkjEdJMTQCnEX8esy+88SbjoogaZCJNQLZ1QuOX3lpJsW5WhnongIR+tpzLPrZgkvrMcjUyQfqukkmekGfrwQ/hb01gL7IYlF19VOYjJVXmO5lobo5BYRDZtVwhnvpcAaAvoAgj1NHL/AUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NE9MHucrQ70hzocbQciubuTPCtTIvpDhR8v1MOnk9g=;
 b=PVSAOVk1peRohmzyRJDNHwHlyQo9LDeeYBr6kEgp5leHj61xyk/wL0RuEbKeP4jSlAqh1uYFls81CZiuWZF8kK8ulyghHwGwAQCj7h/i5DV75CuSZlE7dvwOLrTdF5mgGcizObxAQ5e5baNU80HkbAW2ZOC5zn0gLGkSBCy3/0Y4vJjW/rVYaz04Lh7jgHPpF26b206udnHmpTyyCmMLKFM2Q6D4yVJrlY4Q91IOpvny6JHgjB5qmEWZXKFiAhueXLq9ScplyBRr+q2f4zUm4RKI8vrMTf4zD4vKjqY5qDBqF9+qM8Qih6Q2MSPwSmLyuGyyeEcW6vCArX2GYtLK9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 12:28:33 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 12:28:32 +0000
Message-ID: <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
Date: Wed, 1 May 2024 15:28:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b2b5c5-6160-4801-8311-08dc69da36e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWtOb1RmTTVGSEdNYk1rNlVEUFdYR3MvVTZ6TDNoQ29uS1ZEVmtCR0RnYkZa?=
 =?utf-8?B?QmdVMG5KM0FlVHdsYW96L0d3REtMRTl3ZW5uakVJclNEVTJycTh2SXhvS1Zn?=
 =?utf-8?B?VzRqTnl1M2JkbW1Dd3BVOWVzQUgwQkJSRUV0cjQxNVNEZ0RJK2YvQ3c1MWxI?=
 =?utf-8?B?QTBOcjhTb3d1aUk0QVJTUFRUSGdqbGN4RnRJN0J5YmJBWFY3MGg5M0MzcG1x?=
 =?utf-8?B?TUY0Zk1mZzF0aThIUmRidlhURkgvekc5dUd0WHVURURsUGNDZHNzSTU5OUlM?=
 =?utf-8?B?am5JZTBqRCs5Q3VkR2puOUJKSTNjejhxd2pwNHNmVXRTWndLZWVJaSthc3ZJ?=
 =?utf-8?B?Z0xPRGtDQTFZaU5KU3laQisxaDIwaGhDTGxnSllKTEkyZlc1bmNTaitRVDR5?=
 =?utf-8?B?akhiU2Q3bEIzS3M1aXoxK2s0M3cwbUJ6amlMRXdJWTlnT1ZVV2RKbk9vYlU1?=
 =?utf-8?B?dnRZd2o3Z0ljVVhVakZuU1dwL0kzZU5lUkl0eHJEaGVWdnVHbzJSRHF3VHhX?=
 =?utf-8?B?algxd1I5bHN5Z3h6ZkdTZyttSCtIOHNreGcvNXlYVHlTazFwWS85U3pRNFBp?=
 =?utf-8?B?b1hMQjFNb3QxV2xhSmlwVVlWMTZWK1ZCMTFUWGFXWWQ1aXY4ZUxpQ3lzSnp1?=
 =?utf-8?B?TGpEeDBwS2tGS09Yc1hYTkd2UDlBcSs4YXJWWk9jdEVIUkFML2pPZ3NXUDhS?=
 =?utf-8?B?ZUJWcDVybWxtUTk4R09WN0dmcDBqcXd1b0pLSkdiUk0xYnF5a3BLWU00Y3Iv?=
 =?utf-8?B?emx4K2czS09tNFlaNnU0OTJQSzNRRGRxbzBwakdSMGhPY3BUd1kzZFRiSHlr?=
 =?utf-8?B?NjFFWldrcnFxZHkzZjFFQXhQL1FCbVc0cTFTcnFxVm1vNDlIMDJlc0x6UjZ0?=
 =?utf-8?B?R1JtaFJWN0xIc0tlTmQ1TnlTT0tVNXpSOWRlcTdNWDlZcndXaWhBd3BhdUgz?=
 =?utf-8?B?Y01rR0tVYVJrL09NcnJDMWFhMit5eCtsejY1ck5YREEya0pHZ2x4cWl1dnJ1?=
 =?utf-8?B?dmxKTVBRVit4VkpKVklUanVVaXBOUGt6a2tvY3VrKzNqdE5kWEZyU29GeHox?=
 =?utf-8?B?N1BENTY2MU9Oc0NCNHp2VFRkaHROVkFDTmVZT1JBRUdRUG9VdlBWK01FUTFN?=
 =?utf-8?B?ZXgrYk01MTBmVmYvbE5XWjMzWHlPUDFlUnNSTEVycUtZckpCZ0JLbEdQczZk?=
 =?utf-8?B?RzF6aUJMUVhRZGttZnZKRTJJQzFOOGlrZFBvWVBZcmRwdHVEN3orUmtRKzJY?=
 =?utf-8?B?dFRyaTdxK3RCaGhXOUJpOXA5Qm1SL2lINUxHT201MDJsMU9rOXBoc1BwMzZO?=
 =?utf-8?B?ZW9FcmUvNlNyOU02NmxmZUlSL3JVZDJkREduNEhEbHZvZEc2ck5zeG1sMm5Y?=
 =?utf-8?B?YXpFem1MN1ZLSXFvUGE3aERGMUNQTllyMUwxdmdNbk9kWHJjVHZEWDFhbWNO?=
 =?utf-8?B?UzlyNDQyUjVrVjNQK05oaCtSRFFQbDVncUQ0YVZqcVlrQldZWEpaNUNwV3NZ?=
 =?utf-8?B?QmpaWVJ0SEdFdTIzTGswbStuQUtpYnRHR0lkc1FtYUU3eTg0akk2Z3p3UDF6?=
 =?utf-8?B?UWppc0dDQ2Q3NW85RlErVnk1NU1BUnIzcm0vZkFUZzBWR3A5V0h5UDVVcUxt?=
 =?utf-8?B?QjJIV3J5RHlBbmVVTHY5bU5nWmZLcEtzYWNmZ0s2SkFSa3FoQUFjdTBxcE1S?=
 =?utf-8?B?d3RjUTV1Tk1JMmtVWlU3QkN0bEVqcHlETjlUVkxuUkdEZWttM2V0a2p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NGMDgvWEFoVmhJV29Yc2liNm1pSFljOHZBdUlQd1A4RTZmSmlIZk9oMzFF?=
 =?utf-8?B?bm12ZitVeGlCWEZsV0lERTFCUHl2UFlFdW15SWt6ZzREQ3Q1dy84ZklsVjVL?=
 =?utf-8?B?VFRKaitwdGZkenRieDdmSDcwYzc5OFl2cnNTRzRQaWNpbEV5bTFUUElaTDd3?=
 =?utf-8?B?SjJjd2F0Z3N1L2lqWDJGbCtvaWdIR09YZ3JBQkRZaW9KSHh3ZHBRVUFIZ1NM?=
 =?utf-8?B?Y1FRSWlkWnFIeTlxTkZ4VVlmdktvQjJLd01JTkgrdzhFMTNxUWhmM2c1bTV4?=
 =?utf-8?B?T3N2b2Jpc0RDZ21ydFJ1VWZSb3hLNlJhQUptamE1ZVlDeWJjSXhUYnVMeWNM?=
 =?utf-8?B?NkdZTVl0TVZ2SFFNcHcrZ3hPdmlXTWxnZ0s2NHA2clRWbDlrRHNtK0Fta0o0?=
 =?utf-8?B?VThVQURYYUNRaExrb2gvdnZLa2pBbGwzOXdYbTlEcG5nL3oyc29QQmFBYk5Y?=
 =?utf-8?B?RUl0bGFMT3o4WWl4M2VRajhiajNTMU83V05ZMTIxeW56eEhhMXErMXh2eFg3?=
 =?utf-8?B?NFhtUzFYZHc0emxZWm5hYWFwK3FVQXRFY1d5WmdBSllUMlNTajREcUhjdW9t?=
 =?utf-8?B?Syt4M1I2VzVJSy96NDBFTTZYNDVacW85UDhmdTFLSjk0bUJUdkFhdkIybVJy?=
 =?utf-8?B?TitFVWRpZzVMM1hHMkJ2SzI5Sll3Q0RCSm11NHRKKzMvSHlYcmpsWmcxRGhS?=
 =?utf-8?B?ZzkySjdUMWhnUEdlWll5ZGN6ME1TOGR3RDRXZ21Pd3NBYkJyM3RNOWFjbklS?=
 =?utf-8?B?dUlhKzdIREZXdXhHb0xTUFJzRVJuVm1vSWtZTndaM1I2UU82Ui9CcE5KdG9N?=
 =?utf-8?B?eFQxREZ6V3JwVUNmaTA2NUhUOWMyWGtjQ05Dejhvc0xWOTZQQ0ordTNyMlVM?=
 =?utf-8?B?TXF6RUdVTmNUcTlHdTRPeEY3eDFzOTN0UG5CK25WM0N3WkFPcXZPYStXL2Rh?=
 =?utf-8?B?VFN1cXV1bFdrVTI0Z1ovbTRJMWF6VkNHVGpjc0w2R1l1QkhjL1RLQXlweDFm?=
 =?utf-8?B?WHQ2c2R1YjBLRDRNU2tEK2M3Sk1nTFJ5NFBZdGdqeXppRlU1TWJyZi84Z0Nt?=
 =?utf-8?B?bFZsUUhib1d6TlNrRHZTeW9tOW02S1krb1pvTW9EczZVME5Gc0dMdXc3MEZ1?=
 =?utf-8?B?VFk1cU1VR1hLSjNFRGhoWW9mVFRDMkp1MnRSQVRTbHIvWFltdU84RUNRb2Y1?=
 =?utf-8?B?Y2VLRzBJd1FYYThBb20wakNhclEzOWMzblNPdDl0enNMay9tckxrTlNFRjVw?=
 =?utf-8?B?SEJ3L1JKNEtjbWhmd1NIWm1WSm5LTXI0Mzg1TWp3NkZqQVo1Yy9zdWZFMkc0?=
 =?utf-8?B?SGdtTVNqekdpb3JvNVI4dXFCQllKaGQ2UUZ1a29NM00rSk1vRjdhTHVBSEhq?=
 =?utf-8?B?WHBKK2I5VXNIdTU3c0pNcXBxUWlmS0Y2Slh6aWhiQ1lLRjN3cVJ4cFpLMzcz?=
 =?utf-8?B?QStkYmxYdDRpT29ITTd4YkhPc2lHbEdVZldxNExabWNHVlY1bEkyR0lDK3ZF?=
 =?utf-8?B?d3R1UC90Umg1YVFpVXVwaVFUTmduZVhFNllxTWJLOUk4RjMybFJ0VVQ3VFR3?=
 =?utf-8?B?SUdGUVBPS1hhWDY4dUJwU3MwNVdCbE00cmViTkdicEMwREJsYm9LbnJGMGx1?=
 =?utf-8?B?blVEMzFHL3dHejlNV3NrWXJUb0hubXQ0MTRTRjFxTm5ocEtXdk02a09ad01M?=
 =?utf-8?B?QTBMTkpTbGZ2aUdMNnpEd3dXMDlwcmxIWUNLS0EyeitzTWNCZFdxbGRNNUNF?=
 =?utf-8?B?aDljVjkrU3hvSGNtczdBWW43M3JoTU9RNXB0ZXA4RFlTdk9QS2dHTml1KzJm?=
 =?utf-8?B?TVRzNmgyazVrQkZSSWJSajdpSjRzN0JlR3ZTVEpINEgyd2VOSWRkTHgxc1ZO?=
 =?utf-8?B?TW9DaThoczNjZ1F5bVY4QUtoaS9jUXhrd09yTDEvWXJ1ZDFudlJERUdNQlBp?=
 =?utf-8?B?WE5rYm91T21YWGNwbnd5UWpTMEU0UnhIdjAzUXhVK3FXOG9tYjJld0VYK0w2?=
 =?utf-8?B?OFFEL3VSeVRMMjNjZmN5QStsOHFpQ1NVUHlEQ1lYT2piUTNEbkFNV2VPM3ph?=
 =?utf-8?B?VmRCQTRoajRHUXNBMVRnOUJZQTFuZ2ppRm9JZWFWaWNVN2NjODEyVGhhbUxK?=
 =?utf-8?Q?EQD9+lDpx8Cc8MfypgkBLpBhB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b2b5c5-6160-4801-8311-08dc69da36e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:28:32.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA9QtM7SxBvCx29t+NcAHXFCGICHW4r7u7sVgP9FPQJB/g0d/NFhMU7537K/1xEZhc48yAvfrJ/NCCVL9l472g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 01/05/2024 14:50, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 30/04/2024 06:16, Avihai Horon wrote:
>> Emit VFIO device migration state change QAPI event when a VFIO device
>> changes its migration state. This can be used by management applications
>> to get updates on the current state of the VFIO device for their own
>> purposes.
>>
>> A new per VFIO device capability, "migration-events", is added so events
>> can be enabled only for the required devices. It is disabled by default.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  1 +
>>   hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
>>   hw/vfio/pci.c                 |  2 ++
>>   3 files changed, 47 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index b9da6c08ef..3ec5f2425e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>       bool no_mmap;
>>       bool ram_block_discard_allowed;
>>       OnOffAuto enable_migration;
>> +    bool migration_events;
>>       VFIODeviceOps *ops;
>>       unsigned int num_irqs;
>>       unsigned int num_regions;
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 06ae40969b..6bbccf6545 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -24,6 +24,7 @@
>>   #include "migration/register.h"
>>   #include "migration/blocker.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qapi-events-vfio.h"
>>   #include "exec/ramlist.h"
>>   #include "exec/ram_addr.h"
>>   #include "pci.h"
>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>>       }
>>   }
>>
>> +static VFIODeviceMigState
>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>> +{
>> +    switch (state) {
>> +    case VFIO_DEVICE_STATE_STOP:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
>> +    case VFIO_DEVICE_STATE_RUNNING:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
>> +    case VFIO_DEVICE_STATE_RESUMING:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    const char *id;
>> +    Object *obj;
>> +
>> +    if (!vbasedev->migration_events) {
>> +        return;
>> +    }
>> +
> Shouldn't this leap frog migrate_events() capability instead of introducing its
> vfio equivalent i.e.
>
>          if (!migrate_events()) {
>              return;
>          }
>
> ?

I used a per VFIO device cap so the events can be fine tuned for each 
device (maybe one device should send events while the other not).
This gives the most flexibility and I don't think it complicates the 
configuration (one downside, though, is that it can't be 
enabled/disabled dynamically during runtime).

I don't think events add much overhead, so if you prefer a global cap, I 
can change it.
However, I'm not sure overloading the existing migrate_events() is valid?

>
> Applications that don't understand the event string (migration related or not)
> will just discard it (AIUI)
>
>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>> +    id = object_get_canonical_path_component(obj);
>> +
>> +    qapi_event_send_vfio_device_mig_state_changed(
>> +        id, mig_state_to_qapi_state(migration->device_state));
>> +}
>> +
>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>                                       enum vfio_device_mig_state new_state,
>>                                       enum vfio_device_mig_state recover_state)
>> @@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>           }
>>
>>           migration->device_state = recover_state;
>> +        vfio_migration_send_state_change_event(vbasedev);
>>
>>           return ret;
>>       }
>>
>>       migration->device_state = new_state;
>> +    vfio_migration_send_state_change_event(vbasedev);
>>       if (mig_state->data_fd != -1) {
>>           if (migration->data_fd != -1) {
>>               /*
>> @@ -157,6 +200,7 @@ reset_device:
>>       }
>>
>>       migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>> +    vfio_migration_send_state_change_event(vbasedev);
>>
>>       return ret;
>>   }
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 64780d1b79..8840602c50 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>> +                     vbasedev.migration_events, false),
>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>                        vbasedev.ram_block_discard_allowed, false),

