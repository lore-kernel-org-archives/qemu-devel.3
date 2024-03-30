Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37A5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 01:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqNrc-000604-JU; Fri, 29 Mar 2024 21:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rqNrY-0005zd-ME
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 21:50:28 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rqNrW-0000O0-JY
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 21:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711763427; x=1743299427;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7VrQDCQyES68IR+lqCz4l6Rps4EUv79mT2Nxejg8D3E=;
 b=CrsVxKHF4xSZWxUCVzFEB3msygfNrq/YKSp186z2NUEeCNnAEi4d5cX3
 UP0rXCvjKbM+jURECVPO1/i3dYYshjW2Foj1QzsnXNlAWqeEyw65ULlUx
 Woe30UM4dX3PAgYcdhown0/tPjdiM7jF+KuCTG3cYYEsFaK5Ij6auei3T
 E+g6QMLBBzhLu19u3f950Wxp/PucbDP0gG/smArmCWoPOE/AszGqtYAD+
 aabaOWnLt+7IGxyRIGOUw8Xe/6bzAaMgiyrGwK94SDf+DAN+HAovGN/pT
 FH9GeRpSsqqAPmZCf2IvVLJsyJY6PxSKcKbP6jMVij1kuvJ8fmu/mW76n g==;
X-CSE-ConnectionGUID: x67aIYZxQHe/EvCltaOdBw==
X-CSE-MsgGUID: 5cBYXk5IT6KX6RInPzBVkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17514104"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; d="scan'208";a="17514104"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 18:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; d="scan'208";a="21836547"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Mar 2024 18:50:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:50:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:50:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 18:50:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dctFRrAQi+2NXH1pFFQafhze9WWlQ7I72hrZbU1KFvydEj8pTbkueL4lMIYpVBVUz9qQELu9nw8zslUJq/X7Ilci3fnNwl62YE6QHVOyU9c6ieM6FfO2PCAdYMBHOkBtruUc3kxVrk5WQdcqT5jTO+QGDhRp4pOTGhWQvyYnRQdPNxPVduG4SBthDS2Lt60tlgUxpoTs0fAwXcS18mUHtA+yuADb8kLS7plWTDRFmrS6te3sGfmDVQAkSX6D4Dxk7UbmLq9vfexAMCQeKEk5XvMVGMlNfBZFtoqeL9qfKTvtMhjW3vdq0xYuqwCYPC63A6DqmtpHHCoj3btDS66kQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axPRD5bCI0/pMoTea3/Hh670yEqxPiDo2inDAcg2mh8=;
 b=GAjYZ0HtlW0EFwuLOLpGnk5wa9RvhKa8jvbuL/m2HOzS6f5I4w9Jlsk9bT3W1oNp1SspOh8mFf91pM6haZyivOQ8FTCY74Xmihf0YAel/ywOt43eJxumWt/BgsJh65HYvJ4axrkd4pWjPg0D27n/aRK4GKwqOUA0yg4+F22BqrBg3bz2gDx0T57kgzsUCo9s9D6X3Ix331zDev3vwhIPxQTHkXUmWJDuQvGQ9FY2+wPW1xU0Z2MK8j7kKPQwUMC62p7Dac+9yN0AAFMXOOQleSS2VPumPZI5ba3lflF7axquw4vt+gwpc90rG7OfIzuz5dNAH0fch7lNDrpcCuEB6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Sat, 30 Mar
 2024 01:50:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 01:50:19 +0000
Date: Fri, 29 Mar 2024 18:50:17 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
 <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 3/6] cxl/core: add report option for
 cxl_mem_get_poison()
