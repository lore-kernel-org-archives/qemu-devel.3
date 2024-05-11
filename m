Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570C6C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 12:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5mG6-00075n-GH; Sat, 11 May 2024 08:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s5mG4-00075c-Pc
 for qemu-devel@nongnu.org; Sat, 11 May 2024 08:55:24 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s5mG1-0003Ew-J5
 for qemu-devel@nongnu.org; Sat, 11 May 2024 08:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715432122; x=1746968122;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cDiwhNnN9hcfjzVKilJK0GB6KMrXbpnjDm7kk2ETwlM=;
 b=X+TpoL248SzhnqYu6tx15ubSBVoAnqXavFyumdyjJVg0UgcCJIYLvbUk
 yAuf+YN00tGjoOnEgOFPikUAzvi1Da5E9lx7fouBa41BM5T0W5MaqUP1/
 KJtSgoB/2eDBoAz+DOtN3LymS3JhmuJFm9emmiaT2u2uParaA3r7tFWer
 pd8tlJGlNiPqDOjDE5VQsUWhgWuZKQyO9+jzIVcWUWvuLq7uFoZadBtTt
 /y15jOd6bn7r12Jfj6MqV5iD3nX6gM4d7kx+r6hjZwTtzrnmZSAWPtjh+
 rxlE6Wb1iqx4xrvboGxnoa3LkANrFfy7cjoBzzmZpY9sg6yvtVZZal/CP A==;
X-CSE-ConnectionGUID: /6m4rJX7S5+kUHhW8NCnqA==
X-CSE-MsgGUID: JhVMVgIITbWg6BUknCoklA==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11246850"
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; d="scan'208";a="11246850"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2024 05:55:17 -0700
X-CSE-ConnectionGUID: BB3UKVlnRB6w6TLkNzXs8w==
X-CSE-MsgGUID: tj1y1BzST9iy4qCLtLu3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,154,1712646000"; d="scan'208";a="34568242"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 May 2024 05:55:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 11 May 2024 05:55:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 11 May 2024 05:55:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 05:55:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBkdDJDGVwdr994sO7iG+abQ17LN7i6gwTXHXyk65EZzVEIPkk4XNVU0KRtVss9f8/B7tqNBsNffIoL89Qhpcw/t32C9ybdM1pcvzIXNjfvTr8DMdtnBEDLNQ9HsD5rkvgqFjLPlJmBIEqk6ztammtl0MsSmP5Vs/VbnDE5Jk1/Igw26jUTOPPa2No5ZLjgo0kv//uoznodBqpoWWLSEBUJMkiQATMqYvYv8HJVRSwQ8635GfUtQrgwQZtC8tcxBSqqvr+gLECMpAVWfihM+Q8IZrc7G/Q8lLXIo7IFn0xhPJA3UGSp2xS6iVRFyCA5DIX/fAdgmwl29hFTxb74WvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmB72Qu1GnTdVK0mO8WfVxXBDGQkK+R1SlGDKMO91uo=;
 b=HA8JTov8Q2mlr+uIcHeBUVD6N9wBgqcpOwgUlKmEalc1Ect2Qv/RNt5WM56a4HONYAuPJ5LF0LcyjbeSvdCr+EMS8aZaaKIEibHseeVe52+yTDSp9xazcJ1RUJNBKdZHb7N/rhKpjKGLNhdUZv9V/S3pZEGJSHl6259rYDU43mEcCPMoT1c05t5H6pxccWZSfXvcBFB1KYx5h0bV9CFE2VpoDJgNsVGB8BkrPvhPt1w0t39HFFpsnVHLAhiJmXh9Eo6G+A6vzDz6iX4Dun/Khz2wDnZx+r438+rLxnVATw+c3mdE10HIs8ATULFKRl3LKglG0Be5ZXAJIdJ+e+wTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 12:55:13 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%5]) with mapi id 15.20.7544.041; Sat, 11 May 2024
 12:55:13 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v6 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHan5HTHXPsmPSqGUqaYb0smdpZjrGQ9s4AgAEMVZA=
