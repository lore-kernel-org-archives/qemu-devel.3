Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC10C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOp1d-0001JE-L1; Tue, 02 Jul 2024 21:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOp1Z-0001J1-Dq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 21:43:09 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sOp1W-0003q1-H8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 21:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719970986; x=1751506986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vqECiBrvn6jPjVTb5n5KRDSdSoIuss7Vam23jCXZcsc=;
 b=Hr6EdX4GxNV5MrNaXhx/tKpghYOEafzEwDBL2pQI4jAcmtTgU/nR/KaH
 +gECP65myvT0eZQqwPQHZOHo/+PWii9ztEtUlid/3kEePyWad8/K/h83g
 pVEUuOl3CEw2IKRrFH0utKpB1w4FvCdJUBA5f2z5goSnd0Vkb2afkbPo9
 XeRggkzAkuvF20iF2rGuJ+K+wPh+ZE338hEaYX/N8tg3WV1k68UK8wyDg
 UaY5EkU5h2QfIA0kX7Lf2nVjuXKxkr2hY1nCKMZMZeQbGyBziu4xF0ImN
 T/ovA1848nA9w54ApoGEuH/7PzpYruYwD0+t/ogSCMPn+wGNfB6ochZAT w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="37058616"
X-IronPort-AV: E=Sophos;i="6.09,180,1716217200"; d="scan'208";a="37058616"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 10:42:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt9nB6eMq+asG1Qgxsmsoioa4WQJvwXRQ6kid7CNwdGAIi5N4XtcntNOwPSXGytarDi0MiFWmNLUe05Xj7hdMIZQSXUECD6wzWBT7smKdM8skK5MTU1i/1wW/6JbUGzGldChoZESevB9HPkcZFTNMkZkw+DYPxQLnqfmFJ7VdyGSBfp9G/hxgLEdgsXU9k1X4S6poFGahLsXq30O9YyTFPWLxVGd24Rz4Hh7xBjLFEhxTeXIUKR04OcQw/ZtKwYuYLeeuZmtZdg1392RWaxZaIvJzEgcJEFzMQKAK/5PgE/IjsVCHIFiK+QTmQo3blMT/1g3I6Fjry0iTGJSurbudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqECiBrvn6jPjVTb5n5KRDSdSoIuss7Vam23jCXZcsc=;
 b=EXCA/ubNl3NqDeSAKVf5mtNUDPoAAj4l8DdwL95T0KlVerpZfHN+d9e37+A0HZfFb14GKs0ttLjo6QnQp3F9gEwCHdPF0uHtGFbvh9+pbPmvMpE4q9Q1G9KQ0KNs+TjePDASS/X+oOjuzXnspjkgYn3vakmx7KNGQyuFei+XEkKajOtfI+c9d/hXIGm7vjMTVsPO29Jh1ESautbwENNU5RBfGBmnj8QeiVdyFAXA1pJb950xf1s534bdythR6debIsLiJ7eDZmSOrgO7i05/yiohlVGIHdi0dC6RPM4Bv8egekg0ZmzMXO4Bzxw/03lBpXVBvOED+IeG7lg1SLV96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TY1PR01MB10752.jpnprd01.prod.outlook.com (2603:1096:400:321::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Wed, 3 Jul
 2024 01:42:52 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 01:42:52 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v4 7/7] tests/tcg/x86_64: add test for plugin memory access
Thread-Topic: [PATCH v4 7/7] tests/tcg/x86_64: add test for plugin memory
 access
Thread-Index: AQHazLA/KdaVJZ4pGEes8TGE62JFo7HkOv1Q
Date: Wed, 3 Jul 2024 01:42:52 +0000
Message-ID: <OSZPR01MB64539BF2C8F393B2205C9B238DDD2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-8-pierrick.bouvier@linaro.org>
In-Reply-To: <20240702184448.551705-8-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OGFiOTAzYTItMTk4ZS00MmY0LWEyN2EtY2M1MDRhMGQ4?=
 =?utf-8?B?MzY0O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAzVDAxOjQyOjA1WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TY1PR01MB10752:EE_
