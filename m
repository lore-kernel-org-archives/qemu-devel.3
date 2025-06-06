Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4BBC5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNT60-0000nx-Se; Fri, 06 Jun 2025 05:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNT5y-0000nW-Pw
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:10:38 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNT5v-0006oH-Ek
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749201035; x=1780737035;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QUYfiCoBtR6YCcUHsenG2EAlDMw7AyWnUShmpRddBHY=;
 b=I69xKQgDcUE6gLny9ZK5NChgLmqf1z4IqC1Paytq/QHVpGP9TFoN+YGv
 AyptP+PvHvP40GzqvsRv/7+I7SZO+24eSEGZoC3AcM2az+G+cdajFDtC/
 YWBSLpOK1owtflIYLSNvrrm5S5iYypp2rGXbT9yUlhzlnVVKGtrz5OOvS
 sGNYY+y66eA1pg1rLKBcYkG0xGuuq7NIxlBro8rvoJ0vP22rxKY43peJP
 deoacKPXxhzCzNfBzBYh2I2gWasx94c4bVPjaXYupVTAFVmmH68H7VLqn
 0IdBQDkcLFllGX2qvTvtOKJ12mdAzPeElz4+ZrIz8G9y5rTZx/g2wc+bU Q==;
X-CSE-ConnectionGUID: jugRVh6mTz+q1c3USNBRpQ==
X-CSE-MsgGUID: i+rHUs7OS1C3KuexJZqyOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51048512"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="51048512"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:10:28 -0700
X-CSE-ConnectionGUID: fRi6cNn7Q4SaiykUrsS7cw==
X-CSE-MsgGUID: QDmByeE2Q0uCmP3Iu/jK4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146731111"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 02:10:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 02:10:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 02:10:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 02:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvGNjKp15X9ULQ+Pa5cPLQo/AJ3mw7MbuPwNfWUfL1uZiaXB71rCETCCsIvAiS0Wp6tBqgGNcF3Yx0gnxFADhEOAnp6lAOv1FRYU81YGoM0CmppCMJopFzeSmRXR5kggQDcWisLxk5htSiKn8gBak3nzk0bTrcyJNgAcNTHrlRITNvPU/KOJFc8x3PwM2hq2LKwj8bKwZjKW1ZcvxSi9yavC9SZ6p87PcPGSgd6/hIpHs/IWtmhNaLyOh1Ik/1OQEq7RJJtWi0Dh3+7p2sdPm1yrGGBJGS3SfvNFjemCdQWB3rndS913QZcLZTQGbkbrgQpPxp0KURtX+PuxfPR0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUYfiCoBtR6YCcUHsenG2EAlDMw7AyWnUShmpRddBHY=;
 b=dhMM0Ws2w5uN556iKAsolEBT/16+9ZYqbwtqeOAatw9CEM6EKWA9FSNjFXHx2AYRlrK/lkXaXjz+U+xlR9ySM7wHm8LvGEgoI8aTA2Eda/XpA+LpYJYZUM4xLd9B4dXrV6U94nH0wyJG0Ie50wZ9KOJDYg1CbyJn5kcVsFcixANPfdzX81NJ1j+HUsSVcgQ5327K+e0Qg3PgdUiK5x/pkdVTeBxNQEKEH5KUJkBy1Jfzw0oIswr7K1HkdFA3CTqMJWP0d1a2HoULSY7pOnH3I0rxrOtONkEcGHRUOZNK93MaWyHerw8UZ1QjG7TACNptld7fZIKsUk9GrQO3eASa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 09:10:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 09:10:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, "david@redhat.com" <david@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v3 1/5] virtio-mem: Fix definition of VirtIOMEMClass
Thread-Topic: [PATCH v3 1/5] virtio-mem: Fix definition of VirtIOMEMClass
Thread-Index: AQHb1gRkQWJulWeCk0qZtD5gIOWzqrP0ZX34gAFzVfA=
Date: Fri, 6 Jun 2025 09:10:24 +0000
Message-ID: <IA3PR11MB913682E2D55E3607C52E7F93926EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250605102311.148171-1-zhenzhong.duan@intel.com>
 <20250605102311.148171-2-zhenzhong.duan@intel.com>
 <87cybiihfz.fsf@pond.sub.org>
