Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608DCC61DE4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 01:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0qXO-0007OC-Ng; Sun, 30 Aug 2026 21:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qXK-0007L0-0j; Sun, 30 Aug 2026 21:10:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=696fae14a=Alistair.Francis@wdc.com>)
 id 1x0qXH-0007Zs-KT; Sun, 30 Aug 2026 21:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788138608; x=1819674608;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SlilZyERMiqX+ABjoY4Uhg8/kWpePSXyoJ3+kREjuhY=;
 b=lOpbbfn2NCeG4idIVwmZC461MxnzXkvrk1bsIoLrs2+OeBMFEDg1YeGa
 r3U89B1D0fCfa8+1MfOdzVTJ+zU7pEu6Kb2aFoqnvExAE2mLS3ky1bNLK
 CiFlrpgkS8Op96266NJAnc/HbBCEo9uNOJeVlW3a0CGdOsyxvXRCc8JY8
 2tVQBwWFBCbw03GDE0zf0WBy6VJ7fCDvBafkosM0birF2DCbSL+xrcqB8
 e0AibtuHnTz/qYIjLZ08Tt74TX0926U/8r7P19O7Mz8hW7XOqPgc0C+QH
 093ndtwDsAbQfweuqHeIl2DHBAlRvOZNVEpXj9Cl0FYjKzB4Rhz9D1u1S A==;
X-CSE-ConnectionGUID: NQjqYuTsT2mY/lHmv6i8Vw==
X-CSE-MsgGUID: BSi/XFXZT3O/1u/p4m2iww==
X-IronPort-AV: E=Sophos;i="6.25,252,1779120000"; d="scan'208";a="154586031"
Received: from mail-westus3azon11012028.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.28])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 31 Aug 2026 09:10:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmNAk8OCZBa/lUvulyHj2AiU1sJxMXgyn3GbF0eHyox7a0j3YVSKxzbcCsokW2BOehLUZRj2aJQW2Nd7HHE+SV49Gsc2vDlL7h4A1HkHOhKdLLw2zXWQupOWFtpaghZ3hNN6UhswjMDIbFdPHacyw6OyN3I1+d0UDVUjApX/vco4r9jV9WoJWkyg9C9GFqil0Py5xMLGmh/XvcbayFwa6dLuATxAonSdR9fyKH8dVojqJyx2LtRitABFfC6V48s3TO5qrdKUXecG3nSE7yNROB1FHRWiGBBO++LB8PPKNr8DXN+IYlq9HpBq3YsvJpABvM3CwrozSAt8TcKPzxW0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlilZyERMiqX+ABjoY4Uhg8/kWpePSXyoJ3+kREjuhY=;
 b=rhXHXNWJrj+X1oQPOQQAErmqrZo4qd9ZGk8bfTlwS2ReyiAPBJUQ6KVJj28YhGoeDQAr+PWBZm8pWclVwxSFiacPc9r3j4kCrjWvj++mY4Y95IKWOCDDI+IsFNpTTE2vamSag1WT81wgtUvHOnTNRm7L02K86EEz6FqAn+W7VyPklngeaX2tWPTNBoAzHuWTfQ7wQYFcrTiLMgAyavsPAQ9BmK/OlAEpimBO+4324Or0ndDTpDP9MvQk9pRy83vBqz4Hyt0hl8eaqS4BaPXcmRiaKinkQhTQDEpnelXPbOcB2AHU82hDhYkQyhR5mgLJnINKOKf4+MNMgEl0Fnwivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlilZyERMiqX+ABjoY4Uhg8/kWpePSXyoJ3+kREjuhY=;
 b=VQtEQmao6u5WovyjZ/lzsa+0h6nsUlk0bP0QoV9rgKhimRGLMnWSXw0HF7k8NeOgnmokTxgTrHI5xXu2e5MIea4EPciYwyFp5wlbPHb5grh324a0/Tktv2VmF1YtmErjOlp5Runy7Pawgh42aLhfsa4ozfkfygDLN5tux9xr8Vo=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV2PR04MB993975.namprd04.prod.outlook.com (2603:10b6:408:36c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 01:10:02 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 01:10:02 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "joel@jms.id.au"
 <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH 03/12] tests/tcg/riscv64: Boot semihost tests with -bios
 none -kernel
Thread-Topic: [PATCH 03/12] tests/tcg/riscv64: Boot semihost tests with -bios
 none -kernel
Thread-Index: AQHdNeJntczHelYpUEmhZFFKeGRdr7a3XyCA
Date: Mon, 31 Aug 2026 01:10:02 +0000
Message-ID: <3ad4cbb4ae32171e90e1f5edd4a8a3bef2f75465.camel@wdc.com>
References: <20260827050953.67184-1-joel@jms.id.au>
 <20260827050953.67184-4-joel@jms.id.au>
In-Reply-To: <20260827050953.67184-4-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV2PR04MB993975:EE_
x-ms-office365-filtering-correlation-id: f32222b1-5fcd-4169-618b-08df06fc95ba
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|23010399003|10070799003|376014|7416014|10067099003|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: oCU5tShq80ADBXKIXjUd7hPbd0RRPbihmgPe6kUnpUwdDO2KZFyCcxqiKJP04N02b5czYzhaUnZINFnBpVlynQviHCyDsNs1F6KC/PspIcElGkibabHnH6x3m2LgsXHE2+qfxh16Cdfa5inOoyel+YbZFh1Kc0rfOPUVIqKOR4t1yNVOUf/WfH8hL1WQRjuSRgyzakS5O7m+ua9jS6jSTfaKKMLeZ/ePa4CxM08FRdGWJXF6KYE10FOnwXbugGynv7vMswmSChVgPHrR4fS4P+kxdhk6rMXqRkNEZy/2wZUkjrbZedWuBNq+Y/2DKzFw9GzIV/+B1HYvy40XfMZBOjuINaEINxmCqU/X1xCGRKaS+Qds7oBqdy9PT1mV+VzVMRkebIskqWgaMUeCohuZBEuwDAiBXpr4t/VC/P9AD8dNoAmpFYsbrkJd7HiuVXWrKDU9ZKx0qcAuwi3OpyeNFGOtMq8mLyEFtg9p6E5rXoPXATUi/BN8trjQ7TGMNEh5vuJzJRADuBUpgriL7j+tG/SYxsd5pVMGyZ8jFQTHqnM6ck7kQhe1QNbFRq7oDCdcLVEE9CsE2IJtfwFJCIqJwQHIMXChsxqXSTztgGMcr/NVaB4Mmenrxdpf2Dw+RD/3JCCycN2D60+e00PxpO6tY7JRh35Ren+zdTwJ3lj1Q7dyy/C/lmqzH6Ht3OYYoEhOmYmAl+4+N6p5cmK2AFasopkMYpU13/58lbrN4SBXha8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(10070799003)(376014)(7416014)(10067099003)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFoVnZ3NzJYTlFkYStxd0RDUSt0RmtvUE83ODN2czRhdkNjNE9Hc0trbFZB?=
 =?utf-8?B?bkxLeGFCOFQ4R1ppRkZRSlBFeHFTSzNqRXhwdzZaTGw1ck9pRzVsVEJxSkxz?=
 =?utf-8?B?aWtaUnV0SWJNZVRnNEw0MzRhQ2ZhNkxnQzg1UU9CR24wSVRPTy9uclo4MkVJ?=
 =?utf-8?B?YWlHNGp4L0M0SWdScUI2ZUZlcXVxeGR2UUN0eGNKZnJNWVFDdzlobVZKeng2?=
 =?utf-8?B?K05FWjJQTSt0UDBQZmFPWVpRYmlhbVVwSEp0UHlKUHBuTmJ1di96VnNURk9B?=
 =?utf-8?B?Y2l1QitFc1lFVWhuWEc1bkRsTGdCNVpwT2xJR21wOEwrZnhtQkJRS1QySFdr?=
 =?utf-8?B?SGovU1hQeC9xZFlpVUpxdm5nR2dIZ01wTkZvTVNJNTk5RUFvK25GaFBRSVVj?=
 =?utf-8?B?d1V4Z3VLTTRja2cybkZ0RENKaHkyRmhMT0MrS2VxaXQ4Q3p6UUp5ZG5CY2lo?=
 =?utf-8?B?OVdkWFlWQnpxWFlsenlCRTR2MEZWUk1qamFNcW9vSTVFTHE5Ri9hTS8rbW55?=
 =?utf-8?B?VlMrKy9rZFl1SGtCczN4c09oR0pmL1BXY044UmxmZGM0QjA5R1VwZ0RRRmpm?=
 =?utf-8?B?STl4Wnp4VlJvUitnK2lSeFV0ZXRKWGNhNjl6SzBSWksvclozZzV3a3FXK09L?=
 =?utf-8?B?TVlzNXJhNGNsTU1DdUJsL2lXeVR6Tyt4QW1IOWQ1d0I1dHpVS3RjOG45c3RU?=
 =?utf-8?B?cFFSVEkvREZ0OCtwanFpeDVoOWFzMitaQTFpYkZYRWxEaGl0WGROSzFpd1Fj?=
 =?utf-8?B?RTFZT1V5ckdQcFNQYzE1eTJrdXI3dXhpM2pMdFJLbXZ2a1hoMEc3WGtHbmcw?=
 =?utf-8?B?bk5IYk41R1FYdjBxVWFHNWNZM0RCOVdhSlY1d2ZSdEJzTGZqVit4LzEra2lI?=
 =?utf-8?B?WVFuU1RjN2w0dXpzV2pOSzFHRHQ0YnVoWnJSZGF1K2w4clpQWnlmclJwb1Jh?=
 =?utf-8?B?TDdOamt4NE9YSHpCa1RhTWxzRUVpd2VQUEk3RjdYYzB4N096RDRJM05TdU5G?=
 =?utf-8?B?UUV6WmludHZqUElWOGZjaEFaSnVDQ2RVc2FkNXpYTzBwaVBORThVSXhYL2dP?=
 =?utf-8?B?MHBMUTdZZVdqcGdFTVpPZ2YyaHVXVS9xVU9hbnRmTWhYeWgyNUFyVkFFT3lO?=
 =?utf-8?B?cU8rdU9tUlhOSXRjRVBTdDc2aUQ5alp1UnpuUjRlYUdLYlYremNRSzh0MmdJ?=
 =?utf-8?B?UnlXTWZrb0lnMTJaMUFBc2l2b2c2YXNtTlFMU0pSUE03Y2dmMGJRSGRlRVAv?=
 =?utf-8?B?ckJYdnpLOEYvVFpvLzBMUUFNS2VobHZvMisrVW15SG9OeDUyazZXa2Z3R29k?=
 =?utf-8?B?aTJFc2xhR3UrSFJnU21Fc3U2bXVFTXMzVW1QRTlkdnJSMnh4K0hScDVXZjlD?=
 =?utf-8?B?aktxbm9CaTdHOVptRDJwREM5KzJxTzBDdnhKdmFOeE1salZEUHVUZExVQlVj?=
 =?utf-8?B?ei9Sb1k5bXk2dzNua2szQlYxQUFDTWIvdFU4YzFjRHJVMUhYQXEyMlU3WHds?=
 =?utf-8?B?dFd4MDh2eWZpdE5XbUxjWEJzWnpvZm5JUUxyUlUxZldVdi8reWlkZTFhVE8v?=
 =?utf-8?B?WXF3MzdzSC9FMzU1TUV4Vk5jSDg4dTZqaVNSRzR5bERsazV0MGt4VXN4azla?=
 =?utf-8?B?alF0Kzl1ZjRBM0dOd1dmcml3Y0xRcENvd001c3hNMk9Oelgxd2wyVHdhMVFE?=
 =?utf-8?B?bzNqNklNckY4akxIR0djbVV3Z21Xa1ZkNVZ0Q3AyUmdZSGFycU9OL0RZWnZ4?=
 =?utf-8?B?QlVtaFZEMzloTnFRZVJYZHhxSkhhODZ2QWdzdllKemxTUTFLc0JkMU51cXlF?=
 =?utf-8?B?U0U0VTVocTRiMHZiUlBuU1d3TVBvYk04ZWtMVEVWSHBTMER2QjdNOHBjYmRt?=
 =?utf-8?B?c0gzdU9FV3c4YVVFcmsvMUFGbXJTVWtRYmdkQVhYblV5ZE9WVXlFUG55Nk9B?=
 =?utf-8?B?S2l1U1lUWWh1SHBzQVFjVndONFNUSWhNMG1kMkxXUUVoSDlSRDdNNVN1aUxz?=
 =?utf-8?B?dURXYmNYeE1pNXp5NnRVOUU1b1JKK1EzWFdQQXhYS2ZtelBCY0Rrc3YzN0VT?=
 =?utf-8?B?MlpBUVRtUDF5R2FDeDdJZEJHTTl2K0ppVUxNUVFaM3MwalRBUWIzb282TTZH?=
 =?utf-8?B?eHBaeHlqSzFMeGJhSFNReHRNeCtWT240Z2lWV2lQNmFOTmNpNUVzc2JqeUhH?=
 =?utf-8?B?UWZNQ3gwb0UzeUc4cjJLbXdKV0ZrNldQWmFTajNBL2RBa0pFS1BkODR6ZjUx?=
 =?utf-8?B?VVZCaG1sZU84YS95aENXWTdsdVVkL2trOGNGSEJBVWxPUnkzVTNEYUtaUXhH?=
 =?utf-8?B?YjNxaFZYQjJvRE0xUmVxNkprTVNnUjA3SWVWY21kNWlCSVM1NThLV1AwaXA5?=
 =?utf-8?Q?iN2gHfMvYxycsBZsYZ7L2bDrLOBAm5tJ309/QkZfVGXFS?=
