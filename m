Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58951C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 03:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO7k6-0003bD-MA; Sun, 30 Jun 2024 23:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sO7k5-0003ax-9X; Sun, 30 Jun 2024 23:30:13 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sO7jy-00081a-SS; Sun, 30 Jun 2024 23:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1719804607; x=1751340607;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m5uqK5moSX0lpc14I5ip23nYVQrv+/yOliKbCQ/AjFw=;
 b=OR0NoTYHgQ77Ayk7Suuv5Ruth+D41rvcCrd3qiC+V/pIoddRMyTjNu09
 3DxGQaRVNP6LNDkTwmJ/rJJLl6g9xDsAOFr0Jis+CkLmUoqJexfv0nfnD
 xcE7PjEoG4WNcM88yqdgQ+od+jOVwatO2DqqPmxHTRZSXEoGmUafK2mbO
 GOdpj2MZCJCLy7f/SZqsF0BMrt8KN9gkW01/FQMgAKssGb70SMQIBYS5m
 PkiH54wvC4mkqzgfCdu7tsSdOSNrLy08lFpXse9p6r3hIWqoN7IQStnlW
 Dl+octZ2wJ3lxxFGF3kKu9sXdAyjMmoxd3g9ctMuWQLJV8kzUcZhFBMKi g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="123949373"
X-IronPort-AV: E=Sophos;i="6.09,175,1716217200"; d="scan'208";a="123949373"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2024 12:30:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOHROPS34dKV9k4HRxtKUBIDgY4/Aa9wHsyU5XjIPCOeHEmOd8c+2nLZeMY3tTJkIDad0XUXnS5QcXwpeAdqHXIG6i9CYlnsTW55AhUC6vvurl0VkgygsecAhFFOQV7eIx/T0pRbXjREJjlYmzDpD46BxlJ+ve5ExTnpsDuaBXEkIykBwYi0fRtTfksvyrBSFakzQUbW63sNum1KjqtWe8OFNmcNnwCjP9Cs5/zZ9xGdxuzxz2wuHcq/4gbkXb3hxicdPeCNnDPI8bf0zfyvEV/Nop+bUoPh2IvNQv8OB/rOBSOXpVlWvU0SgNqxogh+vAOSHqgLHok7EAOnRpsEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5uqK5moSX0lpc14I5ip23nYVQrv+/yOliKbCQ/AjFw=;
 b=S7fuH8nyvmROB84fqA4uecoPbZJXi53DhcjoTtceIcNxtlQR6NbgZf8OYgz6HN2UN8JtChIuwhxpy3CAvsRhHD2GzhEQD9d0QCE29kFCzJUe2jZWtSZ8PXEUJSVOE003hqfuDmiSNPcnam7VgM0oJHGRIt5AY7mKPvm9wvB5hW8Eg8wDK8iDB3Fkd4Euj9bVR2aK+7O4FkoPa/8XdzVT/hnli5K2Edb/5395QMXYB9V31MonQQqWnOZs1KJ31Uj6BSgDRI7E/c8L8dbLTKHBP8cV7jKqP37LWSK+1GwncG2gY3esiyERz4Wx2MFIQCtPIa4neAQ8JDbodVsq7Y6Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB8843.jpnprd01.prod.outlook.com (2603:1096:604:155::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Mon, 1 Jul
 2024 03:29:57 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%6]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 03:29:56 +0000
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/misc/bcm2835_thermal: Handle invalid address accesses
 gracefully
Thread-Topic: [PATCH] hw/misc/bcm2835_thermal: Handle invalid address accesses
 gracefully
Thread-Index: AQHaywB1PCuCK+d8kUOPhtkdUH2B8rHhNmgw
Date: Mon, 1 Jul 2024 03:29:56 +0000
Message-ID: <OSZPR01MB6453923E37DFDDDCBED12C988DD32@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240630151414.2969772-1-zheyuma97@gmail.com>
In-Reply-To: <20240630151414.2969772-1-zheyuma97@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9NzY4MGE3YTItNmIxNi00MGFhLTgwYjItMzZkODdkZmRj?=
 =?utf-8?B?YTI5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTAxVDAzOjI0OjQ0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB8843:EE_
