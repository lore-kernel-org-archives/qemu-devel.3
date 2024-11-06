Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA63D44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8h1n-0008Bt-7c; Wed, 06 Nov 2024 09:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick.p.edgecombe@intel.com>)
 id 1t8h1m-0008BV-3H
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:28:58 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rick.p.edgecombe@intel.com>)
 id 1t8h1j-0000j5-Sp
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730903336; x=1762439336;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=d51eYy0f+fGtgqXPg0Hscyk/sETpmgVEJ2pOkLJWCpE=;
 b=CiVxYcuXqKzlq0Y4e3dYRqLQUDfUTUJUP0u/wMt0wc2tckaJB01EQuCP
 12j6ZgmjMTA1fWrae/gC1IgpZlSwGkBJh32cB0g85S9D0yleu9YvezGYZ
 p0jPChA50+GXonKESJ35AVHneLWQVu9LP8fqqw5PJLyocaitw0YweRJoJ
 P2FcuQhWcWT8OPMZGnnB+Nctq0YW47JkaYEAK/yENJ++PZ5e+mBY7Zu2m
 J61iGnEii82GNgZpluemQZ70flwtCEreo2+a+udaLoZ9XDmgiIk2rgy0L
 n3PGSJ4UqadRPg8QgW2l0OCXAhDGhJDMPawyB3lBjC0cBGeo+w9davt4v Q==;
X-CSE-ConnectionGUID: 6EbXuNPUQtOFDhaD2R5xmw==
X-CSE-MsgGUID: 326ebZrBS0G8ceSkMIeNxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30130646"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; d="scan'208";a="30130646"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 06:28:53 -0800
X-CSE-ConnectionGUID: UrfUigUrRbe+6J6U8q0SGA==
X-CSE-MsgGUID: xEHKc9EER6Sx46w9wPRxCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; d="scan'208";a="89095992"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Nov 2024 06:28:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 06:28:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 06:28:52 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 06:28:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf3yWZgQCqbK1w2TwnjERQeaem6aqrFYcwwUtGHz1wxqAtuKN8SxDzw0HaNvbCkcnZqaI0wJ0/Pa4vl60jr1/6LziJyUsPDb2q8HIOhXTE1Rli/gSyX0lV26OLGnneY39H3nszvDCWx9iAericEhLIvM+fsPBktgv9z6o/vtSmTNhHaYrrGa8Erhd/FkSNenQobnRjfw/Vj56ZemLxORD/GSNFPmeHo1NyZM9dp2gaJj6qy7Jy+VZgcl+yYp70UyR+kLl1KJkk4kIO659mRhszzXjd5QECso94E8oYnS329FG/9ELhT/IDad7rvUadc/+FPlSWq7sj+SRUFAPmPYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d51eYy0f+fGtgqXPg0Hscyk/sETpmgVEJ2pOkLJWCpE=;
 b=AQqmYlgewr9v1JnoqiNLEfcICndTwmnN1mwtRdRtXNkv59gM3GpI7RYcoFeQP7gtjmV6F/SXNS6llGTUpJAXeLykIeuzTHwEfUodX37ciKQJjxkHS1chAiE3940ANOHPY5MW5QXUJNg6UV8P1UlsVDpZoDHoADd9YaJxudQ9wggJ5V7LsuVlpQTIPNjY+cuL38icwyZzf2CuSZ9TumabXxPKteOex6tfZk1jH66zo8h8fT2t7nHmV/FkmEQ1TxAQarDWPurbTZbcDxK4rToexbBgDD/Q5p0PCdCK3qtxLBy4pRI869PfzOoEYM0K6ejRESi/y6p4bXfbWah4GIK9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 14:28:49 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 14:28:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "Liu, Zhao1" <zhao1.liu@intel.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "Li, Xiaoyao"
 <xiaoyao.li@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
