Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B435C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwc3l-0005jt-VN; Tue, 16 Apr 2024 02:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwc3k-0005ir-Cl
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:12:48 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwc3i-0002Gf-Fo
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713247966; x=1744783966;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IpUeexwBjpvV8G0nlPKhxlMIF3yEEyf7BknCtN+1d6w=;
 b=Hxid+Q3WFYH+HjBBi04YJeVxUfkTGo9g5KrSlm3FjEz2ITG1uiXz4UGf
 HUe4lYirtjOHyH3FyGCyDTJAhcZ8vyPUGX3beO8LwcMd2ImKSZjaLp6mu
 oC7SYjxKv/Mk4YpFdCdiWc6jPxfLgrxEUFdB6Y6bkSLkKcIfK6cPzgY8R
 4uDMJOkjETSG46ysUgAl/B2E46MID6vLMELj38AJ2yN6qVKYDKPayEyZi
 vOIokr9tFzKpUAilZvy2IR7XNuwH4BjUNo4hl5N4PeWi4JuCr4djodPwC
 nX0jFCo5kvmYdB+28/pjUlWTzBf1M8mLVx6iYKtsKibNkAyTulu2b8fKt Q==;
X-CSE-ConnectionGUID: M0bq9aUARuGEeHOlzU0DCA==
X-CSE-MsgGUID: ZhCB4t8BTUe2DCCNXIgA4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8886275"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8886275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 23:11:03 -0700
X-CSE-ConnectionGUID: 9dGzPjQCRICWL7mvIOt9+w==
X-CSE-MsgGUID: fTdSKOQYRwKCh9DUk8kKHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="22218018"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 23:11:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:11:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:11:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:11:02 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHNRFJlADNahxQ541A2fpVGk6ZIswyf70rXVN6Kfw4aCUlON5eUAAZsOD2nd7WRMO8pmFpZEimCn/lOLv4Tq1evDjgxMV2D6pMEQM+jg/1GcJXAZvQSL9XYLyNBSBHvcDWv3pYAyItdh4iRLaQfmN0p3xTP50BbmW8R9AM2CtIYpo6rHcbmEqts+IfBOCUExcjjsEpKPoJHOZ5Ico0ZxmQg2ggRhUSzpugH4r8jpmROzavFTmUq+w2YDWGPKeyhFhOH9zzpb0O7Qtj3vCtduqpjGZ3MTVAgI17gIgnUOqGNO5IS8JVpR9DlPUlmJwPyiz7YY640DuVkv+Ql/t+KpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpUeexwBjpvV8G0nlPKhxlMIF3yEEyf7BknCtN+1d6w=;
 b=Q26Sl8xw65XTm0mhI+73GbvhMXtEMr2mNlPtE4T0PTe005Hexld4x3f+8R26ZbFG+j+/OLjAVoU/k8AIAb0gGv8MOiStFc8xn3PCyyunNATENmVhJd79QKN/iE2d9omrwZk/A1J6BaRt7xR1Yk8t9zQngCggz9xJnkiLQAT2VSv+h92s7DFN2fqSkkIJhA0F0eeHce0CRDtNoAtUjhzNgjaWz1p72mFP+flhbx/ud9bvKIlRfvMR4aZVtfRYbN0ShnF0VAaGjLxGQwKv/b/VjadML8SqDC5/JPgS1ALJ3D8Dzi2QMIYMnQS+hOQxSpA+aXDy3AgOXdeuT4607+4iuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:11:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 06:11:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 08/10] vfio: Create host IOMMU device instance
Thread-Topic: [PATCH v2 08/10] vfio: Create host IOMMU device instance
Thread-Index: AQHaiYz3DNHnIcJZUU++mQQZrwwZWLFpXZ8AgAEXhvA=
Date: Tue, 16 Apr 2024 06:11:00 +0000
Message-ID: <SJ0PR11MB6744ABE8FD845AB9BF94B90C92082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-9-zhenzhong.duan@intel.com>
 <543294a6-5f04-46ac-af56-af8c1b5f436c@redhat.com>
