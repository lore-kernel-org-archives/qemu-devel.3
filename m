Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DF0CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHXFo-0002So-1i; Thu, 15 Oct 2026 22:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXFl-0002R1-Rl; Thu, 15 Oct 2026 22:01:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXFj-0001UF-Pi; Thu, 15 Oct 2026 22:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792116059; x=1823652059;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mS62lzuyzqKbvw93jZcF2F62QnGAxqhXezmPzicAlis=;
 b=Cseq8aBC/44UjsjtWiV6Exs75+HOCVyZP34E0MFOZT+dxSKS0frvayop
 1l9fjuQ4fUd3KVppijyk4Te7LFSA3N2Dy8EaQvb4Rg/v7+K5RwJPbu5dv
 SDCUDniTdqzsxR1TbsrRqi1b7yu/982JupJ+E3nQiQZihMo/E2t3+zPCa
 qBT6CaaE8IHnvSAww81vVfbO86SlwEo3St101RXIYQN3hrQ5IUf88vFqy
 jf9VeSSoR5Rulqltwsz9jD7l5C47Ge0Zuowv4zyVKd6e9R0BfxWf89SA8
 N/feQJa3sSWwYKTFIM59m5OviDGH4QOqcx10wnYAWAiMztKvcdC/0GNHZ w==;
X-CSE-ConnectionGUID: ByKCvBf7RSCQRY6Jas4Nkg==
X-CSE-MsgGUID: +WGmQqwbTz6jYkKaTW94Ag==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="158113789"
Received: from mail-eastus2azon11011012.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 10:00:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SC/RdQScLP9UhdWehebCjh9vZwo1Y9a2GJeaiLZfORs0nNl5H+ryJNi0LQfWOxftl/TZxoQZNmgwlFOlyOYA0dSIHeJtjeZ8WOMLEXrLkU8Nrxn2ThmldexEIkhVm/7SB92KNzg/2g0imbUkise3DkSd3pgMJ6/SWPisB++TKfuarLbcmt0bFfdnwxafxGL4NbWlwAX3whyziYvgUajDIn2VH6ym6mTsdcltPQosmRyYNRvTOUkNXLSziqI1kDmEA/7agI6JI5cJsnkH6XFDdWQ0gQTPbUl4kB+ScT8y7x/Uk5y07BN2wxLFrfCdEb36lhlfKynXMG5Vh2Ff267e7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS62lzuyzqKbvw93jZcF2F62QnGAxqhXezmPzicAlis=;
 b=vubcKyiL5x5Y59QwE7ZWs10kyEmBqPmKEqiDcpqVvnvVIRp2hIC+h7Aa+ZzTnpjH2HcjH3Q2UVyGzxOSw8490EUNI6Ur7JOGT6+j2duQkw8y3z6BPNSRggucrLlUys7Mdwjumu+GgRkG9cbvgv9kyDIEV09dDHyPxHaKIrv0ii8PkD+95Chre7NAcQ3Pnt/Qdq/bzZp8iZGoXgR9M1w/Rtkad6AMiCeso6mQb+Va/j7QzWrRMK4GmfaNlzHqzIHhuQzbMsPmCl8Urb26FL0EyEcGan21v7bnuZ/yaBi1nGrz3/4cZkV+HsdsG5ZlmHYDtHPxiCrYJlIxkDUG/RFnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS62lzuyzqKbvw93jZcF2F62QnGAxqhXezmPzicAlis=;
 b=yHeY+/uU4nupGk5Va/g30xEB7arnKpjGhgq6lguUm2ZasUJJiWJQhXUg0VXPc1BYQzN8vyMC8gqxSMi7pAykAdYz6HkklNVtyKM+BxBdXBWoG8ucK0QLV1bHwycOyR2+joxhoumR/MB7jlGdgCBZaABY/jinPPsoHFF9rDD7pAM=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 02:00:54 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 02:00:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v2 3/5] hw/misc: use hwaddr for the k230_decomp_gzip input
 address
Thread-Topic: [PATCH v2 3/5] hw/misc: use hwaddr for the k230_decomp_gzip
 input address
