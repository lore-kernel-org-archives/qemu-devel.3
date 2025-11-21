Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366D9CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjS-0000Jc-4I; Fri, 21 Nov 2025 20:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMbOt-0003tm-2l; Fri, 21 Nov 2025 19:22:51 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMbOf-0002Fq-3d; Fri, 21 Nov 2025 19:22:44 -0500
Received: from DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) by
 LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 21:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEspc2F6sxp6E05biqt4bMvoGk9k3h4SY1Ln9ZZyw4mUgGcFCfCwTSRFukiYQjD7slcZfxzyvT+KxUsa2wcK0isLBFwUQkgYMXaNESyoxCL0s4GRJab3uNhQUQw7sxC/BqfPU+tbJGDXZ4IcaxfznrNo4zJdvd+2OKeVhFUgBkTRJ+Uh54a4rFezDUuBakWgdrdUyaIYyAvrtIOLQ62iEuikzy6+5XL0FpY8rMfszb/ruYX0liU7vvYs6YEP/3RWJfNtT20Y1l9S40asILHuvv4O4dJg7gvooUh9N+hVe7NmIDkLjoB9J5rWHYFvHXVHNLnP4eoZzy39SReV6iyWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Bm0+S8we1K4yQNsLCVCZ26X6ISMJBMWVtGUuGZMO6w=;
 b=cC7MH6/CYUG47TzOYfD9TFRVfnTvyPpPWQ2wC3hmaqX3os0yiVvh1Dr+KDxL7f1eGmB+tCPpt03eg8FE6f2gWi7hSGG2T1bERKlwrNqP4n1M13AgaSaFILymhkU/wfWdz7Eswc7GgQ0ukisWghoQwQVh3l3ifnNoAS/MSatCeZ2b+HTqCzZhAzobZf5KbpMdcGSrtYQlbNqiClisW21mraxnXRJsNY9PTxJsrTWz75jmZyfnMyjNQyOcIeVfE95Qdfz9CbgCQXtWLHjtTjPse+vhjAm1cYuQ1+8cCKWdNzGZ9aQ6uJFzbtM0dpSMjZAExqt6CTtV0XIDu8o6hgA1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Bm0+S8we1K4yQNsLCVCZ26X6ISMJBMWVtGUuGZMO6w=;
 b=YfhdgFNE/KlFvxZk3aX4UnrQxl+QeWqsX5Jovq3kNGn7Uvh1CKGMNL+U282BMYCm1ZZLB3ViINRwWEZa59T3Wmgcpg0oWSQPWB15RVPei5R/rK8sujXRtbKv8mcCRz3cWwub9UoVxXesihLn+PSbQXB7OPpkmgMyLzbhXD5WtBtSWzYopXfRI0p6IBLo5sMzy/VGjYm+nrgovu+7kbg1pI4DonSR5QViW67Og7H8yJxt9pnwA40z7S6R9Jz0uZMVrE5X/YDgzyNGAn2m/t8+xfBigrf4pHvwXfFC8+foxw0T2Jk2q8/cYB7ym3qojfCzGv2gSpAK2NMdIxMJt/fR8w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Fri, 21 Nov 2025 10:38:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:38:06 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Thread-Topic: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Thread-Index: AQHcWiFC5ZutjosMpE+DcYfPDxJ0SbT8CpYAgADj5VA=
Date: Fri, 21 Nov 2025 10:38:06 +0000
Message-ID: <CH3PR12MB754864DAE416B1EE5C1DFFC7ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-9-skolothumtho@nvidia.com>
 <aR9/SMia+iganQ2r@Asurada-Nvidia>
