Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC1CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIbsP-00011g-Vk; Sun, 18 Oct 2026 21:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIbsN-00010y-NC; Sun, 18 Oct 2026 21:09:19 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xIbsL-00038L-2A; Sun, 18 Oct 2026 21:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792372157; x=1823908157;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ccTFouVPCFkkUI1is5kD3J9L8XQqMMN5SP/Dz81PI18=;
 b=EhQkcs3Va+1O80s//MQ1jLrXon5dhY0ZpPRAERlxfyL6FIeSUNaesOja
 3yyiXkQt+Gk6SfVSKUdpeFekbjZzCmBscI8FqGyELrVyNZGFSgvRDf1EJ
 vaF1uizPueXpyTtrexWN+EXmH9LleZqcckzvAATGTCc2wyE8mpEh/PylN
 M44+YOQ0/BW/mEVF4DjkXwJNo9EFUcJfMUoLVhNeeiblJwKr79aGTvClV
 PXddedo5O35rVa/uLDD5oVlddjShkH6hs5V+BiI+52TW8vej9LRV8mmQ4
 od7H9GFm325/D7fdx0wPJlH0KQXXD9kdqlEWTcCYrBYYIdk7VzV5GCGpY Q==;
X-CSE-ConnectionGUID: cCdQdLHaQWun+wSScaClbw==
X-CSE-MsgGUID: VITxgUtwTRCxLH5WeJ9YWA==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="157449736"
Received: from mail-eastusazon11011069.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 09:09:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNKrQSIUGcuqiZQ+7wxRfESZnYhlivoROKzEkcCQtoiAOQDNQyylUlHPVZXnW1VnUFTMFDxXWrSZ6Nvb5ocl7R84CQye0sH+6sEjKhq0HumegWFITfcc5rPGnkqblJ0H5ZJTKKx02QVJzADeRgBFJprsTckavJsMKMhbGRglhOmvQx/zfoxiFiZz2tsYKj8sjU9jrUtRl3WbCDRZz4jMj5QtEA+vbDT30eNDVZ+LQDKtTOnjF0kVwI/xuPXKob7lGtZSEQSVpFp5zB3+W1RXgdnl64KmyoJIJRDBYO8tP7V/WDCgBdIX0QurcVx47ahG5QKWOOovvgdB8jL9x2GU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccTFouVPCFkkUI1is5kD3J9L8XQqMMN5SP/Dz81PI18=;
 b=snjb1NVVXpohWX2ADmfxW/2j1DTNYqIZfthFaMqM3Gk7kI+eGUJG/TXRzSy8wYANoGdHwRJSvqGU4Z3ZP36SPXLJZdnR7XmbiJ7fgkTwg6cJQNmBtMd1dvz2HFQuYNRBaeax3WC3WkgwOf9Gcj2KsF1/j+/j1Fif91s4uZRvV0NpDwN+yYHg9U+c3NZ6RU2iE+aTkqzcGvy/QSeNI1UknSOW8ima4DItzzA9n9LMuh2tuFi9sODXo/6sCp7v4AtPWIybMyzjMkwsJXo/5AHCDAIJq7/3pLXvfEuKvxYq32VGFi8YSmfP8zm+BK2oFnrGgUtJ2ucR+z90vnS6XZPLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccTFouVPCFkkUI1is5kD3J9L8XQqMMN5SP/Dz81PI18=;
 b=oFXpBzD3U0A3NyEBzCWcPr06Yz27H0Z83ht1IZ1QCjkW2CD0/YSOV5fR/ZNfe62wD4Iw9fkNie7XGxoB55BBMHYde9FXecIItEdeMM+KS+KLyagl5MI7wgb72d9zb3PCrB4iimuwZhR2+c65wG16bt23kKCAmPyfHUSR71511JI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DS0PR04MB8741.namprd04.prod.outlook.com (2603:10b6:8:127::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 01:09:07 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 01:09:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>, "mjt@tls.msk.ru"
 <mjt@tls.msk.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH v3] target/riscv: fix RV32 fixed counter accesses
