Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76A3D5C0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 03:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVLfz-0005aY-KJ; Mon, 15 Dec 2025 22:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vVLfx-0005Zf-Jb
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 22:24:37 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vVLfu-000354-8D
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 22:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765855474; x=1797391474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q+j7PDvhN9r8ALbpKp6Cstf4QjtaifGPO3QF+YSQmDU=;
 b=Z5zizHG8sHt24bKOCV7gQ18sBcWQBreOqhlTcTjdYU55x8Dn1xRUgEtc
 CFzVboSO2F/9WPiicsxNwtpjWHMHoU8Js7AAmWfv9mnDAlmfalyQu1rxc
 ailJdDe1yCgf80YETL8M2xsuUcMdFbLj8pL28bq3XGrLxDbuZnLnq0J0V
 G2Iz0eskz1Ls+aLBoFcfj/KmynbyynGyrUdhE1C16+Xzd2CYpw/qIgUfK
 lW73HzOFWmxwoUpaCr+M1agWdZ8m+bjK/UakD3llMNRmvDvzVHmJQwzJK
 F56SbtgvqdFHmxBQonameV4CK3XVRrrfQT2IOf0uNRUCnNu+8ReLKbs5I g==;
X-CSE-ConnectionGUID: JE/0CYxHR5Sbfo4mG2vFig==
X-CSE-MsgGUID: rJRRnNTtR3qi88UH8j7jnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="93244646"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="93244646"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 19:24:32 -0800
X-CSE-ConnectionGUID: Q8/9wKW5S7SbihBhRVevKQ==
X-CSE-MsgGUID: n2HISrF3QOO1ovBa5pI/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="221265424"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 19:24:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 19:24:31 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 19:24:31 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 19:24:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjMuP6dWKmvUmqqmf9Bo58M1t0eDJxRN4f6ThK9ekfPMapFXO/cODXV93dM1nO7/Yv0JZjeVhtDBhtnKsapRXMguMiEXqx7Hu6wcg+3u1OKrPAdMaRSbZOshSSwfkCsu3JOhvA9Kczwil5TvZyik9kei5dv3g9M0ukZok/ZfkCd+KWxMLKJlaLP8+viOiY/TKL5RolIe63Iy0fG9vuCYsruHt08/RaADP63/Ur3iv/5mO/3RSSJMMzZO1MZsXhb7QBWU7+7OOY+L53SwXr+194pBJUrvfhW9YcUrH0guCeZUvLPxLgE45Y8N4M65ZlMtSsyTm9F+scGnL1qmePxuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+j7PDvhN9r8ALbpKp6Cstf4QjtaifGPO3QF+YSQmDU=;
 b=Z+XzQsNHvBVyDmRbbUeKeea8sNa9ZhDgMMsRrmgruU0QM8GNaPF2qsrQz+6HoZSkeovBZo7EGlnxiBV3iPMTvXSU1QWMe6SRKMwpF+ZgmrNiW6yByb2F3TTbn1r5iwqi7ERC830JShalqR8R9BmJt4OjxFQ8SoaI6s5saeyGcJPdvTNhTfbntnj9uNf/gi96uFJzQlVUlnZs1WxQUtLVZssLzoRBoej/rH3tKjJtOGyJ60+Blp7m58VNx0dfTRUWVCyWNeC1tkeXBorg6UyBnoM7yPxb7mr0eMpHVAYoOciYrVo7Zg1mXMH9KuE0+aZbKWoWabgcXMJvYyipSJWalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB7893.namprd11.prod.outlook.com (2603:10b6:610:12e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 03:24:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 03:24:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
 passthrough device
Thread-Topic: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
 passthrough device
Thread-Index: AQHcbY9AReLaq+3KWEek0HB2hE9cArUivIcAgADTNdA=
Date: Tue, 16 Dec 2025 03:24:23 +0000
Message-ID: <IA3PR11MB913661A98BDF8BE7019277D192AAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
 <56e582e7-d14c-46f6-b2cb-4a328315d505@redhat.com>
In-Reply-To: <56e582e7-d14c-46f6-b2cb-4a328315d505@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB7893:EE_
x-ms-office365-filtering-correlation-id: 24f367b6-d533-425a-53f5-08de3c529bed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MlpJZThUUCtrbEl4MzZUd1BleWxNYWVtWG45MTdDaE9IdmltRzhYYlNuTzgw?=
 =?utf-8?B?ajY3Tk5ZWFJRNDRMWnpzMnRPSXViaUhYRXc1R0wzWWZCWXRhem1YdENla2xD?=
 =?utf-8?B?N0t3VTZZUUdVQkhRR0RBd1pVWEMwY1VXT3RRdnUxbE5JTDk5Mlp6b29BK0lV?=
 =?utf-8?B?UnUrY3Q5emRBTzZ1ZTNHaWRtakM3d2wyU09HTW9yMzhRaDBwQ3dBd1paR3JP?=
 =?utf-8?B?NTBTODlOVHNhaDdNVE1QeHNnd2VVRlBGUFNWazZETnBhL2ZyS1JoU3QxRzMy?=
 =?utf-8?B?UjJVMUpkZ0dSdnlScWYyNmZJdVhCL2tTY0NGSEQ5TXZBQW1EWWF4TDBFem9y?=
 =?utf-8?B?eVZlMVo3QWRTbWwwczFOSXhRT1NFR2N0V2w0bjlLMzRvaTV5cE5qMm9XR0sx?=
 =?utf-8?B?eTNMZmxlVFZWOWJNUjd6eHZwWktYc3c5TGN4RGMyUWxLUmk2RUZMNGh3NnVZ?=
 =?utf-8?B?b0pRV3dDT0tZSGdjL1NmUEZVSi9SUWpDYWtvbmJoSE5NS0c1aFFjei80R1RM?=
 =?utf-8?B?NXRLUjlhdHhNLzMvUzRTWlEzQzJSVUlEQ1d3SmpUazhqb1l5bDF2amRXTEhB?=
 =?utf-8?B?eEorWnZyT2JCNGw3MUlqTHpXNkFScHNFRnluanN5R3BoekhMUjJPUU95a0Zo?=
 =?utf-8?B?ampiZE9ibVVYTm0zdnRDbThMZHpOYTkxU3k0SmQ1UW5pUnZ4WW0weGprR3U2?=
 =?utf-8?B?UG1XNkQvSVd0QUoyM3IwMmpPaG5JSENzQndRQkV5cjFWNWFZTnlSaGlOdjRW?=
 =?utf-8?B?YjJ4VjYxZlZtY3MxY3V5Q0l4TmVlRUhRQjFZNGpOb2NaTitOTlo2M3BuTXJt?=
 =?utf-8?B?cm94Y3lZWVJXcEZYdnpIQzhFSVEvTjRadFpWYWhlQ29jZ2pTVTNBSW9GZmRl?=
 =?utf-8?B?R0kyb1VDOGZDa3R3eUd2N0k1MDhFYmhqckVTZlVjSVhJN0QySUxkd3ZzcW1V?=
 =?utf-8?B?ckQ0TFJsaWhKaUZtQ01ZN3h6c3MyVW1lU0hHM1MxcFFkRXZyZ3FBYkpJMW9p?=
 =?utf-8?B?VS9QUFdiZVdFcDJMNUk1RTdwTC9DYjhEMWhMZzFkcE1wV0crS0FKbkprMXZH?=
 =?utf-8?B?OWkzV3RFUW5qWTBreU90OGVkMktwQ3VLWllqbERUb1dhWFVSUmxjNjY5YnA4?=
 =?utf-8?B?NHR4Q0tOWHlNUVdqT1hBSGVQVmpVVnlNbHdIVU1WTVlqNXF5Smt4NG14dnJG?=
 =?utf-8?B?Z01sNVcxYXlDRHQ4MW1BeVRvQWsrSE5RS2NHeEM5ZDFPNTJuZ29Rc2lteXBW?=
 =?utf-8?B?ZkZPTGgrZCtzbkU2OWpsSlhvYjRnYUhQb0pWSk41OW11d0pkWERFYXBON2Vo?=
 =?utf-8?B?WCs2MjZqYUIybnVCL2plczVIRExxZm5yRldDSk4zRDVLaDZaMlZKVXkrTzNv?=
 =?utf-8?B?UDFxS0xseDRybXpCWWhYNmF2OEg3a1ZJYTlXYXdyb0laL0NFTHVhUXVmdDJ4?=
 =?utf-8?B?YjdLSlZEOFlrL0VXaUxMTGEyZ0dWanUxWGx2ZTNaZ2QvQVhlRmRHNExWdmwy?=
 =?utf-8?B?c2hnUkJPYWVxUlVpalpLSFlSdW5zd3pkbU8rM2J0WjFGWlpCZVZzRlNscFls?=
 =?utf-8?B?WnJ0a2cxREdBbEh3ZXU4MW1FdzlvdU13STQ3aURTbUVmMWhNdnNjNTlCVkNp?=
 =?utf-8?B?cnplbnRuU3M4QndRSFFGTHVHd0k3a016d0JWSElWcjhLbTFkSjBNTkw2cEow?=
 =?utf-8?B?TWtZMjh4dHUrZUxLT2VUQ093U3NqTG93dkVVRzFmUXNTOE9zSzd4Mlo2ejlS?=
 =?utf-8?B?SlZQVVYyWUZIMjRKazg3Yk1YL1MvWU1ESGMrbUdPcTRaSEpsM3orRSsreE55?=
 =?utf-8?B?dEZra1FkSW5QMkorR20zSjBkYnY5ZE50WmlvNVF4M3R0L2RWSmFsYTdDMGxl?=
 =?utf-8?B?bUJqMEVvckY0QklKbWVyRGV6eG1IUjQ0Rjl1bkhCYzRPSFFLTmIwNGVNNUVL?=
 =?utf-8?B?VVB1VnNaM3V4SVVtTVk4QisvVHhXS0gzQUNSTkdqZzk4TFQvNGw1TkVXQ1FZ?=
 =?utf-8?B?OHI2RGNVNSt3TVpUUXNydmJ3d29ua2EvcmhhY0dBR09udzlkckZsQUNXQitE?=
 =?utf-8?Q?+Bzf6O?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5ma3FrOHZPeUFSWlFXb2pZNm1RQ2tnb21rZzZVN1lTaTBhU2lLUlJ4eEFn?=
 =?utf-8?B?RDNxZEJkMm4vbVF1eGxpSjluSDFOM1dVdVZaUGYrK3l4amtaeXNMWWhZSFdL?=
 =?utf-8?B?M1RiV2JSdS9hVzB0NGtvNk1lU3lKbi9ITm5BUC9INXcxa0U5WU5WbkpEZG43?=
 =?utf-8?B?dXM0OWViWXc3amJiM0Y5cm1tZWNXL0Z3NldQdUtFaWZQbFNtWWtjRmZFeGNT?=
 =?utf-8?B?VmhVYWNJUDZ1MXZpSGpYaWhYeFd0NmRkWlNmQVJwZmowcndxUXV0UnFxL2hn?=
 =?utf-8?B?OXc2dm5QQ29SYVgxMmhIYW5PWUJLZm9DV0tLWm5rc0NPamY1S01QTk9zNTht?=
 =?utf-8?B?eHBmekI0TVo0TkhUbHp5VmdVSWJ5MDYzQjZkQnA4WXQzNGJwaW4rRFRhcjE3?=
 =?utf-8?B?dElTemJVUXg1NGRJWWh1cEF4ZzRpODlmNDBSVzNSQUlTc2NHQ2NzTERTbGdL?=
 =?utf-8?B?eFNjSUJ6UE95VE54VmJtQWF0azhXK1lIQllrT2UvcWtPb1lobXRlN0hWVnNO?=
 =?utf-8?B?NnpndVQ3ZTdCS1hEbDlTRlZYeUlHSWJJa0VkbGNSRGNQQXFoaGdvdmZEK3Bt?=
 =?utf-8?B?OXB2MCtDeFVDZjRPOVdtRWV4S3JjVS9sNUNjQW96Z2FHYzBlSmhldzRWNHlX?=
 =?utf-8?B?eko5RUN5WU8xSGYwa1loWGVxS3cyRWhEV0s5VFFoL1YvR1ZLaExpNDFQcTNY?=
 =?utf-8?B?RC9Dc3BONlRJTVp6TURTZGZPRkwyT3drMlVmZEpyWXNCY2hWMmpvcE5FbDZy?=
 =?utf-8?B?RHlNSDg3OUUxWndiR3MrQkhIbWlJZ0ZDRlVqTUxuOXluNEtPa1JCVVVUdWc5?=
 =?utf-8?B?aXpjSHNnZGE4YnMyWXFoMHh4MVJHdEhlWi9pdmtUKzRzdHZtMG5LMlJkaHRS?=
 =?utf-8?B?MmIvelVLaUt0OElvV3NWM1hvN1VYUUFad2cyeGhmdlh0QTVHZExNeUpUU1hn?=
 =?utf-8?B?ckszRXNGY0taczY4Slo0aUZTS1dHTnlERXV3VHM5Mm9sNTljVVgrNDZkQzBO?=
 =?utf-8?B?bGE2aUl3M0pvc25acDNrNW9zR2dqRUgvMlNmVU4yelFUWklnZUViWFpsL3N0?=
 =?utf-8?B?dEIxRk90NklsaGtEKzdGdWR5VEY0R1pGQkJtM2l5OUlHUi8ybDRNdW5PVWox?=
 =?utf-8?B?M3JVbTIyUCtyZE1zamJINjZmZnZRaGNsNjM2T05PaFgySDdTUjl1TDVWdUZs?=
 =?utf-8?B?ZkJZeEIvUWxFZTRlUVNjV2I4YTVHN1RUOGFwYUtWenR2SGRma1NraldZZk5U?=
 =?utf-8?B?UkdDbytHaFlUaFcxVkY0em85bVpSRFJvVCt5dGRVMDBYcjd4bFdOZENEUDBo?=
 =?utf-8?B?WGxWaU02VlMzZmpNQnRLM21CSmVaczBwazZEbzZJKzNJSHMyYXV6dVNRaGU1?=
 =?utf-8?B?a2FZSm54MHVZcDVhQ2c0Si9DQXJjSk55MmNZSDUyQlVpVjl0MHhoNjBHZmdU?=
 =?utf-8?B?RjM4REZEY1pocHJ5dEM3NmVhNFRMdzQvaFE2UWlGQnlGd295M29XcTl0a3pJ?=
 =?utf-8?B?MCtZUmVJbm1MOERieTZKazhQakI1c01WYzY2ZXRxTTU5YkJrUVFuNHZiY0hY?=
 =?utf-8?B?UW5mMUM2YWQ1UGFaRlZMa2dZS0tyUFZYMm41dFozY3JkdE9mWmdJRHlUVy9U?=
 =?utf-8?B?cWFzN3VaZ1RFTmdMcjBybkVQSWlUcjlHbGhtTGJ4aFZaVElYZk1uRE9ENUN6?=
 =?utf-8?B?dndZK2ZqblBiK0dKeTBJdUNBSjFPN00wRzdpRklqd1ZuUUtoMW5WTWFYbCtL?=
 =?utf-8?B?UjcrNUdRQzRhRlJpVnRuS1VHcTJDTHRtK0JXUk1KQXJSZTZjbitGLzZibDFN?=
 =?utf-8?B?WUpMU00wUW9OWThEZXE0eWV6aytHM1pRS3c5ODdPdGt2bUdhU2VXTWNTaWF1?=
 =?utf-8?B?T0ZvUmhhMHViRnEvMGszSUtwUWlhZUs5NWlTVFA3ZHlEUUtBRWxZcHBHVE16?=
 =?utf-8?B?VTkrdWhENVZ5NU9xSG9aVUhQZHNQT3ExOXk5YzAvbzhPeHMyTXkwc2pMSHNE?=
 =?utf-8?B?OGN4aDFjRU9NSHF0NGtvVW9rNDViV1hJT3EwK1FsTFZxdWNsUjA1OS8rM3pW?=
 =?utf-8?B?NWFXV25Sdy9xYkxqUTFSdnlDdklDUjlJSkZvNStQS3l6WG1kSE1tYXd3T1VC?=
 =?utf-8?Q?mvGeZtZoUNf4Nx/3dF9IBqAcp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f367b6-d533-425a-53f5-08de3c529bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 03:24:23.3838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLRj5qo/vHVEnuiA11u9uvIWoJIN/+ULD8pog09iWvKFzlt0P9unEf6BLHimCkZZUVr5JVbUvt0oXIEOrEFWvlsF2HwmD9YEo9k0tN+aPBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7893
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDAv
MTldIGludGVsX2lvbW11OiBFbmFibGUgZmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gZm9yDQo+cGFz
c3Rocm91Z2ggZGV2aWNlDQo+DQo+SGVsbG8gWmhlbnpob25nDQo+DQo+T24gMTIvMTUvMjUgMDc6
NTAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gQmFzZWQgb24gQ8OpZHJp
YydzIHN1Z2dlc3Rpb25zWzFdLCBUaGUgbmVzdGluZyBzZXJpZXMgdjggaXMgc3BsaXQgdG8NCj4+
ICJiYXNlIG5lc3Rpbmcgc2VyaWVzIiArICJFUlJBVEFfNzcyNDE1X1NQUjE3IHF1aXJrIHNlcmll
cyIsIHRoaXMgaXMgdGhlDQo+PiBiYXNlIG5lc3Rpbmcgc2VyaWVzLg0KPj4NCj4+IEZvciBwYXNz
dGhyb3VnaCBkZXZpY2Ugd2l0aCBpbnRlbF9pb21tdS54LWZsdHM9b24sIHdlIGRvbid0IGRvIHNo
YWRvd2luZw0KPm9mDQo+PiBndWVzdCBwYWdlIHRhYmxlIGJ1dCBwYXNzIGZpcnN0IHN0YWdlIHBh
Z2UgdGFibGUgdG8gaG9zdCBzaWRlIHRvIGNvbnN0cnVjdCBhDQo+PiBuZXN0ZWQgSFdQVC4gVGhl
cmUgd2FzIHNvbWUgZWZmb3J0IHRvIGVuYWJsZSB0aGlzIGZlYXR1cmUgaW4gb2xkIGRheXMsIHNl
ZQ0KPj4gWzJdIGZvciBkZXRhaWxzLg0KPj4NCj4+IFRoZSBrZXkgZGVzaWduIGlzIHRvIHV0aWxp
emUgdGhlIGR1YWwtc3RhZ2UgSU9NTVUgdHJhbnNsYXRpb24gKGFsc28ga25vd24gYXMNCj4+IElP
TU1VIG5lc3RlZCB0cmFuc2xhdGlvbikgY2FwYWJpbGl0eSBpbiBob3N0IElPTU1VLiBBcyB0aGUg
YmVsb3cNCj5kaWFncmFtIHNob3dzLA0KPj4gZ3Vlc3QgSS9PIHBhZ2UgdGFibGUgcG9pbnRlciBp
biBHUEEgKGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3MpIGlzIHBhc3NlZCB0bw0KPmhvc3QNCj4+IGFu
ZCBiZSB1c2VkIHRvIHBlcmZvcm0gdGhlIGZpcnN0IHN0YWdlIGFkZHJlc3MgdHJhbnNsYXRpb24u
IEFsb25nIHdpdGggaXQsDQo+PiBtb2RpZmljYXRpb25zIHRvIHByZXNlbnQgbWFwcGluZ3MgaW4g
dGhlIGd1ZXN0IEkvTyBwYWdlIHRhYmxlIHNob3VsZCBiZQ0KPmZvbGxvd2VkDQo+PiB3aXRoIGFu
IElPVExCIGludmFsaWRhdGlvbi4NCj4+DQo+PiAgICAgICAgICAuLS0tLS0tLS0tLS0tLS4gIC4t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgICAgICB8ICAgdklPTU1VICAgIHwg
IHwgR3Vlc3QgSS9PIHBhZ2UgdGFibGUgICAgICB8DQo+PiAgICAgICAgICB8ICAgICAgICAgICAg
IHwgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0nDQo+PiAgICAgICAgICAuLS0tLS0tLS0t
LS0tLS0tLS8NCj4+ICAgICAgICAgIHwgUEFTSUQgRW50cnkgfC0tLSBQQVNJRCBjYWNoZSBmbHVz
aCAtLSsNCj4+ICAgICAgICAgICctLS0tLS0tLS0tLS0tJyAgICAgICAgICAgICAgICAgICAgICAg
IHwNCj4+ICAgICAgICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgIFYN
Cj4+ICAgICAgICAgIHwgICAgICAgICAgICAgfCAgICAgICAgICAgSS9PIHBhZ2UgdGFibGUgcG9p
bnRlciBpbiBHUEENCj4+ICAgICAgICAgICctLS0tLS0tLS0tLS0tJw0KPj4gICAgICBHdWVzdA0K
Pj4gICAgICAtLS0tLS18IFNoYWRvdyB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0t
LS0tDQo+PiAgICAgICAgICAgIHYgICAgICAgIHYgICAgICAgICAgICAgICAgICAgICAgICAgICB2
DQo+PiAgICAgIEhvc3QNCj4+ICAgICAgICAgIC4tLS0tLS0tLS0tLS0tLiAgLi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLg0KPj4gICAgICAgICAgfCAgIHBJT01NVSAgICB8ICB8IEZpcnN0
IHN0YWdlIGZvciBHSU9WQS0+R1BBICB8DQo+PiAgICAgICAgICB8ICAgICAgICAgICAgIHwgICct
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScNCj4+ICAgICAgICAgIC4tLS0tLS0tLS0tLS0t
LS0tLyAgfA0KPj4gICAgICAgICAgfCBQQVNJRCBFbnRyeSB8ICAgICBWIChOZXN0ZWQgeGxhdGUp
DQo+PiAgICAgICAgICAnLS0tLS0tLS0tLS0tLS0tLVwuLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgICAgICB8ICAgICAgICAgICAgIHwgICB8IFNl
Y29uZCBzdGFnZSBmb3IgR1BBLT5IUEEsIHVubWFuYWdlZA0KPmRvbWFpbnwNCj4+ICAgICAgICAg
IHwgICAgICAgICAgICAgfCAgICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLScNCj4+ICAgICAgICAgICctLS0tLS0tLS0tLS0tJw0KPj4gPEludGVsIFZULWQgTmVz
dGVkIHRyYW5zbGF0aW9uPg0KPj4NCj4+IFRoaXMgc2VyaWVzIHJldXNlIFZGSU8gZGV2aWNlJ3Mg
ZGVmYXVsdCBIV1BUIGFzIG5lc3RpbmcgcGFyZW50IGluc3RlYWQgb2YNCj4+IGNyZWF0aW5nIG5l
dyBvbmUuIFRoaXMgd2F5IGF2b2lkcyBkdXBsaWNhdGUgY29kZSBvZiBhIG5ldyBtZW1vcnkNCj5s
aXN0ZW5lciwNCj4+IGFsbCBleGlzdGluZyBmZWF0dXJlIGZyb20gVkZJTyBsaXN0ZW5lciBjYW4g
YmUgc2hhcmVkLCBlLmcuLCByYW0gZGlzY2FyZCwNCj4+IGRpcnR5IHRyYWNraW5nLCBldGMuIFR3
byBsaW1pdGF0aW9ucyBhcmU6IDEpIG5vdCBzdXBwb3J0aW5nIFZGSU8gZGV2aWNlDQo+PiB1bmRl
ciBhIFBDSSBicmlkZ2Ugd2l0aCBlbXVsYXRlZCBkZXZpY2UsIGJlY2F1c2UgZW11bGF0ZWQgZGV2
aWNlIHdhbnRzDQo+PiBJT01NVSBBUyBhbmQgVkZJTyBkZXZpY2Ugc3RpY2sgdG8gc3lzdGVtIEFT
OyAyKSBub3Qgc3VwcG9ydGluZyBrZXhlYyBvcg0KPj4gcmVib290IGZyb20gImludGVsX2lvbW11
PW9uLHNtX29uIiB0byAiaW50ZWxfaW9tbXU9b24sc21fb2ZmIiBvbg0KPnBsYXRmb3JtDQo+PiB3
aXRoIEVSUkFUQV83NzI0MTVfU1BSMTcsIGJlY2F1c2UgVkZJTyBkZXZpY2UncyBkZWZhdWx0IEhX
UFQgaXMNCj5jcmVhdGVkDQo+PiB3aXRoIE5FU1RfUEFSRU5UIGZsYWcsIGtlcm5lbCBpbmhpYml0
IFJPIG1hcHBpbmdzIHdoZW4gc3dpdGNoIHRvIHNoYWRvdw0KPj4gbW9kZS4NCj4+DQo+PiBUaGlz
IHNlcmllcyBpcyBhbHNvIGEgcHJlcmVxdWlzaXRlIHdvcmsgZm9yIHZTVkEsIGkuZS4gU2hhcmlu
ZyBndWVzdA0KPj4gYXBwbGljYXRpb24gYWRkcmVzcyBzcGFjZSB3aXRoIHBhc3N0aHJvdWdoIGRl
dmljZXMuDQo+Pg0KPj4gVGhlcmUgYXJlIHNvbWUgaW50ZXJhY3Rpb25zIGJldHdlZW4gVkZJTyBh
bmQgdklPTU1VDQo+PiAqIHZJT01NVSByZWdpc3RlcnMgUENJSU9NTVVPcHMgW3NldHx1bnNldF1f
aW9tbXVfZGV2aWNlIHRvIFBDSQ0KPj4gICAgc3Vic3lzdGVtLiBWRklPIGNhbGxzIHRoZW0gdG8g
cmVnaXN0ZXIvdW5yZWdpc3RlciBIb3N0SU9NTVVEZXZpY2UNCj4+ICAgIGluc3RhbmNlIHRvIHZJ
T01NVSBhdCB2ZmlvIGRldmljZSByZWFsaXplIHN0YWdlLg0KPj4gKiB2SU9NTVUgcmVnaXN0ZXJz
IFBDSUlPTU1VT3BzIGdldF92aW9tbXVfZmxhZ3MgdG8gUENJIHN1YnN5c3RlbS4NCj4+ICAgIFZG
SU8gY2FsbHMgaXQgdG8gZ2V0IHZJT01NVSBleHBvc2VkIGZsYWdzLg0KPj4gKiB2SU9NTVUgY2Fs
bHMgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCBpbnRlcmZhY2UgW2F0fGRlXXRhY2hfaHdwdA0KPj4g
ICAgdG8gYmluZC91bmJpbmQgZGV2aWNlIHRvIElPTU1VRkQgYmFja2VkIGRvbWFpbnMsIGVpdGhl
ciBuZXN0ZWQNCj4+ICAgIGRvbWFpbiBvciBub3QuDQo+Pg0KPj4gU2VlIGJlbG93IGRpYWdyYW06
DQo+Pg0KPj4gICAgICAgICAgVkZJTyBEZXZpY2UgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBJbnRlbA0KPklPTU1VDQo+PiAgICAgIC4tLS0tLS0tLS0tLS0tLS0tLS4gICAgICAgICAg
ICAgICAgICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgIHwgICAgICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPnwNCj4+ICAgICAgfCAgICAgICAu
LS0tLS0tLS0tfFBDSUlPTU1VT3BzICAgICAgICAgICAgICB8Li0tLS0tLS0tLS0tLS0uDQo+fA0K
Pj4gICAgICB8ICAgICAgIHwgSU9NTVVGRCB8KHNldC91bnNldF9pb21tdV9kZXZpY2UpIHx8IEhv
c3QgSU9NTVUNCj58ICAgIHwNCj4+ICAgICAgfCAgICAgICB8IERldmljZSAgfC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLT58fCBEZXZpY2UgbGlzdCB8ICAgIHwNCj4+ICAgICAgfCAgICAgICAuLS0t
LS0tLS0tfChnZXRfdmlvbW11X2ZsYWdzKSAgICAgICB8Li0tLS0tLS0tLS0tLS0uICAgIHwNCj4+
ICAgICAgfCAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAg
IHwNCj58DQo+PiAgICAgIHwgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgICAgICBWDQo+fA0KPj4gICAgICB8ICAgICAgIC4tLS0tLS0tLS18ICBIb3N0SU9NTVVE
ZXZpY2VJT01NVUZEIHwgIC4tLS0tLS0tLS0tLS0tLg0KPnwNCj4+ICAgICAgfCAgICAgICB8IElP
TU1VRkQgfCAgICAgICAgICAgIChhdHRhY2hfaHdwdCl8ICB8IEhvc3QNCj5JT01NVSAgfCAgfA0K
Pj4gICAgICB8ICAgICAgIHwgbGluayAgICB8PC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwgIHwg
ICBEZXZpY2UgICAgfCAgfA0KPj4gICAgICB8ICAgICAgIC4tLS0tLS0tLS18ICAgICAgICAgICAg
KGRldGFjaF9od3B0KXwgIC4tLS0tLS0tLS0tLS0tLiAgfA0KPj4gICAgICB8ICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfA0KPnwNCj4+ICAgICAgfCAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIC4uLg0KPnwN
Cj4+ICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLiAgICAgICAgICAgICAgICAgICAgICAgICAuLS0t
LS0tLS0tLS0tLS0tLS0tLS4NCj4+DQo+PiBCZWxvdyBpcyBhbiBleGFtcGxlIHRvIGVuYWJsZSBm
aXJzdCBzdGFnZSB0cmFuc2xhdGlvbiBmb3IgcGFzc3Rocm91Z2gNCj5kZXZpY2U6DQo+Pg0KPj4g
ICAgICAtTSBxMzUsLi4uDQo+PiAgICAgIC1kZXZpY2UgaW50ZWwtaW9tbXUseC1zY2FsYWJsZS1t
b2RlPW9uLHgtZmx0cz1vbi4uLg0KPj4gICAgICAtb2JqZWN0IGlvbW11ZmQsaWQ9aW9tbXVmZDAg
LWRldmljZQ0KPnZmaW8tcGNpLGlvbW11ZmQ9aW9tbXVmZDAsLi4uDQo+DQo+V2hhdCBhYm91dCBs
aWJ2aXJ0IHN1cHBvcnQgPyBUaGVyZSBhcmUgcGF0Y2hlcyB0byBlbmFibGUgSU9NTVVGRA0KPnN1
cHBvcnQgd2l0aCBkZXZpY2UgYXNzaWdubWVudCBidXQgSSBkb24ndCBzZWUgYW55dGhpbmcgcmVs
YXRlZA0KPnRvIGZpcnN0IHN0YWdlIHRyYW5zbGF0aW9uLiBJcyB0aGVyZSBhIHBsYW4gPw0KDQpJ
IHRoaW5rIElPTU1VRkQgc3VwcG9ydCBpbiBsaWJ2aXJ0IGlzIG5vbi10cml2aWFsLCBnb29kIHRv
IGtub3cgdGhlcmUgaXMgcHJvZ3Jlc3MuDQpCdXQgSSBkaWRuJ3QgZmluZCBhIG1hdGNoIGluIGxp
YnZpcnQgbWFpbGluZyBsaXN0LCBodHRwczovL2xpc3RzLmxpYnZpcnQub3JnL2FyY2hpdmVzL3Nl
YXJjaD9xPWlvbW11ZmQNCkRvIHlvdSBoYXZlIGEgbGluaz8NCg0KSSB0aGluayBmaXJzdCBzdGFn
ZSBzdXBwb3J0IGlzIHRyaXZpYWwsIG9ubHkgdG8gc3VwcG9ydCBhIG5ldyBwcm9wZXJ0eSA8Li4u
eC1mbHRzPW9uL29mZj4uDQpJIGNhbiBhcHBseSBhIGZldyB0aW1lIHJlc291cmNlIGZyb20gbXkg
bWFuYWdlciB0byB3b3JrIG9uIGl0IGFmdGVyIHRoaXMgc2VyaWVzIGlzIG1lcmdlZC4NCkl0J3Mg
YWxzbyB3ZWxjb21lIGlmIGFueW9uZSBpcyBpbnRlcmVzdGVkIHRvIHRha2UgaXQuDQoNCj4NCj5U
aGlzIHJhaXNlcyBhIHF1ZXN0aW9uLiBTaG91bGQgZnRscyBzdXBwb3J0IGJlIGF1dG9tYXRpY2Fs
bHkgZW5hYmxlZA0KPmJhc2VkIG9uIHRoZSBhdmFpbGFiaWxpdHkgb2YgYW4gSU9NTVVGRCBiYWNr
ZW5kID8NCg0KWWVzLCBpZiB1c2VyIGRvZXNuJ3QgZm9yY2UgaXQgb2ZmLCBsaWtlIDwuLi5pb21t
dWZkPSdvZmYnPiBhbmQgSU9NTVVGRCBiYWNrZW5kIGF2YWlsYWJsZSwgd2UgY2FuIGVuYWJsZSBp
dCBhdXRvbWF0aWNhbGx5Lg0KDQo+DQo+Pg0KPj4gVGVzdCBkb25lOg0KPj4gLSBWRklPIGRldmlj
ZXMgaG90cGx1Zy91bnBsdWcNCj4+IC0gZGlmZmVyZW50IFZGSU8gZGV2aWNlcyBsaW5rZWQgdG8g
ZGlmZmVyZW50IGlvbW11ZmRzDQo+PiAtIHZob3N0IG5ldCBkZXZpY2UgcGluZyB0ZXN0DQo+PiAt
IG1pZ3JhdGlvbiB3aXRoIFFBVCBwYXNzdGhyb3VnaA0KPg0KPkRpZCB5b3UgZG8gYW55IGV4cGVy
aW1lbnRzIHdpdGggYWN0aXZlIG1seDUgVkZzID8NCg0KTm8sIHRoZXJlIGFyZSBvbmx5IGEgZmV3
IGRldmljZSBkcml2ZXJzIHN1cHBvcnRpbmcgVkZJTyBtaWdyYXRpb24gYW5kIHdlIG9ubHkgaGF2
ZSBRQVQuDQpMZXQgbWUga25vdyBpZiB5b3Ugc2VlIGlzc3VlIG9uIG90aGVyIGRldmljZXMuDQoN
ClRoYW5rcw0KWmhlbnpob25nDQo=

