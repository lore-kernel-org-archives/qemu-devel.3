Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E22C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 02:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSpl5-0006oH-Vx; Wed, 24 Jan 2024 21:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSpl2-0006nl-Tg; Wed, 24 Jan 2024 21:46:25 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSpl0-0008UA-UJ; Wed, 24 Jan 2024 21:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706150783; x=1737686783;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=isciEXGpzxopoXQU+XEhPuxSFkNTN7PKEFMtjMJuONw=;
 b=h7SdnVOdPTkpwlbKjpnqB2kru2UELz0GmLUJFAbeM2qBFuzdFqjMEv9Z
 Tnjsua2xxsOllgHyjxAr/xXHgO+m75SRYh4Okic1PvNcpOe9OhmygJ8pv
 9prwusqiTiTtWGL/e9eXLlYlAlE05NQSOkZ+mPuvkX8FxdM6A9TM8m47b
 YORYEfI5B9Lu/1SSXIdJl4UV821UkPw1i845+zFBMHjOulc659Br3cjDT
 CZCl7ZuqB06n9JN97aFDTFk9FGQt/2qDj4FWNVeQZyqagQJ2sI38Ue3Hg
 MUZQEtk41slPENFhc5TonVN7YyjBOor9iAiB4v9sF0stow7bef5ROdRLN A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8691299"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8691299"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 18:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959719221"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="959719221"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jan 2024 18:46:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 18:46:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 18:46:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 18:46:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDQlYahkkMST5j6FpxzUD6vmCvptusVFYL355Vbg4c6e9fbnXcFFgspP1KZxHpAsJra7sV9S9hAa4EujQxvz7i9On9PsBBMDkpi30X8l7PP+BXaxn7lF2hKqNFhkEOY57H19RSsEdI9g2NEvjnZtADQpBMMmdL+kz4F3kIZyGPA60kHS/oLuivuYjU4ySIthW04CXT6Dg5dnbVq2pFBvsxsTfQz8XXvgHN/HjYqh3RyU/MtoL7Zp2n4Py8Y12ORwAqzQO/Gf4fRrJzDZOjmbvGr3gEf4c94QFYwDD+rbaPU/Kp3NyQctwCaUCCKhnnlPPQS1U69B/gst85Vu8z4nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isciEXGpzxopoXQU+XEhPuxSFkNTN7PKEFMtjMJuONw=;
 b=efuntF0P33TfHD44sAzI3/kcuL1ql69jL5Z4+MqLM4aXB1am3HyOntw+LgltKzJ5osH7JDRyn11C4c/1/QKo+z/5HWC3BGcoc9sFABhrfqmOQ0iQZXg4tP1N0gAloyNr6GvF4Ha97JuMoMiB8Y6LYNdfzRgQ6MznwBMDLld0K3hbuYxoYxKmG7AWElVkUzzKCJ1ip+tut9GczdNnCS9VwicHZ9feIGolL1PyejeG/hFcyCa4eVjyh+/ueov+E42wjnKJGKJAemgDS61X/d971ZaU8woddWx3T6AHQpUzMj60CPRx1VZYsPj8IOHocTeDf3GNxlx4+3zRe5MzZmTwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 02:46:16 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 02:46:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Thread-Topic: [PATCH 1/3] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Thread-Index: AQHaTP4zVTrr9AB0XEWQmwIG6AB3qrDnJr2AgAAF+NCAAksZgIAAUNHg
Date: Thu, 25 Jan 2024 02:46:16 +0000
Message-ID: <SJ0PR11MB67441F08EAA5993C986B8D40927A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
 <20240122064015.94630-2-zhenzhong.duan@intel.com>
 <c47b95f9-ca42-4f8e-85d1-8fc72404e441@redhat.com>
 <SJ0PR11MB6744E96BE6A6014F7E43899892742@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ef080ff4-1fd5-4639-a316-6e09949608c7@redhat.com>
