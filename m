Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E7C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyP5-0008Df-Q9; Wed, 02 Jul 2025 10:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWyP3-0008DJ-N9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:25:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWyP0-0002da-VZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751466335; x=1783002335;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b76rsbUsmQpJJWsk3/k9c1/Y4yUelUkK88iFuzwrBq8=;
 b=atIaF04SouBNBx8cKviPUUI8cnQ3cX8vJrJkAZACto9ehBSqKaF56yMI
 e9v9Y5OpH2jqAeJEk1zaHiefsui3iOVnvgNS1Ep7Yt9qvKzuD0n528C6N
 ZrnVu7Od8QFuDnPGFOIrPevHfPcNtuY2frYFTr9m35aXJEcPBZzWHBhiC
 Qz5SnbPGnoPirh4cHCzh+hhvuhDIb7UYJum1fqvaCZjbYfd+73SePc33D
 bSAafok5bLadwmgSwZbiQMNSeXswIt10++Fi1imlR38X5990d93SknSfn
 fKh7L/GW08A0Xs7iYUDoPvVSNLQ/F7QaUxoXHWMCPTpDrpJO+T6omXJTA w==;
X-CSE-ConnectionGUID: +/9aSMYzTlmm9Qb7uklJBw==
X-CSE-MsgGUID: ZPxRi+LvTGCIlE8kaPeyGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64814067"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="64814067"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:24:27 -0700
X-CSE-ConnectionGUID: My87Fl45TfeXAjBxmaiZ6g==
X-CSE-MsgGUID: Y1w7f7lyS16bWAF4ZR6/qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="159782337"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:24:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:24:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 07:24:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXOVyHaK9xnpiP489GQv0m+Nfn3oo+OmFT7HG1HQGfCWdbxRpBNgbKr1UF5ZMcSWu0PkvHrW6RjbM1PvoedzrL5Z9DxJRL3t09hH44lfbM22j+nwdV8kMfbz+ydAsRMSah9JPHu3Sm7anTXOXF3G0SpBrLEqu7C66v8H4Cagf0JywtQ3TmKaaM6mXSFFOfMMiMkcv9iisw8NrVgAB6o2YPVDcVhRpS5xa5TEUop+FfMa+1ulV5OVEHlbkYVAK/bVa3xM3JO+p1jqSru9GPnP8cNRZkxDKPSJjXFtVtVXo3momJrAg3IRDXvrtbmIkXoO388towkrHxDj5AyfIKvH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b76rsbUsmQpJJWsk3/k9c1/Y4yUelUkK88iFuzwrBq8=;
 b=X1mxzIOv10gC6GkIqLFS1K32AuokQbjs8a+C85O/r/VT6LbAFmZ94CF3BPqbaQaY0W3u9443xl6Xq+Tbhb7ne2AoaZt6mSfqNEHn5b1wgkkTvSxm34dDLzOdxePOiKxOvdQcyO+ERNwGepxK327XWy9HUTdqEawastqgrsWbq+CBfFQpte1QYeFbMEsGTxUaqIUNGnIFSC4PwrtRGk43/S5k8dfojfNNmhlbHW3fltmFnrAH95LUbzDk0DLDky76DDm6VymxHK6ty+XstIg+gihKyjZoGrlJfigQaGyCrxGVHfwVdZCR5Gdq2vzT0kQj2FZSLwCRJCXMK/8dBAv75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 2 Jul
 2025 14:23:53 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 14:23:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 04/38] vfio/container: preserve descriptors
