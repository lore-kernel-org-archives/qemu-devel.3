Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0C8C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 03:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6j7G-0006Pq-QL; Mon, 13 May 2024 23:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6j7E-0006Pb-0Q
 for qemu-devel@nongnu.org; Mon, 13 May 2024 23:46:12 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6j7A-0007Vz-38
 for qemu-devel@nongnu.org; Mon, 13 May 2024 23:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715658368; x=1747194368;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kAJGbq7mFvC/xEX0dODP3LNAiaBV+h1c5csczbUnvcw=;
 b=UJpk9gvoolU+rCskk3G1AcLK1U4NgapSAWtmw96u4ILFuB4oLDPbadE/
 sPWsUcKuaC/JgXXPTOgMcwncbbTtnXYnYJ6YjmlsFoDAt50yx4BlC0kFi
 cNbTmGttfPLpg1+rRnV4FTxBHcWDVh3oUo0fNG60j3InkIODvVvPzjzs4
 /LEFQjzJaeWqp/veCz00KYX2X7SB/YCt+NbLfbJAIINeqJRRYfZ7wrvn5
 IbnfmYbb7+YG+qI5BPkEg87DwipneCONyYVXCxBD7DIJa2Gb2dQtS8YxD
 U3vAuuYY1mmy3Dc0kmbyZCbaBnXpn6zID4mUr8CT7EQjoEZd1wlVWUWK3 A==;
X-CSE-ConnectionGUID: 93pnqBXZSna/ksGVxX/V6g==
X-CSE-MsgGUID: 4EGsafYxQOiuR1lnST0I9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11794100"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11794100"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 20:46:05 -0700
X-CSE-ConnectionGUID: szMLVaF0SfKKgiTpVwZiGQ==
X-CSE-MsgGUID: lLFo6d9wT8KLn6plaJn4/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="31106278"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 May 2024 20:46:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 20:46:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 20:46:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 20:46:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 20:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUW21M3bak3li/DvBppO7CS+UuVsj4uTDRB5Z90LlUTBIfkpskJ982WPvsit45zJA3LMlqu4VZIK4OkCI7JP00FkNyqeqJwoa91it2MurD/iD26YgXbsQuleeehDcaEU5I/1b18NK/rQ6JnZMHJhLrlH6mcBNEH084+LUSa+30g9K581oocCAm5Ci68/kNpS6BL0kWIb2p06NlhrG+tnwest3qjgIPuXq3vFMhB9jOXgwjD568ue/XDMaqp+EVlkvUpWhgIrNWF3g2w6uYniefdXTWMlP8+K52UHDjL0XpvI/CMUyXRF5phpU4SwiA0db3sClpC/LMby+NrAtAnw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAJGbq7mFvC/xEX0dODP3LNAiaBV+h1c5csczbUnvcw=;
 b=fXgX1OTceRVXBlIQPCJuxL2uMZSCxNRcEQ2Bsjz0rPOk79e95WGwjyAFMih5wJdxg3ngCb00zBOmIoff75rJ6qeDGteTf2NAzIoACaL6f3ZKbpCn+v7Q4DpLXjA+e4tQdw6qGd9cMQRvur1j2/H6wFCdANo3mzDNTMT55KSbgcm6oMvThdcqkriVNvYXN+4ku3lGXpGsrm1K/hpXxkB1dp6Lpg07hIWG4wcxqMsONK/fP9pgbKLEBWGdUfQGXcalSdgQQ6ekF4X1BFBXUzgW4OuGD0fmlrbNWngJs9Fe1UUbI1O3ZikKa2rWgVgHrO/HqrOr8LzwHP7xZ1ni3ENP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 03:46:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 03:46:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Markus
 Armbruster" <armbru@redhat.com>
