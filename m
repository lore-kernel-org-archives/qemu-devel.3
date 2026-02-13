Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF90EDF170
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqugM-0005eN-Ky; Fri, 13 Feb 2026 10:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqugK-0005dz-SO
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:02:08 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqugI-00046b-Ly
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:02:08 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9iJ8p3534714; Fri, 13 Feb 2026 07:02:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=enf3Dll/D5CDlPe9caQzh52OhVuT6MzNLU2TzuAv3
 Dc=; b=Xa9wDE1Of/8qGvZCHtRfLouqDJqQZYFiVkhNmqZ+kTuolzMCoVEgo4apP
 PH5l2ogMwSu5Iz2DebaZDfF33CMokFndlmEjtgfvxvhWl3AUJJ8cXA9pW1pGosmj
 gvRVMfZDvExhTsslvf6evGd2+jQIcXS4tfZyuB9DL2S94Qd9rGXm02PbsjxEyTF+
 /dXI6GelZeWbOkZOZ/e5MbpzeXeBoo4JJpwDN+rLjQsiWa3ek3anxj1ssPonH9Io
 k+lxx/mAjoFp2WQU+u50vv303zk5XYNZzsnpT+FG+0MzxlJpqBLWJgTfRlhMn8sn
 9d1aZ+R+7aK1opmdDEpk/WOTmL2ig==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021100.outbound.protection.outlook.com [52.101.52.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d7n8w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 07:02:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vg9gpR4wmCX8JJVMkmfhRPkj9Oq6GoH4g+7NBU6eJLvY0NAqAOCsKd3vqvwa+bkJk3473oZv+DqOtWEUYjQOgA9clmZgGZef85oMq9qxrCrVrQOIofaX1yl/zQwfEhLef2vaLh57ShNk0LnpPtpaMN9qCC17XN00XfnwPXfVL9rIK35S9DFGnnlhR3C8a3q7wAo69xkp+N7ou8xJNb2KbaGbcK1BP3XVoloRw5Gu+MXSz7JvIMkUW5SHfWrppSeNexpkIGFlHlv5WG0pGh1LBrs/jiASeONCE+d9RbdLD4qFrZPkntgRVROpmDxEG34x83lfGa9gmeio25sGAk8puQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enf3Dll/D5CDlPe9caQzh52OhVuT6MzNLU2TzuAv3Dc=;
 b=Z77yUKWQ4mJ4tUDlmAjXB+v8Pk1Nr6B/Slb7PjOQVu1JdIjtslT+2fWws3NNXi20xG4IklLoDMamt7Mn4CfqwkOAA+oGaY5mD+a+aYsseJEthl9kgx1tNdpc1tPXQWs/VPnVB+FeNra9LOh31ObojHB+pJs7gIKWGzxv1R95YBgHqLcuvitua9tc8jaG/rB9cVvr7zFGbbt0ln6x4VRO1tIl1KFRT+7IjwWhwG5udmMdLBwq2dyHE/fMtZXQUo16pkReX6LJwuvbx2osEh5winFKphRh0xNqNOt5PKV606gkONjiA7kXPQqvnmohfxrIiLN6HseCTs1wOym4KTyFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enf3Dll/D5CDlPe9caQzh52OhVuT6MzNLU2TzuAv3Dc=;
 b=JjhcrYmgmyJ0GDIcuv3vgQ+8iHInr+LcbooWbP2OaVlS30ns/CnR1GBBnfof7G3fVq3tHbMWfH/8Coo/qxZnve4R/amgg6uUYH9jg19wad7mnFj42RnmVq9ts7GyqabbVBFpiixD+SFUKnAEWiHp24WAZ6AGABwI3lM1unOUstDHnYDqODWBQ0Iad21uG1Moz+bFrwqHFdcjkz+GS7PS2ybxXJ8CsyW+gXPl7xDACPeLOg8lAxqDi8N9OmcCKqwQyEuNLczLZfwUiwLpUncj4rjOHifAq1s+ovXLuvPlf9I5UsmQ1OeBMJm6OmXZfrT6D5eEEldYmFet7PP8+6D7gg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10985.namprd02.prod.outlook.com (2603:10b6:8:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 15:02:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:02:01 +0000
Message-ID: <99d78fe5-70a2-45f3-b0d0-96af22b40191@nutanix.com>
Date: Fri, 13 Feb 2026 15:01:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/43] audio/wav: replace custom logging with error_report
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-31-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-31-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:b0::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10985:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdb40c1-19c2-47f6-1cf6-08de6b10d74c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUkrRHFXejgzZ1RaVk1oQ1hxYiszS1lTZFNkU25rUkhRVzA1ZVVJQ1FUaTRs?=
 =?utf-8?B?MEFocGpNTzhEd0RRQ1BISEc2Sk5ITkp2WTJNR0tEYTR2RHhYNVNScFVJTDZU?=
 =?utf-8?B?TXYxYUgzby8wR3VLQmhMVE1nWHp4cUxTQVVIblRVSGhGNGpFZzEzVzlTMUpp?=
 =?utf-8?B?TURvazlHOUVlTVhQVEVIRHV2bjVZRHRRZ2pmS2NhK2w1dGpWZk03NHMycVhR?=
 =?utf-8?B?V3Y4ZkptT2lQVEZ4WUtqWUZvR0xSMVQ5K0FuVVZTRkt3c3lwcGVUOVNlQkxI?=
 =?utf-8?B?eEFhU2htQ3hVOUJQcXByL2JwelV4NXM5RFVHUTJrMVNJTXNlZUYvZ2Jod0FC?=
 =?utf-8?B?U1dnRVNTWlhUVzB6bisyYzhGcjZBUjJaYXFxbkxwVHl6WXBIWFFwRDY4RUZu?=
 =?utf-8?B?RndKWUtURDNWSTJleERUS2I0ekhVUDEydERUc1ZXNGJtL0wxM2x2NlJSYWFt?=
 =?utf-8?B?aGpPTkJwL1dyZ2ZMRTZWUXp3dDU4L25uOU1Ma2U1ME4ybnMrMTZQVmtLbUR2?=
 =?utf-8?B?L3dkek9BMm1Sc1M4ZXduOWJ6QkJ4TjY0NUN5UDY2VUpiM1pKYi9GVnJGc1gv?=
 =?utf-8?B?MmdrM2k4cVlJMEQweDQwSURCaTNzVkVnelZRekRJekFMNHJoL0NqcFBNNWp3?=
 =?utf-8?B?TTN1TFR1dUVtY2dHNU9nR01mVldTVnVnRGsweis1cU9seGtMVnBFdy82Qisy?=
 =?utf-8?B?bkpmZzc5MkFrdFpkWUR6TkxXSm9NLzIzR1lIQXYzYlJWSlRTUmk0Si9iV3R1?=
 =?utf-8?B?NEhTRkx4U1k0QlFFdDdzeENQRWZBc2RJSFdEbmExajkzNWFkOCtBTlJNdllm?=
 =?utf-8?B?WHgzb2h0bDhmdVJPS0VGRmZscDBldFVyZVNvOVphN3dTeDczVUR1aHF6SnE0?=
 =?utf-8?B?OHBkeVlBK0IwclBvb3MyWWpIYnRKT2NsUlR4S2pnOEtEc0FTMTRENXBNaTVk?=
 =?utf-8?B?TVdkWlkzOHFGSGdES2lPaFVOQlRRQWorWkVDdi9Nd3BaYlRmY3A1V2o3ZEp5?=
 =?utf-8?B?Wm9QN0JDZnJPcTBWWmVwa3pUWitOa0ttMEVHakMxMDRuRHNabFNqTGxjRzl5?=
 =?utf-8?B?UFlsUHg5cWZ5Si9lelBqVjgvaHZvc2tRQnh6QUhlN2FkZmtURUk4QVZaU00y?=
 =?utf-8?B?bGxUYXExZEdqOXp0aklSNzBacEpYN3h5NmFlbGVESXNrUjdHZkV2QnpNcmJx?=
 =?utf-8?B?amhVYVVzMnB5bitPc2o2YmtSUnZDU0tmOHk3RllreXg5Q3ppZjBNU3FIZ1dt?=
 =?utf-8?B?VEF0NTlVYi80dVpqTUVET1hFR2pvRzE0WGVCQjdzVE42WW05d2xqOERVVlVh?=
 =?utf-8?B?NmYrZUtpaHlwcGdTeEU5cXNzZHpobGt3QjVoU0hvcXY5MTRLRityZFNuVEtH?=
 =?utf-8?B?eU5xRGIxeEpyVDBPUld0c1NTOUVyUWdoT1RSZlJMNThWUkVkc1RjN2VXUkJF?=
 =?utf-8?B?cC9sckIyWi90OUpZK2ZwckNKM3hEMXM0N0pqS2FtU3NiOXNrUFkzbjZXanVD?=
 =?utf-8?B?YkNQcjVyTjZCTTZaNnJXaGluTkc3enJvNmFGd0RrdG03bXNDQ2JUYnAxK3hN?=
 =?utf-8?B?N3NqK1daRjRKbTFyR1dyUUZmLyt1dWZrMXE5WnJndFQvTGJ3WlFvU0IzRVBv?=
 =?utf-8?B?UjBmaUVsYndYKzRnSEV4dnpzTnRhbmtXVXlHTGVuMmNCYWh3bUszK25aZ01E?=
 =?utf-8?B?Y0RmcmcvK1pGVDM4M0VRMDlnZko3QXpWaDlNbDFkMWVYUHNlZ3lpaWpMUWpW?=
 =?utf-8?B?Zm00eWk2a1YzNVYwa2NoL2VHQ1BsOU5HNENya295WS9wYS9GbXlqaWdKNi8x?=
 =?utf-8?B?cDMyK0h6S3RGTjdiYVExRS9MTFlXVHRMaUt3ejVyUmpzWExMSGFyT1pMb1Va?=
 =?utf-8?B?dDZIaG5MZ3JtUzFWOTR3VndYYzVLRGRGRFNjZjJvbHZpQmRLanh1emNTbkNL?=
 =?utf-8?B?am1IRUI3OXVBRFRWM3BRZ3k3MjBNUmhybGN1akgrTGhjNjZCUlJ4RlU4YWxP?=
 =?utf-8?B?NFNMM3ZZdGsweHZrcmRDU3hYOEN0SFA1bVpER1FrWEVYVkZEbDBLUEx4cXNY?=
 =?utf-8?B?bHJwekRMOVVlR050L25HRzZWazV3aVAwS0VqRmhpODQvUU8zT3gvZS9HVVp0?=
 =?utf-8?Q?kVzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVljbS9lcmhkUjlncitwWHlmMEpiWi9KTHY5K2E1RjVwQUdrM0phQmFuM1l1?=
 =?utf-8?B?VElaUzJ3bGlqMjhMRGxCd2VCNW9SbUJEUDRwdDZNOWN6WjlrbEVBS1Q4OVQ5?=
 =?utf-8?B?NG1HVFFnTEI3NGsvRFRqNWxCRCtEbXowY3BBNStjckZDdU96eG1nMDlTMnpa?=
 =?utf-8?B?V29XZVZDRVk2TXRmRkNLaTJ5YytXcTg5emVZZjlhRXlQSFJPcnByOWlkRFBW?=
 =?utf-8?B?Y2RtZkc0dlA2S0NFUWlVSjYvUWdNZU9LVUZyWFJqbzFJdEtXWEFZUjY4Rm9z?=
 =?utf-8?B?bGlNeEpnaHVJazBvaEpwSExOTEF4QUVYVUtTT2NIZGRGaVpXOCtPMlFFZis0?=
 =?utf-8?B?YjEweFI4T3k5QkhNRWIrL0laTTBzdnRUWDdRWlA3MWRNeEdqLzVvN2s0ektR?=
 =?utf-8?B?WHFTWmUzL0tDakxPUSthbG1zR2NYQTdoYjlRa0hhSmlyWDBMYWNsUTg1RkFI?=
 =?utf-8?B?OTdxMmVpVUdjdUhxRzJPSnl1WWR4YlJxbEJGSVRHUDhzbVZ2cUxycTJaak5G?=
 =?utf-8?B?SUZnM2RweUFxb2FaeGJXdTFoNjhqVFlxbDM4OHBVbURiZjgwQ1RBN3lML3lz?=
 =?utf-8?B?MWFpd0VrVmh6U09JL2x4cG8vc0Y5WVVldlBmN2dYNTNZOE51d3ZzRkZXOVVl?=
 =?utf-8?B?dTRZdDRYK25rajJHK2lKMkdFdVJ6MWVaMzRwMGtBRmxnNGZJVFYvYTkzRnhm?=
 =?utf-8?B?d081dWhGa2VPMlVWZ2ZQbmcwUXNPRit2WlFkWTZzTU5nWmFaYUZlbHBYbVNk?=
 =?utf-8?B?Q0Z0V3BBaUczVm1JWFZueWFFT1hoRnZnYWM3czJOYVlBKzd5TC9zTDNEUFZ2?=
 =?utf-8?B?blBMYkxveVUwQy9jeEp3UmFBbUtUSTZUQ1BOZG1yNFp6VDNHYUdNeEFFSWU2?=
 =?utf-8?B?bVdIMnZXcURYdUJpMzBWSm95WEM5Q29lY2hLdTZMZDNIUHdIbFhyR1o3Q2kx?=
 =?utf-8?B?RHpObnp5ajVQKytxMmhxZk9KUkYwQnJVR0hlRlA2Y2NkV0tDay9iaTN5Mk5j?=
 =?utf-8?B?UDQxanNNNlRJOVN0MmdvVVNMSTk0U0VXTU83OFlHZlJOTVNIa3RpOGh6RXk0?=
 =?utf-8?B?cDNRemM5eDJsTTFKdmt1R2hqYThmUStpczRWMm1MTzQxd3dEVDhTLzZqNGxy?=
 =?utf-8?B?aWNLL2pUQm5mRjRVNjl1LytPYXkyQW9MbkJhVllBaWxydTZPY1VjYlBFWFJX?=
 =?utf-8?B?RVNwSDJIdFF3a2I1MThPUC9qV2orMXRxZ1lLYlByanJuUGtYOGl2UmEzTU1P?=
 =?utf-8?B?eVhvWnN0WjlFUlV6VW5hVnlkcm85OW5ZZzJKMm9ibFJxQ2VYbEdTQ1pRc21J?=
 =?utf-8?B?RVBDRS9NdmxsRlZ0MEVEYjZqQzEwaU1pZ2pGR01Ubk1pL2VDbi95eStISGVU?=
 =?utf-8?B?MzlBc053QlpncHVJSGVuM1RISUZVbkJpM3BBMmhkMmF6WmZUUHBSck12Y3FG?=
 =?utf-8?B?cHhBWXFldk80elAxOVdRT1NpRjZ2bnRsS0dBUVd0MEtSUExkQXVKaWFUNFlV?=
 =?utf-8?B?bXRlYjIrUG9IZ2VCcXBQd3REZmNtL3BKaUR4NVRtb2FnMDd0SWFTWk5YVGRr?=
 =?utf-8?B?QWxVWEhudE5MTmlxaFp5bEptbTk5RWJmb1VZS1BLcE9pM0RGaGdCZGlrVU1v?=
 =?utf-8?B?S0FFenQ3SHFaM29taEk3cENpZHo1R3dWUGsvNW84cHhHM0xlcTBiSlFJWGQ5?=
 =?utf-8?B?VXh1TkVibHp6cU9tbTUxMUhCazhHOEM4VkdKVEd4SmZrbUhuZFhoV3JCYmth?=
 =?utf-8?B?RzBVNXV2RzVKYjdtRFZobDlSaWY1dTNlbDhYdGVFeHV3b3BpQXZwaVZGRWJW?=
 =?utf-8?B?UVJYbGJsSEhkQUlrZ2RPWFNOaTZ2cWJ0VTYvYzRhNHdNMnRDcTBJMks3UCtS?=
 =?utf-8?B?OWpVTEJOSW43U1NrbE1vNVR4aHNxdW5QM3F0S216Q0RNVXRMTEYrdC9BMldD?=
 =?utf-8?B?bFhxMW94S1NSWDlCeEdPdmU2WDVuRjVCRTVJTjlqeG05eG9WTmJta1lnWFVy?=
 =?utf-8?B?MXVBdWVGeFJtRDdya1dpeENaZ3VpMXJNTVhpOGxxMWlmVnRZN3pVWUZLVXRM?=
 =?utf-8?B?anhueXBKOVdtSUJ3bS9BSDFvVDYxMmhKZUk1VFl1UkFia1lmNmtXcDJUR3c5?=
 =?utf-8?B?bkI1SHpUN2J4ZDVZMkpReWx3ejl6Q3RoMFBudHZBY3Y2MkdNbXNiRFpGZkpw?=
 =?utf-8?B?VWw0YTlyU2VyOThiYkxsbkxsdDBuaStpZG5aa01lUWNjT1pIWGZOaGlCeWpz?=
 =?utf-8?B?VkIwaGFsV3NaWmhQMkpSWGE0d0kvSU1pSWpmelRXdGFGblM4WEgxTmdsWVhl?=
 =?utf-8?B?QkJIK2taa3lEL3hzdHF1VVdQZDgxbW5lMCtLUUkwc2c5akkzUTFzc25pMVA1?=
 =?utf-8?Q?ZTP5vvN8tG0dVAvI=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdb40c1-19c2-47f6-1cf6-08de6b10d74c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:02:01.0270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/5Kk+kzXbfrPFjpnNyB9IEgd13CVebREYzCW8OQuoP4DyAYgit5Fbm4WodO8nKsvhfHz60Ykhz4OdsdSEh0+2LBk5A2J2jIFO6oF02zsCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10985
X-Proofpoint-ORIG-GUID: EhqVFIPcdL22PZg4wY_oFth-v6eY2d_c
X-Proofpoint-GUID: EhqVFIPcdL22PZg4wY_oFth-v6eY2d_c
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f3cea cx=c_pps
 a=oHVU4+OBm0glsEb2BXLEfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=lF90RKiBuAZSsffC6W4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNiBTYWx0ZWRfXy+BRyTqcKVCA
 R/q27jaTauG4velBtHfbFTgUNng/8IAN9HXKlgcN447pK1WunjETbllL9xU7vmriYTvW486Yrpr
 yLX2oOmOowlY4tCq0WoxVz/9InkH9savo7G4bSTdecQ3fGojjgJx3R0sEiuePfeg72sgEwzyZri
 NEkuh/fC9zMz2U6RY1lRKgwjvoUVf9MaK3erxfKahet9Hv6jd45dhhys9kuUBgBwsUgnPqO9a/8
 4iiZoykdaZsDDh0flBIwdlzFVhvvk5RRUvhFIhklvxJU08M/V87evOlonHiof9sSlaZocl+0B9t
 8tE6RIFVWcsfpota8T9PV5vviQEH7vuv0BMIy0jKiAl4bFGcbGpYrN5Qu2WEBKLU11euYVCqC0D
 C2/ELomt7g53g8AfgtvXR/1LGFiLLzaHF/A/p7J8dmTSFJNlp38lYTjYb9uYY7xUEqyV6klyz9c
 DfZUwbKaP1ulpxdt+lQ==
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
> Replace the custom audio logging infrastructure (dolog macro) with
> standard QEMU error reporting (error_report).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/wavaudio.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 090f3f4dc60..5c614ed3b51 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -24,10 +24,10 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   #include "qemu/audio.h"
>   #include "qom/object.h"
>   
> -#define AUDIO_CAP "wav"
>   #include "audio_int.h"
>   
>   #define TYPE_AUDIO_WAV "audio-wav"
> @@ -51,8 +51,8 @@ static size_t wav_write_out(HWVoiceOut *hw, void *buf, size_t len)
>       assert(bytes % hw->info.bytes_per_frame == 0);
>   
>       if (bytes && fwrite(buf, bytes, 1, wav->f) != 1) {
> -        dolog("wav_write_out: fwrite of %" PRId64 " bytes failed\nReason: %s\n",
> -              bytes, strerror(errno));
> +        error_report("wav: fwrite of %" PRId64 " bytes failed: %s",
> +                     bytes, strerror(errno));
>       }
>   
>       wav->total_samples += bytes / hw->info.bytes_per_frame;
> @@ -98,11 +98,11 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
>   
>       case AUDIO_FORMAT_S32:
>       case AUDIO_FORMAT_U32:
> -        dolog ("WAVE files can not handle 32bit formats\n");
> +        error_report("wav: WAVE files cannot handle 32-bit formats");
>           return -1;
>   
>       case AUDIO_FORMAT_F32:
> -        dolog("WAVE files can not handle float formats\n");
> +        error_report("wav: WAVE files cannot handle float formats");
>           return -1;
>   
>       default:
> @@ -122,14 +122,13 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
>   
>       wav->f = fopen(wav_path, "wb");
>       if (!wav->f) {
> -        dolog ("Failed to open wave file `%s'\nReason: %s\n",
> -               wav_path, strerror(errno));
> +        error_report("wav: failed to open wave file '%s': %s",
> +                     wav_path, strerror(errno));
>           return -1;
>       }
>   
>       if (fwrite (hdr, sizeof (hdr), 1, wav->f) != 1) {
> -        dolog ("wav_init_out: failed to write header\nReason: %s\n",
> -               strerror(errno));
> +        error_report("wav: failed to write header: %s", strerror(errno));
>           return -1;
>       }
>   
> @@ -153,30 +152,25 @@ static void wav_fini_out (HWVoiceOut *hw)
>       le_store (dlen, datalen, 4);
>   
>       if (fseek (wav->f, 4, SEEK_SET)) {
> -        dolog ("wav_fini_out: fseek to rlen failed\nReason: %s\n",
> -               strerror(errno));
> +        error_report("wav: fseek to rlen failed: %s", strerror(errno));
>           goto doclose;
>       }
>       if (fwrite (rlen, 4, 1, wav->f) != 1) {
> -        dolog ("wav_fini_out: failed to write rlen\nReason: %s\n",
> -               strerror (errno));
> +        error_report("wav: failed to write rlen: %s", strerror(errno));
>           goto doclose;
>       }
>       if (fseek (wav->f, 32, SEEK_CUR)) {
> -        dolog ("wav_fini_out: fseek to dlen failed\nReason: %s\n",
> -               strerror (errno));
> +        error_report("wav: fseek to dlen failed: %s", strerror(errno));
>           goto doclose;
>       }
>       if (fwrite (dlen, 4, 1, wav->f) != 1) {
> -        dolog ("wav_fini_out: failed to write dlen\nReaons: %s\n",
> -               strerror (errno));
> +        error_report("wav: failed to write dlen: %s", strerror(errno));
>           goto doclose;
>       }
>   
>    doclose:
>       if (fclose (wav->f))  {
> -        dolog ("wav_fini_out: fclose %p failed\nReason: %s\n",
> -               wav->f, strerror (errno));
> +        error_report("wav: fclose failed: %s", strerror(errno));
>       }
>       wav->f = NULL;
>   }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


