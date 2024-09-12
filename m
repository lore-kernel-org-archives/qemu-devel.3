Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0DCEE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm0-000335-Ot; Wed, 11 Sep 2024 22:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1soZly-0002tt-FR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:30 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1soZlv-00048Y-2W
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1726108887; x=1757644887;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cDe+18HAgwRNrUobNcWNXZwKjQlNyF66AFSJy4RJ5bY=;
 b=WmVZlQDLCuti1uuJB5b5CLOf+9oryKco9vKlUjTkLrg67x5//TA/j769
 62KzRxPKdmvKwkSmIcdR4Yb4FoBfsJNvwnGazOl8wu7unjmkSaHgrtA79
 p61pyDY6i6aLKNcc8G9WRuu4JDvTi3w8X5zRR32NZ6+wGmh3WpgbAAZQG
 e6EO/V4wiG6GzhOR+d5ohuY7ItbgV+nEF1l1vAx5HVcN/kiJQnvtEnAMC
 sBDsFY9GUFUmamMNrdM+XigVVdYp/5o0qN96jGqgTtCS/RJAAbfnXwEx7
 K/thkYcE4KNzaBb4PFn5hk7d1uP81V9zyFYRYZ+MyG7C+M3TndzkKAEep g==;
X-CSE-ConnectionGUID: JXVSqt5NSZqq0X0IuBMZyw==
X-CSE-MsgGUID: PiFMqjb8QzqDKm5pO20MaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="130961994"
X-IronPort-AV: E=Sophos;i="6.10,221,1719846000"; d="scan'208";a="130961994"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2024 11:41:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvDt9B46LtUuFX6yyVXxJaysgtyzpGVivodJa0QPhHlrRE7zBbeqsgkDxvhWzP7ucgR/ZZHPP86ClsIGwl/gf8WDUv0Pj8dqQym47ie/rYtYqBJPBhv1+eCiankWiWNWNGP27CCvqproKbtWuopE0nApwhoo9tZHSzVmlfmbDswZVmNfR/H5UajzKUdO9jUjKOATBhhTdroMX/e4GAWeoF95WR1HZJLaYKVe4tFgo9Ex7L+HHsnHiiPWOZ6OgcnpEI9VMnFCBu0CBxuLafoVrUacDULC1sS/LTDzOdWmYXz44IEvhYHXwvtUmMAJ2IHa1Iv4IX+B9uHmzblIysbD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig6Mwp7zzBW01Dl+5/aVE6aCiozXff/kV7J3Dt+5fyM=;
 b=jWcRmcjwPYMYKroY292XAazCFL5QeChLmG5K2hlpOW6UdBnlLmkncGe7KxeAor7GusW+/WguoRZdgqrsedJZBhpLSmgIE2TYDEQmrjUj0c20mwPp5GtleqIC97g0vudzyniOMLqIb/o1I4ZKyIFmFt0snPrA+bLF4uIlDwcCQdXMlVm067tAt1NjkqeMMQQexWE3wKI+Tav5jl2598SaHJSzlnZSA7hGDa3nc1FzR9DfTBbtdkRqVUteCE82vhV2BKaxJpF8uh6FHFxNDI9ubu8XgJoqj8c284b6xW3VuLvSqyG9Qxo/unOoHNCoqatFqtUnyxbn67iJHOpFsRbGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSZPR01MB7844.jpnprd01.prod.outlook.com (2603:1096:604:1b8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 02:41:12 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%5]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 02:41:11 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Topic: [PATCH v4] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Index: AQHa3nZ22xYQBEGwKEWqyF7g/GHEEbJRa/sAgAJQP3A=
Date: Thu, 12 Sep 2024 02:41:11 +0000
Message-ID: <OSZPR01MB6453ABF3A300C9BDD53847178D642@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240725093819.15549-1-yaoxt.fnst@fujitsu.com>
 <20240910111433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240910111433-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=2c815e3d-2517-4407-af04-2b9027b9f2cd;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-09-12T02:40:42Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSZPR01MB7844:EE_
