Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E47C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCRE-00065S-6f; Thu, 20 Mar 2025 05:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCR5-0005zQ-31
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:43:35 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvCR3-0002uo-AL
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742463813; x=1773999813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bXJOzSq41LKdUklLi2A+mHOBW68YbrdlxUNm9siBd/k=;
 b=kNGN1lTy8nziMZNkKL4NdFYFPqLjOHnqM2V/JBi4WA/kfss0i8vqB7DD
 MHSsTYhxuIFmurexaMBuDFT2vaO78ATVuRF2oIqcYbmRPvW1+RQAvDJCr
 2Nye387hAcMJK0+BWSA9YRviwB4+6+SVxE3ZfkIPGh76paRvAQcsgQ9/P
 VtFFfFdFx4nCpimArKS94tsFzKTtLjPu3Tw+idOr+kAEAGUMT2A2D6IKv
 0pXJiKjnniP1WhnzY1Ox6H6zAy94a52vEZPkIefyMM9oYGUWmzErymvWt
 bvHObQEkLnBvlYqIr78zJgoDjrVQzAbRP+sbeuInVsuzQWsLtHmI8wAyl Q==;
X-CSE-ConnectionGUID: RmMlZgW4Sne5xxzyr+rzHA==
X-CSE-MsgGUID: NMElkYM5Quu3cEbvmRkwFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43567113"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="43567113"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:43:31 -0700
X-CSE-ConnectionGUID: TRKSYbP4SlaPRrYN8KMLTg==
X-CSE-MsgGUID: Q9hjt9kGQBe3U26SVotLRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="123050104"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:43:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Mar 2025 02:43:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Mar 2025 02:43:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ8TbTEruRX8VgQ30PiA2CeaEROFYgWChjnmgdLUgVE+REDIgkRybaAgzBrj8+Pxsy+tWu0j3IdvvRHGrbFi+/k51gCxWwhE81JvDwyT2zFUR93Iim+Eg2TPAu8PBZiPVw9WgnDeaCGaYdG9cX8NIwknlseBQmAostBTc1z2awQZmqOoPXYanJtb+JxZygaJSwNJHEUDJ57A5fsqQyeLBzmcdmF6JWCoN/n1Gx7uswS285k+ghs/b40hQHXhzh5ay4Za0rjp3NuKR0MJjnMNpGrKgjCImpyjJRB4FE2HUOSOL3zyK9Awpr3VaKb1M0q2wK49XDBHjS/mxR/RwwADfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXJOzSq41LKdUklLi2A+mHOBW68YbrdlxUNm9siBd/k=;
 b=jw+0oNPDbedS1CP8vY5sMcKwTtmhgyO/Z1T86R3i/KuYMT53QB2DpO5i5SYy8E/lCyxmiB4Bc+L7sG5IQZVu8QSWunt3DelRYHzZejkr1xywlkRUNa0uUCFRPBq99y/fF78gmhyRW/x2BiUD84jzgcyGm2QpTfTwKXWsIrPp1yh0yR1Gdl1DkPa8NzQsghiOtFrj+t6UpRZPF52fuzIe8W+EdLynu6GrS57X5dlg2grBKWBu4j0RPT/+gBZKh47Bx5gMxy1f3zM5RMYjnvpqUhBxK1uN1sYRQJFnQUljG/GuEDnaXu3pnvhwpXgl8wcji/H/C92AH3IM/xV3DhhUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 09:42:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:42:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 18/32] vfio: Move vfio_get_device_info() to
 helpers.c
Thread-Topic: [PATCH for-10.1 18/32] vfio: Move vfio_get_device_info() to
 helpers.c
