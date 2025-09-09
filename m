Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1F3CA1016
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 01:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvnJh-00035w-Sc; Mon, 08 Sep 2025 21:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvnJb-00034T-U1; Mon, 08 Sep 2025 21:38:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvnJR-0007aB-GD; Mon, 08 Sep 2025 21:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1757381905; x=1788917905;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mJEgdrskcnfnBQcQ74KV75dCkJ8qSTZlSifxD+onwRg=;
 b=OtG+g7I3fxJY8njWRiS6DPL3RatFSWJX5TQa9RsFCMc2mBpM3vmp5/r5
 FY2m/eDY58kyqS9ElGOG6hHtohF/p+59EgxM15mN73Ad1RnAc6jRaEecu
 gGxeaekwdRa1Oy+RYs4tz6TEbcPGvqhklszhR9JtVORPWtzlZgd4M1zJm
 pn49lr29ZJ80ySjNT2Z35oEVIroREHKAGDXNWfDHvp3XTpV0nNTR3WSdT
 X6vyHEpSBF5tS917tr+NLtCoSVK6NvuL+dGvp9aja18gk0O2GYpaRcBcU
 qhPjsjBKndJgM4AmCUNXLqXKZFIp4eFtzi346i4vxomsPtc7+2Rbs/RR/ w==;
