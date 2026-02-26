Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E742FD9E1E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvl4O-000525-2i; Thu, 26 Feb 2026 18:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=510b84ec3=Alistair.Francis@wdc.com>)
 id 1vvl4M-00051S-Gm; Thu, 26 Feb 2026 18:46:58 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=510b84ec3=Alistair.Francis@wdc.com>)
 id 1vvl4J-0001Iq-44; Thu, 26 Feb 2026 18:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1772149615; x=1803685615;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nZdDqWUashLH9zVZmgxDgPnic44GyTqTGeNA/OEEPyg=;
 b=h6WhOQYpnxuOrHsN5aypOZkP3eXbZ6/GmUavVpdoOqPvhSGK4rTHEQat
 +HTphUwRGbHhkzg7vQMlLVHMXWquTKKq2a08biX7pI1Nm1D3T7W9G5/Y0
 DAIAPY9hQyIWJ0b8yFbSDt1EpIDTZxOb7B/HQBBCJa3GM0icxCU5XIoSg
 3adhraAIDIKKH05GHPcvqu+TRXePo96fTS4RUSD2ADa47irdOIWZihgb2
 +GIKJgzkIcVQQGmWPetzDRMWiilxd4LRANT6632ZDprXnzbfB1xfGlZZQ
 QdJQS+c+HY2KtSLdTj+g/NCrrmTmrEPXeBNRjPRBN2T2yuhie5wtMjMzR w==;
X-CSE-ConnectionGUID: ma0JEafBQLyrO26Wk2RP4Q==
X-CSE-MsgGUID: HlYnqeneQzG9hYQhLyfr+g==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; d="scan'208";a="141553522"
Received: from mail-southcentralusazon11011043.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.43])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2026 07:46:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQShsgkZSsjSqZlP0erzM/lUzHDlMP+4684kTkjMz5t1N7PXDKLL4WbvUh4Tmg9+YM9GYG8zVtZ9AVjjQ2ntVJ7tUktwfBjIzfvNcKmlXK8TfVRt7OwAiezZ0IPjDySMMxBKswNGHDpEUWNp8NISNgSLQZpmR+RJlP7BqW44Y2S9Dvu9PWw7ovsll3p8sRi6BkAlvQ33D5kSJaKxF37rwxEpl6tQhKfx5cyfxBkpKo8KMJy6xV9O6tDHtTruh4oeX2qU4zjCPy98CSMHQ/o3vLNZM9UvV6RA/INVMe522XVIbNRR6kdFhtXHfSuc2TPSVqhFE3UubcUMG0o43DGPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZdDqWUashLH9zVZmgxDgPnic44GyTqTGeNA/OEEPyg=;
 b=Ma2EsTjTC1UfKtoHw5vTUfmpdPG8LN4yi5uRx3N8eq/OADstecCsz661dJR3/vNko2BCHk5do/ct3xisV3ENtWbqT9fuKjQsmp/5Mp06GrEpygy8VK8v3zrJQj3ssCi+O/QNwId8TLZRO9RSHOMecXXemAyYg9K9oiA3+GYLuqF1X5Rj3pBBIzFZTeQZkbkfvoNTnDpdPR6GvfXqrQ+xSIqR1UaCtpHEUi3+wrGoEQvfrZijZPTAvvXp24XQVSaumbGgg4Hz1i5soYF6xpc2gEKtv3pxaPrXdHN9oPDo+9P2BVOqflPlaJk4LmVXIhTYFQTqG+humDpO9duniCOwYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZdDqWUashLH9zVZmgxDgPnic44GyTqTGeNA/OEEPyg=;
 b=esOo12V4XiXkLkwlxafhzhyfeLbeb2qrEX5s8FPTzXy28bzatMiF3m+BYLGsRNoLyb8cYnTTYnZFmP4qxU9LY1cJeS5To6q/PjbGCkr3LSKWwuCAvSyixwfrkuOKLPZxwpTwwtQw2mBGsk0FyfDB2mTlRQu9cFI57MoK0l0sguk=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by BY5PR04MB6724.namprd04.prod.outlook.com (2603:10b6:a03:219::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 23:46:48 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 23:46:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lex.bailey@lowrisc.org" <lex.bailey@lowrisc.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "amitkh@google.com" <amitkh@google.com>, "qemu-maintainers@lowrisc.org"
 <qemu-maintainers@lowrisc.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dave@treblig.org"
 <dave@treblig.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH qemu 01/11] [ot] target/riscv: rename ibex hart as
 lowrisc-ibex
Thread-Topic: [PATCH qemu 01/11] [ot] target/riscv: rename ibex hart as
 lowrisc-ibex
