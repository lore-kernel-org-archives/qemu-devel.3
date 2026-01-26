Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F44CF65E9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLIU-0003pp-Ow; Mon, 26 Jan 2026 07:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLIE-0003GM-SB; Mon, 26 Jan 2026 07:02:10 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLIB-0003pu-Fq; Mon, 26 Jan 2026 07:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428923; x=1800964923;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pZxHRYunJiE3SIRt4ZlvUlgHSO8UsN/L9dd10D0u5SA=;
 b=bfN6YEWByzE0yvvVHCF7dhJbzjDnQm7fQHdAv3j3/f90SvwGIuoZbvZB
 ukQMpGuNpkBkOs+kZjLuyJGbHFudfH5urMIfx7bVvbdcH23uyjKSj5fiG
 7GE4Uzi2JB+j6Ov7OyWC+c0XmW2/x91c1i41Qyz4/wR1o8DzJ4CGNcPkE
 MOjYzbiKSc7N/CpBuMOixF90fXh+FcK8Nuseu5ZdmibgjHDtHUJMD72mn
 j8v9/dbOEHfiqqTKmj90NiyZsh4FXW0/quOo5UsIkKBlLnnLBLVgtfiIw
 70BtpJdGRhbky1D1l43emH9gwuK9EfJlRcRj8WfJ2PlmfbhfF2KE7+/Ah Q==;
X-CSE-ConnectionGUID: C5FRpCZVSZ6Fy7QVN/Xq0Q==
X-CSE-MsgGUID: y+YD9usRREOniQaikR9eBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="96066832"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="96066832"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:01:56 -0800
X-CSE-ConnectionGUID: wPbzmnKsQ/KL89XUSfuxBw==
X-CSE-MsgGUID: EJTwNcx6Rqe0+Nz9fzE5Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212525641"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:01:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:01:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 04:01:53 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:01:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjgrUv97MESgDE4CliNd2Vgp5igr4pM9ictAZLjS/lEJNbBZj4GvA7uEa/7aknDkqscxBEIledoct7Rb766rg85gb8CeD/nof1Km8fdobVE0cU1UyMixBVRAuT0KSY5o3vqWSvzYCToqZfWq1xZnziQIMrdmao0LCRc9NU8xQVv1eMWCQXHjwWGt/KCFHxr7x/KP/jX/UvrJ1b53NDdFokiR4nd3/+TMWuzBO8gFsr4eKC5aTh1ytuT0+2c1o1b6d5ByuKAtb2r1FiFTseD1PpOUERWn9ukqAjyLiI/raTWRybfp+6AdRgP609XHbaHdbmcEbkqNxSuydTWXw/LdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3BzxbeIvTv4BWUFBLmZCYhIXwmDejKqAUuzReBphIo=;
 b=k27wPw+8DAMqWTqMcwqtKu+1ZlEIkmjpJD5aRDU+Ml/pcbQcSFrmxXoUMAd1mHWnYx5zjMG+3BelKK0W49EGa8FPSoVmUwrNUVPtKxAICYs4DnJouRwrN6wFKkYe62l6a6rQy5XKx7kD8X/WRJtEvBYfO3MG7/bxpgMMyRqGtyXueZtC+WlDQz7nOzmXwlZD1Qf0fOfNYIXNVlcdex7iZxu5Nr7rIoqiFTUpcbMDPZAcU6iknjcM+UBUDzV+2p8SN68fTBJgAQrWk3rFZSmylAmd/ieZEFG4QJUFWjcEoW7Y6jYHfpmyboQy0TRP/Hr4ePln/kpobu70RmtoW09lwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 12:01:20 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 12:01:20 +0000
