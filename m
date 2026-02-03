Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9B4E87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIe6-0007BX-9S; Tue, 03 Feb 2026 10:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIe3-000794-GI
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:48:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIe1-0002Bj-76
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:48:50 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613FjCmX191251; Tue, 3 Feb 2026 07:48:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zq1defwBAwS0WOSaqwKuZiFGEh0lqSeCVq4VZRijT
 uw=; b=tzbij6l4vmsnlavW4h0afG8H30Am5gMO2124XRfjat5U80Zt8GxVrcyIs
 cWJb3vl1XFmCVtiqZ12WxBdRvqwHV+Vq5wtwgE/Ugd2XmiAizMBt78AMQxvgs3uJ
 wpANdy6keEwq4n4tY8luU7j5fQyV0RUWM6XcISyovCCHiY1Ga6wrV8uVZkq+fro4
 LExnX2BIJ3I43/Waup7QE5JNMGverkLMGY3eRHpsp1xGkqhLU6ih3mX5ZR0Mh6iI
 FEpe5AeGFC8MEWUjsArG1c4/PT+pMoJLdCU3HDmOv2emC3WGwA5MyXGkfVo2WL85
 j0OewbqGe6qFZ9xOzOxcoaEt5IxHA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023142.outbound.protection.outlook.com
 [40.107.201.142])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1hxdf2a1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 07:48:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAldG8natVEb3JO44QZt0vVDu8xHT9IMdINlJQX9XhaykUelujln9h8rjq7VacUYBNWJIddq4dbFu5JAcpa+gKH3iUatgBWRbwzdW4TDA3D+7F/p3whk0Zf+3Dx3zQfMKsIp6jkphw3UBUjupUaotDIne6SqPfvvokvYvOV3BmIl/aVobQL02ZigHhtQ7AOkM16l3eQ5OsQPt0paHrPKmXGYfqXgkgQ6IV3MKDOuHaqio64itq/td/XPA+Mw6uxyUc3SS6MCtoL1wLq2QsF6TjeJ2Fq9EP7IK8ayfc08Uw1FlIkwuAQRapRWm6UNeSWDFiCF4RNdg17nFUrZR9rVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq1defwBAwS0WOSaqwKuZiFGEh0lqSeCVq4VZRijTuw=;
 b=AjpRL78dKMM+2Bc/yl81UOFuf/GH/6H5ViF/WceEI/WNktREaSLVayIM8IYI8cEu4PJT4ytNZx5PaKP+LiL6RPeYLaP8UBfSIGAgmJzdxcjS/KozgEOk3RDzSIyduRZhKhGqcCYD9aEeB7VlVgvSwIeZftFwNWP3BM+RPn0aR1qbcACjg977DFg7U7rtqopDyyp1S/KMkhZebv1zE3MBJLwhXDEPcJVicsYOeo/TAgdZyvM3IrH3YadvqVInyYM5lnoSQa8KO8MemCuaAOcU0SFadQUotiIuDo7al8wrF7p+lVFWn/+HcdcP+/Fk28RKVe9wVRJlSYTEOnecBhrezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq1defwBAwS0WOSaqwKuZiFGEh0lqSeCVq4VZRijTuw=;
 b=TYhIAeJz4ACDbTwe01Su24bSCfTIEGWmaQAxPNN6O/GQ+RAMr8eBmSJMiXJNW0sWz7sNrjRvUDbDI6xHEmctBsvsJnY/zARIbdcwGc5OYAlfnNoMXND9WuPWT/OPGaJDZj/0YG/ucXk7MaKf9FM44Mz1ZShS3k+bSwNbMcRhHCwLQFxKs1NV+KPQrYUI1rOTIV9WNZ3hs2ekV4ilD6dOZt5edpH2XCLT9rjYpGXmZav5UGIJN6NSuKK8DLDChUjVhkq7ePpH0xZ1z7OpFuh2w1QyMVsQs2omRgctJZZ0OgmTkQO+sVlE+8p7I2WqFroOux8ZOlyOB2eKd0RKAKdAFg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6794.namprd02.prod.outlook.com (2603:10b6:5:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:48:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 15:48:44 +0000
Message-ID: <b28fd63e-063c-41d3-a9dc-54929e7adfaa@nutanix.com>
Date: Tue, 3 Feb 2026 15:48:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] qemu-options.hx: clarify default audio backend
 selection
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-6-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 893b74e4-fc52-4416-969e-08de633bb662
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkZCNG5lRHdMLzlxSTI3WE12UE9DTWdFay9aUnN3SGVlejRwc0VpWDRUc2s0?=
 =?utf-8?B?dHhMWnltbVBIaDIxeks1VmM2MGpVdE1VYWpJVDFFWVY0aGcra1NhS0FTSnpy?=
 =?utf-8?B?Uk4xaTFVRnJUcEVLMjZnbHgyRzFud25tYmRmL1hSdFFseWVkUTJvTGk4YzFy?=
 =?utf-8?B?WnJwUXUrV3IrVzltK1Uya0R4MlRHNFVQZnNHb1BoRVI2a1B4c1JDbmg4cUVV?=
 =?utf-8?B?a1E4WUFtR0dIajRhNm5zdUYydzE4cUpSYm0xNmcrUk5JakVGU0d0T3RPVnNr?=
 =?utf-8?B?OXQyNldsYTMrNGtTeU5tZ0FOVk1reVJ1V3VqSUxRL3M2eUsrSitzNFNsVHpN?=
 =?utf-8?B?VFNPSU1rZHJvWUdRRmV2V2M3dG05eU5ZRHVuQUpGMERTc0h1ekZiVHpjejJO?=
 =?utf-8?B?Y09qTDhINkJHb1orTlp0cXUwRjl0V0dMZzA5NHlvb1ZZRklFQXA1S0ZsYjZ3?=
 =?utf-8?B?VXd2WlVoSkZ3K0hnTWRwaE9MRVh3aFF3UWhyMHQ3R2lOcENDb2RKNDBwUjZN?=
 =?utf-8?B?V1UycUo3ZlRDeHVoSmhmWG13NGF0WklkZktXSW1zaTVESFd6UmliamRmSkF2?=
 =?utf-8?B?b0kwRXYxL2hSS2tjNWQvanVCSHVEU3BSQXdLN3l5ZzgzNnVCaEJ1VjRJdlIr?=
 =?utf-8?B?V3FLeGNldXdWYTVQd0dSdUM3UTBreFV4dnpPODV2R0FESXlFMUhJMVRJMERy?=
 =?utf-8?B?SzliKzA2RXNiTFBhcW5iS3oreHFmQnlJaVhyc2pobndhZ0QwQi96Z1lCQUFv?=
 =?utf-8?B?Yk9xQmtlTXNmdkFUWmh2dWRqZWZLdEtJRmJlWlV1bWtXMDlXWDZiZG1FeUNa?=
 =?utf-8?B?VGU4MDY1MzdHeVQvMTJiSTBYVWlYdUxnZ2VMc3JXQUZBZ2lKcFlUMC9Sa2t6?=
 =?utf-8?B?VE83ZE0xUmhmYVl0Q3c3bmNwUWl4akk4MXFvYVIrRHRxdE9EZlpWWHN1UzYy?=
 =?utf-8?B?Y0VCWVJraXNNbmZHUmd3S2FVSFZGOXNxUmt1cDJXOElkeVhvb3ZERCtCQVUx?=
 =?utf-8?B?T1ppN2lJS3p1MUh2eisxYzErWU55T09Wd0QvYWNBOFF2Qm4rNXI3UHBFN2Nu?=
 =?utf-8?B?U3lZYWlXVEc2UGUrbzdXRHcrbEZtVjlUQ0ltL0NGNEloNWhMQUx5STZnMyt3?=
 =?utf-8?B?bjBaQ0JTWWlreUZYQzcyWlhwU1lTOCtKZnVSVWxVRE9DUUVqQkVwS204VUFL?=
 =?utf-8?B?QVRQakpVN1dkMmIyanBkMTJEM2puMFVwZTZlUnk2RVNlVnAvZk91Mk40Nkkv?=
 =?utf-8?B?eXNPai9SZWtybU5JQklhYzBpTlg5UklzT1ZmbTFGbUhLREVoeUpMNjBMbis2?=
 =?utf-8?B?bEV5dlJMTk1wZHBhdVNMZVB6RFFzcDIwK1hhTXovZ1BhbDEzV0pvVE5hMWht?=
 =?utf-8?B?ai9rdHhKT3ZtQm1OdlJ4R3dtajE3T21zNzUybGJYVEk2YWRYbWtxQTdWVUxa?=
 =?utf-8?B?aUlLcjRPNTVvek9pSkhac2tldXhleXBseTQ3NUdialVRSndlQ1JkL0R1bFNr?=
 =?utf-8?B?Z0hKNlhlekpoNzhMS0VJRllqYW9kOTNqOG92dXRLV0I4REIxZFZOVjdwaVE0?=
 =?utf-8?B?NngwMndTbmVWcGcxTGd1RkhoQmw4Zk4zdHJqSi9BN0kzYU5MeVNWR1JGUkJn?=
 =?utf-8?B?dHI4ZHVzUlJVQ2VuZkRkcTRHYTh4VGo2TzRyKzJwZWZ3ZTZzOHFvOXhVa0Vo?=
 =?utf-8?B?MlVaRTQ0ODRiMG83ZVFQZzZPYmk4WFVXQkVQMWhKK2lWQTFEd3Iwd0pkSDhl?=
 =?utf-8?B?WlNYQVJJMFFIN1RJSVJsSnRuQWE2M3lRU2NVNk5Gc2NkSlNZSTlQckk2TElm?=
 =?utf-8?B?MENHTUF6ZGh3VEtDS2N4VE1DdjdGcVQ5aVJEY3dBZ1hDWWtleE5vUTcySU5E?=
 =?utf-8?B?UDQ3Ym9kbVQzMG5qTnlPczJtUjAyM0dsNWFDdmpaU2JWNkpEdEx3Q3B5WHVN?=
 =?utf-8?B?alZYK3Rtc3h4TnE5QmZIeVEreXBYSXBDbVRxekpUUENGb0IzS2NKNHRMK0ND?=
 =?utf-8?B?NTBWVE1ZSUZqNEpSRk1lR1ViK3JxcDROb3QxT3J2TEVTdEZCd0I2L0NHQVAz?=
 =?utf-8?B?L2k4NzJwaUFqQ1ZvekFOelRYQm5FS1dVcTFteU5rUmJpaVVpdG9jbUZQUjJa?=
 =?utf-8?Q?RvLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3d6SkNWVUxsNysrMG9ucVBrN2NRd1NlSmwrL00yZHcxZVRqVUsreDhwT3R1?=
 =?utf-8?B?TWt1OHpEd3Z3UUM4Y1hUeFF3YlhrRXBKS1BVZFdEaVc5VVBiLzRqQXN6eE8z?=
 =?utf-8?B?UTZFTk9HZ0F4SVNFWnJyZjVKdFl4bVdnQlRlUUh0bjkrZ2RNNWlMSnc0YlVU?=
 =?utf-8?B?Q043a0NqQ282QjFUWWJ4R0FEK2c0eWVEbC8xMzFCZjZHYjBsSUJsaGQ2WXFG?=
 =?utf-8?B?Szg0a1FsNzZpeWgyQ3dNN3liMTFuMjV2RityenhCa3BmbTBSaUxJenNYNG9p?=
 =?utf-8?B?UWFSMnQ5WlUyTlUxK0JiWDIrRmZXOEdnd2FHeE9rNFBVVjRPNno0VXNnZnoz?=
 =?utf-8?B?TDFNdHNsaWZFTDgwZlA5Y2hRakwrMW5ienVUUGhkQVNyNUxpdjNOMEppZjZY?=
 =?utf-8?B?Vm1CSXkvY1ZPcWRqRXQ5UUN6L200V1NDQmcydnp0T2NydDRRb2M0eUt5b3di?=
 =?utf-8?B?TlQrS2twRFhOeGxLNUx1NDk0SDE2b1ByaVo0WldHWmVmdytaQVhGaXlGK2Vq?=
 =?utf-8?B?RDFFUW8rbmJZSFhmTzVidmtHdVg5VVBFUFBxVloxdVhIYnRkKzd3UFBHQ1hn?=
 =?utf-8?B?T0RyTmpPSVFad0JSOUVZSndSa0doYlB1TW4yWFMraUdXUzBWRmpwY0R3QWJM?=
 =?utf-8?B?cXlSUUorVitmcGx0R0ltTHhSR3VpTWtKc1h1eFh4RWtHeFZCb0pnamZVSzlU?=
 =?utf-8?B?UFdwbHdqcHpKTWxpNDUyTnFXTk9WbEEzSnZFNWxkZjRhK2dxTmhzbFFWZmtC?=
 =?utf-8?B?aTZrSlNkVjFKTFVYU24wS1Ftam50Sk13SCsxSDFRRFRicVNjTGI0Si95WS9r?=
 =?utf-8?B?MENPRGpGeTVJclpoWmNLMlp6QlFnNytpeVM5RGZ0QzBOMzY0cVR4dFdiSHhD?=
 =?utf-8?B?MHZXQUpDQnBwQVFvblJXM3VVNnk3L1c2MlNCTWZMbHdxbUUyMVdoT1JabnM3?=
 =?utf-8?B?VTlVQlJ2eVhiR3U5ODNaNjhUVTVhaWhMeFNWcC9neWtDbmVzMmRNc1Fmckdj?=
 =?utf-8?B?TjZicDZwV2lHTjVmYmc3bElEN3JxNUNCNnNJdTBFTXpjT1BSaDdjeFNYQmw4?=
 =?utf-8?B?SGk0Y0pGN0lFeXRwVGs3TldSMVRaU2hVVVdlQ1pDWVBORC90S2VNZ1NXYWcz?=
 =?utf-8?B?ZUtacHFTS08wYlNoYUdCVG5BUllMaTc1OHNJQ2htOTNodjdBay84Vk1Scjl4?=
 =?utf-8?B?S3czUVJYRVlMS01lOEdWN2ljYnFSTmV3VksvcXpxVDMvdXpueTFrWWgyL2xv?=
 =?utf-8?B?NFcvbXpjSlFUeGFyZURicG9tSDQrc1RFM2cyRFlpYUtYcDZaZmhHaDkweUVI?=
 =?utf-8?B?NFVtY2ZOWjlweEorQ1dHOERVQXBJYkIveHl0TTQweUNMTmZ6YW9NWm1RY2Fs?=
 =?utf-8?B?NjF4MDFnRUN6YWZlTlhaSDlaWFd0aWNhRTlNc25XSU1NektzaWtzQllJam9w?=
 =?utf-8?B?eGhRblFBWjZuWWlhME5YQVJ5MEVhQmNYU1FKNUEzaUNpWmJ0dUV5Yk00SXUy?=
 =?utf-8?B?aDlmVmlxR3Z3NUZrdlBYVVAxdG1jSEpTTFIyOHF1U0UzOWt1NmZPSWJaRFJX?=
 =?utf-8?B?Sk9kdEhvZHplZmlqaEpFT1E0Z0d4Q0RXdlVJVVcrcUJXb1k5YWIvbXRTeVBw?=
 =?utf-8?B?RUE2Y3hGTCtBTXdzUXZnZUhPNTBpb3ZBMFlEUGRUZ1J0VXpRbk83N2s5YlNy?=
 =?utf-8?B?Tkt0cGh6U0xtcWE2V2ZQYnlPQ2tqUmZhSWNTN2prU2tVRWIzMDVvWE01T2dz?=
 =?utf-8?B?ZkJwRUdGNFh2d0ZUMHg3TGF3cWFMcm5UUmlXQ3kyazJOenpEaXQwZmJpRmxP?=
 =?utf-8?B?bnlPWkVqbjZHcEo0ZFNWbTAyK2ZDRzY4VGhtdGxYd2srR1Zjam5iN1dUeFVU?=
 =?utf-8?B?amp1eXRrTWJiS3o2SWtsSlpZUzRNdzdQSGgwNGcxbmJWTkxNVjUxV1p4eEE4?=
 =?utf-8?B?R1ZWOEdVekN6MGlLNWdUTUhJUVpodlUvOVBBYktBcldyWWJFK3ZHeFhab1Rv?=
 =?utf-8?B?bWlKT3JUeFBiaVdNTGkvZXlkR2ZtY2pDZEFqaUZKMEFMMHVUNDNPTGEyalZ0?=
 =?utf-8?B?ckJ5NkJYMSt0b2NCbXFvYUNaSVczTkJqR1VueWZNa251Vmp2cmhwd01HeHRS?=
 =?utf-8?B?VEtGVWpaWTJuVDB6aEdXSEtQREtvZk9LMVRGWGhPVDVzMjg2QUR5bUllYTFE?=
 =?utf-8?B?TWxaQzJVb1owTVRRaFJMVmpwVlFZU1VtNHhlTVg1ejBYSkVxZnZEdEFFdG03?=
 =?utf-8?B?Vk1jMzBDRTRLZDRIbTJ3cWFlWG8ybFpBejMwUEdybUZTNnlHUEFZWnhmOE1T?=
 =?utf-8?B?TDFpRDBISk52S29DcHJ1cGY0NFZ2M0ppUi82Z2EwbVcraXQyZ29IajVoZERW?=
 =?utf-8?Q?A95v4vAOlWU71/jE=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893b74e4-fc52-4416-969e-08de633bb662
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:48:44.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dgi3N8VVXjyUgpqNM8qDqjZS9ViB/shDmnByN1+SwCfg++Uh1XKYNmDi8xmTV2V1QVDquhBUzbORVBReb4/rjVgGlr+edscYiG32RDkFKq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
X-Authority-Analysis: v=2.4 cv=J4inLQnS c=1 sm=1 tr=0 ts=698218de cx=c_pps
 a=nzP3m+/CqRdBhj8fzGTHBQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=cEo3GkVnLjV8wW4lT9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t8AIdsVs54WHNJZAyTFs5YeX8wNCW5JA
