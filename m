Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDA9C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj41m-00043b-GN; Sun, 12 Jul 2026 19:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=646a5f148=Alistair.Francis@wdc.com>)
 id 1wj41j-000435-SS; Sun, 12 Jul 2026 19:56:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=646a5f148=Alistair.Francis@wdc.com>)
 id 1wj41h-0007vV-Vk; Sun, 12 Jul 2026 19:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1783900562; x=1815436562;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ja44D+gcNcSEFPf4fyEWpfvNu5z1cvMEoC/uW4e8PyA=;
 b=YkCoL/vLUj3HhmaEPMcqbDU+BauMVxTC7Gqpv8ftDSBcARULyl9WT2Y7
 o97kuBuQiIMzQysu70szc257OOerEYl4eCgnBcNMWnxPWpcAGVvS/qGoR
 ojZWurXm5C9RaBjoMDYV0D9RiGe8UsH/tvzmFACOwHwwcaq2ria4oRbjw
 wNMEqq6YhS8wPDIdt7mSdsaQsC8MFYXbI/TMUEd5sZ1s3JrQiXKp3Od/w
 UgdiHvaI1mA3G+7QLuTpQjpZejT21P5nlWgeiH1AvzpBKS7R48tYung9X
 nOX0a9xOar5g3iQFK1cL/q3dg1vR/Hp2h4bSd4g13ZiAbkR6VpnLi2Wco A==;
