Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388D2D44C41
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgMwk-0003Kn-HN; Thu, 15 Jan 2026 07:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMwi-0003GD-BT; Thu, 15 Jan 2026 07:59:28 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vgMwg-0006ok-NS; Thu, 15 Jan 2026 07:59:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz/0txr701Tgfkkb3sjLunmiAZno8/P+VVqUwKw9nGv1kW3soST4LDSG2PKoSGntLIrTm5yhUsV2wmAqHEcSOxYoD5OHQ1FQDQi9xk5Klj6ZWWVmsDOtdxKEOvcorAVXGTCgfhTZfEdvLeRZFlb/1OuEp1Lv2P2fSf2gZhJbWJKzg1VY7Q1hpOMSkRW/gZxdOMfA9ohliEqz6v6/sZtTJoJMdPfnqzl69OvOdctSwcH7Wp798F++pPNOG5+DhTzmXco6rIiTioICGyzZFVQmVW+21IPtDV5htIvJ6aqq+uCX+KB+/mJRzHzc7uW7jwnDS2gYeTaSjEVuo2wXVmCucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRec5t2Mkbr3LHjI/joIYjxMmJMhIr+GsFJ1BPvyqY8=;
 b=wyWqNoyYP7MFCT0g2WxXG+lqTqxDHAQCwpOzVuYY0jUi3gdc53DIt97RjzLyNpdSY1SMlffJvhBysLWODQl+4QC7Z1BkhtlHncktBC7LEH1wFbXWM5FsHLM6HMVzBCCo5gpyXSFgNA2HNSEYw9Ze6zr0FaydN1DT5F7qJgpkchnwNblIP9BQxXAJ1LZKUOhvWS5DTPJ52BQeEMjk+hePztbXNVYAxnbI8NKvEEf0WitBHeH5wMDwhRMV1K/fAyPtbKqQ1OM4AlbEhVcd5aMxuSNYm885y5XyUF2e4M5FuA4z8Tx+ciah+HpQVdGLUy7SXlEwDbAzyhr7eaR89bAu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRec5t2Mkbr3LHjI/joIYjxMmJMhIr+GsFJ1BPvyqY8=;
 b=YjtwSF6mi+VJK/ut/IZnViReXnb5ggF1W6Tbx4o5P4nm4gq2jjF9eD2M4ZFCL7eO/tonudeTl7JCUC3cKjFEMD5N3Ie+Xti3AhudWMtujpQsgH0oavM5cSOUMsTM2EXzbjhDeP2itDK5Dd/DVQvO+iidjM74gaJatWwZfjGh0yEFSpa7eArnkEYjIUDmRVwTShJGvxtpaVfzeBeO9MIIEGf/77iuC3Bcr1VQJGodlxa7timV2cXC5Ku37Gm1XLLFGY2cY5bijpC+frvmgeCkXZpR61FIB+XxuAVFPLp95kOzHLAOzLEt4k6zchfTpFggNTq+sm2P5u3t6GF7b2O+gw==
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com (2603:10a6:803:e6::13)
 by AS8PR09MB6257.eurprd09.prod.outlook.com (2603:10a6:20b:5b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.2; Thu, 15 Jan
 2026 12:59:20 +0000
Received: from VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387]) by VI1PR09MB2798.eurprd09.prod.outlook.com
 ([fe80::d8f:f20a:9e1a:9387%7]) with mapi id 15.20.9542.001; Thu, 15 Jan 2026
 12:59:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v1 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
Thread-Topic: [PATCH v1 1/2] hw/riscv: Fix integer overflow in cm_base
 calculation
Thread-Index: AQHcg6KKHohQLgT/bkyt3PokVm99B7VPd0gAgAO+9oA=
Date: Thu, 15 Jan 2026 12:59:18 +0000
Message-ID: <4c05e7e0-840f-481a-bca7-7a3392bf0e3f@htecgroup.com>
References: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
 <20260112090458.2345280-2-djordje.todorovic@htecgroup.com>
 <CAKmqyKNMt=NH4r8o6k4jLmKJ9Su_y+o++6tZF1okmgVJ11MwYA@mail.gmail.com>
