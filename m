Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A769F53D6D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2AmK-0007l8-9T; Mon, 16 Mar 2026 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1w2Am9-0007kF-Hi
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:26:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1w2Am1-00058f-G2
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:26:36 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GAJYbC590026; Mon, 16 Mar 2026 09:26:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5zXp8owpZH/yjW162iz/KIVGJFqMQT8BLMCUPAYCL
 MI=; b=boebx2YjJByJ16mqsBncCSn1SD7OmpJW+wbAer3RXdb0evulZcXReM/Af
 gh6jnocr6TvQgxADSr6qbPdhpfTdx+OUjfvoBtVhtFY2a+2FOaauRzE/OMKtg/D8
 HIP7ghRCnUOytRcJfTjv6C3oeb1KsJRWd5FbxdIDtmH0w+7IzTmR34DuL/+myevs
 NFKU9c6YzxlKSYCu1sdc40ddM5p/c+jAPtYegB3aANFJ2+usPY11MlLHyrM4YrTC
 7AqBIzeSvhTc03J0vxyohOP7ez77HGq9an6px6GBWkej8Pa2itgML7OjPrAc9HRg
 F9ZeQoJq0T4nWZ2Wm0LNN5sjMQ8jg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020107.outbound.protection.outlook.com [52.101.61.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cw3k4c9qw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 09:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3xNyOD/yyKzE67c8TjSXSDJN4cRw+flmg9k6sKGAmWn2wSlqzCjCV92pQEbOe4f83P8tkRq+PM84SPW035j7R2UW486k1T0SN5CT8qgD1tcSHnvMicd9xFMxxkyIPW1tx6XCf97cgHSiWn27144C4A4MOC5e6vmQsGWMtxvXoFu8oZ1fCVKs+3Gnfa1oxxGuLCXQXFV462FWbMKassKrk75Te34ShLeMnDx2PDQHVeBqWqNXw2cEmffV2MgUn0hsfblWdkQPb4SdEohH5w9ZzFspWTkM11+rn7IxJHkXvQxALmIKC5CWDmkVSskK7hzh4aBVzRk4l+AbsYJDDwXcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zXp8owpZH/yjW162iz/KIVGJFqMQT8BLMCUPAYCLMI=;
 b=wBdPhRHhCJv/zQr1px2+tosuSYrY3TUtS7+YpYYLI2+dG6ar5ALKcyWEr1w4MTlo3ItRkY4vFWmIk+/Jzh5cKPEnh56Dlg/qkRYSxXNpV2MVyOmWzJ4TJ7jyS1Qknw8XSriwPaGKalq0J/vobBFB2qAA+c7VJuo1K81d7Uq3GZ1qIeUEFYof9SZDYcInLhnUtTeznUdL9XYGCsKlmZJ5pmIvdhH23Ut77N7QjtCz3jT+hs3xAVRu5sC/z77fZRD741Z7zFwZYsl3Fxg7iX+Cs9eHtdBdqgc7+wRJN0ZHwxwE5i6m9BriYmQWD3g0kfwdLu4ey6J418z3kKXIHQeH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zXp8owpZH/yjW162iz/KIVGJFqMQT8BLMCUPAYCLMI=;
 b=fGI4r7sgTrlW0qEswAAYtqRm6KynAiixTz7ZTDGc7fxJXjQ3hfRcBGTnnmf1tmClFALbb5koZ2SVa7mgI0pWL4HTQK2T0qt+PmGiR38xxORUpo5g4/qc9ehwQcvYjqhGv8Pqo9xXBuLuDOAgINJQsNJgpJ+E7A8p52I0BT3Meo4bQzzCRGChzkTugsK7gq8xxLHnhtD6v6EYUGalU7j2qeShytXvjWvjpiAD3tlsUJ21gjIWKQprM20Ls8rr0iWnpzTWE2NMWZeOYLJjGvm8qgipZApcMxtvl3CsD9K/maFihdGGcYGrO3GdwYEGS4g391ftLAE1tg66+yNl51pDtg==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by MW4PR02MB7297.namprd02.prod.outlook.com (2603:10b6:303:77::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Mon, 16 Mar
 2026 16:26:24 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 16:26:24 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: Peter Xu <peterx@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
CC: Tejus GK <tejus.gk@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Thread-Topic: [PATCH v2 1/1] io: make zerocopy fallback accounting more
 accurate
Thread-Index: AQHcr6Rq6iJC2Z+CoUCUQa6EPCmGKbWmad2AgAADGwCAAAT0AIAABtkAgAACqICAAAh6gIACupGAgAA6NgCAABf9gIAACQcAgAAFIACAAA/igIAHtTmA
Date: Mon, 16 Mar 2026 16:26:23 +0000
Message-ID: <289D627B-A328-477C-9EFC-46AA3A05D1A5@nutanix.com>
References: <aa78gMsQrt1BeXt3@x1.local> <aa8AqKqOa8YhEiF9@redhat.com>
 <0DF1A5F6-E20D-4A3F-9285-9205E87DE641@nutanix.com>
 <aa8IoQOZHzQvacSh@redhat.com> <aa8Pvd5O-OLKIXam@x1.local>
 <abFZvUoinIjfMlNX@redhat.com> <abGKkoFfy1RILXA0@x1.local>
 <abGesQMQuVSYJy1W@redhat.com> <abGmRItAZiiRIeIY@x1.local>
 <abGqkFCoApJv2rT1@redhat.com> <abG349ix_S-CEn8C@x1.local>
In-Reply-To: <abG349ix_S-CEn8C@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR02MB9817:EE_|MW4PR02MB7297:EE_
x-ms-office365-filtering-correlation-id: 0db53aa2-a80a-4fa1-730f-08de8378c3f7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: N7obFGKHH1DIBxW0i1ZEtcP8x0OIhicR/SBCKK3CYLns/Xa059Wl5C459ajQqumU3cBhLWzC+tGGa8HBTXoresmc8mt1WyDnLvfvWMHG42vKHkvtIQZsIbZVi6asOUKqQkcFO+UAmsTWaNIumky4fD+/EtOyu+NCp8oEfiogFNcDDaixU8BKjd2NZqJlf071Riyr/gNcEiCbhQEtIIcCYdERTjoAaoRFrIv7+rlO4IuXJ60efWMDer6F6WPjH3f+cANvQwVlt4p50svF74icbKCePva38iAtjIazAfhDoAKrS0Ct0Vjg2mgSD/ftqjqF0PutmTfEi5vU8i1jiMatdu2VIMm4HPDKlhsjt2cucJthz3EVgy4BoOeyB1Bskj7Uk+55GFazHFoO8vs+MLI6EFOZ3tgrhlFScnhc2KTa+I0L/7rCth5xTEuiIYbawBZTFZA8Pt5rSHBoxONAX7N8nhhX3y8hf5q8wlm4KDt7L2E8rMWQ4KrXCUmr1HjhwSo+1B0Qo+HfJPndj0/Y/A5m83CYyTIxBUsItVwNcxSRxxEU3+K+oQerrgPBe1qHRYQ8JjY/SSbeF8Mm/41JF60GSabKLFA8yU+S02wG0KGT5Z2bRhtqKZwKphMzZiJ5FQ15hPLeNHEUhZLskpvIKGEMHGkW4TP9RpCZcAIlnFOjCQkmKHaNm3oWM6QeuhsoBLzRP3SnkGqreL+cwP9dpZJF6V/Or4aTiXq//7nGhG3TgswOS0zA9mAbWDhowF9NemZHqGI0cCKIGmQHiF3QVHvk4iO7BJ3d2YvNaouXSo1ce9A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmlVL0srUHRNd3lRd0RHak44QjFiZlZ2ZXhiam1FT21DaFRwQ1ZrcHhzMkd5?=
 =?utf-8?B?OW9BdEZWWmRWUDZPRHdqcG1IS1N4aXlhV3N3bGZxSmltalNYRTg2Q09xS2pZ?=
 =?utf-8?B?Szg1UlNidkgyR0FMYkYxRCtoNlExeFJxbTcrYWhZMlRkclJweGdYQ0xxTldF?=
 =?utf-8?B?Wm9hNkEyV1J0VG56ejdpdzZJdHJoamlxdHRmam1xcHYrK1djcW5xaUJteHFQ?=
 =?utf-8?B?NUJzOVNkYzVPdGJ1VDdjdkJQaVE2b0VYbjd0QnVwMFp0UXpQSGN1VnFFZTR2?=
 =?utf-8?B?dk9nT3NnSGs5YTBHME5jcndnd1JGdThzclkrRXQvNEdlK0x2a24xTUFsMXM4?=
 =?utf-8?B?a0tzRlJ5Q2t2bGlYdDlLZlFOVm42U1dkcjcvMDhOTG5rRjF5RXBXYTFINzJP?=
 =?utf-8?B?bVRLWnorSTFKbUw5Zll0TU9RdTlyenA5cEQxaE1qQnJuTEJ1TnpoQ1lmRXlI?=
 =?utf-8?B?ODNlNm53M2JPUExDbDFWLy93bGhIYU0wQjdIeFB0aUs3aURiSlpiaEdCTXNq?=
 =?utf-8?B?aDBrbUNEVmJQZ20yTnAwTXJ5eHdOb2tpSkNXS0NtUHY4NXY5OURIaEY2cG1B?=
 =?utf-8?B?VExNR2dDRTJ3WkErZFZPUTZISndFLy94WTdtQkMyb084c3F1ZiszU2I1R2tM?=
 =?utf-8?B?cy96SEt5V2RtQUtlUG5OL3hueHQzU3FNMzlkY25zaVlubnBMaDlhcEJkUHVM?=
 =?utf-8?B?UmgyUklMVzI2SHo3NDFpSGxnQ3pYRXpVc0w3QWVjNkxyUDNqWDZ5NUdkMytT?=
 =?utf-8?B?MWR1NitMSHordmZvcnFSaUJDeDZ1NUxZZUZtQUpNTWg0c01sWDErSXptQi9u?=
 =?utf-8?B?RXppWHZHbG9FNTFpK1dadDJiV244RFpEOERVbGhyYitYYm00N2tQRzF1Zmo4?=
 =?utf-8?B?a1BYM2I3RUhORHhNL2dxQ2pJSVRjRjF3WmNmRkQ3TlF2ZmhaNit2MzBMc0pp?=
 =?utf-8?B?dEFGRUcxbXBZSE0xQktzZ0pDZlQxN2w3aGNLL05ZMUlHQ09wWDdnUGFVY0VH?=
 =?utf-8?B?cWVsektJdlgrZlRmM2Q0TXRJWk5YMW5oeFB5clJXU1hpcTVoV3ZkTDZNanZD?=
 =?utf-8?B?R0sxbVpTWjhQenVSVUQwelJ5bVdqSUM3ek5MaWJNbEhqVzltYWFsOGFlbFV4?=
 =?utf-8?B?QWhTY2ttYk1yV1ZNOWM1bGQvNllNZWtTaTMxTVpLZ09sQ0E3OWJVOXFycGYr?=
 =?utf-8?B?T3czaHVDRVMvK2FVb2tYMmVWWUVVZ1hFRXY5MmwrYUx3L2Y4SHZyK3BkejNL?=
 =?utf-8?B?TDFaSnZodWs2bHluVXBOR09CMS85RnRpVXVDZDNTRGsrdlRPbnZoNElnTVVX?=
 =?utf-8?B?enBhbmRzMHpoMWw4UDJtZTdQc3YwRTVFSW9aay9neW41eFhzMjU2YVU0eFZT?=
 =?utf-8?B?Rzhxd2JWanBwMVNQeTFXVDZlRmZDSnpHUW1BbzNOeVBsQXBjT3hHZituSUp1?=
 =?utf-8?B?bnl2aGRJMXVobGQrWTV4Ukt0YjE5cmRPcGNpR21UYWVWL2xNMEthNnJmbnFH?=
 =?utf-8?B?MUZMclJiTEh4L21sVk9HaVQxVG5hbndJZVA1RTN2NzRJOW01MW9YbFFrMXRC?=
 =?utf-8?B?SzA0aU1IL2NuaGJzS0VxY2hKNTJNb0YvcTNETlpwSjh3di91TzZLYVo3OVZz?=
 =?utf-8?B?ZTJDKzdPUzFqYmcrU21nRmVBcHlFWDF0cDR4MDN2cEdWMFhxU0lDRXo2OXRj?=
 =?utf-8?B?ZjJSNk5rU1hWVzVlSVBzQ3dMRTk0SGlZL2YwakFXeVlPeEV4dWJsdnRlQTdx?=
 =?utf-8?B?cVNKeExaN3FRWmFNUjRSMVpvVlZobFNkTFQ3cC8wUmhobjVYenNOVnI0VzZa?=
 =?utf-8?B?bWRBQ3VLODJGTVhGNzFCdUdiRDF2dllNUnBqcWhLSVlodXZjMlB5U1VqdlRp?=
 =?utf-8?B?d3NXWkRLRWRvZWQ1Z2VWNzlaSHlieENHN29NQTVjNkpCQzVaTjAxM0ZrNnFW?=
 =?utf-8?B?cU5wTEliMUlzUllHVjBFMC9HVkY4L0xrVC8xcVhIT0tudWRMYlQzRGVEZzZL?=
 =?utf-8?B?d1dNV2h1RFNOcHlBTzY3NHN0dGNSQVM5c210d3V3dmhFZE9TNWdUL3IxbjZQ?=
 =?utf-8?B?Z2o3dGk1d09ySXBXbG9hbktsZUpEdEFlRkNIaS9HOGdHWUlzSFVBV3FBRko1?=
 =?utf-8?B?MS9PS1JyTHJPWjhVRFlra3h2dnlGajU0Q0c5VXBFWldlaS9UeW9SM0RReGEv?=
 =?utf-8?B?ckNJZC84SG9qSnpmdk9rWkg5OFpyNVlNc3Y0R1c5WUthQlJ5S0JPbWpSRktZ?=
 =?utf-8?B?T1FWZkk5U3ZzNTVITm11RHAzOStPUWpTZHB0T2Fnc05pZ2FQUnc2MEFBVE0v?=
 =?utf-8?B?UkJ3dC8renNORTA2bGg5Z0MxR3ZVa29zWGFYdm9JbUNiU1VmNkdLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD26B5BDA00C3644AAA8A36E4788D0F1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ik7/fdUy9BVak00puKV0Z/UyJEBNNva8kr6IL31wrAchbIOk7IfuekLNoYMjYg3hAk5djzhdbT9hd4Dba8vwYy1XrmYZyg7QmHz+SdgGGsdIm/vC8z4URGuwFlEM/9Tp5IKl5yhARkPLySsgS+uk//arNjabP8cwuDadgfTh+x8s7H00/L8oH8ujHDsnz7JZoWWHNMY6VDfRxbB8LzouGWvEYBU7hwZO14ipHP5z6lv6B9ibr4+B2Dxqm2RMqC05eE2qzNmesLm6yVzopeNX6nEddpZGqPkuMwNsUBgJGF4+TnmZMXYIK8YxyK6cJ0rHMcTL3upAftaWWoetQ0WEZw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db53aa2-a80a-4fa1-730f-08de8378c3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 16:26:23.9989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52Mt7K01cpnx/SgfM38bgH8yrw/gA9lUm/eVzm4EUo7WVNvF1H0xKBUfN9UgpF0xO2K1WKOzqaxdSsuNQAbX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7297
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyNiBTYWx0ZWRfXxPqVDt5xYy50
 jxHbTZj75VDZpsj+X/WdbXqu3MvxP8q2k+fHyKbMLTljQVu54eGgDSkwR/5kpxCeaB8B+rH4oVG
 MtAnUHwlNwuyP8zIiSb8ObH7G9FnSSY2LRKf7o5mqk0/S6sJ60zbs4SNrGTJXkJIB/otatBu+cm
 G5NhwFXzoOAQ884bQI4RqJLeVRIAmvb6nMpJgKefCAw4lGSb6SQCE+zVDgPa0uE1jakG9lMYHyJ
 yg7lJ7e8ENY9Rj1weqzpYlR44E5Wtgq14uouxOhpaVv7puycVO/Pxul3inzy+xeP6Bnda+86yWx
 Q1OtAe4nu8EKxyjmExZFBvGEz1XvsEqibdD2s2QOAd73vQuPu8g87Ujk+RRCyLt86sf+TdGt1LY
 vN8RHwzI7Py5EhTGeFoPj/d822+ebsjsM+MreB0ndJX07ACcdo+vZlFh7YdpXb+lR3OoSMKB+KG
 Kifr9ilYK2Z+DzfBWwQ==
X-Proofpoint-ORIG-GUID: dda2Gzd2sQNTpTQA-PLv7FukggDvJgve
X-Proofpoint-GUID: dda2Gzd2sQNTpTQA-PLv7FukggDvJgve
X-Authority-Analysis: v=2.4 cv=RZqdyltv c=1 sm=1 tr=0 ts=69b82f34 cx=c_pps
 a=5R/USArCWZnskgXodYG4KA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=20KFwNOVAAAA:8
 a=sr3_8uY9Va46d4sARgkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

T24gMTIvMDMvMjYgMTI6MTMgYW0sIFBldGVyIFh1IHdyb3RlOg0KPiAhLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4g
ICBDQVVUSU9OOiBFeHRlcm5hbCBFbWFpbA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gT24gV2VkLCBNYXIg
MTEsIDIwMjYgYXQgMDU6NDY6NTZQTSArMDAwMCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToN
Cj4+IE9uIFdlZCwgTWFyIDExLCAyMDI2IGF0IDAxOjI4OjM2UE0gLTA0MDAsIFBldGVyIFh1IHdy
b3RlOg0KPj4+IE9uIFdlZCwgTWFyIDExLCAyMDI2IGF0IDA0OjU2OjE3UE0gKzAwMDAsIERhbmll
bCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgTWFyIDExLCAyMDI2IGF0IDExOjMw
OjI2QU0gLTA0MDAsIFBldGVyIFh1IHdyb3RlOg0KPj4+Pj4gT24gV2VkLCBNYXIgMTEsIDIwMjYg
YXQgMTI6MDI6MDVQTSArMDAwMCwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+Pj4+PiBP
biBNb24sIE1hciAwOSwgMjAyNiBhdCAwMjoyMTo0OVBNIC0wNDAwLCBQZXRlciBYdSB3cm90ZToN
Cj4+Pj4+Pj4gT24gTW9uLCBNYXIgMDksIDIwMjYgYXQgMDU6NTE6MjlQTSArMDAwMCwgRGFuaWVs
IFAuIEJlcnJhbmfDqSB3cm90ZToNCj4+Pj4+Pj4+IE9uIE1vbiwgTWFyIDA5LCAyMDI2IGF0IDA1
OjQyOjA4UE0gKzAwMDAsIFRlanVzIEdLIHdyb3RlOg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4+PiBPbiA5IE1hciAyMDI2LCBhdCAxMDo0N+KAr1BNLCBEYW5pZWwgUC4gQmVycmFu
Z8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+
ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tfA0KPj4+Pj4+Pj4+PiAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4+Pj4+
Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4g
T24gTW9uLCBNYXIgMDksIDIwMjYgYXQgMTI6NTk6NDRQTSAtMDQwMCwgUGV0ZXIgWHUgd3JvdGU6
DQo+Pj4+Pj4+Pj4+PiBPbiBNb24sIE1hciAwOSwgMjAyNiBhdCAwNDo0ODozN1BNICswMDAwLCBE
YW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+PiBAQCAtODgxLDggKzg4MSw4
IEBAIHN0YXRpYyBpbnQgcWlvX2NoYW5uZWxfc29ja2V0X2ZsdXNoX2ludGVybmFsKFFJT0NoYW5u
ZWwgKmlvYywNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICBzaW9jLT56ZXJvX2NvcHlfc2VudCArPSBz
ZXJyLT5lZV9kYXRhIC0gc2Vyci0+ZWVfaW5mbyArIDE7DQo+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4+Pj4+PiAgICAgICAgIC8qIElmIGFueSBzZW5kbXNnKCkgc3VjY2VlZGVkIHVzaW5nIHplcm8g
Y29weSwgbWFyayB6ZXJvY29weSBzdWNjZXNzICovDQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgIGlm
IChzZXJyLT5lZV9jb2RlICE9IFNPX0VFX0NPREVfWkVST0NPUFlfQ09QSUVEKSB7DQo+Pj4+Pj4+
Pj4+Pj4+IC0gICAgICAgICAgICBzaW9jLT5uZXdfemVyb19jb3B5X3NlbnRfc3VjY2VzcyA9IHRy
dWU7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgIGlmIChzZXJyLT5lZV9jb2RlID09IFNPX0VFX0NP
REVfWkVST0NPUFlfQ09QSUVEKSB7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICBzaW9jLT56
ZXJvX2NvcHlfZmFsbGJhY2srKzsNCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiAuLi50aGlz
IGlzIGNvdW50aW5nIHRoZSBudW1iZXIgb2YgTVNHX0VSUlFVRVVFIGl0ZW1zLCB3aGljaCBpcyBu
b3QNCj4+Pj4+Pj4+Pj4+PiB0aGUgc2FtZSBhcyB0aGUgbnVtYmVyIG9mIElPIHJlcXVlc3RzLiBU
aGF0J3Mgd2h5IHdlIG9ubHkgdXNlZCBpdA0KPj4+Pj4+Pj4+Pj4+IGFzIGEgYm9vbGVhbiBtYXJr
ZXIgb3JpZ2luYWxseSwgcmF0aGVyIHRoYW4gbWFraW5nIGl0IGEgY291bnRlci4NCj4+Pj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4+Pj4gV291bGQgdGhlIGxvZ2ljIHN0aWxsIHdvcmsgYW5kIGJldHRlciB0
aGFuIGJlZm9yZT8gIFNheSwgaXQncyBhIGNvdW50ZXIgb2YNCj4+Pj4+Pj4+Pj4+ICJtZXNzYWdl
cyIgcmF0aGVyIHRoYW4gIklPcyIgdGhlbi4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IElJVUMg
aXQgaXMgYSBjb3VudGVyIG9mIHByb2Nlc3Npbmcgbm90aWZpY2F0aW9ucyB3aGljaCBpcyBub3Qg
ZGlyZWN0bHkNCj4+Pj4+Pj4+Pj4gY29ycmVsYXRlZCB0byBhbnkgYWN0aW9uIGJ5IFFFTVUgLSBu
ZWl0aGVyIGJ5dGVzIG5vciBzeXNjYWxscy4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBQbGVhc2Ug
Y29ycmVjdCBtZSBpZiBJJ20gd3JvbmcgYWJvdXQgdGhpcywgaXNu4oCZdCBlYWNoIG5vdGlmaWNh
dGlvbiBhbiBpbmZvcm1hdGlvbg0KPj4+Pj4+Pj4+IGFib3V0IHdoYXQgaGFwcGVuZWQgdG8gYW4g
aW5kaXZpZHVhbCBJTz8NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSWYgdXNlcnNwYWNlIGhhc24ndCBy
ZWFkIGEgcXVldWVkIG5vdGlmaWNhdGlvbiB5ZXQsIHRoZSBrZXJuZWwgd2lsbA0KPj4+Pj4+Pj4g
bWVyZ2UgbmV3IG5vdGlmaWNhdGlvbnMgd2l0aCB0aGUgZXhpc3RpbmcgcXVldWVkIG9uZS4NCj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4gVGhlIGxpbmUgYWJvdmUgeW91ciBjaGFuZ2UNCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gICBzZXJyLT5lZV9kYXRhIC0gc2Vyci0+ZWVfaW5mbyArIDE7DQo+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+IHJlY29yZHMgaG93IG1hbnkgbm90aWZpY2F0aW9ucyB3ZXJlIG1lcmdlZCwgc28g
d2Ugbm93IGhvdyBtYW55DQo+Pj4+Pj4+PiBzeXNjYWxscyB3ZXJlIHByb2Nlc3NlZC4NCj4+Pj4+
Pj4+IA0KPj4+Pj4+Pj4gSWYgZWVfY29kZSBpcyAgU09fRUVfQ09ERV9aRVJPQ09QWV9DT1BJRUQg
dGhvdWdoIGl0IG1lYW5zIGF0IGxlYXN0DQo+Pj4+Pj4+PiBvbmUgc3lzY2FsbCByZXN1bHRlZCBp
biBhIGNvcHksIGJ1dCB0aGF0IGRvZXNuJ3QgaW1wbHkgdGhhdCAqYWxsKg0KPj4+Pj4+Pj4gc3lz
Y2FsbHMgcmVzdWx0ZWQgaW4gYSBjb3B5Lg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBBRkFJQ1QsIGl0
IGNvdWxkIGJlIDEgb3V0IG9mIGEgMTAwMCBzeXNjYWxscyByZXN1bHRlZCBpbiBhIGNvcHksDQo+
Pj4+Pj4+PiBvciBpdCBjb3VsZCBiZSAxMDAwIG91dCBvZiAxMDAwIHJlc3VsdGVkIGluIGEgY29w
eS4gV2UgZG9uJ3Qga25vdy4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSUlVQyB0aGUga2VybmVsJ3Mg
bWVyZ2luZyBvZiBub3RpZmljYXRpb25zIGFwcGVhcnMgbG9zc3kgd3J0IHRoaXMNCj4+Pj4+Pj4+
IGluZm9ybWF0aW9uLiBJdCBjb3VsZCBiZSBwYXJ0aWFsbHkgbWl0aWdhdGVkIGJ5IGRvaW5nIGEg
Zmx1c2ggZm9yDQo+Pj4+Pj4+PiBub3RpZmljYXRpb25zIHJlYWxseSByZWFsbHkgZnJlcXVlbnRs
eSBidXQgdGhhdCBmZWVscyBsaWtlIGl0IHdvdWxkDQo+Pj4+Pj4+PiBoYXZlIGl0cyBvd24gZG93
bnNpZGVzDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBJTUhPIHdoYXQgdGhpcyBjaGFuZ2UgZG9lcyBpcyBy
ZW1vdmluZyB0aGUgZmFsc2UgbmVnYXRpdmVzLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gQmVmb3JlIHRo
aXMgcGF0Y2gsIGlmIFFFTVUgcmVwb3J0cyBmYWxsYmFjaz0wLCBpdCBkb2Vzbid0IG1lYW4gYWxs
IHRoZQ0KPj4+Pj4+PiBNU0dfWkVST0NPUFkgcmVxdWVzdHMgd2VyZSBhbGwgZnVsZmlsbGVkIGJ5
IHplcm9jb3B5LiAgSXQncyBiZWNhdXNlIHdlDQo+Pj4+Pj4+IGp1c3RpZnkgaXQgd2l0aCBvbmUg
Ym9vbGVhbiBvdmVyICJhIHBlcmlvZCBvZiB0aW1lIiBiZXR3ZWVuIHR3byBmbHVzaGVzLCB3ZQ0K
Pj4+Pj4+PiBzZXQgdGhlIGJvb2xlYW4gdG8gVFJVRSBhcyBsb25nIGFzIHRoZXJlIGlzIF9vbmVf
IHN1Y2Nlc3NmdWwgcmVwb3J0IG9mDQo+Pj4+Pj4+IE1TR19aRVJPQ09QWS4gIFNvIGV2ZW4gaWYg
ZXZlcnkgZmx1c2ggcmVwb3J0cyBUUlVFIGl0IG9ubHkgbWVhbnMgInRoZXJlIGlzDQo+Pj4+Pj4+
IGF0IGxlYXN0IG9uZSBNU0dfWkVST0NPUFkgcmVxdWVzdCB0aGF0IGRpZG4ndCBmYWxsYmFjayIu
ICBJdCBoYXMgbm8NCj4+Pj4+Pj4gaW1wbGljYXRpb24gb2Ygd2hldGhlciBhIGZhbGxiYWNrIGhh
cHBlbmVkLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gSGVuY2UsIGJlZm9yZSB0aGlzIHYyIHBhdGNoLCB0
aGVyZSBjYW4gYmUgZmFsc2UgbmVnYXRpdmUgcmVwb3J0ZWQgYnkgUUVNVSwNCj4+Pj4+Pj4gYXNz
dW1pbmcgdGhlcmUncyBubyBmYWxsYmFjayAocmVmbGVjdGVkIGluIHN0YXRzKSBidXQgaXQgYWN0
dWFsbHkgaGFwcGVuZWQuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBBZnRlciB0aGlzIHBhdGNoLCBpZiBR
RU1VIHJlcG9ydHMgZmFsbGJhY2s9MCwgaXQgZ3VhcmFudGVlcyB0aGF0IF9hbGxfDQo+Pj4+Pj4+
IE1TR19aRVJPQ09QWSByZXF1ZXN0cyBhcmUgZnVsZmlsbGVkIHdpdGggemVyb2NvcHkuICBJdCdz
IGJlY2F1c2Ugd2UgbW9uaXRvcg0KPj4+Pj4+PiBhbGwgbWVzc2FnZXMgYW5kIGFjY3VtdWxhdGUg
YW55IGZhbGxiYWNrIGNhc2VzLiAgRXZlbiBpZiB0aGUgbWVzc2FnZXMgY2FuDQo+Pj4+Pj4+IGJl
IG1lcmdlZCwgd2hlbiAiZmFsbGJhY2siIHNob3dzIGFueXRoaW5nIG5vbi16ZXJvIHdvdWxkIGlt
cGx5IHNvbWUNCj4+Pj4+Pj4gZmFsbGJhY2sgaGFwcGVuZWQuICBIZXJlLCB0aGUgY291bnRlciB2
YWx1ZSBkb2Vzbid0IHJlYWxseSBtYXR0ZXIgbXVjaA0KPj4+Pj4+PiBJTUhPLCBhcyBsb25nIGFz
IGl0IGJlY29tZXMgbm9uLXplcm8uDQo+Pj4+Pj4gDQo+Pj4+Pj4gQUZBSUNULCB0aGUgdjEgb2Yg
dGhpcyBwYXRjaCB3YXMgc3VmZmljaWVudCB0byBhZGRyZXNzIHRoZSBvcmlnaW5hbA0KPj4+Pj4+
IGJ1ZyBhbmQgbWFpbnRhaW4gdGhlIGN1cnJlbnQgaW50ZW5kZWQgc2VtYW50aWNzIG9mIHRoZSBt
aWdyYXRpb24NCj4+Pj4+PiBjb3VudGVyLiBUaGlzIHYyIGlzIG1peGluZyBhIGJ1ZyBmaXggd2l0
aCBmdW5jdGlvbmFsIGNoYW5nZSBpbg0KPj4+Pj4+IGJlaGF2aW91ciBhbmQgSSBkb24ndCB0aGlu
ayB0aGUgbGF0dGVyIGlzIGp1c3RpZmllZC4NCj4+Pj4+IA0KPj4+Pj4gSXQncyBqdXN0IHRoYXQg
d2hlbiBpdCBjYW5ub3QgcmVwb3J0IGFsbCBmYWxsYmFjayBjYXNlcywgSSBkb24ndCB5ZXQgc2Vl
DQo+Pj4+PiBob3cgaXQgd291bGQgaGVscCBtdWNoIGV2ZW4gaWYgd2UgZml4IHRoZSBwcmV2aW91
cyBiZWhhdmlvciB3aXRoIHYxLi4NCj4+Pj4+IA0KPj4+Pj4gT1RPSCwgdGhlIG5ldyBiZWhhdmlv
ciB3aWxsIGJlIGRlZW1lZCB0byBoYXZlIG5vIGlzc3VlIG9uIHRoZSBwcm9ibGVtIHYxDQo+Pj4+
PiB3YXMgZml4aW5nLg0KPj4+Pj4gDQo+Pj4+PiBTbyBJSVVDIHYyJ3MgYmVoYXZpb3IgaXMgdGhl
IG9uZSB3ZSB3YW50LCBhbmQgaGVscHMgaWRlbnRpZnkgZmFsbGJhY2sNCj4+Pj4+IGhhcHBlbmVk
Lg0KPj4+PiANCj4+Pj4gSSBkb24ndCBjb25zaWRlciB2MiBhY2NlcHRhYmxlIGFzIHRoZSB2YWx1
ZSBpdHMgcmV0dXJuaW5nIGlzIGFuDQo+Pj4+IG1lYW5pbmdsZXNzIGNvdW50ZXIgdGhhdCBkb2Vz
bid0IGNvcnJlbGF0ZSB0byBhbnkgcXVhbnRpdHkgdGhhdA0KPj4+PiBpcyB1c2VkIGJ5IFFFTVUs
IG5vciB2aXNpYmxlIHRvIHVzZXJzIG9mIFFFTVUuDQo+Pj4gDQo+Pj4gSXQgY2FuIGJlIGEgYm9v
bGVhbiBpZiB3ZSB3YW50IHNob3dpbmcgImlmIGFueSBmYWxsYmFjayBoYXBwZW5lZCIsIHRoYXQn
bGwNCj4+PiBhdCBsZWFzdCBtYWtlIGl0IGFjY3VyYXRlIGFuZCBhdm9pZCBmYWxzZSBuZWdhdGl2
ZXMuIEJ1dCBJTUhPIGEgY291bnRlciBpcw0KPj4+IGFsd2F5cyBiZXR0ZXIsIGUuZy4gd2hlbiB3
ZSBkdW1wIGl0IGZyb20gdGltZSB0byB0aW1lIHdlIGtub3cgaWYgYW55IG1vcmUNCj4+PiBmYWxs
YmFjayBoYXBwZW5lZC4NCj4+PiANCj4+PiBJbiB0aGF0IGNhc2UsIG5vIG1hdHRlciBob3cgdGhh
dCBjb3VudGVyIGlzIGRlZmluZWQgaW4gZ3JhbnVsYXJpdHkgdGhhdCdsbA0KPj4+IGhlbHAsIGFz
IGxvbmcgYXMgaXQgZ2V0IGJvb3N0ZWQgd2hlbiBmYWxsYmFjayBoYXBwZW5lZC4NCj4+PiANCj4+
PiBJIGFsc28gZG9uJ3QgZXhwZWN0IHRoaXMgdmFsdWUgdG8gYmUgY29uc3VtZWQgYnkgYW4gdXNl
ciwgYnV0IG9ubHkgcmVwb3J0ZWQNCj4+PiBieSBhbiB1c2VyIGFuZCBzaG91bGQgb25seSBiZSBj
b25zdW1lZCBieSBhIGRldmVsb3Blci4NCj4+IA0KPj4gT2ssIHNvIHRoZSBwcm9ibGVtIGlzIHRo
YXQgd2UndmUgZ290IGEgZGVzaWduIGludmVyc2lvbiBiZXR3ZWVuIHdoYXQNCj4+IHRoZSBrZXJu
ZWwgaXMgcmVwb3J0aW5nIGFuZCB3aGF0IHRoZSBpbyBjaGFubmVsIGlzIHJlcG9ydGluZy4NCj4+
IA0KPj4gV2l0aCB0aGUga2VybmVsIG5vdGlmaWNhdGlvbnMgd2UgY2FuIGRldGVybWluZQ0KPj4g
DQo+PiAgKiBBbGwgc3lzY2FsbHMgc3VjY2Vzc2Z1bGx5IHVzZWQgemVybyBjb3B5DQo+PiAgKiBB
dCBsZWFzdCBvbmUgc3lzY2FsbCBmYWlsZWQgdG8gdXNlIHplcm8gY29weQ0KPj4gDQo+PiB3aGVy
ZWFzIHdoYXQgdGhlIGlvIGNoYW5uZWwgZmx1c2ggaXMgKGNsYWltaW5nKSB0byByZXBvcnQgaXMN
Cj4+IA0KPj4gICogMSA9PiBhbGwgc3lzY2FsbHMgZmFpbGVkIHRvIHVzZSB6ZXJvIGNvcHkNCj4+
ICAqIDAgPT4gYXQgbGVhc3Qgb25lIHN5c2NhbGwgc3VjY2Vzc2Z1bGx5IHVzZWQgemVybyBjb3B5
DQo+PiANCj4+IGFuZCB5b3UgY2Fubm90IGluZmVyIHRoZSBsYXR0ZXIgZnJvbSB0aGUgZm9ybWVy
LCBhcyB3ZSBoYXZlIG1pc3NpbmcNCj4+IGluZm9ybWF0aW9uIGR1ZSB0byBtZXJnaW5nIG9mIG5v
dGlmaWNhdGlvbnMuDQo+PiANCj4+IFNvIHdlIG5lZWQgdG8gaW52ZXJ0IHRoZSByZXR1cm4gdmFs
dWVzIHNlbWFudGljcyBvZiB0aGUgZmx1c2ggbWV0aG9kDQo+PiB0byBhY2NvdW50IGZvciB0aGUg
bWlzc2luZyBpbmZvcm1hdGlvbjoNCj4+IA0KPj4gICogMSA9PiBhdCBsZWFzdCBvbmUgc3lzY2Fs
bCBmYWlsZWQgdG8gdXNlIHplcm8gY29weQ0KPj4gICogMCA9PiBhbGwgc3lzY2FsbHMgc3VjY2Vz
c2Z1bGx5IHVzZWQgemVybyBjb3B5DQo+IFllcCwgdGhpcyBzaG91bGQgYmUgb25lIGdvb2Qgd2F5
IHRvIG5haWwgdGhpcyBwcm9ibGVtLiAgTWF5YmUgVGVqdXMsIGFzIGENCj4gcmVhbCBjb25zdW1l
ciBvZiB0aGlzIGNvdW50ZXIsIHdpbGwgaGF2ZSBhIHByZWZlcmVuY2Ugb24gaG93IGl0IGxvb2tz
IHRoZQ0KPiBiZXN0Lg0KPiBUaGFua3MsDQpIaSBhbGwhIFRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dl
c3Rpb25zLCBhbmQgYXBvbG9naWVzIG9uIHRoZSBkZWxheSBvbiB0aGlzLg0KDQo+ICAqIDEgPT4g
YXQgbGVhc3Qgb25lIHN5c2NhbGwgZmFpbGVkIHRvIHVzZSB6ZXJvIGNvcHkNCj4gICogMCA9PiBh
bGwgc3lzY2FsbHMgc3VjY2Vzc2Z1bGx5IHVzZWQgemVybyBjb3B5DQoNCkkgdGhpbmsgdGhpcyBy
ZXR1cm4gc2VtYW50aWMgc2VlbXMgYXBwcm9wcmlhdGUsIGFuZCBhdm9pZHMgdGhlIGZhbHNlIHBv
c2l0aXZlcyBsaWtlIGVhcmxpZXIuIEkgY2FuIHNwaW4gdXAgYSB2MyANCmlmIGV2ZXJ5b25lIGFn
cmVlcyBvbiB0aGlzPw0KDQoNClJlZ2FyZHMsDQpUZWp1cw0K

