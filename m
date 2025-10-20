Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53DACCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAoNF-0001ES-L9; Mon, 20 Oct 2025 07:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vAoNC-00018q-66
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:48:22 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vAoN8-0002Qn-RZ
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760960899; x=1792496899;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YTdf/B+pUoyYQn9U6ap8dD2Fm50lOKAbyDCe4t8e5QU=;
 b=G3aoF5Gar12JoIQTApR13OI1ZyJwKnTXhpf2dW23/kEczhH36rmEMdP2
 eEh37r/ibR5ioCpZMuL6dELENscFIwYGMslRONA073lYLU8MG0nHMGRt4
 MeI5c1IJk5c4GSoVYUnRqGk4BJ/YtmtDX54KuK5UUpCbsOWJUm4QXxYDb
 lrBmOt9ywa7O/KtbovLPNv6iJu4Z+IkqKUavn5xhDPzone0cLvE+nYgRU
 kt9iLy4YUAfxDNRDFgTQiHysx/UevT1aCSs1pXolpLHpmicxrIixZV/oz
 v6hG6fV7EQD9gK4t+l1e/eUrO5+jrCLskhIRm46ttkQmnOf8VMli3eEoa Q==;
X-CSE-ConnectionGUID: jwQFzYvzTS6OxuXJo/QKIw==
X-CSE-MsgGUID: HtTJpTr+RoGIQ8lWENulmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80699774"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="80699774"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 04:48:15 -0700
X-CSE-ConnectionGUID: YGk+a8kARoeF+i8J3O1GTg==
X-CSE-MsgGUID: 6mcBkBPzTx+mJsZ1qtOkTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183720489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 04:48:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 04:48:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 04:48:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 04:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W44SwNTglOBKyJ5guHiOTRhrnM1SEPnce2cpC7Oscw/6q4347+R1mtyIE9xJQB6BYEPHIzs2BnRZa8KyWK13rXqiVsuLZ5b8P32F6sE9vxWAuhbwmV8MyFJyalu0SplI+0w6TvIR0bMGTKyBOZ4iiFq1BUQkewpOe0VSzyniIB/979Ip/SjqHSvJa4h/DjX4nojarzOgPZQh6DoYXY6bKhPp+LgJ0d184sKEWepvqbtKFJhWGphfxK7R/sEj6SQwyYQzjmxHk/qvvf8E5X3/q2qE6SkP4BcougaQpHzlaUkwYEIZwpAKs4PQ1ADFMSu/Go7Kgq5GuRv1BMVvEwcZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8hP9B0fFVtDXfmXBvHFYkfAZu13PkObDRa/zu66XyA=;
 b=gwq+tlbDMZAtovT9q2ZJ6e+wTkiLf0po5YNiPEOfpnD7H7660+2gDWs4qfOoGhecMFbJUlyMOyvHI9hmJaa+b7yNa5n9D6UIVNCokfzdwe0NCSyi3frlyOGaJUA8jRpow3SvKclS3GuWRIWFRmZ4REbLDYcL7W3HTTfAdgDU1YVeIEl4NpBNsfFQO1K++LZMJYTerGE+kKss+skwpTuI+yDKdCb0MtFZogwtOIOUXlt7z6czhxan7Ky4iD9Dpb6XaKTPx2o2IPBnBQ8DF5iueisbvIXg8PFY55i+QooSlVW4/KOX9T6mgJo94vQinGcZ3HiJEX+fozJX6BA0IvZraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 11:48:10 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 11:48:10 +0000
