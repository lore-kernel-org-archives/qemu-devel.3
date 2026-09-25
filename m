Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA09C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 03:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9x5K-0006dE-0z; Thu, 24 Sep 2026 23:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9x5E-0006cv-8t; Thu, 24 Sep 2026 23:58:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=721c190f3=Alistair.Francis@wdc.com>)
 id 1x9x5B-0006yL-Eb; Thu, 24 Sep 2026 23:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790308725; x=1821844725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MldWle4+DA7yoiVP8e7pfE17Ei4V69guUkROlYEEaVA=;
 b=huiFkfNKHvgny93XCL4HSQ9IK3RSHsqzneatEhbYuY5z9a/diUruITK+
 LtZe57hgCh0UJ7U2hTKD5pTmmV/GIkVIcdQqOItICB9HI4yplhG1Dwx0O
 kchUTi5nCkfygbI/Pi7x1qcbM2UkuspmbMNI7jh0gTR8hWRRjFMfQb+QH
 XoefR+G95TIraqCy3Jq36cp1QeEsRsJjCNW4VE/Vv/2osaM8bEduau+E6
 iq79axdXHcB08RfM8UyiNw8nKKT0YyhBDrYo1fG+pQiIPli0FnIoP0S54
 J028YaczQJ6Suf6X5WN/lqGmyq6xUsb/vDLFFtg9uTA2/DnX6Qm9FNiW9 g==;
X-CSE-ConnectionGUID: x4CcllbQS7GpjKfQfBv4VQ==
X-CSE-MsgGUID: o23qQt2ySfmgXUbK9qOpJQ==
X-IronPort-AV: E=Sophos;i="6.27,121,1786982400"; d="scan'208";a="155557435"
Received: from mail-eastus2azon11010058.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.58])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Sep 2026 11:58:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9TwqWEIEapBmybwSQB6U84vItJw/shpqbF87CQt3yeyDnFWLzAHgC8jKeAt2R1GjuDZkU6D8+3sR6asehc+PC9er9BRnEt+kKl1q0sd+t4/sgaPzWzoYSjVau+b/vBPGIkOMGmfQ6vumv27RwfHOSAdXm8UBrwyamnV9HJsEqvuVBHxpTk0hmvsSvvaTk2W8ehxo5tt2LKFcvzpotqb2cZ9zjcQwzkaDPFLXEaTYhQ8eI/GbCL9mcOmbS0R0mIQHDaf+rqXs5Mc9/q5J40lWi47Vt6XmRUC0xFgbpSuYRhdPBRzm80WNap+mpsqoUn73ftOwJOZCYoW3Vd3wIyA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MldWle4+DA7yoiVP8e7pfE17Ei4V69guUkROlYEEaVA=;
 b=H1JSlisox2JUt28xF9D+13hkYnxV+BfAqR7uwi02r6Pn46kGcPRyDfho5+7UKUJhG0BGPY9KXfA2rVS/aiJxOu4tNSArN9qUqIAfwqLqEsNu8c5t9vCdNy/mjFoFrE0zOIRIQ6EFB3R6NiUUlqirFQ+vyMdJ9j29pcTDQJM5OU6dc80TBbNpEGrKFo3LwxFDd6Hzu/uKAy027ouMhFMbtlzSBbgq3UPysoFRJaCU3a4k6oTjfixiOOq1fonUU9hS7rJ3VTdK881snlX1CFL15FRcJuE6Veq2A/EQpuM8elxBK3Y8A7AXjjiuZJTTqX7huOhW8LwDwpwQA42uRFwELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MldWle4+DA7yoiVP8e7pfE17Ei4V69guUkROlYEEaVA=;
 b=oXa/MGyW71zuQrL6wV+7si2l4AppbQQtltFQioW2koBGTbHGIfl8kTEEWWRbPtXbmDjdGFEsXEz6cPcZngbdENwUVA96nLMSDwbx9hFDVMstm1vY8u0rNnD1syvwcdrCHmKNxaHyt5MfAupNWXGcssbD20YWr1yVJo0bRkKgo4E=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY1PR04MB8752.namprd04.prod.outlook.com (2603:10b6:a03:535::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Fri, 25 Sep
 2026 03:58:36 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 03:58:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "almer@dabbelt.com" <almer@dabbelt.com>, 
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "eleanor15x@gmail.com"
 <eleanor15x@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v4 2/7] hw/misc: Add Sophgo CV1800B clock controller
Thread-Topic: [PATCH v4 2/7] hw/misc: Add Sophgo CV1800B clock controller
Thread-Index: AQHdMm6NvOmDM5ni6EWpotpl+WSmBrbe32AA
Date: Fri, 25 Sep 2026 03:58:29 +0000
Message-ID: <4873c084bfa15d5712bcbaa6bcbc4299517309f8.camel@wdc.com>
References: <20260822194315.2550260-1-visitorckw@gmail.com>
 <20260822194315.2550260-3-visitorckw@gmail.com>
In-Reply-To: <20260822194315.2550260-3-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY1PR04MB8752:EE_
x-ms-office365-filtering-correlation-id: 0a1b52c2-3398-4649-81c0-08df1ab942bb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|19092799006|10070799003|23010399003|6133799003|18002099003|22082099003|10067099003|5023799004|11063799006|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info: KrJnq5SfQnvUnh6I4zHCt1eC8N9CUuSVqK6ScwQxkGtrXrVE+xIWtkJBoIKKsaxkrL1qkOPU/oIaXhmljSSNKM94F3frTBPpRJqw2gIuuZDGZszR9vB1ci+cNupOiYjz6ObBmLBacdcS2EVpxWuEOCb458MMWVIF9U5oxVCCWTdA65/59A6UmZVoSeFxOBzxe8mHfTi27GCHVvNkrmdwoVvIZ84DvGhnKJ7qyKB0MYO40GmTYDEwwurG7bDJyaVaRDzv4L2oisJBdgUA5VxfTR/h2aB2WSFBy6Srk57Q6t8uEAg8I7AQf6q12zJ6iWQrHHwWyfNf6H9OkRDXh0LGlcn2v66lbaKGkQ49lHlXTED76ZDGBBWPajxXbVI8YakeUFNb8mif9kbcq9CZpb29qJhouRq/RacLV9XJE70yYgbmNhdz3o0Dq9w0PvYVRYVsRnAj2dZhbg8d0icU60ctrBIo2TRAFmSMn6b2fEDCka+Ycsl2ryRo63jyP8dzrRy5PLZw89xPuLp4TwRHx+RqRWFlmCf5/LcIAQIw2iN1EOjkoHT1rAGhl8ESZFPJDrA25JMRXZ/+/lIBWVUA4YMKBhtmlGWOxwuvrSQUyaVLuDmH3RhMzz3VKR7nGo6auOxViQvN/VnxCy4Xd2RGG/f+m1q+Hn00YSj8klfIcOo1x9DDiTYi5PqKK9LSOEg88l+sgWI7eSkfwen9KQO0IBLvCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(10070799003)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(5023799004)(11063799006)(38070700021)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDBrSHk1WllxaVcwM1NBd2dzc1FuV3BMd3VhYWo2QjIwSDBYMVdDeGxocU1s?=
 =?utf-8?B?YXR2UFB5S0x1WDVvZFFDWnhzRzA1azJUZFZlOHJRUGJZK055aTU1YTBCTERP?=
 =?utf-8?B?anp1YjFpbFJlT1R6VG5kMmNES2JiZE95dmVLbVR6Smh6c0c2MjkxWnhlc3Uw?=
 =?utf-8?B?TytxSTZNSHp0WCtLNXZlWG11OGcvSFZOTjd2bENRVlZoOUFRdGh0OTh1cXBG?=
 =?utf-8?B?cHhHSlQvdEU0YWlBb3JlZ2haRHd0Y0hlQUtyV3BpWHQ3NjRuSzFhWUVmenlZ?=
 =?utf-8?B?NGwyYkE5Q2hNalMva01IR2t2cWo0VmUwVUFIbWJ6WUg1NXFVMUc0RUpYTTZ6?=
 =?utf-8?B?MS8vUU9DamQ3VDNXVjREb2twekl1L01lZHAxVmdFUVc5Z09WOWU5TDdzV0g5?=
 =?utf-8?B?T3VRVzd3ZTh2cFFEdWl2ODY5Qk9oQVpURVV0Y3dIZnBwYmJVRTBHOGNoOGUr?=
 =?utf-8?B?c2V5QzI3WUU3VXVmdFF3dGwzdjJnbVB2dkM0Mk9nMjg2Y2pxRm9zOEdaZm04?=
 =?utf-8?B?cTdka3htVjNLdE42em16NWFMNWhWOUpRNWRVRXllNHNJRDJZb2lGMUpaV0Q5?=
 =?utf-8?B?alNMbDd2L01xMTExTFdldi95TVZQQmpKdFF4Z3llcVRRaEpjTEhGYXZGbmg1?=
 =?utf-8?B?T2psK0xXNjdIaTJ0aW1Pdjd1ZDdXbnl0ZUY5YzBLalY3dmdSaTJOZml1N1Jv?=
 =?utf-8?B?MjdJM29LNDB1VWtXY1ZiQWMrdFNOMWl2aHVDVjhqYVNBZnVSUGozRFYzVEFi?=
 =?utf-8?B?TGNINXkxN3lBVjBoTm5MaWpIaitoemZoY2VGaTMvSDN5YklUa1FVdHlFYWZx?=
 =?utf-8?B?ZjdqRURvajBMcnlKcFBoZ1Q2ZmpiQ05iL0J1QXlPeUFFcnVFV2V4eCtDSXZH?=
 =?utf-8?B?YmhQT2FUN2wySnNqSFoveWVOenV0QzdvQ3hVUW5VdlNsSkcvYUdGcjhOUTVi?=
 =?utf-8?B?SmdEYlVPM0twQk0wZ3VSUDFsdzFFSXR4ZVYvUnlmNGF1a1NnS3J3VER6WFQ1?=
 =?utf-8?B?VkxLYzg3U2hkeUtXSTczRU9vdE9CRFlVNXFkaFJJL0Z0QmpwREhaTC8rdi9D?=
 =?utf-8?B?NXRLcjZFaXpiRUMxYitZcExkNmIwYm5PZHVqYWRRVTBxTE9FK09FQjJMQSth?=
 =?utf-8?B?UWNoZGozQ2x4U3VEZE4yL2NGb1NKVmhtQUxycXdtc3l4ZC9uQVNuZm4wUEhs?=
 =?utf-8?B?Qy9zQmU0T0FPMUZSd3VsZ0p4WkNYaWwxSlRKb1d2K3gxWHFEajVVNkltN0xR?=
 =?utf-8?B?RGF2ZWJBb3JIc2Z5V2VnUWFSRWpxWENEUHpQUFJ5VzlmbXRJZWRhYkNNRHBw?=
 =?utf-8?B?S3hhdGxGeXRVT1BXTEhDRUFjaGNEbTlKYTE1Sy9HTDdTWDg0ZHJsN2Fpc2JH?=
 =?utf-8?B?YnVDVEFEbkhRTFA5SVhINlVxK2VHTWRmZGU2RVJoNHpSUzI5Z042am5XZ0xs?=
 =?utf-8?B?Nld0eHFDVzhmY25BYnBBRFc3VjZnaWdwTUJYeE9sWEthOGNNWmswS3FjV2lr?=
 =?utf-8?B?Q2UySkFHdXRYUzBhRkJYNG1oNTZxSE5LNW1veUMrVlNzTStXUTJCZVZSYmZM?=
 =?utf-8?B?OURGOEs4SUlmQ2pqbzhIVC8vR2xnRGZhUTN2c0tGUkV3VWZ6Y2EyZFJZMG1v?=
 =?utf-8?B?ZUJzOUxlNmRuMUE4dk9CNy9GVGlQUWJoRkhGMVYvOFhWOUxxd2lQL3RvMFA4?=
 =?utf-8?B?OVJLSzBxYkozdFEvM2dDZjhIMmxuck5EYWNZajFKWmR2aUVKb1FmREQya3F2?=
 =?utf-8?B?ZElKa085QjFGMlBzMnZhOThnVE9HT0FNb1BsTXp2TGlISjRkeWxuWUdYNHhk?=
 =?utf-8?B?RDNjNTZGaHJ3U0xBOUJOaTZoK0FILzBSajVWZVFzV01aNGE2dEpkZ096RUho?=
 =?utf-8?B?MjBTUjZKbW5LckxNaWhxODN4YUhBbHpkTzJTRmxvM1hmNVB2eE5Jek41MG9s?=
 =?utf-8?B?Kzh3ZzFacXd4cytBZjJadzdGRzhsY2N6NGxDcDlrVkFTeHl3ck16YU5NdGtM?=
 =?utf-8?B?WGFzRDJvQytObzgzZUxmQ3duaGNWYm81ZUF4VVhDQ0JweGN2RE8wTTlOWFpM?=
 =?utf-8?B?Q3dxMkZkWFhQK3FUOGNFS2R0SlpGT1NPZUs0UWg3NG1FaFlZN1ZKQ1pzVFN1?=
 =?utf-8?B?MSs1YUNPZmpha05qc0Y3MTkvRVBsY0EyVmFDam8yL3p1R05HR3hSUDhNNDJI?=
 =?utf-8?B?bXpreWIrOFVUK1dHWXk4SFZId1VxZENMZHNMYjZYbnRkSjlDa3ZyY1FtZWZw?=
 =?utf-8?B?WGRWWmhvbkJNdXI0cDJkUjlJOEs1ZW1UcURJSVlOZnJrOUxSa05xUG9kZ0FD?=
 =?utf-8?B?SUhaVUlVVFVMYi9DT2haTkhxVXl0MnpyVUdvQnJYaDZTRDNkaE01RnBRQW41?=
 =?utf-8?Q?4YHp+MMfr1WxJcN1OA6g5XkO3PVgkCeKOkCnKJ3yFK/gv?=
x-ms-exchange-antispam-messagedata-1: Bmwfrp6srQHzqCUmSC4Ts68r5w18kHZR/z8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9179C71109B48A4FB4BE647A8C5ED858@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pm0sEg+ZCdWROn5BJiIkH8KEwiitTbMPgyNkLGXVrd9POO5yWwRFJosnT0uUGNhqAoFXwbe4x4NbiT/5prq6ZbEeCikDgDLAj4Wy37hxvxMhDl/B3SgvByTp21lFv72e4ELs6XS86N9afEYS5qKwlkhWTnfTuFXK7FE/H+PHBF0K4eJULCqHosezM2r/JrRhXnA2tkDtGinGAcAdCnKsB8KBb+EXVuK/YNMi69x8Mhw6mwMpF5aE/oYuc1lZ7HRwbRn0Y8w/VxaEzgz1pKyJkcPfq9vYPgo4B9k3PlBvdtCTbQbJzN96wWMlp/B+OLIAHtovGpjnd7btIFZNr3lBkw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ah6UM8VFAraEjtT8DOz5Rx+O7ZthDiap2d1VpeHMtm+PlYCBwmhR/FCtqdTJ52W71Q9mNskIF+Ne+h5hsgL24TMrjJR2qSJba0ZFOfpH9HK/C7rHtHkUTh1dX1KEBepLpeXd5SU+1wphVd9wkxx2Rcl6GQHwlOLOVMXpmT5OlDenxo0JgWW6u08MKYrhnYmViEYtQ0+qlFFMu+x7jiUK+tcLdfqtLqjGGJ5gLkXWUFtflINFBfNIMi25pJTaanlXQmiPlABgEI5YAGdwMYBYfKMYpLUD/Vz/yNr+9hcdC7MeKifu+mqQziQUjt7cWqNBQyIsNCz55LBw+PNmXA5ICx/jOyRaaRFN31bLYYx1dhk4wHmT45dB/b2r5prarP2VmhH/nvpqqVoPlFEsnLVene4r0uMs6boHqIflVuAzbgwNilyWcPW7dhqiLq+FI5Awb3F+QskVNDu8rspXd3NDZGUxe9j76gh7jEI/6pL6r9eEMAD64mcEOleg0x4BCg+u42/CL12Qh3XQO1OQN3zEjERWsSXQUdazUx/hIw9cx0CYkZRQ34QGy20ARYgAU5Hx88YZ0SPu5hHsOD4D+Lcr3OOwH6dfQfcA/Q2bCAmeFbBoAs2w5u2zUUXZ/m4QeJqm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1b52c2-3398-4649-81c0-08df1ab942bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 03:58:30.0197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFdR9h2hLNVWehhnNXJuYuUrp8Ps0tfz0AP3/rd8Q6usblHFEr7cHM1YqPga1gXhzfxs48abfVVHIgMChj9KvdDfWwMBESfD/+M7kz97Z6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8752
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=721c190f3=Alistair.Francis@wdc.com;
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

