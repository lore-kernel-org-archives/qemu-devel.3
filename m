Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FB3C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 02:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXsy0-0000F5-Fq; Tue, 14 Jan 2025 21:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=103277e90=wilfred.mallawa@wdc.com>)
 id 1tXsxy-0000Eo-QG; Tue, 14 Jan 2025 21:17:11 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=103277e90=wilfred.mallawa@wdc.com>)
 id 1tXsxw-0004GK-4a; Tue, 14 Jan 2025 21:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1736907428; x=1768443428;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YQEs1pWM5Or6VxuyYujQapKAdLNeupWMOAYxQ3oNC6M=;
 b=ixNIF5zukW0jCGp/cYXMwMpszP+k4D57o5CYzRco9kOuhWi6/e7yVKcl
 ZX4YlaQmL7qd2sL0eGJg9p9RSnwKlBLqX7oFCYY07rv5PPZCD3+10akvc
 NnFobOfmuwkIE+NH9dARwVF+gSWSXyTS0l3m9oifXp1GpXXXa4/OiF3hF
 nOmRq+AeNNulnU17vFs2I01Ga6O4QzQJfIdNB/fVm0GArf2lIXRd8cc80
 UXMxQVvW3j/myUJV5WGI55Lmr/hm4VImyyvS3w+X4U9vE5KjJ3bBnMD9+
 P2rG+EqTMgr+imw8BgjiNY8Wp7TwgVZOhiVQBP0exz2mnjR1IyM/kSzNW A==;
