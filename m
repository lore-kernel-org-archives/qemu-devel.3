Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC15DC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs8S-0006Ef-M6; Mon, 10 Jun 2024 23:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs8K-0006A6-8I; Mon, 10 Jun 2024 23:25:17 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs8E-0007Fb-HS; Mon, 10 Jun 2024 23:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718076310; x=1749612310;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uf6n2MZI8IVEGV0xAUGx9/I5VwMObQ71sJBfqJChFuo=;
 b=DrVyAh+R4PCWQWbY56zhOQ08/Mr5zQS06GaM++GiPtHzNfUnTyC77xIl
 hzm50nzXBHHP3687QKr9KEU6JqEYtKmVZ+BeOltiZ0GGegYo5y/lBfncD
 /sPEschGD2DDDCoOG4AekEqX4/d6F+myHd57hgoVRcwWi+j5LkPL33Xsi
 og5/H3m16LmbZ0DkBRj6PfHwO/JGFQW+qFOyDPLOGQEwgPISoI0BfMerk
 nWB5RdN4WVjuT1BQkdwHFCLdiz3DjHFXs5hTawLYO3avOZXqpV2LRVL+/
 RYXL2m7spzXHWoO0RMKcJlrNgMvZv8dO4MP8lZ1Ndhnky9naehCXdnzxU g==;
X-CSE-ConnectionGUID: 0lBA20UzSFmXEatHyOIIgA==
X-CSE-MsgGUID: hMPGsEOJTmClU+i0n2i3kA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14891256"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="14891256"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 20:25:08 -0700
X-CSE-ConnectionGUID: AnZrlQB9ROqVrl1vTpntWg==
X-CSE-MsgGUID: /llgNYjmSQ2PmOzKMkFeog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39217838"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 20:25:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:25:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:25:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 20:25:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 20:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZOg0kzDubJKOjW+g+u7p4v35QfYQKvrAr+UvDOjP7g/p7sZUS2sK5UL7tKUgxJ3CcHNurTUPPsEr6LsTs/J8KxP/PXRbY4nNqp3uLrR0FhYn+sdDRHsd6TyqMi23XcWf9+9hV8kHeTsmB8Jo6PhqtZIY4k7vxu2B5WIy7Z8Zu2lcHpMd6kTcm55Wwdi9C/zo1PJTo8S+Wgm47vXHj+f6TlBsE1kJRJ4Kgb0Anm07p6Eg2XhX6qqONqsxjUxa7I7S+9yjx9Baj5B79O3RRV7PwmUYT6vtsKjf9hmjkfQmN+HKLrbBNet0e8X7FXowV4KNAHlp5XJZDZ3viXMwJBBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVAEIdlYFlvV4/9qq1B7BH4AGB4JKzdH3PNfIgkFqZ8=;
 b=CBFiDtDBRZRJzc5CAGNJEuF8OSF+Mf/VjbszAaHfggFEsE3kRRiW1DjpNfv3HdMyYGVziy8pds0FZZAEAKatSl3xDLJMU7K8+zEGvl7fJOSQbJ3CLukHvaiIusAhWlGPwvwhAoAXO9UPBR4iIy0mwaS++9YORrpIfK72/QT7CDxlEIy6o4dcVABVV0TS62Dmom6dAvSzNKalarn3lcNVkfZ569GLQfAhFAmKK+P/5f85fYRF0rRIfPftMNjN2kuNV18jZRCzueNOuues1hRYGgg4u5+kXHHS8qT02+WrrKAfhHL39Wh7eyLI7Su8BVttAUWoJ1YOp2JiJh3SrPf+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:25:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:25:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
