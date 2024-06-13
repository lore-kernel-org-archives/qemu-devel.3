Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257EBC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoF2-0003Hb-Dl; Thu, 13 Jun 2024 13:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHoF0-0003E5-3d
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:28:02 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sHoEt-0006s0-Rj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718299677; x=1749835677;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XYZin/E9P6pwzeCJnYvwOWDcp2ll0QxcW5oWIL1ojJc=;
 b=jsFLi1j5kd2X8J99A4/DFCc8dSnmXjs3Ax2th5ZKvrom29YDq/xmeck4
 LlhdY+8mUVChG9UE3/UQheIIFYCRX5cSeE7D1Ivf8iMs6km8Xr4YltZcE
 j4iGItz5K0e+k7EDaOES7poEvwL+hMqt8uun6uc36QLRrql/n2iqvOIzp
 KciA3CF92w93/F/qJ8Z8AIy8UlSh9cWHUbakv3eC+eKWCbW9OajxAEwqx
 h4NFzaU7N6jgW5WNW4ID1whayQEHq1h6kEeJYwkM3nXLgRfTU7r8n2Z5R
 gmRTY5Nqd+Y3XiocmeUKm9QD0fb9EYXsIrcBmdWm+rRe0tYkdupPOH0g1 A==;
X-CSE-ConnectionGUID: u88ukPSJSoOwu6cfu5zu0Q==
X-CSE-MsgGUID: V4WZ+HdfQiG55vKYfzl7Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15274780"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; d="scan'208";a="15274780"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 10:27:54 -0700
X-CSE-ConnectionGUID: 6hA1OnfxTwqcRzu5ZcxB+g==
X-CSE-MsgGUID: KMuK7/MpQHGGjE+UiZAjxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; d="scan'208";a="71017222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Jun 2024 10:27:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 10:27:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 10:27:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 10:27:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 10:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAj6RZIvQVp5XxDflRKRfRlbZ7lTV2isKXjnKF5kfPe4+BAI50Di0aMxbuIKV4/1iA+ocGUHkUC72XcpZS3N2cql9pRj8DaKNmhXnv+ld/cHGucZG+i16u7u2658D7Z+m58Twh72P2pEnLOoxxeR131uANam8Lqy/HEwmA1R2T12nVno0WvT3NUqeBhEIo/vS/BCJ81q0lUxfw0iD2hFVB4B0wlpG2eYrdmJgOiXJBO/q3R35OpBSAq/XCv9YAcZKgC8ry3dwkMUslwk3qqcH11eNIT8BUDK1mKAl01KY0zSIq4H+Vu6EvEJfV5xiITnzVK+i/Hgn78OF4o/RqbZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzm1+az/aXoAJTiwM1Vd02B1cPItvtzSWt2rP3SSr/g=;
 b=kYweyF9PBk30YMLHSmxnjwXHb3+FN7X25sy4ocrUHUNAbnbvmQxXcvANtuJQQ0IbYKprf6lXU3b98L1VzxRRpJlFrK4w6+pQ26F98hQzPKpt2J4GUrR0VYCZRyYOAf7XO+mctm+Ce2VoIhgX6kZPrCdClHgbNqTa6SQHFmzohDZ0En4jxjsaCEC6wNx0Xc8lVZtsVs5O+za/wfX1H9sj2jEouQ/54+qxUVjSx0VnRv8khSAZ8ofzPIqYbwuNlMYVcjeRxY4iDOj3KVq0r9HJbJuvBiiz4XyVr+sFFGIMj/zFtZAyGCjAlkBMPtGw1+D0YoAiAQtcuyIrq6Q0WOl79g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 17:27:48 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 17:27:48 +0000