x-ms-exchange-antispam-messagedata-1: 0THJ+ZJVfrd+1X6nf3H3uPmCx0XO1k/vB+I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6ABD841927E0943833BD861DC20B2E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qE5tskfrFXtehz8ZdeiLsi36aZnFW5dz6YMsDHhb0eH3FvB9+d6DPdfBs9tSAaZwIZTq8VDuNZZLiR0I+KyWo6dJOuwGtFhrHi/mqN3qLV4I8UaMFpKMDrvi0pzzRMRYNfjOlhmHR4g3hP9XE6i4rVamz9JTDyd3WrKp96GogWpcnZfvWsqmMsmJYEYaZAjtv8M0GQSDsL25QC494myG0DIczmh/VzHXoVX3xjYFha9/v6w5Qc/YPf4pe3l5NTgPYKZlCYihYLJ4ra5LG+LXWBSh/tOBNxnuktnl3JXr9xbYjoVYXYh8vbtRYh5ZQmComJnrcJFfC7HFs3dh8vCmKw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NIeIFl1cRZcqWpNA9Y/b033ug6ht/4JgsWF6WdNLuYNqkzAdT+l76LYGrfz146SkG9cTPuMHC7yNpgdk9HoSdqRByF5Ld/roCn3zfV5dTw8JWFDUdjLxQ8lE1VdGIid61c6AwsMnXgER62Nc7z9MF+gKHJF/3OJcavY3JHzwJvHWUn2LfNlTi9knTjqZwtO8hxysbdMAyw6hLHdL+gLtd8lBX8Sw50XEjVamh8py5mjYDdHO9/FCXfgmGcwAfY7Y2foGAHRWhsXlfJRiCEHL8kpH6q41KdWDSDQtDyb4NeJd1xt2wSQTRBQwUQx+CQl2Fsh4x5b51tJ8F9PdbiLp3iXPxfl+LexNjm78ORwFXsMPK2iLXMVFtgJMNdmEDJ8uXRptGPThOkndCYQXMJyq8Uc3lEmFpLatC2f6ABREwXJLzk0xXETMczEahByWWY286GlUA8O4KN1AO1NVenB7tPtUPpEjsZNLTsCvLBG8l42gF3s+dZKrPQgbUU60h9xKcVvAfsBZwTa9bhUZ+CCtx/qY3NgPtrLtu9lBnD+Zf47HRSgt7Yujm1x/Z/9ECWRFEYgD4kQpTBdVYTBga7EfhLILFHcPWTI1bW1w9BMtukbmGIVLC/p4CQfisMS7Dvkm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32222b1-5fcd-4169-618b-08df06fc95ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 01:10:02.3052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLTE/LAzJ75VdqQcTQ8sm8k0EBCpGjC5BqFrABrAFPT6H7Icvg48QrnvTcw5td9zKqH9MU/XCwxu33mkexbMI8NgUotgcvznon/wBBGFNaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB993975
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=696fae14a=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTA4LTI3IGF0IDE0OjM5ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IExvYWRpbmcgdGVzdHMgc2hvdWxkIGNvbmZsaWN0IHdpdGggdGhlIG9wZW5zYmkgUk9NLCBob3dl
dmVyIHRoZQ0KPiBnZW5lcmljDQo+IGxvYWRlciB3cml0ZXMgdGhyb3VnaCB0aGUgQ1BVIGFkZHJl
c3Mgc3BhY2Ugd2hpY2ggYnlwYXNzZXMgdGhlIFJPTQ0KPiBvdmVybGFwIGNoZWNrLg0KPiANCj4g
SW5zdGVhZCBvZiBkZXBlbmRpbmcgb24gdGhpcyBoYXBweSBhY2NpZGVudCwgc2V0IC1iaW9zIG5v
bmUgdG8gc2tpcA0KPiBsb2FkaW5nIG9wZW5zYmkuIFRoaXMgZnJlZXMgdXAgdGhlIGFkZHJlc3Mg
c3BhY2UgdG8gbG9hZCB0aGUgdGVzdA0KPiB3aXRoDQo+IC1rZXJuZWwsIHJlcXVpcmVkIGJ5IGEg
ZnV0dXJlIGNoYW5nZSB0aGF0IHVzZXMgdGhlIHNhbWUgcnVsZXMgdG8gcnVuDQo+IHRoZQ0KPiBt
dWx0aWFyY2ggdGVzdHMgZm9yIHJpc2N2NjQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2VsIFN0
YW5sZXkgPGpvZWxAam1zLmlkLmF1Pg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3Rz
L3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IHwgMTggKysrKysrKysrLS0tLS0t
LS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRh
cmdldA0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGlu
ZGV4IDZhMjE5YzMwNmM0My4uNTYyYWM5YjBlMGZiIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy90Y2cv
cmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2
NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0KPiBAQCAtMTQsMzYgKzE0LDM2IEBAIENGTEFHUyAr
PSAtZyAtT2cNCj4gwqAlOiAlLm8gJChMSU5LX1NDUklQVCkNCj4gwqAJJChMRCkgJChMREZMQUdT
KSAkPCAtbyAkQA0KPiDCoA0KPiAtUUVNVV9PUFRTICs9IC1NIHZpcnQgLWRpc3BsYXkgbm9uZSAt
c2VtaWhvc3RpbmcgLWRldmljZSBsb2FkZXIsZmlsZT0NCj4gK1FFTVVfT1BUUyArPSAtTSB2aXJ0
IC1kaXNwbGF5IG5vbmUgLWJpb3Mgbm9uZSAtc2VtaWhvc3RpbmcgLWtlcm5lbA0KPiDCoA0KPiDC
oEVYVFJBX1JVTlMgKz0gcnVuLWlzc3VlMTA2MA0KPiDCoHJ1bi1pc3N1ZTEwNjA6IGlzc3VlMTA2
MA0KPiAtCSQoY2FsbCBydW4tdGVzdCwgJDwsICQoUUVNVSkgJChRRU1VX09QVFMpJDwpDQo+ICsJ
JChjYWxsIHJ1bi10ZXN0LCAkPCwgJChRRU1VKSAkKFFFTVVfT1BUUykgJDwpDQo+IMKgDQo+IMKg
RVhUUkFfUlVOUyArPSBydW4tdGVzdC1tZXBjLW1hc2tpbmcNCj4gwqBydW4tdGVzdC1tZXBjLW1h
c2tpbmc6IHRlc3QtbWVwYy1tYXNraW5nDQo+IC0JJChjYWxsIHJ1bi10ZXN0LCAkPCwgJChRRU1V
KSAkKFFFTVVfT1BUUykkPCkNCj4gKwkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpICQoUUVN
VV9PUFRTKSAkPCkNCj4gwqANCj4gwqBFWFRSQV9SVU5TICs9IHJ1bi10ZXN0LW1pbnN0cmV0LWVj
YWxsDQo+IMKgcnVuLXRlc3QtbWluc3RyZXQtZWNhbGw6IHRlc3QtbWluc3RyZXQtZWNhbGwNCj4g
LQkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpIC1pY291bnQgc2hpZnQ9MSAkKFFFTVVfT1BU
UykkPCkNCj4gKwkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpIC1pY291bnQgc2hpZnQ9MSAk
KFFFTVVfT1BUUykNCj4gJDwpDQo+IMKgDQo+IMKgRVhUUkFfUlVOUyArPSBydW4tcGx1Z2luLWRv
dWJsZXRyYXANCj4gwqBydW4tcGx1Z2luLWRvdWJsZXRyYXA6IGRvdWJsZXRyYXANCj4gwqAJJChj
YWxsIHJ1bi10ZXN0LCAkPCwgXA0KPiDCoAnCoCAkKFFFTVUpIC1wbHVnaW4gLi4vcGx1Z2lucy9s
aWJkaXNjb25zLnNvIC1kIHBsdWdpbiAtRA0KPiAkPC5wb3V0IFwNCj4gLQnCoCAkKFFFTVVfT1BU
UykkPCkNCj4gKwnCoCAkKFFFTVVfT1BUUykgJDwpDQo+IMKgDQo+IMKgRVhUUkFfUlVOUyArPSBy
dW4tcGx1Z2luLWludGVycnVwdGVkbWVtb3J5DQo+IMKgcnVuLXBsdWdpbi1pbnRlcnJ1cHRlZG1l
bW9yeTogaW50ZXJydXB0ZWRtZW1vcnkNCj4gwqAJJChjYWxsIHJ1bi10ZXN0LCAkPCwgXA0KPiDC
oAnCoCAkKFFFTVUpIC1wbHVnaW4gLi4vcGx1Z2lucy9saWJkaXNjb25zLnNvIC1kIHBsdWdpbiAt
RA0KPiAkPC5wb3V0IFwNCj4gLQnCoCAkKFFFTVVfT1BUUykkPCkNCj4gKwnCoCAkKFFFTVVfT1BU
UykgJDwpDQo+IMKgDQo+IMKgRVhUUkFfUlVOUyArPSBydW4tdGVzdC1jcmMzMg0KPiDCoGNvbW1h
Oj0gLA0KPiDCoHJ1bi10ZXN0LWNyYzMyOiB0ZXN0LWNyYzMyDQo+IC0JJChjYWxsIHJ1bi10ZXN0
LCAkPCwgJChRRU1VKSAtY3B1IHJ2NjQkKGNvbW1hKXhscmJyPXRydWUNCj4gJChRRU1VX09QVFMp
JDwpDQo+ICsJJChjYWxsIHJ1bi10ZXN0LCAkPCwgJChRRU1VKSAtY3B1IHJ2NjQkKGNvbW1hKXhs
cmJyPXRydWUNCj4gJChRRU1VX09QVFMpICQ8KQ0KPiDCoA0KPiDCoCMgWmljY2xzbTogbWlzYWxp
Z25lZCBsb2FkL3N0b3JlIHN1cHBvcnQuIEFzc2VtYmxlIG9uZSBzb3VyY2UgdHdpY2U6DQo+IHRo
ZQ0KPiDCoCMgZGVmYXVsdCBidWlsZCBleHBlY3RzIGV2ZXJ5IG1pc2FsaWduZWQgYWNjZXNzIHRv
IHN1Y2NlZWQNCj4gKHppY2Nsc209dHJ1ZSksDQo+IEBAIC02MSwxMSArNjEsMTEgQEAgdGVzdC16
aWNjbHNtLW9mZjogdGVzdC16aWNjbHNtLlMgJChMSU5LX1NDUklQVCkNCj4gwqANCj4gwqBFWFRS
QV9SVU5TICs9IHJ1bi10ZXN0LXppY2Nsc20NCj4gwqBydW4tdGVzdC16aWNjbHNtOiB0ZXN0LXpp
Y2Nsc20NCj4gLQkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpIC1jcHUNCj4gcnY2NCQoY29t
bWEpdj10cnVlJChjb21tYSl6Zmg9dHJ1ZSQoY29tbWEpemljY2xzbT10cnVlDQo+ICQoUUVNVV9P
UFRTKSQ8KQ0KPiArCSQoY2FsbCBydW4tdGVzdCwgJDwsICQoUUVNVSkgLWNwdQ0KPiBydjY0JChj
b21tYSl2PXRydWUkKGNvbW1hKXpmaD10cnVlJChjb21tYSl6aWNjbHNtPXRydWUgJChRRU1VX09Q
VFMpDQo+ICQ8KQ0KPiDCoA0KPiDCoEVYVFJBX1JVTlMgKz0gcnVuLXRlc3QtemljY2xzbS1vZmYN
Cj4gwqBydW4tdGVzdC16aWNjbHNtLW9mZjogdGVzdC16aWNjbHNtLW9mZg0KPiAtCSQoY2FsbCBy
dW4tdGVzdCwgJDwsICQoUUVNVSkgLWNwdQ0KPiBydjY0JChjb21tYSl2PXRydWUkKGNvbW1hKXpm
aD10cnVlJChjb21tYSl6aWNjbHNtPWZhbHNlDQo+ICQoUUVNVV9PUFRTKSQ8KQ0KPiArCSQoY2Fs
bCBydW4tdGVzdCwgJDwsICQoUUVNVSkgLWNwdQ0KPiBydjY0JChjb21tYSl2PXRydWUkKGNvbW1h
KXpmaD10cnVlJChjb21tYSl6aWNjbHNtPWZhbHNlICQoUUVNVV9PUFRTKQ0KPiAkPCkNCj4gwqAN
Cj4gwqBFWFRSQV9SVU5TICs9IHJ1bi10ZXN0LW1pc2Etdw0KPiDCoHJ1bi10ZXN0LW1pc2Etdzog
dGVzdC1taXNhLXcNCg==

