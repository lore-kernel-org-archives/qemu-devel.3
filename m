Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD5FD4609
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvRo6-0002sT-Ih; Wed, 25 Feb 2026 22:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvRo4-0002sE-7h
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:12:52 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvRo1-0004Nm-3Q
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772075569; x=1803611569;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=IhUqJTAF8WxvGdIH/wY5vs7Z4fWZ5SZktvze2r/iayI=;
 b=WraJUxGk6mlDT+vS9G7wZ+3PqnG09taI3GsjmPFNOapaF90AhwKsFdu0
 LOY7AXMBAJK5Th3RTUM/lvOXSZYJ8Hey76uZmpcrG1+eC8drR7RhojT2Z
 AwMQsBUAcmjgfUV9UhJPi7vtY6MUk8lCi8vJ7+CcJ9s+tbEsXQbo+qeSI
 vb7ACC7NitoVqFXUh+wuBl6QmSOLmmiicpt4rqrZ/TL1MDtZwhVa811br
 Cj7MKRcqFbzCJHKOYQ53aMJwKFvwBBytRyFJHQBJb5AYL90hvG/FSpye0
 SF+YCLwd7bJy5BcpyKkEXfRhm8nacSzV0fSiOqy60tnd62tjM6SlYq3eO Q==;
X-CSE-ConnectionGUID: v+5jb00yTT+n+x1D+FRtIw==
X-CSE-MsgGUID: b4/PdUlsQX+1lgpOH3iZDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72162042"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208,217";a="72162042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:12:44 -0800
X-CSE-ConnectionGUID: KOOQqytwQ8y4/LR4fGd7Hg==
X-CSE-MsgGUID: pjKfEmmHS4GrbnMrUMTcmA==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:12:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 19:12:43 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 19:12:43 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 19:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow/h40TxZu5q7gVlJWxjZikC6V+Zu04OhvIOGpJmt5Bg7lD/YTlMDNwTw7cLFiTeOFIljeoqcpo/mPdaQl9+O7yI2qq3m5Ghoph4WJL2YVLE99KL1h12EnOpO4Vd9j9WcejaR3HEzxrSgaXPqF82GP+Y2314JnqDGGKjk0wW/hW/9wNKZ/X7zW/bX1LO28rhh1r0ytbyyhc0fEgWlnoP9dPWAfpooDF7suRXFK2FI1+062p8A3puuEeSRZRUhsNTENfJOMSoaUUyLDBGG30a1H98FU4nhonneiB4sSfnuPYe1h09WALYk1RLCKAessWHCUIanEjZBYF2TZIALY2sCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNG1PfExORt1nY1g1F48qlEys6H58cFhSIb1NTWutFg=;
 b=Ryy3xu5/tdFydNEXNH+pUhEcI+tch6RuSaE1K/5HEY7VhHa9LU5hbaeuDK+3regbxEdNeUE7aieECU8WDSxClXRD+jky/dyu6ATlD4me8iA0XN9C/Eklhj73DipgB7puP/2QOBziQWUaKTSqio/jyvgQIM/Dif18Ky6GouGgCpYDa7fhzv9c+s51hGG3myGXUWhn62prKd/sxvr5BKZkyjJHb8/jnfi4MxxFp+WO9U5kvrO8Ne81unOqTYDNZoKAOsc40aNzb+BF1zeGFnSdr+JXiUnYlNq5/IlycqXpkILXH29X3eUTl5U1lozM7/Z8CJ8YvB7lMANMsKKYgqLu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 03:12:36 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:12:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcnWP6tyKy+zgBK0aBvE2Kf1JwJ7WTB68AgAFX8xA=
Date: Thu, 26 Feb 2026 03:12:35 +0000
Message-ID: <IA3PR11MB9136ADFEF99A8AD8220F497A9272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
 <AM8PR07MB760213E1A9BBE02E443F9CD28675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
