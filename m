Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F519C7EE32
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOUx-00055Q-No; Wed, 25 Jun 2025 07:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUZ-00051V-NY
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:41 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUW-0000T1-Rk
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750851637; x=1782387637;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lNsJicIfzqmPAAMaewpNhuNP5LsBCUWsWSmmpBEyXd4=;
 b=Kj0TJPdJCQJU/U4FXPTt77Rl+EUQS20rEMSVg1GMnGZ/a+Rf6WMbDmQR
 2tagQrKhQ3ICOpBI7vcw7eXcWcvZh2BydFaUsZLw87rW+9LIOp6Bo8w3Y
 yQsKkCjSLGfjT3qLgTj6/DcbWj88t8d2pnJbdjLBLOiJBOmv8qwctU6YJ
 fCKExkjd7Oeiu0EmmzCf45aV0K4GiH/3KTN+8SyBy4Kq/9B8J/thmzGA/
 7tV8UmlikdJCLFhE3D4edWcE80RfIddyyeozhv5Ob4kaBMuS3mdW5dJ5t
 VYspTANVt531oZ+BJMBpz8nI9n6lh4tGb2Ixd6SB6bLeZagDTvH3E3AnO g==;
X-CSE-ConnectionGUID: a4PcOOpBTJSlCJxApKEiAQ==
X-CSE-MsgGUID: TZfC+hWpSiOnkVDq3Ahgeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="63719514"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="63719514"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:27 -0700
X-CSE-ConnectionGUID: L3jojLAzTKanmxC1K4++OQ==
X-CSE-MsgGUID: QV0GO2JNThmgMxolI/XFLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="152324809"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:40:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCKTXaU99M8hFJxah6zxTxRDRZWC/5tLgtlq3t1HQu4l1hHAoF3d7zITJwKeJ4GZj1MVHH+NV8tPX/L7GuwZ8QUVtGlJ3DgWRYIqj7wLB3xONu41TypT00z/e8AOBNj1d6aFP5+j4hhDsJqDXxa8OO8j7QLD0F6PcNpyV1DEHHA7zcJmNhqvkCRyO9SHaiRF1KVSynLIQOB2j/svIjzVw8pam5p1WR4Pm10JglLcZ+/MCS5QjE8Q1Q5EIlgfWlS8CEyLtQhC+VG+KmV//usz6Kwf5fQGNdaiXXalRcySomX0RgLSZrTOohWR+nmeUV411uEaDJ9ZJNZCB3SzLxIbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhCVeVg2rhQ0StzkyJsZ0n4gV612of58p6IsaWI23k0=;
 b=u4pdjXsqsYSZg8CCHYRAGfqcW03rsiyZEKPHepRqDYBitXpdvRwBaLI/iVGMNonvOjT4A8XdxOLzFaP7bVD2INYYFHdbNWeS2wCZgNAGlyZI5y/jzl3LqEPFx1Az9s3feFRKTWW8IZDCxE4Gf0EFdNT2zBZNaa9BKa6MUjY1+YRMuT4c5loYo31sEuk6bg/coR/T7KJc0SDeB+TkzL9EbV8USLSEzIvnsA1ahfUed3ITJK1oU6irPe5SosuIeeMVZ9eCbXS0xGmStudYjU5fDKDDalpqQaBoSbYjkKL/MjZQNYiHM2tuhUFLHafcaKAExcqlYPckPQM0kdwdUSq2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:40:14 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 11:40:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 35/38] vfio/iommufd: change process
