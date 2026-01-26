Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B0CF65E5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLHk-0002kh-Le; Mon, 26 Jan 2026 07:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLHb-0002Zf-B8; Mon, 26 Jan 2026 07:01:27 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLHZ-0003mQ-89; Mon, 26 Jan 2026 07:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428885; x=1800964885;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QXE5dot+STZhBATp7huZn09s++1JLVuf0d34O4R06q8=;
 b=YbUzw4/X7qFfufBlues4IJA4GtNfyTTWThCWLme9t8flQ2L6RcYpsf40
 GkbNq/tc+bzSmFluLaTefpS03Qs24easRTsLFiaQLS1HMHGvzKGqjHP4L
 DHixbMoFNP8UHJ29uP3p4Jnbf45L0aKsWqQ+QJpLGykjFr8qzQLmPaO3G
 05s7jaHEmucp5qB/5mskOJKrA3GuPhGk6WeZxBGj21h0vagcbBxYqqK+y
 IlFHT/6o9w4GN1T9uHpMlg/1tHFKjucj5/RgbceJBXpahKMo5h6wHcU3+
 f4rpiuG+vMrRAzERLyh7ipBk0nIkbPeIkLgBtAAnY/6v+/0o4AmNh8Hf7 g==;
X-CSE-ConnectionGUID: zqxlA8h+RiGkZa/SfWQeEg==
X-CSE-MsgGUID: l7GOlgXsSVKUzeMCVfsCXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81237969"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="81237969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:01:23 -0800
X-CSE-ConnectionGUID: ckKfBmjIREOa9tOepgCeqQ==
X-CSE-MsgGUID: 9/SpsQYfToeu/+1EnnhUtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212649081"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:01:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:01:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 04:01:22 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:00:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=av+VQMn62HwJJmO6LQbYGWwwhaDuVPRiq/wusKb76dXZ04GP+rFypKmyUaS0swYXvcJPEGGMGRCTx8az1oF9cUNkkq5IlM7i/unBRBHL9+ELfNJrmag2VbsDR6YgYQseRwcUvh8LWVXgqxPMEjJqE6PdQNQQ/fG6vLf8Usk8930dW8CwaAXT7wI8wjqfrTGbOrJGObxLct2dvTZKYHQgY5iI2idq5SB/n1EHAAMcIp+K2QiWK+/mIY7T49WIaUFRhMmT/S+NIWaz3r+EQ/qfaP68nIjAwAvInY/u7VMpyKxdsZilIXxZXGC7s+DX72d90hTVGrozEJ8TtYu/aBSN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjlUiYxUjAPL1AwPS2lQhOXWnscxN5IChdV77kePgwU=;
 b=x74wfvAeqgSw0Dy2jX8BQIPAyP9g0VBNFy6CReB7SIrkpFrs860X15Gt/KY8nA4zXS2dROdrn3WToNICeBUHDu9fJwHzdtMFK+caufl/25DeUb7SPi3TcwsZh9C+TrujoMirSdLNsqiVnZwCPn1VDZABDY9kMqvvvrJXKEmIIr2ntySvffmZt5DFq+Gnpp53aZkJBc6V+49N6OnlIfGjOHRxYUhrR9Pad9joZxEtE0jKqVj8Bm/NvyMBptJYaRsH/5JM8CfLuaGnXF/y2fQ3aAKVe/1reBJwlzZkhCvnElTE2oCZyz8OaiROTT7xuDJ60mgUaq9gScMLoNTf/cA/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 12:00:50 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 12:00:50 +0000
