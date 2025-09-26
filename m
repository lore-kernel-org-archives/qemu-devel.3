Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AB7CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yS9-0000tl-8F; Thu, 25 Sep 2025 22:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1yS5-0000tb-QF
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:44:53 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1yRv-0008BD-R2
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1758854684; x=1790390684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L/wvCPuPaX3LvxG4xM8rNNby18v8ThXhOnyR8gzhe7o=;
 b=jn3AaqhfL2ttgvo4plCzkp14sbPryePZz8RowKbYimHM0c1y4uC9AhpH
 oH8/jUX8TADvmwJ4u08O3e8lMHs5nqfBTkko79Pj5C2yJwsQ6rSn07mQO
 KfIoRHsVEAUiZrKHSlfAnKCEG+8eL9tH4eFWOd2KcacMxf1CdkyTUIwxU
 4z38mqt/BYK6w63B/phla1fqzBvAETgOLDEWI96nhDq/HoDjPM2T5kv2K
 soWEiko+JuVQqi0f5sJrQqVkDmmCibSPqgdGD6cNkrUnwOZc7OSiP/O7Z
 L8iVBG4u3gD2N/U0QA5HzT8YdAvAwcfi2+ldAJErW0/jb7P9U+ym9CZqQ A==;
X-CSE-ConnectionGUID: w+aYFsvTTnqpIURKy1HB2A==
X-CSE-MsgGUID: iSbiTAqTTUmiZqXt+AAwWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="168913906"
X-IronPort-AV: E=Sophos;i="6.18,293,1751209200"; d="scan'208";a="168913906"
Received: from mail-japanwestazon11010023.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.23])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 11:44:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbXGV9xPoFI8d2NXYrhOK9CE5gIAyDhLtTBcCHKfAbBH2SVWSaMMhLzO22cEv61FNwyYdTg8K8mC1jGKZj6FTbWPiJ1622ftdKKyhfUT+qCzC/GNqY6ubxIsWP6HJUE1JrJwQLiGbulQf2JNv6LWSmxMEVZ/U1lpbL4s3qYpJWv9wTLcPqBT5Q4gzKn7E7G25PLc+ItX5BQ+PH9sS93H8Zn8g8bmDBzohB98K9QdX28FszNaMa58nO/74WEu25RGOiLk2KCSgX7PGKV51C97HRqWwOQNIpH5Ats0UbfeAYsFdzlVGLUIxen2USX8j8wvFTFRzA9ou1zMbSldVxdbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/wvCPuPaX3LvxG4xM8rNNby18v8ThXhOnyR8gzhe7o=;
 b=Fiyr3tbZ7VZxYWWzLL6DJL9NW40gnPMwMjk+laa87lZeMbGIvUylM0eIZZPSMTgRRWItiGrPyonGcpw8lHwUusgC+7T9YRqaRbAL5ldQczGAFxeEBPPvBReMxhdg/qHTkkesEK3r9pr4tRRivI7rCouvSrN8czPH3KTg36kamrQsesMLlTbN4l39kMD29kBIG5UhgzHebqTJFARjRPQUSyTLCKKz0vxrGeExdRruXlL5sjYUB2XyXzMEj/m4LPiYmahEU8g+eroQE11lwS2dT3BDKoCo32Ylz5dah6zQ0a7KCEyXC0br7HTRjvmPf/WD34a4es2zKPR980KJx1fVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/wvCPuPaX3LvxG4xM8rNNby18v8ThXhOnyR8gzhe7o=;
 b=Op3k3lO4T1xzTVGMxvsV1olvxx15/sbxk3Pl2xThJDr74MkpCuzDVgPYZ2dnxRnfdmt81gs9HnEPDHi7ACLVfv3WhzNF2/QCnxpgGmP0/4juMMaJnw35TcJ5bxdd2TxD1t+VrVIhxjWMcTIe/R3bu1D5avgLAdA3en+OGEyfpKERE8enW18MMBhLuV/YlWzq8C9thUGGT/cCLItMd6rzJ5r9hgnVCnVcPNLaEQxe/ieatDrb5OXUt79LnFENgn23+iOb0OLIrFv8DI+wAbM/7us80gjXDeyDNmL0aeiRWIUnYPUZBC2vQXYhbNLvcRKJRFWJj4q2/yAK7wdfpactaQ==
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by OS7PR01MB14893.jpnprd01.prod.outlook.com (2603:1096:604:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 02:44:19 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 02:44:19 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>, Yury Kotov
 <yury-kotov@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 6/9] migration/rdma: Remove coroutine path in
 qemu_rdma_wait_comp_channel
