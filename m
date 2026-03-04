Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAACEB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiti-0004Jk-Np; Wed, 04 Mar 2026 04:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vxitg-0004JU-Fn
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:52:04 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1vxitc-0001uP-Vm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772617921; x=1804153921;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QlhW3IR2QmslmcYVHT+BLB+fpGuwVFoHfy/jcEH2+cg=;
 b=QkcbgtSyD9NtPF59z67X+eTJkQHLQYtXwkaYmUrVeOmYUsID86RWLpuh
 zGRZDhtv2w3ijuS+kR8TSbgNZnJ/LkPe5jG3UGoav0K9PyR0WfcPVg7nZ
 AZv0Ff4lEZXhXfUFz30px6oiAeNZEOX5OJP/67KcsQK5AYblJNWmlMl8S
 7v3UkyRkZFq0Dyrmaq7E4fW2gbW5FO2Z16MHi3bm5IMQ+4fU45zEiOE6J
 +fygUIYO6xGrN1+3o6D9PhiAkMf/SlLVi9udn0CRuE8/QcPgHWF1hW77v
 InWTyntuhax/Hc/xBr6C0GKIiMHZhW1Cbuw5UYON6rKI1CWzE/nUAH2IW g==;
X-CSE-ConnectionGUID: KkL2p+zzTXKI3+M1CON5kw==
X-CSE-MsgGUID: q5OAh8sHRLyU7ZC0vkuuxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73640926"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="73640926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:51:57 -0800
X-CSE-ConnectionGUID: nREJ6x0GQ1612+u65qRC/A==
X-CSE-MsgGUID: S8m+aqKISNm6J+Ygdo49Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="223285900"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 01:51:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:51:56 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 01:51:56 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 01:51:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCnrdZ9HhR0f48P73jUQXA68Prrf36pB3CSudss+WtIIfRiWm1ZOBMAX88e1UR37uESZDdvWvr5cMUAXL6V7qmugEH2NPAzgMzWp/RAxhwi+ZOBiI7vcSejpHWmEk1dF2Pm2eemhI41s2BXGfk4Q+T/EyycXcx43RiUhUQQzQNqYc8OvmTzs1Fs2V7JZ7O8P7lBQbWQ44Vhd8EQMGDYQhNbh6VnoCHLiEM7a/oM1Y3EruxmTNbDYdXXEexpI+fUIeHynzJTPOcnmL9hmsrJChpO3VluLGooRSr4ARLvTaFuUlYiA/jAvqKZGMyEIMRprL+HSgjgtItShYhdo534KYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDVzC1yhGWlSJz4ULlrl3aqYI23d/qPsjkRwqG9Bdgc=;
 b=mnYCYtHx4iIlQpukVAJEU1I+bHMdQbQSthF9IOXXCtNsJW9D5khBmTsgShDwSjEVLIy18I0PWTiTKp/enNbCGdEezd8asLwDib2QgAJVlFXyjsLPAJjolfmbEaVHVBlY+5ReGzxQTg7yIAWDR2SdVDseY83j0ugWNn4IW0NUrhhVp6MYuw/LTdk13JPQmFayi++1SuLVvlq7jd+wj5ihOCjk7tEJqapgNgBAdJZL1lexKiG/1CREZYEm4YyrUAW3P8qRHuP5AxPsmz9p8KNf1SvqbcfAyVG+Hb1MC7SeiqXx2q//VQWS/n58h1gjsK9ZEjMEFmKdRKrFz06yGg306g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 09:51:53 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%4]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 09:51:52 +0000
Message-ID: <02381fd6-dd40-45e7-bd7c-f97de5618df1@intel.com>
Date: Wed, 4 Mar 2026 17:51:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] system/memory: split RamDiscardManager into
 source and manager
