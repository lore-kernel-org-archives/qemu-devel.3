Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6B4CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHX8S-0000pj-L9; Thu, 15 Oct 2026 21:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHX8J-0000p6-1G; Thu, 15 Oct 2026 21:53:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHX8H-0000fX-A4; Thu, 15 Oct 2026 21:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792115596; x=1823651596;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6NrTS7A0yECYaDIjTJxL8mY788DOKxUfbphgrcY0E6Q=;
 b=BwaHkeJPohpb+9sh7jtYMot4Iq0O+Ha9flc8piqpmMmH7pQpsx8zQs4f
 FZ0mIqOuT2o/XzZO+Q3oZ1esCSCUCjbLJNkRLaRWFFubVjXACWyLWPNYI
 2z5ngWZ8vZdjmB6tq6onjw/csv/TDK9/kmTIqlBKpU7jmS3k+VOSJa3//
 zTBcmjT8ShmEgrcjvPaYjWmdq5vFAGQYF303+DMtmFiHqdi8lK5Nru4S1
 Y1iU1qv/JqlxXgJErFxGbi969x4Blvfvlt/OJV0bS2YpKA/A0gkFoqYAA
 U7kbpiyBouFQ7TZLBRkcR5ehNSgcdG6Gv0QiQWYL02mMPs3pDAPCnUmPk Q==;
