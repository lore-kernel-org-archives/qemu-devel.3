Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E94CC3DA6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 02:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHZVb-0008RD-5F; Tue, 20 May 2025 22:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZVZ-0008Qs-Af
 for qemu-devel@nongnu.org; Tue, 20 May 2025 22:48:41 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZVX-0002Tp-IQ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 22:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747795719; x=1779331719;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qiq5NUx4c7s4wxclEaqA1+H70hq4/4oTHZtrG/dDNUk=;
 b=IIIUs3ekDdET1nJWbucIP46758mfG20UsnUeRPPxsAI0LulniRyvB6Lg
 4HVn+ksyoeY0N4Fogok3qDbc11B7Pw021+EARkPaDLYohuMMbW+4LsKz2
 KDMHw7g3Dlm6OazGRTtQSh4kh1lwI4n0Hqnv1X7ygUTR4otWHHmCEktb8
 yfU1mqCOJ9sp7OeNw5ekIuyPPAoVp794kIO/YOmRlfs43h/hGqAg2m2J7
 3PL1O9uvjZU1Qkds/cwRwCdtVyHRNvuL8cSehZfCuImFinaj2wDINIBu5
 +vB0wWQUr0isNo+eiSjyU/aOIfFmjU8zbKDGpWOj68snMcAOTARwxTkwB g==;
X-CSE-ConnectionGUID: 3oytzxirRiybeG+xSgOVGQ==
X-CSE-MsgGUID: Pd8nmbmHTuKv2EN3mU16Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49656639"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49656639"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 19:48:36 -0700
X-CSE-ConnectionGUID: ScBJHzYwQCqKjsvc22dWYA==
X-CSE-MsgGUID: 6pBPOk5EQrO3W0h1rc1qeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145028035"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 19:48:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 19:48:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 19:48:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 19:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5VCBu7AKozWeCZQFwoTaod70Pxi26RtnAVkM5cinbkEw4fQM5FyltGZg4CRGewyiYRHNOJ4FbjxbMapGb6jDkLLOsLzUKm+TYTwu587IoRe/WlDVkTwVWoYt9r99x6EIS5WZz4NU0REwPDTTa+XSk4yyR/OIxiSm4zgpGpOJj9fxdXQSgqBnkIxbNowBTofgS3TQ+ZE9fWRaPfBLFE9rFLULcbEOZaSIAyzUVYl+8uZCSp3HB00XTN/Ij5jaaxtlF33+v3kEAXigk/C9CmsVqNiS+PkAQW41UgG/jL/m94/rNxle1MnjGUI0I5ozRRD4Hm6P1qMoiQaQEfDF7DDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm2kzCDwIRSQSlfi4tuWlD10Yh2yBThH0Fg2z39x0IE=;
 b=VeVKowuO/Y+dgpYzPHOmtqEMqkba5colvBeXFM1e10e5tgqnvTU544Ji/rvgvZIAI2szHl83vyym8bTiC0C2Lb8evQ4JrGDB/9YlhrU3DIpeHU76VvGS3eXhl0drM2ocvfFnXGeuPG9ir8nUJLbm7Edb4V1xiTebOrR0KJWG9HU6vAUa59Q9GkKmze2ypQrayVqjZqM5pFRxN8QA+EjGPu/FO7+k4KWIofbBeVdO07QHxhkQIuGn0TsQkc84p/U2RPHDKXM/XvdRNgdbyTsjZXHKAVgtriQE6HmyJBwzjCRkg6/4hwarL8KnHzf7MAT3wKteNSbssaC9UeRgn5W6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 02:48:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 02:48:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
