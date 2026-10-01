Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABBBCA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC62F-0000kn-CQ; Wed, 30 Sep 2026 21:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC627-0000iE-D1; Wed, 30 Sep 2026 21:56:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC625-00088e-Eq; Wed, 30 Sep 2026 21:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819785; x=1822355785;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OVHstNC/PuxykkOzn6HlLHK+K+DVL7bVoFLwyIcJYIc=;
 b=HaHmb1wwa4OUd2CuGKu7KVJiWbEWGr8e/W+gCeHV1Fa3BZQaBnxBxaAv
 I+aESzOpBfk2TzLPNRzWj4s8psnQpwNYUJbSJ9Y2PyG8MVzMkHotsNnr0
 /2+adzVo1+56sQqyOnbGBdStMbDugIJnZWSzkFgh1fwkFMc49Kdgy+MzM
 2+fwd183FtfaCLudDmgZquGnfJlaFTbn1Vr5AssGMfFEppq5Uu6GdT7fY
 IT08fANNqKEZOrFFn2bPbEdMAb7meKp+bis21O2uzgo8J5MbMorPJ/b6q
 CnJ7OmNiD3+PD8GpASB0Ay1ZONea4kPebS1ZrBZKjFSdeQZeXek8BO9Xh A==;
X-CSE-ConnectionGUID: jBoxluRdRhuDuNUfg4tbCA==
X-CSE-MsgGUID: PWKpxJO7QLOJtjrkMYPrzw==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="157931826"
Received: from mail-westus3azon11010030.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.30])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:56:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zla0wdHER43U+kAxPt6dmbNjVKGAInh4Y2HdSjO+023rMpQ0Z+318R3U1jsujCDhsYx7S8B7g8WclRXfip1vUBAQOonRGu3KeAuDp70tQrzo8lPCwpfHYqv+0S8SA/6d3g+3CJBYYSLOI3/+bluQPaQ7f3Ds26ENUjEyIysTbUZfnz26PBTtrvFBkU49lXvN1JeM98iCk4Uccyy/OVnSzGGd4I7QPhwFYakld2W2V1p7G1IoMpmWnwM3CIR2vDB3Yksh4ji6z9Zcao9ZeqcdlnbRzaktnQ8SM/HhkmfgVIhBkjR5HrxpWFuzjt0zkhvQIxy2m4bqXl1XrGVJf6fjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVHstNC/PuxykkOzn6HlLHK+K+DVL7bVoFLwyIcJYIc=;
 b=PICpZxkhAOMURYDZkop3HD29QASrQ33yOD1mJejMN0oUYfuwiGvehiSVeD2HhoRVby5oGAa6mJGa/CooU/96zMBcJZOLa8StTeT7w/R1JeHItosEgzw7O0pVL1ypWonRaG8m4zrzaOepWsGgKUxkcC4kp/mLYQxqAKOYs2UWNi1auYxDc+hGfqmzcq7yGCwuhos1RIiXaowqVrqOKdrfphGgEBeN/0erWsGEr2IQcGKzuUgeL0pzpG+O08sFq6x2BDrofZHrxdjIF3yzorWzJ3kLUzSQnaV8BFllGHtaMzjSHuWnCjv3s5FEzWhYglAmy/eRyQ8TUCF+0JhJoUNNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVHstNC/PuxykkOzn6HlLHK+K+DVL7bVoFLwyIcJYIc=;
 b=Hj8LI7hIZl7TMuXfYgxIms9zYVO6KqWkj5tj7V4LDmSejJx/6sOpa27lMDybSKfDGLlVxvKoGmDem7Ie1Kz5GUz+1rrcRs7BIxdtkfIY/nUkb9BvrEil1a0inn7MYbVk7G3Zjti0xKlR/ntzs30SeT1O676vtiYW3AGfgxblW6s=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB6380.namprd04.prod.outlook.com (2603:10b6:5:1e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 01:56:21 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:56:21 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 7/7] target/riscv: Skip redundant MIP updates