In-Reply-To: <543294a6-5f04-46ac-af56-af8c1b5f436c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 6b0adfa4-2f06-4e3a-7095-08dc5ddbfd46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++z3cZP/6fKcayQGI0l0okZUHUVic6QOgQrF75VPaanlRjXJ7CJ0Ut7tn2pD+CDDuqlUCBZaeGpcniAWHQdNHggqrrrC04i/FGWYjYDMVu3mIU+wOwkSoCU6ig5zT/xRy7V222W9L7vuFVSWUJoSOod1i4qZOFRcIv9zUbsNuuXjAORInG58wKmM25IMSR5tqhCw8qBiMIgtFT0qKwGJx3bw3BG9eXWyz12lRkXXPCDsz4zzt7MmAtGDddQmPiCf61vNWb29SkmvCx7zH2vm7hkCiQsYeoTyXb0ckSwdh/PqGpoVia6newxI1VMKKvAzQOYJnUsnUB4ZKp+zwBy+itv1amiymmffQ4JGF51jmOtjhN1farOhUXC1wwMPKiyvWJTbp1T4QmV9CDnS61F8ewUJI0icdBgN2+oO9zr40y+6lWd6KMjLixJUyg/Awutr/RUOGbHnyYsYh7GmSATJn7uz69GSfCjJiVeklyJ4QKIhk97XLOI3WShf768j7HhiUdRtpJqQedm3qsnq9afvQm0FEt39SjTEDmxWIyqIFyCwUAIaPOBcmS/HRbQaKrYT+zzRyd4KxL9scNjwMzKgEW6Q2bx6k1l9djIhJRA2NfM6fXeYChCRNyt2bJvYRL2BBjHiPpv1LPn0r7JvAN1ub2EOgtX1zpIlb4SNsiE2jo8/nmNDha9QAxjVFRdGrfEo2Lz6RyJycgKEp992yRwzF7RrWzidIsevX8g4ARrteGQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1FSjNyUmQ0V09PR0hxWkJwS2JOd0N5eGplcUpyeW5UZDFjRitTZlFsei9t?=
 =?utf-8?B?dVdsWXNIR1gzd09iajdyMVRqUnlGMlZBOHJvY1hzU2pKZ3YwaDhETC9rQVd0?=
 =?utf-8?B?R2JGWVJ1RGNZVFQ4NnZvWWFxSUFIS0dDYnlHZzY5WlNxaUdUcWgzZklJSUIv?=
 =?utf-8?B?N2tuUVlKaXNYa3pMZUxmdU83VjE5QS85c2hGVjZVOUdVMU1DN3NJMi9EZGlr?=
 =?utf-8?B?UktDakRnYU1CUVpUNVUycnkwaEhZSCtFeW9hakN6a3Z3aE1RNnlINFhIWmNX?=
 =?utf-8?B?YVpkeklFZm1YUEllMHRSTElUclZRVzJWUjMyODVyZE1hcHFLbkRyVmpDNnlZ?=
 =?utf-8?B?dGU5NEtkK01iMURNSkszRjhFa0FRQnJ5SFhwVDVnVG9NdFNHUVBJNVdxRXFS?=
 =?utf-8?B?Ym1jRmlEeFRBeHJYZS9OYlFUYm9ZeFpxS1prQ2dFb2lVcWVXRnd2YkJhcHc4?=
 =?utf-8?B?ZGtJZmkvOVRta1F3cVc0ZERIM0prNnNieWl3TDRGdWhpaUFHMHZ4K05iUHln?=
 =?utf-8?B?VFZZazJxMEt4a21aYzh0aDN0VDFDa1NXS3dwaU5ENjlTQ01ZOXJyZnluZXg1?=
 =?utf-8?B?OG9NZHRib0ZaaHhGT25hTnkzcGRhcHlScVROcWVTRjVGd3hVUWp2QXZoWG5v?=
 =?utf-8?B?Z3hWMGF2MHpJRXZnNlUyYXA0ZkpaeXZSQ0N4UHU3aTcrcUdmbjlvTGpsVlg1?=
 =?utf-8?B?czYzaDhEVXpXaUJNQW5pS0srTWFteGRhdUhyM2pKN3FjTlNRSDdUWFVJSzAz?=
 =?utf-8?B?TDhaMk9UVHoxb2hpek84bjZwNEpiL2FkdTNNdVZJMmdReHZoZTdWKzcrVGpp?=
 =?utf-8?B?VzdVQ1ZFSTRSYkRBTDV6cXdRaER4KzBrQzdxbldhRUJ5d21EczV0NDJRNnYr?=
 =?utf-8?B?OHdEbmgwblYveDkrL1M1Q1Y3N0ZTam93dkpBQStPRmxkVENSaXhZREFlNjZU?=
 =?utf-8?B?eDFENmVRdmI2RkE4d1BXSjkzdisrZjRvYVBzbWZGaHFaczJPNnRNSHZFaDVS?=
 =?utf-8?B?bG0xSWJFT3I2Mm9oUWFwZE8rWFQ4U0tacUF5S0NkaDF5R01WSy81ZVlXMmJT?=
 =?utf-8?B?cDJqT25Ub2VQZUhBSm9zNm1pWEJxdCtBRGt0dmVhQU1JeUpZa0dBZjN4dlhP?=
 =?utf-8?B?YlR0a1J6emlyVWhsZWlIN0IyVTBOTGxCbm9yQnFrM0hnNkhGNElQenA4RmIy?=
 =?utf-8?B?V2hMbDBMSlI4VnNsR0lIbUUxSDVRQnF6L2pUWU45MmNLNzNaSmNLRlFEK2FB?=
 =?utf-8?B?WWpEWXRsZVBOR0hRRVRrMnRKQU9nZ1FsUE9xUTRQTkM4RU0rc3dvdTkvWkhj?=
 =?utf-8?B?NURIQW9rekRYRW1BeEptMTRmcGRORUFLbUdSeUtURXpEWGFLTDZrSGpmUFI1?=
 =?utf-8?B?V2RwSmRMZHdJY1dCUDlRTm0vdDhPcFV6aVBkRzBJS3hqampLakV5aWR3T1RD?=
 =?utf-8?B?K1BFdUwwVlNlQ0djUFNoUDBvc2M0SU1LUmdQa2JuQU1kOGMxT2U4ZFQrdzM4?=
 =?utf-8?B?eUdQWmZiK0Q3NlhSbXVTUldBbHFiVFlXbEJRclJyVmxlaVBxTGxkTGZYdHY0?=
 =?utf-8?B?SHdVRUVJVkVEM2NKS2dwNHlacmxhYUR0clNCaHorc1ZsNC9ESkgzdkIxR2tG?=
 =?utf-8?B?cnl6WWo1YjZLWEswVjgreExRaC9GbXdsc2l5cWdkZzhuYk5ISGVvdlJ5WG4y?=
 =?utf-8?B?NSs1WXVVYzF2L29xbXp1TXBBSTFxL0dBQVU3RDIybGE2T2NIdmc4aGNRa2Jr?=
 =?utf-8?B?eGd0a3R1bVZsMkVrMUduNEtLcUNId1pFMGV4VkltbkJnT2JyWmpCSmNkOHZS?=
 =?utf-8?B?ZTNUN0FmSlo1QVA2YVliWmtQUDM2eFFPaUJ6NVcxKzhWaWVkU1Y0RGZhbklY?=
 =?utf-8?B?SksyUWNRZHd6TzhzRDNsU0trUHJ0c1QyRFZ3dldXcG5hRzNHWU1za3JKZ0da?=
 =?utf-8?B?djRIeHN3Mzh4Vm43R3dpOEUrcERGV0FJMy9pZE1CN09tNVMzQ0ZaS0VmMEd4?=
 =?utf-8?B?aXBvMFFEUjhFOXBoUzU4a3dvMmJUZnY3d1hrQXJYTXJjVXVYY1NpQWZPOW1x?=
 =?utf-8?B?WTRWZXp5aGEvS0JJMDRMZzY0MkplTnFiTjA3QXp4VzZwM3NXLzBsMWg4bnly?=
 =?utf-8?Q?51LUV9v3nGcEaV//Tp5fVARxO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0adfa4-2f06-4e3a-7095-08dc5ddbfd46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:11:00.7665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CvXzMPmN64+fbKFSsT3IcB8lbt8WWB6If/W4nfDHihUm2+vjyWgONbXKsG854ouTwb8MXQ/lxdrzZvyYsei5V/Y0HlPyQZuUJIog3KGtCzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA4LzEwXSB2ZmlvOiBD