T24gU2F0LCAyMDI2LTA4LTIyIGF0IDE5OjQzICswMDAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBBZGQgYSBzdHViIGZvciB0aGUgQ1YxODAwQiBjbG9jayBjb250cm9sbGVyLiBUaGlzIGlzIHNw
ZWNpZmljYWxseQ0KPiByZXF1aXJlZCBmb3IgdGhlIFNESENJIGNvbnRyb2xsZXIgdG8gZnVuY3Rp
b24gY29ycmVjdGx5IHVuZGVyIExpbnV4Lg0KPiANCj4gVGhlIExpbnV4ICdzb3BoZ28sY3YxODAw
LWNsaycgZHJpdmVyIHByb2JlcyB0aGlzIGRldmljZSB0byBkZXRlcm1pbmUNCj4gdGhlIGNsb2Nr
IHRyZWUgY29uZmlndXJhdGlvbi4gVGhpcyBpbXBsZW1lbnRhdGlvbiBzZXRzIHRoZSBieXBhc3MN
Cj4gcmVnaXN0ZXJzIChDTEtfQllQXzAgYW5kIENMS19CWVBfMSkgdG8gMHhGRkZGRkZGRiBkdXJp
bmcgcmVzZXQsDQo+IG1hdGNoaW5nIHRoZSBQT1IgZGVmYXVsdCBzdGF0ZS4gVGhpcyBieXBhc3Nl
cyB0aGUgUExMcyBhbmQgYWxsb3dzIHRoZQ0KPiBTREhDSSBhbmQgb3RoZXIgcGVyaXBoZXJhbHMg
dG8gb3BlcmF0ZSB1c2luZyB0aGUgMjVNSHogcmVmZXJlbmNlDQo+IGNsb2NrLg0KPiANCj4gV2l0
aG91dCB0aGlzIGRldmljZSwgdGhlIFNEIGNhcmQgZHJpdmVyIGZhaWxzIHRvIGluaXRpYWxpemUs
DQo+IHByZXZlbnRpbmcNCj4gdGhlIHN5c3RlbSBmcm9tIG1vdW50aW5nIHRoZSByb290IGZpbGVz
eXN0ZW0gZnJvbSB0aGUgU0QgY2FyZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1YW4tV2VpIENo
aXUgPHZpc2l0b3Jja3dAZ21haWwuY29tPg0KPiAtLS0NCj4gwqBody9taXNjL0tjb25maWfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrDQo+IMKgaHcvbWlzYy9jdjE4MDBiX2Ns
ay5jwqDCoMKgwqDCoMKgwqDCoCB8IDkwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+IMKgaHcvbWlzYy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
ICsNCj4gwqBpbmNsdWRlL2h3L21pc2MvY3YxODAwYl9jbGsuaCB8IDI2ICsrKysrKysrKysNCj4g
wqA0IGZpbGVzIGNoYW5nZWQsIDEyMCBpbnNlcnRpb25zKCspDQo+IMKgY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L21pc2MvY3YxODAwYl9jbGsuYw0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2h3L21pc2MvY3YxODAwYl9jbGsuaA0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L21pc2MvS2NvbmZp
ZyBiL2h3L21pc2MvS2NvbmZpZw0KPiBpbmRleCBiODg2MGRkM2U3Li4yMzI1ZGRkMzQ4IDEwMDY0
NA0KPiAtLS0gYS9ody9taXNjL0tjb25maWcNCj4gKysrIGIvaHcvbWlzYy9LY29uZmlnDQo+IEBA
IC0yNjAsNCArMjYwLDcgQEAgY29uZmlnIFhMTlhfWllOUV9ERFJDDQo+IMKgY29uZmlnIEFYSUFE
T19DTEsNCj4gwqDCoMKgwqAgYm9vbA0KPiDCoA0KPiArY29uZmlnIFNPUEhHT19DVjE4MDBCX0NM
Sw0KPiArwqDCoMKgIGJvb2wNCj4gKw0KPiDCoHNvdXJjZSBtYWNpby9LY29uZmlnDQo+IGRpZmYg
LS1naXQgYS9ody9taXNjL2N2MTgwMGJfY2xrLmMgYi9ody9taXNjL2N2MTgwMGJfY2xrLmMNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMC4uYjkyZjA4ODlhMw0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL2h3L21pc2MvY3YxODAwYl9jbGsuYw0KPiBAQCAtMCwwICsx
LDkwIEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAq
Lw0KPiArLyoNCj4gKyAqIFNvcGhnbyBDVjE4MDBCIENsb2NrIENvbnRyb2xsZXINCj4gKyAqDQo+
ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjYgS3Vhbi1XZWkgQ2hpdSA8dmlzaXRvcmNrd0BnbWFpbC5j
b20+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRl
ICJxZW11L2xvZy5oIg0KPiArI2luY2x1ZGUgImh3L21pc2MvY3YxODAwYl9jbGsuaCINCj4gKw0K
PiArI2RlZmluZSBSRUdfQllURV9XSURUSMKgwqDCoCAoNCkNCg0KWW91IGNhbiB1c2Ugc2l6ZW9m
KHVpbnQzMl90KSB0byBtYXRjaCBgcmVnc2ANCg0KPiArI2RlZmluZSBSRUdfQ0xLX0JZUF8wwqDC
oMKgwqAgKDB4MDMwIC8gUkVHX0JZVEVfV0lEVEgpDQo+ICsjZGVmaW5lIFJFR19DTEtfQllQXzHC
oMKgwqDCoCAoMHgwMzQgLyBSRUdfQllURV9XSURUSCkNCj4gKw0KPiArc3RhdGljIHVpbnQ2NF90
IGN2MTgwMGJfY2xrX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQNCj4g
aW50IHNpemUpDQo+ICt7DQo+ICvCoMKgwqAgQ1YxODAwQkNsa1N0YXRlICpzID0gb3BhcXVlOw0K
PiArwqDCoMKgIHVpbnQzMl90IHZhbCA9IDA7DQo+ICsNCj4gK8KgwqDCoCBpZiAoKGFkZHIgLyBS
RUdfQllURV9XSURUSCkgPCBBUlJBWV9TSVpFKHMtPnJlZ3MpKSB7DQoNClRoZSBjaGVjayBzaG91
bGQgYmUgYGlmIChhZGRyIDwgQ1YxODAwQl9DTEtfSU9TSVpFKWAgYXMgdGhhdCdzIHdoYXQNCnJl
Z3MgYWN0dWFsbHkgaXMgYWxsb2NhdGVkIGFzDQoNCj4gK8KgwqDCoMKgwqDCoMKgIHZhbCA9IHMt
PnJlZ3NbYWRkciAvIFJFR19CWVRFX1dJRFRIXTsNCj4gK8KgwqDCoCB9DQoNCkFsc28gc2hvdWxk
IGxvZyBhIGd1ZXN0IGVycm9yIGlmIGl0J3Mgb3V0c2lkZSB0aGUgcmFuZ2UuDQoNCj4gKw0KPiAr
wqDCoMKgIHJldHVybiB2YWw7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGN2MTgwMGJfY2xr
X3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90DQo+IHZhbCwgdW5zaWdu
ZWQgaW50IHNpemUpDQo+ICt7DQo+ICvCoMKgwqAgQ1YxODAwQkNsa1N0YXRlICpzID0gb3BhcXVl
Ow0KPiArDQo+ICvCoMKgwqAgaWYgKChhZGRyIC8gUkVHX0JZVEVfV0lEVEgpIDwgQVJSQVlfU0la
RShzLT5yZWdzKSkgew0KDQpTYW1lIGhlcmUNCg0KQWxpc3RhaXINCg0KPiArwqDCoMKgwqDCoMKg
wqAgcy0+cmVnc1thZGRyIC8gUkVHX0JZVEVfV0lEVEhdID0gdmFsOw0KPiArwqDCoMKgIH0NCj4g
K30NCj4gKw0KPiArc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBjdjE4MDBiX2Nsa19vcHMg
PSB7DQo+ICvCoMKgwqAgLnJlYWQgPSBjdjE4MDBiX2Nsa19yZWFkLA0KPiArwqDCoMKgIC53cml0
ZSA9IGN2MTgwMGJfY2xrX3dyaXRlLA0KPiArwqDCoMKgIC5lbmRpYW5uZXNzID0gREVWSUNFX0xJ
VFRMRV9FTkRJQU4sDQo+ICvCoMKgwqAgLnZhbGlkID0gew0KPiArwqDCoMKgwqDCoMKgwqAgLm1p
bl9hY2Nlc3Nfc2l6ZSA9IDQsDQo+ICvCoMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19zaXplID0g
NCwNCj4gK8KgwqDCoCB9LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgY3YxODAwYl9jbGtf
cmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpDQo+ICt7DQo+ICvCoMKgwqAg
Q1YxODAwQkNsa1N0YXRlICpzID0gQ1YxODAwQl9DTEsob2JqKTsNCj4gKw0KPiArwqDCoMKgIG1l
bXNldChzLT5yZWdzLCAwLCBzaXplb2Yocy0+cmVncykpOw0KPiArDQo+ICvCoMKgwqAgLyoNCj4g
K8KgwqDCoMKgICogVE9ETzogSW1wbGVtZW50IHByb3BlciBQTEwgc3RhdGUgbWFjaGluZXMuDQo+
ICvCoMKgwqDCoCAqIEZvciBub3csIHVzZSBQT1IgZGVmYXVsdCB0byBieXBhc3MgUExMcyBhbmQg
Ym9vdCB2aWEgMjVNSHoNCj4gWFRBTC4NCj4gK8KgwqDCoMKgICovDQo+ICvCoMKgwqAgcy0+cmVn
c1tSRUdfQ0xLX0JZUF8wXSA9IDB4RkZGRkZGRkY7DQo+ICvCoMKgwqAgcy0+cmVnc1tSRUdfQ0xL
X0JZUF8xXSA9IDB4RkZGRkZGRkY7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGN2MTgwMGJf
Y2xrX2luaXQoT2JqZWN0ICpvYmopDQo+ICt7DQo+ICvCoMKgwqAgQ1YxODAwQkNsa1N0YXRlICpz
ID0gQ1YxODAwQl9DTEsob2JqKTsNCj4gKw0KPiArwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9p
bygmcy0+aW9tZW0sIG9iaiwgJmN2MTgwMGJfY2xrX29wcywgcywNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBFX0NWMTgwMEJfQ0xL
LCBDVjE4MDBCX0NMS19JT1NJWkUpOw0KPiArwqDCoMKgIHN5c2J1c19pbml0X21taW8oU1lTX0JV
U19ERVZJQ0Uob2JqKSwgJnMtPmlvbWVtKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgY3Yx
ODAwYl9jbGtfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQNCj4gKmRh
dGEpDQo+ICt7DQo+ICvCoMKgwqAgUmVzZXR0YWJsZUNsYXNzICpyYyA9IFJFU0VUVEFCTEVfQ0xB
U1Moa2xhc3MpOw0KPiArDQo+ICvCoMKgwqAgcmMtPnBoYXNlcy5ob2xkID0gY3YxODAwYl9jbGtf
cmVzZXRfaG9sZDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IFR5cGVJbmZvIGN2MTgwMGJf
Y2xrX2luZm8gPSB7DQo+ICvCoMKgwqAgLm5hbWUgPSBUWVBFX0NWMTgwMEJfQ0xLLA0KPiArwqDC
oMKgIC5wYXJlbnQgPSBUWVBFX1NZU19CVVNfREVWSUNFLA0KPiArwqDCoMKgIC5pbnN0YW5jZV9z
aXplID0gc2l6ZW9mKENWMTgwMEJDbGtTdGF0ZSksDQo+ICvCoMKgwqAgLmluc3RhbmNlX2luaXQg
PSBjdjE4MDBiX2Nsa19pbml0LA0KPiArwqDCoMKgIC5jbGFzc19pbml0ID0gY3YxODAwYl9jbGtf
Y2xhc3NfaW5pdCwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGN2MTgwMGJfY2xrX3JlZ2lz
dGVyX3R5cGVzKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmN2
MTgwMGJfY2xrX2luZm8pOw0KPiArfQ0KPiArDQo+ICt0eXBlX2luaXQoY3YxODAwYl9jbGtfcmVn
aXN0ZXJfdHlwZXMpDQo+IGRpZmYgLS1naXQgYS9ody9taXNjL21lc29uLmJ1aWxkIGIvaHcvbWlz
Yy9tZXNvbi5idWlsZA0KPiBpbmRleCA4NThjYTg0NWEyLi40YzZhZTU1MWJhIDEwMDY0NA0KPiAt
LS0gYS9ody9taXNjL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L21pc2MvbWVzb24uYnVpbGQNCj4g
QEAgLTM3LDYgKzM3LDcgQEAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1NJRklWRV9FX1BS
Q0knLA0KPiBpZl90cnVlOiBmaWxlcygnc2lmaXZlX2VfcHJjaS5jJykpDQo+IMKgc3lzdGVtX3Nz
LmFkZCh3aGVuOiAnQ09ORklHX1NJRklWRV9FX0FPTicsIGlmX3RydWU6DQo+IGZpbGVzKCdzaWZp
dmVfZV9hb24uYycpKQ0KPiDCoHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19TSUZJVkVfVV9P
VFAnLCBpZl90cnVlOg0KPiBmaWxlcygnc2lmaXZlX3Vfb3RwLmMnKSkNCj4gwqBzeXN0ZW1fc3Mu
YWRkKHdoZW46ICdDT05GSUdfU0lGSVZFX1VfUFJDSScsIGlmX3RydWU6DQo+IGZpbGVzKCdzaWZp
dmVfdV9wcmNpLmMnKSkNCj4gK3N5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19TT1BIR09fQ1Yx
ODAwQl9DTEsnLCBpZl90cnVlOg0KPiBmaWxlcygnY3YxODAwYl9jbGsuYycpKQ0KPiDCoA0KPiDC
oHN1YmRpcignbWFjaW8nKQ0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9taXNjL2N2
MTgwMGJfY2xrLmgNCj4gYi9pbmNsdWRlL2h3L21pc2MvY3YxODAwYl9jbGsuaA0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi40ZDAzZDg4N2M2DQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvaW5jbHVkZS9ody9taXNjL2N2MTgwMGJfY2xrLmgNCj4gQEAgLTAsMCAr
MSwyNiBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIg
Ki8NCj4gKy8qDQo+ICsgKiBTb3BoZ28gQ1YxODAwQiBDbG9jayBDb250cm9sbGVyDQo+ICsgKg0K
PiArICogQ29weXJpZ2h0IChjKSAyMDI2IEt1YW4tV2VpIENoaXUgPHZpc2l0b3Jja3dAZ21haWwu
Y29tPg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgSFdfTUlTQ19DVjE4MDBCX0NMS19IDQo+ICsj
ZGVmaW5lIEhXX01JU0NfQ1YxODAwQl9DTEtfSA0KPiArDQo+ICsjaW5jbHVkZSAiaHcvY29yZS9z
eXNidXMuaCINCj4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+ICsNCj4gKyNkZWZpbmUgVFlQ
RV9DVjE4MDBCX0NMSyAiY3YxODAwYi1jbGsiDQo+ICtPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQ
RShDVjE4MDBCQ2xrU3RhdGUsIENWMTgwMEJfQ0xLKQ0KPiArDQo+ICsjZGVmaW5lIENWMTgwMEJf
Q0xLX0lPU0laRSAweDEwMDANCj4gKw0KPiArc3RydWN0IENWMTgwMEJDbGtTdGF0ZSB7DQo+ICvC
oMKgwqAgU3lzQnVzRGV2aWNlIHBhcmVudF9vYmo7DQo+ICsNCj4gK8KgwqDCoCBNZW1vcnlSZWdp
b24gaW9tZW07DQo+ICvCoMKgwqAgdWludDMyX3QgcmVnc1tDVjE4MDBCX0NMS19JT1NJWkUgLyBz
aXplb2YodWludDMyX3QpXTsNCj4gK307DQo+ICsNCj4gKyNlbmRpZg0K

