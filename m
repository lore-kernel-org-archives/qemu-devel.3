Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEEEC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 04:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7P9-0006cN-Av; Tue, 23 Jul 2024 00:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7P4-0006bg-25
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 00:45:34 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7P0-0006wd-MU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 00:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721709930; x=1753245930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=riaV866q+wBmB7AYjQ4DIYMokmsh5XTLNtJ/YFZEJW4=;
 b=DRzIGZWlrKWjppvYeT+jLztrppznkSlsPUaj7ewiO9jp/SVvxdlyzjs/
 r98Vsa0QiOBQ7AlOMml9sa7ejQ0oLBvnE1EbYUqBjQwJS3w+E8pxzTL9m
 n1qqantEztb9HfiM9TSA0azhd0NwmmMBNilz4nm9iyTeqt2yItkXRuu1D
 AeKofcec8a03Fw4obWcnmSYZk+f8TKVgOSpin0olWEnVh2OycLY00zlJu
 MLiqJli4kxbiGNj7HParnSqq+MV4DlkdGAK7KiFbbr2gQgxk569IyChRL
 gN/tTcdyU4FRsb7Q/vLgihQZPLwBN6GTrcHS/Xt1y9AVbuph7DYjrXPO8 A==;
X-CSE-ConnectionGUID: nJk6sWBcQ5G+l1l9K5GtPA==
X-CSE-MsgGUID: F0uCbCIRTO2naRlRtoT44A==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="29899142"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="29899142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 21:45:28 -0700
X-CSE-ConnectionGUID: q62LbNn7SRecz0WZgx6VPA==
X-CSE-MsgGUID: H2H6Mkb/T9ehT1QLRk0dpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="51757994"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 21:45:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 21:45:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 21:45:27 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 21:45:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grH4OKxw70SYdgB3CcffsakYOhlP3jLP32JhI5l1fwnVV6bJxnss3X3qPuDnH+6fJHniCDudVctUfO0lQxc/T0fGSJ/d00vSLOwlvt+5m1v3zXEkVeXwXTHdGlRqhVAQBtfKWzFSdk0s2CqGSH0WJR1Nzc3gK/OUg7Tx//N+o0z47RD1YQheNE9erymLLy8TmZfTEyIRu2gfRj3+RRFui0LoLLZLlpn4WgfJ33cEkFfLIk1FlRIwPz+dUkv447faRC0BYV4VqUy/WQt4IecUTb8WKgPSl/agW3VaJFZtxSHP+zgvAScDOwqmB/6iw2FVwXlqgNPLaqPsrPqvQQ+zwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWd1KuY1yRagslxm5xkkmHsA3gt/fw3gzpJsClwjmiA=;
 b=X3oirtO7ir3VM5B4veZ2qZRF3U+EZ6RvgfrZXWzJ1ba56qxqr1x0ceDxlGVDCrlNdXdV9xCAk+4aKj2waNNDykm613HR5gPbCE/IS4pIGHC8PPc5mm5Td+YP+ohy28dFgbfhwpNpU1EDFZfAMnQvkLNSbKQcHNqqu2Oufnf3QTOH2xiFr6ZiuVCdTrVBTdjb8uBqdhlX523GTF2314BnZZ+gFky77i1gKmT8LGfKuZBRSJpTO5fxADVv4mo6ty78LrJrix9HZjvWtToKgv2VmP71VyU3t5PUJZntDFMn5ngVNN2vGaKl9ICVVnxHHAANrAy1XN8eFgiMyKrbCYxYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 04:45:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 04:45:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v6 8/9] vfio/migration: Don't block migration device dirty
 tracking is unsupported