In-Reply-To: <87cybiihfz.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: b6879368-b2d1-4762-0b8d-08dda4d9f8d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkdocjFpSll4aW12NFFqNUJhY3hQaElIdkMyRWFrcmgyam8wVXRqaDNBd1Vl?=
 =?utf-8?B?M2NRV3JNazFxSHdNR2tCZkRzZlpNWmZBRlRabFF2WXZ5QUN4dFg4a01vWG5E?=
 =?utf-8?B?NHplSVJjZ3oxZkxrTXBNVkp1QVdVZ0JYbmhlZldzYmdOVDdocVRVZWtJN3FC?=
 =?utf-8?B?SUgyQzlIU0xMK0lRcHJrUGV4QWJBYVE1Wm5JQVY1WVh2dU9vSmtLSG1VdjFj?=
 =?utf-8?B?bjRlQTRHcGZueDJyUWRNTHJRTUZvVFB0bWNOU1ZyWmtEZWVwdTB0QkoxeC9E?=
 =?utf-8?B?b1ptem5GeDg2UEdnazg2T0ZaTm16a3VSL1N5V3NQZGxWZkxNTitDZ0NKekZD?=
 =?utf-8?B?VnhuL2w0QlZrY3dqNXRzNjVSdFlTRU9xWkFacmxWZ0loY0o3TUdpbWp6dmpz?=
 =?utf-8?B?amFScW92Zk53TkFLc1ZDaVdoYkl6ZDhsdkQ3N0dMZjhmTndGNUdlQytWMHBQ?=
 =?utf-8?B?RWtQQ2dGN0pzLzduNUU2aTcxSWlNQS9Sc2d0VlhXUGREN1crbU4xQTJjYzFG?=
 =?utf-8?B?cVRRdHVzZkRackkwdGRDSjhmZFVHWnArYjZ2VFMxSnFBWFY1RHd1alVOZkhp?=
 =?utf-8?B?MTMzVDdsdUc3aytUVmt1QUZkMis1Yjh0c25BU1hHVFBrSjM0dU5uM1VjSXV6?=
 =?utf-8?B?V0RRYXN0K0Y2dXlLajFJelAzVld0cWY2VW9LS240RFFZYXhEbG0wT00wb0R2?=
 =?utf-8?B?MElSbWs3SjZVak5iYTBHZ1NON3ErSHd0ZklENnJ6ZFVSblJwWXdySWNtSWRH?=
 =?utf-8?B?UU0vU1BTaXVvbFVObjZ5b2xBOVlRMVZoNitLRVh0d3dSa25EaldHVHlnY0la?=
 =?utf-8?B?RlF3eXc1aTl0MWFlbGpYdzBDQU9EZzdsdGN1RXU5OS9tMU1KVVMyYWptK0VB?=
 =?utf-8?B?QndtNXU5RjdmSEgyVTMxdWtyT3dlc3FXdjJkM2VpSmVQNnBWbm9hNGRmU0xI?=
 =?utf-8?B?UEt3VmFEQXoxMVdkNVRrMUtiNWRQMk56RjBkYVFGdCtZdzVuU2ppQ20zWVJh?=
 =?utf-8?B?M0hXTVBkS0xRYUIveDNWQUJ5dzVMcXpDSW0wSWVUQ093bi9sMWhTMXAyVlpN?=
 =?utf-8?B?ZkxQb01pU0J6OXVudkxaVGJzLytKaFcxOHVlUUc1K2hsR3d3ckZ4bVdjdGZi?=
 =?utf-8?B?azN6Uit4OHc0WDg3OXgzaXNCa2t4MTRnS28rMm1IYUtLc0haSmxLalVHVFNl?=
 =?utf-8?B?cVRMZWUxMFhkTEpkSysyaVlrZEhIMzdVUWhQazJYVnpIUXZwd1FPdnJCTG13?=
 =?utf-8?B?Y1EwcXc0cXM4dFc0Z2NES2hoby9yMzFJM2xBanNxMjNyNVl4dTk0WnVHb0Fl?=
 =?utf-8?B?QlVXdTNSNjRUcWxWVXg5YUw2Q2xVNlBOc2g5QVlhd2NuOG8zYkFRcmJ1dHIx?=
 =?utf-8?B?OTNoeFNSRDE4QTErNnVCUnlQandkZzl2SFRGRFlsT1ZCdzR0alkvaFdBaExt?=
 =?utf-8?B?U0lmUVozM3VjOUh4UTE0N2Y1U29sZ2EvWWtLSk14TnhWd0lJY01RMEdRbFdm?=
 =?utf-8?B?cXo1RjZRem8xbGMrS3lFK0kwRkNjTWhuTVdKb1h3QzhTZEZ6b1JYUzZQaHNh?=
 =?utf-8?B?U3lveCtjU2tBVWhQU3pwS0locG1Rc3VFdmFEZElkeHZtVjhkRHBGczJDSSs5?=
 =?utf-8?B?NGJPU3A0WWVyVzdoYkd0ZHcza2k0SFlvMGdQYXZ0Rm5PZ3NSeDRCUjNYb0hz?=
 =?utf-8?B?Z0hsckJUeHI5Vy9EeXBLQ2pJcjlZWXNGTi8zQzNsNUtQV3ppOG8xOWFXRUxh?=
 =?utf-8?B?WmpuRXVrZCtNN3VtNWRRc012R0xQaGdkS0c3cXdKODlKcEVhZS9Hd20ySE1N?=
 =?utf-8?B?K0lUVmJUQlJSNXFjRTU4ampOekRmSXpOR2Q3cjZsWkpNaHIxdHM0VVpiWTRu?=
 =?utf-8?B?QzZzeWYvMWVUODZtOUllWE9sdm8rK3MxVElhSVo0UnJXUklxVWVFeWhZcGM4?=
 =?utf-8?B?eVFZRFVnVTRmYkVUMHN1bGROQUVjM0VFbXc0c29iN1BhOEpnQ2pKazI5N0lC?=
 =?utf-8?Q?y8ACGk3nsYqyHLce1Cv0fCPW4ml0Xs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVlETml2dW83cmlOejFwZFRQUDZIYUM5VlEzVHpXbGxhYXgrOVZUdExGa1RB?=
 =?utf-8?B?eXZxZ0NVdlY2WGJ6QjZQSjNQZ3BmSVZldy8welp5YW9YMVU2MUZMQ0ZUT21h?=
 =?utf-8?B?TUNWWlZLQUQxMWRuWmV6NTB5UVdoY09kclcyWXl5T0w0NTRSM0ZwMWZJNHB5?=
 =?utf-8?B?ZElvQVRkcDZSZm9CZkhqaGhMdlh1UUtBdmxDOFN1a0VTN0ZDc2UxZ2pUQUJr?=
 =?utf-8?B?cHY2cU9BMVU2eUM1RUNYM1hDeHF5eG4ralV5NUJyMmxTY1NKQnNycG9PeWlF?=
 =?utf-8?B?Q2E3cHEvYkdyNG5NTk1HeUlidkYzV2NMUjVEWjlXcnVKRlkrbWJ5dmVXVTcx?=
 =?utf-8?B?c1FtUlFMMTh2OENibXdsYUdqZlJGOUllWkY4aUxwUXNhRHZwdk4zL3BlcnZB?=
 =?utf-8?B?dGthUmdzQ3BmNVViTDNQd2tLNHJQVkRlMVpNZEg3U3Q1dHVtcHFaM0lqTWly?=
 =?utf-8?B?RVBHb0hvd3JTSUNtaDdtdnc1S3lLQ21tRlp0MnF3cmpLekNLSDFRZGhJZUhQ?=
 =?utf-8?B?WW02YXJvaWhXR1NtSUdqOFZTNzdhRjVEZzNtL1oxN1R3UjU5NDR2ZE1MZ2d5?=
 =?utf-8?B?OEJjcGRkRFlwVmF3cXhUZkNHUklwZmlwV2Q2Nng4Mk5tSGttVWgvZzBqUmc0?=
 =?utf-8?B?cmRMc1hkU0xrd2crYU5tdWNBMzg3SkEvYzVXb3lrVzVxN1NqeWpTbkF3QlRj?=
 =?utf-8?B?OUc5VTAzcUx2TGFNeGlIWmcwZld1MlRTTmZNaEZ0eURWU3V1MjZNZUJLaWRI?=
 =?utf-8?B?dFhxdUw2TFBqRVlVVzdhNyt1UnpJdTkrMHlEMTZwV0Y0RVpKVTVvMjJLMitK?=
 =?utf-8?B?QnlpeHEwaE1wNS9RdG5UNGxZamsvNWlZZlMyTHFsZFJiQ0N3bWtoSmVxeXVj?=
 =?utf-8?B?TVV6bzNQZFJ1d291dkVUdW5Ea0NSbzNhUFNvUFI0aEs1K1lpRHNSSkxaVkVK?=
 =?utf-8?B?RUl5d2loOVZRN2hwVDFFYjdoRG83NkpxZ0ZZWENCVFNwOUNVMC9Md0xBNHNZ?=
 =?utf-8?B?NUJEYUo5aHV6YnNHNHhFa2xCMWpEcUs4TmNHL1o5YnVFQ3VDaWdPbENvTCtv?=
 =?utf-8?B?T2h1M0Yvb005VDhJcFc1TXcrc2psU1J4OFJSZytLMkdLcjJDUjlVbWpkSU44?=
 =?utf-8?B?SHRqem1kaElkS1Bza2FjTFk4dndrZXZCQktJbXZIaXZWdDhwelNJQStENjQv?=
 =?utf-8?B?bSsyWXFKdGhiRDdUNWx5bkkyamZndGQ4ZlhKMEp5OVFUWUU4dnpQY3JrMCtG?=
 =?utf-8?B?eGxOQTVZQVNSaGRyKzFwMUhZUWRzVEtLQmVVZnc4bkFZNUd2WFcwMUFkYWVD?=
 =?utf-8?B?ZkxwUGtHRithK2hhRjgvSDdWQ0xwcGhqQlExY0JrYlpHUUpqeVgrNExnWFF5?=
 =?utf-8?B?ZXk1eEdIL01kbS9HUnV4VlhaT0E3bGVTMWlvQTFuUDBtNXJwYzh6dDJEYWxV?=
 =?utf-8?B?Z2djeWxEeml0ZWRsTm9Cai8zUysvT2tVVkEwVlk1TW9xZDk2SnFjcmRlbFcv?=
 =?utf-8?B?R2NOZGtESVNzQzJlc0tvZUYrNFFnMTUwVzUyNTlnanlqd2hwVXhLK3FkYUJZ?=
 =?utf-8?B?clVuR1hSaVU0amMycWVZSFpPTUpsbGhTMnczMm9JcVRmRlpkVndoenlvL0ht?=
 =?utf-8?B?WnF3ejBuR3B1akZ1RnI4YXZVTDRkeE1qRzU3K1B3UURQOU8zMThDaFRndk8y?=
 =?utf-8?B?ejZPT1I4bWtsbXN4N09TUzhLdVMxMURVYndHNFNVcXNaeDV0bGs1cm0vRUNG?=
 =?utf-8?B?NGs1VlRSekFaZVZ4c1JnTFphRy9ZNXlIUkhmYXVacDI3akdQcWhuWlB1aUhI?=
 =?utf-8?B?alJrTWhkVHpWbVh2c2x2d285aHFxRWdKemEyWWVGT3dPSklveGxmQzNSZU5I?=
 =?utf-8?B?RXV6Zng3TVREUk0yZlhTdE13cEVQNzRlMHZuS0dWQUtlMVpxS1dQWnUyV2lE?=
 =?utf-8?B?WGNaQlNBZW03WStrYlNTQmZhWnQ3ZGcyM3BIYTUzTnN4TG1meDNTbCtmR3du?=
 =?utf-8?B?WnRKaFRvUTRjTlNKVjgxa3poU0E4NU9CZi9jYjlWMjNBcUNQaTlUaUZFcXJ3?=
 =?utf-8?B?L0RxTktrT3IvTjBNK3lwQjYwRDBzOVB4K2w5TnhiV25pUzVMVWhyc0tTaURZ?=
 =?utf-8?Q?dGQJz2Mqw9/s6d34x9j/Yw9Xj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6879368-b2d1-4762-0b8d-08dda4d9f8d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 09:10:24.5331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGId/zhVkusdnC6LY7nLGnUEZqmCIWGRS7vJBJTH/ojHyMfa49yuzI/IfsB2k4j8xDYMRY4j6xw174Y2Atyq1JVYMMBfEfcCN2cU0TA/Aoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNV0gdmlydGlv
