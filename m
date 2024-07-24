Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D270FC3DA70
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWVAL-0006mt-AL; Wed, 24 Jul 2024 02:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWVAH-0006m3-1E
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:07:54 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sWVAD-00052T-PR
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721801270; x=1753337270;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nMDQWLcW1pk18/M2eZIgirwpY5VNK7P+oUNyfvlLlSk=;
 b=UU+NOc2bE7NSSpMz1Imh1Ldum4PkiNeXsvdKM0U6qZLg2bnfwhmxEqin
 XuHlEauhwflKQyZ4VhNq6Csv1kuoi3ZdR2YuTVFpZTqUfkKJacwuO8ZaH
 M0t5DnyNxMAqys2wkoL7YJcyYnh4XDR+Mn0xH0hPxUFwayS6lVXfJ93uN
 DWfEpZHLsPRQBnic8uLdnNe0MwS3Kj/Js7diraU8fAI4wCQGy+JcSwt9i
 SUqPLgMfdsEIaMIxyOCR2nmv40R4RWSgCi/Pr+72+ZKKN//oQ+GS7SHQ5
 KQv3s/LhvgVquRoh5NV/3D9I+oATP8f8GubYWtO/fSEaid30ec58g9Fn4 w==;
X-CSE-ConnectionGUID: dcunAQ4/T1+rZ0MNp+8rbg==
X-CSE-MsgGUID: kL1k/sKBTnKAd+08NKUawA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19420781"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="19420781"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 23:07:46 -0700
X-CSE-ConnectionGUID: GEP1krPIS4i/hRNJyHGDqg==
X-CSE-MsgGUID: atSJea1WRwCfdS4d12aQgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; d="scan'208";a="57287442"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 23:07:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 23:07:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 23:07:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 23:07:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 23:07:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxVVtf6hIbNSMwNcAiaF1UN6Y7G2+23DXhWU3PhEdD98AWQl7dOWfmExv+DS4ISBLSKo9eLgw1jSS4GzDqsplW1MO6eDaD9RKiMX96dO5ulRiWIimxJd9rqtZZOJYto7rRjXvkK0VJuPucekoe5xa4aaXRvCMp6ldzdyQVeTdvcaYTULPGGl6Xn8EESmqo5Hb8a+LU4axilBriECXsNoRzi2cQ9t5P5fHg3tOYn+0qrLAiRfxHo5wLZ2m1eogGCpv6fNGuJcHTwJ8X+FfFtzUV1hBoseLPHDZ8CpUjJeB/UCSdcUP3FOn9PjE9oC8cBGHopqWzV33HowO4fWOOOyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMDQWLcW1pk18/M2eZIgirwpY5VNK7P+oUNyfvlLlSk=;
 b=d0TTPWS/0zUS3vX92a0MoFoAuy02v3msWSvtHsIdfd/DP1yKGZOcHNHU4DmJxhhFjVCo9iJTgGXfjHgshgpPXsarcjVxZH+eYfy2Oto7ZNSjz0YDoJrdUSWbWq0fYypewyLteFq7MykaBGhL0XvYWKUioO6dbDF5yz530SDTw+cyzEk5SJQ3eKdNUgHZoPP1URIM7E8afwz2/cWP8YnxiNi7YHy2XlE13Xy/hh7qnazZ/PVYN+17NCFowRBRwmW3seILxJvl3fRSNHmibbLYPsu3QuRm3hrTpMZaL/G2HVg6k9yT7xtZNHOlmWwAjgbWoMXK20lew3GazLCGXVMXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7197.namprd11.prod.outlook.com (2603:10b6:208:41a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 24 Jul
 2024 06:07:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 06:07:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHa2OtpJZ2tSW4s+kGYFT4r3bq0YLIFZ4OAgAAFUYCAAABYIA==
Date: Wed, 24 Jul 2024 06:07:36 +0000
Message-ID: <SJ0PR11MB67449812034F2086F97B3E0A92AA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-15-zhenzhong.duan@intel.com>
 <700f34b1-d020-4a1f-86d0-878a0628cc5e@eviden.com>
 <dd6cf2fc-a18d-4730-a351-be4057b6fb31@eviden.com>
In-Reply-To: <dd6cf2fc-a18d-4730-a351-be4057b6fb31@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7197:EE_
x-ms-office365-filtering-correlation-id: 7cca2da2-3161-481e-9216-08dcaba6eab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?akRyUkFFZFFVSGR4U2tFajZoSVJzSnBWM2FzbGhIQWpTQnRuMG42UnNyTEw0?=
 =?utf-8?B?UFhCUmZ1eXpQQlJiNFJGYytwV2R0dlV1Z0tZL3hobW1rRU8wazNpSjM4a1JK?=
 =?utf-8?B?NFluZzQ5TmtEWE53Ukk1WFZ4WnR1dWVnVjFPd3habWovc3N5RWdNYnJaeTdF?=
 =?utf-8?B?VnRyUGNxdm11OE5vZHdoeS82VWUzblpsbG9FTVBkd2NOMEtLa3ZrQmtHZFkw?=
 =?utf-8?B?Wm1zTGFZM0laQ3N5cVFaWW5VYXJMUXl3c255b2RsYStkdk9iVEVPVXI4RFlU?=
 =?utf-8?B?SE0vdEJ3SmZvcENGUUdvME82RmRSZzBsbWNCOG5LNmhhTEdtVk1MNk5vRXRW?=
 =?utf-8?B?WGg0VXgvakM4ckNLZjY1SldPaVc3a1RGbHZOaG5DdkloSWhidG00RlZ3aHhm?=
 =?utf-8?B?N2ZySlpaTVc5QzJMV3R6cFBGa2UycVpTanplWkZYS3lsMmdkZEYwRGRZSFNG?=
 =?utf-8?B?N0t1b0lqQ1VBbDZvS0UwL1NjNFE4YVAxTzh0ck93dlBCWHdiTmZlNnphQTFW?=
 =?utf-8?B?RGlYdUt0SWJjYUtsbkxrQy9adEdKOVl6dU1FRlIwUEs1M3VrUVg2SEMrNmdS?=
 =?utf-8?B?QzVVTGJvMm16KzM1NE5KdSs0c09ZV2tsSkVsSUVJTTBrTjNub0tmOWVUKzBr?=
 =?utf-8?B?c1R2RXpqT3k1RUFyaFFWWmlKNERKWDk5bTZzMlVtTHlEMno3bTZhSFNMWnRn?=
 =?utf-8?B?T1NSUHhHbFBrRE5sUVZHTlllK3N5Sm5uMFVNSzRmczlOR0NrN2FoWFh3SnNE?=
 =?utf-8?B?c1p4bVpEazB1dTFDRnFHOXdaeG9ISEEycVdLZW5JeFFFbzIxOWdyTzB3dkFo?=
 =?utf-8?B?V1JlOEhLQlg3SHh1RmxsSUtLaldpOW1YNzAzREZyUCsvaHg2RHhUYytXcUlj?=
 =?utf-8?B?KzE3ZVREK3JjNE9QanVvZm1JUzREVG5vd1U5R2RrWTNsVEFvRkFnQ0hrK05q?=
 =?utf-8?B?TEZMcVJWWWdNeXB2TjAzN01qT0tRbjYrWE5GQ095eUY0VTlNd1NCUzI2QjJQ?=
 =?utf-8?B?cHBLcm1HZXI4VnYvb01uTHRFWG5KY1kzK1dBNDM0UTkvVDIvTHB0cjZwNHBK?=
 =?utf-8?B?VTFlWWg2Q1RKK0JzYW9HUnhzQWQ1KzR4UlE3MzVadzZHcCtydXlPZHdzWE5T?=
 =?utf-8?B?K1l3a1g3R0hFMGE2YXc3Y3hrZjhsdEhOZ2RkVlNZSVg0QVhsUDhFNWNFd05S?=
 =?utf-8?B?Y0MycDNrZ2Z4YlhFejYxcWc2KzhvZ0t2UExyOGJJdHpHbVFOMCtKTE9zaS9z?=
 =?utf-8?B?MzZQejdGNGNpSTN1R1FvaFZwQW02VXVISmxoSVhDUVk5My9HN3pOdkFPQVpj?=
 =?utf-8?B?TVB2akkwWmM2b2hxeVc0aDRGUUM5U0wxMFZNR205YTk5VWZpNTMzSWcyeG9W?=
 =?utf-8?B?cDF2WXNkaE82d0ZHQ1hyRHpvNDBCL3RrU3JFQ294WlMrZ2NFYm5QVlhaTzRX?=
 =?utf-8?B?VWFBRkZmaXA5VVFCdDdMM1BTZ09nQnlaOVFaUDY0V0FsSHgzRFVIZzhPNzAw?=
 =?utf-8?B?c3RZaCs2UWtUeldKOXJyTWJZNDhFRTRBdklGSjBsZTBXM0hQOWlJeVBjTTdh?=
 =?utf-8?B?c1d6OGVTK2g0eWdBN1VVYWtFd3RkVnlnekZPc1ZhdFFQMzZqS0MwVzduWi9o?=
 =?utf-8?B?MXoyLzF1WnByeU03NUNZa3FIaWt5ME9XaFd4T3FTd0w3NkIza0VneVNtcExM?=
 =?utf-8?B?ZkdVaFc1Yy9sVVZ1RzZ6TFE5Sm1HYjhCTkRJc0R4SWJ3bG1OcExybWhaeXp5?=
 =?utf-8?B?Tkh2ZkVWcDV6UEU0a2dTSHdOU0ZqWFB3MnA2RVhHVXA3SFhpeERLTjZlSzdw?=
 =?utf-8?B?ejg4ZVE2VFBNZldqOG1IZURWNUtoYUNmS1B1aktNOU16RHkydCtzV2NFOCtp?=
 =?utf-8?B?R2NUV3pVK3RFOFpIcmJZcXJrUzY0Q1FUODhkQ241MTZxSEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk80M0R1Qm16UHF4VkpDOEcwc1AwWG9tSE9Rc1hTNUhQUENORmhDRkpLODZa?=
 =?utf-8?B?M1pJRy9aTDBGd1pOQ29Cc2xoM1dxTlNBSTFxMFQ2VWlUUHRqT1dkM1F1Wllo?=
 =?utf-8?B?WTVmcjlRSGFCbTlGbGFpOXlBYW5RcFJVUG1UeVlnNTRyVU1mYUdJRE1Ya1Vx?=
 =?utf-8?B?a2RRN3dqWjR4eDZVZmt3Ukd4Sk51TktEekxqRDlpSkV0ZmE1aXYxZDdJVm44?=
 =?utf-8?B?Y3lOSWFyYnk4clZCdW1YZFBudGhYbCtuQS9oS2VZQWR6N0NPUDNXSVlzQW9B?=
 =?utf-8?B?bVVUWUdVR1BZWUtSN1ArdUFJVFBScEZKd0JKeG9MT1pxOHFZVXVzZ0thYTFS?=
 =?utf-8?B?M09oZUYraDlCSmRQcEYwSE5WcGVPR1VxZ1JIb3A5NXhqT0V2QkpJOWhHTzd2?=
 =?utf-8?B?ZDh1QnEwc1JOelJGNVQ2dmYrVU1lZHVlOXc0QUNUSTlLUyt6dGM0STVIVE1y?=
 =?utf-8?B?SzZRKytVTDd6Qyt0cHNDTzNmalBpdHU3Vm5yYXlsZjhxRG43aGFGQW01Z0Iz?=
 =?utf-8?B?TFY5Z2daaEJXS3phVHFNbjJkYms5Zk5qcjk3VzRVR0pVRHBTaEt1U0Y3QlZT?=
 =?utf-8?B?SEgwSDhLUW80RmN5dWJYdU9adzZyMTdoSFNLS1FHUVFvb0xmWWpJSzlPdGkr?=
 =?utf-8?B?Q1YwRUJkdjBPVlBvOVBEK3ZKNi80WStoRHJWWXk0Z3pjVnBQdWIvYXZlK1A2?=
 =?utf-8?B?Zlo2bFNCOElQa2s5YUFNWW5ZUnpvZEFjSmE1NStjRUpqNXdYd1FjNS9XaVQz?=
 =?utf-8?B?SEtCd3l6OXFocmUxOG5NczVlZVAwUGU2QTVFYWlNMWJqejAyemZlTFU3L3pm?=
 =?utf-8?B?aFdLOFZIYnBqdXVqdjBGaHRIaDdmcWFXNWxyUlBSSzVqK2czZ2xSek9xYzhy?=
 =?utf-8?B?UlZiSlZqc3lvZ2RGY2MzdWFYRU1nWHJnSkFndHFrTGpnWHVIYVMvVmRNZWlr?=
 =?utf-8?B?VFQxN3ZGc0JxSFNGazdSSXU3aFZYQmV4RFMvOEdGOWF4Umc4RVpDR2tScnI3?=
 =?utf-8?B?V2FMV1dhV0NJSUh0RG1ldmhna01DSFRvQm4wUERHZjg4aXJ5eDRDSmE5ZkNv?=
 =?utf-8?B?T0pOYXF5SXgveU9NaWsvY3VMd0U5dGxGOTR4Yk9kQWlFNnNKWDJoYy9KVkFD?=
 =?utf-8?B?OC9kZDZBTXJGVnZPNGNPeFZ1N09IZ1Y2MjVOekorNTM5UjhHYmFnRUZiYks2?=
 =?utf-8?B?UUV3em11YndlZm9RME1WS0FaR1RTVUNjZmI4cW9DTlRsS0lmb2hweUtxY1Fk?=
 =?utf-8?B?OG9WS2ZFbVVFZ3ZyT2xKL3lmdUNqZlQ2MC92NjNNT0d4SVBReHo0bjgvMEk2?=
 =?utf-8?B?ZSt1Q3ZONWYzbjZFK1k1b29JUXduZStxV1hQTVZIVm9NUnBBemozTDNOeU5B?=
 =?utf-8?B?ZWhyR0RxMzU3MHk5YUdmbTAvVy84S1o5N2tiSjVLZkt3bGpTRmcvVU8vK0xB?=
 =?utf-8?B?U2FFZ2V5ZXVJZTUyNVAxdDZNa21wVW5ROTJLMUFQcE1MUnlyNlZlcUVjbHMv?=
 =?utf-8?B?VElnME1GMHNrSURMOCtBSlJxTDBSdGRIY2pGS0RXbGVjdnZVbDd1cFY4ZEZQ?=
 =?utf-8?B?ZmROMzZXMWh2alVtL2diVkRqeXlCejJhUjRsUk5kUGdickh3U3BvbXFVcW5K?=
 =?utf-8?B?eVpPL3VaaU9zREpkeXdwNEx4WStrY3pta1FKblZxNUphcEVYMmVKT1dmVnVt?=
 =?utf-8?B?NVRmNXd3Y1VEODViMmNaQkU1YmhTZ0I5eXpldlZSd1F1eW5hTW4zUitwbXRi?=
 =?utf-8?B?enI3SVRydGtiSW5mWEZzZGVmbDJpaGVrMThhdjhVMGR0T2dQY1hIVjdIdHNQ?=
 =?utf-8?B?Z1ZLc3I0L1FKaWFzQzIzWGZmbU8yY05ob05HQk1icHZUdHgxWDlDeDBiVGVG?=
 =?utf-8?B?MWZhdHhtdmRWMXBlMzJZQUtJMjlRZTd2cmRUYUphek0zeUJ3eXgzd1ZOWWdv?=
 =?utf-8?B?a1RsNVJ5WFMzQjlpU29qNXAyS0FRY1cvb0VhZ3drQWZBU3NuZHp2cHZ5bjZy?=
 =?utf-8?B?RzZiUW45UVlFZ1dYU1gwVU4yOUd5eUt6V1hxRmtCSXRNeHp5VitReWo2dXkr?=
 =?utf-8?B?UlJXUDJmdVc4eDFVYlVibVV0WmxLUHQ2R3kzWGswcElwSldqWVFnYWh0M0dz?=
 =?utf-8?Q?O+cHyR6MPUIdCWhi0PgW46px9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cca2da2-3161-481e-9216-08dcaba6eab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:07:36.9986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lChcJtpcQ6hdSEKzNsdS2kQwNdsLKk6bFu5uJtlVVB2ukLyfI4mAVYXl8gnru442oypmmaHF9aaS9TErqyvSo4tAkfz/mhtGrWU4yR0JvmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7197
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAxNC8xN10gaW50ZWxfaW9tbXU6IHBpb3RsYiBpbnZhbGlkYXRpb24gc2hvdWxkDQo+
bm90aWZ5IHVubWFwDQo+DQo+DQo+DQo+T24gMjQvMDcvMjAyNCAwNzo0NSwgQ0xFTUVOVCBNQVRI
SUVVLS1EUklGIHdyb3RlOg0KPj4gTWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGJ1dCB3aHkg
ZG8gd2UgaW52YWxpZGF0ZSBkZXZpY2UgSU9UTEINCj4+IHVwb24gcGlvdGxiIHJlY2VpcHQgb2Yg
YSByZWd1bGFyIElPVExCIGludiBkZXNjPw0KPj4gSSBkb24ndCBnZXQgd2h5IHdlIGRvbid0IHdh
aXQgZm9yIGEgZGV2aWNlIElPVExCIGludiBkZXNjPw0KPkkgdGhvdWdodCB5b3Ugd2VyZSBwbGFu
bmluZyB0byByZW1vdmUgdGhhdCBhZnRlciB0aGUgbGFzdCByZmMgdmVyc2lvbg0KDQpMb29rIGF0
IHZ0ZF9pb3RsYl9wYWdlX2ludmFsaWRhdGUoKSwgaXQgaGFzIHNhbWUgb3BlcmF0aW9uLg0KUmVh
c29uIGlzIGV2ZW4gaWYgd2UgZG9uJ3QgZW5hYmxlIGRldmljZSBJT1RMQiwgZGV2aWNlcyBzdWNo
IGFzIHZob3N0IG1heSBzdGlsbCBjYWNoZXMgSU9UTEIgZW50cmllcy4gU28gd2UgbmVlZCB0byBm
bHVzaCB0aG9zZSBzdGFsZSBJT1RMQiBlbnRyaWVzIGluIHRoaXMgY2FzZS4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg0KPj4NCj4+IE9uIDE4LzA3LzIwMjQgMTA6MTYsIFpoZW56aG9uZyBEdWFuIHdy
b3RlOg0KPj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50
cyBvciBjbGljayBsaW5rcywgdW5sZXNzDQo+dGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24g
c2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+DQo+Pj4NCj4+PiBU
aGlzIGlzIHVzZWQgYnkgc29tZSBlbXVsYXRlZCBkZXZpY2VzIHdoaWNoIGNhY2hlcyBhZGRyZXNz
DQo+Pj4gdHJhbnNsYXRpb24gcmVzdWx0LiBXaGVuIHBpb3RsYiBpbnZhbGlkYXRpb24gaXNzdWVk
IGluIGd1ZXN0LA0KPj4+IHRob3NlIGNhY2hlcyBzaG91bGQgYmUgcmVmcmVzaGVkLg0KPj4+DQo+
Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+PiAtLS0NCj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAzNQ0KPisrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+PiBpbmRleCA4YjY2ZDZjZmE1
Li5jMDExNjQ5N2IxIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+IEBAIC0yOTEwLDcgKzI5MTAsNyBAQCBz
dGF0aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUg
KnMsDQo+Pj4gICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4+ICAgICAgICAgICAgICAg
IH0NCj4+Pg0KPj4+IC0gICAgICAgICAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+
ICsgICAgICAgICAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybiB8fCAhdnRkX2FzX2hhc19tYXBf
bm90aWZpZXIodnRkX2FzKSkgew0KPj4+ICAgICAgICAgICAgICAgICAgICB2dGRfYWRkcmVzc19z
cGFjZV9zeW5jKHZ0ZF9hcyk7DQo+Pj4gICAgICAgICAgICAgICAgfQ0KPj4+ICAgICAgICAgICAg
fQ0KPj4+IEBAIC0yOTIyLDYgKzI5MjIsOSBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFn
ZV9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3QgZG9tYWluX2lkLA0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaWgpDQo+Pj4g
ICAgew0KPj4+ICAgICAgICBWVERJT1RMQlBhZ2VJbnZJbmZvIGluZm87DQo+Pj4gKyAgICBWVERB
ZGRyZXNzU3BhY2UgKnZ0ZF9hczsNCj4+PiArICAgIFZURENvbnRleHRFbnRyeSBjZTsNCj4+PiAr
ICAgIGh3YWRkciBzaXplID0gKDEgPDwgYW0pICogVlREX1BBR0VfU0laRTsNCj4+Pg0KPj4+ICAg
ICAgICBpbmZvLmRvbWFpbl9pZCA9IGRvbWFpbl9pZDsNCj4+PiAgICAgICAgaW5mby5wYXNpZCA9
IHBhc2lkOw0KPj4+IEBAIC0yOTMyLDYgKzI5MzUsMzYgQEAgc3RhdGljIHZvaWQNCj52dGRfcGlv
dGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9p
ZCwNCj4+PiAgICAgICAgZ19oYXNoX3RhYmxlX2ZvcmVhY2hfcmVtb3ZlKHMtPmlvdGxiLA0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnRkX2hhc2hfcmVtb3ZlX2J5X3Bh
Z2VfcGlvdGxiLCAmaW5mbyk7DQo+Pj4gICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+Pj4g
Kw0KPj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZzLT52dGRfYXNfd2l0aF9ub3RpZmll
cnMsIG5leHQpIHsNCj4+PiArICAgICAgICBpZiAoIXZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShz
LCBwY2lfYnVzX251bSh2dGRfYXMtPmJ1cyksDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0KPj4+ICsgICAgICAgICAgICBk
b21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2dGRfYXMtPnBhc2lkKSkgew0K
Pj4+ICsgICAgICAgICAgICB1aW50MzJfdCByaWQycGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJ
RCgmY2UpOw0KPj4+ICsgICAgICAgICAgICBJT01NVVRMQkV2ZW50IGV2ZW50Ow0KPj4+ICsNCj4+
PiArICAgICAgICAgICAgaWYgKCh2dGRfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNp
ZCAhPSByaWQycGFzaWQpICYmDQo+Pj4gKyAgICAgICAgICAgICAgICB2dGRfYXMtPnBhc2lkICE9
IHBhc2lkKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+PiArICAgICAgICAg
ICAgfQ0KPj4+ICsNCj4+PiArICAgICAgICAgICAgLyoNCj4+PiArICAgICAgICAgICAgICogUGFn
ZS1TZWxlY3RpdmUtd2l0aGluLVBBU0lEIFBBU0lELWJhc2VkLUlPVExCIEludmFsaWRhdGlvbg0K
Pj4+ICsgICAgICAgICAgICAgKiBkb2VzIG5vdCBmbHVzaCBzdGFnZS0yIGVudHJpZXMuIFNlZSBz
cGVjIHNlY3Rpb24gNi41LjIuNA0KPj4+ICsgICAgICAgICAgICAgKi8NCj4+PiArICAgICAgICAg
ICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+PiArICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPj4+ICsgICAgICAgICAgICB9DQo+Pj4gKw0KPj4+ICsgICAgICAgICAgICBldmVudC50
eXBlID0gSU9NTVVfTk9USUZJRVJfVU5NQVA7DQo+Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5
LnRhcmdldF9hcyA9ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+PiArICAgICAgICAgICAgZXZl
bnQuZW50cnkuaW92YSA9IGFkZHI7DQo+Pj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBlcm0g
PSBJT01NVV9OT05FOw0KPj4+ICsgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBz
aXplIC0gMTsNCj4+PiArICAgICAgICAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0g
MDsNCj4+PiArICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9hcy0+
aW9tbXUsIDAsIGV2ZW50KTsNCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICB9DQo+Pj4gICAgfQ0K
Pj4+DQo+Pj4gICAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01N
VVN0YXRlICpzLA0KPj4+IC0tDQo+Pj4gMi4zNC4xDQo+Pj4NCg==

