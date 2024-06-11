Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D733BC27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 02:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGrJw-0005Ve-MN; Mon, 10 Jun 2024 22:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGrJu-0005VR-PZ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 22:33:11 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGrJr-00061p-Ij
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 22:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718073188; x=1749609188;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=INQb14P0eufk2luSL0qLmpMNm0pPmSW/h0teMatXqbA=;
 b=foa1HiK3p9HORgjd4ESEyXcm/wrlL+A02UD8ef/moF/Hu9GvvedHyEeD
 pjuKNTUdPBNNdFrmU+W0iaZO/NzaWIIzfmoTPMWWaR0CC0XdDEplaAfee
 OZopmfxkji3RYJpzBphf4ds3Zw9fo67UWj99SWDdpCIU65nfW9grwbB5Q
 dP4Tfm5S9tQB281crQ6zDazDZyIH2r9YMp2YLEnYX3P1oQZIAhcG0ZNqC
 a4xLWg9bUqmtJwbn4qhUOJlvrWP26RAVIlPd5XotdPDSe9xe+wScLryf2
 n8kQ+HWovW3dLeM8OS7S5DeFuumB5TQeI7jjRwf5EgCBlh16Yk324T369 Q==;
X-CSE-ConnectionGUID: mP263WoJQPypoEup78H5Ow==
X-CSE-MsgGUID: HwpMDVezSpyJCyGFKV5LtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14931538"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="14931538"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 19:33:03 -0700
X-CSE-ConnectionGUID: ntHzCDuqReqnQbXCnoO5zg==
X-CSE-MsgGUID: m8/HAsd6SduCDpIxc9eR2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39941664"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 19:33:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 19:33:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 19:33:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 19:33:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMrlQgQsVhPvIlaa2bJwWy/hagjzjU3KX/0t2oPRkcGqERja6Hyvbed5MYueA6bznJjsbu9juAsGJGT7UumkwKwykt1ERImANz0wfF9rgXaWUR0xmWdqu9Q9li1sYrmKdvzsozOigCdBkwrpewwAmRi41VneplVGn3tKOc+pZUxm5D5K9zxvc+3hXWmvFtCuUhG1DBN+yTAeKd1aQ3XKBkXGkqbNnBBfUbeCIOBZFY8ygDD/LCmVcKWYEM7BHfTezWJJze94MCit2OVw/KEFg1LkVH7EDGSVHSVRlnfoiRJBWPeJ3c1I1pV/4G08metjaIuRlxkrfh3VrOcQ2QkKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INQb14P0eufk2luSL0qLmpMNm0pPmSW/h0teMatXqbA=;
 b=DrJZwGQIG2Mi3ap60nbz/6ZGFakROT3rv6KUlLBuR79c19nM6+ejb8DQrCxNcJymdAzp2ZIt1WzaELnLSI1QspnQ1oULF56ClKGpsr0XumVfCwe1AxYdsmkpQ9Et7S8Ua+PjMbZsIihOxByiQ+eacjzaXiz8lnSsSQxdxEsnWyJRtOZkI/LK5bQmACzlx+fTvHx5kzCToRB8Uam61CSqVrk6D4pVF7GEKyKWfOub7Rd3CpvvdL+d83qv7BBe3S0WqFaUBaL9MDmPXAQ4nnOkeQeXzQha4UBL86gAOqRllfXhB9iS4AxaJZjEbOypwV7JxOdMBKAQoxMSVqTxYhRRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 02:32:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 02:32:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 00/17] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Topic: [PATCH v7 00/17] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Index: AQHatyMI+pOgM35EG0CJrhfGkIesrLG8aLIAgAV2r6A=
Date: Tue, 11 Jun 2024 02:32:54 +0000
Message-ID: <SJ0PR11MB67443B40B64A005DC2C7781692C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
 <bfe7e229-2614-4865-b7cc-3d37918a30ff@redhat.com>
