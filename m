Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC24AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzL46-0001XN-Ri; Tue, 23 Apr 2024 14:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rzL44-0001XE-Fh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:40:24 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rzL41-0007fa-8g
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713897621; x=1745433621;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rPGWuCTAtf1QVLLeu3zYAXsKImg/Lm46DOywgAHmZEQ=;
 b=Tq53HA4XtKvHiUsvXAuDIKIWc9IiR3/6d5lmz0aPP5SvnuN8/9VotG2i
 UU54HyhbiEf3rDEaAIH/fvKpkXThKbz5JMXERBnebim5a2s+bcGXZfdPY
 E7llfF5JvvBdSK3ACclGPq1ecybFT9vvybm2fgD5xkfLGT4TTJEVFbOZH
 qK/92LjlX6Z9pkvXb2sSVnKR5UHr+q+XSei9eJo+IUD8B71jMuTNX7kck
 c9WMG2y1G4i5TMnoHFiLt3KYFa/D+l3c7Vti5opTxNGLbDx+2v6xD/I+I
 jxm0SCrY6RNR+UKRlOL/wBDhcSZFfEGqHmZhi9ylGrb1EDmbs+zl0NGSb g==;
X-CSE-ConnectionGUID: O1HlsKpUTWuHWtE/O2DtcA==
X-CSE-MsgGUID: 8BuUcMwJRMq9RC3vu8qIUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20196550"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="20196550"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 11:40:17 -0700
X-CSE-ConnectionGUID: Ci/WhGuHRU+W8i3tpkxrYg==
X-CSE-MsgGUID: 6LekkufzQNuVm0cVKO1oCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="47729764"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Apr 2024 11:40:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 11:40:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 11:40:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 11:40:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 11:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdgDs4ywRmpiu3ePoyEpaHgvvx81W/4iEgD6Gn0yQudvriJeg/grKucjhqIiClEvM3+qjFghqPByXF+z/891L0BXTwQUxZAnKUaT98qz8qV057v9opkk5DfzUklZ7uwJr5sQ2cU2W3/CrU1WvAqh5XNaqSsbUMwUme6tK+jaZ0okdC2ygSrvb62SHI3rNvnBpXCp+GUPI9kdrCmUMQHg7ZhZoMjO4+pNYnxLC7pqnJTYuCMcd7cF6mHlaKwcdkfO6/4d9oiaMoPi0eS5kc1NbAJmdmhWo2No3+7wtF3J52Kgh++9QioAOKZhi0MhxjNdO1z24FswhougitqRCWehgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCSQEyE8A8mCAF8oiW3xvfmo+eMGn7hWdBxkiGb+xd4=;
 b=CWxk4X72eTF1MjrmLFXlG+ZlTrm6f5eZrBjwdbYa72SLwljJsr453ZeHC69EfIicuFuZ/VtvFd7tL829uuahf3BhQjW9scmyX4sW+DUsgpuLeTuOvx9o5AVnL1qrgBqAQw76WslvXqWqWscjyH6qminUzEL/k3zuTzyVn4cFp7IxGGGwNkOsKjxe9n8J+uazZg2NKPXCMshqVqSyxL6Vme7gtT1ZmW8xF7XlqllgXkYvVEG+2z4JGyCJ+NWtrZrjpmLoNtgHUFqyF0rFlHwI+nLbJr6ShlonDb8JLZ2K8FutpnWVZJt+RF9PItush/EPuhGk7QYo8NU2EFiiA4RN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7671.namprd11.prod.outlook.com (2603:10b6:a03:4c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 18:40:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 18:40:15 +0000
Date: Tue, 23 Apr 2024 11:40:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
 <dave@stgolabs.net>, <ira.weiny@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
Message-ID: <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 21608bd6-7152-480e-fa64-08dc63c4d09c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L8Yw2NAMJsWQuoeoyEInKkat+Y4vqYRGpf6+MaeygacH2TPEQInppPCLciEx?=
 =?us-ascii?Q?GcZSg3s4wRAMdQjIEYxuYjbTd4Tts7whul2MyC6vtrYRztvlgidfAqW8y/Zh?=
 =?us-ascii?Q?Z7ywKSTXos/3lGzEzK93i/lUB/olYJgorzdXVXS1xrUq/KggERpQkOOJo+qE?=
 =?us-ascii?Q?0/dEwi32hCLdL3e0XlMkBoV5t/0Vo87Bkah4z/VhzLFc0DIO+XyIw8VaSUZT?=
 =?us-ascii?Q?RfmKP3Rh5B8rx/OqzoqO6uWpbqnKDPViKZ/RuhWjxEtZjUdef00f1hRiOOdJ?=
 =?us-ascii?Q?PLFggAYdylWY15BmGj9aaEDUrBSoYKl2qAnt1lDh3TP2DAQow+nZ06boeqAl?=
 =?us-ascii?Q?xD3Yg/rBXzt2fciubyHgHmWh5rXdCwGt+ZZ2a36pBoyh87sumGd5E90r7M/o?=
 =?us-ascii?Q?0bd93sGHM++kxt7YyGoFYYM9DHPwsjdNVkzI19fSqlDvWmwsC3jrT30FMzgG?=
 =?us-ascii?Q?neGM5MSOvzrLyyhtjFef6/l+6Z29ekLmVu7xgWVRu2xrXVeodftLg9SJJ6ld?=
 =?us-ascii?Q?G2MtjgPqD4JQHlpIZ6HP84QtMlKsv6RpBn1tc0gwRBZ/dQqomTwu5OIHx91E?=
 =?us-ascii?Q?ngefDoJqGFWrUAREd5QRVvH8lNE4+OlDdMLH4OQXK8s/FnHpsMKzw3uhR66X?=
 =?us-ascii?Q?JofL9AWQWzk7KCY3G344fzi/h4aeKy5Y/TG7cmXBtRCnFgwWCeHaXRr65Iel?=
 =?us-ascii?Q?bGRHxUwiUanjc6OvWN4xIxc1vzpolTZhGQGV8OlTt20u5sHI4hlzh9MPqLn1?=
 =?us-ascii?Q?nHwy+6AEC4VYPgskNe1Sx6cdampQgZRhLQD2o1gIieeE8szN7dcZtzNIRpMS?=
 =?us-ascii?Q?aMlArmzj3Wc/OpvIkUFsrR8Y9gL/1AGADYfS9LN2J3Gu7myhVKoNDHyg8pqq?=
 =?us-ascii?Q?18OgqtyO4j982bKyuXl7vvGq3jJvYdknEZOH+ULEgrs9b+MvLypnIY+w3Rrk?=
 =?us-ascii?Q?nxroSsIkLrQSt8Tne/hdtHLQAociclkdKyM3q6ghsnPdEM3kM5En3BurYFOC?=
 =?us-ascii?Q?yZ1cpsznprB770KkJbpIYzv/20qZSsCpmIFbDJSDDnLb/z+cYMP+rN7onsqW?=
 =?us-ascii?Q?oujRrqFQ3rSbfw6cNeDgzJAJpoy8LRzkEedrfcqwZintvk1MCd4wNa4DadxF?=
 =?us-ascii?Q?BmqclDA4PefahHd/Bh//Mq9sSZgpnzmsUO5ln48mquFew3fChxebL5TerwsO?=
 =?us-ascii?Q?9G6GBfWmbegDNVGM6Y3jdTXCXjAxLJ8hqxU3ac6XPy8m1ikHWxPnosnhOaWp?=
 =?us-ascii?Q?fGnmOXMHt+ABThUGyepuHifRcQBFPoO33SQO7WlyuA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCllc5EpZAdri5wDTGsJPCb9xmgVTGRIRGtrxVAaYKDEu135f1W0lKx3rAdx?=
 =?us-ascii?Q?a3SIkekopkGjuXb94csQOldyhHEhqI8NFcDFKBP/7ZFN2C6E2bFuoNrxNvGa?=
 =?us-ascii?Q?vGg0hkuCUNBFe/W2ukSJpMXTDCGTdfCb/nsC3O8233UKvxggnf6n7YHZA/+2?=
 =?us-ascii?Q?YrE7bDs5dQ1iA2nDqLR3pegQJwtHhgQXuGHbZqHXIo78ED0xM5fAeJtPNKSL?=
 =?us-ascii?Q?5vbYg9UERRuwYSfXUPSpO9tx7Zqg4MxFXoegfw89rhoesgEswlu8HJCEB+DY?=
 =?us-ascii?Q?t1TL2Ut0Lsk9tI5pTMZ1feXrbOfMqEPnqeB5q5GUNLwirKuQ1/wk9EstSwiW?=
 =?us-ascii?Q?rFPEEn26uevDlCuPVpiy9DEQZ9m5FpcalaZNNRgQIcbJuBP3EM95UGuj88th?=
 =?us-ascii?Q?0eEK/NcfVn9cFbPfzxgJO7bAdhqL+3AH6GOgDm4ZTBaHoH08WH7qPxd24kvm?=
 =?us-ascii?Q?jvxJ6q0AWjs4vVIqUGgBt0feXwZMOCg+cX2hBAxrQ0f5Rfsj48jMC7ykc+eY?=
 =?us-ascii?Q?HKU694yx3c8LGrYSw1iOJwcUAjT+oPImdj6et0qxcRWtCQU3Mso0nMltdsv3?=
 =?us-ascii?Q?stgZzlIqAglS6tFYaEclCBIJa1DZTaNe1zDtMbQSYgbTqBecpYATQTlaz3zx?=
 =?us-ascii?Q?4iWemjY6qhCEtnbyoaWUpFyJk/l9SgRlVaKfeBrj7LLzf7iplZpLpxQ4ohhl?=
 =?us-ascii?Q?gYvuaoscXs29dWrTXNtkDTJGw5sMrFVRw1poPMiE5Lla7SOQmLJWkwfEP4Gr?=
 =?us-ascii?Q?nclxX68N38OmxIM4KhxKA9MSRFm01fwk83ZoTmuETTSj2mbjPv91tjccUnh8?=
 =?us-ascii?Q?OfHlPgePgMtHP9Bh+ow76XNeGSTF9UM7QHE/rtvwKZYoHqElVdsW787Pf4l+?=
 =?us-ascii?Q?SOltP8Qbe0FW7Vj3q39kvYV1UhmBNS4FTLQBzy4m5+y3Ip5OVlrelgsZWrxp?=
 =?us-ascii?Q?Hn9NhEWmP/WQ5mQju4tzE2w5GU5WPbIDQ5VwTc/c57qh5fAtYaR7MaX2Iix9?=
 =?us-ascii?Q?pKT/K29a5Z4kso+C+QB0p8bokJQyKaVwJ9dwrvumFz+izgilEy964zyFlv6z?=
 =?us-ascii?Q?jBnbfAe+NjBdbdYEAXEEj+0D55fVxW1m4taeYFjfjYueNqOoBfpTpmis1wg1?=
 =?us-ascii?Q?JYSkqOn1NabeDEmuTK2J7+W2lAkJnlw3Fvn6fd3/70YBLyDI7AunYTQ5LiCX?=
 =?us-ascii?Q?T8V/xovTDXXvtFXp9uh7R0um6OhT90CsaSspHCAM6LBICe3In7RpzK2DmR+F?=
 =?us-ascii?Q?FUU6536QbLvl/aAw95h03zZlw9wEDLe4TBbNWXy38qJ+cDa+ZFOewUBg30oP?=
 =?us-ascii?Q?pcXrFVHcCxmlTU48FtkIV4pwF9cAFm+pLxoXtuCdz8u7lILDKAsVDOwHu7XO?=
 =?us-ascii?Q?i9XGsz9pKwEsK+3Nk2fChpqeldymDn31FydWH1hDal28XG9/dN07NMBjSBq9?=
 =?us-ascii?Q?1JRfN1PXhAakn37xffcaotDRgAfa2UbmGLfF5RdUn3cEMe5KQL46kTWsIZnO?=
 =?us-ascii?Q?89fEOvH+Hofq6MDGd01kKpuOFDGLlhh7P8qkbs79Xxtz+nS2KzA+4xd0i5pF?=
 =?us-ascii?Q?UMwUnCeP9ZI5J0M/UPma0QA/appiEN/S+nvQ9PfsqiHPxj/DvKV0SlqXcLZz?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21608bd6-7152-480e-fa64-08dc63c4d09c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:40:14.9505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5MpgyxOaoTNNNjUzF4KFinkSfu2T4uqYhXkJJz/8OxJ8o8RVmTUoLU4LC2jnWYpd6Nv0AnotvLXigQ2OTGbivFm96Tlgyj9eY3VP5r9NZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7671
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Shiyang Ruan wrote:
> Currently driver only traces cxl events, poison creation (for both vmem
> and pmem type) on cxl memdev is silent.

As it should be.

> OS needs to be notified then it could handle poison pages in time.

No, it was always the case that latent poison is an "action optional"
event. I am not understanding the justification for this approach. What
breaks if the kernel does not forward events to memory_failure_queue()?

Consider that in the CPU consumption case that the firmware first path
will do its own memory_failure_queue() and in the native case the MCE
handler will take care of this. So that leaves pages that are accessed
by DMA or background operation that encounter poison. Those are "action
optional" scenarios and it is not clear to me how the driver tells the
difference.

This needs more precision on which agent is repsonsible for what level
of reporting. The distribution of responsibility between ACPI GHES,
EDAC, and the CXL driver is messy and I expect this changelog to
demonstrate it understands all those considerations.

> Per CXL spec, the device error event could be signaled through
> FW-First and OS-First methods.
> 
> So, add poison creation event handler in OS-First method:
>   - Qemu:

Why is QEMU relevant for this patch? QEMU is only a development vehicle
the upstream enabling should be reference shipping or expected to be
shipping hardware implementations.

>     - CXL device reports POISON creation event to OS by MSI by sending
>       GMER/DER after injecting a poison record;

When you say "inject" here do you mean "add to the poison list if
present". Because "inject" to me means the "Inject Poison" Memory Device
Command.

>   - CXL driver:
>     a. parse the POISON event from GMER/DER;
>     b. translate poisoned DPA to HPA (PFN);
>     c. enqueue poisoned PFN to memory_failure's work queue;
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c   | 119 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h      |   8 +--
>  include/linux/cxl-event.h |  18 +++++-
>  3 files changed, 125 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f0f54aeccc87..76af0d73859d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -837,25 +837,116 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +static void cxl_report_poison(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
> +			      u64 dpa)
>  {
> -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +	u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +	unsigned long pfn = PHYS_PFN(hpa);
> +
> +	if (!IS_ENABLED(CONFIG_MEMORY_FAILURE))
> +		return;

No need for this check, memory_failure_queue() is already stubbed out in
the CONFIG_MEMORY_FAILURE=n case.

> +	memory_failure_queue(pfn, MF_ACTION_REQUIRED);

My expectation is MF_ACTION_REQUIRED is not appropriate for CXL event
reported errors since action is only required for direct consumption
events and those need not be reported through the device event queue.

It would be useful to collaborate with a BIOS firmware engineer so that
the kernel ends up with similar logic as is used to set CPER record
severity, or at least understands why it would want to be different.
See how ghes_handle_memory_failure() determines the
memory_failure_queue() flags.

