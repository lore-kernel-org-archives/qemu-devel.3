Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6FECAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 01:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1wqk-0003Ct-Dl; Thu, 25 Sep 2025 21:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1wqh-0003CL-5i
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 21:02:11 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1wqZ-0002hj-0e
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 21:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1758848523; x=1790384523;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fWtDY6npxxMx1bBe/KgdVNvDQWYOs+QHZTYrqfze83A=;
 b=pmvqjYX5DvMOOLc7YPuOsynuxUeyksvdF/1DhCS33ARbac8n/usDnydD
 KaZtVlfe6OmToVSLKXHyp4/VY3twjQhkYMNezmS8fLXu5zyRkdXKc5e0A
 oNVfqGJl83J8uOaCAuqCkSHvHUJtdVqc/6wpCZ0Awh+k5tJ1wFCpdcQy4
 DvMcXEr0aackqHb8dHF8SK10950kspsQtDOM1k8CtXOCbLdhuawkiNkdL
 ti/wSOwkq2jetgriPegZm0wEtZitlsMAMqVTeNKjsrUSguHE9V8ejVMtN
 pZ3RoSXfRXDylmZroDYHpcK3PxDAIK6UggYIMLjkORp+irV92F6Q6FqBy A==;
X-CSE-ConnectionGUID: pNr34DV3RG2KZKldjlQnhQ==
X-CSE-MsgGUID: jpigAj90QvSI0TEVceV10w==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="79865375"
X-IronPort-AV: E=Sophos;i="6.18,293,1751209200"; d="scan'208";a="79865375"
Received: from mail-japaneastazon11010065.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.65])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 10:01:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGxWmQQW0oIraSXQCoe5mbd6AQNOQ7lwwyeFz3JFjt3hyB4qkfkafdDFUoJyGHoDelMHKZy5xyOiekzrDJVr24DVGfy8EQhyNtmsSUO/AeYUu2jNibNwF5k2a+wGiNKnHFiKo+q5vLiRpB4aV0vgiEStUM/a9ob58inmoyWNdq88BX4xILHzi56JIje7wxB8X4NH/tqGb5lX9irvZDaNA6Sw9iPebXpvnwUjRaigyHl57im9fRCeFV0HoxPUvdtipvnrNcxwaOzS7BZhrUPFE+gBymHdHplXxFR9wU/DdlH1erjkE8CYQn3mUXAgD9Wc7lYj0hVwuIwsNreuvToVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWtDY6npxxMx1bBe/KgdVNvDQWYOs+QHZTYrqfze83A=;
 b=PpuKxXNDtPRp0n021GBbCJJ7oUxXZPniE5l1kKuQ9lGSCre7Rz/k3eLe3Y5lUHWZl07jcLyOsBRM7lDp9t0wE+F+8BubmZRCKeyaDd1q1v5l49fuChFtlS3vX5AuzPihPWtlKveZ759oEYYQ/8cXHdtryyezR9QnPR+GSpDlQQNNmvX3/MeVcQKV/+jdE1Yeu+nMZmHXgwrd0yt5rtJj52t8r4bNGJfu9+282GsJ/UnOnbfwZ90/eQarwQ05BO4H8hCOu5jR/rD2Ln5jpcCxwphPubL//t4VJVudj/qWxnsRneGyQDHMFIToczIpgIrlrqwPvq7u1OwokhsGElt6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWtDY6npxxMx1bBe/KgdVNvDQWYOs+QHZTYrqfze83A=;
 b=aRFpz2V+dj07EgOhJfXVr0YeBqe5jIxMYL2k52ed8PEmpGdIYBoroM1wGUACcslIJSZ1SC+XDFlltVFFWlCYTQGVXqBq9qxHB5BJ9vZ9GWX/YtPLC8FKrpxVNo8lSgSYbsRzKqLuZmccqsF+NuUVjRpumLTogWyi57Q+xmTsEe6aupZesKA42Yyxx7E3VHEFS/pIl/e8Fouw/LnmWuXMvXsvEvg3pEqRfQXelPpWnL5i/+r9faHuLcpb0JQrRL17A5RnIxILUCwOtTzk+f6r+HsoFJ8xlWwrZQ/m6aD9ejSSHKSyZ6crW9fufXscDV6wKovPJ6JcdeFU9vozV7B3lA==
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by TYCPR01MB6687.jpnprd01.prod.outlook.com (2603:1096:400:9c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 01:01:43 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 01:01:43 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>, Yury Kotov
 <yury-kotov@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>, Lidong Chen
 <jemmy858585@gmail.com>
Subject: Re: [PATCH RFC 2/9] migration/rdma: Fix wrong context in
 qio_channel_rdma_shutdown()
Thread-Topic: [PATCH RFC 2/9] migration/rdma: Fix wrong context in
 qio_channel_rdma_shutdown()
Thread-Index: AQHcF5WtC3plgtlDhESl7rKVXTj3BrSk0xAA
Date: Fri, 26 Sep 2025 01:01:43 +0000
Message-ID: <bddec2ab-a3ca-4c16-a8b0-821109a3e0dd@fujitsu.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-3-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-3-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|TYCPR01MB6687:EE_
x-ms-office365-filtering-correlation-id: 5900eabe-7381-4552-e058-08ddfc984282
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?enE0K1lJZE94cjFPL3NMaUJSZENlUFRSVUdLTmdueHYxTEh5MEIwZVo3NFpN?=
 =?utf-8?B?YjEvcTcrNjdDU2F4ejI2MVpMK0w2NnVsQ1FWa08zMU5kejJBeHFxcVJ0SlJq?=
 =?utf-8?B?dk1FQkxvYkNQTzFIL2Ywa3dPWWVrd212YXp6N0FSd2ZqM2k0V2JmZWttd0hH?=
 =?utf-8?B?WnZnZll0MXdReGh5ZzV5NmZKMEtxbG9MVWNNNUNIYnE4MElZMUNMVVlxb3FD?=
 =?utf-8?B?YXM0WkltYTZ2YmdrWXF6T0p1R2M3Yk1iZW03Nk0ranR0MkhCandiZnhFNWtz?=
 =?utf-8?B?MWhrRkhwZlNlN3BUdEJWV055Ym9vSEp5RzFMTnJabklXTzFuMWgxT2NrQ3Bo?=
 =?utf-8?B?WThJdW55UmVvc3lCVDc4NFQ4eDhTQjVZZmtWVGhPa2VheGViMjVjRUJ4TzZ5?=
 =?utf-8?B?YTMzNFhZR2FlNVI4bUgzcHUxMThGNnVuWEphekNYazNCZCt0QitKTnJiVzlC?=
 =?utf-8?B?ZktSV3lhWVkrQ0d1aDhlTmczdFY2bURwMHhZMDJPSnFSSTA5TjNYdk5aT1Vv?=
 =?utf-8?B?M0lORkI2MXhIV0hqL3FuRVljQzU1R1pUU0Z2b1MrdXdyUmZCeDZZbit0SjhT?=
 =?utf-8?B?VHFkVnMyWGM1WHZEeWhYaXNHRVVsVVNLSlNEYXN4aE9HWkVlS2FJNnIvaEhC?=
 =?utf-8?B?MGRKblZLU1k0WnNVbTd1alpvL3BKcEN5ZjJHeFkwQjJ2dEk1cUNCalMveFFu?=
 =?utf-8?B?ZmNGTHJaZWtCREF2MnMyVklKVHUrTnJYNVN5YnZONDBFUlUxSU5yTit6OEtp?=
 =?utf-8?B?TWZyYkJDNXI2UEJNV1FDWFlCdDB0WTIzcjVrZmdPYlVSQ3pqR2g5NmtCQWpB?=
 =?utf-8?B?OWxPSjRqVExQbENSZGwxZjNOSkpOdG4waFZDdVlOOFg3VjZsc3J5dnlJUzIw?=
 =?utf-8?B?Q1dGTkw3aHNXbWMxMFBzWXdhTVRYd1UreEo0M2MyQUxnOUcrazY0YnRHak03?=
 =?utf-8?B?bXlKT3k0UGo3cEwyYVBqdDZHdzE2Uml0aFZEVmltNCs1KzFTNzBXR0RKR3A1?=
 =?utf-8?B?MDBqZm1IZ2ZZbHFMMGlhbjRZNi95Rk95aHF2VUFJcEN4cnFEYVJHOEw4c21v?=
 =?utf-8?B?cDJvOHIybkhxOE1EOHlPeUU5NUlPdEU5TDQ2RGdMVk5TRUJlZXE3aGpVbDVP?=
 =?utf-8?B?dXlMNG5HVlRqc0g3NllDM1hFakRjV2VDcEVKbXRBdXFwT25Yc3c3amt2T1Jn?=
 =?utf-8?B?emRLVzk3TmxDK2E2cFRTSWpMdHloSkUyeUUyOGhGeHZIWU1qZTVCU3RCaEti?=
 =?utf-8?B?SklNN1YxYmFuN3M1SDU0N1FoVWlZOG5SZUVCalEwUHc1NXNpb3htb1hwS3Bv?=
 =?utf-8?B?OVJ2cWc0aks0bFZJQ2VsNWlUdFh0S0xFT3VBWXM4U2JsQmQySXN6KzkzSHpV?=
 =?utf-8?B?YlM3aS83R1E5cnU2QzkrQVRUOHFtTVJsWTVUYVVjdjgyNWZpaGdnTVdoVkdD?=
 =?utf-8?B?cG9FR3M3aUUzTGttUWJjb2N0cFUzQ3ZLdEhIQlpua1hsdzBjcWNCVnFFV1Mv?=
 =?utf-8?B?YUlMbW9CRUNQblZ3TGVKYWRUQ0NRZCtHQ2Z3a3MwYXlkQ1IrRlROTndWMWFT?=
 =?utf-8?B?NjZOcTlzK2VJd1l6dmtmd1M3VW1kcUpQSHF2MjBWTmdYVGl6enhLTXJZSk5r?=
 =?utf-8?B?ZkpncVRQVFh5ekgyOXg2dlhBMUM2ejlCZndGOVVGcVh1NDMwNUdlOWNvaXll?=
 =?utf-8?B?VzR3ZnduY1lEVVRLY2U5WXp3QWlDVHQyMU9GTlF0TTlnUld2RFBLOVhVSGpn?=
 =?utf-8?B?Ti9wbUpqZURyR3p5RFlKU1FhQ1VkM3RBc1dqelo1S3oybytNQS93dE0wWDNC?=
 =?utf-8?B?WUtHZE1XeHQ2MVlYUzE1K01kdU9CR2h0U1U5bnNKUGw3cGU4N3prMnlwMU10?=
 =?utf-8?B?UWNsblZXbGQ5b3FqNUE4MkZrdTFQaG9tR0g3RFBkRWpCVkc2L3hDTXRIRlF0?=
 =?utf-8?B?cExpaStmMTkybTllNUVzd09mMEovUC9zOHVyUFFYNkxxdksxQ3lqYzBLQWNy?=
 =?utf-8?B?ZzhYSFZhNUlTa1ByUjFFRVZ5Q2pKYmJXd1lwZDRWNGxBM21NdHNJS2NGTEZC?=
 =?utf-8?Q?QFGJU+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSCPR01MB13050.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym9OOUl3UTFzWitweklGNHhtclp2S1dzb2l3ZFRrM3owOUFEdlRPV1hlbWc1?=
 =?utf-8?B?SG5XY1dqTnJFbjRVdkxlT1o5emkxRU9DbkJodTVXU2NLb0FiQmp0QnFLTFFB?=
 =?utf-8?B?bDhra29QWkUrVERUdHh2c1hXUEkyODVaWjFVR0xsVlNBMFlsTzBqZ1dlSUpV?=
 =?utf-8?B?a1VQaE92WmltQW5RSlFuMzR0ZlgxaDRnU3VwUnRsZGd4dnJOYzdMb2FwUTJY?=
 =?utf-8?B?V3FpT2VNdXdoclV3SXF2SFBoZ3FvUCszM3p2VVEvK2hIWlFJUGdjMTRJdy9V?=
 =?utf-8?B?SUpNT3RYL09UYklmdkhGWThvVzA1enRQZERGb3NSeWVRRG00cHRKS3VDeXlx?=
 =?utf-8?B?NkwzNFRjRkxJUloyUkxWUExRSGRpc3VFUHRzYTlNcnc0eityYnY0RGE1Y1gv?=
 =?utf-8?B?bWR2cWIxN1p0K1RzdU04ZGtBM25TMlc1ZWRFanVDL00vVVQvMHZhUXZYL24y?=
 =?utf-8?B?aWhqQVNIM3UrbnUzbG8xVFp5cE9DYVFuUTZzd3dkRkp2YytCZ2NRVklPbmNO?=
 =?utf-8?B?a3ZRMU5MLzFjNUgvUmNWTEVPN0NkTVgySW1mSWJtTkdMcE1rSjRQNXdqTWda?=
 =?utf-8?B?Lzd0a2hVK3NtQXpCTCtRdWVaRVN3MG9VVDRrZUthdzM4citvb3NCK1l6UGlZ?=
 =?utf-8?B?dk1SVGdqT0Qrcmw1T25KRzEvK3dJR0Noazg4ZEtzSEFPMk0vaHFVa2l4YjJq?=
 =?utf-8?B?ZW9aQnZ0MnZTL2w4SlBLK3ZkQ1dKcnhGaHRqWndVeTJvYWY0QTRRU3B6Q1V4?=
 =?utf-8?B?YVdocTFPbzRQK3h3Rlh5Y0hHaVNPVjFBeDJXRXo0U3B0cVltcW16K2ZtSm1V?=
 =?utf-8?B?b1I5dXBoRzJGQy9aZUhDVWt0UHh2ODdTQ3FqdDdGZlVHdDFhcFNlMUMvMVV4?=
 =?utf-8?B?SldCLzdUbnMwTmlSYy9OUDNVdUxIVW5RRFUrUmNkNWJmVGREZDRhcGFHMEtu?=
 =?utf-8?B?QUtYdFpuaVZoT1R2RFJ4WHp5WmVLV1lCb2R0NG1iV1NiNURmRU5LTWFPVmky?=
 =?utf-8?B?emFORUxIRlVFeU9QbFk1bmI1RVQvOUlzbUdPYVhha3pVZUNlS3lJZmJtaG5t?=
 =?utf-8?B?ZGxaYUY2VSt5Ty82c1FmaEI4SHZMMkJnQmNZaTY5VlBlVHc1UHJnRjN6Sm9Y?=
 =?utf-8?B?MGdWYmFWeExIb2dtUVVLTnh4aFV5d3VGK2hYaml0S2M5YzdZMWVNQ2xQQmZo?=
 =?utf-8?B?UXpkN0V0MHBSNU95QjRHcWxtUVVXNU51S1VjR1lBOVlsM0VkdEYvbk1BT215?=
 =?utf-8?B?TzNyU0l0SmRJTzdyNVRPcGhGS0EyKzBLS0VUOGJVTklHa1dVcGxsV0drdGNM?=
 =?utf-8?B?cG4xaXpGT2pma2g4OG9qYXdHSnkrb01SVkRmN3FONHVxZHlNTjIzbWpWbU8z?=
 =?utf-8?B?OWZ6UFFUZkh2S0xveVo2d2x0SDBXa2xhVmFxY3VSS1kvWWQwUWhWUE5ZNHY4?=
 =?utf-8?B?L3NjbWdzOUFrN1hobU54UmE4S2tURkdIY2R1TWswNmp2OWdidVpjZU1UZVdV?=
 =?utf-8?B?M1Nrb09Eekc4L282bnVEeklUREx3aE94SEdXUnJSQWs3R2hTdWRCTW1TRGhK?=
 =?utf-8?B?U2lzZ1UwU1RaWmYwZjBwNEI2aHo2bWZQUEoyaUFpZkNhZmVIUXFZc1ZrQVh4?=
 =?utf-8?B?dnpaUnlLcFZ0RXVHT0Jybk5LWnlpOUc0SUlGcjdCWDV5Ym0rWWptNlIxWDlG?=
 =?utf-8?B?TTkwckRHaDMzV25VY1VyM0JVaUg1UldyQWI1ZncreXRPdTRUY1F6eThHZWx6?=
 =?utf-8?B?ZlM2Y2NPdm1hOENYTHRDT0J0WnlJUzJJRHNFL2ZXWW0xckM0ZlZhbGJoa01Q?=
 =?utf-8?B?VW9odG5XLzNBL3RTVFlVeDM2S0RtTEhhTnRNdGJoQkRJSThHbTV0Ti8ycUM1?=
 =?utf-8?B?MHRMT1UzT3VPQ2QwTDJoeDFFZjFQWjJoQUNRdmNmTndldENONCtmakRRdjc5?=
 =?utf-8?B?V2I1ZVBSdEgrSmFoRVV4dVpqYms3R0tSTWNpYWJnOFB1WjA0bWc5Rkp3d0t0?=
 =?utf-8?B?emc1TkJST2hVR0UvR0xPVGlBTzhqOWpwTUtVMFVsdmZQSGMvK1FrVHdsU0o1?=
 =?utf-8?B?Vm1VOHI4dVNScnBDbVpxbjFROEtYeWswcmZiRkp1WUNNaFRCRm02NllaLzlB?=
 =?utf-8?B?allNMTZiN1drR0U1dUl0TDF2WTRyL0JWSkJCZTNnbDFyNG1Zem1wb3krK1Nn?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A38AF7724FCAC84AB6296A8667D5237E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4NcSd4w3s8hpmlXiIULw05+3/LxmY+L/uKPFUcII8Yccor9IAEvoB+tUr9DSWpl9PZtKWAu7TCp5eM5c7px5u/KLA0/VbQ4b5B8+r2m4qGI5cbxGx34UXEmxmm9Z/X9HQFsKTYbq3qLt8lPmfPUUBcqTyQ9mlmnYOAAUUa35S8Qpe9AtLYvWiT9XMrQ0Ds33MBgaVJ37Ics9cz6zhsYQGjVn3se0+wyAN3DJaTFcqOjANzVe28ATMHWfgTSgyc+xLqz9xR8HX6dnva8omUmGWGE9OZ6O7p5lHx6448ZKRhCpB58A6QC1aCU1YGbw++jBikLAAfoyLqQHU1dfcu5muJ57WivIE0hXjJ7zpdqYqkpSoBNqPU3XKkYjaOkn6xuKORabDmLoOesDvNt/Bt4B23J9uK9bXc4ibn4969j0gx8TShKORz7dNlgRutJ/XaNs6ke3L2skNI67VrRjxzmu4fGWB9uKUqyOxMGgizJ/Gu+Q23WvwrE3dJvuwQ6kdRhZDSc3XLA5QEOlcskpfPCszehiWQY7ItQcsdP5+qj5ePNzgvbJgix0OupX1eNT2FbLCzDJpxaX9ON+jwAxAvGJuBUVZmm/WmkvaLDVREz/VKV+CprBD8wTKyudcsmYdN/r
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5900eabe-7381-4552-e058-08ddfc984282
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 01:01:43.7442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTYBrPXofht3uKV82cCYvGsxuHIi949n/bcH+xQEWv4zCDzGhGT2ejm+hp0k5ImcRXxYv0dccPZsTrs5eRvImg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6687
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=lizhijian@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDI4LzA4LzIwMjUgMDQ6NTksIFBldGVyIFh1IHdyb3RlOg0KPiBUaGUgcmRtYW91dCBz
aG91bGQgYmUgYSBjYWNoZSBvZiByaW9jLT5yZG1hb3V0LCBub3QgcmlvYy0+cmRtYWluLg0KPiAN
Cj4gQ2M6IFpoaWppYW4gTGkgKEZ1aml0c3UpIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+IENj
OiBMaWRvbmcgQ2hlbiA8amVtbXk4NTg1ODVAZ21haWwuY29tPg0KPiBGaXhlczogNTRkYjg4MmYw
NyAoIm1pZ3JhdGlvbjogaW1wbGVtZW50IHRoZSBzaHV0ZG93biBmb3IgUkRNQSBRSU9DaGFubmVs
IikNCj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KDQpHb29k
IGNhdGNoLg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KDQoNCj4gLS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9t
aWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBpbmRleCAyZDgzOWZjZTZjLi5l
NjgzNzE4NGM4IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBiL21pZ3Jh
dGlvbi9yZG1hLmMNCj4gQEAgLTI5ODYsNyArMjk4Niw3IEBAIHFpb19jaGFubmVsX3JkbWFfc2h1
dGRvd24oUUlPQ2hhbm5lbCAqaW9jLA0KPiAgICAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7DQo+
ICAgDQo+ICAgICAgIHJkbWFpbiA9IHFhdG9taWNfcmN1X3JlYWQoJnJpb2MtPnJkbWFpbik7DQo+
IC0gICAgcmRtYW91dCA9IHFhdG9taWNfcmN1X3JlYWQoJnJpb2MtPnJkbWFpbik7DQo+ICsgICAg
cmRtYW91dCA9IHFhdG9taWNfcmN1X3JlYWQoJnJpb2MtPnJkbWFvdXQpOw0KPiAgIA0KPiAgICAg
ICBzd2l0Y2ggKGhvdykgew0KPiAgICAgICBjYXNlIFFJT19DSEFOTkVMX1NIVVRET1dOX1JFQUQ6
DQo=

