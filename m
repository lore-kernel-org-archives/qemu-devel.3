Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C19C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPb6b-0005Py-Rv; Fri, 05 Jul 2024 01:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6a-0005O6-Kq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:32 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6T-0003dq-RU
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720155806; x=1751691806;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=j628q3+V4xqPJkfr6b8PJdJ5s63LIyfgsCAOxJmOsz8=;
 b=o868FcvsYy+Xx2PyD+RwB2rY8sM5cieGOKU1zS28j4DnwZwsrLM+3Lm7
 cK0z+vCVBUFebVkgutU5D3+pvb6PGyJtddFUX3eIuBUumuY8IMyA5MedP
 X8nhb8kNrE6T4/UPAyDcJzo7XKdec7WAzcKbYifSrmhDCdbRejtk0/Cfe
 fd7BI3czRRIqICv6IeimD4Ryyh4hMe2fyewKVSoy64lIfrDtgR0eO0PYr
 VgnyqFSJS6AYf8PMagZYfvJIr5p/dMKMAYc9d7BIsTZGKoIAUCYRF1qVq
 SqWQtDFwno9kLiyDO2Iv7JSIEya/NCXlgYZutV7/x2qlePgo2h4wdYy6O w==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="16030229"
X-MGA-submission: =?us-ascii?q?MDGA39Y2QmRWxn7xksqi/XNwj+Q6C3cJs10SqZ?=
 =?us-ascii?q?9LM6/P4RuWT7hidmdQhKWNXszAYIPlxgTu6sMVFXWdaz2kVawgJXCZDf?=
 =?us-ascii?q?Id+3434/CnZGIiO58XCoU/gDcU8z8uDB9AP01GD9rqdNk4Z4bTE9qYfx?=
 =?us-ascii?q?KOaliAboFQ9sNAGuXx/LNDSw=3D=3D?=
Received: from mail-vi1eur05lp2168.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.168])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 07:03:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0M+QNwT2ppk3+AGFrBWounBVEZKRsEWgnt2eHbL9NfIKYOb1Q0OQAeXh+LUzQuZkrlqLYGxPP6QQ6J06cn78NnvKqruQxWL+O2P15iN+4Cay15UrzMrWWoNp8Nq3qPPMFUk4j7qN2MYV4gM0G78xnJwAasb+iJCTgmtbfTgmfmZTEU0bQgNekxkBO6PQnCHJEYP0QSqCr46C9JrTOrPbX3oWEWAUehG8CBfjaMWEUGsjNbP/IOrxprH+KDvfovg23FYcmq+5TDGWtHGw7CqsOYJn1X6QB2wtlVghCW1XRiz7Byzk6gGRizg5tzmJmZwkg9uRgTANufHOcz0NcMaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j628q3+V4xqPJkfr6b8PJdJ5s63LIyfgsCAOxJmOsz8=;
 b=ke48zH4dXu35fuwkAO2qJ6dtGcEZ5c7MBcBpPt4rzigM50MzLf2+/wObwZIm3eOMJTaOQj3z4xCkz7TKUj5oKJpqXbVXvYjljNc3u8H8smePoU3aSysU5WPr9yiGmaP/FDL/4Igiy6Q21yZTiTdNRaV8oq5qeBiUgqYz2WdRbJqTnaTJ3lyzQD0pfG9ntd2ecdCOEzpK+5eJcatfjEzIHtBIzpm1dLq5RIgi7PHB1dPXisjMfn2Ep4rFO2RwNUZRXSuF9BeJuXCKQ3wjEfzPrgk6ICmNjKozMalR//CW7mJZcKbfPMwfm2FsqMwfGvG0cHjXs/zd1ALNWZDj7GPjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j628q3+V4xqPJkfr6b8PJdJ5s63LIyfgsCAOxJmOsz8=;
 b=IlndJezECotoLvbFri7e3SubF9vEOQ7m12Qe6OEUxoM/PvH3rI2yhho4Pxowa2+I6q9sKNE7zZJjTk2to9835WdbEdw6tTEooDzTZx1kQT+CrN98wmi9OXIgSw91Fr4DOf4/5+Cf+GRc/UKuTtWKfKh0JvUtIMWpmegca6YpSbOMMN8SUh3wazBRZcoq73LAJuhQx7l6QNPDExJUbJW5em+Ef5ZSVu+OKUAe9GpmRpuME/g6FbsHmLS0xegtou2B7+9p6XMqxt/B87sElxbJpM0SiWZpwXoUvLbfB1/RkDtEfvwh5IU3wNLTDXga2VKR9SNRM8zgf4hr2nzhFw7pUw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6542.eurprd07.prod.outlook.com (2603:10a6:800:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 05:03:15 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 05:03:14 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v3 0/3] VT-d minor fixes
