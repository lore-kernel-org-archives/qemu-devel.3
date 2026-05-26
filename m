Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32EBCD5BDE
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 23:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1ZP-0002v5-9O; Tue, 26 May 2026 19:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1ZH-0002pH-7n; Tue, 26 May 2026 19:52:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=599a94ef2=Alistair.Francis@wdc.com>)
 id 1wS1ZF-0006uv-9i; Tue, 26 May 2026 19:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779839533; x=1811375533;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=f9cGDULbeQuLNKXl2V73WlPRdLl7pYbKMgfZSmMBUZk=;
 b=OZD9mRMC2i/4RDYnmSTuCKv3IwYU3K3sUDFzLX1RJwOGpTlweewGpSZ8
 0ucDTXooSEtBPmoWPaNSWf/pTx4838vQp0rtR9pEHXrsBoMAnkEbB9M21
 zfavBEMerYi7TZ73eupaPqr5sPD598+Fnwff864iGFpbeQwUKKY2xu8ix
 Z+D5rQatpSP0QQ9U6fInVFI9V3zX61ppnY3JKu5wOdpCHYwPvyGny+PDy
 sCcrZEOnK90t1E1dGejYftIOc06ofXSseUdG6hLX/muuOlFIZFm3Tjmoi
 u24RVNiJDnbHZjHTTE8nifxnJvS4l0Zt6RnJVc6WljUbCF2B5UNCm5HRA Q==;
X-CSE-ConnectionGUID: XAsrLe16TtWGnQTClXQluw==
X-CSE-MsgGUID: dPI9lyaOROCpCIr07pdLEg==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="143712884"
Received: from mail-northcentralusazon11010045.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.45])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 07:52:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CM/LSKQ2U/8qtlu7tEkUIkqxA6UdnIsY4xRNiVQwAlfkRbNaVBmMr6TctOQrGeU54LgiZFRduUQcs86nRRKPTmkTgSxK0i6gSWLhsrGk/bMKxcMr0d5IpzbCaAVMY9vl1gZ9rg9ypNG7lg+aRAkE3zjo9HsJ9XEvBhlrEZokWOB0a0GRSD3pj3rqL0MnZekyjlt2Jic/ObBH7wtTYwGTLCn+2hqzuYgiWul2HHpTZK2Sr1cMKQ/66DLEJcVUbhtfF7Bxo7EhLBYhSCxyAp7CuhG/Q4/Lpq77q/3/IwCLpveRWyR2QBvobXEvLkzeiaz5cVw+pp1tDLcOxKe7cjjU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9cGDULbeQuLNKXl2V73WlPRdLl7pYbKMgfZSmMBUZk=;
 b=M9Ff+Po8FZhCL+LgPhTaEPydzpYahjS1ejW2dGvIw0w81eFKqiS6RciUGWi2vNIWiMl1bPcp1gKNy2iRM9VNQAaGpV7RzEfoPGeeS1+Oc/dnJXUovAV/lNLoOgqD9zw7kK4RfXOCEbZHVptYHWarg42UCle3aI/xH6az03LKQ3D7RmPjYLGR1aTHusPE56OcKM7H7daaMFphBYuQRgVzzfeId+StvPXZ8LZ0HmZsOtbAtBLbdqLjen55MpxupgWb8fdCzKer8xO+bpfKkmdGq0pA0owXT/V6giNKT/U+HyITBhWfC52efN20Tmp82kcmrHIZdzuuNjb/mHgOnwkR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9cGDULbeQuLNKXl2V73WlPRdLl7pYbKMgfZSmMBUZk=;
 b=AUAMLRUJHIW9pfKB6+FvIaeYMEWOnsvB52QpFFKbGG4SwzcyxDC99JBvlQcAZiqFSklqk/kdEWvE9BMITaePi8y/TusmCQruI1tCFlaE38QTWVp0VJpkbnHVQMKyDJW6F16C9eO/7WlRL3AsmPdU8ubX6OLUowmJjae0GIt8omQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by IA3PR04MB9087.namprd04.prod.outlook.com (2603:10b6:208:525::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 23:52:08 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 23:52:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 4/5] target/riscv: Reject x-misa-w without TCG
