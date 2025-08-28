Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F042CC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXs-00005z-S8; Thu, 28 Aug 2025 07:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXm-0008Mz-CZ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXk-0005OH-I2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:50 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S77Yjg2726376; Thu, 28 Aug 2025 04:11:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=a/urwUXHjEYKhPmT7pUu/Stl3Zm09Y9o+oLA4A0fo
 2o=; b=R7ZlMK7PozTKTsmvyhNMWMv9Iw1YApo9A/ej4iVZF5/1kTmUy/C6tyPfD
 bc4TlNtFgnD93F45P6GyS2IKjwpSFo4fUVz4wqn/CL/veN3hpLKIb69BhTbh1hft
 b8IHY++EM0ZOY44azVttUZhpCwq07F8IFh/blOMupkEdFqpO7zbKw2ejkFxeE0Cd
 flR7GZq7dac5ZsBY7pbJ1WHkP/kWxm5QRDMUZF/M6VPf8ZuFHSW3JdEogHzFjWGp
 IGnVQn424X4Xia4bv6TMfvxYQj5OOXLu7hjlfjla2iZ0y1E+bp9MQo8cnXJgHuvj
 kbfq2upChGkWrqdoNWqYBQ0/rHV6A==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021078.outbound.protection.outlook.com [52.101.62.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t6kjswgd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqQu0/Iym/NfNmqBBEGmgzePRTvCu/c6d4s5+6RGmUYvflX8u/DLfczMlcEutmorNDDz/K9T0DljR7afyWAyGwnwEKW7TDGykGN80DuJahG7xXC8dSvhPbLaY00eoqYa0ptdmcv7du2Vhd250vt2dwo7GVJEJsZ2BiXeKyuZ7/jQyPbIBHOca8XLFxaqMtPUPbjNbYUwCLGFn2UQSllFAL+1ZXf0MlADtS74/ZV4dudaQbcFJmDABrMZgHFDvHEd+8YnJ4hsv/KfZHqQa2QbCUoalutMs7FxArYzJI/GEwi8XzHwokUQeDxCuoXXMC8qcOUGb+ShpOz/A4qIduRdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/urwUXHjEYKhPmT7pUu/Stl3Zm09Y9o+oLA4A0fo2o=;
 b=rTPv4vFUJKf/XR+yl3Lr43e8lPi6he0eEGu+lMu4G5P6ok4CJoCiRRAkLvNMLMOPe6AXK6vnMOaXkDaWMZisDPyLOMi57fUYswuycxZ6U5rcKsMVFxh6QFokIW6OAQR4Y1/GJvv7mU17MgmZbUAPCQw5w1M8ypU/9t4mAjW5ehBF4U7gua9EKMhSoH1K7hEa9JJA50H9DvQCh7KvTTYYXrm60wha5xvHf+i8RQ8s89NTQSjIwcqaY5XkAby1hdJVrcQhyuuXNgDtz53AiH7SWeNNLonwWro0ZmCFVeD+Fr+x/RyzGA8iJJCHnuDkEKKfI7duv/16RylebJ8tjA45SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/urwUXHjEYKhPmT7pUu/Stl3Zm09Y9o+oLA4A0fo2o=;
 b=CO85yoissP4LV9dmrIiA0TNVIfS9xS3cr+k3IP9U3lCWyN9ar6fv1dsKm7n3AjmxS2N2FQ5WzSTDe1dtb9aI/N7KRhR5EBSr4wB4cX+6CCuuMLPOHs+wMXfLC9B8WXhlqftNLZB4VioJfQt7sPgtF6caXrVXvitgrJD5UmRx0ePthHy5ZHzctjGbqjWked9XbyhNF2cWYQFNiEJTNBub3qEKkeP2R0JXFKpOrev+NRjHRD86n/AkOBZFiLC+379EIqVnVo8RwnllzIkOJnoc1/6TUvSCQ+x49qgO5NsBs9v7ta4NBB0BbtG7LPfRZy6pAaJ7pmxvgwY5OzcKydJLPA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:40 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 12/19] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:55 +0100
