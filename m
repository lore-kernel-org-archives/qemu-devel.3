Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B3ACA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uravu-0008Pt-Ly; Thu, 28 Aug 2025 07:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uravp-00084F-13
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:36:42 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uravm-0006Rt-Ic
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:36:40 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S7Kus52893289; Thu, 28 Aug 2025 04:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3yF+RkTzEJskY15DmAWCcxHBU7lZcaAA5Py4pflpw
 AI=; b=P77b9j0R+FHbktsbE9MfKncXeidLyhYdMGIgcojhfhuLa1pnrRVRhTkIw
 YJuwzM7GQyNwjy6xWYoqiYHuzrN9MjfoVUNi+DzBKASa4xndPzsrXjwOIu/abQBi
 KsmusaBESJAFPBHQ/9loqW41AYM5vyWs4vUZx7APFL/mwPuktgM6yzsceMBUAnwq
 4lJyMJvpXQUd3KFA1KNVZu4kbMZujbVkls72u5FpP72H5w2tQDDcvKQufX0qAEXB
 D41gyWC7tG8w57Wc8lLhbgbbIsRcdXxYPlQC3LDXWBlUWrULYRPLNq/QLniLQTfz
 tDxo72cnSS3LXvgJx4gr0Rpzj9ISA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020081.outbound.protection.outlook.com [52.101.56.81])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48t7sy1phh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ch9dtcn6m+zuMHuYQrAD8SvxpG+MHOBYgtxMHaVOEknpXuGz29QDTy98Ftl3tkPFLLoK03IYBR07Se6JnNbizYp8Pgl0/vcIG//6S47T7aF9iTNf3IoCa29jmyl8+qTKjgk+OXouB+oG9Bk7v3AmiMOIIJEVkbO3HJ21HO4xaC2mf7f/4OADYRPxz2+MOapzTjj4/iYC3f+Y/qVDr2nZYa0TMQ6YrgXQ6VFl2HOoBceOmOo3sUPyZprOgbgGYj6XfEHEG8jNJVUbjUuSo21d7WO6or18zTXiNmaTnOPrXLbeSap+WUHO3AmvXYzvVk4O2wIDjukW4vIXaOWRkQ7RHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yF+RkTzEJskY15DmAWCcxHBU7lZcaAA5Py4pflpwAI=;
 b=ITwAJ2Adgfl+fj9wAWLEA4ZAWO7+fTGon8Np15Sl/UO5/rP+ZICFSOH7BCbfFrV6B5nl7C3c3J2vIhXhLhCpInrfQf6CtL7nJQPVxsdPxlWfMI08MDLTC65QNwuEovbXPIXEkeDG8PCDIkNPzY9FhZUXKxa8O8XzUjCmNM/dkaiNcFKQdHrBXLsfiudqfFO52UHg22WdZgoiW1/aaJPK2HKemySdX3S08XkL2qgztZLznLE8IBK+zVjJH43T3b3jk5IfHxDRk82TYQDBkzhTR2OhD+LeyGUJnDn7KzQssV/1FVnPzsiQaTOyL4/Ts9WA+67bQqkpCwQMoYFek3J2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yF+RkTzEJskY15DmAWCcxHBU7lZcaAA5Py4pflpwAI=;
 b=TIFZdqJKPlffqrRbf3PQNbrMLnDtO41j4N5JLM9KYAeWnVtLTO7k5Cz+g4zK00lWAg9M9d9BF4QAZqyA8KcVa1yjwD5JSM7fIV7HJAQ41X+2QE9FYDEgqKwrXTmC4gkhwppoAiJYivo92Wbo0/bORYioLS2z/zIjfJkRsvaRLjVKzw8dKKkyFRyPgLA2g+8vO6OZ9DYzPWFi7ojwTgxUwXowbzgU4nMble0JpXOrIgdcrf4gfI9wAaUDI+qcfrVuP02EU+5vBNEw3PsK88Z21BTjl1wiRkqsqXhMYAGmzEArorm8wKCRIQqxSvWcwOcd4zWRmI0+fsU6p2qKjcrkfA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:12:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:12:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 19/19] hw/i386/isapc.c: replace rom_memory with
 system_memory
Date: Thu, 28 Aug 2025 12:10:02 +0100
Message-ID: <20250828111057.468712-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 172510a0-dfc8-4a32-f43a-08dde623b6fa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHJ1VFhqUDFYZDRuTUxWUzI1eGtaKzh0Rk1XOC8wZEIyQStDa3pVa2tGWm5S?=
 =?utf-8?B?L1FRVWM3NTVaNC9GN3YwcjBqVW5DY3NBR2NRRmJlek5sNjlJZ2M4OVJuZm8y?=
 =?utf-8?B?K3hicEI1SG1vbHNLdUFLako0c1Yvc2dVMkozd2NhREcwUEhvRVNlRlpRb01K?=
 =?utf-8?B?QmpxNlA3WDYyaUEzUnFuYmh6MXNxWUJXKzIzNGlFa2VQVXJqSmw0aHB0RmdE?=
 =?utf-8?B?YjVtYTVCZjNESWRnVHVocnEzeTYvMW1sVEtuMWowbDdod1hIVDMvVXZZeFJP?=
 =?utf-8?B?VS9nemdzd2x2L0pVVUk3OVQ2N0Q4UkZaK1UydFpqa0UzOUI3emtpeDIyUmpt?=
 =?utf-8?B?dmxKZ1I2Mm5jN1lXdVpVQnJ6QjJyQ0p4bXBFSFkyWVNxVVEwelJLMFhubnlO?=
 =?utf-8?B?TlRTN1JES0F4WEttbUhLSVphR08yem4rNlEzZG9IMndKWElBcXpGZ2pPWWR3?=
 =?utf-8?B?b21EaUVBK1JJWUlWU2JQenZXTEdlRFU2VkFhbFJESjFiLzF3K3JxL1Y1ajI2?=
 =?utf-8?B?MFFnWTcrQmRhVHNjUVhMVzlBcHI1UWYwYm1HK25aTDczWmswcG8rYUY4UVFw?=
 =?utf-8?B?aUptU2VUNG05cjRYUzhmdGdEazZucTZRTEM5aFhETzhVWCsyOXdoclpzQ2ta?=
 =?utf-8?B?M29xMWRBYnVZS2lRNzA0OGRNZUdGK0JRaTVvQkdPV1lmZEJKWTlaeXBVWHVS?=
 =?utf-8?B?ZDRJR05sRlFHeUZHT1JwL1hxVHJGcVZ4K09xL3h6b0pWSHA4WVZjWWpXd3pi?=
 =?utf-8?B?aWVmeHVYb1ZDUzhHeVkwL3ZQdUx6YUdRdkM1WjJlbDd3Mzk4ZDYrdzhjTkN6?=
 =?utf-8?B?Nm4wd1hQYTlsMEhHdG5xSVA1SVlPRWNrV2llanN6Um8rYnpXUGtIUWs5azJi?=
 =?utf-8?B?U284ejhnWW1wbGxPa05CMFcxcWZwZ2FiQ2NpcTJ3bW9ZeXBOb2NDaTVuMVBL?=
 =?utf-8?B?ZlYycU8wSkc5eDlWM0JDZHNlZnpzTEhXYkxyQ2N1a3FuL041QkdpejlRS0Rh?=
 =?utf-8?B?dHpteUlBM3l3aDRGTEtZUFZFQ2NhTkFVbDBEQkM5SnRreTdzSTRiQ1NKYita?=
 =?utf-8?B?cFZnL2ROQ0haZ1VaeVNKOW5WQlRrNG1sSzkxZzliRnN0dFU0MTZvblhTaU1B?=
 =?utf-8?B?cUpHNXJLcDZIellBS2FETTdJODFvQlYwWkxDUC9EOFZEYVloRERYQ2FUTm1D?=
 =?utf-8?B?WkpZdVovUXZERGZTSk9SVEY4MEtKQlRPaVZLc1ZPVVNxbDVPeS85aVJSaUxL?=
 =?utf-8?B?eGwzVTB0L0J4V0haclpwZVo4MlR1OHJOUVRtSHRQOXB0eW1rTEl1TXFleXlQ?=
 =?utf-8?B?ekVlSDZkUkRWamIzbWZqc1hUbW56cFNRamxRSU1ER2hBb1FxczJwNXNaNTBY?=
 =?utf-8?B?SUlBd09MNGEwQk9NWlozcmJLbkZxb1k0ZFZXT1VBOTZ1ODA0QWRDd2xueXVM?=
 =?utf-8?B?dWRuZCtQUGNac0pCTkduRVlWdEV3QXZPSG9jd0NLbDhRZVZBeXBaYnhtTHp2?=
 =?utf-8?B?dVFiRGNWNmJDRWxINXZ2aXRHMVBLWkhLeVlGdUgzclNkMjVYQ2YzWUQxelll?=
 =?utf-8?B?QTNvKzA3LzlRMFM2Y0J5eHJKY0grdnJrdUpBRS85UnJGY3ZvS0h5aG1mYzV6?=
 =?utf-8?B?dHN1a21NcTFsd2I0OWJzTEhzRnF3ZXhHVDNhMldlVDRSUlZ5bGNlQjRZQXZm?=
 =?utf-8?B?dCtCQm8zNU95bE81ODBOQ0VNaHJqOXpCT3pxMGtyVXo2V2lBSWNNNnhMbVFw?=
 =?utf-8?B?SXB3VmdsQjc0SGR5SWZQaUcxaFJUU3ZKZUVHbDhDek15TkVTRGl6SDdGUlNP?=
 =?utf-8?B?Q1d4Q2xtbkN5SW1qUnhhTkI0YXBZMFhYMnFLSVQvRGVXZUI0ZUlEYjM0ejQx?=
 =?utf-8?B?a0Y3eVhNaXpqU1NvZHB5TDFCaElPTFdwdHYxUTNXcDdZcUxzdDI2Y3NhSUVF?=
 =?utf-8?Q?JdwrYFLZBuk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFub1NMN2wzMFkrU1E5UkRPLzlEMEoxSXkrTWx0bG05MVNPSnBCZ1lCdS9U?=
 =?utf-8?B?cHlRVFVDYXJHMy9XV2xXNWJZWTNGaWcxT3JPMmhYV0p5SmxnNThub05UamJP?=
 =?utf-8?B?RXhEMDlYd3VKaFNuK1BYaStRQ2o5bEszcEQyRkhMTGVHVU81OTVJT25KeXJ4?=
 =?utf-8?B?ZUtJcUJ5V3BRbTlsc2M0VmNUWThhdjRtSmd1M3FYQzRJcW00TnJYZzNMRHRy?=
 =?utf-8?B?NzJrL2VzeG84VVg1c2ZYZldqblc0aFZSeWw4M3dMcWQyV2t4eUthM0VSZmdw?=
 =?utf-8?B?WWRaK1BiS3Ywb0MvOGNYQkNxUTl0SmtwNFlSdFR6Z0FXOTJCcmVtQ1I1OHlT?=
 =?utf-8?B?K2JBVjBmQ0tpdHZFWllJVHFMRjgxQTlybHRkRGNpQWxjaG8zQUVEZCthRE5S?=
 =?utf-8?B?ZmQzVWNheGRnaDk5MXBtbi9LN0VueENCQTBSelkxSHVPbm5YOG1Jb3JZUUVa?=
 =?utf-8?B?T3BCd3hKZFpFZDhTT3lXWFh3NExVMEJKTENQbTd6Wm82V1ZGUlJjOVQ5KzAy?=
 =?utf-8?B?dFlWdk5IUWJUMlh0bWd5bHFQS0RyNzJXWDZ6cUF6RE45dDNCRjBtL3AvaTVP?=
 =?utf-8?B?bmlISDdyVlhSTTJzSVJKZ1JYSjBQaDVoNTYxaE56TUNuRzNkSTNIcjVkMjl0?=
 =?utf-8?B?MmxxaHBYZFMxenpENVdhRVpMb2Q1T3g5aXZISWVZK2hwVHRucXlBNStMQzRi?=
 =?utf-8?B?dGpIbHNKeSs2Q090anlrUEpOeFhwOFpsNEpSU25hS0ZsWXF3aG9BM08zajRN?=
 =?utf-8?B?eVBRRnlocGpacXE5SlN3b3YzMWo2ekNIRmVZalJaRmJNWnZxOVU4N1NJNzlF?=
 =?utf-8?B?SWVjaHpjOUNDdFAyaUdGWHFLUlBDVWVmRFJaSTdubllqYXE5TE1rbHJtVUFT?=
 =?utf-8?B?aVFUNGJvZytMM2xPeDkwK3YzR0dsVVNYNlV4bFcwL09wOXdEb0dRbkNvaUhE?=
 =?utf-8?B?MnRvcGIvVDUvdUE0WmwyNjU3eTRaQ2pmdUN1ZS83UkxsdjZKdTZhbmVUbDFI?=
 =?utf-8?B?OC9paWIvcW9weU5zR0ZiMVNzSG5DK3hYVmVXT0g0SmRCSDdHTTJIR3NHckZS?=
 =?utf-8?B?TkE5WGt2RFNaMjVLdktGSUJwT2lrd0VpSWRlcHdMOGI2WXB0NitmLzdxYlh1?=
 =?utf-8?B?WkxYRCtBM2o1WWU3V3pobjZWWFJ3UkUySmF0cWNtaFVrNDdrNndIVmt0bHZW?=
 =?utf-8?B?TXU0WmRMMkhzTldaenZhWEhpUGxYNkFtZGNFOEY2NGlzU0JQdldLNWZRNi9K?=
 =?utf-8?B?UHFZN0FHWmE2TTZtTU9qTVFURmM2SDRTTFJPLzNoMUpndDhHTFlNSEtWMUNk?=
 =?utf-8?B?VHEveERDTzVYcVJOemFoa0IzNlJXVWZQb3lrRUlVQ2c1bkJDSWVYby9pY1Y0?=
 =?utf-8?B?anFubWVRdkYxTHg4c3dLSUVxRFhLd2t4SmFBVVdPM2dZWkRDUEdNazYvbTNQ?=
 =?utf-8?B?QUhwTERHNW5Zd2RhRFJpZWJqeTZIODd5TVhaTmQ1SmYyaGZmOWUwc0tzSEJa?=
 =?utf-8?B?MFFZc3lHQm9EaTFtaWc5S2paWkkxK29sRXNpY044dlJybmQrTEkzbEY2RFhU?=
 =?utf-8?B?eWpUSmYvOHB4dHF2ZUlwSXFjd0htVlRHdWY1Z0VmSmJ3QVdSL0Z4YytHWXIx?=
 =?utf-8?B?RlRxbUt5SC9zSm95QmgyQ0RLQktPbC9TK1NjajNiaEl6bFFLL3VGanpjS083?=
 =?utf-8?B?eVA1QlR1Wk5FVkZ3Z0crUEJIRVlnM3lqNGFHTVVqRk1vdjB5aFlZcVRsd0Zo?=
 =?utf-8?B?aE5aUTJpeVplWWlhZERJRHozL1dWUjFQVkV0M3JpZ1RmV00xSEV3TVBXbEp1?=
 =?utf-8?B?YTlZTkN1UDlPaExXVjB6WVJIcGhaUXNEUTF2ZnVwV3pGb242QXV4TWMyK2I5?=
 =?utf-8?B?ZHhWS0RWc0p2TTl3SmFhNnpLS3Q2cEtRa0FrcnVFeVU1V243THpZd2QvVnZY?=
 =?utf-8?B?OVBEbkVsaEZKS3p2aGMrTTg1NmVHNUVxN3JKSU1MWE1SYTZHRkhpVkk4aTE3?=
 =?utf-8?B?S3cvUU95c0JBdzJ4cUpuY212YURZNmRtUUg5dmJnbTMvS2E3a0tKQWVQNEdr?=
 =?utf-8?B?RXpiVTM2cVNOaXJoVkJESmlscUx4VDEyTGlSMm8xMGdJZTNYTHBsVHVZKzJx?=
 =?utf-8?B?WG1aME11b0tKYmFiOFR3dDJFZ08xV201cnd3Ry95NTRXa2tDcWxoSnFPZ1M3?=
 =?utf-8?B?M2g4dndJM1QzTWwxdmcydGhoOXpzTSt2dmNacHM2bVhJcWJsbFQvY2l4WHhY?=
 =?utf-8?B?aGJsUTk1TzZidlFmaGF6aVJMZCt3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172510a0-dfc8-4a32-f43a-08dde623b6fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:12:02.5329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16Jhguf5Eg7AYj0wycBBfvwdmc5TopPnBx0UCTk4qU6rRn+q1RjSVt6WgZvIWXaKpooi/ySseeZ6i2IftX3nnx16Zv2928OYpBqe5qvkPGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfXwwo478j8Gwhh
 8rThNHBHFWCUOvFsUojeBe3QUGNAVZJu6dylxQ5Ut5AWNlNC7ocgasgMt7zhsbroCDkmlFpJgd9
 JnukOSSSZ3oXSvLLWk7dW5g/GEKH3QDdecIxBy2nivE73lyMjpn+zoaCCYQxToaIiGmfXCO/Nk/
 Un5W5ElEAWrGZV/nSYtu9Jz1XU9sg3X7+r32Yo9XMcBFecLb/yxtPyVS4NPSsmgXKYzSXY0b2oS
 agQ/+syWADX3EqskR2tZMdYBt3fNMZGkkBmyb30L7hTRWSE3oGj39YAhkhYDjrykTbWbxtnqkjx
 uXh6qFkizhX1QOBjbRSqmiRwbzd1YsbFg857l5WPHLbwsbmHjzu+K2PuQgZN1Q=
X-Proofpoint-GUID: pb8CtKTy3ODHEGFH5K4APhPQv5wv0gyx
X-Authority-Analysis: v=2.4 cv=M/VNKzws c=1 sm=1 tr=0 ts=68b03989 cx=c_pps
 a=H8KQetTyUVx2NtQIo3bL5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VVXk-92eaM9LjyQm6BwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pb8CtKTy3ODHEGFH5K4APhPQv5wv0gyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that we can guarantee the isapc machine will never have a PCI bus, any
instances of rom_memory can be replaced by system_memory and rom_memory
removed completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/isapc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 300d64b7ad..44f4a44672 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -38,7 +38,6 @@ static void pc_init_isa(MachineState *machine)
     uint32_t irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
@@ -94,7 +93,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
+        pc_memory_init(pcms, system_memory, system_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


