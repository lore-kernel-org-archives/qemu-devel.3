Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D68C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 09:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taAPF-0002L3-RJ; Tue, 21 Jan 2025 04:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1taAPC-0002KO-Qf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 04:18:43 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1taAP9-0008Ua-Vd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 04:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737451121; x=1768987121;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=JBjc5ItbUe87dyXINs7nP5BYLopuEwb9Pk+E+ABHpK0=;
 b=Kop4k5WpAXzr0Sqk6m0w5o9xdjWoN4eVDBwuoTpzWyyBRgwBlN341Gdv
 0wuTlsfQPRFi+YOeD/YQMIOADZy/RL4DcGDZ5+7cTF4ZZvD1pcqeTbrvP
 5SkS91KarAbvXZiv8icSXNbjDl6mvCSHmVm5sDcv1BSl3LBzyiIso5cNI
 8BLHqAF4FZqv+GMIxCSIwI2MbAr5oNSEYUHLkWybbFM+8W9yP0dHa/dp7
 umPeOW1/6f1wBSXcwhARezP2FgMtuFYXHAFK7+jIaME2A8NAkrwV5+wd7
 k3G9tr08Iu3UpyXjm2jfzD8msfIQpH79Txv6c7g/OrofOqcvIdy1+S4wV A==;
X-CSE-ConnectionGUID: yo13epaCQ/yzM8v2rg6DXQ==
X-CSE-MsgGUID: 5gi1l7lVQre28tmW4AD2Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="60325337"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="60325337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 01:18:32 -0800
X-CSE-ConnectionGUID: 7N4TilPhR0qGxZcRG7W3dA==
X-CSE-MsgGUID: XPcOI1g0RLWGSj0PaWWZGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="111733960"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jan 2025 01:18:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 01:18:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 01:18:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 01:18:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS/2VVI76TiGx7lDH+q8RfAzeYyuyjRHqTnCb3yDb+NLLhGckjxcylN/aLrcDN7071MhU4VwxnYRwRb1vAZkStE1Is7xkhPdcJIFjt9KFSHnn3z+aoG/yDuO6fYfPwmLR6HfTVMHhSwBdB597N9B5E5dWd0YEAi+Bm/RNMB9SircL4Tnc9WwQrZE2ojtYM//19t0V3/ka/ujBmZvrK5JGANo1RT+KcXKv3ZcsGZKvKTRJBDsGjI5Y02sAUDuNr0pF8OGt6HtaWcSxDMuwsp954395OvC8q5o57k3XFsCrowv381dupXUno29ErPV+aQ0XnX4pitr9iWj/32WW/cHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GYlsr4UkpFDdnuYuzc62H1eJvUWxD8784UzRpX0UyI=;
 b=skRlDTAGNj+Qc/B4rnyxKroJ9gPAqzceuITNbyb6mA1giKZhfErjBbFErYxjMz9MXyMvxeur5GfI/bg+h6hXZaebIKiYTVOB59kTf43EuVuXxpIJ42NqU74Y9cAWLCLjdmwxhEDKaEgLqb+JJegrB2fQRR5V7qlaZej2HXfn4z55dZ0T7oakKc2LrTleTupqXAWMk6dCvo5TNJSaJSKZRSuoF+DnxSD9+osPRRg86+ek/Ml7pwcZSBC8MVsES3jZw6g56Lnvjf5Oh8aXSBaGfm8XGKQW4T/uxbaEWIgX/S4UrEH2UFWmPoe/8tjVnh2WKCfRE4NT81gcpfrd0s1lJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 09:18:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 09:18:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>
