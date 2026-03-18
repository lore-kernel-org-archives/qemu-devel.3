Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E614B103E168
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2plU-0003fJ-5O; Wed, 18 Mar 2026 08:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2plR-0003es-Ad
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:12:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2plO-00085a-RF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773835959; x=1805371959;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RMECA+UBxqE1+dmTbrF5KkHt5qsaNOaeSremNbNz4uI=;
 b=Rq5ipNIaHFDZ2n1YpuaUgUA9R+LqsZRTfTWLBv7EldgooABEaq2M7LIX
 ma4FFR0cGgXZNZBKsEkAAvSTk6YWJUjAp9PRoodERZOu798FlFXh4JW80
 otGHVrqY7aoi13NxDiv5AdQO3kREz7/+N7I2UeA0eO0t7f1R44N+cYj7u
 ZJfJ59uaPai3/GeFScv9uLKk3W8jRrJuB1a9EGs6A7RQSBAny9uyyejIh
 1oveT1QZNf+lOSQSIvqBic0izcJ0EdUNFDDZcoLbTBOhjJPkx/i9Q8P+d
 NPPaHUm1EJml/P+aV0cJVghcqXvg/kdPaBnO2sJkVkW958GZyiNYugxA4 A==;
X-CSE-ConnectionGUID: DSkoMtYES4WQ2VVNo9t0fQ==
X-CSE-MsgGUID: 9ejS2lk0T/Kz8YHYKeoi8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92268836"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="92268836"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:12:36 -0700
X-CSE-ConnectionGUID: g9vt+T4ITeKG0xK+jfAwpQ==
X-CSE-MsgGUID: n+JpgnJWTd69TsXLHMPGeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="219650773"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:12:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:12:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:12:34 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:12:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJa7E+BRqj3btut6DUT18dY6HVefuIQZjeagKdl33p1KGFwls5tZnxhsgVVMdAO2IcWtN5bn3OifNoQy2q/AWZBNHPqKe2hv4vRG0cw3sSd6EA9q2FYNQC62lucZP1wlISeFpq8KYoHk0EPdzM9uNHSvghbFz+x1BvWXcbRbD2VY4bkNe1RwNoIFPUdwOSYewuVMsHPSXNc3TBqFlX6txrz0IPUcdVqHOluIoNHUbwuZrnLZjnybqMLKlxXtPh9/tzhZpitDqq5GQAnidNok+I8AdmGDKotIZk0x/ILm3/TeJKki8pwKxrna2QKMYZhpO21n0O9j6KQ1nTqRwLjDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPmxZGhWfMd0mQD9VtoQTZt67ozmI9R11nw5BunV/Ys=;
 b=lKaKG+Sz27PijM3bkO/Z51tKDz5UgZVljil4BrWjsY6m6ZbLS+Jsc1gZ82Ob57pzV3wasBM6cqnB2tbH6tOPqvv3t5FD2MGOD+Yqc6sRB2nz2FMKElNTHuyWyETJK0LjPn+e+gaP5N2w+DrQCu6+hvBT7y5nNuM/kh5jq5OixpOMVJ0wislMpxnz04Ztwf6ccapIwZ3VSSpp006qx1m7hBj6wOPzi3cdwZu3C9dYnlVXk55R5l2SgB8RSkeEvISqmFHy9N2yR/4AFYC4tx7+Esz9B72Hrb6iyzjtoxIoKORmA3PzmpFcgGTFA5ssObbsuIyMGiX9EZaQstiwyR9AsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 12:12:33 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:12:32 +0000
