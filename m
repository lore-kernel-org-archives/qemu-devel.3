Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61819109C04F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5SFz-00083v-CE; Wed, 25 Mar 2026 13:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1w5SFx-00083a-Jn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:43:01 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1w5SFu-0004dA-VS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774460579; x=1805996579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ODEppahQ/VA+aEi14B8ZbOW5wG2banCmZbQyj5hXHuw=;
 b=Q/EEU1GKb6duiAj0SC0kpR5lnXfLjZ2VRv80KriDNPcbvyWRzyVyVEUD
 aijoDVOx81ncFjDs1eHK50XlfWzpoL41XITU/CwY4e1IpUM2q4Qe4I36a
 BeG07z3D2CTIQh3HwBBYMQv7U8h34d61PkkGBbRMsmv0tNeVZWT3d7N4D
 MveUSpwQVfkk0pKRQcRRWBzbut73xKwHnuQ4fsSiNrIO1lxQGmxdhVcb6
 G2MKmpl5Eh76N/sNPRitC0ZFXJ4p1b/lBbgT1IFF3y8EMKUauQytuPO3N
 DoiAC5wVblUGJ7KI90ITIm7nBBxx/PuEojoQ+/csSVN+jU834CSPFsGr6 w==;
X-CSE-ConnectionGUID: kA50zQktS/+BLnJDwOqUHg==
X-CSE-MsgGUID: aAcbbYy4SeShRdtOKfimiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93085605"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="93085605"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 10:42:53 -0700
X-CSE-ConnectionGUID: 9QjrNEq6RsiiQ2m6vdcfaA==
X-CSE-MsgGUID: Kr0XToz/QayQ01tJwLxzgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="255245948"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 10:42:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 10:42:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 10:42:52 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 10:42:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ejp4B0GSAR8HA2SyAybPzK4FM2lXP/zpuIfVv/5dgYTi9nXE6zPw9rpmWfMNefFddLxQeRZ4AXt5QynfnmthefyBfcyqkE74id8e4qQs4TU3R2O+nGR8S7NKWJhUGAbmI9XiMAMGssFc0q2lHBhy7w1+eKGwb8qwWoenmf5aqrUAO44VRygjlHQ7IswfYdl68I8rRkIw3gl5oEX2zA2GLFsG1kJrp76uLFyiIxI+b5I5T0xQzF5ZLgQ6TalFivRQSLc6m7n9mJjXUL5bMKn29OsaJEvPp2u5Gxrkf2iUd+MJd1L0KADpB2owFLcyXVbPHTeJ+JWLLKw1MyXqtMKuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODEppahQ/VA+aEi14B8ZbOW5wG2banCmZbQyj5hXHuw=;
 b=EKzNMU0ryKyh531bAbQJwZ+8cT/0vgUVeU47gLMaNyDXHO6JyszBW9b/9EAKh7YwNQKIJqochz/RUYqSq3A+U/ddknB7C0U9DJ3K1bbI306YfLzBYQHN2TEro0e3ChXju/GK7JHK++WP4T5y+tJnZMDXSqwiadjNQvEHXLzodlHvy74wE0tLdJZmey8cJ7CQtTLVcrqDizYQ94nscYqRKRZkNJ92ewS8EtQsdN/YXa69ISWBBn4pz1ojfCB9/4h0Ej3EX+0+NhzDa4KfNmBtjHop3cH7wOX+xbUojvN5WLMP7nsJMA+rWYqF2PNyZpdepNZHrvs0D5GctI9zQCYTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 17:42:46 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 17:42:46 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/egl-helpers: Fix FBO recreation and prevent texture
 accidental deletion
Thread-Topic: [PATCH] ui/egl-helpers: Fix FBO recreation and prevent texture
 accidental deletion
Thread-Index: AQHcqq0QiPc5bVuB6UWuSwHvKc7PZrWyxCWAgAzbR7A=
Date: Wed, 25 Mar 2026 17:42:46 +0000
Message-ID: <PH0PR11MB5112E470E80EB9B8C586D807FA49A@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260303010844.1925737-1-dongwon.kim@intel.com>
 <CAJ+F1CJ9E9YyWMcJVTSRz2ehJegQbuud8T4j4vqowubnBg_iHQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJ9E9YyWMcJVTSRz2ehJegQbuud8T4j4vqowubnBg_iHQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|SJ2PR11MB7454:EE_