Date: Sat, 11 May 2024 12:55:13 +0000
Message-ID: <PH7PR11MB59412D4757F9B176EB9B2C6FA3E02@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-6-yuan1.liu@intel.com> <87o79dflb3.fsf@suse.de>
In-Reply-To: <87o79dflb3.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CO1PR11MB4833:EE_
x-ms-office365-filtering-correlation-id: 5e84b201-888d-46be-34bc-08dc71b99972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+VtFzvSW512tLZRSVNLraZJ8bUN0epkDDvkzN5AexTa6P5AqiXFTliDxexxe?=
 =?us-ascii?Q?zR4DZS5rtwNVrGIOorx39zGjURCkHu7ZYzzS8FTFXGJ/pxocMTxcGGFuQZqs?=
 =?us-ascii?Q?T2shPw3RsHBGES46DpymorEOL2JGppdU2AICggP8T6aUNxPgDGqm+aXd83c0?=
 =?us-ascii?Q?OUzFfiJNLBXhkXmnjyKhJUn3N4rBocEADIa/WinYVtXTk4DNlX8dA01VjCIM?=
 =?us-ascii?Q?UHjIocbqRVf8xcc01hIPsRyJmBaUATWwt3CfAi5GdkMkNe7tFS4960joykOf?=
 =?us-ascii?Q?fGIScKcXIzwdXXFeiaIjvvul+62cRzqOJQSaOEChuohnCBDVJ6AgqrMGtlp2?=
 =?us-ascii?Q?hhdgHpUPmv2KAVSgT3GXBqYAJfhlWxLLR05bmkdd5gQKNVNsBQyFL6qHxxRL?=
 =?us-ascii?Q?57c2OwI7VAEhKdwhI79SfJctVuKa83lbjtXTsm3PN47HJhSDMHHUMk3HywPg?=
 =?us-ascii?Q?tKZ9GFiLi0Yj7g7Prd4OcryU5QZVj4jjeIp74XCbza7LBo4SdDm6K31ltLAa?=
 =?us-ascii?Q?yc4JzvnFoTFx1T+pnoB/TVsA2nvIJrD4nIbgtfa5lSv+DrWvvpnhFjCX0qAE?=
 =?us-ascii?Q?g2mEhwmfL51wRgz0AbG2gZqMBGHwhAdajuEREjBpxaUAj3/tB0HNb95+T9jR?=
 =?us-ascii?Q?u53dKfvw9/UcnaXyabP6mvlpH4V17m+fGVslXxg/SC8lW1/WgHe6mfDRPEmx?=
 =?us-ascii?Q?A+d3W9+NyFDOx/MNJBI5Cp1mtmKUrZg7NwmxSruZYTmx8nQAcrsEVBvcJuBD?=
 =?us-ascii?Q?NdF84+DoDnGCzssN1656jwcI4mWnfRXP7j+jLXMwisBNYSyuX/ZOn1FyvXdo?=
 =?us-ascii?Q?nJWaRwlQq+LBfjdHLuZ35Bf0o5fE21K3dn7yZZHejEOgY/wOlYt3uuD0FE73?=
 =?us-ascii?Q?wR6UyJbtH4cJnT5SrjtKVuboDNYC+oAKpGmB3hxEeItOTg6N7ZsMewXknf06?=
 =?us-ascii?Q?tW7p6TuuwBpScswLAp05IGpLGMRF2eXZ9RSjBqhlyv70prqHJ8Us9p4U690z?=
 =?us-ascii?Q?kHTu+TCl04Q1xoc04wsFcbg8CDQc2HBfS1pWV+YgrGCl8kTZpUEUQ/kimeEN?=
 =?us-ascii?Q?3FY9Ng0oARF0ouq0tPA+4DG0Wegnoz8+tlykWYC8Zla+qqX7xkkX3oXhSDlb?=
 =?us-ascii?Q?ZLUG2Db/EGWpG+XCStChrnxboQIe0wGRM9XbRmd/nRD4Kbm9lQlZWXrAh8h5?=
 =?us-ascii?Q?VDuktjDEB5WuUSt6zTAX11OTv2KH12nYwDMPjh7wLO0QKVJmLLKUuTJjxudB?=
 =?us-ascii?Q?3heXlvox0RrKOvCiVTIixanTyQX9O9bfnWlqQGE8DfLidoVJWhflXZG9/Kz0?=
 =?us-ascii?Q?pBV/xf5ClZMha+kgtM1yT675x0Q0PFX/ms/OlS+Cr45CHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GbBUQ6ne3m8wncm7O1iRFOzMPFH5xkFRHaSlmwjxYoAefQRmZ3+M1iSqqeGz?=
 =?us-ascii?Q?x9av9beJ9EYsgxwFxzErwCBmyFZaTZZokgzyiRAMuyRQuZ7OVUqB7lr4vlaN?=
 =?us-ascii?Q?oqNKbdPMpuEUBlrMJnaOCjGZmd3zgAQB7pZ8zslmyJJ/263R069Z2CucdwH8?=
 =?us-ascii?Q?amhRS/gX1HZTszS5GVJdkOhU04sCQ7jCv3biKKSIuNuNOL9DYoul6z+F6dOf?=
 =?us-ascii?Q?Hp5jVaUNXScybPe7ODnBqwsVXPlTHHvuihJ4HV0bUD5h4laO7wQmmlFHvG3L?=
 =?us-ascii?Q?0aDewGmVp9LeC3tcaR6jkwbjz9SgvzKz4+2vOhLGvpXNZTk2x9axYK+nfqfE?=
 =?us-ascii?Q?GeFKUVQBMzI1a/01TjRAjMkdD6sLdFe2AyyO1hyrfsaQujULIUsWOTrr6h+P?=
 =?us-ascii?Q?aI6iCzw+15+hFr7dCHq5gbNLQHVW3ckvppyBaQuiutyrwbhfhrmnJTO9x2MD?=
 =?us-ascii?Q?+GHw/wKrmPoXHoGjcwGhCSuNRpqDp9ukH/JMEsHw4DvU9tZv1+XAM2nQVRyU?=
 =?us-ascii?Q?anka0iQrp5Dlkc5wZNyiq/OIYDXRYItH8cRdOMyUkyVCe/U2HdEG5uxpf8YA?=
 =?us-ascii?Q?uwP9Ir/cxGu9wv8ZWbB1/gwJJt9eLAYZVUOlDknTH8jZOtxFmQBWOiquKY3n?=
 =?us-ascii?Q?v6/mq0vn87HCp2NwaRjxdcP3frbCGTLrNF2FP45lZllTsQn8LmgidVaGL74J?=
 =?us-ascii?Q?Ckd5OxqEpZahCsbdHLyBWC65DHjR1I6L7zrLkPSvuUULBTde99XJlgIZyoMK?=
 =?us-ascii?Q?FQxNnrWX2o3zh5GxGqTtmHmH14rimt08wMMEToDC8JaRof1KxewdfpzhRuPT?=
 =?us-ascii?Q?AnRuttR8z4dOtdkCf8LwKUMD6LKnqaafcskMWK1XO/5JP9to2k8Zpx/NmF3v?=
 =?us-ascii?Q?vzp73iFPfdudZgWF54pdq1EkLxCjp4m5niykBIATDBspMirLyLikfAQtOFCc?=
 =?us-ascii?Q?qC3Bq3NlUCVCzEsE3iZcpHqZ54MbuBRsYa85o7t7qkT+p27MsiXfPbNpkCfK?=
 =?us-ascii?Q?OhSTHox++KDrlPn6EA4CQN4by6A/XCB7th2jx8tUCzHwR6PiDmAwAAvw/CCN?=
 =?us-ascii?Q?bag3gFnI5RCp1WtKNabQiUTyCAwQ2wXWyI6sVDZaGaMPAS7J2MKHyYb4FeXH?=
 =?us-ascii?Q?xqfy/BGDxHfv+2T83c19ftP57ZA4ynKIEg+euqiAuly1kOR/ffAe42LfUk7n?=
 =?us-ascii?Q?yMG+ySVd3OWZ5q+7008rS1jGHcP4caGcCZtfZmMJk+tUgZmp/6zHdXNYhDoI?=
 =?us-ascii?Q?l2xYr10U/Emm0BBWQVkQraT6Hg/YvKZdBkvw8FkQoLK1LduiLSd1KsmK99VU?=
 =?us-ascii?Q?uvK+0dYZzZaMU1jrbjApho0JDD9EzDM/gh6ZG1Y3v4uLxDGgXZgH88e2N/S1?=
 =?us-ascii?Q?2u8ROkbL5+nkWacD0pC08GxgH2DBi0AKE+5D09MWbpp19X6LzIezY3mys3/N?=
 =?us-ascii?Q?EUe1PxGAkVO+R0hVdQMnZh0+wz1wXev4uuXBZRHl/mtQ+GtECXTt7kXHSNdW?=
 =?us-ascii?Q?XzyMtJvITZLwjUEAzyhzmdoJH4rWoLhio39g/ypPEs3oxvr4PHlT7GkWiCmc?=
 =?us-ascii?Q?3tGANGzRzUpp1PO7sZaU12/PazZt7jwKO6ADwN/Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e84b201-888d-46be-34bc-08dc71b99972
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 12:55:13.6673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1pbRx7l7ENSqoSKCFvl5UBWurvu3nYXDQ1BcwAKpRLt9QARFEa9cLEwgjpRdXV00wqhmmznlteKgA7OLjeM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Saturday, May 11, 2024 4:45 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v6 5/7] migration/multifd: implement initialization o=
f
> qpl compression
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > the qpl initialization includes memory allocation for compressed
> > data and the qpl job initialization.
> >
> > the qpl job initialization will check if the In-Memory Analytics
> > Accelerator(IAA) device is available and use the IAA device first.
> > If the platform does not have IAA device or the IAA device is not
> > available, the qpl compression will fallback to the software path.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>=20
> Looks good, just some nits below.
>=20
> > ---
> >  migration/multifd-qpl.c | 272 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 271 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> > index 056a68a060..89fa51091a 100644
> > --- a/migration/multifd-qpl.c
> > +++ b/migration/multifd-qpl.c
> > @@ -9,12 +9,282 @@
> >   * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> >   * See the COPYING file in the top-level directory.
> >   */
> > +
> >  #include "qemu/osdep.h"
> >  #include "qemu/module.h"
> > +#include "qapi/error.h"
> > +#include "migration.h"
> > +#include "multifd.h"
> > +#include "qpl/qpl.h"
> > +
> > +typedef struct {
> > +    qpl_job **job_array;
> > +    /* the number of allocated jobs */
> > +    uint32_t total_job_num;
> > +    /* compressed data buffer */
> > +    uint8_t *zbuf;
> > +    /* the length of compressed data */
>=20
> array of lenghts

Thanks for the comment, I will improve the comment next version.

> > +    uint32_t *zbuf_hdr;
>=20
> Why the _hdr suffix if the lengths are the only data stored here?

This zbuf_hdr is confusing, I will use lens instead of zbuf_hdr next versio=
n

> > +    /* the status of IAA device */
> > +    bool iaa_avail;
> > +} QplData;
> > +
> > +/**
> > + * check_iaa_avail: check if IAA device is available
> > + *
> > + * If the system does not have an IAA device, the IAA device is
> > + * not enabled or the IAA work queue is not configured as a shared
> > + * mode, the QPL hardware path initialization will fail.
> > + *
> > + * Returns true if IAA device is available, otherwise false.
> > + */
> > +static bool check_iaa_avail(void)
> > +{
> > +    qpl_job *job =3D NULL;
> > +    uint32_t job_size =3D 0;
> > +    qpl_path_t path =3D qpl_path_hardware;
> > +
> > +    if (qpl_get_job_size(path, &job_size) !=3D QPL_STS_OK) {
> > +        return false;
> > +    }
> > +    job =3D g_malloc0(job_size);
> > +    if (qpl_init_job(path, job) !=3D QPL_STS_OK) {
> > +        g_free(job);
> > +        return false;
> > +    }
> > +    g_free(job);
> > +    return true;
> > +}
> > +
> > +/**
> > + * multifd_qpl_free_jobs: cleanup jobs
> > + *
> > + * Free all job resources.
> > + *
> > + * @qpl: pointer to the QplData structure
> > + */
> > +static void multifd_qpl_free_jobs(QplData *qpl)
> > +{
> > +    assert(qpl !=3D NULL);
> > +    for (int i =3D 0; i < qpl->total_job_num; i++) {
> > +        qpl_fini_job(qpl->job_array[i]);
> > +        g_free(qpl->job_array[i]);
> > +        qpl->job_array[i] =3D NULL;
> > +    }
> > +    g_free(qpl->job_array);
> > +    qpl->job_array =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_qpl_init_jobs: initialize jobs
> > + *
> > + * Initialize all jobs
> > + *
> > + * @qpl: pointer to the QplData structure
> > + * @chan_id: multifd channel number
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_init_jobs(QplData *qpl, uint8_t chan_id, Error
> **errp)
> > +{
> > +    qpl_path_t path;
> > +    qpl_status status;
> > +    uint32_t job_size =3D 0;
> > +    qpl_job *job =3D NULL;
> > +
> > +    path =3D qpl->iaa_avail ? qpl_path_hardware : qpl_path_software;
> > +    status =3D qpl_get_job_size(path, &job_size);
> > +    if (status !=3D QPL_STS_OK) {
> > +        error_setg(errp, "multifd: %u: qpl_get_job_size failed with
> error %d",
> > +                   chan_id, status);
> > +        return -1;
> > +    }
> > +    qpl->job_array =3D g_new0(qpl_job *, qpl->total_job_num);
> > +    for (int i =3D 0; i < qpl->total_job_num; i++) {
> > +        job =3D g_malloc0(job_size);
> > +        status =3D qpl_init_job(path, job);
> > +        if (status !=3D QPL_STS_OK) {
> > +            error_setg(errp, "multifd: %u: qpl_init_job failed with
> error %d",
> > +                       chan_id, status);
> > +            multifd_qpl_free_jobs(qpl);
> > +            return -1;
> > +        }
> > +        qpl->job_array[i] =3D job;
> > +    }
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_init: initialize QplData structure
> > + *
> > + * Allocate and initialize a QplData structure
> > + *
> > + * Returns QplData pointer for success or NULL for error
> > + *
> > + * @job_num: pointer to the QplData structure
>=20
> This needs updating^

Yes, thanks for the comment, I will fix it next version

> > + * @job_size: the buffer size of the job
> > + * @chan_id: multifd channel number
> > + * @errp: pointer to an error
> > + */
> > +static QplData *multifd_qpl_init(uint32_t job_num, uint32_t job_size,
> > +                                 uint8_t chan_id, Error **errp)
> > +{
> > +    QplData *qpl;
> > +
> > +    qpl =3D g_new0(QplData, 1);
> > +    qpl->total_job_num =3D job_num;
> > +    qpl->iaa_avail =3D check_iaa_avail();
> > +    if (multifd_qpl_init_jobs(qpl, chan_id, errp) !=3D 0) {
> > +        g_free(qpl);
> > +        return NULL;
> > +    }
> > +    qpl->zbuf =3D g_malloc0(job_size * job_num);
> > +    qpl->zbuf_hdr =3D g_new0(uint32_t, job_num);
> > +    return qpl;
> > +}
> > +
> > +/**
> > + * multifd_qpl_deinit: cleanup QplData structure
> > + *
> > + * Free jobs, comprssed buffers and QplData structure
>=20
> compressed

Thanks for the comment, I will fix the typo next version

> > + *
> > + * @qpl: pointer to the QplData structure
> > + */
> > +static void multifd_qpl_deinit(QplData *qpl)
> > +{
> > +    if (qpl !=3D NULL) {
> > +        multifd_qpl_free_jobs(qpl);
> > +        g_free(qpl->zbuf_hdr);
> > +        g_free(qpl->zbuf);
> > +        g_free(qpl);
> > +    }
> > +}
> > +
> > +/**
> > + * multifd_qpl_send_setup: setup send side
> > + *
> > + * Setup each channel with QPL compression.
>=20
> s/each/the/

Sure, I will refine the comment next version

> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
> > +{
> > +    QplData *qpl;
> > +
> > +    qpl =3D multifd_qpl_init(p->page_count, p->page_size, p->id, errp)=
;
> > +    if (!qpl) {
> > +        return -1;
> > +    }
> > +    p->compress_data =3D qpl;
> > +
> > +    /*
> > +     * Each page will be compressed independently and sent using an
> IOV. The
> > +     * additional two IOVs are used to store packet header and
> compressed data
> > +     * length
> > +     */
> > +    p->iov =3D g_new0(struct iovec, p->page_count + 2);
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_send_cleanup: cleanup send side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error
> **errp)
> > +{
> > +    multifd_qpl_deinit(p->compress_data);
> > +    p->compress_data =3D NULL;
> > +    g_free(p->iov);
> > +    p->iov =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_qpl_send_prepare: prepare data to be able to send
> > + *
> > + * Create a compressed buffer with all the pages that we are going to
> > + * send.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp=
)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +/**
> > + * multifd_qpl_recv_setup: setup receive side
> > + *
> > + * Create the compressed channel and buffer.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    QplData *qpl;
> > +
> > +    qpl =3D multifd_qpl_init(p->page_count, p->page_size, p->id, errp)=
;
> > +    if (!qpl) {
> > +        return -1;
> > +    }
> > +    p->compress_data =3D qpl;
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_recv_cleanup: setup receive side
> > + *
> > + * Close the channel and return memory.
> > + *
> > + * @p: Params for the channel that we are using
> > + */
> > +static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> > +{
> > +    multifd_qpl_deinit(p->compress_data);
> > +    p->compress_data =3D NULL;
> > +}
> > +
> > +/**
> > + * multifd_qpl_recv: read the data from the channel into actual pages
> > + *
> > + * Read the compressed buffer, and uncompress it into the actual
> > + * pages.
> > + *
> > + * Returns 0 for success or -1 for error
> > + *
> > + * @p: Params for the channel that we are using
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
> > +{
> > +    /* Implement in next patch */
> > +    return -1;
> > +}
> > +
> > +static MultiFDMethods multifd_qpl_ops =3D {
> > +    .send_setup =3D multifd_qpl_send_setup,
> > +    .send_cleanup =3D multifd_qpl_send_cleanup,
> > +    .send_prepare =3D multifd_qpl_send_prepare,
> > +    .recv_setup =3D multifd_qpl_recv_setup,
> > +    .recv_cleanup =3D multifd_qpl_recv_cleanup,
> > +    .recv =3D multifd_qpl_recv,
> > +};
> >
> >  static void multifd_qpl_register(void)
> >  {
> > -    /* noop */
> > +    multifd_register_ops(MULTIFD_COMPRESSION_QPL, &multifd_qpl_ops);
> >  }
> >
> >  migration_init(multifd_qpl_register);