Message-ID: <20250828111057.468712-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 126035dc-d7aa-4413-5db1-08dde623a9b2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1ZEMFg2dU5DWUp2TGdNQmg2RnQ0YWk3ck9mYXBlLzN4VHZMY2x5VE9ZK2ha?=
 =?utf-8?B?NVNpZ0dtMmx5UXZhVjErNXBYYUtIQnhqQ1ZGWjlTTDhCWWIveHhGNUdmZ1NM?=
 =?utf-8?B?WU94R3hOc2p2VGF0NVNYMnpyR2Vkb2wxcmdpd2dSZ29hUTVSNXljTHgxTDZz?=
 =?utf-8?B?UjVXWXE1cGdFeVhsTGFac1JncFlFbndyOE9kQTZMdHA3NENURFVIem4xU3B1?=
 =?utf-8?B?VWxvaG1zbEx0YkExSllmd1lnaDJTTmdKcEVzSW04aEJHYSt6RGhuQVJ4Ritj?=
 =?utf-8?B?VzZXUnJPWFdKTWNYQnllcHpUVnJjSFY2YmF1ejI1WDFHQmxwQWEvbG94UmhI?=
 =?utf-8?B?OGdQS1FCby9JZmtpWC9jZm1iVit5bFlrZlBGSGt0SjhRZ24zZnd3NXF1blo5?=
 =?utf-8?B?aklNZlI0aDB6NCtrWGpPUnJkU1N3bE9IbWM5UGtHZjBvYTlGcU1nWTdnQVZN?=
 =?utf-8?B?SSs0S29ER0xxZWY5NkJVdlI2UGoyLzFMaDlxbkpDQ09LZTM3dmh6dUhWSmRV?=
 =?utf-8?B?cU1mY0dkUE03VjJpU3dIWHdCbml3NWsyQ1haMDJ2ZDNzM1NabmZaSFRLbFlU?=
 =?utf-8?B?c1ZSZkNaR2owalZvY3RBUjZiU3NJYWJCcFNmRysyODBmamdmOWt4ZFZHZ01u?=
 =?utf-8?B?NFp6eExXT0FrVVdURDBqZjBYb21NLzVyQjlaUE1qSHZnVjNaa1RPcmh1eDY3?=
 =?utf-8?B?QTFaU2ttbHhIcnh0bWpxYzFiZTVKM29mQWQ1Nll2akVOUkFUWDArN0NZbGdw?=
 =?utf-8?B?bGN3RnQ0bm1FM0tCTGs1TUpZdkFOYkczN1c5UHc4YUhLUE1pNUVFSk9sQTNU?=
 =?utf-8?B?eEV4aU15Mi93Ly94Mmhpek5GWlZmVUIydWNPeE5lWkRVWi8xTGs5aHNSemNx?=
 =?utf-8?B?SGFHRHo2S0w2emkxRkxCS0FqdG8zZFdrbmIvSkJxSlRxL3BrVkd5dkhzYjAw?=
 =?utf-8?B?UHpHL3BwRjJPZEs0aTAyNmtuVDRXR0VWbDdsTlF0SjZYcCtUU1NLb25ZNWFi?=
 =?utf-8?B?UGdKWSt2T05jRjhUdUcySXlmOU43dWgzZHcyT1p2Vk9Ud1JNMWJ6b3BFcHl5?=
 =?utf-8?B?bDArcHpkNVR0TlphRmJDLzRXcktvWFMzWlJreGp3WUF6QWlNbm1OU3JCanBU?=
 =?utf-8?B?Tk9wOXM5djV0ek1pY2JuZTFRYit6MzNGWUlDdklYYURJWjlVd015TnBPdVlq?=
 =?utf-8?B?ZGJvRUlpYWprRTQxcnA4UFYwSzZicXpXNXVmWEt3MTU3cnY0b05TZnc2YmNW?=
 =?utf-8?B?WC9PWVV4MUlzN0Z6NzcrY1plZUdCOTAzY244TEF2akg2MXpESzBVdE1mWTRS?=
 =?utf-8?B?Njh2OUsya1REMDIyVXRmWFhzMUlhTGM3MDhiVEFtWFNiN1crZ1ZTWHlqbGEr?=
 =?utf-8?B?VEhrbFBEZFFSckVKdTlqbHhRdHZxQS9hWXJnOHRiMjBmd09rTE1MQWhWVjFs?=
 =?utf-8?B?ZG1ITVkvVm1OTXBLWStVeUdTRDBpSmJQeGpjNnZxckpMa3htNGpOZDFLM0ln?=
 =?utf-8?B?S1E1ZHNUQTY3Y1I1eExLelloaTlQZ25YQjdCckg2ZHVNRlJGTTdZbGJncGJ0?=
 =?utf-8?B?VjBHbUU0SHFJSjR6dkYyMlNTdnlKMEc0aTdraWJzRk44emVlVWlFN2E5MlA1?=
 =?utf-8?B?QTR0YXZrcnhaanQxNUR2Qlo4YXlHVW5xRVZhc1Z6U2tIQmRVcmxQTWQ3aUZN?=
 =?utf-8?B?QytPVHRBcU1LbFdJUitOR0lMQm1MR2QzQ1V3UmtCV2ZxZHZiZWVGZTEzcHNQ?=
 =?utf-8?B?VVNURUVjUGp1V1E4czd0SjVZRjlpZ0ZJdmRjQUlZYmhMUVl5WHpuZkkxZU5X?=
 =?utf-8?B?clk0WnVrRThkWFRiVjlRR1Y3aTExUUo2WS8xcHlZbmhWcEt1SzJ1cFRjRkhQ?=
 =?utf-8?B?NGJmVzdyNHZoSkt0cGpDWVlFcnBuYXJtdFltUWh6MkE1MFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhPK2R3S3RseGJ5TGVaazNYTzFQM2t5Ti9UTnp6VDlqWkgvM3J3VklPeUVE?=
 =?utf-8?B?N2NZVzBuMFVsdit2WXV6bDczQjNicjFOU2UxM0hZMEdqUm4vYTZjNlY0UThV?=
 =?utf-8?B?Q1BnSDY1Qlkyai8zK3k4cGhWUHZORjQvZHdLdnlueWFSUXhHR3ROd3J0QjFF?=
 =?utf-8?B?azJNZlFyZ01lbFAyck9Sc3RiS203Mk9RR2VhcTB4R3hhOWdaa01TZzRXbUhQ?=
 =?utf-8?B?RkFsQnZOaFJBeml6Sm5GSE8zcXJGMnhzTlZTa0tPaE1lYXptZk1ScXgwM0hD?=
 =?utf-8?B?WEwySjBLcTdleHV1dks0L3N3bm5wS1VUNFZ6bG5YbFRnYVMwb2FWYmJPb3Bl?=
 =?utf-8?B?N1VaSDRUMGVYNDV4WjNoaDZuZUluODl1OHc2c21URWdqbFdIR3EyajEzeDZT?=
 =?utf-8?B?cHBZWUowVlhhR2U2SjdPQmN5bEx3cmF0ZlNYMlZvMDFCRUR2aXZXUi85alJJ?=
 =?utf-8?B?dGwxQm9xaW1yMHBCYlZlb1VMaEJjQmhZZ3NrTDFTRWx5UURzcVpGSUI4aGJR?=
 =?utf-8?B?OW5OMVNDb1AydXVGVk1rYUxBcGE4ZCs3c3Q5Q00zaXNOSFhFZlRxbXVaWk4v?=
 =?utf-8?B?WDcyUzUyeHVLQVA1RmVZaCs1Q1YvL0lqbFIyWVBOTXlUejN4UHUzem0xb0FP?=
 =?utf-8?B?L2dOcEp1VG1FWnZkcjRJSlgzSmJBbG5rZW1RZ0pLNkdYa1FYR2hvTVFmMXB1?=
 =?utf-8?B?KzNCL0ZoQXd5OHA5NWlhM09zdmtYd0tNSXdsME1PVkR5M3JLRTNST0syZ2E5?=
 =?utf-8?B?akdKa3VzQTJaclRGWTRSU001M0g1d25iZjg1QkFIOFU4aVdpc3pnZCt5TFBK?=
 =?utf-8?B?MW5sdFcxZzhhalFZamFFeHJiOUNFSW8xZDZJMU05WXBFWVZVbXZrNk43U3V1?=
 =?utf-8?B?L05pT2FiSWl3NVdtQjBrT2FOVTk3eGN3NHFCekZQeHBtRnNJNStOckZFMEoy?=
 =?utf-8?B?WXNuQW1waU44R3BVQ2xvZEhMNnMrNS8rekp4V0lLeG9rODhWcldwWCtPYmQ2?=
 =?utf-8?B?blBvNFdTMWpESGpkcFN5RDV6ZVlad3VUTU1YV0tkdHZUV1NTOVlqOUU1ejB4?=
 =?utf-8?B?WWFLMHNCanJBVFNwQWhUUlNNdHoxRFEwRzhpTjh0bkp1anZlUkVyQXhvcnJ5?=
 =?utf-8?B?ZmhjVkFNL0V3Mnc0STYvS2hVQitvaWloN2RqY08rYkhsb2IzakR2L3drNWJT?=
 =?utf-8?B?V2xmN25yaXlOYmNpYWFkSVkxUWd2MW5ZTkxIVGRkb2FJYUhuZmFVTEVVbGdW?=
 =?utf-8?B?cENhNUoybklPNFRtNE1uVWt2Z3llZHArMGJMVWlCbGEyZkl1cS9SRG02SjEx?=
 =?utf-8?B?YVdJUjBKNmg4QXNxWVd2aEtEYjdpbFk2YUl0KzUxdUREczVlNnN1RlMzb3ZP?=
 =?utf-8?B?bGNSWlVEMUVxd2ZaQjdrZmt3ckc2TWV4OS9jaUc2eTdpc2x4c0x3M3FMVi9U?=
 =?utf-8?B?dDZwck84R0JvTk45L3BZZGprK3dITGs4UEViV21nVEw4Tzc2WEZDckMrT3ln?=
 =?utf-8?B?bUhlV0dCK2xTZWFDM20ySTBEdkpMR2dWMFZ5eTBQMnhCb2IyOEt3MFA5ZGhq?=
 =?utf-8?B?cVhkNk1YUjViTXdtVUlBdWJsNEJuMmh0QjFpem1BeHhGcEs1Yys2cmhESmFH?=
 =?utf-8?B?VHZZeTVTTS9yYUdUYU1SS1dGdlh4SjRDSmhMemV0UDFhcDVqVXdpTFh6MmhV?=
 =?utf-8?B?UWIxZERaeDFEdElqY0s0bEtEMjBZa1hkYlNUWFJ4b05Ea2ZDL3NhWk14RjZB?=
 =?utf-8?B?VHU1SlZ2clQ1R0RZeFREeDJHYTNianJzVEU1M0JBZnlUZzR1dnF2U3ZmaGlV?=
 =?utf-8?B?cWNSNEIya2ZyNk9Yc2o5SjZsOXlnbFRTcUxCdnc1azB2N2VaL0ZDQklEeGgz?=
 =?utf-8?B?Q1VVYXpzSE9tcTExbi9NY3FuQnN5bG96WHpFU3YzZVU2UFFjNmdqYkhJS0ZG?=
 =?utf-8?B?eTkvYVIwb3dWYXRXTkFYNVh6cGx2cHRja1IwcHpVZVNOZWxOaUszeTNsdmRX?=
 =?utf-8?B?RkF0MU9sS3phbGFWSGhxZHRsRFltLy9FOURvZXRhY1MzcVhEVDUrblBRMXZo?=
 =?utf-8?B?QkI5YnYrWmV5RUlBTHdUaGxuaXlabW5tTW1xbWhyRDdMMkl4NzJoYU56aHUw?=
 =?utf-8?B?TVVmMjdHTXY1QXN6Qmt6TkxlUms5NHZKZFJLbHM1RVdrdjcxTkVvZnpPNkVl?=
 =?utf-8?B?SzEwNTFGRk50N3pmdmJmMzlTM3d1bEIvUG5TcEF4K0FCZkdIOEVaS28vOHhi?=
 =?utf-8?B?T3N1TC9oY0pXWTRqYmVVVmhXQitnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126035dc-d7aa-4413-5db1-08dde623a9b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:40.2484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMNQgWwIJ5lz0RlnJjQ2IcrUFf2rhBeO1epnz+do59ehBmKcVaLezFL8wHK6CjcTvGFfSWnAbfvMueO6nocPAwhbE3Psl0Z8bP+fDVn2RGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-GUID: PZy06PjWdU5_05jt1DpvdkOjnGc-VzkC
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=68b03972 cx=c_pps
 a=c/RC1Hvpwd1gfJZSTjwoVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VVXk-92eaM9LjyQm6BwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: PZy06PjWdU5_05jt1DpvdkOjnGc-VzkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX/7mPLbbrRB+X
 fr8G5r1tJCNo+ASgb8GMvNKlOGLjWuKgGy0XUYch4XeUlbsXrww8xRPeEo9iKPjSpEMH5n9fazc
 ISJurHWriczJ3DXr88tOq9c61HEo6FD/DXYbMltxUJ2vGRX/Qq3j9+u0KiMAQDfBMVKFMDGXP+/
 st26jISAfIBHQhI4DA5JmOwp/TyKkL2dVwJ1FWjx+CpCxX3kIaHn6kVDof23NgUX6Z8UBhgbOnv
 arLWotYoY6LsSiJAGyz5RE+9yeNcGuv011l/jNZ9JzTQ3jHVBbviAli6npyKDm6t2YbOvLu3X97
 4vBi1kE5qsLDaDjR/uCJtDq0DlYc83opl8vpuXHYtZPyzmeE+rqoZUaWS9bZcE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0bc033943c..66dc4a5186 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,7 +445,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
@@ -499,7 +498,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


