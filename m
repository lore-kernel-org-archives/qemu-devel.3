Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F836C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFrxv-00084B-9q; Fri, 16 May 2025 06:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFrxr-00083S-Hq
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:06:52 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFrxk-0006uv-Th
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747390005; x=1778926005;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jnwUo3YK1GzxXTJh25cin8uafQOIWayaLgY5puweU5s=;
 b=U3ABFMePUvMnfXOCyY264C5ZnGnDKb09JSPWj8TGqrOnhQQsdgZ1gKuP
 +7t02jKgy/0HDhPCMQuOYbZ60qBhQ1lTaOue5I/+qjGO+OzrC9gcpjcYZ
 NccRCgGsgzhzKobdVKxulasYLHw+XZ3kCe6U5UNw3UfrTDRAyRyxVFRVM
 HjHwJ87sdf2DzT0/IGFlMYZRjzP7YFzbGCTPiicgyXGTCJi/vCkC4jMvk
 ucHSVNXxD9DLvdGT2/kMv6f639HpfJ2Ly4aanBhwVppG6j7Z45fW48tvS
 QJNQ5ut1qfz12on7AhtrvvWRHGtJommYOcVnhUHcsf8UPPTCWfDl2/HdS g==;
X-CSE-ConnectionGUID: sdLpBlUXTT+eCY2IIgbeAA==
X-CSE-MsgGUID: 08Mrts0uQPKSwWDhhHvEBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53171776"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="53171776"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 03:06:40 -0700
X-CSE-ConnectionGUID: mHgses6cTj2t7xEMFtV1ZQ==
X-CSE-MsgGUID: 98sajQQbRKeWE31g7g5hyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="138564795"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 03:06:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 03:06:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 03:06:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 03:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBd3psocR868SYFc6vFB/W6ZCTCtYavXb2pKQLmFDbse40RCIU4LMdG9jiaOpKiita16afn1L9foIf6EzlIb3JVy3KjQIONZfVIXK1jyGJxZrxX+1C0Ch4iLzLgfPi+jQQRZ95S4CLyOBTt8pvjZZRvy5wZkrDgpsb9yb3RK8ilEDZr+CYYVj+TkxU7g0aot/Aqj4BwNnfJcuDZNyNNeI/X7KeIPyTnR+sVOpmE89vizVBej0FwlpXc9f4caKOWWXsaci3zJq3BACnfiLQKjibV26TuMArT/hGskDTIsVc55aMV8i5ghMu1vnZgjT+6hvZ3aPAk33MAJswHp5/n20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgaHkRbsrN3RELa1rCRTlD90p12TES59ZnDHBFjTd10=;
 b=GI+tQUzx1LhFoBtNGGrXRfq40G3sXXIHpkCw+U+D2zf6v2yk3X09wr4sh4EFnzgzXV39uBA3+KoKSNbE5DY3h4cAJ7fmoV5C7SB9nB7ArNgwcOzcvO8fcWLOUPF3A4XGrjNX6h5GFFC1OZgV/FkrYPOcGv6WkK7/smlNUAnvg+Hs0MV3xVSwny22IKW4egIXOyyeUh2CyQ+OgETti+gfZK5l2GBX2ldzD91iKigSju73xTdIZNmhLuI49cji9KjZNo4/5C96bB/N3d72u0yLT2RH5X0/erNMC3QPm+AgwIA/2g+Zz0vthptfJWz5uhJGesZazsge1K6crH+IS4ZDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 16 May
 2025 10:06:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 10:06:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
