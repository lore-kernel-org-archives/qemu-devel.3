Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D77C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsM2-0006tc-11; Thu, 11 Jul 2024 07:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sRsLy-0006sC-1i
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:52:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sandesh.patel@nutanix.com>)
 id 1sRsLt-0003VF-GZ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:52:49 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4qtjQ008101;
 Thu, 11 Jul 2024 04:52:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gjJkCv/yzkf71icmO9Lmws3YV7tbjtUllAPgOKmx0
 +s=; b=O3fWC/bhpYUPfGuKi37Rd55x7SV1j7l2AdNLJMGdNYv+ZndTVUmFCzz/y
 qEoJ4eQtDnZRHXePTyeLql04vdJnoLvshM1O6yrOinZ2Xn5aS57c+cFyDm86IjTZ
 isHQiyrME7zn26fWGm940w9/TLXgIzCH4ahNNPFKJXdL+onhwPToQOgB9UR6K3av
 v3rz0XTvCZ1p8WT5PZxnLXu6ND10FY+FJHvkfQ53Fpt5fQwFoa6q5+i5abaX+e1x
 iZqfRaZAmw6+oK8Wif5cN2Nek6sC1C1jSkNUraFC4/UfOYCGGi4U2HGVo6Jtllvo
 DkZ5IDqiKMu7nKThM34XPtPNujA/w==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010000.outbound.protection.outlook.com [40.93.11.0])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4073f6kqm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jul 2024 04:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2zZqFfzZOeRqbLDFYH66BWAbt1dTEqev23bGt1r/6muh2l9Um4QGC78UG5wMEPneEZP9liX4IhE2BgpzcTOnRQkjF2ZbSOXrmoA5kkUk1E2cC6hMwySyUK8wtEYeIMxsCx632uURCRuQ8vsdjHawyoo9an/e5m2GFEssGpas+FHOg+/dqHEZcUDQMXvpxce6Pg6j4v1MjGuh4u1wsS6aD51trCeddQUTBDEEW7ExNEc7d6EjUld525Zw8qP0ZA6fez5huGxyl2mKjbGkJXfHD7ONyN4MkxJgZEYFPE44LOOhNFC2UIq5cWTQ2EM4IV1J5ns4Gxv7zjET2hlQfBBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjJkCv/yzkf71icmO9Lmws3YV7tbjtUllAPgOKmx0+s=;
 b=wsvWPwHgvGf5zqyiXpwFvWTot4HoDzu29E4QcxmzvpMkZQeGGXlsBuqyRv+9uEX2pVELspi051zx86Fgtj6FWIyq8evZ4+goTXJHt4G/6vBxtxd8JaQB4dbc+xbiNPP+AWGiU6kOYQBMC5FcHwzLEpDIbgtE49ixAp3s1R11amRgnmDwAiuRco6iNHQsPSkTNWd+mtjj2iRHxm5dkJdOVB4qMYh83LXlfO6PXUMeM7OkJT5SnVA9E+SkSHkWLAMuU7JjY+AwUwSwkKLGziAgZvx/usmIwDA2rt1Cs+sF/O5VYCgmpQF/7jVhywlCgUnuMJlB5JEdCH/yEddaYnTHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjJkCv/yzkf71icmO9Lmws3YV7tbjtUllAPgOKmx0+s=;
 b=M7zZYIOnDh4yEJmeXYPI7L/LeugY2Z0WWh5T5P8wNemWy/PHrR3tc6nQsuiG/mYz2UNz3ll1/YoI9PXZ8qjRnrVrKs8Ap/gYIf6ThDPwuolJ88wvdpz81NkQlmu+qPBm/qd7ayzrwplsVdtvzC1EzAaYiMGOml47VjTvdd8zuf/VnEkZpc0eiKr0LUQ2JPHgUsypqQkZcSNN61H82SYN4kparHlz1eBYxjFLK7UZesWLqzyMmMGFoeHXN3TQQMvFAcBf8IFNvem7QsnHOcyFPyDuUa2vKg9c2zjmasQlrbLqdOGoIsIjzROm2gBLpDRsDQvmf9/dTRRAtNoTPyBRcw==
