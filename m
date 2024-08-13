Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C19AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 02:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdh9S-0002aV-4n; Mon, 12 Aug 2024 22:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdh9E-0002X1-MX
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 22:20:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdh9A-0005fT-3t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 22:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723515628; x=1755051628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T9GTQAfAVBXalP5wcqzPK67zuJDi5KoaRxA8G9DY2+c=;
 b=GBEPjiD46rzT0UYBdfrCtDC7Yl0uiPf/W5AVp+VaYGVjEkK2npm3zcGE
 hFPK1qvdpRzpRKCEapv4pHVqEVwjhLent5OHUW+aKFhgGl34vf2cTcQJP
 yuK7mGg3zCsxw1YYUMXwbSmrjt7JAAUdgYaAiDMa1Fw4OYb6SVeYIHcK6
 DRRXMq7kl1+zTy9GbjGWpXN1yKScdrvdnpaj0NfQi6BUtyjShWOo0Fs9l
 T7z2ZwF5z5jcoJJbQlFNil/bXXqzAMlftl5ObByW1dgv1ceorUWaZeXc7
 UcbuBkBY2xm2fG4cx6RIUA3c2gfDYaf+ubprg8Esfz48OQ0c36+Lj7cCV g==;
X-CSE-ConnectionGUID: OQcXls/UQ0i1BMOXzuMfQQ==
X-CSE-MsgGUID: XsOAaRFMTuikrcNrtbiwsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33058075"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; d="scan'208";a="33058075"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 19:20:21 -0700
X-CSE-ConnectionGUID: XjXi33EGRT+GN8BCIffHxQ==
X-CSE-MsgGUID: 2Uh6cbdkTKm9qoIu9LGHgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; d="scan'208";a="58152233"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Aug 2024 19:20:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 19:20:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 19:20:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 19:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWba6J1BcYcKI98coY+TJtlxhQ8O/Wnt03Dr2xUFsyZIQwTBnf37LQS0bVMwX75loMHkgTw0sOeSIQTQWzsfZqzvynsarqY6qvw7EWivtI/D4QXngs8dGliIaajarEJ/V7BAmY4y1Y8CL9ALHKclgM2IPJbFpjRCJvgcRv521+ipYldBtwyysnLfQ0FF895MwpXSc2jk+t+nwyfZxsJnPGEvtuKhV2zPvBjMw72X1zBOnlOYhXqG/9dHK3XCN+AFTo99Os+r7cwtmmwka/zcn1Z0G8Few2KscyoWj+IyHD7/eRAGLHZuRqago+fWYOrfuigQ7m+CIa4kM0nff1nZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9GTQAfAVBXalP5wcqzPK67zuJDi5KoaRxA8G9DY2+c=;
 b=yWYYgrgv3s0ZR/MJe/yjGIY2YKkZnDpPMKKoNOwyAtSZ2XHDyNOm41QNAGim6XbG/iCtbWDykuPJZuneh4CsOLkcKD1OFcVkm8cS7QRnbkVOHexJhWZjJlrOzb5eX2ey/P3ep+F5meQyOHy0EI/8q3pDPP4ewUCroNw/7ENAuCI+rPQjra77dt+Z7zs+jOKtCbUdGU1UUFzxzdfa5DpUThpHX2HdGKhegJE1WXqXQjpU6UmnL9lWOzNxe+WFaqU6U/74TSdvi949y7stuaEgssxRboI1SVbzk+ZkJcKY03rkUDCUs9hpagr5TYYc4AOQLC+QngqBikESE1LI590oQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Tue, 13 Aug
 2024 02:20:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 02:20:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v2 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa5wEF+Nis8FYiJkubkxZ/MAQBaLIZx6OAgAOIR4CAACp8AIAHBXmw
Date: Tue, 13 Aug 2024 02:20:15 +0000
Message-ID: <SJ0PR11MB674466B036500FF8875889AF92862@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-4-zhenzhong.duan@intel.com>
 <cba7ec79-e2db-4919-a1ea-553ed20e0e2b@eviden.com>
 <9ae22a85-9bf5-3d45-2d19-c3371aecf42e@intel.com>
 <7043464a-7085-4ae1-a07c-06785626b640@eviden.com>
