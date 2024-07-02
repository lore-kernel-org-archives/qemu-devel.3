Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F042C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfPf-0003TN-Qz; Tue, 02 Jul 2024 11:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOfPe-0003Si-5Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:27:22 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOfPb-0001gt-5v
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719934039; x=1751470039;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=DYw5ELzKdbsv2XgxOR/yY2w0HaDh5TgrTXFprJc3mGk=;
 b=n0UUZi/MP8RL422YrYcAoNFqWZbGKEeeIP2CjeKdhqpToRf8zdu8C39C
 LfQJ9rCKavxog8n18C/OiE67P1YvGaEz+FhV/HxVQpG2mIwJg8Dip0t9q
 kHbokRKHYGPhD9pygjt9FS4wAj8wcIOlNWkzxMAJK/Kt+TtVzsGjrgfQr
 FP0VJMPsGQgVU+RKDi5g49kjLBtSP582Um++h4dwyD63oJZ6Eapq/WwNS
 HVqBSa5R21tQttTLcMW78R7tbAEYVXNl/JRMsYe4vG4/Lm7Sx6JP8UYb2
 MfzZVGxJo5op14izkCVzmfsg6F0FoFey1u87Pz02DZ2BRTGbVukGZdGxb g==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15861290"
X-MGA-submission: =?us-ascii?q?MDH4ztiVON/cLwRMmid1Q95wTmz+JiHJa1GpXX?=
 =?us-ascii?q?S9Sqd4Gcisds02ES957o08IAXrxhO4geHsBkdMT7sBaLruOjpcgyGSFK?=
 =?us-ascii?q?qiCeneFCHmWcDaIozLDgWQ9csL7H1IzHRWpygwtcr9KaYH1qTjNvrfm0?=
 =?us-ascii?q?OJb3iNhsXeB8S5TSctI+CRvA=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 17:27:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiBkVSuRwKMBrT+qU4MBpgk9CEEHrlbI15YCKez0M8tw2PV2sN0v8oHc7BD7G1cjJ595Il0pJqtcPBy90sD+pPpVhx3tfpROzBi/+tQLFdGuJNetlw6UaD+op8tkm4wXuJq9+FIiyWQmELx+OBEToArVrSAqu76b1wxOJZX1+kLqN2+5tg2LzD930EoR1xVgzz/bJkbL+0R4tPfu4j6e4fLSRa7S5bV5lckgvqaNDb42ubf7CrlcUq+76HZrFEtOkvAKYL7GBLXXMRs+CKeqT3Cy+5zNmhHiq79t7rV/xfSpQiNkHR0Jr7TKA83s2N9OXQt8V7fksa8jED1kO0hk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYw5ELzKdbsv2XgxOR/yY2w0HaDh5TgrTXFprJc3mGk=;
 b=QYJgjt/TVnNU2Uzp5uCn125Cctst2LbUu+5BdEKyc52PXR8xcSWQ+aj7mRylk7usv/YlVSnEiYnx/+qWDhrdsQOFnI7AUISrXuKSf1xI9383g36MPBWXG1eEThM/e6Lx2df047DCy96P1WKqqMiy7RNTVZX/u7ccnhOopjmihHuvVzntMRzgcmXL7O9dHiscyQr4wYe6G1vKf5j4Lkc+rwZ2x9WcbO8j2PJ3ezypYPtrNpq6I5z9R0OwvXzF5ajn6nlE2cqsWcZdLAs1M2Xigb9Ehq5sI96Mc0jh97NaUbjn48HMqQ3CvrTg2pwzQcgx2AILF5OmWtlZTKlLS/+jJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYw5ELzKdbsv2XgxOR/yY2w0HaDh5TgrTXFprJc3mGk=;
 b=sF8GeaXzFr6J3ArDLQwzmkjLb82dncNyEBYxnDUIow2t9+dA3RkQdzhysZpTIHjQpRdmT/TVP4OoIEMGR+81B8IxJs5MfeCZiXaVKlaPU+tbf+lcRXZL+XhSrjqgQyYuCuYPxyUlJGxsmUgn8fnVgelX1DXTkNYkWTPuJ4xHkTELiy152mvBRBXKayXEB7Z4ZaLd+fup4Fp3ctO+15nDryKu9V0CF/DWe3BlDjnFf4CuBX3Rs/G3Sw+BgInqt+Od3sTZtHt0LiFsz4okSb783hFdvSA/vK//NYsUv+vPOQ0+V/zVip1nHpgweo1dFm1YYVZDnK78uwyxPwTgXdyV3g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6412.eurprd07.prod.outlook.com (2603:10a6:10:138::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.22; Tue, 2 Jul
 2024 15:27:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 15:27:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Index: AQHatXs42Vo/2A63BES9fBhuPzCosbHieF0AgACk6VmAAGrUgIAAGEWAgAAdSQA=
