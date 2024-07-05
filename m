Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACFDC30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPXD3-0005Tq-G5; Thu, 04 Jul 2024 20:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPXD1-0005Tc-IA; Thu, 04 Jul 2024 20:53:55 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPXCz-00048h-Gp; Thu, 04 Jul 2024 20:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720140833; x=1751676833;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+3iU9nPo7YscBqKIp8NDKmybWpq+OCTB22kEOhtURbc=;
 b=b1zC/cHZ63Ksd6VCEMbvb5NqTJQpmXDWzdBGhurfexQmMOxf5g7gkzBD
 E5+RN1vffzPLzmHv9xj0JYzv3llZ4neR0o4CRNOoztsJlizx3PR8xuY2m
 +YLNWOxXLrSThoEECddFZtTyFvUTV0O/CeAcJHJuZ2I703ok95fF85y3E
 MTzpuUNgArVIErTG7vWxZYUE3llDRgMFV+BvbF8E0TM/R/z62vQkUF8Vh
 6ogClB9po6EEjTFgrEZaHxyP0rHbcti8xn8XMabFm018+HS7xHMiZ/Y6N
 jaPJ7hG+EgJGQcKJ4jX44zlCof6zr0jxfeRDR9gkxldnGmgTQ8Bp0baws w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124209618"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="124209618"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 09:53:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LorZHdr9ksphvYYaJj6aEKvUamlONjnYw5VVAUj4B8tNHk3khKLgsRbAlVUp0hU/4JFaYfGBB2Tp2SIA9k5vVM/ScBh6dLb3+BM8iKq9asPyxpCBf0OdHWuSSZAjZaptL9F3wIxYgBMPxGmiiaH7qW3uhJD8UqvC3CP6iGyuYBJCEBM5vo/vsAxMhYe+/G4k1DcpUwyv6FyggOJ+G/2fOtGJdfPUznB0tVP1yQa4Dq4wZSlUxZFw7HTtTsu+bfUioCf7LhPvb2iaAL9rWdZrsmHbAaEM1e6IGN7FcwRXfAZGuPQS0LxKUQfH1VTCEs4aZCFM/XYWJP/eFwN9RKtmsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibrRpMoBd2tgsUYJO1WhKiEB5UqRcTwWHO1tudbOkEw=;
 b=KMNRreFFaANl6aY+hR3MZ8gPIaFhvDecfn3xhHgCEloIKphQQVFJWalUGAGdK1V1QR2vxzRXyJBhJirvFpMzB9H4qQX4WkOTR0mhC3jwe8dj8GkiDtWTNmccxr7CIvqMDlvJyiwgfHlQ0m4pxjtB0TofqoXqbFynQKr+AKcJQqSeavBOo4me/UzyMZ2b9AAoO3oT4Hs9CA+FmeSDczxU4e6MJluIsMIVv5aVVcGc/FlEvYgLl39IsQVtBpzx5nUM98Oh6+UjHM9pYz73vG+QLdQ2wAH7iQtXVcbwS/SzwZDvK/3TL6akqAR0kdbmh0pG82vQHKyx0XVr01UtffQQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by OSZPR01MB8765.jpnprd01.prod.outlook.com (2603:1096:604:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 00:53:44 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 00:53:44 +0000
To: Zhao Liu <zhao1.liu@linux.intel.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: RE: [PATCH] hw/cxl/cxl-host: Fix guest crash when getting cxl-fmw
 property
Thread-Topic: [PATCH] hw/cxl/cxl-host: Fix guest crash when getting cxl-fmw
 property
Thread-Index: AQHazfNcteUSVQHgpEKt9cYJCuA+aLHnT1Rg
Date: Fri, 5 Jul 2024 00:53:43 +0000
Message-ID: <TYCPR01MB646463EABC0B9FDA05CEF0208DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <20240704093404.1848132-1-zhao1.liu@linux.intel.com>
In-Reply-To: <20240704093404.1848132-1-zhao1.liu@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=e3791ca8-3291-4480-b457-c2480328b140;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-05T00:52:38Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|OSZPR01MB8765:EE_
x-ms-office365-filtering-correlation-id: 925e243a-3628-4a81-0cde-08dc9c8ceb79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?WExUamg0SUxTUUlPR0xQVlp0aHluWkhJeUhqc09Ta0lFMXJzZFVEWDlB?=
 =?iso-2022-jp?B?OWtMNmk1U1MvWWUxY0lDK21CdkJYVXVNYm8ycmJaVjlEekFiLzRWc2ZN?=
 =?iso-2022-jp?B?aWxJY3hwcktjaXFvbDBEY1grN1diNEdyeGFRRSs3V2NoZE0vY1pucUFX?=
 =?iso-2022-jp?B?Y2JTai83SXJINGdXb290NUh1RnVjb1ZkdlVVTnlhUVExdGlrNUZnRHZ3?=
 =?iso-2022-jp?B?d1VnZDVscUdVRFQ4eXZ0MjVNbEFqQkc5cWl1bkZxYSsxT2trcVd6a1FI?=
 =?iso-2022-jp?B?UnRNZmh3UXRWTVZLak9icFpNNHlUcWVxNzJYK3g4WHNpQzlpSlVSY1gr?=
 =?iso-2022-jp?B?b1cxYUhjaDdLZlArNXFDR0tlSzNvZDZRaFdSR2lXQVByeklqenVuR3FQ?=
 =?iso-2022-jp?B?MXUwQU1aSzJDU3RXVlRVbE14TVJMa05iZ1VoUmpBMzNrSDY0Q3Q2NDlt?=
 =?iso-2022-jp?B?TlhCaFA1QkhWZmlPbmZSaEpBbkVXSElhNVFsTi84MXlMVzQydENaUXVJ?=
 =?iso-2022-jp?B?ZEVTWUl1MTR0azdaSThYTFVMZmQvelVhbVY5WmdiV3FSaGR4ZEJaZ1lq?=
 =?iso-2022-jp?B?b0x2a1YwQkNlSXlRazgxMHR6eGw2YnFOUjFWNWZwRG43ZnJrUyttaTlQ?=
 =?iso-2022-jp?B?UFZkaHUwc3Z1OWdYMWVJTnVKeFNhQk42VGYyZ0tra1BJWVhiQTRrc1Ra?=
 =?iso-2022-jp?B?VHFEK2FoTVl6UEg1R3dYbkUrc1FmMVkxbmV6R1RlVDVOVU5oamVldUVk?=
 =?iso-2022-jp?B?WENBYnU1SXBTUDlpTWxNUnUwMHFEbURKTXVhMkV5M1NlTDZCb0FiWUxH?=
 =?iso-2022-jp?B?SnBhcS80N3lDaDhyMW1ZZ3RRU3JoaFowclFCcEVFRjY1bjdkYnZBVWRI?=
 =?iso-2022-jp?B?cHBoVE00L2dQaGd3Y1d2dHBtT2N1V2o0ZWFySXBFVEZLeVJZNStsZC9J?=
 =?iso-2022-jp?B?SGZhSFRTTjRXK0Y2Rjl1ajBaYVplZnlCb3dKSHVGclJYNVBHc2orR21T?=
 =?iso-2022-jp?B?SWVpRWZ3NlJJRFk3VDhQNjdrdWVEcUgrVWFWTVdqY1h0VnN6Wkdrc0Z4?=
 =?iso-2022-jp?B?N3JWcWFBT2lUWXZ5ekpCaVp6eG1BejltTmFTakVuWjN3OFI2NDRqZkJ2?=
 =?iso-2022-jp?B?bEFHRThneXc1aElVS1lpWEw1SmR2YzVoc1FWL3pWTWtPNFBLd2FsNFRU?=
 =?iso-2022-jp?B?OHdLRVhGZWtuRU5obXdEODlVcXNVdUpWRTZmcUNBK3U3ZzBoSEgwYTRM?=
 =?iso-2022-jp?B?c3FoOEtSUGVBMnVFaXM3REN6VzVYYk5JbDE0Ryt6VTlSbm1ueUJnMnhn?=
 =?iso-2022-jp?B?NktIVjYxT0k3eEE4dTdSMCtLTHRXTlVNUUpuSmVLTEU3am51d21xTkJK?=
 =?iso-2022-jp?B?SksyVllFa0ptTDJMY0hWdkpaZnhiOHYvNE9aMGQ5ZStuWjVybUxycFBu?=
 =?iso-2022-jp?B?S2N1RlZnSGUwTnlRTUgwZFRNUXMzeUJUaWlnT01LUkllWFkyUUpNQllB?=
 =?iso-2022-jp?B?Sk45U2xxOUg2Y3NwZnIyaDJxZXd1RGlUWEVTdHBlT1NTV3huVk9RQUM3?=
 =?iso-2022-jp?B?TE5JQjZORGRqQWFYbWZRUHVjejArV3JROWUwS21TRnB3VVpBUHAyRnh2?=
 =?iso-2022-jp?B?REtaTVhzWUxNS2ZGdjFyY3U3aUZDUWtmVHBFWWRCWCtnNi81M3hlUnZp?=
 =?iso-2022-jp?B?cVl2QURLbmtrblJZZjJaZzQrNCtIbjl4eXA1VXJkVjNmeGtvWFpEcGpL?=
 =?iso-2022-jp?B?ZHdMWFpadzNmbm5xOTMvbTNQOG9GSThEdTFCNWRTdzh2aFBMSnU1S2ZO?=
 =?iso-2022-jp?B?NXpRL0crRkV4ZTFvT2xrN0lzakkwSFJkazBIRjNxZkkyMlhTbVJSdnlG?=
 =?iso-2022-jp?B?a3hlNFE2SHR4UCtGck1POS9WZUJieEo5WjZpYmhFMEZSZW1CalEzN050?=
 =?iso-2022-jp?B?TWdqKzFVc3Q3ODc5VW5IVVFMWGJVNXMyZ3g0UjJiZGl0N0Uyb0hEc1BX?=
 =?iso-2022-jp?B?anpUWkNJTk1vUzJUbWJGVjg4MFc4RGI1MDJ3Q0YxaWhkK3k0YUVwVTVq?=
 =?iso-2022-jp?B?L05MM2VzV3k0QzJRSDM0VzJZUE5DNFk9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYCPR01MB6464.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Uld2alFCMVcvVGNJc1c3Ymh5WUZKYk9hZStMKzVnL0JaS2VoNjY5a3Z6?=
 =?iso-2022-jp?B?Y09nMkhFZjBOL1Q1TEFtV3ZoSEpsTGVmVDNKWjgvODQ0cmlGcVpETlJN?=
 =?iso-2022-jp?B?ZHlYV3FWUlNXK1NQa0s5UEVuZU9YWjJnOTJVeVRidWNCVHhEbjE4cnRR?=
 =?iso-2022-jp?B?TUEvK2E1RkN0cVpnaUlOSWw4M2RuRkNtdXJlV2FlZ3RYK09ScTZnem1M?=
 =?iso-2022-jp?B?N2x4alRybi9WR3d4L1laaGY3SzBxK1BsUXNuaUhrNjFjVHNETmx3MmM1?=
 =?iso-2022-jp?B?bzY5UGJ5cXNldGxIYWpmNWFHWTFPNkczWjE5d1ZVeXNzZlc1aTh4TUIw?=
 =?iso-2022-jp?B?Z2dSQjk4NUk0ekdxcm91T1kxbTBFTlZldllMUzlEdU1MeUd4Z0MxZ2U4?=
 =?iso-2022-jp?B?eFhwT242aHFiVk1NOXZ6UzlranRHUDJBcngzOW5rakNFVDJxNDZIZnFT?=
 =?iso-2022-jp?B?bHhQSFNrSjIyLzNObWs2a0dKMTFxcXFyekRnSnp4Z2JwT1h3eUl6ejB3?=
 =?iso-2022-jp?B?RXpiUSs2b2k1MStBVCs0b0F6OHhZYk9KMTZ2b05CUCthblhmcUJtWG80?=
 =?iso-2022-jp?B?VFpzR2pSLzlZMmxGUVhkc2Y4Ung4VEFPU3U3SEpxZmJTZUFCcHNNU0VY?=
 =?iso-2022-jp?B?Rml5Z3krT09COWk3L1ExUklpaSszanA3TzM0WEpwTDVFZXY0M3JOOXhs?=
 =?iso-2022-jp?B?cFU1MUQwQm5zbGN5c1h2dUZXLzBpM2N4YmVtc21NUlQvNG9Wa1l2T0Jh?=
 =?iso-2022-jp?B?a05UWFJqM0JjUHFXNWtMN01pVStScmZXaVBrMFNNcTRHMW5sdlZ4Z2ZQ?=
 =?iso-2022-jp?B?RzVRcTFZRFhwN1JKZk9CNVFZUmh4WW1XZFJpWlgyb0N5WURya0E3eVhK?=
 =?iso-2022-jp?B?VlJ6QkUrM1NweGxqL2E5aGtKaENObVg1aU1GVG5saGoxVDNFbGNYU0R4?=
 =?iso-2022-jp?B?eFdPS2lpOUFDTG1SM2NtQWNBaTkvaUZ5VlRXWUV6eCtwSUFXK1hnQk5a?=
 =?iso-2022-jp?B?a3NWTlhpeG1JVGZpU1FOVUlKcnF6MnFEdHdiM0w5dnBsUzZsVFpwZTNj?=
 =?iso-2022-jp?B?SUtEZ0I3OW1jdHpYR1BiUEhiWEhhY1dQZ1pnQkJGYkhjWm1US3VCc3dq?=
 =?iso-2022-jp?B?UDlITllPNEp3a0xBK2s4VkUvZDhKbXNKOFBTc3FMbzZHbFY1dDlROWJt?=
 =?iso-2022-jp?B?cEkwbCswbm1COHNhd1AwMS9yc1hKaTVPZHFUeUEvWUNkL2tWTDlRVUx2?=
 =?iso-2022-jp?B?RHNad0VZYklnTkJTSnRxWXQwWnFzVjA3VjZncTNNUTI3WkpwcGhLQXVH?=
 =?iso-2022-jp?B?QjFacWlGdm1aRkxCRkdjZFdBbE1lMWVCNlZ1N3UrTk1sWjVBZm0ycVpN?=
 =?iso-2022-jp?B?c3ZMaVI5OTcwa0dnNFVhL3NiY3ZSZ1JNUmVQR3pHQ0lZZjJVQWl5TXFY?=
 =?iso-2022-jp?B?MjRhV3N3dU5BQTlzb2FhY0ZlcWlUeElMOXZsblVtdStUTHNNN3AyVHpV?=
 =?iso-2022-jp?B?T2N6RWhtLzdhOHpDM1BKM05hRWYwMnptc0I0M2JMYmNBbUhXUlhkQjNG?=
 =?iso-2022-jp?B?OHhTZFVjOGxLS1hIY1pXNm5WdzZ6dTVGblpOK0dDUmY2cCtDZFBvK2ox?=
 =?iso-2022-jp?B?TENEVTZWWUlRdzRLLzFnLzNrU1ZuM05PeDdEbTdKUjQyTFhYR000Ry9T?=
 =?iso-2022-jp?B?OGkwUmNEa1pLcmx3M3BlbUpXMVNpcit1Z3BKby9Oc21HYmFlWkNSRkV4?=
 =?iso-2022-jp?B?WGdGWHJVRDdJQkRuditRT2RwSENmQkVVYkRRZWpYVkZwS3FJbXhpejZ2?=
 =?iso-2022-jp?B?ZnVUYlU2elo5dlJwNG9ua2tqMkF6TisrLzBEUHVVOXpFTklDZmZ3SzVT?=
 =?iso-2022-jp?B?NHByOXVTWEVkeUc5QkxpVTFmTE9nWlhOa1dKSnRtdDNWb1c0ZCt1cHRS?=
 =?iso-2022-jp?B?ODBiSVFyalpxVzlkWjQvdWZqaHppbG9YTGR5NkdqSkJieW1tZnEvNmVE?=
 =?iso-2022-jp?B?L01zeFpZaHNVVmVQeERZRWVDTVE5Rjh1QlBsY0c3K1hrNGFUblRjRERr?=
 =?iso-2022-jp?B?TUd3cit0VHRJTUI5cG5lTUVPOXVYRC9IRkd1ajQzVFZqS3drdXoyZ1BZ?=
 =?iso-2022-jp?B?RjFEcHdRcjArMmRKbHFtTnRBaEFBTllLellxNlJrY2hNSm16Vk1KaTZp?=
 =?iso-2022-jp?B?MzEwT0dQVSsyUUFSd0dnS1R2MCtiTy9uWGplOVBVcHJOZ3Q1alNPL09N?=
 =?iso-2022-jp?B?SzhnT3F1Um52SFJ1MDF2WGlFWFVTQVl1WXJ6SHJBSEpOQTJXWUxUUTZ1?=
 =?iso-2022-jp?B?eUdmaA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jai/0BmYPo4DNJbRN1dZb6p/7HuZ6Zf1b4nB1X3YmoQfDxarefEdn3OMYfSNNvl/Ji+BT8Vv8Xh3oK1TpNA3TbBPryS4vcDlaOM0bqZ4F7v5HbDcmlmK1B2u+x4ew4Bl8NWnvw30E5mhRH9rKN+1oKVnmDsZnlCLMrILRj52CQsfg1QYDbP8CeMi7QWQuYzCi17m+GT6fMzH/numqjUDEKafFb7jcZ87rPOW2y1JDh1+MdleWd53mAuPpdm22BJxX6gn7xoQhffbH5g0Ww0QNogITMOGZM6R4q2Lf3JhXMKl12q2wky1Dy4893Ys5pFVRPwU/PGtubifkQP+J1utbfqqzTxN6gyLH6fP6Sb8smD1Yw+1GfVlwbS2r6wOxoD6Hleb61i50/y7xFnDQidyurehL73YCLmYT+CyV+ZBqwkEZts+LblZ1fa2wjL7YAS06uQ3UzIPebV9uw6iFrQ5lwPmzyvv6EhuoIMotVl9rPwGRGpo+Mlx/hHmGPz2hLhROYO+a532x3pmsv94dQiftChON0LHGe3MUF9M2PXr4aTkU/FDT+dWaW7KdSRpXdjF96g5n2sRCctrqkevl7WsSpi+PKB3+/Y1RKflhLPOTebEpmy6mWQsdPo+G+1WA4Gq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925e243a-3628-4a81-0cde-08dc9c8ceb79
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 00:53:43.9567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rp7C7YAYTbJnrUYDyxsIrCsfA+h0zu0QxLBR+H2dnNUDKFZcvVDa+lRxs7+TQ9HuIpq3Kab6oiVy5R2+s3xHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8765
Received-SPF: pass client-ip=216.71.158.34;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa17.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org
> <qemu-devel-bounces+yaoxt.fnst=3Dfujitsu.com@nongnu.org> On Behalf Of Zha=
o
> Liu
> Sent: Thursday, July 4, 2024 5:34 PM
> To: Jonathan Cameron <jonathan.cameron@huawei.com>; Fan Ni
> <fan.ni@samsung.com>
> Cc: qemu-devel@nongnu.org; qemu-stable@nongnu.org; Zhao Liu
> <zhao1.liu@intel.com>
> Subject: [PATCH] hw/cxl/cxl-host: Fix guest crash when getting cxl-fmw pr=
operty
>=20
> From: Zhao Liu <zhao1.liu@intel.com>
>=20
> Guest crashes (Segmentation fault) when getting cxl-fmw property via
> qmp:
>=20
> (QEMU) qom-get path=3Dmachine property=3Dcxl-fmw
>=20
> This issue is caused by accessing wrong callback (opaque) type in
> machine_get_cfmw().
>=20
> cxl_machine_init() sets the callback as `CXLState *` type but
> machine_get_cfmw() treats the callback as
> `CXLFixedMemoryWindowOptionsList **`.
>=20
> Fix this error by casting opaque to `CXLState *` type in
> machine_get_cfmw().
>=20
> Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a
> machine parameter.")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/cxl/cxl-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index c5f5fcfd64d0..e9f2543c43c6 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -315,7 +315,8 @@ static void machine_set_cxl(Object *obj, Visitor *v, =
const
> char *name,
>  static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
>                               void *opaque, Error **errp)
>  {
> -    CXLFixedMemoryWindowOptionsList **list =3D opaque;
> +    CXLState *state =3D opaque;
> +    CXLFixedMemoryWindowOptionsList **list =3D &state->cfmw_list;
>=20
>      visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
>  }
> --
> 2.34.1
>=20

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>