Thread-Topic: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
Thread-Index: AQHbw1NdfsZ61LQreUmnGCD8bDk2g7PVDE2g
Date: Fri, 16 May 2025 10:06:33 +0000
Message-ID: <SJ0PR11MB67441B4BA69BF42F30261EB19293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-37-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-37-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7763:EE_
x-ms-office365-filtering-correlation-id: a5329bf0-4014-4f33-99fe-08dd9461563b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aavMz7NJfBhsTahS3uVcHZzCFqoW+v35AugPKSw+/+EX3sTjOd4aDUBhP41R?=
 =?us-ascii?Q?kK7fq7uJC2Fqj9nK6BQdTD8O2XAV8bIL0gKdbaQE8cpRrL6BStMwiPbk2pgx?=
 =?us-ascii?Q?0DubOJ6Oub+uli7SLMeDoKnw4zBM2xit+AE4G14wKFX3cocUYMb6GY61bLaD?=
 =?us-ascii?Q?juWRFin7+WezhYH5t8fGKWdLga9JhURrQ/P9fflKI71fr/BEn62EulJoPcOf?=
 =?us-ascii?Q?/c+cdjEPd/7MeJFlMayCOnGZKhvdGQ1LcyfGhPfK/SrCFKSrpdslwuLzjVvd?=
 =?us-ascii?Q?HtsPukTZUSeCN+C+Dir6YHZ0u1hyFEIS61tEViJ6tjPzXiPS7jea3LrmyGHY?=
 =?us-ascii?Q?kx2SaNSZrHr5q86nhuzHt3YXPzIi99RL9b0jUgCG4zpIO2uY5OW6vo/RSouH?=
 =?us-ascii?Q?u4QY/V4HJmJ+xTETMErCnEhYCEQ542i4X/xHH2vHT0TEtnrjYLl0ZQgKjEdu?=
 =?us-ascii?Q?w8tntp+wN2UuAXVAEIjNVeAeUCZ+xyMsOYhIre1vLDLP9gN2c55FoH87giPe?=
 =?us-ascii?Q?j1kIT5Hnti2KQ8cDX20XialzrLKYCFkK6NZRBD1axxwE1771d6x5QtJ39nHO?=
 =?us-ascii?Q?cmvSMU21402ga9rsBTdIfPc9TDLCtsPGxWLA7qYWEODPbwFaSCQ0QGBzqKCZ?=
 =?us-ascii?Q?vHhyX/KHZ7rV0SAz1mUgHulZ7tf3ggQZdy5/sZK4a2QcTdLSZbK7D0Plh/KY?=
 =?us-ascii?Q?Bw+xhrsaAbCW4QKabmzp2Cs5GL70KYhJulXhmw/c7cDXIvqabk8uY/75/GPr?=
 =?us-ascii?Q?+pWGtNKt7VLGfiJP5/iOFgTUyuYrfJscmhwy427d95U4rXhhsF2HUbWhCsoR?=
 =?us-ascii?Q?F1ih/X1yGAu7p/Pg/3mC478OC3HWpSIdq6r80YvMtQcVJvhLNbT2oEfVi1B+?=
 =?us-ascii?Q?779regbrMfx5g7ccikoFSzSEl/3wlX7tH2wcITsfNbkdSIRccbabYiS/WekZ?=
 =?us-ascii?Q?SUN2ie9UZHcw2OoxXsT2tklfuj8aidmtsNpGYF97/Mz/B4netpG+7+5Wl1S8?=
 =?us-ascii?Q?XQXzZ55s1gdvF5GwCv0Ea3mG14xKSuiKqoxWGL57wf+mD/azbpRASdMCdKnF?=
 =?us-ascii?Q?zAt/9We7CfZX+CPsISQAzfxYBreffECR5t0VFvEkgdx358g6N/KPcjuxE7IX?=
 =?us-ascii?Q?kRs+KuLwNPIO5BRZfqY09HDYsh7ZfUgcLzWT1avvY0xFID9evQfVt+Gs0qc4?=
 =?us-ascii?Q?kJ+6VNdpWBvIAsWIaEzimTnn5yBpwGI6qiYbb7RMZ652SisfHqpDUb9h1Fgl?=
 =?us-ascii?Q?Wis42P/MqoWw03Ca4/w89QqgaYVxq4k2wRLS+neGS0WcBE+1N3F4VdUKAgHK?=
 =?us-ascii?Q?ftk1MxtyaFLG4Zg0AJBjZ0Jo+ne3Ae3HmydTxejYUAL1g2hqYFD95gEPpMuS?=
 =?us-ascii?Q?HMdMvWUsOvAnrW3/1W1bZBy9RQnB/yt01+rYaCIID0lFVqUt9hW5SIE6lg36?=
 =?us-ascii?Q?R0wBEIn2qWgzoaCj8Q0CNoWbOil2FCpRD36T/b/FMkz7WsCPpFYhBw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8WhZI7aaCnn+kFFb3+5dCH0VDRoYTR5h3WYgdCmrativS8Y7mFospsJNRG9g?=
 =?us-ascii?Q?ZDgsjGl2cAj8eKdNO26TiWlxSaFrfvPcKu1WR0w8aOV+rxqeCfAho+43kTFx?=
 =?us-ascii?Q?odPHTxzE/z7zCjepeVy7iZ7zS8+juvzokCvrRxBlgFAAKdL3PQChrF7RMl1T?=
 =?us-ascii?Q?UxktMkIlKXI9LEHVCKl8H6+Pje9lcZfAPDAadWmFpNU8TYhhZxX/Z0HsMdzw?=
 =?us-ascii?Q?YlDRx+FELIwFFtRQDH0Khhla4BZyJMNYwrYmgcxRl9DzpRJ2tLwGb7IwDcjt?=
 =?us-ascii?Q?Ra1dCljXNCDHLVhc5q8t9rx9i26H0dW6TMy7MMC4k62aB+uD+S4HHRI9reZG?=
 =?us-ascii?Q?Z57eey2j6ZrpyIQbrDQ/LQlIL/T/96tsoNVJhdLCz0+ePxEc2lAVMilwVot2?=
 =?us-ascii?Q?+GyN6h8s6I/S73meC0k7TeY+T/EWYsqpsehRn7HaN7gPeTKWdxR7PE2pWZvM?=
 =?us-ascii?Q?0ySPYMhTK+KR65X+DPsn5+zTaXxxNsPqZ2kouuV68rcol2VVkx2j1hMq7RjB?=
 =?us-ascii?Q?Oe39yT5X5rxQkIH3K6jbYCotl6BG0ZNnXjzY61V2T+Fg2DrXaAWXkIPSUqVA?=
 =?us-ascii?Q?icXsK8tVLzttYerXmITURCVnitXHmfL9OjTkTrlo3RVqDyX3oWWAM1SuDwHq?=
 =?us-ascii?Q?kua9lMomgZKF4HRASvRcicsx0BN3+1jrMtBQ2mg6RrQ1iV7Z+87yVioyD1iu?=
 =?us-ascii?Q?GeLhOrJ6A8fi7ZDTXwavIBwobWEXfNc2WUA0m5OM3JVWtkW1aGSTT5k++pQd?=
 =?us-ascii?Q?sWBY8tywIxeefJxWaDEKYKYfYjLFEe8XPLeuIYo61fYc6lh5Fr6YfIfuetOw?=
 =?us-ascii?Q?QYtawYcCGjDnYN/z5Wo9AaiEtcMp/JRNocnlT7RCeXCnBQecKjGQL58fC6lC?=
 =?us-ascii?Q?OM1mSEaXTs3s1XLHjOG6T0yMzilMiCJqC5aC8qJnPxfb7eIsGTrhORq2shvl?=
 =?us-ascii?Q?oYuB7JqJJw8Ulh4uvUGGLs1776CQRKCEr0kO84T2/UEp4Gf/F3ScAlNIuhLZ?=
 =?us-ascii?Q?g56brP7LUB4z+PF3Zll7gTX0zaNRG026d3fXWGlHztnkEYWGNj45kC/abSzU?=
 =?us-ascii?Q?buJxKM6qugOBppv0h3WFZnld6p+aneLMV5fOzZPCAnH1CMAG02SFUjzguADY?=
 =?us-ascii?Q?VLKrwAidkwITkW+wF7zpFxsqRK8qnYTK4sSj4CPFVpzHf0aKMfVdl7EjLlsG?=
 =?us-ascii?Q?o7q3SYpgsmt+pVWF00c4w3QipOM23lHoPrh2doRb1Vcjiv576eXVi6JzwJTM?=
 =?us-ascii?Q?ezYWr+PrpB2jhLK0OAsAFtw2A/OeiyoVqiKQWEwWmb+qD8lNMMX0uEf7y5ea?=
 =?us-ascii?Q?IqwNk5Y7Tt+NRHPFTUrIf3RcYOoskcvVbeibmss70pGY5JFgPbdZ05DWuUni?=
 =?us-ascii?Q?2HRW0sVaESFDZGochYFaJR4mQdqxgbepA9810zntIx5jLa/BnTJpoJ+Q7ltY?=
 =?us-ascii?Q?QFFqwn52GqRlrxGOnO14P5xY9JoGnhh8wcwqPhKUaoHlFx1OBvRb6DUgQmsw?=
 =?us-ascii?Q?Wc7MMgSVPUfKBx/fQhGJtkXJJOKFcYd17F9cao994HeGdsmfo1UVnXMlSITO?=
 =?us-ascii?Q?sZrSTQWvhM0rRn/pbX6gZpcifPXND5r5dHYld6FK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5329bf0-4014-4f33-99fe-08dd9461563b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 10:06:33.5670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8K19yt+mFE5qBGOi7YNZXBuUs/Y9maASh3t2am5GcFW5xhosyt/b/X+of1V4DNb7GRZYEvZygBcv7/EfTPwDrWbZvi+aoJqAGQqwMnQpoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