Thread-Topic: [PATCH v4 7/7] target/riscv: Skip redundant MIP updates
Thread-Index: AQHdUQOXtfIMQiNNsEe6/fIv+Y7kLbbn7hEA
Date: Thu, 1 Oct 2026 01:56:21 +0000
Message-ID: <375211a45956c78d004211fe55032608979e6dbe.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-8-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-8-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB6380:EE_
x-ms-office365-filtering-correlation-id: e761136b-f87f-4de7-9a19-08df1f5f311a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|10070799003|376014|366016|1800799024|38070700021|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: MnrV51HeRO07gdSoYsOBRqSS5xa5joTMb8RSp7+11Y/by9s6Q26b8ysymbfPdHuPFp/PXgfKHhbXINrmZQdCw6JJ7R3qkqcfkWh6uQg8AuudtqWfxfuVrXQ5D/JNIVghrMtWTje3TIf3snEnWderzFsDOTHuq7dFwipj5jvyq+rnU1ydCzTD+SpGSvwUpfXU0tL/0oYS4e+ApVy9kRLFXmSqVZUb61J++hD90e5kjNIZn8ucEXlA0DuGWd18HAP1iOXUNCnYssOwvzEMtiSSdHbm+5FppHVMUGmk2dLHDZaFuykugMmC9KunIIM5GziwTPRJTWjrUnSFa9kD2voqSR1HeJo8LlFN6yP8ZXAMJaA6sFpyWxQLPZl1zWZMTuaG8LQlJqaufYf9tbbfImggvq+53ykuLwEpQsx4na7gjG9nlj0/J3wtPuADqxXoYi+7zmPDaAvz/6U8T/2Adcq09/Sc8hhuEbaxQjp9qILz8MHNZXqXc7/9ARNIvgKcb0JnVZgmEwT52GD2DC9+v834bh4jQSQJ8R2fiPqZf3U7F06aGF0jr4Oc89i8SGGJW2iSst53hyFv3fiT9C07xURuvZPJsJR6cR6/IdpUH4C9vZZ6xRIgIp6SlZ/t5VBxx9VEc6oEnttz+BPyQES/OSXuS/+GhSrEzCnuFuZidOg7GxFr9i0Wdqkh2h+pAn4JUtC8tF4lK4ci743H7fReXvUnu5dsp55r//I2MMyCwB8rnGA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(10070799003)(376014)(366016)(1800799024)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGgyQjViNmc3L0RwR3pYNmkzT09FRTIxQndKenFaUUhvcUY0cTRyNGVWd1Aw?=
 =?utf-8?B?S21QVCtFK3VucWpkZ1pmWWZLdWdIK2hpd0VBNFhHZ1JST2FIV3dKbUpsQ05M?=
 =?utf-8?B?Ui9kU2Nvcy8rQkRweG1PcmRuTDlXMkhhcGh4R041d1pQd1JEM05mOWQ2Q3Bp?=
 =?utf-8?B?aDVjb0lNbCtBdDEvSi9QcW9iQ1F6cE1GU2Y2WGZEQ2FXNmttcnZoVUF3aWFi?=
 =?utf-8?B?TDdmRDd1V2lTTEdqcEZ1YWcyL0hESWx5WnJUb2ZZb0ZGT2pTOUxMYklPTCsr?=
 =?utf-8?B?dndUU1lmSFNERTFBSEVCQXF6Q1dIQXdLT3A1YTh4VEh3TDZQQWpiZzlPY254?=
 =?utf-8?B?NHY2dzgxSUVZNGdkWjFrbjNoYURQcU1QenVqYXFoUEMvbzlYNjQwWElvVSt4?=
 =?utf-8?B?emRRWTdvS2gwRkY5d2FscC9YZkZpWVdvTU9zZGpQUkhKVzRqNGpUejUxejNW?=
 =?utf-8?B?aU5YekhNTm1WNUMyMHNiSldjSEtTUlBtTXM4K1lmL05zL1p6bWJNY2c1VnJi?=
 =?utf-8?B?VUZ6d1RNcFg1eTlENUFicnhodTN6eC9jWjEyQXJVcjdlUkhZRDBZMFhEeXh1?=
 =?utf-8?B?TWpCY0lBa3NrMDgvZ1poLzZKa25yOUtmMFplSlNXNVpLelJHc3JUdUtpTTBn?=
 =?utf-8?B?b2ZlNVFWVTk2SWFFZmx3djNUWFRoNkxjZmNQWGwrYkVkZ2gxemZOcXVyNkV4?=
 =?utf-8?B?S0hNYVgvWmZBeERtajREVlNBcnlFSkwwTlpQdkdZNzlBMGw5b2xmZzZGaDlM?=
 =?utf-8?B?QVVzRHBxRFFhS3V3bm8zckhMVUxoNC8vNUVWbGVmU2NLT0xlMnZBekRHK2pI?=
 =?utf-8?B?amRWcmZOaEp0M0hQV2JuK28yYnlkekl2SktCcjRKOTdnRlJqRUlSbWRKWHhy?=
 =?utf-8?B?V2h5eGJOc2lic2hVdnVGTHA2elM5bENZdmNRcytWVDNIcHAwWllIRWVEQmp3?=
 =?utf-8?B?cjhNaEtucHU4ZHRvSVY0MFVydHM5M1ZxcXRybkRxZmgxSVhlSTFIWUVFdE4r?=
 =?utf-8?B?SHZtVjJoMWpsTXcrdUx3dEVPSUlZbmFkRWR1eHB3MVZGTU1aSGpIZnlxekRM?=
 =?utf-8?B?dXBDK1ZtcURENGZZV2h6cjd5M0Z1ZU5IdVJIS3BKVXB3cVJoRzlRTTBSUm03?=
 =?utf-8?B?Tkt6YkhOdmNMUVRHOURyaFl6aFNkUVBQb1EzSFo0c0NqMGFKTmxDVklXYUo5?=
 =?utf-8?B?ZUR5eHAxRHJITnJRZW1SNkkySlZITDhuQ3h1dmM5OFhPdnI1OEk4OTFFWkpz?=
 =?utf-8?B?ajlrUGE2ZUwrRDhxR1pSd2tOWUd4cis1NnpTMkVRbkFxbkx4REJZc0lTTlVR?=
 =?utf-8?B?SFh3TkRCMnpyOVNPbHI2ZFZRQzJBR2tSMnE5cHVaSHJlRmFKYk9qWTN6V1Ay?=
 =?utf-8?B?ZXYyK1ZPUEVXbFN3MXVrSFNEWFJQRVUyUmZFRWZ5T1h5VFpZQVZtNTlpeWtI?=
 =?utf-8?B?ektlL3NrMXRIR29LbFN3WmVOakhNMnRnZXcxc0E1VDcvT29ydVBEQ2FHc3l2?=
 =?utf-8?B?bDFYaXlKQS9nU1lUUjhLSURTMndlVjFCOUxiUzdjLytCRndLUmxGYjFLdWRJ?=
 =?utf-8?B?Ujg1RGdjbWxBbTJXdGw2a3YzRERqVlVQd1hvTEF1cWpFKzFIZUhWTXBxSWZG?=
 =?utf-8?B?NTJ5c2xOMWIySENwOWRHQm9zUWRvckhsVnU3UlpLWTRFM244SzVmTmJzTUR2?=
 =?utf-8?B?citQbXNGaTV6ZlllZ0hmcW1JMVVid3JKV2h2NFpvRFZwUzczN1hWOS9JNmR5?=
 =?utf-8?B?Vk1wUWt3VzBiT0pSaUNNVUJyN3VMUVBxU1B0N0xWcitFL2xBZVJ2c3U1T0Zl?=
 =?utf-8?B?K05UMm8zVWkvZHYzN0liNGtOUDBoNHd2bEV3ZDVHN0xNc3hwbUdZMUpWTjhC?=
 =?utf-8?B?SC9SMVZQdDRQcW5KRk5GYTM1U01ZOCs2SWQwdkxRbFZEVi80a0ppRFg1a2tO?=
 =?utf-8?B?NjdhQ3huQ0EyY1pHRk1pRVgwemc4dzhrSUxkbmVqTWtZUG5LZk9FSTkzM1U4?=
 =?utf-8?B?cEFxTk5tYlJOdVNVeDhXdTdMVVdteDRtdXY3aVM0YlRpa3RNbHpuYk5SUjFh?=
 =?utf-8?B?T0puTEZHR3JUOVFFRlhNdXdYQytwSEMzeUhaN1kva1JSUlphSTJ2eFlMbHBj?=
 =?utf-8?B?QzRDTkhSM3kxUmc4TW0wMytaZjBCb3VBcVpZRUZWWWlneXRVTk40d2ROa1VB?=
 =?utf-8?B?WVZmNGVKa0tPSmVKYU9ablNVTTdObVNqUWtPRGt2VEMrZXc1UUdKeHZrbTB4?=
 =?utf-8?B?TDlWa1hhYUFFbURXenl6R3hFSkM4enBFUEdlazM2aFAyd092Q3pUWk1hUHZt?=
 =?utf-8?B?K3VQY3JVUmNFRUE1c0lYWXBjbnVqMmxCeExYV05GK1A4eEltNndjUkY5Rm10?=
 =?utf-8?Q?9GahWOLSTAqfiqt6ZB/UMZQS/BCcoH8k1uOvruEVfVt8H?=
