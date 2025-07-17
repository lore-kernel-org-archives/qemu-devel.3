Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B136AC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 07:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIeA-00081q-33; Thu, 17 Jul 2025 03:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucIe7-0007xG-1p
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 03:03:11 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucIe4-0004Uu-3K
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 03:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752735788; x=1784271788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4htGRwXpZlLdw5nGpCGtcCT1dCYs9X8JBHf59/iFTwE=;
 b=OU1BfXrR8DGYo2iHebDKypk0M1C2/9rqfsPc4JU+yhc7FjIuM//cEr+D
 VpWMsYL7EyLSpKPpnatEnwL8t9+wco6f2yM3K1aVtL9F8PODpLyXJBbaV
 9M28vyhJDi0bLLMqA0YMMyB9CApzvpnfe9P9DzhW4sFW2mBi0FMxWVThL
 6a4wX40TuRO8b2Wdr8VPB9rhaq9LP436TjQP0if4rF4I1+f+rV2wEqwfR
 6Oz9tNtZ3rnxrshgL14dlzfv701H8kD/EfNTaURMWPj1me4C9qCi1z5Ou
 nvmGpWZU8zALy5HpVmejuHQkHOiuEWBafGc2Q8sjMH4Rplmq40sEolbL5 Q==;
X-CSE-ConnectionGUID: RAaEt9E/RFammezPuGhsCw==
X-CSE-MsgGUID: Q537QJ1WTKGD84j/3OvD6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55142216"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="55142216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 00:03:04 -0700
X-CSE-ConnectionGUID: xJxeIE8qTzmv2J3bYVc97w==
X-CSE-MsgGUID: WScx1oa4RLmjhDcboRUdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="157786932"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 00:03:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 00:03:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 00:03:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.86)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 00:03:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAKTFKrKjO5Dvud4Qij86jyk8fAXXtQpOrZ2M43XVzu82qp6ivCG1jyQ7dwqPdUYqWQIHi8zOFz98M7XqFvDoMGxR/XYgwu8FHUGkzkkaZdXwHFoEVnEUnGEUWlNeDHDKX+qk29xvJLhSecLJlLkAzFSY4h1FMNG979zROyM2R0P8bkfPO26STZ61s+XVpeemV9R+yXRCc35zgtXbJLv9YyYbfJlg8n3IRuFD7clpNobWYRTxQlPqKst6fdgWtlROn7UiU6gmE8v3uGWJKspyRGPUEApK2NyCLPhtqGvO6yqwtcNYlVzU3edhkmctWfm7uA6wgU+WXsJpN4BLkcBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4htGRwXpZlLdw5nGpCGtcCT1dCYs9X8JBHf59/iFTwE=;
 b=GnABcEWTP3fqkQe1rJFGyRo0X5FXLU66UII+UUbgm++KOKkSZvZ7n3wFk4zKRq1a/KZQa1JqEQmYidYG0zbZcs7unMSKmPa8IEt5nwgi4da3Nscu1n3IMDw9XO+uCb4H67jgfpX5ABqfBgmPUADDv4D/y4MRnnLmaHyEXVJ3lr4A0NYfnDdHN3gqhTf/rPkvKTZ02Wgw/0JHpMuhY67E5+AebnXO99+IluI9Z4S7GvvM3yEVtokdq0Z+5WIzolj5Uqk8t3avGPL8bAnj79vnlbhwzwtAS/6vXWsiEo6l97jPOIOm+Qll/5pZ2RGb3PxVON4zqLrbukdFadO2HNSJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL1PR11MB5288.namprd11.prod.outlook.com (2603:10b6:208:316::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:02:55 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 07:02:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v3 10/20] intel_iommu: Handle PASID entry removing and
 updating
Thread-Topic: [PATCH v3 10/20] intel_iommu: Handle PASID entry removing and
 updating
Thread-Index: AQHb7/hx64K4/N34ak2lMC7yA8lQ8bQ056CAgAEELgA=
Date: Thu, 17 Jul 2025 07:02:55 +0000
Message-ID: <IA3PR11MB913618A761D331ECDB0C78C19251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-11-zhenzhong.duan@intel.com>
 <8c3c469d-c2ec-4699-863f-9ffc45834ce5@redhat.com>
