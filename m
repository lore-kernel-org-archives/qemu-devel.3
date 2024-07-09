Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38D3C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBnX-0006YT-Fv; Tue, 09 Jul 2024 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnU-0006Oc-TA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:24 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnK-0002k2-Sa
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720535174; x=1752071174;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=u/EE/MVYvmwVs8wPu6Il6DxMESvsWjmJtHWqiv7M++c=;
 b=N/EcZmLnBcOw9yih7fFjMi/rR+JKAtIvQ/Orqzy6vmrKe0mPMrI3ieFQ
 iwGUJS1D7s2hfGpwYRp1KVv9/xH6naz6JSF8tSMOipijQ3EQJ1Ta8dNOb
 RB5urfsdv/dTRhdWMz9JWIA0FoVGLBIDpmcZzEca3zgskYvAGJWdX1kN3
 CWJKmdpTyviUY8w/AaD4s5XTaM7r/4psJ5rGY/0duaMGJHAp2+l5+2afr
 uZ5HcgFvzYfT/D0+QK/p89HmQavFHzC+5jZc/nkfGgwiQr7IKtv/10Wxp
 n+0yNwkWxfOiq21+50NCz/vvrn4aD6f89/6PbabwR9Ku3enHzKLBdzLha A==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172660"
X-MGA-submission: =?us-ascii?q?MDHt0OLFiCuR5mDp0hqv4unM60BKCx6Zkpx3uj?=
 =?us-ascii?q?wDxYt4jv7MdtL3iqfM40u65+U6S5znVKG8A0QjNIz7moXoQGLlqEwXS0?=
 =?us-ascii?q?fo6ZMu172eXveKUkG6/GBIbaBWCIDjwRZfPhiFBBTzkf/8EGRsi2Zvjh?=
 =?us-ascii?q?GtguA202oPCAFdPgD0dZHNRg=3D=3D?=
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:26:10 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unJKgZlBnJStIE9vUAkIBR+S10KOjg4bC3CYdX9JbaRj9RPYy39NUFa7stdL9j9OrILV2mgJ5Maon9cavmbrTUa0NGB37BJMf9VAWBXYUM/Pb9oEo7jKg9ahq3+S2J8w1PiQ77vjgoeeAVINSlGOwmHXCFCGVThL0L1geb+oUJgtKBlVkeNyISAitV6hExHEiLW6rcx1rMgJHAx1WNNQrDKiX26iZr4SVBvWicOxc5sdt5/GLAVMmRBUfZ9KyPvrIh0CijSfKbdkYseomSEPTR5p9TjLOUliUjdJTw/z6RzOsdozolMDGlws3icT+Gz+LFXQ5WMt2J35dV0KXuv53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/EE/MVYvmwVs8wPu6Il6DxMESvsWjmJtHWqiv7M++c=;
 b=ILNEjZaTFB4/QtXmSZUP4sudjbF4VW+3zWSbP4yibaxYW2hRLCcEuaAfdUGjHANlEd09kvSgiWNdS3t1GuFdPx5IorVLCpcaYS49AzC+MlIsbU86sUYO4PyWFjC/uUBu8xu1kw1Dxrym/jqukckOPjICKYYR8GCUGEwdpYc7WaG1Zmv8CmqbWlREMyc4JOxtLwW/y8HlNLjVx7pm+4EJvpnE8H0RhAsI7jLszh2Ubhy3KLp4t4Eg1AUGJ7Ob04VcolAV996xb/FDKR5c2k6fwPIOpTkIV9GBSWWo8ABukNgblaU8ytYuMPDQBxuP+QhPPFfKEGPo8OfQxoXADSVDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/EE/MVYvmwVs8wPu6Il6DxMESvsWjmJtHWqiv7M++c=;
 b=nF6hQMx4rNXBVc35IfJ/GCtEOKH052nF1Aaoblf6r3UdZ/h4aq5NrESb4K42EjU+Mw8COiqjIOp3Opt50QN8wK2iOkR8fDcODhcphlbw4vDWyw2y3scoJs+dHxPeOf5a/PtzfQ5AuLZSpHY/tfnEAw3zfhEl7K1eW2gyOgxGFE/7tl+znOxHFq/nsQ9quEXmtqpRXYogTTJzqId95wv6NdAiW3lFc7rcFlrpkryhswic49rccjY+Fdiet7wa7GC75i7mBLfWY/jxgkOMOIJ3qIkY6yl37HZHS0hDfDsmiiUyvmdXr3VV5kBYwGnmVKJBb0nTCDI2AygFEJLoqvvxCA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:26:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:26:08 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v7 1/4] intel_iommu: fix FRCD construction macro
