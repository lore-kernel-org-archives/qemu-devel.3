Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC7DCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 02:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHXKb-00042o-HM; Thu, 15 Oct 2026 22:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXKY-00041a-8s; Thu, 15 Oct 2026 22:05:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=742cbab99=Alistair.Francis@wdc.com>)
 id 1xHXKW-0001sI-Aq; Thu, 15 Oct 2026 22:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792116362; x=1823652362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ez74UsWQ1n0QFsHT+7tnZQZZB9ghlGYgtRdz8cUn/Ng=;
 b=HtWPV6KXCJbuinfTbcJ1LEKnh4R9RbfFdWeb83Le1i4KvSKIdaE6o/YO
 k5mi3rSyrJEtb60NFsUwRfO40xtR6/7u8CEpx0dtXtY3DS04UbelMz/D3
 32mEoEHAeTLFQkgp0t9C6QRXnHwjRPkcEExN5o4BYclhf3ubKli0wTFtD
 VwskWFrNUSBEC3W+mL0o1dpiJQa7RNYo2iEldt4T4lHXoRcyClMzpsXui
 SsIIGe4UjBmgaFjb0qNA8gj9ToVJbx03uW7UDNYVvy658hRvdWDv15u4/
 xNDDVd9y4ewWCX8bidh5/IinJwQcJARr3ikOVJphR3/v7xoDoPOCKpdsc Q==;
X-CSE-ConnectionGUID: qTL3JBIpRDKpgu96z8cWvw==
X-CSE-MsgGUID: 7R+cHS+xQKO+0TcTvnXuJQ==
X-IronPort-AV: E=Sophos;i="6.27,160,1786982400"; d="scan'208";a="159178672"
Received: from mail-eastus2azon11011051.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.51])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 16 Oct 2026 10:05:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAxB1iMBodvbOo7lHTvoiYloAqhLB5j/R0Y+x4iLYEGmmbh3JpoWvCcj8cHloBLrVlK0P4Ttdc5uNTUc+k5eJRp61reB3yt3unTFCQkOTBYf71Ik74eqb4w6D4g3Fa4WnZ8ETZmLUtO1eUXpwEEsTCrHoWYsqx73NtKNi1fOIxEJ3ooSl+c9BKG73Xp7HHs5X1y8nX/bGIgsR9E1VjbgrqOwvCnLIYNUmYjVRsf79QjUMg+4vPV4gmEQ7Q2SZ4IuzXhpve2o6neVWSVJcBsnofrfh/hgCf7ly3ku8ICDKZbeAJlvF/E+H4pNJhgRbHOm0mfMg23+2vzKzk7zvi5OvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez74UsWQ1n0QFsHT+7tnZQZZB9ghlGYgtRdz8cUn/Ng=;
 b=ZcdVAnvDYMOY4MIBWz9lf6TgpB8p6L8TI8YqKb2sdgLNDOVBUqbZEKyDjoWr7tAfnDfH2EPkBSiIBE8LC4THOmY/ZaUq/8mlx1939ZmP4CdRDLTQ5Lpquktdw3JPgVUXW3Cb4teAp7AHS68+lLZGyUrkLOyzAF98Fajap0mhs95MIgJsOUmdbspSroXZgdg51K0TMpmK7wejYGC0+a4X0mYoRGs2YmFGA5yWfSCfRdXRfvj5e9cITzzZGtPtD0xtMrTIUCkR+V1r5fUxafgjtcVPdg8IbM1zNKTzSuQ6eOVyUDHvG2ZK+UhrFqbFOYPFdUJWdeVAGTCtXUIsvNi7Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez74UsWQ1n0QFsHT+7tnZQZZB9ghlGYgtRdz8cUn/Ng=;
 b=XtbJ/qrpiOsSplyhqYcT9LlgxtA5SHeS5pn1Lp1qLOZYJpRWr9zNSHazneEnm6CbIJy7BulkahsYpkWMaw66Fnk0F2dIHzmGeqK/eUEIEj7Sut6SfVXF+nyTHtpAALKPk4XJxIJUhd86Mbven53nKcJnSebD79aybmGYSqwCPuE=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by SA1PR04MB8886.namprd04.prod.outlook.com (2603:10b6:806:386::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 02:05:49 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 02:05:49 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH v2 5/5] hw/dma: fix k230_gsdma integer handling issues