In-Reply-To: <aR9/SMia+iganQ2r@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS7PR12MB6336:EE_|LV3PR12MB9143:EE_
x-ms-office365-filtering-correlation-id: 04e16972-1cde-4c64-fe19-08de28ea0e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ICWBMF4jvOfDJW4fNgPUgJzHDP5igMiFpo/INfgyIvTGPYrvVkEnyRR07yBc?=
 =?us-ascii?Q?ekELhv/PpYAEnNesAT5Xb6wJDhAFubXSQrAMPnnbF6qTDeEjLyHI80T4J6Jz?=
 =?us-ascii?Q?KSmhxhIFmMRValTmtrREANiXxRjCjPOKxgNdrNdlK3kNGvUbxc6xp+TDeH1T?=
 =?us-ascii?Q?91uvDNLjtY+crwALRiMXyvrVCgmeFumjv6z4TMMZRp16qHgOR71VsMNdvOKQ?=
 =?us-ascii?Q?9RLZm0YaNTEPvRL3AF4WQNLB+7WS5XBTgZw+oz4+kn9GdH+KmCTF02C15te6?=
 =?us-ascii?Q?lBXINDjcq77UtNVq6RjDy/H1DIgpmE6BNYjFZdDN8G2MlDcdRbY2ilFLlyyW?=
 =?us-ascii?Q?q5BOpqA0PT1277LaWBhEQQpcGhVpiMAHFmPgDw0rYC++U06XwznT9pK5HHFY?=
 =?us-ascii?Q?/CuTxpNhWc2MCMs/OQZlYKHXIiB3yoYAlU36qKyTz9SK8Sk/A5sWczCmD24N?=
 =?us-ascii?Q?QZ0SRnJe8QzJve71AIO6klgmBTEWXECnyNB2qLWN7WweAxcgmk9nQANVaOvP?=
 =?us-ascii?Q?kho/pcj/I7AXE6E1xFSCOEfHOKqkwtIGjQrB1PtiG9FKXg12E0C5RZjG4/tT?=
 =?us-ascii?Q?2RucbPWjyaUPkHad8KrkxUZNUD9/bxUVG6PhxAyNup2udNWLgtMa2WC5VKbF?=
 =?us-ascii?Q?Gr9gDmtXzopxaLyg9TEUtBB93aL8tUsY1weMi6UdJSTvLUY5wedaLa8lfTwF?=
 =?us-ascii?Q?MaSBeCagGWSlzWT2v9V1JLDLnLzAs6GPO1+BvDVdGWlQ12u4fSIqXGzhQevl?=
 =?us-ascii?Q?M4esheuoa65k/HDD3/zVWo5l5oNjJHErf9KJOjjZl79UQlhU3RRUbQ+yEQ9O?=
 =?us-ascii?Q?TBOOIrRWh59Helm6UjhI9BAZhNUHK2PyDb4LbjIrHcBQ/BPO8jN6BLhM4dBr?=
 =?us-ascii?Q?81VjHtGT6r44GmSkXVRf9RNOkmsrWqPZzR1G19OxNmlYM6L+g5SdsSHg3+ZG?=
 =?us-ascii?Q?RH8jGk5bT1k+daK1wrtpxuQYjU3CkuS7R1tHWtolHUGP7yTkHrpEC25TSd3q?=
 =?us-ascii?Q?H249tr4PWBjlIEvxYGnyyWxU63q3/n8KnEUn/XzQlwckLvpMhs9vRs6vPgO7?=
 =?us-ascii?Q?lRwIFOaPHgytTg+gIdEs8JWllfOqOhZZP4wxt+idhOA04zO+cl+zgraaab0X?=
 =?us-ascii?Q?tb+GQgjV2syCaNqIQLW55ABihZxqifwBLHjPPS0dl6Lwt6/d8SNEkMUZoKr+?=
 =?us-ascii?Q?oeN1vEFK9BoLadG1ruLDHokHBS78/GemtxzS+qToGroPqVuBVzq7KByRNevD?=
 =?us-ascii?Q?58yAZheSIIdh8BER/wVYV5tj26q5tD1NnTpeNGRHIpMp6j4Jgsqr4OJyKDi4?=
 =?us-ascii?Q?BrPXiimLGjS91OSrQkp6MqV6+Hvwj+DHibiWof0113JmGz/qDYoIVo581CGq?=
 =?us-ascii?Q?SocSoiyuZ2+FFbO8Uqfk9vdcKgHiSGV0VsH8qeuUaDN/ngGuMn4Zcb6vFlXb?=
 =?us-ascii?Q?WtTI6xeNRIJSdSb/G+QJc+YV27SPAHkNp0QHZWQuJx5LJ8aoxhkELVENGYWo?=
 =?us-ascii?Q?hg9TZuSGXa5WoxFeASPp4J/IfWijukc8MnEU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yxLy0sy7DbR0w+Zj7INdjF/pVi6aGPMdnqasdQ6hLTPJjrwy9if9PLU0DSMV?=
 =?us-ascii?Q?1Mzb72nXdKfmqOLZiwrh9kaDmql7Ktdqu2FYwdba6f+lDgn3jYvfu74BX9t8?=
 =?us-ascii?Q?6K/Wipu8V+JIKLIJwPyrWxkLnsEo1sXZRvvUvOklY+tF6Qc0HKVO1Dx1v6d9?=
 =?us-ascii?Q?jV/zx9EmzYtYEC+ujEZC4RpXFwKlDm4wfynoAsj3FMihUBGZ+jb5g/OKHtxB?=
 =?us-ascii?Q?J32+91IpN5x0uJDwgd3fBnCrogGqrCNNZKY26bvFBZlxffFn/sR1UB/9vYqK?=
 =?us-ascii?Q?k+Jg3g49sKBk1Pf+cZwxhm77vhSMOfxNf7dvg8bOI4X9nIVSl2XuHnRHZ8F1?=
 =?us-ascii?Q?4PLFBqca/ptg7d2pBnquzNLF40VASqA1rJm29knISQR2WxlPcfagoUg2lEmq?=
 =?us-ascii?Q?B0L6VilqF5HbvHbzHB+KhHwxc+7LYo/hl963FApPOngbIqXiQhnGMMFoM7zd?=
 =?us-ascii?Q?TXLgQWmY4rwd9ruSqd7bd4+v81LgQZZAKLZh08P1xSoaQdtRBP9ZuxgeQ7M7?=
 =?us-ascii?Q?awcf9hSoL11NnmJSMtCDr9Yt43hk904BXM+qg1vEWmYJHw3wGvJGISNHR+RP?=
 =?us-ascii?Q?fh6cgCb4A7x9b0lKx31feZxzpg1sHfEeZroMsmZlq5XLMpKZbZNHlztApbv7?=
 =?us-ascii?Q?jXGD4peTLAbBct+Myl8lmyQkpu6yBdxRdaf+nHI1+5srktO9phVE60M489F3?=
 =?us-ascii?Q?rJCsHocFAt82QuDzLQ6KBAPCdf/XLin6SF9OeDuOFzSI+zAvjDvmea1FhY0j?=
 =?us-ascii?Q?3PCqK91DaJBPNISxnwdh5I0GvNSsAMc/maXuxbxSXKNDiOPrNmS3Fe++orbs?=
 =?us-ascii?Q?UOxwcpjgx6gvf+Pi9iaMLR+Ieatzg90YzKeuakHAstT80CezOyRgxF7Uj0PK?=
 =?us-ascii?Q?NFrTip6qAZJuMck4Fd607N941bT9Uv6aaYmUkHRg1/rTzr0yPGQsDpeyzEBh?=
 =?us-ascii?Q?ifFq9q9il7Y1tFMwsxpvkXomVhl5xnwZ3mCt6cMoZiSGXGbSTePFF8lPs4Xv?=
 =?us-ascii?Q?vVcxkMLmvrcZhBRFaJPCvnx5Gwq/K4zrZGpUZQcTqu9d2F3aScFbMZp+p66n?=
 =?us-ascii?Q?RFixrbZZCUI0Umg6aiaeAAqJimTSNISBDGvBU+bsfczA0JMVX82OCLVQKaM4?=
 =?us-ascii?Q?GZ8+c9/lr6RYwL4QY0WSBPXRJt3szLZt97w4/M7xS4PzxYihQiLKq6vkyCIp?=
 =?us-ascii?Q?B4jmLAc/4EayMYwyi/BZ/LTf8GN2KEJC6Oah8lcHz7BsgIXfHVuEw0BsewMA?=
 =?us-ascii?Q?NuD6TuaMfoXcDQorE3JGIQj/HzK+ipW4mVqEqlukHzzRJrK0YgVzqUJrWDnC?=
 =?us-ascii?Q?sheylJknydFaRNfMet/2Q77y2RfgXOK65mPWBnZ55k/v/VTmNehFdDPzsxMy?=
 =?us-ascii?Q?KNYzi97RveVpUuR36CVx8g65qxFJFhiM8U/OJZOAkFMN0PsGMs0SBt/xwDjv?=
 =?us-ascii?Q?NAeu/SWnKtYh9JmWwC+teiySwbZLUtH7W8ObagUd0YFfXKBt4vuM1RnMR8Aa?=
 =?us-ascii?Q?fxVyrJOk9q+pV86yLyaCfrsSZ0PlFrQflIHNB5BVw2gOfy45XBNQF/50LAu6?=
 =?us-ascii?Q?Z1Xry8W23hPUbI8APhSKm2wAvPMxrQc/0e4RGFTF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e16972-1cde-4c64-fe19-08de28ea0e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 10:38:06.5163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUaBMEIPLfaIwWxOdvg/Xw0aATbu4KdaG3WCm7RjJMzjGxmBIa2/C1LQq/e4S/ihyJ4lIvw63ZAnlgYpdSub6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
X-OriginatorOrg: Nvidia.com
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 20 November 2025 20:51
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
> Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
> supports_address_space() callback
>=20
> On Thu, Nov 20, 2025 at 01:21:48PM +0000, Shameer Kolothum wrote:
> > Introduce an optional supports_address_space() callback in PCIIOMMUOps
> to
>=20
> "supports_address_space" sounds a bit to wide to me than its
> indication to supporting an IOMMU address space specifically,
> since the "system address space" being used in this series is
> a legit address space as well.
>=20
> With that being said, I think we are fine for now, given the
> API docs has clarified it. If someone shares the same concern,
> we can rename it later.

The intent here is just to let the vIOMMU decide whether a device should
be associated with its address_space before we call get_address_space().
If the check passes, the vIOMMU must provide the actual address_space
through get_address_space() callback.

Sure. Open to suggestion here.

Thanks,
Shameer

