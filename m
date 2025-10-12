Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB01DCCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7v4v-0002Nt-Ld; Sun, 12 Oct 2025 08:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v4s-0002NO-3Y
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:21:30 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v4k-0001hb-BP
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760271682; x=1791807682;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NVU+zN0vfQnlHT9HlwOQ/OVz5rrF0lHSXFwjXC75K8Q=;
 b=CgxoUy1Ob+Nfb4RBL6NzG329c47h0f59qTQH3ccz29gzG8DKQxvSJrFt
 uFuMQHNaJtm7IXTSlZjUWIdKO3joLra81i4qLBtthpNTMsJTkp384vAnS
 4y76ByLut7PrRHgGN7fKqhcgdSPjLw+7r+Z3ImHzQF81DNnxxP+pArI4o
 oGwk1tv5h3nAwxJS71S0xtKu3oYWgagBw8Ml7kkx//oGYXJHEbHpyO4NA
 0SeHduY2S2YMA2yIYvcBSrjM8JYGfN1JLiUtOd5F06MWF6SAzkZRZfNXA
 txqTBkCce0tBIQzS8+RzrSbgSnbMqKCHyi4JaMKwyppg7yzPUC2yxGcSW Q==;
X-CSE-ConnectionGUID: +/C0CGHjRnmOJ4ijBtVG7w==
X-CSE-MsgGUID: EXQnmjxIQh+u6gAoGxVDVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62461920"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="62461920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:21:20 -0700
X-CSE-ConnectionGUID: +am5lkDERCmfHDWtkaJrBg==
X-CSE-MsgGUID: Ft3HeaLVT4yFwdpwNyK8rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="212332166"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:21:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:21:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:21:19 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:21:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRE3OcnWRzhlRHIyHP40MjLzG41uTjZm03lozvnRBQofTDqa4G+aqX7uKFxMTa+YzGP+gnGvLIQUQ+k7NAUPBy+RQMQyWQDPU1EBOuXtKbTLan486Z37Tc9L0RUIbt+dBWzQbk/LDXGdlYyHtO9lruk7cMHdSHYRcivHns8eS1GQwNu1KkxZ1nL2x15FxP6zsnTOg0VzHb0m/MwHQH9R0BIpoW8Y4Dxw1/xU7KYIOY9+fDCvYblVJOJFz0YJPdi45xFd6vEkY1Eqw2DTVwSmiprLGz3H1eteR1DxzbdUprl2rEOZ2L/Q9F97PZc3UCEvtuNeZybOB+MHGXihIZ91xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLdVTpKMXSslBEM7zDq0qIr86qd1dNsU+JQ8iujtGyg=;
 b=xnlWT+4FQbsDCBUavqZkEP6kg3ZW6gLK4iu/DWo/BWWcJQXA3RSrF/S4d5HRgJvzJ4N/KZMU4sC6GNGzP0K1iUUs2tDdxenhlZobM2R4Jfnhtyr2FM4GhpcBn6KisSxpvih7iV2KTspDQeL5VTZmpIOAIUXa+JZ4PAs+n2sZmnxxTLtbm2HhVEQ2c0iZRFzsWzKITZf86umLnpWIfx5Yn0wPnDevuWS9KPbKjwi4R9zhxo3jmZFjtx3Cs2vRBFHEi9n31dueDTQaTCLFsIiTMizI4V6aIflmd1wfsm26AHzPc2V/YLbHt1aLp37sAxXnV9nNFJB4ygiiGqQQbUnwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 12:21:15 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:21:15 +0000
