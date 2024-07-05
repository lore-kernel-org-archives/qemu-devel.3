Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174CCC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 09:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfBe-00045m-DN; Fri, 05 Jul 2024 05:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPfBc-00045S-En
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:25:00 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPfBa-00079g-C5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720171497; x=1751707497;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=m1bLMLrWzRv+xFcOGqq3p0aLSO2ZhniZxWEle+723vk=;
 b=eHxGDo+K57gmpuF1XAEFhOp8WgjHailcsLOMrLPCJ7XZKoAfyXFQlMtF
 ltz55kyDc0tt0S/ufjztjCFz2XoIhN9XFmWa53jqwKd14ZLZZ4Nyh5CvE
 sJMv3ByKJ26aA7xbQNsE3gjzO+lxxjmBjKZoajvlAQymoB9cpTsJByUMZ
 sgvbdooGyeOSQbFC9jQJ5IJrSo9GSN7wcppxk5cNr6gVAOf3UvIUGIjH3
 lrzrgNqruSYZY6l1PA6k0v49zlThfURjwqAjaqj6qnv/LGezK6nHeQQyx
 DB0l3CZEy9b6Cl6mbvHAKZRfZQC6/sNWORrczm4ZnlRXBPn1XKQcR70h+ A==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="15953183"
X-MGA-submission: =?us-ascii?q?MDEtDYZrBTmsN22UNeu4mxe+NP6hRuDUrXtJW4?=
 =?us-ascii?q?sj85hOkVz8met+u/ckTj33HzWpNjKFLwjA0RArvMMwf1HJ19mZoYmyUI?=
 =?us-ascii?q?tdR97eFgXdorszLBR1UH6CmQY11eRU1otpCQsMbMiZJkBY2yNKI5T3MF?=
 =?us-ascii?q?VTcjAetm0UhK1qEgvZpq5Eng=3D=3D?=
Received: from mail-am0eur02lp2241.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.241])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 11:24:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeHhqWCmjvGxO6a9v6iF1Ligkf4GF3xGtDatA5ZNmXKf7yGYarj7Xo+Z8IFkX8+P2u4DfIT/xFuNgLr8nr5+o+Wx3HMG8pJwbpqQXb5Ww3AwRDr/NOyC31mngPbX1h4+IQepxH6QZ2+5lKFdSBlVElU8kSa4s4GEXIkJCTPkuX2huR1LFfB9TuGGAp58pAoTFh64Hhz1U6LtUeaiqy6BxaULzs3IMEPo9v5mrJFR/H7dPCBBbUiIyZLPRZcCa1iaMaSF7/8yLa9YLRTgReTdyeP1UYFntRdY/uIucSBHKncxY460uQZJelzmoexNvOV+aerhMZOJG8EZHv9BwRtU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1bLMLrWzRv+xFcOGqq3p0aLSO2ZhniZxWEle+723vk=;
 b=nqQNNoJ+57sDCozV0+GhtOZRf217nzHiWlepjR51TMIkPOg0ImRTf324qUMHgo8gotPNToPZrZWWa/EdE/VeY5zPhelvpvrpUhFumPPjal5qicCguqaztXo24Ka9pQlZxjWBbLbyYmxlVrP3/nGPl+zir0wLRIURViu9uBWUw3uFFCNPyFwKGKcfPZ7Tdx82C08iU6xE7SHuRxEduppYIKX/do36YWMZf/BPlxFJVgpsoClGXIZI45SNAM4J0EgViURDOCJi5wpnwmz3MOViybCnQr2N8BK5UwG0+isA6Zm+IWY37gIfXCgDcC8mqxuxu5hoV5VL6wnF54XvadyzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1bLMLrWzRv+xFcOGqq3p0aLSO2ZhniZxWEle+723vk=;
 b=mk0q04kSI/ceXxosPbs7OMlLM9x0AKgvlCFgJ2dk495Jmi7u2lf+D4MdV8VlP1b+rLSHPsUmnSLcQLB9AHnQvmA8ft21cMYXX9FKBGsCzVoFwBnV62Iyu3lyRuSDGGXtG7qnqigETF6K6Rjtgnk1Zascpyqc8/tsZTZYcoCfG1MrrK9uANCBNlq/XhJdC0EhAPCmg6CiUG4wJjwZkSBJS1BUn/vh5875uOon79x/EHKwuamsd3rd47830lPqtR3nSp/A/BMj6x1BYSXLlSVUhDHJGpq5UKWmknlpcGWQ13zHGNyNaeVQoH6KCjVv4rH1nN96+80zrprcb52UEBnH6g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8611.eurprd07.prod.outlook.com (2603:10a6:10:307::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.13; Fri, 5 Jul
 2024 09:24:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 09:24:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v3 3/3] intel_iommu: make types match
