Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97348CA1016
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 01:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvmye-0006wa-EV; Mon, 08 Sep 2025 21:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvmyc-0006vx-Qy; Mon, 08 Sep 2025 21:16:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=340207e43=wilfred.mallawa@wdc.com>)
 id 1uvmyY-0004tA-3e; Mon, 08 Sep 2025 21:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1757380609; x=1788916609;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=P1FHL3SAGPqCfIVzI7S87veqktnTjSXi7SFYrLbo0Rw=;
 b=bYnv84EQahrdbByiFK5HRwOqFOv8stZnSNUu1b+axmovGXfCeOxkf79c
 s5JxqbxJani46L67UJupYML7b3qg3FkacbQtKN7EAPg1W02TLAhXRaH97
 9nd5kaLO8/PsXwkJSFYzoWyy2ywWgsfyfkw4gds3A6fcVLHWUHodpN2KJ
 77kQwIl8ED98rRPwsTzA2n8tpnCdd0KZeDs7U3fy0o+tKMjpHwxKJK41w
 TIoUchlsIWy/F/Wo/NBP1gG77eQkRNWVSCgggGoL+7o98labGtuJv3mat
 +dIBpX/0dLeaX8bWRZcnXx0CYogixClIDe2zA2Vp5BJl50u0PugqLjNvp Q==;
