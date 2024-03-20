Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1FDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxu3-0000kk-JS; Wed, 20 Mar 2024 11:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmxu1-0000kL-09
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:30:53 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmxty-0003Uq-95
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710948650; x=1742484650;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9F1mgws5jY0NigfUCzWwD3XpwArSwoY47vCD9QtoUiE=;
 b=n3b4qR2SHKGBB1Ubcep6EYuVFQZcw05+9qd4bxb5BNfOzfX3KRUmKRXv
 RVmzBBFXG0Q0AbJJfw54i3BNxBJ2ZshegazYpk1gaLys3vdXQDUc+mEec
 F02Nt3uct0WrBMZLfOTOFj/2eun8CzgFE9/nsadRfm/GiizFqg1WR81sN
 fG1WJIGGZCHYRPRinaCjo2j15v3ZPclReMkAlRbkjohZ2HxTi9/wfUUle
 BEFBmJ8FrqRytXXE8nMKpojZGsgdz538XDUj9rcspsk1TP5qggiennoIy
 0zPmUkORg2Aogyeam57BUKLWr5/BgbP88C2HgxVI9DF/ZTx8v+uLrIkQG Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5717744"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5717744"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 08:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14171759"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 08:30:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:30:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 08:30:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:30:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcujZNt+KNaed5TYNKk0NqhjoHJ0JxgeXiBJqSuVjuLav2jUScY7bVFlOZUixO4chcIl/Fp8SXZuQTbEc1+RPbRipeA+PavkX9oSIxf7+iGVY3immD36QcEHopK6Tv9XctBZ1EnvVS9KizR8/5W8+uA934abbR6S/77u3jK3Bhn3SBrBuRzWm+2NXZjXuolj0fHk1v23E1Zi/66ucez438aLueIoAodScfhlqD2+IORP5gWTFFcVvTKV+pVaKRShTVh13GB1Fc+dT4fE4YIGKzQ1bXTio601mP1vUHOKgvn8ZWYwLnnskAL+2k8L+1fRHNeYxZWuGcUfmqnzMVW+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F1mgws5jY0NigfUCzWwD3XpwArSwoY47vCD9QtoUiE=;
 b=jM1NCXSm0zftn2gZ8juJXQ2/RsG2K7cTEslWA482AAEuGnJlRj69Qo+xwHrB3MQz4qDD8U0Dxa1CAuPoYAICnrLj2Bh5O8RhA1yEfPymxE9KFhCuXW7QmZTidUG49MYDSFgNK7oq5S0OvOpVlXNlVMEN4926ieEEX0+wKkVT+Weibhs4xuGukcp6K//R3c/+Ui+xNs/xpMaLDZ/DGmH5c4B0Rr7HElG3sr14LArvAvVG91N/9qSDsVNkcTa4nhzjmBdBD6UPvOHI5wCcBtfqBashfpr+aHsMoIK3MYvl/1pvw6PKaHwI/LNzbGUTlWduzqsvFvQ+VzWUbai7kslW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 15:30:41 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 15:30:41 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 7/7] tests/migration-test: add qpl compression test