Thread-Topic: [PATCH V5 04/38] vfio/container: preserve descriptors
Thread-Index: AQHb2h3yaet/vzjiqU6M73o4eM+8UrQQh2JAgAzscoCAAZDBEA==
Date: Wed, 2 Jul 2025 14:23:53 +0000
Message-ID: <IA3PR11MB9136CF5E6964B8D6A2FC8B029240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136FA577AEC8E5D138B0E249279A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9386dfd2-6793-46ab-a2a0-c50f98379530@oracle.com>
In-Reply-To: <9386dfd2-6793-46ab-a2a0-c50f98379530@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8237:EE_
x-ms-office365-filtering-correlation-id: 50008765-bf10-4689-0270-08ddb9741296
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b0txTmdlMXpRSFFCUkRIZnpUWS9MV3dqZ0lneitEQm5VM0xKNFM5MjR1RHFI?=
 =?utf-8?B?aUVIQWJVbU5aclhwV1RTUVoxMmpXR1dPODM1NG1wc0ZpYU03QjJhb3FiYTli?=
 =?utf-8?B?Z3FmT2NuVm9meG9VRHVEclBBM25YTzVIejZUcThiYjBRT2ZoRzJoMElRSjNi?=
 =?utf-8?B?NUdyUWxEZ1hUSHQwaGFvZmhqeEp5bE9iNVl2VnBjZWxPc3ZhL3ZRR1dLbWRn?=
 =?utf-8?B?TGtkT2w0emNhOEN1ajM3TzBESWtXNmFHb2ZRZDZSemMvcjJ0ak91VzJiZ2NY?=
 =?utf-8?B?YVdRdm1kMkdpR0w5OG9QWmxoM1hhQlhtV1oxaWZUanNtUVJJSCs1U0ttQ0pK?=
 =?utf-8?B?bmNSbGRSTUVHSUtzWEtmcmxIbTRsNmNQdHc0VGNIeDBrdGxyd2Q5b0M2RDFO?=
 =?utf-8?B?c1FsSFAxUzRFcVczSzhNRlZ1UCtvamZQN0YvVVZJOG4rcWs5SUMzdE0zWU5F?=
 =?utf-8?B?elllZU1wNE1TaFl5emJqMGlWbC9pRm8zVkJnZVo0alNhc2dpbU5WTXk3VkNH?=
 =?utf-8?B?Q1QrSEhpTldtb1R6STduSHpPM3ZlTGxrNFpwRGlvbzdRQllwaXNpTVVMS2Fp?=
 =?utf-8?B?ZW9TbW5IUEV5d2lJNGpNMDB0OHRpcXhtN1NueDR3bmRmS3N6NGxFOUprdUs1?=
 =?utf-8?B?cFBLd3RXOHhWVGdtcG8rSzNKeUVYUFdOK1U5dVhvQVQ5VE1wV0gvRUowcmdr?=
 =?utf-8?B?Sm1VRGdkQi96cUNoTjl1OW5XRjNSN0MxalRGQUZLUHp1ZTJJNWFpN05Ic0VP?=
 =?utf-8?B?dzBjRHNWc0VpU2FueUF6VllWTkxsMGkxdzljM1Y5WVJ2WUpvRjhDYk5RYVh2?=
 =?utf-8?B?Z3VyOFRaa25PTkJMYzhUb1RXblZYNkM0dlFMUC9TeFMyY2FTWHN1bVo2VmpZ?=
 =?utf-8?B?MUtySk9aRkZ0eTJ5L2dhOFhYalZWazQ5aXV3UHphTHFBdllnR3YvZmgxb0FP?=
 =?utf-8?B?Qmx3d2xUSmxMYTcrOFNBcDYvRHB4RE5wbVNBbkNTdlI5ZFRKOHZxclRPN3Mr?=
 =?utf-8?B?SVlibk16WkJyTS92Q05rcC9IQ1lodkpya1RKUmliMml1Sms1RUF1Z3pFczZn?=
 =?utf-8?B?VFF6UkpjNGRWUlkvbDJLVnpYSVJvTnZ3bzAyNVNMcUFkb2dBQTNwa21NdzVy?=
 =?utf-8?B?dUcxcjJCMlNGZnZNWG5McDRtYWdyTGt4TUIxQnNQcFpnZk0rdG5pSWJmMzkz?=
 =?utf-8?B?MXVDbkVXWVBIVy9ycG8xL3VZSEx4SldtcVN4em1scmN4OUplRTI0ZkxTbjMw?=
 =?utf-8?B?NDJyYnE0M2Q0WU9kbE1BL3FUZ1V5bkp6UVBNT2x4eWFkUHJVTSsyWjA4V2ZN?=
 =?utf-8?B?V3RNOCtLUjFjUEp6SDQzVHl0Mk9HU3BwZ3lVaTd6REpXenpRMGJyRkxBaTgv?=
 =?utf-8?B?V2FNb09RcWZDUER5STJway9zWmRhc2hPQVR3dmlDWmhvTVZxc0tYa1I3WDhM?=
 =?utf-8?B?UVhsNW5TZzZFMFNubHdXSS9YK0hPZ25langyaktNdVJYSVRXQVRPbENzdklN?=
 =?utf-8?B?bng0SGwwa3FFVk1GUDFpQjA2UWFnMGRDakRQdjRLUzYyZnZTb096TUVETkJ0?=
 =?utf-8?B?OUM1Qms4WkUyVWMxYnJMYUJucGZHaW15TFNURjllS3BFYWhkU2t3ZkZKeEZ0?=
 =?utf-8?B?YXJkV3pXWm1MZU0rMmxWS1lyWHVhTndCYnNueUVoRXhrZ3huSDFsSnBxd2NN?=
 =?utf-8?B?N3RjZTJ2OHB4SCtxb1NaZHR0OFpmYmQxbmZwRjU5ZnJ6M2JTTm1WaHRHNjJr?=
 =?utf-8?B?UzRuOFo3S1JqSlV2L3dSc3JPcjFQZUJReDUvNytzUzVEejhHRzgrWndyN2Nq?=
 =?utf-8?B?TFpucUtxK3hFQ0FlbWZHUE5ZZjhhTzFBODRNOW5BWlRQdHVrY1dYMXBYbThw?=
 =?utf-8?B?Q2FhaExGSEZRcXY3eCtXSm10dFZheU1tNVVUNUNkK2hvRzA2WEF6WEVKWmlm?=
 =?utf-8?B?SmVLbDlzeGZFd0NoWGpDMzNLcEZ4bXlsQkZVQXAyVUV3U1JobEpaSHd0SlRv?=
 =?utf-8?Q?YzC4cQrZBJo/LCUoqT2TjTwkN3+msg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1RFN0ZQSlBhUG0zL3FuQ0I3QTFwMml1d1hYMmJNNDk3WkhyTFpMdU5lT2lM?=
 =?utf-8?B?WTFZOFZwcWFHdmV6NTRZM2lRSm93TTF6UzhQdU5hbUI2THRScXFOdmFUaERD?=
 =?utf-8?B?Q1FobDNMK0cxMVMyUWt5NHZoNEZPVDVkOHdDVWpBL3ovR05YcXExOVhkOXdY?=
 =?utf-8?B?bUh2YStjVlpVRk5HYVYrQXBTUzh1dlhGWjJ0ODZEWWkvendzQVRuLytJTnQ4?=
 =?utf-8?B?SE03d0kwYjhyRUdHWGRIYnhGK3RYQ2hFVlZ4Si9EVHVLZWMrQUdkc0czaitG?=
 =?utf-8?B?cEFuT0dOL240ZWM2dWVFc1hEV2tYVDhLVGV2aUNKeGdhdDNsMVphV3NBU3NF?=
 =?utf-8?B?dUdHREt2TEpwN0FKYXNpdnB1MkN0SEhwZVphRzFzSmV3Q3RiZzYxTTZPQnI1?=
 =?utf-8?B?TTExQTIyUzlKYUd4dHFkNkVKRkR0eU1WTW11dUJsd01MQ2RUTFdIVzBUajhx?=
 =?utf-8?B?NWFMYTBpR1h6QnFiYStYT0oxM0REUmdGb0NPRTBwTHI4cnQyM3BtNUJtbTc0?=
 =?utf-8?B?dmoyUjhQM3JYOVQ1cUtjRHhpOUNZNHdQNU1zZ0ZGUG5NaUlvbUoyYkhmc1hW?=
 =?utf-8?B?SDlYVWdDZnQ5NXhsUXR1Wks3TnFQREFpaWVNcWhLQTZqZ05DYnhPWWdFVlRP?=
 =?utf-8?B?V2d0aEoreWJQR2U3OTF5OUh2d09xUHo0WGZ2TEh1VzRXTHdnR0JyaFRISkp1?=
 =?utf-8?B?a2dhWkd1V0c1bTRyQ3FFaEhlZERQc2JlYk5GU1FYT1pZNmFPZlFnNzd3d0Q2?=
 =?utf-8?B?SVJiV0FjTzAzVmpyYU1pUFRGRUhWQi90SExQNU45T2pLNm5qZUhJczNrVzkz?=
 =?utf-8?B?STZldjBjSDBrYkVQTmYwSjI2TUtEVEwyK0RKWnRXb2ZET3FZakxrNGxqOWI3?=
 =?utf-8?B?Tkt3VlA0eVpDSTQ2QzU3SWNlb3ppMVdZaTJ5Snk5elhMSGxscUszMjB2VFBz?=
 =?utf-8?B?bjZWblJTMm1SY3l0TEZIdExxakhUQmtTS2xHdjE2MmNNWDlOVGlnUEZWNHQy?=
 =?utf-8?B?Y0JhK0RCakI4ek96T0tEcTlZdEhpVStsNml1OVFvU0pFOCs1QjV0TW04d3lD?=
 =?utf-8?B?ZTVxMVdCWVFXc1kreXlZN2F4VS9td1J4anZmZFR5bVkwenBlUmxEeEF0WkRi?=
 =?utf-8?B?OVFEVHpsbzdhZGVremtlMWZsbkpvdEhZUzVkb3JYeTc4c0VDYUhlNnc4d1FK?=
 =?utf-8?B?K3U5anR4SHZadWdvSVQ5TVIwTEFjOThXNXBlU3cwTGc4Z2lYWFpIZ3JJMGhS?=
 =?utf-8?B?N2NtdmRaelh0dXg4RUxFYTNuZGFWTVZBQzJ0c1FiVXl5K2IvcTdtWE1XbHRj?=
 =?utf-8?B?K000Mnl3NmwwM3FXSU5TNzZyZURyajdnRDJuaTQ3MFYwcnpzbGhhb3FtZVY4?=
 =?utf-8?B?NGI2NjdlcHBuaXl1NWdSVU5QNjhmNUpkK0ZaNkZpTHhJMmMrSmw2N2UrcExQ?=
 =?utf-8?B?d043LzhJN0tjQmJYZlh4RmZTTVBIc0g2M2luc1I0eTBpbWdsT3JxSWMwVnVY?=
 =?utf-8?B?YWdocEsrSmw1WVUza2hvY01NSDlkYmRBV2oxeUFBcUxSSDc2dDRFY1NneHVB?=
 =?utf-8?B?Vk0rQlFwS255aHJreVhKdUswQ0NiQWQ5bDRkWTRBb2pZSlJyVUdxT2VIeFIx?=
 =?utf-8?B?UTRQcjBRbzZIMXBaOXJ5UUJVOUpsL3R5QkhZWFYyY3hBS1BNRE03VS9ZMFRS?=
 =?utf-8?B?V2JJVXdxMUNwM0NQWHR5THVVVE1pZFJldm1GKzAzTzhrZ3dDVFpJK2xudFI1?=
 =?utf-8?B?MlhEMWlaNERrRUhQOG1kUEdrei85VE9TdnpYOGFGaTZEQWdNd0xWVFg3TExK?=
 =?utf-8?B?bU9BLzFDQThiNG8xQnBCU1Z3aERyT3NkcTJIRjVhb0xCKzdHWHBhdytLeWtU?=
 =?utf-8?B?OFJCMDhhaGV5SGxWSS9xanpVZ1ZpRTluYWFnU2FkNWtiQTJpOFFKQzNPdmth?=
 =?utf-8?B?bW9LN0VwZkdmS2g2enJ0T2xnMW9nL3F1TUIwelo2bXdFRVNHd1dObkViTHpp?=
 =?utf-8?B?K3pwd2VDcDhWNDIyNTkyRTJmcXRXVFRDNUdkTGFBUFlyWHZFak9vclRBcnRa?=
 =?utf-8?B?VzBOZmQ5S3FCVXYwY0Fyc1VJYVJIUUdxV2VqQkNWRFlyNXdrTkZBbjRSQVZP?=
 =?utf-8?Q?FSxqfNAPuxY8pFk3spdYbYk0F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50008765-bf10-4689-0270-08ddb9741296
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 14:23:53.5580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThCyfEzsfnkxoa37lysouMS9PfYvZ8Z4OscqRkRkdDLk5g356JVd+CWBjc0i8nxI10MUoSwJaXML8fZtpUVkmbpGfeLPpnCv5VCTP+W+WvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMDQvMzhd
IHZmaW8vY29udGFpbmVyOiBwcmVzZXJ2ZSBkZXNjcmlwdG9ycw0KPg0KPk9uIDYvMjMvMjAyNSA1
OjA3IEFNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+PiBGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29t
Pg0KPj4+IFN1YmplY3Q6IFtQQVRDSCBWNSAwNC8zOF0gdmZpby9jb250YWluZXI6IHByZXNlcnZl
IGRlc2NyaXB0b3JzDQo+Pj4NCj4+PiBBdCB2ZmlvIGNyZWF0aW9uIHRpbWUsIHNhdmUgdGhlIHZh
bHVlIG9mIHZmaW8gY29udGFpbmVyLCBncm91cCwgYW5kIGRldmljZQ0KPj4+IGRlc2NyaXB0b3Jz
IGluIENQUiBzdGF0ZS4gIE9uIHFlbXUgcmVzdGFydCwgdmZpb19yZWFsaXplKCkgZmluZHMgYW5k
IHVzZXMNCj4+PiB0aGUgc2F2ZWQgZGVzY3JpcHRvcnMuDQo+Pj4NCj4+PiBEdXJpbmcgcmV1c2Us
IGRldmljZSBhbmQgaW9tbXUgc3RhdGUgaXMgYWxyZWFkeSBjb25maWd1cmVkLCBzbyBvcGVyYXRp
b25zDQo+Pj4gaW4gdmZpb19yZWFsaXplIHRoYXQgd291bGQgbW9kaWZ5IHRoZSBjb25maWd1cmF0
aW9uLCBzdWNoIGFzIHZmaW8gaW9jdGwncywNCj4+PiBhcmUgc2tpcHBlZC4gIFRoZSByZXN1bHQg
aXMgdGhhdCB2ZmlvX3JlYWxpemUgY29uc3RydWN0cyBxZW11IGRhdGENCj4+PiBzdHJ1Y3R1cmVz
IHRoYXQgcmVmbGVjdCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgZGV2aWNlLg0KPj4+DQo+Pj4g
U2lnbmVkLW9mZi1ieTogU3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4N
Cj4+PiBSZXZpZXdlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+
IFJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4+IC0tLQ0KPj4+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oIHwgIDYgKysrKysNCj4+PiBo
dy92ZmlvL2NvbnRhaW5lci5jICAgICAgICB8IDY3DQo+KysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tDQo+Pj4gLQ0KPj4+IGh3L3ZmaW8vY3ByLWxlZ2FjeS5jICAg
ICAgIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiAzIGZpbGVzIGNoYW5n
ZWQsIDEwMCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jcHIuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNw
ci5oDQo+Pj4gaW5kZXggZDRlMGJkNS4uNWEyZTVmNiAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRl
L2h3L3ZmaW8vdmZpby1jcHIuaA0KPj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5o
DQo+Pj4gQEAgLTEzLDYgKzEzLDcgQEANCj4+Pg0KPj4+IHN0cnVjdCBWRklPQ29udGFpbmVyOw0K
Pj4+IHN0cnVjdCBWRklPQ29udGFpbmVyQmFzZTsNCj4+PiArc3RydWN0IFZGSU9Hcm91cDsNCj4+
Pg0KPj4+IHR5cGVkZWYgc3RydWN0IFZGSU9Db250YWluZXJDUFIgew0KPj4+ICAgICAgRXJyb3Ig
KmJsb2NrZXI7DQo+Pj4gQEAgLTMwLDQgKzMxLDkgQEAgYm9vbCB2ZmlvX2Nwcl9yZWdpc3Rlcl9j
b250YWluZXIoc3RydWN0DQo+VkZJT0NvbnRhaW5lckJhc2UNCj4+PiAqYmNvbnRhaW5lciwNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+PiB2
b2lkIHZmaW9fY3ByX3VucmVnaXN0ZXJfY29udGFpbmVyKHN0cnVjdCBWRklPQ29udGFpbmVyQmFz
ZQ0KPipiY29udGFpbmVyKTsNCj4+Pg0KPj4+ICtpbnQgdmZpb19jcHJfZ3JvdXBfZ2V0X2Rldmlj
ZV9mZChpbnQgZCwgY29uc3QgY2hhciAqbmFtZSk7DQo+Pj4gKw0KPj4+ICtib29sIHZmaW9fY3By
X2NvbnRhaW5lcl9tYXRjaChzdHJ1Y3QgVkZJT0NvbnRhaW5lciAqY29udGFpbmVyLA0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgVkZJT0dyb3VwICpncm91cCwgaW50
IGZkKTsNCj4+PiArDQo+Pj4gI2VuZGlmIC8qIEhXX1ZGSU9fVkZJT19DUFJfSCAqLw0KPj4+IGRp
ZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4+
IGluZGV4IDkzY2RmODAuLjVjYWFlNGMgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmZpby9jb250YWlu
ZXIuYw0KPj4+ICsrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+PiBAQCAtMzEsNiArMzEsOCBA
QA0KPj4+ICNpbmNsdWRlICJzeXN0ZW0vcmVzZXQuaCINCj4+PiAjaW5jbHVkZSAidHJhY2UuaCIN
Cj4+PiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPj4+ICsjaW5jbHVkZSAibWlncmF0aW9uL2Nw
ci5oIg0KPj4+ICsjaW5jbHVkZSAibWlncmF0aW9uL2Jsb2NrZXIuaCINCj4+PiAjaW5jbHVkZSAi
cGNpLmgiDQo+Pj4gI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb250YWluZXIuaCINCj4+PiAjaW5j
bHVkZSAidmZpby1oZWxwZXJzLmgiDQo+Pj4gQEAgLTQyNSw3ICs0MjcsMTIgQEAgc3RhdGljIFZG
SU9Db250YWluZXIgKnZmaW9fY3JlYXRlX2NvbnRhaW5lcihpbnQNCj5mZCwNCj4+PiBWRklPR3Jv
dXAgKmdyb3VwLA0KPj4+ICAgICAgICAgIHJldHVybiBOVUxMOw0KPj4+ICAgICAgfQ0KPj4+DQo+
Pj4gLSAgICBpZiAoIXZmaW9fc2V0X2lvbW11KGZkLCBncm91cC0+ZmQsICZpb21tdV90eXBlLCBl
cnJwKSkgew0KPj4+ICsgICAgLyoNCj4+PiArICAgICAqIER1cmluZyBDUFIsIGp1c3Qgc2V0IHRo
ZSBjb250YWluZXIgdHlwZSBhbmQgc2tpcCB0aGUgaW9jdGxzLCBhcyB0aGUNCj4+PiArICAgICAq
IGNvbnRhaW5lciBhbmQgZ3JvdXAgYXJlIGFscmVhZHkgY29uZmlndXJlZCBpbiB0aGUga2VybmVs
Lg0KPj4+ICsgICAgICovDQo+Pj4gKyAgICBpZiAoIWNwcl9pc19pbmNvbWluZygpICYmDQo+Pj4g
KyAgICAgICAgIXZmaW9fc2V0X2lvbW11KGZkLCBncm91cC0+ZmQsICZpb21tdV90eXBlLCBlcnJw
KSkgew0KPj4+ICAgICAgICAgIHJldHVybiBOVUxMOw0KPj4+ICAgICAgfQ0KPj4+DQo+Pj4gQEAg
LTU5Miw2ICs1OTksMTEgQEAgc3RhdGljIGJvb2wNCj52ZmlvX2NvbnRhaW5lcl9ncm91cF9hZGQo
VkZJT0NvbnRhaW5lcg0KPj4+ICpjb250YWluZXIsIFZGSU9Hcm91cCAqZ3JvdXAsDQo+Pj4gICAg
ICBncm91cC0+Y29udGFpbmVyID0gY29udGFpbmVyOw0KPj4+ICAgICAgUUxJU1RfSU5TRVJUX0hF
QUQoJmNvbnRhaW5lci0+Z3JvdXBfbGlzdCwgZ3JvdXAsDQo+Y29udGFpbmVyX25leHQpOw0KPj4+
ICAgICAgdmZpb19ncm91cF9hZGRfa3ZtX2RldmljZShncm91cCk7DQo+Pj4gKyAgICAvKg0KPj4+
ICsgICAgICogUmVtZW1iZXIgdGhlIGNvbnRhaW5lciBmZCBmb3IgZWFjaCBncm91cCwgc28gd2Ug
Y2FuIGF0dGFjaCB0bw0KPnRoZSBzYW1lDQo+Pj4gKyAgICAgKiBjb250YWluZXIgYWZ0ZXIgQ1BS
Lg0KPj4+ICsgICAgICovDQo+Pj4gKyAgICBjcHJfcmVzYXZlX2ZkKCJ2ZmlvX2NvbnRhaW5lcl9m
b3JfZ3JvdXAiLCBncm91cC0+Z3JvdXBpZCwNCj5jb250YWluZXItPmZkKTsNCj4+DQo+PiBJIGtu
b3cgdGhpcyBpcyBhbHJlYWR5IG1lcmdlZC4gSnVzdCBvdXQgb2YgY3VyaW91cywgSXQgbG9va3Mg
Y3ByX3NhdmVfZmQgaXMNCj5lbm91Z2g/DQo+DQo+dmZpb19jb250YWluZXJfZ3JvdXBfYWRkIGlz
IGNhbGxlZCBmcm9tIG11bHRpcGxlIHBsYWNlcy4gIEluIHNvbWUsIHdlIGtub3cNCj50aGF0IHRo
ZSBmZA0KPmlzIGJlaW5nIHNhdmVkIGZvciB0aGUgZmlyc3QgdGltZSwgaW4gb3RoZXJzIHdlIGRv
IG5vdCBrbm93LiAgcmVzYXZlIGF2b2lkcw0KPmNyZWF0aW5nDQo+YSBkdXBsaWNhdGUgZW50cnku
DQoNCklJVUMsIHZmaW9fY29udGFpbmVyX2dyb3VwX2FkZCBpcyBjYWxsZWQgb25seSBvbmNlIGZv
ciBlYWNoIGdyb3VwLiBCdXQgaXQncyBoYXJtbGVzcyB0byBjYWxsIGNwcl9yZXNhdmVfZmQoKSBo
ZXJlLiBJJ20gZmluZSB0byBsZWF2ZSBpdCBhcyBpcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

