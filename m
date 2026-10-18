Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F6CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRJe-0003FN-Fm; Sun, 18 Oct 2026 09:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xIRJc-0003FF-Ca
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:52:44 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xIRJa-0003cc-DY
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792331563; x=1823867563;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qISq5+FfI7pd+NMKMLU+SR6ySupg2yg+VBYrkcfH5PM=;
 b=ZGHr0MzLc8Td0132w3qKWwxWKof+dTm1j0clAL+lhr/WzQFcXat/pLpp
 VJktf5GX95LwAcoUF0C3SQ5iQArWwNju37jfDm/BI91pVK8BPOFnJlD+A
 XbjG1NK4s7ryQHL18vIccun2dq8GcjTy4/wJ5ZrAH7iLJA/NKtUv+ra1N
 yVuCNcGJx3imcqmvryp2nEoRbV9+GBLsWqFIV0AfkUjON6PooU30Hd3ZK
 C42iUcl3wUJC9Y8bPUWPli1MiWmqU1xYNg45huxTdYUqd+q8de770hAJj
 05rljpLgWdhEEeONyE36yyRG21ZK8JsuueRhvAmHSQCXrt8npMszKwZGH w==;
X-CSE-ConnectionGUID: mKmTvmqiTJOl9d8WA881sQ==
X-CSE-MsgGUID: ZwrfFCKvRwu2kZ+Ve6BvRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1055870"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="1055870"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 06:52:40 -0700
X-CSE-ConnectionGUID: zMBWgCiuROeF81MRohkX8Q==
X-CSE-MsgGUID: VRePakKeQo+X3IiNzb7Bew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2261410"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 06:52:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 06:52:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 18 Oct 2026 06:52:39 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 06:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHkPhUU0ZyfxfX7TDbdqkc9Et4sE6YlZbFL0sRQD/jHl0qCSkjGhLj8TK0XUL1NdEPNgSrZe+521qzhRyquU4h5TuKq0tako5FeIi7Xv3A73UE/CI4MtN0zjU2d+9YwPFXvaZPt1RrHks0BeVcTUHYl5oac8UJYa0imX7Wb1lf21sRenWK1TqSBUlflLMs9P2YqDZ+iTvU1kNn+Keds7gYl8ExBeV7rpgceQkc1W3HxzAa3irdNA7cdUWV3nT26UnK5rt+G0x6sTyL78FgWcfK/l5t/R4BBkij+wAVJLmSXV9vjt21vMd0rVo0Kjd8gRtguPr/sB45sPQpgQs8a0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/MopELyqq3iyP5O92rfaxzhHwWqizmSRhqVU7AXMEw=;
 b=H87jdQR/vXiS4yk1f+RDhlSZFg8hKqb5DR1ZEF997UtVWLqK5uJ+XX7FY97/xpc7CiqU6WV3sXDj+8u72ztUm7ogFYdwGJK8E6h3ly2jXiY0wjaJN9AiuwiL+ucxNqfxc25A3jsyGX6a+CKYz3kpWtiU1O02+lycUhMMfD9fVcmTqn+RKlEGlfxDElDwhwOlbeJzXqYUzZ1nNez+c0lMUeu4HYp4ql1HD6i1IAAS1OMqNAa7uQMl6lMe3XuI+rkw5403WZoMBTjyK+1g/2vwqXk9r0t+8YEzNwOGCuRK2YWJAzCByZaubRa8c3d2PXQGHSHlcHEM1hpaFUt/NrfQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 13:52:37 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 13:52:37 +0000
