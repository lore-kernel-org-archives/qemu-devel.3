Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E5FC72A8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Zn8-0008QZ-4p; Mon, 23 Mar 2026 03:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w4Zn3-0008QD-2i
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:33:34 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w4Zn1-0002De-3v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774251211; x=1805787211;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3WoAAbDHkQuABVk4hkHI/+DjBOjP0dJgzvNMvxoO5Ws=;
 b=bCDUBb7aUcSQScu7KncdHjr5jYxqr/wg3IhSr+MCGxMVhmyaqPnyhQ9P
 0kFR2w+LW2jxAIgKICC9WWh18DlpqVUGUTGLBwya3LHtV50npA6Pylr79
 aCL5FGWkDG9tBkWUdD408AUXz728QVgSCj20ZqVhGao0LtOL/CMNtkN7c
 akym5g4B+++/WBlJ0KHGPmrDs0SX0XM6+25WYr3jNB830oQgUKonQ6g+H
 EnHnF5p/McgBIvV+SYEkxDHCjf2G5Qj6oPtfeiYig2xIWS47tMWbfcY6e
 CMw2YA9plgjcyoUzevGiluY6NQCg4mmUdxH5OEjTEHAEmJiTf65p6JNuu Q==;
X-CSE-ConnectionGUID: iEPJBw85T2OWM9Cyjs301A==
X-CSE-MsgGUID: XaffFn30QxWmUVdvb3sdaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="85867492"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="85867492"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:33:07 -0700
X-CSE-ConnectionGUID: lJ3pMvg7TbmCb0H9wk789w==
X-CSE-MsgGUID: TCPXvXWfTaeNT05M9fg6Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="228668151"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:33:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:33:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 00:33:06 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHq4T+B5W1p4SNUsGb/OuEDDtsvSYf/FPlcD6EPbVJiq7iy2NVDJ4se59/QaPSSoW0qnibPAmoUPclaAZfvCiUDAkeXRTFJPJJCHn7ldi49qahxL290H6b9xWE3fmYE7qun7qb7+eyDsPnPfdj5I5A5i1ob9AWEd4pRth1Ky6cQtUl0KTrDzO6A+3DHyq4aej0ZzopCyw0Xl6rYjx3FOc5MSiQtzpftA166RrztJUED7jJ6wO3vuWK/XSS63hha6IjNKMpVxVM7qG+UK6V9NBoKYAefPQNRmoTxxPQQFgRSmAPmj3GhFiE2vJlDyUEcy2N3W8INUdkO4Mb+OC5d+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLaGCbQe0XWXEtlLmsvDB1/FcfwYArJRbFMP81KW924=;
 b=BYGBukkrneRB9pJbrAJ+IDOdoZBtKIsIkJWDXjTIp+43rd9MRrO3JEyqoHFHs3JUKax3xsjRV1w4/Ajyp+UiRYeXh7NNvQaxvSVEQIT0V2QNKNyEzDMZXJHo6Tq/ftoq68HQbX6rdVk9xYmWmXD/L10xZC/VNEZlPDyncjRRn4Gi4sHA27GlZXi614EoNLi0mAJ/ha8YasYW+waLd6l6fAaQGgLrr5SOp+IVYT/Zoqvekq1uaQtK1axu7uZRn+7KZitvVpP+ANrl9CPKdhLmH4XqcMarfTVxypkqfehtQrOTGVwBTz6xDu9A8afS/8eusp5Ohg+8Aw12k9Yw3Zht9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 23 Mar
 2026 07:32:57 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 07:32:57 +0000
