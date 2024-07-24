Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9C5C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 06:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWV75-0002Jg-55; Wed, 24 Jul 2024 02:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWV73-0002JA-FY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:04:33 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sWV70-0004RL-O5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 02:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721801071; x=1753337071;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=S+UgSC9vrHrXDTHkHEIq1NhHtMD1aiWBhAd0EUld9PA=;
 b=lrFIptDT4XZc4KmEMSBUGZ6tZC0SrzxF7NYYPxIBvtT13YNJyHIi4N7S
 FQlqfHH7hN7w55IL8HeOzpDQzRCEmFio6DEamT5OqZGSJkkYJ5R3Tag3P
 CRinyHOx3g2p65T0I+wHUpzankx3pHh1RBkpY5FOQQSocBekqb1bh63Ch
 QjNHN+PNXMtMXRcuWIvjoH7BypOaJx2vFNt3NIcgS1r+nEIlCcYwh5W/1
 QaLBRv5P98G5+1OYcfdkIDzYjbgjuLwJrE3CqaAwEFQ/Rgtdfn1rPiw1p
 feF6CVdC7ycF01o/MWbZ4UVMx+a3SDJhMyliBxVfyaL1wb3icoktGs60W A==;
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; d="scan'208";a="17073380"
X-MGA-submission: =?us-ascii?q?MDHfRp6txMPP2Wwd+QEDN8aK00OoUPXedWXoDq?=
 =?us-ascii?q?wf6jpm7wFwnQvKfb9f6JESwGlIRMeizzffVnhM9AZ87fZ9fhUSCMUkmK?=
 =?us-ascii?q?woG1dv1Rrdiumv3+JzDJsV24ZF2QqN0A30DOpl2NBD8A8ICwBsP+qxaA?=
 =?us-ascii?q?gA/auvCZ+yJ+pmD7xVd5wTUw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 08:04:27 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZWHXr+gDgN6wgZlCzfwI5G/dDuqynejtTC8p1ZFEAzarHeb+F/lqPXdH57//ninObOwCI3/tYJig6iewHc6bAGVX+qXQnAAr9FYyJpqjP5Jpy7rkdgmOwMyY0kdgBI4Dl/Xd/gQI9m57M9aAXrHvL0yNZ7yCkxjsEzrylQGzlha3i5aWr9bNxb/k/HcCCV9bUTuENtzkqsyaGAwKOJDrN5YNUrOo0YnPkXCaKxExs0nCRrP0HaSPYcMoL4nJBD8WeLTNDhicNMucf+On56vMqdQ0puO/spkrP/fN9FGtQXl+g+NZE3XPQ0j7qnUAvx1O2uVO7ZkCWUj4oAzPdjPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+UgSC9vrHrXDTHkHEIq1NhHtMD1aiWBhAd0EUld9PA=;
 b=n9dWFznB6/w298TrgrgywRSxenj4oI/6zETd3is0W7hafF928EyM6ntK2mOOwTpAWwwGHYwltbLABZW414NtVtpq7UFWHq6D2m/1OY4ZxA7KHjyAOmEIs5u8jUSmjvfhTm36NuGwbsNXewQRaF6oJcF4nFYRRa2phgYhiZWJ1SSvG69e+5D+gQOkUAqSEgFyhk9T4duC5xhkmcUuCyxQViK7uBriS1qqvLlHcHlNDRmwjYwbBgp7lZrjDkjtXKm1UxPJ6xJIX0z30SbxGxrP5+W7FBjIJ0RTA+LU+7rfBvdu34Djux2ioxS2eJHR1gnTVyDBWXtQ/rvkiO3ByEAYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+UgSC9vrHrXDTHkHEIq1NhHtMD1aiWBhAd0EUld9PA=;
 b=jSM62482kdK2boN8Kuaaw/t3HWZd+E0wo/sPvbeK6squuakEnjLIR1Fwi7X+08Npt0Av+hLVW7GWG0KoHMMDnq6vY6oNYMxzbykgiD0u1TnAVPLim3G1vgHrT2W7V9acGMDPTjXuIXnfhzCscEZhnS9XCqzy7Mc5ZAMrN9w+fzRF+lITZzUt7uScKazXGXVOQPn+cG+D5YMrH/tkZRgp8Nah9f0UeCY52twnBkLCj+nfddVZBExh5MwCjLYR6ZGYObERl+dVzPQ5e+MJgp6PVHF5AhKNwydRnyqrW6w/do1tsCxj8DA6xGOiPfiBqgcGo38nqYJvEqtPdgTDwr/p+w==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8220.eurprd07.prod.outlook.com (2603:10a6:20b:377::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Wed, 24 Jul
 2024 06:04:25 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7807.006; Wed, 24 Jul 2024
 06:04:25 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v1 14/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHa2OtXvGur8faoMEeNH+HzRNGOm7IFZ3mAgAAFUQA=
Date: Wed, 24 Jul 2024 06:04:25 +0000
Message-ID: <dd6cf2fc-a18d-4730-a351-be4057b6fb31@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-15-zhenzhong.duan@intel.com>
 <700f34b1-d020-4a1f-86d0-878a0628cc5e@eviden.com>
In-Reply-To: <700f34b1-d020-4a1f-86d0-878a0628cc5e@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8220:EE_
x-ms-office365-filtering-correlation-id: f7e23e0c-cde9-4808-e71d-08dcaba67865
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M2sveGdWODZ6TmtHcXRKOXF1MVNMcE9yaWF1RWtvdnkxNHdoTVY1TUhXZ0Js?=
 =?utf-8?B?TDVYVmY0SVIwT3ZPRGZvY2JjdHBOaDZqQlRySFIxVGFoelFKMTEwckR4Mms5?=
 =?utf-8?B?b0ExejA0QW92Q1R6elVwRG9mcHEyVGhNWDc0OHdGUkNYWHEwb1dwNjEzL3lW?=
 =?utf-8?B?K2tCSEZrcU5oZXNoWkxLUVJybXNLa2pEdGpKdS9WUjV4WFpiRVFWaGxyTkdC?=
 =?utf-8?B?ZU9SdFU4RkNZN29NbGZHK1ROdjJ4cUtUbytUSW9xUHVhSWM1OGNZMkdKYmpP?=
 =?utf-8?B?OUx3ZmhnNCtoTTUyT2c2Y2xwNG1taENsS0Rxekw1YmpnSnVSaWFRLzlOQUNH?=
 =?utf-8?B?anhYTGJkQi9kSTV3d2dhdmdMUWZxTjZrQ1hVZ2hDRDlxT1o4ZVZXNnNvb24v?=
 =?utf-8?B?eWdrV1RoYWNaTUU4QzM4TlprQ3B6aWcrZDgyQnlyK1cyM3lJdDBCQnlPZStx?=
 =?utf-8?B?Kzd4UmdGTmxWWGcvdTBYS0k5bUFYSVhCYkRkWWVXbkwvS3pxNnRpa0tmZlB6?=
 =?utf-8?B?Uk1tZkpabHk3R1FCa1JhMURGaHk1RHdPdlhqeCtVUThWR3dxeitsbVlseE02?=
 =?utf-8?B?bFJubG9TRVFBbGdwYlBCZnRtVDBBM2pvSStBS1VhSEpjSHhWL2ZLL05RL1hx?=
 =?utf-8?B?QytBTG5kYXNEUzlmbFFyaHhqQWJXNXJ1OU45RzFBUFFqL3F0MGlsclZ5b3Qv?=
 =?utf-8?B?MzNvYTg0bFFXbkRXTUlXTTNObTJuSFBHL3BhVC9PRzEyUzU4bkh1b3UySmlk?=
 =?utf-8?B?Y2xhWGR1dnB6cUszeDQ3NWphWjFOcitPaS9iSDlXVU1KL1lVekNhSGg3MDND?=
 =?utf-8?B?ekl1ZlJlZFRPV2huZEtMQkJoT0FuZk56OHRRT2kvZ2RENXVDdENua05NQWp1?=
 =?utf-8?B?bUs2bkJ0aU5BYXVDU2pkTlNlZkMxeUVqRm1pS2dsQUdWZ1dPTXVYem91VFVQ?=
 =?utf-8?B?TEpyVVAxMFlST3lLNlU2bnpNeElOeDNvb003OWU5bDFBcjJiakFyWHMwZ3JO?=
 =?utf-8?B?d0EwcjZ4Qno4eG5XdHdMQnBwUDE1ZUlSRkYwSUVXenFrcHoyZWZRYk9NTzIw?=
 =?utf-8?B?QmxGUjY1WHlrUE9YbnZ4dHNtbWt0eGU1MHhaWEIwUnlJcm1zTjlMY1RSQUln?=
 =?utf-8?B?b2FTQitGY25YM2FiS0Z2dERaSi9oTUFud0V6QitDN0Q1N0djMys4WXVyVWpa?=
 =?utf-8?B?eks3TjBkcXE2WDVmKzkveWRnUUxNY2hKVWxPOEhkdFo0Y1N5N0o1WkNFZnNq?=
 =?utf-8?B?aXNFOGViWVJERHoxRjZ0d2s4RnNuZDRGS3k0NGVEZEFyZ2VvOFZpYkhMVktu?=
 =?utf-8?B?eFBYVDhld0JuckxXQTJiZVpORU9Zb3FkNFI1TS9QTTNCSnpVRmZlNGtVK2RH?=
 =?utf-8?B?SzlRU2MyQ0JHRVlJNm5mZlpmUThmQVNpMXgwQnBPMTJEVGx2ME1vL3BIaUVQ?=
 =?utf-8?B?SlFRTk56dWtXdm1qWUtqMmFSQzRqUmpvNGh0d1A5N2dkT2V2dTdFOFNJTWNX?=
 =?utf-8?B?akJOUEw3SmtlQm5WMktOekhYV3RPUVhvVHVQdlRoVGhPSDY4czhBOHVveTVR?=
 =?utf-8?B?bndJWk1MZTdhNkVMbDZDV1J0Vm1nYm9yNFFPQlBmelRGSVM3a3dBaXFMY1lp?=
 =?utf-8?B?WTBhbnByT2p2ZXA0NU41TFZvVnNZekJYckpPSFZ5ditqNzBiSzhkYkdTYU1s?=
 =?utf-8?B?NlJQTjRkQ1YrS05ER0RjVWRONDhiZCt3Y3d3dzYzdGZ2SDRibGVGSEV5bjZU?=
 =?utf-8?B?eU03REMvYTdTRDJmcTI1elR2RDRmc2l6T0tMcFRYZGt6dm5YUjJERjNuS0tY?=
 =?utf-8?B?bDlFUUQvVUNKMStUS2tLYTVQUEh3UURwTzduVjV3amJTcE1RUGpvRHZ3VWUr?=
 =?utf-8?B?dFdmQ2RVcjhvdy9DYTB4NFRlQ1d3U1BJa2NpeEVGYXZ4YlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azdvdXI1enVnbU5keE5PeWhHREIzbk05d1FkZ3ZMb0xXTjgzWW1jSUg5RlY0?=
 =?utf-8?B?UzR1SDJpQWlzOGNCNXV2OXE0a0padlgxRzRwd2t3bGVmZ1ZlNk9zSmtkeE1P?=
 =?utf-8?B?SUx3T0VDYmU1SXcxdlpVK2ZDOFowcUM1a2FvU1Z4akZSb1ZKaFNMMWtCMjN4?=
 =?utf-8?B?NnAzNkl1amVmbmN5VDdIeVA0N2RKYUZoSFAvWEI5Y0xqRXZOTnVoczNxSUd4?=
 =?utf-8?B?UlZHMEtFSExGOTB2TDBYdUJxbHl4Y0Y0eGRtalFLSnE2U01vbjRCQUpLd3hr?=
 =?utf-8?B?bnhjYXZJQklUNVBxZTl1Rytpd2twb0pOMG1ld0t6b3pjeGsxVHFrWElZZ01w?=
 =?utf-8?B?QzVhTXJxVjRsT3JwL0poVFVLSkZsZUVTanBqcE9LZnNnam1JR0pNbUpROWV6?=
 =?utf-8?B?eXNCdWY3dTBkWEFLWm5IN2R0MDlNanlGeWc4S1hKSzNDWGUyMWNBdVZBeWUx?=
 =?utf-8?B?bE9ZTFpZWXo0R28zOG1oTWVkR05SeTZ6V2lERFkwQWFKVFZ0WDRrSDdSbmhI?=
 =?utf-8?B?bWh3bTRjYS9ESUM0bU94ZnU4NjM0Qkp4dFhrQmNWelc1dS9BTTkybVliMEhJ?=
 =?utf-8?B?ZG5BazMzaTBnc0c1a0ZhTzdLdjhKUVF4VHU5YTJmSTVSYTNGLzUvNFBvemhm?=
 =?utf-8?B?UGhSQWRoUHN6ZUNia0dHeGRuYUE5VXY4ZkN6YjM2YWRZTmU2bkNZOGN5SjI2?=
 =?utf-8?B?RHd2ZVBtOEx1SitYbGRkTkltdWpFeThNQkVMbkoyVG9JSitOUEdPL3hmVjl6?=
 =?utf-8?B?L0FydzBTb0pUMUVCa3F5WUJpQ1BHUGMxM29YNk5vT3l6OXJmK09BcWxRcTVL?=
 =?utf-8?B?cGttWU45NzJmSUk2QmRJZFNKUVhwNi93Nm1yTlF5V1E3MS81bXh4aVJPWlR0?=
 =?utf-8?B?WlloV2VQQituSnZlZzNUR0xaNmJUSGFmVzFpYk9QUzlwRXJqY01JZ2hEd200?=
 =?utf-8?B?ZG9td25vUERlZGtVbGtsc3hMM1luYWVFdEVQNFV4S2N0cXAwS0FReTlWclV4?=
 =?utf-8?B?UWN0RTR6SDZqWWpkcWNEd0FyVVRuWmZtaXFyZUFuVGVneG41Mlova0RDY1lu?=
 =?utf-8?B?eTczN1dmMXZMYUhYcVJZWW9hZi93Ui92cXo2RWNiYmhLa1NoMlBXZlZsTWE5?=
 =?utf-8?B?OCtWS2NsRUZIa2srZWdtaURLbXFJUENaeGpiVjNjQzhIUUZTSVdCT2NlYUNH?=
 =?utf-8?B?Y0RtRjdyNC9XbHFNZldTRDg4VExZMXNwL1A2RS9sclVaOU5VU0w1NThlN0J1?=
 =?utf-8?B?ODRFV1JMOEVCSGNCZ0QxNytSUW1Hd1BrSjV5K1ovamZIdkVLQjRFZU1ERnBq?=
 =?utf-8?B?ay9YaWRrMmc4Nk5YZmRWZ3FWNE5aTzAwYnBWcWl1cFFvL28zS2NoVzIxL2Ix?=
 =?utf-8?B?ZlRlVlNDRWNNZ1RFZWhlTTJvd0xXc0hsMWJHYVhmdE0yWWNQRG9hVUpBem45?=
 =?utf-8?B?dVF6ZnhuVTBJbGFMTk81NTgvc1c0bkNjVGZhRkJKa3pVR2R4RFJmenRLUGZp?=
 =?utf-8?B?TWVPMGo2YnBobEdYMUJCSEFUZ3creUdGWlVQZGQyOXV3VzhxZlI0cVVGMUp4?=
 =?utf-8?B?bkVoaWVqTVVZOU9jZ1RqZDJrMSs2Q25FWldDeFIzVE44SDl6c2Ivd0hLMzVX?=
 =?utf-8?B?dVhQdHVLSGI4S0s0bEFBZGlaYnoyVzljZHRNdzJSNS8vRkFHZDhxT0dNZ2J0?=
 =?utf-8?B?OTF1S2xTTzJLSWtDWHlJMWRiTFVEbmt3WmI0SENENEhVRmxTMDRFaWNrS2t5?=
 =?utf-8?B?SmY3dVFaWkFmcWEzeWlSMmp2K3h1YzZoN01LYkVMWmxURHdEVUN2NjVsNElk?=
 =?utf-8?B?T2tKeldiZjRsVHVvbC80WHJnNUM5WkpnNUY2cHp2R1NmUWNQdms1eDhVU2lK?=
 =?utf-8?B?bEZNNjVvbWE0VzFXWWQ3bWxmRzJEWmJiQU5Pb090ZExlRjY4YmhPNEQ4Nkhl?=
 =?utf-8?B?MThKV2kzQ1NkK0NkaXRBaStDa1d5L2pTbitmQmRESE1XMVBpMzRiemxHN2E3?=
 =?utf-8?B?cHFCdkVJSkdEcHA0aVVoZU9zTlVoYjM0SE9hdzc1NDAxem5UVytrVytSM01S?=
 =?utf-8?B?dTc2MEVvTlBRTW9nNXlYNVYrMFpZeXpsSy9Uc1FIL0hUVXF6OHRPc0ZyL3Bp?=
 =?utf-8?B?ZjdoMFl2MlN2enVxc0oyOGNrbzF6TjA1c1dOZVhNdzlxNnE2Nm5vaUtlTXYx?=
 =?utf-8?Q?FBPfc7ucAY8ou6rEe29llXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5ACCAD909837E4889A54A81BAAE3915@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e23e0c-cde9-4808-e71d-08dcaba67865
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 06:04:25.2387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+iQ/2Pd1//owEZ7tmYEq/ZED6l70uvBGcFs9Jz01gCy9Be8vEU5lMASY59iYL2i3/zfDYQ6k3hKmtnaxEAShXPCofn21nP5WXgzKMrzGpK7uGjP7bGXO91k/wMPl55N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8220
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDI0LzA3LzIwMjQgMDc6NDUsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4g
TWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGJ1dCB3aHkgZG8gd2UgaW52YWxpZGF0ZSBkZXZp
Y2UgSU9UTEINCj4gdXBvbiBwaW90bGIgcmVjZWlwdCBvZiBhIHJlZ3VsYXIgSU9UTEIgaW52IGRl
c2M/DQo+IEkgZG9uJ3QgZ2V0IHdoeSB3ZSBkb24ndCB3YWl0IGZvciBhIGRldmljZSBJT1RMQiBp
bnYgZGVzYz8NCkkgdGhvdWdodCB5b3Ugd2VyZSBwbGFubmluZyB0byByZW1vdmUgdGhhdCBhZnRl
ciB0aGUgbGFzdCByZmMgdmVyc2lvbg0KPg0KPiBPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhv
bmcgRHVhbiB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBh
dHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBh
IGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+DQo+Pg0K
Pj4gVGhpcyBpcyB1c2VkIGJ5IHNvbWUgZW11bGF0ZWQgZGV2aWNlcyB3aGljaCBjYWNoZXMgYWRk
cmVzcw0KPj4gdHJhbnNsYXRpb24gcmVzdWx0LiBXaGVuIHBpb3RsYiBpbnZhbGlkYXRpb24gaXNz
dWVkIGluIGd1ZXN0LA0KPj4gdGhvc2UgY2FjaGVzIHNob3VsZCBiZSByZWZyZXNoZWQuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gLS0tDQo+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAzNSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA4YjY2ZDZjZmE1Li5jMDExNjQ5
N2IxIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yOTEwLDcgKzI5MTAsNyBAQCBzdGF0aWMgdm9pZCB2
dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gICAgICAgICAgICAgICAgfQ0KPj4NCj4+IC0gICAg
ICAgICAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgICAgIGlmICgh
cy0+c2NhbGFibGVfbW9kZXJuIHx8ICF2dGRfYXNfaGFzX21hcF9ub3RpZmllcih2dGRfYXMpKSB7
DQo+PiAgICAgICAgICAgICAgICAgICAgdnRkX2FkZHJlc3Nfc3BhY2Vfc3luYyh2dGRfYXMpOw0K
Pj4gICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICB9DQo+PiBAQCAtMjkyMiw2ICsyOTIy
LDkgQEAgc3RhdGljIHZvaWQgdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0
YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBib29sIGloKQ0KPj4gICAgew0KPj4gICAgICAgIFZURElPVExCUGFn
ZUludkluZm8gaW5mbzsNCj4+ICsgICAgVlREQWRkcmVzc1NwYWNlICp2dGRfYXM7DQo+PiArICAg
IFZURENvbnRleHRFbnRyeSBjZTsNCj4+ICsgICAgaHdhZGRyIHNpemUgPSAoMSA8PCBhbSkgKiBW
VERfUEFHRV9TSVpFOw0KPj4NCj4+ICAgICAgICBpbmZvLmRvbWFpbl9pZCA9IGRvbWFpbl9pZDsN
Cj4+ICAgICAgICBpbmZvLnBhc2lkID0gcGFzaWQ7DQo+PiBAQCAtMjkzMiw2ICsyOTM1LDM2IEBA
IHN0YXRpYyB2b2lkIHZ0ZF9waW90bGJfcGFnZV9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAq
cywgdWludDE2X3QgZG9tYWluX2lkLA0KPj4gICAgICAgIGdfaGFzaF90YWJsZV9mb3JlYWNoX3Jl
bW92ZShzLT5pb3RsYiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnRk
X2hhc2hfcmVtb3ZlX2J5X3BhZ2VfcGlvdGxiLCAmaW5mbyk7DQo+PiAgICAgICAgdnRkX2lvbW11
X3VubG9jayhzKTsNCj4+ICsNCj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2dGRfYXMsICZzLT52dGRf
YXNfd2l0aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+ICsgICAgICAgIGlmICghdnRkX2Rldl90b19j
b250ZXh0X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgJiYNCj4+ICsg
ICAgICAgICAgICBkb21haW5faWQgPT0gdnRkX2dldF9kb21haW5faWQocywgJmNlLCB2dGRfYXMt
PnBhc2lkKSkgew0KPj4gKyAgICAgICAgICAgIHVpbnQzMl90IHJpZDJwYXNpZCA9IFZURF9DRV9H
RVRfUklEMlBBU0lEKCZjZSk7DQo+PiArICAgICAgICAgICAgSU9NTVVUTEJFdmVudCBldmVudDsN
Cj4+ICsNCj4+ICsgICAgICAgICAgICBpZiAoKHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lE
IHx8IHBhc2lkICE9IHJpZDJwYXNpZCkgJiYNCj4+ICsgICAgICAgICAgICAgICAgdnRkX2FzLT5w
YXNpZCAhPSBwYXNpZCkgew0KPj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAg
ICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICAgICAgLyoNCj4+ICsgICAgICAgICAgICAgKiBQ
YWdlLVNlbGVjdGl2ZS13aXRoaW4tUEFTSUQgUEFTSUQtYmFzZWQtSU9UTEIgSW52YWxpZGF0aW9u
DQo+PiArICAgICAgICAgICAgICogZG9lcyBub3QgZmx1c2ggc3RhZ2UtMiBlbnRyaWVzLiBTZWUg
c3BlYyBzZWN0aW9uIDYuNS4yLjQNCj4+ICsgICAgICAgICAgICAgKi8NCj4+ICsgICAgICAgICAg
ICBpZiAoIXMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4+ICsgICAgICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICAgICAgZXZlbnQudHlwZSA9
IElPTU1VX05PVElGSUVSX1VOTUFQOw0KPj4gKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnRhcmdl
dF9hcyA9ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+ICsgICAgICAgICAgICBldmVudC5lbnRy
eS5pb3ZhID0gYWRkcjsNCj4+ICsgICAgICAgICAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVf
Tk9ORTsNCj4+ICsgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBzaXplIC0gMTsN
Cj4+ICsgICAgICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4gKyAg
ICAgICAgICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lvbW11KCZ2dGRfYXMtPmlvbW11LCAwLCBl
dmVudCk7DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+ICAgIH0NCj4+DQo+PiAgICBzdGF0
aWMgYm9vbCB2dGRfcHJvY2Vzc19waW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAt
LQ0KPj4gMi4zNC4xDQo+Pg0K

