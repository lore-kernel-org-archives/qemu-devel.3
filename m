Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF16CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHSM-0003qW-LB; Fri, 08 May 2026 05:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLHSK-0003lO-55
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:25:12 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLHSH-0008ED-9C
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232309; x=1809768309;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZqV+IvirTpEzp2uY0GbyUa/IczQSICDDzjqMvAsPC1A=;
 b=gtX5owLD9K97/lkb0hqETwNg1YOYDHWmxQz1OL29ylaMbHS1MMTuLCtu
 dRGyQ/PPLimJvQONMwcT+u3F+CLtRnwAIIGB1kwG/bvKUE355dSUNHxO8
 3qoY8gPk4NYKM9Yhr3wfkEIBoJe9CEaUZP9LB3Hreq2QIhz5EaXnKAhoo
 R1U9Pm/nR2VRvvsKbdE9d4VLLfFs1bQSwCVmHfeF4RVwtlk6qv6d9/yVQ
 GM3FeEFKTAoSbH+BddRdssVCcDaKzDO2LU9SkoOKnPV8BuifNVb6qWczq
 7eqkukON95ZCrSXx82QqAGbHv1YD5ceeXTYS5CK2Xwq+crFMD5tuCF619 g==;
X-CSE-ConnectionGUID: 1JwY8RkzSk2nMBA+QSsUAQ==
X-CSE-MsgGUID: T9xANlYjQUKTLmWS/P0VKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="101870050"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="101870050"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:25:04 -0700
X-CSE-ConnectionGUID: tW8i9hddTKu7dq7y2GnZ5A==
X-CSE-MsgGUID: LI8HhWDVSgSbhLT1OThX8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241723691"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:25:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:25:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:25:04 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXaN4xhEYJ5GU+j0enPLJ+hvhkLCmBTywZxS2xJY4mkBADpa/fiL5Mn0IPPKQZTseB0HWZ3wUhnSkfj0Bo9E0CEcXOnkMakcbeBUPm22dd1kUSD5KwFUBHxfE7YZS/nhLHu3S+5LHmAU9pVHtUdJXe7ki2/5TusHPG/igeRD+BFuMQDIOw92TeZgKpx2/LAFN6lwxcQMZM0gfi+PzgZmSsTTiQdsMVLoek+oUHOH+ZNwzKZtl0ic9Pyk/98bUkXKn5sAjOAe/0vvoUF/3WZ/YbWx0Pah9gy+5c1C/GGnUQmM7SfDBd5e2wDh7MCvLFomdSoQarfMeLqdezQBcmF0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RB8Ko+oHyg8mww7khr/5soyMghbJK71q7Lttnosabp8=;
 b=JzaBWntDyNVo77dgRx1FF1zVUsaDOIKK142mWcDeSrN9qqnuhUr5fMzEd3ZRIxXh5m+YusmctfGLSO22/qmhgBbYpXD08mA54zQ/eosiYTbNi8Hc4cn4QQADtDdIsh5cSnq3rvzYsdckD/91Myx7OcDhOO1opE5YMka5lm4QnKZP3YDL1ZPuZBZveDRb6bxuVfA2R5eGG5IvpqbjdBCAf8wjyo0Cadsu1lHkJ7YRtPuQJ3TWEoHpnxn1QgAnslD4QMxfIaogxABPcGhh8nMQ4mSfSfjp8FrItQJEFOu66aojVTNnWZlI0H8blTzRhvC3GJKPktx3+yH5GJ38z/3Aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:25:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 09:25:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHc2HD8BanUNHqXVU60FS6iP2zM9rYCPUeAgAGkC2A=
Date: Fri, 8 May 2026 09:25:00 +0000
Message-ID: <IA3PR11MB9136A83356C363CE12E16E07923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-9-zhenzhong.duan@intel.com>
 <66b8667d439df5f17a760870eaa7ddd56cea786f.camel@bull.com>
