Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC997C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6tu-0003W3-UR; Mon, 16 Jun 2025 06:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR6tg-0003UQ-Sf
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:17:01 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR6te-0005N5-8v
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750069018; x=1781605018;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DyYlsrCdrRj/3YHm4vFC2+UcRPrUcsFC8zXK5xV7dZo=;
 b=FBdl7jnrMCwXjRLO9Q/4wZq5ievKhhssFZkomrHuqnnYPHo/P3MI+fs3
 dE1hilxOhMZY0K8Pv0gMULDrsDosH/2uE2GCzqrpoKfO601ssd5fDRpzq
 21Un9H2YEAnhvYo4n+hkSZqWOXivndMNSNxKNs/Y1cwBVh6tzYc4biwVs
 2pF+c2EMEAvL0E+rcvL8MgIbWARWJgui0d/Ki+FAEbdveynx5DxEhgbRH
 drTj+hkchzEQykHln6tYDH5SmJIH2UgmOWIaK8UzkqG2oMheOVqLuR5Uo
 rYvl+XsdgR9Wu8u1z99THkgAM5KcDGEK4aNJV3G85svV4N8gJ/qPmcIaS A==;
X-CSE-ConnectionGUID: idrpmThYQBOjWR/AAZMkoQ==
X-CSE-MsgGUID: l4qcaFA8RmiMEV5q40DLrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52344736"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="52344736"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:16:54 -0700
X-CSE-ConnectionGUID: GFotE6TgRaGkwfADFGStYg==
X-CSE-MsgGUID: n91gwjUERBy3rzH/AXxt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="148273604"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 03:16:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 03:16:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 03:16:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 03:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+nWeeD6PT0/4BjA1LDgfxPFfm23esL+DmoH1CzG/vxohwFqwY6o/D8A3XLkY11k3c3n50pPHQmH0uCOdwlccm2rXHe7IQqqjBNQ0q8z62pVFUXmEBxPxLYMMGn5AFZoVGPVkhbjxKVGbtTm8LedV9ULlTv5ZtC3J+K//5UegqWHvHQ6PFBgPMEvJ5eiTuE2Mdo5e3zWh9TuOKoQmklb80m4F5Tn9P+KB/GQk0BiiF5RoahUpQ9SfUh0MD/K19U1RoAX4TSJ27y2KwpQqziYcg6vRHiOgplF6CkAEYhRF2TijZSPoM1UJHsM6/wiu2jr2K987BjWij5BQ2dMFgjsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyYlsrCdrRj/3YHm4vFC2+UcRPrUcsFC8zXK5xV7dZo=;
 b=JCDh5zL3CQdq4wiJCe3ERI7Y+RIMNeh7ezMcGsZI+xJjsCT1brF4RP2BPxfW7GRx0QfOF54x0q0g11NMNxrkEJe93o9eSfVrjWP5xYbiiwBki43dWoWBIykCSvxp98gam1oPPegCxzi+0cKb847FF5xv6ddpIWNLDZhIUL9Cqz0wIDMWUXTlqNunzim5vSplUiAzVb7t795fjKVUCHltglFUXskhA5AsRyMUcKIkBL6qCEXTuq22GJFT4IJVrl9BCp/ot3lwgAE7pn5ZV9+R9mhnKZgsbJ6CEm4RLHsWH6YLixF7wCzQoOBRBg+NBS0biWP3RM1i3hkwrGrJ1ez91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 10:16:20 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 10:16:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADz6UAgACqsQCAAnMkMIAX9a0AgAWgn1CAAD69AIAAIZ9QgAARIoCAAAK5UA==
Date: Mon, 16 Jun 2025 10:16:19 +0000
Message-ID: <IA3PR11MB91363EF9EE3E6E4EB69FE4769270A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aE+68E03aAXEynBd@nvidia.com>
 <IA3PR11MB91362B306AA38B1180E3FC5A9270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ca05ae62-d946-41d8-bd77-60be67a246cc@intel.com>