x-ms-office365-filtering-correlation-id: 2bbb5276-bec5-46d3-e171-08dc997e148d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?TnIzSE8yZ1E1ZGJlNUhJS1B4b0dsZzZFVTR4TDhJK2xySzRPSmF1NXZoZGpY?=
 =?utf-8?B?MDQ5M1lyOHJzMG0wUWlVbzk0azVwdW9vcVdVNzhYcy9UL3RiWXJXRWhSNElZ?=
 =?utf-8?B?MlJpalprYWhkYnFibXkwd0hPQk92bVNXZWg3dUNwNFN5cm5pdHQ1Nkk3TzlH?=
 =?utf-8?B?WndWSXhreWRROVFoZW03SStLRVhzTWhDOFpVVG9MT3VyYlBob3JVQ20vNDVU?=
 =?utf-8?B?YTVSUzRqUXNCbTJZZW9uZllvT2JPWWZvRW1KVkJHNHM4clFHT0o0WWhLRHpQ?=
 =?utf-8?B?VVRjb2tOeWgrczhqNXl2bTBLNm1qQnRMSVA0Vnoxdk9wcGh3K2tVS212NTl5?=
 =?utf-8?B?ajdaQjVpa25tS0d0T3dlekZ4VVhZM3VLYy9YSUJrdGU4eHIzaVAwMi92Q0xW?=
 =?utf-8?B?akw5NEJiYmxaaEhlbTFxR2I1OGF3MHBRY3Z2c2tlVnBMZ0poeGtRK0VvM0tJ?=
 =?utf-8?B?ajlrMkhCVTF0MVVBUWc1NmR3UDI3Snk3MFZ3SFVablJrK0UxWU1pU2pId3JP?=
 =?utf-8?B?TW9yRTNQQ2RhTlZtSGdER2JwT3pjSllzQ3UzSEFpTkFaeFV3ckMzNldZbTJR?=
 =?utf-8?B?YlBER2dyREhhSDQ0MUFEaDdzOTZDRXYwT1dvR1ovQ0ZGRi9nTVVoUnVBeFMz?=
 =?utf-8?B?NDh2YWI0Z2hxM1hNWnFNa2xObGRZUVFieTVRL0tkTHpVNzhOMUc5SWIzVnpI?=
 =?utf-8?B?TjFzeGNSNTZ1bjVaQVlqS2NQdGsrSkFxR3c5RnhQTlRvQWxVaEpYQkFWbHBT?=
 =?utf-8?B?dVpqOXllM3E1MDNWZHdOdVNtZFcvTFNDN0F4QmM5enJ5bldibytzeGdxSkNG?=
 =?utf-8?B?UXJmQjVHUFdQdE9HWkJjUUI5b1czcG80anoxQzgrbGFYZk5FeDR6NmJIcHJY?=
 =?utf-8?B?ek1vMjhlcXZ5bVp0bDFFQlFHSFZKMWNHanVXKzZBLzBieDdrZW1oVGY4N2Fp?=
 =?utf-8?B?Y3NkMldWL29yTWRjOU9zT1M2TnZuSW4wbXRmaCtCSUlrdWxJRVZtbmYzaWMx?=
 =?utf-8?B?K2hIL1lESmlBWkxveUV4U1ZNRGhSU2U4bzVLSUg3bzhjQXh0U1BPVjV5dWRi?=
 =?utf-8?B?Qm16TStkZ0x3c00wUGU3RnhtNnpHbmxUaXpHeDg4WlRWQW9lbDJrOFd6RUZC?=
 =?utf-8?B?d1hrK2VOK1BST3UwaU1BQ3liM2xEZlhPY3l5K0JOOXRsWDYxam9FYlhqZURu?=
 =?utf-8?B?a1RhSTFjS2Ixc3NsTWU5WXV0VS90OWl5RXRUNldGdXVVQVZHUTZHTWVsUGpt?=
 =?utf-8?B?em9Ra3kzaGpaWmtvWlhvTWVRN0xTM3IzeHpHSlMyM09mR09FbzA4SXQ4NDJN?=
 =?utf-8?B?bVpINTdhVk05eWpmMTdOSG1nV2NzUkg0N3JQbWZ4bytRTXV6cXdoNlEwZmlQ?=
 =?utf-8?B?Z1JRdWZSdGZJYVJFTUdXNmFMMUorUHlpNWlGanRma3RFN1hJTW5DL2pJZWxu?=
 =?utf-8?B?bUJqTDJJRGlRa3FieTA2Z2FUdDBUMzdxL1RScHllOGwxSzZuV3huODlvVmpp?=
 =?utf-8?B?akVtMHNBQlo0TzVGMWlUaTNZbVFhbEs3NE1ydDlsUHk5UEtRN29xbTRwc1Vr?=
 =?utf-8?B?WnM4UTh6WEYxSzB4aVZpQ3lZVEIxaUtURnRkSHdnelczcXR0K1ZGYUc5Ritv?=
 =?utf-8?B?Wm82Q1h3Kzh4cEdLUjBHeFZmVVJVMloyTk1lbGlNSTVObWhmWkNEc0xNWjFJ?=
 =?utf-8?B?L2IrR2ZSaWIyZ3dNc1ZQQlU4VCtITW1iNk9CdE1XZG9xaEhDZ0lyR3dCd3o3?=
 =?utf-8?B?MHpNaGxEd1U0MldQL3pJNE1zVEZJa2dvRXRFcjB5OHBQL2xHV0x2N0RkaXdk?=
 =?utf-8?B?c1BkOFFPZE15dmdVWFNBdzZjQnV3cDdab2E5OG5OZWVpbFIwRmphWFpDaUtl?=
 =?utf-8?B?NnpTNkZDVllKZFJJbm51T282OThlWHdUV3QraWY5NUhaeEx6dUk0R1hPdkQ3?=
 =?utf-8?Q?GYyIfPQOcME=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z21ERGlYbjZ3c2FLNGlIakRRYytybzByekZ1VU1HMWFkZUhkQitjOVpmSysx?=
 =?utf-8?B?cGVlZWhldE1iTGp1MlNqZW0ycFFKTEIyMWZiUG5LaVBidkV0ZlhGc0xlRFdr?=
 =?utf-8?B?TlUzcmcvVXgvbFFVTy80UjZTanhYbmJySnZBOG9WaGs3Z2ZieEVJUTRBWWEw?=
 =?utf-8?B?aW9ZMUI0UGU4VFVaRExSOU1CdXVCQTE5U1NESm1JSTdHbXJFNHNlbGJpR0lR?=
 =?utf-8?B?Q2NWVUptZ2M5QUJycnVPbno5R2lPVUlJM0dJdVFzbldDbW5ZQkh5NWpkM3JD?=
 =?utf-8?B?WThvWCtjRUxIR0Z4WDZvT0pkNU1CaXhaYjN3czd5VEtucUdKd05lQUJubi96?=
 =?utf-8?B?bWZTejd3cVJFeTVtNUtaK2RTd2NmSllob1R5MndPcFB2ZHh0YUEwKzdaQmk4?=
 =?utf-8?B?c29nYi8zTjhPbEhjZ3lKTXErVXFpY2FibVNqd3JHWDJiV1A1Z2h5b0N1TlFQ?=
 =?utf-8?B?bGdkdmREdTB2bDFXcHNUNFBLdGJKbGE1SVpoZFUwaTBHY2kwYUZYS0pVSUk2?=
 =?utf-8?B?NkkwQk5qMzBsNW9hSFVvM3o4a1F3bUNBRDk1cFYxVlBrdjFVWFlaalB5bWhF?=
 =?utf-8?B?UjJjL0xDbE5UYUozWmd5bHp6d0lCaWZwZUdmdDUwTHhjNHdGMVJpc2M2VEN5?=
 =?utf-8?B?Yy80U2NVV0hBSXc1Wjlrc2lXakZvdjRjU0YwMk5LNnBSMDlBdElPQnFjTU15?=
 =?utf-8?B?bmlEcm02ckN0b1M2VTB3SlRjZUJnMVFwOGpleEdIY3V2WEM2T0RSV3dCbHp2?=
 =?utf-8?B?WURDVXNRN20rYmJYclJ5NnpTQlVRalcwWlIzN0FkV2g1dktUNGc2Z0YzN05E?=
 =?utf-8?B?cmZwVnJSMHZIRHFWakZkYnhuZW5scjl4bjNJWDM2Y2NDRFJjZC9SNW1GRDNB?=
 =?utf-8?B?R2UwNVFoaU56NVNmSnZkeU5ZWXlyWXBzN3ZvT0RLZ3N3bXhyQ3NoV3dvT1cy?=
 =?utf-8?B?cWFDODlHVFVxMjI5TEZuaWVoczFUNFNzcDdsUldFK0pucWFkMDBYaE9pNFMz?=
 =?utf-8?B?ckd3Zm90TmlYK0FJVloyT0tkTW1TTG9MUFFhalErYzhkcGNVbTNrQ3VTZHF2?=
 =?utf-8?B?WmRMN3VWWFZ3K1kxNkN5VGdHZUFjRDVZVThscUd0Y2JMRFUzb055MGEyWERV?=
 =?utf-8?B?UXc3SWhPSnoyTitGbTNBTU53eXVza0JRdjJmWjlEZG5pdlAxRDdFODlELzBS?=
 =?utf-8?B?SEJ5UWhoaUw5NVhpckMvbUdLSlk0L29Gb3VsdFBvQVdYZWY5TWdoVUoxSVlW?=
 =?utf-8?B?VmRwRXMxMVhQaEpvUHpJYXZXNms1eDJCUFpicTBFT3FsV2EwZXJ2RVdHTE94?=
 =?utf-8?B?ZW9MVFUwaDFjdjZTQnozcDRjY3d6dEdKd2EwV0tFcnJEWEczN3FpcU93a0Ex?=
 =?utf-8?B?ZE5wRzJ0bUhiVXdrOHdpdjRQYm0xSXF3Y1lEbndNUVlvM3Y0L3BaeVhMZmNM?=
 =?utf-8?B?aGl6TTdDQVBrQmxuSGtMQWp5YXNDTHNYSDN2STRSTnBYdWRSUFVqV0NPSDdY?=
 =?utf-8?B?R2greGw1amgrZTNRenY3L0dUeDFyeGkvZDIzZjNQdVl6UEROTlBiSDdWeE05?=
 =?utf-8?B?VHdlb2NPTktiQXJzMzhnaVhiamZkOStiRUtCNUFPdWJNTGNpdHY1dnlNUzkx?=
 =?utf-8?B?SHVNRjJVREN6Zlk0aGxaTzc0bnc3WHRiN0ZkellHWndUdEMzcWVPVXFIUzdn?=
 =?utf-8?B?WVZyZ09nWklvZmVCY1UzUWV3dnlqRnlLWDlUcGtSN2NnaDgySExDMVE0WEU4?=
 =?utf-8?B?L3JwME1YSW90bnNhOW5WUFo4OTZCSTl6aFk0QlBtUmJqK2NrVzVDcDduM1Fq?=
 =?utf-8?B?czVnUHZXQ0lRWW5LeWUyMnUrM0I0cG9hcGtPYnFYY0dtMTFIUFlIL1VRYVZy?=
 =?utf-8?B?WnpRT08vMDI1a2xhWVJ3KzJsN2JGYlp4eXF6bHZzVXYxNWxFTy9uYTlYbld4?=
 =?utf-8?B?QTQ3VGpLcHlNeldCeHdhcXJRZTBRcENMa1ZwOTByV2QwTUdsUHJMRCs0cll3?=
 =?utf-8?B?NGx4Z0R0SEU3L2xMckpPRlgxcHhXR2YxNTZpb3BhdHNvM3RWN0JvdWxYbk1w?=
 =?utf-8?B?VDFpYk5WWWlSN2ZIVW9RWlU4SmxLL29BMERjdUN5bHBuYWU4SC9Vc0s5UWhX?=
 =?utf-8?Q?wFxUfxcaZRjcJgXlxzeqmvN3p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Yx/CIPhRPtal6c0Y3HdFpd3EAYAnYEvqrJ0HCXt1+tsnHNk6L0FRP4/9u7WEFb/Tu9osnnaWSNqkfSaCowJGUX7JxscK53LBl3VmIy42Dg+DsPJEoMZVxzkzhAQPwV6bTjhvIPIC91RVeF6kvhK7GYr6z9v4lG6RJBj9Zyxig9nFYSkaASb3SMqsRJL4jq0N7TeWXuJeyjcZPslFpzbxN6pMHVgq2mDZM5gT+KEfzY0aOWtBS/f0GaMm1tzeaA0egtQXFm0mOLIcMOmf5DJj/iDyJh/QwTtvtp8fTZwUKRYXpAXSsmuMOOVuYscGmQmHlJic5mwGzTrubdJdtdagLZiY+nLFXw05gkNjsrKanIDx026gey7pvkvF4wfriXvpZPoLPGSW34AFmBIsVpTpe3xHQeqD9IlHOIwoQxS59xVrk2lklgy4Lcb70/yRzDNBGEoYiIXlesYSZ8qs5V/s477/I7I3ORUN2nmsQ2Rd5fmqll9OxZ+exlhHOV29ePh72o6EdkU50xdZ/Hdk29LUZG/AL+fi1bYQB7vSDDFc5jbSypSmi18aD1ISnRC1kgv2TvPWnB29Z/fR63o5MEUUtJbblvlKX99mA8ZYRydYIwwaBPTMthrXS+iD3tmwAYTN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbb5276-bec5-46d3-e171-08dc997e148d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 03:29:56.9377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYjsLzB5L09+Blaso7RYdoAtr9lfMOjUZl7GuB1rxN5xH1MLAmZlcRbCCiTUInPW8xT+KxI03TmqmFUeDeE5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8843