Thread-Topic: [PATCH v3] target/riscv: fix RV32 fixed counter accesses
Thread-Index: AQHdVthrQ2+jkjyZ0kGg/uVNFKJ/Zrb/y1YAgART14A=
Date: Mon, 19 Oct 2026 01:09:07 +0000
Message-ID: <c241bc1bb83a700f8c69228996422870c6e464ac.camel@wdc.com>
References: <20261008035150.2223-1-fritchleybohrer@gmail.com>
 <3a0084cf-3fe9-40fe-b530-11f4387f404f@tls.msk.ru>
In-Reply-To: <3a0084cf-3fe9-40fe-b530-11f4387f404f@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DS0PR04MB8741:EE_
x-ms-office365-filtering-correlation-id: 7c9d0345-ba51-4e52-8d11-08df2d7d9333
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|19092799006|366016|1800799024|376014|7416014|38070700021|11063799006|4143699003|5023799004|56012099006|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WaaWua4wwr+99XJqDrz1OnHlo/5vhisrN8vcgqV5Oj54bnDCgn3co5XAraSOLWiFkTpq0REje+lq3aG8NLBPQkElKCRQIy3DZYCiebNEaEQrcWs6ZGbchW2/PT1EXsQ1VlBLTUSKg1XKNZ2xGtzHa+JHnThEFMH7u3Y+3NPRCjA/pFt/QHqibW06MIhXjQgTX8AJp0+s4iu/XmHuTmKTPgz317s28dH4zK1dlz+Ge10DB93ZabSX7zrpV1/1VgPNPMQq11D9C/+SPv0bpf3Lo6AzNX6Qa5h4mi5OFBaceLu2LNnupSnCEG2s3rer0TKUoORFRQ6HrQuRAzJYfxh6UeISLYQ8eglPVcaDe18cPxGxpdIGrOL7YLleKbvmDBbNpMABoEWs2K1zEVP6GSFVBDlzCD7T5CeurXgUJMTDXDfb3/eUGxGtMFPjoOZxlA4/LRZlurAL5px04u1/N6WFwvOsBCVnkI1sIiB+n46WvdKpu7BSVC2p3BIq3JlGrfU/5QSch3bh9fD61f9cjNqXRJn5YBIatJDvnWsRiJabTemJ7epDgujEkKFv8QHCE9OsLOmLlOCSe/YgG90Cl6BFtgqSbyPA6vDeRVm9i496lzqTtImugzdnMkpuh2ZKF1B/6Cei1EPjFWo/zFhFx2oCZmluYoxQoHk+x4iLCaMuJSZwiuGneEuOdUGinvc98u8DAQ/fNgjm6cCmVA1jLbVoVUfJ1fwZ46zsXDHKRIJtyLI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHJKN1RwMmhnWnJOOTAvejdNYTJoS0dyQzZhOU53KzR5clpFTCs2Sy9rWWtD?=
 =?utf-8?B?dFJTdDhpYVdFTHc5ZmRhMUQ4S3QyNlVlS1lnRFFDMW02MzhGalNieFpmN2hN?=
 =?utf-8?B?UHUrRy9KVkQyZWNzZ3dlZ0M2eWhLV0lBajdzNE1IUXJpNG05R2thaXl0NEMr?=
 =?utf-8?B?Snl6SVZKVDRFVGdmdmNBUkpITXdsYlpjMXFlNEQvNzM0TytKTjdkR2NqeEV3?=
 =?utf-8?B?SWd5c2VEY2pYdFB2SUVNZnBQamhIektNaGw3ZDdDelhKQ2hVTmdiandNUU5L?=
 =?utf-8?B?WjZKT0NKOVNCWTYrV0tPQUo3WWI5WGh0TWphcUJmUklTMGN1Tnh3Y2x5cCs2?=
 =?utf-8?B?NURjQ3l0TGNzdHp2K2J3ZlB2aXljUHFVOE9uK2dKQ2FYK1pycjVScU9qQjZ3?=
 =?utf-8?B?RU5sUzFVQUt2UVgrQWJSRjY4LytLRWpwMVhTLzRVVkRZUFhMaGFzUlQxeUhC?=
 =?utf-8?B?b0xZL0ZpMHBZN05vVUM1QWIwV2dYdE02T2ErMDlFcEI0UjI5L05qSmdZSlpa?=
 =?utf-8?B?Qk9NcmlKdmNqd3dNVXdNZW9Dck9obytqSzUvdzdqeDFpb3Jlb2pBTm1kRnph?=
 =?utf-8?B?SEJpaW9pTkd2a3BJamJoWE5EWEhPUmtsWER4eFhqcDROMkllN2xjRjlkRjFB?=
 =?utf-8?B?RHFKV1hhcVNhQWIvUUI4UUpYdDZVZ1M5Y2JNOENWcnE1WmV4dm1lb3QyUmNE?=
 =?utf-8?B?NUFqN3VXNDByN0V5UldhNTlDOUQ0R3c4ZDY1dXgvRWRjMFkxMGhyWmpuMk5x?=
 =?utf-8?B?T0kySU1wUVpCUkswQStIekkzZHBIT0JzRmxmV3pacDBzdzNpMVpJck1SMlkw?=
 =?utf-8?B?Q2them50S2NKdFJ0NlBkNCtMWDhxdkxLWmxKYXYzdFFZNXVqaHRXQmtJbEwv?=
 =?utf-8?B?SGErdU9qZnlwcVNJaHBDL2lCTlFCVVYxd0dNUCtuUEV6QmFWME4zRllBeTBM?=
 =?utf-8?B?NGhKTFhtVGhMZVJBT2tZdlI3dFBjUXJkbmg3aXVBQ0xZeHNoM2NWM0xERmxX?=
 =?utf-8?B?bVA1YjFZendYZ0kvbXFjMzlzQlNEVnhSL3orL3ZyOWxvNUZNSzV0SVhxQ3gy?=
 =?utf-8?B?cXE1OTh0TWltYS9WRXVJM3ptTE9IU1hTMFFnczFvWElrWHNZRWJXWGFCTUFr?=
 =?utf-8?B?WDRqWVNlcHM0TTF4YmU5c2tWbTJVSnQxSytUR2d1eHdCUEc2YmQ2UG1iWGtm?=
 =?utf-8?B?dXZLTUIyRUY4eDJJSkJqSmZiZ0tMT3MrekVpOFpjL29VTUphZzFIZ0VXWnRn?=
 =?utf-8?B?RDJtRjdHVlJjbEh2MWpqNmFrMk50bHNWQ295WkduQ3ZnRHhLWVBYSytuemhI?=
 =?utf-8?B?RHZ5MENmalNQRURQcVNUVm5MU3BmV2tnN09MWkhJRXRESHUwQUhEc0xsL3F1?=
 =?utf-8?B?S3R6VFhzeElzTng0aWxLZjk1QStVSWtxVnZISm5PVUI4WU9MUHgyN0RtSXZ5?=
 =?utf-8?B?QVdLUlVwZkROaHJ4T0FGQ0hBWGtoNEYwaVdoWHJnUHFJajFDcFRqTUcvaUFv?=
 =?utf-8?B?eS9UbTRhSGRLalVscjJYa3JZSzkrc0JJZnBrc3E0QmlLTHNLb3lGM25hS3Ry?=
 =?utf-8?B?UUJmNkQ0SGNtSWpNa29HZjlQRDE0NDhtK00zaytlVG1NTmw1ZG4rNm91amRs?=
 =?utf-8?B?SWNzVkFGUkFNbGduUDk1eVZOMFJ0N21MeUJ4L1RHa05WQzE1V1p4WG9uNW45?=
 =?utf-8?B?ZFFzVHhuOGFqMUIxd0FDRE5iRm1zcGJGZGJRSEFnK0hnUkEyd210Wk95VlhJ?=
 =?utf-8?B?a2lacmN3cUtwMTU3dFlxaFZYNUE1NWFJMWNNVWh4TkZ2MnlkeWpUS0l2Mk1z?=
 =?utf-8?B?Q2FTd2NUc2lNVndqakt6ZlNUTU9abGpCME8yUEFJQjYvOWFyNHRGMmpJemc2?=
 =?utf-8?B?RlF4am12aDhxOUF1engxZjBPa2VkTFF6QkFWTzN2TlRNOG1YdndtV2xmUnIr?=
 =?utf-8?B?QTRFZnNOWERzNkFRcWc2T2ZVQkRxZVNkWEhBeW1hejlhZk5yWGhjcVd0T2hK?=
 =?utf-8?B?eDV1RlRhUmg2R29KMm16QmxuM2M4RnVHOTIrSzRESEU0cERIUTg3YVkvR2Rw?=
 =?utf-8?B?N1NFQWV1elhLWXdMOHd1WFBpS3BHblRJSnpjZi9DTU5uQmliQmRzZEwyaXJU?=
 =?utf-8?B?dFZvRGpwVFZjNlNkWlhKUlF1V2ZMeUQ0aHY3Tk1VMnRhOGNqNlN3UDdad0ZS?=
 =?utf-8?B?VTlUSHgwWmF1VkQyRmNBSURyYlVOVXBkdi9UaUFiYitjWmY5YWIxd0I1Nkll?=
 =?utf-8?B?VmV4M0RjTmhOeHVBekpyckNCOUoyM1VKdnJGeXRud0IreGRDQXFGVlg2QW9D?=
 =?utf-8?B?MmFCMms1Nk1obGkyb0VVUU5pc2JGdHFwRTNEQ2gwUUdWYWZlSmhiRnl2OFVI?=
 =?utf-8?Q?0rHCmAGYIVVJ/uOnh0iZ+xUmo0vcnZYYsMzhB87WYrhbk?=
