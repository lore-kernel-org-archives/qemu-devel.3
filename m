Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2638C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYwn-0001RU-5v; Thu, 01 Aug 2024 12:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sZYwe-0001Q5-Oo
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:46:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1sZYwb-0008Jf-BR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:46:28 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47191els008044;
 Thu, 1 Aug 2024 09:46:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=37X9axSFelMtODeuzs2kP1yRKjieXTCLuHk6YUauX
 5Y=; b=0ragDA8gOuoNS+qBcG13Ec12yXSmkBYv0e8VfSyRSSMEAr//N1IW2t9eo
 vtJJxwNqW7GxyrsuzE0BKnHDQbezParwumCwd44CaXhoa0nKXGteyRI/KE0i/NSi
 ZxmKXt73QDNnXxgeP/T6iyRrdsU96xJcCg7wWY/bL56hpyntbxiP7mOA0gpKvEw+
 ql6ARN/UkDPJxixO89sfkuvlKYZvdanrxDUyOwqQ2uUodWBhZTK2X6lN2VNQK9dV
 9JyMJ5hGAG29uy1GhOCtNUP9ruPey3Pc737JHJDlmir2mqSWn1H4Rw9PXbNEVEKL
 FBRImfp6iHWYWJojPtFOGdGSD1+XA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 40q9chmvfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 09:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm5QoX+yZEkv1DF548InUDzOON712BlRRLWQIggm3xerlKLssWiK5Pz0wUQOQPVNvn2toIJr9Ia98fL1HIkvnOh7LIL6/WU355aeHHOvMksztqc5N/QyB1nwnpSb4Nx5cbvTNKJcFWLpZSmNY7jlddtyoAA2eRUNE1386Lyog1TT2Hql7iaZeN41JpDew08d7BG+yJs25jD165zk7ry29Rp4Dcr3CYSystku8bwc96rb1V+lNC7FyWebsJEVwBYnYnvOdyBCunFzQGzaiXBuiNNHT+nzDoTHAILre3L9ibOKKuIIGzWpQHG6Vx7r8LNJLwFBzqSX4V4fueQr/yQNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37X9axSFelMtODeuzs2kP1yRKjieXTCLuHk6YUauX5Y=;
 b=afcZAURtEwlTe+NOWBYkc/OLklumDd5cgxSo0q0XfGU6PrUDdB98ITyTYuBdCc9ZdHKjCftyo1jLTHD3PqeRLUVdBalepKPRV9NVYLC2Z27nnlH6FQqwTn96G7MHnQaOrGy8dqDc6uaSKZSHz/lMocdaMLuLuJKPp10st9oiwhPPAesGUnMd5IINCfSHto5ZsIpTh/jYlYeKdoxrukVwaW5+cgZ2S+Towt1o5Ww+Xt1ygB/ZNC0o7ztkBZCt5pMHJOacs3Kj+UKAm2TVj/wEYbAXGrv2LKDRHzwfEGpdcqbPgmZhnrqEQlI36xwaxAKIVN9bLyR2bVdK6u1WhQqBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37X9axSFelMtODeuzs2kP1yRKjieXTCLuHk6YUauX5Y=;
 b=NlF0E3yC2Pb+zag07oGxeAjb5ZdU6QuWWjR4ZrB3gSHTn2njsNSFMYfG6XM7oPbBjpj0KxLvcm+GveyHEtCB0mYJss2Bn80stu1JmVem8dzC1tRniu7ZfczYlaWVuYRQxEB35pHe2M4bdXenmuXiBdtozuQewAInkkwfpTg3kwiqFuXbagz66y8XlKHfVftJchx5ExZHJ6JQyLYFFFZH+ygHEgJFVbAvCZTtGe8u7WASlXzTGQ2gEzzyKNRYwARyl4wV4XoGb7VG+qJA4rWj7cU3mfvddlf4CxZkm/3R57NSpmvqJfHFEjr/5JXSouYLdxJvxMhWSh1V6exKYHH9ew==