X-Proofpoint-GUID: t8AIdsVs54WHNJZAyTFs5YeX8wNCW5JA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyNSBTYWx0ZWRfX0MD0cRQT0/YL
 D0no71Yp3DuyOjH8yAqAwYQl+Jv3kayOFgrvd6FVz/2MJAtmtd/0YICTT0SPWYD0DD20D5S4c+T
 DOBHd8oIFH7/+2v1qc7B8RHLlcFISTSHW87yH6oQDjyggTd+GydKUu/AMqw/4LRcGnRDu1BKxAs
 SRWx0BVy6gPfdjNOIuiEz73jSaSdgKtt+7bqup5iay3klM1OQkXkz4oT8ifLOhklojhChyQfB2y
 Ajnu/kNJrkMlyRKoEt/1jRHw9T3nlJbticmZEGH93nagbDgeulvB0uZ7MG1L0YlGZY/m/G8Edx9
 oq1jmaJs64e1g1Ebhalta18e3NNamy8PULhzk9cMCwTNNDl9djA8l9559FgYNhmvvTKXO2Mzd2S
 E0eT1N7jYqP4mnMLzVKJaCzzcDDAEjnM2tQxP+G//e0V+GMg1V5pgHOXiesUzXrFjzrOfkndnr5
 WquAjn/umflj95JGvJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   qemu-options.hx | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 455b8be8903..732934a6fa8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>       QEMU_ARCH_ALL)
