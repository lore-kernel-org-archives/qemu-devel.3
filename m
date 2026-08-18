Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D381C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKK6-00061q-LE; Tue, 18 Aug 2026 09:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK4-0005vK-Il
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKK2-0004jL-IP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:48 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDuWrH1687653; Tue, 18 Aug 2026 06:57:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=0AWmvHF1nf7op
 PufjQWJ4QU47VIXkuwNznyF1Zb3d4o=; b=LJl9ABN2dEuSo63n6eJrPv48XNKrT
 a83J8fuTyQtKaqOm228+dhIjEFNoaDaOGeE8YksqGlnsjxp6VHrkQ/0sD13ngDf8
 PM7R8dfzvW4BmaRYx+QuqJTr0LCthf0T22E4pPJ7p343H6DlrwBchGKJL+ro06aI
 vis7WfxywY8h0Joss4cTDAMNb5OgMED1hcOuhmeri4qfXo1O0tRyJ4ZErzGUeRxO
 CaEP7VAr341NqK+Hbx/YKB5ZvIHbei0/bfM2ZIgYhREk266ZvgQsrTAqV02/6AoF
 I+ikW5izxBdABvIy0tK+07LUzUznknxa1gHAxrGZKQrbHBNC+4xRO9YPQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020121.outbound.protection.outlook.com
 [52.101.193.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2m156u9x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrcEx55S+MX8uiBF8QNpix6bVciVEnNPsKgvMzMerm97ygZFmkLuBFh3HIRmNKoQIqsHARRhObINnNNK0YaJOg+1nSsLYnImD8l86GwKJh7Yy94OBjyFGajn0wS5oX9bpMGFrIB2iaWoWFaVwY8phsf0Jl9Za7PJOBzpCGlz6HyslSNDc4wIelmrGauenzCUsxPxAqdjJFHcASle07Kn+5Iv8FjopFTlczTZkQdpA/eSQtdWB//ltfAoAqqiM+npjgqUt94iAkSj8OnkMaM8ZY5j2QmAxwtRLY8Sm7onSaNi8PkRgdQ4i4FHuYZ57Go+gA/7Q1291EXQ0eV9gHUxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AWmvHF1nf7opPufjQWJ4QU47VIXkuwNznyF1Zb3d4o=;
 b=Hk0X7attqRnRpeI/7aH2gWSQw+gGuniWU2ynglyvFC8tDGaxM0uvyh0z1HYz5nMaDl/v5sfko/y3ubktrFM3Rf7fZBP95AhaUla5OqIZuY3elH78fIU8diddJ2DpEKNSrdad20DW0AXMCr94i/ZCLYUA6GOeCAjIAAqUT9TkT24Te6jqa1UDMOK9bN4MrYlABnTupoIs6TbVZzXUifRDjpMzztfRxcbvf+Yb8FwACfNokRY5DEHIf54y2h5l3roVMU0bsMw/DpvO43mQUDbaBw8yXWV/CLOaNy9s+Wd7WW0GeeGCkTtNMDL4dAb4pWvOp6T7BiGMA+/Zgm7Jpca5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AWmvHF1nf7opPufjQWJ4QU47VIXkuwNznyF1Zb3d4o=;
 b=SqH0arU7s0ACWKOOwFfUkh6/J7VRY7mioazOcpHFLLVAV0K3zqKzxsqw4me9QPM2bg4ECuGsyus4rZf8RJSP/QwMa+Al91oUEqpvmQ1Hnqb/FhruV0L7XfxbBLMUaaSimPYT974N0KCB1BlsJnRP499zDPs1WhMxfQrq2+VU4T5aGhpLdsbR3kbF1WMtOcmjz6R48dre3547MRB5eTmexuSIaKxK/YuRdJK5kQODj53mmOCO+mWdbNhPhqH0YejATKQy2JWiWhfF0f4ZLbDVVtZTEnWIglqLYI68jzpnehRpPhnX1mhkCyVraljg1ReL/SzMwoGlQEsvHizy2w0eFg==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS0PR02MB9103.namprd02.prod.outlook.com (2603:10b6:8:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:57:40 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:57:40 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/4] Add clipboard status notification to VNC
Date: Tue, 18 Aug 2026 15:57:33 +0200
Message-ID: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0024.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::29) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS0PR02MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 6452c14c-14fa-4b90-4415-08defd30ab25
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: VLnvaV3mUv6XJymMqQ9Of2hBvEhc+kfPVhGV5apoXz5l4u5gkhgCsY9+CYj05MwcpQdJgwZ/9+pyrru4ewMqZ4FtZo9Bl28Vxo0ZNyMT7rRaJfLqS+4ge5r+nIwF4PLehhQnracllGJhEeQDyVWN5rs3qJ/fweb9F83JWf/rn+3wyl70k5tV8xlGwDQfDLe9YJzljsv0eBWiP+AwW+98u8ut1ctcvanPNRE0DTMOjgOHh2pvSgdDQqih5hY+ATznCt7B6zwGteBwCdhVtDafVvFLwndGuwyCohWDFQ8TCVs8aKWuPeoaHJhUqv4o03SxbRKUvVbr6feDeeksJ50NdnvwGZZ2xbfwZW5eIS5tbXjl0RYAw9QaJ2mRv/uFVnxV8tzNHpKeLRbxoHVgOqoThwkS/OnZT4yMsC2ZgUfjSBDb0QkS8Sfxf9WDA4+11s04OoIwRVAnHdmYn/5uN2TDcq+WGd8q4vCxwear3yWwgYEw/W7fkc3hSfK47l6m9THa5QUdV8sH5GPNIIxg9fBKtsR4dE66o4VDe2mQPCvp3w0kAE4AR5Z4nveBs3Pg+Coua2PEY/4VA+rQDnEWpLbRgRdszkyp1KlQuLmlbtSPw4GOP2/8xyDuv9stY1NdXIaSMvsO4aIjLAEzGfsFbcgx7ZHlM/OGU2jh1tPy7OYSMKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVVbmlqOUQyaWRIaHBwWTc5QWtGUUlsdHpaWTdTa3UwZUNhbkd3K043Z0RL?=
 =?utf-8?B?THphOC9rTjFueWVac25qUzdsM2J4L0ViWHd5c01wNWJwZXdqNnUveGNWRTMz?=
 =?utf-8?B?QVJnaVlYS0tlYXVPZUxlbUNpUWVxSk04SnM3VjgwdFBMdTdkK1dQUE8rVVlP?=
 =?utf-8?B?RmpzNkdsazM3UkFTcjBPcnFXOWlWdWJRTHFXd1k1c2Yyd2N1QWVHZHFrRkRR?=
 =?utf-8?B?VUFtVk5OVXplcmlYZUdxZEJ5eGZGclVOcTNObElTT3dybnZTUEZiZzdETTYx?=
 =?utf-8?B?anNTUlhLV1ovOEcrU0hrZW9uNTk0KzlDRlBmQlMwSHlJSTluVnB3T2luODJZ?=
 =?utf-8?B?MEQzdHVuL25PaUN6WkREekJ1Z2pjMlhtL01CKzhEb3NBSDk3KzdpMWlYSWpU?=
 =?utf-8?B?d2lGeklFaDcvQ3ZpcTZUN2ZnV0dub3d2RDRXUW9xckZHWjFBS0RiK2t3L3Bx?=
 =?utf-8?B?bXhoUGhJZkFvcGtrRlJ2SDlZeFBCc2MxemlCb0pWWTFOMk44ZDJIaUlTaHBV?=
 =?utf-8?B?VmZCUzBpbll5b0ZVaGZuM0I0b3VCY0JNRW9JN1ZLTFJHRzlVc2FuenZ0WkJh?=
 =?utf-8?B?OUVZUUVTTVdWN3Q5ZE81aFRoQ1RZdmlOaFlXM2ZmdFF5MVFkL0VCRTZLbWZ0?=
 =?utf-8?B?UHVRbXQ1Sktmdi9Ia1B2S1VpOGpNNnVTN1N1Y0lZclYrVGlxZmYwc2tMK05S?=
 =?utf-8?B?NmtNc084Rm5NVHF1cnpFeEFnMHBzZVVLNVphY0xZZk1ZaDF5QjIrSzZaSGNY?=
 =?utf-8?B?RHpZNXM0dTlDNnVLZ2NTeHl4Ti9XVUFYbXRPRGR4SzIzcnVZekxmMTU1eVM1?=
 =?utf-8?B?aElrQnM5eFpycEUyL3NnaGZUcEpYcjlDeWoxYnV5ZHI5SkVaYkpjR1NRTy9l?=
 =?utf-8?B?Q2d0YVd4bXlxenRiUnBzRzFQNlRLR2FYSXZIdUxWZlo5Zjk2TUFFeVBjVVdj?=
 =?utf-8?B?U0UvcFlNYWFnaXhkZ3ZjRnNWeXVKaTFTV1huV3pZYnZpR21tVjhlRXhzVXZ0?=
 =?utf-8?B?SG9CK0RsVDVPbHcvMXFCSFRZK3laZ3Uxb3IxQUV6UUpVNXNKZTBZOTJ3RGxE?=
 =?utf-8?B?am82bUtaUXJIVHdrTGNmMHEwMDU5MkdlS0ptc3l1L1RIb1dza0ViVG4xZ01X?=
 =?utf-8?B?dVNJcVdiNkRrUnRsc0diZGV1d2RURTVKNTQyeitwNGphZmlHcFhPdDhwdlYx?=
 =?utf-8?B?UEp0NWJjbmZrMzdyVWF2K1VWL3EzS1ZMOWpmNlp2dTNFM0ZEMll3ZUNyMVVM?=
 =?utf-8?B?SHhvTTd0S2QyYzUzTFJkcWxYQjRVa3p2cll0bllndEpWdk1UNDZJRXVIajc4?=
 =?utf-8?B?bGZ3YXN0ZzRJL29JQ0FCYUFkNkg3QTRJanFzZ2tmL01jbWlJRitKZkExWTQr?=
 =?utf-8?B?aVdONjhoWGNoTkxscEYvdk9hbDdQeDhIUnNNbWlVR1FLOFNRM29QMDNXU3BC?=
 =?utf-8?B?WXZvSnZWNVl5RGJ2Kzd6cHQwK2M5bVJkVU9xZGlhZmpBWVlLOFVpUzNocEov?=
 =?utf-8?B?ekEyOUUwM1JHUWg0WW5LOUdzSjJrOGtNOWZ6YmFCSGFBK1phQkdMQmJpNU0z?=
 =?utf-8?B?aXRyUmxzTDRyNjdzRVlaL1AwWkhmVy9mVUtnenMwd1FpbXFiVFZ3Rzd6VXdC?=
 =?utf-8?B?c0xlNzk4NDJQV0NsQ2xPWW5iNDRKR0JZczVMS1ozZnR6SFllZ2w2SkpYeGI1?=
 =?utf-8?B?Nmc4OVpnTUJ3eTI0TmZCbWxXMk5sY084UVozbTZsU3FnRDBhaVhRZG1zNGdJ?=
 =?utf-8?B?TVQvd3lPamRmVGwydzhnM0hKck1sOWZtT0Zxc3AzV1NYZWlmSXk1WE1LS2RO?=
 =?utf-8?B?U1g3L3kzZmVMZW94a05zRWJPU0RyOHN4RDhCTTVsZ0tHOGR1d0FCMHdETEd1?=
 =?utf-8?B?bVV4ZmtIKzl4TDJONTZGYzdpRlVYNmRYVXNBYnNFUWZVUTBBczlYblAxWnNj?=
 =?utf-8?B?N3FCc1lPSjZ2VkVoclQyekVCU2xKdTJ2T1ZuZUgzSkFoQkNKcjFNK2VFV3BZ?=
 =?utf-8?B?OE15ZFlRaGYvTTlyMkx2Kzh1Tmtid0tFdVBPNC90Z2lXWUdTTC95RXBVTjBC?=
 =?utf-8?B?aFpHdU1ScVpvWXlCR2Z5T2NVYTdHM0FSQVRqKzcrK0xvcm9XS3pwa1plK2s0?=
 =?utf-8?B?eWFwWmc2aFA4Qmp0RngraGtlNmJONlNpdTVxS1Zuc0M1bm9FVnpQK0xSY3hs?=
 =?utf-8?B?bnUwQ2JPVFlQSXFWekFJRVoxdUs3b3pkcHRqUGJ0Y2ZEaFNaRnJoRnhaT0pV?=
 =?utf-8?B?Qm1WSlEvbG1DUWNTd1NxUEJhVDdLcHpjMzgzaThmZ1RKeWM0bFR0WUt0cjBl?=
 =?utf-8?B?am40ckd3MDJrdk5ObzM4NkpKeExxSllGNVZEMVZFM05rc3pSYXlVdz09?=