Received: from SA0PR02MB7386.namprd02.prod.outlook.com (2603:10b6:806:d9::19)
 by PH0PR02MB8680.namprd02.prod.outlook.com (2603:10b6:510:dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:46:11 +0000
Received: from SA0PR02MB7386.namprd02.prod.outlook.com
 ([fe80::4c36:8bda:38b:e564]) by SA0PR02MB7386.namprd02.prod.outlook.com
 ([fe80::4c36:8bda:38b:e564%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 16:46:11 +0000
Message-ID: <4bcae915-5812-4465-8ce0-dca787cc4860@nutanix.com>
Date: Thu, 1 Aug 2024 22:16:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Content-Language: en-GB
To: Xiaoyao Li <xiaoyao.li@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com> <Zqn6mNuCH4/HJoO/@lent>
 <bda03736-ade0-46a9-977f-1ae368374555@intel.com>
 <d7de1729-e497-4913-be8e-8938e83b3a2a@nutanix.com>
 <20240801122537.4307ea77@imammedo.users.ipa.redhat.com>
 <e9f61d7d-2f72-4644-ba9f-241672d27cda@intel.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <e9f61d7d-2f72-4644-ba9f-241672d27cda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::18) To SA0PR02MB7386.namprd02.prod.outlook.com
 (2603:10b6:806:d9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR02MB7386:EE_|PH0PR02MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: fa39e5e3-75c0-4c39-c707-08dcb24972d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|52116014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnNUNVpaeDc5SlVBUGpOdWdWU1pNWm50VXIvYlplN00wM3QrTWRMb21RemYz?=
 =?utf-8?B?NkpDb3ZGajlPSFQ3aG5keG9BckxuWlZ6dDBvdGkvRUx2YVhOV2xTSSsyY1VD?=
 =?utf-8?B?R2tUZlUvU2hOYXA3eUttTG5sOTd4UUlORjBRcmtYdGpxcld2WUJydUpnUmhh?=
 =?utf-8?B?MU5LWko4YzdOZUpvTUlpN2VZMlhBQUNmNzR5NmQxSXFXMmFVMldYME9zSUFi?=
 =?utf-8?B?VUQ5K09hbTFhMzRselU3b2FLTUFRQWNlYlZ6RnBURzM2R3YwNHd1QXhxMGpQ?=
 =?utf-8?B?Q24wdnA1S0FHUnphT1QxYnd4cytqRVRpcTJiRkFkaVdlMzJTZmx4bFIxbGdw?=
 =?utf-8?B?emNJQXpmUitXQUVNZ2NKVjV1elY0WWFjd3M5QkozWk5lZXpTaUpVc1A3aEhw?=
 =?utf-8?B?TjhmRzNqRjFjMXZNRm9mUmpHS2VvazI2VHZsK2llcmFEbC9PaDM1NWRsWVdF?=
 =?utf-8?B?L0IzanM4UUdMbmZLYVFlbTJRU2RCdTBMa05Cc3JlMWM2LzQxcmVGbitqNmpN?=
 =?utf-8?B?L0NVVm5lMjNnS1RuZUlhMG03RVBHcTJ0Uk9PdlBnb0prQmhaZmFmSVhUMGRY?=
 =?utf-8?B?TnQwMnhTcWZvb3RIN2Ryd0VUQkNQQWl2YnlQZGgzaTZFenJndnlWWFF2bitq?=
 =?utf-8?B?elR0R1ZBSm85YkdPZ0E4VCsxTUNGRFVmV0VMT0Y1UUVleU4zNlNjQ256a1hP?=
 =?utf-8?B?eVEwbGdPbU9sYk91dWxMMXl1anlzYUJhSWZHZFYvODRQS1lnZ3NmVFh4ZTJK?=
 =?utf-8?B?Q2MwOERBMStkR3VUVklNZ2gyWFZIRC9ERWdEeVdwSmM2eHBJcndEN3IrZ2Iz?=
 =?utf-8?B?WFJSSHJxNGtuSXpCRnp3byt2SFBzZlZJTmg5TzQ5dEU1VjVOTVNBazJQVE5S?=
 =?utf-8?B?c1VyVVVoV095dmhOdGwrUHZRQ1JGNkJGSU9GMEFNR1lBdmJESGtHNTR4TjZX?=
 =?utf-8?B?RU5seUpPdVdabzRHR3M1MzNqT3ZpdGx5dTJac3QvSmdPUzU3WUU4OGFKdEJn?=
 =?utf-8?B?OVZZejhhRFRTbE1TdmtXV0haNWJiN1FEc0lFK21SKzA3bDM1ckxsOVlrLzA1?=
 =?utf-8?B?UVhsSklXTUhvOWY3Y1dUS3FreVI1MW9WK1ZrbElpRDJzVkhwRGdUREJhTFBt?=
 =?utf-8?B?R294aTMxWDhxSVpsa1o0YjNxMUdvZVYzQ1ZCYnMvNisyM3BOL2lsY21IaHFE?=
 =?utf-8?B?OGswUm5wc0tkdWhneUxMQVc4WVdPR3FsS2FOOVdtSjZwdCtNdFV0NFJHUVh1?=
 =?utf-8?B?S2U2d1puTkV2QXEzR3kxQlVrcklQcEZ5YzA1SXBHb1Rnc253U3k0ZHVJSFps?=
 =?utf-8?B?WURzeTVQanNzQXJjWUNZL0xaOWJtaWViMFp4ZFRPV1hDT1dpL2NINTdaOTFI?=
 =?utf-8?B?NU5UTGc1cVB6TUVkQzFMWkdtUHh4SnN1NXFuL3M4Q1ppTzliVVJqQjdOc3Nt?=
 =?utf-8?B?ZlJLUW9YdjhLYVVSZGtaR0tHckhvZi9SeDQwUjFOaTdnQmp5SzM0ZUVZWHo5?=
 =?utf-8?B?RTd3TTMwcWd3WEU5SGFxZHBZaHJjdUpSQnBscytNREdPaHg3b2VUMEc2NW1M?=
 =?utf-8?B?c3c1SVpVZitHWTFNQVhlZElSbVJCRDBvMkg4NzBuY1J3WkhRdjlPVU1WbXAv?=
 =?utf-8?B?dEFiZThiZUhLcDNrN054S0hBOGd0azJ6WHhUb1R5L3YrWm1lMUtvdEdlVDZM?=
 =?utf-8?B?cjE4SWtaQ3V3cXUrNGdjNGQzemlmVVEwN1Bvb0RqeElBVnUvblA1TmRnV2kz?=
 =?utf-8?Q?t18d9vd7gWXU92X6d4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR02MB7386.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2NudSt1bXJ3RVUwNm9UYWJJTS9ZMWRQc3hvMndRR0hvaDZCN3dONi8xTTAy?=
 =?utf-8?B?Nm1BejR1bGYzanBocGFiVmkwUGUySFFnLzM0OEpONFo1MnZkVjN3bGFpWnNE?=
 =?utf-8?B?bHdHeDI2OURuSDZ4cFNUUXBOdWRCVVI4V2tueWEyUzhHMEp1YXZIaHdzUkpG?=
 =?utf-8?B?bTc5TTFUdXFjeWZqWGxWOEhlMzhGalNyczZ4ancrKzh6c0lRQmFvQW1jUVV6?=
 =?utf-8?B?SDlEUkpYaTl2VUZuR21IeG96dHIrQlZzWStTS1ExUjVkZGtYTkFVY29GU0RV?=
 =?utf-8?B?ejlXOW5CemhlTlM1a0MwTFRBajBQbVdpUUp4NFBkdWNEUnBNdWlXUnFzaEV1?=
 =?utf-8?B?WGgyNEh5QzBiRTllVlBxSkFQY3c0a0VxMitjTzZKR1VGN1YvWUhNMEVyM0JL?=
 =?utf-8?B?YUJoV2VEdis4Z3RBVEJWaE5NcXNyY1E3ZkFMQXpaOExya3BpTFNwUlBmZ0Qr?=
 =?utf-8?B?ek44N0NGMG90N21rb25qT0RvTENBVUR3eXpwNjFzMnAwTFZHUFRhMDJUR0tU?=
 =?utf-8?B?M3VkSHkzNHF0L1lKYWtoQ2x5Tk81VmNEdWVYdWJmeEdoQkVhT3JBM1JHMURa?=
 =?utf-8?B?RE1FZ2RvYUVBY0ZncG5ZS040NUxDbDFiUEhQYVJwUm5zZE53V1FlUTh2OGhV?=
 =?utf-8?B?L0E5WTRtbHlCNTk3Umk1alJIbW56MjJLcXhKL096UjB5NzZGWWdUbldUOS9L?=
 =?utf-8?B?Q2NEeGZkY0laaUY3bXIweGMxQzRHU251M25jY1RVaGNVditaRVZvOUUxZjNQ?=
 =?utf-8?B?YmI0eXRHNVJ5L3BhYXRHNlpQK2ViSk5IdVRwS0xueDAvUG1pUmVOenlwNVJx?=
 =?utf-8?B?TURGS1VLdlpxUTUzajNGRHZkT1UwQ0k2SEVKUXBzVjl2SUZINDZWZFdDTDJy?=
 =?utf-8?B?VUFkaFJJM2VNNjJaZVNwbVV1Z1pLRE5paDBpcmNYaU9MRlF0TjJjenZ4cm1t?=
 =?utf-8?B?TzdrZzMvRFNGQ3F6ekM4NlVOTEV3NFd5SHZZcEdwQmtLNGZVZjdoUW5VRVJ6?=
 =?utf-8?B?K1FaMmRISlRsY093K2ZxNnFnbkFiUjdPTmNsNGVJV2F6UkN3cS9YQmJZSysr?=
 =?utf-8?B?Uk9FdHFCa0lMaUxqQXQvL08ybDdvN1ZSRnppeXE2TDFWQ1BZUldVdGJER3Vp?=
 =?utf-8?B?SUVSY1pkSThKbWdDSWtoOWZUa1NIVWFEWDYzM2svUksrWlNDSjlCK1lpTURS?=
 =?utf-8?B?ck1jVnpGQkRuanAyYlBOSkRFakNLMzdpSUNDTW80NEJCRHVyUEw5TlhJWkla?=
 =?utf-8?B?U0F3TW9RNzR6RE5KR0VyQ28vZ3h4ZEVLNm5lTGJRYk9URkpDMnl4STVNNEl0?=
 =?utf-8?B?VDBVWm9XMy9nbEVBV3c4SFphVkxIWmRYdGhZVXJ2dUVqQmNyTTNvM3FWYk9Z?=
 =?utf-8?B?MmVxN1V3VlljeUtNdFNnZ09VTnhvWUxLWGtjL3JxTkFjdm00WXFHdXpldXcx?=
 =?utf-8?B?VXRuQUZQdDVWYWFEUGs0bG5Zc3NaKzNLSHZ3V0w2Q21mWHc0a0x2YzVmMEZK?=
 =?utf-8?B?VG0zSklVeTM0S0gyWUNEYTAwSlVyeXVJMFZMaDloOWlmQTdwZXMvaStBdjdY?=
 =?utf-8?B?UnRzL0xoaUttUnA1bm03akMyYUw0T2hvNnNKK0h5UG1QTjYrOVNQR28wTkt6?=
 =?utf-8?B?bncwSDVTVFJ5MmdOUVNFVjJ1ZkJFUkpwZDNtWkNueHcyL3JiTm9ZSG92d0Fs?=
 =?utf-8?B?WG5Cb3JZZEY0MldEQis4M25VSllwZ1M5Yi8wUTlVbm0rek0zZmxkWHY2MmlS?=
 =?utf-8?B?Z1dIcHBWaVltQ3pmV29HRGFlalA4MTNWN09oRHRmeDNVRWZ5RGJ5UnNwcHhm?=
 =?utf-8?B?TkVpYXZ5OXlrb1MvY2pOMFpwU0VaaU5maHEyRVNkQjlrdEhsZjJPZTZXaTYw?=
 =?utf-8?B?bGxvNEkwVnE4bXRVdDlhSXVvdU5GSis0RGV4RjJlb3B4eVVCejNqMUpsaHBQ?=
 =?utf-8?B?elp4YlhiLzFDcjFsc1N1WlVTQ3kzN0JWNGRMTVdmZHpmUGFlZWpIUS9BR2tG?=
 =?utf-8?B?aE9hdVpkQXZpM2RuZ01MdUNBaXdla09RM1VkbmhIakpmUEFnWC95ZTMrdFNp?=
 =?utf-8?B?aCttTkgwMkhKU3lRVUw2SGc2d05pR05tVXlNWTQ1VVFQNEdxRTJ1Um56aTJF?=
 =?utf-8?B?N3ZZZy96eVFBRkNrakQ2eEFVckErVkZObTlQN2FLSjlyUVZoQ2dJbGoxK0tV?=
 =?utf-8?B?TFRITmNEc04ydGZPYUlMckoyWnB6alIvcm1ldWs1SStVMllWTnRJTDAvM1Zh?=
 =?utf-8?B?T0NwcnZ3MTlpRG9uSlBnYXhUSlBRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa39e5e3-75c0-4c39-c707-08dcb24972d7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:46:11.2884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThDA1sWxarm6t/N0pFK1U80VaYfDZpkqL5KAzH64V/x+k0nzmq5qThS2sWFmnROWlaqGuR71q8hD8hJI2z1H4vE7me5evJBcqSe9eLNXl7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8680
X-Proofpoint-GUID: txvd3-L9Pq2bIeAnS0wmqPAgWzrp2Rfm
X-Proofpoint-ORIG-GUID: txvd3-L9Pq2bIeAnS0wmqPAgWzrp2Rfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 01/08/24 8:41 pm, Xiaoyao Li wrote:
> !-------------------------------------------------------------------|
>  CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On 8/1/2024 6:25 PM, Igor Mammedov wrote:
>> On Thu, 1 Aug 2024 15:36:10 +0530
>> Manish <manish.mishra@nutanix.com> wrote:
>>
>>> On 31/07/24 9:01 pm, Xiaoyao Li wrote:
>>>> !-------------------------------------------------------------------|
>>>>   CAUTION: External Email
>>>>
>>>> |-------------------------------------------------------------------!
>>>>
>>>> On 7/31/2024 4:49 PM, John Levon wrote:
>>>>> On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:
>>>>>>> Windows does not expect 0x1f to be present for any CPU model. But
>>>>>>> if it
>>>>>>> is exposed to the guest, it expects non-zero values.
>>>>>>
>>>>>> Please fix Windows!
>>>>>
>>>>> A ticket has been filed with MSFT, we are aware this is a guest bug.
>>>>>
>>>>> But that doesn't really help anybody trying to use Windows right now.
>>>>
>>>> For existing buggy Windows, we can still introduce
>>>> "cpuid-0x1f-enforce" but not make it default on.
>>>>
>>>> People want to boot the buggy Windows needs to opt-in it themselves
>>>> via "-cpu xxx,cpuid-0x1f-enforce=on". This way, we don't have live
>>>> migration issue and it doesn't affect anything.
>>>
>>>
>>> Yes, that makes sense, I will send a updated patch by tomorrow if no 
>>> one
>>> has any objection with this.
>>
>> I'd rename it to
>>     x-have-cpuid-0x1f-leaf
>> (x-) to reflect that it's not stable/maintained and subject
>> to be dropped in future
>>
>> Also please clearly spell out that it's a temporary workaround for ...
>> in commit message.
>
> I have a patch at hand, to introduce enable_cpuid_0x1f similar as 
> enable_cpuid_0xb, for TDX:
>
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_intel-2Dstaging_qemu-2Dtdx_commit_de08fd30926bc9d7997af6bd12cfff1b998da8b7&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c4KON2DiMd-szjwjggQcuUvTsPWblztAL0gVzaHnNmc&m=CIrxjRd0KG4ww4BtSxZysWS0tFYfPGTRBG731EmlUcy7BFlAw3-5PLp2SlKPR83m&s=2gKDZXpqB7wE8v0vtN8l65WBqTtXOUJ-FkMblXcT_Ws&e= 
>
> It is not a temporary solution. So I would suggest to drop (x-).
> If no objection, I think Manish can start from my patch and it only 
> misses a property definition for windows case:
>
>   DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false);
>
>
Thanks Xiaoyao, I see your patch does what we require but i am not able 
to track these patches, are these in line to be merged soon? We need 
this urgently. Also as it is just a single line change on top of your 
changes, how i manage my change? Should i wait for you to merge and then 
send patch or you will be fine to directly include it in your series?


>
>>
>>>
>>>>> regards
>>>>> john
>>>
>>>
>>> Thanks
>>>
>>> Manish Mishra
>>>
>>
>

Thanks

Manish Mishra


