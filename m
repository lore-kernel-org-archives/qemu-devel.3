Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7611EEDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvUI-0005bc-P3; Fri, 13 Feb 2026 10:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvUH-0005bF-2z
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:53:45 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvUF-0000Hj-CM
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:53:44 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DEwXru3415830; Fri, 13 Feb 2026 07:53:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JLe/CAgAtLHMOirYhDIyQNqDmqaCKGybiIgO5/SG1
 5c=; b=E5tAzT77omujRvHQ5nWMATXd6DjcSDxoWCsa7H7WGGeE+3568592QZAA8
 I9DB+G3jrYx9Cev+xdSsn3DjkGwtPwU8qtnnLFenq/CnPHkP0REmeRB1NPPPsd6M
 lBv8roMMAjkUhiGUWpgdkLyZKV9mBp2TsSKxz9oRr4+OEDjQQwux+Y7ede2galDN
 JQCGoxHqLLgEU+puxhGBXn6APNYEMs9BI6EghSqvDz0DBi6QUKGjzOxm6N2vBxMq
 WLUmtEHR0zlYNTByiYv4N1VesJH+U1vCXDM5r9spZocFGpUB1bJD16aSRAV+wxgf
 ccG+roYF8b32kxudVt8m5VPIaBbfQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020090.outbound.protection.outlook.com
 [52.101.193.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9jp9tyq5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:53:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSHtAW7Izp/U92qCnWrGuGGDpce6O/hp7x2kz0dZfUXHqvHZGKLUbAqz1u+KIO/vf2adXsdPhlp7/48jK4B2TwwAJ9khNXUxuOjFqTcCVDDI5CPaaYIOLdpp9WRD1YvPurhSur6GuqgHB7nqgs63Jnqe/Bq/FdLVVJO5WGDF2WCLZJX7p4tAOizFbZ8+zxaAyOKqhtC2iMmY//GGMUzNlS6qHhfoMy31JIy6+RpMpZB75kqVR4fO9gpVzob9ibryEPVPIeg5PcZO8zN6+ntY2xgcGZS/tOOlaPlMmqKyJPv08US0GtoW65jNyLZn6FgZsJNnNBejcTT65/yNIqrt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLe/CAgAtLHMOirYhDIyQNqDmqaCKGybiIgO5/SG15c=;
 b=LIguljcRORJ8fp9ur3oJXjNt5zcobJ9Q3ibwZjffS7epUKZ1kQnZ8Edd6m934FEsNhyA5etn8KoxTLR147oGHnvjfFlyu5TlN8clJ9vQoNCGIDmdCKjGegsT9kH49r985VeJ4pnCTq4grxgu1N7h/SwJlutPLaNZ0J4NxRQ8cY1d6GFf8R/ty53Pcx2JV28zuNP5Cf8p/fSdCCHWR+v49P/2Zhxkzkpqjmbvm+ZBua3qL3UVXuEfy9Tew5Mz1soi0pPk0L2vB2WvzBZdpTXL1gu3FKwMlpLqODki0tHAK15vL8eIfsWMaFmegtyLRUWAqWv/z12mmUGoKbwFkd2d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLe/CAgAtLHMOirYhDIyQNqDmqaCKGybiIgO5/SG15c=;
 b=D2CdLbBEPJKI7lXBUMfpj7sRLkFyW+8Y25yQslEMSopWufqJH8QD6waFGw2jT3CNw5QEJGriGpDouMDrnm4m9aIfgi0ko0g5kLAmhaFK4jfiVYxd3CizF/LIf5L15jlfudjkELDbs84jQw84YTYxLizKUkNquP8LkmeOwv7cAIHtF72nNjdv9Z/vMKStHY3WgZN3nI1pV+K35tMbaO0qB5lNswApN1lXiT0BsCc/0BXS8ic6pHbYv9d7AGMpfI7/UCRRHHlq8YFxEODsr9efBHl+KZXgf3ttWnS5AaPL+xPwDsnrfqcT9RKaqvNfKFW6raKz2ctCOrMtTWG+IM/LzA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB7866.namprd02.prod.outlook.com (2603:10b6:610:ed::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 15:53:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:53:38 +0000
Message-ID: <b33ba3b9-0808-4b13-b8ab-4981212f228c@nutanix.com>
Date: Fri, 13 Feb 2026 15:53:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/43] audio: replace DEBUG_CAPTURE with traces
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-36-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-36-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:5a::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: cedc1ba0-9230-4cca-9e1d-08de6b180d40
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anpzMmpXbThJeVlyczhLRmcrY0xRY25wZ094d3hEZHB5TVhjTGFXdEE4RXdm?=
 =?utf-8?B?RFVDOXdQWFNLaVpzLzFYQkFoUlBFbDVjZnlvSVVHbGhNZi83QngvL3daMGNG?=
 =?utf-8?B?UWdod1Awb1c3V296dWhPUkdBZHllRVpvVGxORi9MOTc5aTdZaEZQWndrTGxL?=
 =?utf-8?B?OGd5RE9QWlZ4b1c4RVlXNE83RFFjaEl0cWJmQ0NOYW1OMlZrNzc4cGFhVFdF?=
 =?utf-8?B?eFd3MkVXUTJQUG13V0hRRDlmVG9MaDFaUXVxalVQRnA1M0RaZUkzU3VMMXht?=
 =?utf-8?B?cnpuMlg1WWRVYjVGWVUrMGllMTF1anNQUGpScVJ0ZkJFa011K1pxRllYQ0pn?=
 =?utf-8?B?K1pYeC9zL0ZtVEFkZHEyc01Rd1VDS2ZwM0NpWHZ4K2REN2Fwd1hZOXhpaE43?=
 =?utf-8?B?azVTajd4bXlUTWgzWGN2YzFnZjQ2R0FoSTZwblYyNmxldVljVGU1SEpxTzlz?=
 =?utf-8?B?SDMyTEt5eDJKMTFDbm9EWFpWZitoM3hjdWlCU1hVZ1lXZ05HaElxYmw3SUsx?=
 =?utf-8?B?L0NOWTNmRUpEdVorR2JKcGVTUitXcVNDZDlGRGlIR05XTFlRVWtHME56QjlQ?=
 =?utf-8?B?K3hsdVMvNjRHN0t0YTNhYU9pOTBLSXVRa294U0llcTJFOHQ3SndxZ1FOWVJK?=
 =?utf-8?B?b3ovT1ZKOEUwRnpFeDZjVHJaMkZKK2ozcnR3Rlk5Y1g4MXF3TEl1Z05mZ09D?=
 =?utf-8?B?U05JdmgvYnRCUDV6RmJJYUZxQ2Y2R2FweitNRTlCMC92THdQYkFuSWQwdE1U?=
 =?utf-8?B?ck5QVGtuQThxdkVtU2U2Rnppb3NrMnZPWkx6Z05QMjNDTUJjbUZZNDJuSHl3?=
 =?utf-8?B?SXN6YkpVUk9Kd2JrSG1xeTl3SStrdnY0VkwyRllSdlNPZ1lCZmJUVVhVajJw?=
 =?utf-8?B?Rjg2SXg5RG5FNzJQM2NLVW5JdStRZEhXN1VZTlJIclJ5bjN4b1hVa095RDc0?=
 =?utf-8?B?U2xqeUR5ZFA3K3duSDRxUlErdzF4Qm5WSWJvdU9DRk1iSGs3MFRDc1ZYNXJt?=
 =?utf-8?B?L3J5bExNNjk0N1kwL0pCU2ROVFpSelpNeEQzcmluWm9zWU9ZTXJFUStpRUhZ?=
 =?utf-8?B?OS85cUNSN01uZlAxOUtPUmlCMnlOUDRRcWNCSnZJY0k3NmUwemV5eXZFcTRa?=
 =?utf-8?B?dC9paU04ZUo1VGdpSnNwcFlHQzRWL05TdWVla2c1TnJoaE9ibVFEcjRhRlhu?=
 =?utf-8?B?eDZzeUc5bDAzUm1GZ0dwc1ZLNDQ0SmVVY01ock5zZUkvUytzaUMvQ1h3RTRK?=
 =?utf-8?B?NFc2VW1hZ1NDU2pYWURpLzdOdWNDTEZuSHlKakY4MGVNU3VnK3BsUUVBK1Zn?=
 =?utf-8?B?WVdmOUxra3N4eFNCWlRxYTVnTWd5bUU0MG5FUnJrTTJ1cFgwQWpQY0NYekhy?=
 =?utf-8?B?RWRnMGhFZC9mbysrTTh3azlaY0oybHI2OG96a2FyMi9wRUhIWTRsV2N0Q2JQ?=
 =?utf-8?B?ZFVNaEdBelc3UWx0Vk9XR2xtdlRKSVJZU3g5YWFuamxNTjJlME03VXhiTDIy?=
 =?utf-8?B?cUkvazhNMUlYNXJMYzMxTy9wOHA0VWtXU1VibS9UMlhUNitEcmFyR2Q0Zkov?=
 =?utf-8?B?ZGY5N2xVRlg3OFc0UFJ0eTRzY01XbkFaQ05pTTQ3UFpoSngxSEgrMUZOWXY4?=
 =?utf-8?B?UjFVMmNDaXRBR2RPVmJhM1VkVzJ3WTBVUWxnZWw5am1sZlFzME04VVZLWXdV?=
 =?utf-8?B?bjZ1TDQ3SGJJYTBFVllkQVU1YVNvbnJFUWFGSlBrU2NTUjlKbkUzRTFqREtS?=
 =?utf-8?B?d3ZMNm9mY1NORHBPWE9BeFV3Nzl0dDN5NGdtUWJXd3B4aFZqK0s1VWJmOVBr?=
 =?utf-8?B?bWI5b1B0OGpBQzU4dWs1NlZsUXBtZFYyYWtOUU5kKzZpMGtXcnA1SU5KUkUv?=
 =?utf-8?B?V0NoQjdUdmdWWDlGeHQ0Z1g0R2NsWno3SXZUbnd0TXpEa0xuWWpFK28vWTFO?=
 =?utf-8?B?aW9KSjZhQU5ZSWZwOFN6WlRmK1F6NFMxcUpFaERKdHFqZ1hLelkzdWpUSHFG?=
 =?utf-8?B?dUNEZERDR2pXdlFGN1hwaEdobzZDc0g1S0pUL28wNWxROHN5aFlzMk9GcFhR?=
 =?utf-8?B?SS9RcUhkMDg4TkQ0U3RNc2ZxSElSZXJETk44TS95eDJyK0pkNDVTdm1QTGdW?=
 =?utf-8?Q?Cq4Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdReDB1a1lCWUFsa0ErMzdibkU1d00veERlMlFkSStGcmJ5dStyU2lmbis5?=
 =?utf-8?B?TlhLbk53ZDlJQ1lWTFg2bkdkcWliUDFVU2FBN2p2MVVydEk5RTlqTVllNk8y?=
 =?utf-8?B?MXNBYXFUY0NtWUNiMTQ3aEtUSHYyb3hDcWExQTRYaEhvMFJsbzlYb1MrZEJH?=
 =?utf-8?B?RDNRSFRxQTJOeTNNS1Z6OVlyOWx5ZmZmUE5aSHFpVEZNbERiWFJ1TEpjTWl2?=
 =?utf-8?B?UkMxN3hmTXkwRFBhSlVKOWVrRzJ1NEVBZkRWcldSRkhxdGFqZmo2cmFOSW0v?=
 =?utf-8?B?dXdNSmcyWFFxbVI2VjRiN1c5Z3NURXgvdHN5elQ4dWhsZ3hKVlR5R1NOQnJF?=
 =?utf-8?B?NFdqR0tjdkpJNFRxdE5zSEM0Ym83c1NIaEc1MjZMeXlzZ2F1ZSt5dEZWd1Rx?=
 =?utf-8?B?a29xTUkwWW1NWXo4eG1UdC9mQ0V1NEJkTFZBL3F3S25SQmJVNCt6YStqYS9G?=
 =?utf-8?B?Zzg1OVpMZ3V4SE1sT1plUVZkNDNMajc3TmVvVDdYUEx1N0lZQk5wY0lIVHR4?=
 =?utf-8?B?ZG04ZU9KdDIyRWJmZkZZV21wbmcrTlAyK1BCd1FNQ0k3SzhwVXl2MWFDUEta?=
 =?utf-8?B?STVmcnVNbk1saTJKUHBtTUZNSHZjeHhQeEpLb3hxZXRrR3hDNmxnV3lIUHFm?=
 =?utf-8?B?b1RaTHVobTE5SVlmaUtpWnZzNWs1MEdDNlc4TVZSQXU2a2Z4TnVibXQyc3lk?=
 =?utf-8?B?YXM5VTdmcHArc05saUozVGU1R2JiUDI4b0pFN0wvT0tybWpoY0dPTmEvUEFO?=
 =?utf-8?B?SGF3K3N6R1hWTjFCWUZMQzlqdjBQeXI4N2JXd084VEJYTDJ1QkFvRGZadG5P?=
 =?utf-8?B?VkNHbXdFZ0VmaUZJaml0OTM4dzN2TVp5R2szczZ6RURrZng5R3FJZlJtRXJP?=
 =?utf-8?B?bHJhWFpKc2N1d2tWZEtpaGppZG8vSW9EeXJyM1hBRFE3dk5SWW45YTVYWTdN?=
 =?utf-8?B?MUl6b0RiNlEvTnJjRU5BbzVWbTRSb1ptVGhsNmFuc0V4RStwa3hHcEUwK3hG?=
 =?utf-8?B?OEFXSm15SWtkdFVvL3ZRbWgrREVDYTZxL1ZMbmJHL3psNU1VM3R4WmpMR0da?=
 =?utf-8?B?cXRLSGl4WGd4SURzaDhvUDJKZmx3UkFKNld0Vk1oM3lIeWlVUkM4RDBXeE1w?=
 =?utf-8?B?YnJBcmpiWUxxMVVSUzhtbjZTcHh6NnhGTTJSRlYzT1phRm1LbGU2OE5oQTVX?=
 =?utf-8?B?VHJvbGg2SFlGZGwxTmVBRzlJa2Z6REozUE1XWG5Ia2lQUlgzTy8rNmJtTGtu?=
 =?utf-8?B?WXNwVWp1ekNIeGhDZW5rSkkzQ09sV3JJMDhJOW52VmgzWFZGY3h6eUJHd2tp?=
 =?utf-8?B?V0Y3bnU0R1lXL0JVb0VWM0tCRUZzaTVzQ3FtZGNvZW50SDNPSkx4bG01SkZP?=
 =?utf-8?B?WXZWVlhOOVFxUjIxZS83UEhsN1RydjdQUEh1ekwybnVJUnN6YkZpa2NZdkti?=
 =?utf-8?B?akJqV2p5K0tmNlAvbWYwaWpCYkU3Q3dDRlhhK21nSEdpN05JNXA1cGU0bTZE?=
 =?utf-8?B?ZkF5bGkyU1g0VHBEYkxrU0V0UDl1dDd1SWNKRFZwSDdNcDhsTTJWYm5rYWNw?=
 =?utf-8?B?S1h2eEVtNmdLWEtjR2NIWEQyWkdEL3BtVjQxb3dSY3JZMTJrVGpRcElpMTJi?=
 =?utf-8?B?VC9TTkZ0QnpuREtHekFVeXFLZkVmU3VyalpWRUFGbWVCaEUxOEx1NmROTTBJ?=
 =?utf-8?B?Uk1KRSt0TWg0Qm5hZWhqS29qQVY5TlM4dis3L1Y3NzRnb0V4U01WMk5qS29x?=
 =?utf-8?B?a2p4dXZNczJBU1hULzAxck9MTU14ekZ6dDVhRjgwNGpLT3FsVEgrdUtwTTJv?=
 =?utf-8?B?NXJKUUVNNmdkSGpxMFlwS3NwOGZWVk9ucTdMcStNUCtXZGZlbFI5MURCUnla?=
 =?utf-8?B?VmV5TmUzTmQ0cStIeDQ5ellERHJNNjZyUUJOeFNRMWRDTHVyT0dURlpxeUVT?=
 =?utf-8?B?Smc4QTZReFdHMWNSSjdXbllmbnV0dkY5OVR4UjVld2xFZFNIUStPczRkdkNU?=
 =?utf-8?B?WUdpRWRWbFdRUHdvQkIzWkg5SURNNitvTXJXZ284TEFFVGVoQVJpUDJBUlgz?=
 =?utf-8?B?Z040ZE90Ym50TVFXT3NQcUFLWjZBVEs2OHdTSndTWWQ3NTZ3TE94YUpIbURz?=
 =?utf-8?B?cE9CZ1RFZENNWDU3VTdXaURxcTBWZC9iWWJ2MytxZkZkdEkxKzFSNnZCS0xD?=
 =?utf-8?B?UGxHZE45YU9TRFZUSm4xWWEwTlVlSGRlM3BRd3ZkZU1FcTJoNjVDNXZpV05z?=
 =?utf-8?B?OVNTMU02dENFcEN1QVFCbjNGd3p4VUNpdnZXOWNjd3hkcDR4Z2pnYU5Gd1NF?=
 =?utf-8?B?cTR2NUVyenEvdk5jVmFxL2pYZFVHaWQvcXJHV0dKd3JqY3V4WkVBYW5VZk9r?=
 =?utf-8?Q?I3G6rch1oC0crI1g=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cedc1ba0-9230-4cca-9e1d-08de6b180d40
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:53:37.9799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QP/VIw1UcVu1zj8v/jrHIWJHr1+niIGM7B4k9sdXA/PdhEvMCB30iT4bnooJU2FpJPLfPFc/xHroHUyRmk7GbRsASyu3cgJBcSCIe9mTQRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7866
X-Proofpoint-ORIG-GUID: nyFpgzAk15HB3gwcml45uk2X8VrouMOR
X-Proofpoint-GUID: nyFpgzAk15HB3gwcml45uk2X8VrouMOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyMiBTYWx0ZWRfXyCKkyDBzJivJ
 txzRpct5zp50f6GizDlcUGwH9C2Exn+DqqGLSXXraB/sg6/TSRjhK5ArHwsr0iIdM5Qsx1SY5ID
 O6L/mhKlUFmEuFgbz80UzAlzp0JgbEaqzGMZtEg5aivhqYxNY8dk/oxhhsLc32TTS1Khlu57nVm
 dXUHZVdE0CG3s5lkRwNrdf3mayCG1lwWAz+7z1s/o/bRmvhoqkPTOZMXE8A9rTzjWnhXPqgXtU0
 mAYNkuJpXD9K9skAiwtyw/w13ULujr2cV/5KSQKhvMTnPQWRt2Ag7erYBzI5X4Ka4916vJngwxY
 EfC6i13Nyv7/6I8rfobO8LE7/nYZSvyqc63XcorNB+oy042DMN1VvjHPGw4HqAtYTjoVmdaHA1U
 qA2vDs0cI7A3dAGsMsAoa6Fa1GGj3GvFYKLe/+edncr06PAQ0GtaXbmD3YjnMBcwN3fex0bYXzG
 oI4jgzOaLsJonNGLe8A==
X-Authority-Analysis: v=2.4 cv=SKJPlevH c=1 sm=1 tr=0 ts=698f4905 cx=c_pps
 a=hTY5Tzxx0J6bc07E+BihHw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=tObGzaUTSIctz3C0i-QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio-mixeng-be.c | 20 +++++++-------------
>   audio/trace-events      |  3 +++
>   2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 1b2c1fafa87..c3234aafb1b 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -30,7 +30,6 @@
>   #include "audio_int.h"
>   
>   /* #define DEBUG_OUT */
> -/* #define DEBUG_CAPTURE */
>   
>   #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
>   
> @@ -249,9 +248,8 @@ static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
>   {
>       struct capture_callback *cb;
>   
> -#ifdef DEBUG_CAPTURE
> -    dolog ("notification %d sent\n", cmd);
> -#endif
> +    trace_audio_notify_capture(cmd);
> +
>       for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
>           cb->ops.notify (cb->opaque, cmd);
>       }
> @@ -333,12 +331,10 @@ static int audio_attach_capture (HWVoiceOut *hw)
>           sw->rate = st_rate_start (sw->info.freq, hw_cap->info.freq);
>           QLIST_INSERT_HEAD (&hw_cap->sw_head, sw, entries);
>           QLIST_INSERT_HEAD (&hw->cap_head, sc, entries);
> -#ifdef DEBUG_CAPTURE
> -        sw->name = g_strdup_printf ("for %p %d,%d,%d",
> -                                    hw, sw->info.freq, sw->info.bits,
> -                                    sw->info.nchannels);
> -        dolog ("Added %s active = %d\n", sw->name, sw->active);
> -#endif
> +        sw->name = g_strdup_printf("for %p %d,%s,%d",
> +                                   hw, sw->info.freq, AudioFormat_str(sw->info.af),
> +                                   sw->info.nchannels);
> +        trace_audio_capture_attach(sw->name, sw->active);
>           if (sw->active) {
>               audio_capture_maybe_changed (cap, 1);
>           }
> @@ -1707,10 +1703,8 @@ static void audio_mixeng_backend_del_capture(
>   
>                   while (sw) {
>                       SWVoiceCap *sc = (SWVoiceCap *) sw;
> -#ifdef DEBUG_CAPTURE
> -                    dolog ("freeing %s\n", sw->name);
> -#endif
>   
> +                    trace_audio_capture_free_sw(sw->name);
>                       sw1 = sw->entries.le_next;
>                       if (sw->rate) {
>                           st_rate_stop (sw->rate);
> diff --git a/audio/trace-events b/audio/trace-events
> index d66a712e871..3f8ebf9c6cb 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -58,10 +58,13 @@ audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
>   audio_timer_start(int interval) "interval %d ms"
>   audio_timer_stop(void) ""
>   audio_timer_delayed(int interval) "interval %d ms"
> +audio_notify_capture(int cmd) "notification %d sent"
> +audio_capture_attach(const char *name, bool active) "capture %s active=%d"
>   
>   # audio-mixeng-be.c
>   audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
>   audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
> +audio_capture_free_sw(const char *name) "freeing %s"
>   
>   # audio_template.h
>   audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


