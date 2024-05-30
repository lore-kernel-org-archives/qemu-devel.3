Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7472DC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqP-00074q-03; Thu, 30 May 2024 08:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqO-000741-6M
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:20 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqJ-0006BP-Pj
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071915; x=1748607915;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ikwo6pFWmWJPmsLVz9EZY1puQ3UYZOPOUaqaZRcgXFs=;
 b=J9rd3n4f4yl3AHmfHsnlu1ilvV4G73XpXve9R5HmQ9IGjwUC1j9z9Yog
 lGrd/HTN9Ot8mKfEqGOthtzsqThz0vZdTdEuX5P57N6lSW6XtTm4N1qwZ
 M7NX9SOEzoieIBEs5Q0tfp8yHIUAZmrNEkyhSSL020G6t1lPeUm0InnSO
 N8o7U4mvp1xNLOhakMrVHv14bUIyic6bKnTxuSCCXbxdk/bQOi/J2yUSo
 A+r9x2X+IUXiXD5o6hOIzobI6iiK+XSkUUOn1jlMvtOLgqIFD8KdK1Yl4
 LPHfhGfgGKfYxzlcz6ARNzAGCnprBWCz+eh7+1aPWysugMRr5yOwcKPB6 g==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13582415"
X-MGA-submission: =?us-ascii?q?MDFrA/4WdAcxka9Ck3g9hbqn24B5MJmBdxxT0U?=
 =?us-ascii?q?nmCl2DqIzzIaFCFd8dz9w5FzFuqq85LmCaPuIy7rs+pPXJPn3oFIgDbg?=
 =?us-ascii?q?eqtO4NX9CAi9i/GAx+QeGT0hARs/bTYugy2SFOADXBy4jEIOC5Ag6wNd?=
 =?us-ascii?q?Dl3lAjX/m20eYhEs7dui/nMA=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO+yYRY2wjT07uuZ4DcND3xbH+HyHi32pJgezq2HA2migPN1RSEubW1krDhVjD8qa45SbgQU3QYS6BcZ/GhxKGHI2gBPt4YV5wO8qqnBQjqO1W4b9544Ql+yRUuh3xvbuCAix58Q3XTvr5n1hLjGIzfewp6uZwArBa5gUjbgJEz5TY9MbGM9dQzC/go1EumzmRS+IOZ5jQaSrsSiSvOgNpmq/RCcU8oO4pqNBwbaT93Pn3pAPP3h5eFAwiotYsxFEb06Fd0MLevB7lpl8XmYDqEIXQExdno/NnEylkTJmfB/8xTTxnTr0aMEiiVGN0uU2hNj4j4hMLuAu3CIZr4e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikwo6pFWmWJPmsLVz9EZY1puQ3UYZOPOUaqaZRcgXFs=;
 b=l4q07WNHszBRHENwJpB9Vji4lFhloUEzJ3s/DWzmnp0aXzMjaSuXZfSnUa1/cvsGhvnsPrMO0Z/4YFyql5HxGHFWSJS2hjCgxDpKTz7fiKsGGQ9OBXkXx56YWnQp4MG7m8KcFX0/mu0d0ncwjCnIE2u0qXBtxsDmv30esukq3TvK08Tvvqg5qPzaVZLrHUSEDWFmdI2AZrKaGCnhgpDj0UJP+PUwhsGIg/DXIZJlwln8HUhdfaktcVEKfAUb3Ji8JoQHgjmckDkwqDjTZXmCY0Ujj5nUbqFs+qxV3vufEeFH1OrRYGi+rY0WIp1xp+0HM2EnihINdgrcA9rp9dLbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:25:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:25:02 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 4/8] pci: declare structures and IOMMU operation for PRI
Thread-Topic: [PATCH v1 4/8] pci: declare structures and IOMMU operation for
 PRI