In-Reply-To: <66b8667d439df5f17a760870eaa7ddd56cea786f.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7732:EE_
x-ms-office365-filtering-correlation-id: 545f6300-6649-4235-6702-08deace3adbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: xDg3+WYC1XXF7m3EeNpwhsBlUny4gJfBgM7EaBxFJi0qY9p60tq5aUt4nWsJlma0YrceLXsQShA7u6J6kv1KlEr1wwK4RuGSO8XXHy3Ee3L6DNshDXYCtCkDwCfpXcUw1j/DYj9cFRd1z19U9Uh1GVO0XffMuIMCh/pkWpCdu7A4cKXFo/tzDuFBD6nCqgTY/QqejQmlZGvYlHT9Vb6/2bjTh4WEJ9nRvovKSomywMr1n3wC5rVos7Karywc48bYNQwUose5VYRZSC/UqB769udgwfWT0kbMsV6d8at8DPoXpLzsDaYyAOMzh5u4zv7Om7G9/tO7M61imt/agvhN7Dfi8jqa5xRF4XOj7X/m4sR4Taxi3uGDSYQcb95TFaatq/p/LNHjcIrhhG3GEnkPGOiEgBMyIk6LE9F3ztNRexQPR0cGjsErCl0EjXwAKMzzG9SdNPDG7+PSn8XEAOGdcO+9DcZ3qUMwZT+Af1iPOFeF3ghyFUcJH+/ObHwzVTGY7lvrua0Ozu+3Fw2PfLs4rBV/U3dmFIbeLg8YiX0sj1FsUDBYQb641x7u1kOUbpkarDy7hgR9A9Lws2ReNEZmTxsZPWZ6mc2V8QZA2yCBpkkHrjsMO00TzHAL9DaZIaOuRMS6M3S802nZwAeIuOwkoEULCbdb+iYo52970KJtCLaVeMVDht4q4SNzaX86WIoLXaym22ZLDRv1oxifmls6akZjt5koZR7buENOvMk4OvaZarweS3pjdCwyIMoegd+N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(38070700021)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bGhrYsItKwLx1mobKqVlZUrl8SMk2vvrEc921Nt8oXWRCU5jWk+R73ip1p?=
 =?iso-8859-1?Q?wS2RZB7xCfKiV66J1VZQFTOJ2XiqGZA/tLyegH6yV4VBp/GsLCpyHyYaMF?=
 =?iso-8859-1?Q?UethDUlROaxu6H10Jw/5B28yfTZJqhUN08EC9YHDDPUouhl9B+WvtdAXMZ?=
 =?iso-8859-1?Q?W0UDXE+isbf8RajaYSxWpT3hqYdtSg6+a3riiM2Noejrzt216dBV8bbH4F?=
 =?iso-8859-1?Q?G9Mo2YBFxIz956NZsARncRATNzwzteidGO1Y5bve1UG3O/Zqepy36X2+Jd?=
 =?iso-8859-1?Q?DwiqHjVUL+chwbLP80IKd8wWcem3L1qQRaYVkptOV8xpo3gSpQUdiihoU4?=
 =?iso-8859-1?Q?7yeXppoxXeCetrFCmmUV9UpthbcLiwAWXwFcwkNfj9g5lm7IoTE0Ru6Tek?=
 =?iso-8859-1?Q?NI2pwUDl1EjnzImRi1zvvkySvNHbnn6a9mj5Uc59HnZ4urEaQTFIlssIih?=
 =?iso-8859-1?Q?3vWSDPHzL+L5W1Pc2+P7moVe96qmVN27JT2uqJA5MlbXjkZL6dA6eypjw+?=
 =?iso-8859-1?Q?+qjbqgUm3UiVGVsPFKifvRdx45C1Y6DBpqr6oPgOk0lZCH4coeRw2UG+RX?=
 =?iso-8859-1?Q?QIAv29CAqTxI63wBEs0ve1uZ0udJOMPoK/mQl5n28Ny3BAcrocKakZman2?=
 =?iso-8859-1?Q?15kCIW7ZxO06S6gvy+SYpv7o5P8EtdIyn/Gqz9uIGItwl2BfgyEMZocI/0?=
 =?iso-8859-1?Q?LNKXAQYg9gG4j7LB2bkm0hnfecicc7OYyjcimh2yz6km3OV/j0IX2s9um1?=
 =?iso-8859-1?Q?7f13nvTBrWtJEjxzPufiqBmMQgX+z0W2VwZviE5eSga+9vNe7s0juKbFxk?=
 =?iso-8859-1?Q?xJTdnruXJYvebYaS0tlKRPqPeIqsUEOTZxTYpHpF4dCUhOMjhIRiOenkFA?=
 =?iso-8859-1?Q?0919sEfOD1eBq8tJEXtntgh8TFdxvTXHFEvshda0+YNIP6rVa/PQ9IZEmu?=
 =?iso-8859-1?Q?N9xry7wFTD81beJcGg+0DyQxUtVpjp2HfdPXp4B7rruDyIaQItpPn43Xso?=
 =?iso-8859-1?Q?OEPa+wBh0SEipN/vuaySIynSnXWowTtyd9V/Y+VkSjo3t4Av3Dfm6Z7Nfa?=
 =?iso-8859-1?Q?/3+E+yVFeRAqcGxScMoGN7uB39vY/+4OQtRrBwdzSn92keprDpL0K1Niyk?=
 =?iso-8859-1?Q?3Ld6k1VmcVGVUbAIiiA05pE7vC6iE+f9IfH4UMSmpKiRcQSm7ZCfMlJnn5?=
 =?iso-8859-1?Q?UUUjR/ab+uzk4jvSrAZArVEEVeoHBbUkasaHz97jQ+2sI+hwROj9hegfrO?=
 =?iso-8859-1?Q?E63HDaim+WBSzjU5qnA4wtI6iFPCdrkUngjLRHDUJ9yJEI+gReYvCHiZpZ?=
 =?iso-8859-1?Q?NUM61gK5GXK+HfYbEN4sQdFfC5tb+oedWH6yQ6U6dsLmzW2SEJcwYW8wN/?=
 =?iso-8859-1?Q?5NraSVuYQIynQv+P/YAihu7vjQ18fbbBufy4FNOb1GzbWg8qvFaDfYnKxC?=
 =?iso-8859-1?Q?qVMU0Zh1G7zrFoecq99VHXXhgz/cVSIeTQJOe525G1wmwHoVafaTA0K6iE?=
 =?iso-8859-1?Q?kAPYP4deLMIkOrecBvMstwBPXH7zFvgqkh4/m2oQqOzlsaiYV3erlyIXUx?=
 =?iso-8859-1?Q?yUj40d2VX9IprmsIM5T5yz1jZv+Uko0H3Xe4Xr3BSrrk49RqF7051uDPyf?=
 =?iso-8859-1?Q?CGWgMMlBVwdP7qgLU/iWkWRMw+gNSm/bKNvgzpiaQOmdwanLI8Tcv2Cy4D?=
 =?iso-8859-1?Q?/27HBZypD1t4Fs2PauEvyGGLHZr3W0JVF2Z4qWSevKs7ILlxW0zzWG2Ltw?=
 =?iso-8859-1?Q?7qFvb9+bnjz/M010Spo0rSaBT1WPd3o/Z/BOnsN9/Lzpe1xgdwF9THL/SK?=
 =?iso-8859-1?Q?+eZSZQEGNj49REPKzcBoymGr7QltfztLaa3NNSAFLVo1UsHkIGN9FGjerS?=
 =?iso-8859-1?Q?F2?=
