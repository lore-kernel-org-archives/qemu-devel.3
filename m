Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F5CC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUN5a-00028a-3g; Thu, 18 Jul 2024 05:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUN5X-00021F-Qk
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:06:11 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sUN5V-0005hC-Eg
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721293570; x=1752829570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ee0M5sXwdw+qoF8zVCltexmAyqydgZFrnSQFIk8iQkw=;
 b=LdVHi5lnUd56oy1akVwHf+NYvYzkv+yVqSI944VNRo8JWqiHR6MfaATe
 A+YVoETumra/Azp9WJwyq6hXdk/7Ma15GobD7pQwrzhbP8OlVt1Op6StV
 z3+j2845EEh+2OIXggPeudwBt1Y+OIX0I9tVIVBNp0vHhWRrOmELiJh8B
 akp/oP2O2ubqnlgqiP57lqML+K1oCw4IW3X5XIDBUIPJbsBqmS1XT7C1a
 ItPOHR21M/MBJ4tNSAjBZho4cYtK5/rKPF6fRsW4vdNjTrOV5gdIBFrv3
 rdYvU/VEi1B6PZruJ0dHS9HBMssdC/MNi0QP1Lj/C0bZQcMo76Cj7elR0 Q==;
X-IronPort-AV: E=Sophos;i="6.09,217,1716242400"; d="scan'208";a="16733836"
X-MGA-submission: =?us-ascii?q?MDFjMz2T+BN2pklzWEsDK0ipfCfTJqW4yNWvSW?=
 =?us-ascii?q?5J+bKpal0BuzU8DTOEg1Ipf930XYOHzO0bn9e5Sa60hPTFRkR6DMN/K1?=
 =?us-ascii?q?oZMCYM+WDXe9xmW/Cj6n3pQK2Kc2RTGYJ7N0rsCknvcFDjSISOIGSXdI?=
 =?us-ascii?q?NK4ZGXbdrywVmkLOyHoGZamQ=3D=3D?=
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.111])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 11:06:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmk98Je10XATBLNG4B3KUFMtYWNv1IAVJhJ6Yde/UwrABAe+rpndgUAp3vCxKNsMW9/s7HJUG9qKlPhyfxzNDMzvwtxvi/uORjvbOb8cYH9dVBaq6FQ1otJfb9TPHgiUGT/QBFMcfhMDmlxiyUehhsv0lDtfk3UQTps2wE+NELC9wNl7rupVwL+uSxbAMJsVcTCNS9xSLElvgsnd7VEtoxAE9/hohUFYuOe+6+24ymPPtoAt3v5nVguJd0x5p0SytLK+VKEyw6geCQaU8RbrGYopIUbZ7QWJVKXo1ABI7eOr2skYF6XpduZRE/JSdjV3LKb5euwrhhgO5oDVJ22j6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ee0M5sXwdw+qoF8zVCltexmAyqydgZFrnSQFIk8iQkw=;
 b=LO05xRw90H7V4tbp1R6sfbj7+VXleP3JMIj3Q1x6UmcwgtmBf+zI5jG8Hk1wT8LWpyKVXMLZF8cJZTAORgbFPCv3P+Pqsa0LrxBfSNwL2283GcBU9CU3o8uy72lx3rPOi0ry7rgBKc7gsabTAf5/qGs37UddQFRVG5xAlwBhGaMWKeJy+KsyRyETlDpKNcAbbnwx0bXeH8YZUc5kHFXDT8v1OChIpMwFQGSGyHzarZpyC6DGX1tVlUwm2/vYRBtUCW0lsxgfPVV/LxNdlibWPsP0UhqQwXkFL7pIm5s+MeDoDFJRfL8hJBzMXaxV8nO855V9N4jvHC7CVTYFqAeDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ee0M5sXwdw+qoF8zVCltexmAyqydgZFrnSQFIk8iQkw=;
 b=K1uV5kjJMUcTpwTk2/iY3Swa6fh/5FZ6b5HB0AqksImgFCFpcJg+u+tTmdsXdspxHzkQUKOljH66zVent78NwGODg+xSVMtPILUJMKUgJufdo/EhRMvavkxLh4rB2cEvxzFJ4YCtXw+/i3S84dD7TTPtmSwa4JS7t2+bWBaJyqasVCH/jbpABTFVX8dhAFQnz33CoJ4UKGcg5EWO/OCd6WpbScpJoZ6n/A2WLRuf1D6kXoiWbllS0zm8Pshtkh8TH0bfw5vMQ0mmlgOtks7QtjT/sl81ZXFSRfFMvauI9dNGAjeNExXEU1TkRuAPu0e+/t14bhK5818BRV85pQcGwg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7279.eurprd07.prod.outlook.com (2603:10a6:102:d4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 09:06:02 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 09:06:02 +0000
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
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 02/17] intel_iommu: Make pasid entry type check accurate
Thread-Topic: [PATCH v1 02/17] intel_iommu: Make pasid entry type check
 accurate
