Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC916C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 03:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgFLx-0001lx-37; Mon, 19 Aug 2024 23:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgFLv-0001jx-2J; Mon, 19 Aug 2024 23:16:11 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sgFLs-0000Tn-52; Mon, 19 Aug 2024 23:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1724123768; x=1755659768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VDEmCn0xGoLe7JDGtcYuGgjtX44FEoO4JBmdeOmKouc=;
 b=FoigVjvZ89yevX1rL01E/GcFmX+wyug9Csf6rb7LAehaF29Ga00xWkGM
 elJvDmSHca15M6TyuMzQwbZvXzuPP4/JWvtW2ItpVPidRuEAD67PcAEgZ
 qiYTB/Y76UKkjvWswqWDc1o/AVJmx9jxwVJqAuynujc1VkrFMj4ip6x4O
 MuwrjQcXPcDMJDeVCliiA58YPBRxxcQKoTJ8dGb7SzFxnXqa+gb8g18g8
 p5GdrtBl0G74RmoFm//EctMrG2d4w9harS0qYbq9mG6qmwhpqPakyp3K5
 dIMPcgJV27/SYkXB8sW4bKS8z9cY1WIFWBQbOxdLnmQbkW4JPZIsLr4ts A==;
X-CSE-ConnectionGUID: njHBAZYKQ8iZWuyoE4SH+A==
X-CSE-MsgGUID: +Gf2RpLyR/WEzW5kDCsD+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39554701"
X-IronPort-AV: E=Sophos;i="6.10,160,1719846000"; d="scan'208";a="39554701"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2024 12:16:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx1QB34DWlIpmUvkynuDozDgNvJWGZu7M9dF9QUA5GkgBRwS68YX/3Uym0RNS2QZ6OlkQUO6KUJNexdhX0GuIlXSp7gcjIbEAbG1wma3kPCqmu4pAGMUNTtI8+8MWDxbW2zqDWmsWDoIMEiJAnhENXg7x35aIT8hMAOYel9WSz3aELiMPnAVc3mToD9dU94exfTVI4ngJhgiV1pUaQ72gPFrVrnqDng5ZUwmDclOlmcIaEzlSFWANImilMDvBVbHnHWoGFD7KivQOEzz2xCOgQ4wiRLTtd5LFhUsKCxb3ENaZDF/RZBrkcbWDX5S8LDQ0GVIL8OFPJuhWyDFy989Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKPY/pGv4r8AF4qZQ5Gg7pFq0pP5amfJqMLQ5KqIJk4=;
 b=NR4Ep1KsG84cM5dzwEjABQIJ2oJL9cW1uWQKJ7Lf4nkVasfHz3NCH5W5X0lRMzp6jBKn4PkB8wIDZyiGH5VV/B8i8n0qLXOXgneQxhpD123rqTVBROu3Mkvx2dd0LElTZofo7mwp5BYw7b1Jt1ZKIWaoz9NjczwiTNGNvW4ByJdlX00Lp+Otb5dh6YY4WqL9vwnCFolQBl6k+y5BGUGt3IzDmDR8r7DbDCwvkBulkX7drP5M411CUWCsr1Tj+IW9+nrrizYCL84CxabeeYmwjk4JAH8vKrwkf4lY8AnFKCoLSZVV2HcfwQPuvGN9mbxjgJdyYpqhlchkABsPFmSQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OS3PR01MB8684.jpnprd01.prod.outlook.com (2603:1096:604:154::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 03:15:59 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 03:15:59 +0000
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>
CC: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [PATCH 13/13] block/qcow2-cluster: make range overlap check more
 readable
Thread-Topic: [PATCH 13/13] block/qcow2-cluster: make range overlap check more
 readable
Thread-Index: AQHa2+zzBVZvCSu+tEyjYfkVkOXtcrIvpplw
Date: Tue, 20 Aug 2024 03:15:59 +0000
Message-ID: <OSZPR01MB64537F5167D5A65C45945E868D8D2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-14-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240722040742.11513-14-yaoxt.fnst@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=f4d71c94-2fbc-4e37-9d51-6cab421ca88c;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-20T03:15:40Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OS3PR01MB8684:EE_
x-ms-office365-filtering-correlation-id: dfdcb394-cd11-4e86-e282-08dcc0c66a1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?dnZ6M0Z5cEFHb0RJLzlFemhiOUp1dzBxR3RZWTJDc09CUGl4NkZFYmFY?=
 =?iso-2022-jp?B?NnRQWW1mdUZWYVpFbEtKb3BJSjl0RVlQRFJsMHVFY1lPOXRyUmxhRExq?=
 =?iso-2022-jp?B?d0IvSU1aV0dUbGV5MnMrMHloYVVkb2EwbGVqN1NTQk42R0xDK1MwQXNZ?=
 =?iso-2022-jp?B?S1dSRVc2WkpGY0NVOHhXK0tZeTcwWm9rQlptV00wUDdsMU9ROUlJN3N0?=
 =?iso-2022-jp?B?YlNKU1ovVUYwVjZ3WDhXYVBHbmJjcWN0NVNEV2ZRWkN5eDZzU2IzYjdY?=
 =?iso-2022-jp?B?YUdxR0o1WXFzYUJEUWRobnJUVXV5Qy9rTm80OE5veTdWOE5VRTNtNjYz?=
 =?iso-2022-jp?B?OWU1NGJJY3Zvd0VTNnh0SW1NUTlBai9PZEcvRGNhbEFWV0pyK0s3K2Jj?=
 =?iso-2022-jp?B?bGhqVHNtbEJIb0ljdEtoM0w2VzVDRWNkWWdDbGNHNHZkbnNRem1oekZ2?=
 =?iso-2022-jp?B?UzhTQVptRE5sazU0THRyMFFGQXA1ODJnOEl6WjJkMU9JWUxVNmszNlc2?=
 =?iso-2022-jp?B?MFNyWWRYdEp0dmVuUG00S04wRE45NlFoNUxjdHdEUWsydzc2cUlDSklv?=
 =?iso-2022-jp?B?SGZNd0ovaHhYUmIxWVRDYW1ZMk1SNHhTcFhydHVqV0VtekRleWp0dU1U?=
 =?iso-2022-jp?B?TktoTElyMzBieHo1UFllOEJHbWZWWHI2TXh0WllQdlRYRzF4ek1Kb1J3?=
 =?iso-2022-jp?B?SWppNjRlOUZobm9ROCtsaFVxVlo4YnhCTzlkdVB6dElxSVl6TnNNaStT?=
 =?iso-2022-jp?B?MWluWW5lUTBrVGZIVHZYK2VsQUtaOXp0aUJieWdVbnRqL0ViMGxwb2Nt?=
 =?iso-2022-jp?B?bHJySzFFMXo2Yk5TMlFydDJpK3I5bjlxczUxL1JkaGVUV3lFMFJPQ2dN?=
 =?iso-2022-jp?B?WnE0ekFFMWxFS1JQb3ZUT2ZCZ1hTZjRJWXExY2NPNVAzeFBlQnZaakRP?=
 =?iso-2022-jp?B?VXN3UWtNZFVPV0xlVzVrRWplT2w4dW9JOTNhQm5ZVW5zT3lMeG9EUGFK?=
 =?iso-2022-jp?B?eFpORkcwc2F0b21rSWJDZHBNVWVMT1czbU9UWXFqUHR6RlFDZHlSZkd5?=
 =?iso-2022-jp?B?c0ZLVWFwN2JxSGVadnNLMWVJb21iM3VocXkwZXkzNHk0SitSSUVxSnBq?=
 =?iso-2022-jp?B?Tk85dkhhYW1VNW9Xa0RodnRkbU94azYrYjFQcnQveDMreGY3am1HRCs0?=
 =?iso-2022-jp?B?SFpXUnBXdTZJSElVdkpOMUNHNDhTd0YzUFIwalVYWnVoQzBIellPQkxi?=
 =?iso-2022-jp?B?K25CbEdGaStwaGFrU1ZocDg1Y2xaK3JmRlA5Z3FMZ1JORzBxb2o0bVd4?=
 =?iso-2022-jp?B?Um5ZaEhZaDl5MXY5UWpyeXg2V0NCdEo3NFVBMWIvK3pFZ0hBVzNwVUNj?=
 =?iso-2022-jp?B?ZThPZ2tsak55MHovR0JCdjNFc1FuSndhK1NZbFJocDhTNXBpYVltbFl2?=
 =?iso-2022-jp?B?TUdTT2lSbmg1aWpGQ3FncDNFQkpmRG1hWkMwUjl5bDNrZnF5WkFObnRz?=
 =?iso-2022-jp?B?TlljSFRnQURNUzJHbDFjRDhvUVNuUlh1d3ZPMnFRQTVGK29jMy9SVnh4?=
 =?iso-2022-jp?B?RGhCRGUwYm8wcXBhc2RBYU9hQnh0TldXckZwS25jMHk3dW5CVWFSUExZ?=
 =?iso-2022-jp?B?bEl0ZEtyWWxIT1dZV0NPTlE3MU1YeUt0NnRKR0pwS0JCUnlqQzE0RUNV?=
 =?iso-2022-jp?B?UlVpaUxITUtHQnZydmtrejgvNDVrdDd3elVFN3NteXRnMXQ4WjdMMGdz?=
 =?iso-2022-jp?B?NFN4WjJnZU5wdk5TUTE4LzcreDVZVGZ0MllNNUhidkI2TUpYOVdsNGFU?=
 =?iso-2022-jp?B?U0ZORWN5VWtHdEZWZzI0TDVNQlgzdi9QdXJkR3VnaU5yMjU4NFFZRDdo?=
 =?iso-2022-jp?B?K3dCbmg4Wi9ndXg5U0kwT3ZKbnhEUmxsM0c2b09jR3BrTi9RRlp6UFg1?=
 =?iso-2022-jp?B?QXNlTGNsa2ZZRFZyOXBUMTFsLzFOaGJMZ0NwUm5RU1hXb0d3QkhtYjRB?=
 =?iso-2022-jp?B?VnJPOFNCUWxGVHcwZVNqZjlQeG4zNWR5WTluanN0ek1vRlFsT2RZdWwx?=
 =?iso-2022-jp?B?VFpLblhYMnc0L3JkVUhZdXRxbWlHSDg9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VCtIUis5SlJrNDJVTlNuMjBxK2lFTHdnc291MEZFWmh6bysrcW5ST09R?=
 =?iso-2022-jp?B?TVdBK2FPSW5aTDNrQjFybEdOSkFYTXdPdUFhc3dlSkFLNVU1clZUeGc0?=
 =?iso-2022-jp?B?RDd1QisvdkZscmlCSk8xRVRSN1l5R0pkRDNDSHVVODZLQzB4TzkrelhM?=
 =?iso-2022-jp?B?d3FFMWYvR01RUzU1QzdqYkVrOUlZZWVBM3ZTZ1BHblZSRVVQeUF6dk5s?=
 =?iso-2022-jp?B?VnVtZm1vVjFpQUxMUWtpaFBzVkNrRjlNeXNpekhDejlEdDhCMU5oUVpi?=
 =?iso-2022-jp?B?OUc4b3NoZElCL3QrdHFGVko1NmZHWmt0ZUdKZ1hzQWNaL0dmcUF0MTZu?=
 =?iso-2022-jp?B?OGUvcldUbWxGSWdXdkxXdndhVmwvOHhmWVE5NC9vYyt0VnhYVm52bFZl?=
 =?iso-2022-jp?B?Y1J3WS96dXpqRFk3cGlzeFlkQmkzN0p6dlgreGRnZEkzdVhibVBzNEla?=
 =?iso-2022-jp?B?SmlEdHJaV2ZpYXAyR1RLZ1VJOEwyaFR3QXQ4RWVXcExwOS9nekR0aTI5?=
 =?iso-2022-jp?B?aTZnSFZZRFlKZVFleGU5ZEdHNlQ3RVlrcG5OanJNaVZTMENNN3JWTFZa?=
 =?iso-2022-jp?B?a21XM3RFZjVSTCtvaHFBMzBNK0pmUll1QWs0a2grc1RZK09mSTdWZnBH?=
 =?iso-2022-jp?B?dVpBZWduV0Y5QXJTcDM0M3k1aEdDZ2lRRXJCWmdlSTRieXVlTHZrNUVv?=
 =?iso-2022-jp?B?R0RnNzVhL2d3SUhtNUhudnU5ZXcxQVJycmM0V2taQVhieFd5WXNjb2RL?=
 =?iso-2022-jp?B?RU45R2Y3QWhjTC9uUzR0T3hUa09DSGtwQmRNV3k4MUpWemw2M3N0emtS?=
 =?iso-2022-jp?B?dTV5V0hZQ3NuenlEUkFOTkt2YUN4ZFp2K1lPbmFnUFB0Q29RSEM4S2Zz?=
 =?iso-2022-jp?B?M0FWT2dhbTkyLzVxYkhxcGo1T3F3ZUNZRFNBNDBpbk85RzkwdldWcGtG?=
 =?iso-2022-jp?B?dkFrQTl5a1JpQnpPNWpJTktONFN5Mkt0cTlySUI4aTF0dDhlSE9PMHN1?=
 =?iso-2022-jp?B?djdKdGkxbXdTK3dmR0JGdC8yRGlJWHdOVlduZHNVc3JUMldud0tSSDRw?=
 =?iso-2022-jp?B?T2xpYWFzR0NlSjRuYWhrZUNRY0dQNnhTNHNmbzJRZUl2UDJoRm82L0V5?=
 =?iso-2022-jp?B?QnR4OXNaNFhpREJuNEFkL2dicnpyUEhKN2tvUGtpdC9wdmFWMkVBZEJU?=
 =?iso-2022-jp?B?dTB4RWNnUFB3WW9Sc3h2MnlEbE1CNG5hTnNKbWx6T2xlSkIyZ0VmTXVF?=
 =?iso-2022-jp?B?Rkphb1RYRXZqTkozb0swWnlIa3FMR0tzM0J1dmtiNG5LYjc0ZmRNSGtz?=
 =?iso-2022-jp?B?K1hJYWp5eVhwTFFRNlhwZmNBdEh2Yy9mUU9kME00NmN4bUpzdjJIUjRp?=
 =?iso-2022-jp?B?REdrbmFQVHBMcHBVdUNMRlhhaERGb1J0S0RNRGNMTlhqa3NzOHZjRUpY?=
 =?iso-2022-jp?B?YkRBMXFoSnpZaWZtRm5hMSt5R3lnTXp6aE0veElOR09iSlZHbGlPWjE4?=
 =?iso-2022-jp?B?MEl3a0hSNUtXRVZqSUFhZm5iQm16ZG1JVmJnbzB1aU1mN09ZUnVxZnpC?=
 =?iso-2022-jp?B?b3JjbHJUUlczNDZIUStNSDlqbkEvdzl2dUUxOXJVTDBIS2RXR1owY2RQ?=
 =?iso-2022-jp?B?bGxpZFpUV29URDZkZWtHQmxjUXFOOTliOWozYlNlejJoZ25QM0F0K3hS?=
 =?iso-2022-jp?B?WDU2S2xldFA0dnNZb3M5WDRIZzlWdnNKclJycFhLeWU1S1FTTkd1SGkx?=
 =?iso-2022-jp?B?clczU1pjUFYyVGhPRFlpNnRIeHNPT3MwRERmcFgzNTJub1pQNkUvSEVO?=
 =?iso-2022-jp?B?SkJkYnQrNW13ck1LZElBcWNBdE82WlhUVFdvOFJEQnZDNE9YSmE2c3l0?=
 =?iso-2022-jp?B?Um8vaFBwZHorMERlTXZRNEplYnliUkdIa1VQRWNjU3pPVkx1djhYL2JU?=
 =?iso-2022-jp?B?dSt4bUNoK2RpLytQMUZIVzNtZ28vWmtDU0lrQ0cxWTJYS0phY2doYitn?=
 =?iso-2022-jp?B?bHA0b2wrS0R0aXdlVWI4Nnh0M1FsVFlZZUM5TDRuWkZ3eWxTZFRNZ28r?=
 =?iso-2022-jp?B?TUlDdFZNWUtudWJTTlYrdHd1Zkw0SHA1bGp2TnVHcVVqTml0OHZwL29y?=
 =?iso-2022-jp?B?aXF2MW1QZElHb0tvL3BZc2NzM0h1dWMyejEzc0JkOExXZ21CMitFK3hr?=
 =?iso-2022-jp?B?Mld5dldyTk54dWxJV2ZNOVRZZUlWRGlKTzVVS3hHSGFxalMrYnRnc0pV?=
 =?iso-2022-jp?B?L0JmQXUyMXZxYWoydjlYYU55a21SQlY3dm16ZUxKOEUzQkkxSGhhSHM5?=
 =?iso-2022-jp?B?RkQxNg==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E2hr5evy/pB66xTu9wdzCU7c6MVqvbEaHn8SCaRzgyKy4rAr3C5vyQ7WRnu+ekomSIio1nSEVJ8IaacKYF9KAJoi/PZC7CAlPPlKlZVAQN1ov4B2+IWpUzK+WUgX3jN4+uTa5uTXzA8y+QEUO8w+nPCP61lxkVPm9MDWN2Rv2VWUnHhMUBrapJP80gil8q2uz9LFhK3BYbv16f4geCUUXv+vXn/C1kQXk32WTI131p4WQ5ZnyfGqGKZV2VR1ABr3+Q3Y26DmmuCkDZIm12B+4WrYjwN+UhsayEClwnWyIFGV+spd8n0Y3JNYnRSW40WRsooUIHrsPJVth1FFadXY26fUWBxsTq0cBawBp0spUnE/uccbGeILqa9p/MDlGgwnor9mxTVtZB2xVIEA1lfBlb1ddOpEcPeRZ6Ua8RLC4k/kk8qmtRYUL1MtySk+uag6Rh8kracopGBcwNkw8t4Wpa6n6FhWuX5pznuVfis/aAK3Nrvu9yle4hvdVTZ/gLxD1uIZ2yFIVjvr7VE7dMrdC1DfvT8ITrTtElfVLDbLG7LFK/Tf+nFc8g12rBLkWse9Y+4rwBmTLDQJZl7GFXxbrwPy6oFBdzSzRzj2TVEVUZuUii6hZTVvlRgTgdwwQAZh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdcb394-cd11-4e86-e282-08dcc0c66a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 03:15:59.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzqWT6BEOa9gMiM/rA8nP8jTTJJ5yj9kfK8C9lLW5r19d0/mtM05JkvMZ/WVaBwb2KiWR7nOL/yo93RzpGjgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8684
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping.

> -----Original Message-----
> From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> Sent: Monday, July 22, 2024 12:08 PM
> To: qemu-devel@nongnu.org; Kevin Wolf <kwolf@redhat.com>; Hanna Reitz
> <hreitz@redhat.com>
> Cc: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; qe=
mu-block@nongnu.org
> Subject: [PATCH 13/13] block/qcow2-cluster: make range overlap check more
> readable
>=20
> use range_overlaps_range() instead of open-coding the overlap check to
> improve the readability of the code.
>=20
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  block/qcow2-cluster.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index ce8c0076b3b5..88d65c4b99e6 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -30,6 +30,7 @@
>  #include "qcow2.h"
>  #include "qemu/bswap.h"
>  #include "qemu/memalign.h"
> +#include "qemu/range.h"
>  #include "trace.h"
>=20
>  int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
> @@ -1408,23 +1409,25 @@ static int coroutine_fn
> handle_dependencies(BlockDriverState *bs,
>      BDRVQcow2State *s =3D bs->opaque;
>      QCowL2Meta *old_alloc;
>      uint64_t bytes =3D *cur_bytes;
> +    Range range1, range2, range3;
>=20
> +    range_init_nofail(&range1, guest_offset, bytes);
>      QLIST_FOREACH(old_alloc, &s->cluster_allocs, next_in_flight) {
>=20
> -        uint64_t start =3D guest_offset;
> -        uint64_t end =3D start + bytes;
> -        uint64_t old_start =3D start_of_cluster(s, l2meta_cow_start(old_=
alloc));
> -        uint64_t old_end =3D ROUND_UP(l2meta_cow_end(old_alloc),
> s->cluster_size);
> +        uint64_t cow_start =3D l2meta_cow_start(old_alloc);
> +        uint64_t cow_end =3D l2meta_cow_end(old_alloc);
> +        uint64_t start =3D start_of_cluster(s, cow_start);
> +        uint64_t end =3D ROUND_UP(cow_end, s->cluster_size);
>=20
> -        if (end <=3D old_start || start >=3D old_end) {
> +        range_init_nofail(&range2, start, end - start);
> +        if (!range_overlaps_range(&range1, &range2)) {
>              /* No intersection */
>              continue;
>          }
>=20
> +        range_init_nofail(&range3, cow_start, cow_end - cow_start);
>          if (old_alloc->keep_old_clusters &&
> -            (end <=3D l2meta_cow_start(old_alloc) ||
> -             start >=3D l2meta_cow_end(old_alloc)))
> -        {
> +            !range_overlaps_range(&range1, &range3)) {
>              /*
>               * Clusters intersect but COW areas don't. And cluster itsel=
f is
>               * already allocated. So, there is no actual conflict.
> @@ -1434,9 +1437,9 @@ static int coroutine_fn
> handle_dependencies(BlockDriverState *bs,
>=20
>          /* Conflict */
>=20
> -        if (start < old_start) {
> +        if (guest_offset < start) {
>              /* Stop at the start of a running allocation */
> -            bytes =3D old_start - start;
> +            bytes =3D start - guest_offset;
>          } else {
>              bytes =3D 0;
>          }
> --
> 2.41.0


