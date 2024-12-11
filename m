Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC09AE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLFtq-0000hC-0W; Wed, 11 Dec 2024 01:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tLFto-0000gs-3i
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:08:40 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tLFtl-0005bM-Ar
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1733897317; x=1765433317;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=sGrpSwROmQ8Vq/3wXm9D5qUvrZ4/XY+lTps0MsuF7QA=;
 b=ryEwuTOBw7Cet7l63yoNGcqKMPlI980lDYV4Vpuv29of6plasn3CgOZn
 TMNL1Hh7tpjnJxEL+3Z/oV0BZSX781Xo18bC+/wfNR6oWD6bLq2Riv714
 xrTzL1whAqXHFtL6MIpPRkDj3ZyIMfS0kbsb7SDGCO8wVJcuoujvlgtqb
 fUUeE73qEMIXuA43bb06ZGiGUpJgmaHz+8Fb3x6MvZKl+yjSToIxSUcag
 Hc/MjbzhaBZDQ0AR9bSeMYsOa2GFU+w3UbfScaSHAEnI6w7hIurJRGZcf
 mvXUbw9lbwwjQBDKKLy4X1I2mNAtR5i7H3HXZH2iXoPPhTG5GdB2avHK2 A==;
X-IronPort-AV: E=Sophos;i="6.12,224,1728943200"; d="scan'208";a="27280698"
X-MGA-submission: =?us-ascii?q?MDFylsyAPNAB2xWkLY4QhaSGBBOsk6X5gdLDV4?=
 =?us-ascii?q?O2D0/IJaLVRc2Vq3auWqTa6LdiEJM1IQjeqhG4+F95S5Sym+C0MO25kI?=
 =?us-ascii?q?AEd8trCJi2H8JiWuCM2tmBD7qET/j6jsSZ6Hf8AyY5DXF6WUy2ISfqNF?=
 =?us-ascii?q?E/5TtgpamgSro9kmoC0hyGVA=3D=3D?=
