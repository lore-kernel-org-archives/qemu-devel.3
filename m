Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B802CC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSslJ-0007yW-S4; Thu, 25 Jan 2024 00:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSslH-0007yI-Lc; Thu, 25 Jan 2024 00:58:51 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSslF-0004c1-DJ; Thu, 25 Jan 2024 00:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706162330; x=1737698330;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=88MfD74Vn/GAF0E81TATSZCE2nCf7vi961tP9BwK+Rg=;
 b=UEftpWP47ZDfjbGoYqfjcgpCXyOugWzsdMXjrs4FBUkLlyqT+tasUppp
 MqLWbVI/MSqLQUoqn2F1nBdV7nEvjRpJAQUhPLn1KG60d+UdWQl/MgxYB
 x2gfw+yXdxapKJkjIj0aQkIdL1qJGh2nJcmj8bTkrs3LIa5x4P+WoPKWq
 GtAvMXF/vViWbr+JOSVgfwkRfoOzPdHPFtuxrQB/QRR9jqA7bO56MniGU
 7GW8scMSo7F0vFhlc9cJUA/RW4ch2PUxI4yxNqXUwYby49onu4foLYrUE
 Egr38IhFM1GoHTsIt9h60tSDUvMYCuJq1ashcZF+1n/lDSysuIXS8RUin A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15419266"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="15419266"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 21:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905855568"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="905855568"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jan 2024 21:58:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 21:58:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 21:58:44 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 21:58:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 21:58:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH6AXMts9EqgjLIs1Z4/d6dQWxZqVbPCj1201LNQ71dpMUOkY5d18A052OvnBEDF67bqpewJ3EhuIXwHjHuyZLLwFPFSEOVzo6Dk5Jbkpqx1KFMSNjyH60yg6ZnbadpEilrmzhvfH2TeLDJxTcr5pgtroCkVN0dHTjNiAaGs8J4zwcu1qHnGcfNHXqrNgla7K+bjQXCPFUL0xhtfN5ze265St+sWNCfAaYTNarDABEXxhWZGfh6fe2QuEgnjKjuoS8IE4uE3AoqEDZHwi8mYD7lCvYjWaaXnqJZhWjcx9FIz/synVPv7KJNGZz0CmckdHXyj7AdAqroCU9qlJjLwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88MfD74Vn/GAF0E81TATSZCE2nCf7vi961tP9BwK+Rg=;
 b=O5bA/nkSpb9iQ9IWfKTzkiprQTGrHGmyn8w/RaEtrv4+mDUD2xEr4REuraptNGaHZjb+YkMI4szdajwfdQhpzfheENZsM8bP2yKxPe072w8j2byxIUD/avIrUERXCYhUkJNJSAO1eY0avmDpbaNAg6hSIDbEr8M79GqC1HJVICkZR3v9+QM76XrI0JuPATJ5V1LDY7u65gz0cAQUrxUeCc5ZzPeZ8JWYPBHHRBtqYA59fKYx+UvQk9rsIirebNbP+o1KfTCXcZicm5hqqsQxq7AyOJMdWEBb3TYS3g08KrkZmxr6StCmTF79F1lyd4wlQtod/T7CKlItMAnra4TDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.22; Thu, 25 Jan 2024 05:58:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 05:58:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH 3/3] virtio-iommu: Support PCI device aliases
Thread-Topic: [PATCH 3/3] virtio-iommu: Support PCI device aliases
Thread-Index: AQHaTP46inHvlL2+OUiJIbcRnK6aorDpdWyAgABjtaA=
Date: Thu, 25 Jan 2024 05:58:41 +0000
Message-ID: <SJ0PR11MB6744271100E77EF545C8E875927A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
 <20240122064015.94630-4-zhenzhong.duan@intel.com>
 <afbb95d3-f18e-47d1-bb4f-ebcc89514c21@redhat.com>