CC: "armbru@redhat.com" <armbru@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH v6 29/60] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
Thread-Topic: [PATCH v6 29/60] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
Thread-Index: AQHbL01XLgLDrqTpCUqGEGAQLvHO3bKpK58AgAEmJ4A=
Date: Wed, 6 Nov 2024 14:28:48 +0000
Message-ID: <d2c4ed5f7c3f9270b26473249af3bb09591ba839.camel@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-30-xiaoyao.li@intel.com>
 <b2893e19e2bac78ec5d7c33e797bb52bcb7a7041.camel@intel.com>
In-Reply-To: <b2893e19e2bac78ec5d7c33e797bb52bcb7a7041.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY5PR11MB6211:EE_
x-ms-office365-filtering-correlation-id: 684da71c-e35b-487b-5f63-08dcfe6f542c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Ynh6U0pVMjg1ckFFVEVyYXZwcDc4YU9LMWhrY204TTFFb01rZ050U1NvMWZB?=
 =?utf-8?B?Q0RtR3U3WmdnWXF5RUNzZW03TEFIbXhUSno3bFoxUlNOaTJ5U0dUVGFrVG91?=
 =?utf-8?B?bXI3emdlRzU1SVYrVDIxa1hOdXFZMjlHTTNNQzRpd3FqM25LbW9rM09Gd0lx?=
 =?utf-8?B?a3Q3ellUOGx0bDFkTVR4SENKODZqV1hEeThORWZQQjQ0MFJ1TlZJN3FBOW83?=
 =?utf-8?B?TDIwd25sYm12ek9ydG0yVHlqUi9FdHJOSGxXTUMxQnkvdHFGZUNnSmVLNEdP?=
 =?utf-8?B?ZnIzOXR4N2RhdW1GazRFRnByOUEzdnltYmhSQlRyM0w1UXNMSVEvYnUrTjkz?=
 =?utf-8?B?cWFQb25jU01yR2N6L1p5MENWQjc5bG8yVTMydTZMLzJYMVdscUlwQ3lxYy9m?=
 =?utf-8?B?Wnd3QUsxVGo4aUcxUDVCOEdSYmJCMU5Ia0FIcmhhYTNjVmh6M0UxY2U2ak53?=
 =?utf-8?B?eUUyRmx3aWtiTmtxRFJkRVg5Z3ArbWZBdlFadkdMMzU0cDZjZktRaDhIbndr?=
 =?utf-8?B?VDZ6bE0yTzFFMHltbS9xdzA1NVNZWVJDM3lWQ3BsTnhWcDB0aVVnRHB2bzFL?=
 =?utf-8?B?aS8rSHVZQUtnWE83MDBDWUo2VzVrQUJhN0JWcGU1L1hObUxING5kTm54dUVW?=
 =?utf-8?B?N2hnMG16U2ROU0phREc5VzV2Mm5hdnhBblR1ZStDZlk3R1ZiR1JESTRkYTV6?=
 =?utf-8?B?emxrL2VkQ2xtbzVhM3B5VFBEWHQzekxMZGpqR2t4azYxU0c3NVB1cVAxYkVx?=
 =?utf-8?B?cTc3dVprZ2ZvQWJxODMvMFJla1hqcjFtWHhzT1FlVHFrSWZ2bWhJbUtxR0dr?=
 =?utf-8?B?bXJaQ1A1OVhsSTNnQ2s0UlhwYmxRNzEzK2pIdG1xOEZTVlV2aGtDL1hDc0FS?=
 =?utf-8?B?QkNDR1RKdnl1SnZ6UEpFYUE5aHU3QlllOWg1ZGhPNHNoZXI2ZUYrenRUZlNT?=
 =?utf-8?B?ek9KTTlGVUJJWDMranFGaHFvK1hKSkxUR29QcXIrczJLR2NGdGVjYXdhMzFX?=
 =?utf-8?B?Rmp6ZW1qcjlxZHVkMC9sSEtOVWU0ZFhQQ1I5Y3V4SnBvWEd5RDQ3R0dTa3dT?=
 =?utf-8?B?WVczb2QzQlZ5ZHNManNoT0VrL3pmQ3MyUWFqVTNPcGFuRFFCalBLQUtZT0lO?=
 =?utf-8?B?cVJsRWRKVlMvTUpGN2twV0dGK3FQRDFnbFlZVzhoYW9ZUU5pd09ER1AzL29S?=
 =?utf-8?B?enRNVkcxQ0FHZy9UcHlLeW9GM0VkQ3dZd1dGVytxSkVtWGJGQ3ZvNGdOUUUr?=
 =?utf-8?B?N0g1UTJBTmJ0QW9oL1dBUU53YXUxZjZJYnlJdDcvaDdnSEMyc3p0R1o0YVZa?=
 =?utf-8?B?ejVsRi9jWEh4aS9rWWtYdy9yamt4TmtiWmRUbzNpeEQrcU1Fb0tyNGM4ZXQ3?=
 =?utf-8?B?RitheEtrL2t5cUprRGZOTXBRZ2haQjNLMzNzYkNuSXBibXJNY0dKcUk2VFQ5?=
 =?utf-8?B?ZUJNTzlvY1BKN3lmaE52V2hOd2h6Y2ZaUWRDN2hsdWRRSWMyeE1BaVluMjBy?=
 =?utf-8?B?b0Vwd3Vla1ZrNGs0QUhlU2NjbmtaNVozUXIwR0ZldDdqMVJVb3pkdWpMeGdH?=
 =?utf-8?B?MW9Ib3NiZVZ0cmpxZmdGaER2UlAzUjdYQnY1czhvYzBnOEM0eThEOW1BUUxi?=
 =?utf-8?B?clRtSUdsem03WE0xNVRMU3JMT1g1SmxXaVlCWU1oalF1b0lJdStQaHU3ZkUw?=
 =?utf-8?B?RFUzT0lFc0lJZHJFczZEd1RLbmhQMGc2V0JHWUNZMllIeUs0cDZpb0NGZ3ps?=
 =?utf-8?B?ZDNSQlBRZk9oM2V2cU1uT2ZSNlZxc3Y2b0tOTFc0ckliSDk1bjVaRyt2aDF1?=
 =?utf-8?B?b2QvRjJrUkozU1NES3dLV01TMTFQVEJ1SUVjZmZoa1hVQkUzcFFRckxxMUVN?=
 =?utf-8?Q?JTnwlJX82LxT5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB5963.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2NxYnlUTEJDWG42Z3VNemZjd0RWdUZTcUpJZXV1Z3U1dW15czZZVmF2Q2hS?=
 =?utf-8?B?SVNabGljTTd3V2IyY0VhSkZGejdEOW9IdXowbHE5aVR5OXFjajBUQlFGUDJt?=
 =?utf-8?B?cUJVV2lVenJ1S3BmZWhJb3NRYVk5SWxqbkthYzVuays1ay8waU9nbUtvRUlM?=
 =?utf-8?B?ajJndUE3NHdKOWJyaStqYTR4QUUwRUU0OVk2bUgyQy9iNzhSbzdPUFRsMUo3?=
 =?utf-8?B?cURuV2xTa3pHU2VpNTYrNE0rZ2QvekxMQUVjQks0WTZ2N1Qva3lpUkRNT3lh?=
 =?utf-8?B?MjQ3M1phemhIMU1Ca1M3L2dDVjBCTXpLbjFJdmVwSDdhaXUybWxobzhmZTZY?=
 =?utf-8?B?WnhibzJQTi9taDBobUpMaFNXSmxoNG4vWlFJVVlDTU1vQmpkRlZxUXFpWi9I?=
 =?utf-8?B?MEM5dG5MZzE4TXd4SWNhWnNTWnBXUytsS0dXc0lrcUJvMzhkbzIyRDY4MnF5?=
 =?utf-8?B?M2ZqM1A2MzFsOXZEYUdZbFhlRzlDMVlNU2NQWGxINWhwbHpjOW8vcFcycnc1?=
 =?utf-8?B?TkJDUm11QnFJS2FNS1hsY2Vsek9XdmxObzFEM2dXS0VmQ08xUVRxTStDTytT?=
 =?utf-8?B?ZE80b2Z5eVhHRG1VbjBUWlJyTFY2a05Cb25SWUZYMDUxOFo0S2xMcHh3ekFx?=
 =?utf-8?B?WGx3di84WHdTaS9WakEwQzVZUCtMNTl1RlVVMVN1dGRSZnZTUyt6bXBURVcy?=
 =?utf-8?B?OVRXb3hYMEcrV2NKcGpiWFlteEc3aHhiQjMwd3Mwd09UcGNkQUN1OXpmS2Na?=
 =?utf-8?B?MFVsTWtPNUYvR0xoVW9xZXNMWFlIN3p6R2tnK0lCYmJsMng1MnpBSmQzMTNX?=
 =?utf-8?B?MFZsZG10a09QajZ6UVdPVWFGL0RnL1JsN3VxRzZpS3V3MDhRUlN4SXlVZHJR?=
 =?utf-8?B?VzdLZHI2TmROSWhZc1hOdUEzcUpDWVhmbXRxUEd2SmMrWjJ1UXRvWHh3YU9C?=
 =?utf-8?B?VkswOXgwMWNXdnpHdFhhVitqOElFZHhJWERyeHhPclFtdWpvalZxOXhwb0xW?=
 =?utf-8?B?bXZxbGEva1FkQm12NlhQR2Z4OVJNQ3pSOXpQOXJ0R0hMZmZwellVY0RrdDVT?=
 =?utf-8?B?b3V0S3FycGIxSHBzNWRWQ1Q4WU5xaE1mTFM0Q0hnZjV1WU54VVNlQWpaTytq?=
 =?utf-8?B?YU8vSlN4YnUxWktDL2JsMWFJV0JGMDgxR2tnVE1yeWdwY21YSjFkZ2tlQ0gw?=
 =?utf-8?B?V0dkQmhTL2FDQ25GblVSVEswNjRiMDlzR3FvdnBjMUJvRDYwK3pQdm9EdFNu?=
 =?utf-8?B?K1F1aCtNek9oaE9tL25EZWdobWZVbW5IdnZBMjJJTWtNTmUyc3pFcVJtU0Ev?=
 =?utf-8?B?cUZFRmlPQTRhY2NFZ2VnWFV5S3lxem96Tm1pdnVHR2JjQVNpcFk5WkhGMVly?=
 =?utf-8?B?WnFaU1VCZWpURlJKSkswQXZhaXFmcHVxUVYyQk13L1c5Y0p2cmFTTHVLNVZX?=
 =?utf-8?B?MWZhZFZEOFhMc09mQWJjRU5GMkpmOWJxU0Z0M0lLNE8vQVVkTDJVajMrQ1ND?=
 =?utf-8?B?MzAvYWd1bVA4MHBsQTFjOEdISWhSUCtyNWh5TndoNEgwTmo1cFB2U3J1MDll?=
 =?utf-8?B?dStZaXI3QkxqYmpNU0RkcVUxaFV0WStIcHIxZ3kxQmVuQ2hkaTJwWm44M3Fw?=
 =?utf-8?B?dzgwZnpJZDB3MVdJd3AyRSt4YVlDYy9XM2tiZzhJV3pHQjlZOGYyYWJWVmdG?=
 =?utf-8?B?WWRRQ0lWUUhuVDFRUkZwUU5uN0VXR0ErMW9Nd0dMU3grMG9MVi92K1J4VjQ2?=
 =?utf-8?B?MmFSUWgzbFJ1L2pFYVlNbTg5Tm01VVNSTWtScFpROFBYUDdiU0VGUEVNaWN6?=
 =?utf-8?B?N09od3FlOUpPU0VmazdBbGMrbHRLSm5TYW4zZTFTNEV6M215NlBTV05RdkJn?=
 =?utf-8?B?ZmNkSkdLVHhFNkRlSi8ybm1kTzY0U0tSYkIrTUxhekduY0NBb0tYMlpZN0JC?=
 =?utf-8?B?anVBTm5JZGZXWC8xdnVJM0pySkJnYXF6WkhlTCs0QWtvcldsaUdXb2d0T044?=
 =?utf-8?B?aEZvTi9aRmVhQzBhWkREenh6ZHV0aXlxWE15RyswWEVocDExNE02cVJQSytw?=
 =?utf-8?B?YUw3bEF5VGQ1dW1RS2M3aVppUFVGT3d2REZNQnRuOXRuOGRIUzRPSDZrZjR5?=
 =?utf-8?B?ZTBVdDB5Z3NQNVZBbzRlVUMvV2RiS0F6ck9TUUM1YkpFZzNvMGg4MkJyUXdw?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFA11DE1F890D347A128D3E0E0D048FB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684da71c-e35b-487b-5f63-08dcfe6f542c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 14:28:48.6380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raMxFMoWge761bclCH3NjOEmrnk+3Q+kw1Y7wU/wl5SEc/OaukxtvQ+2TCHCt5MJQUI6kXemCeX/efDNwVztJTf3tVeh49RPOPV/zotl6gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6211
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=rick.p.edgecombe@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