x-ms-exchange-antispam-messagedata-1: staq0/HY2D3vqA6qIQIRVKj88wlLHvcoUW4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6823DA087D41154C8E1E8C35D9A93037@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ftDHvVmR/4W9jvSfahYtS1C9M6iToDSifivSzSZjJsUTkUgCCc7s7zuy8NWCe1+m6DAjsU70n17oirvTNSCjfsSWK1a4HQidCKo5tU0YGUTBzCOrtOz0aPll3OH6RF4Jemfl8Sh6M5aD++zERrNAO7aHu+uP2BZciLDEyMXVhmCHTFmRtRrNxt87W/IdiaY8Jw7Pgulx5fRnUCoQloKwS7i3EGpUZFRaekuBBmXMnmpJ/R2qX6wYcec4bxyA+vRvVsuQLanvCFgNcf/JCoqVPWxPuFoVvTwEORpsrOaQYW01KdkUY551eG0LDiUVruIqVO+rubGxMXLWfQZ8tMlxjQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0Npy1togaHRDq0fymP+o78ROy7g0mWiDF/Cgzlw8hh4yTzmOiOhR/WAoGH2AweCV04IzmzztuMOz4aQY4oc5kCGfY6sFhfF6vzp7REFjPVvHbTd5N1ChF487pp6Gz5nF+t13YKAVILizMwK7K9OlIi5HmbtqanMUfiu3SU9C5VDWrRWmzwzDlccPWq1woBjciQj90bmdTpfpjcdBYVX5twl4+9DTxbnVG5usp+ATJjWuynw8Trq/rWt63PB0ii9aIfTJzNYXEJa/cc8RO2jt9wybHyAsgAitI7zTLyLnEYeVxLa/qzlVte6FAirYlTdVnsWD+xhMH0mxev3yELaT0j+8E0hAxRCcx8RG+bXMmPsrf1IxsPDWukFYU5J+qucGMMXfFoIUtwmkiO0c+6U3+GJ2JSTWRIjI7Jxi4f5mCOBgGcsElxfZ6Y4dVEzNB7zO4KhmHnMXoA3tJk8OmfHQ0uha1dFEdK25cCIr40pLq5NXp+Ptnf90YrLHpxtdR/sIXxiLcRe8gV9BhpbPaPbwxDgR//eDKUB1UvGzbZxTiSHXij99n35zGCGtGN158OWMjIGOuAq8Nd5HVCY+OgMIDGEGitk7J5QBngXLXaMScMVXkhSbe+AS/xG8lAFZiOxe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e761136b-f87f-4de7-9a19-08df1f5f311a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:56:21.5615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myou60wmgUajQV16BtQWv4zIa/9sbC7Goi04AJIaONp1MCUEvuIkvEbeuEZTO4pChUw9/y7U4r2beOmtYAkFsFJZru0GlF2v6iWYZrI9qjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6380
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gcmlzY3ZfY3B1X3VwZGF0ZV9taXAoKSB3YXMgY2FsbGVkIHdpdGggYSB6ZXJv
IG1hc2sgb25seSB0byByZS1wb2xsDQo+IGludGVycnVwdHMgYWZ0ZXIgdXBkYXRpbmcgZW52LT52
c3RpbWVfaXJxLCB3aGVyZSB0aGUgVlMgdGltZXIga2VlcHMNCj4gVlNUSVAgKHNlZSAxNGNiNzhi
ZmFmNCAidGFyZ2V0L3Jpc2N2OiBEb24ndCBjbGVhciBtYXNrIGluDQo+IHJpc2N2X2NwdV91cGRh
dGVfbWlwKCkgZm9yIFZTVElQIikuIE1vdmUgdGhhdCByZS1wb2xsIHRvDQo+IHJpc2N2X2FjY2Vs
X3NldF9pcnEoKSwgd2hpY2ggbm93IGNhbGxzIHJpc2N2X2NwdV9pbnRlcnJ1cHQoKSBkaXJlY3Rs
eQ0KPiBmb3IgdGhlIHplcm8tbWFzayBjYXNlLCBhbmQga2VlcCB0aGUgZWFybHkgcmV0dXJuIGZv
ciB0aGUgbm8tb3AgVlNUSVANCj4gdXBkYXRlLg0KPiANCj4gTm8gY2FsbGVyIHBhc3NlcyBhIHpl
cm8gbWFzayBhbnltb3JlLCBzbyBkb2N1bWVudCBAbWFzayBhcyBub24temVybw0KPiBhbmQgYXNz
ZXJ0IGl0Lg0KPiANCj4gQUktdXNlZC1mb3I6IGNvZGUgKHByb3RvdHlwZSkNCg0KQWhoLi4uLi4g
VGhlIEFJIGNvZGUgcG9saWN5IGhhc24ndCBjaGFuZ2VkIHlldC4NCg0KRHJhZnRpbmcgY29kZSBz
ZWVtcyB0byBmYWxsIGluc2lkZSB0aGUgY3VycmVudCBwb2xpY3kgb2Ygbm90IGFsbG93ZWQNCg0K
QWxpc3RhaXINCg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQG9zcy5xdWFsY29tbS5jb20+DQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxw
ZXIuYyB8wqAgNiArKysrKy0NCj4gwqB0YXJnZXQvcmlzY3YvdGltZV9oZWxwZXIuY8KgwqDCoCB8
IDExICsrKysrKysrKystDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3Rh
cmdldC9yaXNjdi9jcHUuaA0KPiBpbmRleCBhZDczMWJmNWQzNC4uNjE3MzM2MGU0MDcgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmgN
Cj4gQEAgLTY5NCw3ICs2OTQsNyBAQCB1aW50NjRfdCByaXNjdl9jcHVfZ2V0X21pcChjb25zdCBD
UFVSSVNDVlN0YXRlDQo+ICplbnYpOw0KPiDCoC8qKg0KPiDCoCAqIHJpc2N2X2NwdV91cGRhdGVf
bWlwOg0KPiDCoCAqIEBlbnY6IENQVVJJU0NWU3RhdGUNCj4gLSAqIEBtYXNrOiBNYXNrIG9mIHRo
ZSBNSVAgYml0cyB0byB1cGRhdGUNCj4gKyAqIEBtYXNrOiBNYXNrIG9mIHRoZSBNSVAgYml0cyB0
byB1cGRhdGUgKG11c3QgYmUgbm9uLXplcm8pDQo+IMKgICogQHZhbHVlOiBOZXcgdmFsdWVzIGZv
ciB0aGUgYml0cyBzZXQgaW4gQG1hc2suDQo+IMKgICrCoMKgwqDCoMKgwqDCoMKgIFVzZSBCT09M
X1RPX01BU0soKSBmb3IgYm9vbGVhbiB2YWx1ZXMuDQo+IMKgICoNCj4gZGlmZiAtLWdpdCBhL3Rh
cmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVs
cGVyLmMNCj4gaW5kZXggZGI3ZjJiZDZkZTcuLjE2YjJjNDg2OTM0IDEwMDY0NA0KPiAtLS0gYS90
YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2Nw
dV9oZWxwZXIuYw0KPiBAQCAtNTc5LDggKzU3OSwxMiBAQCB1aW50NjRfdCByaXNjdl9jcHVfdXBk
YXRlX21pcChDUFVSSVNDVlN0YXRlDQo+ICplbnYsIHVpbnQ2NF90IG1hc2ssIHVpbnQ2NF90IHZh
bHVlKQ0KPiDCoHsNCj4gwqDCoMKgwqAgdWludDY0X3Qgb2xkOw0KPiDCoA0KPiArwqDCoMKgIGFz
c2VydChtYXNrKTsNCj4gKw0KPiDCoMKgwqDCoCAvKiBObyBuZWVkIHRvIHVwZGF0ZSBtaXAgZm9y
IFZTVElQICovDQo+IC3CoMKgwqAgbWFzayA9ICgobWFzayA9PSBNSVBfVlNUSVApICYmIGVudi0+
dnN0aW1lX2lycSkgPyAwIDogbWFzazsNCj4gK8KgwqDCoCBpZiAobWFzayA9PSBNSVBfVlNUSVAg
JiYgZW52LT52c3RpbWVfaXJxKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmlzY3ZfY3B1
X2dldF9taXAoZW52KTsNCj4gK8KgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIEJRTF9MT0NLX0dV
QVJEKCk7DQo+IMKgDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGltZV9oZWxwZXIuYyBi
L3RhcmdldC9yaXNjdi90aW1lX2hlbHBlci5jDQo+IGluZGV4IDI5YmJlYmI5NmZjLi42YmQ5MTcz
ODNlMyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RpbWVfaGVscGVyLmMNCj4gKysrIGIv
dGFyZ2V0L3Jpc2N2L3RpbWVfaGVscGVyLmMNCj4gQEAgLTM5LDcgKzM5LDE2IEBAIHN0YXRpYyB2
b2lkIHJpc2N2X2FjY2VsX3NldF9pcnEoUklTQ1ZDUFUgKmNwdSwNCj4gwqDCoMKgwqDCoMKgwqDC
oCB1aW50NjRfdCBtYXNrID0gaXJxX29yX21hc2s7DQo+IMKgwqDCoMKgwqDCoMKgwqAgdWludDY0
X3QgdmFsdWUgPSBsZXZlbF9vcl92YWx1ZTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgIHJpc2N2
X2NwdV91cGRhdGVfbWlwKCZjcHUtPmVudiwgbWFzaywgdmFsdWUpOw0KPiArwqDCoMKgwqDCoMKg
wqAgaWYgKCFtYXNrKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qDQo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBUaGUgVlMgdGltZXIga2VlcHMgVlNUSVAgaW4gZW52LT52c3Rp
bWVfaXJxIHJhdGhlcg0KPiB0aGFuDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpbiBt
aXAsIHNvIGNhbGxlcnMgcGFzcyBhIHplcm8gbWFzayBvbmx5IHRvIHJlLXBvbGwNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqIGludGVycnVwdHMgYWZ0ZXIgdXBkYXRpbmcgaXQuDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmlz
Y3ZfY3B1X2ludGVycnVwdCgmY3B1LT5lbnYpOw0KPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3B1X3VwZGF0ZV9taXAoJmNwdS0+ZW52
LCBtYXNrLCB2YWx1ZSk7DQo+ICvCoMKgwqDCoMKgwqDCoCB9DQo+IMKgwqDCoMKgIH0NCj4gwqB9
DQo+IMKgDQo=

