Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA4DC7115C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 02:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTWnF-0003tl-A7; Sun, 22 Jun 2025 22:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTWnD-0003tS-LA
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:20:19 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTWnB-0000FI-7s
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 22:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750645217; x=1782181217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kiz/Q/rRJsb/G4dcFSc4RtQ84PlHMqZBo6kGQOe93rM=;
 b=BpBTyYDzve6qm+QFby641A+YeWBOnVbWfg3diPeARCn6clX25WOUjLKr
 3JFcCmctgKxDxuNCjHXckjvmNswhzL9ELShg5fMaePgArZdefqZAWFlrd
 OUtTOOOcgynnajSC+a3OmjvD9Igz4AeoGl0Io0/58kA4nJTTaDAc0m2xZ
 K6T7m6wUY4ffIPQKNRKgXfF14mam78WQdQQI9lBdJ+LfCjcdJ/tV+ZRzY
 h8oXucWWJCjNcb/960D2yDGyO9ckZNTX/V1JhUiWwggYbdTwLSwG/bFiW
 MFSrcquIqe+dlo0f7Q+Ndpn9z7l1KWbvy172plOILQSkHq/+ExGXg4pPJ g==;
X-CSE-ConnectionGUID: 3TWEBpdYRJi3ZU8rtWzXQA==
X-CSE-MsgGUID: YYPYJsYZT6W5xNSYaOnc6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52768208"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="52768208"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:20:13 -0700
X-CSE-ConnectionGUID: jy0J523SR56jmFpfakuASA==
X-CSE-MsgGUID: 3fmG1ny9SoGcRcCi56VxQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; d="scan'208";a="152137666"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 19:20:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:20:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 19:20:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 19:20:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STzEam81COaVhq3dpe37KQYsMymbxX7N2AMHWL9WeoFQPW6vOJErZEV2dvN2vYRugefZiNI4h3AsLj7p6RAvMz40oXLW8ViThJ8JXaKn66eDDIlmt5L03rEZ4kNn+q9YUC/WyCAtTI4y7hxxdUhnDtunzP+rJTS4Un4NLFDiTUtCjT2vkCNAIwpgjt+EgVxHgBeG96fp2SIZGErIyH75VKBGgf10Jwof0recbWJlyGzFMS1Kg3vErcGewYIXRyYbLN8McTqfWCHS6VukWZ6hXRB5POYZ481Tie2O2OzxSnOkC2Ez60DB3/mTxpuEHLDlB7//9bQOaUF3lvusGYWn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2bCGnuG/cyjQfZfggKvLu7bTQAR9uf2p8v4U8bQTFg=;
 b=E251tee+HDEXCahPUaaEZdlqJC+tn264GgHfG/TpxsIo99a3bpLV3MSJRejYv19EWEP72/KnjLlaUCXkuA7eLTsUfS7uVbR1GgKv+fRlWX4zg7O4WbkLnHv3bhnrNhEXnJr/Yb2ZFdtOqJDJ72NMnJkF/Gnxlb2mIyYJDrchtvg89THBnisJvSS9UGxCXxGBNCL5JH+psFn+QouLIj9Jrh5BVCy9ikqlVf9XJa4Y2ykvj6lY1xo/8rbfmUlAx7pbMLQcOwTStkwN0xcCLblHXiDPm/4dLpt0ZvLd1J+yiRqq/ruimW705kY7/FEY0g3GMUIJtJymb/N/dFL6HRd0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 23 Jun
 2025 02:20:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 02:20:08 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHb4bQXUdNHImQvMEWCMlFd/qLw17QLrXiAgARYSxA=
Date: Mon, 23 Jun 2025 02:20:08 +0000
Message-ID: <IA3PR11MB91366E9CE94069B41DF4C43D9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-3-zhenzhong.duan@intel.com>
 <15fa4c74-347f-4374-b225-d97f340d045b@redhat.com>
