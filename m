Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62151C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPO8n-0005Wq-50; Thu, 04 Jul 2024 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8k-0005WK-2G
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:12:54 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPO8i-0002sY-2x
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720105972; x=1751641972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iKgWTW73+sONWU+F9uuFcnPrFDqHO//Sx1zKx7/KBTY=;
 b=tDZeUX58b0BDrYyiqA5c2CBFCizDZnVX1yCQ2hD5VOWt/Ejgdn+peulZ
 yi3dSKeVlwy1tE4glxh8OGt0rQj9vChf5+P9PjgQ4OamF87qlmNfZiEA3
 odAVTaE69/PCRAdYPaLP9BPl86cZ7kBx5W9w2bQJecOi82ft1DbX5MdYR
 laB37bOnwu7BQyyy0Kdun9i8HqQm4cxFbB569W3RP61ljUdV5Q1wSyRaN
 ueggQWduB8D82tHcfBXpc3B4xjC5aO2kSg1kk0mOliAZn9lk7j0JOIv0J
 5EcR8VVPX6ymzfNYII+EW+ib8g49wyEu9aY3bjZNlQUQGMj5kmeibg/fG w==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="16007268"
X-MGA-submission: =?us-ascii?q?MDEs5hfOVmg/sN6QarBZfts0n2pZf+VekM9Y9e?=
 =?us-ascii?q?8/NlAHkLuGPXnBULwfU+bcaPkoiH4jYPbpyZYYh4NZlDrwX9btEBQa7+?=
 =?us-ascii?q?P5QEMz8FDsRErx6YNjU6IyNOK+IafgQobMg2nT0PDDJM/sCJ0pYcIeBp?=
 =?us-ascii?q?mqAGU3hV4S3cwogCRSXs3Weg=3D=3D?=
Received: from mail-am0eur02lp2238.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.238])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 17:12:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGS4DIUuDbvni+yF5gyWhVeLAJjU23GSoXnc+8lvn3iGNQNVaL2hQaGidr/fclqHNxps1ncQm7tF4wgpiJanO5gQDhenVwBGU8l2ezGtv2GpsyQPwOyie3rHrX73E2vVWfI28fNqEIfyu7BTZ5qAegqXQqiTa5rpXH+V4rJ/USFXLpxjOXHywReMwP9/ryShPBMgG4D/rsG8qrePpZ8GMQ8c+tSTLpNTZEzFX0rDGSYqzKR+Js+9to7C5LiLM0E8Oj/VC037OPJyeWyy5D2fs3glEW8mPIbEhAbm3we3ZL0vB4RLBK8wVhp4lpBsBw+/u3G8Nfv0BLIIDPndpkPWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKgWTW73+sONWU+F9uuFcnPrFDqHO//Sx1zKx7/KBTY=;
 b=VeYBxCdaLdeLkDzWnhtaMW72JtoRHAsJrFOQ/4Nw5+RVJf/6cs6b79g1crKkIV7TQaSkerwgiU76DUfUDwdW2iQjrt2sKru/CsDrBitfIFQgdHnuUQ4qJCqqlGi+qpxhJBwV89IHpGmmxKBe//PI4kbfQvJl3bW8zhaoqALYyRRHhJLSrueXgliwJCe0LEY7dBmK3nJLBzq/XjUK71p67nIg5oZVhAiM90gXUcPx6txFViMZ81OCdEZW38zFPxR+vERsz35yzfBdu7aMJd8UIHasd+BeIYSHeDgSqfp/bdxG9yPsOJRLlaIU6ttw3haohEHn57UOlQP6JJAzzWipQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKgWTW73+sONWU+F9uuFcnPrFDqHO//Sx1zKx7/KBTY=;
 b=BQtAew+PcHHXjwpYwdsahY5VWwSxEg+shu5hLVZrDht2GCvKeN8rLNLJBc0fWyiT/Mh4dbk+rJYbc/evtYIl3i3dr2Q4y+xDfAsi77Dc+awNMgYeJWK2hdwF2Hkx1BRYZ5DwYYF2uwViFHGbnn2PJHCg1kwO5JSzxDVKlXWpuwwGbaiGCzjV1+CGONnlcrqJw23yC4B+DDY4FvPaJ92s50a4VxyKq7U5zOYCRjxgLdNq6lv7HaIk/Nm8reNhiWdCgNTWhnzq936nZBPFuemhum7sHr7wi9dVE6h0s/IcUCnL1NTL85k/8FH+6ZrWh17mRpzwUKyEAZmb1P42umVhLg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6455.eurprd07.prod.outlook.com (2603:10a6:20b:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.8; Thu, 4 Jul
 2024 15:12:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:12:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v2 1/3] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH  v2 1/3] intel_iommu: fix FRCD construction macro.