X-Exchange-RoutingPolicyChecked: tGOq2HmgpO/QkhI/RKXFnHZi9aqCSQRHQH7XJEbl/vBP81qSAE9KDL8LIqb7lbcyo4W8grc/GofR3W271qWb8+MjmBfliA4Kvd3J2UNdosj7gwn0RN2IavxSTwDosKVKecywWWuAe9UWZXEG5KQxwDc6RP4aVeVSaLsIOPJT/LHLM6VcixY+ajvZsm6x0ditp6p9vaVjv5a7W9k/OH5QiLAuiewvGgxBWStP+0h6eEWwCwfl4hai7SWiJYoQTahcGki4H407SU+IXORa7Q/NoozNL2YRNkhYbZvvKk5aYUMYLMn46xYJQXliuCySghNu09m0Xz2ZMUog4Mw6QQa6Lg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6452c14c-14fa-4b90-4415-08defd30ab25
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:57:40.6101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GDuSqOE2DJyKe+I41y6ehhY1xlJXQ9yWUQHzeBpyVIYhUfBpiqYVcB8UiU2EHjXo3n+RCOMfSOAI+JaO1pyNvGA8jefrTtZgGE4F3F6UrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9103
X-Proofpoint-ORIG-GUID: OLJQ1guoC6q6aXvo8i95saLTjhpbgWR3
X-Proofpoint-GUID: OLJQ1guoC6q6aXvo8i95saLTjhpbgWR3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfXy2Wfi/zl4KMi
 CCMEnocscUF70IcW9I7eyTBUV8hiPUZ8D2MvfG1e081DZ6/2aovLEXxIkUv6EIAcs49/qs30nip
 kMSM+nnVsZkdpbzNNV5qVYjo/CYmBVErvuIrJvBhX1TwwwMNxkALYNlHTLviKptmr6XfjwJX8N8
 uLTUULnXOPel46VGUtkmq99LVhDnHmJfzEkGHD9lZJ5cFrz1598nthA6eO5iAuY/q+uTqKJTZeT
 6qO5p/jyK2Ax5wNq/9CvUvI8HFFj6J+p+tfjS4d4aHrIoojZ2k1eIPjrx1x+DviWyW+HRGUeBap
 ZHkDbdcmEAZB40uWTqnEMwXp59ogFDJx3U6iPuUMQ6fXKOipmf2LEgjVpT3+cXo9BqYSLuLiH4x
 4rf9LvpFRtoTAcbJZPIP8oyRvhdI9PQ8DDqhSMC9SYAhWh1AuD7KdhtCxObg1aqa5gqHRLE5VKC
 n6oMr8rGY/EdBU8BXVw==
