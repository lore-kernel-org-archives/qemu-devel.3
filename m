Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA6DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 06:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reUuP-0006Qy-Qb; Mon, 26 Feb 2024 01:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUuO-0006P8-SN
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:56:16 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reUuN-0001QR-C5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 01:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708930575; x=1740466575;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IZDAZ54B2Jxg2fENoNNb06gjZKN+Xw2o6th3wROUrCc=;
 b=AxgXEJBVNQdMKQw7j1h4JPXyOB1PLYYDvUHyuhpu4CDvgkuMdELoI2d5
 kYx6L6Wl/wjLE887k3j+K7c5mOktdlCyTyifiYBmtFS8oXeSHktg9xTLT
 NBwHo/goAjESk7KuNjlSfqf+RgioTXvYy5q/qL/RagWASqT6qWnPdLICW
 LVugJzp3oSgzmSRDM5WBS+8uB/rBASMn1ZgLNyjMfksE3djRpumXva3GG
 7dXa0PgClpyFwH3LSTeNr5YVHwD59VNXPUPe95hjFvZlQeFxYxzvgDl/N
 tO99Rl7PDBS1wHLfH8M3ZDYINokpvUihWJdrWqv5GNqyeorFG1cuJ+BR6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14614709"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="14614709"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 22:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11251838"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 22:56:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 22:56:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 22:56:12 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 22:56:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFNXwGnZnQg2D/swC5b9SKwj1SvofmFMPcjDv1sQqghQOvivRPS0AtwVPMD8Kn+od7PIqpaTEZjnaYB4/9vY1sHn6d1B5UH6DWEGjUtlTY/xlercAGmq3vm87gESj5iHBX0TJXqtkaMNmGn09REEa7t9GYs1PrsV8s250cwuI39m6eAjXVVqah0Jgz6/rJO/9KPwlNxTNd9F2dFYNb+aCQzVutrkrN6sRW0IPAVktoupUcnaqG9c3kKHZm1SVLrmNdP180Z0XAq4LfJ34ktCFl+YBD93bu4AnlGe9sz/r27grIS9EdTExzPAar6cbegYzCEL8P0zuRLcl5OzcYZDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZDAZ54B2Jxg2fENoNNb06gjZKN+Xw2o6th3wROUrCc=;
 b=A5ooZRtgA7SHxwV1i4VmpbSVN0obheiHPKcImcybqlrY1fmozgpkCsy2mAba/T+HSNsl0OBsn3UZifJ8jFti/mMNnFD8YEOtrYXqrZL25LpjsWbYE1XPftORp4j54LbuKq3zaoRzanyaVO+LCLmoIzNUpgWBmalUiXo2JHy2gpHBH0U6U5t/oGThhURG1nvODcPK/pVrlPjOsdYC8UhFlvJf1oLT2u/phNgoi7Khdt0SLJD7lQdjg/KLjkhQpIdF/JydvhAn8AuKCB341hG49a6NKYKjOElRrGCuNxzaCRlsuI3a8L03YJCiye1NGZC8RxYIpGeFOlPw85Sv3ckI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 06:56:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 06:56:09 +0000
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
Subject: RE: [PATCH rfcv2 07/18] vfio/container: Implement
 host_iommu_device_init callback in legacy mode
Thread-Topic: [PATCH rfcv2 07/18] vfio/container: Implement
 host_iommu_device_init callback in legacy mode
Thread-Index: AQHaVOCj3SondD992kWwkiUJTv7mzrESBEQAgApTl0A=
Date: Mon, 26 Feb 2024 06:56:09 +0000
Message-ID: <SJ0PR11MB674449E8897A195A557093A6925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-8-zhenzhong.duan@intel.com>
 <16acbc9f-7895-42b4-b762-55b36a1cc7df@redhat.com>