In-Reply-To: <AM8PR07MB760213E1A9BBE02E443F9CD28675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:37:14.117Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB8541:EE_
x-ms-office365-filtering-correlation-id: d6dcb089-8ae0-45c8-6cf1-08de74e4e3fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007|18082099003|13003099007|38070700021|8096899003;
x-microsoft-antispam-message-info: 1W1gtcw8tU4HszV3BsaAApZ+fjYzzS493b+qPLQEMRTzo0M1z1kRTDBwmSmE068kp/8y/QW0Blg2aZkCHN99IwgbdItUrVAUiyx7QI3SD6ivQX6w5QCqYm7uVQ7YlniavyWS12VjFa0eBfhYrdarVRzQi7El3sSRhw5D4KL0ABZO+ifhjOO6fz5NhcJ2SAZ4n9TG0+o5VeAgCdb5Rz/VfHg55c1wi4blBq9F6V+9OM7Cr7ODvHee1PB8m8gAeXaHohRfrlOaikU+AokdzfBHAf/7VQmB0E1rNDylQi0tkIBBPIVOmoGNdAeY3TC3jJxPhVhA60qzSOrD61Vm/UWt5xMVYIeeyoCjsI6gV9UZ6/z8w+poXmDyONUeGYMFGTIFCoyaiuz6wdTqVVF8ivMutDGgXMqvEiVmP2Dghg5PCqzbz29CfVSg7t4h756qoB0xyLi6NGDXDMNaSS+HHLhUtdYd2MaxfFLXCh9Jum7aBMODqGrxOjgBfULu/4UzYq5iA8ljdoTYGruoU2GL53P/ftpiuuhs1CEVKrry8783Gkx4F9LPFiWR+BWgEBck5g6PWcW5n1AGboYRAnNRNZsNr63IoGUc5FI0Fg+T8J8/mxhrShKHRqZMqCu0kp3swzX3qiMpi/75bk5naQClcWUHu5yGRwIdhxDrkjkujWaG5H1jxF0G37Yr69LPXvGru4Z7IKIsUduYjZokW6kiIva/y8VXomYqDl+vODcW2wRWovF6gmb5d/VviqRgv5L0MrgueIAEuJDUB+cGvuxhgf1sRUqcVn81t3XU//Lzw76BaIQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(18082099003)(13003099007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wPcxStbRM05Z1/M0ouiyX0KwHJ8FG5PuVfvjGKFnPU+iB8gWwx5+iGS1ZGBH?=
 =?us-ascii?Q?HyKcTWS8fx8SNVz8c2JM7/fhVkXC4WZE+R0aMQuUTvO0NhzYBkyoLS1skdOO?=
 =?us-ascii?Q?yfxQF2ur6pgBzGklzZJSGz5xAuLl5KbDEodDR6n/2V3KO1CrkqWwF8PXEXHP?=
 =?us-ascii?Q?ss6CTq68VQ9bC26F71i6Jb/7O+b+jUqk9s8yB0aldhit62GqzfBtkw9GGAJ1?=
 =?us-ascii?Q?cbRLxqbEc68DScUys3SZQHp2LAflZ0JVxmf9or7U+5PWwELB5L1XkY6w90Al?=
 =?us-ascii?Q?alUB3z7dUtYEHqIUEEodAuAfrKixGRyWXnrN55PtgjstvPUlRv6HDrOMdb0R?=
 =?us-ascii?Q?jJeA1kNlfJSzu3fBokdHqFK8O42UFJM7DGw/VZKDBMVZjXTdF6SoJO99ltg/?=
 =?us-ascii?Q?DREgJqPGTVMR+nZnlBbCnIhXzJM2vR20r+SkSoOSdq+kSqI/ZyJacfRc3/zr?=
 =?us-ascii?Q?31jkvxYX6A7LP8c9mmNuKf92quxfIM5N46F60o9QjUIdEiT0DIeqY+8YSl6J?=
 =?us-ascii?Q?PbBUP/7Hl3abiE9q7L/aciNFYflVauJZkfU+N2g/aNOdUR5AQFSPwwu17fet?=
 =?us-ascii?Q?fX241EUD9AzD1vq/S/Iq1T/jdDPOwu9D6Bd6I9AZklm7QKiBBAcBg43Ap06n?=
 =?us-ascii?Q?bvVpQyTU0UY8Kq59uZ9/f2b/HKkW0TH1mELI3xEyc3ArGWdw3HJW+j7dLrSj?=
 =?us-ascii?Q?cZMIQq2FevoPh4ykOQLjlMF/sQgwSI7GUAnrA1qBLSOjd0beuWDG6pjZcTyB?=
 =?us-ascii?Q?k10x35ze+0Zlt7xFO1KU5xDTrW9jk8hqHmWQFfrlWUheTZTZME+kDIhGPyVV?=
 =?us-ascii?Q?lN/8CxUkVhyJsXZ+VL/wug695FBdqnqa56+jjUIB6eTE8P2YwwLD27O9rLTi?=
 =?us-ascii?Q?kZ2ShGy+xWe8wTR8aLCc+gT4wqdEsmwmlwgopz6Haq6NyCfcs4MDq73y5JqR?=
 =?us-ascii?Q?EyJfMXutxEBwNeJPjbqLzgyNfG3IZLABO5SDG4fvtub6S3JRIjX6fRaGbxg7?=
 =?us-ascii?Q?OIiZWjKbQQSD3flgrBUMei0WJc45BChkBXAk/18g8l2GMRsD/Wvps3aRitPm?=
 =?us-ascii?Q?l25+IExaFWgcupfv2pbXaEhBE3XIbTkUQRSyHNm1H8YcaV4RaXv9/tNi43bG?=
 =?us-ascii?Q?vJBy+eIYzABqMKcXqcDIrJ/s3wxA3ILOCUozXEkm/iK9Y5JSdKBXlr9O1nrc?=
 =?us-ascii?Q?MtvLOA7lTRGWOZL5LnpGlpEwxCF9s9v7QbyQeZrCdcF8br2TxENDDht+M9zu?=
 =?us-ascii?Q?yVVWgBgYd30mFWk/u/F7dI4PRqfBdars52F91clHwOxLSunk97bvY1IQFQzi?=
 =?us-ascii?Q?ljI2ByZD5rz070KUzMW3ZNEykQI/pgCLlmT9fTdQ8Wg93S3NGxLWd/r2ABoW?=
 =?us-ascii?Q?1TS51Om34p3AOspXDSv9lWn8NzjIa/ASX3rXQuazP5lcSz52NGQKMt6rBikQ?=
 =?us-ascii?Q?1lRdSQdshWZUoK77RES6ChEyMG7SMtdQYTwqwXH7IJxYMo+hNtel+AeYHe9M?=
 =?us-ascii?Q?FCfwYrcbU5x60rvt4yPu+6CuJAQPJ9B+kNdT8hXXw+xsCfr5G1YOQP/PlVgK?=
 =?us-ascii?Q?G4vZNjbKYjhz3sqx5BZGVLf6kv04npV51xFUquDrBWzA0qvDm5N9w0eoqkub?=
 =?us-ascii?Q?4spZL5z7UgCmx/ZrGh9Wg1iM+qSWeHP84fsjfJCBA45nK7Yn9egoxRodke+2?=
 =?us-ascii?Q?Zmzk+cCvfj6ggpArJCH8xKf9qe27N2wG6sGD7pLth46Eox6GWiP9NcVt8ra1?=
 =?us-ascii?Q?8bkmUYKZFA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB9136ADFEF99A8AD8220F497A9272AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dcb089-8ae0-45c8-6cf1-08de74e4e3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 03:12:35.1375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+15GNzZfnH1itwZrL7lmqCu4GwzJfwto98BbnzAoxRIMThVa98SgqbFzP3PIHGF35N/Lf8eBzlLO5cRRSvuKL3zGYyrUozT3VZTBNNpqeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_IA3PR11MB9136ADFEF99A8AD8220F497A9272AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

