Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76377C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 06:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF6MH-00041Q-Et; Thu, 06 Jun 2024 02:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sF6MG-00040w-Ao
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:12:20 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sF6MC-0007CA-LN
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717654337; x=1749190337;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dmat9U726OqJPD585MNQJgldJb0tpwUMTDpOoho8CVQ=;
 b=hsz9O7IKTtOKi6F/nBQqQ1xuq/e/N2or//fHGfMr5DiTgWrliSY0vsoo
 8XE2IhuAhyxtKgu/pl8OdKu1j4ri1sCCI/aCIv2ozgbyWmc7bDFvUVr7K
 ai0sN1mr2BnAX3Lm83hi3MlGMXPJoNiL1hkE8U7qy8DXS3EMHZxHea4ED
 ufA2ZJMJ9mOHBiQuQMYD1KT177doj8bYsexN7FJpam+jovaQ9lCFaXi5X
 HC+m5twyCuvNcsloqEqvsvGfKCiF3JGZbF1k6aYzG1fTp3LjX/wpn0K5M
 Q6yphPhaKFNICrl/ujWnVIvmAX7fSXfvmb5u2L7qFK4tzslu3PzQycSzE Q==;
X-CSE-ConnectionGUID: owqikaZGStmojTayQEuhnw==
X-CSE-MsgGUID: wRR14vPOQB+wW0D+/mcGnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14140988"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="14140988"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 23:12:13 -0700
X-CSE-ConnectionGUID: 6a3AGOIrR0KiH/x97p62sA==
X-CSE-MsgGUID: wTLOiMCmQCyYqaMds8J64A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="37862616"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Jun 2024 23:12:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 23:12:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 23:12:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 23:12:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 23:12:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUi7ZI7YgzGjxI2ABLP2Ww2lE1L9Dvox59t2thasWe5DpOlfLDca4cNNuYgmumCdVKy1WUQTHI9uSo2hX9xvdlVrK+VO6NwV5IjYiZRIFO9E+FClBqeLnngDE7hdFW3crP9iKuaRSoU47ADytm1YaWi+2ELNefB9Ff68S5HztE3XtaND+fMOWFy/YfjgwX/8/XnqQvKi7HHun/UqBuG4Awn4JbAeWdL1pKLYdtccMqsXr11KtD18NF70Jg3JEbbDLYpSiK2TnukKDzrreajfOG/HPecWYuLinI5wm4BMG5Zx2crRODmSF972xrTfahxF2Pop2kAeGDUMTW+MsxtH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrP/dXXU25EcUf6YUB54WL5YGfMk7f2iQUs8ZCftEzI=;
 b=kJonMCTPE70fq+QrO9lVpt1UdP7tnHmNfVEj0kd2M8rNelrbrF3ES9Q94euA5l4XKREUDdoGGR7F+Xk9+bG+zXNRSx7qzkl4WUL4V60gXgP3ZyZkWl6BCca5orQPsKLVut4QFvHJCLoldqkzBH1WA6QPyNAuAWEEno2sJOVxmvVAK0B+lnB9Xs9bsuR4ctw5Bf4ugXAIQ473fT9OrhFpyDSgd7Rsz/OTXF3Wskf+Fr+dH9gW9EJKKGkF5Tv5p0AwHCpjp+ichHzdYFjpBEPTUXARXV7MoDOVQj5atOIFKnymD0ZGwB/vxLyTzREJGGERZvQZOaCNaDLjloBKtcsjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 06:12:09 +0000
