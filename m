Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D498CCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmid-0005DR-Q4; Mon, 20 Oct 2025 06:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAmiR-0005Ap-Q1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:02:11 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAmiJ-0003ng-7K
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760954523; x=1792490523;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kieZrxlU39PTUCTmPAIop+WWCPvz5rcktY84NGaUNp8=;
 b=S7NM+qpBlXwroOEcjmnEAsJfWKqdF/HhC6zsUMcq+IiI1NzpzJdfiV5U
 DRlEn2VBFBNDLOcbIVfCRA7E+fZ3HtlB6cncKhTPte62QHNGuasNMwYrD
 IQbbbDztn14sNMqjRZ3bfVwWNCTRDxMzcFDQtu2v6oWg6aA0oipomCpT3
 rxzjQaOy/kOpfiOwY8O3cGVJzpEfRUBynwLTRraN0Ha+lC6eMdW9mS23h
 OxNWBQLTlfghMSyDg/zsCzOEVEqW9DATwfHBQoog1MARMxiJAm5mGdVcV
 nlPOHt7IQVsaG/bTRiRMgjYoUhZacu10FuPZkYJed9m9I2vQHBjObmrhY A==;
X-CSE-ConnectionGUID: 981fqbhIT4CYA2w/rlDWcg==
X-CSE-MsgGUID: Icyz9du4SvyMy+oCA32OjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="66931813"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="66931813"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:01:58 -0700
X-CSE-ConnectionGUID: AmBTGPHrTlmUg0u3SAKfjA==
X-CSE-MsgGUID: zLwfeKLmT7KTAsFZvMwvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="182481701"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:01:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:01:57 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 03:01:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:01:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC9HdrYxsLh79ZD6C7xUcAm5oZFMvjsL/HTCXaNfxr7n4yBLES6OgxI19Z38ZpqOwO1I7gt8rtDujtoBMnIueDlkveN7eHv5O2/vLf2QGVPixyC+Z4IMlMP9mqnCIgfJnM5ZaRake0eNqK3QUvZUyZ7e0MDeSLTuJWVI2v6MZkudo5UTpQPkOesyiIjYcEmGu9RAHmGomAohARLB/zTYn17GRqxDKxhCUYGZFt528c+gQtZX7HoIsF3pQJw/mA55554XCwVmbhW+5H5knbkhoIfcdxkKx7h9DOw9as7ZqdS3JjQDyT5awl7zcnSv0+lB0O9s/ah4NWOSRs0KfWj3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kieZrxlU39PTUCTmPAIop+WWCPvz5rcktY84NGaUNp8=;
 b=TYdWTJeb97OjCkUJ52uuF5VKzkw2F/tBHpzSPSc1p7Qj8sP6DcJZh6QeKWHpwNYaR7hGaEcWwqS008lGoDG87H46vMo6oSwVRahMbq7aYlr6idsctY8TvD839vNwo4ndQp0+f681KEBefiAcmcFp+GGDt/ICJgBUV5KMXKyGnnhOb+AUeIjnPJDQxllDYflCspON3GEaBMEqSu95L1zDCoh+d+eCKqOM1JQl8sPjXWoWNa77oq+y0mi3yNv5diicH0qNM/ppoPEW+lHpUmId3UCUrgO5zveD6tIGkzlVlOQJYD3EwkpXMk24sF04JarrHDm71/bX7mI/RNNjW6r3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 10:01:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:01:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Thread-Topic: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Thread-Index: AQHcPz9LWgjkxOjKnUm/UTySYpqPeLTKqq0AgAAFq/CAAAqbgIAAF5lg
Date: Mon, 20 Oct 2025 10:01:53 +0000
Message-ID: <IA3PR11MB9136F8A1EA2FC46CE2B7C10F92F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-7-zhenzhong.duan@intel.com>
 <5cabe9ba-fad4-4f23-9d00-10f775f12f7d@intel.com>
 <IA3PR11MB913639B9E0AB36CE6890BCE792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <6f1ca5b3-8993-42ae-95b3-16ccccf51efa@intel.com>
