Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCF5D6DDE2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 07:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBr1U-0003hr-2g; Fri, 15 Nov 2024 02:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tBr1R-0003he-3U
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 02:45:41 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tBr1J-0001zI-OU
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 02:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731656734; x=1763192734;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vmKF1LBhq65Ki/xGRJz3EJpKAgfxpV9prVfeEwTK0hk=;
 b=GWenyqjwRce2Myf7n/9X5FwEmbOgHw4skyXiQympLBE+No5EhenhfcGy
 /tSE7c/RiUw4Gt02T330pVtwrX+H4nvEe8g3/o1Ro9rrlLtiGGKfDSr54
 MVFr0dg363TWRYiADJAsbEi8mUq5tQB4CtETFwjTYp1giaNQGtkdo6P0B
 ie8oCg5e/E3uwUjbhuid8OkSNeQAzL7fMMH4/+ho1X8UhL+q1FzlH0Liy
 B6g/6/+q9UDrMTO1BXrV4Aw7FwihikDeBs5VcmXOfpnlzz8rpEt98nd8y
 M73cDFHulfMeVvY90tJihQI6XS+9xrt06kGOzARmq9+7KMJ300H0hMcBc Q==;
X-CSE-ConnectionGUID: UZ0YkdwGSr6thYC2fgCCgQ==
X-CSE-MsgGUID: xUz7yL0VR/mKKdpT+8Amkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="43049338"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; d="scan'208";a="43049338"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2024 23:45:29 -0800
X-CSE-ConnectionGUID: oesMB8w2R+aHfy7bSnqZFA==
X-CSE-MsgGUID: X/QdbnoUS1eUEK6viG4BWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; d="scan'208";a="93549563"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Nov 2024 23:45:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 23:45:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 14 Nov 2024 23:45:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 23:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDAvcvCPSs4G37bknQqN0EMcRn+Ty/ofZbo/zmIAMgxclwEskgVD1b+ZvQonvgiEJJK0kr4Q5BVKSldnUvQMxujd96IMnRdVGdI3cfz84wl+B1WTo826hhX/yZIqOWiU0yFuW2IA4xhbF25JUPlYw36eAefDPX0PbuKtnNWBWJIlTajJjsgMxrNoW2Q84myyyDc8RJO13ooqR7GNPjEUSXBDdEPE0MEVTbRDBVzysero6h3eDRJ19g++0O4MMNmNfM2VVFKT5mcS/kdIEPGkp9zCH6Qko5TiaMeXGxM9dyLQ1yOCxegs/f7dLo2disarhRC6jHvEXG/vDSjG5tTDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmKF1LBhq65Ki/xGRJz3EJpKAgfxpV9prVfeEwTK0hk=;
 b=oeaw95UZPbImPYrDe8WbCsap9ySOPdCV4yDAR+uuoG+jZxjTqfiuVnhxTAGdeXF2jNjg6+4okkcLEp4XAMBE1VqPk+GmxABiqucxRMHn41ZDNF5QkQNwMZIo+iGhvW/gZSFHbKE8CUKQW/iSq/aGNn4eTnAqTt+vvTskVLiBN17TKyuFTzVNXDIZDOFEukk6fPLmvjymCa204qd6LVpvzBXW8Mnkx/SyLjr0swnTXfSTCh66Vx6YPkbCDqTST4AM5blN/+vMcLIRe7cqLmj/p7MV2EYYaslXLBqip7vco1LHv0PI0qHv6uJ8W5pxxDJOzPR+mexe66Le+QtTyxorqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 07:45:16 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 07:45:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH for-9.2] vfio/container: Fix container object destruction
