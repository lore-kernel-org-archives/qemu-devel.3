Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EACC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpJd-0000Tr-4x; Mon, 22 Jul 2024 05:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpJZ-0000GE-Lu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:26:42 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVpJX-0008Tc-Il
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721640400; x=1753176400;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mbjGIn7AUz1Rz1BZSUZMFdKXgDTXbvj66z6U2zqYB4s=;
 b=rf/zprcDTP6gslJ5cKJh/ub2y0jAZ9aUSj/R6UxPLQOMKvwlFH50MQwC
 VNnGqq1JsKon2k4v/WWzGfA5Zoy3T65Zz5PIiFEy81LVhiGFY9PSGg3jz
 SDXlG0srQw1f7EOlNwPI5oeltHr4EfTUt7FBW7poNprDcnnybV0DLnev5
 8Utf5xWtdrXkZSkgsk0uZHPtMcbH8IMDmVnASP4y3YRC5QMVmcmFB4/9M
 a40zf6uJDVrAwzA2XT+M5wZcjUPN4o1Xw1a33Y02TcPTmVncwoSQOcoFY
 W3p7ijj+k03smd0GZSdV50n6s8tWbxvFN1KiP/GNVIYik8S0YbgTS91oi Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="125786813"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="125786813"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 18:26:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRSxmg1py6LV29PaE8WImJbVKaBgBi/4VIWJDRv5i1tf0HBIbDzkyP58KDyGOLfhFprVACSNPnIqWjGncqOz/j9HQODHDXqjikkZRnAhf81hYYxCveaFvGhMDum7yjUinbfeXcZXlPJJcaZ5bTGUltXKvJtyFMSGNG479Rlp6owTrv7r6a0SUXyCIkRCZvBgmBuNRiGTPDPWfAE34PkHfjSfDbXTABUS0f5Hh4LQrAcJPpB6L38frzgeC4IoDGuZZdtTpXcWv4li8wTr3WND//kWB9sCAb/q3PqDzrRSUcg8vV+rRRLWO24nfc2gRmW8ImHiDNmbFhSa7wLMrEDAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbjGIn7AUz1Rz1BZSUZMFdKXgDTXbvj66z6U2zqYB4s=;
 b=yJibXr73+T4ARJVfIMCp98oo0xkEXukZ8Y8DQHIQEN5/fJK17ES1MuvlDnoFvtdTpDTeMEvghYXMib1lvxKjT9jDqT1uG8xRcwfaXsgtwfhFsfoeOfZJ2s4bPCFvnbthzfvjUZ8S9HMNnbnWcfWc5zSmV+q8s2xvQH8/bm/3iT3DhbN9EokgrRTLVnka4xK6rlSj3Sl08gGtqIdB7pHTRrx5A7mA5FnnwaTnj5/XWYICxp5pFd2BaU+ZiqqQ40YcUkdSnb4H6yTw09YEuPSWNf7sUM+nzQKDuVWsNnTG25G32jFagOgFqxTKowL5wyfnZv/BiYaKXu+z9PN/BKAtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by OSZPR01MB6908.jpnprd01.prod.outlook.com (2603:1096:604:138::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 09:26:32 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 09:26:32 +0000
To: Vivian Wang <uwu@dram.page>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
Subject: RE: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
Thread-Topic: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
Thread-Index: AQHa23ExAgtTxYSHz0SeV+prn1lU5LIB4KsQgACJdgCAABEp8A==
Date: Mon, 22 Jul 2024 09:26:32 +0000
Message-ID: <OSZPR01MB64535AE51B7D222565D7D7078DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240721090817.120888-1-uwu@dram.page>
 <20240721090817.120888-2-uwu@dram.page>
 <OSZPR01MB6453807448D47F3EFA427C878DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <902417dd-2aa7-409a-b62d-7950e34c444a@dram.page>
In-Reply-To: <902417dd-2aa7-409a-b62d-7950e34c444a@dram.page>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZWY4MGQ1ZDYtZGFlMi00ZmQ5LWJiZTMtYWJkM2JkOTA0?=
 =?utf-8?B?Mzg4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTIyVDA5OjI1OjM0WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|OSZPR01MB6908:EE_
x-ms-office365-filtering-correlation-id: c42a05f4-3ca6-45f4-e215-08dcaa305fb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?QWJyQ0EydnI4azZpWWRhNTRlakoyUitmMWR1bm1IcmFwdEUzd2NSVjhpeVNz?=
 =?utf-8?B?R0pLOGVsd0prV3RiS1FkYkxRUWVPd2pnck5KN1R0MEs5cWtzdm83dG45VElV?=
 =?utf-8?B?TDIrMVNuR2tMc0FnbEtnbzNIQ0V2dTEyS1NXV0MwUVBtMFFTUHk5VUJRSUtY?=
 =?utf-8?B?SGtsa0pyUEZkT3pqNDBGcWRhRkRUdlpaTzF5U3dKYjdKZ05ZaU9NbEpTZXBk?=
 =?utf-8?B?MFBXU3pmYTFubk9rYklob0FoMlFqcGhJNzRndmpLRUh1Q21zY25XeEYwN214?=
 =?utf-8?B?Z2R1VnpCZlJCZTZMb1RmSHVMemdWcnVHbTRWYkRqNHN4cm1INmlDNzFRUWoy?=
 =?utf-8?B?ZXZ1QzNjSmptNzdwQURoNGtVdE8xbzFEMlNqUUtMbEptU2EwZGRzMjBkWDNp?=
 =?utf-8?B?TXJVSmRUZ1V0OEJLUXJSVm8rbXFNdy9iMDIwNEllU2ZWTlp1dkdCazljTS9C?=
 =?utf-8?B?dXlhUmUraEVpSzJaaEl5cDRzb056VEc2TVBKZTJqUDBHcHQ3R0RIWXNFcU1M?=
 =?utf-8?B?Y2hhRm1VNXdQS3lpZm1XZStWWHRmWkdBYzhhMktnTlc5WTJBTTU2ZGNDVkVl?=
 =?utf-8?B?TjJhc0wyUUVBeTZSaU1LcXVPYzFBZDBBQjRoOER6amhzbU5RV2hpMFVSd1Q0?=
 =?utf-8?B?U3Y5RTI5eGR4bjk5MmQvTDhhTTJ5MlpncStQWTVNNWlRM3JXYXJ0QjYwbU5q?=
 =?utf-8?B?YjlQWG42RGNYRzUxSW1NMjVqOUF6QThuaG93cEZEV3IyTEpIVVU1UUhUZUhi?=
 =?utf-8?B?anNlaHRTTTQ0Sm1RTHVJb1g3d3E4OWNkcVBCYXNBS3h5bzRVWmtMbTZ0Lzgw?=
 =?utf-8?B?bSt5N0FJajREWE1LRHhTQXlXcVpsR25Bd2h2a3hrY2ZiakpMRXdqMDFaczlJ?=
 =?utf-8?B?VUZiSSsweFBNdlc4RkF5RUJLVFN3ZzJBOTl4b2tFV3pNNWtjRE1oc2VKb09r?=
 =?utf-8?B?Nkw0a29zcjBXelpKa0UzdmN6bmdpYjVDaHZkMk9aS2syQkQ4aFBlU2ZLSlAx?=
 =?utf-8?B?VS82VlJONkVpRDk4L280YmhuNlR0d1RrNlplbTdLS1h2Q2pFN3pHYVlZZ2t1?=
 =?utf-8?B?R0E4SU5IU0RMOWxqOWs3dmwrNkRsMTcybWFCMkw3RTNPMkJ4aXJmaU1YZkdn?=
 =?utf-8?B?MVNnUXY3d1Q4c3FWYUIzSlZyZi9LdzUxKzc2bCtOTzBsNU85L2RpRTk2SXA2?=
 =?utf-8?B?QjNoMkJ3ZTd6UUg3bWhocXlkL3NSK3JJNjJ5SzUvN21INUl1VktlQi9hN0hr?=
 =?utf-8?B?S0prN2NZM0ZFc3o1MmZFWThFU1V0THFranFqWnozM1ZFeE1NczUzb1NWc2hJ?=
 =?utf-8?B?QmE3Wm1Qd1JRL2hTa2xZOXd0b2NwUTFLVDV3bnVZVTBjanZWMjB3Z1dDSWZQ?=
 =?utf-8?B?WjROaloxVm9kQmtINVBRVTlLQ3ZlT1Ira3hMWXNtOStseGYwWHB0dlRRRTMy?=
 =?utf-8?B?WDErWHFxeHhrcEhRYTBWL0xKeStLSDRuRjlmY3hDdE5sRC9hTlVZT3c5T091?=
 =?utf-8?B?Q0FWaGhzRDBTbXRta2o2WjhKOVRXZXM0ZS8xd000aWxNbjZaZmFqYTNjOHBj?=
 =?utf-8?B?SHJmRm5yaUk4Vk1jdGd5VC9UU2gyRkVqR3hSUzg3SjdnWXZLYmw2OFFKblIy?=
 =?utf-8?B?TzhubmxDZ0hJN0lQOFFCaitpRlRFYTFUaHFmTDU1TysvaWpsSDBNMTI1UzUz?=
 =?utf-8?B?dG1teHdZZFNtSjdNMFgvWmhDL1JtNFNVUkdqOGpyN05TbnVtcFNkbCs4TGdJ?=
 =?utf-8?B?TXRyM3ZUb05ZUkFMQmFSYjNxYlVhSE05Z0FWWWllRlRXSHJTMzNNd1k3cGth?=
 =?utf-8?B?RWlpN0VSVWkxa0V0ZUJzaG1RU1h5a2ZBeElvZXNvTWVtazNXSzlTMW4rdVZC?=
 =?utf-8?B?bHhpYnFpZERlZXRIR2kyMG9yRHpRT0h2UW9jTnp5Zk81R0hrL0VSVDJmQmZN?=
 =?utf-8?Q?gWkCB6KByTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkxhOG9pREw5cHpxVDR1dkErcVkvSzBGTE53WlpKUXZuWVlPRjhFODJaNnZW?=
 =?utf-8?B?R2g3WnRib0lHejAwaDdDUWRmZEptNE1qYmk1c1VJdlpGcm9UbDBzQVFHakZh?=
 =?utf-8?B?YTgzWjhKcFV1aHZNeS9LeU5SZ3JzOEt0cWdjczVYNlgxLzEvUGxUUW1sTFB6?=
 =?utf-8?B?Y0xXNUpmbWVycW56NlBsa1VGcldndlllYXdWd0p0N0R6STZya0thNzNnVDVQ?=
 =?utf-8?B?ZEdCM3VIYXdTdHNFb25qT3VxSGdtS0lJRWk4aEN6c0Q5L2FJQzg1S1JnMnp1?=
 =?utf-8?B?L29wb1kyeU93RXROak9nbjVUQlZWbVl0RzJkVGtGSGN2cE4vL3lqZVpYS2Fn?=
 =?utf-8?B?TnJBUS94MjVoeVFEYkdRVU5CbnNlbHhTWFRKeC9jSzIzS0NlK1FBc0Q5ZDdp?=
 =?utf-8?B?MGFDeGJrdHZaN2NPbE9MdzZubWlpZ3ZEM3hXWTFqNk1TZUtTY2hJdlFIKzBH?=
 =?utf-8?B?WnI2UEMxd2Z2Tmc4dC9zeVpQakNlbUhVRFJna2pvRW40RDVjWWxxWHE0U3Vn?=
 =?utf-8?B?OHlQS3p6Ukowc0JML0R4YVRXRFg3aWo1L0ZvYXR5UXpCT1J2Wm9EclM5VnhQ?=
 =?utf-8?B?UWZ3YXhiaVcxSFZBMGxNMitiSjdnb0dyV0RNTG9hN1VROE9uRWVYdnJsMk9a?=
 =?utf-8?B?MHpydGZIUVpMVGI2SXJTTkVGcmZXMENobEdJanFIRXF1bTgwb3RJKzRIbmtx?=
 =?utf-8?B?S2wyQmlGZjdYZ1owV055NFFIUk92bjlMcmFOSVE2VzdNZ1AxZWVuVzJTVkMx?=
 =?utf-8?B?bElFVlp3Qmp2aityRFVRMlBKWWpZdUJOWThSNkU2akc0SDhJQ3dhNytvdTdl?=
 =?utf-8?B?YTZEUm5tZHA4MHk1NkxORm5WUkVUT0w0R1lpUW10Wi9HNElHeUJTMGJPWENv?=
 =?utf-8?B?VUJuVXp3U2pIQkh2amlMQnQrUDhRUFA0OWF0ajdwR201enVDOUdtRHUvQmYr?=
 =?utf-8?B?dmJEMTJmZ1pqVy9PNnJra2sxSHg0SXpkSzR5L05PVm1LTTZpWHpHdTh0VUVT?=
 =?utf-8?B?U3Nsc0xnS2dTTnlXS1gyWEpSZTJlQllWTWpjQURHbnROREdlOXZTYTZSb1dB?=
 =?utf-8?B?NEtFdFphQXh5ZnhCSUdiV0JXNlpYY2RMY0dEUTZ6NDBCT3BOdzA5MktDcTFh?=
 =?utf-8?B?dStkaytNT2NWeGxMZTk5M21OS1l2Vk9ad1BmODdCT21jVzE5YnBZbXV1NkZ0?=
 =?utf-8?B?RUpydEROaGNBVVl2V3BCSnhvbWhNZk52YjhCY3VOMG5tbHBoUUUzbENyREJV?=
 =?utf-8?B?Nlh0NFFaSUxNT251WUloeVQ0MlFrRTE4aXEvYUV1SktmckVuVDVVckExM090?=
 =?utf-8?B?QjdQYU51U0xES24zUFlaN1FEWjREQWwwZmlVSDFFZ1FTTWhFRUZUWmlpQ2VQ?=
 =?utf-8?B?TzY3TUd2Slgva3B3clVVMmsvNlRCSzZHamlrUExnUDYvMmpBK0JOVnJzcWhV?=
 =?utf-8?B?Nko3cm1lT3l0YU9wTzhBYXMzSUY5K213clJXTFluSm5qaHl1K2EwSEU5MUNI?=
 =?utf-8?B?VXloOTdQUFV6emRrUHIyMzNwcHArZjZERFN3M29QdjZ5cExBTXNvUTFtclMx?=
 =?utf-8?B?WWtQOGN1MnE0U1NGdWxBYUY0TWwvalRoQ2J3cWl4T2ZPTnhzSCtPNVpDL1RT?=
 =?utf-8?B?TENiRDFpaUxWaDZhckVuRmZrdTNaV3NJb2ZROFB0R3dYMkEwbzBnWjZyTCs2?=
 =?utf-8?B?UjZQVE94c1luaVl1aW5Jd0hRY2tRdk1RVzRUSHR3MEQxMXhqMlR4TmF4NEds?=
 =?utf-8?B?NmptcU80M3FvOURtUXBtMk9KOFBUS1Q1eUJQdDF4VlRneTJwNWpxQmhDRk9K?=
 =?utf-8?B?dk9ubVRpeUQ5MGVxUFEyM2Erd1BId0V3TVYxZnhQNkI1ZVd5aWU5RC9SbWlz?=
 =?utf-8?B?cGx3bkZvd1pKVXF2MUI4czZ5dnoyNlczdGtPV0ZGU0xWb3d3MmxaeG5Uakxm?=
 =?utf-8?B?bUQ0ejJud3dxOFpGYmN1bXcyNUgveVRSaGdZK2hhUkhDZ0NzRUJ2M2V3dVNE?=
 =?utf-8?B?RHZWazFnM1pDSG54L1VGWDNrNi9Kc0xraDJVMFBHR1Uxbi9KWVBMYVBJVk1M?=
 =?utf-8?B?bXltMVFEQTVJRjNpbmNZNlRBSGdzQU5ZdVc0azJyYTQ5VzZhS3VjT2lGYXpP?=
 =?utf-8?Q?TPfNFPzb8xBJxmd3rDO7FAT2c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L83mOWtx+dCsJCwUvWq4p850SQ/xJ0m+/NX7TFef2Shsk+tiYogL7w5303TGrCpnJNRp8FOe6QfizTKgUM/9uE+Ny4NFcGInYwFtRFxoWn+v0i6uEN1+cE+pOFYhC82b+NSvIjpQpfK5TpI7WOUYq9S02K464Jk8G4RDYz8egnqwC+ZYRcRzXahiOzrMuLZBKqFyqHB487ZQJBwp2fyMfNpLIf88COb8H3SMgLIhDowvruGhuYxn+Lbo0HHsNcZtQ2/faJtOcDTz1hyzJ5fW1NMw/KiBzuuwgyX0RdUlW8UjmCDRIqgAaIAerCr1LFwh+a7tw4LVTf2mjtISPc7P9jNuN/NZUjCf6xtMcghvXLRUggx86A961jCW8pFf5KNMfvE20z9yxNrcdk+XDQwCLWTrqQ6uv7ojDtTgTtlGyCTxh6ElHhpPnhi+dfLcKR7ux8PqAmnqf7xpbuaKOrzqbX8wEtym9h47nUBAxVHTXXzBHtTiSvyAtmlzFGeQUFEkeLACOcWrlubfPKJEjXPWvr/lZvAsVbefW3pJAsIn9qR3j1BtrcSJ3/Kbpe0KqRTQwCsW2RRoyYlMKrXbPDimBnA7Dv1RZMEV5kcxQmxULfwndzqOpaOpLGDBgawSNZCL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a05f4-3ca6-45f4-e215-08dcaa305fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 09:26:32.0919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FptRNOiehBSD5v9W58kKd199fUkNc0z0UotXjIHN3C9AGpd9HYg/Iz6AgIypF2kBRz7mcSgVJYNiOV8aOEOluQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6908
Received-SPF: pass client-ip=68.232.159.87;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa7.fujitsucc.c3s2.iphmx.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVml2aWFuIFdhbmcgPHV3
dUBkcmFtLnBhZ2U+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAyMiwgMjAyNCA0OjI0IFBNDQo+IFRv
OiBZYW8sIFhpbmd0YW8v5aeaIOW5uOa2myA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT47IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogUmljaGFyZCBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5l
dD47IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzJdIHV0aWwvZ2V0YXV4dmFsOiBFbnN1cmUgc2V0dGluZyBlcnJubyBpZiBub3QgZm91
bmQNCj4gDQo+IE9uIDcvMjIvMjQgMDg6MTgsIFhpbmd0YW8gWWFvIChGdWppdHN1KSB3cm90ZToN
Cj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBxZW11LWRl
dmVsLWJvdW5jZXMreWFveHQuZm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnDQo+ID4+IDxxZW11
LWRldmVsLWJvdW5jZXMreWFveHQuZm5zdD1mdWppdHN1LmNvbUBub25nbnUub3JnPiBPbiBCZWhh
bGYgT2YNCj4gVml2aWFuDQo+ID4+IFdhbmcNCj4gPj4gU2VudDogU3VuZGF5LCBKdWx5IDIxLCAy
MDI0IDU6MDggUE0NCj4gPj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBDYzogVml2
aWFuIFdhbmcgPHV3dUBkcmFtLnBhZ2U+OyBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUu
bmV0PjsNCj4gPj4gTGF1cmVudCBWaXZpZXIgPGxhdXJlbnRAdml2aWVyLmV1Pg0KPiA+PiBTdWJq
ZWN0OiBbUEFUQ0ggMS8yXSB1dGlsL2dldGF1eHZhbDogRW5zdXJlIHNldHRpbmcgZXJybm8gaWYg
bm90IGZvdW5kDQo+ID4+DQo+ID4+IFNvbWV0aW1lcyB6ZXJvIGlzIGEgdmFsaWQgdmFsdWUgZm9y
IGdldGF1eHZhbCAoZS5nLiBBVF9FWEVDRkQpLiBNYWtlDQo+ID4+IHN1cmUgdGhhdCB3ZSBjYW4g
ZGlzdGluZ3Vpc2ggYmV0d2VlbiBhIHZhbGlkIHplcm8gdmFsdWUgYW5kIGEgbm90IGZvdW5kDQo+
ID4+IGVudHJ5IGJ5IHNldHRpbmcgZXJybm8uDQo+ID4+DQo+ID4+IElnbm9yZSBnZXRhdXh2YWwg
ZnJvbSBzeXMvYXV4di5oIG9uIGdsaWJjIDwgMi4xOSBiZWNhdXNlIGl0IGRvZXMgbm90IHNldA0K
PiA+PiBlcnJuby4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogVml2aWFuIFdhbmcgPHV3dUBk
cmFtLnBhZ2U+DQo+ID4+IC0tLQ0KPiA+PiAgdXRpbC9nZXRhdXh2YWwuYyB8IDE0ICsrKysrKysr
KysrKy0tDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL3V0aWwvZ2V0YXV4dmFsLmMgYi91dGlsL2dl
dGF1eHZhbC5jDQo+ID4+IGluZGV4IGIxMjQxMDdkNjEuLmYxMDA4YmRjNTkgMTAwNjQ0DQo+ID4+
IC0tLSBhL3V0aWwvZ2V0YXV4dmFsLmMNCj4gPj4gKysrIGIvdXRpbC9nZXRhdXh2YWwuYw0KPiA+
PiBAQCAtMjQsNyArMjQsMTMgQEANCj4gPj4NCj4gPj4gICNpbmNsdWRlICJxZW11L29zZGVwLmgi
DQo+ID4+DQo+ID4+IC0jaWZkZWYgQ09ORklHX0dFVEFVWFZBTA0KPiA+PiArLyogSWYgZ2xpYmMg
PCAyLjE5LCBnZXRhdXh2YWwgY2FuJ3QgYmUgdXNlZCBiZWNhdXNlIGl0IGRvZXMgbm90IHNldCBl
cnJubyBpZg0KPiA+PiArICAgZW50cnkgaXMgbm90IGZvdW5kLiAqLw0KPiA+PiArI2lmIGRlZmlu
ZWQoQ09ORklHX0dFVEFVWFZBTCkgJiYgXA0KPiA+PiArICAgICghZGVmaW5lZChfX0dMSUJDX18p
IFwNCj4gPj4gKyAgICAgICAgfHwgX19HTElCQ19fID4gMiBcDQo+ID4+ICsgICAgICAgIHx8IChf
X0dMSUJDX18gPT0gMiAmJiBfX0dMSUJDX01JTk9SX18gPj0gMTkpKQ0KPiA+IHlvdSBjYW4gdXNl
IEdMSUJfQ0hFQ0tfVkVSU0lPTigyLCAxOSwgMCkgaW5zdGVhZA0KPiBUaGF0IHdvdWxkbid0IHdv
cmsuIEknbSB0ZXN0aW5nIGZvciBnbGliYywgbm90IGdsaWIuDQpzb3JyeSwgSSBtaXN1bmRlcnN0
b29kLg0KDQo+ID4+ICsNCj4gPj4gIC8qIERvbid0IGlubGluZSB0aGlzIGluIHFlbXUvb3NkZXAu
aCwgYmVjYXVzZSBwdWxsaW5nIGluIDxzeXMvYXV4di5oPiBmb3INCj4gPj4gICAgIHRoZSBzeXN0
ZW0gZGVjbGFyYXRpb24gb2YgZ2V0YXV4dmFsIHB1bGxzIGluIHRoZSBzeXN0ZW0gPGVsZi5oPiwg
d2hpY2gNCj4gPj4gICAgIGNvbmZsaWN0cyB3aXRoIHFlbXUncyB2ZXJzaW9uLiAgKi8NCj4gPj4g
QEAgLTk1LDYgKzEwMSw3IEBAIHVuc2lnbmVkIGxvbmcgcWVtdV9nZXRhdXh2YWwodW5zaWduZWQg
bG9uZyB0eXBlKQ0KPiA+PiAgICAgICAgICB9DQo+ID4+ICAgICAgfQ0KPiA+Pg0KPiA+PiArICAg
IGVycm5vID0gRU5PRU5UOw0KPiA+PiAgICAgIHJldHVybiAwOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+
PiBAQCAtMTA0LDcgKzExMSw5IEBAIHVuc2lnbmVkIGxvbmcgcWVtdV9nZXRhdXh2YWwodW5zaWdu
ZWQgbG9uZyB0eXBlKQ0KPiA+PiAgdW5zaWduZWQgbG9uZyBxZW11X2dldGF1eHZhbCh1bnNpZ25l
ZCBsb25nIHR5cGUpDQo+ID4+ICB7DQo+ID4+ICAgICAgdW5zaWduZWQgbG9uZyBhdXggPSAwOw0K
PiA+PiAtICAgIGVsZl9hdXhfaW5mbyh0eXBlLCAmYXV4LCBzaXplb2YoYXV4KSk7DQo+ID4+ICsg
ICAgaW50IHJldCA9IGVsZl9hdXhfaW5mbyh0eXBlLCAmYXV4LCBzaXplb2YoYXV4KSk7DQo+ID4+
ICsgICAgaWYgKHJldCAhPSAwKQ0KPiA+PiArICAgICAgICBlcnJubyA9IHJldDsNCj4gPj4gICAg
ICByZXR1cm4gYXV4Ow0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiBAQCAtMTEyLDYgKzEyMSw3IEBAIHVu
c2lnbmVkIGxvbmcgcWVtdV9nZXRhdXh2YWwodW5zaWduZWQgbG9uZyB0eXBlKQ0KPiA+Pg0KPiA+
PiAgdW5zaWduZWQgbG9uZyBxZW11X2dldGF1eHZhbCh1bnNpZ25lZCBsb25nIHR5cGUpDQo+ID4+
ICB7DQo+ID4+ICsgICAgZXJybm8gPSBFTk9TWVM7DQo+ID4+ICAgICAgcmV0dXJuIDA7DQo+ID4+
ICB9DQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuNDUuMQ0KPiA+Pg0KDQo=

