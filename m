Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E75C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txk5E-0003bE-A5; Thu, 27 Mar 2025 06:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk57-0003Zg-0M
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:03:26 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk4u-00038z-HA
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743069792; x=1774605792;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UcKJjDHbSk67MeCDdICShpPDF6YYKJRpwpXGRzPAHr8=;
 b=i51SsmbQto/TBAa6ml9BxNYHJ/U/+7ltHw+9/NxDW/4xACv4Um3kUgi3
 YC0X+GaBc3xC+yZE8+LbYU6fYaknVYO+aW9b1xQNeXLoIgmDAlUuS6J6N
 dsvbE1Zj8gCme5nA4eMk0h0gljFh7mPVPTYgx4/dFa5EeLKQsA76rH4jS
 VFVFX41t6IJ3QzMMu6ta4a/E0QW8cYrGgti7v4u1Gki4M14J7XdCBq6mR
 1ncBDCL0LsSZJO6Ax+FNpJY/PbVgZ1UC+oESS941/5ouXegq24QSdHc6M
 RRFaeSsGaJViSCHYpTMbgF31ZDOUqFg/cdnWNX56EX8/VyDsw1sc/SXOd A==;
X-CSE-ConnectionGUID: GqHDi9YiRN2Cgai9WaC+cA==
X-CSE-MsgGUID: kAmbwojvQVOoHCXwWl0kcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44576275"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44576275"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:02:55 -0700
X-CSE-ConnectionGUID: 9L32krsgRyaFIeDcVbTzcQ==
X-CSE-MsgGUID: F33qCRqUQQKOpElPAvjUQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="124856436"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:02:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 03:02:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:02:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNHxmjeC6IhAmVbnFq3ed7itGmkyPF/9uCISxiRqElaoJRVlRzrRgg29LDOfVSqkp1bQ8oe9r8hIu8T03fLbKuGjZC5J/KPLtJv3NfO5OzQwvcJCVptH8MMmdj2yELI54XGWMeLdRRo2MxjNBxIXZEQdD/6qqgdMacMGS4n7eNtkxgK/qqnw3P61geq3l9yef619MxUHawQ/seqf5kZlBLLVsy/rofn9JPGzDSNad2w790ysy4UAwGMDO0NMMOc3pe2wc/5+g4iVjgvOrw4oM1lDVV5UbMqkIykE0rqLA7u7jgtbl/pcLZ+1rOqPcc/kIKS1H+KKTrIaXnysH7lE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcKJjDHbSk67MeCDdICShpPDF6YYKJRpwpXGRzPAHr8=;
 b=F4CfmIORML8PlGvftDHvoqh8rFUogD7OOyuZnEEFTfuO8uiHz3lVjL+rASwLh19TCGc2zYSOxr2mLEydlY0W1AGsAx8trQM/ukGxWubWTr4dMgLrDyzbBj+fSqynjWkB0oWHtLcSZF+aN6BW/TXwJMN65b4NGBQKviRqcrvDh+K2OB6u7dLdIav7YZKAhiwj79XVmCeheynW7Lw9SEWglGbVk8xoA2QFVWMMOGogICgaJkfcE1rGtCqhlOmQ1zkIEvLf5WqPrLpmCychCymADhWmA91+Rz3RaF/86DjF2OnS0VQr8dEVT4ljdbbRPJxZhHh+KvubqTpYq2cFL66hfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:02:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:02:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 25/37] vfio: Move vfio_reset_handler() into
 device.c
Thread-Topic: [PATCH for-10.1 v2 25/37] vfio: Move vfio_reset_handler() into
 device.c