Thread-Topic: [PATCH v2 4/5] target/riscv: Reject x-misa-w without TCG
Thread-Index: AQHc7P+P7CLMZx0SQ0uFOvi6S6NwgLYgOcSAgADBjQA=
Date: Tue, 26 May 2026 23:52:07 +0000
Message-ID: <c254529af5aee1c33bc143ad72d79839231465f1.camel@wdc.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
 <c33bea8085f103db209eaf06f978297bba727d88.1779792111.git.fritchleybohrer@gmail.com>
 <4e562850-06c3-48f0-9023-d1c5df71e828@linaro.org>
In-Reply-To: <4e562850-06c3-48f0-9023-d1c5df71e828@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|IA3PR04MB9087:EE_
x-ms-office365-filtering-correlation-id: 45af4596-a159-4b80-59cd-08debb81cbe3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|376014|366016|1800799024|38070700021|11063799006|5023799004|4143699003|3023799007|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: VpQPnrXo16VXymrbXz5yP6dTgpuxCUL85h61ZeynNexx7Ai+KIzXY1vumV7wxDhkZ/EAVrQOCJ3i5ELiXy++BO+uXrfUwF+W/s12UH+SbCSvnKoyb74i/mBUJB/j0UCKaPt79jr0qvtAIgu+vQ++Zg6FbYYpgFr3E+BTgQZwQRHb7BO4vcz54J7vYcPZkSeBQUrV4/7dj8yjLdRlGmFUcR3p9paDRn51ngb6eC8XpkO1pdbJfXuNbJpuN7O7eyHnMiiFMmyXhg7R5o+syRIq7hhWIZC529txQ+sRL8BGBa4Ptkf9lNyFrmYkcNBUiQ9pnwCRKkhIvls+2Y6fD2ha3OVpUi/iLuQzksPVne952/7v0UJMssiScD3Il2OpKrXwjytYcMPSpKnQ5CZMim+xDED6PFitP+d2kgtNGOkO9dK3/nuEcly8vBTgGdCiiApr/UZCb8lQia/RRxnIn6NE9akoGRHpsc0+Fx+ikku1ywiYEWc2IaUAQjqyuMNQiXjPKmaAwWi96Sm9h1BUmWjHCOpOK8khpohahGc+kl9154jUbQMLjxxQ0dL+8Fw42cymj/gQW0mLsNgQQBmnZdXtIlEM3MXeTaVKaOimoDNlTkWrSyZebSV/zI8s5HX/WRE6McC5IwRiu/Xn30faNsRVG1HLsU8hKRNN2fizFjue1+weo5skEG0icMbvDFPwYXe2pLoJMDyNXLvJjhd9vihVGm3yNepZ4N3actqY8GsGJ7XzW4icDIxvsp4xiFrVv9hP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(376014)(366016)(1800799024)(38070700021)(11063799006)(5023799004)(4143699003)(3023799007)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c29yRVFnclphTXZFK3RCUGJwS0xuNUEyMS9KU0UzZFA2d1RKRnQyNWI1RzZt?=
 =?utf-8?B?cGY1Q0FlMDBtUFNWVVErclQ4elBjb3UzNmNuVGs1a005Z0YxOFpRRFVvWDZN?=
 =?utf-8?B?blBJWnJUSVFFb0REd25PWkpnSUk5ZktIam1OSmlDOFVTYVBTbVRabFNkTjN1?=
 =?utf-8?B?WGkxczhLQW05Q2NQTUFTVGhnYzh5bGpIeUJMMFNnRXhVOWVwRENiWngvZysv?=
 =?utf-8?B?bmFXUytsTGtzWnlxVVlXRG1ETXpOY0tHT3FlTkwzRWRQcnlISW1xRWpmMU5V?=
 =?utf-8?B?Um1nWTQrUklFeDZIOExmWlVKYi9uS2dIRm9qdHZyZitoeDJzVE44cXJpQ2py?=
 =?utf-8?B?emJUZEhVNG9QTWRFbE5taERPdkYzamtKRU1hSFlRZklRUHdyRHFIMmd0QWtY?=
 =?utf-8?B?NWV0QlR1Z1pGNHl6M2xZaERjcXdXblF0RFJaN1pVcHdGMlBScm8rNy9KSFAx?=
 =?utf-8?B?dlVhL1NMTDE0VWdnZnA3VDU4UURCQlYwRFFFVk41aWZMYit2UHd6R0JOYXE3?=
 =?utf-8?B?VFoxKzUrSCtrM2R3RHNnN2dqdWtpYkFVelBlcWdEQ0hvVnJibWlDUDEzWUFC?=
 =?utf-8?B?Tk5OVFd5ZEo5WVgrUGZvMkdnbVNRMmN3UTQ5MjdES2V4S3RxQWMyNC81aFFZ?=
 =?utf-8?B?cFJSSVBHOU4xckE4SElGek5GdXZQNVhDRTNxZlo0Tk5mVmVqS3Z2YllualhD?=
 =?utf-8?B?YzFoQkhVWnR0aXl4NWNIeFBhWFI1Z1VzQ1g4QTVvbmFaeVVoR3lFTkhPc0pp?=
 =?utf-8?B?eWpJRWM3cllrYmhZakRoVGpFcDlQaTcvOUVGSmNVOWc2U1p2ZjVWaDdxVkN4?=
 =?utf-8?B?RzJEOHI2dEs4bnM1ZEl1QXRaTElBYTduVFAwK1dUT0R3aFpiZmZEYWc4SGNB?=
 =?utf-8?B?UHVQNzJFTmkrbDY3aVN2Y2FUQlpMUGE4d2FvQzJtdkgyUSt5N29Hb3liTzRk?=
 =?utf-8?B?MmZVa2kwTzVJTmF5UnhnZFltSGZJWDBZd1VyR0tJUHdIUWFqNkFucUY4eHU0?=
 =?utf-8?B?WlRHU3pEMWp2bE1YOHB3bFpBdHp0aXNyRUcvZzNvTjBiSjV4eUxGb0ZpdUND?=
 =?utf-8?B?T3FsMENOaXU4azFoZkFXRDRROWMyZXhxMWVXT3poVGdBbUJTY081aVJzTk91?=
 =?utf-8?B?ZWRRM0R4VEZQbU9iREJqK0FQMW85aHIxU1c1emxnNjAyYmZnQnJpMzQ1ajEr?=
 =?utf-8?B?T09pa3FrVWl6NGRYckNCQ3NBWCtBc3dEcFZod1RjZWJxT1Q2ejJvaVhPQlF2?=
 =?utf-8?B?WW8zTHhOOWI3ZlUrb2htSm82WVkxdXNJQ3pQemxpQ0p2dE5qWFpod0cwT1l2?=
 =?utf-8?B?dnRkcE9KRDhHVFQ4dmdLVjFtenZxNkxmcHYyenFaWEFJejI2R0VRMWYxeWxB?=
 =?utf-8?B?aW1xNmZsdjMzVDhPVklZMFhCZnJ0dmM5SWVKeThCR2FmSHNUVW11MHRld1kz?=
 =?utf-8?B?WFNaVDBtMndnNkQwZU9GYUhjRFJJVWdBdFptNHp2K2JuQ0ZSNDlzOFVub0xB?=
 =?utf-8?B?aTM2eGw3V2xDNitoeHN6ajBDYUczMWNWYTkxb3NRcVNXZnZGNlR0OXozbjhI?=
 =?utf-8?B?SUpSSndMcFV6TTl6MVJzRjAzUmYzSGRHaE11QXpZTUloelBhSnE4Qk9tZW43?=
 =?utf-8?B?SHVOblFUQ2oraDRSUGVOazM5RXBHYkdlYVovdnJlRVNubExrZENocHgwL2tR?=
 =?utf-8?B?Qk5GSm1sdDY0SEFxbk51UE9XcUhHd2FJanRuZ0RmMFdLLzhEejBNd1dNR3Nh?=
 =?utf-8?B?Z0xWcnNwdlpPdFUwTzRIeFdEVDJJaFZJdnU0am5zSlpXa0ZzaEZsZ1BTd0lk?=
 =?utf-8?B?NlY0MzdaOUFiNEYwa3lHbi9mbGxnSksrVzVjNXhmOWJMZjNNTXlxR3VKeDF3?=
 =?utf-8?B?UXVIZkI4UGFxYW9jelp6enRBTDhHb2E5VzlwOWJjYVVoVUYxak96RXE0QTFP?=
 =?utf-8?B?RFl2ZEFGR2V4WXRCWi9rWm5zK3BvN1ZZVE5pUzB6NktZblk5bDJibzV3eDVu?=
 =?utf-8?B?MVRIaDlMVGlYN1ZNMmtCUGF1MFR1dVEya2tGUEc5bGdtK3dvOWYyZFpiT2x3?=
 =?utf-8?B?bHd1UlpUSlY1cnJWUWJXZDNMS0dDZW5raUhOdVUwTkM0ZGdJbVhGSVViWXBO?=
 =?utf-8?B?bjYwZWpOQmx3YS9FTkZ4Q0szT2FRRHZ0eGVaUzE3eW5pSGVLSnk4OUo0WkV5?=
 =?utf-8?B?TGM1WFhEVlVMM2NzY2hoakxneEs3bXFnYmd1cGxkdGRuby9vWUpnMU9QVjFj?=
 =?utf-8?B?YnEwWGlCWUpqNXQ5WVRYZHpha0doeVVLWVJEUlZPUi9IVWZQaTkvK3JiRmFi?=
 =?utf-8?B?aUJBT0JyaUZpN2M5bEprS2lQRHdTUlNoZkdqYWx0Sm9mTUxzeEFvbnpURWg3?=
 =?utf-8?Q?tG681eHuax60n6f6T4Xf7pBGoz+ir+wr/C3TAFrb+O5hE?=