x-ms-exchange-antispam-messagedata-1: u2XMxMCBWEGapv6ATmJJL+aU2ia3Guzm5RM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DCC3AB7886224418347704658784254@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qYG+bKpypx9eY/zcBIH26T7U+FXvZF9UKrfucnQ86Wr5MMJOzi3yL2jCXLkgP9gh4kqXAbz/L54CgbBCrQwnzlFLCmAU9x23Knffy+9UCP7OerkDLSZaSToPLdjoyObWidzZWtPQY6LlX6Rh+A8nXKmoPMCuvOl7Uk0gdUFtrbLCCKCEsAfnQ7Xd05e6O5BD35ZeCInJ/Hhj6XM+urkmF/y6hMb41gbQRWt3BBbPbvA7DfVWFnLThASV2zAkEs1j+5be5QqVGJcNptWR9+ZFvIGUxIP0TOkxI3/P3Vrm7dc+okUIZX9H0eG7w65xHp+nRPjXUYLSPDSXin6M/wyOCQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +QvLNXNI5wRT7pZSL7o/KcjsJD0exF73eJDPOnSelHhsZk2IyrPqPAZ5kqeMlq2ePEEgbz+LcUYpUsQkOgh/7entUJaPRL5tr3e8ljU9vorSQ6WTiM9AuczIJ2KmyfUxDx0YOP4vU47/qgmgtgrEGmfnfwobYNhSQv9JGUcgU9qRALiMB/g4H9jWpgE1l1MCeYVcnlzdmw8tLCUQ2leH6YNZhfQ1Lm/j50mrUZ/oIzsrlLR3w1bdDg9bmGRz3XDt3vsHwkMdAxyyymi/G0UM1L9kK7IlMmfsi3VBswHA6PxFKiJcggGQr+Ls2zYNQLrqfIh0eZ80ycCxy4+RTtISkCJnVqV9IVGFhhlv4xRYDJC6YHT/Z70keMnGjP9mmc+hIZHlAauWyAXoYLBBX+NTVeZNBUx1m//e/9can1tNxsEw0UeGPI6j6HzbHl0LPqZn/qN8g4vR4agQyKMYMeDPoo5IFMFtR9DfRj6z4P2Uv6caTFXF0FOEYoeYfhiRx/x85/CzmTdpOlOwVQepwGnD8uDCclx4jJn6/ZSCs3lFd+HsIkdPj5ofWpq/DVUM3mDxeN1QvLgsH1CWtLX6lRZ0XLy9pNFrFHZldk8zj3LbZw/Jj0TYpX9HS/QUbdnANdHk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d0345-ba51-4e52-8d11-08df2d7d9333
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 01:09:07.3482 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTpKfe8UYKf0rBi0MHtx2pWmyV0xQq3yMohYr70rDRgbTS/UlDQOGRX3G3772vzxI3AK4GUNB69CiRQW9yEnB/IZyvLSd+6B+EC8idcKiG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8741
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDEwOjAzICswMzAwLCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6
DQo+IE9uIDA4LjEwLjIwMjYgMDY6NTEsIFplcGh5ciBMaSB3cm90ZToNCj4gPiBTaW5jZSBjb21t
aXQgY2ZjOTZkZjY1ZTAxLCByaXNjdl9wbXVfY3RyX2dldF9maXhlZF9jb3VudGVyc192YWwoKQ0K
PiA+IHJldHVybnMgdGhlIGNvbXBsZXRlIDY0LWJpdCBmaXhlZC1jb3VudGVyIHZhbHVlLiBUaGUg
UlYzMiBjb3VudGVyDQo+ID4gYWNjZXNzIHBhdGhzLCBob3dldmVyLCBzdGlsbCBwZXJmb3JtIHBh
cnRzIG9mIHRoZSBvZmZzZXQNCj4gPiBjYWxjdWxhdGlvbg0KPiA+IG9uIHNlcGFyYXRlbHkgZXh0
cmFjdGVkIDMyLWJpdCBoYWx2ZXMuDQo+ID4gDQo+ID4gSW4gcGFydGljdWxhciwgcmlzY3ZfcG11
X3dyaXRlX2N0cmgoKSBkZXBvc2l0cyB0aGUgbG93IDMyIGJpdHMgb2YNCj4gPiB0aGUNCj4gPiBj
b21wbGV0ZSBmaXhlZC1jb3VudGVyIHZhbHVlIGludG8gdGhlIGhpZ2ggaGFsZiBvZg0KPiA+IG1o
cG1jb3VudGVyX3ByZXYuDQo+ID4gcmlzY3ZfcG11X3JlYWRfY3RyKCkgYWxzbyBzdWJ0cmFjdHMg
YSAzMi1iaXQgaGFsZiBvZiB0aGUgcHJldmlvdXMNCj4gPiB2YWx1ZQ0KPiA+IGZyb20gdGhlIGNv
bXBsZXRlIDY0LWJpdCBmaXhlZC1jb3VudGVyIHZhbHVlLiBDb25zZXF1ZW50bHksIHdyaXRlcw0K
PiA+IHRvDQo+ID4gbWN5Y2xlaCBjYW4gYmUgbG9zdCBhbmQgY2FycmllcyBiZXR3ZWVuIHRoZSBs
b3cgYW5kIGhpZ2ggaGFsdmVzIGFyZQ0KPiA+IG5vdA0KPiA+IGhhbmRsZWQgY29ycmVjdGx5Lg0K
PiA+IA0KPiA+IEtlZXAgdGhlIGZpeGVkLWNvdW50ZXIgb2Zmc2V0IGNhbGN1bGF0aW9uIGVudGly
ZWx5IGluIDY0IGJpdHMuDQo+ID4gQmVmb3JlDQo+ID4gYSBydW5uaW5nIGNvdW50ZXIgaXMgcGFy
dGlhbGx5IHdyaXR0ZW4sIG1hdGVyaWFsaXplIGl0cyBjdXJyZW50DQo+ID4gYXJjaGl0ZWN0dXJh
bCB2YWx1ZSBhbmQgcmVzZXQgdGhlIGZpeGVkLWNvdW50ZXIgYmFzZWxpbmUuIE9uIHJlYWRzLA0K
PiA+IGNhbGN1bGF0ZSB0aGUgY29tcGxldGUgNjQtYml0IGNvdW50ZXIgdmFsdWUgYmVmb3JlIGV4
dHJhY3RpbmcgdGhlDQo+ID4gaGFsZg0KPiA+IHJlcXVlc3RlZCBieSBSVjMyLg0KPiA+IA0KPiA+
IFJlZ2lzdGVyIFJWMzIgc3lzdGVtIFRDRyB0ZXN0cyB3aXRoIHRoZSBNZXNvbiBidWlsZC4gQWRk
IGEgdGVzdCBmb3INCj4gPiBoaWdoLWhhbGYgd3JpdGVzLCBsb3ctdG8taGlnaCBjYXJyeSwgYW5k
IHByZXNlcnZpbmcgdGhlIGNhcnJpZWQNCj4gPiBoaWdoDQo+ID4gaGFsZiBhY3Jvc3MgYSBzdWJz
ZXF1ZW50IGxvdy1oYWxmIHdyaXRlLg0KPiA+IA0KPiA+IEZpeGVzOiBjZmM5NmRmNjVlMDEgKCJ0
YXJnZXQvcmlzY3Y6IFJlbW92ZSB1cHBlcl9oYWxmIGZyb20NCj4gPiByaXNjdl9wbXVfY3RyX2dl
dF9maXhlZF9jb3VudGVyc192YWwiKQ0KPiA+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20v
cWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzQyMTkNCj4gPiBTaWduZWQtb2ZmLWJ5OiBa
ZXBoeXIgTGkgPGZyaXRjaGxleWJvaHJlckBnbWFpbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IERh
bmllbCBIZW5yaXF1ZSBCYXJib3phDQo+ID4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IENoYW8gTGl1IDxjaGFvLmxpdUBwcm9jZXNzbWlzc2lvbi5j
b20+DQo+IA0KPiBGV0lXLCBJJ20gX25vdF8gcGlja2luZyB0aGlzIG9uZSB1cCBmb3IgdGhlIHN0
YWJsZSBzZXJpZXMuDQo+IEl0IGlzIG9ubHkgYXBwbGljYWJsZSBmb3IgMTEuMS54IGJyYW5jaCAo
bm90IHRvIDEwLjAueCBMVFMgYnJhbmNoKSwNCj4gYnV0IGR1ZSB0byB0aGUgdGVzdHMgYW5kIGNo
YW5nZXMgaW4gdGhlcmUgYWZ0ZXIgMTEuMSB3ZXJlIHJlbGVhc2VkLA0KPiBpdCBiZWNvbWVzIGEg
Yml0IG1vcmUgZGlmZmljdWx0IHRoYW4gSSdkIGxpa2UuwqAgQmVzaWRlcywgUlYzMiBpcw0KPiBz
aWduaWZpY2FudGx5IGxlc3MgY29tbW9uIHRoYW4gUlY2NCAtIGluIHBhcnRpY3VsYXIsIGRlYmlh
biBkb2VzIG5vdA0KPiBzaGlwIHRoZSByaXNjdjMyIGNyb3NzLWNvbXBpbGVycyB3aGljaCB3ZXJl
IHVzZWQgaW4gdGhlIG5ld2x5IGFkZGVkDQo+IHRlc3RzLCAtIHNvIEkgY2FuJ3QgZXZlbiB2ZXJp
ZnkgaXQgZWFzaWx5Lg0KPiANCj4gSG9wZWZ1bGx5IGl0J3Mgb2theSA6KQ0KDQpGaW5lIHdpdGgg
bWUNCg0KQWxpc3RhaXINCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gL21qdA0K

