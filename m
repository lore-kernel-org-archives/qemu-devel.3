Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD8AC27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 02:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGrP2-0006ul-AG; Mon, 10 Jun 2024 22:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGrP0-0006uR-O2; Mon, 10 Jun 2024 22:38:26 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGrOy-0007A7-Je; Mon, 10 Jun 2024 22:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718073504; x=1749609504;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZeRex4t6DFvNQ/6hMTnPKydpy+Sw7acf5cfZPAcAY3c=;
 b=b9Ftio0N5NC/2siXAg5JJzBDxd/rY8MaQXQ/eB9FygqFcWYhblzjkKH5
 iNkJ8QiFiJFgkgD/zp7/cTUDviPKCJBdmuUYIAEmzE43uL+WLMmGZfsjc
 3i76y8vsm7R6qrKdbxIyNh2ljDl51Ald3JYuuMRsNGYbviy4crxzJ9YEM
 e9vl5/8ezDX6yJYcHQCEy2RSu/+qFURkXCr9hgy5J6p2dTQ3OKUYLOyUf
 qloJ1spLMxPgGlfjb7Z3jUIrgMccyIZc3Szd1OLV67RT0BrsTduRs+zie
 zuaIHSa3GHhrHo+VJy1CadnPw0g2TP+bO0D2yDppLq/g0sfljgfiWbxWo A==;
