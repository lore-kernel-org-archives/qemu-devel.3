Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21D8CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hza-0004or-P9; Mon, 13 Oct 2025 08:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8HzY-0004hC-P3
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:49:32 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8HzP-00009F-CB
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760359764; x=1791895764;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Zxb04w7iwUxzV4uLvVWeen0uXZK7PMnUjYnqRlzxFv0=;
 b=ZKyUWm5y+lhmv7y1e1ozxp4kz5PU6OL8w3lcbwfUCO8Ni0D7Qp97YB3j
 z6zWspxbX2EN9Fg17jV78IM780PNnxaxEhM++l5corhmJ+NymVvvjvpJS
 CJOHHcIIgsOGnlC6Zhr1OCQ69rJ8KRdwqe+CIUptne4s/6ciJCTpocbAI
 7EqlrHtyTUfp5L7pMrmXobTXr2qi7ZBlpBHN1+plIWuHqB+s82h51cTYX
 zmOU93r/q2vWOWnaC/qBMkWpHKQzT2TJrOMpIYh++j0XZ/VDUkTdKdNYn
 8pfC1fqh7Njk3OYc404DocGYVnYQaZtGDh725L2wxELmDyKMD1Mo/ZkmE Q==;
X-CSE-ConnectionGUID: DLaX0QfeTreT2S0H52m5jA==
X-CSE-MsgGUID: myud798XSnSlttsAvJ7WKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="65117534"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="65117534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:49:19 -0700
X-CSE-ConnectionGUID: W9hOOHxTRx6RtyzeJY0r0Q==
X-CSE-MsgGUID: Uk+Pp/+TSXGb4MuleYKGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="181266163"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:49:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:49:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 05:49:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:49:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB55JCIx7b7UeHrV3pgtkyrkGffbuZkeEVtDhJqMl89WpL1hkDcLdy+yh2orU7JrZ9n23jKLhDOT2uz+cmJ8t2SWDWsBk7TIN1bpNb8lvGIXfiJ+i7krgW5KttLCk5a9JK4kRdcOx0frLy/ZSPE4LCkc4nM5LTgajvSd6RPjI1VmhGV5ZDx26ONtaXv4NnxpthQHgBB1gJ1Unth4YVELqYV//5QilV7I+XqDFjJ3sE6ZiI3EZbzrTz9ToIKHbtDJiyFQZHqA/vixpoFRzMg+tMkvEdM0TqQ5PVVaVOXj2ypLAZvcKDBDU5OjKxRxpwmhTgvN08CiUOBJZXqoPIGWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDixDfPqsY3sjzM5d+K/SQeIXp4jYowajJesELfQ6VI=;
 b=cX+4/oc2w4Z4OW/1ZkYiK8io10y9ZXtckub55bb2fpP/4D2DDw1VeyIAjcb1aAvVM/GMeR7pEL8bBw+hKO/+Il5ghJdjWGwN6K/DHgv3ZwLxJXo5PdTN39iyedMPkDs+OXP1g4oyKQS5G+uGd9xyMSBx4R2ewd9D2seObQJc+I0sda1MSQFNqKbr3WP7hajn74T5TS/Bb/SqxYvDCuByzuprXDmHYs/5rto5LhUySLn4ORiLxCQTX03GeNDqqHj1QckVDXjzthN5CsGCftvIGsWPTOCKLPvaW6w50um/jLHyIQDx1cGZJ16Cfbg7kJPLnwP07+y0BNHsaCfY9aojJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 12:49:16 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:49:16 +0000
