Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0934ECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 08:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sna1f-0003ur-AQ; Mon, 09 Sep 2024 04:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sna1d-0003po-Ra
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:45:33 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sna1c-0001Ej-2s
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 04:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725871532; x=1757407532;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PqZRKQaAr1xdrICNNnYRpcLWkIYhMnMkQnfKJtx+cDc=;
 b=jY7dLItfqKizcnLjRUSBVfR6I/NO9NY7iJaHDbPdsWNITtJnTW86QcKQ
 qgPIIGalSg+nWOYx9pxNw50vIjBNAOeFzDxxLxeb5NB8Uo0XrE/OocNuI
 OOSD9RWOneTvV9DiCgZ8+V7UPd8gujJ1ab1ZtwzBIPSYWHK5PiFa8S1M2
 LDXuUcuDLfnCQ2UwSca7s+6lmMd7CpBQQrLXLK/NDrtJ79SyAyd95+YbC
 lJaISuWWnY6/eHKEtsyLsgFUjVC/nE2XwF6Otnhh1DbPXbW6Ypz2OshLL
 dz445QSuNBmL5LjBG74YIpiFcrowLGCOs1UEX9NHiFDFVQuHIsVbbhTVZ Q==;
X-CSE-ConnectionGUID: BdI1+Dn+QAW44rQhAtuVOQ==
X-CSE-MsgGUID: EIE1z5+RSi2vzRAyXRKHaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24749119"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; d="scan'208";a="24749119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2024 01:45:29 -0700
X-CSE-ConnectionGUID: E5x2jepzTTa3gyUFxon/Ug==
X-CSE-MsgGUID: RdWG8Ek7RBCNmZnvuZ1i2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; d="scan'208";a="66389315"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Sep 2024 01:45:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 01:45:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 01:45:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 01:45:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 01:45:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhQzf0kECcaYQiYPS8kIegf0fIr7WxS1Xexis7WLc/povUaTfk0KuLIl515KkECWIPb5ZkiwqfYfXQOjHFhgzob5Jg1vYu3b57Y1m2WlcDqvF6TpLkgXhG5eZy2P6ioD4AUguGpdesN32UVaiqlDxd1YBAI+/eSpO79FBwUmuIBSUpYc1XKgWfKxKyFMfXPtQG5yE6+9swkT7yEbLF7qNjNDXmEBxMp3Ev1AgwEQiBNqXDYIVczWCSdY/GsRh1VjFzBrABmiuA+G04BIYYM29RS/LZHI5F7BCytL5KCvbLL6eeTalucBukx06FmR8G5mDzqYNHUfMGyVLzRe65t56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqZRKQaAr1xdrICNNnYRpcLWkIYhMnMkQnfKJtx+cDc=;
 b=v9GPVSZyOcdZHPsewaJKmxlOKJbHmKuAaZatIa1n9A3/Pw2yRCaG9bp7pr21RST+qrACMy5bLLOUcR4XuLmVTJy8pIJ+T2j0NuE2qMVqSzC+zJeK+hzzNy8T04t2uCC3Oh5P2dN2JaV3euppHHsVCD4n4ASS90aYAEgry7G3QXTN4Ya/DO5SKfaTuJ2G2TPqq3vn5axW/7Ea7VQm6Rl1HZQ03efnUEe6lqZFO1PtH8WvCnGdJwMMksY1CHSVCXivQiY31TiThNw9kLjViOEFuti+ZnRwbCVqLDrVrY9uGqQNv4GTt3lSuE13FNFFg09sGS9Bb15vmUEKO+/byM6bzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 08:45:24 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 08:45:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 0/2] intel_iommu minor fixes