LW1lbTogRml4IGRlZmluaXRpb24gb2YgVmlydElPTUVNQ2xhc3MNCj4NCj5aaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cml0ZXM6DQo+DQo+PiBQYXJlbnQgb2YgVmly
dElPTUVNQ2xhc3MgaXMgVmlydGlvRGV2aWNlQ2xhc3MgcmF0aGVyIHRoYW4gVmlydElPRGV2aWNl
Lg0KPj4NCj4+IEZpeGVzOiA5MTBiMjU3NjZiMzMgKCJ2aXJ0aW8tbWVtOiBQYXJhdmlydHVhbGl6
ZWQgbWVtb3J5IGhvdCh1bilwbHVnIikNCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogRGF2aWQgSGlsZGVu
YnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody92aXJ0
aW8vdmlydGlvLW1lbS5oIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92
aXJ0aW8tbWVtLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tbWVtLmgNCj4+IGluZGV4IGJj
NGY3ODc3NzIuLmUwYWIzMWI0NWEgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92
aXJ0aW8tbWVtLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaA0KPj4g
QEAgLTEzNCw3ICsxMzQsNyBAQCBzdHJ1Y3QgVmlydGlvTWVtU3lzdGVtUmVzZXQgew0KPj4NCj4+
ICBzdHJ1Y3QgVmlydElPTUVNQ2xhc3Mgew0KPj4gICAgICAvKiBwcml2YXRlICovDQo+PiAtICAg
IFZpcnRJT0RldmljZSBwYXJlbnQ7DQo+PiArICAgIFZpcnRpb0RldmljZUNsYXNzIHBhcmVudF9j
bGFzczsNCj4+DQo+PiAgICAgIC8qIHB1YmxpYyAqLw0KPj4gICAgICB2b2lkICgqZmlsbF9kZXZp
Y2VfaW5mbykoY29uc3QgVmlydElPTUVNICp2bWVuLCBWaXJ0aW9NRU1EZXZpY2VJbmZvICp2aSk7
DQo+DQo+Kk91Y2gqDQo+DQo+SSBndWVzcyB0aGlzIGlzbid0IGNhdGFzdHJvcGhpYyBvbmx5IGJl
Y2F1c2Ugc2l6ZW9mKFZpcnRJT0RldmljZSkgPg0KPnNpemVvZihWaXJ0aW9EZXZpY2VDbGFzcyku
ICBTdWdnZXN0IHRvIG1lbnRpb24gdGhhdCBpbiB0aGUgY29tbWl0DQo+bWVzc2FnZS4NCg0KV2ls
bCBkby4NCg0KPg0KPk91dCBvZiBzY29wZSBmb3IgdGhpcyBwYXRjaCwgYnV0IEknZCByZWFsbHks
IHJlYWxseSBhcHByZWNpYXRlIG1vcmUNCj5jb25zaXN0ZW50IHNwZWxsaW5nIG9mIFZpcnRJTy4N
Cg0KWWVzLiBCdXQgVmlydGlvRGV2aWNlQ2xhc3MgaXMgd2lkZWx5IHVzZWQgaW4gUUVNVSBmb3Ig
bG9uZyBoaXN0b3J5LA0Kbm90IGNsZWFyIGlmIGl0J3MgZGVzZXJ2ZWQgdG8gcy9WaXJ0aW9EZXZp
Y2VDbGFzcy9WaXJ0SU9EZXZpY2VDbGFzcyBub3cuLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

