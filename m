Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E85C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 20:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVGN9-0008BZ-Cu; Sat, 20 Jul 2024 16:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGN7-00089S-H1
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:08:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGN5-00025k-Gc
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:08:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KK54on025105;
 Sat, 20 Jul 2024 20:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=3sFrQ6rIK2X1cYsTag1ePW7GdoPpPJcG9F2WdLIXgCw=; b=
 Rc0oRqA/YCabEcVhHKb4rKp0MC1rTmXTu35U00oh9EZ3yLNLpLQRFc42mb8RptCk
 cHxkaxgzyUhIEiIzSI4Smuu3sl2d9SVYtq3i35w+x+UH6lISSUPGkj5lFnUkRqPE
 R3g+ngzxS1MOmpPZ3vCydDG/f38ZmKvn3Xs8BA9BwQzu+5MIIFxiGV5HurB8+dOs
 wH5LKKbUcefxh641tbDxYKIORrP7DyhStbt9zMFdNMLwhFfOXDlLK0RsLrO8go5y
 4bfADEA/RoRcHLQRxIk8SAUDcUkazO/uqcxvwXahOS3bNYkOqe7qyQ77iauKaWCI
 MZYG0azDUFZVTL0M2bxhLQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gkya001b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:07:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KH0Aj0034902; Sat, 20 Jul 2024 20:07:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3pbqjpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEM+U8PNm0mzHm3sw1iAt2TYcd4IVOPCsQeV3jE+TxB4hvuMRKhj3tHrvaJhAge2HjiywqQE/rp/XUZQOBL1AMQqbqLV4B4WHm/xeqSw2TwI4oaluXAJldEjK8yaTaPditg58w4InoWtbtWgajnfEcJ6xRhVxW0LEyDfJvL6rXoOFgWEnXyLXmZ/rgzcEiTH0dOikM2R0cKAiY2NKWoNCHj51z/Yi1AtamT8UZ9IPXzUguyYV+O46wslVx5/aS0nNBP3vVVZeIhHGAmu7St76YEQPYZnpr15djpD4B9NGOzr/f/7ATIKyT26tqQr2YiUxmOAULvSu/bx/TS+7I5S0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sFrQ6rIK2X1cYsTag1ePW7GdoPpPJcG9F2WdLIXgCw=;
 b=cXF2nvI4VHZPBQuSI9PPVjjU1bW8fW3HFghAZbzmY2/Up0CU9FxWnVpu3ZWgb/4rki7ztLFUVEPWrHDNaE+GCpxvtgK+WdZW0K8KEbZ1DQ1wF04J3qa2JJcqvGsmu6FqlXZfPP84cyxjBqhHZRsgWNos0VAZdtHUkK/OuR+gq1Xcw2kbJbHQxYRtqpSkhaNfVUTfA37mOuOophyPhpM1cX1vZsVV0M8vhAcc79qqGzShqBpx5oxcGjdle3Q4KbaXEceKe4+dMiXzzmay41ra0dNTWqwuhWdVcDV5IARWg4cfR5hByUosrkNIQlsY5r5AmFBE/xyjn5uXv3na/BruAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sFrQ6rIK2X1cYsTag1ePW7GdoPpPJcG9F2WdLIXgCw=;
 b=v3FxVUwg6Vc/au0QVZmnIcguiBA08mp6+pIrTQ/cPvz5mrFTv6pkuraKflbiCBNNmdOReMSes2crOoh8Ji8punIpDA8vVlsn8VwnpvcvM9q1+P05K9CW2WC7tR/y98xvjfAfxsZy3d/rdVTlGzSd0714+guTq/VfVPffTn0m/qk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7987.namprd10.prod.outlook.com (2603:10b6:610:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Sat, 20 Jul
 2024 20:07:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 20:07:54 +0000
Message-ID: <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
Date: Sat, 20 Jul 2024 16:07:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zpk2bfjS1Wu2QbcO@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0655.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 333c6e88-55f8-4aea-6f78-08dca8f7a439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1lna1F2S05ubHh2a1V6YklIb3djV3hZNUZoK0FPdnN3eE80RU42aDMzQnR1?=
 =?utf-8?B?VDh0T1hDWERPTG1WakRDOXdzZXVMQnA2OEgzeTJ6czVLZ3VFc3ZvclBHZjl4?=
 =?utf-8?B?QjVEVFcvbW91MFJNQVEyTXlTTTRGS2U3bElPTFRkQThEM0t5QS9CQUpTSHpI?=
 =?utf-8?B?NXJESWErQlBoN0xDZ0NyTENtL3ZlSklGWFEzOUh4ZC9SRDUwRFRhaEIwN2hP?=
 =?utf-8?B?WFRheTB5ckFJWWZIRUhnd1EwNGtUd3dNWlZYRDJSODFyMDNYb0ppb3k1YktE?=
 =?utf-8?B?ME0xYnF4aVFaeVAySE1FelFXaThBdDlqSlNvaWRwdkhMbzVkUGc2clRKTjhu?=
 =?utf-8?B?ZnBHZ3hqenVLMTBrR0k0c0Z2NW5RT0NnRE5qMnROc2hJMVBTdGd5MmRsSU9R?=
 =?utf-8?B?WW4vVW1aYkJRK0ZYUmw0QlovVjFUbzFsd25zWE1GZVpDeWFxbWdaZ2lUY25l?=
 =?utf-8?B?WEM2OFNaaSsySGduaVNzLzJCa3doNzBydUYydFBkTnMrL2ZIMHNDaGI3SldS?=
 =?utf-8?B?SUpXQmlBM2lMYkd2N2VrdnZRelpnbWlsMjRhSVRrbk1HUzFjTnJuV3BLRTFm?=
 =?utf-8?B?NzRia1pJcDJSZUx3L2JsL1N2Y2E2aWh5SVM0WkhOTFN4dW9paEtuRGZIcHZn?=
 =?utf-8?B?dW9ycFlXdWM5UjJiYXFsTkJJbXp4dlVMQkxrTjk1S2pES3ZPdmF1TzRMTmZi?=
 =?utf-8?B?WVo5VTh1TXhkZFgraUlNZFJXblY2VEdPZXhlZUw2SU1xMnBkUTR5SUxQcFhE?=
 =?utf-8?B?ODJCekdrZWtjMVRRcjJRWFdUT3MxZENHTzFwQ0ZBMlJaQmFUWlF3bDhHNjcw?=
 =?utf-8?B?RDhRVlpwRXdyZzdEK3B2a0loZjhmQlJ3OWZyL1E4VHJZeGh0bDQxNDFiLzFi?=
 =?utf-8?B?a3QzZklPUnZmNXdkNlYvV3lWQ2JkbVNnU1pEMUVDc3lSdTVBbVJhM1BMZEky?=
 =?utf-8?B?WDJoS3BXV2trMjMwNjUxSXdvTHVkbDg0Vis2UFJzUzJYR0tJdlpGOE45cEdp?=
 =?utf-8?B?ekFIYkNzOXJnZVBUckJOdjFXeDZ3QnIwcWdIYWowQVM2ZkdOQUpEcGhLV0Jj?=
 =?utf-8?B?YzhLbm1DN1ZrL3oxcFEyQ2RkOGNDbnRqWHorUjUvWitvMFdGUnA3ZElvSlFV?=
 =?utf-8?B?YVJrZ2s4dllpRVJsNHRUelg2MTFUai9CM0hrWFFUSXpFSHpubVNPMldjL2x1?=
 =?utf-8?B?dkFCcG00L3VvVFhSeld4SHUwWWNPQjFDeUNrUXZVT0t5NHU5ZWhObkNUSVdI?=
 =?utf-8?B?ZXVYbDlUVFEvUCtORkNXaHhTTWlzL2hCYkVldFJSSlB2UUxSTTBWcWIzSDhl?=
 =?utf-8?B?c0J0eVdFaUdCczN3dkdqNWZkQlNETnlMMTdZOXRPT3lqZVhjZjc0SlRMTnRE?=
 =?utf-8?B?c2ZrMDlTSWovYXQyaGhoTmdvZW9oYXJveGVScERRQklvdUY3S0kxKzkyYU0x?=
 =?utf-8?B?WENya1E0czloZW9IT2E3ZDlha3lQVzJPUm5kRy9vVDJQSWhZaUZhcXlnTktQ?=
 =?utf-8?B?R0Q5Nm5nZDJCYUIyRHNsMmlEL2RoVG1RMXZTbEliOHc3NGxla1hkdVExSTRa?=
 =?utf-8?B?WWxZWTdXWE5BL1hZNU1ZU2dROUpKZEZXR2xPc29kMk5EQTlFditBcmxaMWZ2?=
 =?utf-8?B?YjJpRk44Ry9pd2sxWFhnMlRUd1VMVTlXY3c2MWVmU3NXck9YanNjNUc5eGdv?=
 =?utf-8?B?SzVVUUtDMlJWTXlPWnZtTUF2VmQ5VHhHWHQ0eVlqRXl3YWFkUjI1MUoyQlcv?=
 =?utf-8?B?dHFUdjR0N2JBM2JJdVVIWllmYmI3dGNUcmRhNHloeWRrN1ZpZCtFTDdBZTZZ?=
 =?utf-8?B?d25says4YXJid0VoWEo4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlrNlVVeVlMVllhZXI4cHpjR2t2WTBuajVFNDA4bk1TZFcrWHFWYVNhd1hk?=
 =?utf-8?B?bHgxUHViTWZCcHVVZVY2ODQyTEs3WWNHRUsxMUIwbnlkaUxxZGhTZDM3ZEVM?=
 =?utf-8?B?Nm9pS3FRQTMvNVp1SmhDcWl5V0VXWEF4L1JCWlk1bTMzcng3YmhiaHpaZUxy?=
 =?utf-8?B?V01hUFJsaEFzVUNEMlBqampSY25oaGpma2ZpN2tFN0tWbERhaDlZS28vb3Z4?=
 =?utf-8?B?MnJ3Um4zVkxMMEd2SWxVdjFsaldHTVFtVHRGbWdVSjl0MmJ6WUtMT3RrTm9x?=
 =?utf-8?B?MnYvNjdGbFNDNkptejU3V1FUL0pibXlRcmhFVm13Z29nRktiaVlTbGFLMnFm?=
 =?utf-8?B?ZmZNT3AxSElBenFNVXdMWEliNTNiVi9zNS9CdW9kRmgwNUFjSyszZm5pMjdX?=
 =?utf-8?B?VHNoTGM2ejRTZFFjSHl5MlB3RS9ZNGhlVHE4a3FmWGdBNUlNQkdsZThqTmR4?=
 =?utf-8?B?cFVNUDRGVjg2TFRjNXd5MXpMVDc3SW1ENjJXQTZFbzZucGdyem9qcWduaFJa?=
 =?utf-8?B?RlR0Q0UrNTJ3TVVsb1RxcWxLNTB2U2lVNVozVWpWZFhQc0RnbzVzbDk1U0F0?=
 =?utf-8?B?RHNIU3dmZ1VRdWFiSE1KeHcyVE85cWpVTE83OTZvVWNLU05NSHJGSGcyTzdW?=
 =?utf-8?B?cEZyd2lNZ2phTm03NTN5SW1PcVR3aEI4c09hSE83QnBKN294SDlGNXNwUkhx?=
 =?utf-8?B?eitpN2Y5OEtyQ3cyMU5ZSlJaa2RJLzdPaksrM1g1UmY1YTdNbTU4Z2ptOWtq?=
 =?utf-8?B?YnJueTkwdjh0ZlZYMEF2YUVjeUxERjhLWS93c1FIeVkvdkdPZjhTR1VvNXFh?=
 =?utf-8?B?dk9mUVR3cFRkaFR5SzR4a29IYVpyY1R0WnhCc3BkOVlHakVwT1pNQXVFb2I0?=
 =?utf-8?B?RDlEVmhrWlBsdkkwdkx6bkQzdUFRYmV2WHRJMDY0TEZhUVdNcWdxTnE3ZU5K?=
 =?utf-8?B?c2hXKzFLQW9WSHhFdG82VzhsZTg2YTR0c0NWaExsRmV2a0NzZjNvMXRLd0pk?=
 =?utf-8?B?bVdqRVJoYlh0N1MrNTN3cHkvM0RKUEFKdjkwdjR6S1NUR0NLTGQ5OHV0Nllx?=
 =?utf-8?B?WnU0am1nTm4zelN4RGtTcWFVUDVQQ1RGNXh3TzU3QWZQV1BDOFJtOGI4TXpV?=
 =?utf-8?B?SVh4YWtNV2FlMkRGcnZNZEtNaDdFSExRQStHWUU1Y0V6MUx6d3NqTER1NGRO?=
 =?utf-8?B?akRqMnVVRzhkWUYrZlB1elhwbmxnS25zU3Awa2UzZ1RDamZsY0ZmZERUdGdl?=
 =?utf-8?B?OTJqWE0rbWNpK1VTTVBoanhpUVhDeXZ4dGtuL2w3c2NKekQ3OVN5VkFZTUFB?=
 =?utf-8?B?MmNxR2hYNlpPNUcxZGZxd3UrS084dnVJeHFXRjhjQnJRdHcxbTRtaU5LTTB3?=
 =?utf-8?B?Vmo2QXdLQUJ3bE8yK1laUFNYU0ljOFBnSS9jb1lLVjhTZ3Juc1VZZlZzSWNn?=
 =?utf-8?B?MDJWbDU5a1Z0YXB4WDJab3V6UGNDVGtRME9STFYwRENjUG41QU80ZWFxWVNI?=
 =?utf-8?B?U01YRStrQmtxN3k3bVNINWdNWFduYkRIUk9FUnlTc2lnT0xrOGQyNEdZMkF6?=
 =?utf-8?B?bk9XS21kdlhmMHVCdVBLL1lVaDBWb2ZQNjdQTURrZytRTEFzUmFUdE5tS1JD?=
 =?utf-8?B?WXJDbUZsU1IxTFV4a0Nvb1FUeFdNYjNzVS9EaDJiVjJtdTNvN245YTdrVk5y?=
 =?utf-8?B?K1prL09JS3BNNFRpSEtZMlhFZU03NWg4c3E0cXlaa0VVMEszamIyUlRDejln?=
 =?utf-8?B?US91T1cxQ3pBU3FSYlV4VDlTOUFKbnhmWXUxMUxEMFB5bUdBcDB6NlF3ZEs5?=
 =?utf-8?B?cXVEaVltOTVXb24vZGtiL2lVVHpVTXd0MUF4d0Q2a000NkRrcTM2VlJ0Rk5h?=
 =?utf-8?B?SUg2TWQydFE0aDIwRGt6Yy9WRFA1emlvYzdkZzNhS0FrQlhIeC9qUWZ5ZjBJ?=
 =?utf-8?B?dmZ4S0E3TmZUZ1Y3QmFKejhPWlFOTlNDRlgwZVZCUll5VmNmeGNXWUxKRWNo?=
 =?utf-8?B?T3NGQXd3OWNNNG5Od2RQaUIzM0Z5SzBtYzdQcmNWYnQyWVZjMVhISlIrWUZP?=
 =?utf-8?B?VE1PVllJaFRkTkliWEY4R2VoYXM4ZHBoem5IRlduUUpYSU00ekM5dWZyUm5K?=
 =?utf-8?B?MlhxODYzTjV5aDY3YjV1SU5uM3Y2Z0hkeVpmMFRUTXZvd2tmK3JscWFKKzRD?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KynFXCYz7oCIiDTOYe9nx6CVrMpszt63MAH78FuY7WK/s59I43QjeMCmsaUWtXfKNVt9P8o1+EbdqOM5DLQjNRZ2EQSaLaZ0wMy/tTFwCf4YOILDtQtdUuHlOrIHVcqUTL+Sfjt2ik4mJRd1rwANxRRr4wiNv/M1X5WKhnIKFl8M5n4wsJoFUNjDoQQ8ZxQEpbcfVsP8PSWVnKtc45GyAGhI1dAY+NDUlOtVSV9RtgEXJzTNo8zepe4vO4n7mm67mj8u5lrsRR1RVvUHpMruqFHAHiisMFMK+cBA3Wn0sodysI6WDIwdfTuR9eMzuM5BGsOo4ejdeqrNL+R9Ohy7TtMN4GfzQgpRvgxdQaXq7VLDGbWpa6Nzjak1Kb6hvp9stkY5hugIXB1cg2d5DxpSiZcxPrzfj2C0FVVQlJR7CEh/28GjEwfea2cbDp1I0PDzPpazamhpS1pijM0lCb06ewuuuUeyQEAalVASaF1mURIBDHaZE//xdigKRg9kuVqk8+8Cai9WKiHdOf0xv9MYnHVC6XpDjzbnw7Sdu8MJfy9BXRo2gJlvZhnQ7IUs+sLlwmcN3Uc5g+pZmon9Q112Texn7OJimbl3FRaiVRfjJyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333c6e88-55f8-4aea-6f78-08dca8f7a439
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 20:07:54.6807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0HbMgesilFfd+VwOGwbn7nWqb3FtK2CdlXjAah/l4EZf9tBko8zQFfFFOoL2YJ6QI7GFPn38bDN0gUhpTCJJujpIr0sMu+VAF84H4CwKsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_17,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200147
X-Proofpoint-ORIG-GUID: IdgIL_eopbYsMGP_Xj8mVhmHFh5CxXbk
X-Proofpoint-GUID: IdgIL_eopbYsMGP_Xj8mVhmHFh5CxXbk
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/18/2024 11:36 AM, Peter Xu wrote:
> On Sun, Jun 30, 2024 at 12:44:02PM -0700, Steve Sistare wrote:
>> What?
>>
>> This patch series adds the live migration cpr-transfer mode, which
>> allows the user to transfer a guest to a new QEMU instance on the same
>> host.  It is identical to cpr-exec in most respects, except as described
>> below.
> 
> I definitely prefer this one more than the exec solution, thanks for trying
> this out.  It's a matter of whether we'll need both, my answer would be
> no..
> 
>>
>> The new user-visible interfaces are:
>>    * cpr-transfer (MigMode migration parameter)
>>    * cpr-uri (migration parameter)
> 
> I wonder whether this parameter can be avoided already, maybe we can let
> cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> in the same channel?

You saw the answer in another thread, but I repeat it here for others benefit:

   "CPR state cannot be sent over the normal migration channel, because devices
    and backends are created prior to reading the channel, so this mode sends
    CPR state over a second migration channel that is not visible to the user.
    New QEMU reads the second channel prior to creating devices or backends."

- Steve

>>    * cpr-uri (command-line argument)
>>
>> In this mode, the user starts new QEMU on the same host as old QEMU, with
>> the same arguments as old QEMU, plus the -incoming and the -cpr-uri options.
>> The user issues the migrate command to old QEMU, which stops the VM, saves
>> state to the migration channels, and enters the postmigrate state.  Execution
>> resumes in new QEMU.
>>
>> This mode requires a second migration channel, specified by the cpr-uri
>> migration property on the outgoing side, and by the cpr-uri QEMU command-line
>> option on the incoming side.  The channel must be a type, such as unix socket,
>> that supports SCM_RIGHTS.
>>
>> This series depends on the series "Live update: cpr-exec mode".
>>
>> Why?
>>
>> cpr-transfer offers the same benefits as cpr-exec mode, but with a model
>> for launching new QEMU that may be more natural for some management packages.
>>
>> How?
>>
>> The file descriptors are kept open by sending them to new QEMU via the
>> cpr-uri, which must support SCM_RIGHTS.
>>
>> Example:
>>
>> In this example, we simply restart the same version of QEMU, but in
>> a real scenario one would use a new QEMU binary path in terminal 2.
>>
>>    Terminal 1: start old QEMU
>>    # qemu-kvm -monitor stdio -object
>>    memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>>    -m 4G -machine anon-alloc=memfd ...
>>
>>    Terminal 2: start new QEMU
>>    # qemu-kvm ... -incoming unix:vm.sock -cpr-uri unix:cpr.sock
>>
>>    Terminal 1:
>>    QEMU 9.1.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>    (qemu) migrate_set_parameter mode cpr-transfer
>>    (qemu) migrate_set_parameter cpr-uri unix:cpr.sock
>>    (qemu) migrate -d unix:vm.sock
>>    (qemu) info status
>>    VM status: paused (postmigrate)
>>
>>    Terminal 2:
>>    QEMU 9.1.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>
>> Steve Sistare (6):
>>    migration: SCM_RIGHTS for QEMUFile
>>    migration: VMSTATE_FD
>>    migration: cpr-transfer save and load
>>    migration: cpr-uri parameter
>>    migration: cpr-uri option
>>    migration: cpr-transfer mode
>>
>>   include/migration/cpr.h        |  4 ++
>>   include/migration/vmstate.h    |  9 +++++
>>   migration/cpr-transfer.c       | 81 +++++++++++++++++++++++++++++++++++++++++
>>   migration/cpr.c                | 16 +++++++-
>>   migration/meson.build          |  1 +
>>   migration/migration-hmp-cmds.c | 10 +++++
>>   migration/migration.c          | 37 +++++++++++++++++++
>>   migration/options.c            | 29 +++++++++++++++
>>   migration/options.h            |  1 +
>>   migration/qemu-file.c          | 83 ++++++++++++++++++++++++++++++++++++++++--
>>   migration/qemu-file.h          |  2 +
>>   migration/ram.c                |  1 +
>>   migration/trace-events         |  2 +
>>   migration/vmstate-types.c      | 33 +++++++++++++++++
>>   qapi/migration.json            | 38 ++++++++++++++++++-
>>   qemu-options.hx                |  8 ++++
>>   stubs/vmstate.c                |  7 ++++
>>   system/vl.c                    |  3 ++
>>   18 files changed, 359 insertions(+), 6 deletions(-)
>>   create mode 100644 migration/cpr-transfer.c
>>
>> -- 
>> 1.8.3.1
>>
> 

