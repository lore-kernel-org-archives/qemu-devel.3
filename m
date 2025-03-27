Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6277AC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txkAc-0005LW-KW; Thu, 27 Mar 2025 06:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txkAa-0005LC-Fx
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:09:04 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txkAY-0004DH-Or
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743070142; x=1774606142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gyDL+xHQS92tgPTwj3ijLE7Qw0B16bxHiI9gs2PDpwY=;
 b=aHl/KFTpUO4JID3wW4AapOwjG94fvdrDuUHNB5ErSxRJgq0OddqbKnby
 YRG/HqKkbGU9D06SHN69RyvxjYKQCh1HiOxJJU6GNbq+NL/O2gbjbZ9Q8
 gH5Jq3rxVXyPXh0ncDc1LGacsQDd6WNyDo9m8nXZXy6guwfBaIof9hcf9
 acP8C+nALOc87HuCZfQz9eefTxRhcmLc6o7JMuEhnKM/98yQIDBqrcaxe
 p3K+FThw7Z/6Xz3FRXrS1QqXA2Pgm1+aGklr7lLiEbmAu8Hzz7Xa0FliG
 ZH3VM0EDHEdqHqorLJYB1FUDWekRScUBptcs8f2tik4HXsDJ6RJN8kq2+ w==;
X-CSE-ConnectionGUID: FJBk1QECRUeqmKye10ne4Q==
X-CSE-MsgGUID: JJj3HoSnSXKtObire3bwcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44577062"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44577062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:09:01 -0700
X-CSE-ConnectionGUID: 0Xw26LfFT5SddR3bUoOAWA==
X-CSE-MsgGUID: 8lxNLHM+Ss2HaAEpp595Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="124857494"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 03:09:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 03:09:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:09:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzaSRf5V5raz1+3uxtzRROE6ypS4Q8QWiguMLotQlF2PH5jocEHiqnHrqq1G7s3uqeo3+D3BVvkxAjnCIixxcmbEQNjYTO5ao+MU/jPKamlW9Ii0Gt9rIVUpPClZCPGL1JiUtLQC/0e/9ymZwac9akm8i2lcNnKUwfdsO8fCLzyXqtLO469MbD3+zbadOVsOdLPqwrhL21LtF/t+fkItxT/TxKgEYEy8O48Ht9XdKFh8+JBHQ8ylotsDrcBY30ZZNqxSHQh4N3drC14IW6jq0KK08jXu51CbCCgwGjQrDyXggiarc78nTI8vtUcm+CeWaujmuTv7hdEWRwFaXb5+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyDL+xHQS92tgPTwj3ijLE7Qw0B16bxHiI9gs2PDpwY=;
 b=vc7NyiNr6uSJvlfFfdY9nj5zfaeuUL9wHdEloadck86kB1iJdF7V+3jm2Ca4daRjY8d7Bw9GCLLTFM/8TZsYfOU3JVcCn0hE7xosYgcvDIlCmSb2h8F9bnOJ90f7HUPQ6TFDdo4+8bJvVwKXFwQ7RIOWQiT0PGdEVYNwPLzfqKMxMZXkuYXZiFnHV2wZOUSWMvZB2dMgyvTvh2WWikGrMz5BwwnTZwOTTnriLnltqvE3IO+1UusDybJUYSm5Jq4DO8s5TqKiVY/3dgDhfludVyhJNYlq/yCBKgJqOB/6yz0tISEsrh0jApwSqaaIQaqhKYjZVJFbfeTcqKGuM6n5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:08:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:08:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 36/37] vfio: Rename VFIODevice related services
Thread-Topic: [PATCH for-10.1 v2 36/37] vfio: Rename VFIODevice related
 services
