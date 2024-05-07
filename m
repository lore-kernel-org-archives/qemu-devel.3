Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644BBC25B10
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 02:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4AXH-0002n9-Na; Mon, 06 May 2024 22:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4AXF-0002mN-Mi
 for qemu-devel@nongnu.org; Mon, 06 May 2024 22:26:29 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4AXC-0002iY-Pn
 for qemu-devel@nongnu.org; Mon, 06 May 2024 22:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715048786; x=1746584786;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A1p2mab793m4w8oI3KQGJqbBGQtpDVg9S+IqXLik4II=;
 b=JyFXhSP5Rc3yt47dRRhAEwG4zT/p5mamgKNmyGbDIcXn7AjUPbcQWP+m
 0/G2jwzCpiAbd1QPhfSXmLzvTFXuFC+0vht/GvSDsdZBh/3cH3MFjTEmz
 D8M4Oiqof+/EMqpt6s4El1YFlOAB5eFs6sm4U9bsD6wa6J5oWD2B5cFWA
 VkP7Ed04oua4t+YyyzQdhjW+bw06nHpCGo8ViFih/tMsuhOKkNgQft3UN
 ll865W221y2CDQV/tsyUxtgkRyPqv0NJIa1d6bAutsUG5nN8YFtvIhv0h
 M7+SOBn6kpir+28jCHYLfMoqZDCVHEf4ENsq3AoxnbHaMVzLeeP3m6vNL w==;
X-CSE-ConnectionGUID: pLGuc+6tRz+64bdXt5nBxQ==
X-CSE-MsgGUID: 8UWsnMx5Tpuu4nN7nV6HHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10670306"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10670306"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 19:24:34 -0700
X-CSE-ConnectionGUID: p1etc+JPSDqDPF0v3DQ6Wg==
X-CSE-MsgGUID: 9084Bx29TkaQXIuNl3c2ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="32927144"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 May 2024 19:24:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 6 May 2024 19:24:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 6 May 2024 19:24:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 19:24:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrMw5YQIeDzNPw+bR7cVCMgOpdjlF32nMh1pjRO4VFI54wz3MqlZMWHX9Zpz1EpKJHYPmtWdcLf3IvMkR1Kxq/jkyY/OZqzvqId0kSOnc14V3sooMFHg9lDobHe+/ZjGpb0CfoSXs4YogMbNsNNJUYaKSsUAgUffZ58TB4te2V048BT5lXAQDE+d5vaOW1StQ/l+2dXKDij/t9fGjc0BuPpazxXTyw22cC2JKaWADGxeaHQwwNvt+PiIYTb+TCISgXefkXgITA+I6I+BZlL9VYNjuN79QVSUCCjoBQoyDbvHFYOFOw5/WS3tN4tPkagBt80XYeVpK95rOwEN/SeuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1p2mab793m4w8oI3KQGJqbBGQtpDVg9S+IqXLik4II=;
 b=Xb5ksbAUKjntBeH+tQkX5qhHKWLl7fJRVpqFevjZaggGVyiHb0x5K9f4MYnxpMgjVKu0qiNfS/LwE3f5EP6mWwbxnm5sZU81qujLPZ5YggCRH6CIJMKY9WjLQFGkVB16ec6RJfzsg5CMrDV/XlTTJEdHLCdI3sL1Lgo1/5KvH3AE7lc6B1PrxXONg1ZMNGlsSObbh4rUAM59VIDo4Blrv7//7uE3tL7kqzvOxISR6ztOfQavoZ/GIlqH7git/gq6lXhF+GHxEEYMvGbCBSVq5ZhlWL6kubPJaX7qtoTMPFUNL1zKvAQL1qtORECoMMy0nRGV0hKeAGKYkELW2bplng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Tue, 7 May
 2024 02:24:30 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:24:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Topic: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Index: AQHamgH7eck8+te5Z0qCq1cTh3hQ5rGFkZiAgAPqERCAAKvBgIAA6+uQ
Date: Tue, 7 May 2024 02:24:30 +0000
Message-ID: <SJ0PR11MB6744C6038585F0014429C27292E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
 <SJ0PR11MB6744A435E58FC69DF37AA148921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240506120541.GG3341011@nvidia.com>
