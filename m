Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59032CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApAc-0001uq-Fs; Mon, 20 Oct 2025 08:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vApAY-0001qa-OX
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:39:23 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vApAU-0000nU-Gi
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963959; x=1792499959;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rzi1gDnx6YcBML0fhHuPsG9e8Bnlj/buFXOjy9TngLE=;
 b=Kghxw16MjDTMU2beBsAXLSB3/vqFsBA7jif6cZAcCDgNxC3Cu3EuuJIJ
 BFIAM17RGUE1W2nYFbG26wnBO7US+n4kz55l/HDBZsIGteEejxmdE6Ggp
 38kEV/ZhtxeGcrsS51XSLen9hIcm0ML3p72Qnqp9H8GsUKUOoV+e9dq3c
 EQeppCvna+5MEGxLQ2svgsTJW9cel/acgr0x3nBuoR9vhmdcewVcLkr8U
 OB02ollnkOF7g7uwcWXtJHS4zyXguY9S77272n3rP7C3L/QR0FbTDx/gB
 Rz9QltB/Nyp+rhsfu5JPBh3wZoSoi95CSARWsidRYLsFhFNWbucgzD+1H g==;
X-CSE-ConnectionGUID: NPbwHlv/SdSyt4lKRu6rZA==
X-CSE-MsgGUID: bECqjZ2KTCq340HYXQxs+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62995930"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62995930"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:39:05 -0700
X-CSE-ConnectionGUID: XvQuPZzfRn2VNC9CohyV/g==
X-CSE-MsgGUID: O0i/2ueKSE6l40wMT2j0BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="214281543"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:39:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:39:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:39:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:39:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkYXv6RiKAO1SCjhP5qqFv2GKtBMYR6iYnKWCwM+oQhtWBb6SR2l7pzvwMsKPolSNeSacAybfFH+atsig4vDrA1Q6J3ww3+z2zer8mZ9SgW/jfbiPLx2vbzRaBvpaMEp1ObATwQlTwHlua0Hgzyj0NyNbdE8LvU/PEoyHlia61sP3uPHYwz2HMrZ7rg53TbXYdVR+aBNaU5e6Eo5NRm489ghbxbeOZKEdcN6EqNY5xvHcDrHj+Ry3ylS2PYPrNXKhAwbIPqkGT9/qVbpinFsBzPFTeoRdcRsPVvH0gL5pk9aA4wpAphiri2Pxq1CbhcY3jHv4IGN1w4XENfN8LG9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3lNnOkkTY+YSyw2FUH1NevZgbsqwS4WSOVMHJPZE3g=;
 b=mNfQIlUoVf2w+BzlglhXMcFXRnrqAQ2om1R8gSLhKqWmOvRdmbRGZFSRdPrxWx0+Zq9sNfyu4mM4q/ZLA0AQrmXfyh9ffuv8xu0vhxURMKErpry21Q4E5RItVt6E+waVUFSpzgKuh/X18tbb/Q5Uc04hCFu24Up3MnCVMyGZ4cgTYugkAf810eLPdkIXDWZrGlp0CsW5jkyl2QaPnbfAbiHAl6q1CYsWw24B+ArqJUfv4UU2PgkeJaD8a82XoB+wEX5tm4fUtLOAVuICHh/xtXYbojeH1SgghyJGcA0Fc5P48K30JDC/JTMHdso4xHl0Cf0zZHUeewMDBFE89XOJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ5PPFB8C3A0B7C.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::84c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:39:01 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:39:01 +0000
Message-ID: <2492ac2f-3eb3-481b-9d35-f1597b82457f@intel.com>
Date: Mon, 20 Oct 2025 20:45:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] vfio/container-legacy: rename
 vfio_dma_unmap_bitmap() to vfio_legacy_dma_unmap_get_dirty_bitmap()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-4-zhenzhong.duan@intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0034.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::10) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ5PPFB8C3A0B7C:EE_