In-Reply-To: <CAKmqyKNMt=NH4r8o6k4jLmKJ9Su_y+o++6tZF1okmgVJ11MwYA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR09MB2798:EE_|AS8PR09MB6257:EE_
x-ms-office365-filtering-correlation-id: d90c8f83-5afd-4d85-e210-08de5435e4d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dGh0ZitqWW5XYmU5Q2xnVEpzanlRbDlpZnJUcklQK3lzSW1nYmJuS1VGRU1Z?=
 =?utf-8?B?UGttak44ZWFGeVRKOTFDL2ZDbm5BaUVOdUVMZitkYUc1d2dzaDRWRXBYdGpF?=
 =?utf-8?B?YXR2L3dMdEdLYmxPaml4enVWR3dNZEZ1c3BieTJtUWtPakZ0cjhpTzdhejly?=
 =?utf-8?B?UGpHOVgxWHlwRys1b1JoWk4wakdNWlI3bVZHNHVCYnJ2dUpzWWRsdU1wSWl3?=
 =?utf-8?B?NzNlcitDdzdaY0JWckFmL3J3Zjg2L2tWT2UyRDJlY0k2OFFzaC9RN0NzOFE0?=
 =?utf-8?B?USthakJVa25KaWJwMC82SkZiWURVdHlMRnZPUzBNMW03ZXZUVzJKdjhveGhL?=
 =?utf-8?B?SnZySHBwUHpsbnJoOHVlVWd0M0JzRVRqU1JxY3lRckhyVktuWVNCT3ZzWWRD?=
 =?utf-8?B?UDRhSDJ3V29GalR0U2hzazVBenhhQmh6NXhlY3RvK2o2dmFXc0JpZmZrbmY0?=
 =?utf-8?B?MjNVZHBFakxnUlN2bHZoTHhjSlhrVTZuZ1hHVUhoSGE2UlVNd3ZTMGN0RHV3?=
 =?utf-8?B?YXVqTWMxR00wdStKMDVhcG9ub283UDdVVXROR1hMbE0xR0V1L0FOT0lQdnBn?=
 =?utf-8?B?NkNRTTVENGljZmRxamg2Zm1SZjd0eFlQTnJXdHdjMXlZSmZZK3REcW1wV2cr?=
 =?utf-8?B?Qi9PaUc1TEJXc3k3bktQM01KdWpDMS96aVVoa2ZPM05sWnVjb2pXR1RWdGdr?=
 =?utf-8?B?V2tjWkI5cGwrQmFMYzcxUmk4L0pHdElscjRlVFpLSzdIek9KSEFSUWEyMmcy?=
 =?utf-8?B?eXpMUVp1czAwS0Vmb094M3RMRStTUUdoeFgzczE5NkR3cVV0aTZuREZsQnBh?=
 =?utf-8?B?dmJJMmVId2ZLQW9USkJ6MVp0VXhHZUtINGJlbVZRSXlCNE9MeVc4eTRiR2pQ?=
 =?utf-8?B?Um94cWdhTEVncFRkSnpYTDR4aURxSjYxQVFGS0NxYVNNTzFZVVp6VzNCT2tI?=
 =?utf-8?B?S0xabGJKd2EyeEVKbnZtZUVxYkFaN3FUR2RHZDljek00TWFGNEpPanZzVUtG?=
 =?utf-8?B?d3QwTGZPbTBacU1meEYrOHZkVE1RNCtDWGJiZ1VNWFRoRDY0YlpJUksvTXhW?=
 =?utf-8?B?cyt6SUtieGdmYlMwQVNvWWt6dHp2bjQ5bklFeUt4WUIyaUM2N2ZXZm1neE84?=
 =?utf-8?B?RFNWVkJ3SHFGbS83aGRoYUZLNnpnVXdWMTVFODVmaE0vS1V2dnZwbS9xaWZu?=
 =?utf-8?B?Rlo4WHRXU29XT2NxMGJIZzE0UXF2emV0ZVFuY0lxWnhoMXNtL3hFbUhFMkht?=
 =?utf-8?B?M0V0RjFZdUpLdXp6QmQzeC90eU81alBnUVZzNkNSb1RBZUMrT1ZCRkpKWTNM?=
 =?utf-8?B?QVFKVStERVNHb3pQTHYyWnpLeHppR0hURVFNeHhVanloVUZORFRMeGd1MlFJ?=
 =?utf-8?B?OFFRZlpsc0c2WFEvK2pPd3RPMEJNSUhrV2IyUk5TbW9uUUFNV2RLSDJTTmFH?=
 =?utf-8?B?MGlRRU9maDNHVVpoYm51UGE1SURndXZQTHJJa0Eva3BmclJhNzJ0cXZaa3lG?=
 =?utf-8?B?MmUvcjNFdXo1M05JcWZhcDNHSTNlbnE4QjB3WWw5S0x5QVkyNDFxRU5VOUJN?=
 =?utf-8?B?SGlQVmZaeG5HL2FLMUZVaEJ6Z3BKRXltZFRxVFc1dUFnaFZseS95d1VMa0xY?=
 =?utf-8?B?V3lSR2hTME1UNUQzc1Z0WlhNcjNFaGVJUG51QzZlS3k3d2Zmb2puS1Y1TWcw?=
 =?utf-8?B?SUhIZENWRnlmZVcvZ1BHeXh5V3U4R3ZVTXdrYmRRc25rR2Y3T0J1Y2NLdkFi?=
 =?utf-8?B?OW15RkRUSUJqeDhYN2NrMlBPK2paY3M2ZHVvL1lBK2xBdFh1RCsvUkZxenpX?=
 =?utf-8?B?Mm9uTmgwNldNY0dWOHAyZE9udEd5cUxBemw0eHVRbDJyNHl0UnFOQUxFaEhD?=
 =?utf-8?B?a1BFKzZOK1RqYVgyMnNSUllWb0tKSVRLdTY4ekR5UWxHYllTVmpVYkhrTU5D?=
 =?utf-8?B?S2ZxeEl1dHpiaUtOTWdVbmZPNytRb1gvQ1dCVVh4dEVHeFkwQ2F2TjVQNFNI?=
 =?utf-8?B?M0lKcjErU3FrWjVyN2M5aHJzdkdyQ2FuMzVZU3pocGNGZ0ttS0NlSm91OGNW?=
 =?utf-8?B?WFBEM1p0YXRKUXJXTnNDc2h0YmxCbnRDang5bW1YMGZTTzRZZ3lkbEZENEQy?=
 =?utf-8?B?Nm5PWDBVdlY2VGhEVnNqV2I4OHZoc2hnOEJhckhEOTJyTHZMQzZHSXArVGJr?=
 =?utf-8?Q?KJqe287CdcRSyLx2V2wlvBQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR09MB2798.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVjM0ZWRkk2ZmpTRmRFTjFpdEJUTlFBQkIxbEhaVDFGZld1bG9zWEJ1NHhH?=
 =?utf-8?B?UXpOUUdqZW9BTHhONkwzSkpnOVRhWitSOFRzSEFIT1RxTmwyd0dDTTRVMnk4?=
 =?utf-8?B?aEZYYWp5cEptQTJ1WStUN3l4L29IZWZoTkRIeFFyUXZnNzdNWk0xTkpPTWlk?=
 =?utf-8?B?c3N1em82Skg4a0REbVhTNHVJeHBmNGhsRGpwN1ZzYlRNVm1WV1RrbnU4MzNV?=
 =?utf-8?B?VWIwUmZKNmkzUHUzVU1heHVsd1M0dkFUdi81ZlR6OE5YNXJqQ29jMTMzTE5j?=
 =?utf-8?B?b1Mwem14QnVZRzI0T2dpYklrSkYxLzM5NXB1eVUxUnNiVlpmVC9qRGdZMEln?=
 =?utf-8?B?STNzS1VWUzl6dkM1MGJJT2RsakpKK1Q4eHpjNWVRdWRqOGJ1bkdGeVo3c2dT?=
 =?utf-8?B?TGlVaDRod2tFL2l4dUtPNDlSQVNjSkE2bTE4c0V3NWpGV09lbXFUZGsxQ0RT?=
 =?utf-8?B?VC9vTHhZSkZUM09lTG1nZi9Fd3ZqSFhoRGFCSU9OZS83K21JekVhb3B5eFNJ?=
 =?utf-8?B?SUpYVEc2bVNJUHJjaDlXNFA2bnRpeUpEMFoxVEJoYzVBd0xCR1hObXpuMEdt?=
 =?utf-8?B?MU5NMzQvWFZyeUhRbktUbXRaTDNsVFlVM2U1UDhKdzhtN1pvRURXOW52TFdR?=
 =?utf-8?B?bW5pajBma3lRRGZJbWJrOU5ickNsTnVIckljUFJnTVh2L2h4bC9HVmpyeEx3?=
 =?utf-8?B?YW1oUmM3UVk5V0tGaGRKQ050TUFzOXk4MnFWa3RyT0EveWdabUZ0NzVSM1Y2?=
 =?utf-8?B?dmZGcm5IOWhqVjhwd053M05rdExKNzJxenYzd1A4blVVRUF6aGdnZDVad3R6?=
 =?utf-8?B?Z28wcmdMbm1zRkt3VE14N1ErVWM1cE94VWJDeDgzTDVRT0Y3a0JoYWdkeTBO?=
 =?utf-8?B?T2hMQ0w3YWQ2OGx0SGdVRm93UkVWNUlKa0RSUWNLRW4rWWtkZGFnZFNpUlho?=
 =?utf-8?B?SmZ4UHVmc0pDSU8xb2F3U0wybWRIY0dkOXVTbUJ4Z0Z0WG9tNkFDZGt3eHFh?=
 =?utf-8?B?NVR1Qm1YeUh2dTAzazJsM0tKdzI3aWoyUk5hc25UOGJmN1lqTU1tSVhjUzM0?=
 =?utf-8?B?ZXdMcXNIN2JCQXcyQ2lRS0twK21vcXBsVHBCYytmbFJGN0I4VnRzQk1nRUpw?=
 =?utf-8?B?M2hUQ0xuM2RVWGdIMzNjU0FGKzdmKzRkMVpORGxNSU1XT1JhcnF6VC83eVhT?=
 =?utf-8?B?Vk1sV3J4VnZRWURtNmJtZ1RFZElmWGRYdjk2dDhFa25mSXM0cjVxalN5ZkVZ?=
 =?utf-8?B?MmhRczlxTzBSTmpodzNhcjhtODdxdXRvdEdidVpVWUdlQTlpd1FZTDNGc2dO?=
 =?utf-8?B?anUxNE9LOHYvR0dWVU44YUVRdTF3MVN2Z3V3OHU1S3UybTk3eUxpaDVIT2Y5?=
 =?utf-8?B?Ly9UUFByUEZXaC85WU91U1liWmloNUlSRERHK2xlQWRGMmRoNkNDYzlmaStq?=
 =?utf-8?B?bjcyU1cxaDF5MVhtWmJmcVJ1NFY1UFpKczd6L012ZHEyTlFqUHZjVExiWVll?=
 =?utf-8?B?eCtmTy9mZzk5M0hQWStsa01kaTFWcUlva2plVGpzdmFXTTJ4bE01eHhVbDRq?=
 =?utf-8?B?eXA2T1FiT01IekM3d0ZSV2hqWDNJLzFkTXhHb1BhTDNtdmN0VjdnZzc2VDBs?=
 =?utf-8?B?d3Rqb3hlMkFwamd3TTI0QzArdnlabEluOS8yK09mQ2xWTTl0dnpiSldTcHls?=
 =?utf-8?B?cGkwZlJUMitWVHJUZ2dNeXpsdU9zNmdpRStzVElpVmRmdGhzNlgwNzJadkdU?=
 =?utf-8?B?bkg5SmNJSHU4UUpOOStZVE1lQVNtNXlCbmVJOTd4SHh1U2VRYVRHNWhsOGts?=
 =?utf-8?B?MERYSlhTNVdQbENMczlKQ2FXY3dQb1lYWGt3bDlpcWJadytKQzJ2MUM1VGRz?=
 =?utf-8?B?UUFqNVZhRDE2R0hkcTBOTDZlSmlKODBjWng5dm10Z3NtNmluYVdEcWlsTXdK?=
 =?utf-8?B?MHNCRGFlTWhmRmQ2OEhPL1g2dTZlZ1VsdSszNzh6eE4xU0tweVZPaFJHU0Iw?=
 =?utf-8?B?UmZwbmFGNTVPWjNscDE3SHh3aE1RZUtqWkZPM1pLQk5nSFQzaHk4dUVnWHlJ?=
 =?utf-8?B?UzJ6ZVg0WHZLdjNySkI5eWRYSW1BRnQ5cUY3UjlEWUFTOVVPL0NnV0NERnpJ?=
 =?utf-8?B?UVduTU9jRExjd09CYnZHWGU5aXIzTndpd0dlMktYWE1FNGtLVG1CMzE3dVJZ?=
 =?utf-8?B?V3lweU1zNEdMNExiYzNERFVBeG5UZ00ydjkzUEg0R0dZVHgxei9RTThjTWFX?=
 =?utf-8?B?Y0lkRkFFY09mK2xKZ0lrQ1JINmNubFVxWVZ3RTlDWUhBMnQ4ZEk0WENqYUNO?=
 =?utf-8?B?TWd0dWU5L1dQQ0xveG01UnR3S0hUUnJqTmZqSXA0dUpQb0ZrSmtzSFQrQ2JG?=
 =?utf-8?Q?2ODLyhgTdXfOhR6X/R5FMLMzFHoKBijIkNv+7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <142BA967A60AB649B6BF901384C126AE@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB2798.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90c8f83-5afd-4d85-e210-08de5435e4d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 12:59:18.2085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfQKODEl0leFWWnwLmK6OpdsuuMy3hTBPL6HCdd+R/VAtl0/jb/1AbvfpKqP5cygL8KFL92vFBF7YgniT5ssBX9+HvgAd8lpkXfQMSEAADk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6257
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