Received: from IA1PR02MB9017.namprd02.prod.outlook.com (2603:10b6:208:3ab::12)
 by BY5PR02MB6660.namprd02.prod.outlook.com (2603:10b6:a03:212::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 11:52:28 +0000
Received: from IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616]) by IA1PR02MB9017.namprd02.prod.outlook.com
 ([fe80::d569:fbdf:590c:d616%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 11:52:28 +0000
From: Sandesh Patel <sandesh.patel@nutanix.com>
To: David Woodhouse <dwmw2@infradead.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Rob Scheepens
 <rob.scheepens@nutanix.com>, Prerna Saxena <confluence@nutanix.com>, Dexuan
 Cui <decui@microsoft.com>, Alexander Graf <alex@csgraf.de>
Subject: Re: More than 255 vcpus Windows VM setup without viommu ?
Thread-Topic: More than 255 vcpus Windows VM setup without viommu ?
Thread-Index: AQHazD8hTLL5FHwLqEGHw53bjlsZbbHjJUCAgAIG04CAB2mXAIAEmSMAgABCUACAAAfygA==
Date: Thu, 11 Jul 2024 11:52:28 +0000
Message-ID: <ACC111A2-A3BA-49C9-8EAE-C62ADAA74FB7@nutanix.com>
References: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
 <3bb7c269ab0a13fe4398d2c7920d2f6bf8e86d47.camel@infradead.org>
 <7BBA47BD-AC3D-4F12-A860-AD3F2B509257@nutanix.com>
 <39b92288418839e9cdba447705a44a8e216dedc3.camel@infradead.org>
 <b37283824ff4b7c6cc3a0c51199e6aa9b4b658a3.camel@infradead.org>
 <2cffab2dc20f99ab0c0391bbf5076113cf74411b.camel@infradead.org>
In-Reply-To: <2cffab2dc20f99ab0c0391bbf5076113cf74411b.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB9017:EE_|BY5PR02MB6660:EE_
x-ms-office365-filtering-correlation-id: 6c44bde4-4a11-4a3f-5252-08dca19ff062
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnpzdFlSL1FvMWdvbTZFazlBbm50dUhqSWZKZGtYTnFxOGZFK05GMlhWZ2tw?=
 =?utf-8?B?M3RGT0oySW1YWnB2WEN2b2p0U3hKeGNhOU80M1paWnBJQXhheEFGWTI5bUR2?=
 =?utf-8?B?VUtVNHRxdkZTTzVvUG1lMXBnemZlUkRwTit4QmZzYVVJZ0JhQlRaOE44Y0Nq?=
 =?utf-8?B?TzJwWkU2cEtHbVMxaDdSQzB0dndjc1JCZEUrbXJybG5wdU5LcmgrUHV2ZFpu?=
 =?utf-8?B?NllQdjlXSXZ3alN1MVhxek0yTXhQQnNlSm9PUEdVQ2JvdThtdXE3K05RY1dV?=
 =?utf-8?B?SytSczZmc1NjTDFhWC9wa1B6U3VzUU9VZXBmTi8zVUNqODk2MFJYN1RJSE92?=
 =?utf-8?B?SlczR3NjZnBXUmNQQ1BXVlAvOFduVjFGYWhEY25LeDFYVTlhSk5JM0gyL0kr?=
 =?utf-8?B?d3hhNmhEREVnd3d3QlVEQzVEZkI4MWlFMDdIZHBPQkxOTmNnUnd4bEdyTkxs?=
 =?utf-8?B?c0xjUlc1V2xXaStXR2dCR0hBWTl5V3lSZ080TzB3ZXJPNlJvMVREcGE2SnlJ?=
 =?utf-8?B?MGdieklMbWx6eDdMOWt1SXNIblZLcng3UjVrMVV3RExWSEY0dDBTcklibHE0?=
 =?utf-8?B?RmZxWjNqcVA1ZW5IY2lnMVVray9jQjNkNVFuVU5lbzJHVVN3WlBZTmtNUFEz?=
 =?utf-8?B?a1NVNHlIRkhVdDA3NFFJdUtSWFNWaWJkZ2dkVThRLzJCMmlIdFpqVjRmelcw?=
 =?utf-8?B?dkY2UmRhREtMU2M3bHF3eDU1bWlnNjU2ZWZrR09CL01HelVSd2FwVU9nRHA2?=
 =?utf-8?B?VFdPd3VkcENnVkxmbjE1c2JzK2R0MFYwSkV5TW5TTEtDQWl4K1ZmbldOMkl6?=
 =?utf-8?B?ZzVBay9LQ2ptQ3VWeFdRMzdDaXdNZS9abzlVS0NFNC85N2FFdm9PTGxNUmJ6?=
 =?utf-8?B?c3dkT01Razc4VUo2WWd4aVM3MmpncDByK1hSTElCb0VCcnN6N0s3RzdYcml2?=
 =?utf-8?B?eHJWOVNFMUtjSGJPbkpoR0dvREpnaXJtU3NmdGg4Vk1KZWJ2SVNtZCtxSVNy?=
 =?utf-8?B?TlFadVV3T2ZPTWd4Tm9uN0hQK05zUng3SmU4cHR4cU9rbW01SWhaTWFoVGhU?=
 =?utf-8?B?eWxPbldJS0ViZ3RFSnFhOWlrVXViUVF1QldDdzNxbTZTLytUVW1YTm90L0xG?=
 =?utf-8?B?MDBuTGJMdVlxemYzbE5NaEIzamFkTWtaT0hMenYzaXUwM0NCUlpDdmdCMVo2?=
 =?utf-8?B?b1VoTk00U2NLRnZyaVJlTFVSbkhkYU1yemxkQWtJZnZyZ0hrY1VneGtBRGRw?=
 =?utf-8?B?V1p6aXN4VHpDR1l3aEtoZEdjaHQwVWxuMFA0OXR5dzNjWTIzKzZHdktHR2Fk?=
 =?utf-8?B?RVdGckYwZVdrOTZnZGJJMTdHWnFDZHZPQnM2Qit3VGkwZlB5S3ZDNXBseDZF?=
 =?utf-8?B?R2RGQnNVK1VTNDNXbUtKVldVdzJXS2gxMldsU0RHTCtLT1QxQnFld0V6R0Ry?=
 =?utf-8?B?bHFadUhoSjNQNlBRRkdMZ0I2dWpNQy9KT2JETHhGY0RsRGJubGdWU1h5S01G?=
 =?utf-8?B?SmhMRWFKM3pPM09DMkF4SUpweU4vclJ3dW0wbzdtQTAxOVVKdk55cTJ3ek5B?=
 =?utf-8?B?cDk1aThCLzdwRnhzYkticHkyZTRHOFd2K2RYd0RoVFRtNStJdVJ1UmptYWF5?=
 =?utf-8?B?RnI4Wm9WRVR1ZklmRXIvcnZ3ZUN5VDRZT2dkdkEwT243K0ZWeUFHdmpHSU5s?=
 =?utf-8?B?NkV3UkQxa1lDZ3VIYUlWeVRyZnVvVS9iZlhSZlMrdkdzTUpOd08zdzBtbHdm?=
 =?utf-8?B?ZXBCdVhiTUZDKytJTFQ1T0l1THIxcjZnSUNKbENaYmFjMW5TYnpqZlFpWXN6?=
 =?utf-8?B?eWhPR2k3aDFUT2FVV25OTUNvOVVIdUtxdHFmWHhYTkVuVnM5aGcvcExiRnox?=
 =?utf-8?B?NE0zSTErVSs5bjJ0dTRXZ1k0azhqN1ExSGtMN3o1TjhSM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR02MB9017.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1CRzlFaStScDRkUUc1dVpWMm9XWHQwd3grYnVST1hBUHNuY1lXRmZQd0Rt?=
 =?utf-8?B?Tmx2elN0bGc5d3owQjI3dzVjbmoyRk9Xa2liN0VCUVlIeTRLQU8ya3JmZHNK?=
 =?utf-8?B?UDZweXgydG1mTDRqYWJPbXJkZGJpVURteWpsb0t4dkhlLzAwZm91MDB6R0l4?=
 =?utf-8?B?dzRUdmRPU0pPRmlFQ2Nocm5MUElZdjJRVGo1Z0RwUEpuTVA4aUVBTjBxMmYz?=
 =?utf-8?B?K3QvU3RERGhnU2kxOEk2N1ZHdTF2dXBQNUtkWjk3Z0ZaUHg2Z1Q3TXZqWlpS?=
 =?utf-8?B?N3AzT1NGOG9GWTVJYmR1N2k4dm1KUittaDB3M2pNSVJ1dkNiaHRpb2YrZTRC?=
 =?utf-8?B?bWJvMHU3RHM3R2JuNjhPNHhQTTdPVkVOTENwNWlHaXV6VmFWVW1yb1dVUTZh?=
 =?utf-8?B?aDFDN09JYkZQMGNham1XTjdXY0tzODU1V2VMakRldWs1QVEvN25XQVhzOGpu?=
 =?utf-8?B?UE9FeGRHYy9YRnVjOWx6ZmFxVlBVWW5Qdm1oaGxsSXRXUW5HUWNRb0xaRFlC?=
 =?utf-8?B?dnRBeTBXOGFaWVdJcVVPZCtOWEd6TmFQS3pub25EN0FpRFVrQjU3R3BCRU5P?=
 =?utf-8?B?akloNldWZ3g3cHFKTjlJRFZEejhqVjQxQURocXQ0OXZlVDRqcElSTVphSEth?=
 =?utf-8?B?elNFMnh5YTQxVE9yN3VGemZ6L2IrTjFqUTBpcDdGRU9qTDVZRmdHRFJhalNw?=
 =?utf-8?B?a2JwblU0a1RxelFRcGdpZk93ME9rWUp5a0FhSjMzRzQvN1JYNHlBRTg1dHNQ?=
 =?utf-8?B?cng1aVBwR3hvNUdJUmd3N3VtKytMYng4QVRsM1A2Q1BMeG9ucjlqSTJXWCtZ?=
 =?utf-8?B?OHhYTDJPbkZITFdRTG5rRUFiRThnRWI1UStoQjUrRzZMMTlsWEQvMjFRazQ2?=
 =?utf-8?B?TDRFeSt0TVJoekt2OERBZk1xcklDRE9TRVF6Rkd1a3BraHRLQnZNRGFlS1VY?=
 =?utf-8?B?elRKd2NpbUFNYkcrMkw5ekV6NEZ2T3o2NnlNVEpDV2NUSzRTZFhteFN6Rllt?=
 =?utf-8?B?RUxFeFdJR3daYjVIQ1ovMzRPdE1MV2k0andLOHJTTTYzZFdHNWx0UHVqU0tO?=
 =?utf-8?B?NVZmU2Q4azN3MS93T1F5RnhUSVBiOG1Gay9FcnBsU3pVWGxvb1ROK0ZIeWRJ?=
 =?utf-8?B?L1BNM2dNQWcxZUw3WXhadkRmM253V2dSV1pwRnU5dWNLWkFYV3VHSXo2TGx5?=
 =?utf-8?B?eGpvTS9iVUFac1JNS0ZNdFFaVnQrN3NJU0lxTWR3cTdhSkpVNVpja3hhU3pU?=
 =?utf-8?B?MW1nLzY1Tkt5WjIvaElZbGN1akxRNTBGNzVNREpCZGtSMkVCOGhZYmJGM3Iz?=
 =?utf-8?B?YUQxUEVCUFczT2V1QlpyZmx0a3RPVW9lZmFhOWhBN3ZNcm9qdnZLVlJ6emF4?=
 =?utf-8?B?RXQ3L0JxbllCT2Rkbk5zRjNuM2s5Sy9IaXFjUkVkUXgxUm1tWUFRVU9ONkI4?=
 =?utf-8?B?bmRvalArU0dGa2FYU3ZGVG10Tk1xSnM2NVl0WmhRQmFHOEthVzlabDUwYkJJ?=
 =?utf-8?B?NFFpS1c0VXhsY3AwczF6SzNYN09yNktXUVNBbjMyR0FFaDl0RU0zMG0ySEow?=
 =?utf-8?B?SzlpNGVIZmVTaVlNMThCQ0o2SUZ3Wm53SlB2WDEvU3c3NGVpMGR3Ulp0NGth?=
 =?utf-8?B?SllUWGRvbGRsWTFhMEdrWjhXRm5QcE1wZmNiRVhwWmZGV2NiKzRQUzB2OG9R?=
 =?utf-8?B?MnZSV2pqNm1MdFZ6TWVTWkVHWnMwTXA4LzRrSEd3b2NPdVp4V0Uvc01YSEhO?=
 =?utf-8?B?K295Yk5kdmV0cWovZC9oaU1KTk1hMTlmMGg0b0Z3cFF6QWNqZDJYeVlWaEtW?=
 =?utf-8?B?MlIzbUxvb0h4RmM5OHlnTjZYNGhTUzQ4NDVqRVBYNGt1TVNYcXMzNXVMMSsr?=
 =?utf-8?B?Mmo4YnJNemRSdUdrN1djS3YrU1RPUzlFT2dGQkVTRWlUdE5EOHVGRjhLUExx?=
 =?utf-8?B?V2lLRnRZbWFrSzg1TWdFNXhjQmNMckxQRndtS0NhN255Yk0xSmVoVG95Tm5p?=
 =?utf-8?B?eUhCakxpUy9RSmRBUnJHZk8xY2hFL29DY0k5MnUzTVNINTVmZEFIdlFRem8r?=
 =?utf-8?B?djFXR1ZwQmNkWEw0SXJxN21tSUh2VTcvSENkZjQ1UE9YQ3RiTmlRRFlHb2U2?=
 =?utf-8?B?QWUyWEtyWVJxTmVDMGQwRjFiUHlmRG9sQ2RTZW5BbFRNR3NralNidVc3bkNj?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03266ED5844838449DB251B21D5E4D6D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB9017.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c44bde4-4a11-4a3f-5252-08dca19ff062
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 11:52:28.4545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQie8g8vKo7T6Ukpk0UmAs3U6Mdu5iDtiJK1JR1+owHtduGRSbtjg0BUEidyJetXLrh2DTNQfaS5a8fWyoG4wQmQcWNULjS+IMf0VVLWXHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6660
X-Proofpoint-GUID: SU7NNgiM0AdcQwUkLLz3HOVtVYHbzGv3
X-Proofpoint-ORIG-GUID: SU7NNgiM0AdcQwUkLLz3HOVtVYHbzGv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=sandesh.patel@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhhbmtzIERhdmlkIGZvciBhbGwgdGhlIGFuYWx5c2lzLg0KDQo+IE9uIDExIEp1bCAyMDI0LCBh
dCA0OjUz4oCvUE0sIERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQo+IA0KPiBPbiBUaHUsIDIwMjQtMDctMTEgYXQgMDg6MjYgKzAxMDAsIERhdmlkIFdvb2Rob3Vz
ZSB3cm90ZToNCj4+IA0KPj4gSSB1c2VkIGlkZW50aWNhbCBjb21tYW5kIGxpbmVzIG9uIGJvdGgs
IGFuZCBvbiBlYWNoIGhvc3QgSSBnb3QgdGhlIHNhbWUNCj4+IHJlc3VsdCB3aXRoIGFsbCBvZiAn
LWNwdSBob3N0JywgJy1jcHUgRVBZQycgYW5kIC1jcHUgU2t5bGFrZS1TZXJ2ZXInLg0KPj4gSXQn
cyB0aGUgKmhvc3QqIHRoYXQgbWFrZXMgdGhlIGRpZmZlcmVuY2UsIG5vdCB0aGUgQ1BVSUQgcHJl
c2VudGVkIHRvDQo+PiB0aGUgZ3Vlc3QuDQo+IA0KPiBBY3R1YWxseS4uLiBpdCB0dXJucyBvdXQg
UUVNVSBpc24ndCByZWFsbHkgYWR2ZXJ0aXNpbmcgdGhlIENQVUlEIHdlIGFzaw0KPiBpdCB0by4g
TGVhZiB6ZXJvIHN0aWxsIGRvZXMgc2F5ICdBdXRoZW50aWNBTUQnIHZzLiBHZW51aW5lSW50ZWwn
DQo+IGFjY29yZGluZyB0byB0aGUgKmhvc3QqIGl0J3MgcnVubmluZyBvbiwgcmVnYXJkbGVzcyBv
ZiB0aGUgLWNwdSBvcHRpb24uDQo+IA0KdGhhdCB1bmRlcm1pbmVzIGFkdmVydGlzZWQgIGNwdSBt
b2RlbC4NCg0KPiBBbmQgaXQgaXMgaW5kZWVkICpqdXN0KiB0aGF0IHdoaWNoIHNlZW1zIHRvIHRy
aWdnZXIgdGhlIFdpbmRvd3MgYnVnLA0KPiBzZXR0aW5nIElSUTIgdG8gcG9pbnQgc29tZXdoZXJl
IGJvZ3VzOg0KPiANCj4gdnRkX2lyX3JlbWFwX21zaV9yZXEgYWRkciAweGZlZTAwMDA0IGRhdGEg
MHgwIHNpZCAweGZmZmYgZG9fZmF1bHQgMA0KPiB2dGRfaXJfcmVtYXBfbXNpIChhZGRyIDB4ZmVl
MDAwMDQsIGRhdGEgMHgwKSAtPiAoYWRkciAweGZlZTAwMDA0LCBkYXRhIDB4MCkNCj4ga3ZtX2ly
cWNoaXBfdXBkYXRlX21zaV9yb3V0ZSBVcGRhdGluZyBNU0kgcm91dGUgdmlycT0yDQo+IA0KPiBX
aGlsZSBpbiB0aGUgaGFwcHkgY2FzZSBpdCBkb2VzIHVzZSBhIHJlbWFwcGFibGUgZm9ybWF0IE1T
SSBtZXNzYWdlLg0KPiBOb3QgZGlyZWN0IHRvIHZlY3RvciAyMDkgb24gQ1BVMCBhcyBJIHNhaWQg
YmVmb3JlOyBJIHRoaW5rIHRoYXQncyBJUlRFDQo+IGVudHJ5ICMyMDkgd2hpY2ggbWFwcyB0byB2
ZWN0b3IgMjA5IG9uIENQVTEuDQo+IA0KPiB2dGRfaXJfcmVtYXBfbXNpX3JlcSBhZGRyIDB4ZmVl
MDAwMTAgZGF0YSAweGQxIHNpZCAweGZmZmYgZG9fZmF1bHQgMA0KPiB2dGRfaXJfaXJ0ZV9nZXQg
aW5kZXggMCBsb3cgMHgwIGhpZ2ggMHgxMDBkMTAwMDUNCj4gdnRkX2lyX3JlbWFwIGluZGV4IDAg
dHJpZ2dlciAwIHZlY3RvciAyMDkgZGVsaXZlciAwIGRlc3QgMHgxIG1vZGUgMQ0KPiB2dGRfaXJf
cmVtYXBfdHlwZSBJT0FQSUMNCj4gdnRkX2lyX3JlbWFwX21zaSAoYWRkciAweGZlZTAwMDEwLCBk
YXRhIDB4ZDEpIC0+IChhZGRyIDB4ZmVlMDEwMDQsIGRhdGEgMHg0MGQxKQ0KPiANCj4gU28gaXQg
bG9va3MgbGlrZSBXaW5kb3dzIGRvZXNuJ3QgYWN0dWFsbHkgY29wZSB3aXRoIEludGVsIElSUSBy
ZW1hcHBpbmcNCj4gd2hlbiBpdCBzZWVzIGFuZCBBTUQgQ1BVLCB3aGljaCBpcyBzdWJvcHRpbWFs
Lg0KPiANCk1ha2VzIHNlbnNlLg0KDQo+IFNvIHRvIHN1cHBvcnQgPjI1NSB2Q1BVcyBvbiBBTUQg
d2l0aG91dCBoYXZpbmcgdG8gYWxzbyBkbyAqRE1BKg0KPiB0cmFuc2xhdGlvbiwgZWl0aGVyIHdl
IG5lZWQgdG8gY29tZSB1cCB3aXRoIGEgdHJpY2sgbGlrZSB0aGUgIm5vDQo+IHN1cHBvcnRlZCBh
ZGRyZXNzIHdpZHRocyIgd2UgdXNlIGZvciBkbWEtdHJhbnNsYXRpb249b2ZmIG9uIEludGVsLCBv
cg0KPiB3ZSBzZWUgaWYgd2UgY2FuIHBlcnN1YWRlIFdpbmRvd3MgdG8gdXNlIHRoZSAxNS1iaXQg
TVNJIHN1cHBvcnQuDQo+IA0KPiANCj4gTG9va2luZyBhdCB0aGUgTGludXggZ3Vlc3Qgc3VwcG9y
dCwgaXQgc2VlbXMgdG8gbG9vayBqdXN0IGF0IHRoZSBIeXBlclYNCj4gQ1BVSUQgbGVhdmVzIDB4
NDAwMDAwODEgYW5kIDB4NDAwMDAwODIuIFFFTVUga25vd3Mgb2YgdGhvc2Ugb25seSBmb3INCj4g
U1lOREJHOyBTYW5kZXNoIGRvIHlvdSB3YW50IHRvIHRyeSBzZXR0aW5nIHRoZQ0KPiBIWVBFUlZf
VlNfUFJPUEVSVElFU19FQVhfRVhURU5ERURfSU9BUElDX1JURSBiaXQgdGhhdCBMaW51eCBsb29r
cyBmb3IsDQo+IGFuZCBzZWUgaG93IHRoYXQgYWZmZWN0cyBXaW5kb3dzIGd1ZXN0cyAod2l0aCBu
byBlbXVsYXRlZCBJT01NVSk/DQo+IA0KDQpTdXJlIEkgd291bGQgdHJ5IHRoYXQsIEkgd291bGQg
bmVlZCBzb21lIHJlYWRpbmcgdGltZSBob3dldmVyLg0KDQpSZWdhcmRzLA0KU2FuZGVzaA==

