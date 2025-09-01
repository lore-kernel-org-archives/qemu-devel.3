Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2CECA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 05:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uswsO-000526-3L; Mon, 01 Sep 2025 01:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uswsM-00051m-43
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 01:14:42 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uswsI-0002Oh-7R
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 01:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756703678; x=1788239678;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U1Z376DnnFHOrnjGGcKq3lKdzTJZoleXrkGOIVkzS04=;
 b=YDvs0Us2EnxbtaI7G35bkqxVMqeG2kLzbISNzjmKrCJ9BBTX12k2aDIL
 I1FFucTxGgw0HT1MeF9CPkayjR8UoHg9vgYK4VB1R4QUrmoNJ2PWZXxvy
 OyNObEZpFlBrwV8+v0CLuht5TGm/HBTMxXZc98KD+t4FL5twY0Do5gQW/
 z5DKA3H5Sv2DLJKg52Zi643bVXBz8erXcV7wdvJaLi3pbiT/g+qfXI1yg
 GDU82n0ONPS7jepAWfcHC/cu3K4APG3daGcPfnj+n62gJGga67cNwhnRg
 fRacnTterG8Mjvq6oB1L6biSYnSFgiLzaybMKOjPtXaoZK1tAn5bLL6mQ g==;
X-CSE-ConnectionGUID: aP5ljaztSFSg10+hpI6foQ==
X-CSE-MsgGUID: wgeXxOiDSfiCzzK5sO5f5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58968015"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58968015"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 22:14:32 -0700
X-CSE-ConnectionGUID: XG7XUkNaStignYLabuoLeQ==
X-CSE-MsgGUID: PtHbuQvnRNGJAxPdMlNyDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="170125383"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 22:14:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 22:14:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 22:14:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.49)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 22:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwkw0rr5jTkx7qf/yYNqhiB6pYPVA9n2LPQn/F5f2Rf8+3oWIrpborSV3W700w8xpX8Dd48vp99mbfCMa1TeJKGIFKdXnskDk1UTNLZyEsj7SQdueN8Qx8RMNHpVlNIZC3yG3fRqftQInNS0rMOYGBXLDtyW13Yu9EvIu92QaMuhhrUdXCVgYv5HtFT3B352J/PnF4h2jU80oMwPdArbIpwtNc1YCYTNtVcL9PC+3XHoHHjIKD3XUYY6U1G7lyBfayoHkIhKCZ1NobOAwLoS8tF7t5MeRi5oxCWhl5M9H0QtKnK6AMrfXoUggR3Y2q057zLiHCPVYFYIX7AlgkvaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Z376DnnFHOrnjGGcKq3lKdzTJZoleXrkGOIVkzS04=;
 b=sEs/LJ0jUYKWLy1vEG1RB8/a/ctjDygiWSmUEP6PDCTxcMR0Phn/E3cG6RSf/Fv8284uJULijxSx/j9y9D42FowHTRbYlb3lCqrmzfBHagcX6Dluijco1ppwX12oRgybJ3U1wEM9IJ1jSZK4lRNckvcqZzAjLv1u++uyaY5rk4eYu1Tk8EPwUGM+NVcdACW5ZXhOEmmacSv+R8t0FFRBAdKdYsm7j2IiH/f28c7O2QfVvhCAnn2BdL0+369bkk0Ux4UXBABy4/mZPvexictQx2fZRkwB9s06LG8rmDXoWitOGuuQmv1yjNn/RB0yOAN3rF5xVf+EQYoByUJyiAwl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Mon, 1 Sep
 2025 05:14:25 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 05:14:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 09/21] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Thread-Topic: [PATCH v5 09/21] intel_iommu: Fail passthrough device under PCI
 bridge if x-flts=on
Thread-Index: AQHcEy/h6r1AzmVmi0aEsNEv/zDiE7R35+cAgAXvBvA=
Date: Mon, 1 Sep 2025 05:14:25 +0000
Message-ID: <IA3PR11MB9136095F7520975C74DAD2479207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-10-zhenzhong.duan@intel.com>
 <d470594c-959e-4cf7-a1a6-745c5671646f@intel.com>
