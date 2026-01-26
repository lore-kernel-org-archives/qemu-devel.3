Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF4CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLM1-0007Wf-8r; Mon, 26 Jan 2026 07:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLK0-0005Zg-AP; Mon, 26 Jan 2026 07:04:06 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLJe-0004CC-83; Mon, 26 Jan 2026 07:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769429014; x=1800965014;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k18hW9hKlSIDRa+je4lhZmX2gdgJgdgesLjkydBNwRw=;
 b=fJBh1W/pocr8MwRoMJkIVYqDjMWAiDBrhsbTGQrTGliBMjoKtgQlvuFW
 2nif1iLZ5dB1gHnoww9pR6dHEEMN5QyGmC5/eQCTCoVKu4QZdHNQLsGTc
 ycnnt748k3Q7bBCc7yxSrpCnW27bm+0KPPTDR0Ia4bt8OgqzLXXahzSlm
 rkOK5AbFGuGWMHxcH8bEI1JRgBMClr7PVoFvGx/pDbfd6q5dhfnm5n/Ew
 KUwgShPAMfA9Hh4Vp1zVX/dOwJHfa3xHvt1Y3r/OJpNnHnEpk5hfUTXbe
 TLJ94AQqQmTyZJOahoeP8oBmPxtLrXRCWmq+WyzmJot/TaXtt77x/PmbV Q==;
X-CSE-ConnectionGUID: A9ppkODaSH2wwoDMOEuQyQ==
X-CSE-MsgGUID: bbTLn497QAeyE1RUBYGBiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70647345"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70647345"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:03:32 -0800
X-CSE-ConnectionGUID: 3KlO3yzvThehUZpNGcvHHQ==
X-CSE-MsgGUID: YZ+z21JxSyS59WTi2TX5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="238343636"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:03:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:03:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 04:03:26 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:02:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU/zMKcuD2+BhWzzLUSY6k6Sjmp+FLeQG95f+nWfOm+4LQ8AulUGLSSM76iweMJlrf5Ma7h6mCqJkWIb/a3i4iOEKyOIdVkeuPnynWQJBlOj3gCxRxAjh4beQK7oTtIRsKc68Nb2TVRia35ACTRHQCkX+3nrkiu5DBnlRua/0tUG293Cl08BCJjKbCreW+M5Z2rqSOcWuGvlqMk23C51jb5idnK8d4FudU59gBhoA425lYJZYgLnCpcAb43o9PYnksj/evMtpdICdgV/I19FB8tJiqFQh1RW6aMILrNLFDnzsjsAgdxNL27gStkopfIVlfllVP2/rWuejW30LJ19sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFBdqAWv1GLmew1xD+wh5SknVt/8ldUdYGhKwS1oQb0=;
 b=HWDBQE0wYgAkFEJC/Nw/SsipXnGdfNvC2kKwXPrkfSLMRNhNoQNOBwGuX8oaWl8OKLml3pxU50ccFo4pYoTrMl1WsHuUdMCfWsscb5q6Cz0EdMZ9rS6FYXhiRZ+W7nYoAd41mr2pCk2+LQQm2Ej8LTKkcMgqz4lmjbbuHMhBIua5GYAwNf8zMPjDS8uNk47OhoS8SDdDxe1IIk+5W00GEER+Ib2A09LniWzAuF5t8aJAyD6m2E4jVrQVJluLRlGpJ8+H4rmJ2qZRDuftV7K+HCjmd+ErW8yRtjK/5l9BWnwBTeB787zR1WQT00OdgWRuCowN0VB/GF1+fwDW27pNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 12:01:13 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 12:01:13 +0000
