Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC646CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 01:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLg0-0007Pg-EB; Sun, 23 Nov 2025 20:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNLfy-0007MO-D2
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 20:47:34 -0500
Received: from mail-westus2azon11012027.outbound.protection.outlook.com
 ([52.101.48.27] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vNLfv-0002ix-G2
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 20:47:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjItUgVR5CFuA4x8VtzSshwsAO+/oX60TJem3bE45z8qf67BMbhQ3fHzDwDL7qtnSpu54xPZAOUzRrzCtKIULJukr1F8kKoLoRBwgj6zORJJCP+Hcpi7JbCOJZmIZdvOUheAgbrTRk6iZs1B9T1A/cay3qCjjllM3oo2/CytHWqSRUmR8uePQGtx2tiOPuc/GotExMcwK2eHeHPmrpOpGqOuwRu0XYszpADqJaPaY7Lo+iqCjWNPfI7/2u2xsYXaX6MTwcVPgXX0xRGBC/i4OScATIzM4fKvPTe5xsobXo4O9kgh6t3it64XmC3WQIjan51uNxijcDBq1p/TNDJg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD8gElNgyff6eJwfm/WTcb72yQf/OluNUq1EPDZ/640=;
 b=NwXTmQ89iirD4OWTe/+BsaRkAimaHxX5QJ7ALbk+YN6VT/xmBms01UWNVeDeHdaKMFGqwPg5NppElBxbVxcC3qKUB5/uUBigIymfYoGU6+qNnNukyuuZh7EEdw4SBCIyMH0gXdd8CGVAjg1+Bbz9eVWLLblBF3lsOywlirRALycl7ur2LJamkQeowpBq3F61wZZsHoK+lw7QtQqZggtTPzZDlkDcmIvTt/r2DN0bm3+RN5HhVTaKkKXJ9slonFp9zvytED8fthgSoiRJ1FFjhDbKpEk+gQjp8EJAXEvncNeBVfnf9XSYFigSdbHkRzJHe97EXP1gJqbPuCrKsgN3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD8gElNgyff6eJwfm/WTcb72yQf/OluNUq1EPDZ/640=;
 b=Wr/JQ7N/XxNTjvlAqlRvWhl+eHdNnN5IILFJ05w7E9BAvH6xwvEEzwn+InoWCK7x7MX2LK5fEtrqLAfHRVhlhHejUbmTK9zKhXsLykXXYBnzNdduotPSAi/VpajimqGn1DY3FwsUkgWZIlYlf32xRRHX07kdmS/ZW4EtYA2jETM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 01:42:23 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 01:42:23 +0000
Message-ID: <ab145340-db1a-4f47-bba9-97d8e9939a14@amd.com>
Date: Mon, 24 Nov 2025 09:42:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 alex.bennee@linaro.org, armbru@redhat.com
References: <20251121075802.1637598-1-honghuan@amd.com>
 <0ef0b85a-d45b-4efc-ac1e-b562b1d34786@amd.com>
 <b828a7e0-5422-415b-b4da-2442b0c924a1@collabora.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <b828a7e0-5422-415b-b4da-2442b0c924a1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY1PR01CA0191.jpnprd01.prod.outlook.com (2603:1096:403::21)
 To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 995aca24-4b8d-426a-e0d5-08de2afab6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm5BZDZMZVdlZVRvOG5YZEtYN3c2SXRJeEJiUmh6L2FDM1NrU0UvbWV2M2dX?=
 =?utf-8?B?eVNCMVVNcmlITUxPZjdiVkNRMnpnQ1BBc0l0T1c3bDNQNy9jbktxSkpyUU1n?=
 =?utf-8?B?VndjVHQrTDJNTmFpeUY0ZDBzOWI0RWxmWjF2b0tYdFREeFcwVUpwLzkzenhx?=
 =?utf-8?B?QVg3WkV0cDVKa2RwY3V6Rm91YmZJMFN6M2xkS210cVVSejFMejl6Rm94d1pX?=
 =?utf-8?B?SGlUZXhmZU5uWS9tdXRWYmcwNXdhVkRaTjZlZ0liSVJsTXltb2VpUUcyOEly?=
 =?utf-8?B?bjRmaTlLdGZJVGZLcGdNcWxFNjQzRlpoTzFUUjR3VkxrYVRUZ0VRVWUybE0w?=
 =?utf-8?B?cnBjSEtCakFLZUVjQzZJRkpkSXhLZHVpWGtVL093RFQ3M1M3VHhPeG1ydXlR?=
 =?utf-8?B?QWtPNXpwQWlkT1FPOS9EWlM1VlJJVUVqVFNzbHFjOGpBUWRKVkR1UjlTSDdZ?=
 =?utf-8?B?QjU2ZjJWVkJOckIzZWZJejB4R3NzSEMyajNJcmZDUStXOVlaRThlVXlUMDhv?=
 =?utf-8?B?ckNrVWRoaHE4dGFMTXNicHIzSUhQbGprVzg2dXhzSlRFeTY1S0YxdmtKWGVO?=
 =?utf-8?B?ckxLSE9JeWRTcjJVNloybFFpdTVIeXljMmFFVDVNMU5uQ1ZSYjZROW8rb1B3?=
 =?utf-8?B?YkJTMzNBYk5pUnN1RW90V1YvcitrdS9hWDNJbld2R0VtdlNQZFhYWlZSMUJ4?=
 =?utf-8?B?SlVxZysrQ0kwaW5YOE1iRTJ2bC9SUUpZbEF3eDNFWGpGS2NwYnYzMUlJZ1dv?=
 =?utf-8?B?bGh6VGc0OEJqakkzYzFwMkxKSjhoMFZLQlloWkFIcG0xdGlhNWZXM2ZFV2gv?=
 =?utf-8?B?cm1JREVZaFYwc2Vod2VaNWgxK2EyWGRwODJFYUhzWVNYOHN3WXhVWm5wVkQy?=
 =?utf-8?B?RWpFWUZDSWs4V1lJMCtYdEZUak5BRjhSRy9LRjU5TVJ5ZXJPTFdwdnByVlky?=
 =?utf-8?B?UDRFdkJ4TGsvUUJKbCt4bXg3M1IyYWVjcW11dmMyS0YvWjFCbEZERTBrcWdM?=
 =?utf-8?B?dTRKTVAzNGw2MHFxNlFJYlBoNFNCVTJ4SXJsMElZRVY5TzFlQXJSRUFpNnph?=
 =?utf-8?B?cG5iN0lXRUY2TUkwOWVrem9CK0sxaTRydVIxb1J2aVRycG45elh5L2M0bUI3?=
 =?utf-8?B?UzhkOGFvdUwxRjBGMzl6a3U2YzBVRzRpRTVDMUF0alBEU1cxc1lCVm9qU3pG?=
 =?utf-8?B?K2VsQldESDRPbjdEcGFRQXg4enF4TFFJVTNERWQ5bXhhdGtwSXU3bXd6ZC9v?=
 =?utf-8?B?MUgrVVlLM002c3VPTkF5S0R4a0xkMm5ueWZZcnluaDVWNndGOG56NXNOSy9u?=
 =?utf-8?B?eEFRREJqS3g2YXNtdDVaeFhWWG04aXVaU3F3aGJZYStVQXAxUVRwZTltK2pr?=
 =?utf-8?B?M3h4bkJHYmNuWWpZU2xUMllQU2FzNkVHVFVwMmtMSG13OTNmL21tWjNiMUwx?=
 =?utf-8?B?anlrcjZodWxCWlFQQW1Ca25zSTdLcFlxZFJxRVp3SFNLNkFDWnFWMUl6SzNY?=
 =?utf-8?B?TlErZGZQRUQxeE5Oek9vQzNYMkVaNFB5ZmZEdG1la3l1ZXFBOU1tQTFreGNM?=
 =?utf-8?B?c3ovYlVicVpkQmZKZCtpUXp1WWQxV1l0ZWJkM3QrRTNlSTExdlJRbHp0dUtN?=
 =?utf-8?B?TzMycitUTkl6QkI5NEc4ZUtnU0xZQTQwL1ZPSFRsL3B0RS85TzRBaHQ4YXdr?=
 =?utf-8?B?Vml5ZVdtc1JHdktOeXpnWko5NWtZNCs3U1dxZlJxeVk0NzB1M3NzNnVoMjhk?=
 =?utf-8?B?Z21BcnpScEtnU04vcTdnZlhxRElTR0JkSVRmdXFwWjJtQ0lybXRPbjFzMzlU?=
 =?utf-8?B?ZUh6VHdhNjluRGR0Y0llaHBmbDlBdjFCNE5Sb3ltUERMM1RFdG5JOU9vaHdw?=
 =?utf-8?B?cUFrdVVONUgrNVdpUk80RHlpZHl6YjljUmRycHVrbUVMSXFaaTJzckNVYjZh?=
 =?utf-8?Q?GTiJih8MTwBTBi2km4vXcuJaWtzDVCRA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BGbm0rSXh5dzNjTzY2b1FMcUlDaUx3WmJ6SkRxOVpreEw4UE5TcGl4RzlS?=
 =?utf-8?B?MnlmZGxCRGRRU1pIMUJHSC85Nll5L1pGdFlHTFpTZ2RZbXJRSUo4VGJsaFZz?=
 =?utf-8?B?YlJYa0tZQUFGTHlmMnVFaUVZNGxTdmZUMHl1NmVMVVNIb0VmdEJXblA3c1ZC?=
 =?utf-8?B?REpUeVNPT3NFcE83OVo4WFpvSTJsQnlhSld5aHNObkIrd1ArMmNYenZ5RXdG?=
 =?utf-8?B?VENoRG4zQ2d2TU5Cb1l4L0Q1SG9UMC85TElKeUFVL0hXcjkxRkpxM05uTUI0?=
 =?utf-8?B?cnlkOXQ5NGFOaXNUUHJHWFhoTHpqNVVIRHFIQ05nVEpacEZLTi9ldERCSkdM?=
 =?utf-8?B?Nk82L2UzVWFCYkxPNDVRcjg3ZjVEV3RidXZZVlU0TUU5ZWhrVHNQZDlTQUkr?=
 =?utf-8?B?a3VnaWdLQ21QVDNaRld6bE9rODIyNy9jUzdoNjVqclFRVjIrOXlmaUdCOEMv?=
 =?utf-8?B?WWVkcU1TekRGY1ZwUGI0Vk5ObG5XVmtsNXRJVGcwdUE4ejE0dXl0OGQ1bTRS?=
 =?utf-8?B?VEt4MG9WS2dCSk5MNWNJdnZMSGtXYkFuMXV6M05uaUd2U3ZyU290Z2dUSjIx?=
 =?utf-8?B?NkRFRXJ1ay9YN0FrSVRYVmdRRnhWRTBqRndxbWY2bXJUbUhCZXI0MDMyYUkz?=
 =?utf-8?B?bEhVWkFYbHdWdHZnQ3JBSm1sQXVtdWNlMVg2OThQc1J3WFUxVFpLSTZNSUV5?=
 =?utf-8?B?MTQ5a05wUlFYZEo3STA5ZzdaK0t6UXpSSGRNanVDQU5McGptUHVhbm1jejRX?=
 =?utf-8?B?dXNLK05QK0w5czlHenFpNFNCOHpZcDg5R2FhbFNFT0FuWmZyR1hwN1l6dWdu?=
 =?utf-8?B?bk43K2pHWk8zWFpqOS9hQzArL0FmWHR5YWduT29PSXQ0NTI0YnR5T1Y0V2Yz?=
 =?utf-8?B?N1AxbzkzMFZQbVZDUmNGNHFTNkh4UkRBeXA0cTY3NmxpRmhaVTYxcC9kZ3pj?=
 =?utf-8?B?ZW1MSXdrOHNZK3gwQmF5cjFJUk42SHRadDR3YmdiQTA1Y3RWakl2L2JJbDRZ?=
 =?utf-8?B?ZHkxNDhMay9Gbm83S2FxNTBxV0ZBajU1bDNQZUVEZWZDMUtMOWVJQWhmdm5x?=
 =?utf-8?B?M1l1MlVvZTA5S09tblVra0F6eVNHSklCa2pidkFYOXExMmJpVXlXdEdQcWpw?=
 =?utf-8?B?amZWTlN1RkFqQ3JubGpSV0YzbXF6dnhiOERIVVhIYmJSRlhhMWdTQU95OWFS?=
 =?utf-8?B?QlI1OTVPaFpKendDb2d2TU1wY3NFeTFPQXNtSG1CamRqTllqM0ZjNEVDVU1T?=
 =?utf-8?B?ZVArMWhvcmdRR2loV2VJTmwvbDNPUXJCVVV1OEllOUdFbUY3bzdyR2MrR3Y1?=
 =?utf-8?B?ME5ZblJrcmlKR3ZuaUJ1Zmk4bG5VMU5LZWMzNXU0dWxwNWFpYXRzVVZwRXdY?=
 =?utf-8?B?UGhmSTZJR0MyQWxkY0wwQXRwQ3lqS1NwN0dlZERHRmRqRmYvMERoekZmRVUr?=
 =?utf-8?B?Y3lLUThyQVRqSmgrNXlDanRwSjdWNHozallTL2F2Zmk4d3RxeUg2VnV2b2lX?=
 =?utf-8?B?L1hERUZGcUV0eVhTeXpkeWV4d1N2Tk5tYnRTLzg1bEdUUkQ4TnBacVpORVZW?=
 =?utf-8?B?TWh6K1JIYkRtK3M1MThxNnV1alVsSTk4NTVjaTRqcTVpS3Joek5NU1JnNFNE?=
 =?utf-8?B?YkY2a2NtM2l0cjM2ak0waUczTDkrM2FNelN2TWpUbHZiSHliODhkcm4zSTV1?=
 =?utf-8?B?U3dTQWkyTkx4SHpTTzV5N0hoRG1NWmlvTjZRSnl0N21jemNXNjEzcEZxVUxu?=
 =?utf-8?B?TFZVTkNaZ1VQUHFVZVpONmhHS2x2TmJBazRISXM2YTQ4TC9LbVNZMlRlaWtk?=
 =?utf-8?B?ZFUvOTlDamg5Y0RGRys3R2NSd0hseXVJekRaMTVOMmpmejZjYnhPVWd6bkIv?=
 =?utf-8?B?OWJPcW1MQWxpcHVMYjgwd3pPTUpoWFBidU01SlphR0JzN29RcWF6ZUpzaCtV?=
 =?utf-8?B?U3FMcHdxVVpiY1E0MjhvM25KK3l6c2xnRDN2V3JrSXBGekxkaDd6NGlDVkFC?=
 =?utf-8?B?TDdldTlISkhnOExaTFpDQ1RVRCszdkM2dUlVZzFISGF6b0x0NE9UZUJ4Kytt?=
 =?utf-8?B?RWo2TlFjZ0hpbG4wRTlKdmZqMXJjaU0xV1UzNFZnOHB0M2E1Ums4d1J1VWF5?=
 =?utf-8?Q?d5lKETM8GH05Zn5Z7Rhz02u4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995aca24-4b8d-426a-e0d5-08de2afab6ba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 01:42:23.1981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZYp/1pG+Lx+AvrWGlRCFq95KTEm1wUZrb5MY4dAlA/+p4GTNnIlBKS5NvMgV6Xs4swjWCP9LWu4ZMI84+1fuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
Received-SPF: permerror client-ip=52.101.48.27;
 envelope-from=Honglei1.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/11/22 02:00, Dmitry Osipenko wrote:
> On 11/21/25 11:14, Honglei Huang wrote:
>>
>>
>> On 2025/11/21 15:58, Honglei Huang wrote:
>>> Fix error handling logic in virgl_cmd_resource_create_blob and improve
>>> consistency across the codebase.
>>>
>>> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
>>> on error, but the original code was inconsistently checking for error
>>> conditions using different patterns.
>>>
>>> Change all virtio_gpu_create_mapping_iov() error checks to use consistent
>>> 'ret < 0' or 'ret >= 0' patterns, following the preferred QEMU coding
>>> convention for functions that return 0 on success and negative on error.
>>> This makes the return value convention immediately clear to code readers
>>> without needing to look up the function definition.
>>>
>>> Updated locations:
>>> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
>>> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
>>> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
>>> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
>>> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_attach_backing()
>>> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_resource_create_blob()
>>>
>>> Changes since v3:
>>> - Extended consistency improvements to virtio-gpu-rutabaga.c
>>> - Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
>>>     CHECK(result >= 0) in rutabaga functions for consistency
>>> - Now covers all virtio-gpu files that use
>>> virtio_gpu_create_mapping_iov()
>>>
>>> Changes since v2:
>>> - Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
>>>     feedback on preferred QEMU coding style for error checking functions
>>>     that return 0 on success and negative on error
>>> - Updated all similar usages across virtio-gpu files for consistency
>>> - Expanded scope from single function fix to codebase-wide style
>>> consistency
>>>
>>> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
>>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    hw/display/virtio-gpu-rutabaga.c | 4 ++--
>>>    hw/display/virtio-gpu-virgl.c    | 4 ++--
>>>    hw/display/virtio-gpu.c          | 4 ++--
>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-
>>> rutabaga.c
>>> index ed5ae52acb..ea2928b706 100644
>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct
>>> virtio_gpu_ctrl_command *cmd)
>>>          ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>> sizeof(att_rb),
>>>                                            cmd, NULL, &res->iov, &res-
>>>> iov_cnt);
>>> -    CHECK(!ret, cmd);
>>> +    CHECK(ret >= 0, cmd);
>>>          vecs.iovecs = res->iov;
>>>        vecs.num_iovecs = res->iov_cnt;
>>> @@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>>>            result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>>                                                   sizeof(cblob), cmd,
>>> &res->addrs,
>>>                                                   &res->iov, &res-
>>>> iov_cnt);
>>> -        CHECK(!result, cmd);
>>> +        CHECK(result >= 0, cmd);
>>>        }
>>>          rc_blob.blob_id = cblob.blob_id;
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-
>>> virgl.c
>>> index 94ddc01f91..6ebd9293e5 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -557,7 +557,7 @@ static void
>>> virgl_resource_attach_backing(VirtIOGPU *g,
>>>          ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>> sizeof(att_rb),
>>>                                            cmd, NULL, &res_iovs,
>>> &res_niov);
>>> -    if (ret != 0) {
>>> +    if (ret < 0) {
>>>            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>            return;
>>>        }
>>> @@ -701,7 +701,7 @@ static void
>>> virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>>            ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>> sizeof(cblob),
>>>                                                cmd, &res->base.addrs,
>>>                                                &res->base.iov, &res-
>>>> base.iov_cnt);
>>> -        if (!ret) {
>>> +        if (ret < 0) {
>>>                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>                return;
>>>            }
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index 0a1a625b0e..1038c6a49f 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -352,7 +352,7 @@ static void
>>> virtio_gpu_resource_create_blob(VirtIOGPU *g,
>>>        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>> sizeof(cblob),
>>>                                            cmd, &res->addrs, &res->iov,
>>>                                            &res->iov_cnt);
>>> -    if (ret != 0) {
>>> +    if (ret < 0) {
>>>            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>            g_free(res);
>>>            return;
>>> @@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>>>          ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries,
>>> sizeof(ab), cmd,
>>>                                            &res->addrs, &res->iov,
>>> &res->iov_cnt);
>>> -    if (ret != 0) {
>>> +    if (ret < 0) {
>>>            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>>            return;
>>>        }
>>
>> This v4 patch started as a bug fix for error handling in
>> `virgl_cmd_resource_create_blob()` but evolved through community
>> feedback to include comprehensive code style consistency improvements,
>> unifying error checking patterns (`ret < 0`) across all virtio-gpu files.
>>
>>   This version appears to have gained community consensus and may be
>> ready for acceptance.
>>
>> Correct me if I am wrong.
> 
> I was previously very puzzled by what bug is fixed and didn't notice it,
> seeing only the err < 0 changes. Now I see which code is fixed after you
> pointed it out explicitly.
> 
> The common practice is:
> 
> 1. Bug fix patches should contain only fixes
> 2. All code improvements should be done in separate patches
> 3. Bugfix patches should be first in the series, improvements follow
> them on top of the fixes
> 
> So here should be two patches:
> 
> 1. The virgl_cmd_resource_create_blob() fix
> 2. virtio_gpu_create_mapping_iov() err handling improvement
> 

You are absolutely correct. I apologize for the confusion in my approach.

Will prepare v5 with this two-patch structure, ensuring the bug fix is 
isolated and can be easily reviewed and backported if needed, while the 
style improvements are clearly separated as code quality enhancements.

Regards,
Honglei




