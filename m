Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD56C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCF0m-0007BN-W5; Tue, 06 May 2025 05:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uCF0l-0007BE-J2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:54:51 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uCF0j-00070o-5y
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746525289; x=1778061289;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hRwRpXxCJrkHGYVubIfqc8B+pK/cS8MtxJOkvvlO03k=;
 b=N1Da6pJIojFtkPTKRRxiRrj/0FRrQVyPv9VeXBs6RQboVae51ikKl4mU
 UW9QEAyyArje+pJ//FZuVLwTfn2IpUkntMMyubn3HhOkmx8ecja7Yc5e5
 mCIjeIkKsIktf4BpUlAGHBYNoUWZu564iTyRInWzuW4WtEy9qF23KVuKx
 LGIUuxvJG5mZotz58P7QAHxOXXDll5aWD47kQVf4170/2FIhDVsbJN2Z8
 TWSJEzbzkeG+iHY49bZ0LhoAjXYOtJGMWv9LRNYtXe5CeaoO3ZIgDHOr/
 Ao/Dmzybd/i4kv45I5FGGXzpHpTaHNzdRbRttP7r5UglmV3gJiXvdunbz w==;
X-CSE-ConnectionGUID: KHbcBZM9Tr+eDZqMEpPDmw==
X-CSE-MsgGUID: 0ya/oyGVS0GzOPIqTFPxgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="59537962"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="59537962"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 02:54:46 -0700
X-CSE-ConnectionGUID: gNizFAa2TqC1ppBPF+QdFQ==
X-CSE-MsgGUID: 0xYf+ms3R0OtSbOZkZBR1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="166490072"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 02:54:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 02:54:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 02:54:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 02:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NowWJqMncRhMpan1SuAd2B7H3F2uGnnIqKVzTObiZOJz7dvd5YCPTyE+GiaETkbU/gF9scZ0QeMoMa8HimUtDcWxZuso5WWCxgZzvSzO50tfHkAOiBwK6/QZ6BeN7l4HC5sfKSNOXJsWzwnm5ltuKG4HTlCousWQyJNp1KgHv/wc5W88y9xT8ZSX8edDqWMkx8E4+xzZd/KdAQJPUKM3/psCZ/WS0YX+BwpS+DtW3yr5S84fObNvLy21tlbM6UZVu6W4NtOSH532wdJWVqJ+j+JO0MxihMXxaTs8AV36sPYkb/Iqqnl47YaZV+AXFMQX+cUnuSG5llaLtK/xuZHHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frL3Wz4ICwBGmXQmAD9wGf2sq+/gZHr+MZ5PTgCFPzo=;
 b=zK5BV17p0ja18z+6CR7Gvg3ddgluMwmfRizVSBxky51iQz1IwDpvIvfG74tqWXtCA4fw3VWHkHdNoqfMQJnweKHNhlm1uQknGgVtVC1nfqT8eQNtGFRb5jn6WxJQRoiwFwUJ+Cpz3ntBcb4geOSN/PjTk5HJdbvk1TW9093twxCwNfyou0lePYB2IkBxRacKdkc0eQOJtWmH4TtXrPfzxS6VxlHAWajAiAzLQDoTKbMQddtZFp3c+oeDpSSAXMeQnYG7Rl3TVmzk/SxUI7Rx3IEuH37bOTKXJnTqPLxBTeX2RyDq/S2sl6+a57TbsleqnyhfSGkhObwJJxRQ7Y3Ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:54:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:54:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: RE: [PATCH v5 0/2] intel_iommu: Fix locking issues