Thread-Topic: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
Thread-Index: AQHbw1NeyTj0Ugl2t06fgWEXsIff/bPU+E0QgAaIFICAAOSXoA==
Date: Wed, 21 May 2025 02:48:28 +0000
Message-ID: <SJ0PR11MB674429DE6E6421031651D44A929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-34-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9ABCAFF7FB3204BA6549293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a61b557c-5cee-4a6d-bc68-973582b797c4@redhat.com>
In-Reply-To: <a61b557c-5cee-4a6d-bc68-973582b797c4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5929:EE_
x-ms-office365-filtering-correlation-id: 725d1f6d-8cea-47e8-4bc0-08dd9811f722
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nMR7zdZxwb9SJ1toZXLAONs1HPeTVdxrm84RIWwB099bIJgjMOhNOafkZs?=
 =?iso-8859-1?Q?b9eZAwtF0HMsRvMND6egvlNOIQkf478FLxtZN1vKAcCEGhfcTw4BMU742B?=
 =?iso-8859-1?Q?llS04qkdCXHXLyHMlhfdVJME4gZAcLffuhsjoK2ZD1b7lWjHWdw33Pg05/?=
 =?iso-8859-1?Q?3365QD7yB1CxLFyyLf8EjRA2ca0QEkjvdX7QPigsSlpg0MP7YlkpKLFFd+?=
 =?iso-8859-1?Q?RixIOsF7b6TTNO9Jn2u7CB8RsDNS7RNJCbYf5LkhfyiaUUq8VJo+0B2twv?=
 =?iso-8859-1?Q?MXTEYaQAsX+Ya2TvjD/00tiOc6eCY0W/8eIrzFsPLyTMvbjm8WSyGa80GC?=
 =?iso-8859-1?Q?ZTwp5l8y6XKqiXOtHX+WlAlHTrX2gTHANGB8CBguPLmpF1t0XNaFH0J+UI?=
 =?iso-8859-1?Q?Wr0qdXqGUBlkzcSd7yynPSvDKGLUpE+PcWhaC0Emi9vTvFPntqlB0UUFr1?=
 =?iso-8859-1?Q?kzQbklu6y7FqOclDh/V6PbeNUTZ7j43LBBA7/G8nBmmdBngwyK1GM8GHE8?=
 =?iso-8859-1?Q?ufLhVmUMVymLSVd+BVNNSE2Uu43zJwW8EZ0HaVjXuDG6TRQOWP6MRA+ay7?=
 =?iso-8859-1?Q?eNDBBG5/dQLDJ+Hsxs0aR//Rl5ZOL0b1lCGvEn1L684amC8+Am+1vvsx49?=
 =?iso-8859-1?Q?zV/mwgTnRlr41cV4MlpTa8VavkwilQ1VHHOnngLgICgqDNdNTKNpaKDZrP?=
 =?iso-8859-1?Q?koT9/suBHhyz1+sUL2j8nj3FDlT7E3nJDaamcVLYuJk5ce/kZPIpole4Kd?=
 =?iso-8859-1?Q?/xk+oi5cdQoM3SGzLZSkNVjekyiWedfYBsohbWG2xeCELGJDnT5qIOb4xe?=
 =?iso-8859-1?Q?3txsTCvSCHY/+93971YrJlrtlptaNMfDuFxov2HnXIWzoro6HybBeKSMeD?=
 =?iso-8859-1?Q?r5lPam5+bsY/JJ9eaLdBEUEqHSR/GR1T53AgMVNmNVkp070ARPJq9oLmcE?=
 =?iso-8859-1?Q?9k69Bi4AgtgpO5BPZWy49qoon8HGUeyRN0UeVsLlAzx+Znc4wBbx385qbC?=
 =?iso-8859-1?Q?j7BK9juz8gj1zIhfUxOhxfJHEft0KSweG0ql51gg2RuxcZVWZQXP4Xys9E?=
 =?iso-8859-1?Q?yjjS7d15iMVt6P5uSC+p8waOCArByUZdakxF071ZpMpPLzD0x3KZk/yDyV?=
 =?iso-8859-1?Q?VjvA9kwNqO/ilTxg9JtO0wL7LVNrjUMT1Qo/qV7wU7AjOBnGohX5g9WGxk?=
 =?iso-8859-1?Q?cHzLouK5N3y3SHEQcHoE3bDKMwvjvAxR7xZ5KH92Ym2TUuWNNiZz0SjJ4H?=
 =?iso-8859-1?Q?qbx2025lLzPmHabXa8VHpcZd7k/7DilFoyYX3C2L8YF/5F3JBdIPmmssVr?=
 =?iso-8859-1?Q?JW0PzCLM1VfHpj17m0svLFMlYE7e2TMlMJ/LPBCUy58idvWrk+jylMw3z/?=
 =?iso-8859-1?Q?NveXXIrkPcCAnzmTNsVdXZL5pjIwzVwve5ZIa6NTefgEX/YhYEK8ARUNNI?=
 =?iso-8859-1?Q?emxgGabYQYNmsxq2Yrq8TZxyuurowyAOn2VChNr6+ytzfrO8ENgCvt3Mgc?=
 =?iso-8859-1?Q?ot/YU8kfNmVizxudnAhaq78Gbsqwndb/sc6y98kMrUvw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IE4OzRdhgOL5XKTWZusOKhHltWUEYUImd35u8wiv8xww24doHb4EmeWr+N?=
 =?iso-8859-1?Q?x2Ajc14o92no69dg/m8hli7EqqPnate6PqV+ZF+YvcALRqJ4AFvUgGYpn/?=
 =?iso-8859-1?Q?gfNVVpY/SAvK9FvFyqSXCRcLsJ8XU8WLMS0qCYOT7uEon7X3wLQ6uS61eQ?=
 =?iso-8859-1?Q?Dr3zvx5hgwPqbp0ecxSjfO8cIMd3czqDO4xx7FtboMW2kFnx7zt/fw2eBp?=
 =?iso-8859-1?Q?5mVNUCj7W1K5xAwsz0ta0VBl9Bomq6E2nm7Uzb062Pqqx+WaW7xfM/4B8D?=
 =?iso-8859-1?Q?XdQ/EGcGOQ8Apj9czCgi04/qPScBQAkiZwOWHiLZZstnv3sRR9xYpeWj13?=
 =?iso-8859-1?Q?RWl8xvrDnPzZw9ixGB47+brNW41IsVksZGJaanbwFprd5Hl5kH2lv547zx?=
 =?iso-8859-1?Q?Cd/i5jsInqi1FLiv/W5C0qHooYf70alwVkD/i+GOTaHnkRo5rLOHI7sYya?=
 =?iso-8859-1?Q?eY1XQ0wQY7jeBb/UeTEc9w1E7y3FSdp69yGjT5oEkMt3CWInpY52z1vYrp?=
 =?iso-8859-1?Q?oHeYVXsB7LdTeMWHnA5kY1JjfPGi4g3iP1RCh9COzGgHB+qtdes3yb9O/B?=
 =?iso-8859-1?Q?YPBMCp+smOpMIhfImtKdE1PJkwMkx4gPJZ91oifHHikkg1ddM4ZZnv/4Dj?=
 =?iso-8859-1?Q?Ju+yuWhrrbMWYlZcWl6ELZqHgBz649SYNbft0xuPd4whYgg2ZW2+tpHvmA?=
 =?iso-8859-1?Q?FiK03lyu0iLDc0a130ftNs9qVDisBTtHAjbKgj6mJmC0GtX4RYYfLDst6T?=
 =?iso-8859-1?Q?HHNit9INEKfq1FkU3rRShnxWBuoroNayuiWqlihtjskowG+bLSWUj/4LKU?=
 =?iso-8859-1?Q?DVVfr6e9oMTAbWu1netG4ktiSuDkSW96pKJbewHjVDT4gCN9nYUth2WuKD?=
 =?iso-8859-1?Q?JJG1wKUWB9siqwJud890jzWpLnMSwfeVgMj3MRqhBsNkN1w8L7TwSLXS2a?=
 =?iso-8859-1?Q?VLqAzspfv5O8Vvy/8Vn+gtNxi0p6OH9mMJcM0O408A3YiFV6nqPZlUwzdl?=
 =?iso-8859-1?Q?R0/CR8J7ceoIvvgAngqXgQ//Hv+WL4UgeTJgZKs92b4FZz0TU/9eMzdJT2?=
 =?iso-8859-1?Q?b89cBlG37EPJF+tw4DG2xJz1SxZiz8G/47Tzfskkkp/R4wPba6ZLIi58Ks?=
 =?iso-8859-1?Q?eCLRoFFixvZuuxPSOdgO9MoTh89hORRBnSKk+XmDfdmGrLJXrjMVcHEKqf?=
 =?iso-8859-1?Q?ccaiLw5fl5UF9fHqcb0wvQXTZmfBr7lKo3M2vFehWLNuRKfdEZWPdnhSm8?=
 =?iso-8859-1?Q?RqqW3+F2r3Uqvr7Ig0sXBoLo/kYsbFS9S2SiDB8OkkdQhtra9hLmuvhf/q?=
 =?iso-8859-1?Q?FNCa90Z0kp0MLD4mOI1bHH6ATBUWV91J7SUQfj8uCbxjJM/PDZ4j8TR4lY?=
 =?iso-8859-1?Q?BOunCyWgf+9UG7OsqN4neKLjoJLow+P13Ti9pAiMwRMuwuFl8QoQbbU2Pm?=
 =?iso-8859-1?Q?qcIpm6oQ3mcCcv2gDDJYk52XLsuraLkwbY3GH2/FFRHeyD1ToaJxucn1Kz?=
 =?iso-8859-1?Q?7Lx5MriwhANJ9SVzS/ObiX7ql0KGSAJ4bUPUFJh+lPjuKBAgmzaxPlIuMv?=
 =?iso-8859-1?Q?/W7av21/WFkcQxkBxmM6Hz/of3j93TpyRbbEHLBcmIa4DBZ2EkTOPQJ2Eb?=
 =?iso-8859-1?Q?luJQSkHeu2ZJOYYxV9qBUc2KL52qopzw/l?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725d1f6d-8cea-47e8-4bc0-08dd9811f722
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 02:48:28.4471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f19kxGn4l8gEaAoXad5B4TdANQtiFid1DIZOKJsfwsK8hkCjHWIuf7OOpoO2Gf9tYdQpJqIMkxDCnHMVaguGGWV8tnclh58k62GUS7C5xLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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
>Subject: Re: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>
>On 5/16/25 10:55, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 33/42] vfio/iommufd: define hwpt constructors
>>>
>>> Extract hwpt creation code from iommufd_cdev_autodomains_get into the
>>> helpers iommufd_cdev_use_hwpt and iommufd_cdev_make_hwpt.  These will
>>> be used by CPR in a subsequent patch.
>>>
>>> Call vfio_device_hiod_create_and_realize earlier so
>iommufd_cdev_make_hwpt
>>> can use vbasedev->hiod hw_caps, avoiding an extra call to
>>> iommufd_backend_get_device_info
>>
>> We had made consensus to realize hiod after attachment,
>> it's not a hot path so an extra call is acceptable per Cedric.
>
>We also placed the realize call where it is in preparation for
>nested IOMMU support, and avoid a late_realize handler AFAICR
>
>
>>> No functional change.
>
>
>We should add a comment before to make sure the code is not moved
>around.

Yes, I should have done that last time. Do you want me to send a patch to f=
ix it?

Thanks
Zhenzhong