X-MS-Office365-Filtering-Correlation-Id: 52db01be-4cf7-4ba6-8262-08de0fd5a54a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0tLTnQrQWtUMGI1OGhTZUd6dWJjb05oNFljcUtscEptZXp6d3V1L0NqUy9M?=
 =?utf-8?B?THI0OVFMOEorbVIvSlc0a2V6THNiQ0FrczhaUEpzc3NGNHBvZTFxUWlxYUtS?=
 =?utf-8?B?TDV3dkw0STBHM2loR3JCOUFtbTlrV3E5Uk8zT213YVdFYzJSNVk3dzJoZktt?=
 =?utf-8?B?SGJyd3N0VjVMa0Rua01YeDZ0eThkZ1I1bGNQUGxSYlpXOGMwNm5IVzhwc2FZ?=
 =?utf-8?B?ZXJsRTl0YW9hbUdORDFvbXlreHlJcTJNWTI2MDNjL2V2aXA2Z3RyVXRoQTdp?=
 =?utf-8?B?bng4bnBCUlNjTmJsaUVENVBsa0FyU3k0K3hsV0tSUytrS3pvTXlxY3IybmVl?=
 =?utf-8?B?K2pwU3FXZnJPR0RWSjRIaG9adVlRbldOMGk0cmdMTFVKQUNQS0pacVJnNm5h?=
 =?utf-8?B?cHhvSENxSFJOV1Rzb0REM3NZZSt6YktoUVptMmFya1NnSFdBQnp6MlcvZDE4?=
 =?utf-8?B?aXZ1ak4yNXhwVG9MQjQxZmJHQWEwWVEwbkFBYWVsQkgrZXUySnc3U3FTVEhF?=
 =?utf-8?B?WCs4bHBiQVZYZkxoK1pIL1RJcHdHcHovNU53YUhzL2NrMGN5b0Y3M1JseGU5?=
 =?utf-8?B?MmtiY0tHa1FrZll5M3BkS2daV2ZRM0E1dWpMVUd6WGlaY1YyRDhuNEQ2K29G?=
 =?utf-8?B?SFZyVUJPRFJIRVM3T2dyaTdFR1JqY2xyRnpwWFZvemp6MndjQlhYS3R5aGMw?=
 =?utf-8?B?WUVXRUxZZW5xMGVCTjAvbHNYRWF4L29GZGRlNXV1YTdvcHpBQlRQdzJFbFY3?=
 =?utf-8?B?RUJuUC9uWHVXU0tSby9KMXNIKzFqSmttbllPZWRLU1VBcE5GK0dNdXRld1lS?=
 =?utf-8?B?NGF6TlhaakRHZEh3RzRvRVBsYUIvdFBneHVUc0lPTUhWU3RFSzN2d3hHUmNq?=
 =?utf-8?B?NjZ2M1FBV0xVRy9KVWN3M2ZiL1poR0RLOFpVaVhlMHc5TlpONXk5OWRXeTZs?=
 =?utf-8?B?Myt4VFNtNFJIYkNpOHBmRGtNQWVZaEx3QnhpcHRUTm5ibkN2aFdxaDdXNnJw?=
 =?utf-8?B?TlV2Yk1TTk1ubGpWMkNNK2lWa1pXYUlRTnZPcUNuRE1MUTYxRG50RFVTREU0?=
 =?utf-8?B?aCtQbVFpRXNVNE1rRFlVQ0o5eUFraktCSWhmcllkdGJaYXVyZFM5YWtpOVlO?=
 =?utf-8?B?WkgrcnlwaC8zM0MySThxRGpEY0xTT1U2Z1N5QmVXKzJMK1ZSd0xoTEUvZ0Fq?=
 =?utf-8?B?WDUxNkcrcmQ4Zjh5YXlza1A2YnNhOEcwS0xMZVB2OFVEU1BqWlhQZ2JWaVlZ?=
 =?utf-8?B?V3RiQ0c2OXFUMzVqTjNmT09wZjVhUFdJeUg1NGFiWDh6SG11aE1CWUgwY3g2?=
 =?utf-8?B?UFNOLzBCZ0pRbklJanZSS3dVZ3NvZy9GT1RmSit1TUJpd0lNSHZSN2U0elVo?=
 =?utf-8?B?NUkzQTY1ekxJNG9LNXNXZnd1WUJ2Q2pkc3Jqc2Nlb1Y3MG8waVVyS0ZOL215?=
 =?utf-8?B?T0QyNldudllGUlUvbUZhWm41cUlFSTJzaVVVaUVQaDdXRHB6ZWFnQWlsMkc4?=
 =?utf-8?B?d1JaQkFNY0Iybjg5OXF6cDYvL08yWjhTU1c3UGk5UEYwNkJiOUR6cVlZMHE0?=
 =?utf-8?B?dXdwRkRHSVdJZitDWE1XeVpxbmFmOEhCaThEclU3KzBlTTlTNm5xRzg2UThV?=
 =?utf-8?B?NnBUN2tWVlgvVCtlaElxQWdsZTk0ZTAveWhCUWgyYkx2M0lrNkEvRjViTWxD?=
 =?utf-8?B?TDg0d0hkaWUydWRELy9uZXJyRUd2RG1HL0V5RUVkajd1T0ZqU1g4NjljcUJS?=
 =?utf-8?B?MmFhUC9USU1LV0VzZTFrMHROVjB6NVFLbDdXNG5KS1g3amtoRUk1OENLTEpr?=
 =?utf-8?B?Sjd6eWdoRkNuTWZvRkZiV25ZelE5RmRjdGZ6MjFaYlBSRXVVR1hIK0t1L2ta?=
 =?utf-8?B?VHdaSTVzNTRNUmRGUGo1Y1pxaEtlNkoyVXFNMGp1ejBySDhTbm9uOW8rRzlW?=
 =?utf-8?Q?4UXhvZ670kJ0Xk9yh+ukcn5IK60LuoQ9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWFZanNENERjQVlhZ2ZvNm4yVE9rTXZwaVRVZ2VVWkJIYk1CQlMvYTdseEIv?=
 =?utf-8?B?ZXRzUjVEeng1eGdvY0NHbFFZaTNUOCtiUzB2OE1HY2N6cDk2eFpJVE9tcmdL?=
 =?utf-8?B?RUQ0b25QU085S29iK2ZVNFhaR0pabXdmVUxab2hRZDFLZlZhNGJHai9WSEZr?=
 =?utf-8?B?SzRyUCtUalVqMWdpcHBvMW5ScUUrWmFqblNkTzQ5QUZuczVtbE9la3dxcHRM?=
 =?utf-8?B?cU9NZHYwTmU3VHQ4WkU0bkp5eC9GYlFWNGh2Y2wwL3BqZWk5ZGc1KzlOdFJ6?=
 =?utf-8?B?UFMxSWJwZGVJbWx0eVhxUExBZkl3T256UkovUDBjUUdCN05sSU84bktwU3RZ?=
 =?utf-8?B?WU1GN3UwVkp2dm5SVlJDMUJwc1JjWVdwenM1MVE2TmV1K2dZZUc2S2Jyaytj?=
 =?utf-8?B?Z1FYWDI3NFhqUlF1QlFWZGhxS3pNeHpBeWV4a2VDMUR2VjV6WDRZSUhuRUt2?=
 =?utf-8?B?UisrcDJjc3ZWRDhaRnJXRHU3Slg1ZCszdUkzTGxUTVM5VmNxRWJVZGs3bnph?=
 =?utf-8?B?Vjk5MmRsb281cTVxQkZrMExjTjRBQlFPMFpXbytGSklSMDY5WUxjTk9lOEc0?=
 =?utf-8?B?Vm56TnNjQ0V0eXZUcDd1akhRNDV2UjJSTDVYbFUxY3g4WnJmeUh0UjB3NU9q?=
 =?utf-8?B?eXU3MGRiMDNrVFFwdVdkYkE4SnhRWDFjdlloMkhNM0VEQ2krb2Focm1sNXhN?=
 =?utf-8?B?ZkJGa1l5dmhxZGtQeXJDckxZSUcwczV4YUFyKzBOZlRSQ0JQRE5saldoRUxo?=
 =?utf-8?B?NzdYMEJTdUN4NVgzTm5XK1dFQU5rRzVDZGFGa2FVbVpvQW1xT0t4UENwaDBF?=
 =?utf-8?B?Z2lsbVZCNXZhL2JTSGNCeWJIS2dxVzB0SnA3QWJud0FuOGNWR0I5b2k2SlRS?=
 =?utf-8?B?YWs5dnZKSEJ6ZWY1M2E2YWNGN1hOdityRFgwTkMvRGlJUFIwUW1FcFhQT0wv?=
 =?utf-8?B?YU9ZRlZ2a1pBbjBub2VrbXFtUFFEdy9XVXA0eCtoTFUwbTRnQzcvNzk0R0ls?=
 =?utf-8?B?N3lLTlBRWmdYbHNVTVpIL3NJT1ZWVU1GSTJDUjZDUU4za3liS1RZbDhjamhE?=
 =?utf-8?B?blNIOXVzV1FERHROVEhLWTIzN2xRcmRkOGl0SXAwSWc2bVdWSHZrM2hhVUxp?=
 =?utf-8?B?bjRIYVNBajl6WlFnbytndGhEcHdrc2pZbmllempzRnNqeU56bXhZeDlWMXhr?=
 =?utf-8?B?ZjdXK2FnNTI1aHJ2M3JqVFRYN0lPMnBvSXFDcklQU1psalRiOE1HM1hXM0FJ?=
 =?utf-8?B?WUxDVUhTL2x3L0JKb1BFS0g0U1lIbEJrSGdmWkVZK2dzQWRlTjQvODdxb1Fu?=
 =?utf-8?B?U3lZQjBYV285SXdMWFc2TkpEc2poUWdDL2RRdnhqdDNubEpPbkwrYmlvcEUv?=
 =?utf-8?B?OWFoNkNEUGFmL2ZIcVo0bThSVTNaVVNDeUMwSU9mL3E0NkRNbHM2MHpkOGJu?=
 =?utf-8?B?QjV6bjRybHBFUHVER0pzaXNoS0plQXZzdHZnS2xTbCsydmFaN3hiNmJFbnpR?=
 =?utf-8?B?V3dydHR1eGlNSldHZ2puUjhsUWo4NFFqdTE5UFZ6dmpsYmtKN05oT08wVlhN?=
 =?utf-8?B?VG9XNGdaRTNJdTd1NVNBMGdwekxoaTdiaGk5QmdaUXJCUnN6TElhTFMvTTBD?=
 =?utf-8?B?RW55L2xOZkZQNy9JNkVxMnRVU09NQ0hyMWlzVDA5emNZdnZnMnMvYnd5Yzl2?=
 =?utf-8?B?aVNrZloxYUZPMW0yZkhjYThzbE5FNlI4WEZ6YXJPU1F3WjQycWZXcGpuS0Yy?=
 =?utf-8?B?OWJmaFlEQ2VjYURPeG8xYjZaQmkzNVNvZ3psZmtRUGNVb2R2WEw0bld6YnJJ?=
 =?utf-8?B?YXdUU1EyVW1RWnR2dzE5L2lCU09QcTVYTld6bWNITkxTSFY1cDF6QzJzQ0tD?=
 =?utf-8?B?Tlh3WmpwTTRtb25uejVRTHF1bXR5bmhQMzNvQnQ2ZzBvY1dMZGxxVjBrNHp6?=
 =?utf-8?B?RTRNNlhZeGV3SHhDOURzNExFcDh3N3g5QkVFa0hiVGxiK2hGRFJ0eHgwYVpV?=
 =?utf-8?B?MnZvVWk0TnFjZ1dUNUxhZFdNMFhXM2wrMTl0OXV6Y01HVUdJUU9idXU4aldP?=
 =?utf-8?B?WlVaUyt3cmxTdndBLytoaXJ0N3AwaHJwYXlWMUhHL1ZSbkUxQkI5MmlpS3lS?=
 =?utf-8?Q?BjWKdDIOaJhaeXs/gqL2OfvD2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52db01be-4cf7-4ba6-8262-08de0fd5a54a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:39:01.1669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /z9WbMCUrNZGLMv4n2kYrofBoPWsEA9MeGoHnu+Bb3AQsL8NZR8DY92NE5YucNzfuZ8PW//+Cs7xr21Swvkang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB8C3A0B7C
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> This is to follow naming style in container-legacy.c to have low level functions
> with vfio_legacy_ prefix.
> 
> No functional changes.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container-legacy.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index 8e9639603e..b7e3b892b9 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -68,9 +68,10 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
>       }
>   }
>   
> -static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
> -                                 hwaddr iova, uint64_t size,
> -                                 IOMMUTLBEntry *iotlb)
> +static int
> +vfio_legacy_dma_unmap_get_dirty_bitmap(const VFIOLegacyContainer *container,
> +                                       hwaddr iova, uint64_t size,
> +                                       IOMMUTLBEntry *iotlb)
>   {
>       const VFIOContainer *bcontainer = VFIO_IOMMU(container);
>       struct vfio_iommu_type1_dma_unmap *unmap;
> @@ -141,7 +142,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>               bcontainer->dirty_pages_supported) {
> -            return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
> +            return vfio_legacy_dma_unmap_get_dirty_bitmap(container, iova, size,
> +                                                          iotlb);
>           }
>   
>           need_dirty_sync = true;