Message-ID: <a66aef84-ce92-4193-89bf-33651875452a@intel.com>
Date: Mon, 26 Jan 2026 20:07:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 34/37] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
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
 <20260126104342.253965-35-skolothumtho@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-35-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e397de-8300-49f3-ed4e-08de5cd28c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWtsdVN5VjlQK0JNbGE5L2wxVW1NWGdIa0E0bXFIbEdrNlJ2K1kwSGdwclI5?=
 =?utf-8?B?MFdCeHo3UzFiN1NsUmFJK2V2NFgydVlzNFBjanJaZlcyUkRzbUtmVGZWMVhp?=
 =?utf-8?B?VFVyalhTY3greVBrMkdlK0w3MkVSQlVIbVhjTlFNbGtSVlMxTytONzhoaFpr?=
 =?utf-8?B?K2xINWRUellud2o1b1BLSFg1RDJxTVIwQzQwazVVZ0ZtOVU1L3Z1cTlrK2Rn?=
 =?utf-8?B?RG1ycU5PSjNTLzF4TENrRCt4N2p1UXEzWDRZanhHbVFoVmpubFh0akROTnJL?=
 =?utf-8?B?dnhGNUM0UHNreW1QL281UGp5ZXVyQjgxcHRIU0x5YUVtZ2hRQ3Q4YnFkV0N5?=
 =?utf-8?B?U1BEUDdDbFhzMTJhakN3clNsU210NmZlVVBQTE1jUVpSZUxwUHV3VE1OM2dG?=
 =?utf-8?B?TDVtNEFYd2d3dlVyK09lK0ZkUC85d2tsektOQmNSOWlYSVpXakxxbnB2WGJZ?=
 =?utf-8?B?QkxZRHdWWHFiWmIzRTZEd1BXbkFUbExDWlBCSWFCMGE1K1hJd3BGeTdBOWNJ?=
 =?utf-8?B?TEdVTktaNGc0MkNvRzAvU3pIMHo5bUlWbFZHRDZaS05HMkNWa1JEWUFmMlQr?=
 =?utf-8?B?R0VlYWMxaVRTK0FidS9IZmZpUDlHbzZ1RjluWWFPM2FobUttblkyQnhpOFBh?=
 =?utf-8?B?VmpxSXhqa1dIQmRTSTZUd2N6L1VrNzdBbXBqQ2VvYS8zS0lnLzVycks5WTd1?=
 =?utf-8?B?N2FFcGhScG5ML0Vha1BMOUMya3JPM0hZVUlIS3Q1U0VhcmRQTTZrTGN6UkNm?=
 =?utf-8?B?OFEvNHBtUVQ3R1IwcWRzR2t5RXQ4M28yc0EvWndnQ1o1N1ZLS1hnMWM0VFhv?=
 =?utf-8?B?dlpuNW10MTZUbmlFTHo3UlF4aGk4RFFuNDVBeStJVkRpMG1GZVYzTklKNGVs?=
 =?utf-8?B?aGU1TG5Ha3g1ekZtQjJncWVRdk9vL0ZmN1JiL1VrVy9mS0libVh3UCtWQXRY?=
 =?utf-8?B?QVhUSER2U2Vnbm1oTXNMMnE1cVl5NmtFN3Q1M2d5amhUN1EwRitjbm1yOU1z?=
 =?utf-8?B?cUNQOExXcWNDQk1oVUJvYTFMamppRVhJdHRqRXZ3M2kwK0ZHTHV1ajdDWVRK?=
 =?utf-8?B?dXczYnd1VkJQNEdwWjRRdjBTM3RoUk9walBhNzZkSmdqU2h6Ujk0ZldTNFdt?=
 =?utf-8?B?bVA2b1diU3hwL2hqdlE5MFFhVUdUWE12NElqQzU5ekZJSkpIZzR4MGlvb09X?=
 =?utf-8?B?L0FudGlJNGlPVVEydk8xQXdYMys1V3A0SkU3WmI1TkFScG1iam1FN2RxQ1VI?=
 =?utf-8?B?NVdPNnVXOEowcnFBNEVxN29uSnRtUDBWTHFiQWxPRWV4dHFmbkhKVHkxM2FT?=
 =?utf-8?B?azBSVmFPWUFsZ0MybWhQRzR0WWNsc09IY2lmSnVOV0E4dXJxNXdoL2R0VGVu?=
 =?utf-8?B?ME01RVJINjVUbDZiOUx4RGxsL2hwMG54RVNoWEwrV1JiM3huU2YyVkk4MnBs?=
 =?utf-8?B?MVlZakNJWDVUcTUxVXNSQnVBWEpwVCsvclFYR1V2UzI2Wms4bElvdkIrVFlJ?=
 =?utf-8?B?T1NwYkpkV29GOHpYNWpKRTBqNEkveUdQejV3MXZlTVdkWDdodXdsa00yQ2l0?=
 =?utf-8?B?NU1vVGFlQnV1bERMM0tFVGlRTHBBWWpFeW0vZDNDdm5wbTVBY3FYUlh5TjZX?=
 =?utf-8?B?cWVjbmR6M1FUR3BPY3VaT2VNeGUyTS9SUDhrS2pCQ2lVQmhMb1hDZGpRcUF2?=
 =?utf-8?B?YURHcS9FQmIyMzBuY2xNSTBqV1RKRXBadGdxcTRJcEYyTW5VbDlRaGxlYzVX?=
 =?utf-8?B?UStrZXd5WVVBWlllU1I5cGprNit2cGtPZytjaGZsTFF0VmhZU1ZvZTdCTUZZ?=
 =?utf-8?B?aDl1Q3JyQ1RTRFJLUmhmSTVTMkEvTnNFWGtZM0Y4c05hY1NDbWVZckI4bG9T?=
 =?utf-8?B?NlREclRnT0pmUEtYaTF1aTN2OFZkOWRNcVQ1TmgvejRDb0ExcmRlTVVCZVB4?=
 =?utf-8?B?R3Jha1NrTjlFbmZSRVVRL21ySTliUmVaSzRkSnNsSStSbDE2TVN4S3hkbUNN?=
 =?utf-8?B?SUxuYUIzK0l4SFJsaXc3cFhvVmdJRDZZaFhSWGFLVzBTclhOS3kzejVtMjds?=
 =?utf-8?B?WFcrTE1ZYzYyckdScjNqbFFuTXZsMjdDeXFteGFOUmpyQk1GVnBkT1NTZHFD?=
 =?utf-8?Q?H7yk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFE1dzBKWDV0RGQ5clRMSmtGMktlWjJWV3BBbmNtWm9qanQvVnFxL0dwdmNC?=
 =?utf-8?B?bURVZ3BKZlU5MVBnWHo4STBQbVZXOE5mS2g2NjFQQm42R3RQTXI2Y0xLY3Ax?=
 =?utf-8?B?eUNpTlBMNXpzSnd4V3FwRTNWazZQTFRvT0d2MW9nWGYveGh5NnNGd1ErYXhU?=
 =?utf-8?B?bDUvMW01K3RwQldNWUNuWHg2N3BhRUNWOTlyTXBWUEs0d2NLdUN4ZWN6U2Vh?=
 =?utf-8?B?RitWSk5zRmlFRlprTGgrT0MramVMZ3k3VXRPNVBHSDFvaTRWcnVJN0QzQm1X?=
 =?utf-8?B?OExjREhFVTlpZ3FXSDhySDZjT1dqdVB1VlNyUGdCZUhnOURnVW9iOUZrTk55?=
 =?utf-8?B?eXA0Z3l5bS9Va3QyZ1BUUEpTWmUwODZsVW9ZMEdRR290TTZ6RlNoYm5EcTYw?=
 =?utf-8?B?MVc4SCtOY3lRNFJRQUJ4SFN2Q3gzYzZiR01vbE5oamo2TE1zZm9vckp5ZFND?=
 =?utf-8?B?dmhBb2M2RkFWNXVHbVNReDZCZzhveGI4VUZrSHlKVUpKSThPaGJZdGZuMnJq?=
 =?utf-8?B?WjJjajdzSHMrR0w2NnlTN1RIS0ttRTRPazZCZUNwYkRqWG9wNDEyVy9YdW5a?=
 =?utf-8?B?K0ZyQjFDaDlzTDE5VTZqeDU4VTBrLzRFQ0J2ZTZKSGQxZXdERXhIR2VLVUNY?=
 =?utf-8?B?aE4zd3ZucDdaL0hOdUxuQmVYM3M0V21aZng5N1oxSTNvRVVlT3Z5UE5QaTJl?=
 =?utf-8?B?QU9XVVFJNVhscEtlZ094VjlJa0hjT0xnSktPdUI0QUg0UDNYKzFqc1R1WStv?=
 =?utf-8?B?TnAzVlVGVk5PSmN5WXJqVWNzZFR3ak0vQXhYd1NQODAweFVpSUFXNC96MlBG?=
 =?utf-8?B?L2tkVVZUbVVldmdkMGZZdFVXRitDR0l1MTI3a3JzSnZYSG41SlhZNFozaDkv?=
 =?utf-8?B?NHpSM2V1QktBQ3lmMlVGWU4rK3U2MzJRZHFJK01tZVZEZWJjcFVMWGFUamtK?=
 =?utf-8?B?OXNIUDdwbitpdVlRL04xRHphYmFoemdFNWdSQ0JVcXpVT1lhSVJUbnh3aFlj?=
 =?utf-8?B?eGpDYnRDTFNNT25ocFJIMXdSVVIxZlhVUE9MUzAwQ0ZSZ3lRaHpYa09QUXY0?=
 =?utf-8?B?QkFQZEhaWkVSL2tmYjBpZHkvRlRGSzhva0Nxd0RocHQ2RzA1K3VUREtOYlhy?=
 =?utf-8?B?VlJTdWRBTVkxbU5wOWhLWmJIcEpTWkk0bkc5ckp1Wk9WQTBmWUlKSVNXeGlu?=
 =?utf-8?B?TFl3ZWJobkIydG9iMzdaT2xEQTUrek4xNVJER2J2cUNUSzhkOFA2VE0zUjBy?=
 =?utf-8?B?aDVUelVlZGpIWE1aSis3V05qUm5IUEg5U0c3dDhYZFNqVXd6SHpCSEUrTnVr?=
 =?utf-8?B?SUh6OEgzUW51WHJlWVVncGhGMWExcTVvSC8rTHhDQzFNRVBQaFFmTW5DMis5?=
 =?utf-8?B?S3JsREJKWkJGNXM3YndFaVMzOEt3SDc5TmFZY3BwbHpaRDZQUVRMQ3REYTRt?=
 =?utf-8?B?YjFBcjd3eFAweEhtS0xDOGk0RE1iTVRENFdqTTRxT25ZMGJ2V1dMd2c1SFF1?=
 =?utf-8?B?YUF6ZG1MaW9xdkwvMi83WDNITXVZczF6MzN2Tm04MmR0VFdrMUJVSlFXeHZv?=
 =?utf-8?B?cmFSaXRJd1hBZTI0eXpyZU5wSmhCdm8xSXg5ZkJoSDlnWDVySW9RWjdIRFVI?=
 =?utf-8?B?bTZsQm9mVlp2WjdiQ1VZV3JOYWNtS2w3YUx4MUJnbFEwZjVEKzdBWDA3YWcr?=
 =?utf-8?B?MHdrYklLZE1BcUdrWXZGMjA2VDM4bDUzTXJOV2J2T3hnVEZZSStJVlRhS0ZW?=
 =?utf-8?B?YWpFbE1KR2JYQTdKKytvUjQvTElKMFdZM21BVFBkRXlFZTgvYlA5WDRISTZP?=
 =?utf-8?B?c1VraUhlSXFzZDIyRTdGUytHYTB2cGhqVXBNTHh1YlprZExGYWVvdmpSVWhX?=
 =?utf-8?B?Qngxd0U4MDltWHBrRys2VjBaWnZoR3pzbTZuT3k1cXAwei9SWU9QUE10VERo?=
 =?utf-8?B?VGdDVFFhT3ZVRmYrTUwzSFpsZG5iOWN5TGJXc1JjaXpKbDlVQWowZlNtVHNB?=
 =?utf-8?B?YkxWY20wVW5Fd0Jvam91Wk8zTGVnaXNaVmpYTFUyYllyZFpjdjdVc3JlYnRC?=
 =?utf-8?B?SCtvNGJOL2RYeGhWTEg4UytTRHlCR2NWUnVUTmxPZlo2NFhIVjNiV3JOcmMz?=
 =?utf-8?B?SjYwQ0l3cGtEa2lCcjZBL1NDOTluN1pMaUlZYVZSb3dPTTJvdUtzaXplT1NI?=
 =?utf-8?B?S29xRkpyU0FoZFZndWlEbFN2dDFMdHRIQlhZdVo5MkxiTmp4dmZoOWsvVEdv?=
 =?utf-8?B?dDdPOW1HZHVSYmY4K1ZNR3FRalMzQjdqRy9SNTZZT1A5eTdxYnB1SExHV3NR?=
 =?utf-8?B?MHZ0U2ZHV1AxTENWWkpHakthU0tKS3JVZEFQak9EV3VFK1Fya2lnZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e397de-8300-49f3-ed4e-08de5cd28c74
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:00:50.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0oM69Mjgvu3hOxJi08hT+T0pIwPMKLK0LUM25EszOnDkj8dttc5f1wFK1ob+3MW1z4kajMHb6URq2XZCSy/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
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
> Add pcie_insert_capability(), a helper to insert a PCIe extended
> capability into an existing extended capability list at a caller
> specified offset.
> 
> Unlike pcie_add_capability(), which always appends a capability to the
> end of the list, this helper preserves the existing list ordering while
> allowing insertion at an arbitrary offset.
> 
> The helper only validates that the insertion does not overwrite an
> existing PCIe extended capability header, since corrupting a header
> would break the extended capability linked list. Validation of overlaps
> with other configuration space registers or capability-specific
> register blocks is left to the caller.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/pci/pcie.c         | 69 +++++++++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pcie.h |  2 ++
>   2 files changed, 71 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b302de6419..aa9024e532 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -1050,6 +1050,75 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
>       pci_set_long(dev->config + pos, header);
>   }
>   
> +/*
> + * Insert a PCIe extended capability at a given offset.
> + *
> + * This helper only validates that the insertion does not overwrite an
> + * existing PCIe extended capability header, as corrupting a header would
> + * break the extended capability linked list.
> + *
> + * The caller must ensure that (offset, size) does not overlap with other
> + * registers or capability-specific register blocks. Overlaps with
> + * capability-specific registers are not checked and are considered a
> + * user-controlled override.
> + *
> + * Note: Best effort helper. The PCIe spec does not require extended
> + * capabilities to be ordered, but most devices use a forward-linked list.
> + * Devices that do not consistently use a forward-linked list may cause
> + * insertion to fail.
> + */
> +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
> +                            uint16_t offset, uint16_t size)
> +{
> +    uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
> +    uint32_t header;
> +
> +    assert(pci_is_express(dev));
> +
> +    if (!QEMU_IS_ALIGNED(offset, PCI_EXT_CAP_ALIGN) ||
> +        size < 8 ||
> +        offset < PCI_CONFIG_SPACE_SIZE ||
> +        offset >= PCIE_CONFIG_SPACE_SIZE ||
> +        offset + size > PCIE_CONFIG_SPACE_SIZE) {
> +        return false;
> +    }
> +
> +    header = pci_get_long(dev->config + pos);
> +    if (!header) {
> +        /* No extended capability present, insertion must be at the ECAP head */
> +        if (offset != pos) {
> +            return false;
> +        }
> +        pci_set_long(dev->config + pos, PCI_EXT_CAP(cap_id, cap_ver, 0));
> +        goto out;
> +    }
> +
> +    while (header && pos && offset >= pos) {
> +        uint16_t next = PCI_EXT_CAP_NEXT(header);
> +
> +        /* Reject insertion inside an existing ECAP header (4 bytes) */
> +        if (offset < pos + PCI_EXT_CAP_ALIGN) {
> +            return false;
> +        }

TBH. I was expecting to see a table that is similar with 
pci_ext_cap_length[][1], and a helper to walk the ext cap list
to figure out the spared pos. But it might be over-enginering as
we rely more on user to give an offset that is for sure no conflict
with existing ecaps nor hidden registers. Could you also add a comment
in the code to note it?

[1] 
https://github.com/torvalds/linux/blob/63804fed149a6750ffd28610c5c1c98cce6bd377/drivers/vfio/pci/vfio_pci_config.c#L71

With the above nit, LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> +        prev = pos;
> +        pos = next;
> +        header = pos ? pci_get_long(dev->config + pos) : 0;
> +    }
> +
> +    pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, pos));
> +    if (prev) {
> +        pcie_ext_cap_set_next(dev, prev, offset);
> +    }
> +
> +out:
> +    /* Make capability read-only by default */
> +    memset(dev->wmask + offset, 0, size);
> +    memset(dev->w1cmask + offset, 0, size);
> +    /* Check capability by default */
> +    memset(dev->cmask + offset, 0xFF, size);
> +    return true;
> +}
>   /*
>    * Caller must supply valid (offset, size) such that the range wouldn't
>    * overlap with other capability or other registers.
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index c880ae1e04..d68bfa6257 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -133,6 +133,8 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
>   void pcie_add_capability(PCIDevice *dev,
>                            uint16_t cap_id, uint8_t cap_ver,
>                            uint16_t offset, uint16_t size);
> +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
> +                            uint16_t offset, uint16_t size);
>   void pcie_sync_bridge_lnk(PCIDevice *dev);
>   
>   void pcie_acs_init(PCIDevice *dev, uint16_t offset);