Message-ID: <200c1b14-0439-484e-8681-d525a73929bb@intel.com>
Date: Thu, 13 Jun 2024 10:27:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk: Wait until the current guest frame is rendered
 before switching to RUN_STATE_SAVE_VM
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>
References: <20240529224252.80395-1-dongwon.kim@intel.com>
 <CAJ+F1CJFWRtyXvpCJuSVPssJcBx8ecP1HCkWCJ=HBWxXovj+Dw@mail.gmail.com>
 <ed6a1963-b079-4fdc-a6ca-6ba98b95c0de@intel.com>
 <CAJ+F1CJW3b9D4nU3x4XSjpG=KrBpJMLWqdR3tpdipObODZRvgQ@mail.gmail.com>
 <PH8PR11MB68796CDE59AA75FD1D6089A1FAC02@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAJ+F1C+L=5cSPhEXrAczfN27sXEH_2Xwohk7Bt2r4KmhteDguQ@mail.gmail.com>
 <d1534c51-bb11-4439-afc9-0a95f2dc4cf5@intel.com>
 <CAJ+F1C+kYEHrCGKcwxyGiaiHhRyN7+uKvEj4yWBDxEK2nKUOdA@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1C+kYEHrCGKcwxyGiaiHhRyN7+uKvEj4yWBDxEK2nKUOdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d092df-8e22-4002-3c3b-08dc8bce24e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0k0c0FneWVsZ0dORVBYLzlmajMwa1NTV2dKWkNjVkRaMnVTbGJpangvMENB?=
 =?utf-8?B?eXduSzNCclNFbkpVMzlybWhDNzFzT1k1ZEZRK3VJYVFFRWd3dHZSQlh1eGZL?=
 =?utf-8?B?aWxDQVpGYzlTUi9lalBhMVYwa1ViSnVCWHRBSFp6eFFIT050NlNjaTgwRy96?=
 =?utf-8?B?VzFPKzlVNlJNZlZXVjM5eGY1ZHFOUFZHOGlIemZvdGhnZE5MRXIvdE1DcU1h?=
 =?utf-8?B?bitRY2JNeXhaMTBCL3QrQnV4a2hySnBGVHBCZFdPVHduMmt2UkEzMjZhWmQ4?=
 =?utf-8?B?clF1N1Q4WFlzeisydHhFUzNEaFpNdXh4UXVlZVlrM3N1aUJZaWJ2dzlSaVBL?=
 =?utf-8?B?VC9nTGxubFNzeVh2aGZDZFoxWitmZGh4a0tjRTNaMExqT1RHalNzdHdhWmdt?=
 =?utf-8?B?UnhJeHRqQWpweENUT09IaEV0Wng0dUtDaUFJZmN1bktNTHB2eUxLY2RBQkJS?=
 =?utf-8?B?TjE1WjRXenJRbWh0V3U1WVVBZ00reWN4SytJOGd4enJXdTFwdjlhRFB1SWhO?=
 =?utf-8?B?YnVpZjVtcENMQW9tRi81N1B4cDZqWkpKYzNzdU9xV1YrMEIwMHNvV1hEbzZE?=
 =?utf-8?B?WWo2a2xzazhkYktDNmszN1RjaXRYN3ViWUFibHJIU3I2bUxSNVRGVWZnZTY1?=
 =?utf-8?B?VDNpSkNBb3ZzNVk2K3BMWXZRRVVwY1lVbVcwejZQNzVlc2RhTWtpQ1BmcVdH?=
 =?utf-8?B?dzQzTHUwZTErdG0zZzVydUZERUs2NjRyZUxIL0ZFWGpzam10WDU4RGtZQ3cv?=
 =?utf-8?B?ekxCN1pRNEJxVU1iaXVQcGZ5SFVCSFZmYUMyd1N3RWlhaFZDOUpkVWUrNndL?=
 =?utf-8?B?b0R4SGl0MjJ3TE53ZE5mU0dSRHVHZGZTdmNMQkxYNnVmNzhmR08wTjBEMSs4?=
 =?utf-8?B?RU80czRVdDFObnhMWk5wZFZEOUdSOEt4TnJLbmpmdXBsWi9uTGMvUUdubE1J?=
 =?utf-8?B?elVLZ3YvVFFocndubW5qbUdBNnlxU1M5aiszZlhmVFE4dXFzclVnSmwwejBz?=
 =?utf-8?B?NGtJUHoxRFBGM3NENVd0MkxDR3lCMW5BVVVYdVVvdlZpNEszVGd3dnNrVVZi?=
 =?utf-8?B?djNXd1ZpTm1EcERzUWhGZEVYRTFKUkFtaExBaTExWTdBOHpRcGhGamtJR2JO?=
 =?utf-8?B?RnB5ajVMUDV5MkRDOTNjRXZONG1EWHVBTkFKY0ZnWG90MXJuZ2J3bXJibEdQ?=
 =?utf-8?B?MzYvUkxhK0dwcjR0S3NDUHcyZ1dNNmxvWkVSTDF2Q1hDQVh1Z1hPWWl2c0JC?=
 =?utf-8?B?TGlaeWx3VXVGcmkvblFaNk9iSC9DT1NmUzNRQlNkMnVlcU0rOTRELzI2UWND?=
 =?utf-8?B?b3ljcWpMVytYMndkTXVycWtMZ0NIb1g5OGdBU0xLWnRiN01mQ2JuSFZRZndU?=
 =?utf-8?B?NDNOWGZ4YWlYcjZIYTF5WFZMTXRLY3I2d2VnTnBOSytjbHlNemlvVThlLzFy?=
 =?utf-8?B?TU1Kb0dMK20yWjh0bDFFREczdkRjcEJMbzhsRks4dWVOcWk4VUFZL1ZjMDlQ?=
 =?utf-8?B?NEZaTTFFNWdoZW1RNDdwUFdMaG5Tdk5QVHNvdmdLbWxjSHNWNjJHVFB1K2cy?=
 =?utf-8?B?Z2hqaERmdkFTQllrNTJsMHYzNzIzR0lJanhadC9zckF6OU5lRHR3WGE3NHdY?=
 =?utf-8?B?VWZ4a01JcHQxWDdLN0kwbTkwTzlVd2Z5d0RrVTg1VktjcVIzenYvWVRla28r?=
 =?utf-8?B?NVNQMFR3bW1iN3lxSG9ONngwM2xXNXhoelNBWjVSaGpGd3FaU3ZlNTRRUm9B?=
 =?utf-8?Q?e0OJ7UH/89GsNtD0VfCOGcjyv2MBm//jnjasLQ3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(376009)(1800799019)(366011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBNREhVR2U5enh0cHNMakhmd2loQjkvVW9yNFlMZXZCeDNVYWFjdzBwTi9N?=
 =?utf-8?B?YkdDZ01JY1NpeU96YXZHMjFHbnJ6ZkpkaEw4UXZBaGtHOVN4eTVDd3RxSG5w?=
 =?utf-8?B?RnlUMTNRRS9VcytqQlY3MFdUcDlyQXZINDNYK0NTamJMdTZvKzhWZ0lSTkd3?=
 =?utf-8?B?dW5mU2c4ZDlRWExLd3lidGN2VncrdW5DT1dZQW85RThod01oQnBuZktJMkFr?=
 =?utf-8?B?TjN1S0x5QkNrSStwT0xUTnllMzN5TmN4bjZJQXd5L3B5azAxVHJRTlVGdHJ0?=
 =?utf-8?B?VTRUSW9vand5S2p5NmcvSEFkSEVwWktWSENzQ0N2bWN6ZThYb3V4WDFFejE4?=
 =?utf-8?B?WE9SbVFxNllMalFVNVVLQWZyWHFBcm1CQnF4MFdnSjdGMk4yTHBrOFQyZmUr?=
 =?utf-8?B?SEVOZU5UanlaNGpWU2FibEFrNHNxT2RHOFViMjV3dndTZmtxVVk5RDl2QytN?=
 =?utf-8?B?T0RacmNJRks2V25YVWR4K0xnT0kvQ0lJRUFiZ3NRQnlqOWFPWEpVMDAwdktC?=
 =?utf-8?B?RlpPcXlpeHdNS2lkeVltcXlnZnZKd1BRZnk5bkF4U3BWbzNqMk5xQkZ6VndM?=
 =?utf-8?B?ejlvMjFDd3pndkRCaVo1anVJVi9wb043SHVOcXRDcTdxcEhIYWNnR2ZTWEE5?=
 =?utf-8?B?S3ozbnoveDlxTEdyVEE1bFVyUXN0Um8yYmhFTFRtR1U2eStUY0xhVFpPUi9r?=
 =?utf-8?B?bmFuNWp4dGxiQWVITEFYRFAwaUJyRHIxbStLSmlDb1QrZEVRTnlSYVBrQ2Yx?=
 =?utf-8?B?eGdBQXhEWVBIRUQ1TWVidVVoQzNRbklFcVpNMlVBejJ1N0J5OXlyclI1cTM4?=
 =?utf-8?B?endXTi8zL05yWndSQ2pmNFNYR3JOQ2RocjVGbElrVy9jc3F4N3VEQUVCK2JN?=
 =?utf-8?B?UTl0TjV3T0UwNzJZaC9sM1Z6WjZHZU9qSm9CQ1N4VHJoQThrbjREMm1XSFFv?=
 =?utf-8?B?Nm5iS3MwdjRZUlp1bE9TakJueExkd1pzZ1IyaU9ObEdkblJLRkhqeWNiNzJD?=
 =?utf-8?B?OHVCUVRTMHBOdmFOSU96ZTZQQUhYbS9HMDBPc1Jud2N3dWpBeUE1L0RxZk1N?=
 =?utf-8?B?bGttR2hoTlZUNnpOcWR2VTc5UWNyRXlRTG1kV2xzSjNPNHFPUHlSZFJydjYx?=
 =?utf-8?B?N1R1ak96dEZxbmt2ems0M0FuaXVzQ293VHordkNWb0hmcGxyZkNNZitHVVZr?=
 =?utf-8?B?V1JSSFZWRlNQbktMcG56b3BkQjJydXN1K1JJazNBYnkrM3ZPc0ljaFJOK1h3?=
 =?utf-8?B?MitqTWU3UVhNUEl0ak9Eb2lVQ2hrWXpUWFJQcEpJSEJMMkwzVXQvQWE2UzIr?=
 =?utf-8?B?cWlPV3Vpa3Q2cWRNblpUUkdTMXdHTlZ5YTgxdGkvWk1TS3k1eTZESFN2bkZT?=
 =?utf-8?B?Y3JPTExsUkIzZXpjRndVRDU2ckVaY0dLMnZ6bWdCdXhvSDlrcWhyUW53WXpL?=
 =?utf-8?B?T3IvUW5oTHpEa3ZpWGZZdkQ2KzAyQ2Z5djFrU1A2OUU0UHlqNW5OTTdkNDZB?=
 =?utf-8?B?OXQwRmt6cEoxVmtLVGZPY1NtQlluK2lHQjRGc1NScW8ySHF1WUNQZlZldkZ1?=
 =?utf-8?B?U0RKNmF4bW9lV2s0TVYyeHZFa1R1QzhheSs0ZndxVU0vZlE5aXZPQkpLN2NK?=
 =?utf-8?B?V0FyRGg1eVdCcWQ0RUtoc2ZmL0NaQjd1NWRleUZ4a3FYaFJvdkN1N2x5czBN?=
 =?utf-8?B?SEV4M2lheEV3ZDhmcjhXY2Zab2tHeDhwUFNicE5iMVpiRDF5Sko3K1RNVC9u?=
 =?utf-8?B?TlB5aXpHNmZwbE5BMko2VUI2WWsrbG9EUldLL2x3Z1haSitWNVMrQ3hxU0gw?=
 =?utf-8?B?cFBQR1ExZCtBNlkvWGtmZEt3SDRiOUowQnpLVFk3N3ZtcWVIRUltSDRKbEhT?=
 =?utf-8?B?ZzFQZG1iVW12NTZLQS9yMXNjVkR5cW9oNE5yWXpXd05MZSt0QWZ2N2hGT0dY?=
 =?utf-8?B?dk9RRUZBVk05dlZBTjBNSWNGQm5oSGQzOXhoSk5OQmh4K1lYT3RUam5pUnR6?=
 =?utf-8?B?TDhYc3M2Nm5rc3hwZk9iMkM3aHRYZFhEMVVrV0cvbWtyU21RNmFjT0FTL3Q3?=
 =?utf-8?B?UjQrTDAwWjg2VDF2cFl0akF4MllUcXhlWkluWU51UjBGMHhmZ2RvdkFXOFpQ?=
 =?utf-8?Q?SfS3pqEIi7W1habLqqYKfml7m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d092df-8e22-4002-3c3b-08dc8bce24e2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:27:47.9286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vXn4cERea5icfY+/jP6H0WRCpqL2TCmguXPx2Fq2Ieu0L7zZs5dc7PC78MxJgwCVtZR5nGEdmTf7l49ti+2kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Hi Marc-André,