>
>Save the iommu and vfio device fd in CPR state when it is created.
>After CPR, the fd number is found in CPR state and reused.  Remember
>the reused status for subsequent patches.  The reused status is cleared
>when vmstate load finishes.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> backends/iommufd.c       | 19 ++++++++++---------
> hw/vfio/cpr-iommufd.c    | 16 ++++++++++++++++
> hw/vfio/device.c         | 10 ++--------
> hw/vfio/iommufd.c        | 13 +++++++++++--
> include/system/iommufd.h |  1 +
> 5 files changed, 40 insertions(+), 19 deletions(-)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 6fed1c1..492747c 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -16,12 +16,18 @@
> #include "qemu/module.h"
> #include "qom/object_interfaces.h"
> #include "qemu/error-report.h"
>+#include "migration/cpr.h"
> #include "monitor/monitor.h"
> #include "trace.h"
> #include "hw/vfio/vfio-device.h"
> #include <sys/ioctl.h>
> #include <linux/iommufd.h>
>
>+static const char *iommufd_fd_name(IOMMUFDBackend *be)
>+{
>+    return object_get_canonical_path_component(OBJECT(be));
>+}
>+
> static void iommufd_backend_init(Object *obj)
> {
>     IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>@@ -47,9 +53,8 @@ static void iommufd_backend_set_fd(Object *obj, const
>char *str, Error **errp)
>     IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>     int fd =3D -1;
>
>-    fd =3D monitor_fd_param(monitor_cur(), str, errp);
>+    fd =3D cpr_get_fd_param(iommufd_fd_name(be), str, 0, &be->cpr_reused,=
 errp);
>     if (fd =3D=3D -1) {
>-        error_prepend(errp, "Could not parse remote object fd %s:", str);
>         return;
>     }
>     be->fd =3D fd;
>@@ -95,14 +100,9 @@ bool iommufd_change_process(IOMMUFDBackend *be,
>Error **errp)
>
> bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> {
>-    int fd;
>-
>     if (be->owned && !be->users) {
>-        fd =3D qemu_open("/dev/iommu", O_RDWR, errp);
>-        if (fd < 0) {
>-            return false;
>-        }
>-        be->fd =3D fd;
>+        be->fd =3D cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be),=
 0,
>+                             &be->cpr_reused, errp);

Need to check error before assign to be->fd.

>     }
>     be->users++;
>
>@@ -121,6 +121,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>*be)
>         be->fd =3D -1;
>     }
> out:
>+    cpr_delete_fd(iommufd_fd_name(be), 0);
>     trace_iommufd_backend_disconnect(be->fd, be->users);
> }
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index 46f2006..b760bd3 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -8,6 +8,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "hw/vfio/vfio-cpr.h"
>+#include "hw/vfio/vfio-device.h"
> #include "migration/blocker.h"
> #include "migration/cpr.h"
> #include "migration/migration.h"
>@@ -25,10 +26,25 @@ static bool vfio_cpr_supported(VFIOIOMMUFDContainer
>*container, Error **errp)
>     return true;
> }
>
>+static int vfio_container_post_load(void *opaque, int version_id)
>+{
>+    VFIOIOMMUFDContainer *container =3D opaque;
>+    VFIOContainerBase *bcontainer =3D &container->bcontainer;
>+    VFIODevice *vbasedev;
>+
>+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>+        vbasedev->cpr.reused =3D false;
>+    }
>+    container->be->cpr_reused =3D false;