In-Reply-To: <6f1ca5b3-8993-42ae-95b3-16ccccf51efa@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB7156:EE_
x-ms-office365-filtering-correlation-id: c623d6fc-6074-4dad-1497-08de0fbfb278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dWtkV1d5MDB6YXY0SW5lQkx3bHpyWjd3RGdpOXhuR1h5R1JPNm05QkQ0dTB2?=
 =?utf-8?B?VVZPNkl4dVFKRVh3enNNRUYzNUF2dDVOL21QRGR0Ylh6ZWVuamNZVzVGZ1l5?=
 =?utf-8?B?OVk5bDd3d3R0NlFIQzZtWG1tQlpzcnFPTnI5aWZhbFp4MSt3b1o4VGppUVJS?=
 =?utf-8?B?YzdsdUtrZ2JiRXVldVJYTGh6bjhpcHZNS01DbFJVUzlEWUlXWmpYOGhCa3dE?=
 =?utf-8?B?a20yZFlVZFpJQmxSc2pwMXdyU0lSN1JzQWhTWncrZWhFWTRvcnR6MmtibzlB?=
 =?utf-8?B?cVlJWU9DNlh0VjNpRkg5a2NFMTduUUEwbmh2TmJhazU4VmlFRlpUbkd6bkZG?=
 =?utf-8?B?RDcrS1FnVFFPR1lPNWplSTFPemx4a3NMK3dDcGJkbUdRaFZONm1hSC9jd2xo?=
 =?utf-8?B?YlhRbldkN3hQSmpHVDU1cVFyeS8zMXp0VjEyZS9UbS91bEdISXo2M21ZcG5Y?=
 =?utf-8?B?UTRpWmxVVFY4MFdQdTduWEUzZ1htaUNBaU9XZ3phTHk0R1BCVSszajVWSmd6?=
 =?utf-8?B?VVNRWmNYMmhBcGRjZklpTDJSaDVIZjlvRmNWQVAzbVVEWHJtc0N2MWF0ZC9G?=
 =?utf-8?B?VVNuQ0pBMVpFcVBPVTQ3NC9HckVPL3V2LzVTUkNETDR1S1oxYktmWS9QeEFq?=
 =?utf-8?B?ZEVoT3hndEpNVWxNMzM3clZtSWxaQjdFWnBsSVpPWXUzNG14aHQwYTdvTjN4?=
 =?utf-8?B?cWlROUlWdEhPK0pKeXpkSFJqZW44aTB5RVdwdlpNdUJJV3V3djkwT3IvM3RI?=
 =?utf-8?B?RmZZZ2ppaWpNWHRoTGRoSkF3TjJiSENabWN2K2tYVjRMQUVCSG9GYzJwd1pl?=
 =?utf-8?B?bHhJaXFiYUFtNC9MVzRIeHBVZHRlTkt1YWZUT2h5RFBYbUx3QXgxTDgyNnJM?=
 =?utf-8?B?UFZ1eEJnRmdxUEdNcmMweEhEZVovSmk4Z2NCbjB1UFd2TVJ1b3ozSGh5NnMw?=
 =?utf-8?B?eFplUnV1M2V6Vlg2QnNhdXlVUXdSSCt0NnpqRHE0amo3Q0JBYVcwL2p5ZENI?=
 =?utf-8?B?MlVXdTQzTXkxTVlacUMwR3J4QVI0UHI0OXN4ZWRaQ1J4VlRSQVRVNm5pTmsx?=
 =?utf-8?B?NWZTRnRuMW1WNEJ5K3Y3ZDZ2RGVLQ1kwdFJhdDN5emhmSXFJZ3F2YWc5Y3cy?=
 =?utf-8?B?RVhGVnJVTFNJNGozQzM3TzhWeVkrZGJPdXNsaDJGZDdiRnIrNE51UC9OMzA2?=
 =?utf-8?B?cVNuQTdrNzVicnRJUi8wcWpRR3BKMy9WNERmVjBTYWEyM3QvUnRqMFlLOU9z?=
 =?utf-8?B?R1ZmZkFjSHlIR0F2M0xkY2I2b3pnU3hoU3pwdVczS2haYUFTZmpGU2dGU3lN?=
 =?utf-8?B?VDZObVVESWs0TkVzTFRsTmFrYmlKRFdnc2o0YkI1cnBNVi9QUzhCSFF1bHpP?=
 =?utf-8?B?QXBYNUpLMm9XQUtnSHY0WlJqaE5hYkUzbTByUUROc05EdzAyK3NTZE9qZWNC?=
 =?utf-8?B?UFE1ZzZXZ01CbjJTTTM3K3kwSGVKR1Q1RFhOQkVSSjdpNFdUN0JWNVJ4anFQ?=
 =?utf-8?B?NGdlR3V0cWhKQzA0Z3lVQnI2T3NLaXBTY3BwdEg0c2xtelJLR3dOb2x2c09H?=
 =?utf-8?B?VkIvY2lIYUxrVXd0a1JzK1kzZEQ4MHNicm1yU1krRGZmOW42VXV2VDNZQm9B?=
 =?utf-8?B?RTlLbnBNZlpkUldsditWaUFoL2FTSStGT3M2ekVOQ0JoR1RqdE4yY01MRnpM?=
 =?utf-8?B?Q0N3SmtIZXRFSlBtaS9lTVJqTG1RTXREcUx5TWM3VzBFcXNkbWxCUHFmbFNh?=
 =?utf-8?B?MlE1MHFmclJxVHMrR29KbFVQeURPTENrZWMzZHBZNjc0Q1VtS1RKS2k3V3V4?=
 =?utf-8?B?andwSkJ3S2hCdGdvSW9vYkVYSitZdFhwb1pPWTlDRlBBVXhUOE9SRjFlS3Nv?=
 =?utf-8?B?V2VvUG1nTmxIUlgwTW9hLytqdk5aUFFEN2N5VW9kTVErWDFIS3UvMytqSDFT?=
 =?utf-8?B?eVl2MVlsM3JqMjZYaE9na1prRDc5alFDTUFXZHo1SzdRUHFVcTlwUmxoK1Mr?=
 =?utf-8?B?NjB0eFJMV0E1aGsxMFBSSHFmeFFKV0diaEQ5V3N5UDhRRGRNWjNvVUIzRXFW?=
 =?utf-8?Q?BOnC1I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXBGbHFFV2JTSUR4QVVOc0tzNEgwYUEyY1RkUGkvVHVxVGpVamdFdGxra2hp?=
 =?utf-8?B?aUdJSEdWZlJwb1N5cDFBQXpHZDVDSkFydXRRclo3djNJSml0MmUxS1Vuazk4?=
 =?utf-8?B?QUVlWWFUVk1PeHZPTzBVNUExTFJ4R2VMNEJ6dmJEUUhMeGFObVNLZmV1WXpq?=
 =?utf-8?B?MnhqRlRiaUFEckRUYmJKMkFrMlI4RFZPbm02UjdDOTg2b3lWUTZCWWJQUEFO?=
 =?utf-8?B?Z1d4U080Rk1PcmdMUkRqOGU2STZZRXFyaVZSYkg1aVl2NFNjdzZ4Y25Mak4z?=
 =?utf-8?B?K2ZwL3kyV3hRNHFkWC9PQk1QOEVzM2oxSTdsVSs3T3M0dWMvbVVIeUprR3JJ?=
 =?utf-8?B?aU5RNklJdU1SMmtGZmJhZ1gveVY2ZmlZejVzMmZEQklGZFFybmNrUlozRjRs?=
 =?utf-8?B?MzZ3MU5DNGVQeVNBcjJ6T29udUh3UE5qODh4bmFzUmtYYmlMN2YzREVoSXdM?=
 =?utf-8?B?eitoYlhZRlRpMllOMWc3YjBIU3EzZG83YW80RDFBS1dhUkxmQVo0V05IWXB4?=
 =?utf-8?B?b0Y5TTBsZkJZeEJYZ1hxcXhzRlpDRFNqV0lNZ0Q4bFphaGc5Y0p2V1B2MWhH?=
 =?utf-8?B?Z0VjVmxhNG5iSGVVb1V3RmRMZVA3S0I3bm1hdG1IWFY5NDlxVDRlQU9Mdnhm?=
 =?utf-8?B?ajZOQWxhVWk4WXNuVFk1Wk1Bamp4MmJFbXl0R1I1VTRFUnIrNzlHTGJ0dHFK?=
 =?utf-8?B?ZFVFRHEvK1RWbk5TNkh5VE9vVXY0TitvUG9VeHBTMGhvYWZhWEtib1R5VjRy?=
 =?utf-8?B?c29oTVNmeEJ4aTNNQXBTMTQ3RFNqL3REdVhGVGR5THJCNjZXMSt3ZHl1SVZX?=
 =?utf-8?B?WUtTVHB4YzE5M2YwZHh4ZjFldUYyamJQMmFSUmNrUk5nY3BmQzdOSll1NUNP?=
 =?utf-8?B?MnI2eDF5ZXdySWkzWHhRWlJBcWJ3VVFIZS9FMkNsVFlRVVNkYk9zdy9DQUgx?=
 =?utf-8?B?Yzg2dXVEdmNlQ0FyWlpOREFjMnJsejM4NkJER1hOTXlpTzAxVmFMUFNjTWNw?=
 =?utf-8?B?Smx6eVY4VEN0elNaY2tXTWtCTktTM1V1Q0ppYnNKL0ttckhMbXhaK2FPbkg3?=
 =?utf-8?B?dVIrYnF0R1VWaHZNYnY0R0pkU2lSTkdXZzdNV2hFQkdKQlJ4UEo2QjFjbTFB?=
 =?utf-8?B?bmtJTzErRzNWWUIwcEpoSjNtdzJhSkdzdHIrNHBNSk1xSVZYdGlGQ2kyT0xy?=
 =?utf-8?B?WS9weHF0U1ZPeHpST0J6U0xVQ2pxamNXMVIvVnVvZ0lKKzFIeDlLMXBnTW1D?=
 =?utf-8?B?Z29kMHdwbUZLTm5kbnNzUkthbm9zNEtPWmlrdWY3RE4xYXpsU2pzNy9POURu?=
 =?utf-8?B?Rko1M0dkOWxack5GVC9nd3pPSEduaUgrTk9SYlhPWVdpYW4ralZKT0pqb0tD?=
 =?utf-8?B?U3NkVEtmY25VbFViampXb096Rk9na0paR1ZMeG15cnJhV2xydFM2ZGlFNm9a?=
 =?utf-8?B?VS8vVU9ZSDRJdjJxUWV4REVCc3JtTThQanZmbGZ5SVR4bXRHK1Eyd1hveWlX?=
 =?utf-8?B?ZWl3VFkrZnVJNzB3VmI4MVc2ZmkrNW8rTFlvc2d1SzFIaGdyTzZmeXNoWHpF?=
 =?utf-8?B?UXZkZVd5YXdVM0R0TkFiTEJ3WEQ0QnE1bkYyZjdxV0V0aFEvR1VxZlgzUzRE?=
 =?utf-8?B?d0RQdkRFNm5CWU1heGdBcVVqcWFRVnE3RGdmUEhRUGpNeEFINWwyem9WdFJu?=
 =?utf-8?B?ZXA4bHpMWHp4bm85MkI2WTQwVzhZblo0NC9LV1Z2OHQrc3p2aEFTelpBYWlq?=
 =?utf-8?B?TmZaRWdlZ1JIRnQzQm5XN1pFdldFVmFqb1RVZ1RMSTU2dEwvS24rV3Z1Y3Js?=
 =?utf-8?B?RHVZdjBmYmI5QkdBWXdMUnBmVzRRVVNqNitzaXloUU1aMFBKazlhcmJqQW1q?=
 =?utf-8?B?MjBTSGQvSFNUNzJzRVhVOEhOZDNRSVBhRmJQanVRdnhubzMwODlIYkpGSXZp?=
 =?utf-8?B?eEV4b21oRTVtUnF3T3RGME9HMEM1dGt3Wm1wQ1lrY2tCZ0ttR2lsaTdNU1Bv?=
 =?utf-8?B?YmtUMEF3Q2RSTWdhYnErSU5uaHRTVXozRk9wVFUyMXF3MVd6OXJ4Wi9xM0dp?=
 =?utf-8?B?Y3VYZVcwVUg3UXR4NjBCVjNTTmErQ014dTVNS2tXajQ1SjBnKzdZekhRckxj?=
 =?utf-8?Q?RpNBTEd7+2jfubuVbdY/MIAwb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c623d6fc-6074-4dad-1497-08de0fbfb278
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 10:01:54.0116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvMJtQFKT7uTy8PzYct9Yo4xl2OkXiqF9maiyvDMO7PnsHB82oSzJ1O8lfE1m05vsscHL/ohZho5LirA8qKHX3yGYqzv7wLFDP9a95D4uKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNi84XSBpbnRlbF9pb21tdTog
Rml4IHVubWFwX2JpdG1hcCBmYWlsdXJlIHdpdGgNCj5sZWdhY3kgVkZJTyBiYWNrZW5kDQo+DQo+
DQo+DQo+T24gMjAyNS8xMC8yMCAxNjowMywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDYvOF0gaW50ZWxf
aW9tbXU6IEZpeCB1bm1hcF9iaXRtYXAgZmFpbHVyZSB3aXRoDQo+Pj4gbGVnYWN5IFZGSU8gYmFj
a2VuZA0KPj4+DQo+Pj4gT24gMjAyNS8xMC8xNyAxNjoyMiwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+Pj4+IElmIGEgVkZJTyBkZXZpY2UgaW4gZ3Vlc3Qgc3dpdGNoZXMgZnJvbSBJT01NVSBkb21h
aW4gdG8gYmxvY2sgZG9tYWluLA0KPj4+PiB2dGRfYWRkcmVzc19zcGFjZV91bm1hcCgpIGlzIGNh
bGxlZCB0byB1bm1hcCB3aG9sZSBhZGRyZXNzIHNwYWNlLg0KPj4+Pg0KPj4+PiBJZiB0aGF0IGhh
cHBlbnMgZHVyaW5nIG1pZ3JhdGlvbiwgbWlncmF0aW9uIGZhaWxzIHdpdGggbGVnYWN5IFZGSU8N
Cj4+Pj4gYmFja2VuZCBhcyBiZWxvdzoNCj4+Pj4NCj4+Pj4gU3RhdHVzOiBmYWlsZWQgKHZmaW9f
Y29udGFpbmVyX2RtYV91bm1hcCgweDU2MWJiYmQ5MmQ5MCwNCj4+PiAweDEwMDAwMDAwMDAwMCwg
MHgxMDAwMDAwMDAwMDApID0gLTcgKEFyZ3VtZW50IGxpc3QgdG9vIGxvbmcpKQ0KPj4+Pg0KPj4+
PiBCZWNhdXNlIGxlZ2FjeSBWRklPIGxpbWl0cyBtYXhpbXVtIGJpdG1hcCBzaXplIHRvIDI1Nk1C
IHdoaWNoIG1hcHMNCj50bw0KPj4+IDhUQiBvbg0KPj4+PiA0SyBwYWdlIHN5c3RlbSwgd2hlbiAx
NlRCIHNpemVkIFVOTUFQIG5vdGlmaWNhdGlvbiBpcyBzZW50LA0KPj4+IHVubWFwX2JpdG1hcA0K
Pj4+PiBpb2N0bCBmYWlscy4NCj4+Pg0KPj4+IEl0IHdvdWxkIGJlIGdyZWF0IHRvIGFkZCBzb21l
IHdvcmRzIHRvIG5vdGUgd2h5IHZJT01NVSBjYW4gdHJpZ2dlcg0KPnRoaXMuDQo+Pg0KPj4gSGkg
WWksIEkgdGhpbmsgdGhlIGZpcnN0IHNlbnRlbmNlIGluIGRlc2NyaXB0aW9uIGlzIGV4cGxhaW5p
bmcgdGhhdD8NCj4+DQo+PiAiSWYgYSBWRklPIGRldmljZSBpbiBndWVzdCBzd2l0Y2hlcyBmcm9t
IElPTU1VIGRvbWFpbiB0byBibG9jayBkb21haW4sDQo+PiB2dGRfYWRkcmVzc19zcGFjZV91bm1h
cCgpIGlzIGNhbGxlZCB0byB1bm1hcCB3aG9sZSBhZGRyZXNzIHNwYWNlLiINCj4NCj5haGEsIHll
cy4gSSB3YXMgdHJ5aW5nIHRvIG1hcmsgaXQgaXMgTk9UIG5lY2Vzc2FyaWx5IHJlbGF0ZWQgdG8g
Vk0NCj5tZW1vcnkgc2l6ZS4gQ291bGQgeW91IG5vdGUgdGhhdCB0aGUgYWRkcmVzcyBzcGFjZSBp
cyBndWVzdCBJT1ZBIHdoaWNoDQo+aXMgbm90IHN5c3RlbSBtZW1vcnk/DQoNClN1cmUsIHdpbGwg
ZG8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