x-ms-exchange-antispam-messagedata-1: 9i3jpl4EiOCW1MKpM/jj8w1Z+xh/4SyJFS8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27147A676675FB4FAD8A78553544AF6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V7lrEEZRJoms62cQ17gVgzH9S5CINA1FaXT/mesCR5xE3nHD0qY1a8HqDFEk2P2j4Z1uSLJt8vsxXPz+alYwFVcLwmbviFlb+4A2h5IoE7QZJyFAOGP2fRyILKveWN5YDmR1mFgEgPTuTndzPw/kITuKXKiyHAuEkzVdy7Vxg2ovuH9xB5J7AbxH8eSsf2uBb1PMxmNpmbTHFIxHaH7vzhOz0ycMm+6/lRhWenzof9F+C1wFH+z71/MO+gAd5lZ9V6SS2z1e3dcr8z3tu6h6WNzUReOGcf50/9hrBv7BStGdg/w52MJQ9mKsqizNpo3iTw+WFQ6UHqfCzedNDswVjA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J7CRsFDBciBq2AAxTZUYtoVwLWHaPiBwQ2jYsLMbsgc7wfr5eMDKWRTaUZlwhf1rl+LxOX3HZczc+KRFv3WSSD0SW+dM1tGk9D43PA0nASbAgtMe2XbancBn6QiqxAEuMkc+j4z26mute8zmNXEoh51v/hIxvOFOC/VCru+Hqlpe2Zu6oKeZc2GSuCq/7sUUPavsQRBlL6Np6tnhKNeiRIW26IdNf9BSJP/b+AuxsXTq12B2w0/qkVNft8i7WI36wJKi7BCMuA4XJY+wnK6zdwCO/W8+2mc3JQvZBv/rYaJ1GCXs3L+ZvwEf1KGkpxPLdNoRKloQbkUCRtFjizKgsgGi8hsjfcI4kHiHueMDquha60a55vd18TjYlXYxH1NBYwsFATcvAGJUJi26EO4Hpi6u7+7m2NgLlgGKeVJeS9xlnLPSmq9UmHBVnwWkOVThJ53kVPJqohqFHI/RdGD1QpxEMNWiNsunbhlhiPXNrs8DvCPgphyPuP+b5IOWTMITPmpawk7JNhZuwjdrWDlHwO9pnj2B3QFheBAfni0X2JD7sroNdeDrS5KzyZY/iK2GPTrKk4UugHpkks0jVneuyO7FnEub27zm/6NDWrM6xzgARJPgblb61XuECxclBPq1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45af4596-a159-4b80-59cd-08debb81cbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 23:52:07.8701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SMzcnEeIET61hhVIvPIbMdpYZgNwVf04ltiXLOap0BUQzrD3qSQnkqnNZDgoPsnwrfwglOK6yOQfB9HtoOChgz286ZmJjd3HCwD88sAuNUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9087
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=599a94ef2=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDE0OjE5ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gT24gMjYvNS8yNiAxMzowNCwgWmVwaHlyIExpIHdyb3RlOg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFplcGh5ciBMaSA8ZnJpdGNobGV5Ym9ocmVyQGdtYWlsLmNvbT4NCj4gPiAtLS0N
Cj4gPiDCoCB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrKysrKysN
Cj4gPiDCoCB0YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuaCB8IDEwICsrKysrKysrKysNCj4gPiDC
oCAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+ID4gaW5kZXggMWRl
YTY2OTcyZC4uOGY1NDYxMDA5NyAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMN
Cj4gPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gPiBAQCAtOTU1LDYgKzk1NSwxMyBAQCBz
dGF0aWMgdm9pZCByaXNjdl9jcHVfcmVhbGl6ZShEZXZpY2VTdGF0ZQ0KPiA+ICpkZXYsIEVycm9y
ICoqZXJycCkNCj4gPiDCoMKgwqDCoMKgIFJJU0NWQ1BVQ2xhc3MgKm1jYyA9IFJJU0NWX0NQVV9H
RVRfQ0xBU1MoZGV2KTsNCj4gPiDCoMKgwqDCoMKgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0K
PiA+IMKgIA0KPiA+ICsjaWZuZGVmIENPTkZJR19UQ0cNCj4gPiArwqDCoMKgIGlmIChjcHUtPmNm
Zy5taXNhX3cpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAieC1taXNh
LXcgcmVxdWlyZXMgVENHIik7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiArwqDC
oMKgIH0NCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+IMKgwqDCoMKgwqAgY3B1X2V4ZWNfcmVhbGl6
ZWZuKGNzLCAmbG9jYWxfZXJyKTsNCj4gPiDCoMKgwqDCoMKgIGlmIChsb2NhbF9lcnIgIT0gTlVM
TCkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxf
ZXJyKTsNCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmggYi90YXJn
ZXQvcmlzY3YvdGNnL3RjZy0NCj4gPiBjcHUuaA0KPiA+IGluZGV4IGEyMzcxNmE1YWMuLjIwYWQy
OTRmODggMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmgNCj4gPiAr
KysgYi90YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuaA0KPiA+IEBAIC0yMiw3ICsyMiwxNyBAQA0K
PiA+IMKgIA0KPiA+IMKgICNpbmNsdWRlICJjcHUuaCINCj4gPiDCoCANCj4gPiArI2lmZGVmIENP
TkZJR19UQ0cNCj4gPiDCoCB2b2lkIHJpc2N2X2NwdV92YWxpZGF0ZV9zZXRfZXh0ZW5zaW9ucyhS
SVNDVkNQVSAqY3B1LCBFcnJvcg0KPiA+ICoqZXJycCk7DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRp
YyBpbmxpbmUgdm9pZCByaXNjdl9jcHVfdmFsaWRhdGVfc2V0X2V4dGVuc2lvbnMoUklTQ1ZDUFUN
Cj4gPiAqY3B1LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBFcnJvciAqKmVycnApDQo+ID4gK3sNCj4gPiArwqDCoMKgICh2b2lkKWNwdTsNCj4g
PiArwqDCoMKgICh2b2lkKWVycnA7DQo+ID4gK8KgwqDCoCBxZW11X2J1aWxkX25vdF9yZWFjaGVk
KCk7DQo+IA0KPiBCeSBzdHViIEkgbWVhbnQgYSBuZXcgdW5pdCBmaWxlIGFkZGVkIHRvIHRoZSBz
dHViX3NzW10gbWVzb24gc291cmNlDQo+IHNldC4NCj4gDQo+IEFueXdheSwgSSdtIG5vdCBmYW1p
bGlhciBlbm91Z2ggd2l0aCBSSVNDViBidXQgaWYgaXQgd29ya3Mgc2ltaWxhcmx5DQo+IHRvDQo+
IEFSTSBJJ2QgZXhwZWN0IGFuIGFjY2VsZXJhdGVkICdob3N0JyBDUFUgdHlwZSB0byBoYXZlIGFs
bCBob3N0LQ0KPiBlbmFibGVkDQo+IGZlYXR1cmVzLCB3aXRoIHRoZSBhYmlsaXR5IHRvIGRlc2Vs
ZWN0IGZldyBvZiB0aGVtLiBJbiB0aGF0IGNhc2UsIHRoZQ0KPiByaXNjdl9jcHVfdmFsaWRhdGVf
c2V0X2V4dGVuc2lvbnMoKSBoZWxwZXIgd291bGRuJ3QgYmUgVENHIHNwZWNpZmljDQo+IChzaW5j
ZSB2YWxpZGF0aW5nIHRoZSBhcmNoaXRlY3R1cmUgcmVzdHJpY3Rpb25zKS4NCg0KQWdyZWVkLiBU
aGlzIGF0IGxlYXN0IG5lZWRzIGEgY29tbWl0IGNvbW1lbnQgZGVzY3JpYmluZyB3aHkgdGhpcyBz
aG91bGQNCmJlIGRpc2FibGVkDQoNCkFsaXN0YWlyDQoNCj4gDQo+IElmIHlvdSBuZWVkIGFjY2Vs
ZXJhdG9yLXNwZWNpZmljIENQVSBmZWF0dXJlIHZhbGlkYXRvcnMsIHlvdSBjb3VsZA0KPiBkaXNw
YXRjaCBpbiByaXNjdl9jcHVfdmFsaWRhdGVfc2V0X2V4dGVuc2lvbnMsIGV2ZW50dWFsbHkgZXhw
YW5kaW5nDQo+IEFjY2VsT3BzQ2xhc3MuDQo+IA0KPiA+ICt9DQo+ID4gKyNlbmRpZg0KPiA+IMKg
IHZvaWQgcmlzY3ZfdGNnX2NwdV9maW5hbGl6ZV9mZWF0dXJlcyhSSVNDVkNQVSAqY3B1LCBFcnJv
cg0KPiA+ICoqZXJycCk7DQo+ID4gwqAgYm9vbCByaXNjdl9jcHVfdGNnX2NvbXBhdGlibGUoUklT
Q1ZDUFUgKmNwdSk7DQo+ID4gwqAgDQo=