Message-ID: <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
Date: Mon, 13 Oct 2025 20:56:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
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
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR03CA0027.apcprd03.prod.outlook.com
 (2603:1096:d10:24::9) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: a078ba7b-2074-448e-4e0a-08de0a56eb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXhvcEsyeG9zRVY4aElocGNFQnVBYWh5eXZ0NW9lRzZvTjh4MHRpY1h4ejRM?=
 =?utf-8?B?R1A2elU2dkpRamRpN2FnUlRnZXorWXVNZE9YcjByNEpyMWl4Z3BXblFLaXRv?=
 =?utf-8?B?YUF2amFnZzFYd1dzMU03QnEyN3FQNEdtNFJvODk0TTFiTThqMlNSWndzLzdr?=
 =?utf-8?B?N2Voci9qb0ZDc29jWXBLb2Y5ZTNMcmRaazRZNHo3eEp3akNqbE1YU2dCNFRw?=
 =?utf-8?B?ak1VcEl1ZnpzQlJVQ3FNWTFtYXBjSndUMzdGRTE0M2VJRlBOTE8rcm1FcnZk?=
 =?utf-8?B?bEwvTUtqcUdiVk16emVjS0hBQmxDYzJ6dEs3S2l6ZUNiQ1duR2NOdnJvbGo4?=
 =?utf-8?B?WFVHU1IrNTg2S3c3b1hYM3Q2b0U1ZXlPSC8yMVdYT0lSYWtmN0E4YzBvODA1?=
 =?utf-8?B?NTRnWVFlK1c5RGdlYmllMWRyaEZyY3JjV0dkOWtlb0l3d0ZDRUpGRmtvTUFO?=
 =?utf-8?B?UTZBV1YrVlBreEp0ajFZaWcrUURLcVRxSENORURqZFlzMGdHZmZUd0l3N1Ry?=
 =?utf-8?B?ZG9wcktQbWJwcElIV0kwR1dFT2dmZkYxSWdIcS9FZlNoWVhLMGhjOEdDd2FX?=
 =?utf-8?B?b3ZqTGl1cnZkMmo2Z0xYNGZjendYWkF6Z3FuQzA2ZyswTGswb2YwSnZ6VGNN?=
 =?utf-8?B?T3IrMmFWeXBJRXlrdVZjbVlua3FGUVQ4cnhKa1QvNHNSRkZ4VGw4UC9abktR?=
 =?utf-8?B?eTFiYmpsTkhqd1JJU1NvV2pMZFU5d2l1dkNKb2RranJjeW1jb0VqTGtwL1JE?=
 =?utf-8?B?L0ZvSHZnTnE5cEtnY0tFMHE2cnpHalFFaHpUR0s2VEMyanJBeGF4aXlhamdT?=
 =?utf-8?B?VXphZmlJeHVxMzdNRElDZkNPQXgyVmE4VXFtMWxDdERpU1N1QUI5M21IWmtL?=
 =?utf-8?B?SU5hZHBiTENLQ0Y5dDExK2REa3lkK3YyRFFZZmlJT3NZeU9hWjNvdERKQklr?=
 =?utf-8?B?TkxGckN3M1hlMjZmUHpOaHpzaExDaXpTVDdlZytMOHdDL3dEcjFYdmVvYVlq?=
 =?utf-8?B?eTN0TWpLemh3bkFkejlXbEtNQlhHRndscittclhkdXgvSFFHUksybUlCbCtQ?=
 =?utf-8?B?MFhERy9hVzlNc0QrUWk2STJRRjFCM1c3ZHptYlFJK2JNajdBaUhqU0VmUUN3?=
 =?utf-8?B?Zi9XWm1ROEZBL2hDOFpub1E5dUNKZHpHcFFtaC9aVS9HaS9kcWEvcVVQVTd0?=
 =?utf-8?B?R2JXT0N6MVB4aGJOTzlFUzdwYVZPOUZQcEhqM01MaDdxMWJRdXJ5ajVBWkYy?=
 =?utf-8?B?WFRrb2ZrbUJVRXQ3ZjluRVVmRUlsaEQ0MW55WlRaVk02UlU0QTA4N2xaK3cx?=
 =?utf-8?B?OWZ2cFZCYjBrVlhYcWhIMWFsR0s0M3liV3llUzlKcFJUeWJrM3czblFtQ1NQ?=
 =?utf-8?B?ZnFpR3k5VXM3REpLelZ0VWV0L0paeDRIU3ozNVFVSE9xdjhuYVovTzI0c0JB?=
 =?utf-8?B?WURzdC82dzlJQ0QrMnQ5Y2lraUJYOVNyLzdVVHdUYXpqSzhac21XRXpmczhH?=
 =?utf-8?B?dkhZU1RLd09NMS9YRS9ieTZiZ0VmNjVrbDJaWDhGdFVZZEE2RmVTNmFwOFV6?=
 =?utf-8?B?aWM3VS9sZFBmMzNmYStlc01ubkdHOTNoNmZxak9GWFlQeE9ndm5QQ2dFUXR2?=
 =?utf-8?B?NXJWajZoZzVRblpkSlhLbWdtTVpud2ZzZnp3b2lKMHg2U2syNnpMTVE0ams1?=
 =?utf-8?B?bmV3Qjc5ZS9iVm11MzBPK0xoM0RPVGVkenIvT0JjSndPSEtUYlNhTG1sUTR3?=
 =?utf-8?B?V1V3bjlRRmVjM1ZPdnZCYUdIWjRZNmlISTQrZ3VJNm5QQXVZTzQ1ZExsOGdk?=
 =?utf-8?B?bFMzQ0p4SEF4ZGdHM25MQjJCR2ptemFwcDI3aktXTXJyUVBzMWlZbU5jeHhE?=
 =?utf-8?B?RzIxaVk5S2NkbnZuMmNZVGZ5U2pVL3VKM3NJbDFlMi9UODdFQVFvc2wyUGt3?=
 =?utf-8?Q?mvjJ/56uxyUDUUy/HvFhGS/cBETDoPNO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG8wUmkwd01TSExCUTBRNS9GbWV2WGR1WU8wamp6RDB4emVqdFRUdXhZYTJX?=
 =?utf-8?B?NFc2L1h0UDMzNnViODhQNTh2ZDVxNyticzBrdkVzOWZUbFdOdlduVjZLY1Z4?=
 =?utf-8?B?cnYySDRwUGJUWFVwZWRUUmpHcFZUOGM0aHVTM2cvL2JMSnVGS2dTeXhvQzVI?=
 =?utf-8?B?dVFjRTMxajhNbkVWd1piNzByVGtxQUVrMXhqa3VFVm5IZFJCQWpPdzRSYTlr?=
 =?utf-8?B?SS9TMnFzZkZKK1FLZlRWWVU5d2VFUEFycVBrc3cwQUdEZUpncXRxNUFOR3dF?=
 =?utf-8?B?RkEzajk4RjA5TjhnZ3RJUW44Njg4M0VFM25TTzRRbWVVb2FiTkc0eGxGQTA5?=
 =?utf-8?B?UG8rdmIxMXB5cVdpdGxUSDltSlh6TDk3YVpldHZhYmRjd1VXb2UxTVdsajNZ?=
 =?utf-8?B?aHZZTGdJZnBITnY1T3JJZkljS3VHQk1rcGk3eXNveFRSODBQdTVINitTVlYy?=
 =?utf-8?B?RHNybWM5N2o2VjduZjdaRVRLTzVRenYvdjNWTlRnZlJUTG13ZzBlaDZic1NH?=
 =?utf-8?B?QndOL1JNaFMrVTFOWnlwNzl4c2E2akpudk9YNXpiYm5aOUh1VHNhWFFjckRS?=
 =?utf-8?B?bFZGeFd0dnRycDRIVldYQ2pFN2s2OEk4MmV2YmozSHBBZ2ZBcE1XM2JLRlZ2?=
 =?utf-8?B?UW0ySVpVR0wvdXJpM3ZrWW5iWlMxSUhWbTV5cjRwL2ExZ3lMSWFDRnlxVjRE?=
 =?utf-8?B?aXJEaCtzMUhDSmJJNHhKNVZMV1crTng5bXBvdTQ0Qnk3S2J2bStTcTNwYURZ?=
 =?utf-8?B?eURhOXM2Ync4VjdvTk1XRGhIanhkcWtaRmRCcWpOdjkydGJablc1SG9IY29z?=
 =?utf-8?B?MExrbXhSZ0dpK3N5b2w1RWVFWi93OW1FZkYwQytwRUc1eFZML0FsYVN1bk9a?=
 =?utf-8?B?UjR6V093L2ZtS3pQYmJ3eDFzdXVuU1hmakR0NThKMFZERllYdm9YOGhqTzRK?=
 =?utf-8?B?dWtZRER6NEJiSlhpRmRjRHlyY3oyS3hHUVVHbnlOT1E5MVlaZCtKTUNtemNa?=
 =?utf-8?B?Z0EwRTlWNHU3MHducWJWc1UwSno1aU5lZERiWUxSbXMwSnFjNUlaaDVQV2ZQ?=
 =?utf-8?B?eHVxVnRsclg5c3Vwbk1XMUtreS84WTVGWnUweWc5NEUvNStjUVAzR1dSTXRI?=
 =?utf-8?B?UUFFdG9FUjVjcFVvV0lpd1l1aFMyTHhvMDhRcEhJUjlENkdyS1Z3LzNENnR0?=
 =?utf-8?B?ZmFxMWtPdjVjQ0Q1QXZ5QTlmVGhhMEo3ZG5jeUkwM1EzVnIzc2x1UUEvUEFy?=
 =?utf-8?B?MzY4dVVyOGtyUlUyYWhjazRuNUd3cFRBb3NMY0x4b2pxYWlJUXc1eU9JNmtx?=
 =?utf-8?B?WmhSdFpGUGZ3WjJEbHJDUmg0U1JjZHFyR0ZPc0ZYc0g4WEpLdkxpU2FLVWNK?=
 =?utf-8?B?cjQyb3BmSTJ5N3MzWUhiaXg0TVZyWnBFUzRHeGxsVGlaSWd1NDQxY2MxeUJz?=
 =?utf-8?B?dlBvbXhtUzk3ZFZJc1h6dU55SkhhOWVGMnRLQWltNTk3cmp3TEdHR2o1RWM4?=
 =?utf-8?B?STl1cHoxdTNyNFV0M3Bsc3dxWmRNMzdRMHYvVnBzT0F1NFhyNmdiYU14aDhW?=
 =?utf-8?B?VlNnK2FYZWNWU0E4NTlxV1VBNHAyMklkU3hPTzFoYzFGU2R6b2xpRjVEbjRN?=
 =?utf-8?B?NEtBaTdtM1ZSREorOWFBblNKOThrd2JzQXYrek9XZ3U5SzFkVVJDVmZ6Ymhn?=
 =?utf-8?B?RkpvVE1aMHU2bnhuZ3p3b0hLTmMrTDVOUGh3bm5waEdCRk5VSHF4OWs0ei9Z?=
 =?utf-8?B?UDdqQTZ3NlhBc3VVWVMxVkhlbEtMWUpPdmh5Z09XR2ZvNkhPN1ZQQ0ozUnV5?=
 =?utf-8?B?cUJYblJ3VzVwdmRGMzhpcU9qNC92M1NwTWV1TFArOVdleEIyYTNIT2RBM0Mz?=
 =?utf-8?B?NFBTRGhtMUJxcnQzWlU3OWdwdHYyV1lydE1WQXQ4SlVISzV5aFhhNUdDSjd1?=
 =?utf-8?B?bEpWaGIrRFljTkUvc2RmOFdUVndwbktBd3ozcjVUa05NT0xpZUdmbXNaRWlr?=
 =?utf-8?B?cU5uS1ZwV2VpWmtkM1gwUXdmeWFYWFpsclpYeTNaYnNYaWk2QXRBenRncldq?=
 =?utf-8?B?ZG5veElmUVdwN3lxREhVZkhGcWlxS2Zxc3B4aTN0ZFIwTTlkd0hVSEVtVHVp?=
 =?utf-8?Q?KVpyLyb5nRO8kPMQq0aGCM/t3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a078ba7b-2074-448e-4e0a-08de0a56eb26
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:49:16.4651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbVnd56ouzoPvIsMdk5PyjgjQ7GB3XrDLo4swXgFm+36dyuZWt1X3N0H7v/NJYR4VrwuSez6sS7ixdvwwetrnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/13 10:50, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during
>> migration
>>
>> On 2025/9/10 10:37, Zhenzhong Duan wrote:
>>> If a VFIO device in guest switches from IOMMU domain to block domain,
>>> vtd_address_space_unmap() is called to unmap whole address space.
>>>
>>> If that happens during migration, migration fails with legacy VFIO
>>> backend as below:
>>>
>>> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90,
>> 0x100000000000, 0x100000000000) = -7 (Argument list too long))
>>
>> this should be a giant and busy VM. right? Is a fix tag needed by the way?
> 
> VM size is unrelated, it's not a bug, just current code doesn't work well with migration.
> 
> When device switches from IOMMU domain to block domain, the whole iommu
> memory region is disabled, this trigger the unmap on the whole iommu memory
> region,