Thread-Topic: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
Thread-Index: AQHauOiYnfHCpfKY3EO+0RQTvgcaNrHB6Jrg
Date: Tue, 11 Jun 2024 03:25:05 +0000
Message-ID: <SJ0PR11MB674461B49A34599D0166D74E92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-5-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-5-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: c3360ccf-daaf-493d-a90c-08dc89c6169c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/f/RNnR1Ip2RDmGW0N0nLuC9GAKjj1v5hkpsGsg1VuU55iRBAOmXmUDbUpuc?=
 =?us-ascii?Q?kWKJCbjik1AM8gxg1ZvlRdFfSazTQgZVQT+eeNrBPMA6K4CX0L/SacYHLto3?=
 =?us-ascii?Q?1QJTEZLFzf15KRMnxq00dgEcP+W84zu2pZoO9rJbRw8Oi4oxuC/RsX9t4IAA?=
 =?us-ascii?Q?VbcKSLo4ueL944n+jsAArz+rVyNLqK1iRbJUZt+NpbUprjjOPctomaF598ol?=
 =?us-ascii?Q?0QCK/4/F40h/sEyHrGWK5PE4ofEzb9aNCzxDrsvHE6Z4lc9LGoHCSroegz1w?=
 =?us-ascii?Q?ksjUV0UBELPkF4NJdmdWem4KJuJPYq8k5IiBe8Gh+96osWEgX/qodHe+5Tqg?=
 =?us-ascii?Q?OQdPvRwe+3Ue9RLA0f2HWXRQEU4E2w6AvkoSy6D/dM8vehEGH7RMpw+s/xhW?=
 =?us-ascii?Q?63ud36E4cBeEx9zp/eVaUZLShQMipSiZnw+fZy5Nh2Lfpo7dsFa922YKlt89?=
 =?us-ascii?Q?C1GY59y3fVwwaMvBnSzh8+wuvzsUp7IqScJzOO2KQQRJpn3/7Z6hAnAMu0e6?=
 =?us-ascii?Q?IMfK8GAmrM+XHS+YHEoAMpUz0dBdMLSA7TLB1SN9tPc5ssG1DQ92niLbWay6?=
 =?us-ascii?Q?hRJsjMpcnXeiKwpspFsuVcv1NvTAsm8ZmVP7UWbGyMgAM6kTnFCJF/MrA4nb?=
 =?us-ascii?Q?bjF+a4tzdC5zUWL5f647AHfbth97CrJUxobpIRvoRboWKrtmOwErZiUAAOoX?=
 =?us-ascii?Q?vCgICaM7RbSz9t1uvPoho/0mTNAPMuBJdc7bHyagEVhBM9fGt37GNgLsEDAl?=
 =?us-ascii?Q?93bMsP5nNWlF9JB6iktO/rHNxxrlvJw31kHm0uDmYw0YbjLbb7ejWkpVndvS?=
 =?us-ascii?Q?DDndGfzQCN+hUl5yrZkqMPIqnGnlKuNSPjNrdQ0kaxccidGqyf2FgfTxB5FP?=
 =?us-ascii?Q?enmUUEM3z+M+VFNtOZDEDWM5cb8lBepOv2Nwwd3Gb0eBrOFUUBc8wG8r1SuD?=
 =?us-ascii?Q?b6hVnxau8YTwWX3e7OXErvvze9cceumRpFs5kIdjoZwjwdVdp+b5UOfs2A/o?=
 =?us-ascii?Q?9cppgPdcC3g1lA/ma6ZUdZwGyVlh8cb5zpNtV/6Mc3x5d0cZcfJjCqJaWBS/?=
 =?us-ascii?Q?+ncTfV9s33XQ8ErELzZKI8AWEjjstGi0shZbWwQ0QtY3h9KGvo8rtC2GLYgP?=
 =?us-ascii?Q?PkHKM85q5kRYiF6hLBYGN+gCZ/ZY4T4FTkqHzFbPOlUA/FbewnSfLPOvnRVo?=
 =?us-ascii?Q?hZgIrYruOk2Uu4VExYPu79k39WDeBtJnE5YFquvOIkM9n+M8SOUFxdbTDqjy?=
 =?us-ascii?Q?PrQLpUdJBwmJ8GFx/ctC3+evb/q7dF6Avdvub92wuYwKt0zSjg7Bz350HE6I?=
 =?us-ascii?Q?O8W0UzcbDMlDvFOYTBLQhZgl4uXFXKJvrThBMKREo9uGJ3fCJOGVI2iJGtPW?=
 =?us-ascii?Q?YTjxauPFLCq/V80LAliWhxam7Wwo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c48mSk66CdB5JoA+yA1f17TFIbkcyoqAp4+ie4h/SCpwMaeaOGfnT7TAuLTf?=
 =?us-ascii?Q?NVQWrrO2nH4W8j/HFS25CE5Zh0pF4nYEzMMj8nE8DFFX4Wn4JXef+31kp1Y9?=
 =?us-ascii?Q?La57puQSJVFogXjmlY7EAoDkQErMr4uoSpyg+TPQBmHZB3MB+dEB1zQu+tCQ?=
 =?us-ascii?Q?7cqjHWqmJ/8iIyPWgtfQl/pmCRb2+ue2+A5DWyrHjtgYpomiddZbr0DhqMyK?=
 =?us-ascii?Q?ICXUC7jp9Kd/N0V2KkMz5hjolyCU2h4TKvdsOADF5L/xifrNAPtwZ/Z1nvDH?=
 =?us-ascii?Q?7fZtdN/TrBnVL8Rl22TNpwjqcuAYdj8sfSnO1r+UgfCJMVyqgVSK0A5MjpQF?=
 =?us-ascii?Q?iMBJFy0YHsRK7ICMjbdRA8Ay/9lzl0VrkxSWQfZQyMLR1s/v31NfT/74uCMW?=
 =?us-ascii?Q?xhRPTUV4JvpxSh2c3eJc9WsFpowYdIPG//H1b5t8eW7bxUlykY1nAstoWo3X?=
 =?us-ascii?Q?aExh7uvnc3QrNnLva0cUgN3szU5Qoz+Sc6F3GKC1Dy8y0mOw09q91GHv6zAs?=
 =?us-ascii?Q?Ke78kShl+BgBZvfIvrUY+0PBH3ALdLr6PfgwoHkkdf4rEjYHWS16dylF4tQq?=
 =?us-ascii?Q?Qa9c3/EuzyjRyPYhmhuol9u+OkY5wEK6XoSj9J2WiZJF1AwSyxs8NE6FTAdK?=
 =?us-ascii?Q?2Ot0rqi6iK/9RY6+tio/+Ji/Di0l8VrDLkYZTxVXJR8yyOJLGOEULC1ncPKP?=
 =?us-ascii?Q?X+4z+ajYCqTVpk/pJ+v1pGECZeyE9CPUELhDxmljOM5+AgUMdbqqEpRE0Syo?=
 =?us-ascii?Q?nE30wzBE6mXxYyuzRNWZzy/+rzTBBJahD5oKR/vV0tyX1FNwdTkPvGGhs2eF?=
 =?us-ascii?Q?L5/3d8MJrCog8IJw7IroAyffgTni3g3E0jivFgTrlD1/YBvM8pYLmIO7rX/Y?=
 =?us-ascii?Q?c7CJg6DhRSehvggs6Wn1pEnbI0w94seANHOHA6IsvBOiQ/+YpVmCCej0KLvb?=
 =?us-ascii?Q?Cw+PFz210IDq8qo5h6OBUu5KKv0s6f/WCLH147cJ11vwH+hTQpLYLYyAeoPV?=
 =?us-ascii?Q?ZE94zNqffOXXIeBppcrHw+8cUR+9goPGFkpN2V1D81IZrHYI49sSBX3tpIIK?=
 =?us-ascii?Q?vbHO71NSqJGSM064ZuWbx6G7+BTLF3k3/qFYGDUKnnoAfCCeFl8UfeT7iqXv?=
 =?us-ascii?Q?6HdD5aoYSUTcfiw4V4RNfbGRNdZ/LksyZYd+Cd7WTQx25Cep6wkB1q5a7dVW?=
 =?us-ascii?Q?5rv733PWc7CsPytNLOpJ5SNa7mV1Ptyq6KpCVPfe1DwvJ024DJjz1KKbmbdg?=
 =?us-ascii?Q?Uh9hULelR7BXh6EWLMGImex4nlcTJEV9KCxUYIHJNGkAvKETdXQahjJh3RMf?=
 =?us-ascii?Q?akf18A2sMN2Ka8+a60plzSlVcM3/czmhGjCw9pYd1VTPeNbGLkqkjD5XJgQR?=
 =?us-ascii?Q?cpdQFuBb8pOsg6stjH6jDulSpvFYTE/iHulA1mFyihh1G+koIDV0EFCtXm3k?=
 =?us-ascii?Q?h6xuW8CgIEKzvv8lOn2uB3VKA3KQRE7iNiKODIYoPVKa+y/kDrWjpHMV8eor?=
 =?us-ascii?Q?xoVkNKpyNdX+vR5MRsczdv+qJjwBsDedls13bYN97OYOXOFvTAW62V10Ucpp?=
 =?us-ascii?Q?UsYSC55Hv4DPUVyCdVIccW9zCwmDDSeqfMwd8ife?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3360ccf-daaf-493d-a90c-08dc89c6169c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:25:05.5374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mAxYPfRw9GXXLdkeHqW+YViA9IuIYG8Q4Jqef1PqBHCzgP7yN1G24Gt7g3SOYOMis1R7E3nr3mRA0mZy9ItA6Cri5hBAK3i5syxQDtqUE9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC v2 4/7] virtio-iommu: Compute host reserved regions
