Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46378C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 04:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftis-00053E-EA; Mon, 19 Aug 2024 00:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sftiV-0004z6-Ky; Mon, 19 Aug 2024 00:10:05 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sftiS-0002hE-Vq; Mon, 19 Aug 2024 00:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724040601; x=1755576601;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sb879EC5CaTzfzNEs8NXKnW/7ehdIHt8CJWWDASJLmc=;
 b=WYtqSZ2c4ZGsdoC3CCP3KXFXBDbI5PD95JRJoioHBE9ge6qp2qsaPFsK
 Of7b5Txg2ZyoAw6N0tTOVde8ddZG4yCCGHiAytQTlFRQwKvkO3m5fNfYZ
 VlW146VFU80wf/Ry5/iPojobYiMOYfMmcZCEg78sIsTqsN0ksqzXM356k
 +knxcc8Cp8sIVuNXflec6TSfWoJeqfsHz4aNdZwG4W3aVXIZnBew33c3l
 4NnAWv/KtwMDL7zOxzZJApgHpy5PaA+bJ4vuYl40GIZ0UxlKXiiJM0u4Z
 lDJEfIBpYJlKOMLtF02hTSMAhIia+8cYUCdZb8/C1hvqxJGCVmzBXPBqe w==;
X-CSE-ConnectionGUID: XR0tLFSzSg6jRkkdLcuXNw==
X-CSE-MsgGUID: xSLapn87Rq6ExsEzciDh5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32891449"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="32891449"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2024 21:09:55 -0700
X-CSE-ConnectionGUID: nGZFmMqnTxOnPaD0jeBkpw==
X-CSE-MsgGUID: wpr9ifj+Tuuya0KFvCNwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; d="scan'208";a="60239460"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Aug 2024 21:09:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 21:09:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 21:09:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 21:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+jPoXFiy+ngRArEhQQrNZfIxBxcyzF+Olr1EefRZMqnm6c04oUDrYf1YQM/ZxYIvZwlHkoAVrtU1faz7lL3Rb+doBUnidGk//Hdgfp7hhpdVdXr/EyOoRHv3Hg80WtSteYGB0e7d1n1qenK23FXijicP3Lj8x3MNl4jK/fpIXoiVWNQsr6/MpQHlFTksM5QYuimZpJzRtNFdq9nxake5dxOaboOjtlNaarwq3PRlxelVb3t/cvpL7uYMUMlQFqDNvPN8yMIjT0zGAi/jH6l1W241MgYFbXp/uvKNuohPZ3UIB8IwxZRVcsPPM+UcZMUco/g4MyToZRVmBYAD5B9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFFYN/p2mJrT02rMuzwtGLIspEkoqwxTGWllSpAb7a8=;
 b=ddJJOl9Pc8LGNCXWfTUvZLxTn7pDN/+0QxLIBnifGrDRng9fbPlWoEE+v5eDLAM6acrXglgHGx9JR1oidBPI93yg9nDsJwp80EpVA2S/5C2dcRm+PixktLx6caljxIz0YhRePJVGu3J2f3UoB0n55m1fq7+S2nrCPRF9InvTJ6GtvzmRVXOje+b5E8haS8VIvwytGGT+I2PFr9k+/2Ta9O+tp+Wl9RxAaMrMfuzfXPqOrzXTbWNhN4MeXG1W5pArYXtx7/0/H43EdeNq8dUEsCWCKCVH3qi9XiHrCOn3vDKrf4qFleK/cu0ehaj0Pvm9n4FYosdo++VuDuoKstfo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 04:09:52 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 04:09:52 +0000
