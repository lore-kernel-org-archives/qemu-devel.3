Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85887CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZqG-0001rA-IL; Thu, 28 Aug 2025 06:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urZqE-0001pw-8b
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:26:50 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urZqB-0006Jx-9q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756376807; x=1787912807;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pqYpjaqDxMc96+ij4FZwj10uNPZ8ds7W5T08Kk8VuLQ=;
 b=jtZr8naMU6qFhOvVZIAkLU+7oigtvCR4dWAybc3VzbsY4c5cHOGbXJ7f
 J7N9XlbFhSJN1QlTlN/knkfzlv09cFoPRIPj9xi6jQ5icnMgmp5PqAjml
 0MyuqO8wHZinKhfgF0ryMR3v5FU38BYTffRvphqA2WCeBNHxB3dFvtdTi
 5exI9Aykbos7/t4rvGIFn4sji6Z0OjFzhS7uMB7eNNkKr9+S+y1QnRGOs
 4E4EDfXf6JLjiegiDtj8h1WeCgOVCgaKU8NfGpAgkSUODotLkT+wmGXNi
 Lbi3kKg4rLJ7PHH1gyFI22dOMzPVDahq2lvRA/hbmTz/VtozvRTsECAuC A==;
X-CSE-ConnectionGUID: Y1tT38nLTe+oof85KH7f/A==
X-CSE-MsgGUID: mq+QHds9Qj6J9dEbUgc9mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69348802"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69348802"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 03:26:43 -0700
X-CSE-ConnectionGUID: mHYkg7o2S4yjRKakgljJPg==
X-CSE-MsgGUID: Re4UljQ/TF+q2R/eFJkf7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="169372761"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 03:26:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 03:26:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 03:26:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 03:26:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmxOdTU+zAgNbTGufJ9qmpr4WW+G6RMikO4joxHzYkoX7VYiON7k6OEm0z/w0PR08uxkM6YuAvVlaMZz69KdG8r4i7yhQWFHm+Ddm6fadqVD6M/0OTxRoPbo9BZDdrOfZgbXO9yQD5xdoOBnNmxPCeVOfNbCCONxa+xmzonWfFVEE3z1kk8lUVmhwdXiCNEkpFWk4/pGyTT41qawJxmmE/ZVU/WnJNhp2AugqvkTZkuoYxQW0lBru69SxiCAno5m1KNXt5Obl5xKR/eXnksMqCtyE8W7g2xsTh4cO8vtBe8Hj342JZUDThKnXEQImM90jFFh+TTkEaXwMfVqpD5StA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPoeywRejuB7P/jeIuZb/vHy1tk13w2MNjJEeLjwXs4=;
 b=Tvf60O+zWksx+xPJantUIdec71ReKVOVVgD3SJ9e7D2SEDHyFtkTw74FLaYos/6q6an3p5qO4mKy43TIm+pfJyHexAZxQqywzH2Rrk+xKqOlIVvUuJAo+lEg6s0mS7AAUzmDPIAaLBCRLf54qVEY7TAbt8ZdMA7M/PxcSs9oHsV2RRGG5ltq2y3SSP85YcaJvXFrxviH3zQbAAfyWHvGTuM3EqMeZgYHExEcs0KL3fZvDfUnYRuUaYljo+ZXsaQNfYl5avEpbsWachJlU7895XIVp04acAcWNuMC7jcKi8wqQboXIrcXo2P346givG8mTUjwviJOAaHq6hRnspxdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 10:26:36 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 10:26:35 +0000
