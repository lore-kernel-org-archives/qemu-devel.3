Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5C9CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 11:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRTB0-00036e-3L; Mon, 25 May 2026 07:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wRTAs-000367-RW
 for qemu-devel@nongnu.org; Mon, 25 May 2026 07:08:46 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wRTAq-0006YR-NE
 for qemu-devel@nongnu.org; Mon, 25 May 2026 07:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779707324; x=1811243324;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XN40Rzq0UaO9nH90wwmCv6uZwtgeTJXxByZCbtbCaQs=;
 b=f2sHCr9J9BHQNVbN8lsFcqe34yjemXodecIkjLS348kgRj1+LgRaS1NM
 ujPwDIZm+kor/xXU7WhzFZoXXuNJT43SR1ErDMn/eARgCE3KVHBTgqksf
 MAsngjo8RSUNSRtS1uMgqIGVlqiCjFPumb13W/LL669cXeIBsk0vhQxzJ
 ZRYZHfsz1HJpX/62o8qi87AnuxbQMDLLBa+jpZW7rmJPmfGEsO7uO+7rK
 c1KmOYQCHYwUxf1/yoSwfPvBjCr4Fl7cEqQnrgdlnMr0JYbOZyNiiS4rX
 J0xN75pT8SEUcuJqSdRXKUwes8fUl0MDB5bvO2ATFtvhTHtgePcmLa2vz g==;
X-CSE-ConnectionGUID: HF2ixTSoTAWMWX/dbCDjJg==
X-CSE-MsgGUID: WHPrwgsQSXW0Ow02fi1x9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="103209394"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="103209394"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 04:08:35 -0700
X-CSE-ConnectionGUID: OLES2Xk5RGeFHAYLLiHbnA==
X-CSE-MsgGUID: P29e/ciuRu6p/eRFWnJowg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="240540930"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 04:08:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 04:08:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 04:08:34 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 04:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJJXOKobvI43Yktm5Du8NJTxPuq+6Ku0vUXPckIWS65rFICzju4qIXrqs+bJsZ9ILQYWBxb0Bm3mld7z9vLYLdCHEFx+L8AvUEFETHMHqpIDCZZylL2BKbagOsmBvhl+UvXJxwtSIkr8HzDQNJ81z5gi1orzJuk7JQU/AP1oQoFMekLx6WStfmJTa1+fTQP4gVcXvcHu+lli4uo9RSP0jHnpHnOeeeboEDPVROuBYTWuWKKTXuaMzgiwBXGOpS6OxKMFNVdCsa4t0Wxo/OIn9hw49BMN0ELb08ecmgIISZbsj8PVQBPIvMq/z54xtHVEbBMvr7qWy1QrSVqnLR3iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dv7eONIs3mYKhLx0awflYEiBV4zTWdYAjF14EWOXDLo=;
 b=Uk8XW38fXVXAjehsdcEBplEq5xf9PhOur1xopemZ69QKB6d2Pz4Oa8T9VcShtoQAj9mqBh6urXGjpa5SNQcBXGWNsn+RhtxmX3/979sA27eZrJdyPI7FFvYV8vH1BPaTIFYOY+SJHymSBzedYV1X1P09/fuIFDs5wmpOX6Q/MnxbLnFbSYybLH7mLJa0uhzbe1j6n2DsTRf7xnA6AhZPuPzmn5RwMOHH4dH9NxFH9QWxnUlRM64cl/rGyMIg1a1yC0V+LqeVCAZYlQNlbuIU+kPXOwc3yXKFUJtbckIL4WrWNKnIQ4eLLk9tarJ8Yt5bolml76ZGy7Ehdtp86aV3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 11:08:30 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 11:08:29 +0000
Message-ID: <951500a3-be6b-4f14-b5de-03802117f62e@intel.com>
Date: Mon, 25 May 2026 19:08:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, "Chen, Farrah"
 <farrah.chen@intel.com>
References: <20260519055756.70575-1-chenyi.qiang@intel.com>
 <IA3PR11MB9136AD783C648B7ABF5E65E4920A2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <IA3PR11MB9136AD783C648B7ABF5E65E4920A2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|DM4PR11MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3abde5-63ef-43bf-f621-08deba4df33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WctTYYK1TTcPMgwv7uSne8h0VJA7s6M8Lx6XfiUKDoG7RA1VcKbF2E32PZbOrQlaC453qD531YoMdUP3xRXtQGDbwQCEh4tiJ214KV7aff96XHzmrQEOeLFIhUYNmrkU+56JkXnaBrsf9x8JjeLKH6iqmpjOUsqCp7V7HjGq/U3VfEbsv1ZSmlgNDo0HKoyqR6zXtjj4hAoJDZt4b+DmAoRXxB0Mg973jvZ5toH96E09rkFurQF+sUf6COQY4c0TLncm5jrvIOcnrQ8NYgHtlS3Ols+1lnEbAPtb2piowUXFwFEoludrirAyCbIYpHt8xxwu5EMhx+djWQrLK8YBeaAkOy1ru/WXD6EEo1Q8/+N2V356m7z9+ajKlHwTngQlCMredbsRb+FaXkARRSmPbjzUaRAYVwe0tClgqIjVIRdGh7WS/YR6AxT3LeuFgKhgXyYukz4RAz9qjpH2cuBw5hGlm72qH603AIiooBpmtbf80Ulz7j4tJquPA3zLob/zuQ8mt/tNRuydtbvLfFM/PyVkQbBgr2C5bOlaffy9kRzzz+SqKkK+q+SaNZDanopv6vanS3IBX36BcJ+HsuGgYbMaecimjvd+HFgHGkUrFMnSI8ZiHQSWVPJhWcRpDRO1dD05AJiobtg5+Ahvl9fBrQxUf3bEL/9CquhJHkBC52jNpZg3gnSBrwz8dVqP3S1v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVk4c093eTlLRkVRWXdWZ0pVNjlVTGxoYW9zSElEVGxUM1VYdXREckpKelFP?=
 =?utf-8?B?NDhaK0Nnb1JEbDJ6NDZlczVMalRscEdDZFVRcWFHNmlTcnZtbkltSEowck9u?=
 =?utf-8?B?OGtOOUV5NVJIMk05a1ZOeUdiQmExSXN3OVZXcGVZVnpCSXU4cEpiZDNFRVpr?=
 =?utf-8?B?Nkwyb1ZPbGZwWkM0MW9DUnNzenN6TDJZeWs2bEFGRkJVL3BOZnE2K3dpYWp2?=
 =?utf-8?B?VWJLK1lXaDNYK1RTZHJTQzg4emxCdmhKZ1hxb3c1WG5sQ21nbXFYTkY1WEtz?=
 =?utf-8?B?YzlXb3ZkVHdKYVQrUEx4V3F4dkgyNDhjMnA3aUd3Y3owdmRTQ0RvOU92WUFI?=
 =?utf-8?B?blRiRUxJclVEMk9yZThVbEFKNEJtcjhJdjVoY0V2VDkyODIvRjAzUGdzSktr?=
 =?utf-8?B?K3RjV1lCZzB4c2FSVWpEL29NWEtPU3FCMWQxOVd6QWFqUzFjTlZ6V1p3UXBE?=
 =?utf-8?B?UXdhUXBYS3J5VU51N3dzM1djNG9ERDRnRVplM2g1YzRxSExSWU1KNnJvS0Nj?=
 =?utf-8?B?bnZTYm1keEVia09LRFh6R2VyQ20yV3Y5QzZ2N0pITHB4SWdQT29pbWFmbDJL?=
 =?utf-8?B?VzFmR0dscmQ3YzJ1YnVWL1ZiUEZHMFJiMEpGNW9VWDZ1YjVhVEtQc0F5dDhE?=
 =?utf-8?B?T1ZYUFlSR2RDcHZqSUdWVGlpUDg0N0VNQWxQc0p6VG50N1Z3T1h3T2ZNZHVt?=
 =?utf-8?B?WFBDbHV4d2JRQ3A1cnBSZDZtanpFbzJ2bVplVTBnaTZjSVUvR1RMR2VrMkZP?=
 =?utf-8?B?Zmt0RnVKTXJLRXcyYmw1MitnQjgyTG9SN28wYzkvVk5jMlJ1ZHVGSVhiNnV4?=
 =?utf-8?B?L3hERkthN0I3M1RRSk5YS0JZZ09MSCs3WVZ1UEpSdVdRU09PbGxiZkxxYU90?=
 =?utf-8?B?eHdvT1c0b0h0bzViY0Q5Yi9LU1hReHZWNUF1Tm9LKzFEZXZRKzkzbnQ1OGtI?=
 =?utf-8?B?eW1nSU5vSFZ0ZWFmem1BTmh6aXdGZHlNWmNkc0Z4Z2prSTZOV1llN3dQYzNz?=
 =?utf-8?B?NEZvNklkNlp6M3lFSHpvM2ExT1p6a29TdmZubXBRVjdDbnRPeXo2WEptUVhJ?=
 =?utf-8?B?V0R1dk9tWGVPdEpTb0I5THp2dVB4ZTV1Wnc4dzluSWJlVFo3Y3JuWUYyR3hp?=
 =?utf-8?B?MDNrN25zTng5czNQck9id2tJUFJJVU1sYlpUdG45WVprYjVGeDJnQTFUbU9u?=
 =?utf-8?B?dEs3NFFBanJuRDJIR2RDbG8vZnpOcGJ6UDFER1JGWWpwOHl1U3JGSXNtb1Bi?=
 =?utf-8?B?MUdNcndyM01oVlVYZWdVMjFxaEhsa01BQmYvZU8xUkFtVDhscXkyS3IyMG9y?=
 =?utf-8?B?Q0JJM2EwSzhNYXRuR09QamdCZDRUbXk1a09MRGI5YkdEZGlTWFR5aHRZNHlw?=
 =?utf-8?B?dERXRCtGc3JGRi94ZG1HNGFUMEFkclJYbElrUnhORjVpL09ZL3BFbEM1K3R1?=
 =?utf-8?B?MWd0UlpPa2JYSUtDUG1pcnRUTWwrSlNTS1RGSzR5UVlLOGUzOFdPUGg3cGhK?=
 =?utf-8?B?d2pmWlFYN2NNQlVsTFpEQ3djWTczUW9LbUoxR0ora0d0L0lLMTFuNG5xN080?=
 =?utf-8?B?Mzg0eW5MS2VRRHJmb2xYb2lhdWNZSWg4Q2I3VExrbWs1SEwya0VOLzBmZmti?=
 =?utf-8?B?Y3o4dFZJazFDb3QxVnpNYm9VWTF5UzdFU05NSnpJZWZ6ODhJYnJMWHhJcDEy?=
 =?utf-8?B?SWQ4ajJqZEJ1eklaTDZRcjErQkVXL3MrSWN1L2tMcTJrUHVIWXUzOFUxTXh0?=
 =?utf-8?B?NkxJeFFhdFZ0T28vK3lqQTgxRUJBdDRrczFSSHlXd0VBZ0xIUzhhYUs2TXdm?=
 =?utf-8?B?dFEvNEd4cWZ0R3dGYUpFc2Q1UnFxOW4xZlpmWW80L2V1WWc4Q0ZwT3ArVEhv?=
 =?utf-8?B?OUE3RGUrNHR0Mm9Ua2dTY24xUGxhbE4wWEtjK3doM1ovWVpUdTQ2aU96c2FW?=
 =?utf-8?B?cGVQc3IyU3EwTWVTZ2R3N0VIYXVaMVJIVzAyWVljbDdBYjV5NHpsSDI0TEZz?=
 =?utf-8?B?RFMvNmRkU0V2ZVpxVGF1NlZxd1RaY21IazJNYTQ2QXU1NEZmWG9kVlpUQ0hC?=
 =?utf-8?B?WVliMThXQ1ZKZjJLeTVlNUlMK21ud3RJb2RkSDBXdk9nYVlaNDd2dDRVd0Vm?=
 =?utf-8?B?bm03bEwvMVJUc2doQVJKV0FXbXJJd2pXR3Q0aVBLSXdhQ1VUcUwvSk5GZzJC?=
 =?utf-8?B?NVRoWUdCYVQ2UzA3VXR4ZEVrQTVnLy9SQTNQUC9FYnJaMGJJcyszazZFcHhl?=
 =?utf-8?B?clp4aEZxWDlmUlhPVkt1UzA2UnovWkV4Z2k4ei9sTy9BTWpjL1l5QUNsWHVP?=
 =?utf-8?B?Yks1Q1h2RXdvTEtRNm01d0FvcnRyT2c1elVMTUpnZFk2RmN5NHpkQT09?=
