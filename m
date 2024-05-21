Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F610C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHk-0007zk-T3; Tue, 21 May 2024 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0007ih-IL
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0001aH-S2
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297112; x=1747833112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1KP+zeK26x+doh2isKWRxN6rm1DzgfpKS4lDIjc+Dro=;
 b=Z4NvI3mVhBJq3qkXFTxC7fetvtZpzI642v4bMNLE2dcoFJUle7OziMjS
 FeasUswgYoDDOTuFoXrH3mPZvPVQ00ky50mIPoDUTpq5W+vvIlcwq3ZG3
 thdrOHHCa2g3pmZfAqNJLAuf8uQ8AoHEwvdICFcMaUc4XrG0HjWPQkMht
 /TRZN1Ri1s0mUyeiScHWAmmBGhmQU0nUWKYYNc3H0E+BEaUx4wT+WAeDj
 DeJV7xEy/pOJCGHdTLIfk9eh0NEvQvLjq4ZJUxjec/ZHeEd2/ivM15vzp
 flqx7aLuJDPRMpE9LiSi2HVYb+idG+MIFVfq3iAGUV5uL5Lkhcc2A1U1S Q==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061507"
X-MGA-submission: =?us-ascii?q?MDFTAb4y57vFCnQNzlJRHyL6rfgX+uPtyWF8N7?=
 =?us-ascii?q?RiIni/BgHazqgYbT/oAQutPB16I48K74vb1HdMwHppw8WQcBhPMCvC01?=
 =?us-ascii?q?p5YZC/jkcQsXYrkH1il2OSDttU/1VKPkKR83ibnRgFmzMS7wTCptEAgz?=
 =?us-ascii?q?eCLsRx0yuq+jB28YuFTEh+EQ=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:46 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1VxaiidyN8T8IKzWgu4ODk9t+C4A4gl0HsIYnGAVxO/kWwje3IdtlBwDImSfa83M8TkcxgVYkHWYMYW3OG0Y9IRdemh1y4FQSsMlKFVIRk1+JMiKUs3m7JGGHPWKQ5yycSlHgdLFyYMGDJ7bhqTji437CPxrXkr1QD08+RML/bMEevVZp9p4+yjkjIXSxTITF3Ie06xs3JTJom4ppmP509J7o1CQUai3PGo5aHUZyccFSCP9dZ0KjVOrz+JyBqlw7bpX1F7RxHN+YSX5MQl7fZWD4+nbABEMJFeYmpQ+WSn80CwmXdyq+KVd3lABE0Bpx8aOmi98KoUJtdssNXi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KP+zeK26x+doh2isKWRxN6rm1DzgfpKS4lDIjc+Dro=;
 b=KfX3RcJvuULU3OdCKCy0NN/Fh/kjtgKFxNMgX/unJ3mIc3qCpxXhHIaCfqbFpwmJ1uNZM+fZBsJAEfAUDWE7Mf4pw8VwoCNah9iCwYHKoJxfFMTwX4YdEyOxgZxLkO1nxap5m+5zzK7FlAw4iccAb9Q9CrNWyXt0zlI+ggnMDHioZCxNi2749NjoVWajqM+x8P4dSCTu/QOZ1eWuNuwswkkt+ykRGHkjv2xhPkpZiHeD5KjJn8YHPlGydNtbY4FXrK//VgODZ9WRFOtilC5BoIgxCYfHuH9jTao6PhZowve3zo6y4J7JjLGYpA8LXDFoODrnP31luLBaRWdeFI+Udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:45 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:45 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 11/22] memory: store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH ats_vtd 11/22] memory: store user data pointer in the
 IOMMU notifiers