Thread-Topic: [PATCH V5 35/38] vfio/iommufd: change process
Thread-Index: AQHb2h4QhD64q5KK2EqqYvjZk7axZLQT1chQ
Date: Wed, 25 Jun 2025 11:40:14 +0000
Message-ID: <IA3PR11MB91368C5C5D98CD165A9F53DE927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-36-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-36-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: 56600c90-7082-4dd2-3f17-08ddb3dd0cf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UpG9HNDMShDfE5htphtiwQHWHOcjhBHOGZnrmHdkmlTgCGUc3fxF8/6CPg1i?=
 =?us-ascii?Q?ZCCg/mxlv5ZHG0D2sxjDzi64RnAzv7QqcMK9TunaqW+2NulH/PxAEXyJsw0I?=
 =?us-ascii?Q?gozn4m4wA7H64KKLTTNFZwvCkIOJ7N/1mVgCly86x7t8RKgId3pHRZCtDgSD?=
 =?us-ascii?Q?3Zwn8DkU2APqnECpyt2g83COBLZ+N0JBB31/6ICph8ar30u/c/bSwSaHAktH?=
 =?us-ascii?Q?r5LrEbICouXFri/twN7964EO0QwDiEz4tSuKkSnLs6V90uHR+1W/0EA40GfM?=
 =?us-ascii?Q?XiC0VGhtpNks0EZhGWn1+izkE82BB15I2B11qV/VRwkU0CaImGCmal+1vy1k?=
 =?us-ascii?Q?h+31G0Y8wNNI5SUJvCnrwHzr+1Wcj6O8nD3OB3sn02kYW+KTzdH66xrHjT+c?=
 =?us-ascii?Q?oBfcYFnSsKrKqU4bYFAjKQNBI/zQ+rs7ZiS5Q7Jvk0FMMop2gLscyIhxptXz?=
 =?us-ascii?Q?ztbLt1dFsB/NeD2+7AE5ZPZxptVgjgPeV7Pl1H1v/EtgheYH6bOFZzHgvy6C?=
 =?us-ascii?Q?P+stx/62W1ecVboo2HnJtaTE0PFBGF3PUY8B6CyKfMLNbPEw3Zf38AiceBBr?=
 =?us-ascii?Q?Vf1y/prKn31Cj7ZVpUkQ26pHiSFiZFHAt/b5QXcWBtgKPIkkbzmXcrdFuaCk?=
 =?us-ascii?Q?ZdKAhhis50yDadQ19YC6EK9Zp8QIkm+J9+mcbv3BA/t6rrkRPEtCzicDW1Ds?=
 =?us-ascii?Q?+YrGW1vGbflNKZILe8l6JsmQE1d5VhB7bneAT1efJseAtPXbpbHp+3R+gLmQ?=
 =?us-ascii?Q?ub/erkVryapbjxBABKq78/WAewgBfuaORkjjkLUsKlqeNvUgJSNh21nBpEep?=
 =?us-ascii?Q?V2rhFdp5sekCdpyjn5okqhGswB1sgyIm2UiZpeU3q4t2iLA4FzPN/gfAPDxY?=
 =?us-ascii?Q?nSEQR5aM+M6HvM2aCPG9iWMayl/s6faUmDw8VvvIBB5bLUIh6ZLeIg+oDlzn?=
 =?us-ascii?Q?b9LLTgRukj1k5fi/NaxyZVyCM1QI+ck9dAdJr435srrpC7nUn0hdhTOucxLC?=
 =?us-ascii?Q?6SAmUiviwgHs6/c5PCUz57e0JAFbztDz4KJ00xjV02RFJ0dr/PmrH3j+aBT6?=
 =?us-ascii?Q?GQ+etHQS6YvM56wzCUM+eBppn/UOpuxl9Hfz1LkT58bbJ4JZGJRXmGmIflSO?=
 =?us-ascii?Q?aaduKw6iSrkrBxTGFZQAE4zEQLttWywuzFM+CwfixTE5rINmOiBhVGcOLq0i?=
 =?us-ascii?Q?UhDbJflMG8HSSRpIgblIzuQYM+Hf34bS4ojO6h6fQSCnGFCh7j0xkptaElst?=
 =?us-ascii?Q?i7+4npwLaPtYXchOuZf/7x4KtCwmClqgQXhdzIvQ1JP7baH8M7TuS4uJYYn7?=
 =?us-ascii?Q?0WpLsXjWjc/IClHPKFlCtICtrztD4MV2JWcJapTtexYOWqvT2LfaEFAXlUIT?=
 =?us-ascii?Q?pkKxRdW8rcmK1Y+4/D/Qq+Exx3qNe2DeNN5V89hiDFzu5dbF9YJmS9Jtzqy9?=
 =?us-ascii?Q?LjTglVuIBqxSlK1YuCPw08WsSqsHWoPo+vmbdSFdADKom+0uq2q7Y1nJff2j?=
 =?us-ascii?Q?nvBhlv631DSCUWc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q09qpLaqSZzjpoKFq+5m9K5TQy9SxUA1gg5tmbaPAlf31z8k2SJXlgBRIApP?=
 =?us-ascii?Q?t9HTwbXnBWePdOdDiDIB7pGORxcnq1LscCSmNiBbsjuhStUoLM17ZKBrQ4hN?=
 =?us-ascii?Q?jQRT8zy8DlQFq6uIHT/tQq8arOZfEToJHy5if+2k4FdfBAgnoL8N22RYbZmx?=
 =?us-ascii?Q?AF2ScQvj4FNxSMMk8LQ4fRot/cpy0zSMFwbhS1+okUtckJO0qOTH5qEvi+zS?=
 =?us-ascii?Q?bU1t22o1VuVGqavLcu04wPUSjm5V0AsubEtLkeDihVMGRl0B4zzTXRyn1xgK?=
 =?us-ascii?Q?8AfEPtOZqJQuQrFJUj5Li4APzL0MuKNAjrnpgvS5ZfErXVS6pQ6UPMd9ssdi?=
 =?us-ascii?Q?gjYvJgz9laBO4CmdKoqnJ4N7s5QjMsQfsLLOjdtDEoOBA+hDY3lxPjJV5KH7?=
 =?us-ascii?Q?YwnF18mMKq5ZCsGnP6x80vHUeEbb0bnKk91rO+ru3mXItcxfdoWO4qOOwhhW?=
 =?us-ascii?Q?oLNIXM3fyVUPVZasvckUj1N1oqqV/cE6Bm85xeinw948h30hfEZzjprxhJdV?=
 =?us-ascii?Q?hwCXwdMnw2XqINHcMfpLhXfyUmW7x7lQNyZxZ9DGDBSlQ76BVwpSFrt2i5DD?=
 =?us-ascii?Q?6Xb5egI6/4n5qeyi+YkTszRIeIBuimVYAQGl0sYHNhyBau51Z/trHkJVl6wp?=
 =?us-ascii?Q?nYml4rnUwngloxOd0p3GJ3uMbezBUrVKk3rYSvr3GpJqQGZK1Ynmp0oj35St?=
 =?us-ascii?Q?iVmDGPWE16Bhru+2MnJKx5T8uk1CPmku8pl77k7djui5doDqjIkngucJaoQK?=
 =?us-ascii?Q?NgC+v3yljtefQ7d3d4ijtLaA4HMfejMSLi2jHj53EpEC3x3C+51679Th0njK?=
 =?us-ascii?Q?T5s9Z6Xlj2xetl4iARknVxFFR+SNvjlTuXZibcbJDqoy0XBVOG9gbKTt3hxW?=
 =?us-ascii?Q?hT6rYOjqYMW/5YC+q1phTX/q5lyQXrjX3zhPyLjkwopDL/8853EEgVLzUFvt?=
 =?us-ascii?Q?ughR3ld1IxHDa7UbBtnJ/45DD/oqtyEfPNSN/P7/SrqXyYo3gEAaLIwrsDvW?=
 =?us-ascii?Q?ol7Q+/kw/vY2fMvcKQ6bwCYLP4rexhwP8uKZbAtU5dtHG6InX5/axdZ1dUQX?=
 =?us-ascii?Q?DbrAiVRW1xU5jh9C9JjpIklgnFG92Nk5avkRh/i4ztkd9yY2a8sIzhUJl23P?=
 =?us-ascii?Q?wuGtZmzt7PQ8kh4MsF6PQniSS3kcJnU2PFhAUyhauyr4U8FIWSCo9EODMzw4?=
 =?us-ascii?Q?160J0fEQ3R668E81c/6NMe8GcEKYrX44Jp1fzvnohWXFjo9eQ+mr9Dv1uBM9?=
 =?us-ascii?Q?a01+tD+NaPtaoxrAS8cfnaCB7+QyHOfZERZEOT6WdkN1Rh9zVlxg7QxwBl37?=
 =?us-ascii?Q?kRbS2l+/OJUyCE/UF9UBSNMkhKi24ARpFwT9NvWnBZZfVj004lYpt+0lbDtQ?=
 =?us-ascii?Q?IlhYKYTlVHZ/g26ndkWzlvEGzOH3BDaFeMCPjh16JTvAPlgxtd1CDb3g+Jzf?=
 =?us-ascii?Q?+xyen4BHPYqnN7VlVzvRWcFuTeuNIGRFwpX/ijabcRSvYg5nCx93zNZjflb7?=
 =?us-ascii?Q?pjpDeup3jh00E91BHpkeLVwn62QZ603baGG9+0lsD0kg/p0I+g2jm598oTob?=
 =?us-ascii?Q?55q1htw77GwqjcoguGToheMDnokOZe16e7dwlAym?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56600c90-7082-4dd2-3f17-08ddb3dd0cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:14.2652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im0sAZ/gNQJeLhHTMr8oCrP44K8KCwQCvWBxRLYRJSRyIh2iYiBi1SWS6vZSzJQ05REq2iJpXKBQT6FeAiq6V9me8jLA2gpeeU2eZvkoIMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 35/38] vfio/iommufd: change process