x-ms-office365-filtering-correlation-id: fa7c3c35-f3db-434c-65eb-08dc9b0173f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?emczR0VEVm9NSFh6elB4RnVqZHdLN0ZMelBXWEJ5T2NiSyt2L3BwbFM4SHpV?=
 =?utf-8?B?SVpkcEZrMkdXNlJPOXhkb0hRYXNTMEkxZlFrZXBtbEhPc09SRFZWSUxjRXpS?=
 =?utf-8?B?Rmcrdnd0eng3UGlxUEN0TXlWUlI1WmJIM0JTNnFFQ3hvUi9jRjVMZDJua2Fp?=
 =?utf-8?B?MkNNVU40Y1FpTldzY2Y0WW1PNVVCSUJnWGx2NGd4YitQUTl2b1Y0Y3NkR1F2?=
 =?utf-8?B?MTdYSEI3RXFrYW5xQit1SngwSjB6ZzlzbWdLcUlxUVhkUFUyY2pWQU9iblRU?=
 =?utf-8?B?SVU3OG9JOVN4VDA4dTFDci9KazUyajdpaENYVFozd3Byb1o1bHBtYnhnMjZN?=
 =?utf-8?B?UG5RQ01kQU9naXNjUVVSR29yMUlHaC8wYzMxZHUrSmUzdG9wNG1JdmVDNUlS?=
 =?utf-8?B?bmJiZmVhQTdiMDBMQVkyd2lRaUhsTGtHT0RLeHNKVmhOWkJEMzY5UzdjRTho?=
 =?utf-8?B?QkFIaEdYUXE3cThoUXJESkVRcHFOZURwVTIyUTNTL1pKMXIyVThPb3BUcGNH?=
 =?utf-8?B?Ym1hbC8wVm1wQ0tPL1RadEVTb2dhQ0hnejdQNVhoN0xSVEhITm5BL21jbWVE?=
 =?utf-8?B?QTRGVEsxNEcrY3BOc0xnZVl1b3ZnRytmUHQrbVpqZWc5eisyenB3SEpLUjdt?=
 =?utf-8?B?MExrSExWc1d2MlMxQXBoSVlZb2dMamxWblovRE93QnlzUVlXbzFNZXhGdFMv?=
 =?utf-8?B?YUFDNXVMWnRwWm9GSWE0dHdPWm1ybHJla2t4ZXU2WDJWYklZWVhReVFMZ3po?=
 =?utf-8?B?ZjEvd2ZmQVJiRmwxaVB3QVJRR1o1QjhTQlJ3SEpLbEtCRjNFeE9IbXJqQVN1?=
 =?utf-8?B?UmZTeGs0SXE4ZGoyRkIzYU15emlmazRoVVJCY3VQdjQ2MURjY2RrS0ovOEVN?=
 =?utf-8?B?L1c0NU5WT25Hc2xNWHB5VTBQTGRVRDBaMG1pTC9xTVpBK1A0MTRFMWgzSWRV?=
 =?utf-8?B?dTNldlFEZlBEakh4eTBpVUhjTWVwQlp1VEhMUVh2SklGdStvVzhLRnZTZk52?=
 =?utf-8?B?SVljK0F0TVhRMkgyZHhCS3NXTlpKUzNjZ1JkbkN4cHFYQURxYkNMQ2NLeE9h?=
 =?utf-8?B?bG82UENkVXV2d1Z1TnlkZEhsK0tQLzVFUmpXZmJXZFJqN0t4UVorVEpNT2s4?=
 =?utf-8?B?cFVRdXM3ODlaVWZ5RUhKZ09kc3ZmazJkejZqSHpWU1VLcFphVjBoRVNFa0VT?=
 =?utf-8?B?alJ4dEV0TW92TENLb0R0eXRmZWk4bHVOL1FyNEFhMWl3aVBqbHhGNjB5ZzUz?=
 =?utf-8?B?M0ZSeXRiYUswelZNTzA0Q3pWenRNbWUwcWZqMTNVUGRBMXFNTHhKNzIxRndU?=
 =?utf-8?B?SFdhSHc1cHVmMVJBYmM3dnp4bFhPcnRyN3IxZDYzWHVCSStUQXBTOEtsU3ZP?=
 =?utf-8?B?MVNBRWNqNGJHSTZLVFdBOCtNQVFZdC9vaVBWMEV4YW5uS0ZPMUdzdG9NWUI5?=
 =?utf-8?B?QUxjVkl4Zm92YTI0MzZUTTBvbEVyWVNxL2JReGwrN21JYnc0L25XZVZ2ZU8v?=
 =?utf-8?B?bWRrSVNJbHdReDFZTWJFZmE3bUdLWFdHVU56TWZzc3BvZG1PUU9WRC9GdnpP?=
 =?utf-8?B?N0VqNHNEamliWDAxOFhXZEpVTjB4ZDdYZm85aUVWaU5YdzlHZUVUYjdxN0lJ?=
 =?utf-8?B?cjBKaCtmUnNnSGVHZFIyN1hFOTVobzlBUmFvVE8vMnJxdWg4UGl1bWRXL3kz?=
 =?utf-8?B?cVJGYVIzSFBHMnlUcmJPc2p2dThHTzI1M3l4am1Ua3dvYXZWT0lscnFDL3RM?=
 =?utf-8?B?ekhqYVdLV2t1amozcWNPSGtuSFdxTlFtWFN3UmdEWVROdm9YQkJtWEVWQXB5?=
 =?utf-8?B?UFBIL3hGMnY4d2d6NmdkOGRaR3ZXUUt2UUZRUHFEYlZmZEZkZ2txdWZPblZa?=
 =?utf-8?B?UDBhTEFBcFk5QlplbGdsclMvQUNYUzN1eERIcDlMVjNkOWRkY0hIak1POWhx?=
 =?utf-8?Q?jCxznzAODsQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWpaOWRZYWVKTitCcG43ZTBnMVQxZ29YT2p4MGlnWTQ0ZTloNyt0MUxMK0oy?=
 =?utf-8?B?T3grVmtDUXRwVHM0ZTQ5d0dvOU96S20yeTVRcU9QcElnSDAzYXVMZjMvdkdl?=
 =?utf-8?B?aVRKS3NwV3VxcWlQOGtJdjJTTUNCRmVZblN3eFRtcGJHVUxlblFFMlk1Wjdr?=
 =?utf-8?B?WXNxTmNMekpvdkZyZFlTR3RXUnRXelRudDlTamtMMUVwa3UzYi9JdVVab2pz?=
 =?utf-8?B?bzU3bEZTUzIrNnM5SFAxZ0FXMzhyWWsvZVpFcDBTS0d2UE5GZ1JXblFaTC9C?=
 =?utf-8?B?N1FYSk10dVVGVGdoZE93MXhNcWJzak1hMTN2bUF1RVBDMU9NaDdHR3ArRkZ6?=
 =?utf-8?B?U3VZOEU5T0p3TUxrNnF4TUR4Vy84Tm5QNXZVVTQxSXhPQVNONWwwNFJlYTlX?=
 =?utf-8?B?RHl6eXJ5RE1JTVd5N2RrcDdCZG8rSVhYalpDdmVWUllFUUV0c2dpLzE2Nnd3?=
 =?utf-8?B?RXZFaUdxTGxJL1lFRjloVEdVYUswOHIwb2lMclZOK3IrVXZWYUVreDJDcEVp?=
 =?utf-8?B?dVhDb3djbHRlNnMxdGdkSEVuV2RmVFZSUVREcmJyMVk3L2tTWS9HaExUbnJV?=
 =?utf-8?B?K0FCZUhUM0EzUllEaStJVzFBMHFOUjRNSGJ3UDNIZ0hiU0RIME1XNUlmZlJI?=
 =?utf-8?B?aVh4Yk9DNGs4WXhEQy9pVXpmVUNZTTNFaEtZbG04ZW5sKzJ4cVdkRnZ4VFMw?=
 =?utf-8?B?aFExN202V1lQL29WS2F4RjQ4clZ6SU9PdnZCa1d2ZmpxbWFtSEhXL2dXK3lu?=
 =?utf-8?B?MWRWZ3NGRW1pUGNRejlnYzA5NWtFdk9odW5wem53RHF2UjdwWEkzYlpyM245?=
 =?utf-8?B?UkZQMGVWT1dyQTVraTJWdlpyS1MwYnBBMzZtNTFQQ1BPbks0SkI2Vm85K3lR?=
 =?utf-8?B?K050WXdrNHEvTmJleXZKVGZsRHlJUUJOZ2svNE5rNVdhQk94d0I3eGxWUElC?=
 =?utf-8?B?MThTenJ1QWErcE50TWVjaUNpckpxOFlMd3U2VTVoMDBtNDgrdkpxZ01XaHdD?=
 =?utf-8?B?MnZ5dklwbmRsV0p5c3Y1aVpmV3NidzFhK1BEQU5EL2hpRDgwMEtOSGp4S2xq?=
 =?utf-8?B?dXRHdFZ1K0JUeFdrc0dFSkV5NFZXOHl0b2dJZDRHZWtwUWYzK2ZyeHFuaWZJ?=
 =?utf-8?B?V2s4WnRkb2pYcWsxN3ZoUDV1QTVEOVd2bW1iN0dFMEt0NG9rM3UzOUJLN2tw?=
 =?utf-8?B?WS9IbVl5OGg1QkI1T1YwWjM5L2s4V1NvaG1Jd21qbzlGd0lKRDMxOFJtL05j?=
 =?utf-8?B?eU5jVzk5NldtaVJwQTJaZ091a1BrL3NwMjY4VWlQT0VpSkp0SWl4VGdmWHM2?=
 =?utf-8?B?ZTR3Si9yditGZnBwaTVnaStoUkRzVnlpdzN2bytFRWtzWHRyeUNhR082dXBs?=
 =?utf-8?B?KzdSQVN2SHQvUTR2cVhVRzBrMitYUlM3aW5sVi9wMG5GOWkzU2pGOFF1VTRy?=
 =?utf-8?B?ZWtwNEplaFB0R1M1dmh1YTlPRFVzSlJrczAvZmZIckV1Zk1rOGZoTVJvYzYx?=
 =?utf-8?B?ZnVHY0EyRG5LbFFXRXNJNWJGd29ZbWtYQ0N6UkJXZkI0OVVXMVZHbmxaSkUx?=
 =?utf-8?B?cDN2UUF2TDZMMlB3bzh1Ui9rSzlQdVlZNkdHbUdBM3hxL3Jhd1FsaTJHdGhk?=
 =?utf-8?B?TCt1aDlJUXp1TUtyV0p3NDBuS3MrK1BybjhFN2ZhWHlQWkJzM3ZWaS9qMy81?=
 =?utf-8?B?QWtuaGFaWFo4YzFTWDk0OEJzZm5wK0hzNjdKTFc1ZTVpdUZYbFJTWjNLZzN0?=
 =?utf-8?B?RGRkWnpaTVNuNHdHQStNdXNGVXpMZ2xVU0hOYkZVdXhYSU5RN0VDOUc2M3Bx?=
 =?utf-8?B?M1kzWXlSdEM5SlFRdm05bW8rWW9aZ1FxM251SE9XQ3BmbHZoc3NIbmVKYUoy?=
 =?utf-8?B?TGx4TmVFRU41emYxSFRNK1p2NnFZblN0VGdwbThyMmhXNzBUeWYxTG9zTnBT?=
 =?utf-8?B?V2U3TWh5UDUvWWpkVzZiVHMySk5BbXJuVVFOU2J6bUs3Yy9yNCswWCsyUUFo?=
 =?utf-8?B?cVdnWk1EZG9kaXdWL0c3aTVQNkNweVIyb2FJSHY1Um9hRnArT3hQaGVOdk5T?=
 =?utf-8?B?YkcyYU15bmNWZ2RQS1dMSTFIMkFDZEZ3V2pKRC9UYVhzc0tZSjUzOGo5QzJ6?=
 =?utf-8?Q?TT6Y05GfuF1E0W+UvAKcXrelK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8GULLZNYYCCKfuPadisPBEnr0m/1lF2hLAOn3f7F0prGF1tPPtLChiqa+1MNJdyhCE/QS2Q05gpRH4n16kk691PXgsbVe9o17yHbAoFHLyqjw6gViFP0pPhQohEaoqfPzRfN3WTEhNpSxgjfBVbrHJL9nMucAEWC9NhjHrole24RGskGY9dwZuhJ5tk96mU49HQcsXqVdJys/86wsPuVZmHDmC3Sfv203ciy87saRO9ExFrMGt+mJwF0Vjf2yi+lQ7HoHYbSG1rPsOUtPWBHwzYTCl5ikZx9k5SDEttKX4GQ4jBuQxe447HjC5TjY+ofuXuQKTQ1HMqZI+Yvdv8NSAUDEIch4VyWjQpl9Ak9Qwr6eC+XEwsaHdjhSFShUhMhNvfimExxwCibBmBzk3qA6tWZzXFWsmfOdojj33vveb4aE+I41K5xWmhpP8Wr5CZJVjVcystTqLX4SP4zOO13vEl2T1VJq4XzaKP5oGnCYKQMV3Vt22MQowKuiCGoyebqCIVWn/BO2IJJsta62QMJxLokQ+ueoJOieBCU2icEGd4GOaVFWuXiOw6Dr7w9XF5ViNX9Na2/yHvsFOPWrRjZFcDH3BBrhhOTNb0sikbdUjXazkDZfYzUQ/vYEcglQvJ+
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7c3c35-f3db-434c-65eb-08dc9b0173f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 01:42:52.2351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QinBlsWLA7cX4e8srJlIBeMWhmkH14jZIXxhWVvgaAJTy9V25x7CsRGvisii3s2xFTFEe6GCc0Dm5yhUH0qKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10752
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1ib3Vu
Y2VzK3lhb3h0LmZuc3Q9ZnVqaXRzdS5jb21Abm9uZ251Lm9yZw0KPiA8cWVtdS1kZXZlbC1ib3Vu
Y2VzK3lhb3h0LmZuc3Q9ZnVqaXRzdS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mDQo+IFBp
ZXJyaWNrIEJvdXZpZXINCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDMsIDIwMjQgMjo0NSBBTQ0K
PiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVu
bmVlQGxpbmFyby5vcmc+OyBNYWhtb3VkIE1hbmRvdXINCj4gPG1hLm1hbmRvdXJyQGdtYWlsLmNv
bT47IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz47DQo+IEFs
ZXhhbmRyZSBJb29zcyA8ZXJkbmF4ZUBjcmFucy5vcmc+OyBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qQ0KPiA8cGhpbG1kQGxpbmFyby5vcmc+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPjsgUmljaGFyZCBIZW5kZXJzb24NCj4gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+
OyBFZHVhcmRvIEhhYmtvc3QgPGVkdWFyZG9AaGFia29zdC5uZXQ+DQo+IFN1YmplY3Q6IFtQQVRD
SCB2NCA3LzddIHRlc3RzL3RjZy94ODZfNjQ6IGFkZCB0ZXN0IGZvciBwbHVnaW4gbWVtb3J5IGFj
Y2Vzcw0KPiANCj4gQWRkIGFuIGV4cGxpY2l0IHRlc3QgdG8gY2hlY2sgZXhwZWN0ZWQgbWVtb3J5
IHZhbHVlcyBhcmUgcmVhZC93cml0dGVuLg0KPiBGb3Igc2l6ZXMgOCwgMTYsIDMyLCA2NCBhbmQg
MTI4LCB3ZSBnZW5lcmF0ZSBhIGxvYWQvc3RvcmUgb3BlcmF0aW9uLg0KPiBGb3Igc2l6ZSA4IC0+
IDY0LCB3ZSBnZW5lcmF0ZSBhbiBhdG9taWMgX19zeW5jX3ZhbF9jb21wYXJlX2FuZF9zd2FwIHRv
by4NCj4gRm9yIDEyOGJpdHMgbWVtb3J5IGFjY2Vzcywgd2UgcmVseSBvbiBTU0UyIGluc3RydWN0
aW9ucy4NCj4gDQo+IEJ5IGRlZmF1bHQsIGF0b21pYyBhY2Nlc3NlcyBhcmUgbm9uIGF0b21pYyBp
ZiBhIHNpbmdsZSBjcHUgaXMgcnVubmluZywNCj4gc28gd2UgZm9yY2UgY3JlYXRpb24gb2YgYSBz
ZWNvbmQgb25lIGJ5IGNyZWF0aW5nIGEgbmV3IHRocmVhZCBmaXJzdC4NCj4gDQo+IGxvYWQvc3Rv
cmUgaGVscGVycyBjb2RlIHBhdGggY2FuJ3QgYmUgdHJpZ2dlcmVkIGVhc2lseSBpbiB1c2VyIG1v
ZGUgKG5vDQo+IHNvZnRtbXUpLCBzbyB3ZSBjYW4ndCB0ZXN0IGl0IGhlcmUuDQo+IA0KPiBDYW4g
YmUgcnVuIHdpdGg6DQo+IG1ha2UgLUMgYnVpbGQvdGVzdHMvdGNnL3g4Nl82NC1saW51eC11c2Vy
DQo+IHJ1bi1wbHVnaW4tdGVzdC1wbHVnaW4tbWVtLWFjY2Vzcy13aXRoLWxpYm1lbS5zbw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5h
cm8ub3JnPg0KPiAtLS0NCj4gIHRlc3RzL3RjZy94ODZfNjQvdGVzdC1wbHVnaW4tbWVtLWFjY2Vz
cy5jICAgfCA4OQ0KPiArKysrKysrKysrKysrKysrKysrKysNCj4gIHRlc3RzL3RjZy94ODZfNjQv
TWFrZWZpbGUudGFyZ2V0ICAgICAgICAgICAgfCAgNyArKw0KPiAgdGVzdHMvdGNnL3g4Nl82NC9j
aGVjay1wbHVnaW4tbWVtLWFjY2Vzcy5zaCB8IDQ4ICsrKysrKysrKysrDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDE0NCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNn
L3g4Nl82NC90ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
ZXN0cy90Y2cveDg2XzY0L2NoZWNrLXBsdWdpbi1tZW0tYWNjZXNzLnNoDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdGVzdHMvdGNnL3g4Nl82NC90ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMNCj4gYi90ZXN0
cy90Y2cveDg2XzY0L3Rlc3QtcGx1Z2luLW1lbS1hY2Nlc3MuYw0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uN2ZkZDZhNTU4MjkNCj4gLS0tIC9kZXYvbnVsbA0K
PiArKysgYi90ZXN0cy90Y2cveDg2XzY0L3Rlc3QtcGx1Z2luLW1lbS1hY2Nlc3MuYw0KPiBAQCAt
MCwwICsxLDg5IEBADQo+ICsjaW5jbHVkZSA8ZW1taW50cmluLmg+DQo+ICsjaW5jbHVkZSA8cHRo
cmVhZC5oPg0KPiArI2luY2x1ZGUgPHN0ZGludC5oPg0KPiArI2luY2x1ZGUgPHN0ZGxpYi5oPg0K
PiArDQo+ICtzdGF0aWMgdm9pZCAqZGF0YTsNCj4gKw0KPiArI2RlZmluZSBERUZJTkVfU1RPUkUo
bmFtZSwgdHlwZSwgdmFsdWUpIFwNCj4gK3N0YXRpYyB2b2lkIHN0b3JlXyMjbmFtZSh2b2lkKSAg
ICAgICAgICBcDQo+ICt7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiArICAgICooKHR5cGUgKilkYXRhKSA9IHZhbHVlOyAgICAgICAgICAgIFwNCj4gK30NCj4gKw0K
PiArI2RlZmluZSBERUZJTkVfQVRPTUlDX09QKG5hbWUsIHR5cGUsIHZhbHVlKSAgICAgICAgICAg
ICAgICAgXA0KPiArc3RhdGljIHZvaWQgYXRvbWljX29wXyMjbmFtZSh2b2lkKSAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPiAreyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICooKHR5cGUgKilkYXRhKSA9IDB4NDI7
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgIF9fc3luY192YWxfY29t
cGFyZV9hbmRfc3dhcCgodHlwZSAqKWRhdGEsIDB4NDIsIHZhbHVlKTsgXA0KPiArfQ0KPiArDQo+
ICsjZGVmaW5lIERFRklORV9MT0FEKG5hbWUsIHR5cGUpICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gK3N0YXRpYyB2b2lkIGxvYWRfIyNuYW1lKHZvaWQpICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAreyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcDQo+ICsgICAgcmVnaXN0ZXIgdHlwZSB2YXIgYXNtKCJlYXgiKSA9ICooKHR5
cGUgKikgZGF0YSk7ICAgIFwNCj4gKyAgICAodm9pZCl2YXI7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXA0KPiArfQ0KPiArDQo+ICtERUZJTkVfU1RPUkUodTgsIHVp
bnQ4X3QsIDB4ZjEpDQo+ICtERUZJTkVfQVRPTUlDX09QKHU4LCB1aW50OF90LCAweGYxKQ0KPiAr
REVGSU5FX0xPQUQodTgsIHVpbnQ4X3QpDQo+ICtERUZJTkVfU1RPUkUodTE2LCB1aW50MTZfdCwg
MHhmMTIzKQ0KPiArREVGSU5FX0FUT01JQ19PUCh1MTYsIHVpbnQxNl90LCAweGYxMjMpDQo+ICtE
RUZJTkVfTE9BRCh1MTYsIHVpbnQxNl90KQ0KPiArREVGSU5FX1NUT1JFKHUzMiwgdWludDMyX3Qs
IDB4ZmYxMTIyMzMpDQo+ICtERUZJTkVfQVRPTUlDX09QKHUzMiwgdWludDMyX3QsIDB4ZmYxMTIy
MzMpDQo+ICtERUZJTkVfTE9BRCh1MzIsIHVpbnQzMl90KQ0KPiArREVGSU5FX1NUT1JFKHU2NCwg
dWludDY0X3QsIDB4ZjEyMzQ1Njc4OWFiY2RlZikNCj4gK0RFRklORV9BVE9NSUNfT1AodTY0LCB1
aW50NjRfdCwgMHhmMTIzNDU2Nzg5YWJjZGVmKQ0KPiArREVGSU5FX0xPQUQodTY0LCB1aW50NjRf
dCkNCj4gKw0KPiArc3RhdGljIHZvaWQgc3RvcmVfdTEyOCh2b2lkKQ0KPiArew0KPiArICAgIF9t
bV9zdG9yZV9zaTEyOChkYXRhLCBfbW1fc2V0X2VwaTMyKDB4ZjEyMjMzNDQsIDB4NTU2Njc3ODgs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHhmMTIzNDU2Nywg
MHg4OWFiY2RlZikpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBsb2FkX3UxMjgodm9pZCkN
Cj4gK3sNCj4gKyAgICBfX20xMjhpIHZhciA9IF9tbV9sb2FkX3NpMTI4KGRhdGEpOw0KPiArICAg
ICh2b2lkKXZhcjsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgKmYodm9pZCAqcCkNCj4gK3sN
Cj4gKyAgICByZXR1cm4gTlVMTDsNCj4gK30NCj4gKw0KPiAraW50IG1haW4odm9pZCkNCj4gK3sN
Cj4gKyAgICAvKg0KPiArICAgICAqIFdlIGZvcmNlIGNyZWF0aW9uIG9mIGEgc2Vjb25kIHRocmVh
ZCB0byBlbmFibGUgY3B1IGZsYWcgQ0ZfUEFSQUxMRUwuDQo+ICsgICAgICogVGhpcyB3aWxsIGdl
bmVyYXRlIGF0b21pYyBvcGVyYXRpb25zIHdoZW4gbmVlZGVkLg0KPiArICAgICAqLw0KPiArICAg
IHB0aHJlYWRfdCB0aHJlYWQ7DQo+ICsgICAgcHRocmVhZF9jcmVhdGUoJnRocmVhZCwgTlVMTCwg
JmYsIE5VTEwpOw0KPiArICAgIHB0aHJlYWRfam9pbih0aHJlYWQsIE5VTEwpOw0KPiArDQo+ICsg
ICAgZGF0YSA9IG1hbGxvYyhzaXplb2YoX19tMTI4aSkpOw0KPiArICAgIGF0b21pY19vcF91OCgp
Ow0KPiArICAgIHN0b3JlX3U4KCk7DQo+ICsgICAgbG9hZF91OCgpOw0KPiArDQo+ICsgICAgYXRv
bWljX29wX3UxNigpOw0KPiArICAgIHN0b3JlX3UxNigpOw0KPiArICAgIGxvYWRfdTE2KCk7DQo+
ICsNCj4gKyAgICBhdG9taWNfb3BfdTMyKCk7DQo+ICsgICAgc3RvcmVfdTMyKCk7DQo+ICsgICAg
bG9hZF91MzIoKTsNCj4gKw0KPiArICAgIGF0b21pY19vcF91NjQoKTsNCj4gKyAgICBzdG9yZV91
NjQoKTsNCj4gKyAgICBsb2FkX3U2NCgpOw0KPiArDQo+ICsgICAgc3RvcmVfdTEyOCgpOw0KPiAr
ICAgIGxvYWRfdTEyOCgpOw0KPiArDQo+ICsgICAgZnJlZShkYXRhKTsNCj4gK30NCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3RjZy94ODZfNjQvTWFrZWZpbGUudGFyZ2V0IGIvdGVzdHMvdGNnL3g4Nl82
NC9NYWtlZmlsZS50YXJnZXQNCj4gaW5kZXggNWZlZGYyMjExNzQuLjVmNzAxNWZkOGI0IDEwMDY0
NA0KPiAtLS0gYS90ZXN0cy90Y2cveDg2XzY0L01ha2VmaWxlLnRhcmdldA0KPiArKysgYi90ZXN0
cy90Y2cveDg2XzY0L01ha2VmaWxlLnRhcmdldA0KPiBAQCAtMTQsNiArMTQsNyBAQCBYODZfNjRf
VEVTVFMgKz0gbm9leGVjDQo+ICBYODZfNjRfVEVTVFMgKz0gY21weGNoZw0KPiAgWDg2XzY0X1RF
U1RTICs9IGFkb3gNCj4gIFg4Nl82NF9URVNUUyArPSB0ZXN0LTE2NDgNCj4gK1BMVUdJTlNfVEVT
VFMgKz0gdGVzdC1wbHVnaW4tbWVtLWFjY2Vzcw0KPiAgVEVTVFM9JChNVUxUSUFSQ0hfVEVTVFMp
ICQoWDg2XzY0X1RFU1RTKSB0ZXN0LXg4Nl82NA0KPiAgZWxzZQ0KPiAgVEVTVFM9JChNVUxUSUFS
Q0hfVEVTVFMpDQo+IEBAIC0yNCw2ICsyNSwxMiBAQCBhZG94OiBDRkxBR1M9LU8yDQo+ICBydW4t
dGVzdC1pMzg2LXNzc2UzOiBRRU1VX09QVFMgKz0gLWNwdSBtYXgNCj4gIHJ1bi1wbHVnaW4tdGVz
dC1pMzg2LXNzc2UzLSU6IFFFTVVfT1BUUyArPSAtY3B1IG1heA0KPiANCj4gK3J1bi1wbHVnaW4t
dGVzdC1wbHVnaW4tbWVtLWFjY2Vzcy13aXRoLWxpYm1lbS5zbzogXA0KPiArCVBMVUdJTl9BUkdT
PSQoQ09NTUEpcHJpbnQtYWNjZXNzZXM9dHJ1ZQ0KPiArcnVuLXBsdWdpbi10ZXN0LXBsdWdpbi1t
ZW0tYWNjZXNzLXdpdGgtbGlibWVtLnNvOiBcDQo+ICsJQ0hFQ0tfUExVR0lOX09VVFBVVF9DT01N
QU5EPSBcDQo+ICsJJChTUkNfUEFUSCkvdGVzdHMvdGNnL3g4Nl82NC9jaGVjay1wbHVnaW4tbWVt
LWFjY2Vzcy5zaA0KPiArDQo+ICB0ZXN0LXg4Nl82NDogTERGTEFHUys9LWxtIC1sYw0KPiAgdGVz
dC14ODZfNjQ6IHRlc3QtaTM4Ni5jIHRlc3QtaTM4Ni5oIHRlc3QtaTM4Ni1zaGlmdC5oIHRlc3Qt
aTM4Ni1tdWxkaXYuaA0KPiAgCSQoQ0MpICQoQ0ZMQUdTKSAkPCAtbyAkQCAkKExERkxBR1MpDQo+
IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cveDg2XzY0L2NoZWNrLXBsdWdpbi1tZW0tYWNjZXNzLnNo
DQo+IGIvdGVzdHMvdGNnL3g4Nl82NC9jaGVjay1wbHVnaW4tbWVtLWFjY2Vzcy5zaA0KPiBuZXcg
ZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAwMDAwMC4uOTIwMDhlMjVhOTMNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cveDg2XzY0L2NoZWNrLXBsdWdpbi1tZW0tYWNj
ZXNzLnNoDQo+IEBAIC0wLDAgKzEsNDggQEANCj4gKyMhL3Vzci9iaW4vZW52IGJhc2gNCj4gKw0K
PiArc2V0IC1ldW8gcGlwZWZhaWwNCj4gKw0KPiArZGllKCkNCj4gK3sNCj4gKyAgICBlY2hvICIk
QCIgMT4mMg0KPiArICAgIGV4aXQgMQ0KPiArfQ0KPiArDQo+ICtjaGVjaygpDQo+ICt7DQo+ICsg
ICAgZmlsZT0kMQ0KPiArICAgIHBhdHRlcm49JDINCj4gKyAgICBncmVwICIkcGF0dGVybiIgIiRm
aWxlIiA+IC9kZXYvbnVsbCB8fCBkaWUgIlwiJHBhdHRlcm5cIiBub3QgZm91bmQgaW4gJGZpbGUi
DQo+ICt9DQo+ICsNCj4gK1sgJCMgLWVxIDEgXSB8fCBkaWUgInVzYWdlOiBwbHVnaW5fb3V0X2Zp
bGUiDQo+ICsNCj4gK3BsdWdpbl9vdXQ9JDENCj4gKw0KPiArZXhwZWN0ZWQoKQ0KPiArew0KPiAr
ICAgIGNhdCA8PCBFT0YNCj4gKyxzdG9yZV91OCwuKiw4LHN0b3JlLDB4ZjENCj4gKyxhdG9taWNf
b3BfdTgsLiosOCxsb2FkLDB4NDINCj4gKyxhdG9taWNfb3BfdTgsLiosOCxzdG9yZSwweGYxDQo+
ICssbG9hZF91OCwuKiw4LGxvYWQsMHhmMQ0KPiArLHN0b3JlX3UxNiwuKiwxNixzdG9yZSwweGYx
MjMNCj4gKyxhdG9taWNfb3BfdTE2LC4qLDE2LGxvYWQsMHg0Mg0KPiArLGF0b21pY19vcF91MTYs
LiosMTYsc3RvcmUsMHhmMTIzDQo+ICssbG9hZF91MTYsLiosMTYsbG9hZCwweGYxMjMNCj4gKyxz
dG9yZV91MzIsLiosMzIsc3RvcmUsMHhmZjExMjIzMw0KPiArLGF0b21pY19vcF91MzIsLiosMzIs
bG9hZCwweDQyDQo+ICssYXRvbWljX29wX3UzMiwuKiwzMixzdG9yZSwweGZmMTEyMjMzDQo+ICss
bG9hZF91MzIsLiosMzIsbG9hZCwweGZmMTEyMjMzDQo+ICssc3RvcmVfdTY0LC4qLDY0LHN0b3Jl
LDB4ZjEyMzQ1Njc4OWFiY2RlZg0KPiArLGF0b21pY19vcF91NjQsLiosNjQsbG9hZCwweDQyDQo+
ICssYXRvbWljX29wX3U2NCwuKiw2NCxzdG9yZSwweGYxMjM0NTY3ODlhYmNkZWYNCj4gKyxsb2Fk
X3U2NCwuKiw2NCxsb2FkLDB4ZjEyMzQ1Njc4OWFiY2RlZg0KPiArLHN0b3JlX3UxMjgsLiosMTI4
LHN0b3JlLDB4ZjEyMjMzNDQ1NTY2Nzc4OGYxMjM0NTY3ODlhYmNkZWYNCj4gKyxsb2FkX3UxMjgs
LiosMTI4LGxvYWQsMHhmMTIyMzM0NDU1NjY3Nzg4ZjEyMzQ1Njc4OWFiY2RlZg0KPiArRU9GDQo+
ICt9DQo+ICsNCj4gK2V4cGVjdGVkIHwgd2hpbGUgcmVhZCBsaW5lOyBkbw0KPiArICAgIGNoZWNr
ICIkcGx1Z2luX291dCIgIiRsaW5lIg0KPiArZG9uZQ0KPiAtLQ0KPiAyLjM5LjINCj4gDQoNClRl
c3RlZC1ieTogWGluZ3RhbyBZYW8gPHlhb3h0LmZuc3RAZnVqaXRzdS5jb20+DQoNCg==

