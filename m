Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E18C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVXY-0004cV-Id; Mon, 26 Feb 2024 02:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reVXU-0004VP-4Z
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:36:41 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reVXR-0004G0-DS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708932997; x=1740468997;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6SQ6dvuY8mmsmQuocma/E2J8IT6p/bAW+VQJf13+yKM=;
 b=OHF87vBhXkksjfwKn3c7q6HD0StoXj03hmxPi/yxEjEVu28qVQGEFx4q
 7expnqFQGQ8hcW3f6pVVkqLlWJK8VBp/HyWFhxI+ionO5CCtU3Im6xAQ+
 grEV3YoW3o0PXdsKnBqBcI1ySvhgncAsVvWaaqEpqMx4Kp6kVuAGPIMlN
 ioTBbqWX12jRmKvYWp5ocfBzmCilmfMG+SHxRVcS7kuGsec1CCceEiAx6
 VelvLBUUCZYCJZ/6pA0uC07lkI10ghxF5+rrz8YuYw+6DyqNiNANhQMbv
 BuZojR5Fr6jeQnJYBLbHXfkyJaWefiUgQG7QkAtR0wEJCjCYb6u1hKoJT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3366243"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3366243"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11163721"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 23:36:34 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 23:36:34 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 23:36:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 23:36:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 23:36:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReujAP6dtDAaZdT5kFUHqj6KucdzPpR2DzJTWQ3Ks7mng3tvMaBY4RGSeinducES/rHnt+D79TKFDY5twUgrlq7SL2YHGNsFiZVu0e/ZOOiBMEIkJjfzQ3P06u6X8NAub7kkow5+ixy5pLFAWLy0EsUJt2TKLwxCpNE0f4I1xGmQ3T5dov74yXP2slOJp4y4iybMhz2GcD80kTHo8e+TqRIuB0dxKC5Ok8zjbGCQY0NqZ7uEpO3MDdkfD53P3bJtLFqqosdzFKsxajL7vqlknAO+c7tfJHRNSn2wK7tX8QYVuFbcfmAhGUyUqWr31d9ijQOYkNQmgo1MgyGDhN6ACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SQ6dvuY8mmsmQuocma/E2J8IT6p/bAW+VQJf13+yKM=;
 b=QOoXTlPT5iflixINbInLNodvfegBpZRMaFzOJIH9WV5IdTjwH5/PamqnnoNHN8esUcQPMHKjyZIosisPxw4RyOW2zECcAiNdVEZF9EQWE2H3bYAd+/l5mH0XO+ccRRzo3Uj+Ku7EleJPw3TgHX2xwBbAfxZ/a/AziN7s+hrfgHL0wN7BiKADmIihUMxYiGJ+66+mAQcCAMT//4YUjXfdsgForc96rbeHKIxejBnihbAMTTToUsPd4BFnmzWE/d8gwaUXJNkABTjBgUil7C7njTXVWa4LYxOmFNzV76reLbn7zt9oDE9Xcpn/OciJWsSMBxW1bK6ZeKDhvMorLSpZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 07:36:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 07:36:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 14/18] intel_iommu: Add a framework to check and
 sync host IOMMU cap/ecap
Thread-Topic: [PATCH rfcv2 14/18] intel_iommu: Add a framework to check and
 sync host IOMMU cap/ecap
Thread-Index: AQHaVOCvLKkgATPCU0WWK72+ETI33bESDswAgApB1qA=
Date: Mon, 26 Feb 2024 07:36:30 +0000
Message-ID: <SJ0PR11MB67441887EF4A8F6658DD86F5925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-15-zhenzhong.duan@intel.com>
 <750f1f96-5e6f-4ef0-9436-9b7947515e05@redhat.com>