Thread-Index: AQHconoV90+eD4uu4UyXuwzEwRB1H7WVr2KA
Date: Thu, 26 Feb 2026 23:46:48 +0000
Message-ID: <6d25e69b1cc7fe52b2097e4b6246b2be90fcfc2c.camel@wdc.com>
References: <177159976712.8279.7732381632410882915-1@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-1@git.sr.ht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|BY5PR04MB6724:EE_
x-ms-office365-filtering-correlation-id: 98ad3a44-7ec0-4b8b-3221-08de75914e9a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: kItuCBMpkyMAUgpxIPrU8dKIuKTF3wJa4rgW8TLrKduqoxea+oioR+q6wcSWyPPcerAeEjFHqVR1kU96hJigVF6Op26EZaZSAB71y8y9o+xnhyGGPHFNj6e6LfdpuNIAOoiHaMwnLFGk4VDkUKypPmH0pNrPMp/LNwqJHWgfJNSZU+nGcQ1FyMxP0qnGiDlsyeSJ8iD5BOcyDIqNa696B5Sv9sW/QOgSP0mooyPpexqeGCvjGesadvFF4BP4vDakk0f50CQc3va3TV+XiLXLb26v7R+DPqrWpE/IjooxkZc0YiMY66SRK8zBRhS3GKlPJSjM/OrPqRh7pnFWZXP46xiaAf8t4XDpUkm93BNrWERcfhATS4415Nti4n8tcWOFagxQqX2V1iIuPSJrJbR6HqxJL84Us1C3ipTPvE1+WiLkrOXXhq/WSvOuATqvVn6vlHUJBqv1aW7vTf20DfkB/q/FtR31ZgsRWmOQPwyv6a4GTkMZiVLPKSmGTvc0ixjts4xIlblti5pYjvZphM72HnBJTpGPu9ozCYqZfTA8lmenWQdKhzvzCNbavB5PQGSTlMNxaoR1Fws/VbkpXLVfLJ7Yw6iyR6yig0DbkWMXUNMN5zSlTeRUMwmR8OX9i6W4ryISHkk73B3QwBPR8sRPmV3s8qMVO0OsbWtdHmBSElS16tBWhFDgUS/+J5fxTNZtb7E+98CFE+blqiTUU9d2Dvy7xiAPiwerPA6oMrg8va14TfAJZYRthdHl9UPHLbax12ckiWeC/8fcXK4P/AIgihLZU+ghXhfzFTmz8MxqF5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB9849.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(19092799006)(10070799003)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU5oOEVvMjJTSlRNNDJ2N3BqbTRsVUVRZkd1SFB3b3orVGlQKzhwZkZmREJu?=
 =?utf-8?B?K1FvOWhuc3VxZHhJUU91NEY0YUNVUUdOc0pXTlVBUXJXTDhxWVlsTkV4a2M5?=
 =?utf-8?B?MFhzRkZNaTN6VDJYd2RRa2R4UFBzUkp3UExLR2hpWUZSUW1KQWoyVVlWeGFr?=
 =?utf-8?B?OUpodkd5enZ5RVNRNnFlZ20xNWw1US9vclZ3OFhScjN0dFdSWmF6R3BFMWZh?=
 =?utf-8?B?a214c281ZHZ2YVJvQmhsNWdTdDQ0M0xucDFWN1ZZZGtLMnpkQVNZMzVRdkdY?=
 =?utf-8?B?b0toc0wrUXNCQ2RtWFVSa0ljelppMUtnd2wwanZzVXNBMWc2NE9ER2pOUC9V?=
 =?utf-8?B?bW5PeEs0b0VMNDJYSHJFRW9rYmZoTlJKWVdKclZMR0R5YmgxR3p4ZjE1enNV?=
 =?utf-8?B?WENUSXh5WisrbkhuUnN3SE1PNW5GV1MwcnluQjZuTkhZM2xwVFdnKzhjOFBZ?=
 =?utf-8?B?cklqMkFEZHNIVm42L0tMa25EelArdk8ycHQyREVHL2tQWW03NU4zSDloeHRW?=
 =?utf-8?B?emFtVWNNVmZjU2d4bXZuWkF6Z0JzbExBM2c5bVN5UloxT1dReEFXL0I0aWhh?=
 =?utf-8?B?Unpqb2owVkJjUCtheU93MGgzZzk1ZGJFZytGY3pMU0hMR2cvdHByczdDNGt4?=
 =?utf-8?B?S2l4L0l0RkJaZzl3N21GV2RhUXRpek53dWJ6SUphNEpxdmJPaFdnTWRzK3JU?=
 =?utf-8?B?b2xnb1BuSUtxb3A0MTM0cHorTzhPT3VZdnJsclU1cVg4K3lvZHZ2OFFxbldQ?=
 =?utf-8?B?THNCZ0lySUNpd3FqYjVLSnZkdmw1NlBnOW95THR6TXdKeGxiK0hQNVVQRGlw?=
 =?utf-8?B?dW5MRzd5WkFWK2x6ZlFwWUYvZmdKbS9laVIxWVVBSThxYUd3bjF2cWZhcGRo?=
 =?utf-8?B?RXB1OFl1MTFIUXFGVmE0WGFPeWZzNWVDb0Q4a3BSekJEQ204UFlWeU1OUWFr?=
 =?utf-8?B?YTRDQ215Y0ZSR243cXQ2K1ZwUFFDS2xoNkNZTlBQUWFrbi9Wc1VjaEh2eTU1?=
 =?utf-8?B?T2NINyswbEJUdEM3alFDU3BsYm5FVHVMNENmNVdTUVdKZGRlVVpHZnFUUElD?=
 =?utf-8?B?aEZtOWJsMCtvTVNGWjBIYWV6UytoekxYNVBPamZJbkwwR0s2b0lMdzRRNzNw?=
 =?utf-8?B?L0FrR2dveStCNDl5U2lOS3g1QkRKeTRKQStRUEJoTjQ5ODVOYkxaRTYrNTRt?=
 =?utf-8?B?TnJFS2E3V2tpSmFobEZJZjZZRndyV1VyK1hXMC9nbi9nNG9QSG5IdDVKQ2gr?=
 =?utf-8?B?OG9Ya0J6WkZSTDZnRGw5L0U4WmpueEtwTmxxMXVlUXEwWUpvL1k0MFRpT0o2?=
 =?utf-8?B?ZForVGlLWElNVWdES2k4ODZPS3Mrai8rTVQ4SkVXLzFFaVdRMXUyUGhvRjhn?=
 =?utf-8?B?K2JnTTFmekRhelNHU25kNVVyaFVWZ1pjVlA2ckYvU1FLWkNnOFZHdlJqMjlU?=
 =?utf-8?B?TDNNdnhkajh1SWJuc3c3UlluOG5BOXM4bVlEUlVaZ01HbDNmWWR5NEREbkxV?=
 =?utf-8?B?SWlWc1RmWkZyeXk2REdhdUI3ci9KeXMzWjdzL2h4ZUdTM25id3NCOFhJVG1H?=
 =?utf-8?B?OERKdkpsVitqWWZUdFRTM3lxQWlqZkV4ODdzL3pIbEtnZG11RzZWM1ZRWnJ5?=
 =?utf-8?B?a3NQY0xDZWM4NXo5S3lxc2FBT0FQYUs4TXZIN2gxb3VrMUMwaUdxRkdSeE1p?=
 =?utf-8?B?cUZiOVRMMlVKVzl3SmtjMlZ4Sy9PdksvTThwWEpEYkVhVUJGY2YxVVVrSjMr?=
 =?utf-8?B?RFZkSjJPZis5Y1pXSHp5U05TK2c2WDZzd1BTUHlwMWxpNCtyYjk0bi9CUjJG?=
 =?utf-8?B?akpsSUpKclZkRGREOVpLWjQvdmpNMkdUZGFOZTZsenFiREpXRHpwTkhWei9m?=
 =?utf-8?B?d2JSeUhaZkd2c2tQaWZaN3YvRVVFZlA1RnF3bHJiam5FeXhXelRaWXRTcXlw?=
 =?utf-8?B?Q1B6Z2lvUkh6YjZCckxmdTM0RlQzSUNkNkZiWTA4NVlmVzZTdjc0TnZyOVNV?=
 =?utf-8?B?RTNkTXByUjYwbVZUcFQyZE4zelUzaUFwY2VJaDgzYUwxejQvN3JRZ0hKN0o1?=
 =?utf-8?B?T0oybCttQWhScCtpV1pEN1hHK1BzdlluV2JST2dUa2tXV3V0K2Njdko5M0dZ?=
 =?utf-8?B?UkM1VHA2ZUZrRXlId3ZObVRRb0ZYbjZ5SW1XZEVLTHdWeUZuS1Rvd0ZHVlFG?=
 =?utf-8?B?S1I0V29CWHdpa3dySUZWcTF2aUh3a1VBUVhiMWJxVk00V3NEL3dYVXZscE15?=
 =?utf-8?B?Tm9oSjhnTUEzSCtYbFJoRDhqLzNIMm5lL2QzcWdUc0JkQk13UUg1b0sxUUdm?=
 =?utf-8?B?V2doSllhZjZ1UW5LcHBMWHNLSVQzRFN5Q2J0SFFaemlHYTRWcGY1Y2RoSjlk?=
 =?utf-8?Q?/pL1HQOzuGY8LrhcyyBxy86LaILCvk9GXssXsH0z5Q3cB?=