In-Reply-To: <8c3c469d-c2ec-4699-863f-9ffc45834ce5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL1PR11MB5288:EE_
x-ms-office365-filtering-correlation-id: 76a06520-9903-42fa-9755-08ddc4fff483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WVI3a1RDd002SjRkL05wNXlBNnhJVllBM0xkaDV4NDRmTXhWd2V2elZENlNv?=
 =?utf-8?B?M2ZJSEtYSll3MXBlaEh0U09FSVJBQkIwV1pDZzM0UEdWakZKaUs2cGZmQVFw?=
 =?utf-8?B?b1FXcG8xU0tSdWdza05FUU5xOTVDVG5FZjlmOXFYWTlOY1ljdkJTVU9mR2M0?=
 =?utf-8?B?bEpqODR5OVpsUDNUS2VTUEhlZmlabHJPKzZ0QWFzdE5ickJWdU03SUUvQTVQ?=
 =?utf-8?B?ZytyMXFjYzdOWS9oQWFoZFN1OEEyaHlSL0x6elpabU5IWW1UYkZ4QU53eE9l?=
 =?utf-8?B?cUVMenRWV2dhUmxPbnlFWDVZbm5aSnY4ZTJEQjkvZ2YrUVFFWU1oZG02OWRo?=
 =?utf-8?B?dDZ1V3VjMFg1bjBaV1NUT3lSaVFObWYwLzh1ZTlaRUdjNDhCMWZGN3ZMVHEy?=
 =?utf-8?B?QmR0ajVVZzg3TjV5Q1lQV1B2YXNJeU5nU0p4eXhKa0E0aWJzcFRHSjZ3V0lr?=
 =?utf-8?B?UkVBWnZVbFh4eTBRTTA4c3NDc0FZNUN5b2ZaY09IdW5wRFpHdFNHMjJ0VC9U?=
 =?utf-8?B?KzhXYTk0TkZOczNMVlBGN09NTXRzaTljZ25SOWFCLy9ES0Q3R0pHeVNPaWlK?=
 =?utf-8?B?NEdDcE95NS9uYkVNUExTZTRta05oMmZIMFcyYU5HcDBUdkNja2lRUmpqd3FM?=
 =?utf-8?B?bFhaQU0vTU1ZTG5Xa0lXRzRNT282ZUFNbGVPbUdKRk1IY1VIQmsxQU40N3Uy?=
 =?utf-8?B?c3kzNnpzb2hWSllpOEQ5MVlGcmRLc0VNZ3dpSnU1c1p5VFk0SlJMTFlmVGQ5?=
 =?utf-8?B?ZTljZHhVRE5xdlg2V2dXUGFlemd6dTV6WVErUlE4ZjhjY1NxK2plY2ZWZWJr?=
 =?utf-8?B?a01YN1NYT3VwRWp2cFk3Rk1UU2RXaEZvQXJTQ2hJZlZDSkpIKzI0UW1CQm9H?=
 =?utf-8?B?M1BYRThkdzNkVWd0ZkhmbldpVUdQc3RvUk5tN0hXSnF2YVNoK0pjbHFZNU13?=
 =?utf-8?B?Q0IxYVZ5NjdtbkxLS0tIRWVUQ0JYZlFCektTSXZIVnB0S2huUnU2M3NKdUJX?=
 =?utf-8?B?RlliTm83TEdCeENYdVZpWlB6VWk3YVRLVG1WYndCbG9CNnJyb1h1bUFmYTAw?=
 =?utf-8?B?cmpWbDNGZUJRSzkwQU9IV0dKYzUwbzZJUDM1WGFHK2FOU0pVS0cxYTRxVzR0?=
 =?utf-8?B?ZzFlUUNXbjA1OUZDOTZWbDQ2RlgzaDVNZGd0ZGw0dUtCWWlYM25oVXNCZWhD?=
 =?utf-8?B?MEdJQTMxbE1SMVhxN3gvWXdEZTNqK2lCYitNUWdKNlJ2MjR3eWJma1l1RHNy?=
 =?utf-8?B?b1daZmVzWEpYcnMxZkxwUXpCbjdqeDVtWmc4SlQ3bHdEeU9UWHovMFNmbm5M?=
 =?utf-8?B?RkVpM0VkRUtWSEVyTmxHTEl6c2lVb2lEMDd4Zy9EdGh6elZ2ZjZ1OHQ2aEJs?=
 =?utf-8?B?ZEhBa1ljaklYMjMzMUllK2V5MmZtaWJLNXNOMXAzaHRDeXQwWUdhTW9LV0hp?=
 =?utf-8?B?eDVqSU9MS3JhRkdoa1lpSkJoL0tMdmlEM1RkbnlqQVZETDhXQWEzS3BrMC9I?=
 =?utf-8?B?Ry80RFlKSXo3a1QxdFBFMGkrT2w3S29xWUlzR2RKeXFVcS9hRm1hazNiMXZy?=
 =?utf-8?B?MSt1dms1dUZhUVZSWmpoR3o3c2lSRkJqeDJlRzRsMENUaC9UOEZrMnJTV3Nt?=
 =?utf-8?B?TThUeHRsdzRrTkVWWUNTY3QvVm1BcjNkd0NOTkRQNDI0Tm5aSEhhTWFockVN?=
 =?utf-8?B?cVBZMHlnU2pJTGx6MVlvbjRORm80b21iV0p5ZTcrbXBvZFd4UVhoMUZTVmN2?=
 =?utf-8?B?cDZSWjRERlB1S1N0Nm5nNjl4OThwbWVaZnhOUTBGeE1zRnF6MFMvS2lKbDJP?=
 =?utf-8?B?Wm5FWm1jVk9iYVgxRXIzVExQcVg1cHkrMGd0aS9tUnQ1SFdRQnVkcUVweXZn?=
 =?utf-8?B?V1JZNlBSa3ROVkE4Q3BJaldxUmtHL3N1Y011U1VuT3NaemVTWHdQRWRRNlcr?=
 =?utf-8?B?ekpML3VuN2t4U2tCOVlrZDczeFR1bkFqSTh2eTkyV2syNitVUTNSZHA5V3ow?=
 =?utf-8?B?ZGJiRE5xYWJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODJYZ2hSWjM4cUIyWGpYdURSSGNpVGNTYUt4dll3d2RWQUg0djFHWWtHVG5E?=
 =?utf-8?B?VlVWa1ZHR24weUxnQ0xxbEpqTDQ1c2VWL2RGczZXd0p5aWJlM1hnZlVpYVRo?=
 =?utf-8?B?Um84cmEydW40bFI4WE5DSUpXWGxOTVZrRGJISnpIRjlpanA0RzVhaGdlN2lj?=
 =?utf-8?B?cUg1USsxdlNQL1RsVW1tdWlzS2tNNFNERHBudWZHRkFCalF2enFpbU1iSE9v?=
 =?utf-8?B?SDNqczloODlMOWo1VnEwSUlKV0pETGRadWthczRXTnZqNVExNUpMYkVyLzhH?=
 =?utf-8?B?eU4zSmZPK0JYVDEyMnYvQTJHZE1RVmR4eTJSYWd2SUtGOXd3VTI0d01qWTU2?=
 =?utf-8?B?ZEJ2Q3pHU0d2RVc2L29HdzdxYTAxTmo2M3o5VllQRmdLNkI5TkZ5a3ArSU52?=
 =?utf-8?B?V0RqSkJnciswNWo0YkJSMHYxNVh3WU02M3grSVVzQURFNzdPd0hkMG9WMnhI?=
 =?utf-8?B?ZkpUN2pDbG9EVDJiVmR4Z1FjaS8raEE1VEVVd2NnQkdMV2lGVGRvaGZmRmhh?=
 =?utf-8?B?S3NLdDJDMW9qdWpDUHdwNXI2R3duKzQ0SUFuTTVGUGFRRWRVeXFPS1hGRzZN?=
 =?utf-8?B?eGdJN1lRL0F4ZlZQRGxKa3VIL29KcG9MV2xGMzNHNjQvV3ZrZzF0OUVlYnRO?=
 =?utf-8?B?aTJNZWR4WFdUTmd5cnRNZDhEbVQzY0tSSDF5ODR1ZFkyaWUvV0Nvd2VsVm1U?=
 =?utf-8?B?VFZ4cW05K1lJYlZWQ3ZiSlRJMlBIbkJEZXc1SVlhSTRta1hkWG1meCtadWVP?=
 =?utf-8?B?VmFaQVJOZVZ0VUhRckhwdEtlckRUckx3UUNOQzBRaGZJemlrNFZRMFpVWDgy?=
 =?utf-8?B?WS9RRUJlbFV2bURxbnQ1cjRpbFMxbGpZV0tHSlVScndmeURTcEJVUUs0SU1m?=
 =?utf-8?B?bnB2YThHU0VqTEdHRFdiNTBOQjBFd0kyNFVUZWJDY2RDSXN3c3RFR3ZXaGxI?=
 =?utf-8?B?dEJrZkxxZFRrS3RFYWFKNXJkejlxVFgrK1g1TXdnYXdSZ01yNkFBYm1PU2pN?=
 =?utf-8?B?K2tSL0R1ZDZwUmp6N0JjdzNCcjN3Y0daUVNEZExOdmR4ekU5di9PYndBZFJI?=
 =?utf-8?B?WXFLVWd2Sk5SRXE1a1gzbjJiNTkxazNKaE1yd1MzbWp1bnpnMzlDNUdaY0lI?=
 =?utf-8?B?eUEvTEpzRXNSR2RmQlplaWYra1NFWHcrSWU1Vk5sZnEvRVBWMzVXU0JUSVlm?=
 =?utf-8?B?bjNWeVBTMlBTY09TcTlGV21xekIvKzJNZE9Wd2I5eG1ZdmZxRjJ1WU01SVBw?=
 =?utf-8?B?T01mbnFFbnNyWGltMk11akVJdWw1Y0h5ZTgreHZ5MXZkQkNQT1dQN0FJc2Ns?=
 =?utf-8?B?czN1QXdINWp2NzJzL0ZrMmt2dUZUSnYwd2R5NXhqZmpocmlISURpRElFbzJz?=
 =?utf-8?B?ektmLzM1KzN1OFBaZHZFWktOamhVQzg4Q25VRHZUeURlYlJUUmhKNFViV2hW?=
 =?utf-8?B?Z01uUUhFQXA4enRFZ0RHUmJNb01nZ3cycXhVUEVOMVYrdVRjREVHM2poc3dr?=
 =?utf-8?B?T08vMjRod053S25zc3VrVm53QTdQTFJFdUtjS0xjaVU5ay9vaTl3b2pwS3JG?=
 =?utf-8?B?UkM5QUJoZVMxdlZqYnJ6RU14blJjQjNteU1vdU1NWFhSd3JJZ2UyekczU2tD?=
 =?utf-8?B?UjBoTXVnWDVYSzlYWDh5U3Y2Rk41RFJYaUFPMTNuSXdFQngxME80N2NCV0NF?=
 =?utf-8?B?a0ZUclRhMWNLMm9PTlEzdXVHV3hKZHgxeFQrcTRqME1GOUVwV0swRUcrNEcv?=
 =?utf-8?B?aE40OENtcThnK1E1U1phNXIwMTh6NzBNa3VmMDNWMVp0TjErcit3QnJQcG1R?=
 =?utf-8?B?UGIyUlNmTWVmNzFjanF5TkhJTGFzODdSbXY0a0t5TVV0dVZnZzdhcWJGVmlZ?=
 =?utf-8?B?UklmbzV5eVBMbUFwbXFxdHhoWnJCdm1HM3RCSFBkS09CWkdhTzdhdS9WWWk4?=
 =?utf-8?B?V21ranF2aWV4UUo4U3VEL00zejNQSWNaWE9Cc0FBUTRvdDR6bTBKRlZSOTda?=
 =?utf-8?B?MGJoK1YxS1Y5L2ZUL0Q3cDZBNXkyWmd0cGY3c2VNYWhVMEw3a0U1aWg4VFhq?=
 =?utf-8?B?Wm5iTVRkOGdDNUZCVlFka1dUWkJiREwwTGhpMmU3ZVE1VHJtOFY2SnlnTUEw?=
 =?utf-8?Q?3DJ1reCmEKvT/zVvXzXFVMQ+w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a06520-9903-42fa-9755-08ddc4fff483
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:02:55.3984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDzygLnRTjMYTegXfK2WeIY4m/RyxeTMOOaZ1dDFrygHgBeA4r9+EEL9qJUdDI7QA+H1bZlOTJYZhFqPGfhb+ML2X8BmKsXtDTEyttIbE50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5288
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEwLzIwXSBpbnRlbF9p
b21tdTogSGFuZGxlIFBBU0lEIGVudHJ5IHJlbW92aW5nIGFuZA0KPnVwZGF0aW5nDQouLi4NCj4+
ICtzdGF0aWMgYm9vbCB2dGRfcGFzaWRfZW50cnlfY29tcGFyZShWVERQQVNJREVudHJ5ICpwMSwg
VlREUEFTSURFbnRyeQ0KPipwMikNCj4+ICt7DQo+PiArICAgIHJldHVybiAhbWVtY21wKHAxLCBw
Miwgc2l6ZW9mKCpwMSkpOw0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4gKyAqIFRoaXMgZnVuY3Rp
b24gaXMgdXNlZCB0byB1cGRhdGUgb3IgY2xlYXIgY2FjaGVkIHBhc2lkIGVudHJ5IGluIHZ0ZF9h
cy4NCj4+ICsgKiB2dGRfYXMgaXMgcmVsZWFzZWQgd2hlbiBjb3JyZXNwb25kaW5nIGNhY2hlZCBw
YXNpZCBlbnRyeSBpcyBjbGVhcmVkLA0KPj4gKyAqIGV4Y2VwdCBmb3IgUENJX05PX1BBU0lEIHdo
aWNoIHZ0ZF9hcyBpcyBvd2VuIGJ5IFBDSSBzdWItc3lzdGVtLg0KPkkgd291bGQgZG9jdW1lbnQg
d2hlbiBpdCBpcyBzdXBwb3NlZCB0byByZXR1cm4gdHJ1ZSAoaW5kaWNhdGVzIHRoYXQgdGhlDQo+
Y2FjaGVkIHBhc2lkIGVudHJ5IG5lZWRzIHRvIGJlIHJlbW92ZWQpLg0KDQpXaWxsIGRvLg0KDQo+
PiArICovDQo+PiArc3RhdGljIGdib29sZWFuIHZ0ZF9mbHVzaF9wYXNpZF9sb2NrZWQoZ3BvaW50
ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQo+PiArew0KPj4gKyAgICBWVERQQVNJRENh
Y2hlSW5mbyAqcGNfaW5mbyA9IHVzZXJfZGF0YTsNCj4+ICsgICAgVlREQWRkcmVzc1NwYWNlICp2
dGRfYXMgPSB2YWx1ZTsNCj4+ICsgICAgVlREUEFTSURDYWNoZUVudHJ5ICpwY19lbnRyeSA9ICZ2
dGRfYXMtPnBhc2lkX2NhY2hlX2VudHJ5Ow0KPj4gKyAgICBWVERQQVNJREVudHJ5IHBlOw0KPj4g
KyAgICB1aW50MTZfdCBkaWQ7DQo+PiArICAgIHVpbnQzMl90IHBhc2lkOw0KPj4gKyAgICBpbnQg
cmV0Ow0KPj4gKw0KPj4gKyAgICBpZiAoIXBjX2VudHJ5LT52YWxpZCkgew0KPj4gKyAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPj4gKyAgICB9DQo+PiArICAgIGRpZCA9IFZURF9TTV9QQVNJRF9FTlRS
WV9ESUQoJnBjX2VudHJ5LT5wYXNpZF9lbnRyeSk7DQo+PiArDQo+PiArICAgIGlmICh2dGRfYXNf
dG9faW9tbXVfcGFzaWRfbG9ja2VkKHZ0ZF9hcywgJnBhc2lkKSkgew0KPj4gKyAgICAgICAgZ290
byByZW1vdmU7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgc3dpdGNoIChwY19pbmZvLT50eXBl
KSB7DQo+PiArICAgIGNhc2UgVlREX1BBU0lEX0NBQ0hFX1BBU0lEU0k6DQo+PiArICAgICAgICBp
ZiAocGNfaW5mby0+cGFzaWQgIT0gcGFzaWQpIHsNCj4+ICsgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+PiArICAgICAgICB9DQo+PiArICAgICAgICAvKiBmYWxsIHRocm91Z2ggKi8NCj4+ICsg
ICAgY2FzZSBWVERfUEFTSURfQ0FDSEVfRE9NU0k6DQo+PiArICAgICAgICBpZiAocGNfaW5mby0+
ZGlkICE9IGRpZCkgew0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgICAg
IH0NCj4+ICsgICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPj4gKyAgICBjYXNlIFZURF9QQVNJ
RF9DQUNIRV9HTE9CQUxfSU5WOg0KPj4gKyAgICAgICAgYnJlYWs7DQo+PiArICAgIGRlZmF1bHQ6
DQo+PiArICAgICAgICBlcnJvcl9zZXRnKCZlcnJvcl9mYXRhbCwgImludmFsaWQgcGNfaW5mby0+
dHlwZSBmb3IgZmx1c2giKTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAg
KiBwYXNpZCBjYWNoZSBpbnZhbGlkYXRpb24gbWF5IGluZGljYXRlIGEgcHJlc2VudCBwYXNpZA0K
Pj4gKyAgICAgKiBlbnRyeSB0byBwcmVzZW50IHBhc2lkIGVudHJ5IG1vZGlmaWNhdGlvbi4gVG8g
Y292ZXIgc3VjaA0KPj4gKyAgICAgKiBjYXNlLCB2SU9NTVUgZW11bGF0b3IgbmVlZHMgdG8gZmV0
Y2ggbGF0ZXN0IGd1ZXN0IHBhc2lkDQo+PiArICAgICAqIGVudHJ5IGFuZCBjb21wYXJlcyB3aXRo
IGNhY2hlZCBwYXNpZCBlbnRyeSwgdGhlbiB1cGRhdGUNCj4+ICsgICAgICogcGFzaWQgY2FjaGUu
DQo+PiArICAgICAqLw0KPj4gKyAgICByZXQgPSB2dGRfZGV2X2dldF9wZV9mcm9tX3Bhc2lkKHZ0
ZF9hcywgcGFzaWQsICZwZSk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIC8qDQo+
PiArICAgICAgICAgKiBObyB2YWxpZCBwYXNpZCBlbnRyeSBpbiBndWVzdCBtZW1vcnkuIGUuZy4g
cGFzaWQgZW50cnkNCj4+ICsgICAgICAgICAqIHdhcyBtb2RpZmllZCB0byBiZSBlaXRoZXIgYWxs
LXplcm8gb3Igbm9uLXByZXNlbnQuIEVpdGhlcg0KPj4gKyAgICAgICAgICogY2FzZSBtZWFucyBl
eGlzdGluZyBwYXNpZCBjYWNoZSBzaG91bGQgYmUgcmVtb3ZlZC4NCj4+ICsgICAgICAgICAqLw0K
Pj4gKyAgICAgICAgZ290byByZW1vdmU7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgLyogTm8g
bmVlZCB0byB1cGRhdGUgaWYgY2FjaGVkIHBhc2lkIGVudHJ5IGlzIGxhdGVzdCAqLw0KPnRoYXQg
Y29tbWVudCBzb3VuZHMgcmVhbGx5IHdlaXJkIHRvIG1lLiBJbiBjYXNlIHRoZSBjYWNoZSBlbnRy
eSBkb2VzIG5vdA0KPm1hdGNoIHRoZSBvbmUgaW4gZ3Vlc3QgbWVtLCB5b3UgdXBkYXRlIGl0IGJl
bG93IC0gYXQgbGVhc3QgdGhhdCdzIHdoYXQgSQ0KPnVuZGVyc3RhbmQgOy0pIC0gSG93ZXZlciB5
b3Ugd2FudCB0byByZXR1cm4gZmFsc2UgYmVjYXVzZSB5b3UgZG9uJ3Qgd2FudA0KPmdfaGFzaF90
YWJsZV9mb3JlYWNoX3JlbW92ZSgpIHRvIHJlbW92ZSB0aGUgZW50cnkuDQoNCllvdSB1bmRlcnN0
YW5kIHRvdGFsbHkgcmlnaHTwn5iKLCB3aWxsIHJlcGhhc2UgdG86DQovKiBVcGRhdGUgY2FjaGVk
IHBhc2lkIGVudHJ5IGlmIGl0J3Mgc3RhbGUgY29tcGFyZWQgdG8gd2hhdCdzIGluIGd1ZXN0IG1l
bW9yeSAqLw0KDQo+PiArICAgIGlmICghdnRkX3Bhc2lkX2VudHJ5X2NvbXBhcmUoJnBlLCAmcGNf
ZW50cnktPnBhc2lkX2VudHJ5KSkgew0KPj4gKyAgICAgICAgcGNfZW50cnktPnBhc2lkX2VudHJ5
ID0gcGU7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIGZhbHNlOw0KPj4gKw0KPj4gK3JlbW92
ZToNCj4+ICsgICAgcGNfZW50cnktPnZhbGlkID0gZmFsc2U7DQo+PiArDQo+PiArICAgIC8qDQo+
PiArICAgICAqIERvbid0IHJlbW92ZSBhZGRyZXNzIHNwYWNlIG9mIFBDSV9OT19QQVNJRCB3aGlj
aCBpcyBjcmVhdGVkIGZvcg0KPlBDSQ0KPj4gKyAgICAgKiBzdWItc3lzdGVtLg0KPj4gKyAgICAg
Ki8NCj4+ICsgICAgaWYgKHZ0ZF9hcy0+cGFzaWQgPT0gUENJX05PX1BBU0lEKSB7DQo+PiArICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiAr
fQ0KPj4gKw0KPj4gKy8qIFVwZGF0ZSB0aGUgcGFzaWQgY2FjaGUgaW4gdklPTU1VICovDQo+PiAr
c3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmMoSW50ZWxJT01NVVN0YXRlICpzLA0KPlZU
RFBBU0lEQ2FjaGVJbmZvICpwY19pbmZvKQ0KPj4gK3sNCj4+ICsgICAgaWYgKCFzLT5mbHRzIHx8
ICFzLT5yb290X3NjYWxhYmxlIHx8ICFzLT5kbWFyX2VuYWJsZWQpIHsNCj4+ICsgICAgICAgIHJl
dHVybjsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBSZWdhcmRzIHRv
IGEgcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uLCBlLmcuIGEgUFNJLg0KPlJlZ2FyZGVkIFBBU0lE
IGNhY2hlIGludmFsaWRhdGlvbj8NCj4+ICsgICAgICogSXQgY291bGQgYmUgZWl0aGVyIGNhc2Vz
IG9mIGJlbG93Og0KPj4gKyAgICAgKiBhKSBhIHByZXNlbnQgcGFzaWQgZW50cnkgbW92ZWQgdG8g
bm9uLXByZXNlbnQNCj5hIHByZXNlbnQgY2FjaGUgcGFzaWQgZW50cnkgbmVlZHMgdG8gYmUgcmVt
b3ZlZA0KPj4gKyAgICAgKiBiKSBhIHByZXNlbnQgcGFzaWQgZW50cnkgdG8gYmUgYSBwcmVzZW50
IGVudHJ5DQo+YWJvdmUgc291bmRzIGEgYml0IHdlaXJkLiBBIHByZXNlbnQgY2FjaGVkIHBhc2lk
IGVudHJ5IG5lZWRzIHRvIGJlIHVwZGF0ZWQNCj4+ICsgICAgICogYykgYSBub24tcHJlc2VudCBw
YXNpZCBlbnRyeSBtb3ZlZCB0byBwcmVzZW50DQo+YSBwcmVzZW50IGNhY2hlZCBwYXNpZCBlbnRy
eSBuZWVkcyB0byBiZSBjcmVhdGVkLiBBcyB0aGlzIGlzIG5vdCBoYW5kbGVkDQo+aW4gdGhpcyBw
YXRjaCBJIHdvdWxkIG1vdmUgdGhpcyB0byBuZXh0IG9uZS4NCj5CZXNpZGVzIHNpbmNlIHRoZXJl
IGlzIGFub3RoZXIgY29tbWVudCBiZWxvdyBJIGFtIG5vdCBldmVuIHN1cmUgdGhpcyBpcw0KPnJl
cXVlc3RlZCBvciBhdCBsZWFzdCBJIHdvdWxkIHB1dCB0aGlzIGluIGEgZG9jIGNvbW1lbnQgZm9y
IHRoZSBmdW5jdGlvbg0KPmFuZCBub3Qgd2l0aGluIHRoZSBjb2RlLg0KDQpXaWxsIGRvLg0KDQo+
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTMxNSw2ICszMTUsNyBAQCB0eXBlZGVmIGVu
dW0gVlRERmF1bHRSZWFzb24gew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIHJlcXVlc3Qgd2hpbGUgZGlzYWJsZWQgKi8NCj4+ICAgICAgVlREX0ZSX0lSX1NJRF9FUlIg
PSAweDI2LCAgIC8qIEludmFsaWQgU291cmNlLUlEICovDQo+Pg0KPj4gKyAgICBWVERfRlJfUlRB
RERSX0lOVl9UVE0gPSAweDMxLCAgLyogSW52YWxpZCBUVE0gaW4gUlRBRERSICovDQo+PiAgICAg
IC8qIFBBU0lEIGRpcmVjdG9yeSBlbnRyeSBhY2Nlc3MgZmFpbHVyZSAqLw0KPj4gICAgICBWVERf
RlJfUEFTSURfRElSX0FDQ0VTU19FUlIgPSAweDUwLA0KPj4gICAgICAvKiBUaGUgUHJlc2VudChQ
KSBmaWVsZCBvZiBwYXNpZCBkaXJlY3RvcnkgZW50cnkgaXMgMCAqLw0KPj4gQEAgLTQ5Miw2ICs0
OTMsMTUgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAgI2RlZmlu
ZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRfVkFMMA0KPjB4ZmZmMDAwMDAwMDAwZjFjMFVMTA0K
Pj4gICNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9SU1ZEX1ZBTDEgICAgIDB4ZjgwVUxMDQo+
Pg0KPj4gKy8qIFBBU0lELWNhY2hlIEludmFsaWRhdGUgRGVzY3JpcHRvciAocGNfaW52X2RzYykg
ZmllbGRzICovDQo+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURDX0coeCkgICAgICAgIGV4
dHJhY3Q2NCgoeCktPnZhbFswXSwgNCwgMikNCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJ
RENfR19EU0kgICAgICAgMA0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEQ19HX1BBU0lE
X1NJICAxDQo+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURDX0dfR0xPQkFMICAgIDMNCj4+
ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfRElEKHgpICAgICAgZXh0cmFjdDY0KCh4KS0+
dmFsWzBdLCAxNiwNCj4xNikNCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRENfUEFTSUQo
eCkgICAgZXh0cmFjdDY0KCh4KS0+dmFsWzBdLCAzMiwNCj4yMCkNCj50aGFua3MgZm9yIGNvbnZl
cnRpbmcgdG8gZXh0cmFjdDY0IDstKQ0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEQ19S
U1ZEX1ZBTDAgICAweGZmZjAwMDAwMDAwMGYxYzBVTEwNCj5uaXQ6IEkgZmluZCBzdWNoIG1hc2sg
ZGVmaW5pdGlvbiBlcnJvciBwcm9uZSBhbmQgZGlmZmljdWx0IHRvIHJldmlldy4NCj5jb21iaW5l
ZCBNQUtFXzY0QklUX01BU0soKSB3b3VsZCBtYWtlIGl0IGNsZWFyZXIgSSB0aGluaw0KDQpZZXMs
IHNvIHdlIG5lZWQgdG8gYmUgY2FyZWZ1bCB0byBlbnN1cmUgaXRzIGNvcnJlY3RuZXNzIHdoZW4g
Y29kaW5nLg0KQnV0IEkgdGhpbmsgYSBzaW5nbGUgMHhmZmYwMDAwMDAwMDBmMWMwVUxMIGlzIGNs
ZWFuZXIgdGhhbiBtYW55IE1BS0VfNjRCSVRfTUFTSygpIGNvbWJpbmVkLg0KDQpUaGFua3MNClpo
ZW56aG9uZw0K