It's strange to set iommufd and vfio device's reused in container's post lo=
ad,
Maybe better to do it in their own post load handler?

>+
>+    return 0;
>+}
>+
> static const VMStateDescription vfio_container_vmstate =3D {
>     .name =3D "vfio-iommufd-container",
>     .version_id =3D 0,
>     .minimum_version_id =3D 0,
>+    .post_load =3D vfio_container_post_load,
>     .needed =3D cpr_needed_for_reuse,
>     .fields =3D (VMStateField[]) {
>         VMSTATE_END_OF_LIST()
>diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>index 8e9de68..02f384e 100644
>--- a/hw/vfio/device.c
>+++ b/hw/vfio/device.c
>@@ -312,14 +312,8 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>Error **errp)
>
> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **er=
rp)
> {
>-    ERRP_GUARD();
>-    int fd =3D monitor_fd_param(monitor_cur(), str, errp);
>-
>-    if (fd < 0) {
>-        error_prepend(errp, "Could not parse remote object fd %s:", str);
>-        return;
>-    }
>-    vbasedev->fd =3D fd;
>+    vbasedev->fd =3D cpr_get_fd_param(vbasedev->dev->id, str, 0,
>+                                    &vbasedev->cpr.reused, errp);

Same here.

> }
>
> static VFIODeviceIOOps vfio_device_io_ops_ioctl;
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index dabb948..046f601 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -26,6 +26,7 @@
> #include "qemu/cutils.h"
> #include "qemu/chardev_open.h"
> #include "migration/blocker.h"
>+#include "migration/cpr.h"
> #include "pci.h"
> #include "vfio-iommufd.h"
> #include "vfio-helpers.h"
>@@ -530,13 +531,18 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>
>VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>
>     if (vbasedev->fd < 0) {
>-        devfd =3D iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>+        devfd =3D cpr_find_fd(vbasedev->name, 0);
>+        vbasedev->cpr.reused =3D (devfd >=3D 0);
>+        if (!vbasedev->cpr.reused) {
>+            devfd =3D iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>+        }
>         if (devfd < 0) {
>             return false;
>         }
>         vbasedev->fd =3D devfd;
>     } else {
>         devfd =3D vbasedev->fd;
>+        /* reused was set in iommufd_backend_set_fd */

Should be vfio_device_set_fd

>     }
>
>     if (!iommufd_cdev_connect_and_bind(vbasedev, errp)) {
>@@ -634,7 +640,9 @@ found_container:
>
>     vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>     vfio_iommufd_cpr_register_device(vbasedev);
>-
>+    if (!vbasedev->cpr.reused) {
>+        cpr_save_fd(vbasedev->name, 0, vbasedev->fd);
>+    }
>     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>num_irqs,
>                                    vbasedev->num_regions, vbasedev->flags=
);
>     return true;
>@@ -673,6 +681,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>
>     migrate_del_blocker(&vbasedev->cpr.id_blocker);
>     vfio_iommufd_cpr_unregister_device(vbasedev);
>+    cpr_delete_fd(vbasedev->name, 0);
>     iommufd_cdev_unbind_and_disconnect(vbasedev);
>     close(vbasedev->fd);
> }
>diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>index db9ed53..5c17abd 100644
>--- a/include/system/iommufd.h
>+++ b/include/system/iommufd.h
>@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>     /*< protected >*/
>     int fd;            /* /dev/iommu file descriptor */
>     bool owned;        /* is the /dev/iommu opened internally */
>+    bool cpr_reused;   /* fd is reused after CPR */
>     uint32_t users;
>
>     /*< public >*/
>--
>1.8.3.1


