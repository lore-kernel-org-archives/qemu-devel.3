Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69428C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 09:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfyeZ-0003KW-Ao; Mon, 19 Aug 2024 05:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sfyeX-0003Jx-4n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:26:17 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sfyeR-0005El-N3
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724059572; x=1755595572;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hKAzPQH8vGwWAZ3ycmVSpuKZviJZ7glkdrjLxPSYXG4=;
 b=mXcpkCoszdu1GrXMr/ZTP8Q8vfHSRhpFqpMUTGdvobhO3aEe7jDkNs+W
 uYRbaoxYTOHSrke62OTiH6AN5kzLOEScnACahLcHWArcB67miiCLP1iRd
 fI9VKmyuyFI0J0Ot7nWalcdm3Qw1CvyrVMKq4Ax8ObbTQvHT7lFAbf6Aw
 ROqFD4aePSHhtpHJlu1B16WttuC4ZRhxqobNKvdb1jwfe7pABkiDCAoOH
 ys17L8py+zJOVvGmBlCm1KsbxaumjSvgc04Eo3pYPcoiOi4LZch1G+j44
 x99jr+HmJPr0m8+oMGuX+U5/ihyrvXuZrsY+5Zjg0ewRNgYUuatNNyOk5 A==;
X-CSE-ConnectionGUID: EKHMtSykS8mipD2GwmL1mg==
X-CSE-MsgGUID: ilYaa9KmQyWSwfKeJa8ipA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="26089025"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="26089025"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2024 02:26:02 -0700
X-CSE-ConnectionGUID: gPIVWHJiQMGaHNdNIhxRYA==
X-CSE-MsgGUID: EVlXssLEQtqLkrvRKdfHGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="60297562"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Aug 2024 02:25:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:25:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 02:25:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 02:25:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 02:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHZOmbewaJy+3o6KkiUMCmqXRtOqiUj0OrupS7+mXdNgL2/X0UeUvDJYErliA3nnwlaikV1PApM///2KUadpjZZHPtRsndeYAKXsMULvtMEZT9qK9xjvE2kzXiEguChAUNxyHop6FW7Teqn97cxpRcKQySUQ13alkn0O4+hym1JobBewzMatzyenMddTNjbmXpHZdw/EDzjOO5P1j937KRjKACWsjfJtczfY76agrgGgC87bc6AyCYi5qYf3+FkD9xXoHTQHVmYLJAZPrz6QmD9/1DvFzFwzRx2J4doCscoKsHTzDpqextE4ygCUxzIX8hJ1fkU98d0v6fQqnFv+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ6yyTNCSz+RobPdsQWOA7RtujGqPGFX4Fssf/k4MUs=;
 b=w3jHUq/kMn4QQpwD5HFCOY1OQVhmziRmFOocqr5K3/feTfYYE9VqsuNrNJVA7V47zQxlBAPsPqscoBfs4TYaPvPcWD42GSUQ1Or+q9XP7C1y7vnLXK/XSiQ5c/uLBDQMtAk0a38C821ueld7Y+rNlCCp2eq7IJKa87YlhwRfq5wWtrgaowbhXtqi6njVh7DMV2u2n1HxZ5QgEcFrOVW2V9tIXuTLv/3kVgF3YFhr8B6XYMkGusdqHurtf377v4+QB2t6MlI6NGKYXo9RYDmgPbr9Mb1+jY/0tZ8QN2umOZ4+JhB9qErofvullAEpzAqQ1cA2Iz8BPSYmhBwDUKxSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5918.namprd11.prod.outlook.com (2603:10b6:a03:42c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Mon, 19 Aug
 2024 09:25:52 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:25:51 +0000
Message-ID: <68c7f380-08c3-42ca-9cb8-db0368f92fc2@intel.com>
Date: Mon, 19 Aug 2024 17:30:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-17-zhenzhong.duan@intel.com>
 <9b2b2f76-a5ef-4378-b233-af1a44f742c7@intel.com>
 <SJ0PR11MB6744410546621C57CCF7D2E892802@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744410546621C57CCF7D2E892802@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: ae412161-77c9-49ff-f4f2-08dcc030eae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE1lcTYyc2Rmcyt6R0F3UEJpaHpTd05XRUtwcENFZlFjSEtObmp6d3ZXU291?=
 =?utf-8?B?eFhNZEFBSWVIOGJURHJjM1QyU2tzc3NHWHNHZHgvU2JXRmtqUmxNOEtsN3Fu?=
 =?utf-8?B?N0tWTkN0N28rS0svdE5mV3hiM3EwVkVNQ0Z3NUJuZEZwSkp4bDA1alpnamdT?=
 =?utf-8?B?UUxpMnZpWFZIcWVHeDlweEN2V05UTVhzM0pycEJYa0V3OG84Z0pNbU1ONStk?=
 =?utf-8?B?a2lVV1d4RzFxTFRRZExCTnNLYzVMaVpCQ0h5Y2EycmVMMXdPR0M3Z3BwTXNG?=
 =?utf-8?B?cXQ0b3phSzRHWEhTbS9qdWdkeE9aTFgvSUhWZ2VaZ05YZVZ4TytLL0IrUmNM?=
 =?utf-8?B?SC90NVpBV0FKVW9EL1JXK2ZmVytLdTJQaXB1NE45MjQyUWtnMmk2d2taZ0J2?=
 =?utf-8?B?L3BhdHNDVEpqUHd1RGFBQ3ZJUUJvSWtGTE1USW1qUU04ZVZ2ZUZnOVQyWjRu?=
 =?utf-8?B?dUwrVVZKTDR5NXNFUEk2cTFSa3JwTE15bVZGcjdZaGw3YmI5QkFBbFp4Smhu?=
 =?utf-8?B?bzU5WExMZTZBQ0cwWUZVNFhaWGZXaHYzdDBwQTVpV2JNUkdsWGNZcVdEZDN0?=
 =?utf-8?B?NlkzRFlJYkJvdGhJdjJzdU1nb0dyRGs3eTVUWERlbWtzYlp1c0JZNjRweTJs?=
 =?utf-8?B?RmlSQkxCNWlLM0NJY2RxbHNUSWVZUFFkaVdLdSsyREJrbDd1ZzNiakw0VmpO?=
 =?utf-8?B?UnZkYmxOMTY3MUt3V0M2WWRwT0hEMG5rR1BpRkdsNC9QajIwaytmZWR4c2dO?=
 =?utf-8?B?V2pyaVRjN21IZmlMNlpTbldTYVA3dUlnQVFwSXNIR3RWdnkyaWRvK2VCd3g4?=
 =?utf-8?B?M2VxckZMMDI5bGFvNTV6MjJwWTZaRTI5UDBpN2hUbHptaHcvOEJFNFlwN3dx?=
 =?utf-8?B?Uks4VmNNOFlXTDVnSnErVXN2SGxRdUpyVGxGeU52OVcwNWsxY2FMN05iNlVW?=
 =?utf-8?B?VWtRTklZQ0Y0S010MXgrT0ovS2ErY3hYMm56SmJBUUtIZmgxOTBYaTVCaUND?=
 =?utf-8?B?TE8wK2h5eGhMUlkyRUhUOUJnRDBSc21pV1Q4b1p0UnYybGNXWVJNYmNJYmhi?=
 =?utf-8?B?OEpIRG1ubVhab2YxV21VaFd3RS8yM3VFVEJEa08zendYUTNNQ3ZSd1M1ZTFm?=
 =?utf-8?B?aDhycG1rU0RYSkVqY2E0RUpreXdsQWpiZGZpQVcxenNTUUxzUjd6TldBZmpt?=
 =?utf-8?B?aWNZclBTT1N1OXRWMExJWTZ5Q2dWM0swKzVOM0RSb3VKT2E1YjRzaFlHSUZD?=
 =?utf-8?B?SVVkUXpvZkNBMGlrWFFxeXZ4Wkl4Ym1hVUxrK3ZhalB2eEZjLzhVODNYbXNK?=
 =?utf-8?B?Z2ZDOEZHOHdzVm5CcmRHa3BFUEZPUXpnRkN4NG5PcnlOT3dBeklkUDZLUkNX?=
 =?utf-8?B?UjZQcWNZV2ljR0JhMTd1bVp4Tm1mcnAwT3BvZzVJZkZ6Wm90Tit0dC92QzFq?=
 =?utf-8?B?S2Y5MjM1MnZwTWxxdUJqVnNLS002ZUM3QmdGTi8zd0pmRDR1aTF6MDFONEhK?=
 =?utf-8?B?YXJyeXUvbkl6K3BERm5EREZBVUVJb3hiQURtUVNRNmlDZWo4NmdzOVRMNnJP?=
 =?utf-8?B?SncxVGRpK0RiQ3cxYlJFVlp3M3k1ZWl2alBnWlhWbTduMGk0QUpGWmRKUnJF?=
 =?utf-8?B?Vlk4NUxDbEhSc3JXRnFQNnZHakZaUmtqaUZjc0RBdHJXUmkyd3o0MXFGQkhm?=
 =?utf-8?B?OTVvRGRFZko4aEF0czJ3a0gyVy8yUkV6b3hia0hPSUZPOTB3QjRzRWdZKzd5?=
 =?utf-8?Q?ULguSkqjFucqpgu+c4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNneVp1dm9oTWt6ZTBGQmFuSWNIUkJTaWUzY0I4TSsvMm9rQklqWC8xVm5m?=
 =?utf-8?B?UjAzdThHcTl5d3FObFQ3ajVheS9KdVA5NjEvTndIYm9vTXcwaGQ1RlNOTjIx?=
 =?utf-8?B?WDV4Lzd5MjdhNnRkWW9CdXM2K1ZlMlc3VmVwdnI3dGRwa1NWRVdoYmhSeW4z?=
 =?utf-8?B?ZnVFKzMyRHl4M2FrbGpVU1ZjTlJ0WnI2UjA3R0ZqTEZscENncFkwamwxYjEr?=
 =?utf-8?B?Wk8zcDRBK3Rta2IwQjI4U0lZMjlZcXNmWWZleWcxMlc3WCtUTjdpMGR6aFV5?=
 =?utf-8?B?VW9jZ2Z3am5rUlArK0ROUzJ6VVpxTjhvMnh3TGpDK3hIZHRZRmRQVWtGUGJx?=
 =?utf-8?B?RllLbnpzUExLbWZmRXdXWlRvcmJCN2pkTFhVVjV4c2ovOVhpbGx3bnlzNXR6?=
 =?utf-8?B?alhHeEdWVWJNYTJZVVU4MEpXd0pzK3JxbzdLMFlyWTlDWko1MzB4dHZHeEk1?=
 =?utf-8?B?TUZUdGtQT2JybWx0UHlSc0hYUXBGalB1dExDaGlxVWc2ejBSTW1ZRFZ5Zm9k?=
 =?utf-8?B?N1V2K05uQkNGQTZObFpLVGhKNWdKbld3dnA5VkNMclYzazJOejZKU015L2FC?=
 =?utf-8?B?WlZBRWduTklBYkZVaXlMYUFCUWFPT1p1Z1VSMHA5bE5UcE4zUlJpSjBMY1RI?=
 =?utf-8?B?YjFpVy9JVFZvZUhrS3dCb0M3VWMwVFNDbGM4UGpkNnViWE5IamtHdklDNTFa?=
 =?utf-8?B?ZVpLcmNnQnVuU29adUdkNTB2Yy9QbXlLR0Q0WnlSSk9KSDdpc3VvNnhuN2xo?=
 =?utf-8?B?UE1XT0lsWDB2VC9wZEd4NkxUSndXWEdxWHlHTHhDbnhYUkR6QmVXUW1rWXhp?=
 =?utf-8?B?T2d0OXlGdWxEdWxpUHZaaU1oaUJzTE82eGNWdHhZV05pd2cyd3d6Ui9KSzhV?=
 =?utf-8?B?akx4TXh3SWRtNXprYjI0UEsvbWE2WDI1Z3hlWXN5RXBjVmxTOEZkT010K1k3?=
 =?utf-8?B?Y0RlbjlDdnVmbFk4Qi9HOTgveGZYblNRbnErUXFablJJSWdkZ2ExNzF1Z0pu?=
 =?utf-8?B?N3ppSzVPWFdXQmNuS1ZSQTVwL3p6MEh5Y3JMUDhZRlhHZ3d1VlBtNmttS2Zp?=
 =?utf-8?B?bHBkTVNXMlNFMzZwRC9jSnJJcUFMVWd3eUY3N3JCT2xFZjErMkg4MU1TQUtt?=
 =?utf-8?B?TTAxM0J3Qm81bXVEZytHbkpUUXAwd3YxZkVnMi9OZVBIVmpaR3dHUmgwQjQ3?=
 =?utf-8?B?NTNiUURZWitaYUhQV0RnR3FCcjhydUpFQzhFSG9FVURCTjB2R0ZMQStuNGxX?=
 =?utf-8?B?REVDNDJZdHVVR25LRnE4V1dKMUY1aHJ5ZzRsS20rT2dnb085YjZjenFFNTZZ?=
 =?utf-8?B?cU9KRXkzWnJvMjhEWlo4WUhUWEpBZC84TTJZeGdGbnR4UFYzRU5xUEo1M3pz?=
 =?utf-8?B?QTB0LytDNUUrb3EyblorekpYVmIyV01CZ2xCS1VXaGh5NGpDVzRiMVdnSk4z?=
 =?utf-8?B?akdkQ2xZMUF4ZHo5RHZZejQ2VHFoTmIyQjlzWDFYay9XOUI2bHlOMC9HRTJv?=
 =?utf-8?B?cGxXTTBjakNwMUF0RzdDL1JTVHBuY0dDNXNiSHZFa2xaWTUzZmZzS0I2YVVS?=
 =?utf-8?B?MkttOXh1NmV5YWxMWE9LcmZaamF3V2RBRkZIblkraS9ITDRIaElZcjFVOG83?=
 =?utf-8?B?NlN3Z1psbHlEQ0drMjU2THUvanVNZTdqcmRlVUpWWUhrcUFmZzdteSsyZlNJ?=
 =?utf-8?B?VGlyb21JQjZvd09sQ1UvUWhkWEw0dDBWWTNhblpwMC81R2VTK2VsdFJrZ3Q5?=
 =?utf-8?B?emRUdjhIemFKOWwzM21uUEk0L3p3U2lhM2xpY3J5QmVmRlVEWVcxZTNDQnV2?=
 =?utf-8?B?bGhXcUJoZ2hjVFNmTUN6SXdaYmNZZ0Joc2FHODVMYzIzSlpHOUc0dzVZOWFE?=
 =?utf-8?B?VmdmYktzU04xeHF1bndKelFiRno2YWFGNFVWL1QzcDZURjE5K1JoUE9WeUV3?=
 =?utf-8?B?QXlUdWZYcUYrNWNTUW9DV0lqR3VMOWxBYmVXeXJJS3hqWnRWemNud1dLN1p5?=
 =?utf-8?B?VVBvdjMxbElrQW9HY1g2N3lMV29HWVRLNjV4cDc4RXd1ZnVkR3VpcThHSm9u?=
 =?utf-8?B?R0hoNEFjVElJNk5wbzF1aE0wK21raTZGWXJjcUN5UHBKczV6bFZTanZMcTBE?=
 =?utf-8?Q?llFhvnD0aB54EfPZavZjP7gv8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae412161-77c9-49ff-f4f2-08dcc030eae6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 09:25:51.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt2Et0vzScEFHw1CipKFiTQDfcFCSVo2JxFkzzTMDochpEhmOnc5J89go1Ox/sCLjeFgK81FlMR1NQTxCe8tKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5918
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/8/15 11:46, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to control
>> FS1GP cap bit setting
>>
>> On 2024/8/5 14:27, Zhenzhong Duan wrote:
>>> When host IOMMU doesn't support FS1GP but vIOMMU does, host
>> IOMMU
>>> can't translate stage-1 page table from guest correctly.
>>
>> this series is for emulated devices, so the above statement does not
>> belong to this series. Is there any other reason to have this option?
> 
> Good catch, will remove this comment.
> In fact, this patch is mainly for passthrough device where host IOMMU doesn't support fs1gp.

I see. To me, as long as the vIOMMU page walk logic supports 1GP large
pages, it's ok to report the FS1GP cap to VM. But it is still fine to
have this property to opt-out FS1GP if admin/orchestration layer(e.g. libvirt)
knows no hw iommu has this capability, so it is better to opt out it
before invoking QEMU.

Is this your motivation for this property?

>>
>>> Add a property x-cap-fs1gp for user to turn FS1GP off so that
>>> nested page table on host side works.
>>
>> I guess you would need to sync the FS1GP cap with host before reporting it
>> in vIOMMU when comes to support passthrough devices.
> 
> Yes, we already have this check, see https://github.com/yiliu1765/qemu/commit/b7ac7ce3a2e21eb1b3172743ee6f73e80fe67b3a

good to know it. :) Will you fail the VM if the device's iommu does not
support FS1GP or just mask out the FS1GP?

-- 
Regards,
Yi Liu

