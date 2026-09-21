Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF7FC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Yig-0006pV-3c; Mon, 21 Sep 2026 03:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8Yie-0006pL-Ng
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:45:44 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.wang@intel.com>)
 id 1x8Yic-0006ON-Sf
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 03:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789976743; x=1821512743;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SHZ2oc10Q0rw9SdWQ+cIbZ9ECyTXlcJUNcmkOVy3+G0=;
 b=NucUsy8B1ItelamOHwdRt+/X5A3c+v4zERK/BJxHIVpvaPmtNKzaMSj5
 R/7yKe8aUXUQdoBFiNMAyh3OFsCaC67MnpF5InVtLMDdmokd/0Ynr1/F9
 hoN7s9WSrODaQekvbysvpQrT+nop+JLkGLWhd4RNVJRwmtuew4ISPCkoO
 Dlp0YRbBw0aHV4A8jhrg4j1oodWDvQqbRtEqfPLojGOoGLFV3rG1jSCFg
 gnM+gnWKvcwWImNAz4SAXFLiTTCzWUZAZG97vdXZTU5fWCr4an80v1vbC
 BS22OV2ujuPIDPWqKhKGEVWSXEqH+kIpJhNgNSGAzrkzMWm1xI5HEvE/T g==;
X-CSE-ConnectionGUID: sGdFqcNuT4uTccK7qpr/YA==
X-CSE-MsgGUID: eMGX3JjRQ22IBom8aJcdeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89609803"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="89609803"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 00:45:38 -0700
X-CSE-ConnectionGUID: pGpD/NjrRaKOeHwHnRybhQ==
X-CSE-MsgGUID: cSQqQUdeQ7iWNGodgHpb+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="272704486"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 00:45:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 00:45:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 00:45:37 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 00:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNX59Okc4AO/eFTf333dRFyJIjJ7OhC8oxInfGBkNDQlnsvAcXViNEPbdsPXRJUOWFG5P3yuYE6xQEKTkpxgRbqc0d+SOB1zN8JLpJt0v/ZAIGjH8OSCv4LDKMSJb/aB31LWwfB8nJLp45ChQwTWBjPT8oYlt6VA7DN/BErqP74a2nvFiQwlgHzK2i5vGmP5bXwx5ZYkitX6ByDrTSba4/AKQNAYWvnzR5OG2yCzPit1pRDXV1QGC01J0vWKGWr3kf23S1fjFwDcdI3Lk2eYjrHYmonjXxlPkUFTSaK0PR/NddfyeGxTBPsFuQdgkzrJjC4M2Z89KMsNF7hIwZbm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFDgDvLBBvHEFreyjCsF6r7QxtuCUGpGYn3edAwXGts=;
 b=ouRL8qWQMPsb8gclX87e6CT+9GncUt7yti2nR8sB/DTjbsvnDZo/T6+MqfL0l34/qpNtlsPQPepRyygwKMLfCH1fu/e2oUhtefiBtAtsOpcuL7GWBZj27dEUOtRko7FGosu0HjkQNv3kJ2fLrL9zHAYGAP633a8nFC4chndcfeLAK/40fjiv2g08UXrzByjA+6lzKdWxIakHScxDWdkreYOyXwjHFcCZBPKa0/Id7UIbbzgaHGZgb1NE50/h/DMWrdtqNtnatgj/w3+kMzTQMoIPoEgJ2O71UAkD8bGxJVm3xQeDag7sKEpic/E52Gpzr8lCdPMNG1plMm7s91gyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852) by IA3PR11MB379370.namprd11.prod.outlook.com
 (2603:10b6:208:61f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:45:35 +0000
Received: from SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d]) by SJ5PPFC295640A5.namprd11.prod.outlook.com
 ([fe80::80bb:e0b8:a9ae:716d%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 07:45:35 +0000
Message-ID: <bda5b602-29aa-4f93-b28d-fc37e967d59a@intel.com>
Date: Mon, 21 Sep 2026 15:45:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: Tomita Moeko <tomitamoeko@gmail.com>
CC: <qemu-devel@nongnu.org>, <alex@shazbot.org>, <clg@redhat.com>,
 <bosheng.xue@intel.com>, <junjie.cao@intel.com>
References: <e1c9833b-e534-4b02-831d-a22a25cc2a47@gmail.com>
 <20260915013037.648161-1-junjie.cao@intel.com>
 <948e2399-1c85-4b51-9964-892750f7ce68@gmail.com>
 <57ff9cf6-412b-4cbb-844e-d9d1b0efbe95@intel.com>
 <4999b79f-e5e2-4a20-a245-4784913fea1c@gmail.com>
Content-Language: en-US
From: "Wang, Yuan1" <yuan1.wang@intel.com>
In-Reply-To: <4999b79f-e5e2-4a20-a245-4784913fea1c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::6) To SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFC295640A5:EE_|IA3PR11MB379370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4909953e-043f-41d1-a798-08df17b451fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: XymrNUONXYkfPjroHw60FEE+t+C0E+3zCQovUAC3H0+1jY+ZiSve6wAAE6WjcdE7GCzDk8C00J3DrgP2EonjOfvhWkYrvIxtCM7pBEub2n5c23pX1YTVHkfYj5Ofc3+TsVNZDuQMegiZ58xxx6ro1zS8RP8ipYUWODmh2zUsCTYjOe0SzqbaOZs9enMcI/CTv9L3qM8OiVRDWvchfUdbtJj9+iS9SEC2rSSof3sZP6paDRYJyrgXYF/WqDTLKq2UZLAgPuGK4cMod7YXxnmm/pCFNBzr/TTH89ybOp940lhEn0zsgexOmQmml+DDQkvZNs2iSq2exuAo2QPBmmI6L0LIMWL5B58X7ta6RtplnIizoIshyVXEuKMqM96EAoAuHFPUVm8Bn6QJ+ty1tdXAdk4oz6XJ7sCxRx90ZwhL5PXcSGHK9AJ8NQz8b+WUF/CkatbdGJVpJxsJWtIvK5RBm5eiqUSQBgPOCanoE8jeyb6QWknQN7yHMdb3sfWO5oeh9WEY1KsYmZ+xtUBAqNW3Om5JPBOH0KUeO/cP2POYPcsJarpbclQMZihtlevQddOOosIXCp62zRK5ZkJtH16T9RUrucEr4Lp8yOulPBSBA5ccOrBCS79PNP+3th0eaXze6yLQ0xGjFzPZRaNgca5m/414BWYM2tVjDi4uClF3sos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFC295640A5.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGo3YTBUWGpQSTZsRVdrU2RLOHliU0F4S2JkKzRyY1JaSkh6KzZLajcyOVpt?=
 =?utf-8?B?anhlNSt2YVRhWDRaMHlXcDE1S2RHaDJSZ3VYeFdRMldDSVVEWUk0L3JadGZT?=
 =?utf-8?B?TC8zTUwzaGJHMDBDeER2djlDbGxVV0FDNmpwQ2liVlJhKy9oOVNkTElvZFg4?=
 =?utf-8?B?Tkc1N2ozZFZFMEZWMUEyTmVNblVYOEdLSFBvekI4RkkzbUViVDVPN3d3V2dL?=
 =?utf-8?B?cWFzcU53VHJKVkJ3WVBLanpFcFo3eG1tRUtEbUtHRWlIMkJjbVUxQzlLbk5T?=
 =?utf-8?B?ZTBKS00zMEtFa3BFMjlVNDNuNmRJZWlnMGhCT0xVYjU4MjIzM1B1aE9tT1RP?=
 =?utf-8?B?WHpjTjltdlhkL3RyTFNKNVVvZVdoMU41a3FUSHVxa1JjNGR1QkUzRVNyckZP?=
 =?utf-8?B?SGhXQ0tuWXcrcU9ObFZyZVdwdGZSWldGMXkvdVhOMm54SkJnTUVtTnljdTMx?=
 =?utf-8?B?QXNiRk9ObU1IMlhhSjRiL2lTcXdvaVNSekZFSXlnTHhlL3E2SlNFQndXQ1Vz?=
 =?utf-8?B?WUlyL0Z2RjFpcmJvaTNpNmo1dUx4WnBTWFlTSENEWWdTK09WanN0QnF1UUxP?=
 =?utf-8?B?V2RCVXJ5dnVKQTcydmVYcUF1ZExnQ2hncis1cjh2aklBS1BvbHY0OWowanNz?=
 =?utf-8?B?TlpxNm9tQ1duc2hFclFkT2V4VjZnbXdtdkIzeDVMYkMvZmZFd21FcEF4QWtP?=
 =?utf-8?B?NHFJTzZJSFNSYkY3c3FwRWhuQTBBN3hnaHc0cXNSZElvbjlUZmxBM3hQNzJV?=
 =?utf-8?B?NVgvSkZteU5VK2tPOFNYNmNZdytzd2NxY0szNFV1cVhENXJ0cTJ4OXFHWHIv?=
 =?utf-8?B?a3VCNVVOKzcxbTV3dWxUbEtxNjJVYndoNWlVVlpHSmpkSDQ4ZGJQMG5pMFBN?=
 =?utf-8?B?VnZIcUdEV21lSHlOVE5GamlEdkJKYTZWVzNiWGYwNWJTWlViQlhoblNZZGhN?=
 =?utf-8?B?eFo3VXpHbGEwZ082K3g3aXhFcEg0eHBwVXRzMVRqbllnYjAxbnhWem5mRlZ5?=
 =?utf-8?B?SEcvKzNvUTUzMkt4VFBTcHJWQWxxd1MyZGM4VWRORXpoSk50MThnZEVpendR?=
 =?utf-8?B?cGxha0VtQ1dWU2UrVHl0OWRaQnJXZUdXbkxvTkt5QUNjbTBwUGZnWHlWcktX?=
 =?utf-8?B?bWgrQ1ZMc1JHbHQ4MFRYZTVoMDBicUo2bnZnejFXS0ZnY1dGbjFBZllocTk5?=
 =?utf-8?B?QzJ2U0hQd0ZXVDJ5QmNHMVdCTVJ4NWdDOGVmYXFobFZvOVlFZmdTVVBVdFM1?=
 =?utf-8?B?c0tlSDVkalJlaVRXMWovRUw5bVJpTGluMHZBU2UzMnZ1aUhXanRUc0dScnVB?=
 =?utf-8?B?ZUI2NGVMaG1nQnZqN09qT1hRRkJyaDlhb1NhdE5FWlpoTzZwT3pnMkpFZllY?=
 =?utf-8?B?Zk1NS2RCOVhJTjcyR3FVUGVqUDQ1SE9pTFMwOHoxa09STTdoNncvRDMycmdF?=
 =?utf-8?B?WGZxR0tZSDlTT3ZKb2owZVdXb0FadXl0M3VzSnIrL0F5OXhubUxsTDNJUUV2?=
 =?utf-8?B?MHpxcmQxUDhxb1NuSGVYQnZnRkpWUm9ST1NhSDZLMUtXVVluSjZ0cGx1QVE1?=
 =?utf-8?B?WGZ4Rk1Xd1JzYnYwamNnS00wR2c2VzRYNHZHbWRpNzFYN2JoUEJBSVlmMHhV?=
 =?utf-8?B?Tm5VQnJhZEJ5ZkdWYy9QN3V1UWt0cGFDb1djVkZVR0VaRGs5eWc3bkR0NU9x?=
 =?utf-8?B?aVg2djI4RHB1Ym1haXNVelB2cGZtME83bzFwUngxUFI3bGtyV282RkN3Rmkx?=
 =?utf-8?B?c2FSL25hemtraTNDTEV6cjNQSTFTT2hMTmR4bXBoZEVmMkxsMTJrb0hzUy9L?=
 =?utf-8?B?Y3pUYjlGSG1yZGFHeTdweGozTlY2aVJheXpvWEkvQnZ5MXM0TVhnQkNnOGZ4?=
 =?utf-8?B?anlCb1pIV3JoRGhScVdIWldZUE1tTmU0QWpUMlgzZFpPeWNRZVVtSVJjSWZq?=
 =?utf-8?B?TlYwV2Jxbko2d21Rc0k2b2V1a1dRNlVGTldJTTZJVm94WWttMnV3WWZCcXl5?=
 =?utf-8?B?U045NXJISzFtVDlJYnBkbVdjbXNEc1BNaGJKOCttMTlTT3RvaEFmTjVVQlFV?=
 =?utf-8?B?SXZ5Y2VUVCtZM1pCN2VMMEdEN0x0MkJnSndvZmNRVzlFVW5zU29DNExibS83?=
 =?utf-8?B?Mm5UY0VXMEY2cDJIUGNobEdHY2F2SGVYMmhXOVhFM1RhZXFhZXNLMURjdFBL?=
 =?utf-8?B?Tit2V25UYTloSUZxSWx0QmJUS3JSbS9UT2pnVW4waTQyYUFWV3hWUzR0bkxp?=
 =?utf-8?B?eFBsL0J6R3krUVhLSHRvR05hRDltUnlyMStNa05DeUJHQ05HeTFaaXhERDJZ?=
 =?utf-8?B?clV2NkZNUTd0Z1ZoWVJuRld4NHYzVVB5L3BXNEY3RTc2WW5yUTJ1UT09?=
X-Exchange-RoutingPolicyChecked: N+XAyDOwL+0hVnvqVX+YBNVugZ+EUBeliq/rkyzTTBRlfUpHNGX2mlPo1t8X5CUGS8aKuOzZopeZyeGbQzA0EVOK3L7fCHc4nD07KkO0kOMqobae9k6pwuwWL3FAsXn9pm5HNlaANJiVa/mCGSPpPoaNS29S8KtbBk6/ckMth3JVFMbKcDrLH9wrSAlqYmbt5fD08NIZFWH3kQ4UQz6bWCQphKQIiqz8sXOI6A4bNLHux7/E8zWuDkpnn7eXnLaC6K1MEbFzjvTyIw2ZmlCzsXi1UHW8e0m5aR7pNc7zGnZ5fIH+wN2Ep8rae+uTuXuAN14z7wfOnzGcne2hadCvVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4909953e-043f-41d1-a798-08df17b451fd
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFC295640A5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:45:35.2507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NXjzkSS72HpfLBWN/Uo73D4CV6804uvpm+NGs682vKz/SfbPuTH0NgDKuNNpjUqSecGixOeURd1uhvAEqjZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB379370
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 9/18/2026 4:23 PM, Tomita Moeko wrote:
>>>>> Possibly an easier way is emulating MTL_PCODE_STOLEN_ACCESS(0x138914) to
>>>>> disallowed in QEMU, if the GOP driver code checks it, to enforce the access
>>>>> via BAR2 in guest.
>>>> 0x138914 reads 1 on the host and is not quirked, so a guest sees 1 too.
>>>> Returning 0 there is a small addition and covers a GOP that checks it;
>>>> the DSMBASE quirk covers one that does not.  On the Wa itself: i915
>>>> already takes the BAR path in guests (i915_run_as_guest() short-circuits
>>>> i915_direct_stolen_access()), so that path has upstream precedent; we
>>>> have not measured whether the hang reproduces there.
>>>>
>>> Quirking 0x138914 prevents driver applying that WA, but we are not sure
>>> if driver checks it before WA. While hooking read to 0x1080C0 fakes the
>>> DSMBASE to (BAR2 + 8M) in guest address space. Both tries to enforce
>>> guest accesses to DSM via BAR2. I personally prefers hooking 0x1080C0
>>> as it's driver-independent.
>> By some internal sync with Junjie and Bosheng, we plan to quirk 0x138914 as you point
>>
>> before. We have checked the GOP code, it always checks the 0x138914 first to determine
>>
>> the address it used.  If you think it is ok, we will raise a V3 patch based on it.
> Sure please proceed with that.

Thanks everyone for the valuable feedback on v2!

I have addressed the comments and sent out the v3 patch series in a new thread for review.

Looking forward to your feedback there.

Best regards,
Yuan


