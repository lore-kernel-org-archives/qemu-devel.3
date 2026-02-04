Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12994E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaIA-0004D4-Ns; Wed, 04 Feb 2026 05:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaI1-0004CP-RY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:39:18 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnaHz-0005Qt-Oy
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:39:17 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145o6XT2992496; Wed, 4 Feb 2026 02:39:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gzLwdeuMY+nao5TocdFtCkQoc958IrHp8iIk1Zd6B
 8s=; b=eGd3Y+ZfqvS+HorQg3N6Rrrj4QYuLxHyjRuDCd6b8E1HtZ7k4bGoC0q6D
 3J1QNIYpE8mh1prP8NaQiiwcf2iN1qRhg4dH3OLiI3P2affKjEuSPCwZ/sQkAMFE
 xGWEv3qcrbzIQ0V3YM/8GA1O0P5LhWlYVC+PWmWm7ut2tLq3cfBMaRiB0Fob1teR
 9Mr/oqfoFWVcu+jPO+Xo0JA7VWcqcAw5ZL6d4ddDbc2skOeFOt3Yq2mCVj+tErmY
 g6OEznJe9pN7K4PhZFAlG87kDaeHdFIOufPGd9PkdpLtnZ8LkdHzKZpypKM+oR8V
 xebUhJ4poFZaM9BWs74ItXxSKf9aw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022115.outbound.protection.outlook.com [52.101.53.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja279-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 02:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7lk88okQAJd3VmCKwkRunFtJ/CaXhok7Y2/0Jq0La49xVuj6WXLGVIWBp9Enhw10wEl+XnDOc1bsWy/1GiSwdAbEx8SF1ik4tWEGCiv0ZGX2X2ZfMi2S6BuyDclntd34iIGig6ypwKz5H9WJggnAsixEl+bR35M97ND2nhibKhhKQVdZJueQHOutmt08RvsX3bMBfVaOZFtTWCxShosSaGZGbQyAPiK6DPWHk851D6i3Z8pEGE7k35LZiP3KOis+7JI2+Wyb9QFQUfnqO3DnSdaq4bUAKCJOpnkb0iYZF/azxUOH5bRu5NtXse85P4MQ0hPf15XosQHbnqdrxWBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzLwdeuMY+nao5TocdFtCkQoc958IrHp8iIk1Zd6B8s=;
 b=dE/HukMbuIH4+pLpMcOGK4DdxA9I4Y4PWXqQDnGjp+Bacs44fCpAoF0uqEnzUdix1WltlChIlagbn03giJxxGI5+uUHfjTQHMiH+rxeQiLfPlqwYCrAbEAF9UBC7FfQ+nHZi92PwTPF/d6q79IZlkQqGqZbxuLxkGIz/0cQGfqU/SzWVRg8UYzr7LB12pSgx6GK7y16BhREug6MPhcZ3wOH3rsjZCfne7+aYpCzf2Vz0CyIGgcAI7z/9I0kRkASN3TgjIAaRrSajwHBr8BcJ6XxanxaLGlMOicioiq7qVJD6Otrea73+s4eXq6dumk/Tt1lyp2aECBVYplsAOGy/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzLwdeuMY+nao5TocdFtCkQoc958IrHp8iIk1Zd6B8s=;
 b=ZQHf6Zx0xUf8escy7zlU/KzL/wFGFu1yOwL2oMc89n5KLuZmdlLOaUFWh7UmILkw5r06n3asOW3775KKiaMpSz5GrG6vzErGW6gLHSwRRRDQeQM9ifQ4MXe+6/WHdDRCt47cz70IluJ4TArgQaRgRXuiTWXx9+YDBACZSFU8ItlaRmSTtJrF4aRgTivizQumXi9QFuOUP1/4wP3cc1AHiVke43r/GySrBzYbSzlgTpn9F+OqDEKPaM5kpxNWhKHT9SoXX05oia4tA5lVtUdC5dv6obmIMI1QJIwKZsrI4mrJBmk0IyQs+Ph08HBwONCz1V/DxfEdKWftS8EsHywDBw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV5PR02MB10850.namprd02.prod.outlook.com (2603:10b6:408:2b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 10:39:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:39:12 +0000
Message-ID: <ea8797c1-5f1f-4481-8878-2def3865427e@nutanix.com>
Date: Wed, 4 Feb 2026 10:39:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/37] audio: constify audsettings argument
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-18-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:806:21::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV5PR02MB10850:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fddb6c-d052-4ca4-ba91-08de63d9a2d9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anVZSWUra2tkZmhTQW5ZTTBlMUF4M0ZDZm5kUlkrb016RitWd1hBamdzUGJG?=
 =?utf-8?B?bjZwc2hxblZYL2JOU012dG12R2RBN0E0cHdRWlRESndEbE9IN0pJQzhIeXd4?=
 =?utf-8?B?NHhLZUtoSnRKWGtTSXZTYUFNbEpvTG1CTW16a2dTY1Ric2svRGFzdGRsQnRB?=
 =?utf-8?B?NXRFRkVLZDlyUjFlMzZ5S3lWWTNHWlRGU0k0c3diSXphUS9XZlIwYkRFTDdQ?=
 =?utf-8?B?VHl3M2N4NEp5dG9Gd1dyeVhYcnplNlhiUlk1M01SV0swWHA1Z0l2WHc4aklZ?=
 =?utf-8?B?MVhHT1pVeHF6YUJDamo2blF4NU1JQlNsWWZLbUErTXBFYkRNc1c0K0dsSWxH?=
 =?utf-8?B?ZTRjaHRUS00xbFdLYVpILzdmWFRta0tkaFcxV2RraWJtY1BxczNZVkRCa2gx?=
 =?utf-8?B?ODVSSWJ2S2lpbzBVWURiYVNycnpiZVFNSk1mRGMraXRtYmtSb1JqRnZ0OTNj?=
 =?utf-8?B?cUhqblpucUhoZUJveFJ2bUpGRiswYU5kSWZjMnlDbFFuVXgzTHB0RG5hYldm?=
 =?utf-8?B?aG1SY0lId2RPSDZpTGJOS2FGVnV5b3pCbzJRR29SSGRSYTZCcHhKdWlUMHNL?=
 =?utf-8?B?cUJUY0x6S05lcUs0TmU4elRBcGFrMlJtWlNyTVJwRm8vbzRGOFdKbUErR3gw?=
 =?utf-8?B?TmRSRlhmaW9OWnBhSUprZC9qQm5hQ3BjeUFLV0ZKWklWUlBBN1NHZTJiNWFk?=
 =?utf-8?B?MTFQL3ZsNlJLaDVvMFlaUjZxb3c3MHlDSmxtUmFJWmxpUlB5ZGMxR3RVYWFn?=
 =?utf-8?B?UDdoUklBMzBRYndrR29VNTd6ZGs4eHFITWtiSG8rVDd3YmQ1UHNNZm9uQnpT?=
 =?utf-8?B?SmpDc1loOWpQdVNydWNhOVJLRGJycEFzQ3djTVFpSW91MUttVFhoanZpQjQx?=
 =?utf-8?B?UEREWFRjWGZqS0szaUxES2tienJPdVdhcEtlTEN1TVlKUkxSSTNFL1FDczlC?=
 =?utf-8?B?S1RJUlg2bWpTOUFiUExtSmJjcHhIc1pRaGRsc0lvZGdMZURsYktCV3pRSmZt?=
 =?utf-8?B?SzRtSWxkV0ExSnZsM011TlFqRC8rSXc5T2JFQ0xrdmc0Z2ZxNmpucDR0NVNW?=
 =?utf-8?B?VVU3SlI4TUtMUTFUenpKdm80R1JFbE1rRnNDZDlBelkvZGI4T2Q0Si91RjF2?=
 =?utf-8?B?dk5UMU8vOUM4Qm5VeFJISldZeGxMMEV2L05uRVQ0a2YzU29nSCtJMm5td1kz?=
 =?utf-8?B?MVZBcE53a2dJeit2dDFqWURpR3lCclBOUFgySEhmdzdHVUpWdHRqTUE4cFBY?=
 =?utf-8?B?YnZ6cXFpMWo1TGNscVhmYUZzNmtEajcrK2Q4RlVQTFJqTWNGV2NFNWVNVG8r?=
 =?utf-8?B?QzR4WlhsWmxzNVQ0Y2c0SHpCMForMGxmdDJ5T1lmKzhjd1IvVWlNRzNDL25N?=
 =?utf-8?B?b0UxVHMrNVIvajVva2xINytVNFBkbjFTS25TQXZrcVZMcDlQQm9EOTdRNkdW?=
 =?utf-8?B?ZFNERzNvd3pOdkw5ZndDNE9VK0tqWDFjdGhHbGxHRkVORjlTVjcrNDlGeEMr?=
 =?utf-8?B?d0tnMzFnYVBjUXN3OUZIdXordVRGTGc4OGpCNVpjOGFwU0NEenlpMldmM0ta?=
 =?utf-8?B?YTAyS3VUZjVEOWcxT3hYc3lGREFNOGh1akhrdk9rV1FGNk5KMXc2NnRrT2E4?=
 =?utf-8?B?ZUJjQ1R6aU52RzZPYVU0STJuVVRyY0VMTThLWUc3OC9mWjVwTGFCWHFla1hV?=
 =?utf-8?B?VmQ2S0Z1ZVhXaWE4dk91L1pCL05rcTJKaWdQNHRnakZNSFFQZ3dwZitWeXpn?=
 =?utf-8?B?aVFmaXZXV1J2UU9nNGxFU2h6MG9ZVDh3YnVMM3RwMUdtWTFpQ3RSbEUxV0d1?=
 =?utf-8?B?dDdkUGtsQkZlNFNmVVVjREpTKzY2cGx6SGQ0NENDajM3MWxocm1XZkNiUlVU?=
 =?utf-8?B?eVVHdjEyelVPamZvRUU1ekR4Vlk1cFFoblJ2QldRS2dQYmF4bzVybHdJckVp?=
 =?utf-8?B?bVlmR0dteWpOemlwTVp5RUI0MW5XNlBDT2w1MDdKL0ZvYktsMmxIdHhNZVJl?=
 =?utf-8?B?VEZmZkJLbXdyZzJmMW82LzBTdVNnMnArMWxleGJDSTF5UFJjUm9CV2lDeXQx?=
 =?utf-8?B?RWwzMVhzU294N1JYSldjZVA3eTYwYWI0Yk5NaWpzR1FCZnFhaXU3ZmJUUmxt?=
 =?utf-8?Q?7dQ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdzeXZmZ2xhb0dCNkl5ckVTSC8xQVc0SExkeEkvMVhxd1F4dEtoMFRxcGZU?=
 =?utf-8?B?Nmp5MTdKeEhVbXNGalExa2RnelZ1dkYrcTN0cGxOY05UZDc0Q1VIdEZLQ1J3?=
 =?utf-8?B?L2JncEEwdWE0emVJcUxtOGFhLy9WTWlCb0gxYW9ZdXE5cS9Zalo5Q1VmOWRP?=
 =?utf-8?B?Tm83ODViL29YRUxkb3lEcG9pd3VnZ2FlTUo3SmpzR1FvTjdzeWtmdnhhZEM4?=
 =?utf-8?B?MUh6amJ6eHppKzdzZlJBeXlYVENLd0o5Tjk2VFpvR2hKcFR2VWtRQXFBdTV3?=
 =?utf-8?B?cUNOcjhoSE1QQTIxd3VOb0pEMXJ0VmMrK2l6b0dZQmN0djY4K0JTZmFlZkg5?=
 =?utf-8?B?bVh5SEFVaUJIQm1MUkZlcytuQlJKejZINHlQTys1eVVtZ2pjbEt0d1B2c2V3?=
 =?utf-8?B?dVZqQ05kaFNia2k1OWZIVGZRdzErcURDZ2xyVEFwanNFbnZUbGhnOHNvSkZL?=
 =?utf-8?B?NTdsL1pVUGNXMHNMUHVHbFRjcGlKVUg5T2dNZWhDNzRKelRDY0tXc092ajZG?=
 =?utf-8?B?eUVDOHE2V3llQmVTVVZkWFprRHI5ZDNMRzZlemFpVXNpR3FBeXBwWU9yNHNW?=
 =?utf-8?B?b3hUNUJINXA0d0xtbzgxd2s5aElDZXV1d2wrQXo5NnZocXlHT0dIdDRkZVlI?=
 =?utf-8?B?WVc2djFoUGhIN0IwR3hIMjNZbG80RkVSdUNpS2tVMjJwNkR5bUFWNXh5bjlV?=
 =?utf-8?B?NEpEYkVZYTZBUnpkK1ErL0I2MGFXNDNZVjhrUmhrZkY3WFpsMnRtc1VBNWF6?=
 =?utf-8?B?SXZUQmdnQVhUbTFQTS9qR0prdjdtZlRWZTJIMGRGdFl2ellTdEtmeVp3VTRm?=
 =?utf-8?B?ekw0akszWkkwNVRuOFFNNjNYNDRXOXZIb0NPUWV0bnlERUt5dXlCMnh5akJu?=
 =?utf-8?B?VTZ3aHBwazhsa1l2OU14bWxQVzZwY2VXR2JmTkdGSklaTkVIK2xQUHlHVnZQ?=
 =?utf-8?B?a3EySzNQZTVQSDJveklDV0VMdCs4Zk1RTUEzK25mUHZzbC9pNy9EK0VhWHFh?=
 =?utf-8?B?MXZyOTZnalpTeFFyYzNzMlhXTUZQSUFadVpwV21yNVNqQTQxdnF6aWh6K3cz?=
 =?utf-8?B?Q0hTcE5zeGRsTHM0b1A3RDBxRkZsMmp5NmdJelFlRHF3ckgvcEJHc0xaVFlT?=
 =?utf-8?B?V1BleWV5U2FCRGRscVI2bkF5TTVRandSMVFnbmx5cDJ4TUJsV0Y5dDZoOW5o?=
 =?utf-8?B?My84RThxVGxCZW1Na3lPQStTb3RuYkxUYnJLZDdpRUlDdTQvKzhISkZhaWl4?=
 =?utf-8?B?ZnJ1WW1FWEFCK2RxM0tVdjFIdkZGVUxoWncyd1ZhSThOK2hRYklWT0ZNR2xW?=
 =?utf-8?B?akdBNE00d25XQkxRZHJ1amJxODZnbFlpRC9TK0lHMDl2Z08xbVR3cDdhd2lj?=
 =?utf-8?B?SHhPMURJTVB0THlXbU9yQ0ErVkcrU1dPdjN6alhvd0ljWXM3aGIybzhndXZX?=
 =?utf-8?B?T0RZYTBlN3hCalZWaUlDclhoZjFlU0pkc3M2N0RJYTZEUUZvWTVsWHVYRTlZ?=
 =?utf-8?B?blJpTjlCMXI5UWJCSFRZU1ZxcmJCS0ZIMUtYVjF0OUJyUXR2VEhUOFdwNUxX?=
 =?utf-8?B?MzJYVjh5MU1qczI5UUZKZ1Y5c0NYUWJFQ0p1aTZ6QlorUjdOK3Bad0JDc1hH?=
 =?utf-8?B?OENlaTY5Z0xBdzRaUlRWSWZuWHpzU2Fua0ZNQ1VUUkUyTE9qZVM4TDdia2cz?=
 =?utf-8?B?VDMwZldjQUZVRzBiSmpZOS83eVI2bE9VcnFPUWFlOTlOa2hUVHMyeG5HYk4v?=
 =?utf-8?B?eGkvQW1OeEZSRkV2bHYvNktBTkI0bXN0YkozenE0ZHFqcUxCeVhZejREdGpQ?=
 =?utf-8?B?c0w4RG9DdFpMM3FKbk1FTTE2aFdjZjFVSzBibUNlZlYxcXlxRG1rOWhUR050?=
 =?utf-8?B?MkMvK2ZpQWxWY1VaNmhjNzc1SHdCT2xWMmU0WXhyaXVqWmgvSWo0dDBnSVAz?=
 =?utf-8?B?RmVXTEQwS3psbm9RZlM1M2d0YWNaQlRjdmJYQUJrRlhjYVc4bXFMWU9SaWVr?=
 =?utf-8?B?QXNUTUpWbnhsMjloWkF2ZVpaQStxQmJJOVgvMjZVZEpPaUdCTUx0UmI4bHdq?=
 =?utf-8?B?YjFWVTkxSEVxakpSbHVwUmY2ZG9LZUZtTi9kbnhEYSt6UkZDY1NmMUpNTTd2?=
 =?utf-8?B?Z1AwR1RUTXdLcXFLS01Qa1ZGUGZLWExoWGVUYnhUUm5wUXZJUGQvbWJUZmxS?=
 =?utf-8?B?dWVPdEpHVHpBc29WUU5aYjNxK3dFTFJSZnBMdkdibmVGSUVZYjRkMGFUT1o2?=
 =?utf-8?B?djBNVjlOV3I5SGd0aDdzTUdoNGlUU20rUVIrdzI3bXRkTlVlbXhORXlEaGdD?=
 =?utf-8?B?MDhKVnRDd2F1TTJ3bi9qUFBISHc1VldHZ2taSW5wVWpJL00yU0oxMzBhRURy?=
 =?utf-8?Q?f27uO7Yawr2oDyuA=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fddb6c-d052-4ca4-ba91-08de63d9a2d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:39:12.5376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpVS+ZgyCrCetMjiQeRNnYI6zLTIVIFfGtvfpnIXP3RpvQCgzJLG4XN6sxYD0m0Akz3gP3d12ydImQpauGPXq/Ya6K9uRTi8YHC+EpsrUB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR02MB10850
X-Proofpoint-ORIG-GUID: RvFOh6bLDDGRytdh668ZL82-Xp6umlBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4MCBTYWx0ZWRfX6dtHksgc9hMl
 2aiHq0bTDOMGonr45XHywGr5aoYpgjltEXBglQQirIst7Es2krqyUEOF5ipbi61ascHqSlFDx7e
 /QU03QC5P/BIieYSv+xn93tAbD9wVkPmKFqaq3NO9UISb9IDD4oCNdMnqNd7FI6xlPH37qG4FB1
 9Izlb2ajZo1gEn8L4txoYEwXUalN975hDavcVdmkSdui8CEulhS9LPeXgu5hcKPr9mwzWtTKuIj
 Yt9oTDTwPyJRrIyXK3jInFkWKbp9gQImOmp5Zer2Z3B1gjn5dWP8LACa+RhPQH+Kvzx2uYaEKdn
 IUq8Inpw3DjojGYWgbBlOMd0rxlsuAnFaBJsaa4XLeRBaz3xPOXd70V4i5b5ZW7cY4j1dyKbl1f
 qbjvC/jYrEK4JDJrK+3fdEcqQIwmFrSKoLYB39AE3iLM5plTj/RM87kGoLY3o4MRQ9FcOwHew4c
 v5gPA23JBfr/IzBucaw==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=698321d1 cx=c_pps
 a=eiJXeYcBrKiqJN7PW0oR8A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=T2b3pr8BBwGlsXMQR4EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RvFOh6bLDDGRytdh668ZL82-Xp6umlBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
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
> It shouldn't be modified by the audio functions.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h      | 2 +-
>   audio/audio_template.h | 6 +++---
>   include/qemu/audio.h   | 4 ++--
>   audio/audio.c          | 8 ++++----
>   4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 25de0e3f9cf..a6276375887 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -265,7 +265,7 @@ extern const char *audio_prio_list[];
>   
>   void audio_driver_register(audio_driver *drv);
>   
> -void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
> +void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as);
>   void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
>   
>   int audio_bug (const char *funcname, int cond);
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 1ab3c47fd76..e69e6e74570 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -159,7 +159,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>       SW *sw,
>       HW *hw,
>       const char *name,
> -    struct audsettings *as
> +    const struct audsettings *as
>       )
>   {
>       int err;
> @@ -426,7 +426,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as
>   static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
>       AudioBackend *s,
>       const char *sw_name,
> -    struct audsettings *as
> +    const struct audsettings *as
>       )
>   {
>       SW *sw;
> @@ -491,7 +491,7 @@ SW *glue (AUD_open_, TYPE) (
>       const char *name,
>       void *callback_opaque ,
>       audio_callback_fn callback_fn,
> -    struct audsettings *as
> +    const struct audsettings *as
>       )
>   {
>       AudioBackend *s = be;
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index a1a64ad340d..370e993f080 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -58,7 +58,7 @@ SWVoiceOut *AUD_open_out (
>       const char *name,
>       void *callback_opaque,
>       audio_callback_fn callback_fn,
> -    struct audsettings *settings
> +    const struct audsettings *settings
>       );
>   
>   void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
> @@ -97,7 +97,7 @@ SWVoiceIn *AUD_open_in(
>       const char *name,
>       void *callback_opaque,
>       audio_callback_fn callback_fn,
> -    struct audsettings *settings
> +    const struct audsettings *settings
>       );
>   
>   void AUD_close_in(AudioBackend *be, SWVoiceIn *sw);
> diff --git a/audio/audio.c b/audio/audio.c
> index 5b9d352f325..6eb921f0cca 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -169,7 +169,7 @@ void AUD_log (const char *cap, const char *fmt, ...)
>       va_end (ap);
>   }
>   
> -static void audio_print_settings (struct audsettings *as)
> +static void audio_print_settings (const struct audsettings *as)
>   {
>       dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


> @@ -215,7 +215,7 @@ static void audio_print_settings (struct audsettings *as)
>       AUD_log (NULL, "\n");
>   }
>   
> -static int audio_validate_settings (struct audsettings *as)
> +static int audio_validate_settings (const struct audsettings *as)
>   {
>       int invalid;
>   
> @@ -240,7 +240,7 @@ static int audio_validate_settings (struct audsettings *as)
>       return invalid ? -1 : 0;
>   }
>   
> -static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *as)
> +static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
>   {
>       int bits = 8;
>       bool is_signed = false, is_float = false;
> @@ -280,7 +280,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
>           && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
>   }
>   
> -void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
> +void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
>   {
>       int bits = 8, mul;
>       bool is_signed = false, is_float = false;