Subject: RE: [PATCH v2 00/11] VFIO: misc cleanups
Thread-Topic: [PATCH v2 00/11] VFIO: misc cleanups
Thread-Index: AQHaoEoiv4Ou0P94rEyr60fanuGJcbGWG7gQ
Date: Tue, 14 May 2024 03:46:01 +0000
Message-ID: <SJ0PR11MB6744B042C01BF5CE7C8FA0C492E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6567:EE_
x-ms-office365-filtering-correlation-id: e2a3c334-15f5-40a3-0260-08dc73c85fb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?alFkM0ZRaUdPZGd0Nlo4L1l4d0p3NVU4ZnhPc3Q1RlVYVGpyV1owZjVvUmM0?=
 =?utf-8?B?d0hqMlZvU21LY2hRSkZwNzRwdHdNUnZaeFhyL3B2VktPT25iQ3ZLcGl5UFdR?=
 =?utf-8?B?WFFKazFFMUxsUmNlc1VoZDd0WGtjZ0syOEY0UlE2SVhaVW9ubS8zTndNTXl6?=
 =?utf-8?B?N3ZTZ2pWWWNZWDdWU1VYVUtzaDlpK255TjVCUk5BeUFuRVFyamhVd2RsN0tM?=
 =?utf-8?B?K2U1ZC9VWG80ZzYvQWFEQUpYdm5QNDZJUkdwS0p3cllUendkMkJsSGdIeUxx?=
 =?utf-8?B?c3JjZmw1S2FtS082UnlVQ3RSZmhnMFVGMUp0Y05SR3o2MU1nRU5rRzQvaUxW?=
 =?utf-8?B?N0FaNzMvbXhUcXpyV29keFI4UnJZbW8vVlNMYUlUekdobW05cHZ4Z1Fmbmlo?=
 =?utf-8?B?OFB2NGcrMjZKNi85TVNMQm5UT2xJby9MT3dDK1hwMVQrWEFWV3VlOENTcFhL?=
 =?utf-8?B?U3ZLTUhCRlg1SG85Wi9zM0dEQ2J2WnkvS1ZBVUk4NThWaDIrbFJtcEpxN0RH?=
 =?utf-8?B?MDAwTTM2Y1QyaEhGTVp1TFZ4VmdtaEZYS2lrUTZ4aUkwaVltWDUwelRPbTZ4?=
 =?utf-8?B?aEhobHJiZFZLVzRSdllLWlNWR1luNWpaME5NNlM0NitQK0tGSmxUV0VrejBi?=
 =?utf-8?B?SHBDUXlGek52V1FWVXFKRUkrMWIzYVZxamYxekpwN3pISlRBaUh6OUlKYjN1?=
 =?utf-8?B?VUFncXF6RUFwRUVLbHFmS3Q5VmxOWWlFUXpnd3VVM3pqQTRzZ3BlcmYwV3BC?=
 =?utf-8?B?V3E1am1vRkl1VnpRZXBVd0hldWcrREJBY2RkakNHTklmVnRWamx3M1ZhNzF3?=
 =?utf-8?B?WStqVTZla2VVRXl6VWNhOHBDanBMandyaUtlTHptZFNaaE9TSGZyOHd0VXJW?=
 =?utf-8?B?dmtxbElWZm9WdEhLQ3I2U3hyS3JuL1JhY2lUWU1RdVpqWVh2bkNMbFowc1lr?=
 =?utf-8?B?VDhXUmlMdkFUaXB1SFBONWFDazdBSExSZ0paSmVrc1JFeDYwc3puaGJyYm1i?=
 =?utf-8?B?MFRmVWdQRU1lS284amxJUU11Lzlmc080dk1nRVk2MVRMd25id1dOcnp4VVZP?=
 =?utf-8?B?bFFhYzJvdEZRc2daMHpDNTdzZXdWcHYxdjFHdGhnekx3bWJkdEpuNEpQZDlw?=
 =?utf-8?B?a2F5c0ZCMjVMYWY3cGFFS0FPVDdndlhOUnFJekhFeklHOHVjbTAzSHdKT2xL?=
 =?utf-8?B?SzY0SlNZelZnLzdSQkpDbjVrb1Y2UGV5eFdlUlJnWWYyWmdNWG1VdWRZN1Zp?=
 =?utf-8?B?Y1dHQitpRk9KVkpobFZ4SUk4WFd3TnZleGh4TFJsdzE0STFuaU5HWEdRcllw?=
 =?utf-8?B?WEg1WXpvVkNGNFFxRzRlTzFwYUVoZUpoOTlLcDdaa2lvYVVkOXMvNHE2YURW?=
 =?utf-8?B?QUpOMld5WUx0Ti9JcTVnaTEwRm9sMzR0NmdqVGNiR01LWkNFeW9TTWtGOE5W?=
 =?utf-8?B?VWNrM2ZUbGpIbWM1Um54YWhhYnlhYnZ2amVyS0ZsekFYZysrRUNmSFVJc09w?=
 =?utf-8?B?cjM2cHQ4OUcxbm5BU2sySGorYU05bXZva2VHTWhSRjVHTEZqM1lIbDQ0TEFD?=
 =?utf-8?B?a2NwbVlZZ3h5YnFQc2Vrd2ovVDlPT0xvdDdVRFRjak1DN3h3cS85N09UY0c1?=
 =?utf-8?B?dW9OT2Q1QUs3S2UrbStCV2FCeHhHdFRsaUQ5MFRSM3VyTE5IWHVCWk5tQnYy?=
 =?utf-8?B?UHNTaCtPSnV5NEU4RElCamJmZUpXMmMycWtOaktWTC9OMzBkanE4aVNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTErTFlVM0dkWVhJaythRjVsTVpTWGFQNXlGZ0tycTIzM2ZBaEYwbmt0aDQw?=
 =?utf-8?B?aVBWNDdLMkxYYmMrK1ZUZGpSQUFBRkNXcW5idjZnQ0RCeUdHQTU5Vk5GazFP?=
 =?utf-8?B?ZzhWeDZxZktBU0laZG94ZzAxR3RSSG5naWlad214L1V3Mi9mUUVlanY5U3ZJ?=
 =?utf-8?B?TlA2NHU0WHNhM3JCaDM2b0xod3FQbzQwMHJCRlBYV1hLRWVxWmxab1dQZ29l?=
 =?utf-8?B?d3ZNcVRkU29jL0NmMzc5Vnd5TDR6UU9KZFJSNWNNS0pmNU5OVFBhbHJIa0lW?=
 =?utf-8?B?RzMxK0g5clAyY2s0N0RXSmVkMVRFclphZnVjOUpFWVI0MEpQZlVRUVltNGVC?=
 =?utf-8?B?QVdIUThoT0hDS1ErL0pVZm5zVWt6VmRKMnFLQVh1aVZLN1VqTU41c3RLWVZX?=
 =?utf-8?B?ZUsrSGQrc2p5V1NHdnVpeGQrYWg3YzdESm5SUFdGQmZjUlMrNWF5anJjbS9X?=
 =?utf-8?B?REFjR2FzcFRmb0dCQ2tibFE4Wm9HODVVUlg1MzZFdldMOHVPUTBRWkE2YUJX?=
 =?utf-8?B?Zk02cEpNV0FheFlrN1lXT3ltN0hNNWZSemtoS1YwQ0VkSDRTWExzek96OXY0?=
 =?utf-8?B?Y0xMYTVxazAwR0pFY1h5M3lSTU4zdjVsMDM4WEhKZGNDNTJFZDRqZGR4a3Zw?=
 =?utf-8?B?NEh2YWRjNUZ6eW8yY2tmcm42dDFpSjMxWExmeW54UElFQVVwK201bnEzSzB2?=
 =?utf-8?B?L3JKNU52Q0IzN2tPdjhOOFhTVEwvMEtJaGlrZWpxVTVvZW5nMTVxYlJTMFJZ?=
 =?utf-8?B?dGVhK1NCazF5NDRzY291Qml6eDZrT0dpODJVZ3cwbk9HeFNMS2ZLOHdZOGQr?=
 =?utf-8?B?cGJZRDFydkxta0xwZmxmSnFiN0lUY05qeEdxTlc0NmdXWFZucjNZNDdWOWVz?=
 =?utf-8?B?M0k4YmltRjVGcHdhcWhjTTArNjRReXFFdzRtaGZTaEtjSzFDLzdtQTdzcWdF?=
 =?utf-8?B?Ym9aeVdWZTE4eFZ1UkZ5bFh0aVpzY2dOZVZmdHBpZnhsQ1JPdU9lTFV3aG1Z?=
 =?utf-8?B?RzdDUlBkMkVHendFUkREZzNLKzBURGxSc1Y1cjVQcjRsemVWbXdsSXBocnpR?=
 =?utf-8?B?NThRNDF2bnRsR3IzaU15WEVvZUR3aWZzWm1rNWFUVG1jUXR6TGNRVGdnZVBa?=
 =?utf-8?B?NS83MkhCUytvUlF2ZGJtZklqWUhtZGtDTXdaQ2E2UG1mWGU3MnhHQ1VQSnlw?=
 =?utf-8?B?LzVEWXQrelFsRzFWblEyQU8vdUhWYVNwR2FwK0s5NGpqdW9KM0JiOXQreXFZ?=
 =?utf-8?B?U05HK2pFcHJzLzhyS0p2MHVJNjVDRE9MeVBPdXVzenhMWlNxUFZ4ZzFpa2x2?=
 =?utf-8?B?MHV4MlFNTmJRaTd2aGdSQ3RwWVdwbEFUb2VMNzFiQWp6R0dUWmdhTGo5Q3ZD?=
 =?utf-8?B?THc0bmJzbU10V21TdXVxcGozMUN0RjN2Vk9HS2xCeHJJT0hLZkFXOFVoL2Zp?=
 =?utf-8?B?RXF5NlN5N1ZLb2VuNUlIVVRPL2pFRk52N3lIT01DZlBxaUF1allaM0FxdVFi?=
 =?utf-8?B?aDN6eUY5MXltYVI4NzRjNStUd0JwTFdjeElmYndmeThjS0ZaeTJUM3pGZUtl?=
 =?utf-8?B?djlVNm94MGJRVFZDL2czbEN2cWViN08zVFZxbUhLR2N6Q2tFSjZMTk54dG1Y?=
 =?utf-8?B?aXZHKzhvcUtWdjNMVDE5Yy85WUIweTBRWE44cGpNRVMrRTRJVHRIV055Mmhq?=
 =?utf-8?B?UHN0RzFvNjNyeHZpR1E1Nkpkd2VXajNYVEhocmU5bk5GZUxYNHlNUjN6RmQz?=
 =?utf-8?B?VnFYN2tjMC9tdFFwU0FyaVo5WXAvRlJlSjhKdFV3TFpna1ZuYSsvTEFaYVpn?=
 =?utf-8?B?WXZLTXBsVEZBKzI3Y2NhOGU4ZEQrUHE4Kys1L1BKc0lWYSs5UnNac0JBN2c2?=
 =?utf-8?B?Zmk5dVhUeVB6OThHaWsrQzBQZDUzdGtNZ1Y2T2kzWnZueXkxYTAxVmJTcmVO?=
 =?utf-8?B?Qk1tRytnc094eSs2TTdrKzVZdkxVRjZVQ0NXRktpTGdsOUxSVG9JNGphYVNS?=
 =?utf-8?B?cW9SNzQvOVFDRmllSDl5TndaTUpyelUzckVENUJJZVJRRmUyS29GdzVSQ0VL?=
 =?utf-8?B?bDJxL0VmbUNWTStMYVlWTVpuVU1md0w4MUFWWnp0SVBQQnRUSUpETUFkeGZC?=
 =?utf-8?Q?ix2kIcaPwG7wy8ahIZ9fTTX+K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a3c334-15f5-40a3-0260-08dc73c85fb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 03:46:01.5719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oBJBrYPjQr/OTY2WKKTza9IISb1bguOVOXu24nFmxHaik5otZHIWufQsFA6sYuoB9JgWwlZxcmmldqXCuCDMG9hiNLPdp5Q7XXVAaOWbrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

