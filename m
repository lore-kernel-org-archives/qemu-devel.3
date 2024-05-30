Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10802C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqV-0007B9-Tt; Thu, 30 May 2024 08:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqT-0007A1-HQ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:25 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqL-0006CX-NS
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071917; x=1748607917;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gNcnDcGIoZWQA9eLeBSUZ/Vwq52+cEGSr0++VuU4HGY=;
 b=NvPHhUI98IcVg9jRFHyjewbdI4UCY23/SE2PRTVOe1DtFeuDTvuLaCIA
 ssJ7pmHv8lCCyrAVrikTwyTplDnqerTDK2IcUmyS5Irtlf6SHMZokV72Q
 +9iKNI+lANvbQwFPveyKLbVq4dFQbDtn/Ku07BBMLMr07q+bAHrmsLKIw
 pvtvZO+uxO4yqvuw/Zs6Cuci5BBP0v0CavVIPL5pzFSZ8QU2fb1ZA3wjj
 4NQfylvYSaWW6+jygDWAd5vcwztMPNuo/tVGTI9d5tqa/GuPGmHzMR5xL
 IMrNIrvZB9ajD1xseDbEMAZIb5oHdh80YI343UdF6qAlKirAEBbg4w9Ig w==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13581119"
X-MGA-submission: =?us-ascii?q?MDF4KhjoaBdeXoFC9wYhCZomhS3YUDLBt13Kxf?=
 =?us-ascii?q?ZglEb/hg5xub+MbtBduFheZ1WFo0FpXxlU2OW62RyLnfTLpAkkR0aQwg?=
 =?us-ascii?q?sZK1X3LfR6OOLYEYILERmAfYRAu7atFZE/O4NcIJKhszAg0vJkbgwKBA?=
 =?us-ascii?q?GGBUOZCEN9DyEWaQC6lmv6WA=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDSxqvdkkXdHWK6Zo4j1n7Md3MandHRELijm/aJl5eQ3AWERO812K/9EODCDdXgQo46PgFXOQ7Lln720t2rJ/K8MaRUG5Do0iFudcr3MqdaqGxQrQokSQzbUlL9PIf2d4pYYlVhpgmVHYjOuGEPePKAHXVrWuwn6JNJyfiQJt9ROX6O31K3TQixxrzc7dsGnU/UNS9xyisgd8vnM9XSPLv+XroIDR5RVMTJcIJYbOx17MxYCIGhIABmHlnfvSofXsvXICZUSJyQTBXaFtcsukLWmBX6pyaVfHUpHrV2m40yZryH1ugN11y0FWN7/RO4m8WjZdTDCejLhObjh9j1P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNcnDcGIoZWQA9eLeBSUZ/Vwq52+cEGSr0++VuU4HGY=;
 b=McFNQ8ppIVc7QGmF2WNgnNlqOYMhWBjySvqpmJ39m7cFpk3IP85rK/zlOf8n6WFrigqaLDKgod1Pgw8JRxs3Fm7g4zPw2EJe/EqZBxZ65DFo7yfchbzZSxyy4m/IulQqzQOXY1qNM2QmjXcX413xDJocg8jc1JUdnpU3pm2AgIj/JG2Dq538s+1OWAmCazGb+qBpeHVKgM61FCfT30bcpb/Ih3y92OaudpcqoNTJ20XWT9j+AMWtJ9nyeTQ1C5LzRSU8iw+JBQv+bTF4dfFqgEfJD5Ygty8l2vLqWFpjVY9FAMjGUTVfiRAM6oRqd7jqI83gh4Ts6mVU7tl9dqjKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:25:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:25:04 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 7/8] intel_iommu: declare registers for PRI