Thread-Topic: [PATCH for-9.2] vfio/container: Fix container object destruction
Thread-Index: AQHbNysX+ypCnLQNDUOhChbMRoVeLbK39Jdg
Date: Fri, 15 Nov 2024 07:45:15 +0000
Message-ID: <SJ0PR11MB6744AD5AFD0059797909646592242@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241115065240.2198493-1-clg@redhat.com>
In-Reply-To: <20241115065240.2198493-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7336:EE_
x-ms-office365-filtering-correlation-id: ab33b009-bc22-4996-c256-08dd054971bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tkg5Rm95MlNGVXdMd2JOczArOGxBMlN1VU8zb0pqRkplTlpnREVkREhZMEMx?=
 =?utf-8?B?VWRKQWlZdUpUZHZiVTBDK1hlMVBER2lJV2t2OFFRNm5TSFNhU054QkxpVlA1?=
 =?utf-8?B?dFRidzVTYjhSY3BIV1J0b3RqVFF1b2srWFZiKzBtYjgzbkxBUXAvVU0wTlR6?=
 =?utf-8?B?UXJjWmE2V0h5UFZOc29nTTBvZFd0UXpOVEVVaU9VZDRWWjJnS2ZkaWpKUkM5?=
 =?utf-8?B?U1hUdVpYVVdCckMyVkhBakdXSUc2TE9BeU9nWGxwUlY1Vm91UzN4WVNXUEN3?=
 =?utf-8?B?dlNqNmJGc0gwOXk4RUJRWG9oeXdrTjdjMHZMTFZKNGVlcit6cHlmdy9BMGx5?=
 =?utf-8?B?cjRKbVlkYkdldWs3dmlCZmFsRFVOd01vekpXRGtUc0pMcjhCaFFUSmhxNGJx?=
 =?utf-8?B?endaY1lsaTB2Tng0cDJSS2ExRzhuSnlHOW5aUm8wMFF6MVhRQTRSb0ZKU1Zj?=
 =?utf-8?B?U1J5RytMc0FaV0MySmUrNElxUEZiL0lBY2Z5Ri8yeHpZMHpyb0V0dWFQdkpp?=
 =?utf-8?B?R01HaUt1amg2a1dqM3AxaVBYMXNIc25BRTBNb0RpWE1laDF0NldNWlhmRS9x?=
 =?utf-8?B?NzE2OGFmYkJuWTkxZEVLdEdydUFUV0c3WFhzR1k2WlRZZ2hlNUNZOEpoOEIz?=
 =?utf-8?B?MnVwb1dBQnJGbzkveFhNSWJkU0VIRVhzczZSY0x6RWxnUjhTMTMxUXF6ZUZu?=
 =?utf-8?B?WHBSSHdxUlJlbTJsNjJYZ0tqTGVBOG1JL3BVditoMmRWd3BFQWxLeDFDNm5H?=
 =?utf-8?B?a3I3VHZpNVN4dnBlNzlvOTRDWGprUVV4ZkVlYmx5TVpJMTFQR1lPZjF1R2Q3?=
 =?utf-8?B?TkxaSFBsWXVQN0xrWERSdDk2aC9JSXNzejRoREowMGt3a1BLVlR4a3EweUww?=
 =?utf-8?B?bFNMTWc0eFZkNWxiQXhsNzlrditUeWx3TnFNa0F5dDB3d09GM2lOVEkvUkY1?=
 =?utf-8?B?QWw5Z1lZY3NINjJTNlk2UEtxR0pxbWZTQ0ZWUklPdVNsK2ZwUXR2UFVEUkx1?=
 =?utf-8?B?Wm9obW1jODRNQjZCTFJ3VFZVNjNENFc4bEQrVVl4THhXb3ovNFk3aXU4S2xL?=
 =?utf-8?B?eWVPc2NhaTFiWW5reTdCNXNzQmVnellPZERYU1RjeGR2b2hoT3d0NTJ2WEJr?=
 =?utf-8?B?aGRoVWZVeURHTlArYlBjMGE5UThQQWNWVDFleFN0RDhDSWw5cjFYcDFhZzRB?=
 =?utf-8?B?d2pNQk03U1E2cnArQ1ZpSDdsZ3FrVk9NWGhlTHlMRmNHTW4xbGZpd0pjQ0Ux?=
 =?utf-8?B?OXFJVzF2TGZaODBKRndrQ01HdkZtazhrekJnYzdkQjQ3LzFhMGwyVmhsZmll?=
 =?utf-8?B?RU00YzkyMFE5a09VMmZzblUyQnZSeVQ2REJNbFlmdFdvaFVwZmxaV0FzdGlV?=
 =?utf-8?B?bEFoSG9MMDFNM2lIdjlQZkRRaWx1YWMzVFE5V0g3cngzS0JHMFJFeTlrdkov?=
 =?utf-8?B?U1E4bUJncWI5b1dsTDIrZkhPdGRQNDhHUEozSzhxOVQ4SkpQajhYbWtmQmdK?=
 =?utf-8?B?K1VweVJHM3JsREc3TkpVSWY3NXBxRjVGVFYwZnFMUUZJOFVvWVJVNkRuSFBl?=
 =?utf-8?B?elBaUGVDUW9nc3hrdnIxT0kzc0RrMnpFZUtpbGdiTUVRVTNjTVBLU1hKQnEz?=
 =?utf-8?B?dnplM2dYV0pJRmsrYTRjODBVY3ExdVU1RFhYOTdhY2c4UE12TTVxSWlrM1Br?=
 =?utf-8?B?Q21nbFlFZFpXTWhtTDVvelRrUlR0TzhHdWNHYkl3MWRCUGJTU0Y4SERhR2kv?=
 =?utf-8?B?dUNzdTBZbXVITnFWMTc3OERpSkRPRENlZ3Z5MlQxcHRKeU8vdmpJajcxL0tx?=
 =?utf-8?Q?J2bGM/YoOuj5rpOqKT/txQRxMb0A8rLMNkOJY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHRVNUNJV2hEbm9ya3h1cENzMFhybEh2aWkxd084YmlXQVlBaFYrYmgrR3Zz?=
 =?utf-8?B?Y0VyR2VxdmpqRTAzTTJ3dmg5dU5DOXNKU0VocUtnUytJNWVaaUdsVU5TSEpK?=
 =?utf-8?B?UFdSTjdQeFdNaG1jRTcyMEZUM09HQkRFNUs2NWpOVVJLcHU5bWE2ZU1scWlx?=
 =?utf-8?B?aXB6NWtaeTFld2NhTzRQL3YyYXg0U01NL2tjTk1wUks2TVBVWFNhcUwvUktX?=
 =?utf-8?B?UXhEOVdFK0daYThBT3dEbUtiTDEvTE5pVXpGYVl5V1BSVjdwc1lZakQ5UEhK?=
 =?utf-8?B?c3pJaHdVa1lPNjJyVUp1cjYxYkJwL0pYN3prKzlOM2lqcG1pRGg2TFUvWDQz?=
 =?utf-8?B?a1RibU5aVEtETG5xS0J0bDZxVi91VjZhY2RwWW1xSlk4TGtRSHNLaFNwNng3?=
 =?utf-8?B?TWtXVlYydFhtL081NGFwTkFleVAzUG13VVErVk43QkJGMUZjMXpMWXUxc1VB?=
 =?utf-8?B?SnZKSnlRTWhLVjJVOHhrZ1dUL0FaK1R2b0dmMHV1TTFzYm9za2Qybm51QTlF?=
 =?utf-8?B?QmhQd2ZDT2JqN0xub1k3eWpkemFZRU5CSkFueHJrYkRvT0dyR25COUs4akMr?=
 =?utf-8?B?dGttSXNML1B3N1hrMXRFMWZENzhjZFBwcU9PQ25nSkk4WjVtdDBWL01lY1hW?=
 =?utf-8?B?Tlo1TWMrUzZDdUdqakZua3pVMXhFNXVMY0Y5clJBM2l5dFZXOFJhWmwxeXEy?=
 =?utf-8?B?SVBZL0RLZnBUUzk5UEJLa0k4aUpKRGZxN1hEaDh2SGFLNDdRTGZZTE5maGQ4?=
 =?utf-8?B?WGZtT2lIMGFHWS94ZDMwRDIwRVVZdWxpT3pNcUFXUTZtaTZscnhBbGZjdE1K?=
 =?utf-8?B?cGJ6YnhXM1pQYjNIK0VJQVg3L3pKSmN0RHJQbDJvaFlsWVFQNzJxd2RlQkZp?=
 =?utf-8?B?QUZDcFBnS2djLzFiUTA2Qzc1VlhGTVpFRlNPVXZiSnFqYi94VkEwQmFORUR0?=
 =?utf-8?B?NS90L2RjU3VwV01WRnBJRWFPNWx4QjNTU05YOUIxWDJuSEJpTWVwS3hGTDgw?=
 =?utf-8?B?VjlURE9vdGFJVFZGSGtZVlpnSVdKeUdXYXZ5ZEQvVUlCazJzdFhHZ2VrY0w3?=
 =?utf-8?B?RGZJd3RmcWFDa2NPc3BDR0k2RWdhQ0xpRVcxeUluUWNWS2JNcU5QTUZqdytH?=
 =?utf-8?B?bW5maEMvQW1MMUJMSUY5NldVZjloajdPWHZjOFZvaFM1dC9TYTZ2ZFVQV09Q?=
 =?utf-8?B?TDBHaU5neldqVkJaNStZR2JmclRZSzAzZm9WOVlOUC90bWhVL1pkZUNiQ2Rx?=
 =?utf-8?B?aXNqejA1NkZ2ZlB4Qzc3U0tNWldwTGM2RTJlcWhyV09RK2lBVDRjSjdPdExm?=
 =?utf-8?B?RjJpZHNhMERQMlZBMXRxeTJ6TG5KbkU1RmRSZU5UWDk3cDNsRUlTbnpDSjIz?=
 =?utf-8?B?aXZWc0d3RS9BVUJ4L1hPUGgxNkpQckR3OHhqYkFrRm1OQjdQN2FRemNPQjk1?=
 =?utf-8?B?aXkyYmtSNlRqTnVaV1lnMmZOakVIQ3pMTGdPNjFYWTh6Qys2MENtemN1TzVM?=
 =?utf-8?B?Zm0wYjU0SmNFODNHS1A0ZDFSaDBTZ0tpaUovMXMvdWdKdU9NTVlTbVY0SXNQ?=
 =?utf-8?B?UUZEdUI0VWs5NDMvOEJHLzYweXgzeVBtb0swNmlQY0JVKzJpRmMyU1ZOcndY?=
 =?utf-8?B?TXlHampDN1pPUVVxYWkyWU9wVTJoQ01OSExRNXRCU1R5VHlQTUl0cHk3MFdx?=
 =?utf-8?B?UnhmaWkydmdwTHJGNVp6S1pTdUZSRjVQek9Ba095RWVrMHFnNzRHbEkvQnVS?=
 =?utf-8?B?YjNPdkhYK2lZZWdoV0o2d1BLMWp1NkJRa1RFY3p2MVJoeUZiUkozaFZvbERC?=
 =?utf-8?B?VGthcDErZTVVWWUxZm83RDIzYkdXZERrSnA3bDJHMmVZN3BoNHRjMGJzOWM4?=
 =?utf-8?B?WHA3SUdVeGVXdHhLYU5PRzl3RWhPWmRLTEhkeCtrUFYreHRXaGVDd3NhZ1BZ?=
 =?utf-8?B?THlibFgzN04yR0UrN0hOZU52am5oVm11QmpRcmx0WFp3eng4Y2tEc1ZHakZP?=
 =?utf-8?B?ZXIzcFFhaEpBWnZ5cHRYb29QcmdNd0ltcmVESHJIVTFPUVpYM3hSb200em90?=
 =?utf-8?B?NlBPdFFyWHBxdGx1Tk5SbzdoSkR5MGlpck1ubHdod2RUaVlOc2MraTlCYjNP?=
 =?utf-8?Q?jSixxC9lVwMQUkyEt05Ed4Zhe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab33b009-bc22-4996-c256-08dd054971bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 07:45:15.5238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KXgKLU866oaEk+rxKDbKONiyuWxoW/J+bLcj0c44j4MNEJXtsnK9FJL0EblI6o/YBMNQhDpz8yeOtsMrh1Yn4/dSCQ3dFd4IhWqpGh208Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTUs
IDIwMjQgMjo1MyBQTQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4yXSB2ZmlvL2NvbnRhaW5lcjog
Rml4IGNvbnRhaW5lciBvYmplY3QgZGVzdHJ1Y3Rpb24NCj4NCj5XaGVuIGNvbW1pdCA5NmI3YWY0
Mzg4YjMgaW50b2R1Y2VkIGEgLmluc3RhbmNlX2ZpbmFsaXplKCkgaGFuZGxlciwNCj5pdCBkaWQg
bm90IHRha2UgaW50byBhY2NvdW50IHRoYXQgdGhlIGNvbnRhaW5lciB3YXMgbm90IG5lY2Vzc2Fy
aWx5DQo+aW5zZXJ0ZWQgaW50byB0aGUgY29udGFpbmVyIGxpc3Qgb2YgdGhlIGFkZHJlc3Mgc3Bh
Y2UuIEhlbmNlLCBpZg0KPnRoZSBjb250YWluZXIgb2JqZWN0IGlzIGRlc3Ryb3llZCwgYnkgY2Fs
bGluZyBvYmplY3RfdW5yZWYoKSBmb3INCj5leGFtcGxlLCBiZWZvcmUgdmZpb19hZGRyZXNzX3Nw
YWNlX2luc2VydCgpIGlzIGNhbGxlZCwgUUVNVSBtYXkNCj5jcmFzaCB3aGVuIHJlbW92aW5nIHRo
ZSBjb250YWluZXIgZnJvbSB0aGUgbGlzdCBhcyBkb25lIGluDQo+dmZpb19jb250YWluZXJfaW5z
dGFuY2VfZmluYWxpemUoKS4gVGhpcyB3YXMgc2VlbiB3aXRoIGFuIFNFVi1TTlANCj5ndWVzdCBm
b3Igd2hpY2ggZGlzY2FyZGluZyBvZiBSQU0gZmFpbHMuDQo+DQo+VG8gcmVzb2x2ZSB0aGlzIGlz
c3VlLCBpbnNlcnQgdGhlIGNvbnRhaW5lciBvYmplY3QgaW50byB0aGUgYWRkcmVzcw0KPnNwYWNl
J3MgY29udGFpbmVyIGxpc3QgZWFybGllciwganVzdCBhZnRlciBpdCBpcyBjcmVhdGVkLg0KDQpJ
dCBsb29rcyB3ZSBzdGlsbCBoYXZlIGlzc3VlIGlmIGNyZWF0ZSBhIGNvbnRhaW5lciB0aGVuIHJl
bGVhc2UgaXQgcmlnaHQgYXdheT8NCklmIHRoYXQncyB0cnVlLCBJIHdvdWxkIHN1Z2dlc3QgdG8g
YWxzbyB1c2UgUUxJU1RfU0FGRV9SRU1PVkUgZm9yDQpRTElTVF9SRU1PVkUoYmNvbnRhaW5lciwg
bmV4dCkgYmVzaWRlcyB0aGlzIGNoYW5nZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPkNj
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNjOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Rml4ZXM6IDk2YjdhZjQzODhiMyAoInZmaW8v
Y29udGFpbmVyOiBNb3ZlIHZmaW9fY29udGFpbmVyX2Rlc3Ryb3koKSB0byBhbg0KPmluc3RhbmNl
X2ZpbmFsaXplKCkgaGFuZGxlciIpDQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPi0tLQ0KPiBody92ZmlvL2NvbnRhaW5lci5jIHwgNCArKy0tDQo+
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+ZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+aW5k
ZXgNCj45Y2NkYjYzOWFjODRmODg1ZGE0MGVhY2U4YTAwNTlmMzk3Mjk1NjE5Li5iNDI0NjY3MDFi
ZjEzODE4YjUzODQ4M2VjNA0KPmMxNDNjZTZmODNjNTk4IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8v
Y29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+QEAgLTYxOCw2ICs2MTgs
OCBAQCBzdGF0aWMgYm9vbCB2ZmlvX2Nvbm5lY3RfY29udGFpbmVyKFZGSU9Hcm91cCAqZ3JvdXAs
DQo+QWRkcmVzc1NwYWNlICphcywNCj4gICAgIH0NCj4gICAgIGJjb250YWluZXIgPSAmY29udGFp
bmVyLT5iY29udGFpbmVyOw0KPg0KPisgICAgdmZpb19hZGRyZXNzX3NwYWNlX2luc2VydChzcGFj
ZSwgYmNvbnRhaW5lcik7DQo+Kw0KPiAgICAgaWYgKCF2ZmlvX2Nwcl9yZWdpc3Rlcl9jb250YWlu
ZXIoYmNvbnRhaW5lciwgZXJycCkpIHsNCj4gICAgICAgICBnb3RvIGZyZWVfY29udGFpbmVyX2V4
aXQ7DQo+ICAgICB9DQo+QEAgLTYzNyw4ICs2MzksNiBAQCBzdGF0aWMgYm9vbCB2ZmlvX2Nvbm5l
Y3RfY29udGFpbmVyKFZGSU9Hcm91cCAqZ3JvdXAsDQo+QWRkcmVzc1NwYWNlICphcywNCj4NCj4g
ICAgIHZmaW9fa3ZtX2RldmljZV9hZGRfZ3JvdXAoZ3JvdXApOw0KPg0KPi0gICAgdmZpb19hZGRy
ZXNzX3NwYWNlX2luc2VydChzcGFjZSwgYmNvbnRhaW5lcik7DQo+LQ0KPiAgICAgZ3JvdXAtPmNv
bnRhaW5lciA9IGNvbnRhaW5lcjsNCj4gICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZjb250YWluZXIt
Pmdyb3VwX2xpc3QsIGdyb3VwLCBjb250YWluZXJfbmV4dCk7DQo+DQo+LS0NCj4yLjQ3LjANCg0K