X-CSE-ConnectionGUID: VcoPw+nRSfSlRSa7Jcc7rQ==
X-CSE-MsgGUID: MbDiQSx+SXK1XEN17RFHIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14598432"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="14598432"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 19:38:20 -0700
X-CSE-ConnectionGUID: CF6a4+ldRp+vCjnxdshXMQ==
X-CSE-MsgGUID: bot0mPpORLe+v4s003gOhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="43678817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 19:38:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 19:38:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 19:38:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 19:38:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPJFQIabMLqm5T/y50vYlswxX/E5mNbYJo3GTHFKsO44tg0sUIHGJ2r1eSWm06o2leMR2FMjc4iwwkvY/ePHu4QCbCGNhhbADwG+i6dS0LMcG/TaihyJtoOAyEhYqX6i5vE451vKyrPol5YqnPhOsec0HLcZeIm4tpMDSLtllJBKWSOZv3SSvMkRRZOW/U2BLSnuH3p5yPNTg+gC4qB/juy2sIHjXop0xUi89t0RwxAUf9LogsgnjVj5CxScTFhglu590lHnEj/3v1bBdI/BbhXKMJVAXwTjDr35DgEskQeTtlfjG4GrVaJuDAw8QCBto3xugiOHIJseH26Q1Pp53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg3IhvcYFR8YSZ4bZzhnKEA3iUnGyM06+sT0r8QXJ7E=;
 b=lmy8EqDZ7+Im3NfWdx99glAOeLnqMz7a6yv14kG3y5p3hgDeMYVcT+rIk9iamveL7ESQFUG287T89RS5VL7t3JbdiFhBipg0WfU2NgJMu9b5jKr37oXMRXM9Q0hEqISorAbMmt1jtfJZ3R1jrV1lBmXHx/gZiSdBQDVoB4R9yxc5UjVUdUuSzK1Z2F9e8lAJSUkbr8O5p6DBUmrLzObergJshAg0L6U36Cjv2bbXr6cNhXmZPHZKkUmFngBrHZLDWkjUjrbvOAUXZUZ/TzLvN5qI8VDHaCNkWNP/xW7e7X7ni8rLdOeQ+u9MebYArZgCziXW2tAuQKO8ntGwAXI4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB6442.namprd11.prod.outlook.com (2603:10b6:208:3a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 02:38:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 02:38:12 +0000
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
Subject: RE: [RFC v2 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Thread-Topic: [RFC v2 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Thread-Index: AQHauOiMvw6BNqKnAEySvM6EM6cwPbHB3fKQ
Date: Tue, 11 Jun 2024 02:38:12 +0000
Message-ID: <SJ0PR11MB6744E8907BBF000C73278B0A92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-3-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-3-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB6442:EE_
x-ms-office365-filtering-correlation-id: d61aa49e-0e48-4937-c66b-08dc89bf89bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?s9q0qCgMfmxt9lUrq5wifMKnXGFlkl65fferdop7XNzxU2H3JIucsJKeLBdx?=
 =?us-ascii?Q?vghoRRCpGMQI1vOtIknoyPtI59SJnss805sTriWDI5WWTmDuEHFQ5KTGp7pM?=
 =?us-ascii?Q?6q1EnPmQ1L4/c76ZIcWgzj7wRSXHJB9ac8IdxeW3UmEDvbE2nSxuLR4GLbLv?=
 =?us-ascii?Q?uIkx2wuq1OMttQU6sT0NE7dGIQput4Ap2bC2cvk5FPVsxL+w4wUNnF04AFkN?=
 =?us-ascii?Q?HQ6UakbLDL/372o66ud+LZ8UaqE3yWfKu5Upg8sLXYsWipS0uCI/e4uyNt+7?=
 =?us-ascii?Q?rJhjOs08gGmA2qqyA1ddF9nP090+tVxPf/yXyKXqGetuSymAHjVtujUZI525?=
 =?us-ascii?Q?dVX9Is/GCNdlk9V3muJgEFKm3tBs6oEcVwb5l25hF4KI+84qHpsyLoQbwNJQ?=
 =?us-ascii?Q?EHS6Is4D0uHq+0X9rYutly6c8UFLJO3KVG4Je3vL44gkLk4BRjAzJYI/n8Sn?=
 =?us-ascii?Q?5z3Zk9PWhAxHwNMZKVFQFKXnqx2l0PXX2T0/4SZfpC/p8/yW73HI4RCaZtmn?=
 =?us-ascii?Q?zdrMxcc9+ERn6afgx+w2jESqbgQ59NQZnh6IT3SSa9VXlTdhtsGeFjkgiUCr?=
 =?us-ascii?Q?vNdJBN2SaXwRtRMC7Trdq4HsFsAsRC9LCsl1E5djSoaUxspS6LsD+Hvk505A?=
 =?us-ascii?Q?RIfaagrnZZLjrUcwDwoXpIOv2Sa+NuoI5zDG4A0F5Lbt4G+Ei9GkIBWavcee?=
 =?us-ascii?Q?KXuvWlHIxjoy8M+L2YqUTtkot3fcknXiPyyHfyCPn9aE5OnFOvYnvzmdW3/S?=
 =?us-ascii?Q?RMh5n1n88X0EeZ1i2UfveGp9RVso2C0OKAMgCiSTbWVePvTB9vdMZpcVfN46?=
 =?us-ascii?Q?+3y5QWZSZqBSuxotjkLXmYPzKQkPAIFQZZjzeKpNNma/H+9Q3eIdNesOK99g?=
 =?us-ascii?Q?zEIMdQfn0DDLdOjk3/T38M0PJFnNHTxFvUW7+1CYvmtU/jL+FHCMV9yAFz08?=
 =?us-ascii?Q?A+0450t5bm2b10N8Ai+RIBTG31BvZudezEn9PPmuOmJWZ3bYWAnabICayoT8?=
 =?us-ascii?Q?aDUkxSzDDY1inNlw8Dbx1GBHwfcjCAmKZaw0Qk1NAUJXNwa1AngFW74q6LTD?=
 =?us-ascii?Q?p2K/C4g4TbJTJ7jOLs0QGCixqpGZta2QdIe2MfSdoyPors1biKYByUE2Aw/3?=
 =?us-ascii?Q?H0KI1hii+ciN6ZeBsz78gQAIpeTIsIBelBgPQUz1zKpWJFqzNT2ntyQADU1A?=
 =?us-ascii?Q?XDiyE07w7ZwKwhnoboiNVTMD6Rhis+EyF5IesFdRDdDZDs1aDRvYwJ3FBDiy?=
 =?us-ascii?Q?MeJPhclAyL6VJi6h44Y1k087vsJhNRhRWj/tUC1ih3SJ+4cOkD+Zrhv2+m4O?=
 =?us-ascii?Q?6yphCzTzEWEOeiwPkYIfbl7b9JFQRgisEQCzwqt9LvP5ff+XC6Zd7O4m9Blg?=
 =?us-ascii?Q?K4Veb7Ac8xVbmIPCON+n1ziwz4jD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5/bKY71EhQyFye3oJnaMpL8ZzrRN94akNGj0zyEVU/HVGuTem+0RKyN17Rj9?=
 =?us-ascii?Q?PvbGVCJnUUvAe6glry8qu3e24jEeiBUG6a0yxcwJ3qI/lr08Q0kD1EpuEePf?=
 =?us-ascii?Q?TmQEJeJkpON3PSSeEh2J9vqNCs9/Eg64Au3iwYJbvLiHsAXuo1CMFPXsC5WZ?=
 =?us-ascii?Q?tLW3z6MdVklh9VkATkqWwg7nBudlJqInx3cWLPs9a492WdRlScT07RtG4rLt?=
 =?us-ascii?Q?sNjsKGY2pxp+xB5yzw1eXracj52Sc373wnN9U1DFG+dNda43nyY/joVbQVce?=
 =?us-ascii?Q?2NdTqFxWKyltw/pK6tR0sb2i7OR/9e8WfHTDi+FbtLUOjDnOAeshr/HGY6y9?=
 =?us-ascii?Q?HMKpL9RlYhXGLTIqpNBjcW6jYu0qzk2C4sWnsrEPyNS0gsJyoCMOIgKPSNnN?=
 =?us-ascii?Q?gcu7ajr4uddubrG0eifYhTliOYT2f0bYxuYxjLw4VpRchBlOaBBpp2OLxlXK?=
 =?us-ascii?Q?dO2NJsROwlfE0OYLQrO0uydwETe/0uxpADZ6Q6VSzvBmRNP6Iu+dC23PVYCu?=
 =?us-ascii?Q?x+WulMzRs/PYxPhcDIyuBxi4fR9z/1ZjooqoqMT8/Yw9QPElmkCuCqAfUQ3J?=
 =?us-ascii?Q?fxi9+OcjN13eWl64hCuhbGpbMsubullWVHQQCFt4GMwldc30QGag8t+7lwVH?=
 =?us-ascii?Q?rbs0/VYI2+fQRWCTUi0yc9MbZPl+bzZT8W+F4Afs+du41zvXJXPeKMqMMtUo?=
 =?us-ascii?Q?W671VMwXEpYzohs9vt7k20+xkpCBWi1f1c7kQ92OY6D2ZAB96fcv9Py8B3aM?=
 =?us-ascii?Q?ZZbC30SnJzq+KkpgxQ0NTDhoKhGiT5/fMx40031EvtMi7p3jecAIq1Y2U+Ab?=
 =?us-ascii?Q?IJIVlz4uPa5IFAQfZPHOX/UlK8P/jZIsto4R0WumkDW9Al4TRz6p+G7vW3jk?=
 =?us-ascii?Q?V5cOiDVDovhlPyLxBbLe0Kg9LXPLyoKMo4X2fd1RQ+6of1xwc4oJXmTn0s8j?=
 =?us-ascii?Q?7rM5UBtq3eY7nffaFuSwXRsuvL8gkLOWz4gU6hHEtIBoeONQ7kSl4MQ9Bz56?=
 =?us-ascii?Q?+whDP0GPKM4lVDmdceKXLyBVOzImmIJeBqf/+MGhQFj4l1I7T2ffdFe/KQRf?=
 =?us-ascii?Q?YAH3UKA+dNN8E7UiJwTtdcYUgG4dqxxJA1X2akPKH4Mg8XNEu+q/LCoMlUFb?=
 =?us-ascii?Q?zEV6z8/do8m9InbctkAXzVR1A5JjyyBn2Qs0B4EajvbFARRRb0Jk84FPGv8g?=
 =?us-ascii?Q?mmW4kISA+fz0F5qXb+LguPaKiHuOpUGSEAQQ3wm/SlIvmepjv8Ha6TIN+/1Y?=
 =?us-ascii?Q?ghWuOBuY2+8J4zYnfddUfy9zN9Ghl1cXjdego5f5dfTlMTRTjHtgLvx2aBDm?=
 =?us-ascii?Q?ThkQuag4Q+9/4zp6w4XXNDMIqGtT4Tp+nhfkl9SWO0qTvl14JcFLTdeRo6r8?=
 =?us-ascii?Q?j0HUhCALsUBr3CsAza0ywtvy3aGnT4JS4nVCiQAl0fHUZ9xwqcEwhjCmBuwO?=
 =?us-ascii?Q?Xvlix19nq8MoEi2JyhDTM8Ue6KBRKUOeA4yFoXw3y5TWrKsGDtzZK47uQINF?=
 =?us-ascii?Q?HKYOE7ib6BRSs9cKvyfjhLwJmU4cs9LuLWyhIuwWOWwlNdH7x6b38XBXlz0I?=
 =?us-ascii?Q?nVTnnXAMGV9MstsCT6UgUej/WgBzYOIRT7xAQuke?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61aa49e-0e48-4937-c66b-08dc89bf89bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 02:38:12.1827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VL4PHxWGShQMHmFANq5uvFtfN43jJIkvCRH49oJ6MRxVhzw0fQ0yJVusL7+S2OYdHuIK7wWozSvt512fUblblH83bI5rwN0yVMIzHOS8i7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6442
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC v2 2/7] virtio-iommu: Implement set|unset]_iommu_device()
>callbacks
>
>Implement PCIIOMMUOPs [set|unset]_iommu_device() callbacks.
>In set(), a VirtioHostIOMMUDevice is allocated which holds
>a reference to the HostIOMMUDevice. This object is stored in a hash
>table indexed by PCI BDF. The handle to the Host IOMMU device
>will allow to retrieve information related to the physical IOMMU.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> include/hw/virtio/virtio-iommu.h |  9 ++++
> hw/virtio/virtio-iommu.c         | 87
>++++++++++++++++++++++++++++++++
> 2 files changed, 96 insertions(+)
>
>diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>iommu.h
>index 83a52cc446..4f664ea0c4 100644
>--- a/include/hw/virtio/virtio-iommu.h
>+++ b/include/hw/virtio/virtio-iommu.h
>@@ -45,6 +45,14 @@ typedef struct IOMMUDevice {
>     bool probe_done;
> } IOMMUDevice;
>
>+typedef struct VirtioHostIOMMUDevice {
>+    void *viommu;
>+    PCIBus *bus;
>+    uint8_t devfn;
>+    HostIOMMUDevice *dev;
>+    QLIST_ENTRY(VirtioHostIOMMUDevice) next;
>+} VirtioHostIOMMUDevice;
>+
> typedef struct IOMMUPciBus {
>     PCIBus       *bus;
>     IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically allo=
c
>*/
>@@ -57,6 +65,7 @@ struct VirtIOIOMMU {
>     struct virtio_iommu_config config;
>     uint64_t features;
>     GHashTable *as_by_busptr;
>+    GHashTable *host_iommu_devices;
>     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>     PCIBus *primary_bus;
>     ReservedRegion *prop_resv_regions;
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 1326c6ec41..0680a357f0 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -28,6 +28,7 @@
> #include "sysemu/kvm.h"
> #include "sysemu/reset.h"
> #include "sysemu/sysemu.h"
>+#include "sysemu/host_iommu_device.h"

Not sure if better to move this to include/hw/virtio/virtio-iommu.h
as HostIOMMUDevice is used there.

> #include "qemu/reserved-region.h"
> #include "qemu/units.h"
> #include "qapi/error.h"
>@@ -69,6 +70,11 @@ typedef struct VirtIOIOMMUMapping {
>     uint32_t flags;
> } VirtIOIOMMUMapping;
>
>+struct hiod_key {
>+    PCIBus *bus;
>+    uint8_t devfn;
>+};
>+
> static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
> {
>     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
>@@ -462,8 +468,86 @@ static AddressSpace
>*virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>     return &sdev->as;
> }
>
>+static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
>+{
>+    const struct hiod_key *key1 =3D v1;
>+    const struct hiod_key *key2 =3D v2;
>+
>+    return (key1->bus =3D=3D key2->bus) && (key1->devfn =3D=3D key2->devf=
n);
>+}
>+
>+static guint hiod_hash(gconstpointer v)
>+{
>+    const struct hiod_key *key =3D v;
>+    guint value =3D (guint)(uintptr_t)key->bus;
>+
>+    return (guint)(value << 8 | key->devfn);
>+}
>+
>+static VirtioHostIOMMUDevice *
>+get_host_iommu_device(VirtIOIOMMU *viommu, PCIBus *bus, int devfn) {
>+    struct hiod_key key =3D {
>+        .bus =3D bus,
>+        .devfn =3D devfn,
>+    };
>+
>+    return g_hash_table_lookup(viommu->host_iommu_devices, &key);
>+}
>+
>+static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>int devfn,
>+                                          HostIOMMUDevice *hiod, Error **=
errp)
>+{
>+    VirtIOIOMMU *viommu =3D opaque;
>+    VirtioHostIOMMUDevice *vhiod;
>+    struct hiod_key *new_key;
>+
>+    assert(hiod);
>+
>+    vhiod =3D get_host_iommu_device(viommu, bus, devfn);
>+    if (vhiod) {
>+        error_setg(errp, "VirtioHostIOMMUDevice already exists");
>+        return false;
>+    }
>+
>+    vhiod =3D g_malloc0(sizeof(VirtioHostIOMMUDevice));
>+    vhiod->bus =3D bus;
>+    vhiod->devfn =3D (uint8_t)devfn;
>+    vhiod->viommu =3D viommu;
>+    vhiod->dev =3D hiod;
>+
>+    new_key =3D g_malloc(sizeof(*new_key));
>+    new_key->bus =3D bus;
>+    new_key->devfn =3D devfn;
>+
>+    object_ref(hiod);
>+    g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>+
>+    return true;
>+}
>+
>+static void
>+virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>+{
>+    VirtIOIOMMU *viommu =3D opaque;
>+    VirtioHostIOMMUDevice *vhiod;
>+    struct hiod_key key =3D {
>+        .bus =3D bus,
>+        .devfn =3D devfn,
>+    };
>+
>+    vhiod =3D g_hash_table_lookup(viommu->host_iommu_devices, &key);
>+    if (!vhiod) {
>+        return;
>+    }
>+
>+    g_hash_table_remove(viommu->host_iommu_devices, &key);
>+    object_unref(vhiod->dev);

This looks a use-after-free.

Thanks
Zhenzhong

>+}
>+
> static const PCIIOMMUOps virtio_iommu_ops =3D {
>     .get_address_space =3D virtio_iommu_find_add_as,
>+    .set_iommu_device =3D virtio_iommu_set_iommu_device,
>+    .unset_iommu_device =3D virtio_iommu_unset_iommu_device,
> };
>
> static int virtio_iommu_attach(VirtIOIOMMU *s,
>@@ -1357,6 +1441,9 @@ static void
>virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>
>     s->as_by_busptr =3D g_hash_table_new_full(NULL, NULL, NULL, g_free);
>
>+    s->host_iommu_devices =3D g_hash_table_new_full(hiod_hash,
>hiod_equal,
>+                                                  g_free, g_free);
>+
>     if (s->primary_bus) {
>         pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
>     } else {
>--
>2.41.0


