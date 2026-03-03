Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A82EDEBE5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUqd-0006tI-99; Tue, 03 Mar 2026 13:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxUqY-0006s3-PI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:51:54 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxUqW-0008Kp-Ma
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772563912; x=1804099912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LiPeXmlMDZ28IbYSPrYsV4NSGomut+Nnh18HRnq3X3Y=;
 b=Jou9ujFReBFv+Mjai0A/F/mqDdb5qRGG6M9dEZavWRgeg7WWvfkEpyiu
 svO/JdRiVobaQ9golfPpM5+gssoG5BXnsMxf/GpuK0cZRjO3/Z98fZvJS
 v5zPpRdJDtrlfkmOlt1Cf9bCenC1ASimUzJ15bJXJ1Ty6eozzJfSDX9P1
 ZHQLYCf72JmyZc8aUSo9c2fEPv23TXjILKjC3wwceNxWTwVYN8JzeNNue
 tmysEOct9ZoZNkj9IIjJs8tksMXLkZpUbn3xiel1E1Mz6rPQ1D2eGJwa9
 mLUcYuwFIgwYeT1hIoIqNjKFR1Chu3Q49PX7HjYnNCBUGfXTwgAPlsZLM Q==;
X-CSE-ConnectionGUID: 2jzSLKo2QkWwJ/TyY2+vrA==
X-CSE-MsgGUID: jlNv913lQFKPMHZAQh2Pjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="83951492"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="83951492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 10:51:47 -0800
X-CSE-ConnectionGUID: y0iYGEA/QwWI36LMs2gCxg==
X-CSE-MsgGUID: T64h+tKHTIGbJL09CM52OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="217254623"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 10:51:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 10:51:47 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 10:51:47 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 10:51:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyj01PtpMlyNLMG42FvqQrwSNk/6vwShurBD+nMyE4Xdxa16ZO92ParCmq0WAlrR4JkLBVxF9tFg1v5ONAF8D+pEH8K8DyXqR7QsSUkTb1giil2Pc4Leq/Kom81Jd6s/jFE5WzQiZ6bu3tRvjyoAAUiNjqGijGFE0oB/F1s8U/xM/kakWgCx2c8IkatbvCZs77PQXt47UtUODdccqZNCTVZFyxOUV6HzmhlUfRLiPsmVC4SZRnsDisSX3YkplwGYrf1a+u5JUDBcTn7L1SirN/5KT8sQOWx+geoC0hQCgF5fPJMlYFElEmbarAm7Xo7YUqpJ3wQDEFYUlKOZgrFuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiPeXmlMDZ28IbYSPrYsV4NSGomut+Nnh18HRnq3X3Y=;
 b=HUMVRVQyT4R/tcUm2fYdXpRNB2slyfJon50wBGEq37UegqaJFdP8EZddeqREvwzqRi6wnR2WWBeaMr5jdnUKYqNPTEj8KVQ/XkOffXJ4RsMgHkmdN9RBAmH1vFGCpyi/eESZ/Ifun8hFA8kgS97nH2hBGn/XL/xi5tyRU39EOvF648sNTdQfynajO8rysIt5sPwo5aA7mxHdT+NzGYrzSBdIajW+dxd9VIQ9VMGCRZoAejGPihE/HlyFTUFFEWElMYvv68TKcCE6SyfFKSqA5Vcpg6FrvAgf/zkaY15pvs4sqZc2SaAAjlsBWdRkvI8iugfnhjrrI/ewdiGl6nxJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:51:45 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:51:45 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
Thread-Topic: [PATCH] virtio-gpu: Fix scanout dmabuf cleanup during resource
 destruction
Thread-Index: AQHcqqoH7BpZkR1Itk6lmFVlY1oVvLWdACSAgAAnrCA=
Date: Tue, 3 Mar 2026 18:51:45 +0000
Message-ID: <PH0PR11MB511250B98C5CE00CE879BB3FFA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260303010047.1925589-1-dongwon.kim@intel.com>
 <CAJ+F1CKCQiBnOncaecpgG2FXj3R2tjxYOe8z7r8rGqCBAo97=g@mail.gmail.com>
In-Reply-To: <CAJ+F1CKCQiBnOncaecpgG2FXj3R2tjxYOe8z7r8rGqCBAo97=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|CO1PR11MB4931:EE_
x-ms-office365-filtering-correlation-id: 05fa0258-c839-4d2a-e4e7-08de7955eae6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 5r1/12G4B+pY4/vjLOBgGjbb/5yti2Te4AXIn2q6lcm3qQDGiHbUcUwG0RPjkFDxhnhEL6J6XKDHjZvkWykHgkBD2LbIvAl6sir/CiK8Bzf4K/pbKkT+2Tf4Iwp3ZOw6V5WifeDeABCFJFU5N0fDpc8SL96ahkDQpOa1SXdi0FVEf8lLRsiYES52/46F6tr8KvvC7si1PTfz3kAfuXxnOtuA3ZU0W3EXov96tuliVJUkBgDaqZ1YcV6B1ajHV2vxgAtXtHrjFx0TvvBDyGUrVyw7BrNNZ09/3p1FcsugOzQMY6hhVIF2aA6f0Buf6pSGXp3lnqln6VQq0MnunXdMiRzsADOwt1JUVtZvlN9Ir3larA5IRcEkhdSiyVxIeXdqkawKdZIJqlSofXLnH113Q81cDcFpJ2HHM6Wno6Rk53OG1xL8nxzPOJrLHcBVw1IfsE8BBwxgWUBrUaF6+wQOmGvi6LDPd/HsgR9tcuaMR2ELQT7i3tkasbpvm0GLihpSOixeeUT6GgMDz+TM30kxdJTxoi9dt/ct9qINP9O1xRttO7ipIXYffmpk4Kwz21xFW5+ED/8FEXbCn5+JDr62cFBZl+2m6kG9aFyXHZ0AMsybiZ7EaQsa5DmTQ0Pgo94po2MBmOraWNSNno8K2Mpr2DSYl4gRbkofMdUs71cFsfn7nfKgkL6iBdLOw3PXvi/lHoed2r1t58/wTyaa0GT7OSZJLV3YzgikW18J07WvG4yLS4jLcWqigUz5L7NFoLiQHGlm/Kl0HzlYN/OjL8wRdmky9xWEyGtEg0LkHtyMjGg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXcwM3hiS3lSMklCUmZKTjNnTlRxVXNnQng5dlpwR25sWVlhbnhHOW9JL3JM?=
 =?utf-8?B?STBIWkRMVzcyRmJtLzFzL3dPNUpySlM0RThTT1B3WkRoejdHQnE4YTZNVTNQ?=
 =?utf-8?B?UW9OdWd0REFNVkZhNnZMMW53NitIT2lsSHE5M3htRk0wQmg5WFBiQ1NTYUln?=
 =?utf-8?B?Qk5jdFZnM1NhajhCM0ZuRzBNRHpsQ2xYanhPd2xleXQ2dG04VVFKQzdJVjlV?=
 =?utf-8?B?Y2NXdUYwanl3c0NOdW95TiszWHNET3d0azMwb2NhbVJnU3o3cmZDalA2Tmc2?=
 =?utf-8?B?NTNPRFI2RGo3NnNWL1VLS2JHWkVzR1A1bkszb0RxQmlsSUxWTEFYb2twOS94?=
 =?utf-8?B?SUFQMUYxSkc3VlNUelVlcU12aUMzYWRyT1F5QXBGOVJ3UVVtVUxZV09YVHM1?=
 =?utf-8?B?dThpVmQ4L2pKS3YrR2pUTnpHNUdkMXliZFZ2dmM1dlk4VC9wTmtCeDhYU3U2?=
 =?utf-8?B?dTFvV0RyWUVjM3dmUi91cklFSjhaQjlJcy9OdU5jU0Z6UnZCQXVRRndLa2c5?=
 =?utf-8?B?NTFhejBnYllYbnFpT0VIekNnMXo3Z2hkQy9GWm9LKzhjZlNmZjNER0U0ckFZ?=
 =?utf-8?B?NGpsTlRORndEZUo5aloyYTZaa0E3TEVXbndWR21DTkJiaUNpVFlIaVZaZkNz?=
 =?utf-8?B?bXZkOHdXYWxtaE0vLzNCQkk2NmNvTElFdDJ5L2s1OXViL0ErNS82VjFoaW9s?=
 =?utf-8?B?aThsTGZxaUFmbndQTVVOOTJuUXZCMGtIYkVIMTY0b2Fua3kvcGNKRkdiWko3?=
 =?utf-8?B?TnZiR1dVQ0VpUUp4R1BtSFRvZjg5WC9yUkVqZFVYOUZZZXRvZ2pCVFYzb0hJ?=
 =?utf-8?B?K3hUbU0xa2NJRmNFNndQL3hoT2VzZmRIU3hLM0t4OTd2RVpKYlRqT3EvVmR0?=
 =?utf-8?B?Q3M1eEtMN2ZqOHgyZGxjUnVaaFY4K2JReEZpVkloMHpFLzJXenVSZkowbGJt?=
 =?utf-8?B?QjZnYlRtUkNsNmt6OGIxOUgwcjdLL1pmU0YrZjNjeU9aNmFWK1ZiNjhOeGZQ?=
 =?utf-8?B?SlgxS2ptMFllQnBpYjFkUnA1T0wvNkV2T0kvVFdkRmRBSGFMMDRpRW9ZRHhi?=
 =?utf-8?B?MUlFbnZUTTRmMWRQdEtkclNoYVNCRzVONkJicTJKWkV5VWg4ZWVmbU5rTTJw?=
 =?utf-8?B?cFhmMVhyb3RzT21kTThLOG5IdVk4K212SG1ZY0F1bUZkU2cwSTFnaVE5STFP?=
 =?utf-8?B?bm0wekdJRDlwTUtxSXB6VDBLWkpsUElPTGlMVzEyaS9INUpoYVlxZkNVMktj?=
 =?utf-8?B?OW54WlpzM2dOa2VyQ01iVWl5MGUxZ1p2MFJSYUpJNUkvS0FDeGE2TjZMNkpu?=
 =?utf-8?B?RmsxbFg5b3poUnVSOEQ1WGoxbnBEUHIvSytqZUdnK2ZYVGNTYWk3RGt1YTVJ?=
 =?utf-8?B?NFplM1Flc1A1dW84S1ZUb0NlK2RjMko2Slppd0FVQUVrYWdFTUNwYVJ1VVE4?=
 =?utf-8?B?MGRETTUrQ2xVMG5Ra2tMZ3RLRC9Pa3oxRmM1cFF1d00vT3N1RW9MVG9RZ3Fq?=
 =?utf-8?B?bE50aUxrSWFORllRZjRNYVZ6ZnR3dzlaVjFHQlU5WWVBU1JaWjBSSU5hdVJQ?=
 =?utf-8?B?SXd2cFNQQUdZOGpkcXVGaExBL0syYWkvVnVSdzFiUDVKMEhDYWp2YlVJY2N0?=
 =?utf-8?B?ZVVaeWthVzNxbzJMb1dVUUtvdUZwYXpaWW1mOVdJcytTcUZyclVmUjdDNUs1?=
 =?utf-8?B?dURpdHdYOVE4Mk8yZzFvVW94T1VCeUlxS2xPVGdzRm5HdHo5V0h5a1drUUUz?=
 =?utf-8?B?WFo2NkRhb3NrTVZCQkc1Y20ydVhBeFdiR2lmcHEyWUFHUnQ3MGUxNjNyMkxC?=
 =?utf-8?B?WkgvazBoVHdUaUovY3FFU1lNeHRQVVluWUltV1ZVVUYvVnlvK1lXOVpaQ05o?=
 =?utf-8?B?MngvWUV0WGhnNjBzdmYyamo5aEd0SC9ZbDNnc2ROM2J5SEc2QmU2djNQcGtZ?=
 =?utf-8?B?K3l5dkE1c2dOeWJqb2dIcmtLRkliVURQaDlJK3FLVWJlUmY4c2loRjBWU0NX?=
 =?utf-8?B?SmtzU3pLcURGQzNKdE1Td3g2VWo3YmlBWGUrRTBGTjhGb2oxMkJ1MTh2OW0x?=
 =?utf-8?B?WnRFSE5scFRJUllDRlg0bW9kZXA5eTJEdk92aHAvWFJseE9NcmFQL2tXZ0Ri?=
 =?utf-8?B?WSs0SUxBWnlSMW13RytsNnVLa3czM0QyR0VkMUxYTGRMcmluQVAwd0F2L0l5?=
 =?utf-8?B?enpVVzMvMjZtU1BXdTdMQU1FcVRRWUh0ejVENXEwS0JNWGNCMzlkVysyVkxt?=
 =?utf-8?B?NDY4cVI5c1p5OGVnY2dhbmRrbmRxVWM5WVBQNTV4RHpoR0Vib245QmVadzBv?=
 =?utf-8?B?SnQxSEtYV2pZb3dKV201Smc5Z2JudzdrK2VpcVJab0NvVlF6R3MxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D08nLXvYsMZJJJBlQ9yZXA20k8mACjQ7UQEbACjzrKNE7xhiuO1/bfwpVojFjXj6EOUjYDV3q5YrbUsXmQDJZ2FtG8vU3w0o7cglAQQ8k2B9hdL4UiwfteeXmwa26eaUwq1AEMwTIeYZpZ/GeVt+fZmYvo4nCqehJoegbqpapUZc5XWR7CjGmbUr7Akz9yvwJpaM10Z9WM5VmuYLJficJjfISODsNAoytFWh5pH6aKalDxqJ5MAWBYhUNuynm3P2JcSRShWZL7fOfMhQgPBGPrUdtFDhIwXvMnABHRxtZiEm7AKxg4Ysu/sBCIXpj2/rVWJ55UiNi8ujOck7FJgNdQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fa0258-c839-4d2a-e4e7-08de7955eae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 18:51:45.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wr9aCOzRzY9sW4LTkxTXnT8eUd/QCPIx8KmmUBnhcfK6NfoL9Q8jsVcYqFRMLwfpRYmfcwR4HZaHjhKQrUHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgTWFyY2ggMywgMjAyNiA4OjI4IEFNDQo+IFRvOiBLaW0sIERvbmd3b24gPGRvbmd3
b24ua2ltQGludGVsLmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSB2aXJ0aW8tZ3B1OiBGaXggc2Nhbm91dCBkbWFidWYgY2xlYW51cCBkdXJp
bmcgcmVzb3VyY2UNCj4gZGVzdHJ1Y3Rpb24NCj4gDQo+IEhpDQo+IA0KPiBPbiBUdWUsIE1hciAz
LCAyMDI2IGF0IDI6MDbigK9BTSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4NCj4gPiBX
aGVuIGEgdmlydGlvLWdwdSByZXNvdXJjZSBpcyBkZXN0cm95ZWQsIGFueSBhc3NvY2lhdGVkIHVk
bWFidWYgbXVzdA0KPiA+IGJlIHByb3Blcmx5IHRvcm4gZG93bi4gQ3VycmVudGx5LCB0aGUgY29k
ZSBtYXkgbGVhdmUgZGFuZ2xpbmcNCj4gPiByZWZlcmVuY2VzIHRvIGRtYWJ1ZiBmaWxlIGRlc2Ny
aXB0b3JzIGluIHRoZSBzY2Fub3V0IHByaW1hcnkgYnVmZmVycy4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggdXBkYXRlcyB2aXJ0aW9fZ3B1X2ZpbmlfdWRtYWJ1ZiB0bzoNCj4gPiAxLiBJdGVyYXRlIHRo
cm91Z2ggYWxsIGFjdGl2ZSBzY2Fub3V0cy4NCj4gPiAyLiBJZGVudGlmeSBkbWFidWZzIHRoYXQg
bWF0Y2ggdGhlIHJlc291cmNlJ3MgZmlsZSBkZXNjcmlwdG9yLg0KPiA+IDMuIENsb3NlIHRoZSBk
bWFidWYgYW5kIGludmFsaWRhdGUgdGhlIHJlc291cmNlJ3MgRkQgcmVmZXJlbmNlIHRvDQo+ID4g
ICAgcHJldmVudCB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtY2xvc2Ugc2NlbmFyaW9zLg0KPiA+
IDQuIEZpbmFsbHksIHRyaWdnZXIgdGhlIHVuZGVybHlpbmcgdWRtYWJ1ZiBkZXN0cnVjdGlvbi4N
Cj4gPg0KPiA+IFRoaXMgZW5zdXJlcyB0aGF0IHRoZSBkaXNwbGF5IGJhY2tlbmQgZG9lcyBub3Qg
YXR0ZW1wdCB0byBhY2Nlc3MNCj4gPiBtZW1vcnkgb3IgRkRzIHRoYXQgaGF2ZSBiZWVuIHJlbGVh
c2VkIGJ5IHRoZSBndWVzdCBvciB0aGUgaG9zdC4NCj4gPg0KPiA+IENjOiBHZXJkIEhvZmZtYW5u
IDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gPiBDYzogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVml2ZWsgS2FzaXJlZGR5
IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24g
S2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+IA0KPiBBY2tlZC1ieTogTWFyYy1BbmRyw6kg
THVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICBp
bmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tZ3B1LmggIHwgIDMgKystDQo+ID4gaHcvZGlzcGxheS92
aXJ0aW8tZ3B1LXVkbWFidWYuYyB8IDI1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAg
aHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMgICAgICAgICB8ICAyICstDQo+ID4gIDMgZmlsZXMgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tZ3B1LmgNCj4gPiBiL2luY2x1ZGUvaHcvdmly
dGlvL3ZpcnRpby1ncHUuaCBpbmRleCA1OGUwZjkxZmRhLi42NTMxMmY4NjlkIDEwMDY0NA0KPiA+
IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1ncHUuaA0KPiA+ICsrKyBiL2luY2x1ZGUv
aHcvdmlydGlvL3ZpcnRpby1ncHUuaA0KPiA+IEBAIC0zNTcsNyArMzU3LDggQEAgYm9vbCB2aXJ0
aW9fZ3B1X3NjYW5vdXRfYmxvYl90b19mYihzdHJ1Y3QNCj4gPiB2aXJ0aW9fZ3B1X2ZyYW1lYnVm
ZmVyICpmYiwNCj4gPiAgLyogdmlydGlvLWdwdS11ZG1hYnVmLmMgKi8NCj4gPiAgYm9vbCB2aXJ0
aW9fZ3B1X2hhdmVfdWRtYWJ1Zih2b2lkKTsNCj4gPiAgdm9pZCB2aXJ0aW9fZ3B1X2luaXRfdWRt
YWJ1ZihzdHJ1Y3QgdmlydGlvX2dwdV9zaW1wbGVfcmVzb3VyY2UgKnJlcyk7DQo+ID4gLXZvaWQg
dmlydGlvX2dwdV9maW5pX3VkbWFidWYoc3RydWN0IHZpcnRpb19ncHVfc2ltcGxlX3Jlc291cmNl
ICpyZXMpOw0KPiA+ICt2b2lkIHZpcnRpb19ncHVfZmluaV91ZG1hYnVmKFZpcnRJT0dQVSAqZywN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX2dwdV9zaW1w
bGVfcmVzb3VyY2UgKnJlcyk7DQo+ID4gIGludCB2aXJ0aW9fZ3B1X3VwZGF0ZV9kbWFidWYoVmly
dElPR1BVICpnLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHNj
YW5vdXRfaWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRp
b19ncHVfc2ltcGxlX3Jlc291cmNlICpyZXMsDQo+ID4gZGlmZiAtLWdpdCBhL2h3L2Rpc3BsYXkv
dmlydGlvLWdwdS11ZG1hYnVmLmMNCj4gPiBiL2h3L2Rpc3BsYXkvdmlydGlvLWdwdS11ZG1hYnVm
LmMgaW5kZXggZDgwNGYzMjFhYS4uYmQ1YjQ0ZjVmYiAxMDA2NDQNCj4gPiAtLS0gYS9ody9kaXNw
bGF5L3ZpcnRpby1ncHUtdWRtYWJ1Zi5jDQo+ID4gKysrIGIvaHcvZGlzcGxheS92aXJ0aW8tZ3B1
LXVkbWFidWYuYw0KPiA+IEBAIC0xNTEsMTMgKzE1MSw2IEBAIHZvaWQgdmlydGlvX2dwdV9pbml0
X3VkbWFidWYoc3RydWN0DQo+IHZpcnRpb19ncHVfc2ltcGxlX3Jlc291cmNlICpyZXMpDQo+ID4g
ICAgICByZXMtPmJsb2IgPSBwZGF0YTsNCj4gPiAgfQ0KPiA+DQo+ID4gLXZvaWQgdmlydGlvX2dw
dV9maW5pX3VkbWFidWYoc3RydWN0IHZpcnRpb19ncHVfc2ltcGxlX3Jlc291cmNlICpyZXMpDQo+
ID4gLXsNCj4gPiAtICAgIGlmIChyZXMtPnJlbWFwcGVkKSB7DQo+ID4gLSAgICAgICAgdmlydGlv
X2dwdV9kZXN0cm95X3VkbWFidWYocmVzKTsNCj4gPiAtICAgIH0NCj4gPiAtfQ0KPiA+IC0NCj4g
PiAgc3RhdGljIHZvaWQgdmlydGlvX2dwdV9mcmVlX2RtYWJ1ZihWaXJ0SU9HUFUgKmcsIFZHUFVE
TUFCdWYgKmRtYWJ1ZikNCj4gPiB7DQo+ID4gICAgICBzdHJ1Y3QgdmlydGlvX2dwdV9zY2Fub3V0
ICpzY2Fub3V0OyBAQCAtMTY5LDYgKzE2MiwyNCBAQCBzdGF0aWMNCj4gPiB2b2lkIHZpcnRpb19n
cHVfZnJlZV9kbWFidWYoVmlydElPR1BVICpnLCBWR1BVRE1BQnVmICpkbWFidWYpDQo+ID4gICAg
ICBnX2ZyZWUoZG1hYnVmKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3ZvaWQgdmlydGlvX2dwdV9maW5p
X3VkbWFidWYoVmlydElPR1BVICpnLCBzdHJ1Y3QNCj4gPiArdmlydGlvX2dwdV9zaW1wbGVfcmVz
b3VyY2UgKnJlcykgew0KPiA+ICsgICAgaW50IG1heF9vdXRwdXRzID0gZy0+cGFyZW50X29iai5j
b25mLm1heF9vdXRwdXRzOw0KPiA+ICsgICAgaW50IGk7DQo+ID4gKw0KPiA+ICsgICAgZm9yIChp
ID0gMDsgaSA8IG1heF9vdXRwdXRzOyBpKyspIHsNCj4gPiArICAgICAgICBWR1BVRE1BQnVmICpk
bWFidWYgPSBnLT5kbWFidWYucHJpbWFyeVtpXTsNCj4gPiArDQo+ID4gKyAgICAgICAgaWYgKGRt
YWJ1ZiAmJiAocmVzLT5kbWFidWZfZmQgIT0gLTEpICYmDQo+IA0KPiBNYXliZSBhZGQgcWVtdV9k
bWFidWZfZ2V0X251bXBsYW5lcygpID4gMCA/DQoNCkRvIHlvdSB3YW50IG1lIHRvIGFkZCB0aGlz
IGNvbmRpdGlvbiBhbmQgcmVzdWJtaXQgdjIgb2YgdGhpcyBwYXRjaD8gSSBzYXcNCnRoaXMgcGF0
Y2ggaGFzIGFscmVhZHkgYmVlbiBpbiB0aGUgcXVldWUuDQoNCj4gDQo+ID4gKyAgICAgICAgICAg
IHFlbXVfZG1hYnVmX2dldF9mZHMoZG1hYnVmLT5idWYsIE5VTEwpWzBdID09IHJlcy0+ZG1hYnVm
X2ZkKSB7DQo+ID4gKyAgICAgICAgICAgIHFlbXVfZG1hYnVmX2Nsb3NlKGRtYWJ1Zi0+YnVmKTsN
Cj4gPiArICAgICAgICAgICAgcmVzLT5kbWFidWZfZmQgPSAtMTsNCj4gDQo+IEkgYW0gbm90IHJl
YWxseSBoYXBweSBhYm91dCB0aGF0IHdlIGNsb3NlIHRoZSB1bmRlcmx5aW5nIGZkIGhlcmUgYmVm
b3JlIHRoZQ0KPiBuZXh0IGRlc3Ryb3ksIGJ1dCBJIGRvbid0IGhhdmUgYW4gaW1tZWRpYXRlIHNv
bHV0aW9uDQoNClllYWgsIEkganVzdCB0aG91Z2h0IHRoaXMgd291bGQgYmUgdGhlIGJlc3QgZm9y
IG5vdy4NCg0KPiANCj4gPiArICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAg
dmlydGlvX2dwdV9kZXN0cm95X3VkbWFidWYocmVzKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3Rh
dGljIFZHUFVETUFCdWYNCj4gPiAgKnZpcnRpb19ncHVfY3JlYXRlX2RtYWJ1ZihWaXJ0SU9HUFUg
KmcsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3Qgc2Nhbm91dF9pZCwg
ZGlmZiAtLWdpdA0KPiA+IGEvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMgYi9ody9kaXNwbGF5L3Zp
cnRpby1ncHUuYyBpbmRleA0KPiA+IDY0M2U5MWNhMmEuLmIyYWY4NjFmMGQgMTAwNjQ0DQo+ID4g
LS0tIGEvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMNCj4gPiArKysgYi9ody9kaXNwbGF5L3ZpcnRp
by1ncHUuYw0KPiA+IEBAIC05MDIsNyArOTAyLDcgQEAgdm9pZCB2aXJ0aW9fZ3B1X2NsZWFudXBf
bWFwcGluZyhWaXJ0SU9HUFUgKmcsDQo+ID4gICAgICByZXMtPmFkZHJzID0gTlVMTDsNCj4gPg0K
PiA+ICAgICAgaWYgKHJlcy0+YmxvYikgew0KPiA+IC0gICAgICAgIHZpcnRpb19ncHVfZmluaV91
ZG1hYnVmKHJlcyk7DQo+ID4gKyAgICAgICAgdmlydGlvX2dwdV9maW5pX3VkbWFidWYoZywgcmVz
KTsNCj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0KPiA+
DQo+IA0KPiANCj4gLS0NCj4gTWFyYy1BbmRyw6kgTHVyZWF1DQoNClRoYW5rcywNCg==

