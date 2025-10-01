Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tOj-0002zA-FD; Wed, 01 Oct 2025 05:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=362a73bd3=wilfred.mallawa@wdc.com>)
 id 1v3tOg-0002yh-HF; Wed, 01 Oct 2025 05:45:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=362a73bd3=wilfred.mallawa@wdc.com>)
 id 1v3tOT-0002ql-Nt; Wed, 01 Oct 2025 05:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1759311905; x=1790847905;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bzcVqn6LcdT4U/BOZLy5kTvW6ZDuhBdR8PWw5h4iF80=;
 b=QrIMk7EaIJ7ZQDOD3EHh6nQHEJfjro9rNMDkYaMG4lkfZHktDN9JuhLW
 RdX/V2nw0cStvyEim3XLptA8+Xo2g5EYApIqSTZZNH+AqLRLwEd74C4FH
 dEbeD3LnitLVtYy23y0W6RiDX2Olv+Af9fc2O76q38Sp5oWnSYylFmUGS
 ZuiA8Am75RYaHJnrQg2T4ucoi1pYSNIczVS6Kf0es+T+by7poUmifNmTo
 xuGYto3LEytzCJL9wV70O9iOd4H9jOlw7227q0RQ6Cujx3zf4zkdXCuw3
 D7jKIWtUEq0oUgXlWo3vAuNGwvdEL79g23uOgVSN9y7tmuCOKKhCADN0m w==;
