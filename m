Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C4C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 09:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWus3-0004pr-J0; Thu, 25 Jul 2024 05:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWus0-0004ow-NE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:34:45 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWury-0003Wf-4a
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1721900081; x=1753436081;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iR8xqLXKFHJn0zbRYqXP/Tko8/a85X1O4tRDoYoWc74=;
 b=tgZMMS3KzZzT/x99koDf2B0TDILVIRGNGaUn6e/Y8VocytPbUmZools+
 BZIKKep2wHRIpVolHJRaafzucPOW5w5ZsLaqiXg3avS1h294okFSJpdo+
 7YiRFiLLXj3l+DECqM+zpY0g5YzB3fHU0KLPHrNdU6O/vQ3rnslIeL1PR
 U1bqALv/pJjfxU1qCV7UQ5f/Vl9pHLXMm8fh6d4SRnkYhPXV/CEDKQ0/O
 V47fXLqACRCHBxIOmdDRtdlQYoK5wBndfrcUO2BJ9Hh6NqLjDTKEH4CUC
 qBRH+DcLzREoxqViphaDxwnMLobhSWFSBSDgxhnqJxu405WqsD90kVBT6 w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="126999555"
X-IronPort-AV: E=Sophos;i="6.09,235,1716217200"; d="scan'208";a="126999555"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 18:34:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPxyrfcRUv9Ee+3+MDVihIu34HWqsxstCEdtVDSz01Sw+ZnTb6wIQczT0f4+mL9150vnpQaTcWq/iJ2DlZZwPTtKjxS0Ktt2s5A6miUOsnqZx78w2xQ6IU7bCJwg9hx/5MpfLhTi1+Atou5+lm5qxeSZHQeqyCLLHOf/wC7scWcKt2wjEumyeN2lVVOuTPgX2ZomaG572xr4zKS8FTV77PjtkoVfuZCvUDvLYPY+ts88eRGYfwVyUpyjE7arXkQMP2QIYIb/GDsC6LGreua8ZPPnC1tXqppQzLJX9nlb21B1S53eaSAO5JUOAJTUKnAMrBjgBM8K9MsEiTYmRd5luA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiXC+EQLQDPCGwo/CWBvCY2Q79h5qF6LjHKaFCAzrOc=;
 b=SliwEvpNrk184tbViZ6O/QAk35432USYF3+UelVFX7JjWakjj1Ji9YKA+mHMggz3cHBEiDXJtSJzXJUSGgoQ3V7m/PQmtQaIRI84LtNxPqr88zWIpMDFOIVNr1VHBeIN7hkwKWQlvyMAV9+BU5Lu2WLqMTO4/Dheuw7wlJI0+TPxKKWDuoN1tlmzFBTCskiXmMqk/Qes/3F4ykYFWhU3Tx6CdOepjGgFj2z+Z2O+cNENUrlqLEmvJzxvdhprIZUp43+JvBVh+Q3PgP9tIJqQ34a5N/JiZmvrMzlym56iQNFKpqiQgzRNsMxOqJn4EKxIldQAg80CthnFwg3Um4+fmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYWPR01MB10289.jpnprd01.prod.outlook.com (2603:1096:400:1d5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 09:34:32 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::9ef5:e83:9047:de11%4]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 09:34:32 +0000
To: Igor Mammedov <imammedo@redhat.com>, Yao Xingtao via
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Topic: [PATCH v3] pci-bridge: avoid linking a single downstream port
 more than once