Message-ID: <1179eadd-c0a5-4a46-ba85-4e2a9c60b727@intel.com>
Date: Mon, 19 Aug 2024 12:09:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Add Rust build support, ARM PL011 device impl
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: "open list:ARM SMMU" <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, John Snow
 <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, "Liu, Zhao1"
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, ARM TCG CPUs
 <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Pierrick
 Bouvier" <pierrick.bouvier@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 "Hart, Rowan" <rowan.hart@intel.com>, Mads Ynddal <mads@ynddal.dk>, "Markus
 Armbruster" <armbru@redhat.com>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
 <8f5f670b-313e-4172-a04b-ff8439bc4777@intel.com>
 <CAAjaMXYyggQuenzEt-cTpENAM5S46_Wi4iqeXjzLYoDrHXzj2g@mail.gmail.com>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <CAAjaMXYyggQuenzEt-cTpENAM5S46_Wi4iqeXjzLYoDrHXzj2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|DM4PR11MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2651e2fc-7b10-45ba-a415-08dcc004c65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVRMZDhsTnozZGxFK013cEdyV0lFL0M5L0gyckFWMWFZR0pCQWxuT3RKbUgy?=
 =?utf-8?B?RUNIdXFOclBuV29ZVUErdFJMdVI1U1V2U3Y0TzdoTEJGajRlU3BiUUpYUUxs?=
 =?utf-8?B?bGtzOHlTUzFVTHg4dWp6YzZacHF2TW1CU3psKzBsTzBzKzhHc1RGUEZZY1dL?=
 =?utf-8?B?YWdHck1MN0dUMHpOTzJXNFJtaVF2VzBDbGJRemlkOG5tZldQeXVEK0JHWjZN?=
 =?utf-8?B?TVdUbFpPbFBkOVFaR3FndjFXczQ3RnlrMDhqUHROYWgzRXBhSUNORlJncVZZ?=
 =?utf-8?B?VERHaWRxVzdxSjVoMnBLQmZwRUROZFhIeWlwYW9vWWVlbkNmM0ZvNmxqVEo1?=
 =?utf-8?B?ZjZaSWFhb3R0SkJjbjViaUkrSUYvSWZyRDRnNndwZmF5T2ZaT09mend2UDRG?=
 =?utf-8?B?WFpaZmhwdUIzaXppTW1PWVdua2JMQnZNRGxobEtjWlBmNjRGYnJRcGZHREpk?=
 =?utf-8?B?VFJyYWFXWnRKRDdya09walhHOFJuTS9vblBvemdoSXE5ai8vdmdvYllNVWd4?=
 =?utf-8?B?b3B5UG1kaVdHMVpTR0dhdGR0RHkxdUVmZHU4dU5DRm1BcXNHUk85amtqK2gv?=
 =?utf-8?B?Y2I1eFpMR0pzWWxsdVMrMUY2MGZvZXNVa3lDMHFLNVBRUkR0bHg0MktVbHlD?=
 =?utf-8?B?S1UySHB4eHpQc0NMWFVyUmJhQ2xHNUNQUXViMXNRb1ZscDdwaFpOYkswelow?=
 =?utf-8?B?UXJBNGdmNGtFUjhCVjQ4R0hGYmllbzU3S2ZucmViOHJQNHdaZUN1MHZCditJ?=
 =?utf-8?B?WkFYejJOVi80aFVpcGhIa2MvQndCdEI3bzNRV293RTk1WEU5UmF6M1dZTlZK?=
 =?utf-8?B?Vm5saExiQjkySmpkUUJKdVByRldGd1k2aDUxSlgwTFJ0QmVJRkNHczF5b1JG?=
 =?utf-8?B?Sm9IcXZsTEx2TVN4UFpVUEVQdVBJVXBvVHpUZlJES29YeGI2Z056QTlqZitx?=
 =?utf-8?B?OVdoMTBzRTUrWG5FaWlIU2ZLZ2NFQjBLUmFVZ0VuckFZUk9tMHc0OEJGZndI?=
 =?utf-8?B?V0NhNzIrV0NlTENOV25IazBzUXNKaXhzR2twbEZWcGhQWEJKRDlrWXVrVU9h?=
 =?utf-8?B?aUFQOEhLdWlKL3hRc0dqV2pDbndUcEVGVWVRcVZGbWpQdk51NnoyNndHYUJC?=
 =?utf-8?B?YnovdXNlUk9rcWRlaHhPNFNIaGxoV2lqSHNDV0JnY1lkTHVJc2ZaUWh4bTE2?=
 =?utf-8?B?NWRrZDNRaS9BMkR0RVZQcDhqRnpNaFdzdkNGdGFQNlZRazlSVEZqVVVIUWpq?=
 =?utf-8?B?YmxXN2lFVHNKRlJHVXFia0RqVjNGTzMxK0FQQjlmNnhiZHVTMWZxUFNld2ZV?=
 =?utf-8?B?ZDMxVDgwQkhJSkRJc0JMMXhUV2hXaFlhZ1RWdjQzYjRqV1E0THBFMlYzUjJp?=
 =?utf-8?B?enorU0p5MXNrTXVCSE8vODl5YmFJWDAzeGlYdDVUSEt2T1htMCtjc0hmNFBR?=
 =?utf-8?B?SzQ2YmpscDNOMmhHNzBIRm5lZkQ0d0lmeTluRkFNWlcyaUMyZmErZXNLRFJQ?=
 =?utf-8?B?cm82a0lsVi8yS3UyZWJjVXAwSWxmVi82NDRWS2F1QUJpNGVobURnWlpRN1Iz?=
 =?utf-8?B?UDhnQ3psN0tXd2tTZTgwOEFUNUFYRnR6aUxVUGZ2U1ZpYmdHeTVGaVJMZWxG?=
 =?utf-8?B?blN4S25CRzBLYzJBRWxRb3hhMGl5Y1Bma282d29QdHBIdVlXM0cxMXdvcEVa?=
 =?utf-8?B?amJhcGNyMXYrRXlTRkJscEdmblpaMmxUZjhVRHNXcVhEbVc1VkhxWnFlNkVa?=
 =?utf-8?Q?DpXHS92zwsffcMvVy4vhyskXYmqfeDd7m5BLjL4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21hRGlEQjdVZ2pXd2ZhN0Y3VlhEQmJUQmc1eDdzeVUxUmtkeHg2NUpzVVgx?=
 =?utf-8?B?ajYxeHNrZXZNeHRPb2tZRGVxS0NybjZTTC9yM1hOeTV5WGVYQkttc0pndG11?=
 =?utf-8?B?cEFiN0tlUGRVZTFZTVhrQyszbEt2b1Zyc0pkTFhjcGhYUWN2U2dNZ09QUDhj?=
 =?utf-8?B?T21waDZ3L3A3eHg2YVBhWXJHWE12ZXhoSFoxYjZnQmtZYmllNFBNRloyOHR2?=
 =?utf-8?B?WGROL1BSdVZQbGZqSEltcmZLYm5VdW9vRVFHd29JTytSQmc5ekt3cStBMkhF?=
 =?utf-8?B?SDBCenNaUFJtZndQR3hWbHdvYjhNNjZHRnRsK1JIMi8rVk5nb3ltRmpDS2Y2?=
 =?utf-8?B?WE9EQjBxR0NpWHl1SWU1a0JaM1padExxVGx3a3RaK0tUSXVpRmxWczV2UERJ?=
 =?utf-8?B?MCtSRmlWUHVVV1Z2R09HZ0hHZGF4b25PUmVaZUNZNS9WdUdOWFk4OEdQS3lZ?=
 =?utf-8?B?NGhVOVVkNndINXdodVh1bnkxL09zTVkvaGRmSmZZbmR3Y0VOK2cwak9FVGpM?=
 =?utf-8?B?QkZiQzNaRDYrMmpyS1ZCUHJXL0I5MmtUdS9IdlVtVlpnaDdYd01PMjB2SW5k?=
 =?utf-8?B?NWRBMXp0Q1RqbUNmMGlUamZUVW11dGlTTmpWZjdqNmpzL0daeUg5L0o5bUxm?=
 =?utf-8?B?RElQRGlZc2NHMVNucjBEbmViYkw1Z3FFRWdybzEyN2xNMllQRHdnQzI4c1N0?=
 =?utf-8?B?cTY1ZkFMOWVqWDlBZXkwZXFvRW5ZOVVEcEdkMzJaWWlxWmtyQzFFRkZIYk1F?=
 =?utf-8?B?ayt0V0MzTUpLVmtQbis0Y29CK08xT0dXQTNLZVd0QjBmdXIycytCRDBEVExh?=
 =?utf-8?B?azFTbkJnR0FDaU0zNFlPMmYvRHZUWkg2MVI2K0F2bGp6M2RRQlJ0RGJVMEFo?=
 =?utf-8?B?eHZuNWk3WHV1ZTdZUmdWRXZ6dnE5ZWw1Z3FUcGF0djNTTUQxbmsxeTBiTStx?=
 =?utf-8?B?bmVIb2pzK2RNQ3VBSEtiQ1lKcS8vRVZYcGZ5VTc1L0huQXJSSzZPcHRFRjd6?=
 =?utf-8?B?SmQveXFyOGVZeCtod1pOK0RDbFVXMWNjYU0yVHFOeXVHcURHM3ptYVYweDY5?=
 =?utf-8?B?ZW9xaEV6VHRNbi9QbVZzaWxFbEd0SnFiMXBkeXg5eU50ajk1cm41KzJYNHBv?=
 =?utf-8?B?Zzl4b1M4Rkg5dHhEWjl4dHNHbTBGWWdJNFF5ekRCK21kZjJPTnhRSEZTdFU3?=
 =?utf-8?B?ekZiQUlLaW5nRHNNS3ZicmxUbHZINEpqV0JxK0JLRnZjTFY2ZVBjR1dwSjgy?=
 =?utf-8?B?Ri8wc3hKM3Via0ZxMVROaU1YTDVsZnJUelE0cUxJWHhCWGhQdDl1QmJRTGEz?=
 =?utf-8?B?NXFKZStDZ1BVVzF1bUs2ZzlNdDNKNjl2VDhHVUo5SU5HS1lQVlUvYlMyY2Uz?=
 =?utf-8?B?NGIwaUhvN1FHZU1lb2dZY3hTRTl0eEdYUUJWYnVpQzhrbmJWaFJ2N2lXZTQ5?=
 =?utf-8?B?bTJEM0h2eEx2dU1SakxQS1Q0RDhob2Q4K21QQmtERzF3OVh4a1p6aElDRW41?=
 =?utf-8?B?Z09ucFdmRkFwNHNKRHZJL1JqeE02bkhtTjdFcTdrRktBWTJyRmhTSWw0QW9X?=
 =?utf-8?B?R2V4QkZ4d3ZUU2MvYkNUU1Fud3F2dXNwWWcyMXVMb0FQSWNpOUJtUjBNdFYx?=
 =?utf-8?B?N2N2cFRyYzZoNHNuRGUxMURBczdKZGE0TEJxVjd1T0NrY292cEdHYXpLMDFY?=
 =?utf-8?B?bVpJLzIrU0NNRmVlTFQ4a0pEN0FSUE5VVElXSHlEWjRYSkNNV0NiTTFuQ2NR?=
 =?utf-8?B?amc5WG4yakJmeC9YdldnOGhvVjFpWGhNWG5xZ0NMSkp6VFBKNy9oTWxBQ3kx?=
 =?utf-8?B?VW5jUmh3Q21YN1dVQ2ZMakc0K3dOa2t0Rjh5ZlFjYmZKWFdUTWJZSnFic3Ir?=
 =?utf-8?B?WXY1Q1lFZDRzb2E0WlI0c1ZqS3BDWXo0bmJwNE1QSE5ha2FwMzN2QjA5aHBH?=
 =?utf-8?B?MGNDckxNUEZPcEE3S0Jxa3U2dUtkdFRjd00vWlgvdHFqbmpITThCdlhDZlpZ?=
 =?utf-8?B?ekE4WFcxZVQyZEZIOW1kSEhGUzd2NG5SR2tHY2JyWVhUZXVLOTVudDNEN2Nv?=
 =?utf-8?B?QTg0Z0JqQXA0Kyt1SmozencwOWNKSjBOa3E4Q0htck9uNFdSdVNDdU92ejgw?=
 =?utf-8?Q?IlCQIRI8VOroGVIUiJwUhrwWr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2651e2fc-7b10-45ba-a415-08dcc004c65d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 04:09:52.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl1XKtFE1R0YxFREdn1bV+ccKBUeEgLahzZzLBqpZ6JjFr7qaPC6voit+WHHj7JuGAH1k7d86viXZcGSKETQuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/16/2024 4:17 PM, Manos Pitsidianakis wrote:
> 
> 
> On Fri, 16 Aug 2024, 11:06 Junjie Mao, <junjie.mao@intel.com 
> <mailto:junjie.mao@intel.com>> wrote:
> 
>     On 8/15/2024 7:42 PM, Manos Pitsidianakis wrote:
>      > Outstanding issues
>      > ==================
>      >
>      > Outstanding issues that are not blocking for merge are:
>      >
>      > - Cross-compilation for aarch64 is not possible out-of-the-box because of
>     this bug:
>      >    <https://github.com/rust-lang/rust/issues/125619
>     <https://github.com/rust-lang/rust/issues/125619>> in llvm which when
>      >    fixed, must be ported to upstream rust's llvm fork. Since the problem
>      >    is an extraneous symbol we could strip it with objcopy -N|--strip-symbol
>      > - Adding more than one Rust device ends up with duplicate symbols from
>      >    rust std library because we are linking as whole archives because...
>      >    constructors are stripped by the linker otherwise :( It can be worked
>      >    around if a single Rust library is built with all the devices as
>      >    dependencies which is then linked to qemu. The fix is a small change
>      >    which I will add either in a next version or when a new Rust device is
>      >    added.
>      >
> 
>     Hi Manos,
> 
>     I also noticed that when I tried adding a second device. Some other projects
>     met
>     similar issues [1], but no clean solution seems to be available yet. The
>     options
>     are:
> 
>     1) Combining all crates into one staticlib which is linked to the final
>     executable. That requires generating one .rs with extern crate decls of all
>     enabled crates. In the context of QEMU, different targets may enable different
>     set of crates (e.g., some crates have arch constraints), thus one .rs for each
>     target will be needed in general.
> 
>     2) Linking rlibs (or emitted objects) directly with other C objects using the C
>     linker. That somehow works (with some tricks) but is not officially supported
>     and may break in the future.
> 
>     I'm working on (1), but would like to have your thoughts and preference on
>     those
>     options.
> 
> 
> Hello Junjie, I have also implemented (1) already (the fix I mentioned in the 
> cover letter). In general I'd like to do it on a standalone patch so that it can 
> be separated from the other changes instead of squashing it.
> 
> If you have something already too, please share here! I will send mine as a 
> reply to this thread when I am able. I am not familiar with meson so my version 
> could be lacking!

