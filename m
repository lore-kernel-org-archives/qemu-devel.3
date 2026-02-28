Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B8AFEE4F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 18:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwP4o-0008B9-Ry; Sat, 28 Feb 2026 13:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vwP4K-00087J-2W
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:29:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vwP4G-00047f-P1
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:29:35 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61SDxIxJ2698152; Sat, 28 Feb 2026 10:29:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=corkszz69YweWo+3UlGhbSA064vRWOy29jbQuBZzI
 J8=; b=N2lSOTSpiO/7i36b1ZTXqYjZiVF3Br/JvVgddVo9xK2rGfNM09OttdpM1
 8jraL6KArDECRmPZdXIfvvq3X3ZvJhtjf3MUPv/NpWC3MiCS/0Fb1zEnctSH0iqB
 YybPGbhBewDDUU5hWVn4GF8FYmHV7cwRtoN3ZOQCASshVXzBoPA8KhV7XbfxGbTW
 tWgQx9xkbZr7PvnPAYJjPKrk01RJPI8Yf1KwQA6SeK1HMb+ggeB9o913xlxdwy1m
 /+q13AhGrqHyt2w/7Ka0+0Enn22LjWxyCA56INfFhdKWyCVpzSlPOZVXLBm7BMk8
 84mH1CdDCYLu8BN2nKsB3s/6qJCNg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021077.outbound.protection.outlook.com [52.101.52.77])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ckw550jyd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 10:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs2eJogkhx2lvEqb3lS6vG2owgMOI8Zd22TGps/RgijkdewLstC5mHzHY+LKYi/KshjfhRZb+jDPLlaIcZJuR3TDzVTHQSBUI8FV370ER5Ux5I4ROhTF4MAqqBwDc6D1iynWKMGheYb3RWmPVA+5YBjdbISRvE2ssLJ+YNVhjaoJ5qMny1SNPwE1NZTxn5kUlDy8rHeoNZVd5DyK1NxSg93ZZ2idflRDsDsgSEBsGE13XbUlij/0FOOwd3SDNBfAOcrOaAZvtQrmYdR58AwP8RYbqzMr3xu5HBIIZpj8rfoPhrV4NU5v7YBU5+OJaT9UD4tBCF2mwnP0pp5wHTcYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=corkszz69YweWo+3UlGhbSA064vRWOy29jbQuBZzIJ8=;
 b=Q/upu0eKr7myTVaORWNGnftcqtaqRvN5FesoTIxOP6n4e81gzQZn30A7xpTIEzXNP0/fVNbyoPxEzp8aWaNf/msp74ySkeF06BlhuXC0zdwnS2bdrvk9B0dU6DrbHWc9IraZjY9Deykpid6L/56EnQTehtd9L7kctJ7Ddoasa2rAHEfcK4H423xHdifovLSB6Ebl2RGUl8Wjfwbd8ukVAJZSgopWLuD/ikNwhbIRe/vlLXR95zAEguANE/ngWiBGGB5i3meRyCDBU2G6DQWked25gaS5kuB/g1gY4LfbJtI0cO5Rjm6CADZH1E3crHAWUBLTmTSuyvr3E5cNTMPpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=corkszz69YweWo+3UlGhbSA064vRWOy29jbQuBZzIJ8=;
 b=Y6NCz645/o4pXm3QMDlSHuh/uqtoEzICdicAuMmx3jkkofJIe2WPzvQiQpgWP1Ad5t3Jk+8ff1DB/N6ep3Gmu6djSSKLWfeyDVb6t/OzpJMXrN/hc5BIyetwkI5DogBNYytBys397AE5Rnbx9UGVssXOjsYhBGGnRo0Dq2UpicRiL5T/lgZTAh4G++ODR5/78mopVhDZ4helLktS1/o/Yi9f6vR+wT4jKb8Gp+aIsYK5uhg3/H15YXTBnlRAIEmxzA4qMGkYFsZ5rz9JCeEkTAAQuzwvC5TLarY6Uux+L3RCtX4CRBaI0iPkM7z+qPNN0oJwU1yCtrk/FEED+RUzKw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by DS4PR02MB10867.namprd02.prod.outlook.com
 (2603:10b6:8:29d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 18:29:26 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 18:29:26 +0000
From: Jon Kohler <jon@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] util/oslib-posix: increase memprealloc thread count to
 32