Thread-Topic: [PATCH v6 8/9] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Index: AQHa3HwtxjszDE/5v0q3GgUuZtAHqbIDvS3w
Date: Tue, 23 Jul 2024 04:45:25 +0000
Message-ID: <SJ0PR11MB67448DA5D4BC087B46CC84D092A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-9-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-9-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8210:EE_
x-ms-office365-filtering-correlation-id: d5de6f39-4990-4069-dd5d-08dcaad244f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VBIc2mPwhqNjZ0CgNOvt7e9y84ZbzVAYQizpxPdLadn+MnhGLRbrCT5oNN87?=
 =?us-ascii?Q?iaMJHpfG5Az/pD8PEL7FapxojfY0/puSg+BLaPQoP6eKfjl1SQAAUG+xRgY4?=
 =?us-ascii?Q?r5HutSxWv5IwewLde6Omot0wO1/NbnwrI1vu1VNrEJQ1VTZuh/GOlBKkTDoj?=
 =?us-ascii?Q?7hh2CVmvHvJf5NmzY4kggPCbpq5G4stA4CFcMqTiXnFyWifcZJrybbCZl21N?=
 =?us-ascii?Q?oVLT+Wj2pMiNSM6vUs4C7RDRkyYpdbBjEVPFNw+WhFSGz18q0PJKDwS6Eb5i?=
 =?us-ascii?Q?RbVekjDnBYykhjYllKWnTN0AXa9KMFO1iJMvX45ZyLohHsfkAl9Ppx4/lvNq?=
 =?us-ascii?Q?J03/5OOBMPL5XyNo3tgzn3X2vN/3fsSSmS04ulfHmgZdfQdEU+lBgfFOymPC?=
 =?us-ascii?Q?rMpPrhk+qoZ/QJg723XRQgLFDOCC0wOpSBY+o2LfTACTce0hEMepCRDky/7n?=
 =?us-ascii?Q?uJgQdeRxhuh2oalkxHTUi+HGxvq5Gl2oQHtVmvVly7wkfqTaWQ55WdXkGquE?=
 =?us-ascii?Q?WKrMCC49lz0P4hrAc8fKyiwiCrfIFeebdzEbpSD7kNJkQ4de7vWq5mKYNvu8?=
 =?us-ascii?Q?sGZLXB9DRWDT9tC/poOWpyGmnyjCV1i2xIwuN5uz5zqGxxeI1pF1eXohXsKZ?=
 =?us-ascii?Q?kWFdxilvohe7VV2/DxdwV/wJuWG2Jt3jTdSWeSp+SPJ/aK1Qz/OzMPXQ5xC+?=
 =?us-ascii?Q?yDUzizIehg5riQBBGMU51GB3vP4atGtNOBFfAvzxZIjcP3cgfbszpwpScVAr?=
 =?us-ascii?Q?m6fbg4tlbT8QLyqnq7QgkSI0BOIlaMh0Ca+aIrRLw/X5vcHN8RmDEULQYylh?=
 =?us-ascii?Q?pIbnzTWzTRxasiJYXX/Nv2b0DAAGXCamFs7es90w+Ix1P4yWiOyw6WGXTB2T?=
 =?us-ascii?Q?vsc7plXBbak1PTufUXlVJ2tW6ccnfoeeEtXHM57IOzJoy1JXC2dyDmrrtdcK?=
 =?us-ascii?Q?TyUmW8V/5UEeh7MjfuMnJzcdKjBpSN90q+uWbePFamtIxVzQkImTtg7r14EK?=
 =?us-ascii?Q?LiqixOdhco1KXSrUD8aaDLW0gE4KgFntngxtVmOQs9nGfaOBRno+oB1WV7yB?=
 =?us-ascii?Q?doiANOfvYlzLi8ThaXo5b+ac+digVYlKYj0XtJnSPoke+pCk29gTknESePx+?=
 =?us-ascii?Q?JlVvJxGpY5RkrhF18uV4d5H7hpDCM/IawKKn5XxYJTC1siLzXj8iZ0khg/4T?=
 =?us-ascii?Q?SCwjcl23VmuGSMd/dsbIKWhCB2hBebxjN6D9lZv6+HgycZ2nTrq6L113vUSr?=
 =?us-ascii?Q?ZmMbT4695kNLh5/ufMROfFR+HxLA1cLje74Kewqj0inZrXcm3k9op1rn9wBF?=
 =?us-ascii?Q?MixqrpNwxlfKeU2jlXQHXntsAeMO47UmvAw/+UN0ckPtGkCckFRweehJDllh?=
 =?us-ascii?Q?3oj5QG0rEmUa800GRcCCc75WjkevmBs5IOeuaBFljZlfSxadWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F8rSFtSi8YB+xsSXAmuYaHx+uSHqyQwcepmtnVFC0zekkjNC8efw4/nvrwER?=
 =?us-ascii?Q?VPM51QG0dQXSwjo5aAHQa2qZxhXoAe6DQ3E9LGuY5sz3DoOmlP1UFQpo2rMa?=
 =?us-ascii?Q?0ypTC2z9N6Spyo0VMBGRPigFkIpT0mLw0Wf45/sL5zAwD/plv/AvxFeA+O+8?=
 =?us-ascii?Q?DNM17ljDE6qpUYTVkKlR9TBLxtXb8duH9HzOsVqQOom6J8bBynOuFhmPATDj?=
 =?us-ascii?Q?JgmFHhqFwy6dQ2+U3c53lGnY253UbXWQHlesk1gZfXD+khwJko3o4TIGKSms?=
 =?us-ascii?Q?xvfrABa5+9AdWJHXXHuLmaoUGE034r9L73TqF2lBbhx0Io4nxP2yI069/ED4?=
 =?us-ascii?Q?Va/q+DwP/+dnccAZRnNrqO5jp7F7C3hg/hr7741CwOr/I779cl6enpOM0wPu?=
 =?us-ascii?Q?1/+j3UgRWsxrPTDVxR5qgEvDHbfuVbm2EWCD2+ubD8nmYVARUX2mI8RC8QiL?=
 =?us-ascii?Q?F7Ks2JKMnoZ6umxYKO2lmQCWSU9QH2SolaTcUThlGNuVkiVFvLLraPvckBCY?=
 =?us-ascii?Q?aUol5emWj0HIjAyKoNGWB1DIZJK3GUOXvyJJQr63nccrewvNxqVvqiYLMsgu?=
 =?us-ascii?Q?QSZhKkwz3QoSnvhqHfI7O41kPEXmChdiwtODZik8bXzwZ60w+u31M0B6lvqg?=
 =?us-ascii?Q?rsqs7fwMWcO0tZOBgrqVjCcRDCRdt0pjgA5wddw5Cjcwwg69/yYg0SuQ50xL?=
 =?us-ascii?Q?Db6J6rqHa4dZ6yuFos4e8K3XpJd4PtFoDkPqzOaKTABySqyzYNGNYdKLi+Vb?=
 =?us-ascii?Q?5dcbwS9CaAB+XdHOoVYgYcKlzcwuf4MXsKyDoAQ8sQkXXNhT2elxDp202a3b?=
 =?us-ascii?Q?zdat1pFNdHrvWBfpNsLOPdQTVVs/86oTDR4RWUbmZSV5f/M0KAJGHtiLYzR1?=
 =?us-ascii?Q?ML4eJswhadu2nl6+E9BUFLxq4OV86aaylIrb17VWOXcVIDE9I2+T7nRMFOfr?=
 =?us-ascii?Q?JDDXrzTImrXoHcQ7lReZppXB4ZLJ9VqBROfgxK0szk8et6GbCNbGw/IohCK+?=
 =?us-ascii?Q?cN/VvXDfzT6/LNFNSX0icZhXLnrefQBGMK4eenKr0FH8etSxwoyIViwGYRjP?=
 =?us-ascii?Q?HvUaKViDU1TJbSBufSASwwN7sSj9/qXBEkv8jdvsb5+TIdP0dJs3zTEURHAd?=
 =?us-ascii?Q?F9+PtLZ1lbz8eDywZpT0Kh+1DToFuoWsYiY0IUw1hdm7sbTm60KXlt0St/9t?=
 =?us-ascii?Q?q/XYUQtmfdQchGoIYa1ke/46dpSPSgZULGlyW3V41nz7iSRg1mE8PMO6+8eJ?=
 =?us-ascii?Q?Ew5ijYV0Zhkeq49Pei7hUoNzUM6HkHjA9A5R5rcEWrWYIMZBYTpGIsfCsZDG?=
 =?us-ascii?Q?rC2GN94HE0pzQ3zDORbegOODws22gJLxgHXUtlPqbqpvHqowvMOUNAfO6EOK?=
 =?us-ascii?Q?9aQPU0Sv6xZ4CWsom8x2EHoZqi3H8ORtBLZt3rW7RmXJ+tLoSywWvyOUph2N?=
 =?us-ascii?Q?02ZDsxlwqFalbmGKTuNmbUkGTYvpMWHWyZGcV2JUHFJ/TYrYtVrsve+veF+A?=
 =?us-ascii?Q?iU4LxfzprRUGwaBTfFnAD9b699ssdG3vp8aIws3fDPKnLYwR/Tt1mGYXNPlP?=
 =?us-ascii?Q?Lh+N4k2Z27/hGKKOyUQjS5D2dPULSX+5AHXNgvYP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5de6f39-4990-4069-dd5d-08dcaad244f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 04:45:25.5990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEgDjL3ZZolh0Ju70HZJ0c2mOwZP6WX4JwANaLokxb8COPlV2k91u7C+VPvF+GOY5cIqMYkUmeO0F7wTMR1wTGx0SphR6dV3EbUtKfpUMr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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