This is to follow Eric's suggestion in previous iommufd nesting series
where he suggested to use extra32/64 syntax, copied here:

+#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
+#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
+#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
as those are values for the granularity field using

VTD_INV_DESC_PASIDC_G_* look relevant to me.

I think you would gain in readability if you adopt extract32/64 syntax
like in hw/arm/smmuv3-internal.h
Looks more readable to me.

See https://lore.kernel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b=
@redhat.com/ for details.

BRs,
Zhenzhong

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Wednesday, February 25, 2026 2:38 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck

Hi Zhenzhong,

I'm a bit confused about this patch.

All the other VTD_ECAP_* are masks for the ecap qword.
The purpose of this new definition of ECAP_PSS differs a bit as it extracts=
 the field itself :/

cmd

________________________________
From: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.=
com>>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.=
org<mailto:qemu-devel@nongnu.org>>
Cc: alex@shazbot.org<mailto:alex@shazbot.org> <alex@shazbot.org<mailto:alex=
@shazbot.org>>; clg@redhat.com<mailto:clg@redhat.com> <clg@redhat.com<mailt=
o:clg@redhat.com>>; eric.auger@redhat.com<mailto:eric.auger@redhat.com> <er=
ic.auger@redhat.com<mailto:eric.auger@redhat.com>>; mst@redhat.com<mailto:m=
st@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat.com=
<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redhat.co=
m>>; jgg@nvidia.com<mailto:jgg@nvidia.com> <jgg@nvidia.com<mailto:jgg@nvidi=
a.com>>; nicolinc@nvidia.com<mailto:nicolinc@nvidia.com> <nicolinc@nvidia.c=
om<mailto:nicolinc@nvidia.com>>; skolothumtho@nvidia.com<mailto:skolothumth=
o@nvidia.com> <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>; jo=
ao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@o=
racle.com<mailto:joao.m.martins@oracle.com>>; CLEMENT MATHIEU--DRIF <clemen=
t.mathieu--drif@eviden.com<mailto:clement.mathieu--drif@eviden.com>>; kevin=
.tian@intel.com<mailto:kevin.tian@intel.com> <kevin.tian@intel.com<mailto:k=
evin.tian@intel.com>>; yi.l.liu@intel.com<mailto:yi.l.liu@intel.com> <yi.l.=
liu@intel.com<mailto:yi.l.liu@intel.com>>; xudong.hao@intel.com<mailto:xudo=
ng.hao@intel.com> <xudong.hao@intel.com<mailto:xudong.hao@intel.com>>; Zhen=
zhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.com>>
Subject: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.du=
an@intel.com>>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e4bcc884b0..e5518a94ea 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
+#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6483cb3d85..c1b31b17de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowe=
d "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }

     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