>
>Finish CPR by change the owning process of the iommufd device in
>post load.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/cpr-iommufd.c | 30 ++++++++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index 152a661..a9e3f68 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -110,10 +110,40 @@ static bool vfio_cpr_supported(IOMMUFDBackend *be,
>Error **errp)
>     return true;
> }
>
>+static int iommufd_cpr_pre_save(void *opaque)
>+{
>+    IOMMUFDBackend *be =3D opaque;
>+    Error *local_err =3D NULL;
>+
>+    /*
>+     * The process has not changed yet, but proactively call the ioctl,
>+     * and it will fail if any DMA mappings are not supported.
>+     */
>+    if (!iommufd_change_process(be, &local_err)) {

I'm confused when to call iommufd_change_process_capable and when to call i=
ommufd_change_process, could you clarify?

>+        error_report_err(local_err);
>+        return -1;
>+    }
>+    return 0;
>+}
>+
>+static int iommufd_cpr_post_load(void *opaque, int version_id)
>+{
>+     IOMMUFDBackend *be =3D opaque;
>+     Error *local_err =3D NULL;
>+
>+     if (!iommufd_change_process(be, &local_err)) {
>+        error_report_err(local_err);
>+        return -1;
>+     }
>+     return 0;
>+}
>+
> static const VMStateDescription iommufd_cpr_vmstate =3D {
>     .name =3D "iommufd",
>     .version_id =3D 0,
>     .minimum_version_id =3D 0,
>+    .pre_save =3D iommufd_cpr_pre_save,
>+    .post_load =3D iommufd_cpr_post_load,

Do we need LOW priority?

>     .needed =3D cpr_incoming_needed,
>     .fields =3D (VMStateField[]) {
>         VMSTATE_END_OF_LIST()
>--
>1.8.3.1


