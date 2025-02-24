Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDC0C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 01:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNXJ-0005IA-Q4; Sun, 23 Feb 2025 20:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tmNXE-0005Hs-6F
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:45:28 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tmNXB-0002sh-RQ
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740361526; x=1771897526;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rjtR7aFSUrsTiibLoTyizK1doDpDk7sXcrIho0G3f0Y=;
 b=QXdAHFJg4LkkKyk6pRcPHFYlPf37qDa8hUGZRxgj2FlRpAIa19Y4KDLP
 0PDNscqOMVd5OFAFX+fKeITEjnnE14Rm5KTtp+1Nl4eQ04KmrUhJOvdXO
 HOglMVz8wGIVPuZb6YyYBYgruIwgXTsJJEUIs+AKRs09je+MeSIHUfVeC
 UPPZhhWbAFV+diCTzhv+awPx61dMHhRr4ksfoE0Vqs5uI4gPcg+79UTAU
 Fh7ZffTHTdArF5ce+sIySxjIgynu2P5K7KE1ekxQ7S0ixYLJ0qInU8NNV
 PFiTOC4odJrFj+o3qjgiAPGmD9y+XbnaQjvKoAjTaI9SiLzvlhnknTqq7 w==;
X-CSE-ConnectionGUID: zm0m4z7MT4mEUQTUnB8JtA==
X-CSE-MsgGUID: CsZB/FyOSQaURhBz88F8BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="63573682"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="63573682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2025 17:45:24 -0800
X-CSE-ConnectionGUID: ukgYcC9ITBicvWbGffNW7w==
X-CSE-MsgGUID: nn6M3LtERF65BGl7fbUXKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="115728101"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2025 17:45:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Feb 2025 17:45:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 17:45:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 17:45:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/Nw6v5EDh6W9dc+4uASeAZvccvcPCP2au3MidqixDeAhqXwDSHqE66UM+FTsEE1GrMaULR8Jw4zR9Jzm70t1PSnC7G2zRGYc/uGTyh1YdIxz85VjcsicfWflitiHYeDq4aVqE+o33EiPRGAM07w7ZOBJoKEbMGMZq/DcCxqidNF8SIGeTnG8gZnev7iRF6CaL4RYsOQ2I25bXUGSbVrcYj/zCn/Xt1hKHXArNGYE+bVkQ5/98m/MBFFMYBjVtW482+MY7/5wWuJEguo5Wv7YOGJuGgRZS/e2i/QoTFEsku7D0rN7EDZK7/yqQNbK0AsObhwcE0YyzH3YC0yWJlRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjtR7aFSUrsTiibLoTyizK1doDpDk7sXcrIho0G3f0Y=;
 b=yYLeV9Zm+6kBSVzyMlTfsr3oppLv+1Ymw/AYjgF5dygACV1BOT0mdp8QvVB4sXBMXhu9Mw3CrtoOKnJRr/0sJzR6PaHjP6DmYkR5z9UKGQG3E1Tjaxf+NFAO5EzV4oQq/t+FuZ2igGRzBPIpzwJANtwQ4XhkOxtsYzrDeSKMP62s29GsItINpT0NyXHRHhOFxTdtHGLewrFLypoI2f0TgYihad+f8bwmBABe6EyzfY8kxN5xsad97CLOiPEP9E43/htTCCPSMITzoyj8QZQoyFQaZgRAAORbTx7i7WewRg2eB18shzkSutgv6q+6ljyQGbsyOpBK/l2elTnrxO6C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 01:45:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 01:45:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
Thread-Topic: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
Thread-Index: AQHbg+nIoZcRdmfLyU2LmXS835NR5bNRRkVQgAGQJYCAAtz0IA==
Date: Mon, 24 Feb 2025 01:45:20 +0000
Message-ID: <SJ0PR11MB6744AD679A94A0C3DBD64D0092C02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-5-alex.williamson@redhat.com>
 <SJ0PR11MB674457591D328D9178947A6B92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <86fb5af2-6cda-4a87-97b0-d06dbe55e086@redhat.com>
