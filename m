Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B68C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 18:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbPHw-0004GF-Ax; Tue, 06 Aug 2024 14:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbPHn-0004Ca-1J; Tue, 06 Aug 2024 14:51:55 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbPHj-00014z-E2; Tue, 06 Aug 2024 14:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722970311; x=1754506311;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1E3ecCBVLKAYaTZ0ICAuwpmjQOtEZ+fLl9phbHDGtmM=;
 b=iUok6fJ8vyvt+shWtXi28/uWw857OpnYWSW9vlwAdAwVoOSPgD/6GyK7
 6JYLolUcvIEpIY/sCL5kLlxESYeqRt2PP70jL5OoGgAyR4OVrG76+umBq
 yc0PlPQuQso6/yNXcBumTvLiP+uOhRYML5CQ3dJZLQOYfeFpcnVaeDNJD U=;
X-CSE-ConnectionGUID: /uXhmm2DTD+aYsveY6hLXg==
X-CSE-MsgGUID: zwy2l41aSqGKZAD45OiBvw==
Received: from mail-mw2nam10lp2040.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.40])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 11:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1wdHq3Hsqs/CyA6s4Tb+2kzsBOXXZ3V25xgjeotVoH0otn3iWSrNzNshUjKjyhaIfk3K2GBQQFAYZAo2gpTe78y+cZYSSAg5zws0zAcdwzWTtJiX1glHKGFR5A7lID6YC7Jyc1htiWHKdFz/5lu1FA91+IFoufPMb3sPAKZUzCzlFu4ynNUEJuqucEILVjYP9T3OsFF8q5uNPbWBRaUvbTzOLbeeDh3h9okY5Rq5kUSsKRU/3zeqbyNHqtkb/3RjeqB8e4oKwStEDmUQiVtVgdRXrCBO1Fk2ggrefhVRG4DCxRHHdEzP/sN09evh/uO88nNq23Zcuq516afCpmJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E3ecCBVLKAYaTZ0ICAuwpmjQOtEZ+fLl9phbHDGtmM=;
 b=LzneNH4FRMtFWOjHxYtPPjHKEdjQBIZ0KkV0d7oyRN6rXLstHaQ9z+UVc6FjFBCqBeAPO6y+9qSTRr9IFJmX4Q4AUhOuVagA5ExIs+qN5vyUvvj9YPNkSXGy9ukt6oQzA3ibJiT+sBDtK+8Ez1cdDRs/sJSFIPG7gvUK8IjVTqYcsrDxouN15hKXu/5yBmzWID1cDmMRUsz4WWR1ytgE6r/EilbaJ2UYFPbZCsUeMYV0u26zfeMcRgKPx/EYprWfFu8g444KH7OqSH2V3jkeeRNDtjsNJyIKSH+8vLZY72rKvL2udS6m+n7CCBJnFz6v81WrvVCleD4YJ3weAA66bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E3ecCBVLKAYaTZ0ICAuwpmjQOtEZ+fLl9phbHDGtmM=;
 b=BpulkSPbXBFsVOmIEdedj2F5nfSMgwS3L4BIbAWfvFpc7aC/eFmg9npJsNs7rb+9IgOR7rIfw5pyB3l1ZDPy9iuNtIIxYyVv465I6+WA8tmf0Pr3EjYtpYRBE4dMGjGgizuknDXP1D6QYFlXqZFbbQcVUIs7xEvxrDUHGCdrhkc=