Thread-Topic: [PATCH v5 7/7] tests/migration-test: add qpl compression test
Thread-Index: AQHaeqFN3RFTN7VnMUC5HRmYwLqpVrFAck4AgABKnfA=
Date: Wed, 20 Mar 2024 15:30:40 +0000
Message-ID: <PH7PR11MB5941FDC1E4B9723CBBAEC2B4A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-8-yuan1.liu@intel.com> <Zfq-Yu-aLa1OJL25@redhat.com>
In-Reply-To: <Zfq-Yu-aLa1OJL25@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS7PR11MB6293:EE_
x-ms-office365-filtering-correlation-id: 84f039e7-e4ee-4433-8520-08dc48f2b36e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 50q+upU/1q9N6flUGgSVFKMJE7mYAA8IwhQyimPCnkW9yhWdcbn+3lQMsjOKOyKD6DKmsyQLBbLcDfFai5NQbfncgOsnNlHcNmFUH5f1zFJwHXa+TOn3gRQ84e3E881BqlKP5sDQnFV9dqzlbnPt+5+q82/Ijl3C+M+xkKTOQBp8VUFl61QRzN8CydeYr5dSgfGgGcXYuE/RpUdMSE3jaFjwWsqw1m+tsaIz5XrXHsF5/xKTZDj/RWJembIMqfODIUxRDabDomyNBRLdHb4l0YTVtWLw06+d2xeoq9BNrb5XpIx3LhSp77h5w6+0mDFRu3/MLyw9FJXqr7OkDPJ6MiwinbJGlCz+XzlwGGYOlxp0CefQFCSU1839oIsHZQ6nyU3p4ra70xsORTZw/3yzc7EigBAkEkRXAmBxG7BV+k1ccI5a0tq/rEZ5wis78Aea2YnoUAtXoiZSkkrFwCnyjq5HpDt0B7jpl+0LGEZVccUUwXUnymLU335uCOKb3W9Ww/Bs5pz1aZfkYyz6wNpKu2hAxx+vXg5/I7omA9jD4YG4YDpWvqA5rvKi1h49LSmtfpPOKZ1ie9W5TfmGtQ+wKwzx+7PW+YEtKLtBQlZHcKpwv4YLd+dNw75EjGFa9bjpFfo6R6zmB/eUla/uK5tJSIHPAt/zE+FZm9GUzr4xhS70b4T3enrF0/atRwDNGfJ3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3lGbjlZQktoTUUxQkdZVEhzWW11ci9QVjVvZFhQc1Z6emV5NFA0ZUptUUk4?=
 =?utf-8?B?bUdISlE4d2lxYVZGdUhZWHRZRkdzb2dOTWphcDBzazV4SnhKSFhvaE5mcjVh?=
 =?utf-8?B?dW43TFF2cXpsRVVVcGx4dXVVUHNkM2tOTGlmRWhsV2F5K3lVMmppZlNmVVZl?=
 =?utf-8?B?MjNSdEt1MWNrVWk4MmlNL3I3OHdub0hvR0UwWG1mN2ZpNjUwNE03ZTFQSFNK?=
 =?utf-8?B?OE4zS1FFanVrMkxmclNab1hNbktBK3VMVkhlRVpmT0pPUjN3RlJiUGZKeVFt?=
 =?utf-8?B?ZGNHY2MxdW1ONnZ1a0FlNUZ4VFpSN1ZhT1VoaXpCMHBkT3JYTHdLWldGVHdZ?=
 =?utf-8?B?aFNyT3lsL0VzeURqbnNYMTdWV2R5Zy9Nbkk4QXNGWXB5NVZyRDgxMm9tZnd1?=
 =?utf-8?B?Sit5RzJQd0ttTUxJd2xpMlM1amhvK2RBL3hBcjhZeG9vTGJYWVZrMktDMWhq?=
 =?utf-8?B?Z01naUJvYXloWnphLy9PU0ppNUhhblRiLyttdUlHVFRBMnZRNnNYeDl2dVJz?=
 =?utf-8?B?d2xXYkVBeE5vV3B0VDRJd1c3WWFCVVc3ODE4bTBrOXBBak9rTGoxMlEyQUFS?=
 =?utf-8?B?K3hRL25rejkreWdwOWF2NCs0WFFXYVFhdEE2c2FSMXExQk5sUk13ZlhZUlpT?=
 =?utf-8?B?VGExZjFwM3AwdXUzdVBoRXZSOEthRmlad2FHLzkzQitpNEd1TVNWRnNUVHZS?=
 =?utf-8?B?LzlPMTVSTkEvSTdSNzg4SGhyOXZyWVRJN1NSRXJHYTkrYVBBbW83Qk41S3Z4?=
 =?utf-8?B?ZkxOeTRCSThxc1FRZlhNQnNDWmtxUnRaeXFCaklpZjYyVUZzQnUrc05xNVNW?=
 =?utf-8?B?K3VNdFlPZXBDR2xORTlRTXFFTWZUcHBwejRUMEZjRXpheU5xa2JkcWp3OE53?=
 =?utf-8?B?eWFTWTF2a25KeWhDb0hWOTNLdGNNMWlsY2U2UGowMmc5ZzJVZm8xWlRRUTl4?=
 =?utf-8?B?WWY0WEo3YkJFRVNkcDErTExsbUppcGhOMUUyNytaaUN3QnpFOVRWTDBYMCtn?=
 =?utf-8?B?L29UZ2tMQWZ2aVZKQzNaNWJMU3RIbkdkczRKdUh4aW10akxZRk8zSnNXcjVW?=
 =?utf-8?B?NkNTNlN4aVNoVEVJYStucXZzeHp1U2psOGY4MlpKSFNzdjZQTlh3U2tnMTl1?=
 =?utf-8?B?b0F1Q3lmSi84UFRJRjNXSWZYaFo4TXBWZllTQ0poSUdOcXlwVDR6L2Q0RUhQ?=
 =?utf-8?B?cUNacDBOSmRNbCtZbnJndUtlVjJ3bTREOEpQU01aOVMydXp4MXdBMFVCcDR2?=
 =?utf-8?B?emwxNE9XS1duUE1SOEZvbE5aMTNPWm55VVZHNk5SeUEzZVo3VWcvT0VLOVdD?=
 =?utf-8?B?MVU5NXBaZCtkbG55ek1tRDBKWFJ4YWtsYWlrWk0vb3VlL0hlVDRkUlFtNWxa?=
 =?utf-8?B?eWNJN0lOMFdnQndTbHluZjFxRUZua1RGSk5lMkZPNjJSYTlYREozRFFpQ0Nv?=
 =?utf-8?B?Y2hHOXlFL09YTnJvS01ML0paQVJWaXVSaDlrNnYxaHFiUlhMWmRqS0gxYU5S?=
 =?utf-8?B?TlJBTXY5aytNRFQ0Z01KMnZtcHFvZC85YzhvRkt3UTJ6Z2MrQU9HZlZUbDdH?=
 =?utf-8?B?SVp1Q0FrQnhUK3FzNjluRUVkdlJmeDBIazlydzYzdWFQU0JsMnpsZHlBcU5X?=
 =?utf-8?B?WGo2dXdYemx1WVRXeHBQcTlpZFdxbjdFUGNmVU5CSExDZW5LendoSkF0QXdt?=
 =?utf-8?B?ZGFTOTRud1llTDEwZjI0blEyZnRkL1A0MTg3MkRTT3dxYS82QnZqRHd1QTc1?=
 =?utf-8?B?NDhzbXlWMFVMRUhGdSthYks3UWtqRTdYTngvTHRjVE9RTHI1Tkd2SzdTaEgw?=
 =?utf-8?B?bE1LcXN6UGkzTG5YWWJoYk5pZzEzQldtaXJUL3pjZnRkOHVZS1JQSzdEV1Bm?=
 =?utf-8?B?dERjNWU5V2R0S2pOUXB6ZWlTd016YmM5TUJEMUhGUldiWFRVV29UYmwvYkJY?=
 =?utf-8?B?VEVxMjMwZVRUaCs3bmd1ZCtkRXVKMi94ZUpVVHNkU0llMFh2dG1Ud3U5M1g0?=
 =?utf-8?B?ZEd0Y0N3SHQ0MSt6SllyNFdLK3JQUzNqdXBUT3h5dnlaS3lSeVk1Mk1jSklC?=
 =?utf-8?B?M2dFUFRYL1gydnhZWGV3Smg4T3ozMjE1Q2pHRHdldEMzNnAzNUl6MVlScWVn?=
 =?utf-8?Q?2DA5Szt/Pr2cka+B+xKxco7cj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f039e7-e4ee-4433-8520-08dc48f2b36e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 15:30:40.9284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+Xu0DW5LUzaYvyVXYCA6crv6bm6ZMrqFu3Smes+2Yo26MAGoa4QYZfbPlqcTY3VJj5xUg09p/1EeJ2XQri4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0
IDY6NDYgUE0NCj4gVG86IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+IENjOiBw
ZXRlcnhAcmVkaGF0LmNvbTsgZmFyb3Nhc0BzdXNlLmRlOyBxZW11LWRldmVsQG5vbmdudS5vcmc7
DQo+IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOyBicnlhbi56aGFuZ0BieXRlZGFuY2UuY29tOyBa
b3UsIE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjUgNy83XSB0ZXN0cy9taWdyYXRpb24tdGVzdDogYWRkIHFwbCBjb21wcmVzc2lvbiB0ZXN0
DQo+IA0KPiBPbiBXZWQsIE1hciAyMCwgMjAyNCBhdCAxMjo0NToyN0FNICswODAwLCBZdWFuIExp
dSB3cm90ZToNCj4gPiBhZGQgcXBsIHRvIGNvbXByZXNzaW9uIG1ldGhvZCB0ZXN0IGZvciBtdWx0
aWZkIG1pZ3JhdGlvbg0KPiA+DQo+ID4gdGhlIG1pZ3JhdGlvbiB3aXRoIHFwbCBjb21wcmVzc2lv
biBuZWVkcyB0byBhY2Nlc3MgSUFBIGhhcmR3YXJlDQo+ID4gcmVzb3VyY2UsIHBsZWFzZSBydW4g
ImNoZWNrLXF0ZXN0IiB3aXRoIHN1ZG8gb3Igcm9vdCBwZXJtaXNzaW9uLA0KPiA+IG90aGVyd2lz
ZSBtaWdyYXRpb24gdGVzdCB3aWxsIGZhaWwNCj4gDQo+IFRoYXQncyBub3QgYW4gYWNjZXB0YWJs
ZSByZXF1aXJlbWVudC4NCj4gDQo+IElmIHNvbWVvbmUgYnVpbGRzIFFFTVUgd2l0aCBRUEwsIHRo
ZSBtaWdyYXRpb24gdGVzdCAqbXVzdCoNCj4gcGFzcyAxMDAlIHJlbGlhYmx5IHdoZW4gZWl0aGVy
IHJ1bm5pbmcgb24gYSBob3N0IHdpdGhvdXQNCj4gdGhlIFFQTCByZXF1aXJlZCBoYXJkd2FyZSwg
b3Igd2hlbiBsYWNraW5nIHBlcm1pc3Npb25zLg0KPiANCj4gVGhlIHRlc3QgY2FzZSBuZWVkcyB0
byBkZXRlY3QgdGhlc2Ugc2NlbmFyaW9zIGFuZCBhdXRvbWF0aWNhbGx5DQo+IHNraXAgdGhlIHRl
c3QgaWYgaXQgaXMgaW5jYXBhYmxlIG9mIHJ1bm5pbmcgc3VjY2Vzc2Z1bGx5Lg0KPiBUaGlzIHJh
aXNlcyBhbm90aGVyIHF1ZXN0aW9uIHRob3VnaC4gSWYgUVBMIG1pZ3JhdGlvbiByZXF1aXJlcw0K
PiBydW5uaW5nIGFzIHJvb3QsIHRoZW4gaXQgaXMgZWZmZWN0aXZlbHkgdW51c2FibGUgZm9yIFFF
TVUsIGFzDQo+IG5vIHNhbmUgZGVwbG95bWVudCBldmVyIHJ1bnMgUUVNVSBhcyByb290Lg0KPiAN
Cj4gSXMgdGhlcmUgYSB3YXkgdG8gbWFrZSBRUEwgd29yayBmb3Igbm9uLXJvb3QgdXNlcnMgPw0K
DQpUaGVyZSBhcmUgdHdvIGlzc3VlcyBoZXJlDQoxLiBJIG5lZWQgdG8gYWRkIGFuIElBQSByZXNv
dXJjZSBkZXRlY3Rpb24gYmVmb3JlIHRoZSBRUEwgdGVzdCBiZWdpbnMNCiAgIEluIHRoaXMgd2F5
LCB3aGVuIFFQTCByZXNvdXJjZXMgYXJlIHVuYXZhaWxhYmxlLCB0aGUgbGl2ZSBtaWdyYXRpb24g
DQogICB0ZXN0IHdpbGwgbm90IGJlIGFmZmVjdGVkLg0KDQoyLiBJIG5lZWQgdG8gYWRkIHNvbWUg
YWRkaXRpb25hbCBpbmZvcm1hdGlvbiBhYm91dCBJQUEgY29uZmlndXJhdGlvbiBpbiANCiAgIHRo
ZSBkZXZlbC9xcGwtY29tcHJlc3Npb24ucnN0IGRvY3VtZW50YXRpb24uIEluIGFkZGl0aW9uIHRv
IGNvbmZpZ3VyaW5nIA0KICAgSUFBIHJlc291cmNlcywgdGhlIHN5c3RlbSBhZG1pbmlzdHJhdG9y
IGFsc28gbmVlZHMgdG8gYXNzaWduIElBQSByZXNvdXJjZXMNCiAgIHRvIHVzZXIgZ3JvdXBzLg0K
ICAgRm9yIGV4YW1wbGUsIHRoZSBzeXN0ZW0gYWRtaW5pc3RyYXRvciBydW5zICJjaG93biAtUiB1
c2VyIC9kZXYvaWF4IiwgdGhlbg0KICAgYWxsIElBQSByZXNvdXJjZXMgY2FuIGJlIGFjY2Vzc2Vk
IGJ5ICJ1c2VyIiwgdGhpcyBtZXRob2QgZG9lcyBub3QgcmVxdWlyZSANCiAgIHN1ZG8gb3Igcm9v
dCBwZXJtaXNzaW9ucw0KDQo+ID4gU2lnbmVkLW9mZi1ieTogWXVhbiBMaXUgPHl1YW4xLmxpdUBp
bnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE5hbmhhaSBab3UgPG5hbmhhaS56b3VAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICB0ZXN0cy9xdGVzdC9taWdyYXRpb24tdGVzdC5jIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QuYyBi
L3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi10ZXN0LmMNCj4gPiBpbmRleCA3MTg5NWFiYjdmLi4wNTJk
MGQ2MGZkIDEwMDY0NA0KPiA+IC0tLSBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi10ZXN0LmMNCj4g
PiArKysgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24tdGVzdC5jDQo+ID4gQEAgLTI4MTUsNiArMjgx
NSwxNSBAQA0KPiB0ZXN0X21pZ3JhdGVfcHJlY29weV90Y3BfbXVsdGlmZF96c3RkX3N0YXJ0KFFU
ZXN0U3RhdGUgKmZyb20sDQo+ID4gIH0NCj4gPiAgI2VuZGlmIC8qIENPTkZJR19aU1REICovDQo+
ID4NCj4gPiArI2lmZGVmIENPTkZJR19RUEwNCj4gPiArc3RhdGljIHZvaWQgKg0KPiA+ICt0ZXN0
X21pZ3JhdGVfcHJlY29weV90Y3BfbXVsdGlmZF9xcGxfc3RhcnQoUVRlc3RTdGF0ZSAqZnJvbSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRVGVzdFN0
YXRlICp0bykNCj4gPiArew0KPiA+ICsgICAgcmV0dXJuIHRlc3RfbWlncmF0ZV9wcmVjb3B5X3Rj
cF9tdWx0aWZkX3N0YXJ0X2NvbW1vbihmcm9tLCB0bywNCj4gInFwbCIpOw0KPiA+ICt9DQo+ID4g
KyNlbmRpZiAvKiBDT05GSUdfUVBMICovDQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCB0ZXN0X211
bHRpZmRfdGNwX25vbmUodm9pZCkNCj4gPiAgew0KPiA+ICAgICAgTWlncmF0ZUNvbW1vbiBhcmdz
ID0gew0KPiA+IEBAIC0yODgwLDYgKzI4ODksMTcgQEAgc3RhdGljIHZvaWQgdGVzdF9tdWx0aWZk
X3RjcF96c3RkKHZvaWQpDQo+ID4gIH0NCj4gPiAgI2VuZGlmDQo+ID4NCj4gPiArI2lmZGVmIENP
TkZJR19RUEwNCj4gPiArc3RhdGljIHZvaWQgdGVzdF9tdWx0aWZkX3RjcF9xcGwodm9pZCkNCj4g
PiArew0KPiA+ICsgICAgTWlncmF0ZUNvbW1vbiBhcmdzID0gew0KPiA+ICsgICAgICAgIC5saXN0
ZW5fdXJpID0gImRlZmVyIiwNCj4gPiArICAgICAgICAuc3RhcnRfaG9vayA9IHRlc3RfbWlncmF0
ZV9wcmVjb3B5X3RjcF9tdWx0aWZkX3FwbF9zdGFydCwNCj4gPiArICAgIH07DQo+ID4gKyAgICB0
ZXN0X3ByZWNvcHlfY29tbW9uKCZhcmdzKTsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+
ID4gICNpZmRlZiBDT05GSUdfR05VVExTDQo+ID4gIHN0YXRpYyB2b2lkICoNCj4gPiAgdGVzdF9t
aWdyYXRlX211bHRpZmRfdGNwX3Rsc19wc2tfc3RhcnRfbWF0Y2goUVRlc3RTdGF0ZSAqZnJvbSwN
Cj4gPiBAQCAtMzc4OSw2ICszODA5LDEwIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikNCj4gPiAgICAgIG1pZ3JhdGlvbl90ZXN0X2FkZCgiL21pZ3JhdGlvbi9tdWx0aWZkL3RjcC9w
bGFpbi96c3RkIiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB0ZXN0X211bHRpZmRfdGNw
X3pzdGQpOw0KPiA+ICAjZW5kaWYNCj4gPiArI2lmZGVmIENPTkZJR19RUEwNCj4gPiArICAgIG1p
Z3JhdGlvbl90ZXN0X2FkZCgiL21pZ3JhdGlvbi9tdWx0aWZkL3RjcC9wbGFpbi9xcGwiLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHRlc3RfbXVsdGlmZF90Y3BfcXBsKTsNCj4gPiArI2Vu
ZGlmDQo+ID4gICNpZmRlZiBDT05GSUdfR05VVExTDQo+ID4gICAgICBtaWdyYXRpb25fdGVzdF9h
ZGQoIi9taWdyYXRpb24vbXVsdGlmZC90Y3AvdGxzL3Bzay9tYXRjaCIsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgdGVzdF9tdWx0aWZkX3RjcF90bHNfcHNrX21hdGNoKTsNCj4gPiAtLQ0K
PiA+IDIuMzkuMw0KPiA+DQo+ID4NCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0t
DQo+IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tDQo+IGh0dHBzOi8vd3d3LmZsaWNr
ci5jb20vcGhvdG9zL2RiZXJyYW5nZSA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAg
ICAgLW8tDQo+IGh0dHBzOi8vZnN0b3AxMzguYmVycmFuZ2UuY29tIDp8DQo+IHw6IGh0dHBzOi8v
ZW50YW5nbGUtcGhvdG8ub3JnICAgIC1vLQ0KPiBodHRwczovL3d3dy5pbnN0YWdyYW0uY29tL2Ri
ZXJyYW5nZSA6fA0KDQo=

