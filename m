Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CC7C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Wdk-0003sK-SI; Mon, 13 May 2024 10:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Wdh-0003s4-HU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:26:53 -0400
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6WdY-0001cN-33
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clKG/IKtDHJd0C+CJLQH+QcBwDl9Ire3QqmsGLKFZlhnZB3Eq2d4SVXz1TVFEynwLkIBwgxxjjySEkrk4JZJSfcmFyXDwyNovMEGN8pdZfgtJ+XB4QH8JLRVZ5n2NAaC62DHAfeUv2vDJck9/TbPOQ23qk7+LAeBL9xgCdls6AiymFOlaVz2j11S/96vKBAvuQSYqkGHoLSaWS3i0ZQTGFWBJQ7UF2KIg4xzgzl14xOQ2HaGR7OOu4qlJuibxk5LVCKip68Hx4ZXGpJTeFj5A76FoFcgDsyFOWgIlFvKkHGRd/YiA/ReKnxYjc82K7d3ehkLZxujUz5N+40tevTirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B3b8XoKVbt/ULgIYoFqV++8wEAShakZ7dOrRWJL92E=;
 b=WZFB+04XMb6PxrpkRKh5RreVocxpu35f2cSsFbwLbZDZurlT5aBrDzyeqGFmcJ+n2SvsjrelkbO2z4wFJqyD1D7CQAA4mB4CKukDql3pnl9B0HjGUxliIWcC/sfznBz7P435GUh+6J5s+BNj9XSuarbzlEJB6Oy+75fm5Hf2Jyr0zAhjwhUnQ3g6tzAtkM1pCIlIuxL2a8FM9/XHYfCeztcwd+R6RzQ+VBUjMInbDrXIgmA2EGWx2CTSsXWrDKLb5NTkzLjilrYmQl/QEKOxFAs8zpSN6JGv+T8DY/j9nphbPouuuRcDNvD/u33k1SnIlyodu62cgdr8qDQ7Uwnzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B3b8XoKVbt/ULgIYoFqV++8wEAShakZ7dOrRWJL92E=;
 b=ZIA0G/GR6erp5Rxtkkf8mbWy37Vo9DBHJWTdIK4hPhaiQPapUAv23hSXe4F9Mreo/yeoEI4rcBYvZfXmLelxaUE7UIlWQmeYRotb2CQbitCxoXV0Qv/o2ecG1BrFCTVxZNhgDKRouhPLn4MH3zEeUtS0G+oISfDIQyh+x8ZRY+oMc5AHi8HBISGDlQDlMfnh6XVRhRFjkPeHwTXBiZ6gGkcsKzMOmXBA+QONoDZ57NmHUEr2tFIqDfq2MALZBY8XWVbgwwgI+lDYDU4Vuwsg9UtzX4f9xAPY1zw4vrtatg98nPbxHP4C+7IUmyJ7BVa36rznSpzQiOMRd/baDEnGew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 14:26:38 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 14:26:38 +0000
