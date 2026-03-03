Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACEAEDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUqP-0006m0-6F; Tue, 03 Mar 2026 13:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxUpB-0005uT-Fe
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:50:30 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxUp5-0007xS-1G
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772563823; x=1804099823;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ccvYij/F4DVYnHbwW4B/y83Icz6VZ1kaRHCtmw2zmM4=;
 b=ZFM9+iWhRfUU0Oc5+CqWJnGE5bPS4q1tRbZmBCTvcMD/HCeVDxR8HZsp
 LJhXiF8o2RwHr1IRu2waQSOxUuFFXnAHG7uat18uCPYI/gN4kt8CMEBvK
 xsUQnKvHnxxOrU0fWQH/COWEm90sE6RqjswyVVRdDL2z0cvbS5s1UKMv0
 mLd2AIiHEgjbuajAh0Y+TlHdQrjsdWPpQoQfnf1f253SulS4J9CajF4ww
 l6rxVFgm1JyxmbP/K4RKIt/YXpDvhxwSv1zDtlCCM7248zlw5fZq+iYKF
 6D4TAj4y7vw9YWw/3894cRmxIV5U4qIm0OTEracaSOANJUBOJvJ2Rfyev g==;
X-CSE-ConnectionGUID: 00QfGbGeRjesmWrACuscJg==
X-CSE-MsgGUID: 8woCBuuQQiSf27atjU92wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77483582"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="77483582"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 10:50:11 -0800
X-CSE-ConnectionGUID: UzZRmAbjQL+ocLdgvL65CQ==
X-CSE-MsgGUID: PaZ+MTnGQeuUyqwJC5P/WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; d="scan'208";a="222753953"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 10:50:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 10:50:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 10:50:05 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 10:50:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9dMGuWgczNb0+8KC43FOQprms9rnp3tkerpwEyNA/BB7YKlIkPtAT5RuhcIVmJsKV+EXFZROXSxIZQQweh3z/T9UN16SpwOzW4Rl9qnBkjo7ZLsKk3ubIp+At2XSXv0Trw7XLb0+PCKR8mkVGQnXmF2fYpQoWvfHHx+W2m5GG7SFObPzqt8pXa/2JwpDI8uBT1B8/lQVI4XYLPP9OHSidxq98o2IAjkkH6MKFVn2Fx8VXL/WPqvGO891sA0+gOmw5PqyyJ7q0j5kGfWKivrDI7ZS7heFDCKI+QqsId+3u8ODr11kUsQzDsjYOXQDhGOHZ1KjZ9mcd5h94Esk5i21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccvYij/F4DVYnHbwW4B/y83Icz6VZ1kaRHCtmw2zmM4=;
 b=qoaNrgp0M+kgWmpOE0YP4JXqFkhxDrDSLfMwQgR/mEMR31w8Wt/stLKWoPZMDowg2qUVlPs/sQ9BCZQY3MK0UvhPTaZgVcpsyKWvfY1/8VX/feLv+65k+d8p7YQqy4/nrgRA5dYYU9mBGW/+I54oTJk1SlxQItynIm+b+ROcUTk0t1loDOaDw89MciX7iksPHs9bspCNCYbb2ayg7gq3fDudoHrfdcUCgKbl9oEqKfKXJh5Ej6CgHCllmxqciwxJIT35f77EcXUkTvTbKJegWkBKPHEUC9bUdoDL5yUfY97UJ2pqH/ETCmlTYAfSj3sU8g3L3JBT8env+o+ma3pqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by SJ5PPF0F15BC42D.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 18:50:00 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 18:50:00 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl
 and gtk-gl-area
Thread-Topic: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl
 and gtk-gl-area
Thread-Index: AQHcqru+pkfTkzjQPEWYdRgNLoERELWdFkIAgAAGLGA=
Date: Tue, 3 Mar 2026 18:50:00 +0000
Message-ID: <PH0PR11MB511248C615D6433E2ED7E7D4FA7FA@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260303030714.1926907-1-dongwon.kim@intel.com>
 <CAJ+F1C+ownUskL4troo57_GxJjGaZvX2sHCJoc4KjYm3rU-oQw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+ownUskL4troo57_GxJjGaZvX2sHCJoc4KjYm3rU-oQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|SJ5PPF0F15BC42D:EE_