Thread-Topic: [PATCH v3 3/3] intel_iommu: make types match
Thread-Index: AQHazr0vYcdvpMi3ykSdmB+kM5mpgg==
Date: Fri, 5 Jul 2024 09:24:50 +0000
Message-ID: <d637bd99-11cb-4bbc-a8c4-06fae21b6c88@eviden.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
 <20240705050213.1492515-4-clement.mathieu--drif@eviden.com>
 <SJ0PR11MB6744DDE438D094FEB4F8A29392DF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744DDE438D094FEB4F8A29392DF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8611:EE_
x-ms-office365-filtering-correlation-id: 3efc04ec-06a6-46a1-29fd-08dc9cd45276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dE1zS2JIYnFqU2xpR3phZ0ZSaXRxWTRjSnVWc3pxVklCb2RDdk9ZTlpRUlFk?=
 =?utf-8?B?NkdXOVVsM2R4anlGTHM3V1NVTVBtdFhHWXVDUVJNd2sySHNrL29jbkNYdTFj?=
 =?utf-8?B?Znk0V21LdnhRV2RrYjlyd3FTNHA1VWlhN0VzRnllQ01adEo1dHNpeE84dS96?=
 =?utf-8?B?Q2NNazhGRWRGZmVlZ1Rvck1SamEyemJkNVJGZnJ0Z1NKcVVrYy85NzQvME1R?=
 =?utf-8?B?eHNDckxPOFNpdzNIV1hDWU1wVnRuL3NuN1cxQmUwRVFEejhiTTNSaTA3VDhh?=
 =?utf-8?B?enViczd1Q2Q1b1BSQzdsTFpwcWxzNjM4UjQ1eDNMUUxOM3F4OHVWbDJQbWR3?=
 =?utf-8?B?UHFRL0Z1c0Zvd1dFTDViWWFwRm11ODVZdXUrcURJK3NkSHZ5TlAra0V2RHNp?=
 =?utf-8?B?NEdlQnNVQkhoTCtuNjZXWXZTM0dBWUJBM1VOTU5CUGhFWGFCampCeEFPMFlK?=
 =?utf-8?B?OFQwWDEzdkxyMnNvSUNQaVpSTElibUFDc3A1UlUyZytYSGFaY3JmZVVMWXU0?=
 =?utf-8?B?VytDOWc2SUpTZFhLRnZUOVU3NVpUYk0yaERURzJlSjkvVVpVV2kzSm02cWF5?=
 =?utf-8?B?bm0vU2FZaXhFMVhPNktlMk9qelNNU25xbmNUU29nUVFXdEFwemxGNUNmOHl3?=
 =?utf-8?B?QjlOSzNTRkw2QnpkVTA1aTJpa04ySHpUMWdnWlBNSzY2VmhZVHVtSU1IZFZ3?=
 =?utf-8?B?ck9GOXZER284Qlh1RFNxMHNxb3YyNFZSYmVlbFJDMTREa3kzNy9qd2NpT3Uy?=
 =?utf-8?B?WC8rVjZmUzN5RnhpbkNvWEJjUzlwZEl1K2l0bnV2NHVRQU13K0tNVXBSMGVN?=
 =?utf-8?B?bG85VzhqRmdja1p6RTc3Q1RFNGtpczl4ckV3Zk5DU2xiMzJzdnhRUklCT3Rh?=
 =?utf-8?B?SmJqaE03OWsrMk1QQjNIRlVpQTdmWlZLaGNyQWdaVUtIYjRpdjduWlRXVHVu?=
 =?utf-8?B?MjdTTjlxNE0zVk5BTEdzeWpKTEJuSS9BWnJIcDcvYk0yTGV0STNpYU02SGZT?=
 =?utf-8?B?azFLQWlFY1UvMzQ1M3NRVDk3QisyZ1plUFdNS1hBVDhSTmtZZll0S3FPSkFD?=
 =?utf-8?B?aC8xZllIdTdFMHlMZ05HaGZUYnZZRzRlMldoVDVhMEFGb25LOXhTbXZzUWNl?=
 =?utf-8?B?Z1VLSGRuWlI2WlM3b1hxOTJLTlBXYko2UlJOUVpWbmdUS2lIQkxBVTZScHpt?=
 =?utf-8?B?T2lQZHJsZkU5MWdmUHdNMm9wVThrVkt1L29sR1M1akhqOEtHTE5zbk85bHBY?=
 =?utf-8?B?Nkx5MGsyWFFBay8vM3MrSXRSRFhhNW9WRUhRcUhjcjkrb3JsdWpyejJVTncw?=
 =?utf-8?B?QW5DZ2gyOHBucjBHQ2Jac2g3dnlZRVl1K0ozZXlURElMbytNRVU3V1plSUVW?=
 =?utf-8?B?bUxIREdFNXlMNmY0U3BBWDZ3NkhyNVVGWjZ4d093RENjY3hkWGVSYWduTWJH?=
 =?utf-8?B?YWNnaWZFTlF5T0dwSDNKOFZoN0tFNGF1OEZOSUZFb0ZvSjMwRlB6Y1pvcWZG?=
 =?utf-8?B?ZGR6dWFZdEZzNHhzUE1KOHVQZlI0dmw2MmI2RDVMTm5CN0RYSk94V2UwT1hw?=
 =?utf-8?B?V05YeTNHc2gzRlgySTI1TWMrK3NYcUFsWGxzSklIaGpHRGNud0dRYTVMRVpM?=
 =?utf-8?B?N3VUUWc2czQ1Zjd5RFhJSWp6MzI2TEllTFBzOWNQcTFueFlabWVES1NSdzBl?=
 =?utf-8?B?MTFzUFFVRGQvZkxYQnFHSS8vWis2TFpRNXl0MDd4c29iVFRMN2k5czdDN1dr?=
 =?utf-8?B?RkdSUjRqcW9HZjZyV1N2a2FET2M5YTN1TC9aWVdvTHNjSEVsZ05HelY5QmNj?=
 =?utf-8?B?dXVrNk12NEhYVVhjSnJCL091dERqdTBPdlpQZllJcXRWdkVzUUN0K1hkYS9v?=
 =?utf-8?B?WU0yYm1sQmVsdzVZcjNlYnVINGJaTWRLTFR2NDFTaEN3VXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODFwNmxSWWNSWVpwRURoYy91bXJwajBGYkJibHB3N0l4TVpPUzFSVDM3RnF4?=
 =?utf-8?B?ZlhqM1ltMHREK1MweUdpcWtyUGh5TStzSVZlcm9rcmRSTTcrNDZWMUtqNlAy?=
 =?utf-8?B?ODc5RW5CUERRS1hrNHIyZHZOei9SZnlpMkpaMUM5SzV1ZkYvTm8zUGtoM0Nk?=
 =?utf-8?B?TW9sRmZZbExTOTBqZVgxbXJ4b1pKSkczMUhabHRMTUR5YzkvUUJjalZjWXZZ?=
 =?utf-8?B?VlRiNjVUYmViRmczZ3RDUFFjc1d1cTVXS05Zcm44cDhsdWc0ZnJleEFiK1Ro?=
 =?utf-8?B?bnFseVJpQnp0TlAwRThVMjNValMzcDRZUWJOejZweUVVclVmREtkU3BMM1E1?=
 =?utf-8?B?bE4rM2pXNUxYUkNIS2hwcG5xMnJWbkxiRGluRHRDTExsQndPR1RuMFEzMDZF?=
 =?utf-8?B?U2JqQ0ZCZ1dMRm9MN2huVHRqOWxRenBlUFlMQXdxWHZJQXdQTys5SytOT1Bs?=
 =?utf-8?B?Y0tnZFhZbWNwaHBqNXVOTEkrMStaYnQ1ei9ySEJFWWRCZDYvMDNlMzJ3Q0Rs?=
 =?utf-8?B?M2w5M0cvazNPaCs4NlNqUG93U1pHTjM3ajRpZEd5RWdNZDNRQno1eTZ3dDJT?=
 =?utf-8?B?NmNLcTAvV0tmaEQ2QUpWK0o1bkRHWEM5ZHloM2VzQ3N1YTRPaGdPZTljUFNa?=
 =?utf-8?B?MWtKTjlodWs2Wm9qMVE2VG43RmtXc2hkdkxQRzNXTUhyNnVmNGcrSGRZZFlt?=
 =?utf-8?B?U0NVQXljTWQ5VUQ1R0ZtMnZhc1RJT2p3WTUwQjNuS3VoM3RzaW8wdWV3VUpM?=
 =?utf-8?B?cXdtTzFkS2liQ0EzSld6MHBNYmdXd0hxUUtyS0M3enlkbHpyTm56RXY0b2kx?=
 =?utf-8?B?QjlnR3dJOHJ2V1NoSmRoeDhsZ3BGVmRBVzB0SkhmQkJUbmk4eG5IRkJHd0VQ?=
 =?utf-8?B?VWlmY0hnTnNxL1dhaWhxcUtLaGlDNzNhWnhVRXBNbDg3K3JtNG5VQzZlWHdP?=
 =?utf-8?B?SVVRRXVJKzlNUkpSazE5RVBKSTF6VVhFTnJnNVlFRGhYcmx4QzJJc3YxQ1FO?=
 =?utf-8?B?ejNuS3Nid3hOMURiRHZyUnp6SC9LQXgvZis2SXV3UXNIbFY0NHJaakN6U3Rn?=
 =?utf-8?B?dk44cnNlbWRGOHQzMmI0R2h5ODgzSnI3NzJzaTc3aTNOMVRla3BSa2FaTmdM?=
 =?utf-8?B?WVZ4YXdOcUpSczNPb2tPTnJ6bzBRY3AyM3NKZm5ydXFOOWtGQUtNQjVzaEpD?=
 =?utf-8?B?MWZuVDJNNnJxMVpqbWo3dGxSaERiQWJJZUxna3lDeXZMSmp0NkVhY0J1UWZp?=
 =?utf-8?B?eURuQmZkdEhGNlNaejByeTlDNmJaa2V1RUZXQ1piN0RjV2lGeGxMSkY4S1NP?=
 =?utf-8?B?bG1GT2FzVERXeXYwWWwxT01MYnBnQnVMU09uN2VTVGZ5T21BcXJabUMwUHRN?=
 =?utf-8?B?THJVLzNkd21CMnZKWDMrcVJXS2JXWDZMMnFDdGg1djF3bU5BQWYzQWlKbzdM?=
 =?utf-8?B?M05nM25tbkx0T0FtUDB0RDRRcjI5ZWtOTDMyTDFYRUFRWDNTbnhxcjcwZHBj?=
 =?utf-8?B?ZTg3cmlyQzFQSVY4cXpSTXlMZjNoeFdJTlRETVZmYnRRenRNQTRtOWM2N2RZ?=
 =?utf-8?B?bTFFZ3hpUkx5OFRoRWl6b2VuaWpvZkluU2N2TTNwOXh3ejhOSGsxZDFUNXR6?=
 =?utf-8?B?MTY2THo3VUZ5YjFOTlo3d0RVcnNoeERSVHg1NUoySFZkbGNialAxZkxaTWpw?=
 =?utf-8?B?K2wvT0F2bHViWC8xUVM0WXFudGRWRksySjIxT0cvK1dXa1p0M1ZEMTBEUGs0?=
 =?utf-8?B?aStRVHFHTmdHRHNmeHk3Qm9jU0RLY0xLc0JmVVJtckdLc1JIYkZ2RkNTNmM2?=
 =?utf-8?B?dEtwYUgzVjRsWTJldzAvdlpHRU93cjlHbXRjYmYvOXBDMTZGM2RLeSsxek56?=
 =?utf-8?B?bUN1ZXZyb2dwZnRMcThnNzNlQUxHdjlyL2lUSXNKS0RPa0dwNWthTEtsVUUx?=
 =?utf-8?B?bGMrS2RPYXhLcDVMNGxNNUQ4MHhwejJZRUlwSllRejlHNGZFdHJVVUQ5ZFM4?=
 =?utf-8?B?a1orZk1rcmFmTlJNNUhLN2VrQzlQdHRnbWh2WW5tblhUOEJ5eTk0V29EcCtu?=
 =?utf-8?B?WWVXc094RWhJMzF5T0Y3dkUxU01Jd05RVERScjN4bmFVTk1nS1JXcjBHTllS?=
 =?utf-8?B?VndVekQ3ZytlbG10T2h4YnNLd3VwQ1NsRjhObllsTExkUWFQdW5BL21KMUlT?=
 =?utf-8?Q?UGBTYNOV+hZ27vR82M/7+2k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7883EC4F5FBEB44AF93A65BC7C53B26@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc04ec-06a6-46a1-29fd-08dc9cd45276
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:24:50.9872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIdqWKen6rLm3WFVT2vXxXp5s3XkuYrdp+fJQNBXZzZ3lGk4s54Hh48k33Vctg6RQWWBtown3xolUGgGQ2USWsc5+DB8mcPEketXhJfCxFN0jgHO73Ma9uDxt/WLu0Nq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8611
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