Message-ID: <c06e8de4-a3ad-4044-a4ca-f45d404314fb@nvidia.com>
Date: Mon, 13 May 2024 17:26:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] vfio: Extend vfio_set_migration_error() with
 Error* argument
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-11-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-11-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0619.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 1173c6ac-bc7b-4343-feb1-08dc7358b341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWpuRjVwSTRwUmRyTFQ2QmphQXE4S3lTZXF6MGhiU2UreXZsbG92VTA4WnFo?=
 =?utf-8?B?OXZIUjROaC9yVHBJZXpCSWRHYjExU283V25tOFJoV0NIaUNLdlhwM00zL2hS?=
 =?utf-8?B?dmRsQTJkdWdPZnpySlJPRlVMRyt1aTBMZnZaZ2wzeHpMRHZkcUFzTEFlTDR1?=
 =?utf-8?B?ZDRvaTdvNUY2K1J6Wk52QkgxRU9JVzMya1BrN3ZTWVBzUE8wYXdnNk8yY09R?=
 =?utf-8?B?WGVYckcrcE9WbFJBSy90YTI1THdVckhvK1pSZ01zSkVwU000YmwyZ0VMQ1NM?=
 =?utf-8?B?UW9tc1IxWk14RTVYOWhYaDhsaHRZWG92RjRIR2JsS1gvYzFUanpUNEtGaTJD?=
 =?utf-8?B?SGpuT2tCZC9rdkYwL21EYUdiTWFlRUNOc2lrd0lFaURZSFVMMW8ycWZoT3FS?=
 =?utf-8?B?Szg5Zi9vR3JicEZ3RjFwMmlvZ0JRTWtwanFDWHZlcjFqdGEvYWxFOE1iOTFt?=
 =?utf-8?B?dFVyeGF5WGVNSHBGYkZQOHQwaFIrL1dsbFZaWksyWlFpN3c3SmhZSGhlS25N?=
 =?utf-8?B?YUZpM0VSUHV4QitUTFZMVmt6WkhlM2U0QUVxa3dlMkV0clhUZVhKQ1NHL2Iv?=
 =?utf-8?B?SVBhcnhzbndtNC9VR3pLMGxZYUhsdEloMlVWNVR5NGtKV2NqOURmamdva09L?=
 =?utf-8?B?bU5Pa2pST3B1eVNTUTEzd0VXbVdkV1FKME5TcERyNlRQa3F2Z0hoZFRWZlVH?=
 =?utf-8?B?WTNWYlEvUlB6ckpxY0lZdnhwZjJHVWt4VXFEcDUvMGFzUG9qZXI3bWZPQWJ2?=
 =?utf-8?B?UWw3S3Bid0EwNDNDT093UWEwaXpadHgyM3Jna3BGRnhBQUppcHlZemgxbHpB?=
 =?utf-8?B?NGt4ZE1FR2N3Z2NTM0VNbUhwbmlHQXZJTmtOWDFZeENETXVidTFMRWdMQTdK?=
 =?utf-8?B?MitrdEt5aForY3BlNHJTdUVVNmpyNHBhcUFoelpHR3dleDJUNmo4U3JoUlpR?=
 =?utf-8?B?K3V4QXJvVXJjU0FraTBOQnFCdEMrWHlVcW5hM1pvQ0RDVmNlY1VrWWFSV2hm?=
 =?utf-8?B?TFU4ejlwWVkvMTJYM2xYRjJVTWpIOGYyalNhYlp1NHZVWG9ZQmZySWJzMUx2?=
 =?utf-8?B?dXJrZDF3cWY4a01wdFRtNXEzRnFSNGo0UktRVnBpYisvOXJZV3VTSXdQaStX?=
 =?utf-8?B?VkxadzNBeFdPei95Q1RXR3llZmFGZkFUOEVRQmQ4cmV0NHNqa3d5cnRERVdE?=
 =?utf-8?B?VzdBdCtsSkQ0dWo3VEFUMlBiNWN2NXY0bHBjWVlUYTIwTXFpY3Ric2FERGsv?=
 =?utf-8?B?ZVM2bU1aRk9qN2ZTVzhqNWUvRXJOM3ExeFJBNEdUL293UzBBdU1Ea3VrSmEx?=
 =?utf-8?B?RmowbWtKcDV5aVVQQldDS0M0c1ZQSUNaRFlRQXRzNE5lTVhLTjllcjFWWnZC?=
 =?utf-8?B?U25KSjFKQUs4cHN3NUdmZVFuaWdhMUpHMm5EMmJ2cDhCSnNXYm9BNVJ6ZzhU?=
 =?utf-8?B?cE93QmZIUzhhZUlCQk83S1RpZDdxWEw1SGV0VTdDMXdTUkRPeENZVDlveHQz?=
 =?utf-8?B?M1NPZDFPNklGb05OTDRzaWpPZk1kNUVvSHBpRjBPV1B2WGRpdEFMZG9PYzJM?=
 =?utf-8?B?NTh2QURialBNb0N4aTVXVnIxU1oza1Y3RDROU2RBSnZjUHI5RDNwTGZ0c2NI?=
 =?utf-8?B?Vk9obURCaFZBYWhQeW4rVCt5cUtXY3dOYXVWeWthd2tXUnk5dkp5dXE1N3Q2?=
 =?utf-8?B?QU1xM2F1RStST3ZDWXQ4b2o5c1h4ZmZTQ1FtYjRyaDhuOU9Lc005WWdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNLSVhxTWU5TXFaYXRuNVp1VWhKSmRsTnI2eDNnSGQ1ZGpBb01wL3d2c3Q3?=
 =?utf-8?B?TFlrSGlJRlVGNXhxMFdFRXVRUGNNdzNjSGpKVmRJSzVPR3BmdG9kUCtmWHJq?=
 =?utf-8?B?cVpLMkE4WHFnMDhMakZSTjhuUm5xUEpKQWJ2UjRjdnVteVBXenVPOW80cjkv?=
 =?utf-8?B?SVdpZXpMMkt4aUlXbGdaWU9sZjJncHNQVEtHNUZIeVAxUEVkTWE0V2ZUUTlO?=
 =?utf-8?B?N1Y4V1dWQWYxcURJUkZ2QzRBYkZZYWprNlRHUlB4dUtWUU5tMVJrS1JkWHpl?=
 =?utf-8?B?NE1lWXp1OEs5QTVEaDZLSlFKZm9oNFZYRU5kSVRYTDliaEhqem9uNGVhMVF2?=
 =?utf-8?B?ekxWa3VEd0hDU3dBdFRrNnZrUnlyVUNTVWY5ZVpscDdSSHIrUTBoUTJuMEFa?=
 =?utf-8?B?YVVlV2w2Y0V0R3hORlRCZGhESUNlZktKNU1HdTU4Z3ZUTzA3UFdZYzMxQjN0?=
 =?utf-8?B?VFZYMjNmWVhzcDU1eERRV3VSK1dkRURUdEZydDkwRFMvcklSTVNYRUhkdzZi?=
 =?utf-8?B?TUtRaVBvMFArTWJ3elk1dWVud1ZBV1FFbDlCR2xKRTBVMkJJL2JIcENHWEl6?=
 =?utf-8?B?ODVqQnpFbE9kajBlRC91SzYwUnlYcys3Y1dsb2lBUTVMVm9PRUsyYVdkWUFY?=
 =?utf-8?B?S3RwSG9xQXJZbS9BVGJCT0YrdFc4dEJCaDZDeWplbURVdm90U2MzbENBaVgz?=
 =?utf-8?B?RkRZVnZScS93QVVHSno2cWNTcUNUK2RIeHE1VjlUeUk5cVp2UzIzaUhERkd4?=
 =?utf-8?B?dTUyVWQ2OUxTR1hFZ0FDRDMyWmlNeDdmcUNtVUFFZkc1WHkwbERSdlBJTTZ3?=
 =?utf-8?B?a1dHR2IvQ2J0dmJJNkhCV05PSXRhUXNXQjlVSWtHZWpUWEVZSytZMzVkVlg3?=
 =?utf-8?B?VWNMNFNBSjlMK1Z5M1pBbHhFOU81MDAwUjhMYlFlcXQ3VUFtNFRWcWFkR2FX?=
 =?utf-8?B?VHNjQVRISHdsOWNzdk8vZ2VRcWxuai9jdVE3c09TTCtPN1VmOHNlYktVd0pq?=
 =?utf-8?B?T2h2MDYwTFJ6SUsza2J3Qy9OcmV0N2xvWmVKZUovdVlxdE5CYy9xeHRhblhO?=
 =?utf-8?B?K2prWkdHVnF4MlQ1THRQc1hORWhmeG83am5NeFBWV0E3MWI5VmVFcmF1Ym1F?=
 =?utf-8?B?Z3gzN0hacmxwdEdNaEFYTjBtcjk4SnRiSE00a2VzNTRCa29qUVNma1g5MVdD?=
 =?utf-8?B?eGVnQXVVTkFGZHFVckFRVC94UldpVlJGOEJpaXNVem1SVWxSK0xkVFVqcndL?=
 =?utf-8?B?Y0JBc012ZDdFQlpuT3hqYmZaRklnSUZ4V2dXTHZBV3BPNUhZK3NPM29IWnVL?=
 =?utf-8?B?cjU2bHdHMHdnamlvclg0V0RsQjN5VFhXOGxZQkNXSjFXckxxaFpqWGZzTXNq?=
 =?utf-8?B?ZytXMVdPaTdnWFFmTkRSbnZNTFh5V1ZXUEhqRCtiK29YMlBVT1lBckZMRXk4?=
 =?utf-8?B?aGtIZHJVK1VMOERRcEpEZk1NT0w3ZjZ3a3VJNlhsLzY2bXJjY0p3NmVPYVZs?=
 =?utf-8?B?ODU1Z2gxOFhRS29adXd3d3VycFM5WjlwZHNyanZHRG9Xa2NTOUwyeDN2TzVt?=
 =?utf-8?B?M2pBQUxSMGsvcXI5eSs0VHJsczlVQ09FQ3pNMUord20wN3VEWkV0S2wyeFNs?=
 =?utf-8?B?T0RQTXdnSXRrV2xiMlJ4SGhnTWlTaHFuTUdZd2tGWExVQUozeXVETkg2RW9P?=
 =?utf-8?B?TmVYcnVDbnpRejVEd1VFYU4vNFRwQURNbmZ5QWRIMDVuTmszdUJsZWlvalJW?=
 =?utf-8?B?dTIvNTVDRFUzZURra0xlcWw1dllLdzdtMi8xZW1LNDM0MXB2eVNaUmZrZ211?=
 =?utf-8?B?ZXBoLzhlM0pLL08yYW0yS1BUb2pvWlZBQlVsY0x6L0JTTlU3ZUxDY2xMcnlG?=
 =?utf-8?B?K2RiL0pEUXQxWm5saFZLQjA3bC9iYWhKV3hacXRWYkZub2h3NDZJdElUelR2?=
 =?utf-8?B?Q3BtcExSc0FaMkpFUHM2dExNdE11dlBnUmV3SDRWRFhCNmV6Z0FUYkx6N3JW?=
 =?utf-8?B?Q1FjYXc3QUlhOGZZa3BLUU9CV1RIYUZMUkVIbmZ3TzJmWDFDbEo2NlhRRXNh?=
 =?utf-8?B?THVvbEFydjQ2V3J1SkdiazVwa3hxUGFGZ3drTE5XMGNLbkFsTlhXLzd1UGJ3?=
 =?utf-8?Q?U3efsxjoefzFUup3PUTyVKJba?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1173c6ac-bc7b-4343-feb1-08dc7358b341
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 14:26:38.3669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG1G/JKV5NolssHVP9+qwk3eUrQe7x9btDM8N8fdorSGrmBfJbBv0+6DQwYORjuiP5hTbghAIcLKiMMghAxdYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
Received-SPF: softfail client-ip=2a01:111:f403:2009::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> vfio_set_migration_error() sets the 'return' error on the migration
> stream if a migration is in progress. To improve error reporting, add
> a new Error* argument to also set the Error object on the migration
> stream, if a migration is progress.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Changes in v5:
>
>   - Rebased on 20c64c8a51a4 ("migration: migration_file_set_error")
>
>   hw/vfio/common.c | 37 ++++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index c3d82a9d6e434e33f361e4b96157bf912d5c3a2f..4cf3e13a8439bd1b9a032e9d4e75df676eba457b 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -147,10 +147,10 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>
> -static void vfio_set_migration_error(int err)
> +static void vfio_set_migration_error(int ret, Error *err)
>   {
>       if (migration_is_setup_or_active()) {
> -        migration_file_set_error(err, NULL);
> +        migration_file_set_error(ret, err);
>       }
>   }
>
> @@ -295,9 +295,10 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                                   iova, iova + iotlb->addr_mask);
>
>       if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> -        vfio_set_migration_error(-EINVAL);
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        vfio_set_migration_error(-EINVAL, local_err);
>           return;
>       }
>
> @@ -330,11 +331,12 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>           ret = vfio_container_dma_unmap(bcontainer, iova,
>                                          iotlb->addr_mask + 1, iotlb);
>           if (ret) {
> -            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> -                         "0x%"HWADDR_PRIx") = %d (%s)",
> -                         bcontainer, iova,
> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
> -            vfio_set_migration_error(ret);
> +            error_setg(&local_err,
> +                       "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                       "0x%"HWADDR_PRIx") = %d (%s)",
> +                       bcontainer, iova,
> +                       iotlb->addr_mask + 1, ret, strerror(-ret));