Here's my version for your reference. There are still a few places yet to be 
improved:

1. Each virtual device is required to write an additional `variables: {'crate': 
'crate_name'}` in dep decl. It duplicates the crate name which is already given 
in the static_libary() call, "abuses" the dep variables originally for cmake or 
pkg-config, but is the only way I found to include the crate name in the dep.

2. Names of variables and scripts are tentative.

diff --git a/meson.build b/meson.build
index 97f90a9a60..07401b379a 100644
--- a/meson.build
+++ b/meson.build
@@ -3879,6 +3879,8 @@ common_all = static_library('common',
                              dependencies: common_ss.all_dependencies())

  if have_rust and have_system
+  rust_root_crate = find_program('scripts/rust_root_crate.sh')
+
    rust_args += run_command(
      meson.global_source_root() / 'scripts/rustc_args.py',
      '--config-headers', meson.project_build_root() / 'config-host.h',
@@ -3916,6 +3918,8 @@ if have_rust and have_system
        '--allowlist-file', meson.project_build_root() + '/.*'
        ],
      )
+
+  rust_ss = ss.source_set()
    subdir('rust')
  endif

@@ -4013,6 +4017,28 @@ foreach target : target_dirs
    arch_srcs += target_specific.sources()
    arch_deps += target_specific.dependencies()