Thread-Topic: [PATCH v2] util/oslib-posix: increase memprealloc thread count
 to 32
Thread-Index: AQHcTzUXkYZstMSMGU+AFq1nGDZ0kLTlzKwAgB+V8ACAAADWAICTvmyA
Date: Sat, 28 Feb 2026 18:29:26 +0000
Message-ID: <C99876D1-B5E3-4AE6-9953-401A42D3231F@nutanix.com>
References: <20251106163143.4185468-1-jon@nutanix.com>
 <aQzEjov7dGPQeR3f@redhat.com>
 <FA4A9CAA-F033-4F1A-8197-799913A65DDA@nutanix.com>
 <aSdEPK3U6B_9gSKV@redhat.com>
In-Reply-To: <aSdEPK3U6B_9gSKV@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|DS4PR02MB10867:EE_
x-ms-office365-filtering-correlation-id: 6a630071-daa7-4248-ed2d-08de76f74d70
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: mdu2QrgD1s4jk7ZK1LxmzKxjMhRUQktBRiNLd9erScypZBGGMQuwrMY+9DZf3jLGhgjflFus6vkdWg8GVeuAU1vrn22iWf5L0Tk5xqPVY404HtDzW2F3tlcHZgFJdGMkDZGj6XuM820zjmJ63p6DSLUdzZuhzfAKe2mHE3L8sI6RnvJsHtwqJ9QnAzYoBWjXH6PiGcnJW6EJ6GwM+IFbOKtT8xwOrHmaTD7BRC4Zy04ik6ALoRgMCqDDsM1b9L20wKbSzODnvLTPfOaKcTD5dWJQb4jsP2B7P3PhE+NV2q1RFquU25J5oJnDUVnmw1tqZK6phIgA2JOWW4c2P7NPUDd05cTzGzfzcJeML7fHp6scgn2siI+xfrsExOn3WcuTm4tsefkSpz1duYmz5p4wZdHza9XcWCWdEIQkzYemHEpK4nybhFbTmf7jth42JGGgKWy3d0XSYL6gFw7Ur5dAWm9C860rau4f59oWSF9a6oYyHwFM/KkMcWleprrF15fAvoscHNzgljoFBnUmRYXIwNrOc1nJm8YWyvzXoXt78S5rW95aI3/Vovs8pg2FBbmb04fZV/hBfhZw/sQKBG+wskXaobxs3SQu8ijijwgvF/dPMosU1MH4Rx1PmAVIYU9EfxSzlUcyovgfVAYQYZsknxz7GpYlWUL46e0DqvF/go0mbRiHegrpE17J77LmQtjPXa313/4s2pEj3YqbP+N85qDvWwQwPX+oxa6tFKc+b5fj+DT/Qa7oXX6F3WSCtMkgzAm/5/4cP/oeBTGbdE3L+ki6n8ej/UndQPI/7HRZCEQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDVIWUNVQXR2UWh5RFg4QkpKbUtkZ2ljOEcyN1EyMmJLYkUyOFN1NjJsQ1ll?=
 =?utf-8?B?N2YxNnlHOUsrYVVLM0hvOGhMcjNaaVdqZ1JNY3NQR3RuY08rU0dDTVcxRmtl?=
 =?utf-8?B?bzA1ZEsrT1crUW1yTGFvc24rTkNjK2o0NFFiYngxWVZ3SXRWdE53MzNiK1k1?=
 =?utf-8?B?djlURUtueHlJSmNQYjUwd2VjU3dueWJYcTBnWDZRaGRsYjBtSTNJcVI1Q1ZO?=
 =?utf-8?B?OGV2Yi9tYkFoUmhEN2JWdDFuYUx3QXIwT1JtMTkxekttWitFRXlndnk5Z2FY?=
 =?utf-8?B?aThXdzhPVlBEc1MwV085WnVyZ3B5ZnR5eUdsZE0xbGJaSSsxOUppTGl4T1ZW?=
 =?utf-8?B?WlJEeGhybyswaXFrMzByV2ZaNmJGR0RQVVErbmZyNXZvY3RCSm1ISHBKYjAv?=
 =?utf-8?B?NkFQRVd4ZVFhSmxmUzFWSll4UTJlY0VSR0ZIck9rMExRZDcvZDBGNThVVEtE?=
 =?utf-8?B?Qm5WOTNuby9DU3VuLzlDQnkyYitJUVc2UmJuTjV6MjlHZUs3TWNpZjZ1VE5B?=
 =?utf-8?B?dXJVekd6TklpNzhNWXZ4b3FhcWIwOXBaVmltZmVZZy9GNnF5Y0xkMzV1NExw?=
 =?utf-8?B?bGRiR2JHWGUyTnVhN0NBMWlUb3NHbUw4VnRQcDh3Y0JPR1JrMWZaV3NHamhY?=
 =?utf-8?B?NS9aR2dRTlptNFdSTTNnRTJFOXZ6NzJxcDlpWXBHK3E0NXlSVEg2enRwdmhp?=
 =?utf-8?B?UWllSEE4VUx5UzlDLytTaVkxR3kvWlpOaTI3YlE4SVNJMWw1ek0zUjQ4cm5V?=
 =?utf-8?B?WjlxMFJYSFZHVzQyMGpyMlhjc3NoelUvNkc5R2c4SVZYWVFEeUt3L0c4TFVF?=
 =?utf-8?B?QzNhN24xanJmOWoxMFhZUFRYNzNReUZvUHNHeE4ySENWcWQ2K01hZFFHSzJX?=
 =?utf-8?B?cWpYMGw1eFdqUEZ5dVoyT3ZDdEx2bmZlYkxkSmtud3Z5Ry9Ubm1Gb29iZG4y?=
 =?utf-8?B?Y0I2STZWRXhLa2tpNUljVEt6alBKRFdsb0lwTGxRM044R1V0UUZjOUw3M21u?=
 =?utf-8?B?S1NLait4SGhDanFzVTNENTRERnRTeUVmaXV5cFVxR2tTWGR4NmdQMHg1SEdN?=
 =?utf-8?B?NWtLSk54dGI3QTNSSUt1WkxnU2dORE9yWmxOTmdWcmI4NmthMUk4ZUV1Y2J4?=
 =?utf-8?B?Ry9aeUFWSUpYVWtHYU9jUHd0VlBRNnNGQVZCSDBJUExLRlpPSGFBdkhocVRW?=
 =?utf-8?B?TmM0MFVsSTBVK0xORDBUZkNiZnN3bm5rSEJyYWgvd2VGbTAzUjd4b01LWkZU?=
 =?utf-8?B?ZENsdmh4eDlXMmRLVFlrS25JL0RUR21CVGI1OS9qYXBzZUZyQk8yMUNoaW4y?=
 =?utf-8?B?Sm4vMVMxdVl2SER5Syt2NVAwZ1NCVnNxMEIxdUVSVWlUUUltSkVMQTRia1JD?=
 =?utf-8?B?b3FnVW5tczlXMmhzUzkvUDBoclY0OUZ6QWNPMlJ0Y0RtdnpMZURISzhhUHBR?=
 =?utf-8?B?NzhNVmxneXgvUmprR1VCSzlSc2hkMUd3WFUwcXdjbmFyTFZxYWpMeDU3YUhS?=
 =?utf-8?B?dVgyelhSTXZ2TTZwY2VzRHhLYWZ3SzBWSFArWmlVelVVVkZzcTgyaHU5QTRC?=
 =?utf-8?B?bXpxY04zeVNTWFZicGtCTVA2bC9BUEZSM3BlamJCQ2tCL0JpdVBHUzB3QnFy?=
 =?utf-8?B?TXBnYTE0eXBIVk9RazlFSzRpSGtjeTMwN3U1YVQrcE8xVUxIRDlLblBNVXhW?=
 =?utf-8?B?R3N4VGYwMzRiZFB2dmdHQVlnVmtHZm1lSER4RTJQUGdTSDNibnZXcHE2REtO?=
 =?utf-8?B?akVJOExnQTEzZXhaNzQvblVlZGFNMG5wQUZsKy9QRXlNMGRuQ0F2aHBDVVhx?=
 =?utf-8?B?SU9ybXcxSXlkNGFEQzR6Tzc4dC9oMmJWRkloU2UyZ0t6MFZXVHl6Sk45cDBq?=
 =?utf-8?B?RGU2VjhUNXVnRGZhTGFKNUNML0ZGUEh6QU1XWkZEMnAxb0g4YkhaSlVvV0p5?=
 =?utf-8?B?RzFiU2NDM1YxSXlscU9oSCtZUE1zM0x1M2o0V2ZpMnNDWUQ4MS9oTTNLeXpJ?=
 =?utf-8?B?TWFYT29UT3M5NU5lOEY2djVQSDhIdDJzNGNQY2U0UVJYZFVNZEFEU2l0Rmty?=
 =?utf-8?B?ZnFpeTRlRDRLdjdVUytDeGhPUDFKTTB4c0VDMk53aFpaZDBMMDZubnBsK3B3?=
 =?utf-8?B?TmZQSzZlcFFMSFJCcWF6MkhSektGVWJ4YXBLRDlPcWo1UHlqWEVvUU9LUDFI?=
 =?utf-8?B?REhRMkdjYnFqQkV0dkVFRzRFeTBUK2VqRGhuWmlVWHVHVVl3ZDRkNjRqYURT?=
 =?utf-8?B?WWIzTzRZZGxFSDJ3UTZWdHhJWllqdFF4TG1FS2tUb21UOXVUeG1teXVrSTJB?=
 =?utf-8?B?WDRXaWtMbHdrdTJXcVE3YWJWRGhUWjdaRVJuZDJkblgzdUhqR2FFMUMvdmJW?=
 =?utf-8?Q?5xcpNIdqr0tS7c1p5qO15th30C4Glk93RUknlJ+xS9IRC?=
x-ms-exchange-antispam-messagedata-1: YK5TX37hE9TtCdIV+gh8nHVJJ1+8Mz4n5lw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41B95AAFCD33D548A4FC1DA5CCFB38A7@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a630071-daa7-4248-ed2d-08de76f74d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 18:29:26.1163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpnHHIywKyvJjcvE5qMetCyg2RKN4Y4LT9Q1lpfvSv2xsv3f6D4IZrwMpsPD4NCJPBkb4VGFwBaUK7asYfIfpf3TTYjqoEJ8S3ggQ7+lyC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10867
X-Authority-Analysis: v=2.4 cv=bIEb4f+Z c=1 sm=1 tr=0 ts=69a33409 cx=c_pps
 a=gZV5Ef4gw7eWa1hDQMD07w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=kzlQNHmw2IgF_FLC8xMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6oSwgqpeqt0M6UGn0IHnATRGuG_yOWFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDE3MSBTYWx0ZWRfX5QHewJeietDX
 tzSjCuSwyRPKvZszvHE4vUr2YXtElBW24NvjY3/AaSWiOgsaHYtRHxBaHL1rGHiJ+fTa+dyEXL4
 zn7X2FrdrQZn+aapoWCFoewOUNYS6UQFdyuAU7zf6rBP7FKJyP9tM/msrqBlIBllMcEH7ohFR+p
 FlPV9dRwdptHcDqiQ29t4M0WnjE9y/zLQMrqms+CDzodx99DwPaWVqjoEfuhYY2ujdoWUPGzOwR
 8U53JCREusQEHCuNYM6wHL72+BcOkC6b38F2IiZQzt1XigFNxLoQ7Q3VItA4wlwTreJk32vvfEG
 9Zu+Snm/JFINIEFjNX2aCzi/6NcHPW763QkrgmZkd0oSuBafSXceo8J6od+FiqqU1b6AM1uEGMC
 ikD7C4mQNKY4w+7wgQLMAP17N0OIGb45F5m70nCFu9dw4SJWQl3ENyn6qxD6aUsRK0w5UKsI5Kf
 akpbPJiktOmrgMJfXSg==