Thread-Topic: [PATCH RFC 6/9] migration/rdma: Remove coroutine path in
 qemu_rdma_wait_comp_channel
Thread-Index: AQHcF5WYvnToSMeJjUiVXzXp06cBibSk770A
Date: Fri, 26 Sep 2025 02:44:19 +0000
Message-ID: <cbfde183-881f-4152-895f-5842eaac91dd@fujitsu.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-7-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-7-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|OS7PR01MB14893:EE_
x-ms-office365-filtering-correlation-id: 4b7f53b6-1934-4fdc-cd19-08ddfca6979e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cVU1U2w5Tyt1YjNGSVA0WnVlR3pnY1FoZmR2c2ZWWTlQNUs3eVhVcGVZaDlx?=
 =?utf-8?B?VHIrUzlyVUQrWURmdWdJYm1MM0NqbUV5Yk51OW5EeU1tQ01HRVJGTzRod2Ux?=
 =?utf-8?B?UmJEWllXaDBRVHFsOFUrUnpxNTZBMGNQTll4RExpTG9oZjJIemNiMDlhQUN2?=
 =?utf-8?B?T0g1MS9OOHdYS0pxSzY2WE00U041SVNDZVhLakt6bVlmTHpQWEY5SEh4YUNr?=
 =?utf-8?B?UGtGMkhDZ2lLWWt1dTlSRDA0WEQxZjF0Z0xwTWErQ0dCVWJPMG1FRnBZNVlj?=
 =?utf-8?B?NGdVaG1jVVNCSm56MEp4dnYyK3I2ek05alN2cGhJdXpXazJ6Tk0xQXgrR2tD?=
 =?utf-8?B?UnVnNk5KcGU3VjBtTnBTM0hFcjhpNE5sK1RKSlY1WmpHZWM0TXdKdkF4UjlW?=
 =?utf-8?B?cUhORTF2cThVc0x3KzBnOHZtVUZMclVVTnhwZUZIWER5S3JOZnpob2ZleDBi?=
 =?utf-8?B?NTdNRVc2RUV4aXV0NGtUTyttZG9ZL1UweHhwU0QwM2NzdTlmTnZRbk0rVDdy?=
 =?utf-8?B?RUtINFJRN0lTQUM1WTAvM2ZiZ0NWK1BEaklsbUhWdG5iWUQzUTZQSlViTk1R?=
 =?utf-8?B?TnhGRldma0pWMWdCaWdJUFhQYW9jQk1IY3JMMURCQmtiOWJRM21nUlRWY0tm?=
 =?utf-8?B?M2JyUGFrTlZXOHNpZXdCeEF2eGlTNUZMWDdjaFVxMnpNQUk5MWJOMm9DZmN3?=
 =?utf-8?B?cUMrSkN5N2ZxV01XdE9EOEk5UUJUV3RUbG5EZFdwM0Rmc3JST044M0VZdmNT?=
 =?utf-8?B?bE1uYXhGQVpKTWY1RU9qNExaOUFONnN2ZjNTMjBzcDEyTTZqYW9lRksvMk1C?=
 =?utf-8?B?WW9LbW9VT3VpcGNmR2YwOU5vdkNHS3Y5bUpEc09MYzMzVnU0R3oyQ0pTZUJy?=
 =?utf-8?B?MHQxdzVXZG5PS1d1Q2pkTXA0bjh4NVRiOExPbnFNMm9pbEVhalJJWFBGR2tQ?=
 =?utf-8?B?YktXSXczSGF5azJDK25yaTBYTlJSSWZoSXZZTWlSRFhiWmhtZUdORGlWZTFp?=
 =?utf-8?B?ZW5mWDlqOFdlOEVzK2dIZ1FuQXpCSEhDNTIwNENNMUk2RXF1OTRrOWFVMVN3?=
 =?utf-8?B?THhIRTg0bGU1dmVPY2FyNUYxSlo3SFYvSVhmdGt6N0MxU2dFcHFwcWplWWpN?=
 =?utf-8?B?NGpPVEcrNTlFN3NMcFE0V3hkYXRsY1ZPUmx0eHZaS3BzR3o3QzUrOGZ5bTNu?=
 =?utf-8?B?UGgwZjdlQnhPQ2ZyUGpjYkphZm50Q05IazR6Nk1PdzBUQ0thWVJHZDQ4cFhj?=
 =?utf-8?B?NFIvUnU0dzdENzVyS1JYdGx0TUlVNkMwaDUrUW9iR0Q4QVM2UGY2eHRtMU9l?=
 =?utf-8?B?K2NoZVhrUTN4Z3dWZGlKeU1tb3ZYRjk1UHlZak5sb1lpdmZjWk9XdEhhclBZ?=
 =?utf-8?B?d05ZZlZJdHNVUTdMcmk3OEd2VTk1a0hhQnVlV092eFhLa3JlMUYySGh2c2h5?=
 =?utf-8?B?OFhxQkhDc1V6Ym5oUnd1N250aTdQUUtMZ2FWRTRBYUkxRTJPYXRESk5oZ1V1?=
 =?utf-8?B?TzVLWFRaQitnMzhtV1BwVUF2b2ZHcVdpR0M4NUp2dnJoQkROeFBJaytudUtp?=
 =?utf-8?B?QnlmM0d5aG94aXpzRmFQQUEwY1FJTVJTQklpeE1GM3NudkdXdGxxVEpzZXJh?=
 =?utf-8?B?ZUZsVUI0UXJ3NWNTM3dTZ09rNWM4YVZSclhvVU5sLytReWxNWDdOek5KdFJp?=
 =?utf-8?B?UjBVYTQ2ZFpCRm1Rak1zak5kRy9PVlRSV3BtbTdyMjFlQTRGamI2TDZQSFV5?=
 =?utf-8?B?NmJVQnc4dnBGTEE0L1dtamRzNE53S0ZtVHljZ1M1QzlKRStxaDdtN3g2QlBm?=
 =?utf-8?B?Sy9JdWM1bksrUThlaDJJWisvZDRoeFkxZDk1TUErQW0vVGQ0RFZBUmNiSFMx?=
 =?utf-8?B?c2p5b0VpSklKN1NnaEx6MUlBVEZiZnFhUFR3UGIreUFaZVBhQU1Zd0ZvZWxU?=
 =?utf-8?B?cEVPZzJPbGVlTDJib1pkWCs5c05rS2FKQ1JZZUhVWklPbVhJd1d6WDBGL0l3?=
 =?utf-8?B?WU5Db2gzdmNsQnlueWgxdXJoUmI5ekxFazBxOWhqZnFmUjVVMVJpNWNPdVBU?=
 =?utf-8?B?enQzbHA0SVc4bVdjSVExSUtEUVlhcjBrNThBc2Y3WjZhbFZ5dzdvblR2QVVC?=
 =?utf-8?Q?LSOY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSCPR01MB13050.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzFudDl5a2kxTFhSamEvUThiYThTYmdFSTB4c0hPclM5cjBQdHo0T3hsOTZj?=
 =?utf-8?B?WUN4RERCMm1wYWFRUEt3VmJORXMyMU5tTHpzcmFuTXNUT1lFZWtrdzdCNldi?=
 =?utf-8?B?NXE5QUNDRk1SaFNFaU9pbVNrUXVnejhOOUJ6Zm45b09XblorcXBWeG1kSmJx?=
 =?utf-8?B?MmFlemREY1VDa3JrSDdpbHBCSjR5Vy9wZXRYTnM3bUZjZlZwV3ZLbXZQeG5O?=
 =?utf-8?B?SFBrdTJQU1BJL1JJUGc0cnZpdHI1OVp3TGNCajZ6ZVBQM0NzZ2Z5TXBSQjha?=
 =?utf-8?B?c2wzZVVBS2tPR0VYYWtSWU0wNFd6TmZodFFxV0ZMSUJNZlRsWnR5YzVpQ1RB?=
 =?utf-8?B?UEt1WlVmYWtRdEFyZ21VTEFKLyt0UmtvSmpVc3RXR1pYWnpMZktKT290b1VU?=
 =?utf-8?B?UUlIT1RaTnJXNHQ3WnFRZW5yQWlpM1IwOGN4Rm9QL1UyUFJibmlVQWRCZEc1?=
 =?utf-8?B?RVFiVUMvSGwvZjRoL2hSaUJWbEtvTytKeU9QRm1lTnE2bjNCYWkrNnk0eEZt?=
 =?utf-8?B?WWdEM3UycVhOSmdQYlg0TzlVMTJweHlyL29leS9yd05Cblk0VTZ6Z0hwQUVp?=
 =?utf-8?B?UU5vNEV6aDFjWDFmZWRFTERSR1BRMFJ2eDUxMCt2SWpGK0pUcmNOY3dkZFRu?=
 =?utf-8?B?aFYyN2NhRFBKdU9RNW1JeGtlcnVDN2t1Y2JVc2ZqMzJqS2pZMGF6UzVaWFpr?=
 =?utf-8?B?Z094SGVIUDUvWi9VNmRsWnNGckJ4NVZZMmxwRzFVTEZZUGRDN0dva1pQR2hN?=
 =?utf-8?B?ME5SNzZBTTFiSVpDQnM5WTByMC90OFh6MEVhTklwTGpzSngzN0t1WWxDVHAz?=
 =?utf-8?B?ZGZNU2k0NlNIbWFwLzZKNjkxcGdCUFROUXhpZm1BVnRkMHlaRGY5VFJPUUR4?=
 =?utf-8?B?V29pT3ozK1BjK1MxbzJlMEhZbExTY21xY1phcThXVzM0ZTIzeXg4Q0c3bmE2?=
 =?utf-8?B?cGZTM1hwZ3hESFIvcUNIOTJaNkY5dzZKZGF3VnlCQWNHVnhQZ2svVndLWVFv?=
 =?utf-8?B?TElPMThJVE0xUk1VeTB5SnJwMTc2cUlqUjlnUGcvWGwxdS9ENC9mcHJJeUFl?=
 =?utf-8?B?MXA3UnI5VUtmMUpPQmdOYXVZbEVyUEQrQjRFcW00MlBYZlBnVmR1L21xVVFL?=
 =?utf-8?B?UFlnVzRoZ0E5U2tmcTBYYXFWRnR2SVdLZGJoVDFiQkNmQjRMYkNTZVoxSWxN?=
 =?utf-8?B?a2lRU1JGRHVra05DbnJnU1FERktmY1ZQTG4xcHVpZHZLRWxYN1BETFNacFh1?=
 =?utf-8?B?Q0pKVXBVRjlScFRFUStHbFhJbTI3Y3UxamhHb01LT2Q3RkFDNW9waHZPeWFR?=
 =?utf-8?B?bDQ4Y3Yra3N0U29GeFhDbnhyK2puaEwxZ3Q2K1NZRkZjaXNGaThlYTRpK3BJ?=
 =?utf-8?B?bHNuYVYrTWNMYjkzMnQwMHlieVpGb2U3NnNaYzVHbkpkSUhnNzR3YS82dDVQ?=
 =?utf-8?B?eTZ6L0t0c2lmZTRyMmI2UGZidHRXKzFxRG1sL1NLMENWd0ZYVWh2RzJWZ2lj?=
 =?utf-8?B?SmlLZ243VCtnRmxFUWNXdkNtdTVad25MMFlWcWpIU3pmdjVwbGFsNFgxV2RN?=
 =?utf-8?B?ZHpyZmx6cWo5RlVXRlVXZ3hKN2ZiYWxEclZBZVBEYlFDUnYvMTlvZHlzVGtK?=
 =?utf-8?B?TDgxR3Y5SkkxRzEwVWIrWStOT05scjlaZjNaZWdQTkEwb1NaM1VmQUx3bDJQ?=
 =?utf-8?B?dnNyeXNTV25ZRXNFOGRNdWVtOUlYV1NuQXJ6bE9yOEsxdTAzWVhPcGNVOE1B?=
 =?utf-8?B?YWVXS2pNN2ZmSHZpeTgwWmVtaXd2MllzUFA5SEtHM2dBQnRMWTBTUE9mR0th?=
 =?utf-8?B?d09KWjVpU2ZYRUJ0UStjUzdRcnUrQW05RWdrU1FFZXN5SXRmaThuZ0NqZmJI?=
 =?utf-8?B?WVk3QzBibU1OZ2VlUXh6OGtIUW9qQjFHWVlLT1JzTHRhTllaakpjYWlIeVo0?=
 =?utf-8?B?Ylc2SkNDYzgzNGQyVjNJU0gvVGhYOGVJeFRTTEw4MVBHaVFZdWN4elA1eVM0?=
 =?utf-8?B?TXA0Z1lCdWFNb1FyZ0V6V1luMFRUOEtQTGkyYUtlWFZ0dThDa2VDanplU2ZR?=
 =?utf-8?B?b3U1WWtndFl5bXdlcWhCcmVya1RKWHFsaGxhU28xZDFHRi94WEp0UXcvNG9L?=
 =?utf-8?B?ZmN4RmlEdTlrU09TVkJweHVIbzFTMTVVbFJRMGVTcitkUlJmSDQrdkpySDBO?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A7592E3F927BE4AA0DFCF569F3A1DD5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a5Rwh6Y5/StVriorKEeYWEJ/uIjc27+rO4c0EMFvXk3riELpyWbfproLzgRVfzHiXVXtPBvKB3YizJgrNz3haeGhSDV7Wsfv609Nyu22HSafY1XzCwwpTjkUrTz+jCPjk4A07frLjdN04ZTQeJvxhMxU/IUcV/Xujl9GBgvs3oHMNCrqnW+0PPqSvDMLWMyz1BuaPFMrcirVdDykfOrWIVfA2ZJbPFj/wpc3vtdtwH+yqppa6G6eB4GdjVeQGXLVw9dSsCUbTDIQrCnQQ+ZSoDS03DwNCDSlPBKb6CEx8lhwmB2X0nA6WQBDIO5g61r4E737moYrtDTcqXzz/eneUAdYxAAB0GTpQQqNkerWJxWIuaUo8MmiJFxqBRtbMB5xQbjha+LhpGo/WWKowJocbOCTKbfaXGkmGt8BCCDjpL5Lwxrz1kifUojSO4OpgGuYzuFZDRtB1rR4N0C7HGWX0O2FDABsaYkmqfmq8xPpe7q4cu59DG5dY/6dRCv6YHmSc4D9gAEjwLq4W8ZXA0JnyK+4zv8JDhcih1m3i5zyhM0lTjNE93q8V72U1WJogIfczKTUJytGaMkuKeOOO4dCNTll/eAZeqKIxzBfXhadmn8eODfl7vzYnIxs8guZEZG9
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7f53b6-1934-4fdc-cd19-08ddfca6979e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 02:44:19.4771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrbJeC+N6sWHnwZiOwC428fvzueriQkrmhfR14FMNRuCJd3pv4HmzQtQIM6QB+d90JmE5lOnELeIoJX2Rn8sKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14893
Received-SPF: pass client-ip=216.71.158.34; envelope-from=lizhijian@fujitsu.com;
 helo=esa17.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDI4LzA4LzIwMjUgMDQ6NTksIFBldGVyIFh1IHdyb3RlOg0KPiBOb3cgYWZ0ZXIgdGhy
