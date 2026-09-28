Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A2FC9830E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 02:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB1Vx-0002sJ-IT; Sun, 27 Sep 2026 22:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1Vk-0002r5-AD; Sun, 27 Sep 2026 22:54:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB1Vi-0002AI-5g; Sun, 27 Sep 2026 22:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790564074; x=1822100074;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=UhzwpdLZz20cO5DsuV+Kj4i1f9VZZryPsDEdUcPb1Mw=;
 b=pn8Gpb4D5qB/qvk0Ig4OvGB6PAWPyOQhFIWB/BOqhokArjHFnbPaqncs
 oU7+hoKxkVODjruVi7ldDmH/ZD1r9WGsCNCyQX18kn7dePOEZjhi5RE+j
 lsD6VbV12loHc/UCoj9U61sY3v++cVk4g2EaKbpiP+xI0jBV19/C/LCe/
 HImEK2WYrc6vnsDCQlMG0+PI8tMIPSV3dIzbvCKHOhzIK5oA8p87blAK4
 Zz33Sn2dR9S51LzDDwafIQYce/AGBYjJIrZFejnrddSSXMOHnKOcJRZUm
 X0iTDJJsz5KzKHxuJ6dwqk06NrHjJf8oYWDOA/3Ofsbc965DANItV20nm A==;
X-CSE-ConnectionGUID: /dwfJngzSx20flfIQmNAmg==
X-CSE-MsgGUID: D7ezxCLXRb6OCC7b0vTQvw==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="155749950"
Received: from mail-northcentralusazon11013061.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 10:54:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSKP4WXEA8/FjZefCgPCSYPTFwPuhpRyqcEC4gT8BGdKACkest8sFQniKaptExyzmk0YQcbxg8RomqCH0xXUVBmZ/FWx010td5TlKQfMvxDchkTOmbXF1LGjJ65MRNolniu2PKvIHEBP2MMXJI+rsiTLQEKbHZks8PBRe0AO6RLOMscglGZUlrfOCPfvvT2Ue8lfBXo+dKXpmUAU93NgH1ageCuuZhc3EHPFW/XcmlkolB17iDKUOGG4SVvvDc0C2j9mhcCTNuL04+fuOSo8UQwJmQ1E4uu00AeRhBjNvm7ccjdvMn/abLFYlLI9NZULZ9Y9Mzn4yn/0p/KOw0cenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhzwpdLZz20cO5DsuV+Kj4i1f9VZZryPsDEdUcPb1Mw=;
 b=y+BPysrIwlaJYtfF+Kw//dSaAxL5Ub2GcYbwHMrIYla4qaRLxM5OOje4ku9A+RDRw3vlGbYmy2kYcW8lJ8A/c3PIGISt8RvLMxptanYhAjF/yL5hNRFYXRba0w/JC8evMHe/MjegzpYY8CXH1Nz6m7HLy80KhnrB/+TRyXpZvADxZp65R8ThRc4DdLBjMGpNoRspiN6MSUxrYKS9SFOLFJoKcI10ftxXHNI+3SIYviHLT4E5jjwRTbtWnwj1l+L+rba7J+zG+HI+0N/albjZEttne6L3wbTntopryd5pLfg7PgXEpA0mk9bRRp8zIG6Ctc3fyTf+g4WJI+xboMuwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhzwpdLZz20cO5DsuV+Kj4i1f9VZZryPsDEdUcPb1Mw=;
 b=x/oOhFdyqYw5I0jtX8slXiFrqhqHGz7OKGJq8Uc+v2s/w/d2pvo6FnghBn65yqPJPOEasJLJvrTgFaaFQU5oxJCy/y3K/ATk09Bhs0wsx3/tGyXGEBMpu/0F1YBejL8gA0WHUfiHss4e9emvgkJX3WxIr0s8qg89ajJwaKca1jw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH7PR04MB9644.namprd04.prod.outlook.com (2603:10b6:610:252::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 02:54:28 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 02:54:28 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "tangtao1634@phytium.com.cn"
 <tangtao1634@phytium.com.cn>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v9 2/7] target/riscv: add sdext Debug Mode helpers