X-Authority-Analysis: v=2.4 cv=RImD2Yi+ c=1 sm=1 tr=0 ts=6a8464d8 cx=c_pps
 a=EgIJVKDiB2rM9xu8Bbqf7A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=scCNhTKc4am_9yREdVgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX/sNT47VWtASu
 cUg4SG3REmrcTff44+HW8ebjTfBehyt8FxCLUEGvnTfB3d7zG/0invum0PIpaaFBzZNbaPwtOb8
 wHT9BSCFNWCeOM8tMQGfEI6LjQHAb/c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Currently, a vnc client has no reliable way of determining if a
guest side clipboard peer is present. Using VNC_ENCODING_CLIPBOARD_EXT
allows the client to try and infer peer presence based on NOTIFY event,
but this only works if the unregistering peer has ownership over the
clipboard, otherwise the loss of peer is silent.

This series' goal is to enable vnc clients to determine if a guest side
peer is present, and to be notified of changes to its presence.

A new qemu submessage (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) used to
carry the guest peer status was added to ui/vnc. It will be emitted
when the server receives the pseudo-encoding enabling this feature
and when a ClipboardPeer with .guest=true register or unregisters.

The commit adding the new vnc feature is preceeded by 3 commits adding the
prerequisite functionality, making it 4 parts in total:

1. Add PEER_UPDATE notification to ui/clipboard and call it on each
    register/unregister.

2. Add *guest* field to ClipboardPeer, which indicates that a peer is
    guest side. Currently it's only set on vdagent's cbpeer.

3. Factor out vnc peer registration into a separate function.
    Currently it's inlined in vnc_server_cut_text_caps.

4. Add the new vnc feature, register the clipboard peer for update
    notifications, emit peer status message on set_encodings and
    on peer updates.

Changes from v1:
- Removed spurious change ids from commit-msg hook
- Added some missing context to cover letter

Lukasz Kornicki (4):
  ui/clipboard: add clipboard peer update notification
  ui/clipboard: keep track of clipboard peer side
  ui/vnc-clipboard: factor out clipboard peer registration
  ui/vnc: notify client of clipboard peer status

 include/ui/clipboard.h     | 27 +++++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 ui/clipboard.c             | 33 +++++++++++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  2 ++
 ui/vdagent.c               |  4 ++++
 ui/vnc-clipboard.c         | 49 +++++++++++++++++++++++++++++++++-----
 ui/vnc.c                   |  6 +++++
 ui/vnc.h                   |  9 +++++++
 11 files changed, 136 insertions(+), 6 deletions(-)

-- 
2.43.0