Thread-Topic: [PATCH v2 5/5] hw/dma: fix k230_gsdma integer handling issues
Thread-Index: AQHdUnbNyiL6TvxtSUSepSMM4M7HMLb/gMqA
Date: Fri, 16 Oct 2026 02:05:49 +0000
Message-ID: <621efd0cf2f709dd9cc0491a7955d21bd0f7f09b.camel@wdc.com>
References: <20261002140245.30214-1-dingtao0430@163.com>
 <20261002140245.30214-6-dingtao0430@163.com>
In-Reply-To: <20261002140245.30214-6-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|SA1PR04MB8886:EE_
x-ms-office365-filtering-correlation-id: b8bc21e5-d491-421e-8543-08df2b29ffb6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|19092799006|23010399003|22082099003|261009223027099003|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003;
x-microsoft-antispam-message-info: Zfl9+aehX4ainN6cMvZMOPAFHdeFDwee8wWQ61s45tF4ji4/Zcqy/hRzDdXt3VDkIg8uV+Kf/FZLxyEEUxRx7W7tSksrEIblLzM986OJMMvl7uy/ufvcMYO6hIWJcwIa1biRS1pOx3oUs6JA3YIG7wfM7dkq23Q4T4z82aPCl757yfRwomuOm/Ue8fJ5+H0NIW3nIU69BRpk59OfawghQOsrXvvUrXNxq2ydCxJD4eNxhtQrUuelRTniubs8hSeYa3B5NkAm5dzYAOHY8oA0iRU+99JHAPggXNBGWBb2FU51W4MLutqOWbOxqPCuUYcoDPnswz1bW8RHTGd01rd4tbosonqO1vCMQgr3wYCySrB7pP/8g2sUy19HGVDPR+1lEdokm2O9bxdki6JrVR4PBfPsLpu8Zr8hQ7Yq55+A/CuTJ85cc2KWdCz33CBgy3JqN9vAm6HRG9KxKxtYpcUUqfsolqc/oI8ViPTyL79S8E8nlQjPEiBWJyvyVzu/nZOtAfhTCvV+Y+kTTSQZVxiBXOSNCyZss6VUwAoBLjyhcfRVJKh9RZHNLXdyUyY3Htaotf6zGcveuRYDdvfdfX5qf0yKUPPHNzfi0EW9xjW6vikv7samp7nzvw7lrop+jV+WZf1aYb0ruM4cW+Kf1zr1pi8eVhcP2IvSKGNlHY3RZoGeTjyM+y23Hkel2/VcuMJ2PhLBNjfvwCFIzKXkcxUF0fuKDzRkWavtg6QyGjfVLoo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(19092799006)(23010399003)(22082099003)(261009223027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Smw2MitmSnc4eDc5NURUK3ZlOGVHQk5VUXlxaTArNXh1SnJEWm9UdmphOVUy?=
 =?utf-8?B?KzdqK1dFNnJMcDlPNXRocWhqbU1YQjFsT3JXWTY1NG9FcEZURnQwMEk1aFVl?=
 =?utf-8?B?WG1kdlJDK25nb1I4RFlWUHluNm01N2hhb0Y0N2N1ejhjclQ0WVFhN0dlRjg4?=
 =?utf-8?B?OVJvWE4rOUdZTUNtRDBXWWUzYzNTdHVCTXZ6QjhmS1R4cXZlNDZLNnpXWkdE?=
 =?utf-8?B?TWpiR2RiQkxabitKdklWV1k1SlJCSkJkc21RVUdtMnBpU1Z1V3VBMUxIWUw5?=
 =?utf-8?B?WFdIWTh5WEIwNXh1NGZMREFmRHZINVZjYmpJMG41TDJzZlkrVVVkaThCc0Yz?=
 =?utf-8?B?eE9qNFVNTkhWUk5rd3FYWm9rdkhqMS9aay9vN0NGS29OYWdybUllTExjSGhz?=
 =?utf-8?B?YktTYXNMWnV0QlNrSXRTbWdjbkFaRk9sVDAzZ0hhaFozMzR3bmVIM0JyNy81?=
 =?utf-8?B?QXp5NzJONndhdXpJamMySjNCMEZMb2hreG9TUFlCOHRaM3VYNXFDcFRZWU5T?=
 =?utf-8?B?b2VaeXZaZXhQd3hIOHF5c1BTWnVVekRBK1FCM3ljd0x4Si9mSWZTdDdhTGwz?=
 =?utf-8?B?T2xQMklkdHFEK2h0VDdnNjhwNlVjMlpVR3JCbUtxeU1DblpIZW9jMVdON3U2?=
 =?utf-8?B?WDN1dGRNdjgrU1BhMkNaMDU0S09sS21vT3BvQnNoTGVuZEtSY05VeW1KSEF5?=
 =?utf-8?B?RXQ4RWduR0NuRCtYYlA3SGRjK05CSHNhWmxhR3VEMS96eTFuUWYyVkdsVVZX?=
 =?utf-8?B?UEZPRzBXZU05VTdMQWZXRWREVW1TMFJ1SnBNcU5EZkV1SnlKSFpwR0swdHJD?=
 =?utf-8?B?SHUrdXVpa2NpNGFWVEduZVVYVmJDUEorUnFJY0FQV1BDWTFMNy9TUEQ3T3BL?=
 =?utf-8?B?cUVDbzVUQ1NYdUJFeC9uMU8vYjIwa3NhaXV2QjI0WXBTdFRsekRkUnZPOTNF?=
 =?utf-8?B?SkYwdHE5ZnFoUDRmK2xNckdSS3pVMjJUdkI4ZFdaQTNZWUFIb21OVXhYYTdI?=
 =?utf-8?B?T0tMUWVjbEs4dThSaTlkNnBjZXNJK3FVSGlncVYrUnVpLzgvUFVHaWZjQkky?=
 =?utf-8?B?UGFQOEtwenpSN0h1c0FvQ1RvMUNxWGhMa1JvT1JQR1d5TjhLTzdHR0dEbGdz?=
 =?utf-8?B?Y0dLcEUzRDR3YmpjVVNHWTh5QUZUNWVaMms0WmlHTDNzOGt4eU1ZckkxMWRL?=
 =?utf-8?B?TnBRdVh5VzNTbHd6Q0NxcFkrSTQ0SzI4REdXYnNTWVpxWHhLRXdsSTVhakE4?=
 =?utf-8?B?OVhZY0xlT2Y4eEU3OUY0SlYvOXcvZlNnZ3ZscTFPaDJDSnF4ZTRlVCtRZnJv?=
 =?utf-8?B?clNQNVBqZmJhV3Uwb2ZpQ0xTc21BQkxMZ1hoRUZGd25qWmxPSHdPQWNXanBU?=
 =?utf-8?B?K3p1aVFnNkhsd0VXOXdwNVhYVk1Wa0IreW5iUjFyTVpRZS9XRFhPbFBROE1H?=
 =?utf-8?B?ZGFtWTRiUDFDSFR1SlhGeXFpUlYzRWdIQ1ZwOUV1ZHViWWE1elA5bkx5aWlQ?=
 =?utf-8?B?TzdKMGtIbk13NjI2dWt0ZmFqUmI1RTNJQmZtUmh4aGZRYWt5b3VFdlI2MVZW?=
 =?utf-8?B?RlZzbnJtL1BoL2J6UWd5bDY2bEFrSUlmWm1VaitKK2x2Sk4xOVhOSEFBV01Y?=
 =?utf-8?B?ZXNwQWtEc2ZJdFgwYTdlS1d4Qlp5Ukw1YUlaM0dkNVJtZyttaDQvbjZpZkpQ?=
 =?utf-8?B?eWE2ZHkwUnRVNlRQMS9qbStSdERJU1M0dzdneWtvQ053YjNnaWYyaW9zQm1t?=
 =?utf-8?B?OC9QVkljTXJCdkZRR1RicG9EOFh0Qkh3bENPQlA4YjJ3T1Z3d010Q1pFeC9B?=
 =?utf-8?B?Y2JHRWdVSkRxQUZ5RlducU5lc1Bib0x0M3VZNVJGait5OUZ2NGxLMjNGaklQ?=
 =?utf-8?B?SUk1Qlh1MC9zbzdKRGczU0hpcWt4ZFpXM1JPaVBhaGMvcm9yZFJCdFBDZDZn?=
 =?utf-8?B?cFprMUtwSDJYRVdoMkpnRE5hemwxSk1hTCtqMXVaTzdqQ04xOEV2d2ZScko5?=
 =?utf-8?B?RHhIMXlVZjB3UUJQL0tvSlBwclpvWlJoOC83b1hkTzFMUGYvVFYwcVpuUkdL?=
 =?utf-8?B?TUdHaWk4MVpWY3lNZFlFbjF4dkxaRU5KNzg5aVlXT0htdzlCS2tJUTZWbjRk?=
 =?utf-8?B?TFRkMnZTdjJRcHBMSlRYQ1NzY0ZNbzBHZHVSbHA1NjZYZTB6WTA2cWhkQlVU?=
 =?utf-8?B?M0liSTZORnlUMndhazdNenBPQTYzNjlPQmprMkt0UDVLclJoTkEvOFJzVGU2?=
 =?utf-8?B?M3NsMXh1TlhnQXE2YUhFVk43R2ZRQWZVc1laeWI0SHRibGV2Q09NV0lCcFkw?=
 =?utf-8?B?ZVBPOGZMUXhLVnlleGxpZ2ZyajJzRW1CVktRYS81aURlVmticlFsQzhWWGh2?=
 =?utf-8?Q?N7/adK+I6Km8rjCrwLvK2FRlPuPcjAfU4SViY3e70teNw?=
x-ms-exchange-antispam-messagedata-1: xjdk7JbTKXEMaH1YmZrIHHF3uMgiJPp24PY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03EFFFFD8B3AE04EABC8EBE3CA49400F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dCW8MO3a7gwjLa96/U6r9KbqnsVGtZEaFVpzz7E+0nWB5iSBQpv63aEI4/cLzlzwBVl9FfEa/3JdhSPb4Jd0vE4ejAa9cLH1MeZb0XgUs4y+RUFG9rZa3rYjaswjI7+A7RTYhAertEfhuUUQaqljek+QkFwsM0+0yP3RT/YNxtV7/WaSwec0slQJFk2nu1amiQ9fsNz8rwRmtz7d3kfcb7nYFwi+GfRlAg192iizG81EFCkaiYuLlTo0Pz10C2V5T5PLL66Wam8qQMISkBdWtDAX69wFQXkw5BL1RRGdTUIuA26Cmutugp1AmYqVZ1P+PASoXQuyUS7PURbT38LD7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w81eFucYguoYuHRv7tYVI5iwnXgIpB2zcqqvWqn4BfXtW53REEPcvoZrCr1aJftps3YS3rmySzW2f8BGgAHTfCVAHDrSRVVWKEmZCguaNuSEV0N0BBvELmAbtURpNgBXy7dyhEai+u2mgc41WisGUgKBgSCZB8I1G6B1XItauXiUBpQuXbNX9fVuv9NviW2LuzZd+S7Zp7AmuIlxS9syJCm+vyKVq5TfEZdtzSMhinNvGHK5XKZl9vMgFOQdsmgkwtsFKTqa/ia+enMsS8fImnRxUAa5E5m1p5NGfo4C1GcHg5XO+Ym+NAJ0miwZG4N2K/ptRtHABtofOdeAk4j3O6YL0gYbv0JPy2Xu/fRDQX/5geicOJbNbuft0Fjfu3tyFTtH7nMkUeiGsCYvAZXJVpx6ZGztqgDsLt10ELnIEUn8LKO7obfFWNvbXH9nwMk/5dvNnYavaRUI2OG43XP8DWNE9n0eXUVsdGLpKaWl0/c2xpF/GLhYg8iroDsrgFgWYvlkz3YFCAGDTsqaL9ihXe6AnyKTxUNOFJwnEAO31Ovb2p6rRsHkWk6+sJrUCvnYoloRBMNgjvwL5GKpDMnmOxaI94GgtpnsC5ZN6ZaMfcI77cT7GNk3aHGWlZkpju25
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bc21e5-d491-421e-8543-08df2b29ffb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 02:05:49.3209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxeTT8ZvclKoTaDZ8GlcIf3siHyMFfc1O9xUJz8S4quIQruS3nfVw1vgjZYVOKsOE8PMHTt3HKCeUf43CxpykoDHh8v28tP+V2EzcoLhvqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8886
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=742cbab99=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDIyOjAyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gVmFs
aWRhdGUgdGhlIGFkZHJlc3MgYmVmb3JlIHN1YnRyYWN0aW5nIHRoZSBjaGFubmVsIGJhc2UgYW5k
IHVzZQ0KPiBod2FkZHIgDQo+IGZvciBjaGFubmVsIGNhbGN1bGF0aW9ucyB0byBwcmV2ZW50IHVu
c2lnbmVkIHVuZGVyZmxvdyBhbmQNCj4gdHJ1bmNhdGlvbi4NCj4gDQo+IFJlc29sdmVzOiBDb3Zl
cml0eSBDSUQgMTY4NTUxNA0KPiANCj4gUmVwb3J0ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPEFs
aXN0YWlyLkZyYW5jaXNAd2RjLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGFvIERpbmcgPGRpbmd0
YW8wNDMwQDE2My5jb20+DQo+IC0tLQ0KPiBDb21wYXJlZCB0byBwYXRjaHYxLCB0aGUgbW9kaWZp
Y2F0aW9uIG9mIGNoIGhhcyBiZWVuIHJlbW92ZWQuIA0KPiBCZWNhdXNlIGNoIGlzIGFuIHVuc2ln
bmVkIGludCwgaXQgaXMgc3VmZmljaWVudC4NCj4gDQo+IMKgaHcvZG1hL2syMzBfZ3NkbWEuYyB8
IDQgKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9kbWEvazIzMF9nc2RtYS5jIGIvaHcvZG1hL2syMzBfZ3NkbWEuYw0KPiBpbmRl
eCA3NjM1Y2QxOWU4Li5lNDIyYjQzNmEyIDEwMDY0NA0KPiAtLS0gYS9ody9kbWEvazIzMF9nc2Rt
YS5jDQo+ICsrKyBiL2h3L2RtYS9rMjMwX2dzZG1hLmMNCj4gQEAgLTMyOSw2ICszMjksOSBAQCBz
dGF0aWMgdWludDY0X3QgazIzMF9nc2RtYV9yZWFkKHZvaWQgKm9wYXF1ZSwNCj4gaHdhZGRyIGFk
ZHIsIHVuc2lnbmVkIGludCBzaXplKQ0KPiDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiDCoMKg
wqDCoCB9DQo+IMKgDQo+ICvCoMKgwqAgaWYgKGFkZHIgPCBLMjMwX0dTRE1BX0NIX0JBU0UpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiArwqDCoMKgIH0NCg0KVGhpcyBpc24ndCBy
aWdodCwgeW91IGFscmVhZHkgaGF2ZSBhIGBpZiAoYWRkciA8IEsyMzBfR1NETUFfQ0hfQkFTRSlg
DQpjaGVjayBhYm92ZSwganVzdCB1c2UgdGhhdCBidXQgcmV0dXJuLg0KDQpUaGF0IHdheSB3ZSBk
b24ndCBsb2cgYSByZWFkIHRoYXQgZG9lc24ndCBhY3R1YWxseSBoYXBwZW4sIGFuZCBjYW4NCmF2
b2lkIGEgZ290bw0KDQpBbGlzdGFpcg0KDQoNCj4gwqDCoMKgwqAgY2ggPSAoYWRkciAtIEsyMzBf
R1NETUFfQ0hfQkFTRSkgLyBLMjMwX0dTRE1BX0NIX1NUUklERTsNCj4gwqDCoMKgwqAgY2hfb2Zm
ID0gKGFkZHIgLSBLMjMwX0dTRE1BX0NIX0JBU0UpICUgSzIzMF9HU0RNQV9DSF9TVFJJREU7DQo+
IMKgwqDCoMKgIGlmIChjaCA8IEsyMzBfR1NETUFfTlVNX1NETUFfQ0hBTk5FTFMpIHsNCj4gQEAg
LTM1NSw2ICszNTgsNyBAQCBzdGF0aWMgdWludDY0X3QgazIzMF9nc2RtYV9yZWFkKHZvaWQgKm9w
YXF1ZSwNCj4gaHdhZGRyIGFkZHIsIHVuc2lnbmVkIGludCBzaXplKQ0KPiDCoMKgwqDCoMKgwqDC
oMKgIH0NCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiArb3V0Og0KPiDCoMKgwqDCoCB0cmFjZV9rMjMw
X2dzZG1hX3JlYWQoYWRkciwgc2l6ZSwgcmV0KTsNCj4gwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4g
wqB9DQo=