Message-ID: <4b0c92ff-54d9-4383-859f-169a5735de9d@intel.com>
Date: Wed, 18 Mar 2026 20:20:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/13] intel_iommu: Change pasid property from bool to
 uint8
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 50365fb0-d591-4430-78a4-08de84e7a1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|42112799006|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vWZrxVa1fy3tt3jAQS8KlRqS/2ZZ0R39V9f3tova+23xc2zoxvXzAA2M4clydO1b4urqfA3dirq8HmMbtxSGJaypH3RayKYf5RSs+G6Tn2//rPgddVIwLRTk2aUHpN0G84Rj0WnxpWt4wozqWM/2Ws8Qxqcek8kZcmlgRhOyrIWNb9Y5ElFEACEzcQfo/mIo4nOHXa4Ib8DXyoyCkINsVrtyydlyF6mQHoP/Nb79egu1p7sZ0oesGfRN9EJetorzU7jdj7tA7c0ws3HSJMff3jAZgJmrzZhooc7AwMg+y1m45+aOs7kR9BWBkSzZNvXdDWVSM9FgzBIKB55zEhPionMyRNBCK29c9DSiP4Nur0KCpU6groreSVc2RJyxwUNzAB9RceXhfUL7sOLRYEiewHQt4ZK+b823+5I318KldWUDdNGgE2DhxPbYHlb+Dac5ZqpiJXtLcIUpoPXfWGWj713UqjRj8VCqfpKJU+h4adnh7XFNe5HPzcwX7Dl+sMXcqMvhgVKjOwpXEq8znw8U8AoQ99R3pXFqpf74XIONQWP5xxhwO0TJAW4ao8henSqgF0REgWaOfalkvLZA3ucRFDZ3ohzAkSrckqhkr3X3YjejcNtuEmEddDFZet6JIVgMEybDXyloGP01jMANQgumlMAtVfXgjOO939L2of6dnzktABWJrhxm9s6BWSUZxw3H70/Vvd8gthk6s+f9WmjdgBbEm64T1XhED0aKLb2Uw08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(42112799006)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkltVVE4N3FFbFY1NzRvWjEwNHhsaXVWaHB0VENPVjdKaUh0a2sweUE2dHFr?=
 =?utf-8?B?T3Q0cWJYR0xWY1VHem5tUFVIZWVldTRVVkgxb29JdmFGM0wwUUovb0ZMRzZP?=
 =?utf-8?B?MVBER2pJTkd2RC9NaHhoQnJzT0hqcUFhWUFLaUxrQ0dPNmYxVGN3ZHYxSVQv?=
 =?utf-8?B?Vk1UdTI1dVBXZlBwbmRyT3RUcUVNam5sdThDOExZZlhua1kyWVJFQWM3SUZ0?=
 =?utf-8?B?bDMwS2owWFMxK3ZFcWtTTEhWR0tBZ1BydFRSZFFlaStDVFpDWE1IUk9RNGhD?=
 =?utf-8?B?MWJ2ZDcwRVBVaHJVYWVXVVBXdVFRY0VMcmJKWlJCY1VWenFMTGNUa25ueFlv?=
 =?utf-8?B?dzlvQ1lNYlJhZHg3eGNTaXJxM0RMQksrc0FRdmhrUlIyNmNrQVB6K3RFNFNL?=
 =?utf-8?B?MGJYQVRyZDVDczNDSVc1bnlOSFRBWEVlcldrVDQ0OTR5bFVjSlZEY3RVNGYx?=
 =?utf-8?B?MHhxK0FGZEx1emFjaTE3a2wyY1ZiT1cwZFkxR1pZemdNVWFpK2trVXRRY0pw?=
 =?utf-8?B?QmJIWjJTQ2pZSkRBcFlrU0lJZ0VDQ1Rla21IdGZyV0daY0YwV2hXYlNIRDlI?=
 =?utf-8?B?VXMvQWZxanFXeTdVeVY0UUx2UmJ0eE9VQWtSalNqN01HVnMrTGFNSTd3eFJO?=
 =?utf-8?B?a0huMkVsVU51b09lZU1aUDRpQkFtWG11SE4wVUZpL244Z0M4Zk1JWHFDQUJ1?=
 =?utf-8?B?eTJqRVlmWUNUbXhjVWlxK2xqMkdUelorOVdxbVU2anlIbkVYKzBBRW1MNjhX?=
 =?utf-8?B?UUVvSk9ESjNJbGN2c1hMZzZvWGkrTjVJZWNTSjg1Y3lqdENNbklOS25yLzF4?=
 =?utf-8?B?VUZ1TEhCS1RBQVh2OXEyMDMvNEFRSkEvamFaYWxlZVV2WklaMnRNK3p1MXZu?=
 =?utf-8?B?QkR3YmhJdUlWV3dSUTdXenhUR3VnVS8vSmRiWFlSemV3TmRWQnQ2Q2xXM3Jh?=
 =?utf-8?B?NkRtekp4OXF4Ymc2N0UvL1l2bnhqZVd3NHlTN2NuNTdRcEdtbGZxajZFdjN6?=
 =?utf-8?B?RnV0aERlb3BKVGh5Kzl1SkdMdFhrS1RhMFFGWFdNNkFCUHNYSUptSzhZMUJQ?=
 =?utf-8?B?SG5KUnRZdlJMLzBQNUJ2ZFh2QzlTa2dueTA4dmdNRUZKZThwRTYyWlFDVC9N?=
 =?utf-8?B?MDJzR2RXeHM3emNKZkJYL1c1RUNlNXA2YWN5Si9wdjl0QUN5eFB5OGtHMXNx?=
 =?utf-8?B?bFJSZmgya3BGcy9TdjliY1hDSUdMWE1xUFBOTHc2T0EwN3lveWRUWmhGcXRR?=
 =?utf-8?B?V2ljZTZ6THF5MTd4Y0VobEhLZlI4VlNRL2d1Ky9HZUZFaWZlQ25hSndsdVl4?=
 =?utf-8?B?UjVBenhUaXJIR053YVpKU1FxbDNDOTNpN0RiSE11MlVGcFJDZk8xUEFvbXZt?=
 =?utf-8?B?VmdkYVNTUWZlNWZDYlo2MWlweE9pdDhQeEhDYlZwSmxQT2ZmVW41MTB0c1E1?=
 =?utf-8?B?cFd4U0x2MGMwb3I5dXRmRzJqN0lEbEhxc21vTEU3SWdhT3gxM3MrS2FHVlVY?=
 =?utf-8?B?TGowQThxNnZJeEJCVFA2UjhEL1YrNDlMZ0R2WUVGNlZ5V3VjNFdLSCtIRFQ3?=
 =?utf-8?B?WHBDLy8yUDdJQmFQVU9XZDBkNk51bDNRTkJHZ3Jya25hVVJTRVpDcW5sV3ov?=
 =?utf-8?B?c1hpMjY2Q0JOSG9OMXYveHdpZUxpbCs5Zm9tdUtVZ1FsTEVEQTVoNHlSbjBL?=
 =?utf-8?B?WWJVL1YySC9vdFVRb3BBaUR5UVlvRUZxVVBVK3cweFJrUk5SaCt4Z1J0Q3pT?=
 =?utf-8?B?S2NrNzAvb0tBa0ZuM0NEcThFU2NsODg5OEJweEpPK2RWaG1CT0U0b0FqNWJC?=
 =?utf-8?B?UW9zQ2MvUW1VUUFzRS9ZRU9WdDUrbkVBZkFpcTlPMElqdDk3c2NacEQ2dlB3?=
 =?utf-8?B?U3N1Z25LNURGekp4U1JHK2puT0gwcU93ZEg1d21ySFpDQkFRd0x2Q3lxVDFM?=
 =?utf-8?B?MktIU1k2Vndncnp4YndZeStFQU8xbFlNdHY3cGRWSHh3Lys4cFFOak5waTMy?=
 =?utf-8?B?Z1VFUVJ5VXJzTnVFa0MvTzhQNW5jSjJMUyt6MTd5bkZRS3NWTmdMNWJQNFV4?=
 =?utf-8?B?WmVIM0lXcll2clhBOTIraHh6d1JuSmpWanRuczkyd2tOWndJWHhuTElGdFZC?=
 =?utf-8?B?d3RybDh4U2pXeDBnYWN3N1hOa2UyZHJNbzBWUTVWSS9wZ2tIWkJlK1V4YktP?=
 =?utf-8?B?aFF4QnpaU3FzVXNKVE5FakNHd09EV3BtMFZ4VjNrWWxGM2R2R3VBdGtyRDJF?=
 =?utf-8?B?eFJxV3kxSUVHWitxSVFLS1NpNENuZGluTHVhcldvSDlTUUxVMVNKa1ZZL1Fs?=
 =?utf-8?B?UWFNWEdnQ015dlFLSnVFRm1hNUlJZVU4UVlHR2NMY3V1WjZGbTdydz09?=