Thread-Topic: [PATCH v5 0/2] intel_iommu: Fix locking issues
Thread-Index: AQHbuc4dH+dO4qeI7EuJ1zAypjI1y7PFZUyw
Date: Tue, 6 May 2025 09:54:04 +0000
Message-ID: <SJ0PR11MB6744290002CD5E480562F9D892892@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5226:EE_
x-ms-office365-filtering-correlation-id: 859d7220-bede-4e06-0ef1-08dd8c83ef83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CZmZlYDWQylXd+q62MILDa8uARZsNqc7l9rm+zcPca54ka+j1JHu3NBY+x87?=
 =?us-ascii?Q?tc2Ktb+hfBqDwTrj0RiTS6xPkjNatDMRRBhnVeeRhDKm8BQsJvzrCnqM9ihS?=
 =?us-ascii?Q?j+tOlscXeluNohVmmeKpe8HUMWifcYGOAra2G9nj1Ayv6TXOD1YjeTCnKjX4?=
 =?us-ascii?Q?6ZLvz+9SxyzGCPSxovpWvVcXAEDtMiC/acgDHzIsHt+WG5PRQQfUzHVObHgW?=
 =?us-ascii?Q?6f/Pd+SaeVE5rX6ntSTox0wKsW6ilTtMBN+URut6qIJtBhpsjYWpuNKYgikK?=
 =?us-ascii?Q?mDKfN5bSAOg0NvnTdSeFCk0HrCtqNJrhN8EjMGMkeQPjSkWr4F3AA+QsxRYW?=
 =?us-ascii?Q?YQ4y08+B7n5i2gIqOIwMnvFQpGJ8oEUu6+NAJzavLj4/m7G78jdnT7/gF++C?=
 =?us-ascii?Q?t+PCkO6tbgAK0kcEwfovPJWewyWtWNfOSgOkKctCS1SuXZuXu0+vniAN/RT2?=
 =?us-ascii?Q?fNxVYDo7MuWVUTe2Dz0OddVBWehETCUFItHJKACXaG5yczvHipe3liPJ0Edi?=
 =?us-ascii?Q?b9j++nrDEKmlfbLS9sxVIFLU1q/gV9HB00JI0VxkNIwvujZrSlwgG7WES82c?=
 =?us-ascii?Q?P9jw5e/f6itQghjj81HWqmQ7C7FJWO+TldgltrAntPZhwmZ52LIYyrHa3vSB?=
 =?us-ascii?Q?+4Dv/1uIyYEyNKarlozigplBzWBL46widg13AUoS3+iasXcClxyUysJFrjRC?=
 =?us-ascii?Q?c82qieQD79X/1SXio8c1rdu2BMtuhzQ1Yah94ro764uM3aqBs0qEDuxDxxbg?=
 =?us-ascii?Q?+7W1mg+zNO6u0RNb+jisYfr4rcqV0XysUhV2NH2R9jUdJ+wEvJoo01x+4zD9?=
 =?us-ascii?Q?pPPmFKQsSK82q4m5PndN+6IZI2NrKCASCEbb7pa/MJzuLL/tdooBpsezT48w?=
 =?us-ascii?Q?FyePpJAJLd5+Dk0lckJUA5gL3N9jgL7N/AsXxMFAgzJTqf1vymZxY0v1nNG8?=
 =?us-ascii?Q?tW/IftB0QV3D+OhMwRVWmcGqaAaOetDco53bzJIZH4YNGZt4VEQLCVjq61Qa?=
 =?us-ascii?Q?AgBSFFCZ3ZEpDDNiDd2Dwb4JT/6ZS/vv8Ll1sbjLjeJwQMIZui7xOqnjG6rj?=
 =?us-ascii?Q?BZPx48kk3vxI2gd36T13koar69NnV0t+SMLNY2q0E+giMQPqWtPOJAoDgY7D?=
 =?us-ascii?Q?hQwU7+EWToaLnQNvIzGMKgAP/5nuQo1DOqtmaTkj3p4mkGX1bS/vvdpCI8z3?=
 =?us-ascii?Q?gMMo/uTL6tKQTSMjpCRRr3i9KtdCCloWLEcbn04hfQ2yLIgAiNE6YOTRcs/U?=
 =?us-ascii?Q?/FgObLlLVP2ecjsgQuNL5Wec82rmKSEu040CjN7SwJkt6MF9RA3EQZrcV2R1?=
 =?us-ascii?Q?EPulW5cpy1m3Tztv9BErjp0xT9xGJaT3FnSbiTkRzIfhXqCtkCYASIXc/DoH?=
 =?us-ascii?Q?idHFyZd178lNos7+rQJsFa9Z8H2jG7lbQfromafIZwXlRLYHjwaV2Efn1tTT?=
 =?us-ascii?Q?q4jFCOfCDk3wpGVijZzf3WbpTVSFtsbSDgqoCQ0swpxC6Z2B3/Tq78+qbSxT?=
 =?us-ascii?Q?OnyFDD2BGCZ+JnE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G9ALNOQTgDhVMghrs+VTrbTeSMAHGF86x78ouruHNSojUtVL8/BnuKQbNULw?=
 =?us-ascii?Q?Gf6nTpfTRBLKmNTT+sRhlkM5e5eOnsXZTyCW5kTAHpMI0vQqpRLuDeJCkX4T?=
 =?us-ascii?Q?lcZUxshgLaMaWNr3JSvmgUcdrfGxzjFGAP9USuWH0UXn6iEYpptcMK4Oe6fr?=
 =?us-ascii?Q?BiKqd6LACiiJyHF9DeTuyeGH0bk1IJV7z1/S7GAZGgVIYATF/jU7i8g7tZDs?=
 =?us-ascii?Q?Lp/61kS+Xvzs2eA55j2RVO/HqKKTk+NO/wedWjSVP97h3yxaZtk5vLu4h5Lk?=
 =?us-ascii?Q?KjirBDkXT3swty/jctaDbnWwjD5WmfQenH/fXl5xoS2/i6QQzL6rZJZTOUD6?=
 =?us-ascii?Q?lZ/pf2BS8dGgcdnIeBFXKXOiipOcM5d8BfGLekEnssuRQ1jbaagyH3tN+Xyk?=
 =?us-ascii?Q?f54FYoDwvki1cQDP5ISxzgzG15o2mYjN4AbrYstIGhpv0h52ceJDi2B+rHs3?=
 =?us-ascii?Q?0bCe/T+NDl1R4VB0uEK9flDSsiEXkIu1cpLj0q8OFN7krYIRnIiCrv4cg41x?=
 =?us-ascii?Q?RWzB1LxuxnOHyCWC6O0b28ZMrhkY4vyU41xKenYvPm2aKe+aqwv3aumnuOFG?=
 =?us-ascii?Q?JhE/E/gqnaQKYpEBG/v8+xKUC3rwG0X3Uqe0ro3kNDdPkanI/GkxkKd47wm4?=
 =?us-ascii?Q?eg34gWDvb9N5AFPFa/g/JsVFgLIbRc2ws3HJ+9W3m7n8ZxYV06NLs2x6Khf/?=
 =?us-ascii?Q?5P/rgbMqbFEdPS8C7jvjJ+aei1NLvUOIMSR7zRR1vRh1Gnb6tk94LCTvJX5v?=
 =?us-ascii?Q?YGFfmuAsN0eUKaNosbcaqtYTW4+zTPil3C106CVkEcvYI6nTlJp8QRkpw+Ev?=
 =?us-ascii?Q?6y7ea6VyBjeTqggzkTIYnxqogmJVc89l4Ek9MvcYsa+Y5o0vCmrUlTyXFRgH?=
 =?us-ascii?Q?F70zoPak1GebslOVVJ1+8gT2CV4qozuDnJUxkO0Z4SUcmtedJAkD8K2guQfx?=
 =?us-ascii?Q?m3NzXzYy6u7QbieUcOMZTZGlpPrjUrCMjLrceszPNC2iZkRZFNxGGS0wQ8NG?=
 =?us-ascii?Q?hDqguaZ1o0y34XCz6ECss5JsXcDotBfQLc6tadrdtAI1bhVbLCpEXj6dbk5N?=
 =?us-ascii?Q?cCw6Qg9fpxRtb4a+sPDygpaovGw6dkO+/hksrHrgbshvKofglx+09CrT4ppk?=
 =?us-ascii?Q?LhpaiebsoqVANq77RnICdtjg+k2buVxt+CQ+oSJGzva/Rocde9l7xFg2hBKv?=
 =?us-ascii?Q?oXySypL9KjDMYFk3Frz6e/orw46ZviFodVvOadZzBUmXStfnP3LFHkfGq6aZ?=
 =?us-ascii?Q?IjOMsnn81RW5nluOgdaxkHFl0OLiDlMw24ASXFWJZp9JwbcgBXp8u48/XKJy?=
 =?us-ascii?Q?bQRE2v54Q6VZ/6fJzS8WCCYEsTJNgHE/RvtFYRWvVz1MEh7dHon+6inPk33c?=
 =?us-ascii?Q?3mYuCfAp2hQiRTMqrf63lWZrvjbo4VMCNAhWak1k/p+cmLRn0R8hmHKBiCnI?=
 =?us-ascii?Q?OcBd8V+c9TQbuV5fa99R4MOQ9Mj+yEpUODQXrNPfpBaqlWAx3dgXv9uQXhlO?=
 =?us-ascii?Q?Ucut/pXyReNIW3HgyDbulx4sWmHdY+lFyavBrG8DdSVtQjYFn/uuDTxYplbZ?=
 =?us-ascii?Q?PnCyep0xuVDkOhNnXjIpybhGxie84mXbubNGBv16?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859d7220-bede-4e06-0ef1-08dd8c83ef83
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 09:54:04.3395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lxb8jJprjg/QIrQ948DAIUsx2g2HfNebFtwXp+Ea/JAdtoDUTBGKL11XofCm2CXUM5qvfsadSwJx6f+9hlEZpxOzAzXIY+bfhixgmovHnxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Hi Clement,

>-----Original Message-----
>From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>Subject: [PATCH v5 0/2] intel_iommu: Fix locking issues
>
>This series introduces 2 fixes and improves locking style
>consistency in the VT-d device.
>
>Changes since v4:
>	- Re-check if the address space is present once both bql and
>	  iommu lock are held.

Yes, this is cleaner. For the whole series:

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong


