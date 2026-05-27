Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEB4CD6E48
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGbA-0007hl-AA; Wed, 27 May 2026 11:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wSGaq-0007ZI-Sf; Wed, 27 May 2026 11:54:53 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wSGah-0002Pq-U2; Wed, 27 May 2026 11:54:47 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RCsRFv2703983; Wed, 27 May 2026 08:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AlkCgrIaEd2IxlmJHTFTE0oyKh742OLqdunztNrSX
 pA=; b=p+z1Zs/nhxJD+L9IvCssmwFVy85ilgM8RH+hHRX8WQfun/5GdbvUDad0f
 XXegmujF9BGJnvoQXYeh+H/mPLvf1waoSp8un3X1F1PecZjyG5yMDb9TY+JSZO18
 1O/dHaPKis9AgpKIWZB4UneK9Ek4RwjmI77ZIFDcE+iAJT3HzAc3IQnYnnCQEyhH
 JjsAB4nzkieF2jDZPpnclvyxgf4kbOxPhgSZiAjKpoP5ZUOgmHNpUeJUYjZue3y6
 /ohbqBdSrHkEqcQcqE1Ez7LWaWimGwov/TGS1yUckDh//71+hrgNQwhUUYeQo6eY
 5WgqNdDRUuUgniygfqVO34T6OQb2A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022128.outbound.protection.outlook.com
 [40.93.195.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ed82b45jt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 08:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQA3LRajvni49TYHyK3QJDi29RMPNLkk/Nr4ocBJt2waRcoVGmVenKCssc9K8PM1b24TWeB8UxweIFMqyJiK08zKNriB3Zm9yEL1Wh4w7zlYNQVYfs8Nirm0Oyq8g8dZ7buoNoM14FAKPZnrGp9UYVO4VoTsRsbjAZ2fZgZzKf1HVUS0zexLZaD6J0yIv/gH51bdRmeqvyyjN2LsWB9n3qF3TSp02pOYBaz2B6FsGS27eiwogc1DQ11twFT+mp0W2wOKi4Hglvp/5dzXH8VS+4joI4lwW2Znxs2e2wxK23SNwXAhqtvh5aLAeRWYcIMXIE+Qb6yz8aR2W3uyirWAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlkCgrIaEd2IxlmJHTFTE0oyKh742OLqdunztNrSXpA=;
 b=vkceFpaGmYGjmq0ksYBhJeP7lKHL7i///H5HLBpuLTmo3BDE4waBhqiN2hFcQrMaAxOJVt28rAOj7GOmz+pS9DCREOo5CcDk2u3GV8ZsoUAFHJj4QIVTV4m7f6HC5aWYERRWvvlr3x72pcQXe0U0EFynXjSRtB63VZ5pgh7etJTPkB/VdbKeSen5feT14rY1N5znA6qGhAQfFsMfVPUPHFQO7STgveGfjEA6TiW3AkR5R9dQRIlpxs3vC63N1mifZvgLZsI560gl5QQ8qb549ZCoK0UiHPe+FtzB5yP2gkqxygAd1lCDOKavt1i1GW1XeC0eTAnVQF6Bq4a6aEEzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlkCgrIaEd2IxlmJHTFTE0oyKh742OLqdunztNrSXpA=;
 b=VBOYuyY1UEi4aM3R7MuI8Op0fjipbf/geGz+SthBV4GcAi+hTAozlUZM3CvG2X+FyEYzFn098v7dwMPPTeU4S5emwHtN2efFLYOYiugQiR4ZTH/mJ306pVnBaME/A+ND4zf8Rd+Fpaozl+COupicvJoPW76r9/luUHROe9DyY1x6+piyCttNbZk7YfEgdyq/OnF94zVSD8b2kddLbkDkq3WuwnesaSv18DHCIooGUDBLzGppXZqiZZOrXpEmI19uSyjR2B0OXiauu+3p2M3RzbNnsvAjQMZrlFC7ol5sfQvviplBBjEBsj4QL5q+mxh5pmpcGziUHvOa/ECKKXjs+A==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by CH0PR02MB7865.namprd02.prod.outlook.com (2603:10b6:610:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 15:54:14 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:54:13 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Shaju Abraham
 <shaju.abraham@nutanix.com>, "yangjinqian1@huawei.com"
 <yangjinqian1@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
Subject: Re: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Thread-Topic: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Thread-Index: AQHc55O/x+/NiUinyE2TjkVGnlGvpbYiAA6AgAAQkoCAAAJLAA==
Date: Wed, 27 May 2026 15:54:13 +0000
Message-ID: <6CA1EBCE-BA44-42A1-81D3-1A723C6F0CC3@nutanix.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-16-eric.auger@redhat.com>
 <E5402D74-AE00-4088-801C-C87A749E17C9@nutanix.com>
 <80fa5157-2376-4010-88b2-deb6ab50f87f@redhat.com>
In-Reply-To: <80fa5157-2376-4010-88b2-deb6ab50f87f@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|CH0PR02MB7865:EE_
x-ms-office365-filtering-correlation-id: bedb2d54-48d5-4842-2d3b-08debc0832d0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|4143699003|56012099006;
x-microsoft-antispam-message-info: 7NYQ2OK6+hs70ahMnDX7qcIR7p2Xw2ebtosIJCA0xUHXzkY21ZE4X0AO4KvL7dBhs2nSnxK0Iz9iVUrUUOnFyb/6T264dsaMXpSK3GHLOWoeFw8KVK7XvBaC0Q/RYrinWGZGCB1se4r+dMH6g+pNpWe5t+3RSHBbr3Iu1C3kpR4ppXjbwPvtkF5niTjzmXcXOmr4VsqjrMAWPiYMC7JqZ9UyHC+PoTB5zUOsK9D1DEaIgkpLeV1EmThhsad4QtAXU8R2TgVzJoNbPBE0oyuX/GtOz5kabZlKCKfM1ytgQRj1hrjqU40lK4g6nRzaWtoM8Yk5ja+d7gyhjZsXjBFeNNgbDtbiuqZoJdXQPG42Dn70G+lvKgB3YraACuuCxaCeViAOnk8Q4uX7IciXkB5PMqCJE3BgFOBKhK82BN9bSpmCIbwjpUm3JpJWG5jrUSMGFBeJqdIge6Kd8GIE6vYNFtYo7sOMLbXz7cl4gNNgGrzXftGJVtM7LfZM1n0i3RLqsnK7jnrrwECI/xvbSKOnztNllT6eV2HBVtfBd3NR4Utekn+m62sHPI6XbkTmmjC6NhBh+RNpdRKfsfRH9nKKZupQrDCManrEIYta76Rz1c+8hj/KSmELhHcuhMaOE2MlNpuDZWrPgGiiwz1AB6v3zPCjZL57zRvu/W4xTgBr8M2HnZ8aMYorYV4bscVILkni6NPJ7llTeNcnCOj1n1XpXvlnbdRacFe4W6tGot54FIj8MCogcT3XoBxXpJl2m+KO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0l4YmNHekdPWkFNZFhJb1hBUm1sQVJqVDFIaTEwdDA2VkVNNyt1dnh6SDdn?=
 =?utf-8?B?YlduQWlpUTdrVnE1ektCTUNOQmdPQ1FRcjZJUlNtTnpwOUJBSkdQbkZLTTJo?=
 =?utf-8?B?b2tESDZpSjFoRGFHTjhtLzlOYXFNdG9OV0FVZkp3REN5MG1ZNE1CTFZFdU1K?=
 =?utf-8?B?TllSMWJTUmNsTmhab0ttdnZVZDkwKzhaU1dGQWhkM3VyZDM5KzNOYUtQeVZp?=
 =?utf-8?B?di9EYjl6UDVJSzM1YzVqR3VFdkJNbWgzNW1JelUzRlpKMzF6TlpuRGhkRVNX?=
 =?utf-8?B?b0pLSzRNemxZeTNQaWZmWTVXZm9BSTNIaTVoR2h0OCt3d0NObFU5ZjhsSkFS?=
 =?utf-8?B?eW9SYUhOZm1mV3V1OFVJajNhKzFIZDlVcTNYekF2SXFrcU9uYVJBZnMrNExX?=
 =?utf-8?B?UGFSSjRZTUtxcEZEMnRQODZySjdydmxlWHdicXB4SlFRN3J6QjY5M3dsVHRi?=
 =?utf-8?B?VzF6YXBFMk95anlnVURiblZBZjgvQkdOWU44MitVOWNwMTFJN1I0MWN2SERW?=
 =?utf-8?B?ZjNvbFdjd1FjUmJGZGVxTlV4VWszbkwzd3pFLzNNQ0pJZkh6VWw1b0ExcVdT?=
 =?utf-8?B?OWxXWHBTYTZ2ZkFRMnhsMVMwbVU2MmhaZHNJZVFQUUJDMCt5eTZLd0gyVitG?=
 =?utf-8?B?b01nb2gvbm5Fd2hrWmVNQ1pVV2F2VWJqK3lPN1c1eEFBYkNBOEZJWDBxdFFq?=
 =?utf-8?B?RFZMVlNFM1kzcy92U0J5ai83UHN2K3lIaXNFcnpGRkhhV0NNMlk2cEZoMGh0?=
 =?utf-8?B?TjhmTjVzdldoN3JpdFJ1U1R2Z2lNekdCa3NrVmpIZ0dFSWJubGo5cjdycmpm?=
 =?utf-8?B?Q3FOQ05mQUdhZmNDYUxjNGYwcTgvSFNsNTdaKyt1NGxEVGlDL3hYNnQzMXNK?=
 =?utf-8?B?SGQrVkMvWkd1MDRreThRU0I0alNsS1lnN29VSHpFa1ZsbEhCYjFvalBmU2Jx?=
 =?utf-8?B?YlpYUDh4Z2s0VjVsaGJ5dllCNDMwZzlPSVNnc2c5eS9CeXl2SjdjR25DZXJm?=
 =?utf-8?B?a1NsMkdkWERzRjVzeFFDeGFLQzBMRnA4K05GenZKa2NYcUtEKy8vSVdPU3pE?=
 =?utf-8?B?RmlwdDJvQ01mYVNUbmY5UTZXbXZ4Ti9EbDBETEV4dE9TR1RpVFZOUjhXSDY1?=
 =?utf-8?B?QmFoMFU5anpKK1VXMWZIamJ2eVBUc1lWaTNqRkFiNUhGaTJyaGk4WThFQVZ2?=
 =?utf-8?B?YnJmdnhBUng2R1BQTGhJYVZ6OXRNUTE4TWNUdDJ6UGViM2NaNzRuSmhQYUx0?=
 =?utf-8?B?YzI4VDNSZHZiSjNOb3lYRkxSV3ZWL1RMTmNDTUluYXRieXlUQXN6MlhGRFdz?=
 =?utf-8?B?N3lQUC9nSWZSVS9jVzRlbS95M3orNklkTi96UTVCMGpkNFBLS1pZdVZhWmlr?=
 =?utf-8?B?MUdHcUFiOGdNc1ZVL0h6N3hZcmQzcUNNeWNTMktEZnRXTENmczlsUERwRS9w?=
 =?utf-8?B?TTlJaEI4SXZ5QklqTnoyWDVyM3ZVSTJwb1ozL3RXd1czMjREcnd2clo3aWZp?=
 =?utf-8?B?S3d4U05LQWF6SnVXZDl5Y00xaGRSQlUwRDFqN3kxTklTWTZRSDJpbVRSN2RV?=
 =?utf-8?B?NUdEa3dDcDNiekY0eGNUSEtOM3FNWWpkK0xuWGhobFJmNXZjQ1lBYVVUN2th?=
 =?utf-8?B?Tzl3N2tSQVZkYnlkdzBQaXB1b0dQTTFSaitvaklKRG9DTFcxYVViRG5aNHpE?=
 =?utf-8?B?WjNZbUo4T1Jadm96cUk3VHlDYkh5d2M0QnA4TmozRjNFWFpZZ1p2ZGpwdE45?=
 =?utf-8?B?VXRmZ1M5czJESEtaOXBYdG9XLzdNZGlORm1sb3FvbjU3TVVBRVlFeSszZHp6?=
 =?utf-8?B?clNYR2IwZXgvRlBRS3ZDbVVjRmVaZjJFT3huc0plQW83QlA0Z0loNXhKUDN0?=
 =?utf-8?B?STEvL2RpZEc0eXMvRHJmangvUEEvdmNBeWN3Y0hLUm9MNUtJK0M2V1lCV0xF?=
 =?utf-8?B?ODFjVDhmY3ZpUmJBUHhWbkh5RjkvK3lua0RXV0s5MThobXhXRW9jZlRML01L?=
 =?utf-8?B?ZTJKUW82NzJjdHNWVlNIc3VIRFAwNmNQOExRUGt3N0hZSlJSZ1FmUUQ0TU5l?=
 =?utf-8?B?b05lUE5IQlBOVnQzUUpJeU5zTUtTYVpoVUxnWHVyYUNqbGRjS1RmcFMxUWNE?=
 =?utf-8?B?UkhOcDRURjZ5QTBmY1V2WnJMNmNnbkJXQklJVUd4YmM0Q25sU09ub0xKNCtz?=
 =?utf-8?B?V0lPeWE5Q3hXMEJXODArbFpSMThpRnIrL2FXa2J1SDFrRzJ6QWgrQWVLNTRn?=
 =?utf-8?B?SHpWOUF2eUpTV0lVMmIwbjRFaVVqY3F0ak5jUW9zM1pXa0M1OW5TTC9wU1VC?=
 =?utf-8?B?cmR2M1pYMittdnU5TkNKNnRrSlJRN0VmMm5kNXd4eldwNHFoekFjRmxoZ0VC?=
 =?utf-8?Q?JzfiNszr12Ky2vNE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7485F0971534249AD5E7D206AC17DF5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gaaisgys7qpwjqvFPOo+CS4BKIqNSkLO3DjdhaBOH2kqEpWk1wLXrYeiDVwGSNe8Pfrtin6ki7ngprK/5C7Ugo9GrSPZDux7Cfz49U7IuCl4pbHUO/e8dyAshMQ0W91cvXIODOOkYRcrcFSZz+XBglbUjrYSjm9V01FT3mCS6AmHTy/VzfCXdLVeK2gnby2actc2N/71w6Zd3Ipv4yZoHsqc1d2KsBEjdBnVgVIndLphBY7qG3padP2UwdefnmAOPySu5oV/RgdFk1vwxd560vaofE+8rkpQhG+WZX8rgxCVpa/qWuFL8S//BYcxkV5bPhkS9JBCGuFTEKPS3khIBw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedb2d54-48d5-4842-2d3b-08debc0832d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 15:54:13.0888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fzxs0xKsrK833tFLtzjRFDORFy55RVYjaGCdahWXjjSdMx4qPEo6QlcpR/te7/WKh6rPvNuwsaO4S6Axo2jaABJxtSodochlX3APS8Q2I4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7865
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1OCBTYWx0ZWRfXwvdPlSJR6w0W
 zOEETQRfzLcqQU9iI8DZac7yRvYiFwgPw2EA8G8VeMbBFDAxX7ixG/Fb6YiilH0PF+6rYojbH/I
 PsHSkJ2/qUfnTix2IDim3KPUoFd8aQRwYH6qxyg+WLOsk3O31IcMNcz4yiqGuxGA/ruDj6AfPlJ
 214qR7hlEJ2sus4oz5nssx52ID4GpIv6wodBWX+acepcJTBXahRZYGbsnwQYmThlDRTCs+SpVwH
 977Po3e8LmUaKrTA3PPa/g6Ng5+K04FSV24pJPlzAU9xpaMF2MiXUwmGNY/Gx7etl5c8pml8KLg
 YdewEuDw/xYD5fnB5ozIoHVz9Wju7f3pP6rX41lpa1lJFby1XvXdyATRHoRksLK4iuVGQWurQfM
 lvSF2XsVV0wLMeC8JSQz/eGHq+qx1p+7MySBe/+eH9XwRIpsjsn6DlMoexVdDpipkt6uezd9UFq
 AdM9rofCPDm2nnPHMcg==
X-Proofpoint-GUID: rXVMe8FJ7NSQN6Zg8hFezdWlHm6bN1ZC
X-Proofpoint-ORIG-GUID: rXVMe8FJ7NSQN6Zg8hFezdWlHm6bN1ZC
X-Authority-Analysis: v=2.4 cv=E9j9Y6dl c=1 sm=1 tr=0 ts=6a1713aa cx=c_pps
 a=+WkigaN7fx4UYWmYucrQAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=20KFwNOVAAAA:8
 a=Vdo1IMNqAnvnvvdoPsUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=khushit.shah@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gMjcgTWF5IDIwMjYsIGF0IDk6MTXigK9QTSwgRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IFdoYXQgd291bGQgaXQgY2hhbmdlIGFueXdheSwg
aWYgd2UgZGV0ZWN0IHdlIGhhdmUgYSB3cml0YWJsZSBmaWVsZA0KPiBtYXRjaGluZyBhIFJFU3gg
ZmllbGQsIEkgZ3Vlc3Mgd2Ugd291bGQgY29udGludWUgcmFpc2luZyBhIHdhcm5pbmcsIG5vPw0K
DQpBdC1sZWFzdCBmb3IgbmFtZWQgbW9kZWxzIHdlIHdhbnQgdmFsdWVzIGZvciBlYWNoIGJpdCBp
biANCklEIHJlZ2lzdGVyLg0KDQpXYXJtIFJlZ2FyZHMsDQpLaHVzaGl0