To: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>
CC: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>, Fabiano Rosas
 <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
 <peterx@redhat.com>, <kvm@vger.kernel.org>, Mark Kanda
 <mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-7-marcandre.lureau@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: e37dbe17-e971-455f-a333-08de79d3a9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: 7hYsvEeEK5LsT7NgkxA3WBJpJbECAt63Hf7pZl1LHMtt0ig3coCPb0ruqCU9U1YG1oS9dKQCEOgg8BMqJirkkYq/lBj6pOh78xHVjifKOylljo+5nHwQh31gIw2ttnnStYHo6n3aDNcJO0uL1I2u+WJKQHYR89Ka1pnFZHo7LwBbcmiQu8Wt8q2uV3R2lsWPrRLJeRbiU7N/Qyx+EIRVG1mjnyf+pB95ULITNpHWnE0P1uyt9nybYkTuva6TdOJSj2ys+DvDqSjw4ccCgiuoJOMmg/Pfi+1B46HYxscJn98O1aYoMMqMjIfNHJHV/Vf8HuDm1Vd49jVP5dTBJtCHIwsZAju79X4pQLWd8amDMqExIE81LpsevbqbKjn7xomLswvh1mTfyIEpqXqEEnlOSj0u+Z8kqhy5hm7ZxdPGARzbz7KNjVauOzNOJr9dxMuUxSZSEyhHcTMV1CGRs2CDkwpa3qb/dgNAYESPAUkxROHDxwCPh3M4y3TKZf99NFNcY3JZN1QLWla74HvSsGIZzOijhAZf0Xml1j7ZNcmJcE+HzB+FO2tuiNXBtjmLGqTGBDea/8Qqao/YBrfyqfW6Rq4/YnItJd6CqsPGl38ke/xtGz/exH6C4qCo8bJWDht5n0tYgj3fr7491XIj7y8vrDRuc7tEzqAv1D3aOWHgkNoe4DCBxBNsAOpLJmNyQrLO2e2vqO1u8WU3duV1fsO8boVeIHd72Me5BKMGU+QCT9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlMyc1lyMFIxSzZ6UWRJeXRZbzRVZzRUOTV2RHRxcFZwUklRakcrSWV3aWZI?=
 =?utf-8?B?MWdEdlJsQmFmOG4rMWI1cHhjczhZSFhGNnRuYW1MbkpEZU4xbjVVMkZYN2dO?=
 =?utf-8?B?Rk9qWjJlbytZWEMwc3ZYeWlPZmtZWHRHZThvWEJVLzVJNU1ZTzNOOFZqbU82?=
 =?utf-8?B?VVNjSUJXYVMrODhaT1VxV2RJb2J6VGpncVQ3Q2FjaFpnZHZnYkNTQytxbHpy?=
 =?utf-8?B?bjdRUjVkZXhWbWV3VStRWnFBTzlHTDluYXlYcVBLcmRXZy90MnE4WkFuYStI?=
 =?utf-8?B?N3Z1N3d4cUNsWDUxWHlKWVBXUy94VVAxME53Q3FZWkQ1ekc3NWNIZW1sK0J0?=
 =?utf-8?B?ZEs4dk1iaVV1cktiTUUySXJZeDJtQjJGZXI3RDJVWjdJaHJuREJmNmJ4bW5L?=
 =?utf-8?B?ZHczOE1lVnRDOFlUTzBXWkhKQXNoL2pBQk1PaVc4ZS95SEFNQUlWNmRZVy9O?=
 =?utf-8?B?NG9GZXNPSWg1enJvS3NkUGM2enN1NXRjTFhoa2ZQTUJPU09zT2tEZ2pUSlh5?=
 =?utf-8?B?cTc4Q2EyU3lqQ2l0Vi93L2ZOVWdBZk4wRUxrZW9mTFRzcnpva1JLbTRYOFNI?=
 =?utf-8?B?U0tPTTJXVjFIL1gya0xMeG5FVDJLbXgvY25ybE9kZmNnZUxmK2kyTkpWcE82?=
 =?utf-8?B?QUdScU9rU2dxKzFNMHRqSmJ0NnZ5cGJJNUo0bGl1VWtrSkZYZ0dndGxJZW45?=
 =?utf-8?B?Qyt4eHJob1ByMnJTdUFESDdzUDAwNHpONG1ONVY0K29UeUNHZHZEWjk4SDl3?=
 =?utf-8?B?S1BXcU8zTVhyMlhRSXFWd0FUUW1HWG5LSTdQSS83VW9hUklmSHo3V2VBZnBm?=
 =?utf-8?B?bUg1ejhOVFZYZndWUHl2WnBDOWc2MGNzd25hei9OcnBnMHRRUXl4QUxxdXZO?=
 =?utf-8?B?Q0xzZk9WSGtPY1l1UVZGdGg5T2t0NW5Gb2IwbFRJNDZTZnE0eUNKaVVxZXcw?=
 =?utf-8?B?QWR3c3FPZUJEa3hxb253M0tQNWE0QU5oNVd1UGhnVGp4WGkyUlVlL1B5T0oy?=
 =?utf-8?B?cnBYVVFFdlBkSFlPemprcWR5MkhaT3NCdkFlTERRelVCZkVGS1F0T1RFVVFw?=
 =?utf-8?B?eExJTTdzcVJqYU53TEsxb204bTJ0QmV0cFJsVUxMRlA5SzRaTTRBUmdjTjJB?=
 =?utf-8?B?a2JIeVVieTJJRVBmc29nNzB6R3hvazh4c1hkZGtIMHcwOEx0ZnZFeVJERU11?=
 =?utf-8?B?L1FuSDNRdTdRT3lJRUNaOFNIN3RTSnNDb3FvQW1qLzFCV25PbHViYTViTUl2?=
 =?utf-8?B?TGVCeEJCeFBoNTlURng0eGZ4a0szam1NQmhhc2hCQlZiWEpRbFZ2QVppV3FG?=
 =?utf-8?B?NVpqbFZ1N2ZIWkZYczl6UEx5ZkRDMWtQT3VqN2ZSYVBLQUZRbStjdm5CQlBP?=
 =?utf-8?B?eEhXL1ozZHNiTnozTWd1VGVaUXF6U25FaFY1MVJXSWxxNzRZRWlQOEo2WlQ5?=
 =?utf-8?B?ZDZjV01SQ0dTSUxuNDdZWWxEeGtWUy9mU1I2MDJJNHVJUldKa2JYT01zZFA4?=
 =?utf-8?B?aDFKK1NSSVVlMjZUTkQrb1JSTk9obm1uMHBJUEY1S2F2aVZuTUYwanRLb2tt?=
 =?utf-8?B?eVpnL3FtQlJGYmpMcEhuY2xEbHM4THRlNUxJVzlabkViWTJ0dDV6c1BGRkxi?=
 =?utf-8?B?SlJCUU9UYUVsUnBZZHk3WHRleENCRzV1UnhpR3hJSktvOXhQZ3F5TUsvQTh2?=
 =?utf-8?B?M1pOYjZKM1J6V1FrRUVsc0Mxc1p6WlNHTXcwV2tsVDY1dkh2allkaWdPRGpB?=
 =?utf-8?B?Q0NjVHBteGlWRkE3SGlNKzBiN0J6ZXJXK0F6czRkU256Vy8zalJCY2w3TlJn?=
 =?utf-8?B?Nm1XQ0dxZ3Yza3lVK0V5L2NxeUZxa2lyOWJ5S0hiYUdhR2VRSVkyWTJpaVpD?=
 =?utf-8?B?dldvVUpoaVpDUjRpVG1aL00rQmV3UW1HakNCWW9ycStLV28xTm1SQjYwVSt6?=
 =?utf-8?B?M3lUU25XVTFXN1pHbkxMdDNlR3F3dHc5ZDZad3FONlRLNk1mYjZPb2dXVVgz?=
 =?utf-8?B?eDI4dEVzM3NmMSsvK3V4UTdBY1pHZUQyN05VUDRlNlhXSzJuWnJNVzBXcWxJ?=
 =?utf-8?B?L1JqdTFpWEljV2p1MVJNMTJscXpWS09qbmt3ZUd0MERZWFpHWVM2Y1N6c2oz?=
 =?utf-8?B?U1JvWEF5SFBrSHlFNWFQajF3emV3N3g4bWNwMm9FWmJGbFljakdta2F5MUdO?=
 =?utf-8?B?Y3lsZTZ3aXpCQmQ4NExQUzdoa2t4azdJU3d6d2hzVUZLQVdVZzhSUHZVaW1a?=
 =?utf-8?B?R2hNcU1IdlpvbTkyRHRmcTdjUjdGRUtZZ0h1cmZwNmw4THJ4TzV4bm9rdTdR?=
 =?utf-8?B?UlJKTlJKYnpBNXFudnNTTDUra3RDaXd0R0FtNjdRMDhxcHM2MndvUT09?=