Thread-Topic: [PATCH v4 0/2] intel_iommu minor fixes
Thread-Index: AQHa7hnYI6X3S5CMpUWhKCqnyQNGvLJPTDWA
Date: Mon, 9 Sep 2024 08:45:24 +0000
Message-ID: <SJ0PR11MB6744EE90D1D781522091803492992@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240814071321.2621384-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240814071321.2621384-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB7805:EE_
x-ms-office365-filtering-correlation-id: 41c038d0-b16d-4534-8f1e-08dcd0abbf02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0JlSGZKajZySE42V0taUXJTajI3dkxIWktOY3J1cUZqK1BMc3I1U29nOFFP?=
 =?utf-8?B?aUl4ODZ3UFlGamFyTGpjandtaXVwNjgydm54WkRsMytvOGM3ZFgrVVg0LzhS?=
 =?utf-8?B?eU1sUURObm9ndDRVbVlSR1NVQ2xuR0tWcmlaTWFVYWI0UXE0Y1ZkbFlFQTFh?=
 =?utf-8?B?cEpUTWt1TVF5ZXVpUzBjN1dOZGZDWkhlOTFieUFKRWpqMGRSeEpyRG5pK2Vi?=
 =?utf-8?B?NVFCQ1NPQWVNcUJNZk9LRHdtdHRLcWZQYTZQSzZzdWI3TFg5Qit4YndkVThq?=
 =?utf-8?B?cno1VDlUNmZDMUNFVnR2UDVTYnhDOHVGdnBweUlVa25XLy95UUdwLytRdkZt?=
 =?utf-8?B?Z3dCelYzRUhOV25OOFF4MVVCbGZJQU9kUlNWTUUvUFRKZldJM2twMXhCZ2dJ?=
 =?utf-8?B?VU5UUEpxZVFkOXA5ZDBqejNEOVE1cnBuamY1eEx4eHd3SzlOVCtvVDJiajNy?=
 =?utf-8?B?N0IrSWdkbVpzUUNINDQxbTdRZ29iUUUwck5qSVZWTzYxL3RsOERHNitxRlh2?=
 =?utf-8?B?aFpPQkw0UzJQVDQxSjRyemEyUmJtVFkvZ2R1QkpYdU5KVk9RbDZEbWtHZmZV?=
 =?utf-8?B?ZEgvN2Y5NXUzcUdnZU9MZGNXd1ZaeVVReVZTUXozWFFHeTRuZnVKQ0hUWHhP?=
 =?utf-8?B?bStjU090SGxNbTFBNzdpb21DT2k1OUNnQWFERDNhaldWdmU5eHkyVCs4ZWps?=
 =?utf-8?B?THRqNW15TkhmQm9hU3dwOGJ3UTRqU0RoVkJLQWNTRnJoWXorL2VQajBFL21B?=
 =?utf-8?B?c1k2Qk1IM1FLQ0lTcnNjczBvck9heUJ2OGFQbVRMZUJCTXRyWTFibHVqVjVk?=
 =?utf-8?B?Wk5XN1RReUFGS1RlanFhdGhKOWczNkt6SFl3dkVZY1djcTh3RTl1U1dlNnph?=
 =?utf-8?B?TlVKZFBwZnAwOEpiYUhhMVpwbjRSVUxldHprVXI2M0MxOVZwT241dWhIUWZY?=
 =?utf-8?B?NDBkNUlvMTZUckFqREEvd2dQWVJDV0VpcFBXOTN4U01XelRtWDRKMjliSll0?=
 =?utf-8?B?S3kxVmMxNDBCMWNSZkRrOGx0aWh1ZGtDME53TVFteXVkNzJtMWZXL3FlU3J4?=
 =?utf-8?B?cnBucVhXUFpBZHFGVnV5RG50RkhiaHFxTDBmQitaVHpwR29zZzZacXpxejVp?=
 =?utf-8?B?ek14ZEUvTmM5S1p4QnlvMTZVZTJ3SDRaRE1EODJqdEtEUW5zMmlNbzFaQ1Rh?=
 =?utf-8?B?L3RibTEzUG1kbXVNVGNhWEpGNWJteXJ4VG1McDN5REVoZDFmTWV2MlNMRUly?=
 =?utf-8?B?VGtkUC9rWFIxOGNwaDlrMHhOczFYS1kzbDBBTFAwclBQUmVnZmNYTy9OeDZT?=
 =?utf-8?B?K0V1SmZlcCtrUERmeVRMS0NWdG1KUU1EMStTMGxiQU40d0xtazN5TG9Yb210?=
 =?utf-8?B?dk96L0I3L1pEeGYzV0ozR3ZEM2dOMmx6c2xjejhlWTBFd1dXRnVqaEg5SWN6?=
 =?utf-8?B?M2Z6S0poTFJCMnRuNjFwVkZwSkFIampxSXA5SE5wdVB0NUFyWTgyVENGbldP?=
 =?utf-8?B?eE1zZzc4M0xjRC8vSG02WExrNTFBMVdkd0Jxcjd1Y0Zlc0tmL1VnS3FQUjQx?=
 =?utf-8?B?YWw0aDFlMUVPeE9xT21GSitFRWZoaStQMGFjOTVvYTErMjJEUTZVNHJra3V3?=
 =?utf-8?B?Y0hrZUpqN1BlTk55VWt2WDRFZ3RLY2xSN0NOeHBPeHJra24zQkh2TEtMZGxx?=
 =?utf-8?B?NFpQMWdYMnlOMi9yeThFNGdOeVVZa3hOWEJWQmhnZG9JaXU2NTRQZkpNSFZM?=
 =?utf-8?B?ZFpWMzZ4aEY3M2V6b1JhZmRzSGxVZG9TSWFzUW5LSm9ucnhhZnMzWDQ4MXU4?=
 =?utf-8?B?ekhBSzAyUlZkaHA2eFFTS2RMY2U2ZEhyRXZGSzJSdXgxNXh5YnBZQ00xdWhq?=
 =?utf-8?B?YUpCajFHNDA3LzVaUEI5OVFLeTVqdnVmZHdzS3Y2bW8zaUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmlBZ3kyRnNISzUrcm83L25WQlZualpDRWVleGRMNERKNGYzcjV1dVJ0VWlj?=
 =?utf-8?B?bnpDYkdLMjdBSVhrazRhNlgreWtleXY1VHBFQzlTbGtQVnhjemxhMDdWUnNo?=
 =?utf-8?B?KzNCeTE3RDdta0lJTXlkZDM0cnA5UE5nVUFVSTg3SEo4cjFuWXNKM3NzNTlG?=
 =?utf-8?B?enY4bGI0N2pyRnVZaE4vckdpRGwwS0ZrOWgyQmREMUpaRVcwUEVOOG0weE05?=
 =?utf-8?B?MUlrM2hYU0FpZlVSVDY0R2hET2MvNmFiblg3UGNudVVGZXBhQkI0VnQrbWdY?=
 =?utf-8?B?VkhFNFFtcUQwSGtKVk42bWlGdE5vNzJrNEdwbVNycmhyVDV0cTVxOTROdkRq?=
 =?utf-8?B?RnlOWit6SlFqcFpFeGJ6a1dsQWxGNmVSNFFKQ0Foem1CUnY0VW1ZekZCRnIy?=
 =?utf-8?B?ZGxSN3dBazNNODVJTUEzYlE0V253ZktZRk81bGhtWE5PMy9FUHBRL1pXVkFi?=
 =?utf-8?B?dC9BRVpqeXlnaUpURGRJZUdDTmZyR2NaSG1kV2gyRmhEU2xWQVVHKzh5aU1I?=
 =?utf-8?B?VDJaWFphdktxcXJVeGhielBTK2oydTR1VnpQUGhHNmNEM0t1dy9WdXZ3a3BP?=
 =?utf-8?B?UzZYNUl0NTVJNlBFSi9DVDZNYVlYcnBsWWNRSWN0Zm14Z25XTU8vMURsOEtO?=
 =?utf-8?B?WlZXRC9BdHRKdENGQ0JiSUkweStCcGJuVjRORkVGRnhUMzIxZEY2RmwzS2o1?=
 =?utf-8?B?WE41T1ZHMEU3b2R3VTZyT2xrTVZST0txY0VwSkFNTi9SaEorT2cxODBlM3Nu?=
 =?utf-8?B?QnZ1QlZYQ3paODN5K3BPR2JYc1pqUHJUTHlJT0owNm9HbzFOeXFVQ3JMdEEz?=
 =?utf-8?B?YnpQU01iOEltdWFNdVIzRkZhTDVJQ2VXaEtFWVFGS0FSTXdGUDBzRnAzWTRq?=
 =?utf-8?B?eDkxWXVRbW5MVmExTTVHdEdTbXdLaW9waDNPck5DZlFINEtxY3BkRHhkVElC?=
 =?utf-8?B?RG1KTncvQTR2bUtoSXJTemxqV1RxWTAwcFpBbXdMZEw5V2RVUHpzYTU0WGZ3?=
 =?utf-8?B?TzRiL2pXRWlCbkhLQjY0Z1hsanFsTkh1ZE0vZjk4dGFCaXozSkdUUjZtVXVn?=
 =?utf-8?B?dTdNUnh2OThPMDA5QithakhxMjFCbHEwSWFNREhyTmRxNmYya25hdlF6L0dR?=
 =?utf-8?B?czBTcVdOSmtRemJFeEEyQThHVHdGdDkreFRpQlBkN0JycFBqQXJVczFQT01T?=
 =?utf-8?B?QnVGRG1vek1MbFh4ejZqbGp0K05BdzJ4eWZuaTZhVzhHZFhoM2pRU3NUaElV?=
 =?utf-8?B?QldNcVB2VDRoUVppU01aVFR6NVJ1bitLUHFJc3pGMFpTS3Y4V2NYczZ5TnhR?=
 =?utf-8?B?NFZyYkFRZjFjeXVoaWc0YlR1V0Q3ejQ1dk1MejM2UC9qTDlzUklsSVlxM0NJ?=
 =?utf-8?B?MGZrYlM0OFVoR2VueGtNUEtBTFRXVyt1Uk13a2pqTXR0Wm1tUFBacHloUEhM?=
 =?utf-8?B?R0hwa082MFQvY002aWxnL3N3azB3MlBNYjNUUkQyUmVYSmxsN05SdjlZaCsw?=
 =?utf-8?B?Rkszd3FYc1dUQTV1anVpNVRPd1ZKVDFsRTNGcnFPK2xOWDJnbkQ3alFpeUQw?=
 =?utf-8?B?ck5CY05haGtnL1FMQkFFdEdlZlVHSFVuT0JCbmxocTg3VTQ0azZjRitUT25q?=
 =?utf-8?B?RGc1Z0gyTkwwdnBkNTErZitPQUttQm1ROFA5Wmp1aW05MnlhMWM3dkQxUkta?=
 =?utf-8?B?OVRnckc5UW9tUFRCWkRvcmJNZGZtRkY2Yi9Ra2NWMDBFbVE3UWUzNUVrUjZU?=
 =?utf-8?B?MWd6aWdQaG9lVVUwcHVFNGNadTlMSEFialBqU3ZMcGRERS93blZFMnZ0a1hF?=
 =?utf-8?B?djArZWNyYnY5aE15YjMwdzNpcEJ0bWQwcjJ4QjJnVUQ4MExHUlF3ejJ1NEtI?=
 =?utf-8?B?ZzJyUjFlWngvYkRXeGhneHVJTGxLUGYyNUFKK1ZjazRJc0crOFJXWVpJNXNV?=
 =?utf-8?B?L1BUdURNSC9ZOHdEY042U2NrVXovQkJ1ejllaHcwNVBuSzNFVkVjRHQ5UHd4?=
 =?utf-8?B?ekVXQ1ozNGx3R2EyTStDZk9HSG9tc2tzdWhpQjZHaTBjREdULzlUaklNa0Rv?=
 =?utf-8?B?MVYvR0ttcDg1QW5ycVRwZktsYXIwdVlSZmc3V0plQzlzT1JaVmFNTE5ITDdP?=
 =?utf-8?Q?8gicm0gzaqUtYiwVSbaOMYLr8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c038d0-b16d-4534-8f1e-08dcd0abbf02
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 08:45:24.2344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HkXzKIUOvn43AoYraTpcqUIlkYhbAQCul+zvJd61C9zycO4Agd+NGGzQONOmRDljtzbyyHpnojIihn5I+Rgs2TBDLAGz2X+UqUpDy9291o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgTWljaGFlbCwNCg0KS2luZGx5IHBpbmcsIHNlZW1zIHRoaXMgc21hbGwgc2VyaWVzIG1pc3Nl
ZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj5Gcm9tOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5TdWJq
ZWN0OiBbUEFUQ0ggdjQgMC8yXSBpbnRlbF9pb21tdSBtaW5vciBmaXhlcw0KPg0KPkhpDQo+DQo+
Rml4ZXMgdHdvIG1pbm9yIGlzc3VlcyBpbiBpbnRlbCBpb21tdS4NCj5TZWUgcGF0Y2ggZm9yIGRl
dGFpbHMuDQo+DQo+VGVzdGVkIHNjYWxhYmxlIG1vZGUgYW5kIGxlZ2FjeSBtb2RlIHdpdGggdmZp
byBkZXZpY2UgcGFzc3Rocm91Z2g6IFBBU1MNCj5UZXN0ZWQgaW50ZWwtaW9tbXUuZmxhdCBpbiBr
dm0tdW5pdC10ZXN0OiBQQVNTDQo+DQo+VGhhbmtzDQo+Wmhlbnpob25nDQo+DQo+Q2hhbmdlbG9n
Og0KPnY0Og0KPi0gVXNlIDEyIGJ5dGVzIGNvbW1pdCBpZCBpbiBmaXggdGFnIChMaXUgWWkpDQo+
DQo+djM6DQo+LSBhZGQgZml4IHRhZyAoTGl1IFlpKQ0KPi0gY29sbGVjdCBSLUINCj4NCj52MjoN
Cj4tIHMvdGFrZS90YWtpbmcvIChMaXUgWWkpDQo+LSBhZGQgcGF0Y2gyIChMaXUgWWkpDQo+DQo+
Wmhlbnpob25nIER1YW4gKDIpOg0KPiAgaW50ZWxfaW9tbXU6IEZpeCBpbnZhbGlkYXRpb24gZGVz
Y3JpcHRvciB0eXBlIGZpZWxkDQo+ICBpbnRlbF9pb21tdTogTWFrZSBQQVNJRC1jYWNoZSBhbmQg
UElPVExCIHR5cGUgaW52YWxpZCBpbiBsZWdhY3kgbW9kZQ0KPg0KPiBody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmggfCAxMSArKysrKystLS0tLQ0KPiBody9pMzg2L2ludGVsX2lvbW11LmMg
ICAgICAgICAgfCAyNCArKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gMiBmaWxlcyBjaGFuZ2Vk
LCAxOCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4NCj4tLQ0KPjIuMzQuMQ0KDQo=

