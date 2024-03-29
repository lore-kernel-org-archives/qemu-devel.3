Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD507C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 18:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGsI-0007oB-3c; Fri, 29 Mar 2024 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rqGsF-0007nx-Ls
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 14:22:43 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rqGsD-00059C-Ef
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 14:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711736561; x=1743272561;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=tdjuLjy32ckWfdQJ+F1U0fMdpdNw9sjVrZ+GwLP0EDI=;
 b=FaJPNIoFXN6nhYCh/ibWFNoOwyzumARVbm8Bm1oBYL50phvwaEb+/Hy2
 0ICFdmoaS8Wv8EFlK5/tMZapQ3omnoVgF2Jep00+/lO3JyosSBFdakyRO
 I7yvuUs+owBLsmwyM8jGe52kGRHtpgnCnKo8+bimGjilZTmvVfPNGNlxp
 pHTBoJNum3v8zTAM6472EDuxcV1E3ayVyeTZ7fmdI5jcFTa/5KXXEo34d
 pGyioI9pcndcbi3AVfkgnbZkujraNu0i4OGTqvOWeYezrwb/4oqsKXJBz
 5L0xpi0VNRDiJPxrCgFKctU7bz7B0hSmAnuA9IQsiV9IFszj2XHPzZ7uG A==;
X-CSE-ConnectionGUID: Lt1obdnZSQ6XxyebE15gjQ==
X-CSE-MsgGUID: J+fuNXozTs+EEnqdFmJivA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7526821"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7526821"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 11:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; d="scan'208";a="21709004"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Mar 2024 11:22:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 11:22:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 11:22:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 11:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAQH+IB2+25Mu5fr4kUwewFdX3Kb0TJeUaIlsbyakQOQwY0VlhxMNo36q80guqa0i16bimYpdCXyONoqrAz6WjzDq4n83Bx2HALur0VGI7Yft5MXNzU8w95sXuVhMFCJOskY1ffjVax6aXyJvC38c6ZEE3Rj4sa8VStRw0HyhEEl0TNHHOd1dqfI3ov0E9U6dVOlt6zgkvuo8VHnm2ZXLdxET14sCHaiYzJQkaYucN6faNN8lnJ7W6ovSHWRaFQHjdHZAnGasmwzdRdhjTKIPnY8CTOEhN284HJaiDuuA6txECw92fO2BExuUcWhDHgZ8fvYA4//0Z+qmMtxHDjR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfCUFm8wSUGcyXFo7PRCvhG6qtKv8QHov6OKeu9egoM=;
 b=RfupYdmlFXYzgFUmLI3Zh49W8o1lCwz5JjQr86YJ4MPj0Paft7aOrMap1iwhZlZXiDsm87EeUv7bTRa1QL8AdxInhGOOJIiOMgGiHxC8Of2n/3QbGv+7XIrznaqwEAqvISAAmXGsh3qKv5dmwWTjg4bHMxaj/5c96M/jG21r4UVEPWzujEmRBqdqmKHekMu9WYy54ZEWu7X/rcvO690aEjQrweHnZwaCHBcwTccwAou2b+MxQn/5XQD0n8Drtx8iSlWgbu/tO+H2qqy+VYSJJkqr3samxY/9f4pNb3MY8twKArFyXwNL1T84yAqYnimec9bCX+AcK2h5gi5/v1sF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 18:22:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 18:22:34 +0000
Date: Fri, 29 Mar 2024 11:22:32 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Shiyang Ruan
 <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
 <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 0/6] cxl: add poison event handler