Message-ID: <66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5186:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NicHIcoW61yI5mj0Mtr623kroMZsMxsMnCRaxkHO2YVrrDiJQrNU8XOXAr9tSGbVNHkJ8OiKaVbmHqjfqQ2GKLVeMQKu/DFyVE2OKkieIEXBj+Pm2+Sh/HBGetdeJbP7AtPoDdADSL8uQN+rkfutAZQ01JaOgHaEcDlR4kpq7pYTFbUbwZjWFct8j5j1ae4jvyGKI4rdqx1EhbyerSTiZRsBQRniNeX2AWmRjE6Dosuj26RzkSfy+NA4cy+pee0wrU0kYV3vbdyqQTGjRCTZqC3a0SQNp6xgNQkuWroswgHKx1Fh51QjAltYr636ke+LzI31p2beyJGG6E8v0kSHrTUZ3AMwECwn0g792zLgZz4ebdX4KHpRWNkI9Pkuucn86mcGiwqEI0WI06TJBl9O3+imFXbDtY/KJw6O1Ui0NlJhr3JaQYuYvU/txYoivadawZcqsHg2JrtaO4u77JPABKT72HZ34rGnSQeNFsiuRB6rJP/HAwmzuFRMJ9TWNn8Fy1yz1HEc8IdEvPRB6gX9O8zpsoFr4h+JTx/d3YPL9HSCWsN/xezlVFOkgpAFHoYbEtXnnEUU+pjWgVD/wDxUPZYuPqgEhFMnEUVSIigvmvw8xPdLst5RaMnL+ZCGtSIwBy7gS3Toj8bZFVlF6D+KJs9T6N11RQcRpPpMJfGWpdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05s/GxQNabjJjtPwQrZifE0qZl9LTCqvstQoW1vS/YiFVtI5vIFboBSQm01m?=
 =?us-ascii?Q?1RjG+YA2ttXySyYSScR3Ju3lpWIbE0DKXH1+zqsoGa9WQMEvLD3K4mHKAJQS?=
 =?us-ascii?Q?XIyPAafaTZDBAVYkVpnTXtKytnW4aBuAT3+bc5IqZXNoYM5fJTHn6EY7gSrc?=
 =?us-ascii?Q?xDOfpeVX6C3okiYcR9FJb4d5hn6SmzkwG7unltgpzAwMQXMuhrlnHiaiaIge?=
 =?us-ascii?Q?hR7NrLpd8fdV0d+Q2Ckabedna+Sr3mG3g4fDFGUFPUnb58Sf2eonllzd+9AT?=
 =?us-ascii?Q?K5TB4fHHf0oC33Vqof58FwIFAzWQ2h2xcGgOQs+bmpxYWX54dkZMeQkTxo8/?=
 =?us-ascii?Q?Wf//f+i8Pz0eJkAQggbfAs33qkuJnBTG+pkalNxCAZ5mZg720ssWeS8dxki1?=
 =?us-ascii?Q?V+uvMd0xn9m2g5F4HmGYVTxmxPwLfMlRSSkuW0jjSekEH8XpNdDQe1UQpVWK?=
 =?us-ascii?Q?NKkaCP1hgf+3ITEcHVadkpgMDoq3st4UzYqx0bzdWgc1n7ZsM5PVULLUAFqZ?=
 =?us-ascii?Q?LtwrGSkB+gfLY676XEMsGLkTfyvXjxKsjQJXnK/CaFttuNhpHxcqgnkhXfFr?=
 =?us-ascii?Q?0IHba15ycxImw3jRfpYX0tO4gVr1rMBO6zph3P+u8GPnT4sTHNEAZaqYWwyy?=
 =?us-ascii?Q?oNGnj6hcc7Ei6aySGsMhePV8nAfMOtiDmv8i6UQjEswaBLskp1+Q5cKWSH6n?=
 =?us-ascii?Q?ea3ZluNpTWRQ1k4t6WhAPGB84bpQpCxjfvbpDvJ6FTpW8ISGqeMVt93WmufG?=
 =?us-ascii?Q?wvxCf7vqGlkljlI+f1VVy6ePhAegVbTZdn+93wBberTH/w4HQg2MkKxcVTwN?=
 =?us-ascii?Q?ayMZ5BZ30NLl0gxoQY/RSE4hTtH9m972tu13yViq9uJAE2KVlmaLpJA56Aph?=
 =?us-ascii?Q?7nZn5nuEn9x58FiRONpJo7aP4pD0l4WYnhLe6TekxLCEUa/7QYaQO8K/QjmP?=
 =?us-ascii?Q?pJ/54pP2HAZSi6/0KpFazDhoMabPAfXL8OSMDLTpvwCyuwgd9F5OI1KKbFUA?=
 =?us-ascii?Q?ChPh+UxeX1yvRD6ofEaBWr7UXRpXHu16x8BE81wMLjK0gpcwKSUWmY5Dq/DW?=
 =?us-ascii?Q?cpRrsxUGYLb9IDZP72dqX57d6/pkoOPuBW2chd1lcIH2aVzeyjk5xImrlZ2z?=
 =?us-ascii?Q?V10X9eWBciF3L1pn3RUE3A1QBOMskqBpXZUleMVFXFIZnIA2uUR5QsTGAils?=
 =?us-ascii?Q?PbbVnUl0TnrBjP1x0OLCB8E79VUyAM57O2Pw2/A3utA3lNvneLjGcDgnNQnb?=
 =?us-ascii?Q?hV32mS0tb9pMJU07m0uqN43B4SwLkxUoh9LGIStgl/OaYT/hQCoTCFlQ+xPe?=
 =?us-ascii?Q?sUUOMFylhjb/lcPMYtQUjrqICuugbHM+S5HA65gL1dtjUFvwJbT3yRmzog7B?=
 =?us-ascii?Q?xx9n2WJ/wFW5sA/HL4WFRWcjvl5asjyk4gm8bkrhbMDMh/8+zt7IlwX+rbKw?=
 =?us-ascii?Q?gh2e7aPbIwqVzYW7or9iGpvx4pc/TAA4+9FXiXlkXb97USrWbPgGg2TtQsLM?=
 =?us-ascii?Q?cJNo0XFyvjGqOvPYdd7lz8HrJ6WtqzGSaotbYMPEokC/qiBukYMSZm+fS4PM?=
 =?us-ascii?Q?X0bdjAm3LaPIkTnuHODGZOBGtOiGDw+0WcR5YCHK7B9vohXRJDNoFWoFeDkE?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d71824e8-1ed6-41d0-6e3d-08dc505bc16b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 01:50:19.8235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/pJu2JKjd72NR6xjy4aEEBBed+Affc8250J8XXeVMRtbW8/+986y/PZe47fVSMC1zrG9yus4twLGSNhveWb/yDHpa8UGWWQ3CUSzIUTEgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Shiyang Ruan wrote:
> The GMER only has "Physical Address" field, no such one indicates length.
> So, when a poison event is received, we could use GET_POISON_LIST command
> to get the poison list.  Now driver has cxl_mem_get_poison(), so
> reuse it and add a parameter 'bool report', report poison record to MCE
> if set true.

I am not sure I agree with the rationale here because there is no
correlation between the event being signaled and the current state of
the poison list. It also establishes race between multiple GMER events,
i.e. imagine the hardware sends 4 GMER events to communicate a 256B
poison discovery event. Does the driver need logic to support GMER event
2, 3, and 4 if it already say all 256B of poison after processing GMER
event 1?

I think the best the driver can do is assume at least 64B of poison
per-event and depend on multiple notifications to handle larger poison
lengths.

Otherwise, the poison list is really only useful for pre-populating
pages to offline after a reboot, i.e. to catch the kernel up with the
state of poison pages after a reboot.

