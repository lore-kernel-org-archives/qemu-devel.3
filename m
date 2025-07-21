Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3AEC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udoY1-0008ER-Id; Mon, 21 Jul 2025 07:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1udoXy-00089h-TF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:19:07 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1udoXw-0007gP-OS
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753096745; x=1784632745;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rw6d9cf5H3cx1wpC4g54NPI4gp1H+kxrkoVMfHE9Dqs=;
 b=nXoHoNn771WATJHml5mYYLlm3vxoYIN/g/CGBHsdEN0gVgsW7GeeMKjj
 F1Q+3aVY/xnitX0/KzmjZYhKlPn7dUGKBLvx7VWWkb1Pl2od4AfHL3KZ3
 +PU/TwwqJpzH10X/HUkSEOx/sE7lYS13/jp0sLODN1VEKPC7cIOxBFtE/
 WvbWJtPA2eHqzXTJ95J68VU9D2mFnnbolHiVSrPyYo/3pRcJ0AHx6FHoG
 dJrcRoKrP7QRBO8sqek33K86qvOCQAVcjR2bdM7JtFk4UM4aktnagjUB6
 jR6SHMWwbiAb4ijYUBNpFJpftaItOWm3vfBhmQD2g5ZeeVHm8ttP6MU62 Q==;
X-CSE-ConnectionGUID: KG58D7zSQPeo4tn90xQ4Bg==
X-CSE-MsgGUID: G2Dt3NtgQhq4Fd4D6Ejl1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55017933"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="55017933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 04:19:00 -0700
X-CSE-ConnectionGUID: cegWVD5tT9GOKvnN2NDHqg==
X-CSE-MsgGUID: rxkgh+0sR+yvJCSxe1zTlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="189765239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 04:18:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:18:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 04:18:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 04:18:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0neXExornrCP0RR/y3ScJ1QGHadYy4FtiF6n5+9WefwaZsCiAf0FE+qcQMEceE7PGInwy87k/dLvuLFt+6LPFdfiXjpHsA/czOAVcEK1Gg4hl+sr5qDVGjMNmHoek2tZvuWUbr1XsbPFLpcNhFVMawzOs9oHlebQ7eMBTjRnsg42JHHil1ee24h4X4/HtZjhNzOAmk3QmMQxi72nLyaNROFSOZEyEGbyyj+3vLi38AF0vmEN9oZlDN1haye98qe1c0RFn1ePzkPjt+WGjQ+5Lp9g5tPKpE7+CFZ4STKCLoXMOCVAefKto8YgAYBLQJ94SMAOi5JFA+rzV+iJ8zbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxHuMJEuIJqULa8JIbYdzJ5lME+u9xfRMu74FaXx/wE=;
 b=ZhemJZ5b8Dhx1GN+HmJInHCkTaBt1gRX11AvswiWEKTyARYlpHKFiAR2VefzFS4SZhKafDokqW16FrsEzRUWyVLvlNt4HvYPOG1PwOCNmPt5ROGUUUl3pOXbD5MRVcfbJd6ij4VbvnOtTEqHCwN1rFR3IezuI8zOGtfNodncqwbVXEVpGY5G/siteuesdcpn0OYYeWXA+7idb33UDH9Db3fAxAGRvBxAgvBYjBVKVSBYKWEl1hCBKELUiy/62d48qO+xFgqz5dztLnMC0XcDH5Hx8GqWhPfZM/yYy9d5wKmYB/02WAnMKyF7W7CbKs8fxI40nbTMYNgKpl6zD4GK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Mon, 21 Jul
 2025 11:18:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 11:18:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Cedric Le Goater <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