Message-ID: <bd3191df-1503-4caf-8b06-69e8a140268a@intel.com>
Date: Sun, 18 Oct 2026 22:00:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] intel_iommu_accel: Accept PRQ response for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20261009090737.3930000-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DM6PR11MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 904d5451-6c42-4f01-e0e2-08df2d1f1166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|42112799006|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SxvmQEwA+5wLyK17yT4DtXWJfXbiv94fsAwcFsIODv0cfsSA8YTqiNRc3x7QLJllN1wYrD2kbXFQIkavM6n5c/M0bea27BCxyjDSk0/2Zs7gKGWPJOm5OzlBLQzluwDDD8mN4NKhBmvT3AoCR1QoR9sA/Y2kSkMcu+/vIpl+vs/ld7fnEWU4GuW4AxuHTuxIpEBSZ/C4nllZ1nbeGUAxL4Lc+rufzRx+gxAad8mEUjPIpkhJnm6LdHrgYm48Aesz85rAVUOm99pdfChNiiHMZ7OuJPEIhayXm8KYtzorjzdy1cs0J9b3y3TD1T57hkvtMGp7mEA6jSE2ho90oZv45nbczLVH5HEsN1ur3BLHIxUGv9TGYz+FYgj/pM+zwWrZFhMFth2kCldqstrNuBqg60EKgvEijPnYkCgUvJcX2gNDtq5XGj4RD0lkS/bMqtlLzYtJ02wVgM/HLOiL9cRcEIYy7dTS3/C0/E7N9kxDqzFc5ZiAxLxDUxN/xRmHsD5g07xYh5d+At0twn4IgUoLFlRaHlaMiR5MyBD9ap6kIQ+2peBY6euChgEENx/Bp1Ga5DyCEIIov+G8sP6gFiLSjdeXX4htJm1lT9VWVekZnL/Ux2AGGGD+ZWEnSD4+to/wjOIgnuR069DUCSqeBeH0d77496YZ8gNUv3symrjIL2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(42112799006)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JnbG1waHQvVGJySTd6MXppc1Y1cXVWQktORGYwTnRTbysyeDc1UjRvYzAr?=
 =?utf-8?B?RjJ0RENFNFF6eS9xbjREVE95TmF2aWF6L2VMbWNIcFBsWnFwYU0wWmRia0ov?=
 =?utf-8?B?YU9hWndGYXJxc2lvdjl5YzJ3dTZOREtzdmxxNHV1S0RCZlV4aHplSHFDRCs4?=
 =?utf-8?B?a2NtMG5qS0xLWWlEbGZZYmg1QXg5RmpSQm1LbEgrdjM1azk0aytEc3RsYWxO?=
 =?utf-8?B?a1VXVnBxRUF5VFZRSFJZQmhNRW1ncHhzZ01lUVFrUnNwS0RzbHpjS09va1hV?=
 =?utf-8?B?aHRYMkdScFZITElXaG5zOFNpejk3ODhvU1FUTUJWVzVYTzB1R3J5cTNyYm5B?=
 =?utf-8?B?QjBuQmxHUHpYanBOTENocFVNd1RDNVV2b29kN0M3bTE4Vy8rV3hNSVVjUGNM?=
 =?utf-8?B?aE1MdXlrTHc0M1B4c0Vza2MxbC8vREtQRzd3MjVHMHRKTXVVVWJCbWJwRHZ4?=
 =?utf-8?B?VllpbzMyNG1aTnYySTJ0Nk40R0lzNFBHaUJoTm9Jalliem1jRCt6MnUwUFNH?=
 =?utf-8?B?VWNxc1R3WnlSNHdnUm02eHd6aEdMOE9iTU9oRlJRVlUvQXU3UG85aVZIakhT?=
 =?utf-8?B?S2ZiK2xHZTcxbENIL2pSL0wxd29MTmJ2QUdBREZXa1VBNlRZMzZOdGh6QUVn?=
 =?utf-8?B?SE0zT2JZVHdad0J6VEJpbVN4OWNXakJKSENIUlNkcFhhTFhiUUl0ZmJBWFFF?=
 =?utf-8?B?a1BqTUNNeVdLUnprQVM0UzhldThnUlg5aGMrRDdnV2pLbHc4ZmwxazBaWkI4?=
 =?utf-8?B?YXpRVjI4MUFlMHVxTFNEeU94Y1hVekVGK3hKZkZDL1B1NTRJd2cwSmsyWmFX?=
 =?utf-8?B?aGFkOUlRVndWQndaZkwvWnRObFVGZE54MjIzYmFyOUJ2K1dKU1g1MWp2WElM?=
 =?utf-8?B?SFRQaHlTMHYyNVM2K1VtRGhadDF5UnVtWCt0aVhWYngyekZtMWFxZ3VYWEVw?=
 =?utf-8?B?Y1RLUVhNM0dPNVd5NTZHaW5neXc0RG1uNytXWENtdVlLcFM2MFhvbi9ERGdY?=
 =?utf-8?B?NU1ZRVNTZmZidkVmVHF3Nzd4bGIyakYrcjNVdEpsZ09SOWhqM2daRzkyNk05?=
 =?utf-8?B?eFhaVTVjQ0xkY3V1R1oyRXhiWlZNaThjWktDeDNtUUw0WW9IUDBmbzBaTDFE?=
 =?utf-8?B?OE1ZTWRoQTZJQnUrczg1endyb3FCam84TW5ZamR2eDQwb2YyN0lmbVhKaWMw?=
 =?utf-8?B?MVlpQmxDQUZIcHl2cGZiR0F2aSszRzM1Q3p4QVZRMXJ0aDBsZVhPSjNBWFpt?=
 =?utf-8?B?VUVMSzFSYlZHMDJ4Ymp6RnNYMXJyZDBPTlZpRkZpVmRyWWNxbTYzWWlGaUlD?=
 =?utf-8?B?R2tDY0lCamxEL0Z6SWpBTzZhQWRFZ2YvQ05UaVZsY0JCaW1ES0tYekxHNmFJ?=
 =?utf-8?B?R3pWNVpWakNCcVJwRWZ6ZkE1cHROOVphdW9icng1Zi9vWldkRzYxTG42MjY2?=
 =?utf-8?B?RDh3VUZaT0VreG9rUWlSVmYvUVNJL3Rha3lFZlR3aTV0Y0ZmTHM2cVF3eUZE?=
 =?utf-8?B?UjE5UjNBN2ZvNHpyWm5kS2dsa2toRXZzcXJiTlp2eHhTUjk1VnJKTnhySnl5?=
 =?utf-8?B?QWdad3MxZDBOYUF2end5UGgwb2U2RGRuV0diMmwrdmkvM2c3Z0RGVktsK3VK?=
 =?utf-8?B?MEdWSVIvN0J4a3FhTytBOTBaVU9ReUpWNUs1b1pEcmo2ajcrR25KYWNEZTZL?=
 =?utf-8?B?QkdWeGFoWFVmVTNPTDNxK2VFWDRyUVVYUFVaWVZMdHFOaTJFR21JZzFUUmUr?=
 =?utf-8?B?bG9LUjQxQVh0cFZTa3FIaS9NcU1aQkR4eXp4Z0RqRmdRY1ByVkw0aWovUnl2?=
 =?utf-8?B?dVBCMHdUK2lwMzNlZUFaTXNNZk1MdUpienNPVlNUVWs0aXMxdWxiM2VuajFv?=
 =?utf-8?B?cEtSeU1SSGs1NHB1ZUg3NXpwWFlEK2cwQjhYVUhWNHgrUy9XL2RCTit5Qkxp?=
 =?utf-8?B?R1NwZmpHR28xSGcxbFRxRzk3NWtoZTJJU1F3dVExWHJZcUxHQXZIa3I5azlp?=
 =?utf-8?B?MW9HZE1wbmhCNE9XNURRdUJTZk5DMEp1RHQ4djJkZ2lQYmNocExNVFUxV1JQ?=
 =?utf-8?B?R1J1NS9Mam9VODlCdGFQSGlsd2UxV3JlNFEzUTQvMksxYVhIQkR2K2hLY1FQ?=
 =?utf-8?B?MjJMaXE1UzNNYWtpdjBUR2txYzBMNDNyeS9WRXlYUHBWSVVsTm5KMm5oM2ZL?=
 =?utf-8?B?clNRRm5zWXNlYU1JTnQ2NTgrZ09PSFFwcWNrNXN6dWd6a1dnNGxmN0FOYmRC?=
 =?utf-8?B?REhCUEJrM0czRWUwaXRTeEpINWdxemp2RXhndW0wa0t5TVY2U2VqeVZpWGM1?=
 =?utf-8?B?Sy9lTWs1RFpCSzFXS3hjTWFzWVVUdmp3UHRiQzRCVkMzeUg3KzRudz09?=
