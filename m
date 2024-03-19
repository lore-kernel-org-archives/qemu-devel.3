Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0621C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmQSw-0006y0-Of; Mon, 18 Mar 2024 23:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmQSv-0006xa-0V
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:48:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmQSt-0007NO-9e
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710820119; x=1742356119;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o0SX37WkKHG+jTEokSUIt1XbCnuvcWOMmqMHhQIzqnA=;
 b=iHGgCfYkir6wqFg1GTypBD5XnUSiHfeXmIWBmuemvmMLJkbSO11ol9/g
 /SXKN/SlTzQHa8pmCDadM7pigGEANy/aBClKp/ecgvvbeR9X1EuDIHh0n
 L5z9jo2URORUFydBjKCADAwWtPj9Zqn6VsHuir1XcYPrcuuJ15UaYHcGH
 +OSSi6B0wnipFLR6sWKDdAdq14l4ZHb65OkOZooXKgpQJruj0CgV8bVVe
 6RZzzAMM0gbIa3IbZ/VCOFiEVrnWwUHB9AcUA2tYSQ3LWtEtVytHC4bHS
 XEfGuyl5elBOeAGFcejvBj8aylFu2yT0Ddj7lDj0wh/yR+Ets88kIoxK5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="23122728"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="23122728"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 20:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="44621210"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 20:48:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 20:48:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 20:48:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 20:48:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXuRUbj8b1dYrc2MNpo4oTTqlXeX/sEEw5SwcxUoj3EoqBsv8Ex0VESC9NOUY8GB1U6WvcYukAQoFntAkE8qDuLavD01IhhPlOnGNpiqJaIjxNQkn9iEEp5Ul3Z1S7giqb3kZv50VO/i0RCmhcJBntnddHGPTkadOWOZxJkd8zMw8QQGR4AsM81eqhVDDNdYaDrcCZWb1rwOD/rDYS5pjUQYKEj9vTyoNBVPRK/iFYG9PDqKQeHM0qPcqR+eYHy1n8vSS1wchJ104SjicajJK2w1sizjcDEtdZUzo1F4qljMzUurfmoTJvebmWEjA2HZEQYgG9qdNPLRStLT++6Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0SX37WkKHG+jTEokSUIt1XbCnuvcWOMmqMHhQIzqnA=;
 b=VUa7WpD+upA5jcKx3qIa//mCH1M/1OI2KBVWxsT1yPrWnGJl4XATXwNDbFGHi0SAxApYCLaiGa7idYBNbjNGeTFYR8EBERpd0AM14X4XsTy948dScEuK967VO4d3xEIF3CEdBGAOtJlXjUNMqAa4yaIeE68aJ5hyPgQRnt+v5REhXH9Vi1gjQrPQ7j06fLDW6jsLcj6cFnYeGIHdFOSxncW7zVXD2pBsH288L0FXo4ObVtNXTylQ1Ex0upx5tkNlWt+Zu8id1FgEHF7bR+6BP5z8ZwLwl4fB3G19LAZ6mf2yYxSp8vHH579Zel9+y1JPpS2X8lWzZRnx/auXPTFqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 03:48:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 03:48:35 +0000
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
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Topic: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Index: AQHaafrJT1f15ksRNUCyLoL+rga0E7E9q9oAgADguxA=
Date: Tue, 19 Mar 2024 03:48:34 +0000
Message-ID: <SJ0PR11MB6744E05C391A1FA08FBA6CA9922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
 <2d9b6b71-6913-4169-9759-0b25ae9eddbc@redhat.com>
