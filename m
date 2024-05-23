Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123BBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA52Z-0007gv-2H; Thu, 23 May 2024 05:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA52O-0007QP-Po
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:47:06 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA52L-0001DA-Ey
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716457621; x=1747993621;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=842D4JT9hWRiPHFc2NE4wCS4x5I7qKb6bBarHQsNDv8=;
 b=QktAvGDiF1COwdUXSVmpx2hV8+0JUAhtgLQSUW6/I5M/nsKxtZDqrjVT
 zCv5Q1GzOIPrwXrbOueLzDW4hmheX5fIGKpvdP1CxmfRxWdjFSq4nj8aO
 P6CERro3eaGhEa2hwFdoj1gepmY8CwYBHLMaf/9+h0wDwMmIeu/zZsdan
 fZb7zw6Zzk4pjzJeOtMHGq0AJI9478VQu5FrFObLHbdTdqrC3YEGKSibx
 X5iHywc0U19WA2njsvM7Sw+sUBkjG0rtWJ4ZKd+TRN/fxG3RchQY4CQ3u
 AblIuNbtN9lQInqKL+57RPzbo9crirPCuBToiV7OfEIVG0M4yIpmxtBU2 w==;
X-CSE-ConnectionGUID: hVa3DRRHRBCwMDLZ9jNxwA==
X-CSE-MsgGUID: 9e1pD9azQyujctRHdGbOpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23429906"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="23429906"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 02:46:58 -0700
X-CSE-ConnectionGUID: GAXdhjTKRcefaPagLjalJQ==
X-CSE-MsgGUID: 4l1rHh8pRLOq6vI99k08DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="33722550"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 02:46:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 02:46:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 02:46:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 02:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVOFvaFRr5Z6sNGxExx7Vh342bpyVhM5tc65vaFWUZYbKY1AaaU+oxtQ0CgG9oZbKsJFN1Q0WV4q9PJimkTmEqKtCyYv5gcNHZxyRC1FMFRIhrzRYAM7QC3Ly3LXDNggXs5jVBF6s+fENpFYNB6Q4Mz9L99R7xds0T/hYRIeLFCqSljLACy8sQ7YZAnBm6mCGs8Jp7PiwG+j6J7ZKXLPqokwHLVCYk5D+uL6jB7/UmmsrWbX+nhT7uzdlCmmLcCLQG4VS1e88j/KVQIz4lL7t3BlCvKRtBRDRoYrWJ65S/TPEKqA8FkO+wSyFccuEWKXAPrUp7+GHkEWikX3/xycPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=842D4JT9hWRiPHFc2NE4wCS4x5I7qKb6bBarHQsNDv8=;
 b=mNfrpMlnmNSGN7g8ZjfO3I85HOdN9TdqURVtNsq+sV5vjIrO3Yb7ICTNdhcCF0qRKIdKUgTxENMQPwJouEyHZNYyCVZmqY0VdZsFtH7HxE3jtozapGgMesVCdaKvQ0v7SlLUnH/0XRXzD8Zs0EnRpY0zFtnTtAN8mCpQQr54i/MPlwhJo1BzxhKUyq/ZtK7bxfZW8ZC1FmB+6kP52MGGzF+X0tIo42yA4WDN4plLwdxy1yamwO023hYIbzQ1a9NRxkXcw3UiPnN0QOcpUmPfqafx6u706yoa2WMezQ71AXCmfvlzfAE5JuNSQ37wLOXWO2Lu5TOtBd2plMUj9NFwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:46:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 09:46:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH rfcv2 17/17] tests/qtest: Add intel-iommu test
Thread-Topic: [PATCH rfcv2 17/17] tests/qtest: Add intel-iommu test
Thread-Index: AQHarBEbHFNzZao7rUarimlQWTaTNbGjM/+AgAFdkQA=
Date: Thu, 23 May 2024 09:46:55 +0000
Message-ID: <SJ0PR11MB67442CEAFEC7F1907AE8A36D92F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-18-zhenzhong.duan@intel.com>
 <74401a75-3c07-4370-88df-50e325f8930b@redhat.com>
