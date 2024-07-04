Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE90CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLuO-0006GG-Ah; Thu, 04 Jul 2024 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPLtz-0005AL-GZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:49:33 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPLtt-0006Wg-1c
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720097365; x=1751633365;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jGVAmgM1YUx2Rmm9eO5hSd5VCfaeNr3ElMEzMtAiujQ=;
 b=KQbnZk28n/rHamJpVgta2Ezx/jFGkoaz4UpzaIN5IiuiD/VM7qm2Kmmw
 BoOXpojXJWbtgdFoJwBhy1B0ykPz5EduZ3FBdv9cdYHAy+pNcHOLSeTHT
 VTPWd89ClCAMfcbbankY1jKrIIiG0E9ylbYpXh0ItA9EbGu7grWKy20Lm
 yo9W11E+kXIxpCOYHze3wvk09qR5VvBzGVgK2TygXbA4HGTf9vtlDEaIM
 0g5dNl7KnHhVFfb5QLGgekfH5euyA/mF7sW2GXVX8MCylg7OQVSMH0iEM
 t6ImCBWv+IwmJMTBR/qNLgt6L9pKwrbF8SEC21uuOFdGM7UCwsq98iT3r A==;
X-CSE-ConnectionGUID: wJ4AVX00Rc2eCCItxxASEg==
X-CSE-MsgGUID: nIvufYeCSbmSqtzGeb4big==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17193656"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17193656"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 05:49:07 -0700
X-CSE-ConnectionGUID: uIFagib0Rd+vlPLVSUblGQ==
X-CSE-MsgGUID: xOQTDvryQEq5bEDIoEp3kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46480719"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 05:49:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 05:49:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 05:49:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 05:49:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 05:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUEWmbuGhFHqXYEuulawIG/RoxeQls8bYZ0hIRddsw603MGVP3L4MzkTm10L3pCACHoihit1VBFy2CN0RckFEWAO8jhLUObF+T8Mw2JKBXO/0t5QOQ4sfu1PoUcVjVND4ypBqYnWompCaXGEFCUSMCKHU/hUds61KC9h3IVNRg/S+Ydud2C2nS1majEvvHky5g2BQz5b051wbUXDdcF+0rb5x8t5MiPjCBlgGozykrJwvgovFDm5TmvHs9Q6B8Ldb/6GhpI10AeY49NOlLiJCGzbjkFz56y73nMkOLUVSyX1XIbBW9ZK0oeTdEW+WTyujcB2T20Oe3ALLxMtU+x4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/AxhA4RY0IUiilnXwe9P+eg+BV0nEyR5pm34ewcTJ4=;
 b=Xxr6hpUD8TcuzBUSBnQDyG1so9/hQSj+40lkNsIDKOQx83Qd2+2Sga6qA6iOBfIUX5s9FNKOhmaqHSJZDiKCRfHL3pvbvnYgiBDfEdC2L9bhNy6zCSy+fOBEGuXHuZIfFSyaRCNpuHHxTWs+S9eAh3x/Z/vfQvs+kEnqnbWs4aGmicsknUUW3q8V2izBUL4frEqHo/kBp9s1ROAWoskQcxlN/Sr5ywTQYr7Wd1d8m1E207c1TM+4G3zaNODtQOo+AOyZ2Syw8Z9pepIlpwdwFAcrwiMZA9qpYKgTdW0SHuAeMQb1Zd2KX4h6tb+bDOxP3RFKDmm/iClK5aiqMxvxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4848.namprd11.prod.outlook.com (2603:10b6:a03:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 12:49:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.029; Thu, 4 Jul 2024
 12:49:03 +0000
Message-ID: <ce5730ef-95e5-4167-af5a-237bde5e04f9@intel.com>
Date: Thu, 4 Jul 2024 20:52:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 19/22] memory: add an API for ATS support
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-20-clement.mathieu--drif@eviden.com>
 <ca43f372-413e-4e3f-b4d9-26164f5cb7db@intel.com>
 <4ba9b7bc-b965-4a24-88aa-ec1010d60189@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <4ba9b7bc-b965-4a24-88aa-ec1010d60189@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f574de5-c6c2-49e0-955b-08dc9c27af34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2dPRFJFeXZRL0U2d0ovL3YyM29GK2VKUm9qNUdCaEc0SEo5NDQwclcrZVc3?=
 =?utf-8?B?bXlhMzUrZnpzeHdPT0luY0xZU0I4d3NnR1BBYkRIYTMxQ2FRc0tXNlZZNlo1?=
 =?utf-8?B?U1BoQ2JBMXh2RTlLOU1UOUh6ckY5U3dQY0JJcndjLzRJd1J4NlNxNUNOVGpw?=
 =?utf-8?B?cFdBYndaMGFYTUJIcFcycXRuSlczN1RIZC9qK1JKU2ZuajNqallQbUgvb2s3?=
 =?utf-8?B?MTd0SG1YUlNTZ0NvR1Z3R0k2dEZaVlNkUklUUm84K3N1MU9MUkVHWXN6VGxR?=
 =?utf-8?B?aEJoc1d4ZmxlZEYyRmNIWDdPQkF6RjJtNWY0dCs2aXZZUTRJVGtqV2x0OUFM?=
 =?utf-8?B?Y1R4cHNZNnpJaTlZVUx4NzVnUTdTdmNCQjh0NTZkcm9iYXFld3NxMkNFN2xS?=
 =?utf-8?B?SWFWSmVQeVJXdjA3K3FVYjVXVlJsbEptS3lLWDJiTzRNNWdDTU1obDE0NFRD?=
 =?utf-8?B?RUIwMjlqcnU4MWZNRHhoeUZsenhEQW5qNHZ0VkNzSW1nK3MwRzExUm45UjNP?=
 =?utf-8?B?ektacG5meUcxL0ZQbldNQjZDWnYxc2hGcTlWcGNmbnY2cGpBQmc1NFF0Z0JP?=
 =?utf-8?B?dnhRQmJ4SmVwanRnR1lsd2dFOG9xUDgvazBCSzJsSDd5YWRkYUdmdm9Db1Nk?=
 =?utf-8?B?Qlkyb3M3alhFb1lnS3dLWUFGWm9MelVsRlgwMVUxVTRTM2NuSWJWUVdTYlhW?=
 =?utf-8?B?aE1IRHlLTlU0TkNIZkxnVGlYNEJWZ093Y0xIY2dJSjB4cnY3SkhvYjFlYWhz?=
 =?utf-8?B?QmZaVWh1N3BDV296bzljbkc2RVdQZU5sS2pSOEVmdTVYOTdGdHFNRTVrQkRP?=
 =?utf-8?B?bHVzS2V4SldHZmlMb09FV0pDaUVObE83NEpHVjNKU3hZNFc0YnRCNDk0MGtZ?=
 =?utf-8?B?bG5XSncwT0lNWWlsNWxLZWhMY2doWDVjUW9qUmY3YXMzdnpYazIxZkJncXlv?=
 =?utf-8?B?UDc0MkN1MnBYVFpwZSt1N2ltZjhHYVVwYWptVGpMRC9HTmtyNkZyMFJvZ29V?=
 =?utf-8?B?djhzN2g1dC9naEZpRFh6TUV0QkZXKzJJMWQ0Qko0a1hEd05HQlZWcEg0V2Rp?=
 =?utf-8?B?SnU3QmJtUkU2cytLNzN5aXFPcDRSVHRGTkxZSHRBa0pKdW5YeGtlRm16Mk5z?=
 =?utf-8?B?VVg4c2F0NCtMZjgyQjYwaWVFd3FCd0d4dkVZUnZNZkNJV2tpZW16Mko2ZHNw?=
 =?utf-8?B?ZFROemkxOUdDNWdicHdBTlBSODNYUUhyUGxkdjVtZDVFNXJZaGVWaVc2d0pi?=
 =?utf-8?B?dGVGZElvYlROVlpyRE55SUo5WWpZODlMaFl6eVBxZW13N0RwZWYwQTE1WUJY?=
 =?utf-8?B?dTI2dEZhbk1BMWVZbnQ5cXo0MkFYS1lQeUttWWNDU1kyU05TWVZ0RDNmb2xH?=
 =?utf-8?B?T3BaWUU4b252eVhIU2JxZURqbEhmSWZnYnEzMys5bWtFamJOM3RIcXRFWUlu?=
 =?utf-8?B?MVQ2b0l3UTBGOTVwUFhpWG92MEN6MzNzYUl3dDZvMG12V3lWcnZDaFVSRXJj?=
 =?utf-8?B?dnhQeGFXcUZpQ29weDVnNlFnbUZnYTFsamJYK1JvNWZwRlJJMXNxODV3Szg2?=
 =?utf-8?B?bG9tWllpTExidTl5QmU0MUYxQ09kT2FyQ2hKamhTRkU2d2FHanNJd0szaWhL?=
 =?utf-8?B?YmxOMDZIZWtYbUlpMnZNa0djKy9jL0pzQXNxTEF4blVvN0RtakxWWG1KdmJQ?=
 =?utf-8?B?NE5MamdweHRCYThZUW1nMFp4ajRDOWRnckM4Q1B6NnRsRjNjZjVlNHhsNXJR?=
 =?utf-8?B?Y1ZRd1NQQW5CRWwrRzVTclI0NXAwL0NBQy9acnFvUnhPNVhpcmdVRkg5SE5X?=
 =?utf-8?B?YWhEeGtZOFFvZ0ZWbnlOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkp3OUZTeGZ0MjdUaDBjQmNpK1ZyRE8yRVRLZVNHR1pveDJwSFpDRnVXOWp2?=
 =?utf-8?B?UmtOUFZkaFVHakN5QkUwam5hMFNqSlpMK3dWaG1YNnIrYlAyWHRDMFJwbG1k?=
 =?utf-8?B?b2o3cGw0VnJROS9xREZlYVVWZFJYTExqcDhneWl5dk9IaEN3cnROcVh2NG9l?=
 =?utf-8?B?U2xyUXdwdlpCMTREaytlTTRudkk5UXozMXcrVWYxbUQrcnhXT0FsV2lScm9m?=
 =?utf-8?B?ZUh1OVFKSE44bjMxdFVUYU0xOFNzS1RtRnJuUUlnbEh2Q2QrUVUzSUhseDd1?=
 =?utf-8?B?UjAveWRaQ25qRGMvZTZRZXRuVHlYempXWjdRR2JJTlR4TFVEdDFnNDROc05p?=
 =?utf-8?B?U3VzUjkwZS9PZG5GQVZVeUhRbFRkZEJOcjMvWExUdUhlT1lTcUJzVW02a2Jx?=
 =?utf-8?B?T2I4MlNPOVh5Y0VLNjY2c0F2enVmNWlEeWEwd1ByOEtWTkpKbUpxZFFOQ1I5?=
 =?utf-8?B?RXQzMkcvR0t4bTBIQUw2TUN5ZjJpVTV2ZThTdHlyUjgzdzEwWmhrRGZiM1Rm?=
 =?utf-8?B?TDBieFZ6YWJhREtnMUlrM2tqLzdvNC91eCtwRnl3K1JJcmQ5RzJQdkp3cmhI?=
 =?utf-8?B?QmNJSDNZTFM3d2ZtNUFxWmFzN3JoQU9oN0RmOGhMa0tmQU1oMkRjU1FFYTFO?=
 =?utf-8?B?T3lOdVA5UVVyZSs3Mm14OXptaUJ6RHdKb2RuU1I5ODZUZXZxUjdXREcvbkll?=
 =?utf-8?B?YWhXK2xVNERWZXJxZm4wTUttdXV1cnNBVjhXNXFaeVFxMTF6WmFReG5GYytS?=
 =?utf-8?B?UVp2NlpZRHJzV1dTNmNLTjFaVEcyZVljaFpUWTNTT3VpaFR6WFRQQzZoS20z?=
 =?utf-8?B?M2dpU01JbFd3bG9CbkJiaHJvTGRWYytGQXEyb1JPWGJRMzVXVGJUSGxPVmNE?=
 =?utf-8?B?NW9mR09lTktEMjNuN2kwSGVYeVJUd29CSHNJQzFIZFYyejRwRlpSVG94byti?=
 =?utf-8?B?TGg1UkdsT2dpOXVHTG0zVi9sbkUzZGwzWUVKbm9jeFBWYTZNQnhubldJc2JY?=
 =?utf-8?B?RUhsTk84YXJGTSswSGpjS1gzelFmTm9BU1NwZnBUUENXRml1U1ZkQ1p3cCty?=
 =?utf-8?B?cFZER0kxV2h0UTBOaFFoMVBTdHBjMVN3RnllV3VMVVBTbzdPbllFNmY1YWI5?=
 =?utf-8?B?aENxVU9WdXEwZjBnNEJwc244eCttYTFYUTJxc2ZQbjRjTVVNYWxIeUtVRVBJ?=
 =?utf-8?B?dTRJTUlOYzdXcHg3a3RUK2ZCd1lrWEJEcXcvMSswbEswOFlYZVROd1hPakc0?=
 =?utf-8?B?VnNWL2VmNXgrRzg0dzd0a1hQY2ZHTzZQM1RSSHhnVDV4SWhrcWF6bzgrOW9k?=
 =?utf-8?B?YTZFVkpXN0J6Wm00RTF5MmJUWFVOWStRbHd2amJyVkhhcktBNytpMW1PWVp3?=
 =?utf-8?B?Z05OQXhTSFNaMkZyNGx5VlY3RUlnN0VKSlJIak5vRG5GdEovNjZSZm5rNXlR?=
 =?utf-8?B?R3llTXJOd1hIT2xDSGRrMUE0c2FLM2JVZzNrMzhveXd5NWtuZS9NMjFIaUdF?=
 =?utf-8?B?Q1FieVg1YVpySmVxOUVYMWQ4MFJkZkZMZllaM256Vzdob0NWTGQzOFpTRFhy?=
 =?utf-8?B?SVVEY0Rad0ZNZVhsRHpQa0RSZlNFekdaRFVxMHA1MWMxWTZ1TmhoaFB0eUxR?=
 =?utf-8?B?Y2RIamJZN2daM1RYVElRcEtiNitNVXlDZ2dOb0lhK0w0NzJ0Nk9pWklsZWs4?=
 =?utf-8?B?TnRoNzFHSm0vQmZ3ckhaZ3BONUhWMDZ0UkhDVlNHOGVsUHYvL0pnb2V6Wmow?=
 =?utf-8?B?dEUzR3MyNG1CWGJNWUhxSVdqTFVEV3U4VlNsYWYyVGk4ZzNXY3dnMEJydThU?=
 =?utf-8?B?ZU1id2ZZSktTRjhpZGNBU3ZnSWNwWWtYWGZxUzZhVEdOUzFlM1hHV0JaaGNQ?=
 =?utf-8?B?ZlJ0RzhHdEFPcW9yTDVjQ2RpK1FsbVdwZkh5cUcwMFkrSTI3em9ZVlRSVTJS?=
 =?utf-8?B?MGFWMFUyYld4RW04b2ZEZG05WXRmQStienBCWUNzR3lQOEVsR3pwTk44a3hV?=
 =?utf-8?B?V3ZKc0RFUSs2Tkt6NW5HcGRnaFlmSjRjVkFoUzE1dTR2MkNkd2F5VlRnSDNF?=
 =?utf-8?B?SC9SR0h1YmVmVEg5YWgzZDVxK3JicWlET1dxODVxbkgyTDVhN2xUZUkybUVH?=
 =?utf-8?Q?scFIhIeQm1OiBg4wYeSgEqKlH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f574de5-c6c2-49e0-955b-08dc9c27af34
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 12:49:03.8036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dE0NGM44Oc33B0q+7Xv8WXbWRh+Iey3OMg2gBw2Fsmpjxvbq9FZFKAtl1Db2DijPyoTS/w4MZuSgE7oXxFP21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4848
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2024/7/4 12:30, CLEMENT MATHIEU--DRIF wrote:
> 
> On 03/07/2024 14:14, Yi Liu wrote:
>> Caution: External email. Do not open attachments or click links,
>> unless this email comes from a known sender and you know the content
>> is safe.
>>
>>
>> On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
>>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>
>>> IOMMU have to implement iommu_ats_request_translation to support ATS.
>>>
>>> Devices can use IOMMU_TLB_ENTRY_TRANSLATION_ERROR to check the tlb
>>> entries returned by a translation request.
>>>
>>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>> ---
>>>    include/exec/memory.h | 26 ++++++++++++++++++++++++++
>>>    system/memory.c       | 20 ++++++++++++++++++++
>>>    2 files changed, 46 insertions(+)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 003ee06610..48555c87c6 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -148,6 +148,10 @@ struct IOMMUTLBEntry {
>>>        uint32_t         pasid;
>>>    };
>>>
>>> +/* Check if an IOMMU TLB entry indicates a translation error */
>>> +#define IOMMU_TLB_ENTRY_TRANSLATION_ERROR(entry) ((((entry)->perm) &
>>> IOMMU_RW) \
>>> +                                                    == IOMMU_NONE)
>>> +
>>>    /*
>>>     * Bitmap for different IOMMUNotifier capabilities. Each notifier can
>>>     * register with one or multiple IOMMU Notifier capability bit(s).
>>> @@ -571,6 +575,20 @@ struct IOMMUMemoryRegionClass {
>>>         int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
>>>                                      GList *iova_ranges,
>>>                                      Error **errp);
>>> +
>>> +    /**
>>> +     * @iommu_ats_request_translation:
>>> +     * This method must be implemented if the IOMMU has ATS enabled
>>> +     *
>>> +     * @see pci_ats_request_translation_pasid
>>> +     */
>>> +    ssize_t (*iommu_ats_request_translation)(IOMMUMemoryRegion *iommu,
>>> +                                             bool priv_req, bool
>>> exec_req,
>>> +                                             hwaddr addr, size_t
>>> length,
>>> +                                             bool no_write,
>>> +                                             IOMMUTLBEntry *result,
>>> +                                             size_t result_length,
>>> +                                             uint32_t *err_count);
>>>    };
>>>
>>
>> I'm not quite understanding why the existing translate() does not work.
>> Could you elaborate?
> We need more parameters than what the existing translation function has.
> This one is designed to get translations for a range instead of just a
> single address.
> The main purpose is to expose an API that has the same parameters as a
> PCIe translation request message
> and to give all the information the IOMMU needs to process the request.