Thread-Index: AQHasoxlVf0NBxjHCEirwX3kIlKGLA==
Date: Thu, 30 May 2024 12:25:02 +0000
Message-ID: <20240530122439.42888-5-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 7315b40e-060a-47c3-68a6-08dc80a387aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZzQ3ajdDTTZlL0Y2d29KZTVSc3Y4TjNablBLektMMGduL0VMOEU1UGZmQmJz?=
 =?utf-8?B?K3ZtQ1lPeHZjUWdVb0lwRFp2TVp6MFR1NVBlSkYrTDhHaXpTNUNQWml4S3hD?=
 =?utf-8?B?dXQ3dSs5N2JxaEZJMWs0WlA5ck4wMTdRdlRnay9KQlU5VkpRT2RqOEs0VUxw?=
 =?utf-8?B?eUVKT0lLSjdtazBBLyt3SzRJMlMvcXl2N3NQd0tVc1BQd3RnZHhTMDUrY3k1?=
 =?utf-8?B?LzRET2dvbzRDbnQwcjZNaE92czdpc0pIeGxTc1NJaEpaM1AwQWRXL3B6cmly?=
 =?utf-8?B?Nm9oVzh0clZCOXBtWEhoL0F1dittLzVBcVgzTW9OWW9ZbTZMY0drS0U5K1NY?=
 =?utf-8?B?SmNFS3d2aUM3eTNCSzBGM1pyR1Q3ZnZKYkFGWlJlZjJERkEwVmJxaGtzbm1i?=
 =?utf-8?B?dTQzeU1DbWlJT1Rnb1NOUFhjZDYzSGdKTG9GdlZNMzRIM05NdXF5QXR1bXZi?=
 =?utf-8?B?SDllNnd3ZHJuY1lMT3hqcmF4UFhXeHFCYXJWOEdQaXk0OTV3bFc2SzhhMjhB?=
 =?utf-8?B?dTFZK1B4c05tYWZyOVQ4TCs4S3dCWDZ4WW5YNFpCTDhEMktCdG9zU3hNUkY2?=
 =?utf-8?B?Q0p1K1F2Sm5VbWhGOTZVS3Rtbkwvb254UUtoSTFHSStmdW1pVzB6MWxpZmJh?=
 =?utf-8?B?RndHOE9qR3VkU2xqdjZVN25GVnJCbHh3RDhiNDUxblpVdDdRMkkramk1Q2Ux?=
 =?utf-8?B?SVB3OTlDbkJSTE5MOElWck5uTmNHeEFjc09LY3ZkV0cvc2NJNXppN3dFUHFZ?=
 =?utf-8?B?QWdmMC9TVTdnOHMxVVdiL3JjNis3TDRDRm1rK0FBcm1SR1Q4MjRRbkIvdlh4?=
 =?utf-8?B?cmFpQ1Y5Rkw3MjVsL0x0UmtTZVYyS0ZyQjRpYWw5b3VXNkZiejVmblU3R29s?=
 =?utf-8?B?VHpDc2pudFZYZi9USVdOVThrUXUzUEdBclFCQlA5a3VDOVlGWTRuN2Z4RVpT?=
 =?utf-8?B?L0xJUkdaMW9Tc3J3bEVMd1RIbVI0SVZvY0o1dkJCVWRmcDA3ZGNsWldxYWJj?=
 =?utf-8?B?SEd5d0hvWlYybEo2SndWS0dJb0g3SGYzM1RDelJqcUJrOHRpcjdCZ3loZ0V4?=
 =?utf-8?B?K0xKWkxyTStTbjNIcUFZQmNuM1EraDNLZm5BY2o0T1NVaGM0S0ViWVQyS3RR?=
 =?utf-8?B?cW5XTEFiUUY3VW5mSkZlN1hTZk9ZcUh5Rm5rZG5nbmtVYjlBV0oyTE9MRnVR?=
 =?utf-8?B?Y21NamVHcXhGOTVId0M4RGNwZm9WQVM5aHlBNUtiY0IzUklUR3pjbHIzeDRv?=
 =?utf-8?B?ZTQzaTVOemVRY2VnZEdiamcrUERqYVY0OUhxb0dyNVkvWFFSZjJPci9nb3VL?=
 =?utf-8?B?NkxvVnZsMEtrNnhONjV0T2RYU1dUQ1luS3F2YmhOWDBqbUREYlJRdUdjNnZo?=
 =?utf-8?B?S01vbUpmcjczSGdmY2pYbXRvZDc4UkxiRElYa3Vpc1N3ZU5pamZRck1aT1ZW?=
 =?utf-8?B?ekRVZEdTUFZFYnIrd1I4amZaUDNrZ3lqT2NPWTJpbXFYS2dZMTM5TXpJOS9I?=
 =?utf-8?B?MWFESWMvcDRjckNUT2x6WmZDcDAzakFnN2dEaEg2azZ3WnJvTDlQU3Y4VTcx?=
 =?utf-8?B?TXhmOE5qMnAvc0lMR2dBbjhHUFpRNkVWMmszQ2VwMkRHQy8rOTd5OUdpaEVZ?=
 =?utf-8?B?cFJxZ21HNkJtMVlLREF4YXhkT24rcWc2b2xHcjVCY2ZRWVYyMnFFZDZWT3ZB?=
 =?utf-8?B?ZmNqNjFFWFpHWWsxSEc3eVZWQWVvaFFUYnVkTS91bDUzU3cxRTl3dDI5NGxq?=
 =?utf-8?B?N09OZUVEZ09CYVk1eHVIbityTmhWVFhQRW9GaVFmdVpZTnkxMC8zeEh6cEE4?=
 =?utf-8?B?VnlLeU54QlhVdjNtdWF0dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0ZuTjM5a0J5NmtoSVBuZ2FTS0taNlRlMlVyRzdMQisvTVNQZ2N3dUJuL2Zx?=
 =?utf-8?B?OWhETldzdjlHRUxEUXArZWpPcEVMeUt2NTNtUW5IYU1XRlVyQ2xnR2JBZWVy?=
 =?utf-8?B?K0d6bDdJNFl2aTJabGRENkpNYWJ5QzB0YWovMG4xTDFhWVB2UVliMEs2enJH?=
 =?utf-8?B?bjNqeGR4OWJUaXVyM1NNeW1mTzVCYllHaERXMXhQL1dVYlRncXMrN004WXM1?=
 =?utf-8?B?NmJ3bFIvZElIbmVEMzFDWTErZUxCUDNOWDdWc2x3WVJMQ3N5SWxMcGROSzRP?=
 =?utf-8?B?OUJONnhLSjRMdkd0U3VXQktybnU5dWxvUHVQMDhiZExPTkwyRnZNR2xRUHBU?=
 =?utf-8?B?VmJ1aXRLOU9jNER3QitYOXhWTW12RUMrMnJYWUpmM2xSYVBVVHR1WkJnMnlG?=
 =?utf-8?B?ZUZQWFRDUXcwRjZhUUNXMXRLMDBqWWhxUW1ibWdNK1pjL1pUMlNmRlk4NzVo?=
 =?utf-8?B?ZDV3OWpabTdEaWM5RWFlNldzMStZVjROT29wMmtXNW4vQW12bHZNU0lXalRE?=
 =?utf-8?B?UEYyWWt3d0N0bUN0ZkVmZVRESTQwTEdwQ0pHUzZuT25mc0xXZU1xT01UMXV5?=
 =?utf-8?B?MVp2RTdjWVBPbGdvbCszdExrV2IxWTlwWjdZRzJoUFQwUTFuR1FwVkNNSEF0?=
 =?utf-8?B?NXQzV09naEh0TTd3a3NrRmRYZW9kbUlVQkZTalhZakdHZExLdzY3ZUQ0MWFV?=
 =?utf-8?B?Q0xIY3Jtb3JZMlowTWhvVGdSNGZ6WlhpUDBnVnNLMFZ6blZQQmR0SWNmeVpC?=
 =?utf-8?B?b2lGT2YwV1A3R0U3bmhiN044M0pBc0xSQnNUa200QytMRjd4bDJQTmZSUGlG?=
 =?utf-8?B?Z2RDN1cvRHlrRy9RQnRTNVQ3b1lsRGtvRVIzUUpGeTFQS2h2dDYyQWJZRzdB?=
 =?utf-8?B?TVpma2NIZjd2S3Q1b0RPTTF5M2NhYVNubVdGbUsxNk5ROGhOZ25zVEs0bGFv?=
 =?utf-8?B?RnFqUFB4VzBPUzl1emtJd1lEWFFWWC9qY2pZYmNVeStCYXNFZ1BmeWFkcVJU?=
 =?utf-8?B?VzZNSXJqTCtpTEJjM08veEhpME83UWdWUFBOL3BOMWQxK1JEVHNhYnBhRThM?=
 =?utf-8?B?VEFMeHZCWDBsb1lnZWhTNXZ0bGpRdmlGNHl5eGpSOUVzQXRXTmxiblVxcW9u?=
 =?utf-8?B?SWZac24ybEFMSjZXeW1zWTNiTSsrNnBMOEFRM3FEMUtUcmExK1RWcENVLzdm?=
 =?utf-8?B?RzRGV2Z5S3FuYVdJVGRXVVMzc3lRZjhFRmxRMDFXLzlFNXdJVFh3S0kvM1NP?=
 =?utf-8?B?eXlJTzhVZkhQc0o5RWh0Zk9DdUg5TVlpNFZSQ3pTUFUybTB4REptTE1ZQzVE?=
 =?utf-8?B?c24wRUJ3Y2Jxcms3ajlrY3A5TjRaWHd3ZjFHYmRrQmswcFFaVVpTRXNlVDlC?=
 =?utf-8?B?VnJmeFlhZkVxV2ZZMllJMVdQMktQaUdmckM2M0x5SUxrSFFtOTV6bmFnYldi?=
 =?utf-8?B?aytJV2tOOWdpcmJ3NWlhNWdkb21rdDBwOWRoOVcwSXJKQk96N2p2RXRSc0Y4?=
 =?utf-8?B?Tk9nUUJMSUtSMTgzenV3NWYxdnNiRWVaTUN3R013MjYyVTVvUnVWYmhTWWdm?=
 =?utf-8?B?OGowdjRtZWxQd3NhQlNxVFdWZ0ZNUEh3WW1tZ1VORW5mN25lbU9rVkhjZWJP?=
 =?utf-8?B?WVV4SW5jRllScmkyRStxUkVab2l6QzdrbFdVS0djbU5xNEc1bHlEb1FEblJV?=
 =?utf-8?B?MDJxR3RPRnpEOHVWc3ZZRmFQRk52UTJHalBqamVQVTRqTTdzUUw0VjV5ck5T?=
 =?utf-8?B?aFhvN3FtVWc3THFDdXpMSzhHdlJSYnBYdU9xc3YvcitIL1JuQiszNStRSEp6?=
 =?utf-8?B?K2pKZncybG1VNStzZm5hd3UzcytxdXdhU3hrR295Q0diVzhSZXU5c0U0N29t?=
 =?utf-8?B?OWc1OFdwRm4yWmNELzh3dHBZcW12MHlacWJUelNVbCtZSVBXNUFxWS96MmVE?=
 =?utf-8?B?R0RNTkg5dDQ1dExIZWkyNzU0N1BsNG13Rk9xOVZ3L2haRnFUNXFNamRmTTRm?=
 =?utf-8?B?VXMwVFQ2WnMwTTVac2t4M1ByZ1FkMjhwTzB5Umdhc0hUYXVlc1hudlF6K3dS?=
 =?utf-8?B?cmV3bGIxYW9TSStUV2RlQldZVTl1elNqSFQ1TUNqYlFHZHg2c0Zjb3NmTUIz?=
 =?utf-8?B?MHVVYVhxSlNvVHhzZ25BTlhVUzBmTDA3L0NIelRnd0xHNk5ZMzdtRzBtaDRt?=
 =?utf-8?Q?yTGvBvn9PnhfDYk7hh+W/nE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12F47AA919D68C4A975B8AC8ED64B813@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7315b40e-060a-47c3-68a6-08dc80a387aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:25:02.3514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sKdgkHIq/Oj2xnmZGZhvAZ4BhvFWJ/FrfloMWA/BRjnYjd/9a8rPu36VFZz2+axHSN6RWnEprH5xdXrGKykIW8YmNf/Gdz4zIJYh8fNuj5/xhh450F9zivum8ztnrE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