X-Exchange-RoutingPolicyChecked: 4qLxksJcMJInTh+Ni1nXKg8IPuodnlhP6fLBKLBG7umEcIUkz5Bhwu5Qo/Eq18RbcCzV9pARZux5fB45xoh/Ie7XO8LQIt1qA7ho5Jx+JUI04Vf2AUJHYuLqGmYrBJNKrFzAkT4rlHYnWyk1+qDz6lgvHHnGfAuW+JBD6rjlwi4Dq1Ney3TTfoglK0CTu8BmPvUKkYO23b6gv3rPsueNzcp9DRXV9KfU2XZCeKIsk99+OCev02te1ag4NjF/C6T1h6PTw/CnnAo4r1bORREvRguRZEUxQeThGQrrRUodSE6iYgYIbEqlZN7w3ADomkLlv0NbCo6Ko6g6iYsAldlK3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 904d5451-6c42-4f01-e0e2-08df2d1f1166
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 13:52:37.0210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRtWrmZ4XCZycJUxXwH7C8ATaeOCtfcPhwrTZLyXE5yxKWFZQnPcVdCsKfnv9rp9mqfVeL7+htnAO5siMUPuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 10/9/26 17:07, Zhenzhong Duan wrote:
> Propagate guest's PRQ response to host by writing to fault_fd.
> Create a new VTDPRQEntry to cache cookie for each fault group,
> this cookie is used to mark the fault group on host side.
> 
> If there is either PRQ overflow or full error condition, propagate
> a success response to host for LPIG request with the PRQ requests
> dropped. For other error conditions, propagate response of invalid
> request.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h   | 12 +++++
>   include/hw/i386/intel_iommu.h |  6 +++
>   hw/i386/intel_iommu.c         |  4 ++
>   hw/i386/intel_iommu_accel.c   | 99 ++++++++++++++++++++++++++++++++---
>   hw/i386/trace-events          |  1 +
>   5 files changed, 115 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index e0319749a5..0cc22b2cbb 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -20,6 +20,7 @@ typedef struct VTDAccelPASIDCacheEntry {
>       uint32_t fs_hwpt_id;
>       uint32_t fault_id;
>       int fault_fd;
> +    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> @@ -31,6 +32,9 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint64_t npages, bool ih);
>   void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_accel_pasid_cache_reset(IntelIOMMUState *s);
> +bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
> +                                             uint16_t rid, uint32_t pasid,
> +                                             IOMMUPRIResponse *response);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -69,6 +73,14 @@ static inline void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
>   {
>   }
>   
> +static inline
> +bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
> +                                             uint16_t rid, uint32_t pasid,
> +                                             IOMMUPRIResponse *response)
> +{
> +    return false;
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 1842ba5840..5d44eac0ed 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -100,6 +100,12 @@ typedef struct VTDPASIDCacheEntry {
>       bool valid;
>   } VTDPASIDCacheEntry;
>   
> +typedef struct VTDPRQEntry {
> +    uint32_t grpid;
> +    uint32_t cookie;
> +    QLIST_ENTRY(VTDPRQEntry) next;
> +} VTDPRQEntry;
> +
>   struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 81c53c6f5a..4c2347e7d2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3380,6 +3380,10 @@ static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
>           response.response_code = IOMMU_PRI_RESP_FAILURE;
>       }
>   
> +    if (vtd_accel_propagate_page_group_response(s, rid, pasid, &response)) {
> +        return true;
> +    }
> +
>       if (vtd_dev_as->pri_notifier) {
>           vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &response);
>       }
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 7baefe30cc..cd227315da 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -84,6 +84,62 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> +static void vtd_write_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                uint32_t cookie, uint32_t code)
> +{
> +    struct iommu_hwpt_page_response resp = {.cookie = cookie, .code = code};
> +    uint32_t id = vtd_pce->fault_id;
> +    int fd = vtd_pce->fault_fd;
> +    ssize_t bytes;
> +
> +    bytes = write(fd, &resp, sizeof(resp));
> +    trace_vtd_write_fs_faultq(id, fd, cookie, code, bytes);
> +    if (bytes < 0) {
> +        error_report_once("FAULTQ(id %u): write failed "
> +                          "[cookie 0x%x code 0x%x] (%m)", id, cookie, code);
> +    }
> +}