In-Reply-To: <750f1f96-5e6f-4ef0-9436-9b7947515e05@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4884:EE_
x-ms-office365-filtering-correlation-id: 522b0189-d2e5-4663-63a9-08dc369da670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Donxo1aAMvqz4zdXCZqJ4zXwIFlVisqr4rGpstkKkzRMDzezeRrNmq+nijUiZ7Rg1ICDMPk/gn1rmjg0+42Ec3+ClEu2LxNtxeFA36TxwGD16ZVzV9JL15ZtCYpcnFPccBtQPSxn4nHoKRbCHTvDyHwzj3cpfjF8Mbrv8lx0u8f5zkUrYuAxhCUFUhDH8ede/FejoiUP0nHxNvZjnBCpiQdeENI+iHRH0FlzCynSYRf2AOeF3/+pfQlgu2vp286Gxd95E7B2Ze1AMpnkBZ6Tny8Qcob2n7zbAa+CPc3mejt7sETzuiS1ZwMfRGu9YuzhOKjM9buK0ohxKz6Csn5UfD4OkIieendaEU0UrOFrkUXbl+9hERpPeciFWuWfR/LQRMRRr0atibw6pFYv5nFbtI0bFrJPkqV0DEIkiZEBRcPP7n7CNI/86REjX7yg2Y7tbTCCFn5odQdBXVqu7/jYWg1+CC7NwcOkrdF+ktfeKQTYSS7Zrow9mO6BjeJypfvda1kxpS/7tLrQBgxmrK7/k9Kk3ifvSTdprXQpNnl/vUeMSPOEGfkWSBwJHgBALnJ7rZa9WV6PXr8gBNueMxuZih4elKUdWicSo/c3+U69TC+kYD2lzVKXW0ZDlOwwC1nDo7Ufvop5M0whYojxlNp2g2SbBzJx5beeX9XohiNpCF1wMa9tnyoMoxk/pTxOKlr1+M3sW3maymoBL9CydJt6qhDTydkmfH/j6n6ePEn/us8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1VMRVVnb0NQdXJHc2hCQ25FbDUwSkdkU1BVNjBUMGhmRXA0cmlmZnZheTgr?=
 =?utf-8?B?RzBoRjlUOWFCRk5pRFJHZ2ZxT1JKdnovNXpyUlZWUklSYXd1VlhMNXBTSWpy?=
 =?utf-8?B?aWpYN3Y1dTZ3LzZ3d2ViMFRLSW0yRWlTWWQ2MFR0eVZURy93RldkbEZpSEZD?=
 =?utf-8?B?R3U5aEZjQXlXM0FGeW1sOXB1UkZtUFFzTk9zRkhQOFB5VHZRazR3b0FRSmRV?=
 =?utf-8?B?MHJVaTVMRzZkZHFwM1AxU2hCVk1FRGFHakg5L0RheTRSUmJxaUpzTDE2dTZs?=
 =?utf-8?B?dDJHc2IzVFdOclVmWVZuSkIya05LdlQ3dnQ4azZvdFIwRDJoVkdWQitvdGpa?=
 =?utf-8?B?UTB0d3ZhN282aGxsbjUxTDc2blFjU0YwZExWWHRyNkhldm5ydWN3dXZCcThX?=
 =?utf-8?B?UlpwNDRaUkJhVDJQQ3JERXVLL3RtU1g2T0RaWE93WWo3NEFYcHFORkNsOStG?=
 =?utf-8?B?T2hGdzVRdUVnS1BQMk80MXZxOVpsSitWeCtlWlkzTGpFN3J3Y1h3cVZrUVR3?=
 =?utf-8?B?em4vNnRrdWdIVUlZcGdWVHNOKzNGSzZDWDl0aTVpSElUMlJMTVcydm4zWE9i?=
 =?utf-8?B?eEVtaDkwK0t6ZWt0SFY2OGl4eEJsbktxL3h3V3FFT0E2UGNZWWh4clg2RzR3?=
 =?utf-8?B?TnVNZnhSZWNaZk43Y1lqa0VGTDhha3I5dzlBbHA5aVdYQWRYaXFzZDVqeTNp?=
 =?utf-8?B?bElERXc5d0hDZlNtYW8wMWszNmZwamZXK1pKeFB4dkhKTWRTWVh4MmN6ZEl3?=
 =?utf-8?B?N2pBSldaY2oySVFFRXk3T1JKejRZQkt4YVpUV3RnRWs1STBkRHVYTFJDN2RK?=
 =?utf-8?B?dThydGdvNHZNQkVrRmVveVdiNnFxNWJLTC82QlFaOUhzT2N0YW9TU3ptS2x2?=
 =?utf-8?B?M0JvY1dpekZjWEExbDk1YmF2eFV3TXJIR3RPYjhFeDJka0hDYTNLalVNeTk5?=
 =?utf-8?B?N0JzcVhlb25FUnpNbUp4SDdYTVlMWFlGY29icjdWU3REZTlIS2tqN0ZWcEZv?=
 =?utf-8?B?RUoxVitDMy9HRVdyZUw2OEtmeGV0MU1XdVJZRmx1Um84a25rOUJzOXBXNFdT?=
 =?utf-8?B?WVNZNjhrdEw0RVltTGZjdDlFMUZjRngwR2g1MEpXbmw0cVVIUi84Szc0bUlJ?=
 =?utf-8?B?RmtQQk9pWFp0Tk81NEpIREhQaWdPV1o2Rm9kNzdoZ1dMbXFQOUdRUm5OcnRZ?=
 =?utf-8?B?VDFkS2hma3NwdjdINnFkd2RqMjFMd0JpRWk3emlFcmc1YURVUHlXZklWVUpx?=
 =?utf-8?B?WEdHR1RSMWRvQksza1BXM2o4dStuOGo5WFlZR2JLOEQ1TXZoZThqUTJoRTA2?=
 =?utf-8?B?NTQwR2NCRG9RT3FaQndjcklMODRDMkJsK3VYeFM4NzdlbUs2VzBZQVB4Zit0?=
 =?utf-8?B?TWNCbzAzWkFobTk5VG44M3M1TUZjSXpyVk5NbjIyQUIrRDE2R0hLeWdtV2hj?=
 =?utf-8?B?Tk5XRVJwdUlQRDVqYktpZzhROE00SUJJdXlRRjNwKzkwVFlsdDR4amZManE4?=
 =?utf-8?B?R0ZTVTU1WTM2d1dDRWdTQUtwQUxEemE3RnNmQnBwNjJUOEhEd3pHNWFZdEhX?=
 =?utf-8?B?MHUxUFVIVVF3RUFNQWh4Rkg3NjBveHhPYUhpWWFoci9kaTduOWRMbDJaSVZN?=
 =?utf-8?B?S3M4STU2c1lvbXlNRnpsM2lIczRzdkMxR0lsMy9zUDB0cWdiZVg4Z0J4SDdC?=
 =?utf-8?B?MXBLRDBudFN4Q1R5SWFjMk9DWUVEa0ZiMUhPMWRJN01aTVVnR3VFcEN1UEZK?=
 =?utf-8?B?MDJjYkcrcFErcktLSGhtcFhiTENRMEhIWkgwRWxoZU9ka0VqanBoRVJwLzA0?=
 =?utf-8?B?bXkyZlRjbWJBUDlNQUhRZDVtcUwxa3BRK3J6WURMZGxWclFYZS9sMkhKVU9O?=
 =?utf-8?B?dDh5YU5kWEs4dU9rblhleDVuVDBoWDBXNTJUZkZJb1ZCUGFOQTFldmRTVUk0?=
 =?utf-8?B?NGYvSmNqVmYrWERWWGtEbGhqSldSSml2dHNGUWg5SmdVYitlWU9aTlZpK2Zo?=
 =?utf-8?B?Z0lOZHp3YmhNcTdwNy9xWGNkNjRzV3V1dzUrcVZhZDNKa3ltTlhmcmlKYlpz?=
 =?utf-8?B?Snl1OUNLcHNzSlpIRUE3YXMxUGhxc0QyL01ieTlqeHFSWC92ZG4wb3dBOVYw?=
 =?utf-8?Q?m8LmTBLRnBiTciIe3NwxROaT/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522b0189-d2e5-4663-63a9-08dc369da670
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 07:36:30.9424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Y4k+rl3jJfBPccECoVLyP+nLkI0IrURX7FZtLEN4l6vaVZYTM85HE55nJri6X0cu9lIQNDAabLc+6lFpnTIX9+khEsBxyGbwDqGseY8PW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDE0LzE4XSBpbnRl
bF9pb21tdTogQWRkIGEgZnJhbWV3b3JrIHRvIGNoZWNrDQo+YW5kIHN5bmMgaG9zdCBJT01NVSBj
YXAvZWNhcA0KPg0KPg0KPg0KPk9uIDIvMS8yNCAwODoyOCwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+PiBGcm9tOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+DQo+PiBBZGQgYSBmcmFt
ZXdvcmsgdG8gY2hlY2sgYW5kIHN5bmNocm9uaXplIGhvc3QgSU9NTVUgY2FwL2VjYXAgd2l0aA0K
Pj4gdklPTU1VIGNhcC9lY2FwLg0KPj4NCj4+IFRoZSBzZXF1ZW5jZSB3aWxsIGJlOg0KPj4NCj4+
IHZ0ZF9jYXBfaW5pdCgpIGluaXRpYWxpemVzIGlvbW11LT5jYXAvZWNhcC4NCj4+IHZ0ZF9jaGVj
a19oZGV2KCkgdXBkYXRlIGlvbW11LT5jYXAvZWNhcCBiYXNlZCBvbiBob3N0IGNhcC9lY2FwLg0K
Pj4gaW9tbXUtPmNhcF9mcm96ZW4gc2V0IHdoZW4gbWFjaGluZSBjcmVhdGUgZG9uZSwgaW9tbXUt
PmNhcC9lY2FwDQo+YmVjb21lIHJlYWRvbmx5Lg0KPj4NCj4+IEltcGxlbWVudGF0aW9uIGRldGFp
bHMgZm9yIGRpZmZlcmVudCBiYWNrZW5kcyB3aWxsIGJlIGluIGZvbGxvd2luZyBwYXRjaGVzLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0t
DQo+PiAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAgMSArDQo+PiAgaHcvaTM4Ni9p
bnRlbF9pb21tdS5jICAgICAgICAgfCA0MQ0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
Yi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggYmJjN2I5NmFkZC4uYzcx
YTEzMzgyMCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAgLTI4Myw2ICsyODMs
NyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4+DQo+PiAgICAgIHVpbnQ2NF90IGNhcDsg
ICAgICAgICAgICAgICAgICAgLyogVGhlIHZhbHVlIG9mIGNhcGFiaWxpdHkgcmVnICovDQo+PiAg
ICAgIHVpbnQ2NF90IGVjYXA7ICAgICAgICAgICAgICAgICAgLyogVGhlIHZhbHVlIG9mIGV4dGVu
ZGVkIGNhcGFiaWxpdHkgcmVnICovDQo+PiArICAgIGJvb2wgY2FwX2Zyb3plbjsgICAgICAgICAg
ICAgICAgLyogY2FwL2VjYXAgYmVjb21lIHJlYWQtb25seSBhZnRlciBmcm96ZW4gKi8NCj4+DQo+
PiAgICAgIHVpbnQzMl90IGNvbnRleHRfY2FjaGVfZ2VuOyAgICAgLyogU2hvdWxkIGJlIGluIFsx
LE1BWF0gKi8NCj4+ICAgICAgR0hhc2hUYWJsZSAqaW90bGI7ICAgICAgICAgICAgICAvKiBJT1RM
QiAqLw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KPj4gaW5kZXggZmZhMWFkNjQyOS4uN2VkMmI3OTY2OSAxMDA2NDQNCj4+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+PiBAQCAtMzgxOSw2ICszODE5LDMxIEBAIFZUREFkZHJlc3NTcGFjZQ0KPip2dGRfZmluZF9h
ZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+ICAgICAgcmV0dXJuIHZ0
ZF9kZXZfYXM7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVja19sZWdhY3lfaGRl
dihJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSU9NTVVMZWdhY3lEZXZpY2UgKmxkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArfQ0K
Pj4gKw0KPj4gK3N0YXRpYyBpbnQgdnRkX2NoZWNrX2lvbW11ZmRfaGRldihJbnRlbElPTU1VU3Rh
dGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VRkREZXZp
Y2UgKmlkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoq
ZXJycCkNCj4+ICt7DQo+PiArICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMg
aW50IHZ0ZF9jaGVja19oZGV2KEludGVsSU9NTVVTdGF0ZSAqcywgVlRESG9zdElPTU1VRGV2aWNl
DQo+KnZ0ZF9oZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KQ0KPj4gK3sNCj4+ICsgICAgSG9zdElPTU1VRGV2aWNlICpiYXNlX2RldiA9IHZ0ZF9oZGV2LT5k
ZXY7DQo+PiArDQo+PiArICAgIGlmIChiYXNlX2Rldi0+dHlwZSA9PSBISURfTEVHQUNZKSB7DQo+
PiArICAgICAgICByZXR1cm4gdnRkX2NoZWNrX2xlZ2FjeV9oZGV2KHMsIHZ0ZF9oZGV2LT5sZGV2
LCBlcnJwKTsNCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gdnRkX2NoZWNrX2lvbW11ZmRfaGRl
dihzLCB2dGRfaGRldi0+aWRldiwgZXJycCk7DQo+Q291bGRuJ3Qgd2UgaGF2ZSBIb3N0SU9NTVVE
ZXZpY2Ugb3BzIGluc3RlYWQgb2YgaGF2aW5nIHRoaXMgY2hlY2sgaGVyZT8NCg0KSG1tLCBub3Qg
c3VyZSBpZiB0aGlzIGlzIGRlc2VydmVkLiBJZiB3ZSBkZWZpbmUgc3VjaCBvcHMsIGl0IGhhcyBv
bmx5IG9uZSBmdW5jdGlvbg0KY2hlY2tfaGRldiBhbmQgd2Ugc3RpbGwgbmVlZCB0byBjaGVjayBi
YXNlX2Rldi0+dHlwZSB0byBhc3NpZ24gZGlmZmVyZW50DQpmdW5jdGlvbiB0byBIb3N0SU9NTVVE
ZXZpY2Uub3BzLmNoZWNrX2hkZXYgaW4gdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKCkuDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

