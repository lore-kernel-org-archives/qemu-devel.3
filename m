Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DF9C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOf8X-0001g1-NW; Tue, 02 Jul 2024 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOf8U-0001fk-AH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:09:38 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOf8Q-0005bi-Nk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719932974; x=1751468974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=q0pQfaD1rCXgwkVTK9uN3l8MoHmonBeTedUOelplKGc=;
 b=EyHm42xvrU1xNFelqgKvwY+qjRjaAo3BmjUORwsWCtOd0WdLjxsvfxCR
 SDPJDh3bdFGnxHNXiBa+lEf9uG8sVoRDXvzIwNNW1dwmbewaQ/4SLXsYS
 TJkJ97fCEjCqmim0cCnkR72kX9A3nIKMNHry90axoDcaadYbUerHvKmbt
 KNkIoMNs9gQc5xDl1bTaqWkLc2wI7t6/VtA03LUkkGozzVJizMKFjvclR
 bBhUlwP9Lj5mHVBqfDggcnFT7ahb4BtswD6+ZCqCiSCCGs6ex8MTBaWJ4
 NYcEcxbpdrtKa4Y+E55m4d2xp3zB2b52L/stdMYKSHUHLsZ8pmgLUqf5Y Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15860080"
X-MGA-submission: =?us-ascii?q?MDFopgfz1ahpGU848Geg1dQfuMciDr91YO+v9i?=
 =?us-ascii?q?u5WQCYCSbJTLWnarBOhOSp4U+NU5rY1vzMGYJLVXpPU/k265cki9kye8?=
 =?us-ascii?q?GhROZrxjXi++VJpbtRuN6UgRPQJ2JB3/CFP19gxg2p1vSOWBHJbXOzSx?=
 =?us-ascii?q?+50+EHD457WGiNBJNYSuDO8A=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 17:09:29 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kuw6qbkm2N1kptZzK4+rrloHiJKk6k1Uh35RYbvRjdUHVsryTsaCZIwgxRxasay6NRhFB3Nla5i/CL4aGRlZScF40F8AJQ+ouhYmAzudho13badMCn51icSkLc6XmCS80y4M9fYU4+XYd0xyr1Iw9IQshHEguywOl0s3PKj5vhF+Ghbg31fgxEWb5KzCsYMJPP03AtHd7jljG7JRtu4R3UtN924d3U+lBin4CtdtO9IO4+Ul/5QTz0oer2+zvcdhjpSXDJcHL/6g6YzYgtYyoaZ1qvVSwe0iNMjpkHm3g+eruQi+AUDNnNUze1j2uYLLi8NkkdiNdo9b+zqsRMb+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0pQfaD1rCXgwkVTK9uN3l8MoHmonBeTedUOelplKGc=;
 b=OcYJ1jAmtxzJM8A9x79oTPt6aGxF6ltio/x/0GQ/cHyXd+GIZ9zKoyaBQy9WWitfpqY4VwYz4I8ceEghoHyRKA92k5lwzNwXUOOqvasoiUNGNrtMOnckAuHIRagrtnFfpxF2SuZBie3EW18xhio8Db1xMvHk1SKsXQj5zU21Btb3BUj4TjrrmNVn3sASlY9pokQNF+qm94nOKBXNtAbLAAnhFRbeYl8OxJyT/xdEmK+tghmLGlSB93ycEwEY2D4eBsBnaFR4sK+EVHy4f5XOGxMlygeslTbZ5ruY7yyj9J9JWsoNYfzQcwMzM5Dwh4Z8pO5aOnUBAvlntYKtWjvA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0pQfaD1rCXgwkVTK9uN3l8MoHmonBeTedUOelplKGc=;
 b=KHP0zobvxfEQ6qyq2QmoCjObRCo6I0LgGPTqrOx2wCMErCRG9RJwBq0lkkG6Oy5X2xB3bz0deRmDp9W1TvnXsMDL4QrMPNnOKcJe0KK4moyK1+24FFUx/ouHp3sWQYLkBEFoZ0yoak4oyPs4SUj0KniNvBNkMbKqVGVEnP1+7XD0YuUfNmfEa5+wEzcY6lrO2Mzt27M12CrzQJYpEcKJvgAgRT//eco0pUL+ZIp3JSgklq7oukFTd9d2U82Id4COhg/ftLOTNswXCsA5EmtaOUEFI6DGXcOVgkWoKZHkCwYFC5VwFzTdFKMGXKGYke1hjsXgDkN+LGyfjUZ+GzUObA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU2PR07MB8077.eurprd07.prod.outlook.com (2603:10a6:10:2b6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 15:09:28 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 15:09:28 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, Clement
 Mathieu--Drif <cmdetu@gmail.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Index: AQHazEQGTuJM3iTlWUqCZ55Q529ilrHjWuWAgAAwMwA=