+    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=3Don");
--
2.47.3

--_000_IA3PR11MB9136ADFEF99A8AD8220F497A9272AIA3PR11MB9136namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Clement,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is to follow Eric&#8217;s suggestion in previou=
s iommufd nesting series<o:p></o:p></p>
<p class=3D"MsoNormal">where he suggested to use extra32/64 syntax, copied =
here:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+#define VTD_INV_DESC_PASIDC_DSI&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (0ULL &lt;&lt; 4)<o:p></o:p></p>
<p class=3D"MsoNormal">+#define VTD_INV_DESC_PASIDC_PASID_SI&nbsp;&nbsp; (1=
ULL &lt;&lt; 4)<o:p></o:p></p>
<p class=3D"MsoNormal">+#define VTD_INV_DESC_PASIDC_GLOBAL&nbsp;&nbsp;&nbsp=
;&nbsp; (3ULL &lt;&lt; 4)<o:p></o:p></p>
<p class=3D"MsoNormal">as those are values for the granularity field using<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">VTD_INV_DESC_PASIDC_G_* look relevant to me.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think you would gain in readability if you adopt e=
xtract32/64 syntax<o:p></o:p></p>
<p class=3D"MsoNormal">like in hw/arm/smmuv3-internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">Looks more readable to me.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">See <a href=3D"https://lore.kernel.org/qemu-devel/2c=
bb91d3-9acc-4e7a-9a0a-19d9b5efe21b@redhat.com/">
https://lore.kernel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b@red=
hat.com/</a> for details.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BRs,<o:p></o:p></p>
<p class=3D"MsoNormal">Zhenzhong<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> CLEMENT MATHIEU--DRIF &lt;clem=
ent.mathieu--drif@eviden.com&gt;
<br>
<b>Sent:</b> Wednesday, February 25, 2026 2:38 PM<br>
<b>To:</b> Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; qemu-devel@non=
gnu.org<br>
<b>Cc:</b> alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@red=
hat.com; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothu=
mtho@nvidia.com; joao.m.martins@oracle.com; Tian, Kevin &lt;kevin.tian@inte=
l.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt;;
 Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b> Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits s=