VGhlIEFQSSBkZWxpYmVyYXRlbHkgZGVzaWduZWQgdG8gYmUgc2ltaWxhciB0byB0aGUgQVRTIG9u
ZS4NCldlIGRlZmluZSBhIHN0cnVjdCB0aGF0IHN0b3JlcyBhIGZ1bmN0aW9uIHBvaW50ZXIgdG8g
dGhlIGRldmljZSdzIGNhbGxiYWNrLg0KUmVnaXN0ZXJpbmcgYW5kIHVucmVnaXN0ZXJpbmcgYSBu
b3RpZmllciBpcyBkb25lIHVzaW5nIGEgcGFpciBvZiBmdW5jdGlvbnMNCnRoYXQgd2lsbCBiZSBh
ZGRlZCBpbiBhIGZ1dHVyZSBjb21taXQgb2YgdGhpcyBzZXJpZXMuDQoNCkFuIElPTU1VIGNhbiBz
dXBwb3J0IFBSSSBieSBpbXBsZW1lbnRpbmcgdGhlIGlvbW11X3ByaV9yZXF1ZXN0X3BhZ2UNCm9w
ZXJhdGlvbiBkZWNsYXJlZCBpbiBJT01NVU1lbW9yeVJlZ2lvbkNsYXNzLg0KDQpTaWduZWQtb2Zm
LWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVu
LmNvbT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCAgICB8IDMwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaV9idXMuaCB8ICAxICsNCiAyIGZp
bGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhl
Yy9tZW1vcnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KaW5kZXggMGNlZDdjMzNiMS4uZjQ3
ODBkMzkyMCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KKysrIGIvaW5jbHVk
ZS9leGVjL21lbW9yeS5oDQpAQCAtMjE4LDYgKzIxOCwyNSBAQCB0eXBlZGVmIHN0cnVjdCBJT01N
VVRMQkV2ZW50IHsNCiAgICAgSU9NTVVUTEJFbnRyeSBlbnRyeTsNCiB9IElPTU1VVExCRXZlbnQ7
DQogDQorLyogUGFnZSBSZXF1ZXN0IEludGVyZmFjZSAqLw0KKyNkZWZpbmUgSU9NTVVfUFJJX1JF
U1BfQ09ERV9TVUNDRVNTKHZhbCkgICAgICAgICAgICAoISh2YWwpKQ0KKyNkZWZpbmUgSU9NTVVf
UFJJX1JFU1BfQ09ERV9JTlZBTElEX1JFUVVFU1QodmFsKSAgICAoKHZhbCkgPT0gMHgxdSkNCisj
ZGVmaW5lIElPTU1VX1BSSV9SRVNQX0NPREVfRkFJTFVSRSh2YWwpICAgICAgICAgICAgKCh2YWwp
ICYgMHhldSkNCisNCit0eXBlZGVmIHN0cnVjdCBJT01NVVBSSVJlc3BvbnNlIHsNCisgICAgdWlu
dDhfdCByZXNwb25zZV9jb2RlOw0KKyAgICB1aW50MTZfdCBwcmdpOw0KK30gSU9NTVVQUklSZXNw
b25zZTsNCisNCitzdHJ1Y3QgSU9NTVVQUklOb3RpZmllcjsNCisNCit0eXBlZGVmIHZvaWQgKCpJ
T01NVVBSSU5vdGlmeSkoc3RydWN0IElPTU1VUFJJTm90aWZpZXIgKm5vdGlmaWVyLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVVBSSVJlc3BvbnNlICpyZXNwb25zZSk7DQor
DQordHlwZWRlZiBzdHJ1Y3QgSU9NTVVQUklOb3RpZmllciB7DQorICAgIElPTU1VUFJJTm90aWZ5
IG5vdGlmeTsNCit9IElPTU1VUFJJTm90aWZpZXI7DQorDQogLyogUkFNIGlzIHByZS1hbGxvY2F0
ZWQgYW5kIHBhc3NlZCBpbnRvIHFlbXVfcmFtX2FsbG9jX2Zyb21fcHRyICovDQogI2RlZmluZSBS
QU1fUFJFQUxMT0MgICAoMSA8PCAwKQ0KIA0KQEAgLTU4OSw2ICs2MDgsMTYgQEAgc3RydWN0IElP
TU1VTWVtb3J5UmVnaW9uQ2xhc3Mgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIElPTU1VVExCRW50cnkgKnJlc3VsdCwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgcmVzdWx0X2xlbmd0aCwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZXJyX2NvdW50
KTsNCisNCisgICAgLyoqDQorICAgICAqIEBpb21tdV9wcmlfcmVxdWVzdF9wYWdlOg0KKyAgICAg
KiBUaGlzIG1ldGhvZCBtdXN0IGJlIGltcGxlbWVudGVkIGlmIHRoZSBJT01NVSBoYXMgUFJJIGVu
YWJsZWQNCisgICAgICoNCisgICAgICogQHNlZSBwY2lfcHJpX3JlcXVlc3RfcGFnZV9wYXNpZA0K
KyAgICAgKi8NCisgICAgaW50ICgqaW9tbXVfcHJpX3JlcXVlc3RfcGFnZSkoSU9NTVVNZW1vcnlS
ZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBscGlnLCB1aW50MTZfdCBwcmdpLCBib29sIGlzX3JlYWQsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaXNfd3JpdGUsIGJvb2wgZXhlY19yZXEsIGJv
b2wgcHJpdl9yZXEpOw0KIH07DQogDQogdHlwZWRlZiBzdHJ1Y3QgUmFtRGlzY2FyZExpc3RlbmVy
IFJhbURpc2NhcmRMaXN0ZW5lcjsNCkBAIC04NzgsNiArOTA3LDcgQEAgc3RydWN0IElPTU1VTWVt
b3J5UmVnaW9uIHsNCiANCiAgICAgUUxJU1RfSEVBRCgsIElPTU1VTm90aWZpZXIpIGlvbW11X25v
dGlmeTsNCiAgICAgSU9NTVVOb3RpZmllckZsYWcgaW9tbXVfbm90aWZ5X2ZsYWdzOw0KKyAgICBJ
T01NVVBSSU5vdGlmaWVyICpwcmlfbm90aWZpZXI7DQogfTsNCiANCiAjZGVmaW5lIElPTU1VX05P
VElGSUVSX0ZPUkVBQ0gobiwgbXIpIFwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2lf
YnVzLmggYi9pbmNsdWRlL2h3L3BjaS9wY2lfYnVzLmgNCmluZGV4IDIyNjEzMTI1NDYuLmVhYTc3
N2ZkZTQgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2lfYnVzLmgNCisrKyBiL2luY2x1
ZGUvaHcvcGNpL3BjaV9idXMuaA0KQEAgLTI5LDYgKzI5LDcgQEAgZW51bSBQQ0lCdXNGbGFncyB7
DQogfTsNCiANCiAjZGVmaW5lIFBDSV9OT19QQVNJRCBVSU5UMzJfTUFYDQorI2RlZmluZSBQQ0lf
UFJJX1BSR0lfTUFTSyAweDFmZlUNCiANCiBzdHJ1Y3QgUENJQnVzIHsNCiAgICAgQnVzU3RhdGUg
cWJ1czsNCi0tIA0KMi40NS4xDQo=