>
>Compute the host reserved regions in virtio_iommu_set_iommu_device().
>The usable IOVA regions are retrieved from the HOSTIOMMUDevice.
>The virtio_iommu_set_host_iova_ranges() helper turns usable regions
>into complementary reserved regions while testing the inclusion
>into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
>implementation of virtio_iommu_set_iova_ranges() which will be=09
>removed in subsequent patches. rebuild_resv_regions() is just moved.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/virtio/virtio-iommu.c | 151 ++++++++++++++++++++++++++++++--------
>-
> 1 file changed, 117 insertions(+), 34 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 0680a357f0..33e9682b83 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -494,12 +494,114 @@ get_host_iommu_device(VirtIOIOMMU
>*viommu, PCIBus *bus, int devfn) {
>     return g_hash_table_lookup(viommu->host_iommu_devices, &key);
> }
>
>+/**
>+ * rebuild_resv_regions: rebuild resv regions with both the
>+ * info of host resv ranges and property set resv ranges
>+ */
>+static int rebuild_resv_regions(IOMMUDevice *sdev)
>+{
>+    GList *l;
>+    int i =3D 0;
>+
>+    /* free the existing list and rebuild it from scratch */
>+    g_list_free_full(sdev->resv_regions, g_free);
>+    sdev->resv_regions =3D NULL;
>+
>+    /* First add host reserved regions if any, all tagged as RESERVED */
>+    for (l =3D sdev->host_resv_ranges; l; l =3D l->next) {
>+        ReservedRegion *reg =3D g_new0(ReservedRegion, 1);
>+        Range *r =3D (Range *)l->data;
>+
>+        reg->type =3D VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>+        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>+        sdev->resv_regions =3D resv_region_list_insert(sdev->resv_regions=
, reg);
>+        trace_virtio_iommu_host_resv_regions(sdev-
>>iommu_mr.parent_obj.name, i,
>+                                             range_lob(&reg->range),
>+                                             range_upb(&reg->range));
>+        i++;
>+    }
>+    /*
>+     * then add higher priority reserved regions set by the machine
>+     * through properties
>+     */
>+    add_prop_resv_regions(sdev);
>+    return 0;
>+}
>+
>+static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus
>*bus,
>+                                             int devfn, GList *iova_range=
s,
>+                                             Error **errp)
>+{
>+    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);
>+    IOMMUDevice *sdev;
>+    GList *current_ranges;
>+    GList *l, *tmp, *new_ranges =3D NULL;
>+    int ret =3D -EINVAL;
>+
>+    if (!sbus) {
>+        error_report("%s no sbus", __func__);
>+    }
>+
>+    sdev =3D sbus->pbdev[devfn];
>+
>+    current_ranges =3D sdev->host_resv_ranges;
>+
>+    if (sdev->probe_done) {

Will this still happen with new interface?

>+        error_setg(errp,
>+                   "%s: Notified about new host reserved regions after pr=
obe",
>+                   __func__);
>+        goto out;
>+    }
>+
>+    /* check that each new resv region is included in an existing one */
>+    if (sdev->host_resv_ranges) {

Same here.

>+        range_inverse_array(iova_ranges,
>+                            &new_ranges,
>+                            0, UINT64_MAX);
>+
>+        for (tmp =3D new_ranges; tmp; tmp =3D tmp->next) {
>+            Range *newr =3D (Range *)tmp->data;
>+            bool included =3D false;
>+
>+            for (l =3D current_ranges; l; l =3D l->next) {
>+                Range * r =3D (Range *)l->data;
>+
>+                if (range_contains_range(r, newr)) {
>+                    included =3D true;
>+                    break;
>+                }
>+            }
>+            if (!included) {
>+                goto error;
>+            }
>+        }
>+        /* all new reserved ranges are included in existing ones */
>+        ret =3D 0;
>+        goto out;
>+    }
>+
>+    range_inverse_array(iova_ranges,
>+                        &sdev->host_resv_ranges,
>+                        0, UINT64_MAX);
>+    rebuild_resv_regions(sdev);
>+
>+    return 0;
>+error:
>+    error_setg(errp, "%s Conflicting host reserved ranges set!",
>+               __func__);
>+out:
>+    g_list_free_full(new_ranges, g_free);
>+    return ret;
>+}
>+
> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>int devfn,
>                                           HostIOMMUDevice *hiod, Error **=
errp)
> {
>     VirtIOIOMMU *viommu =3D opaque;
>     VirtioHostIOMMUDevice *vhiod;
>+    HostIOMMUDeviceClass *hiodc =3D
>HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>     struct hiod_key *new_key;
>+    GList *host_iova_ranges =3D NULL;

g_autoptr(GList)?

Thanks
Zhenzhong

>
>     assert(hiod);
>
>@@ -509,6 +611,20 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>         return false;
>     }
>
>+    if (hiodc->get_iova_ranges) {
>+        int ret;
>+        host_iova_ranges =3D hiodc->get_iova_ranges(hiod, errp);
>+        if (!host_iova_ranges) {
>+            return true; /* some old kernels may not support that capabil=
ity */
>+        }
>+        ret =3D virtio_iommu_set_host_iova_ranges(viommu, bus, devfn,
>+                                                host_iova_ranges, errp);
>+        if (ret) {
>+            g_list_free_full(host_iova_ranges, g_free);
>+            return false;
>+        }
>+    }
>+
>     vhiod =3D g_malloc0(sizeof(VirtioHostIOMMUDevice));
>     vhiod->bus =3D bus;
>     vhiod->devfn =3D (uint8_t)devfn;
>@@ -521,6 +637,7 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>
>     object_ref(hiod);
>     g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>+    g_list_free_full(host_iova_ranges, g_free);
>
>     return true;
> }
>@@ -1243,40 +1360,6 @@ static int
>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>     return 0;
> }
>
>-/**
>- * rebuild_resv_regions: rebuild resv regions with both the
>- * info of host resv ranges and property set resv ranges
>- */
>-static int rebuild_resv_regions(IOMMUDevice *sdev)
>-{
>-    GList *l;
>-    int i =3D 0;
>-
>-    /* free the existing list and rebuild it from scratch */
>-    g_list_free_full(sdev->resv_regions, g_free);
>-    sdev->resv_regions =3D NULL;
>-
>-    /* First add host reserved regions if any, all tagged as RESERVED */
>-    for (l =3D sdev->host_resv_ranges; l; l =3D l->next) {
>-        ReservedRegion *reg =3D g_new0(ReservedRegion, 1);
>-        Range *r =3D (Range *)l->data;
>-
>-        reg->type =3D VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>-        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>-        sdev->resv_regions =3D resv_region_list_insert(sdev->resv_regions=
, reg);
>-        trace_virtio_iommu_host_resv_regions(sdev-
>>iommu_mr.parent_obj.name, i,
>-                                             range_lob(&reg->range),
>-                                             range_upb(&reg->range));
>-        i++;
>-    }
>-    /*
>-     * then add higher priority reserved regions set by the machine
>-     * through properties
>-     */
>-    add_prop_resv_regions(sdev);
>-    return 0;
>-}
>-
> /**
>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>  *
>--
>2.41.0


