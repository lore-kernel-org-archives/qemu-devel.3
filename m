Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8847C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwv60-0005ch-Vu; Thu, 20 Aug 2026 01:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwv60-0005cR-5E; Thu, 20 Aug 2026 01:13:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwv5y-0006yd-HG; Thu, 20 Aug 2026 01:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787202822; x=1818738822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=stUr23BxFuLZxKm51yF51hGPAz2jE6WSGxjHJwleJ5A=;
 b=cnG/3en2YypsaICZiXmgps6/tX++7vKcAdcQs6RyNh7NXQ9TBjYnhkq4
 SCP+Z+0DARU3yNikbfNaj/JyOURsnzh5K4+ktZTspc6Dj6W7r01Bs+onF
 Zy+IyNLSxvYYXy//s6eE1Qh+BhTZy+qmdSyJBJAqh4UR9j+3g/ffZU0+1
 phYJ0gUn5WWThOL767764K6hBaTk6igx3E4p8+HIsCoPoiQaK5YzPNGbf
 rZksDTDFdwLDOSG/SnrbDbRn6WThZL+gQu+OHcvOcBODTumXqMuHmkNBo
 pzIt/rdcqo+UJHX5YBXoHkzec1D5dL4Ix3wShnKBvIEOR14R5Hdrjk4QI Q==;