x-ms-exchange-antispam-messagedata-1: P7UYXR/AjhM327kLtzjEVuZL+saYANOPWhM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8113FC0E17F9114490A2697FBFBCF0D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /9UULb0QWWJEPqMSMwWpacURQ4NfvQZhnbxJrMV2bjBNe63RCcznHtaF2hEMIxt0EhzyULJPpLbdfF+q87YOKRwdHMWJSRflzkeWlHsbZG4UGwxK7/i58bH3brsPNjO3tJ4gy5jAM8TvjVIdOH2XYtwjv5q61I98R/3FbIFjjnl18vtB1nouXUfjHon8sy7ETvPnt4MhGyNKdaHI9tqDNSak20dmRFkq7iI1fjrjibdHluEgWJwt4/WXCXBvrTNbSiGbmR0OnNqBuwDw8extNNVQ6jaG8QiYVFcefE2yHjqhm2Ll227y1OX9lMs5ed9unMIxLHI/ceygUceo4PN6JrzOpfAMqW6EmueXkOnkDV0N9+S6u/g3FEJW5R6JtjXIg2TkqAO5eh8+3s4Z9q720eKZZjK+8PqN18gS+v4aElX6HTG7oO4lBjZfILgxN7MyPg8D1hhNL1iGDx8hW9Y6tnD3y7MbD+PKIHrVxBpAHjwPFQZ7AGLLtROG2BBVF15A8YR0/tWEf50RcGauAuK4SM53llKVcfuhzb2YLW5iodQjs0MqrR2YkkIRYlCKfHhK9TS/Qt378c9y1xdpbNoSrDXUPtJc64GNDGIt5sqeAkJiKbcyrhkFZHO2AVfCVGYB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ad3a44-7ec0-4b8b-3221-08de75914e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:46:48.2249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nLVTdW0mv/M9521Em0QBU1USODmCQZpwrfM00GZje0AWonm8Kxzw3+/N5cWTyw55lx2TidYsWhWH6ho3lnAb/Gh16fGc1UDee9ILSE5O6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6724
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=510b84ec3=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDIzLTA0LTI3IGF0IDE5OjM5ICswMjAwLCB+bGV4YmFpbGV5bG93cmlzYyB3cm90
ZToNCj4gRnJvbTogRW1tYW51ZWwgQmxvdCA8ZWJsb3RAcml2b3NpbmMuY29tPg0KPiANCj4gRm9s
bG93IHZlbmRvci1kZXZpY2Ugc3ludGF4IHVzZWQgd2l0aCBvdGhlciBSSVNDViBjb3Jlcw0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRW1tYW51ZWwgQmxvdCA8ZWJsb3RAcml2b3NpbmMuY29tPg0KDQpS
ZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0K
DQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L29wZW50aXRhbi5jwqDCoCB8IDIgKy0N
Cj4gwqB0YXJnZXQvcmlzY3YvY3B1LXFvbS5oIHwgMiArLQ0KPiDCoHRhcmdldC9yaXNjdi9jcHUu
Y8KgwqDCoMKgIHwgMiArLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L29wZW50aXRhbi5jIGIv
aHcvcmlzY3Yvb3BlbnRpdGFuLmMNCj4gaW5kZXggMzA5MTI1ZTg1NC4uMTljYjM1YjM1MSAxMDA2
NDQNCj4gLS0tIGEvaHcvcmlzY3Yvb3BlbnRpdGFuLmMNCj4gKysrIGIvaHcvcmlzY3Yvb3BlbnRp
dGFuLmMNCj4gQEAgLTExOSw3ICsxMTksNyBAQCBzdGF0aWMgdm9pZA0KPiBvcGVudGl0YW5fbWFj
aGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gwqDC
oMKgwqAgbWMtPmRlc2MgPSAiUklTQy1WIEJvYXJkIGNvbXBhdGlibGUgd2l0aCBPcGVuVGl0YW4i
Ow0KPiDCoMKgwqDCoCBtYy0+aW5pdCA9IG9wZW50aXRhbl9tYWNoaW5lX2luaXQ7DQo+IMKgwqDC
oMKgIG1jLT5tYXhfY3B1cyA9IDE7DQo+IC3CoMKgwqAgbWMtPmRlZmF1bHRfY3B1X3R5cGUgPSBU
WVBFX1JJU0NWX0NQVV9JQkVYOw0KPiArwqDCoMKgIG1jLT5kZWZhdWx0X2NwdV90eXBlID0gVFlQ
RV9SSVNDVl9DUFVfTE9XUklTQ19JQkVYOw0KPiDCoMKgwqDCoCBtYy0+ZGVmYXVsdF9yYW1faWQg
PSAicmlzY3YubG93cmlzYy5pYmV4LnJhbSI7DQo+IMKgwqDCoMKgIG1jLT5kZWZhdWx0X3JhbV9z
aXplID0gaWJleF9tZW1tYXBbSUJFWF9ERVZfUkFNXS5zaXplOw0KPiDCoH0NCj4gZGlmZiAtLWdp
dCBhL3RhcmdldC9yaXNjdi9jcHUtcW9tLmggYi90YXJnZXQvcmlzY3YvY3B1LXFvbS5oDQo+IGlu
ZGV4IDMwZGNkY2ZhYWUuLjNhNjM5NGZkMTEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9j
cHUtcW9tLmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS1xb20uaA0KPiBAQCAtNDIsNyArNDIs
NyBAQA0KPiDCoCNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfUlZBMjJTNjTCoMKgwqDCoMKgwqDCoMKg
DQo+IFJJU0NWX0NQVV9UWVBFX05BTUUoInJ2YTIyczY0IikNCj4gwqAjZGVmaW5lIFRZUEVfUklT
Q1ZfQ1BVX1JWQTIzVTY0wqDCoMKgwqDCoMKgwqDCoA0KPiBSSVNDVl9DUFVfVFlQRV9OQU1FKCJy
dmEyM3U2NCIpDQo+IMKgI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9SVkEyM1M2NMKgwqDCoMKgwqDC
oMKgwqANCj4gUklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnZhMjNzNjQiKQ0KPiAtI2RlZmluZSBUWVBF
X1JJU0NWX0NQVV9JQkVYwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+IFJJU0NWX0NQVV9UWVBF
X05BTUUoImxvd3Jpc2MtaWJleCIpDQo+ICsjZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX0xPV1JJU0Nf
SUJFWMKgwqDCoMKgDQo+IFJJU0NWX0NQVV9UWVBFX05BTUUoImxvd3Jpc2MtaWJleCIpDQo+IMKg
I2RlZmluZSBUWVBFX1JJU0NWX0NQVV9TSEFLVElfQ8KgwqDCoMKgwqDCoMKgwqAgUklTQ1ZfQ1BV
X1RZUEVfTkFNRSgic2hha3RpLQ0KPiBjIikNCj4gwqAjZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX1NJ
RklWRV9FwqDCoMKgwqDCoMKgwqDCoCBSSVNDVl9DUFVfVFlQRV9OQU1FKCJzaWZpdmUtDQo+IGUi
KQ0KPiDCoCNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfU0lGSVZFX0UzMcKgwqDCoMKgwqDCoCBSSVND
Vl9DUFVfVFlQRV9OQU1FKCJzaWZpdmUtDQo+IGUzMSIpDQo+IGRpZmYgLS1naXQgYS90YXJnZXQv
cmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gaW5kZXggZTU2NDcwYTM3NC4uMjRh
NGMyZmQzZiAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+ICsrKyBiL3Rhcmdl
dC9yaXNjdi9jcHUuYw0KPiBAQCAtMzA0Myw3ICszMDQzLDcgQEAgc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIHJpc2N2X2NwdV90eXBlX2luZm9zW10gPQ0KPiB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgLm1p
c2FfbXhsX21heCA9IE1YTF9SVjMyLA0KPiDCoMKgwqDCoCApLA0KPiDCoA0KPiAtwqDCoMKgIERF
RklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVfSUJFWCwgVFlQRV9SSVNDVl9WRU5ET1JfQ1BV
LA0KPiArwqDCoMKgIERFRklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVfTE9XUklTQ19JQkVY
LA0KPiBUWVBFX1JJU0NWX1ZFTkRPUl9DUFUsDQo+IMKgwqDCoMKgwqDCoMKgwqAgLm1pc2FfbXhs
X21heCA9IE1YTF9SVjMyLA0KPiDCoMKgwqDCoMKgwqDCoMKgIC5taXNhX2V4dCA9IFJWSSB8IFJW
TSB8IFJWQyB8IFJWVSwNCj4gwqDCoMKgwqDCoMKgwqDCoCAucHJpdl9zcGVjID0gUFJJVl9WRVJT
SU9OXzFfMTJfMCwNCg==

