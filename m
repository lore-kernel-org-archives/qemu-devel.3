Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD1BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwc1b-0004hg-3L; Tue, 16 Apr 2024 02:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwc1Z-0004hM-HI
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:10:33 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwc1W-00025U-Qt
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713247831; x=1744783831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PgB5jfefxUa/DDMfM+H5u4Ybm3Hkuy+zcYB8frVp/aM=;
 b=aVpBts35f/w6gXQiNC4rmAir745XY+o5nJZer8//mefvGVNVddTOabJq
 DXfgHK6hodOr5MtTd0EznOnoEjLbkkyii3Pr3ax36mfJIAOwET+m1d0tM
 bWO4DL4E1bBtnJ6Z080YHgLJPzMdMymEtcoZoTfMOosYCbnOoFBZ5Ev4D
 AqiBa6e6b0KwaMde4M+rmoO4+UYFuGVdRRLdrdTsBSv489zbzqVBA4hiA
 mJexOsDVeSjAh3QEmPOHL4FLRit7r6H7eToDE3+pBYdw63Cfp0979/Zru
 yCNfTOcWtocg7cns9N0uSCPkNmC35c6sZRwWCuHNZgGp6/qidHOir9DE9 Q==;
X-CSE-ConnectionGUID: FizfmHfiSOKK8ajKAy7tYQ==
X-CSE-MsgGUID: M3KiD7arRwmgloV5oncToQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="11613632"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="11613632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 23:10:28 -0700
X-CSE-ConnectionGUID: yE+Ysc0qS/CSdvayn5Vh4Q==
X-CSE-MsgGUID: Xg/XqCr+QziE1jo/G3HNIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="22054571"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 23:10:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:10:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:10:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:10:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwbKany6RQa29cZuqudk9qyQMHybpzi8l4wkE/Uy5hQgjs6I9NkJyv9vqlkU5sD8+m6THEP8C8E5zw8Z0b+XdGXNTJqI1U1H4Xm/1xmKHJO7Yfqd+Q/qiqTw3mpSNXrNKBaIR1PX8XcRaRP7YbnlxTjmeMnuLmfjzn2vo4nUsn6Kh93ku1profB2fl5Dk2H+e5TueXtCBmE+9Sp0RU+YKPOS9DP4cunDjPyFsxTLIfN5vgpLRyEdaw2sWT4VdppKKGkEi3vvUs7iMPTizu3ocRaQ0zXcW3u5Be0xkP0T3uf8eEjsQT0S8t7C4PTOPgE1Yg87bxsBvIRhj06JIysXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgB5jfefxUa/DDMfM+H5u4Ybm3Hkuy+zcYB8frVp/aM=;
 b=O95IVfux2kL32ydrpn0JF1Ebl9FgThEsgfTZrArJ7gQk6xwqteMnRgrMijykQ2wNYCGnGIt7TuB9XUYte95DxvhdVpMp1qa+suKxFl4dlZoggYd8tnrmqR6WYv051qDzhlcbS8QGDCx1c4OLEc8mD0mjvNQR6x1Eh5Vlw3oXoXAfKx7djObBcsBcxN1KXBKTfbzeUMgLYwDEaQe4+UObYC9Y2pzLvajXoGNdvNQrSbSxW29ggpmm/Z02IyU8uSqjJVHMW+9UutlB+5FqqQa/QkE9SUGxVvRoqNQk8qfX+aDusMl67tm2hGD/a5OlgWWcJkynlV7qxqaLXfQ8x/dSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:10:24 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 06:10:24 +0000
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
Subject: RE: [PATCH v2 07/10] backends/iommufd: Implement
 get_host_iommu_info() callback
Thread-Topic: [PATCH v2 07/10] backends/iommufd: Implement
 get_host_iommu_info() callback
Thread-Index: AQHaiYz0kaB9QOUTTEmkL/mM11pQ6bFpXQIAgAEXIUA=
Date: Tue, 16 Apr 2024 06:10:24 +0000
Message-ID: <SJ0PR11MB6744C506EA10D013C326D8FB92082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-8-zhenzhong.duan@intel.com>
 <bc974ba1-a4fe-47d7-9de7-7bc8a6229d86@redhat.com>