Use error_setg_errno()?

> +            vfio_set_migration_error(ret, local_err);

Now dma unmap errors (and also the error before it) are not reported if 
they happen not during migration.

This makes me think, maybe vfio_set_migration_error() is redundant and 
can be replaced by migration_file_set_error()?

Thanks.

>           }
>       }
>   out:
> @@ -1108,8 +1110,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>       if (ret) {
>           error_prepend(&local_err,
>                         "vfio: Could not stop dirty page tracking - ");
> -        error_report_err(local_err);
> -        vfio_set_migration_error(ret);
> +        vfio_set_migration_error(ret, local_err);
>       }
>   }
>
> @@ -1226,14 +1227,14 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>
>       if (iotlb->target_as != &address_space_memory) {
> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
> +        error_setg(&local_err,
> +                   "Wrong target AS \"%s\", only system memory is allowed",
> +                   iotlb->target_as->name ? iotlb->target_as->name : "none");
>           goto out;
>       }
>
>       rcu_read_lock();
>       if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> -        error_report_err(local_err);
>           goto out_lock;
>       }
>
> @@ -1244,7 +1245,6 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>                         "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
>                         "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
>                         iotlb->addr_mask + 1);
> -        error_report_err(local_err);
>       }
>
>   out_lock:
> @@ -1252,7 +1252,7 @@ out_lock:
>
>   out:
>       if (ret) {
> -        vfio_set_migration_error(ret);
> +        vfio_set_migration_error(ret, local_err);
>       }
>   }
>
> @@ -1372,8 +1372,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>       if (vfio_devices_all_dirty_tracking(bcontainer)) {
>           ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>           if (ret) {
> -            error_report_err(local_err);
> -            vfio_set_migration_error(ret);
> +            vfio_set_migration_error(ret, local_err);
>           }
>       }
>   }
> --
> 2.45.0
>

