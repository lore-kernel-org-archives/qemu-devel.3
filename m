Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761E4C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBfUS-0004Nd-CX; Mon, 27 May 2024 14:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBfUQ-0004MW-FD
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:54:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBfUO-0004yF-64
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:54:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44RFJ6vb024269; Mon, 27 May 2024 18:54:27 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dd5JUmXFf4YAAIU6Cbg51iSn1mwL0ydpvbFjm1W8Ji74=3D;_b?=
 =?UTF-8?Q?=3DMLLVZp/rJpXnTotqU8GTO7Xzd9YJTCNhkfRBJKtfA6bl5MpbPMoKpoWn3Er/?=
 =?UTF-8?Q?14dRb0Gt_2zHK+oO/wfBYUR2iDpXomUgDQ/sp1n2sIt6dFalFRAXyLhkO63PWVh?=
 =?UTF-8?Q?mOn2myjI+aWzf8_9VsD/WFoF1YMCejepy/K9uoaDZQ2WKqBdCqCzWKGVSYJnCKs?=
 =?UTF-8?Q?Bn11Vjr/cQrZXdYTS6qW_r8+CzaoL7TGDXBVURWSdWt447db42prPGbCoZk9aRo?=
 =?UTF-8?Q?bELvdukEhB2UK4LwqhSvxD4vNm_lw6t/6F+mzt6lTgiUZ9EaoxBPdGQsslkPBTm?=
 =?UTF-8?Q?vOQui1CwEA4Eer8H3GXOl/as2Hf536tC_Lw=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcaydu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 18:54:27 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44RHd80f037681; Mon, 27 May 2024 18:54:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50523w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 18:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjU4jp2Da1yESwZOSVBvjVfbsqjpazFh6ieiv6GWQWpyu6rlf6ViXeUBvU7Xa0q1323PH/l/WNUhyVgeAJC15QsUdkoJttWp7X3s1be9CFhDEjvNufy2r8LTMkFylxy4uIuFbwh0Ms8UAo+qD9PKU7GmKI2DIP9ejRxJHoZWyY1ks6fgEsRLlWsOTNy/Qs7QKG4Dwl3s6eHX6PcuY8MVq1Ir9RFv6FuBJ2/fT9S8pcd0BjJ2xeJsrF7zedF9UUTgbYgdbUJr+pwCCBTBQMIUFuIauJr5Szqu66t1Sjf23QVYJCdFNjXITSoMH4UFcktX6uQ+rrygecolQN2XTcZePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5JUmXFf4YAAIU6Cbg51iSn1mwL0ydpvbFjm1W8Ji74=;
 b=ENazPdh+nvUbx0TTSP5VImzridUb4nyASa8bqyulW8796KCk0pNFRmZYl9/LhPWBUsa3ApJOPia6Zhr+ZL+4NnvztdOvyk+rvYszmN9D3YcWUbVQ1/qv6799tVPUKSoVH9O2UbPWdQYomIh3xzK4KKUNq4ObGNsjsY6SEJCgyZhRlwaYdFXXTHD2oY5VH7mMovK4BWote+JhHYmafSncSoRRjjvIFsnNMCGvz2+RXVgk3ST6pnlNCPX71K96K0rjRqnZ1kLyuBhRaRBTsUpRQmkg/D9BMRywKLTvAFr3Z1lpEi+jUoPTLdAIXyKpLe9wd1uC/SkjuYai6qy4wRVvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5JUmXFf4YAAIU6Cbg51iSn1mwL0ydpvbFjm1W8Ji74=;
 b=u8iHPAmh0R6ziRLInTETPPYsEFtBLx5sGa8yUjZ56FekEeCEZKQ2tMVWhDBbyPxzdxK23m6CddMKycsqcXyV6qFikOn0G45uySOyXTD52ICKDqGS/G4+6u1GMcF3URrVOcbBbuO6pmxdEkslPY6I+0fbqt9kfp9nEaaXZc/e4BI=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BN0PR10MB5192.namprd10.prod.outlook.com (2603:10b6:408:115::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 18:54:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 18:54:23 +0000
Message-ID: <21f02815-ae2b-4f21-a187-f52553e79090@oracle.com>
Date: Mon, 27 May 2024 14:54:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 20/26] migration: cpr-exec mode
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
 <87fru7gst5.fsf@suse.de>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <87fru7gst5.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BN0PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6041ecfc-34ff-4c0d-94c8-08dc7e7e6ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3NlTkpCdU0vVFBTTklISWV1R2RENGsvV2pZd3NxdnJOcjRxTXN5d1BFZExH?=
 =?utf-8?B?dzNFc0psa2theS96T2svUTdRelgwUzhuMTVjU0U0VlJqdEs5YVZHaGlQczJW?=
 =?utf-8?B?SWU1YVpTV05EWFBLYUpSQW45YUZPRkk2UTUrdTFkOGl4Z0t4ck42MFB1K0E1?=
 =?utf-8?B?M3grVWMwY1Q1OE15VFNwYlNGVE40MGk0NHpOS012angzTzNycW93eUhRSFE3?=
 =?utf-8?B?cFFjNlhuS2hpZElOWm9rSW52V0ZhVEl0Y2RRQklwUTZsbkNmZ0JxRGZyWDYw?=
 =?utf-8?B?bkxJZ2R3SnR3amVDbWp1WnJKbHNBaldnK0ViNG9ZUkl0b21TSlVOU0JpRy9O?=
 =?utf-8?B?RW5uYWN2bmZ5MHlHQkt4RGExQm5hekIzK09vZE8xQ3ZBNTVnOGtjWVQrM0N1?=
 =?utf-8?B?VnZLb0Q1b3BZVkVQcVplYlVhMnZOTjd1UHdJTFNPSXhsOHgyZzE0T1VwRS91?=
 =?utf-8?B?MEFWUUpSUDNIdkFxcFk2MDdsaVNKb0RLR3pRWXRlQThFcGtwTE1UaWl3a3lY?=
 =?utf-8?B?WXBRNkdTUmcvcURwSnVCUkJIRm1ZaVFjVU1uMXpiMm9rU25RZkYxY3NpRytq?=
 =?utf-8?B?Q3E4YkxUTlFQeThWTjdZRTQ1aERjdlFXdlNDeTFGUlJKcGNuR0NLVHV5RHNC?=
 =?utf-8?B?Y2J0Tm1BQTA1VS9Cb0JydUhtVk1UOUFjMzg1U2UyNTNoN2lKa3RWQzU2aEhW?=
 =?utf-8?B?UGJRaGNWdDZ0Uzd5VkNjdm5Td2JZbk9hbkFmSU5uN0l4MWxrRkRzQUhnZ2hW?=
 =?utf-8?B?MGoraDFONXdGS3l1VHo2bGpxSDM2TzRqR0puakVtRnoyRWVrM2JDTzA1Ym1r?=
 =?utf-8?B?blhOWHlRWVNLTnpDL0IwdkRvL3prL29EWWJ3ZVN5TXJHN3k2MGlYaThNUG9G?=
 =?utf-8?B?Q1Q3TGlDT242M2pTTXovYWtEa3ZEaGkrQWRtR2VwSjg2RFlBcnpheFNXQU10?=
 =?utf-8?B?aGtQTmdrcDdnSlNNVzNzdG4rRUhFSUZwdUdBRy9LQU9kSkp5Qjk4Mm14ZkRC?=
 =?utf-8?B?YjFhemo1QjdzV0ROSjNzSThqek9iNW5IVmpaWHdMVHBpd2poN3VGU3I3ZGR2?=
 =?utf-8?B?eXVHSUoxQlFaRzJDaFEyN3JxUWxZa0NibFhzeVlkc2M1aDQvRXpjakk0M3VX?=
 =?utf-8?B?NHIxZUw4Z29KRGY5MU9JZ1ZrTFZ1clQ2N2toRWNNODZ3dzQya1BKZW1QMFNt?=
 =?utf-8?B?YXNvaGhtbGp3V0pHZ3hIK1plckQwZzVLWUN2dVJ2dEFWZ2dUMGZFTnE5Z0RE?=
 =?utf-8?B?ZVNEb0oyUHYxSTd5NkJTbStvOHhaV2FBMEdnY00zeGcwK1FFM2Uvb3Rrc1F4?=
 =?utf-8?B?aUFrcmJtbFhQSFFPTHkwb0lMblFwR1M5RVZCSzRvaEhKTlp3aE1XV2lNUkdY?=
 =?utf-8?B?Rzg1WnIxZm8yejF4UzNtaTlKLzFZK2ZxbGhlcmF6TFVpdEpOZTV3blprVUph?=
 =?utf-8?B?bER2ekIvN1RMSFBLV2RQbEttTEI3bTBFRVJwdklETGQ2aWZLUVlaRW5GNUxS?=
 =?utf-8?B?QlhCNGVIa0VwUi9ENytpQUg5a2tySHhaN29mV0ZvMUNoQ2NpcVZScmhFY0lE?=
 =?utf-8?B?NGMxamZucVdMNlNIU3gxYlJTaktBcXFqQWtoY2ZQOVd2ODBvTS9pUU9mVldS?=
 =?utf-8?B?NXdpUnBENjBuWjdTNEZDT0pjVTVYcFFzWmZvNkJrU3dRcy85VHVIT0t4NGxU?=
 =?utf-8?B?dVhMemRDWUNaQ2cyNDdYZERVeEdGRlZHbHNTZkhGSWRtMDNQM1JIdW5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9PVDNTT3R3NE9Ganp0ditsNHI0bCtnUGRuVnF4TElycWdsOTdPb3krSDFW?=
 =?utf-8?B?SERaSUpsK1FDRURZUjkwcGxSMU1aYjR2VWExK0hxWGhUZWR3UDhrTFRFbEhy?=
 =?utf-8?B?cmZ5OStTcFZPaXdpL3hNTThTZnVPS2k1V1c5WWhDYmw0WWViZTFhUVdLR0s5?=
 =?utf-8?B?eWVkc2NJRHFBblBZQkI4WTZWQUhtS3R1NUVvR1ptOHN0OEtPYVVOek1CdERq?=
 =?utf-8?B?bVg3QTA4L0RVUkErcVFJS2RNTDhoUEI0S3JKTkU5aitoblM5bDgvS1VCVW1K?=
 =?utf-8?B?WmM0ajErVmlGdmIra3BOODlzVUhBRlNKVkxOLzIvKytFTERyNUQ1bU9wTVdT?=
 =?utf-8?B?Wk1hUE5ZVVJpQ054dlZWRCtmUkczZFhEdzNqaGRWaFhVQUhVRmF6dEZidXZQ?=
 =?utf-8?B?a0hnenNSOGtpcEpQd1YvemdXK3F1N29Hcmd3YUh0ZUFzT25IVUZUS0Q0OENM?=
 =?utf-8?B?ci9VQjh2MGdMZ2J1ZGZ6dHNBbTNmOW5pa1l2cFJUcGwwRi9lakRZQiszRnM2?=
 =?utf-8?B?THNUTjBJWGNIb1FRRUVYZ2VYVk1GL2hPWXRweVZra0xtSjJSVlJhTFVSOExm?=
 =?utf-8?B?Q3QrelUyUzNXelVZVW13ZnBLL3BBTXhHcWJYdGZVQ3BFWU5QOEwzY2xuaTdj?=
 =?utf-8?B?T1ZLb2N4MmVBSFkyQ2hRdVRTV0ZVbFlvSEFhT2FnZlE4TUVqVzRCK0FscEFW?=
 =?utf-8?B?Z2k0djhyRnBTbE8zV21vcmQ5WXdqWFBaSDJUb3NZMlJ4M0xoek5nVHhmYlhZ?=
 =?utf-8?B?eC9sMG9IcURCSUNXdGMxaWYwUG94S2J5ZjVzbytyOENGZ1JLbkhJZlVYejlZ?=
 =?utf-8?B?ZUJpazY1WCtDMndrNlJKSlFRQnpoWDJYdENUK2owWmQ0ZHMxOGU3UktkMm5K?=
 =?utf-8?B?K0NOb2VNeFNjVmZnS1huazJZUmNocUJMdTZYVlNmdkRzVmFMY0E0NUhjbFBv?=
 =?utf-8?B?eTk4UGl2d3JLMmdJcjE1VW5rd01Ld2Fsc0VGeGNsblRUSVZpc2JPcHBTdEFZ?=
 =?utf-8?B?dmRoVnU3Y2pwQ0U1cVJhV3NDQU1xZCtReHN4bjd5cUhROUdQOEdqYTluWnVl?=
 =?utf-8?B?SFFRelFxQ1I4clk3ZzZkN3cvYmRTRXdvNjVpZWhxbk12ckl5NitWbFhaRmhj?=
 =?utf-8?B?Ym1sT09Scm15YW16ZENGWktNdDdMY1VNRHRCU2dSYnptZGJtb3FEOVB0QkRp?=
 =?utf-8?B?S3JZWDdvT0hNV2phZ1pMUmNOaGFQckkwWFlsTzFDeFdsblNmZkJsd1lmeEda?=
 =?utf-8?B?Tmo5K21wckZqQzdEV05Tam95bmZGdlJSNnEzQkQvMFVyYkREaXYweWxlRkJm?=
 =?utf-8?B?WGY4cnNtcFdVbWpVczczUjg5SEZKdTJOUDhUbmxrRWMzKzR5M1lHanB5N3Jk?=
 =?utf-8?B?cjdReWtBSndKN2ovRVA3QXlnSlY3aVJ0Qk5ScElmRVR0QlZSOVFwS05QSStE?=
 =?utf-8?B?bnhlVkM5aGdOekdFSnV1c0lNRDV3MVpYakYvc0NBN01oOE0wWE9oNEZUbTM2?=
 =?utf-8?B?QlpTSjVWckpqclBNMEFHTFZYUFlwOFhhQ2owTytqbG16U3o1ay8xNVhQWW5w?=
 =?utf-8?B?OUI2R09BOTJ4NHpmcGtIUG15OFJOTy92OENWYSs3MU5kb3lOcjhXK1pOOFJr?=
 =?utf-8?B?NnhZZzJLM2lSWWtjVjJ0b3Nwa2FCbUlFWFJ2a1RmTHFUUWtxSW5TUjFlZlpW?=
 =?utf-8?B?S1lRTmxGSTJPRkVHMzRUQXdJSU0zam9vRjBaakNXV013d2lPOWJab2NNaUpH?=
 =?utf-8?B?NE9xTW5wekxCTWp3ZFBpWkM2YzN5YTJJYmpPSjF6TGtVYjhRUzNlRFBlY0Nx?=
 =?utf-8?B?dmROcVU4aU80NG1mU0w4K3NkQXU4SE5EWWVHV1hiWmFMZlJnemtseVdSejhD?=
 =?utf-8?B?TDNsc0F3QVltNVJlZlM1aldnaHJuWnR0WEZBQlN3Y1BJTlZ5cXMrMFhvYlVP?=
 =?utf-8?B?Zm5jSEpxUnljSHNsZVB0MThGRFBWUkVtNE4rMytKMDI2YVFEQzExckpuWGpU?=
 =?utf-8?B?VVd1TUk0Q0QxdXhvZ2N2bkpKWlp1QVJ3TTN0c1VWTGR4aExseVBNbU16SmND?=
 =?utf-8?B?S3JSSkFKdGRPOFZNUVF5WWFRUCswMThwL2JOTFpiMWl3OHBxZUVnNTJvdmZN?=
 =?utf-8?B?RUVneHYxQkF3bE5NcHhjTm04bnQ0dHJuV0ZTV3B0bjVzRXdOZWJaOEpLczZT?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pp8u9RwoWM0fpsSfWi3y+7ZTBev9Z4jsoSE1SyQc4+M9IQwb4pdQu3IPT7G80ahwBB/XDetjBt5hT+lSv12LLFkCzNdcQcygjDmwnf5TZOclm2GN+L2lyr5JAw5V2l7iJQDvI5dYF247mKvqOCRt5fmtWUeD7FJqV6N0Byhe7jqW4bRQwJg7xF5C9L0nqwzAagX6RDGKRZji8cWvyW8GCeFGL/4tPy0z7GG8kFgP+D9fGOSrwhUwbnwsQRjaOI0EgaMrr2WJCt3eMfxCq/Hdkf5Mx9/r+ZsDj4sqR5d6qVfS2K+ZgEnK6BBE/xdupIL7SqmlzMS/VoqAyaHLW3ZTlJBmHD7N9leWhPXG+MD0r12Zdrgj/3khKghWabeM8BoiU6+c7OruysqdwKklPz/VR1AtMy1yUOWTLJCgwx32xxSNPu0XIpFeZ1FC8/Ja6MWILxbd6hMwPPFdEyjRSt7te7SLCA7bZDH2BDNTOO5A+uZNJVy/0iSfbuASW9TuCuwBuaTuw2cKRmcftQWnOABw6KRpuenQ+mYM6ty3dLxEAlyCQMzKmIQCZ9LMXf/lxDwn2pznZhss7x02uiJZtoTD7nJ0PGcm49gL3khhpuxiw+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6041ecfc-34ff-4c0d-94c8-08dc7e7e6ce8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 18:54:23.9013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moo3fLK4Wg3M4Cxfg6ytUW43N25BRbn43A/E1cbNPVGEB/iUd0rMpBkrbLH3oi4vJTKWmP5TsxARKqYzXYh9ZdYThh/SCgjq6sS4n9uzDMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405270155