Thread-Index: AQHa2Os3RO9t/VexkU+MfO2Vkrw/j7H8MZWA
Date: Thu, 18 Jul 2024 09:06:02 +0000
Message-ID: <b6b0bff0-4df2-4b56-b59e-ccaa8c293b20@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-3-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-3-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7279:EE_
x-ms-office365-filtering-correlation-id: f03d31b9-e237-4b48-d0ad-08dca708d939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eEZGeWJrcmh2WnRpQW5jWDFsWHl1aWRSVHVYMXRWb1dQWFpMb29PVGsvVnhw?=
 =?utf-8?B?TFRSajE5ZG1RWWhrSXNMK0RWc1ptZEhNSjZ3ZllOalhycjRFdG92TDBTaHhC?=
 =?utf-8?B?dngrdUh2UmoveEtBNm9EZlVuTnFKTW9oVktoSHp4QWdjdFhKcTRnMWl2QW9s?=
 =?utf-8?B?Ky9lQ3lqYVpPQzc4cDdtSnVMNy9DRmgwWDExTXd1RmVXb0RFSUpUZS81Z0Fj?=
 =?utf-8?B?Y3dpME84WVZXTGlMcFNXdFdaeVAvZWNldGJYaCtDRk80ZXF5blVpM3oyODc3?=
 =?utf-8?B?R2k2NjdsZmhZRWwydEZJRjEvUDQvR0d3RFpzWFpsUVV3em5rbnQ0aXNjTENs?=
 =?utf-8?B?aFpGSUY1OUZrbHB5VU1NUTZldmpvM0xvRUwzbEhPamhlZUpkWXZ2amRFTnZp?=
 =?utf-8?B?SzRKajhybTB1RXFjTVN6c2tBemdKSDlySjVuM1FOZ3hUV0cvSS95WGswYzJ6?=
 =?utf-8?B?OE9XWTY3YzVPUVMxQ3RBR0k3YmhqdXp5aHdDOEtkZ2c1OU0vc21DWitFMUJZ?=
 =?utf-8?B?b1JjcDE5Unh4Q28wTjNxa0R2eG4xTUM0Tm85KzdGbGRZUjV0NjY4bFhVa3BU?=
 =?utf-8?B?OXJrRzZwRGZxM09YaytZbjJTL1JLbjdvL1ROZmZlN0lELzZsR2NjQWxsYjZm?=
 =?utf-8?B?Wk40ZDJKRDdnMk9RRjdMbWdXN2FMOVp5MXhZRVVHenpaMFdMOFEwY0JMamhQ?=
 =?utf-8?B?ejFCbUxUa1F1SzFVODlaTUdTMUxjRWZaNzBMNzRtVUpOZlZnV2xsOTR2UEpk?=
 =?utf-8?B?N00zd0tvTTYwZ2VQSVgvcWhKTjhVM2hEOFQ4dmNGMGR6R096MFNZWkswR28v?=
 =?utf-8?B?VUFGclY5akhGbEdjQ2ZxTlVSVExFSm1zVEdBdUZJVE1qdmx6L1hycTAwek9x?=
 =?utf-8?B?QXV4K2t2UHVURzNQWUdBeDdKcnRCc3VWZ1hNaHdPQklQQ0F5Qitmbk93Vm45?=
 =?utf-8?B?WUp6NmJkREZpQVlCZFFpWkRpa3NOcVpsUExGeHk0MU9BaGYvRjBzUmpCV1Fy?=
 =?utf-8?B?REFpS1BBSTR2RG8vTGl3cjdYM2ZhTWJYaExIV2haeER2UEdoYUFaUzQrcDFp?=
 =?utf-8?B?U3hsV3NsQkZZSWFSZ1N3VUhVT05PSDgzV0RGOXgrSkNKWnNkeWtudU1VV0E3?=
 =?utf-8?B?d1U0a1ZTY09wSHZhWlhMaEdKSCtyZkd5RjkyR3NxRGFOY3FWRHB4UDhjZG91?=
 =?utf-8?B?S2NPYmJUUWxUaUdXdlhGSXhCbmZ1dGpUOFdES1BLcWI3N05XcnEvVC9mb1Mv?=
 =?utf-8?B?dTI5dkhKMm05cjdDVmhvSDFJbTVCdUNvZUtVeVRISkxORWdRUFZFblJ3bVZJ?=
 =?utf-8?B?YlJFWGt5eGNweFQ4MlhwdTNFMUs5akVIZ2xsY1JYRC9ZK0FEbkpjaWdrVGtK?=
 =?utf-8?B?bDRURzIwbDBJdFJRQi92Y0dDTlpiNlZsUHEvTTdEZ256MlVZZkFzMTFDWU0v?=
 =?utf-8?B?VExPRkxsZkg0YTk4bTE3a0lVSGkvSnVIUUs3K1VFQlZ0bFg1b1UvelIrV2px?=
 =?utf-8?B?N3MzUjM3NzhjWXVqMEVFSDZ3NHRnazFOOTc4dkhpb28xelNlQXhMOEZVcDVE?=
 =?utf-8?B?UmtWUmhsaXRQb09ocnM4MnBNZ0NIK051YWxVV3UrNGFnL1B4cTZTaEVVUEJj?=
 =?utf-8?B?U1hRR3dmYUVRdkZlWTR4OVJ0aEl2VXN0MGFlN00yVzQ4QUMvU3dwdzM4RkZH?=
 =?utf-8?B?eUU1MHdmS21ZdkJyWWNpUWFkUnptT0hSOFVwUFZhS3VDUzhtN2dIWFVRdCto?=
 =?utf-8?B?aUJKbE5VUjFLc3gwVlk3WXR6RjNtTFF0OWo3bWYzTnBXbHlCVkoxUUk2cHlM?=
 =?utf-8?B?SndUTFJyQ2FWRWJhclpCNTNZQlA4QzlkOExlNVVid21VNzM4cmp5NUpRbVIr?=
 =?utf-8?B?djNzcE1RTFM1RTJWcGZpTUpSN29WQzEydzJaeFc4dy9hSlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzdOdGQwWnpqVjdQbjVBSGJIUTRpZXdpcXVRa1ZHaU5VY0tKdEZsais5cTRS?=
 =?utf-8?B?aEc1dG1KMllBMTE5ck9Cdmd5bzg1dmtyalpwcDIxSUtnZnZsb2o0SjhKYm5N?=
 =?utf-8?B?bVkyeEd5Z0IvVFNRNmN0ZE5JOCt2d2lHTEZlME9NZ1FjalMvUXYrckFod3ho?=
 =?utf-8?B?b3pCcE55aW5rZ2hIcnM5SlduNm1SUkg0M05IMDF5bjc3SFJzZXBaWnV0N3dn?=
 =?utf-8?B?SHl2MmlYVUFPTWdDUUc2R2FkZWxjOUUvTjB3VnJRZ055Z0hOUDJuT1gzV09j?=
 =?utf-8?B?ZWRua2VybVhpeE11T1oweXdRalhCNG04czgxUlV3VlhSdll4Ylh1WElEczRy?=
 =?utf-8?B?OElDUVRWZ3RzSzRuZjhsbG9FU05BUnBiOHlibUtVZm9RQWYzNW9TV1AxMTlE?=
 =?utf-8?B?dUtIcjNwTkJuVUJRQ3V2UERMbkpxS1FFWDZzaFZ1S25FUHo3eW44RmptUXNo?=
 =?utf-8?B?VGcyRDYwWXVGcEYyRjFvTnBGSVVzbmhEbXJrclREWVBTRHdGaUwzQ3RPSkQ1?=
 =?utf-8?B?bm1JajRRclVnWVk3TWpOL25mSkRJOWIwaDBWK3U2bklBYTJkRWwvdVA0YVZq?=
 =?utf-8?B?UktwdWlxc0xjblB2VEl6QkY4VC9qalVZRDlWYll3bG5IWnJUNTlnRDd4NGpp?=
 =?utf-8?B?MWJaWWNHaWl6Wk1Pcnl2Q1h3bkV4MEgrVGF5K3RPbHE3SkdDQk9UelBWNzBo?=
 =?utf-8?B?dGowNTMrWE1NN1QzZDMrTW5TbzZCNVNpSEpsaXRLdFN3ekZsc2xFQVhRT0hM?=
 =?utf-8?B?K2tUa0JqbjJuM3JiKzlJMUo1Tnk3dnNoMk9FdG9ROVBWSjVkRkk1WW91YXFK?=
 =?utf-8?B?WFBqcE5kQVE2WTB2NElmcjVBY1BLOEJ4cUk0Q0tNd0swSDVYUzlpRXA3UUhO?=
 =?utf-8?B?MFhxWDc2dlVWc3JEbWpJWmNqRUhLSDUvZ3JtNENoUVRhaWJmYlUvZjJjb0Ur?=
 =?utf-8?B?QjFyMmpFbkV4YUErZzFnUG1QVElmK3pjYm9yanZvclRiNlR3STFiNDJnMGRr?=
 =?utf-8?B?VFcyUGd1Qkw5ZnIwRk45Q2QrVUxiK1U4QmE0cmtEc2RzUmFMeHoyblh0eUIy?=
 =?utf-8?B?OGxoWUthNnZ0RnJqS082Y1BlQ3VBdnpnKzNsQTF0NGU0RExsTFJGNnRyNWRY?=
 =?utf-8?B?M3ljamw3M29tT2FIYk5NajNuTjFrbGp2YllCQW5jOEdxcmlEOUJKS0pIWW9B?=
 =?utf-8?B?S3BGeTIxWVRsa3QwQktlKzRyblBkOWg3QUwzeGtWVFNLNEVlUmdVWTF3RlZy?=
 =?utf-8?B?K1ZhcXFyTEVpV20yWnR4bmdzamhzNTJna0VtZmRlWk93MEdVQ1VoRTF1eWlv?=
 =?utf-8?B?djcvRzRuZ0tkYUtWQ1B3dmlLUVJLV2x2RjRWUW9PZXNqek00NVZka1VzUUp2?=
 =?utf-8?B?bUprSE4zL25nMTBlWkV1VTZFVHdoSlMzVmg4ZkZXejVWcncrQ1VvSnZUM25m?=
 =?utf-8?B?Y3JnTUVuT0tJdzdGQmtCUlFmQXFobDFhQUh4RGNVWlpINENhNjVkVHBJY2RI?=
 =?utf-8?B?ZGVrNGtQdHhkcEd2a2tiR3dUY1IwN3doNlcyZEthcUlCaXVPS09pckluRGla?=
 =?utf-8?B?QU9UL0ZIa3psVHlwZXRIRUdRRCtXblQzRzNzNHp6MnZKYXBqT2lGT0hXdjNi?=
 =?utf-8?B?c1ovWkNJcHRKZGdrZTRacGt6bFE1TzRtdmtKK0cxNHBuaXBZK2NVYmxJRGpB?=
 =?utf-8?B?LzAwMGxudVZneXZiOUhVVVJ4S3lhc1o2RUYyRmNwK2pWMThWYnhtUGUxWVZx?=
 =?utf-8?B?RkRkVXFTcFFjMHdFVzlZelNjaUlSRHJaYlI4Z1BPY2UvRFAwdTdmbXA2OVZU?=
 =?utf-8?B?YzlGaUdqWW5BR3dHY1BoQkpmSDhIaW9UaSt4ZXRURExub1lDb0lHa3RwM2NZ?=
 =?utf-8?B?RmRuMm9kNkY1dkNWaUNiekVKaFUwTXVrRk9VK1RKRU9XWldPbjRuTzV4c3JT?=
 =?utf-8?B?Vm03cU8rUzRhOEJSSEUvU0VSUU01T2VQeXNmOEp5cTZmZG5wQTMrOWhKN29i?=
 =?utf-8?B?WHFPNU5WczJta1NkYmpBK2ZiUUtmSm9aWFZDVlNqdzBtOUE4U2NSM0FOL1I0?=
 =?utf-8?B?SUdtSmRXZzF1QVV0WTdqSzBsb0NKeHE5Q2N0bHpFNFpiWWFIbnp3QmxjZXRY?=
 =?utf-8?B?YWN4NUJDSHFFMnNOdTVnSXR3enkzQVNlazdWZmhBTjlFQlJKN0R6KzU1VHZZ?=
 =?utf-8?Q?HS19uCkGmp7YLkxTtq6Fa/o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F841E0A843E2B47A161B8DDE970F191@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03d31b9-e237-4b48-d0ad-08dca708d939
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 09:06:02.5413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RoSuSbbD54cSx+rMnRRBp/iptDUr/Z8jmu6fhaohV3WiCfIIE07VUq60z9nxY03uCc+Ksd7dSardElh15YBz51YXx8DUZJZamk5Ma1qix3s6dgKdPYVl/CbmUA4rxLr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7279
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gV2hlbiBndWVzdCBj
b25maWd1cmVzIE5lc3RlZCBUcmFuc2xhdGlvbigwMTFiKSBvciBGaXJzdC1zdGFnZSBUcmFuc2xh
dGlvbiBvbmx5DQo+ICgwMDFiKSwgdHlwZSBjaGVjayBwYXNzZWQgdW5hY2N1cmF0ZWx5Lg0KPg0K
PiBGYWlscyB0aGUgdHlwZSBjaGVjayBpbiB0aG9zZSBjYXNlcyBhcyB0aGVpciBzaW11bGF0aW9u
IGlzbid0IHN1cHBvcnRlZCB5ZXQuDQo+DQo+IEZpeGVzOiBmYjQzY2Y3MzllMSAoImludGVsX2lv
bW11OiBzY2FsYWJsZSBtb2RlIGVtdWxhdGlvbiIpDQo+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8
IDEyICsrKystLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggZTY1ZjViMjlhNS4uMWNmZjhiMDBhZSAxMDA2
NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPiBAQCAtNzU5LDIwICs3NTksMTYgQEAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9w
ZV90eXBlX2NoZWNrKFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVlREUEFTSURFbnRyeSAqcGUpDQo+ICAgew0KPiAgICAg
ICBzd2l0Y2ggKFZURF9QRV9HRVRfVFlQRShwZSkpIHsNCj4gLSAgICBjYXNlIFZURF9TTV9QQVNJ
RF9FTlRSWV9GTFQ6DQo+ICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1NMVDoNCj4gLSAg
ICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9ORVNURUQ6DQo+IC0gICAgICAgIGJyZWFrOw0KPiAr
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gICAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfUFQ6
DQo+IC0gICAgICAgIGlmICgheDg2X2lvbW11LT5wdF9zdXBwb3J0ZWQpIHsNCj4gLSAgICAgICAg
ICAgIHJldHVybiBmYWxzZTsNCj4gLSAgICAgICAgfQ0KPiAtICAgICAgICBicmVhazsNCj4gKyAg
ICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRfc3VwcG9ydGVkOw0KPiArICAgIGNhc2UgVlREX1NN
X1BBU0lEX0VOVFJZX0ZMVDoNCj4gKyAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9ORVNURUQ6
DQo+ICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAvKiBVbmtub3duIHR5cGUgKi8NCj4gICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPiAtICAgIHJldHVybiB0cnVlOw0KPiAg
IH0NCj4NCj4gICBzdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BkaXJlX3ByZXNlbnQoVlREUEFTSURE
aXJFbnRyeSAqcGRpcmUpDQo+IC0tDQo+IDIuMzQuMQ0KPg0K