X-CSE-ConnectionGUID: MUcTky5OQ+OED+l2a38e8g==
X-CSE-MsgGUID: uM+T4pCLS6euTgFEAm3yPQ==
X-IronPort-AV: E=Sophos;i="6.18,306,1751212800"; d="scan'208";a="133600627"
Received: from mail-westus2azon11010000.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.0])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2025 17:44:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdghXSoAk3I9E+FzRq9Z1ZovY45S52ChNUxlALqbNVZUlycK6Kg8O5YdwXCX9V+wkrYFauh8BZqL3Bp/hT3EbyK/hX5GlrnnctX1qQPXzfuxB/nFRRi56rVpRpqaAnTrB8QcXbBar91jsM7KT6anRuthkq2fFa2ruuIUwjmMzcwklBm+3XNL48EKdgpLfnYMKUy1raeZSKOJ4Aot7m1m8M6S8AExz1IhKFG31lEPNxvzIjA4143zHWrZ9m5Fl5lk7U90gFzdXMunHiYCQNjzvp+5yaFVg3sY7WAsb7xGpkR1ygObBsXE0mUd4pJmqPWnZQYsm23NNkNvE+Fyu+GmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzcVqn6LcdT4U/BOZLy5kTvW6ZDuhBdR8PWw5h4iF80=;
 b=HEniieqo5f4KaYx46IhK29BubD2ZRCmO6MYyWVRd0jUbIr9JTl83rG0eKUGKcr7bVtl6bKHcGTo/DZFXL73rluy7PVzwfjTGs/wpRoh3gaHbJMNqM2YZMIyjds+onYfdCZGpgmLH0mbn9TmI+o/e/5d1m/pq540p+oSvYCsiV7P7nju5LyK6cyIuBDRK9OaKybnGNNAqpPmsR9lxXNimi9QdrsD5BnSZcAZ1ZrLNv9Uo+KvjdMzrvHXQG+06K84rg4aKbM3USTzFesAWDl7/byOJYBDExXboLujiXPkTbrW/zVHBp6q2vRbALYxlVQpIKjaiRC+JwyrmE7ffnAGtQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzcVqn6LcdT4U/BOZLy5kTvW6ZDuhBdR8PWw5h4iF80=;
 b=yqFFRixvEoP6AQdqCMccSPJBNEf8Vs7NolXuPL2EHW362tdJyn3paSlPeAib7sYIM66mmknlQd0nlrlmUSzCNaGlEAhM6mnQFbA0u1TfaBpGM53h1hj1h0J8jWrDKMadGwo9Vr5M36Gr2Cm79VfmZhJMu0WMcOf8qTBuJYEOFMU=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA6PR04MB9239.namprd04.prod.outlook.com (2603:10b6:806:41a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:44:48 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 09:44:48 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "foss@defmacro.it" <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Thread-Topic: [PATCH v7 2/5] spdm: add spdm storage transport virtual header
Thread-Index: AQHcI4qtv0XdpU+L30SCZvTDvk+rlrStGLaAgAAQQIA=
Date: Wed, 1 Oct 2025 09:44:48 +0000
Message-ID: <de2015b7312b174c96daf79913ff07f7e08d6f8f.camel@wdc.com>
References: <20250912021152.46556-1-wilfred.opensource@gmail.com>
 <20250912021152.46556-3-wilfred.opensource@gmail.com>
 <aNzqbYmO6jkT9-9-@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <aNzqbYmO6jkT9-9-@AALNPWKJENSEN.aal.scsc.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA6PR04MB9239:EE_
x-ms-office365-filtering-correlation-id: 9b33f777-d934-4468-39d4-08de00cf2973
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?d0lzeU1YaDlHaHJENElUUysxMy9zNi9kU0NwRFVnK0NqU3EvZkFOSXRvNFhG?=
 =?utf-8?B?ZksyVUFVYU05UWFZMTF4R2tNT2txT05XeWQ5UmQ4S3ZYTkc4S2huOVhNM3FJ?=
 =?utf-8?B?MGZrKytaNUUxZi9BVkhVdmVaT3BLTFp6Vkc5RU1pUUhtNXNGdExvZmdDd1o0?=
 =?utf-8?B?UzJhQXcwUzVtcVI5ckxzUjl3TUxTSC9JR3U2Rjd0ejF5WjRMdzdNU2JEdktI?=
 =?utf-8?B?cTBOZm1iV2FjZFcvOU1vSlJVd2FzTmpiK3hqYmYwSnppRk1oS20xeFViWm9I?=
 =?utf-8?B?eDFJaXpRblRkTE9CVE04SmZyYmREZnVMMi90QjM0cGd3LzhROWlybFJUZTYz?=
 =?utf-8?B?dnhUVEdEVmg0VUlRSFI3TU01b0EvVG5DSDZ1cTBqZENsZ3I3Y3pCT2FrdXpv?=
 =?utf-8?B?TDFLQ3hxSGQrRUNOOUVNV2N6UlBsOUNESGdqUFdYZUU0RG9iSVVhNkpjTVAw?=
 =?utf-8?B?ZUtST2hXejVEYWxZRHoxUldMRE8zakQ1Mm5qTGJHbUZvMDEwNHVWZ25SWkU0?=
 =?utf-8?B?ZHgwbkd1cmRTc0RCSjhaamxXOXRIYUI2bXUxVWgrVUR5SVEvODdwOTAzUGdO?=
 =?utf-8?B?RXNyQkdMUGZsejM5WWl4Q2JHdVNoWlBRYmVSWGh6MjA5Z3E3aVFtMkZsa2F1?=
 =?utf-8?B?Q3M0RnlOUitkSUxtcjVWTkhZMGtvQzRkQ2tsdzVablRwMFh1eVdGOUpnK0Ew?=
 =?utf-8?B?VVV6TlA1dWs1dk9EendoNW1sQUcrTEd3T2pycUlGejgwdGV1TVpwQ2RRaVlH?=
 =?utf-8?B?dnJzVHlwMzJuUjQ1ZURZYU5ScEdmUENFVms2eGVLbGJ2dTFXTHFmeVFPekNI?=
 =?utf-8?B?ZlZMZFVFMXB3MjJiTm5jMzl4MmtkYWZjeHVrcURCdWxIaWt6TlNGQm96VnJm?=
 =?utf-8?B?L1VqMlR2MU5ZQ1BONnFKWm01MUtjYk5EdGlvRlZMU01hdlZHWUFsL2ltRVNP?=
 =?utf-8?B?S21BN2VaZ3dhVUNhT1dOMkZFaktqby8rV0hkbmF2WVd6NXVaZmp3SHNMSTNw?=
 =?utf-8?B?SnBZeU15dWdsdUw0ZGYxaDRjZzVlZ21QQ0hKcXJnbGF3aXZvaEFleUxhb3d6?=
 =?utf-8?B?ZXFoR2R3eWdWWkFGakFLaFRaYzdLeVBPTlFZZVN4RWNLU2xUaDM2ZHdVQ0x5?=
 =?utf-8?B?L1VVd3FvK3RGa0RTa1VoYXNkNnIwTEkrVXJYWTIxbVBYdWd2M0hvcXFRTDNi?=
 =?utf-8?B?V2w5bjFNSFJHWmRiOXk3VDNmYUhpUUhtYkR4M0dOeFFHK1haZFNSRHVPWXBa?=
 =?utf-8?B?azZTVHNKbk4vVlZLN0tkWjlaSkw1T0QyWTFDc2NGTmxRanRVMHN6RU8yZVdr?=
 =?utf-8?B?cEJTSVFBOVV4M1Z4UnZqQzZkMHA4KzZtL2tnMEF5dHl4OUExRmRFNDlaalB0?=
 =?utf-8?B?OGJEWUdwejl6Zm9RK3JBaENUeHFwelBXZEFQYW1LVVRGMFhPTUFoS0pnQkNP?=
 =?utf-8?B?aGhzUFBoTzF4UVdjQXkyT3ZWTkRrVHR0cmdyQm5NSVNxbWNsNUIwYTRMOUVx?=
 =?utf-8?B?RjlBY1JUUjNHbStIQTZzRkl0SUgyRk1lMzZBcFNwQmNCa3ROMDRmaFhhRXNa?=
 =?utf-8?B?TUcra3FMUlBJWGlIME93Y3NDTGFDU2p2ZnlzTzh3QWN3QUtoU1ZmWndhOXJL?=
 =?utf-8?B?dFU5WGFzZ28zazFqaVQwVFAxdWlrWXlCNUprWWpLQmc5bDJwMzdHSUM1Z1Vw?=
 =?utf-8?B?VWxkdDhRTFArRXJGWkdETkVlMkZLTkpjZXgzdDNRMS9QekkxNjhxNG5qY0pG?=
 =?utf-8?B?dXlRK2RqeUpJTUN4aUl2SEZzb1JJdFVWQ0liUVRmL0ZCanZBU2dnVWhWK242?=
 =?utf-8?B?UlpxSnN2T1Y5T0t6L3ZEZmhaamdvNENBdzhtWVkramdLYmMwaHd6MDRDd3Er?=
 =?utf-8?B?b0lBZlVoRmcvTzdxUXVCNmhhcWc2V25SVHAyOThrSlpiOUVQMXBLZUdmSzRh?=
 =?utf-8?B?NlQ2eVRUUXd5dTBmZUVnbVhVdUw5ODZBNDdKbU9HaVBKK2xkZ1JyK0RtWlJZ?=
 =?utf-8?B?akpBWWo1S2tWakk4bFVUZG9mV2hPRlRERmt1a29pVHhWQkdzeUJadGRUV2tW?=
 =?utf-8?Q?40XJOr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(7416014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFNLQUQ0TDhMcDQybTZTdi8xcmJoY05qZlo3OXBGN2RnMFN1ZVJLSlY0cXlR?=
 =?utf-8?B?aGZCN2ZpcXRzK2gzRFB3Mnc1by9rRTgySEF3UGR2emplb1luT0JDd2h0NGcx?=
 =?utf-8?B?Z1VqejZZeHQ0RjViVG0xRmh2MytDTTQvd2hRSVNOR2wvOVJEOW1vWE8wWjRt?=
 =?utf-8?B?U1pra3JpbVdyclhkUGQ1c2o3SmQ1N2h1bmQ3WThwUFY5VC80UTY5TFBRTXJL?=
 =?utf-8?B?K25LMDlRVmk1WThuNXB3YVdZcHhUdXVnL0ZxR2ZJL3h5T3hwRkRicDIxMlk1?=
 =?utf-8?B?K0V2YzVZaUpUaEVLbUh6THVDYmxsRkZRSW5DUHc2dTIyeVpRaWRWUmRNb3dP?=
 =?utf-8?B?WEF2ZUczY2gyTXFrTHhwWU1NRlpuWmhpc2xuQzRqT0l4aStxV0ZRbVYrNmdw?=
 =?utf-8?B?OGpFc0JXbUE5bkViOGROYVRPUkFZMnFoOE81TjRKbGtoN1ZyNWN6YmRKT3pZ?=
 =?utf-8?B?cTQvQkk0c1BGRi9OZGdDQmtWQXlHZThBTXpmbWVyaUNnS3VtWVNWb3g4ZWdm?=
 =?utf-8?B?YTdHd2xVQ2F3aVV3VU1OUFR0ckxJaW82VWUweXhCTEtUTzNkV0luT3lxa0NJ?=
 =?utf-8?B?c0FMM2hJZ1hFd25URUc3UVpJQUNHT2dXcWc4WC9yWTNzd2ordE1HV3ZmOWwv?=
 =?utf-8?B?dS9ob2MxZ3FVQXo2Nnp0OUlkV29DbWpFWTVlZUhZaUwzZFV5dWVqRXFMdVlD?=
 =?utf-8?B?RFovSS95ckhLZVBBbmdEUjlQWCs4eW5OTmkxcUI4MElaVGVvZUtHc3N1eUlK?=
 =?utf-8?B?NGx5NitoZ1dDS0wwT3FVb3J3YThhbFAxTUxaYlVKNnpEVnpyVkxRb0Z2bGpu?=
 =?utf-8?B?YnhVNGt0YVFvVktCcUVramlwWkxXOFEya2xpYUpnbElyZE91c2FqU2Z1Tml0?=
 =?utf-8?B?ZzM2eGZRMXpZazVMRWZBMVpjNmt2aGwrbEIrbW0xUVZyaWplcjhMR2s0VEpq?=
 =?utf-8?B?bGlWNEwwVHg1T3dDczZVUVhKbW9RWHkzMVFyNHBlRWFGanYxNDc1c2JtNmRP?=
 =?utf-8?B?ZlBXMzlvOEtOOVE3RWM0RE1IVDV4RjlmN2dpV3JUYlRpWTNUb3EvUlA2a2d5?=
 =?utf-8?B?RnFvcGV5NnpJU1pGTk9Ramh2ZEM5enlQNmJ6OW04Ry8weWNPaDkvV1lPRERH?=
 =?utf-8?B?WkxGblBNeWZiZEpIMmRqRUYvQ3RydnNaREhMNU51TFFXT3R5ekFSM0ovbG9L?=
 =?utf-8?B?dFBxQkxMZitkNTFmSjNiM2k2KzJIT1dYTzlzbVY2SXhWeWtKcHE4MDdMZm84?=
 =?utf-8?B?T2RKZm1OeEhhaWdCSXNvZjVHNk9CWnM3MnhIbW1WUkZEVm9Nck9uNDdOSDZC?=
 =?utf-8?B?ei93Wkd5T2Z0UDl0RVVBUFdCTkFHY0NqK01aUXFjeC85NW1zcGNjZnVxeml0?=
 =?utf-8?B?YmN6eS9XSE1vUTBQQ0tZd2M4RFF1bk9TU0ZVdzRoWXNISlFKMFZPYndOa2wz?=
 =?utf-8?B?Z1VWYXgvekpOcmR6YitpL3F5Wk90UHNhQXgrajcxclpzY0xmbW9BQ2J1b1VD?=
 =?utf-8?B?ODFGQ1hNYXNzaDdQT2hRbmppVGdqbFFJUlNweGRQam1wT1hjZm1wZTNlYm9j?=
 =?utf-8?B?UmFtY1I0SzluTkJ3S3p6TkkwekZoVEsyMU9iTVB0R0U1T05rWEtURXE4L3VV?=
 =?utf-8?B?dHpFaEovcTMyUTlXdEU5NTRsL2V4cGhvUVYrTGlIbHhoVXFBMkhZZVVFc1lo?=
 =?utf-8?B?d3pYWXh5LzZ6UHdCZGIwT1Y5M0RkTFk4UXZHd2hUMWFRSTloaHhtSDFXYkti?=
 =?utf-8?B?K1dtQ3NVNTlDbXZnOVlDVlZFQnlwNFdBTCtGWHV0NVpEMlBoNWErMVYxYXJt?=
 =?utf-8?B?eExYbEdsKzhXUklsWW5lUDV3T3RReTVCN0M3QjE2aFlSRnViUnlJMWlKd3FM?=
 =?utf-8?B?NE1PK1hRZ3krSkc3M0hITnRXL3dIRml1eXZwMlhqZ2hpSU9FWWx6emFmSXox?=
 =?utf-8?B?dTNTVGVGL0czelJyZkZ5MlluWlJhaTBVTC9Pd0locjBuZ2Z2azZCN1JZcGI1?=
 =?utf-8?B?bzZSUXNRdXZscGZKcGhJcHg3cG5EOXpWZHhCZTZIQTZGVmtWWXNPOGRtM2l3?=
 =?utf-8?B?clpnWjhNa1FBM3ZTVENFYkZIeHIwVjNYcHJ3NTZFZHdtU2RySGZOenhabkh2?=
 =?utf-8?B?eVIraVVocktxWnI3Wk1RY1g5QTFrMVpKWDNMVTdpRm1iVXRMWm90VFIyalhU?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F72F4A4140596E4885784662B141900A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KNb3ShIV+naUIbjA6VZLpkCvP4K3hT/I9JEHi8PbQ/k8nbSjureRXNQrgxAivbDAb1igXovo9AKHmZCVki7lhFufGHeLS+MDrY652aLnqedHGp1qir18NX1UjARfhn2FFr96DFpV2k1GZNvDViuyMOaRXuyWRRf/eePktRIgMhnRdVgwnEhT4yyalQ6QBngz/GYmdizfL1Cw0NnHmEAskPSblQMSiURpUaUXJWMOuKCnjUml3Yu2Jm6GeBHkmYFWEIBfyODN4HkEU311YtwwTOY9w2MoqMba8tp4rKrQOK4pH35rk+SQuIN2cxzYmALaM11kzMUoJP6y2rncwFgRANBzRa6niusbPN4h+j0OoPw3aZ/FjfIJbboFfiMfZi820Iuz3xVCUD3NsnFnF0kT2jXBFmD6+0JaJEgJY6aqkytDmpsGl8ThGsN7zu1ZR4srKimi0VV6Zpby5029kkq8fh+XX5FxGmys2fGR3EwH0KI4urvkcE3APatV5Vxw9xHK4U6/QWiymqAidBNa2JDQCXB7JXJBFSFoKVzzYcm0hqcrb3YkWyurBaKy9HrDgUrpXg8iRMGkuSG5yojpyLXvFe6gDg+edXBggJv0aswo3CTFuCZBXzSFcTwwSocI/YNK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b33f777-d934-4468-39d4-08de00cf2973
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:44:48.6422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4p9AdWRkx5eKSr2YwyIYnVO+W1S8vw4K72COJPyLzjNIWRi93Xu0SeHHoovSwK/Fes4BbVWyxBEp/rJ7419IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9239
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=362a73bd3=wilfred.mallawa@wdc.com; helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gV2VkLCAyMDI1LTEwLTAxIGF0IDEwOjQ2ICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIFNlcCAxMiAxMjoxMSwgV2lsZnJlZCBNYWxsYXdhIHdyb3RlOg0KPiA+IEZyb206IFdpbGZy
ZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+ID4gDQo+ID4gVGhpcyBoZWFk
ZXIgY29udGFpbnMgdGhlIHRyYW5zcG9ydCBlbmNvZGluZyBmb3IgYW4gU1BETSBtZXNzYWdlDQo+
ID4gdGhhdA0KPiA+IHVzZXMgdGhlIFNQRE0gb3ZlciBTdG9yYWdlIHRyYW5zcG9ydCBhcyBkZWZp
bmVkIGJ5IHRoZSBETVRGDQo+ID4gRFNQMDI4Ni4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
aWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+IMKg
aW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCB8IDEyICsrKysrKysrKysrKw0KPiA+IMKgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCBiL2luY2x1ZGUvc3lzdGVtL3NwZG0tDQo+ID4gc29j
a2V0LmgNCj4gPiBpbmRleCAyOWFhMDRmZDUyLi44MGNkNzAyMWMxIDEwMDY0NA0KPiA+IC0tLSBh
L2luY2x1ZGUvc3lzdGVtL3NwZG0tc29ja2V0LmgNCj4gPiArKysgYi9pbmNsdWRlL3N5c3RlbS9z
cGRtLXNvY2tldC5oDQo+ID4gQEAgLTg4LDYgKzg4LDE4IEBAIGJvb2wgc3BkbV9zb2NrZXRfc2Vu
ZChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdA0KPiA+IHNvY2tldF9jbWQsDQo+ID4gwqAgKi8N
Cj4gPiDCoHZvaWQgc3BkbV9zb2NrZXRfY2xvc2UoY29uc3QgaW50IHNvY2tldCwgdWludDMyX3Qg
dHJhbnNwb3J0X3R5cGUpOw0KPiA+IMKgDQo+ID4gKy8qDQo+ID4gKyAqIERlZmluZXMgdGhlIHRy
YW5zcG9ydCBlbmNvZGluZyBmb3IgU1BETSwgdGhpcyBpbmZvcm1hdGlvbiBzaGFsbA0KPiA+IGJl
IHBhc3NlZA0KPiA+ICsgKiBkb3duIHRvIHRoZSBTUERNIHNlcnZlciwgd2hlbiBjb25mb3JtaW5n
IHRvIHRoZSBTUERNIG92ZXINCj4gPiBTdG9yYWdlIHN0YW5kYXJkDQo+ID4gKyAqIGFzIGRlZmlu
ZWQgYnkgRFNQMDI4Ni4NCj4gPiArICovDQo+ID4gK3R5cGVkZWYgc3RydWN0IHsNCj4gPiArwqDC
oMKgIHVpbnQ4X3Qgc2VjdXJpdHlfcHJvdG9jb2w7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogTXVzdCBiZSAweEU4IGZvcg0KPiA+IFNQRE0gQ29tbWFuZHMgKi8NCj4gPiArwqDCoMKgIHVp
bnQxNl90IHNlY3VyaXR5X3Byb3RvY29sX3NwZWNpZmljO8KgwqDCoCAvKiBCaXRbNzoyXSBTUERN
DQo+ID4gT3BlcmF0aW9uDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEJpdFswOjFdIENvbm5lY3Rpb24NCj4gPiBJRCAqLw0KPiA+ICvCoMKgwqAgdWludDMyX3QgbGVu
Z3RoO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogTGVu
Z3RoIG9mIHRoZSBTUERNDQo+ID4gTWVzc2FnZSovDQo+ID4gK30gUUVNVV9QQUNLRUQgU3RvcmFn
ZVNwZG1UcmFuc3BvcnRIZWFkZXI7DQo+ID4gKw0KPiA+IMKgI2RlZmluZSBTUERNX1NPQ0tFVF9D
T01NQU5EX05PUk1BTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMDENCj4gPiDC
oCNkZWZpbmUgU1BETV9TT0NLRVRfU1RPUkFHRV9DTURfSUZfU0VORMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDB4MDAwMg0KPiA+IMKgI2RlZmluZSBTUERNX1NPQ0tFVF9TVE9SQUdFX0NNRF9JRl9SRUNW
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAzDQo+ID4gLS0gDQo+ID4gMi41MS4wDQo+ID4gDQo+
IA0KPiBUaGUgYWJvdmUgc3RydWN0IGlzIHNwZWNpZmljIHRvIHRoZSBjb21tdW5pY2F0aW9uIHBy
b3RvY29sIHdpdGggdGhlDQo+IHNwZWNpZmljIFNQRE0gc2VydmVyLCBjb3JyZWN0PyBJdCdzIG5v
dCBkZWZpbmVkIGJ5IERTUDAyODYgYXMgZmFyIGFzDQo+IEkNCj4gY2FuIHRlbGw/DQpZZWFoIHRo
YXQncyBjb3JyZWN0LiBGb3IgZXhhbXBsZSwgc3BkbS11dGlscyB3aWxsIHVzZSB0aGlzIFsxXS4g
V2hpY2gNCmlzIHRoZSBvbmx5IHNlcnZlciB0byBzdXBwb3J0IFNQRE0gU3RvcmFnZSBhcyBmYXIg
YXMgSSBhbSBhd2FyZS4NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS93ZXN0ZXJuZGlnaXRhbGNv
cnBvcmF0aW9uL3NwZG0tdXRpbHMvcHVsbC8xMzkNCg==