X-Proofpoint-GUID: OB-Vat6lO4YmHuDbDIP8hX4qN8Sr4QyF
X-Proofpoint-ORIG-GUID: OB-Vat6lO4YmHuDbDIP8hX4qN8Sr4QyF
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/24/2024 10:58 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the cpr-exec migration mode.  Usage:
>>    qemu-system-$arch -machine memfd-alloc=on ...
>>    migrate_set_parameter mode cpr-exec
>>    migrate_set_parameter cpr-exec-args \
>>      <arg1> <arg2> ... -incoming <uri>
>>    migrate -d <uri>
>>
>> The migrate command stops the VM, saves state to the URI,
>> directly exec's a new version of QEMU on the same host,
>> replacing the original process while retaining its PID, and
>> loads state from the URI.  Guest RAM is preserved in place,
>> albeit with new virtual addresses.
>>
>> Arguments for the new QEMU process are taken from the
>> @cpr-exec-args parameter.  The first argument should be the
>> path of a new QEMU binary, or a prefix command that exec's the
>> new QEMU binary.
>>
>> Because old QEMU terminates when new QEMU starts, one cannot
>> stream data between the two, so the URI must be a type, such as
>> a file, that reads all data before old QEMU exits.
>>
>> Memory backend objects must have the share=on attribute, and
>> must be mmap'able in the new QEMU process.  For example,
>> memory-backend-file is acceptable, but memory-backend-ram is
>> not.
>>
>> The VM must be started with the '-machine memfd-alloc=on'
>> option.  This causes implicit ram blocks (those not explicitly
>> described by a memory-backend object) to be allocated by
>> mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>> RAM when it is specified without a memory-backend object.
>>
>> The implementation saves precreate vmstate at the end of normal
>> migration in migrate_fd_cleanup, and tells the main loop to call
>> cpr_exec.  Incoming qemu loads preceate state early, before objects
>> are created.  The memfds are kept open across exec by clearing the
>> close-on-exec flag, their values are saved in precreate vmstate,
>> and they are mmap'd in new qemu.
>>
>> Note that the memfd-alloc option is not related to memory-backend-memfd.
>> Later patches add support for memory-backend-memfd, and for additional
>> devices, including vfio, chardev, and more.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h  |  14 +++++
>>   include/migration/misc.h |   3 ++
>>   migration/cpr.c          | 131 +++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/meson.build    |   1 +
>>   migration/migration.c    |  21 ++++++++
>>   migration/migration.h    |   5 +-
>>   migration/ram.c          |   1 +
>>   qapi/migration.json      |  30 ++++++++++-
>>   system/physmem.c         |   2 +
>>   system/vl.c              |   4 ++
>>   10 files changed, 210 insertions(+), 2 deletions(-)
>>   create mode 100644 include/migration/cpr.h
>>   create mode 100644 migration/cpr.c
>> [...]
>> diff --git a/migration/migration.c b/migration/migration.c
>> index b5af6b5..0d91531 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -239,6 +239,7 @@ void migration_object_init(void)
>>       blk_mig_init();
>>       ram_mig_init();
>>       dirty_bitmap_mig_init();
>> +    cpr_mig_init();
>>   }
>>   
>>   typedef struct {
>> @@ -1395,6 +1396,15 @@ static void migrate_fd_cleanup(MigrationState *s)
>>           qemu_fclose(tmp);
>>       }
>>   
>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>> +        Error *err = NULL;
>> +        if (migration_precreate_save(&err)) {
>> +            migrate_set_error(s, err);
>> +            error_report_err(err);
> 
> There's an error_report_err() call already a few lines down.
> 
>> +            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>> +        }
>> +    }
> 
> Not a fan of saving state in the middle of the cleanup function. This
> adds extra restrictions to migrate_fd_cleanup() which already tends to
> be the source of a bunch of bugs.
> 
> Can this be done either entirely before or after migrate_fd_cleanup()?
> There's only one callsite from which you actually want to do cpr-exec,
> migration_iteration_finish(). It's no big deal if we have to play a bit
> with the notifier call placement.
> 
> static void migration_iteration_finish(MigrationState *s)
> {
> ...
>      migration_bh_schedule(migrate_cpr_exec_bh, s);
>      migration_bh_schedule(migrate_fd_cleanup_bh, s);
>      bql_unlock();
> }
> 
> IIUC, the BQL ensures the ordering here, but if that doesn't work we
> could just call the cpr function right at the end of
> migrate_fd_cleanup(). That would already be better than interleaving.
> 
> static void migrate_cpr_exec_bh(void *opaque)
> {
>      MigrationState *s = opaque;
>      Error *err = NULL;
> 
>      if (migration_has_failed(s) || migrate_mode() != MIG_MODE_CPR_EXEC) {
>          return;
>      }
> 
>      assert(s->state == MIGRATION_STATUS_COMPLETED);
> 
>      if (migration_precreate_save(&err)) {
>          migrate_set_error(s, err);
>          error_report_err(err);
>          migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>          migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
> 
>          return;
>      }
> 
>      qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_args);
> }

No problem, I can hoist the cpr exec logic out of migrate_fd_cleanup.
I'll call migration_precreate_save prior, and I'll register a notifier
for MIG_EVENT_PRECOPY_DONE that calls qemu_system_exec_request.

BTW the following does not work because the order of bh execution is not defined
by the qemu_bh_schedule API (and in fact the current implementation prepends
to bh_list, executing these in reverse order):

   migration_bh_schedule(migrate_cpr_exec_bh, s);
   migration_bh_schedule(migrate_fd_cleanup_bh, s);

- Steve