x-ms-office365-filtering-correlation-id: d9889619-26b6-43d1-1150-08de8a95ed18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: jaMhUaGCPwuMmcvwpYS1mQIDhOBL2amhr9wZR131pM6Y166VzyRf9BTPvd0RSCbjYHzISvaL2SO5wL1kYVm38ky5HiUC7DkrVMWdLJv0B7bVZWZ61p48q3h87koem8STl0p0N9RYDE0qcPg3z5j1E5C87G58HKMd7PK0PqhlUvF+CC4sgAXfzpL2Sy6kFWDqyUnpUOlvW7XgOenx402P3+YT2L4dauDEZH1Awv9c9S4XZp9YvBez5fzIsWmTiZbXwRxAME2J1ofHFki5pBEekyumWuBwpAhtGPtw8qPLZGaoidr6f+pSWH2BO/7tmk/4JpwXihwZWwKWZRn1rSg/Dxb4tYoxEXhXe/GNKZ5q9YsKGOOStWKq0pwRNFaLnNl8L6QTVWuEaUAazPVuIZCAjNqblHwcjq3yIzuyjr9MxRFVwbbCgWTiwsH6Z2sK5fZmBz4MGGRC0WC9eQPcbTiA9eLuWIy1mNxeZIo6aIhMadub5Gat2CduyFL65U2MCf1p/PVJ+di/NNRAF7a3dP2OmabSa3RyTaOW/7siN/qHyDqWN/6hBa4IRMp7Kga9EZpZ/ulOasRKD+cRRcpyb7qxiHovYK8hWXCDEe0gVnwdfK+bpWMAqtu7V1BTN2eEhJOK15fkU23VkH8eRoaVWctj2MxOv1+suMO35cDcEAc8A2iiD2yiNhFPdYETbxFL8TRAduY1nbGCezPnxbsnhrnG0vSmzNSTLA4/zHgKSPe/HadYyCj1v+nsOXoSc5EZTpY60aN7SZROESe3sFy5S8b+BDpsXy43m+7pcho4iRgkgEo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU1MVHhHTjk5eDQyN1JlejJjeDNDM3lUeldFWGVpbGx0a1p0ckVRODJLaXdz?=
 =?utf-8?B?TTlsNlliODV2dHp0clQ0UG85TUFtWnlWazlQWktTMnQ3V2JuOVVvYzlFSjIv?=
 =?utf-8?B?RG9ucS9vall2SEJGcS8zbGNlSzBCczZpcy9mN2RBM2lYb2N6OHNOUGhBdzBt?=
 =?utf-8?B?RFRIa096anN6cG9IU204VytVaDNkNmZPUXhrQ2JKbUp1Z1RvU0w3VXZ5VWdB?=
 =?utf-8?B?c3M4RnhwYnh0VDZaS3B6cWJ4Y1c2V2JuTGxGa1I2RWtSalFtSXIvM0hxU1cx?=
 =?utf-8?B?YWdPTHFVUzQ3NzhaK3V4M3ErVWpMbWhIYUZML2h1bDFRUExzc0xGTWpvY3VR?=
 =?utf-8?B?c2pGelRzTllWMUZjbXJuekFtZGJiUm5VMXZDUmRhczJXTksxNmd0OVJkOWRw?=
 =?utf-8?B?WHMvd3dvWXZ5V29JN1NLYWk2VHczdmQ5L1paSVlPaTEvQWFvMm5iVUl1bmVm?=
 =?utf-8?B?Y09zbkh4ZVdoZ2lZZllwNEtmUmROdlZuMlM1U2I0V2RUUWUzMzNPR0JMTFRn?=
 =?utf-8?B?Z0hXdDdjN0M4dGI3cHc3Mm1US3Z1OHpYajh2OWtLaWdxU1NTY2YrUnRqVS9m?=
 =?utf-8?B?U0ZTN0JCS0h4WG1GVlMyWStXNTVaR2o1WTI2a3ovdHIzbUdmdHJqU2cvVUxG?=
 =?utf-8?B?R3lDbWF3ZjM0WHdjbmJobUN5cHQzbDd0alZYNjBrN2Nvcm13OGU3cXZwNkI1?=
 =?utf-8?B?aUd1Zm9QYlpEOHBoeTdNMm1uemlCVm5ieUplR2RuNW1kZXM1YkwxZ2NrWlRt?=
 =?utf-8?B?OUpGU2dWMENUS1NXNzFpWjZ1b0hMajlrM21RQU5iWmFHZ0F2czZuRXdiT0JR?=
 =?utf-8?B?WkZLRnRoVE9nekRuYWs5M2hoOStoMG8xUzd4Yzd2ZVRCb2k4ME80Lys2ZEQ3?=
 =?utf-8?B?aUU0b0RqTmZ6UWhWS3o2bktjVVhJTktXTHk5L2U5bEVuY2V5QXZvT21iNXZU?=
 =?utf-8?B?dkhzNk5TV1ViamJySmIxamhxdzM2eEFIVlVUQlRDbm9FWXZnUFptTElWcTRy?=
 =?utf-8?B?cGxiRkdQczdERnA2TFNSelVZc1BzaEpiZ2JUV2o0UkJJYkJHcGVLK0JPVG0y?=
 =?utf-8?B?aUNCajdsOUdLUUJhdmdnNUJ2N1FSVVJYQXpnclFCOXpxOEdreVB0cm9CRUZZ?=
 =?utf-8?B?Z2lVU0w2eUZ5SThnLzZ2Y1F0dnR5ZllWeFJoQ3NJd0NLdW5oV21udFBlbnJE?=
 =?utf-8?B?dDRSNkdtY0k4RzFKMVRqMWFzeGdKcDVNMjFkODBaa284cS9Rdytia0NzejJr?=
 =?utf-8?B?QXVoM25JamFuRE1HZGlZaXdDeE00NU84RzY4OXdzNlVVWWQ4VlgreDlJa2Z3?=
 =?utf-8?B?WXN6ZDdyZGRtSEFXZ0w5b2ZqaG1VSDF1VzhxZk1pYnF4Y2hNZkZWOFlyY3Ix?=
 =?utf-8?B?VFFhUHNrYWRackVMQUtnam5BTHJxTE5qTHlkR0x2elN3N2dJK0RmZSt6OU1Q?=
 =?utf-8?B?Y3M1TjBjZ0hMQmhJaHBsYldKSVZQRmtueHphWmk1NldGREd5b3ZSRFJxbHdq?=
 =?utf-8?B?WXUrNk9kQTRrTkpaTTcrcmJqdk5zQ2ZJUGpDUURodVQwQ2pNbEk4RjR5akoy?=
 =?utf-8?B?QWYyZERaemRMRUpsdVV5SFk0ZkpVL1VGcUdaSUpLNGJFQ3daSUcwd1MxRlBN?=
 =?utf-8?B?cjhpWGFZMGxIQnRITTNyZVhZTThXVjZKZ0FSK1N3bXdTeWtxTnhnL0xleWl3?=
 =?utf-8?B?aWgrWDN5RjlUbnZLSUVtNGxxNVExV0RLU0VxN1JMTUdVeEwwWER0Mmx5SGhC?=
 =?utf-8?B?VVhxT3NXeVJyay9tdEVDSVVpWnVTcUxyTXloeDVIYzR3K0RVVXBxUjVCSlQ0?=
 =?utf-8?B?cktzYVdYai9WUytJdTJreVQ3TU00QTYvc1hzT2dQVW00alBFSkh1RGFjRUNi?=
 =?utf-8?B?UzFkc21oMUlpTkVzczNKUGdmVktxTzVtY0puUWlac2x6OE5FOU1hYjZnUXZZ?=
 =?utf-8?B?WERIdWpCbmdzRThiUHoxOVNHcjE0TGJpWU5DWlF4ek9nMS85TGRyTUM0eWZF?=
 =?utf-8?B?dVBLY0Q3UEhKWlBTR1BtbUVlR01NUFBtZ1FMMzVYKytOQ2RUb3RUbUZGb3pj?=
 =?utf-8?B?WS9LNFQ0TEx1VG0yVzRsUkoxa2xsK1VvSkFxbW9CdVNOeXdCVTEwRmJhdjdB?=
 =?utf-8?B?RWNqQVN0T2Z4ZHZkMFJNcHZpdytJVlNxdnpGUTd0dWNGZ0hGNkRLcjh1c1N0?=
 =?utf-8?B?UVZVVW5XM2twWnBmTDVHNE9WaGJaSUVrSEZzZmlVSTB5cTZVcW4wcDFtbHEy?=
 =?utf-8?B?VmkwcDlRQmFmRFlCL0RtWFhVSy92UmptcHlxVUdHRnZzMnMxa0ZHc3dubHlE?=
 =?utf-8?B?Ti9ieWVFTllpdjd5S2FjMWtBS3BFVUJwNG1MTEtuNHZWYXZibjJNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jHZAmjqNbJGzrWPsHPUaDG1lW461OtwGT/T7qeh6oTxtgigU3f0p8vXScelZnuXArJqzq25d4qSuXxGFCEFaUucvSCIfGHPZgz33guLK25SNFyseJmpoeznOH+ex3IJKzRjfgWpmVCFWfS3IHw160d4r1NDCkuRwSgz7rIqwbd9GcV1lPnX4D8KcRhC+fMWBE0Cx9sBwZyS8ywJdSIAFLg9F0Nh+Zmv3bXab2UHv7+uqhzQgoE8MaSGtrazUVXGshvMZCFjnCW4QgttdrcgQK3SZR13nX7QosC4OqWNVfFSjkaKxZfWJfNCWc4hJVqCO9c1t840qhXKBRfwFIhGDjQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9889619-26b6-43d1-1150-08de8a95ed18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 17:42:46.5085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzrSinYwRs/lbduom47nXm58iMOmDqUmmsa/XBc075MTLGOp/5sVYsKN6r9zztz3KxZDupSqtMFlaRSU8NYkGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