Thread-Topic: [PATCH  v3 0/3] VT-d minor fixes
Thread-Index: AQHazpijdaEuqiQM5kOypZZeY+5kgQ==
Date: Fri, 5 Jul 2024 05:03:14 +0000
Message-ID: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6542:EE_
x-ms-office365-filtering-correlation-id: 744455e2-7b81-42f7-cb84-08dc9cafc67f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dXdjSG14b3ZHMTNWWUtVTUgrU25nZFBLeWFySmtHalkyaXVSa0lLOCszMUZN?=
 =?utf-8?B?RHpiOWUrMndCR3FPcDk0OGhjMk53RXJCVFQ3SnJJYkNVU1piRzA3UzVqV2RQ?=
 =?utf-8?B?SW55QWx0MEdyaXExOFdkQTFPZ0ZLWHErb082Tm8rL0lZQnpZc05FTHhxa3oy?=
 =?utf-8?B?VkxXRnBSUUFKNEM4LzJyaWRCUjE0UlpxRFVVdCtkOVVvS1VkN0VtQ2hSNVlW?=
 =?utf-8?B?SmtCeGVDejZicW13K0JaSTBuYnhkajMrcVBlYjU2RG4vSUVIQjdxOHE1dDNV?=
 =?utf-8?B?RGRNOUU2T1Y4Z09rRGRxa3htUlBhZlJmcnZRS1Y0a0xrVE5QM09GMGlXUG9K?=
 =?utf-8?B?SWFEMzdlSlFTRTZtaU4zSVB1Y0gwNURaNzlVRHcwcHZnQ292ZlAyMW9aa2NN?=
 =?utf-8?B?OFZ0SVBWZzVBSitMQXlTZGpISFdwRFhWZGFnb1luQ3BMbUtKRHdYZlJLMFU2?=
 =?utf-8?B?V2E5RWVBd3F1Ujl3VEpUR1lpbytxYnU4aGd0R210M0pycHN5NzNia1BTcTdE?=
 =?utf-8?B?M2tvT0VQclh4MjlBeFAwVFVpQ053Q2ZkdnpQb0EycDR4YVY1b2p0akhFa3Ew?=
 =?utf-8?B?a0xYem9QOWRJd1Y0NHYwcGtEeU9VSWRTVzBpRmtrejR4WEVrRHE2SlNaZXZx?=
 =?utf-8?B?ZUVYY1l5UTlnSk1TV2lZbDg5UHFsOXJjWDFxem55LzI1NzB6UXh6ek8yRkdF?=
 =?utf-8?B?bkhxS2FjaWVKbFFyWDE1TWxsTzBxV2oyWURIakRRMWVTenY3MXhocXk4TkdD?=
 =?utf-8?B?bklGZ3NBVkdtNmpnS1VISlhlbFZLUllxakFXWVZVVzByTXJBTjM2Q2pIVDcz?=
 =?utf-8?B?REFYNE9SMjNvVStFOWlvQUZwVmFGSStKMTZWMkdob2RGVWx2ZUhwM05yM2FG?=
 =?utf-8?B?YXJzSWlmQnNJSERjUEJIVDV1Mzk0YWtoNW05U2FxeklOaXVvcENLNWVkVXpj?=
 =?utf-8?B?RGJwUDhOUk9qM2FxZTE3YmZwVmxsZFl1OWF0UnhvQS9GMStDT0FaTFprLzlH?=
 =?utf-8?B?S2tEbTY5RGRpYW1UajVEckVyVXZkSkdhYVRRaVRzdHBOdnlFeDd2eXhmcTNN?=
 =?utf-8?B?ZzNRL3l1Q2JZbEIvYWN4dTlKUWJKTzFHQzg4Yi9ldEVPUy95WjRnay80TGYr?=
 =?utf-8?B?TnhsSTg5cW1Tck1XdXdlZGNNVUJwNHVkOFIySjF2dUdOWUJ4VVFpbG0wL25w?=
 =?utf-8?B?N01tMWdmLzAvSDRnNHhTNGZxYkJ1UkFMcFRCa1ZPdkVreGVNa0ZHRnhYVnZZ?=
 =?utf-8?B?Z24xTGlPZWVQYyt6d3NlUzNrUSsxQkQzdVFnTHdodkRZVXpLVGNHeGZTWnZG?=
 =?utf-8?B?NzdYeUFldmZLN0VKL2EvRE9WZ1ZJL0pvdGtnY1FKT3U3Q0FEUXlqa2ZPNmFM?=
 =?utf-8?B?eS9uQW4wRXFmemEySzdnSFkyZXd2WXpwNEJPdlJrdHFMR1V5LzNVVkd3cUxV?=
 =?utf-8?B?d3A2d2JDZk05TnZKa2RsQ01YYTUvajlLZkxWb21VQ3JQaWtsL3pwVHowVVZi?=
 =?utf-8?B?Q2hLelpBL25kZEk0RnVKTHJqVEh1dndLcTljRHdWcnk3SWN3ZXlucmk1VnVn?=
 =?utf-8?B?TXI1cXF1V0VITWR6YzhPTmFCNy9sRjhKangwaU8yM1RDanNRaXhmbHUzVllu?=
 =?utf-8?B?c3BBMGU2OE4va2pTNDNPY05uU21jRmN0ZEE2bi9EeE55SGFDeUwxMDBNemds?=
 =?utf-8?B?ejJlMzgrSEZUUC92NS9pUFhlT1piNzM0WkNyT0Q1KzBiSDYwek5UcjhFY205?=
 =?utf-8?B?RFFWczNSamlUdytiTG9YT0JIMmpwSzhMbkpQcjJaQU9LeWJnN3RmYVUyVzZ4?=
 =?utf-8?B?cHpFWFRFcWNkayt5a1BLcXhmMzA0T0tzN2Q4RzVvQ1d1eG9zS1VSS2JyV3dW?=
 =?utf-8?B?TkRvNDh3UnAxS21hWlRCalNpLzhLK1p6eDNTSEZ4SGVVRlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHo2b2xyMWE1TDZFdFFBeDRNRUhBVWN2b3JBQ2JDNWtqQk84ODRBcjJsL0M1?=
 =?utf-8?B?UWRyR0dhdnRpOVZKWlZ1UTk3aWltU01WdkVTdnI1V3NTVlU3QUFZOVdPcTAw?=
 =?utf-8?B?WHdPTzVybVJoTnN3bGJQNTNUZ25xSTlaMXNmUVlCSkxTc3UrdkR3Z2E0SGx3?=
 =?utf-8?B?cm5iamVZdVhxc3pKKzB5QThtbk15aVNYM1ZqbHJyL2NwLzRhTnFFRWczcEl1?=
 =?utf-8?B?TGRmaEYwMnQ1T1UzRFd3Q0szS1ZTSHY2dU4yek5aVVd2MHlUNHJJb0s2UExh?=
 =?utf-8?B?WWxKWHUzR0R2MlVrOENTWW1LUmZoTU93RTFWQTdhdjU1UkdnM3ZYV2x0RGhM?=
 =?utf-8?B?aVdyT2tYTHZzMGdrMWdMQ2dnQTAwZ2ZGYTVnVmNFSm03SVpBOS9kR0poLy9S?=
 =?utf-8?B?VWYvaHczQ1QzRi8xS0pxclNEa1FVM01POXRkTGcrcEIxSXlvc2VBMWNlNW5w?=
 =?utf-8?B?OVk0djV6cDczbVZyakYxakpCVmV6UFN1MU4xNVZHcXVZNkhJWVN1OGVvdnNX?=
 =?utf-8?B?QlpIUTU5WkVGckozYTZmc1RLVFEwMlBnQWV1ODN0WDZod3I0ZDBRdGZOMjJy?=
 =?utf-8?B?YTZLT3RnTDloMXZqNzN1cnlQZkYwMEJRdUI2UVpLK0cyYmRCcXdhdW53U0Iy?=
 =?utf-8?B?TVZ1eHY3Wk5WVUl5VG9Jb3F5VU1TSTVEdlQ4K1RwakkzM3lyWHZuU2RPQno4?=
 =?utf-8?B?TmdBM1hoYXBoaTJRM0FqcjhrNWJYanZNS0R6Ym4rM1g0RnZhRXFhVEZSRDRC?=
 =?utf-8?B?TytBQklKNzFkbSswNlhwakhFUHFOZWdQbTNlZ2lITFBHVEJqVHpnYkJpRFlk?=
 =?utf-8?B?QWs3MjYwdG1aa3JLemsrdmNhRUxtLzhZQm54KzNzTDdCdzg4Q080TVl4ampM?=
 =?utf-8?B?Q05zSVpwTmF2RnZ5aVlnd0Y5NzNLeHRzU2ovWDFTYWVDOFFLTGI2MGgydmE1?=
 =?utf-8?B?WW5WK3ljN2tIempUZTVEd0FWS0g2dFEySnRwck1MY0M5RWVhNVAzcVJsQkJG?=
 =?utf-8?B?QlhqeTkrQVVQbWNLbVdmckRRQnNhS2hQZ1g5U2dkcTZ0Rm56OVZwYkwyaG45?=
 =?utf-8?B?RUozLzlZdGRoaE9QRGN5dy83L2VwM0ZRV3d6c2IyM2cyT3NZUG52U1JOMzdr?=
 =?utf-8?B?elptRFAxVi9GcTRrN2RBTHNHL0FpOUh4dzA4b3dOMVo2ODJVWFRaREZMdXIx?=
 =?utf-8?B?MXk4S0tlSHdsMVZ6RlhvZnJ1Si9haVZDck1zRmJUZVhRVzZwcUZxWDFRS1Av?=
 =?utf-8?B?SldwNVJ5OFI3b3JFK1N5aFROTDdxb3hBZi9iREd5ZW1vR1ovTGE2NEREbThq?=
 =?utf-8?B?cVh2cHpTdE5wZHc2M0pwWHFrZHpBT0pRaVZUYW5mU2JzOC9oNGtxYVBUWmZq?=
 =?utf-8?B?RitJbmtIYW5WYy94VElsMW9wMnVQVzFFRW9RWjcrcXhwK1lQTTBZY1RQRVZl?=
 =?utf-8?B?Vkl1RVVIc1g2MDdXaFU2S2FYYUVGbW5Wc0VVMXBIamJvYzdxbjlqZDRpTW4x?=
 =?utf-8?B?QkV1M1FnSWU5NnpLcU16cVRUckJyUVQwT1BrazFrRDRKNG5XWjJxZ3hPbEtP?=
 =?utf-8?B?RDZDQVNqenBINTg4NXlJSHp0S2hqMTdTaHJTWitXdHFaWlQwWXhVTFMwSUZH?=
 =?utf-8?B?Qk5ZVjdrQk9EY0VFbTlOWnFxZ0cwZWZvT2dEdVNsWDJXdUhBaEJkVDVNREpS?=
 =?utf-8?B?QjA1UXZOdERNMkFpdGk3OU9vdkJVQ0s2dFVhdktaOE5YN1JFemdEbXVrWTgx?=
 =?utf-8?B?ZTZ3RFE2d0ZXdVRnNHNQU2JYc242WUZ0MnhQbG43MXFldm9GdXFGbE9iSVhF?=
 =?utf-8?B?ckgzeGloaUdjbE9OZ3JqWTZCTWFaYjUrVUJOdEc5UExhTUgxb1l1eFFkV3lG?=
 =?utf-8?B?eTdmS3UwZy9oempmb0E0WERycnlLQjNUaUZUbXc3eU11WjdZSFZOYjh4Nm1T?=
 =?utf-8?B?S1czMG16bGptYTYybDZpdGNQeU5KZnBDN3NMRzZPOG13OU5JbGtncFpWS2sw?=
 =?utf-8?B?TlhtajJ0bkZISGt4ZHVMOEtsWnE1cE9iQ3VwanFvODF6Smh0bmdvSnd1cEx4?=
 =?utf-8?B?YW5kTDJxVXBmSG9sN1lQZlRJcFRqcU1XQ1liS2hFdTlscytIcGNSTWg3NkVW?=
 =?utf-8?B?L0gwQ1A1OS9ESFBtUSthNk1vb0h0d1dQeXFlbk5yVy9LMFVtNndIS0FtZHUy?=
 =?utf-8?Q?V1Na0Z/Q/QCyZqxVEvB1DAc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F584D2A8FF6EC34ABB44891A92388AE9@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744455e2-7b81-42f7-cb84-08dc9cafc67f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 05:03:14.3045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7m3klPVSBX3HjG/kjDR1oueGRIkxhhgp6htD3geYCyEg02UArdrF7JTRer6R0eyrO6SjCg6611DHhQrdhtP0hOEI01ZX2kXLr4zOu/F4qXC3JOaesvho6TbwkHa9p7BU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6542
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
bi5jb20+DQoNClZhcmlvdXMgZml4ZXMgZm9yIFZULWQNCg0KVGhpcyBzZXJpZXMgY29udGFpbnMg
Zml4ZXMgdGhhdCB3aWxsIGJlIG5lY2Vzc2FyeQ0Kd2hlbiBhZGRpbmcgaW4tZ3Vlc3QgKGZ1bGx5
IGVtdWxhdGVkKSBTVk0gc3VwcG9ydC4NCg0KdjMNCiAgICBGUkNEIGNvbnN0cnVjdGlvbiBtYWNy
byA6DQogICAgCS0gTG9uZ2VyIHNoYTEgZm9yIHRoZSAnRml4ZXMnIHRhZw0KICAgIAktIEFkZCAn
LicgYXQgdGhlIGVuZCBvZiB0aGUgc2VudGVuY2UNCiAgICANCiAgICBNYWtlIHR5cGVzIG1hdGNo
IDoNCiAgICAJLSBTcGxpdCBpbnRvIDIgcGF0Y2hlcyAob25lIGZvciB0aGUgZml4IGFuZCBvbmUg
Zm9yIHR5cGUgbWF0Y2hpbmcpDQogICAgDQogICAgUmVtb3ZlIHBhdGNoIGZvciB3YWl0IGRlc2Ny
aXB0b3IgaGFuZGxpbmcgKHdpbGwgYmUgaW4gdGhlIFBSSSBzZXJpZXMpDQoNCnYyDQogICAgTWFr
ZSBjb21taXQgYXV0aG9yIGNvbnNpc3RlbnQNCg0KDQoNCkNsw6ltZW50IE1hdGhpZXUtLURyaWYg
KDMpOg0KICBpbnRlbF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0aW9uIG1hY3JvLg0KICBpbnRl
bF9pb21tdTogZml4IHR5cGUgb2YgdGhlIG1hc2sgZmllbGQgaW4gVlRESU9UTEJQYWdlSW52SW5m
bw0KICBpbnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRjaA0KDQogaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgIHwgMiArLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDQg
KystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuNDUuMg0K

