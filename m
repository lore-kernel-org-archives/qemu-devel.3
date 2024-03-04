Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549F9C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3QY-0003SV-Q6; Mon, 04 Mar 2024 03:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rh3QR-0003OM-0e
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:11:58 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rh3QO-00011a-LA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709539912; x=1741075912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cfSCE+v2/j+dB5V3pcJs/lXnQsMfeCF4Qh3poGBdA4w=;
 b=I/u1HjaVRMZfw1AgHtEjzdfuRBpIc16/gVNLvZ/bWx/f1rtsCsuO5XD/
 qb96m8xWtRcI5o1TpfkLfmVZzSCSVcNqKzw/E9FBBa4XQ7DsJOGPRBH/o
 bq3wdV0SDep3cWl4dupQxXXFWVz7iwFBnF4RIpMwi0JZDUPQx8Or95pNx
 N8ibrPFAKJMip0nMNJq4lZfaCn6HNo2FS/p0qYjwSNw8WCRu+G8LbMtde
 qGUuEq/xoRvTIP9IR291vPCbBXzmovXyts9z1mKMog0+y7+MD5TRd3Dy2
 HN9QBkAclSeNFjB1z3xocMOiu7o7AabUb/jVK7xc1ORS5BGZBFS8nR2HG Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3868437"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3868437"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 00:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9046566"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Mar 2024 00:11:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:11:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 00:11:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 00:11:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 00:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idh3Xxl1VpBIjOvVuEsD3zVd0IECFTpT5+XLREaJWNbXmSFmRl/fMbGD70XrYpdnI/e4uTwn46O5cfbunIX+K2vE+HkdNUkBCIS/Ll4yj5KJeu/zxC8F1sgiYE9F+cX/kDhi+7vI3JQ6Ts7VIJKNxgsVpzkD1NddRVJ797uaXK/kEsA5msGzU1pKbQzvBVmtFTIaBjrAPwfI144vJDCC2jL2106fGIjp53BMM6wWNR04+1m5SLekW0DCXfXCC88yNV8rCxnNpI3BQYQUEXegACFMs2+Hc/G1Wittz8FCwLufklxX9HM3SbolAG8cujw3yTLbSourfjmakQcYJiGMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfSCE+v2/j+dB5V3pcJs/lXnQsMfeCF4Qh3poGBdA4w=;
 b=O/XZPHyv03K900AFdLzEECQXIeNRbY3Kh77Hmwq6pg+mMLTUm4/mBjQqNx3mM4ukDxEFYCmePP6h3YuKav8VeONW/ridmGOgpkOcP5IJPwBO26ejbaHMy6PHReyOlzPJuDBPJhHgfiLqtTHdGCLf+CUd50A4UFdkglp5QUhd9FrxtdFV/JWo644ZFqWCt+AoVFmjY5SMGLnIYJqgAxaGMzAQxI5qQH8M1FTKWbNFa9UoEbfI+Hae5vjq3OChCJnoo/BhV5dPF8h5tkzNrFNnfToVcKCS6Md2Cnx/EFHqLT/X9ZPRmVnFLP9ksIEufVzO7HitwflzGvZJrl6ojTSX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 08:11:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 08:11:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Prasad Pandit <ppandit@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
Thread-Topic: [PATCH v1 6/6] intel_iommu: Block migration if cap is updated
Thread-Index: AQHaaisjZfUYiE/VykmSeDX9O65MCbEnJ/iAgAAI1KA=
Date: Mon, 4 Mar 2024 08:11:41 +0000
Message-ID: <SJ0PR11MB6744A22D240CB8A41569222392232@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-7-zhenzhong.duan@intel.com>
 <CAE8KmOxFnzsw2das+Go_EEyVUr517hWS8xvXfN1VoJq0RofR+w@mail.gmail.com>
In-Reply-To: <CAE8KmOxFnzsw2das+Go_EEyVUr517hWS8xvXfN1VoJq0RofR+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: 2577365a-a012-43e2-763f-08dc3c22b959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJanR/GHyHmCzNbUWqfn1RC8OkdRVUjJiJLcscgyMtuqdKnzQeYMx2XG6/0hCvYb+A+O3WZ2NWzo5dqKvwcUEMpk+ESIuBV5mXkhiMMWYcjbabUy+kc5hkRMO2xGtUQeR2lmP6GGT27IJuyHW2TIUD9Sc55xJrW59U4/wDtSOdqrwPLUb71jSYYyQHVMTc2uIdBdqO5IWoLz0JfxJN4OEOUvTKQ2vk4z5k4A+dI14IeQPg/HAIBbHoKAoxTP4cadekZ6/54oHtVP7X2RxCteOMUUpgb9C3a9quwVJtz0+8Cv6XGQR+FvyWOpboK7BmsskjaNZd41HmKFh+5JpG9kRgsFpvUG5xlwNWTJ2O+j9f9Ycz7OgknR17zdBe8icjd6nR+ewl1bVjItg0tQ73q67tUDSKcISbivQuBcj7mq13syJ5NTD3wU3iJC2DdZjerTJpSNajFLQKy7f8/1flmRJy8Pw3XcU/J/vT7daMOv4qlWUaBqbdnIUAFPAJTvo/b4ABRFJsL8xGaGgmx/3okPmWiWOthOLvP/PG/CJmZHw7diHU107PbmiGb6MT+8pxkgLSOMZkLBRkaQKvT4k0GUrMSjs8wPzcRQSXNrvTR7uL35ww5NIKX1K2Y6G2Pn0K0Ic4Mj8rS0AmFOz3H/HO/Rq/PV0OrPffnO2F/ZLvFq3Lc2YZ+oKlZnqkyWa8hfItoM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2tId1pTdGEvb2p5SkkzcENlVC9hanhoRDdQZ0ZLQno0cThJOHVhbTdFV28w?=
 =?utf-8?B?MzMxVktSQzFoQjNtdS9JbGRyWlhFY1dpZTFtRlVIeHUxMXVwRXNWaGVXZjJi?=
 =?utf-8?B?U1h4alNybVBaaSt3TjdsZUtEemNRMk82YWFZck5HRlpuZzBSUTRsbnRXN3B6?=
 =?utf-8?B?d3Zlc0JMMDY0NE96Z1BqZnU5c3Fxend5bEZ4dGsvQ1BtMHB1b014UGwxNlhP?=
 =?utf-8?B?cDRLQkdEU1BNcWZaOXMxcndJaVkvMFB5b2xzWDErd1k2L1RPRFpzaUJ2RWs0?=
 =?utf-8?B?Uk5NdmhRR3RlTXFzNjNJeTM3NWZXZ1lDVFVqbURJbkx5RS8rWmlUOGJQQ3Bw?=
 =?utf-8?B?RkFSNU4wM0VzNUlhdlV6NUdRcVhxTVdRTmV6UDZJUnZvSmFaaXF5UWhTajFV?=
 =?utf-8?B?ai81MWlLZlpFOGttbU1wa1lQaUNlU2hlNkluTW9yNTl6eEMzdjFqODRKaDBO?=
 =?utf-8?B?NHJ1cGo5U083ZDgwWkd6Rnh1b1ZlU3VzSmZJQnNITFROK2dSRGZmNXo4YXJ1?=
 =?utf-8?B?UDB2cDRXSHJqbmdFTnZIYTBIdWN2SE00c0FnaUhQM2FlalVva3dCTW5IUjNv?=
 =?utf-8?B?aWdQNXBuRkgwcWF2cTFXa1NUQTBiSFBjZHpzcDNyS0lDUWgrcE9kakJMV055?=
 =?utf-8?B?bno3ZkcwWTU4dzFCR2RSYkdXNXlhYkZBcVhPbXM2QlpGOGVIMi9SMDZHcHp0?=
 =?utf-8?B?algvaGZUQUtRMWE2Y3JXQzNCSVQwK1p4bHdORk9tT0JFNmt5a2R2Z0VqTnlu?=
 =?utf-8?B?ZktpR2xqRmZwMWlickVQV0dvRU4xd0EwYVFTY2JscW5TS2hLS1pqbWVqRmJS?=
 =?utf-8?B?Z0QzcndodTV3VUFVVCswREZOeE44QVo2K3I1MURLU1RHeXJSODB3cmNIMndh?=
 =?utf-8?B?eTI3UXBCL2NvWWtpYW1OMHBOQkh5OWVoTlhheEdTSk8vYWhoQXNCbUdDaTF5?=
 =?utf-8?B?bFRiMEZxZlJFVnMxSEtxcW9GR055RzhKVE1Gd3ovNmYrSitEbDlaOEdERjYz?=
 =?utf-8?B?dzJiU2NVUml5RnM0QytSR2pzMklsN1NQVTNibFRHZjk4RFJ5N0Raemg2ZUdR?=
 =?utf-8?B?Zm9teS93a1I5dHE2RUlTWGp0cVdUUXpNRXFtWXF3R3hNcjVBTmw5NWxlYmlI?=
 =?utf-8?B?R1BPWmZVcENqbnR4N2NuVWJoU3kvZ2RQb3l3QXExRTQvd3FvTVJnQ1Vuc3Rp?=
 =?utf-8?B?S0l0eE9iZzh0VWttRFhYUFFjeW5TMjN3KzQ0RlpsUjJTQUxxcURaQTVhY0ly?=
 =?utf-8?B?YnliZnN4WWNaeHo4Z1RDK3BkNGh6NElTVHhsOGI2K0MzTEFXLzdpb0VwcVJz?=
 =?utf-8?B?dEhTV0J0NngwMzJCazVOWml2V3Rrd0taWXdFQWxyb2JibmtLaVFDbnBhcU94?=
 =?utf-8?B?cU1tWlpKR3A1UmEvUWI4V3JtTXEvanlydFhVdnRiMkEvNnBSLzVoRHlzQzF3?=
 =?utf-8?B?cU5IZHVLVGxiTEJOKzVIcmEzOUpYZit0NHJRTTZEb3RvYU1RbEpjVXBzS0hR?=
 =?utf-8?B?QWRCTWk0VEhGbG5HYi9jZFBNNjNiY1hKZ3RKNFNGV21pL1RMcVYxOVNmbld4?=
 =?utf-8?B?QTRRKzNsTDFCWGI3NlpnR2g3TmgyMU1oZ010RDFUbUN0QlNNOGl6QXl6RXlz?=
 =?utf-8?B?emNIMXovSG1XNjdVN0dVZ2xsMFYveUFtR2VOaUU4OWE5cDVvMWt2QUxucytm?=
 =?utf-8?B?ZDBGTUNJeisrWDYwRHB6b00yQnlDOHRNSXh2MjlzNUNRWXhPU0lEOGpKWS9w?=
 =?utf-8?B?OVY1VGF4QS81cDQzLzM0ckFSNkJ2T2pCS0oxR3RDNEQvT3ZtNU9NVWFsSG9L?=
 =?utf-8?B?WWFBL0dKZDBCaGt6cG5GcDR6SzgrZy9wcjlZaHFvU01aWUdKUlVvWHcyY0VC?=
 =?utf-8?B?cysrUGtTVzFyUXo1TEE4RWIzMTl0b1FFaVJVbzY3NTFuSEN5NWNaRm5tTVQ0?=
 =?utf-8?B?MXBiOC9xY05uVnY4Y3h3dWJEMFB5M0VaaWxMeWEzWmNHYU9OOVEzV1IzdjZR?=
 =?utf-8?B?RE0vOU9MYnhPLzNhTngzbUlRY0JXdUxUbW1NSHI0WDJQMzd4TkJGNTNtR1F5?=
 =?utf-8?B?WTltM1VXSWFGSlcwZ093ZVdETTI3alV5UWIyeUEyZTNwSnNpa2FVWmFyVDlF?=
 =?utf-8?Q?bIam0PUxs4dl131iL09A/mh7e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2577365a-a012-43e2-763f-08dc3c22b959
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 08:11:41.5836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHpLGELaWRIW7dvt1Gynjc5w0QWWHBFaztJmiiz94AYOT8sQ6ogqwW1A6DrUjWhg1mkkvLH1bpg5GTjxVrW6oTKmLCbFCSIMyRNlb1v+8qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFByYXNhZCBQYW5kaXQgPHBw
YW5kaXRAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDYvNl0gaW50ZWxfaW9t
bXU6IEJsb2NrIG1pZ3JhdGlvbiBpZiBjYXAgaXMgdXBkYXRlZA0KPg0KPk9uIFdlZCwgMjggRmVi
IDIwMjQgYXQgMTU6MTcsIFpoZW56aG9uZyBEdWFuDQo+PHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4gd3JvdGU6DQo+PiBXaGVuIHRoZXJlIGlzIFZGSU8gZGV2aWNlIGFuZCB2SU9NTVUgY2FwL2Vj
YXAgaXMgdXBkYXRlZCBiYXNlZCBvbg0KPmhvc3QNCj4NCj4qIGNhcC9lY2FwIC0+IGNhcGFiaWxp
dHkvZXh0ZW5kZWQgY2FwYWJpbGl0eSByZWdpc3RlcnMgYXJlIHVwZGF0ZWQgLi4uDQoNCldpbGwg
ZG8uDQoNCj4NCj4+IElPTU1VIGNhcC9lY2FwLCBtaWdyYXRpb24gc2hvdWxkIGJlIGJsb2NrZWQu
DQo+DQo+KiBJdCdsbCBoZWxwIHRvIG1lbnRpb24gd2h5IG1pZ3JhdGlvbiBzaG91bGQgYmUgYmxv
Y2tlZCBpbiB0aGlzIGNhc2U/DQoNClJlZmluZSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gYXMgYmVs
b3c6DQoNClRoaXMgaXMgdG8gZGVhbCB3aXRoIGEgc3BlY2lhbCBjYXNlIHdoZW4gY29sZCBwbHVn
Z2VkIHZmaW8gZGV2aWNlIGlzIHVucGx1Z2dlZA0KYXQgcnVudGltZSwgdGhlbiBtaWdyYXRpb24g
dHJpZ2dlcnMuDQoNCldoZW4gcWVtdSBvbiBzb3VyY2Ugc2lkZSBzdGFydHMgd2l0aCBjb2xkIHBs
dWdnZWQgdmZpbyBkZXZpY2UsIHZJT01NVQ0KY2FwYWJpbGl0eS9leHRlbmRlZCBjYXBhYmlsaXR5
IHJlZ2lzdGVycyhjYXAvZWNhcCkgY2FuIGJlIHVwZGF0ZWQgYmFzZWQNCm9uIGhvc3QgY2FwL2Vj
YXAsIHRoZW4gdklPTU1VIGNhcC9lY2FwIGlzIGZyb3plbiBhZnRlciBtYWNoaW5lIGNyZWF0aW9u
DQpkb25lLCB2SU9NTVUgY2FwL2VjYXAgaXNu4oCZdCByZXN0b3JlZCB0byBkZWZhdWx0IGFmdGVy
IHZmaW8gZGV2aWNlIGlzIHVucGx1Z2dlZC4NCkluIHRoaXMgY2FzZSBzb3VyY2UgYW5kIGRlc3Qo
ZGVmYXVsdCBjYXAvZWNhcCkgd2lsbCBoYXZlIGluY29tcGF0aWJsZSBjYXAvZWNhcA0KdmFsdWUu
IFNvIG1pZ3JhdGlvbiBpcyBibG9ja2VkIGlmIHRoZXJlIGlzIGNhcC9lY2FwIHVwZGF0ZSBvbiBz
b3VyY2Ugc2lkZS4NCg0KSWYgdmZpbyBkZXZpY2UgaXNuJ3QgdW5wbHVnZ2VkIGF0IHJ1bnRpbWUs
IHZmaW8gZGV2aWNlJ3Mgb3duIHZJT01NVSBtaWdyYXRpb24gYmxvY2tlcg0KaXMgcmVkdW5kYW50
IHdpdGggYmxvY2tlciBoZXJlLCBidXQgdGhhdCdzIGhhcm1sZXNzLg0KDQpJZiB2ZmlvIGRldmlj
ZXMgYXJlIGFsbCBob3QgcGx1Z2dlZCBhZnRlciBxZW11IG9uIHNvdXJjZSBzaWRlIHN0YXJ0cywg
dGhlbiB2SU9NTVUNCmNhcC9lY2FwIGlzIGZyb3plbiB3aXRoIHRoZSBkZWZhdWx0IHZhbHVlLCB3
ZSBkb24ndCBtYWtlIGEgYmxvY2tlciBpbiB0aGlzIGNhc2UuDQoNCj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+
ICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxNiArKysrKysrKysrKysrKy0tDQo+PiArc3RhdGlj
IEVycm9yICp2dGRfbWlnX2Jsb2NrZXI7DQo+PiArDQo+PiAgc3RhdGljIGludCB2dGRfY2hlY2tf
aW9tbXVmZF9oZGV2KEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgSU9NTVVGRERldmljZSAqaWRldiwNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gQEAgLTM4NjEsOCArMzg2NCwxNyBA
QCBzdGF0aWMgaW50DQo+dnRkX2NoZWNrX2lvbW11ZmRfaGRldihJbnRlbElPTU1VU3RhdGUgKnMs
DQo+PiAgICAgICAgICB0bXBfY2FwIHw9IFZURF9DQVBfTUdBVyhob3N0X21nYXcgKyAxKTsNCj4+
ICAgICAgfQ0KPj4NCj4+IC0gICAgcy0+Y2FwID0gdG1wX2NhcDsNCj4+IC0gICAgcmV0dXJuIDA7
DQo+PiArICAgIGlmIChzLT5jYXAgIT0gdG1wX2NhcCkgew0KPj4gKyAgICAgICAgaWYgKHZ0ZF9t
aWdfYmxvY2tlciA9PSBOVUxMKSB7DQo+PiArICAgICAgICAgICAgZXJyb3Jfc2V0ZygmdnRkX21p
Z19ibG9ja2VyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgImNhcC9lY2FwIHVwZGF0ZSBm
cm9tIGhvc3QgSU9NTVUgYmxvY2sgbWlncmF0aW9uIik7DQo+PiArICAgICAgICAgICAgcmV0ID0g
bWlncmF0ZV9hZGRfYmxvY2tlcigmdnRkX21pZ19ibG9ja2VyLCBlcnJwKTsNCj4+ICsgICAgICAg
IH0NCj4+ICsgICAgICAgIGlmICghcmV0KSB7DQo+PiArICAgICAgICAgICAgcy0+Y2FwID0gdG1w
X2NhcDsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPg0K
PiogSSBjb3VsZG4ndCBmaW5kIHZ0ZF9jaGVja18qIGZ1bmN0aW9uIGluIHRoZSB0cmVlLCBidXQg
d2hhdCBoYXBwZW5zDQo+aWYgdnRkX21pZ19ibG9ja2VyICE9IE5VTEw/IFdoYXQgd2lsbCBiZSAn
cmV0JyB0aGVuPw0KDQp2dGRfbWlnX2Jsb2NrZXIgIT0gTlVMTCBtZWFucyBjYXAgaXMgYWxyZWFk
eSB1cGRhdGVkIG9uY2UgYXQgbGVhc3QuDQpJbiB0aGlzIGNhc2UsIHJldCBpcyByZXR1cm4gdmFs
dWUgMCBmcm9tIGlvbW11ZmRfZGV2aWNlX2dldF9pbmZvKCkuDQoNCiAgICByZXQgPSBpb21tdWZk
X2RldmljZV9nZXRfaW5mbyhpZGV2LCAmdHlwZSwgc2l6ZW9mKHZ0ZCksICZ2dGQsIGVycnApOw0K
ICAgIGlmIChyZXQpIHsNCiAgICAgICAgcmV0dXJuIHJldDsNCiAgICB9DQoNClRoZW4gY2FwIGlz
IHVwZGF0ZWQgd2l0aCBob3N0IGNhcCB2YWx1ZSB0bXBfY2FwLiBUaGlzIHVwZGF0ZSBvbmx5IGhh
cHBlbg0KYmVmb3JlIG1hY2hpbmUgY3JlYXRpb24gZG9uZS4NCg0KVnRkX2NoZWNrXyogaXMgaW4g
cGF0Y2gzIGFuZCBwYXRjaDQ6DQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3Fl
bXUtZGV2ZWwvMjAyNC0wMi9tc2cwNjQxOC5odG1sDQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyNC0wMi9tc2cwNjQxOS5odG1sDQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