x-ms-office365-filtering-correlation-id: 9b6ae216-2b75-458d-6b82-08de7955ac94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: g39BCDVfBJrk19vcU2m2Y21lcTEDzlm9rlHmSnB1nxpzfB1OpKw6nAvTBuDI3lmeFsqOsriJP41AOMzxEOHpl6WNdKqq6L5JEbB1Cu0qoQLiSRux5k28j+HbnSLPl8VkakMkXB8YTWFr368/xNDAtD+3BWzldhbLS00pYUPO4NgQQBVvsBmHiSQlz1POARtA2WPLR4PVobfzyU9w0ZCc104ypxAxWdFYgq0qiIhvImbUlf3q0l1TuMl1DqGQ3k4JqwibxzVs+s426+s6ucy0Of7L9XTbBL4ddSBF3KvJYmsMVUIqJaY/zlE0oJKepCiHVOgQnsQiybHihNbTpOvbtVXL5tDhqy8EuiHyknEuepJVI+U3eVD0jKDf3RtWqKt78a4f4hD3zrbbXwuvnjQemBaqzzVBAxrNed/IN4ab77Bgk3DHWBkdm9FUG22Ay7pY+PhHHpAHzvYfKWpIXLUzik/AcVBuiNZRHxTuCXxvFB46JWZZmhK2UwixovtYrjtypDhe0axflConuicc+LU7LVdVnSZrVf9+UI1QCt3Pyrl9f+HGKxVFLwBtfkGZRikxWe/r/BCc9bIjHKkWdYgzdZshJLm6co5DAnCmA25/KUso0Gsb+r5S8c82rWNebx2pj4RazC0HgnnDFbIXrychYH/W3H92t5S7B5749dpw8TQrXLz2K6YaozN2nm0Uz7B+RoGjNkFx6jjaXxON38MvQ8Pi6arXkGBYPueu2vvFXoRJzjKCCLfw9tx+AVc+wiOU4nPiTYy+G6XmtqXZrGOCph/rP7oQjSnWjvMbLpuRVf0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1FMaWhFWmhOejlzTml1bCs5MW1jRS9iRHhodWFldXlBRUwwcGpLUWwyN09V?=
 =?utf-8?B?aGpUZnM4MVp6RWhtY0doWUh5dVpYckhGb3gxOHN2M1ppeGV5VVJvOEJ4NlFG?=
 =?utf-8?B?WmRabXVlTzRDZS9IZ1E0a2NrTVFFN2lFVzh5bEVWWUZlNHNyN2ZyeWpYMk1Z?=
 =?utf-8?B?ZmV0ZmxRNmdpVHlIT0pYc3NESDZlV29nNnVYWFVQM1dTR2ljNi8wMWZDY2hX?=
 =?utf-8?B?UmFZVm1MY0tNV1Y5bFBKRkRCQThPVnFhbXI1dDdoWGlGOVNoQjZBczRZZktG?=
 =?utf-8?B?QmxWKzFBc0UxVWg1S2NncitGNUxiaG43NjdqL0pUWHBLcXUwNE14WWo3UER1?=
 =?utf-8?B?TEg2S1VES0VjM2N6RzZQNXZSSUZLaHg1c2VsemxOMVpheU03RUU2VlNPRUtv?=
 =?utf-8?B?eDlLdmNJOE5qeG9GMnlhcGRjOENrQ1ZSaDRTSFdpbjVMMFV1cXpZNFM5VHVQ?=
 =?utf-8?B?QWp1M2lsb2xVWXNMUWZFaUpBTU5hSDRvSGluYlh4ODExWDdSdS80bUtDSnNI?=
 =?utf-8?B?ZHIvVnFQblJKSnFEbnBSTHQrckUzNyt0elhmM09PQ3FZMjNiWjlWMFZ4Y25G?=
 =?utf-8?B?UUE1MUZWeTJnSlJNckF1R1c0S1N3Z1JFUjZ1N1ZzbG05SDNVbUxxSWMxQjlt?=
 =?utf-8?B?cWxraDczSFgzWmQyQmRzUUFOWHNaRENpOTJkRWZCRy85bGlCQXJRVEsxTDVw?=
 =?utf-8?B?UEV4L2IyMWhqSkRzSHU3K2o3SmN5SVV1QlJNZ241bDA2KzhoaUtSNmNzQlZJ?=
 =?utf-8?B?STM1NWUzL3lKaEF5VlQ5QXduYWFWNlFDTGxYbXdUZm9kWTVDMmNpY3BhSTZM?=
 =?utf-8?B?M2xxcmtOdjF4K3c5Q0tmYU95VUJxeUZsZEtNWlpZOUtHQ0hwY3RxNjl4aGNU?=
 =?utf-8?B?VjBkTTJCKzl5cDM2SXZFYjFuNVAxd2hpMndRdGE1dkY0eGRGUWV2alExbkFm?=
 =?utf-8?B?ZEtTWXdNUFJXVW8zTEVvak9yV1JjLytsMnRnWVJxaVcyK3BVVHk5dnJrTEdQ?=
 =?utf-8?B?bEx5NzRSWUlwM1ZBTzZKZmNYNTMyMHBjd0VMQjZpN0Q2TmtJZFBsc1Z1ZERY?=
 =?utf-8?B?QTJkVlBvY2NGWEVkL3k5ZnY0QjlwQTV1ckpaUkxwTGNXS29wZXJLQ0xMRGsv?=
 =?utf-8?B?cTRLenZHQ1R3dWNPOWdQcWNENUVzVmNxbHB5a3JBRVJrNWUxYzcrbFBrSDVt?=
 =?utf-8?B?YjBTVkh4U21zTW5iWTN6TUhXcHVLNW81OWJSMFNZd1Rma09VM2hFdWV4R1hF?=
 =?utf-8?B?ZTRaR1AzSlZMZG5rVVZsRktiYjhYZzdSVk9oV3FnN05QbTRnZGc4SEFvTGl0?=
 =?utf-8?B?LzJvZlVpUlFIVHlvb0dUeENNbW9JSWRRZHZOanE3b1FaU0kveW5IdHVtUmFi?=
 =?utf-8?B?Y3VaU0UwNlVPaHBYbnNRdGxLNTVaV0FoMW5PLzkrdXFTVm92alpId3RnWFlR?=
 =?utf-8?B?Z1AyT1Z0Qkh2L0l0WUs5ZklTSDlEaVFLcUoycVFsd2d3dlBlTUVodThSRU1n?=
 =?utf-8?B?OFZwblVUOWRyUGpkSWZRQStoVEVtNDNMajJGT3VXYlgxc2RnZjh4RjhTeWNB?=
 =?utf-8?B?Zk9IREtFSzdGU3JMckw4bmFpeWVVaVdrUXBXby9hMHhCampOSkhucUFZdkxU?=
 =?utf-8?B?c2tsdHVzZ1NXMmhGTktGNXhMWVBIZEErY3hnenBHSEsxK1IxdXlwTzdoUTI5?=
 =?utf-8?B?K0hnZ3ZtZWU3NjF1TWFVbmI4M1RBamlMZ3ZPSTY0NG5ubHplME5JYVQxaGJj?=
 =?utf-8?B?VFBxK0ZQUW9ScU50WGIwSHIxcnVTaVNRWG95OVQvaE5OZklDMWVEWkVRSFls?=
 =?utf-8?B?ekRYMWRURC9MSVROSDNrRjNmbExFOGlndlpocmRMWkFQWDFIU21DcDRaaWZC?=
 =?utf-8?B?UVpiZDhKK3FxVmR6d0x2RGtnb29TNUpETG0walpDQzFhWWo0NEE1ajhrRUNN?=
 =?utf-8?B?NTl1VHFzSTZsVmgrSERYbWV3eUNvdEc0RnpJcENJd2tEbG1qVzJmMVJaTXpa?=
 =?utf-8?B?NTBjMnhCV1VsaU5xck5lbG11M2tiKzNBd25yclJHY0xDd1NiU3lzZm9xRDVO?=
 =?utf-8?B?eW5GWlRCaWMrNitCQy9ZQnI2WXJaZklObHFuZDNaOUc0SUxvWjBTNGJ4QXFL?=
 =?utf-8?B?TUNvSlU1enFGS0QzMU9lVENHNFcrMEc2ZTJ4TUZYcjlBM2tLNklKNUV0T2hO?=
 =?utf-8?B?UEVqTmE5SWVDVlcrc0ZMb0dTTWsvbjVwZ29sTmFPRjhtOHhNNUFwY0VEUmRC?=
 =?utf-8?B?dkMzR0cwNUhqSGpORkMxNUF5bDR1M1lPZ3g5clpSUWNTcGZSZGozVGltYVh5?=
 =?utf-8?B?alBMdDZMUmpSOUdpblBYU2pLS3N4anlVaWZrLy9IY3dmdUh4bGswUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6ae216-2b75-458d-6b82-08de7955ac94
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 18:50:00.7513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJQ4aU0wb4CHl7ZAhGDe+BpJXbJjPt4q0gqdrM1dlWm+gNNpppD5xFVmV0k4KGXZ6L7IgKTK328uLyeYM3/74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0F15BC42D
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdWkvZ3RrOiBJbXBsZW1l
bnQgZHB5X2dsX2N0eF9kZXN0cm95X3RleHR1cmUgZm9yIGd0ay0NCj4gZWdsIGFuZCBndGstZ2wt
YXJlYQ0KPiANCj4gSGkNCj4gDQo+IE9uIFR1ZSwgTWFyIDMsIDIwMjYgYXQgNDoxM+KAr0FNIDxk
b25nd29uLmtpbUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRG9uZ3dvbiBLaW0g
PGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPg0KPiA+IEN1cnJlbnRseSwgdGhlIHRleHR1cmUg
YXNzb2NpYXRlZCB3aXRoIGEgRGlzcGxheVN1cmZhY2UgaXMgbm90IGRlbGV0ZWQNCj4gPiB3aGVu
IHRoZSBzdXJmYWNlIGlzIHN3aXRjaGVkIG9yIGZyZWVkLCBsZWFkaW5nIHRvIGEgbWVtb3J5IGxl
YWsgaW4gdGhlDQo+ID4gR1BVIHByb2Nlc3MuIFRoaXMgb2NjdXJzIGJlY2F1c2UgdGhlIEdUSyBi
YWNrZW5kIGxhY2tzIGEgbWFwcGluZyBmb3INCj4gPiB0aGUgJ2RweV9nbF9jdHhfZGVzdHJveV90
ZXh0dXJlJyBvcGVyYXRpb24uDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIG5l
Y2Vzc2FyeSBjbGVhbnVwIGZ1bmN0aW9ucyBmb3IgYm90aCBFR0wgYW5kDQo+ID4gR0wgQXJlYSBi
YWNrZW5kcy4gRWFjaCBpbXBsZW1lbnRhdGlvbiBlbnN1cmVzIHRoZSBhcHByb3ByaWF0ZSBHTA0K
PiA+IGNvbnRleHQgaXMgbWFkZSBjdXJyZW50IGJlZm9yZSBjYWxsaW5nIHN1cmZhY2VfZ2xfZGVz
dHJveV90ZXh0dXJlKCksDQo+ID4gZW5zdXJpbmcgdGhhdCB0aGUgdW5kZXJseWluZyBHTCB0ZXh0
dXJlIElEIGlzIHNhZmVseSByZWxlYXNlZCBieSB0aGUgZHJpdmVyLg0KPiA+DQo+ID4gQ2M6IEdl
cmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJl
YXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBDYzogVml2ZWsgS2FzaXJlZGR5
IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24g
S2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvdWkvZ3Rr
LmggfCAgNCArKysrDQo+ID4gIHVpL2d0ay1lZ2wuYyAgICAgfCAxMCArKysrKysrKysrDQo+ID4g
IHVpL2d0ay1nbC1hcmVhLmMgfCAgOCArKysrKysrKw0KPiA+ICB1aS9ndGsuYyAgICAgICAgIHwg
IDIgKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS91aS9ndGsuaCBiL2luY2x1ZGUvdWkvZ3RrLmggaW5kZXgNCj4g
PiAzZTZjZTNjYjQ4Li5mMTc2NWFkNWNiIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvdWkvZ3Rr
LmgNCj4gPiArKysgYi9pbmNsdWRlL3VpL2d0ay5oDQo+ID4gQEAgLTE3MCw2ICsxNzAsOCBAQCB2
b2lkIGdkX2VnbF9zd2l0Y2goRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2wsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICBEaXNwbGF5U3VyZmFjZSAqc3VyZmFjZSk7ICBRRU1VR0xDb250ZXh0DQo+
ID4gZ2RfZWdsX2NyZWF0ZV9jb250ZXh0KERpc3BsYXlHTEN0eCAqZGdjLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VR0xQYXJhbXMgKnBhcmFtcyk7DQo+ID4g
K3ZvaWQgZ2RfZWdsX2Rlc3Ryb3lfdGV4dHVyZShEaXNwbGF5R0xDdHggKmRnYywNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIERpc3BsYXlTdXJmYWNlICpzdXJmYWNlKTsNCj4gPiAg
dm9pZCBnZF9lZ2xfc2Nhbm91dF9kaXNhYmxlKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNsKTsg
IHZvaWQNCj4gPiBnZF9lZ2xfc2Nhbm91dF90ZXh0dXJlKERpc3BsYXlDaGFuZ2VMaXN0ZW5lciAq
ZGNsLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYmFja2luZ19p
ZCwgQEAgLTIwNiw2ICsyMDgsOCBAQA0KPiA+IFFFTVVHTENvbnRleHQgZ2RfZ2xfYXJlYV9jcmVh
dGVfY29udGV4dChEaXNwbGF5R0xDdHggKmRnYywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFFFTVVHTFBhcmFtcyAqcGFyYW1zKTsgIHZvaWQNCj4gPiBnZF9n
bF9hcmVhX2Rlc3Ryb3lfY29udGV4dChEaXNwbGF5R0xDdHggKmRnYywNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBRRU1VR0xDb250ZXh0IGN0eCk7DQo+ID4gK3ZvaWQgZ2Rf
Z2xfYXJlYV9kZXN0cm95X3RleHR1cmUoRGlzcGxheUdMQ3R4ICpkZ2MsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRGlzcGxheVN1cmZhY2UgKnN1cmZhY2UpOw0KPiA+ICB2
b2lkIGdkX2dsX2FyZWFfc2Nhbm91dF9kbWFidWYoRGlzcGxheUNoYW5nZUxpc3RlbmVyICpkY2ws
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRZW11RG1hQnVmICpkbWFidWYp
OyAgdm9pZA0KPiA+IGdkX2dsX2FyZWFfc2Nhbm91dF90ZXh0dXJlKERpc3BsYXlDaGFuZ2VMaXN0
ZW5lciAqZGNsLCBkaWZmIC0tZ2l0DQo+ID4gYS91aS9ndGstZWdsLmMgYi91aS9ndGstZWdsLmMg
aW5kZXggYWU5MjM5OTk5Yy4uYzFiMzJiYzQxYiAxMDA2NDQNCj4gPiAtLS0gYS91aS9ndGstZWds
LmMNCj4gPiArKysgYi91aS9ndGstZWdsLmMNCj4gPiBAQCAtMjI1LDYgKzIyNSwxNiBAQCBRRU1V
R0xDb250ZXh0DQo+IGdkX2VnbF9jcmVhdGVfY29udGV4dChEaXNwbGF5R0xDdHggKmRnYywNCj4g
PiAgICAgIHJldHVybiBxZW11X2VnbF9jcmVhdGVfY29udGV4dChkZ2MsIHBhcmFtcyk7ICB9DQo+
ID4NCj4gPiArdm9pZCBnZF9lZ2xfZGVzdHJveV90ZXh0dXJlKERpc3BsYXlHTEN0eCAqZGdjLCBE
aXNwbGF5U3VyZmFjZQ0KPiA+ICsqc3VyZmFjZSkgew0KPiA+ICsgICAgVmlydHVhbENvbnNvbGUg
KnZjID0gY29udGFpbmVyX29mKGRnYywgVmlydHVhbENvbnNvbGUsIGdmeC5kZ2MpOw0KPiA+ICsN
Cj4gPiArICAgIGVnbE1ha2VDdXJyZW50KHFlbXVfZWdsX2Rpc3BsYXksIHZjLT5nZnguZXN1cmZh
Y2UsDQo+ID4gKyAgICAgICAgICAgICAgICAgICB2Yy0+Z2Z4LmVzdXJmYWNlLCB2Yy0+Z2Z4LmVj
dHgpOw0KPiA+ICsNCj4gPiArICAgIHN1cmZhY2VfZ2xfZGVzdHJveV90ZXh0dXJlKGRnYy0+Z2xz
LCBzdXJmYWNlKTsgfQ0KPiA+ICsNCj4gPiAgdm9pZCBnZF9lZ2xfc2Nhbm91dF9kaXNhYmxlKERp
c3BsYXlDaGFuZ2VMaXN0ZW5lciAqZGNsKSAgew0KPiA+ICAgICAgVmlydHVhbENvbnNvbGUgKnZj
ID0gY29udGFpbmVyX29mKGRjbCwgVmlydHVhbENvbnNvbGUsIGdmeC5kY2wpOw0KPiA+IGRpZmYg
LS1naXQgYS91aS9ndGstZ2wtYXJlYS5jIGIvdWkvZ3RrLWdsLWFyZWEuYyBpbmRleA0KPiA+IGNk
ODYwMjJkMjYuLjg0ZTQxZjQyMjEgMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLWdsLWFyZWEuYw0K
PiA+ICsrKyBiL3VpL2d0ay1nbC1hcmVhLmMNCj4gPiBAQCAtMjk5LDYgKzI5OSwxNCBAQCB2b2lk
IGdkX2dsX2FyZWFfZGVzdHJveV9jb250ZXh0KERpc3BsYXlHTEN0eA0KPiAqZGdjLCBRRU1VR0xD
b250ZXh0IGN0eCkNCj4gPiAgICAgIGdfY2xlYXJfb2JqZWN0KCZjdHgpOw0KPiA+ICB9DQo+ID4N
Cj4gPiArdm9pZCBnZF9nbF9hcmVhX2Rlc3Ryb3lfdGV4dHVyZShEaXNwbGF5R0xDdHggKmRnYywg
RGlzcGxheVN1cmZhY2UNCj4gPiArKnN1cmZhY2UpIHsNCj4gPiArICAgIFZpcnR1YWxDb25zb2xl
ICp2YyA9IGNvbnRhaW5lcl9vZihkZ2MsIFZpcnR1YWxDb25zb2xlLCBnZnguZGdjKTsNCj4gPiAr
DQo+ID4gKyAgICBndGtfZ2xfYXJlYV9tYWtlX2N1cnJlbnQoR1RLX0dMX0FSRUEodmMtPmdmeC5k
cmF3aW5nX2FyZWEpKTsNCj4gPiArICAgIHN1cmZhY2VfZ2xfZGVzdHJveV90ZXh0dXJlKGRnYy0+
Z2xzLCBzdXJmYWNlKTsgfQ0KPiA+ICsNCj4gPiAgdm9pZCBnZF9nbF9hcmVhX3NjYW5vdXRfdGV4
dHVyZShEaXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBiYWNraW5nX2lkLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJvb2wgYmFja2luZ195XzBfdG9wLCBkaWZmIC0tZ2l0DQo+ID4gYS91
aS9ndGsuYyBiL3VpL2d0ay5jIGluZGV4IDllYmU3ZThkZjAuLjIxN2Y0MjUwNzUgMTAwNjQ0DQo+
ID4gLS0tIGEvdWkvZ3RrLmMNCj4gPiArKysgYi91aS9ndGsuYw0KPiA+IEBAIC02MzYsNiArNjM2
LDcgQEAgc3RhdGljIGNvbnN0IERpc3BsYXlHTEN0eE9wcyBnbF9hcmVhX2N0eF9vcHMgPSB7DQo+
ID4gICAgICAuZHB5X2dsX2N0eF9pc19jb21wYXRpYmxlX2RjbCA9IGdkX2dsX2FyZWFfaXNfY29t
cGF0aWJsZV9kY2wsDQo+ID4gICAgICAuZHB5X2dsX2N0eF9jcmVhdGUgICAgICAgPSBnZF9nbF9h
cmVhX2NyZWF0ZV9jb250ZXh0LA0KPiA+ICAgICAgLmRweV9nbF9jdHhfZGVzdHJveSAgICAgID0g
Z2RfZ2xfYXJlYV9kZXN0cm95X2NvbnRleHQsDQo+ID4gKyAgICAuZHB5X2dsX2N0eF9kZXN0cm95
X3RleHR1cmUgPSBnZF9nbF9hcmVhX2Rlc3Ryb3lfdGV4dHVyZSwNCj4gPiAgICAgIC5kcHlfZ2xf
Y3R4X21ha2VfY3VycmVudCA9IGdkX2dsX2FyZWFfbWFrZV9jdXJyZW50LCAgfTsNCj4gPg0KPiA+
IEBAIC02NzAsNiArNjcxLDcgQEAgc3RhdGljIGNvbnN0IERpc3BsYXlHTEN0eE9wcyBlZ2xfY3R4
X29wcyA9IHsNCj4gPiAgICAgIC5kcHlfZ2xfY3R4X2lzX2NvbXBhdGlibGVfZGNsID0gZ2RfZWds
X2lzX2NvbXBhdGlibGVfZGNsLA0KPiA+ICAgICAgLmRweV9nbF9jdHhfY3JlYXRlICAgICAgID0g
Z2RfZWdsX2NyZWF0ZV9jb250ZXh0LA0KPiA+ICAgICAgLmRweV9nbF9jdHhfZGVzdHJveSAgICAg
ID0gcWVtdV9lZ2xfZGVzdHJveV9jb250ZXh0LA0KPiA+ICsgICAgLmRweV9nbF9jdHhfZGVzdHJv
eV90ZXh0dXJlID0gZ2RfZWdsX2Rlc3Ryb3lfdGV4dHVyZSwNCj4gPiAgICAgIC5kcHlfZ2xfY3R4
X21ha2VfY3VycmVudCA9IGdkX2VnbF9tYWtlX2N1cnJlbnQsDQo+IA0KPiBCdXQgdGhlcmUgaXMg
bm8gZHB5X2dsX2N0eF9jcmVhdGVfdGV4dHVyZSgpLCBob3cgY2FuDQo+IGRweV9nbF9jdHhfZGVz
dHJveV90ZXh0dXJlKCkgZ2V0IGNhbGxlZD8NCg0KVGV4dHVyZXMgYXJlIGFsc28gY3JlYXRlZCB2
aWEgc3VyZmFjZV9nbF9jcmVhdGVfdGV4dHVyZSBpbiB0aGUgcGxhY2VzIGxpa2UsDQoNCmd0ay1l
Z2wuYw0Kc3RhdGljIHZvaWQgZ3RrX2VnbF9zZXRfc2Nhbm91dF9tb2RlKFZpcnR1YWxDb25zb2xl
ICp2YywgYm9vbCBzY2Fub3V0KQ0Kew0KIC4uLi4uDQogICAgICAgZWdsX2ZiX2Rlc3Ryb3koJnZj
LT5nZnguZ3Vlc3RfZmIpOw0KICAgICAgICBpZiAodmMtPmdmeC5zdXJmYWNlKSB7DQogICAgICAg
ICAgICBzdXJmYWNlX2dsX2Rlc3Ryb3lfdGV4dHVyZSh2Yy0+Z2Z4LmdscywgdmMtPmdmeC5kcyk7
DQogICAgICAgICAgICBzdXJmYWNlX2dsX2NyZWF0ZV90ZXh0dXJlKHZjLT5nZnguZ2xzLCB2Yy0+
Z2Z4LmRzKTsNCiAgICAgICAgfQ0KDQpzdXJmYWNlX2dsX2NyZWF0ZV90ZXh0dXJlIGFsd2F5cyBj
b21lIGFmdGVyIHN1cmZhY2VfZ2xfZGVzdHJveV90ZXh0dXJlDQpzbyB0aGVyZSBpcyBubyBsZWFr
IHdoaWxlIHRoZSBndWVzdCBpcyBydW5uaW5nIGJ1dCB0ZXh0dXJlIHdvdWxkIHJlbWFpbiB1bnJl
bW92ZWQNCmlmIHdlIGRvIG5vbmUgaW4gZHB5X2dsX2N0eF9kZXN0cm95X3RleHR1cmUoKSB3aGVu
IHRoZSBndWVzdCBpcyByZWJvb3RpbmcuIA0KDQo+IA0KPiA+ICB9Ow0KPiA+ICAjZW5kaWYNCj4g
PiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBM
dXJlYXUNCg0KVGhhbmtzDQo=