perhaps we can place vtd_write_fs_faultq() around vtd_read_fs_faultq().
Other parts LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> +static void vtd_prq_handle_pasid_response(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                          IOMMUPRIResponse *response)
> +{
> +    VTDPRQEntry *prqe, *tmp;
> +
> +    QLIST_FOREACH_SAFE(prqe, &vtd_pce->vtd_prq_list, next, tmp) {
> +        if (prqe->grpid != response->prgi) {
> +            continue;
> +        }
> +
> +        vtd_write_fs_faultq(vtd_pce, prqe->cookie, response->response_code);
> +
> +        QLIST_REMOVE(prqe, next);
> +        g_free(prqe);
> +        break;
> +    }
> +}
> +
> +bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
> +                                             uint16_t rid, uint32_t pasid,
> +                                             IOMMUPRIResponse *response)
> +{
> +    VTDAddressSpace *vtd_as = vtd_get_as_by_sid(s, rid);
> +    VTDAccelPASIDCacheEntry *vtd_pce;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +
> +    if (!vtd_hiod) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +        if (vtd_pce->pasid == pasid) {
> +            vtd_prq_handle_pasid_response(vtd_pce, response);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
>                                                struct iommu_hwpt_pgfault *fault,
>                                                unsigned cnt)
> @@ -94,14 +150,42 @@ static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
>   
>       for (; cnt--; fault++) {
>           bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
> +        int ret;
> +
> +        ret = vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
> +                                   vtd_hiod->devfn, pasid,
> +                                   fault->perm & IOMMU_PGFAULT_PERM_PRIV,
> +                                   fault->perm & IOMMU_PGFAULT_PERM_EXEC,
> +                                   fault->addr, last_page, fault->grpid,
> +                                   fault->perm & IOMMU_PGFAULT_PERM_READ,
> +                                   fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +        if (!last_page) {
> +            continue;
> +        }
> +
> +        if (!ret) {
> +            VTDPRQEntry *prqe = g_malloc0(sizeof(*prqe));
> +
> +            prqe->grpid = fault->grpid;
> +            prqe->cookie = fault->cookie;
> +            QLIST_INSERT_HEAD(&vtd_pce->vtd_prq_list, prqe, next);
> +            continue;
> +        }
>   
> -        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
> -                             vtd_hiod->devfn, pasid,
> -                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
> -                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
> -                             fault->addr, last_page, fault->grpid,
> -                             fault->perm & IOMMU_PGFAULT_PERM_READ,
> -                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +        /*
> +         * vt-d spec 7.4.1:
> +         *
> +         * Hardware generates page group response with code of success for
> +         * PRQ overflow and PRQ full, with code of invalid request for
> +         * other error conditions.
> +         */
> +        if (ret == -ENOSPC) {
> +            vtd_write_fs_faultq(vtd_pce, fault->cookie,
> +                                IOMMUFD_PAGE_RESP_SUCCESS);
> +        } else {
> +            vtd_write_fs_faultq(vtd_pce, fault->cookie,
> +                                IOMMUFD_PAGE_RESP_INVALID);
> +        }
>       }
>   }
>   
> @@ -433,6 +517,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       vtd_pce->pasid = pasid;
>       vtd_pce->pasid_entry = *pe;
>       vtd_pce->fault_fd = -1;
> +    QLIST_INIT(&vtd_pce->vtd_prq_list);
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   
>       if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index ad84d106a4..7bf4cddd38 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -78,6 +78,7 @@ vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int re
>   vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
>   vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   vtd_read_fs_faultq(uint32_t fault_id, uint32_t fault_fd, ssize_t ret) "fault_id %d fault_fd %d ret: %zd"
> +vtd_write_fs_faultq(uint32_t fault_id, uint32_t fault_fd, uint32_t cookie, uint32_t code, ssize_t ret) "fault_id %d fault_fd %d cookie %d code %d ret: %zd"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