In-Reply-To: <16acbc9f-7895-42b4-b762-55b36a1cc7df@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB6863:EE_
x-ms-office365-filtering-correlation-id: ad9f1f8a-2582-45ff-05dc-08dc3698030c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gw0h/mF5+vhmPeHmEdorP3jg8BXmusdpOJQd+0G+wVs3KHmju/waKjl8APrJVMlItN5oixu/5wrpenCwCTvUwtemSmvS3F572vxMiqS6ARlXdApVtKrjQn8huTRJv7NcX6upUyfGNbqZLZzEkdqxx7JGqfWH0Iu0nxVJnrraqDFlAKsh3Eq3+NLUf1lwIa1GOBSDeG/lff9ymkFP3YGUmEy88xY6GyY7+4/rfSNR26lSTPRhGiy1v69i8V+NwHgpJP8YeKiIl1O18W0/Rx4Wcg5yUOSurSgET8rbGme2AuQi40inKb24GJBFe+v9QYukORzIOWTo1JGQlY+Mn4mJdPiwHBx8rSDPRWATr3BPlsHdh8I8vKMkG44A0mwftil1kSq5Un1rW5Q58jCSy4UOdRVR3uiD3D3mRDiccbnWjGYO9UpWat0iaWOtm0IYKPKXPTUilfMCm1tP5nvUSOivsEMbokQklR8AOtMA4VwyUktIo0tGq3BT2+XR7I5j3l9c2TrviT1TIxvm4JXj1ndM5KX93QBfc04xl39bobZfUmZfV3RCh3KIZCNKUBVW1YsKiOsxrnpqG81daj2BdPVhxDlibOuldws4Hr3RrGFNC8PTbAWmFwIgiRt+sc0uHGsJeD0GcL9PT98iBb2Ckn4HoAMyDQ1weSqfocyLWDW+lp+kSLjDFeP6xuE/c0eD7jH+inH60o2WCY4q5fn9dlTEwJREWPIpvxbRZerZVgRzA/g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnoxNDEwekVQaDNray9NaWdxVTRWN0V5L3NGM0RBM1AzR29BeGZpQWkzZWZt?=
 =?utf-8?B?TmhFbEhkKzE2VDNGSTk4eE42VTFkSHZvbWRlSEhuTDdZWDN6b0wvVm1DbEdi?=
 =?utf-8?B?Vm9pT0U1ZWNFaGxZOTFERXg0R2xVa0hINVhndE40ak5CazJhbUJNL2lTNW4r?=
 =?utf-8?B?cWpTS1ZkL1VqeUdPT28ySUJxYmVmQlpPaGtvbFRqWjZoNVN6eHo3cXpJVG4z?=
 =?utf-8?B?eXRsZjVZdGlweHpYcmtMOWtEUEIyNFpkK1pZTlFkU1p1QnVQZnJkZk9Wb2dI?=
 =?utf-8?B?OGw1eEhIemlDdjdWNzZEL0huT1I2V0NFaHMveWY3RGVqUXU3QjVKUG94REoy?=
 =?utf-8?B?dkpyM1BnOVJ0NG1oRVUwZTladEJraGRZNWhnRk9NSXBabnVSMDRnUnhtU1c2?=
 =?utf-8?B?bnlEU2o0YVpkdk9sWUZnT1hPaEh0NktrZEg2OUxBL0lVZVQzcWlNR0hDSU9X?=
 =?utf-8?B?c2R6L2pvTE9OK3JXUUttZzE0WVNucnZ5aTdnV1dldWJSVmpENlFCZk03NVg4?=
 =?utf-8?B?MkcvcXlnWHU2MEhHdjJCeUtVZVNLZDNDNXNVTXdNWEhOV2tSTWNSNlZTL3Nu?=
 =?utf-8?B?WXVwWXVCR282Q0k3bFh4ZlpOWFp5QTExZHdWQm1OYzFidmoxdkJFeGFaNGxV?=
 =?utf-8?B?VWFOUERrRHRTdlJUMlVleHNvY1pmeFF2ekVldk8vQ2pZMWxaTW8ySjRhZkRB?=
 =?utf-8?B?SVF6dmRxTnI5L3dLb0licFJ6Y3FERlVlT1hWTGZHLytobzIyVHJlOWlBRlNC?=
 =?utf-8?B?YnZ5a0NpakRyOTlhZTB1cWc3NnUzTy9NbmJYVDUxcjdudmhrYkJUK0NDZzZI?=
 =?utf-8?B?bFdCN3dremFQS1dCb1d6L0tuN2VDRUk1UmJWRW5IczZFb0FPWU5ueXZ2eCtL?=
 =?utf-8?B?MWYzMnlIdm1VRkkvR3E3dXIxMlpZVUFYZENJdUlKQVFUSUJydGJINGduSXUv?=
 =?utf-8?B?T1AxeTZ3cFRQTmtrQVVhbVVwY3U5SEMxT0k4L2QyTUs3M2k4VzU3cmZoZHMr?=
 =?utf-8?B?NjF3ekxxd1ZhcWsvN3VtaEZUeXBtOXAxd3E0QmtHM3doMkVUTU1FVUJndFJw?=
 =?utf-8?B?elFKZVFkamNOQ2JDWmZGNWlmT2J1Y1hRdWQva2FKamNHUks4SjJDQ09lNk1i?=
 =?utf-8?B?UXVrS2xFbEVndU9RZnlRTi9UbEdFaEozazhaSWZWS0RQb1VYYTJFZFZRWTlS?=
 =?utf-8?B?WXNwTU9kLzNMYzBkZlpVWTA5V0M0OHpyL1FZNFJjTEJQcGV6Z2dTaUxNZ2tD?=
 =?utf-8?B?VE8ySHdHMmt3ZkJJZkJ6QUlqbFpnSTR5RW8vN1o5alZLNEFOWmZhYWd2MkEw?=
 =?utf-8?B?VWdQQ0NmOEN0Q0RHb3dNTEZLaUJpNVZETCtPNU56TytjTldFckNrczFDRm1y?=
 =?utf-8?B?NzBVM3Y2b1lVNFJKeFhzQXJYbFI1OVZHbnRVb1R6SlEvcU55QUJwNi8wMFg1?=
 =?utf-8?B?VG80Q1JBVUdWT3hlMTU3VDh2TUZlbklPRG1ndDQ2SWd2VDR5VFkxdlBmS1ls?=
 =?utf-8?B?aXAzOUtIUDhRaXNnSXpXZVdKM1ZZM3pKMnJ6VVRFZlI1SVdHUlBmTkhySXNV?=
 =?utf-8?B?eTdoRkY5UFl0MW5xdVkzWEQzY3BtSmNJeEJpdkQ2eVdBTVZrSFFtaE1SS2Jl?=
 =?utf-8?B?aDlVZU1iMWVpK2ltMTZMYWhvb3NRWGIxeGR1T0VvNDkyN3dvVHp0S2NaRFls?=
 =?utf-8?B?c2dQSWpEMzhQRmtRU1JvUTVaR1ZHdmgwdW1tcVptZjlXM0llMUhBemRhbmNV?=
 =?utf-8?B?U3MzbVIyZjBEV3pVOVhMQWU1ekZNMmJhTC9jS2F3WHBPUnVYUGlHZ0JsMk9w?=
 =?utf-8?B?RE1LQ24yK3g2RGpmd3ZVVTRoTzJjRjZyS2cvTG9mdzB5NU5CMTVLdzZDZlYr?=
 =?utf-8?B?QkF1TVJ3ZkZCeDlROXFiVVFjbkNaYmNERkp3THNram53Z21SRFhGTzlzcGg2?=
 =?utf-8?B?VC9jZlNnenMyS0pXVVBoTTNNNmIxalloWW5QcFVjNHNjL1A4R2JyaWhWZXh2?=
 =?utf-8?B?ODJXVytpamZoZGZhSlVhL1NkdHp4eGorbFk4VlpmYk1RRXEyMG1zbVhnMXdj?=
 =?utf-8?B?T0xtdkZaM254YmlWTWg5MVAxK2dGRFNSRHhBZG1lczV5K1N6TG9hZkl5QU9t?=
 =?utf-8?Q?KForCghO/z7e60VrRn5x27O9a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9f1f8a-2582-45ff-05dc-08dc3698030c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 06:56:09.1261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKGMwP0d/MwwNCExgk5dHSa+it+4m9IGCTC39J3sLg4k4knIX5UMXYDbXFsD19tGu88M4e3khjrnR3lHet2PGSgKs4gkjhdBNrJju34KPkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDA3LzE4XSB2Zmlv