SGkgQWxsLA0KDQpXaGVuIEkgbG9va2VkIGludG8gbW9yZSBmdW5jdGlvbnMgcGFzc2luZyAnRXJy
b3IgKionLA0KSSBzZWUgbWFueSBhcmUgaW4gImludCB0ZXN0ZnVuYyguLi4sIEVycm9yICoqZXJy
cCkiIGZvcm1hdC4gSSB3YXMgYSBiaXQgY29uZnVzZWQuDQoNClRoZSBxYXBpL2Vycm9yLmggc3Vn
Z2VzdHM6DQoNCiogLSBXaGVuZXZlciBwcmFjdGljYWwsIGFsc28gcmV0dXJuIGEgdmFsdWUgdGhh
dCBpbmRpY2F0ZXMgc3VjY2VzcyAvDQogKiAgIGZhaWx1cmUuICBUaGlzIGNhbiBtYWtlIHRoZSBl
cnJvciBjaGVja2luZyBtb3JlIGNvbmNpc2UsIGFuZCBjYW4NCiAqICAgYXZvaWQgdXNlbGVzcyBl
cnJvciBvYmplY3QgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uLiAgTm90ZSB0aGF0DQogKiAgIHdl
IHN0aWxsIGhhdmUgbWFueSBmdW5jdGlvbnMgcmV0dXJuaW5nIHZvaWQuICBXZSByZWNvbW1lbmQN
CiAqICAg4oCiIGJvb2wtdmFsdWVkIGZ1bmN0aW9ucyByZXR1cm4gdHJ1ZSBvbiBzdWNjZXNzIC8g
ZmFsc2Ugb24gZmFpbHVyZSwNCiAqICAg4oCiIHBvaW50ZXItdmFsdWVkIGZ1bmN0aW9ucyByZXR1
cm4gbm9uLW51bGwgLyBudWxsIHBvaW50ZXIsIGFuZA0KICogICDigKIgaW50ZWdlci12YWx1ZWQg
ZnVuY3Rpb25zIHJldHVybiBub24tbmVnYXRpdmUgLyBuZWdhdGl2ZS4NCg0KVGhlcmUgYXJlIHNv
bWUgZnVuY3Rpb25zIGxpa2U6DQoNCmludCB0ZXN0ZnVuYyguLi4sIEVycm9yICoqZXJycCkNCnsN
CiAgICBJZiAoc3VjY2VlZCkgew0KICAgICAgICByZXR1cm4gMDsNCiAgICB9IGVsc2Ugew0KICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICB9DQp9DQoNCkRvZXMgdGVzdGZ1bmMoKSBmb2xsb3cg
J2ludGVnZXItdmFsdWVkIGZ1bmN0aW9ucycgYXMgYWJvdmUgb3IgaXQgc2hvdWxkIGJlIGNoYW5n
ZWQgdG8gJ2Jvb2wtdmFsdWVkIGZ1bmN0aW9ucyc/DQoNCklzIHRoZXJlIGEgY2xlYXIgcnVsZSBp
biB3aGljaCBjYXNlIHRvIGNoYW5nZSAnaW50IHRlc3RmdW5jKC4uLiBFcnJvciAqKmVycnApJyB0
byAnIGJvb2wgdGVzdGZ1bmMoLi4uIEVycm9yICoqZXJycCknPw0KDQpUaGFua3MNClpoZW56aG9u
Zw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEdWFuLCBaaGVuemhvbmcg
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
PlN1YmplY3Q6IFtQQVRDSCB2MiAwMC8xMV0gVkZJTzogbWlzYyBjbGVhbnVwcw0KPg0KPkhpDQo+
DQo+VGhpcyBpcyBhIGNsZWFudXAgc2VyaWVzIHRvIGNoYW5nZSBmdW5jdGlvbnMgaW4gaHcvdmZp
by8gdG8gcmV0dXJuIGJvb2wNCj53aGVuIHRoZSBlcnJvciBpcyBwYXNzZWQgdGhyb3VnaCBlcnJw
IHBhcmFtZXRlciwgYWxzbyBzb21lIGNsZWFudXANCj53aXRoIGdfYXV0b2ZyZWUuDQo+DQo+U2Vl
IGRpc2N1c3Npb24gYXQgaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMjQtDQo+MDQvbXNnMDQ3ODIuaHRtbA0KPg0KPlRoaXMgc2VyaWVzIHByb2Nlc3NlZCBi
ZWxvdyBmaWxlczoNCj5ody92ZmlvL2NvbnRhaW5lci5jDQo+aHcvdmZpby9pb21tdWZkLmMNCj5o
dy92ZmlvL2Nwci5jDQo+YmFja2VuZHMvaW9tbXVmZC5jDQo+DQo+U28gYWJvdmUgZmlsZXMgYXJl
IGNsZWFuIG5vdywgdGhlcmUgYXJlIHN0aWxsIG90aGVyIGZpbGVzIG5lZWQgcHJvY2Vzc2luZw0K
PmluIGh3L3ZmaW8uDQo+DQo+VGVzdCBkb25lIG9uIHg4NiBwbGF0Zm9ybToNCj52ZmlvIGRldmlj
ZSBob3RwbHVnL3VucGx1ZyB3aXRoIGRpZmZlcmVudCBiYWNrZW5kDQo+cmVib290DQo+DQo+VGhh
bmtzDQo+Wmhlbnpob25nDQo+DQo+Q2hhbmdlbG9nOg0KPnYyOg0KPi0gc3BsaXQgb3V0IGdfYXV0
b2ZyZWUgY29kZSBhcyBhIHBhdGNoIChDw6lkcmljKQ0KPi0gYWRkIHByb2Nlc3NpbmcgZm9yIG1v
cmUgZmlsZXMNCj4NCj5aaGVuemhvbmcgRHVhbiAoMTEpOg0KPiAgdmZpby9wY2k6IFVzZSBnX2F1
dG9mcmVlIGluIHZmaW9fcmVhbGl6ZQ0KPiAgdmZpby9wY2k6IFVzZSBnX2F1dG9mcmVlIGluIGlv
bW11ZmRfY2Rldl9nZXRfaW5mb19pb3ZhX3JhbmdlKCkNCj4gIHZmaW86IE1ha2UgVkZJT0lPTU1V
Q2xhc3M6OmF0dGFjaF9kZXZpY2UoKSBhbmQgaXRzIHdyYXBwZXIgcmV0dXJuIGJvb2wNCj4gIHZm
aW86IE1ha2UgVkZJT0lPTU1VQ2xhc3M6OnNldHVwKCkgcmV0dXJuIGJvb2wNCj4gIHZmaW86IE1h
a2UgVkZJT0lPTU1VQ2xhc3M6OmFkZF93aW5kb3coKSBhbmQgaXRzIHdyYXBwZXIgcmV0dXJuIGJv
b2wNCj4gIHZmaW8vY29udGFpbmVyOiBNYWtlIHZmaW9fY29ubmVjdF9jb250YWluZXIoKSByZXR1
cm4gYm9vbA0KPiAgdmZpby9jb250YWluZXI6IE1ha2UgdmZpb19zZXRfaW9tbXUoKSByZXR1cm4g
Ym9vbA0KPiAgdmZpby9jb250YWluZXI6IE1ha2UgdmZpb19nZXRfZGV2aWNlKCkgcmV0dXJuIGJv
b2wNCj4gIHZmaW8vaW9tbXVmZDogTWFrZSBpb21tdWZkX2NkZXZfKigpIHJldHVybiBib29sDQo+
ICB2ZmlvL2NwcjogTWFrZSB2ZmlvX2Nwcl9yZWdpc3Rlcl9jb250YWluZXIoKSByZXR1cm4gYm9v
bA0KPiAgYmFja2VuZHMvaW9tbXVmZDogTWFrZSBpb21tdWZkX2JhY2tlbmRfKigpIHJldHVybiBi
b29sDQo+DQo+IGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oICAgICAgICAgfCAgIDYgKy0N
Cj4gaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8ICAxOCArKy0tLQ0KPiBp
bmNsdWRlL3N5c2VtdS9pb21tdWZkLmggICAgICAgICAgICAgIHwgICA2ICstDQo+IGJhY2tlbmRz
L2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgICAgfCAgMjkgKysrLS0tLQ0KPiBody92ZmlvL2Fw
LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+IGh3L3ZmaW8vY2N3LmMgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCj4gaHcvdmZpby9jb21tb24uYyAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNiArLQ0KPiBody92ZmlvL2NvbnRhaW5lci1iYXNlLmMgICAgICAg
ICAgICAgIHwgICA4ICstDQo+IGh3L3ZmaW8vY29udGFpbmVyLmMgICAgICAgICAgICAgICAgICAg
fCAgODEgKysrKysrKysrLS0tLS0tLS0tLQ0KPiBody92ZmlvL2Nwci5jICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICA0ICstDQo+IGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgICAgICAg
ICAgfCAxMDkgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gaHcvdmZpby9wY2kuYyAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxMiArKy0NCj4gaHcvdmZpby9wbGF0Zm9ybS5jICAgICAg
ICAgICAgICAgICAgICB8ICAgNyArLQ0KPiBody92ZmlvL3NwYXByLmMgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDI4ICsrKy0tLS0NCj4gYmFja2VuZHMvdHJhY2UtZXZlbnRzICAgICAgICAgICAg
ICAgICB8ICAgNCArLQ0KPiAxNSBmaWxlcyBjaGFuZ2VkLCAxNDcgaW5zZXJ0aW9ucygrKSwgMTgz
IGRlbGV0aW9ucygtKQ0KPg0KPi0tDQo+Mi4zNC4xDQoNCg==