In-Reply-To: <afbb95d3-f18e-47d1-bb4f-ebcc89514c21@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB5990:EE_
x-ms-office365-filtering-correlation-id: 4f013ed6-96e1-4c97-c4e2-08dc1d6aaedc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkxNXX/mm7bloSIfBNN/nFMXzrSqT71hyf/SO1sBN79gN6KdrNCUL732Yc8Xh9ypLiGbtZV8fR/gpBYQI1COkcd/s3O0gLNTprGKxF0JZw6EQIiQgEfy1t6VAbb7S+mtinJMyarLFrLcP7oxG09NeK0E2zQdbY4cgdomBWjN/GO6E7IctYIwtKIH27DAkY2wswKcl8pony8aloikH9tlZ/0+P4sAP23nWG7KeZf3yGqVAPmHp8NtPiLQEFv5d4lOrUIldAWFyfjUyMMbauLXsw5wg3OhJK+AIvRZKYa+TJFO025UoW2ox2/yBq2JZKKUA4D4Ar4n0kQBB17b63H3s+six1dFCpSI6hG7b3s7FvcvylX+Ron3Wo77R08I3hiK/E17wdlaFd4IzbwqjPX4/NxGex74+NufybJb8oXOCoaZmzMUiTH7tzRezLd2ksSp4iMxrDkjaxUvEzoHtCaMFcUlunSlhbDfToi4NriZUVQ/mWKfHgeJuRZqv4BpgDYTsQey0s6lX6E7xNc+ck1mVflX9Vvmjf8K91sDTOA84/o21+NRqPg7rhOuxtKemc2Ry4cN99UVYuiRjiHeS6258lYjHOn60IzhGTvxX7KxIxU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52536014)(8936002)(8676002)(4326008)(83380400001)(55016003)(110136005)(66476007)(54906003)(66946007)(107886003)(66446008)(66556008)(316002)(64756008)(122000001)(76116006)(26005)(2906002)(38100700002)(5660300002)(6506007)(7696005)(86362001)(82960400001)(478600001)(38070700009)(33656002)(9686003)(41300700001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czVLUWpyNEJGVXdpWTJkRGZYTlEzeXJsTGdaYjlubVFhOWRpQzJLTExOTDAw?=
 =?utf-8?B?VmpJWEVUY2lZeVNRZXNUNmlNdEFnNEFxM0ljNlRCczJnWkswajRkNmRzQ1F6?=
 =?utf-8?B?dkQvMHkyZE5tWmhjeHg5Nmc3T0VLZ2FXLzdnMHVjb0VBZkUwQjVINGNwOWNp?=
 =?utf-8?B?SFhWYTVseWx0MlQ5Y0ptOVRQSGxiSXJ3ajRxaWJ1N3pNdjRCQStzand4aWVE?=
 =?utf-8?B?NVFYc1JzS0I2akZrSkVYTXRQd3FJN2NYUXgydENQSFVsaTRWU3hOMWNaaVBI?=
 =?utf-8?B?VENXN1E4YVp1NTdyUVd6TjFsQWdlQkVRSnRxYWxabHVzWklLWk1nRHRUNFFD?=
 =?utf-8?B?WTV6UDY1SGtlcW9VbDNNTG0xTGRWZXB5RjhsZ1dISzhDanEyMHZ5WDRSUlF3?=
 =?utf-8?B?WjVlL3R4cm9EYkZ5OWJIKzhaWUgrR2s2Qm1RTXc1TTY4dEpWWlR4aWthcFpL?=
 =?utf-8?B?WTRzNm1qVVhFOEVZeG90endxY3ZVMStPQWZURVN6eEExUHpmdEZjZWV5Uy8z?=
 =?utf-8?B?N09mU0FtNjNpRmZzZ3E0bDZ4MHMrMExYYnZsZi9uLzhqUDhrTGphaUU2Qjlh?=
 =?utf-8?B?VzRXdEcvNWZUYXhDSitiMlFoZG9IT2xIUDMrYTBYZnRKdFR5MUU2YUtGZkF0?=
 =?utf-8?B?MHZaZGNZN2hWQ3I0UVRKZ2c3VFlab3FYWjhRM3F4VWdsd1BraFJYU2xXUEF6?=
 =?utf-8?B?dVY1VkFVYXFjYk5IbzJFc0ZZeXp5cWlNU2Vxb2VtaUxSclY3OXFGUDZJV0JE?=
 =?utf-8?B?b2VZVVNZWGh3ajNnL0xTSTEvQTQ5TnpnKzBHeU5ITkhzL29HUmU2UEx6YXhU?=
 =?utf-8?B?c1RhYWlYUFNCWDd5ZXBGYmF5RGJnZk0yWElJejRwbUdFTnhqckpiU0ZiMTZl?=
 =?utf-8?B?ZVJSQmxYUXJGQkw1citGYlJDZW9EWHBTaTRRc3VXZDlNYTR0QU5pakhjMmQz?=
 =?utf-8?B?cmJmQ2lCUlBJV2wvVm9mT3ZFdTl3Z1BDU2paVVY1dENpVFlOd256NGtqNyt2?=
 =?utf-8?B?eG1aM2FkR2p1blhSMmZkZFZvdHk1Znp0Zk50ZThZN0Q1ZlJQeng3Q3NLWkxo?=
 =?utf-8?B?d1lLaHdRVUNPMVZPWHNPTkIxQmdGN3F3SkxFcjVZbEtzd1Rldjh1c1A5Mno2?=
 =?utf-8?B?UGVlYlA1cTBMOGN0UHV0cEo4dTMrWDk2UlFlNlYzUERHaUFHY0NvWWxHMkEy?=
 =?utf-8?B?RWZXVDl5ZnNiSmlGdjgxMmJMamV1SlpWU1JudlFHTmJ1UFB3N1YvbysvUDV0?=
 =?utf-8?B?Y0V3QVprODNGMnAwVmdnVTZKY0ZvQ0RZcWlSV0l6KzVpQ1pXeFVaVjJNUTdI?=
 =?utf-8?B?R3NZaEZjeXQ3c0NWd3l0MENhOXFZTFMzVmgzcE9VZ2h0SjVGQk5KbVkyWUw2?=
 =?utf-8?B?SmsrcFBzTmN3a1FIdUM0cDRKQUxFNTRCK3ZjckFIK2tQMnlpYlFhdHZWNFpV?=
 =?utf-8?B?aSs3Y1FZMkNLRFR1RkxjMTNsSzhyQTB5QTlwK0UrQWl4VXpHNllIMTNON3lD?=
 =?utf-8?B?dFBPVlB3NTZ2aWNmU05jcFJPVVNFdlhFWGxLMllDRSszUWpneDI1ZXI1K3Ar?=
 =?utf-8?B?UU4xTGthYXgrQTdDUDdwQWxja3NCUVluc0VRZWNUK1dQeklqVUpWbSsvNU5j?=
 =?utf-8?B?eFZxS0NEZWh3SjJjbGUvK2Y5N2pKYlhWVUFmc3dPUXM3SFhaeWtsTFZIeFIv?=
 =?utf-8?B?bU5qK1JHNTMwZXJ2dDdnWm85UFhjUUx1T1phRnRvdzBHUjVvNHNDMjF0bUN5?=
 =?utf-8?B?TzJaNHNmOHlDTkkzbnRwdk90QUdyUExiQ0dJSmk5NENLRnRyN21HYUcxYm1n?=
 =?utf-8?B?NmorU000QVhnYkxmK3NIVnBWeTc2OGdacS85UkFQQ2VCeXRZT2EzNTFGK01V?=
 =?utf-8?B?Nk41RU5heklsQlNTNzYyM0ZzQmhKbStGZ3owRnNzK1JpTmhvVVAzaVNQRmxk?=
 =?utf-8?B?cTI3eHM0SW4raCtOaVU5Q212Zk1DZktIZFFUOWtqRWVnbHIyQU92WGxBQVBH?=
 =?utf-8?B?OE1weXdFUC9Makt5dHUzRDFPdHNTd1RaMkJZbDlxVkc3YTlwcHE3a3FMY0JJ?=
 =?utf-8?B?N2pZWWpoNHh1Y3hNWElHZ2VjVG9WTHZvTUZWTi9XSE5TQm9xOEhzaTJxNzNB?=
 =?utf-8?Q?dRMq9WAyqkqpBMvP2ebPoxSeP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f013ed6-96e1-4c97-c4e2-08dc1d6aaedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 05:58:41.6709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcadeTX5xDwIUD2H7rJ19CyoPUh8h59bzbbf0jbYWpHlI9hMlOUNJ9Tz+ErZTV/lKQCkApTXa74c/Isu8ChaK6KDkeJKSKl3RpF09jF9gcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDMvM10gdmlydGlvLWlvbW11
OiBTdXBwb3J0IFBDSSBkZXZpY2UgYWxpYXNlcw0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiAx
LzIyLzI0IDA3OjQwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEN1cnJlbnRseSB2aXJ0aW8t
aW9tbXUgZG9lc24ndCB3b3JrIHdlbGwgaWYgdGhlcmUgYXJlIG11bHRpcGxlIGRldmljZXMNCj4+
IGluIHNhbWUgaW9tbXUgZ3JvdXAuIEluIGJlbG93IGV4YW1wbGUgY29uZmlnLCBndWVzdCB2aXJ0
aW8taW9tbXUgZHJpdmVyDQo+PiBjYW4gc3VjY2Vzc2Z1bGx5IHByb2JlIGZpcnN0IGRldmljZSBi
dXQgZmFpbCBvbiBvdGhlcnMuIE9ubHkgb25lIGRldmljZQ0KPj4gdW5kZXIgdGhlIGJyaWRnZSBj
YW4gd29yayBub3JtYWxseS4NCj4+DQo+PiAtZGV2aWNlIHZpcnRpby1pb21tdSBcDQo+PiAtZGV2
aWNlIHBjaWUtcGNpLWJyaWRnZSxpZD1yb290MCBcDQo+PiAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9
ODE6MTEuMCxidXM9cm9vdDAgXA0KPj4gLWRldmljZSB2ZmlvLXBjaSxob3N0PTZmOjAxLjAsYnVz
PXJvb3QwIFwNCj4+DQo+PiBUaGUgcmVhc29uIGlzIHZpcnRpby1pb21tdSBzdG9yZXMgQVMoYWRk
cmVzcyBzcGFjZSkgaW4gaGFzaCB0YWJsZSB3aXRoDQo+PiBhbGlhc2VkIEJERiBhbmQgY29yZWxh
dGVzIGVuZHBvaW50IHdoaWNoIGlzIGluZGV4ZWQgYnkgZGV2aWNlJ3MgcmVhbA0KPj4gQkRGLCBp
LmUuLCB2aXJ0aW9faW9tbXVfbXIoKSBpcyBwYXNzZWQgYSByZWFsIEJERiB0byBsb29rdXAgQVMg
aGFzaA0KPj4gdGFibGUsIHdlIGVpdGhlciBnZXQgd3JvbmcgQVMgb3IgTlVMTC4NCj4+DQo+PiBG
aXggaXQgYnkgc3RvcmluZyBBUyBpbmRleGVkIGJ5IHJlYWwgQkRGLiBUaGlzIHdheSBhbHNvIG1h
a2UgaW92YV9yYW5nZXMNCj4+IGZyb20gdmZpbyBkZXZpY2Ugc3RvcmVkIGluIElPTU1VRGV2aWNl
IG9mIHJlYWwgQkRGIHN1Y2Nlc3NmdWxseS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvdmlydGlv
L3ZpcnRpby1pb21tdS5jIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3
L3ZpcnRpby92aXJ0aW8taW9tbXUuYyBiL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPj4gaW5k
ZXggZDk5YzFmMGQ2NC4uNjg4MGQ5MmE0NCAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZpcnRpby92aXJ0
aW8taW9tbXUuYw0KPj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+PiBAQCAtMzk5
LDI3ICszOTksMjcgQEAgc3RhdGljIEFkZHJlc3NTcGFjZQ0KPip2aXJ0aW9faW9tbXVfZmluZF9h
ZGRfYXMoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHJlYWxfZGV2Zm4pDQo+PiAgew0KPj4gICAg
ICBWaXJ0SU9JT01NVSAqcyA9IG9wYXF1ZTsNCj4+IC0gICAgSU9NTVVQY2lCdXMgKnNidXMgPSBn
X2hhc2hfdGFibGVfbG9va3VwKHMtPmFzX2J5X2J1c3B0ciwgYnVzKTsNCj4+ICsgICAgSU9NTVVQ
Y2lCdXMgKnNidXMgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPmFzX2J5X2J1c3B0ciwNCj5yZWFs
X2J1cyk7DQo+PiAgICAgIHN0YXRpYyB1aW50MzJfdCBtcl9pbmRleDsNCj4+ICAgICAgSU9NTVVE
ZXZpY2UgKnNkZXY7DQo+Pg0KPj4gICAgICBpZiAoIXNidXMpIHsNCj4+ICAgICAgICAgIHNidXMg
PSBnX21hbGxvYzAoc2l6ZW9mKElPTU1VUGNpQnVzKSArDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZihJT01NVURldmljZSAqKSAqIFBDSV9ERVZGTl9NQVgpOw0KPj4gLSAgICAg
ICAgc2J1cy0+YnVzID0gYnVzOw0KPj4gLSAgICAgICAgZ19oYXNoX3RhYmxlX2luc2VydChzLT5h
c19ieV9idXNwdHIsIGJ1cywgc2J1cyk7DQo+PiArICAgICAgICBzYnVzLT5idXMgPSByZWFsX2J1
czsNCj4+ICsgICAgICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+YXNfYnlfYnVzcHRyLCByZWFs
X2J1cywgc2J1cyk7DQo+PiAgICAgIH0NCj4+DQo+PiAtICAgIHNkZXYgPSBzYnVzLT5wYmRldltk
ZXZmbl07DQo+PiArICAgIHNkZXYgPSBzYnVzLT5wYmRldltyZWFsX2RldmZuXTsNCj4+ICAgICAg
aWYgKCFzZGV2KSB7DQo+PiAgICAgICAgICBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIl
cy0lZC0lZCIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVf
VklSVElPX0lPTU1VX01FTU9SWV9SRUdJT04sDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG1yX2luZGV4KyssIGRldmZuKTsNCj4+IC0gICAgICAgIHNkZXYgPSBzYnVz
LT5wYmRldltkZXZmbl0gPSBnX25ldzAoSU9NTVVEZXZpY2UsIDEpOw0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBtcl9pbmRleCsrLCByZWFsX2RldmZuKTsNCj4+ICsg
ICAgICAgIHNkZXYgPSBzYnVzLT5wYmRldltyZWFsX2RldmZuXSA9IGdfbmV3MChJT01NVURldmlj
ZSwgMSk7DQo+Pg0KPj4gICAgICAgICAgc2Rldi0+dmlvbW11ID0gczsNCj4+IC0gICAgICAgIHNk
ZXYtPmJ1cyA9IGJ1czsNCj4+IC0gICAgICAgIHNkZXYtPmRldmZuID0gZGV2Zm47DQo+PiArICAg
ICAgICBzZGV2LT5idXMgPSByZWFsX2J1czsNCj4+ICsgICAgICAgIHNkZXYtPmRldmZuID0gcmVh
bF9kZXZmbjsNCj5idXQgdGhlbiB0aGlzIG1lYW5zIHRoZSAyIGRldmljZXMgd291bGQgYmUgYWJz
dHJhY3RlZCBieSB0d28gZGlmZmVyZW50DQo+SU9NTVUgTVJzIHdoZXJlYXMgaW4gcHJhY3RpY2Ug
dGhleSBjYW5ub3QgYmUgZGlzdGluZ3Vpc2hlZCBmcm9tIGFuDQo+SU9NTVUgcG92Lg0KDQpZZXMs
IG5vcm1hbGx5IHRoZSB0d28gZGlmZmVyZW50IElPTU1VIE1ScyBzaG91bGQgbGluayB0byBzYW1l
IGd1ZXN0IGRvbWFpbiwNCnNvIHRyYW5zbGF0aW9uIHJlc3VsdCB3aWxsIGJlIHNhbWUuIEJ1dCBp
ZiBhIG1hbGljaW91cyBndWVzdCB0cnkgdG8gYnJlYWssDQp0aGVuIGl0IGZhaWxzIHRvIGJsb2Nr
IHRoYXQuDQoNCj5TaG91bGRuJ3QgdGhlIHZpcnRpby1pb21tdSBkcml2ZXIgdXNlIHRoZSBzYW1l
IGVwX2lkIGZvciBib3RoDQo+ZGV2aWNlcyB3aXRoaW4gdGhlIHNhbWUgZ3JvdXA/DQoNCklJVUMs
IHlvdSBtZWFuIGZvciBkb21haW4gYXR0YWNoIGFuZCBub3QgcHJvYmUgcmVxdWVzdD8NCkkgd2Fz
IHRoaW5raW5nIGVwX2lkIHJlcHJlc2VudGVkIGFuIGV4aXN0aW5nIGRldmljZSBpbiBndWVzdCwg
bm90IHRoZSBhbGlhc2VkIG9uZS4gDQoNCj4NCj5Ob3RlIHRoZXJlIGFyZSBzb21lIGtub3duIGlz
c3VlcyBhYm91dCB2aXJ0aW8taW9tbXUgYW5kIHBjaWUtdG8tcGNpDQo+YnJpZGdlcyB3aGljaCB3
ZXJlIHJlcG9ydGVkIGVhcmx5IGxhc3QgeWVhciBhbmQgY29uZmlybWVkIGJ5IFJvYmluDQo+TXVy
cGh5LiBTZWU6DQo+DQo+W1JGQ10gdmlydGlvLWlvbW11OiBUYWtlIGludG8gYWNjb3VudCBwb3Nz
aWJsZSBhbGlhc2luZyBpbiB2aXJ0aW9faW9tbXVfbXIoKQ0KPjxodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMzAxMTYxMjQ3MDkuNzkzMDg0LTEtDQo+ZXJpYy5hdWdlckByZWRoYXQuY29t
LyNyPg0KDQpUaGFua3MgZm9yIHNoYXJpbmcsIGl04oCZcyB2YWx1YWJsZfCfmIoNCg0KQlJzLg0K
Wmhlbnpob25nDQo=