T24gVHVlLCAyMDI0LTExLTA1IGF0IDEyOjU1IC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gQmluYmluIHdhcyBsb29raW5nIGF0IHJlLWFycmFuZ2luZyB0aGUgVERYIGRldiBicmFuY2gg
dG8gdHJ5IHRvIG1vdmUgdGhlc2UNCj4gcGF0Y2hlcyBlYXJsaWVyIGluIHRoZSBzZXJpZXMgc28g
d2UgY291bGQgZ2V0IHRoZW0gZmluYWxpemVkIGZvciB0aGUgcHVycG9zZSBvZg0KPiBmdWxseSBz
ZXR0bGluZyB0aGUgdUFQSSBmb3IgUUVNVS4NCj4gDQo+IEkgd29uZGVyIGlmIHdlIHNob3VsZCBq
dXN0IHBvc3QgYSB2ZXJ5IHNtYWxsIHNlcmllcyB3aXRoIHRoZSBLVk0gaW1wbGVtZW50YXRpb25z
DQo+IGZvciBNYXBHUEEgYW5kIFJlcG9ydEZhdGFsRXJyb3IgYW5kIHdlIGNvdWxkIHRyeSB0byBn
ZXQgc29tZSBzdGFiaWxpdHkNCj4gZXN0YWJsaXNoZWQuIE1heWJlIHRoYXQgd291bGQgYmUgZW5v
dWdoPw0KPiANCj4gUGFvbG8sIGFueSB0aG91Z2h0cyBvbiB0aGUgbWVyaXRzIG9mIHRyeWluZyB0
byBnZXQgdG8gdGhhdCBwYXJ0IGVhcmxpZXI/DQoNCkNpcmNsaW5nIGJhY2sgYWZ0ZXIgc29tZSBk
aXNjdXNzaW9uIG9uIHRoZSBQVUNLIGNhbGwuIFdlIGRvbid0IG5lZWQgdG8gcnVzaCB0aGVtDQpv
dXQgdXJnZW50bHkuIFdlIGNhbiBwb3N0IHRoZW0gYWZ0ZXIgdGhlIFREIHZjcHUgZW50ZXIvZXhp
dCBzZXJpZXMuDQo=