ize check<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Zhenzhong,<o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">I'm a bit confused about=
 this patch.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">All the other VTD_ECAP_*=
 are masks for the ecap qword.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">The purpose of this new =
definition of ECAP_PSS differs a bit as it extracts the field itself :/<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">cmd<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;Z=
henzhong Duan &lt;</span><a href=3D"mailto:zhenzhong.duan@intel.com"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">zhenz=
hong.duan@intel.com</span></a><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;</span><a href=3D"mailto:qemu-devel@nongnu.org"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">qemu-devel=
@nongnu.org</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black"> &lt;</span><a href=3D"mailto:qemu-devel=
@nongnu.org"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot=
;,sans-serif">qemu-devel@nongnu.org</span></a><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
<b>Cc:</b>&nbsp;</span><a href=3D"mailto:alex@shazbot.org"><span style=3D"f=
ont-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">alex@shazbot.or=
g</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;=
,sans-serif;color:black"> &lt;</span><a href=3D"mailto:alex@shazbot.org"><s=
pan style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">a=
lex@shazbot.org</span></a><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:clg@redhat.com"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">clg@redhat.com</span></a><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:bl=
ack"> &lt;</span><a href=3D"mailto:clg@redhat.com"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">clg@redhat.com</span></=
a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:black">&gt;;
</span><a href=3D"mailto:eric.auger@redhat.com"><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif">eric.auger@redhat.com</spa=
n></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-=
serif;color:black"> &lt;</span><a href=3D"mailto:eric.auger@redhat.com"><sp=
an style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">er=
ic.auger@redhat.com</span></a><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:mst@redhat.com"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">mst@redhat.com</span></a><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:bl=
ack"> &lt;</span><a href=3D"mailto:mst@redhat.com"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">mst@redhat.com</span></=
a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:black">&gt;;
</span><a href=3D"mailto:jasowang@redhat.com"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif">jasowang@redhat.com</span></=
a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:black"> &lt;</span><a href=3D"mailto:jasowang@redhat.com"><span sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">jasowang=
@redhat.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:jgg@nvidia.com"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif">jgg@nvidia.com</span></a><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:bl=
ack"> &lt;</span><a href=3D"mailto:jgg@nvidia.com"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">jgg@nvidia.com</span></=
a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:black">&gt;;
</span><a href=3D"mailto:nicolinc@nvidia.com"><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif">nicolinc@nvidia.com</span></=
a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:black"> &lt;</span><a href=3D"mailto:nicolinc@nvidia.com"><span sty=
le=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">nicolinc=
@nvidia.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:skolothumtho@nvidia.com"><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif">skolothumtho@nvidia.com<=
/span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:black"> &lt;</span><a href=3D"mailto:skolothumtho@nvidia.co=
m"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if">skolothumtho@nvidia.com</span></a><span style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:joao.m.martins@oracle.com"><span style=3D"font-siz=
e:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">joao.m.martins@oracle.=
com</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quo=
t;,sans-serif;color:black"> &lt;</span><a href=3D"mailto:joao.m.martins@ora=
cle.com"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sa=
ns-serif">joao.m.martins@oracle.com</span></a><span style=3D"font-size:11.0=
pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
 CLEMENT MATHIEU--DRIF &lt;</span><a href=3D"mailto:clement.mathieu--drif@e=