VHVlc2RheSwgTWFyY2ggMTcsIDIwMjYgNTo1MSBBTQ0KPiBUbzogS2ltLCBEb25nd29uIDxkb25n
d29uLmtpbUBpbnRlbC5jb20+DQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdWkvZWdsLWhlbHBlcnM6IEZpeCBGQk8gcmVjcmVhdGlvbiBhbmQgcHJl
dmVudCB0ZXh0dXJlDQo+IGFjY2lkZW50YWwgZGVsZXRpb24NCj4gDQo+IEhpDQo+IA0KPiBPbiBU
dWUsIE1hciAzLCAyMDI2IGF0IDU6MTTigK9BTSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+
ID4NCj4gPiBXaGVuIGVnbF9mYl9zZXR1cF9mb3JfdGV4IGlzIGNhbGxlZCwgd2UgbXVzdCBoYW5k
bGUgY2FzZXMgd2hlcmUgdGhlDQo+ID4gdGV4dHVyZSBJRCBpcyByZXVzZWQgYWNyb3NzIGRpZmZl
cmVudCBHTCBjb250ZXh0cy4NCj4gPg0KPiA+IFRleHR1cmUgUHJlc2VydmF0aW9uIC0gSWYgdGhl
IG5ldyB0ZXh0dXJlIElEIG1hdGNoZXMgdGhlIGNhY2hlZCBJRCwgd2UNCj4gPiBtdXN0IHNraXAg
ZWdsX2ZiX2RlbGV0ZV90ZXh0dXJlIHRvIGF2b2lkIGRlc3Ryb3lpbmcgdGhlIHRleHR1cmUgd2Ug
YXJlDQo+ID4gYWJvdXQgdG8gdXNlLg0KPiA+DQo+ID4gRkJPIFJlY3JlYXRpb24gLSBCZWNhdXNl
IEZCT3MgYXJlIGNvbnRleHQtbG9jYWwgYW5kIG5vdCBzaGFyZWQsIGENCj4gPiBjYWNoZWQgRkJP
IElEIGZyb20gYSBwcmV2aW91cyBjb250ZXh0IGlzIGludmFsaWQuIFdlIG11c3QgZ2VuZXJhdGUg
YQ0KPiA+IG5ldyBGQk8gaGFuZGxlIGlmIHdlIGFyZSByZS12YWxpZGF0aW5nIHRoZSBzYW1lIHRl
eHR1cmUgSUQgaW4gYQ0KPiA+IHBvdGVudGlhbGx5IG5ldyBjb250ZXh0Lg0KPiA+DQo+ID4gVGhp
cyBwcmV2ZW50cyBzdGFsZSBGQk8gdXNhZ2UgYW5kIHVuaW50ZW5kZWQgdGV4dHVyZSBkZWxldGlv
biBkdXJpbmcNCj4gPiBjb250ZXh0IHRyYW5zaXRpb25zLg0KPiA+DQo+ID4gQ2M6IEdlcmQgSG9m
Zm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXZlayBLYXNp
cmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9u
Z3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdWkvZWdsLWhl
bHBlcnMuYyB8IDE2ICsrKysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdWkvZWds
LWhlbHBlcnMuYyBiL3VpL2VnbC1oZWxwZXJzLmMgaW5kZXgNCj4gPiBlM2YyODcyY2MxLi43YWM2
NGYzYmE4IDEwMDY0NA0KPiA+IC0tLSBhL3VpL2VnbC1oZWxwZXJzLmMNCj4gPiArKysgYi91aS9l
Z2wtaGVscGVycy5jDQo+ID4gQEAgLTExMSwxNSArMTExLDIzIEBAIHZvaWQgZWdsX2ZiX3NldHVw
X2RlZmF1bHQoZWdsX2ZiICpmYiwgaW50IHdpZHRoLA0KPiA+IGludCBoZWlnaHQsIGludCB4LCBp
bnQgeSkgIHZvaWQgZWdsX2ZiX3NldHVwX2Zvcl90ZXgoZWdsX2ZiICpmYiwgaW50IHdpZHRoLCBp
bnQNCj4gaGVpZ2h0LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdMdWludCB0ZXh0
dXJlLCBib29sIGRlbGV0ZSkgIHsNCj4gPiAtICAgIGVnbF9mYl9kZWxldGVfdGV4dHVyZShmYik7
DQo+ID4gKyAgICBpZiAoZmItPnRleHR1cmUgIT0gdGV4dHVyZSkgew0KPiA+ICsgICAgICAgIGVn
bF9mYl9kZWxldGVfdGV4dHVyZShmYik7DQo+ID4gKyAgICB9DQo+IA0KPiBUaGF0IGNoYW5nZSBt
YWtlcyBzZW5zZSwgYW5kIHByZXZlbnRzIHJldXNpbmcgYSBkZXN0cm95ZWQgdGV4dHVyZS4NCj4g
DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIElmIGZiLT50ZXh0dXJlID09IHRleHR1
cmUsIHRoZSBleGlzdGluZyBmYi0+ZnJhbWVidWZmZXIgaXMgdGllZCB0bw0KPiA+ICsgICAgICog
YSBwcmV2aW91cyBHTCBjb250ZXh0LiBTaW5jZSBGQk9zIGFyZSBub3Qgc2hhcmVkIGFjcm9zcyBj
b250ZXh0cywNCj4gPiArICAgICAqIHdlIG11c3QgY3JlYXRlIGEgbmV3IEZCTyBmb3IgdGhlIGN1
cnJlbnQgY29udGV4dC4NCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKCFmYi0+ZnJhbWVidWZm
ZXIgfHwgKGZiLT50ZXh0dXJlID09IHRleHR1cmUpKSB7DQo+ID4gKyAgICAgICAgZ2xHZW5GcmFt
ZWJ1ZmZlcnMoMSwgJmZiLT5mcmFtZWJ1ZmZlcik7DQo+ID4gKyAgICB9DQo+IA0KPiBUaGlzLCBJ
IGRvbid0IHVuZGVyc3RhbmQuIEFzc3VtaW5nIHRoZSBmcmFtZWJ1ZmZlciBpcyB1c2VkIGluIGEg
ZGlmZmVyZW50DQo+IGNvbnRleHQsIHNob3VsZG4ndCBpdCBnZW5lcmF0ZSBhIG5ldyBmcmFtZWJ1
ZmZlciByZWdhcmRsZXNzIG9mIHRoZSB0ZXh0dXJlPw0KDQpTbyB0aGlzIGNvbmRpdGlvbiAiZmIt
PnRleHR1cmUgPT0gdGV4dHVyZSIgaXMgdXNlZCB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgZXhp
c3RpbmcgZnJhbWVidWZmZXINCmFuZCB0ZXh0dXJlIChmYi0+ZnJhbWVidWZmZXIgYW5kIGZiLT50
ZXh0dXJlKSBhcmUgZGVzdHJveWVkIGNvbnRleHQncy4gQnV0IEkganVzdCByZWFsaXplZCB0aGlz
IGNhbid0IGJlDQphbHdheXMgdHJ1ZSBhcyB0aGVyZSB3aWxsIGJlIGNhc2VzIHdoZXJlIHRleHR1
cmVzIGFyZSBkaWZmZXJlbnQgYnV0IGNvbnRleHQgc3dpdGNoaW5nIGhhcyBoYXBwZW5lZC4NCkkg
aW5pdGlhbGx5IGNhbWUgd2l0aCB0aGlzIGlkZWEgdG8gYXZvaWQgYWRkaW5nIHRvbyBtdWNoIGZv
ciB0cmFja2luZyBjb250ZXh0IChpLmUgZmItPmNvbnRleHQpDQpidXQgSSBndWVzcyB0aGlzIGlz
IHdoYXQgd2Ugc2hvdWxkIGRvLiBJIHdpbGwgdGFrZSBhIGxvb2suDQoNCj4gDQo+IEFsc28sIGFy
ZW4ndCB0aGVzZSBsZWFraW5nIGZyYW1lYnVmZmVycz8NCg0KT2xkIGNvbnRleHQgaXMgZGVzdHJv
eWVkIGF0IHRoaXMgcG9pbnQgYWxyZWFkeSBzbyB0aGUgYXNzdW1wdGlvbiBpcyB0aGF0IGFsbCBy
ZXNvdXJjZXMgYXJlIHVucmVmZXJlbmNlZC4gDQoNCj4gDQo+IENhbiB5b3UgaWRlbnRpZnkgY2Fz
ZXMgd2hlcmUgZWdsX2ZiX3NldHVwX2Zvcl90ZXgoKSBpcyByZXVzZWQgaW4gYSBkaWZmZXJlbnQN
Cj4gY29udGV4dD8gc2hvdWxkbid0IHdlIHByZXZlbnQgdGhpcyBpbnN0ZWFkPw0KDQpUaGlzIGhh
cHBlbnMgd2hlbiB0aGUgdXNlciBjbG9zZSB0aGUgdW50YWJpZmllZCB3aW5kb3cgKGdkX3RhYl93
aW5kb3dfY2xvc2UpLCB3aGljaCBpcyBhbg0KYXN5bmNocm9ub3VzIGV2ZW50Lg0KDQo+IA0KPiB0
aGFua3MNCj4gDQo+ID4NCj4gPiAgICAgIGZiLT53aWR0aCA9IHdpZHRoOw0KPiA+ICAgICAgZmIt
PmhlaWdodCA9IGhlaWdodDsNCj4gPiAgICAgIGZiLT50ZXh0dXJlID0gdGV4dHVyZTsNCj4gPiAg
ICAgIGZiLT5kZWxldGVfdGV4dHVyZSA9IGRlbGV0ZTsNCj4gPiAtICAgIGlmICghZmItPmZyYW1l
YnVmZmVyKSB7DQo+ID4gLSAgICAgICAgZ2xHZW5GcmFtZWJ1ZmZlcnMoMSwgJmZiLT5mcmFtZWJ1
ZmZlcik7DQo+ID4gLSAgICB9DQo+ID4NCj4gPiAgICAgIGdsQmluZEZyYW1lYnVmZmVyKEdMX0ZS
QU1FQlVGRkVSX0VYVCwgZmItPmZyYW1lYnVmZmVyKTsNCj4gPiAgICAgIGdsRnJhbWVidWZmZXJU
ZXh0dXJlMkRFWFQoR0xfRlJBTUVCVUZGRVJfRVhULA0KPiA+IEdMX0NPTE9SX0FUVEFDSE1FTlQw
X0VYVCwNCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJj
LUFuZHLDqSBMdXJlYXUNCg==