In-Reply-To: <bfe7e229-2614-4865-b7cc-3d37918a30ff@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7398:EE_
x-ms-office365-filtering-correlation-id: e39964d5-bbba-4fec-b726-08dc89becc5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?S3BNc3VZamZZMitPSytpRDBNZmVoZmg3cEs3S1NSUjgvOGF5dWtGeHJEeG9x?=
 =?utf-8?B?b08rYUI4cUlNVVhIWVVhYnlJem5QeCtYdnBSd0loT0RhcmwxcGh6WmU5N2pl?=
 =?utf-8?B?SUk1VE4vOVBNQ0l3bzRkRFVTbHFFTm14QmQ1NGZQeGxXS0huN3ZwQmhYVk83?=
 =?utf-8?B?R0dKQUo1OERWd2ZDMzlSTVNiWkg0aTQ4SU5GMEdBcjJmL0ZBQlhmM1ZBbzBQ?=
 =?utf-8?B?MzZ1ODlURmxkaW5mc3BxNkV6bFNhbzF1WFY5TCtnNXFzdGdpQmZvdFUyS2Y0?=
 =?utf-8?B?TWdnNldib1ZYT0dtbkxoQ1NWS3ZpRGhYWlIrZUk0VUZGWmxTNERaZW1tNHZ5?=
 =?utf-8?B?ZkUzNjErR0tzYXpmWUliaVkvbnNBYUJFWmg1cGtXTVV4SW9MTEtzTDBKSDl1?=
 =?utf-8?B?VHRvMU5naUdxd2NZc29tbEFTM2Fld1JDUzEvdHlOeUNUbFUvV2RQNmVaYVNS?=
 =?utf-8?B?bzhndlBjVEVQNm1EQnF6WmFNVjhVTWFoSGJxakRLb0gyTjJiN3czNVk5S1Yv?=
 =?utf-8?B?bGJiUGIxRFgxdExTOHRRNERhN2JXRWFJVUZub2pUdFhQK2dlY3BuTWNobkRk?=
 =?utf-8?B?eUNMRSthYUc2TzZHUlE5Q1dmS05QSFowVTZxQjhXMjRNY2kyYktFOEt4Z3RY?=
 =?utf-8?B?SkxsMDJVclRyZlAvQlhtaWVPbHhoZFdyUjNrL2hrWmZ5SGlacHZiNnJ1ZVM0?=
 =?utf-8?B?VXl4aXJLOGRtUnM0b1dtbkdRcVFkdU80Y0tObzFONXBJdGtXcHhoTmFaSDFq?=
 =?utf-8?B?d3FIL3JITHlQR2VkU2hKWmxtSnhxWHlZR0RtNUZZWHgvZUhWOEVwams0aThJ?=
 =?utf-8?B?WEFVSUR3aWhia2FoZkJ3b00rQmR1YUFERjhzdTVjTitld1VYcVdta3c4WjJw?=
 =?utf-8?B?MlFIV0hINWF2bnl1SnRmTGJadGh4bWZtNElGQkcrQVRweEhtTkMvY0d6K3Nx?=
 =?utf-8?B?Z3k5dFBTWXA5RGZWaWN1d2dRaHcrSk9vRys2cXZBRk5jZ0FqeXZsSGFRaUFU?=
 =?utf-8?B?c0xDRU1DYlREaFloVzVSalJ4eGhRdjVPc2xQM0poNi96dGdNWm5zcGM1a0xt?=
 =?utf-8?B?TlFLMU9GODc1dTBPZTBXOVJLSHdYaWxKZnNXMklOMGdncnk0ZmNHT29mY2cr?=
 =?utf-8?B?ZFprazdkTVhuenhYUVlOTGNxcU0vQlFFd1JVQmVSSzRPdGdEaUtReXZ2MkZk?=
 =?utf-8?B?UHptM3Vtc0dia2hmMEFlb0FRNFNiV29sdXNMQkFGMitORVRpUlU0M3B1REt5?=
 =?utf-8?B?N1htUVdwM1U0Sk8rUnYvbmdoOGVsYnhEL3NLclVLeVBSOEJuRkFkTUJmTjg2?=
 =?utf-8?B?YjBwcWlXd3hpQjZGclEyWU1GczBSTzN4RXJTNm5jd1JNQTFyaE1KN1hGTGk0?=
 =?utf-8?B?U3d1VUI0MDFOTzlXOURRYlB2bWFpOGN0cnRadnl6R3Q0cnprTGEvMnVReUlD?=
 =?utf-8?B?RUlzL1prdVQwUFZLRkpIV3RhWmJYbkpEc2tldmYxSXNYTzE2WVo1VVNyQ0Fw?=
 =?utf-8?B?ZTBqejhYSFVwSGcvNHV4SUFmQ1VUTmM1S0FhQnNWTloyODhVUzFoZGNMMHhq?=
 =?utf-8?B?T2JhQklBbHZUMDh2K01YODdRbjJaY1kxTWt6TlhvUTBGaVZIdllOZ2Vibklj?=
 =?utf-8?B?QXVCd2RIQXRlS1lHa2J4V3JoYzdNeWlIdEI0N0xuYmxBNWdRbXJEMVg1WXJX?=
 =?utf-8?B?TG05Z25PZG1INk9qYXZtaVYzb0NuZzNvbHNSMjkxcEhpSmpneE5PZVE1Umpk?=
 =?utf-8?B?eEpMSVRocnFQU1FseVZVbklzN1dtMXUybmtjRE5FdUNwa0YvRkY3QXQ4RGV4?=
 =?utf-8?B?UE1kc2lYNEVWd0ZTYWpSVG0rVEZmNGZKdzBJZUFPYkxpVDJnV3d5aTlCbnJQ?=
 =?utf-8?Q?WmBFfkLEkRyjt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1c1YTVqcWR1akdQNUdLbjU1c2NDcWhkZVNVMUhDY0MyZUNtWTM2dWNTUjFE?=
 =?utf-8?B?dTk3MnEydmp5ZGdYSWFXL1BOVDdMMityc1pHYnpzTWI0UEdDVlMxdVNVZmpC?=
 =?utf-8?B?MXVGQ3ZhRFBaMC9IUkVESkFGQzdEUkJxdEs4N3cyeDF4UVp3U256U3NRQUxF?=
 =?utf-8?B?SEtlaDdTeENWZ3ArL3V2Lzl5TmNCNUo0WjNKV2hWbXJwTGkzaG93U1pJdTZp?=
 =?utf-8?B?eGdCeTByNzlUbS9WK2VreXFqdmJNcFFvMTR2OVMrOEkycmxad2hiaXZ3ZXRu?=
 =?utf-8?B?Y1M0NnMrR2Q2Ump4ZlVDcWc4bXE0QUxVK1RIZlR3K0R2N0pnTENUOGJxdVV2?=
 =?utf-8?B?TTlnZHRPUVJLREpEQjJCZTF0ZEpIbW92d0g2dWtJWGdUKzNvSDlPL2MyYmR1?=
 =?utf-8?B?NjFSNitvRXBoeXFYY3dYUVF4UjZnOUhtRmIxQ1pWTGUzMG9yTUQxaStBMUtU?=
 =?utf-8?B?THZ3MXlYcitNTGlLSS9IYmw0UXQvUFRZMVFMdmdqV3BRWGFsK1VPdWRvcHBN?=
 =?utf-8?B?WGtMaUtiZkZoSFMvcG1Jb0ZuZXJydEp0R0ZhTXVKZ3ozT2sremtWR3h6Vmsw?=
 =?utf-8?B?M0FLaEp5WTZxZWdxQmthV0dHMnJWOHBvdm5xSnZPeW8yMFBmU3FQNEVqbVJa?=
 =?utf-8?B?UVAyWm5jaCs4dmJ3aVZOMW96N2VlUkovVVQ4NzZySnZlaGdBcUwvVjJKVE53?=
 =?utf-8?B?RjRjaHEvZWxtdDAyM2wyVER4WVZIa28vWFdLaURJbzV2SUxMdzVoK3JYZVhm?=
 =?utf-8?B?cG9XVWh4WUVkdHJMOGtnVnZUdmRoTlJYTVBxZE1LRWJQUHZLODZOZklTR3RX?=
 =?utf-8?B?Rll0OTM2em1YY0JtaUdBcHpNSE91OWNHeTF1TVNKS2VHUG5pc2gzSFBYV2Fk?=
 =?utf-8?B?RzRzQlR5SDlTRjBHV2Vmc0RVRUFBa2FnY3NVUTl2bTV1clEvMUx5cS9MK1hU?=
 =?utf-8?B?Z2kybng1RENnSFBnYkNPMGRvV01NODRNbnFTTkFsNGFldkRySjdCaUVucEdj?=
 =?utf-8?B?OWJQbVVXMzZlTUh0NEdlei9aOHI0bDU3VWRqWkZKTzZsVVZFUGE0RTNWQVFp?=
 =?utf-8?B?Qjh4ZEEvNEVWRkJ1bWpDellISlYxY3BKVnRHQVE1bG96S0Q2dVAzeklobFRp?=
 =?utf-8?B?OTN4SkRCMmQwbzErWXRmNmYwd2tibTk4MURPSEJQS1YwMThTc0I1VFk1SmZK?=
 =?utf-8?B?YkZnbHVYOUw3ZFRFeHBMSDdyeW45TGRiRzVoY2NiWmN5V3MzOFUwU0E0enFN?=
 =?utf-8?B?THM2RXQ5TTVMMmNSOCtKVk5yZHJub1prSVhPNUpvYXpwWFUveGR6Sm5wN21k?=
 =?utf-8?B?SXQ3d1ZEMkNYaXZjSVA0aGNjN0l2cWE1ZnkvTUN5SDV2RGwwTW0xalk3N3Y3?=
 =?utf-8?B?S1ByY3dMWDJ5cXdzS3ltbCtzT3VHWnN2ZzBXeHg3c2dRb250WVhiMW43QVBL?=
 =?utf-8?B?UU5rN0NxdjV2Zk5EQkU3NmFuL2NaN3licVY5TzJnekdNUU1jcWRFS3lwbm45?=
 =?utf-8?B?UWV2WVUyOWJzRWRjcCszb1JhMUQ4RFkzMzQ2bmNUR09hNmIzY3cyVkNyb2tp?=
 =?utf-8?B?bnFiK2NHN3ErVXdiSS96N0U5cm5Fd1Bla2NmZkx5T1hFazBMQUlsNVJCYmNu?=
 =?utf-8?B?N1hmZWtoWXo5cXByaUtCS0dSc3lpUk5MNkp3OE50TE5ZNEdCa0lqOWtKT3Ns?=
 =?utf-8?B?SzRQSEUwRnZsMW84ZG5JbWxERVNDeUE0OS9OVis5TkxxL21McE96Y2JJc2tQ?=
 =?utf-8?B?L0NtRmNzbDRiWUUwb29rM0I3QTI5aTlmaFlQR0lWMHZxZEhiWEU5a1JmTno2?=
 =?utf-8?B?WG5rYnpRbTRkK2JZMmdBb0FmRG5ZUHpFbmtmRlgvNVRBNnd4Q1N5TXViOXND?=
 =?utf-8?B?Y3FFMCtGSDZyaFNSQWFLWDg2eThSRmZDdTFCN20yMTBMNG5zS281cUZNSXVp?=
 =?utf-8?B?U3IyT1dDYzZDa2ZKbnQ0VVlzWE80b1BsWC9DOHVyazlNQnpsMlFqS3oraXV4?=
 =?utf-8?B?TXNvZDlWNWxXNUhnMVlCZkkyWEljNXkwTk9uZ0dlZTAzTlhNWHVXejU4TTRO?=
 =?utf-8?B?ZnlFSXB3b2VJUk9zVldOalZGaDJNeDJXU2thOW9wK0tNblI3dWZmSXFYWWd1?=
 =?utf-8?Q?UbDc3uL2QL8Ne2v/Y5CDjUluC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39964d5-bbba-4fec-b726-08dc89becc5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 02:32:54.5139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEAOFvYS0fWtR43CzJy281l6i2pEHn7Ip3244ARR1TjCynBW7E4q9bCaa95SNlPb5zc0limfCOai2Yv0BsMV3/4vGkqmPr/L+syIruGRiYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDAwLzE3XSBBZGQgYSBo
b3N0IElPTU1VIGRldmljZSBhYnN0cmFjdGlvbiB0bw0KPmNoZWNrIHdpdGggdklPTU1VDQo+DQo+
SGkgWmhlbnpob25nLA0KPg0KPk9uIDYvNS8yNCAxMDozMCwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+PiBIaSwNCj4+DQo+PiBUaGlzIHNlcmllcyBpbnRyb2R1Y2UgYSBIb3N0SU9NTVVEZXZpY2Ug
YWJzdHJhY3Rpb24gYW5kIHN1Yi1jbGFzc2VzLg0KPj4gQWxzbyBIb3N0SU9NTVVEZXZpY2VDYXBz
IHN0cnVjdHVyZSBpbiBIb3N0SU9NTVVEZXZpY2UgYW5kIGEgbmV3DQo+aW50ZXJmYWNlDQo+PiBi
ZXR3ZWVuIHZJT01NVSBhbmQgSG9zdElPTU1VRGV2aWNlLg0KPj4NCj4+IEEgSG9zdElPTU1VRGV2
aWNlIGlzIGFuIGFic3RyYWN0aW9uIGZvciBhbiBhc3NpZ25lZCBkZXZpY2UgdGhhdCBpcw0KPnBy
b3RlY3RlZA0KPj4gYnkgYSBwaHlzaWNhbCBJT01NVSAoYWthIGhvc3QgSU9NTVUpLiBUaGUgdXNl
cnNwYWNlIGludGVyYWN0aW9uIHdpdGgNCj50aGlzDQo+PiBwaHlzaWNhbCBJT01NVSBjYW4gYmUg
ZG9uZSBlaXRoZXIgdGhyb3VnaCB0aGUgVkZJTyBJT01NVSB0eXBlIDENCj5sZWdhY3kNCj4+IGJh
Y2tlbmQgb3IgdGhlIG5ldyBpb21tdWZkIGJhY2tlbmQuIFRoZSBhc3NpZ25lZCBkZXZpY2UgY2Fu
IGJlIGEgVkZJTw0KPmRldmljZQ0KPj4gb3IgYSBWRFBBIGRldmljZS4gVGhlIEhvc3RJT01NVURl
dmljZSBpcyBuZWVkZWQgdG8gaW50ZXJhY3Qgd2l0aCB0aGUNCj5ob3N0DQo+PiBJT01NVSB0aGF0
IHByb3RlY3RzIHRoZSBhc3NpZ25lZCBkZXZpY2UuIEl0IGlzIGVzcGVjaWFsbHkgdXNlZnVsIHdo
ZW4gdGhlDQo+PiBkZXZpY2UgaXMgYWxzbyBwcm90ZWN0ZWQgYnkgYSB2aXJ0dWFsIElPTU1VIGFz
IHRoaXMgbGF0dGVyIHVzZSB0aGUNCj50cmFuc2xhdGlvbg0KPj4gc2VydmljZXMgb2YgdGhlIHBo
eXNpY2FsIElPTU1VIGFuZCBpcyBjb25zdHJhaW5lZCBieSBpdC4gSW4gdGhhdCBjb250ZXh0IHRo
ZQ0KPj4gSG9zdElPTU1VRGV2aWNlIGNhbiBiZSBwYXNzZWQgdG8gdGhlIHZpcnR1YWwgSU9NTVUg
dG8gY29sbGVjdCBwaHlzaWNhbA0KPklPTU1VDQo+PiBjYXBhYmlsaXRpZXMgc3VjaCBhcyB0aGUg
c3VwcG9ydGVkIGFkZHJlc3Mgd2lkdGguIEluIHRoZSBmdXR1cmUsIHRoZSB2aXJ0dWFsDQo+PiBJ
T01NVSB3aWxsIHVzZSB0aGUgSG9zdElPTU1VRGV2aWNlIHRvIHByb2dyYW0gdGhlIGd1ZXN0IHBh
Z2UgdGFibGVzDQo+aW4gdGhlDQo+PiBmaXJzdCB0cmFuc2xhdGlvbiBzdGFnZSBvZiB0aGUgcGh5
c2ljYWwgSU9NTVUuDQo+Pg0KPj4gSG9zdElPTU1VRGV2aWNlQ2xhc3M6OnJlYWxpemUoKSBpcyBp
bnRyb2R1Y2VkIHRvIGluaXRpYWxpemUNCj4+IEhvc3RJT01NVURldmljZUNhcHMgYW5kIG90aGVy
IGZpZWxkcyBvZiBIb3N0SU9NTVVEZXZpY2UgdmFyaWFudHMuDQo+Pg0KPj4gSG9zdElPTU1VRGV2
aWNlQ2xhc3M6OmdldF9jYXAoKSBpcyBpbnRyb2R1Y2VkIHRvIHF1ZXJ5IGhvc3QgSU9NTVUNCj4+
IGRldmljZSBjYXBhYmlsaXRpZXMuDQo+Pg0KPj4gVGhlIGNsYXNzIHRyZWUgaXMgYXMgYmVsb3c6
DQo+Pg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAuY2Fwcw0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgLnJlYWxpemUoKQ0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgLmdldF9jYXAoKQ0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwJDQo+PiBIb3N0SU9N
TVVEZXZpY2VMZWdhY3lWRklPICB7SG9zdElPTU1VRGV2aWNlTGVnYWN5VkRQQX0NCj5Ib3N0SU9N
TVVEZXZpY2VJT01NVUZEDQo+PiAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICB8IFsuaW9tbXVmZF0NCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgWy5kZXZpZF0NCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgWy5pb2FzX2lkXQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCBbLmF0dGFjaF9od3B0KCldDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IFsuZGV0
YWNoX2h3cHQoKV0NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZUlPTU1VRkRWRklPDQo+e0hv
c3RJT01NVURldmljZUlPTU1VRkRWRFBBfQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCBbLnZkZXZdICAgICAgICAgICAgICAgIHwgey52ZGV2fQ0KPj4NCj4+
ICogVGhlIGF0dHJpYnV0ZXMgaW4gW10gd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBuZXN0aW5nIHNl
cmllcy4NCj4+ICogVGhlIGNsYXNzZXMgaW4ge30gd2lsbCBiZSBpbXBsZW1lbnRlZCBpbiBmdXR1
cmUuDQo+PiAqIC52ZGV2IGluIGRpZmZlcmVudCBjbGFzcyBwb2ludHMgdG8gZGlmZmVyZW50IGFn
ZW50IGRldmljZSwNCj4+ICogaS5lLiwgVkZJT0RldmljZSBvciBWRFBBRGV2aWNlLg0KPj4NCj4+
IFBBVENIMS00OiBJbnRyb2R1Y2UgSG9zdElPTU1VRGV2aWNlIGFuZCBpdHMgc3ViIGNsYXNzZXMN
Cj4+IFBBVENINS0xMDogSW1wbGVtZW50IC5yZWFsaXplKCkgYW5kIC5nZXRfY2FwKCkgaGFuZGxl
cg0KPj4gUEFUQ0gxMS0xNDogQ3JlYXRlIEhvc3RJT01NVURldmljZSBpbnN0YW5jZSBhbmQgcGFz
cyB0byB2SU9NTVUNCj4+IFBBVENIMTUtMTc6IEltcGxlbWVudCBjb21wYXRpYmlsaXR5IGNoZWNr
IGJldHdlZW4gaG9zdCBJT01NVSBhbmQNCj52SU9NTVUoaW50ZWxfaW9tbXUpDQo+Pg0KPj4gVGVz
dCBkb25lOg0KPj4gbWFrZSBjaGVjaw0KPj4gdmZpbyBkZXZpY2UgaG90cGx1Zy91bnBsdWcgd2l0
aCBkaWZmZXJlbnQgYmFja2VuZCBvbiBsaW51eA0KPj4gcmVib290LCBrZXhlYw0KPj4gYnVpbGQg
dGVzdCBvbiBsaW51eCBhbmQgd2luZG93czExDQo+Pg0KPj4gUWVtdSBjb2RlIGNhbiBiZSBmb3Vu
ZCBhdDoNCj4+DQo+aHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpo
b25nL2lvbW11ZmRfbmVzdGluZ19wcmUNCj5xX3Y3DQo+Pg0KPj4gQmVzaWRlcyB0aGUgY29tcGF0
aWJpbGl0eSBjaGVjayBpbiB0aGlzIHNlcmllcywgaW4gbmVzdGluZyBzZXJpZXMsIHRoaXMNCj4+
IGhvc3QgSU9NTVUgZGV2aWNlIGlzIGV4dGVuZGVkIGZvciBtdWNoIHdpZGVyIHVzYWdlLiBGb3Ig
YW55b25lDQo+aW50ZXJlc3RlZA0KPj4gb24gdGhlIG5lc3Rpbmcgc2VyaWVzLCBoZXJlIGlzIHRo
ZSBsaW5rOg0KPj4NCj5odHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvdHJlZS96aGVu
emhvbmcvaW9tbXVmZF9uZXN0aW5nX3JmYw0KPnYyDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhv
bmcNCj4+DQo+PiBDaGFuZ2Vsb2c6DQo+PiB2NzoNCj4+IC0gZHJvcCBjb25maWcgQ09ORklHX0hP
U1RfSU9NTVVfREVWSUNFIChDw6lkcmljKQ0KPj4gLSBpbnRyb2R1Y2UgSE9TVF9JT01NVV9ERVZJ
Q0VfQ0FQX0FXX0JJVFNfTUFYIChFcmljKQ0KPj4gLSB1c2UgaW92YV9yYW5nZXMgbWV0aG9kIGlu
IGlvbW11ZmQucmVhbGl6ZSgpIChFcmljKQ0KPj4gLSBpbnRyb2R1Y2UgSG9zdElPTU1VRGV2aWNl
OjpuYW1lIHRvIGZhY2lsaXRhdGUgdHJhY2luZyAoRXJpYykNCj4+IC0gaW1wbGVtZW50IGEgY3Vz
dG9tIGRlc3Ryb3kgaGFzaCBmdW5jdGlvbiAoQ8OpZHJpYykNCj4+IC0gZHJvcCBWVERIb3N0SU9N
TVVEZXZpY2UgYW5kIHNhdmUgSG9zdElPTU1VRGV2aWNlIGluIGhhc2ggdGFibGUNCj4oRXJpYykN
Cj4+IC0gbW92ZSBwYXRjaDUgYWZ0ZXIgcGF0Y2gxIChFcmljKQ0KPj4gLSBzcXVhc2ggcGF0Y2gz
IGFuZCA0LCBzcXVhc2ggcGF0Y2gxMiBhbmQgMTMgKEVyaWMpDQo+PiAtIHJlZmluZSBjb21tZW50
cyAoRXJpYykNCj4+IC0gY29sbGVjdCBFcmljJ3MgUi1CDQo+DQo+Zm9yIHRoZSB3aG9sZSBzZXJp
ZXM6DQo+UmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0K
VGhhbmtzIEVyaWMuDQoNCj4NCj5JIGV4ZXJjaXNlZCBwYXJ0IG9mIGl0IHVzaW5nIHRoZSB2aXJ0
aW8taW9tbXUgYW5kIHRoaXMgc2VyaWVzIG9uIHRvcA0KPltSRkMgdjIgMC83XSBWSVJUSU8tSU9N
TVUvVkZJTzogRml4IGhvc3QgaW9tbXUgZ2VvbWV0cnkgaGFuZGxpbmcgZm9yDQo+aG90cGx1Z2dl
ZCBkZXZpY2VzDQoNCllvdSBhcmUgc3VwZXItZWZmaWNpZW508J+Yig0KDQpCUnMuDQpaaGVuemhv
bmcNCg==