X-CSE-ConnectionGUID: Ri8lC4HsSAuYVis4oIWBfw==
X-CSE-MsgGUID: M6/3OyxYSI28bn0iCO9HIQ==
X-IronPort-AV: E=Sophos;i="6.18,250,1751212800"; d="scan'208";a="112593283"
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.57])
 by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2025 09:16:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff3d6S2Ii0Vv8oZcuY3eTFGRVcA70AlQeUyuaUEYMPXBriqDlPuqc9ctQhg8I5F8xTrxqN/SYwJ4zhOcSlgy1iPRHgAd1ZWo+b5F6wxWSSaZ00jbZYRZ/FeaSwGGA9G8mHHBZ3SUb2OtWZwY/ruVscfdpGSnkdTccNSKRLquxn7ySXLRYJecHuXdGhnI1opCmvATaAz4H1VIrWOILJrJptKCxkn0eBg/m5TV/hMoiuzuHj5XeUqArrrWDHgvqW1K3s8tjc0M3qCJycLvNMhlBem2bs2UkeXMG5AxSW4WX5Bii6bbKlYIvHwdrpZc8GsNFXu7OzSbCQUag97Qxbos2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1FHL3SAGPqCfIVzI7S87veqktnTjSXi7SFYrLbo0Rw=;
 b=yUdpKMf1qhIhuUx3EHp3nceLGrOPaGJZhFE5HB0vavPiIaQ+dQYuoixUB0tbUQGkT+TbZL6KA3hYAC1QbJ9tbi/DczzXid2SQ6/w9Nvx0TscWlfo7Pt5gIgcowroUA+aRJ9B9/GzkXSY5Qryp7Es3rs3llC2F2LgfIn84IdYsdv8/LOp1MW9VVcE2FP/K5gJtMMzmeroFFM7TRPtJmbgvqUXQ/MWJ6Erl6bRLEtebaN4wtHCF4pzZTFMbFrL5cESXlfGpXWnxZRNrDuWJz5XpLpO9Y3jZCp/tD0gqbL1LlNux44RK7+H2J4+hkRpt4a4G8inx5BxZnXN4JX79DT+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1FHL3SAGPqCfIVzI7S87veqktnTjSXi7SFYrLbo0Rw=;
 b=ksC/EKj0zS/9IiP+s7OVcgpi97pzfM3Y2qgV8n2IXRR8xu5r7IYD/VwurHQqcs60X3Sn9e8AnwkA3lOfaMqQoEHPf7GvQGHJaelC7EnI5ga2Rk7FdNZ5bVe9GVZtEuKwMwYGpnzde42ZWBvxRIFUn2FCaKu4EPpTD1NUYGAA4l4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by CH2PR04MB6967.namprd04.prod.outlook.com (2603:10b6:610:97::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 01:16:43 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Tue, 9 Sep 2025
 01:16:43 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
CC: "its@irrelevant.dk" <its@irrelevant.dk>, "hreitz@redhat.com"
 <hreitz@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "stefanha@redhat.com"
 <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "foss@defmacro.it"
 <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dlemoal@kernel.org" <dlemoal@kernel.org>
Subject: Re: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Thread-Topic: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Thread-Index: AQHcHUm+agRvvjJkqECFgpvYbmPGGLSC0PKAgAdDRwA=
Date: Tue, 9 Sep 2025 01:16:43 +0000
Message-ID: <0242ecdeeeedc69689d71dd76d01459e191670f0.camel@wdc.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-5-wilfred.opensource@gmail.com>
 <20250904112205.00007e47@huawei.com>
In-Reply-To: <20250904112205.00007e47@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|CH2PR04MB6967:EE_
x-ms-office365-filtering-correlation-id: a7c95be1-0b49-4dff-2fd9-08ddef3e89c9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?L0R0WEI5TDF5RU4xZTZXZXRaRVIybDhZUlEwYTF0SzUwSW1iSmE3WUNZSE1s?=
 =?utf-8?B?RHFTUWV3ZXRpU2NCeW5JSTdFcmJPdElqUzVYK3pqWnQxM3hkSHlDMlpTQm82?=
 =?utf-8?B?NW9QSWs2WkdPZTFVemh5WnM3K2RySjhWVGxTSEZleEpaTnZwMFNJKzBkTG9C?=
 =?utf-8?B?eGx4RytzUUlGYnFPbjk4anJhTFlaWWp6eG9FTi9FTWdzVzZBSWRzR0JuRzZF?=
 =?utf-8?B?eDhrOW5MWTJkV1VTb0dHRmNlN2lyNTJGdDFZVjBydXNCdUgwVkYrNWJEM2JU?=
 =?utf-8?B?QVVma0hFbTljY1lYQUowYk53b2F2V3NTQU1HbGVvWHNtY1JaUzk0VkhRUzB4?=
 =?utf-8?B?SmZvdS9ERTVXM1BWQlJQdk1yWEtNZkdydmIrUUU4WkF1RHNoOGExYzJIYytu?=
 =?utf-8?B?OHZHS0R4VTdMd2k4UW5FemFwbUdaanFiQjRzcHh1SEVQcjEzWjZFR1BsN05x?=
 =?utf-8?B?amwyeGIrOUhwd09CWlI5U3ZCRHNBY0g3bHJoV1IzWjEyVkpkeExpb3hjanBP?=
 =?utf-8?B?eDFvTmUvdkp6cEVzcEJtcEFrTnFLRDdhbUlBV3hGeUdDcEpzaEpXTm5VaWhy?=
 =?utf-8?B?RDlKQjExNGxxWVJNWm0vN0xST2FiTkxnaS9xMFY4TDN6SUh1SzdSZk52d3ZZ?=
 =?utf-8?B?ZERuV0NWWW03VFlMT3dBV3I1am44MlQ2MU5Obk8wcEpWM281M3ljeS9MUmdq?=
 =?utf-8?B?VWhYblZuSFhzRTJGaXhKUXoxZUIyelhNRlRmYzQ0VjFMTDVZMU45NXFtclRW?=
 =?utf-8?B?dEhJYXEvQ1VPZmpDVGF6RHZCWStER2FwcVdBN1lJU2gyelcvK2VPbDc1d0JN?=
 =?utf-8?B?UTRxbHhJWjNjdENmSHRFWUZGWHZrODZMbTFSVlprZWlpZ0JpcnZHSlg0YjNk?=
 =?utf-8?B?Vll4NFp3cW1rMlJjdC96TlRPbkIycURkcHl5Rlo0Um5CbXlzOERSSGU3aXVU?=
 =?utf-8?B?YWJxQlYrODZLK0I0R2liZjY4Mk9pbmk1K1J5aXNKakl6cTFwRkZJalpvNm9s?=
 =?utf-8?B?bFlOWkVoczFVY0E4QzZnUmZHOGZkZXJwTG5xL09pUVZPMHlNTGM2Tk9LUU9w?=
 =?utf-8?B?ZmMwSG5sbEprb1oyRVVLV204aWZ1YnVxaVR1VFJjaFowV1hlM0tJeklRNFcv?=
 =?utf-8?B?TXhzenRrNlZMZkp1RittZ0ZXc2VOYjRSdTdlUUNDRXBRREZNWWQ2YUtPU2dF?=
 =?utf-8?B?UXg3R1BDYnJCczhWRmVnVGZYWWdQd0NsNFhKd2dnZmlPeGlWNWgrUHd2RWph?=
 =?utf-8?B?eEMwUy9pVHFBa1FOMHpmSzNEa3UvcFdyYXZCYUJqY0VlRjNWejVTZUZGaDVw?=
 =?utf-8?B?TXd4c3psUHJNbVRNNm5hT0hnbm10SkZHa0FVQ3VPWmx6cmtESHlFWU53aDY0?=
 =?utf-8?B?TEFpdW5hZFBBbUN6cndoTFMwc3RQRW5CWkJvR1hmL2I5Y0F5OFJib1Y3M3A4?=
 =?utf-8?B?OGEyQU1yaHIxbW51T2p2eW5lR3FKY3RYaGxka0J3K255azdsWWh6dFhQQXND?=
 =?utf-8?B?YzZ3ZzdpNHd4c0RhTjRDZVlMek9vTVFIR1JuSEsxaXNPb0tzR1dVSHZMckdV?=
 =?utf-8?B?VEhrRHI2eDNTZnhGaWxTeDNURW5LM1F6U0E2MXJPNHNFaWZ6NnpoT3R1ZC9u?=
 =?utf-8?B?MTRURytReTBvS1JvNHlvOVVkMEhBNDNGYVNSeXhKSzBlNzcyb2hweW5qOTNU?=
 =?utf-8?B?SWlEazVrTGJHYTJlQTROdTJBUHZBalRiVkE0UWlVR2lPUnF1QTkyTHptYWo1?=
 =?utf-8?B?Wm5xWFJ3ZWxCRDFseWo3OSs5blY2VktXTHAvbHE5Nk5DY3o4TDhoOVBYODlm?=
 =?utf-8?B?ZkpJY0ROMkVPKzUvMnlqVTNYUlh4cldNWFU4bmxYd1EwcFh6WHVZYWdzSGpl?=
 =?utf-8?B?cXFvaVVzQzFnUUc0ZUdqb0VnblJHdzduUGJmRW5zOHdaUi92cVIzbDZvN2xZ?=
 =?utf-8?B?S0dqbEVwRklpbk1ETEZTRjdlVUQxb08rL29tUi9oR1lTN2tpa0VZakVlVTdl?=
 =?utf-8?Q?/9bZSLJdDAxxQfzy77BRHN0UHmFSS4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0JUc2JVZzBKMjVWdEozN3FpTjE5NjFabVB1aGtKdDlxdVJpUmkvbGZzenRp?=
 =?utf-8?B?QVE4WERIT3o1L1R6UlkxVEJtU0Z3Yk5JUXBuUWlUckk3SDlTMCtSclE5c29i?=
 =?utf-8?B?OUZNdEp5MjNDek9nd3RRdTJKRklPV1hVWjArT3hpS1Znbm1KQWlUd1FiT1dR?=
 =?utf-8?B?S1FxY1E4elZOWHhyajZOZHBFODFhSE5Za0VOK3dzQTZwc21yVktXbisvTFk4?=
 =?utf-8?B?UWFWKzExTGtLcDB5UmlqRW9OZzZ4SlMrT28xVlNtRnRldjE3NmMrSUJaaGtP?=
 =?utf-8?B?aklkUllscmhJRWFaa3Fzd1BZWUFLL1hRdVQ0ckNwTW04RkhzODY3aWZ3NCt1?=
 =?utf-8?B?SFV0Q0dFZTRhWFdHTzY0bUlnOFIwT3FhQi9PU3Y3MGl6MnVMT3pWaVRFdTZ4?=
 =?utf-8?B?SEVKQndIN3B5cTJSdjBXcHV0WnJjYnMxY0xIbnMvdThoODg4a0hSdmpUWkIv?=
 =?utf-8?B?VE5uODgyZWpsUDZKWGptMiswQ0lMcy9RWi9lSDAxM2lLVUNLQy8wWmNTS3NS?=
 =?utf-8?B?RlRwdjh5ejEzVHhhWWNvdy93SHpLaElGbjJlTVhBTmt6QlFOMFlYSUE0NkFy?=
 =?utf-8?B?T0JKYnRXUUpQZlArTVhXTUpxVGZ4ZC9vS2tIVWRaaG12VVFqRWRBRk9valFP?=
 =?utf-8?B?elNqSmtyNlE1cjNuVnRaVmtzRE9IMTAxRXBPemc3Y010ZGNxMVRKOERxVStV?=
 =?utf-8?B?UDc4bk45U0V5T2JLeWNHMi9NSkJXV3VCQlkrNm9ZTTdvZWtLUmhnYWdPbml0?=
 =?utf-8?B?TjU2N0RLYjBBT0RScWU1T1k3d3dsaW05VlFxS2phbE5DUTlPaUR3b08vOTYz?=
 =?utf-8?B?bC9DSThsV2UrazJNZ1JLMitmT0NMOFVEYXViT2hVWEdmajQyVzRNQzlTTXJl?=
 =?utf-8?B?ZmVVYmZDcExxMHd1K0JGUXJ6d1hTMmJmL3JHMFBTRnhIbG8wbDVmejJpV3Zr?=
 =?utf-8?B?ZktPQTk0RldpbmJrU0ZtNHJQUVh4TVlEUkNJT3JpVzRiVUJFdXRwcFZHaXlM?=
 =?utf-8?B?dXpsL0s3U2NvUmdxUlBybEVjenJ3Yjl4cEVUS1hoWGV6Zk9ZN1RHUy9RWjVL?=
 =?utf-8?B?TXhjV2l2MS9iTnNCTDlsVi9ONTVWektYa052T24wTEUrZHpXejZMRExwL0lQ?=
 =?utf-8?B?OTgwMFFVNWtQZU10WWpMNFlsc0hzTlZpY05lVnFMOGpzSFNrWUpBc09IRnZQ?=
 =?utf-8?B?aTREWmQrS1dYdkw2dTNFOHJMUFpudkJDZUdmUDA3MXN2WWF2MnhlTi9yUVRB?=
 =?utf-8?B?OUdXeXYxdFNvZm5Ba3pWdzcvZ29MSnVMOVdkdnMraldkZGs2V0ROWjNUSVov?=
 =?utf-8?B?cnRVbGpmQjRnQTlUa3NrL3NKVGZJT1FjdHNTL0xFMWcwTzlYTFcxdEtvR3Ex?=
 =?utf-8?B?SWw3M2lrWTdBY2VmZFZYQ05JQnp6cnVNL1VWWjBZOXFDcEhYbEJIbzlvelhU?=
 =?utf-8?B?Vm9JK0pGRkQwRnVuZ21xd05BVmY4QmpNbjdzVHRqcFNZMmJiOVRzMEU2bFNH?=
 =?utf-8?B?N0wzNXlRWnU3SFd6aDhXdndnRU91K053aXl2R3BwY1NRcVpwNFZpL3Q3NVdG?=
 =?utf-8?B?V1MyTkhaSTFOWE1ITTYxUENDTDFxcW5sblRSQjUrM0txb29QeEVKTUJzQUpi?=
 =?utf-8?B?SlQraVJpSTVaR25BUVUwMlY0KzNqeXBRRHM2cytna1M3RUtDUW83eW90dEtx?=
 =?utf-8?B?b004ZXdVVHk5bkk5RG5iOHdXR0lIVm1RWkgyUmJOMUNhVUJrTXprbDliVUJU?=
 =?utf-8?B?elZNbmsyaHByczZUUDdIRDdZMnNnUUtSRzljUXo1dG55NGV1cUVKYXp2Z01O?=
 =?utf-8?B?R21ndmVuTVZGQTdkWXl5KzdzdHVXYjlQZTVBK2Y1bmQvZTFWZ3BNN3hnSEhU?=
 =?utf-8?B?MGlyd0MzdjlyMzlWYnNDbFVWcG5kZjNoWTNQYjh3NVlhSkxwRDNaTnBYYUN1?=
 =?utf-8?B?QThSeXAyR0lQTjFSTzBPUm1NeDNQQ2E0TE9oWWxYNTk5czJlRW9Bb3JjL05Z?=
 =?utf-8?B?N3pIS3ljZUtqb28ySVJFNytWRTFyNWlxT2RzaXNMTkM3bU45MmlnMGNPMVRl?=
 =?utf-8?B?VWVkQWxHb3BHV3dHSkU1eG5nTk1MLzIrWEVFRTNKa2hxa2dlUHNGMFdzVmd2?=
 =?utf-8?B?NXVaUEdZbEo2UmtKOWNUbU96T0ZSMGU1SlJ3VzZPK05nVnJIVHNzYi92VXZO?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <591EB8FCB2ACD045B4A390F566D0B7E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Wau0RZp5NL7JPxP2hA2MV5BLDVELjdvkiNaatYXIiCvH9HYlbWc7JKchPYDsJkZHHappM/UxAAGsIiYAan/IwT1/O1uyxDd4H19XdoTqMS4MDLSGtGCuGoHQEY5tAGf0z+ipD9Vd7VBVrSQFq86YvYAPdFFeF9cql0zrUuTiT+wkwgafN7f2bTYRkXAZxO0lUXj62tg5RQVqCjLt42DH8F9b3p8OlVFocCAwT9PWDxSc1bZTZhC3+0DJYh7Xly7dXFKuixrdBU1i87Pa0Ecjwn/rO5vb5auDWPl7VY/NJ1jsWpkWxMWG+UYk6Am2JAcdfrafVNW+NuUzMYo4wVBoeqPh1ZNnoXzoOJedU0Q+YU0fsgbkm0ce5txc1rIk9T3ySynD7OUFzPCDzRmdmn53VGWfE4MI2qyqrfAXrTV7vyQ3kFlE2usJSuZiNSS1yGTXSx4EvS8fefRzkJwW9x7Nr9fZeEO4VAI904Z042KJ+o0HIQ0WoID23bC6bKmWwk6QbEbE3EMZ6pGpPO/9JMGGBkqeI7bpBOF3TL5J2pkJMuAPgnzZr0gHFgpUeZQozwT9xrhtjaJShez6SML2WUbAoqpMQ94s5xpyrZ2ipVo4nX6yfVFwEAAPfo4dpJiLj/k6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c95be1-0b49-4dff-2fd9-08ddef3e89c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 01:16:43.4867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38CuWkdUV7RlAc0lOT5b6X2DjRy7aBJSZsH04+5VLIsS4m2FjZVcFdU5FTn7oWWnwaOFaVNOzNUiedCY4MfPRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6967
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=340207e43=wilfred.mallawa@wdc.com; helo=esa1.hgst.iphmx.com
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

T24gVGh1LCAyMDI1LTA5LTA0IGF0IDExOjIyICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUswqAgNCBTZXAgMjAyNSAxMzoxMDo1NyArMTAwMA0KPiBXaWxmcmVkIE1hbGxh
d2EgPHdpbGZyZWQub3BlbnNvdXJjZUBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBX
aWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiA+IA0KPiA+IEFkZHMg
dGhlIE5WTWUgQWRtaW4gU2VjdXJpdHkgU2VuZC9SZWNlaXZlIGNvbW1hbmQgc3VwcG9ydCB3aXRo
DQo+ID4gc3VwcG9ydA0KPiA+IGZvciBETVRGcyBTUERNLiBUaGUgdHJhbnNwb3J0IGJpbmRpbmcg
Zm9yIFNQRE0gaXMgZGVmaW5lZCBpbiB0aGUNCj4gPiBETVRGIERTUDAyODYuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4N
Cj4gSGkgV2lsZnJlZCwgDQo+IA0KPiBJIGhhdmVuJ3QgZXZlbiBvcGVuZWQgdGhlIG52bWUgc3Bl
YyBvbiBiYXNpcyBvdGhlcnMgYXJlIGNvdmVyaW5nIHRoYXQNCj4gcGFydCB3ZWxsLiBTbyB0aGlz
IGlzIGp1c3QgYSByZXZpZXcgYmFzZWQgb24gdGhlIGNvZGUgaW4gdGhpcyBwYXRjaA0KPiBzbyBt
b3N0bHkgc3R5bGUgc3R1ZmYuDQo+IA0KPiBKb25hdGhhbg0KPiANCkhleSBKb25hdGhhbiwNCg0K
U291bmRzIGdvb2QhIFRoYW5rcyBmb3IgdGhlIHJldmlldy4gQ29tbWVudHMgaW5saW5lLg0KDQpS
ZWdhcmRzLA0KV2lsZnJlZA0KPiA+IC0tLQ0KPiA+IMKgaHcvbnZtZS9jdHJsLmPCoMKgwqDCoMKg
wqAgfCAyMTMNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ID4gwqBody9udm1lL252bWUuaMKgwqDCoMKgwqDCoCB8wqDCoCA1ICsNCj4gPiDCoGluY2x1
ZGUvYmxvY2svbnZtZS5oIHzCoCAxNSArKysNCj4gPiDCoDMgZmlsZXMgY2hhbmdlZCwgMjMyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaHcvbnZt
ZS9jdHJsLmMgYi9ody9udm1lL2N0cmwuYw0KPiA+IGluZGV4IGY1ZWU2YmYyNjAuLmRmNzI1OTli
Y2MgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbnZtZS9jdHJsLmMNCj4gPiArKysgYi9ody9udm1lL2N0
cmwuYw0KPiA+IEBAIC0yODIsNiArMjgyLDggQEAgc3RhdGljIGNvbnN0IHVpbnQzMl90IG52bWVf
Y3NlX2Fjc19kZWZhdWx0WzI1Nl0NCj4gPiA9IHsNCj4gPiDCoMKgwqDCoCBbTlZNRV9BRE1fQ01E
X0ZPUk1BVF9OVk1dwqDCoMKgwqDCoMKgID0gTlZNRV9DTURfRUZGX0NTVVBQIHwNCj4gPiBOVk1F
X0NNRF9FRkZfTEJDQywNCj4gPiDCoMKgwqDCoCBbTlZNRV9BRE1fQ01EX0RJUkVDVElWRV9SRUNW
XcKgwqAgPSBOVk1FX0NNRF9FRkZfQ1NVUFAsDQo+ID4gwqDCoMKgwqAgW05WTUVfQURNX0NNRF9E
SVJFQ1RJVkVfU0VORF3CoMKgID0gTlZNRV9DTURfRUZGX0NTVVBQLA0KPiA+ICvCoMKgwqAgW05W
TUVfQURNX0NNRF9TRUNVUklUWV9TRU5EXcKgwqAgPSBOVk1FX0NNRF9FRkZfQ1NVUFAsDQo+ID4g
K8KgwqDCoCBbTlZNRV9BRE1fQ01EX1NFQ1VSSVRZX1JFQ1ZdwqDCoCA9IE5WTUVfQ01EX0VGRl9D
U1VQUCwNCj4gDQo+IE1heWJlIGl0J3MgYW4gZW1haWwgdGhpbmcgYnV0IHRoYXQgYWxpZ25tZW50
IG9mID0gbG9va3Mgb2ZmIGJ5IG9uZQ0KPiBzcGFjZS4NCk5vdCBlbWFpbCwgd2lsbCBmaXghDQo+
IA0KPiA+IMKgfTsNCj4gPiDCoA0KPiA+IMKgc3RhdGljIGNvbnN0IHVpbnQzMl90IG52bWVfY3Nl
X2lvY3NfbnZtX2RlZmF1bHRbMjU2XSA9IHsNCj4gPiBAQCAtNzI4Miw2ICs3Mjg0LDIxMCBAQCBz
dGF0aWMgdWludDE2X3QgbnZtZV9kYmJ1Zl9jb25maWcoTnZtZUN0cmwNCj4gPiAqbiwgY29uc3Qg
TnZtZVJlcXVlc3QgKnJlcSkNCj4gPiDCoMKgwqDCoCByZXR1cm4gTlZNRV9TVUNDRVNTOw0KPiA+
IMKgfQ0KPiA+IMKgDQo+ID4gK3N0YXRpYyB1aW50MTZfdCBudm1lX3NlY19wcm90X3NwZG1fc2Vu
ZChOdm1lQ3RybCAqbiwgTnZtZVJlcXVlc3QNCj4gPiAqcmVxKQ0KPiA+ICt7DQo+ID4gK8KgwqDC
oCBTdG9yYWdlU3BkbVRyYW5zcG9ydEhlYWRlciBoZHIgPSB7MH07DQo+ID4gK8KgwqDCoCBnX2F1
dG9mcmVlIHVpbnQ4X3QgKnNlY19idWYgPSBOVUxMOw0KPiA+ICvCoMKgwqAgdWludDMyX3QgdHJh
bnNmZXJfbGVuID0gbGUzMl90b19jcHUocmVxLT5jbWQuY2R3MTEpOw0KPiA+ICvCoMKgwqAgdWlu
dDMyX3QgdHJhbnNwb3J0X3RyYW5zZmVyX2xlbiA9IHRyYW5zZmVyX2xlbjsNCj4gPiArwqDCoMKg
IHVpbnQzMl90IGR3MTAgPSBsZTMyX3RvX2NwdShyZXEtPmNtZC5jZHcxMCk7DQo+ID4gK8KgwqDC
oCB1aW50MzJfdCByZWN2ZDsNCj4gPiArwqDCoMKgIHVpbnQxNl90IG52bWVfY21kX3N0YXR1cywg
cmV0Ow0KPiA+ICvCoMKgwqAgdWludDhfdCBzZWNwID0gZXh0cmFjdDMyKGR3MTAsIDI0LCA4KTsN
Cj4gPiArwqDCoMKgIHVpbnQ4X3Qgc3BzcDEgPSBleHRyYWN0MzIoZHcxMCwgMTYsIDgpOw0KPiA+
ICvCoMKgwqAgdWludDhfdCBzcHNwMCA9IGV4dHJhY3QzMihkdzEwLCA4LCA4KTsNCj4gDQo+IFNl
ZSBiZWxvdy4gMTYgYml0IGZpZWxkIHNlZW1zIG1vcmUgbG9naWNhbCB0byBtZS4NCj4gDQo+ID4g
K8KgwqDCoCBib29sIHNwZG1fcmVzOw0KPiA+ICsNCj4gPiArwqDCoMKgIGlmICh0cmFuc3BvcnRf
dHJhbnNmZXJfbGVuID4gVUlOVDMyX01BWCAtIHNpemVvZihoZHIpKSB7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1FX0ROUjsNCj4gPiArwqDCoMKg
IH0NCj4gPiArDQo+ID4gK8KgwqDCoCB0cmFuc3BvcnRfdHJhbnNmZXJfbGVuICs9IHNpemVvZiho
ZHIpOw0KPiA+ICvCoMKgwqAgaWYgKHRyYW5zcG9ydF90cmFuc2Zlcl9sZW4gPg0KPiA+IFNQRE1f
U09DS0VUX01BWF9NRVNTQUdFX0JVRkZFUl9TSVpFKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1FX0ROUjsNCj4gPiArwqDCoMKgIH0NCj4gPiAr
DQo+ID4gK8KgwqDCoCByZXQgPSBudm1lX2NoZWNrX21kdHMobiwgdHJhbnNwb3J0X3RyYW5zZmVy
X2xlbik7DQo+ID4gK8KgwqDCoCBpZiAocmV0ICE9IE5WTUVfU1VDQ0VTUykgew0KPiA+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+ICvCoMKgwqAgfQ0KPiA+ICsNCj4gPiArwqDCoMKg
IC8qIEdlbmVyYXRlIHRoZSBOVk1lIHRyYW5zcG9ydCBoZWFkZXIgKi8NCj4gPiArwqDCoMKgIGhk
ci5zZWN1cml0eV9wcm90b2NvbCA9IHNlY3A7DQo+ID4gK8KgwqDCoCBoZHIuc2VjdXJpdHlfcHJv
dG9jb2xfc3BlY2lmaWMgPSBjcHVfdG9fbGUxNigoc3BzcDEgPDwgOCkgfA0KPiA+IHNwc3AwKTsN
Cj4gPiArwqDCoMKgIGhkci5sZW5ndGggPSBjcHVfdG9fbGUzMih0cmFuc2Zlcl9sZW4pOw0KPiA+
ICsNCj4gPiArwqDCoMKgIHNlY19idWYgPSBnX3RyeV9tYWxsb2MwKHRyYW5zcG9ydF90cmFuc2Zl
cl9sZW4pOw0KPiA+ICvCoMKgwqAgaWYgKCFzZWNfYnVmKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiBOVk1FX0lOVEVSTkFMX0RFVl9FUlJPUjsNCj4gPiArwqDCoMKgIH0NCj4gPiArDQo+
ID4gK8KgwqDCoCAvKiBBdHRhY2ggdGhlIHRyYW5zcG9ydCBoZWFkZXIgKi8NCj4gPiArwqDCoMKg
IG1lbWNweShzZWNfYnVmLCAmaGRyLCBzaXplb2YoaGRyKSk7DQo+ID4gK8KgwqDCoCByZXQgPSBu
dm1lX2gyYyhuLCBzZWNfYnVmICsgc2l6ZW9mKGhkciksIHRyYW5zZmVyX2xlbiwgcmVxKTsNCj4g
PiArwqDCoMKgIGlmIChyZXQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4g
PiArwqDCoMKgIH0NCj4gPiArDQo+ID4gK8KgwqDCoCBzcGRtX3JlcyA9IHNwZG1fc29ja2V0X3Nl
bmQobi0+c3BkbV9zb2NrZXQsDQo+ID4gU1BETV9TT0NLRVRfU1RPUkFHRV9DTURfSUZfU0VORCwN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgU1BETV9TT0NLRVRfVFJBTlNQT1JUX1RZUEVfTlZNRSwNCj4gPiBzZWNfYnVm
LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0cmFuc3BvcnRfdHJhbnNmZXJfbGVuKTsNCj4gPiArwqDCoMKgIGlmICgh
c3BkbV9yZXMpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5WTUVfREFUQV9UUkFTX0VS
Uk9SIHwgTlZNRV9ETlI7DQo+ID4gK8KgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqAgLyogVGhl
IHJlc3BvbmRlciBzaGFsbCBhY2sgd2l0aCBtZXNzYWdlIHN0YXR1cyAqLw0KPiA+ICvCoMKgwqAg
cmVjdmQgPSBzcGRtX3NvY2tldF9yZWNlaXZlKG4tPnNwZG1fc29ja2V0LA0KPiA+IFNQRE1fU09D
S0VUX1RSQU5TUE9SVF9UWVBFX05WTUUsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh1aW50OF90ICopJm52bWVfY21k
X3N0YXR1cywNCj4gDQo+IEFzIGluIGVhcmxpZXIgcGF0Y2gsIHNwZG1fc29ja2V0X3JlY2VpdmUo
KSBzZWVtcyB0byB0YWtlIGEgdm9pZCAqIHNvDQo+IG5vIGNhc3QNCj4gc2hvdWxkIGJlIG5lZWRl
ZCBhbmQgZGVmaW5pdGVseSBub3QgdG8gYSB1aW50OF90ICohDQpBaCB5ZWFoLCB3aWxsIGZpeHVw
Lg0KPiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgU1BETV9TT0NLRVRfTUFYX01TR19TVEFUVVNfTEVOKTsNCj4gPiAr
DQo+ID4gK8KgwqDCoCBudm1lX2NtZF9zdGF0dXMgPSBiZTE2X3RvX2NwdShudm1lX2NtZF9zdGF0
dXMpOw0KPiA+ICsNCj4gPiArwqDCoMKgIGlmIChyZWN2ZCA8IFNQRE1fU09DS0VUX01BWF9NU0df
U1RBVFVTX0xFTikgew0KPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlZNRV9EQVRBX1RSQVNf
RVJST1IgfCBOVk1FX0ROUjsNCj4gPiArwqDCoMKgIH0NCj4gPiArDQo+ID4gK8KgwqDCoCByZXR1
cm4gbnZtZV9jbWRfc3RhdHVzOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKiBGcm9tIGhvc3QgdG8g
Y29udHJvbGxlciAqLw0KPiA+ICtzdGF0aWMgdWludDE2X3QgbnZtZV9zZWN1cml0eV9zZW5kKE52
bWVDdHJsICpuLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoCB1aW50MzJf
dCBkdzEwID0gbGUzMl90b19jcHUocmVxLT5jbWQuY2R3MTApOw0KPiA+ICvCoMKgwqAgdWludDhf
dCBzZWNwID0gKGR3MTAgPj4gMjQpICYgMHhmZjsNCj4gDQo+IFVzZWQgZXh0cmFjdDMyKCkgYmVs
b3cuIFdoeSBub3QgZm9yIHRoaXMgb25lPw0KTWlzc2VkIGl0ISBXaWxsIGZpeHVwIDopLg0KPiAN
Cj4gPiArDQo+ID4gK8KgwqDCoCBzd2l0Y2ggKHNlY3ApIHsNCj4gPiArwqDCoMKgIGNhc2UgTlZN
RV9TRUNfUFJPVF9ETVRGX1NQRE06DQo+ID4gK8KgwqDCoMKgwqDCoMKgIGlmIChuLT5zcGRtX3Nv
Y2tldCA8PSAwKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5WTUVfSU5W
QUxJRF9GSUVMRCB8IE5WTUVfRE5SOw0KPiA+ICvCoMKgwqDCoMKgwqDCoCB9DQo+ID4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiBudm1lX3NlY19wcm90X3NwZG1fc2VuZChuLCByZXEpOw0KPiA+ICvC
oMKgwqAgZGVmYXVsdDoNCj4gPiArwqDCoMKgwqDCoMKgwqAgLyogVW5zdXBwb3J0ZWQgU2VjdXJp
dHkgUHJvdG9jb2wgVHlwZSAqLw0KPiA+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlZNRV9JTlZB
TElEX0ZJRUxEIHwgTlZNRV9ETlI7DQo+ID4gK8KgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqAg
cmV0dXJuIE5WTUVfSU5WQUxJRF9GSUVMRCB8IE5WTUVfRE5SOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgdWludDE2X3QgbnZtZV9zZWNfcHJvdF9zcGRtX3JlY2VpdmUoTnZtZUN0cmwgKm4s
DQo+ID4gTnZtZVJlcXVlc3QgKnJlcSkNCj4gPiArew0KPiA+ICvCoMKgwqAgU3RvcmFnZVNwZG1U
cmFuc3BvcnRIZWFkZXIgaGRyOw0KPiA+ICvCoMKgwqAgZ19hdXRvZnJlZSB1aW50OF90ICpyc3Bf
c3BkbV9idWYgPSBOVUxMOw0KPiA+ICvCoMKgwqAgdWludDMyX3QgZHcxMCA9IGxlMzJfdG9fY3B1
KHJlcS0+Y21kLmNkdzEwKTsNCj4gPiArwqDCoMKgIHVpbnQzMl90IGFsbG9jX2xlbiA9IGxlMzJf
dG9fY3B1KHJlcS0+Y21kLmNkdzExKTsNCj4gPiArwqDCoMKgIHVpbnQzMl90IHJlY3ZkLCBzcGRt
X3JlczsNCj4gPiArwqDCoMKgIHVpbnQxNl90IG52bWVfY21kX3N0YXR1cywgcmV0Ow0KPiA+ICvC
oMKgwqAgdWludDhfdCBzZWNwID0gZXh0cmFjdDMyKGR3MTAsIDI0LCA4KTsNCj4gPiArwqDCoMKg
IHVpbnQ4X3Qgc3BzcDEgPSBleHRyYWN0MzIoZHcxMCwgMTYsIDgpOw0KPiA+ICvCoMKgwqAgdWlu
dDhfdCBzcHNwMCA9IGV4dHJhY3QzMihkdzEwLCA4LCA4KTsNCj4gDQo+IFRoaXMgaXMgYSBsaXR0
bGUgb2RkLiBZb3UgYnJlYWsgb3V0IHR3byA4IGJpdCBmaWVsZHMgaGVyZSBqdXN0DQo+IHRvIGNv
bWJpbmUgdGhlbSBhZ2FpbiBiZWxvdy7CoCBXaHkgbm90IGEgMTZiaXQgZmllbGQ/DQo+IElmIGl0
cyBhYm91dCBzcGVjIGFsaWdubWVudCBtYXliZSBjYWxsIHRoYXQgZmllbGQgc3BzcDBfMQ0KPiAN
CkFoIHllYWgsIEkgdGhpbmsgSSBzcGxpdCBpdCBvdXQgZnJvbSB3aGVuIERTUDAyODYgd2FzIFdJ
UCBhbmQgaXQgc2VlbWVkDQpsaWtlIHdlIG1heSBuZWVkIHRvIHBhcnNlIFNQU1AgaGVyZS4gQnV0
IGRvZXNuJ3Qgc2VlbSB0byBiZSBjYXNlLCBhdC0NCmxlYXN0IGZvciBub3cuDQo+IA0KPiA+ICsN
Cj4gPiArwqDCoMKgIGlmICghYWxsb2NfbGVuKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVy
biBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1FX0ROUjsNCj4gPiArwqDCoMKgIH0NCj4gPiArDQo+
ID4gK8KgwqDCoCAvKiBHZW5lcmF0ZSB0aGUgTlZNZSB0cmFuc3BvcnQgaGVhZGVyICovDQo+ID4g
K8KgwqDCoCBoZHIgPSAoU3RvcmFnZVNwZG1UcmFuc3BvcnRIZWFkZXIpIHsNCj4gPiArwqDCoMKg
wqDCoMKgwqAgLnNlY3VyaXR5X3Byb3RvY29sID0gc2VjcCwNCj4gPiArwqDCoMKgwqDCoMKgwqAg
LnNlY3VyaXR5X3Byb3RvY29sX3NwZWNpZmljID0gY3B1X3RvX2xlMTYoKHNwc3AxIDw8IDgpIHwN
Cj4gPiBzcHNwMCksDQo+ID4gK8KgwqDCoMKgwqDCoMKgIC5sZW5ndGggPSBjcHVfdG9fbGUzMihh
bGxvY19sZW4pLA0KPiA+ICvCoMKgwqAgfTsNCj4gPiArDQo+ID4gK8KgwqDCoCAvKiBGb3J3YXJk
IGlmX3JlY3YgdG8gdGhlIFNQRE0gU2VydmVyIHdpdGggU1BTUDAgKi8NCj4gPiArwqDCoMKgIHNw
ZG1fcmVzID0gc3BkbV9zb2NrZXRfc2VuZChuLT5zcGRtX3NvY2tldCwNCj4gPiBTUERNX1NPQ0tF
VF9TVE9SQUdFX0NNRF9JRl9SRUNWLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTUERNX1NPQ0tFVF9UUkFOU1BPUlRf
VFlQRV9OVk1FLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodWludDhfdCAqKSZoZHIsIHNpemVvZihoZHIpKTsNCj4g
DQo+IEFzIGFib3ZlLg0KPiANCj4gPiArwqDCoMKgIGlmICghc3BkbV9yZXMpIHsNCj4gPiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIE5WTUVfREFUQV9UUkFTX0VSUk9SIHwgTlZNRV9ETlI7DQo+ID4g
K8KgwqDCoCB9DQo+ID4gKw0KPiA+ICvCoMKgwqAgLyogVGhlIHJlc3BvbmRlciBzaGFsbCBhY2sg
d2l0aCBtZXNzYWdlIHN0YXR1cyAqLw0KPiA+ICvCoMKgwqAgcmVjdmQgPSBzcGRtX3NvY2tldF9y
ZWNlaXZlKG4tPnNwZG1fc29ja2V0LA0KPiA+IFNQRE1fU09DS0VUX1RSQU5TUE9SVF9UWVBFX05W
TUUsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICh1aW50OF90ICopJm52bWVfY21kX3N0YXR1cywNCj4gDQo+IEFzIGFi
b3ZlIC0gc2VlbXMgdG8gYmUgYSBzcHVyaW91cyBjYXN0Lg0KPiANCldpbGwgZml4dXAgZm9yIG5l
eHQgdmVyc2lvbi4NCg0KQ2hlZXJzLA0KV2lsZnJlZA0KPiANCj4gDQo=