In-Reply-To: <7043464a-7085-4ae1-a07c-06785626b640@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6397:EE_
x-ms-office365-filtering-correlation-id: 67bbf8fc-fc42-4858-5138-08dcbb3e7816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?elljM2hUL3BzTlNoUnV6VmViZ09uVTE0dklVcnNmWmdLK1RacEdEZlBVaWdm?=
 =?utf-8?B?UzEwNGZvcDRLcW9tZEYrRDJDZ1Z6OExBRE9EMTZ3dytxWEZNMmZFRmNOTTJZ?=
 =?utf-8?B?anhuUXlFeloyQUlhTmU0NWlKYWIwQno0OEl5NDZxaS9oTkFTdTdpV3JIYk1h?=
 =?utf-8?B?UUx4ZWQzT3lnVWlHMWMyd2VzR0FEd3o3WTZnUi9ia1gzczZVZFRScnYyK1hE?=
 =?utf-8?B?RVEraGpDT0h0MDRWVlM4YVZFTzROZVo3R3dzZGlXMmduMkdOVURDTlZWNmZF?=
 =?utf-8?B?Tk1nOGZrSVgxQlNLcXRkK2Y0ZmlrMnZiUEtKbUhhdmM5U0cyVzFWSFhiUlZ3?=
 =?utf-8?B?N3hNWXNjdGF0ZEhwbDRtRHBMOUVjSEl6UWE5VjBXdjYwbUlwcTV3dUltSFBL?=
 =?utf-8?B?dTZvSWcxOU1HcDlMTHFUUEt4b2RVcW45aFdCaHdhQVVucTUvYzcvMUNVUmkw?=
 =?utf-8?B?bytLQUlMZC9zamFMTndPLzAvTDhaeVZtK1ZsM1lKOTA0ejdVQkJ2S2pWdXJw?=
 =?utf-8?B?SmZ1UkswcFRvZXU3UzB6SmViZUlESjRPNXV2YUkzbmJmekE2SlEyaTR6SUNl?=
 =?utf-8?B?ak5ZOU55ekxnWHU3MXhKNWcwcVc2d2Z3VmphZUJJTlg1Um1aN3FIRXlOQnRv?=
 =?utf-8?B?QkttRCs0aUZ2MUtqQVBPTmo3djh6TEFVdEJkaWErbGxIK00rbUFhZ2RPUG5T?=
 =?utf-8?B?SXVNWU11UURBZkJzTVZPVWJteXBEMXdoV1I4OE0yeW9pejFuZXc0dU1tUW1J?=
 =?utf-8?B?cENjam5OUmhaVFBvWnRsWnVMZ2FtTWdkNGZlVjlJSHJ5R0dNL25ud2E0MkZ4?=
 =?utf-8?B?Y0RnM0Q0SkVnL3kyQ01TZURadmROVDh5NTBGd0RNMUlNYUNObmZtRnpWYlNH?=
 =?utf-8?B?ZDVpSkZ3NWFUbXNiMi8zak44WFpNTGZIZUdIYXprOFE3OUYzZVYyMlFZME1w?=
 =?utf-8?B?WkVGa1Jaa3N5eVo2QkZibjFpa2x0OFJTTXpGRVdnY2h1R0hkYlFBODlDR09W?=
 =?utf-8?B?ZGwxQVpUNGh1MjErVnlmSk0vd2UyWVloblBkclhzVVBZcEp6b2w2T001NC9X?=
 =?utf-8?B?WnAxNmhnNzJSUjl5aFpvOCtYRUxvVnIwVmFKWm5SQmp6YSthMy9BbDA2bC93?=
 =?utf-8?B?OVpPRVB5VjR6MjZRVG90Q2UvdytYTFhwVDVoWU8rNVcwbFRKa1IrUllVSTFC?=
 =?utf-8?B?cEF4Z0dSTGFoeno5MzExK25BalE5SlRLZ3VRZDBqQWI1ZmEwZ2dsYkJibmwy?=
 =?utf-8?B?dm4yYURZYTFqVDlwbnVVR0ZjaDYzZk1IK0xJVDhmaTJSZ1NtSUMvbzh2MGNU?=
 =?utf-8?B?czVQd0w0elg5WWY3bEMvUktQaUZNeFRBdi9KOGpFNk9MS3NDWW05YUk1c1pk?=
 =?utf-8?B?ZUtaRXlKR29paTk0UkhRdVpwVWRVYUVEMWQ5eFJ3YzVEYktHUytjRTY5aENs?=
 =?utf-8?B?MjdpQUMxZEtVVHcxU05WcDBucDRLYmZpdWg4K3lHekVGWERTVHRweTcwWFVq?=
 =?utf-8?B?L3QxWVhNaldld2JRNkwwTjUxS0xCcWVHRW9WRXRuRDZBSVFTMzR3LzQ3RkR4?=
 =?utf-8?B?NUpYSUxUZWNkTitWSU9RVERTeG9KcnYvTE41ci94YWlxTTIwUVVnOWs5bXBr?=
 =?utf-8?B?Vys4L0ZYcExVQ0pTZlFTdm83a3FBRFYwemwreUJqbE9ZMjNWZElscWM2SDF1?=
 =?utf-8?B?aXpydm5qV0RPUXhvVFZ1c1hkMkNvc0VxS1RRWFZvVXJ6UlBHSnhnWEhSNHpi?=
 =?utf-8?B?V3ZKS1RuV2lLSGpwT2doNTVybUVnODFjRUluK2lvYVExNndZREh1NU94b1Jo?=
 =?utf-8?B?QkorZjMrNi9oQkNUdnVzR0d4YXEwNkdXYkp6TEJWK3ZlbEhkU0NlRjJyUlJk?=
 =?utf-8?B?OEprRjFOYUFiaGV2cUdTRTduN01hWE4vcTdqbzNDRExqL2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW9yYXQ2VGFJRERPMzF6alVKT3JiWFI0b0lSWEp4TVJKM1BaT0RYc0Q1QXlI?=
 =?utf-8?B?eE5CMy9QVEhiMThKc0lRZDkrWDZtVHFJMXo0d3hOOW55MHgvQmFaaTJndDVE?=
 =?utf-8?B?R0J0ZXBpZGZWems0TUswaCtCNkhLWXNhckpmYys5ZVJla1MxeXpHMXpFNUhp?=
 =?utf-8?B?TURvM1dwYysrVVgzWS9MWUk2NUxvbmpEY0hpakppOHQzSXdRU1VvbTdXTTJn?=
 =?utf-8?B?elMxVSs0RFl3WW8rdklMT1hRQ1BjdHNZeWEycE04b2RXeUMxNnZ2LzJ2Ynhi?=
 =?utf-8?B?cFZKQUJpQzJKZWwwQnZDajdGZy92ZmRzS3I3MWx6RHB5MG54T25ZRkRScml6?=
 =?utf-8?B?eUFZL0hBdmhPaHNtUjFGMWduWXQyU3FaMldqY25QVlBUMy8xcWdoUXBQMjVw?=
 =?utf-8?B?M1NUR3Y1S2puYjdRMnE1WS9GZ1BPelhZN2dMbVBsRWRWbHRZM2YxTVVjQkls?=
 =?utf-8?B?OUpRUkp4RGREakZkYnl6bThKdHkxRmVzUG1BK3g4WEVRcWxoRkNxNXZmdlA4?=
 =?utf-8?B?dVMzeEZITTFiVStJZ21Ud3JFM0FjeUdnVzRFQzhVMnJVY3hCcHRyc0N4dDNH?=
 =?utf-8?B?U25ZRDRjQU9pNzkrdzdXMW9sL2xlVXhMMWdXVVg2NVc2YUQveXpzLzFIdVN5?=
 =?utf-8?B?N2JFeUtYQXdMaDFwTUR6R1dnemUxSW9tTnNXajlYb2RlK2pNNXRSNjd2U3Er?=
 =?utf-8?B?WWFmMkhZaC9DeFNqOE0yQzVXVE0zTjJnTjZOMGF2SXp0MFNVRlNVdFhJdFRB?=
 =?utf-8?B?U1RXNUFYNzlMd045RmdoQTVRWjRQRHNPS0dYNUFabXdDTlhOdEh0R2hsdFNk?=
 =?utf-8?B?Y2R1Ny9vTVd0T3ZsM3lYVjhnVGgybkt1dGZ6Zy81LzA1OFRwNHVIcEkzMHZH?=
 =?utf-8?B?cVI1OWtvSGV6TWx4cTBDeE0vY2FRdHdxNkFZRk1YbXZXRWxiVDB6aUJrVkY5?=
 =?utf-8?B?bmpmemFUNHBGQWlKZlNsY1NOZUlidzRrbW02SFY2VjZPNkRnei9MRWY1RDZu?=
 =?utf-8?B?bE9ydisrZWJETXJsWkwra1NRYjR1SERLMC9yMEsyZG1qNFVPcGdjRVFObGhG?=
 =?utf-8?B?OHJyUlB0dEZiZ2RxVDYvdFRpR3JUcjJZNll4MVBNcHdQWEduU3RnZHFVZ29K?=
 =?utf-8?B?T3NpMTZvenhpRzB0c2NrY0RQVWxaVnpka3lyNzlzTFJyMHJlTnZLUGVyNWFp?=
 =?utf-8?B?Z1pqTjNoay9RUjU0SWc4aDkxQ0VhaUt6SkZSZ1gxUzM5VW4vLy90M0JLUEJF?=
 =?utf-8?B?a3BDSDFnbkIxVmFFSU5PdEFNRU5tNXRuZytZYlJENm1vYkpYdmhzaVNxWHEr?=
 =?utf-8?B?dmhUdjNqWmhHR1BIeFVuL1lyVnZmOEtaZFZBa3VFYzRmTUFpKzZHL24vQzNC?=
 =?utf-8?B?QkR0dXZHL2V0cm0wZWhvL1pzd0kyZ0REL3lQSit1MkVVUml0eHRlVWdoTC9a?=
 =?utf-8?B?dHZKTThpRjZTTkNueUcxWGYwTWNWdmFUSlFUYlIrS0RvOXFsbHorYnBLZTdN?=
 =?utf-8?B?WHE4TTNEaFpkY0Zkd244VUtwbUo3WDlRb3dZWndqQ21WVG5yZHpjakVvK1Jq?=
 =?utf-8?B?K0JkMVlWdmpQUTJWZG80UWxYdWtJMHVnQXd6a0hLNTR6ckNDcWZndEZ6bXJX?=
 =?utf-8?B?Y3RsblIrWnhGRElBRE9KckpRd1lGUmxIeEJPWjZ4Z2dTemtaSnVHWUFuYjYy?=
 =?utf-8?B?SlpvUGhuWC9mbUxtbEtmYk8wMWlwcjhQSFhFYlpzblY3eWJDRHRJR3dWN1d3?=
 =?utf-8?B?WVB2L21zU3kzdWltenJBdlphSElBVHBWdmhWUnpzQm5MUy9FZm9PSkZQbHVQ?=
 =?utf-8?B?dUVpR3hZcXVsbEhWMFZnT0xHQ3lwdzVsYWFZWVZteFpWNm0xRXplM1BrcC9k?=
 =?utf-8?B?M1VBdldzb1lYeHN3cHdjOVdPaGpKQmIzTC9wMDFWNFZwajVuT2dRRk8vVGUy?=
 =?utf-8?B?WFFHOUhaUllWNUlkclJtRjlkRThFSHpJN2dxNnhrbmY1SXo4VjVmR2xiODJs?=
 =?utf-8?B?TzQrNDVwa0hBMWhtZW5Gdm85QjdkVndXUmxxOHVyOU9Sb0lPN09Fem9RdmMr?=
 =?utf-8?B?OWxFNmljemdYVHczRWV0TmdmTTQ2dGdOMUgrQjBVdk5pdlJqWWg2TWdpT0VQ?=
 =?utf-8?Q?5b8jH1lGt2Y8+sVdjyH0PUOeB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bbf8fc-fc42-4858-5138-08dcbb3e7816
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 02:20:15.6632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4YQr7wU0G16E23++eish/vsKX6HZFXQR9drEPN/ajMX7AhnDXLAzJR3uGSOlxzO+hjtAOTXKS/Kb6JDHhMdcJu59HeoDRGg8jqUUoVJ8nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlhYmxlIGZv
cg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+DQo+DQo+T24gMDgvMDgvMjAyNCAxNDozMSwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLA0KPj4gdW5sZXNzIHRoaXMgZW1haWwg
Y29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4+IGlz
IHNhZmUuDQo+Pg0KPj4NCj4+IE9uIDgvNi8yMDI0IDI6MzUgUE0sIENMRU1FTlQgTUFUSElFVS0t
RFJJRiB3cm90ZToNCj4+Pg0KPj4+IE9uIDA1LzA4LzIwMjQgMDg6MjcsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNo
bWVudHMgb3IgY2xpY2sgbGlua3MsDQo+Pj4+IHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20g
YSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50DQo+Pj4+IGlzIHNhZmUuDQo+
Pj4+DQo+Pj4+DQo+Pj4+IEFkZCBhbiBuZXcgZWxlbWVudCBzY2FsYWJsZV9tb2RlIGluIEludGVs
SU9NTVVTdGF0ZSB0byBtYXJrDQo+c2NhbGFibGUNCj4+Pj4gbW9kZXJuIG1vZGUsIHRoaXMgZWxl
bWVudCB3aWxsIGJlIGV4cG9zZWQgYXMgYW4gaW50ZWxfaW9tbXUgcHJvcGVydHkNCj4+Pj4gZmlu
YWxseS4NCj4+Pj4NCj4+Pj4gRm9yIG5vdywgaXQncyBvbmx5IGEgcGxhY2VoaG9sZGVyIGFuZCB1
c2VkIGZvciBhZGRyZXNzIHdpZHRoDQo+Pj4+IGNvbXBhdGliaWxpdHkgY2hlY2sgYW5kIGJsb2Nr
IGhvc3QgZGV2aWNlIHBhc3N0aHJvdWdoIHVudGlsIG5lc3RpbmcNCj4+Pj4gaXMgc3VwcG9ydGVk
Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IMKgwqAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
fMKgIDEgKw0KPj4+PiDCoMKgIGh3L2kzODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqAg
fCAxMiArKysrKysrKystLS0NCj4+Pj4gwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+PiBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
DQo+Pj4+IGluZGV4IDFlYjA1YzI5ZmMuLjc4OGVkNDI0NzcgMTAwNjQ0DQo+Pj4+IC0tLSBhL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9p
bnRlbF9pb21tdS5oDQo+Pj4+IEBAIC0yNjIsNiArMjYyLDcgQEAgc3RydWN0IEludGVsSU9NTVVT
dGF0ZSB7DQo+Pj4+DQo+Pj4+IMKgwqDCoMKgwqDCoCBib29sIGNhY2hpbmdfbW9kZTvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSTyAtIGlzIGNhcCBDTSBlbmFibGVkPyAqLw0KPj4+PiDC
oMKgwqDCoMKgwqAgYm9vbCBzY2FsYWJsZV9tb2RlO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBSTyAtIGlzIFNjYWxhYmxlIE1vZGUNCj4+Pj4gc3VwcG9ydGVkPyAqLw0KPj4+PiArwqDCoMKg
IGJvb2wgc2NhbGFibGVfbW9kZXJuO8KgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFJPIC0gaXMgbW9k
ZXJuIFNNIHN1cHBvcnRlZD8gKi8NCj4+Pj4gwqDCoMKgwqDCoMKgIGJvb2wgc25vb3BfY29udHJv
bDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUk8gLSBpcyBTTlAgZmlsZWQNCj4+Pj4gc3Vw
cG9ydGVkPyAqLw0KPj4+Pg0KPj4+PiDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCByb290O8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBDdXJyZW50IHJvb3QgdGFibGUgcG9pbnRlciAq
Lw0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+Pj4+IGluZGV4IGUzNDY1ZmMyN2QuLmMxMzgyYTU2NTEgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+Pj4gQEAgLTM4NzIsNyArMzg3MiwxMyBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9jaGVj
a19oaW9kKEludGVsSU9NTVVTdGF0ZQ0KPj4+PiAqcywgSG9zdElPTU1VRGV2aWNlICpoaW9kLA0K
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+Pj4+IMKgwqDCoMKgwqDC
oCB9DQo+Pj4+DQo+Pj4+IC3CoMKgwqAgcmV0dXJuIHRydWU7DQo+Pj4+ICvCoMKgwqAgaWYgKCFz
LT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qIEFsbCBjaGVja3Mg
cmVxdWVzdGVkIGJ5IFZURCBub24tbW9kZXJuIG1vZGUgcGFzcyAqLw0KPj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHRydWU7DQo+Pj4+ICvCoMKgwqAgfQ0KPj4+PiArDQo+Pj4+ICvCoMKgwqAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiaG9zdCBkZXZpY2UgaXMgdW5zdXBwb3J0ZWQgaW4gc2NhbGFibGUg
bW9kZXJuDQo+Pj4+IG1vZGUgeWV0Iik7DQo+Pj4+ICvCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPj4+
PiDCoMKgIH0NCj4+Pj4NCj4+Pj4gwqDCoCBzdGF0aWMgYm9vbCB2dGRfZGV2X3NldF9pb21tdV9k
ZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwNCj4+Pj4gaW50IGRldmZuLA0KPj4+PiBA
QCAtNDI2Miw5ICs0MjY4LDkgQEAgc3RhdGljIGJvb2wNCj52dGRfZGVjaWRlX2NvbmZpZyhJbnRl
bElPTU1VU3RhdGUNCj4+Pj4gKnMsIEVycm9yICoqZXJycCkNCj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfQ0KPj4+PiDCoMKgwqDCoMKgwqAgfQ0KPj4+Pg0KPj4+PiAtwqDCoMKgIC8qIEN1cnJl
bnRseSBvbmx5IGFkZHJlc3Mgd2lkdGhzIHN1cHBvcnRlZCBhcmUgMzkgYW5kIDQ4IGJpdHMgKi8N
Cj4+Pj4gwqDCoMKgwqDCoMKgIGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJVCkg
JiYNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzQ4QklU
KSkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhC
SVQpICYmDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAhcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+Pj4g
V2h5IGRvZXMgc2NhbGFibGVfbW9kZXJuIGFsbG93IHRvIHVzZSBhIHZhbHVlIG90aGVyIHRoYW4g
Mzkgb3IgNDg/DQo+Pj4gSXMgaXQgc2FmZT8NCj4+DQo+PiBUaGUgY2hlY2sgZm9yIHNjYWxhYmxl
X21vZGVybiBpcyBpbiBwYXRjaDE0Og0KPj4NCj4+IGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9T
VF9BV180OEJJVCkgJiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+Pg0KPj4gZXJyb3Jfc2V0Zyhl
cnJwLCAiU3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkIiwNCj4+IFZURF9IT1NU
X0FXXzQ4QklUKTsNCj4+DQo+PiByZXR1cm4gZmFsc2U7DQo+Pg0KPj4gfQ0KPj4NCj4+IExldCBt
ZSBrbm93IGlmIHlvdSBwcmVmZXIgdG8gbW92ZSBpdCBpbiB0aGlzIHBhdGNoLg0KPlllcywgeW91
IGFyZSByaWdodCwgaXQgd291bGQgYmUgYmV0dGVyIHRvIG1vdmUgdGhlIGNoZWNrIGhlcmUuDQo+
DQo+QnV0IEkgdGhpbmsgdGhlIGZpcnN0IGNoZWNrIHNob3VsZCBhbHNvIGZhaWwgZXZlbiB3aGVu
IHNjYWxhYmxlX21vZGVybg0KPmlzIGVuYWJsZWQgYmVjYXVzZSB2YWx1ZXMgb3RoZXIgdGhhbiAz
OSBhbmQgNDggYXJlIG5vdCBzdXBwb3J0ZWQgYXQgYWxsLA0KPndoYXRldmVyIHRoZSBtb2RlLg0K
PlRoZW4sIHdlIHNob3VsZCBjaGVjayBpZiB0aGUgdmFsdWUgaXMgdmFsaWQgZm9yIHNjYWxhYmxl
X21vZGVybiBtb2RlLg0KDQpSaWdodCwgSSB3cm90ZSB0aGF0IHdheSB3aXRoIGEgcG9zc2libGUg
cGxhbiB0byBzdXBwb3J0IFZURF9IT1NUX0FXXzUyQklULg0KV2hhdCBhYm91dCB0aGlzOg0KDQog
ICAgaWYgKChzLT5hd19iaXRzICE9IFZURF9IT1NUX0FXXzM5QklUKSAmJg0KICAgICAgICAocy0+
YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYNCiAgICAgICAgIXMtPnNjYWxhYmxlX21v
ZGVybikgew0KICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJTY2FsYWJsZSBsZWdhY3kgbW9kZTog
c3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkLCAlZCIsDQogICAgICAgICAgICAg
ICAgICAgVlREX0hPU1RfQVdfMzlCSVQsIFZURF9IT1NUX0FXXzQ4QklUKTsNCiAgICAgICAgcmV0
dXJuIGZhbHNlOw0KICAgIH0NCg0KICAgIGlmICgocy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180
OEJJVCkgJiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQogICAgICAgIGVycm9yX3NldGcoZXJycCwg
IlNjYWxhYmxlIG1vZGVybiBtb2RlOiBzdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGlzOiAl
ZCIsDQogICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQVdfNDhCSVQpOw0KICAgICAgICByZXR1
cm4gZmFsc2U7DQogICAgfQ0KDQpUaGFua3MNClpoZW56aG9uZw0K