Subject: RE: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Topic: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Index: AQHba2GEeT3q2OY+G0e4DMt12KVy1rMg8zrg
Date: Tue, 21 Jan 2025 09:18:29 +0000
Message-ID: <SJ0PR11MB67445918D03892472C78C2DD92E62@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
In-Reply-To: <20250120173339.865681-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5061:EE_
x-ms-office365-filtering-correlation-id: 4fdabb1e-fd84-49da-c37a-08dd39fc91ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BdA2w21A6TWKZ1tkQeJ3G5oO7R0aR+3ISmsQRjkx60WxATfPHHNFm/ze0I5K?=
 =?us-ascii?Q?+QL7pfjPr1npZA6ErLM0TYuglHtY6og3BPDzzpFNnvlCTEMqU++tLt5F1Ngd?=
 =?us-ascii?Q?bje1FL1wuR9uOaf3SWOY5NazKlH1H/6T7NTGmBJGcC3fLHylskQh6zNx1ixS?=
 =?us-ascii?Q?t/vY5VVYYrxPNL2uRTt6QQXKscduQVEHkYX/QRoPjmLxoXDPizTsCJ/mYp01?=
 =?us-ascii?Q?uk84nr/BrrOHXVE+sMnEUbrtj5o1j4AzwJCIiK6AxAzUbgTfruXxcQKHq+Rk?=
 =?us-ascii?Q?uPz/zTKhJKgYyvSubLbOYjAEhYr6/qZnRktaNUgS+Qz6vNxE7mWTs3hVZ2Yy?=
 =?us-ascii?Q?NkJtskO5Aoihx/DrrwKDa4p6RWe0S5ZkJUPRvt9vWISV1SBF3/Fh00BpKHdd?=
 =?us-ascii?Q?qo0mLJB8nM8vqPUj6kYN1maoLTJaJoPgkwIHyEafzSaS0rGlIRQBPcKRkT60?=
 =?us-ascii?Q?rxVZD7j3wBtVwdUEJ1UujroWjHI0RXnELn0HBWw6DGFhe3vhZmOEeTluRedE?=
 =?us-ascii?Q?N1fSbDiuJbZvUEAioB7ZqRp3+dpO0rWX8pcm+ze2+2kIdFV3ZRbVroS/T6OU?=
 =?us-ascii?Q?RjyvwwXRRsX9M0IaL+K2Chd5X5hPnjiWUGAoKAp5xP8dyIc2gPpyTBUDzFhO?=
 =?us-ascii?Q?Wed/VngtTh4sOF68cJnoTmYktjLs6+GQW7oGCyy753DCVpzpI6r09Ktu1SOB?=
 =?us-ascii?Q?tFuoISnq+EMz0D1MGWlfRPIqn8WPIVaOR9Hsv+5fKalBxdsJlwqAXQDVgteE?=
 =?us-ascii?Q?+aNAphGeLHOdzrezxTOVF7HBqnjo2U8aAiGWt78QHLqH8/alpn5d29TUj1k+?=
 =?us-ascii?Q?wMjTnBrkYS4l13E++JvHE3oWgkMy7lRYVJ8WdMVS9yJmi3IefHR3amfmP42C?=
 =?us-ascii?Q?QJvTqfOK+hLrl737uTdfrAaK1pBUz015p8nmad1pnvhducWQYTca2gfmXEFD?=
 =?us-ascii?Q?jwqpfv234VN5W5hmhTwDxDcSCuNMFGwLEX70Q+p/f2SLmM1p39QeqDMF7qwu?=
 =?us-ascii?Q?AzuJceWPkMiDKMcwBiWqRW00hC2EY9im5zBvEL6wFOCc9NEyhHlQQXvRlsCp?=
 =?us-ascii?Q?zJOtSRjbFQR+1dvdmTRc1c8ryPyey/gK0vWlPJ1G8/sRK4tW/F9fbeX/E3s+?=
 =?us-ascii?Q?OhyVxo/Kjga6cPeiRG6erPaCTm41XnoOJqSFnoAaTXTdltye+ZT5BnJaC0GP?=
 =?us-ascii?Q?E6LJgqfU8Laf0deMm8nMBClZMLkwBRGoQa1oErY41eJ5aHmuzX6XEov/h9I2?=
 =?us-ascii?Q?UW/VZFsIjYc6T7hZhenoAMJB25YpcHnZbwuk4gX72K+U91Ghinrx07j+Xb2I?=
 =?us-ascii?Q?1YRmxSL3V2/xfK4EEfdLjcJ1VgAJ2U3vXYAhelKgRG6Yz5RA9mJJweo+4ztx?=
 =?us-ascii?Q?E5EKlI9yy63JH8dcJsEFkjMqkz8TuW1tXssPHqze0lxULPBlhQiSxvQBmXVC?=
 =?us-ascii?Q?gwr/4H/0K6KL9lxaJxeC7LtJZNNz0Vhu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HPgIU7nQlCJKj89S5cWS8l3xZQMQqeh7vJQujUYZz7TCkeM9LVxE1AuhjlUH?=
 =?us-ascii?Q?UO7/u5BObOxGKYgYQalA2H603XfU5zVm1zc7lLCH7D0/LHb+BRooS6NnbiOV?=
 =?us-ascii?Q?nyv1i60hsPJBc/W0RSRGjFMDBxAMLToTtYNGrFOBGaaAUvAH2ZaTuJNPPuRN?=
 =?us-ascii?Q?wHgR3Wmsck1CIO1SfSYpbTJIdl19BHzd9K4yRLAF3npSvpbtPm80JtgaMDDX?=
 =?us-ascii?Q?mztZZtmKP6WxVNoT7UGMfLW8cyLxq7njg6rbwsW1X3l/YRTfN+Uh/0cKkyRn?=
 =?us-ascii?Q?9wGb6hT5V1mC1Jo0021Bvdz7VYx3PxcrGBUpgFW66z3KnfUVx25r9WIraFVU?=
 =?us-ascii?Q?vR/FuZRcydggC+snSZLorIiPR4zb+YfvprCUL0rUnAVJIGyF+/D14s6w5RtF?=
 =?us-ascii?Q?kY6lbAChhwffy1Og+5NrVOYec7/ucPGnTXGzZHRV0R/UF5Adw6lL7Y5nR2ZM?=
 =?us-ascii?Q?a9YgRnjO5DloJqPxcK3vLfx8jBIjcC05uQq1IxN7epezRBWyN1BaJMJPrXhp?=
 =?us-ascii?Q?v0dVZU/e0m0bFZh4s7ioPdhKHuwUxHjcYSavUBeSjEQKIf1mRsPBXIXyftUg?=
 =?us-ascii?Q?SzwFrxclX8zgnzjVtSemGFpLB4z1FrakWyQrOywB7aM/NZ+O1vxjLL4Z9PC4?=
 =?us-ascii?Q?w8Um8n7uirWRI9sAEb0t+xTeXkjO0E6Nq/yqyZffV+lLjMbNqL+hO0g8/QZ8?=
 =?us-ascii?Q?w4oO/r0XZDe0zFdEhEEFJz0n3jQaUzKDhl68fgSlMtw693q0+5cyHO4S/c+e?=
 =?us-ascii?Q?b6ib9ULuPAjvRNFbOs7rDqho8NEnjeB463NHvtrY3HdKvyNtyVhWW62cbSuY?=
 =?us-ascii?Q?+MMARZMnShWOB9fzELSQqcJiYUXu/Q0v/rVflwOrRSsyq0bo6M+KisuVzKOc?=
 =?us-ascii?Q?HVisTJDdJ4oq4lsfvceRdfJ43/bEVbU3tvdmYbLnjamNgY20IfMyBSSJh97S?=
 =?us-ascii?Q?1EmHlqdM9eP084cRgVc0Lr04uRlhS0OsYOEWumN+amGsZRdc0E+0PB8TyV+n?=
 =?us-ascii?Q?as60vST10DX3cqB69gRZynz+638YE7waN33bZ+dWgSk9CBZBfwzLEunEgmec?=
 =?us-ascii?Q?NGs8cX/g0oE0eco+MntMgiXlGUAyzxKzFAVlnXce76maPXod14ljIWuQ7goy?=
 =?us-ascii?Q?SX1u2VqzXeRw1pu59SYDXy0wbIvqjpMsksVJ9j8a8NvueYtrUJPEIhnPN4tg?=
 =?us-ascii?Q?XR7dEiIEkL06Z7wnJzlBzkv0suVodrdbEIlVEAXUTtCyLWMF88PvUfgpYMIz?=
 =?us-ascii?Q?YtPR294iSOlbk2vjcxNUENRfatSYJ7ocUDQFnlp7VXU+O1DyEh/tR1Z3r+Ty?=
 =?us-ascii?Q?I8KW7zfmmKCi479bibqQ+4V/dWPbU78EG3Evjp3RZ5s1m2vVvkJJJ8QmiEci?=
 =?us-ascii?Q?7RcPCCbTy2AdC3AqSyXQYJ5U2492ErIXOPrRRVJIjjlhrwP2Hy4fBGT7hXPU?=
 =?us-ascii?Q?TvZnTLL0HkArkLtwADwjK8kt6qI23OBBkaQCYnB7k6Oy9f1TBLAIUS3NMC6E?=
 =?us-ascii?Q?R0S+beN6ghNHvu4c27hISZy2cYuFtC/wbZ9uykfoBV4RFKW/1U5B1S+Dtf5/?=
 =?us-ascii?Q?ejj+4O2L0Ukg/x0aiY0d6UaZAoopva30eYXv9mr5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdabb1e-fd84-49da-c37a-08dd39fc91ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 09:18:29.4455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6kvsAiKNjsUQrWnTwRwdnjawwPKOGpT9WokLOjfBR471xmDxcSk6s/DJHVcTDbl8aMbV1wsurtEmGnulk24NJ3Xd7xHOeuJ1ENdtLmCeDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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
>Subject: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
>disabled
>
>When a guest exposed with a vhost device and protected by an
>intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>
>Fail to lookup the translated address ffffe000

Do you see this print once during one time reboot?

>
>We observe that the IOMMU gets disabled through a write to the global
>command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>When this warning happens it can be observed an inflight IOTLB
>miss occurs after the IOMMU disable and before the vhost stop. In
>that case a flat translation occurs and the check in
>vhost_memory_region_lookup() fails.
>
>Let's disable the IOTLB callbacks when all IOMMU MRs have been
>unregistered.

Try to understand the sequence, is it like below?

           vhost                                                     vcpu  =
       =20

call into vtd_iommu_translate();

                                                                    set s->=
dmar_enabled =3D false;
                                                                    switch =
off iommu address space;
                                                                    disable=
 vhost IOTLB callbacks;

check if !s->dmar_enabled;
return flat translation and trigger warning

Thanks
Zhenzhong

>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/virtio/vhost.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 6aa72fd434..128c2ab094 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener
>*listener,
>             break;
>         }
>     }
>+    if (QLIST_EMPTY(&dev->iommu_list) &&
>+        dev->vhost_ops->vhost_set_iotlb_callback) {
>+        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>+    }
> }
>
> void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>--
>2.47.1