Received: from MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::fcd7:1ee6:47db:935c]) by MW4PR11MB5936.namprd11.prod.outlook.com
 ([fe80::fcd7:1ee6:47db:935c%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 06:12:09 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v7 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Topic: [PATCH v7 6/7] migration/multifd: implement qpl compression and
 decompression
Thread-Index: AQHatoIOkzCC5BZJ1kmOKxeDB7vItrG5waWAgAAvfGA=
Date: Thu, 6 Jun 2024 06:12:09 +0000
Message-ID: <MW4PR11MB59366D87600EA832A8248F2FA3FA2@MW4PR11MB5936.namprd11.prod.outlook.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
 <20240603154106.764378-7-yuan1.liu@intel.com> <87plsvni18.fsf@suse.de>
In-Reply-To: <87plsvni18.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5936:EE_|SA2PR11MB4937:EE_
x-ms-office365-filtering-correlation-id: f4e2df0f-3194-4cbe-654a-08dc85ef9915
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?n24eTt4BVWizIyWK32cqymtXbI9uj6ZVJ+zU0UDs6+dZ4fxx08HxZf5blnaB?=
 =?us-ascii?Q?wss283tlRczJY1+lh515qe4Kgqy7TRd17ACUvTmMlTQJouHbDVLhFZXfOs48?=
 =?us-ascii?Q?TMSuXPVvTwEG1bGDyYKGeiaSeS4DBJvPnjYLyscbtEe1Z8Mm3RdX3YgWAORi?=
 =?us-ascii?Q?If1AYMtWOfcesccge2loeWNhxTY2hvjQ40oi6nIvUoATAyFiOEopT+1B7SQO?=
 =?us-ascii?Q?u5NLtkCjd119bgSrymKCurtznK05cx4GI87r6cDg9mllXUoZtol6X4L9J4IC?=
 =?us-ascii?Q?oGHZKzvjazAu9R30nycHKPdRnW+TWvf0xr+f3OjW/EtUh3Y+AEqz/kDKcrX9?=
 =?us-ascii?Q?2u9tUSSiIXkuXrnzi/k9eqsZX7Elf05BpJGmdagsoaHGPmWP6kHFStbMHXkK?=
 =?us-ascii?Q?JZu4vIk9ut7W7I3+DCHsxg6/oq7NQN9uh0HqQpm2eulGz9yvhgF0tqZo9u6d?=
 =?us-ascii?Q?UOdpHSkbpBk0Q3mPp0yIAcICycdrgM3HUGgv8TTY3dQji4Pk7W4YhOSuc2ke?=
 =?us-ascii?Q?usKMUCAXJ+wOPv4lhig+vpQ18+TlQt0HLQjkshyh4r4+cu2PufsIoRKokJjl?=
 =?us-ascii?Q?s3LpvUAP8oxBsm6Zz8ooAseFIC8zyJrLdUEcbTMjiGCzzTe4yq3ox4//9AlJ?=
 =?us-ascii?Q?zJOoKHkWO4LihhF2+KJctmEwpF6P6GEsAYJxTSiyC+Ccoj2cWWNKtoH/pb6n?=
 =?us-ascii?Q?wCp4WDVzbqYfsfV2dxZ1VW3suoXiebiIRePvcFKLVJNjmUG2DVjKr2w7ZbBB?=
 =?us-ascii?Q?o0KtpR1E23S+wyro2kEtJRbFteaYRUtVXs9fL7/DRnjaBeKQkyYjKC9lWjdN?=
 =?us-ascii?Q?GwsFzvB0WaBg/DyXHsO6VAJBtNUY268cMtcNflsLXQnOMu2bRm6QysryKKyC?=
 =?us-ascii?Q?k8pg527GZUxrCcPLDGhQne8g30Oo3jhvAeSe8lDwoPXy+XUTMqXUaRlwfMmL?=
 =?us-ascii?Q?sXjtj86jSrbPX9CnM0AkJ/7tXNrGI5CFKk0SVqGDOlIAx6b4Y7AfaQMGi+Ko?=
 =?us-ascii?Q?nN2rK03nOQ/q/d3ytjb1qXhrI/rB8JIioQlS92Kt4dczu5J9Msd/ZE2qD3R6?=
 =?us-ascii?Q?PFfuR8FxEaHoP56yRm+jdrA56be69XKl6LAt3vDynJdd1P3W7+P8V8tIwufk?=
 =?us-ascii?Q?L3Zx6meIC3HaqpU/IY0baJb6CT693vkqxiMWQgQRa9C2AZDDtqIEGE/eULyU?=
 =?us-ascii?Q?ILfgy7CN5JcqBAxrLi/ok7LAbwL49xt8wDO+iDwGVKYv7Qh2YQXkZXv8BBMB?=
 =?us-ascii?Q?NjoTpetIWMTF4xPPp5BQar3Jbzk0156PqEAHUJ0pTQq/rK7+IDTBI1XlB+4M?=
 =?us-ascii?Q?NZBbrR99A8Psrro44vg8Dz4boTm9OhxdFlChyDAqHk3eZSUBI3iBPkHqUUKz?=
 =?us-ascii?Q?EVJtsNo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5936.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XIzl3g0y2Iq5bjrEzptSBZaxzx6SBVmIcFOriBbydU+3b5lqlXxG9q7RwJl5?=
 =?us-ascii?Q?5lvoWp//JmqTVA5Bck2p1c30CWvxatfMRaL0l3xsFYJ4Itie2S68DEmhUa/r?=
 =?us-ascii?Q?jCMddnhVw8XfViNmTkJUMqPHt9y836xkTfskPABsS1EUFHiiqKUEk9ZiTWWQ?=
 =?us-ascii?Q?qo+3YUx2nhoDjWmQtr7ikh6jCTKDjXtGYLBKgR1rQ7kA60P23bf11dbWs1LH?=
 =?us-ascii?Q?44QasLytMsAci0PynOg0bf1bLERZOE26+2T2HlXZ2Ob0mhMDyhJfkjNXCCn2?=
 =?us-ascii?Q?CnFGC+RixfSQ2PA+JaGeN/Vv9Pi104c4MPIFf0CqKiyo6Kjsu/aLq0S0+U3a?=
 =?us-ascii?Q?wY0U2ViFYZKizmvSm/adTvALUh3tL0hWnLrFAgilHz/ZyU6mvkKS3UF1Molj?=
 =?us-ascii?Q?FujFlCwZ/rXqTdGXfKEVM24agr7VZariZp65IwPlwDKE22NBoTVsJZyxswLP?=
 =?us-ascii?Q?VuXfUVR+bEqx6+KDGv8aya+znXnGw50iM+/zIPqwg75g0wo1p21GwMSkTPSu?=
 =?us-ascii?Q?C5c10JAkyKypjI9kdIiX6f2xrAAIssNdsf30blC3dtzViZs/6kqdGFuGiZYK?=
 =?us-ascii?Q?kVTVaSgdDl2gzCx7sXA1OvbTDAxRnZwzTjC2AaEKWEOJ7/M726v82qb6p0Sf?=
 =?us-ascii?Q?Y9MsKxQAQNSxRkWsfLuR3jP2liXIBh2ttixAljKmfcrDke1Y8Jmd+sxsNYqC?=
 =?us-ascii?Q?TDNEqHMq5IDQUk4Qr8Awepzp1DPx9JocE+NgtfvHseRSIHNYo2cS/2o2cwAL?=
 =?us-ascii?Q?ADd0D8v1BhhWvlERrpKD0aRkxLkZKD8GBUC2FzdMqP6fm2FpSwtKJWZ45+kX?=
 =?us-ascii?Q?BHcU9k8DZooXuZAgbMeePcyUFbt7Qka3sHAaF5ILwhQRegqfWkAAjWI0YMYJ?=
 =?us-ascii?Q?FI+1/Im3xv6M1WWh2Qx9ojtWvRiI1D9p8zdpMw6f7fTS96wALgZ+ytGe1lQM?=
 =?us-ascii?Q?jQ830RPiVoBobbZ/S5J/m3fG3R3IOs6TFpVjgKhsFMIlLl5zxD687r3AjPas?=
 =?us-ascii?Q?c9ahzdT3sk4khT7oVOmbqySc43UHUyu5FK6XgqGbpSlqUJYbrMj5yAYuX3ab?=
 =?us-ascii?Q?/mHKCtVkP/N9yfHnFysfcKaWVJWDKzt9ykTz6BO6UR+PTKLSDVsbXOX4/Lt6?=
 =?us-ascii?Q?M9wCO2gzhL/iUc7vvrIlZgwBt0aeEJHojfkh7UxpkOfgSAzMrPB3c4r0HONG?=
 =?us-ascii?Q?p4rcH6539K/jOpDkHJMDvdxTRXDMbYtIZpR7+VIyhenB77vrpt7K9fdjxvuq?=
 =?us-ascii?Q?b6QzZvRPGuvwJDbu+SW8sMPIwniOdvvgloW9pTyD8bDfGSUJ2mGpZKvbqdWJ?=
 =?us-ascii?Q?CajUGnkdk7VbDklN/6OPVlUAJNGZ9GiwFvVvgA/DJnsAGarPnfVa12CAq0AU?=
 =?us-ascii?Q?det+ra3wBFDMUzUjHvS4pjUc/VofTeu+uHqDQokQu0B601G06YMsJxESBNhP?=
 =?us-ascii?Q?3abOlwxNRSSwCPUt0eb527RgFshBKt9tMgNS3sSMORAUa22uopfIXX1lk1qq?=
 =?us-ascii?Q?IKbmyTZl84DZmoDTRqZocXUYEz0kiGUv8o/33BeiEHjjYP6v7EFV3A/dCepY?=
 =?us-ascii?Q?EZG3rJ+AaFDTlJ4yEdUsgA4K3CkSBE7FbepHpv4W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5936.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e2df0f-3194-4cbe-654a-08dc85ef9915
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 06:12:09.1233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrZUei/x1AS/uo8G443ZWd7VHRKqthAbO6kfEaUK7rgb+mBUp4N+bdRMiDQNk88ZfJ+LCAOxmFw1mca5sgUNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Thursday, June 6, 2024 6:26 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
> thuth@redhat.com; philmd@linaro.org
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>; shameerali.kolothum.thodi@huawei.com
> Subject: Re: [PATCH v7 6/7] migration/multifd: implement qpl compression
> and decompression
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > QPL compression and decompression will use IAA hardware first.
> > If IAA hardware is not available, it will automatically fall
> > back to QPL software path, if the software job also fails,
> > the uncompressed page is sent directly.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  migration/multifd-qpl.c | 412 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 408 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
> > index 6791a204d5..18b3384bd5 100644
> > --- a/migration/multifd-qpl.c
> > +++ b/migration/multifd-qpl.c
> > @@ -13,9 +13,14 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/module.h"
> >  #include "qapi/error.h"
> > +#include "qapi/qapi-types-migration.h"
> > +#include "exec/ramblock.h"
> >  #include "multifd.h"
> >  #include "qpl/qpl.h"
> >
> > +/* Maximum number of retries to resubmit a job if IAA work queues are
> full */
> > +#define MAX_SUBMIT_RETRY_NUM (3)
> > +
> >  typedef struct {
> >      /* the QPL hardware path job */
> >      qpl_job *job;
> > @@ -260,6 +265,219 @@ static void
> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >      p->iov =3D NULL;
> >  }
> >
> > +/**
> > + * multifd_qpl_prepare_job: prepare the job
> > + *
> > + * Set the QPL job parameters and properties.
> > + *
> > + * @job: pointer to the qpl_job structure
> > + * @is_compression: indicates compression and decompression
> > + * @input: pointer to the input data buffer
> > + * @input_len: the length of the input data
> > + * @output: pointer to the output data buffer
> > + * @output_len: the length of the output data
> > + */
> > +static void multifd_qpl_prepare_job(qpl_job *job, bool is_compression,
> > +                                    uint8_t *input, uint32_t input_len=
,
> > +                                    uint8_t *output, uint32_t
> output_len)
> > +{
> > +    job->op =3D is_compression ? qpl_op_compress : qpl_op_decompress;
> > +    job->next_in_ptr =3D input;
> > +    job->next_out_ptr =3D output;
> > +    job->available_in =3D input_len;
> > +    job->available_out =3D output_len;
> > +    job->flags =3D QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERI=
FY;
> > +    /* only supports compression level 1 */
> > +    job->level =3D 1;
> > +}
> > +
> > +/**
> > + * multifd_qpl_prepare_job: prepare the compression job
>=20
> function name is wrong

Thanks, I will fix this next version.
=20
> > + *
> > + * Set the compression job parameters and properties.
> > + *
> > + * @job: pointer to the qpl_job structure
> > + * @input: pointer to the input data buffer
> > + * @input_len: the length of the input data
> > + * @output: pointer to the output data buffer
> > + * @output_len: the length of the output data
> > + */
> > +static void multifd_qpl_prepare_comp_job(qpl_job *job, uint8_t *input,
> > +                                         uint32_t input_len, uint8_t
> *output,
> > +                                         uint32_t output_len)
> > +{
> > +    multifd_qpl_prepare_job(job, true, input, input_len, output,
> output_len);
> > +}
> > +
> > +/**
> > + * multifd_qpl_prepare_job: prepare the decompression job

Thanks, I will fix this next version.
=20
> > + *
> > + * Set the decompression job parameters and properties.
> > + *
> > + * @job: pointer to the qpl_job structure
> > + * @input: pointer to the input data buffer
> > + * @input_len: the length of the input data
> > + * @output: pointer to the output data buffer
> > + * @output_len: the length of the output data
> > + */
> > +static void multifd_qpl_prepare_decomp_job(qpl_job *job, uint8_t
> *input,
> > +                                           uint32_t input_len, uint8_t
> *output,
> > +                                           uint32_t output_len)
> > +{
> > +    multifd_qpl_prepare_job(job, false, input, input_len, output,
> output_len);
> > +}
> > +
> > +/**
> > + * multifd_qpl_fill_iov: fill in the IOV
> > + *
> > + * Fill in the QPL packet IOV
> > + *
> > + * @p: Params for the channel being used
> > + * @data: pointer to the IOV data
> > + * @len: The length of the IOV data
> > + */
> > +static void multifd_qpl_fill_iov(MultiFDSendParams *p, uint8_t *data,
> > +                                 uint32_t len)
> > +{
> > +    p->iov[p->iovs_num].iov_base =3D data;
> > +    p->iov[p->iovs_num].iov_len =3D len;
> > +    p->iovs_num++;
> > +    p->next_packet_size +=3D len;
> > +}
> > +
> > +/**
> > + * multifd_qpl_fill_packet: fill the compressed page into the QPL
> packet
> > + *
> > + * Fill the compressed page length and IOV into the QPL packet
> > + *
> > + * @idx: The index of the compressed length array
> > + * @p: Params for the channel being used
> > + * @data: pointer to the compressed page buffer
> > + * @len: The length of the compressed page
> > + */
> > +static void multifd_qpl_fill_packet(uint32_t idx, MultiFDSendParams *p=
,
> > +                                    uint8_t *data, uint32_t len)
> > +{
> > +    QplData *qpl =3D p->compress_data;
> > +
> > +    qpl->zlen[idx] =3D cpu_to_be32(len);
> > +    multifd_qpl_fill_iov(p, data, len);
> > +}
> > +
> > +/**
> > + * multifd_qpl_submit_job: submit a job to the hardware
> > + *
> > + * Submit a QPL hardware job to the IAA device
> > + *
> > + * Returns true if the job is submitted successfully, otherwise false.
> > + *
> > + * @job: pointer to the qpl_job structure
> > + */
> > +static bool multifd_qpl_submit_job(qpl_job *job)
> > +{
> > +    qpl_status status;
> > +    uint32_t num =3D 0;
> > +
> > +retry:
> > +    status =3D qpl_submit_job(job);
> > +    if (status =3D=3D QPL_STS_QUEUES_ARE_BUSY_ERR) {
> > +        if (num < MAX_SUBMIT_RETRY_NUM) {
> > +            num++;
> > +            goto retry;
> > +        }
> > +    }
> > +    return (status =3D=3D QPL_STS_OK);
>=20
> How often do we expect this to fail? Will the queues be busy frequently
> or is this an unlikely event? I'm thinking whether we really need to
> allow a fallback for the hw path. Sorry if this has been discussed
> already, I don't remember.

In some scenarios, this may happen frequently, such as configuring 4 channe=
ls=20
but only one IAA device is available. In the case of insufficient IAA hardw=
are=20
resources, retry and fallback can help optimize performance.
I have a comparison test below

1. Retry + SW fallback:
   total time: 14649 ms
   downtime: 25 ms
   throughput: 17666.57 mbps
   pages-per-second: 1509647

2. No fallback, always wait for work queues to become available
   total time: 18381 ms
   downtime: 25 ms
   throughput: 13698.65 mbps
   pages-per-second: 859607

> > +}
> > +
> > +/**
> > + * multifd_qpl_compress_pages_slow_path: compress pages using slow pat=
h
> > + *
> > + * Compress the pages using software. If compression fails, the page
> will
> > + * be sent directly.
> > + *
> > + * @p: Params for the channel being used
> > + */
> > +static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
> > +{
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t size =3D p->page_size;
> > +    qpl_job *job =3D qpl->sw_job;
> > +    uint8_t *zbuf =3D qpl->zbuf;
> > +    uint8_t *buf;
> > +
> > +    for (int i =3D 0; i < p->pages->normal_num; i++) {
> > +        buf =3D p->pages->block->host + p->pages->offset[i];
> > +        /* Set output length to less than the page to reduce
> decompression */
> > +        multifd_qpl_prepare_comp_job(job, buf, size, zbuf, size - 1);
> > +        if (qpl_execute_job(job) =3D=3D QPL_STS_OK) {
> > +            multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
> > +        } else {
> > +            /* send the page directly */
>=20
> s/directly/uncompressed/
>=20
> a bit clearer.

Sure, I will fix it next version.=20

> > +            multifd_qpl_fill_packet(i, p, buf, size);
> > +        }
> > +        zbuf +=3D size;
> > +    }
> > +}
> > +
> > +/**
> > + * multifd_qpl_compress_pages: compress pages
> > + *
> > + * Submit the pages to the IAA hardware for compression. If hardware
> > + * compression fails, it falls back to software compression. If
> software
> > + * compression also fails, the page is sent directly
> > + *
> > + * @p: Params for the channel being used
> > + */
> > +static void multifd_qpl_compress_pages(MultiFDSendParams *p)
> > +{
> > +    QplData *qpl =3D p->compress_data;
> > +    MultiFDPages_t *pages =3D p->pages;
> > +    uint32_t size =3D p->page_size;
> > +    QplHwJob *hw_job;
> > +    uint8_t *buf;
> > +    uint8_t *zbuf;
> > +
>=20
> Let's document the output size choice more explicitly:
>=20
>     /*
>      * Set output length to less than the page size to force the job to
>      * fail in case it compresses to a larger size. We'll send that page
>      * without compression and skip the decompression operation on the
>      * destination.
>      */
>      out_size =3D size - 1;
>=20
> you can then omit the other comments.

Thanks for the comments, I will refine this next version.
=20
> > +    for (int i =3D 0; i < pages->normal_num; i++) {
> > +        buf =3D pages->block->host + pages->offset[i];
> > +        zbuf =3D qpl->zbuf + (size * i);
> > +        hw_job =3D &qpl->hw_jobs[i];
> > +        /* Set output length to less than the page to reduce
> decompression */
> > +        multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf, siz=
e
> - 1);
> > +        if (multifd_qpl_submit_job(hw_job->job)) {
> > +            hw_job->fallback_sw_path =3D false;
> > +        } else {
> > +            hw_job->fallback_sw_path =3D true;
> > +            /* Set output length less than page size to reduce
> decompression */
> > +            multifd_qpl_prepare_comp_job(qpl->sw_job, buf, size, zbuf,
> > +                                         size - 1);
> > +            if (qpl_execute_job(qpl->sw_job) =3D=3D QPL_STS_OK) {
> > +                hw_job->sw_output =3D zbuf;
> > +                hw_job->sw_output_len =3D qpl->sw_job->total_out;
> > +            } else {
> > +                hw_job->sw_output =3D buf;
> > +                hw_job->sw_output_len =3D size;
> > +            }
>=20
> Hmm, these look a bit cumbersome, would it work if we moved the fallback
> qpl_execute_job() down into the other loop? We could then avoid the
> extra fields. Something like:
>=20
> static void multifd_qpl_compress_pages(MultiFDSendParams *p)
> {
>     QplData *qpl =3D p->compress_data;
>     MultiFDPages_t *pages =3D p->pages;
>     uint32_t out_size, size =3D p->page_size;
>     uint8_t *buf, *zbuf;
>=20
>     /*
>      * Set output length to less than the page size to force the job to
>      * fail in case it compresses to a larger size. We'll send that page
>      * without compression to skip the decompression operation on the
>      * destination.
>      */
>     out_size =3D size - 1;
>=20
>     for (int i =3D 0; i < pages->normal_num; i++) {
>         QplHwJob *hw_job =3D &qpl->hw_jobs[i];
>=20
>         hw_job->fallback_sw_path =3D false;
>         buf =3D pages->block->host + pages->offset[i];
>         zbuf =3D qpl->zbuf + (size * i);
>=20
>         multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf,
> out_size);
>=20
>         if (!multifd_qpl_submit_job(hw_job->job)) {
>             hw_job->fallback_sw_path =3D true;
>         }
>     }
>=20
>     for (int i =3D 0; i < pages->normal_num; i++) {
>         QplHwJob *hw_job =3D &qpl->hw_jobs[i];
>         qpl_job *job;
>=20
>         buf =3D pages->block->host + pages->offset[i];
>         zbuf =3D qpl->zbuf + (size * i);
>=20
>         if (hw_job->fallback_sw_path) {
>             job =3D qpl->sw_job;
>             multifd_qpl_prepare_comp_job(job, buf, size, zbuf, out_size);
>             ret =3D qpl_execute_job(job);
>         } else {
>             job =3D hw_job->job;
>             ret =3D qpl_wait_job(job);
>         }
>=20
>         if (ret =3D=3D QPL_STS_OK) {
>             multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
>         } else {
>             multifd_qpl_fill_packet(i, p, buf, size);
>         }
>     }
> }

Very thanks for the reference code, I have test the code and the performanc=
e is not good.
When the work queue is full, after a hardware job fails to be submitted, th=
e subsequent
job submission will most likely fail as well. so my idea is to use software=
 job execution
instead immediately, but all subsequent jobs will still give priority to ha=
rdware path.=20

There is almost no overhead in job submission because Intel uses the new "e=
nqcmd" instruction,
which allows the user program to submit the job directly to the hardware.

According to the implementation of the reference code, when a job fails to =
be submitted, there=20
is a high probability that "ALL" subsequent jobs will fail to be submitted =
and then use software
compression, resulting in the IAA hardware not being fully utilized.

For 4 Channel, 1 IAA device test case, using the reference code will reduce=
 IAA throughput=20
from 3.4GBps to 2.2GBps, thus affecting live migration performance.(total t=
ime from 14s to 18s)

> > +        }
> > +    }
> > +
> > +    for (int i =3D 0; i < pages->normal_num; i++) {
> > +        buf =3D pages->block->host + pages->offset[i];
> > +        zbuf =3D qpl->zbuf + (size * i);
> > +        hw_job =3D &qpl->hw_jobs[i];
> > +        if (hw_job->fallback_sw_path) {
> > +            multifd_qpl_fill_packet(i, p, hw_job->sw_output,
> > +                                    hw_job->sw_output_len);
> > +            continue;
> > +        }
> > +        if (qpl_wait_job(hw_job->job) =3D=3D QPL_STS_OK) {
> > +            multifd_qpl_fill_packet(i, p, zbuf, hw_job->job-
> >total_out);
> > +        } else {
> > +            /* send the page directly */
> > +            multifd_qpl_fill_packet(i, p, buf, size);
> > +        }
> > +    }
> > +}
> > +
> >  /**
> >   * multifd_qpl_send_prepare: prepare data to be able to send
> >   *
> > @@ -273,8 +491,26 @@ static void
> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
> >   */
> >  static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp=
)
> >  {
> > -    /* Implement in next patch */
> > -    return -1;
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t len =3D 0;
> > +
> > +    if (!multifd_send_prepare_common(p)) {
> > +        goto out;
> > +    }
> > +
> > +    /* The first IOV is used to store the compressed page lengths */
> > +    len =3D p->pages->normal_num * sizeof(uint32_t);
> > +    multifd_qpl_fill_iov(p, (uint8_t *) qpl->zlen, len);
> > +    if (qpl->hw_avail) {
> > +        multifd_qpl_compress_pages(p);
> > +    } else {
> > +        multifd_qpl_compress_pages_slow_path(p);
> > +    }
> > +
> > +out:
> > +    p->flags |=3D MULTIFD_FLAG_QPL;
> > +    multifd_send_fill_packet(p);
> > +    return 0;
> >  }
> >
> >  /**
> > @@ -312,6 +548,134 @@ static void
> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> >      p->compress_data =3D NULL;
> >  }
> >
> > +/**
> > + * multifd_qpl_process_and_check_job: process and check a QPL job
> > + *
> > + * Process the job and check whether the job output length is the
> > + * same as the specified length
> > + *
> > + * Returns true if the job execution succeeded and the output length
> > + * is equal to the specified length, otherwise false.
> > + *
> > + * @job: pointer to the qpl_job structure
> > + * @is_hardware: indicates whether the job is a hardware job
> > + * @len: Specified output length
> > + * @errp: pointer to an error
> > + */
> > +static bool multifd_qpl_process_and_check_job(qpl_job *job, bool
> is_hardware,
> > +                                              uint32_t len, Error
> **errp)
> > +{
> > +    qpl_status status;
> > +
> > +    status =3D (is_hardware ? qpl_wait_job(job) : qpl_execute_job(job)=
);
> > +    if (status !=3D QPL_STS_OK) {
> > +        error_setg(errp, "qpl_execute_job failed with error %d",
> status);
>=20
> The error message should also cover qpl_wait_job(), right? Maybe just
> use "qpl job failed".

You are right, I will fix this next version.

> > +        return false;
> > +    }
> > +    if (job->total_out !=3D len) {
> > +        error_setg(errp, "qpl decompressed len %u, expected len %u",
> > +                   job->total_out, len);
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +/**
> > + * multifd_qpl_decompress_pages_slow_path: decompress pages using slow
> path
> > + *
> > + * Decompress the pages using software
> > + *
> > + * Returns 0 on success or -1 on error
> > + *
> > + * @p: Params for the channel being used
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_decompress_pages_slow_path(MultiFDRecvParams *p=
,
> > +                                                  Error **errp)
> > +{
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t size =3D p->page_size;
> > +    qpl_job *job =3D qpl->sw_job;
> > +    uint8_t *zbuf =3D qpl->zbuf;
> > +    uint8_t *addr;
> > +    uint32_t len;
> > +
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        len =3D qpl->zlen[i];
> > +        addr =3D p->host + p->normal[i];
> > +        /* the page is uncompressed, load it */
> > +        if (len =3D=3D size) {
> > +            memcpy(addr, zbuf, size);
> > +            zbuf +=3D size;
> > +            continue;
> > +        }
> > +        multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
> > +        if (!multifd_qpl_process_and_check_job(job, false, size, errp)=
)
> {
> > +            return -1;
> > +        }
> > +        zbuf +=3D len;
> > +    }
> > +    return 0;
> > +}
> > +
> > +/**
> > + * multifd_qpl_decompress_pages: decompress pages
> > + *
> > + * Decompress the pages using the IAA hardware. If hardware
> > + * decompression fails, it falls back to software decompression.
> > + *
> > + * Returns 0 on success or -1 on error
> > + *
> > + * @p: Params for the channel being used
> > + * @errp: pointer to an error
> > + */
> > +static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error
> **errp)
> > +{
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t size =3D p->page_size;
> > +    uint8_t *zbuf =3D qpl->zbuf;
> > +    uint8_t *addr;
> > +    uint32_t len;
> > +    qpl_job *job;
> > +
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        addr =3D p->host + p->normal[i];
> > +        len =3D qpl->zlen[i];
> > +        /* the page is uncompressed if received length equals the page
> size */
> > +        if (len =3D=3D size) {
> > +            memcpy(addr, zbuf, size);
> > +            zbuf +=3D size;
> > +            continue;
> > +        }
> > +
> > +        job =3D qpl->hw_jobs[i].job;
> > +        multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
> > +        if (multifd_qpl_submit_job(job)) {
> > +            qpl->hw_jobs[i].fallback_sw_path =3D false;
> > +        } else {
> > +            qpl->hw_jobs[i].fallback_sw_path =3D true;
> > +            job =3D qpl->sw_job;
> > +            multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size)=
;
> > +            if (!multifd_qpl_process_and_check_job(job, false, size,
> errp)) {
> > +                return -1;
> > +            }
>=20
> Here the same suggestion applies. You created
> multifd_qpl_process_and_check_job() but is now calling it twice, which
> seems to lose the purpose. If the fallback moves to the loop below, then
> you do it all in one place:
>=20
>     for (int i =3D 0; i < p->normal_num; i++) {
>         bool is_sw =3D !qpl->hw_jobs[i].fallback_sw_path;
>=20
>         if (is_sw) {
>             job =3D qpl->sw_job;
>             multifd_qpl_prepare_decomp_job(job, zbuf, len, addr, size);
>         } else {
>             job =3D qpl->hw_jobs[i].job;
>         }
>=20
>         if (!multifd_qpl_process_and_check_job(job, !is_sw, size, errp)) =
{
>             return -1;
>         }
>     }

I think this is the same issue as discussed above, after a hardware job fai=
ls to
be submitted, execute a software job immediately, and subsequent jobs are
prioritized to use hardware jobs. So use the same multifd_qpl_process_and_c=
heck_job=20
in two parts.
=20
> > +        }
> > +        zbuf +=3D len;
> > +    }
> > +
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        /* ignore pages that have already been processed */
> > +        if (qpl->zlen[i] =3D=3D size || qpl->hw_jobs[i].fallback_sw_pa=
th) {
> > +            continue;
> > +        }
> > +
> > +        job =3D qpl->hw_jobs[i].job;
> > +        if (!multifd_qpl_process_and_check_job(job, true, size, errp))
> {
> > +            return -1;
> > +        }
> > +    }
> > +    return 0;
> > +}
> >  /**
> >   * multifd_qpl_recv: read the data from the channel into actual pages
> >   *
> > @@ -325,8 +689,48 @@ static void
> multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
> >   */
> >  static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
> >  {
> > -    /* Implement in next patch */
> > -    return -1;
> > +    QplData *qpl =3D p->compress_data;
> > +    uint32_t in_size =3D p->next_packet_size;
> > +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> > +    uint32_t len =3D 0;
> > +    uint32_t zbuf_len =3D 0;
> > +    int ret;
> > +
> > +    if (flags !=3D MULTIFD_FLAG_QPL) {
> > +        error_setg(errp, "multifd %u: flags received %x flags
> expected %x",
> > +                   p->id, flags, MULTIFD_FLAG_QPL);
> > +        return -1;
> > +    }
> > +    multifd_recv_zero_page_process(p);
> > +    if (!p->normal_num) {
> > +        assert(in_size =3D=3D 0);
> > +        return 0;
> > +    }
> > +
> > +    /* read compressed page lengths */
> > +    len =3D p->normal_num * sizeof(uint32_t);
> > +    assert(len < in_size);
> > +    ret =3D qio_channel_read_all(p->c, (void *) qpl->zlen, len, errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +    for (int i =3D 0; i < p->normal_num; i++) {
> > +        qpl->zlen[i] =3D be32_to_cpu(qpl->zlen[i]);
> > +        assert(qpl->zlen[i] <=3D p->page_size);
> > +        zbuf_len +=3D qpl->zlen[i];
> > +    }
> > +
> > +    /* read compressed pages */
> > +    assert(in_size =3D=3D len + zbuf_len);
> > +    ret =3D qio_channel_read_all(p->c, (void *) qpl->zbuf, zbuf_len,
> errp);
> > +    if (ret !=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +    if (qpl->hw_avail) {
> > +        return multifd_qpl_decompress_pages(p, errp);
> > +    }
> > +    return multifd_qpl_decompress_pages_slow_path(p, errp);
> >  }
> >
> >  static MultiFDMethods multifd_qpl_ops =3D {

