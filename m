Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3174CC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdiX-00065f-IT; Tue, 02 Jul 2024 09:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdiV-000654-0M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:38:43 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdiM-0006pQ-HG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719927514; x=1751463514;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oGpNeN+k4P2vWs603Aurvz0ql4ZMFUDCSPm9mmYbgic=;
 b=Sfs9O6fmYer35GqNB9pemGu9BUXbZks/pgb+jYCXoHo8uutygDLUtP4L
 PU7ZjzDX7tyPrqSOa7UyN7mPDwb+ZUWpu79NY0qLLyPXV1n4WY4DX2CWv
 hraKrinwjwMb4g9IHU2IakSrTkDVtAJIBZmbWOL9X2iZcS3IlrytCSbR+
 J//fyxmuZ78qqFzjQ/ZFbDrAsyY5fDPelDIQCG0tMB4aG9e3TvnVuNWsI
 232fyCUCygH1eT2oTwH0t+q7pJ1Ynp+qAzUEt2wVn9vqLiGV/PrPyE7kx
 S43WPAb48ej3cOnKSExkcL3kEtX9H5fMPYh1MTnt2L1A2QwzSFHTU3jyn w==;
X-CSE-ConnectionGUID: DZGIboa5Sg+fkQqQAAyL5w==
X-CSE-MsgGUID: vzT2n50BTDm1JRMJ4397aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16929432"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="16929432"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 06:38:31 -0700
X-CSE-ConnectionGUID: t0V7fJxxQDWeGbNj8t3YmA==
X-CSE-MsgGUID: 0kLLduOmSQeWrbdTloJaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="46331986"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 06:38:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:38:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 06:38:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 06:38:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElVgfgfxWmwzqf3FU+MNV49iFXZjSCZJNFMwtgxUsvgueZC+Bj148Wldo/vlkYJb+swAQRpuMTLk3KIJQ+uab2hyAfE4K8VrRAtybDUFmjDZXZmSB49BA6PZyj6Vth6H/yzKcZL4qsHqWof3FAcaMR6xJXuvKankvojREsRCh3QVTZEcGkefJcVEVn6AcfnNCcnnLLFxtnfIhjRxCzwSDQuJBaGfvwn4olYG7UtkeIds2CdqpmmRRmJEVgS2TtAOa63hRl8vZ/a21lTgX9nqheqVqgEneiMlvoY4u58gkScmVvQO9ejr9odnzgSz25uORjKxGXMv8TuEwt/Kjbvqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgRhkHVWG2lzPKN6aVskDMBsCvVOd0wcs6jJDVYNsgY=;
 b=FnT9fKQ+v5EMye9mfqeW+QOxRfSFeuv28Qcq0uWjhFjEnv/fLJ9QuV9YPDHJ19rzJrpGvYQO9+EWuX2ytMVsQm7l0hJUTucEWl8qHIKWoKm261nejjf2gcg/22NcAFVwj7cTELDY67jVZueqxVRUOwOfygoKZ7kYrDjCz3fnGhREcdHg0BIs5UZHFQ/Msa5PiXybVUfCC3OTEJ+EG3XeGhJTX2MO+ZEJXBkIMTbJs/RTLSiNgIOJDZ8Fm7qOSBZkbRnnY9/syCGulE9CifbYZeg7HXtnduxBP3C1VFE8IzLsEtlXcF9oTzl2ikA55qkxCw+P3PMsX4FSGwQj9BXwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 13:38:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 13:38:27 +0000
Message-ID: <52efc1b0-5451-4e9e-a05d-4db360d3c573@intel.com>
Date: Tue, 2 Jul 2024 21:42:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
To: "Michael S. Tsirkin" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
 <20240701160122-mutt-send-email-mst@kernel.org>
 <AM8PR07MB76020A044539A40485F91F0A86DC2@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <20240702081352-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702081352-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 6178ee9c-efc3-4625-197b-08dc9a9c40e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZCt4VTgzYUJTV1ZneEFBelVlckZNSDkxNlZJR1RWcHBjR050cG02UEVUSW5U?=
 =?utf-8?B?UzhUcmpxQkM1Q25wOHRTTGs3L3FWaEMycExpZzY0bno2MzJLVlcwckFvL2JS?=
 =?utf-8?B?dGFzYkk5Nzgybk1DOUo5UVFyWmpocHNibGI1anV6WlV5ZGtxeWJMSTk4T1Ju?=
 =?utf-8?B?VFJFS2ZTTkNPRzFvWEQ4eWQvVjIrRFR6RFFQc1pCR1dHQkNvbk8yTWNvL0k4?=
 =?utf-8?B?UDE2M1FDMGdEaHQ4NkpRa3Fac0lZN3RUcG1mYk1BSkZXWUk5ZENramxhcWZv?=
 =?utf-8?B?NU41d3NXdVIzNy91YXFNUUc4YlVzcG04cFBXYVJNYk16d2E0M0xiNDZGM2tj?=
 =?utf-8?B?REQyd3RCby9zTENBU3hxNDlQcmxVd0ZSTUszdVgzb0s4R2VzdHZ6Q1NNU1E1?=
 =?utf-8?B?aXNrbTNqdlhjeXFXMjFjZHRLUWZLMkQ4RjZNMnhvc0cxcWZMZW5ROUZDZGsw?=
 =?utf-8?B?ayt3WXYyWU9yejBicjlORjdESDdBbk9QNCsrRWlBYjl4RCtRMGdtQ0RGMWNS?=
 =?utf-8?B?Nm1FR0hubzJERnR5ZFd4Z05BQXZMRjBQdlVxL3JVSm1DV1JJeVVtd29MWjZa?=
 =?utf-8?B?MmdjZ3BxRTRJK3FkQkt5ZGlldUxuNU1ZRGd2US9HQlB0UDEvZzJNeS9UdWJy?=
 =?utf-8?B?ektMbkRlbGNWazZpQXlaZmRORGFkdG1SOWpMN3RyUnFXR0RHWlRnYkVTMW5u?=
 =?utf-8?B?REhlbnNTNGd6a3ZRTlBPMHk1ZUJxWllOZlF1Uy9VR2xYTnQzM1g0dUYxbFR5?=
 =?utf-8?B?RHcxT2ZXeXFGOUhEQXR1OGI3SCsvdmFGMmxVTWR1eFhiaHVzT25LVElYRTRx?=
 =?utf-8?B?c2g0ZmJNcWFCUUpEbDVLeHloUS9qd2MxdHpYaStiTzQ3YkMvRGY3L0FBUE96?=
 =?utf-8?B?NkVQeElEL09EV1JPQ0ZHcWRaejdLTjhHTU56TEZRZ1k3MjBjSWhiZ3lJZmNO?=
 =?utf-8?B?SnVRL01QQm9ieFlGdUdhWi8xMGhwRXU1UzhnNHF2TFNRTWZEWENBUnpYc2Ix?=
 =?utf-8?B?RjdLN1pkNUNoL2JwSVZXcmJVa1ZPOFAyazg1QzQwdWZzVCtJUVlodkRnQjVT?=
 =?utf-8?B?b1BwaGVjcjQ1VzdXWHFjcVE4OE5lbjVlYjNRQUd1cjdOQ0JjU0dMSXJhRFJH?=
 =?utf-8?B?VmZXQ20zTEdmSVEwN3ZDcFlJY0NTVVdDcWlITjRSZlRFcGxwaXRpdVZnQndD?=
 =?utf-8?B?SFdmUXRYdEZnNEhNTEJPSmNSSkVmOExuRjQ0cnRpWXVZTGxJOERxU0RlVmJC?=
 =?utf-8?B?emJVTVNOelUvM2xKL3BSOEVTTURZalh0d0FGK0FsRXA5MXBuRXRUYy8yZExI?=
 =?utf-8?B?c3h2UkswWTJ5SmRCWGg4T0JpbjlFckFSV21aTlJBMXJ3RjhVbEtNV21mVjh4?=
 =?utf-8?B?b0tRUVpMM09ZL2tHeXlobjNTVVI3T2FoKzZGdjZJUUkvSEdtT3IxMFVBR2ZN?=
 =?utf-8?B?Z2ViUjZDWEhSY0ZERlFIbmRhSkttRDBiZlN3VFBpTllocXVsRHRpcDRaRDh2?=
 =?utf-8?B?bXRtbVpNeXM1MWlOTnRKdHJ4MGp4ZHdmTDlsdW03VWpuZGN0MFFzRC9TbE5B?=
 =?utf-8?B?TUx6d2FZbmhSb3duRDM0NVRVbTg4S2MyRFdFeWJQK3Y5aU1oS2lXQnNvWXpL?=
 =?utf-8?B?VHBwekpjVWFWTHhCdmhuYko5OFVGbFNDUXRqUkgzaFEvTURGYVAva01FWDBE?=
 =?utf-8?B?b1NZUThtdFV4dHNja0N6VU9LN0REbVVHWDZrNXFvNlVzb0IzeHUxY01pQjZv?=
 =?utf-8?Q?RMzkef3QgvaxJqqByk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amg3TXpyVVZEak8zOFMvKzJWZG9kVzlaYXR0NUEwNndMTi9vOEpFRENobWZm?=
 =?utf-8?B?R3N2V25GNXRaaUVLTXFBbTUvRHhZNGd4ZWhFdmFsVDd4NzFpaXU5aDRiejM3?=
 =?utf-8?B?YVlyRnRkV1hENFNmK284NlhCMU52dE9lTmNrTFhWWlowUm81cTRnUHY3U1Rh?=
 =?utf-8?B?dXZJTHRrWk0vYnVXVG0rNHlKMStUM09NdTIwM1VOV1lKbkFGL1JJUzRZQnRK?=
 =?utf-8?B?S09ldFdJK0FUYnFOcFNMTUtXMDNBQXhwQUtLSlZScVQ5ZEphRzhNdDNES2VC?=
 =?utf-8?B?WjJTUUxKdk5zb3NpMzArbWw1NU9xVyszOENmOGQxMVJwTzZ6T0RXZ3pjTmRT?=
 =?utf-8?B?UllUYkM1Rld4TllicG1uQXk3M0VIaDU2T3ErdCtnUlZCU0FPL1NPWXhqN1RO?=
 =?utf-8?B?UUx6MjgwS3MyS01qM3ZGVStlaDh0bUUvNlRlT01sOTBabVBjV1FTRzRTelFP?=
 =?utf-8?B?M2cySzc1RU9ySHAxRmxBZVQrcGpmTUZ0ZThPbXFyaXBTcTFqT2k4Z1dBQUNG?=
 =?utf-8?B?MXhxMVRYditUN0U3YmRJN2JqQ2VtY3Z5eXNQNEVmT2lEK0orcnhvN2lCMjRh?=
 =?utf-8?B?ZWRFRm9lUHFzWUZ0bDkzV2VvenRDamhvRHBOSjlxcE56T1Jjd2JNdVNReUdW?=
 =?utf-8?B?ZDNEcHUwcEoyY2krdElOWXEwMUY0cGdhTEQyalRBeTk0Tm04Yk52eUEvcUZk?=
 =?utf-8?B?UUloUFhPVUlPSjl1MGo2MDFsYk1CeXpIb2NYbU5wcTNpYUJmNDlFeHNmRWlS?=
 =?utf-8?B?ZWNLM0VqY2xQaEwzNTV2a25OYkVqQUlIdy9neEJIaFBQWDdhNEg5aE5JWE9J?=
 =?utf-8?B?ZHRqem91OVIwTmRJd1Jvc1NOR0djYllvL1JWT0w5UGdSWVBqU1h5R2E4RWRu?=
 =?utf-8?B?Qk54dFYxSmE2d2hjQVJYTkdrSW9zT20vaGZkelBVUWt3K3NpbDhUc3VMV0Fp?=
 =?utf-8?B?WCtHeHRBZ1VUVkYzZFpaaEY0a3BIVzIvVmdoSmtjOXE3VHZJOUNkdXJiOWZW?=
 =?utf-8?B?REY0L3NlVHptK1Jrc0cyNXg4V1hwelVFSC9mcFExcE4rN3Z1Z1J5cG1Mcm03?=
 =?utf-8?B?eHBLWDVCSVFNZy9hTGhjblFxZEtaSS9KWDlvZHZYUnFWdythbFM3Y1M2MXVP?=
 =?utf-8?B?Tk9DaFZpQlFSRkMxWWp6M1JTZFJCNUxXWlpYbGkreTU4Mmw1cTZXZk12NWg5?=
 =?utf-8?B?ak14dzQ5LzZFQ21SZ2xSMEpWZGpYdU5EOEVQd1E4bFR5SnNtSnpEUUxkRWNt?=
 =?utf-8?B?SVVJQzBDWDFMVFdKKy9lWXhKVGk3eG5haFhWVTZJZWhNZFdNcWxlb016WGo4?=
 =?utf-8?B?a0ljeEc3ekZFQVZPM3lNL2JFQmVEcG9wdm9Vdk1XRVBIR2dpVEZkQmFFY0lt?=
 =?utf-8?B?c0xESnRlcjc4Q1AwYnBLNm93YVpFd1lqVHMrUXphWFArUjRqdmltQjdFbVVy?=
 =?utf-8?B?RzFMMlZQUU9INCtuWTROTDVHa0ZnMCtuRGdyY2NGT2FvcTR1VEtBUyt1ZkNS?=
 =?utf-8?B?Z2dFWTdyZTJHM1lPUEJCUU1PK3RWcXovcDlkdkJJYmlieUZ0SGIwNGVKZlZ6?=
 =?utf-8?B?MnNoWjhIWGRMNDM0bEo3SXRZVE9uWkthNmlXQnFtT0pZTy9zanRNdzZmUHN2?=
 =?utf-8?B?R0xaT0p3SU1nQTcxYzRRR1MyVnhzZjZjYzdyc256a2FjS2NLUi9ZWkxqcFZJ?=
 =?utf-8?B?Nkg2Mk1uQisycStrSXliT3pLYkFyZFhIRTNMWTFQQVR5eFhBSTBXa0toamtI?=
 =?utf-8?B?QkJVMUJOTHhvTDh3UmZaRnFBdEIzUEJNamJjbjdTbHk2QkN4Y29OVmpZcVFZ?=
 =?utf-8?B?cWEwQlB5NnZJSVdFYUtZVjNqVlB2eHBXd3FPaUYyQldXNTJQcVA1c3p0YUxy?=
 =?utf-8?B?ZkVidkZnL2dRWjdZaFowZUREOVgwNDN2Tjd0eFBqZ0Vkak16QlpHN1ZXcjho?=
 =?utf-8?B?UVh2Rmo5aXBGQWVrUVgwcXVFTU8yQkRMU0loSkRtbjB3YjNxTmlJaWN2R0li?=
 =?utf-8?B?ME5HOFZNY1hpc2k5Wk81NVNGSFZFNEdoR0h4SW5hNSs5ckZsRDdxKzRER1Nw?=
 =?utf-8?B?Wlhid3FrTlE0cEhzaFptOFdGckVGOUtBTkVJMlI3bXlLQllQNGRvWHNMdDRs?=
 =?utf-8?Q?F73PEYWowAY/2q7dlTOPrqlLT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6178ee9c-efc3-4625-197b-08dc9a9c40e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:38:27.7366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXqRj+Wi4sP5yd+nZmag1bsF4vJ4ZqQOWUQpEt1Phcie9XF6rxjpFw04NK7NPsjQ23mrzZ4g7etywQQ6pBEURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2024/7/2 20:15, Michael S. Tsirkin wrote:
> On Tue, Jul 02, 2024 at 05:57:57AM +0000, CLEMENT MATHIEU--DRIF wrote:
>>
>>
>> ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: 01 July 2024 22:02
>> To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jasowang@redhat.com
>> <jasowang@redhat.com>; zhenzhong.duan@intel.com <zhenzhong.duan@intel.com>;
>> kevin.tian@intel.com <kevin.tian@intel.com>; yi.l.liu@intel.com
>> <yi.l.liu@intel.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.com>;
>> peterx@redhat.com <peterx@redhat.com>
>> Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
>>   
>> Caution: External email. Do not open attachments or click links, unless this
>> email comes from a known sender and you know the content is safe.
>>
>>
>> On Mon, Jun 03, 2024 at 05:59:38AM +0000, CLEMENT MATHIEU--DRIF wrote:
>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>
>>> This series belongs to a list of series that add SVM support for VT-d.
>>>
>>> As a starting point, we use the series called 'intel_iommu: Enable stage-1
>> translation' (rfc2) by Zhenzhong Duan and Yi Liu.
>>>
>>> Here we focus on the implementation of ATS support in the IOMMU and on a
>> PCI-level
>>> API for ATS to be used by virtual devices.
>>>
>>> This work is based on the VT-d specification version 4.1 (March 2023).
>>> Here is a link to a GitHub repository where you can find the following
>> elements :
>>>      - Qemu with all the patches for SVM
>>>          - ATS
>>>          - PRI
>>>          - Device IOTLB invalidations
>>>          - Requests with already translated addresses
>>>      - A demo device
>>>      - A simple driver for the demo device
>>>      - A userspace program (for testing and demonstration purposes)
>>>
>>> https://eur06.safelinks.protection.outlook.com/?url=
>> https%3A%2F%2Fgithub.com%2FBullSequana%2FQemu-in-guest-SVM-demo&data=
>> 05%7C02%7Cclement.mathieu--drif%40eviden.com%7Cf5759aefcc5f4e7d4e6c08dc9a08d29a%7C7d1c77852d8a437db8421ed5d8fbe00a%7C0%7C0%7C638554609882544195%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C
>> &sdata=2Gza1VD7hKr1Sx3fOLoRh6tk3taSPKTn5nfimhPLz70%3D&reserved=0
>>
>> I will merge, but could you please resend this using git format-patch
>> for formatting?  The patches have trailing CRs and don't show which sha1
>> they are for, which makes re-applying them after each change painful.
>>
>>
>>
>> Hi Michael,
>> I sent the series again without the trailing new line.
>> Tell me if it's better.
>>
>> Is Zhenzhong's FLTS series merged? If not, it might the cause of the sha1
>> problem you are facing
> 
> I don't think I have FLTS in any queue.
> 
> If your series has a dependency please specify this in
> the cover letter.
> 
> Alternatively just include the dependency in the posting.