Received: from mail-am7eur03lp2236.outbound.protection.outlook.com (HELO
 EUR03-AM7-obe.outbound.protection.outlook.com) ([104.47.51.236])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 07:08:10 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz3O/pKBMgCid+jGIy268qmveerQBVeZ3U2t1oQ/UcmaWX2N321yGn8J4SlDyrJcr5E4XhKz6qBiTt2D1hn4djfwFnDE3kc9YmPG+zlMy14cR/ScsFut4Y3+d18nMAOAkJx8o/ybthU3youVeKHXMLqvE/rmFkVx99I/YcTpGhYSDmICTCeS5vsjZoxw63PADoJYp4POT8VeYNGkf3/BmNu9VKz1tE6jtlXQEM8yO72oVQ3zQAu8rYOU9PJVqMuO/7v8Rst/8Eh6LvZcAl2obOiUsdRuS00Xh/Wzjbn56qEt5oN9RL8AflD3/NcRa9PdV7Akn0V7NWx+qhMki2PLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGrpSwROmQ8Vq/3wXm9D5qUvrZ4/XY+lTps0MsuF7QA=;
 b=Z2P5KxaXhRjJPTVFqzIFPpBAbHsWPRycDDblOCwGabj4afNVkjJQR1hGJZ8Gk5gZXnlXMUo7BXc70ai0TyDam0eVGL1c+zvbWWpwOAD9QPT3tr3Bp+5uDY4z9poIVZC00hRGjCWgzmPXSnV0hZtcicAF2DHdz0vShvFzpfTx2eugvEfZcU+0tHLIUCh4nH9l+0hlCGQYQgH8DWuXwdgzywGvMPqCP/oXweT28F/JJVD0UrhdFp3MYifo8+2VP+OfzirE7FLaoXhyb8ARMSw+cb1xymXmcFgD2iA5pqitW6rAqhC/FbgfV/thSuzihQLGhW4wMCDYInFfbIEP36G78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGrpSwROmQ8Vq/3wXm9D5qUvrZ4/XY+lTps0MsuF7QA=;
 b=PhZMlqQNAKtGs8l1ILfmIeH1yWT1zOBZMPsVTrNqmpCakGAD+2eVUMk7yFgFdoF8WfKKXLGqDVwRjd6pJyZ0usVxI0yKOBQEaNe9+oTC0zMmqHdMBmiCuQZHkHiSzniJg30cTE9UG6RsAzj0LUdrIMn46t/XD4Fimp3yUwINMhHeGPJB4xaRetw+d7J/Du4rLdgjbSUHV2OfYsMoJEubdu41IL/Gb2ZS88L+0/qd3doJexwqKJ9p+D4NmDKFnWipjBUY4Jd1OkyjUMIsejJxCX4kTQpCZkyg5Q5Cg8UFEHlVI89TVqb1/24fiY7mncJqBOTKtsKnb0rdSR8LlH5jMw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7351.eurprd07.prod.outlook.com (2603:10a6:20b:28a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 06:08:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:08:08 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Jason Wang <jasowang@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBU5r5oNBkqzVUqCcHjZN6/EL7LVkrqAgAAsh4CAB6k4gIAAMqgAgAACyICAAATsAIAC3BEAgAALlYCAADNmgA==
Date: Wed, 11 Dec 2024 06:08:08 +0000
Message-ID: <acfe82fe-f87e-4059-afd2-f59a1092d660@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
 <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
 <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
 <68d3a523-19c4-4296-9df8-b98b498d4c0e@eviden.com>
 <CACGkMEs0xTf+YeCWmBbyJaQSS2RzBe2pBYzrv3n_mW+6EV4few@mail.gmail.com>
 <bb7df163-e3fe-4d26-93c2-756a7b6be15a@eviden.com>
 <SJ0PR11MB67442853FBF1FAD572A3CC37923E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEsRHytcZkR8OcK7cEiAordK9+EcG4Kei0RpABGApnBY4w@mail.gmail.com>
In-Reply-To: <CACGkMEsRHytcZkR8OcK7cEiAordK9+EcG4Kei0RpABGApnBY4w@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7351:EE_
x-ms-office365-filtering-correlation-id: b03b8a80-59f3-463c-5aa5-08dd19aa2f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TnhtT0p4V3VkOWlQVWNycElMdEFkQ2w0c0JkQ1E0dnM3ZVYwMWZaTlpWVFF1?=
 =?utf-8?B?QmNDazNMVzdzUVl2emk0UStLbVRwaEJLQVBRSURNenVJVGV6Vkw0TzZVc1JS?=
 =?utf-8?B?T3BYSTk3K1JwK0xWK093WldDMnYzOWt1Q0hoT1NBdmE0dmNOeE94YjduZnRH?=
 =?utf-8?B?VnEzd1luVDhDYUZBQ3J6dzBvM0ZyVTRVa0Rtc1kxSkRJVmVQdG5jVXgzNEw3?=
 =?utf-8?B?b09wSE9QMTNmMCs1STlHOUJHYjZhb3FyRmtCRTJxb1A3UDM3SVNHenVOM0g5?=
 =?utf-8?B?ZnU0SHRJVFJFSXppVUkvWW1VYTR3ckx1NFg5MTNHTFo3VmozVUxNbDM4MGhz?=
 =?utf-8?B?ZnJWKytQSDZ1cWJ3RzNhcDZOdkpYTUJ6MW1UYXZ3RzBaMlBMQ1lDK0dGV3o2?=
 =?utf-8?B?d0hwR2FFZjR3clFMRm41K2ovVjBZL09PbUo3TmMzOUxUd2NTQ2Uvc0RsRVJz?=
 =?utf-8?B?VmZHSVhGQVMxdUdSQjM5SzBQdVN4UlJkRVNrK2tTK0x3cDdRbGc3cG9uZG5a?=
 =?utf-8?B?WkEySEgwQzk2K0pKR1M3SW1hWHN1Sk9kUnhBeVVlTTFBWnJUWCt5NGo2VEhL?=
 =?utf-8?B?cUZEZDNTSi9uazhkQVNVcU9xS0ZGcVNkS2FMUnErc295Q2VJVW1hdFhXc0lt?=
 =?utf-8?B?UldxamhUSU11NXNPdFRFaGZCNGhpZFI5N2xYZzVkbHFFYmZhSldxOGY3aDU1?=
 =?utf-8?B?eVRmNTFvd2tBUTN4aUhqVkhqMXMxY0JXUjkzZDZpalVjSjVjS0lwbzZ6TWQr?=
 =?utf-8?B?MDVDMXgzb0pPelJXWWdjM1ZHYjV2RmdKeHBoSC90SnlSb1pLV0RuS3AzS0dt?=
 =?utf-8?B?Skh1Wk5yYVkwZ2lpbzhhbEFYQXBPcUZWKy95V1N0dldhSlNzazJFd0RBenp2?=
 =?utf-8?B?ZXBET1NpTkt1cHM2NlI5M29EK3l4anBscXNPWGF6STRjZ2YxWmJXTkIwaFZR?=
 =?utf-8?B?ZHVvRXNDdFVmL0llL3kwWVovV3Z4S3psU0lIUDNPUnE5ZCtGQnErcHRmRGF0?=
 =?utf-8?B?c0VrWnpzQnd6TzJaaGREZWFsaGhOejVnYmdvVzFyRzBqWE1aQzhxdEFzSDR3?=
 =?utf-8?B?QlFKYUZyQndNUHc4Yi9DVEtWS0Z5eFhvdk9ROTJPK3JSWkZ0cFVqOXFkZTV3?=
 =?utf-8?B?TzdrZFlIY2k3MkRnRmJCM082ZEkwVUM5MTdNK3g3ekpxMWxuaUptYlY4R0Ru?=
 =?utf-8?B?c3Eva09WMmszQXh6TU0raTByQ0FPWm5JNC9ob2M0bE9qcWUweXFQWm10dGgz?=
 =?utf-8?B?bExxTkJkbExJN1dOdGRJakRUdnh1SDhXaWtnNUMrdW4veUdOeTFuMEZ5OTlF?=
 =?utf-8?B?NUFYQXJraHlJQnhab0liUlNvUDRDUExYblg4bHF3dzcwanpjelhscTd0eFNp?=
 =?utf-8?B?bllaZjFQdmV0VkVscFJvVlpUSzJFRmJOMW04MEFTVzFpeHhLaXRJUm1GRVA5?=
 =?utf-8?B?eGlkZ1JDUnM3cTdkQUFSNFR6N3BlMmxYeFl3Z0pZRDFnK2xlSGNpdUJrK3lV?=
 =?utf-8?B?K3I2VExDOEthQ2FRQi9MTS8xN2JvVEhvQ0dJK2lGcXZYWTdGdDlQTU1hWTRI?=
 =?utf-8?B?WWREYThxanA4anJBd2lZc3J5a0U0Z05DOTRKK2phOGpHNGxZVWVzOGZWMEdl?=
 =?utf-8?B?NGhKTWRHL3lFdW1HdnVob2RNSlZVd3ZtN3VUYWVrTk5GaGF3RlpwNDJ6aEU4?=
 =?utf-8?B?bXY5bHFlN0QxWmdBcGJFcXh5UllpQ3llMTBNWWFGZVI5M01HQ2hncTlpNFM0?=
 =?utf-8?B?WUVUNXhvWFVTOURSR2xVV3U0MFF0c0VtdG94azU0cUtVeXJrZDQyMGM4YVZU?=
 =?utf-8?B?SU5kVjJ1Wmh2a2tGTktaTjFMYUJFcnZDS0V5azlyWUdsdjhhWlgwSGJIMEEz?=
 =?utf-8?B?c1NjNFZzM0dwV1QxYkl2YTBtczFjelhkb0lkUGdac0RSRmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1XMG56cHdvVmR4ZENxV09VSE9USm05dDJ6NUdiYXozdFdmRUhCaXF6MTNa?=
 =?utf-8?B?UTRxSTIybEhyZk1qVENRRzJIQ3hXeFRPcG9yNFNUM0ljeFEyblV5UGh4Umc4?=
 =?utf-8?B?M1UwVVBlMmpoaFpFK296VTFIU0c3UUFSNktTSXMrNTJZY09KZzFsYlk0ak0r?=
 =?utf-8?B?Sy8vMkw4SEs1V1k2VGczS3BoWnIyaFp0M1RNSkhvRVBFSnk5eWVwK25MbGJw?=
 =?utf-8?B?VFgra1E5QnFtOTJRNlZ4a0Q0ZnQ0Y0R5RUpQZHNsTkxXQkFKZ0FrRDhhdldG?=
 =?utf-8?B?OEFrQURKUFJFV0owZitETWtSTTJkNVBIMnhxS3pGUWR4VlNOb0M0aVlyZm1E?=
 =?utf-8?B?QUd1RFpIUldvQ2hVK3lqbnYrWkFNcjdXYmxZT1pSSk94cVdJMzBVNUxUZ0tH?=
 =?utf-8?B?Q0VPVWJNczFvdVQ0NDM5MC8waTNtRG1DM2VRU09SWjhaYVFhMHdoQTF4RTJJ?=
 =?utf-8?B?OTRQNElYaWlBNmZ4TndDQVlLeHZrSXpZMHJObS9DRVF5TUdXMTZLQ0NzV0NE?=
 =?utf-8?B?MmsyZGM5cTEzemhob1M0WUJsUUR6eW1LWW56QVU5aHRTa1lIc25MV05tWklu?=
 =?utf-8?B?aWFZUTlWcjR3Qlc2MXAwbzNZdHd4anY2UzJSYXdxcGZOQ21kazhyRFBxeThq?=
 =?utf-8?B?c0JaL1RLK045SmlJUXZabVFVYlU5VFpldytWOVp6QzJtb3hwOEVTWUxwRU5i?=
 =?utf-8?B?TjZFQ3FOb0RTT3FzdHFrMTgycnJEbEVYdkd5eGJ2SjErNGlkcnJnbW94bmdD?=
 =?utf-8?B?RzZnNThTOE1JWS81c3FkYTVFbFBGeXJOZ25TdGhSRmFYNnRoWFh0b01PL1NX?=
 =?utf-8?B?WlprQ3dFbVQ0dUY1azkzc0NlWEkrNENxcVdWOG4ySkk0UmJmUlVCbVNQc0Zh?=
 =?utf-8?B?QWRYQTdNRWdlVkFROE1kcXNVOCtxYzN5d0gvZ3FNMUo5VkVuaWRlK2NQSjVF?=
 =?utf-8?B?K05iOXpnb0FtV0tOYUdNd1BJNHJjV0xlWjkwSlU4bmhFMEVLbk1ibGNvUWtS?=
 =?utf-8?B?anVmaWtGK0ZoaG4wM3R5ZllMNU0vSmhZSGk0MjRhNWZsSWdNMVZTdkp4aUF4?=
 =?utf-8?B?L2dESEIyamZ0UjBISFpRTzdWdW50ZXpVMVFWanczNVRISjlqcm14RUV5Wkha?=
 =?utf-8?B?YkpyU1l6OU5nWnJ2LzF3WUVGanlKWWNJWldiWmd2TlpsTGRoTHRvWWNaOUM1?=
 =?utf-8?B?V2pNby9vMEpXMkJPV3Q5WXhvUlZQdmdCV3JkdjFXc05jZEdXMEFSN3h2RlAz?=
 =?utf-8?B?ZUtUbGk5S2xVOWlQWHY3ZjVMSnJnbm5Ub3pxMHdKdUZod2dGbElqenkvSlU0?=
 =?utf-8?B?WitUSGtlWFlldFo0TmVaS3RFUDF5bzVFY1VJbzdOdEZ1SU95bEZnQ0k5WmFj?=
 =?utf-8?B?VnlJbXV2eFFRVzNyNkppbjE3TW1zRDhZbUkrcloraVk4SjNLbDBCc29JSk02?=
 =?utf-8?B?aEdxanJuSFphNVBuSU00eDgwMURuSGpyRjE3VVI1MCt2ZWd1M2VRcVZoRm1E?=
 =?utf-8?B?WUlVckhtaklOQVhsbVpkeThXamcvcUlQeEpSbmN4c3ZvdEduUXBUcTNhenly?=
 =?utf-8?B?ZXRMVnhVbTNqdGU5M3FvSzZma3Z0bmFsMnBOMTh5RTNWTkRNQkcvVUg3RHdP?=
 =?utf-8?B?c0RFbkRieXNrUk5UQlY0MEMweC9CSEVpMzI3ek9SZUkwN2dPRTgyK2FkVXM3?=
 =?utf-8?B?QjdGUytqKzFuZU5Ydjk0TUZuN0tHNE1hYlgxaXRJZi9ucHhtc0xvZzJpVnA1?=
 =?utf-8?B?TWxNL2tIN1ROWjRiT2paQkFkY29kSDZFVDgvblJwV1Y1SHdaN1BPU1QyWHVT?=
 =?utf-8?B?THU0aWJ3a08zSy8xZGRCb3dkb1k5UWtZU0NValBDSnN6SUhSVGxuZ2Frc2dr?=
 =?utf-8?B?Y3g3UnoraW5HaUdTcTJEVVU3M0tXUzg5Sldsd2lsNitweXV6WUZKc3RncUl0?=
 =?utf-8?B?a2daWmhkUWRKQWdzWTB1WXlXZXVNZ1hpLzlEdHp5MVFpd1lVZEVlRTN3MHRR?=
 =?utf-8?B?elFVbXBrdWdhSFZhYnNHSU0vUXdsNHJpRC8vQ09qTXorWGR3cUJaT0EvcGFZ?=
 =?utf-8?B?N3dPK21lUVNSZzZPUDlPL1dNVWF0bUNuMXYzRTFZYUZQTGd4YVBFSFZNMXlS?=
 =?utf-8?B?NEtHdlE5MVNJbG1zanNPTUpiS1daUFV6TjRHTE9aQkViWklxTkJXOEVCWVRC?=
 =?utf-8?Q?PfBcqy4Hguc2IfeBCeKgNzs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A3553ED7EBB9045A3E7350AD8594FA4@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03b8a80-59f3-463c-5aa5-08dd19aa2f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 06:08:08.2400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1I476n3P57zEwXm0/FYEeRdTPuziS3f+i5/wpfWY3DMj7/SPTq1LKCxmtwbkr+I5OSzgIpSJXLWN7+KXlVOhXElivCIu4e5uGKq40JxNBVz178JWxBPdptXpNojIlL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7351
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCg0KT24gMTEvMTIvMjAyNCAwNDowMywgSmFzb24gV2FuZyB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBXZWQsIERlYyAxMSwgMjAyNCBhdCAxMDo1
MOKAr0FNIER1YW4sIFpoZW56aG9uZw0KPiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90
ZToNCj4+IEhpIEphc29uLCBDbGVtZW50LA0KPj4NCj4+IFNvcnJ5IGZvciBsYXRlIHJlcGx5LCBq
dXN0IGJhY2sgZnJvbSB2YWNhdGlvbi4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTgvMjBdIGludGVsX2lv
bW11OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB4LWZsdHMgZm9yDQo+Pj4gc2NhbGFibGUgbW9kZXJu
IG1vZGUNCj4+Pg0KPj4+DQo+Pj4NCj4+Pg0KPj4+IE9uIDA5LzEyLzIwMjQgMDc6MjQsIEphc29u
IFdhbmcgd3JvdGU6DQo+Pj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBh
dHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj4+PiBlbWFpbCBjb21lcyBm
cm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+
Pg0KPj4+PiBPbiBNb24sIERlYyA5LCAyMDI0IGF0IDI6MTXigK9QTSBDTEVNRU5UIE1BVEhJRVUt
LURSSUYNCj4+Pj4gPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPiB3cm90ZToNCj4+
Pj4+DQo+Pj4+PiBPbiAwOS8xMi8yMDI0IDA0OjEzLCBKYXNvbiBXYW5nIHdyb3RlOg0KPj4+Pj4+
IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGlj
ayBsaW5rcywgdW5sZXNzIHRoaXMNCj4+PiBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVy
IGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+Pj4+DQo+Pj4+Pj4gT24gV2Vk
LCBEZWMgNCwgMjAyNCBhdCAyOjE04oCvUE0gQ0xFTUVOVCBNQVRISUVVLS1EUklGDQo+Pj4+Pj4g
PGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPiB3cm90ZToNCj4+Pj4+Pj4NCj4+Pj4+
Pj4gT24gMDQvMTIvMjAyNCAwNDozNCwgSmFzb24gV2FuZyB3cm90ZToNCj4+Pj4+Pj4+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMNCj4+PiBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IE9uIE1vbiwg
Tm92IDExLCAyMDI0IGF0IDQ6MznigK9QTSBaaGVuemhvbmcgRHVhbg0KPj4+IDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+IEludGVsIFZULWQgMy4wIGludHJvZHVj
ZXMgc2NhbGFibGUgbW9kZSwgYW5kIGl0IGhhcyBhIGJ1bmNoIG9mIGNhcGFiaWxpdGllcw0KPj4+
Pj4+Pj4+IHJlbGF0ZWQgdG8gc2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBh
cmUgbXVsdGlwbGUNCj4+PiBjb21iaW5hdGlvbnMuDQo+Pj4+Pj4+Pj4gVGhpcyB2SU9NTVUgaW1w
bGVtZW50YXRpb24gd2FudHMgdG8gc2ltcGxpZnkgaXQgd2l0aCBhIG5ldyBwcm9wZXJ0eSAieC0N
Cj4+PiBmbHRzIi4NCj4+Pj4+Pj4+PiBXaGVuIGVuYWJsZWQgaW4gc2NhbGFibGUgbW9kZSwgZmly
c3Qgc3RhZ2UgdHJhbnNsYXRpb24gYWxzbyBrbm93biBhcw0KPj4+IHNjYWxhYmxlDQo+Pj4+Pj4+
Pj4gbW9kZXJuIG1vZGUgaXMgc3VwcG9ydGVkLiBXaGVuIGVuYWJsZWQgaW4gbGVnYWN5IG1vZGUs
IHRocm93IG91dA0KPj4+IGVycm9yLg0KPj4+Pj4+Pj4+IFdpdGggc2NhbGFibGUgbW9kZXJuIG1v
ZGUgZXhwb3NlZCB0byB1c2VyLCBhbHNvIGFjY3VyYXRlIHRoZSBwYXNpZA0KPj4+IGVudHJ5DQo+
Pj4+Pj4+Pj4gY2hlY2sgaW4gdnRkX3BlX3R5cGVfY2hlY2soKS4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+Pj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4+ICAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgIDIgKysNCj4+Pj4+Pj4+PiAgICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAg
ICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4+Pj4+Pj4+PiAgICAg
IDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+Pj4+IGluZGV4
IDJjOTc3YWE3ZGEuLmU4YjIxMWU4YjAgMTAwNjQ0DQo+Pj4+Pj4+Pj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+PiAuLi4NCj4+Pj4+Pj4+PiBAQCAtNDczNyw2ICs0NzQyLDExIEBAIHN0
YXRpYyBib29sDQo+Pj4gdnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJv
ciAqKmVycnApDQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgIH0NCj4+Pj4+Pj4+PiAgICAgICAgICB9
DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiArICAgIGlmICghcy0+c2NhbGFibGVfbW9kZSAmJiBzLT5z
Y2FsYWJsZV9tb2Rlcm4pIHsNCj4+Pj4+Pj4+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJM
ZWdhY3kgbW9kZTogbm90IHN1cHBvcnQgeC1mbHRzPW9uIik7DQo+Pj4+Pj4+PiBUaGlzIHNlZW1z
IHRvIGJlIHdpcmVkLCBzaG91bGQgd2Ugc2F5ICJzY2FsYWJsZSBtb2RlIGlzIG5lZWRlZCBmb3IN
Cj4+Pj4+Pj4+IHNjYWxhYmxlIG1vZGVybiBtb2RlIj8NCj4+Pj4+Pj4gSGkgSmFzb24sDQo+Pj4+
Pj4+DQo+Pj4+Pj4+IFdlIGFncmVlZCB0byB1c2UgdGhlIGZvbGxvd2luZyBzZW50ZW5jZTogIngt
Zmx0cyBpcyBvbmx5IGF2YWlsYWJsZSBpbg0KPj4+Pj4+PiBzY2FsYWJsZSBtb2RlIg0KPj4+Pj4+
Pg0KPj4+Pj4+PiBEb2VzIGl0IGxvb2sgZ29vdCB0byB5b3U/DQo+Pj4+Pj4gQmV0dGVyIGJ1dCBp
ZiB3ZSBhZGQgbW9yZSBmZWF0dXJlcyB0byB0aGUgc2NhbGFibGUgbW9kZXJuLCB3ZSBuZWVkIHRv
DQo+Pj4+Pj4gY2hhbmdlIHRoZSBlcnJvciBtZXNzYWdlIGhlcmUuDQo+Pj4+PiBIaSBKYXNvbg0K
Pj4+Pj4NCj4+Pj4+IE1heWJlIHRoZSB3ZWlyZG5lc3MgY29tZXMgZnJvbSB0aGUgZmFjdCB0aGF0
IHgtZmx0cyBvbiB0aGUgY29tbWFuZCBsaW5lDQo+Pj4+PiBpcyBtYXBwZWQgdG8gc2NhbGFibGVf
bW9kZXJuIGluIHRoZSBjb2RlPw0KPj4+PiBZZXMsIGFjdHVhbGx5IHRoZSBjb2RlIGNoZWNrcyBp
ZiBzY2FsYWJsZSBtb2RlIGlzIGVuYWJsZWQgaWYgc2NhbGFibGUNCj4+Pj4gbW9kZXJuIGlzIGVu
YWJsZWQuIEJ1dCB0aGlzIGlzIGluY29uc2lzdGVudCB3aXRoIHRoZSBlcnJvciBtZXNzYWdlDQo+
Pj4+ICh0aG91Z2ggeC1mbHRzIHdhcyBpbXBsaWVkIHRoZXJlIHByb2JhYmx5KS4NCj4+PiBXb3Vs
ZCB5b3UgcmVuYW1lIHMtPnNjYWxhYmxlX21vZGVybiB0byBzLT5mbHRzPw0KPj4gU3RhcnRpbmcg
ZnJvbSB2NCwgd2UgcmVwbGFjZSB4LXNjYWxhYmxlLW1vZGU9bW9kZXJuIHdpdGggZmx0cz1vbiBv
biBRRU1VIGNtZGxpbmUuDQo+PiBTY2FsYWJsZSBtb2Rlcm4gbW9kZSBpcyBhbiBhbGlhcyBvZiBz
dGFnZS0xIHBhZ2UgdGFibGUsIHNvIEkgcmV1c2Ugcy0+c2NhbGFibGVfbW9kZXJuDQo+PiBpbiBj
b2RlLCBJJ20gZmluZSB0byByZW5hbWUgdG8gcy0+Zmx0cyBpZiB0aGF0J3MgcHJlZmVycmVkLiBJ
biB0aGF0IGNhc2UsIG1heWJlIHdlIHNob3VsZA0KPj4gYWxzbyBkcm9wIHRoZSBjb25jZXB0IG9m
ICdzY2FsYWJsZSBtb2Rlcm4gbW9kZScgdG90YWxseT8NCj4gSSB0aGluayBzbywgaXQgaGVscHMg
dG8gcmVkdWNlIHRoZSBjb25mdXNpb24uDQo+DQo+IFRoYW5rcw0KDQpZZXAsIGF0IHRoaXMgc3Rh
Z2UgZHJvcHBpbmcgbWVudGlvbnMgdG8gIm1vZGVybiIgaXMgY2xlYXJlci4NCg0KVGhhbmtzDQog
PmNtZA0KPg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCg==