Date: Tue, 2 Jul 2024 15:09:28 +0000
Message-ID: <c4af0f26-83ca-4685-842e-9f0829abb736@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702081539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240702081539-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU2PR07MB8077:EE_
x-ms-office365-filtering-correlation-id: b9b3d9da-37f1-485c-0eb7-08dc9aa8f7b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWdZNjEzT0ZUUmdvSi9DcUwrelRYYkdjaHVXOVRyZVBDUlJyMlVjTnhFbWsy?=
 =?utf-8?B?eWpLZE03czU1QW1YMWNmT282eGhGS1k1c1RIYU9DWjdkVUorNjhFZGk4SVlI?=
 =?utf-8?B?TmlLdTVIK1FJa3hrVFdmcGh0eHRrQ3N0enNvNTJSajErRTdxNTQ5ZFNObkcz?=
 =?utf-8?B?c2sremhHWEFEVWNzcGhwZUlmMHphRG5qT0hEMnBmT29SN2ZERUs3S1hKSjdR?=
 =?utf-8?B?V004RTI2ekVWaHRibStHNHljd0lhQmE2N1dLQWxoTkpGRGRJLzNYcGxqbU15?=
 =?utf-8?B?dGJLOFMzeWpaRGJIdlZKZVVzK1c1dXllMitlV21WZnF4dWZ6NmJPaDhxb3pv?=
 =?utf-8?B?VWIzL01GRUtwSFpsOWZqcC8xZFhmZS9WcHpzOUlDSVJJQ2s5V2RFY3JnMUgx?=
 =?utf-8?B?cjcxZ3B2dkZQOXNVQ201NjBvZms1RWFWM1VXU2lLOVVqY2RJMnhPQ3poWFB6?=
 =?utf-8?B?MjRMMDVXSTYxMjFUeHVROGJLa1g4a0RHT285VnQ2bHlXZ0VOeUliM1V5Lzlr?=
 =?utf-8?B?V056QUtSQ2NkcG5Ud0hQM1NKQWFidU1yUjluTlRGU3JzdXphVHYzTGhpNHdy?=
 =?utf-8?B?a0hDdDNjemk5R0hMcXJGcmVPMUViRXhRbTJLU2NVdUt2VjdGTEhsVkE0NGNZ?=
 =?utf-8?B?L0x2K0VSSDNrbURaMWJESUZhUjhVbmZuZTl5aUo3cS9mbG9ZTVE3Z1lEdEtW?=
 =?utf-8?B?SnVlTStUOXo1eTAxSWUzSlpLNUc5cTdwaEpFbGNFYm9JUE9TeUZEbE0vSTJq?=
 =?utf-8?B?Qy9WUjhRaTFIWGR6NTRRSzdkRENxN2RvYTNtK2JHTVNudk51N1RkeHI0UG52?=
 =?utf-8?B?b0czUzRDTUZ1RGFvT2cwOXd2SUZ3S2Ztc29rWEFCdWlUT2gwREFFK1BkeTNL?=
 =?utf-8?B?WDRRMkFKQ1VpQWJVMHFUaUUyektDNERKdGJ1NnZMamI2cGRrTk5SazZJM1Jt?=
 =?utf-8?B?aTREL3RVbEdGY0tvZ0RuNkl2UUJ2cEIycThhTmpvcHpsZ01kUkNUSUxQZ1FS?=
 =?utf-8?B?cEh1Tk02U2RMUjhYR2Q2UkpjcVU1bHh5OHpFQms5b2lMb2ZGTHJ6dkhRYzY4?=
 =?utf-8?B?WXgzYXZRZ250U0h0ZnlYa2wvZnR1VkYrd0JiSU1VVzRtVDRNQ051ZVlQZjdq?=
 =?utf-8?B?ZXlkL1krNXpIdG03blJnMnp4Q3hwSEJQQ3BSNGx5eWdhc0xzMkJnYUhnQlNH?=
 =?utf-8?B?Y0lpb1FpVlBRbE01TWpFVGdueEg3MTkzN1BGUUZtdndIK3YxS3gvMTg4Q1g1?=
 =?utf-8?B?MWhhNXYvTFNQWFZ6RzhNRjN1b3d1K2g0clliYjc3cTY2VngxKzNoQ3ArOGJR?=
 =?utf-8?B?TXRuSGZEQmFPUUY5dTNLTlBWRGlCMHQ1YnV3clNIZGNob2VsVFNsbWxySkZu?=
 =?utf-8?B?bW5OMmE3RmRzR1RUVUZuaEtKYkYzaW5Dam02YnNJSm84QkNleUxTSzFXcWZI?=
 =?utf-8?B?SEpNbEpKZmp2ZXNFcUh5ZEZhSmVyaVorT2huWUFySHQvWk5SMFkwSGNmS2hh?=
 =?utf-8?B?blFhNzBqeC94eFI1L0k4TWNjdXNRKys4bndZVk9SNW1aRXZtK3VXdW03N0k3?=
 =?utf-8?B?ZTU4b0JMOWMwdjRJOVhQWHNrcEZpWHZFRUkzVVhiUjJ2MHFmOHhtbEo0V0Rx?=
 =?utf-8?B?am9tTHN5QmhZd3RnWElzemQyVmpNVlJ3cGxWb21EeFdDMzBoQWprcHkyb0lX?=
 =?utf-8?B?MHlmcEtDNHBEWk50UTV2bzlaaDhPaGVGRmVMeFk4TzlUV042WngxUVRvbkY0?=
 =?utf-8?B?Q20vQjV5QldRbm9jcEg0NXJGSXdocVZqWlJoYUtUTE00SnlVUDhqdXN3bUp5?=
 =?utf-8?B?cWR1YkdOa2xRR1lxZzdUWnNnSnlZKzJ3NVBsZ09nNjhoVVllUHVwL2xnSGI4?=
 =?utf-8?B?QjRCZmk0TmFUb0xvQ2daWXJycEJpTU01L3J1T0s3MlZGL2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TERBYXVkdkloRDVUYi8xSndZQmRRNUh4QjdLVTdXdzNRZHIrd2pyTDYrR2ZD?=
 =?utf-8?B?YzBoV1lMZlhsRXdrNUVzQ2F0bnkvdlM5V0kyR2Nia21QZ0NiQmZhYko3Qm5X?=
 =?utf-8?B?UGQ2NVlVZzBTVk1IaVkzc1FJM3lDcElTaEVvZVhnNWxSYWpXbkFTTDlzSEJh?=
 =?utf-8?B?ZGlXSFpYQnVIWDUvUHBoMkRGNkVKOUkzZWxUazR0WXNmV1oyWGp0djYzNUhR?=
 =?utf-8?B?QTlrTjZtLytnTnFJdEdBOEpvQmZRdUZwWmpMZm9RVXVmOW1JTFBEKy9KK3FL?=
 =?utf-8?B?NTRiSm9VZStuSWRsWEVqeUF0NFAyYlRMK0dObytuSExWTkxiaDRlUlBCSTZo?=
 =?utf-8?B?YkhsS21HTVhMV0EyZDBqTHNJRS85WkhWRlJZQlFjT3Q1NEU0czFsTW5tdXdJ?=
 =?utf-8?B?NUp2UTNRSW9rczRmekYrV0U1Y0JwZElTL01qKzR0SHkxdkFlRURQZ3Z1RnpH?=
 =?utf-8?B?cnQ0RGEwZENkZjRZNzMwMWY4VkppeWdPSkFuTXhkT3UzVzVQbW1mWXJDY3Z3?=
 =?utf-8?B?UUxjVXhydHArNkNCNzc4M3JoaW9qajRxNlRPcUgrZnZLdXpWUEE1ZzRBak9E?=
 =?utf-8?B?RW9OWWNtaHpuWE5obW5LYmZqRW1WTk5ZUi9GK0xpdVByaUZKWkRVaGlkQjk1?=
 =?utf-8?B?YkNxTkhmOWhUMFdmcUFadDdoVFNyRFZwUTJ1OUxQZ1ZJaDBqRVpSSC9kSi91?=
 =?utf-8?B?QVJqbTZ3Q1g3Y3UzUHp2SzcxdlovN3BZVkV4aC9GQzVVamJZb0sxY1VBNU5j?=
 =?utf-8?B?VUxhbm1hK3Ribld1Y0dnQjI1YWRWWEt5UFVHc3V2cHZOYWNKQll1YnVaTFU4?=
 =?utf-8?B?RjRSYjZrMndISnFVVEQ1MjVoZThaMzVZZ2xSNHRicWM5aEtyYTBXWFg0Y3JQ?=
 =?utf-8?B?SGs2WWtPTUcwamQ3eUt6SDAvSFR2L2gveG5Tc1F5aHhhaGZ5Ym5OVkp3Y0NL?=
 =?utf-8?B?cVN5aEFnZzZ0eGw3ay82ZE1JZXBDUXJtWlN2cVdZMWM5c0VCSDJ2MDQrdlVr?=
 =?utf-8?B?Tm9EaGxYUXNlY2tweGsyQzRTVWttUmdXQXFPNGl6dUpGWGtVMVJpbGJOd3ln?=
 =?utf-8?B?T0hhUUZ3MWJQTXZtaEkwbGh5OWV5NW1IMUx4K3EydForWDVYWFlrQy9oSTBo?=
 =?utf-8?B?U3NmNld2SzJya2R0YTdVeVVQV0VNbUtlS2JJOVZnREZ1cUtSd1lPYVJwdmo1?=
 =?utf-8?B?MllRY01RdUJYUGIxYWR5V29VRWNlZ0JoQ1RqNVdhdExIZStZZk9NaTg0SGlu?=
 =?utf-8?B?YitvQjM2dmlaTHdyTHdBMHQ1MzV2SFExUWlEdFVpVjFUa2FRTjdTSllaVjc4?=
 =?utf-8?B?QnpZejhDTVplTmFzbXZLcE5mOUdFUm9FWlZtWE50c2l3TVA4QzE0anY1YzFr?=
 =?utf-8?B?T3hGVVZYanpob1EvMEorV3JDampNbzJjZlBQSjZHVW43RitUam5jYk92UG41?=
 =?utf-8?B?TlgwblVQZ0R6WExJL1RlVTJNN2NJcG83Tmtza2JPTjVmUk9MbjRaR0gxUnI1?=
 =?utf-8?B?QWFncmU4K3Y5eFE2NUVoL0pjT3hKd0FQK0NneEQyck1lMDZIZ0VrdzU1L055?=
 =?utf-8?B?VnpoOGxBU3NCRXYybUkyM1EyeU9JNU9LOUpSWWlhMlovUW1CZittNlpWMU9B?=
 =?utf-8?B?TERJOC9qZHNFbkozeCtIVGhwNU8xdHlMQ2ZmTngxUzJUbmg0RnRoOFBJRkt3?=
 =?utf-8?B?cnppVnBvQStWV29IZlBZZitwU1dqVXByNkpTY2hRN2cweHBRUEwyZjBUdDNr?=
 =?utf-8?B?TVZwT2hKa3l6WXNSc0tZY3Q5YVFmRm5lbHRoNHB2VndRK2ZCSGo3NzNkY0JW?=
 =?utf-8?B?eEZjNXd3bjJ0R01KS3hWNHcyeE0zakN0My8rTVhQVkZCV1VyMlRWdkh2Z2hZ?=
 =?utf-8?B?cnJPbGF2Y1lBQlJrLzc0V0NFNTVSS0RZQ3hUSUsyUUxqYm5MZXhja1RZeGlG?=
 =?utf-8?B?VGhMSjFqVENLSGFuK2JhN1hEZEI4TnNkN1BKQ3YwdmFxalVLNm1zNnNMaGll?=
 =?utf-8?B?R2hRY1p0YTJFOHJxZG9PYzZkMk1VWTdqMXFjQ1JwM1g3S0l2aE1hZ0dsUGcr?=
 =?utf-8?B?b0pDNUtaeWIrZFpydlJSNld6QWlaQUplZEp3Vlk4YTFralVCKzNNam9tNFV0?=
 =?utf-8?B?YmdzazAxWGdZS0NzRTZYMWFHTHFtQ1FqZmJXaHlNa3VEK3NrS0FjdUkrWWJ2?=
 =?utf-8?Q?MM+ReQhooOB5jTaU649S29E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C1755EE2B362F4E9FC481F711604751@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b3d9da-37f1-485c-0eb7-08dc9aa8f7b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 15:09:28.0972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OFo0lQKxccJc+6HHkqhwmF0UAxBkxEUfMjFbXK+iCA5Wvvso+ulav+4ojOZ/5PXy+vTFoLLjbrL6mRtpxcV95x/Ei1WcWem5gOGUqMec/qErzPj/gZughiXM2eVtn82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8077
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

