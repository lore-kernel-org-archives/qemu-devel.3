Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F9ACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAkrz-00050L-Ez; Mon, 20 Oct 2025 04:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAkrw-00050B-Hc
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:03:52 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAkru-0004yq-54
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760947430; x=1792483430;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W/fbbgM8UULCLRrE64zSHO+iNjnbWxEUwOCfHI2XvjI=;
 b=AFKp0v0TvvZNw/2bwxIrk7QXz6wFDVW95Nfc0/0LPTedaI720NcUV6/q
 WJRnodb6l5QvNiq9yvdmPBXfn09G6784cfwd2MbhxdFNbuCW1JWgEz8cL
 8Gci4DhOF97u3wlR5CxzLGuDWFJeoxmqxGYJwkxXCMTXqo3Pc3eopYkgh
 cHT+tHpDUwXrsBBWVuaDwgMJErgwHMEspQIL67Yng5E1VG30DT5pHYvUV
 jaThwkO88iJsi06QTEuL+3xSZoXwLryC+I+RSPyjc+OFUFpLzFCR84IT/
 WcDFbzHla1M1UBFSTJWPE5Ix4JdyAk4vo6XTxbeG36Oy1xYI6F8TErOfW A==;
X-CSE-ConnectionGUID: xgVdIEd0SVm6HjqIyZGH7A==
X-CSE-MsgGUID: E08Q6gXNQ7CufT7lkRbxvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="74498357"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="74498357"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:03:43 -0700
X-CSE-ConnectionGUID: Ha1i1FUBSsC4zN41wjGvlQ==
X-CSE-MsgGUID: 2TKQJoDmSx6hHcHf4eVmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183754382"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:03:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:03:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:03:39 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:03:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwjhdWP0Skmv5h2otbcpL+9spLYoumOnFLW7ucPLkobEK7FeIt1uJiP5aM2EB1qx84I/VrnhAm8B3+2NPJ47GPmVCUty0nQrmQd6GOwJEKOXhKef4F4FYxU25soTzlgwz71OakCQl/yPFCYShpjcZvja44vBJ1VN8O3fusyLOqM837uJUhTYIbSRIgfezfc2OPTK8pa0p9QaAihC2TYuJCBY8qtd3pPVEiMPHMsQ4qilm6xuqjEsD/Zr6gxlQVHzKYIXxQQbqZkKoauKrF2D/tlAiRUQS/YxD91/KRoWctbtKWHkRAuD+xOFxKeDVtDn94GhWw/arZltgbmzmaSRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/fbbgM8UULCLRrE64zSHO+iNjnbWxEUwOCfHI2XvjI=;
 b=O+98Gf2ShBCmtCtoaSPFqBXoo8dyAzbK7Pdn+ogzqBGio8a2LtUvEuXKxcJCwog6Z6Z2PyQVqfgNfYvS15iGqWvGpznQgzpOADm6etR5NiaGOfmh+swqFXzrV9t9SdJhLZFDUmjRpAAyVcf4zMvUGtP4etS43u5sxMP/zD61b3EWMQkNexvh3vloRHZoJckKI7yN6xLfwxhABzwjG7czS1arltrrSq/Qg0xEJ753Op0yDlh2V2HeBx6nBps18Nqb9Q7uVrsiMHGjMWUNk/gRzHa5QqHCBE4JyNoVEIb2nbN8hda1lyhb6hjXGHWEGdWx0OeTDCVHatBngZZKbyvyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5134.namprd11.prod.outlook.com (2603:10b6:a03:2de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:03:32 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:03:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Thread-Topic: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Thread-Index: AQHcPz9LWgjkxOjKnUm/UTySYpqPeLTKqq0AgAAFq/A=
Date: Mon, 20 Oct 2025 08:03:31 +0000
Message-ID: <IA3PR11MB913639B9E0AB36CE6890BCE792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-7-zhenzhong.duan@intel.com>
 <5cabe9ba-fad4-4f23-9d00-10f775f12f7d@intel.com>
In-Reply-To: <5cabe9ba-fad4-4f23-9d00-10f775f12f7d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5134:EE_
x-ms-office365-filtering-correlation-id: f12c931f-0fa4-4631-1fe4-08de0faf292e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VU5xR3RkRkJ3NDEvcVJNTGViQUxnUTlObFdUOEwxb3d4d3FMR3ZiQjNGZnU3?=
 =?utf-8?B?SWY0YlVRTDV0UHd0YjBoOUJFVkVseXB5TGRkcWtmZ3U4NDRVSTFiTldqN0ZF?=
 =?utf-8?B?NjlNQUJFYzhnbU02SWtqMFR4S1pIM25PbEhhTVg1eGZPSXUrZHhQN1NpaTlU?=
 =?utf-8?B?aG1zVjVKZGIvSnJ0RWlHNkxCNW9rN0t1bHkxQ2lTamtqOVhvbUczcXVJQ3pP?=
 =?utf-8?B?aUdUN2o4TGNzOXVQdWlYRVRPVlhyM1FCaW5EWUg2RTF5SitxMjlsVmkrNFln?=
 =?utf-8?B?T0NUUEtUYXZEWFE0cG1QL2l4RS81eFVoTUVzSkUxVXE1Y20zc0hwZkc3SEF5?=
 =?utf-8?B?U1NSWklHR1A5cXhVWWRjbUZvdWJqSUZKSTIzRXdWSk9hYWZ2NWhHek1GcWd1?=
 =?utf-8?B?UUNRZy9vanB0Q1hrY3lxdjRVdkFteDU5RlJ6N1RTaExnaDNEcXZVd1lLVWhY?=
 =?utf-8?B?SHBKOWxiK1luOGljaFZjQ1JwekNTSStJZCtjY2ZoRHlIeVdXWDMwbzRDTkg5?=
 =?utf-8?B?L3lSRjA1U2d1OXhtbkJkTkhzNTBzeE9hV2gzRDFjeGxnamdTenVnTzM2bnN6?=
 =?utf-8?B?VFdXcnhHb1Z2TkFsTnlSWHN0VVpNWDU0WFRvOHhzcFBZWGJRNXBBNVNudDgw?=
 =?utf-8?B?QVJYaTZ2blpabzQ3ZVJlTy9JTDZhQ1ZSd1pIVDlJZ2ltSlhCS1NsNWZSTzQw?=
 =?utf-8?B?dk9zQWU2bnFIenI2QXdRVWVuNHdkajR6YUVjSUM1UTE0bWxUQ0pDaGNmeFZH?=
 =?utf-8?B?TUlGbWlnMjFNWFFGY0tIbHRCVC81R1dmNWRhMFVlM1hlVHlXdzVodXl5Q1Fy?=
 =?utf-8?B?amNCOVl0UHdoenlzZ0NCMFZCSUtnaGtIRFZwNDJCOUtlcC8xRmFNZUhGZWYx?=
 =?utf-8?B?SlJDRG9vYlRmbFB0YTBYWkNjMU1pWnZkZHhNdFY0YzE2Q2lucDh2VGFBMnVa?=
 =?utf-8?B?SWo0SXREcktNT3Zqbk1iMENGOFUrUTMwOUY0MXFYWG1ITklsOHNqbnZjbHhX?=
 =?utf-8?B?V2dVSzNJdmpRaTBLTzcwNW1YR3NvWHNRWXRXK1ZTeFd1cUQ0ajROVE5MdlYv?=
 =?utf-8?B?UjVYQm91bE8yQlUwMEd0Zm1Iam9XQ1lFZ2ZqQVE3djJXWXd4RmoyeDd6WUtY?=
 =?utf-8?B?R3A2YzF1NVhoZC9tTkppNTFQM1RYQXNGVEpDOVhaN2paUk5xaDBhbC81SVFr?=
 =?utf-8?B?RTFDUXlVU2diNWF5bzA2WWhRMkg5TTBRL2JrVC9TVlJwZlVETTRhby8rYnVo?=
 =?utf-8?B?azZ5amVWaUloSWJpaFFCZXp4QU5VS3U4M2hHbTZPbmdnQ1R2czB4RHhjWGxp?=
 =?utf-8?B?eTgxcmpBbjZZZWtVZW5rK2llS0ZQMGMraWZ6V1psZTF1ZC9yNXdjcjh4YWVC?=
 =?utf-8?B?Y2dVWDNQNVZYb1JqRDJiblBXTmdYazlaTE9kY3R2eVptTFN3c0NCcCt0UHVW?=
 =?utf-8?B?RXB2Sk1FWGZqbzRLQUNjWmE0OWlaU3cyREVQZjVPak9oUHQ3ekJCV1FaUTZy?=
 =?utf-8?B?Y2JGRnNrdUhOM2NsS3VFR1laMi9kelNCUVQwdkJNQXlKOHV0c0ZiaHJwVUZr?=
 =?utf-8?B?RTEycjAwNlFnb3ZZSGRtbXdVTllHcFlOZjlPenJBWEZkNm5TeWdLNVMxV1ZR?=
 =?utf-8?B?RU5UazY2eHl4dURnQWdQTGtCTDdOdUFQcHd5cXZFRk5UMnBEbVI0UmpTTEc2?=
 =?utf-8?B?Q1c5MitBa3czSCtBU3JYRmVoSlI4Ry9PdmVOcTFDOU12VERIMW5jeHBaVmpG?=
 =?utf-8?B?NkxUVnVRU05TVnBhMFZ6MUR4bHhZUDFGUFdsYkFOT2FFc3VoRjNLOElrTVhM?=
 =?utf-8?B?YndvaDFCMUpubFd0R3hHNTZ5OEljRDg0ZENaMlBZNVlnYzhraHVlSkdncHdM?=
 =?utf-8?B?OXNXQXNGUmpCdDI3bmZ3aXljbFpuYkxBYVJKZllMUkF6V0FQT2lXaVY0eWdB?=
 =?utf-8?B?cEJhbU5uTUtqeG9wRkxQNFpSbWtnQWhZUkJTcTMxODVZekNEbkVTWEdsSGd4?=
 =?utf-8?B?T1hKRzh5L2FtSDd1YTBaN05wTDAvaDFySTc3QUpYdERoMTJmbXlJNUlmVnVW?=
 =?utf-8?Q?UQ/oAg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzM5T1RtUEJrN05Mb0dHWU1xRWljR1lyWGZ1UFVkV2Z1NG9VeC9JZmZLR2hU?=
 =?utf-8?B?MUdMSG5hS0NuN1pxUGNFK1pHK1Z1bEN5RjhuWWRFZVBGZHZHMGhLZFY5ODZE?=
 =?utf-8?B?TWNiUjJIcTJqSXVvU2NqZTI0SDhpYWRzNlhLbEVCempaQVZ4dGxoV0EvNSs5?=
 =?utf-8?B?TnFFQkp4UUFwWVRjdm1UanpVcEg5UVNIdXMzMVJRSTU1NDJ1aEZqcjB3N0hD?=
 =?utf-8?B?SFMrTFp2bjVKb0czdEFWRGh5VkJyVnJDNjhUd2RvMDJBMUMvRFJhRk9wR2ZJ?=
 =?utf-8?B?eEd1clZVNU1uNTFzdENBbzdGZ2pGR3BPd0pLbWNBclRjSUlmVkNnYldEZlpi?=
 =?utf-8?B?Ym02NkJ3UytBQ0hqblRUcHJlb0VHNkM1aFpWUHVXM3JHZWRlQU1VWEF5TXVS?=
 =?utf-8?B?V212cVRMZ1BHNEMyMVZpWXU1b1ZZNlFkenAvdnd3NldFYkIya2xYOVZZZElO?=
 =?utf-8?B?TXFLSkdaeDJjc2orZEluTzRKMG5NOUV6RGtKK216ckpTQmJMZmFzL0c0dEVn?=
 =?utf-8?B?MUZrcEJybUxlZGFXTks1NnVpVFNyZFBXWnl4aTZRMytSMVF6T3FQTzBEVHBo?=
 =?utf-8?B?OHRaSUFaL0wyREpybnRwcjZ1MkVHc0JsOFJsQnhCQW1UYm96UVVNSDRCcmJ3?=
 =?utf-8?B?TFlVTndQbmVnNmNpK1NNOGZGSzBRTHl3M2V4dmhCUHVlcUtkK09XZnZtaTVs?=
 =?utf-8?B?ajVjOC9kZkJ2SSs3YmlPQ01VVlRDUVB1UGRyL2JSVkg1Tk1tQ0pvOXZZR2hV?=
 =?utf-8?B?WS9pYU82dHEySWROZDRUNXY2TmE5WVo3SHZ1Z1NzQm9SKzdrRUM1T2pKaFFM?=
 =?utf-8?B?UFpmUVpweUJEZWRXcndjQWtwTFBYa3IwUlRTcWVmS05lSjl3NHEra3d6cmNO?=
 =?utf-8?B?aThGVVVqTHhnYmZxRWNac3BCdllYblpCNkhWa0JyWFNmRjJBMGpGZU1wTVpm?=
 =?utf-8?B?K3VjZnlMU01YZHNTYThFN2QzbUI5b1RmK2Q3bGwrZVVpQVBpQjd2QmhLOXFj?=
 =?utf-8?B?Ymo4UDFXRDR0bXdBOHFySmdlc2ZOemc3NGo4MGg4d1BGRVFWY1VOazZKUEhu?=
 =?utf-8?B?dE1zRytCTE1PVkRtSGJUWlpNWC9ic1hVUzZWbUltd0h2RDllVmZSejdWdEZu?=
 =?utf-8?B?aG5iQndmVllVeEFxbVMvalhhb3ZsUDBPVmhpWFdia2hMSVErZEhVMWh5ZW1x?=
 =?utf-8?B?cVdKcFdlSFdJeVhCejNmRG41a3JhVmpZeGJJTzdsQlpWOEwyRmNoNUoyODlH?=
 =?utf-8?B?UVBuU25Rb2VlSjVzaUx3N3pHUXhjZTJldER2blFzdjdxeVZySzgya2ZVVFEv?=
 =?utf-8?B?ZE5YRDgvM3RKLzJ2TVpSTUpmZEwvTlZVbHVxTC90M1JSSHpHSW0xRHpUWlhp?=
 =?utf-8?B?bnNpVWZaKy9VaytPc0VVYVB4cWFGdzMwbkI1WlcvMm0raUlIcUU4c0U2SVgy?=
 =?utf-8?B?T1VmMGJkbzdmWjlBWmJKY3ZSWUpoMnV1T2ZydjU2MndnNElSY0hzUktoS0Nn?=
 =?utf-8?B?QStpVCt3amFsRDJuZkFUL2c3QUpSYkVoN0xXbVpQS1VZMlkwRlBuZEp6YTlD?=
 =?utf-8?B?cmMrUG0vaEVjZGV6SWZlck5QSEx5VVRvajJKQVM5TVBkY1F1dlBWYWIrYXQ1?=
 =?utf-8?B?U0pIcDBMUVJBeGVZUGFCbTdMZmRRUWpVR2JvSmJqd1BXM2lQc0EvV0ZOUm9q?=
 =?utf-8?B?SmxEaTZ5S1FyZVhJcXk3aDE5bmVQajJzUFVwUmFRcWloV254OEZNeFc3b3Bs?=
 =?utf-8?B?RlRHcFFLRmluUE1peS9PcHh3VEl5K1ZTa2oxYkx4SkxsYzZZcVlLUFdmRzR6?=
 =?utf-8?B?OVpsS2NjZ3BVaUIreWpDbU1ORUo4Rm9vdjRtQndBSkdmRmpKeTJXQmlsWTZ6?=
 =?utf-8?B?MlF5VUgxUStZc3BRSTZjNEZrc3Q1WFMwU0ZzSFR2dGxPQnVOVnJwSHlOWS9E?=
 =?utf-8?B?QmdvaVd1WWtaUGxxMVB1S2VtTWpUK3N0ZXl0YWNFVktidXZUc1ozQXF6a3d2?=
 =?utf-8?B?T3RIWHZoK3hyckRHdmt2dTkwc292RysrZmpkQStPTEwxdkpRYk1BS2tWQXRq?=
 =?utf-8?B?d3FoeDdWUVlJZ2VCQ3REUWlCWWZ0YnVUM3dFN29oMUkxYkdBYlpWaWVDM0VS?=
 =?utf-8?Q?K8eHAJ4qIx8hpDKEUpnhnzsDa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12c931f-0fa4-4631-1fe4-08de0faf292e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 08:03:31.7490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33KecHyv6oa2h4YuEwY1JLNQeRDi5Ik7t4rDJFb9jLRUMSdgRUFOG8qsaCc1+kD97RgLhBS+ph+1vukHVguUYIPEzdUNJjbtpMcgtS5DPEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5134
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNi84XSBpbnRlbF9pb21tdTog
Rml4IHVubWFwX2JpdG1hcCBmYWlsdXJlIHdpdGgNCj5sZWdhY3kgVkZJTyBiYWNrZW5kDQo+DQo+
T24gMjAyNS8xMC8xNyAxNjoyMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJZiBhIFZGSU8g
ZGV2aWNlIGluIGd1ZXN0IHN3aXRjaGVzIGZyb20gSU9NTVUgZG9tYWluIHRvIGJsb2NrIGRvbWFp
biwNCj4+IHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKCkgaXMgY2FsbGVkIHRvIHVubWFwIHdob2xl
IGFkZHJlc3Mgc3BhY2UuDQo+Pg0KPj4gSWYgdGhhdCBoYXBwZW5zIGR1cmluZyBtaWdyYXRpb24s
IG1pZ3JhdGlvbiBmYWlscyB3aXRoIGxlZ2FjeSBWRklPDQo+PiBiYWNrZW5kIGFzIGJlbG93Og0K
Pj4NCj4+IFN0YXR1czogZmFpbGVkICh2ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAoMHg1NjFiYmJk
OTJkOTAsDQo+MHgxMDAwMDAwMDAwMDAsIDB4MTAwMDAwMDAwMDAwKSA9IC03IChBcmd1bWVudCBs
aXN0IHRvbyBsb25nKSkNCj4+DQo+PiBCZWNhdXNlIGxlZ2FjeSBWRklPIGxpbWl0cyBtYXhpbXVt
IGJpdG1hcCBzaXplIHRvIDI1Nk1CIHdoaWNoIG1hcHMgdG8NCj44VEIgb24NCj4+IDRLIHBhZ2Ug
c3lzdGVtLCB3aGVuIDE2VEIgc2l6ZWQgVU5NQVAgbm90aWZpY2F0aW9uIGlzIHNlbnQsDQo+dW5t
YXBfYml0bWFwDQo+PiBpb2N0bCBmYWlscy4NCj4NCj5JdCB3b3VsZCBiZSBncmVhdCB0byBhZGQg
c29tZSB3b3JkcyB0byBub3RlIHdoeSB2SU9NTVUgY2FuIHRyaWdnZXIgdGhpcy4NCg0KSGkgWWks
IEkgdGhpbmsgdGhlIGZpcnN0IHNlbnRlbmNlIGluIGRlc2NyaXB0aW9uIGlzIGV4cGxhaW5pbmcg
dGhhdD8NCg0KIklmIGEgVkZJTyBkZXZpY2UgaW4gZ3Vlc3Qgc3dpdGNoZXMgZnJvbSBJT01NVSBk
b21haW4gdG8gYmxvY2sgZG9tYWluLA0KdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoKSBpcyBjYWxs
ZWQgdG8gdW5tYXAgd2hvbGUgYWRkcmVzcyBzcGFjZS4iDQoNClRoYW5rcw0KWmhlbnpob25nDQoN
Cg==