In-Reply-To: <ca05ae62-d946-41d8-bd77-60be67a246cc@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BY1PR11MB7981:EE_
x-ms-office365-filtering-correlation-id: f0cc6765-ea49-42c6-f955-08ddacbed688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VC9YbEtFM3Q2SFlRbUMreFNBZklscWVLRzVkd3dWTnlHTy9CZ1ZUbFJYMVJX?=
 =?utf-8?B?YVhrQm9sVGRxVE5iNEczME1FWnEyeXY1bXI4OTZQR0F6V2Y3M0VSa3ExdnFG?=
 =?utf-8?B?Tkc1NzVoTzU5RUErd3A5M294RnZienBTcElGQjhaQTRRaWtiVmJkWHFuZnZX?=
 =?utf-8?B?dnVPaTNHODkvZUUydkV6Z05Rc3NRbnpBTWlvbnlhd0gzQ2F5d2dDL0Q0MFlC?=
 =?utf-8?B?cFF5QjUyWnJramJRQUtGVFRvS081NFhmTHdjSGJGT29tMFpWVUI3em45MUw1?=
 =?utf-8?B?eUVYSGVEalRBeURzVVA0aGRhc2VubFptTUZwa1ZHOVFtQjJsMFBPcWtmRXBI?=
 =?utf-8?B?YlBTY2dhSEl3Wm53NUpDaktJZ1R2SG9RRGk4aGhqa29DOFNUR2ZWZ0piSmZH?=
 =?utf-8?B?NzdkODRLOVVUeDkwNXhocjBnTVp4Q29FU0x2UDZ4WDVVSmxiRVZoZlpkcGtj?=
 =?utf-8?B?MnJVQ1dLbXJLVDR5WUVxc0dvVjJwM0crTDArTjYyVzNFamYxcFlINlQzN1lh?=
 =?utf-8?B?KzQvajhPbkRNL0NadXQ0L2UrTXdwUG9FYmVNdWhOMFJWaWhpVlpLcGo3SU9O?=
 =?utf-8?B?YzVFbVZFVnh2UndKYjIrVDZ5dXNpT0ZGSHREVFo4Ym8va3NNRXFzSllmWERj?=
 =?utf-8?B?L2VSUnRjL3RsajJGVzBkLy9ORThjZmpadnpNMTBrQVd1Vk9rd0RaVjB1Ui9P?=
 =?utf-8?B?eTB2YjNwZzIzbzZseXVpOTBuaDhQS1BpRkdudVJIckFUVXFzOGdFSkJlQlJw?=
 =?utf-8?B?dkVpaTJGaWdFMW5XMUlCNUd6ZEJBamZkdVA4dDE3V0paMG93Z2hZdjV3Z29S?=
 =?utf-8?B?YWxEWE5SSWk3MnF5NGlSUHpDbkJJY0hjY3BhVVE3NjlRNXNJcXJxcG42NDhB?=
 =?utf-8?B?NDBUY1RsVzdEU1lRQzU0MnVYVDBtYUtHVEdVNlVWenYyL2FBY1N4eEl2cE1x?=
 =?utf-8?B?a3VHeGVieklwR1dyWEVXWkt6VWgwWU5CK3NYNUYwdm5YdjcxNVozQVRHNHZC?=
 =?utf-8?B?T1h3WEdsY0MydkRmOUNWdk9GdmppTHUwNHFWdCt4RjZXQ1l2bG5BTnJPZEpK?=
 =?utf-8?B?MjJKclorSVdkU2crZmhDVWNobmRaRVhQSk50VktGenRUN3FTWi9KMnZldVRs?=
 =?utf-8?B?TVVyVnI0MzdUSWQ4YnRVR0dOb2F1TWpyb0s3SmtNTTZHOXJhd29UNm9LNnhp?=
 =?utf-8?B?SzFTcGsvYzg1aG44MWhyeDl5R29pcmg5Vm82ZTNlZmxSemU0YnJrZHM4RWpI?=
 =?utf-8?B?bHl1dlJreVl1MmQ0KzRSZitwZ2s2OEp1R2Fjb3hxYVJ6QzFGaExiYjRrbGR3?=
 =?utf-8?B?c3Y2Tk1LTUo0QkpJUFNNbHNPdUYwVllPdGhrRDhweGh5VDZRd0dJRmFsNXFC?=
 =?utf-8?B?Ymp0ejRNYzJzUzFoUmZPV2pGM1JVU01sTHVzeFcxSmljaWV0Q0FDcW84bGNM?=
 =?utf-8?B?ZHV1bkRDNHFjTTZNbVhRblgvZzl3d2VScFVGazJOU2d0YmIvT3YvZkxNYVZP?=
 =?utf-8?B?aHZ5bVlPQ3BIbVVhN2NpcXI4Y3djTUF1ZjRnVVFESUdJZ05qblR1bW54K1Bj?=
 =?utf-8?B?SWZNZHRyYnN0M1A5a1RNNHEvVnFzUHJNMk5QL0E1Q0dySlppdVQ2REE0Y1NX?=
 =?utf-8?B?SjRwdDkvanZ4WWZMT0owU2E0ZitQNmxVZUNUYjc1NnByQm1wNGpLRUQxRldi?=
 =?utf-8?B?Z1U5TnFyeVh1cFVsSHFYeDhxRWphMEFjLzhSSHFmMi91bjhuK1Z4TVhYKzlC?=
 =?utf-8?B?bWFoOUJtcGhtWldseTVwL3R0WEFYZktWM2FmSFFmRm9ZZ2pTWVdiemV6OXlr?=
 =?utf-8?B?UGcyM0U0MGw1KzhkbGtSTUphOEo2MFV1NCtkbnM0Tzh0T2R5eFNPNFlCQ0V0?=
 =?utf-8?B?cjM5NW5MMm4wY3Yremc0cEszTUR1YmNPTHNtdzFUS1lxOVhKMHBHMXJrd1pH?=
 =?utf-8?B?cWZhWWU5dUgzbnFydWo3bFlFcU5wV0FncERRUCtveXhCekxaaHBtdzczU3FF?=
 =?utf-8?B?KzRqdDlhTzFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE1IbHBBSlN6RUI3OWVFL05jWEY2WDczdWpxVk40ei9FdE5vRVJtOXQxTktL?=
 =?utf-8?B?RWdpelJ5RGxxdjM0UEp0dDErNy93MEkvSS9SOThWWE1GcDJtWjlXalpSMFBk?=
 =?utf-8?B?YjMyVlFQSk8yc1huY1dOMTMwU1lIcWdUWHZHTGZuMzVFSjgvODM3SVYwQkph?=
 =?utf-8?B?azB6Y2VqTzRNR1BXRDVQRWpybFRabFNoK3ZRUURpb2lJd0tSYzlMSkphY2hI?=
 =?utf-8?B?RTI5dGZuU21McFZPYlJMYTRUakxzblRiWU55N3VXRTZUQ2Vrb1VDT0xmTzha?=
 =?utf-8?B?Q2JhUWExc3JtSDkraWJPeVVDRDYvUmZFckF4c0lxa3VrbFZGTktwQlVrU0Zz?=
 =?utf-8?B?djBZK0lmTXY0TjBETXJVclZ0aUpMNnh6QzdkQU5CbloyOW5PWEFzcEpENW9t?=
 =?utf-8?B?VVlIdmh6ZEZwNWJIQldhb0xkdUdkcElQK01qZ09UcUJuOUcxNUtWVE1YMmw2?=
 =?utf-8?B?OS84bktsWjN3dE1ydnFvUkViWnhxMFovR1ZSR0phakY0L081VjVWbUhuVjV3?=
 =?utf-8?B?T3ozZHFVUUtiT1JhZGN6QVdQajBzK3JEb1FzTkUraVVVR0g4M29XNzVrR0Jn?=
 =?utf-8?B?Z25JYjNmLzdJd3RjUkc1MmRxL1VqbGxJMUQvZVlUSUIrSG0wdVNBZXVYVkJ1?=
 =?utf-8?B?OUZpM0ZGTEZJNTl0clZTL2pLbTVIVlJ0V2pKRm9qdi9kOWk5Wk55TlUxSDNw?=
 =?utf-8?B?Sm03TEJ4emNKY0M0YURLcmw2QVd2OVFaVlVPTW1RZDZ2T1lFTnYxUkptWFo0?=
 =?utf-8?B?cTJKeVEzVDNsbVVOTEpPQkNISXhnbDZHcUNUelhsV1VqeFlJM1lWRDNLYjQv?=
 =?utf-8?B?Z2tyZEJkUTZHR3dyYkYrQjhpdkpkaUNVVWNsSVFaUWJ6aTBzdmo3M2pPR2NG?=
 =?utf-8?B?cUl6N0UwWW9GQ0VmQ0pQUjhPT1BHZzYxeGRMOW5FWlpTS2k3aVc1cC9tN1Zt?=
 =?utf-8?B?ZFFrRDNSSElldmhSV1ZGMG1KZ2VzV0JXNTUzT1UwYWpIcU1zempVYnIwV1A2?=
 =?utf-8?B?TCtOeHpvcE9HQUxvT0pwRHM4Mm5hOEUzN0xBL0pVYnJiTHplRWhuZE5Xc0RZ?=
 =?utf-8?B?UVNFQ3RkTE9RbC9vZUJiZ1RtZGROKzBoYkdZZkllY3JJclBmbE5YemxmQXdD?=
 =?utf-8?B?M09jUUhFeHFwRjBRSTV6VDhBOTc0c0ZDZHZJenMweXByUnBQMGx3VkdaQi9u?=
 =?utf-8?B?Q0ZidXNYZFdVQVJvQzY5K3VsWGd4OTNUeFpUdEJrZmVaWk5DbGdrK2ttUzZJ?=
 =?utf-8?B?clF6Z0s3My83b3I5MHVHSUVhcmtOWENCRUVOWExaZ0drRi9lbFltQUVxWHBK?=
 =?utf-8?B?c0htVE9YVHlFRTZDTGpsbTNKdTM0TVdvSncyMzQ1SW12SGxWSkR0M2YzZ2lp?=
 =?utf-8?B?bGxhUWNhcWtHd2dPcCtCQ0QrcVJmMy8yc1Z4NTB1cEpDOTlDdm5UZlEyNWJx?=
 =?utf-8?B?bmhlOUxNZkJNZ24yZC9vZkxPVml5aGoxeGo4N2wvZnNkYTYxUkd4cVJGSWVU?=
 =?utf-8?B?YTVTYU8vMGRESGw3WjZoNG4wVjVJWDl6Y1VKMWU2QXRuT0Z0U1JpRm1wc1hB?=
 =?utf-8?B?aUp1ZjFFcno5Z2ZsVk1XN2RPaGluZlVVcHJ6NjhJVkVTYUs2ZGxDeTc5aytx?=
 =?utf-8?B?aEoyQ3pmbXp0VGZhc0dhemw2akFOQkNiZHBIbmpYVHJuK3ZiN29kRytSaFIw?=
 =?utf-8?B?YmNFSlB5Qy9EdTN4c2hITDk0dThDWTM2QkRZRzZWVms5U3Z0dXNjY2RnRGxt?=
 =?utf-8?B?NkNtYmR6MHoxV3FBNUdDTFRVNGQzTVduVGUrOEM0UVhhVUdlZnNMdXlFYVdS?=
 =?utf-8?B?a3hZQzRFb0ZVSTAzSnZXeDV0cWtXdkx4ODZWZ2FxdjJVa0RVQmdmVXRXZmNT?=
 =?utf-8?B?NU9DMGZPM1A3dlF4a2EyeVB0MHdwL0c5U0FPU1Z2VkRTUGNqdHIxcm1iclAx?=
 =?utf-8?B?ell3bEdJNzhBTlVDU05oRm03S3BsQkg1MXdrdmRnMmtROTVXQVlkS2VxZGtD?=
 =?utf-8?B?aGtTWnlNVFhVNGZUcEhKSTJzWHN3SFF3M3dtZjE0ZjJTNG11eWFVVitZakx2?=
 =?utf-8?B?L1JoQ0FCNTVmeVNlekVOQ3orSlQySldNQ08wVzJjcEZiaHNPVHpmWEM5Vk44?=
 =?utf-8?Q?GPuEkAb+B2xkXmyHuUeqWJbdH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cc6765-ea49-42c6-f955-08ddacbed688
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 10:16:19.9377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWrnOY4GulRQQCXNVtxw6N34AGAKAMdDFwzYfNgZEZZSX8ukT3bgjn5Bg+FTlYfdYspTXK/K9i5BXWoBJbpJ5WhGCgSUY1EAmAh+DF/ZYkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjMgMTUvMjFdIGludGVsX2lv
bW11OiBCaW5kL3VuYmluZCBndWVzdCBwYWdlIHRhYmxlIHRvDQo+aG9zdA0KPg0KPk9uIDIwMjUv
Ni8xNiAxNjo1NCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCByZmN2MyAxNS8yMV0gaW50ZWxfaW9tbXU6
IEJpbmQvdW5iaW5kIGd1ZXN0IHBhZ2UgdGFibGUNCj50bw0KPj4+IGhvc3QNCj4+Pg0KPj4+IE9u
IE1vbiwgSnVuIDE2LCAyMDI1IGF0IDAzOjI0OjA2QU0gKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3
cm90ZToNCj4+Pj4gSGkgQExpdSwgWWkgTCBATmljb2xpbiBDaGVuLCBmb3IgZW11bGF0ZWQvcGFz
c3RocnUgZGV2aWNlcw0KPj4+PiBiZWhpbmQgdGhlIHNhbWUgcGNpZS1wY2kgYnJpZGdlLCBJIHRo
aW5rIG9mIGFuIGlkZWEsIGFkZGluZw0KPj4+PiBhIG5ldyBQQ0kgY2FsbGJhY2s6DQo+Pj4+DQo+
Pj4+IEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2VfZXh0ZW5kKShQQ0lCdXMgKmJ1
cywNCj4+Pj4gdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4sIGJvb2wgYWNjZWxfZGV2KTsNCj4+Pj4N
Cj4+Pj4gd2hpY2ggcGFzcyBpbiByZWFsIGJ1cy9kZXZmbiBhbmQgYSBuZXcgcGFyYW0gYWNjZWxf
ZGV2IHdoaWNoDQo+Pj4+IGlzIHRydWUgZm9yIHZmaW8gZGV2aWNlLg0KPj4+DQo+Pj4gSnVzdCA9
eSBmb3IgYWxsIHZmaW8gKHBhc3N0aHJvdWdoKSBkZXZpY2VzPw0KPj4+DQo+DQo+VEJILiBJdCdz
IGEgYml0IGhhY2t5IHRvIG1lIGluIGNvbmNlcHQuIEl0IG1heSBiZSBtb3JlIGNsZWFuZXIgdG8g
ZGV0ZWN0DQo+YW5kIGJsb2NrIHN1Y2ggdG9wb2xvZ3kuDQoNCk9LLCB0aGVuIHdlIGRvbid0IG5l
ZWQgZ2V0X2FkZHJlc3Nfc3BhY2VfZXh0ZW5kKCkuIFdpbGwgZG8gaW4gdjIuDQoNCj4NCj5CVFcu
IEBOaWMsIEkgc3VwcG9zZSBuZXN0aW5nIHZTTU1VdjMgZG9lcyBub3QgaGF2ZSB0aGlzIGNvbmNl
cm4gc2luY2UNCj55b3Ugd2lsbCBwdXQgdGhlIHBhc3N0aHJ1IGRldmljZXMgdW5kZXIgYSBzZXBh
cmF0ZSB2SU9NTVUgd2hpY2ggc2hvdWxkDQo+ZW5zdXJlIHRoYXQgdGhlIGVtdWxhdGVkIGRldmlj
ZXMgd29uJ3Qgc2hhcmUgQVMgd2l0aCBwYXNzdGhyb3VnaCBkZXZpY2UuDQo+cmlnaHQ/DQo+DQo+
Pj4gQVJNIHRlbnRhdGl2ZWx5IGRvZXMgdGhpcyBmb3IgZ2V0X2FkZHJlc3Nfc3BhY2UgdXNpbmcg
U2hhbWVlcidzDQo+Pj4gdHJpY2sgdG8gZGV0ZWN0IGlmIHRoZSBkZXZpY2UgaXMgYSBwYXNzdGhy
b3VnaCBWRklPIG9uZToNCj4+Pg0KPj4+ICAgICBQQ0lEZXZpY2UgKnBkZXYgPSBwY2lfZmluZF9k
ZXZpY2UoYnVzLCBwY2lfYnVzX251bShidXMpLCBkZXZmbik7DQo+Pj4gICAgIGJvb2wgaGFzX2lv
bW11ZmQgPSAhIW9iamVjdF9wcm9wZXJ0eV9maW5kKE9CSkVDVChwZGV2KSwgImlvbW11ZmQiKTsN
Cj4+Pg0KPj4+ICAgICBpZiAoc21tdS0+bmVzdGVkICYmIC4uLiAmJiBoYXNfaW9tbXVmZCkgew0K
Pj4+ICAgICAgICAgcmV0dXJuICZzZGV2LT5hc19zeXNtZW07DQo+Pj4gICAgIH0NCj4+Pg0KPj4+
IFNvLCBJIGd1ZXNzICJhY2NlbF9kZXYiIGNvdWxkIGJlIGp1c3Q6DQo+Pj4gICAgICEhb2JqZWN0
X3Byb3BlcnR5X2ZpbmQoT0JKRUNUKHBkZXYpLCAiaW9tbXVmZCIpDQo+Pj4gPw0KPj4NCj4+IFlv
dSBhcmUgcmlnaHQsIHdlIGRvbid0IG5lZWQgcGFyYW0gYWNjZWxfZGV2LiBCZWxvdyBzaG91bGQg
d29yazoNCj4+DQo+PiBvYmplY3RfZHluYW1pY19jYXN0KE9CSkVDVChoaW9kKSwgVFlQRV9IT1NU
X0lPTU1VX0RFVklDRV9JT01NVUZEKQ0KPj4NCj4+Pg0KPj4+PiBWdGQgaW1wbGVtZW50cyB0aGlz
IGNhbGxiYWNrIGFuZCByZXR1cm4gc2VwYXJhdGUgQVMgZm9yIHZmaW8NCj4+Pj4gZGV2aWNlIGlm
IGl0J3MgdW5kZXIgYW4gcGNpZS1wY2kgYnJpZGdlIGFuZCBmbHRzPW9uOw0KPj4+PiBvdGhlcndp
c2UgaXQgZmFsbGJhY2sgdG8gY2FsbCAuZ2V0X2FkZHJlc3Nfc3BhY2UoKS4gVGhpcyB3YXkNCj4+
Pj4gZW11bGF0ZWQgZGV2aWNlcyBhbmQgcGFzc3RocnUgZGV2aWNlcyBiZWhpbmQgdGhlIHNhbWUg
cGNpZS1wY2kNCj4+Pj4gYnJpZGdlIGNhbiBoYXZlIGRpZmZlcmVudCBBUy4NCj4+Pg0KPj4+IEFn
YWluLCBpZiAidmZpby1kZXZpY2UiIHRhZyB3aXRoICJpb21tdWZkIiBwcm9wZXJ0eSBpcyBlbm91
Z2ggdG8NCj4+PiBpZGVudGlmeSBkZXZpY2VzIHRvIHNlcGFyYXRlIHRoZWlyIGFkZHJlc3Mgc3Bh
Y2VzLCBwZXJoYXBzIHRoZQ0KPj4+IGV4aXN0aW5nIGdldF9hZGRyZXNzX3NwYWNlIGlzIGVub3Vn
aC4NCj4+DQo+PiBXZSBuZWVkIGdldF9hZGRyZXNzX3NwYWNlX2V4dGVuZCgpIHRvIHBhc3MgcmVh
bCBCREYuDQo+PiBnZXRfYWRkcmVzc19zcGFjZSBwYXNzIGdyb3VwJ3MgQkRGIHdoaWNoIG1hZGUg
cGNpX2ZpbmRfZGV2aWNlIHJldHVybiB3cm9uZw0KPmRldmljZS4NCj4+DQo+Pj4NCj4+Pj4gSWYg
YWJvdmUgaWRlYSBpcyBhY2NlcHRhYmxlLCB0aGVuIG9ubHkgb2JzdGFjbGUgaXMgRVJSQVRBXzc3
MjQxNSwNCj4+Pj4gbWF5YmUgd2UgY2FuIGxldCBWRklPIGNoZWNrIHRoaXMgZXJyYXRhIGFuZCBi
eXBhc3MgUk8gbWFwcGluZyBmcm9tDQo+Pj4+IGJlZ2lubmluZz8NCj4+Pg0KPj4+IFllcy4gVGhl
cmUgY2FuIGJlIHNvbWUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIHZJT01NVSBhbmQgdGhlIFZGSU8N
Cj4+PiBjb3JlLg0KPj4+DQo+Pj4+IE9yIHdlIGp1c3QgYmxvY2sgdGhpcyBWRklPIGRldmljZSBy
dW5uaW5nIHdpdGggZmx0cz1vbiBpZg0KPj4+PiBFUlJBVEFfNzcyNDE1IGFuZCBzdWdnZXN0aW5n
IHJ1bm5pbmcgd2l0aCBmbHRzPW9mZj8NCj4+Pg0KPj4+IFRoYXQgc291bmRzIGxpa2UgYSBzaW1w
bGVyIHNvbHV0aW9uLCBzbyBsb25nIGFzIG5vYm9keSBjb21wbGFpbnMNCj4+PiBhYm91dCB0aGlz
IGxpbWl0YXRpb24gOikNCj4+DQo+PiBJIHBsYW4gdG8gYXBwbHkgdGhpcyBzaW1wbGVyIHNvbHV0
aW9uIGV4Y2VwdCB0aGVyZSBpcyBvYmplY3Rpb24sIGJlY2F1c2UNCj4+IEkgZG9uJ3Qgd2FudCB0
byBicmluZyBjb21wbGV4aXR5IHRvIFZGSU8ganVzdCBmb3IgYW4gRXJyYXRhLiBJIHJlbWVtYmVy
DQo+PiBFUlJBVEFfNzcyNDE1IGV4aXN0cyBvbmx5IG9uIG9sZCBTUFIsIEBMaXUsIFlpIEwgY2Fu
IGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nLg0KPg0KPmhtbW0uIEknbSBmaW5lIHRvIHBhc3Mgc29t
ZSBpbmZvIHRvIHZmaW8gaGVuY2UgbGV0IHZmaW8gc2tpcCBSTyBtYXBwaW5ncy4NCj5JcyB0aGVy
ZSBvdGhlciBpbmZvIHRoYXQgVkZJTyBuZWVkcyB0byBnZXQgZnJvbSB2SU9NTVU/IEhvcGUgc3Rh
cnQgYWRkaW5nDQo+c3VjaCBtZWNoYW5pc20gd2l0aCBub3JtYWwgcmVxdWlyZW1lbnQuIDopDQoN
CkkgY2FuIHRoaW5rIG9mIEVSUkFUQV83NzI0MTUgYW5kIE5FU1RFRCBjYXBhYmlsaXR5LiBORVNU
RUQgdXNlZCBmb3IgY3JlYXRpbmcNClZGSU8gZGVmYXVsdCBIV1BUIGluIHN0YWdlMiBtb2RlLg0K
DQpUaGFua3MNClpoZW56aG9uZw0K

