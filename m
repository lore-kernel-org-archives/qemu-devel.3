Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD04C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 02:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRNT4-0008Nv-D9; Tue, 09 Jul 2024 22:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRNT2-0008NH-Ia
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 22:54:04 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRNSw-0006oS-G8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 22:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720580039; x=1752116039;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5nP32A3xgwiGhSQo4bhCOT2JB+jA7cms4ILKPDmNETk=;
 b=Plun0/FcSj/AbGcaVFQhaNEcztgwdOVcDVEdGwG7zC31fi2woFymcOW5
 oWLVwd8hIuMGJ7pUf7wfVCQ7qGsFtlXQY5MzCoNSlz7jZG+EF0SuoFgI9
 0th8b+Q96NYO9QMleHpg569y+K0PiI7XSkjJ1wk2h9ySXv8TBMgQOsuXN
 7+lh1fC6W4WQFTq+SXEtkdke241e6tfv3Tjs9LlQ/KjhuhSK1B6Yqvrvj
 LOKA+OwLXDM6lMzZ5W3MXdJa39+TzPSD7fPhQUdd5MswfnXTLmKGnqw4L
 2zXzrXrEjiG77nILogVXqC6KprLWYTcEcpZk4pjRabNB+LwO5sfJb/cw6 Q==;
X-CSE-ConnectionGUID: WmDO9GxdRaCVJHaXfPfMMg==
X-CSE-MsgGUID: 5iYhBsMMRXeY8OvXiYEPNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="12465524"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; d="scan'208";a="12465524"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 19:53:53 -0700
X-CSE-ConnectionGUID: +wYtmKtiSNam68yiJNXQ9A==
X-CSE-MsgGUID: oXwKld6nTnmuETJLahCBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; d="scan'208";a="52355844"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jul 2024 19:53:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:53:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:53:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 19:53:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 19:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7Zb4m/Andqr5Vm16TzK+NgcidMiVk2SC6UxzKO1TGBUtCBufZPfOn326oRRumFmckmoNtD2vJLnxg/VFJGO/F6bL/7PpmLoTMxbRMyZrby6+iJfBlP/0CpdVXeOdBtDSiKyS7nIxkeojuxd1GLiAL32ixxv72mjqQ9+XDZYReSqoBqD4opcPoQw8zfgNlwU9PJIDyuw9ZU1M8trqkTKJLxp46cpYWWNeEh0DhjbQmWAXo9WBKU0oKNngT6G+Y78yK8ZRXMbAXPvvUYZNaKUpsYlw4pgIyJQh0zA4J5jr/OEaC2fIlU18SUmC/wuKJe3nuhsppG+H/sGt6YpbDKwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nP32A3xgwiGhSQo4bhCOT2JB+jA7cms4ILKPDmNETk=;
 b=Qff7K7+wm0kXKfe/6P8mIGaBGBxEPGwm7yN94k08Zx5Ic3gZ8nfVLkaMUNnUqCEIRriQoOrkpNk4KNtstAzxOesvEwHHeutlenpELmrV34qsn1cmOwj+sDV6qaJIO36d/9Pai+P/EzoqQT5WeMFru3TrGs6G5lERDOwB82xsEbNkbjYi4JeieNq8KgmEMnRGnFMK3prGdI/Ob4p5B6TlsLMmXyDfjQQ0qlpzBp6uZcyrS2ihlwf7yWZ2KC4MGsQl1j+NbrwIOnAAfxJNYbgaVyktZguPde/8hcPvRDzbshxIZ2BlGBL23RXnkEjLS/jcey4pnId2aJIbmF+t4/geMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7767.namprd11.prod.outlook.com (2603:10b6:8:138::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:53:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:53:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
Thread-Topic: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
Thread-Index: AQHa0UP9XaJW+V7HF0q1KSPPC08ne7HtvVgwgABbzwCAAC9PgIAAAXAAgAD7n2A=
Date: Wed, 10 Jul 2024 02:53:45 +0000
Message-ID: <SJ0PR11MB6744E07A01918228E5F4068792A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
 <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
 <59a63429-831b-4bcd-b805-9fb83b8bcdd0@oracle.com>
 <47f86137-a47a-4fa7-a899-39c8f3bf4cbf@oracle.com>
In-Reply-To: <47f86137-a47a-4fa7-a899-39c8f3bf4cbf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7767:EE_
x-ms-office365-filtering-correlation-id: 406117a1-b58e-4ec2-561e-08dca08b8444
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bUhXajV1Tk1uM2RUQ0tOMGpINlFmQ2poeEtOd1FlTE5QcGpibGdjQmhCRm1o?=
 =?utf-8?B?ZWJpUHIwajV4bEhhTnhoMDFsOXFLelNtUk1UVk1ad1ZTL3ZPNXlRaUUxNXVV?=
 =?utf-8?B?S01uaEtrZXhOVkpOTThDYjNyOC9oM1A1UWZqK24rR3FRdHZFOSt2L2FISXNE?=
 =?utf-8?B?c0NYazVFU3pzQzFQN1JTbWVzZHZVd2cyQ2g3R1RhLzc5Mi9uN1JXYlFiRnFh?=
 =?utf-8?B?SW94bmpEUHh4VG5YUDV3U3g4c1MwREFFY20yZGV6SjM5K296LzRrQzNVTG9Y?=
 =?utf-8?B?QjJMSExnaXNIdjc5QkloalBNaGE1MTFUdU5aQXdwcmhmN3VLaCt0QVFtc0NW?=
 =?utf-8?B?KzVVcTFqTTZkNzQrcVRWUWphYllwMDFPUHVvOGQxdUk2YUFMc0dJd05aYzZE?=
 =?utf-8?B?aFNDcGdnL0pRNVVWNU9icWJpODRJZkEvOUxJelBVd3JkUkViOTIyRTJhOWpx?=
 =?utf-8?B?a25Pb1ZwSmVzblM1MkdUb3ZHdlNkaXJiT016eWxrZEVrRS9rYUIvL3Bua25n?=
 =?utf-8?B?VE9wVWlBN0FmaS9GL2pJVitvRE8zVTNHL1ltYXgvSHlHcloxcDVpeUlpZmcx?=
 =?utf-8?B?WTVKUjZOQzV1Z0pLRGZiYTJueEtzWEdidHQ2L3ZjUGZpck1xQzJNaVhwVWMw?=
 =?utf-8?B?NmVkOEZ0VFZSQlUrU0NpMW9QRkJRZFdjNU5ZUS84VXFiWHNtTXFKaTFWUmta?=
 =?utf-8?B?YXp5RmJTTkdYMCtDRjhiZUVYMHhkcFZWUTVrOXNxS09HVi94dndvSGZ3cHJS?=
 =?utf-8?B?aHp1ZVpXaGRRYjBUOHU4di9GZ3lqYTVRL2JxdElPekoxeHNsbFg5ejJoODM2?=
 =?utf-8?B?M2dZb1JlTXIvYVlXWFE1N2ZMb1lOd3NvMGltTjNGTmFlZTI3YVpwd1NFME52?=
 =?utf-8?B?VFREMnlYTHlISitvNjNESkZtV3RRdWxSTDcxTHJMVmtGRWtWUkVrT3ovUnFU?=
 =?utf-8?B?ZXpocGFvNTRWYlZabDlvMWxGVjc5T2ZabHErU1QxVmNmbW9NUElkUnVScVNU?=
 =?utf-8?B?WHJLYWRacSt2NlZ0bCtzaUhIUk10dWdRMm9mWUI5ODBITjRTWWtaS1VtZENZ?=
 =?utf-8?B?SHF1cForTEd0ei83RVkwU2JVbTJZT3gzdVp5SFovZFRLNm5MZjVid1Z6YWhz?=
 =?utf-8?B?ZkxZc2krZmFhR004TlhQUVR2YWptYVZBQ21ua3N4SmZMaHRUSUlXWmdweWsr?=
 =?utf-8?B?MXNpa3BEVEJ1a05HSjAxUGpIdzFqOTZrQmlYOWtxSmswdW5vMTN1dGRnby9U?=
 =?utf-8?B?ek5DQ3BtbVkzNkttUmU2Z2MxSnRsVVFXaml6cG1ZN2ZDNkIxbnFQZGVLeGsw?=
 =?utf-8?B?UFdjemhtU1B6WmdGc0sxOFkyQTRJM2NrVEIwSGdPUnV1ektFQXV4ZU5Ya0d5?=
 =?utf-8?B?Rm8zdGdGM1orMnA4UWJtUlBhVkpFUlJPMGlydzhkYlh1V25ZRUNaZWRQek85?=
 =?utf-8?B?T0hmMThsUFRlMXdsVEdNR2wyNVJ3QkNkM0ZrR1haZ1hmQktUMkhWN2xVRVJx?=
 =?utf-8?B?RS9HbitRMkZONTNnOGhTcmZxZGNsbjdTenR0OG5uZExWTzJmdmc1V1JnVitp?=
 =?utf-8?B?N3ExQzVOWi9uTmVwZyt2OWhmaUpLNlhOWWJGQ0ZuMkQvVTk1eTJ1V2hvbXEz?=
 =?utf-8?B?UFNYcHg0VFFVSzZ1OVhIbktNcGFZVmk3LzZMbDNtNDNZQVlicDVlaEc0ekpL?=
 =?utf-8?B?dkt6cnZYSVZ0RVNjQnI3SGN6RzZ1RkNnSTRaN0wyVXFWcWxHV291NGh3bkR5?=
 =?utf-8?B?SVkxR0ZlaWFvNFZ4RU9YV0N2WUNOVVVLWXlsY2I1UEt0VTB2cjMxc0ErR1Z3?=
 =?utf-8?B?VTEzTEVmdnV5aGU2RE1lanRxS3RycXZ3OEp2SWk1eHM3dVlPbXNWWUlqOGlO?=
 =?utf-8?B?ZENiSHF4V1gxdG1DcC9ZWUQ0UXpSSjRJWnpHajhwMFpkaXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm5uZmJ2WTZpRmNNZ3MwV3l3N2VUSUI1NjN4VGlOTWlvSHFtdkxPMGRMRmNz?=
 =?utf-8?B?MkpHUHhDd1JhS3FmTENOT3MzN2cxd0FQU2VXZ3hVamJNKzJTQmx0QXVab3BL?=
 =?utf-8?B?RjRPVHNCRXl5TXB2dUE4WkNwenJJc2o5TEJyTnluanROZGVsRnAxVUI1amFp?=
 =?utf-8?B?akpxMVhqMUw1ZG1HaVpKV2hIaGdGaTFEeFN4MTQwZ2NiczNJSWQzUjl4dmQ5?=
 =?utf-8?B?dVl6ME01WG44T3YxZkFZRUdqaTd2RkZJL2p5eFk3NkMxRVVtR2JHL0pTancy?=
 =?utf-8?B?V3JBdUR5RDBQbk1NTmJMaURzRmFUckNpc0pucC9hallVRHg4NVlIVHFtL2xi?=
 =?utf-8?B?L05Xa0NqUVhaOFJreVFWTGgreEkrOHhVaXJGblYxaHNpajNuM2FYaEs2bHpY?=
 =?utf-8?B?d2Z0THY5RTMrTnhMaU1FZWVIOUlCbTRDalhqd0ZLU0pCZk5YeXN3Wm5qK0s2?=
 =?utf-8?B?MHNXUXhtV0FWSVI4TzdYSVZlNitZQnRzazliemhyd1IzNVA2cHhYZ29qU2Zz?=
 =?utf-8?B?Z1V1aUFSUS9tcmJJZWo2ZGZmR2ErN0NQQlcvNmZYWllnOHNzUTRPTmZBZUV5?=
 =?utf-8?B?b0phNS9rRzhJbDRyL2hXYzJNNUlEZGVKdlRrY3VtOW5TOFNlL3l3TWtaOEdv?=
 =?utf-8?B?RDY2azVEd0QrSkc4dlRkT252WGFQUXIrZmdwVTBkc0xXZ0lHbjR6czlUYVNY?=
 =?utf-8?B?NkhxMWo0RzNMeTVVcmZwck9FckJzQ3ZWZWpvVVpDaDNEWXprR1d6Z05lZEts?=
 =?utf-8?B?RHFlUUpvVHVsL1ZRWGhRVkVPcFdseXZLVWNJdGVCUWl6QlhsRkVxYUlsMGUr?=
 =?utf-8?B?dTdINXoyNzZSYUJpOUM3VTY5bmVMYW5ESWVoSnNEYnhOZG16MXhVTjI0Q2Rn?=
 =?utf-8?B?QlpGTGMyWHlTRE1kTmdtdmNVTWJpLzMxUmJGWTVydmkveFdSZjV5cFBLaVUr?=
 =?utf-8?B?OXZZQkZIeUJkRFdvOUFmeUNzYVpPTzgvamJUVnFtNlhyZk1ONmhRcEJWMnNl?=
 =?utf-8?B?TGV2bkVjTHNnNXZqRkEvL1pBOTlkdkZ2OWpKRjFQSU1uTElkdm9GMnZEM3I4?=
 =?utf-8?B?NllzT3NOeEZPbk8xOFUvYzhhL1J1dUpnQzlhVE8ydUZWMjBwM0RiMm94YjFG?=
 =?utf-8?B?K3dKTjR1NDVsaVZvR21nZjZQSi81Z2owT3RUNmRreEQ2bUhrL2l6WVZOMHU1?=
 =?utf-8?B?b2Fhdjc5QldsSTJnVnpiM1U5eFZ6eG1ZUmFONkxDdFVCS0FMK2FYc0x4RVRz?=
 =?utf-8?B?TTFLMnJjU0FhVHVPS2tuT2ljVk5mOHV2NDlaVDJ1UXhxZCtRaGU3dHQzRnJl?=
 =?utf-8?B?WE1MTUx5YS9NWElOMlJHL3d2RkR2NUxlWEhTK3ZrZzQyZkJPdEU2ajZsVVVH?=
 =?utf-8?B?Qm5mQ1VwUzdTSGxJUFE0RFQ3LzdpNXQwbVorNXNlaDJFa0hmSmhWNEk1MTJE?=
 =?utf-8?B?eHNKRytmVVlUWCsrY1ROSmwzd2kzUDhhSGtBNW0vYjU0VUhLOW9RYlhkbWxI?=
 =?utf-8?B?VEtOWHdNd0E0dDlEQmJrcjhYdXQxSUFqU3hVaUhZT284dTYwY09URFNvaVBs?=
 =?utf-8?B?YUhyRDVXZUI3UUllMithWlVSWGN6blB6aVhiYmlSU3JpZG5wMHNUcHpueUV2?=
 =?utf-8?B?ckwwUlJEMFVhdUdCRTI3MzlHMjlLdDF2ZmtxYlpFdGcrWWlhb3ZKMFd3aWQy?=
 =?utf-8?B?UUdkRm90eVNFc3RQOUNFM0hKU3Y1cFdiN3JwUTkwNEtKNWhldE1PL0ZjVGhw?=
 =?utf-8?B?SXVGKzNBWkNlNWJpeHVpSzc4Z3FCNDJTa08wUzZDRXcrT1BJSDB5c3NoRnVZ?=
 =?utf-8?B?eEVleXVSeWdYSTIyZFpDT3A1RG42RVk3NWlRV2NQUUg4OVR1S3gvSVZUcm13?=
 =?utf-8?B?UmljYjZoSTRtUlA5cERQc0NUaXBTanE2d1ZEc3loVUkrS1M4SXZrYnRNVVox?=
 =?utf-8?B?bU1SVko1MVlTSGg2NW1oWDhCYnE1dDh6OVBqMmFaNU1xOTlTWFl3bThSN0Zs?=
 =?utf-8?B?eVBMT3ZBZ0NvT28yN2xmcFZGc1RaMHMyU01uMUVsL0MweW5nVGFEZXQ0Wnpi?=
 =?utf-8?B?YWZBMjhieGVXT0l4OC9wU2tvK2JZU0NnMmtMdUtodERjaUJVc1B6SllIbU13?=
 =?utf-8?Q?gyFvFOTgaP34VW3pp4n6KBS1O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406117a1-b58e-4ec2-561e-08dca08b8444
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:53:45.9328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UK0XZ+VqR7RaTgCV2EsqpKqjoQS27ZXXfdYN0lyOxdddbLSvkLDn8Nbq/rHSlOh0iWiSmO11y9uf7D/kNh5mwAf01gtV8gn+TwuR0qJxE7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDAxLzEwXSB2
ZmlvL2lvbW11ZmQ6IERvbid0IGZhaWwgdG8gcmVhbGl6ZSBvbg0KPklPTU1VX0dFVF9IV19JTkZP
IGZhaWx1cmUNCj4NCj5PbiAwOS8wNy8yMDI0IDEyOjQ1LCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+
PiBPbiAwOS8wNy8yMDI0IDA5OjU2LCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+Pj4gT24gMDkvMDcv
MjAyNCAwNDo0MywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+PiBIaSBKb2FvLA0KPj4+Pg0K
Pj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+IEZyb206IEpvYW8gTWFydGlu
cyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+Pj4+IFN1YmplY3Q6IFtQQVRDSCB2MyAw
MS8xMF0gdmZpby9pb21tdWZkOiBEb24ndCBmYWlsIHRvIHJlYWxpemUgb24NCj4+Pj4+IElPTU1V
X0dFVF9IV19JTkZPIGZhaWx1cmUNCj4+Pj4+DQo+Pj4+PiBtZGV2cyBhcmVuJ3QgInBoeXNpY2Fs
IiBkZXZpY2VzIGFuZCB3aGVuIGFza2luZyBmb3IgYmFja2luZyBJT01NVQ0KPmluZm8sIGl0DQo+
Pj4+PiBmYWlscyB0aGUgZW50aXJlIHByb3Zpc2lvbmluZyBvZiB0aGUgZ3Vlc3QuIEZpeCB0aGF0
IGJ5IGZpbGxpbmcgY2FwcyBpbmZvDQo+Pj4+PiB3aGVuIElPTU1VX0dFVF9IV19JTkZPIHN1Y2Nl
ZWRzIHBsdXMgZGlzY2FyZGluZyB0aGUgZXJyb3Igd2UNCj53b3VsZA0KPj4+Pj4gZ2V0IGludG8N
Cj4+Pj4+IGlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8oKS4NCj4+Pj4+DQo+Pj4+PiBD
YzogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+IEZpeGVz
OiA5MzA1ODk1MjAxMjggKCJ2ZmlvL2lvbW11ZmQ6IEltcGxlbWVudA0KPj4+Pj4gSG9zdElPTU1V
RGV2aWNlQ2xhc3M6OnJlYWxpemUoKSBoYW5kbGVyIikNCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEpv
YW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4g
aHcvdmZpby9pb21tdWZkLmMgfCAxMiArKysrKy0tLS0tLS0NCj4+Pj4+IDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+Pj4+IGluZGV4IGMy
ZjE1OGU2MDM4Ni4uYTRkMjNmNDg4YjAxIDEwMDY0NA0KPj4+Pj4gLS0tIGEvaHcvdmZpby9pb21t
dWZkLmMNCj4+Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+PiBAQCAtNjMxLDE1ICs2
MzEsMTMgQEAgc3RhdGljIGJvb2wNCj4+Pj4+IGhpb2RfaW9tbXVmZF92ZmlvX3JlYWxpemUoSG9z
dElPTU1VRGV2aWNlICpoaW9kLCB2b2lkICpvcGFxdWUsDQo+Pj4+Pg0KPj4+Pj4gICAgIGhpb2Qt
PmFnZW50ID0gb3BhcXVlOw0KPj4+Pj4NCj4+Pj4+IC0gICAgaWYgKCFpb21tdWZkX2JhY2tlbmRf
Z2V0X2RldmljZV9pbmZvKHZkZXYtPmlvbW11ZmQsIHZkZXYtDQo+PmRldmlkLA0KPj4+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnR5cGUsICZkYXRhLCBzaXpl
b2YoZGF0YSksIGVycnApKSB7DQo+Pj4+PiAtICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+PiAr
ICAgIGlmIChpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKHZkZXYtPmlvbW11ZmQsIHZk
ZXYtDQo+PmRldmlkLA0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJnR5cGUsICZkYXRhLCBzaXplb2YoZGF0YSksIE5VTEwpKSB7DQo+Pj4+DQo+Pj4+IFRo
aXMgd2lsbCBtYWtlIHVzIG1pc3MgdGhlIHJlYWwgZXJyb3IuIFdoYXQgYWJvdXQgYnlwYXNzaW5n
IGhvc3QNCj5JT01NVSBkZXZpY2UNCj4+Pj4gY3JlYXRpb24gZm9yIG1kZXYgYXMgaXQncyBub3Qg
InBoeXNpY2FsIGRldmljZSIsIHBhc3NpbmcgY29ycmVzcG9uZGluZw0KPmhvc3QgSU9NTVUNCj4+
Pj4gZGV2aWNlIHRvIHZJT01NVSBtYWtlIG5vIHNlbnNlLg0KPj4+DQo+Pj4gWWVhcCAtLSBUaGlz
IHdhcyBteSBzZWNvbmQgYWx0ZXJuYXRpdmUuDQo+Pj4NCj4+PiBJIGNhbiBhZGQgYW4gaGVscGVy
IGZvciB2ZmlvX2lzX21kZXYoKSkgYW5kIGp1c3QgY2FsbA0KPj4+IGlvbW11ZmRfYmFja2VuZF9n
ZXRfZGV2aWNlX2luZm8oKSBpZiAhdmZpb19pc19tZGV2KCkuICBJIGFtIGFzc3VtaW5nDQo+eW91
IG1lYW50DQo+Pj4gdG8gc2tpcCB0aGUgaW5pdGlhbGl6YXRpb24gb2YgSG9zdElPTU1VRGV2aWNl
Q2Fwczo6Y2FwcyBhcyBJIHRoaW5rIHRoYXQNCj4+PiBpbml0aWFsaXppbmcgaGlvZCBzdGlsbCBt
YWtlcyBzZW5zZSBhcyB3ZSBhcmUgc3RpbGwgdXNpbmcgYQ0KPj4+IFRZUEVfSE9TVF9JT01NVV9E
RVZJQ0VfSU9NTVVGRF9WRklPIHNvbWV3aGF0Pw0KPj4+DQo+PiBTb21ldGhpbmcgbGlrZSB0aGlz
IGlzIHdoYXQgSSd2ZSBkb25lIHdpdGggdGhpcyBwYXRjaCwgc2VlIGJlbG93LiBJIHRoaW5rIGl0
DQo+PiBtYXRjaGVzIHdoYXQgeW91IHN1Z2dlc3RlZD8gTmF0dXJhbGx5IHRoZXJlJ3MgYSBwcmVj
ZWRlbnQgcGF0Y2ggdGhhdA0KPmludHJvZHVjZXMNCj4+IHZmaW9faXNfbWRldigpLg0KPj4NCj4N
Cj5Tb3JyeSBpZ25vcmUgdGhlIHByZXZpb3VzIHNuaXAsIGl0IHdhcyB0aGUgd3JvbmcgdmVyc2lv
biwgc2VlIGJlbG93IGluc3RlYWQuDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5j
IGIvaHcvdmZpby9pb21tdWZkLmMNCj5pbmRleCBjMmYxNThlNjAzODYuLjk4N2RkOTc3OWY5NCAx
MDA2NDQNCj4tLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5j
DQo+QEAgLTYzMSw2ICs2MzEsMTAgQEAgc3RhdGljIGJvb2wNCj5oaW9kX2lvbW11ZmRfdmZpb19y
ZWFsaXplKEhvc3RJT01NVURldmljZQ0KPipoaW9kLCB2b2lkICpvcGFxdWUsDQo+DQo+ICAgICBo
aW9kLT5hZ2VudCA9IG9wYXF1ZTsNCj4NCj4rICAgIGlmICh2ZmlvX2lzX21kZXYodmRldikpIHsN
Cj4rICAgICAgICByZXR1cm4gdHJ1ZTsNCj4rICAgIH0NCj4rDQoNCk5vdCBuZWNlc3NhcnkgdG8g
Y3JlYXRlIGEgZHVtbXkgb2JqZWN0Lg0KV2hhdCBhYm91dCBieXBhc3Npbmcgb2JqZWN0X25ldyhv
cHMtPmhpb2RfdHlwZW5hbWUpIGluIHZmaW9fYXR0YWNoX2RldmljZSgpPw0KDQo+ICAgICBpZiAo
IWlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8odmRldi0+aW9tbXVmZCwgdmRldi0+ZGV2
aWQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnR5cGUsICZk
YXRhLCBzaXplb2YoZGF0YSksIGVycnApKSB7DQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPmRp
ZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPmluZGV4IGQ5NWFhNmI2
NTc4OC4uZjA5MmMxNTM3OTk5IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4rKysgYi9o
dy92ZmlvL3BjaS5jDQo+QEAgLTMxMTUsNyArMzExNSw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVh
bGl6ZShQQ0lEZXZpY2UgKnBkZXYsIEVycm9yDQo+KiplcnJwKQ0KPg0KPiAgICAgdmZpb19iYXJz
X3JlZ2lzdGVyKHZkZXYpOw0KPg0KPi0gICAgaWYgKCFwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZp
Y2UocGRldiwgdmJhc2VkZXYtPmhpb2QsIGVycnApKSB7DQo+KyAgICBpZiAoIWlzX21kZXYgJiYg
IXBjaV9kZXZpY2Vfc2V0X2lvbW11X2RldmljZShwZGV2LCB2YmFzZWRldi0+aGlvZCwNCj5lcnJw
KSkgew0KDQpZZXMuDQoNCj4gICAgICAgICBlcnJvcl9wcmVwZW5kKGVycnAsICJGYWlsZWQgdG8g
c2V0IGlvbW11X2RldmljZTogIik7DQo+ICAgICAgICAgZ290byBvdXRfdGVhcmRvd247DQo+ICAg
ICB9DQo+QEAgLTMyMzgsNyArMzIzOCw5IEBAIG91dF9kZXJlZ2lzdGVyOg0KPiAgICAgICAgIHRp
bWVyX2ZyZWUodmRldi0+aW50eC5tbWFwX3RpbWVyKTsNCj4gICAgIH0NCj4gb3V0X3Vuc2V0X2lk
ZXY6DQo+LSAgICBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShwZGV2KTsNCj4rICAgIGlm
ICghaXNfbWRldikgew0KPisgICAgICAgIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKHBk
ZXYpOw0KPisgICAgfQ0KPiBvdXRfdGVhcmRvd246DQo+ICAgICB2ZmlvX3RlYXJkb3duX21zaSh2
ZGV2KTsNCj4gICAgIHZmaW9fYmFyc19leGl0KHZkZXYpOw0KPkBAIC0zMjY4LDYgKzMyNzAsNyBA
QCBzdGF0aWMgdm9pZCB2ZmlvX2V4aXRmbihQQ0lEZXZpY2UgKnBkZXYpDQo+IHsNCj4gICAgIFZG
SU9QQ0lEZXZpY2UgKnZkZXYgPSBWRklPX1BDSShwZGV2KTsNCj4gICAgIFZGSU9EZXZpY2UgKnZi
YXNlZGV2ID0gJnZkZXYtPnZiYXNlZGV2Ow0KPisgICAgYm9vbCBpc19tZGV2ID0gdmZpb19pc19t
ZGV2KHZiYXNlZGV2KTsNCj4NCj4gICAgIHZmaW9fdW5yZWdpc3Rlcl9yZXFfbm90aWZpZXIodmRl
dik7DQo+ICAgICB2ZmlvX3VucmVnaXN0ZXJfZXJyX25vdGlmaWVyKHZkZXYpOw0KPkBAIC0zMjgz
LDcgKzMyODYsOSBAQCBzdGF0aWMgdm9pZCB2ZmlvX2V4aXRmbihQQ0lEZXZpY2UgKnBkZXYpDQo+
ICAgICB2ZmlvX3BjaV9kaXNhYmxlX3JwX2F0b21pY3ModmRldik7DQo+ICAgICB2ZmlvX2JhcnNf
ZXhpdCh2ZGV2KTsNCj4gICAgIHZmaW9fbWlncmF0aW9uX2V4aXQodmJhc2VkZXYpOw0KPi0gICAg
cGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UocGRldik7DQo+KyAgICBpZiAoIWlzX21kZXYp
IHsNCj4rICAgICAgICBwY2lfZGV2aWNlX3Vuc2V0X2lvbW11X2RldmljZShwZGV2KTsNCj4rICAg
IH0NCg0KWWVzLg0KDQpUaGFua3MNClpoZW56aG9uZw0KPiB9DQoNCg==