>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v6 8/9] vfio/migration: Don't block migration device dirty
>tracking is unsupported
>
>By default VFIO migration is set to auto, which will support live
>migration if the migration capability is set *and* also dirty page
>tracking is supported.
>
>For testing purposes one can force enable without dirty page tracking
>via enable-migration=3Don, but that option is generally left for testing
>purposes.
>
>So starting with IOMMU dirty tracking it can use to accomodate the lack of
>VF dirty page tracking allowing us to minimize the VF requirements for
>migration and thus enabling migration by default for those too.
>
>While at it change the error messages to mention IOMMU dirty tracking as
>well.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> hw/vfio/migration.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>index 34d4be2ce1b1..cbfaef7afffe 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -1036,16 +1036,16 @@ bool vfio_migration_realize(VFIODevice
>*vbasedev, Error **errp)
>         return !vfio_block_migration(vbasedev, err, errp);
>     }
>
>-    if (!vbasedev->dirty_pages_supported) {
>+    if (!vbasedev->dirty_pages_supported && !vbasedev-
>>iommu_dirty_tracking) {
>         if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_AUTO) {
>             error_setg(&err,
>-                       "%s: VFIO device doesn't support device dirty trac=
king",
>-                       vbasedev->name);
>+                       "%s: VFIO device doesn't support device and "
>+                       "IOMMU dirty tracking", vbasedev->name);
>             goto add_blocker;
>         }
>
>-        warn_report("%s: VFIO device doesn't support device dirty trackin=
g",
>-                    vbasedev->name);
>+        warn_report("%s: VFIO device doesn't support device and "
>+                    "IOMMU dirty tracking", vbasedev->name);
>     }
>
>     ret =3D vfio_block_multiple_devices_migration(vbasedev, errp);
>--
>2.17.2