Thread-Index: AQHa3kK6+6I9ozT3mUWcAkUVBpTpIrIHHuUAgAAPTzA=
Date: Thu, 25 Jul 2024 09:34:32 +0000
Message-ID: <OSZPR01MB64539D4F78972A069596279A8DAB2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240725032731.13032-1-yaoxt.fnst@fujitsu.com>
 <20240725103614.43875165@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240725103614.43875165@imammedo.users.ipa.redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=261acb35-f5ba-4663-bfdd-1af2f9b370a4;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-25T09:31:06Z;
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYWPR01MB10289:EE_
x-ms-office365-filtering-correlation-id: 9bd186fe-53f9-41b0-96e5-08dcac8cfd39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?iso-2022-jp?B?T1ZQTlQ5cmNacktWSyswaFBYK2oza1gvbXdseXY1Mm5HNzJERXZqTDBV?=
 =?iso-2022-jp?B?a3cwd2pMdjlZcUxrQmRRU05tbkhLT3FsVmtEcm44VUljUUtqM1NmeE84?=
 =?iso-2022-jp?B?VnQvYU1TelZIUzlGZmtDS0ZzUFpkelRFTmlHVjJvUkxGbyt1MmtjdzlI?=
 =?iso-2022-jp?B?SWcxUS9oQ3hLZXVINDZGZnE4NHFsbC8yZnZJdmVrbnFKTTFkTUNBaXZR?=
 =?iso-2022-jp?B?V3NiTFVvUm1tSkw4SFBDSkhHZDNkYlhuQVhLSlptMi9SOWQwRmZwRnhj?=
 =?iso-2022-jp?B?eGluQy9kMk1PTDVFTGtOMTVkRGU5dGlPOUkxNm5La2kzOGhoSHF0cFZC?=
 =?iso-2022-jp?B?VmVQa3M3NEhLcnN2d0E1ZlpSeklGaHcxSE5neE45Tyt1NnVOZjVOYUZw?=
 =?iso-2022-jp?B?RXFlSzVlNkxpN1lWSUpYOWhmbXJPend0OEtqVHRSeVRFSlNac2xpMG50?=
 =?iso-2022-jp?B?dU10K2lkdEswMXRmditQRnB1S09Od0JWa3VkODA1NnZpMm1CUHN3TmhP?=
 =?iso-2022-jp?B?Q2VxTkRDRFJHelp5QjNERWluOEh5RUpSTEJyOFBZK3lSVUVlNmFIOTBC?=
 =?iso-2022-jp?B?eHJoZElXMWNiQ25xZzNIZjR1ZnJMQXVIYkFaM2FPeWEwNGZmYTBSa3kw?=
 =?iso-2022-jp?B?YkoxUTQ4eW1tSW9ObytjclRaSXg1UGM3YzdNQ2lkMmRpNXVUd2toMXJG?=
 =?iso-2022-jp?B?bUUrSHJBb2VoSVlaWU1wZitTTDhPblJYYkVNK0cxRHJrQzEwcUVUNE1Y?=
 =?iso-2022-jp?B?TzE1Sy9URGRod3huZTQzbGlDc0hBU2pzZVhzUktPcFlReFVtZ1prZ0Zr?=
 =?iso-2022-jp?B?emVBYTl5RHNRbnZMemh0T3pZamp3akhqNFBvZTF0Y0pUazJZc29QVnhs?=
 =?iso-2022-jp?B?VGtkRWowaHZTVWVFSTRib3N4QlpKS2lnRFZqY1dzaXplK0p5NzE1ZUJY?=
 =?iso-2022-jp?B?eDZ0bkU2eHhTNlRjUXlFWWhCaFplWk1yaDZkREEyTmpVRFJ2RlhoOXph?=
 =?iso-2022-jp?B?bU9FYWJKY3dFQ2RPWnJ6eHdkK3h4SkNUeS9obmgvZ09MOS9UU1RiWXFu?=
 =?iso-2022-jp?B?MXI5VHdLTWtsakRMRjB5bG80NWlzNm5BbTg3OGFvWEtoeDM5M2JxeUpE?=
 =?iso-2022-jp?B?d01jN2lGUUY0bThxaERUVkxKcWh0OHBYTU1mWWl5VU00bVR5Uloxamcr?=
 =?iso-2022-jp?B?a2hlZC9rQnJtNXBreWwrT0ljbVRzTThCRUl2VVNjKzZmWk5EVkU2bVlP?=
 =?iso-2022-jp?B?RGpyM3E4L0Vhd0FDRmNFUDk4YWN6T25XdDBISml0V1JlNUFTbjIvTlJx?=
 =?iso-2022-jp?B?NHlyZTdSYnBuQkdrRzdvSUlzZE5HWTY3NTJJUE9uOVpyM2VzelROWEs5?=
 =?iso-2022-jp?B?NjdTRlFqT29UNEdVR3NIUlNXYjl4RjdaMXNVY01ocTB0Sm9NZkx6aFdZ?=
 =?iso-2022-jp?B?dVplbXZGRXdldUY3K1kydVhNTUh3TTUwdzNLaERDRlp4ODluVmFGTTZO?=
 =?iso-2022-jp?B?bERWYUJIb0RDSTZiQXVMMTFac3hRTWN5bXAyTThHKzdmQlFOQ1JGazEr?=
 =?iso-2022-jp?B?RHRUdGVhM0tBSkRadnVoMzg0RGhXbFNic2hzclhFV2w3dkM3Y3JTOWRL?=
 =?iso-2022-jp?B?dTA3RUc1OC96UGl4c2dLTGdoOWFlQ2ZQN2N1eGpRaitPcU00NU4vL0Mr?=
 =?iso-2022-jp?B?ZVZsa1l1RENDdFRiczBJODkvdk5FNFBleEpIN3U2aWdiWEs4b2trNTB4?=
 =?iso-2022-jp?B?cXdGdEJJUHF5TXFua3VrTERiWTRreUZXeGJ3TDZjc3ZuM2NtK0NQVVNL?=
 =?iso-2022-jp?B?V0xpckZkWVhjblh3elNQRXBjNE9VbU95NVZrRUw0NTdUVC90SzJzRXFU?=
 =?iso-2022-jp?B?NkhyZzFuek04STRpZzZJejl4S0hmWVB5YjdXd1JZTGgxbjhTR25jRDJk?=
 =?iso-2022-jp?B?aVJWdGY0VjFrSENsWFROWExwWGQvZXhSOGdlbFJlLzJVUkRENmpGVVRx?=
 =?iso-2022-jp?B?V3cybzRxOWJvOWljSklvWUN6Q3h4Vg==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZzZZNGJCWjhaSHM5S2REbTVLckxYbmFpVUMrTWh0NkRsOGxmd3YyclJo?=
 =?iso-2022-jp?B?d3dybG5CRG1LSHhHcXBQaDFMMEoyQzNZVlRMWjFtT1paVFB4b1U1am84?=
 =?iso-2022-jp?B?R0JjOUJ5YzM4ZWZZamFIMkUyNzZmakUxYmhMRTZ6UGpTL0gzalZNUUJS?=
 =?iso-2022-jp?B?cnNuR1hwbkFiOU1YakVMUmhwU3NoYkk1eUsxUmx6MG5QZWU0VnVHamhW?=
 =?iso-2022-jp?B?S29hRi9qMFYxekE3SlRoMU1XeFVYbHpKWUVMcVNuODFreFQ3UjNrRy9M?=
 =?iso-2022-jp?B?L2RQSG9JT0VVNEcwNXVWRmtBOFh5ZDRRSGdrSE9icno0enFUKzNaMXNY?=
 =?iso-2022-jp?B?RkpnL1UvTElqK0F2U29MOHdtZWFYaGsydmVYSUcybnlpR01wWkVWaWVL?=
 =?iso-2022-jp?B?NTBYZFBwdFhTQXdzbDVhRXRuUmQxeXJPQ1RpNUJsNTAwNGc5WmZOQzBH?=
 =?iso-2022-jp?B?cVZRY3NIY0NMbnlGQjFXOUpOWGVia2VML1dMdCsxUVl1ZjBoL25rdm1F?=
 =?iso-2022-jp?B?SjZFZnh2WndxNHpQSUdWZlZPSE1ISkRnTFRMRklCN0x1Nlo1djk4MkJo?=
 =?iso-2022-jp?B?emx5UXZCcFFYQ01RbEdqeTJQY3pIdHFId2JkSEc0MjR1d2UrWlJBTURx?=
 =?iso-2022-jp?B?R2xkQlBDR1FsQ1UwazlzRlZOVHg0c2orT0JWNUJLQjNrRUM0Y29OaXZv?=
 =?iso-2022-jp?B?Zjg2MEZBeENaMjUvMzBwQTc2Vnc2TGtqQi9QVnhSVnBXQWV1YlltUmhV?=
 =?iso-2022-jp?B?UnlhTFBHc2diUWg0NWlVT204NHJ5SDhhU2t6UnEvUFV3N0x0SkR5dzNw?=
 =?iso-2022-jp?B?T29ZbFBzcE5WalJVWnhDbVIxdjAvT3dPVVJYQ3dKZndzRWtpN0tzMjNE?=
 =?iso-2022-jp?B?L2hlN1VmNDlCaW9sZk9wNjdiSjJtZExZUWVWOUR6cDVHNHJtNUZ1cHEw?=
 =?iso-2022-jp?B?UURyK1JFMFJvLzRObVJ5NFlqM3FPRm5XWUc5UUZiRE1HR0lrU3o2dHVu?=
 =?iso-2022-jp?B?czhuVVRhOEt5SjlqTXhlYVVzVVNudmhZTWFpSnBXVHdTVGh3VEM4Yy9n?=
 =?iso-2022-jp?B?cGxhNUswYXZhZHRGU3JKMDJzSW5aTVNqL0QxOWt1NU1KR2dUU2Z4bWZM?=
 =?iso-2022-jp?B?OHovODJYWlV4RFF1a3p0MVdWREtFWjNWK1VCTkZ3SnB5THBWVlhMNW10?=
 =?iso-2022-jp?B?U00ydVJ3WTB1QmZGUk96cm1Ga3dvVjIrMDkvY2J1QVFKRkxNM0J4ZE9h?=
 =?iso-2022-jp?B?dUdibWV6MzFOVWp2alQ0ZGlWcytQM0FSekhKMy9rVWZEQTI4YU5kZldS?=
 =?iso-2022-jp?B?c1hQaW9PcTU3VEJpaU9Jc2JyWXBHMkFDbU1VVm0yUGhkNStZbFNRd0U0?=
 =?iso-2022-jp?B?NGhVZEg4MzRiNmM3S2E0YitGajh4SXZEM3g3RlpxZ3dZWW1EUm9DVTBS?=
 =?iso-2022-jp?B?UTlCWE9QdmFIbFU3Z1pVTTF4RlUzSzQ1U1pwT2g0enFpZDhYY1R6cXBn?=
 =?iso-2022-jp?B?dHVBaFBTNzRyRkxCS2tNMS9lV29nUVltN1FMa09BYUNZbnpwK3FDZkdZ?=
 =?iso-2022-jp?B?RTUzdUh4Q3pVUS83WDBSNFhNUUEwYmNkYk94MTh0ckk1aldLenhDQWlx?=
 =?iso-2022-jp?B?NGZPclYybVZkODJQN09LN1lQM2VPZnV1aXVGNzNWNWZWN3ZxRUppUUpo?=
 =?iso-2022-jp?B?eWNhdW9PTEJQM2NwbGxBRVJxeXlmcWNTdm94dXRuamcxbm42ZjlEYkhs?=
 =?iso-2022-jp?B?V3lwaktrN21JMG52NnI5YWF6czJnaW9NR0VyR09XdlAyMDBkU2phWmRM?=
 =?iso-2022-jp?B?SzFIZmJxVTlXaU5FZVpwTnErQjZTMGozdGdQdHZxVjFqVUxHTHB2RWhH?=
 =?iso-2022-jp?B?cklkZFNHdDBnRk43bHVGVGFOaHIycW81Mm1aaWJ0SG5ZeWNlZE9ONzho?=
 =?iso-2022-jp?B?OGxQRUo1bllRQlRjRjlCamlpMXF2VFZlQjhGZ1ZldzY5eENkbVQ1NC9P?=
 =?iso-2022-jp?B?MjRML1dsVUdlNGJhYUIreW9iR2x5bmZMM29BQzlFK0R0anp4aFY2dXFM?=
 =?iso-2022-jp?B?akQ0bEgzVUVqUVZjVEJZaTE4YU5ZTTZMZ0F3K2hQSjFkSXNMZzBOdzBj?=
 =?iso-2022-jp?B?U29mUWJQZ3l5UUMwSkF0LzNvK2dqZmlvQXkyUFo3UnNGNEdRQnZqL2N6?=
 =?iso-2022-jp?B?THVQU1JFbGsvSUtoak5VckNNNysrMUJZR01DWGtLZjRYVGJ3enBvcU5E?=
 =?iso-2022-jp?B?U3JQUTVoUEEvNkZ5anJiNEVuZXJKUFFIMGdtanJLVVI5N3BmZVFibk1w?=
 =?iso-2022-jp?B?RVUxOA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YypwPlCTQJj6eG46rg3dbUXerKQj5RCpH8ehjLrs9rHHDRPX4O9cvwPw+jknfwhIIpHlOASk3z0En6nlhTOy1puafovlI9/eBhfPyvbNChjETEACRholIWeQ9rBFPs9YRvpjvWFYFMzx7VwGmgl4ppU65yscDQS9v95PFedWFPZk2mNv3HK3IhjiYhXkySs+ByqWEHhO2EgUTLIUWRyC4OiqJyGuUs3GHbYTctqO38lTmNki4mXQPUFY6GKL29x+/0kpWT+8he7no2zfLnojMYDy0G09VCa8TNnac1BZKLV6Zoi2ZHY6YNt7nWWgTZiNZoz7Mzy6DEVxa4bFdJ0M0BNvPZ3Oc1iF5io1+L7vPa0iR5eSYn4mkQoRVrzLPfkEWI05RhlMcDGtCg4WwDBMvi7Iq2p8DaFfr9NHTdUqviiacQtBSxA6wUAIyib5dAUVxFvTUR30Jt4Yt/HC5kc0n94NmFuwi6cg84JGfJSwWF0BI5rBSw+YI0ncwzTCZcjQrUEpU5IDstd/cfmzuD19Cydhc8vIoln5/l75ie50q4k9q3CMzjsa0e73Nn4QIfs/1kMGv7abv+VyQaS/GHwQDPTFRVJcMu5lGcU72T4RsDGfr9cShTxz8Wil3QbLntho
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd186fe-53f9-41b0-96e5-08dcac8cfd39
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 09:34:32.3050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4Xtbffc4733E/feUTFPZHzSznM16FTarg6/gvfAaVdJI+yY3FckMSJf9vVDkrEPTrvIcwz+YGfcXXb2vRsfdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10289
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
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
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Thursday, July 25, 2024 4:36 PM
> To: Yao Xingtao via <qemu-devel@nongnu.org>
> Cc: Yao, Xingtao/=1B$BU-=1B(B =1B$B9,Es=1B(B <yaoxt.fnst@fujitsu.com>; ms=
t@redhat.com;
> marcel.apfelbaum@gmail.com
> Subject: Re: [PATCH v3] pci-bridge: avoid linking a single downstream por=
t more
> than once
>=20
> On Wed, 24 Jul 2024 23:27:31 -0400
> Yao Xingtao via <qemu-devel@nongnu.org> wrote:
>=20
> > Since the downstream port is not checked, two slots can be linked to
> > a single port. However, this can prevent the driver from detecting the
> > device properly.
> >
> > It is necessary to ensure that a downstream port is not linked more tha=
n
> > once.
> >
> > Links:
> https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8D
> DC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> >
> > ---
> > V2[2] -> V3:
> >  - Move this check into pcie_cap_init()
> >
> > V1[1] -> V2:
> >  - Move downstream port check forward
> >
> > [1]
> https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujit=
su.co
> m
> > [2]
> https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fuji=
tsu.c
> om
> > ---
> >  hw/pci/pcie.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 4b2f0805c6e0..aa154ec4b054 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> >
> >      assert(pci_is_express(dev));
> >
> > +    if (pci_is_express_downstream_port(dev) &&
sorry, this check will not be valid since the dev->exp.exp_cap was not set.
I will fix this bug in next revision.

> > +        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
> > +        pos =3D -EBUSY;
> > +        error_setg(errp, "Can't link port, error %d", pos);
> perhaps, also mention what's wrong and suggest user how to fix mis-config=
uration
Thanks, will append in next revision.
>=20
> > +        return pos;
> > +    }
> > +
> >      pos =3D pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
> >                               PCI_EXP_VER2_SIZEOF, errp);
> >      if (pos < 0) {


