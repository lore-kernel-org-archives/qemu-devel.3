Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F37CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZna9-000099-DD; Wed, 17 Jun 2026 06:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnZM-0008Pt-Pf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:32:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZnZJ-0002Nn-Hl
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:32:27 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8WPYM936869; Wed, 17 Jun 2026 03:31:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uDKEceUn6atkbaqaavRkA7+nmmIELmOePmCNTTX71
 Rg=; b=07sqpy/gQVlybgy2FIIWYB/pln2xgoGbmdZRDgV20c/zEjqub/jMrtyis
 cu62NPmNVqOA/35eq8ltoCrFmR+xB8uH5+lvv0t0EBBZEZFQsUxQjO/MNJnDxu4z
 qrehlWuojYshzJfiAi6uPBgO5/uQ/ze3YshcQ4v2imPwipa/FKweMC0sAoaJCoXE
 jJbSXacT7/r7E1op9/DzlMMDypUVnQ8xLYfnD9gOrwo2ZvgfCVYAPb008l9w2/gc
 /UnwZQiVPKH081Ihp2DoBjKhkTd0/PtMNtv0LLKeilPCzPl5EtCQmC1akCJma8Pw
 7Waf5Hogrw9FI4Zxb8U+HFRQIu3TA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021072.outbound.protection.outlook.com
 [40.93.194.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eueg21fv1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 03:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPXovlxqq5JTb7fDCru58rMSSgb89UFLqbzRyZr9KNcdogULb6WMERM25BvT3ly8HnWQsMJXoZsy26E35JttR0gEX7PIiVNO4Lt6Xxxx1Tdp47/ljUWstt3V//ppHy6Pwlv1zZQN2RMi+WpEDErp+fzwf8V0FHqC+RHGhWUe2M6GzwU7gpF+4/NoJYNPxxyG8Pgc/CqFdNpAW+2piifvzxNmGj1KGHok2Jl4vNUKzrhU5+FYRmELzVj2PmZ0zNo/5/uYVUz/peaOb7WUvwhJ+EzrKjmjZPTylG6sYKDZnlptq1nN1rUt38uP0ikvi8TydZs6eefYQGtGkMgkZHl9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDKEceUn6atkbaqaavRkA7+nmmIELmOePmCNTTX71Rg=;
 b=uQVhCqDZgiPfpqmsllCzH43j7IETJpBYUZyzjLq0VYdciP0isluhKU6Dqs6N65Mkf08O+oEWo33q9hgzUXcY5KDq+EE45CnXwF289wxQD/XYd3sCM+suK+MxRUjpQGM8k8qcG+/kO1Yvznn0uJN5fzk4SRH5rCElj8gtWJJFjTCOJxrv6CXQVjPM/V1hqAImgLI/tc4nm5tbQtCWia1F6Im2GdNSdUHeWdTJVUoka29ShMECa8MaXsXTlKchEzEIk/oW5OOm7rL0qxGF654PQP+bDBcvqgWrJWPeXWHQIR+PoGfmVodQT+YNpDi5IX2hc8h7KL23dHA1mc4mQAgkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDKEceUn6atkbaqaavRkA7+nmmIELmOePmCNTTX71Rg=;
 b=Bun3N3X44MyFx5/BHAB2ubQtgvRSpYBlrK/6Smy9YyHMJs58uwm3ZLAQqTTY0JFMisLFoHNI9CShbymX9IrXPaTfherVAHprMy1ipiNrh9JmnYbC6G1uXxQ1bLdFnuNdKKUhrfFS6Oi5X7KIQ4hSiX0RNSwlVm3c6BOF+oVWo66WVAz489iqbL01dDVzd4JRmnoGX1+fMDKg5Pe1DtNxYOA+57HsyvSz1kh0S519JHyZXW9sgdPa973kFYyNFkwMBHy0jWVolnoldvYdJDHRdDbE0OwKVMwC9AEBsHJXMAU5q5cO13epMyxd8ozkxPVJRa/q1TN2L1umnNkipMmySw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7440.namprd02.prod.outlook.com (2603:10b6:a03:29c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:31:50 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 10:31:50 +0000
Message-ID: <b98ac13d-e508-4c0b-ba78-6e0a63f73e65@nutanix.com>
Date: Wed, 17 Jun 2026 11:31:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/7] qom: deprecate embedded objects and instance properties
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0078.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: c273f23f-1e05-493e-0a73-08decc5ba45b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|4133799003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: dadQHsEIgoyI+LcnIAkkGjXB9BikUhQnKO2kXiFEbDUQCFF/HsuiZSaxlekRKfSGn+XduLkcnp0HyJi8fq9+CRRpSvkFleZ8S+0PKXhJjphSlgN6neND8I6iIGru2Sw4Jb5j32ztNv8e4U/1ukwL2R0+oQRFBCDlp7d3sJ/krIsIFapnrMvIbWW27MRqDLcxKIFETnljrNC4488u76xeCT+PkPA4DmWByTcNKOcVJSQM5zRN2+dkJXFmsMNKF0UbqYyVLWulQEa/sN9gBPVe1ozPrmG3Ao18oPJUp89nWzvpe5jilKbGLECFEtqgPfG6tbu2OxxOHjBg8+M2dvobAMoVqEPoMNDcGQdJVOBDghtrbFMKBZ6MMgFdAGxmfQ8Xu4KygLR4gUw2y65n1upRt2E5Ige3a8XUt3oSczZqIpAqIoGP/r9lY4msgzUWBKK5htETsMYOU9YIxizR1PMzuhI+Wl1KrOA0T+FjWts1QdjhrYN8O5J0FSRwqFAccCjI7n9rYU5Ht3UsFEvCssRvSPn7/9v2fmUSwsRIqcfwWPjRQUxnN48887de0E1ltX8zpgz/aqLB5A1l+caEp6L1FIl+qNg/xOlUfPT7cH9/YbNGXxP1OtXWEf/pvNHboICJipqYda5nojOz54f618JvT1jAZUR81TaYkOu09G66lTNpyt8RqbJqA02lhRcJtUFsXk+zDxoFbVnqRBRKMJLGRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(4133799003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0JvdDR4TkNuVWxSNDMvajJQdGlkYUNnZVdwTlJiSmlEM05sakpkdWgrdm1x?=
 =?utf-8?B?RzdMM1lvY0RQZTA3QlE2RnJpTFhvRXJQYVk2Z2VLLy96V20rTU5OaDBLZCtY?=
 =?utf-8?B?Q2tCYUx3UmpySW1aSVl5UkV6cVhEVjVwMDNnR25LTzV0d2xrb2Rra2VLVW5V?=
 =?utf-8?B?UkJPTWdlc1Q0M2Mva3UwREdRYi80TXlnMlorTGhhdnhDSFI3TzBkaW1xQlpa?=
 =?utf-8?B?c0lPcGVHZXNYVDFRdVUxODk5Q3ZhYmxyOUE4WFNabVlmelQ5bVNIWkp3V0lm?=
 =?utf-8?B?Z3FydnJ1WmlIRllqN0t5aGl6MklXd3k1cGZiakFxeFRtNitsMUkzb1c5c3Jx?=
 =?utf-8?B?SkRjZFFuU3g4NzB0cTN3NHFoRkE2RVBVUktMd2YySTVvNUFtbXR3dnRkVWl2?=
 =?utf-8?B?Qzh0TWtqaDF0bkVpRytHUzFPRTJVZktWTTdEOGcrRG5GdkpGVm50L2ZIcGlp?=
 =?utf-8?B?aXc5bFVybHF5Mkt1OVZTUWZDd2dvQzZ6L2N6K0h2RnF1WFlwYml3R3JUSHh0?=
 =?utf-8?B?cHBMUXlzR1plcThBLzdOTW0ydWdFMDU3OFFqRUFreHJ5Unk3c3l3eGtzL1k5?=
 =?utf-8?B?UzZUbk9WRnd2aDNSeTRWT2QvbHZ6VWlBOFRkOXEwT25QZlVzazkzRGhwZ2Na?=
 =?utf-8?B?ZDNwMVlsQVpMeGZXUzlKd2daYkpYMUxUdG13Z3pMNnhhWmRrZkEvVU8vd0pW?=
 =?utf-8?B?cE1wWEVIOXZGbVBiZFlacnZ2RGFSbnlEYmZkcVNNUnRjcU9hMlVmMENqSVBU?=
 =?utf-8?B?QkllaXpXRm8xK3I5K0NMMktoTS9Wc2VUU0Y0YU5XSVc3MFdmVHRRMyttVFlW?=
 =?utf-8?B?Tmh4b1ZwSG9QOVhhSGxXWFRkc20vdnVKT3U2SVJ5WnJDdW54NW0yZDY4cFZY?=
 =?utf-8?B?S3FUMDEyV09XRkdYWWp1N3BKNHJWbmdBblh1R2haMy9tc2dCdGF0S3Y1ZEdv?=
 =?utf-8?B?aXgrMFVtNFFuVmx3MTd1VXpFRFczV2kycjdmUFBKRHF4YnpzdFZkRjZUL0ow?=
 =?utf-8?B?VDVCMkxBWXFTUzdtQWlGZzJxU3JNVm9DcXA3Z3N5dGMwVUUxUXlMUElWajJp?=
 =?utf-8?B?Vnh6bkdqMFpXNEExWTdXSEhzeG1hcklLTVc2Ny9sbXhDTzB4TGZFeGxNMXpR?=
 =?utf-8?B?U1hwR1kzakVsTHA4NGJZbWdmVkU2N2lrcUgwVnMrSHdHQVdFYjBWU2FCdzMv?=
 =?utf-8?B?SGptSmtkOFB4ZUsxYW5DTXZEOGxxM2h1TTNmakRyUzhRV2dmbUVKb05YNDcv?=
 =?utf-8?B?QUhFcTMva1VPQXJjcWlNbGM4QlF0MitHamlwZjE0SElibCtpWlBwUDZZQ3pn?=
 =?utf-8?B?RnFqdFRGa3JHcXhDbHE1ZURHRis3ZjludzgrWGxCZU42QnF6YXFZVmIxUzJD?=
 =?utf-8?B?OXdoMFJWR0Erc3NRc2R1cUR5MzZ0Y2NlaWFYMEJhZCtBbUp2dWM1RUdPUlcr?=
 =?utf-8?B?UFIyUzlBWXMrenZycWR5MVlaL1ZJZ2c5UkRZcjhKK3Ywd1pjeGJvVkRuS1dI?=
 =?utf-8?B?TmJ6eFdoNGFwQ3RUc3dQeWhNNzZHVS9DVnNHUkV0bHdTTTlONzhDUWFLVVht?=
 =?utf-8?B?U2J5RjZPaUtlSGY0YXoxUUxPNVlYa3RYWWI2c1IwNUxLTnovNW1nY2JVL2p5?=
 =?utf-8?B?eTNjQldYQjdZNHhCRHFmMXRQWTJaVHJpRXNSazNnQVp3YXJVL3RlcG96Zm92?=
 =?utf-8?B?dGZQZnhrWTRab2Q4QjdsQjJHMm9CUEg5ZlFPbzljb1FpSENIaWEvV1RQUzNH?=
 =?utf-8?B?QkNiUG9wWTJGVURBVXU3dXg2ZmhKUERBQk56bC8rdlprZ0t2U0tQVkVFd2ZV?=
 =?utf-8?B?Z2dYV2c3QUJjY3lzb0pkWGI4aWxCN1VJM3ZMU1MzYk9SamQ2RFN0MmJ5aVNK?=
 =?utf-8?B?QTQydVFRZHZOK1ZyWDNZbTQxeks4SzZJcW1YOGNXVndnZWo1YkszcEZHSTdZ?=
 =?utf-8?B?ZGlNVitkd3FFWGVUNFRzNG1lODhDbm1TR29ocFgxckxTRGx6Y3NlaWJxblYv?=
 =?utf-8?B?c1NaSDJnT0xhTGdwWUsvOXpDZ3NLc001MUN0dUxyWnYrazN3NGlmMzlVWHRS?=
 =?utf-8?B?TU1pRldWWEhhS1pnZTZsNHcwbU9hWjZZMThMLzQrMTlvOUo0akhKVm4ydGdn?=
 =?utf-8?B?RlZxV0lsTjh0RnF0Q0tmQUtIeEJ2Q1JPS2NSK2YvTUZCYUd1cERHMkVUVEM3?=
 =?utf-8?B?WG4yZHFVeEQyemxQeTJFeE81MGE4ak4xa0J6UFpsS2s5MER0K1BHWWthZVpi?=
 =?utf-8?B?RWJOdVN4RGpraTBiQysvcHhYT1pzMTZ5K2FFWDJkV3pMdzhwdk82Mk83aGth?=
 =?utf-8?B?YjBncVRTRlVzcWVCQkoxREhIUzRGSDFFbDBNUE0wT3NOZkU2UmxTZmwvd0VN?=
 =?utf-8?Q?2T2OyDgZdKUBRV2Y=3D?=
X-Exchange-RoutingPolicyChecked: npkKaVx6ZuhHYQzmJCUtfJ5+6N9Q+Kgdbt0idjlYZVVErq032eFtr/vcPotjaabhrRMXuv1VvkX4hew/JGQb4wDwi+GXDsdIzDrJrbGth6/FnLakX3pSHkX5qM9cGl+0bjNUVNjkURPLhGvwmOUUATSHBwzved1GX6gmUGVMAtX5Vsv7aU34X3W5v63P3k749myPUSaHt61OlB7BYuHx4AumU2Dn8ZmVvl0Cav1hAcqKuPYR3QMLvHGSLTKf4TdO56Tqc13li+eVJU35dIAlWnwoCAFtUrh+If12PHthRvbBj3VtIBDtflSOLnQ6iOITIZ/rH+99dI764cVynCL1nA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c273f23f-1e05-493e-0a73-08decc5ba45b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:31:50.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58Dslrfm8HQz//rN5CWpnJyxvW3c3ubRu1V4Kx9ashtcE9CIldDyq7E62JW6PayVAtetX4lrbWFtP85oSNkHGxZ8xSALy0nEQe5SQb2In4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7440
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5OSBTYWx0ZWRfX2rzVlFgiiCFv
 C9mLcMX78KI10yfzcBlJML3TXNxXq/b+jnjo7sL+FP65e5fHGgJ0kF+uLd/DVTqq6sjSBFSkgz5
 dPTc4Dfq3P35QOqyTsh1v0mw5R3lggPr6GrdxiVGocS+/Cv31SZ3easvzCJZYQXYQA/X1tFuJR+
 uqNbs3OL2RXXQOR5409sPrNjK3GXiU4yoas+imVpAWRodJ9KlpfCBLWqph7sbMPDWXl6Tiz2Hr8
 QtLkkQbc7mI7KambOiEA7Pacot8Fwe6+0esMoLJuIdeoIqXJIiCGPiRfir3D0o8Wova6Zik7rsG
 Dz8cDJpKWiaaHCU5dJ3SvHLvC0ESsHCjDVgIKu+qnVExnGHwo5zHrhlA+D+Hf1HIN8rwgv9wUfF
 8Nn6aybc1K0pBtCeqJaCo8445ftLblAuv0ByvALsgaeqK2bYOo3sg6ieb0xQTyM0CaPnUfa5INj
 75IzhgS92l6iplLypsQ==
X-Authority-Analysis: v=2.4 cv=fsPsol4f c=1 sm=1 tr=0 ts=6a327799 cx=c_pps
 a=yzB2/XVe6vEcQXmkKcPEIg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=mDV3o1hIAAAA:8 a=69wJf7TsAAAA:8 a=3Ba92RX4PQYsbEHfC0MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: FuEiT0CkjbTajmFGehaMBmNHUjbL4jqf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5OSBTYWx0ZWRfX6NStFJWgTY11
 XR/u29QjrSDn3ewCqnGrJl9hYEt4r/hdRsPntvKqWaaqe+4FYhEAwlpNdUTXrYoKfkNvaHoPhFC
 ccTv+3RsHxcEjopL65xnUKJrN4xi/IM=
X-Proofpoint-GUID: FuEiT0CkjbTajmFGehaMBmNHUjbL4jqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 16/06/2026 16:55, Daniel P. Berrangé wrote:

> QOM has two rather unusual / surprising features historicall
> 
>   * The ability to embed a QOM instance's memory inside another
>     struct
>   * The ability to register properties against the instnce
>     instead of struct
> 
> While they both look convenient on the surface, they also
> have significant undesirable side effects (see the commit
> message for each patch for details).
> 
> The premise of this series is that their convenience does
> not outweigh their downsides, and we would be better off
> long term by eliminating their usage, rather than trying
> to add more hacks on top to mitigate their downsides.
> 
> This comes out of two separate conversations this week
> 
>   * Migration series where Peter proposed changes that
>     make use of instance  properties. When I commented,
>     Peter rightly pointed out that our docs do not
>     discourage use of instance properties:
>     
>      https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2026-2D06_msg02368.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=v-N9FJZ1ugUjERquAp1KfuZ3B20G9mdbHpEEFP5zkfs&e=
> 
>   * QOM series where Akihiko proposed some funky hacks
>     to reference counting to better track object lifecycle
>     when embedding structs. We had a short discussion about
>     discouraging QOM embedding, so this is a real world
>     proposal:
> 
>       https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2026-2D06_msg03459.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=mHTDgFeywt1U_2Q9uTnAyG6zp-VjguJ4DZIJAX59vaY&e=
> 
> This is not likely to be a quick task, so this series
> starts small
> 
>   * Adds a "QEMU_DEPRECATIONS" annotation for internal APIs
>   * Deprecate the QOM instance embedding
>   * Deprecate the QOM instance properties
>   * Deprecate the memory region embedding APIs
>   * Deprecate the IRQ embedding APIs
>   * Convert PIIX to eliminate embedding as a
>     demonstration.
> 
> The QEMU_DEPRECATIONS idea is an effect to improve our our
> historic practice where we introduce a new preferred API
> and never really tell anyone the old APIs is bad to use.
> 
> If --enable-deprecations is given to configure, every use
> of a deprecated API emits a compiler warning. This is not
> enabled by default in this series, since we have -Werror
> by default.

I'm not sure if we're ready to start flagging things via the compiler, 
however I'm in broad agreement that this is direction we need to travel. 
Thanks for beating me to it, and starting the conversation :)

> Note that the proposal to stop embedding memory regions has
> been made by Zoltan earlier this year and was rejected by Paolo:
> 
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.nongnu.org_archive_html_qemu-2Ddevel_2026-2D01_msg05435.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=oAY3a1R4rnhYdl7-qnoTVjVdGOX1Qj-GvGlOX77oZrk&e=
>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.nongnu.org_archive_html_qemu-2Ddevel_2026-2D05_msg06665.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=WmpukrnrmuhhTz7hLgAA-9FStZ3fbzH3P1aT_U9f6GY&e=
> 
> I don't really agree with the analysis there. IMHO,  the
> concept of embedding objects is to horrendous to allow to
> live any longer. Yes, that's a big job, but long term it
> is worth it.

FWIW my main objection to the series was that it added yet another way 
of doing something to fix a particular issue in legacy code. I have a 
suspicion that if we can make everything in QOM properly refcounted then 
this approach could work globally: in particular I can see it would fix 
issues where the flatviews hold references to memory regions outside of 
the device lifecycle until the RCU thread tidies up.

However as you can see, there would be quite a bit of work to get there. 
But at least if we can all agree on the way forward, we can start to get 
the relevant changes in place.

> Daniel P. Berrangé (7):
>    meson: add --enable-deprecations configure flag
>    qom: deprecated embedding object structs within other objects
>    qom: deprecate use of instance properties
>    system: add memory_region_new / memory_region_new_io
>    system: add qemu_irq_new / qemu_irq_new_child / qemu_irq_new_array
>    hw/isa: convert PIIX embedded QOM objects to heap allocated
>    qom: improve error message for invalid ID values
> 
>   hw/core/irq.c                 | 35 +++++++++++++
>   hw/isa/piix.c                 | 65 ++++++++++++++---------
>   include/hw/core/irq.h         | 75 +++++++++++++++++++++++++--
>   include/hw/southbridge/piix.h | 12 ++---
>   include/qemu/osdep.h          | 19 +++++++
>   include/qom/object.h          | 98 ++++++++++++++++++++++++++++++-----
>   include/system/memory.h       | 76 +++++++++++++++++++++++----
>   meson.build                   |  1 +
>   meson_options.txt             |  2 +
>   qom/object.c                  | 36 ++++++++++++-
>   scripts/meson-buildoptions.sh |  3 ++
>   system/memory.c               | 85 +++++++++++++++++++++++++-----
>   12 files changed, 433 insertions(+), 74 deletions(-)


ATB,

Mark.