Thread-Index: AQHbniQ5DzSdtT7JwESk2fF/H+5IXbOGw/oQ
Date: Thu, 27 Mar 2025 10:08:25 +0000
Message-ID: <SJ0PR11MB6744296FF222649C12F015B292A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-37-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-37-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: 5fb833a8-e1ef-4aa0-11cf-08dd6d175088
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UDgrK05NVFZDbVUwQjYrSlB4TWE5Y29XOGpnY0tocWV3MnlKQ2R3UFUyQmx3?=
 =?utf-8?B?ZlZ3eVYzUEVXNndPZElENU1jbVd2WTQ3ektiQ0VUTm9YalZZVnhrZFQxNVNp?=
 =?utf-8?B?YVh5ekJqVFdRVy9BaSt6STkwTXdLWWIyNXBnY0xrbWN1Q0JPWWdDTWxDU2E2?=
 =?utf-8?B?WlpnL2lPaEZNRE85bjhyV1A5MHpoWHdIaFMyd3lWOFZFdFJubDJwM1h3bGVi?=
 =?utf-8?B?b0JIWnozeXBnRmMrdnp4VXFtUXBTUnQ2bkFCZUppZjlhN2VxRWpyMXQ3bnha?=
 =?utf-8?B?ZTFOT3EvdmhBbjYvZDRuOFBoUXVOOHBucGJzdXdOSDkwT1NFU2JObFM4Nmt5?=
 =?utf-8?B?WHUvWTJ3MzBjeGhHanR2UG9wU0NsckxRUm5hSEFhaUtPdFdjRnlOZjVvTmlz?=
 =?utf-8?B?c0tJSEJub3Rlcmd3d1hQRjYwU0djTzFBc3N2SXZqTk8yd2psTXlWWXMybDdW?=
 =?utf-8?B?T2dESzRWNUlpbTQ0RjZBTFIwbjJpa3hRVThUZ0N0WEMzZU1jeUZZZzQ4VURa?=
 =?utf-8?B?Qzh5a1lvUURTVVRzeVB6MzE0OURxYS9mZUxhQ3pyaWpGeldNaEFxSkQxZWlB?=
 =?utf-8?B?WHQ5aW9jMWJUUGU4N1c0SGE4VXBxYXlzTmVtZVFuV1ZaZ1dmVVVHWmFHZzg3?=
 =?utf-8?B?V3FPZzZMdkVQUEMrK0RuR2t0RlFQMUl2V0YrYVlNTFpDK29tVDFQa1FyRlhx?=
 =?utf-8?B?VllicjNwc0hSN0VxWHJlc25menJ6TWF0anEwZXY0Mmp0S3gybzBBTnE2UlBl?=
 =?utf-8?B?SzAxdnp0cDV0MmtDRXpKNDJlNytMdWlJazlJcDcvYmJ6K0NlVEVlN0tZTmVR?=
 =?utf-8?B?SjIrUlhwOHJYbUFBL2R4c0lFSzYzODNMMXd3cFUwV0pQaURlTko2aHJaalRU?=
 =?utf-8?B?WGpXeTdzRzNOWmc1Zk1mVGR6RkhUR21xOEhLcVNDVGdickhQRzFMS2hvL0k0?=
 =?utf-8?B?N3dGVCt1R3hkQ1BCaXQ3ZzZjYjB4Sm1tUE1CVE1Mc0Eza2l0c0FvMkFVcFpi?=
 =?utf-8?B?NEtMR3pJZERuNFdMZk1Ud3ZhRWs1VlFycys1LzlwUFNmeU9yUEplcExPVCtR?=
 =?utf-8?B?Y041RzRlK0NjYkpTMitaVGZJeWp1V0x6Z1VFOFMvT0tYVnBSQ0lpeWhDckl1?=
 =?utf-8?B?S3hhNVRjRWFQZHhVbFpEM253M0p0WDZQemxZUmZad0d6ZUx0VkVGWmlRV2FO?=
 =?utf-8?B?OWU2T0Jub0E1RDNQd1g0Y2VRNmI0SVQ5RFNBNkxuL3NGTDV6WnZUTzB6dVZl?=
 =?utf-8?B?emVrclFTcng2TkFjUkg3WVc1TGpzR2orT0xOV0d0SVNKQkZxaytOOE1MTTcr?=
 =?utf-8?B?UVRDMm1iSFpHQVhjbzVxM20rZ0ZLY1doalBVcWQzSFlYRVkvYTlSbHAzTVpU?=
 =?utf-8?B?VGdCeHJRcUxXanZPSUV4ZEFuVVhtYVZGWjJ5Q0YwcTMyN1B6YnZTWjZwSkZC?=
 =?utf-8?B?TE9mdC9rdTJpbi9FUk5ZejNEZHJZRERPWHRjUzFaQWtjTHJhZkZCV0pKK3pk?=
 =?utf-8?B?N1IrTWFSM3hkNjQ4MjJsWmI1bWZPa1M0aGF6MnlFWFdsVG9HYjArRU1TV09P?=
 =?utf-8?B?U21GVVpyRTJJcUtvMllpMjNxV2VmR2M2ZWs0NzMvYS91MDZFdktYTXVUdCtj?=
 =?utf-8?B?YURFSG4yZ3Y2SUxxRThjcmJiTFBWQ1p3MW1HVGVBRVlnbmRiQUNTSEwvcVVG?=
 =?utf-8?B?b0tqWjFUM3NQMFhuV3NTSmFIZjhkMk42aFdTOExRZytvTnd4cG9xbUhtOElo?=
 =?utf-8?B?L1NBVWJrVFlSd2s1dSs0RWE4Z3NMUFBlMDFjclNrZXltN0xzaC83VWY3a2lE?=
 =?utf-8?B?KzB4bTYwaGtyRk4yaUlmOEQwZVdqQ0Z2cVB3cHZVVVB0SkZUbVVIZHphS2Fl?=
 =?utf-8?B?V1IwMFh6cDR5cDZEbEZlZW9sUjRjOFRGYlEyRUcvcWNubExtWUFOd0ZVeHJ5?=
 =?utf-8?Q?A4io4NfTJbQPrHzjfGEb8G4wXeSRsPOZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckN2MWF2VXlvd3JWckFnZXNEcDV5UGZsMXkrSzAwTjI3WGNtTmJpK3JDczVu?=
 =?utf-8?B?QWo3VUVFUHNvYXFXV3BVVnR4TzJ1WnlaNnJwSTkvMnVBM1poR3ViSjRHL0RN?=
 =?utf-8?B?N210ZEJDdDFmVUI3MmZNNkpTWThYWk40cXdySCtBKzdSV3ZwSWRwQkxMby8w?=
 =?utf-8?B?WVhRcUZlUTJkaktPdUZhajl6SmZKakYvaUNERWNNYTNXSXNxTFF3ZlQvREFr?=
 =?utf-8?B?YkJGeG92Z0p1RERhWUJlWWFMdHhNVVJPRkl6ZHNVMkhFcENETHhqbFJJNHA0?=
 =?utf-8?B?alg2dVZRUnlDOEF3WEt4bzBpc2o4YWxMS3ZaWG02T3B4eTRMZHMzanRGM3JU?=
 =?utf-8?B?Vy94QlMwelFsQ3pmaUl0Tno5RWZOdXdPUHpGVUthR0ZOeS9GYVNjeGd0TVNQ?=
 =?utf-8?B?OU5XbXNLdDhoMEw5cUxrYWdhVzBtVnl4bkQ2Rkg0bTEwWVc0SUlRUkYrZDY1?=
 =?utf-8?B?Sk11MlRhUjhvZi9tMTV0dnUxZVRBb09hUGdxQ1JZTEw1MTlpcldzemluQUho?=
 =?utf-8?B?SlVqVzR2VWZ2VDczUWRNazR4WEloQ0xEL0RrSGN5bHpVZ2dja0dJRnBHeFNW?=
 =?utf-8?B?QzM5QVo0U3hnUDllMThsZEw2THM2MExXYktHM3dUeTEzS0xGTmVTYmlPeGNI?=
 =?utf-8?B?RGNNeTRCc3lMczAxRnZKaituQ2Joa3ZnaE1Kb29LS3A1Z1piTEtDamRHdUJy?=
 =?utf-8?B?dHdSdEx4UU9SemN2eFU1ZjJIYnRrc3p6OE1VSlNPSVJJK3J4SzYzOE5GTXUy?=
 =?utf-8?B?dXhvTERtVVVranRMUEtwTVE0S0tpMXJKWjlJU3RsUEZYeGx3MUw5aWdVdm16?=
 =?utf-8?B?MWlWNy9WODR2b2pxNndMMzlYZGwweC81dGtTUmlKNjlzQkE3T0lGMUZZeUpa?=
 =?utf-8?B?bzdpUWJHVlVrUzV0UlBic3NKNlFyejdkRm11Wmd1SnZpRjF0eXdRTCtRbEx3?=
 =?utf-8?B?TUNnUW8yakcxejdVMHpGaUR4QzdRa0tINXI1RDhLQ1ZteVZSTS9pdno1WTNZ?=
 =?utf-8?B?RnJsWmRmZldWVXMxOGJxRGNtY2x2K21kKzlPU0o1bElKTTFyVkp2Mzd3U2hN?=
 =?utf-8?B?blJaSDJ6N2FvU2Z1UWptVTJ5RmcwT1dqVENrbE1XT25VMFBvak9PUURoU1RK?=
 =?utf-8?B?ZDhPKy9jVjNPT01LZXUwR29qdTAranl6SVRCYWVTVm9QQVFWN0hRSlhkeDd6?=
 =?utf-8?B?cEpYV3BSNjdtVU4zekx1ekZxWG5sZlY0N0diWXdTTlVPY2VSQTNuTUtjZ3ox?=
 =?utf-8?B?OGhNRzFBeWJ5eUQ0SDZpRUMzMDFJMk1nSllZVS9jUWlJbURWKytsbDVFM0VI?=
 =?utf-8?B?dXZYRFFmSDdXRVF0Q2RxUFRFN2IrUDVxRG5iSlpsajJLR241djArTldVSzVT?=
 =?utf-8?B?UmxoMTBvS1M5SG41YjRaYmk5ZHBEcFRMbGZkT3FCQnlDQkNOR2kwZXRKOEJO?=
 =?utf-8?B?d3dZSVFaNHNyOW52TFhSQzc1WHRiV3VTNnNwb3cvbmRwTURjcVRmYVpFdnNt?=
 =?utf-8?B?U2o3cVdHTk5IendJeW00Mjc5NHhpd1hZdTZqUnowdHcwMjIvV2pRUHRZejQy?=
 =?utf-8?B?bzhmSUt1WjNKNHJkK3c3RW5YdDlzVlZTWGh4bWY5eFlEU0tVWHZSL1o3ZTFs?=
 =?utf-8?B?TXdENVBZcXM0YVlIQndqWjlzZmZWS3UxZDJrbmhzdHNPSFZmeFIybUNyVld1?=
 =?utf-8?B?dlFNaUFxVWw2M0dXekt2VDVMVTBrWThoaDdzUDNkYkdjajZ1YklrVytoQys3?=
 =?utf-8?B?S0lvaWNidFEwQ2lJYkpuY2Fsa0YyR1c1KyttdWZaWC8rRWRCTFZYZHArcFda?=
 =?utf-8?B?TGs3OVdHZWl1Q1NPbyswWHBjUFdEVW51V2J0ZGEyQ3gxTkozdkZLZWdKbFZF?=
 =?utf-8?B?K2FlMktkWC8xMTVYQ2JXaUMrMUw3VW93aGEzVEpkVThkZDRzZFZ1bXFqUnlU?=
 =?utf-8?B?RXJSa1grYUdaQy95djdjSHdSVjZnNzlYRGV0dkdlSE9lbzJ6azkrbHhSeDc1?=
 =?utf-8?B?azU0aS9OMWoySW1oTnpRQ0R4R1p3c2pEZmNqVGQzUklxbmZEY2VnOXlsSnln?=
 =?utf-8?B?Nm4wZzZ6dzBubWFkS0FRR1dwcU80MDdHMWJGeUhLSXJqM3RqREhEbWFEQS9Z?=
 =?utf-8?Q?MZRFicO/aKYEYw5LO2oWTCrqS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb833a8-e1ef-4aa0-11cf-08dd6d175088
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:08:25.9128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SC7YB+nzULlnNdSSUV81dWABtcmxtqUE2oGBp5yLjEBTBUJ7FQncgUd3HxnysnRUg7SwsTF9NbRVMZGvIjwOHzbPLrx3Is2KYyggEFPue8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMzYvMzddIHZm
aW86IFJlbmFtZSBWRklPRGV2aWNlIHJlbGF0ZWQgc2VydmljZXMNCj4NCj5SZW5hbWUgdGhlc2Ug
cm91dGluZXMgOg0KPg0KPiAgdmZpb19kaXNhYmxlX2lycWluZGV4ICAgICAgIC0+IHZmaW9fZGV2
aWNlX2lycV9kaXNhYmxlDQo+ICB2ZmlvX3VubWFza19zaW5nbGVfaXJxaW5kZXggLT4gdmZpb19k
ZXZpY2VfaXJxX3VubWFzaw0KPiAgdmZpb19tYXNrX3NpbmdsZV9pcnFpbmRleCAgIC0+IHZmaW9f
ZGV2aWNlX2lycV9tYXNrDQo+ICB2ZmlvX3NldF9pcnFfc2lnbmFsaW5nICAgICAgLT4gdmZpb19k
ZXZpY2VfaXJxX3NldF9zaWduYWxpbmcNCj4gIHZmaW9fYXR0YWNoX2RldmljZSAgICAgICAgICAt
PiB2ZmlvX2RldmljZV9hdHRhY2gNCj4gIHZmaW9fZGV0YWNoX2RldmljZSAgICAgICAgICAtPiB2
ZmlvX2RldmljZV9kZXRhY2gNCj4gIHZmaW9fZ2V0X3JlZ2lvbl9pbmZvICAgICAgICAtPiB2Zmlv
X2RldmljZV9nZXRfcmVnaW9uX2luZm8NCj4gIHZmaW9fZ2V0X2Rldl9yZWdpb25faW5mbyAgICAt
PiB2ZmlvX2RldmljZV9nZXRfcmVnaW9uX2luZm9fdHlwZQ0KPiAgdmZpb19oYXNfcmVnaW9uX2Nh
cCAgICAgICAgIC0+IHZmaW9fZGV2aWNlX2hhc19yZWdpb25fY2FwDQo+ICB2ZmlvX3Jlc2V0X2hh
bmRsZXIgICAgICAgICAgLT4gdmZpb19kZXZpY2VfcmVzZXRfaGFuZGVyDQo+DQo+dG8gYmV0dGVy
IHJlZmxlY3QgdGhlIG5hbWVzcGFjZSB0aGV5IGJlbG9uZyB0by4NCj4NCj5TaWduZWQtb2ZmLWJ5
OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVu
emhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