X-CSE-ConnectionGUID: VD/RyslPSxiNp38fgATXXA==
X-CSE-MsgGUID: q21fl4ikTouzRB+KwfI9+w==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; d="scan'208";a="146733341"
Received: from mail-southcentralusazon11013016.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.16])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Jul 2026 07:55:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Isx0CJwmYWhUEf8qIyoeIZB2i4heazaQCIxOPM1opAtNtiIgzjMs69Km9IwGfGbXbORbSvv+TsdGp/QA5FKEvD7j5iyxiZUWaUqe6flI04WtGBeNZUvTSNuLeyGo/b46eG5eXDpAyZGYWhQVCudr+kVI/yJXofPeDq76ZGTVPlSCiT249+t18rfVqzrg1DNukrjNd/g0G8k8YCYILj/rvZSACiEXXgYOYbXvLj1k3OCrXWS2utpeANVot/UPRpSqpC9wCCSIaIbwBTTWDvZE21nKh2ispBcWVw9fQhZ+E8WGpg5sAEEZU3WmtyRYFXksFUcFNAsKZ/pVLZgB4VtL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja44D+gcNcSEFPf4fyEWpfvNu5z1cvMEoC/uW4e8PyA=;
 b=oPj/mLfuE0QwW6x2aFarqeM2ZGFFeiG8QxpR088yqnsF2d2rOJN0c4F+GzjVodHvTSE7wpbjnaiIK/p73WyyU2MzrnmfTUF8UvHfyswKy2oIyrQ/h9g7uarJJelQvgbLY8UNGxAcDKvbwe+7qn9crl02GE2JKyP9RS8Si5sWQaNXoJ7WKTh+NI7Lo0ueGvF6pgxFavayfh/ZC34pAl0HjVDg7PVlMiNWd+otrodn22S7Og9DcIA1q3S0IxaVvB89uoMQyzvUOdmLLEEmU1rx42OWiNcWK8vjR8HRJJrGzEPheqMbX1hDJe373sz6kTndJqeaFtYCBilWo+vNWaN4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja44D+gcNcSEFPf4fyEWpfvNu5z1cvMEoC/uW4e8PyA=;
 b=oie1pCzwnqVK0wmGKLPo/J6ugEHwBmZi51qG/6mMkcNDBXfA1mpYD8Bg6e81r0K3FLoEHVYlD1cQYRWwsKu30hwxEG63gwLqd/Qqzyz6xfJXqCB2mvxOUFaXJtINPreRfDtMYC/Lh9hGlAZw/IaZEswON+ehabzmMpgoq1WCtxs=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH2PR04MB6588.namprd04.prod.outlook.com (2603:10b6:610:6c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Sun, 12 Jul
 2026 23:55:56 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0202.014; Sun, 12 Jul 2026
 23:55:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "mjt@tls.msk.ru" <mjt@tls.msk.ru>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "frank.chang@sifive.com" <frank.chang@sifive.com>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "gaochengbo@bosc.ac.cn" <gaochengbo@bosc.ac.cn>,
 "andrew.jones@oss.qualcomm.com" <andrew.jones@oss.qualcomm.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: set ftype and iova in
 riscv_iommu_ctx()
Thread-Topic: [PATCH] hw/riscv/riscv-iommu.c: set ftype and iova in
 riscv_iommu_ctx()
Thread-Index: AQHdCTsyVghpaI50bkWENGmTnny2GbZoAJWAgAKg5wA=
Date: Sun, 12 Jul 2026 23:55:55 +0000
Message-ID: <d3c0dd9726bc4665922df51af9325ae120bbbde1.camel@wdc.com>
References: <20260701092241.307801-1-daniel.barboza@oss.qualcomm.com>
 <59d0a99c-8eb2-4192-a388-331d0dd93358@tls.msk.ru>
In-Reply-To: <59d0a99c-8eb2-4192-a388-331d0dd93358@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH2PR04MB6588:EE_
x-ms-office365-filtering-correlation-id: 97e6ef10-6010-4aa7-a046-08dee0711d02
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|23010399003|366016|10070799003|1800799024|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007;
x-microsoft-antispam-message-info: SydKkR9b+IlS76aN19mwbqEbmgZMK6/jp7GKHtg6wfM00JMMc57V+Ajsqf3RrySFlQy+wSOFjtXZF6ZUUUoGMIVWB8DAMabYG7ko9cHpu3sGi3z28DAqt3DEZhmnxDoznMX4LBBLgyd57VeyhhXg/ihwC7w8xRQe3qz+eRHlm0hExFueCubZccb3GlnQC1GFfh2grBn7Ws5ZZ8Jj9ItS8ITAN3TX+VcYr+wD32aem2NimY1Bylkiny3oNYxUUgw4FmhqaFjQ8R1tfO84uwc+R0LkW8XTdJ+ewazsa0cZf5GugN6aeFwgToLNPGhxuYSZO6T+FZvxeylUbyvzDfHCNYxZtAMKP5iG5BxqETHKjRAuZn1IcIDTslVJeV0400/K1qlvZUVb/GI+LgOfTA9ODb8cN4pVnQIhjArRj5SuYtK3TmDoPZbj9UtPyPaX+2T8O00NHDjkHwKXwsvnFJk+H3rdTXqNsDgj0efdDWadlEH59I8fZ8xkHy8w/D/Vt0VXgMjJw47LWfIjOtgM9WgFXvW3oVgycqqvhLY4gLlERdiZV52aTSjcZl22aADmxp++K8KI1Vm52KTRD1pWNjePuWCN/3kglqVaR+925yoJaHWbHt+MFRPx4B4dcBz3hBaEQmkVdGqGg2oIxHomeAs/QSJo4hfo6eIfx0phiCMhVckfys6w/VN6nHeam0H9HpNaQYg+0det+Jao86cNSAQ2TgA9Fsunz6cI+YkJfcefw8Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(366016)(10070799003)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2RCcnZlWUxoekVJQk1ncU5yZ3RHcFFLNFJCellBM0FWbVgxYTVQN0lhZlJI?=
 =?utf-8?B?M1FJc3hVSmszcXE5cTNaNFhtandwTzl0M1lMVDVUbFU1bWpXcVA1UXBIaHdx?=
 =?utf-8?B?enpCVXdzazZ2Z0Jod0p5QkZjdkVVWDhsNm1hNS9tTFV6OTFtSndzSi9WZFo0?=
 =?utf-8?B?OVBUZjI5SlAvSGR1TFI2TXVkcDVTMTJ1ai9OQVlwQ1RHZ21aclFrdUFTem9T?=
 =?utf-8?B?NVcxaEJuSEpoa0ZtMkdXaklqcmQyR1psZ0FnbzRnZGE1VnVPUWQ2TXhVMmNF?=
 =?utf-8?B?OUtrK2dVaDVYQjVzcEtOdG5tcGxybGNkWHhWeGo3Yk8zNExlalg2bUJlank0?=
 =?utf-8?B?WFlHOG5NdEJJc3BiSmZuTU5mN2Zabk0wdDM0SnlRYk45alZVczl5R2pvL3dY?=
 =?utf-8?B?K1kxSkwySUxuUzFuZTJ5WUNOTGZMTWJwVlFnZWxaMWttNjhpUktnNm5vcFVw?=
 =?utf-8?B?WG5CTnE0SFlEMVpJY3VmbjZoem9ZR1YxSDlnZDF2TitJS3QyL2kwTEVEU0l6?=
 =?utf-8?B?Ti9GNzJpYmlOQjZ2R1V6eGZ5K1pLaWVVeklCamtQNzFUNkREOVVaaXpDNmRB?=
 =?utf-8?B?UkRadTJYbEJMV1pPNVNBK29VSlVyNDFESW5PWVFaUjJ2WUZqc0lVTzJITXky?=
 =?utf-8?B?aVZGUWErTDlXaGpuU1Vaa2VpeUVjaUhrRFIrdG1WdjJwK0JVWjdyVzhLOFQr?=
 =?utf-8?B?WDFxNmtyZlVNUEIzaDJVb1dKaGJHRmZmVm5VNTduVlJTaDd3OTdnVDNFS09n?=
 =?utf-8?B?WXdrVTRJVnd5c3JhdWpzUHJTZUdhTU1SWWdHMWFHS3VBUFhEak5ZSDNxZEVQ?=
 =?utf-8?B?RW1JeWRkazk2TWFCWXVxbEtFTGFyeU5KZUlkSmVYWmJFVUdqK0RNNUgwL3VK?=
 =?utf-8?B?dFFxLzB4a0xKdjRySXpZdWtuc1F6QnlHSnV3aC9uSWY3cmlSRkZBZzNYTGMv?=
 =?utf-8?B?SEw4WmE4TzBHZU41a2dvRzZVdXphQS9tWll3UWxhVXpEd0FWcEZzRllDa0xr?=
 =?utf-8?B?KzZ3c1FWYktTMVhYbFdNQWdTeGNFL1BKNmxqSmN4QmM5OGVNc2pGckNGY3lJ?=
 =?utf-8?B?NDZBTzZ4K3l3amp4N0N2azRzSEVvMDZ5ZXpocUxvbVp6NXlLMVk4bTZSNkNJ?=
 =?utf-8?B?RUYvQm52M2NBL2lrUTJaY2srMUVHTnFVQTkwWll6ZGFTaGlhOHFsa3lzTlAr?=
 =?utf-8?B?dHNzVXprSWt6aVhwbE9VWTVrYktZQmV0YjNkL0EzOEhZbzdWak5oSTFnK3Av?=
 =?utf-8?B?dTRKSkdFQm0vK0RIaENnekt2L25SQWo5aERqTHlhKzZwbFpxSG85aVo2K0t4?=
 =?utf-8?B?MkN6Z1FBVFhLTDh5T1RRdEtJYnhYclJXYWJ0RGJUUDRTTlh0Q1Z6MUVUS3JP?=
 =?utf-8?B?WGxUazNVRlNnUTFUNjZMN0dVR1VhUk9OUnA4ZXRFTXI3aUR0SkVFT2taeTlO?=
 =?utf-8?B?ckEvQzRSYWFBNnRSYWxmYVgwd05yc296c1oybDAreldjUWpVU1ZhTXlXNjh4?=
 =?utf-8?B?am8ySi9IMW9xdmE3VWVYb1Q0TldpMGJHVGtnNGZSU0N3VG8zRm04V3YwMjRD?=
 =?utf-8?B?RVYrU3dxdlVJbXdNWmV4NS9GY0pFeDFSdzl4S3FaZE0zektyN2ZFMkFNRks4?=
 =?utf-8?B?TnJlSEZyMHhxbmM5OE5zd2VxNVlzNVVYTlBxZnJYL3NpSllBbFVkNHV4R0py?=
 =?utf-8?B?dDFwY0xDZURHbmNobHAwVWNXZ21zR2h6b1ppTkFpOU1mN2ZhTHJqM3JGMnh1?=
 =?utf-8?B?OE83RlVpdGw2VW1IR1pxWFh5WHlKemtaMGM4ODFGaWQ1TW9YeE1BYXczQmpM?=
 =?utf-8?B?SHZ4WkxteEJkQkZBYUVCeVVvZW1JOVZuK3RZdWJZWU5LVWIxdERyUVRydVhG?=
 =?utf-8?B?VEEvSDBjMEJPdmpPR3pNUXlEL1J0cmEwMzlJUVZlcmxQb2MrVW9CaGdySXA5?=
 =?utf-8?B?aGFNU1k4cFNRc0t3QTRoYS91RThvNnVzMzZtelpGbmJXUW1xTlllUklEbkZY?=
 =?utf-8?B?bytnVzRZVzFXcytpVnp0NlBERFpMQXgxS0wrUGYwbHpYMWtwK0ZtUXB0NUty?=
 =?utf-8?B?VW1YZkk1c21mSXIwS3VjTnFuaUJtODcweVZMdTA2R1M5N0dKa0VVTis4KzNS?=
 =?utf-8?B?cUM2Z3owVGtZTFdzWUhaU1ZHZmJ4MGVvVGRzZlZZckx2TTl2K1IwMitnb0lP?=
 =?utf-8?B?b3dNc0ZEdE1Na1ZyKzkzNHd5WGdzZWgrTkJGdVZZdHRVZGlXcWdDVUg3MTZw?=
 =?utf-8?B?SHpNM0krb25IREFQWTcrZ2xyZmtMZjI4TWh6TlRXcG5tZlErYzQ3Y2dZY3lP?=
 =?utf-8?B?S1FWWTJjWmdKOVNJUUk5UVZPaXNVWjIxaVQvS1lvM2VLazhGVUF3RTRkVHBo?=
 =?utf-8?Q?HovryeXozu3Ddxa6OEjbjTsrmM+2Ud7YK3vfb9/eyGf3B?=
x-ms-exchange-antispam-messagedata-1: iXl5Ii0QqtfpZPowHr1oBsSXQyhQwHajmVU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBFF6DB98201404B83F60363D9A98DA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VkWYWLwZ3JA3Pj9d2/SchuJsDr9X8tEjj+i26rKX045Hz+EO7dxAVqbDvv/hlXrpVAFMNKL8i5XuXrAL5lJ5MdDuVlXZpXjb5sLsWi21KYZ+1roQiKYfyX8+Zncbll9Id7TFQnmV0lexWM5ad9awD9mDocm8iKbTNOAIg+jM6eaxxWaLbfv6uWdVM515WX2zGmVHIHao2ZvZ5YLGS7KkL93cu/RWYKD8UyUHdPG4PBFToR397BV3Y1ttnaD1Gi5+LK8NaGhvRd8O0zHJGE0iZCYc/OcuxVMzENUgvyfzC1PEXblwJZ04i6qDzdLD9CWRcgc2olC21ykM28uFSi/WZw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mvxmfhC0ve30XaEnE4gwjBc+cOK6zbqPIfiJ3zk2Yz6Rkyb3TE33A/nzGRDwqnbMU0ySHUtxTqwY/81n4CbjnTrZXT713qNbaPqphYdjXdglQlEt8h8zYYwKu39qkke9NCIfFguuCEoH0bvU5Hx3NTaNaUgod2rfVbmbPXFW5MJ4SUjyZcwuYcNQ7EIinG/vgapNX2HmahC75ibSzyKX5BOC7/sIV7NGTlvbKm94rZkKwY/ETxkHESpqzEG0dS1CEZyLFj9XHP6n6ZY32AGz1xB8HKV8nPrpbnhSHyorNPMtabTaaC7mV2ahwBbKdn0rZcWg9jyJX3MyShw76TsInc9DdffbdoorwsDSfcXup8rwqjzdZ70Du3FBwJBWS6tSdcaI2RV76J9pOXjGdvYVnkC7Ks79nWh5LNYQtizu74VQj+c5cuUJZ3z4jodpc3YvS0e3FGzXzGou/fcAqljO/9NiLRaHnxyPih3np0Xt+A7j8tc37djDaUBVP9HtrDADiTKwIxl9YgpJoabFC3mErWsk1H9cXPzx58DHo/l75WEYYPHwKXuGlXc9HGsnNPCQjZIGHszWMpXFYoHtVtDvzXtRcGFMSDb/wj8jg4YCIb+FW4QsEjwrxcs/S9h7kG6o
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e6ef10-6010-4aa7-a046-08dee0711d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2026 23:55:55.4987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6hQSgFpxnzLT7nzXbBWedBLngQl7FwBHJbw6dfpitxQ4xsexB47c09TCyWCNo8aqIP6wGUSOJHM61yFe0Dmfc3iIKZ2EOzVDgZAtGUMTmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6588
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=646a5f148=Alistair.Francis@wdc.com;
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

T24gU2F0LCAyMDI2LTA3LTExIGF0IDEwOjQ3ICswMzAwLCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6
DQo+IE9uIDcvMS8yNiAxMjoyMiwgRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgd3JvdGU6DQo+ID4g
V2UncmUgaGFyZGNvZGluZyBmYXVsdGluZyB0eXBlIGFzIFJFQUQsIHdoZXJlIGl0IGNvdWxkIHZl
cnkgd2VsbCBiZQ0KPiA+IGENCj4gPiB3cml0ZSBhY2Nlc3MsIGFuZCB3ZSdyZSBub3QgcmVjb3Jk
aW5nIHRoZSBmYXVsdGluZyBhZGRyL2lvdmEuDQo+ID4gDQo+ID4gQSBub3RlIHdhcyBhZGRlZCBp
biB0aGUgZmF1bHRfdHlwZSBsb2dpYyBiZWNhdXNlIEkgd2Fzbid0IGFibGUgdG8NCj4gPiB0cml2
aWFsbHkgaGFuZGxlIGEgcHJvYmFibGUgY29kZSByZXBlaXRpdGlvbiBpdCBpbiB0aGlzIHNhbWUg
cGF0Y2guDQo+ID4gU29tZXRoaW5nIHRvIGRvIGluIGEgbGF0ZXIgZGF0ZS4NCj4gPiANCj4gPiBG
aXhlczogMGM1NGFjYjgyNDNkICgiaHcvcmlzY3Y6IGFkZCBSSVNDLVYgSU9NTVUgYmFzZSBlbXVs
YXRpb24iKQ0KPiA+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3Fl
bXUvLS93b3JrX2l0ZW1zLzM1NjQNCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YQ0KPiA+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiA+IC0tLQ0K
PiA+IMKgIGh3L3Jpc2N2L3Jpc2N2LWlvbW11LmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLQ0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPiANCj4gRm9yIHRoZSBzdGFibGUgcWVtdSBzZXJpZXMgKGN1cnJlbnRseSAxMC4w
LngtTFRTIGFuZCAxMS4wLngpLCBpbg0KPiBvcmRlcg0KPiB0byBwaWNrIHRoaXMgY29tbWl0LCBJ
IGFsc28gcGlja2VkIHYxMS4wLjAtMTIxMi1nY2E3YmFjNTFlMDQNCj4gImh3L3Jpc2N2L3Jpc2N2
LWlvbW11OiBBdm9pZCBjYWNoaW5nIFBDSSBkZXZpY2UgSURzIiBieSBDaGVuZ2JvIEdhbw0KPiAo
Q2MnZWQpIC0gYmVjYXVzZSBpdCB0b3VjaGVkIHRoZSBzYW1lIGNvZGUgYW5kIHRoZXJlJ3MgYSBt
ZXJnZQ0KPiBjb25mbGljdC4NCj4gSSBjYW4gZWRpdCB0aGlzIHBhdGNoICgic2V0IGZ0eXBlIGFu
ZCBpb3ZhIGluIHJpc2N2X2lvbW11X2N0eCgpIikNCj4gaW5zdGVhZCwNCj4gYnV0IGl0IGZlbHQg
dGhhdCBjYTdiYWM1MWUwNCBpcyBhbHNvIGEgZ29vZCBwaWNrIGZvciB0aGUgc3RhYmxlDQo+IHNl
cmllcy4NCj4gDQo+IEFkZGl0aW9uYWxseSBmb3IgMTAuMC54LUxUUyBzZXJpZXMsIEkgYWxzbyBw
aWNrZWQgMiBtb3JlIGNvbW1pdHM6DQo+IA0KPiB2MTAuMi4wLTMyMy1nMTU0MDZjYzU5M2EgImh3
L3Jpc2N2OiByaXNjdi1pb21tdTogRG9uJ3QgbG9vayB1cCBERFQNCj4gY2FjaGUNCj4gwqAgaW4g
T2ZmIGFuZCBCYXJlIG1vZGVzIiBieSBGcmFuayBDaGFuZyAoQ2MnZWQpLCB3aGljaCBhdm9pZHMg
YSBtZXJnZQ0KPiDCoCBjb25mbGljdCBhbmQgYWxzbyBsb29rcyBsaWtlIGEgKG1heWJlIG1pc3Np
bmcpIGJ1Z2ZpeC4NCj4gDQo+IHYxMC4yLjAtMzEyLWdjNDk3ZWY2NzM5YyAiaHcvcmlzY3Yvcmlz
Y3YtaW9tbXU6IEZpeCBNZW1vcnlSZWdpb24NCj4gb3duZXIiDQo+IMKgIGJ5IEFraWhpa28gT2Rh
a2ksIHdoaWNoIEkgc3BvdHRlZCB3aGVuIGxvb2tpbmcgZm9yIHRoZSBoaXN0b3J5IG9mDQo+IMKg
IGNoYW5nZXMsIGFuZCB3aGljaCBsb29rZWQgbGlrZSBhbiBvYnZpb3VzIGJ1Z2ZpeC4NCg0KVGhh
bmtzIGZvciB0aGF0LCB0aG9zZSBib3RoIGxvb2sgbGlrZSBnb29kIGNhbmRpZGF0ZXMuDQoNCj4g
DQo+IEhvcGVmdWxseSB0aGlzIGlzIG9rYXkuwqAgVW5mb3J0dW5hdGVseSBldmVuIHRoZSBzaW1w
bGVyIGNoYW5nZXMNCj4gYnJpbmdzDQo+IHVwIHF1aXRlIGEgbG90IG9mIG1pc3NpbmcgZml4ZXMg
anVzdCBieSBhIGNoYW5jZSAtIHRoaXMgbWVhbnMgdGhhdCB3ZQ0KPiBlaXRoZXIgbm90IGRvaW5n
IGEgZ29vZCBqb2Iga2VlcGluZyBzdGFibGUgc2VyaWVzIHVwIHRvIGRhdGUgKGJ5DQo+IG1hcmtp
bmcNCj4gY29tbWl0cyBmaXhpbmcgc3R1ZmYgZm9yLXN0YWJsZSksIG9yIHdlIHNob3VsZCBub3Qg
dHJ5IGZpeGluZyBzdHVmZg0KPiBpbg0KPiBwcmV2aW91cyBzZXJpZXMgZm9yIGEgdG9vLWZhc3Qt
bW92aW5nIHRhcmdldC4NCg0KUHJvYmFibHkgYm90aA0KDQo+IA0KPiBJJ20gc29ycnkgSSdtIGJy
aW5naW5nIHVwIHRoaXMgbW9yZSBnZW5lcmFsIHF1ZXN0aW9uIGluIGEgdmVyeSBuYXJyb3cNCj4g
Y29udGV4dCBvZiB0aGlzIHBhcnRpY3VsYXIgZml4ICh3aGljaCBtaWdodCBub3QgZXZlbiBiZSBp
bXBvcnRhbnQNCj4gZW5vdWdoKS7CoCBNYXliZSBJIHNob3VsZCBkaXNjdXNzIHRoaXMgc2VwYXJh
dGVseS7CoCBPdmVyYWxsLCBJJ20NCj4gaGF2aW5nIHNvbWUuLiBpc3N1ZXMgd2l0aCByaXNjdiBw
dWxscmVxcyBpbiBjb250ZXh0IG9mIHN0YWJsZSBzZXJpZXMsDQo+IGl0J3MgYWx3YXlzIG1vcmUg
dGltZS1jb25zdW1pbmcgdG8gaGFuZGxlIHRoZXNlIGFuZCBhIGJpdCBtb3JlDQo+IGRpZmZpY3Vs
dA0KPiB0byBkZWNpZGUgd2hhdCBpcyBpbW9ydGFudCBhbmQgd2hhdCBjYW4gYmUgc2tpcHBlZC4N
Cg0KVXJnaC4gSSdtIHNvcnJ5IGFib3V0IHRoYXQuIFdoYXQgY2FuIHdlIGRvIHRvIGhlbHA/IElz
IHRoZSBpc3N1ZSBqdXN0DQp0aGF0IEkgYW0gbm90IG1hcmtpbmcgY29tbWl0cyBvciBzb21ldGhp
bmcgZWxzZT8NCg0KQWxpc3RhaXINCg==