Thread-Index: AQHdUnbEc0ylXF8mNU+aldTh608uSbb/f2uA
Date: Fri, 16 Oct 2026 02:00:54 +0000
Message-ID: <c7f5b5b34ac6883f8f988adca2fa5e2d899c0623.camel@wdc.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <20261002140245.30214-4-dingtao0430@163.com>
In-Reply-To: <20261002140245.30214-4-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: 65cf5d79-39ae-4658-f4ae-08df2b294fe1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|19092799006|23010399003|22082099003|261009223027099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003;
x-microsoft-antispam-message-info: 6n6bdQbLD5x5ntzSHSn480mWNVQgNHmFgqlq/4Eb9ryScAigbQrpt5R/GqjKgYtvdFnqjX9hMkHp/UfPIVK0m/akKWbVaGrQemRv/G9+MB+SGsNzdqFOCGn5z6UWeBvCf+i/4tWg8Hwdc2e8h/6zgPefX88B+3/Sh5GD+WuK8VpzyMeV+MrNigomqG4mSnl3DkbiAzsLdPMa3JT1eJNqgzhSXKuBj2nPYHSWTW6bh97bxKjknU43kp6mmSg6I/t1Ci/RquDomqPQjzmbjZbRpUjNaZeKfcLUzDV5ot5eMUbhjzH/IZilnRMZ30hZqfoxEkC5WEhh04u60XkLWKN4jCxB/WFoIUDRy9vV3nxHRqU2xJ+h/JN7yKqFvyjK5f6bf9G5XlnuLMJo03KsYB0g8CATrcpZIH9U8HC1b2YxNJdC8fOmXMRnlBo/BPf5EiJzA37u1AwOjboQPDbkvXXjgG1q9zx2M1T9pglcXtF3FRgkkjvpq4Xe0JzbE6Gj2rgsjMqRNQkEBFv9vQoQL/YnHfDz55PFGIb08rmmEX57dCYgw2yxkKUd0YpHDx7+dRM1bjeet1zFzbSlleWCaVVlEMyTsEzJK/DaGGMXrIY2Xvgy6EHdH/sn+3w19EHCYSmziiiKdY3lXhDUCNgsDXbhet8EuoCI03e3yHRiLcYMHXSAlEhndx3pqtTT5P8BvNWtx/uJ0rMwqGVVAMskzzbNUxaDG7O6+I4QPmSdenEf33k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006)(23010399003)(22082099003)(261009223027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWovbEFsY3NHZUJaVENXenNzQXBQTnNjbll1QytmQVM1NjhpZytYRXBPSFBQ?=
 =?utf-8?B?eWNtc1JURlhqRDZHS0JvNzdkWEsxbnlMVEJXcUwzRXRZSlM3Z25Vai9EbzlK?=
 =?utf-8?B?bzBpZmxyK0gwNm1VUjZTd2U5R3dzSlQ2OXBheTltYUdtejR3OFBORTRBdURv?=
 =?utf-8?B?dWI4TXJ5Njg5aWdISHA0djFNM3RiYWlZUHRQTkx2OWZEYWlwanFLb2VFSFM3?=
 =?utf-8?B?TG5tMEdPcnEzOUpjYWcrRVhxaEo3NGs0OHdqK0tJSjNBUCtXTWkrakliTDNC?=
 =?utf-8?B?LzFFY2FGVWFsMVR4QkFCN29JYlhrcXlMN2JlV3VvYko2eCtVVVJ1WUxTeFUy?=
 =?utf-8?B?ei9PTm13Z2c3bXhLOXhsWkpPekhiNXk3Y2NMVi9RSTVVUWF5UHVXc20yV29I?=
 =?utf-8?B?QzdqeHRSNHpjcmhyNWI1K0lRT0FtZVNnS3M4WjRsck0xSGYzZGpnaW5FVWpq?=
 =?utf-8?B?dDdzd0xDTDhsTG84OE1BNEtLVXVVVHZEUHRmNEd5SFFZSkJ4TkwxTmhHNzNo?=
 =?utf-8?B?YVh1L0w2ZzJrd1dhUWI3UFFubWM4eFVYVTlUb0VXSFBLYWlHekVNRkZyZWI3?=
 =?utf-8?B?bDVGeUNiRlhSM3hmNHU5cHlxcCtiS0Y4KzNVRXNYSUlhT3lMQy8wUlVTSm01?=
 =?utf-8?B?dTdKWDkxVEhOcEFyaU1zNGZ4bkZHNXZQNDdkcE5zd25uNkk1bUZQNXhwS0lO?=
 =?utf-8?B?YWIrb0ZPM09DczNMZjU3L2xkUkYwOGNjaENzdWhQOFdJRmpUSUhxOUNPRG4x?=
 =?utf-8?B?a3Jlci94eXU0bkJEOEJDQitxMHBrNGFBeTdMek83ZkZLUEJPWTRZL0psYWNN?=
 =?utf-8?B?V1Y3ckJrYVFBSUIxQ0VuYXhib1RGSWFZRXZ1SURvZllxL2pnRFJPZEFrb3Vs?=
 =?utf-8?B?SjArVlpma2lSTXVZRk9aaWc2c00xalljMWdsM1hCMEdSU2tpWitnS1dmU3kv?=
 =?utf-8?B?N3czQ3lsTnZrdjgrSjRkN3h5NlpWTTlGQ1BoM2VyVXJ1Rmd1Q3Q4RHpNQll0?=
 =?utf-8?B?clZZY1YyM1dzd0VKNnpvcXZYUGFid0JQK0drbWVLVFlRQVJNR1k1NFh0UFd5?=
 =?utf-8?B?OVh0OUtHNzdwNERDNW45dVZSdlcvU1Z5S3NMK2o2NGY2WTJHV2l0clZwbUY0?=
 =?utf-8?B?YVlQMld6ZVdDUzhDZnVkeFJRaFhJV0Vid0pVdHFzRU9lWnlseTNCcFpyMmtL?=
 =?utf-8?B?UmdYZmUwdzZPN0c5WXNoYk9obE4xYVpLd3NUdThKWk52ZG5BQjFybElvNmtE?=
 =?utf-8?B?U2FTbCtFNVhWRnlOaDRJV0p6aEtOb21qcVZVTjZHZ0p6TXFySXd0dnhSaVll?=
 =?utf-8?B?WjN2cHRBZ0o5K0JwWlZhT1NZRkRicHNWcE1WVVd6TEw4cVJGQllWMUJxeFpV?=
 =?utf-8?B?TmorSndsREs2cTBTaU9uQlBqcmVxN09tZHpQVmlxS2ROalhRSkg0ajZOUnFi?=
 =?utf-8?B?eEYwU1J2d0FNOG1ORzRSYmU2dDIvT2FMdFNKc2tVWVJta3UxUGsrV3V2UWx5?=
 =?utf-8?B?N21UWkV6dStydmlqODBVbWk0Y1FCUUZ4MmIwZGE5ZUc2QldiZFRuTkNOWlph?=
 =?utf-8?B?ejN4bkJKMnZtWjJhb3UrK2VZa041VmVzY2FxMTV6YlFEN0dTdXQrcUN0eExH?=
 =?utf-8?B?c25RWGJtNGlWaWJBL1kvL0syYjU4ZFEvdHk2aVZkLzV0anRCMmd2NTZwYnVX?=
 =?utf-8?B?Sk85YzV3bzU2TUVyVlFHbVJIVk43RUtUM2xqZ3lNQ3ZJUG5vaCtlekk2SVFI?=
 =?utf-8?B?TVQ1R3c4T3RCZHFKa01YR2wvSzBucnJZMTk3Wm9wN01kMlpZaTBuUC8zNW1I?=
 =?utf-8?B?aWdldm1QbWNwd3ZMbk9OYnpDa3hzODhENERlcmVZLzlZQjN2Qkcwa1ROeGF6?=
 =?utf-8?B?aU1LV2JjRGludWV6Y3NBRXNlY2lqbmJreE5YS2Vpa2tVcjVVWWN5dHp2Sko0?=
 =?utf-8?B?RXhZaTQwMG1obkJaSC90aTZGdmFMQTA4bkpPU0xFUG8wN1VaeFgzakxDWU4x?=
 =?utf-8?B?MFZGUVdIdUg5aksxcHVCcUJvYkh6MURjSGlUNWZoY0ZpVU95Y0J3R3NWTXky?=
 =?utf-8?B?MFYwS296M3AvQUFqdzBtUitZZ3pWcHBhcGowQkhTbUUyaHJGR2VSdjlCWnZP?=
 =?utf-8?B?VmVCVHVOZFFYZXkwdU5yUWVFU0xBWmlHM0duWXNtUkNYQ0hpUmcwTUhHbkNT?=
 =?utf-8?B?U05jWTRUU2VwR09vRWNRQWdwUmFOVlh6blhpL25abkxKdWJtWGVRSVBsNE1Q?=
 =?utf-8?B?M09aTlZIUk1LRENkRGtUdmlHYkxCMzFUdld4OFNGSkJicC9QV0ttVjBsTTE4?=
 =?utf-8?B?T0ZaY3NtcklPL05mbGNJbGFwV0ExbUZiVmxreHNzd3c5UVYxQ3NMeFo0YXlU?=
 =?utf-8?Q?J3mx9cFX6PfZSz2AhJ8HUoZg9Yq3D6iNC1zklY+SxwG1G?=
x-ms-exchange-antispam-messagedata-1: q/fVt8sPvzkkfqTMn4olGjIDnWObJ5DqmK8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <834201E68AE27F47A417B17E2CDC84D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4JIoyiQansoy0Y0mbQyhdqZH0owgMYu34VOTKUgeIQQ58NxBE/Qp2sNcfwHEP3JPzPFTpWTpV/L5HqPPOA1eIUi7e+yoIo4fmikGEpbNlyB4643TCo9MNZgf/0XpcaaYFuhxdO6aihyC/2zuYJ0tmd542DuI39Puy+pq1Bu3hm2OnghFjRwH+w/Qs7PZnsTHtIpLxwB2dF3fiD6pKo0izPUrbrB0WBrIrpQUgxiwW3zh2Fs6xjMt+l2UG5K6BcYCIa6lArqVfzdOiPbElCU+NrCYDG6mgUxXJGG5P/p8y/Z+Cnn0q2Hd1p1CYMOW++xVInsSSdPIy6z5iXZuoK9O5Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4IqmuqKQ4KquA9p7dd12aHAa1pqr4x1KEhLoK6GvI+k9SDERpVsVtB33sXmDxuV4/2zIjUknQSihQVFv42E77ZuJIED7CAXnlaNVDi9S811qUrdrHMLnRiLf6YdsfDyfSwVW2Lqm83WKPZ9Bf8VvpZ2saQpMEVE4NqTh6gK1sE0m/z45VTpXCSt6lbHIsuZKbUVaBSfTUNMU4NvZ72+1mi6oRLn949d9mWXehO5p5n8HPJwSeG6uOxUNBLhR5h4RmZ5DQ0N/ehP2FU3XArjtR6vN6sYCkp4RsJ0OCTOik/4PbArTrZfxBUDocFWUjNNJxjerrMQaM0fot6RxREOIVuOeTYftTKFf3X6R6qZh6tk3Uqjdovjbk040cVpUoz3zbmaWX0Ixm62LiNV4D3kN5u2nKJEv+p/duBDi5IjXVEJH7UIP9k41U5MZWaYfshDDhR/Es1MPtKgbplpyTWnNtF0HmAPLDl5qY1DVFsIGXOkYYRODjVnoM3+3zYRy1KCf7x9lb8rf3QAbWmpllUloUR1Pu251no9AcLklc5ZG4DC2BwwhgmJmfiRBomdbUPGP9CIU1+iQu4wS4dFnXm6JYjxdmYJU9/BgSdF4YTjigJIE2l4forkkajIRRp48PmaU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cf5d79-39ae-4658-f4ae-08df2b294fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 02:00:54.3745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MUSy5OXlfW3vbRfOhBiOEVffWZnqIxQaggrhNe5VPByEv0uuEHin8wrZCwIeUC0ahAL8jZotRH9SmiSILfa0Yj4L2127Oso08iFljXw5Pew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDIyOjAyICswODAwLCBUYW8gRGluZyB3cm90ZToKPiBVc2Ug
aHdhZGRyIGZvciBhZGRyZXNzIGNhbGN1bGF0aW9ucyB0byBhdm9pZCAzMi1iaXQgb3ZlcmZsb3cg
YW5kCj4gYWRkcmVzcyB0cnVuY2F0aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRhbyBEaW5nIDxk
aW5ndGFvMDQzMEAxNjMuY29tPgoKUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4KCkFsaXN0YWlyCgo+IC0tLQo+IMKgaHcvbWlzYy9rMjMwX2Rl
Y29tcF9nemlwLmMgfCAyICstCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9rMjMwX2RlY29tcF9nemlwLmMg
Yi9ody9taXNjL2syMzBfZGVjb21wX2d6aXAuYwo+IGluZGV4IGRhNGRjNmY5NTQuLjU0MzAzYzBl
N2YgMTAwNjQ0Cj4gLS0tIGEvaHcvbWlzYy9rMjMwX2RlY29tcF9nemlwLmMKPiArKysgYi9ody9t
aXNjL2syMzBfZGVjb21wX2d6aXAuYwo+IEBAIC0xMDIsNyArMTAyLDcgQEAgc3RhdGljIHZvaWQK
PiBrMjMwX2RlY29tcF9nemlwX2ZpbmlzaChLMjMwRGVjb21wR3ppcFN0YXRlICpzLCBib29sIGNy
Y19vaykKPiDCoH0KPiDCoAo+IMKgc3RhdGljIGJvb2wgazIzMF9kZWNvbXBfZ3ppcF9sb2FkX2lu
cHV0KEsyMzBEZWNvbXBHemlwU3RhdGUgKnMsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50
MzJfdCBhZGRyLCB1aW50MzJfdAo+IHNpemUpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBod2Fk
ZHIgYWRkciwgdWludDMyX3Qgc2l6ZSkKPiDCoHsKPiDCoMKgwqDCoCBzLT5pbnB1dC5jdXJyZW50
X29mZnNldCA9IDA7Cj4gwqAK