x-ms-exchange-antispam-messagedata-1: iwMhks0WzsyM9Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EtvFRO/6TfNWs/qq3t5NOUs4YZucHDy4DNLeSko2R54OO7HETidUMZL6EOdqx4IWfSBnGODqgnr4EHoAaDknIT+Dn04yRy+jXGeJ8yYivG3LG+DDuIvSh/MWkFyrv9rwog+IOMiIEhFlS0cTul0AsNQewXEBm4UVv5uO/TQtLciEQS+1fGGYJRMw7Z4uDTqSw1oFuQNGuFtYBn/s5aSHB100rLUCPPmQc+RklyT7aOiK7pJmTqWyzPSKacE1grEb3awdWR5gxqFudvJ9gXcW2wuIpDpbEkqalkFzlQtNholtbTrfr45x3bImCOycyhk17mdsDgAVkozZf0nBJ+hzvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545f6300-6649-4235-6702-08deace3adbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:25:00.4569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KVaiJrNlO/Gjq8XP27lEFjay40vR/yVTxDUICRFdUWvHqdHGbtTpvi8kDveF36WkKqUxjSN7TVyZfZY6Xni3t75ML/1LTPoioNXoc3vPWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Clement,

https://github.com/yiliu1765/qemu/commit/9f71129bd215cdb5c416e3c7abb7c282fd=
b7c006 should be able to address your concern about below two code pieces.

Basic test passed, the whole branch https://github.com/yiliu1765/qemu/commi=
ts/zhenzhong/iommufd_pasid.v5.wip/=20