Thread-Topic: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
Thread-Index: AQHb9nxa2lXNdDeN/UCbI5NjRCQA1LQ1mmWwgAKOUACABEUyoA==
Date: Mon, 21 Jul 2025 11:18:56 +0000
Message-ID: <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
In-Reply-To: <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB8567:EE_
x-ms-office365-filtering-correlation-id: c08c100e-2dff-4c99-ada1-08ddc84861d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jP4sorS814YU8mrP/yVdPSjb/FJyLUHzGs5uChZFSrp8g09mlbbFf6qFuBrx?=
 =?us-ascii?Q?C1UoWeT/6XFOIXi+/FwyW6IFO+GIFyQ91q30jheLJI1PBl2ZNFnp4rNVjk9s?=
 =?us-ascii?Q?S6m2UTMwZ1S3IpFTIksLbvppeC8JBrX8NqxsjOrnBFhjc5w5xO6C+0ZPBcAR?=
 =?us-ascii?Q?3uJlpVkUFAW+9gWN4YYDqBmyGATDHLc+fNXHr46MF2Q4xTEsfHJ9ifKC4gsX?=
 =?us-ascii?Q?9JoMS/uJLrVYO4TdEAwsMJhaeCIJtqerNsudf2Nur4U35SvznS+IKfEIU2zM?=
 =?us-ascii?Q?qD7ovhwPTuwcRfjYJph+vaW9uIhOzxWqF1ycV2cSOiwN5tDHbF0ZFG4wW7e4?=
 =?us-ascii?Q?CsNTJWeVAv3wVHvutTOtTNoGrqIbO4vk5RcTGWWkBlqwtmcrTLAVnpt+9Vby?=
 =?us-ascii?Q?Pg4VlXWBnKKK/1sz8y/30oJjgxSsCAD8M8m4Kjhp3ljgP72WjNzKY8kapeiH?=
 =?us-ascii?Q?TGnkBDOBk+0L+3h/Okj6U8jnF0Z+oeX1pqe17c9G13HDDFq7ZDRdf7u+fS2E?=
 =?us-ascii?Q?U9o0gI16PzeRi7Qz16GLV6CNfSW39HrL1SsGdpSxzPXOEOu5GUChm0/Dhfz4?=
 =?us-ascii?Q?izs0OjtZNmiGTHMOSmDKVxscO3InufXIqzpgTu3gRlu5JMSCd0P53wXmKZML?=
 =?us-ascii?Q?3ph8JjFOaCA7lGkXskv5MfHBuBeBAjFBi1d39jYoR6zNnubKSbfwQCyZuKlM?=
 =?us-ascii?Q?TXpRGdB6/eE453M1cXL8Zhr/xQRNpbdBPcZnQnwIXU6I8pwTZSxnAeZIliUi?=
 =?us-ascii?Q?gENG/MpZ53nmvNkpMMBQTGT8tBKPJQqBvBr3gHeyDpzf7ho/FQ2VkVwmKy1y?=
 =?us-ascii?Q?L6OJyIK2qPG9nvrF2IF/oXYAGzUKlxI1vwp0eYctdKdUIWbB3MUahlSM/M5j?=
 =?us-ascii?Q?chQeGDKM34foyYdyqHbILL1UouBiEQBEmmGO6TmF90UQLouokPdUOIN8pIj8?=
 =?us-ascii?Q?eh7JOqZ1PCJaRH8fz0G6SBjwX3t+1INXbgvbk6BySKpp7CvJ64gpCpa6whPH?=
 =?us-ascii?Q?rI57fi5ZpzUuOpA4pzVPkIZZZrb04QT/W5cyg0OzCC2VacEv/XcQDfYinOCo?=
 =?us-ascii?Q?xi5Zd0E8IFOTaN0UBP4FAGCmk5YqypA25uyMTgqIIoQVnPvGFmsK/kja8zHo?=
 =?us-ascii?Q?wg2Q4L/CIvbo8RUWIRT84C5RH+DXbu/DBES3BkKTCIBzo4DkNFjnT84A5pcg?=
 =?us-ascii?Q?Exr8FNCK1CqbTWjiFmQIA2mFygQLNpKNrp+Je05Vtn0Ev2ysnmYLmI+9v5Wx?=
 =?us-ascii?Q?2nCiLocU8IObo4LtZJZeATD/qMsFqf1KmCUmfciAgZGjKrwQhAGeQ4tsC/iQ?=
 =?us-ascii?Q?rktQZVXsL74Sh8EM7mu2sDUJOcGUZwJSsPKeYLHCarg5WLxQLdcXq6Cu8Chf?=
 =?us-ascii?Q?6PIKHKi3vJByTIHN0rPACNznLZZVQXS27/UhFfDpV0AFBcVwH86AXs0WFglN?=
 =?us-ascii?Q?CvHF8ubvepqoUZnCS0ZVJSeNtF1yrY3QcZPqZhvljbX1rpppAzXPuw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6UQo0WGJvb+hFQohURX/3QySnPQKK5eI/HwIPTJS9SZoRlNEAPFlK7qwiKgO?=
 =?us-ascii?Q?rxtVruc7ew080CBAW3q410NvCPSL62gJS0+J6byHgu3mdNqoHE7eSODS9vTW?=
 =?us-ascii?Q?fRyUmnIj1MvIofCeQW65FQX+ZXy4RaI6FUS5c0C3xxPJCJEmF06epmNOfSfJ?=
 =?us-ascii?Q?QLQPZFX38EP8yuTUfhudkEZobbLO0PxidrlrFlpj6kJ8MDFgeDusRH7E9wvS?=
 =?us-ascii?Q?hehKK3XvwoT5/0xffyRH134gEGSjhtY/mSPeBTOn6Nj+2xkyGCP+as4jrasz?=
 =?us-ascii?Q?XG9eGQ7lxYVM1jZIGdWM4rdHJRw0EIbyph++sDQBgm7me93nnuYHK8THmOh/?=
 =?us-ascii?Q?rIZ1gvS42HbLIRHcW/w1gNwQoCPKX0cxsESP/vGMreQL+sjfpde8RwVcGfgV?=
 =?us-ascii?Q?7/MXYxeCbVm4kdOpcfKpcCNzJl7Bxxkn+Ws63h+dBfZ57XN3WqoZU140HmqE?=
 =?us-ascii?Q?g4+seMpAh24w7BN+m4FzA9u/EDdKM72ekx/RNTKN+ha16x9L234/ZsqKiuSJ?=
 =?us-ascii?Q?dyl5rvV4hMCtPVpMAzYUmPgWtQAD4TxJMW7HkhDrcI+u9IsPUY6v87WUgwFV?=
 =?us-ascii?Q?FyXGH7HgVItEJLue6EmDUM1tTCkWlIviNQ8QvRawIloOMqaJIkWnuIbIOZr0?=
 =?us-ascii?Q?E8GEfR3Gzaoqb5ydKHQAncfmrFYQYdNd9OJRaxJaUcN8Xs9f1MFkVFi3BPC+?=
 =?us-ascii?Q?TFTBqw96UvTSxpvvp9z+eQVt7A10bYOR7IhJOmkyjTVhnN40ELS/z1uV0q6p?=
 =?us-ascii?Q?Y2j+wltIs7S5cpuibZAZt1ltjqZliVYHvEZHJF4xxuaUoC6ngtr+1pHdV9jj?=
 =?us-ascii?Q?NX6uHPWp+/cslIwQ2Ksx8OaxJU/Sq4pLXtV8xE51ds1PNZWaJtIg0SzSK2Cq?=
 =?us-ascii?Q?advkAckIRRX+KE1b1eo4T4UxznOpoNv/o/W3wjGtaAUp57OZsPMVKEN+A+97?=
 =?us-ascii?Q?zYuVcOhzizCKUcU5a9/buW4S4wy/fZxRK/gNB8ZRSoVLG0voDDQJRcMpRsJw?=
 =?us-ascii?Q?3ClFOObHvHZRAWmEfpgbmbIRocTSkobKNp7aPDAfAxI/6GKWjZOtxJqXrJ7U?=
 =?us-ascii?Q?UYAqPfgMc38TNyqxPCpawu+OKC0ElZq6JD1Xgjzt6Trb+LAkwCRma0eGAHBK?=
 =?us-ascii?Q?fHB29x9faZc/2+Ui0+encT4JGqPSkpJlo7yAyLy5W1Jqzh2vNQV3pK5dMv1n?=
 =?us-ascii?Q?vRc4Cx4PQavGDp8P0NJZBv3N6ZnCXiDy04Q1t8dVykc8VobgQskUDqjOc6KH?=
 =?us-ascii?Q?UEWyzLdHflLkAQNfrex6xuxe51+oPa1t9OImryAMWxROOI9xR8qNFnlK5POZ?=
 =?us-ascii?Q?rOuvHQw7GzzHQQ9MRXuZ+0lANRrWgSp6ssFmYaUrZtAvgPBpQp6doyykOKSz?=
 =?us-ascii?Q?raue0+oPCARu9FI+/mzSGapfnUXce+TLUqnVIFA4F4kApYc01DmC8ocO2bIm?=
 =?us-ascii?Q?eo9usQbZKvpunSR3aE6EJr7AjSA9/c7MCf8Z8gPJxWpcoNcMDG11yl2sJDx9?=
 =?us-ascii?Q?1NtA5EQx1RNTB4jPutQW32eUgBAaypaA0Lz6PtFtn2zojXWiYLkrhxozRvOf?=
 =?us-ascii?Q?cMmcpIcV51VpvabNc0H4mm8yu0iLw08s6gZCuR96?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c100e-2dff-4c99-ada1-08ddc84861d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 11:18:56.0942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/cFMItev42F6F/E4juadEkGyUIFfDRH54Q1+UAwqLnp7A5gxdZNl/hgS+LE0V6UG6xWD2GWsBVirx/qn+hkJsEoKt99TkaoPbX6bVCNtKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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