Message-ID: <e5157838-2e4d-4a3f-8fba-3a79ceb58a38@intel.com>
Date: Mon, 20 Oct 2025 19:48:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ram-block-attributes: Avoid the overkill of shared memory
 with hugetlbfs backend
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Alexey Kardashevskiy" <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Gao Chao <chao.gao@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20251017081445.175342-1-chenyi.qiang@intel.com>
 <bc7c734d-28c4-4abf-8049-a93e2e5e0b1f@redhat.com>
 <08e0ea1a-34dd-4700-917c-157996586c73@intel.com>
 <944cfa69-c7ed-4e18-aab9-db23f38da1a7@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <944cfa69-c7ed-4e18-aab9-db23f38da1a7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PS2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::24) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|IA1PR11MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: f7205caf-6eba-43a3-522a-08de0fce8b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnRESUt0TXRPMTZQMjMyNE9FZmtCeTR2NXVURXRhdGtPUWRTM1hhUXR5aHJj?=
 =?utf-8?B?bUFMSGhLaEtveUd6SDFLTzNEUE1xV2NURmlsTlZ2RktwVGJ2c05TQ3g3Y1hM?=
 =?utf-8?B?ZDVVSUUzUVMva3U4RFJXdnNDelJoSzBEdmhPR01relVYQmdtZWxxbzVVOE43?=
 =?utf-8?B?YjE3VlEzM1RiczNtblYxekxyVVM2YTdNZmFvTHFNbzY1OE9tYzVxUXVlY2pY?=
 =?utf-8?B?dnVlT3I4eEU5R0FHeWpOQlkydFFpMTJtQSt5VldyM2lqWndaNnhRQk56ZTlh?=
 =?utf-8?B?eGlaNHhpOWNnMmpxdFpibjNFWEpadi9VOGJxUnV4UFFzS1JNV1ZCbmMvQ0xz?=
 =?utf-8?B?V2hOMDZTRmFjdlJ4WDRuSnR3NzJBVnEwYUF0SkY1QkMxenUwZ2tOaCtydHVq?=
 =?utf-8?B?UVloSXBZWEdGS1p5K3JXWFZ2L2NIaTNrSlRLWXNCM1VvWU4zMTkzSEdxRXlv?=
 =?utf-8?B?aU1ZZWx6ZFhDOGhKeXRNZzdMS1NiOUplRTlkSUNlYmdVbWVHZFVEeHJCbUE5?=
 =?utf-8?B?RXpWaXdPVXVSNGwyQUVmd0Q2cTNYWWo1cWFXNmo1TWhQZnRpdVl2TlhMVytv?=
 =?utf-8?B?NDJtbXphaGdTMmdaV3lZQUdsWmZ6Mk90UTI4NzJNSnpBbEdFTGZmODVycVd4?=
 =?utf-8?B?dDlndnpmdmdRR1FvVEhwZElkSk9ucXBoMWRIRmZJZnJzYU9CYzlxbjJKL1JZ?=
 =?utf-8?B?UFJ3UVlGbkJNa3FWaVlneXZndktQZ0phU3JDQlRDYmxIa21lYkd4S2hOZjFT?=
 =?utf-8?B?aDhJZDNLTU4wNU5ERWUxQS9mVHd0SEhyVmxwYzg1Q2RqS1NReWRseHl2M1Fu?=
 =?utf-8?B?aTNjdmt5clRPT1NjZnp3MGJ1Tjh2aXVYYXZYTjdXbmNreWU5aHB4MFR3WFZw?=
 =?utf-8?B?VzNhWFoyaTBhL0ZCZUQrZndaYUwyYlZyUzJXeFl3emhDSUJ0OER4V1JtaDQ4?=
 =?utf-8?B?ZVRCdFRrMlZBMHB0QUgzRGYxM05vZFFpTWRQQVltTFpTV1Y4VmhoZTNEbGho?=
 =?utf-8?B?WGZSeE8wbFBQVFlVVWRnMjlyMlNmZXhid1hiS2dDQWw0SmhjZUU4MURRMk9l?=
 =?utf-8?B?WGxFZGo0d2d0aDBqVG9NNGErbG5sSHF2Sy9STGNzSGtBdTNFQ2p6cFFoVEdI?=
 =?utf-8?B?ZjN5N0t5aFpEaEpJZjBPd2ZTZE1wUDlGZUNwbWNMbmpydlo2N2hvTEhMWG5m?=
 =?utf-8?B?aUQ2V1hGeFRubHlnSjJ5NUVLSGRkVjU5UXA2TmpkSWpYSDJod3pjeVBTQ2lB?=
 =?utf-8?B?V2JSLzRrNGxLVHNTZDV0WGlocDlRd1hOTFBDeDB2NjRiWmsreXJDRTYwQXE4?=
 =?utf-8?B?cm5DODRCMFZjV2hYTDJIVUpEODZNQ2lZajc0SXIzSnV1NGl6Nm02eWhmLzhy?=
 =?utf-8?B?em9SNEcvUTQvV0hCNFBlVEhXVWpSVkJjajRHM0pOZGptcmFwUHFTM1JxUXRk?=
 =?utf-8?B?NlNheU1LamQ1RmQ4TmtHRjYvZUZGMWNwem5hdmIyYjQvQ2p3bFhOT0w1OXNm?=
 =?utf-8?B?SHBna3A5RlRkSTQwcGp5TjdUQ0xzVVM0UlVUc0dIOVBVbXRXZFlmMTh5L29l?=
 =?utf-8?B?VXIzdjhqaUdWekc0amRYYzF0QjcxK0VaN3NFTmJqWWhMSnNCMjExVVMyd0lv?=
 =?utf-8?B?NTZvdkhwa2sveVZOWDRtejBjL05WVWN6VTF3dHhoRTJ5TzAzMEE5ZEJ3WDMv?=
 =?utf-8?B?aFE1Ni9OL2s4YzZTS3dSV240NnVhTkNVVGNyWFBtaVVsbStUY1VxWDAvbFRW?=
 =?utf-8?B?MEQ4VlB3WndaZThmQ21EbnFJZzhOaDlGVlJjT1VhVzRmdDNoY2gzL2phQzU0?=
 =?utf-8?B?RFZvMjlhUVRPazhEQ3BuSWw0TmV4NE1lZTdERjdyWFUyQWRVczdUaXY3d283?=
 =?utf-8?B?UDlScDdxUTZpUjZxZWkybWc1ZHFPVEM2dFhWZEVPWHhHNEdCY2ppNHpMV0x4?=
 =?utf-8?Q?SYvbNnI0ik1WcnZZHL65OC8Fl9haNRju?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0dXVER3KzRwaEJVTkZlK0gzRW1kWngzdWdkNHJPaTVXcWNVSlpZd2JTMTVS?=
 =?utf-8?B?N2ZMVEpGYVFoVlhYODAvL0FWMUZ0eGliWTFBTnd5MU1hYTRzcUJoVmhXQTBw?=
 =?utf-8?B?WFlWcXdrR2JqMTRUZ2NXaFlzaFpJNnkrb1hKK3VxYWhVTWNJSklKQ0JEckFC?=
 =?utf-8?B?ZEJQTDdmTUFPWllWbWhSd3RLQ1NkaGFlYmFScmpJbTNmZjQ3ZDY1eUdNcFE0?=
 =?utf-8?B?dVdkK2xZNzBMS0JxRUJRclFKQTlFR21qcmxMSC9HcjQ1aFFkZ2tMNm8zOGJG?=
 =?utf-8?B?ZHRkcWVtQUZYTTByMnptd0Q1N2MwMjlraVdlSU5TQVdlRGpmYjRjNWNqOGIy?=
 =?utf-8?B?dHBjejlsWTVacmdRY2x6dkNHKzJSOTd1SWYydWlma1FSV1lVZkdmK1k3K2pz?=
 =?utf-8?B?RGVwK0ZkUnFtZ05RdXExdlFhS0JsUkxnd21vMERGN0ZKc2RvZm1LZzZIRW9V?=
 =?utf-8?B?c3lVWWF0SG51bUtuOEtPa0lLdU96U05mdnIrMUJDd0JyU1JNektGWXZycVE4?=
 =?utf-8?B?eWw3QjIzMDl4bkNWMTdvaUtqcit2aVFYZSt3RDR5ZGZkMHRCbFM5RWVMVVJP?=
 =?utf-8?B?c3g5NW5TaUROSERQRDh1am0wY3ZIUmt1dHBsWlo2REs3WVMxYy9QZjBEKzhx?=
 =?utf-8?B?d0ZERmltMjJLWGg5Rko0N3A2Z3NXZGZQR0ZSb1B3ckJWSHorSHBja3c1Wmoy?=
 =?utf-8?B?ZUtKUXltS2svWGlvcnQ5enBUZmFCekdDVWhyT1QyL2M5NWFIRWtaaHlTSFBQ?=
 =?utf-8?B?dTZrM0xhQjJ1VkloajFoaXBEQkxobi93bUJKTDFmZm1BWlJrbldhTnhwUTFZ?=
 =?utf-8?B?N0ptZTIzWGx2L2ExS3JJMTBFNURsQjBvWW85bm5LNFJpa1kzWC9tZnFUYXlw?=
 =?utf-8?B?OURGbElxUG52djA3WEVrM1lmVWRTdGUvdDY0T2E1VTZNUXk1K3RpVEFIZHB6?=
 =?utf-8?B?UFlCTStJbk5jQVFQb0ZSRWFBMWE3TmUyTm5HWExXVnRRalJWZURGUHo4Y01v?=
 =?utf-8?B?QU5pYStKUEkrR3EyRXVNd2xNMmJoVWY3NTdTa09IUGdSb1ljalBKNXg2ai9l?=
 =?utf-8?B?SHo1TVZQRkpJeWZLN0NDVTIxRG0rZyszTlBMZ05haDdkSlJJbHA5UnI2ZHJx?=
 =?utf-8?B?bm40OEl0NWUvaDROSHJFRUtyR3N2SjZkaVM3RlpJd1M0bTFyZ3dVSlNsSFRx?=
 =?utf-8?B?N1ZJK0FKQmdVR1BGMUQrREUyYm10aGNFTnRBdWRjVFo2Smx6Q05mR1k3M3Bi?=
 =?utf-8?B?MVlUQmJNNmo1TTFJelRFbGpvdjBPVGhLYmVyd1crbFlaQ1hIYmRUeDEwSU5I?=
 =?utf-8?B?S2dLSUFwcVpJTkNhN1NoV0FFZEdlSVRXdFZrTWYxNXBHOEJud1g4eFVQYVFX?=
 =?utf-8?B?S2hCSG5BS2xjNjZzejNSKzRnLzdWWTRGRlRuNGJRSmJzWlVDUCsrNWYwOGtB?=
 =?utf-8?B?OXJrbVBYYkZzQXY4endYeXhwcFhXc2k1RUpYYjZidnJzbkc4ZkZqT3JmbHNQ?=
 =?utf-8?B?R3YwSlk2UWdMVklWZGluNXM4VU1PWjZIMlRSZkIwRU93RDhrQU9WREFhU003?=
 =?utf-8?B?ZGJlM1VRRyt0QXpuLzM5NW1IKzVpYzhMVTNQemoyS3pVMzM4SW91RkhHNGFS?=
 =?utf-8?B?RVZ2YTRhOS83RldjcEcxeE5oSjdnbVIrYTZvOXJqUlJLTGNNM05CdWtRd200?=
 =?utf-8?B?c3dLRlRaZHV6ZVJJUWRHUzVaV3U5aDBpeEhoTC9jb0tSS3BBQ2d4NzJXQkNN?=
 =?utf-8?B?bHBEbE1wZTVaVzZEYUxZQW9mYUZnakZ1ZzkxNHhsMU5waVdoT2s0VDMxZDlO?=
 =?utf-8?B?TjZnZjFVdHZiYUdiWjJvL3d5eHF1VHA1U0V5R3ZqZkh2amZuUnVSSWJzRVZv?=
 =?utf-8?B?TGovSmNibjJLVk5GMGxtOVhNdXlOdUhlL2hkOVdRMXdMVk4xWVowc2xOelJW?=
 =?utf-8?B?NUpOZWNsdGhVL0hmRkxQK2Ztanh1aWV1QlExSHFJbit2YTRYSEdRc1FyQkNW?=
 =?utf-8?B?SXpGVDNtZ3NkTVNiYmRBSE5QYWVpT0w1bU1SbmMvOW92S0l4Y3NsNXhUT0Zs?=
 =?utf-8?B?MVlyc2h1QmRwTVZUS2lwSmFvd2tYTXE5N09aMU1GdTh3NDVSUmEzTnQxNXVu?=
 =?utf-8?B?M3FUT2xOaFJDV2hKYlhQT04yc0RzSStkUHM3eTRUbEZwLytzRDFDS3Z6Zjhr?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7205caf-6eba-43a3-522a-08de0fce8b04
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 11:48:10.5208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMTESHUPJWJXtQ41Rbkv5bFnXFL7C13V9VVJx2OK8PsmH++AgWT4nzlthHiXPSrkDudq61JYl655AF1OVUqEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6098
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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