Message-ID: <b3e91b9d-b5ac-4fa4-8202-b88e92bfe7e7@intel.com>
Date: Mon, 26 Jan 2026 20:07:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 35/37] hw/pci: Factor out common PASID capability
 initialization
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-36-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-36-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a09667-5264-4cf6-a741-08de5cd29a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1qRDZtaDc2cTlSWUxKYlVyK2l6M0pVOWQya0tJem9qYzBRdkpHWmhXSWIr?=
 =?utf-8?B?WGI4dmZkYjJOVC9pME9XNGhkY3pmWHFreG40cFNCMmFnRW4zMmJmWHNMSkVI?=
 =?utf-8?B?MXU0QWExZkRsaHZ2NThiTEdYeDY5aERXS3B5bmowWHhTMCs4N3EwUGlFS09O?=
 =?utf-8?B?VGVDbzdnVFhCdHg4eE1IS1VEZ2t0czhXVTc0eXJ1cW1oMnE4c0FlVUI2Z2VO?=
 =?utf-8?B?SVFPdEI2K2NVdG5lZm5SYWZFRTBoc3c2MkhvakV2b1UrbjNYWEs3MS9XWGhK?=
 =?utf-8?B?MFdUWHR5RjgrbWJGcjFacXJ6UXZqOFdBSXpLbWJMUCtVNEp1cXlRQVVITDNY?=
 =?utf-8?B?Z2NGN2FZbGhlVFdpVHdmWlFJVjVkeFd0VSswZlJxaStVMWFZN0U1TjZ6ZS9Z?=
 =?utf-8?B?Zm9JT0JXWGh5cFduZlNxTFFmNWRxR0VDSjJkMTFqbjM5alh0ckFrcFhmNTU5?=
 =?utf-8?B?UDBzanlvUzFENy91UWd0VGs3VDViU0R0eDh4eUdlMWtFK1pIUDNSU0lEMytN?=
 =?utf-8?B?dzFWckF0L1JxVnUydzMwL1BxYkw4MU1wQVRSSDdHUE9hM2RuSncvek80d3p5?=
 =?utf-8?B?bzRXZkRwdFhhQkV6MUtGbnZTSXpxRFJiU3JlZEJwb1NJL1lub0Q1ZmpHYVFr?=
 =?utf-8?B?bUVwUjl1elo3RHlCWXZndFpyNzYxOUlodHdPMEdGNEd5OUtaS1BRRDNKWWhB?=
 =?utf-8?B?RWh1MXVrRS8vT00vZEpyNGpIZUx5K205RmpkbWowWkVqNW9iNnBsM0NRRW41?=
 =?utf-8?B?VnhyVU5iWVlNQnhRVFZpMUlrYzZnYnNzS3RTVHBoWi9oWDdTUlZqVjZxWDNP?=
 =?utf-8?B?NXNldWFKcVFEUTAwUFAwV0VmU2Fzb3FEN3lhLzdQdTR0cVFDbjJiMzNnanc2?=
 =?utf-8?B?amVQWGtLRW1NR0ZCMVlQTlVGZGdCZ0VIY3pzUEcxdHNTU2c4aUtGeGRoY1VE?=
 =?utf-8?B?OVJCeEo0VCt0RXFZRG5MQUtVbmtBcFNvVUkwU09DMThmYlZlQ25WS3JaVzF4?=
 =?utf-8?B?NUEyUXkxd3VSZ1JWaGFJM1p4dXFIcDMwUDU1ZnoxTFpGNXBZZWUwY2JXNlhO?=
 =?utf-8?B?SklrZnRMamkydmRiZUtueTFVdUlEQkJFWjhrUmZtZlp6QmNkNDdNekdtL3pJ?=
 =?utf-8?B?UWd3aWtHRGlVUTNGejE3bnB0aTFqU3VVcDg4bXczaHZUOXJQK3hHbHVDMUIy?=
 =?utf-8?B?aTluMUVIRVREZUo4VjdFM2lodHlOdTRzNnlwaUFtTmFxaUxRMW1KWnNMbTFS?=
 =?utf-8?B?RDhJR3JxVlpvUXVVVGkza08wcDRzM1FLSHBDVU1ZazV6d3lBVlZSNzN0bUxM?=
 =?utf-8?B?RnlSd3ZYaHBLRG9EbzdRcEt4NVdJdFBYNS85NGtNQmoya2xKTWk4Znd5V2ZS?=
 =?utf-8?B?VitoRkxZT08vaXplaUp5ZlBROVRNNTBUT2hGakNuV3FhUmI3bFVTMVMyV2xJ?=
 =?utf-8?B?bVpYN09Pemllc3U2Q0lJMU9YMVB4MG02WVliTnQrV01oT2UvMnd0bkhGVGoz?=
 =?utf-8?B?aG9vVk1seVRKQUM0cXpoaFJ3cTJTYVU4N1NseHBCZ3dFMnZMWlA1SjRnam5o?=
 =?utf-8?B?Sm8wUGFsZHVMVStBakxMU2pWMm5zZFVOeTczTVpVVytTTVFOeE03NlU1WTNy?=
 =?utf-8?B?dkVsRHBESmsvZzdSOU1lTjBSV3dPZnduaTFIVThLeWxWZXVpaW9zU282OS9N?=
 =?utf-8?B?dzNEOFpKS1dwSW5paWNWV2FvRUh3a0JMbXQxeDhSM1QzbUVWRnVHK0JLZkZG?=
 =?utf-8?B?bGZhZklBbEw5ZDJ0ZjA0TC9vREJUekhWM2FTei9kVjlBdEQzMzhsa3pIWnN5?=
 =?utf-8?B?MU1WR3l0V1JQMDhpT3hFZXFCT0M1MjFOeEJtNnVRaUY5dmdIb2VWSGI5N2hm?=
 =?utf-8?B?YmYyTHRBOHNaWXpZOUg0ODROTWM3RTRkNjJQajhWRWg0S085NlBjWUVHK1M5?=
 =?utf-8?B?SkphdER1Wk1ZaVU3R0VvQWhDUWN1MHdoVmx4Skx6N2h2SlZ6VHI2WWQ2R2Nr?=
 =?utf-8?B?ZUNyKzd3MHdKdG5aZDk3SGJPSnBndnBLSjJ3R1c2d1dyUDlxYjhVSitoZUVZ?=
 =?utf-8?B?anhyeDlhNTFHSWN5REp3dGhCU3ZDUHlpSE52a1ZZNFNHOWl4YTVvM2lEVkFX?=
 =?utf-8?Q?doVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnQwUVJNcHpJR0E1cWxrSTBTSXN0aGZ1TjVnT0Z3QStlZnEyWC90RHdncUJy?=
 =?utf-8?B?eWJrMUtqV2d5WC8xajlEbEJHUU0waXZaVnhiUDBkSU9nUWM0VHl1R2ZTNFl4?=
 =?utf-8?B?eWVBRnd2L2FXTi9GNUdmUFBoTjBiSFFqUUJJaDB0QmJidVkySi9TUWVia0RJ?=
 =?utf-8?B?YW92ajZNVUtUK3NEVFJjZmU2YlE0Vm9lUUU4NENOMWE4ZjdVRU9SdnZTWlhl?=
 =?utf-8?B?NkMrZlh5dm5OMlF4ckxKQmM3KzRONmhNTzlGTXUxd25XZjZpSm0rQUNFQkQ0?=
 =?utf-8?B?aEM4SnRCRlhETzg5VmRoa1MvamM5d2RDZ1B6enNyUjJRQmtLNjFmd3lHTHh0?=
 =?utf-8?B?a3pTeHVWQTNrT3k5UjVMNThLZkxZQS92Qms5U01CL1ZVQVNDdHdNSktCVFFm?=
 =?utf-8?B?cDdidFpwenYxMzdpNS9KbEpIUmtjRDVKQ211ZXFCLzJBRHdOZ1c1dnBjM3VE?=
 =?utf-8?B?N1FxNXpEekJ2RzJXakhBUXIrc2thRXU4eE5wRFNYc244MEUxaUlWcVNrU1Jt?=
 =?utf-8?B?TVU4SWFaVEJsRjRsU0ZyRWlaWHo3ZGdFWWNOME9wVld1VmVJODFrekpleU9I?=
 =?utf-8?B?MUVRTWlMbENWdVp2RThHRWFlUDVFOGpWa3VDZElCaWxUZFZjNkZKaHdIM0JM?=
 =?utf-8?B?SFJnNFFxWUFHQUVHTUJJaTY2QmRVVWc1MVlRZnE4NzlpOUJjaWpZcHUvcW5v?=
 =?utf-8?B?K1FZQ2ZyVUNvbG9hT2ZaL01JVExwVmpIV3JJeGtORlhqN2haTExiMy9IOFh3?=
 =?utf-8?B?OTZNSTNncjVxZHpLdUVMR05scUtSeng4MWZ4NTNyYWVOLzVlTklpY0hJZmlz?=
 =?utf-8?B?eExDWGwxVlpmd1g5NGtKRzREWFZ0eHVtbUMyRU0vcUpNR29OcWRoVnQ5ZVFG?=
 =?utf-8?B?TFVXU0RXMDFDRlo2dlpXMFk2YXpBdWRrZW85Z1A2Z005S29FcGt0bFpsU2px?=
 =?utf-8?B?Qm1rL1VKOE9LUHJ3VDNnMVI5bUJSV0RYYWxNUkl3ZmJTUnR4ZzZxdEFicVd6?=
 =?utf-8?B?MHNXWlpsRXVOelYvbCs0UkovMHd6bG1KVjEvRWdSaG1wZDBTZ2kxeG5HZ3hN?=
 =?utf-8?B?ZHdTcUNCTHZjWUh5V2xva20vWVZqeXRDZlBtNlhCWi9sUGJOK0lJTEZqZndt?=
 =?utf-8?B?ZkQ5bUlRdDBYd0JLZ3hlY25pU2tlK1BNSEhOdmN0WXFOd0cvY0lxOWxHNU9M?=
 =?utf-8?B?NVZmUHk0Qkoxajh2UWUwSWlrRG9BdGhiQi94aldBeWdsVENlSFljNFNLRVYw?=
 =?utf-8?B?YVNnLzRIMC9TbjdrTXU1TmU1Z0xlVWt3UlZaNmJMYzd5NlFabmJDNms5LzJD?=
 =?utf-8?B?WGx0ZmsrSDBmNlNaRmIydU5RZGtBK2lrUktKQldTajhPc0FtZDl0V083NVZw?=
 =?utf-8?B?SFFDcXE3QnJYcDRweE5PZTJoR0UvSkZmK2RIY2ZqSUJWR0lYWE1LSkppaHRE?=
 =?utf-8?B?R2ZQTlJTMHlVdEttaDh5b0h2Tm9vemZySFp2Skd4M2dmU2FnK1lWYXRCdUZL?=
 =?utf-8?B?UStwNk1ibzhIUU83eFd0SEU2blJoL1phMDNsTUl4L3hKc0lhZE1MZEo1OTh6?=
 =?utf-8?B?TGR4V2x1NzNmT2E3dzIvQnFHWEVJSml4KzN5cnI5TVZIQjlSZlM5bXN6M1pl?=
 =?utf-8?B?S3gxYy96cytnekFGcGVqQ25qRWJIdWRTeDVsckY2M2JZNVNuU1NiaWlwaHFB?=
 =?utf-8?B?cTQrYmw0WXFST0xHUFl4N1JXUExRbDBEQ2tlVFJsQTB2c1A5K0lDQ2lCdEUy?=
 =?utf-8?B?K2paTmNWTVRubVViZlhQQ1pzTEd1MTQwVW1TWUFDcGJ5bGY0ZjFlL2s1U1pK?=
 =?utf-8?B?YWRpY2lmTzdDZHBoL2trRFQ3YnpNVmpOWDhNOEIrWmgxSXBXVVVqWDl0V3lE?=
 =?utf-8?B?SHpXM25aY2tDc29EQ0pDWUQrRmVFbEhpanJwT2xiVGg2aUpYcXBGRWd3b2Fy?=
 =?utf-8?B?eEh1ZzB0bFJFenhldVpaOGFyNHU3Z1Rid3JkRitQRHlwWVVRYS9CZmh3RXlo?=
 =?utf-8?B?TWhxYzdkSGFLUE5mRzRsWno1Qk03U2k1ZTNSUXhXUCtNY09TdnN3NEZycVpw?=
 =?utf-8?B?dWM4bUdyNW4vUHhrWW1CeFRUUWRwZkxWTjRreitBNnZiSlBFWlR0RC9VNnJM?=
 =?utf-8?B?RVBVT1lzUVFtZDZzU253VmI2anJaK1hZTHZwRkRuZWNOeWVQeWRjaWdmUVNS?=
 =?utf-8?B?Y1ZvS1Q2MGJrUDVKYWo5dForV3FIWnc3NVhzanF1L1N6OXBHUXhzRkxzYnRq?=
 =?utf-8?B?bGdxWDVNNzAzdzRsRnFCSDFXZTdWY25hS3d3bkFrem4vbUxlaUg5SHVDMmcv?=
 =?utf-8?B?aXVYU2dsTEUzeEo1UHZaV0kvd3NFemRGYVBycGdNYXhzUFVOTEpidz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a09667-5264-4cf6-a741-08de5cd29a11
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:01:13.4075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnDHWrXanO1xY5Swp2Su/YqespWo8TdDS7OMU5AgnGJx/S5emvdoXQfBOA38/ZvmR2jVYJax00aCAFmkOpH42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Refactor PCIe PASID capability initialization by moving the common
> register init into a new helper, pcie_pasid_common_init().
> 
> Subsequent patch to synthesize a vPASID will make use of this
> helper.
> 
> No functional change intended.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/pci/pcie.c         | 19 ++++++++++++-------
>   include/hw/pci/pcie.h |  2 ++
>   2 files changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index aa9024e532..c481c16c0f 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1284,18 +1284,13 @@ void pcie_acs_reset(PCIDevice *dev)
>       }
>   }
>   
> -/* PASID */
> -void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
> -                     bool exec_perm, bool priv_mod)
> +void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
> +                            uint8_t pasid_width, bool exec_perm, bool priv_mod)
>   {
>       static const uint16_t control_reg_rw_mask = 0x07;
>       uint16_t capability_reg;
>   
>       assert(pasid_width <= PCI_EXT_CAP_PASID_MAX_WIDTH);
> -
> -    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
> -                        PCI_EXT_CAP_PASID_SIZEOF);
> -
>       capability_reg = ((uint16_t)pasid_width) << PCI_PASID_CAP_WIDTH_SHIFT;
>       capability_reg |= exec_perm ? PCI_PASID_CAP_EXEC : 0;
>       capability_reg |= priv_mod  ? PCI_PASID_CAP_PRIV : 0;
> @@ -1307,6 +1302,16 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
>       pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask);
>   
>       dev->exp.pasid_cap = offset;
> +
> +}
> +
> +/* PASID */
> +void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
> +                     bool exec_perm, bool priv_mod)
> +{
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
> +                        PCI_EXT_CAP_PASID_SIZEOF);
> +    pcie_pasid_common_init(dev, offset, pasid_width, exec_perm, priv_mod);
>   }
>   
>   /* PRI */
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index d68bfa6257..fc02aeb169 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -155,6 +155,8 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>   void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp);
>   
> +void pcie_pasid_common_init(PCIDevice *dev, uint16_t offset,
> +                            uint8_t pasid_width, bool exec_perm, bool priv_mod);
>   void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
>                        bool exec_perm, bool priv_mod);
>   void pcie_pri_init(PCIDevice *dev, uint16_t offset, uint32_t outstanding_pr_cap,