Message-ID: <d470594c-959e-4cf7-a1a6-745c5671646f@intel.com>
Date: Thu, 28 Aug 2025 18:33:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/21] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-10-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: d6832666-df00-48a7-c68b-08dde61d5d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajBSa2UvdEJJaU8zc0wyWG9wTlpDemZPVU1HVHdpNEJMYnBFdWswMmlReWk3?=
 =?utf-8?B?T0xLWENTK1RsMTd5aUFCRDY2akVFQStLdmg4Z2FDOFAyWStxUitvQ2NCQ1c3?=
 =?utf-8?B?QWlDWFV4Q0ZXSDBKUlB2WW4wRnYxdnIyQmVqbS81dHdod0RnMFlsb21CaTAy?=
 =?utf-8?B?aGVqeWtVYi83UEI3TXdsZ3RFWjZHNjNDLzMxRXdiUklwMTFGZllleXZlNDlQ?=
 =?utf-8?B?eUlUY0RRTGtYWjJhYjFkaDdPV05BSHk4U0JNazFTVkwvWEZRUTdXMTdCV1RV?=
 =?utf-8?B?eW5SaG1DZ05QK2JjN256QzVneWJ3RVJTSkJSK1A2UHZVWnArdVlmQkRrRkJN?=
 =?utf-8?B?VDh1TGsyZnU3NTNHS2U0bFFNY1R2QWprOUFPb3dRUUxUQ3FKK253S0dZcjVu?=
 =?utf-8?B?NVFHUEp4NW0vMXhKR2NCSnQ5VVdYb0Zka2lqbVhtbEs2bVRYK2U0YmZGUGta?=
 =?utf-8?B?Y09ZVUloTHFSaEp6N1BRc29vb081ejF6a2t1OHFVMDdQKzBSWnJaS2xJWlZy?=
 =?utf-8?B?ZjY1YWZvRnZidkR6TXVPOFowVittODE1OEpsZ0M4Z0grS0Z5RVQ0MUo3czlC?=
 =?utf-8?B?VXF3OUl6SGFzTUdKdU9iY0E0Y3dCNFhDVGFyVnJpS3h6TUd5aTBxMEltdGZp?=
 =?utf-8?B?N3U4NkhtZnJqMVZmQUwwenhtMlV0VWdZMENWWHdCYUJvQ0Z1ZkxmN0NhcEh5?=
 =?utf-8?B?NUVYTHVKM01YZWt1eGJZZ1dobTVPQXd1ZklLZGVFV1hBVVpneDBhcVBuU0lv?=
 =?utf-8?B?VU1PbHBlRys1UlVBRUZ1VEpvSVZKRjJhVklPei8wcERTR1FGcTNZRHhHLzJs?=
 =?utf-8?B?S3lzTVZQZ0d1c0xtUWlaWGx4N1NJQ1NMZy8vbUJsR1BxaHd3N2szMnV5V1lN?=
 =?utf-8?B?V01VeUptTmZRUWg4Y3NaVkcrWUJpQWtDR0hoQk1kSHN0RURtcXlTblZ0OTJp?=
 =?utf-8?B?Q2VQcnRhUXBad3NRQ3BtOGNkOVIyckc5Q2Z1K0xRMERBUzV1Sk9kNnU0T3Nn?=
 =?utf-8?B?bXNrM0dmaUhlQ0VSUk5iczRsbk1YeUZFSjUzZ3lNbElibnNlckJLMU0rTVYx?=
 =?utf-8?B?Z0dBcDZvVlFPdGlrZFZJb2ZNRnd5L0MzVGJXU0xPa1FYSHh2RXJHNHFSUWM5?=
 =?utf-8?B?N1g3S1dtaEdhNUhtdDFkNEQ0NUZvamJqTDlMK2RIT1QvVS9oSnFNam9OVjg3?=
 =?utf-8?B?UUg5NXR2SDYzRDJIdFdRMWpESU9Va2hXWjJWMzM2amdCejVBTjJmS1o0SHlX?=
 =?utf-8?B?eldZTWRoTTBaOFZuQ3JJeVEyc0IzV1FMRGQ5aXMrMXVnTnRvaFd6djRLTUth?=
 =?utf-8?B?SFJ6KzdOeFh3ekFodmM0dkswUmhJZHVYSjlvS3ZjdEZYSWtoQkdUL2V1VFNx?=
 =?utf-8?B?c05neE5jemEzdUlNVldEZ0kzODNNUFJCQnQvNXJqVDYxYnhGakRVZVlqVU1j?=
 =?utf-8?B?OHVRckRwTHNya0V3REg1aVlYVGQ3d29KWG54MzI1ZnZPanloZi94bDZPSlRP?=
 =?utf-8?B?dFltNVRRQ3h2TTlvcFVjS0VXZVF4eGlDUDZiaGJEUXhTY2pxUUNTL0YxZEpX?=
 =?utf-8?B?RlM0S0xhVy9HMndpMi9SWnBWMFN5TDBUTlMyTzZaTXpNV2htY0xLZ0Fwbm0w?=
 =?utf-8?B?MXpDUjNjUVc4SzVVdFlZYmMyTHpLTlJPUzJ0UVUxdFBjOXFRemllRy9UN1Uv?=
 =?utf-8?B?cTlRRTFSQlo5VWdKY0lDbHJHTC96M2RlbTVtMk13RmcxMXI4TkJCWmUwNWdY?=
 =?utf-8?B?d2VkS1kvRXVwYWdLbkI5cFg4VCtTZVM1bW1vL0FKb3pMMVJwVzc2UmxMRHJy?=
 =?utf-8?B?VXUvczR3cEMvVm1hWWdDbEwyWjBkRnJpTWtnajI0K3VyTk9XNyswOUZlYkc5?=
 =?utf-8?B?QTl5aHorYjVpaXU2blg2YXpObDdxZVFvQzZUZVVSMEwzSDY0aTEzWU9iaHc4?=
 =?utf-8?Q?o2qqg4h44ck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1V1cTU0S3lSM0RlTE5EUjFWbGljRGV2N3BERExvRWw3YWJSaWcwMUFwek9Z?=
 =?utf-8?B?WHZQczNMb0FDTnVCVTBDOUpZOXNhNG1VS2lPaTJQWTlDNURGWGZ5bEFRTHRJ?=
 =?utf-8?B?YkpMdTMzQ3JLU1RnUDlJSXFranBrWXI1SmNwYlRwMUh4SUR4Rm12SWZRTVVw?=
 =?utf-8?B?cWxRSm9ZbDJmV1QzNGMvSEpLTnJsRmdlc1JEbS9jN0lnb2lhL1c1Y3hGaVJy?=
 =?utf-8?B?WkU1WkNsU2REazhSZEJ4YzgzSVNHd25xRVY5K3Vpd091YUM4QmRqbDdTeXh5?=
 =?utf-8?B?TjdCVXFmL2hzWlRXcGZORy9qOWhvazVaS1JUNXBURzNSS2hFV2VLRFgvZWFM?=
 =?utf-8?B?Q0crdjB4NkpZOUErdkdESVBpM3pkQnhPOHJiUGFGQjcwMW15eTRkMWovVUlS?=
 =?utf-8?B?TldrSmRpSnhWUll2T1ZLTkNNakNvNVh3ZTNnMDNWelJXb1V4alpEMHFVWHBm?=
 =?utf-8?B?VXlZVHBTUGx3b0N1NzNmcEp2NGszb29xZzdPVEFPUndmblNIbWZ3Uk5YWll5?=
 =?utf-8?B?UjVYRnZScTF5eW9BZTQ3blFVZ2E1U1hMVjRzZ25OWlg2eFVzbllHNi9IODdv?=
 =?utf-8?B?dVJVQmtxQXFrTmpjdnl5dFFuSmY3RVV4TDFFMDg0RnRuamJkbjJJOE0waXFm?=
 =?utf-8?B?Y1JFcDNuenZ0TTFab3RlU1dnRk0rZ05qbmZQRUF4LzhTbHJTblF0VkppOWRZ?=
 =?utf-8?B?aldmOTlRTWRuYWJnVGoxemdZUFZvVE5HUVIwV0R5V2ZGQzQwMURoWlc2eUxB?=
 =?utf-8?B?THV4NzBnNGVkdE4veGhpYnFtUklpa1pNNko3b3JDZC9STVRxWmxRb3R5KzFi?=
 =?utf-8?B?dXlUeHVQYjlFZmJEQVNROS9KNC9BTTRjVlQ1eVhrdWE4NnpDNnFndDZCTkV4?=
 =?utf-8?B?M1dOZGVDRmpSdUZqbGIrNGRkbTM4RVh2T2dGRjJMbm1NdS9OTGtLU1hzQzQy?=
 =?utf-8?B?QlZvc2Q3TGwyU0pSN0M3Q2tsRkJOYWdROVphaWhqR0cza0VSdWE2bXpLa0sx?=
 =?utf-8?B?T1ErcUFZWmk0WUdIa0tWWGlVbHQxYXA3RnJzNlRaeUJ0TUJ3OFpPUHBoNXE4?=
 =?utf-8?B?VEY4V0Q4WGpKd3RoWnJVeEt4cDQveVU3L2FJSzN5MU5TOTlLcWtmYWdrWXZ0?=
 =?utf-8?B?SEF2MXQyUXZUWmpseHNWamFrS3pnai80RkZqeXpranluNDRYRTVUb1FWNTAy?=
 =?utf-8?B?YTRSOWZkT2NwMTBCeStwL2RuUjBNR2ZMdzBVWG9Idy8rMjdyakhlb1lkTkhy?=
 =?utf-8?B?MmxrMlNQcEZZdnVTRnQ5bHRuMmMveXJocVhaSDVFRVJPSlRtK3VlYmtDWHQ5?=
 =?utf-8?B?TUk3cUlaUVh4UE84YW5QV0tQNEFPOXg4dFlHSGFUajNEZ1FzVmpYRDFsbm9J?=
 =?utf-8?B?QWV3UkVIMVp1dzdCeDBEV3Vac2RURlRuZmdlR3QrL3BtWnFSZm1JM004QTE4?=
 =?utf-8?B?QmVjeXJvdG9OakxGRlE2eFdDejhiTHZ0QUt4SmlOR0VQb25rMFpiSU1vaHNk?=
 =?utf-8?B?Z0VUTXc5aHc1a1hIVGZqVFdsRGhPY0NTRjZrSkh3RWxCK09kTU1KSm83NmJP?=
 =?utf-8?B?SUFWQk9GMTZvZHpsZDJZTFVIWFNIc0tZUzg2TVljOFNhZUFxUHVsYk1kUzk1?=
 =?utf-8?B?ZmRYWGZIdmhxbXVSVEh1RVZzRTliQmQ2MWZNV0FtOTU5ZURiSHA3cVJFVURv?=
 =?utf-8?B?a3RiaFc4YkFScWZsZjFEaEVxZ2xWbzh4QWN3NURhZityQUozbmVpVTczeHBL?=
 =?utf-8?B?cStWVWRIbzd3amZTYm5YY2lJc21LaEVvNnMvZDZzUG9uT205VkR6OEROUlgz?=
 =?utf-8?B?dkJ6MUJnNVIrM3JkWlFDTmtVeHQxSCtsbUZhTVN5NjhWbjhIaHN3ZVZTOEtT?=
 =?utf-8?B?alNqZ0c4NGFoZC9iWEJBOGlZN2d3b1JIUkZBa0o4SnNwWVdHYXplb1E1cHRQ?=
 =?utf-8?B?VGdUZWRQTERQL3RwR0tYMFpGQmxGZFhvN083bExIdmY0NXlIR3p2UjY3aXVD?=
 =?utf-8?B?VDNRMlFuTGp4akVqUkZvc2dGQXpNQ0NUVEdCZ2Y5MDNiZEJLeVJpenBBbk1u?=
 =?utf-8?B?UnhRUWg1ZlVzNmhuZk5GK3p5OHU0Mnp1Tzd6NmtVVFBlUytoSklSVy9iSmtK?=
 =?utf-8?Q?ZdBLFYcSBviKc6D1Fh1XiLyri?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6832666-df00-48a7-c68b-08dde61d5d77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:26:35.6123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWCpZ4ncR3Pptq3NEnIeY9Kp1S/j65TjrJ2xQKt1R7WMmHBgO9ePquiMeV+MuelXHmhtPU3TRZHkUnxxPyYmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> Currently we don't support nested translation for passthrough device with
> emulated device under same PCI bridge, because they require different address
> space when x-flts=on.
> 
> In theory, we do support if devices under same PCI bridge are all passthrough
> devices. But emulated device can be hotplugged under same bridge. To simplify,
> just forbid passthrough device under PCI bridge no matter if there is, or will
> be emulated devices under same bridge. This is acceptable because PCIE bridge
> is more popular than PCI bridge now.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index da355bda79..6edd91d94e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4341,9 +4341,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       return vtd_dev_as;
>   }
>   
> -static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                              Error **errp)
>   {
> +    HostIOMMUDevice *hiod = vtd_hiod->hiod;
>       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>       int ret;
>   
> @@ -4370,6 +4371,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>   #ifdef CONFIG_IOMMUFD
>       struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>       struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +    PCIBus *bus = vtd_hiod->bus;
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), vtd_hiod->devfn);

pci_find_device() finds bus pointer with bus_num, this can be avoided
as you already have bus pointer. Perhaps this may be done by wrapping
bus->devices[devfn] to a helper. Especially, pci_bus_num() may not have
the correct bus number at this point.

>   
>       /* Remaining checks are all stage-1 translation specific */
>       if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> @@ -4392,6 +4395,12 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>           error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
>           return false;
>       }
> +
> +    if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
> +        error_setg(errp, "Host device under PCI bridge is unsupported "
> +                   "when x-flts=on");
> +        return false;
> +    }
>   #endif
>   
>       error_setg(errp, "host IOMMU is incompatible with stage-1 translation");
> @@ -4425,7 +4434,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hiod->iommu_state = s;
>       vtd_hiod->hiod = hiod;
>   
> -    if (!vtd_check_hiod(s, hiod, errp)) {
> +    if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>           g_free(vtd_hiod);
>           vtd_iommu_unlock(s);
>           return false;

other parts looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