X-CSE-ConnectionGUID: O24nxCmmRNeDjnr84ekbkg==
X-CSE-MsgGUID: VvEpdEm4QDmrFrtDJUnvYw==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="158113376"
Received: from mail-westus2azon11012037.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.37])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 09:53:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2mTzQ/lsm0HcQgy1/JsIHVWLgxDHtCs9Ti7B55Wg+29TVG2VtCXyy9V/tiao5ysa2DyW9c870YJ2ok8+kYI94z1k43dojkeF3m3nTal49fZFwKJY5E3RG2F2CPvJ0yMj9592s9hWNrkuYe+ji287xSC0eQqtg7bGk5Y5E0hR/KkkV7eHCvO2vrDEnqy6kgmnRTC5VuHeNjn9GrWY5LsxnRL5BpPW9mqRAyFGmj8uQGSCfG/tgWlsGa/kBI2zxd6i/RfTzZ1o1DRX03dU8b7xJ7IiBGR8OkyBNi5XFdrvMfOibZhYrUQo0vbeL+LyLJZbmZfcZnbUwBFEMyxuPSSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NrTS7A0yECYaDIjTJxL8mY788DOKxUfbphgrcY0E6Q=;
 b=BvZGsuxY9vVDjKXuVaCJyc+iUpVhcrfQc4PldNCcxWh/PmFoxoldS+zCLQ2swrohnDrsh11lzmeLlN2MyAF32KVNJhofoYIS+jD2PCRCgWJksEzO27JnxjHq3WBZGE1DTzoE18kihXNUjtuv/ogu20/SVM46eu6/FmPpydIQYw6KZQ6KXsy2da/k2Rbea50gBv0UbrqTL/icPnLpxvhKUl1FiFeTYs9bCBMjQQQ8OdtpLVyZODUgF36G6IjNPWRTiFg47JuVvQuwvRkyQCRzDhwdH6VdD64fmiwlFDGGOVTH0kQdjZ+dhqj3qhc15mkH3zZJnq/GImKQX4b88aA5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NrTS7A0yECYaDIjTJxL8mY788DOKxUfbphgrcY0E6Q=;
 b=xgRcOs4ccbgIMJEMDqg0YOUFFG0dEANgD/Q8nWVUM5danNGY6c17f7QMwYbwYzZ6Oi9umFparUZ0Sf/gqTvrZEB3X4JUoZ6qnOt4389d7bx6yWgQyiHthY8Y5CmmC9Ecn5APtBD3XSzjSO/b3YolUWHqOZm09/+FtZp8PnOiQxE=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8888.namprd04.prod.outlook.com (2603:10b6:806:38e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 01:53:11 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 01:53:11 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/kvm: Reset vCPU on VM reset via
 MP_STATE_INIT_RECEIVED
Thread-Topic: [PATCH] target/riscv/kvm: Reset vCPU on VM reset via
 MP_STATE_INIT_RECEIVED
Thread-Index: AQHdUL+6oVlFAgHDTU6bAJD8wn9A47b/gLEA
Date: Fri, 16 Oct 2026 01:53:11 +0000
Message-ID: <674b6713827b986e72e26246f4123769081d2937.camel@wdc.com>
References: <20260930093940.117729-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260930093940.117729-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8888:EE_
x-ms-office365-filtering-correlation-id: b421e653-abce-400f-e8d9-08df2b283bd9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|23010399003|19092799006|38070700021|56012099006|261009223027099003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WxO4GaJUtqQBGWvAwMb7F5t0/5pszvoeaVyWaXTYe4kaC8gYInf6kwIbTiAboo1RF/ngHb5Ba7X2tH6bmz2PzBXRSXHevP8ejCpMmjdRjKvRHiuJ6JEMjiTk+18Ftj2RwTLP4uE4TltzXsJB6y3fRRIwL6lldx9VyFN8sUCuL0B2I3GyCOrxz9YFjoz6PjNc5u+Tlpy2CHN9ri8qjvxTPqdg6lqeEKOQrdDkxUsIHRY47QYZFVjxjL6UMxtmCCOW4UGVX27Cqd3w4mUj40xJmu0VO21oe6GsbVT/20cGzOyjKGy6DNYErm2RQlCY6Iu7koOO36CO/5+f7rNqCcfxaXVjZYiqz39Q/mipYAmu49jGYY+lyyF3cR8u5AW81JFXg75sCqg5sfP9t2HRns/sxX47nucO7ijeCPdf4X3BA12GRZMomdCk357MfU78cdyTfrIcNnAFwMhmz0GXd8MJeHjdrRGZpR7fqypGbMy+ONugLf7bOFcUajYtiSgK7lCOrBwVPcks/pv6JaSAnqlpK9FYWX4g69YhTWUKAznqdC/ZokpApOhDgZqNrmYs2KY9vTcWipdYn1FtqgWonqT4CQ5nRnMH1aRfyZdlXTZUhHj9NAtKF18RdjJKcswIF4GJQqt6+8XTQp/52e7P6kalp0vaay76t/U3JHCcPqNmy5MFFYCoaqgrbiPTFKovy7uH7/+fnX64cK93hGbNK3qCM3e5X/bxm9VVS4q46fOsEUE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(19092799006)(38070700021)(56012099006)(261009223027099003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cld2b3BHYXppYWRtTnU1YXZ3Nno4ZzZEZjBsRmRkblQrQ3h2T0xHdTd0QUly?=
 =?utf-8?B?YVdsVlJOYXMwUkRsS2tlY3hZa1FuZ1JPUGxCZ0VGYmsxQzVUNjZvd3l0b2gx?=
 =?utf-8?B?TVBBd1BVRTlCVFdRQ2NPY3M4NWo4dkRsblNsSVpucGl5N3p6cHRuMXF5eFg0?=
 =?utf-8?B?TFRPZndubEw3Z3VEK0w3blNCb0ZSM1E0d2J0Uk9xbjFDU3RnWWdYaUJPQWF0?=
 =?utf-8?B?VmVXWlRZNXpHYlhrM1lFUVNwQjdDSFkxQ0NETm5UTEFBUEZjVXBqNjRsWnFq?=
 =?utf-8?B?YjVZVCtTd21lSzJvQytZMXFLVUpKMHh5cEQzN1B3eWRVQjVnaWl2UENMRlNx?=
 =?utf-8?B?bmtPSVlISnVTVXNsM0Z0WTF6cVdtTUpkOTZQemNxdzkreVdHWHVBTzN1b0g3?=
 =?utf-8?B?cVdXMmhqL3lWbDdEeVFvS3NTL1MyLzRxdG9XMkF1MUpjQVlzYlh3a1pVaXkw?=
 =?utf-8?B?djdmTWJScWl6L0dSLzRCM29YK1NTL0Z5b0xHQi83LzZtWjhDZDZvQ1BSRTRX?=
 =?utf-8?B?ckVJZFdPa0p1akM1Yll0VGdOcHlIcGNXRWpyN3BmbUJOdldyTmp2VzY3T1RW?=
 =?utf-8?B?MW5lZy9PekdXVXlDL1p2UmdCM2oyZGtWZ0ZoQ3hObm9nSnlNVDZjbTRTR0Fz?=
 =?utf-8?B?MFZ5MmRKa0hwb1pJV1BSa24yaDlLaDVNRHB2UnB3clpNcmQ5S2M3ZHVQRkNy?=
 =?utf-8?B?aUp6cnM2UmRVcWQ5Mk1CODRtWGl0TkhjYVczb0xFcTFyOWFFNCt2MEZtQVVv?=
 =?utf-8?B?aUNwUWtNNXZPMWpSOFMxNHpOK2FDNlRRd21uL0xXd0Nyc3dENElVYit4ZmtJ?=
 =?utf-8?B?ZThBZ1dRMXNWU2pPZmhXOWszeHkzQzR4NlFURWl3UldNREVqdkU5QW9CWFdi?=
 =?utf-8?B?QmptOWUzQXFWM1haamcxTENyTGp4Qkx3YzBzTEtMR25CSzZlcmFBYlo4NUZF?=
 =?utf-8?B?aG5XTkJ2dkoyZDhnQ1N1d2ZobGlxa2lyT25Qa3RLTmp0NFRsVEx4bnhyL2ZU?=
 =?utf-8?B?UXRpdWVkRWlCczMwY2xOM2tSTEI0b0tBZFA1SzhVd0syTWlCakpmVVdPdHhN?=
 =?utf-8?B?dlhqeStVRzExbXI5VVBPZGptcmtCNjJ2OEVZSFlaOEFlRmgzanE0K0hzaWFi?=
 =?utf-8?B?U1lCMXJ2bjJYTVYxNkNETTdnTmdTQk55U1hNaFNmQzZDZERxVktjRDVIQlJw?=
 =?utf-8?B?NjRoY1hHeHZiRzBxVmRuNTZObjk3UUljUGtQU1VIVlVSMnZUR3lUWGRkVExp?=
 =?utf-8?B?UHYyT3hOWHRXdFJ4V1F0ZEc4aEVDYzlFZUF4SHZ2emlacmpRM29JeGg1ZHFq?=
 =?utf-8?B?MnliOEduT3JSSm8rbHQvSEIxWVl0RnRxYjFpRzJxQ2ZIV2hCWjgwUjV6a01Q?=
 =?utf-8?B?SE5JR2lZK2ZqOTE0ZFdFdHhOQXRZbmZOVnJDM2JxZURMeU8zRTgwQjV2UXJE?=
 =?utf-8?B?UldPd3N0c2k1NHhvendUVVhGYThTekN4YjQ3V0hucmgyS2UyU0xUV2xtbU14?=
 =?utf-8?B?MlR3TUswS0sxTDNrd2tWa1dmbVgzOFNOemlRaGNKWlB5dU9RS1duanhmOEJi?=
 =?utf-8?B?NUg0NXNOcmRGOXZmS1AzRTV0Wm1jdWtwbDI0WkRLa1JIdXE4OHE1bTBoQzFM?=
 =?utf-8?B?RnR5TlVoYXNIWFp1c2w1dUxWcmQ5MEMyL3g2SFVEWGF1cDlDazBSdWl3WjMy?=
 =?utf-8?B?ME5wUzFxT2hsdkpFNHdFVFNKeHdPcURZcFJ0S1ZtY2U1ZEZDUkFXUU1kQmJr?=
 =?utf-8?B?V0tmUG9xRDY2d0tFRllKckQ3eTlIdW9uYXRYc1RnOGtiNXhUMCt0RytMY2tv?=
 =?utf-8?B?UXdxSG9PZzRtQXVzSmVFVGtBTU9qbzAwVE9lRldKVTZZS1lZMHpKZ0dueU5G?=
 =?utf-8?B?WnRsSHNWUUZxWldOUWxXRm94dU02MHdhdm12Lzd3enJzMmVNUmJVL0QxNTNF?=
 =?utf-8?B?cityVWdMK01Ec3ZpV1ZwekI1aVFEdUJMMnZXVDNyaS83c053VmJBWjBRcjg5?=
 =?utf-8?B?dHk4R2h3eVBnbWlwYmFsOG5PcTNOUDlxYjI5ajJ6c3ZZVjNXUEJWeXd1eGpP?=
 =?utf-8?B?b25GdmgzelNDTHRZZDFWMUk4c0tFWDcxY1VEQ2JtbkVFaC9UQWV0M1JSS2RF?=
 =?utf-8?B?MUN2V0htNDM4Q1RlUHVmRDdVN2hQM2JCRVIxTVBsdzVoRW1jenBtTm03MVlF?=
 =?utf-8?B?ZzQ1RTJtN2dZOWMyZHI3TktCNmNYRnJGY2VFbG1sakZxSzB0VDVYMEpMM1Jr?=
 =?utf-8?B?bDVTaHFUNGxYcEJiR1RicVN1enFBdUxjbjZpeVRuSGY4VU5uTE0rbzd1bEg3?=
 =?utf-8?B?cUxvUkJsb2FZbk5OY1ZGRFJxanhxMGg2b3hiUjBaYW1UanFPRUdKbkF5bEdB?=
 =?utf-8?Q?zwPo0KD1652+usTKXdkcMi4JksV/gw/0YtlLQIiwM9j7l?=
x-ms-exchange-antispam-messagedata-1: JGOFnSX2XaJemQWa8PR7Sxw+7AqviRKE3ss=
Content-Type: text/plain; charset="utf-8"
Content-ID: <605F24E7DE430E43B8FDC9D9B0623890@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k+9CLR6dDRq4YiBBd9HgrXqhthoaUZ0MnmBRpnN7Mzrw/RcHY0/VyTIrraDap2TXzPCPJ+59TuAHT2ac/fU8shLavQOQPWZPX++LNcHC4zDxQW2hOfcgcJ0uPu+3Fgj+q9fvTFDZ/iVYUnQa8ud8mXtcCQ/Kto2j3Jp6OxH5IuQm0K1Z3rSkfvBWnEf/60GaNOEsWUv8ib7LsIClpWqbFveZWlp4qz7WUtBIoL4v1kxg9fS8YO5BEhF2Cpp7nAOnUHFSAcjGKT/2kq3uPM7IWmJZZTlyhJufmRr2Zaqv0/RpgheF/IPbvd5bn8NDYd9rFp2ly+oWcKKG+79OPsjX4g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Lyl3D3r/m1jWV+zlKwfTNO7xbXU55sHuEqof4WH8is/VhHXlf4g0Ra0uAz0JzTB0l3Tlj0E6xCdZpSpe4yz5gbpOrq68fAi1LRhXlspLLCP21POP1gBFKwoZORS+MxUphKcQKfygnwOigZtJbKvclnqrmBmL3QKNUAXuqv7j7kexRr/4s6FfB/cOINO8bREelAsRXZfW9kxC3O0wPPUNqMzK82lmIIl1XOlcNW2MwUrxB1TwdG2euAN/KEQGi1wRgUQ/zxgG+j2jP0nUxBZzBgJJxb0ZRLXkmh3xGK43+LSmIDzWu5QRRcK0cKrYCbDHajVsJ6orc51rm6I6bCIrUpvDB1acniO/u8c+t1e/cCePEvsVEBBb4OOtGcSxVwzjvPpym9OoTRoFkK5R/PtL5d3/sP54BUEFgWeA5TyX80/1rKeHI3kuCOoBNIJ9daxBXB7WxGMN8x9P8uiDP1bu2AKIF+EXj+kELgZ+/7LVprBgW6SUS8EOx8MKZCowNM+CYjUvJDo4yc7tb8lhE5fKJp/XZME/hgr/XKFCa2/P7U0/jK0FCCkm9S0ozoyLX0OAv3y/SN7hSWpRcuYImoJWvS8rGhmV6aKVPLMVudE4N5g/VtNyRRu0pgOAuJha1ZVb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b421e653-abce-400f-e8d9-08df2b283bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 01:53:11.2190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXDH5ir2F2R7kR61BsA3X5ShssHXtX7z8FnJzIplV9Dco52zwbYtZC/SPqV97h0iNcyxL6iWtOta3zn9IXs+IgCSK4IpPafiIHw7x0WetX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8888
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE3OjM5ICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
V2hlbiBhIFZNIHJlc2V0IGlzIHJlcXVlc3RlZCwgS1ZNIG5lZWRzIHRvIHJlc2V0IHRoZSByZWdp
c3RlciBzdGF0ZQ0KPiBvZg0KPiB0aGUgdkNQVXMuIFdpdGhvdXQgdGhpcywgc3RhbGUgS1ZNLWlu
dGVybmFsIHZDUFUgc3RhdGUgKHN1Y2ggYXMgdGhlDQo+IFNCSQ0KPiBTVEEgc2hhcmVkIG1lbW9y
eSBhZGRyZXNzKSBpcyBwcmVzZXJ2ZWQgYWNyb3NzIHRoZSByZXNldCwgd2hpY2ggY2FuDQo+IGNh
dXNlIEtWTSB0byBrZWVwIHdyaXRpbmcgc3RlYWwtdGltZSBkYXRhIHRvIGFuIGFkZHJlc3MgdGhh
dCBub3cNCj4gYmVsb25ncw0KPiB0byBmaXJtd2FyZSBjb2RlLCBjb3JydXB0aW5nIGl0Lg0KPiAN
Cj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBLVk1fQ0FQX1JJU0NWX01QX1NUQVRFX1JFU0VUIGNhcGFi
aWxpdHkuIFdoZW4NCj4gZW5hYmxlZCwgUUVNVSByZXNldHMgdGhlIHZDUFUgYnkgc2V0dGluZyBN
UF9TVEFURV9JTklUX1JFQ0VJVkVEDQo+IHRocm91Z2gNCj4gdGhlIEtWTV9TRVRfTVBfU1RBVEUg
aW9jdGwgZHVyaW5nIHRoZSBLVk1fUFVUX1JFU0VUX1NUQVRFIHBoYXNlIG9mDQo+IGt2bV9hcmNo
X3B1dF9yZWdpc3RlcnMoKS4gS1ZNIHBlcmZvcm1zIHRoZSByZWdpc3RlciByZXNldCB3aGlsZQ0K
PiBwcmVzZXJ2aW5nIHRoZSBvcmlnaW5hbCBNUF9TVEFURSwgc28gbm8gc3RhdGUgcmVzdG9yYXRp
b24gaXMgbmVlZGVkDQo+IG9uDQo+IHRoZSBRRU1VIHNpZGUuDQo+IA0KPiBUaGlzIHJlc2V0IHBh
dGggaXMgcmVhY2hlZCBib3RoIHdoZW4gdGhlIGd1ZXN0IGluaXRpYXRlcyBhbiBTQkkNCj4gc3lz
dGVtDQo+IHJlc2V0IGFuZCB3aGVuIHVzZXJzcGFjZSAoZS5nLiB0aGUgUUVNVSBtb25pdG9yKSBy
ZXF1ZXN0cyBhIFZNIHJlc2V0LA0KPiBjb3ZlcmluZyBib3RoIHJlYm9vdCBzY2VuYXJpb3MuDQo+
IA0KPiBUaGUgY2FwYWJpbGl0eSBpcyBvcHRpb25hbCBhbmQgb25seSBhY3RpdmF0ZWQgaWYgdGhl
IGhvc3Qga2VybmVsDQo+IGFkdmVydGlzZXMgS1ZNX0NBUF9SSVNDVl9NUF9TVEFURV9SRVNFVCwg
ZW5zdXJpbmcgYmFja3dhcmQNCj4gY29tcGF0aWJpbGl0eQ0KPiB3aXRoIG9sZGVyIGtlcm5lbHMu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFllY2hhbyA8d2FuZy55ZWNoYW8yNTVAenRlLmNv
bS5jbj4NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQNCg0KQWxp
c3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDI3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMgYi90YXJn
ZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KPiBpbmRleCA2OGUxNTAxYjIxLi4zMGNlYTE5ZGVhIDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KPiArKysgYi90YXJnZXQv
cmlzY3Yva3ZtL2t2bS1jcHUuYw0KPiBAQCAtNTgsNiArNTgsNyBAQCB2b2lkIHJpc2N2X2t2bV9h
cGxpY19yZXF1ZXN0KHZvaWQgKm9wYXF1ZSwgaW50IGlycSwNCj4gaW50IGxldmVsKQ0KPiDCoH0N
Cj4gwqANCj4gwqBzdGF0aWMgYm9vbCBjYXBfaGFzX21wX3N0YXRlOw0KPiArc3RhdGljIGJvb2wg
bXBfc3RhdGVfcmVzZXQ7DQo+IMKgDQo+IMKgI2RlZmluZSBLVk1fUklTQ1ZfUkVHX0lEX1UzMih0
eXBlLCBpZHgpIChLVk1fUkVHX1JJU0NWIHwNCj4gS1ZNX1JFR19TSVpFX1UzMiB8IFwNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlIHwgaWR4KQ0KPiBAQCAtMTQwNSwxMCArMTQwNiwz
MSBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9wdXRfbXBfc3RhdGUoQ1BVU3RhdGUNCj4gKmNzKQ0K
PiDCoMKgwqDCoCByZXR1cm4ga3ZtX3ZjcHVfaW9jdGwoY3MsIEtWTV9TRVRfTVBfU1RBVEUsICZt
cF9zdGF0ZSk7DQo+IMKgfQ0KPiDCoA0KPiArc3RhdGljIGludCBrdm1fcmlzY3ZfbXBfc3RhdGVf
aW5pdF9yZWNlaXZlZChDUFVTdGF0ZSAqY3MpDQo+ICt7DQo+ICvCoMKgwqAgc3RydWN0IGt2bV9t
cF9zdGF0ZSBtcF9zdGF0ZSA9IHsNCj4gK8KgwqDCoMKgwqDCoMKgIC5tcF9zdGF0ZSA9IEtWTV9N
UF9TVEFURV9JTklUX1JFQ0VJVkVELA0KPiArwqDCoMKgIH07DQo+ICsNCj4gK8KgwqDCoCBpZiAo
IWNhcF9oYXNfbXBfc3RhdGUgfHwgIW1wX3N0YXRlX3Jlc2V0KSB7DQo+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gMDsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCAvKiBMZXQgS1ZNIHJlc2V0
cyB0aGUgVkNQVSwgVGhlIG9yaWdpbmFsIE1QX1NUQVRFIGlzIHByZXNlcnZlZCovDQo+ICvCoMKg
wqAgcmV0dXJuIGt2bV92Y3B1X2lvY3RsKGNzLCBLVk1fU0VUX01QX1NUQVRFLCAmbXBfc3RhdGUp
Ow0KPiArfQ0KPiArDQo+IMKgaW50IGt2bV9hcmNoX3B1dF9yZWdpc3RlcnMoQ1BVU3RhdGUgKmNz
LCBLdm1QdXRTdGF0ZSBsZXZlbCwgRXJyb3INCj4gKiplcnJwKQ0KPiDCoHsNCj4gwqDCoMKgwqAg
aW50IHJldCA9IDA7DQo+IMKgDQo+ICvCoMKgwqAgaWYgKEtWTV9QVVRfUkVTRVRfU1RBVEUgPT0g
bGV2ZWwpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGt2bV9yaXNjdl9tcF9zdGF0ZV9pbml0
X3JlY2VpdmVkKGNzKTsNCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyZXQpIHsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4gK8KgwqDC
oCB9DQo+ICsNCj4gwqDCoMKgwqAgcmV0ID0ga3ZtX3Jpc2N2X3B1dF9yZWdzX2NvcmUoY3MpOw0K
PiDCoMKgwqDCoCBpZiAocmV0KSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4g
QEAgLTE1ODUsNiArMTYwNywxMSBAQCBpbnQga3ZtX2FyY2hfZ2V0X2RlZmF1bHRfdHlwZShNYWNo
aW5lU3RhdGUNCj4gKm1zKQ0KPiDCoGludCBrdm1fYXJjaF9pbml0KE1hY2hpbmVTdGF0ZSAqbXMs
IEtWTVN0YXRlICpzKQ0KPiDCoHsNCj4gwqDCoMKgwqAgY2FwX2hhc19tcF9zdGF0ZSA9IGt2bV9j
aGVja19leHRlbnNpb24ocywgS1ZNX0NBUF9NUF9TVEFURSk7DQo+ICsNCj4gK8KgwqDCoCBpZiAo
Y2FwX2hhc19tcF9zdGF0ZSkgew0KPiArwqDCoMKgwqDCoMKgwqAgbXBfc3RhdGVfcmVzZXQgPSAh
a3ZtX3ZtX2VuYWJsZV9jYXAocywNCj4gS1ZNX0NBUF9SSVNDVl9NUF9TVEFURV9SRVNFVCwgMCk7
DQo+ICvCoMKgwqAgfQ0KPiArDQo+IMKgwqDCoMKgIHJldHVybiAwOw0KPiDCoH0NCj4gwqANCg==