DQoNCk9uIDA1LzA3LzIwMjQgMTA6NTEsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBbUEFUQ0ggdjMgMy8zXSBpbnRlbF9pb21tdTogbWFr
ZSB0eXBlcyBtYXRjaA0KPj4NCj4+IEZyb206IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4NCj4+IFRoZSAnbGV2ZWwnIGZpZWxkIGlu
IHZ0ZF9pb3RsYl9rZXkgaXMgYW4gdW5zaWduZWQgaW50ZWdlci4NCj4+IFdlIGRvbid0IG5lZWQg
dG8gc3RvcmUgbGV2ZWwgYXMgYW4gaW50IGluIHZ0ZF9sb29rdXBfaW90bGIuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiAtLS0NCj4+IGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDIgKy0NCj4+
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IGluZGV4IDM3YzIxYTBhZWMuLmJlMGNiMzliNWMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM1
OCw3ICszNTgsNyBAQCBzdGF0aWMgVlRESU9UTEJFbnRyeQ0KPj4gKnZ0ZF9sb29rdXBfaW90bGIo
SW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzb3VyY2VfaWQsDQo+PiB7DQo+PiAgICAgIHN0
cnVjdCB2dGRfaW90bGJfa2V5IGtleTsNCj4+ICAgICAgVlRESU9UTEJFbnRyeSAqZW50cnk7DQo+
PiAtICAgIGludCBsZXZlbDsNCj4+ICsgICAgdW5zaWduZWQgbGV2ZWw7DQo+IFdpbGwgaXQgYnJp
bmcgYW55IGlzc3VlIGlmIGludCBpcyB1c2VkPw0KSXQgc2hvdWxkbid0LCBidXQgaXQgbWlnaHQg
dHJpZ2dlciBzdGF0aWMgYW5hbHl6ZXIgd2FybmluZ3MuDQpEbyB5b3Ugd2FudCBtZSB0byBkcm9w
IHRoZSBwYXRjaD8NCj4NCj4+ICAgICAgZm9yIChsZXZlbCA9IFZURF9TTF9QVF9MRVZFTDsgbGV2
ZWwgPCBWVERfU0xfUE1MNF9MRVZFTDsgbGV2ZWwrKykgew0KPj4gICAgICAgICAga2V5LmdmbiA9
IHZ0ZF9nZXRfaW90bGJfZ2ZuKGFkZHIsIGxldmVsKTsNCj4+IC0tDQo+PiAyLjQ1LjINCg==