Thread-Index: AQHaziShz6ld2iURc0GxUCRF+M342w==
Date: Thu, 4 Jul 2024 15:12:47 +0000
Message-ID: <20240704151220.1018104-2-clement.mathieu--drif@eviden.com>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6455:EE_
x-ms-office365-filtering-correlation-id: 900d6382-f470-4033-33d4-08dc9c3bc3a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MG9iOWhsOU42R3FFdURmUk1xR2JDbEJSWDl5TzJiMThHVy9LUXQzQnU2aUta?=
 =?utf-8?B?ckRqQWtLOUY4UnIrRFBBdDVTOU1xWUNyVFhDZnBpZ21FNmdaMCt1d21ObTFB?=
 =?utf-8?B?cDB0d0RLbjB4cjdHQ3NkSmpTQWxDTEU5R29VMVYzdTJDcTFjTmdIWHdaTWFz?=
 =?utf-8?B?cCt5WXQvRkFSZGNyVnNHckkxU2tJbnFmR3MwQlFtaWpsb2tOa1ozeDE3N0Vx?=
 =?utf-8?B?RW8zUE5VZG95ZTZ0NDZDT2l1QTk2Zm0yQnAvemtiS0tXMzgvdDRITEZaMlcz?=
 =?utf-8?B?VmlmaW4wQnROYVR1ZDZVOXRqV1RCOVQ1VWZ6YjNjMDZYZlllb1d6VmlTOVk0?=
 =?utf-8?B?VXJvOFlwTGw5ZFc3QlVlWGdNTjZjMDV5SWtaN0R1SXV3eStXSks1Q1lLTHBI?=
 =?utf-8?B?aXp4blJMY0tmZ3RkWHF4eTNiMVRDT2YweDlDbThudFM3eVAvM2h0STF0Z2oz?=
 =?utf-8?B?M2NRcDVkWU5rdjR3ajkyN09aK3FCUS9SNHF3eUNpYjR2OTlXaVA3bjh0Ty9F?=
 =?utf-8?B?eXpqc3diMk5vY1hqMzVMOGJmQXU0Y05GMEdvMTROMXZFbTNaVHBGQTB1anY1?=
 =?utf-8?B?aHc2YkFsbUtqaytNQ25meDVRWGJmRkNlS01XM0dIdTVUY3R0OXo5eE1oYTZ0?=
 =?utf-8?B?cm1nZkdpUHRDSHJsZzRzbE96TzlaamN6MGFKb3lGS2lYWXFNaXkrLy9IbjY1?=
 =?utf-8?B?R0FxdDdiTzMxWGRUUmtlb1F2OXJtWUJyUzZVTVFPbmRwYk5HbVErYWM1NE9U?=
 =?utf-8?B?N2Fod09VUk9nSkh5YSs4c01INHQxcm9MTW1NNG4xQ3cyVHlEZlJsKzdGSlZX?=
 =?utf-8?B?YTBMSmFIaUJSYmZ3TWZHemlSMWVRTFNia2Rvc1VvZEVMMG5SMEZqUlVOR0kx?=
 =?utf-8?B?OURNN1NVMHhCOXdidFRZMGVpbC94bG8vZ04yRE1KTDY1Mlp0U05DMU9pMi9O?=
 =?utf-8?B?WDRnc3ZVSGNCTWpCTHBPblVZaFZDODRTb1J2RWxYTk9lTVVQR1ZGMy9XM1cz?=
 =?utf-8?B?VjRjbUpIVWJpQUtqT0s5YXVHUVpmWjNGSHUyT3k3c1E0ZmxQbFArb2twV09i?=
 =?utf-8?B?Y1Z1U1lmOGd2VzZtTmpBWUJQM2hKeGwyYWNNSVRpT2xHQUR6YWVWQ1ZHZDU1?=
 =?utf-8?B?L0NGRjEvdkwrT3Z3SDhLcTRaVUlzYzNVdVdTVG9BV2I3bzZHak1ZSDgvQ3NR?=
 =?utf-8?B?RVZuTHMwd2FpcldCMjdDL01ST2xJNDNFVU0vNTUxcXlldWliTnlSM2MzcFA2?=
 =?utf-8?B?QjlMdC9tSDcxQjAyWUdCV28rMzVEVDdjeHJlaDNLNnl1b050M2dWdDBjSGFY?=
 =?utf-8?B?a3pqektpNCtNNUxUckpkRHR4SUdZa1hmb0pyYVpHejVidldjZHRpenZ1VjZT?=
 =?utf-8?B?NlJoVml0ZmNZSC9HOW9JVERSUjc1cjJmeThveXBwTURLUDNNZ2NiVzlzOUZ0?=
 =?utf-8?B?QURYc3FkdG50R1MzaXV5ZklUcWFnSnl2ZGtFbXJjam4wNVE1Qjd2SVM3dE9B?=
 =?utf-8?B?VG50Q3A5MTdQNVU5ZExpT3lhdndzLzZMLzdvcXhnRTBBWVpIUm1vYmhqV3dY?=
 =?utf-8?B?QTRFVFFwcGZ0dmxlZVArR2NUUm5ObmRPVDBLUlRvdXAvMlBSRkJHd1FkRU1V?=
 =?utf-8?B?Q0g0OUdwZXIyVVBFVUo4eXVJZ0RXUjZZN0xaMk5XN1B2MkFUSkt2N0pSSmJI?=
 =?utf-8?B?Q3ljQ0dzSEJtQ24xdTE5MTVVSGJGWXoyaXl3clB5SjJCNDNhVkZhWURtK3NT?=
 =?utf-8?B?UzZXK25WVHRSNlVxaFJhTTlpWGE3QlpLRHd4SEJMZisydjlkaWZKMTFLY3Jn?=
 =?utf-8?B?K0RobkJiSGNaMlVLY2ZOYTVHcTVQQ203L2xUMGprditUL2l6dWpOV3J1WnNQ?=
 =?utf-8?B?UGw4aFlsYXc2NVp4Kzhhb25NUkxYZUxVNHlsbXVhYWNDcXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cncyN0RqNHI0dnI2bGllNkg5SmxJaHVOekJDV203U3ZJOXJwSWdXZmxBcnJm?=
 =?utf-8?B?bE1ZL0M5OGZoZXZBeFlqQWh6RSszdXZKblIyWnIzZWV3TTVkb0N3azZ6eUU3?=
 =?utf-8?B?Nng0RHJSbitKN2YyUVJHMjRsdkd4ZWlweUthaUxac2orNTVTeE5MSjJiQS9j?=
 =?utf-8?B?b0tCRnp1RW5oRVp0VWxFZHZHdTQzSDVVUnlCaDNneHp0T1FoeVQrRHIxTDNQ?=
 =?utf-8?B?aTVYVUdWQWhtSHRqMmQyK2hxdW4xZ0VoVklXMndwQ1JHd2ZLZzRpSlRjRjhQ?=
 =?utf-8?B?QW1MU25ObGJhMkZrVFRKNStoY1NVVjZ4SzFCYkI3NkV6bUtmcHdPekJDcklS?=
 =?utf-8?B?M05BQUJkKzZSci9XRW9VcEQ4NktsMG8wd05KSWRJaTdsYmZrazNZL2UxTDdl?=
 =?utf-8?B?aG9KK1N4WVNVcDJXU3FwZjBTbzEva0k3WXNJUHRQVGhuVVZVVTg4RkRGQnZq?=
 =?utf-8?B?SUdVNFdmQXcxR2lEYitYUmQxZDN2aFNYNE1UV3hMWHRnMTJKTG5iWERMTkha?=
 =?utf-8?B?OEJ0QzBvL1RXV2NDLzUzWnNReE9qMTlObWlsQUxXT0lsSW1yMHhjbVgyK0JC?=
 =?utf-8?B?Ykd3dnNPeXNiMXJTVFFQVWNhSjRneTAvZU85U05uWDlqZE1vUFZ3alJlbDR4?=
 =?utf-8?B?OWlVeXpUcVBrUHhQRlN4am0zL0VDSXh0NjI4WmZrRUNVdXFsWGxhSklYeEwx?=
 =?utf-8?B?d0JFV3dTQ1BYZFBFMDBjMThrVlFIU0kzbkhFU2F5Zy9RYjB3dFhRVEdhSjF3?=
 =?utf-8?B?M3ZjSU90L01SRWtjK1dBbWt3Q2J5dEkyQXBBRDYxMTE4dTZYemlyWG9VVTA4?=
 =?utf-8?B?NkM3dFd4aGtFRGNWbG5iUUk5cXZwNzlqR3ZRY1hRTllzYTdYa1pacW5PR3l0?=
 =?utf-8?B?Y1AzaEYrRXZCVmxsQXVWclNrbHR5N1ZoNjRZRDBIMkg5TnFPWDA0NHdEYnNl?=
 =?utf-8?B?RElOS1ZScUduejNRR3VHSlRVRy9jbDNtdnl6Y0ZMcnBXUWgrWCtua2E2REs1?=
 =?utf-8?B?YTMyNXdvK1ExWCt0UDR1NEkvOFE1cWZQMGRQRlVCL0FvTnFDREhLdHZXbjln?=
 =?utf-8?B?UEUrZnVJRjh4djBWdW5henR3NG4rWi83b1ljUFhKaHRSeHNSdk5GQXhQUWZN?=
 =?utf-8?B?YU8zUkppY2U5N3hRWEhQZFFYMXk1b1hadXRKL3VhWXE0NHhlTDI1YTZwR1dH?=
 =?utf-8?B?MVU3OWtiVUJlaVBHdk9zN1RCUFlXN3FQcGt4UXJwZTJPWTJIQTlnNTNvbWsw?=
 =?utf-8?B?Z0lFWUhlQ25RQ0diVWRCYWJDcjVBdUlLdHNqM0hRL1lIV1dNWDZzSWR2U1VM?=
 =?utf-8?B?ZFpBcDVkNzFxT3NmQkY1U3NVaG81L1NaTi9oRjgzZ2xFVm4waGU3Y2ZkZkFF?=
 =?utf-8?B?OHRNYWwyd00xME5IN1NQNzdDNTZhRWhCdU1HR1NiRERnRTI3bktSdkhRWHk1?=
 =?utf-8?B?NGxyTk5ZcWUwSUQ2ZS91MzB6QUNNT1RDK2hEcThnN3p4elA3MmtIOVFERHZk?=
 =?utf-8?B?TU9iWXZFOW9ZR1pKZzhWSzl0blZsTmtWeDFqSzlyRmIyaFBaWjRXYU43LzBW?=
 =?utf-8?B?Wm95Tk9nejFtRTd4VmZsaTBzODFZN2pVOVdITjZXTXlVTXlLbEZsQUJybUww?=
 =?utf-8?B?ZHV2TCszVG54cTZwNDBWWXM5N0xkUW5INTc3eXpoT1ZJc2RWVnJBdHp1bGM3?=
 =?utf-8?B?TUk2UTE1T2k0bmh6R0ZhaUVUaWpEOFBHQitmalB0L09BU2xrbzIxQzdhMzUz?=
 =?utf-8?B?eTFhai9CbXNMUnI2ZlNpbllzUHlaTjFkWWUyTG5kREZXUXJVM3VSZ2k3RDZy?=
 =?utf-8?B?SHlkN01nOXRRZE1yaWJ5ak0wclE2NjU5eEI2ei84UmlDaEJPbVhwMkJsZ3FG?=
 =?utf-8?B?T0tlZ3BBMzNXTXJnS0pFZk91WEcrUXZoWThPM1V0ajBRc2Iwb3J2a0xmdXRE?=
 =?utf-8?B?MDlXdzQ4eXMxQ3JDdGNwYjZTeUZNRHArb0Faa3RVa0I2Z2U5dEwzcTk5TCta?=
 =?utf-8?B?VHFSTHJSRktHYkk0ODFhcmQ1SmVjLzJHNllTeThiRWFOaEdyV0tCSk1SRk5n?=
 =?utf-8?B?bFl0SVpWT2M3UklyRzUvM2NZb2ZvVEgwZUhjT2lXK2t2L2QyV1p1RDY0MFNt?=
 =?utf-8?B?dUEveFdsai9iVUpIbW4zVGhvZTRKNGpaR1U2a0o2RERjL2p2eU9JMDhVZTVt?=
 =?utf-8?Q?b3WiZtLrYD4te38/y5y9LRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FA3C3152EC55743ABD06366529166EB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900d6382-f470-4033-33d4-08dc9c3bc3a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 15:12:47.8948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Jvf2QVoqwZMYmtObPyLWHJjF3s/fSXl4p9Iwzw7rU2RLwvnUNwvnTOCK8tuljpXCt+/QI3anPU/Cl2e2lOcXbTWQ8YA6Z84Q27s33u9Xmg0rq0A49WSw/Lxdb/OeuGl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6455
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
cyBwcmVzZW50DQoNCkZpeGVzOiAxYjJiMTIzNzZjICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1cHBv
cnQiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1h
dGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NClJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KaW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAzMSAxMDA2NDQNCi0tLSBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQpAQCAtMjY3LDcgKzI2Nyw3IEBADQogLyogRm9yIHRoZSBsb3cgNjQtYml0IG9m
IDEyOC1iaXQgKi8NCiAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAmIH4w
eGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAweGZm
ZmZVTEwpIDw8IDQwKQ0KLSNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFsKSAm
IDB4MSkgPDwgMzEpDQorI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwpICYg
MHgxVUxMKSA8PCAzMSkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZhbCkg
JiAweGZmZmZVTEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0aW9u
cyAqLw0KLS0gDQoyLjQ1LjINCg==