Thread-Index: AQHbniQnI3uwjzjddUedhXHDmyk9F7OGwlEA
Date: Thu, 27 Mar 2025 10:02:25 +0000
Message-ID: <SJ0PR11MB674439F801EE70A74CD0B56792A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-26-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-26-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: 6effbd71-61fc-4249-933a-08dd6d16796e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MFFpTFVXZ3ZGMmdEcW1UT3NFQ2JRRzExc0ZPK1BudE90bXQ5WmRSaWRXeDNO?=
 =?utf-8?B?ZVpxb1g0Q2wzRExuTGxuN2FIK3lYdkMzaHRDbWFrUVF6YnBNLzRBT3VUbGVU?=
 =?utf-8?B?ZUprZGtFZ2RHSFNDWk1GRWs5ZVJ5SGRndmVSaklzbUk5SVFsUmZuYmxSYVRi?=
 =?utf-8?B?K2syaVRCQjJycXRzQjVyTFU0TnFPUkRoeitMdk1SNFZxZ3lXV1dYN1RNVDFN?=
 =?utf-8?B?MG04TTVFRWVqVFRaeGtaOTJiWFM3QzVWcFJQOUJkT2hKZG1ZSGIzdCtQUFZC?=
 =?utf-8?B?bWtLY0VFVGxnd0ZVYWtWMmZhT1FwK2Ntd0FJS3JaOFc2NUlNRUlya1FVVzdZ?=
 =?utf-8?B?YVBqcE9LSVp6L1BNdnRnSklHMjgzK2pqUU8ydmtoUEhjbTdxcWtaYVptQ3JI?=
 =?utf-8?B?QXZXUHRVcFc0b3RmUXBPeEM5NURKb1NaZFlQb242Y3ZGWmhIbnNvVUVMMVlW?=
 =?utf-8?B?OHJiaUw3a1dDM29jYVhYUkhlRTNaM1ozc204REJWMzhubWRJY1c5S09jTGNa?=
 =?utf-8?B?MENsdFF1c0JhdmNpNmdtUlBOSE5vMmhxNTllcnhhanpVcGQ4YVkxTE54RE1t?=
 =?utf-8?B?b0NXSnRTRWQ4OCtXcjl3S3Fhandnbnh3akxPWWNncUUvb2l5NUVSOFVZb2kr?=
 =?utf-8?B?Y25ZL3Q2ekdjc3ZMTEd1eFNDYlU2QzNaNlRQQzJvdUcrWGVZdnVrU3kvZ0c5?=
 =?utf-8?B?RE45YjJMMlVLbGsrUjJQZXZTMmdnMHpxbmJBZi9hRkd5aTZic2Z3TzNvalo1?=
 =?utf-8?B?RjlPS3ZzU2pJcXVjRXZSUXRmcjRFYkpER0E2YUlKOE0wSFNlWU9qMEI4bGVP?=
 =?utf-8?B?QktRbDg3Q1lHWjRJMDUvZjh2Q3pKR0xWWGpwRm5YUHo5YnFybUtVbmUrQ1pi?=
 =?utf-8?B?OWZJOEJSZ3BQVVppekh4SndZTDVGa2VzczZLRGFnZjZFQnVtYVptUjRFbWh0?=
 =?utf-8?B?TCs3a1BnQ2JGQSttM0swZTVBMzhCZndIK2JHV3Y4YlE5WThteVZzVko1dFJy?=
 =?utf-8?B?ZVFKdnF3ODhvenRPMnk5Z2greFU3NEZwMThCVkZOcEM3QXVzdWtBNkNjZWlX?=
 =?utf-8?B?YVVuSTRaWnRwbkpjVXRsMlBxK2NYWnBKenNWNnQzUEMvcHl1Z3Vua0YrY1ho?=
 =?utf-8?B?bFhtYjNnRDJPWTlPK0F4VGxwT0xMSU03YWUrT1FFZEFWRjZRWCtIVW5XMmk0?=
 =?utf-8?B?ZmZYbU9jdzdaKzE3a21VaGRFaVJBTnRGN3BIeTRFbm1yaTlRM3N4L0haZ0px?=
 =?utf-8?B?NzM4Q05uN2NTRWY2YUxXQm92V3JhWWtnNGtEOW1KTndMemhpKzBveEZrSCs2?=
 =?utf-8?B?eThFa1JmbG9EQ3d2K2c1aUxHRVZZQXNaOTFGVFNZSENUQWtPZEJxQ2Y4MkJs?=
 =?utf-8?B?MGVudkMvSDdQZ3VmRUhHWE9GS1JDTUI3N3VEZ1VHbERvdVJjaTNpZTZ0aFlI?=
 =?utf-8?B?U21LZWhwV0RjZmVXNlE1ZVFFSmdYN0tlSEJBMVI3SFhGam1YcGdaNno2OVlT?=
 =?utf-8?B?cTNnL3lSMkVBY3VzNVlWYTg3T1hOalo5NytmdldkemFEb2crRSt6SURpZ0FV?=
 =?utf-8?B?TjUxQnVRL1d3UjEyeS9WenRHYWRQZGdmQWZMSVkzSlJDdlpjVmxEVE9ndlQ5?=
 =?utf-8?B?a25wWU1PaU51dmdwbnN6Z29NTTJ3Ny9jT1NISHNlOHlDaEVxSm9QdFF6WUJ5?=
 =?utf-8?B?aUlzQVhTRzdPQzA1NzJ0NXNkaDhkNjhFcGhUZGJKMXd3UlFlWGQ0SGF0MGl6?=
 =?utf-8?B?ZlV4YnhoZEF3Z2t5YjRCUWhqdXZHdUk4Lzh6WjQ0QTBpR25kY2N6cEc0bk1X?=
 =?utf-8?B?RncxWk5xQjVJMTYySEZpNE5kUFJxem9YWFNGSlN0dHBzTUx3WmcydzhmZ3Bj?=
 =?utf-8?B?TEFhUDYzbWU1VkZKUTR6TTl0OFZCZ2N4MExtTllkZS9nS3NLNkFmRmVRTjJ5?=
 =?utf-8?Q?MLfjwuFZ1eT4vid+hIcgKTZpclRMDp9v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2xlUXhQMVh1N1F2V0VSOTJKTlBDMVVnVlRvY3NORk5HN3YzSm9QMnN5VDVH?=
 =?utf-8?B?eHJ6TVpZdmNYS2RrOGVOMHJtM2ErTlVUa01XakFVdTRWVDd1ZWsyc3JIYlVF?=
 =?utf-8?B?NjY2cTNySGJRUjgzTjBXb214UVRvSmhpNmx2ZVcrYkg1Y2JDSTFVU3JIS0pC?=
 =?utf-8?B?UzI3czg3aEZYa2dmMEVqeW5iM0ZvZFpveC9zdCtnOUg1ZGZlZ3labTkrYUd0?=
 =?utf-8?B?dEFIcWxpNUZWbWFDQ2tuWXJKNzArMUhDWGxTYWxHTU1zYi9Yb0lmZTRETmoy?=
 =?utf-8?B?T1lQTTlaNGNPVkkvMWVaTyt6aHhMTUJlTFY3dm5sbmlTMEFraWRBODdzNDdz?=
 =?utf-8?B?U1I0RUtYZGMwcVpCQkxSMG5Tb1NBN0Q1U2F1SW5SRzlnZVlYQkhDUXVjc0pv?=
 =?utf-8?B?VkhRUTZjTWswYkNGeVNObFZHalhIYVZvdm1FczlNMU9NaTEwbWlqem1HMEo1?=
 =?utf-8?B?MmFycVU0V29YZ1JtZzNtcHlvakE0TTJsbm1PZ1dmKzlqb3I5Rk1FTmRBa1J0?=
 =?utf-8?B?TkpoWERjVEhmTVA1Z3JacjU1TkxlMGRnN1hneXY1TCtOOW0vWUdOMVg3L09E?=
 =?utf-8?B?S1VUd1RyUklJWjBtc1pRVUxHVGs0RUx2Y2lYUXdlV001OTRqTjgyRmxId3dx?=
 =?utf-8?B?eitmM2Q1RWxHRDJJYWdzemdBYlF4U1BjYkQ0WWU1bURSQTV2TTNOOGRpTndB?=
 =?utf-8?B?ZEJKb2VGR2l4ZExGaUxHQlJKUTVPYzI1ME8rcTRGRlZCV01FKzgrN1ZTUHVu?=
 =?utf-8?B?K2NhNmZSaVhVbUJwQlFrbkNCejhGbWM3M1FxdXpXNUdOSXRucCtla1B4eWdP?=
 =?utf-8?B?RnVjUExiOWJQb1REZzBRSWxndEtsdVBrblQ4U1FpUGRqc0gvbm4yNG5nbjVW?=
 =?utf-8?B?WWIzWERlOEpCSUNGNHZDODhmcUI3M01zU0NMNjl3SlhPckZydjUxRU5vbkxz?=
 =?utf-8?B?dWVuQmEvU0dWWTladXFqSjdpQ21TUEFnQnU4cmFYMkN6NGJqeUdFMjlDdWZC?=
 =?utf-8?B?VFFPT0Y3Njh3eTEyQ3EwTlBXWTgwVGZ6UnpCQ1NMY0pwekNwMTI3VzRycDNT?=
 =?utf-8?B?OUhmc0NHUmJlTkYxQTVUM1BkbnVMaUh4OE5BNEhuZEYzck85bHNJVnNkWkl1?=
 =?utf-8?B?VE9kMHloZ3Y2NndHUFRsWWh5UHFscDVFb0R2Q1h4bGlRR2JxZUt2c1RWUGpy?=
 =?utf-8?B?NVgwakRjd2FnY2YrdjVvNXVISFJnc3U1czZsY2FqaFQrRENpbUVLbkN4elFU?=
 =?utf-8?B?UkZvNStCWHhQRVVwMkgwb014QTYwK0tDcVl3VlhKamlONlhacXluN0tiWEcx?=
 =?utf-8?B?QkppdUZqRnI1VFBOdi9vM1ZXWFkvbWM3UUR2TjR5K3MxRnkvWktwWFM0Y1E4?=
 =?utf-8?B?dzkxZnV2YnJrcXNVYW16TkxJRjlnZ1lmbmZaNzRTNGtjNGpJaG10elQrT2p5?=
 =?utf-8?B?NWdaRU56WkhJZFZSaWtDY1ROY3BTcGZyM2ZrOU1MdUZMUklPUTdIeWZyNE1D?=
 =?utf-8?B?VThOdDhEZmUyTjVqMlQ0d3BJVVlSdGhOai9FQjhwZlZJMW12VWVmUWI3blQz?=
 =?utf-8?B?M0NlcmpRbmxRMHhHaXBoc3FGOWZGMllkVlFHYlp1NG9nTjVOTjI0UlVwejBJ?=
 =?utf-8?B?dFFzbDNYZW0zRVoyRUNTMlNXbE81Wkl1UzRJYjhsb2FtSnZ4M2N5dTNsVS8v?=
 =?utf-8?B?OGlpTFhIM1N6bUdZVDdCdnlJbGlaNHo5SktNWk9LYjNJZ3loVkVhK1owR2J6?=
 =?utf-8?B?cEt5TU9mVkhOZnRvT2luZEZYQU03eEN3bGJpNThXZ0hQOGZFeEozd3hVTDY4?=
 =?utf-8?B?czdPN3Y1NnVjbGMrUHZidUluTkRMOXNtSGJjeGh3TEVuOWhLRk5uWXlUUEoz?=
 =?utf-8?B?WjJGcXAveTFBZWhuckxEQjdHOUtRRUFqODRyRGZXcFBIaThQSXJlZEhrVjZT?=
 =?utf-8?B?UnlUSmRCRWx1cEZDcVFBS21Rdm9aKzg0MkgrbENpSklBZEtXaEEwaSthTDU0?=
 =?utf-8?B?dmFIVlJSc1FSQnBQZTE3SXByNTBjV2tQMldPZmFMZE1TTm1ORkQ2RmdBbUJS?=
 =?utf-8?B?Z0N4RUVmbnEraFFXUFlGNlNqNFp5aTUySmhScXJINWx3ZWs4NW5VMU5vRnZX?=
 =?utf-8?Q?VE2+TAV5dTuvu6Pqm6NKgeL22?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6effbd71-61fc-4249-933a-08dd6d16796e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:02:25.0278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2SD+/gTN4WHwPPTXzsqLInLykWpiELn6JadsfvBGRuZZRWitHIJEb56JEm9OJLdZ27hTYHJSLvczni66KiX8NgEb8Meq8gs9UDqtrSs05Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMjUvMzddIHZm
aW86IE1vdmUgdmZpb19yZXNldF9oYW5kbGVyKCkgaW50byBkZXZpY2UuYw0KPg0KPlBhc3MtdGhy
b3VnaCBkZXZpY2VzIG9mIGEgVk0gYXJlIG5vdCBuZWNlc3NhcmlseSBpbiB0aGUgc2FtZSBncm91
cCBhbmQNCj5hbGwgZ3JvdXBzL2FkZHJlc3Nfc3BhY2VzIG5lZWQgdG8gYmUgc2Nhbm5lZCB3aGVu
IHRoZSBtYWNoaW5lIGlzDQo+cmVzZXQuIENvbW1pdCBmMTZmMzljM2ZjOTcgKCJJbXBsZW1lbnQg
UENJIGhvdCByZXNldCIpIGludHJvZHVjZWQgYSBWTQ0KPnJlc2V0IGhhbmRsZXIgZm9yIHRoaXMg
cHVycG9zZS4gTW92ZSBpdCB1bmRlciBkZXZpY2UuYw0KPg0KPkFsc28gcmVpbnRyb2R1Y2UgdGhl
IGNvbW1lbnQgd2hpY2ggZXhwbGFpbmVkIHRoZSBjb250ZXh0IGFuZCB3YXMgbG9zdA0KPmFsb25n
IHRoZSB3YXkuDQo+DQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRo
YXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

