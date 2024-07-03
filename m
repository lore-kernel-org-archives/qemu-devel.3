Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDC3C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOyaM-0008D6-Pw; Wed, 03 Jul 2024 07:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOyaL-0008BX-MC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:55:41 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOyaJ-0003QO-DY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720007740; x=1751543740;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cC3IpZ5AGEh5T53SXfJT2JnsIfv8IOt8Zp5SExUt008=;
 b=lQ8TErj0PmnkNisIDjQ431SlYm+3c2WuZbCYQmZhyvRcG50tnC2EafwV
 qgIWX+lhSrwJZ29lmyop+j+rPqk5nExcu135aQMzMgaRCNch7GRMip1+w
 AR0YbUGaCWVxiFMxmLNXLEI2NghShy/Ply8T3b879wiX1XFJMj7D3+Ei6
 gK5Uyo8e0ZeXaZaQr7X0MGGvLImiaXvSLpHvlhEvwjdrX94EC4LoB/M5B
 QyeBjut2S5INSq9vFRY7u//o4rSu4xsHi9riONuWGWsrlwfjXi0pmYJ0X
 qC55jmcC2qWBYUuCUQjvQE/eSjPefOZYLKQAhDJclpT6HfYYWjqA/RY1c w==;
X-CSE-ConnectionGUID: o9v9wItpT5OlxZpdcAGU8g==
X-CSE-MsgGUID: wi1RkjfoQniLIs10eYkRew==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="21041659"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="21041659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2024 04:55:36 -0700
X-CSE-ConnectionGUID: xJX7sw84RZqPhojkU3ud7g==
X-CSE-MsgGUID: ze7w2LI9RnCSjh4er1Symw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; d="scan'208";a="51419726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jul 2024 04:55:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:55:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 04:55:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 04:55:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 04:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzkHgKt6yUO4TVTmmE4S7ThyuX9SjShSK9GYtlhS8Kl0Do1F/sVfSW0AZkkcU4apdtkUyUHbOAWPx+w/snloTUoirx4yURcMgyH7aSgP4UnsyMrCh5RGxQU4aK1jJ+v74lG6isYXTAI+ZFfjZGNOCiw0ycrP+cJTwSBRwd/dXzetOKPc6pNy3nRyoeb9UApzgYSV754Ox0rAUds4An651qjlV0mzhsLV6DBzSlGczYTMPTg6Xnq+fOmZGyFLdufEYMYoN77zH3rzAKRA90P3GadYwsW1p3eGR97VuuN/bKMwknUDDMutfwzrvq0sjSRD7n5HgBbo27AD6me3vvOwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsstuElhGDx9g4Ebbuq5erxV+DUct3wb6HdomF24Whs=;
 b=lG4PJzYfWSixBe+vKg5uts5tqWk6IkO3XOZdXzpxCADUi3X8RN9p34WNlQLgO1waMQ/KUKiUDQaNy/a3k+4PVbwthPH+bxp6zxKm2Orwh3AiuPhaGqcKsFIBAQSZ9hgp575lKt6Wnh3HZqTpeByhr3ny85cjNK6FXVxzExbkaBOk13AyM7gTwTEQotxqYOTNkcXIF/XdC+h4KmM957QLnL6SBUImNgp03IJjlQzwNl1t9FuHi7ZswYAwXaDeAhCmrUyBLprYtLFrUecU29pWyviU9r2/Gbl+ayULNCjeUvki0tSMNMfpi0j08gycrbtOjrLyHr9H5WvyfV7tpRqtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6653.namprd11.prod.outlook.com (2603:10b6:806:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 11:55:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 11:55:32 +0000
Message-ID: <6186faf8-7855-41c4-add2-1bb7860c2cc2@intel.com>
Date: Wed, 3 Jul 2024 19:59:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 03/22] intel_iommu: return page walk level even
 when the translation fails
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-4-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-4-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd43438-fc63-4792-2474-08dc9b570a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnNqelowenlGOVA5WlRLaW1FU2hHbUwyZmVjb0RsWlBSa1VEWlhtTmNKZU5C?=
 =?utf-8?B?RTNMcDFaNWxTSWZxMEs3bXpoYjNZKzF5cXR4NitUeXB6a1pSMUo4T0ZxUlBT?=
 =?utf-8?B?MFVia2FRNzFoUFd3Qi9INDhpazY5clhabTloYjZHOWZoaXZtQTNHNGl5bllN?=
 =?utf-8?B?aEdRTG9EUDFDL3M4UHpXYzVVSGVsRmF1ZUpzRWtST3J5bExuNmtCY0JyRklo?=
 =?utf-8?B?c2hYL0xKWXUvY1U1dm9aNzQvNFJZWmNDNGZVdmVSdG0wSXpnUWxsQUQxN0Ux?=
 =?utf-8?B?Nk01MFNFTERHdXRZUzFEblQzY0NNNGtGckVQVk5zNUNnK3pvbktYQlBJdFFq?=
 =?utf-8?B?ekplaFYzcHZYSTRpWmhiOVRkcXh3SUF6ankxa05meExuYTdrMEx1SWdLZDFI?=
 =?utf-8?B?YjZYTVozM1FBcWRQR0lqOTk4d0xmdkh4cStpNXhKK29ZamF6SkRiSWg2eXZn?=
 =?utf-8?B?ZlErMTNGY2xiU0U5TmhDd3VNaWNRV3hoRHM1ZmY3MXFwUXJvVFFkallLajhj?=
 =?utf-8?B?RkovTzV6WDJJNitNTDJvRVhMMDlGaG4xbWdzeGtDdU03N2Z3NFErK3NnOUxL?=
 =?utf-8?B?eGRQakJIc2tBc2s3ekFDbXVWTERGamxDYjBySlRoMkxWN09Kdy9CWmhIU3BM?=
 =?utf-8?B?eU5Md3grME9sakhDMEpQbzZTMHA5emZnMDBnQ2J5MFdvMnRXRTcyc2ZSMDd6?=
 =?utf-8?B?UUNCbzlqMmZPVjd5TnVlNzE4R0JiVU1SQ3QrSDFteGM4ZjdxWktyKzVGdWw2?=
 =?utf-8?B?djI0Njl0RkJWRHBpc2RLeVUxekZOY1NwOXgyVk90YVNlWm05cVdJbFNhWHlw?=
 =?utf-8?B?MzVzbUtJaFQyZ0NjRzZHY2dhZlF1OHVVWlJRWmRhVGo2RGtIN09IOGFDaW11?=
 =?utf-8?B?RExObWk0bytEdVNaVlpRZXlGTnpGZzlodUZlRm9ydWVPUnpBd2hXdE1INmFL?=
 =?utf-8?B?a0p1UU1vWkZUM3JLc0lxRjF5S29rWjNndHdpQmJNMkQrVHczdS9mWTdhV3ZM?=
 =?utf-8?B?aU1GSzBRR3AvOGxMWG5hSXNZOG80YVRZY2crTGxoV095TGdMdW1zUFdFOGJS?=
 =?utf-8?B?b3F0WXlXZkpzcWVweGVqQUp0SlltSUpldlM4SUdLY3Iwd2J1VGRRUnJvTnA1?=
 =?utf-8?B?dUJQak5TMDd1Z1VhTmxrTkZkTVhBYzNUR2FIUXdvVEdTV0hTOS9aM3FaYTc3?=
 =?utf-8?B?Ky9rVTRITmM4L1ZETVprVU9ibFRXdnoybGtZVlYxektGeHhTNE9ob3FHRlI5?=
 =?utf-8?B?d0NRditvZGMzRVZ5eEtnVjVLTythcXhOUUtBdGZBdGxhTE5TWmN3TTFPZlVt?=
 =?utf-8?B?UHRyb0h4OGZOTElBcDd2MG9NRGdMaVB3eWpCSzAwWnFrNkFQUzdTeWw2Qkhm?=
 =?utf-8?B?VWVQZ1lrMHQwVk5JZWtYeXlkNEt0WlJsMldhUzJzRVcwUFEzTUhMMllkZmtM?=
 =?utf-8?B?TXppeGFMd1NXQjBhODdWZEdiZzBFRnA4cy9wbjk5cndDVlplK2lidmtIQkQ0?=
 =?utf-8?B?RGJ2MmQyeG5Da3NnVUhET3pHR08xK3VWSjlzSkJZS1d2amFvZkI0Wnp6aUV3?=
 =?utf-8?B?WVdGVURjeWZLTW0vQTNTcUQ3UE5qVzhPYnc4Nnk4N0pNbkhJaEFmdFJyczZI?=
 =?utf-8?B?WjNCSWcvZmc0a3dwTUFwU0dTQUhYcHpDdHNqNjdYelB3cVFrQktvQXhhcHY1?=
 =?utf-8?B?YkpjVXVOODJza1pJdk1wOXplcWlpNjNVcDhmYWphbTdzclc5dmc4OHQ1V3Jr?=
 =?utf-8?B?cFYwVWtrbnI5NDRWOXR0MXdsbDBPVzdPZTNWSUh5L0JHU0ZWTEd1bVpsRmQv?=
 =?utf-8?B?WEFtRnN3Y0E2ZWpYRW1CQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW9TckpzSjB3RDFZQmlLTjl6aDJpck9PSzFKMC9JTzRSN0xkbGpkNGIzaWNP?=
 =?utf-8?B?aUw2azNWT2tqQ1VyNHlwYnpXMVQzQUFHVTBEMWMxUUl4bnhmak80NGdjY2hn?=
 =?utf-8?B?N0w5Z1A5N1VtdE4vUTJaZHAyNTdXbHRwK0VkeHV3NXNoY21QN2J3YS9TVWFx?=
 =?utf-8?B?NjczakJsbjVqb0VXU0Z2YU1Memw0b3JoQ3RoQXNkOHVSaTdNQmlzNDlubXda?=
 =?utf-8?B?OU40bUh6OFVCZmdGWVZJeXk3MDFsbFNPdmF1c0hOYXBnMzh6UjgvQjVpbXRk?=
 =?utf-8?B?Uk9MVVdFNzdPd01KaEVOUytDUEZwWk1ySjBuR0lpcEtKQ2w4N3ZxQkVETjNU?=
 =?utf-8?B?ZlhCb0N3dmZBT2xWeVVSWkw3NW84dnpzU3pTSDdGcVNqaG1iUndGUTZqL3JI?=
 =?utf-8?B?VVE4SkFDSXZ1emQwa3NLV3o4WTJxYjNXT1BtOTdVckk4N0x2REp5Q1pETU5o?=
 =?utf-8?B?endPTHR3K3h2aFR1RVFaVXZXMElUOGMzZkNoalR3WU9URFFKbTdnUzdWVzRF?=
 =?utf-8?B?bVJhRXNRNkJpSVF1RjlqR0ZtNDA5ekZXZ2draTZLUk1zemx5N2VuNFNabTdx?=
 =?utf-8?B?cXpGSExLejR0ODNDOERFUjRjZC8vRXlNOWtzd3ZBVW4xTC9JQ1FuVGxEdldn?=
 =?utf-8?B?VWpVQjhoZUJMZ3Fsc1YxMEozaXl1SUZTbTgzdDQxeVM4UEtEYjh3TmpLSFhJ?=
 =?utf-8?B?RHBrL0NjZnhBOXZXbUk3N2kzK3VyVGFmamFVYXpPbjY2SUZIOGdtaGZuZElR?=
 =?utf-8?B?VmNYNnhRc0owT1ZCb24vN0V3NGttRzlwVzU4bEVVbDhrOWoyYkRBY0FnWElj?=
 =?utf-8?B?NDd1RkNTMlRJVFBOWldDd0NBbUhTeU9uQnZZbUNiN0ZmZEllaHBRL2E2MitW?=
 =?utf-8?B?REd0eDBBRUs4a1AzT0NLdG1Ob3lhOUJlOUdGckNNS3hUNW9FSlFOTGUwZXpp?=
 =?utf-8?B?cWdmVlVRTk9xRjA5b28vaGZXVjI1MTNJSjNFSHhJVUJoNFhCcEhKdUw2dUpQ?=
 =?utf-8?B?K3kzcE9BZ3B6NC9xRlB6M2tlL3lsb0pLaFBpNmNha1dwaFdBcENrSk9FQWdR?=
 =?utf-8?B?ckVoWWlVK05DV2RVRW9IYWJOQmhsRXN5ZnZtZkhQbFFzeWdJcUQ0VzRqZ05G?=
 =?utf-8?B?Ny9BWGU2cDBaVE9RWTFiRUJUdlZtaHQ0VitBT3dkVjY5QTRLTFBIM0tiWS9P?=
 =?utf-8?B?UURFeVBoaHZDaklqaGdQb1ZkdmJ3Mk1CWEVjczBXc0MvWXJQOEYzTS9MQ3Q2?=
 =?utf-8?B?QWtHT0R3Q3A4UzZzNlAvTkp1S1VkY2RKU0JDL2hrc0pkd01XZU1hMmt5VFZo?=
 =?utf-8?B?ZFJZY0hOT1BVTVFKbVduVW9iL01ubVRDUTlRcHMrMjJzRTRuVmRxcHF3Qmp2?=
 =?utf-8?B?cWtZRHJqb2xPNDJ0dFFQWVpObmdBblhpNmltYi9ZRGNYZyt5Q0dFanJ6UnNZ?=
 =?utf-8?B?R3NlVkkvSzl4YWhBVjY5YmdOSDBEOVRKU1cydDN6ZTNKNVJudjlTUEJldHEz?=
 =?utf-8?B?ZWsxekxic0pHZmhNMmJxMWhhV1BaQjlhYzEwTkNzM2FIWWlPVXcybXFISnNN?=
 =?utf-8?B?OFRXdjZQcWYraEFUck45RTZOMzIwaGM3NEE5NEd3WDNnbnZmbFlpSlBRMUt3?=
 =?utf-8?B?NjRYZHF3bFVJQUk0cVlMTERrSUlMWmNzMUdYQTZQTFRNclhUVE1GRVYvdEZG?=
 =?utf-8?B?aHkySm9ZQ1NKaVJXY2RpTlI1Ymx6bFhBY0g5YWdZSnlIS0FBNUFJL3dnUnJS?=
 =?utf-8?B?azhLNmNyR3M5ZmJ0RDBKUENpa0hrYXE0M2NSZWFURDFkUjBOWW4zbllQME5I?=
 =?utf-8?B?dVBhYjBvc0ZkNUpTYVRtVi9scEpzZTN4R01yaEJUU0JIVXlYZW4vLzRUZzJX?=
 =?utf-8?B?RGJvSkJ1ZVVFTUJEdXdxT3ozYXVmTG5aSVNDay9laUFxUWlNWVUxVDVjemkz?=
 =?utf-8?B?ek1DK2h4b29HZGpnVDZPWkt2Ym9VRE1SWU9LUDNpTFMrYTc0OUNncmJmY3Bz?=
 =?utf-8?B?VTREQVduU0NZci9nYm9ySEF4ajY5bDVWS0RBVjNJam1FM3NPbTlmR3A2UWpF?=
 =?utf-8?B?MWFWZktOYVZYdkp5RWcvU3V1QVYzRWxCOWxHVnVJd1NzMDM3eWV4MG1vK0pT?=
 =?utf-8?Q?udo5poXI3y7SUMswYCEk/cU/c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd43438-fc63-4792-2474-08dc9b570a5e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:55:32.1415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLoaau1vzNy6jmkXUHp2cyL1vu7+ZItSJPoNdxMo1ttkFJp2Oh1Cl9IO+c6leMQVRIFJbZqvrW26lK4LvUsB4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6653
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> We use this information in vtd_do_iommu_translate to populate the
> IOMMUTLBEntry and indicate the correct page mask. This prevents ATS
> devices from sending many useless translation requests when a megapage
> or gigapage iova is not mapped to a physical address.

you may move this patch prior to "[PATCH ats_vtd v5 22/22] intel_iommu: add 
support for ATS" or just merge to it since it's the "user" of this commit.

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c6474ae735..98996ededc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2096,9 +2096,9 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>                                uint32_t pasid)
>   {
>       dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
> -    uint32_t level = vtd_get_iova_level(s, ce, pasid);
>       uint32_t offset;
>       uint64_t flpte;
> +    *flpte_level = vtd_get_iova_level(s, ce, pasid);
>   
>       if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
>           error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
> @@ -2107,11 +2107,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>       }
>   
>       while (true) {
> -        offset = vtd_iova_level_offset(iova, level);
> +        offset = vtd_iova_level_offset(iova, *flpte_level);
>           flpte = vtd_get_pte(addr, offset);
>   
>           if (flpte == (uint64_t)-1) {
> -            if (level == vtd_get_iova_level(s, ce, pasid)) {
> +            if (*flpte_level == vtd_get_iova_level(s, ce, pasid)) {
>                   /* Invalid programming of context-entry */
>                   return -VTD_FR_CONTEXT_ENTRY_INV;
>               } else {
> @@ -2128,11 +2128,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>           if (is_write && !(flpte & VTD_FL_RW_MASK)) {
>               return -VTD_FR_WRITE;
>           }
> -        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
> +        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
>               error_report_once("%s: detected flpte reserved non-zero "
>                                 "iova=0x%" PRIx64 ", level=0x%" PRIx32
>                                 "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
> -                              __func__, iova, level, flpte, pasid);
> +                              __func__, iova, *flpte_level, flpte, pasid);
>               return -VTD_FR_PAGING_ENTRY_RSVD;
>           }
>   
> @@ -2140,19 +2140,18 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>               return -VTD_FR_FS_BIT_UPDATE_FAILED;
>           }
>   
> -        if (vtd_is_last_pte(flpte, level)) {
> +        if (vtd_is_last_pte(flpte, *flpte_level)) {
>               if (is_write &&
>                   (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_D) !=
>                                                                       MEMTX_OK)) {
>                       return -VTD_FR_FS_BIT_UPDATE_FAILED;
>               }
>               *flptep = flpte;
> -            *flpte_level = level;
>               return 0;
>           }
>   
>           addr = vtd_get_pte_addr(flpte, aw_bits);
> -        level--;
> +        (*flpte_level)--;
>       }
>   }
>   

-- 
Regards,
Yi Liu

