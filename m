Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B3C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 09:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkgYh-0006QJ-C6; Wed, 19 Feb 2025 04:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkgYf-0006Q6-2j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:39:57 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkgYc-0003M2-9y
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1739957994; x=1771493994;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MnhfDnkApYyzSiVFDz+b5i9eRytC08AwVfY5B9ic0RY=;
 b=cNSGCo7ADvnhl1IJGQWrSYPVhr43aejaHd70CGhOCWXTn+N2dvFB8dDo
 pTihQwIw8v5Io7UFpVnJ52LJMCKoxDoL93E23qCUICp6neJNzw9G4BtcU
 NaF/3YIy1WrMPlKQMD5KjwFTFAWXRMFd6lAIvUSh/+JTrW6POivnz+tgF
 Ww21MNv5f0q9XjmLkbyZOPbwMC0+RysFa/XFALmwUpFLcYi47NP97zO9+
 JipEfeK0VVPCJh4wAGc8YAcWBwtyLrlp//kXrHEfXK3VhzOO7711b3NnW
 LA/SbPjMde2Ci2tCWghl9bnGtEsVFYxg7XgbUp2f8JoGb3k5E8s3bREkv A==;
X-CSE-ConnectionGUID: xsiaeeluRcqmJp16q2Sdqg==
X-CSE-MsgGUID: 018XPh1uQISHfK9+mphx+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="147772360"
X-IronPort-AV: E=Sophos;i="6.13,298,1732546800"; d="scan'208";a="147772360"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 18:39:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHAIvTi4MfaIQ6i0vp7MRYbkzQ3HVsAcmWSZyPH2TWd6UdTcBdHCKTORdZuT+eynG1YtfRvbDcv0HZ6ZB7dLAXwcTvmDtoCGbunyOBNXZx6dn2AgCzuyeKBauZbR+FY2Wv8nEtPJCM+7ZDl17KLpmex2Ndb4NZm7HbLkjXndUrs9K38lgfZ5ApzMvngFETkx74NdMLrgepwRzo4BiheB8N+rE6UUQtAbI/m9rOneueLO0GbjQNLNAKPVgOwvA05kkfU6CweEUNU9684OgjdiaFve+tdveT1snkY3uZ4RqZzH5Or0NJvv7Rf6np2ec6hgoIcrt0ksnVgmCb5OEXXvFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnhfDnkApYyzSiVFDz+b5i9eRytC08AwVfY5B9ic0RY=;
 b=MvPTmOjOB9BL9wXtGgd5ZKV3055ks7vGBXkAcnEJN9FNcO9NE8gF5izVjldiPfSABlGnuDO7YBnH3ZDES5AnoYZWMuX3h0nCBe45yz/jcTE03fuC0aUvw9qQVjO8LucUBwKQcZ3HCHBTDs9jkGeia5S3DjTiy7e3a/LvRXQQoFYTjcHGgNRwns0nwY6umin5wADYGd+/Jss1Fcs6WmZ/Qz4VfO4F6BP1JLkJqFjUFetw8hEnpqLjXRjTJQxYHDloEOfVNjBSHv9+3hYqo0UCDGT+rgRoXSaqJ6veuPuszETWtsZJ03eoUnEVrVgv37+bIHMbF1mh2dabwwjQTG5ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB8669.jpnprd01.prod.outlook.com (2603:1096:604:16c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 09:39:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 09:39:38 +0000
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
CC: Li Zhijian via <qemu-devel@nongnu.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Thread-Topic: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Thread-Index: AQHbgdim3piD2OfeG0S7XSsfy2LyW7NNhEEAgAAZ9oCAAMJ5gA==
Date: Wed, 19 Feb 2025 09:39:38 +0000
Message-ID: <0930f197-ae7f-4920-bac8-838733683883@fujitsu.com>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <8734gb9erz.fsf@suse.de> <Z7UDtxdNSS-Jqm-y@x1.local>
In-Reply-To: <Z7UDtxdNSS-Jqm-y@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB8669:EE_
x-ms-office365-filtering-correlation-id: 5b22a00a-308c-48ef-7bb8-08dd50c95406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N0o1SmQ1WXYxa3BrZkZTTmcyV1g4bTVIQ09ib25lZHlqSENGK3hXakt5U1Ru?=
 =?utf-8?B?d1c1OEhjaXgzTkhDMGcyakZTQ3hGZXFMNzJEZFZ3TFphYUYrOTF3eUtHUWdI?=
 =?utf-8?B?dkNXT0VJTzl6WkVlU0Vsa2x5ODVUYWJRbEdYOEt1M3JZdUJKcHJnZkN3dHlm?=
 =?utf-8?B?Z1FhSVRIZ2RqZG9HWkVROGNzd2pOaDIxeDZtT0FTYkd0VTlOcWd3SWNMeXlh?=
 =?utf-8?B?SEFGa010ckpMeGxBRVZrZ1JsUEp2Mk9LV3hxZkZSbjc3Y09CNlplQlZ4cEZD?=
 =?utf-8?B?NklkZGxWZjlrbzVJd2h0L3JBWEN3a2lObmZpQW5rUUxzZmNlcmZLRlBYS25h?=
 =?utf-8?B?d2krWjFDTzIxUDEwUjhWSm0rQXl6a2w5SUVaeGVUeG1McjZ4V1JyWXJ1SGl4?=
 =?utf-8?B?RFRGOUpvTVNEQXM0UGMwYk5VWnJ6MDB1d3c4VFQydFBXQ2RXSlpHZ1NYalRm?=
 =?utf-8?B?SUVma3dmTlU3TlFMWjR0czBpYVdLclphbUpYTGNBWVlDSHkyMVhZeE14YWI0?=
 =?utf-8?B?eHdzUzlLc1l4YmJFYittVEFTMmh6UlNMVks2U1JRNkFDUXoyY2tJK2dCWFRB?=
 =?utf-8?B?WjJQb1hlU29pR05Dd0UxOGRLQWZTY0o0OG14ZnNjRG5uNmFlM1hmMVlTT2tX?=
 =?utf-8?B?MHgwa0Mwb1RYYXltR0JQLzNpK1JEaHI4bDNHa0ZWTVQvM1JLOXRjc05jaDdP?=
 =?utf-8?B?ZysxbFZQbFJmaGttUEkvbkhtOTc0bFBDU0JFelU2VE5uK21LMkhoSG53SFQ4?=
 =?utf-8?B?Wno0ZVQwV1RhWU13VmZ2RkFiZXBxTE1pREMyVzQ0NDlHNEsydXhGaTZtUlBv?=
 =?utf-8?B?NGQzUVA5Q3JJYTg3cGZzd09jcFZGNnlDeExBYjhmb2t1dHRCRUJPK0VVWERj?=
 =?utf-8?B?Wk1BVlVGbHE4MExPZVBlaENjM0wwWW1KSWFTalh4WFUzWkFRRm16TzhLQngv?=
 =?utf-8?B?ajVkZmtPSS9MQjZIRVNUb3MxbUIvOWNSeTV4S1loekNBZ1ZiS0FNVU82a3BJ?=
 =?utf-8?B?VjBjZFlMaWhpREtDcWtwRmN3THRyM2wwYUF5S2F6a2krRjZVUThlVVl5Zi9Y?=
 =?utf-8?B?YnBhRlBMaHdrQU9ZRjcyb1BXbjEvaXJ2eVNFVlBlNVBYRit3b216SkYvaFB2?=
 =?utf-8?B?S2xaVTV3bkNQMHQyWFFLNjloQmpZNk5zTnlkTllBeStidDIwZXZtRnBnMDRo?=
 =?utf-8?B?VTFkUEwwS01EVE44K3RDL0N4S2lQZ2ZJQ0dqVzBIbnEwM283L0NNRm8raWpE?=
 =?utf-8?B?QWdDaVUzZDNqbHRBMlh0UVhqMWRJZ2kwV21XcVFpZU9yRERRZDZESVVWV3hB?=
 =?utf-8?B?T1lTcmxCNDRwSHY0aDg4aHMrR1M3Q0pkTnMyWkdRZ29ZdGVEaTBNWUZRSjQx?=
 =?utf-8?B?eW1GR1ZVZjVGcFloOFpUYnFNNlg3RFQ0eTl6T3BSNDhGN1dZbzV6VW5kNzBK?=
 =?utf-8?B?TXVBbTIraEZjRDhYSnZ6WHFxbmc4d3lvSVBGTUlxV2VsRDVtOHg1aUp0ZHhC?=
 =?utf-8?B?VXNsaUNRdG5mb3E0MldheG9UcFhJK0lmTlJyZ1p1TDM0L2xsRnJrdTBTZXBn?=
 =?utf-8?B?RkIwTDJCZEl3enkraURSUjVFdkRlaEk5eCtxNFdaekxEYjlmaDRVL29WWWMr?=
 =?utf-8?B?V0ZaNnFqVVpZWUMwSDhFTHRNNVU5cXlBQWRacTVubDdyb3cyYlhhMTRPWTV5?=
 =?utf-8?B?U2IzREV1bnhjMW5uaFdZeGpVQ1lRNFlxdGJFYzcvM0dENDZWWW5MU3d3Mk1T?=
 =?utf-8?B?VUJTTk1NeVdWbDFrU0o3dFRBUUxKZldDVjNCKzJrUlVKdHlMWWtJTndBMGVk?=
 =?utf-8?B?cUJuTm5Tam1hRlRHMllHU0dHamU2YUMxdm94TGxwY01iQ1NGZVJQcG92anBM?=
 =?utf-8?B?cVlweVo0RlNuNHdCZXY4TEFMK3FrbVFJMHdsSXFPS2lZYmNXL2xEZXhtS00r?=
 =?utf-8?B?VENBMkQrSHQ5OTB1Rzd2RGlCcGsvUkU5VEd0R2g3V1pmalZzN3J4UW5jQU8y?=
 =?utf-8?B?Q3huVXJnenBBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjVoM3JSRG5tT0dWOEppdnNnUWhvdG9VK3ZZaWI0NVc1ODdaRE9ST2o5ekJp?=
 =?utf-8?B?ZngzVmNocXc4ZG5CbmViN0VxVkFNYjlqUHIvdDBmQlI3T2Y0OGtTMENTUXZT?=
 =?utf-8?B?eVZhKzZRUjBRbDZpNEcyc1Fad1NwZithTDhNMWZCR3lTdGJzT1hzL0VNL3pY?=
 =?utf-8?B?Q3YxQ2pBOXQvRWpsYnZQNktUWkJYd1RvMU5EQ2tJK1BXYU1sazhiVStBZHZN?=
 =?utf-8?B?NDQ4UUpUMk1EZjJLQ0ZCRW1yUC8zS1RHRGRCOEpQNjAzTHhLOU0vTE4wM3ZV?=
 =?utf-8?B?a090K0cyS2lyLzJmSFNsZWZVa3ROZkRtTUEvWVpjT0VPa2FsTkR4SkF0NDFN?=
 =?utf-8?B?YlpZbm1VUHNXNnJwWERvdklkWmhVM1paSnIrUU9PWk1XY2VZaUVKZm5rT2ts?=
 =?utf-8?B?K21hem1SVnpJOEE1RGYwOW1XS0d3bG5jS2N4U01uTzgzMHhMeXBnbmQrVURR?=
 =?utf-8?B?c29uSTRXZm1hVHE1Wm96RUVFdzhrVXpHYk5SVGZMTG5KWnF1SjNNQVBibEsr?=
 =?utf-8?B?VndJaFhKdTdpKzViTzZNMXFhYy9XOWlsalROUmVUVjgzaXRzT2t6U045cE5p?=
 =?utf-8?B?Zy9XdDRWeHd3dUhxL3lpT0R1TnYrV2JxS0kxcXQzeGJGL1BUMFZyOTFxZmZG?=
 =?utf-8?B?M3ZmS0ozTHY3ZFpaVHZnQWdoUlJLMWpRRDlEUE5NR05QT3RlblVUQkx4emxy?=
 =?utf-8?B?K05obzhTRGcvRVg0UXpPSmZHMGxhQmZrTGtheUQxYWs2djFXWDNBdXBXVFhs?=
 =?utf-8?B?TitiMFV5R3M4SjFmb1RYaWVyYkNIdXlGYks5dGZPTGZsRDNvbEZ6MWc1MXZt?=
 =?utf-8?B?RElocG9CRldzcE1NNXBxZVVzYncvTWhhdVlRcjZ1Zk1ocStXS3NqZE1mZ2VC?=
 =?utf-8?B?UjlNRXE0bllpTUhPaktiWVMxU1lpUG9ScUtrcExpbU8zV0N1eHpPRWo1R3BH?=
 =?utf-8?B?Q0RUek5Ma0o4bzk2eWg3SWZWYmRNMllxNmVBZjlET1BJa2VPYlRjQkIyWTJh?=
 =?utf-8?B?VkdEcmMxM2p4dXJVTTBvRGFSUERxWDdHclFDT2FHQ2JVcTZybVRObWtPS0RF?=
 =?utf-8?B?OHRTS1JoS1RZQVhyekRPSS95WUFzeXRzVlJYUDBnMmZNT3d2OW40NE5VbnhS?=
 =?utf-8?B?S0JOTmN5cDJXRWQ0ZVdxWUQ1UlJpczV4VEczWXY4SThKLy9iSUlpK3lqTFJN?=
 =?utf-8?B?VER5WkpuYXJwUThUb1RkMzI4Y3dPSEdjOVkydjNYSlV2R1V5SGZlOElLTmFa?=
 =?utf-8?B?TlhIQ1U0YWROWFlwY081bnNrNkhYREpWN1JpQVlQb043Y0k5WTBqdGdXSFRK?=
 =?utf-8?B?WmZmaUZiUDhJaVhaaGhVV0RCWHJCUjNKT2IrYUorY0p3bmQ0dkw5WjREZk1M?=
 =?utf-8?B?clhQaElNMDJuRXJFeXROMXRSUXp1cFpkTE9IazdDeENPamZYVzhxT0ZaM21U?=
 =?utf-8?B?cWdENmNqeWNWOHFORk1HbHRtUEdoWTBCd3RwcWpGWUxRKzhFOW5xcHdBbTI4?=
 =?utf-8?B?ay9uUGRWWGxmc3p6TTl1R2MxTHVRT3RZWUdsZkFIa3BMZjlOSC9aS3R6cXRI?=
 =?utf-8?B?UmplSXlJUmIySFdnanJ2MDJ2djVOTkpld0R0Vi9SRFdXL0F0clJDNWpSVUZq?=
 =?utf-8?B?eC9jZzhkd08xWm92a0pOdkw1Q3F2am9KMmw0Q09yQlloaEZZQURzMGMxcnRo?=
 =?utf-8?B?NWVtdERkNTdwU204dWNLYzNtLzkvemY4bUdrOGw0RWZnbmg0bXhBR0d2c3lY?=
 =?utf-8?B?RE1zazc3V2ZFRWtFczE1RW5Cci91Mkh2UnF2WXNLRWRBKzExTGNTU3BxdCtF?=
 =?utf-8?B?MTgvWW9vRGI5RVNXb0NsWEpxdUU5aTBvcWR0K2tVaTgxdXpDMzFyK0cxWEVD?=
 =?utf-8?B?dW5JVENqQ1FGNnY3U04zWjNSUWJjMnc0RlFuZUlBb1BTUG1Zc01ZMmh0ZmMx?=
 =?utf-8?B?NDN1aHV0VHprbHk3MTRndHI1ZlppN1pvcjBqZ2UrbWZ6aGtJaTZOaHVkU1Mz?=
 =?utf-8?B?cHh4ZEJXUzlhYjdoSTJFMXBBR1BUZWwwZEZvU1NyeUNDZk9LM00yMzdWQytO?=
 =?utf-8?B?TTR1NUhldWl5am5yemRVdXpvKzBRMUFwcCt5VHpoOWtxWDZBSVVrVit2M0Rl?=
 =?utf-8?B?MDZTMGhRcEh4anplUU9YaUR6NFA2OTIxRkwrR2RqbXJ4V1lOc2JzRVhnQXFD?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30C473C381017C41BC1DF0B636DBCAF8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: urjQNDBMScthZR1hgQ4g17SVl7wBVT+6dYs3QioYInIiJ76HB/g27NfAbvMlfpUbM4HhgHErDCLpyzLPVNZqrISIBWoQnbdGaadtJXIxl7tjine2EI0C4yJaN2+kMXuaAvobBg7htOhvu30p6Yekd7OGckTA/SBDN5AwBBX/qBDuXiy0+YYUgOX+ssjD3/QvVD7G8MeoHKCmswOpIMMwWCwK4g20jy4HKZOQZF22tmeurqwkoFcY3lr1EbcupN8YiyNyVakNNzpiWUwodzJQBRlzbcNGGTaD6MVZoxTfXniUiEK84BqBYmhC3vjqgDw6mMLS+xBx6bhP1EVSrlgSHapYXoMMn3+tbqkg5F1wWmwoqdrapd7Ax8jP2eSqqATeXU9iof6+1nusiAkcA33aH7XYDZOd4SZENd7Jq+XHSa09B9SSBgn9kaYeiOgTxUX7TkVdpbX37TJTs9g57mspay99lSHyIDkn1arwT1QonECWGZWUUUDl++E/rixSqB1DuggoGMX6jvpdd8kzr8OxkxNQ13zU8k8MVA1d24plZUCFWTCHT0XB9bzDG4DMFHrC19ngHPCzPPYYa12yEqug2MCfHX1iCCFQ8C5+ptu9HnefdqZkmnA/bdffPyQyEGTe
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b22a00a-308c-48ef-7bb8-08dd50c95406
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 09:39:38.4286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zqh3qkO6Wfw/0jNugHabPzZwEeYNWxMN5O6uf2nNgtnczH9S+m8NwXCCXDgRBkpav81SqG+fD3tR7nlrTBE7dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8669
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDE5LzAyLzIwMjUgMDY6MDMsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAx
OCwgMjAyNSBhdCAwNTozMDo0MFBNIC0wMzAwLCBGYWJpYW5vIFJvc2FzIHdyb3RlOg0KPj4gTGkg
WmhpamlhbiB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4gd3JpdGVzOg0KPj4NCj4+PiBBZGRy
ZXNzIGFuIGVycm9yIGluIFJETUEtYmFzZWQgbWlncmF0aW9uIGJ5IGVuc3VyaW5nIFJETUEgaXMg
cHJpb3JpdGl6ZWQNCj4+PiB3aGVuIHNhdmluZyBwYWdlcyBpbiBgcmFtX3NhdmVfdGFyZ2V0X3Bh
Z2UoKWAuDQo+Pj4NCj4+PiBQcmV2aW91c2x5LCB0aGUgUkRNQSBwcm90b2NvbCdzIHBhZ2Utc2F2
aW5nIHN0ZXAgd2FzIHBsYWNlZCBhZnRlciBvdGhlcg0KPj4+IHByb3RvY29scyBkdWUgdG8gYSBy
ZWZhY3RvcmluZyBpbiBjb21taXQgYmMzOGRjMmY1ZjMuIFRoaXMgbGVkIHRvIG1pZ3JhdGlvbg0K
Pj4+IGZhaWx1cmVzIGNoYXJhY3Rlcml6ZWQgYnkgdW5rbm93biBjb250cm9sIG1lc3NhZ2VzIGFu
ZCBzdGF0ZSBsb2FkaW5nIGVycm9ycw0KPj4+IGRlc3RpbmF0aW9uOg0KPj4+IChxZW11KSBxZW11
LXN5c3RlbS14ODZfNjQ6IFVua25vd24gY29udHJvbCBtZXNzYWdlIFFFTVUgRklMRQ0KPj4+IHFl
bXUtc3lzdGVtLXg4Nl82NDogZXJyb3Igd2hpbGUgbG9hZGluZyBzdGF0ZSBzZWN0aW9uIGlkIDEo
cmFtKQ0KPj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogbG9hZCBvZiBtaWdyYXRpb24gZmFpbGVkOiBP
cGVyYXRpb24gbm90IHBlcm1pdHRlZA0KPj4+IHNvdXJjZToNCj4+PiAocWVtdSkgcWVtdS1zeXN0
ZW0teDg2XzY0OiBSRE1BIGlzIGluIGFuIGVycm9yIHN0YXRlIHdhaXRpbmcgbWlncmF0aW9uIHRv
IGFib3J0IQ0KPj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogZmFpbGVkIHRvIHNhdmUgU2F2ZVN0YXRl
RW50cnkgd2l0aCBpZChuYW1lKTogMShyYW0pOiAtMQ0KPj4+IHFlbXUtc3lzdGVtLXg4Nl82NDog
cmRtYSBtaWdyYXRpb246IHJlY3YgcG9sbGluZyBjb250cm9sIGVycm9yIQ0KPj4+IHFlbXUtc3lz
dGVtLXg4Nl82NDogd2FybmluZzogRWFybHkgZXJyb3IuIFNlbmRpbmcgZXJyb3IuDQo+Pj4gcWVt
dS1zeXN0ZW0teDg2XzY0OiB3YXJuaW5nOiByZG1hIG1pZ3JhdGlvbjogc2VuZCBwb2xsaW5nIGNv
bnRyb2wgZXJyb3INCj4+Pg0KPj4+IFJETUEgbWlncmF0aW9uIGltcGxlbWVudGVkIGl0cyBvd24g
cHJvdG9jb2wvbWV0aG9kIHRvIHNlbmQgcGFnZXMgdG8NCj4+PiBkZXN0aW5hdGlvbiBzaWRlLCBo
YW5kIG92ZXIgdG8gUkRNQSBmaXJzdCB0byBwcmV2ZW50IHBhZ2VzIGJlaW5nIHNhdmVkIGJ5DQo+
Pj4gb3RoZXIgcHJvdG9jb2wuDQo+Pj4NCj4+PiBGaXhlczogYmMzOGRjMmY1ZjMgKCJtaWdyYXRp
b246IHJlZmFjdG9yIHJhbV9zYXZlX3RhcmdldF9wYWdlIGZ1bmN0aW9ucyIpDQo+Pj4gU2lnbmVk
LW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+
ICAgbWlncmF0aW9uL3JhbS5jIHwgOSArKysrKy0tLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvbWln
cmF0aW9uL3JhbS5jIGIvbWlncmF0aW9uL3JhbS5jDQo+Pj4gaW5kZXggNmY0NjBmZDIyZDIuLjYz
NWEyZmU0NDNhIDEwMDY0NA0KPj4+IC0tLSBhL21pZ3JhdGlvbi9yYW0uYw0KPj4+ICsrKyBiL21p
Z3JhdGlvbi9yYW0uYw0KPj4+IEBAIC0xOTY0LDYgKzE5NjQsMTEgQEAgc3RhdGljIGludCByYW1f
c2F2ZV90YXJnZXRfcGFnZShSQU1TdGF0ZSAqcnMsIFBhZ2VTZWFyY2hTdGF0dXMgKnBzcykNCj4+
PiAgICAgICByYW1fYWRkcl90IG9mZnNldCA9ICgocmFtX2FkZHJfdClwc3MtPnBhZ2UpIDw8IFRB
UkdFVF9QQUdFX0JJVFM7DQo+Pj4gICAgICAgaW50IHJlczsNCj4+PiAgIA0KPj4+ICsgICAgLyog
SGFuZCBvdmVyIHRvIFJETUEgZmlyc3QgKi8NCj4+PiArICAgIGlmIChjb250cm9sX3NhdmVfcGFn
ZShwc3MsIG9mZnNldCwgJnJlcykpIHsNCj4+PiArICAgICAgICByZXR1cm4gcmVzOw0KPj4+ICsg
ICAgfQ0KPj4+ICsNCj4+DQo+PiBDYW4gd2UgaG9pc3QgdGhhdCBtaWdyYXRlX3JkbWEoKSBmcm9t
IGluc2lkZSB0aGUgZnVuY3Rpb24/IFNpbmNlIHRoZQ0KPj4gb3RoZXIgcGF0aHMgYWxyZWFkeSBj
aGVjayBmaXJzdCBiZWZvcmUgY2FsbGluZyB0aGVpciBmdW5jdGlvbnMuDQo+IA0KDQpZZWFoLCBp
dCBzb3VuZHMgZ29vZCB0byBtZS4NCg0KDQo+IElmIHdlJ3JlIHRhbGtpbmcgYWJvdXQgaG9pc3Qg
YW5kIHN0dWZmLi4gYW5kIGlmIHdlIHdhbnQgdG8gZ28gc2xpZ2h0bHkNCj4gZnVydGhlciwgSSB3
b25kZXIgaWYgd2UgY291bGQgYWxzbyBkcm9wIFJBTV9TQVZFX0NPTlRST0xfTk9UX1NVUFAuDQo+
IA0KPiAgICAgIGlmICghbWlncmF0ZV9yZG1hKCkgfHwgbWlncmF0aW9uX2luX3Bvc3Rjb3B5KCkp
IHsNCj4gICAgICAgICAgcmV0dXJuIFJBTV9TQVZFX0NPTlRST0xfTk9UX1NVUFA7DQo+ICAgICAg
fQ0KPiANCj4gV2Ugc2hvdWxkIG1ha2Ugc3VyZSByZG1hX2NvbnRyb2xfc2F2ZV9wYWdlKCkgd29u
J3QgZ2V0IGludm9rZWQgYXQgYWxsIGluDQo+IGVpdGhlciBjYXNlIGFib3ZlLi4gIA0KDQo+IEZv
ciBwb3N0Y29weSwgbWF5YmUgd2UgY291bGQgZmFpbCBpbiB0aGUgUU1QIG1pZ3JhdGUgLw0KPiBt
aWdyYXRlX2luY29taW5nIGNtZCwgYXQgbWlncmF0aW9uX2NoYW5uZWxzX2FuZF90cmFuc3BvcnRf
Y29tcGF0aWJsZSgpDQoNCkkgdHJpZWQgdG8ga2lsbCBSQU1fU0FWRV9DT05UUk9MX05PVF9TVVBQ
LCBidXQgSXQgc2VlbXMgaXQgZG9lc24ndCBuZWVkIHRvIHRvdWNoIGFueSBwb3N0Y29weSBsb2dp
Yw0KImluIHRoZSBRTVAgbWlncmF0ZSAvIG1pZ3JhdGVfaW5jb21pbmcgY21kLCBhdCBtaWdyYXRp
b25fY2hhbm5lbHNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKCkiDQoNCklzIHRoZXJlIHNvbWV0
aGluZyBJIG1pZ2h0IGhhdmUgb3Zlcmxvb2tlZD8NCg0KQSB3aG9sZSBkcmFmdCBkaWZmIHdvdWxk
IGJlIGxpa2UgYmVsb3c6DQpJdCBpbmNsdWRlcyAzIHBhcnRzOg0KDQptaWdyYXRpb24vcmRtYTog
UmVtb3ZlIHVubmVjZXNzYXJ5IFJBTV9TQVZFX0NPTlRST0xfTk9UX1NVUFAgY2hlY2sgaW4gcmRt
YV9jb250cm9sX3NhdmVfcGFnZSgpDQptaWdyYXRpb246IGtpbGwgUkFNX1NBVkVfQ09OVFJPTF9O
T1RfU1VQUA0KbWlncmF0aW9uOiBvcGVuIGNvbnRyb2xfc2F2ZV9wYWdlKCkgdG8gcmFtX3NhdmVf
dGFyZ2V0X3BhZ2UoKQ0KDQpkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JhbS5jIGIvbWlncmF0aW9u
L3JhbS5jDQppbmRleCA1ODliNjUwNWViMi4uZmM2YTk2NGZkNjQgMTAwNjQ0DQotLS0gYS9taWdy
YXRpb24vcmFtLmMNCisrKyBiL21pZ3JhdGlvbi9yYW0uYw0KQEAgLTExNDMsMzIgKzExNDMsNiBA
QCBzdGF0aWMgaW50IHNhdmVfemVyb19wYWdlKFJBTVN0YXRlICpycywgUGFnZVNlYXJjaFN0YXR1
cyAqcHNzLA0KICAgICAgcmV0dXJuIGxlbjsNCiAgfQ0KICANCi0vKg0KLSAqIEBwYWdlczogdGhl
IG51bWJlciBvZiBwYWdlcyB3cml0dGVuIGJ5IHRoZSBjb250cm9sIHBhdGgsDQotICogICAgICAg
IDwgMCAtIGVycm9yDQotICogICAgICAgID4gMCAtIG51bWJlciBvZiBwYWdlcyB3cml0dGVuDQot
ICoNCi0gKiBSZXR1cm4gdHJ1ZSBpZiB0aGUgcGFnZXMgaGFzIGJlZW4gc2F2ZWQsIG90aGVyd2lz
ZSBmYWxzZSBpcyByZXR1cm5lZC4NCi0gKi8NCi1zdGF0aWMgYm9vbCBjb250cm9sX3NhdmVfcGFn
ZShQYWdlU2VhcmNoU3RhdHVzICpwc3MsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
cmFtX2FkZHJfdCBvZmZzZXQsIGludCAqcGFnZXMpDQotew0KLSAgICBpbnQgcmV0Ow0KLQ0KLSAg
ICByZXQgPSByZG1hX2NvbnRyb2xfc2F2ZV9wYWdlKHBzcy0+cHNzX2NoYW5uZWwsIHBzcy0+Ymxv
Y2stPm9mZnNldCwgb2Zmc2V0LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRB
UkdFVF9QQUdFX1NJWkUpOw0KLSAgICBpZiAocmV0ID09IFJBTV9TQVZFX0NPTlRST0xfTk9UX1NV
UFApIHsNCi0gICAgICAgIHJldHVybiBmYWxzZTsNCi0gICAgfQ0KLQ0KLSAgICBpZiAocmV0ID09
IFJBTV9TQVZFX0NPTlRST0xfREVMQVlFRCkgew0KLSAgICAgICAgKnBhZ2VzID0gMTsNCi0gICAg
ICAgIHJldHVybiB0cnVlOw0KLSAgICB9DQotICAgICpwYWdlcyA9IHJldDsNCi0gICAgcmV0dXJu
IHRydWU7DQotfQ0KLQ0KICAvKg0KICAgKiBkaXJlY3RseSBzZW5kIHRoZSBwYWdlIHRvIHRoZSBz
dHJlYW0NCiAgICoNCkBAIC0xOTY0LDYgKzE5MzgsMTYgQEAgc3RhdGljIGludCByYW1fc2F2ZV90
YXJnZXRfcGFnZShSQU1TdGF0ZSAqcnMsIFBhZ2VTZWFyY2hTdGF0dXMgKnBzcykNCiAgICAgIHJh
bV9hZGRyX3Qgb2Zmc2V0ID0gKChyYW1fYWRkcl90KXBzcy0+cGFnZSkgPDwgVEFSR0VUX1BBR0Vf
QklUUzsNCiAgICAgIGludCByZXM7DQogIA0KKyAgICBpZiAobWlncmF0ZV9yZG1hKCkgJiYgIW1p
Z3JhdGlvbl9pbl9wb3N0Y29weSgpKSB7DQorICAgICAgICByZXMgPSByZG1hX2NvbnRyb2xfc2F2
ZV9wYWdlKHBzcy0+cHNzX2NoYW5uZWwsIHBzcy0+YmxvY2stPm9mZnNldCwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0LCBUQVJHRVRfUEFHRV9TSVpFKTsNCisN
CisgICAgICAgIGlmIChyZXMgPT0gUkFNX1NBVkVfQ09OVFJPTF9ERUxBWUVEKSB7DQorICAgICAg
ICAgICAgcmVzID0gMTsNCisgICAgICAgIH0NCisgICAgICAgIHJldHVybiByZXM7DQorICAgIH0N
CisNCiAgICAgIGlmICghbWlncmF0ZV9tdWx0aWZkKCkNCiAgICAgICAgICB8fCBtaWdyYXRlX3pl
cm9fcGFnZV9kZXRlY3Rpb24oKSA9PSBaRVJPX1BBR0VfREVURUNUSU9OX0xFR0FDWSkgew0KICAg
ICAgICAgIGlmIChzYXZlX3plcm9fcGFnZShycywgcHNzLCBvZmZzZXQpKSB7DQpAQCAtMTk3Niwx
MCArMTk2MCw2IEBAIHN0YXRpYyBpbnQgcmFtX3NhdmVfdGFyZ2V0X3BhZ2UoUkFNU3RhdGUgKnJz
LCBQYWdlU2VhcmNoU3RhdHVzICpwc3MpDQogICAgICAgICAgcmV0dXJuIHJhbV9zYXZlX211bHRp
ZmRfcGFnZShibG9jaywgb2Zmc2V0KTsNCiAgICAgIH0NCiAgICAgIH0NCiAgDQotICAgIGlmIChj
b250cm9sX3NhdmVfcGFnZShwc3MsIG9mZnNldCwgJnJlcykpIHsNCi0gICAgICAgIHJldHVybiBy
ZXM7DQotICAgIH0NCi0NCiAgICAgIHJldHVybiByYW1fc2F2ZV9wYWdlKHJzLCBwc3MpOw0KICB9
DQogIA0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQpp
bmRleCA3NmZiMDM0OTIzOC4uYzY4NzYzNDdlMWUgMTAwNjQ0DQotLS0gYS9taWdyYXRpb24vcmRt
YS5jDQorKysgYi9taWdyYXRpb24vcmRtYS5jDQpAQCAtMzI4NCwxNCArMzI4NCwxMSBAQCBlcnI6
DQogIGludCByZG1hX2NvbnRyb2xfc2F2ZV9wYWdlKFFFTVVGaWxlICpmLCByYW1fYWRkcl90IGJs
b2NrX29mZnNldCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBvZmZz
ZXQsIHNpemVfdCBzaXplKQ0KICB7DQotICAgIGlmICghbWlncmF0ZV9yZG1hKCkgfHwgbWlncmF0
aW9uX2luX3Bvc3Rjb3B5KCkpIHsNCi0gICAgICAgIHJldHVybiBSQU1fU0FWRV9DT05UUk9MX05P
VF9TVVBQOw0KLSAgICB9DQorICAgIGFzc2VydChtaWdyYXRlX3JkbWEoKSk7DQogIA0KICAgICAg
aW50IHJldCA9IHFlbXVfcmRtYV9zYXZlX3BhZ2UoZiwgYmxvY2tfb2Zmc2V0LCBvZmZzZXQsIHNp
emUpOw0KICANCi0gICAgaWYgKHJldCAhPSBSQU1fU0FWRV9DT05UUk9MX0RFTEFZRUQgJiYNCi0g
ICAgICAgIHJldCAhPSBSQU1fU0FWRV9DT05UUk9MX05PVF9TVVBQKSB7DQorICAgIGlmIChyZXQg
IT0gUkFNX1NBVkVfQ09OVFJPTF9ERUxBWUVEKSB7DQogICAgICAgICAgaWYgKHJldCA8IDApIHsN
CiAgICAgICAgICAgICAgcWVtdV9maWxlX3NldF9lcnJvcihmLCByZXQpOw0KICAgICAgICAgIH0N
CmRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5oIGIvbWlncmF0aW9uL3JkbWEuaA0KaW5kZXgg
ZjU1ZjI4YmJlZDEuLmJiMDI5NmMzNzI2IDEwMDY0NA0KLS0tIGEvbWlncmF0aW9uL3JkbWEuaA0K
KysrIGIvbWlncmF0aW9uL3JkbWEuaA0KQEAgLTMzLDcgKzMzLDYgQEAgdm9pZCByZG1hX3N0YXJ0
X2luY29taW5nX21pZ3JhdGlvbihJbmV0U29ja2V0QWRkcmVzcyAqaG9zdF9wb3J0LCBFcnJvciAq
KmVycnApOw0KICAjZGVmaW5lIFJBTV9DT05UUk9MX1JPVU5EICAgICAxDQogICNkZWZpbmUgUkFN
X0NPTlRST0xfRklOSVNIICAgIDMNCiAgDQotI2RlZmluZSBSQU1fU0FWRV9DT05UUk9MX05PVF9T
VVBQIC0xMDAwDQogICNkZWZpbmUgUkFNX1NBVkVfQ09OVFJPTF9ERUxBWUVEICAtMjAwMA0KICAN
CiAgI2lmZGVmIENPTkZJR19SRE1BDQpAQCAtNTYsNyArNTUsOSBAQCBzdGF0aWMgaW5saW5lDQog
IGludCByZG1hX2NvbnRyb2xfc2F2ZV9wYWdlKFFFTVVGaWxlICpmLCByYW1fYWRkcl90IGJsb2Nr
X29mZnNldCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBvZmZzZXQs
IHNpemVfdCBzaXplKQ0KICB7DQotICAgIHJldHVybiBSQU1fU0FWRV9DT05UUk9MX05PVF9TVVBQ
Ow0KKyAgICAvKiBuZXZlciByZWFjaCAqLw0KKyAgICBhc3NlcnQoMCk7DQorICAgIHJldHVybiAt
MTsNCiAgfQ0KICAjZW5kaWYNCiAgI2VuZGlmDQoNCg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQo+
IA0KPj4NCj4+PiAgICAgICBpZiAoIW1pZ3JhdGVfbXVsdGlmZCgpDQo+Pj4gICAgICAgICAgIHx8
IG1pZ3JhdGVfemVyb19wYWdlX2RldGVjdGlvbigpID09IFpFUk9fUEFHRV9ERVRFQ1RJT05fTEVH
QUNZKSB7DQo+Pj4gICAgICAgICAgIGlmIChzYXZlX3plcm9fcGFnZShycywgcHNzLCBvZmZzZXQp
KSB7DQo+Pj4gQEAgLTE5NzYsMTAgKzE5ODEsNiBAQCBzdGF0aWMgaW50IHJhbV9zYXZlX3Rhcmdl
dF9wYWdlKFJBTVN0YXRlICpycywgUGFnZVNlYXJjaFN0YXR1cyAqcHNzKQ0KPj4+ICAgICAgICAg
ICByZXR1cm4gcmFtX3NhdmVfbXVsdGlmZF9wYWdlKGJsb2NrLCBvZmZzZXQpOw0KPj4+ICAgICAg
IH0NCj4+PiAgIA0KPj4+IC0gICAgaWYgKGNvbnRyb2xfc2F2ZV9wYWdlKHBzcywgb2Zmc2V0LCAm
cmVzKSkgew0KPj4+IC0gICAgICAgIHJldHVybiByZXM7DQo+Pj4gLSAgICB9DQo+Pj4gLQ0KPj4+
ICAgICAgIHJldHVybiByYW1fc2F2ZV9wYWdlKHJzLCBwc3MpOw0KPj4+ICAgfQ0KPj4NCj4g

