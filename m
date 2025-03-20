Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E8DC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCCS-0003fq-0Z; Thu, 20 Mar 2025 05:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCCP-0003fW-5Z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:28:25 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCCL-0005ZL-1u
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742462901; x=1773998901;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QrDTpLqgmPZ7qsKCpuEo71aVsyaxgnW5fxcjAF15/L0=;
 b=JFB/HVsU/4lR2N4lPwS5xs3rczDj+y1JSsd+/UtkdThnx4Ed+N4iGcty
 9fcCsqTx8OGx75dA8TjIyHn0AWoZeKCFwb7NDBFG9X8JU8XYCWSuXmD0E
 NO71ZkJq59GiGdlpdzWfPzawqZV99XyA0gZeR99V7z5jDm9tqwgf6H91P
 Ckp7f5xEAdSJdXwRxehS0QbjXdhlN5z/kt2ycpPH9DDir8DPsVsa851Ev
 o6t5StGP0BAm2wrRkcD0KIbg5xzYVjdlnRMfLFgQN7wZDFBK+9ADFUVrc
 sxFEf2+JDpC0U8uIoJKnvHiQBQWlUKw9aXorijCYFmOFbhSiqwaHnBS2E Q==;
X-CSE-ConnectionGUID: IMA3wnSET8iwwYGx7GuCUA==
X-CSE-MsgGUID: Tc7pHw+oT2ehXNeiETHlzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54675650"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="54675650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:28:19 -0700
X-CSE-ConnectionGUID: 7DyGFy6EQgSaapFP7B5dzw==
X-CSE-MsgGUID: /n11UCGXQoWQxZn0/3E/eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="128102968"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:28:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 02:28:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 02:28:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRRdJgQ8mlJF5kpwRmlNvmVu1bGQHFjwUlxx0pk77Gdrpg222TTTwdCu1QwAV73vbhQYBL8f0QQ+OfCr/plmYJYih/OmMag21T5pd/nQPzmRM93jJwJJAwRlOr7RsfcPDyxj1MmBgjrriUIhCIATyfSLAm4bIA/m+iop0Lx3cPoMKZJsVGZtjArLZ8uP5fn7t/DamiPofOeDpTbdg2nVTTUlE09GpRXNsqAKvLpNbWp7Qtg/sYjFPHzS/FTq+1oBxWbe642B26ILAeJOdf8nO/zRctw7HTNKxm7J5vCcJyYO5mJU7e59HW1NUEVOXn4FOU1jS9o49RTlDhJRL/0kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrDTpLqgmPZ7qsKCpuEo71aVsyaxgnW5fxcjAF15/L0=;
 b=TtAZKF1JTKjoDvF8EMCUyw8fWo6FOTVQpAxThVoGHqyci+kyc5orwL7CaFByXmWi06loG+SHqzjIMppwxQwM/DcYRURMQFDfzdG60cvQISE+OMlcj6xrNd02jF9ildc6K4QLParqgDZZIQ5ao1x/3FVhMhk8nMKMl6G+y/2/2xuHH0REmJMwmZZiRJyoLQDXvzCEQE4we23OTgRU+u9p4Bl9mEIK/wR4SyjhiNKwTOgyuf4WDVhyKebCWq0q/28pmGncjdfLr+ALdXZWLkv5XZcwbWP9LJa5gKl8Sy+AhLLUJ8QNsdVb4UDF0obE5w+dfWcG5JNMfb2yPoTbLrqiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 09:28:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:28:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 12/32] vfio: Make vfio_group_list static
Thread-Topic: [PATCH for-10.1 12/32] vfio: Make vfio_group_list static
Thread-Index: AQHbl+vpY4eS/SRvwU6T6F6v/izQ+rN7xKWA
Date: Thu, 20 Mar 2025 09:28:03 +0000
Message-ID: <SJ0PR11MB6744265AC4FD1A2FBC59982A92D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-13-clg@redhat.com>
In-Reply-To: <20250318095415.670319-13-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4574:EE_
x-ms-office365-filtering-correlation-id: 07fb643b-9df0-493d-055f-08dd6791838c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Yk3VCADsEfuyIKZw0yrQKwH5VzWWe/ClE3Fg7RGcOn81IWPrbndEjqgfVe?=
 =?iso-8859-1?Q?feI3SGah5hh4HK03MuW5zJRwb+KG0H03PcY9aUQmtefjDbHCzg8ZifraEp?=
 =?iso-8859-1?Q?ekkbrc0N2SEGtVOeLnN8CO1qt5oWk0/4MwnHR2sMEGhiO7H3PQMoX1trVB?=
 =?iso-8859-1?Q?7AzuGnhn547fllHBmAht+LENB6BoURJXRGiRD39gJoCoGceN63xuUvVwvx?=
 =?iso-8859-1?Q?bZIgrspZ1jovzqLSPbFlYERp96gfuTW01TDOp+dH7PAo4niMX2h+Z5xYMV?=
 =?iso-8859-1?Q?SkPgZ58lTRjK8bdxJeXB4crqG3wkSh1z4nrNIlSkwVStzXwMovUqXdTC0O?=
 =?iso-8859-1?Q?ch1OGRmIW6OCfcYTXr4e/zeWOtAQAkxi2TOKs3BsPrzGOuDREF3d25JzDO?=
 =?iso-8859-1?Q?BZuCw/xG6Cg122+KH8+08p8xHRIFcJR8lYSoe0u57hUsF7MvQ9IxXWmjLV?=
 =?iso-8859-1?Q?OjbsjPUTtxko55/Dy8Ivm0URelWVEL52uA1lIe0UGssmRPuaxxHIGwSMOa?=
 =?iso-8859-1?Q?jnJjZiXPat2WyQ8DqoxkLdonTU9mZXMPIgLwS/32TpaDbcMRtREgv4pY9p?=
 =?iso-8859-1?Q?HacK9WUy7F6jdc0MjAnfh4s1UoctB+GOQAXLoSFMG4RYqcOO+X7cRB+c4E?=
 =?iso-8859-1?Q?Aqqo6oLUxL+teFAcmnwRAXA4wO+oBH1lNdlz5SYN7JokNJ7qv/L1EzlTYS?=
 =?iso-8859-1?Q?zdaoqXXkwgpa2tsAbhI4+A+odxmQl3GpPN0NCJslnqmKowfdvUP90LcgsK?=
 =?iso-8859-1?Q?smEK7PtgmQYnSLSlhTcZ2qe0+lE6K1YMoMdlFdpK/473IULJGoLpj/5IrC?=
 =?iso-8859-1?Q?o52nX5QElnTMrIjPRYdHpzOEG8+e8s/40C2oARec/2z5uJ3oHKxjoKWcuU?=
 =?iso-8859-1?Q?4av5YFhn8rgj873sJhdkGy5IvQ9wk3CVe9nk2ovG07t4VxrIC4pBsbMjnv?=
 =?iso-8859-1?Q?qGLdDTukgS8n1BURjLZIKu7lCr3GbEZdqnC0+NYxiVHir3xsCxdiko37s1?=
 =?iso-8859-1?Q?+UOgpb0we3q9I/cJ6zQxeei3XD357OG3HtDcc9Hg1Jba8gi/5CJ+ZMu+W0?=
 =?iso-8859-1?Q?zXYFUIz3vForMbKhe9khZpS3X3l+dR3NEgYMP8R3qnzKAprFjo1wktR4r9?=
 =?iso-8859-1?Q?sD6M5+96URjT7BQEV1Aq4VHJi4iPO0OWg7lWwpk9KlEpYnqpBJrlnTUzT+?=
 =?iso-8859-1?Q?q9aDrypS6r02eCdBojCFrjMEI9O27WXeFCo6qupcaAM/ZD92OWD+1XycE4?=
 =?iso-8859-1?Q?KwOmE2ZWT3jxBbldh2WH5gn0wT6gJpZgqGWRUx9D+YlV7fWbPgNuM7Cpet?=
 =?iso-8859-1?Q?onJOjCTvVEUwxuHJZJjl1m1o6XMfv+dZt91lzCVUqxh1XzIJfhB9oSFc4h?=
 =?iso-8859-1?Q?n/eap+Dus504f7B1hbuHYB1UIShNm0CQ7yLVAbIhAto8eVQ9UMEEAHO6ng?=
 =?iso-8859-1?Q?yFS6y6suUWiydKaszqyDrqByBz3VL2x3NJXagDz8HvjouAXBG3ORo8zq45?=
 =?iso-8859-1?Q?wY446ivyfUH15jWTkB6Nlb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2ZMesy8Hautc3ULc/RaFjvTtTO4zPhlVcXxqidADUJoz/D42JfTHYb30sY?=
 =?iso-8859-1?Q?qUl0HtNtYwd1amkCRan1aJrtzaI82ZSJQq1vgwW4iECd+8fcEhShA5IDaZ?=
 =?iso-8859-1?Q?PKfxkWNwm/ZE0ecbXwDp7i8N6OqPWccExj3rh/bapINoAbGsdVOVXZT4sG?=
 =?iso-8859-1?Q?Q2l8kz+FsFWrR59YlBMTLck0h95dRV2Ztj1RXsek4B6a3fYk34+htM3flq?=
 =?iso-8859-1?Q?wFj1cXPfvJizFmotK2xinMMUSZPdvcsdp9y7Bd45X5Ap5ahXHqT8snLdAo?=
 =?iso-8859-1?Q?IoaaSdLOEy7cVonXsb6k5YtLWMd5ZpqrJD1ru4FXLkb7VHm5PCeNqdUonK?=
 =?iso-8859-1?Q?+xgUBXbaGeHzf7t072DxDAAMfe7Zqx639MA0zbB++s8h0d0vz9/eM3drl6?=
 =?iso-8859-1?Q?SCs3DqIFrjXQabCnT1dwLkNr3KHOj6vqud0vMYC2sLaH/OJV+doWtIJtnZ?=
 =?iso-8859-1?Q?Cm+8UmWluebqjyhepKh5zThMbJ/ovVfWcC7C42AHAoO0V6uEIWlYBdEn0N?=
 =?iso-8859-1?Q?FL4F9S8PisHL6t3kncr4KZcpuEgs8C9aEdZm6Sm6SsEpmcdNOrqhBzdxnC?=
 =?iso-8859-1?Q?bCBSv6OmN0UtcVr3SPT5bwCMH08z63z0vZfNLvajgmW5MLrkz+wq3bvK3N?=
 =?iso-8859-1?Q?I4upsN2BMydhvUPlDBJSXQupO34xUdlPCKjO+enbbH8L00gz3amePn4VB7?=
 =?iso-8859-1?Q?BMZ9IBuqwzKVTE/ibtGUSYbMWdJfkIkiQQEE9UV+mxH/GxArMTH1+tbpAE?=
 =?iso-8859-1?Q?AnKnUdf43tIfpVLBZKNX3bTpdAgBnlrLB4P4btEOsWJBM5sqp7Tc2CHBTo?=
 =?iso-8859-1?Q?H+pXOkE9QgdDFaGId9sqOXu0GqCUzGET98UTCvgp1u7I5NZrIHK6A5zrg2?=
 =?iso-8859-1?Q?l9XraqBUcHNb8S4SOHTftmYuOzDIlJpIFJwZhrDuieB2H4Vpy2zGXqhfNW?=
 =?iso-8859-1?Q?gp01WfE4M78GWRkk0hxuu3rAmRITgJOUNzh4keXxlqZ3NhHKugtJuRiuvd?=
 =?iso-8859-1?Q?3a0RvjABXTFAdSRoYK9Y2k7oy5gHzvQP2r58WOelB0gkWcPXvtXfwafBJu?=
 =?iso-8859-1?Q?JoU8otA3cZqkNi27pgojBfhu4UnFQQcg1HMxNL/OzPcBIBm0EqbrboUKYk?=
 =?iso-8859-1?Q?j511nIcTIApdiir4l2rDXYvKrR8vTHImzCF2yiO7EW7BIE7GaDLLkTTtge?=
 =?iso-8859-1?Q?6iaUFrGqqBYugMOHR+TckjVj1jiWS/RIUVWA5sndxK2g5VoJy4h8r1I3sL?=
 =?iso-8859-1?Q?ycEYm++KBSOU+whh5d6WzXmU8ygFvUjUKRN6wSVdIL3nqZuMhBpl9CW/KT?=
 =?iso-8859-1?Q?SCfS4JmrlDZR2/jn7PA1IxQhxKJyupRBO04RRx7StP0JZbvOeqjIs1Gpah?=
 =?iso-8859-1?Q?Ov2UxVfbMMzFmWf3tmFTW8vlX6EvaqZyS3M7DYW7+r2eEhxAhofdKIqA8l?=
 =?iso-8859-1?Q?NiNy90xGLoxxjl6L6VZ0wl7SGQ00Cd+EeQ+ejGZzpcR8Wu1B8/YvRwLx7k?=
 =?iso-8859-1?Q?yeOOJlcuN+1FAFs+nBGpNGqZ8aZGF7YNpogcUC0pNEPPm+XJ8zNWG8oVbq?=
 =?iso-8859-1?Q?NIH05CqWlJOYL9Zp0+ZQepoHYAwKRa5cx3dGOdACSpx5P9Zr7GUDF+k0d2?=
 =?iso-8859-1?Q?dGYJKPuHfzlagM0ZaGF5HxMYsNcK1Yr0Z1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fb643b-9df0-493d-055f-08dd6791838c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:28:03.1259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lT9YA+bqQPZLyuMsUCtx+sENQnK63RMNH4jtG8KPwTYl6DTalHGqyzFItCGGX6QgiK7kbD9iKccJz8EVkCkwhFitq1ShFf8qiHEdarL5fUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: [PATCH for-10.1 12/32] vfio: Make vfio_group_list static
>
>vfio_group_list is only used in file "container.c".
>
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

