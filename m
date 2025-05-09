Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF328C3ABCB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 02:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDDdq-0000g1-0x; Thu, 08 May 2025 22:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1uDDdn-0000bA-7v
 for qemu-devel@nongnu.org; Thu, 08 May 2025 22:39:11 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1uDDdl-0003nS-Co
 for qemu-devel@nongnu.org; Thu, 08 May 2025 22:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746758349; x=1778294349;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9ZscjTud0qkq06aAe+ogm64z/FCrebK0FAruWsMRFd0=;
 b=Y1ho/oN2lRC5yr8ZFg2nUmBpQnElpc00Xw9yCcPTgkZ00k8LDla/Kbfk
 LV0MSU03hRRFm/rBxEK5xH6ORMFUztgkKtE+wJVYR5NkYRx8tDhIRIena
 4w8aw/WIhPWlnplnU7xmR7p1s0+oHb4ywjFxZAm5Nz8JMsw1RIFAFUjs9
 pp+sBpQ6CXb8HqlgLHMl4KSvl4t4Os4CK/3hUF4e5UE6C/YTAC8ZP1b+Y
 1420B196pBEhRwMHl013UMPfglrYRxnnNSzjTNYtsMt3pyE6tkW/pjGJJ
 M8iAK67+6T++MK8pakMM0M4f8o5nT91GBme5YiGP+RrN+B+9NTPxpMhAh A==;
X-CSE-ConnectionGUID: +BPMwpZYSHGKmHtIzocTYg==
X-CSE-MsgGUID: E6WbFO0cRdqyBrI5qV+1bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66104233"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="66104233"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 19:39:05 -0700
X-CSE-ConnectionGUID: NzrWAadoQ+Ku1NIfV0+SGQ==
X-CSE-MsgGUID: DHjlQbddTMeYUt/vfDZrjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136437913"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 19:39:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 19:39:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 19:39:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 19:39:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQfNK49I0aDfwIQ1CAlyx40h10q6vfZ3b5n9EEOhJs1xYo2o+8k1TcBm0RovJREBdGtWht17EvZqBBvDJi4gpYddjQXjzx0wCOROefgLFFJiZo7xnjn02G/qYsYItws/mYnTDIxHGYTUkznSExXyA4GeRVoI4UkHLUXR+dhKCnIuWFThmJg4bUQap/TmS3bplQbY4udG+MI+PU6tuTQcoErfMYrcWKurw0BTaDBO95F+5CzjQr1AsUFa0kXXQGEllWVdRtgCi5Qe7+lED2v4eV4aUFFP8S26md8IOZf8m+bk6amPHi1am667ZJFR+jlTbKzqFer+Q9QMDG2/CU81rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZscjTud0qkq06aAe+ogm64z/FCrebK0FAruWsMRFd0=;
 b=bIV1ReHMUPF6aoYxU1dKMdWKf39H2ikzI3sYnFcSNNaNtScbPQLIhB8YMxZ78RMshlxRv6y2NyWR3CYPNPKrWBdgi+GZ83E9/Mhvw/XXVCNtufzOx1zPJg+KRTVTyzZQFuIhq9xSgaxVTryX23noCjOYdQRO/CW+q3zD1feGW7c5hL6q3pL3ZSna44v/ut7nHa4gqHM+vUTt1siIkPNSU4sgBl1XCNYnrrnKMENj5p9usIo4/enT4B70eKhqYrJzpKGdRW+QnhwAX71EgFdv6PJnQGJz6ZlR6rUY1Ouddel1uKVSOVudzkGMd6AJUtae0gZ1oxqu5rUXzEQ7Gpaviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 02:38:43 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.8699.019; Fri, 9 May 2025
 02:38:43 +0000
Date: Fri, 9 May 2025 10:38:33 +0800
From: Chao Gao <chao.gao@intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
CC: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 10/13] memory: Change NotifyStateClear() definition to
 return the result
