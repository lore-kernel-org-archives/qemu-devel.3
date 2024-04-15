Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9395C04FFF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 10:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJIb-0006qC-R4; Mon, 15 Apr 2024 06:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwJIY-0006oD-LA
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:10:50 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwJIW-0003uT-Nw
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 06:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713175849; x=1744711849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t7e/cOVq7/wu4pqrRp2MZT+AejhA6TXsQ1cWg1m/Ink=;
 b=R2pzdBCWROcNxnag7XoyaS9FB0rfMBsNAYjhLRPl3HwZx7r9H9YW+zQM
 1B74tVbj7xEb1PJAApv3z7VEqyzQkLAgpyQjdWy8TvmJpa8VmfloOECJx
 XY7PSrh6PQsCJJMdw46jYkb6DmJXIVZ6GHoxE/bSowAybrw4ByV7pEagC
 CkswriFEQj4eX1sCfwDD53G+7KvG/c4oP7zD8C1ti7F3TNVh+mq5vuOle
 PKW2nu22vJyqNJ6bJe1AHJJ2F3Z1FQbBCVADpDC/lbZyhO7DDyhd3E4/e
 WqT6/buv73PUWKmbt5Jkd7PySxfqjuLvodNpVMKcLwlJRnfdVTS1Bq1Yq w==;