On 10/20/2025 7:31 PM, David Hildenbrand wrote:
> On 20.10.25 12:32, Chenyi Qiang wrote:
>>
>>
>> On 10/17/2025 11:13 PM, David Hildenbrand wrote:
>>> On 17.10.25 10:14, Chenyi Qiang wrote:
>>>> Currently, private memory and shared memory have different backend in
>>>> CoCo VMs. It is possible for users to specify the shared memory with
>>>> hugetlbfs backend while private memory with guest_memfd backend only
>>>> supports 4K page size. In this case, ram_block->page_size is different
>>>> from the host page size which will trigger the assertion when getting
>>>> block size. Relax the restriction to allow shared memory to use
>>>> hugetlbfs backend.
>>>>
>>>> Fixes: 5d6483edaa92 ("ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock with guest_memfd")
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> ---
>>>>    system/ram-block-attributes.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
>>>> index 68e8a027032..0f39ccf9090 100644
>>>> --- a/system/ram-block-attributes.c
>>>> +++ b/system/ram-block-attributes.c
>>>> @@ -28,10 +28,11 @@ ram_block_attributes_get_block_size(const RamBlockAttributes *attr)
>>>>         * Because page conversion could be manipulated in the size of at least 4K
>>>>         * or 4K aligned, Use the host page size as the granularity to track the
>>>>         * memory attribute.
>>>> +     * When hugetlbfs is used as backend of shared memory, ram_block->page_size
>>>> +     * is different from host page size. So it is not appropriate to use
>>>> +     * ram_block->page_size here.
>>>
>>> But are we sure everything else is working as expected and that this is not a check that prevents other code from doing the wrong thing?
>>
>> I think so. The block size must be 4K due to the page conversion could be in the size of 4K and we use "bitmap" to track the status.
> 
> Indeed.
> 
>> I originally missed the case of hugetlb so added an assert() here. But it is allowed to use hugetlb as shared memory backend
>> before shared device assignment patches were introduced.
>>
>>>
>>> I recall that punching holes was problematic as the VM shares/unshared 4k chunks.
>>
>> I can see the kvm_convert_memory() will skip ram_block_discard_range() if using hugetlb backend.
>> It will cause the double-memory consumption (*). Any other problem?
> 
> Right.
> 
> 
> What we should be doing is unifying the retrieval of the block size in ram_block_attributes_create() as well. That's where we allocate it.
> 
> So either
> 
> a) Use qemu_real_host_page_size() everywhere.
> 
> b) Use ram_block_attributes_get_block_size() everywhere.
> 
> Could be done in a separate patch.

Agree. Will clean up it and modify the commit message mentioned by you and Peter in other mail threads.

> 


