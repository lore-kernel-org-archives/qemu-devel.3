Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BA6FEE4F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 18:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwP6w-0001M6-Ms; Sat, 28 Feb 2026 13:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vwP6u-0001Kh-Jy
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:32:16 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vwP6s-0005Ab-9v
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:32:16 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61SGmHGg3463092; Sat, 28 Feb 2026 10:32:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4MQT4G8PheAlFVvLyBXdDjzNatEbF0Wsmba+9rPp9
 EU=; b=a1wSNG2xDO/FsKNEroWl8wRDgBd/uaEj97lIsLbpFJ6uEFkbf5TFMmwv4
 dZ0x5Z++oGbFaZhtmlQJacnz86d3V1gzgIlptW0aTW/hvG+Ii25dPH0gaqXufJhF
 rB69/8yRQmtDTuuVWPFoQHeVMbAuxJxWJjTenDczBQKZNgh61YPM6njWHH9/wC0S
 7A0h0309rYWYvu7BhBMYxB4md4WUhn22Ttmp9ARdzdEOGtwhY6T6cupUdbqbVyo+
 PQm5ClfvkMSCI1D2dPjLtM+4WAqFHNsAn4D4Dwu85qeY9IhpW7xN6hFzp/yZmz/h
 rnWcrtsWTb6ue0D8bitGPAKv6oWGw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021094.outbound.protection.outlook.com [52.101.52.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cm0ag8c8d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 10:32:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrKTN6oAzjpWZKz4cYTG5Hw3cQrLHJWv1XaCJGVWDpuRSCWcZMbZTQO+0djd/FIsQD97fbZAzEus5XYZyEWa9Ij5hwzGFthILcpq+q8VCdLWj5dGKDBgClTCDR1toAf43EWTr1TFfKJmP7tjOt4qONuc4++essRMTZIU/hX41fYs7Bd2J8OF0grKKNi2ei7LMvkE5heFaQEsb0xhXI9ZNSZmTvj+otHX3pvcVweDqyKr6PWfGoWPDSqr+TNmqzOJ5Xy+5HJKQ9h0fqRO85pXW1XQeSxJm8Q5AZ2qb3It9j1pp7BzoC3Q2yNG/njVt967TZKqns7L7Zk/I72mJ4yq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MQT4G8PheAlFVvLyBXdDjzNatEbF0Wsmba+9rPp9EU=;
 b=oj/FxGiuuXac4Hxf/832PlTkM3mBNy1VDaCHzqe2IEWXj2e4BeYvOTM/HioAvCeaohbvGyyNUotxApqUUgw83U8GI0uKuCbImKPl9j1E7+0SmKVSdHneMHNcCCdYtJLebz8rRWSRqkIc7Qeg4Z/Q+S+jk48+eE7WVnaWbYrEL0Qy7IwVyLW+2U5nDYYYVi2G1s5t2QcF7J7NIaxBdVfk2SVMMiOzyifcGNus/CERnQpsQRE0vyPgLu8WDejFS9lFuuWHOcSLAYkEaCADGN5vgfz5AzZSFTbb/jeHkGy98xgchnDt4k3Xq/DAEJ9jK+wstjUTYwc6EH7TSBDKuUAIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MQT4G8PheAlFVvLyBXdDjzNatEbF0Wsmba+9rPp9EU=;
 b=fmLEQ1mVNSxkGwvYMMEV3n/j/ip1Ky6hrKvBbKu0NndWsVASOOgeixDbPQHtuUKibPmCxNlVvJLy9IyVLT9uwe6SVvqxVBmhDPPxyLVr9NW1klSpPR89Ixl+nEn5ejsOA5off7COQzXWRyB5oyRpQuBvcewkbDhCsYPWXjdEKNXhdhMsPCqvFYZQfzxB18LxQD+3UyPTTC8h0Gy1dJI1/OaXnRD38NurxpXrnn8+XqahSEkw/LML1qXu2da3mSD8pTyQqgfUwL5hOHzti6AsTWsAkLxywexQHtdiBCd+JEDeWQJyUvwl7kM7iUWL4I1ntIH9/s5NDAykIIbto2wAfw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by DS4PR02MB10867.namprd02.prod.outlook.com
 (2603:10b6:8:29d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 18:32:10 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 18:32:10 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, Aditya Desai <aditya.desai@nutanix.com>
Subject: Re: [PATCH] target/i386: Add VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC
Thread-Topic: [PATCH] target/i386: Add VMX_SECONDARY_EXEC_MODE_BASED_EPT_EXEC
Thread-Index: AQHcc8x2zBtXqGKhb0e8fjdyhK8Xy7WY2XOA
Date: Sat, 28 Feb 2026 18:32:10 +0000
Message-ID: <4938023D-0F82-4D18-9FCB-DD670D7FBF62@nutanix.com>
References: <20251223060834.1618428-1-jon@nutanix.com>
In-Reply-To: <20251223060834.1618428-1-jon@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|DS4PR02MB10867:EE_
x-ms-office365-filtering-correlation-id: 0c075385-9834-468a-7a01-08de76f7af34
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: zc64dM4BSTD0xAVWAlL29KF/O5i7e21FgHETY9COWPeAtTc0L/mVTONZEvCVgsn9GKyZQATAwurBD4K2fbRqk/U3DDW7SzG0PoD5r/PGZfukZv2sUQD2iZN9N3ERFh7yMIHJ0vyohUVdiii+IU8jt8T0/RauCAkJMLcSnK8QGm37r8Kb5DvTcMnGKDNtzWGBkQ61Vpn9pJ/dYQaSwvYBZUYGrZx4WT8PuA+DjH14BQ5zcguH/fej4lnT8Hv7krSP1OZAETsONonXJ2MQQox5AhpGzKRadH3aN9V0hC18vRCqe8tzHWfgGcHlkzWI0ozVcxR1fDtqOCtK2VzpONanyyKQBRzB5CKz6mbVI9CEe3gVX/A/lYGRSjR1gipyEb6WpJo5x26148CSOZILuQmGlxVcNqdD7crjInr+PsrsRj+W1Nlo/4Kpv7HtboE+XNWDhTiYTHVoUqLh3MIcq3xGE2W5b4scRxzSHNlKZlwFP/DT++eRfnrk0EBffZnCps/f4dJvPdDJh4mPAAnh7aiGDGjAeTLldF+c/r1GyEOlVH1DzzCA3bWSf2pTk23DyIjB7t9EewmHYMI/jki81Qp02qDecUzws6ZCx1dwFKHvZfmM7C2VXHWfBFKjdnxDzO+TNOrGtD32zFlPT7NaB9s3Hin4D4LHI71bGNxgbBNnJsq2gP6FNKfq8bxnQ0sCspOT1WLdAX/s2SiyST5R6BXhzrEC8GTymOuLHLWWsTIQ2dNqe6cPQd4D69r4LaN/2C5P
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnpndjZXRmlTQnVlcFo1REhXUWIwRkNpT05ZV08vQ0pOTGVFMnlxYWJlbXBN?=
 =?utf-8?B?L1dicFJCNUpienpEU0ltMGhENndXNUk3NTZUeFNQMmZlcmd0dnoyTFdLcGpP?=
 =?utf-8?B?bCt5eTQ3dFJCOWh5WUROUEx1aG5FaVA4ZEsvNFE5Rm1DL3ZtOWFmcW1GNjBj?=
 =?utf-8?B?TTZqN0F0R1h3ZWRuelJZWElxa1pZRnBhVGwwTE9RL2loYTlpT0ZGYUQrcW83?=
 =?utf-8?B?ZnpKOGNKWnJrRVZtdmFxTzhKV0NiWUFLWjNvNUFOUC9FNmxIcCtLR2RLak56?=
 =?utf-8?B?bm9BdEVMcGRpZzhGV3o5ODFmV3lKdlBQU29VaHVDTG5NY3hERTFUKzVkVnZi?=
 =?utf-8?B?Qng4eTlwMXNtZVdsRXRsZ0pmYVU5VndBYmdVaFRVWmdxVVFHTUs0aDVBanJz?=
 =?utf-8?B?OHRmUFRrZ3RnQmRqbXZNNS9ibDNOM2FoTjI4aFpFZFFlblcwLzJRUG13bjla?=
 =?utf-8?B?Q2JoUE5ObjFkTUhiOFpzMGVPVmdDblVkUzRDbkFNclpTTjJlOW0xeHRkMG1a?=
 =?utf-8?B?S1VEd29nV2FwVzBsOGdTYk5pd2hxa3ZhdFQ4NU1hclVRSFZXejQvczFjYTFX?=
 =?utf-8?B?VzBTNG1EZEx4d2YySy9DVVRFVVZYMjdXanU5S3VrYXNvTmFPd2lDUTBhb21I?=
 =?utf-8?B?dEZLRjBHelM0L2JuZGg2dUZpVHVtalRTZDFIRFVsWDVWL0pzcm80WnhYZnFY?=
 =?utf-8?B?MzN6Z0ZGU0c2Z3c5KzdMVFlYRTBHaGxiUm10cGY0SXBQSlJNbUtQNXhMdGlQ?=
 =?utf-8?B?cy9YR0lPVHJ1RjlRN2ppYmRrWVVyME9lS2NvdzRKcVBNeWgrckZ3YXZBQjFX?=
 =?utf-8?B?VCtGQjBVUDhJcWJ0VVBRT0ZnbDJSSHNrbk9uNVN1UUNQa2RUeTZEMXFmdE8z?=
 =?utf-8?B?ZjA1OVBieFNreEh4MUtQOTBDSGxRRnY4djJLUjVUMDEwbW9wODNVUkxIU2R4?=
 =?utf-8?B?MFJvVUVXSmVEcS80eTliR2p1K3BobE1la0ZXQ3dNTTFJeGZnWkNVNTRXcjBs?=
 =?utf-8?B?bFRFTHBnb05IdmkwZDlzS2xiam9ETDhOa2pVQUg3QkNncTJYdzk0T0tWRklj?=
 =?utf-8?B?T3huMklnNXIzV2U5L0lvQmw2d3lNeTRpWHVjVUcyZmZQS1VJQnF3aUJRNVhh?=
 =?utf-8?B?d0lzc0d2WDIxWkUwWEFqQVM3TjUvbzMvaUd0MmJNWGlLbnZHRFdYREtBenpk?=
 =?utf-8?B?cG4wd3ZDNUtLY2JXKzQ3ZmF0MmVtOFIrT04zUGFoVzAvMXpPMTFhbUxucDhW?=
 =?utf-8?B?MlVRMENhQjlKTWxWYkN4ejlEa0xGTUdXMURIR3BHZWhsTjJ2L0JlNmpZK0gx?=
 =?utf-8?B?Z0FWdFpacDQ5RGh3bG1DUnAwdmQ1ajQ2Ty9acS91R0VGTG1lTU1VREE2UE9O?=
 =?utf-8?B?S01oZWhrSkJnSitHRTBqYXNsWEpGYVJvRjFEYnNzVlZkdFp0U2xhSE5ESitU?=
 =?utf-8?B?QVphczM0N1hCN1hUSHF5ekZKNTB4V2RCYzlUdHorYWU2aCttRHR6OWhhcUIx?=
 =?utf-8?B?Tlg2Y3NNV0FWT2pzZW1uNlF0b0ZkVU93YWlMRWp6NWcwVWJZQzRiSXN6L1l1?=
 =?utf-8?B?TkVLcUQrdUR4eWxlbzhUWDJ2UTBoTndQRG9BZG9yTEVXeElCOVRSd3dPaWlw?=
 =?utf-8?B?UGQ3V0hpSi9JMTcwTGRHR3l2MHdyc1R5eTEyMUdKU0E2SnZMSmxZa1VRN1h4?=
 =?utf-8?B?bUV3YjhaeFAyYkUwQjFjZHNlOVlaUHp3L2YzZlZUUWlBdmNGVjhRZzdHa2lh?=
 =?utf-8?B?M1UzSXhvakdYZVVwVEZBTDVFN2pXTTFiUkY5QnJiZ21Jcm51MnBzYW9DVGov?=
 =?utf-8?B?RlJTeWJZYmpQVWdYSmQvaC9IZ05lM1p1ZjRhK3ZJUW9qOFlBMVc1bno1Q3BP?=
 =?utf-8?B?U3ZqQ1R5Ym9UaFhZSHJNdjdkTmlTOTV4WStGc3N6VVdjK1laQjZFYnJTZlov?=
 =?utf-8?B?U0N4cE9Hb051bUV6OEVXRVNSQkxNWVB6QVFTMW5XZFlFMU05cEZ6NmEvOUYx?=
 =?utf-8?B?RkUxbEFBTDhvOW1HdGV1ZDc2WURUVTQ4enNwN3dYaGg4TGdJdFd4TXljQ2VC?=
 =?utf-8?B?M2RBZkhPYThsV3h6amtJanFYSzEyMnpyQ3IwZmJhd1RrbjZ2NzJHWXIxaDdx?=
 =?utf-8?B?V2IzZ2NIQ3MyemZqUWpmZm84cCs0bHd3cmJqVklqcmpVcFlkbWo5YVhMMlJW?=
 =?utf-8?B?VDE2NldVTW9ZaVVhZVNVbWQ4UDZoQ0ExTnhmVDMyemwvU3VlUTFjYTlBRFlU?=
 =?utf-8?B?VGZPekZrMXZzQWREejVCQTBncFFCbHRZclZjaHB4aTNYdGU0bHVQaXpFbWR5?=
 =?utf-8?B?YmtNVEZ5VkhjWTNOU0tiL3JqT3BkOU8zVWVucVNMY2wwamxzb09HS29pQUtp?=
 =?utf-8?Q?mKWdjQXAE7yY5Opja6XoBXclMK4d8fytz5/yEm836sczJ?=
x-ms-exchange-antispam-messagedata-1: j3dkcmOVHZq2cAQuJkFqccI3SZ8CnrxmVqE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B1C62D90EEF8489B21DDFFBBA7BBDD@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c075385-9834-468a-7a01-08de76f7af34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 18:32:10.1055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOYfONkSQYy1jYCpecGEhFsDNu9rei4hoanYB+/98/UINAQmyx4CkK37oCeQfZ2KISQDqVeE0oFuvX/xknnk9ubEzGbkqVu0BcJ55fVGUYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10867
X-Proofpoint-GUID: I47feUA_5kIWlrdXh_xasHcT6lJOVAyU
X-Authority-Analysis: v=2.4 cv=FtgIPmrq c=1 sm=1 tr=0 ts=69a334ab cx=c_pps
 a=8OTw2qS5QgwVLUZ+0dTndg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=yMhMjlubAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=QyXUC8HyAAAA:8
 a=6WRecC-mV0c7047d00wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: I47feUA_5kIWlrdXh_xasHcT6lJOVAyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDE3MSBTYWx0ZWRfXzj8/3/HMMIh4
 qd0+j+A9Af39X/kIePFJCwdL+kTKvt2XPcxu7UMTRnyVYcONds7CAp/y3xNdMIPcqKqmUXKBVp4
 /Fe6uM/cPyh/mCEhxMAIPQTW6Dh6tyxNjU/nKiZ+emvv9pNVjpkFXlzGhOUDm+Ovz1Rgyy4OSWe
 LEHRsTfuYvGpHoOUGpF/utHcH4sQbyQmF07PT1jiy18wPZVGu+NOO83jLHalGSVprzLJGK1zafo
 7vfUVdyHafg2plEQVpVjjZ4PeXuVef+JGThkPTcdp0vgmf3WHQCtb3KsKb3Veb0crD8F37Xb4qF
 yNsKnUjSV3Ahs2PgAift9qq7NWdfJfuwwK1flwoKFueNy+hxgeh89ekuI5fhDvM/xwN4Hzgv3aJ
 NQeozNFo9QdL7fCbNlkDiD5Wi2Z7K+qwzMmVxi9w3XbEiinBJGAZbcO2iYz9CYO2aZJqwOEPtdf
 PQeniW0m35r28/jPMBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_06,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gT24gRGVjIDIzLCAyMDI1LCBhdCAxMjoyNOKAr0FNLCBKb24gS29obGVyIDxqb25AbnV0
YW5peC5jb20+IHdyb3RlOg0KPiANCj4gRW51bWVyYXRlIGFiaWxpdHkgdG8gZW5hYmxlIEludGVs
IE1vZGUtQmFzZWQgRXhlY3V0ZSBDb250cm9sIChNQkVDKQ0KPiBvbiBzZWNvbmRhcnkgZXhlY3V0
aW9uIGNvbnRyb2wgYml0IDIyLg0KPiANCj4gSW50ZWwgTUJFQyBpcyBhIGhhcmR3YXJlIGZlYXR1
cmUsIGludHJvZHVjZWQgaW4gdGhlIEthYnlsYWtlDQo+IGdlbmVyYXRpb24sIHRoYXQgYWxsb3dz
IGZvciBtb3JlIGdyYW51bGFyIGNvbnRyb2wgb3ZlciBleGVjdXRpb24NCj4gcGVybWlzc2lvbnMu
IE1CRUMgZW5hYmxlcyB0aGUgc2VwYXJhdGlvbiBhbmQgdHJhY2tpbmcgb2YgZXhlY3V0aW9uDQo+
IHBlcm1pc3Npb25zIGZvciBzdXBlcnZpc29yIChrZXJuZWwpIGFuZCB1c2VyLW1vZGUgY29kZS4g
SXQgaXMgdXNlZCBhcw0KPiBhbiBhY2NlbGVyYXRvciBmb3IgTWljcm9zb2Z0J3MgTWVtb3J5IElu
dGVncml0eSBbMV0gKGFsc28ga25vd24gYXMNCj4gaHlwZXJ2aXNvci1wcm90ZWN0ZWQgY29kZSBp
bnRlZ3JpdHkgb3IgSFZDSSkuDQo+IA0KPiBbMV0gaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29t
L2VuLXVzL3dpbmRvd3Mvc2VjdXJpdHkvaGFyZHdhcmUtc2VjdXJpdHkvZW5hYmxlLXZpcnR1YWxp
emF0aW9uLWJhc2VkLXByb3RlY3Rpb24tb2YtY29kZS1pbnRlZ3JpdHkNCj4gDQo+IENvZGUgaXMg
bWlycm9yZWQgaGVyZToNCj4gaHR0cHM6Ly9naXRodWIuY29tL0pvbktvaGxlci9saW51eC90cmVl
L21iZWMtdjEtNi4xOA0KPiBodHRwczovL2dpdGh1Yi5jb20vSm9uS29obGVyL2t2bS11bml0LXRl
c3RzL3RyZWUvbWJlYy12MQ0KPiANCj4gTEtNTCB0aHJlYWQocykgYXJlIGhlcmU6DQo+IE9yaWdp
bmFsIFJGQzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMzEzMjAzNzAyLjU3NTE1
Ni0xLWpvbkBudXRhbml4LmNvbS8NCj4gVjEgY29kZTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjUxMjIzMDU0ODA2LjE2MTExNjgtMS1qb25AbnV0YW5peC5jb20vDQo+IEtWTSB1bml0
IHRlc3QgY2hhbmdlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMjIzMDU0ODUw
LjE2MTE2MTgtMS1qb25AbnV0YW5peC5jb20vDQo+IA0KPiBDYzogWGlhb3lhbyBMaSA8eGlhb3lh
by5saUBpbnRlbC5jb20+DQo+IENjOiBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT4NCj4g
Q28tYXV0aG9yZWQtYnk6IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4NCj4gQ28tYXV0aG9y
ZWQtYnk6IEFkaXR5YSBEZXNhaSA8YWRpdHlhLmRlc2FpQG51dGFuaXguY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+IC0tLQ0KPiB0YXJnZXQvaTM4
Ni9jcHUuYyB8IDYgKysrKystDQo+IHRhcmdldC9pMzg2L2NwdS5oIHwgMSArDQo+IDIgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2kzODYvY3B1LmMgYi90YXJnZXQvaTM4Ni9jcHUuYw0KPiBpbmRleCA2NDE3Nzc1
Nzg2Li5jYzgxODgwZjI4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvaTM4Ni9jcHUuYw0KPiArKysg
Yi90YXJnZXQvaTM4Ni9jcHUuYw0KPiBAQCAtMTYyMyw3ICsxNjIzLDcgQEAgRmVhdHVyZVdvcmRJ
bmZvIGZlYXR1cmVfd29yZF9pbmZvW0ZFQVRVUkVfV09SRFNdID0gew0KPiAgICAgICAgICAgICAi
dm14LWFwaWN2LXJlZ2lzdGVyIiwgInZteC1hcGljdi12aWQiLCAidm14LXBsZSIsICJ2bXgtcmRy
YW5kLWV4aXQiLA0KPiAgICAgICAgICAgICAidm14LWludnBjaWQtZXhpdCIsICJ2bXgtdm1mdW5j
IiwgInZteC1zaGFkb3ctdm1jcyIsICJ2bXgtZW5jbHMtZXhpdCIsDQo+ICAgICAgICAgICAgICJ2
bXgtcmRzZWVkLWV4aXQiLCAidm14LXBtbCIsIE5VTEwsIE5VTEwsDQo+IC0gICAgICAgICAgICAi
dm14LXhzYXZlcyIsIE5VTEwsIE5VTEwsIE5VTEwsDQo+ICsgICAgICAgICAgICAidm14LXhzYXZl
cyIsIE5VTEwsICJ2bXgtbWJlYyIsIE5VTEwsDQo+ICAgICAgICAgICAgIE5VTEwsICJ2bXgtdHNj
LXNjYWxpbmciLCAidm14LWVuYWJsZS11c2VyLXdhaXQtcGF1c2UiLCBOVUxMLA0KPiAgICAgICAg
ICAgICBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMLA0KPiAgICAgICAgIH0sDQo+IEBAIC0xOTM4LDYg
KzE5MzgsMTAgQEAgc3RhdGljIEZlYXR1cmVEZXAgZmVhdHVyZV9kZXBlbmRlbmNpZXNbXSA9IHsN
Cj4gICAgICAgICAuZnJvbSA9IHsgRkVBVF9WTVhfU0VDT05EQVJZX0NUTFMsICBWTVhfU0VDT05E
QVJZX0VYRUNfRU5BQkxFX0VQVCB9LA0KPiAgICAgICAgIC50byA9IHsgRkVBVF9WTVhfU0VDT05E
QVJZX0NUTFMsICAgIFZNWF9TRUNPTkRBUllfRVhFQ19VTlJFU1RSSUNURURfR1VFU1QgfSwNCj4g
ICAgIH0sDQo+ICsgICAgew0KPiArICAgICAgICAuZnJvbSA9IHsgRkVBVF9WTVhfU0VDT05EQVJZ
X0NUTFMsICBWTVhfU0VDT05EQVJZX0VYRUNfRU5BQkxFX0VQVCB9LA0KPiArICAgICAgICAudG8g
PSB7IEZFQVRfVk1YX1NFQ09OREFSWV9DVExTLCAgICBWTVhfU0VDT05EQVJZX0VYRUNfTU9ERV9C
QVNFRF9FUFRfRVhFQyB9LA0KPiArICAgIH0sDQo+ICAgICB7DQo+ICAgICAgICAgLmZyb20gPSB7
IEZFQVRfVk1YX1NFQ09OREFSWV9DVExTLCAgVk1YX1NFQ09OREFSWV9FWEVDX0VOQUJMRV9WUElE
IH0sDQo+ICAgICAgICAgLnRvID0geyBGRUFUX1ZNWF9FUFRfVlBJRF9DQVBTLCAgICAgMHhmZmZm
ZmZmZnVsbCA8PCAzMiB9LA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvY3B1LmggYi90YXJn
ZXQvaTM4Ni9jcHUuaA0KPiBpbmRleCBjZWUxZjY5MmExLi4wODY5ZTAzMjA4IDEwMDY0NA0KPiAt
LS0gYS90YXJnZXQvaTM4Ni9jcHUuaA0KPiArKysgYi90YXJnZXQvaTM4Ni9jcHUuaA0KPiBAQCAt
MTMzMCw2ICsxMzMwLDcgQEAgdWludDY0X3QgeDg2X2NwdV9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVf
d29yZChYODZDUFUgKmNwdSwgRmVhdHVyZVdvcmQgdyk7DQo+ICNkZWZpbmUgVk1YX1NFQ09OREFS
WV9FWEVDX1JEU0VFRF9FWElUSU5HICAgICAgICAgICAweDAwMDEwMDAwDQo+ICNkZWZpbmUgVk1Y
X1NFQ09OREFSWV9FWEVDX0VOQUJMRV9QTUwgICAgICAgICAgICAgICAweDAwMDIwMDAwDQo+ICNk
ZWZpbmUgVk1YX1NFQ09OREFSWV9FWEVDX1hTQVZFUyAgICAgICAgICAgICAgICAgICAweDAwMTAw
MDAwDQo+ICsjZGVmaW5lIFZNWF9TRUNPTkRBUllfRVhFQ19NT0RFX0JBU0VEX0VQVF9FWEVDICAg
ICAgMHgwMDQwMDAwMA0KPiAjZGVmaW5lIFZNWF9TRUNPTkRBUllfRVhFQ19UU0NfU0NBTElORyAg
ICAgICAgICAgICAgMHgwMjAwMDAwMA0KPiAjZGVmaW5lIFZNWF9TRUNPTkRBUllfRVhFQ19FTkFC
TEVfVVNFUl9XQUlUX1BBVVNFICAgMHgwNDAwMDAwMA0KPiANCj4gLS0gDQo+IDIuNDMuMA0KDQpI
b3dkeSBxZW11IGxpc3QgLSBwaW5naW5nIHRoaXMgb25lIGFnYWluLiBUaGUgS1ZNIHNpZGUNCmlz
IHN0aWxsIHBlbmRpbmcgcmV2aWV3LCBidXQgdGhpcyBvbmUgaXMgcHJldHR5IHN0cmFpZ2h0DQpm
b3J3YXJkIG5vIG1hdHRlciB3aGF0IGRpcmVjdGlvbiB0aGUgS1ZNIHNpZGUgdGFrZXMuIA0KDQpU
aGFua3MsDQpKb24NCg0K