ZWFkaWZpZWQgZGVzdCBWTSBsb2FkIGR1cmluZyBwcmVjb3B5LCB3ZSB3aWxsIGFsd2F5cyBpbiBh
DQo+IHRocmVhZCBjb250ZXh0IHJhdGhlciB0aGFuIHdpdGhpbiBhIGNvcm91dGluZS4gIFdlIGNh
biByZW1vdmUgdGhpcyBwYXRoDQo+IG5vdy4NCj4gDQo+IFdpdGggdGhhdCwgbWlncmF0aW9uX3N0
YXJ0ZWRfb25fZGVzdGluYXRpb24gY2FuIGdvIGF3YXkgdG9vLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KDQoNClJldmlld2VkLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4gLS0t
DQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDEwMiArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCsp
LCA2MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5jIGIv
bWlncmF0aW9uL3JkbWEuYw0KPiBpbmRleCAyYjk5NTUxM2FhLi43NzUxMjYyNDYwIDEwMDY0NA0K
PiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gQEAg
LTI5LDcgKzI5LDYgQEANCj4gICAjaW5jbHVkZSAicWVtdS9yY3UuaCINCj4gICAjaW5jbHVkZSAi
cWVtdS9zb2NrZXRzLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvYml0bWFwLmgiDQo+IC0jaW5jbHVk
ZSAicWVtdS9jb3JvdXRpbmUuaCINCj4gICAjaW5jbHVkZSAic3lzdGVtL21lbW9yeS5oIg0KPiAg
ICNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQo+ICAgI2luY2x1ZGUgPG5ldGRiLmg+DQo+IEBAIC0z
NTcsMTMgKzM1Niw2IEBAIHR5cGVkZWYgc3RydWN0IFJETUFDb250ZXh0IHsNCj4gICAgICAgLyog
SW5kZXggb2YgdGhlIG5leHQgUkFNQmxvY2sgcmVjZWl2ZWQgZHVyaW5nIGJsb2NrIHJlZ2lzdHJh
dGlvbiAqLw0KPiAgICAgICB1bnNpZ25lZCBpbnQgICAgbmV4dF9zcmNfaW5kZXg7DQo+ICAgDQo+
IC0gICAgLyoNCj4gLSAgICAgKiBNaWdyYXRpb24gb24gKmRlc3RpbmF0aW9uKiBzdGFydGVkLg0K
PiAtICAgICAqIFRoZW4gdXNlIGNvcm91dGluZSB5aWVsZCBmdW5jdGlvbi4NCj4gLSAgICAgKiBT
b3VyY2UgcnVucyBpbiBhIHRocmVhZCwgc28gd2UgZG9uJ3QgY2FyZS4NCj4gLSAgICAgKi8NCj4g
LSAgICBpbnQgbWlncmF0aW9uX3N0YXJ0ZWRfb25fZGVzdGluYXRpb247DQo+IC0NCj4gICAgICAg
aW50IHRvdGFsX3JlZ2lzdHJhdGlvbnM7DQo+ICAgICAgIGludCB0b3RhbF93cml0ZXM7DQo+ICAg
DQo+IEBAIC0xMzUzLDY2ICsxMzQ1LDU1IEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3dhaXRfY29t
cF9jaGFubmVsKFJETUFDb250ZXh0ICpyZG1hLA0KPiAgICAgICBzdHJ1Y3QgcmRtYV9jbV9ldmVu
dCAqY21fZXZlbnQ7DQo+ICAgDQo+ICAgICAgIC8qDQo+IC0gICAgICogQ29yb3V0aW5lIGRvZXNu
J3Qgc3RhcnQgdW50aWwgbWlncmF0aW9uX2ZkX3Byb2Nlc3NfaW5jb21pbmcoKQ0KPiAtICAgICAq
IHNvIGRvbid0IHlpZWxkIHVubGVzcyB3ZSBrbm93IHdlJ3JlIHJ1bm5pbmcgaW5zaWRlIG9mIGEg
Y29yb3V0aW5lLg0KPiArICAgICAqIFRoaXMgaXMgdGhlIHNvdXJjZSBvciBkZXN0IHNpZGUsIGVp
dGhlciBkdXJpbmcgcHJlY29weSBvcg0KPiArICAgICAqIHBvc3Rjb3B5LiAgV2UncmUgYWx3YXlz
IGluIGEgc2VwYXJhdGUgdGhyZWFkIHdoZW4gcmVhY2hpbmcgaGVyZS4NCj4gKyAgICAgKiBQb2xs
IHRoZSBmZC4gIFdlIG5lZWQgdG8gYmUgYWJsZSB0byBoYW5kbGUgJ2NhbmNlbCcgb3IgYW4gZXJy
b3INCj4gKyAgICAgKiB3aXRob3V0IGhhbmdpbmcgZm9yZXZlci4NCj4gICAgICAgICovDQo+IC0g
ICAgaWYgKHJkbWEtPm1pZ3JhdGlvbl9zdGFydGVkX29uX2Rlc3RpbmF0aW9uICYmDQo+IC0gICAg
ICAgIG1pZ3JhdGlvbl9pbmNvbWluZ19nZXRfY3VycmVudCgpLT5zdGF0ZSA9PSBNSUdSQVRJT05f
U1RBVFVTX0FDVElWRSAmJg0KPiAtICAgICAgICBxZW11X2luX2Nvcm91dGluZSgpKSB7DQo+IC0g
ICAgICAgIHlpZWxkX3VudGlsX2ZkX3JlYWRhYmxlKGNvbXBfY2hhbm5lbC0+ZmQpOw0KPiAtICAg
IH0gZWxzZSB7DQo+IC0gICAgICAgIC8qIFRoaXMgaXMgdGhlIHNvdXJjZSBzaWRlLCB3ZSdyZSBp
biBhIHNlcGFyYXRlIHRocmVhZA0KPiAtICAgICAgICAgKiBvciBkZXN0aW5hdGlvbiBwcmlvciB0
byBtaWdyYXRpb25fZmRfcHJvY2Vzc19pbmNvbWluZygpDQo+IC0gICAgICAgICAqIGFmdGVyIHBv
c3Rjb3B5LCB0aGUgZGVzdGluYXRpb24gYWxzbyBpbiBhIHNlcGFyYXRlIHRocmVhZC4NCj4gLSAg
ICAgICAgICogd2UgY2FuJ3QgeWllbGQ7IHNvIHdlIGhhdmUgdG8gcG9sbCB0aGUgZmQuDQo+IC0g
ICAgICAgICAqIEJ1dCB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gaGFuZGxlICdjYW5jZWwnIG9yIGFu
IGVycm9yDQo+IC0gICAgICAgICAqIHdpdGhvdXQgaGFuZ2luZyBmb3JldmVyLg0KPiAtICAgICAg
ICAgKi8NCj4gLSAgICAgICAgd2hpbGUgKCFyZG1hLT5lcnJvcmVkICYmICFyZG1hLT5yZWNlaXZl
ZF9lcnJvcikgew0KPiAtICAgICAgICAgICAgR1BvbGxGRCBwZmRzWzJdOw0KPiAtICAgICAgICAg
ICAgcGZkc1swXS5mZCA9IGNvbXBfY2hhbm5lbC0+ZmQ7DQo+IC0gICAgICAgICAgICBwZmRzWzBd
LmV2ZW50cyA9IEdfSU9fSU4gfCBHX0lPX0hVUCB8IEdfSU9fRVJSOw0KPiAtICAgICAgICAgICAg
cGZkc1swXS5yZXZlbnRzID0gMDsNCj4gLQ0KPiAtICAgICAgICAgICAgcGZkc1sxXS5mZCA9IHJk
bWEtPmNoYW5uZWwtPmZkOw0KPiAtICAgICAgICAgICAgcGZkc1sxXS5ldmVudHMgPSBHX0lPX0lO
IHwgR19JT19IVVAgfCBHX0lPX0VSUjsNCj4gLSAgICAgICAgICAgIHBmZHNbMV0ucmV2ZW50cyA9
IDA7DQo+IC0NCj4gLSAgICAgICAgICAgIC8qIDAuMXMgdGltZW91dCwgc2hvdWxkIGJlIGZpbmUg
Zm9yIGEgJ2NhbmNlbCcgKi8NCj4gLSAgICAgICAgICAgIHN3aXRjaCAocWVtdV9wb2xsX25zKHBm
ZHMsIDIsIDEwMCAqIDEwMDAgKiAxMDAwKSkgew0KPiAtICAgICAgICAgICAgY2FzZSAyOg0KPiAt
ICAgICAgICAgICAgY2FzZSAxOiAvKiBmZCBhY3RpdmUgKi8NCj4gLSAgICAgICAgICAgICAgICBp
ZiAocGZkc1swXS5yZXZlbnRzKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0K
PiAtICAgICAgICAgICAgICAgIH0NCj4gKyAgICB3aGlsZSAoIXJkbWEtPmVycm9yZWQgJiYgIXJk
bWEtPnJlY2VpdmVkX2Vycm9yKSB7DQo+ICsgICAgICAgIEdQb2xsRkQgcGZkc1syXTsNCj4gKyAg
ICAgICAgcGZkc1swXS5mZCA9IGNvbXBfY2hhbm5lbC0+ZmQ7DQo+ICsgICAgICAgIHBmZHNbMF0u
ZXZlbnRzID0gR19JT19JTiB8IEdfSU9fSFVQIHwgR19JT19FUlI7DQo+ICsgICAgICAgIHBmZHNb
MF0ucmV2ZW50cyA9IDA7DQo+ICsNCj4gKyAgICAgICAgcGZkc1sxXS5mZCA9IHJkbWEtPmNoYW5u
ZWwtPmZkOw0KPiArICAgICAgICBwZmRzWzFdLmV2ZW50cyA9IEdfSU9fSU4gfCBHX0lPX0hVUCB8
IEdfSU9fRVJSOw0KPiArICAgICAgICBwZmRzWzFdLnJldmVudHMgPSAwOw0KPiArDQo+ICsgICAg
ICAgIC8qIDAuMXMgdGltZW91dCwgc2hvdWxkIGJlIGZpbmUgZm9yIGEgJ2NhbmNlbCcgKi8NCj4g
KyAgICAgICAgc3dpdGNoIChxZW11X3BvbGxfbnMocGZkcywgMiwgMTAwICogMTAwMCAqIDEwMDAp
KSB7DQo+ICsgICAgICAgIGNhc2UgMjoNCj4gKyAgICAgICAgY2FzZSAxOiAvKiBmZCBhY3RpdmUg
Ki8NCj4gKyAgICAgICAgICAgIGlmIChwZmRzWzBdLnJldmVudHMpIHsNCj4gKyAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gKyAgICAgICAgICAgIH0NCj4gICANCj4gLSAgICAgICAgICAgICAg
ICBpZiAocGZkc1sxXS5yZXZlbnRzKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgIGlmIChyZG1h
X2dldF9jbV9ldmVudChyZG1hLT5jaGFubmVsLCAmY21fZXZlbnQpIDwgMCkgew0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiAtICAgICAgICAgICAgICAgICAgICB9DQo+
ICsgICAgICAgICAgICBpZiAocGZkc1sxXS5yZXZlbnRzKSB7DQo+ICsgICAgICAgICAgICAgICAg
aWYgKHJkbWFfZ2V0X2NtX2V2ZW50KHJkbWEtPmNoYW5uZWwsICZjbV9ldmVudCkgPCAwKSB7DQo+
ICsgICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gKyAgICAgICAgICAgICAgICB9DQo+
ICAgDQo+IC0gICAgICAgICAgICAgICAgICAgIGlmIChjbV9ldmVudC0+ZXZlbnQgPT0gUkRNQV9D
TV9FVkVOVF9ESVNDT05ORUNURUQgfHwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgIGNtX2V2
ZW50LT5ldmVudCA9PSBSRE1BX0NNX0VWRU5UX0RFVklDRV9SRU1PVkFMKSB7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICByZG1hX2Fja19jbV9ldmVudChjbV9ldmVudCk7DQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+IC0gICAgICAgICAgICAgICAgICAgIH0NCj4g
KyAgICAgICAgICAgICAgICBpZiAoY21fZXZlbnQtPmV2ZW50ID09IFJETUFfQ01fRVZFTlRfRElT
Q09OTkVDVEVEIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgIGNtX2V2ZW50LT5ldmVudCA9PSBS
RE1BX0NNX0VWRU5UX0RFVklDRV9SRU1PVkFMKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICBy
ZG1hX2Fja19jbV9ldmVudChjbV9ldmVudCk7DQo+ICsgICAgICAgICAgICAgICAgICAgIHJldHVy
biAtMTsNCj4gICAgICAgICAgICAgICAgICAgfQ0KPiAtICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiArICAgICAgICAgICAgICAgIHJkbWFfYWNrX2NtX2V2ZW50KGNtX2V2ZW50KTsNCj4gKyAgICAg
ICAgICAgIH0NCj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiAgIA0KPiAtICAgICAgICAgICAgY2Fz
ZSAwOiAvKiBUaW1lb3V0LCBnbyBhcm91bmQgYWdhaW4gKi8NCj4gLSAgICAgICAgICAgICAgICBi
cmVhazsNCj4gKyAgICAgICAgY2FzZSAwOiAvKiBUaW1lb3V0LCBnbyBhcm91bmQgYWdhaW4gKi8N
Cj4gKyAgICAgICAgICAgIGJyZWFrOw0KPiAgIA0KPiAtICAgICAgICAgICAgZGVmYXVsdDogLyog
RXJyb3Igb2Ygc29tZSB0eXBlIC0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAqIEkgZG9uJ3Qg
dHJ1c3QgZXJybm8gZnJvbSBxZW11X3BvbGxfbnMNCj4gLSAgICAgICAgICAgICAgICAgICAgICov
DQo+IC0gICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiAtICAgICAgICAgICAgfQ0KPiArICAg
ICAgICBkZWZhdWx0OiAvKiBFcnJvciBvZiBzb21lIHR5cGUgLQ0KPiArICAgICAgICAgICAgICAg
ICAgKiBJIGRvbid0IHRydXN0IGVycm5vIGZyb20gcWVtdV9wb2xsX25zDQo+ICsgICAgICAgICAg
ICAgICAgICAqLw0KPiArICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiArICAgICAgICB9DQo+ICAg
DQo+IC0gICAgICAgICAgICBpZiAobWlncmF0ZV9nZXRfY3VycmVudCgpLT5zdGF0ZSA9PSBNSUdS
QVRJT05fU1RBVFVTX0NBTkNFTExJTkcpIHsNCj4gLSAgICAgICAgICAgICAgICAvKiBCYWlsIG91
dCBhbmQgbGV0IHRoZSBjYW5jZWxsYXRpb24gaGFwcGVuICovDQo+IC0gICAgICAgICAgICAgICAg
cmV0dXJuIC0xOw0KPiAtICAgICAgICAgICAgfQ0KPiArICAgICAgICBpZiAobWlncmF0ZV9nZXRf
Y3VycmVudCgpLT5zdGF0ZSA9PSBNSUdSQVRJT05fU1RBVFVTX0NBTkNFTExJTkcpIHsNCj4gKyAg
ICAgICAgICAgIC8qIEJhaWwgb3V0IGFuZCBsZXQgdGhlIGNhbmNlbGxhdGlvbiBoYXBwZW4gKi8N
Cj4gKyAgICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiAg
IA0KPiBAQCAtMzgxNyw3ICszNzk4LDYgQEAgc3RhdGljIHZvaWQgcmRtYV9hY2NlcHRfaW5jb21p
bmdfbWlncmF0aW9uKHZvaWQgKm9wYXF1ZSkNCj4gICAgICAgICAgIHJldHVybjsNCj4gICAgICAg
fQ0KPiAgIA0KPiAtICAgIHJkbWEtPm1pZ3JhdGlvbl9zdGFydGVkX29uX2Rlc3RpbmF0aW9uID0g
MTsNCj4gICAgICAgbWlncmF0aW9uX2ZkX3Byb2Nlc3NfaW5jb21pbmcoZik7DQo+ICAgfQ0KPiAg
IA0K

