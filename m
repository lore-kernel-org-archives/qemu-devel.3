Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2178C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA4rD-0001Zw-St; Thu, 23 May 2024 05:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA4rB-0001ZH-Ba
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:35:29 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA4r6-0007RB-Vf
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716456925; x=1747992925;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZY8X6qq1gC6dv5Z4wkzBjmZ3DFCopymkp+2Q8Tk6gcI=;
 b=UgDanIzS4RGttssTrlkA4/wY0mMRz+yQLFPbu8YPJua0sb49hPGUKwyd
 q0HzGBv32hEfwy3IiGMoAVfnsiw+02cw0ggsjyi5rzuwmXv0eCe2T/TNc
 O0JEy1e9dCWduKebb3nLm3e4pAfp3+OyCGEm5PT9TxTZb6EWk5+EcqTYG
 h8Kb7WNKlQ2APL6WjHOiPmjYx30NOQ5GBSbAO38JJxMLJtBkLsvGRXfgE
 zS6FBjnLSNtBGGCh2KhyeKvCuWM5s3tM+GO3/CGXuG7bg8J9DgymuwvM7
 I5RzykyS5hlo7mgQ6ZabsYskRFqvsX2vDb+1hqQqaxs4GaMWt7snX1790 g==;
X-CSE-ConnectionGUID: 6FmAhpAnRKmvJRD/Nr52Gw==
X-CSE-MsgGUID: gaeicHFbQtGrNRjL4fEl/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="11658980"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="11658980"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 02:35:22 -0700
X-CSE-ConnectionGUID: tjqgO5LOT7mRcNSlBcj+Hg==
X-CSE-MsgGUID: DWUb0GmVRJiWW0d7vTdqEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="38190694"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 02:35:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 02:35:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 02:35:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 02:35:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF56sMZXqAWJIZ6w0r749y7N6sohS19G4rzxeuDiLXB7X3+9V5Qv5agxqegEUNxxAekffR1bOqYgYt31rvHn7RxDk+a/8A1LHoZPMJzjbxUELywccNxtYuPqoLmw0yiZRtCf0xi6pTXzFU/wkjIJi5avMLpG97U9G8HS6WL/2mfir+RvGPtg0nd7d00TYhbdA7QFB8CycMgM+y3OmF3YOGMOP4IxPvi8AAUK+fYaMcYjFwEKgkkX/3oB678yj10LuGZIVnNYYZ03pGcBKFzYVx268K2LXIsGlOoBz5Spj0mMzHGPHoAaugQ/ErA64IEdyNAShQL+2JXAvnQkDwtA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY8X6qq1gC6dv5Z4wkzBjmZ3DFCopymkp+2Q8Tk6gcI=;
 b=COAp4UOMTiH87bPnzMkyBNVzVsykUtnU14X5GkYESpeiYIr2zJcRdb9p1H8L9dYUWbh46PsiF/4V4PNWxJ7bXRcGaP8ygYWljOGhsCfkWk2UHZlFTenccwzABzgA9uSL+UCgkjWT0hBbT3UtRXwOhd016sSgzA8h9S3S2p5Ygy2WJTwRlIw3ybgYGPkuhP7AcnfWqalh946+CWfwgkYdlp8Tpea2KS9nARaqs1m08vJlHnuPHnK5cxez2J7p5rjluz/RcmHilIGX5zvE+W9OF8yrzmtGCnC0/NxQpjfouYrDd2lthM+yVy9puHYy9lMaKCo0wS02IztAd4GXpN/02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 09:35:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 09:35:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Topic: [PATCH rfcv2 00/17] intel_iommu: Enable stage-1 translation for
 emulated device
Thread-Index: AQHarBDlUtyPDUNmWEGc493RqU0JOLGi5ueAgAGp0VA=
Date: Thu, 23 May 2024 09:35:19 +0000
Message-ID: <SJ0PR11MB67447C29F85A16742F7E6EE092F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <CACGkMEuDVfL1ijqBdXqJ8UKrBf-Uj5Esw_kxRA2Df9CkcLkc+g@mail.gmail.com>
In-Reply-To: <CACGkMEuDVfL1ijqBdXqJ8UKrBf-Uj5Esw_kxRA2Df9CkcLkc+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB8203:EE_
x-ms-office365-filtering-correlation-id: e0d00a50-231c-42a2-2a0b-08dc7b0ba961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?V09LRHlUbFk5MEFVYitIeGV3OSs0alNObzd1VEdMNUpaQ2lOYjZpMFJLYy9B?=
 =?utf-8?B?ellqWlhhUU9rdEg3NHd4ZzlvU2xFckpJVWlaZXFYR29hR1Z6cXliUFQ0VVZI?=
 =?utf-8?B?TVZYTDcxQlU4aUVZczFIdlYvRENSUXdrWmpKMFBsZ0xQcUpSTVYxUXhXL2ZO?=
 =?utf-8?B?eVduUTlCaG1TaGFBNTF1OFVEeWtxb1Z2TzhjcmtXVTVMSUVOQVRpNTZuVjBV?=
 =?utf-8?B?OU5NcjFnQVBGbU90OHd3dkVMRHJCQXk2c29RTU92Nnc1UitsQVpsUTlaSE95?=
 =?utf-8?B?TjVOOTNYeXJIalNKanpaUktzVnpZblR5MkZzN1pFWEtjSTZiTnErQWh4Yytn?=
 =?utf-8?B?bVRWMnlvNmpVZVRtYThVLzM0SzdzR09LRy9wclRWZU5VM2JRYmU3c2hncWlT?=
 =?utf-8?B?S3V3QmI5VlBvTEkwRy8xRWx0SW1Bb09YMG5zOTRvSVQ1K0lMQXlEa0VRbGRC?=
 =?utf-8?B?cmlha1RncGlNR2dYclUxVUhIc05UZ2R0aVFKZjErMnF5Qm9LaGZ3SVJRUTlM?=
 =?utf-8?B?N3IvcHhnSzFkdlBJYzJ4alA1TkMvSEZNbForQkNNVit5ZWtQSXZZcVdkNVpX?=
 =?utf-8?B?MitLdVFHd3dQZitFZ2tDZjl1NFkxd2NYTXVjckRvTW0rN29TbUVKV3RnTEha?=
 =?utf-8?B?a2t3N3NzKzFyRVBGWFhQTVErU1pDbnFwTm9MNkFjY1ludzArUC9qeEZ4ZGEz?=
 =?utf-8?B?RlFhWHNtaFhXQjZoR2g4bWJiaHFORGpqbmpkUUNWM0czcHFtWThmZytzbzNO?=
 =?utf-8?B?OUlwM2R4OURDSmV1cVhsb2lBWW9HMThlVEdEUGN1MDNVN3g4dXhKOVVUUXc2?=
 =?utf-8?B?TW5YNU9WOEZFVGlaWlFISnJYSXhyQ21Tc0hadWF6aHRDYXlnKzEwZmx3YmRs?=
 =?utf-8?B?M05LRDZPTkYvdk9OUlBGaEpxb3phTWc0bnN0THJqUG90NjVvalJyeGdxV2t6?=
 =?utf-8?B?SjV4d0Z1T0ZyMjU2bmlyaU9JVC9FRG1JaExUdU14T016eVR1YmdoTkFieUx6?=
 =?utf-8?B?VHpXL2FnMjMzb3VjZHQvMk9UNXRwSXdrZ1pYMi9sZUxmTmdFQS9kTWJOZzBp?=
 =?utf-8?B?QnZCRWJpY0M4bzFqQ1dGelVoSEhrTzd3ZHNVM2thUzg2U2hFMjY0UUprRDRo?=
 =?utf-8?B?WEhrMHRSaFBPdEZBMnFnR1JKMEF3SXluUzAyTUJFUU9OV2lXNnZyR3puK0Fq?=
 =?utf-8?B?L2hwWkI3dzcwMzFBZDFzaUpjN2wvSkN6YWJFREhUc29sV1l2TklKcWZVbTJB?=
 =?utf-8?B?RVpldTV4ZEhYSFhCTnVDK1dHUjlvMzdYdUwwUFltVXNvTzVHWCtTZWxxWVRZ?=
 =?utf-8?B?YStsUFdxdG8veGlYMGxkekZQcGhEYi9kL21Ld1RLOERseCtpZTdTY1hsVDhr?=
 =?utf-8?B?VmFEVWRGWWVrRDE0WWY2NGpqV01RVjNlelBKOEZGSU40V0hRT2pPTXBVNWtX?=
 =?utf-8?B?Sm44ZmxyMWoyU2lDZ3lhRjA4TzM4Yk53YTRFbmM5NEFSM2F0aklXZWt1L1h3?=
 =?utf-8?B?cGh3amlQL2s0VWJ4bTdKZDNHemFOekhWaXZvekxjcmhyRXZOWDltby95N2Fl?=
 =?utf-8?B?NkdrQjdRM0tkSlZSeXYvQXpmRGdwdmIyRWZNdzF6SVV4U1ZIZFJvcGNYbER3?=
 =?utf-8?B?ajNpeXF5WUkyMmxtekpBT2tIeWdPMko3WUg2MDRzM3ZZYWU4Qml4Z0ZPYUJL?=
 =?utf-8?B?YlFyUlJ0VHpIODJoaWxpWmp2c0czdnQyL25vT1VnQXRXZksrU3UrOXJCME1L?=
 =?utf-8?B?V254Mys2TlYwY1ErVmlyb1VXWHhoZWJLNWNqRVBpQXF3b1VDQTJ5Y2NHK0pH?=
 =?utf-8?B?Y2l3dFErdFljUWViZ2dodz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGRsakRRMTJodnNDRTRGVG1UTGlmdEtEa0RCK0w2L3BrcVhiY3RpOVNyTjVj?=
 =?utf-8?B?bGlpMVduN3lySUkyTlVGQS84MjZoQ3lVbjFJdjF2NEJpUjBXaWlyWlN4eXpS?=
 =?utf-8?B?ZnpzSXBUaEdBRjhPbTIydFJhOWR4bnBlQUVMSjIvWGl5dGN0dURnbzhXMjhy?=
 =?utf-8?B?bHNNc29USGNTQTIyYWQzUEpWaHdYd01RcGVIN0RvYUowK3FyRTdnNTFtWlEy?=
 =?utf-8?B?SW1ObUpSb01nRXh3VHh5U1JBMUo2S1FYN09kQjRvY3QxdlVKdk9rN1hzeno3?=
 =?utf-8?B?Z3gwUlVqZW9tVzhiZHRDaXlXa29Ud3F0TTErM0V5U2tZeGRudUJDZTk0SWFh?=
 =?utf-8?B?VWFZQ1ZJMEh5T2hON3JqWUdvUXlJa0YwRXA1c0pPZXNxRVRWdk16R3BtbGZi?=
 =?utf-8?B?TEpEN1hHRkVmSHdvbU5pL01KN2tOM0w3VjJ6RU9xbWVNMit5MzhiVkYvQ0tz?=
 =?utf-8?B?eHZvZm4yRnFNU3ZsQWIza1FMcnRhdjIwODFNci9PQnM0QVhueFJzSERYaXli?=
 =?utf-8?B?dW8yNFNvRU5obHQ0dFJ0b1luQkYzSGczaVBBaExDMkNxNDlXNXRoeFVEL3RM?=
 =?utf-8?B?SEliTGVEQnhaN3ZEdlBoeTdqV2FGa3duZXo4R3F4eUJLKzJEcFlNZjFHZFcv?=
 =?utf-8?B?bGMwNWIzckdNRFltRk1yZDhoOVU1OFd3R1pDUVZGS01vK3QxQnB6K3U1amhF?=
 =?utf-8?B?enFWUk9oQlNNUnRxdmJ4akRmZzlVMGZMRks2cHkyTzBjU0U2ZXRkQllNVEVX?=
 =?utf-8?B?RERpWmpxTUtMUTJyVjdZOHdUV0M1clEySWlacmFYWUlES05QQkNuaTk0RndI?=
 =?utf-8?B?NEpFMkN6WTRqT0VybVUvdDFmdC9NYjlibGxqMUxLUnc1ay8wYTdkd0tObVBG?=
 =?utf-8?B?WVNscXMzcldwcFFnM283YUZ2Mi9mcmh3TEt5d3hIY0hHb3NkRW0zcFd3Uk5G?=
 =?utf-8?B?c0FrTVdwc21DNnMyS3FsQ0doUnovY0pwVjBPNnRCeXcvOXZnRUgxNTdtN1F5?=
 =?utf-8?B?U0Roa1JBb0FyRmdDQXlRQU9VRWNNTTdXL010TUNWM3YwQ1JxamNkOXAvUkJN?=
 =?utf-8?B?dnQyTXFrWk5MSm5HVzZRSXNyMFNaWFNwT2JQcU5VSy9hb0NwUnRmK0hEV0Rw?=
 =?utf-8?B?OHJZNjJ0Sm9SOEVhblRMWHh6MjVJbGlwYjY4MmErRXFhLzFDSTE3bkFURzFt?=
 =?utf-8?B?RUd1NjJuNmkwY2Q5THJBcTBJZmNTbnMyTFBlbjI4MllIYzJGeWxHcnRqNkpT?=
 =?utf-8?B?NFA3UzhuL0xtZ2MwT0tOWitBZXdoOC9URENmTnRPTGZyTUIwU0dmODFnT0xa?=
 =?utf-8?B?SHZQbC9FTzdyUTVGT1hZYVNnVSt1K3p0MStjQmJGN1NKOEo5OFZWQk5IN2cw?=
 =?utf-8?B?c3V2Q01KaVJOeXVCdGlaUEVuS0FydFhtcFJta1N5RVNkSFNPWnJDS3FuaDRX?=
 =?utf-8?B?WExpVk5mMDVFZXNNWkJFUS9lcWNzUHJ1aGpaZm9ZcVo4b05RQnVNTTdsMDNk?=
 =?utf-8?B?eDZhSm1oZVRQa2NpdmVRdXpxTVVxOVA3S0IyMmxJeUVTNjlpMXU1T0hmUCt4?=
 =?utf-8?B?azRYTUd1YXRCKzY1K1hIVGFrRG94c0VieUM0V0VTVVl2NHpaamdXZUJhVVVs?=
 =?utf-8?B?dExkYUh2bElxZy9wTG1ZRm9UK2kwNkxjcXc0WlpUVG1MaDB5eXNidEM1WVNy?=
 =?utf-8?B?NDRhWGhLeC82cWxiTWRCT2p5VThhRE9zdlZkZktuekluMGpYRU5mbkF2Slor?=
 =?utf-8?B?WTN4cGI5UmpiallSYkFvU0hUTDlyZXBvblF0WmV6TDFrV0hTb21iQWdCZkkw?=
 =?utf-8?B?V1VGMGdicmZlTlNGb0xsWUM2bUVuYU9YZ3hwSVd0TUxkdFVsVDYrd1ZHVGU3?=
 =?utf-8?B?ZHZXbENNcjEvVXgvOXl3UTA2ell5dGZVcCtSalFyNXVLTGJUZmZaT2kvUThX?=
 =?utf-8?B?L2NFbzZDR2NmQ0lRNXM1VHltQngyWnp6cExTT2VMNExIVkJ5cXhrS2ErZVV5?=
 =?utf-8?B?a2dseWFSSVo0SUp5YWtNSEt3cVA2NDZ6czNuY2RBSFd5QW4rVW9Za3lOWHpG?=
 =?utf-8?B?b3lScCtTeFZMZnZISGNWcTNMRlp2TWxYUkxCUG9HZ1FkOGJ4MzJNZkRoYmI4?=
 =?utf-8?Q?SIuFx9TkLEafcEwojTHA5tbFM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d00a50-231c-42a2-2a0b-08dc7b0ba961
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 09:35:19.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PX664DAHAbl0J+j73oN9LD/liOtPK16U5rRF25d5SPTrMT8BRVMsDDkU/t+uxHeO+Pa3tqrAxWmickiD+7Abv4bf2NNhfKcDUOFclMa4sVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCByZmN2MiAwMC8xN10gaW50ZWxf
aW9tbXU6IEVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uDQo+Zm9yIGVtdWxhdGVkIGRldmljZQ0K
Pg0KPk9uIFdlZCwgTWF5IDIyLCAyMDI0IGF0IDI6MjXigK9QTSBaaGVuemhvbmcgRHVhbg0KPjx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEhpLA0KPj4NCj4+IFBlciBK
YXNvbiBXYW5nJ3Mgc3VnZ2VzdGlvbiwgaW9tbXVmZCBuZXN0aW5nIHNlcmllc1sxXSBpcyBzcGxp
dCBpbnRvDQo+PiAiRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yIGVtdWxhdGVkIGRldmlj
ZSIgc2VyaWVzIGFuZA0KPj4gIkVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBwYXNzdGhy
b3VnaCBkZXZpY2UiIHNlcmllcy4NCj4+DQo+PiBUaGlzIHNlcmllcyBlbmFibGVzIHN0YWdlLTEg
dHJhbnNsYXRpb24gc3VwcG9ydCBmb3IgZW11bGF0ZWQgZGV2aWNlDQo+PiBpbiBpbnRlbCBpb21t
dSB3aGljaCB3ZSBjYWxsZWQgIm1vZGVybiIgbW9kZS4NCj4NCj5CdHcsIEkgdGhpbmsgd2UgbmV2
ZXIgbWVyZ2UgUkZDIHBhdGNoZXMgc28gSSBndWVzcyB0aGlzIHNlcmllcyBjb3VsZA0KPmJlIHNl
bnQgYXMgZm9ybWFsIG9uZSBmb3IgdGhlIG5leHQgdmVyc2lvbi4NCg0KR290IGl0LCB3aWxsIGRv
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

