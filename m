Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87CFC61DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wTN-0003YL-DB; Wed, 02 Sep 2026 21:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wTK-0003Xh-P2; Wed, 02 Sep 2026 21:42:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wTI-0002E6-Sa; Wed, 02 Sep 2026 21:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788399752; x=1819935752;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bqJUlIzG9VFiKHNJqBhXQa97JhvGIz5or1bD23Ir6eg=;
 b=EWSM90u6VH46AW5DPy9/cGl0BSLL4OqBEcwuI7IVEiv2eSxODC2Vgwx6
 jBzwGWFsHAAMdgeWOAUyfoJFBZFu0PHhGsOZRN/1xcRorkXYih7E2f/kc
 a97i13IRva7xBSi3YrVoIVCP/jxnJwWFlq/inn9APCGE1jlZT/DsHyMrE
 0utVuyj6AMAg2S+/kRx0zkrsdNGfQAyK7NuSiS76dhTSp4U+11u5yLvbz
 NgUQv34Okq+RppEKVGGLKAPex3wZmcfZSEqr5MOs3UB32hH9SLE3SGMs0
 wf/wKOFxcP1iH/r+7yKmSpSI+SFPCVXW6FN13bR173XfMkPqMl6om/S6a Q==;
X-CSE-ConnectionGUID: nSYUL3wPTIy+caIB3H/mbQ==
X-CSE-MsgGUID: /016SFBCRg+uNsUVhwV+wA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="154835102"
Received: from mail-eastusazon11011026.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.26])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:42:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi45g0s+w4o6BPldOxv0JN52OzJwil8H17bZxsqze0+6ZJP07eggiEMGOTuwUUpOlhv7qvG/dcuqgWsnjJNQyiKiZlYD9Z9fpzlKYwvTBb5KRfAKQRL8bTQE8DYdqgyagFif7O1ZL3ne8LjgXRP0Nv1HCTQYSbn2l+ADnzvFE1RsHg2c2gDxcTNrjLwSDkrTm9dCRcVK5+WGm5GWXjJXSGpkXNoIHi8a2ap7g3XpxDdVw75g5dtldOMT4uezkX90S3Xuk4ApDdMt0w+p0uCHfKvdGXqyeYZS3fW2SAICDLGf03Q9tKzaX2a7Aun8mDVuqxjAjFlGw15a/cdC/hj5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqJUlIzG9VFiKHNJqBhXQa97JhvGIz5or1bD23Ir6eg=;
 b=XDxkJGRrn7hAIap5wQeDiFguNy4gQed7/kmAoN8Ik3w8b/7Xy11kMm5QimsHL4WjKkV5sUylM6lCmGGBNynKQv8Q7Cf4Enz1qxKzBKBBzogW0mYotky+/dz9vzAreuvtgXx9gY5W+329HWrM8d7xDDf81ZMP5xRcQTnizMgXJL5P1Cfda3eM3GLi88FDbKivRFjB6y4rl09jiHfC3hAban401v7eNvVaqqQXriA+xLVWNc5s44H58zZMYsdY0XvH/9vC2L/AydGuEznwn5BVp8umKVbM1yKpmJW+MHzak9Cxvc4cuKYRpNdef54MnTSRPsuErE2YQtW149jinW/5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqJUlIzG9VFiKHNJqBhXQa97JhvGIz5or1bD23Ir6eg=;
 b=b0ufK9HvmuuPM7W/NWGHGVycWA8GYcmJWwHLcXfHNbbbxf3HZee4PQxoW+XvsLtNePSAkdD5tOrRPyuju78ZPA3P3UDMPdGmBgjh2EhrmGnFzobksystH21vUAkHKDTQjxj9OJ2SDdqv1DBC2hJCg+cRzshY4syVIjJVo63ME94=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:42:27 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:42:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 01/16] hw/riscv/aia: Take a MemoryRegion for the
 created devices
Thread-Topic: [PATCH v2 01/16] hw/riscv/aia: Take a MemoryRegion for the
 created devices