On 6/13/2024 6:16 AM, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jun 12, 2024 at 10:50 PM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>     On 6/11/2024 10:44 PM, Marc-André Lureau wrote:
>      > Hi
>      >
>      > On Wed, Jun 12, 2024 at 5:29 AM Kim, Dongwon
>     <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
>      >
>      >     Hi,
>      >
>      >     From: Marc-André Lureau <marcandre.lureau@gmail.com
>     <mailto:marcandre.lureau@gmail.com>
>      >     <mailto:marcandre.lureau@gmail.com
>     <mailto:marcandre.lureau@gmail.com>>>
>      >     Sent: Wednesday, June 5, 2024 12:56 AM
>      >     To: Kim, Dongwon <dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>
>      >     Cc: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
>     <mailto:qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>>; Peter Xu
>      >     <peterx@redhat.com <mailto:peterx@redhat.com>
>     <mailto:peterx@redhat.com <mailto:peterx@redhat.com>>>
>      >     Subject: Re: [PATCH] ui/gtk: Wait until the current guest
>     frame is
>      >     rendered before switching to RUN_STATE_SAVE_VM
>      >
>      >     Hi
>      >
>      >     On Tue, Jun 4, 2024 at 9:49 PM Kim, Dongwon
>      >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>> wrote:
>      >     On 6/4/2024 4:12 AM, Marc-André Lureau wrote:
>      >      > Hi
>      >      >
>      >      > On Thu, May 30, 2024 at 2:44 AM
>     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>      >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
>      >      > <mailto:mailto <mailto:mailto> <mailto:mailto
>     <mailto:mailto>>:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
>      >     <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>> wrote:
>      >      >
>      >      >     From: Dongwon <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>
>      >     <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>
>     <mailto:mailto <mailto:mailto>
>      >     <mailto:mailto <mailto:mailto>>:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com> <mailto:dongwon.kim@intel.com
>     <mailto:dongwon.kim@intel.com>>>>
>      >      >
>      >      >     Make sure rendering of the current frame is finished
>     before
>      >     switching
>      >      >     the run state to RUN_STATE_SAVE_VM by waiting for egl-sync
>      >     object to be
>      >      >     signaled.
>      >      >
>      >      >
>      >      > Can you expand on what this solves?
>      >
>      >     In current scheme, guest waits for the fence to be signaled
>     for each
>      >     frame it submits before moving to the next frame. If the
>     guest’s state
>      >     is saved while it is still waiting for the fence, The guest will
>      >     continue to  wait for the fence that was signaled while ago
>     when it is
>      >     restored to the point. One way to prevent it is to get it
>     finish the
>      >     current frame before changing the state.
>      >
>      >     After the UI sets a fence, hw_ops->gl_block(true) gets
>     called, which
>      >     will block virtio-gpu/virgl from processing commands (until the
>      >     fence is signaled and gl_block/false called again).
>      >
>      >     But this "blocking" state is not saved. So how does this affect
>      >     save/restore? Please give more details, thanks
>      >
>      >     Yeah sure. "Blocking" state is not saved but guest's state is
>     saved
>      >     while it was still waiting for the response for its last
>      >     resource-flush virtio msg. This virtio response, by the way
>     is set
>      >     to be sent to the guest when the pipeline is unblocked (and
>     when the
>      >     fence is signaled.). Once the guest's state is saved, current
>      >     instance of guest will be continued and receives the response as
>      >     usual. The problem is happening when we restore the saved guest's
>      >     state again because what guest does will be waiting for the
>     response
>      >     that was sent a while ago to the original instance.
>      >
>      >
>      > Where is the pending response saved? Can you detail how you test
>     this?
>      >
> 
>     There is no pending response for the guest's restored point, which is a
>     problem. The response is sent out after saving is done.
> 
>     Normal cycle :
> 
>     resource-flush (scanout flush) -> gl block -> render -> gl unblock
>     (after fence is signaled) -> pending response sent out to the guest ->
>     guest (virtio-gpu drv) processes the next scanout frame -> (next cycle)
>     resource-flush -> gl block ......
> 
>     When vm state is saved in the middle :
> 
>     resource-flush (scanout-flush) -> gl block -> saving vm-state -> render
>     -> gl unblock -> pending response (resp #1) sent out to the guest ->
>     guest (virtio-gpu drv) processes the next scanout frame -> (next cycle)
>     resource-flush -> gl block ......
> 
>     Now, we restore the vm-state we saved
> 
>     vm-state is restored -> guest (virtio-gpu drv) can't move on as this
>     state is still waiting for the response (resp #1)
> 
> 
> Ok, so actually it's more of a device state issue than a UI/GTK. We end 
> up not saving a state that reflects the guest state. My understanding is 
> that the guest is waiting for a fence reply, and we don't save that. 
> Imho, a better fix would be to either save the fenceq (but then, what 
> else is missing to complete the operation on resume?), or have a wait to 
> delay the migration until the fences are flushed.

The second method you are proposing here - 'have a wait'. I understand 
you mean delaying the start point of migration but don't you think the 
current patch is basically doing the similar thing? Assuming egl wait 
sync is what we need to use for a wait, do you have any suggestion where 
that should be called other than 'gd_change_runstate'?

> 
> 
>     So we need to make sure vm-state is saved after the cycle is completed.
> 
>     This situation would be only happening if you use blob=true with
>     virtio-gpu drv as KMS on the linux guest. Do you have any similar setup?
> 
> 
> No, further details to reproduce would help. Even better would be having 
> some automated test.

I will think about this. We use GPU shared via SRIOV as a GPU deviceand 
virtio-gpu as a display device on the guest. I think I need to find and 
test more general cases.

> 
> 
> -- 
> Marc-André Lureau