X-CSE-ConnectionGUID: y+/YmGC9Rx6fbaTUe6cOWQ==
X-CSE-MsgGUID: gnxPq25ASGGy1bw7yJzeCg==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; d="scan'208";a="152939306"
Received: from mail-northcentralusazon11012026.outbound.protection.outlook.com
 (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.26])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Aug 2026 13:13:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEGkEz3WfrBwKcsMn2P3hBw7Zc2C53UOYyN81T46hvxsA/kdJ6NfmpdOv18wa1DleqlzuU/p8NVYJbNTaF8W36LmG6k7lg11iE0g6QWOTw252fj1JMBZUoixRDDvMcWOObnEO9oBFldTWiCtie6SNEUHxobAPLN5Yna1YfXtYtHBjnOJYp6+pf6+1r+JXOcGu1pLVb79YVwyircL1RgVR2s5EWdxQD1RLgNO5T6Wpk0gOZo7wGDrW+MUORYSLQ22P4bweMLNZMFaW2dUFZ8SUDj8l6cJLLJYVOA3uyRhg5l5/LkzPrwRQjOEfxwZ6Bkj/T97U6XDppQU/pb3RumI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stUr23BxFuLZxKm51yF51hGPAz2jE6WSGxjHJwleJ5A=;
 b=ORfguPB7/2FTSKGGv8q4RKzOSv908INR9BHEEexnOMmP134lOyL5EPR1E0DmRBGbpAs6VO7F7MztgZpE0txTbgdAH3gtvsRA9UZ8E89w4Zp0LAoLa/kkr1jKnVGac9kqpRwPy02JKepsYEu2yU2RptFfGPwvfQNxp36syHrHSQ0rpTzy3Q4gwbTNN2lzMpvo8WiKC5YVnLuda+8pdQ7asXwElK6dKepFB9CdVgMEvv/jW/hLgjbipXK/VXAcFvgQ9TIPerr/PhYCMNxwy3yGDRCd6DU6ExJDSGJ3Loh7qvdnNlI7aGF/CMMb/rZgi5Uz1SNlaVCwzfXNWYUeEueHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stUr23BxFuLZxKm51yF51hGPAz2jE6WSGxjHJwleJ5A=;
 b=H1EIQ3RjjNRuRdccrGJLkHH1Hhd/FzW7r3Ti0TjmS+V2UymKi2+Ac3DcDdo7zZwGSdsymy+y4ZsGPZOxFuQDW3cOMt6jhMDZ0upkqWN8Fx/RkwS8LBC38irmp6GyM7amuenjYvnhvdaK2FhqC81YMZvcy/YHPVUWXQMMwGqBZxk=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB994607.namprd04.prod.outlook.com (2603:10b6:510:43f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:13:37 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:13:37 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "liuxu@nucleisys.com" <liuxu@nucleisys.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Make Zcmt JVT loads endian-aware
Thread-Topic: [PATCH] target/riscv: Make Zcmt JVT loads endian-aware
Thread-Index: AQHdLiK2jfyfGGFOYU+C7lx9Ti0ChLamaQgA
Date: Thu, 20 Aug 2026 05:13:37 +0000
Message-ID: <51949f8b857ee90aa55356e05434d89873176b6e.camel@wdc.com>
References: <02050B1BBB8815BE+20260817083005.2392-1-liuxu@nucleisys.com>
In-Reply-To: <02050B1BBB8815BE+20260817083005.2392-1-liuxu@nucleisys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB994607:EE_
x-ms-office365-filtering-correlation-id: 9717bfff-a4e4-46de-1746-08defe79ca92
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 8XvLu4MBwxsuVSjKENgECoBpBGVKpCcMHLY71zYVnG6d/iDpJvH3gdu/Bgxv2VqvBFUd3TzqQxfdU0OxKfT+yJu4RZQbrvV+bQY4r1die+WeR5dgjPHM+WbqB71quYyE4DvflcaJK8NvUedAMeDENiKaRuW17SoMVATHZMA5B7oF3YL3rpeZUpTkJ+pswBVsduH9K6WwnY4RyjwYoiTKhDo29ERqCU5GwQy0767fSpPadeSx2d/Yti6tYRxBOXCMgj5LbX8rcDq2QlyG8YkklbRZhNO1BOxP77FbcUBgNZs1juhQc3qV7hB/1772IY818YMtSXnNBmjfuHhGQEvJ8lo3xWvHv8uEvSSU3XGcnxE+p7hhQX8SvVHyVfmrFB+D5kiivfYV6bGsqu+pVYSQy7EwYH1IAO3iYnCSXncVWWTiskNdbvQr7Vo8GJZkz82PEOYnQBWpd5s28UpVcXkJr3isyT0f4R71/ug99ktUEt4RRdsevFW1r+FduZtZky7lqaOKcSIP+waCsuffRKWgDge0oKwa0WrPo8DoyfIENlFdYrJUH23OQeH+xzHM+O75bxjzMTU5tvSTQT2wdUw+HY3i+S7JO92T33Qucl/yQ/Uonll4rsqsOzZufQqnnrX+wkOLCegYDLuFMnOw18jlVv0KKn0AuhPzixbVX7AHxsII1S6ILnt3+iy3kF0b59bg3l8q7azc+OAHnnqN6/1P10wEh0jmWyMeJiTPCR7x7+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjExVnZJNmVpcWVTc0NhZXJacUdkekVJQVdaelhyL3ZXL1hHZXZJRCs2UmNB?=
 =?utf-8?B?bzBMaC80c2p6Snl6SDg2b3lQbDVtaGdDZ2NZQld6NVVscHRsRkxTUnJwODRy?=
 =?utf-8?B?QjRseFFWbUc4aTkxTU55eSs4SVpCV2lVT3RCWjVCUWd0S00vMktrQUVrM2lK?=
 =?utf-8?B?MUp6UTRobi9YYnplR0MwMkJiQXVESG15bkpSSWUyQ2RDcGVnZFBVbE55T0RD?=
 =?utf-8?B?b04rVjNGWVhVV1cvTmEyZFBWcVVRdTNCa204RHF4YzlYaWswS1o1ZmFsZ3pO?=
 =?utf-8?B?RWY4K1JkZEl2QlhpeXMxbENQVDB2ZENPV1hVMXhVc3RlV3VyZHBPYVp6OVJo?=
 =?utf-8?B?cTl2bnEzZUU2a0hMTDg2TUNmVVBoMnI0N08yNHNqTmFIVW1tMVRHQmVtY2tX?=
 =?utf-8?B?U1Rpb1JKb0RYbmdrZjFHVWxSZHZzRytIdHFLVUZqdmlWdXVIbmZtKzhHZE51?=
 =?utf-8?B?QzlTdUFuWFFOQU9uelVlTlNIeGVwQmpFeHZkN0twQjVUSWY4N1ZuL3cyOFpV?=
 =?utf-8?B?UnRITFZSenl4VUtRYk9GY0hxYTJBU2MxVW5QVEE4eWJvUHVZVjZidkxzT2RW?=
 =?utf-8?B?Nkc0aVRCd1B3cUF1REh1NXRDallLYUNGKytHZFRRMWdoY2I1aTVMMHE0cUhD?=
 =?utf-8?B?WFlmdVl6bnVUS1ViSWQwQ1kybU5rd01KWDVrSlgzc1NCdHh2YW5HRTJkVEd3?=
 =?utf-8?B?VjZNQmZqcFJNZmYxZ0grbktDZVNZUkhTQ1lEM3ZlcHBvakdmcHlBT3pmVUs5?=
 =?utf-8?B?bmVYRlVWOEhKUVg3WjFsV2RybGJtUWdnb3Q5NUJIaHB1bytoaFNzUElVMWxn?=
 =?utf-8?B?ZHR5Q2FCU2Juc0l6R000ZTBXZ3dQUmlPd01uZ3NrcU55UGd0Y2J4TWQzNzNh?=
 =?utf-8?B?UEVJYkw4d0daQ080cktjbktIWU0zRlhIQXJMaWVpekRNT3ZvTndaTFBVSU94?=
 =?utf-8?B?cjhvclJGL2tZcjd6eE04N1NYQWRkM2U4UWNQMGplY05jSXBPTVRSYjN2Y1or?=
 =?utf-8?B?am5Mbk5GS1dUQ2JIQjZnTHNrOC9FbWhhd0ZmWmI3YlJ2YXh0RzRCck52R09x?=
 =?utf-8?B?bHMyZVh5bHJkbG9uTzZSckJ2dC9Iek54b2dxb3o2OFZBV1FEN2dSNDlMY3FB?=
 =?utf-8?B?bWRIbzB4Q1Bha2RrdDFFbWZabHl3RW41UEd1ZlpjaUY1a3ltSmd5WDY4ZUk2?=
 =?utf-8?B?bzhZZ2p3NW1Bb093SG4rc3U2YUpFYXgzS05iVjdzM3liYWQwbDVHeGNCcHdp?=
 =?utf-8?B?R1U4Z1dQaU9VcForbVVFRjVWYkZtWlkxUStKdHZZR1d4K25MUFlIemwxZmdM?=
 =?utf-8?B?UTcvanUxNjF4RWN1RDdxS1gyZmlORkVoZTRPNksxQVJ6UHpiSXJmOTJmazk5?=
 =?utf-8?B?bklHZEZQelBUTHBEYndJZGVsZFN3VFBPTnJLSWY3Z0JzMEw2bjI4TGxudTJ6?=
 =?utf-8?B?YW1tak80NlZKaERva3N4WVpaNEZBdG5WN2E4c0t1QUFJNDRCdTRRVHQrSzBG?=
 =?utf-8?B?WEJhKy9SM0p1UUY5MStsN25jSktYQkkraGYzQytSZWMzakJuVkhpdFRhOXoy?=
 =?utf-8?B?U0V6aFB4RHZkemR1djZkTlphaDM1Z2NBT1RVLzNaQ3ZtU0dqcmFObjkzb3Jj?=
 =?utf-8?B?b3JFb3YyQ2pGQWR2K0E2YlRrTkRiYTI5eWs2TFdiYXkxRzFVZlI5cGJjcXZx?=
 =?utf-8?B?WTFyQVZ1RmUwSldzc1VvS2xvNzdtWHFHMUdha3ZPMzRFRFBRaExkYjE3TUN3?=
 =?utf-8?B?dXQ5Z0Eyd1NIWmh6dWl6cmk1Zy9ZcER4QjQ1OG5LSTUrdXVoWllFUDlUOTha?=
 =?utf-8?B?WlE1UVNoTlNRUjB2bVQ0bjgxa3J5alhmVFpsN3hLQnBZenBkckh0LzRQcnBJ?=
 =?utf-8?B?TEFOODBnc1h2KzRoclFFLzVoTjdZamxzOFdScFlCMmJVMWxwRVUySlVvOTQ1?=
 =?utf-8?B?Q3AwenlHOTZScllRTU8zU01BT3RSTUFyTitrWWFleXFiUEhNTmRWR3BJMzhj?=
 =?utf-8?B?RnpDaUErWVQwbGh5VHZqMnBHR01zbFN1Nm5BSnB5N092YldycEN5QXcwV0dj?=
 =?utf-8?B?cUplR2hSeEQyNnQ3UHlsSXkwYmdxNFlVSU9Pcm1UWFNCYmpwV0ZGWU9ya3Jj?=
 =?utf-8?B?QjNSK1FteE1EM1huQUxlUENQKzRFMXJUdVQxd2xHck1tc2gzb1J1NHlFZUhI?=
 =?utf-8?B?ODR0WEJQZHlBdG9rd3RMWXJKSmZVcHZuT1k5ZERrTXYvakZtQ3FwbmhRRzJm?=
 =?utf-8?B?MVM1ZWtXTlhWTmZybUMyYTY2c1Iwb2szWkRoM3dJQlZlRmJKS1Voc09TR3ZW?=
 =?utf-8?B?NEp5eDdLeUhoN1ZkeUFVRE9YQmprcnVidmhSSlVDUVdvaE1UZS9IMWhyTnRv?=
 =?utf-8?Q?v+bpNB6zARaS89UycP9doSy86vgw1TJAxA01RFsou5nJx?=
x-ms-exchange-antispam-messagedata-1: EKhdBcCGJHAqgwlPWJ7psK5z7WTBrhnt2FM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B2DA479F71298429909C3D1DB1ABC09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JDW3dSppv6xxe5XepnYsNdqrly//TvXB0eLJYBJFuFj0Iymo9+BUjy7UN5XpZl9AKvwI5wIo+Y7KVcrtXrZlFr6AKoFq89eFeqjxN26Oh0KfcgAEfWnNsL2AeOSkYNxO01hXmhGZ6IttpakPH7b6+62M8PDIaTcNoRjByefrB3YKaD/9bVFQzMnKGt99wVZm7QtjdBcXqC8L39lFrgSJicAmWzZo6DFDJbAYRBywuPwGRd60V6zskGPC1k0I7MIZ/cegRUtWhbXTaFekBvh1Y04B+v2QB+CRNgbLK0ys2MjD0Sqrgkr3oIB+QKvi0mzHUymxOF5hxMHHAkvPRrwNXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8+kj1T8i52qvHMpvKYchHWmBnS47oTEoGer3UvRBHa79HpuwyJhglwpDOgFeYdRd5oplI1U65RmyF+yJiStMHTl0vQJzDX6+RqR2OqiL9UFI08C7REXeUQ/upzC6x9HfKrDmPvc7SvUw/eKl2zi8/BPDbnZU1wcPtygh/oeD9WCSrCG8Y/H/sopvJS/aUMPOaadKzjjIuHNBry0QsMeHTu48ikGcY9VEDLZt3bxCIHawVYGr4osJgbiOmWkOoFjCG/xysUgY1+E6ihEDACeQV9A1BFn+N+ZrR6B48GyWEB3GYJhWu2ertQzzNHgimGqquXeztHzZxRYTR3QtyJzdA2farRqN8BrfoPjyajEUSUvgMNyWFlS2SAaC9k9uafe/lI/3Ue2cpZDb85fDh8TPuTbyYlLAZl/ZX1duePh65FcfSSzR0FR1J9aiKdc1MwfEypRD4cqFeUTjufzufIfTFKaeu/D4OYyg+2Y4d+sP6V1JSrk6e8Tty8BqnIrji06szI/Wt167l7nXRwtOcd1bgHw/J6HU0o54Ch+9dbuGp1l+SDM5TWE/c+KmbNAz6Jmm/1+7S/FSjZ7G5X6hU/FpViQpjZ7GP+An1IdBy35t/EY6prWnhIuslsk0v+H/sqOl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9717bfff-a4e4-46de-1746-08defe79ca92
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 05:13:37.6101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGfQIJSyWb+LGsSYvbsPtxeb1Ucbc5CR27W8lXEuubDVGNjHeyui4ha06gns80ZxhVagZm5vULiltZWbBmarwurWThDBmn2vWdokGDFh+gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB994607
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=685c7dad1=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTE3IGF0IDE2OjMwICswODAwLCBYdSBMaXUgd3JvdGU6DQo+IFRoZSBa
Y210IHNwZWNpZmljYXRpb24gc2F5cyBKVlQgdGFibGUgZW50cmllcyBmb2xsb3cgdGhlIGN1cnJl
bnQgZGF0YQ0KPiBlbmRpYW5uZXNzLiBTdXBwb3J0IHRoYXQgYmVoYXZpb3IgYXMgZGVzY3JpYmVk
IGJ5IHRoZSBzcGVjaWZpY2F0aW9uDQo+IHNvDQo+IGJpZy1lbmRpYW4gZ3Vlc3RzIGNhbiB1c2Ug
SlZUIHRhYmxlcyBzdG9yZWQgaW4gYmlnLWVuZGlhbiBmb3JtLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWHUgTGl1IDxsaXV4dUBudWNsZWlzeXMuY29tPg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8g
cmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNj
di90Y2cvemNlX2hlbHBlci5jIHwgNiArKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di90Y2cvemNlX2hlbHBlci5jDQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy96Y2VfaGVscGVyLmMNCj4g
aW5kZXggMTViZjBhOTljOGEuLmM2YmE0YzFhNDc2IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlz
Y3YvdGNnL3pjZV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL3pjZV9oZWxwZXIu
Yw0KPiBAQCAtMTgsMTIgKzE4LDE0IEBADQo+IMKgDQo+IMKgI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCINCj4gwqAjaW5jbHVkZSAiY3B1LmgiDQo+ICsjaW5jbHVkZSAiaW50ZXJuYWxzLmgiDQo+IMKg
I2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiDQo+IMKgI2luY2x1ZGUgImFjY2VsL3RjZy9j
cHUtbGRzdC5oIg0KPiDCoA0KPiDCoHRhcmdldF91bG9uZyBIRUxQRVIoY21famFsdCkoQ1BVUklT
Q1ZTdGF0ZSAqZW52LCB1aW50MzJfdCBpbmRleCkNCj4gwqB7DQo+IMKgwqDCoMKgIHVuc2lnbmVk
IG1tdV9pbmRleCA9IGNwdV9tbXVfaW5kZXgoZW52X2NwdShlbnYpLCB0cnVlKTsNCj4gK8KgwqDC
oCBNZW1PcCBlbmRpYW4gPSBtb19lbmRpYW5fZW52KGVudik7DQo+IMKgwqDCoMKgIE1lbU9wSWR4
IG9pOw0KPiDCoA0KPiDCoCNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiBAQCAtNDUs
MTEgKzQ3LDExIEBAIHRhcmdldF91bG9uZyBIRUxQRVIoY21famFsdCkoQ1BVUklTQ1ZTdGF0ZSAq
ZW52LA0KPiB1aW50MzJfdCBpbmRleCkNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiDCoMKgwqDCoCBp
ZiAoeGxlbiA9PSAzMikgew0KPiAtwqDCoMKgwqDCoMKgwqAgb2kgPSBtYWtlX21lbW9wX2lkeChN
T19MRVVMLCBtbXVfaW5kZXgpOw0KPiArwqDCoMKgwqDCoMKgwqAgb2kgPSBtYWtlX21lbW9wX2lk
eChNT19VTCB8IGVuZGlhbiwgbW11X2luZGV4KTsNCj4gwqDCoMKgwqDCoMKgwqDCoCB0MCA9IGJh
c2UgKyAoaW5kZXggPDwgMik7DQo+IMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0ID0gY3B1X2xkbF9j
b2RlX21tdShlbnYsIHQwLCBvaSwgMCk7DQo+IMKgwqDCoMKgIH0gZWxzZSB7DQo+IC3CoMKgwqDC
oMKgwqDCoCBvaSA9IG1ha2VfbWVtb3BfaWR4KE1PX0xFVVEsIG1tdV9pbmRleCk7DQo+ICvCoMKg
wqDCoMKgwqDCoCBvaSA9IG1ha2VfbWVtb3BfaWR4KE1PX1VRIHwgZW5kaWFuLCBtbXVfaW5kZXgp
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgIHQwID0gYmFzZSArIChpbmRleCA8PCAzKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoCB0YXJnZXQgPSBjcHVfbGRxX2NvZGVfbW11KGVudiwgdDAsIG9pLCAwKTsNCj4g
wqDCoMKgwqAgfQ0K