cmVhdGUgaG9zdCBJT01NVSBkZXZpY2UgaW5zdGFuY2UNCj4NCj5PbiA0LzgvMjQgMTA6MTIsIFpo
ZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ3JlYXRlIGhvc3QgSU9NTVUgZGV2aWNlIGluc3RhbmNl
IGFuZCBpbml0aWFsaXplIGl0IGJhc2VkIG9uIGJhY2tlbmQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4g
ICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8IDEgKw0KPj4gICBody92ZmlvL2NvbnRh
aW5lci5jICAgICAgICAgICB8IDUgKysrKysNCj4+ICAgaHcvdmZpby9pb21tdWZkLmMgICAgICAg
ICAgICAgfCA4ICsrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2lu
Y2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbW1vbi5oDQo+PiBpbmRleCBkMzgyYjEyZWMxLi40ZmJi
YTg1MDE4IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+
ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMTI2LDYgKzEyNiw3
IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9EZXZpY2Ugew0KPj4gICAgICAgT25PZmZBdXRvIHByZV9j
b3B5X2RpcnR5X3BhZ2VfdHJhY2tpbmc7DQo+PiAgICAgICBib29sIGRpcnR5X3BhZ2VzX3N1cHBv
cnRlZDsNCj4+ICAgICAgIGJvb2wgZGlydHlfdHJhY2tpbmc7DQo+PiArICAgIEhvc3RJT01NVURl
dmljZSAqaGlvZDsNCj4+ICAgICAgIGludCBkZXZpZDsNCj4+ICAgICAgIElPTU1VRkRCYWNrZW5k
ICppb21tdWZkOw0KPj4gICB9IFZGSU9EZXZpY2U7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9j
b250YWluZXIuYyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+IGluZGV4IGJhMGFkNGE0MWIuLmZj
MGMwMjc1MDEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2NvbnRhaW5lci5jDQo+PiArKysgYi9o
dy92ZmlvL2NvbnRhaW5lci5jDQo+PiBAQCAtOTE1LDYgKzkxNSw3IEBAIHN0YXRpYyBpbnQgdmZp
b19sZWdhY3lfYXR0YWNoX2RldmljZShjb25zdCBjaGFyDQo+Km5hbWUsIFZGSU9EZXZpY2UgKnZi
YXNlZGV2LA0KPj4gICAgICAgVkZJT0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+ICAgICAgIFZG
SU9Hcm91cCAqZ3JvdXA7DQo+PiAgICAgICBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcjsN
Cj4+ICsgICAgSElPRExlZ2FjeVZGSU8gKmhpb2RfdmZpbzsNCj4NCj5zL2hpb2RfdmZpby9oaW9k
LyBwbGVhc2UuIFNhbWUgYmVsb3cuDQoNCldpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQoN
Cj4NCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4NCj4+ICAgICAgIGludCByZXQ7DQo+Pg0K
Pj4gICAgICAgaWYgKGdyb3VwaWQgPCAwKSB7DQo+PiBAQCAtOTQ1LDYgKzk0Niw5IEBAIHN0YXRp
YyBpbnQgdmZpb19sZWdhY3lfYXR0YWNoX2RldmljZShjb25zdCBjaGFyDQo+Km5hbWUsIFZGSU9E
ZXZpY2UgKnZiYXNlZGV2LA0KPj4gICAgICAgdmJhc2VkZXYtPmJjb250YWluZXIgPSBiY29udGFp
bmVyOw0KPj4gICAgICAgUUxJU1RfSU5TRVJUX0hFQUQoJmJjb250YWluZXItPmRldmljZV9saXN0
LCB2YmFzZWRldiwNCj5jb250YWluZXJfbmV4dCk7DQo+PiAgICAgICBRTElTVF9JTlNFUlRfSEVB
RCgmdmZpb19kZXZpY2VfbGlzdCwgdmJhc2VkZXYsIGdsb2JhbF9uZXh0KTsNCj4+ICsgICAgaGlv
ZF92ZmlvID0NCj5ISU9EX0xFR0FDWV9WRklPKG9iamVjdF9uZXcoVFlQRV9ISU9EX0xFR0FDWV9W
RklPKSk7DQo+PiArICAgIGhpb2RfdmZpby0+dmRldiA9IHZiYXNlZGV2Ow0KPj4gKyAgICB2YmFz
ZWRldi0+aGlvZCA9IEhPU1RfSU9NTVVfREVWSUNFKGhpb2RfdmZpbyk7DQo+Pg0KPj4gICAgICAg
cmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4gQEAgLTk1OSw2ICs5NjMsNyBAQCBzdGF0aWMgdm9pZCB2
ZmlvX2xlZ2FjeV9kZXRhY2hfZGV2aWNlKFZGSU9EZXZpY2UNCj4qdmJhc2VkZXYpDQo+PiAgICAg
ICB0cmFjZV92ZmlvX2RldGFjaF9kZXZpY2UodmJhc2VkZXYtPm5hbWUsIGdyb3VwLT5ncm91cGlk
KTsNCj4+ICAgICAgIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKHZiYXNlZGV2KTsNCj4+ICAgICAgIHZm
aW9fcHV0X2dyb3VwKGdyb3VwKTsNCj4+ICsgICAgb2JqZWN0X3VucmVmKHZiYXNlZGV2LT5oaW9k
KTsNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIGludCB2ZmlvX2xlZ2FjeV9wY2lfaG90X3Jlc2V0
KFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBib29sIHNpbmdsZSkNCj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBpbmRleCAxMTViOWY4ZTdmLi5i
NmQwNTgzMzliIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+ICsrKyBiL2h3
L3ZmaW8vaW9tbXVmZC5jDQo+PiBAQCAtMzA4LDYgKzMwOCw3IEBAIHN0YXRpYyBpbnQgaW9tbXVm
ZF9jZGV2X2F0dGFjaChjb25zdCBjaGFyICpuYW1lLA0KPlZGSU9EZXZpY2UgKnZiYXNlZGV2LA0K
Pj4gICAgICAgVkZJT0lPTU1VRkRDb250YWluZXIgKmNvbnRhaW5lcjsNCj4+ICAgICAgIFZGSU9B
ZGRyZXNzU3BhY2UgKnNwYWNlOw0KPj4gICAgICAgc3RydWN0IHZmaW9fZGV2aWNlX2luZm8gZGV2
X2luZm8gPSB7IC5hcmdzeiA9IHNpemVvZihkZXZfaW5mbykgfTsNCj4+ICsgICAgSElPRElPTU1V
RkRWRklPICpoaW9kX3ZmaW87DQo+PiAgICAgICBpbnQgcmV0LCBkZXZmZDsNCj4+ICAgICAgIHVp
bnQzMl90IGlvYXNfaWQ7DQo+PiAgICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+IEBAIC00MzEs
NiArNDMyLDEyIEBAIGZvdW5kX2NvbnRhaW5lcjoNCj4+ICAgICAgIFFMSVNUX0lOU0VSVF9IRUFE
KCZiY29udGFpbmVyLT5kZXZpY2VfbGlzdCwgdmJhc2VkZXYsDQo+Y29udGFpbmVyX25leHQpOw0K
Pj4gICAgICAgUUxJU1RfSU5TRVJUX0hFQUQoJnZmaW9fZGV2aWNlX2xpc3QsIHZiYXNlZGV2LCBn
bG9iYWxfbmV4dCk7DQo+Pg0KPj4gKyAgICBoaW9kX3ZmaW8gPQ0KPkhJT0RfSU9NTVVGRF9WRklP
KG9iamVjdF9uZXcoVFlQRV9ISU9EX0lPTU1VRkRfVkZJTykpOw0KPj4gKyAgICBoaW9kX2lvbW11
ZmRfaW5pdChISU9EX0lPTU1VRkQoaGlvZF92ZmlvKSwgdmJhc2VkZXYtPmlvbW11ZmQsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgIHZiYXNlZGV2LT5kZXZpZCk7DQo+PiArICAgIGhpb2RfdmZp
by0+dmRldiA9IHZiYXNlZGV2Ow0KPj4gKyAgICB2YmFzZWRldi0+aGlvZCA9IEhPU1RfSU9NTVVf
REVWSUNFKGhpb2RfdmZpbyk7DQo+PiArDQo+PiAgICAgICB0cmFjZV9pb21tdWZkX2NkZXZfZGV2
aWNlX2luZm8odmJhc2VkZXYtPm5hbWUsIGRldmZkLCB2YmFzZWRldi0NCj4+bnVtX2lycXMsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmJhc2VkZXYtPm51bV9yZWdp
b25zLCB2YmFzZWRldi0+ZmxhZ3MpOw0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiBAQCAtNDY4LDYg
KzQ3NSw3IEBAIHN0YXRpYyB2b2lkIGlvbW11ZmRfY2Rldl9kZXRhY2goVkZJT0RldmljZQ0KPip2
YmFzZWRldikNCj4+ICAgICAgIGlvbW11ZmRfY2Rldl9kZXRhY2hfY29udGFpbmVyKHZiYXNlZGV2
LCBjb250YWluZXIpOw0KPj4gICAgICAgaW9tbXVmZF9jZGV2X2NvbnRhaW5lcl9kZXN0cm95KGNv
bnRhaW5lcik7DQo+PiAgICAgICB2ZmlvX3B1dF9hZGRyZXNzX3NwYWNlKHNwYWNlKTsNCj4+ICsg
ICAgb2JqZWN0X3VucmVmKHZiYXNlZGV2LT5oaW9kKTsNCj4+DQo+PiAgICAgICBpb21tdWZkX2Nk
ZXZfdW5iaW5kX2FuZF9kaXNjb25uZWN0KHZiYXNlZGV2KTsNCj4+ICAgICAgIGNsb3NlKHZiYXNl
ZGV2LT5mZCk7DQoNCg==