DQpPbiAwMi8wNy8yMDI0IDE0OjE2LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24gVHVlLCBKdWwgMDIsIDIwMjQgYXQg
MDU6NTI6MjlBTSArMDAwMCwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTog
Q2xlbWVudCBNYXRoaWV1LS1EcmlmIDxjbWRldHVAZ21haWwuY29tPg0KPj4NCj4+IFRoaXMgc2Vy
aWVzIGJlbG9uZ3MgdG8gYSBsaXN0IG9mIHNlcmllcyB0aGF0IGFkZCBTVk0gc3VwcG9ydCBmb3Ig
VlQtZC4NCj4gWW91IGRvbid0IG5lZWQgYXRzX3Z0ZCBhcyBhIHRhZywgSSB0aGluaywgc28gaWYg
aXQncyBoZWxwZnVsDQo+IGZvciBzb21lb25lLCBJIGRvbid0IG1pbmQuIFdoYXQgeW91IGRvIG5l
ZWQgaXMgInJlcG9zdCIgc28NCj4gcGVvcGxlIGtub3cgaG93IGl0J3MgcmVsYXRlZCB0byB5b3Vy
IHByZXZpb3VzIHY1IG9mIHRoZQ0KPiBzYW1lIHBhdGNoc2V0Lg0KPg0KT2sgZmluZSwgSSB3aWxs
IHJlbW92ZSBpdCBpbiBmdXR1cmUgdmVyc2lvbnMsIHNvcnJ5

