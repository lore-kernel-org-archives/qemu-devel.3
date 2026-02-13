Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66ECEDF172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vque3-0003nm-4a; Fri, 13 Feb 2026 09:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vque1-0003nO-EJ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:59:45 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqudz-0003Xs-RG
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:59:45 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9bgav752462; Fri, 13 Feb 2026 06:59:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eAU48FxfJPey1QvOeTYWOQf+8gPEswTxP4nUUPDs4
 ms=; b=yl48ZQ6et67frC99o7mn5YrI9ExebG/TmTJfKSZbBFKm+4yLfBPQokUCv
 urXD7ZgDnlXlJYCUX1vsbG5KLXqfLrz0BG9WXoEvsKnvWqfGBdZ8Y+BUS3drBTwP
 HjkphmAvYuL4kdohPn5JWO6aHy+k40hvghbo+prjsNC2UCTa0eEd3ZgLJsZ8enIe
 sPS/meYvN1MXZgVQumedrUeyeF+c7pOZ0JriMH4IqTBi3Dt8Wc+2hr1gIoQ/DKVf
 9ajiNJAc4vE6j4xp0E7bD5VNwaichZBiHKs7NaZ0NJYBzZPkdj/+xdcxa04A0RG8
 skcYmdouIS5rqahtpsh7Gp4bJLMsA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020133.outbound.protection.outlook.com
 [40.93.198.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc992v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:59:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmiHT+BuTOhFzxgnRq8fncoOl+L3dV+wcA/XlUZbQzjgrqK9MLLryQWyKISZdogR18ZOy4sT9+NKfHjsU/4uaK7sJCbTVFpYPfOTqNi38RfopTn0HovPThaGKT/KG8bvvJVLmq+1EQpStT2v2OG/G6O12kO0WBmDEEQN6rCQ0GBObX9l3xvFTSTtdkOQc3zmKIS+sVMNArEBcCjSjQEhQCia9nZsEX9SGSjz6043jpmLibQRm8PQPOxpiv5sAZAJghFu+7EzVoB+0tCeljs4haE0GLIJww76iYJnALhDFsxUzPs+eYdGaKdOOrkDnIhMwnSjYr1WM8pJhs3e81g97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAU48FxfJPey1QvOeTYWOQf+8gPEswTxP4nUUPDs4ms=;
 b=MPeLP16beeG36eDbLHC4eUM0V6m1kV/Zwpolz53WzRJbmflgfzxM97smHUHp7TgeIMcwc52ozFBqpukXT3ir8EaFX/zV8CcYjjEs/VsbLi1b7GBRRPfHI2kc/X05U4MODmTyB0sJfJOvH32Ka2uMq8LZI5DeKak0iH9liTDuxCTD0KJC6+L5B8ZJPBv5Y0wq5eiZkSYAdH7vF+0VKJDxZH6zy+Hh0WdlVpgBFQ19rOL6OICBCeTEGLMm4B8sBrXPcOKOnEtmgj/2fu/qz8RcjRGX2IQJ/CPCa8wiJHEd+0DNjxgWioZ2WDc/JqWTy2gsp0kGPY5skrxNea5NGmG2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAU48FxfJPey1QvOeTYWOQf+8gPEswTxP4nUUPDs4ms=;
 b=pk16YmLewdrht3wFC/dmvgJq25qHzIimXtGzxJ9K1YD5CgD4pPW+CpO2JLaAgeVcVdY09I65wK9s34nkv9tyn/+UZdGWYlpzJaLKuGWPxyRs8HC8QLrQdJPDaIYjONgAmP99IoR+S5hql137hnr6oDAlSo35R/deHYAfzle3czXJ6G1CiCulAzDbnTYaREucT6QNkg+ScOSDBN6o8jKptczhTbmlFLIHR/kZBeltUxpFFbyyT2gOq+BSFAh2MN12TXZvA5NPcQGrJ78Wm96dhIv1XFYUipOv5l4qNapPvwaqD1qvcCEsFu8GLO6Xc9BDPJt8Ls1QZ30hWlVmsCtMmA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10985.namprd02.prod.outlook.com (2603:10b6:8:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 14:59:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:59:40 +0000
Message-ID: <0f6314c5-529d-49cf-8c86-5c3acfc41b45@nutanix.com>
Date: Fri, 13 Feb 2026 14:59:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/43] audio/spice: remove unused AUDIO_CAP macro
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-30-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:610:11a::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10985:EE_
X-MS-Office365-Filtering-Correlation-Id: cafbf2a2-22c9-46fa-3c61-08de6b10833d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmJlSXJXcDNpbzdrNDFsTjVRc3ZocUtPanVXVHhuUTFlTVBBODYvRlZpTkpG?=
 =?utf-8?B?YlVIRGJiSDlHK1J5RXBzeExZRnAyeDh1UExUc2NORDR2L0xEOFpxZDV3bllP?=
 =?utf-8?B?T3c5SnJBamJsNkNSME04RzAvYXJKL0RZSkh2S2pBVHJXd2FDc1YrVXM3S2Jj?=
 =?utf-8?B?Ly9nMmdYbVFaSW03TFk0SzNoOVlZVnQxRExIZXBsNXVmZ0hpL0NWZHVOV2dr?=
 =?utf-8?B?dmxBMkNmeEM0dzZkd1FpZWRacWVnZnd3ZW0vaHRla1RzV2ZGcFpwODZ3Wi9W?=
 =?utf-8?B?MnJiQ3JQclkzOXdBekRFQU1JK291cXU2NjNsMFJEUWRPQUV2RzZ5KzZYaHBn?=
 =?utf-8?B?cjhCMHRaaVlWVE0vbDJZTEhpaHZUWnlyTUpVVzM5VDNFSTd5elBoZVNDTGUw?=
 =?utf-8?B?enlVeFBaYkI4aFJvd2dON0l4RHAwOS9KN0JhOHJweVd5SldCUTRNZmZaZVhq?=
 =?utf-8?B?cTRmRFcva2Z0eTJYN2xoYlFlOTE1ZC8rbHNCR1p5TkwzL1V4U24va3FESVNX?=
 =?utf-8?B?dW5FeEE3ZUZpN1haVmhaS3BTY3dNR0hQWHM4SXJSNnA0ajQzbnBMVEtXNVVz?=
 =?utf-8?B?QkVRNFU4UmFGeTJtRzFrbzFyc2ZtVjhwZ1NKN3IyUFJIU0Rhb2lkb09hOEZX?=
 =?utf-8?B?ZXpvbkdpSW5zN3FUTW5wWXNmNXBGYjlwUFo4OTR3VVNxdXBYTXNlbFE3UVlv?=
 =?utf-8?B?N0hiSVJjbEtZMSt6NzhDbGtFNVNDOG9Fbjh5eFNzZndiQjJFMUowakg1bFE2?=
 =?utf-8?B?Z1BLYmQ4S0kwdXdRVGMyYzNYdGV4VHJnUWtlYXNXOXZ0L0F1SzVQdUdnc3lL?=
 =?utf-8?B?WVdOdy9MZHRuTmUra1NpUnhEZ2pzaE93bEpFZzJ4YzNLZ2JqcG9hY3VhQjdW?=
 =?utf-8?B?OWt0ZjQ2ZlpVdTZMd0FDTzFZRzRKQWFocjR3bTg4QmMxdERoWFUzNDB5QSsy?=
 =?utf-8?B?WitnQ2xsbWtNcm9DdXZKU0IvOGVYdjA4OG5kZWtlTmpOc3JjTUZVRDk5cXFv?=
 =?utf-8?B?ZU9sVWtWUlB4ZzIrcTkxWWlSdEVBUzExZDduRDV3Tng1K0tySWx0VUx3b3Rs?=
 =?utf-8?B?bUU0NFRObGsvcmtnT1RydWd2QjdvWFl6WWxrb0I3SUVNWktYc2ZubWJiRkxk?=
 =?utf-8?B?R2Z6NzlWUUFGR0kzUlprNGhvYUtWbGNiTHAwcnEycnZWUmVlMEpWZDhrdlc5?=
 =?utf-8?B?OSs2ekptYkJ4N1lvanVLU2NMbmQvTzlGN3NvcXh3eVFVd09ZenZTZ1RGOFpJ?=
 =?utf-8?B?emFwb1plRWtUZXNWc0Q2WW9QaStqUnk5dlA1Q1JZSkdZVUVDWXB1Q0NGVWMy?=
 =?utf-8?B?Q0pCNEhsUENlalhoeVRkRnp0R1FhT2VXNXFRWW85S3NmRGk4M2JiOXk0M1pK?=
 =?utf-8?B?OVJxbnpvWExPUTk4VWJ4bnF2VGVKaFNIQnZpalY1SGYvNGlRQWJ0N0YvcTRz?=
 =?utf-8?B?RDBFOW5oNDNlazJBVVJsTHdoWnFlZjFseUNqQXFhY1RDMEpWb3NiV3JHbDBk?=
 =?utf-8?B?SmtQZWNFUGlsSHJrOXdjK0NVN3Vub2l2SXJZKzNpNCsvckxHckp6RTI2eFor?=
 =?utf-8?B?VHo4SDFSWjFhekRUb2J6Y0swQTVneTVnZXBTQXdUdGkvM2lOSlYyNjFhYUM2?=
 =?utf-8?B?RzJRWC9sOTB2Zkw2bmx2ZC9UM0YrRnN2SnpFSUgzcDEzN3Y4eU1QcWNXS3cz?=
 =?utf-8?B?U2hUeDRTOStJb0MwZ0N0VUxURHdqNW9reFZiSGhlTWxzRzlXUUQ3eVdyUCt5?=
 =?utf-8?B?S0ZsZzN1d1NvZnFhWFY0RE9DYmVVbHhoZWVwNWxNVUdCQjVDV25zUGREVm9y?=
 =?utf-8?B?SXhuN29uWVBUcy9HRVQ2cDhiVFVPaW55UStROC9EdEkyNFZkdzIvSitQM3p2?=
 =?utf-8?B?QlVtQk1wZXVnR3lBUUxhMFJVSDcxVVhDTXVDUUpiSHlRS1RPQnl6Y002aUdw?=
 =?utf-8?B?RGxreW4wK1RJY1lhMTBOYm1xNS9yUlZzbUJJWnlSVFZiSEsyR2ZTdHF0ZzIr?=
 =?utf-8?B?TzQybURpakxyblcvK3JWY0VrNnpub3BXV0FOUWkvUHNETmpjSkN6Yy9BZ1RI?=
 =?utf-8?B?bXpmQzVtNTF2Z1FNN3NnQ2hVSTJjYkorZ1pRbm0veDRKT0dQcnFwcmJsd3JB?=
 =?utf-8?Q?lvkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Jtd0RnQkd5NVNjMmJ3b2xBY05XQWhmdVpjVTVyMll3ZUpKejRKUFJIdmdu?=
 =?utf-8?B?cjJDOG9VZk5XUi91TXd5bC9vd24xUjIyTDc3aGV0R0tGSHAzTkI2OXhBbFJJ?=
 =?utf-8?B?OWpOTXVudkFVSG9QdkhlQXpRRFBlUXphdStWUGUzNzJzUExtaW1hTXhmVTNq?=
 =?utf-8?B?eVJGWjJkR3N0R2o0NUdvRkhVSFYrMkF2czQvLzB2VVpGY3B6MENaNTJaWW9G?=
 =?utf-8?B?aU90VlV0UEE0NU1HS2xGRHQ1dHpmZ1ZvbGdxd3BqZlJtYTJTc1ZwLzhqWFd3?=
 =?utf-8?B?akFKQnV3dXNxYU9GRjIrUkNYOTFuOEZlUDBacG5XV3cwYVZaelVjRHNNeVV3?=
 =?utf-8?B?OVVyV1pyTW9FQ04xUFJ1WUxqQmIyejB3NXlBSmVDdHVONWVScE5tbXFmYXFT?=
 =?utf-8?B?djFoV05KZUYzRno3TUNpdGYwN0dONWNyVzVmVEpLVUx0Umd6U0tjWm1rV3p0?=
 =?utf-8?B?WmpsOFoxSjJxOU9mQVM3Yk9uak53Mk5EbmhlcGlxOE4wVURCaGh0YXIwNVcr?=
 =?utf-8?B?NjZvaSs2ck4xMnVzQm84bW91d213ZSsraEZLZEhma1FrVElQMjNnRDN2UVh4?=
 =?utf-8?B?YmlETFgwaTAzQ0ZwNDlSS1BtUnJlaXRFNGdVZ1VJeVlTYUJHYkl0OGFCenVm?=
 =?utf-8?B?VzYwT2ZKM0tUYktRNjRmSUtKcVQ0bm5lOXBTTlpzOXk3amJyMG11ZDdKS2RV?=
 =?utf-8?B?WklwdjV5NWFCZ1lpSW1MS21PTWZPcWplbVVCbHdmOFZkMHROSWlDbDcxRFkx?=
 =?utf-8?B?QlJBZHNZUkc4alJORUZMVEdXVkFHMFlqaDJYSjNzajA1VWd4enlESzZIS0Yz?=
 =?utf-8?B?WGsxZm4ybVFQUFdnWVo1NkRhNXFQdHhGb1FYWXhqQmRuSzMrb09wWmU0S0xa?=
 =?utf-8?B?K3c5YllQM0NMUCtUSFhZbitQZWdadkhQYXJrbm1ZSktTLzd1a1ZLVklMZTha?=
 =?utf-8?B?YXFMVFlpa2Jva0Q1TWNBMWtnbzg0MDNOZi9ac2cyTWN3SHVOUUt4RjFNakN2?=
 =?utf-8?B?MWR4MkR0c0ZzWXVCSFBWMzllSVVzUEZVNVNjSG53QnQyN3hjS1Z2VDNUeDBz?=
 =?utf-8?B?VEJEMnFPTGx4dVhvQnhGdlZxNXRPZjg0bEd5WDJReitBcVpkSTZSQkdDdUth?=
 =?utf-8?B?bDl4bTRYZ3hLYWsrOGNWQW9UNlZiM0Q4WXFDYlJJQTFxaU5sTmRqMFdJOXBN?=
 =?utf-8?B?a1p1VEVxamlHRm9Wd09xMXBEY2NoelB6c3hheHlqRjNOUXBIT0tWRTk4RjdN?=
 =?utf-8?B?NUtEME5zby9sUVFpRUFtS1hTajlHQVJsT3daUmZGcFNrUjJabWoyWm1OTmx4?=
 =?utf-8?B?UmY0WDRGV2ZvVlhkamtEWHBwbmt2ajFzc1lYNGV6ZFVEMG9UUDB3RWRQRkE3?=
 =?utf-8?B?UlBNVG5rQThZTEtvdmtIeEZKdXA1eWExVEF4c0RkRVROaHFmbXcvVkt4d3gx?=
 =?utf-8?B?citZNFVkTWJnVDBHVm4ybmxhU1JTcjR3N3ZmSmorcDJJU0U2bGpjek9CbWVY?=
 =?utf-8?B?b21TK1NYOWs4WmVtdzl6VUcyYlF1akZMT2Ruc2ZwY0FYM2R4MFVjMnVkTFpW?=
 =?utf-8?B?YXk2YzE5dE1KeW9HM0tmb01jT3ZVencwdzdQTEVOSlFpSS9hWGFuNkZYNmxl?=
 =?utf-8?B?ZUQ3LzZKWWxvZm5JY21vSGg1RWYwSUE0REllbUJMeUxEdms2UjdjaERNdEFi?=
 =?utf-8?B?VGQ1QitwMUhSMHZ0Y2lTVXFDOEdiZEswcmwwN0VQR0ZGMG5raEk5RUlrMnhq?=
 =?utf-8?B?djFlSE43YU56YTFCaXNiaEE1QU9hRENGTlJoN1BvSzNxdFZGTlNhNG1UalhC?=
 =?utf-8?B?b0VvVnRCanpwUmlLaW1GT2FvU2xYYWl3VDZFMUIxcWNPVnNoSW84ZldVMEFh?=
 =?utf-8?B?Z0R5SS96bGlpZFZMOGwwT2s3SmtDaVY2OXNDVE9vQTcveWNROHlhVWVnSVNK?=
 =?utf-8?B?enBJNDZ2enZJd0VpRys1Rno3ejBNcEZTbDkxOHFGaUhrWDBqcXFIeHJoUFd0?=
 =?utf-8?B?S2ZpdytpQzMyMUNVSTNzNTNyNGJDeVFZQXJiTTh2WjVwcUtCK3UveVU3S011?=
 =?utf-8?B?Mk40MFQ5VkVlZ2d3b3BERDFmaWtVRkJZWEpVR0xuZ1B2NEVHUGRyUU9rRzJW?=
 =?utf-8?B?Q1dtcTFwd1VLQlQwV3o4YjBQWGExYS9qRTNHMU8rbHZXb1NwcXk0WFEwTEx5?=
 =?utf-8?B?c0tTUnlyVzRqZWRiNVlxQ1A3cjdCQlZVcWtDL2VRWVV0TGJ6cWY4OW5IRnBH?=
 =?utf-8?B?d1g3aFpVeSt6OEdSODZkZ3Z4WkZBTlRkSU5LN0tlTDV3MHVTVkpJdmNVUlFi?=
 =?utf-8?B?Tk40UWROaE9VUy94MXRoMFRPUjcyK1RLZ1FlZFlhUGZPdHhjc243YUFmZGY4?=
 =?utf-8?Q?7+AqYMomtd57AvCg=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafbf2a2-22c9-46fa-3c61-08de6b10833d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:59:39.9807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR+YgIrQch9vo7eIPWVmgcE27VjOV3JuGLc0ossaIor5trvmsQXJEEQaQvSVHoE7GZ7RgB9OU92LZ1um5Wm+NbIm7TReGZ+nFoH7eyzCJm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10985
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698f3c5d cx=c_pps
 a=QtilNflqjlihrLF22repcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=Qg-rM8gwwXD4SR80nBIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rmskwqC3dUaDkATUdM8flsERgOTADygb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNiBTYWx0ZWRfX0wORXDzo2i+f
 iyMjxk+lZgBR5ueN18WWJA2SynbkOfXXrTxRaFAcFkP1NRP/jff9fhvOaPJgWk2yR3IY3iBzvc9
 GfSt4RsNEPT3WSFw0GIjZCPmE1f9nRcnN/FOq61ohzMeZWTg1l7NLqPQ9t2jtcT+vklRc4gP/Gy
 UHEg2q3Tpu81UZnNoIyk30+FNrhopwor0AEks+LYB+2GQMpTyRHmIX/ldXwSldOe0sBj+ocdguR
 o/f/MJG7npP0NPfL2zG5CS4Po05Wg2Ar/+hyVwTsp8V1sLlADNlAgfASqsey9apJ5J0oIRVd6l8
 XszxoercvkvaWkLL0s/oNcVrQev5oPK24D90XTkKsmKOHbDUpve7LUBD3P68wZkhBK0OLTxcSZJ
 jr3V2q1i064JnzsRB0DGmH14bGEbXok/Ujw5s/xnMnRNQE6K24pXjalhINRh8Mz7+DuShbx2CtJ
 SEg2MIM3vVpGRD2eq1w==
X-Proofpoint-GUID: rmskwqC3dUaDkATUdM8flsERgOTADygb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The AUDIO_CAP macro is no longer used.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/spiceaudio.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index fa1cb04dbf7..2547126994d 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -26,7 +26,6 @@
>   #include "ui/qemu-spice.h"
>   #include "qom/object.h"
>   
> -#define AUDIO_CAP "spice"
>   #include "qemu/audio.h"
>   #include "audio_int.h"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