Message-ID: <a5b8f97c-87ad-4e85-b8b4-59360b6aba97@intel.com>
Date: Sun, 12 Oct 2025 20:28:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/22] intel_iommu: Implement get_viommu_flags()
 callback
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:3::24) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|BL1PR11MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8f6ddc-d746-44b0-1550-08de0989d6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkZrN1c1TjBXbFJmSmVmdEV3R282dmVHSEI3eUV2YVNNang3Q2MwZW1HdXFG?=
 =?utf-8?B?ZDRQcm9JSWRqM3YxVnp5OFlFTmhDM3RSay9WWFpZQ1ZUWU15MFFlS01QalQv?=
 =?utf-8?B?cU5xRklFeUZVeTJ4c1pKaWsxR0t6c1BsR0d0em1CZnhXcFVKK2doekl0dEFK?=
 =?utf-8?B?Q3RjZEtCZHRUT1FaRlZMTDhmN082cTRmajVVcTNmNDZEK2NVaGVyaWprc1N1?=
 =?utf-8?B?dUNvUEVQbEptWjdFRlZhYWlpdElNNXZNYUpibktVaEJ0Z09yV2J2cUJVNE1E?=
 =?utf-8?B?M0cxc1ZvRmwvd2lsWUo3ZXQwYzQ3WHJNWFdCazhXMHUwQXdaWUhrZ3l2NWly?=
 =?utf-8?B?aHladDUzNkN1WTZ1R1IxMzUwMTBadHJBbWdMdlhJY2lISi9EWWdVTkN0bklM?=
 =?utf-8?B?RUV3dS9JNmFuL0NEMVpkVHp0R0k3UE9FYmZRWnRESVprWkpNVnFvaEhhMzUz?=
 =?utf-8?B?MTFpWVZSSmdVb2RwRWtkMWZJb24xNFF3eHIyVG00aW1pdWd6bHMwZWNsaUNI?=
 =?utf-8?B?ZlFDQ3dyWEE4dE1IMG5LMnRzbXBwbnhpVVIxYkpDZUtaRnZ5OGVzK0J2empI?=
 =?utf-8?B?OVdTeW1sdUxRbG9zaDlLTGV1Y0lqQ1RMTFB0a29Xa21uV0ZraU9TaVRJM0E5?=
 =?utf-8?B?RmNXSmZCeW1LdzNwRCtVM0dMNnF3YW9WMlcyQUR5b3ZBZHI0OFhnZVprRFlQ?=
 =?utf-8?B?bUUwSFlTalhGZUV4SUpWUjdiZ2ZGRGlUU3hkcTR0bmltVzNzMWpGRDdhZHNN?=
 =?utf-8?B?YW9NVFg4NExMTWRpR1hTVmo1TEZXRGNHZk1SUlF6QjJjMmtGeDNKSXJuQVpt?=
 =?utf-8?B?OHpURm14YjE3M0FKaFcybXIvc0htZkw5SkZ6UXZoZTIwajVWRmJGU3hPQ1Z6?=
 =?utf-8?B?eFF1bHhvMEh0ZW9XRFNXb05jWXJCT0czN1l1Nm94YUdVYjF5eSs2Zklhd0lt?=
 =?utf-8?B?ajhpUDJ6WEZLb1B3UmErQ3JwbGlMUk9PUEMvbmF4OXd1TXI4dUdmd1FkeXhM?=
 =?utf-8?B?bnU2MmViQkhPWThEK0ZCcFhhd3pkNGR5bVM0L1JEY3hCRytCQTFyNGRPYlhm?=
 =?utf-8?B?dy9hQmRlSGRQODFDZnJ2MjJSZXdLeVRRT3BWOXBxN1NBOG1MeGNVQ1JLT2NX?=
 =?utf-8?B?WGxMSzRqaEcxOXpnMXBzbk1qNDhDb3VHTXY5anNRdVhoZ203T2xqR2RodU53?=
 =?utf-8?B?dE5EWHk3b0pkclBRR3M5NEtvL0FFVzZmcFVxZm9ZMVgreDRlSUxsblpzLzdr?=
 =?utf-8?B?L0FrYjhkaUl5M1pUWFFQK2xxclA5ZWNjRTdLTlBOTk9kVlVwZCt0U2xYdW9O?=
 =?utf-8?B?UXFBcGpySmhIR2M4Q3M2TWNabmtEWk9wbUtjdkJUZ2p1dmVlNlNQbDZxLy9j?=
 =?utf-8?B?aEYxQWxQSlZOTlpVNUpsblFtMnRScjJnL0JpMlRTcGpOTjVKRTBuWXpWUCsz?=
 =?utf-8?B?azRrK0ZNaGIwd2xOdDcwQ0x4ZENLeVIvS1p5Y0JYUGJxT0FDNWZla2p0eU96?=
 =?utf-8?B?VDdxQ25JdzJETWJ6Vkp2SlNMaFdWVTQ5cy9zWFM3K0ZLV05mcG5TRkpCQmx4?=
 =?utf-8?B?dldxOTJPbG9pN1JFR2EzQWNud3pMNkRPd2Y0TXNld0hGbjBDbk9HSDR6Vjkx?=
 =?utf-8?B?VWt0WHBsb0RUTC9wMDd2VCtUY2xYbmFabm9uRGU0TWpMK3FRTi9pbFA2UTZU?=
 =?utf-8?B?OEF5VVZjaDNucG9zZjdWdnhhUk9nWDE3QVVQWkFYeUVQZFpCaHhaeVhkQ3B0?=
 =?utf-8?B?MEdWVFN0T0hhYnRQWnY2WFdFVHhkZzJlc3ZtaVdXR052VWJLeElIZXdMQ3BJ?=
 =?utf-8?B?UmRrdyt2R3NZLzVNZmZjTmdCOGV3ay9icHE0WkZZenZtcEFicDlreU9OcDE2?=
 =?utf-8?B?Tzd6Nm50bmJVWkRhQ2lDUTZBUXdDbEs5Q3pNMDBYcm96TzFxOXd4OGx6amow?=
 =?utf-8?Q?wcVasczGJRbtSO75OATjYxIuS/kv6ghi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERLNExMNWZJanVhdU1LTTBsZ0dmdGdlK2ZQYjVXckFHR3FsenFTaTcwMkVn?=
 =?utf-8?B?dEcxeSsyMktCamJWYzROdU9YblRmeUQwYk15SDdNSk9CbHNMMVFNOEk3QmNR?=
 =?utf-8?B?TGl5QmgwOXo3RlpmZExmeWllWFVRWmkzeGZ6bDk0dnlrM1ZBYXBCWDdzaVg3?=
 =?utf-8?B?ZTQwMUwzSW4rdGpIWVh5bFZHR3IrV3phMlIwQ3VDUDVrREJOMS9MM3JlT0My?=
 =?utf-8?B?aHFnNGZVNENEUkNob2Y3c1ZGeUV5MitlaDJPTHMyN21xa3ZkeEdQMWh3UnhL?=
 =?utf-8?B?dkJpM2ZKQm03VjlQSDNxRnlXOHFBZStNQURtRG1aVDlUMkNhc29leXpjOXFH?=
 =?utf-8?B?NWFSNEY5Yy8yUXZ4dW9rOEhZK2N5NGFGZ0g2N3dEOFRYeHJPY1g1N0NuOUdR?=
 =?utf-8?B?dkhXMFZ4NkJFTUxNV0FmdXJ0VVZHV2FXM0YwaUc3Rnovd1FHSnY2czRPZVhw?=
 =?utf-8?B?MFNvTVM3VU45WFpNSjdCVTJBZi9RYmVRMlA4QVVMU0RUYUxmVDZQa0FuZXpB?=
 =?utf-8?B?TFZLeE94enpWQWdSbFVBdVlwNkordmVmaVdQOW8rYlI2VURRQVQxbzQ2b0Nh?=
 =?utf-8?B?RHFkYnhabGpWYk1FNTdpSWtlb2RPeG1saHVZcXNhT25KR2RkUXNNWEtyMEYv?=
 =?utf-8?B?QSsvVHQ1azUxUkt4UHVpZGplQ2FTTytoS0FDOGl3ck5URFNOK1d3M0c4MEFQ?=
 =?utf-8?B?Z1hyeVZybG9zNzlDR2lRZCtyOUJWTE1nWnEvRVhuNVdHTnEwSUxWSitEdXVF?=
 =?utf-8?B?d25FUW9wOEsvTk96eTk1bmp1MGRHRkFHcTRCc1N6bXlYOVVOTUpCeVNBZHAz?=
 =?utf-8?B?YW5WenJtTWg3QWRlelNiUWVTSHhtWEZXT0xTZDJudjRSRzVQNktHU3g4SEor?=
 =?utf-8?B?V3JTcjhJRFZTV1JjYWR3dStFMnZqMWZqajlqYlhVblh6R0NsVTZUQzZQcG5H?=
 =?utf-8?B?V1p0L3E1TWltaklHc283YU1LbElFWjhka3ZCb0x0TWR0NkZnSUFNMmR2a2JK?=
 =?utf-8?B?bGZieGlSbTNQbWJFbWdTSnptNVRwanVVZnlFOHBpVkpRcWNGR0RnajVPMkYv?=
 =?utf-8?B?Wk45dXVsZUJsbE9wWVNDYjZIVU9SZExwbWkwVlBsTVIzQ2tOa1IxUHltMU9S?=
 =?utf-8?B?d0lFaCtHTnVHa1I3RU13eGFzb3k3MVF3cmtTTTBwZTQyRWF0YUNRU21xNDdL?=
 =?utf-8?B?S0ROLzloN0h0WlNMTVl6SHp5WGFvM2h4eWNiMVFEQkJTeHJpRVdqRjFHeXBP?=
 =?utf-8?B?R29COHFzanp4eXdMTlljY0FSTWZLdWVEMmJ6QzJLTGRnbVJ4MTdtTm1GbDhT?=
 =?utf-8?B?d1JrcUxyMWdVdE16Ujc1YXprdVdhNzNiZHhKb0dNVzcrOXVTZXY3YzVxSjIr?=
 =?utf-8?B?Kzh2N3htZVJSdW1tUStQVmttRHVRODNIWFFWVTRPM3lUZ1FncnZYRTZxQ2U5?=
 =?utf-8?B?RFdmSUF0dml0eEs2U3V3ejZKcGcwSzhMY0VzSFZCd2Vsc3J0NDZqc1JCM0VN?=
 =?utf-8?B?cDdCRm03WXNqNWVjQkxmTmttWFRkTWxzRjRGYXUzc3Y2Ym9LM0xxOFd4UDJp?=
 =?utf-8?B?dmZReG9jM0l1RnNwN1VZeDRRelN1MFhQdUFiWWpBZVlWTS9BL2tiY2ZlWFhC?=
 =?utf-8?B?VTZSdzdVSXNHNXQ1aVhta0U4cTljT3NjVGtMU2dJNGIzT2xFWWtCekpHM240?=
 =?utf-8?B?bjBOTi9yY2xYc3JKdnZ2bHVpMHJteXp6QmVteWdKN2lZU0xZVllNakIwZEJO?=
 =?utf-8?B?a0FZZVV5aklmZkRTdUJlWEx1eVZUZ2xQMUZmZW4zRlpnRzVaR0xPdEZheFBB?=
 =?utf-8?B?ZFRpeW9rcDB5UnZyZStrV25VcjM3cjUyQkNvRFJ1SjM3b2czNExBVUo4ZEZP?=
 =?utf-8?B?TlZZYmtwV2gwNEsxZTF4Skk0Y0RUZU54bk1GWlc3M3UwL05kS3V0eGhsNmFK?=
 =?utf-8?B?T3JGN2J5ckd6MldMNlV5S00yNnVnQ1N5WWJlc2FCOGZCSlhielE2L2RIRnhQ?=
 =?utf-8?B?S1ZsMUdndncrUU14UW00anI4Y3VVZHl3U2k2VmU0WmFDemMrY2NKMFpwREIz?=
 =?utf-8?B?NkdPbjVYckk1SjRHUDcrS2x2a005anhYM0hIUWx4aE82LzRNdG9SSHhCK0po?=
 =?utf-8?Q?w6crZ5x7di99aO3iRHW+vwJHy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8f6ddc-d746-44b0-1550-08de0989d6a6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:21:15.7421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwOxNdBHyj8rAvtg3lxhYNX284ihBBkKeSTjPztRtrXmdTOo1AQ8KF0yrmVeDtJuYQEcxaRFfH1pXgdbSpokTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> Implement get_viommu_flags() callback and expose a request for nesting