X-Exchange-RoutingPolicyChecked: JnxUoVCUeAZa6In5M9+lYn1R+yHrhu9RoQMndKRi1wvn+PEWzqIhnF+6EJEJ8cdUgYOmhJfPmm2jiSoAE6uAyEiLyNGEB1/HICYy/F7HTGXnzCqiZfwAhBeU0JympIZyiyxoTTYpo+LuEiQTGEv95wTvy9LkTVnLjRWMZcpPqqI8X/GBm3A912/PeGddIWOqY1PmQD4/GxrNs7vBdzol81+/cv2k27E1Ght2ziQQx0nL3cr2f536q+CMtJH6vO8S3/k7vHsG1ljyB3cd4FG4Wr5LAwDBxXgne2HEdCgAJ0zCPITsk/za2cwLh+W46cuzFXa1678vl21OSB1dMqKA1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50365fb0-d591-4430-78a4-08de84e7a1f0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:12:32.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTgpE1kdFnuSHRUjuv0XeGaC41NlwQITTwlarBqkgfC3Z5jny2Jkz5kVWIlDCn1zoXl0JerDdx2FaM3f54GHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/6/26 11:43, Zhenzhong Duan wrote:
> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
> represent PASID size supported. Because there is no any device in QEMU
> supporting pasid capability yet, no guest could use the pasid feature
> until now, 'x-pasid-mode' takes no effect.
> 
> So instead of an extra 'pss' property we can use a single 'pasid'
> property of uint8 type to represent if pasid is supported and the PASID
> bits size. A value of N > 0 means pasid is supported and N - 1 is the
> value in PSS field in ECAP register.
> 

should we keep the "x-" prefix since this is new pasid support?

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 2 +-
>   include/hw/i386/intel_iommu.h  | 2 +-
>   hw/i386/intel_iommu.c          | 5 +++--
>   3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 11a53aa369..db4f186a3e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,7 +195,7 @@
>   #define VTD_ECAP_MHMV               (15ULL << 20)
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_NWFS               (1ULL << 33)
> -#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
> +#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_PDS                (1ULL << 42)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 54c2b6b77a..bb957b93e0 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -315,7 +315,7 @@ struct IntelIOMMUState {
>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>       uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
>       bool dma_drain;                 /* Whether DMA r/w draining enabled */
> -    bool pasid;                     /* Whether to support PASID */
> +    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
>       bool fs1gp;                     /* First Stage 1-GByte Page Support */
>   
>       /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d24ba989bf..e5b9689fae 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>       DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> -    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> +    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>       DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
> @@ -5046,7 +5046,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       }
>   
>       if (s->pasid) {
> -        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
> +        VTD_ECAP_SET_PSS(s, s->pasid - 1);
> +        s->ecap |= VTD_ECAP_PASID;
>       }
>   }
>   