X-Proofpoint-ORIG-GUID: 6oSwgqpeqt0M6UGn0IHnATRGuG_yOWFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_06,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gT24gTm92IDI2LCAyMDI1LCBhdCAxOjE34oCvUE0sIERhbmllbCBQLiBCZXJyYW5nw6kg
PGJlcnJhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBOb3YgMjYsIDIwMjUg
YXQgMDY6MTQ6NDNQTSArMDAwMCwgSm9uIEtvaGxlciB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24g
Tm92IDYsIDIwMjUsIGF0IDEwOjUz4oCvQU0sIERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFRodSwgTm92IDA2LCAyMDI1IGF0IDA5
OjMxOjQzQU0gLTA3MDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4+IEluY3JlYXNlIE1BWF9NRU1f
UFJFQUxMT0NfVEhSRUFEX0NPVU5UIGZyb20gMTYgdG8gMzIuIFRoaXMgd2FzIGxhc3QNCj4+Pj4g
dG91Y2hlZCBpbiAyMDE3IFsxXSBhbmQsIHNpbmNlIHRoZW4sIHBoeXNpY2FsIG1hY2hpbmUgc2l6
ZXMgYW5kIFZNcw0KPj4+PiB0aGVyZWluIGhhdmUgY29udGludWUgdG8gZ2V0IGV2ZW4gYmlnZ2Vy
LCBib3RoIG9uIGF2ZXJhZ2UgYW5kIG9uIHRoZQ0KPj4+PiBleHRyZW1lcy4NCj4+Pj4gDQo+Pj4+
IEZvciB2ZXJ5IGxhcmdlIFZNcywgdXNpbmcgMTYgdGhyZWFkcyB0byBwcmVhbGxvY2F0ZSBtZW1v
cnkgY2FuIGJlIGENCj4+Pj4gbm9uLXRyaXZpYWwgYm90dGxlbmVjayBkdXJpbmcgVk0gc3RhcnQt
dXAgYW5kIG1pZ3JhdGlvbi4gSW5jcmVhc2luZw0KPj4+PiB0aGlzIGxpbWl0IHRvIDMyIHRocmVh
ZHMgcmVkdWNlcyB0aGUgdGltZSB0YWtlbiBmb3IgdGhlc2Ugb3BlcmF0aW9ucy4NCj4+Pj4gDQo+
Pj4+IFRlc3QgcmVzdWx0cyBmcm9tIHF1YWQgc29ja2V0IEludGVsIDg0OTBIICg0eCA2MCBjb3Jl
cykgc2hvdyBhIGZhaXJseQ0KPj4+PiBsaW5lYXIgZ2FpbiBvZiA1MCUgd2l0aCB0aGUgMnggdGhy
ZWFkIGNvdW50IGluY3JlYXNlLg0KPj4+PiANCj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+IElkbGUgR3Vlc3Qgdy8gMk0gSHVnZVBhZ2VzICAg
fCBTdGFydC11cCB0aW1lDQo+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPj4+PiAyNDAgdkNQVSwgNy41VEIgKDE2IHRocmVhZHMpIHwgMm00MS45NTVz
DQo+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+
PiAyNDAgdkNQVSwgNy41VEIgKDMyIHRocmVhZHMpIHwgMW0xOS40MDRzDQo+Pj4+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiANCj4+Pj4gTm90ZTog
R29pbmcgYWJvdmUgMzIgdGhyZWFkcyBhcHBlYXJzIHRvIGhhdmUgZGltaW5pc2hpbmcgcmV0dXJu
cyBhdA0KPj4+PiB0aGUgcG9pbnQgd2hlcmUgdGhlIG1lbW9yeSBiYW5kd2lkdGggYW5kIGNvbnRl
eHQgc3dpdGNoaW5nIGNvc3RzDQo+Pj4+IGFwcGVhciB0byBiZSBhIGxpbWl0aW5nIGZhY3RvciB0
byBsaW5lYXIgc2NhbGluZy4gRm9yIHBvc3Rlcml0eSwgb24NCj4+Pj4gdGhlIHNhbWUgc3lzdGVt
IGFzIGFib3ZlOg0KPj4+PiAtIDMyIHRocmVhZHM6IDFtMTlzDQo+Pj4+IC0gNDggdGhyZWFkczog
MW00cw0KPj4+PiAtIDY0IHRocmVhZHM6IDU5cw0KPj4+PiAtIDI0MCB0aHJlYWRzOiA1MHMNCj4+
Pj4gDQo+Pj4+IEFkZGl0aW9uYWwgdGhyZWFkIGNvdW50cyBhbHNvIGdldCBsZXNzIGludGVyZXN0
aW5nIGFzIHRoZSBhbW91bnQgb2YNCj4+Pj4gbWVtb3J5IGlzIHRvIGJlIHByZWFsbG9jYXRlZCBp
cyBzbWFsbGVyLiBQdXR0aW5nIHRoYXQgYWxsIHRvZ2V0aGVyLA0KPj4+PiAzMiB0aHJlYWRzIGFw
cGVhcnMgdG8gYmUgYSBzYW5lIG51bWJlciB3aXRoIGEgc29saWQgc3BlZWR1cCBvbiBmYWlybHkN
Cj4+Pj4gbW9kZXJuIGhhcmR3YXJlLiBUbyBnbyBmYXN0ZXIsIHdlJ2QgZWl0aGVyIG5lZWQgdG8g
aW1wcm92ZSB0aGUgaGFyZHdhcmUNCj4+Pj4gKENQVS9tZW1vcnkpIGl0c2VsZiBvciBpbXByb3Zl
IGNsZWFyX3BhZ2VzXyooKSBvbiB0aGUga2VybmVsIHNpZGUgdG8NCj4+Pj4gYmUgbW9yZSBlZmZp
Y2llbnQuDQo+Pj4+IA0KPj4+PiBbMV0gMWUzNTZmYzE0YmVhICgibWVtLXByZWFsbG9jOiByZWR1
Y2UgbGFyZ2UgZ3Vlc3Qgc3RhcnQtdXAgYW5kIG1pZ3JhdGlvbiB0aW1lLiIpDQo+Pj4+IA0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiB1dGlsL29zbGliLXBvc2l4LmMgfCAyICstDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+IA0KPj4+IFJldmlld2VkLWJ5OiBEYW5pZWwg
UC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPj4gDQo+PiBUaGFua3MsIERhbmll
bCAhDQo+PiANCj4+IElzIHRoZXJlIGFueXRoaW5nIGVsc2Ugd2UgbmVlZCBvbiB0aGlzIG9uZT8g
V2FudCB0bw0KPj4gbWFrZSBzdXJlIGl0IGRvZXNu4oCZdCBnZXQgbG9zdC4NCj4gDQo+IFBhb2xv
IChDQ2QpIGlzIHByaW1hcnkgbWFpbnRhaW5lciBmb3IgdGhpcyBjb2RlIGFuZCBzaG91bGQgcXVl
dWUgaXQuDQoNClBhb2xvIC0gUGluZ2luZyBvbiB0aGlzIG9uZSwgaXMgdGhlcmUgYW55dGhpbmcg
bGVmdCBvbiB0aGlzIHRvIHF1ZXVlIGl0Pw0KDQpUaGFua3MsDQpKb24NCg0KPj4+PiBkaWZmIC0t
Z2l0IGEvdXRpbC9vc2xpYi1wb3NpeC5jIGIvdXRpbC9vc2xpYi1wb3NpeC5jDQo+Pj4+IGluZGV4
IDNjMTRiNzI2NjUuLmRjMDAxZGE2NmQgMTAwNjQ0DQo+Pj4+IC0tLSBhL3V0aWwvb3NsaWItcG9z
aXguYw0KPj4+PiArKysgYi91dGlsL29zbGliLXBvc2l4LmMNCj4+Pj4gQEAgLTYxLDcgKzYxLDcg
QEANCj4+Pj4gI2luY2x1ZGUgInFlbXUvbWVtYWxpZ24uaCINCj4+Pj4gI2luY2x1ZGUgInFlbXUv
bW1hcC1hbGxvYy5oIg0KPj4+PiANCj4+Pj4gLSNkZWZpbmUgTUFYX01FTV9QUkVBTExPQ19USFJF
QURfQ09VTlQgMTYNCj4+Pj4gKyNkZWZpbmUgTUFYX01FTV9QUkVBTExPQ19USFJFQURfQ09VTlQg
MzINCj4+Pj4gDQo+Pj4+IHN0cnVjdCBNZW1zZXRUaHJlYWQ7DQoNCg==

