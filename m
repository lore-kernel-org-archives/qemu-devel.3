Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B59C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63JZ-0000WN-4M; Mon, 14 Sep 2026 05:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@citrix.com>)
 id 1x63JX-0000Vw-Gm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:49:27 -0400
Received: from mail-westcentralusazon11010045.outbound.protection.outlook.com
 ([40.93.198.45] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.syms@citrix.com>)
 id 1x63JV-0003NO-OB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:49:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu4LQQQLeOrvyQavYgmGeRAB7L/Q8S3GjfmFoBlroudlIyBnodyofSLY4iJhLLQBSjMmPE2yFC5gYayiCQA2knr2j0y+a9Y4EJVn/ehGqbe1ks/faC7w3EYbU881v28T+F8L4RZR9BuUdzZm1o0cfsOyXUPWEEo+xlBk4KUjh+wECgoKdFc4aVq1/UfSx8z8zSbCkf0ObqL21n5qKhLIVNRiZY94+6iIm9ejNS1LoHvqnNVdS4n/mSRCGINGKWixdsQ0c20xvcWYCT5GcBABYur9u/VhEKvzhgRtqN+wdOz2L5oGPUGFP7ta125XdzlL18I2ztW33h4qNfcVa8dBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVCM9Bd8dtXmxY2Pdmu4BEKJXZLE+qyH8JEtcseR1aw=;
 b=TA7vBxdOK7eF2nTi1Sy/8ynn8o0NsPuGmFKAZlPiOP5zNlyHNOWjXrEOzoLbkZ9WaSIGBbClQS++flAj4oolNu6wbwcfd3GUklKBG16ycqhqeXp1EJDQNTcvh8tqgi8h11wOhpyH9y7nF5UEhHFbVxWMi0tQdFHmspmh2YA1Tmu1SLVKWLlRvRKBigIGvrYpsdz3d+j8lUGug57kBXMfRFcwoImaA4wEKa9r9XMyiOJrcyqHZBDxJ+oSDn88+zxihjef+sWNeVS8yW3EJGRlKGfaWWmLQ/XBeoia79EfVKBCoQj2IDeqE9eOOtXeBRMvuf1z5M4NwP4cSXPGG8Qzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVCM9Bd8dtXmxY2Pdmu4BEKJXZLE+qyH8JEtcseR1aw=;
 b=m3oXGnvmKpWqJlE+pn8mlFG8iPlrQwvxO9TkVEDsk40y3xU2vXBnA334sRlfG4lwVt2u5Z7KbJ8zorVp5/ttHNUeEitaWdm2EQViR8PpHSyHQk7Lkp4Dm/ek2A14XzB/oPl1D0iArGiPNySRoDfS7/YEdNaVvAkqheGGLC9AW2c=