DQpPbiAxMy4gMS4gMjYuIDA0OjQ3LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24g
TW9uLCBKYW4gMTIsIDIwMjYgYXQgNzowNeKAr1BNIERqb3JkamUgVG9kb3JvdmljDQo+IDxEam9y
ZGplLlRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPiB3cm90ZToNCj4+IENhc3QgQ01fU0laRSB0byB1
aW50NjRfdCBiZWZvcmUgbXVsdGlwbHlpbmcgYnkgdGhlIGxvb3AgY291bnRlcg0KPj4gdG8gYXZv
aWQgcG90ZW50aWFsIGludGVnZXIgb3ZlcmZsb3cuDQo+Pg0KPj4gUmVzb2x2ZXM6IENvdmVyaXR5
IENJRCAxNjQ0MDc2DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRq
b3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvcmlzY3YvY3Bz
LmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9jcHMuYyBiL2h3L3Jpc2N2L2Nwcy5j
DQo+PiBpbmRleCA4NjE3MmJlNWIzLi42MjBmNTRlNDhhIDEwMDY0NA0KPj4gLS0tIGEvaHcvcmlz
Y3YvY3BzLmMNCj4+ICsrKyBiL2h3L3Jpc2N2L2Nwcy5jDQo+PiBAQCAtMTMzLDcgKzEzMyw3IEBA
IHN0YXRpYyB2b2lkIHJpc2N2X2Nwc19yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoq
ZXJycCkNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5c2J1c19tbWlvX2dldF9y
ZWdpb24oU1lTX0JVU19ERVZJQ0UoJnMtPmdjciksIDApKTsNCj4+DQo+PiAgICAgICBmb3IgKGkg
PSAwOyBpIDwgbnVtX29mX2NsdXN0ZXJzOyBpKyspIHsNCj4+IC0gICAgICAgIHVpbnQ2NF90IGNt
X2Jhc2UgPSBHTE9CQUxfQ01fQkFTRSArIChDTV9TSVpFICogaSk7DQo+PiArICAgICAgICB1aW50
NjRfdCBjbV9iYXNlID0gR0xPQkFMX0NNX0JBU0UgKyAoKHVpbnQ2NF90KUNNX1NJWkUgKiBpKTsN
Cj4gWW91IHNob3VsZG4ndCBuZWVkIHRvIGNhc3QgdGhpcywgaW5zdGVhZCB0aGlzIHNob3VsZCB3
b3JrDQo+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L2Nwcy5oIGIvaW5jbHVkZS9o
dy9yaXNjdi9jcHMuaA0KPiBpbmRleCBmMzNmZDdhYzg2Li4zOTAyOWJjYThmIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2h3L3Jpc2N2L2Nwcy5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvcmlzY3YvY3Bz
LmgNCj4gQEAgLTI3LDcgKzI3LDcgQEAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoUklTQ1ZD
UFNTdGF0ZSwgUklTQ1ZfQ1BTKQ0KPiAvKiBUaGUgZ2xvYmFsIENNIGJhc2UgZm9yIHRoZSBib3N0
b24tYWlhIG1vZGVsLiAqLw0KPiAjZGVmaW5lIEdMT0JBTF9DTV9CQVNFIDB4MTYxMDAwMDANCj4g
LyogVGhlIENNIGJsb2NrIGlzIDUxMiBLaUIuICovDQo+IC0jZGVmaW5lIENNX1NJWkUgKDEgPDwg
MTkpDQo+ICsjZGVmaW5lIENNX1NJWkUgKDFVTEwgPDwgMTkpDQo+DQo+IC8qDQo+ICAgKiBUaGUg
bWhhcnRpZCBiaXRzIGhhcyBjbHVzdGVyIGF0IGJpdCAxNiwgY29yZSBhdCBiaXQgNCwgYW5kIGhh
cnQgYXQNCj4NCj4gQWxpc3RhaXINCg0KWWVzLiBJdCB3aWxsIHdvcmsgYXMgd2VsbC4gSSB3aWxs
IHNlbmQgdGhhdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCg0KDQpUaGFua3MsDQoNCkRqb3JkamUN
Cg0KPj4gICAgICAgICAgIHVpbnQzMl90IGhhcnRpZF9iYXNlID0gaSA8PCBNSEFSVElEX0NMVVNU
RVJfU0hJRlQ7DQo+PiAgICAgICAgICAgcy0+YXBsaWMgPSByaXNjdl9hcGxpY19jcmVhdGUoY21f
YmFzZSArIEFJQV9QTElDX01fT0ZGU0VULA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFJQV9QTElDX01fU0laRSwNCj4+IC0tDQo+PiAyLjM0LjE=