>-----Original Message-----
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>
>On 7/16/2025 10:43 PM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>>
>>> cpr-transfer may lose a VFIO interrupt because the KVM instance is
>>> destroyed and recreated.  If an interrupt arrives in the middle, it is
>>> dropped.  To fix, stop pending new interrupts during cpr save, and pick
>>> up the pieces.  In more detail:
>>>
>>> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi -->
>KVM_IRQFD
>>> to
>>> deassign the irqfd gsi that routes interrupts directly to the VCPU and =
KVM.
>>> After this call, interrupts fall back to the kernel vfio_msihandler, wh=
ich
>>> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>>> eventfd.  When the route is re-established in new QEMU, the kernel test=
s
>>> the eventfd and injects an interrupt to KVM if necessary.
>>
>> With this patch, producer is detached from the kvm consumer, do we still
>need to close kvm fd on source QEMU?
>
>Good observation!  I tested with this patch, without the kvm close patch,
>and indeed it works.

Thanks for confirming.

>
>However, I would like to keep the kvm close patch, because it has another
>benefit:
>it makes cpr-exec mode faster.  In that mode, old QEMU directly exec's new
>QEMU,
>and it is faster because the kernel exec code does not have to traverse an=
d
>examine
>kvm page mappings.  That cost is linear with address space size.  I use
>cpr-exec
>mode at Oracle, and I plan to submit it for consideration in QEMU 10.2.

Sure, but I'd like to get clear on the reason.
What kvm page do you mean, guest memory pages?
When exec, old kvm_fd is closed with close_no_exec implicitly, I don't unde=
rstand
why faster if kvm_fd is closed explicitly.

Zhenzhong

