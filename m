Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C553C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 04:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reohY-0003gG-Ny; Mon, 26 Feb 2024 23:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reohV-0003eL-GO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 23:04:17 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reohO-00030n-7v
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 23:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709006650; x=1740542650;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uGD5TqIuEA46IvM4jH43GTht7nJ/ETj4jveUKxUnl8g=;
 b=AN1RwDdvAtmSKXwZjp/bJ1zJaFPdSMws4jcZiyF5nWNczqTIXF0ECZwz
 CCuOxwZV1Nr1dTTpTEKmBHcao6tQEreG/aAJYSoh/jkt7jQ9GpWwQZJJJ
 PWH/6KYuupKHntHWKXDxKUeyiy/Rf8rIxZUFRR0tasRAE+YkLE6OUPdlB
 0r9gFVJ5SuIckU4fLKY21DPOH+swD23W2133CYeLTR5JAMTE8036nAhR7
 snA5rMN2NbEU1G+SfeYb1Cp6XuEs9mteK4wxrvf9102EGHZkcSJ6daAua
 0gRadsEa/gTAhHSgU03+/JLhwGcjkOzu+cuvOEsRtMZhdfev9SYTazcuS Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7117167"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7117167"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 20:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="11678257"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 20:04:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 20:04:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 20:04:04 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 20:04:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzKzoMnT5XNDzVuBk7Uk8csDA1IKSz1qoxnhcowr+qE81ZNY8x2cQ01//xOsp1MtrEk2OqsV8N6Da84+Btmc9ZFANoyLlBGdQML0/2gqPw5pb3Az9ZmKAbGRtD2sdRqUIIlu/JRuhn5HFg/foWZqEJVASV8gKfzV8h6v0E99wfoswW5xzNu4GdH6RzkH9cT/6VKau0i9CNvm4Ak8hja7H276dyssQ8oE4gQlaTKt4iojKYyxKKJuCMfXM2CB7s09UaYTmw/bxpd+VFCSMMmZ2D6ervw7CPXzIyzkPM/4VORN9bO05AWiPBFgQQBJYC/wzLxjvA5ToKSWE9Y3sRU9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGD5TqIuEA46IvM4jH43GTht7nJ/ETj4jveUKxUnl8g=;
 b=Y/Bf55Y3aDr6o1xDUt3R76a3qyxSObVWx/iyvrhoQeuEJ+ZsgG/mIcoR5Cu3UBh7wIceosYWSzrrmq0WddprVdjMrrV6/kM1OeVNPPLxQbh0kLBesByt8AcrgWIta72X15i8opcdT72mOSyL4MegOIn4dRekleVLDxSKWG/1z/ax1lXTSLQFaV9eZvg8aXd7TMwwukmVBW/faWFRIx5BL0b/TvyU0xNgm0wnq+aUBQ48UYDcm4W18PRmGpiQfgnnY3LbH7mJ7VhPGve4pLe9AKFPR+9gIWgNrPWXQ9x2xmY29Pp+13J/vrDAP069n47mmzh4YPDXbyQqGxX2oJhcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 04:04:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Tue, 27 Feb 2024
 04:04:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
 iommufd_device_get_hw_capabilities()
Thread-Topic: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
 iommufd_device_get_hw_capabilities()
Thread-Index: AQHaXbtgjLVWomWoWkW3kUi8UpCu07EcTbbwgAAvA4CAASrZ8A==
Date: Tue, 27 Feb 2024 04:04:01 +0000
Message-ID: <SJ0PR11MB6744280072555D9277976BAD92592@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-2-joao.m.martins@oracle.com>
 <SJ0PR11MB6744CF6315A3BD4906C115F8925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <03e4a92e-ccf7-4659-b9be-6530158b4cfa@oracle.com>
In-Reply-To: <03e4a92e-ccf7-4659-b9be-6530158b4cfa@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4979:EE_
x-ms-office365-filtering-correlation-id: f3d8b88d-7795-4a9e-9ea5-08dc374921a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fNWEw4W1cIw1IhUDZ25KCbPmb8uZxzSbx/A8dFgkbYjlOcqfy3FznUhx8O8poB9Gp6K++u5lquVl8031XOyunY3TOhQ4DU0W3L8HJ6ahl3M0Q139c43gs8j7q1L+FGLFjWYGI0ocx3Lltv+f/csIfKRIoi9rZRRbwbimzTRbR10s3QhryLQBFTdP+1TWW907dDVg1ZnjwaWriJO7zA6mtZOMdkDoo30fluPmFFRk7PuGsqlo2sSH0WuMaffjQbybdT29ZroctE5myJ0Kj2EpqVym3PLXT0OP+uruHMHKxkCHHRaTiOir2CsqnDB3x5WAtevQwDruiRAROk4cM7q2gDPhZFNeD4hvEvknDETQ2N2WctNyC1cxzoA4D1k1KyFo1hgzWzb0gmmNt0Y7fF8tFJPnRCHWunyNjCBzZLvogxL7kIIh+HFV7nfW2AAXQlviQ78cqb/bU0UTyCVD+wbm8Bl03GCSCIhIDxs2HgF/+QESHQ2fxhlubynoncwqXYaumsY/RM9kUhFPj0/SQsfesHj8+giATKctClqtiZp1FwK5I87d2LzwFvlT3gVfBZuFns6Xt4UETXjPDqaBEK09vXsMrIf4qU9sis5tWr4LOCTKLA29Vu2+o+jaiLhsRN+l0kUaiB6xUhzsIqXWiKCzu/WiMWbo/kBA7TmuYNLifooCDJ9/7M+IjvA7rgQ8w4bQRURGHH6uqol//4p4Q4TjgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGw5ajRCQnNoeEJQbUF1dXZVWWNHdGd4cVl4dnNZL052MlhWT01ZK0ZlWHhI?=
 =?utf-8?B?RzBjTjFTM3dkZC9RQXAxVWpyQm9yNWJuUURaLzhwbU42QlduRDRnWk5kM25D?=
 =?utf-8?B?cmFOQmdtZGlCU2xjSnk2TkxKbW9ES2RlUUVFRU51QlgzVnV5RzNIbXAxb1FZ?=
 =?utf-8?B?RHpwYmk4RHRxTG9GN1Z0b0h1bXRSY2c0Y1RiUWYrWStmdldXZnF3ZlE4UnZS?=
 =?utf-8?B?eTBGdkpXS1ZFaXAzYUpjeXo1VmR1Nzk5bVJwZExCWUJjOUhuVDlFbEJhcmxS?=
 =?utf-8?B?aGJPNWU0WXE3d1lsWnRtdVpEM24yUlJRQkJJWlA4a0FkSFh2ZnF3NGpEeFdr?=
 =?utf-8?B?dWk2RXErdkRneDV4ZW51QmRxMG5VTkRZanFKSlk5b2JRenhpNWs0NG5TOHB5?=
 =?utf-8?B?ckFtQkg5QzJseGxtUjBUOTdWbmVCTVoxSi91ck9vcnVqbm9GZDMzS2prZTI5?=
 =?utf-8?B?UTZ3ZDhhR0EvTHpUdGlnYXk5SlEreXBEM1dIalFSb0dJRTRKU3E3WlJpbC9S?=
 =?utf-8?B?VGhMME4vUUlmeHVySUlHSGFpZ2M4bmY2ZW9wLzg2RlNMMmlYaUZSdzYzTXJS?=
 =?utf-8?B?ZU4rK2F5emU1bHZqbk9kT0paeDdvNjgwSWZhWDN0TUNnRW5XL1JOTEhDUWZS?=
 =?utf-8?B?YVEzbklGSndxVjFmWFBKa0lMWkY4OVlSendKTHcwZkdHSHM1TFk1TWRZRmsy?=
 =?utf-8?B?R2h5c3djK1RvZnBTaGVWVVpZUVVIMHhwUnRibU1YVTJscXF3UENMbzJYcVRR?=
 =?utf-8?B?VmhhWi9BbDhEV2dhUVVDWkZDM2c0WFpCZlJiZ0tUVFl3YmtTejBPeDJDbFEy?=
 =?utf-8?B?RXdyMnpxUFk0WEQzS1ZxeHNSbkJOZDVRSTRRcmd2YzRod2VPb1RUdXJEK1BH?=
 =?utf-8?B?S2F0K2JtaHNpMXBwa3loUmJ2UXY3d1VIOVZhZ1NoYUl6bXlwdWVGb0ZLY2Nn?=
 =?utf-8?B?YnRZU2tzUE1Lako5SktkenFjS1FQMXRaMzlWRnI4YU9OOU1nZFJaY01KZHdG?=
 =?utf-8?B?eDQ5V2tGa0JOOEhMSjVJdXJTUWZuSUhFQjNoUzdGeFFHSTBoaVFKODB4VmRX?=
 =?utf-8?B?VkdoQ05IL2VNTXlNWS9xR01lVE9ScE9tU0VvMUd0bG9FQ2xycDR6QUl1Tmdw?=
 =?utf-8?B?VVFGVjlzNUdjZjJOQ3E3TWpUL00vcEFickZUOUZjT2kxdGFNWDFvWFpPZGV5?=
 =?utf-8?B?U1lreDBSTE5RSmMwOFFnT3R3UkoxTTlwWEFHNGlKaTdPb2c5MlhJYTByVGE3?=
 =?utf-8?B?UU4yR0hyWEJsaGtaSEZCYktKYWR5d2lIakthenRLblprNzMySUxwdVNsU3lk?=
 =?utf-8?B?bDhtY0lkcGY0NzJsS1RjcGVpcDdZbGhleG9CMVFNaEN5YUtmd093Q0pBaGUv?=
 =?utf-8?B?Z1I1c2V3dnRMRVkvMzI0aFRpMW1NbHR2eHIwNmRXa1YySElnOFpmSFVHTjJK?=
 =?utf-8?B?aEd6S2VDNzdZb0w0ekU0ckw3ZUdvMm9DK1BKcXR6cS9FVTV5RFZrb0praVlN?=
 =?utf-8?B?L2hkNkJrRjVZSXlyKzhHWE9vYVNrQ0dHS2VRRkhPSFhid2hEeHc2ZlMwYTZ6?=
 =?utf-8?B?anVPYTJOckUrOERrNHVnWVNDNXBFT1JlMWk5M0poam1ZVlpvdlVTRnpYWHVG?=
 =?utf-8?B?a25OTy8rVWRjM3pBU1V0NE9FTlp1V3h4c213WEhqbEZUZmttMERQRVVib1RG?=
 =?utf-8?B?ZEtuQXZZK05VMlBGYkxjZTl6cWVvZnEvS1RCTU4rT2gwZGNlWjhuUGNJM2NW?=
 =?utf-8?B?QndTVmQ3NjhJMTlQbGJta21XZ2Z5b2pCQXpnRWxUZTdSMDI1cjZhZ1loRkF1?=
 =?utf-8?B?c0hLMnVsTEpFS3lCQlJvKzRZTUphYVBiSHVhMTB3L3k0d1ZDSTBjMHdwOE9G?=
 =?utf-8?B?Mjg4SDBSb0JqRERxcHVscmRVWFhWVEEvYm5ZVTVERU0rcW1vd0dBeVpZYVhi?=
 =?utf-8?B?RlJybHlWTlFPUG9tRXZhSXNreU1Lbk5ndG1yQitpU3BCcFhiZW1vZERLaE5x?=
 =?utf-8?B?K1dIVEFyRGlqeHNSWWNRR3RTUEtWVDlZZ2NsK0VlSEJvUVV3WlBRMmMrYXFo?=
 =?utf-8?B?ZmNvS2FYdWpxMktIOFlYVHBaWjlWdU1wVmh2UjBTdUxqcWVwOU8xTzBzZE5X?=
 =?utf-8?Q?/HJOvtyCOFpI/PSTjqzS1ZEh9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d8b88d-7795-4a9e-9ea5-08dc374921a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 04:04:01.5571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6wR5L6bFWMkriiB0a2TNj9moyT9RwV2qHHrA6kuZb97xCGtX8kcHMdpivcNFiIR0tQE58MeriRvn0MgZoylnD3YuUCSX+4hum8aIKQQxnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4979
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIFJGQ3YyIDEvOF0g
YmFja2VuZHMvaW9tbXVmZDogSW50cm9kdWNlIGhlbHBlcg0KPmZ1bmN0aW9uIGlvbW11ZmRfZGV2
aWNlX2dldF9od19jYXBhYmlsaXRpZXMoKQ0KPg0KPk9uIDI2LzAyLzIwMjQgMDc6MjksIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIEpvYW8sDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4gRnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUu
Y29tPg0KPj4+IFN1YmplY3Q6IFtQQVRDSCBSRkN2MiAxLzhdIGJhY2tlbmRzL2lvbW11ZmQ6IElu
dHJvZHVjZSBoZWxwZXINCj5mdW5jdGlvbg0KPj4+IGlvbW11ZmRfZGV2aWNlX2dldF9od19jYXBh
YmlsaXRpZXMoKQ0KPj4+DQo+Pj4gVGhlIG5ldyBoZWxwZXIgd2lsbCBmZXRjaCB2ZW5kb3IgYWdu
b3N0aWMgSU9NTVUgY2FwYWJpbGl0aWVzIHN1cHBvcnRlZA0KPj4+IGJvdGggYnkgaGFyZHdhcmUg
YW5kIHNvZnR3YXJlLiBSaWdodCBub3cgaXQgaXMgb25seSBpb21tdSBkaXJ0eQ0KPj4+IHRyYWNr
aW5nLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGlu
c0BvcmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICB8IDI1
ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiBpbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgg
fCAgMiArKw0KPj4+IDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4g
ZGlmZiAtLWdpdCBhL2JhY2tlbmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+
IGluZGV4IGQ5Mjc5MWJiYTkzNS4uODQ4Njg5NGYxYjNmIDEwMDY0NA0KPj4+IC0tLSBhL2JhY2tl
bmRzL2lvbW11ZmQuYw0KPj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4+IEBAIC0yMzcs
MyArMjM3LDI4IEBAIHZvaWQgaW9tbXVmZF9kZXZpY2VfaW5pdChJT01NVUZERGV2aWNlDQo+Kmlk
ZXYpDQo+Pj4gICAgIGhvc3RfaW9tbXVfYmFzZV9kZXZpY2VfaW5pdCgmaWRldi0+YmFzZSwgSElE
X0lPTU1VRkQsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoSU9N
TVVGRERldmljZSkpOw0KPj4+IH0NCj4+PiArDQo+Pj4gK2ludCBpb21tdWZkX2RldmljZV9nZXRf
aHdfY2FwYWJpbGl0aWVzKElPTU1VRkREZXZpY2UgKmlkZXYsDQo+dWludDY0X3QNCj4+PiAqY2Fw
cywNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKipl
cnJwKQ0KPj4+ICt7DQo+Pj4gKyAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mbyBpbmZvID0gew0KPj4+
ICsgICAgICAgIC5zaXplID0gc2l6ZW9mKGluZm8pLA0KPj4+ICsgICAgICAgIC5mbGFncyA9IDAs
DQo+Pj4gKyAgICAgICAgLmRldl9pZCA9IGlkZXYtPmRldmlkLA0KPj4+ICsgICAgICAgIC5kYXRh
X2xlbiA9IDAsDQo+Pj4gKyAgICAgICAgLl9fcmVzZXJ2ZWQgPSAwLA0KPj4+ICsgICAgICAgIC5k
YXRhX3VwdHIgPSAwLA0KPj4+ICsgICAgICAgIC5vdXRfY2FwYWJpbGl0aWVzID0gMCwNCj4+PiAr
ICAgIH07DQo+Pj4gKyAgICBpbnQgcmV0Ow0KPj4+ICsNCj4+PiArICAgIHJldCA9IGlvY3RsKGlk
ZXYtPmlvbW11ZmQtPmZkLCBJT01NVV9HRVRfSFdfSU5GTywgJmluZm8pOw0KPj4+ICsgICAgaWYg
KHJldCkgew0KPj4+ICsgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIGdldCBoYXJkd2FyZSBpbmZvIGNh
cGFiaWxpdGllcyIpOw0KPj4+ICsgICAgfSBlbHNlIHsNCj4+PiArICAgICAgICAqY2FwcyA9IGlu
Zm8ub3V0X2NhcGFiaWxpdGllczsNCj4+PiArICAgIH0NCj4+PiArDQo+Pj4gKyAgICByZXR1cm4g
cmV0Ow0KPj4+ICt9DQo+Pg0KPj4gVGhpcyBoZWxwZXIgaXMgcmVkdW5kYW50IHdpdGggaHR0cHM6
Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LQ0KPmRldmVsLzIwMjQtMDIvbXNnMDAw
MzEuaHRtbA0KPj4gV2UgaGF2ZSB0byBnZXQgb3RoZXIgZWxlbWVudHMgaW4gaW5mbyBpbiBuZXN0
aW5nIHNlcmllcywgc28gbWluZCB1c2luZyB0aGF0DQo+aGVscGVyDQo+PiBJbnN0ZWFkIHRvIGF2
b2lkIHJlZHVuZGFuY3k/IEkgY2FuIG1vdmUgdGhhdCBwYXRjaCBhaGVhZCBmb3IgeW91ciB1c2Fn
ZS4NCj4+DQo+DQo+U3VyZS4NCj4NCj5CdHcsIHNwZWFraW5nIG9mIHdoaWNoLiBZb3Ugc2VyaWVz
IGNvdWxkIGFjdHVhbGx5IGJlIHNwbGl0IGludG8gdHdvLiBPbmUgZm9yDQo+aW9tbXVmZCBkZXZp
Y2UgYWJzdHJhY3Rpb24gcGFydCAocGF0Y2ggMDAtMDkpIGFuZCBhbm90aGVyIGZvciB0aGUgbmVz
dGluZw0KPmJpdHMNCj4oMTAtMTgpLiBGV0lXIHRoaXMgc2VyaWVzIGhlcmUgYXMgc3VibWl0dGVk
IHdhcyBhY3R1YWxseSBqdXN0IHBsYWNpbmcgaXQgb24NCj50b3ANCj5vZiB0aGUgaW9tbXVmZCBk
ZXZpY2UgYWJzdHJhY3Rpb24NCg0KSSBzZWUsIHdpbGwgc3BsaXQgaW4gbmV4dCB2ZXJzaW9uLg0K
DQo+DQo+SSBhbSBzdGlsbCBwbGFubmluZyBvbiBhZGRpbmcgdGhpcyBzYW1lIGhlbHBlciwgcHJv
YmFibHkganVzdCBjYWxsaW5nIGludG8NCj55b3Vycy4gTW9zdGx5IGJlY2F1c2UgSSBkaXNyZWdh
cmQgdGhlIGRhdGEvZGF0YS1zaXplIGFzIEkgYW0gb25seSBpbnRlcmVzdGVkDQo+aW4NCj52ZW5k
b3IgYWdub3N0aWMgY2FwYWJpbGl0aWVzLg0KDQpTb3VuZHMgZ29vZC4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg0K