Maybe I should send a v5 with all these changes.

Thanks
Zhenzhong

>-----Original Message-----
>From: Cl=E9ment MATHIEU--DRIF <clement.mathieu--drif@bull.com>

>Subject: Re: [PATCH v4 08/15] intel_iommu: Use IOMMU_NO_PASID and delete
>PASID_0
>
>Maybe we should update this as well:
>
>```
>        pc_info.pasid =3D pasid ?: PCI_NO_PASID;
>```
>
>Other question: is this correct?
>
>```
>        pasid =3D VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->lo);
>        vtd_dev_as =3D vtd_get_as_by_sid_and_pasid(s, sid, pasid);
>```
>
>cmd
>
>On Thu, 2026-04-30 at 03:13 -0400, Zhenzhong Duan wrote:
>> In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
>> Requests-without-PASID, this makes the local macro PASID_0 redundant.
>> Delete it and use IOMMU_NO_PASID instead.
>>
>> Suggested-by: Yi Liu <[yi.l.liu@intel.com](mailto:yi.l.liu@intel.com)>
>> Signed-off-by: Zhenzhong Duan
><[zhenzhong.duan@intel.com](mailto:zhenzhong.duan@intel.com)>
>> Tested-by: Xudong Hao
><[xudong.hao@intel.com](mailto:xudong.hao@intel.com)>
>> ---
>> =A0hw/i386/intel_iommu_internal.h |=A0 1 -
>> =A0hw/i386/intel_iommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 21 +++++++++++----=
------
>> =A0hw/i386/intel_iommu_accel.c=A0=A0=A0 |=A0 2 +-
>> =A03 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index c7e107fe87..0141316f83 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -615,7 +615,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>> =A0#define VTD_CTX_ENTRY_LEGACY_SIZE=A0=A0=A0=A0 16
>> =A0#define VTD_CTX_ENTRY_SCALABLE_SIZE=A0=A0 32
>>
>> -#define PASID_0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0
>> =A0#define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)=A0 (0x1e0ULL |
>~VTD_HAW_MASK(aw))
>> =A0#define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1=A0=A0=A0=A0=A0 0xffffffffffe00=
000ULL
>> =A0#define VTD_SM_CONTEXT_ENTRY_PRE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x1=
0ULL
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 74642d8123..4d1b262d56 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -100,7 +100,8 @@ static void
>vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>> =A0 *
>> =A0 * Requests-without-PASID:
>> =A0 *=A0=A0 - PCI subsystem: Uses PCI_NO_PASID (-1) to indicate no PASID=
 present