X-Exchange-RoutingPolicyChecked: USzFtFnEYTxRdUpytlB1zIlyf9vRHtJjaml8ORSXgyA/cB60BCF4n1+uRtXtneDFv/4w5FcvHQ2Ks37dbCCsK0nrcJJkwbM5PTZsO4YfqooXJuDxMUmS0fATAoppMMyX1aQHBSOSiXIv/jKACtAhZGEql3CMEFPH6riyrb9aTB/7T6DomBKib7vgT9KzmsfEosXOWUlNWzicpa/T9WhjWoXexWLgRxpke5aQU5RXAc3UYUfNjCShTx8IUEVQs06U0Vwc/c3f81Alb3LhhHZYSXlNtu3g9dg06HGVTWOD8ijEpYyiMHx14OxjooFEk9ZQyszZPYat+uRp1PhS+r5g3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: e37dbe17-e971-455f-a333-08de79d3a9ad
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 09:51:52.8526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmnhD3uKueSweRa+Sdg24vK4neMyFz8oT5+QeOIFKIEBRl4HL/J6ww5MZC3ADiLZG1pMYLaUwl+kKrI+WrXg4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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



On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Refactor the RamDiscardManager interface into two distinct components:
> - RamDiscardSource: An interface that state providers (virtio-mem,
>   RamBlockAttributes) implement to provide discard state information
>   (granularity, populated/discarded ranges, replay callbacks).
> - RamDiscardManager: A concrete QOM object that wraps a source, owns
>   the listener list, and handles listener registration/unregistration
>   and notifications.
> 
> This separation moves the listener management logic from individual
> source implementations into the central RamDiscardManager, reducing
> code duplication between virtio-mem and RamBlockAttributes.
> 
> The change prepares for future work where a RamDiscardManager could
> aggregate multiple sources.
> 
> Note, the original virtio-mem code had conditions before discard:
>   if (vmem->size) {
>       rdl->notify_discard(rdl, rdl->section);
>   }
> however, the new code calls discard unconditionally. This is considered
> safe, since the populate/discard of sections are already asymmetrical
> (unplug & unregister all listener section unconditionally).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-mem.h |   3 -
>  include/system/memory.h        | 197 ++++++++++++++++-------------
>  include/system/ramblock.h      |   3 +-
>  hw/virtio/virtio-mem.c         | 163 +++++-------------------
>  system/memory.c                | 218 +++++++++++++++++++++++++++++----
>  system/ram-block-attributes.c  | 171 ++++++++------------------
>  6 files changed, 386 insertions(+), 369 deletions(-)
> 