Thread-Index: AQHaq4Bux/vp8d1aW0iFdkcO/MvXEw==
Date: Tue, 21 May 2024 13:11:45 +0000
Message-ID: <20240521130946.117849-12-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: 72894d0a-45cc-408b-2250-08dc799790a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QUIxVnBSTG93NlF3L0lieEFOSWhwSUdVU0RDWUJ5UW02ditDTVBsVmxLVDcr?=
 =?utf-8?B?SFA5Yk9aRG5aZWNsby83ZFNtOE1NRUlCVUwwL3Z6L2wvMytlRWI0Qnp0Vkt0?=
 =?utf-8?B?QWdDUmJGVHQ4ZzZ3MkM5Sjc5eFFUajBtdTloWUtYbldreUt6eXIzcURWd0Yy?=
 =?utf-8?B?bEo3QVRwY0lydFN0MEcvMkpmRERuY3hCcHpJdWtiQkRoc2VzT09FZGxWdmJl?=
 =?utf-8?B?SGMvaHhzaUhhcEY2VWRlZ1dZdDVaVWtnWlBqbHpoZm9qTllBZVp6V1RhMlls?=
 =?utf-8?B?OVQyMm5idm9YZ3hSWDlnMnVpM3M1bGJoZ1lJbVIvWXgrOUhjb1B1emJsb1F4?=
 =?utf-8?B?bnl3K3BTU1Ayd2xmUlFIbFZFZUkwcm9USTcvTndOTEVIZmRQSy9BbGptTWJh?=
 =?utf-8?B?MnVOL1BaeHVNUmFBTmdYNHc4RWVIeDIrdHprbXVXbG15UDBhdzhPaTNlTkx6?=
 =?utf-8?B?UW80MWlub0FTcVE3aXZYNmVIQWRvWklyTExBd2RzYjF4Qy9MZzFucDl4NDUz?=
 =?utf-8?B?UitFWC9iUW56UHd1Q2dRbGZJUXpQS0JEc3k4d2dkK2NVMnpiMmxWRWdvaHdL?=
 =?utf-8?B?QTJkczBCci9TQ2NKU3dib3R3SXoyUjVhaEU1NkdnTmphb201RFJNUzlraDBU?=
 =?utf-8?B?RXpidWhvYTVCNTBWMjZMOGFpYm5yajRLaDdlYllSTTE5aGhpSWJZa0x3YTlV?=
 =?utf-8?B?eGtmbVVEclM0dk9aQVR0b0xNdjdSL3BoR1lkLzBZa3REKytEemx2Sjdsd2tS?=
 =?utf-8?B?Qmw4NTZGWk9xTzhvQlR6ZklTbUcyMjNpSGdTTkZOMUJEeU8zVzdTMFRuSUg5?=
 =?utf-8?B?Y1FmYkpUMkN3YkVjMlg1b1NiVGMzZ3BZUlBIbkgybE5hQWhQaWFPQzhqM1o0?=
 =?utf-8?B?STJWKzJWUkNZY3dNTVF3LzJZUGg1SlRnYWw2cWUrdDFvaWc4Ly84Yml6UzJZ?=
 =?utf-8?B?R0dsanRLRTB4akxIOTh4Z3BaRkE3SVVKNG5RN3hmaDRvR0pMaCtMcGExZ2Er?=
 =?utf-8?B?UXNIdnZqRmtXZ3ZmWERES0gzUFpXam8rdTdwVDFDVzI3RTE5K3hPc1ZrNkJF?=
 =?utf-8?B?MUh5NkMzMm84U01kck5BRkhCMHZpeUcyamY0M0JVZ0d3WTAvTTdQRGtPN3J3?=
 =?utf-8?B?di9ScU1WakltUW5COEZDak9MeG5CbDVYWFRvcGc3WnU3WXNDSERWbnRkaS9L?=
 =?utf-8?B?S1JyR2dpT1pEN0pzMVJLa1Q2SGhFUCt2c2puaGV4bUVEL2FHQUx5dldaaEsy?=
 =?utf-8?B?UllDWnFXZ1JSNUFwTk1jOXZMUUxoMG5zKzBNRzkzVjJ2WUpkeUlyYkNwZ0k5?=
 =?utf-8?B?Mlh6Q1R2WW92Nk9oenVOdWNlQlY2WXNXRTVyUnJIRGEvbUMvdngwcWVXUmZR?=
 =?utf-8?B?WXRLdXkwbHBLbWN5SE9iNXZ3K3Z0M0VtYzhJU0ZtQ1kwbXZ2ZGhyZ29zcTFI?=
 =?utf-8?B?aFVIVXU4Ym8wUXZJR2NtYkRDSkk4bS9aUWlOSTMyMCtzMmg1SCsyVjNGTGhj?=
 =?utf-8?B?THQwQS9rUUpZaWdhemhjRUhEZUN0OENNaDB6TmppS0dQWDFWQTNWL1BWd3JL?=
 =?utf-8?B?MEV2a0tXQm1rVStKQlFoR1AvdSs2cXdDa2N3TXFtL0xJQzB5Z082SU9lRjQy?=
 =?utf-8?B?T2hKMmRiK0MxZmhxZGpOU3hrUlA3N3lldDlKcS9qcEFxR3FNenRKakRSdmpL?=
 =?utf-8?B?R2NiaGNKaUVXUFhkWTdRK296bmlNcnRMRENzb3RydGU3d2l0U3B0RzdhaEti?=
 =?utf-8?B?SWZDSXlJOEt3djZDakdxbzNNaHhzRkNRb1lQR2J5NDVXZXZadG5vcnV3N0Jq?=
 =?utf-8?B?Q1RRbnBzMjN0WVlPcEs4UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGl1NE5ObjVUajlKaFluZGpNTFp5Q0p2MHBGUm91UmhXTklsODhWRXVJeisz?=
 =?utf-8?B?eE12SnBPZGdycS8yVWRnSU9Ubm9PUy9VbWVLT2ZSSG9GdE0rNVhkU3dYZ0p2?=
 =?utf-8?B?V2lsMWRZMW54dTVSMHMwOXhpMWlnMHFFMmxuLzdjUHdTOFVMUFJ5bFcyZXhi?=
 =?utf-8?B?VmJMTytRaUh2Wkd2VmhXNmdVRUhKMGVlTjlBMW8vOTgyZjhtTnNqVlhhaCtT?=
 =?utf-8?B?OXBoZzdmdnZqTUtDTHFIZ1lFd3NXS0FyNEFMSHVWWTBGZFRPRHU4RWNBMXRI?=
 =?utf-8?B?VTVHQzhPTUJXZ2JPbTJkUG93K1hZenQwaWVRT1VmVHRWK1o1MUwvYmd6SHhQ?=
 =?utf-8?B?UVk1U1RZaDl4U2ZCQzdCc3o0MnJUcDJBemNPRkVVTVdENklhVittQXE0UE9m?=
 =?utf-8?B?bkxVL1ZTVHRSSGZkY3hwSC90NHNHYUJueXg0Y2dueGllL2lXNjBYa29jYzBW?=
 =?utf-8?B?MWJBTEFtYkw0Q21YSVNVamFlRFpzUUpLMTBYM1dQY1NmWlFVSmxobFpFMjNQ?=
 =?utf-8?B?ZGNJeTlqaHFGMFhmRVRBbUU2UmJteEZLaDN6cW1qdm51bzdVZnRhamZwdkd4?=
 =?utf-8?B?YUhrcmQ0dTlTWElDTmU1Zm9udGxYeWRiaTZEdTB1N09nTk5GUVlVYUFidGdY?=
 =?utf-8?B?T0VSRUtTNHFnOHRLVHlOSEp1VjZGNmJnYmRLeG5sTWJaQWw1Q3Y1bUFDalJ6?=
 =?utf-8?B?enlNU0padzg3WU1ZYVNTWktjWjVjbXpEUHcraVEyWnNxRjFSTjdhR2R1Z2VM?=
 =?utf-8?B?OGZEWlBHNnkwMEtBTFZtdXZGREIyaEd1RFo4WGUxMC9kOUtKL0g4bzFwUFFQ?=
 =?utf-8?B?QjZVNk9oc2pDZkJSeXVRdE1nYXBtWGFKVStiYjMxUTc3S1ZvOVRNNlVKMS9w?=
 =?utf-8?B?NC8zU1pwZmtGbmxHVnA2TVZUMDdpQUN1ZngvbDMvdWNYcHlEekRrYlFDamNB?=
 =?utf-8?B?bW4zdklsbDNob3h0OExDT2k2ajkxTUZ3VFRNQ2xqMmhpZWc1V1BPWURxYjBC?=
 =?utf-8?B?YzhRYldmOHg2Z3dZem42UmNKWGpuMEpSa0thcVJiTmQzT3RQS2tBZVBVQ1hS?=
 =?utf-8?B?WDlMM0ZSTFFLTWFRYnJ4ZUZVMGRIbEdtQVhnYXN1OFBWOHpJTVU5Wlo1RlND?=
 =?utf-8?B?eVVuSWp5SW9ZOE9Pc1lIYTNsOXhuWS9PdW1Sa3htRG5ybHNnVlYvTit0KzlV?=
 =?utf-8?B?bkJLb1laZ3IzUHUvWjVra2NXQVFKaTdxdEJSUWFSaGtCd2tVbUZjQkRVVWxy?=
 =?utf-8?B?U216QTNPRVNUSWFQckFqSTZyUUoxNUlldUlzUjhXVkRpUnU5UE1OUzRQekRy?=
 =?utf-8?B?UUg3MkhrZHZCVG00dG5RV05zUGx4L1dXM0d0ZlI5bFBoWGpKM2NyTnQrY0RQ?=
 =?utf-8?B?c0NPamx1V1NzYUlUQ2d5b1l3VStJSERKYUk2ZHFEYUxQbnZSVEJFQkJydCtl?=
 =?utf-8?B?UzY5VHJONkZ4OGN6MG9sanp2dEJ5aDdHV3E4Ymk5akhhT0tsTDVGbFp1bkRr?=
 =?utf-8?B?NUo1eENkcFhKUlV1T012RTN1eEc2NzJOMU5iL0FxOWZhaXgzZHk2NUtLcFdF?=
 =?utf-8?B?NVVBdDByQUxadm5aQ3pRZldqc2pmMWh0NXp4dHBvZWtZQVI3dVdVRWczOURI?=
 =?utf-8?B?SVVsVkgrK2g0aFJHd2FZNlJuOFZTRGsxRm4wMnljVDVkbGF4TElqb241U1h4?=
 =?utf-8?B?SWo3UDhwYUw3L01BMG5VSTA1UHEvUFZLblVVSndya1BpNkZacHV6Qnp6V2xK?=
 =?utf-8?B?SUY3bUhJUTZuazBZRVhyem50M21yRDl6Zi9Takc2d1I1b2dYMWRhbGtoUDdM?=
 =?utf-8?B?SXQ2ZlkvZGhuUFkvL0hrOVpDbURtSDZUWGFuamZCRW5RTjNBcXpVOE1CbG9H?=
 =?utf-8?B?dUczdUZBaGhwa2VpMlBxby9RSkxiMFY2dGxOWU5ha3RmOHU0VWhuVU5tUVdw?=
 =?utf-8?B?c0ZCRnRhNFo5YlVXT1BzWXk2VENjbW1uQXJBUGtKS2JOazRlc3ZENnVqbjJL?=
 =?utf-8?B?SW9LeVdkS1dWdXh4Z0Z2U1BLdHdrRnpDUFBRY24vUDRDRUNXK3p5UHhuTjl4?=
 =?utf-8?B?SjhZekwzQytybjR6cUFIMUkxVmFEbk9SamVWMHRaYmxZdzVYcmFleUh5aXJq?=
 =?utf-8?B?TDBYUUNxZTQreEZkSDJkekU5MkhlU1VGUFRyZWZFZ1JnK2FtZ3k5aUJ2djVT?=
 =?utf-8?Q?laeWOgb5OiahAdHfumDP58k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B1EBFE97BC06346BB98F0D3C817899A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72894d0a-45cc-408b-2250-08dc799790a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:45.3337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZcviH9BLRnx5Ab/EUAoa/7DAONcmM5sPTd43vSlPugnyCSSoYj30qaim1Sq9dq9yHoo6ZRtTi8sDzLLg/awIBIEciZ1j9HbATt9q2+VM/giG9UaSmRd7IfCmnOMB/9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
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

VGhpcyB3aWxsIGhlbHAgZGV2ZWxvcGVycyBvZiBzdm0gZGV2aWNlcyB0byB0cmFjayBhIHN0YXRl
DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGll
dS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5oIHwgMSArDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4
ZWMvbWVtb3J5LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCmluZGV4IDAwNjdiMjI2NmEuLjM1
OWJjYTJhZTIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCisrKyBiL2luY2x1
ZGUvZXhlYy9tZW1vcnkuaA0KQEAgLTIwMyw2ICsyMDMsNyBAQCBzdHJ1Y3QgSU9NTVVOb3RpZmll
ciB7DQogICAgIGh3YWRkciBzdGFydDsNCiAgICAgaHdhZGRyIGVuZDsNCiAgICAgaW50IGlvbW11
X2lkeDsNCisgICAgdm9pZCogb3BhcXVlOw0KICAgICBRTElTVF9FTlRSWShJT01NVU5vdGlmaWVy
KSBub2RlOw0KIH07DQogdHlwZWRlZiBzdHJ1Y3QgSU9NTVVOb3RpZmllciBJT01NVU5vdGlmaWVy
Ow0KLS0gDQoyLjQ0LjANCg==

