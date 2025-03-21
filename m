Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75905C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVUA-0002Ji-7w; Fri, 21 Mar 2025 02:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tvVU8-0002JR-DV
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:04:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tvVU4-0003Er-CF
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 02:04:00 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KMlSPF006192;
 Thu, 20 Mar 2025 23:03:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hz2TOoEa98XWHwgQoA+bPDNfquHoZQbors+F1lUwS
 S8=; b=QH84f5gdcrQhYkw61HPhmj9dJ3/Yt043c0lD36F8Gp9qQ/ldNOwHEBJnI
 L+i0Tgc4PFWekLP7nMw/CbQym/EcqMP1j78PK2Lcoh+46ja7b2Tq0Mv9AruKKr9p
 wT0eK1sz20UDU25N3oO3AXP8ZBele+aHLX0DHseCFRUm4YybZTOJjCE4+q7fwerR
 73LxWrlBAxgvHqQ2CL1q1w4kL6APXq/ENXzoMj5tEJH7RhlVyncCKulJD/B3dFlM
 1M/l3jUqPVFLcnQyDQMkY3hAKHQL5Pk9VMQRFObJLzje06VTeuCTzgWsvEYV4oMw
 Z3pJrS3KPeWcXGX7r/lMRM1qIoayw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012050.outbound.protection.outlook.com
 [40.93.20.50])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45d8mfyd6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 23:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7PXLFFu7vkqrTbR2pUcrX81Leb3S6fUjUMDo/rdqji+MaLxzuxDg+LhNAaIOTGEGaLnYikOVEpJW3uB67bSlvi2+VMTQkwkwzOz7DnrY9gt/fWczohFqBPHObmBkcVUyH/eE2pawXBQXFIGnQq7f44xDStFmrSxiX4P2zIwds708cvRxf9s4tLRU8KhftqpmlrH5zbnWDn3mL3HrLyA2K3UdlOQYZTUyZvPOKZBSiNz4/ZmSqp7xIp4z9AkwGjGXfQivlOUv8oxNcy1qwFHMIb0ZEsPqotrFZt7YDUQyWlPftD1QVBFgaMNH64rML/JeGoXHbw3hA7oC2eMZDgFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hz2TOoEa98XWHwgQoA+bPDNfquHoZQbors+F1lUwSS8=;
 b=eZS5dAX97j3SDfVFbtjs3DEol13a6uy4fyoGUKUAPpgKL5Zwgd2JSgyRCqeYUwGL5zSdM8yyg4Tv8DqMN+Lv1tAzpwDekWz3qeL4Oo9BQGn6nL7gOzy32JRidw9iLKqKefCGKIpBx/AoA5kyRM+1GOTiTsIomw4wFCfdznITyVJQfLihKGznGjJws4RYYJyNZHGK7rBgb87zci+exptfa/uXLNUQoxMmFpVbSgwTNr0vCD5LO5Naj+d/oKwN10IVUFA13INjh3Cog4uivuVHQ8Hv6ehYRQnfstz0Dd6fpJcnuraxISHiZoFLGZKGgk+Xd2KJ1L2I+d8d4E2BevrYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz2TOoEa98XWHwgQoA+bPDNfquHoZQbors+F1lUwSS8=;
 b=ZNAWEs8c4pbzxa5xrYE0/WQHRSHXuqwpP3mKGIhQQZLfLi4k25drKDbNyggp/BG2qsmsRzwzHr+K7PjjVV9vhkb9J4qGSApbm8doPd/9e9pOv6FZhWB1NQ/QG+5iVtvtsfX7E2Qox0QR/btU7MNGyvyb9I9ot3rvM8lMrQ8UoKvqT9yU+r6gTL5KQQhJ1dCXAowkJxSM3P67P5VLK7JmE31ULc9+nWvGnuDZR1wvGLSfJwG5MscPV0PdXa8Ca/I+2E7J4WJ6tOZq4J11IupQJ969+QsvgfoG24GjI2QxEpD4H8CY1u5bJpb+LXeAHpoZ3F8FvVh4YYO3mt8lYtZ0Bg==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM6PR02MB6843.namprd02.prod.outlook.com (2603:10b6:5:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 06:03:49 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%7]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 06:03:49 +0000
Message-ID: <06c86fe2-3a34-4d74-9ef1-81ac220ecefe@nutanix.com>
Date: Fri, 21 Mar 2025 11:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] QIOChannelSocket: Flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, leobras@redhat.com, farosas@suse.de
References: <20250317015231.241141-1-manish.mishra@nutanix.com>
Content-Language: en-GB
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <20250317015231.241141-1-manish.mishra@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|DM6PR02MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b761b9d-63b0-4e9b-4d58-08dd683e2591
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|10070799003|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aThOaEhDL2FoT0RYWW01TXkwb01FR0VmVE1OdWpHdkMramVXMzFWNDVwYnBp?=
 =?utf-8?B?VUUzais1WFBKd3pmVzE2Q2xmY1NHamtRMFBUeU02OVZLM2UzeE9rZzdZYTBI?=
 =?utf-8?B?ZEx5K1N1YXNYbUhoVmMwZGl2azRmOGtiMWhBeUdmY3hDZFk0ZG4wc1hMU2la?=
 =?utf-8?B?dlppaXpiQjROaEY3Q2hxKzd5WUR1OHNLeUlSb0lnM2xwemZpQllhejIxekl5?=
 =?utf-8?B?bWJaT2lvQ01RTEh3QVRuWVl0S2JwSGVocFk2YzVaWVdBd09TSy9YVXhHTG1s?=
 =?utf-8?B?TVlDZ3cwdmQ2cnJ5K3hUREQ3VlpadjBBaVJuV1VRd3d5TzJBYSs1azVYY0VW?=
 =?utf-8?B?dFNjV3puN2pBWlM3NTltUW9IazJZVFZQQVA5K3RpV0NKdktqbDV2TS8wd1Rn?=
 =?utf-8?B?THZPSE5xL1Q1UzM2dTBSbUMvQmdqeWNvb0x0UDdOL3NBVGd3a3lzbzE1Qkw3?=
 =?utf-8?B?MzZHa0FSNFJ3VC9pdW11T21DZGpjZVVCbnoxd0NmZzhKQlB3czRjeTlpTGgz?=
 =?utf-8?B?R2UvUG96emxIUjJ0SXBKS0E5MVJTeWpEM0JEWDFtaUttYmpBZkJKTUVRcTZD?=
 =?utf-8?B?V1hwUG0vQWRZeFh4aS9CWEdqRGQrd3FDTXY2QkVwZUdUK3RwcFdOcHlzUTd3?=
 =?utf-8?B?MjJhcUU4UkFaY3djdTFla1FkaWRjSVBSbFZock00U2NYb1pKd1A5M1gzZjZv?=
 =?utf-8?B?SSsyam9SOWRPeHVaRmtPZmRQbHV6K3hKR1pzT05TUlJ1VXJwOTI0RExWVEpx?=
 =?utf-8?B?eng5VnRUampHOEVxODRMeWw1TDVBSXh6aGNGTklqazNHVWp5bzhmbnhvbkp4?=
 =?utf-8?B?RlIwMkU0QjZ1ZkJMZzQxWURsaE9kMTF4NzRTYzMxWG5SMWsxS2JFcUpMUXpa?=
 =?utf-8?B?ZDIwQmtsQVcweVRHNTRKUkxESWN6SU1PSGNObEcvbU1BZ24ySzIwbEw2Vml6?=
 =?utf-8?B?ZTBpWWt1di9HbnptbURJSE1GMEhWTStUYXFoYTNYU1hwT1JEdWExRU1FN2Ry?=
 =?utf-8?B?alBnR1p5am1Yck5ITy9BYS9STVlZK3lOU29ZQkhrWW5uZXErb0dOdFNPUE5Y?=
 =?utf-8?B?MDJwR1RSZEpBWUhXN1VhQ0NaWktkVjJFTjYrUmNnck03eWtCZlZ3eFBGQkRO?=
 =?utf-8?B?clhZSjZnYmdObmlUNUsra3dSUFgvWXBTRURWQ3hDbXFBTDNGN2VIbCszNXJH?=
 =?utf-8?B?SVIzQW92UEtaWWgrSll0SDRsZVliMVc4OU9wSmo4dzcyY1dQajZKNWxsVzBK?=
 =?utf-8?B?WmIwUTR4YzIvR3NKMVNueTJFb1FCRDR6dzI3UDhQSFJYRlRKSS9jbWVXTDZu?=
 =?utf-8?B?WlpoczFVWmJGQlVrUGVybUY2ek9uRDFZMG51bUV4UFJhUW5DTVpESnJDcWkr?=
 =?utf-8?B?MWNhRFRhVVJrMVFlbUk5cjhxdVZEc0JaTHpCQzZtVzJCRHQ4WHlPamtDcWtr?=
 =?utf-8?B?UGpCUW50b1c0L1hsNlFsVWx0S1pFWGhLVitGdjdGYlpPUEJ1K3lpTkRpcUxC?=
 =?utf-8?B?d2JBRXMrOUkrMWF0MlY0VzNuekYxU2ZQYmRoWU1sTXA5VTlVTThPQU4wRkIy?=
 =?utf-8?B?TUNad25pUDRNc0JGSHh4UDhXNkRaeGRTR0YvM05ySGg0VXR3aFVLMVJ0YmtQ?=
 =?utf-8?B?UXloT1FiOGwrb0syY2R5SllPN21GOVVGQkpZWHgvUmtXTmF6M1poWEl5ZHpy?=
 =?utf-8?B?bzhWa014OWlaRk1mcGhOem93Z1E4UkZhdHIzeGxka2pnRkJZNisxSWVPQ3hC?=
 =?utf-8?B?enpWWnlHVDhIbDhKYjZCemZCL2t6VlNSVlpaUkwxNjYwajFQSmd2TGpxY05Y?=
 =?utf-8?B?V3VQNzVDNzFSUVpIMWgzTWUrcUJ0RHRlczVnZEUwWk94S21Ec1BVT2N2dUVF?=
 =?utf-8?Q?FRbTYH0429l+8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(10070799003)(366016)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUUzZkRNTDhlZ0t6N1h0ZDRBYVMrcEx5emdHaW4xRFRWbkVvclhmQXBvd3lC?=
 =?utf-8?B?NGZ4SzV3Zk9uZkc5QXgyN1hZM2wzbkxlUU5sclgzOTc0TDdmOVpRbnRDbjRu?=
 =?utf-8?B?K0ZRTkZ4V2tSQ1Q2OXZPL3ptdWJpYUJ6Y1NxSmtkc1ArcmMrYlVvRG9CbGkr?=
 =?utf-8?B?Tkh3Y0ROZ2ZwL0RMWGpOYS9UWEhTYmM5UEsraHJ6L3czL0tubGphRTFmaGN0?=
 =?utf-8?B?czk2R011VG0yWlFIY1ZLMlFkTU1kNm5kRE9wa2dNQiszOTlOOHQxdjcvN0FH?=
 =?utf-8?B?ekZRWTZIS2l6bWNkdXl6K0dLOVJqREM2Z3pxOWR1ZmFEMjBabnE0a3p2SnVT?=
 =?utf-8?B?TW1UVWxkeFpLZXdPZlRJQ3poR2hoQ3p0OXhGczJhSWxUSUJ5bXRWUGkvZ2dK?=
 =?utf-8?B?cGx5QUFQMTlNcnQvdGpIOW9yOVBZYytMZmVYS2VQNmliWmszdkVXOCtNZlM5?=
 =?utf-8?B?Y0RVUGJIN2hYY0xHWmFuSXczOGt5eWlVaHgxc3hXbS84ZURNT3h3aStMWXF5?=
 =?utf-8?B?TDcveDZMQU5uV291L1dCNVZxQk9qOVdITS9xUmd1ZVlLN2pYQkNKR3R2VmpM?=
 =?utf-8?B?TjBXdjg5TnhhMC9jRnRYR2g5Q2xLMlBNQ0RUV2Mvc2RxeWUxMjYyT21UOCtr?=
 =?utf-8?B?RXplZnZuZ3hiZHZKVTlmNWVTUTJmcXlwb2lSRjV5bTh2cHlMMGdJUlQ1UjRY?=
 =?utf-8?B?S01UWU55YVVjQ2pPQlowaGpJMm9GQzJVYThDNDIveWN3bzRFb2FDeEZDckd4?=
 =?utf-8?B?Q3M3SlU2N2tjNXdvRVo4VEFWTEZHeVQ0aGpzSDExekhxenZ5dnpLdmJZS041?=
 =?utf-8?B?amJIZnpOZjYxenJ5ZjA5Vm5KRGEzL01uMWV3aU5YZzBmVEt5SUl6ZFNxS2Ev?=
 =?utf-8?B?Z1JyKzMvdUpldHcvWCtjTHhxbUtsY0JVUGU4S2c4bUMvY1RGZEhQM216dWhl?=
 =?utf-8?B?SkJmSVFCOTQyd0dGbmJBK1JyWkd0SUxtdVRaK29tZlNBZHdVSVdseXBKYmdZ?=
 =?utf-8?B?Mjk5ckM4czVON3FWcVdBTnFhUDB3MUc2ZFdiUkNUcTh5amxxVlREdTRGQWlM?=
 =?utf-8?B?R1ZKVmRTSDRnMnQ5OXMzY2o3aTJXYWM3cWVaTHVER2M3WHhIVzVKTENSVERP?=
 =?utf-8?B?Mk5lT1NGdW94MUpBWkRoY2RBenpJRURSUGZJQzBaQ0c5VnlnN2pTaTFqUUxl?=
 =?utf-8?B?VW9KN2JxeHVNMkdpUUVYK2VSbVdNcEV6SE1XYmxRNC9qMWtnSm0raERxQUlh?=
 =?utf-8?B?SEFPRGt6b0FzQVJpaFZ1Vlp6Z2VsUzVpU20vcUY2THNMUmExVGprVDhrMzF1?=
 =?utf-8?B?WEd4RHJpOUNPd1p1eWRXV3ZHdzlyRmZBVi85dXRnZU1jK2x3MDRIWGM5RW9u?=
 =?utf-8?B?TjF5WTdhSFUyWmxad3c0MkxGbUtPWVk4UmJpSjFQQVQ0ME5Yd3N3dVdITmdL?=
 =?utf-8?B?ZnN4U3c4cGdvY3M1ajZsd2lNajNmV0kzYWJJelh6UnowRm5nYzlJZ2lQUll4?=
 =?utf-8?B?Y0tMaVluVS92dTZTU2JJTUd3dEhmOHpoNmlrbkZWcE9ibmNxNVVIVXVYZG1l?=
 =?utf-8?B?OEhyRm80dDg5TU13MkZXUVU2NVQwZFdsaFdwYlNGZHFkdzZVSUhXN2NSbWJH?=
 =?utf-8?B?Tmt6cUFuWnZyV1d6Z1loaVBWTnlDZTNHRStSZGtSSG1FakNyeUMvb3NjS1Jp?=
 =?utf-8?B?U3BKT0dUOG4zRGJ0NnBLZk1aVS93RkFJKzJQeDlwNTBtRWhnc1grUmFSWHE3?=
 =?utf-8?B?UTh3KzljbTFUajFKMmVLc1JLN0p0dkVhMzc5ZXl6K2JJdnk2UDM2RW4xSktN?=
 =?utf-8?B?TVNySHRwaVpYZnVYZjY2TnJTalk0S0JFbXA2TjZydUk3S0N1aXl3SUJQS1BX?=
 =?utf-8?B?UnhXSkRDTitwcUhJbmhzSW5XMmhmQ2lxd1dtbThqUU9hQXAzcFJXK1Y4STB4?=
 =?utf-8?B?VWUyYWlOMld2WXoxbWJocVBhZUNHT0ZSZllSMVV1RnRWZlVjcUtqZTlUckc1?=
 =?utf-8?B?NEJGbGVnTjcyUFFiRlgxMGsrTlA4bDZHMUw3blZxVW4rbVNiV2U4Z1JHdzdr?=
 =?utf-8?B?bnY5bDMvbVRBaVE0VEFURVpJSXFnUy91QW9yeXczQkFENExLYTNqN0swa0Yw?=
 =?utf-8?B?MzhSczJ1cTdvQmdsVVZNUm5GUFlZdVhTQkxod3JFazhFUEs4KzV0TUVZYWdo?=
 =?utf-8?B?OC9yeEJobUF4akdqdndKNUdwaVBaTi80cGhYUXh1K0ZtS1M1ZVREUk9XbTFk?=
 =?utf-8?B?a1FlL0tJdkV2WTIycE84Mlo4c05nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b761b9d-63b0-4e9b-4d58-08dd683e2591
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 06:03:48.8577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9JzRxTanNcZWud2lyqp9hGBIo6tFfFqDjozVNNJ5Six40jYOQM3KmTralP+6YSEd5EY/TiAZ68oSS+veQo3axEweuJjOK1QJg0pAAMisig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6843
X-Proofpoint-GUID: C8d7SjU8kIGjPGS30xobl3jMB_v66oHC
X-Authority-Analysis: v=2.4 cv=R50DGcRX c=1 sm=1 tr=0 ts=67dd0148 cx=c_pps
 a=Al84TKQ7ImdPUwhB59KusQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=po7NilS97JvGOaug97gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: C8d7SjU8kIGjPGS30xobl3jMB_v66oHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_02,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Hi Daniel, Peter,

Please let me know if this latest patch looks good?


On 17/03/25 7:22 am, Manish Mishra wrote:
> We allocate extra metadata SKBs in case of a zerocopy send. This metadata
> memory is accounted for in the OPTMEM limit. If there is any error while
> sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
> queued in the socket error queue. This error queue is freed when userspace
> reads it.
>
> Usually, if there are continuous failures, we merge the metadata into a single
> SKB and free another one. As a result, it never exceeds the OPTMEM limit.
> However, if there is any out-of-order processing or intermittent zerocopy
> failures, this error chain can grow significantly, exhausting the OPTMEM limit.
> As a result, all new sendmsg requests fail to allocate any new SKB, leading to
> an ENOBUF error. Depending on the amount of data queued before the flush
> (i.e., large live migration iterations), even large OPTMEM limits are prone to
> failure.
>
> To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
> we flush the error queue and retry once more.
>
> V2:
>    1. Removed the dirty_sync_missed_zero_copy migration stat.
>    2. Made the call to qio_channel_socket_flush_internal() from
>       qio_channel_socket_writev() non-blocking.
>
> V3:
>    1. Add the dirty_sync_missed_zero_copy migration stat again.
>
> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
> ---
>   include/io/channel-socket.h |  5 +++
>   io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
>   2 files changed, 65 insertions(+), 14 deletions(-)
>
> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
> index ab15577d38..2c48b972e8 100644
> --- a/include/io/channel-socket.h
> +++ b/include/io/channel-socket.h
> @@ -49,6 +49,11 @@ struct QIOChannelSocket {
>       socklen_t remoteAddrLen;
>       ssize_t zero_copy_queued;
>       ssize_t zero_copy_sent;
> +    /**
> +     * This flag indicates whether any new data was successfully sent with
> +     * zerocopy since the last qio_channel_socket_flush() call.
> +     */
> +    bool new_zero_copy_sent_success;
>   };
>   
>   
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..604ca9890d 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -37,6 +37,12 @@
>   
>   #define SOCKET_MAX_FDS 16
>   
> +#ifdef QEMU_MSG_ZEROCOPY
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             bool block,
> +                                             Error **errp);
> +#endif
> +
>   SocketAddress *
>   qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>                                        Error **errp)
> @@ -65,6 +71,7 @@ qio_channel_socket_new(void)
>       sioc->fd = -1;
>       sioc->zero_copy_queued = 0;
>       sioc->zero_copy_sent = 0;
> +    sioc->new_zero_copy_sent_success = FALSE;
>   
>       ioc = QIO_CHANNEL(sioc);
>       qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
> @@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>       size_t fdsize = sizeof(int) * nfds;
>       struct cmsghdr *cmsg;
>       int sflags = 0;
> +    bool zero_copy_flush_pending = TRUE;
>   
>       memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>   
> @@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>               goto retry;
>           case ENOBUFS:
>               if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
> -                error_setg_errno(errp, errno,
> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
> -                return -1;
> +                /**
> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
> +                 * flushing the error queue once.
> +                 */
> +                if (zero_copy_flush_pending) {
> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
> +                    if (ret < 0) {
> +                        error_setg_errno(errp, errno,
> +                                         "Zerocopy flush failed");
> +                        return -1;
> +                    }
> +                    zero_copy_flush_pending = FALSE;
> +                    goto retry;
> +                } else {
> +                    error_setg_errno(errp, errno,
> +                                     "Process can't lock enough memory for "
> +                                     "using MSG_ZEROCOPY");
> +                    return -1;
> +                }
>               }
>               break;
>           }
> @@ -725,8 +749,9 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>   
>   
>   #ifdef QEMU_MSG_ZEROCOPY
> -static int qio_channel_socket_flush(QIOChannel *ioc,
> -                                    Error **errp)
> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
> +                                             bool block,
> +                                             Error **errp)
>   {
>       QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>       struct msghdr msg = {};
> @@ -734,7 +759,6 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>       struct cmsghdr *cm;
>       char control[CMSG_SPACE(sizeof(*serr))];
>       int received;
> -    int ret;
>   
>       if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>           return 0;
> @@ -744,16 +768,19 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>       msg.msg_controllen = sizeof(control);
>       memset(control, 0, sizeof(control));
>   
> -    ret = 1;
> -
>       while (sioc->zero_copy_sent < sioc->zero_copy_queued) {
>           received = recvmsg(sioc->fd, &msg, MSG_ERRQUEUE);
>           if (received < 0) {
>               switch (errno) {
>               case EAGAIN:
> -                /* Nothing on errqueue, wait until something is available */
> -                qio_channel_wait(ioc, G_IO_ERR);
> -                continue;
> +                if (block) {
> +                    /* Nothing on errqueue, wait until something is
> +                     * available.
> +                     */
> +                    qio_channel_wait(ioc, G_IO_ERR);
> +                    continue;
> +                }
> +                return 0;
>               case EINTR:
>                   continue;
>               default:
> @@ -791,13 +818,32 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>           /* No errors, count successfully finished sendmsg()*/
>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>   
> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>           if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            ret = 0;
> +            sioc->new_zero_copy_sent_success = TRUE;
>           }
>       }
>   
> -    return ret;
> +    return 0;
> +}
> +
> +static int qio_channel_socket_flush(QIOChannel *ioc,
> +                                    Error **errp)
> +{
> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
> +    int ret;
> +
> +    ret = qio_channel_socket_flush_internal(ioc, true, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (sioc->new_zero_copy_sent_success) {
> +        sioc->new_zero_copy_sent_success = FALSE;
> +        return 0;
> +    }
> +
> +    return 1;
>   }
>   
>   #endif /* QEMU_MSG_ZEROCOPY */