x-ms-office365-filtering-correlation-id: d4e8ccf2-72af-4f1f-12f0-08dcd2d45d1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?VjhES1ZrUXpyUGtnWXZ1VEdBSzJSdEQ4VzFEbHFFTk1DaFZlWXlCQkNI?=
 =?iso-2022-jp?B?a0JxbzRRcHBoTllIaEpuTTcvQkNndnAvUWcvbGFIVGxiOGVqV2kyeURa?=
 =?iso-2022-jp?B?OGlldHFhYVkyWUdNdml3MlUrb0F4Vi9QaFRmT3BoY216Q2Z2cTFGQWlH?=
 =?iso-2022-jp?B?OHhFSEd0WnNGSlRQOGl3aW9Ka2hWMm53THFrL0QrcjRLRjAvdnViekVO?=
 =?iso-2022-jp?B?ekxBK3kxd05SQitwQVdxTGl2c2RIaHpNTDE3cUxOcEw0MjRVRG41Mmlx?=
 =?iso-2022-jp?B?UjhFcXBpcEtLY1AraTVJTzhjcVZHb2ozSWIwQWtsWTI4Y0phV0dOdFlk?=
 =?iso-2022-jp?B?OGZqeUNQYjZRL001QklhSWg5L3REemlFLzg0bXZJa3RESzltKy90MFBM?=
 =?iso-2022-jp?B?VnlkdUJRTWY1QzFHMUk5aVRnLzN5b0xVYTNOMFB2K1R1ZUxJb0R0Y09v?=
 =?iso-2022-jp?B?aUVpUW9oQ1RHM3JqeGt6WlRycGM2S3JWQlNVUXdaTjI1LzdRbENkclZB?=
 =?iso-2022-jp?B?VEQ1SXFRYjlISjNWNU8xbGZ4YW1rZHZ0a3JRaURodzJtSHhuMEVYM1Fv?=
 =?iso-2022-jp?B?TWRFWDUxSXRGNjJrdld1bW81NElaNXVSbVNlTXZ1YkVwbnNJdFFxNkd2?=
 =?iso-2022-jp?B?R2FKTXdZVmdhRUhiYVRrc0dLdjNpMldUK3VPekUxSHVOZEFNa1hrSUNr?=
 =?iso-2022-jp?B?eVRFTG9MVmtrUnYzM1BRMW5WeHNXMitZYW5VNjBlMEwwWk1IUTl3N05h?=
 =?iso-2022-jp?B?WktoTmlkaFNDdTVxQWZFcEZjRTlPdmdzTm96bGVkYjN1OEc5byszeXFF?=
 =?iso-2022-jp?B?N3Q3TmJOanZvWjF2VC81VTlSdDlCbW1XamJhUkJpMWhmVEk4Zm8xR2lI?=
 =?iso-2022-jp?B?cnpHKzVQb0haQlNNR0c0bWxqdXNjYmtxaXNzUERzQk4vZ0RJUWpHR29h?=
 =?iso-2022-jp?B?SlN1WUVCTkpDZ0VINlgwTFFrMlRnK2U4U3FlQVNnN002Vkkza0p6R0or?=
 =?iso-2022-jp?B?Si80aGh3b0NRWWducndiYnVEaHdRbDVqQ2dUVWt2RHhiU24xWVZDcTdX?=
 =?iso-2022-jp?B?TjdKRXBDcmdld09NVlROekdFNUZBUmNRWUpjMlZyajI0djUyaEZUY1Nj?=
 =?iso-2022-jp?B?MDZvY1oyUHVudXB1amVKUnk5V1dkc1lKVWxHa3RXYUhESzNvSUNJTlM3?=
 =?iso-2022-jp?B?WUJtYlVZampiMXc4alNtKzh5YWl5ZUtXa0NSU0gxUlhJbmJhTnB1OFIw?=
 =?iso-2022-jp?B?REc3ejhyUW8wNTdPazFNN1RTWDBDdHdHZllENnpxRDdEMEp2QWloOS9l?=
 =?iso-2022-jp?B?Q2hCbFAycjljZkNXRHEraS96VzlCZlRLRFRUaWFHWnlHaGN3SUk5MjN4?=
 =?iso-2022-jp?B?bFduODJqb1BubHlRSHd6LzUwbWVYcmM0VXF3aVF5bEROUHdZUHo2Y2Jr?=
 =?iso-2022-jp?B?c3pLa2tmMHdkV3I4eXJCanVtVnBBSE1WWThSUjQ5UEpBblFseVgxT0NP?=
 =?iso-2022-jp?B?Y3I0cE5jSFZKaWFCQVJnWHpLYVQwUDRBeVVLOFdLOUlndEE1ZTJxYUY4?=
 =?iso-2022-jp?B?U3gyeHphaXRqNkpEWndsOHdGem4yVjg1eWhvc2JGV2lxSDlrMU9EKysw?=
 =?iso-2022-jp?B?bkk1aG5POEg4V0FKL0sydFh0dytXWWZjcEZTNnJnRkx5VkhwREg5eVZw?=
 =?iso-2022-jp?B?Zk0vdnhGRU1vcE1MWXo4V1pGZWVvU01IVE81a3c2V2FsS2w0VXdjc2lh?=
 =?iso-2022-jp?B?cHZKNkQ2dCtHckQrNzlsZUk4TysxR01oUDlKSTA0VEdxWHZlN2hkWUVi?=
 =?iso-2022-jp?B?VDZLdlpSWVhyVStRa05VVjBwVVM4a3R2ZnJ6NGJNcTZ4bGpLeFRuY2ND?=
 =?iso-2022-jp?B?MFNFcEdqc3pJRWZtK0o5b3RGWlJwYXhjTjUwZTZoZzFjTWp4U3ZlRnRX?=
 =?iso-2022-jp?B?Vmw4SWE3RFBKYytiZEtuNXAwWWdFM0s5Rjh3emZldGxxM0RUVUwxTFFC?=
 =?iso-2022-jp?B?S01WcDFacGdvVVViS3ZHSlhjQzdFNFZJT3JMaHRBNm5oQXlxTWhsV0gx?=
 =?iso-2022-jp?B?elczRWhmVTdxbmtnU2RHaEhOYnZJODRPWHBNM0VuTmo0TkhFZVVhYnpV?=
 =?iso-2022-jp?B?ZTU=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YVBmV0lyZCtZcmdQaXV6RHY1RVpGWGg0NUpaaW5HM3VXNEp0eTltWFgz?=
 =?iso-2022-jp?B?V3JNYnZ1QU1jUm9pSzFlOEVuVitSM0NTY1B3clBFVjAzWmtSVElrc1l6?=
 =?iso-2022-jp?B?Qmx0RXRsNndFL1ROZ0svRUV0NG5ER1FWK1pSd2FhM2VSK0pKUWV3c2hB?=
 =?iso-2022-jp?B?MENzeWgzSlhqbjE5aUo2THJqWlc4d2xkRmZ3ZldTQXRDbEwxTWZ1OGFx?=
 =?iso-2022-jp?B?T2VicSsrYmVNZ3dabTgrMW1INWE2U0VFdnJiUXpPbThpRFB2MkxHU21y?=
 =?iso-2022-jp?B?c0s5TGNXQ2JQQVlnelI4UzJ2UjI4SklmOGlhT1F0UkMrZmJkc3BRQUh2?=
 =?iso-2022-jp?B?ZW9CR0ZrZEk1SFFRd2xPd0JqMjUxQUhiYm50ZXE0eW1TRXMzY0pZZVZ4?=
 =?iso-2022-jp?B?cHJBOEFNaHNjVFNDdGNVTHB0SlpoS1pWbDlwNDJubHQ3Z0crQmpHZXor?=
 =?iso-2022-jp?B?WmoxdFBSeHdCNWxTNzNHcHhUa0JaRGhpYmJFUEFLT2Y2c0NCQmRibzVB?=
 =?iso-2022-jp?B?U0hpVWRaQzYraEVLanhvMzRjWGE2QUdtNVNLOVBINDQzZFpvYm9EVHFk?=
 =?iso-2022-jp?B?alIrZnFuVjBjc3BpSVNiS2tFaDlPNjJPRHkzU1Q2UzBMUzNaN0NURk9t?=
 =?iso-2022-jp?B?bjQxTURsWWY5WEE4bm4ydnF4M0VZYk9UU2dQSXFHUEN6Z2R4Q2hjUk9L?=
 =?iso-2022-jp?B?MjZMcnNzYkQ3NjZzS3F1Q0kyeEUxMTlsdWxrRHhwamhJamxBQ2hLUkZw?=
 =?iso-2022-jp?B?Y3RZQTMzUzMxSFZwbk1MWlNFV2dFaURld2E5TmdiUU5nS1ZOUGtPQ0h4?=
 =?iso-2022-jp?B?d21kUmFXTEZaZ0crSHUwYjJsUjZBQTNzK1JhY0RXYUFJcjY1ckdzTUU1?=
 =?iso-2022-jp?B?NldGeDEyU0g2aVplTjdSTi9ldXQzT1gvYW8wbkdvbFRicE9zTXlpM0VK?=
 =?iso-2022-jp?B?U1FuTCtmaWVkYnowMnA3L25kMjlIMDIzKzRDRit0U296V2ZYVjBOSnJw?=
 =?iso-2022-jp?B?WVZadXNDZVNySkRkRHZkcVZzb0ZwS29rTjlPc2w1L0hmNnVMQm9GVEI2?=
 =?iso-2022-jp?B?VmJqTGw3bEd0NzFsM0IxdVRJQU9OellJVmpndloyWndTcUduemE2R0Fu?=
 =?iso-2022-jp?B?c2RSRW1oV3I2dWlKby9SUFhQNmJLekREZ0M4TCtlUXBKWFI5ZmoxS2Fm?=
 =?iso-2022-jp?B?MisvQlBCN1R0RnRXUmQ5alhDbmlNdUhlYlpKQTA2TmtMZ3lURXQzUmlj?=
 =?iso-2022-jp?B?M2xJcnh2TjAvK2JOOGFFU2tza2NPSFFyb3hFR1JidmJMYUtoSzBDZUYz?=
 =?iso-2022-jp?B?SFQ2VWxFSFZ5ckR1Uzk4NG1SaGRNRnk1ZzljWUtWTjRKM3MrS0ZiR1ZV?=
 =?iso-2022-jp?B?enVlRGUwUDh3cXlXQVBsdVE0WTNSdU1BQmJ1WTRnWEs3SGRuV0RDb2V1?=
 =?iso-2022-jp?B?akR3Z0NvcUgzSHMrcWNHNXlQMno0QjRBSHhBZHhhQ0JyeHFXazREc3lH?=
 =?iso-2022-jp?B?dmIrOGtKbmxUQ1dlSEpsd1h4dXV0VTJmU1BVOC91QjRXMDhwVEF1Nm5o?=
 =?iso-2022-jp?B?ZVYzWEJDQ1VCcEVzR0hPRHUyb2Rydi9PYUExYlBlMllHRGFObXRoM0l4?=
 =?iso-2022-jp?B?Vm5MU3U2YlFhVGVaWXpmUXFtTm9hei80anJRazF1L2NTQzVYb2IxcWtP?=
 =?iso-2022-jp?B?NUZEN3dwNUMzUDFzYkcxWGg0eERHd1FYaDhpQm9XdVdzZDkvc3JyMU9y?=
 =?iso-2022-jp?B?YmpPc2JhRERnV0k3MVJ3aHFhSmxTdlFXNWxPRjFFYkoyZmRyWUg0ZHhD?=
 =?iso-2022-jp?B?aDFncjA4TVhlYlFkNzVJK0NtcVhGR25HZEFIdHM3amF2TklaaG9TU0J3?=
 =?iso-2022-jp?B?cjE3NXowMWEwdE4zTWhsVEFZRjRZby9uRmFnQnNLMWVpV3dmR0lvdUJo?=
 =?iso-2022-jp?B?NWlaak5IWENCUVdTZGFXcDhkMTNNR2dVUjZraC8zWnNDQk1QaXBWSmxW?=
 =?iso-2022-jp?B?aWErRGhLU3dYb3lLczhaUkg1RU85SDhzTFJXVVQvL0R5MDJaaHdlWUlU?=
 =?iso-2022-jp?B?dGhkK0pLaVlERWJ2MDlJV0tUWWV6cWV2UEp1VjdXYVFoWHFTYTNRNXpK?=
 =?iso-2022-jp?B?NUxPYWpROEVQT0NSaisxU2YzYmQ1Z0FUYlZ3U2did2ZESm1lU20vbDV3?=
 =?iso-2022-jp?B?TmFUSjdSWkFxb2UvUWhjTElYelBUV3R4cXdLZThld1NXOU1FSnI0aFlZ?=
 =?iso-2022-jp?B?VWxMTGxMRS8vVlBhWXJCY2pVeWRDcWp6di93OEFDa0pRNDNua0pTUk0w?=
 =?iso-2022-jp?B?WlRXNg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qM1RRB1TtqmbSzqU2J+/mqm947NYZkDLw7uyyrmMynbHa3aMK60oR/YfVZW0b0i2CLSwv9pw5B+N6QJ1T62wo8X5n5QfzBK2cP9/beM7bzIfKZrmP6cy/S46Zb1r9FTLaaPVZah9Oh33EXZd/5iouK8KRGy3nJiD7V9KRrH5bGiK+hH10hKIRqxjEIEbBnf2Lqlz2VOWur8i2Z1qj1XrGYjEacYxZcxz8RiQI+ThupMWxZMygagcs6U3AaPb4iMKIPlJ8DbKulIoSUYbkD/XWEVWpLC9JFP/9AcfVPq6s3u7OUCIgW65OSbmpk4MNYolYt69+aL0CpQmSU2B7Mv/CrvnnFMWpWc4UE3I6foKK1vpZfQcQ08U5zOPxISukKZ7jX6pRfqraMWfCIV1PB1F+v9M7TCMaQPRoClL9Owx/8nOwPHN0IxFK4odXApvmbJezVaDpguDikfjGEd9jB9MBIIX1P9ql+8Fp7IxGhhaaybdIM/oPqk+g+BZexKg+SFEHioDFvQkFtAukZx3K7GZmH3kwf1DUp1Q96EMYQuQPBB5r9rK5LXTirigGh0DgZjPxt/xZvuwHnEaZHOq/MbBVh3wojxJ1/uiDndFKVRX8VDpK1zTyz0CZCPr1lg/Vbaz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e8ccf2-72af-4f1f-12f0-08dcd2d45d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 02:41:11.6281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xn45no6sTJAdNxcFjNWlWsR2Y5HfVApSzULqepcY7hFJ1NcCg6urrmMV6oXZDAOcNXlEW6zCKmwT/fa6l1xiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7844
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, September 10, 2024 11:17 PM
> To: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>
> Cc: marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org
> Subject: Re: [PATCH v4] pci-bridge: avoid linking a single downstream por=
t more
> than once
>=20
> On Thu, Jul 25, 2024 at 05:38:19AM -0400, Yao Xingtao wrote:
> > Since the downstream port is not checked, two slots can be linked to
> > a single port. However, this can prevent the driver from detecting the
> > device properly.
> >
> > It is necessary to ensure that a downstream port is not linked more tha=
n
> > once.
> >
> > Links:
> https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8D
> DC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> >
> > ---
> > V3[3] -> V4:
> >  - make the error message more readable
> >  - fix the downstream port check error
> >
> > V2[2] -> V3:
> >  - Move this check into pcie_cap_init()
> >
> > V1[1] -> V2:
> >  - Move downstream port check forward
> >
> > [1]
> https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujit=
su.co
> m
> > [2]
> https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fuji=
tsu.c
> om
> > [3]
> https://lore.kernel.org/qemu-devel/20240725032731.13032-1-yaoxt.fnst@fuji=
tsu.c
> om
> > ---
> >  hw/pci/pcie.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 4b2f0805c6e0..1e53be1bc7c5 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> >
> >      assert(pci_is_express(dev));
> >
> > +    if ((type =3D=3D PCI_EXP_TYPE_DOWNSTREAM || type =3D=3D
> PCI_EXP_TYPE_ROOT_PORT) &&
> > +        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
> > +        error_setg(errp, "The port %d is already in use, please select=
 "
> > +                   "another port", port);
> > +        return -EBUSY;
> > +    }
> > +
> >      pos =3D pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
> >                               PCI_EXP_VER2_SIZEOF, errp);
> >      if (pos < 0) {
>=20
>=20
> But can't there be two functions of a multi-function device,
> sharing a port?
Good question.=20
But I am not good at PCIe protocol, can anyone give me some advice when usi=
ng the
mulit-function feature?
>=20
> > --
> > 2.41.0