Message-ID: <aB1qqUGEayKbkL+2@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-11-chenyi.qiang@intel.com>
 <c7ee2562-5f66-44ed-b31f-db06916d3d7b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c7ee2562-5f66-44ed-b31f-db06916d3d7b@intel.com>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: c31ece39-00b6-45fb-7cb6-08dd8ea29d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WFC1BwwFvfZx/KyAh/UQhEQtN6zsqFPS+AEz1nIab2BOe2n/1lJ71HvsTMHG?=
 =?us-ascii?Q?3jSsauv7b5vRAqjcjqF+lydNRzmPyXYzdrwrdwY0uRlP2RzzLm05nZ7WnNCS?=
 =?us-ascii?Q?G0ZB4TUirF2ZyOO8FTovBlw2DKSJhUnhkpL0vOC7nhuKGq7bo9eSWmNT+6T0?=
 =?us-ascii?Q?TtwsOY9ACp/UTOOgJz9xGK1MeOlBOPmb61G2Eyhx0BgEojsda8mtZaQ1m31S?=
 =?us-ascii?Q?kMrU25wiQU3m2TeJnQjfeu2RY1fDFSxDDKIpcv7r4PbFmTGoTzd/rLOFXmFb?=
 =?us-ascii?Q?DBLHdbuFNkCiHLNz1iSaneleq2HjBWSh73363/m6Nezq0arxlEhDPDK0Ppmb?=
 =?us-ascii?Q?SX757UJo3u81xrWnW7opzhSdNqjboYLMJL9YKNh5sqFwxI3o13CA9cyZaREL?=
 =?us-ascii?Q?BKzo9deXAPdSTSI2r8llmIGRWCj9Zue8/bf5y0fWyExpqMd40LMS844Eui5j?=
 =?us-ascii?Q?S28V54nF3pWJ2yl/sudXYBQ6GCje40TnJ/V2IYuM6Kams5KS2fDwi2S8vJF2?=
 =?us-ascii?Q?oTXtnt2znZBZcIGcUnzbtCipf2Wd31bnnxU+lvNAkJS+qD3DsBw8OStXAtWQ?=
 =?us-ascii?Q?FxOXYtGWiVyATrLoSqQlefw8hqHoicMqNEwqAfcNMATsl6wx0D8tMgspmfiM?=
 =?us-ascii?Q?jR3TwoC8VMdIzS3oCLDM/Syf295Gr1lIAWBSekPUDnOmV7VtsdEcy5Vp5pnk?=
 =?us-ascii?Q?5VcZE1xXS48iiWLiqZ6xpxoCXTZbObcYgM2v+O8wRZV350lZ4E7++G2BsT9X?=
 =?us-ascii?Q?MhK9KJd0HRzIp6iA1b+2TVhQ4W0b2FvBnGtJ0liu00aFyUIDmwYxbY6fs6ag?=
 =?us-ascii?Q?621GrHUKa8HTM/f8gSbJt7N0AwDwjNv+0l+7tBq1MwBtP5YMkrn/O2TsojIy?=
 =?us-ascii?Q?g1QqpmWYzdax/JA3eBe6ZgwmElJNxBj9S7NefHnPCnTIHAWGl8LjlrhMq17l?=
 =?us-ascii?Q?l9/n7iFAHClZczO1v+1mGb3lWXZ90mUG2o+L0dP5Fh0szMOiYyWPRb8byC71?=
 =?us-ascii?Q?zU1WGQfs8T6k0y2gPFl9HJxH6COLt2dV36Ly6G3Hr6LP/Lr5rNZSt5HSOPHP?=
 =?us-ascii?Q?126EOzW1B/KTSOOUVtRpuewfHAEFI+ofBvQ7+8EwW9ru9Td5b0lEzs96UwYa?=
 =?us-ascii?Q?/NU6cdZRaQ0DuSORhBbYMkfuvlE1rbgxHH5W7BKbEtgp8bvgWQPGkcjmTLbU?=
 =?us-ascii?Q?S4Al3SxPBOvdwwC1Fh8dmFPpe24cPpeK882+ho87/J9svGL1vG5q4uHx+QaH?=
 =?us-ascii?Q?jQ3SeqAAq9kemR+6SeGY9oeL2evXRECuI5Uyhr/dkNBQO/Lk+WfK9X1TWEsj?=
 =?us-ascii?Q?fhJBXof/1W0VbMChGvGJcwjBT/H+DiNvbdAYJylfBAPfZqBt0zDNzWImEHPj?=
 =?us-ascii?Q?23dIvFlSRDxmQKHIE4s2tEElcHzmiwFCnKYv/df8BJqkCHGE57W5kUYUKINi?=
 =?us-ascii?Q?VQ/5nhxxl9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8660.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r6HEEqIWiHESVaAD8qELJBueyw6Nl8hoMTypbH7b1zlA2DIMAPGuY4ac8cR4?=
 =?us-ascii?Q?E8of6VgjzQozE3vZqBTQL0HkyUJPMHQau1n95YSgP9JWVj2pgDzm0Z5eCpCv?=
 =?us-ascii?Q?Sdjl7dyzHKKFgxlRmgHEOVNdplFfKs08ctDzrw9KfMswUO3glyaR+Wq1B9Z9?=
 =?us-ascii?Q?RSvoQvqWx0O+k5FnZW4O/VkPeqd2wNUmpbs/P2uxNIxaq+PKMnOMspjHKS1c?=
 =?us-ascii?Q?wbea6n0RhdyRKpryfvPJgozqREwqoOElI0cQqX/bgI/CeiWdRfleW7NYQat7?=
 =?us-ascii?Q?Kvt35LyVxClxhzTifGVN7t6wBt+rKLzIDIxuJycBiBvINdJS99tVo7M4Y2e5?=
 =?us-ascii?Q?eQ8tdYjxQSj9lr/3pwN88iR2oLjAfWkCO4NNqL2KTKhI+nYo4A+Sc9+C0AWP?=
 =?us-ascii?Q?Pf9Hjs2uqaEQjXY2yALffe9cx2DdiX7xvJZeWxMhVHtC9nSVJ78vok5eLq3q?=
 =?us-ascii?Q?T2LQdn1R4hJpXq1stER2V+KZ36Dab+Qzqz0kKZgtcAKqAIB/ebC8dwb45mUO?=
 =?us-ascii?Q?X57vntQETjrK8ks2TT5bpr/57m60DjSgxyWLU/SF70+amQNFU0Nx3u7rrQuf?=
 =?us-ascii?Q?dYv3b1Y+lKkHmPODucBuwyKDLXTteMV+za6Fg+1Gw8WTatClq148HZd/Tk6E?=
 =?us-ascii?Q?IK0SQ7ds2FDzXv+xG/dZuVNGb5hAiYrkU30/p0zxWPgMmGCTtbQyQS8cJuUh?=
 =?us-ascii?Q?LaBsPZ48hsIKrIxxRhe6RKEDgFtjzFXJZE4dzdcBV7kP3RY/hO+DpKKyFo8y?=
 =?us-ascii?Q?bjzpvmFJFsu9bBGcbh/qibpIonw64xBVP9X4C9mwXiyMZfCWMe3tMxXA54SS?=
 =?us-ascii?Q?tnzQntSt+6sxNLKxL5XJbTR7nqFPwoxkyq3XZfHVlkiBO6EDnYIgI5SR5pXp?=
 =?us-ascii?Q?ztq9L2v/n07crERek6b7PVfFcyUcpZRBqm7uhVxzNSEEGVIRAV6YeC6KNwAG?=
 =?us-ascii?Q?J5CJAb4dLhdgNk96SlaQIv02z8HJIqT69Zlev+VRHqoKKmaE21Q15qx/k3mV?=
 =?us-ascii?Q?mvtQeNQ5k55ju/0TbUGvdwyG6uTtwdOCXFQnrxQhRk9L2z/yu7D6qWTFgxii?=
 =?us-ascii?Q?DpkQbRO6sdzAUH2rRsMQyCegvtjhhXD8RypqLYji8eKXGaGBOk9MS4XGvGVX?=
 =?us-ascii?Q?LtmbGZhUjALvQqNycCiqMMmgo0hbxdJKZe7VQ37w1yi741DpL1aask7BoJBp?=
 =?us-ascii?Q?asvEjFkJG5GQctRLjaDXQOEDMRcbteK0zE3Xw7oqWjxuCnxlHbpTXOzB2PsE?=
 =?us-ascii?Q?dBkczY3u8UpQtx84z6+J+q0np89pxolMZlx0A+cZmbZS6PVMrpji8mKpzBol?=
 =?us-ascii?Q?kfcEGHqMTg6izmzgJktNlJFmOzONUxmn/SriRuXwm7nifSKnVbSYRDv74dGf?=
 =?us-ascii?Q?mHcgHJdTNieI/ZQuDqGS/0kiYJ/ZRnn3fwm7lAoTvXgVjL3QFiVAsVLo1/tA?=
 =?us-ascii?Q?AzPnmX5Ugqe1cWOI+Q4mKD+20YOLb9vK1rwbDvoo6Z6ER+FHdx03TyO/X94W?=
 =?us-ascii?Q?rHRotXIpmGgfHRoKMQ5zz/mcRgJJNyYBN//784tVvlHEKQb2frH35WGEhl+R?=
 =?us-ascii?Q?oCXgeBDd/vxz7JfbstkMaeTkT8TSmM9uxyFvM4QW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c31ece39-00b6-45fb-7cb6-08dd8ea29d54
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 02:38:43.6418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAKc5YIVg9iwtlJsxpSghrqBrZXtT4JJ8J4zM8XEbByPRV7GQDoHXciE18RNZUaGV+/hqihYEzVS96Ky9IG+8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=chao.gao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Sun, Apr 27, 2025 at 10:26:52AM +0800, Chenyi Qiang wrote:
>Hi David,
>
>Any thought on patch 10-12, which is to move the change attribute into a
>priority listener. A problem is how to handle the error handling of
>private_to_shared failure. Previously, we thought it would never be able
>to fail, but right now, it is possible in corner cases (e.g. -ENOMEM) in
>set_attribute_private(). At present, I simply raise an assert instead of
>adding any rollback work (see patch 11).

I took a look at patches 10-12, and here are my thoughts:

Moving the change attribute into a priority listener seems sensible. It can
ensure the correct order between setting memory attributes and VFIO's DMA
map/unmap operations, and it can also simplify rollbacks. Since
MemoryListener already uses a priority-based list, it should be a good fit
for page conversion listeners.

Regarding error handling, -ENOMEM won't occur during page conversion
because the attribute xarray on the KVM side is populated earlier when QEMU
calls kvm_set_phys_mem() -> kvm_set_memory_attributes_private(). Other
errors, such as -EINVAL and -EFAULT, are unlikely to occur unless there is
a bug in QEMU. So, the assertion is appropriate for now. And, since any
failure in page conversion currently leads to QEMU quit (as seen in
kvm_cpu_exec() -> kvm_convert_memory()), implementing a complex rollback in
this case doesn't add value and merely adds code that is difficult to test.

Let's see what others think.

