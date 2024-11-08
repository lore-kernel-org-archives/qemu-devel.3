Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F80D5E12D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 05:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Ha5-00014a-UM; Fri, 08 Nov 2024 00:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t9Ha1-00013x-Mo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 00:30:45 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t9HZq-0004u7-Tk
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 00:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731043835; x=1762579835;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SjLZft6DSXW35b8gAlKtMBi8SCskjz0nC8SI9PW1V/g=;
 b=HNincLjOuKbtTDVfO7CKpG1yJZ/QZe9JnjuDcp29AvLxcZkx3fVAgAqh
 wrxMQiluWZaTqMxwOH/a4n487mHmcBaXQRLzGzu117687uymdGb0fs5St
 KYrbbFNYN8nHa7tRHCJS25eNUu1vDUSvPAmmPIMmOBZ+0nYw5KTUfib+R
 gMstX0haJriKWPYeyHG0fi9afUn/sfQMpi9REukPZ6OiXjMgxgEy1Z//4
 7MXJhzsDUEttYwLdyvw9MWYg7PYn5AWTdv+6W0hua6d25eGS9XnohDMVH
 mQSTnZtujJuHz7sxqzXeI69GpXfNu6r9Ncsqrkxt9hLhAP25znhsmtcXk w==;
X-CSE-ConnectionGUID: lWOb4i4KR12YUYykIg14Ig==
X-CSE-MsgGUID: tDQzGGG5RjSLxt/Ak+n+sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30316307"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="30316307"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2024 21:30:24 -0800
X-CSE-ConnectionGUID: H7pnss8qT1mG+g9kFP228g==
X-CSE-MsgGUID: R/DlG+ZKQy+V68y7eR46lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; d="scan'208";a="90036794"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2024 21:30:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 21:30:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 21:30:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 21:30:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wC4csXoYlNJqieL4cqQC/w/dMzLVVtvVSyaz95vGhCdNGiAn3LS/Fd3/knFblcYj+Y+3YakDc1sI0LsC2GlWqidNyZRTjIJXE8nEkRgDjy7YoQ2RMvKPQ7IHnmUBePVuNjVwjvW0r5y/udBQYYIlTgybZu9YNrsW41xmr6tabS4BFsTOLDE8KN1F71qAE8x6MQf59tQSuKGgS4kFxou8xfuXwRlMvJ53xVPyiF6y+Es/Axx/SA+fpsDPINaaXpQRxQ623moomnTyqILdXq1doz0UfV4AR4r9aeRqktWZpcqQyxlQigu1U5d8agn5whh6p0mVqcKIBf3UrPqAxU+Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjLZft6DSXW35b8gAlKtMBi8SCskjz0nC8SI9PW1V/g=;
 b=rKuzdZCxOYMfE2EUsVNY2UHX08p4h3xVeSFQUOGieqnDu/4r8CxWPfXIX7XwM6miJtGmm9mBl9MLSlq8wThF5Rql0Eu/uX8/2l7OTJsKiNjfBaoTssQVkkHC79toiIZUO1dcoUdHEGf+1QHLwfCpuhH6yU/zBVS4HT+hf8MW+1JL/vxgf77K3xKOmboWcei2mnFC51WFlbBJImLygU3BSRLnomAe7XZWUUkEg6yNWandkNT+Zfo/VNAPOb8OBILFECJApnCQrMPbyF+5rTb2nxE9jvhThRO442c1gRooLYltuvtXZOap9tJ5pCQ0MZbbdUE12q6HeeZ8qP+LtHNf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 05:30:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 05:30:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Topic: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Index: AQHbExt6qksyA+pIAUiDQKSj47oTJbKtCtEAgAAInMA=
Date: Fri, 8 Nov 2024 05:30:10 +0000
Message-ID: <SJ0PR11MB6744B13E0A9C352E4E6EF74D925D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
 <CACGkMEsq+VrxjGMf_ma=6xumwWgb2109XB4+86zH0ZXrce5Kdg@mail.gmail.com>
