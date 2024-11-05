Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D518D1CA3B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DC7-0005AP-Oj; Tue, 05 Nov 2024 01:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t8DBg-0004mU-DG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:12 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t8DBd-0001sJ-L6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730788629; x=1762324629;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ghjrugyFYpYRKQ7LgHhgLSRlzzJTX557IgX7QUAhKpM=;
 b=auYKU28YrFWeIcRKlnf3bAdnTL6zkqle8yRwT9gYycFUKJ+t5WWIlQ1c
 9R0zV/On3Nc72Szcjlg1tPBKKrQcsdA7jRcJxqZzgMHDMV0/EZMdZzvtQ
 Qmmf0tnPZjZ61IsYgIdANFAB+hxWVEH1xwbNKfnnKw4QpwDWBAZNDRQfh
 ayMZCgItvgEYba9++j1fFMcH1e3VNxxVl0Auh83TQn595XAUpLSCA/KyH
 ssn74QU73JJRXd7y4S2LNYdKa6TwiwV3y1YTx4XgyMGT02vBqlsvcb+Vs
 KGa6NHbjGPYsa+vKF8jhdroK2G7LpKFoEF4KpTs/3gKaiPs5AFY6aZX6l g==;
X-IronPort-AV: E=Sophos;i="6.11,259,1725314400"; d="scan'208";a="23834876"
X-MGA-submission: =?us-ascii?q?MDF8dHN7ftt6Z/XBn8XVpvBXxKmjszPsLDTTVb?=
 =?us-ascii?q?hNnfXPgEbVcUXiFusy7eE4Y+EsoSwMWHiBIK84QKwz+lgn8Xk7RFIOTf?=
 =?us-ascii?q?k7YdJ+7kXPBZG8oaZeTpbn9oOHF2/RMDKaPwbNuHR/HKfT/ecjq5wNew?=
 =?us-ascii?q?oEkfvar0fpoF1xkWH0/AQEPg=3D=3D?=
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.111])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 07:37:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVsmXtrwlsCddc+FFwJt1ujWe9x3sV+ARluwQ8mEu8cmQqLbjrOAxTN8Xc5nryNGfHHW0erjo5q7JFbAAW+1eJf7imHTQyUtksYVQxL/A+FF5rOopjKmJa0DbEKebD+o0/wysydtQ2KgIhLmLIYUq3ktrsSF6QKf7hq5wgFS0qqucuCz17bhlSb8HSODGOatvV2UfVBBEzsNtC3e0mpZDdCfvJ6t0/KCfGjgYfutWMsTFPUZMZS1EQIJm8wTA0kGD2t49l1K7adTAKpx+ZjKPOOAhr03y32smUbnNdIBpPw0owi64U5nYHovhS/aCqtp84r6PkbcS+E647R6eouf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghjrugyFYpYRKQ7LgHhgLSRlzzJTX557IgX7QUAhKpM=;
 b=HY7NBWCeRotu8A8tv00lZysmve4uEEyraAtWMsuVokBhGQ985tlfIRL5im9qp0DCUF5PxV1y8fOaJrWRl9YgdaEhnA6R7jGr+i2/D4LMeJgX8NCGaQ9rf2Pnkz8O3SmbAu7LgpvO3DvN82JhJqkR4e8yRgblwPaFgHl94xNY+yVcxuQ7R3u5FCh9zGnv4vDLIWQOi/Jrsr3RkDC1aR4gQ8NtYfWUUcA0VPJZN2YWzyE+fNf8BkXBJ5tAPSPAq5+5ZAXOdyR0P/X4qQgpScDCSQG2F52+K0Q4OK1YVNNCSdeWdHkAhTgf+0/6u6IlkvoQQYT3udyf5KtQ1YKzsUz5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghjrugyFYpYRKQ7LgHhgLSRlzzJTX557IgX7QUAhKpM=;
 b=XitB48vOTlk45Hg+yCJj7NvBTIVju89SeZb+yyZHNuJLa1AD5Fkul8P7LsddUG/gP15xTonrQhU3bZJX/Is5Nu4lsv0RYm29o3uznwGhv21wside91zVIIModUnkgRTvuzp6252hfPgRF0Ewo2oUBvEOyTpOJ+EgBLsMxefa3RLNqsHGoLJq47pU2++ITaX6M+M0jlS/hss8m9fi8EkCDtbEamn9r4qi6xJKTRLbIdio44YZ2q5+9hUE29SA3S7DIwkr8qY7epPG1jTG0V4QTddfM5ojKLmVD1Wd4QVfk5IC857Gm7NOeowsdOYq1HoEPa5b6l779hQD6vXHLXCXjg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB9929.eurprd07.prod.outlook.com (2603:10a6:10:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:37:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 06:37:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH 1/3] intel_iommu: Send IQE event when setting reserved bit
 in IQT_TAIL