In-Reply-To: <20240506120541.GG3341011@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6145:EE_
x-ms-office365-filtering-correlation-id: 9cc06767-dc80-45f9-69cc-08dc6e3cd38d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|366007|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GavvVNNkkGw1H1Ku+G40zylS12R0le7QBsF93zOSyfDORqCqcht2ygANjT?=
 =?iso-8859-1?Q?MQDxrff12MLzClQskcw9XxHSGbheCsgPXUuC6ppz4sUG4Ab/E2augBIVdt?=
 =?iso-8859-1?Q?8lI7q/oz0Xm5ec4gBKJTPxAsqvZqIQBnPkBiUTreStufte/4q+0+n8W1v7?=
 =?iso-8859-1?Q?DSbFqc+cvp9Hg6FvjFU2Gl5+yDf3loASvIepIeJURJdt0WRGlPYBoPg5ce?=
 =?iso-8859-1?Q?zyZwKhEz+4YYxXS+G0i6F0qjPCpIvXEdaVHlV52yBVN6ams3ffcVos0jjW?=
 =?iso-8859-1?Q?ja/4rZAYHzht3iw8zeaHZHqDRavXaR//yiblmtpTNdXp05wtjO74/ILbv4?=
 =?iso-8859-1?Q?2AAm5ovCEJ1RghJS6Qc8UNhJrOOxHkKGFMPQ/Bomm6W+2Dz1IBKxoEM5tI?=
 =?iso-8859-1?Q?tv3MQjOQbygTH4Zl0PKodqKjVEuEDhkKhuFrS9eHN5+wsWWok5/QeHCVLL?=
 =?iso-8859-1?Q?E+1DE+HEVII0MnEdLUo4fRB5ov1aRKQpmbzE1UFyaW1oPxL3+f5p/bnI5G?=
 =?iso-8859-1?Q?F4O70qbdwertfJ8vir3/k4OFrwFPnSuGkKnK1olJgfKVrrA73lQaduxkd5?=
 =?iso-8859-1?Q?VsStbXZArMER/1MdC/Borx2zG0i4pEbPc0rniSuHmdOUGkuVNuOwRqF1/s?=
 =?iso-8859-1?Q?TdH+ctDubgrQilkjRUMkbgoblr/oM/0c139FJziiei1zqqUKmLlUGnJdJo?=
 =?iso-8859-1?Q?j8rxcEYawDndTk+HsEAzJo09G6b0Ij6NEjdg8lKHje9Jtdz1DGDiYPxWpT?=
 =?iso-8859-1?Q?cubSdY4Oh4SGeqkNRAYPMqD6G5tWYUb+Ac58ngbEvwclbudcgNuU8lkkqD?=
 =?iso-8859-1?Q?GOT2NoBlbqIiUDdvk37KXqPfeMqNlL+RJ/9XqHSzlhG+fyumhl3PyRCpu+?=
 =?iso-8859-1?Q?mHup5aDmY/9P/AfouCEuZpuCmM/cPmwjUXGuqQU2X1R9pavSIN1ia3b5LF?=
 =?iso-8859-1?Q?AowhMk49WCFtXPR4uML7vM+h9DtPFipib0W9v06elADJiIsXBK2CAT/teh?=
 =?iso-8859-1?Q?TDQ9OXnfFLTT4jfjqgdKFqp8212KVLMlTbaqleyL2a2YbiVcXQAaspTxhy?=
 =?iso-8859-1?Q?U2gizD7CBW3yNruhraxRxolT54PMUPlOouoYLZVR5ykRiEoXFpoLjTUTS5?=
 =?iso-8859-1?Q?nF7kSG/jxt7/sIs6snOfGmqjGkE9l4vsQv5KV/bdDD2qS10o3IC8OoH6WZ?=
 =?iso-8859-1?Q?BpVcH9weo3arRxkd7hM/9jYqn0XgTdNh3GmYLj1taHHcZdY+94uW5kKY4t?=
 =?iso-8859-1?Q?q5W4InIvoOq2jcj3yx74vDGWSG/g3xPQjtqxCMBv+zBCGmzKE1afqL0vl7?=
 =?iso-8859-1?Q?+CrPHAIcW1WTZjkFLUfB2ViHOQ87Vjwis3pHmEZuSNwNsBNdKU2Ps2Zkyw?=
 =?iso-8859-1?Q?LADTkkDXRLrCJCIvqa+H+agnHYZ35ylA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l6Emtk8Jan/TK99evcrrKpmOuyBSGSAc7DqZxA6KD5CTePQqUAlcSdnGNo?=
 =?iso-8859-1?Q?HT+VIb1UvK+OR1/blwUXydXIS0h52Ac1LKDk8VGosuwagOMYmWlWynSbHG?=
 =?iso-8859-1?Q?q11rmONn0Ves8VBE9vvhVKSjTJrQ8P68ZGVCgcY0iH7jzy3Czvg8LEB3yy?=
 =?iso-8859-1?Q?2RatvVB6puEVy2ohzch0S7OnHUsULkkMM9ia5379ODXI+tw53GhaM2njzs?=
 =?iso-8859-1?Q?InqYIUxcLfAgi6SIs3SGI2ajffRVRe6wLAbriXkVZdxuuMTGOfGZyOU1It?=
 =?iso-8859-1?Q?6eZukZHipaT+aqh1PxmZureut+ArMx3VwGB3yPglW/jmT/9AZy2CH3aWFo?=
 =?iso-8859-1?Q?7YphZRdAcqdjUcFkswWYSLBtQU6LuiFCeAUJPUiOiv3tu16yuSA3DyIS9L?=
 =?iso-8859-1?Q?XIKKQfad7tQLEq7UxEDDKIg2mM4C2DgebIb/ZvgxkIwjpMQofzEHIUxYg9?=
 =?iso-8859-1?Q?H+2J9PdVDWXkaBznGlFnlAlhTpxeIxEmHrpOTlr342H+J3uyJrHTu8Ev3G?=
 =?iso-8859-1?Q?BJc5DnpCMmWBhJnmwahn0Kd3Mi1g9RcEdV0PY0TydZZD1eODzZnVJLaKbA?=
 =?iso-8859-1?Q?I++b8wva+KiKS7ITF+RGorfRhZEVjjVYGKAShnX7kVS6d1DqWZMx8xDSRM?=
 =?iso-8859-1?Q?oy/GR2sFB4NwZPXbyvJtiX+mdEObjUBpeObmNUz9jiQD3BneBgBRw5FSr2?=
 =?iso-8859-1?Q?yZR5whh8iQwlZ80y+XHz0Jet9/Ti0fRm2kpSVezvVZS2pg6mAXtnHfGqRP?=
 =?iso-8859-1?Q?wFgIf2au/c6K6YgOPpjHT26S+k1PvXXL/0kqh1ll1do3gwS3sL9Ps0+mvt?=
 =?iso-8859-1?Q?3Gy0eQ5fxHRnfIRDsNfzYCOrm+EyMsSK4gra/a+LFqU3f3xHO0V5HytbHu?=
 =?iso-8859-1?Q?gVWFhf/T67rQVUMsnu/HXR8pMfmEhC0GBYcAA6Vv6C9zZiF2qZYh/WmZ5U?=
 =?iso-8859-1?Q?QtqtG9YyahEq7JFTw8u5FaXzSH4csLR3an1SRGlR7gUoIeAxTNBvTQRThs?=
 =?iso-8859-1?Q?sQdA3XUtYVwmyYaHMl1sTiAlUJ3SeGsaZQP29ISvHrjchzICOereaWWhX5?=
 =?iso-8859-1?Q?RxIuHJJ+3KtIjFL3pzJr3ZkFo2TCm+68Ys/zqY6C90tpxkSJmvru90T4QX?=
 =?iso-8859-1?Q?8eqOfQ2c83FhoDXlEYJGKEhfXno7bdvMv3bG97D8xTH255Qc1fpcKPD9Ip?=
 =?iso-8859-1?Q?iwakyxsDvCAmOE8veFfw3A6vxaytAvfoCzYEW/p4lNLIiS0iJDPVQYDDtb?=
 =?iso-8859-1?Q?qNmZeUUfOWAH21AMXWQxmMEUs9G+f2IjmXAAZm6MzArVJV1sS60+WZNAgh?=
 =?iso-8859-1?Q?sbdOu9q1i2RX4Vgl5/U+odDX+xTyJi0FL/GZaMTflDuAqSCUUFvAZxLOl5?=
 =?iso-8859-1?Q?hPvrvxKC1PDuZOTPo5cYRAbSQRhRkICGgLUFD8Mfw48ktxswr5GrUKCIJB?=
 =?iso-8859-1?Q?PFAwMZTvZMtuQednGPeaEal5S3rqolpAEgj5OsRCbtgLaoS4cvKvvXWVHS?=
 =?iso-8859-1?Q?F5vm7L4nmg8J6QCLnJPA8dfkgvhkjPEm0CMOBs03kemByAeQIxl+c+hYHw?=
 =?iso-8859-1?Q?fXP1n+kaQHpNgTYVu3BHJjUtX6Yo4ICexBMZSsbhUhtJTpVkR1JR1xSh/w?=
 =?iso-8859-1?Q?Z7wjKhyHm8eulfmSfEfShJyMhXK/x4AS4C?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc06767-dc80-45f9-69cc-08dc6e3cd38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 02:24:30.5632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iw2I1qmtU/eMpDryqiSmZXEVmGO+hHfp1jKum1he8v3+M/OQAqgKDzBHHr82EuNEiwLHe/2xBvt1QGIGXAvHdM1ZZI0vdS60vOjVwcpFAbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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



>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to
>check with vIOMMU
>
>On Mon, May 06, 2024 at 02:30:47AM +0000, Duan, Zhenzhong wrote:
>
>> I'm not clear how useful multiple iommufd instances support are.
>> One possible benefit is for security? It may bring a slightly fine-grain=
ed
>> isolation in kernel.
>
>No. I don't think there is any usecase, it is only harmful.

OK, so we need to limit QEMU to only one iommufd instance.

In cdev series, we support mix of legacy and iommufd backend and multiple i=
ommufd backend instances for flexibility.
We need to make a choice to have this limitation only for nesting series or=
 globally(including cdev).
May I ask what harmfulness we may have?

Thanks
Zhenzhong