Received-SPF: pass client-ip=68.232.159.90;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksIHpoZXl1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1k
ZXZlbC1ib3VuY2VzK3lhb3h0LmZuc3Q9ZnVqaXRzdS5jb21Abm9uZ251Lm9yZw0KPiA8cWVtdS1k
ZXZlbC1ib3VuY2VzK3lhb3h0LmZuc3Q9ZnVqaXRzdS5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxm
IE9mIFpoZXl1DQo+IE1hDQo+IFNlbnQ6IFN1bmRheSwgSnVuZSAzMCwgMjAyNCAxMToxNCBQTQ0K
PiBUbzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kNCj4gPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBDYzogWmhleXUgTWEgPHpo
ZXl1bWE5N0BnbWFpbC5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11LWRldmVsQG5v
bmdudS5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBody9taXNjL2JjbTI4MzVfdGhlcm1hbDogSGFu
ZGxlIGludmFsaWQgYWRkcmVzcyBhY2Nlc3Nlcw0KPiBncmFjZWZ1bGx5DQo+IA0KPiBUaGlzIGNv
bW1pdCBoYW5kbGVzIGludmFsaWQgYWRkcmVzcyBhY2Nlc3NlcyBncmFjZWZ1bGx5IGluIGJvdGgg
cmVhZCBhbmQgd3JpdGUNCj4gZnVuY3Rpb25zLiBJbnN0ZWFkIG9mIGFzc2VydGluZyBhbmQgYWJv
cnRpbmcsIGl0IGxvZ3MgYW4gZXJyb3IgbWVzc2FnZSBhbmQgcmV0dXJucw0KPiBhIG5ldXRyYWwg
dmFsdWUgZm9yIHJlYWQgb3BlcmF0aW9ucyBhbmQgZG9lcyBub3RoaW5nIGZvciB3cml0ZSBvcGVy
YXRpb25zLg0KPiANCj4gRXJyb3IgbG9nOg0KPiBFUlJPUjpody9taXNjL2JjbTI4MzVfdGhlcm1h
bC5jOjU1OmJjbTI4MzVfdGhlcm1hbF9yZWFkOiBjb2RlIHNob3VsZCBub3QNCj4gYmUgcmVhY2hl
ZA0KPiBCYWlsIG91dCEgRVJST1I6aHcvbWlzYy9iY20yODM1X3RoZXJtYWwuYzo1NTpiY20yODM1
X3RoZXJtYWxfcmVhZDogY29kZQ0KPiBzaG91bGQgbm90IGJlIHJlYWNoZWQNCj4gQWJvcnRlZA0K
PiANCj4gUmVwcm9kdWNlcjoNCj4gY2F0IDw8IEVPRiB8IHFlbXUtc3lzdGVtLWFhcmNoNjQgLWRp
c3BsYXkgXA0KPiBub25lIC1tYWNoaW5lIGFjY2VsPXF0ZXN0LCAtbSA1MTJNIC1tYWNoaW5lIHJh
c3BpM2IgLW0gMUcgLXF0ZXN0IHN0ZGlvDQo+IHJlYWR3IDB4M2YyMTIwMDMNCj4gRU9GDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBaaGV5dSBNYSA8emhleXVtYTk3QGdtYWlsLmNvbT4NCj4gLS0tDQo+
ICBody9taXNjL2JjbTI4MzVfdGhlcm1hbC5jIHwgMTIgKysrKysrKystLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2h3L21pc2MvYmNtMjgzNV90aGVybWFsLmMgYi9ody9taXNjL2JjbTI4MzVfdGhlcm1hbC5j
DQo+IGluZGV4IGVlNzgxNmI4YTUuLjVjMmE0MjlkNTggMTAwNjQ0DQo+IC0tLSBhL2h3L21pc2Mv
YmNtMjgzNV90aGVybWFsLmMNCj4gKysrIGIvaHcvbWlzYy9iY20yODM1X3RoZXJtYWwuYw0KPiBA
QCAtNTEsOCArNTEsMTAgQEAgc3RhdGljIHVpbnQ2NF90IGJjbTI4MzVfdGhlcm1hbF9yZWFkKHZv
aWQgKm9wYXF1ZSwNCj4gaHdhZGRyIGFkZHIsIHVuc2lnbmVkIHNpemUpDQo+ICAgICAgICAgIHZh
bCA9IEZJRUxEX0RQMzIoYmNtMjgzNV90aGVybWFsX3RlbXAyYWRjKDI1KSwgU1RBVCwgVkFMSUQs
IHRydWUpOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBkZWZhdWx0Og0KPiAtICAgICAgICAv
KiBNZW1vcnlSZWdpb25PcHMgYXJlIGFsaWduZWQsIHNvIHRoaXMgY2FuIG5vdCBoYXBwZW4uICov
DQo+IC0gICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ICsgICAgICAgIHFlbXVfbG9n
X21hc2soTE9HX0dVRVNUX0VSUk9SLA0KPiArICAgICAgICAgICAgICAgICAgICAgICJiY20yODM1
X3RoZXJtYWxfcmVhZDogaW52YWxpZCBhZGRyZXNzIDB4JSINCj4gKyAgICAgICAgICAgICAgICAg
ICAgICBIV0FERFJfUFJJeCAiXG4iLCBhZGRyKTsNCj4gKyAgICAgICAgdmFsID0gMDsNCj4gICAg
ICB9DQo+ICAgICAgcmV0dXJuIHZhbDsNCj4gIH0NCj4gQEAgLTcyLDggKzc0LDEwIEBAIHN0YXRp
YyB2b2lkIGJjbTI4MzVfdGhlcm1hbF93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPiBhZGRy
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgdmFsdWUsIGFkZHIpOw0KPiAg
ICAgICAgICBicmVhazsNCj4gICAgICBkZWZhdWx0Og0KPiAtICAgICAgICAvKiBNZW1vcnlSZWdp
b25PcHMgYXJlIGFsaWduZWQsIHNvIHRoaXMgY2FuIG5vdCBoYXBwZW4uICovDQo+IC0gICAgICAg
IGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ICsgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dV
RVNUX0VSUk9SLA0KPiArICAgICAgICAgICAgICAgICAgICAgICJiY20yODM1X3RoZXJtYWxfd3Jp
dGU6IGludmFsaWQgYWRkcmVzcyAweCUiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgSFdBRERS
X1BSSXggIlxuIiwgYWRkcik7DQo+ICsgICAgICAgIGJyZWFrOw0KPiAgICAgIH0NCj4gIH0NCg0K
dGhlIGRlZmF1bHQgYnJhbmNoIHdpbGwgbmV2ZXIgYmUgcmVhY2hlZCBpbiBub3JtYWwgYWNjZXNz
LCBzbyBJIHRoaW5rIHRoaXMgDQptb2RpZmljYXRpb24gaXMgbm90IG5lZWRlZC4NCg0KPiANCj4g
LS0NCj4gMi4zNC4xDQo+IA0KDQo=