Thread-Topic: [PATCH 1/3] intel_iommu: Send IQE event when setting reserved
 bit in IQT_TAIL
Thread-Index: AQHbLrlX0R3X27I3H0iw4flJ9IUE8bKoPMyA
Date: Tue, 5 Nov 2024 06:37:05 +0000
Message-ID: <662040ce-92b1-4cc9-8a4c-444452fe1ca9@eviden.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-2-zhenzhong.duan@intel.com>
In-Reply-To: <20241104125536.1236118-2-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB9929:EE_
x-ms-office365-filtering-correlation-id: a833a7b6-34d3-4d67-38f4-08dcfd64438d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?a04xa0I5UGZMb0YxbWhPalJUYWhoMm5MMlYvL0txWm05TUwyNnJGQXd2OE8v?=
 =?utf-8?B?cGU2a0RGNFVYaHZXR1hjcFFhYVdxbDV1Mk82RUpzK0FxOC9hM1dpdTBSWnNC?=
 =?utf-8?B?aGo0Qlp4NktiQmhSUzdGWEtxYkYvb0kxdzhGY3RGNXJoSjVCWTROSXd1NmtT?=
 =?utf-8?B?dzk1ZEhGQ2NNNDU5WG9DeXA2a3ptYWZpYzh3d3RXdEhUNFFXQnRCYXhvSDN6?=
 =?utf-8?B?bVBHUW4zTXBZeHhRd0YvbkF1UGVYUW1IRmxOVDliSXphRGoxWmVpanJyY1Ez?=
 =?utf-8?B?bE8vem4rS1E1cXROUWNkQW1JZUx2MUxSMnhnYWIzT2VWNXF3UktzakpManA4?=
 =?utf-8?B?ZHB2MER1TTE4UzhkV3ZZL2xUYThzeTJVc05DQkdzdTJKVmx2Yjh1Y0lyMjNq?=
 =?utf-8?B?c1ovNmJZZXBLdVBpem1zWnRLajFPbWl0L2lub29ZWmgzcWZyN24rdlRFRjlx?=
 =?utf-8?B?SjVkSGNFRDdFYXVVMW5WWmt5NnJaMWx6dDJ5RXpYb0FpZGVaOWFvbUhvcmtB?=
 =?utf-8?B?VWI1OCswNnhlcjI3aXhEMUJOVnpRcU5tRmpqa1FJa0M0cjVFQXNsa0twRmp1?=
 =?utf-8?B?NGVKUy8wcjkrZkJsalgrWWVzeTZFUXU1MHMwd2NnOGVvYWNjTTM4cW01RjU5?=
 =?utf-8?B?YVcxTHAzdUxMNm9oaWNzVG5kV3Y5Q1I4S2loRDB3Y3JpamtTVXQvd3lZTnJ3?=
 =?utf-8?B?RndxNHNkdWNGdjdJR1hURFNBTllIS3BkbWRHT0VzQm5SNVpwOWVZTGt1cVFI?=
 =?utf-8?B?bFp1RjRDZnNQTktHWktxUDFUMWd6cHl5eFZMUjZFNElMcm5UZUVIWVJKL2px?=
 =?utf-8?B?R0ZMVXJscVRpd3NrUlJaMWdEMmZsOUY0QlYxVkZUTkZZbHdHZ0xEQW9PQWcr?=
 =?utf-8?B?MXpuYnhEUUtvb2JQYUUxbnp3cU5Zait3blZ3Y2xXQ2pIcmVJSjhTdTl2QXAz?=
 =?utf-8?B?V0tqdjZnK29adHFFZEZURkFVUFhvd3hyMk5tTHRDM2QwUVBYa0hGMUVBdmVx?=
 =?utf-8?B?azNWMVZwT295SFBaTDNLSE1CNGMwWmd0cXV1TnZJSlhBRGJLLzM3bWEyYnNB?=
 =?utf-8?B?UkUyZnAwenB6SzRneGg0b2NNaVM1VWFXeGpaWlBIdW8yTVY1am5pc2FuREtu?=
 =?utf-8?B?WDF1akVBeWlkdno4R1dieFpDeU9Vb0VzL3FoQTBlY2o5NTltckNqZ3BoMlNP?=
 =?utf-8?B?Q0F0czlaQVVzbDVSRzBwWUFJd2RCOTdtd09vaThLVHh6N1BJbldWUmpVOHVC?=
 =?utf-8?B?R0xPblE3bW16a2NXWGsycFFWWVJkSk9HdWlBS25LbnpjcWFPWkFmNFMxaDFJ?=
 =?utf-8?B?VXBoOFl4TnVDalkrZ2k4ak1pZWM3dHY4aWdaKzJFaTZ3V2JENEFEaTE3eXpP?=
 =?utf-8?B?SXZvaXM4TWlCUkprWkl6d3g5SDI5ZTV2VEhWcm9uUWh5cm51b25raE02Y1Jo?=
 =?utf-8?B?b3k2MXExWlJPSDUvSDErdlhma0pqZHFSVC9BVmh2QnRHNlRjeUFBZFFSaVJH?=
 =?utf-8?B?b2RQdVFKUnlDWG9jT1JtWG52My9VdUMxSFlZQUJWcUI4Q29zbWkvSHk3QWMv?=
 =?utf-8?B?Y0ltWjhZamZ4S1c3b2l5aFliWGpXN2xjR011cXk2cFBWYjkzUHVDKy9JOVBD?=
 =?utf-8?B?cmd5TU1nMHNyU25QZkR0aGdMdW84eE5ZZHorMWNTK1U1VUVrT2U3MStZYWg5?=
 =?utf-8?B?bEJKRUtJZUs4bDNVTWNaZUVkeUxXSTd5eFVuZzc0ZTQwSGNzSFF4QnoyUFJW?=
 =?utf-8?B?MzJhVHViNUYyekJndGFDaFpGUi9zTTlCM2VrZ2V2c2ZwR1JDSmlCbWJBTndQ?=
 =?utf-8?Q?FNYCIt3ExPjS5j0t5dkA6G7JpgVd/KAgO2BBE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWREbVF6TEpNZHNXOHdSckowWnlIanNMMXpkbzNhdXRSTDRDcmplZHVrSHdh?=
 =?utf-8?B?UWxOdXhwZTZFYlczQXNWSzVqbDVBL1NLUHVYMUJvR21wN2cyckcrU0FRN0tt?=
 =?utf-8?B?QnBpOEJIaHNQcnMzemhmMERKQ3ZpYStXN24zck1qd1pjbGhoY3ZsbERMRlBo?=
 =?utf-8?B?N3JMRTFkbm1yakZpdW1tWFJqQTN5bW9FOWN1ZC9NNFVFWkx0Rm5YS2Yrd2c5?=
 =?utf-8?B?a1RNVUdJVzRjbFh5eVVIR2RhN0hQYlprVStUMGVCcXVaQ2s0bjdWN1BSdGVG?=
 =?utf-8?B?SmRDOEJxZml5QVZKaDJKUlpqOTFwN3E4QjYydXdjcHZNTVd6K08yY0VFSGdY?=
 =?utf-8?B?R285UC9HRFdUekdWWVFtR2FxRWNucHlOenVkaGllWG9TTVVOVy9UYkJDbElT?=
 =?utf-8?B?UVZEZ3d1UE90aytVUnJOOUZwNXRQUUdiMVVZTVBta1M0cUlzUXBjNmRxRHNv?=
 =?utf-8?B?S2x3eG5WdU5UaFdTbVBoNTQxcEhSYmdFbTJXbHZNd2t5T0pibHA3ZzVVeEo4?=
 =?utf-8?B?Z1lEN1pNM1NqSEhyYnI0bHlMcDZTWitOY1A5a3NnTXh1UXNRN1lCRHROSVov?=
 =?utf-8?B?UnZoSTc5b0Y1SjNuSXJvRW9pMElWUFUzMkROUkJ2dm9UN2VpaTczeS9TMThN?=
 =?utf-8?B?Qjh3ZGZCVWU1T0toUmJ3VTQ5SE5Wc3h1OTlpV2VKMDBpaEk4aHZNTG1CQVo5?=
 =?utf-8?B?bk1KTk1RWkw5SkxGeGs2YVBYMlRYYmVWUUlJak1qMnYwbTBJMnFjVFNKbmM3?=
 =?utf-8?B?dGlzQ1RuNSsvcCtranJNYm1pTmNrR0lRMitYNTdKZ1ZPZnFETXpKSE5HSUdu?=
 =?utf-8?B?LzJUa3FTM0Q1ekthSzczRkhrRktPRFQxMlArYnk3MGQwdmxmZDA0UHRMYXV0?=
 =?utf-8?B?MTY2SDFDcGJaWithWVptTDkvNERrUHFQMGhJbG5vcjZDai8wN1ZCT2Z4TlBj?=
 =?utf-8?B?VkxLdm03VFY2RklmZjl3Yk5WUGJvMm5kZFFoeU53VXVCY2MxK3dxelJwend2?=
 =?utf-8?B?REg4a0tvUUt5QmU4dncrZmJhakpZS3d1YnU1aDZVZk9uZ2NtZGg2NFJTVGtL?=
 =?utf-8?B?S1ZxaDVGNXYyUk8xcGZsYVNyTTZUcDZ5OVlRU1MvMEdmRFBpZ0lmUlF5Tm5m?=
 =?utf-8?B?WVBFSWVJUEtoTGthVlVkeXc5bmlzOWw1RTZJNzFDTm52WXNaVWdFWGl6TXJU?=
 =?utf-8?B?dkVYaG9uTnNmMVZlRFFtSFUxOXJTVW9BTzJOT0lPa09GS0hIUWRQOGdIalVE?=
 =?utf-8?B?cDVsVWNzYkg4NXNyVVhtc1dYV3BHUFBCSythY244SFdjWDd3YmhXRkh6OXZl?=
 =?utf-8?B?bjJaK0xiOGlTT2Jnb2x2K1F2UUE1RW9qenF3dk4rbFdMYTd5R3F5T3hrWmR4?=
 =?utf-8?B?SXIrZFF5bVFOU3hOcVJJbVhXbDRReEdZZUtPeEVQdnZzYTVHbDNISjZxVlNL?=
 =?utf-8?B?TExVUWs0T0xPd3BCenprZER5eTVWeWR6N21jekd0UXJTbU8vSGhxcWpUd2Zi?=
 =?utf-8?B?ZnRDT0F4Z2lRK1E0KzBxUkd3S05CNXJvMS9hWHBRL0xsRXU2WlhyMlBFYWJP?=
 =?utf-8?B?Y2dwaUV4dTJoVHNudmNZT1gwY3F2dTk5ckVaUDNpTEkyeDcrV1VvMUQ0dUEy?=
 =?utf-8?B?T2dCRkluL1RCd0x4SS9pbEF5c0cxRSt2Z2pnQ0lDWnovYTM4ZDVvbUFCN2Vv?=
 =?utf-8?B?SVFPVk5naEd3L1FtNnV1YTUvWTJFVjQ5dHhwZnVMckdOMUxtNWpOL3ZwbmF0?=
 =?utf-8?B?dm42QzFPTzBlbUFIb0xMcEZOZkFsRGpwSVdUWEhqQnVhaUk1aElNTVRzVHk5?=
 =?utf-8?B?TEZ0K2Y2UExBaksrVjJrRnNUN3NiTVQ4MmlkQTBVTXppNG0wQVVpaDlHNUkv?=
 =?utf-8?B?clltRXA1TDN3Qit5dFd4Z3FWTFRGcXFtelRnalFpbUdOTFhTS29NdnBQUkZW?=
 =?utf-8?B?RmhFUE5KZDRTYWxJcnFmTEoxRFFqOTdjeFNCZnUya3FzZ3NpNk0xSmxRWGhT?=
 =?utf-8?B?MnNnb1ZMQXF2a2RiTFJLYnJVN2NRVnVZcEp2SDFyUmdkYm53MG5xa1RiT3B1?=
 =?utf-8?B?bUNKRVo5bjFTWFdXMWQ0UDR5SThXZkg3K1R0enFOSjFVTUlyUnVzbUdyYU5K?=
 =?utf-8?B?Y01ZVnZoY0ZPdFAxZEpTYWJTQ0hzcHpJQ0Z6Zk9rREcvci9qMVZpMDFqL1VL?=
 =?utf-8?Q?TUIuff+qaurv17mpn4q4jWs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86F4F3926A40374DBD5FB93891A0852C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a833a7b6-34d3-4d67-38f4-08dcfd64438d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:37:05.1256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tF8TqvpNGS5c7B41f7szBjsRGtRenRbDYy+psjfNTeDPV/iCzuNs2kzMRnN7s3yh5bxhfwRD2H5g0+yKKyIl+zwWtdgnH+tcvwR1JVuQ3GDn75mN8m0gBSUAOPaYzgiH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9929
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksDQoNCmxndG0NCg0KVGhhbmtzDQpjbWQNCg0KDQpPbiAwNC8xMS8yMDI0IDEzOjU1LCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVu
IGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9t
IGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0K
PiBBY2NvcmRpbmcgdG8gVlREIHNwZWMsIEZpZ3VyZSAxMS0yMiwgSW52YWxpZGF0aW9uIFF1ZXVl
IFRhaWwgUmVnaXN0ZXIsDQo+ICJXaGVuIERlc2NyaXB0b3IgV2lkdGggKERXKSBmaWVsZCBpbiBJ
bnZhbGlkYXRpb24gUXVldWUgQWRkcmVzcyBSZWdpc3Rlcg0KPiAoSVFBX1JFRykgaXMgU2V0ICgy
NTYtYml0IGRlc2NyaXB0b3JzKSwgaGFyZHdhcmUgdHJlYXRzIGJpdC00IGFzIHJlc2VydmVkDQo+
IGFuZCBhIHZhbHVlIG9mIDEgaW4gdGhlIGJpdCB3aWxsIHJlc3VsdCBpbiBpbnZhbGlkYXRpb24g
cXVldWUgZXJyb3IuIg0KPg0KPiBDdXJyZW50IGNvZGUgbWlzc2VkIHRvIHNlbmQgSVFFIGV2ZW50
IHRvIGd1ZXN0LCBmaXggaXQuDQo+DQo+IEZpeGVzOiBjMGMxZDM1MTg0OWIgKCJpbnRlbF9pb21t
dTogYWRkIDI1NiBiaXRzIHFpX2Rlc2Mgc3VwcG9ydCIpDQo+IFN1Z2dlc3RlZC1ieTogWWkgTGl1
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUu
YyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IGlu
ZGV4IDg2MTJkMDkxN2IuLjFlY2ZlNDc5NjMgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gQEAgLTI4NDcsNiArMjg0
Nyw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9oYW5kbGVfaXF0X3dyaXRlKEludGVsSU9NTVVTdGF0ZSAq
cykNCj4gICAgICAgaWYgKHMtPmlxX2R3ICYmICh2YWwgJiBWVERfSVFUX1FUXzI1Nl9SU1ZfQklU
KSkgew0KPiAgICAgICAgICAgZXJyb3JfcmVwb3J0X29uY2UoIiVzOiBSU1YgYml0IGlzIHNldDog
dmFsPTB4JSJQUkl4NjQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
dmFsKTsNCj4gKyAgICAgICAgdnRkX2hhbmRsZV9pbnZfcXVldWVfZXJyb3Iocyk7DQo+ICAgICAg
ICAgICByZXR1cm47DQo+ICAgICAgIH0NCj4gICAgICAgcy0+aXFfdGFpbCA9IFZURF9JUVRfUVQo
cy0+aXFfZHcsIHZhbCk7DQo+IC0tDQo+IDIuMzQuMQ0KPg0K