> parent HWPT for now.
> 
> VFIO uses it to create nesting parent HWPT which is further used to create
> nested HWPT in vIOMMU. All these will be implemented in following patches.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   hw/i386/intel_iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a47482ba9d..83c40975cc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -24,6 +24,7 @@
>   #include "qemu/main-loop.h"
>   #include "qapi/error.h"
>   #include "hw/sysbus.h"
> +#include "hw/iommu.h"
>   #include "intel_iommu_internal.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bus.h"
> @@ -4412,6 +4413,16 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>       vtd_iommu_unlock(s);
>   }
>   
> +static uint64_t vtd_get_viommu_flags(void *opaque)
> +{
> +    IntelIOMMUState *s = opaque;
> +    uint64_t caps;

s/caps/flags

> +
> +    caps = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
> +
> +    return caps;
> +}
> +
>   /* Unmap the whole range in the notifier's scope. */
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>   {
> @@ -4842,6 +4853,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
>       .register_iotlb_notifier = vtd_register_iotlb_notifier,
>       .unregister_iotlb_notifier = vtd_unregister_iotlb_notifier,
>       .ats_request_translation = vtd_ats_request_translation,
> +    .get_viommu_flags = vtd_get_viommu_flags,
>   };
>   
>   static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Regards,
Yi Liu