In-Reply-To: <d470594c-959e-4cf7-a1a6-745c5671646f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB4778:EE_
x-ms-office365-filtering-correlation-id: 636bf0e5-5300-418c-1e92-08dde9166b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aUh0WkMwTDJLTW1yZXZKLzduRUZJNTFLa2p3dWNNZnI0bGxINjV4czVjU3h5?=
 =?utf-8?B?ZHRxMDdYbXdCWElmNXJIN1ZCR1B4REVRQmFyd1V2UUFQZnBXMkZ5enlSYTQ5?=
 =?utf-8?B?Ri9YQUtPL040cWNwR3QxbDIrMm1mSlJrVlVXcFlQZFA0NThPSlJrVjl3NVNt?=
 =?utf-8?B?eGEwdnJQSk96Y2pCdm91OFdlUkh3WXJya3M0a0g2YTBRcGRWbVNpemZLUGdy?=
 =?utf-8?B?c0EveGFvek1IcU10cFJoU0VQcjlpR2FKanpuWk4yV0xnUnJiRm1KVGJYYVRh?=
 =?utf-8?B?bDdHck8wR3pScmkzTHBNLzhYSG9RYUJrZ2ZKS3M0Z09CbFFONHpVWGdSODlr?=
 =?utf-8?B?TXdEQ1NtRE8rRncwQ0I1aGNpSGtOTDFMTjhkS2liUW1CTjl4Tm9DVjcwRDBz?=
 =?utf-8?B?a0VpdDc0VEx4ZXNvNGR6YVdQTW0rVHlrSmk1RmdXNWhkQnNsVnpwVEhPUVMy?=
 =?utf-8?B?RlpiT1hmSWdqR0R6VldZZTA2cTR3LzhBWUlkcXNxWWh6K25WWG8rSzZHamRr?=
 =?utf-8?B?Y1lRcVJJMkdNdTF2RFhOZHY0Z1J3aTZMRDdyMDV4RklIcXQwYnhRYkdQdnZo?=
 =?utf-8?B?YmdGdldTbmw2SWFzRVB2ekljamE1Z3kxcTF1d0tiaWxjMFYzYlR4azhNcDVZ?=
 =?utf-8?B?NkN3dm11MjYrb2pKcTNzUFFqemZZT1ZUS3NqZ1RNZzBpWDM0S01xKzBEOE1I?=
 =?utf-8?B?c0FhMCtCcHBxdEhkMkVQcHUrT095ckJhUDR4b3JQMmpteVUvOXNZVDg1UzdL?=
 =?utf-8?B?ejZvQzk0c25GdW80T216eGdyODVlWFRqQ2xxYmVRUWFYSi9YWHVwUjd4SFVF?=
 =?utf-8?B?cDBkR1BlK2lDb2RJSnUxTWRFZHRabEpodVlCOWJuWTFPei9rYjgwQXdQSGFp?=
 =?utf-8?B?bVBURG1IbUVySVF3cmlueWw1bS9YNmNQR2Rid2F0TEcvT1Z2S0h6eUkxTUZL?=
 =?utf-8?B?TFUyK3p1Ny80cFF5TElDTThzdHc5T0FPV3BJc3JGSDYxVTgrYkZXZnlpNVdV?=
 =?utf-8?B?UFdvR2xZT1ZyVzl6cUFZNTZuUWo2TGsxSTF5YzVkRlJraHhMbGFaOXJqRkpv?=
 =?utf-8?B?WUo1dWNUVUQ4czJwWGk2dDdqdVFkN3ZVcVNEM05ldUl1djNoeVZvU3QvVFVI?=
 =?utf-8?B?WG85OXBRaEx3Ymp3bkpXUWhlV1V2WWlSTC8zUkJmbC81cWRuYUI5bW53WjJa?=
 =?utf-8?B?RnNVSElkRHhhRCtOd21Zem0zNGRVVGNJVE93bHE2d3Z5VVZ1QkVMYXVZN3Vo?=
 =?utf-8?B?K3ZsNnRDM2ViSlZweWMyTnBxWkpMRC8zbnhWTFZ3b2tmKytUYWJqbGZIMFFi?=
 =?utf-8?B?RGVnMm45ME1sZEU2eDNUaUkrTWY0VG9SMUJpbmVMQ1NmWlJwNVVudjRuaGxZ?=
 =?utf-8?B?TVVMU3VOYk5CQk84NzhMVzZhQVFiZVJzQkU0REk3dTgzOEVlVE5VWVJPVUJN?=
 =?utf-8?B?SXJzMmJTSFp5U21hT0NCaTRDSENESFdqUFczV2RTTkxNNlh1ZzV0THVtNmdO?=
 =?utf-8?B?dGg0M0d5bEtPMy9PWEh4a1RVYUFLVlh4c01vMGlVSWxZbEdmMFk0Y05pOFdC?=
 =?utf-8?B?QzRJOVl0RHJ1QnltZXk0UzVKQzN4ZHFRVGtKMEF4QUhhRWxCMTJSQTFSeVAx?=
 =?utf-8?B?Wk14eXQ5UmkxT2lsNU5HRUZ6TlFYZzBZOGdqQ2FwN1A5L0pNczlXbllmbUJa?=
 =?utf-8?B?cTdHVENqVXVuVDNVc1pzU2k2bGR1TCtrTUJES2RsWHdKWXg4a04zQ0ZJeDkv?=
 =?utf-8?B?VWlFd2tCaEM1WXdZdWRQdWFEM3F4YjNNblBGQko4b1U5WXVCUEFkdUVsOEpO?=
 =?utf-8?B?dVNJRjl0Sy9TUVNBaFBSZnJKSVdUc1JwVnU1UStGamhGV3RrZVFJQmpyY1A2?=
 =?utf-8?B?d09yRGErc2pMUzNDTnFQZmYzSkZuSmMzMnU0eGtEYUNLazltYU96ZEZrbEUz?=
 =?utf-8?B?Q2VVcW9LZlpZejRyRUs0M0NhZnlJTS9uRXJkV1ZNa1hXSCtZQmVCUXFxczAw?=
 =?utf-8?Q?jSfdxsxtufJ/3m/uVBRwMW2tgHsMZI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0doL0RITE9Qamo1MEkza28rZXd5YUlDVW52R2NtdDV6bVFSQUo1dUdRVXRy?=
 =?utf-8?B?TVlUdk9zU0lJZmQ0c2pQcGVwVXN5d0FybTVRb0N1MGhScVQ0aTl2RTlFYWN2?=
 =?utf-8?B?VGJ3UkJWRHNKbFVMYnVOT0lTeVVzSTZscmxXc3RPMXdKVlZORzgwQWdrSlkr?=
 =?utf-8?B?cGVCamFXcDVLU0ZyNy8wRFFweFl3Qk51b3ZkTGNzS1FhWHpyM292RjR3UVE5?=
 =?utf-8?B?QUxVeGVsWEFtNFRraTdQZUlWZllYTkNwakN5ZHZvbHBXenRyVnY3R0VBTjgw?=
 =?utf-8?B?SGg1UWw4YjdiQW8vT0tMd2ZtR1p2bmlsUWxqcUxxc2g2VlRUQ2EzZGlyeUN1?=
 =?utf-8?B?dnpBT3FUYjVZc3ZFYXlPY0Y4WEhNV2ZQMjN4TzJnVEdqbkp0Zk50M3E1d0tH?=
 =?utf-8?B?SVFzZlZnVUhrK2hGVTJVNGNjZllaWDVVZ2JrMXVFWTJPYUtSV3U3bC8wRlFE?=
 =?utf-8?B?cTRuOGs5TFpSV2U5eWlWSUoyNUYycGlSTUdMUlZWQlMxaFdKdXVTR3hEc3BE?=
 =?utf-8?B?ZWZpYlo1ck5CVlRDZGVjNmcyUTdVdXc4NkdFeUNCbWNtMU9pNysyWW1GSGZY?=
 =?utf-8?B?TGpzL3NLbS9xa0FubUpIMGgvbXhzSjVaOHhoNUVZeTNGQVVOTWlrRWxpNlQy?=
 =?utf-8?B?T0t5VnN1bFBzY3RPQ0taT1QrNExtNzU2aEJFRlo0a0JvWGFobzdhNFFsUitQ?=
 =?utf-8?B?bkcyb2NudCtrTEpyQkVGTndsNXNtc1h0Slp0R001Y0NGNDZ0WUhtWG9wU0xX?=
 =?utf-8?B?QUMvdVpoTkFtU2RkUUI4MnBaR1RIV2RudEV3R0RrTHJWSEtmS0RPRE9iUnll?=
 =?utf-8?B?TmNSbU1GYVFrUUpHYTlOeTJoRXEvUXBZcnBRTnNtaFJMY1hXNWxMS3lYUnpq?=
 =?utf-8?B?N0hKbVczalg4MmRNQ3VhV011MU5vbDZHcUtaMGNPaFU0VjFpUU9GQlVIR2k3?=
 =?utf-8?B?RnA1OG5ucDNsRUZxc2NXVTRPVnFpUWlUaHpLZWU3bmwyZ1lMWHFmVWEyajkz?=
 =?utf-8?B?R3pEdTdGVWI4eUFaLzBuZDk3bkdPdTZFcGE2RVZWclo5MFprZTNqOTEzQThF?=
 =?utf-8?B?elVJNnRXSHpOUmc5N1RZZ25qaHA0MC9iOXUxeU1NTWVIRzRlWndYQTNLWmU3?=
 =?utf-8?B?L1IrbHFrOXlJUEdXT3VDeUpQMmE0elhNaGRYUCt6dDE2MjZEejF0Vlc0Zk1w?=
 =?utf-8?B?eXlqQnhsOGhsQ0c0NUtzWElQV1hzTk1pRFozU2Z1Y2sySzFzeHZOWHhQeEVq?=
 =?utf-8?B?eTlDRXNTeThJTE1VeWpsb0tTWDhDK2M0RlA0dGY1TkxiU1ZBUkJ4cnhzaTQz?=
 =?utf-8?B?czJxQU1nNTI0ckp6d0FRekMyT0tyRUk2TTRwNTVvcFdxSnhOLzdqQUlsQTN4?=
 =?utf-8?B?c1lnVFl5RzA1bGpSa2wxcVJUODVsVHBhektvSEtvL3pRc1NMZFdMZXlTQXpw?=
 =?utf-8?B?MnJhQmtMbHZEUFlGS3ovVVRmQVpFODRDQzFKa3VJZndvb05iZWdFL3RXekxq?=
 =?utf-8?B?MXp0V0R2VmxYTkpZRVFlOXpoZ3hGNkN2M3Zad28yNUpwenZxdzk2a0hqdlZo?=
 =?utf-8?B?bnRmMmRpK1NPdHN2Y1FhektNc2l3U2RYQkRyZ2FZL1YvcDY3b0J3QTc0WG9B?=
 =?utf-8?B?NTYweWN4RnFSbXZqbzNJd3BXVWJUbjF6ZUpKMEZPelZMNVZSeE1vRGVKRk9S?=
 =?utf-8?B?RHhsOTZUQXNIREZpOGxmYmQ1cThCc2xaL3VoYjhsSzRLb0lDRmtzOGo2QlI5?=
 =?utf-8?B?YVBlOXM4cFZUOU5ZcVFhRFhDcG9zUHhrTm1tMWlVTkRKSTNmejNFOU5EZGFj?=
 =?utf-8?B?NllVaUthL3M2dkdQU0FSV20zZ3E0VGR1c2J1MnFXa3p6V2tPUnB4bGtaY0wv?=
 =?utf-8?B?WnM0ckpGbmtlSnFpalozVXZZTEh2Vi9zdEpXUTFjZ05HaWJPUWhCZStMajFI?=
 =?utf-8?B?aEVEK2c2UkVLVnhVZ1JTZjZqdWFpSTlKcDM2ZXVYN3J5ZDkxQUFldmxKUGhQ?=
 =?utf-8?B?cE1ONHJRQzgxYVZoenkyZUpxQkVXQUZKQlFtSi8waXVkc1hCOEsrRHZxTkIx?=
 =?utf-8?B?cVh3SGpTM3ZHSFh4Nm5jeE1zR0d6UndwVHdPZFlIVnVmbUJIaThxRERtQ2E5?=
 =?utf-8?Q?brzps87I07DcgtQ0KCWrY4ccW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636bf0e5-5300-418c-1e92-08dde9166b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 05:14:25.1159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N25ridTsBF1m0jD22cQ7zxDBY4g9bv05Lha/ByCmmjcZAnmbOHi1KVtyz1w4fLMtF3ylgBTvteSaRtKfZI10ukTjKso25e62QXHofRxxSdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDkvMjFdIGludGVsX2lvbW11
OiBGYWlsIHBhc3N0aHJvdWdoIGRldmljZSB1bmRlciBQQ0kNCj5icmlkZ2UgaWYgeC1mbHRzPW9u
DQo+DQo+T24gMjAyNS84LzIyIDE0OjQwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEN1cnJl
bnRseSB3ZSBkb24ndCBzdXBwb3J0IG5lc3RlZCB0cmFuc2xhdGlvbiBmb3IgcGFzc3Rocm91Z2gg
ZGV2aWNlIHdpdGgNCj4+IGVtdWxhdGVkIGRldmljZSB1bmRlciBzYW1lIFBDSSBicmlkZ2UsIGJl
Y2F1c2UgdGhleSByZXF1aXJlIGRpZmZlcmVudA0KPmFkZHJlc3MNCj4+IHNwYWNlIHdoZW4geC1m
bHRzPW9uLg0KPj4NCj4+IEluIHRoZW9yeSwgd2UgZG8gc3VwcG9ydCBpZiBkZXZpY2VzIHVuZGVy
IHNhbWUgUENJIGJyaWRnZSBhcmUgYWxsDQo+cGFzc3Rocm91Z2gNCj4+IGRldmljZXMuIEJ1dCBl
bXVsYXRlZCBkZXZpY2UgY2FuIGJlIGhvdHBsdWdnZWQgdW5kZXIgc2FtZSBicmlkZ2UuIFRvDQo+
c2ltcGxpZnksDQo+PiBqdXN0IGZvcmJpZCBwYXNzdGhyb3VnaCBkZXZpY2UgdW5kZXIgUENJIGJy
aWRnZSBubyBtYXR0ZXIgaWYgdGhlcmUgaXMsIG9yIHdpbGwNCj4+IGJlIGVtdWxhdGVkIGRldmlj
ZXMgdW5kZXIgc2FtZSBicmlkZ2UuIFRoaXMgaXMgYWNjZXB0YWJsZSBiZWNhdXNlIFBDSUUNCj5i
cmlkZ2UNCj4+IGlzIG1vcmUgcG9wdWxhciB0aGFuIFBDSSBicmlkZ2Ugbm93Lg0KPj4NCj4+IFN1
Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11LmMgfCAxMyArKysrKysrKysrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IGRh
MzU1YmRhNzkuLjZlZGQ5MWQ5NGUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTQzNDEsOSArNDM0MSwx
MCBAQCBWVERBZGRyZXNzU3BhY2UNCj4qdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAq
cywgUENJQnVzICpidXMsDQo+PiAgICAgICByZXR1cm4gdnRkX2Rldl9hczsNCj4+ICAgfQ0KPj4N
Cj4+IC1zdGF0aWMgYm9vbCB2dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3RhdGUgKnMsIEhvc3RJ
T01NVURldmljZQ0KPipoaW9kLA0KPj4gK3N0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVs
SU9NTVVTdGF0ZSAqcywgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICsgICAgSG9z
dElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hpb2QtPmhpb2Q7DQo+PiAgICAgICBIb3N0SU9NTVVE
ZXZpY2VDbGFzcyAqaGlvZGMgPQ0KPkhPU1RfSU9NTVVfREVWSUNFX0dFVF9DTEFTUyhoaW9kKTsN
Cj4+ICAgICAgIGludCByZXQ7DQo+Pg0KPj4gQEAgLTQzNzAsNiArNDM3MSw4IEBAIHN0YXRpYyBi
b29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9NTVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZpY2Ug
Kmhpb2QsDQo+PiAgICNpZmRlZiBDT05GSUdfSU9NTVVGRA0KPj4gICAgICAgc3RydWN0IEhvc3RJ
T01NVURldmljZUNhcHMgKmNhcHMgPSAmaGlvZC0+Y2FwczsNCj4+ICAgICAgIHN0cnVjdCBpb21t
dV9od19pbmZvX3Z0ZCAqdnRkID0gJmNhcHMtPnZlbmRvcl9jYXBzLnZ0ZDsNCj4+ICsgICAgUENJ
QnVzICpidXMgPSB2dGRfaGlvZC0+YnVzOw0KPj4gKyAgICBQQ0lEZXZpY2UgKnBkZXYgPSBwY2lf
ZmluZF9kZXZpY2UoYnVzLCBwY2lfYnVzX251bShidXMpLA0KPnZ0ZF9oaW9kLT5kZXZmbik7DQo+
DQo+cGNpX2ZpbmRfZGV2aWNlKCkgZmluZHMgYnVzIHBvaW50ZXIgd2l0aCBidXNfbnVtLCB0aGlz
IGNhbiBiZSBhdm9pZGVkDQo+YXMgeW91IGFscmVhZHkgaGF2ZSBidXMgcG9pbnRlci4gUGVyaGFw
cyB0aGlzIG1heSBiZSBkb25lIGJ5IHdyYXBwaW5nDQo+YnVzLT5kZXZpY2VzW2RldmZuXSB0byBh
IGhlbHBlci4gRXNwZWNpYWxseSwgcGNpX2J1c19udW0oKSBtYXkgbm90IGhhdmUNCj50aGUgY29y
cmVjdCBidXMgbnVtYmVyIGF0IHRoaXMgcG9pbnQuDQoNCkluZGVlZCwgd2lsbCBkbywganVzdCBw
ZGV2PWJ1cy0+ZGV2aWNlc1tkZXZmbl0gc2hvdWxkIHdvcmsuDQoNClRoYW5rcw0KWmhlbnpob25n
DQoNCj4NCj4+DQo+PiAgICAgICAvKiBSZW1haW5pbmcgY2hlY2tzIGFyZSBhbGwgc3RhZ2UtMSB0
cmFuc2xhdGlvbiBzcGVjaWZpYyAqLw0KPj4gICAgICAgaWYgKCFvYmplY3RfZHluYW1pY19jYXN0
KE9CSkVDVChoaW9kKSwNCj5UWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQpKSB7DQo+PiBA
QCAtNDM5Miw2ICs0Mzk1LDEyIEBAIHN0YXRpYyBib29sIHZ0ZF9jaGVja19oaW9kKEludGVsSU9N
TVVTdGF0ZSAqcywNCj5Ib3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+PiAgICAgICAgICAgZXJyb3Jf
c2V0ZyhlcnJwLCAiU3RhZ2UtMSAxR0IgaHVnZSBwYWdlIGlzIHVuc3VwcG9ydGVkIGJ5DQo+aG9z
dCBJT01NVSIpOw0KPj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgIH0NCj4+ICsN
Cj4+ICsgICAgaWYgKHBjaV9kZXZpY2VfZ2V0X2lvbW11X2J1c19kZXZmbihwZGV2LCAmYnVzLCBO
VUxMLCBOVUxMKSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSG9zdCBkZXZpY2Ug
dW5kZXIgUENJIGJyaWRnZSBpcyB1bnN1cHBvcnRlZCAiDQo+PiArICAgICAgICAgICAgICAgICAg
ICJ3aGVuIHgtZmx0cz1vbiIpOw0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9
DQo+PiAgICNlbmRpZg0KPj4NCj4+ICAgICAgIGVycm9yX3NldGcoZXJycCwgImhvc3QgSU9NTVUg
aXMgaW5jb21wYXRpYmxlIHdpdGggc3RhZ2UtMQ0KPnRyYW5zbGF0aW9uIik7DQo+PiBAQCAtNDQy
NSw3ICs0NDM0LDcgQEAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1
cw0KPipidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLA0KPj4gICAgICAgdnRkX2hpb2QtPmlv
bW11X3N0YXRlID0gczsNCj4+ICAgICAgIHZ0ZF9oaW9kLT5oaW9kID0gaGlvZDsNCj4+DQo+PiAt
ICAgIGlmICghdnRkX2NoZWNrX2hpb2QocywgaGlvZCwgZXJycCkpIHsNCj4+ICsgICAgaWYgKCF2
dGRfY2hlY2tfaGlvZChzLCB2dGRfaGlvZCwgZXJycCkpIHsNCj4+ICAgICAgICAgICBnX2ZyZWUo
dnRkX2hpb2QpOw0KPj4gICAgICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPg0KPm90aGVyIHBhcnRzIGxvb2tzIGdvb2QgdG8gbWUuDQo+DQo+
UmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0K