Thread-Index: AQHbl+vxG5DFhHEVwE29zqpqGafIbbN7yM6Q
Date: Thu, 20 Mar 2025 09:42:46 +0000
Message-ID: <SJ0PR11MB6744E26E3B481B953BB780D192D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-19-clg@redhat.com>
In-Reply-To: <20250318095415.670319-19-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB8168:EE_
x-ms-office365-filtering-correlation-id: bdc00a0e-6857-4833-4cd3-08dd679391e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnRqNUhEY3dwUzlINXU3ckFVYzFDREhKQnJ3dWpwSXNNelltR0YxekZvTHEz?=
 =?utf-8?B?OFpwZ2FvNXdBVFFVa3h4MnMzdzNzZE9XVm5CL20yRElndDREdHJENVcvVThR?=
 =?utf-8?B?K0U4WmRzcGFtbTM0cm45MDVEak9TaWZkeThjemNxRjVPSFZqbFVKVDRmV3dr?=
 =?utf-8?B?MmhDaWx2ZFBnM2N1cHkzNjVkSXExWWJwcXlNNFFTUEl1RkJFNEdnOElRSW54?=
 =?utf-8?B?djlZWGtiVk5vWlFXQm1MNHp3V2EvT0toY053VXZsRmxic0RtN0h2eEJBOWpY?=
 =?utf-8?B?Ry9GRWtYQitKa3pEWWd5MytMU1B3QmdmTkFMRFZtN2NsUGo1UW1HUmU4S2RY?=
 =?utf-8?B?VGlFbjkvUEtzL3VIQmhjVzg1TTNlWUNtMm5zS0dkR2M0Yko0MmxrYkR3T0hv?=
 =?utf-8?B?YTc2TWFERlJrS3N1TGdIbzZVL0lrN21PK1EyaENUUUlTLzZXMURmR2Nocmda?=
 =?utf-8?B?NndEUkJaY0I0V2ZId05QLzVVNjhzZ0RYYVFTaTVNQ0hJUFJndHdIcjNDTFQ3?=
 =?utf-8?B?eEhjM0dJWjcyeHBjN2w0cTQ3YWpkKzhCMzd3aVJ0SDB1aW5kSWpEYmM3bmdW?=
 =?utf-8?B?bTdJUngwdjdQRDVWOEhHZ0VGM2hTQWlPZ2ZBS0Zuelg0OGJqcXdoVHNxb09x?=
 =?utf-8?B?cjVqWkRXSEtnSWZiditYVDZVbXpuaEYzd0lWZHk2ZHQrYmFTK1dYSXVhRXAy?=
 =?utf-8?B?c3Fjd2FRREFkQklZV0E0cEgwWnkxWDBsZzBPci96bkNjNzMvOEtTeHp3YTRT?=
 =?utf-8?B?QXFFVE9jRVVzRVpDTVo0TWdXVDAwQ1QyU3dNZXlGUndRK1FicDBDMFE2citI?=
 =?utf-8?B?SE1IdlpxZWpNbXpXYkFLYnR4cUJFK3poVzQrSmhiSGdzcTJvYW5vT0dlRXFP?=
 =?utf-8?B?Nlp0bzdLd1MvcC9yY0M0blMybnMxZldWQXdURzd1b1dRNTNKdFY5OHRTWEtY?=
 =?utf-8?B?RUMzS0FLRnMvWDZhcExLUnd3OUpQb09CTEowNFMxK3pJN1Jwbk5QRFJxTkt2?=
 =?utf-8?B?dGZrU0pWZXljTXM5a0xCSXVPY0piMUhJSTR6U095YWZTWHFRV2UxdlNoM1dB?=
 =?utf-8?B?QjlPWXV4R1JPU3RUMWJPSTFMd2ZqSWxyRDJQL1d2d3dETVY3VHQ1TEVaRGY0?=
 =?utf-8?B?dFVDUjZ0UENDRVpjbkw1ZW9LWW5WZXk4NzFmSWx4c1Rla084NmlFbHB4R3Ez?=
 =?utf-8?B?TVNzaWFKbW94WGJTV2QwbGE2NEFDSUlJUEhSYnNUT2ZVdW5LZWZ4SllIeHFl?=
 =?utf-8?B?Q1d1TUtCQUNNcStwMHh0VU9iQzB6MElXWkFHT0ZoRThJV3dOSWJkTjhkSnJw?=
 =?utf-8?B?cWlaRk1kSzJUNUtKZjNKcXhZL1krOG9VNnYwUEJuK0lCMU5JNWtFeXBILzZo?=
 =?utf-8?B?MlBMdFdCQTB4T3lTTzY4TWtoNUFQREhnSk5hWWRPQ3BpUDUyNWttUjJiL2hO?=
 =?utf-8?B?TUdoM0dRMWtRdkQ2Q0k1Nmp4QlkxSTJjVXEyMEo1RVZ1YklpT3RMVnhLTU1u?=
 =?utf-8?B?Qi9WVitWc0RHcjFFUGNzK1AyWnVXbWRkZ0ZiaXMzS1J1NjFPeXBvS2RueWpF?=
 =?utf-8?B?OGwvbHpyVXo0VllZM2YxditDRTEybUNyM1U4YUpnc2pPNUo3dmhKb2JwOFRp?=
 =?utf-8?B?YXZZWUhIYUlKdXFydzdXR2NFOWF3b3BDZTBDQmIxSi9ZaUZLcGVuTzVsWEp5?=
 =?utf-8?B?Y0NLK1ZRelFCajNvRjBYMmtneE5VTGdJRUpNSndWK2pzT3JYOURJeUljdFo2?=
 =?utf-8?B?bUMrbXZpb1J2amc4dk4xd1lFSFU4TDUwSU5WQzhZdVIwWlBGOFZsZ3I5T0JB?=
 =?utf-8?B?NG4rMW5yNUhWV2ZoajBTbThTV0ZUUlpHenRlQ1luQ2FDQkk3b2xSbFA3blh5?=
 =?utf-8?B?VDhDSkVtS0szMFdtVEtra2toQlVLU2c1STIwMHlSR1FiUU5GTFJOeWZ5bWo3?=
 =?utf-8?Q?UJovM+504KD3avf5oxbr1TW8lPL8/xxD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFVBN2ZFVnIwL0xEQmFWcTRWSld3L1l3aDJ6K1NBQU45V1crR2JzVXV6T0ht?=
 =?utf-8?B?RlpnRi9VQ3M5dXBwcmlpNml0R0s1Yzc4STFSdzZUQ2xyQWxVeXJONUlXZDV3?=
 =?utf-8?B?NUg0QlFVaW9DTzlKeFlRU1R4dFlmMFI4SWgvdHVLMlRZTVROWUlFN2NmaExp?=
 =?utf-8?B?MzZ4RmFsWWdrQTJ2RXB3OG1iVXpFM2ZtK0ptNXNTdXR6bzl3L00zczNHZHkr?=
 =?utf-8?B?ekJ3R0lFQVZMeWc5OG9WQ3ZsSVZkTVRJemxmL2pRenhTL1NGTTFIeUg1QVU2?=
 =?utf-8?B?QllLaEIyL0REdmNPNktxeWw1WEVjRG9OeWc3T3BGOGE3ZmNQR3pMRUloajdm?=
 =?utf-8?B?Z1BDWXZUR2dIZ05Bd241VWZ1blVybDE0YytkNlFYblFEMEZtZXZJUkxaMUpB?=
 =?utf-8?B?Nlg3UkpQdGlidjlBR3RIYnVvVEkyU0QrdmZ5UEhTYUpkUEFpWEx4MEdhcVVx?=
 =?utf-8?B?RUwxdlJXMGo0VEFLcmt2aTNTZUF2UGxub0U3VnJBVDJmNngvT3JVSGJOVk1u?=
 =?utf-8?B?aDNJd1ZjaWU0Q3VRL2lOWXhVMXNsanRMbEdONUlnRkNIYU5LNGdIR0lGMFlJ?=
 =?utf-8?B?UEtESU56MjlYaG4xeE03M2Voai9MOUxJYkJ1bTlNd2lKMGNhRm1DbzRmbmZ0?=
 =?utf-8?B?WUx0eFBYNkpGK001SmVyVFMxSytGc2YyTEtyaEF5TXFIdzlNc21SWUNCSUY2?=
 =?utf-8?B?RXdzTGRwTjRXclJtTUl5WTh3T2o1WFZ5SVNhOHJ4dVc4OHpmZnFrV3JXOTkv?=
 =?utf-8?B?ODBBdG5jY2pWOVZCbkcrN2d1QUJycjFEa003NDVVMzNVT25BeW9GZExEZkJF?=
 =?utf-8?B?TDRydkk1bmo1bDdoQWF6UXBOM1NnR2craWNXNXdNNWFoL0JqRk5zV1VWdk1H?=
 =?utf-8?B?ejlvZDBkZzBLQkt0MzVFRDNxNmxTTUJyQTZHWGFrYjdzNmN3dk9tY0pnMUJG?=
 =?utf-8?B?L3VUSkxMaCtkeTluTmFpczI2OWFKdHVRQ1pWdVR5Qk1aSk9vakZuandodFBU?=
 =?utf-8?B?M0MyR0xLV2hhTFFXNmxoNGN1bU5ubmJrQUR0dWxseml6My9QS0tNZjZkd0lq?=
 =?utf-8?B?UXE4L3dnbmNvSEhXc2phVStSM0dXTmNtNUU2WXExcDRtYjYxbHIwTVl3WXN4?=
 =?utf-8?B?bnNsZ1hFaGFBb2RFcVhaM1ZxN250YTJSSnFPdWl6N2Zha2w3Z0FJNlAvdTQy?=
 =?utf-8?B?SzdUdThmeFoyUkZxcFRRY0hGSndCckhwbUg5MHN3ZkptM2ZrTFNoRWFGV1Jy?=
 =?utf-8?B?N2dJZFBMc1E3bnF6czYzUnlwZ1dqWEpEUU9PRTMzZmdLOVdBUURtOUxFTzBL?=
 =?utf-8?B?bngveC9UdVFyeVc3a1QyQ2ZwODExenIxNzR3dmZER2pFSk92UTBLOHpmc3Rt?=
 =?utf-8?B?b3drVmhqY0VsYmhVSXMvTHllV2VxK2tQYnNEdWVaUTJlZWlFMHFHUHA4UEhr?=
 =?utf-8?B?bjQ2dDBKRE5OYThJdkRraTh3QS9xN0ZjTFNVUTZxYVFUa0ZjckhXTlJhZzZJ?=
 =?utf-8?B?M1RKeUFvSzhWRFdLMGRpWVZVVTUvSGhEZGMxWCswN1plRFFqZ25UVjN3TXM2?=
 =?utf-8?B?Sk5ETGFTcWIxMHF4SEpTa3IxOEU0aXpaeVpKS3FGTk5nVDN6SXVleUZJZVB2?=
 =?utf-8?B?emZ0eGVpMmIxYVh3QzVnTTRVS3dQMC90ZE1qMTlTREk2cHhUM3p4RnErN2I3?=
 =?utf-8?B?azJvWklQeEh0QnQ0MGxEQUZOOXg4L2J0dklaem10TndhNTZRYTJldVJFSzgr?=
 =?utf-8?B?MnhpSHB0eGtaeEd3RXJtdE5yUXNoaVNsOGsvVTdWUE56MjRDNVBhU0dFb0Rh?=
 =?utf-8?B?OFo5aG1WVHpId25iUmt3MklnYlZTMFFUbkI3V1VHdFVOSGlVUGpla1Ixdzhk?=
 =?utf-8?B?MmpUQjRPZldqTFNNV1ZzWjlOWHJKdEFlcW5VL3ZmV21RUlRHcm4yRStEVjF2?=
 =?utf-8?B?cU1MUUljQWwwbHVFRjkvVTFIaXhqRHB3dGdLSy9sRFdHcG1pK0ZjYzVvMGs3?=
 =?utf-8?B?eThxS2EzRjEvTE9tM296YnY5Tnd5VDdEMUVEcVRHWFNrWVZKbkNsUmRUWVhl?=
 =?utf-8?B?ZnF3SHRrM3VOQTdHZ1JwMVEwTVF1OFJBcWVGR2lPOUZXTFNkRWJxQU04Zzcw?=
 =?utf-8?Q?nwPOME0bRumXuS1eU2aPgf4sa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc00a0e-6857-4833-4cd3-08dd679391e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:42:46.2004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Ls7bwH0PbyqUIaKIFINJ9au+UPMJd1t/ZOeBFBScj9ZIVZDyiRn3dWsyPUEnKt0mXbO+VGF2xp/PnlB8vW0XW69SIsU1JCWwO936DJbCUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgMTgvMzJdIHZmaW86
IE1vdmUgdmZpb19nZXRfZGV2aWNlX2luZm8oKSB0byBoZWxwZXJzLmMNCj4NCj52ZmlvX2dldF9k
ZXZpY2VfaW5mbygpIGlzIGEgbG93IGxldmVsIHJvdXRpbmUuIE1vdmUgaXQgd2l0aCB0aGUgb3Ro
ZXINCj5oZWxwZXJzLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdA
cmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