seems this is the dependency.

https://lore.kernel.org/qemu-devel/20240522062313.453317-1-zhenzhong.duan@intel.com/#t

> 
> 
> 
> 
>> Thanks
>>> cmd
>>
>>
>>> v2
>>>      - handle huge pages better by detecting the page table level at which the
>> translation errors occur
>>>      - Changes after review by ZhenZhong Duan :
>>>        - Set the access bit after checking permissions
>>>        - helper for PASID and ATS : make the commit message more accurate
>> ('present' replaced with 'enabled')
>>>        - pcie_pasid_init: add PCI_PASID_CAP_WIDTH_SHIFT and use it instead of
>> PCI_EXT_CAP_PASID_SIZEOF for shifting the pasid width when preparing the
>> capability register
>>>        - pci: do not check pci_bus_bypass_iommu after calling
>> pci_device_get_iommu_bus_devfn
>>>        - do not alter formatting of IOMMUTLBEntry declaration
>>>        - vtd_iova_fl_check_canonical : directly use s->aw_bits instead of aw
>> for the sake of clarity
>>>
>>> v3
>>>      - rebase on new version of Zhenzhong's flts implementation
>>>      - fix the atc lookup operation (check the mask before returning an entry)
>>>      - add a unit test for the ATC
>>>      - store a user pointer in the iommu notifiers to simplify the
>> implementation of svm devices
>>>      Changes after review by Zhenzhong :
>>>        - store the input pasid instead of rid2pasid when returning an entry
>> after a translation
>>>        - split the ATC implementation and its unit tests
>>>
>>> v4
>>>      Changes after internal review
>>>        - Fix the nowrite optimization, an ATS translation without the nowrite
>> flag should not fail when the write permission is not set
>>>
>>> v5
>>>      Changes after review by Philippe :
>>>        - change the type of 'level' to unsigned in vtd_lookup_iotlb
>>>
>>>
>>>
>>> Clément Mathieu--Drif (22):
>>>    intel_iommu: fix FRCD construction macro.
>>>    intel_iommu: make types match
>>>    intel_iommu: return page walk level even when the translation fails
>>>    intel_iommu: do not consider wait_desc as an invalid descriptor
>>>    memory: add permissions in IOMMUAccessFlags
>>>    pcie: add helper to declare PASID capability for a pcie device
>>>    pcie: helper functions to check if PASID and ATS are enabled
>>>    intel_iommu: declare supported PASID size
>>>    pci: cache the bus mastering status in the device
>>>    pci: add IOMMU operations to get address spaces and memory regions
>>>      with PASID
>>>    memory: store user data pointer in the IOMMU notifiers
>>>    pci: add a pci-level initialization function for iommu notifiers
>>>    intel_iommu: implement the get_address_space_pasid iommu operation
>>>    intel_iommu: implement the get_memory_region_pasid iommu operation
>>>    memory: Allow to store the PASID in IOMMUTLBEntry
>>>    intel_iommu: fill the PASID field when creating an instance of
>>>      IOMMUTLBEntry
>>>    atc: generic ATC that can be used by PCIe devices that support SVM
>>>    atc: add unit tests
>>>    memory: add an API for ATS support
>>>    pci: add a pci-level API for ATS
>>>    intel_iommu: set the address mask even when a translation fails
>>>    intel_iommu: add support for ATS
>>>
>>>   hw/i386/intel_iommu.c                     | 142 +++++-
>>>   hw/i386/intel_iommu_internal.h            |   6 +-
>>>   hw/pci/pci.c                              | 127 +++++-
>>>   hw/pci/pcie.c                             |  42 ++
>>>   include/exec/memory.h                     |  51 ++-
>>>   include/hw/i386/intel_iommu.h             |   2 +-
>>>   include/hw/pci/pci.h                      | 101 +++++
>>>   include/hw/pci/pci_device.h               |   1 +
>>>   include/hw/pci/pcie.h                     |   9 +-
>>>   include/hw/pci/pcie_regs.h                |   3 +
>>>   include/standard-headers/linux/pci_regs.h |   1 +
>>>   system/memory.c                           |  20 +
>>>   tests/unit/meson.build                    |   1 +
>>>   tests/unit/test-atc.c                     | 527 ++++++++++++++++++++++
>>>   util/atc.c                                | 211 +++++++++
>>>   util/atc.h                                | 117 +++++
>>>   util/meson.build                          |   1 +
>>>   17 files changed, 1330 insertions(+), 32 deletions(-)
>>>   create mode 100644 tests/unit/test-atc.c
>>>   create mode 100644 util/atc.c
>>>   create mode 100644 util/atc.h
>>>
>>> --
>>> 2.45.1
>>
> 

-- 
Regards,
Yi Liu