I got this part.

> no matter how many or how large the mappings are in the iommu MR.

hmmm. A more explicit question: does this error happen with 4G VM memory
as well?

>>
>>>
>>> Because legacy VFIO limits maximum bitmap size to 256MB which maps to
>> 8TB on
>>> 4K page system, when 16TB sized UNMAP notification is sent,
>> unmap_bitmap
>>> ioctl fails.
>>>
>>> There is no such limitation with iommufd backend, but it's still not optimal
>>> to allocate large bitmap.
>>>
>>> Optimize it by iterating over DMAMap list to unmap each range with active
>>> mapping when migration is active. If migration is not active, unmapping the
>>> whole address space in one go is optimal.
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>> ---
>>>    hw/i386/intel_iommu.c | 42
>> ++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 83c5e44413..6876dae727 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -37,6 +37,7 @@
>>>    #include "system/system.h"
>>>    #include "hw/i386/apic_internal.h"
>>>    #include "kvm/kvm_i386.h"
>>> +#include "migration/misc.h"
>>>    #include "migration/vmstate.h"
>>>    #include "trace.h"
>>>
>>> @@ -4423,6 +4424,42 @@ static void
>> vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>>>        vtd_iommu_unlock(s);
>>>    }
>>>
>>> +/*
>>> + * Unmapping a large range in one go is not optimal during migration
>> because
>>> + * a large dirty bitmap needs to be allocated while there may be only small
>>> + * mappings, iterate over DMAMap list to unmap each range with active
>> mapping.
>>> + */
>>> +static void vtd_address_space_unmap_in_migration(VTDAddressSpace
>> *as,
>>> +
>> IOMMUNotifier *n)
>>> +{
>>> +    const DMAMap *map;
>>> +    const DMAMap target = {
>>> +        .iova = n->start,
>>> +        .size = n->end,
>>> +    };
>>> +    IOVATree *tree = as->iova_tree;
>>> +
>>> +    /*
>>> +     * DMAMap is created during IOMMU page table sync, it's either 4KB
>> or huge
>>> +     * page size and always a power of 2 in size. So the range of
>> DMAMap could
>>> +     * be used for UNMAP notification directly.
>>> +     */
>>> +    while ((map = iova_tree_find(tree, &target))) {
>>
>> how about an empty iova_tree? If guest has not mapped anything for the
>> device, the tree is empty. And it is fine to not unmap anyting. While,
>> if the device is attached to an identify domain, the iova_tree is empty
>> as well. Are we sure that we need not to unmap anything here? It looks
>> the answer is yes. But I'm suspecting the unmap failure will happen in
>> the vfio side? If yes, need to consider a complete fix. :)
> 
> Not get what failure will happen, could you elaborate?
> In case of identity domain, IOMMU memory region is disabled, no iommu
> notifier will ever be triggered. vfio_listener monitors memory address space,
> if any memory region is disabled, vfio_listener will catch it and do dirty tracking.

My question comes from the reason why DMA unmap fails. It is due to
a big range is given to kernel while kernel does not support. So if
VFIO gives a big range as well, it should fail as well. And this is
possible when guest (a VM with large size memory) switches from identify
domain to a paging domain. In this case, vfio_listener will unmap all
the system MRs. And it can be a big range if VM size is big enough.

>>
>>> +        IOMMUTLBEvent event;
>>> +
>>> +        event.type = IOMMU_NOTIFIER_UNMAP;
>>> +        event.entry.iova = map->iova;
>>> +        event.entry.addr_mask = map->size;
>>> +        event.entry.target_as = &address_space_memory;
>>> +        event.entry.perm = IOMMU_NONE;
>>> +        /* This field is meaningless for unmap */
>>> +        event.entry.translated_addr = 0;
>>> +        memory_region_notify_iommu_one(n, &event);
>>> +
>>> +        iova_tree_remove(tree, *map);
>>> +    }
>>> +}
>>> +
>>>    /* Unmap the whole range in the notifier's scope. */
>>>    static void vtd_address_space_unmap(VTDAddressSpace *as,
>> IOMMUNotifier *n)
>>>    {
>>> @@ -4432,6 +4469,11 @@ static void
>> vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>>>        IntelIOMMUState *s = as->iommu_state;
>>>        DMAMap map;
>>>
>>> +    if (migration_is_running()) {
>>
>> If the range is not big enough, it is still better to unmap in one-go.
>> right? If so, might add a check on the range here to go to the iova_tee
>> iteration conditionally.
> 
> We don't want to ditry track IOVA holes between IOVA ranges because it's time consuming and useless work. The hole may be large depending on guest behavior.
> Meanwhile the time iterating on iova_tree is trivial. So we prefer tracking the exact iova ranges that may be dirty actually.

I see. So this is the optimization. And it also WA the above DMA
unmap issue as well. right? If so, you may want to call out in the
commit message.

Regards,
Yi Liu