[...]

> diff --git a/system/memory.c b/system/memory.c
> index c51d0798a84..3e7fd759692 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2105,34 +2105,88 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
>      return mr->rdm;
>  }
>  
> -int memory_region_set_ram_discard_manager(MemoryRegion *mr,
> -                                          RamDiscardManager *rdm)
> +static RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
> +                                                  RamDiscardSource *rds)
> +{
> +    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(object_new(TYPE_RAM_DISCARD_MANAGER));
> +
> +    rdm->rds = rds;
> +    rdm->mr = mr;
> +    QLIST_INIT(&rdm->rdl_list);

Is this QLIST_INIT() redundant since it is already called in ram_discard_manager_initfn()?

> +    return rdm;
> +}
> +

[...]

> +}
> +
> +static void ram_discard_manager_initfn(Object *obj)
> +{
> +    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(obj);
> +
> +    QLIST_INIT(&rdm->rdl_list);
> +}
> +
> +static void ram_discard_manager_finalize(Object *obj)
> +{
> +    RamDiscardManager *rdm = RAM_DISCARD_MANAGER(obj);
>  
> -    g_assert(rdmc->replay_discarded);
> -    return rdmc->replay_discarded(rdm, section, replay_fn, opaque);
> +    g_assert(QLIST_EMPTY(&rdm->rdl_list));
> +}
> +
> +int ram_discard_manager_notify_populate(RamDiscardManager *rdm,
> +                                        uint64_t offset, uint64_t size)
> +{
> +    RamDiscardListener *rdl, *rdl2;
> +    int ret = 0;
> +
> +    QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
> +        MemoryRegionSection tmp = *rdl->section;
> +
> +        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> +            continue;
> +        }
> +        ret = rdl->notify_populate(rdl, &tmp);
> +        if (ret) {
> +            break;
> +        }
> +    }
> +
> +    if (ret) {
> +        /* Notify all already-notified listeners about discard. */
> +        QLIST_FOREACH(rdl2, &rdm->rdl_list, next) {
> +            MemoryRegionSection tmp = *rdl2->section;
> +
> +            if (rdl2 == rdl) {
> +                break;
> +            }
> +            if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> +                continue;
> +            }
> +            rdl2->notify_discard(rdl2, &tmp);
> +        }
> +    }
> +    return ret;
> +}
> +

[...]

>  
>  static int
>  ram_block_attributes_notify_populate(RamBlockAttributes *attr,
>                                       uint64_t offset, uint64_t size)
>  {
> -    RamDiscardListener *rdl;
> -    int ret = 0;
> -
> -    QLIST_FOREACH(rdl, &attr->rdl_list, next) {
> -        MemoryRegionSection tmp = *rdl->section;
> -
> -        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
> -            continue;
> -        }
> -        ret = rdl->notify_populate(rdl, &tmp);
> -        if (ret) {
> -            break;
> -        }
> -    }
> +    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(attr->ram_block->mr);
>  
> -    return ret;
> +    return ram_discard_manager_notify_populate(rdm, offset, size);
>  }

This change introduces a slight difference, as it will perform a rollback if ->notify_populate() fails.
I believe this is acceptable since, currently, memory conversion failures result in QEMU terminating
rather than resuming the guest or retrying the operation. And this rollback is necessary if we plan to support
retry operations in the future. Therefore, we can retain this modification.


