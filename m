Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52084C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 06:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78Ft-0003nF-QT; Wed, 15 May 2024 02:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s78Fo-0003mr-A3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:36:45 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s78Fk-0007OJ-Sg
 for qemu-devel@nongnu.org; Wed, 15 May 2024 02:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715755001; x=1747291001;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fbPYNQG/wpLTWsNlQe/LGRtMmrNVpXY+XM5EWR1suvY=;
 b=lmbspqDy2iVzJhwSvfulyaHFnJMteC8n0I6qomtjcMlPHz9i8zj1zLQb
 wc3vh7/bUOdAmg/SGWCABQacoguopGu7kQZMcoFVhTnR4bYf6imI8fY9y
 J9Bwmz+NeEQSQe0HM4KD2iHY4t4FWOxdznUU40T1oDW8pQpGvGpS27gfk
 2QHxVF36bTiLEwMGEes58ufGcwsqSL0jWaFqcYlaSPI33VXRJZxTcqHG8
 1tRSk3JnbbXPsDeehbpbqMN95TVZEL/h8AsRGm3SGRzweK81wuBoTWQHo
 AGTmDqyTI7JNFVtgsflHFOi9NuVHjGas3RgAX/KCDvKAwiDcMeseusq6o w==;
X-CSE-ConnectionGUID: 5Lcs4+UVQvqVY5OoKbQ9ow==
X-CSE-MsgGUID: fOSlk93DRFO13udfPzeX1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="37157398"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="37157398"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 23:36:36 -0700
X-CSE-ConnectionGUID: FCNKVZxDTgWtGZV85/ESMw==
X-CSE-MsgGUID: PBJWCEqURyq9mzfSf9n0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="35417699"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 23:36:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 23:36:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 23:36:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 23:36:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yhjq5/EPvuF/nLId4NzMHwXsYhRhm+veAd04mrq5jMWFZoo9GeKdulVY91b0bro20dnte7pLg7HiroNIeJGzzhhObcN6A8BXYM8bqidR5O2gpNbLyxChUJWZZFmR3t99wIXp/lwVEUwfZ8vTaT10eBd3N48fO8RZtryiVvlQuU6Dpa5f1+UrkzkDmMoUQOTdobuLLOdHaZWnYZhp4UsbWo56YiZKZMow9J2UepyOZL3XWIkUxmzhyH+wjxjTTBRjJZ2PvuC17Hf+BRqSuY6J33FFWn3ToydGH9eMwdZAFHdJuy24/nt6Bzy/CjJM8yDGKZRoPzW+ooipG+f9ypzOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2zv+fizl0as6vghNuaUZI+rjXSveh/9PafxxLxWLuQ=;
 b=arMddB/Zcqf02DrKN9bwuRT4G+CtHLDfh0bvspK/KdQ2Rj6KrtEZWqKYFifQIBgF0JsXa7e9gomAIbtqzdRU8Uoozb9XCpIoT2YZQTPmlXGFmGeJ+0U/7HmkILu4O1DQkR4mvGGTHKvJXYX8HrQ5z97qt5JoXRAQN0G3MqksZGjoa7y5Swqq/n0pQqcoG3c5kraigeRkcWE+m2OExRhCRVlqrdRsq8y+sXldoENu6apCjzf/cGSjExqTwtFuR9AvlffT/2KFT9r/6chrFnZhpw55Mvt/5aCSztDCkCvm4uQUQVoonBvqca8UH0JJnGAVUyErFVRyvAE6FtjSV9SeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 06:36:31 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 06:36:30 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Topic: [PATCH v6 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Index: AQHan5HVP8olQmturE6meoKKc24AObGVUR6AgACpysCAANZHgIABD8QQ
Date: Wed, 15 May 2024 06:36:30 +0000
Message-ID: <PH7PR11MB5941F37E2F3E3B4D6DCBA7FFA3EC2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-7-yuan1.liu@intel.com> <87ikzhg2xq.fsf@suse.de>
 <PH7PR11MB594145F081617DC668B59343A3E32@PH7PR11MB5941.namprd11.prod.outlook.com>
 <87ttj0ebao.fsf@suse.de>
In-Reply-To: <87ttj0ebao.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH7PR11MB6651:EE_
x-ms-office365-filtering-correlation-id: 1d991086-2534-40c7-7aba-08dc74a95b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hOHmqOgF0pojy8cRpjDAmLK+3ErZmuwTNavNQcSxm9BWqgE46+kJOxVvTR/X?=
 =?us-ascii?Q?K0mBBQN1am2j4PO4NTrhLNP+GHqUMX98SgeExx6EynSCuT771onUN0x1MEU4?=
 =?us-ascii?Q?X09ebKUrWJG247cSwmlCvHw/otzCltwoGqh+stzOwOSN1hO3zR9UOR3rSEyi?=
 =?us-ascii?Q?3j2QP+/D9d1zaic0mQ8oeyI1w1WmQviDWTS/7uPsKdtuG3jhOR4tZ5ve5Z+n?=
 =?us-ascii?Q?RPYNqqFVx88EglXxAP+rFt9fW5VtvpK1+q2hHiZ0atmHIjub/cMp2al6zZSP?=
 =?us-ascii?Q?dvtMtms6h+2B/j7kx960kxeaKblE4j5AxUmFto85qJEAbb1HE49ouiFNnlEX?=
 =?us-ascii?Q?z+U+GLp/VQ5fqSJ/3Cjd76o1uzhurn2w0K1tF1cpZ92DO9HHg97t9csSAjXr?=
 =?us-ascii?Q?/zIyrA8OY+QZbZpoWRMrik87Ci9Cn+If3sHji8xiQ5rgRz55uZnfJUiwh3Ui?=
 =?us-ascii?Q?sl3YNOfZiuczgjwdyqbBINVHOklI+AvboYRXN6twcwNmhulg7dW19BxzlEgU?=
 =?us-ascii?Q?M3BHCoh+DOa29qEV0ti7Z3RxYPRtHWj+ElAMHgp2LwFkDYWlZ6dUhFBDchnc?=
 =?us-ascii?Q?d7cVKG2oMFALw7MEG/p50SUvF1dtmuQod9sxE0Y8BW3W/IOtop33Ee6GLly+?=
 =?us-ascii?Q?jeROv7yB0twNksW4olYj2OEyrTrG8TgmEDB0eKR3i4TJIgP2VSJIzZMKwoJV?=
 =?us-ascii?Q?r0FqAW5FOcWiYYqLiYf3wAhEjgNuDtyHi7beJGzBhb1R2yXUeDPyOmwQAR+p?=
 =?us-ascii?Q?F2X+xpt1MwCzsNb22QQHRScuv5uq610YzhZ3ekAunMeYfQLYY3iLae1z+RRS?=
 =?us-ascii?Q?HwaxSRC0tyO7Hpk/FnZ5XVg31senwJjl4NFXrZaJMuea5hMnLP5qNlPvE2Gc?=
 =?us-ascii?Q?zBijjY7oITKrWVHyhqa4tC6cUo3xgLSI5RwV/7AzfRquInR/I7Zl/cMzbbfH?=
 =?us-ascii?Q?EIlK930uXsIU+YIlJ5J0x/19lPwaHW3aeloMOg1wqTW0Z6AHRTKbZTEufjic?=
 =?us-ascii?Q?R2x0qrqg4LwJaz2DeWnnAEf0pwtfzgQZd1n3o1zyXdni5U0dXgvJcUphNE+0?=
 =?us-ascii?Q?oyZOz6RyibWoqmJaWpX65c54XDvrqmfM/aOagBCz0Mm/REu/KsPhsXwwAcnh?=
 =?us-ascii?Q?0+VuHk2MWMz9NirN1d5SlbnW9nPOvKqqfo9Y4281hRW8SXpPXfzpzMQOq1u+?=
 =?us-ascii?Q?Uet9fmRnAZTZ3sLxDNpmkTEBYdks/3z/4PhSDfl5myvOt+5cWq45zh4SfyZp?=
 =?us-ascii?Q?ECfVw9q/AQUGnvzyeLD2fAzOs5BR3fzB8xYtdDCG0RYtl0ITcenMIPIvwRJ9?=
 =?us-ascii?Q?n8vGMZi8NKRwkHVut15mC7q8+oZi4Vy3K+1hbi+EqVjnoQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?URoDWXriJiUKwhz/rgwEGosXByo/8M/IG2BQD9ZEBxGpIZR54CdAca+Z/JBt?=
 =?us-ascii?Q?sZyF1CRu5xlq8+NghU/ti9mAQZErh8XAWnGca1oW0IW7iogHzYJ6/tRqQ2VV?=
 =?us-ascii?Q?ThzXHq0vEJLJNv3v18Ao45EhN11lC/HkgBiJ8NmKuDgqttmcMKiQd4MdsiCF?=
 =?us-ascii?Q?Tb0wDQoA0ZgMbnB4bSI8V0ZDaP4LkAn9kuwqTqV0kmA/vn888TPmRBCwPTZ0?=
 =?us-ascii?Q?xxyQBJClCJOW6zaEiNnzBe8ixe9Cq//HMx6kEZ8woQXj7WOcGSALoYWA2gcI?=
 =?us-ascii?Q?87Aer3/l5kcX2P4zDJZuRVEe8+6zPspT6wVlymYkJprBCNEj8FKuSzK63RmA?=
 =?us-ascii?Q?aiDv2r+vGsSLp4S26KldySDb8O5pZzNudwWhJPXiec/VcfkDCGXti/sVN4ld?=
 =?us-ascii?Q?GgaFVHx7qCrU8eum7BRV2VBSvAigoTeGGUoS8a8H8USAhADOsodKr80gnkCn?=
 =?us-ascii?Q?VPfbTBzY9iQnKPZioN2LnzvB6yTDObjkmFb/MlmpB+U53+g3+nLkwigeaNEh?=
 =?us-ascii?Q?3V2O96T02MSw+HKr7OAgN0HRh3uQf5L+oPdAeJ6opVx0LB8AWJt3fFGUL9Nf?=
 =?us-ascii?Q?sG6qTiG2HkfwS1kb1Bz7NPtYZOWGiGer7C1ym2pp0uB5qqv7kT65zOQ+6yLK?=
 =?us-ascii?Q?dkuXriWF3tGCfSyMqy41ykyamriBWbNS9q+G6l5riW7/5AZyU8di0GyNbEOA?=
 =?us-ascii?Q?BYa1hCDRLxwL1xMXPeLXL6WD0OXixGU45D3lOCStR277ssA6bp7FeJ01DpVE?=
 =?us-ascii?Q?sKU8gM/UksShsJ98ubDypzX0fqjHX9yPXYvYiMvCc8y6bo/MnFEiQPYoU3j6?=
 =?us-ascii?Q?1q4p1XtR6zkVjmZOOwoQKWuv3+PKTpYbtnTfEksBpYQKWLd5F3MydpFb/QG9?=
 =?us-ascii?Q?AI4/E8gqW5T1okOIMvlzPTLsH+GRdgoBrkoUAh1Gefs9Z1AltgGVtSErHB+I?=
 =?us-ascii?Q?DZ/KIRxcYS6y5RZwQd4pez0tONvcpmoQQ83CIymOPXWoGJwLCopoa8SMaq2Z?=
 =?us-ascii?Q?Zk1tqnKgD1ypSsanUYw+1O2zPb05ML8xa5yYujTH8dzzOazfS+Tht8eu0Yd/?=
 =?us-ascii?Q?vU4FmervNEvnPy8PkCR/Jf61bx9XNpnmWHMB8ZorDMgnFsMHp8ioPBInxJeu?=
 =?us-ascii?Q?64R50PbnoZf0/E/iMObwpoP8Jf0Sj6yG1AheVzzJa/wNQbH7oM7v6Pl0fL87?=
 =?us-ascii?Q?dL4QyS/4UBEFhNCN6Z3dzzG94lfIJR+ciu8MaaRL6PWsCLtaCzVJAp/z8F3C?=
 =?us-ascii?Q?e32PMrIVGqBDtYmB62gXROAlsgpMVIZXBteqLFPaFN5g519KW+7Rjvw/lDg9?=
 =?us-ascii?Q?btBgdzykxh8+Tfz1ix91TU1sn+JyBs+CmWoDSk/13NqNOHna78G7nRLEI82g?=
 =?us-ascii?Q?yuyz2uLBbuTP4NF1HG0vZ8+0wXUBN56DZo01TVIuZNp2qR4mhUXNkfEW2RGa?=
 =?us-ascii?Q?wMq85iA1PuCD/MK7g5iVG4TQ0P1Jiaz8y60RQPLtYgz7xJUDsqu9X0QJQyrz?=
 =?us-ascii?Q?P+RAfeLAPr1lVmNLSD/K+ZEZumvLIelhncIDD5qBRTGcHsREBvAQARznKz9l?=
 =?us-ascii?Q?E5wHItMg8YvQEuHrPDMpX6/dA5ZDiEDf0glRz9Az?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d991086-2534-40c7-7aba-08dc74a95b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 06:36:30.7709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nr0yAMzpy0olqRammQ+xd6BhsVkyVBji1I/QS9WA9Drj4Y9hVPRPIun9Fn7CL3PaLU44Af9lgfqykvoY6/5+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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
> Sent: Tuesday, May 14, 2024 10:08 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; Zou, Nanhai <nanhai.zou@intel.com>
> Subject: RE: [PATCH v6 6/7] migration/multifd: implement qpl compression
> and decompression
>=20
> "Liu, Yuan1" <yuan1.liu@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Fabiano Rosas <farosas@suse.de>
> >> Sent: Monday, May 13, 2024 11:14 PM
> >> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> >> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou,
> Nanhai
> >> <nanhai.zou@intel.com>
> >> Subject: Re: [PATCH v6 6/7] migration/multifd: implement qpl
> compression
> >> and decompression
> >>
> >> Yuan Liu <yuan1.liu@intel.com> writes:
> >>
> >> > each qpl job is used to (de)compress a normal page and it can
> >> > be processed independently by the IAA hardware. All qpl jobs
> >> > are submitted to the hardware at once, and wait for all jobs
> >> > completion. If hardware path(IAA) is not available, use software
> >> > for compression and decompression.
> >> >
> >> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> >> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> >> > ---
> >> >  migration/multifd-qpl.c | 284
> +++++++++++++++++++++++++++++++++++++++-
> >> >  1 file changed, 280 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> >> > index 89fa51091a..9a1fddbdd0 100644
> >> > --- a/migration/multifd-qpl.c
> >> > +++ b/migration/multifd-qpl.c
> >> > @@ -13,6 +13,7 @@
> >> >  #include "qemu/osdep.h"
> >> >  #include "qemu/module.h"
> >> >  #include "qapi/error.h"
> >> > +#include "exec/ramblock.h"
> >> >  #include "migration.h"
> >> >  #include "multifd.h"
> >> >  #include "qpl/qpl.h"
> >> > @@ -204,6 +205,139 @@ static void
> >> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >> >      p->iov =3D NULL;
> >> >  }
> >> >
> >> > +/**
> >> > + * multifd_qpl_prepare_job: prepare a compression or decompression
> job
> >> > + *
> >> > + * Prepare a compression or decompression job and configure job
> >> attributes
> >> > + * including job compression level and flags.
> >> > + *
> >> > + * @job: pointer to the QplData structure
> >>
> >> qpl_job structure
> >
> > Thanks for the comment, I will fix this next version.
> >
> >> > + * @is_compression: compression or decompression indication
> >> > + * @input: pointer to the input data buffer
> >> > + * @input_len: the length of the input data
> >> > + * @output: pointer to the output data buffer
> >> > + * @output_len: the size of the output data buffer
> >> > + */
> >> > +static void multifd_qpl_prepare_job(qpl_job *job, bool
> is_compression,
> >> > +                                    uint8_t *input, uint32_t
> input_len,
> >> > +                                    uint8_t *output, uint32_t
> >> output_len)
> >> > +{
> >> > +    job->op =3D is_compression ? qpl_op_compress : qpl_op_decompres=
s;
> >> > +    job->next_in_ptr =3D input;
> >> > +    job->next_out_ptr =3D output;
> >> > +    job->available_in =3D input_len;
> >> > +    job->available_out =3D output_len;
> >> > +    job->flags =3D QPL_FLAG_FIRST | QPL_FLAG_LAST |
> QPL_FLAG_OMIT_VERIFY;
> >> > +    /* only supports one compression level */
> >> > +    job->level =3D 1;
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_build_packet: build a qpl compressed data packet
> >> > + *
> >> > + * The qpl compressed data packet consists of two parts, one part
> >> stores
> >> > + * the compressed length of each page, and the other part is the
> >> compressed
> >> > + * data of each page. The zbuf_hdr stores the compressed length of
> all
> >> pages,
> >> > + * and use a separate IOV to store the compressed data of each page=
.
> >> > + *
> >> > + * @qpl: pointer to the QplData structure
> >> > + * @p: Params for the channel that we are using
> >> > + * @idx: The index of the compressed length array
> >> > + * @addr: pointer to the compressed data
> >> > + * @len: The length of the compressed data
> >> > + */
> >> > +static void multifd_qpl_build_packet(QplData *qpl, MultiFDSendParam=
s
> >> *p,
> >> > +                                     uint32_t idx, uint8_t *addr,
> >> uint32_t len)
> >> > +{
> >> > +    qpl->zbuf_hdr[idx] =3D cpu_to_be32(len);
> >> > +    p->iov[p->iovs_num].iov_base =3D addr;
> >> > +    p->iov[p->iovs_num].iov_len =3D len;
> >> > +    p->iovs_num++;
> >> > +    p->next_packet_size +=3D len;
> >> > +}
> >> > +
> >> > +/**
> >> > + * multifd_qpl_compress_pages: compress normal pages
> >> > + *
> >> > + * Each normal page will be compressed independently, and the
> >> compression jobs
> >> > + * will be submitted to the IAA hardware in non-blocking mode,
> waiting
> >> for all
> >> > + * jobs to be completed and filling the compressed length and data
> into
> >> the
> >> > + * sending IOVs. If IAA device is not available, the software path
> is
> >> used.
> >> > + *
> >> > + * Returns 0 for success or -1 for error
> >> > + *
> >> > + * @p: Params for the channel that we are using
> >> > + * @errp: pointer to an error
> >> > + */
> >> > +static int multifd_qpl_compress_pages(MultiFDSendParams *p, Error
> >> **errp)
> >> > +{
> >> > +    qpl_status status;
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +    MultiFDPages_t *pages =3D p->pages;
> >> > +    uint8_t *zbuf =3D qpl->zbuf;
> >> > +    uint8_t *host =3D pages->block->host;
> >> > +    uint32_t job_num =3D pages->normal_num;
> >>
> >> A bit misleading because job_num is used in the previous patch as a
> >> synonym for page_count. We could change the previous patch to:
> >> multifd_qpl_init(uint32_t page_count, ...
> >
> > Yes, I will replace job_num with page_count for multifd_qpl_init next
> version.
> >
> >> > +    qpl_job *job =3D NULL;
> >> > +
> >> > +    assert(job_num <=3D qpl->total_job_num);
> >> > +    /* submit all compression jobs */
> >> > +    for (int i =3D 0; i < job_num; i++) {
> >> > +        job =3D qpl->job_array[i];
> >> > +        multifd_qpl_prepare_job(job, true, host + pages->offset[i],
> >> > +                                p->page_size, zbuf, p->page_size -
> 1);
> >>
> >> Isn't the output buffer size =3D=3D page size, why the -1?
> >
> > I think the compressed data should be smaller than a normal page.
> > If the compressed data size is equal to a normal page, send the origina=
l
> > page directly to avoid decompression operation.
> >
> > If the output buffer size is set to p->page_size, the compressed data
> size
> > may be greater than or equal to a normal page, then there are two
> conditions for
> > sending a normal page, one is job status =3D=3D QPL_STS_OK and job-
> >total_out =3D=3D p->page_size,
> > another is job status =3D=3D QPL_STS_MORE_OUTPUT_NEEDED.
> >
> > If the output buffer size is p->page_size - 1, only check
> QPL_STS_MORE_OUTPUT_NEEDED is ok.
> > I will add comments for this in the next version.
> >
>=20
> Thanks.
>=20
> >> > +        /* if hardware path(IAA) is unavailable, call the software
> path
> >> */
> >>
> >> If we're doing the fallback automatically, isn't that what
> qpl_path_auto
> >> does already? What's the difference between the two approaches?
> >
> > The qpl_path_auto feature currently has some limitations.
> >
> > Limitation 1: it does not detect IAA device status before job
> submission, which means
> > I need to use qpl_init_job(qpl_path_hardware, ...) first to make sure
> the hardware path
> > is available, then qpl_path_auto can work for software fallback when
> submitting a job to
> > the IAA fails.
> >
> > Limitation 2: The job submission API has changed
> > For the qpl_path_hardware, the qpl_submit_job is a non-blocking
> function, only submitting
> > a job to IAA work queues, use qpl_wait_job to get the job result.
> >
> > For qpl_path_software/auto, the qpl_submit_job is a blocking function
> and returns the job
> > result directly,  qpl_wait_job can't get the job result.
> >
> > In short, the qpl_submit_job/qpl_wait_job APIs do not well support the
> qpl_path_auto feature.
>=20
> Please put a summary of this in the commit message so in the future we
> can evaluate whether to continue checking for ourselves.

Sure, I will add a summary in the commit message.
I confirmed with the QPL development team that, sw fallback for
qpl_submit_job/qpl_wait_job APIs will be ready next QPL release. So I will
keep the current design next version, the software path only for the QPL un=
it test.

After the next version of QPL is released, I will update the sw fallback co=
de
so that sw fallback can be used both in the QPL unit test and migration wit=
h IAA.

> >> > +        if (!qpl->iaa_avail) {
> >>
> >> This function got a bit convoluted, it's probably worth a check at the
> >> start and a branch to different multifd_qpl_compress_pages_slow()
> >> routine altogether.
> >
> > I agree that using multifd_qpl_compress_pages_slow is a better choice.
> >
> > In my previous thoughts, the QPl software path(or slow path) is only
> used
> > for the unit test and I did not consider fallback to the software path
> when
> > migration start because the QPL software path has no advantage over
> zstd.
> > So when the work queue is full, always try to resubmit the job instead
> of
> > fallback software path.
> >
> > I now realize that when IAA hardware throughput is the bottleneck(the
> work queue is full),
> > switching to software may also increase performance.
> >
> > I will implement the automatically falling back to the software when IA=
A
> work
> > queue is full into the next version and update the performance data.
> With the
> > increase in mutlfd migration threads, the performance will be better
> than now.
> > Currently, 4 threads will reach the IAA device throughput bottleneck,
> then increasing
> > The number of threads does not increase any performance.
> >
> >> > +            status =3D qpl_execute_job(job);
> >> > +            if (status =3D=3D QPL_STS_OK) {
> >> > +                multifd_qpl_build_packet(qpl, p, i, zbuf, job-
> >> >total_out);
> >> > +            } else if (status =3D=3D QPL_STS_MORE_OUTPUT_NEEDED) {
> >> > +                /* compressed length exceeds page size, send page
> >> directly */
> >> > +                multifd_qpl_build_packet(qpl, p, i, host + pages-
> >> >offset[i],
> >> > +                                         p->page_size);
> >> > +            } else {
> >> > +                error_setg(errp, "multifd %u: qpl_execute_job
> >> error %d",
> >> > +                           p->id, status);
> >> > +                return -1;
> >> > +            }
> >> > +            zbuf +=3D p->page_size;
> >> > +            continue;
> >> > +        }
> >> > +retry:
> >> > +        status =3D qpl_submit_job(job);
> >> > +        if (status =3D=3D QPL_STS_OK) {
> >> > +            zbuf +=3D p->page_size;
> >> > +        } else if (status =3D=3D QPL_STS_QUEUES_ARE_BUSY_ERR) {
> >> > +            goto retry;
> >>
> >> A retry count here would be nice.
> >
> > As the previous comment, I will switch to
> multifd_qpl_compress_pages_slow
> > When the work queue is full, I will give a performance comparison
> between
> > hardware only and software fallback next version.
> >
> >> > +        } else {
> >> > +            error_setg(errp, "multifd %u: qpl_submit_job failed wit=
h
> >> error %d",
> >> > +                       p->id, status);
> >> > +            return -1;
> >> > +        }
> >> > +    }
> >> > +    if (!qpl->iaa_avail) {
> >> > +        goto done;
> >> > +    }
> >> > +    /* wait all jobs to complete for hardware(IAA) path */
> >> > +    for (int i =3D 0; i < job_num; i++) {
> >> > +        job =3D qpl->job_array[i];
> >> > +        status =3D qpl_wait_job(job);
> >> > +        if (status =3D=3D QPL_STS_OK) {
> >> > +            multifd_qpl_build_packet(qpl, p, i, qpl->zbuf + (p-
> >> >page_size * i),
> >> > +                                     job->total_out);
> >> > +        } else if (status =3D=3D QPL_STS_MORE_OUTPUT_NEEDED) {
> >> > +            /* compressed data length exceeds page size, send page
> >> directly */
> >> > +            multifd_qpl_build_packet(qpl, p, i, host + pages-
> >> >offset[i],
> >> > +                                     p->page_size);
> >> > +        } else {
> >> > +            error_setg(errp, "multifd %u: qpl_wait_job failed with
> >> error %d",
> >> > +                       p->id, status);
> >> > +            return -1;
> >> > +        }
> >> > +    }
> >> > +done:
> >> > +    return 0;
> >> > +}
> >> > +
> >> >  /**
> >> >   * multifd_qpl_send_prepare: prepare data to be able to send
> >> >   *
> >> > @@ -217,8 +351,28 @@ static void
> >> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >> >   */
> >> >  static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error
> **errp)
> >> >  {
> >> > -    /* Implement in next patch */
> >> > -    return -1;
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +    uint32_t hdr_size;
> >> > +
> >> > +    if (!multifd_send_prepare_common(p)) {
> >> > +        goto out;
> >> > +    }
> >> > +
> >> > +    assert(p->pages->normal_num <=3D qpl->total_job_num);
> >> > +    hdr_size =3D p->pages->normal_num * sizeof(uint32_t);
> >> > +    /* prepare the header that stores the lengths of all compressed
> >> data */
> >> > +    p->iov[1].iov_base =3D (uint8_t *) qpl->zbuf_hdr;
> >> > +    p->iov[1].iov_len =3D hdr_size;
> >>
> >> Better use p->iovs_num here in case we ever decide to add more stuff t=
o
> >> the front of the array.
> >
> > Get it, I will fix this next version.
> >
> >> > +    p->iovs_num++;
> >> > +    p->next_packet_size +=3D hdr_size;
> >>
> >> Here's the first time we're setting this value, right? So just a
> regular
> >> attribution(=3D).
> >
> > Yes, I will fix this next version.
> >
> >> > +    if (multifd_qpl_compress_pages(p, errp) !=3D 0) {
> >> > +        return -1;
> >> > +    }
> >> > +
> >> > +out:
> >> > +    p->flags |=3D MULTIFD_FLAG_QPL;
> >> > +    multifd_send_fill_packet(p);
> >> > +    return 0;
> >> >  }
> >> >
> >> >  /**
> >> > @@ -256,6 +410,88 @@ static void
> >> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> >> >      p->compress_data =3D NULL;
> >> >  }
> >> >
> >> > +/**
> >> > + * multifd_qpl_decompress_pages: decompress normal pages
> >> > + *
> >> > + * Each compressed page will be decompressed independently, and the
> >> > + * decompression jobs will be submitted to the IAA hardware in non-
> >> blocking
> >> > + * mode, waiting for all jobs to be completed and loading the
> >> decompressed
> >> > + * data into guest memory. If IAA device is not available, the
> software
> >> path
> >> > + * is used.
> >> > + *
> >> > + * Returns 0 for success or -1 for error
> >> > + *
> >> > + * @p: Params for the channel that we are using
> >> > + * @errp: pointer to an error
> >> > + */
> >> > +static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error
> >> **errp)
> >> > +{
> >> > +    qpl_status status;
> >> > +    qpl_job *job;
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +    uint32_t job_num =3D p->normal_num;
> >> > +    uint32_t off =3D 0;
> >> > +
> >> > +    assert(job_num <=3D qpl->total_job_num);
> >> > +    /* submit all decompression jobs */
> >> > +    for (int i =3D 0; i < job_num; i++) {
> >> > +        /* if the data size is the same as the page size, load it
> >> directly */
> >> > +        if (qpl->zbuf_hdr[i] =3D=3D p->page_size) {
> >> > +            memcpy(p->host + p->normal[i], qpl->zbuf + off, p-
> >> >page_size);
> >> > +            off +=3D p->page_size;
> >> > +            continue;
> >> > +        }
> >> > +        job =3D qpl->job_array[i];
> >> > +        multifd_qpl_prepare_job(job, false, qpl->zbuf + off, qpl-
> >> >zbuf_hdr[i],
> >> > +                                p->host + p->normal[i], p-
> >page_size);
> >> > +        /* if hardware path(IAA) is unavailable, call the software
> path
> >> */
> >> > +        if (!qpl->iaa_avail) {
> >> > +            status =3D qpl_execute_job(job);
> >> > +            if (status =3D=3D QPL_STS_OK) {
> >> > +                off +=3D qpl->zbuf_hdr[i];
> >> > +                continue;
> >> > +            }
> >> > +            error_setg(errp, "multifd %u: qpl_execute_job failed
> with
> >> error %d",
> >> > +                       p->id, status);
> >> > +            return -1;
> >> > +        }
> >> > +retry:
> >> > +        status =3D qpl_submit_job(job);
> >> > +        if (status =3D=3D QPL_STS_OK) {
> >> > +            off +=3D qpl->zbuf_hdr[i];
> >> > +        } else if (status =3D=3D QPL_STS_QUEUES_ARE_BUSY_ERR) {
> >> > +            goto retry;
> >> > +        } else {
> >> > +            error_setg(errp, "multifd %u: qpl_submit_job failed wit=
h
> >> error %d",
> >> > +                       p->id, status);
> >> > +            return -1;
> >> > +        }
> >> > +    }
> >> > +    if (!qpl->iaa_avail) {
> >> > +        goto done;
> >> > +    }
> >> > +    /* wait all jobs to complete for hardware(IAA) path */
> >> > +    for (int i =3D 0; i < job_num; i++) {
> >> > +        if (qpl->zbuf_hdr[i] =3D=3D p->page_size) {
> >> > +            continue;
> >> > +        }
> >> > +        job =3D qpl->job_array[i];
> >> > +        status =3D qpl_wait_job(job);
> >> > +        if (status !=3D QPL_STS_OK) {
> >> > +            error_setg(errp, "multifd %u: qpl_wait_job failed with
> >> error %d",
> >> > +                       p->id, status);
> >> > +            return -1;
> >> > +        }
> >> > +        if (job->total_out !=3D p->page_size) {
> >> > +            error_setg(errp, "multifd %u: decompressed len %u,
> expected
> >> len %u",
> >> > +                       p->id, job->total_out, p->page_size);
> >> > +            return -1;
> >> > +        }
> >> > +    }
> >> > +done:
> >> > +    return 0;
> >> > +}
> >> > +
> >> >  /**
> >> >   * multifd_qpl_recv: read the data from the channel into actual
> pages
> >> >   *
> >> > @@ -269,8 +505,48 @@ static void
> >> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> >> >   */
> >> >  static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
> >> >  {
> >> > -    /* Implement in next patch */
> >> > -    return -1;
> >> > +    QplData *qpl =3D p->compress_data;
> >> > +    uint32_t in_size =3D p->next_packet_size;
> >> > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> >> > +    uint32_t hdr_len =3D p->normal_num * sizeof(uint32_t);
> >> > +    uint32_t data_len =3D 0;
> >> > +    int ret;
> >> > +
> >> > +    if (flags !=3D MULTIFD_FLAG_QPL) {
> >> > +        error_setg(errp, "multifd %u: flags received %x flags
> >> expected %x",
> >> > +                   p->id, flags, MULTIFD_FLAG_QPL);
> >> > +        return -1;
> >> > +    }
> >> > +    multifd_recv_zero_page_process(p);
> >> > +    if (!p->normal_num) {
> >> > +        assert(in_size =3D=3D 0);
> >> > +        return 0;
> >> > +    }
> >> > +
> >> > +    /* read compressed data lengths */
> >> > +    assert(hdr_len < in_size);
> >> > +    ret =3D qio_channel_read_all(p->c, (void *) qpl->zbuf_hdr,
> hdr_len,
> >> errp);
> >> > +    if (ret !=3D 0) {
> >> > +        return ret;
> >> > +    }
> >> > +    assert(p->normal_num <=3D qpl->total_job_num);
> >>
> >> I'm still in doubt whether we should use p->page_count directly all
> >> over. It's nice to move the concept into the QPL domain space, but it
> >> makes less sense in these functions that take MultiFD*Params as
> >> argument.
> >
> > I don't understand what you mean here. Do you plan to remove page_count
> from MultiFD*Params
> > and provide a new API to get the migrated page count?
> >
>=20
> No, I mean that qpl->total_job_num =3D=3D p->page_count, so we could use
> p->page_count in the functions that have MultiFDParams available. Maybe
> even drop total_job_num altogether. But I'm debating if it is worth it,
> because that makes the code more coupled to multifd and we may not want
> that. Let's leave it for now.

Get it, thanks for the comment

> >> > +    for (int i =3D 0; i < p->normal_num; i++) {
> >> > +        qpl->zbuf_hdr[i] =3D be32_to_cpu(qpl->zbuf_hdr[i]);
> >> > +        data_len +=3D qpl->zbuf_hdr[i];
> >> > +        assert(qpl->zbuf_hdr[i] <=3D p->page_size);
> >> > +    }
> >> > +
> >> > +    /* read compressed data */
> >> > +    assert(in_size =3D=3D hdr_len + data_len);
> >> > +    ret =3D qio_channel_read_all(p->c, (void *) qpl->zbuf, data_len=
,
> >> errp);
> >> > +    if (ret !=3D 0) {
> >> > +        return ret;
> >> > +    }
> >> > +
> >> > +    if (multifd_qpl_decompress_pages(p, errp) !=3D 0) {
> >> > +        return -1;
> >> > +    }
> >> > +    return 0;
> >> >  }
> >> >
> >> >  static MultiFDMethods multifd_qpl_ops =3D {