X-CSE-ConnectionGUID: mgJKSZc3RtanuuMuV4PfZg==
X-CSE-MsgGUID: rLyq+xzUQfKT7epxzHpopw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8393193"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8393193"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 03:10:15 -0700
X-CSE-ConnectionGUID: 9onh5zBkQx+RbyWx4+E/XQ==
X-CSE-MsgGUID: buE+kMEBRO+rbmCwARf1Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; d="scan'208";a="26501857"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 03:10:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 03:10:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 03:10:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 03:10:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 03:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baafEGZ764yLPgBEdSQbMOMoqCjl2A0DWedmqSmLQ3uMGTC6yuBtEgkkLKC2k0Hy5HzvzgUV6VGLKTU9faScFkRGgs6NYBTt1iFxG7Pwy1q5gsxPStY4z/xIs/YUdBp7d8ZHctTijRPQB5bRE+rNbZtV+NZ7A/XHU3Vl6m65wfLly0oDjIbMtuoaAfwe7Q2y4zHOjwylP+E6h/U56k8z6oo6wCwtXxG8xrA45WfXJS2mFd8dltjHlfpXny+HwrJgYtAZHFQtvHUYEwKwkTy6CNq45RSDr0gIFjHCIfDt07mgifHl5v4ZQE+1VXQcAL/y/Gd0+lD7yPYc0LMNLy/LOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7e/cOVq7/wu4pqrRp2MZT+AejhA6TXsQ1cWg1m/Ink=;
 b=hXcZABBvZ8nTWXwbNnqY91S3aS1GgFZXE25JR47vtEeSa2rP0nfRP+WFqxOXSjyrPt7FSY5FMYefbjbgjZJ7A5FQY1+rvf0ei91wiArOBt3lVH4aIpg/fK1J9Vq5/9fC889NtT3RWS7TmYq7B1v4LKU9PIbqpCLGELYH6EXKIQM1R2WHGKiBOPJHQKqSnanPm8uOxjO9sAIbluGRuUMS9V8iEAtNWRc351/x+QTxvxGzqTpamF8NsqJc/8ZaU+20aggGbskmWydpVmyoAPDPSi4f3eIDumSy+/ubore4LttfJxB/1fI/E2GgfsCnzy5SmEP+olWVT+PGKD5ahj1y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8049.namprd11.prod.outlook.com (2603:10b6:8:116::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.30; Mon, 15 Apr
 2024 10:10:02 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 10:10:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Topic: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Index: AQHaiYzptKOfpLfFEUmXEx9ocl3VJrFpGQmAgAAK6ZA=
Date: Mon, 15 Apr 2024 10:10:02 +0000
Message-ID: <SJ0PR11MB67448B10E7E9C052417D6C0392092@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
 <9e71a87e-ad23-4048-bc9a-c26dfafa646c@linaro.org>
In-Reply-To: <9e71a87e-ad23-4048-bc9a-c26dfafa646c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8049:EE_
x-ms-office365-filtering-correlation-id: ff6187e0-70d7-41b4-168c-08dc5d343721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: me7qqvsq4a3B5h7H9VWTZEo/tjnkICzt6/9mSelkfPtxUa+E78Dp6aXeiYe/gguhr6pV6cRHnmqLCwhMVY4lKCozfRjwlCkg/7M2ro/CqtM2r4h6tf23qVzaLgtYwzgR1HTHcA3l4c1sD9JEu1sHs5m/41KHgK5PbTXkBJXeZItfATAQ27kfKVLi/0lDEATnc1PWP5yGkbt/ehjaxvBqsjC3DlaBjDQUGQ1YiYs2cpudrORHdCmleHPfbhdRk+KwjmfA6uMB7HEEF6W1gRmuYZMLVkJoeY4cfSM6HjaWNLup0+FXwmZ6heSbbgOBc9X3fWNCcLMqmi0lps+S0IBTpMgt5eVHvF4queILuCd6ii9Pj/mNzxvMF4sFf9D1shqi5gnHV93r6ROxlkYPKxHTp/GVROQ21kDs54A0ecADp1NiDsh3CHR7prlPyqCOOugU3sWJwfOGG1ohhhRsis1qVnq2E/AOgRCNqE/uYWgWuBTDPMy9pA+q0lm4yeM5jYkcMIJV2ExTw5Znx1buuhkDuvqet2MAPIEjRq5rBG969uZzsuyB7TbInrD+In10DeI6JPwZ0ZrcqwUoR5qhvVMFC2U2PCLevWaPDoF3Cu+4jVH4YS+ArbWDDG6V8wlDRkyYddSdLTgs0m52fcAwSh3rQHuCXohwZUKBNCrbfIuwyKZCIezAVpN9GaqbboXc6eepkQyoEtgAYbgEapKJEYaFhpu/PS2Gty4KXl+iHCgf/Zc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWtvaUZ1cWhicWRQMVBLN0xnajQva2ttejUvYnVsSEw2RXR0cjhHWUdoaDIz?=
 =?utf-8?B?SnhwL3poUVpiQXJyRjJzdjVCTnZVUTYxRDlOOS9JMGtLSlNNT0plb3N3bVY2?=
 =?utf-8?B?TUpSc3I3V2VveGQrU3VLa2dKK2dZSmRXby9BVWFGQ3VXK0lNL1ZOS0pUQjlu?=
 =?utf-8?B?UVl4elVwdnN4M29sNkRnNWZsZmYrU2sySnhPby81ZGN0bnNTQkpwUkVzVkJK?=
 =?utf-8?B?a3dvMFZnMnR6T3lBeVVWZlhIK2VRYlhLblBkOXk3TXNJUkpRSkhXZmUrWWJy?=
 =?utf-8?B?Y3RpeFZxMkpJTDlPRW9nRkFLSzdxaDQ5a21yTWFaek9DOGdtZEx1ckdnN3F5?=
 =?utf-8?B?aFMybVVpNzVNOUhIa0g0eXdIOHExR2N6RlpKU3o2bGZwcmtMdjhZekVPd3Jz?=
 =?utf-8?B?NkFqcmNwQnVEWlJTaDRCdXI0aFpHdG5KcWprYmtUb3BocWFZNWt3QVBNQWp0?=
 =?utf-8?B?NmJlVXhGM2x3RTBBL01wNVlOV3BSNzQ5QzFhRjlmWTE5VHdzeHBLTTNuRVl2?=
 =?utf-8?B?OXl3RTNvZmY4c1hKT1czUnR6VUxOT3cvVFpKNXlkYWpsaHBDZW1sSms3MXhs?=
 =?utf-8?B?VWh4OE1IR25VbFdST2NVcFVtc0k3ZVpMYTFiVjJsS1hSa3BiTjZSTGdUbTdm?=
 =?utf-8?B?TTFtN0RNL0FCWGVRWTZ2RzA5WGZrc3BhN0s3aUI2VGphTnR0bk9KSHRpcnM3?=
 =?utf-8?B?MGVRRDY5L1YxNHFhVmZXUndlNVp3ZzZqWCtsbTdtYUpxRkMrRVg5bFBOeDd1?=
 =?utf-8?B?RlVNMStXeURwcWhuTS9MMDNPbks1TFVtOEE0VnVvVmgrU3NTa2tucHIxUlFD?=
 =?utf-8?B?WUx0Zm4rL1Q0NTExblduODZOeE0vSjFxNmRiNHNOdzU0WkZ3cGNma1YxQ1l2?=
 =?utf-8?B?UzNhSjZCZmN2aHNNSHprYVlVYlZJUHMyRk1JTUg2UHVPcWVsTXg4Nnl6WHRU?=
 =?utf-8?B?RXMzM1lwcWFzZlU3S3NjaGtjSjY0S0pMWlhqMitJcDJJWm9SUCtUT0VHK3M5?=
 =?utf-8?B?OWxQZGJ6SHZsTHlBYkxUU0szODhSbUdzUUJVUlg3ckdTMXVmS1orS0NNSXFK?=
 =?utf-8?B?RmVmUWFDQWlocEJNYU1MOFBYNWluL20vbkJLc1JvenRzUlFpaklFMWlYWk1C?=
 =?utf-8?B?TjVUc0FtOVprVWJJcmNORzA3NmlOV0hCS1pUN2xlMm5MWitLVS80Vmw4SThz?=
 =?utf-8?B?aEJCQ3IxVXp1ZE5jY28vWlgxbjRsQkJBZjVTSUVOZlNYa09UWG5rdmZjSWJz?=
 =?utf-8?B?VWdBSzRwZmU2eWtsemJCVlV0eGd3U3hacndtYmhZb2huRmFrVlhRM3ZxR05L?=
 =?utf-8?B?NzhrYmRxQnJKODFTbTdLdmYwUVVRQ1c3aXJZYjVncmxwVHZ6UUxnQTRPMTVa?=
 =?utf-8?B?aytMcTEvNzZiazhhWWhtM0lTN1p1UzZQd3dpSzY0UFJsWUM4MU1uS2hkMW9P?=
 =?utf-8?B?MWJCZWdIUHg3RjBKT3B6OTU3Y1k4Y2NPeVliT0dqY2YrME5mNEhMOG9EN0Y1?=
 =?utf-8?B?SDdlUWdDMjFqN1lCVzJWR05TVVZ4emNVcktmd01QdjJMQzd4bzA0ZzdCSnlw?=
 =?utf-8?B?ZG12d2pKWGlybUFwdXJvc1dpTWJOdnM0NnozUm9WS0Y1K2t4MXhlU1h6eGtu?=
 =?utf-8?B?VGJUYzZIR0RueWJURHBVMHBPSWpPc01tejcydit2SXQ1N1ZndEloZkg4WlBU?=
 =?utf-8?B?blh6NGYyZ2Y2bk84bDVoNGNwWUlleWlQNmdZZnFudWgzMFAyczd3b0Jrbkky?=
 =?utf-8?B?aDBSWHNmV2djREN0Y1dOM2YrMFNmQ1JacFJUeFYwd2QzUUdzSFRTOXQzczNN?=
 =?utf-8?B?QlFYSmJnMmVTSVZrajFIQmZBWERMeDRWQldxVzFFZkJoTExjSkxjZDJwS3Q2?=
 =?utf-8?B?VEV2TkphdUxlY091SldueW9ncmhSdHR6Q2FTcXJBckkrS1JHY3ZQTWc3UVU0?=
 =?utf-8?B?L3VVOUxXVnpBR0E5RCtpUzZDaUxkTittb0Mwb3JpbEZJRThhQWVKMHQ4UFFS?=
 =?utf-8?B?ZFBJME1sTTJTb3BkZ1hidUNvQ1RvaFhGb3pDblJYdTZwMjdFYkZkbGtoeVRt?=
 =?utf-8?B?MDdKUEhyUWo0N2R6cG1tNVBwWXhYL3FwbzR4b1VCcitydU9US05YT29uV2dy?=
 =?utf-8?Q?HrbhCnJA+UN/t2ucQBemXf7EF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6187e0-70d7-41b4-168c-08dc5d343721
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 10:10:02.3780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV7+oQs3dqLnnjKlO59SANgo01V1knWyrbw3bGcNncmMGZbsGUIZN50kWcJjo0m6gTNR+J0AOQ6LlyaMRvCKL0qAQON/GQoCh/t8ZWZlTwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8049
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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

SGkgUGhpbGlwcGUsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TZW50OiBNb25kYXksIEFw
cmlsIDE1LCAyMDI0IDU6MjAgUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+OyBxZW11LQ0KPmRldmVsQG5vbmdudS5vcmcNCj5DYzogYWxleC53aWxsaWFt
c29uQHJlZGhhdC5jb207IGNsZ0ByZWRoYXQuY29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+
cGV0ZXJ4QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOw0K
PmpnZ0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOyBqb2FvLm0ubWFydGluc0BvcmFj
bGUuY29tOyBUaWFuLA0KPktldmluIDxrZXZpbi50aWFuQGludGVsLmNvbT47IExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPjsgUGVuZywgQ2hhbyBQDQo+PGNoYW8ucC5wZW5nQGludGVsLmNv
bT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEwXSB2ZmlvOiBJbnRyb2R1Y2UgSElPRExl
Z2FjeVZGSU8gZGV2aWNlDQo+DQo+T24gOC80LzI0IDEwOjEyLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IEhJT0RMZWdhY3lWRklPIHJlcHJlc2VudHMgYSBob3N0IElPTU1VIGRldmljZSB1bmRl
ciBWRklPIGxlZ2FjeQ0KPj4gY29udGFpbmVyIGJhY2tlbmQuDQo+Pg0KPj4gSXQgaW5jbHVkZXMg
YSBsaW5rIHRvIFZGSU9EZXZpY2UuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBFcmljIEF1Z2VyIDxl
cmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29tbW9uLmggfCAxMSArKysrKysrKysrKw0KPj4gICBody92ZmlvL2NvbnRhaW5lci5jICAgICAg
ICAgICB8IDExICsrKysrKysrKystDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jb21tb24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbW1vbi5oDQo+PiBpbmRl
eCBiOWRhNmMwOGVmLi5mMzA3NzJmNTM0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29tbW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+
PiBAQCAtMzEsNiArMzEsNyBAQA0KPj4gICAjZW5kaWYNCj4+ICAgI2luY2x1ZGUgInN5c2VtdS9z
eXNlbXUuaCINCj4+ICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIg0K
Pj4gKyNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+DQo+PiAgICNkZWZp
bmUgVkZJT19NU0dfUFJFRklYICJ2ZmlvICVzOiAiDQo+Pg0KPj4gQEAgLTE0Nyw2ICsxNDgsMTYg
QEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0dyb3VwIHsNCj4+ICAgICAgIGJvb2wgcmFtX2Jsb2NrX2Rp
c2NhcmRfYWxsb3dlZDsNCj4+ICAgfSBWRklPR3JvdXA7DQo+Pg0KPj4gKyNkZWZpbmUgVFlQRV9I
SU9EX0xFR0FDWV9WRklPIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UgIi1sZWdhY3ktDQo+dmZpbyIN
Cj4+ICtPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShISU9ETGVnYWN5VkZJTywgSElPRF9MRUdB
Q1lfVkZJTykNCj4+ICsNCj4+ICsvKiBBYnN0cmFjdGlvbiBvZiBWRklPIGxlZ2FjeSBob3N0IElP
TU1VIGRldmljZSAqLw0KPj4gK3N0cnVjdCBISU9ETGVnYWN5VkZJTyB7DQo+PiArICAgIC8qPCBw
cml2YXRlID4qLw0KPg0KPlBsZWFzZSBkcm9wIHRoaXMgY29tbWVudC4NCg0KV2lsbCBkby4gQnV0
IG1heSBJIGFzayB0aGUgcnVsZXMgd2hlbiB0byB1c2UgdGhhdCBjb21tZW50IGFuZCB3aGVuIG5v
dD8NCkkgc2VlIHNvbWUgUU9NIHVzZSB0aGF0IGNvbW1lbnQgdG8gbWFyayBwcml2YXRlIHZzLiBw
dWJsaWMsIGZvciBleGFtcGxlOg0KDQpzdHJ1Y3QgQWNjZWxTdGF0ZSB7DQogICAgLyo8IHByaXZh
dGUgPiovDQogICAgT2JqZWN0IHBhcmVudF9vYmo7DQp9Ow0KDQp0eXBlZGVmIHN0cnVjdCBBY2Nl
bENsYXNzIHsNCiAgICAvKjwgcHJpdmF0ZSA+Ki8NCiAgICBPYmplY3RDbGFzcyBwYXJlbnRfY2xh
c3M7DQogICAgLyo8IHB1YmxpYyA+Ki8NCg0KPg0KPj4gKyAgICBIb3N0SU9NTVVEZXZpY2UgcGFy
ZW50Ow0KPg0KPlBsZWFzZSBuYW1lICdwYXJlbnRfb2JqJy4NCg0KV2lsbCBkby4NCg0KVGhhbmtz
DQpaaGVuemhvbmcNCg0KPg0KPj4gKyAgICBWRklPRGV2aWNlICp2ZGV2Ow0KPj4gK307DQoNCg==