In-Reply-To: <CACGkMEsq+VrxjGMf_ma=6xumwWgb2109XB4+86zH0ZXrce5Kdg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5008:EE_
x-ms-office365-filtering-correlation-id: 36101fe5-c5d0-465c-d8b9-08dcffb669c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QVU0eTd1QldXdk9JMllEYnNVVnpHcUc3RXQ4V2tqR05FWG9WK0FVMnl0bVRT?=
 =?utf-8?B?MjhWeDhoUmtENXEvVzFCTTJBd3l5ZGp2NThYZXlOdGNZaTB4UDJwQjlYWmEv?=
 =?utf-8?B?bEVzV3N6cDY2dDN0NklIU1pjWGp0SmFZVHVGOGx1RFRwcGttZndQQmZxSUZS?=
 =?utf-8?B?ZDFBYlNBSHZxVGp2SU0zMFY2Nk1IelRUcnQ3cjRHYlRuSFpoUmJhM2VrbGt0?=
 =?utf-8?B?dEVRVEszZy9uV2xMeTdsRFE2Q1dBZ3JnWjJ1RmFHREdkQ3ptZnR4Z3czTG5R?=
 =?utf-8?B?WXVXdHVWSERoNU41eUN5SFpBVDFsaTVIRXJrUUZVVVFEREJWeUtaaW1kNGto?=
 =?utf-8?B?VjdNNEJzWG1kd0IwcThpNW40WHN6SXpsMEFKREJsTDh5RXBKZUNLZmNQa0hI?=
 =?utf-8?B?Z0FScHpjUDNDN2VZZXZmVldCR21oZm9sR1VoLzYvalFqdFZ2UU02dkhTV2x0?=
 =?utf-8?B?b3hZSDhLeE5tSDVxeUFvZ1UrdUVxd1ZCMXorRXpxT0JYcGh4aWg2Y250UHEv?=
 =?utf-8?B?M1FiNEw1SjJudEE0RGZ0S0pONkZSYnRSTi9QVktBa09sdWRSRWpudXY1ZnRK?=
 =?utf-8?B?NVhwOW9XQ0xOSFlWZWdpdFF2aGJyU0k2NHNTZEdRS0JJaDN0clVqcU43OVpw?=
 =?utf-8?B?R0htczZaNDV3ZWtkMzYxWFBES0lGWG85Q0N3UWU3U2tKSE9xY2pGV0ZXZWlF?=
 =?utf-8?B?Z3ZpV0dRcTcveEtDWXN0eUlSYlNDa1hyTTFOYlJlUzZqUXJsY1RiT3NGelpJ?=
 =?utf-8?B?Z0hmYlIwQWxlNGdxOWxSdVJ6aldxeTJkV1dmU0ZDMGVYVDMvVnpVdG5sNWNu?=
 =?utf-8?B?SmhacnJxb0owM1l4VHZ3RDBwSG40VGVnbitzS0RKdzFRbXBhMzBFUktaaENr?=
 =?utf-8?B?VlFaNUxkaWRvZTFSTk5NZXI0QnR4cm9aaG42NFN6VmcwckMydnMyYzdtWlJw?=
 =?utf-8?B?djBrMy8rS3YrWEdWb24zdlluVHNueGZ2Mkw4VDYxYzF1ZjJVeUdEL2tpcUVj?=
 =?utf-8?B?bjBicEd6L01qVHRpWFdtY1pPUTZrbk1aSFdjdGMycUIxRU5zOFFmTEF2V1My?=
 =?utf-8?B?Z2ZjZUQxSksrc3dyajlXeHNiNmp1TDFNSCtMRFhHckZBRkhtbWszclVTOG1E?=
 =?utf-8?B?Tmo1UTdqbmdNWkxSMXNpRjFMVFcvOUlzNWpBTzR4bm5ZejJwUzJmVlBkdGNi?=
 =?utf-8?B?REVXSUovVm9RVzc4ZVhuZlpvSnlOci9xWjhZbm5qR3VpakpRNVhYUnhRVHps?=
 =?utf-8?B?d0hoc3RJaGVqSFIzRUZhY29DTWNydEhPRThxYXBOWCtkaFdRV29ieXUrc21M?=
 =?utf-8?B?V0VJOFVCOWk1alZxcUQ0bm5tWE1ZZ3B3eCtOdVMrNW1NeVYrZExEL1RNMW5B?=
 =?utf-8?B?MXg3VllUYTZMOTlDa1h2M1cxdmptOUtWY0RJODJacEpTMWd1Wlgvc0V2VDk5?=
 =?utf-8?B?TFo1RmU1aUpQeWJ1L2RtZ3lKbHFHR3FnVzBWbUxvc3l0RDYwZ0k2V0tDaWFn?=
 =?utf-8?B?bXlKelBaUVU1aWx6UHlLUmg3VkFYYVM2Q01IYWZMWkVrMHlZak5rU2VNT2hJ?=
 =?utf-8?B?WXJmVWhIOXYvYkh6QnEzcFZuOVFMSmw1KzJ1V0h1THdYcVFjM0J3eXgwUjN4?=
 =?utf-8?B?RjZKaXIzbVV5bC9pOWZlMGoxdzF5R29Kamk4MVdkM0RYaG5sZzVlOVlYWUVk?=
 =?utf-8?B?N3BMbVhSZzdsNGVxZXdPdUZWZ1pKQS9kcWRTVW5FWnZJalpueDFKeEQ4OUNs?=
 =?utf-8?B?N0dQNXA5WXNkMDMvcHNwcWFpUFV6enU1VTlyd01vUTVjY0xva2Nnb0p5ekxu?=
 =?utf-8?Q?CQ2+xvgftILTAlMWtli3KLBBUnDqWu4x6QZzs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDhOMHJBakJXanorRnNyY1hjNk1CNG55Y1B5eEVEM2Z4WTdGM1FSa0lkVjBE?=
 =?utf-8?B?OUg1N2NuK1lBVms1bU5RUEFKNjkrNVhYRjlvVWJRV1BYenQyb0czR29YSEFM?=
 =?utf-8?B?OG55VFdHZDA3SXdzY3haL3U4NEhKbmJOSkhIQUI3bUYyZnRRaDNJSytGZ1k0?=
 =?utf-8?B?NEFQaHc3TERnOUZNdFhQVWt6KzBEMVRCVVU3UkJJWFhQUW44ZE1sc015Y3E0?=
 =?utf-8?B?eFVvLzU3ZDhwU1cxTjF4MkxLVHFDSTZSWFNNaUpseGxGaUE4TG1JeVRJTUVM?=
 =?utf-8?B?RkIyWHpBajBaMVEvQlFUYkZLZEt4MGdSVVIvNGh6OFNvR1JDaktDYWRublNq?=
 =?utf-8?B?WUxFYTBSTnBxL1ptMmg5U0MvZXFHNDJsZ3haVzRYUnl6a3ZubVJ2YmhHQUIy?=
 =?utf-8?B?ZTZZVXJocGJobzhHRkcxd2t5amJhbENMUjArMTg2RUNLRzQ5eHB5N2FKK0RI?=
 =?utf-8?B?RWZXMFpLRjBvQ2JRdGlLWVJZd1NPQ2x3OWJrZVJsT1VwQ3EvOXEwY3MzNmpa?=
 =?utf-8?B?WXBvMG85Rllld3VmNkYyakhJOGdPcGVjbVFmTVFrbXpTUDJzSjZSSnFLeXlR?=
 =?utf-8?B?L2VjOEZ4alFCQXlJZUg1OEhoMmhVR2dkbDM1WjZrU2VLaFpzWlBNbEtqd3Vv?=
 =?utf-8?B?TUZDTHZ0Vms3R2RadEN4cG5uYmE2Y3gzYkRiOUNVSzVCektUSFU2SHdhSWlO?=
 =?utf-8?B?V1ZqQlJWRzVLaE1UUWsxaVhlYzdORWlzOTA2L2h1Z1Rwc21yRlVZTG4rQ1do?=
 =?utf-8?B?RGVuakJJUzdTdGdqcW16MVd6V1NyaXNqVWU2S0s2VVlyMU5RTjRNUHFwUzRr?=
 =?utf-8?B?a0NhM0lkY0xKdnhHYjdvWVAyNWNhZFBIaWYwdndIL0NBQmNCWWZxV1kvNEpF?=
 =?utf-8?B?U1Bpa3hYWFY1cjZoM04vcFB0Qmd4WDJMZ0pQakNvbnhVL2M0cDNxMHJnQ2dW?=
 =?utf-8?B?Z2dQZFRBYjNYL0tkV3YyMmlaREVHQ0l2R1FpaStrN3F2YXZTYjg4cEZoS05x?=
 =?utf-8?B?dDJ0QURxRk1WSmZDMzI0TWxweGxHRTNiWlJSblVVejkzUDFPQUdsZWNjY0pz?=
 =?utf-8?B?VFhqd29raFo2VlIyTWoveE5aekJpMERUamMvWG82b2FuYS9uT3NuWndZT1dT?=
 =?utf-8?B?RTQ3VjBaTTJKMVZjVGgzeE43ZFBTeEZEZlhzei9pM1Z0QUlpZEg4K00xRlBW?=
 =?utf-8?B?cXFkQ084WkZUU0FOSzAyY3pGVndJWmZiWitSWC8yVFgrbnRqQktGOFIvRlJu?=
 =?utf-8?B?c1M1RGZROFRJdWJBbjNsTzVhNnNGVFJBMmc1QmxBTHE0d284b1FHbVdUZEpQ?=
 =?utf-8?B?dkNzZDFPU3Q4UTdBZWZRTFBNdUIvV0JWV2xxSVhyendMYVRCd2c5VkFxUmp3?=
 =?utf-8?B?QlJtOW9Zb3FsQjB1M2RHOFpoblUwVnpCWkZVaEtvbExmVlZuT3JHdlBHNDVO?=
 =?utf-8?B?ZUc4L3NlT1RHbW1kbjc3T2dET3JLWEQ3L29relExcGFPeXJmU0lTQjZoWmlS?=
 =?utf-8?B?NTIxaFkydVQ1eldrSG0xaFc5bTIwNUZtYnlUejBSMkU4b2hlMTFzV0pzbktz?=
 =?utf-8?B?NGtSVnhGSnc0dEpkcHNTOVJ0V2hoejFhYmVxV0RvNW1SbGhkWGJiTFpqNjZR?=
 =?utf-8?B?d05Hd0pGMldzSFl2UXpQdGo5dysyZFNObDJ4Rm1BV21IRTk3M3hQeXNjU1NJ?=
 =?utf-8?B?dUNVQWZIdS9xZDhwenJONWdneGVrZzNPbU56RllsczAxY3dhZjZDS1g3TG05?=
 =?utf-8?B?Y0R1cGJMcjErcThKeTBCRnFmb2ZXODVqTFNBZklHQ1ROcmk0WnZTRVNNR1cr?=
 =?utf-8?B?K1ZiMkpqdE0rSVlZOEU5Wk5EZW9maHJFV2hCdk9vTVlkN1JjSjJtZ3lJNmN0?=
 =?utf-8?B?WG1Db0lFT2lOTVhycHJGc0lXVWxBbXIrVlVva2E0VGxaM1NHaEI1QmpWcXdY?=
 =?utf-8?B?Q3FHT004cmIrVEI5bldoTFBvWVkxNExRSExLazA2MVd4L2FCdDdHNDBld3RQ?=
 =?utf-8?B?V0R6NWlERjE1cnVBemh4UHplRE5zOGJ5Y3BFQlVpV21yOWk2LzNDZGtEcUxs?=
 =?utf-8?B?Rmg2NytZbGpmaEJjQzVDY0ZDL2V2MVJnTWUycjNxVENpMzNLWGpMbnZQT3pz?=
 =?utf-8?Q?+faCh4HPA2diF/9vwOJnPVbV+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36101fe5-c5d0-465c-d8b9-08dcffb669c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 05:30:10.2738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDGNSxV6+H2jJW6ZSx95m7w3gxaqDE5AT7MRTnH3bqZYks9/aTCytAsOpX3pvp1CU8xyls6phwem3BNpnSd9Kadjns9hraMG6cvrtIQX8Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U2VudDogRnJpZGF5LCBOb3ZlbWJlciA4LCAyMDI0IDEyOjQyIFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNC8xN10gaW50ZWxfaW9tbXU6IFNldCBkZWZhdWx0
IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUNCj5tb2Rlcm4gbW9kZQ0KPg0KPk9uIE1vbiwgU2Vw
IDMwLCAyMDI0IGF0IDU6MzDigK9QTSBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPndyb3RlOg0KPj4NCj4+IEFjY29yZGluZyB0byBWVEQgc3BlYywgc3RhZ2UtMSBw
YWdlIHRhYmxlIGNvdWxkIHN1cHBvcnQgNC1sZXZlbCBhbmQNCj4+IDUtbGV2ZWwgcGFnaW5nLg0K
Pj4NCj4+IEhvd2V2ZXIsIDUtbGV2ZWwgcGFnaW5nIHRyYW5zbGF0aW9uIGVtdWxhdGlvbiBpcyB1
bnN1cHBvcnRlZCB5ZXQuDQo+PiBUaGF0IG1lYW5zIHRoZSBvbmx5IHN1cHBvcnRlZCB2YWx1ZSBm
b3IgYXdfYml0cyBpcyA0OC4NCj4+DQo+PiBTbyBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2Nh
bGFibGUgbW9kZXJuIG1vZGUuIEluIG90aGVyIGNhc2VzLA0KPj4gaXQgaXMgc3RpbGwgZGVmYXVs
dCB0byAzOSBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4+DQo+PiBBZGQgYSBjaGVjayB0
byBlbnN1cmUgdXNlciBzcGVjaWZpZWQgdmFsdWUgaXMgNDggaW4gbW9kZXJuIG1vZGUNCj4+IGZv
ciBub3cuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody9p
Mzg2L2ludGVsX2lvbW11LmggfCAgMiArLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAg
ICAgIHwgMTAgKysrKysrKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggYjg0
M2QwNjljYy4uNDgxMzRiZGExMSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAg
LTQ1LDcgKzQ1LDcgQEAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSW50ZWxJT01NVVN0YXRl
LA0KPklOVEVMX0lPTU1VX0RFVklDRSkNCj4+ICAjZGVmaW5lIERNQVJfUkVHX1NJWkUgICAgICAg
ICAgICAgICAweDIzMA0KPj4gICNkZWZpbmUgVlREX0hPU1RfQVdfMzlCSVQgICAgICAgICAgIDM5
DQo+PiAgI2RlZmluZSBWVERfSE9TVF9BV180OEJJVCAgICAgICAgICAgNDgNCj4+IC0jZGVmaW5l
IFZURF9IT1NUX0FERFJFU1NfV0lEVEggICAgICBWVERfSE9TVF9BV18zOUJJVA0KPj4gKyNkZWZp
bmUgVlREX0hPU1RfQVdfQVVUTyAgICAgICAgICAgIDB4ZmYNCj4+ICAjZGVmaW5lIFZURF9IQVdf
TUFTSyhhdykgICAgICAgICAgICAoKDFVTEwgPDwgKGF3KSkgLSAxKQ0KPj4NCj4+ICAjZGVmaW5l
IERNQVJfUkVQT1JUX0ZfSU5UUiAgICAgICAgICAoMSkNCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2
L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDkxZDdiMWFi
ZmEuLjA2OGEwOGY1MjIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM3NzYsNyArMzc3Niw3IEBAIHN0
YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVydGllc1tdID0gew0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBPTl9PRkZfQVVUT19BVVRPKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQk9PTCgi
eC1idWdneS1laW0iLCBJbnRlbElPTU1VU3RhdGUsIGJ1Z2d5X2VpbSwgZmFsc2UpLA0KPj4gICAg
ICBERUZJTkVfUFJPUF9VSU5UOCgiYXctYml0cyIsIEludGVsSU9NTVVTdGF0ZSwgYXdfYml0cywN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQUREUkVTU19XSURUSCksDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FXX0FVVE8pLA0KPj4gICAgICBERUZJTkVf
UFJPUF9CT09MKCJjYWNoaW5nLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIGNhY2hpbmdfbW9kZSwN
Cj5GQUxTRSksDQo+PiAgICAgIERFRklORV9QUk9QX0JPT0woIngtc2NhbGFibGUtbW9kZSIsIElu
dGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVfbW9kZSwNCj5GQUxTRSksDQo+PiAgICAgIERFRklORV9Q
Uk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2ws
DQo+ZmFsc2UpLA0KPj4gQEAgLTQ2ODMsNiArNDY4MywxNCBAQCBzdGF0aWMgYm9vbCB2dGRfZGVj
aWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+RXJyb3IgKiplcnJwKQ0KPj4gICAgICAg
ICAgfQ0KPj4gICAgICB9DQo+Pg0KPj4gKyAgICBpZiAocy0+YXdfYml0cyA9PSBWVERfSE9TVF9B
V19BVVRPKSB7DQo+PiArICAgICAgICBpZiAocy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAg
ICAgICAgICAgcy0+YXdfYml0cyA9IFZURF9IT1NUX0FXXzQ4QklUOw0KPj4gKyAgICAgICAgfSBl
bHNlIHsNCj4+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfMzlCSVQ7DQo+
PiArICAgICAgICB9DQo+DQo+SSBkb24ndCBzZWUgaG93IHdlIG1haW50YWluIG1pZ3JhdGlvbiBj
b21wYXRpYmlsaXR5IGhlcmUuDQoNCkltYWdpbmUgdGhpcyBjbWRsaW5lOiAiLWRldmljZSBpbnRl
bC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9b24iIHdoaWNoIGhpbnRzDQpzY2FsYWJsZSBsZWdhY3kg
bW9kZShhLmsuYSwgc3RhZ2UtMiBwYWdlIHRhYmxlIG1vZGUpLA0KDQp3aXRob3V0IHRoaXMgcGF0
Y2gsIGluaXRpYWwgcy0+YXdfYml0cyB2YWx1ZSBpcyBWVERfSE9TVF9BRERSRVNTX1dJRFRIKDM5
KS4NCg0KYWZ0ZXIgdGhpcyBwYXRjaCwgaW5pdGlhbCBzLT5hd19iaXQgdmFsdWUgaXMgVlREX0hP
U1RfQVdfQVVUTygweGZmKSwNCnZ0ZF9kZWNpZGVfY29uZmlnKCkgaXMgY2FsbGVkIGJ5IHZ0ZF9y
ZWFsaXplKCkgdG8gc2V0IHMtPmF3X2JpdCB0byBWVERfSE9TVF9BV18zOUJJVCgzOSkuDQoNClNv
IGFzIGxvbmcgYXMgdGhlIFFFTVUgY21kbGluZSBpcyBzYW1lLCBzLT5hd19iaXQgaXMgc2FtZSB3
aXRoIG9yIHdpdGhvdXQgdGhpcyBwYXRjaC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