In-Reply-To: <2d9b6b71-6913-4169-9759-0b25ae9eddbc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5142:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOQgEKdUtdTVKf2KX1GDSw8PS4blOXRHH0fbGJWD92BFzF2TPiol3S4R0VgszWjpWQ9RQEg2/ZHCg6VdJNNozLC2oslZ5H5e/aiWoVZUY1ICooDs+tDKaIKFCEO2/2AIiZqlPEoyDGUilv8FnLvwaplpzkEEdocGtWXVPoivgKamj8SUUXTt5wPORI1ShnJBKSYNSS0eF5ErH66lkMo/yjJ6Jjs9SQy/avRX+fhqcrChk7F+vFbLqy2FC+hWQcUW3gOhNswYhgq9G+EncsN1+TdnY8JSZi/Nsq84zwj20Di6nf+2PN60ldBbHp8DWfWHxT24dRI90SoUmj+nHOW9a8Ypb+Ullw4xom9bBCq1P0jon/MLKKpyBqRmJXlK6QyGs3xITiBK9k+UV+6ZGzozBsAkjhJuAaReYpyT14UOGDljI/6jfXoBtRuIMuvU4RNiKTSAIxF2Pof4wKP8+sxWPNfG6YWbAk8xP69/D8Gl2aiqhdbZunpVQWy0q7qIWuopRYJXFqzaR9GdHe0+ErfQE6fL13G/ZbigCRnX4XI7BnuLqlXaWfGKEqvUq4H4GvhPwk0v1LzBfPVof6jZazMxyj3+vk2uAMxj9oyr1DKOeujbzKBovANLGGTBDqOy9x59TuIff8jD50gJEWoDezZKq7HhxU/FVvlci1IX90P4B5M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXNqTGxBVm9kRW5Gak1HQTlTR3ZqaGhJNlF3SEs2UWNtbk54eStNZEtpTmJX?=
 =?utf-8?B?OE05TUY1SWYxdnc3bUtyUlNaK0UzTTRYblBuYUY2WExGZlR4SXNpVHFWQVl3?=
 =?utf-8?B?NnNPUzFFbmgxeDl2Z0JJU1VvWmxxelFhak90b2x4enNzWU5SU1RzMUNiSFZn?=
 =?utf-8?B?STQ2THhpLzI0S3RmUldBL2h6bENMTm9ubEVtSTREUjArNEQyd1BxN3Y1YUxI?=
 =?utf-8?B?RXF1ZjVNM0NUT292RHpYN1FVTmVnOXcwbkhrRytldGJoSURyZUJkTkErOTBp?=
 =?utf-8?B?VUNEZER0bmVCSnQxbHNhQVVmODFwbWZ1Vng5LzA4RThMMDVDaU1XZU1xNVp0?=
 =?utf-8?B?QVhqZWFiOW1paDdSNUdoU0Q4SlhnSFJTL2dSc1EybVlLRmtONGZudFhSb3hQ?=
 =?utf-8?B?dXprYzFOdnlWdHZSQU12aUtaL0srMnQyMEpQSGdxcXFudlZXVDVsanNqVndM?=
 =?utf-8?B?dnQrMTFRVDhyTDZhQ2NRdzU4bHY1Skd2ZktqMEFycmR2MXUrZGZQdWhMU2N6?=
 =?utf-8?B?N0x2czdDNW9peUw1U0M1bUF2SHdGSW81K2hFVThSRFZLUEJra0dYbUk2VDZM?=
 =?utf-8?B?cVFLWlBWa2tFeElVbWpDelhiUUNNV0FVaFlSRW5XNEhKbFZGOTBRNTBPZmp1?=
 =?utf-8?B?b0ZHNEoxY3N6eEpGVHRRQUh3U3NnSHNpeTMyTUh0T21iVGZqY2pSZWs0QThh?=
 =?utf-8?B?OCtnVGVIdjRnV1NEelRHQ2NVeFBNU25nY0NtVXovWHlFcjU0UlhGUG80d3hT?=
 =?utf-8?B?RXc2MnAxVlpYTWUwa3FlQ3VNRjdhNEVtM3dFM1h0eFRjK2xSbFdNcllyL0cx?=
 =?utf-8?B?UGIvTG5sb3JVQ0Qwa3FsYldBa21leloyUkoyOFBYanRyanJ4U2dxcmV3N0pz?=
 =?utf-8?B?Nm9IL2JTWUlSeEZHU2VMTzhGUXp3eUJKSCtNS1diL0o4WCtPL3RKZXBlckFa?=
 =?utf-8?B?MzB5dVkvVkUzNUtGL2xpMTIzaHAzSVB5T0hxeEFxOXl3bzhwSlM3c0h3OWJQ?=
 =?utf-8?B?K3Bjb2xjTGxRVTljRWo2TnNPanFQQkhnUmdmRm4rMVN4d0tJczNWMGJYcFdO?=
 =?utf-8?B?ZituZ2VyTlBJam9oN0JjUlQvSHYyeDJEYlZwT2ppSENBTjViTytXdk9QQkJp?=
 =?utf-8?B?N1JrSXBVZzRLaFFHcmtrQnFxRFJhb2REdzVjMnhJcjVBa2ErTldibTFiSHYy?=
 =?utf-8?B?UzV0QjI4azZLV1FjMmxqc0t3Qm83SVIyNDFFaFc2aWR1VnI1TGxoakVqREJp?=
 =?utf-8?B?WHlCTjdxdW1rZEpsaEFGcmMzVGRvWkVWZGh0elUrdXZiRytaMWE2MzFZOExn?=
 =?utf-8?B?S2VLYUtmeUZJQmJ4TGNuZW1xaGMrcnFXNUdMRkZEZGdTU2R6Y0VaYVdIVWl1?=
 =?utf-8?B?Y1VBNHhBdmdqRzNib1ZIQ0hIVDF3OW5JSDFCR0RqNmR5QTFPY1RHM0JnM0Zl?=
 =?utf-8?B?VGJvSjcyaEFnSTRTZDdhQlpOSytrU2RGcGpUTkVmWmRNSlNGT2FvYjFVK3Jn?=
 =?utf-8?B?SUZia3RvWE5FQzZGQUxvLzZLY3F3SkxvcFBIaWcvcjRaeUkzbUQvQ1BRS3JL?=
 =?utf-8?B?T1B6VmNmQ09KV1hZZFZackpKV1dLQWtqWWlraEZDOWtpRGdiVVhtSU1ZU00v?=
 =?utf-8?B?Z2QrQUZxR2dtVWYzOThyNG5hVmNyV3ZpaC9aNmNoSlJtbSt1SFhZcTlQbGo5?=
 =?utf-8?B?dW5KSlZBZy95RTFFOTFZT0VhdnZnM1FhWjRJdDUvby8vOVdXOXVyMmNBRk5r?=
 =?utf-8?B?d3pVWkh3eGF5VlB4THhkd1RvU2Jxci9WWWUzTGtSMzd4T0tRRFdFSytNSXUy?=
 =?utf-8?B?ekNMc0dlYzlxcGkwdDEyTEE1OGhWemViOWdHSnIwbnhMeXp2NWVidlNNV1dM?=
 =?utf-8?B?eEFtYWo2SDRieGt5UHNDa3ViT0I5YWtuandKUkVlaEIralU3TUpFdGJjT0Iv?=
 =?utf-8?B?ODZrdXU4N0hUNWxldmxWTmxRN2JTd2lLVk15UEVjZWZMaXA1bm9HV2ZIbmMv?=
 =?utf-8?B?dld6OE9helRwVm13Q1RaRDVpdkNyN1dmZHJEdHE3REE1OXFaaVAvWmcyQVNi?=
 =?utf-8?B?Y0NuWFJTZW1iZ29tZlI2cXRaS1NieERDOGVIVm1iRUdzQ2tHTG02V0RTcmNW?=
 =?utf-8?Q?XDEWJplnu/eAKn0SmqbyPBU2c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95535ffe-782b-4140-b1af-08dc47c77407
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:48:34.5675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u29ksmV3l35DwhPSEUCCBejnVpZM7WQrqdnuWwaxiBVE2mXFH6XWKfKT0KlYTOqQOQ40eW3+/+fhR9A7jifKys+LaZeO4Srsm6NcWqQEETU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDAxLzExXSBJbnRyb2R1
Y2UgYSBjb21tb24gYWJzdHJhY3Qgc3RydWN0DQo+SG9zdElPTU1VRGV2aWNlDQo+DQo+SGkgWmhl
bnpob25nLA0KPk9uIDIvMjgvMjQgMDQ6NTgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSG9z
dElPTU1VRGV2aWNlIHdpbGwgYmUgaW5oZXJpdGVkIGJ5IHR3byBzdWIgY2xhc3NlcywNCj4+IGxl
Z2FjeSBhbmQgaW9tbXVmZCBjdXJyZW50bHkuDQo+QXMgdGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHRo
ZSBvYmplY3QsIHlvdSBkZXNjcmliZSB3aGF0IHRoZSBvYmplY3QgaXMNCj5tZWFudCBmb3IgYW5k
IHVzZWQgZm9yLiBNYXliZSByZXVzZSB0ZXh0IGZyb20gdGhlIGNvdmVyIGxldHRlcg0KDQpTdXJl
LCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+VGhhbmtzDQo+DQo+RXJpYw0K
Pj4NCj4+IEludHJvZHVjZSBhIGhlbHBlciBmdW5jdGlvbiBob3N0X2lvbW11X2Jhc2VfZGV2aWNl
X2luaXQgdG8gaW5pdGlhbGl6ZSBpdC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBpbmNsdWRlL3N5c2VtdS9o
b3N0X2lvbW11X2RldmljZS5oIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPmIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21t
dV9kZXZpY2UuaA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAu
LmZlODBhYjI1ZmINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11L2hv
c3RfaW9tbXVfZGV2aWNlLmgNCj4+IEBAIC0wLDAgKzEsMjIgQEANCj4+ICsjaWZuZGVmIEhPU1Rf
SU9NTVVfREVWSUNFX0gNCj4+ICsjZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNFX0gNCj4+ICsNCj4+
ICt0eXBlZGVmIGVudW0gSG9zdElPTU1VRGV2aWNlX1R5cGUgew0KPj4gKyAgICBISURfTEVHQUNZ
LA0KPj4gKyAgICBISURfSU9NTVVGRCwNCj4+ICsgICAgSElEX01BWCwNCj4+ICt9IEhvc3RJT01N
VURldmljZV9UeXBlOw0KPj4gKw0KPj4gK3R5cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZSB7
DQo+PiArICAgIEhvc3RJT01NVURldmljZV9UeXBlIHR5cGU7DQo+PiArICAgIHNpemVfdCBzaXpl
Ow0KPj4gK30gSG9zdElPTU1VRGV2aWNlOw0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBo
b3N0X2lvbW11X2Jhc2VfZGV2aWNlX2luaXQoSG9zdElPTU1VRGV2aWNlICpkZXYsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZp
Y2VfVHlwZSB0eXBlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZV90IHNpemUpDQo+PiArew0KPj4gKyAgICBkZXYtPnR5cGUgPSB0eXBlOw0K
Pj4gKyAgICBkZXYtPnNpemUgPSBzaXplOw0KPj4gK30NCj4+ICsjZW5kaWYNCg0K