X-CSE-ConnectionGUID: wW2oRYq9R/qTMMsqKc0UxQ==
X-CSE-MsgGUID: r+3YXw+MS7SjfwNXyVk50A==
X-IronPort-AV: E=Sophos;i="6.12,316,1728921600"; d="scan'208";a="37148190"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO
 BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
 by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2025 10:16:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTXoiMcXYLgIIVj95xQP+BnBJvJBq03HcDFZO3TaWW+ak9BSUYRQMjOHR03D9Fy9FAx4UGJyWBoFvL1RcuCvrWSXpCNBA9fDI1UKOgwPzQeR4+YExN1ID0BSePsMBHGGRtB6hLiCC3ynWbJcoDfzemDQQ+dh8snG17a+XtRoV/7XV5SRg/YF3U4WgqrXr/q/o436OzUbQwlA21xkpztP1rDGbcJzQJHUegVr+QcGI+AH9GC2Lr/0mM1QPANoAMABM+5vkw1iPTzTfzi4TMKj2o4nkxsyJAZlYLARaCbLMGqO6AE1rf3PWEBDrmxGz3CVb39Vw8vL2HTx3PxwwcWIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQEs1pWM5Or6VxuyYujQapKAdLNeupWMOAYxQ3oNC6M=;
 b=YRj5ACY9BFtE2Oe9K8mJzngmmFi4FQnEKmETCde0TOYawD50VPLBkuk8eJVoBXpnH5vXYvFqDoKmRLuFW6eE4ASq8LyXSJ55K4BR0D1Bi94BPv+Quog+eg5Rr2k++5Wt/H6xESygXprOrhb7RhbbGIxUk9i/6ZH7PWszCKr0WvB2OWyP2weFA4Bq590hfhIWKt7pQRU2uTwzAC2wbaGKGJdbcD/NhMwJ8gutRH7vnRHtJ8/W7k0WlDosQKvLuRJRm7kqpv6dXCKVfujCMolzuUO/JoCWHmTF4hRzFcRI4CllBvH7sY3gOB2fRdeJx3x1WKH7lArZq7n44BqwI/ooNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQEs1pWM5Or6VxuyYujQapKAdLNeupWMOAYxQ3oNC6M=;
 b=LBq6itnasX4OtqRgcMaJrZwWUl5DR5zaHqeHnUX5ROVCJbtVF0GdossrnxaWnLKKypMkaPr0sl1nB1EccdyiCXlTb/uGJpZQnMrePHA5VLDIkEHrGEaVoog9crnVsPvzib1adx5LjBoJWTPdQL7hy02E8V8l8BksZ8kfx3DAlj8=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH7PR04MB8610.namprd04.prod.outlook.com (2603:10b6:510:242::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 02:16:58 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 02:16:58 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "foss@defmacro.it" <foss@defmacro.it>, Alistair Francis
 <Alistair.Francis@wdc.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [RFC 2/4] spdm: add spdm storage transport virtual header
Thread-Topic: [RFC 2/4] spdm: add spdm storage transport virtual header
Thread-Index: AQHbYNI7AkxXRPqkYE6RKcFFxr4P97MPu48AgAdp5oA=
Date: Wed, 15 Jan 2025 02:16:57 +0000
Message-ID: <6b521ea30dfae69b447cb7c5d158ffcd0dbbf2d6.camel@wdc.com>
References: <20250107052906.249973-2-wilfred.mallawa@wdc.com>
 <20250107052906.249973-5-wilfred.mallawa@wdc.com>
 <Z4DihskLy0wS9ts3@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <Z4DihskLy0wS9ts3@AALNPWKJENSEN.aal.scsc.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH7PR04MB8610:EE_
x-ms-office365-filtering-correlation-id: 179b5a31-825d-48b6-0991-08dd350ab050
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TU5xcmN3SXBUcUJnRzM2Mm9kZmhmTnF5ZjVuU3JyZDRvTDIzUDhHN2UyWTVv?=
 =?utf-8?B?dEs0TVVPYWs5UFA1TVJ1T0sxS1VpMEJjUHBSV0NSc3Uxa0swYmpFSHRsMnRq?=
 =?utf-8?B?VHZZZ3lJbnI3dEM5S2dEcGpUd2trV2Y0QmRnOURzN2ZKZVY2c0pEbzJwZkpp?=
 =?utf-8?B?dlNWWjA1aEx3UnhoYU1nSldQbFhBSmdUME55cWhzRS9DQkFvTldHVkZkd2Vz?=
 =?utf-8?B?YklLQW1TbXFVZ3hJOTVLcW5zUlVkbndTQUR4ZVFIUmtucDY3NzJPd04zc3A5?=
 =?utf-8?B?OHBDeUJIK2lyelM4alFxSHRuNTVRd3Zqb3NuU0hTM2I0Z2Zyc2VPSjdYSU9E?=
 =?utf-8?B?eDhGV1ozc2c3YThZVHgvSENwNjZ5NFMySmdheDY5cXNYK1BpQWhKTFZZbUNY?=
 =?utf-8?B?MkJOM05RaGFjdG12WTg2Zy92NlZPUWR6UXNlTGZkaUFvU3Z5cEhwZEM2MTdQ?=
 =?utf-8?B?WEZlM1dMOEJEaXNnUkswdEhSR2hKVVVia0hqM3RsUFhGV1l5YTlwQVBEcnh1?=
 =?utf-8?B?T0FROTh2aUNuSjcxanJ0c0FuK0ZyclFJQVlJaUF1ZVQzb0tuSVE1S09EMzRp?=
 =?utf-8?B?N25ISVBrQzI3TXk2TGhjS1ZTd0VBMUNpWlU2MmYyWUNtZlBpTmkwSGt1RHp1?=
 =?utf-8?B?Q1A3WU9EVytaOG1EK0I4Y3hkUmJXS1lBSS9oRXVVVXdjQ0JkcFoydjIzWncz?=
 =?utf-8?B?Y2JSYVNzOUt4Y3J1TUVQSmJaeENtaDlBQ3gyOTh0bjlCRlVCZC9YOW94ZnVa?=
 =?utf-8?B?bFpucVRyQnNVVDNDVXFkVU96VnNJU2lncDlRd3hDRkYraHJ4cit4LzBSMWtr?=
 =?utf-8?B?SlppeXM2RkROc0ZEanJOcEZxekJONUdTMlZxc0F1K2R6akg1S0IvRlJORFdY?=
 =?utf-8?B?M0h6TmR6LzBzYnR3eHpZUVpCWWhwdWpLNUpKQXZQbWRGQ0lFMlhWNm8xV0xs?=
 =?utf-8?B?UWNQRUlwMFUvdmxFREoyOEViNnRhT3c3cWtaK2RDdDhwcmlUSUloOWwyeUV2?=
 =?utf-8?B?SkhYUjJjQUE1K2hYNlRKWHVDRnYwRlpCWjZ6dStFblhEb2ExWXdKN2Nld01Q?=
 =?utf-8?B?ckRidm8vWG1reDVoamV3a2k3cU91QkxjVmc1VmVmbnVNbHRNMnVMdGZEbjRI?=
 =?utf-8?B?MUVYOUxybHVZWXdmUm9CVmdvZHRCSHQ4UkZwdmJ0K3pCMzFxQ0kycC9NdXAx?=
 =?utf-8?B?OE5nL1JiWjdJNGF2Z2Erazh3bHlqYXd3L0VOYUkwSnpvNEg4UFpNSW1jczRT?=
 =?utf-8?B?VVhxVkpDVTE3REh6MTBDMUFISHo4UFArbWNQalJLaFFWRlNGK0d1MGVpaG5Y?=
 =?utf-8?B?TWFNMHVUOTNNaW1rTFFpZGE0YmhoQTYySE1IbGdvUllpRyt4VUZKenJUdHJ5?=
 =?utf-8?B?V3dIaXhEcHlVZFNiUnBxMTlSbUZhdm5Ud3hpSHJoS25pT0s5Rzk5VVJnclQ2?=
 =?utf-8?B?Q0FsZGhSSGNmTmpxZjBLL0dYRzErL2xzdWNpQ2FHcEVpZXRsdG1DK1ZWNmFm?=
 =?utf-8?B?UWRuMkxqOGVVTzcveTNMcXVNakJwbVJIWHA2YmpzU0wwT2hXT2dXMlZQa3hF?=
 =?utf-8?B?K3p6NTRYaEl2aytzT0hsL1d5L2w1Z0JqZWVxUVlJd1NKeHNMT29UdjBGUldJ?=
 =?utf-8?B?Z2QxdHhHaGs1bjFYRFNZUmF0anBKeFFQei9Ea2psdG9wWnZ0dUEyektrTU5V?=
 =?utf-8?B?V0VSZjJMOXlqWTNGUlEzMXVyNHAxcUoxMTRZdjd2QTFGeHJsSkZmRTNHeGtK?=
 =?utf-8?B?S09hb2d2NXVQNEthV1hWRjA4MHNuTG9DbHJWZnkxVDJwK1BNWENKeTNNVnlr?=
 =?utf-8?B?UGo3Z3dIcDlTeTJldWN2SkZrTWp6ZXZNa3hQd25XYzArd3V4cVB5ME9IS1Nw?=
 =?utf-8?B?NWZ4SUlRa0JYaVVWeDM2dlA3UGJ4RnBCY1NYcHducXdDd0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnVyMkZOZFFWTE8zQlRUK1BTN29TNTZva0hGb1AvdXdUSGhKVDVzZ2duWEx6?=
 =?utf-8?B?eUFJUjNkdG4xMUU4R25DUlhQNTNuVDloNGhEV21POGl3eml1b2Zaa3Y3WW9v?=
 =?utf-8?B?b3lRcDF5ZGtqaTh1aHh6OU44RzZ0VWI4RkdUSXBiVWFFalFVUUduWm9ncnRn?=
 =?utf-8?B?QUZ5NHo5WXduVm5tekc3bVRVK3dIYlBobXFTQUxDRlJ6S3QwU01jS05WbDFm?=
 =?utf-8?B?NmJMR3hUUzVCSDFmMllBZWVtcXEwNlhRUlVNM3lnTVM4SU45Mm5reTdlZ1F6?=
 =?utf-8?B?SjRhcmhKSElDWGZIcStEa0pKVHhYTzhtR2dpSmNVUUsycXNHWHI3MnE0Q0tP?=
 =?utf-8?B?Wko3ZHdKQi8rYnZvdTNmSVZydXlYMFpXWlI4Y2xkb1VLQkt2TW9hNHc2aG5U?=
 =?utf-8?B?UEpmVDlraVRjaXBJRWhobjV1QUduU1JYT0FabGJST0xCN3k2STg2eTVLU3Ux?=
 =?utf-8?B?N0VTTU9JdjZJQmdQemdYeko5OHV1UXJwdHQ0UjZ3eUNZUUVQYVZQWDRJeUIy?=
 =?utf-8?B?VUZ4anhrUHZvcVZNNnFXRE1PaEZuUnBYMVpVdzhQSGpIUm1Rckl2YXlYUEpv?=
 =?utf-8?B?Qm4ySG5kSE1YNE5oMmRxbk5ZVWpjdlN2RUJnd08yZ21TYkFyVnVLVFQxdE8x?=
 =?utf-8?B?bGx1S1NqR0NUWmVndGpJeUxYU3pjM1ZYWEtVZkc0NXN2bE5ySnAxSXg0dFVK?=
 =?utf-8?B?U3BYdlM1blRjbzNMbHFKTk1WZjlHSlJ6WERpYmRPTjlXSC9jMlc0WXc1TkRH?=
 =?utf-8?B?bENvTUsxNVNqUHZHNk4vZXNrdUdLUENwS3AyWm41ZU56amFXeFpXUnBtcFht?=
 =?utf-8?B?emUxby85UGQ4ZGZrM0R0WWxjbzJLeVJiWHZWdHkyR0VMR09CbjlpckxaWk9P?=
 =?utf-8?B?TGNzdDhsWlIvTzhBQm9JTU1VNnVwa05nVFpuWTJURHE2R01yellzYWo2WDlu?=
 =?utf-8?B?bWh4R0VEVThpa1g2MXpvanRMQ3B2OXEwM0Rzb2dvb1hESzZWSHlDVDZSWGxa?=
 =?utf-8?B?Mi9kNjBTSXY4QzQzQnNHdC9nQkRXdS9CMGk1aXpCVVU0dXBlR09qV1dYK3lP?=
 =?utf-8?B?NWIwZy9adHpVb1NvaVY2VW5ia295ejQydHdhZ01lK1lsWUMxS2JPbVpvVUJh?=
 =?utf-8?B?YUgzN2xuWDhTYTBWN2JnRXVWTHFZbUlwRjNGYkRHd0U1ZFA5N2VWNFRESG9Z?=
 =?utf-8?B?UjRwOGhpbkovN3c3RDZVdEZqT2dLWllXWTg1NGo4cnlzNUpua1U4TTFzWGkr?=
 =?utf-8?B?b0ZGc3h3VldOUHF6VHJkdFd3RmdCdHQwaXhaV0J6MDY3OWEyMzhVQXlHNTJ3?=
 =?utf-8?B?L1NvT09GZ2FHdmcvTVpMREZQcnZDRTc3T0UrMkFhS0wyRmdFT0MxV2FheklS?=
 =?utf-8?B?ZG5zMndvTS9YcU5rM3NOS1F4VlNDRlRwc21MSHF6S3c3SDdTRUZYSmw0WmVn?=
 =?utf-8?B?TkhjTWRwQWtaNlYzcTFBejk5Z054ZmpTWkFjOUk1VitmWGNSdVVDVDd5THNF?=
 =?utf-8?B?c1lESENzUEExTlVtMUtZa2RVdXN4c2JYODNJTThuelJjUGdheFNsMzFWYnJi?=
 =?utf-8?B?M1FmOExiZlprTWcxcGdMM1orN2hxemlaTG1mK3FLNk1RTXY0bXkreTRTSkRF?=
 =?utf-8?B?eGh4S0Q2OFM0NW9wenJoU0xDbVFEdXczbHNvaERVUzBvbTYzcm9JMU5BYU5U?=
 =?utf-8?B?bmYrN2NwRVJpT0hLUVUybHJIYndmRmRSTVU1K0d3bVkvVVAwY05zNkxlSkhQ?=
 =?utf-8?B?dDBybUpQRFdMT3FJcXk3Q0JnMDdkcXNpSkgyMWVMcjhCaVNWbWxBSDRkMmlu?=
 =?utf-8?B?OUlBUHZIeXRWSVZ4K0lxU0psT0swK05nU252M2hRUzc5K2l6b1ZSWHlOL3V6?=
 =?utf-8?B?YXYzeGxnNVRIYW9MZHo5enN2RVhnNkpSMkY0c1FnS1dtandrR0lrYzA2VXRv?=
 =?utf-8?B?MnNPMGVOUFVLYS80OUUzRzdoNG1wL0tMMHhqS3ZtbWhoNnI3Unp3ZzRWMHNP?=
 =?utf-8?B?UkYwUGpBU1RCaVBsVWJpWExsQ2NhY3pYWDQxQWVzUjRFUXhEcmc4SCtxNlZM?=
 =?utf-8?B?OGswVURzcnJiTE9udDVwaHF1SElISS9MTnpLU0g5K1V3ZjdFNFJUZWV5c0d4?=
 =?utf-8?B?TnlrRXJaa2lPSHdwR3hoTlJGMk53ODNSeTNVS1RPTy9INSs0SW5qNkRaTFhD?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1ADC880B8576D42AC07F887D5B2CF0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S3NcWj3yTbocUg5xF0Gr4WGhMwRq7tLpUTJi9NLudsJjpjPIC2P65SKz1wodvyztJSN6JvPMgUvqI5M8bVixQfQoCg8ywp13xuN2iy/O1fLPJwr5As7fqRKDNWdeooW8ti0KV+0g5Vm4IMp485QReLgWqSFZIpxbrScr+Z97Rat0SmWju5qj0V+DmFb1xPaZ2txRi+A/jH3r+r/gzAqQw/vZgWkv6s8kFma/ZSsbrH/5QyLo973NC5IDV5xjVcYUzHDbp3zk2dkoTKDg9nFCrRKnCO8bWzSrlwi9Wzi0QJx394SEnJZ9RCfbcqLgB0ShNegxSP14tfJhD6yhPpobblUPicn0m0vrrOrezQ4oS8TTao5ktKkHo96ZCdvXBDs0C3kzF9nDypaDWomPiYI4Tkw74rc2zy/R5u3bLoerrEz/LZk3NdQ2zP8IArH7dYrFD5uhPDLEF1+dyzdAV8nH3d/1nAn12KO4C3pFYJKMZfi4SuMufr+tSPsmw4NGtZjBIcINMkQUmKWwxPJoWIJaCdqIVq4mQElAXg+C1Qyfx/vkkU4wv4fZhdDybyCeg/8V6S0JyQUI6XO/+TrOT3BqKT/By6/WtnxdAHtRzNsRlQwLSn4R4d4XpXvenX2y4OqI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b5a31-825d-48b6-0991-08dd350ab050
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 02:16:58.0014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSMGXpFbiLYWFrddOuq2WYkgF7ey5RrPYQ+rCX4eFbjFUJEh002aIhrUoeeEGxPS48oPfRObmAL9Qh9AQ7bQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8610
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=103277e90=wilfred.mallawa@wdc.com; helo=esa1.hgst.iphmx.com
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

T24gRnJpLCAyMDI1LTAxLTEwIGF0IDEwOjA0ICswMTAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIEphbsKgIDcgMTU6MjksIFdpbGZyZWQgTWFsbGF3YSB2aWEgd3JvdGU6DQo+ID4gVGhpcyBo
ZWFkZXIgY29udGFpbnMgdGhlIHRyYW5zcG9ydCBlbmNvZGluZyBmb3IgYW4gU1BETSBtZXNzYWdl
DQo+ID4gdGhhdA0KPiA+IHVzZXMgdGhlIFNQRE0gb3ZlciBTdG9yYWdlIHRyYW5zcG9ydCBhcyBk
ZWZpbmVkIGJ5IHRoZSBETVRGDQo+ID4gRFNQMDI4Ni4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+
IMKgaW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCB8IDEyICsrKysrKysrKysrKw0KPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zeXN0ZW0vc3BkbS1zb2NrZXQuaCBiL2luY2x1ZGUvc3lzdGVtL3NwZG0tDQo+ID4g
c29ja2V0LmgNCj4gPiBpbmRleCAyYjdkMDNmODJkLi5mYzAwN2U1YjQ4IDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvc3lzdGVtL3NwZG0tc29ja2V0LmgNCj4gPiArKysgYi9pbmNsdWRlL3N5c3Rl
bS9zcGRtLXNvY2tldC5oDQo+ID4gQEAgLTg4LDYgKzg4LDE4IEBAIGJvb2wgc3BkbV9zb2NrZXRf
c2VuZChjb25zdCBpbnQgc29ja2V0LCB1aW50MzJfdA0KPiA+IHNvY2tldF9jbWQsDQo+ID4gwqAg
Ki8NCj4gPiDCoHZvaWQgc3BkbV9zb2NrZXRfY2xvc2UoY29uc3QgaW50IHNvY2tldCwgdWludDMy
X3QgdHJhbnNwb3J0X3R5cGUpOw0KPiA+IMKgDQo+ID4gKy8qDQo+ID4gKyAqIERlZmluZXMgdGhl
IHRyYW5zcG9ydCBlbmNvZGluZyBmb3IgU1BETSwgdGhpcyBpbmZvcm1hdGlvbiBzaGFsbA0KPiA+
IGJlIHBhc3NlZA0KPiA+ICsgKiBkb3duIHRvIHRoZSBTUERNIHNlcnZlciwgd2hlbiBjb25mb3Jt
aW5nIHRvIHRoZSBTUERNIG92ZXINCj4gPiBTdG9yYWdlIHN0YW5kYXJkDQo+ID4gKyAqIGFzIGRl
ZmluZWQgYnkgRFNQMDI4Ni4NCj4gPiArICovDQo+ID4gK3R5cGVkZWYgc3RydWN0IFFFTVVfUEFD
S0VEIHsNCj4gPiArwqDCoMKgIHVpbnQ4X3Qgc2VjdXJpdHlfcHJvdG9jb2w7DQo+ID4gK8KgwqDC
oCB1aW50MTZfdCBzZWN1cml0eV9wcm90b2NvbF9zcGVjaWZpYzsNCj4gPiArwqDCoMKgIGJvb2wg
aW5jXzUxMjsNCj4gPiArwqDCoMKgIHVpbnQzMl90IGxlbmd0aDsNCj4gPiArfSBTdG9yYWdlU3Bk
bVRyYW5zcG9ydEhlYWRlcjsNCj4gDQo+IERvZXMgaXQgbWFrZSBzZW5zZSB0byBwYWNrIGEgYm9v
bD8gSXMgdGhpcyBkZWZpbmVkIGJ5IHRoZSBTUERNIHNlcnZlcg0KPiBpbg0KPiB1c2U/IEkgY2Fu
J3QgZmluZCB0aGUgZGVmaW5pdGlvbiBvZiB0aGlzIGhlYWRlciBhbnl3aGVyZS4NCj4gDQpUaGlz
IGlzIGVzc2VudGlhbGx5IGEgdmlydHVhbCBoZWFkZXIgY29udGFpbmluZyBlc3NlbnRpYWwgc3Rv
cmFnZQ0KdHJhbnNwb3J0IGRhdGEgYXMgcGVyIERTUDAyODYuIEZvciBleGFtcGxlLCB0aGlzIGlz
IGRlZmluZWQgaW4gdGhlDQp1cHN0cmVhbSBlZmZvcnQgZm9yIA0KYGxpYnNwbWRgIHRvIGFkZCBz
dG9yYWdlIGJpbmRpbmcgc3VwcG9ydCBbMV0gYW5kIGluIERTUDAyODYgWzJdLCB0aGlzDQppcyBk
ZWZpbmVkIGluIHNlY3Rpb24gNS4xLjEuDQoNCkN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhl
IFNQRE0gc2VydmVyIChpLmUgaW4gYHNwZG0tdXRpbHNgIG9ubHkgb25lDQp0byBoYXZlIHN1cHBv
cnQgZm9yIHN0b3JhZ2UpLCB3aWxsIGp1c3QgcGFzcyB0aGlzIGhlYWRlciB0byBgbGlic3BkbWAN
CnRvIGJlIGRlY29kZWQuIE9uY2UgZGVjb2RlZCBieSBgbGlic3BkbWAsIGBzcGRtLXV0aWxzYC9z
ZXJ2ZXIgd2lsbA0KY29udGV4dHVhbGx5IGNoZWNrIGZvciB2YWxpZGl0eSBvZiB0aGUgbWVzc2Fn
ZS4NCg0KQXMgZm9yIGluY181MTIsIGl0IGp1c3QgbmVlZCB0byBiZSB5ZXMgb3Igbm8sIGlzIHRo
ZXJlIGEgYmV0dGVyIHdheSB0bw0KcmVwcmVzZW50IHRoYXQgaGVyZT8NCg0KWzFdDQpodHRwczov
L2dpdGh1Yi5jb20vRE1URi9saWJzcGRtL3B1bGwvMjgyNy9maWxlcyNkaWZmLTMwYzUyM2VkY2Ey
Mzk4M2UwZjE2ZTA2Nzc3MmVjMThlNzExYTQwZjUzYWM0OWM4ZGRhMjQzMDE0NTBiNzI0ZDBSNDQN
ClsyXQ0KaHR0cHM6Ly93d3cuZG10Zi5vcmcvc2l0ZXMvZGVmYXVsdC9maWxlcy9zdGFuZGFyZHMv
ZG9jdW1lbnRzL0RTUDAyODZfMS4wLjBXSVA5MC5wZGYNCj4gPiArDQo+ID4gwqAjZGVmaW5lIFNQ
RE1fU09DS0VUX0NPTU1BTkRfTk9STUFMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4
MDAwMQ0KPiA+IMKgI2RlZmluZSBTUERNX1NPQ0tFVF9TVE9SQUdFX0NNRF9JRl9TRU5EwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMHgwMDAyDQo+ID4gwqAjZGVmaW5lIFNQRE1fU09DS0VUX1NUT1JBR0Vf
Q01EX0lGX1JFQ1bCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDAwMDMNCj4gPiAtLSANCj4gPiAyLjQ3
LjENCj4gPiANCj4gPiANCg0K