Received: from DS0PR03MB7557.namprd03.prod.outlook.com (2603:10b6:8:1fc::8) by
 PH9PR03MB150476.namprd03.prod.outlook.com (2603:10b6:510:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 09:44:21 +0000
Received: from DS0PR03MB7557.namprd03.prod.outlook.com
 ([fe80::6884:8bd5:3e4d:fde7]) by DS0PR03MB7557.namprd03.prod.outlook.com
 ([fe80::6884:8bd5:3e4d:fde7%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:44:20 +0000
From: Mark Syms <mark.syms@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [bug] hw/xen/xen-bus.c return type confusion and missing error
 handling
Thread-Topic: [bug] hw/xen/xen-bus.c return type confusion and missing error
 handling
Thread-Index: AQHdRC1AOIgl1NL+C0ast83t01+HHg==
Date: Mon, 14 Sep 2026 09:44:20 +0000
Message-ID: <DS0PR03MB7557FE84436F26DAC1E9FCC787BB2@DS0PR03MB7557.namprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR03MB7557:EE_|PH9PR03MB150476:EE_
x-ms-office365-filtering-correlation-id: 66a872f0-f95f-4c71-f319-08df1244c0a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|11063799006|10067099003|56012099006|5023799004|6133799003|18002099003;
x-microsoft-antispam-message-info: 4KGoN9a+/RQKxVBpaOJAcjgwAuHWJVd4vUNraPEwnYefdgEPcER0hxqv0qYQU70CgeePd0LycyMcl9tWsJ0t6peTbm5LjqjZf2gs9eDi/TlcrBFof8RTf0dt06GtXf7z3RudpgIg5RaxFNphw0yfFXrUWPctSDQzC7vXJmaxfCNG6ghinEAacKy/OQRqZVooHqPDInEmEHvFZ+JgdPwLJKLM2s2kYq1q83jFRE6ohvRvTSFSre+SAwx9qmqgurXSZGC4lDlgsoGea60C1fB9bj9F72N1nNjm+VAcuF8Xn4qM/lZ2MmGgGb1/mpdi3U0rzzLRgYMQCZsQxdIL9m2PEGUiUV//dW1NQ7DQ6DKHpKbjWdubU6KtbghzlLeWrggcYQIPRd/bgeRpHLcS4qKfgaggofBa2mcdtDT9TB4BIFCVMk6TnyeZBeixbGi+Ta80Eb77+EKCwxrmh3qrkVpTi8qr40PGk/oOAGBFlFVfdUpPnPVIXOYqXzEZucqAi0rb1Fr2AnPZfJE052pm1n/Zwfu7/Yhuu+t9UlcoumvQDceRL8EooztfFgrsgaBwdCpBDLtKp3jQMREMogpw73Qq7S62BFOjm3OW9O8ifiRY/yQBhhHlFngbwYf1ioDUk8p9UJcUe5ISWJ/i6LuErQk5kxvKSbdEdKS/Y0dOCiq2UCPWZ66Guk7VcyC3yIbggRDxxX/bgXyOXNKcYsWY/HDSY19JqfBuYqY10nb6Ep6+CVw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR03MB7557.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(11063799006)(10067099003)(56012099006)(5023799004)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?USmMPSwaSurNc63knlBk9ICcwH93nHTSs/r3Sj4gwOINfZvEBp84Z7rwb7?=
 =?iso-8859-1?Q?zLv5xVH31tHKghN2QODgLqBwgXEIdogjSX2FF3IqKRLj01+iy4Ai+TSPrR?=
 =?iso-8859-1?Q?bMIL+9/zg2d0Eq48zHkSnoBjjV8lXGj8ARRVamktZ+00QE9yQ8xrMIu8zP?=
 =?iso-8859-1?Q?c3wVPOJysCp+/tW7tROdILN17AROiEsBTClq/Pex5Zf36nDLUjeaxz/ai0?=
 =?iso-8859-1?Q?3iVdFFvYnt5NQv7KzuhVawKBg/6DNP53/0Q6fyepuFGPuv2aLgOmWa4oE2?=
 =?iso-8859-1?Q?mCGdcRrSf2rLJJwcOerVGs1xeuD6w+awj2wAwDBMBc1Oo80UHLMBJrVvTu?=
 =?iso-8859-1?Q?5BzX6GeEfra+WvNN7Ox06NJu67535essLOrxsGvuO/T4c+mfSRDCZ4waCx?=
 =?iso-8859-1?Q?KgvfAv64Mj6g+tuEngBqyGRSopy53ok4FilYRgwZFZ0Hlq/5a2a5MkAfSN?=
 =?iso-8859-1?Q?9zNDVYrA7oZsOYamqzLDyIs7gARdU8U/VYwVKELXAARda566SuYTt5BP2t?=
 =?iso-8859-1?Q?4MqVp6WO8/Q7AlVi/CG9dSxnpCtJic4C1yUmcy+0t0XKtKljN2gVYXaorD?=
 =?iso-8859-1?Q?XSb4jo1W5Q6c4tl9vKT722co1fxTLjhf6VopEx6IMAyr5j1E6QtJcPEhWc?=
 =?iso-8859-1?Q?flk82GsIMbt+k21baCtoJ2hBeKPYCCl8QPDM0WmmDbscT8gVjX2MFJR3l3?=
 =?iso-8859-1?Q?sUB25tHK9y0m4wWfQWh6UzyLklAnxqFu/MZX/1J/dnKrvIaz4wmDr1MKgj?=
 =?iso-8859-1?Q?Kwix5kNCW2YtiXGgev0rdPPcT7Z+GuO3DzpNh7NCWsUQlRFnva8Zesl0Hj?=
 =?iso-8859-1?Q?8AQgHH4meGWFMk3x8bxGhlM6vILFmVG0+7f2TdINE0SDJxmz2UmNY7YMW7?=
 =?iso-8859-1?Q?luRiDX6xJHhvr/mV0OQAQ1tCsCZ7n6j96byUnuo72hLvuZBRxO3AXfIEHb?=
 =?iso-8859-1?Q?OTZ35w1zzXaCs2padvUuJYae73lKwO+xlH4BmAMHKeEJ214CIJtZCdTF0y?=
 =?iso-8859-1?Q?8FNMq+t2n7TUsZSJ6vpbJ9f7+VP7vWETTGqc5Ajd+GkjHWEkMUE5sxGXGt?=
 =?iso-8859-1?Q?nJct8rq19c5i2+HTMCTZY7Ou1vII7//H1R+gtl+3yVVC9ynLrDioKcxooW?=
 =?iso-8859-1?Q?H9mBTmtzV6HQaP2yt0UotC/PCnFC1b6eAN0ws/BcqhLP0zUZOkR8j4qq/Q?=
 =?iso-8859-1?Q?A8GqLEzlJH5ZILn21CF12jr2HHsq2PZahFpUkpoWVmjOnVFuctUfDNXePi?=
 =?iso-8859-1?Q?b+jbyec2/vc/ObInt9PYQWfaot97BtWf6HiEbQxGqaiFLiinhGcE38eIp9?=
 =?iso-8859-1?Q?OeZzZQqhFIZbaYchO/mMwgz683oDYfSd37V2iYvYmHxXZvzArmdySMys+H?=
 =?iso-8859-1?Q?5nORCQseW7gfM9pEzqL7nJjdC6BoVSusCtEYbQl0uKwDkbL4bX95Rp2XyP?=
 =?iso-8859-1?Q?0JQ3HYSL9QbP1pKuaiusNy4udVlyBoE/9IGF5gV0sjdMxyF5BxpU03jlsB?=
 =?iso-8859-1?Q?WbX+x++aMA8VrqZUNiRGKCgMS6h+1wzVEMOpFhrsZA5xgxIFO9rXA4a6aG?=
 =?iso-8859-1?Q?AsMZZBh0MnpnmOTdYOcWuUIkqjU72vRoQXoq3AqAP1hfFP5LXAD4bCEZAi?=
 =?iso-8859-1?Q?g4Hn7jaPSf6YP5L7jJr3/Yi+9Q3uLo5BjHILYFoYdC3xEl3FuNs/158FpT?=
 =?iso-8859-1?Q?Xj7d6tnfaU/+rKSmXLhBg0mW9ULaXmhcA+/dx7Qy59en58mC5xK2tjz0Sf?=
 =?iso-8859-1?Q?/J1+hL5WJ1l5HGacShOMT0FYXUrwb4OzXoF3o5+3kS0itg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR03MB7557.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a872f0-f95f-4c71-f319-08df1244c0a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 09:44:20.9239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5SDQWgZsxKHEWIe3WY4/KNzgIuzIOwPAqBapzMaJV8sn8rpGmScrGu8vrmWJDY7n3i+5tQCRtQ5ciiaEYyHxYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR03MB150476
Received-SPF: pass client-ip=40.93.198.45; envelope-from=mark.syms@citrix.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

We found a bug in `xen_device_event` in `hw/xen/xen-bus.c`. The call=0A=
to `qemu_xen_evtchn_pending` places its return value into an `unsigned=0A=
long` variable. The function returns a signed int -=0A=
=0A=
```c=0A=
static inline int qemu_xen_evtchn_pending(xenevtchn_handle *xc)=0A=
```=0A=
=0A=
Thus, forcing this into an unsigned type sign extends a negative,=0A=
error, return. In particular `-1` which is the error return from=0A=
`xen_evtchn_ops->pending` will become `0xFFFFFFFFFFFFFFFF`. To further=0A=
exacerbate this there is no handling of an error return from this=0A=
call.=0A=
=0A=
As things stand currently in the mainline this does not directly cause=0A=
a problem. But, if for some reason, in our case a buggy development=0A=
patch, an error is returned nothing distinguishes the return from a=0A=
benign port mismatch. If the event polling keeps reporting ready, the=0A=
event loop will re-enter immediately, resulting in a CPU spin.=0A=
=0A=
Other callers of this function, in `xen_pvdev.c` & `xen-hvm-common.c`=0A=
store the return into an `evtchn_port_t` and check if the value does=0A=
not match the `local_port` and take appropriate action. Even this is a=0A=
bit questionable as `evtchn_port_t` is still unsigned.=0A=
=0A=
Whilst this was exposed by a bug in some development code we were=0A=
working on we can't say whether this could occur for other reasons=0A=
such as the ring being filled.=0A=
=0A=
I'm reporting this as an issue rather than via a patch as whilst we=0A=
have a fix in our local build it was generated by our corporate=0A=
agentic AI.=0A=
=0A=
Regards,=0A=
=0A=
Mark=0A=
XenServer Storage Engineering.=