L2NvbnRhaW5lcjogSW1wbGVtZW50DQo+aG9zdF9pb21tdV9kZXZpY2VfaW5pdCBjYWxsYmFjayBp
biBsZWdhY3kgbW9kZQ0KPg0KPkhpIFpoZW56aG9uZywNCj5PbiAyLzEvMjQgMDg6MjgsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4gVGhpcyBjYWxsYmFjayB3aWxsIGJlIHVzZWQgdG8gaW5pdGlh
bGl6ZSBiYXNlIGFuZCBwdWJsaWMgZWxlbWVudHMNCj4+IGluIElPTU1VTGVnYWN5RGV2aWNlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+PiAtLS0NCj4+ICBody92ZmlvL2NvbnRhaW5lci5jIHwgNyArKysrKysrDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4gaW5kZXggYmQyNWI5ZmJh
ZC4uOGZhZmQ0YjRlNSAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+ICsr
KyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+IEBAIC0xMTIwLDYgKzExMjAsMTIgQEAgb3V0X3Np
bmdsZToNCj4+ICAgICAgcmV0dXJuIHJldDsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHZm
aW9fbGVnYWN5X2hvc3RfaW9tbXVfZGV2aWNlX2luaXQoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+
PiArew0KPj4gKyAgICBob3N0X2lvbW11X2Jhc2VfZGV2aWNlX2luaXQoJnZiYXNlZGV2LT5iYXNl
X2hkZXYsIEhJRF9MRUdBQ1ksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplb2YoSU9NTVVMZWdhY3lEZXZpY2UpKTsNCj5UbyBtZSB0aGlzIHNob3VsZCBhbGxvY2F0ZSBh
IG5ldw0KPg0KPiBJT01NVUxlZ2FjeURldmljZSBhbmQgc2V0IHRoZSBWRklPRGV2aWNlIGJhc2Vf
aGRldiBoYW5kbGUgdG8gaXRzIGJhc2UNCg0KU3VyZSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