+  if have_rust and have_system
+    target_rust = rust_ss.apply(config_target, strict: false)
+    crates = []
+    foreach dep : target_rust.dependencies()
+      crates += dep.get_variable('crate')
+    endforeach
+    if crates.length() > 0
+      root_crate = custom_target('rust-' + target + '.rs',
+                                 output: 'rust-' + target + '.rs',
+                                 command: [rust_root_crate] + crates,
+                                 capture: true,
+                                 build_by_default: true,
+                                 build_always_stale: true)
+      rust_lib = static_library('rust-' + target,
+                                root_crate,
+                                dependencies: target_rust.dependencies(),
+                                rust_abi: 'c')
+      arch_deps += declare_dependency(link_whole: [rust_lib])
+    endif
+  endif
+
    # allow using headers from the dependencies but do not include the sources,
    # because this emulator only needs those in "objects".  For external
    # dependencies, the full dependency is included below in the executable.
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 518d4924a9..55d68ffb5c 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -8,7 +8,7 @@ _libpl011_rs = static_library(
    'pl011',
    files('src/lib.rs'),
    override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'c',
+  rust_abi: 'rust',
    dependencies: [
      bilge_dep,
      bilge_impl_dep,
@@ -16,6 +16,7 @@ _libpl011_rs = static_library(
    ],
  )

-specific_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
+rust_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
    link_whole: [_libpl011_rs],
+  variables: {'crate': 'pl011'},
  )])
diff --git a/scripts/rust_root_crate.sh b/scripts/rust_root_crate.sh
new file mode 100755
index 0000000000..46d7e8728a
--- /dev/null
+++ b/scripts/rust_root_crate.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+set -eu
+
+cat <<EOF
+/* This file is autogenerated by scripts/rust_root_crate.sh. */
+
+EOF
+
+for crate in $*; do
+    echo "extern crate $crate;"
+done

---
Best Regards
Junjie Mao

> 
> Manos
> 
> 
> 
>     [1] https://github.com/rust-lang/rust/issues/73632
>     <https://github.com/rust-lang/rust/issues/73632>
> 
>     ---
>     Best Regards
>     Junjie Mao
> 