Message-ID: <fd9ccf26-9462-4c63-a484-b913d0d82060@intel.com>
Date: Mon, 26 Jan 2026 20:07:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 36/37] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-37-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-37-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: d59edda4-1fa8-40de-eaa9-08de5cd29e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|42112799006|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUhoS0JxZSs4UnlUdTF3VlpLdms0QU11OHVvWDYvT0ZLeW5PN2w4b2tKMkRC?=
 =?utf-8?B?Um5YTk1hcHNSSWwxYkZ6OXEvOTQraldLV1RKdDZSMjhnUC8xckVob0hEZm9N?=
 =?utf-8?B?VUdKRXpOZzMxTGpNRVdqVVVGRktMRkI4YVEyUzNNOXcza2cvSGFIRFo2bVpw?=
 =?utf-8?B?Z1lCWHNzWGdUa0tMRmJhQUJ6THlEOTV2VHJ6a3JHMDRqekh6YjlWb2RkajJZ?=
 =?utf-8?B?N3RuSHhmcWNTSTJYaFlJek1lZTI4cXY1amVxeDVOcWVKMlBTb0NTWUZOMWRL?=
 =?utf-8?B?MTVYdWFYVks5OWFkcy9CazJsMUUvZzA1RURKT2plaHFQbWJCRFF0V0FIWW1w?=
 =?utf-8?B?bWhtNmpEbXJhTmxmY3FRUjlwRi90cGQ5aHlxQ2JUVTQvYkc2QUlwSDJKTFJY?=
 =?utf-8?B?REtXVFRzZzJmeHV6OU5hWXQyWUlTUm85aUZ5ejNESDBuWWx1Z2QxK3NzRGFW?=
 =?utf-8?B?TG1qUEM0UGhSV2JURE9RS3h1M2Jnb1h4T2lRbEJDTThzalQwRGloTHI5YXAx?=
 =?utf-8?B?bjBRblo5K3p1cVgycldodDdUMk5JWkVKb3c3cTM0bnAzSWxCK2ducDZqdFM2?=
 =?utf-8?B?cllaLzU2ZHNoaG5Md0JPYlc2RU1iWS8yTkY5ZU96VkRIZ1ljRm9xb0RHdnh0?=
 =?utf-8?B?cE4waEFFMk5VdThibDdiV2dmYVdDVUtmT3JwV3BNTE1KdVBHSVdEbFh5T1U1?=
 =?utf-8?B?VTI4QnZ5K0JWSkVwTFpWSHZNaC9xcTdSM2FNRFdKZ2dTZTdQVXk2eUVseUor?=
 =?utf-8?B?RlZLR1A1eUlFc3Q5V3cxdDRkcjFDaVBTcmZGZXF2VFptOHEyVGFsM2NjNDJ1?=
 =?utf-8?B?b1FJYS94Mk83Y3A2cFhsNVp1cUYxVE1Vbld3bE9salB4VGtIZm1iWE5YVVEz?=
 =?utf-8?B?RDVQTUhaZlVmTE5rMVVtczFyakgzczZSRE9tZm9CMVViREhOSEs3cE5rTW9o?=
 =?utf-8?B?c0FzNlR5VWN5UkJVb29GalN4N0JDa3liZG95aWNKVUVxT09aczM0a0g3Ujdk?=
 =?utf-8?B?Nlh6Z0w2YkF1QmFETml2M1pMUW1VTFU1Ry9qZXA3REV5ckZCbnovRVByOGdr?=
 =?utf-8?B?RzIrRS9LWmxwSlZDTTVJeFY3aXJOWjliVi9lbEQra1dMN0Q5cThrMGlibWxx?=
 =?utf-8?B?amNrSGJGcXB2cFBnV0tFVzk2MTkxc2lrWXRGcHVvQm9vZFlhZUJSTDV6MjJK?=
 =?utf-8?B?QzVMbEFnMTBGYnZDcHUvdFk5Tkdqc2pVdWtuRHBtRHhBR1IzMEU1Vi85WnNE?=
 =?utf-8?B?QW5vcHJlN3RqN0RXbUJPTDVTWEV6STdkWmt5VTN4R1FTWXBRWDN6UmlhY3NF?=
 =?utf-8?B?WEJmVUpqdFE1Wmg0ckY4VjBwMi9YRzh0RGRSZjZuM3R1OWk4Ny9Nd0tKWFRu?=
 =?utf-8?B?WWNjZkUwZWU5cTdDSUJnY2UxMU0wWS9hdEg2TEVCK2ZYc2kxSWcvdExnUHN3?=
 =?utf-8?B?UzQxS2Q2dzFjYWhNTDNlU3orSmN4U2ZJRFplbDF4c0VldFBjQ3Zob1p1VVRY?=
 =?utf-8?B?SUI2aXlBN3J1Tit1OENkdGU0UDIxendwdjRneGNEUjRFdmR0SGR6MnByenMx?=
 =?utf-8?B?TWhLVTZGY0IrZmFsaHYyWHZCTUVJYTRiSXdhQSsyc1ZhMWlZV0k4dk5RUG8z?=
 =?utf-8?B?ODQyTnhtRGtYeWwxSnRpMzZmdDI0cjI4TmtMR1N6RlFHdStGNjUwOUFIc3gr?=
 =?utf-8?B?UXFJVGRTRkxtN3lTQzgxbkVVRlE2clAyZ1RKTEpvYzI3RDZJMzc3VDBkRm1s?=
 =?utf-8?B?KzlrZVAyQUFKNHNOQzRYcGh5RnBWZ3l3Y1JadkJQVTFza0wydTYxM2R3bWtw?=
 =?utf-8?B?NWhaU3ZwRW0rbVNGU3g4QjVkUjBmWldzcXpleWp0THJRNzh2STh5YnpZbS9l?=
 =?utf-8?B?TjR0dzRHNkN5UlllUWtzNlJrY3Y5QU83NjBaa29sM0k0dnMxdjE5NVk1TkVY?=
 =?utf-8?B?VkNuVGNyRWRycVAya0xMUzdxeG5zSUZxYnBMOFBRN1JjUHlDWm9rb2NGaU53?=
 =?utf-8?B?K1RaZkhYZnNoUEdLZ1pWMHE0T0lWNTlTNm0xWGM5MDN2YTRtL3cxZ3BScmll?=
 =?utf-8?B?SjFlWDAxOG5hSXdTWHpybjNkS1BaVHZBNjdPWU1jZjF6MzIzdnVxSVptVmNo?=
 =?utf-8?Q?8xOY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(42112799006)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEc4U3g0SS9uZ3VwSjQvMkhvUWtwSTFQWnZzMHhIbmN4d2dsblNOSEhUU1Ft?=
 =?utf-8?B?TTJrR25RL3BGNVY2VnR4SzhYVUFlMWtsMkxjOFZnRmVEZ0lVSmp0amhrQ2po?=
 =?utf-8?B?VDJsdG96OEgyaFRXS3hjNno5L2NldlUrV1Rad2srcU9RRzkzWi9ZdjIzZ0Fh?=
 =?utf-8?B?MEpwcDY0c0x5bjR5cVp2ZmJjaENHNGRMWXhoQW9wYXZwRXJGQUdrR3R0d0lz?=
 =?utf-8?B?N25CenNuVWVHYW5FODlMS2E4MGRtdmRwM3VHUUxrNmlpSGxWT2RReGxGM09o?=
 =?utf-8?B?U3NFQTlLQldiMjJLUHRjM2I4MmYvcDVjN1N1THZ6K3JFRHprYUNlSjVCeGpR?=
 =?utf-8?B?Qlk3YWNjV1FwbjVIL3hHcnUzNDFxTDM0ak1Ma1ZLK1JocTJzYW9xdHIxem9V?=
 =?utf-8?B?K0VKdVcwenVYNW1YbE1QRC9QQmhpMW1pc3FmOFpQR2JTTnRaSVdLM3QzVzVC?=
 =?utf-8?B?dHliR1NTNjlESE54TFM1ZjBQdm0wK1loM1NNNzNtTG1HVElkREI2RmxxNVZE?=
 =?utf-8?B?RTVNZlFMTk1JSTNEdFRUT3pOanV1SVBMblhOMnBsUG54M0pHZGRuNWtxTG1y?=
 =?utf-8?B?TUc5V1FOWWIvcEpyMXNRSnRqK2o2b1BGZ3lBb3VNdVIrMi9TQTAyZTBwYlNQ?=
 =?utf-8?B?NTYvU2Urcm1IbmNOb2pJc2o3WGJQQVdoWnZnWkc5eHlGbnduTXJxYnNyL2h6?=
 =?utf-8?B?RjdtNmw0NTRRaTZwbi9hUk1jcGFPRW9XRzM2dzBBbVpVb3NhOW9ZR3BPWFZ4?=
 =?utf-8?B?L011d1hTaWFhUE5iWGlaSDU1YXhFRHJkNDFVTCttbEtvNWkzOUZERGE1Zk10?=
 =?utf-8?B?bnVHSkhsOUp3RjdaVTYrR2c2bnFFcS9BT0o5NGJhMXg4Y3ZNN25RdTBTcUhI?=
 =?utf-8?B?RkQxWTh0TzlFQ0VvTXhNdXRtaVB1cHkxa1BBaFRXNlNMUVo2WjljbWlES3Yr?=
 =?utf-8?B?SzdpeXExaHIxZ1FtOXU1OEs4c2ovQWlxSzhEY1pUdFVQalNIanlITEQxN1Q2?=
 =?utf-8?B?SW55Y01zNXU1bFphYUIrM0pNalVYaUJuc0pIY0lvVXZicFBHRytZMnZlNzYw?=
 =?utf-8?B?NmFSUlRaVEs1N2hydmQ3TnpzYWJVZkM2YVhucDc3V3VWODEreEFLTkQydGxC?=
 =?utf-8?B?U2NVanBWTU1xYi9SSHQvTDN3L1daTCt0Y01TQkxEQUR1ZVZkMDdtUWY2VWxC?=
 =?utf-8?B?YmZoWFRRY1BCdTRWTzU0azhHc2tkRWY0d3R0ZkdCbXM5dTU1aTlxV2txcXY1?=
 =?utf-8?B?NVBWQTR5bWNSL2c5Um8ybEZaazVEU0J3ZktLa1c0dDNNdi84RmNmd0VMRDM3?=
 =?utf-8?B?WU0xaXl4eVJwT1Ewa3FjL29XK0hqZ0dGU2twd21oM2E4Ui8wbjVCZjJGdHVN?=
 =?utf-8?B?Ymp0RVNiaXBCZkNYSGxKbWVFUDAyS2crUWJVMlhxS2RWVExjYUlOZGg0d2tU?=
 =?utf-8?B?ZFUxLzdvMkFIVHluVGgyMFh5TFBmNVB3aVNOU0MwSGtwNEZuR0pkOW8rbEw1?=
 =?utf-8?B?T0dzRGtsRjBOdkE1VDF6LzI5UGdTWFI4K3drY1hJWEhwc3FIbStTTXpOd2dU?=
 =?utf-8?B?T3grRGp4MkJkTjk2ZThWWm5hQ1BzVWlDaldzMjUwU2d0SDg1QjV2aDhBTXJx?=
 =?utf-8?B?VmthazlKc0hFMW52emlxVWd0RkxPZk94bG9lTEJOanNvSjh2ZTU3TlZhU05F?=
 =?utf-8?B?akc2NjJhdGhndTNHQXdNYS93cEVMWU1CeVZBMkdvTUgyT20xSGJyd1NOWGJa?=
 =?utf-8?B?U2V2MGpzYmE3UlZuaVpxMjRBUFc0bUxvNlNFNE1Jb2N1OTY5elBRMmZUZXlM?=
 =?utf-8?B?L3NNY3BURGl1NzFqMHBkUFhOREU5c1JHMzI3SjVaVVhhSW0xTHNqMmliQU9L?=
 =?utf-8?B?RWdyVXo0L2ltaUdYTFlCMUc1UkNaSm0wL2VFd2RhRnRsVkgvUUs2NGZ2Vm9U?=
 =?utf-8?B?WUtQOE9YWXY3ZkFOcG5VdHRBRTcxalMxeXlRaFhpN3N0cGFUQWZKOFVGUnJB?=
 =?utf-8?B?bncwaWw3RlJmSkFBTjVibmF6RDREMmgyVkc1RS9wODRFMi92akF4eFpxOUR6?=
 =?utf-8?B?ejF3dU51dnNDWDVoUTBjaW9QWEErSGsvczMwNjg2NGh0TERjbEdMejJuVjRp?=
 =?utf-8?B?cENtWXdzZEs5enpFcnYyMHo5Nyt5bWd4MUpJTG1ubmNva3FrVi9WUk90SGlL?=
 =?utf-8?B?M3p1dXpqaUhHTlF2ZWxML2lON3grYVlYem1YVDNRYWZlMW9CUlNzY0FQeWVo?=
 =?utf-8?B?MHdNR0N0MHl3eW01VldkM2lHTjdxM0JqcEdUN3NOYnZQNXBRNklpTFBJMVdJ?=
 =?utf-8?B?THh5bStkZms1QUg2RVgwOE0xUDNSaU1kTjVtaFBQeGUzNC9NRHNIdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d59edda4-1fa8-40de-eaa9-08de5cd29e33
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:01:20.2987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYzkP8ckHX1Yqn/wSofu47GsDsdnV+2LqrJaA7Ul0c0bdk0sSTw/THFSuJ92JbxbvLZDWK0vpTpMSaKaTgsWUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/1/26 18:43, Shameer Kolothum wrote:
> Add support for synthesizing a PCIe PASID extended capability for
> vfio-pci devices when PASID is enabled via a vIOMMU and supported by
> the host IOMMU backend.
> 
> PASID capability parameters are retrieved via IOMMUFD APIs and the
> capability is inserted into the PCIe extended capability list using
> the insertion helper. A new x-vpasid-cap-offset property allows
> explicit control over the placement; by default the capability is
> placed at the end of the PCIe extended configuration space.
> 
> If the kernel does not expose PASID information or insertion fails,
> the device continues without PASID support.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   hw/vfio/pci.c           | 75 +++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h           |  1 +
>   hw/vfio/trace-events    |  1 +
>   include/hw/core/iommu.h |  1 +
>   4 files changed, 78 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c734472721..36d8fbe872 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -24,6 +24,7 @@
>   #include <sys/ioctl.h>
>   
>   #include "hw/core/hw-error.h"
> +#include "hw/core/iommu.h"
>   #include "hw/pci/msi.h"
>   #include "hw/pci/msix.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -2498,9 +2499,62 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
>       return 0;
>   }
>   
> +/*
> + * Try to retrieve PASID capability information via IOMMUFD APIs and,
> + * if supported, synthesize a PASID PCIe extended capability for the
> + * VFIO device.
> + *
> + * Use user-specified PASID capability offset if provided, otherwise
> + * place it at the end of the PCIe extended configuration space.
> + */
> +static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
> +    HostIOMMUDeviceClass *hiodc;
> +    PasidInfo pasid_info;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint16_t pasid_offset;
> +
> +    if (!hiod) {
> +        return true;
> +    }
> +
> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> +    if (!hiodc || !hiodc->get_pasid_info ||
> +        !hiodc->get_pasid_info(hiod, &pasid_info) ||
> +        !(pci_device_get_viommu_flags(pdev) & VIOMMU_FLAG_PASID_SUPPORTED)) {
> +        return true;
> +    }
> +
> +    /* Use user-specified offset if set, otherwise place PASID at the end. */
> +    if (vdev->vpasid_cap_offset) {
> +        pasid_offset = vdev->vpasid_cap_offset;
> +    } else {
> +        pasid_offset = PCIE_CONFIG_SPACE_SIZE - PCI_EXT_CAP_PASID_SIZEOF;
> +    }
> +
> +    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER,
> +                                pasid_offset, PCI_EXT_CAP_PASID_SIZEOF)) {
> +        error_setg(errp, "vfio: Placing PASID capability at offset 0x%x failed",
> +                   pasid_offset);
> +        return false;
> +    }
> +    trace_vfio_pci_synthesize_pasid_cap(vdev->vbasedev.name, pasid_offset);
> +
> +    pcie_pasid_common_init(pdev, pasid_offset, pasid_info.max_pasid_log2,
> +                           pasid_info.exec_perm, pasid_info.priv_mod);
> +
> +    /* PASID capability is fully emulated by QEMU */
> +    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
> +           PCI_EXT_CAP_PASID_SIZEOF);
> +    return true;
> +}
> +
>   static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
> +    bool pasid_cap_added = false;
> +    Error *err = NULL;
>       uint32_t header;
>       uint16_t cap_id, next, size;
>       uint8_t cap_ver;
> @@ -2578,12 +2632,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                   pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>               }
>               break;
> +        /*
> +         * VFIO kernel does not expose the PASID CAP today. We may synthesize
> +         * one later through IOMMUFD APIs. If VFIO ever starts exposing it,
> +         * record its presence here so we do not create a duplicate CAP.
> +         */
> +        case PCI_EXT_CAP_ID_PASID:
> +            pasid_cap_added = true;
> +            /* fallthrough */
>           default:
>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>           }
>   
>       }
>   
> +    if (!pasid_cap_added && !vfio_pci_synthesize_pasid_cap(vdev, &err)) {
> +        error_report_err(err);
> +    }
> +
>       /* Cleanup chain head ID if necessary */
>       if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
>           pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> @@ -3756,6 +3822,8 @@ static const Property vfio_pci_properties[] = {
>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>   #endif
>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
> +    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
> +                       vpasid_cap_offset, 0),
>   };
>   
>   #ifdef CONFIG_IOMMUFD
> @@ -3913,6 +3981,13 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
>                                             "destination when doing live "
>                                             "migration of device state via "
>                                             "multifd channels");
> +   object_class_property_set_description(klass, /* 11.0 */
> +                                          "x-vpasid-cap-offset",
> +                                          "PCIe extended configuration space offset at which to place a "
> +                                          "synthetic PASID extended capability when PASID is enabled via "
> +                                          "a vIOMMU. A value of 0 (default) places the capability at the "
> +                                          "end of the extended configuration space. The offset must be "
> +                                          "4-byte aligned and within the PCIe extended configuration space");
>   }
>   
>   static const TypeInfo vfio_pci_info = {
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 0f78cf9cdb..d6495d7f29 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -187,6 +187,7 @@ struct VFIOPCIDevice {
>       bool defer_kvm_irq_routing;
>       bool clear_parent_atomics_on_exit;
>       bool skip_vsc_check;
> +    uint16_t vpasid_cap_offset;
>       VFIODisplay *dpy;
>       Notifier irqchip_change_notifier;
>       VFIOPCICPR cpr;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 180e3d526b..b48c4abe7a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -40,6 +40,7 @@ vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %
>   vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
>   vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
>   vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
> +vfio_pci_synthesize_pasid_cap(const char *name,  uint16_t offset)  "%s offset: 0x%x"
>   vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
>   vfio_pci_reset(const char *name) " (%s)"
>   vfio_pci_reset_flr(const char *name) "%s FLR/VFIO_DEVICE_RESET"
> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
> index d5401a397b..86af315c15 100644
> --- a/include/hw/core/iommu.h
> +++ b/include/hw/core/iommu.h
> @@ -20,6 +20,7 @@
>   enum viommu_flags {
>       /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>       VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +    VIOMMU_FLAG_PASID_SUPPORTED = BIT_ULL(1),
>   };
>   
>   /* Host IOMMU quirks. Extracted from host IOMMU capabilities */