Thread-Topic: [PATCH v1 7/8] intel_iommu: declare registers for PRI
Thread-Index: AQHasoxmdbGUniy0gkq3Lt1n7bIUGA==
Date: Thu, 30 May 2024 12:25:04 +0000
Message-ID: <20240530122439.42888-8-clement.mathieu--drif@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8069:EE_
x-ms-office365-filtering-correlation-id: 4a1a30c3-77ab-48b5-390b-08dc80a38917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NTRJeU1TODFCWFhTYUljbHRuMFlTbkNBanZLWVdrUkRwcnN4Ukg3bU10VVNE?=
 =?utf-8?B?aHR5dXpLRnNLQUhNRURJWUY4dFNqMitYQ2ZMU3dabHBhZDFQaEZWU2FJN3Zq?=
 =?utf-8?B?NWRTcGpVMFhKQjZBN2diMVRjeUQ5ZkltVGxYWnBHSmwxL1dtQ2dmK2czT3di?=
 =?utf-8?B?b1JJTXAreG9zeGkrSnhidmNRVy8xQzQ4MlhhZHFNelNNcFd0NFFzaUdwUUt2?=
 =?utf-8?B?a0VXYUk1TmhFV2ptdXpOeklGVTFHRy95MFV6R0VONGhKcEd2QUhIZVU4Z3pG?=
 =?utf-8?B?bXlvcXExYVZsYTZFZ3pwVTdIRUZNNEg5ZHlDdVloeWNzaldNQkFNczRJMVgy?=
 =?utf-8?B?aHpZVEhIQkloUXNkcmJQVmI5dXc0UmpSY3RuZjdyd2dobVY3ajFKbVphNjhT?=
 =?utf-8?B?Q2MrcklwMkdPQzlmbG1HOEpXN1dVVU9oaXMya1d0Zi9sZTkzUnNPNlV6QjVi?=
 =?utf-8?B?SXZuNU8yTGd3TmhmOUd2NWJrSTNqVnRYYUF2ZTF4RVh6YnVmVjcydlhQZlBp?=
 =?utf-8?B?dDNXNHRUSUdpR2NWanNwN2dZaGZYTXhDR2dhYlNodXd5V240WlIvM0ZrS1hF?=
 =?utf-8?B?cWx2aitNc3l4a3RHazR4OTVmeFlqVXZDZ09GWHZJeDBydVZvaHV2MzlEZDdu?=
 =?utf-8?B?NXVlSkkzM3JZUmdESG84VEFXOHlOdmNXdCtieCt4RG5xa21qdWVJSk5kRmF3?=
 =?utf-8?B?azc2RjMrMzZrbUw1QjZ4MExnVFpuYUVwcC9JU3BOV0hRT2xvRUVJaGRUMGU4?=
 =?utf-8?B?SWZ3Nnc0ZTF4OW5wWHZPRjk5QkdrdDRSaTNpRlNYL0hNQlNUWjVJOVQvZ1pv?=
 =?utf-8?B?NVlIczRmSmVoN0Z4ZldMbU8vbmpjZ0J5WjNjTFFQbjJta0FoMHZSUHhyOGRE?=
 =?utf-8?B?QWJ3SkpVUUFOSjEwazg3TlU3eTRMQWJQUGpBbWlFTmtidVR5Q0dvTlY0cGla?=
 =?utf-8?B?YXJEUEcyazhTRGsrWFdxUmh4VEVVallLRS9VNDU1N2Y5QjBxZ1pFWTFYOWhq?=
 =?utf-8?B?cEVicVF6S21VU2ZzZXdvRzFXeTVSdU1rWXhobmZUb0lNV3VxdDM4d2hnZll3?=
 =?utf-8?B?Y28zb1gvQzN5SWVjZEVYQllmVDFSRU02dEhiUndVSUZtZFdPZ3lqZHVDWVJr?=
 =?utf-8?B?djFqZlZvRnZwdWhFeW9GSS9YaGFCN2VENEhlUGxHVEZNblRHdGFmdWdCMkFV?=
 =?utf-8?B?WU5KaDRyUmo4Q3hsVmMwUy9ZbGtWeDJjNGhaNHRSOUN5ZSt3TGZVZjFvNnZu?=
 =?utf-8?B?NG0yMFVjNXQ3bTFYWXpjQlFYLzlFVDVod3lLelpEQlc0cU1tNHFkRFlYemhm?=
 =?utf-8?B?UStEb3RvZktLWHE3dlYvV2t0dmtYZnFZTEc0OGFKeHVZUHBuQVNScEpkelBH?=
 =?utf-8?B?UDIzOVM0d3hVSEJRcVZ2K0lVcy9BQW9HZGhudGF1UjYvenE5azlrREhNdWZj?=
 =?utf-8?B?SnRFT1dtam5nYWdBNlJ0SjVvZ0ZCamcyaVZHRkRGWVVmcjg1dnpDR1hnRmdB?=
 =?utf-8?B?T01GU3ZjS0Z2bzArZWJrQktPRGQvRHAxOUI1S0ppUzE2bVlzVDV0SnlpVDFO?=
 =?utf-8?B?YUk1YkhMckkrS0Q5amVrZ1oxTTYrUko4VW1VLzhlZU9NdDAvOUhYdW9GcjAr?=
 =?utf-8?B?NGdZQy84YWgydHZibHRvclViMnlMUVlPN2o5Tndkc2lyZzhlNHlSZDNHRFFv?=
 =?utf-8?B?Y0lyc0x2NXN6UDh4TGZBNUFEeWFVc1VmRS9FeGk3SzlJY2ljWXhIWXZmb1Ux?=
 =?utf-8?B?MVBBTEp6WGthQjVFKzN2bHVLVkU5K1lPdkxScGV2RldaMnZSN0dZL3Iyai8r?=
 =?utf-8?B?NkFxWXJBaU4wZ3h3bzE2Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1gvUG1aanp2bisxQStCckg4NEtJdndWZmsxZjVIcnMwRnJ2Z3RPNVZuWW5q?=
 =?utf-8?B?YVF1anpwVXZGc1hRWWp4NmkyOXNxTnFJNXdDR2JyQVpoSk04MVd5RHM3aExa?=
 =?utf-8?B?cktZQncyRVJqTWY0bVJoNWJYK213Y00rOG40WndvS0RBd1hVVGZ4blh4SHhW?=
 =?utf-8?B?QmpvV0VZbXAyZW5ER0ZhLytCTUlRTlo4V1U2aWI4cjVXdEhHdFltN21RdVRE?=
 =?utf-8?B?YkltWGtKSVRtRlVKZHBaYjQvdExpWGZLeUJDZ2xjNVppVUdlQTVqNWhiaHJa?=
 =?utf-8?B?b0hYQ0xzUHFkNElxbDZnL3BMQmh3OWIvcnFMUWwyYUdoSjloc3RSaGRkeW1X?=
 =?utf-8?B?OWc1K0FnTEV0emlRdkVrdW1XWWIrWk5OYTNaL2N1RlM0Rjh2VUxnazZtU01I?=
 =?utf-8?B?R1lLbjdsU2Rpa1ZoVVRqNE1zOUd5azNwcEpKT3VobTdndDdSeitqUUNHV2U3?=
 =?utf-8?B?S1BsUzF2ZWlRVDdpcnVDRXUzMmZtNXplTjdhMUdVQUVpVCttZW0wSTYvU2Zo?=
 =?utf-8?B?cm1vVU9zZTJCbEthM2xJRHlvRU1DL3dmNWtkWWlySjBEZ2c5UkFmOU5qZ2s3?=
 =?utf-8?B?VGhxallWNnM2WmVTTi9EMVlLY3pXWnlTZ3NFcWJrU3hlaU1VcVBKNUhzampo?=
 =?utf-8?B?Z2RzaFYzMnViVGVNOUlNMFRISkd3RWI2cVR1bGxBNFN4a2NGbVUzS25EbWtJ?=
 =?utf-8?B?SklFVUcyeFJDK1B0S1dvcDFYN3FjbDdNcXdYUENGSm92WUlzeWx6ME5NYjVh?=
 =?utf-8?B?T3NLTC95QTRvaXcyZ2Q2T0IySUp5b1B1YTFEb3ZXVVZoY01Xdm1ZYURmOUNx?=
 =?utf-8?B?WmFCU3dmV28wN0IzK0R6dzZTM3lmRmZHMFdFcEFhSlBTZkRBQWpka1lqMUNS?=
 =?utf-8?B?M0c2ZUtZZTR3dTFOblVIVzE1ZzlQdmZHaWhMZTlnc0tzVmQwWklwL2VIRlly?=
 =?utf-8?B?aWFPVWhqTWhCMjZ2TUdXdWpwWCtBUUdFZVhkMlE4TDJhNmptbkJnRjJKU09w?=
 =?utf-8?B?MTV5YnlwQ1B6RThGRHZ2emdYd21hRTNoUkJlUUY1RHdSZDJnUENIV2U0UGFS?=
 =?utf-8?B?d3Y2ZDJiWVhTaE5jajNab05UU2VzSXNMaTVVWUNNOFBHSnBQZ1RZVlV0ZU5i?=
 =?utf-8?B?UDBMSi93bGR1OUNzUDBQckNGaVBDNUhUTjlpbmJUV1d5dENnL0kvSEVoWktQ?=
 =?utf-8?B?amFDSUdEYjJqenRPS09EcnoyZ08zS2tpNHhqTGYycVlhUEFNN2hDV2phNnZL?=
 =?utf-8?B?RjlNMVhKQ3prdmR6K001bWtITVVBZU5BMWZ4WDBNcTZFVnhpaEluS2tDMXFy?=
 =?utf-8?B?ak42VzJuc1RIdGxJM2g2VE5MNWZtckNpVDRqZkliKytYVDBOUlRFK082RnZ2?=
 =?utf-8?B?bVkwZnpRTDhpczZRQzBYNGcxKzR2YUg5K1g0K2RqM2xtUEl0NlFiaEVXZGFL?=
 =?utf-8?B?cmFmOWZ5Q09COTMyNEg4YjhGM29lcXNibWlFamVKTG1Ob2pTWmUxTVFjUDFx?=
 =?utf-8?B?WUJLNjZoUHhDVmtheTNLZFRTak5IOWs5dkRCdEc2Uis5RWNrcWJ2ZHVqS1dO?=
 =?utf-8?B?ek11b1FwN3UvSUU3dE1YQ3cwQjVOS2JvTC9LOWlOZXk3aWNWaFJGaVQ1MkZa?=
 =?utf-8?B?MG0zT0FwaHdjUnpHYmxVQ0lvTEx5WG0wVitlN1FUajNZZWxCdjFYbUZWQ21y?=
 =?utf-8?B?QmMxL0NtUVBmV3YwWUJHS0g2NGkya2ZEQTBxUmpkeTJCQVgzTWJoZHVPMFVI?=
 =?utf-8?B?MGRBOHU1OGZaWi90L3Q0NEIzcDdDV2dtTE5iMWc5ZzVBMy9ZOGJ2ZHZXKzJK?=
 =?utf-8?B?am9nNzJ3bjdML2FvcGlYUjVYc0J2R0pZN1J1c0JMR2YyakdtdmRPTjJoK1NF?=
 =?utf-8?B?eWp1WG1CcE5IemlTbFFWSGtwOXNxUExPcjNNT1Q0N0poeHVVR1pMT1prQitj?=
 =?utf-8?B?UVcyeHpKRmwwU3FsQ2k4NlQrUEZEVVJCNE9XWGVFRzRaOFNoeEdhRGFiQ3V1?=
 =?utf-8?B?R2dadlRramVBMlR6UmxId05jTlJiSmNXeEpWTWsvN2NZZStiTUZXRmhkSXh3?=
 =?utf-8?B?a1BneW51ZksxZjg2NEpJdjIrR01KWmx5WDgzZDVlbHJRcnlVaXRoU1cwTCtH?=
 =?utf-8?B?QXNPV3F2L1dDR0dxek1scEdiY1lzSjRqZFFyVWYra2QvZWtIUEFia0RNaTRh?=
 =?utf-8?Q?Enx7nvPr2TgXjhgP+Et5wDo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE45F1EC0C64749B7B52C214DF0DA8E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a30c3-77ab-48b5-390b-08dc80a38917
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:25:04.7705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26RHbAEA0TfJ4IZEoo7AgrHDH5TV3QPWxB/8ffxbQn+tH51HZ6//uC234UbPkhurmFdrkddHgr+uNvyUoHH0JNggvi3qzkDpTshuKk1Hrc2g0OMZjej43PiVfZX2nnqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA2NyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY3
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggMmU3OGViZTZkMi4uODk5NjU1OTI4ZCAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtNDYwOSw2ICs0NjA5LDI3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9oYW5kbGVfaWVjdGxfd3Jp
dGUoSW50ZWxJT01NVVN0YXRlICpzKQ0KICAgICB9DQogfQ0KIA0KK3N0YXRpYyB2b2lkIHZ0ZF9o
YW5kbGVfcHJzX3dyaXRlKEludGVsSU9NTVVTdGF0ZSAqcykNCit7DQorICAgIHVpbnQzMl90IHBy
cyA9IHZ0ZF9nZXRfbG9uZ19yYXcocywgRE1BUl9QUlNfUkVHKTsNCisgICAgaWYgKCEocHJzICYg
VlREX1BSX1NUQVRVU19QUFIpICYmICEocHJzICYgVlREX1BSX1NUQVRVU19QUk8pKSB7DQorICAg
ICAgICB2dGRfc2V0X2NsZWFyX21hc2tfbG9uZyhzLCBETUFSX1BFQ1RMX1JFRywgVlREX1BSX1BF
Q1RMX0lQLCAwKTsNCisgICAgfQ0KK30NCisNCitzdGF0aWMgdm9pZCB2dGRfaGFuZGxlX3BlY3Rs
X3dyaXRlKEludGVsSU9NTVVTdGF0ZSAqcykNCit7DQorICAgIHVpbnQzMl90IHBlY3RsID0gdnRk
X2dldF9sb25nX3JhdyhzLCBETUFSX1BFQ1RMX1JFRyk7DQorICAgIGlmICgocGVjdGwgJiBWVERf
UFJfUEVDVExfSVApICYmICEocGVjdGwgJiBWVERfUFJfUEVDVExfSU0pKSB7DQorICAgICAgICAv
Kg0KKyAgICAgICAgICogSWYgSVAgZmllbGQgd2FzIDEgd2hlbiBzb2Z0d2FyZSBjbGVhcnMgdGhl
IElNIGZpZWxkLA0KKyAgICAgICAgICogdGhlICBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkIGFsb25n
IHdpdGggY2xlYXJpbmcgdGhlIElQIGZpZWxkLg0KKyAgICAgICAgICovDQorICAgICAgICB2dGRf
c2V0X2NsZWFyX21hc2tfbG9uZyhzLCBETUFSX1BFQ1RMX1JFRywgVlREX1BSX1BFQ1RMX0lQLCAw
KTsNCisgICAgICAgIHZ0ZF9nZW5lcmF0ZV9pbnRlcnJ1cHQocywgRE1BUl9QRUFERFJfUkVHLCBE
TUFSX1BFREFUQV9SRUcpOw0KKyAgICB9DQorfQ0KKw0KIHN0YXRpYyB1aW50NjRfdCB2dGRfbWVt
X3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQgc2l6ZSkNCiB7DQogICAg
IEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCkBAIC00NjQ5LDYgKzQ2NzAsMTcgQEAgc3Rh
dGljIHVpbnQ2NF90IHZ0ZF9tZW1fcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1bnNp
Z25lZCBzaXplKQ0KICAgICAgICAgdmFsID0gcy0+aXEgPj4gMzI7DQogICAgICAgICBicmVhazsN
CiANCisgICAgLyogUGFnZSBSZXF1ZXN0IEV2ZW50IEFkZHJlc3MgUmVnaXN0ZXIgKi8NCisgICAg
Y2FzZSBETUFSX1BFQUREUl9SRUc6DQorICAgICAgICBhc3NlcnQoc2l6ZSA9PSA0KTsNCisgICAg
ICAgIHZhbCA9IHZ0ZF9nZXRfbG9uZ19yYXcocywgRE1BUl9QRUFERFJfUkVHKTsNCisgICAgICAg
IGJyZWFrOw0KKw0KKyAgICBjYXNlIERNQVJfUEVVQUREUl9SRUc6DQorICAgICAgICBhc3NlcnQo
c2l6ZSA9PSA0KTsNCisgICAgICAgIHZhbCA9IHZ0ZF9nZXRfbG9uZ19yYXcocywgRE1BUl9QRVVB
RERSX1JFRyk7DQorICAgICAgICBicmVhazsNCisNCiAgICAgZGVmYXVsdDoNCiAgICAgICAgIGlm
IChzaXplID09IDQpIHsNCiAgICAgICAgICAgICB2YWwgPSB2dGRfZ2V0X2xvbmcocywgYWRkcik7
DQpAQCAtNDcxMiw2ICs0NzQ0LDE3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9tZW1fd3JpdGUodm9pZCAq
b3BhcXVlLCBod2FkZHIgYWRkciwNCiAgICAgICAgIHZ0ZF9oYW5kbGVfaW90bGJfd3JpdGUocyk7
DQogICAgICAgICBicmVhazsNCiANCisgICAgLyogUGFnZSBSZXF1ZXN0IEV2ZW50IEFkZHJlc3Mg
UmVnaXN0ZXIgKi8NCisgICAgY2FzZSBETUFSX1BFQUREUl9SRUc6DQorICAgICAgICBhc3NlcnQo
c2l6ZSA9PSA0KTsNCisgICAgICAgIHZ0ZF9zZXRfbG9uZyhzLCBhZGRyLCB2YWwpOw0KKyAgICAg
ICAgYnJlYWs7DQorDQorICAgIGNhc2UgRE1BUl9QRVVBRERSX1JFRzoNCisgICAgICAgIGFzc2Vy
dChzaXplID09IDQpOw0KKyAgICAgICAgdnRkX3NldF9sb25nKHMsIGFkZHIsIHZhbCk7DQorICAg
ICAgICBicmVhazsNCisNCiAgICAgLyogSW52YWxpZGF0ZSBBZGRyZXNzIFJlZ2lzdGVyLCA2NC1i
aXQgKi8NCiAgICAgY2FzZSBETUFSX0lWQV9SRUc6DQogICAgICAgICBpZiAoc2l6ZSA9PSA0KSB7
DQpAQCAtNDg5Miw2ICs0OTM1LDE4IEBAIHN0YXRpYyB2b2lkIHZ0ZF9tZW1fd3JpdGUodm9pZCAq
b3BhcXVlLCBod2FkZHIgYWRkciwNCiAgICAgICAgIHZ0ZF9zZXRfbG9uZyhzLCBhZGRyLCB2YWwp
Ow0KICAgICAgICAgYnJlYWs7DQogDQorICAgIGNhc2UgRE1BUl9QUlNfUkVHOg0KKyAgICAgICAg
YXNzZXJ0KHNpemUgPT0gNCk7DQorICAgICAgICB2dGRfc2V0X2xvbmcocywgYWRkciwgdmFsKTsN
CisgICAgICAgIHZ0ZF9oYW5kbGVfcHJzX3dyaXRlKHMpOw0KKyAgICAgICAgYnJlYWs7DQorDQor
ICAgIGNhc2UgRE1BUl9QRUNUTF9SRUc6DQorICAgICAgICBhc3NlcnQoc2l6ZSA9PSA0KTsNCisg
ICAgICAgIHZ0ZF9zZXRfbG9uZyhzLCBhZGRyLCB2YWwpOw0KKyAgICAgICAgdnRkX2hhbmRsZV9w
ZWN0bF93cml0ZShzKTsNCisgICAgICAgIGJyZWFrOw0KKw0KICAgICBkZWZhdWx0Og0KICAgICAg
ICAgaWYgKHNpemUgPT0gNCkgew0KICAgICAgICAgICAgIHZ0ZF9zZXRfbG9uZyhzLCBhZGRyLCB2
YWwpOw0KQEAgLTU5NTcsNiArNjAxMiwxOCBAQCBzdGF0aWMgdm9pZCB2dGRfaW5pdChJbnRlbElP
TU1VU3RhdGUgKnMpDQogICAgICAqIEludGVycnVwdCByZW1hcHBpbmcgcmVnaXN0ZXJzLg0KICAg
ICAgKi8NCiAgICAgdnRkX2RlZmluZV9xdWFkKHMsIERNQVJfSVJUQV9SRUcsIDAsIDB4ZmZmZmZm
ZmZmZmZmZjgwZlVMTCwgMCk7DQorDQorICAgIC8qIFBhZ2UgcmVxdWVzdCByZWdpc3RlcnMgKi8N
CisgICAgaWYgKHMtPmVjYXAgJiBWVERfRUNBUF9QUlMpIHsNCisgICAgICAgIHZ0ZF9kZWZpbmVf
cXVhZChzLCBETUFSX1BRSF9SRUcsIDAsIDB4N2ZmZTBVTEwsIDApOw0KKyAgICAgICAgdnRkX2Rl
ZmluZV9xdWFkKHMsIERNQVJfUFFUX1JFRywgMCwgMHg3ZmZlMFVMTCwgMCk7DQorICAgICAgICB2
dGRfZGVmaW5lX3F1YWQocywgRE1BUl9QUUFfUkVHLCAwLCAweGZmZmZmZmZmZmZmZmYwMDdVTEws
IDApOw0KKyAgICAgICAgdnRkX2RlZmluZV9sb25nKHMsIERNQVJfUFJTX1JFRywgMCwgMCwgMHgz
VUwpOw0KKyAgICAgICAgdnRkX2RlZmluZV9sb25nKHMsIERNQVJfUEVDVExfUkVHLCAwLCAweDgw
MDAwMDAwVUwsIDApOw0KKyAgICAgICAgdnRkX2RlZmluZV9sb25nKHMsIERNQVJfUEVEQVRBX1JF
RywgMCwgMHhmZmZmVUwsIDApOw0KKyAgICAgICAgdnRkX2RlZmluZV9sb25nKHMsIERNQVJfUEVB
RERSX1JFRywgMCwgMHhmZmZmZmZmY1VMLCAwKTsNCisgICAgICAgIHZ0ZF9kZWZpbmVfbG9uZyhz
LCBETUFSX1BFVUFERFJfUkVHLCAwLCAweGZmZmZmZmZmVUwsIDApOw0KKyAgICB9DQogfQ0KIA0K
IC8qIFNob3VsZCBub3QgcmVzZXQgYWRkcmVzc19zcGFjZXMgd2hlbiByZXNldCBiZWNhdXNlIGRl
dmljZXMgd2lsbCBzdGlsbCB1c2UNCi0tIA0KMi40NS4xDQo=