In-Reply-To: <74401a75-3c07-4370-88df-50e325f8930b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6125:EE_
x-ms-office365-filtering-correlation-id: 52618201-b5a0-464e-12c3-08dc7b0d4833
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|366007|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?WTl0elF3OGx6T0hrZ0pGd2JqWjh1VHZob3ZxanYxNEFxMjE5NnlqeTdrb1JP?=
 =?utf-8?B?THN2UytPSWphNU1mYlM3M0o0Sk9Da3psaFFiK0ZJUlgyOEkvTTNpclhUa1ZK?=
 =?utf-8?B?Y243Nko0bUE0aTBHYkJWVkhoNklFaCszaEh0L0JWL09uVGprRGgrMmhHd1U3?=
 =?utf-8?B?WE1oQXNDUmVpSXdGK2MrVTZsaTY4RWY2cnJkdzM0aXBQeHhxTXExWVpWS0U0?=
 =?utf-8?B?NEZUWXhCZ3U4NWdRVlpmZWh4cEkxV0FJbUpicU4rWVJhTXZWL2lTOCtvcnd4?=
 =?utf-8?B?TGtaWE10RE1OOCt6VFZTN001WVM5VUwwUVhwQVBUY2hYUU05cjZ1SE5FbmtV?=
 =?utf-8?B?MDh0ZDZ2OE5rMmFqREJoTEZzaDRNQlk4eDJUWXdSaTV2ekxqRksyaUdzTXBH?=
 =?utf-8?B?VU1EVjA2cUdRalB1TzVWMGRNWGlxWEx6NmkwbUIrK0NUK2RJSFRTcldsb1Jx?=
 =?utf-8?B?N2hZemFXUFBCb3R2QkZucW05TUxKUEFTemZiMmpuUUxlNEt1UkpRa090T2Vi?=
 =?utf-8?B?YTRIcWtMOWlPaS9ua2RyRDlEL1R3K3VwTWwxN1EzUFJKV0grSHBuY1U0aTlw?=
 =?utf-8?B?Qk8yc3V1OTdTcnNxWWNBZ2Rva1ZQRm5XRk5xZHRPaW1nV1ZQTWphcXFEWkU2?=
 =?utf-8?B?ZHFCdmZNZUpCdEhFTmxCL2tTY0R1bzE5T00ramU4MkdScjI1WllQRVQrd2RH?=
 =?utf-8?B?QlFTVlU0emc5TFcwc3loSDZiREtVQTRlYWlJQ3F6RXVhUTZZa3RYM05FT0Y2?=
 =?utf-8?B?SE5nMVQ5Z1E5YXIxN0U2VjltWjdjd284SDkwNXZzR2dyR3VVclNrRmVmcXk0?=
 =?utf-8?B?eTJxM3doK1dSSENTM0x5RlJKYXJYK0hkUktTaGd0d25nemRweEMrVWZXSnA2?=
 =?utf-8?B?eDQyd3h1MDRxOWZybEtQeklLRm4vaFJyZ1V0bmRXVFlwWWRucVdVUHhXTzN5?=
 =?utf-8?B?NmUyUWxHMjNWb1A1QnYyczVFcnd4SjloZVBzZHVXNVZJWnBnYVVrZFJIQ3Zy?=
 =?utf-8?B?Q3R4a0tobHBPR3NiSUkzSnBkcU4zVFhUQmJEQ2dMdnB4TjFxUDg1ckZ1bEM0?=
 =?utf-8?B?WVBkeFJPVTNRWlZ1MVArUWUyNUlneWoxNlhGUkRnR2RzL2ltRlNBU29BK1VZ?=
 =?utf-8?B?a2IwcTdXL29ZWEQzN090RHROOTU1QkxBNWplb1RuOEhmanpPZmQrendvTS91?=
 =?utf-8?B?bTVjWmM2emRhWks5VHpTQ0NxL1JQajZDVW02V3BNbm5VU3gwTk91UFJ0SlpO?=
 =?utf-8?B?ZzdhS0tHT2JVVlg1a3BSeEhZL3V1ZWtDMWY5RnNZRHVvVlVPSVRiaXh1TDRL?=
 =?utf-8?B?YU9sVnlVM2I1RjlaVnNnN09yNlgvaE1VZHVVQTI5SFNvSmlReU9seEh4Y09O?=
 =?utf-8?B?WHdUSXRDSmdPNFNwQ2xyaGxRaVlLeGUwMjM2NU9uS0g1MURLd0htNTFFUlNp?=
 =?utf-8?B?QWJHYmw5N1pDL2dZbGlxd0lvbEdXRFUzN3JYRUVrbGVseFpyTGRzaU15dU9n?=
 =?utf-8?B?YnhNYW16OVE5R3QyZkR4eCtDdnprbVZGbHFxRGVRZnpnMGR3cUlBQnZ0Ri9z?=
 =?utf-8?B?WjRyZ3duYTFpVTBCay9kTnVpL0FXOHpzZ1lSTXRRUkJNNHJoVXFyaGhncU5F?=
 =?utf-8?B?YzBLSldtT29GV1M0eUtqeWs3eWFqRDZiOHFJeWtKeHJRT2tQY21KT3B4NzZz?=
 =?utf-8?B?QUc2bmUzUTE1K1V2R3NBTGloT3I2b0d5NVZiWGd6WHNSNlMwdmk4bkYydVlh?=
 =?utf-8?B?U3VIU2JIUzFqc3JHWWhkRGx5ME5LN0lveXRaSUp0cDl1NVlRcTNXODR0L3Iz?=
 =?utf-8?B?VFMzRnBxZEwvTmprMGpkZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2g4UjdkaTgrbDJvTUh2anJjblBYLzBtOUFMR2lLaTJHNHJrQmRINFNJVS9m?=
 =?utf-8?B?RkZ1MGQ3d2xFL2JZcjBTZ3ovdHE5Nnk4dGhDTDkwUVJXN0dYd0dtT3YwMHF0?=
 =?utf-8?B?R0svSEpmL2l5UDUyOVVLZ0ZEZnVyRFdtN21XLzB6bWFmdzhRVTV6MEZESXE3?=
 =?utf-8?B?bS9iWWlIekEyK0xXRE1RZFBBWFJtRjNBZ05QaWtUL3FYdHlmNklSSnF3dUxJ?=
 =?utf-8?B?dWtwQW9KODlaQUw2dzMwcWRFZEtjNUdOa1paMTIvYS8rRFFUZElQVndoNkdN?=
 =?utf-8?B?TGp2UnBwOWlmbkt0TG40K3lNYzIzSXJ6MTJTNW1ZWmhUbDQ1Z2NHd2xrVGl0?=
 =?utf-8?B?eGR2cVRUYWZ2OWpFdVlrRFJpbmZhdnNkTis4Q2ZncWFEKytMT1RaTTI2Z3du?=
 =?utf-8?B?dC9oNGFkV1hUNjBadWdraTU3TTNWOUxYNFEyZnRlWTRMcXVheGltbFdpVXVM?=
 =?utf-8?B?LzRZSGMybnR3Z1ZRRlp2NExtenE3bHVIVFp5NEIzbjVQTnM2NUZaZXhzZXVn?=
 =?utf-8?B?WWo1VUtvRDBmeWI3TEIvVWdQQTFUd291dUFIcHZwYytpSGs3QmVvTTZiajRi?=
 =?utf-8?B?L1VhQmlWNUtycXZxMWxUbWpNa091SzFrdkFCTnA1cm5xZ3AxakkwRE00RnJQ?=
 =?utf-8?B?UjlMWXYxOXJRQURXaW83ZjR5dlpGQTVRaXBqczVSb2J0dGR2bTNDL09XbkpH?=
 =?utf-8?B?akZjZitqM05BbytFeDFtaTByVjZPKzh4bExUVjJiWFExdzBzQXVVSkVaaFJM?=
 =?utf-8?B?YkpuZVhoSFBRWHFESWs1NndCTUZtRDFqa3dLS3ArVmVMSkxBL3lsblp3Rmth?=
 =?utf-8?B?TEpRM09BckZXUCtNd1o5QmdwYS9wbzBIQzBMZVBDdzdaSmhHRVIyeldEeUwv?=
 =?utf-8?B?N0wzWmdQNjk2SlZ6QytQcFNNa1JncVhvcnlpZTJmdEdITFJ4U052ZE5NVllX?=
 =?utf-8?B?NG9lMGsvdUlMdkFKcjZIK1BLQkt5cEloemNOYWJRNUlQaGNnODNYaGJaOEFE?=
 =?utf-8?B?SkVxcWVqc1V4UXBZQndTcUNHQXcwQnR3K2hENGxtY0dGSG9yaG9KNlkyVlN1?=
 =?utf-8?B?SXJZSDlQd0lNU0lKYkN4bEN5cWJwemswajlobVRvYk9nNk16QjlDeHBTbk5z?=
 =?utf-8?B?WE9nczBOWWNlbjJHWGRkZ2hvL0EwaTY4aWdkT0RKUG5YNlhyQ2U2QzI4Mncv?=
 =?utf-8?B?akxqcDNoNXlVTE9vRDNHQnVHQnl0ZnZaVnBsK2dQWndNWHFJU0pTYTIxVGZE?=
 =?utf-8?B?aEN3ckhDbnhNREsrcE9yYzk0eTlGaWV1eEw0QVN5dGFERG9hK0tOdkJRRUNp?=
 =?utf-8?B?SDc4aUNZMEEvN3o4UXNOaGpCTDRpanJlZ0laSWQzTUk5dHFGUzh3SUYxa2Nt?=
 =?utf-8?B?cHhPcENoMTlCU05OdFB5Qm1KL09RQ0tPeFgvc2hnb3pOWFp2a0g4S2ZEaitt?=
 =?utf-8?B?TmZCMHQwVzFnbGtleXpGRjVCdHl5MXVxZUZqUEZVSUhJdFU3clFoc2lMV01x?=
 =?utf-8?B?Q2JhcFVUSEt0NjhBNFR6ZGNCa2pybWx3dy9yRW90Uk03VnA3dVFrQXBYdXQ2?=
 =?utf-8?B?ajd2NjlKZ1grMGRaTWhBaHRsQktqa0FLV2Iwd3ZVSVVNNkh3QUovQlVGcjkx?=
 =?utf-8?B?Vzl4dkF1aHNnVUNIeXVGUnlSTVZkQkdyam1lRlcxMHpRRm1KTGcrZ0tjV3Ns?=
 =?utf-8?B?eXVrUkY3OFFvdXNXVUhoNllnV1VrVVJ5KysxTkJDQ1l0Q1Q5Q3htQXducGxx?=
 =?utf-8?B?cWI4Rk1XZjBTVm5UUGtOTlFPRm8xdFNnaXR2bHcvOUZiU0FyV2lBTGRNb29S?=
 =?utf-8?B?YjVtU3pNWUszZXhpUjNQVldody82bnVMZFZRa1RHQzc0K1NzeVlwbkpoR095?=
 =?utf-8?B?dlc2eUhFR0hCcTJDdEdRdmxHdFErKzFqeVE3VmxzVjFWdWVaN3FnVHBxZ2Zh?=
 =?utf-8?B?RW1DTmVGcWpBNFVyMi8xZjFua0g2U1RRamduWFo4aDZXM3drS2JKMjZvai80?=
 =?utf-8?B?N0g0L2J3cHdWczd1aXJpalZoUmM5V1U1UXdxZ29Fd2lyaFpvNWF0OTZFOGhP?=
 =?utf-8?B?cHBMcFVMODFQZjFSOUNqWXVrMThmL0tBdFArL1NqakNDU3JvYkVqS2E3R3Uz?=
 =?utf-8?Q?k/jxasMMkKqthoPuSi2Wy2y+N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52618201-b5a0-464e-12c3-08dc7b0d4833
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 09:46:55.5663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nmEVzrZbaJ5KqhDIIYqjQV2gzNWfS2HXBa9xuNpgwYxqUsHbfALk3t3HBKuL8f5Lx9frCDyrb3R+uou0w5wq61qO3I+uCwYroj+hyoXtTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFRob21hcyBIdXRoIDx0aHV0
aEByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjIgMTcvMTddIHRlc3RzL3F0
ZXN0OiBBZGQgaW50ZWwtaW9tbXUgdGVzdA0KPg0KPk9uIDIyLzA1LzIwMjQgMDguMjMsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4gQWRkIHRoZSBmcmFtZXdvcmsgdG8gdGVzdCB0aGUgaW50ZWwt
aW9tbXUgZGV2aWNlLg0KPj4NCj4+IEN1cnJlbnRseSBvbmx5IHRlc3RlZCBjYXAvZWNhcCBiaXRz
IGNvcnJlY3RuZXNzIGluIHNjYWxhYmxlDQo+PiBtb2Rlcm4gbW9kZS4gQWxzbyB0ZXN0ZWQgY2Fw
L2VjYXAgYml0cyBjb25zaXN0ZW5jeSBiZWZvcmUNCj4+IGFuZCBhZnRlciBzeXN0ZW0gcmVzZXQu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgfCAg
MSArDQo+PiAgIHRlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYyB8IDYzDQo+KysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAg
ICAgICAgfCAgMSArDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQ0KPj4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+IGluZGV4IDVkYWI2
MGJkMDQuLmYxZWY2MTI4YzggMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4gKysrIGIv
TUFJTlRBSU5FUlMNCj4+IEBAIC0zNjU2LDYgKzM2NTYsNyBAQCBTOiBTdXBwb3J0ZWQNCj4+ICAg
RjogaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiAgIEY6IGh3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPj4gICBGOiBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gK0Y6IHRl
c3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPj4NCj4+ICAgQU1ELVZpIEVtdWxhdGlvbg0K
Pj4gICBTOiBPcnBoYW4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10
ZXN0LmMgYi90ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi5lMTI3M2JjZTE0DQo+PiAtLS0gL2Rldi9udWxs
DQo+PiArKysgYi90ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMNCj4+IEBAIC0wLDAgKzEs
NjMgQEANCj4+ICsvKg0KPj4gKyAqIFFUZXN0IHRlc3RjYXNlIGZvciBpbnRlbC1pb21tdQ0KPj4g
KyAqDQo+PiArICogQ29weXJpZ2h0IChjKSAyMDI0IEludGVsLCBJbmMuDQo+PiArICoNCj4+ICsg
KiBBdXRob3I6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAr
ICoNCj4+ICsgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR1BMLCB2ZXJzaW9uIDIgb3INCj5sYXRlci4NCj4+ICsgKiBTZWUgdGhlIENPUFlJTkcgZmls
ZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVk
ZSAicWVtdS9vc2RlcC5oIg0KPj4gKyNpbmNsdWRlICJsaWJxdGVzdC1zaW5nbGUuaCINCj4NCj5J
dCdzIGEgbGl0dGxlIGJpdCBuaWNlciB0byB3cml0ZSBuZXcgdGVzdHMgd2l0aG91dCBsaWJxdGVz
dC1zaW5nbGUuaCAoZS5nLg0KPmluIGNhc2UgeW91IGV2ZXIgYWRkIG1pZ3JhdGlvbiB0ZXN0cyBs
YXRlciwgeW91IG11c3Qgbm90IHVzZSBhbnl0aGluZyB0aGF0DQo+dXNlcyBhIGdsb2JhbCBzdGF0
ZSksIHNvIEknZCByZWNvbW1lbmQgdG8gdXNlICJxdHMgPSBxdGVzdF9pbml0KC4uLikiDQo+aW5z
dGVhZCBvZiBxdGVzdF9zdGFydCguLi4pIGFuZCB0aGVuIHRvIHVzZSB0aGUgZnVuY3Rpb25zIHdp
dGggdGhlICJxdGVzdF8iDQo+cHJlZml4IGluc3RlYWQgb2YgdGhlIG90aGVyIGZ1bmN0aW9ucyBm
cm9tIGxpYnF0ZXN0LXNpbmdsZS5oIC4uLiBidXQgaXQncw0KPm9ubHkgYSByZWNvbW1lbmRhdGlv
biwgdXAgdG8geW91IHdoZXRoZXIgeW91IHdhbnQgdG8gcmVzcGluIHlvdXIgcGF0Y2gNCj53aXRo
DQo+aXQgb3Igbm90Lg0KDQpHb3QgaXQsIEknbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0K
Pg0KPkFueXdheToNCj5BY2tlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+DQo+
DQo+RG8geW91IHdhbnQgbWUgdG8gcGljayB0aGlzIHVwIHRocm91Z2ggdGhlIHF0ZXN0IHRyZWUs
IG9yIHNoYWxsIHRoaXMgZ28NCj50aHJvdWdoIHNvbWUgeDg2LXJlbGF0ZWQgdHJlZSBpbnN0ZWFk
Pw0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gb3RoZXIgZnVuY3Rpb25hbCBwYXRjaGVzIGluIHRo
aXMgc2VyaWVzLA0KU28gbWF5YmUgZ29pbmcgdGhyb3VnaCB4ODYtcmVsYXRlZCB0cmVlIHdpdGgg
b3RoZXJzIGlzIGJldHRlci4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