In-Reply-To: <15fa4c74-347f-4374-b225-d97f340d045b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: fe7c982c-aee9-45b0-65af-08ddb1fc79c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8OTrpACGiBtkhpmL1jPwUDMNlA0eLXERLgy4ShyypR0DUhQbw9eepBrmXohR?=
 =?us-ascii?Q?6usQQNexG1nkhEZ9J+bs4d21fY534aQTYLsNzp0I4jSNB5glZji9eptEADz/?=
 =?us-ascii?Q?xBLX5d/qVPanw4TEnDj0tOc9/W9Ew5Qu7JhHGI91LD9JKI67UrjywZSnP7vZ?=
 =?us-ascii?Q?0iRD5534l1sBVSy5jgYxBbrjTvgdS/WuiseIM6F4GGH7ocCEDKlnRsZPo9vo?=
 =?us-ascii?Q?wLqGQmiijG9snnekyd5vJcDuU/Q9OqAl9uaqN9oLjOIz278RmYJCocR4NLD/?=
 =?us-ascii?Q?nRAx+XdxM151rC7ZJFHtwi985MHjA/JELmPRKDnqwlfljdVeK2YaPgn/qUcm?=
 =?us-ascii?Q?tqVRXHv5sh810K3nmV+LsrOa0M4/S6A29Lunh/yhLj3Tbhi3eby7s14VP8gO?=
 =?us-ascii?Q?p+EarCn9oZ8UXWrAP9KZuGVGd2PopNb8qkbd+aEJKbHvk5n2qpPrtJqxsQ7E?=
 =?us-ascii?Q?ripELL4zUX2lB76sCotiyHcTvie1WyQMT7kjimSm440DpBe4f2/tVIVT6oNc?=
 =?us-ascii?Q?uocNKjjNyXW7ZtTVSSzW/l5e+0YED2AXgLZekdb9rZlmLurIm5gtxKabiq5b?=
 =?us-ascii?Q?+tkW1ouvwv8OgHC7QP+lgOtvdq6rbaEC0e5blfvjKDB3UDWM3FRWKZ73o1fV?=
 =?us-ascii?Q?OeCrCp64CGLOJCuOswAeoUWtUIu6yFA75o/O0Un19B836gAIwp5HpsP4FO8i?=
 =?us-ascii?Q?4nxLj+bwJCrf7HIC4KdZgZTHDuAVPiKlh4JK3oh5mm/TMzvvdF6Ck1U6lG5X?=
 =?us-ascii?Q?pZ8J4vP9ee5tzqgQROojt0P0at7XjsOw9obalj54oIVs+iGAHJSnHY62wmR6?=
 =?us-ascii?Q?FXXfSiP5xaecH1mLo2bkbpEg7i1EYlB8R7U7MK//tQxcmYBIfxF12ZNQawEX?=
 =?us-ascii?Q?LwrZN2iVkuLTLFokYJpfedhFm01PPv+syjpmGYaivwLR10tvusgAPMK7Ic5S?=
 =?us-ascii?Q?z4tjXlR0uCXM8T0jQ/D7rYUkv8PmfUlDRvpHIfgH3VSJTxi155yHXq5H91gV?=
 =?us-ascii?Q?rgzZV6lWONSJgzV37VWloHO1SudfEl9IWarFFkAe4cwePzo1SCUOxGBpZe+z?=
 =?us-ascii?Q?pZfJ25Iiwoeqp8Auf2YT05IYJTF7YXgWnChMP3cBEPuiY8EukwDoHmPzIjGB?=
 =?us-ascii?Q?MgVKjqY4Lo80qhjPxUg4nzzd2uLIrhfepU4n1WUkVztw7UjjiAcaZHtetFpZ?=
 =?us-ascii?Q?Cy120mhZtd6L3/feMqrb/kGXfrgVO0drh2BvA8e058TG+kXbuY/bA27xEo+5?=
 =?us-ascii?Q?KfYrx77cOixQjdU11wsbddd0yvrAFOkw447z9xZ0DzcBN4fK64is40mC3ar/?=
 =?us-ascii?Q?rb66Sa35BqEC1fP0udxM/XyY4D2Ls73chFsSsqCM09bzESw6cS9yWB7yrMfO?=
 =?us-ascii?Q?TxZi69DzfRmKsvAfovrMYHlLr3iXoNBoHDSfiIR90cqJ1phJ05E0EH+M5VSc?=
 =?us-ascii?Q?dMLiFDtU4JeP/0gkyjJhUBUbNgXTxhOFvYzbZWWdi/YZqUchEQVvhknKMOWf?=
 =?us-ascii?Q?mfAqZhFjHU965MA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aolYOfGEeLtBlZpz9kXvIO86WD+v2sMPgzDkIPzLXZLfUQI+hhy2HAnzeCyf?=
 =?us-ascii?Q?Ei6fBBJkZLLJkNEXL7PE3KltHwZN4/X4usH7g/VeQl7bgriC3+FnQQA9I9IC?=
 =?us-ascii?Q?qGI88FWkYjSGTwGPpFzn/HCzIMm10ga75OJuD3grPe/QUIugYqav1BfT3soV?=
 =?us-ascii?Q?vfvpzEVL2O6asmZ15htmvsu74ic9ujMiaHbDVIvm5RofUsniyzTxwwkjYm/O?=
 =?us-ascii?Q?Jk+5JTMQlU1/hEqmIjXv1vNBGT72PLKobHMbVsl0pKX+/lVrP6f9o53SD3Kp?=
 =?us-ascii?Q?yNZav9gowfgJKn9zovq88Tr1fcBogAW/jCv23n9SCR5D7+62czZCx/FT4osp?=
 =?us-ascii?Q?qF+xdnW9koCeTycRLc2H9M2tC3Vo1HjwAFTu+YGbIMgQFba0G8ksHEeqhsZu?=
 =?us-ascii?Q?+6fyPVEGq8ACrnfmeN5WMoFy7lgrButeN/LWCIQIOdSm//slqb3W28s3cec8?=
 =?us-ascii?Q?DjYmZMuwGu6KYaWBgNHClBGQ1qa5iYN/N8Rx9nMOo7ZXR4PtZOfSnbdFc75q?=
 =?us-ascii?Q?MIeQAC+3uq8DH5WlqO2MNSG8whtEpIAkd7/ZGGAfe6J+KyantGucR5HoO3Bc?=
 =?us-ascii?Q?n+2XcimyFHwPmQH8ARZgG5MyBEVn6hOuApLZXX8alZNgVtlRuO30jfC8HeZC?=
 =?us-ascii?Q?00w3/83wDhagkmB+T5bcR1cyAv11pyQ4Pz6fHnQpZp5x3dr7u7PErViB69sf?=
 =?us-ascii?Q?1SIFH1EbUNZpMaMcx7y1yBnm7GnBDu7icyhKQ5sljtzL6OSc6jrcLGEAsOwc?=
 =?us-ascii?Q?YWLYuT4YNEoEvhzEQrIa+I78keOaWjOuO5045zcW0Ylo+s3jfBka4nCyrmZ+?=
 =?us-ascii?Q?CgNyGU825Tmxz/7EutCgY7wxAMGWzSCEJR1N4m0o5km02bP8fPKhRZfxsdiB?=
 =?us-ascii?Q?lPhcIxyB9DYIgp3+++/YZnTW5ziWGqMgVJAwrSkyUcSOyaFlCkYl9BmBnfVD?=
 =?us-ascii?Q?Ola934mQPol4iApMWgAmWEW+34iP/oqa0NMFqHOShvC4fPHzer/z6b3vjQFj?=
 =?us-ascii?Q?qPhA1Z3MOAtvVjV0WJuSn2p+UECRusF4bh55orlXWLlUMPFc1oBRhxjN7wob?=
 =?us-ascii?Q?VuxdmqSqJlsIKgjpa09yIAvrCJsHmaYWL/1UTXQOd+o86z4GGKk0hX5p+6ZD?=
 =?us-ascii?Q?gxZQVnbO0cH5ifo0/QuIkMnvPZKVa6Pn3bLSzNuwbsqPL1NGGCCwd5W6otcB?=
 =?us-ascii?Q?vPUWlAwtNHtf36RK1+3EBRFW2vTdVH6Oqz4UhhrCE8MTH+ksYzPXuctL9V74?=
 =?us-ascii?Q?YO0aBwKvg97Pn+g+6MgJ4Kf43PC5806vzySfg6pzFCMoCLldvt0yjXBrG5vA?=
 =?us-ascii?Q?2ojf4ttMnaMX9cnHfaIHrmoSr6CfWMJIS1bVn2FV3XbOjs9/5S3uAvdUNW9e?=
 =?us-ascii?Q?hQ53bMx5MxrzKDR6U86JZjwdVGaLScaY5UY+yMJR+a+u2l3FUivmoPiac7cN?=
 =?us-ascii?Q?s9I2AJ5+Z3ZvER4ZTOF/fsz0GAeKhMGCIsA7kC62ow0NzvYUJVa7I6Ndvr7n?=
 =?us-ascii?Q?OvO2dNZh1+ZDS4y9I/ZKra/JWva+eA88nVYIxX+rrZwntoSJJxaTGw+WYjdw?=
 =?us-ascii?Q?REHEFqyLIaotZsuDl7uibKbwyt1IgOyN/LnH0A+O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7c982c-aee9-45b0-65af-08ddb1fc79c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 02:20:08.8830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DaI2Tq6NmMuECc7TNRAzRtGiY/tdejWyLQ/g15A8BUqOW2uqfxbaBdUYZzqCOxJiKWyQsrB6bLmvBUrsB8N00C0j35cZWqecvu8qZCbVR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap(=
)
>
>Hi Zhenzhong,
>
>On 6/20/25 9:17 AM, Zhenzhong Duan wrote:
>> pci_device_get_viommu_cap() call pci_device_get_iommu_bus_devfn()
>> to get iommu_bus->iommu_ops and call get_viommu_cap() callback to
>> get a bitmap with each bit represents a vIOMMU exposed capability.
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/hw/pci/pci.h | 22 ++++++++++++++++++++++
>>  hw/pci/pci.c         | 11 +++++++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index df3cc7b875..829757b2c2 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -453,6 +453,18 @@ typedef struct PCIIOMMUOps {
>>       * @devfn: device and function number of the PCI device.
>>       */
>>      void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>> +    /**
>> +     * @get_viommu_cap: get vIOMMU capabilities
>> +     *
>> +     * Optional callback, if not implemented, then vIOMMU doesn't
>> +     * support exposing capabilities to other subsystem, e.g., VFIO.
>> +     * vIOMMU can choose which capabilities to expose.
>> +     *
>> +     * @opaque: the data passed to pci_setup_iommu().
>> +     *
>> +     * Returns: 64bit bitmap with each bit represents a capability.
>I think we need to clarify what this bitmap contains as capability bits
>(enum type)

Sure, will be like:

     * Returns: 64bit bitmap with each bit represents a capability emulated
     * by VIOMMU_CAP_* in include/hw/iommu.h

enum {
    VIOMMU_CAP_STAGE1 =3D BIT_ULL(0),  /* stage1 page table supported */
};

Thanks
Zhenzhong