Message-ID: <f36cb217-4ebc-4d57-8e82-b6d24c36ee02@intel.com>
Date: Mon, 23 Mar 2026 15:40:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-9-zhenzhong.duan@intel.com>
 <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
 <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: db847207-deac-46e7-0c81-08de88ae670c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|366016|376014|56012099003|18002099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info: 23QZzqSAQ2U97IBLF88W94d0zst5hZTrxaP6PQV/aOuNUfGZPmIa7Hs1ltPj0QnecXRqLLJ8gBTvpRJ74ElTD464oE+at1xZyk17cxowUpXxFz2g0iFEbqxB6i/9Lo+BplVoUu4lgoYev49H2MzuP+Bo7p/XmWQtgFjY+LNzYM2+k9GoZd4typFIhs1XmZX9MHI/MMjGIbKmB1U5DJZf5Uw6BSNGvVAf13uSb4cMAW1mxhI1/++dGFYCttiHdRGcR9sb4bTuR8sY5nGf/jLHk0tRNbAMiJZ6gO3JShn6wiveMYtu9x6DiUHYRgJZJkXBsHI7JOC3PmwZG7qSI6abWUn3MAUaHsodTF+CHG+mGcJzuobYuUYSJGwjz7tGXuV8+J4seLqon+xPctcppj5PwvI2/HxJzI5zaDq3k2IpR9nGx8+xxSwm4CLj24EuPCJRwROEuoSyUepPqiIbQb0krSydSYtjp7LsaxwGtuYiK13j+5egr8E4JYCDgc+LilwMWRHJMndBbjAEIkHh3ldiW5cTXq5XgPin1LzvKq6TyDtb9AoIHTPyvZw/e6hfUa3jiuc0UACPbGUYDUpO73wGcvHamtVtRzrNpnjJLoa30KGt+pxiLVbcai6Vn1AOcCNEp/macJB4teaxdyKzmY7kOkK2vSINIRqrkhdvlqknOmbtPcCr8mMA607izjh7QcVGa3eLCXZl/36RkhdrJCYHMsDPi/XNN1pvE+7IM9uuFBoaQmzBu5xTHtdSfwa2F9f0AtexqvDl4H901UbtpyahqZBAd3rzqJnnJB5AACzuFyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(366016)(376014)(56012099003)(18002099003)(22082099003)(3613699012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRBUkdwajQxZ09RektmU3YvcDNJQlJzcDR2dXBvNUs2dVd1RXpYekRHaFV0?=
 =?utf-8?B?UFJCVVpmUVlxN0cxVDVtdmtoL2pxcEsxK0dCNlRneCtXenFld2dWYjdCdk53?=
 =?utf-8?B?TCszWU02QmhGYzY3NGRxWWNZVnF1emZZV3JIam5qc2Fvb1I1SHcyUHNtMjJq?=
 =?utf-8?B?cEZlMlFLbGkzb29DdUEvZC9HWk1CRHZaTzMwY3gvY2JDTUVSQ0xHVXZnZTI4?=
 =?utf-8?B?eElDYUEwb2VQVzJDbGtLNkMvNUt1YWxyMHBXVnh5WEZvajVGYmxHc05QbmRa?=
 =?utf-8?B?Y1FqL2NwUTlRTnREMlVYZW9NbFE0NDdNRmZ1Yk9OSStKM1ZJNzhvTmkxeENL?=
 =?utf-8?B?VndtUHVXYUd1dzBPbnF1a3NsNzJxQVhDN1p5bWNHRWZPUk1KczE1M0xVOGN4?=
 =?utf-8?B?MUNLYVk1MmVaczMwZ2ptaFdjSEg2UlhsMmRrUTE3eVB6UDk0SEpvemprK095?=
 =?utf-8?B?bDFDTlZNR1VQNXFzQzZOZkw3MzU1ZnltQm5id3lOY2wvaEZWVFBMSjV1NTNE?=
 =?utf-8?B?YS8zUTkyZFp2R3JaQ2ZMbzJGd280VWk4SHRscUxZSWprMUtxTEYyZ1l6Q29z?=
 =?utf-8?B?Ylh6alJnYm5hR2k5YWFsUlcwcHZXQkRKekg4RnU2TXVoc1F2QzBXd0F3dTVY?=
 =?utf-8?B?V2sraFZTSzgyZ25mNmp1MnJzeWU3Z0hCbmVoWmFvTm1nWk92VjQ4eXkxRThD?=
 =?utf-8?B?Uk5DYkh0R2lYUlNsZi9LVTJFczdSZ0owK3Fsb0cvNEdtRTgyYThRNWUvYW9M?=
 =?utf-8?B?UWtCN1hIODhxQndBdk5IYUxkMCtCZDZ5M0VWNElMeG1Yc200NWswRG9JeVpo?=
 =?utf-8?B?NEhKTGppQzdGUHRtR3lEaHZHaGRKVGMzVTZRVGV5RVpqRVc4UFR5Q2R4Skxo?=
 =?utf-8?B?dHMrSFM5TmFjMnM3SUdySis2czQ4WWZlYUh1dnhuOERqUFQ2V3ZhSmNVT056?=
 =?utf-8?B?Ty95ZzhOeFMzK1hqTDZIZmdZRE5mYjY2YUxuR1dxMnNYSFg0TW5GTW5qWkcz?=
 =?utf-8?B?Q1o1eEt4bW5mcUUwcndFQ282K0VJUldmemlaK1NHUUFTRXdnd3hlbTUwZm5z?=
 =?utf-8?B?YkYrY2NteFNURU9sSkpZNjhRWUtvdTlzNDBUYnlXdjBOa2FaL00wSERPcGJ0?=
 =?utf-8?B?WUxRTC9GOHA3RmlTdE43S3owcHRHa2FoT2hhcnF5ZU5FWFpOcVZZWFJHYnIx?=
 =?utf-8?B?WC9WUTNsZlcyT2FuVjlQWHNzSzNoN2U1Z1B0Y1BRZTdpbWphc0xFQXNrcVRI?=
 =?utf-8?B?SHM5STVIbmJvSWV3cEtrRzBSb0dqbndyYm0wemw1L2xTa1dGcUxJN3pTWElz?=
 =?utf-8?B?RnUyZTA0TDNaVTFlK08vL3hha1V5Ulh2enhUUHB2c0lVZGRTaGs5R0pmVXR1?=
 =?utf-8?B?clBpbTk2cmQxM1B5anVVNlRwYS9XN0w4UlFtcFBYajRJdU95aWxiemRqWWZO?=
 =?utf-8?B?eW9zOVFmTU1MMmUvUllCR1VkSVVmdGYzcDRUaE9HUU1kaXFBN2doRWcxaWhl?=
 =?utf-8?B?SFRvSkU4QXpTZmpEZGREeGJtNEx2QXlvWW9EczlVMHNyVWZGWEc5Qnl6dXdo?=
 =?utf-8?B?S0QvOFFWYmx4aVdHZ1pERFRETzN0Q254VUt5Smx6Y01Udi82emRBaDhkTDZs?=
 =?utf-8?B?N3R4d0xBdTVGTWxJYXpYKytGdy9iYXVDN1pNWjA3RUJ4UUxnMjFub29rUXNO?=
 =?utf-8?B?WnNyUkdtM01WVDloa3hsMlVhVmtIYUJ4ZjNySlBXNFNYTGVFUmVjR3JwL0Yr?=
 =?utf-8?B?T2s3VXFXK0hqRTk0LzIraHg1S203cmhwaTVad2gyNnJDRUhpcVNXbnV2bnI4?=
 =?utf-8?B?SnkvZlVpV3ZKYjk4R0ZzalFVMUlQYURrOGRhLzVNWHUzQThrT2NyKzkwYnpz?=
 =?utf-8?B?VTNxZkU1SmgvcVBuajdjUzhSSzllT21Ea2FjcVQvT0luNG4xU2JJRWRpVlpD?=
 =?utf-8?B?ZVNodldRaGF2bjlLeTZLNTdXSG10TnFQMSszWk1jNktRQnVVOWszQkNVTVRm?=
 =?utf-8?B?RHZUZk9iVEsrdDUxcE9ZVUEwS0JRYmtYNWI1d3IrK1VhdGU1TXlmT3RSNklE?=
 =?utf-8?B?dXN1eEh4TkpsWGp0Qjh3MFRKM0pqY3RCZXY5a0VQWk1FRm51QjBNTnF5VW5L?=
 =?utf-8?B?Sm5tZ0V0MEorKzhaMTAwSG5WcVJOSlNmdTN3Tmp6T3lWZWFBaWVSQ2s3SGdO?=
 =?utf-8?B?cjVRbERYdlMyVUVack9ZN2ZWSjBNZ2NIcmtzb3dQazlPd1J2K3B4U1MwOEVE?=
 =?utf-8?B?Yjg4Nm44YjVDODlucklDVE5FRmR1OE1GOCtoWUpCZW9RNms2Z2JSd1ZLMGxS?=
 =?utf-8?B?OVhhUS81dnozRkpLSkcrZzdWYS9jcGFya1pNMVZtMWVaR0VCQmtndz09?=
X-Exchange-RoutingPolicyChecked: IznJ7I/lNlEna65bqjmhFHOdA/N50iRBLjzA57nR41d9WJSvfvt+vZ9M9kj6TfEAMMj/cg4df6OEGqD7LoJ6wxWd419E4eJP82aB2zvvjIOh0iqFGLO88ZyVavuSN9idtUN02J8apybg1/1RvP1AT5EOzwhe38LnJvIJwX3aegkzqx0XljWIgSf2T1Y01jky3k25vbPF2pvv4XTUKcWMmb8nqMHRe0g/9N3q6nYO6zhdCxQB34lemf9KJIApi+U0Icm5rWTivtFOzPU7I2mREQCnLinonl7r7g1+kusA6vQwFbXoI/tFVs4BYOOob+NyDqBwrGgWKWD9j39UwH2ibg==
X-MS-Exchange-CrossTenant-Network-Message-Id: db847207-deac-46e7-0c81-08de88ae670c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:32:57.0853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBH6IvKOKxEmqwF5gsupLgy2c4XCQFc6ogNdf/lsUvibb5gRSQP5y2UzHeB5eN7g7A7vCleibekfQG7YndbvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
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

On 3/23/26 14:08, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
>> pc_inv_dsc request
>>
>> On 3/6/26 11:44, Zhenzhong Duan wrote:
>>> When guest deletes PASID entries, QEMU will capture the pasid cache
>>> invalidation request, walk through pasid_cache_list in each passthrough
>>> device to find stale VTDACCELPASIDCacheEntry and delete them.
>>
>> As the comment to the last patch, I think this patch should handle both
>> update and removal of PASID entry.
>>
>>> This happen before the PASID entry addition, because a new added entry
>>> should never be removed.
>>
>> This is confusing. TBH. this order is not quite important as the current
>> implementation, we don't have multiple pasid entires share same cache
>> entry, so a given pasid entry, we either add new cache entry or
>> update/delete cache entry. So I would just drop this line.
> 
> OK, will remove it.
> 
> In fact, the order is for performance reason. Imaging there are lots of pasid entires
> in pasid_cache_list, we remove stale entries first, then in addition code when we
> loop on pasid_cache_list to see if a new pasid entry already exists, we can iterate
> less entries.

got it. you can mark it in the code.

> Thanks
> Zhenzhong
> 
>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_accel.c | 70
>> +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 70 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index 0acf3ae77f..5a956af916 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -16,6 +16,28 @@
>>>    #include "hw/pci/pci_bus.h"
>>>    #include "trace.h"
>>>
>>> +static inline int vtd_hiod_get_pe_from_pasid(VTDACCELPASIDCacheEntry
>> *vtd_pce,
>>> +                                             VTDPASIDEntry *pe)
>>> +{
>>> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>>> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
>>> +    uint32_t pasid = vtd_pce->pasid;
>>> +    VTDContextEntry ce;
>>> +    int ret;
>>> +
>>> +    if (!s->dmar_enabled || !s->root_scalable) {
>>> +        return -VTD_FR_RTADDR_INV_TTM;
>>> +    }
>>> +
>>> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
>>> +                                   vtd_hiod->devfn, &ce);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
>>> +}
>>> +
>>>    bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hiod,
>>>                              Error **errp)
>>>    {
>>> @@ -257,6 +279,52 @@ void
>> vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>>>                             vtd_flush_host_piotlb_locked, &piotlb_info);
>>>    }
>>>
>>> +static void vtd_pasid_cache_invalidate_one(VTDACCELPASIDCacheEntry
>> *vtd_pce,
>>> +                                           VTDPASIDCacheInfo *pc_info)
>>> +{
>>> +    VTDPASIDEntry pe;
>>> +    uint16_t did;
>>> +
>>> +    /*
>>> +     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI
>> require
>>> +     * DID check. If DID doesn't match the value in cache or memory, then
>>> +     * it's not a pasid entry we want to invalidate.
>>> +     */
>>> +    switch (pc_info->type) {
>>> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
>>> +        if (pc_info->pasid != vtd_pce->pasid) {
>>> +            return;
>>> +        }
>>> +        /* Fall through */
>>> +    case VTD_INV_DESC_PASIDC_G_DSI:
>>> +        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pe);
>>> +        if (pc_info->did != did) {
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    if (vtd_hiod_get_pe_from_pasid(vtd_pce, &pe)) {
>>> +        /*
>>> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
>>> +         * to be either all-zero or non-present. Either case means existing
>>> +         * pasid cache should be invalidated.
>>> +         */
>>> +        QLIST_REMOVE(vtd_pce, next);
>>> +        g_free(vtd_pce);
>>
>> call vtd_accel_update_pc() and vtd_accel_delete_pc() accordingly.
>>
>>> +    }
>>> +}
>>> +
>>> +/* Delete invalid pasid cache entry from pasid_cache_list */
>>> +static void vtd_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
>>> +                                       VTDPASIDCacheInfo *pc_info)
>>> +{
>>> +    VTDACCELPASIDCacheEntry *vtd_pce, *next;
>>> +
>>> +    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
>>> +        vtd_pasid_cache_invalidate_one(vtd_pce, pc_info);
>>> +    }
>>> +}
>>> +
>>>    static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>>>                                VTDPASIDEntry *pe)
>>>    {
>>> @@ -423,6 +491,8 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
>> VTDPASIDCacheInfo *pc_info)
>>>                                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>>>                continue;
>>>            }
>>> +
>>> +        vtd_pasid_cache_invalidate(vtd_hiod, pc_info);
>>>            vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
>>>        }
>>>    }
> 