Received: from LV8PR20MB6853.namprd20.prod.outlook.com (2603:10b6:408:203::21)
 by SA0PR20MB3310.namprd20.prod.outlook.com (2603:10b6:806:73::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 6 Aug
 2024 18:51:42 +0000
Received: from LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad]) by LV8PR20MB6853.namprd20.prod.outlook.com
 ([fe80::30b0:8e2a:9ac:20ad%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 18:51:42 +0000
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Kris Conklin
 <kris.conklin@seagate.com>, Jonathan Henze <jonathan.henze@seagate.com>, Evan
 Burgess <evan.burgess@seagate.com>, "clg@kaod.org" <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 00/12] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Thread-Topic: [PATCH v3 00/12] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Thread-Index: AQHa50+EyDwu6yuLd0SHwrBFVoEkVLIaYr6AgAAwjaA=
Date: Tue, 6 Aug 2024 18:51:42 +0000
Message-ID: <LV8PR20MB6853561C6468584E43D01D85EFBF2@LV8PR20MB6853.namprd20.prod.outlook.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
 <ZrJGzxtvzJ49aGln@redhat.com>
In-Reply-To: <ZrJGzxtvzJ49aGln@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ActionId=e98d89e8-45c2-4349-bd0d-45a8267765cf;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=true;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2024-08-06T18:46:33Z;
 MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR20MB6853:EE_|SA0PR20MB3310:EE_
x-ms-office365-filtering-correlation-id: 32dc176e-65a0-4259-22c1-08dcb648cffd
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YVBFRGdjdGhiNy9LcTFQMXRodk41aVVramhZOVB2b0E1ZXY5MDBEYXY0R1pl?=
 =?utf-8?B?YjQ5OWtyREt0cTR3RzROMGxVZWFFbGRqRmNrWmwvdnBsSGtnY3FvUDg3M1dm?=
 =?utf-8?B?eVM3eU9IeTlTM0xoUlBSbjdmaFNmQnRXd0JNUnZKenA3S0JlcmpHd0tHMHlO?=
 =?utf-8?B?WjAvK09FZVlrVk9UTERIRHVkTTlMd0JyUkZTSVRNZlU4WnYyQ2RXajVXNzhr?=
 =?utf-8?B?ZlFoWlFiSVhqVU1OaGcwY1N0bE9JaE43RURyWXcrNS9WYi84Nk1USlJFNEFr?=
 =?utf-8?B?a2YyMW1TWlV0WThZSitRZjZsZlVNR0pzQkZURVFFOHFmYWF6eG5XK3Q3dDNi?=
 =?utf-8?B?dytBbWUrUjY3Mk9MS2ZGam9HMSt5U2ZaZTI4YWV0UmVXNWs5QlZFU0JIMjRz?=
 =?utf-8?B?OE0vK2c0SDRPZWRJWDZ6Y1JKZk13ODZ2MWhBUzVXZWtQRWRuYUpjVE9sOFNm?=
 =?utf-8?B?TGVDUS9LcVpqS1Fvb1dJdFdlRnlyVTN6SmF2dVRFZlloMmxvdjRNMUxLMktB?=
 =?utf-8?B?UVY0OGp4clFIbjRsSUZZU09DRjBlZTRLV3NhblN6YkxXQ0Z6RDRycW4wRW8v?=
 =?utf-8?B?MWt2M0lIN3FaOGxXOC9IRm94U2NOVitEWTFKeUx2SU1seUFTTUs1ZjJya3pV?=
 =?utf-8?B?cm1IcmJDWE5NclVwVFBSOE16WUxndkhNMVdXdzNyRENIVjMveVZrei8vWlhy?=
 =?utf-8?B?UlJMSndNM3huMk9TclB0b2laKzdGc3pHa3YxeUNjOC9EcjVpSWJVeTQwOVg2?=
 =?utf-8?B?L2hGNkJBa3IrV3B6TVp2b0ZoRDJqbFdtd1hSR3I0Q2NtZkhmdHZhYWJKK0ZI?=
 =?utf-8?B?SkJha0t6MUxnUnZESFZKZE94Y0QzTzBFMS9sOE1XTjAxQU1vekFZV2tSWU56?=
 =?utf-8?B?NmdhNTRTTkhoUVhQaFVrZ1NVNHlpSGtPaE5aUGJESURWcU40UUtuR3d2OU42?=
 =?utf-8?B?Sjh4ZHdOY0tNbHpJZzFrNDY2OFNuVUJXeFBDcUh5WDIvSjBZdzNWTFlYZy9h?=
 =?utf-8?B?MEY3RkRXalBMcVdOd2liNWRGaitGTVphZjRsMUlwS2pxVDk5NmVnSHRvT1VQ?=
 =?utf-8?B?blVHVUF4dVhuMDBZRktMb1JzRzlIY0VvTTA4dHYwb1A4QkVnakFmREVXZ2ND?=
 =?utf-8?B?WDE0ZVcxZFVrVVBKWTN2UTZDd204VDVkZkNZRGs0QklHNzJ3Vnk1MnNzbUZQ?=
 =?utf-8?B?bGZHK3J0cjlyNVI1QnorZTZTV05xc3VvSjBIUXprSlVTQ0Y1U3JFVVg3SDF6?=
 =?utf-8?B?cWdXcHE1WEo5Vzh4OGZNVElvblFMK3IxMGJpTFl1Q01qbTFwRmZETmZBSjhh?=
 =?utf-8?B?STd1ZWsrL2Y0L005WlNqdHRMVzZSNktITFRUSWNQc3k2U0lyWmRBbkV5Wk9Z?=
 =?utf-8?B?M0x4SmY1RE1OdDloazIrRXBzcEErVUFUZWQzNmxRTjZwL3l4eG8xSDBOMk1C?=
 =?utf-8?B?VFpMenFkL1ljdWRjelJ0MVB0Y1BNVVZmcjFuc0Q2dGRUbWxKd3hLeDF2Z2hT?=
 =?utf-8?B?bVVvRDVqRDcvdWpoc2ZlQy9JNHljT1Bid0NTRzlVYzF0a3ZtR2lYV053N1NB?=
 =?utf-8?B?RHFuV0VMYmNwNlNnZHVvc2gvWVhJU3p2K3BoeWJBZm5YNVRXQ29rRUFFSWhp?=
 =?utf-8?B?WGNwaFQzK09iT2lGNEtHenNHUFpCWWFQUDE4emFhQlBEbisyNjdZdTErYmdt?=
 =?utf-8?B?Ynp2aTFPQ3FQclB0emhmaWxPK1hhUW56dnZGaEpyQUI0cnB4K1dxMVJlQzda?=
 =?utf-8?B?VHZLc1N5RnBBWnVIN0JHd3pYZjMwY0NYWDVONWh5NlU5bHREOXhYeGN5Mklt?=
 =?utf-8?B?WU9LTU5WUjFUOEhZWXJSVWpTc0xtTWp4VlVTajltZXJaaDk5RHNqU002NFIv?=
 =?utf-8?B?bUlhTElrcTZVS2NCc3JvbXhobXRtekp3VW1WZEpoL2RuN0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR20MB6853.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZRR2o0TElMSCsvQUJpbHhzZFhVSFAwM0I2djJhNVV6Y0svNm1ISFU1Z3cv?=
 =?utf-8?B?MWFuYW9UdndCeFo1bW1vVnMxMnVmWFFOZk5kY3AvMWVFV3BwUXY2bmc1ejZw?=
 =?utf-8?B?L1k5amNTZ1llRlA1NDVsc3AwNktEbjBmZlZUcTREak5Ua1VSSUFISHZHalZO?=
 =?utf-8?B?UFplT0NGR2RNWHc4Z3g0ZDlmZ0xIRGEzNExtc1dDbmhlYnlMaVQ2MG9wMW1B?=
 =?utf-8?B?ZUIyYkFsdmtQZ1BBbnliY1FZalROR21lYlREMjdMck5PV0hKTW1PWnpOM0Rk?=
 =?utf-8?B?MUtHQjQwSUJ6ZW1KeDQxd1ozdDd1MXYvaFMvSElleEdXYjByVDU1dmpuU1Fl?=
 =?utf-8?B?RXI3dGU3b09sdHc4YkJYWUhoUGhCUFlsNy9jOXJoVm1pZnlZZ1JSVEltZUkw?=
 =?utf-8?B?VEJRVW9PZHovT0h3VzZBVFRDcFc0OWtvKzhka2FlOHlNWHdYQmRjUmZ5a3Vw?=
 =?utf-8?B?dGY4TldUcTIxdDFaaVJuSzJocHIrSDM0aFpxQ0ZsbEFoQUJpMXdjTzArb1VW?=
 =?utf-8?B?M3hRMUFET2FWVGtadkgvUGt5ajlaelN4bEc1Tk92Rm1xU3phZC8rajZYditr?=
 =?utf-8?B?MFVJeDJzU2tscFQ1RG0za1VFeDM2M2tLcHpDN1BRLzJYVGVYY0F5MGpVMVRp?=
 =?utf-8?B?K21nZFRYaWcvRlpndmhPclcxUDBqOWtZSXJ0ZzhaZnlZOVV0OE03cCtrMVBX?=
 =?utf-8?B?VjNYRWlnM0dndDA0NDkrYkJsY1ZjeHJYSXVEbzllWW9sSkg2NERGTFhSbFkv?=
 =?utf-8?B?VGJLRWpFR3JsNmRVb2RGSHUwT3ZUQk03S0FYWHFBQVY5Y0UrQVZPNWlqWGF1?=
 =?utf-8?B?emlyeCt6d3NydnZmVm9NTEErVWlqYXcxd1ZxQnFpWHpxSVlzUlQ4eWJRRUtZ?=
 =?utf-8?B?aUY4NCtiaHNOTHkzK25ienYzV2VqeWRGaVdhR2d0MXlwUCtpKy9ZQ0tjaEtB?=
 =?utf-8?B?c2I3ZlU4MzBua0JiZkp6cjgvNkZEZHA4dVNHYlBwRElYM3UxcWx0bWY4QjBl?=
 =?utf-8?B?R2JYMElZWjcrUC9RWllCczJiMjBlYU1sMUF4Y3RsaTVSVTkzR2JFU3RLOCtx?=
 =?utf-8?B?STVpREFpQVdBQUtXTXVKUFg4RWs2T2JIWXI1WFpab1llVVNqeDR3YWNQYkhR?=
 =?utf-8?B?bEJlaWVleVJId2VXa1FIcmhUQk92VmNOSG03U0dsSFpQTWtPRk5TbkJXVHNO?=
 =?utf-8?B?NEtyVWxmQjBhUWZUMis3cS9Ea2ovVEMzanN0d3ZEc2I4RDJ5Rk5BZnVPV1c3?=
 =?utf-8?B?TXFiQUh0SEowR1pEdC9ST00xREFUV1IzdXVsSUF1Q3d1K3ZWeWliYnVhWE1k?=
 =?utf-8?B?eFNGayt4RnpGRnVhelRPUzVybjdxcStSYWw5MTJzRU8vbVpyZmpCa2FlNDJa?=
 =?utf-8?B?MmRXeTczWDlMdUdGOFBvRHQ1d1o3dzJOei9Ib0NJVFYxOTUyMDNVYzRzK0lX?=
 =?utf-8?B?M1U0MFdmc2FzSTBwYkUxTFVuQzQvVFBtOFBNeWJ1Z0lsVC9nOXBYZmpDQTZt?=
 =?utf-8?B?ZHNhTDZJSUJRUnIreW5TMGJsU3c2KzVESVh6Z1RlNXJrNkt0R2Z4bVlVUE9u?=
 =?utf-8?B?Tmo0RGNTNWtQV09tVTArenRrU0h5YnJXbEdZbGE0cDNsL3dEem1rV3NFdHlk?=
 =?utf-8?B?R2dNVlZHUHlFK0pDSzF5YWFaZU1kNFlQbXRaenhpYzI2OU81dUFGTERSRFUv?=
 =?utf-8?B?R0VzbXR2aDhDeTh6UFZCemFTejhjZG9NUSsvc2VrQTN3eHI0ckJVUGJyWDBC?=
 =?utf-8?B?Tmx0b0FFRXF2SWNIZ3BKNGxqYk5yaDJNVm5neVQwd1l0NkliNTdTVjQ3MEJ6?=
 =?utf-8?B?ajdNZWhadFpkQlFwcFdmM3c4aFJOTFFvNmJXdThqZWxnSFpCc3c3V3ZYUTJC?=
 =?utf-8?B?Ry9ZZDNkTG5GbzVrcTBQd3pITUtOTUlxNGRydHcrZVBZL0t2eXRGNTFjdTBt?=
 =?utf-8?B?SlZ0SkU0eG4wQitOR1BXaFRiK1ZLdnVpdStkaHRsMFk4Q0p3cmtRbE9Fb1B1?=
 =?utf-8?B?Rk1KZGcvcE5SaXNLNnNIQnRGeWgxbnFmN255N3BnM0lPT0oxdXhBbzZGV0VX?=
 =?utf-8?B?ZmtHYzNtc1Q4ekJvcDZmUWNaQVdtc3ZRK1VOSEJ4azNjZW1scWdOT3RtMGx5?=
 =?utf-8?B?dGY4UnI5NmtrTUV1c1lpbG5tWnRBd25ITis5V1krMzV1OFMrSDA0dVBTRWRB?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GPctRxHHo/gPX2AkcSmaxmVSQTY3aEwcLTnuhdUsqSV9SzTUuF3hOfsDPAOHZ3XrScx8rMSaPgMD3hIzP5C21QpdIDrxsZPRYybaMwCPf6g+Bo4RqOEvF5MO9/j/UBsK7C0GbVOijZmJhvbD488NhFkNeb0XKdEm2dvHI1ILi1ld6e+KSUFWitT2qgbz6fVFZdKFMYR2qrUGBomZMyxw1KIRSiNeqI679a7mZWQqGcUyMX8avpj7lykIZXwhH0qXe9ThS4I++4X7PO2ZV4imcAl5xwVLYQhufhxNPmGWG0rX7YIFEUju475btRLoJQCfUzpc5JQGW1IzoQ735ioy6YxfYTfj33PpVOucUmU0mF6M9gYYNvEi87YJThzFw+MEG+KmxF1wcbRnvrA/GXFoNAFibshd2Y98nJHhj74GQ3bFeezke36MXfsUkI1VEGebpFzawqJfA8S35152nfd9Ls/dgXVlsAGvbFauaHgK1hUBrhSbvxrUzMlxUOvWJHyjLJiv09AioOPYiOFzOuO5B8IJ09jLKtAc2eNBxuTMN/O3T9xSq0WB4iJrbRvNHXcXOstHVc9uFjcD/oVL9EAtNjdIq8WronJ/79QK9JGZSt+gQQgXanBi2J6v/Zi9Vit+
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR20MB6853.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dc176e-65a0-4259-22c1-08dcb648cffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 18:51:42.3096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aClE88pW+PURPRZtf3CqV9WxDlQX/0mGK5jA0fGwZ+hePLKNLNxZ49pOPdoxGXYnizO0OD9467RgQEsT9VW1uiPclrYrP5acHPEUSbLv+yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3310
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

PiBUbyBhbGxvdyAnbWFrZSBjaGVjaycgdG8gc3VjY2VlZCBhdCBldmVyeSBpbmRpdmlkdWFsIHBh
dGNoLCB5b3UnbGwgbmVlZCB0byByZS1vcmRlciB0aGVzZSwgYW5kIHNwbGl0IGEgY291cGxlIG9m
IHBhdGNoZXMsIHRvIGJlIG1vcmUgb3IgbGVzcyBsaWtlIHRoaXM6DQo+DQo+ICBjcnlwdG86IGFj
Y3VtdWxhdGl2ZSBoYXNoaW5nIEFQSSAgIChvbmx5IGRlZmluZSBuZXcgZHJpdmVyIEFQSXMgJiBu
ZXcgcHVibGljIEFQSXMgaGVyZSkNCj4gIGNyeXB0by9oYXNoLWdsaWI6IEltcGxlbWVudCBuZXcg
aGFzaCBBUEkNCj4gICBjcnlwdG8vaGFzaC1nY3J5cHQ6IEltcGxlbWVudCBuZXcgaGFzaCBBUEkN
Cj4gIGNyeXB0by9oYXNoLWdudXRsczogSW1wbGVtZW50IG5ldyBoYXNoIEFQSQ0KPiAgIGNyeXB0
by9oYXNoLW5ldHRsZTogSW1wbGVtZW50IG5ldyBoYXNoIEFQSQ0KPiAgIGNyeXB0by9oYXNoLWFm
YWxnOiBVcGRhdGUgdG8gbmV3IEFQSSAgKG9ubHkgYWRkIG5ldyBBUElzIGhlcmUgKQ0KPiAgIDwg
Y29udmVydCBvbGQgcHVibGljIEFQSXMgdG8gY2FsbCB0aGUgbmV3IGRyaXZlciBBUElzIGhlcmU+
DQo+ICAgdGVzdHMvdW5pdC90ZXN0LWNyeXB0by1oYXNoOiBhY2N1bXVsYXRpdmUgaGFzaGluZw0K
PiAgIGNyeXB0by9oYXNoLWdsaWI6IFJlbW92ZSBvbGQgaGFzaCBBUEkgaW1wbGVtZW50YXRpb24N
Cj4gICBjcnlwdG8vaGFzaC1nY3J5cHQ6IFJlbW92ZSBvbGQgaGFzaCBBUEkgaW1wbGVtZW50YXRp
b24NCj4gICBjcnlwdG8vaGFzaC1nbnV0bHM6IFJlbW92ZSBvbGQgaGFzaCBBUEkNCj4gICBjcnlw
dG8vaGFzaC1uZXR0bGU6IFJlbW92ZSBvbGQgaGFzaCBBUEkNCj4gICA8IHJlbW92ZSBvbGQgYWZh
bGcgc3VwcG9ydCBoZXJlID4NCj4gICA8IHJlbW92ZSBvbGQgZHJpdmVyIEFQSXMgaGVyZSA+DQo+
ICAgaHcvbWlzYy9hc3BlZWRfaGFjZTogRml4IFNHIEFjY3VtdWxhdGl2ZSBoYXNoaW5nDQoNCkFw
b2xvZ2llcywgSSB3aWxsIHJlb3JkZXIgdGhlIHBhdGNoZXMgc28gdGhhdCAnbWFrZSBjaGVjaycg
d29ya3MgaW5kZXBlbmRlbnRseSBhbmQgdGFrZSB5b3VyIG90aGVyIGNvbW1lbnRzIGludG8gYWNj
b3VudC4NCg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2ssDQpBbGVqYW5kcm8NCg0KU2VhZ2F0
ZSBJbnRlcm5hbA0K