X-Exchange-RoutingPolicyChecked: n3G7DmxZFIVN1HKTbm2rTL7iC4JdoADLNv5UZxbiPUF/nJdhcv2NVqXSOwvxS6DLbDkw+Z/yII1ES7k3lR+1aeI13htKr+4FgKtTEXyWWM+44KfbV+hkc6fSuQYzttN8rwySkbw8Lv0Jo6jHWf8xpJWSetIMs/K2GfFxjIhUBgfNqtD0UEy7GjOZE+Yn9kUOg8/V7F/41Hev3vqafy7PVQtFm6vpZiGdiQnF2h6KpsNb7vcpi2FB0xKsI7U3wAhv76pIuu0MAU7ROip64PpBeZ91MK97T1Nx5te8fMHiUEMdhJIi2nU8IOPIxJ/zX5DQYcTqACocRmIIWLVILTuq9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3abde5-63ef-43bf-f621-08deba4df33e
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:08:29.2856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uyd/1W1Hb2cWu6SeYyZ/K5FmYQfn3iMUqZpeGIkOiwEAuWYDWXJL3Vcb9GTP0xY9F0fjqiqbLNjq+tE26HbTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8132
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 5/25/2026 6:31 PM, Duan, Zhenzhong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Qiang, Chenyi <chenyi.qiang@intel.com>
>> Subject: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
>>
>> vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
>> fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
>> not correct for private file-backed RAM.
>>
>> dma_map_file() resolves PFNs from the backing file, but private
>> mappings can run on different PFNs than the file itself. As a result,
>> using dma_map_file() on a private RAMBlock can program DMA against pages
>> that do not back QEMU's actual guest memory.
>>
>> This was observed with hugetlbfs-backed guest memory and iommufd/VFIO:
>> share=on works, while share=off can fault because the file-backed PFNs
>> can diverge from the PFNs backing QEMU's private mapping.
> 
> Good finding, did you see same issue with common file(not hugetlbfs file) backed private mapping?

Yes, I also tried with "-object memory-backend-memfd,id=mem1,size=2G,share=off", and it can also be reproduced.