In-Reply-To: <86fb5af2-6cda-4a87-97b0-d06dbe55e086@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: bfa9528f-ca93-45fe-2113-08dd5474e607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWV6QnArZS9RTFJKSEpSSzdIUE1PNm1MRUdVeThucjVWa2lmV1I3NkJ4OTdD?=
 =?utf-8?B?UE5BaTRGT2gydU16OEk5Mk10dm9WQnNRZTZBT3pIdFM2bkR3d242K3ZENXJW?=
 =?utf-8?B?TFlLTVN5MnBSNE13Y1ZaVXJCVERQV0U5R294cGpKTXlGejFqMzQ5Z09YdzZB?=
 =?utf-8?B?czcxTndydVArdFpqekw0ZmF4S2U0dG1HZTEzelpndTdzbmY4ZUVOeHZuRFlJ?=
 =?utf-8?B?cjZ0Y0p0dFZnNFpHclpiaWJrd2dvNVA2NzYyRnk4VnVMbThnNXEyNUlUZVho?=
 =?utf-8?B?a29xc0cxV2VrMGtqWGNNbEZ5VSt4UWZ2d1Z6ODV5WnRrOGJmQ1pWWEVtSm14?=
 =?utf-8?B?YmwwdnZid0hWcW5JS1pkQVp5MUM4eGFud0FFZlpSbUJWcDNWVnZ4enZnQWY4?=
 =?utf-8?B?UEk5UDhpU0lHZTBZVUFrOW94N2xHaUFFazZFN0NaUVp2UGJyVFpFWkZ5bUpC?=
 =?utf-8?B?alpmQTR5NGY0STN1RjNOTGlvZkZZRFFkanZKTXdkNVgya0dZd2pPeTBFL0w1?=
 =?utf-8?B?dWpVS1dRQWNxSTN3d3QyZUdFME80VDlvdWNaOHY2cmdldHliTGpGUVh1Nkxn?=
 =?utf-8?B?QjJwckxCcTEwMDFhbkduTWZHVXhPNGE3Z1pBQzJGc0xtelNPeUlLTVhDMU5x?=
 =?utf-8?B?alFPblRKYVQ4THN0NmRneUo1TXJBdVRaeStNNE1Kc0lOTS9pTno1d2h2b21S?=
 =?utf-8?B?N0RYajk3QkF6aWFTUC9KWnIwdmNFVE1TZTJIZ0tkR3k0RWJobU1WNldJa01h?=
 =?utf-8?B?empXSUQ2cTNEU1BWUGJ6T3Z2cDdaYTFVM3JBMHllMURTWi8rNjlvNGEzdC9M?=
 =?utf-8?B?Nzk5UVI5Q0dUTWkrN29LMy84RHNRcUptNmVjOEUwbWNUYjJob2c5RzFncllP?=
 =?utf-8?B?aDh2M3h2bHBxUkRtVFZ5TGsxSHN2czc1eHU4ZUZDRFkzTWlRNzVHcklvK013?=
 =?utf-8?B?aVdxdTV4aW44MjR4THB3K2psa1FjcnlKakxWT3ArUGQzNE5CU3hNVmR5dXJF?=
 =?utf-8?B?K01GTW16dzRzV3dWV2pXR2JvUzU2aWRFMkgzUThwUUU2bGkyZGtKVkUwWk42?=
 =?utf-8?B?ZHMralh3UGRUZEF6b0tZeGNnSC9HMEVFMjRObUpCWDJZUzFjL3VnWlcxYjdH?=
 =?utf-8?B?bVVyeG5PSG9ZY3ExSmlzTlRWR0Q5cXZUazQrQ3Z2VGMrNlRlS0o2VXdlWVJC?=
 =?utf-8?B?dW9pUFlPd1BBRVprOTl2K01TUG9Oa1JlK3RVNy9XbjBwVzVkZENaR2ZqK0xD?=
 =?utf-8?B?K1B6UHJqS1FVVExhV20wV0c3NzVtUDBxVU9QNU9wc1Z2UGpyZzFjUlpEWWxV?=
 =?utf-8?B?NVp0a1pTNGU4aEVxRXZwWW0reVNTbi80SVFuOFAxNGFwN0EyM1oxR3FaTDVa?=
 =?utf-8?B?NjFxNnB1WkY4UEFCcS9uRENiQkdOSS9IMGpCR3U0WE9CYU9BSTFOamkyU2lz?=
 =?utf-8?B?SDdLTnVDOGVTZko5VHJFVGdCbnVFOC9lTU5qMlE4NHVPbTA1MUZNK0NIRXBl?=
 =?utf-8?B?VUhTRlVqQkMzYUZyWVpaei9paEhVaVRsYnlBd3dKdzZSczM5bUpVNWxod0h5?=
 =?utf-8?B?Ym1IR0s5VktjSUQ5b3FZcTRTc2tQTWwyY3A5QzdKMGpteWxXbnVlTVZPVEEw?=
 =?utf-8?B?T0NSbGczS2tvSkJiU2FtSzMxaXVzZkM0U2c0T2VXRmhQaU5Qb3Y0WmUzaGJ2?=
 =?utf-8?B?MmhFclY1WjJNVThOQ0FoSjRmYnFLakdDOGlyK0ZCZ2RsZTlHTlY4YXJpbFo5?=
 =?utf-8?B?SjFzTnZVTlVDQkpoMGE0dmYwQTFIcyt6cEVNNFNnRXF1WkRmckNsVWVveEtD?=
 =?utf-8?B?cGIya2M0dEJzZTNwQ0FxbkU4Y3hHUG5rdEIrQW16dW04em1yOEpQNkphcG1E?=
 =?utf-8?B?SS9qMy82VVJhcTEvOWxHcHFtQlZyVEFXSnd0NjFXb0o2MCtjNnN3RlZ0V0Yz?=
 =?utf-8?Q?1lWqFo621sg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXdKOG9kSzlnY2w3dUw3TXpYVUpZbFh2K3EvVVJINUZjK0t5bTZITEh0MzlY?=
 =?utf-8?B?NnZTQ3VJQm9FTCsxbG9Vc09UOVVFc2F0YW1SWkVLOUhYbmZrUEsxT1p0VTkx?=
 =?utf-8?B?SUI3WFd4UGNpVVdRTFdNajN2NGJ6ZTFzcHN0WXJPOUx1Tlg3SjB4aDdqbHRs?=
 =?utf-8?B?Q2tRVE95aVg2R09sWGg0ZGFJWlYyb00yU2lUV245VEtPMGZXN3pwQmRIekIz?=
 =?utf-8?B?V01hOWh5bG5vTjgwLzBDWDg2VTh2VnZXdjB5WTJqeHkvZklIRUE4cktOUnpI?=
 =?utf-8?B?WWRVdFFlbWJEaUlGWGZnYW9MOTJhT0tBRi9OVHF6Vkt5a0xOcWxJOXBqaDQx?=
 =?utf-8?B?ZzFtaFZJT2xrQS9RVGwrQldLMklFS0RMQnNxL25Ed2QwVUpWTG1ZUmkwZXQ2?=
 =?utf-8?B?alFvV0ppalpOY3hYT0hWbUZ3cWxwNGY1M29ORTQ0K2VrdFFuN1d5SEM3eTE2?=
 =?utf-8?B?RU1wTTV0MjlZbDdseDhZOWp2VU5sUk94OC9CN2xTNUQ1ZGszWGpSWGFsSHRl?=
 =?utf-8?B?aDNLOU4xWDhwMjRWMGlqK0hOdVdhVitPZ0Zhd29OYzJyL3U3OEMzMHdudGdQ?=
 =?utf-8?B?clN5eER0UXl6NUxFVnpGbGx2bzB0U3RoSjVXVm45Zm9oelJONTFIS3pVWFUx?=
 =?utf-8?B?Z3FxeEtxcTMzUW84eVVXaFNOa3JGTlphSWw0RWFuUlhreDZ6REp5M1Rqcnow?=
 =?utf-8?B?aHpTc3EvdXNobzJCNTRwUzJFNldQaXBiVHBPZFBKYklIQ3pvYjVuTUxrMTB0?=
 =?utf-8?B?OGtZWUJQOW9sbWlESUlkT3Jhb1o3aGhobk0ydHlubDloOUJzaUVWaFc1Q2ZR?=
 =?utf-8?B?NzQzRE9mczQvQ0o5dlpGeHV5Ym15QmZuMFdVVEhnNHBzT1RKUDVwWGMrWWdH?=
 =?utf-8?B?ZG1kNE9SYmV2NDJBS3ZaTFg3b21yYWNGZ2w3NGxPQ3VmQXhZc1ovdXJ1bGU4?=
 =?utf-8?B?QUs3bWtPbFdUV1g2c1h2Sk44K1BBVVp3MkNxNE93Z0NndWVBOUIrWWJGOUF2?=
 =?utf-8?B?TjFYaWZnZlhaVHpmaGNQSmtZR1BoYlI3aFR0cFRtTTUyZEZYWERDaTZNVnRK?=
 =?utf-8?B?L3dUbldtNGk5dzd5blBhMWhVTWVXdW9JS1BpM29pd3VPZDZpa0Jvb1Z0aENB?=
 =?utf-8?B?YW1iRXlTZGJ0VkMvUU9rTEtienJ2alE0NHk4b2ZtSUtSUnJ5dDZGNWQ0KzdN?=
 =?utf-8?B?UGg2VjIxeU1EUWY2bkhmT2oxeFpFdWY3UTdzR2ZNS3ZvMlh5cmFPYWFjcDB3?=
 =?utf-8?B?QURIQVhtNkV1elNiUG9SRGNKbnRSRXhFOGVhZ1V0WTlJQXg4TytWbzBvdmtr?=
 =?utf-8?B?cDZKbit5eThQb1crK3QzVS9qeGRrSlNhRmZISVZ5ZitKNE9DM25oZGxFQ251?=
 =?utf-8?B?QTdQSmxlb1Z6VDJUUlpzR3Z3cG1aQjA0NXkrTVpaMHc4SnA1ckRGUzBidzNU?=
 =?utf-8?B?UGMrOWlqV2lNeGd5NjFUYVZDcjJ2bHBPQXFGcnBEOTA4Mm5tb2pEM0dQdnNl?=
 =?utf-8?B?QnFpRGtMNzNFL2dycGJFSzBnSUxOS1pZU0JXMGRtQ1FoSFdJTTZDMjc3RWRI?=
 =?utf-8?B?MFVSOWZST2FwZEo3NjRoNVBsengrRDB6dEFEY096UlFDend5SXVVTnJqWnRH?=
 =?utf-8?B?RUJ6Nk94WUxFbExNc3g1WkhLM3h4TFB6OUZaS0FTV2NISkZDMEpmWThXN0Jk?=
 =?utf-8?B?S1NuOTE3S0xvNGRlK0xpRnVPY3ZQTUVGT2IyWGhxdTM1OUZwbHQ5TExobVcw?=
 =?utf-8?B?V3RrSWhrZVBhcEp5T0ROcnUzOVcxS1VrZG5qYkNxeXdFUjFkckVJNFNXZ0FR?=
 =?utf-8?B?eGdsSmQxT2tVSHE3UkEva3B1ZDVWQzMwdUV0YWFKaEVNeWhjUStOWUZWVkJj?=
 =?utf-8?B?RnhoWHhMb0pYZldpY0RJeVRoZUVDMitHYWxiMXdRanhpVzh5akxBVVBJMzJk?=
 =?utf-8?B?TVhncWEySUZGRm9GL0tDZkFkaHdLZWNaS29rWDFuOGY1dEVoWVd6MHdMeFhz?=
 =?utf-8?B?SVJNWmZ2OHZvSHcvekdKL0Q3Q01DR25PdjJFMkZ1MjgxNC81NkRUMVhUZFlO?=
 =?utf-8?B?YlNKblY2RG8vVENDa2NtblBxRFRYNU5URnpudDRtZmk0clBXaWFBVU1BeDhE?=
 =?utf-8?Q?arJkFTVQFtEk0pVJVR7chv02N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa9528f-ca93-45fe-2113-08dd5474e607
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 01:45:20.8626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCRxjxSHMaH++/fSz4b0tsUlQOyanXB89p/8L/o/oQZI3fCP7ODn4MxbabGXSx+w0mTD5eDlocLRq1nauODTDHd/bxjfwAMgZqLBeq6fvEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggNC81XSBw
Y2llLCB2aXJ0aW86IFJlbW92ZSByZWR1bmRhbnQgcG1fY2FwDQo+DQo+SGVsbG8gWmhlbnpob25n
LA0KPg0KPk9uIDIvMjEvMjUgMDc6MTIsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0K
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQWxleCBXaWxsaWFtc29u
IDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggNC81XSBw
Y2llLCB2aXJ0aW86IFJlbW92ZSByZWR1bmRhbnQgcG1fY2FwDQo+Pj4NCj4+PiBUaGUgcG1fY2Fw
IG9uIHRoZSBQQ0lFeHByZXNzRGV2aWNlIG9iamVjdCBjYW4gYmUgZGlzdGlsbGVkIGRvd24NCj4+
PiB0byB0aGUgbmV3IGluc3RhbmNlIG9uIHRoZSBQQ0lEZXZpY2Ugb2JqZWN0Lg0KPj4+DQo+Pj4g
Q2M6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+Pj4gQ2M6IE1hcmNlbCBB
cGZlbGJhdW0gPG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6
IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+
Pj4gaHcvcGNpLWJyaWRnZS9wY2llX3BjaV9icmlkZ2UuYyB8IDEgLQ0KPj4+IGh3L3ZpcnRpby92
aXJ0aW8tcGNpLmMgICAgICAgICAgfCA4ICsrKy0tLS0tDQo+Pj4gaW5jbHVkZS9ody9wY2kvcGNp
ZS5oICAgICAgICAgICB8IDIgLS0NCj4+PiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody9wY2ktYnJpZGdlL3Bj
aWVfcGNpX2JyaWRnZS5jIGIvaHcvcGNpLWJyaWRnZS9wY2llX3BjaV9icmlkZ2UuYw0KPj4+IGlu
ZGV4IDlmYTY1NmI0M2I0Mi4uMjQyOTUwM2NmYmJmIDEwMDY0NA0KPj4+IC0tLSBhL2h3L3BjaS1i
cmlkZ2UvcGNpZV9wY2lfYnJpZGdlLmMNCj4+PiArKysgYi9ody9wY2ktYnJpZGdlL3BjaWVfcGNp
X2JyaWRnZS5jDQo+Pj4gQEAgLTU2LDcgKzU2LDYgQEAgc3RhdGljIHZvaWQgcGNpZV9wY2lfYnJp
ZGdlX3JlYWxpemUoUENJRGV2aWNlICpkLCBFcnJvcg0KPj4+ICoqZXJycCkNCj4+PiAgICAgIGlm
IChwb3MgPCAwKSB7DQo+Pj4gICAgICAgICAgZ290byBwbV9lcnJvcjsNCj4+PiAgICAgIH0NCj4+
PiAtICAgIGQtPmV4cC5wbV9jYXAgPSBwb3M7DQo+Pj4gICAgICBwY2lfc2V0X3dvcmQoZC0+Y29u
ZmlnICsgcG9zICsgUENJX1BNX1BNQywgMHgzKTsNCj4+Pg0KPj4+ICAgICAgcGNpZV9jYXBfYXJp
ZndkX2luaXQoZCk7DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMgYi9o
dy92aXJ0aW8vdmlydGlvLXBjaS5jDQo+Pj4gaW5kZXggYWZlOGI1NTUxYzVjLi4zY2EzZjg0OWQz
OTEgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4+ICsrKyBiL2h3
L3ZpcnRpby92aXJ0aW8tcGNpLmMNCj4+PiBAQCAtMjIwOSw4ICsyMjA5LDYgQEAgc3RhdGljIHZv
aWQgdmlydGlvX3BjaV9yZWFsaXplKFBDSURldmljZSAqcGNpX2RldiwNCj5FcnJvcg0KPj4+ICoq
ZXJycCkNCj4+PiAgICAgICAgICAgICAgcmV0dXJuOw0KPj4+ICAgICAgICAgIH0NCj4+Pg0KPj4+
IC0gICAgICAgIHBjaV9kZXYtPmV4cC5wbV9jYXAgPSBwb3M7DQo+Pj4gLQ0KPj4+ICAgICAgICAg
IC8qDQo+Pj4gICAgICAgICAgICogSW5kaWNhdGVzIHRoYXQgdGhpcyBmdW5jdGlvbiBjb21wbGll
cyB3aXRoIHJldmlzaW9uIDEuMiBvZiB0aGUNCj4+PiAgICAgICAgICAgKiBQQ0kgUG93ZXIgTWFu
YWdlbWVudCBJbnRlcmZhY2UgU3BlY2lmaWNhdGlvbi4NCj4+PiBAQCAtMjMwOSwxMSArMjMwNywx
MSBAQCBzdGF0aWMgYm9vbCB2aXJ0aW9fcGNpX25vX3NvZnRfcmVzZXQoUENJRGV2aWNlDQo+KmRl
dikNCj4+PiB7DQo+Pj4gICAgICB1aW50MTZfdCBwbWNzcjsNCj4+Pg0KPj4+IC0gICAgaWYgKCFw
Y2lfaXNfZXhwcmVzcyhkZXYpIHx8ICFkZXYtPmV4cC5wbV9jYXApIHsNCj4+PiArICAgIGlmICgh
cGNpX2lzX2V4cHJlc3MoZGV2KSB8fCAhKGRldi0+Y2FwX3ByZXNlbnQgJiBRRU1VX1BDSV9DQVBf
UE0pKSB7DQo+Pg0KPj4gTWF5YmUgYSBiaXQgbW9yZSBvcHRpbWl6ZWQgYnkgY2hlY2tpbmcgZGV2
LT5wbV9jYXAsDQo+PiBidXQgaXQncyBhbHNvIG9rIGNoZWNraW5nIHByZXNlbnQgYml0LiBGb3Ig
dGhlIHdob2xlIHNlcmllcywNCj4+DQo+PiBSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4NCj5Db3VsZCB5b3UgcGxlYXNlIHJlcGx5IHRvIHRo
ZSBjb3ZlciBsZXR0ZXIgaW5zdGVhZCA/IFRvb2xzIGxpa2UgYjQNCj53aWxsIGFwcGx5IHRoZSBw
cm92aWRlZCB0cmFpbGVycyB0byB0aGUgd2hvbGUgc2VyaWVzIGFuZCBub3QgdGhpcw0KPnBhdGNo
IG9ubHkuDQoNCkdvdCBpdCwganVzdCBkb25lLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