X-CSE-ConnectionGUID: WeYqJcQTQzqz7E8q8ySrSg==
X-CSE-MsgGUID: nEHMZ7BuSHKMoo6OoTox/g==
X-IronPort-AV: E=Sophos;i="6.18,250,1751212800"; d="scan'208";a="115199881"
Received: from mail-westus2azon11012066.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.66])
 by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 09:38:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKmNKovZ7iL3+SqYCGvEb/5u2JZEcYtWdIWRpWTRn71TMAocZ+l/8ifw55+fetuzZ02W4Zd5eTNw/sVPD9ZSQyAx9cgFmOxo0wmTwdwMCgWQCkaQ3Aq4yook07t5Aivd4sz21VP5Sh36Ri1zmyWgOPkcNhuSJwi2LBxntbX5sLC7+9PkZ/gMuffTw/TlHH3gmM8HqUihTL14FS7Efb7i8D7/0YUPnvcwiPGdj50usbgBc7mvrKhGvm5P4dmot8ELSieOiBOIRGp829IuvKiwJLaEa/QYEtj2p9jv9jBkgJezBVD8TSrHYRmic3POpdwd8DY/T7eCixUZX8J0aSbfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJEgdrskcnfnBQcQ74KV75dCkJ8qSTZlSifxD+onwRg=;
 b=pJnzQawU4Nqp6N6I7mlGmxj0pRc/56iWWvSWM0W5Rs0emQv6YR9myUI7XYQavi69Tkxon3Us01VaeHlzTb/GimDbHrOAC5UG6/RpXp8tUb5+dImestXT1AgPMpTohRAP0Bs2xpgNxdUNKRx7J7ip4oWxtG3TbhWt2CErrEfeCY5U82wcbRmtTjKZOx4wgMud/rZjcPH8uAXB6SUnqfwtimk2VVC5NGoezgrLQAs2eMErMQ5DY2Hpmnht+9AhtnuHIwi3dp25+oJNYLjTH5mQHXsHFFiJvpqCEdN+B6DTHLS6xd2EV5jI+2+XWnCpCO/hKAoCGDW6+3HhexTjnL9ldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJEgdrskcnfnBQcQ74KV75dCkJ8qSTZlSifxD+onwRg=;
 b=UHhBFTWR4KnsQ7Wgmvm5hd1uKrEE2sOBOO+UUFBTtSTRtIWXDkuEjkzWdHtwRhWuKwNGfaAQQ2+h8jrHkfbfYHcCOxNQ7Uiicq3EugL9TcaLIb5h0fVY0vxlm6Nt7YRhVS5wjqpagv+RV5RD1XmROhbMYTikKKaIYOL3UjDFJtQ=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by SA3PR04MB8716.namprd04.prod.outlook.com (2603:10b6:806:303::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 01:38:09 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Tue, 9 Sep 2025
 01:38:09 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Thread-Topic: [PATCH v4 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Thread-Index: AQHcHUnFOI3fJvPTwEadsr1eZ7PExLSC04iAgAdGrgA=
Date: Tue, 9 Sep 2025 01:38:09 +0000
Message-ID: <73aa800122044d2b8595965d4f25b89972dcb7b7.camel@wdc.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-7-wilfred.opensource@gmail.com>
 <20250904113121.00004f05@huawei.com>
In-Reply-To: <20250904113121.00004f05@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|SA3PR04MB8716:EE_
x-ms-office365-filtering-correlation-id: 954fcf17-d66b-4f06-bc9f-08ddef41884d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?K3FkOHFnSWRJU0EvTXg2SXBhcXJVS2g2Q2FWWC92dGxpbEF0NmNaSmJpNHY0?=
 =?utf-8?B?Y290MUVDRi9VTzNkRUxQZWRpdnhXT0VoTkpsWWJXbEprQTRqN0hmUkJiWnZM?=
 =?utf-8?B?dzRocXMrSGM0L1AwVU1kcGdRc1IySmEyNnJtMGFZRnVwMzBnT1FYY1Ftak0r?=
 =?utf-8?B?cVZVRjRyRm8yZ3FUSlhBNDJSdnQ3NWVIZHFrbWFxbzJTb1ZCdGVsTytVM3ZG?=
 =?utf-8?B?eXNyc0dONGg3SE1OMVNWa09tampyaFpoak5Jb2ppRkZwNDZxZUxXazl1VnU0?=
 =?utf-8?B?bHhQTlYzekE0YzQ4VjF3czlZdi9QYkxEckRPZWdSY1NpY0J1Zi9Bam5vY1o5?=
 =?utf-8?B?L0R3SVMzLzVRaXhWdzFwTGU1TkVTM0RZUlJHTjBJenIyazJVUXZnQnBhYm9i?=
 =?utf-8?B?LzRKRzA2TjF0d1RGVStVaS9JYXhwcUhlYm93V2pKQTFWdmFVQWhCSHhFTzgr?=
 =?utf-8?B?aFRESDRrWFNqbmdXcWtxbFRIcWptOTkxUjJjWHFGb3hqczEyOXVRelFBTmx3?=
 =?utf-8?B?WW5ocFdyYmlUbmdMZTlnN3BPSmNqNk90dWZ3SXZnOEY5QzVXbm4rM2liN1E4?=
 =?utf-8?B?VWlvWVA2c2hpd2tDR3E4RzZoOVJPUU9MOXo1enpVbmJGRHZ4MzVxWXNUNlQy?=
 =?utf-8?B?bFFVTk5XRzV0RHdjU05LVzdNd2xhcjlCaWxQQ2V1MGxUU05abkpmc1ZXVVBH?=
 =?utf-8?B?dEpzTUhnL0JtYkVnYWFZcDVPaE1TcXRDVjhuaHp1N0lZL1lrYWk1WGl4WXdj?=
 =?utf-8?B?UzQ1UVVZRDdYL1A2VU4ramJ1Q2t0UkFqdDNzMDdtYTJ3VlRFN051YVBzcjBh?=
 =?utf-8?B?bUJMaW9iR0dIRWRadmV1V0lRaXpwRWhTcTZhTCtIcmRuSlpBNVBUdFRnbDRS?=
 =?utf-8?B?MnBOS2lUWWRDM3ByTndoMWs2R2I0RDdWTisyWFRVdXhIc0IvWkxETCtnZVk2?=
 =?utf-8?B?dEhXRTh4MzRNc1pyWlhrb0ZjNW4zZFJnRWxUMEM0ckRQOEIwYjFrMHBYTzMy?=
 =?utf-8?B?N21LaVdKMzNVNUhFVDhlckZPRjc5TUNYNWJBUC9PdVJ3eDZzditBVEVFeXY3?=
 =?utf-8?B?cnpvSUFuYUxVNGlSbWNDVTJ6cUFrWmNFSVA3UStSWnkrdmwycVk3NXMvRGNl?=
 =?utf-8?B?K3F3aC8vK21DOVBSREdoWUhLd0NJc2prUGpQVjVXZkJzdmw3ZXVTMCtKSjU5?=
 =?utf-8?B?NlVhWUJRaWVHRk14d29peDFFMWNSWTUrUjNDaTB4V0pwZHg3QVIvQ0llcFY4?=
 =?utf-8?B?SzRBRE85b2YrRld4MGdlTUNtTVlvOWlubFdTc3BiMGVSNCtKY1NzZkhwY0wr?=
 =?utf-8?B?ZUJJWDlXOUFGRUhFNUpxL0ltejNCMi9IbGRWQTdPKy95WjZMTlY3RmRLQXh2?=
 =?utf-8?B?UlpVWXFzWG9aSERqRXNUZldZb0dDNThzU2FRU0xZL2F2VWVjeGFaT1NQYzRi?=
 =?utf-8?B?U0FkeDBTa2t1UHdUdSswQ21WQm5mVzR1cXZMYXJIQ2JGS09McElad2grQ0Rn?=
 =?utf-8?B?RGh1ZE5HMzVhRkkxSkJJVFFwcTl4bG9EbnhxZ3lHWWt3ZDA5ZklaTW1EckJl?=
 =?utf-8?B?b09VdXVDUG13cmFQaWllREZ0YVY0dDQ2WTdvdzlWU25vR2JoRmJ2MHRSZlhr?=
 =?utf-8?B?aGVvVVJ1UjJOdUFjdm9CNWNCNWZSdmh2bzVyUVJ1ZmxvNjhXRGFrTHBMSzQz?=
 =?utf-8?B?MFV5bW5ZRDdkTXNIS0lIcVhtYldQWkhWZGp4L0lDQXpnTGkwRUdsazVONDN1?=
 =?utf-8?B?Wm12c3dCR1JGSzNHSE5lQnQ0aG1yTmdvN2ZVYk85ZisrZGNUQ0FCd2grSXBV?=
 =?utf-8?B?czMwYkQ5dFdjb01XZ1dhckZPTWR3RExpWUNMR0ljcy9WUG9US1lIRzVLMjEx?=
 =?utf-8?B?S0NhblA0UXpxTldYWVYzVk1WeHg1cEswRjlWKy9rSmY1T0V6YWlHWWJSdWRv?=
 =?utf-8?Q?+xnTr+gR/Ds=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkcybzM3cGdtckc3UldhMHBrZlZYNERtSFVFTnJIa2NoMXBReklpbXdNcTF1?=
 =?utf-8?B?K3M5VW4xc1VGd0FtdmRPbmRROWMxaFdyYmN4bHhPMjdCblhnbUVBQjJjZXlN?=
 =?utf-8?B?aHhwNjhwNzd6WHBxcFVTdjZ4bFNWQzdxMVJpNlI1QUtBTm5lVFd1SFkzRHJJ?=
 =?utf-8?B?ek5yWmtMa0xjekJIVW5STDVBa2owRThteWIzUFRNQ0t3TVNjSHhoL09yN1BX?=
 =?utf-8?B?T2EzL29YUG1aZnlDNi9QVTdVRkVmdGl1UzBDVlpFVk0rdFVHMHBKdjZWZnZB?=
 =?utf-8?B?WUhHREI2RzJXejY3dUVZL01xdDhkTXdmeWdrUlJTRmtnUjRucXJlWGZUU1pL?=
 =?utf-8?B?VUFSckh6NkFJdllWR1hoSVc2Qllua2dwMHZ5d1ZFaHEwdE4vZzhadzh4SmZ3?=
 =?utf-8?B?Z21PNnRpUVc2eGEzbkJ6TUc5U0cydVRFSFVXRDdKUnpKV1k2aXZmZHFEYmUx?=
 =?utf-8?B?eHhtb2VDZU1DaWptbHhZcElnYkJiM3pYMTMzcTFMV3RCVjI2Sml5Z1JEZlNl?=
 =?utf-8?B?Mk9PYUpuRG9vcWE5TTlydWR3QTdwR1VZWHpDd0NodFY0cHJKOWFhc1l3ZlhN?=
 =?utf-8?B?R3dWWXg5enNWcEdqaE5jOHZha2I2a1Qxdkp6N09SNDZhV3hDZnpvN1lUSnJE?=
 =?utf-8?B?c0xwdU9ZR1pTTm9pd3BNemJXSER4QTBhR1J0NGhmbWtCZmhJTU11ZTJHTjR4?=
 =?utf-8?B?WURwYThEM0JHRUhkdDJTUnBNQnY1RlpDZngzWE9IOFRxd0l3UExKQ1NtQnNW?=
 =?utf-8?B?REtFVnBqVFF3RTdDOXloMUhTcnhZODdQUDZMaEJVNDZ4R1orQi8valpqNE9Z?=
 =?utf-8?B?dFpkdUc2WWtXMHR5UFpQaWZUUHhJSXZrUmtmOWFrOXluSitsNHNCaXZPQ2t6?=
 =?utf-8?B?dlVUT29peS9DeXJzSGFKeVFPQ2tQR1Iyd0x6bHcxdzc3WDNZWnZYR3p6Z0g4?=
 =?utf-8?B?SEhvdi9xQ29NWTJpcG9mZkRlVS83UEJvRVhKdXRXWTZld3JFM0ZjQ1lCc00v?=
 =?utf-8?B?RXdHNWFyWGJ6eHIzRXFRQndQQzkyK3JhL3hkcHNsbG0xZm04QU0yQjdaa1Fp?=
 =?utf-8?B?QUZVRmUrNmxRRnM4NEc1SnJpL25GTFgwM01STWlENkE5YmlzZ2dUVEY2U1pT?=
 =?utf-8?B?cW9scTRoOS9uZTgwWHNJOHhYMDJvSjdYTDFOaTNIOXRTQzBEOC9TY25yRE5j?=
 =?utf-8?B?TWJxRVk0Vk5PVzEyUEg4cWNCbmtMUzhoNWtqbldqdDdOMHIrQzY2eUkzRlJ3?=
 =?utf-8?B?WEhWWmh2TjhrYXZiT2w5WUh3RzlXSnpYdjNUQTI4SUVzaXN0Tk5ucXpuSkFr?=
 =?utf-8?B?cEhrYWQ3QkxpU01zajhsdytLeU9GdHlaeFpWWERKUmw0NW90Z0hNTFNlcGxv?=
 =?utf-8?B?L3lPdzRtZXdYVWhrdTB1bG9BdDN5S2ovTitLcG1OTzcwdXl2TExTYjZ5Uldo?=
 =?utf-8?B?UGwrR05UWkQxMzNzYlArTVY1YjFjcHU5K2xrQ2U4Vm03bER4cldKTXBXTzJq?=
 =?utf-8?B?aGR2cG85Mkw3MHBDWWl6aE0xV1dUTi94c3ZGSk5mNUkyWi9VOFBFc2xKQ25N?=
 =?utf-8?B?MHVhZVp4Q0RTL1JXY2pZRFU4ZGpvWHN3QnFBTjJTNlFyaW1nMmJDbEFVb2dT?=
 =?utf-8?B?UVpvNFdLVXNYOXhpUGttMmJjWGJwcmtMc1ZIejNmRVArc3VNd3AwbThTTDhX?=
 =?utf-8?B?ZmZLdWIzU01MeU9OL1lWUlREUitEVThndmxycVpqMC9yV01ZWEJOM2p4SlV5?=
 =?utf-8?B?Mm5UcEE3WW9oekN1SVdBaFVkUUtBT1p6c0w2cTlZWUZMZU5oWFduWEVFWXRv?=
 =?utf-8?B?M0hSdmRWSDNoSE5yb0dXanRxV3VTNk1TT3phRFNjTmIvYTNna1ZsUmZneXBP?=
 =?utf-8?B?MmlMd3ZGOWRKTVk5RU0za3dBUkdyQlNTZUl4UW4vRHlTTnl1VWs1TGd0ejU4?=
 =?utf-8?B?L1A0aDg4U2FXWjNlNmxZRmtvc0tSekx0bFdvQ0VyOEZ4M1pFQmo3Wk9aYmtK?=
 =?utf-8?B?TjY5dDhETENkSVBPNGlsQVNEVldRRTg1RmVzQlNySXUrdld2Wk9UdWtITkw1?=
 =?utf-8?B?K3AxcXE0REtLTTh0SHRjS2pJYzN1TVh1Z0lVNHdNWHl1ZU5tU09CRFBtdDlz?=
 =?utf-8?B?TEMyTUlGcStHOUx5UVFOUzhyMVhYQUVlK2xnSnMycmU4WmF5a00vM3dRZERu?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E883B01C46ADB94B854843C8D24E7AA2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0EObICnj+qHO+GhNecHKIdYZpTXrcoaMg7T8ZILcXaToBVpUqSJM+eUPD061u3bF3Pa3NF5U+W1FmxU/ru5YQl06LLNpSYLwp296j554lqpZnBRCN6AAW7hs5Q4s+7QHvf8UlnRL/AVw4AgvmXbW1wBIJWsI2oxrC/KHph1gbCNjRUajsdQb1EyLtddUEQZTY28xRfKeKOaetvrzYut3O66IQCwlBheS9GUB9bdYT3DQNnFK7fbIWLRDYBLxkUhhHbAnrCipqvlOvhO5AEYI2hoivpdqYt74oXakeDpLxQv+cpEgzA03Bu3+CW14QjO4VmiNy3n58PDL1GL6LKCua3bd24ea3TfxYLk0zGFbf3h0Zou8JYqlxTwa7CSGzXsAn/4gy76kDWwhIfjhimiWBC44VhWZWX7Q3fmY3jnPQ47W5YEUUldTQiiXULkFvSzr0Wn0KMneiQQn3cU3go0G7B2kwvF4Iu0TwOYdO6yZCkcT99syIu1sqHb8vzGRAYzgt4CDwkezT+s1tK7YHp5G4jMr0HUDptbvfv6qkzRB+ifQK8teqyWJXJePDC/ZLm8G9+KsyyXGxlnEZ+9Pp99lW/Us/V3mghlMvYZES/hQig11hc9zPXxrnpyuSo17fKwb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954fcf17-d66b-4f06-bc9f-08ddef41884d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 01:38:09.4641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJTS3N07YzJBxj3nQc42IazcqM66r+70NW20ixP9Gna3Lomvm0CoAwlSsSVrrvvMez+SUmGNSWijXW6dYV0EMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8716
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=340207e43=wilfred.mallawa@wdc.com; helo=esa6.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDExOjMxICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KWy4uLl0NCj4gDQo+ID4gwqBBdCB3aGljaCBwb2ludCBRRU1VIHdpbGwgdHJ5IHRvIGNvbm5l
Y3QgdG8gdGhlIFNQRE0gc2VydmVyLg0KPiA+IMKgDQo+ID4gQEAgLTExMyw3ICsxMTMsMTMgQEAg
b2YgdGhlIGRlZmF1bHQuIFNvIHRoZSBlbnRpcmUgUUVNVSBjb21tYW5kDQo+ID4gbWlnaHQgbG9v
ayBsaWtlIHRoaXMNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIC1hcHBlbmQgInJvb3Q9L2Rldi92ZGEg
Y29uc29sZT10dHlTMCIgXA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgLW5ldCBub25lIC1ub2dyYXBo
aWMgXA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgLWRyaXZlIGZpbGU9YmxrbnZtZSxpZj1ub25lLGlk
PW15bnZtZSxmb3JtYXQ9cmF3IFwNCj4gPiAtwqDCoMKgwqDCoMKgwqAgLWRldmljZSBudm1lLGRy
aXZlPW15bnZtZSxzZXJpYWw9ZGVhZGJlZWYsc3BkbV9wb3J0PTIzMjMNCj4gPiArwqDCoMKgwqDC
oMKgwqAgLWRldmljZQ0KPiA+IG52bWUsZHJpdmU9bXludm1lLHNlcmlhbD1kZWFkYmVlZixzcGRt
X3BvcnQ9MjMyMyxzcGRtX3RyYW5zPWRvZQ0KPiANCj4gSSB3b25kZXIgaWYsIGZvciBjb21tYW5k
IGxpbmUgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgd2Ugc2hvdWxkIGhhdmUNCj4gYSBkZWZhdWx0
DQo+IG9mIGRvZSBpZiBubyBzcGRtX3RyYW5zIHBhcmFtZXRlciBpcyBwcm92aWRlZD8NClllYWgg
Z29vZCBwb2ludCwgSSB3aWxsIGFkZCB0aGF0Lg0KDQpSZWdhcmRzLA0KV2lsZnJlZA0KPiANCj4g
PiArDQo+ID4gK1RoZSBgc3BkbV90cmFuc2AgYXJndW1lbnQgZGVmaW5lcyB0aGUgdW5kZXJseWlu
ZyB0cmFuc3BvcnQgdHlwZQ0KPiA+IHRoYXQgaXMgZW11bGF0ZWQNCj4gPiArYnkgUUVNVS4gRm9y
IGFuIFBDSWUgTlZNZSBjb250cm9sbGVyLCBib3RoICJkb2UiIGFuZCAibnZtZSIgYXJlDQo+ID4g
c3VwcG9ydGVkLiBXaGVyZSwNCj4gPiArImRvZSIgZG9lcyBTUERNIHRyYW5zcG9ydCBvdmVyIHRo
ZSBQQ0llIGV4dGVuZGVkIGNhcGFiaWxpdHkgRGF0YQ0KPiA+IE9iamVjdCBFeGNoYW5nZQ0KPiA+
ICsoRE9FKSwgYW5kICJudm1lIiB1c2VzIHRoZSBOVk1lIEFkbWluIFNlY3VyaXR5IFNlbmQvUmVj
ZWl2ZQ0KPiA+IGNvbW1hbmRzIHRvDQo+ID4gK2ltcGxlbWVudCB0aGUgU1BETSB0cmFuc3BvcnQu
DQo+ID4gwqANCj4gPiDCoC4uIF9ETVRGOg0KPiA+IMKgwqDCoCBodHRwczovL3d3dy5kbXRmLm9y
Zy9zdGFuZGFyZHMvU1BETQ0KPiA+IGRpZmYgLS1naXQgYS9ody9udm1lL2N0cmwuYyBiL2h3L252
bWUvY3RybC5jDQo+ID4gaW5kZXggZGY3MjU5OWJjYy4uZTQ4NWUwNTg0ZSAxMDA2NDQNCj4gPiAt
LS0gYS9ody9udm1lL2N0cmwuYw0KPiA+ICsrKyBiL2h3L252bWUvY3RybC5jDQo+IA0KPiA+IEBA
IC05MzA4LDYgKzkzMjYsNyBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgbnZtZV9wcm9wc1tdID0g
ew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYWxzZSks
DQo+ID4gwqDCoMKgwqAgREVGSU5FX1BST1BfVUlOVDE2KCJtcWVzIiwgTnZtZUN0cmwsIHBhcmFt
cy5tcWVzLCAweDdmZiksDQo+ID4gwqDCoMKgwqAgREVGSU5FX1BST1BfVUlOVDE2KCJzcGRtX3Bv
cnQiLCBQQ0lEZXZpY2UsIHNwZG1fcG9ydCwgMCksDQo+ID4gK8KgwqDCoCBERUZJTkVfUFJPUF9T
UERNX1RSQU5TX05PREVGQVVMVCgic3BkbV90cmFucyIsIFBDSURldmljZSwNCj4gPiBzcGRtX3Ry
YW5zKSwNCj4gDQo+IEFzIGFib3ZlLiBJIHRoaW5rIGEgZGVmYXVsdCBpcyBhcHByb3ByaWF0ZSBo
ZXJlLg0KPiANCj4gPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJjdHJhdHQubWVtIiwgTnZt
ZUN0cmwsIHBhcmFtcy5jdHJhdHQubWVtLA0KPiA+IGZhbHNlKSwNCj4gPiDCoMKgwqDCoCBERUZJ
TkVfUFJPUF9CT09MKCJhdG9taWMuZG4iLCBOdm1lQ3RybCwgcGFyYW1zLmF0b21pY19kbiwgMCks
DQo+ID4gwqDCoMKgwqAgREVGSU5FX1BST1BfVUlOVDE2KCJhdG9taWMuYXd1biIsIE52bWVDdHJs
LA0KPiA+IHBhcmFtcy5hdG9taWNfYXd1biwgMCksDQo=