Message-ID: <660706e8a66c_4a98a294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zgb9wjTIu1CE4S5r@aschofie-mobl2>
X-ClientProxiedBy: MW4PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:303:16d::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7856:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sp4oUUspFFT8fHag/REUR/GxQt/lK1my1tBd/3P87w34wSa2phQTxtk1kOTQeDZO42NvisTzdU7sTrKASz4rJHUklu5ZL3JB/50Q4j4biWxpvUCjn6xaEkx+S7nzA6KYXr8O6RQ0fkHDkcxmcsz/2YCyJyjjhq/iPu7oIJe732CJaCJGB2ZKXx6LB6PhVgFYRimcIdJ6cxG8HahLpowm7RL2965jfvk2X5Wmt7UEQ+Qq4zft4zSEj1ipus04rMBHZDj/EblG5nF5L5edo+BK3kkK1QcWZ5hvYFir6AOqQOqJpZBXMMyV4V1rjfz31Rax/F3vh+q+C+/DZp9SU72hykWe0+/X99j0898+wSaP0bB91lFS2eMbRqSgtk0QoFMK/CdX0YA9JtDhwWBQ8J00ILX7jdv/JRRebJg89MA9k8gn0QhlhWnUA7QT7/da1QErVAucdud/BMNZDeiuKnXr8FhALo62SDUm9D51UNkiFMt9jZZljX+CSs8z2H99/CP6O2FJ8O1hlHNn9f8gw6E2SyoTRj0k10E23kVh+bhGEZRvcgAiS0HoONHDK7R37Rc4UnkWTCW/SB7aexlTzVVjp/b5ZU6ZjiML3D3HqTG2cX5Mic71pQdfZIV4dJ8/WmWc3UWzxzLduisw61rGgrpn2nxjBOfziK0CasHOSynnb58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdCGdkKzT5VXqafLbE4adsLMwD2DgREUhbUlKfQ3shvF8163VCC3MvScK5Mk?=
 =?us-ascii?Q?pMFJwPkfTzB48qXwWbygQyf9Djvjjr+8zXPG1muuyHoiyrKQj0bBdGICjetM?=
 =?us-ascii?Q?NKPdgFaNcra3ceeP++xU40iDbdvQNvtOTCIwRnhimu/IQDqeJ05phCDMWffd?=
 =?us-ascii?Q?5Ov+bQFcqe/hbZbCmJ9ukbEnHSfb+QozmY6OWYCYfeP/ROgp86G/VerAjZM4?=
 =?us-ascii?Q?g5djEDiL5Sdgp1LPKd84bZSTL11S8H4EMGp0jEjyk2tO180SWaZvL5bSJ4Vv?=
 =?us-ascii?Q?ZQEhS3aYxlt66JKvxv+XbdrC+AdRhwB2ksYXm839KajBwqTtum6MZQRsi7nn?=
 =?us-ascii?Q?R2QH7UqKrNWxwhqylEFdZ1/k4Y6tl+1yzG0BOEt0FofHibF3+o41dlUrMvzh?=
 =?us-ascii?Q?GdAAB/50Odn77cKQmYt91gU9CL8836aCOgLjHecMuinS0CiNj3WZBUEYbLQo?=
 =?us-ascii?Q?h1FV4TF56XcBQB6YPUrHNkOcq1EL0JWkEiDvcyMkF6Jcsh4dEsc3H3zfG7vH?=
 =?us-ascii?Q?WMgddifk2PH2jgRq5FD7A0Gp5bs+Cy6UeBcXPLxH05EfzKycn5P3/Rk3aeKe?=
 =?us-ascii?Q?+XYeLTbu0kKfAgrhcfpstbXtB8Q6CDkg/K6yqRdacHb0StlF8Q24ItGVsT9e?=
 =?us-ascii?Q?HjsaU5FImrJ8uab53j4kllX1jMySyGbatfqjI1d51RD16m3U9P1zQYZJ0+Js?=
 =?us-ascii?Q?IOD0HMteHNQT6mO5IxCxnhHng8RSVj1JjBYS6kQtaJnM+ihnfTE2N6+nx25Q?=
 =?us-ascii?Q?mhF+ZpAyr7XKxA9ENntlTnL0x4fsnxXCFKmA0+jffaKj/VJMAMdTRbWbO0dp?=
 =?us-ascii?Q?ytF3XXOG85nVKDvS7ZqjQV0pT5lvHZhu71VHPs73bzBvkuQ+U8cTfjoTjEX2?=
 =?us-ascii?Q?ehDZblkcUKdcs9kKabda016cEqAB5AqYNv+3/FKowT/fQuqu0DpxQY85vcq9?=
 =?us-ascii?Q?f11F1vv1+MWgFJ8p1IDUqK5V4OZtkW7wsX0bB4+m+CVuTl8ISfbH0Y3in2lR?=
 =?us-ascii?Q?id7teGnOfcHLC9SfpFaoxARt3xObxcziGzDxY3N9yZq8mdp9/nQbxP2RnPjx?=
 =?us-ascii?Q?hsN216UwnQgrgOh0SOeg/2L0HRLDTkpRXKkDbpe4gPCf6S5ijwHWIEyUzk4s?=
 =?us-ascii?Q?tO+kUhMwTBPXyVp6kPHyw7WsRr6MNT5sWRBlxINsKnyyKlcl7EbyoDbdyI0x?=
 =?us-ascii?Q?6u6HeBs70fOZ6Mi3HxKBWBOqnV7RuM02Jn1DPe7MrtibHy+ns+fafW9sLIgX?=
 =?us-ascii?Q?ZerrkSAVYCH6yk4nDekE5ODrDrU8lM5EgSMm3G3i9YEzGz6UftW/VRz/6bXz?=
 =?us-ascii?Q?GlqJ3BfKM+dxhCx62VNF3X425hrS+UloWERzthXTfSLZ3+B2cOusph2tr2FF?=
 =?us-ascii?Q?mxML0VOjnYC+y4MSfufPX/K4BiqaGEcU04ggEQ4QuZnoe4x4uiTKCZi8atfl?=
 =?us-ascii?Q?3jrAd67d7+tE8N4Tw7nZ3lqd2AvHKuP+X8B2uC/lYHripB4k06KI/HqEBlUK?=
 =?us-ascii?Q?uqecvJCedQAsaA1B3EtxM9obJF8R27p+g8LDdcqAGrKxEsLekPlmjIg1gNOs?=
 =?us-ascii?Q?42x97r7+6mVmIZ3Ikoj6TYbETuYCVQSr6/UGiKd4hzMsyM7CSHzTU1Z5EBAS?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a8f922-7116-4e02-af76-08dc501d3472
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 18:22:34.5909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3r93ZibhuZfCoGGX1xGuP2PgEfqAfyuKE5JutMnJlqR1NKfoBhM+OZocRtOQdOtDOjGpEzKcjnUOlsJyOiG7EtgkTXF1N8V5C/bbnFkE/Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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

Alison Schofield wrote:
[..]
> Upon receipt of that new poison list, call memory_failture_queue()
> on *any* poison in a mapped space. Is that OK?  Can we call
> memory_failure_queue() on any and every poison report that is in
> HPA space regardless of whether it first came to us through a GMER?
> I'm actually wondering if that is going to be the next ask anyway -
> ie report all poison.

memory_failure_queue() should be called on poison creation events. Leave
the MF_ACTION_REQUIRED flag not set so that memory_failure() performs
"action optional" handling.  So I would expect memory_failure_queue()
notification for GMER events, but not on poison list events.