In-Reply-To: <ef080ff4-1fd5-4639-a316-6e09949608c7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5530:EE_
x-ms-office365-filtering-correlation-id: 36a151ee-b3da-4b2e-7df3-08dc1d4fcd68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cRte/crjsvZGGVTfTZtuFlF5t/hXbgfqiSA1qeug9T/RdIur0oYs6rSJVhc82astoLLZwi6fkU6lXG/ipqjHgJ9ZczM+yc96mvYAZaDiIHQRjUyIHcAQQrzpBYk1uuVLfC8BQwBRc/HPLpsrl0X8JAYixXRZmUsbopnIkcUyYyY8w0OZm7Ukc2V4Mo3dGTpb/bllaa/frgszq3dOpb7wodfS298IgeaNsRKrMtHFsJB9yPG4ixUU+3yF9eBKphJStoFS2GWiYBPUZrUmh3tb55vUnzh9PfIBkaMwZvZTyTdkMompvi2zTqlV7D05y2h2sfi+0l+heIwlshhbTAZ7CnKCNcSmsSjEZNocBib+Lpbp2UpW66ijK+GGVdabGvGDrwM44tgrlrOp5BeoA23lHFY1bjRiojjkUhyORzWIplkYgex9NU4eUSF7FLAPHmsNFNbxJpBcXcCsKnX8+AzOQ0r6jDhMzvlO7jcpdyXpSca7D/yilNbULnY3VBlMS+tlscOWeUaDLknh45Q+0G+7vokcxn2WYZsLW3Uk8JNzXAMUlomm2+fWAbW1ebMvaNKFDH5IZjm7hiJMU+T7CAj6jx58oWF+az0KDDmSZ6cAVmwCMHiCO4aVTqMPQCFY1qMd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(52536014)(9686003)(4326008)(8676002)(66574015)(8936002)(53546011)(6506007)(7696005)(33656002)(83380400001)(2906002)(107886003)(5660300002)(26005)(110136005)(76116006)(41300700001)(86362001)(478600001)(38070700009)(71200400001)(64756008)(66556008)(66476007)(66446008)(66946007)(316002)(54906003)(122000001)(82960400001)(55016003)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjBaWTNja2U2MGR1UDVOMVh4MlowVzlYVWF6SC9oZ2NRWXNiSjEzK21qMHox?=
 =?utf-8?B?K0gzQ1hoVlZ5TGN0Mlk2M0hHckhIMmszTDU3SUw3amh6Q2FVNk1QYmFLQUtE?=
 =?utf-8?B?WWtjcFdnT3hicjBwdEoxR0lXUCtyYkhzS01DYzgxUzZPK3N1d3dDSUZmMzJV?=
 =?utf-8?B?VDkvSmxFR2ZXeWljcldETUpjTnhrcWRuWkFUWXJwRDlZTHJwTDYxcFBXc3Bu?=
 =?utf-8?B?alU5QmFTQ2VtQnZLLzZtd0IvSnNEUURoMi8wUXJuSFA0c1gzK1FiK2Y1bzZV?=
 =?utf-8?B?VkhYU1c2eHArazZ1K2UxekNLRmx6L29VV1N4MDM2Y2FsYS82NXZQS0tmbkpq?=
 =?utf-8?B?dmNOMkNhZXlPOEdmT2tTamVFa21pNS9mNGw0cDAxektpTXlkMWcyWHZIVVNn?=
 =?utf-8?B?aUUwRmpId3MrOFQycU1rQkJhUHZsRldYNFVPT0sxMXFNVk9LMUhFd0Y1bkVV?=
 =?utf-8?B?UElFelFBazZ4U1ZSRG9PQUdtTjMreHM5b053SGdYVStacEVZR2NCOEZJZjdM?=
 =?utf-8?B?QnErRjY1TktNRWVyRnBDazFPbERDUkVCTFNRODhVSzBWb3JtSkpia1FBeHBi?=
 =?utf-8?B?TVpBd1gyNUFlYkUwaDU1VW9hbFd6enV0dzEvTExvcXd2aW1mMjRwdXYyMVcr?=
 =?utf-8?B?YTZHNDVVS2k4NmgxbWVkY0k1OHRTOUdHK051NVRVSjhyY09Od1h2YXVBUExG?=
 =?utf-8?B?elAvY0VXcjhSNXV3OFBlM054QVFLb2ZLUmkza3Z0YVU2L3BucFZmQXN0ZEVK?=
 =?utf-8?B?SEJzT05ZL3Fya05rcGJMdmg1d3BPM0R4aTA2b2JBRzI3ZHNid2twamdmcnZp?=
 =?utf-8?B?TjhReWZzd1lPdkJBeXUreTF4QVg2UlFzSTFDYzVmSHg5OVF6N2lSZVUvdXo0?=
 =?utf-8?B?UDNxSHZFcy9rcTNaYVowbEdDSjNaRWxMcnVpTzU3TS9SSFkzem45Tll0WmM0?=
 =?utf-8?B?ZzcwckFpNTRKTFhoZi9KYmc3YktGZm1iNEdBRnNkR1Ywb0lzSDBESkVWdjBD?=
 =?utf-8?B?bGFYTlhZSXZKRDZaRHRBcko1VXhVM1dwZXJHdmRkeGQwREFHS2ZmdjR1c0hR?=
 =?utf-8?B?bkxYTUowcmw3SHIwNWtWRzEzeStac1pEWDA2SXpCQzNpdFd5RGk0OEZKWUo4?=
 =?utf-8?B?eFFPS1pnaHkvbDRqUVE0T1JaeDR5VUN6L3hWQlVvemp1cnAvZThtWW16YXVs?=
 =?utf-8?B?Uk1PdHRtWWRxZWdYYVRNdlUzM3EwUTZyanhvTEV4K0szMlNVUW1YWlFDSHZH?=
 =?utf-8?B?YWl2RFRFYlozNUl5dnh1RlRzY0FvanFjMS9seDk0RFJVRVdZMWhMYkFzZm44?=
 =?utf-8?B?aXUvdndhcHFaMFgrcU0wS09sV1cvSWE4aGo3MEdsTFYrbmhSYkdJT240TlU1?=
 =?utf-8?B?TlJjb2RkMFRBQ3ZWUkk0QlhYajBNNTEyK0FzRk83R3gweUdCNnJVMThpcFov?=
 =?utf-8?B?ZGVMYXRmUVJ2ajZvRzRPSnNEd2RkOWo4SDd5aWNnaStTRy8rNzlPL0tUei92?=
 =?utf-8?B?dFBLQjNLMkxpU3I4c0g2Rkl4NUZrZWxaaXpJWjJnT2xVNk92ZXFMQzVEekxk?=
 =?utf-8?B?VjQ5aGNLVmhtdmJ3T3M4MUxlUGJUeEJub1cwOWJUaUpLS0Iwa0NMaU9rTmpl?=
 =?utf-8?B?SDFvNW85cjZsc0N0djVYTE1saU82Z21rUTFHdld1ZC9hcml0V3ZpVWhOQ3ox?=
 =?utf-8?B?V3Voa2U4U0JMNFNpWElqdWk1dWVBUnFwRTFYVVNBc3pJSEQrSC9MWElaem1I?=
 =?utf-8?B?c2w4TlNEdkhpSDZiRnFsaWk1THBqcTJnU1JsM2ZxenRvWXdrelNMdG1kajFN?=
 =?utf-8?B?cUEzYVRvYVlFaWN5ZzFJdHp1K1k3dXdiR3VQcWk5SnhQNWhCY3NjbHpjVGUy?=
 =?utf-8?B?U0xRSitacCt2L3h2K0oxUXk1MVE3K1g4S2tvV1B0VXlwTGFJZkFWeDdhRENQ?=
 =?utf-8?B?VWRzc3JDeGRxcmR0M3g4U2VoYnN1dnp4eXFZdy9VRFZ6ZWFwKzl2TFIrUG5U?=
 =?utf-8?B?dG9IRFhXaDNGMTlxeTZ4ajFWblhQRHBxQ3hYVnEzM1loRGQ4QVBTdnFLa3Ux?=
 =?utf-8?B?Y1JtWElLcjVnMzRDTGxWWW1wdmF5VEJya28vUTZIWGdLZG9SZE10MnNmNkdY?=
 =?utf-8?Q?KYKNyX9OjD+nEkuZ73SSzDhKP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a151ee-b3da-4b2e-7df3-08dc1d4fcd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 02:46:16.5455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dufB4SpUvOf/s1dFCgwWdUo//6DuPap5zBx5+P6JtSZPhFjDaP9G++szID4qUeoBoemqpcA1SgroQv1sK4QC3e8K5PjOPkmYlDldu2m+bg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5530
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSB2aXJ0
aW9faW9tbXU6IENsZWFyIElPTU1VUGNpQnVzIHBvaW50ZXIgY2FjaGUNCj53aGVuIHN5c3RlbSBy
ZXNldA0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiAxLzIzLzI0IDExOjAzLCBEdWFuLCBaaGVu
emhvbmcgd3JvdGU6DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJv
bTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8zXSB2aXJ0aW9faW9tbXU6IENsZWFyIElPTU1VUGNpQnVzIHBvaW50ZXINCj5jYWNo
ZQ0KPj4+IHdoZW4gc3lzdGVtIHJlc2V0DQo+Pj4NCj4+PiBPbiAxLzIyLzI0IDA3OjQwLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSU9NTVVQY2lCdXMgcG9pbnRlciBjYWNoZSBpcyBpbmRl
eGVkIGJ5IGJ1cyBudW1iZXIsIGJ1cyBudW1iZXINCj4+Pj4gbWF5IG5vdCBhbHdheXMgYmUgYSBm
aXhlZCB2YWx1ZSwgaS5lLiwgZ3Vlc3QgcmVib290IHRvIGRpZmZlcmVudA0KPj4+PiBrZXJuZWwg
d2hpY2ggc2V0IGJ1cyBudW1iZXIgd2l0aCBkaWZmZXJlbnQgYWxnb3JpdGhtLg0KPnRoaXMgY2Fu
bm90IGhhcm0gdG8gcmVzZXQgaXQgYnV0IEkgZG9uJ3Qga25vdyBpZiB0aGlzIGNhbiBiZSBlbmNv
dW50ZXJlZC4NCj4+Pj4NCj4+Pj4gVGhpcyBjb3VsZCBsZWFkIHRvIGVuZHBvaW50IGJpbmRpbmcg
dG8gd3JvbmcgaW9tbXUgTVIgaW4NCj4+Pj4gdmlydGlvX2lvbW11X2dldF9lbmRwb2ludCgpLCB0
aGVuIHZmaW8gZGV2aWNlIHNldHVwIHdyb25nDQo+Pj4+IG1hcHBpbmcgZnJvbSBvdGhlciBkZXZp
Y2UuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgIGh3L3ZpcnRpby92aXJ0aW8taW9tbXUu
YyB8IDIgKysNCj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMgYi9ody92aXJ0aW8vdmly
dGlvLWlvbW11LmMNCj4+Pj4gaW5kZXggOGE0YmQ5MzNjNi4uYmZjZTMyMzdmMyAxMDA2NDQNCj4+
Pj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4+ICsrKyBiL2h3L3ZpcnRpby92
aXJ0aW8taW9tbXUuYw0KPj4+PiBAQCAtMTI2NCw2ICsxMjY0LDggQEAgc3RhdGljIHZvaWQgdmly
dGlvX2lvbW11X3N5c3RlbV9yZXNldCh2b2lkDQo+Pj4gKm9wYXF1ZSkNCj4+Pj4gICAgICAgdHJh
Y2VfdmlydGlvX2lvbW11X3N5c3RlbV9yZXNldCgpOw0KPj4+Pg0KPj4+PiArICAgIG1lbXNldChz
LT5pb21tdV9wY2lidXNfYnlfYnVzX251bSwgMCwgc2l6ZW9mKHMtDQo+Pj4+IGlvbW11X3BjaWJ1
c19ieV9idXNfbnVtKSk7DQo+Pj4+ICsNCj4+Pj4gICAgICAgLyoNCj4+Pj4gICAgICAgICogY29u
ZmlnLmJ5cGFzcyBpcyBzdGlja3kgYWNyb3NzIGRldmljZSByZXNldCwgYnV0IHNob3VsZCBiZSBy
ZXN0b3JlZA0KPm9uDQo+Pj4+ICAgICAgICAqIHN5c3RlbSByZXNldA0KPj4+IHlvdSBjb3VsZCBy
ZW1vdmUgdGhlIG1lbXNldCBpbiB2aXJ0aW9faW9tbXVfZGV2aWNlX3JlYWxpemUoKSB0aGVuID8N
Cj4+IEdvb2Qgc3VnZ2VzdGlvbiwgd2lsbCBkby4NCj5CeSB0aGUgd2F5IHdoYXQgYWJvdXQgdGhl
IHZ0ZCBpbXBsZW1lbnRhdGlvbi4gcy0+dnRkX2FkZHJlc3Nfc3BhY2VzIGlzDQo+aGFzaCB0YWJs
ZSBidXQgSSBkb24ndCBzZWUgaXQgcmVzZXQgZWl0aGVyPw0KDQpHb29kIHF1ZXN0aW9uIQ0Kcy0+
dnRkX2FkZHJlc3Nfc3BhY2VzIGlzIGluZGV4ZWQgYnkgYSBrZXkgY29udGFpbmluZyAoUENJQnVz
ICopIHdoaWNoIGlzIHJlbGlhYmxlLg0KDQovKg0KICogUENJIGJ1cyBudW1iZXIgKG9yIFNJRCkg
aXMgbm90IHJlbGlhYmxlIHNpbmNlIHRoZSBkZXZpY2UgaXMgdXNhdWxseQ0KICogaW5pdGlhbGl6
ZWQgYmVmb3JlIGd1ZXN0IGNhbiBjb25maWd1cmUgdGhlIFBDSSBicmlkZ2UNCiAqIChTRUNPTkRB
UllfQlVTX05VTUJFUikuDQogKi8NCnN0cnVjdCB2dGRfYXNfa2V5IHsNCiAgICBQQ0lCdXMgKmJ1
czsNCiAgICB1aW50OF90IGRldmZuOw0KICAgIHVpbnQzMl90IHBhc2lkOw0KfTsNCg0KU28gSSBk
b27igJl0IHRoaW5rIGl0IHNob3VsZCByZXNldCwgc2FtZSBmb3Igcy0+YXNfYnlfYnVzcHRyIGlu
IHZpcnRpby1pb21tdS4NCg0Kcy0+dnRkX2FzX2NhY2hlW2J1c19udW1dIGlzIHVuc3RhYmxlIGFm
dGVyIGd1ZXN0IHJlYm9vdCwgYnV0IHZ0ZF9nZXRfYXNfYnlfc2lkKCkgaGFzDQpsb2dpYyB0byB2
ZXJpZnkgYW5kIHVwZGF0ZSBjYWNoZSwgc28gaXQgZG9lc24ndCBoYXZlIGlzc3VlLg0KDQpCdXQg
aWYgd2UgaG90cGx1Zy91bnBsdWcgYnJpZGdlIGluIGEgbG9vcCwgdGhlcmUgbWF5IGJlIGlzc3Vl
IHdpdGggcy0+dnRkX2FkZHJlc3Nfc3BhY2VzDQpCZWNhdXNlIG9sZCBBUyBpcyBuZXZlciByZWxl
YXNlZC4gQW55d2F5IHRoYXQncyBiZXlvbmQgc2NvcGUgb2YgdGhpcyBwYXRjaC4NCg0KPkFsc28g
aWYgaXMgcmVxdWVzdGVkIGhlcmUgd2Ugd291bGQgbmVlZCBpdCBvbiBzbW11djMgYXMgd2VsbC4N
Cg0KR29vZCBzdWdnZXN0aW9uLCBJIHRoaW5rIHNvLCBJJ2xsIGFkZCBhIHBhdGNoIHRvIHNtbXV2
MyBmb3IgcmV2aWV3Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