>> - *=A0=A0 - VT-d IOMMU:=A0=A0=A0 Uses PASID_0 (0) to index the PASID tab=
le for translation
>> + *=A0=A0 - VT-d IOMMU:=A0=A0=A0 Uses IOMMU_NO_PASID (0) to index the PA=
SID table for
>> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 translation
>> =A0 *
>> =A0 * Requests-with-PASID:
>> =A0 *=A0=A0 - Both subsystems use identical PASID values (1-0xFFFFF)
>> @@ -114,7 +115,7 @@ static void
>vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>> =A0 */
>> =A0static uint32_t vtd_pasid_to_pci_pasid(uint32_t pasid)
>> =A0{
>> -=A0=A0=A0 if (pasid =3D=3D PASID_0) {
>> +=A0=A0=A0 if (pasid =3D=3D IOMMU_NO_PASID) {
>> =A0=A0=A0=A0=A0=A0=A0=A0 pasid =3D PCI_NO_PASID;
>> =A0=A0=A0=A0 }
>> =A0=A0=A0=A0 return pasid;
>> @@ -969,7 +970,7 @@ int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>VTDContextEntry *ce,
>> =A0=A0=A0=A0 dma_addr_t pasid_dir_base;
>>
>> =A0=A0=A0=A0 if (pasid =3D=3D PCI_NO_PASID) {
>> -=A0=A0=A0=A0=A0=A0=A0 pasid =3D PASID_0;
>> +=A0=A0=A0=A0=A0=A0=A0 pasid =3D IOMMU_NO_PASID;
>> =A0=A0=A0=A0 }
>> =A0=A0=A0=A0 pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(ce);
>> =A0=A0=A0=A0 return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid=
, pe);
>> @@ -986,7 +987,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>> =A0=A0=A0=A0 VTDPASIDEntry pe;
>>
>> =A0=A0=A0=A0 if (pasid =3D=3D PCI_NO_PASID) {
>> -=A0=A0=A0=A0=A0=A0=A0 pasid =3D PASID_0;
>> +=A0=A0=A0=A0=A0=A0=A0 pasid =3D IOMMU_NO_PASID;
>> =A0=A0=A0=A0 }
>> =A0=A0=A0=A0 pasid_dir_base =3D VTD_CE_GET_PASID_DIR_TABLE(ce);
>>
>> @@ -1529,9 +1530,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s=
,
>VTDContextEntry *ce)
>>
>> =A0=A0=A0=A0 /*
>> =A0=A0=A0=A0=A0 * Make sure in Scalable Mode, a present context entry
>> -=A0=A0=A0=A0 * has valid pasid entry setting at PASID_0.
>> +=A0=A0=A0=A0 * has valid pasid entry setting at IOMMU_NO_PASID.
>> =A0=A0=A0=A0=A0 */
>> -=A0=A0=A0 return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
>> +=A0=A0=A0 return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
>> =A0}
>>
>> =A0/* Map a device to its corresponding domain (context-entry) */
>> @@ -1592,7 +1593,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s,
>uint8_t bus_num,
>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0 } else {
>> =A0=A0=A0=A0=A0=A0=A0=A0 /*
>> -=A0=A0=A0=A0=A0=A0=A0=A0 * Check if the programming of pasid setting of=
 PASID_0
>> +=A0=A0=A0=A0=A0=A0=A0=A0 * Check if the programming of pasid setting of=
 IOMMU_NO_PASID
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * is valid, and thus avoids to check pasid e=
ntry fetching
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 * result in future helper function calling.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>> @@ -2150,7 +2151,7 @@ static bool
>vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>> =A0=A0=A0=A0 vtd_iommu_lock(s);
>>
>> =A0=A0=A0=A0 if (pasid =3D=3D PCI_NO_PASID && s->root_scalable) {
>> -=A0=A0=A0=A0=A0=A0=A0 pasid =3D PASID_0;
>> +=A0=A0=A0=A0=A0=A0=A0 pasid =3D IOMMU_NO_PASID;
>> =A0=A0=A0=A0 }
>>
>> =A0=A0=A0=A0 /* Try to fetch pte from IOTLB */
>> @@ -2515,7 +2516,7 @@ static void
>vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>> =A0}
>>
>> =A0/*
>> - * There is no pasid field in iotlb invalidation descriptor, so PASID_0
>> + * There is no pasid field in iotlb invalidation descriptor, so IOMMU_N=
O_PASID
>> =A0 * is passed as parameter. Piotlb invalidation supports pasid, pasid =
in its
>> =A0 * descriptor is passed. In both cases, pasid is converted to PCI pas=
id
>> =A0 * before checking with vtd_as->pasid.
>> @@ -2586,7 +2587,7 @@ static void
>vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>> =A0=A0=A0=A0 vtd_iommu_lock(s);
>> =A0=A0=A0=A0 g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pa=
ge, &info);
>> =A0=A0=A0=A0 vtd_iommu_unlock(s);
>> -=A0=A0=A0 vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PASI=
D_0);
>> +=A0=A0=A0 vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am,
>IOMMU_NO_PASID);
>> =A0}
>>
>> =A0/* Flush IOTLB
>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>> index bd1236c070..8940d240a1 100644
>> --- a/hw/i386/intel_iommu_accel.c
>> +++ b/hw/i386/intel_iommu_accel.c
>> @@ -217,7 +217,7 @@ static void vtd_flush_host_piotlb_locked(gpointer ke=
y,
>gpointer value,
>>
>> =A0=A0=A0=A0 did =3D VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>>
>> -=A0=A0=A0 if (piotlb_info->domain_id =3D=3D did && piotlb_info->pasid =
=3D=3D PASID_0) {
>> +=A0=A0=A0 if (piotlb_info->domain_id =3D=3D did && piotlb_info->pasid =
=3D=3D
>IOMMU_NO_PASID) {
>> =A0=A0=A0=A0=A0=A0=A0=A0 HostIOMMUDeviceIOMMUFD *hiodi =3D
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod-=
>hiod);
>> =A0=A0=A0=A0=A0=A0=A0=A0 uint32_t entry_num =3D 1; /* Only implement one=
 request for simplicity */