ok. Please make the reason clear in commit message as well. Let's see if
any other opinion on it.

>>
>>>    typedef struct RamDiscardListener RamDiscardListener;
>>> @@ -1926,6 +1944,14 @@ void
>>> memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier
>>> *n);
>>>    void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>>>                                                 IOMMUNotifier *n);
>>>
>>> +ssize_t
>>> memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iommu_mr,
>>> +                                                bool priv_req, bool
>>> exec_req,
>>> +                                                hwaddr addr, size_t
>>> length,
>>> +                                                bool no_write,
>>> +                                                IOMMUTLBEntry *result,
>>> +                                                size_t result_length,
>>> +                                                uint32_t *err_count);
>>> +
>>>    /**
>>>     * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
>>>     * defined on the IOMMU.
>>> diff --git a/system/memory.c b/system/memory.c
>>> index 74cd73ebc7..8268df7bf5 100644
>>> --- a/system/memory.c
>>> +++ b/system/memory.c
>>> @@ -2005,6 +2005,26 @@ void
>>> memory_region_unregister_iommu_notifier(MemoryRegion *mr,
>>>        memory_region_update_iommu_notify_flags(iommu_mr, NULL);
>>>    }
>>>
>>> +ssize_t
>>> memory_region_iommu_ats_request_translation(IOMMUMemoryRegion *iommu_mr,
>>> +                                                    bool priv_req,
>>> +                                                    bool exec_req,
>>> +                                                    hwaddr addr,
>>> size_t length,
>>> +                                                    bool no_write,
>>> + IOMMUTLBEntry *result,
>>> +                                                    size_t
>>> result_length,
>>> +                                                    uint32_t
>>> *err_count)
>>> +{
>>> +    IOMMUMemoryRegionClass *imrc =
>>> memory_region_get_iommu_class_nocheck(iommu_mr);
>>> +
>>> +    if (!imrc->iommu_ats_request_translation) {
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    return imrc->iommu_ats_request_translation(iommu_mr, priv_req,
>>> exec_req,
>>> +                                               addr, length,
>>> no_write, result,
>>> +                                               result_length,
>>> err_count);
>>> +}
>>> +
>>>    void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>>>                                        IOMMUTLBEvent *event)
>>>    {
>>
>> -- 
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu

