Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7BBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcm2-0001bF-KY; Tue, 28 Oct 2025 02:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDcln-0001OB-2l
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:01:23 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDcle-0005bI-0L
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761631274; x=1793167274;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5fxQvrw1a9Tt5wMIlvUd6erMOEFQH9cCBWuD9bz9/VA=;
 b=ZNv5/whHrDoap6rHtDY4yi8JcSL72SgEXH40QXnI3yQrRxSsyY+ZSfYH
 Jkcho+gpT0B23e1KKbXJtQ98fwJdfF0w1yxnupjJ0TUgPpRslPiLd075I
 M1HyRZ8S/cqrkOOSQvttsO8d/LyVI1t6ycPtfsY65EuiH838FIHeH450a
 OUWkTF+TuhESh0OJUBgJlipYB0YJfJ3H6wyh692cromcApXU3Ti1BEcwv
 dIylCDdPreQB9+vS6wZyW0NEWTu86Le+kVN062qfYT1uoEJqFCwZ6HfvM
 PTmT6n6pnE+YR9kuESBka96FF6Xq7QYe1LmKh3NbpugEqjt84IHkcMAqW w==;
X-CSE-ConnectionGUID: AH/RJj3qRDGzk1hPiXGvxA==
X-CSE-MsgGUID: ki0kpOHJS/e0RE2NgeuI+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74009640"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="74009640"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 23:01:09 -0700
X-CSE-ConnectionGUID: nPJ9LlITSz2/dgHCwc7w/g==
X-CSE-MsgGUID: rlr/GteaQo2P4BanzwnJCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; d="scan'208";a="184954887"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 23:01:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:01:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 23:01:04 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 23:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K25N5k+aKwprNffebZo4vXBMZbqmnFLgxANoES/Kmviu3aTcHJLrQx/5IZc9MEk+LMMcu/MbsKFCEcxzW6lP1pGpJy2w7thsYcELEDD1fBlHKHKM9/8JT8hHRmnEiQw5aJb2fpJvUWaH2839cWs7Sn2LE3yo9oThK7dSuan1+MfKeU6tG+9XJbxgudRCI50eswiJ3SozfwY3eVQYeVhyNXbeTx/YcA3dyqov5lnQnGIm0gOhdPlsG45RLlrMOJWxuwTfupAFs5eEBarBTo2nvkh/l/dKAsyvs1lSjijzPERl98dZroUaoPpZH0rVqgUaHV4ZK3Jd7wlGqZgJVgCS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fxQvrw1a9Tt5wMIlvUd6erMOEFQH9cCBWuD9bz9/VA=;
 b=w8UXzroLOhtUxD6xrbVEqCdD9pkn9RQCYboGH1T+zta7n8gI5mGrsDFj/irctZvVy/LDiGQDmhMu5CZ+xYRnKlfmZHrBRCHn5Ae7OoCKoJcLWHcHL0SZhBVHlEukt55PHTEuF/Fy1tyyNjgEE+g/BMHCF+0VDkqhl4f7gP6Mz1VV9zr/3EM5hcMGnno0SDXxzaCkIqyynvFK15GD4AStZUB8T4BIJQS8JbY0EcXA22PaUhhyFvJvLNr+MJJJdZi9Wihp/CBcCi9khIvRcQV6CyUP5W2V0xdgy2KloHJEPXDQPM/TZ6BJES8q5iXn9JtC4ItcMHvtO2tPLF9WViIv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 06:01:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 06:01:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 12/23] intel_iommu: Add some macros and inline functions
Thread-Topic: [PATCH v7 12/23] intel_iommu: Add some macros and inline
 functions
Thread-Index: AQHcRMKRdjBWkWbHEUmpCsPDnypQ+bTRgAiAgAWWu2A=
Date: Tue, 28 Oct 2025 06:01:00 +0000
Message-ID: <IA3PR11MB91363FF8EB61FE77AEBAD9B392FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-13-zhenzhong.duan@intel.com>
 <deafd3cd-481d-429d-a658-670886010f71@redhat.com>
In-Reply-To: <deafd3cd-481d-429d-a658-670886010f71@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5044:EE_
x-ms-office365-filtering-correlation-id: 63b80383-6b45-441c-a8c8-08de15e75f05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WDkvK3pQSE1CT1FEcmRQejY4aDlKTHJtZTRjbEd4dDhIZ0pUL3Vob1BEVmo5?=
 =?utf-8?B?bDVERWpkQ1RYK3YycytCUFM0TDRPS2RTYmRhRWcxd3NWMHNYbzJBL2taL3la?=
 =?utf-8?B?Uk5QZExKUzlHM253QXJkVjcyR0tBNHB5eWl2L0E4M280cERwT3BqRjROVkhy?=
 =?utf-8?B?bEQxNmtBdnZiSm1aYkxFRTJ1RUR5Rm5GOG0zOUdPdk1jZHRIU3NZYnFJWEM5?=
 =?utf-8?B?YWpRWlcxT2JTVVBEY0hwdFZtdzRkejhzZlNwSjZDNFhrMDVpVmJZNURUbkRo?=
 =?utf-8?B?b2d3NHRCZndqUHVMczdsb2F1V3Z6QzVBcVhHWGFpY0o0QkEwSVliczJiZFNI?=
 =?utf-8?B?WklzYk5pSDhyU0Z6QmIzZnY5ZUoyZ2pObnRuTUV5K3Myb2tCVkRyQWR4Qk9Z?=
 =?utf-8?B?Y0MzZXRRUVNua1RzanB2SVdZaS83ZXFacUNndTJDbnJSaUQxTlRQZmQ1dmhQ?=
 =?utf-8?B?TnZPbmFQd24zZUZOQ1JYMXJ0eThFeFNGZWRYdzZkZ1oxQmdSZEpkRTZFMExF?=
 =?utf-8?B?OTdoL2Q3eXIzL0pWR2JyYks3Sm5XaFk4STlNNDJ6d3A1QVl5dWtQRHQwaElj?=
 =?utf-8?B?OEN5VXFHY1FyanlFL3VlMzNidEI2WEVhZVZ4REdQKzlvbkNhOFcrUHpmTWZw?=
 =?utf-8?B?eGo2Njk1YmMvNnNVUVUzSzlUT3NldFo3SWlFNnFseTdMTjlXY04rWlR5VS95?=
 =?utf-8?B?ZXgyNUtaWW1UdWp3TjBOcnBSQlRiM0dVNnRpeklRNFFFNS9DakhsOFIxZ3VD?=
 =?utf-8?B?bFhDNENzS2hRYnR1bUlNU2pHTFU3N25tMEtFMUZic05naWxUVlNYc2VxUkxz?=
 =?utf-8?B?UlhVK0RJR096ZEJYVTRORys2QlNvaGY2Ui9EQ1h6dWsralpyNlBwenp0WjRJ?=
 =?utf-8?B?S2VNNzZCSDMwbjQ5U3ZSaU9uQTJXdWRyOUs1ZTJFWEtobGpTYUhMVjF0TUlm?=
 =?utf-8?B?RldhMzZLOGhrZGxMdklJUjl2UFR6U2xpRDlWODh6eDJCQ29TNUN1TURuNTJH?=
 =?utf-8?B?d3lQUm8yZktFSFdVdEp0Sk5DZGJSa3ZocjYvbGduOGRjajJZNGI2enJlYnd0?=
 =?utf-8?B?MzluYzVzMDBqQWJUVE1pL1lWZXhDakVTOHFRRFd1MWE0aGh1TWhlNlZhcFdq?=
 =?utf-8?B?S3c0cStkWTZ4YTAwRDFDSzhMVTZ5Y1VkL0d3YTBFNEJHK2ZUcTJkcW1Eblph?=
 =?utf-8?B?NWZEUFk1TEIvNzduN1V5R0hGbHZrNTJaVWVYcnlkUHM2aWdFVkFFYXZVVVAr?=
 =?utf-8?B?VFhHdGVUZVcrT3QyaDBBVHc1QWp3ak1Hd3l0dHROWEJVTlJGVTFiOUk0Sng2?=
 =?utf-8?B?S2o4MlB5UUk1ZExLREU5aC9uZ2NJQU9xdityeCtnRll0VXpabzE3djgrT0tL?=
 =?utf-8?B?L1FXM2wyekJkdm0xWGFoaHl4WmV5N0g4ajVldlA3Nk5kYkdEVWN6U2JpM3J4?=
 =?utf-8?B?cGdCVitNTHJhZFZUdFlLZG1STklIRWxncnVPL2ZVQjg5MlllNUduczdqY285?=
 =?utf-8?B?d0lQTGxRK29LMDFpV1dZbUEwRWR0dXRiQW5KbmRaKzZYMGxLZGY2aU40ZW1q?=
 =?utf-8?B?YVBobjMxdnVxQWtvaUE4TWZLRkhNZzV4SjhtTHhmNVZ1YjYvMTY0QTNkZHov?=
 =?utf-8?B?NmUxamt2bHdsMGpEREp6MnNWeHM0RERDcUc0SDlRQ1p5dXFsSTRjVFYyTmNM?=
 =?utf-8?B?NzNzVUxvYU1UbDk3RGlqdnJFc0krUm5XaC9WZ3RmQTZYYVMzZWtwejBTUzlz?=
 =?utf-8?B?bFk3NkNQSWNvc1hNNHRyVjhidlJqOHpBVUozU3AzeFpURHpPQk8wc3MxN2dL?=
 =?utf-8?B?VUl6TFJZRHY1aVpqMDZEd1hRMkVHVTZPc2U3L3lxNkdoL29XY0F6a0twakpm?=
 =?utf-8?B?SktqaHVJbU1Wa21EL01SbEQzMklvejdBSGROc3FncXFtSFRvUmw5UE90Nldv?=
 =?utf-8?B?TzdDN3J1di8vRGVCMnVsZk05Ti92WGp3dXJOL0ZBR2VqK1ZrcXNKblRCa2FC?=
 =?utf-8?B?b1MrVlNYSUlGNVY3aU5tUHhVc1NNdTJVU3ZlK1pPSlhuQkZrbTEyR09JckRv?=
 =?utf-8?Q?6lWFA1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHJJY1BUMWg4bFl3OVh3ZEZXNGJ6NmR5OVU1VmhwQXN1a3pNQVg3ZlZiRWZI?=
 =?utf-8?B?WHNhaFo4M1RranRNbjlyL3BISXN0dzBScDBrUDdsOU5HbG9laFpTYlpKeDVS?=
 =?utf-8?B?b2k1T3B2dm5Ia1o1T3ppalk2RnkxejVJQkhXWFNGdTJMMCtuTC9DOTMrelFI?=
 =?utf-8?B?RHN3bjhSN1RJL1VVSVdWd0RSRVRFL3FzLzNyUnd1YjU1OGRPZHJ0Tk82NTd6?=
 =?utf-8?B?RUU5LzljNHFwcnB1VEc3KzNBUC80TVFXa0t6Z3RpMXErLzg5SW5EWk1hUmZG?=
 =?utf-8?B?cjFLYTZEOGpoTksvNjJ5UTNuVHFKa1BYWVNtdE8wdHNYRTlwUXlOc3pLYmw5?=
 =?utf-8?B?eVN1MWdnbDNRUWlwSVhDYnhHOVR0QmtNZW9sOHl2bHp0R3AwL01lbG9IQlFR?=
 =?utf-8?B?bUNLZEpLWGp2L1Viak56L2FNYk9VSWxXdmxDMncvUitUcS92WmphWEhiVytE?=
 =?utf-8?B?bGdUWEgrdjFUbXJlRkJzRnFYMzVtZjkzeU8wY3FtZ1haSVRETGlxSzA0ZGln?=
 =?utf-8?B?bTFsZHhZd1RkUm5qaFd1bS9Qcmo5REZGTUpOZGNPSnowdHhyM2FMbFhhMGh3?=
 =?utf-8?B?cFlyOTYzZHhXMlpWMks1ZXFxSkNtZ2NvcUl2NzQ4Zy9jSk1WWmRLTEE3NTlB?=
 =?utf-8?B?aVhnbWNtQlJOdHJXNFdoRlhlYWpzNmJ5NThXRyt3K0ZRR3p3c2VWYTk0Si9N?=
 =?utf-8?B?RFduaVBPTDBlU09EeVRGcFVzVnB4b2R3SmYwcGppaUM2ODZuSWNYS0VSR3Jr?=
 =?utf-8?B?N08xM3BBSENraFhRTzduOGpYQVZISktTMEFzbDN6Qm9OYlBvZWRTalVaa3VC?=
 =?utf-8?B?YVZ1Uzl5R0RETXU3cjJlMlhkcFNSeGovUUVTNlJYM2ZYTmxpSWMyMjdLbUJp?=
 =?utf-8?B?MGtST0JnZmhiTTRjWElHdlpnZ0UxSXZNaXAvT1J2MStNZ1oyc2VGdkFLbmtI?=
 =?utf-8?B?cnVvakE4Tk12NGF3YlR2SmVLMDI5akI2OU10NE44WUFGOUgxQUVpR21jcU51?=
 =?utf-8?B?OUpjN1EwVDdwL0dybmt4SEZmMWU5enZhOFFGTVlTYlBFZkl4VFMvdStwMU80?=
 =?utf-8?B?YzFjWkNnai93Yk16VVdUcjZpMFBub3ZZWUNKWnVYbmY3TFJpQUkvU2M2QVl4?=
 =?utf-8?B?ZW1ocmxKVmIzTmJkUW02VHBZOVBxNzN2YzFyUmJXVnBJS3dHQ1R1dDNQR1Aw?=
 =?utf-8?B?RGxDOWNJcU8wVnB5RER1dFczYXZuQ0VoWDhmN2xlekFoeVVUaldCOVgyZTRW?=
 =?utf-8?B?SjNKMGl3b2s4V0xwN3lYSGN6SXJQd2pSaFRneGtxNEdIS3pHNkc5N1lTWnhx?=
 =?utf-8?B?TUIrZERERnNKRFp6c0R4cU9tVldKdmQyMEZiQkpPN3R2S1ROYmRjSlBleTlZ?=
 =?utf-8?B?NHNYcE1jd0ExMjR6K2MvRTZOVENxaTlGSjl5djlObWVKUFNyOFJUWm40dzda?=
 =?utf-8?B?QVdEKzJUVTdxc25FejJSY1Z6VWJRYm14WTBsc1VIRGVEdWhhajdUZXp2S2Zr?=
 =?utf-8?B?eDZ5T2IrZlZ1RmVGOVV1VS92cjJJL2YvcURhRGJFUk5pVjFtS3hva3NGQWlV?=
 =?utf-8?B?cG9leC9aa0pZRU1xSndGcTBtVVpNSERtSmwvNERxZ2dsT3dLaTlpUEdGbDE1?=
 =?utf-8?B?S08xZ3dOS2s3QWJZSHYzb2x0Z3JLYVpxMU94VElxOWZhNzZVUHpGTHdtRldX?=
 =?utf-8?B?bktVUHNqQmxGcThPMXk4cit1RXI4Yjh1aVVOUGtvWUJRTlNmZCtWb1FWVHUy?=
 =?utf-8?B?THV6NklGVFphRk40SVhEK1hxVjJOY2JsK0pCTzIwd2c1ZnZRakRzZjR1TU5E?=
 =?utf-8?B?ZGpMaE5WTWlXeldEWDVoT0VWNGZ1K1A2WStGVVFIODVVamd5ZFZFQ3BWTTZx?=
 =?utf-8?B?dUk2UXJ4aHFLWCtHTk45NHhrMVR1N2k5Y1JoZmdjMUFPeXo2NlgyMGttaHFk?=
 =?utf-8?B?M2hYU1dsUEl5Qm41UnVWblhOSWZvMm8rdHhjakc0TU8wY0RBNkd1OW9vUFpP?=
 =?utf-8?B?YXRMczM5ajRabm9lUWNyTWVLMDlKQ2hWa2doV0F6VHYwZElrSUZQS0ViK0JY?=
 =?utf-8?B?YmIrdTExRytjMzFvNGc4YUhid2RDblpTWTN6aU0yeUk4OFNFZWhSSTczTGRv?=
 =?utf-8?Q?sjkWZgT3aY3F1C8ORSzMow3UQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b80383-6b45-441c-a8c8-08de15e75f05
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 06:01:00.8789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYflTNDL+OUDBIiIld8EfpsA72xrNRsezGpwpa+jCm0GWd1F397t/Uf/mt4eFhtIVWYAtiDFKjikqaJNaEBWkS6ywwj/mmmGIJbk0CyfSAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDEyLzIzXSBpbnRlbF9p
b21tdTogQWRkIHNvbWUgbWFjcm9zIGFuZCBpbmxpbmUNCj5mdW5jdGlvbnMNCj4NCj5PbiAxMC8y
NC8yNSAxMDo0MywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBZGQgc29tZSBtYWNyb3MgYW5k
IGlubGluZSBmdW5jdGlvbnMgdGhhdCB3aWxsIGJlIHVzZWQgYnkgZm9sbG93aW5nDQo+PiBwYXRj
aC4NCj4+DQo+PiBUaGlzIHBhdGNoIGFsc28gbWFrZSBhIGNsZWFudXAgdG8gY2hhbmdlIG1hY3Jv
DQo+VlREX1NNX1BBU0lEX0VOVFJZX0RJRA0KPj4gYW5kIFZURF9TTV9QQVNJRF9FTlRSWV9GU1BN
IHRvIHVzZSBleHRyYWN0NjQoKSBqdXN0IGxpa2Ugd2hhdCBzbW11DQo+ZG9lcywNCj4+IGJlY2F1
c2UgdGhleSBhcmUgZWl0aGVyIHVzZWQgaW4gZm9sbG93aW5nIHBhdGNoZXMgb3IgdXNlZCBpbmRp
cmVjdGx5IGJ5DQo+PiBuZXcgaW50cm9kdWNlZCBpbmxpbmUgZnVuY3Rpb25zLiBCdXQgd2UgZG9l
c24ndCBhaW0gdG8gY2hhbmdlIHRoZSBodWdlDQo+PiBhbW91bnQgb2YgYml0IG1hc2sgc3R5bGUg
bWFjcm8gZGVmaW5pdGlvbnMgaW4gdGhpcyBwYXRjaCwgdGhhdCBzaG91bGQgYmUNCj4+IGluIGEg
c2VwYXJhdGUgcGF0Y2guDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50
ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA4
ICsrKysrLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMzgNCj4rKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMzcg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCj4+IGluZGV4IDA5ZWRiYTgxZTIuLmRmODBhZjgzOWQgMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPj4gQEAgLTY0MiwxMCArNjQyLDE0IEBAIHR5cGVkZWYgc3RydWN0IFZURFBB
U0lEQ2FjaGVJbmZvIHsNCj4+ICAgI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfUFQgICAgICAg
ICAgKDRVTEwgPDwgNikNCj4+DQo+PiAgICNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX0FXICAg
ICAgICAgIDdVTEwgLyogQWRqdXN0ZWQNCj5ndWVzdC1hZGRyZXNzLXdpZHRoICovDQo+PiAtI2Rl
ZmluZSBWVERfU01fUEFTSURfRU5UUllfRElEKHZhbCkgICAgKCh2YWwpICYNCj5WVERfRE9NQUlO
X0lEX01BU0spDQo+PiArI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfRElEKHgpICAgICAgZXh0
cmFjdDY0KCh4KS0+dmFsWzFdLCAwLCAxNikNCj4+DQo+PiAtI2RlZmluZSBWVERfU01fUEFTSURf
RU5UUllfRlNQTSAgICAgICAgICAzVUxMDQo+PiAgICNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZ
X0ZTUFRQVFIgICAgICAgKH4weGZmZlVMTCkNCj4+ICsjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRS
WV9TUkVfQklUKHgpICAgIGV4dHJhY3Q2NCgoeCktPnZhbFsyXSwgMCwgMSkNCj4+ICsvKiAwMDog
NC1sZXZlbCBwYWdpbmcsIDAxOiA1LWxldmVsIHBhZ2luZywgMTAtMTE6IFJlc2VydmVkICovDQo+
PiArI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfRlNQTSh4KSAgICAgICBleHRyYWN0NjQoKHgp
LT52YWxbMl0sIDIsDQo+MikNCj4+ICsjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9XUEVfQklU
KHgpICAgIGV4dHJhY3Q2NCgoeCktPnZhbFsyXSwgNCwNCj4xKQ0KPj4gKyNkZWZpbmUgVlREX1NN
X1BBU0lEX0VOVFJZX0VBRkVfQklUKHgpICAgZXh0cmFjdDY0KCh4KS0+dmFsWzJdLCA3LCAxKQ0K
Pj4NCj4+ICAgLyogRmlyc3QgU3RhZ2UgUGFnaW5nIFN0cnVjdHVyZSAqLw0KPj4gICAvKiBNYXNr
cyBmb3IgRmlyc3QgU3RhZ2UgUGFnaW5nIEVudHJ5ICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA1NmFiYmI5
OTFkLi44NzFlNmFhZDE5IDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC01Miw4ICs1Miw3IEBADQo+Pg0K
Pj4gICAvKiBwZSBvcGVyYXRpb25zICovDQo+PiAgICNkZWZpbmUgVlREX1BFX0dFVF9UWVBFKHBl
KSAoKHBlKS0+dmFsWzBdICYNCj5WVERfU01fUEFTSURfRU5UUllfUEdUVCkNCj4+IC0jZGVmaW5l
IFZURF9QRV9HRVRfRlNfTEVWRUwocGUpIFwNCj4+IC0gICAgKDQgKyAoKChwZSktPnZhbFsyXSA+
PiAyKSAmIFZURF9TTV9QQVNJRF9FTlRSWV9GU1BNKSkNCj4+ICsjZGVmaW5lIFZURF9QRV9HRVRf
RlNfTEVWRUwocGUpIChWVERfU01fUEFTSURfRU5UUllfRlNQTShwZSkgKw0KPjQpDQo+PiAgICNk
ZWZpbmUgVlREX1BFX0dFVF9TU19MRVZFTChwZSkgXA0KPj4gICAgICAgKDIgKyAoKChwZSktPnZh
bFswXSA+PiAyKSAmIFZURF9TTV9QQVNJRF9FTlRSWV9BVykpDQo+Pg0KPj4gQEAgLTgzNyw2ICs4
MzYsMzEgQEAgc3RhdGljIGlubGluZSBib29sDQo+dnRkX3BlX3R5cGVfY2hlY2soSW50ZWxJT01N
VVN0YXRlICpzLCBWVERQQVNJREVudHJ5ICpwZSkNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4+
ICtzdGF0aWMgaW5saW5lIGRtYV9hZGRyX3QgdnRkX3BlX2dldF9mc3B0X2Jhc2UoVlREUEFTSURF
bnRyeSAqcGUpDQo+PiArew0KPj4gKyAgICByZXR1cm4gcGUtPnZhbFsyXSAmIFZURF9TTV9QQVNJ
RF9FTlRSWV9GU1BUUFRSOw0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4gKyAqIEZpcnN0IHN0YWdl
IElPVkEgYWRkcmVzcyB3aWR0aDogNDggYml0cyBmb3IgNC1sZXZlbCBwYWdpbmcoRlNQTT0wMCkN
Cj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3IGJpdHMgZm9yIDUtbGV2
ZWwNCj5wYWdpbmcoRlNQTT0wMSkNCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW5saW5lIHVpbnQzMl90
IHZ0ZF9wZV9nZXRfZnNfYXcoVlREUEFTSURFbnRyeSAqcGUpDQo+PiArew0KPj4gKyAgICByZXR1
cm4gNDggKyBWVERfU01fUEFTSURfRU5UUllfRlNQTShwZSkgKiA5Ow0KPg0KPg0KPkNhbid0IHdl
IHVzZSBWVERfSE9TVF9BV180OEJJVCBoZXJlID8NCg0KV2lsbCBkby4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