In-Reply-To: <bc974ba1-a4fe-47d7-9de7-7bc8a6229d86@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: f3362903-5f07-40b7-994c-08dc5ddbe776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jt+A53iF38GE+r/o+d+DCvNitAosXyg8rqQiZ9EZSo2jH0HZ6ZRHNJYWa4nW6YkLq5HFx0dS0gKhaFrsAE6pDQWNVSTQsdADRNUHlQAsGtIKKheU+Jf1kv7TJA8AuHhCqdPWarrHjKjqEYSxmPy2WPkTKTjkqb3jiOvvn2wjVZZt83clS/+GVyjvJnSkDvRcs4ekGF3KPPRi/HzWMML5V6rz9biJX5r1NnT4M+jyiLAcrzMRx6gzFpW4vQndQyWq8VVebots1gH8tMqMFtEzHNi/kdQFhxibndFKpWueXl+TgBqLRpg8A8CVKWcJuImrTgtxG12pGHBYNu2ciVSSP7iU73K8M6QD0jh79mGaAIvhLVvnrqkHk20MtoEdh1Ox8+HsOP9zfBNinEbJ6h/E1ooX3ak+MylcCUCnt1oyEWbPsKLgR8OEmYhYyzSjUJRLwRHwspbeg/QhW9pFZ2z9LYlU8TDVhjmS5RI+FFxh/2iJB9cTpKBavTXJpzX3/yX/GrDDFy2IQLASsj94glhmYxpGDuvySaAqJpht1jU3u4yd0/qPQjEwGfsJTHyEkoAn667D2mLjePL6xlDoq/ieE2cpGZ+Y/4E3W6xV3Y7hxUs4SVEAgoMOdhobH7xRjDEn51dqB1FPLN80y3UfpI7dxJKOB77lQ8F+2cmjefZaRaCLOFR9ozKIf7uNO9xNXS8mWbB7TVDbk/WJnJoeMbr7mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEV3ei8vMFFFemdxMmxYaGoyNllDbmRQdjJ6c2oyWXRJRjNDNlRHMEs0Mjhp?=
 =?utf-8?B?dHlRMDh1K2tTZVczdDlmOHgwT2xraXNRR0xZWFN5Z3ZHQnpHWTBYek1kNXFL?=
 =?utf-8?B?MEZOK3VNMzNaVHp1V1NnZEtUUVZtK2QzbkdCZlpuTEV6blowaUJjTDJvQlpp?=
 =?utf-8?B?dnExWnlBS1NqUE5WeFRVWG5vWVo1U0QzTElLV3A3MmJHbmNWWjNoTWtsU2xF?=
 =?utf-8?B?REVWd3ZqNEZ3dUdxVUdMMjlKWmd5NXo0MFpONFJpbldGZTlkM1B5Si9HcHYw?=
 =?utf-8?B?R2tFV1VQSi95TDF5RG92elRsZ3Z6aG1OV1NLOXJJSTFDeXNOb2UrKzFyOG9v?=
 =?utf-8?B?YUtZU3N4YUkybHJRbTRXR1kvZzZrK2hEZTBocE1OaHVaaDNObFpkaUZjaU9v?=
 =?utf-8?B?aW9uazRpbDg0UGxwWFlUUHlBL0dQSHl1RnJCQ1ZCUFpnNC84T0pYQlRQUmVI?=
 =?utf-8?B?MjFHbEEwZ0hON2FBSHMvWjZGSjl3U1hEV0dFRnZUYW00Z2VyeER1emc1V0xI?=
 =?utf-8?B?T2VLL0NmSUM3WlBUOThLYjdPcWJIS2ZPTU1oVXpMWnR1akJSWmp1TjB5R2ow?=
 =?utf-8?B?OXZLSUFpUWNVb3dlRlA1N3NJWjBJRXY3K3ZBUWdNNlM0RVdPYVJFQ1JYRFVK?=
 =?utf-8?B?UHlsUUdYQ0VrYjZCclhWczJhY3ovbjVvVUsyZUZkMy9heVAvK3hMcnN6UmRP?=
 =?utf-8?B?dENSVW1KRkVlSmh3VmRVTUc3cVNvNW1zYnN3eG84SkFEUS9BU0cvckVXNnFT?=
 =?utf-8?B?ZDJhQjQza09rUEY4UnRRSkluNG1tZWNGZFZXSEZ1WkFwb3QyTDZLTUx0RFI0?=
 =?utf-8?B?ckFkVE92Q0MxdDFSSDZnMDlvdm9NSzNONngzQ0x1SE15TTUzWXhhZW9OMlJS?=
 =?utf-8?B?bTg1cWMybXdtMS9GaW1ZK2JPNjBxR2Zld2tLQUg2MmZsaml5eno4am8zYnhG?=
 =?utf-8?B?Z3VRTVNmcmdFU2dQSk5zMEpuRWYzMmlOK0R6Uy9ndktuOWhEL1BjNDU1NWdv?=
 =?utf-8?B?a29STzVtQk5jK0xhQnh5dlYyVU9aK2ZFaVpOSW5uby9CSG5VZXV0WWlPRE9k?=
 =?utf-8?B?d3k3ZmtzUEhvMCsySE1DWld0bEFIR2ExdTdUNWlsS20zdDVhTVhXOFlRR1Bx?=
 =?utf-8?B?Y1JRUjROU1dWRnpTSFlvaUZBbWV1TzhWMWtKMFVYOXlCbGxwd3A5RWtzdWFs?=
 =?utf-8?B?Uld2aUpGSyt0Nm5Oa3c2TEYvbSt3Ni9HRHA0OVdoaGp0dUZaTStKUERTbWJP?=
 =?utf-8?B?Q1dKL1k2RExmN1Z2Tk9rNDkrUUhGcDI2UmROWkNJQkppem9mNjArMEJQUHZS?=
 =?utf-8?B?RHNBOWlMSHFJeWo5U2RlNEJuclVKUWR6U0E3Mk9aTW9SS0ZYU2RRZjFVZlE4?=
 =?utf-8?B?T2ZCWUg3eXJQQ08zeFhaUzVGMDZ4eVVxbzlMTlJCL1V2VGlUYURIVnUvZ0c5?=
 =?utf-8?B?blJzcnhzTlBxK1UxeHNNc1B5VlhweHhMQzA1RDZNTmhyQ21FMTlMUFlvQUJJ?=
 =?utf-8?B?SmJGR2VVTkR0RW9rZWhRRktCTW92aC8vSm5xZjhsaG5RdUxxbE1EanlzQm9v?=
 =?utf-8?B?M0l5OURaY3czMVQrYUxNL256L1pvanRhOTZ2VTEzQ00yREVpaUNDZWhtWm5K?=
 =?utf-8?B?K01QSldxRkNWWmUyTVQvNnQ1WVhjaUlZSk9ObnpPNmhadUVUV2g5Wm9YcXpu?=
 =?utf-8?B?WWFBcjV2RWdmc2FEaWRzcTg2SWRZU29mRTRXbm1UNTlFK0I0Nytid0ZHUTVv?=
 =?utf-8?B?dU1CY28wdER4Q1FNKzU1U0IyZUxWMjVKK3FVZDRYNjlCVElLbkxKWlVlS09v?=
 =?utf-8?B?RE5pUndObGdtMXhPR0g5aVdrT3ZRQ2pNbmI4M0tzeHF2THRsN2RPTEh5QVl5?=
 =?utf-8?B?aUU0bGZSbkdIMEVWOVNuSXp5MkpCQmtXNGkycWhneFpXVEZBQndacWIrL2hk?=
 =?utf-8?B?TUJmL055WXNFSnJnT2NuM2xlS0txL1V4NlR3MlliQnVkeVJFTXVjZ0NHakV5?=
 =?utf-8?B?OTRQbGQrN0xnNHdpaGE1V2gwYm5rYWxFcUdQRUl6eXUxZUFNQnZ6bWR1c1JI?=
 =?utf-8?B?cnZ0WE9VeE8wUVMyQnZnd2JCYkdZZkMvR1IwMmdGajdmZWVwb3ZtT3VFemlq?=
 =?utf-8?Q?qQ/87ZkMFBKXTvbYMUAgbynwh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3362903-5f07-40b7-994c-08dc5ddbe776
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:10:24.1718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOQOMeyzK98vFTJ7I9nkMhe/+Q6mV+D0qI2kHOUCeK+nV+NAB3sCLpLloEvdZwloJdXHB0Xa+QWT4QrpwzIQE+HbEYlSWvAHw46vmBd7VGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA3LzEwXSBiYWNrZW5k
cy9pb21tdWZkOiBJbXBsZW1lbnQNCj5nZXRfaG9zdF9pb21tdV9pbmZvKCkgY2FsbGJhY2sNCj4N
Cj5PbiA0LzgvMjQgMTA6MTIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSXQgY2FsbHMgaW9t
bXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIHRvIGdldCBob3N0IElPTU1VDQo+PiByZWxh
dGVkIGluZm9ybWF0aW9uLg0KPj4NCj4+IERlZmluZSBhIGNvbW1vbiBzdHJ1Y3R1cmUgSElPRF9J
T01NVUZEX0lORk8gdG8gZGVzY3JpYmUgdGhlIGluZm8NCj4+IHJldHVybmVkIGZyb20ga2VybmVs
LiBDdXJyZW50bHkgb25seSB2dGQsIGJ1dCBlYXN5IHRvIGFkZCBhcm0gc21tdQ0KPj4gd2hlbiBr
ZXJuZWwgc3VwcG9ydHMuDQo+DQo+SSB0aGluayB5b3UgY2FuIG1lcmdlIHRoZSBwcmV2aW91cyBw
YXRjaCBhbmQgdGhpcyBvbmUuDQoNClN1cmUuDQoNCj4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5j
bHVkZS9zeXNlbXUvaW9tbXVmZC5oIHwgIDcgKysrKysrKw0KPj4gICBiYWNrZW5kcy9pb21tdWZk
LmMgICAgICAgfCAxNyArKysrKysrKysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVm
ZC5oIGIvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oDQo+PiBpbmRleCBmYTFhODY2MjM3Li40NGVj
MTMzNWIyIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oDQo+PiArKysg
Yi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4NCj5JIGp1c3Qgbm90aWNlZCB0aGF0IGluY2x1
ZGUvc3lzZW11L2lvbW11ZmQuaCBsYWNrcyBhIGhlYWRlci4gIENvdWxkIHlvdSBmaXgNCj50aGF0
IHBsZWFzZSA/DQoNClN1cmUuIFByZXN1bWUgeW91IG1lYW5zIHRoZSBjb3B5cmlnaHQgaGVhZGVy
LiBGaXggbWUgaWYgeW91IG1lYW4gb3RoZXJzLg0KDQo+DQo+PiBAQCAtMzksNiArMzksMTMgQEAg
aW50DQo+aW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJT01NVUZEQmFja2VuZCAqYmUs
IHVpbnQzMl90IGRldmlkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlbnVtIGlvbW11X2h3X2luZm9fdHlwZSAqdHlwZSwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgdWludDMyX3QgbGVuLCBFcnJvciAqKmVycnAp
Ow0KPj4NCj4+ICt0eXBlZGVmIHN0cnVjdCBISU9EX0lPTU1VRkRfSU5GTyB7DQo+DQo+UGxlYXNl
IHVzZSBDYW1lbENhc2UgbmFtZXMuDQoNClN1cmUuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4N
Cj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4+ICsgICAgZW51bSBpb21tdV9od19pbmZvX3R5
cGUgdHlwZTsNCj4+ICsgICAgdW5pb24gew0KPj4gKyAgICAgICAgc3RydWN0IGlvbW11X2h3X2lu
Zm9fdnRkIHZ0ZDsNCj4+ICsgICAgfSBkYXRhOw0KPj4gK30gSElPRF9JT01NVUZEX0lORk87DQo+
PiArDQo+PiAgICNkZWZpbmUgVFlQRV9ISU9EX0lPTU1VRkQgVFlQRV9IT1NUX0lPTU1VX0RFVklD
RSAiLWlvbW11ZmQiDQo+PiAgIE9CSkVDVF9ERUNMQVJFX1RZUEUoSElPRElPTU1VRkQsIEhJT0RJ
T01NVUZEQ2xhc3MsDQo+SElPRF9JT01NVUZEKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5k
cy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IGluZGV4IDU1OWFmZmE5ZWMuLjFl
OWM0NjllNjUgMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+ICsrKyBiL2Jh
Y2tlbmRzL2lvbW11ZmQuYw0KPj4gQEAgLTI0MCw4ICsyNDAsMjUgQEAgdm9pZCBoaW9kX2lvbW11
ZmRfaW5pdChISU9ESU9NTVVGRCAqaWRldiwNCj5JT01NVUZEQmFja2VuZCAqaW9tbXVmZCwNCj4+
ICAgICAgIGlkZXYtPmRldmlkID0gZGV2aWQ7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGludCBo
aW9kX2lvbW11ZmRfZ2V0X2hvc3RfaW9tbXVfaW5mbyhIb3N0SU9NTVVEZXZpY2UNCj4qaGlvZCwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRh
dGEsIHVpbnQzMl90IGxlbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIEhJT0RJT01NVUZEICppZGV2
ID0gSElPRF9JT01NVUZEKGhpb2QpOw0KPj4gKyAgICBISU9EX0lPTU1VRkRfSU5GTyAqaW5mbyA9
IGRhdGE7DQo+PiArDQo+PiArICAgIGFzc2VydChzaXplb2YoSElPRF9JT01NVUZEX0lORk8pIDw9
IGxlbik7DQo+PiArDQo+PiArICAgIHJldHVybiBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9p
bmZvKGlkZXYtPmlvbW11ZmQsIGlkZXYtDQo+PmRldmlkLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5mby0+dHlwZSwgJmluZm8tPmRhdGEsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihpbmZvLT5k
YXRhKSwgZXJycCk7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgdm9pZCBoaW9kX2lvbW11ZmRf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+PiAgIHsNCj4+ICsgICAg
SG9zdElPTU1VRGV2aWNlQ2xhc3MgKmhpb2RjID0gSE9TVF9JT01NVV9ERVZJQ0VfQ0xBU1Mob2Mp
Ow0KPj4gKw0KPj4gKyAgICBoaW9kYy0+Z2V0X2hvc3RfaW9tbXVfaW5mbyA9IGhpb2RfaW9tbXVm
ZF9nZXRfaG9zdF9pb21tdV9pbmZvOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgY29uc3QgVHlw
ZUluZm8gdHlwZXNbXSA9IHsNCg0K