Date: Tue, 2 Jul 2024 15:27:13 +0000
Message-ID: <5894d125-0365-4f1a-91f3-0dbb56c4e4cc@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
 <20240701160122-mutt-send-email-mst@kernel.org>
 <AM8PR07MB76020A044539A40485F91F0A86DC2@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <20240702081352-mutt-send-email-mst@kernel.org>
 <52efc1b0-5451-4e9e-a05d-4db360d3c573@intel.com>
In-Reply-To: <52efc1b0-5451-4e9e-a05d-4db360d3c573@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6412:EE_
x-ms-office365-filtering-correlation-id: 0f291f34-3008-42fe-c40a-08dc9aab727a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SFhIODRYME5zRHpsUWh0SUNtK1JramV0ZlJLNzVjbkhhdnkzc1BzVFF2eEEx?=
 =?utf-8?B?V25tNHJmL2pnTkZUdUp0N0RyQmRpQ2dQZzZ5dlZSbXpVMmttOVNvMStpRFlZ?=
 =?utf-8?B?RmV1ODFEUGJ6YXBVZHhtaWVER0h2UjNZak5uMk9nM2tDdmhQbTBNdERKUHVB?=
 =?utf-8?B?WmdtZmNRZHptbW13TkJUUGp4OHpiaFR5eElENTlDcEZZd0tmcWRHNUVBSlhR?=
 =?utf-8?B?WStxUWJEcHRvR1ExNUgrOFRFRzZvZEpSbDVpZGNCMW1YR2p2Z1Q2K1dScUxk?=
 =?utf-8?B?djFuTnJiSHNIRklZckNVVjRIb1lENkdrWjJ0aWx0WXhkdTRKN3ExL3ZHY1VP?=
 =?utf-8?B?VlNSdDk5WTRHNFZNTkFpdzJwdjBIOG50Q2lzZGdpa1VyTEdOR0hnYWFhT29R?=
 =?utf-8?B?YkRNVEgyZFkyVFhwQ3RXc3VTTEV2YzdIYTkvS1NueE55N0ZLYWJRblRPN3F4?=
 =?utf-8?B?SFVWR2llWXlTRlJ1SUtjUGFlZDR3SmwxM0dUVkhCbUloRURTU3d2VTZkR0V0?=
 =?utf-8?B?K01oQSs0ZGcxMnlud0lHZ21UaDVvcHBvTlFsUDdyaFE4UFcrVXk2WGIrZ09F?=
 =?utf-8?B?SFdLMkt5K2tBVm5iNUVURENVOU4wRTBmUzVuRGxaN1MzZ1k3TFhwTjY2emV3?=
 =?utf-8?B?MWtFTXIwanlQeGI3Sjg0UU5sR0p3ODY5TUNja3VkRWZxeEE2ZTJVS011Q3Z6?=
 =?utf-8?B?NDNmRVpYNFhBVXFZWXoyQzNLUXVzVU12a0JmOXd3NDByeXpHU2ZkQUF2Tml6?=
 =?utf-8?B?T1p5NXcySjRsR3A2MkV5WCs3Z0x6UHRrZStXWEVpR3V1blVyV0FnMVZZZ3RY?=
 =?utf-8?B?aDlaZ3VBSUMwYldGN0lvVzRiT3dVd3I2c2NrMDg4a09ncnVuOE1rMlA4cGxi?=
 =?utf-8?B?YkVnYUh0Wm5jS0UyRVYyMFo1dTQ2STdISFFwcDhIa2lmWmhDSVVXZlhWUzBu?=
 =?utf-8?B?VnZ2dXFyOXFjbCt6MHluMWw2dXZoeU9DVWVzaW5Takh3ZDM4RHhPN24xODRn?=
 =?utf-8?B?Y2Zrb3RXb3I1ZWJlVDRsSWs1UWZTejJTVmkyNmlYeE9LWXlmc21jWC9rYXdM?=
 =?utf-8?B?NXFnQzdnSTFPbkJxbDBvc1ZVQVNLOVZqVlllRU1Bcy9LOFdtMThtd2pRYXhB?=
 =?utf-8?B?QzljWHJPV3ZtbDVCSWZscGlGN08wS24ySUV4dE9weCt1RnBFS2RSaEhEa2lB?=
 =?utf-8?B?T2VxTncxOU5lWlFsVTFpYnRweVlNdmlEa0U1OVI1THJlNWVEUE9YbmNkME1q?=
 =?utf-8?B?RmF1a2dlRmRobStWdm1GSytJQld1WExpSmIxK3lpVGV0cEpFTnVBd2t5Qjhr?=
 =?utf-8?B?N1FVbE5IY2ZYU1pIYVAvdW9paFpsa0txbzU5dkhXSDlnSnNNSVFGMGhERGdJ?=
 =?utf-8?B?RkI2NUJsRmlDd3dQL2hhVWhDKzdKcE03ZjJETFFtN3ZjT3ZKVVZENnpOSmYw?=
 =?utf-8?B?dzJwcFNpMno1SnVPVC9ydEN4cWRrY3Nvb3BPUk9LSktHKzEranZCc1hMc1l3?=
 =?utf-8?B?ZHFORWt5aG9wSC92aXpBaGd4SGdZYXFlZFRqdUNXbUJocFFTUDhDUU9LdDZS?=
 =?utf-8?B?RjVWeHY3YzFlRnAxWThnaVFpRDNsbFV3VFJMeXk0d3paQXZJTlplT2hJWHFV?=
 =?utf-8?B?a2t6ajZPRWtTRE1uU0VBMFl4SnBadjNTclcyekpiUnhpZUV2OUExZzIxZ2Rr?=
 =?utf-8?B?RE5yZ2dhcEp6cDA2TndZWHVLQ0p5bWpVRldLbk5SNkVNZXd1OXh6bTZ6di9H?=
 =?utf-8?B?NjMxMDJHV1NOWlVDTkRBbGVNVDI5V01ucE11RzA3a0ZoZGpWSlU2cGx3SFZB?=
 =?utf-8?Q?Qq+XCHZhtczYz9qhZzNDEnbmgTD/T/35cu91A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzNhMTlYeTRsVHRrNjAvL3RlNmxJQXQxYzcrUGNnYnZLZ215a3lCUDNRaEhO?=
 =?utf-8?B?RU42TURETDFEZ1BxM0JZaUF5TU10VlhhZTZVRTBpMkw5RS9waUY1Q25tM2dT?=
 =?utf-8?B?NlNKZitxeXE0TERxRmFSalhpODh4TmFuamNPTUZBcnZyWkNLVk02WUZ4c1Jo?=
 =?utf-8?B?aGJOZXZoUjQwTDl6NG5RMlB1bllvcXhRMkRGWFlsK1hzK2VmOWg4Z250Nllt?=
 =?utf-8?B?RjJ4cFNVMlp4QzJHNWt1TEJQL2s2ei8zcWVZRXRuVkorRFo3VERFYit2ZElT?=
 =?utf-8?B?b1BoeEpPRWRVb0lTYVUzRE5yaG12Q3pNZ3BkREg2TlRpWkR0SVFvaEhaSFNW?=
 =?utf-8?B?S0dyalZZM3Z2dmFCNXhuWCtraWtIU2JVVlpRR2dYNEZPeG52eCtxdDR3Tkpl?=
 =?utf-8?B?SitPZjZIWDJjNVNrUE9LZFlEK0dnYlV2dVJLazI0TEc1WnBvTEZjYUt5WHJQ?=
 =?utf-8?B?Tk43MlBtVG1CNzByRDExWXhVMDFaZXRYcmg1czVwTFVhczJLODgvaHpOWUdk?=
 =?utf-8?B?dEx5dVRQa2orNHJOclRLajVtRFd1ZkpWZEZIcVBBbE0xODgvY1V4ZUJIT0lS?=
 =?utf-8?B?bDJIcUx6Z2xINEFxajlMZXo4V0JrMlU2M0IvbCtFQVlKeGxUWHZyckhONHBN?=
 =?utf-8?B?THJ1L1RIU0xwL1FlZ2c0WU1LelVJWnBodXBTdVEwTFN1bC9jeG5PdVp5cW5I?=
 =?utf-8?B?K0JWczVmbGJnZk9Rd3hhVEo4MEtiRlp6YXdsaXBjUDgvcWNIcVRXNzAzY3VF?=
 =?utf-8?B?Q2RURWlMQWVaL2Z3YkNhKy9HMERidXExTXdMNm81K0R6UEFrSG5qYit4bUJU?=
 =?utf-8?B?dDVNZ3RsbXlJY0NXUEhDREx3MWRXb1VJamNlY2czNzduc1BBYkZ1ZDFhQ0hD?=
 =?utf-8?B?QXVrZkprbjhwVnQ5dUlEWkdUWlR0ZmpXNER6SGJodHFLZHpKUzNiUStYMGtx?=
 =?utf-8?B?emFPc0dhbnhUN09GWHdUTkQrTTQyNkwvaW1qVlVHNUY3Q25td2hENWk4dFp5?=
 =?utf-8?B?MjBKWjBCbUR2QlpyejllT2ZMNnl2VmxLMnVMZk9tVUZrc0s2elpxTEpER0Q3?=
 =?utf-8?B?Q1oveDZLNHp2NHFkVTl3V3RxRkMwV1p0ZU1ObFVSb3VOL0N3SGRFWEtCZlJm?=
 =?utf-8?B?YW00WnE0UzExQjJtMmhZcnJGT29hUndzUXNOZE5scDVRdnFWQ1hPeFh2ZXVs?=
 =?utf-8?B?VlZmMFBnL2NDaHFWVGpoc0dRRE96WmhDZTZmdHVkSThzZUNqU2YzZmZNM251?=
 =?utf-8?B?YkhLWmNKY3hzL3FDMzVwY2c3UVZsOTZFdHNMZTl6SW03UFd6VkVad3Irbkti?=
 =?utf-8?B?OUJBM3c4VnBFbWgrZXVUa1ZldFYvV25NSHoyZ2Fjd1A3cEZ1ajNRZytXUCtZ?=
 =?utf-8?B?ZU03RjBNczNpcmpDUFN1c1BPZTg0Q1ZHWUc3VU0xeE9iUHRJNmVwVjF1STk3?=
 =?utf-8?B?U0c1cW5vdVFNanlHaGIzcnJ5UEY1dTJZZzF1Y1BxZCsvbGF5VW1qVVZwc2tr?=
 =?utf-8?B?dGJGNVdaUTNncC91MFNiSXdHS3c3ZGZwZ1JURm9iQ1JuYk8zZDlMTE8yN1J1?=
 =?utf-8?B?elFYck5XWUlYSHE1Y3NhbVdZNnFid0c4QzNYWmkyUDdKNG04ZHV5bDVNNkZi?=
 =?utf-8?B?RnBFS3VDeFhTcnd2SkR1UnJpUVgxdGlZS3JDRE9ENGVZMFZmT0FRWFJFLzZo?=
 =?utf-8?B?T1hERGtpdXRYNjFnRWVrQzQ2bVl6a1YwY3dBMjE0OHlHUmp2dGlvb2M1MVI0?=
 =?utf-8?B?dFkyY0JXL2c4aW5qcFAzQ2xHa01Yd2U2NE5tSHlBd0FEKyt6MHRaZzVJeGRY?=
 =?utf-8?B?TnlweUNOS1VsTlRYNG94NDM4ZVlXQXJBdnhjOEdwdjc4VzRCZkdKVzVGSjBQ?=
 =?utf-8?B?RzFzU28venNxQi8xUlYvRjA3a3hVNkw1cTB6bFZ2Wmgzd3RoclNtWkxXa3hi?=
 =?utf-8?B?RjB5K1BVc1RrWXEzWk5RUXRlQUJUeGR6YVhnUEQ4eVJPT3h6bGFwSXQ3M3gv?=
 =?utf-8?B?b1NBeURQZzJMdk9kM2U4ejFOMGw0RWx0TDdXTm9ubmJ6UjlHVFArSWtKN2Ri?=
 =?utf-8?B?Zzl3U2hiZ21zdnVPSzYva3F1M0FGSzhsZC80RnduU3YrWlVXanVBcWZET1h6?=
 =?utf-8?B?NDRadXNmS1NDYWk1ZzdPOXVVUGNZNms2TTlnaWtYbU56d2pXOFV4aGl5bUxw?=
 =?utf-8?Q?97XBCxkwMyZ9lPJjHocp2rk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63D88E311B47742ABECFAB900DBF5EF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f291f34-3008-42fe-c40a-08dc9aab727a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 15:27:13.0231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l194tkFj4yJOwA/738FVxQYd9DUjJ1qKEtvUDfAtyI3dzdaLzIbY7F0Mr6bYuRE+8IETKgNAtIOPlt9KEyNzmEN3Ah1y4xvytlnjlowFeI6tIz954v05pPvzRkC1ijo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6412
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQpPbiAwMi8wNy8yMDI0IDE1OjQyLCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywNCj4gdW5sZXNz
IHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNv
bnRlbnQNCj4gaXMgc2FmZS4NCj4NCj4NCj4gT24gMjAyNC83LzIgMjA6MTUsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToNCj4+IE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDA1OjU3OjU3QU0gKzAw
MDAsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4g4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB4pSB
DQo+Pj4NCj4+PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPj4+
IFNlbnQ6IDAxIEp1bHkgMjAyNCAyMjowMg0KPj4+IFRvOiBDTEVNRU5UIE1BVEhJRVUtLURSSUYg
PGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+IENjOiBxZW11LWRldmVsQG5v
bmdudS5vcmcgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IGphc293YW5nQHJlZGhhdC5jb20NCj4+
PiA8amFzb3dhbmdAcmVkaGF0LmNvbT47IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbQ0KPj4+IDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+Ow0KPj4+IGtldmluLnRpYW5AaW50ZWwuY29tIDxrZXZp
bi50aWFuQGludGVsLmNvbT47IHlpLmwubGl1QGludGVsLmNvbQ0KPj4+IDx5aS5sLmxpdUBpbnRl
bC5jb20+OyBqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tDQo+Pj4gPGpvYW8ubS5tYXJ0aW5zQG9y
YWNsZS5jb20+Ow0KPj4+IHBldGVyeEByZWRoYXQuY29tIDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4+
PiBTdWJqZWN0OiBSZTogW1BBVENIIGF0c192dGQgdjUgMDAvMjJdIEFUUyBzdXBwb3J0IGZvciBW
VC1kDQo+Pj4NCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNo
bWVudHMgb3IgY2xpY2sgbGlua3MsDQo+Pj4gdW5sZXNzIHRoaXMNCj4+PiBlbWFpbCBjb21lcyBm
cm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+
DQo+Pj4NCj4+PiBPbiBNb24sIEp1biAwMywgMjAyNCBhdCAwNTo1OTozOEFNICswMDAwLCBDTEVN
RU5UIE1BVEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4+IEZyb206IENsw6ltZW50IE1hdGhpZXUtLURy
aWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+Pg0KPj4+PiBUaGlzIHNl
cmllcyBiZWxvbmdzIHRvIGEgbGlzdCBvZiBzZXJpZXMgdGhhdCBhZGQgU1ZNIHN1cHBvcnQgZm9y
IFZULWQuDQo+Pj4+DQo+Pj4+IEFzIGEgc3RhcnRpbmcgcG9pbnQsIHdlIHVzZSB0aGUgc2VyaWVz
IGNhbGxlZCAnaW50ZWxfaW9tbXU6IEVuYWJsZQ0KPj4+PiBzdGFnZS0xDQo+Pj4gdHJhbnNsYXRp
b24nIChyZmMyKSBieSBaaGVuemhvbmcgRHVhbiBhbmQgWWkgTGl1Lg0KPj4+Pg0KPj4+PiBIZXJl
IHdlIGZvY3VzIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBBVFMgc3VwcG9ydCBpbiB0aGUgSU9N
TVUgYW5kDQo+Pj4+IG9uIGENCj4+PiBQQ0ktbGV2ZWwNCj4+Pj4gQVBJIGZvciBBVFMgdG8gYmUg
dXNlZCBieSB2aXJ0dWFsIGRldmljZXMuDQo+Pj4+DQo+Pj4+IFRoaXMgd29yayBpcyBiYXNlZCBv
biB0aGUgVlQtZCBzcGVjaWZpY2F0aW9uIHZlcnNpb24gNC4xIChNYXJjaCAyMDIzKS4NCj4+Pj4g
SGVyZSBpcyBhIGxpbmsgdG8gYSBHaXRIdWIgcmVwb3NpdG9yeSB3aGVyZSB5b3UgY2FuIGZpbmQg
dGhlIGZvbGxvd2luZw0KPj4+IGVsZW1lbnRzIDoNCj4+Pj4gICAgICAtIFFlbXUgd2l0aCBhbGwg
dGhlIHBhdGNoZXMgZm9yIFNWTQ0KPj4+PiAgICAgICAgICAtIEFUUw0KPj4+PiAgICAgICAgICAt
IFBSSQ0KPj4+PiAgICAgICAgICAtIERldmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQo+Pj4+ICAg
ICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5IHRyYW5zbGF0ZWQgYWRkcmVzc2VzDQo+Pj4+
ICAgICAgLSBBIGRlbW8gZGV2aWNlDQo+Pj4+ICAgICAgLSBBIHNpbXBsZSBkcml2ZXIgZm9yIHRo
ZSBkZW1vIGRldmljZQ0KPj4+PiAgICAgIC0gQSB1c2Vyc3BhY2UgcHJvZ3JhbSAoZm9yIHRlc3Rp
bmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQo+Pj4+DQo+Pj4+IGh0dHBzOi8vZXVyMDYu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD0NCj4+PiBodHRwcyUzQSUyRiUy
RmdpdGh1Yi5jb20lMkZCdWxsU2VxdWFuYSUyRlFlbXUtaW4tZ3Vlc3QtU1ZNLWRlbW8mZGF0YT0N
Cj4+PiAwNSU3QzAyJTdDY2xlbWVudC5tYXRoaWV1LS1kcmlmJTQwZXZpZGVuLmNvbSU3Q2Y1NzU5
YWVmY2M1ZjRlN2Q0ZTZjMDhkYzlhMDhkMjlhJTdDN2QxYzc3ODUyZDhhNDM3ZGI4NDIxZWQ1ZDhm
YmUwMGElN0MwJTdDMCU3QzYzODU1NDYwOTg4MjU0NDE5NSU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MwJTdDJTdDJTdDDQo+Pj4NCj4+PiAmc2RhdGE9Mkd6YTFWRDdoS3IxU3gz
Zk9Mb1JoNnRrM3RhU1BLVG41bmZpbWhQTHo3MCUzRCZyZXNlcnZlZD0wDQo+Pj4NCj4+PiBJIHdp
bGwgbWVyZ2UsIGJ1dCBjb3VsZCB5b3UgcGxlYXNlIHJlc2VuZCB0aGlzIHVzaW5nIGdpdCBmb3Jt
YXQtcGF0Y2gNCj4+PiBmb3IgZm9ybWF0dGluZz8gIFRoZSBwYXRjaGVzIGhhdmUgdHJhaWxpbmcg
Q1JzIGFuZCBkb24ndCBzaG93IHdoaWNoDQo+Pj4gc2hhMQ0KPj4+IHRoZXkgYXJlIGZvciwgd2hp
Y2ggbWFrZXMgcmUtYXBwbHlpbmcgdGhlbSBhZnRlciBlYWNoIGNoYW5nZSBwYWluZnVsLg0KPj4+
DQo+Pj4NCj4+Pg0KPj4+IEhpIE1pY2hhZWwsDQo+Pj4gSSBzZW50IHRoZSBzZXJpZXMgYWdhaW4g
d2l0aG91dCB0aGUgdHJhaWxpbmcgbmV3IGxpbmUuDQo+Pj4gVGVsbCBtZSBpZiBpdCdzIGJldHRl
ci4NCj4+Pg0KPj4+IElzIFpoZW56aG9uZydzIEZMVFMgc2VyaWVzIG1lcmdlZD8gSWYgbm90LCBp
dCBtaWdodCB0aGUgY2F1c2Ugb2YgdGhlDQo+Pj4gc2hhMQ0KPj4+IHByb2JsZW0geW91IGFyZSBm
YWNpbmcNCj4+DQo+PiBJIGRvbid0IHRoaW5rIEkgaGF2ZSBGTFRTIGluIGFueSBxdWV1ZS4NCj4+
DQo+PiBJZiB5b3VyIHNlcmllcyBoYXMgYSBkZXBlbmRlbmN5IHBsZWFzZSBzcGVjaWZ5IHRoaXMg
aW4NCj4+IHRoZSBjb3ZlciBsZXR0ZXIuDQo+Pg0KPj4gQWx0ZXJuYXRpdmVseSBqdXN0IGluY2x1
ZGUgdGhlIGRlcGVuZGVuY3kgaW4gdGhlIHBvc3RpbmcuDQo+DQo+IHNlZW1zIHRoaXMgaXMgdGhl
IGRlcGVuZGVuY3kuDQo+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NDA1MjIwNjIzMTMuNDUzMzE3LTEtemhlbnpob25nLmR1YW5AaW50ZWwuY29tLyN0DQo+DQo+DQpT
b3JyeSBpZiBJIGRpZG4ndCBtYWtlIGl0IGNsZWFyLg0KDQpBcyBtZW50aW9uZWQgaW4gdGhlIGNv
dmVyIGxldHRlciwgdGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gWmhlbnpob25nJ3MNCmFuZCBZaSdz
IEZMVFMgaW1wbGVtZW50YXRpb24gd2hpY2ggKEFGQUlLKSBoYXMgb25seSBiZSBwb3N0ZWQgYXMg
YW4gUkZDDQpzbyBmYXIgKGtlZXAgbWUgdXAgdG8gZGF0ZSBwbGVhc2UpLg0KDQp2NSBpcyBiYXNl
ZCBvbiB0aGF0IGJyYW5jaCA6DQpodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJl
ZS96aGVuemhvbmcvaW9tbXVmZF9uZXN0aW5nX3JmY3YyDQoNCj4+DQo+Pg0KPj4NCj4+DQo+Pj4g
VGhhbmtzDQo+Pj4+IGNtZA0KPj4+DQo+Pj4NCj4+Pj4gdjINCj4+Pj4gICAgICAtIGhhbmRsZSBo
dWdlIHBhZ2VzIGJldHRlciBieSBkZXRlY3RpbmcgdGhlIHBhZ2UgdGFibGUgbGV2ZWwNCj4+Pj4g
YXQgd2hpY2ggdGhlDQo+Pj4gdHJhbnNsYXRpb24gZXJyb3JzIG9jY3VyDQo+Pj4+ICAgICAgLSBD
aGFuZ2VzIGFmdGVyIHJldmlldyBieSBaaGVuWmhvbmcgRHVhbiA6DQo+Pj4+ICAgICAgICAtIFNl
dCB0aGUgYWNjZXNzIGJpdCBhZnRlciBjaGVja2luZyBwZXJtaXNzaW9ucw0KPj4+PiAgICAgICAg
LSBoZWxwZXIgZm9yIFBBU0lEIGFuZCBBVFMgOiBtYWtlIHRoZSBjb21taXQgbWVzc2FnZSBtb3Jl
DQo+Pj4+IGFjY3VyYXRlDQo+Pj4gKCdwcmVzZW50JyByZXBsYWNlZCB3aXRoICdlbmFibGVkJykN
Cj4+Pj4gICAgICAgIC0gcGNpZV9wYXNpZF9pbml0OiBhZGQgUENJX1BBU0lEX0NBUF9XSURUSF9T
SElGVCBhbmQgdXNlIGl0DQo+Pj4+IGluc3RlYWQgb2YNCj4+PiBQQ0lfRVhUX0NBUF9QQVNJRF9T
SVpFT0YgZm9yIHNoaWZ0aW5nIHRoZSBwYXNpZCB3aWR0aCB3aGVuIHByZXBhcmluZw0KPj4+IHRo
ZQ0KPj4+IGNhcGFiaWxpdHkgcmVnaXN0ZXINCj4+Pj4gICAgICAgIC0gcGNpOiBkbyBub3QgY2hl
Y2sgcGNpX2J1c19ieXBhc3NfaW9tbXUgYWZ0ZXIgY2FsbGluZw0KPj4+IHBjaV9kZXZpY2VfZ2V0
X2lvbW11X2J1c19kZXZmbg0KPj4+PiAgICAgICAgLSBkbyBub3QgYWx0ZXIgZm9ybWF0dGluZyBv
ZiBJT01NVVRMQkVudHJ5IGRlY2xhcmF0aW9uDQo+Pj4+ICAgICAgICAtIHZ0ZF9pb3ZhX2ZsX2No
ZWNrX2Nhbm9uaWNhbCA6IGRpcmVjdGx5IHVzZSBzLT5hd19iaXRzDQo+Pj4+IGluc3RlYWQgb2Yg
YXcNCj4+PiBmb3IgdGhlIHNha2Ugb2YgY2xhcml0eQ0KPj4+Pg0KPj4+PiB2Mw0KPj4+PiAgICAg
IC0gcmViYXNlIG9uIG5ldyB2ZXJzaW9uIG9mIFpoZW56aG9uZydzIGZsdHMgaW1wbGVtZW50YXRp
b24NCj4+Pj4gICAgICAtIGZpeCB0aGUgYXRjIGxvb2t1cCBvcGVyYXRpb24gKGNoZWNrIHRoZSBt
YXNrIGJlZm9yZQ0KPj4+PiByZXR1cm5pbmcgYW4gZW50cnkpDQo+Pj4+ICAgICAgLSBhZGQgYSB1
bml0IHRlc3QgZm9yIHRoZSBBVEMNCj4+Pj4gICAgICAtIHN0b3JlIGEgdXNlciBwb2ludGVyIGlu
IHRoZSBpb21tdSBub3RpZmllcnMgdG8gc2ltcGxpZnkgdGhlDQo+Pj4gaW1wbGVtZW50YXRpb24g
b2Ygc3ZtIGRldmljZXMNCj4+Pj4gICAgICBDaGFuZ2VzIGFmdGVyIHJldmlldyBieSBaaGVuemhv
bmcgOg0KPj4+PiAgICAgICAgLSBzdG9yZSB0aGUgaW5wdXQgcGFzaWQgaW5zdGVhZCBvZiByaWQy
cGFzaWQgd2hlbiByZXR1cm5pbmcNCj4+Pj4gYW4gZW50cnkNCj4+PiBhZnRlciBhIHRyYW5zbGF0
aW9uDQo+Pj4+ICAgICAgICAtIHNwbGl0IHRoZSBBVEMgaW1wbGVtZW50YXRpb24gYW5kIGl0cyB1
bml0IHRlc3RzDQo+Pj4+DQo+Pj4+IHY0DQo+Pj4+ICAgICAgQ2hhbmdlcyBhZnRlciBpbnRlcm5h
bCByZXZpZXcNCj4+Pj4gICAgICAgIC0gRml4IHRoZSBub3dyaXRlIG9wdGltaXphdGlvbiwgYW4g
QVRTIHRyYW5zbGF0aW9uIHdpdGhvdXQNCj4+Pj4gdGhlIG5vd3JpdGUNCj4+PiBmbGFnIHNob3Vs
ZCBub3QgZmFpbCB3aGVuIHRoZSB3cml0ZSBwZXJtaXNzaW9uIGlzIG5vdCBzZXQNCj4+Pj4NCj4+
Pj4gdjUNCj4+Pj4gICAgICBDaGFuZ2VzIGFmdGVyIHJldmlldyBieSBQaGlsaXBwZSA6DQo+Pj4+
ICAgICAgICAtIGNoYW5nZSB0aGUgdHlwZSBvZiAnbGV2ZWwnIHRvIHVuc2lnbmVkIGluIHZ0ZF9s
b29rdXBfaW90bGINCj4+Pj4NCj4+Pj4NCj4+Pj4NCj4+Pj4gQ2zDqW1lbnQgTWF0aGlldS0tRHJp
ZiAoMjIpOg0KPj4+PiAgICBpbnRlbF9pb21tdTogZml4IEZSQ0QgY29uc3RydWN0aW9uIG1hY3Jv
Lg0KPj4+PiAgICBpbnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRjaA0KPj4+PiAgICBpbnRlbF9p
b21tdTogcmV0dXJuIHBhZ2Ugd2FsayBsZXZlbCBldmVuIHdoZW4gdGhlIHRyYW5zbGF0aW9uIGZh
aWxzDQo+Pj4+ICAgIGludGVsX2lvbW11OiBkbyBub3QgY29uc2lkZXIgd2FpdF9kZXNjIGFzIGFu
IGludmFsaWQgZGVzY3JpcHRvcg0KPj4+PiAgICBtZW1vcnk6IGFkZCBwZXJtaXNzaW9ucyBpbiBJ
T01NVUFjY2Vzc0ZsYWdzDQo+Pj4+ICAgIHBjaWU6IGFkZCBoZWxwZXIgdG8gZGVjbGFyZSBQQVNJ
RCBjYXBhYmlsaXR5IGZvciBhIHBjaWUgZGV2aWNlDQo+Pj4+ICAgIHBjaWU6IGhlbHBlciBmdW5j
dGlvbnMgdG8gY2hlY2sgaWYgUEFTSUQgYW5kIEFUUyBhcmUgZW5hYmxlZA0KPj4+PiAgICBpbnRl
bF9pb21tdTogZGVjbGFyZSBzdXBwb3J0ZWQgUEFTSUQgc2l6ZQ0KPj4+PiAgICBwY2k6IGNhY2hl
IHRoZSBidXMgbWFzdGVyaW5nIHN0YXR1cyBpbiB0aGUgZGV2aWNlDQo+Pj4+ICAgIHBjaTogYWRk
IElPTU1VIG9wZXJhdGlvbnMgdG8gZ2V0IGFkZHJlc3Mgc3BhY2VzIGFuZCBtZW1vcnkgcmVnaW9u
cw0KPj4+PiAgICAgIHdpdGggUEFTSUQNCj4+Pj4gICAgbWVtb3J5OiBzdG9yZSB1c2VyIGRhdGEg
cG9pbnRlciBpbiB0aGUgSU9NTVUgbm90aWZpZXJzDQo+Pj4+ICAgIHBjaTogYWRkIGEgcGNpLWxl
dmVsIGluaXRpYWxpemF0aW9uIGZ1bmN0aW9uIGZvciBpb21tdSBub3RpZmllcnMNCj4+Pj4gICAg
aW50ZWxfaW9tbXU6IGltcGxlbWVudCB0aGUgZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgaW9tbXUg
b3BlcmF0aW9uDQo+Pj4+ICAgIGludGVsX2lvbW11OiBpbXBsZW1lbnQgdGhlIGdldF9tZW1vcnlf
cmVnaW9uX3Bhc2lkIGlvbW11IG9wZXJhdGlvbg0KPj4+PiAgICBtZW1vcnk6IEFsbG93IHRvIHN0
b3JlIHRoZSBQQVNJRCBpbiBJT01NVVRMQkVudHJ5DQo+Pj4+ICAgIGludGVsX2lvbW11OiBmaWxs
IHRoZSBQQVNJRCBmaWVsZCB3aGVuIGNyZWF0aW5nIGFuIGluc3RhbmNlIG9mDQo+Pj4+ICAgICAg
SU9NTVVUTEJFbnRyeQ0KPj4+PiAgICBhdGM6IGdlbmVyaWMgQVRDIHRoYXQgY2FuIGJlIHVzZWQg
YnkgUENJZSBkZXZpY2VzIHRoYXQgc3VwcG9ydCBTVk0NCj4+Pj4gICAgYXRjOiBhZGQgdW5pdCB0
ZXN0cw0KPj4+PiAgICBtZW1vcnk6IGFkZCBhbiBBUEkgZm9yIEFUUyBzdXBwb3J0DQo+Pj4+ICAg
IHBjaTogYWRkIGEgcGNpLWxldmVsIEFQSSBmb3IgQVRTDQo+Pj4+ICAgIGludGVsX2lvbW11OiBz
ZXQgdGhlIGFkZHJlc3MgbWFzayBldmVuIHdoZW4gYSB0cmFuc2xhdGlvbiBmYWlscw0KPj4+PiAg
ICBpbnRlbF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIEFUUw0KPj4+Pg0KPj4+PiAgIGh3L2kzODYv
aW50ZWxfaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwgMTQyICsrKysrLQ0KPj4+PiAgIGh3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCAgICAgICAgICAgIHwgICA2ICstDQo+Pj4+ICAg
aHcvcGNpL3BjaS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMjcgKysrKystDQo+
Pj4+ICAgaHcvcGNpL3BjaWUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDIgKysN
Cj4+Pj4gICBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggICAgICAgICAgICAgICAgICAgICB8ICA1MSAr
Ky0NCj4+Pj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgICAgICAgICAgICB8ICAg
MiArLQ0KPj4+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaS5oICAgICAgICAgICAgICAgICAgICAgIHwg
MTAxICsrKysrDQo+Pj4+ICAgaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPj4+PiAgIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCAgICAgICAgICAgICAgICAg
ICAgIHwgICA5ICstDQo+Pj4+ICAgaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmggICAgICAgICAg
ICAgICAgfCAgIDMgKw0KPj4+PiAgIGluY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lf
cmVncy5oIHwgICAxICsNCj4+Pj4gICBzeXN0ZW0vbWVtb3J5LmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyMCArDQo+Pj4+ICAgdGVzdHMvdW5pdC9tZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgICAgfCAgIDEgKw0KPj4+PiAgIHRlc3RzL3VuaXQvdGVzdC1hdGMuYyAgICAgICAgICAg
ICAgICAgICAgIHwgNTI3DQo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICB1dGls
L2F0Yy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDIxMSArKysrKysrKysNCj4+
Pj4gICB1dGlsL2F0Yy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExNyArKysr
Kw0KPj4+PiAgIHV0aWwvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCj4+Pj4gICAxNyBmaWxlcyBjaGFuZ2VkLCAxMzMwIGluc2VydGlvbnMoKyksIDMyIGRlbGV0
aW9ucygtKQ0KPj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy91bml0L3Rlc3QtYXRjLmMN
Cj4+Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9hdGMuYw0KPj4+PiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB1dGlsL2F0Yy5oDQo+Pj4+DQo+Pj4+IC0tDQo+Pj4+IDIuNDUuMQ0KPj4+DQo+Pg0K
Pg0KPiAtLQ0KPiBSZWdhcmRzLA0KPiBZaSBMaXUNCg==