>   SRST
>   ``-audiodev [driver=]driver,id=id[,prop[=value][,...]]``
> -    Adds a new audio backend driver identified by id. There are global
> -    and driver specific properties. Some values can be set differently
> -    for input and output, they're marked with ``in|out.``. You can set
> -    the input's property with ``in.prop`` and the output's property with
> -    ``out.prop``. For example:
> +    Adds a new audio backend driver identified by id.
> +
> +    If no audio backend is specified, QEMU will attempt to select a
> +    default one. The ``-display`` option may influence which backend is
> +    selected.
> +
> +    There are global and driver specific properties. Some values can be
> +    set differently for input and output, they're marked with ``in|out.``.
> +    You can set the input's property with ``in.prop`` and the output's
> +    property with ``out.prop``. For example:
>   
>       ::
>   
> @@ -2172,8 +2177,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
>       , QEMU_ARCH_ALL)
>   SRST
>   ``-display type``
> -    Select type of display to use. Use ``-display help`` to list the available
> -    display types. Valid values for type are
> +    Select type of display to use. This may also influence the default
> +    audio backend selection.
> +
> +    Use ``-display help`` to list the available display types. Valid values
> +    for type are
>   
>       ``spice-app[,gl=on|off]``
>           Start QEMU as a Spice server and launch the default Spice client

The documentation changes look fine in terms of describing how one 
option may influence the other, however there is no explicit mention in 
the documentation that selecting a dbus display with no audio backend 
will also use dbus for audio.

Is it possible to mention this somewhere? Otherwise someone would have 
to go digging through the code to figure this out.


ATB,

Mark.