Thread-Topic: [PATCH v9 2/7] target/riscv: add sdext Debug Mode helpers
Thread-Index: AQHdQGpcWsQqzhBLuUKdILmF/W+3A7bjaISA
Date: Mon, 28 Sep 2026 02:54:28 +0000
Message-ID: <7cf266931838b44c3f7a6a2cdc455ad5f7057ed7.camel@wdc.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260909144841.1766921-3-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH7PR04MB9644:EE_
x-ms-office365-filtering-correlation-id: c1887825-b797-4119-79fc-08df1d0bd008
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|19092799006|10067099003|11063799006|6133799003|18002099003|18092099006|10086099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: wVmPtX8i8AdZXCG4E8yCd0IY0+biUryH1MKjBmCNdHxmSw4MxqgNRL4zKhbGVaa3O/3ryjEEoLIKzxFTv/Rq6kA2+FvE51nTCwwoEvsldvcmaQCB3LnkhXAxwVYQuR9QTJEdkBSvB7owckk9BSbe6mvarUNwmSBdR1jGl2S9zcqqwJ1A0OfxLaHth4t59MRy+RM8YuvHaeC0lDYcvMUuuowXhx8/bCSWTJUqUqVI7yOS3Jxc7G0jM2yVY52f0gKSu1itbvAGMEdQMSPH5ahe3TSWWwoy15aGnNsPqPYhpsBY9fGe2MfTfT5CSv7taxCsFh2akj00kYIx6cfhmS+pBhdxsD9kjSiZJBH9yHOfL+tKBvs7/STcG/qe9hZDFiPV0YPQm70mrIgtcRQJbg1laIhVogtpzLy8Xdw2zwB6m6FZkWulm+JL1kBoSYTgJ61fEX7buYPdmTlTKY+e/XomvPi5EKdeJsFSWSTSZC43eLnh3nDYte1wXZGXcYCNuMcOcERc7il7JC9kZ2pRQ1ehLwzi3dPG0fI4ix6E5rG09OAM2la1q8gu77RFeKFF7VLRfZn+JpOvgcj3E+NsVEqwaCRwJ06KLI3xbJshJZqVFDJxPeDF/pUl2Mmb/mxTIXvOyTb3L6k61vLMOS1jdYlkPk2DZiTx1l3ig5WBU0HxeV1OdOf+NQH2HGtsfjsoqIgvOocVIbWDQ7U88xrroE0CxMfQ6rG2stbaKjG88ytPIlM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(19092799006)(10067099003)(11063799006)(6133799003)(18002099003)(18092099006)(10086099003)(22082099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2wvbnhkM2ZUbGVtOEd0aDhVYXdOajMrTjRyMkJ3UU1UT0Rhc1ZRUE42Q1Fr?=
 =?utf-8?B?RWZ1VC9RcTdFSmtFcVByd0M5UDdRQ3hUT2FCYVdEeFRMVmhwTEhtKzZpdk11?=
 =?utf-8?B?RDF4VEEwcDlqeGl6QWRKTVZVaFhNRzhyN2dVb1R4bjFCK0t3c3p0WnVhaVJt?=
 =?utf-8?B?TVNVQ1V4UlhBTHRMZFFvOW9JekZPNVZsMUpwWVBhTWhVUXUxSE5zZ081TlNY?=
 =?utf-8?B?T21KMW1zRkxaRll6QTdGY1hQQ2tKenlVYUhsK1pPYlNIZFV0Ymd5Z0FFLzF5?=
 =?utf-8?B?TzZ5YXRxMi9ETTJVSytXenpOQStSb0U4MzBPUy9NTlhRcjZyMDhwcnRVWTA2?=
 =?utf-8?B?c0RyZlU0aXBJdzFaUWltRGEzN0I1VTFlUUdXbC9oZjVkMlBGWHJpODZnMjBw?=
 =?utf-8?B?NU9vQlRxOXczdUZ1dG5LSWgvVlBJQThQekZ5RzJZRHJRcGFsZmE4Z1AxQkJk?=
 =?utf-8?B?aGlvTnpxZU44MlcyVGVtcjRKUjZQOGNtVk9lVnlSaXE0cVNFWk8vYzhndVdZ?=
 =?utf-8?B?Kzc0Wm0rTHBTYWVhRXJwc1Y3V3ZCdEtvUUpIb0IzRS9wTy95SXlaZkJnanlO?=
 =?utf-8?B?TEFZR0JKeXhqRFJzdngzTUdXTHVKNHFKVC9weXpWZ1htL1ZockJhaFd0SjUw?=
 =?utf-8?B?eFB3NEtZN1JlVzZkMGNtWVJ3QlJkaVJHVUlncVRYVmd5SzJBUFpZYldEb3R5?=
 =?utf-8?B?a1N6NElPcEVWek9Ca3d4Z3FvWUh6aUJMWGJvM1BWUm5VWkQ1Z0xNL041OHZH?=
 =?utf-8?B?U2ptNTE0cXZWeE50NG9nQmd1SXpGNldESUt0WnBDZ01UTWhKQXk1TVJFVVV2?=
 =?utf-8?B?aC9JK3p6a08vUVVXaG9LTFdBanB4YWtEWkZ2RjJWTkVwNkp4NTJPa25nWnpD?=
 =?utf-8?B?RklWbEZUU1lmME1iS0xlNHZ4ZGRkb2RrWGJiYit4YWlXbngvRFJDVnNqVnIw?=
 =?utf-8?B?T0UrTFlqQzh4Y3IzaHNYcmpsWG1XL2RkakowV3BsV2dNZjdpL1NNZkRuYmF6?=
 =?utf-8?B?RGN4VEx6c1BHTFBiSm5YTWZsMzh2ZnVmazlTQ3BubVBnaFNkb0EvUEJwSzRq?=
 =?utf-8?B?VnoyU25TakdOaVhHRkR1bFE1OGVKSm1XWjhxUFNIUGk2STYwbnM5SzBoTWtT?=
 =?utf-8?B?QVYwaWlHU3EwYXo1dm9vQk5qMkR3ZXJKWjBQd2tGSmdHYXFaVmdBV3k4aWht?=
 =?utf-8?B?Q00wZTZtZ1EzaThPTHVXQ0hJQmtPLzBoOXR0dEZMano1bHYzRUszdW5hcEpE?=
 =?utf-8?B?Q2R6Uzc2ZVMwZmwra1hEODRvemlSVHBNdElxdlQxSCtjYTBJem1CeHYvTzVE?=
 =?utf-8?B?dUxpdXJaQVUzQWdVTWFWcGpvQWRaYWJsWWRiZ0VHTEF2M00rYVV2bVNNbEQ3?=
 =?utf-8?B?am9lNzZyUy9kRnBYTTByUC9xWkpFTDlPcExWRkFPREZic29INEZ0emdBS3BK?=
 =?utf-8?B?eDlTclI0MzJEVEpzdHVFTEk0dWhCcmh6V1YvOVpTRGJPTnJmK2xMRnhDRDRV?=
 =?utf-8?B?Qm5pM3krb3k3U0tDNHpOR2VKL0dvcFcxZGl6ZGRub21QRnU0bUJyVkIwUEtZ?=
 =?utf-8?B?VkdldENGZkgzZ0U5VFJMVjJPMEFuSkE5SHpJdFFUVy92bWdoc1ZXcGNxU3F5?=
 =?utf-8?B?Y3c5UVlxMk1vZ3RzS0Eva0owSjZ3K1gyWHhJRDJYcmhFVzNkanJIK29sSVJX?=
 =?utf-8?B?cmxydjhqUE0vaFFIMjZGUVNLcG5xcmNvL2RXeXZsME5oeEJRZDRtOGhyN0Z4?=
 =?utf-8?B?OElub3l1V05vZHBVWDlyQ0dnb202cjZyZm9tSlByOThycnNRd1k1THJwKzhr?=
 =?utf-8?B?QjVvVTZoNjhhNVZhbUVUVTRiMVhHalFieDU1TUhlbTRrdDVhWTlGLys3di80?=
 =?utf-8?B?K1B0SXhxQ1l0WUtJUURVMmNrNVl2SWtPb3pONmdxc2pUSzZ6d2hhaGEvbEhI?=
 =?utf-8?B?d2NNcEFLMEhhRXhiU25lVitBWjF2cUNkNGF0aW1CNUZFVXpBNjFtNDROUUE0?=
 =?utf-8?B?aXQzTUdrd25uaWhpa293Ris2ZjNYV3RKOW9FUkExVDJ0ZnBTNEprMkRVaUdj?=
 =?utf-8?B?T2V0M2hQSGUvNlN3bTByR1daTnp4RG5BTjFjMFc4cDZma3g5eTBIVnpZdzlq?=
 =?utf-8?B?ZnkxMFZzTnMwZWFpSzdycGwySWVpdkI3R2ZIbUIrbjAzd3dWdDdvUVk0amdZ?=
 =?utf-8?B?Q2xyeVNrQnB2eXBIS2RLekV4QmtnMVlTQTBTTUR5U2l1ZG0wdDZLd3RXT2p0?=
 =?utf-8?B?dEd4WU5DS0x3dmh5TUJqR0lSOWlDUFF6R21ybkRHWUdNWW1EU28zQW8rM1dk?=
 =?utf-8?B?bTZUMzN1T2FLN1JZdnZpa2h2QXQ5bmR1aDY5L3RDYnBXWnFmRmgxODFYWm5i?=
 =?utf-8?Q?2SqORCVx0Qlj/yVuDriFno8N6U98SPQruucW5zwLTrBKL?=
x-ms-exchange-antispam-messagedata-1: L8dzgaoBEw5YorAmVYcxg5lW9WdoFfnNRW4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25B296B8438D68489A8F24CDCF6CCD3D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EnJ33YCWqT+QvNPWzhukGPa85mhxEm/gotePVL3Qh8Cyf4pvfDB+EbaF7JiL7zA8RI7iO77Moxcd1N8WFwA3Zf8B3LiuVNSI7I1ZSiuE4eS9ycDODKI3XuFl2Xqs/zObYpwzBGXYlD5mq39/c5kTqAcTfa4lWTF49KIH/cCOgQeBWDMLZGJ4yEKr7CpZ8VKu/4CD1Yvfn/7K7IknKfx+1gCS3ZYrsIr+UoR9LIvN8TJjcmopdd0ksWw8J9MYJTsLbYtWP8Hjp2/FWHJBfmqqB7xvn5LvsrMme0+WxGA11sgEjsE5TdZDTiHV5/HKoCmtFIC2rLcZLh/V7LvYU30Rvg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: elLppZVVhsBH6ZCF9hcp18sDPQ7HTpmOqf3QaURdb7NG5JO//BZ85WeatK9b1lUqCtLNZPHz2TMfzS95UJgeJU9Y4j+ekLhEmmesxtQDZW/Wtj0II+5r14W/2WvdMLlyIeiPQusiT9/ZXQOEBOsn2igDNfZ0VVPKEg2Wt6tEQa78AIMtRtML2YUtSc+7XAAqhaFDe4J1kjuM9aR4PVc6k3sKFIzN839pX3y02ZYar2BPdzkbJOSRGvUqCNka1P3LDmgY3/bowrSyMHHVD0A5kq5toLE7QVbh9yHj9/7B478F690hOsZ2Q7dEOvG/9nidtHHUjPPvxapINaxQmHmLx65cgkHMxd7ESLnFaFUwLzPBIwJJVUYKwqq+GpeyVhPmo1nNptAScuelzPaA6WROFkPVxp7PnumWaZSMyLzEOvvTL9bQHr064tplO2TIGiFW4yTJar4z1CzQSWDIUh9upQAEDo8/ffjKN0tXT1MXU3XAtENe6N4HsjZHyQ4LQvoOqmimD3XRno/Maf6aOnCmN0DvMzls1xt63f1AeNjWXDXrCF+wPCeJ2A7q4bg/woP99HPFF2m9Mz6G0oJTAi9i4w3PhCxIBEycGjErD69XBrX8BMeeaM3qdftzWk6VU+B5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1887825-b797-4119-79fc-08df1d0bd008
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 02:54:28.1688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GInouFtCFPycfc8eyF46LnYjCJ1TAc5Qu6mrtAfevjUkUN1qfuU02fuB9icAneLLVAGMM26ErMk+bYbAt7Y04odSSiEIf4c8zWEqt40tSAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9644
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDExOjQ4IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gRnJvbTogQ2hhbyBMaXUgPGNoYW8ubGl1Lnpldm9ybkBnbWFpbC5jb20+DQo+
IA0KPiBSSVNDLVYgRGVidWcgU3BlY2lmaWNhdGlvbjoNCj4gaHR0cHM6Ly9naXRodWIuY29tL3Jp
c2N2L3Jpc2N2LWRlYnVnLXNwZWMvcmVsZWFzZXMvdGFnLzEuMA0KPiANCj4gQWRkIGhlbHBlcnMg
dG8gZW50ZXIvbGVhdmUgRGVidWcgTW9kZSBhbmQgdG8gdXBkYXRlIGRwYy9kY3NyLg0KPiBNb2Rl
bCByZXN1bWUgd2l0aG91dCBhIERlYnVnIE1vZHVsZSBieSBsZWF2aW5nIERlYnVnIE1vZGUgYXQN
Cj4gY3B1X2V4ZWNfZW50ZXIgYW5kIGNvbnRpbnVpbmcgZnJvbSBkcGMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFvIExpdSA8Y2hhby5saXUuemV2b3JuQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNv
bW0uY29tPg0KPiBUZXN0ZWQtYnk6IFRhbyBUYW5nIDx0YW5ndGFvMTYzNEBwaHl0aXVtLmNvbS5j
bj4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5i
YXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysNCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2NwdV9o
ZWxwZXIuYyB8IDg1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jwqDCoMKgwqDCoCB8wqAgNSArKysNCj4gwqB0YXJnZXQv
cmlzY3YvdGNnL3RjZy1jcHUuY8KgwqDCoCB8IDE0ICsrKysrKw0KPiDCoDQgZmlsZXMgY2hhbmdl
ZCwgMTA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1
LmggYi90YXJnZXQvcmlzY3YvY3B1LmgNCj4gaW5kZXggN2IzNDNkN2EzZS4uODJlYjYxYTE4YyAx
MDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9j
cHUuaA0KPiBAQCAtNjcxLDYgKzY3MSw5IEBAIGJvb2wgcmlzY3ZfY3B1X3RsYl9maWxsKENQVVN0
YXRlICpjcywgdmFkZHINCj4gYWRkcmVzcywgaW50IHNpemUsDQo+IMKgY2hhciAqcmlzY3ZfaXNh
X3N0cmluZyhSSVNDVkNQVSAqY3B1KTsNCj4gwqBpbnQgcmlzY3ZfY3B1X21heF94bGVuKFJJU0NW
Q1BVQ2xhc3MgKm1jYyk7DQo+IMKgYm9vbCByaXNjdl9jcHVfb3B0aW9uX3NldChSSVNDVkNQVSAq
Y3B1LCBjb25zdCBjaGFyICpvcHRuYW1lKTsNCj4gK3ZvaWQgcmlzY3ZfY3B1X2VudGVyX2RlYnVn
X21vZGUoQ1BVUklTQ1ZTdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgcGMsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50
MzJfdCBjYXVzZSk7DQo+ICt2b2lkIHJpc2N2X2NwdV9sZWF2ZV9kZWJ1Z19tb2RlKENQVVJJU0NW
U3RhdGUgKmVudik7DQo+IMKgDQo+IMKgI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+IMKgdm9p
ZCByaXNjdl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcHUpOw0KPiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMNCj4gYi90YXJnZXQvcmlzY3YvdGNnL2NwdV9o
ZWxwZXIuYw0KPiBpbmRleCAwN2Q5MjIyNjUyLi5lNmQ5NDg5OTFjIDEwMDY0NA0KPiAtLS0gYS90
YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL2Nw
dV9oZWxwZXIuYw0KPiBAQCAtMTMyLDYgKzEzMiw5MSBAQCBib29sDQo+IHJpc2N2X2Vudl9zbW9k
ZV9kYmx0cnBfZW5hYmxlZChDUFVSSVNDVlN0YXRlICplbnYsIGJvb2wgdmlydCkNCj4gwqAjZW5k
aWYNCj4gwqB9DQo+IMKgDQo+ICsjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gK3N0YXRpYyBi
b29sIHJpc2N2X3NkZXh0X2VuYWJsZWQoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiArew0KPiArwqDC
oMKgIHJldHVybiByaXNjdl9jcHVfY2ZnKGVudiktPmV4dF9zZGV4dDsNCj4gK30NCj4gKyNlbmRp
Zg0KPiArDQo+ICt2b2lkIHJpc2N2X2NwdV9lbnRlcl9kZWJ1Z19tb2RlKENQVVJJU0NWU3RhdGUg
KmVudiwgdGFyZ2V0X3Vsb25nIHBjLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgY2F1c2UpDQo+ICt7DQo+
ICsjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gK8KgwqDCoCBpZiAoIXJpc2N2X3NkZXh0X2Vu
YWJsZWQoZW52KSkgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiArwqDCoMKgIH0NCj4g
Kw0KPiArwqDCoMKgIGVudi0+ZGVidWdfbW9kZSA9IHRydWU7DQo+ICvCoMKgwqAgZW52LT5kcGMg
PSBwYyAmIGdldF94ZXBjX21hc2soZW52KTsNCj4gK8KgwqDCoCBlbnYtPmRjc3IgJj0gfihEQ1NS
X0NBVVNFX01BU0sgfCBEQ1NSX1BSVl9NQVNLIHwgRENTUl9WKTsNCj4gK8KgwqDCoCBlbnYtPmRj
c3IgfD0gKCh0YXJnZXRfdWxvbmcpKGNhdXNlICYgMHg3KSkgPDwgRENTUl9DQVVTRV9TSElGVDsN
Cg0KWW91IHNob3VsZG4ndCBuZWVkIHRoZSBjYXN0LCBhcyBEQ1NSIGlzIG9ubHkgMzItYml0DQoN
Cj4gK8KgwqDCoCBlbnYtPmRjc3IgfD0gZW52LT5wcml2ICYgRENTUl9QUlZfTUFTSzsNCj4gK8Kg
wqDCoCBpZiAoZW52LT52aXJ0X2VuYWJsZWQgJiYgcmlzY3ZfaGFzX2V4dChlbnYsIFJWSCkpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIGVudi0+ZGNzciB8PSBEQ1NSX1Y7DQo+ICvCoMKgwqAgfQ0KPiAr
DQo+ICvCoMKgwqAgaWYgKGVudl9hcmNoY3B1KGVudiktPmNmZy5leHRfemljZmlscCkgew0KPiAr
wqDCoMKgwqDCoMKgwqAgaWYgKGVudi0+ZWxwKSB7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVudi0+ZGNzciB8PSBEQ1NSX1BFTFA7DQo+ICvCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugew0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPmRjc3IgJj0gfkRDU1JfUEVMUDsNCj4gK8KgwqDC
oMKgwqDCoMKgIH0NCj4gK8KgwqDCoMKgwqDCoMKgIGVudi0+ZWxwID0gZmFsc2U7DQo+ICvCoMKg
wqAgfQ0KPiArI2VuZGlmDQo+ICt9DQo+ICsNCj4gK3ZvaWQgcmlzY3ZfY3B1X2xlYXZlX2RlYnVn
X21vZGUoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiArew0KPiArI2lmbmRlZiBDT05GSUdfVVNFUl9P
TkxZDQo+ICvCoMKgwqAgaWYgKCFyaXNjdl9zZGV4dF9lbmFibGVkKGVudikpIHsNCj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCB0YXJnZXRfdWxv
bmcgbmV3X3ByaXYgPSBlbnYtPmRjc3IgJiBEQ1NSX1BSVl9NQVNLOw0KPiArwqDCoMKgIGJvb2wg
bmV3X3ZpcnQgPSByaXNjdl9oYXNfZXh0KGVudiwgUlZIKSAmJiAoZW52LT5kY3NyICYgRENTUl9W
KTsNCg0KVGhlc2Ugc2hvdWxkIGJlIGF0IHRoZSB0b3Agb2YgdGhlIGZ1bmN0aW9uDQoNCkFsaXN0
YWlyDQoNCj4gKw0KPiArwqDCoMKgIGlmIChuZXdfcHJpdiA+IFBSVl9NKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoCBuZXdfcHJpdiA9IFBSVl9NOw0KPiArwqDCoMKgIH0NCj4gK8KgwqDCoCBpZiAobmV3
X3ByaXYgPT0gUFJWX00pIHsNCj4gK8KgwqDCoMKgwqDCoMKgIG5ld192aXJ0ID0gZmFsc2U7DQo+
ICvCoMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgaWYgKG5ld19wcml2ID09IFBSVl9TICYmICFyaXNj
dl9oYXNfZXh0KGVudiwgUlZTKSkgew0KPiArwqDCoMKgwqDCoMKgwqAgbmV3X3ByaXYgPSBQUlZf
TTsNCj4gK8KgwqDCoMKgwqDCoMKgIG5ld192aXJ0ID0gZmFsc2U7DQo+ICvCoMKgwqAgfSBlbHNl
IGlmIChuZXdfcHJpdiA9PSBQUlZfVSAmJiAhcmlzY3ZfaGFzX2V4dChlbnYsIFJWVSkpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgIG5ld19wcml2ID0gcmlzY3ZfaGFzX2V4dChlbnYsIFJWUykgPyBQUlZf
UyA6IFBSVl9NOw0KPiArwqDCoMKgwqDCoMKgwqAgbmV3X3ZpcnQgPSBmYWxzZTsNCj4gK8KgwqDC
oCB9DQo+ICsNCj4gK8KgwqDCoCBlbnYtPmRlYnVnX21vZGUgPSBmYWxzZTsNCj4gK8KgwqDCoCBy
aXNjdl9jcHVfc2V0X21vZGUoZW52LCBuZXdfcHJpdiwgbmV3X3ZpcnQpOw0KPiArDQo+ICvCoMKg
wqAgaWYgKGVudl9hcmNoY3B1KGVudiktPmNmZy5leHRfemljZmlscCkgew0KPiArwqDCoMKgwqDC
oMKgwqAgZW52LT5lbHAgPSBjcHVfZ2V0X2ZjZmllbihlbnYpICYmIChlbnYtPmRjc3IgJiBEQ1NS
X1BFTFApOw0KPiArwqDCoMKgwqDCoMKgwqAgZW52LT5kY3NyICY9IH5EQ1NSX1BFTFA7DQo+ICvC
oMKgwqAgfQ0KPiArDQo+ICvCoMKgwqAgaWYgKG5ld19wcml2ICE9IFBSVl9NKSB7DQo+ICvCoMKg
wqDCoMKgwqDCoCBlbnYtPm1zdGF0dXMgPSBzZXRfZmllbGQoZW52LT5tc3RhdHVzLCBNU1RBVFVT
X01QUlYsIDApOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIGlmIChlbnZfYXJjaGNwdShl
bnYpLT5jZmcuZXh0X3NtZGJsdHJwICYmIG5ld19wcml2ICE9IFBSVl9NKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoCBlbnYtPm1zdGF0dXMgPSBzZXRfZmllbGQoZW52LT5tc3RhdHVzLCBNU1RBVFVTX01E
VCwgMCk7DQo+ICvCoMKgwqAgfQ0KPiArwqDCoMKgIGlmIChlbnZfYXJjaGNwdShlbnYpLT5jZmcu
ZXh0X3NzZGJsdHJwICYmIChuZXdfcHJpdiA9PSBQUlZfVSB8fA0KPiBuZXdfdmlydCkpIHsNCj4g
K8KgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0dXMsIE1T
VEFUVVNfU0RULCAwKTsNCj4gK8KgwqDCoMKgwqDCoMKgIGlmIChuZXdfdmlydCAmJiBuZXdfcHJp
diA9PSBQUlZfVSkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPnZzc3RhdHVzID0g
c2V0X2ZpZWxkKGVudi0+dnNzdGF0dXMsIE1TVEFUVVNfU0RULA0KPiAwKTsNCj4gK8KgwqDCoMKg
wqDCoMKgIH0NCj4gK8KgwqDCoCB9DQo+ICsjZW5kaWYNCj4gK30NCj4gKw0KPiArDQo+IMKgLyoN
Cj4gwqAgKiBSZXR1cm5zIHRoZSBlZmZlY3RpdmUgUE1NIGZpZWxkLg0KPiDCoCAqDQo+IGRpZmYg
LS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMgYi90YXJnZXQvcmlzY3YvdGNnL2RlYnVn
LmMNCj4gaW5kZXggZTRkNzE5YTFkYS4uMjUzNzUxNWY1NCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0
L3Jpc2N2L3RjZy9kZWJ1Zy5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYw0KPiBA
QCAtOTczLDYgKzk3MywxMSBAQCB2b2lkIHJpc2N2X2NwdV9kZWJ1Z19leGNwX2hhbmRsZXIoQ1BV
U3RhdGUgKmNzKQ0KPiDCoMKgwqDCoCBSSVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BVKGNzKTsNCj4g
wqDCoMKgwqAgQ1BVUklTQ1ZTdGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0KPiDCoA0KPiArwqDCoMKg
IC8qIFRyaWdnZXJzIG11c3Qgbm90IG1hdGNoIG9yIGZpcmUgd2hpbGUgaW4gRGVidWcgTW9kZS4g
Ki8NCj4gK8KgwqDCoCBpZiAoZW52LT5kZWJ1Z19tb2RlKSB7DQo+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm47DQo+ICvCoMKgwqAgfQ0KPiArDQo+IMKgwqDCoMKgIGlmIChjcy0+d2F0Y2hwb2ludF9o
aXQpIHsNCj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3MtPndhdGNocG9pbnRfaGl0LT5mbGFncyAm
IEJQX0NQVSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9fdHJpZ2dlcl9hY3Rpb24o
ZW52LCBEQkdfQUNUSU9OX0JQKTsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvdGNn
LWNwdS5jIGIvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMNCj4gaW5kZXggYjY4MTYwYWY4My4u
OTU5YTFlODljOCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMNCj4g
KysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMNCj4gQEAgLTI2OSw2ICsyNjksMTkgQEAg
c3RhdGljIHZhZGRyIHJpc2N2X3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsDQo+IGludCBtbXVf
aWR4LA0KPiDCoMKgwqDCoCB9DQo+IMKgwqDCoMKgIHJldHVybiBleHRyYWN0NjQocmVzdWx0LCAw
LCA2NCAtIHBtX2xlbik7DQo+IMKgfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCByaXNjdl9jcHVfZXhl
Y19lbnRlcihDUFVTdGF0ZSAqY3MpDQo+ICt7DQo+ICvCoMKgwqAgUklTQ1ZDUFUgKmNwdSA9IFJJ
U0NWX0NQVShjcyk7DQo+ICvCoMKgwqAgQ1BVUklTQ1ZTdGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0K
PiArDQo+ICvCoMKgwqAgaWYgKCFjcHUtPmNmZy5leHRfc2RleHQgfHwgIWVudi0+ZGVidWdfbW9k
ZSkgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiArwqDCoMKgIH0NCj4gK8KgwqDCoCB0
YXJnZXRfdWxvbmcgcGMgPSBlbnYtPmRwYzsNCj4gK8KgwqDCoCByaXNjdl9jcHVfbGVhdmVfZGVi
dWdfbW9kZShlbnYpOw0KPiArwqDCoMKgIGVudi0+cGMgPSBwYzsNCj4gK30NCj4gwqAjZW5kaWYN
Cj4gwqANCj4gwqBjb25zdCBUQ0dDUFVPcHMgcmlzY3ZfdGNnX29wcyA9IHsNCj4gQEAgLTI4NSw2
ICsyOTgsNyBAQCBjb25zdCBUQ0dDUFVPcHMgcmlzY3ZfdGNnX29wcyA9IHsNCj4gwqAjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkNCj4gwqDCoMKgwqAgLnRsYl9maWxsID0gcmlzY3ZfY3B1X3RsYl9m
aWxsLA0KPiDCoMKgwqDCoCAucG9pbnRlcl93cmFwID0gcmlzY3ZfcG9pbnRlcl93cmFwLA0KPiAr
wqDCoMKgIC5jcHVfZXhlY19lbnRlciA9IHJpc2N2X2NwdV9leGVjX2VudGVyLA0KPiDCoMKgwqDC
oCAuY3B1X2V4ZWNfaW50ZXJydXB0ID0gcmlzY3ZfY3B1X2V4ZWNfaW50ZXJydXB0LA0KPiDCoMKg
wqDCoCAuY3B1X2V4ZWNfaGFsdCA9IHJpc2N2X2NwdV9oYXNfd29yaywNCj4gwqDCoMKgwqAgLmNw
dV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LA0K