Thread-Topic: [PATCH v7 1/4] intel_iommu: fix FRCD construction macro
Thread-Index: AQHa0gvwQEBSmTxjMESb+vD3l1do3A==
Date: Tue, 9 Jul 2024 14:26:08 +0000
Message-ID: <20240709142557.317271-2-clement.mathieu--drif@eviden.com>
References: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: 1ca57ec1-763c-44bb-e619-08dca023133d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vk1mc2U5bjNRZ2dKMkgvUnBTOEltS2JsT2RzRzdvOVNpL2ZLSnQzNlJRemNm?=
 =?utf-8?B?ejlmK2VLVU9uVjdFOFZLK1hVa3NZc3JaVnhVMlp6YnF1NE5obzlSNHRXbGxH?=
 =?utf-8?B?Zi9ycXRWWmUxVExUcStPZ3NwQzR1L1hPdzZ1djVDS2VBcnhWeVFoVEt2NVFJ?=
 =?utf-8?B?QzdGdEQ0b1ZZcWVDSnNYWmIwY0x3YzZ4eDVKdmhZRzM0N0FUTmFHdGxTbW1Y?=
 =?utf-8?B?UXdlbDUxV3FjSjVISDBHMUE3L3pOa0xZWTgzamZ4a0VOQzUrc1hpODBiMjhQ?=
 =?utf-8?B?d3M0bjZabDV2L0hyb3VHbmw1bGgxMEY0RmlkUFJJcS90SHQvTGxjZTJDOCtH?=
 =?utf-8?B?Uk1MYm9tOTBLaXZvVE1uaExEWExQRU5Ic0tGTFFGTGR6QUZLbWVpcDhORGdJ?=
 =?utf-8?B?U2owY25ZN2o5ekhDdWFtWVdwbjU5Q0E2VExRQWU3bHYzUTZXWkp4M1YrOU15?=
 =?utf-8?B?OXYvbGNZOVgxUVMrR0ZFRnJ4V2ZrMlZpdlZKUy9kdHBmWHhHbmx1VnJLWHlm?=
 =?utf-8?B?QTJvNGtUZnZ4eDViQ2pDWkpOTWpCSk11Q1F2aGJIUC9PemNtanFJSWVTS2xB?=
 =?utf-8?B?K3ZZZzVFOTIzaDhqcUVKZkZkSVluSWtRTm5WdFJiSVFmRHBnclRmV1orSCtk?=
 =?utf-8?B?Y2xVUGJFSVBMSHdpREY3d3hYNUVwMkZQWDVzaDZCTDFHenkvcTBQUkQ3cHV3?=
 =?utf-8?B?SUFHVC93b3o5NzhsL3g5TlhsUlU0czBjd2thWlpRMWlXdVdTQ1FRVmNRQncv?=
 =?utf-8?B?YllXQVNrWmx6M3hVQ1RUUFQxSnVrVitzQmtEZ3BWbjVWbjU2bmhUdUgzOTlu?=
 =?utf-8?B?NDkwY2dLRERBaktNZmorR1RCcXNBM1V0cS9DRWw3MHdNSDd5UHZYWWQ4UXgx?=
 =?utf-8?B?YU9aZU1NYnQ2SXJEeURNSGVNV1l0WnVKRXF6aHZnbjRPQkh1d0thNm9pY25l?=
 =?utf-8?B?eUZNNGVURXhQS3NDeXlPMExxekJnNFZodURKRWdMWXRhRVRCckxvVWNmQjhT?=
 =?utf-8?B?c21EZ0EyMHZ6MERrSUcvdjNuN2pFVlN3WXVJWUVFZlpTWmgxamhWTFBWMTls?=
 =?utf-8?B?ZDFHK2hHZTlhOWlBTldxNE1jSUFhb2JhN1lxWEVsYzVYOGNON3hHTVFMaDl0?=
 =?utf-8?B?bW1ob3NxYlNsNDVhU1ZDaExrWkkxSEFZa2ZQV25hTi93UDkzL3I2VHY3RzlS?=
 =?utf-8?B?bkpIbTlBaEtmdFVieG5rWGtjb3BxTlY0WFVsWmMvcEQ1Y0EzS0JRalVmNzFi?=
 =?utf-8?B?WEpSVFBHSmNPb3JTamRDQnNFc1RtSlMzbTNsWHlxdFZtcUhNdTJ0YWFqdVlY?=
 =?utf-8?B?VkRFN0E2a0x0M2s2WjJuMmxyWEs3MkFPa2tLWWYrc0JDbFhReENzL0I3RnNo?=
 =?utf-8?B?NnZsc2dINFpSdlBEbStKRjRZZTM0MnR4dmZ0Mmk4MHBBOWt1Q1l2eGdGRWFS?=
 =?utf-8?B?QnFzOVhvSGpqOVo5aFBxMWNqZnc1VkZ5THZBMHNTamlYZFAzSW41WmRLZkcr?=
 =?utf-8?B?Q2k0WWJIV28vM29VZ3RaZjNJbTlJQ0ZvK2FwUk1VS2s2bVZjeEFtYVFDa1dE?=
 =?utf-8?B?ZUJNYnIxLzY2NDh2TGR2RS96SktqMk9pYnNaWmttMGlteDZtNEM2K2IwOEJw?=
 =?utf-8?B?dUwyeUxkK3A4OEd1N0JCV2sxU2lNNE1adTFCbld6VVdGTmcvQTBJS2FDYTJI?=
 =?utf-8?B?L091MVhEc2EzM3MwYndyZE11WWY2Rzc0TzJKQTJkTGt1US90L0xnZ3R3Y1ps?=
 =?utf-8?B?T3ZmbFpoQjkxNHl5OGhPU3RqeGZ3dVJLNXdQSmMyTDlIZWlkd2xqYXVnSXR0?=
 =?utf-8?B?RlZtUzV1S0o2T1JGbTRBbjZwdHJETTEzOXlqa2FUdmZ4UFlweGl6QnFvM0FJ?=
 =?utf-8?B?T2JyTUhXVU5CWWRDQkVwa1V1akNXdmthT0dqNE8xZGRmTFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDJDT1hCR2piZXlzSUlPRXE4VWVqZ0J2QVhCbXhERVRnYllybXJWSHFFSG03?=
 =?utf-8?B?MEYrZHc4VCtMa2tmc0VmaHZVV29SZ2lCNVR3bHNWV2E1Y0RJSUpZQzJvTDlS?=
 =?utf-8?B?UEJyblhLc2x4K2psdkZHQjZGYTBkKzYzVlozNXB6Rm5YOFZGYnpuNGNPejBp?=
 =?utf-8?B?TXAxTDdCSkpDUW9TamtCN2lEUXkwRzFpd0k2Snc3T1FMQ3dGaGNyZTZkWENM?=
 =?utf-8?B?QXNHTldPdWg0cjVoNG9QTjFvcmFBK29sWE9zVFFlLzhTK2hNWnJqdGwyTGVw?=
 =?utf-8?B?S2FLbzhCVHFsajVWeUg5YlA1OVhMdFFSUlhJT0g2ckw1VzBBMStmL0lGMitM?=
 =?utf-8?B?SGdjOGNEMnNPQ0doem12MEJUOCtVU3ZTeEtGTnEzUTQ5R2hPU0ROb2xHTmRh?=
 =?utf-8?B?UnEwSFFablVvSkF1d0F5Mkc2MHRCSnQwQXhvV2Y0ZUdiZUUxaWlQWU1tNWJU?=
 =?utf-8?B?UWlFeEUyNmVpekVHdXFtZWxiMDkybENrbWVIT1BsMTdwRUkxZXp1ak8vbWg3?=
 =?utf-8?B?a04vNlN5ek5jbFA2YzB5WEIrZTRBZ2pnUUoxY0ZsUjJzQ2hYbUszYlk4aG50?=
 =?utf-8?B?eVp1MHBBWno4Q1M5R2JQLzRGdUgzTm52c2VNeFc5dVVhQm5VeHhNb2Myc2JK?=
 =?utf-8?B?eCtyMDQ5eHN5bzlTVW0zYnhrZzJ1WHB1aW9ManZOZFZwWXp2elhacXJ3Y09S?=
 =?utf-8?B?OTEzcTI0S3hvdEJIcHJ0enBJSWJkR3g0Z2tXdzNTeFBoUTBkMDcvV29EV011?=
 =?utf-8?B?Q3U4MlgyNFZmV1dIUFdwYm13Y05hTXRyQXFvK0pjb25rUWtJeXVMcjR1RGZl?=
 =?utf-8?B?cnpKNks3NlhQSkk0NFZkVWZ5NzdnRndIT1V6OWEwY0h2NjlPSUFHOWZOcTFh?=
 =?utf-8?B?V0l5S1ZEa3F0VkFiTk1qZUYybU5JeVowZFdyQTh6Qi95NUM4YUZ5THd2K3pP?=
 =?utf-8?B?QmdUczVnWWkrTzlxQzcyQ3JxNXNrU2ttSDVtYmJzdGVYbmo3RTZsRDZweHpw?=
 =?utf-8?B?RGp4bHpjTXBuZGhVL284eGkrb3haWW0yZE05OEhsVm9WdzByNnluUzFmSG8v?=
 =?utf-8?B?YURPOTVhRENVcStUMmxob2lzN3hsSTE4ZUtycXlaR0VhSmRXb1VRSzlEYzNF?=
 =?utf-8?B?UTA0SVBLWUtNQ2hhK280bjY2WmtmWGhSNWkxSUlSU2NHaVI0M3RHdi8yWU1x?=
 =?utf-8?B?cnpielZNUWVBczVXZDljSktJaWQ5MmtDdTZYYTVrUHJRQUNwN1VRalgwa2NQ?=
 =?utf-8?B?SWhVdXFxaGlyLzYxNm9CeTVGOUtQVmtOZk5GME9SWEJmYnVMeVZEYTcvcnFI?=
 =?utf-8?B?dnVjR2owaFE1U2E4aUhvQmEzL2ROWmNwTGN4RnZtcVJnL0VCanpLZkZQZ1Fi?=
 =?utf-8?B?MlhLQXlza0RuSmIxUmJlM1VTK3QxdUg3ZDdBYlJOTjl4MVJ3TlV5YmxoZWpK?=
 =?utf-8?B?aHcxV0piTXh0aHp6bFY0VUIyNEdvTWJyMEZkTFUyZXAzSXY1QmxMUFJZZGhO?=
 =?utf-8?B?QWVUMkhQM2Foall3bzJoV2xxQStmMlZCQnBWOGRNZUVUVnhQY2RkZnVpOEE1?=
 =?utf-8?B?Y1Z2UUdJeU8vWlBjcm0wVDdUWnd3U2VLa2d4dDZZU2JmYkZKWjN5dWpzK1RJ?=
 =?utf-8?B?YjErL1pZdWRpMHBteWt5ZWxQa04xbFJyVDg0dEdWenZVc08yQzBkUTgyaXcy?=
 =?utf-8?B?Nlpqb3RRaEtRWHRrMkZJZ0UzZDg5RWFyL24wOGkzUXBJRktkVC8ySDN1eDdK?=
 =?utf-8?B?QUt4WThwbGJ1TFZNSmpYUWt4cUFqaU9qWG05YmF4eFlOcXNUV3YrY0ltSWhm?=
 =?utf-8?B?Z3gzOXY2U0VjR3JsS3d1TXQzdTdaUDdFNU12alAyaHB1UU0yaGczMDBwMWxD?=
 =?utf-8?B?V3lYTVpqTHpKa1U1MDQ4Q3lxQ3Vyd0R4VnRyZWxwMHMxSWJkTWFoTHE5b0lB?=
 =?utf-8?B?MzRnWnMvK1RIYjMxY3lSb2szVTg3RVNhczlCV0FIUDk0VXNmdVU1QWpzZlRm?=
 =?utf-8?B?VHZvWk9DVkpCTjU0Nk5wRkhMUG16V1Q2REJoeC9ERDBDWXBDTnV6bFN5RlZN?=
 =?utf-8?B?WGR2UU0rRjBsSHV3dFNiUXVEUHFTM2RLeWpwZWowYVRVVDFjdzBDUkJlZXha?=
 =?utf-8?B?c1UyclhNUm03NVhXamxYZ0lMb20yRlV1NHBsemNaN2wyMnlYQTd4OVdIMXVm?=
 =?utf-8?Q?wvIaC32gu7F8Xn0NqIf2Qx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D964A93EBBBA2C4485A13E254120C678@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca57ec1-763c-44bb-e619-08dca023133d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:26:08.6339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2RUq1romSoXg1RSkFbm838rFvVAlUGCaB5TTzF3pYmz5zwPsDvpSR91Xdnsm8Rr1OkTTnnUvgFlqShScthTpYIdcjz9auXijY4bviiOriSfoWbJHjTy6k1/pYi9jerL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50Lg0KDQpGaXhlczogMWIyYjEyMzc2YzhhICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1
cHBvcnQiKQ0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQpSZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NClJldmlld2VkLWJ5OiBNaW53b28gSW0gPG1pbndvby5pbUBzYW1zdW5nLmNvbT4N
Ci0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KaW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAzMSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
DQpAQCAtMjY3LDcgKzI2Nyw3IEBADQogLyogRm9yIHRoZSBsb3cgNjQtYml0IG9mIDEyOC1iaXQg
Ki8NCiAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4weGZmZlVMTCkN
CiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZmZmZVTEwpIDw8
IDQwKQ0KLSNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAmIDB4MSkgPDwg
MzEpDQorI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwpICYgMHgxVUxMKSA8
PCAzMSkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkgJiAweGZmZmZV
TEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9ucyAqLw0KLS0g
DQoyLjQ1LjINCg==