viden.com"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,=
sans-serif">clement.mathieu--drif@eviden.com</span></a><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:kevin.tian@intel.com"><span style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,sans-serif">kevin.tian@intel.com</span>=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-se=
rif;color:black"> &lt;</span><a href=3D"mailto:kevin.tian@intel.com"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">kevin=
.tian@intel.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:yi.l.liu@intel.com"><span style=3D"font-size:11.0p=
t;font-family:&quot;Calibri&quot;,sans-serif">yi.l.liu@intel.com</span></a>=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:black"> &lt;</span><a href=3D"mailto:yi.l.liu@intel.com"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">yi.l.liu@i=
ntel.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot;Calibr=
i&quot;,sans-serif;color:black">&gt;;
</span><a href=3D"mailto:xudong.hao@intel.com"><span style=3D"font-size:11.=
0pt;font-family:&quot;Calibri&quot;,sans-serif">xudong.hao@intel.com</span>=
</a><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-se=
rif;color:black"> &lt;</span><a href=3D"mailto:xudong.hao@intel.com"><span =
style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">xudon=
g.hao@intel.com</span></a><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">&gt;;
 Zhenzhong Duan &lt;</span><a href=3D"mailto:zhenzhong.duan@intel.com"><spa=
n style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">zhe=
nzhong.duan@intel.com</span></a><span style=3D"font-size:11.0pt;font-family=
:&quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits =
size check<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Caution: External email. Do not open attachments or click links=
, unless this email comes from a known sender and you know the content is s=
afe.<br>
<br>
<br>
If pasid bits size is bigger than host side, host could fail to emulate<br>
all bindings in guest. Add a check to fail device plug early.<br>
<br>
Pasid bits size should also be no more than 20 bits according to PCI spec.<=
br>
<br>
Signed-off-by: Zhenzhong Duan &lt;</span><a href=3D"mailto:zhenzhong.duan@i=
ntel.com"><span style=3D"font-size:11.0pt">zhenzhong.duan@intel.com</span><=
/a><span style=3D"font-size:11.0pt">&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 +<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 5 +++++<br>
&nbsp;hw/i386/intel_iommu_accel.c&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index e4bcc884b0..e5518a94ea 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,6 +195,7 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
+#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 6483cb3d85..c1b31b17de 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Nee=
d to set scalable mode for PASID&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID wi=
dth %d, exceed Max PASID Width %d allowed &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;in PCI spec&quot;, s-&gt;pasid, PC=
I_EXT_CAP_PASID_MAX_WIDTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;svm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_iommu-&gt;dt_supp=
orted) {<br>
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c<br>
index acb1b1e238..15412123d5 100644<br>
--- a/hw/i386/intel_iommu_accel.c<br>
+++ b/hw/i386/intel_iommu_accel.c<br>
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D vtd_hiod-&gt;hiod;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps *caps =3D &amp;hiod-&gt=
;caps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *vtd =3D &amp;caps-&gt;ve=
ndor_caps.vtd;<br>
+&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(vtd-&gt;ecap_reg) + 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&gt;bus;<br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt;devices[vtd_hiod-&gt;d=
evfn];<br>
<br>
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Only do the check when host device support PASIDs */=
<br>
+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp;&amp; s-&gt;pasid &gt;=
 hpasid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID bi=
ts size %d &gt; host IOMMU PASID bits size %d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pci_device_get_iommu_bus_devfn(pdev, &amp;bus,=
 NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Hos=
t device downstream to a PCI bridge is &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unsupported when x-flts=3Don&=
quot;);<br>
--<br>
2.47.3<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA3PR11MB9136ADFEF99A8AD8220F497A9272AIA3PR11MB9136namp_--