Thread-Index: AQHdOO6gGoPjM9m4QUGOcHLqLDvWL7a8GRIA
Date: Thu, 3 Sep 2026 01:42:25 +0000
Message-ID: <f742cf14b2d304f3f45b784bd508c468f9095d3b.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-2-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-2-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7640:EE_
x-ms-office365-filtering-correlation-id: c206f74f-7bfd-4e2d-c499-08df095c9b3f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: BDD+zKcJ8S9lrwxKnKay6g8uRWfxIJvDDpebR2wbBVRSSWSVgJtC9Fhsyxig7J9YuV488a2t3BNrzUGE4gYZIceL2A1P0MYD6EszAZ/uq3k/DXwaYdOx/BQVXTykIzfyMz47PPIHG336knsOhEf5CAAQLx40GP4nmVoG5nO0GKBFaH3gzLqzpp+6vE7onMwwOpxXBkgqMSOct8plUzxIXfi5aTfETlJ5jewuespy15zVuZpmGhqdzusOaFh0Ph2O8fP7ea/cIZxytjdPQAkkAOIdqiHAbEwbRgYjrqli7L+lRJrYBqp7L3pxT0mfFru48VaBGiplTC+ZsKabrqjxi2jjpHv0WafC3DUUVjWPdUXOpzCzp0gHT6TwAZeeYBna8ew2ch0IDGJSojiSH1dh53coQ+NhPQ9l9lM+cPVEYWjgmuSUGqqCrKglc603HAiPoLI3PFw2jhGUVvN4tPD5z32PK3fys5RQ/o+HICTRENN+W4vDwrHN1bxvog016vC75lRfywxjyw7tSKrerR7ovfXnA/+rSvzw265llpUtK//D75z3l8eqDYPEYGNCKtpqvXXhIfWBPa0IMdE6oWNufaz+WFxOg6gPIDU+jVh1BxJUt9+7PDYt6eCH5VFPhaLqNQlCqMMlthrbhhPzTXz/HqQVbMw9biZpuRkMBGbXevrrPt/ai2V6eJj3R0vDQIjuemZtw8f5NS/c2EgoYjm3D8YTcCVqO6NwdPZYoDTetF8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEhVMXJnK0plMGs3Sit2UHgrMlY1ck9KczdsMTJHOFVnNXdnMGhKN2VoUUZp?=
 =?utf-8?B?NWFoMVprTDYyVTA2bExQRzFrVFVsUStzVzRhVDEvL3VkQk5CQm1UT3VYRDA5?=
 =?utf-8?B?TjZvNmRtN0pkQTZNVFZBU0dLTVRYczVZSUN4NngzUjlPZ1IrZ2JQcUpZQmRY?=
 =?utf-8?B?VUx4V0ZVY2hQWGhaMUlDU1pjSTk0b082MnNoQ1MvMjJtWEFkL1FWSldKREVr?=
 =?utf-8?B?bCt5N0F1YklqRnQ0R2plRFllMTliQitEVVNKWjY4QTd3Tk9Qd1pXdCtIbEFs?=
 =?utf-8?B?UHRId0d4MkVlMDd4SnJhcE04OTgvcDJ2UzJmYVZIbFRtMng3MDFsSzZYTlMw?=
 =?utf-8?B?YXFTZ1ZZdUQrQ3ExQ1RPcHdGQmJVY2t3OXRIdkNDZEM2U2hLajVoS2hLc1RR?=
 =?utf-8?B?THUyVkhpRU1WWHAzVHIrdzczb21xZzVScVg2aDVURC9RRmdudS9qYUFObDRo?=
 =?utf-8?B?YWJSY1lNcXhwNUpPSWJmTXgwSVpiNGRKU29QMEdxTHZKUUlTSHdBeUpnOThV?=
 =?utf-8?B?bFlzT2lxcFBFbDJKcFpOU0tYem5RN2FXWkZ4VnhGSXdhd2dSOWdvYTlzYlZu?=
 =?utf-8?B?QTF0VldOQmg5Y0xQUWNaZEJqQ2E4T25QZUI5OUt1TWZrVVg5dGd0NjIrSDdY?=
 =?utf-8?B?dlFPSFBBM1pyTVJBdHJhMFVwMnN1cWlEZEppN3Frd3I1ZW5NQWhLQVFCZVp5?=
 =?utf-8?B?UzRFOE9PbnVaQ280MDVQVld0ckRQNFNIMFByKytPZDJSVENuUEVrVDNubjJK?=
 =?utf-8?B?c01oUmdSMTloa2dkNC9BNjZoc2FNVWdqei9xRDU3V0ZOWDFVT2FMYnJmQng4?=
 =?utf-8?B?T2x3N2ZCQ3VJQmVjcnc3WCttdTdjeFpMclYvcGxqVlE1MElwLzhEc0ZqZ05o?=
 =?utf-8?B?WmhtbzFqZ2FYZ1ZEbnpyd3lNMEVoOCswTUVlZSs3R0t0aCtSS2R1cExCNW9o?=
 =?utf-8?B?Nk5US2YyQ2Y0ZGFDaUN5VG4wdGJYMmxyWGtNTzZKM1FFeHIyUFdwdjdqT3N6?=
 =?utf-8?B?QnZaWXpVUGhjVWNFMXVoVXFaT1ovUUVobEJwRU9BMWM4N1htck5iMkRRRGpO?=
 =?utf-8?B?TTJzTE8rTXNueCswT2o2NStnK3Rrdks0ZFMxbURsTWFsZ0JvUUZBQ1AyZ2tR?=
 =?utf-8?B?Z0hoTUVZUGZSbndoQXd3QTArbkd2RVRkSkJhc2xQcG9KTTNwREFhc0I2bHFa?=
 =?utf-8?B?REllUlIvNU9oSW1Ob0lySzhHRzVnb2xBNG5ka1FNbjg4TUpibFgxbGwzb0Qr?=
 =?utf-8?B?NFBoa0w1cXNZSmxUeU95OEl3K2I2SmM5dytueXp6bzJQT0dZMnE5YlpwbStX?=
 =?utf-8?B?RVJhWm5ZUWN2dENDMk9wR29OMGFkSnFCWStuaTJRUFkrUERMUlM5UzVMTHkv?=
 =?utf-8?B?VzlRWEp2R1ZuUDFvWEYrajZYenBjY1JPc3ZRT0pXeHhoMm1NQXl4V2xjR3ZT?=
 =?utf-8?B?NElLd2Iyb2xJUGlxdHN3dzFORmR1UDJ4c0ExblR2b25jVmFSLzlIZDhOZzJs?=
 =?utf-8?B?NVBROXIwQ1RYK1JkSFBWT0hFMytIVkJZbFUzeVo3Q295ZENIVXJXdGVnQUlC?=
 =?utf-8?B?RXhVaXIvcGQ3Mkd1dDVVWDRObFMxS0xhYm52am1FTjlaSi9XVS81bTFWM0ZY?=
 =?utf-8?B?a2pWQ1lVOGZCamx1aDc0ZmZuQS8wR0JScHRqMXFRUWhBT040eGc5aG0zMGJi?=
 =?utf-8?B?SWZCTC9qbzVKcXh4cFIzSG16UjFrNitnOTJkdUt0L1IwWTFFZTFkYUUwQTRB?=
 =?utf-8?B?RlRzUmxyYVNXM1ZQSVhERmVpUVlBRmNIVWIrelczZGlWdEJ1NG5VRUp2ajlM?=
 =?utf-8?B?R1B0NjR2c0RQV0hmVDZxSm5mTWxPR0NaNVRoUzJTbWpLNjhhZWJqUnpKVW9q?=
 =?utf-8?B?Qkh1RFpkK2txQWU0Ymh0RDZ3dEowVUFLNEVzZzFmU3UrdUo3Zzd4V3RYTlpJ?=
 =?utf-8?B?YzhOcHQ3L1p1OC9saWFrdjVRU0JLaDA4N3QxV29TTWdhQ2UrQ00yL09QWEM3?=
 =?utf-8?B?TXp2NmdlbWFqa3k1NWRockRSRll0N212OFBtMU16cDRvVU90bU44d1FvaTBT?=
 =?utf-8?B?MXY3aytzMkF3TzViYys1Q0F6RTFZR0xrVnJGOGxjWGRKSTJrS1hZVE5HZGlE?=
 =?utf-8?B?d0lEMmxqUUJLQUJjdjEvMFBSajZtRXFBdUlsRExjM2FLWTZZYTdJZkhCRnNB?=
 =?utf-8?B?dDEwb2VXTXkyNkkxdit6dWFHZTBkeEx1MEgyeDNLcjRkL0c0dVhwN0ZoWVFH?=
 =?utf-8?B?ZjNlamRXdWd6VFpEbDJhM05hOUR4YWs5SEhKUHVLWUY4UzIvOXlNbDBJcjNB?=
 =?utf-8?B?Y25WbWs0aVg3SjJLV0tsVXpYS3FJUmo4TjJ3UHhOYUdqZmg0MElIYUNwSmpW?=
 =?utf-8?Q?7RgptlDxb/r57Nrv+CZDOU/KAD90Q2JXijm5aVd9jLFeM?=
x-ms-exchange-antispam-messagedata-1: kR9EJvpQUtdBTlJYErpwUzNBXdk4lFo+/hk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9BA907DFE37B469EF3EA9A7674E61B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UbeKKas45ArYKqJXYP5G0tOqVL4KsXdnaNIPP+9sZVS7r9Ly1HJ+9d3jST//nDBinfgLc48g/YKH3dshQq0fPruGg88V5WqAVrxnXxrKF7S7zU/EHLqtBHCpWHgtNbwgU+QIvUWSB3sZTOLcD8azW2knusEAWu09edCUEah9cgXE8IaPhW7CAkmBAdsxuvCDG99DHcj0iSufeqecH/6QgxZUUp3UMn9ooD1sUNhNU8hP2qy8IJYFQpiD/EQzpAEvyf9dcrNuQp9WAkuWGnR7RQUCOD9EdKYPP6jnWB44mKZb+aYFOJa/mGWis05DdlgPlbb7wVRp2EAM+HMwIkZ/kg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b9pujEODZlfqSpTyRkh5b7/3LEXnzqNRLxf/3zgXVCu/QNji5mlWtjaJTRDhyNbTlypHt+TW2zxcf3K2VLD1evyq22/HNiB9GYg39ugtq8Ny8btYDWf3iaHgiizk3NHfooy6dy1BPjhN9rop208M3LK/oHlKWcW0oaJ3ehoBmB1CYZ+pkXLGpg7YtBV3n18j92RFaCy5Tj/qekkcw13+/7gpWtx7g+hXqYFEvvPIYmg979+zSwjMmHnJB+ysyvV5kTmuPyjK2pA+lCUI5Fz8j13Oqrm/OI0diSGKvkuJ/rKUGSdh0RE6pEJmSWbKGc1bsGXfkjaiAoBqoMoVad6xt3eQRCBQD6XOwtp5+UqDogw1cD9ajYjgllE/21kxUDWE5dsj9Jrd/nRFlxGeg634oh8PSP/ICxHHTIyZafj7HZRSUCWm3eh4FmeIEpXNM4F74AhOJBvsb90tW4OJoyX6rnk8y5QUp3ndlKmIzKhoAPXpjScmfmGDI7fxtgOEo6HMtVHTF+7RRYRkUvElWNWgJ2PA09Ul0SI9l+7WhNC8FtCL/HvImKI4U0C51nB4s0AJ2wDBcyDoXcQdDW18+0ksSiK4FT71NmWEERwIH2FdBlEoWiwlHnpvqq0PIX/S/P8M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c206f74f-7bfd-4e2d-c499-08df095c9b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:42:25.5961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mgtM5GUX4gMUh2tHNhAnD/AqL6pqhOZ9yObijs3pWl7Z7VZR3W8GW7DEwiM2J6USfCE7AHMfaQToxU81BS/XwQNXOVN0hyGiz5ZdnX7/lKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
QWRkIGEgTWVtb3J5UmVnaW9uIHBhcmFtZXRlciB0byByaXNjdl9jcmVhdGVfYWlhKCksIHRvIGJl
IHBhc3NlZCBvbgo+IHRvCj4gdGhlIElNU0lDIGFuZCBBUExJQyBoZWxwZXJzIHNvIGEgU29DIGNh
biBoYXZlIHRoZSBjb250cm9sbGVycyBtYXBwZWQKPiBpbnRvIGl0cyBvd24gbWVtb3J5IGNvbnRh
aW5lci4gQm90aCBjYWxsZXJzIHBhc3Mgc3lzdGVtX21lbW9yeSwgc28KPiB0aGVyZQo+IGlzIG5v
IGNoYW5nZSBpbiBiZWhhdmlvdXIuCj4gCj4gQXMgdGhlIGNvbnRyb2xsZXJzIGRvbid0IHlldCB0
YWtlIGEgTWVtb3J5UmVnaW9uIHRoZSBwYXJhbWV0ZXIgaXMgbm90Cj4geWV0IHBhc3NlZCBvbi4g
Q2hhbmdpbmcgcmlzY3ZfY3JlYXRlX2FpYSBmaXJzdCBhdm9pZHMgY2h1cm4gaW4gdGhlCj4gaW50
ZXJtZWRpYXRlIGNvbW1pdHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9lbCBTdGFubGV5IDxqb2Vs
QGptcy5pZC5hdT4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGh3L3Jpc2N2L2FpYS5owqDCoMKgwqDC
oMKgwqDCoCB8IDIgKy0KPiDCoGh3L3Jpc2N2L2FpYS5jwqDCoMKgwqDCoMKgwqDCoCB8IDIgKy0K
PiDCoGh3L3Jpc2N2L3R0X2F0bGFudGlzLmMgfCAzICsrLQo+IMKgaHcvcmlzY3YvdmlydC5jwqDC
oMKgwqDCoMKgwqAgfCAzICsrLQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L2FpYS5oIGIvaHcvcmlz
Y3YvYWlhLmgKPiBpbmRleCAzYjZkN2Y5NjI1MDYuLjgyYWI2MDFiZjE4OCAxMDA2NDQKPiAtLS0g
YS9ody9yaXNjdi9haWEuaAo+ICsrKyBiL2h3L3Jpc2N2L2FpYS5oCj4gQEAgLTEzLDcgKzEzLDcg
QEAKPiDCoAo+IMKgdWludDMyX3QgaW1zaWNfbnVtX2JpdHModWludDMyX3QgY291bnQpOwo+IMKg
Cj4gLURldmljZVN0YXRlICpyaXNjdl9jcmVhdGVfYWlhKGJvb2wgbXNpbW9kZSwgaW50IGFpYV9n
dWVzdHMsCj4gK0RldmljZVN0YXRlICpyaXNjdl9jcmVhdGVfYWlhKE1lbW9yeVJlZ2lvbiAqbXIs
IGJvb2wgbXNpbW9kZSwgaW50Cj4gYWlhX2d1ZXN0cywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IG1faW1zaWNfc3Ry
aWRlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdWludDMyX3Qgc19pbXNpY19zdHJpZGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCBudW1fc291cmNl
cywKPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvYWlhLmMgYi9ody9yaXNjdi9haWEuYwo+IGluZGV4
IGMxYTU5ODI4NTZjNS4uNjUxNTUyYzhmOTcwIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L2FpYS5j
Cj4gKysrIGIvaHcvcmlzY3YvYWlhLmMKPiBAQCAtMjQsNyArMjQsNyBAQCB1aW50MzJfdCBpbXNp
Y19udW1fYml0cyh1aW50MzJfdCBjb3VudCkKPiDCoMKgwqDCoCByZXR1cm4gcmV0Owo+IMKgfQo+
IMKgCj4gLURldmljZVN0YXRlICpyaXNjdl9jcmVhdGVfYWlhKGJvb2wgbXNpbW9kZSwgaW50IGFp
YV9ndWVzdHMsCj4gK0RldmljZVN0YXRlICpyaXNjdl9jcmVhdGVfYWlhKE1lbW9yeVJlZ2lvbiAq
bXIsIGJvb2wgbXNpbW9kZSwgaW50Cj4gYWlhX2d1ZXN0cywKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IG1faW1zaWNf
c3RyaWRlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdWludDMyX3Qgc19pbXNpY19zdHJpZGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MTZfdCBudW1fc291
cmNlcywKPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvdHRfYXRsYW50aXMuYyBiL2h3L3Jpc2N2L3R0
X2F0bGFudGlzLmMKPiBpbmRleCBiYWJjZTJiNjgwZjIuLmQ2OTg1MWRmMGEwMSAxMDA2NDQKPiAt
LS0gYS9ody9yaXNjdi90dF9hdGxhbnRpcy5jCj4gKysrIGIvaHcvcmlzY3YvdHRfYXRsYW50aXMu
Ywo+IEBAIC00OTYsNyArNDk2LDggQEAgc3RhdGljIHZvaWQgdHRfYXRsYW50aXNfbWFjaGluZV9p
bml0KE1hY2hpbmVTdGF0ZQo+ICptYWNoaW5lKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZlcnJvcl9hYm9ydCk7Cj4gwqDCoMKgwqAg
c3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0UoJnMtPnNvYyksICZlcnJvcl9mYXRhbCk7Cj4g
wqAKPiAtwqDCoMKgIHMtPmlycWNoaXAgPSByaXNjdl9jcmVhdGVfYWlhKHRydWUsIFRUX0lNU0lD
X0dVRVNUUywKPiArwqDCoMKgIHMtPmlycWNoaXAgPSByaXNjdl9jcmVhdGVfYWlhKHN5c3RlbV9t
ZW1vcnksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0cnVlLCBUVF9JTVNJQ19HVUVTVFMsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
VFRfSU1TSUNfU1RSSURFLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRUX0lNU0lDX1NUUklERSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBUVF9JUlFDSElQX05VTV9TT1VSQ0VTLAo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0
LmMgYi9ody9yaXNjdi92aXJ0LmMKPiBpbmRleCAzMjljY2RiNWE3YjYuLjIyYTYwN2VkMTBiZiAx
MDA2NDQKPiAtLS0gYS9ody9yaXNjdi92aXJ0LmMKPiArKysgYi9ody9yaXNjdi92aXJ0LmMKPiBA
QCAtMTQxMSw4ICsxNDExLDkgQEAgc3RhdGljIHZvaWQgdmlydF9tYWNoaW5lX2luaXQoTWFjaGlu
ZVN0YXRlCj4gKm1hY2hpbmUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmlycWNoaXBb
aV0gPSB2aXJ0X2NyZWF0ZV9wbGljKHMtPm1lbW1hcCwgaSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYmFzZV9oYXJ0aWQsCj4gaGFydF9jb3VudCk7Cj4gwqDCoMKgwqDCoMKg
wqDCoCB9IGVsc2Ugewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgbXNpbW9kZSA9IHMt
PmFpYV90eXBlID09IFZJUlRfQUlBX1RZUEVfQVBMSUNfSU1TSUM7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGludCBpbXNpY19iaXRzID0gaW1zaWNfbnVtX2JpdHMocy0+YWlhX2d1ZXN0cyAr
IDEpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmlycWNoaXBbaV0gPSByaXNjdl9jcmVh
dGVfYWlhKHMtPmFpYV90eXBlID09Cj4gVklSVF9BSUFfVFlQRV9BUExJQ19JTVNJQywKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzLT5pcnFjaGlwW2ldID0gcmlzY3ZfY3JlYXRlX2FpYShzeXN0
ZW1fbWVtb3J5LCBtc2ltb2RlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
LT5haWFfZ3Vlc3RzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJTVNJQ19I
QVJUX1NJWkUoMCksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gSU1TSUNf
SEFSVF9TSVpFKGltc2ljX2JpdHMpLAo=

