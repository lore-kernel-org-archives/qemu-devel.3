Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA88C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAme5-0002QX-Lp; Fri, 02 May 2025 05:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAme4-0002Nf-Ju
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:25:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAme2-0004OI-Nz
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:25:24 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54267cv1004896;
 Fri, 2 May 2025 02:25:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8eIWFBxkG+ms2dIKNgg+fuFJeiqRCWx3xcN607055
 2Q=; b=kpXpa6Z+zxoOD7U5FNfCbemNPvObq3VT6u7XQlAyYIwZ0ro68k8firL8X
 /Bc2TTWKy7XOiNxTPYYQUlJn/F0lFQiPVATTWWXGLfne8g8A1U4iK4UpjZ3Md+v7
 wZORWr69lPOKn6OiDx9kqP6Fc/J2Szgs3mq0L3SJGqLjOU14aXBEhPVfVvR5nqcY
 BgoMk2OUpiTiDnrdCzS1r2vg4VSvaZ3cnuVgNAfeY30XZ3192lceZwQes/nUZEzE
 fihrUJG6ie3nWu2+us/Z+Kbp9HlnQUswZRRBo0Ff9P+xvIGZYgplL2AwCVVE/efr
 psYrCAWfaroRYmsG5roCsYEoRHsDw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468y10dswm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAe5h4ka/MeLU3XSIopACPHLPEn/1pG+vjOjlOhNm5l5cnSAaDsCSqB1qoE+KBDfrUnVEwSAarMw1q1jo8K034BOBPISIjDqOW4t5rK1qvS+e9tjY0H4foYLR+5K73G1oJFiAZyhA0FSmo2734gYH5oZ0LBiPotlwe4zr/NCo0Ju1cZb1n/uiKMG2LLGYlcmx5i6Rzu0MiGCTaRUo91FjLzyPQwFZc6edFjJg4nXT3T1Ap6lXkUdEaShoQ/L9pcHiLibenrzRHIc46Cwvqjm97MlwVzfqpzCgSTJLVqBUXtCh0W+F/JvDOms18pviZ159cf/YrunuaNsV+HBGOkIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eIWFBxkG+ms2dIKNgg+fuFJeiqRCWx3xcN6070552Q=;
 b=OB4nSS6gNZjalfF1PlVN4G23wo0EubEx7Ct4wqYbH/KM7XbfhltiLrGAwQhqGDNpGU6owuT/NFR+m6TyIZoDHZ9oskBcZl6FmTtQbhVY1AWO9QcJp0DwslFG44EA/wjfOo4r8/gAuZWWQjWJcAULr+pbndUfNp9anQkZ2eEeANMrZtsSODV6whCO8+Ov0IH0g4iepisSrgeit4y+QE0oar1wj1lJClHroTZHq4isXREL8Rs8/+kXR/Btsoj7pxrl++zpBNruBHdiA9b0QCinkSsepsNyAatWof56RD/d+UO//TxdVQ6bRkV3tmnyk1oY7qjJs0OBHpGnGFFL0e0oZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eIWFBxkG+ms2dIKNgg+fuFJeiqRCWx3xcN6070552Q=;
 b=t0ZBj1lNZaliZQWjT9L3iA2d9xg2Zz07IpdCeQrqA1m8ag/lxqNCScyYJWnAibgKKFoJpGeuFtFkGe0uxzRtfePo6lDOMJ33gc1RAUKuB+wX9IVvfO6yB6vsqbaOtTFKMFbFfPWzQA7rBq3ZtI4U8ihuyhU/emNZ+rNY7LMzVggRHAiNIsrk1piJn4wc+swxOGoWJjuYv4bNfeta5nf9R3u78veiQ/VTMvgDJ4GHlhSMb0lRwnd73pM/Ap+DORsO5v+/hzD1+edt59BdHx4t2G9Ss9bRoD8QZ3ThshxvdEJ3J3ihv9cauinjflHJukKLh7g4fza86Z2GaUrNr+58bA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CH3PR02MB9939.namprd02.prod.outlook.com (2603:10b6:610:1a1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Fri, 2 May 2025 09:25:02 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:25:01 +0000
Message-ID: <fc35617c-768b-4dbf-a389-0b0812186d1a@nutanix.com>
Date: Fri, 2 May 2025 10:24:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] hw/i386/intel_iommu: Remove
 IntelIOMMUState::buggy_eim field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-13-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:208::32)
 To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CH3PR02MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 99baa62a-e6e1-442a-d021-08dd895b36cf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bm5DOXhCR0wzcFJxcjVsanM5QUNOdWg4S1d4SmZrdVRPVzVCN25jaXh3VmQ5?=
 =?utf-8?B?aDd3N3pjSXdyd0xVZFBXZ2VjZ3hhbHFHOEw2SmlBZXJLd2hPOSt3UkFkME02?=
 =?utf-8?B?WHZhTkNZdWpodE9tSEcxanQ5WXlhMG92UzhEVGpraUNKVkQ3VnRlOHgxN2kw?=
 =?utf-8?B?VWNXcHNhYldzR2NUSWVkc09xWXV3dXR5UzZ0S2M0NnJWZkV6UUo5dVlyVWF4?=
 =?utf-8?B?QzNVY1dub3FJZ2dJZ0o1aXRNc3doRktYSXJ1aDVydDVaNHI5SG5aa2RQQ2wv?=
 =?utf-8?B?bGUvVjJpTUdIUEZKK0hEdjE5QWUzeUp6S3RFOEVRQVBiQUdJblpPeVRtSHYv?=
 =?utf-8?B?MFI1dmcyaVRTTHdmZEU1RkxyZHFPNjVwUW5INFhnSTR1TE5QWXVjUG5KZExP?=
 =?utf-8?B?K1J0NVpPTWRESFNqYU9haFhLMVBRcUdqOG9IQmVERHc5NnF4bHBUYW9tNzEz?=
 =?utf-8?B?S3lES0ZGa0VTcGljZjMzcEdBcGZRZWxWbnBFdTZ6NEhuT0pjV1paZU9UTUg0?=
 =?utf-8?B?WmtlZWJaOTFKTWdObUtxdm5zZ25wd2pkSW9hZXlPck1YdGpHT3o5eDZiT1Zx?=
 =?utf-8?B?dkZaUjVMRFF1OEgzbXE4NW9zbCtqMzRUcncwTldBSmtpcW11RWZkTVFtMEIy?=
 =?utf-8?B?NEdOOXRrSmhtdmJ2SkF4a3RweE1STmh5UGs2ZkNhNjZjLzV3WkFkNDIxa3N0?=
 =?utf-8?B?TW5QdjF2NUtRUjlFMkZOczk4cHdZTFRMUTBFWUI3NkZwOFpYR1lFYStvTGNG?=
 =?utf-8?B?L3daTm40MVozN2xseVFpZ1Z5WTVsd3J2TEduQzZ0UlBoS3Z3WEljbEUxOVA3?=
 =?utf-8?B?OXlHcjEzMlJqaWFFMldLazVpcDdGaU9kek1ESXFhTnZWWVIvQ3ZTTjM4bDZv?=
 =?utf-8?B?ZHRFZ0RLTk55THBJeWh1ZUxNUncva2x1VkNON1grZzhqeEV0RGhRMUpCU0VC?=
 =?utf-8?B?RVkrSkNJdmdNSGVoQytudXg4dFU0MnBlUTJpcFA2SHk1b251Mmo4ZktoUEhM?=
 =?utf-8?B?cmdwZm5sTmYzWC9qU3JMNTFrd3QyMGlpYkpnS05rWnVuYVRPdUlMckkvTFow?=
 =?utf-8?B?V0VSNUMzSkRzR3JsbHQ4SnFsY0xxZ1RZcHo3VmdHMThlZW81UDhPRkl2eXl5?=
 =?utf-8?B?NnlLVkttdlZMZVU0N1NNTDhUUXpkWkczNkR6RGtYK2lyYi83SURubHBYellG?=
 =?utf-8?B?RzlEQ2pyaWZIMzI3TTNFem9qTllOZVBSNzduYmdlRWZOMWY2aUpKZDd4UG5N?=
 =?utf-8?B?VjJ4ZDZzUXB4T1k5UTBpbHhLV1BpckhOU2pGdUpXQ2hFckgxOWRDK3BpRWpS?=
 =?utf-8?B?QUVBbjI5OTBlbyswZzRvZ000Ykp2YzRYdGhTaTdObktxeGx1dzB6eGxGY2NY?=
 =?utf-8?B?VWNTRW9EMExSRGR6Q2dBd2t5bllvWWw4T0N6cWx5dyszNnVWN1FyMXVoekJK?=
 =?utf-8?B?YTFKMG1NZ0xlaTlOc2pnN05zbEllSWZPMTVHWTRpbHQxZW15Ym5PZWZLYzFH?=
 =?utf-8?B?eHZ2anJneStUU1JjRk03SVJ3UDRZMUlRN2N3NjQ4Mmsrczh3SnlhekgvN2pz?=
 =?utf-8?B?eTJLeTlMNGJLL2NCVU13L3k3SzI5ckNvUU1iT0lhTmlLakI5YW1iRUNJUVNV?=
 =?utf-8?B?ckxRVmRXSk1XMVJQOXkzVjM5ODdpUEdHY3hDdDNNaVFMNUUyNmhJVHR1YTZ6?=
 =?utf-8?B?VzJHTG14azVEcDd0MllYN2V3WjN4RnZlZE14UlFqeUtaUE83TWg1bWF1b3RL?=
 =?utf-8?B?MjJzUVN4LzMxVk1oSEMvS05KcDhRbUVaUGF0b3RHalJqQy9QbTE4V2RRY0x2?=
 =?utf-8?B?aXZMS2lFYjdNamVTNDBNTUJRNVRNdTYrUnZRbU1ucFk2MzdUcFZEOFZpMTRQ?=
 =?utf-8?B?aEg1MlNJdDYrTllzbGV4TzRWczFYM2t4SmlQS0lwQUpXeUcvdFF2WGxGcjlu?=
 =?utf-8?Q?CAtmd9JUcdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0wvemRLdVRINHh5MTdLU3VCRk5sSUlyb2dQRGxxQnVVc09LSHhvbDFTR2RZ?=
 =?utf-8?B?YlFaRUpxUFN2dUxxYnVZenZsbE1aek9LWnBEbTRGVXpxdFlmNXV3L3VCbXdo?=
 =?utf-8?B?Z29RMnhnZ1JRN09ydGMxVGJRTVhHSjFmY01CWUs2cHFUVS9jS0ZnVTREOVZV?=
 =?utf-8?B?UWVXOVplR3ZHYTRaMm1DZ0JDWVFKTVBCazVNRXJjdnNGVjdhT2YrWElHWlFL?=
 =?utf-8?B?TW9McnVMSWxZVGNseDI1a2taZGh2MjlRWWFlM2REa3k4YWRvS2pmSEw2Qmkr?=
 =?utf-8?B?UmhmblpJMjc1UlFHblFvVndlT0RPTDdOTThzN3NGcmtKVjJJbmVHLzdlazJC?=
 =?utf-8?B?VmZoc1hIcll2ZGEyVmQ2MUlZcUF5RHFFeDhrem9LeDU0M1ROUjExQ1RlMWsv?=
 =?utf-8?B?ZXpkTzl4SDN3aHlDVmFSdERRMVlBMXpFcHNsNkpxMFFmenJyQWF3VzkzUTFX?=
 =?utf-8?B?cFV0TkJvWGh4bXJmampHTTRiUlZZZ3d6WDByUlRBcGEyekpVVjZaU214TnFJ?=
 =?utf-8?B?TG91SG1Fa3RpSUtxZ1RpY3FoeWRFaHRzZHRlU0oxeFVsNDNsMUg0MHI1Y2xK?=
 =?utf-8?B?dlNqQmVCZDJZRlRUOUpCcUk2MWUrWVNQSDBpdFp0eVM1MTlFS3V5MFRWK240?=
 =?utf-8?B?c0lvaXNmMVNJajNaWUg1bTV5UU5halhxWVBVY1d0dnV2U2pwcFpTTTlzN3RL?=
 =?utf-8?B?eGlvRSt2NXU5SmhoQTJzSldlaE5Kekw3MVhjNTN3ajFBNlFwL3F3aDhNRWE3?=
 =?utf-8?B?VnlEZ2xjZ3Fjc0w1alhwTFZCbXVQM0xNcVVUTUg1TG94Ylh0akZvS3VKYUdU?=
 =?utf-8?B?MkJ3VUwrOG94RFF4OFVqZXNCbWg0L0RUWFE2SlpUOEw5d3ZpTmhtMUthMHF6?=
 =?utf-8?B?cGZyaTNoQUkyVXBBKy9Tblo5VWxXcmN4VGc0WC9UTDcvTUtxN0YrUWFCb1NY?=
 =?utf-8?B?N05jNXRDYUpzSUsxSlBKYUlmRm9vWlRWWlU1N1NVTk5CV1VmZXJDTnZ5RE5O?=
 =?utf-8?B?U1diMThyRm1idjlMdHg4bmR2d1VVWCs0dXNFVTNadzFMMWQ3dWtnRmlUQmcv?=
 =?utf-8?B?ajVTazQvcS9hU2pjM1JVdlJHUzFRRVJ3NEpuei8yM09RUnZIMGp1T1IzYkV5?=
 =?utf-8?B?YlIrM2tHRU1CL0JoR0d1NDJ3cXdNZUFQU3kxK3pUaHErSDRFYzdTYkdhZWJQ?=
 =?utf-8?B?WHVpTE5DYXBhU2NrNVBlTlFPOElnSEc3VDU1RlNGelBheUMwcWN0OUhhN2dB?=
 =?utf-8?B?V3BiNXJ6MGpIMDgxRjJnRVJ0MnVKNXoxalRtWHRGS3hpY0xLYVpDSmpmb0ZN?=
 =?utf-8?B?N3NCZUNNYmRKV0h0b0pKSXhRdWJPWXdIbXExTTBRUXphSW9wUFUvaFBRYXRm?=
 =?utf-8?B?ZUJvR09ndnBjdWo1bGx0Z2RaVEp6azlqNFp5MHMrQU5LSjBtRGpNc0w4RDBQ?=
 =?utf-8?B?UytpbFFjZHZHVVhRa3hUaGRUU3dwL2JBNlM4M3JoNU5TOXQ3NHc0NnpMUzQy?=
 =?utf-8?B?dGlnbXQ4MDBJQURDRkZ0VWY1eDZ2YUM1cWVYZFV4alhzYWROWmJad2lnd2lu?=
 =?utf-8?B?cXpuWWp1TkN2N2QyYlU1cHlBZ2xQbTlhTVVDaG5DcW5EOEsybUFvVmoxdlM5?=
 =?utf-8?B?VE1tR29sZ01wUjc1TlNxbFZSR29XbGJVZ1VPOExvSW1GVG1aTVBUVy9WVTMw?=
 =?utf-8?B?TVJEdXJ1bHI1eVlqWGR5c2hqTlpDQ1ZadmVLM1B2OEhMbk1MeklFTVB6MGZL?=
 =?utf-8?B?dDhhalA2MXdPT2cvRUNrUDArOXJTQ3FRVFZXd1Z3eGZ6RzRlOE1xTk5LMDFp?=
 =?utf-8?B?b2xVekxvd05mZEh0b21JbmEwUGlzWndSSURQNS9uY0EwL2g2RlFqRnNaL0ND?=
 =?utf-8?B?eWJyZEFuMUZzd1ZmL1g5K3RrYy9SY0x2U1FwVXVzM2hvekd4RjdkaE5hYVVU?=
 =?utf-8?B?UVkxOWFhc3FLM1pTVExMbFErTml0TWo1cDZaM0VaVjY0Z2JXOTl1S2V1MEMy?=
 =?utf-8?B?TDM1V2ZDbjVMUmxTNC9YdVVLeEZRaHIwOHhXcmV1bGludHFXeGMxYzcvWmZY?=
 =?utf-8?B?dFVkVmFENmhwdlREZTRvaStybzA0UU91Y25QcFRpVlVsT0lBdEF4ZzdDZUo1?=
 =?utf-8?B?ZzduejdmUDV4Wm9IL2Vac0I5dzY5T1VlbjlIZ3JaYVRsMVdFZC94Q3F6aThH?=
 =?utf-8?B?M1dyQXJmSlBHTUgrSDR0WjVIZGMxWHM1cjFYWVJHMlBEcWx5WTJlV1V5OEo1?=
 =?utf-8?B?VzRMcGdyTHdSa21qcXp0RnFLeWhBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99baa62a-e6e1-442a-d021-08dd895b36cf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:25:01.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdUj3FoXO5pGlcXOQA4jBcRzUdSbM3rvjoRdbXtXQmSnaOsWe0UAh+kXg6JQ8tsHn6/GEsClQLYVEVQPk/dMRn72Mo+u1/4wgDpmqtiCx+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MyBTYWx0ZWRfX1zfKvunGE47b
 H3fIbSvA6EILmqBn/425lNaveAQ69NWEUhacq4LD6V+UtY0svJtG79VYHd4ZGwIPfCH0iEYSJ7B
 yDOifSvlakPqVB5MNGB6AO4E6m7fS9ucV86HPx1VMj8KsxjbjVqpPDxFdJ63RYCdEUULDP7JWgX
 plFydlX0o57L/tWfKKvl9eDyBCmlay8H/0tviBwDoUtN84np+IxOiYbrs04AbYVBu5h00Elzpx0
 dt+Wassx1r8C+pb/GKT4FYEvslp2hRmzCqr2LhgTXCyRmlMbQGz5XFA7RlbscMRSaJ9OgcEyyFC
 fLtj8u3CcsSkvFRAxl+rxV/mXdLOgAn5RvqEIoOn1U/FMhOfpU7vEg7ZdLzVIefSEO36gNIGx7Y
 5uiBhZ/G0uxCCtGRvrzv9SoErEVIgOmVKaklBSGYnOL0WQ8GbUNHO4w+Tdy6IojU9bBrJNKN
X-Authority-Analysis: v=2.4 cv=MNVgmNZl c=1 sm=1 tr=0 ts=68148f72 cx=c_pps
 a=n5+7iF7l5R/EKaY7dbRUPA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=vPw0Zxg5UOH-iSgSlcEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: w4fT8m5laoU5XMjvSzN_uXUHBWxPJzm9
X-Proofpoint-ORIG-GUID: w4fT8m5laoU5XMjvSzN_uXUHBWxPJzm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The IntelIOMMUState::buggy_eim boolean was only set in
> the hw_compat_2_7[] array, via the 'x-buggy-eim=true'
> property. We removed all machines using that array, lets
> remove that property, simplifying vtd_decide_config().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/intel_iommu.h | 1 -
>   hw/i386/intel_iommu.c         | 5 ++---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e95477e8554..29304329d05 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -303,7 +303,6 @@ struct IntelIOMMUState {
>       uint32_t intr_size;             /* Number of IR table entries */
>       bool intr_eime;                 /* Extended interrupt mode enabled */
>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
> -    bool buggy_eim;                 /* Force buggy EIM unless eim=off */
>       uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
>       bool dma_drain;                 /* Whether DMA r/w draining enabled */
>       bool dma_translation;           /* Whether DMA translation supported */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5f8ed1243d1..c980cecb4ee 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3823,7 +3823,6 @@ static const Property vtd_properties[] = {
>       DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
>       DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
>                               ON_OFF_AUTO_AUTO),
> -    DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
>       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>                         VTD_HOST_ADDRESS_WIDTH),
>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> @@ -4731,11 +4730,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>       }
>   
>       if (s->intr_eim == ON_OFF_AUTO_AUTO) {
> -        s->intr_eim = (kvm_irqchip_in_kernel() || s->buggy_eim)
> +        s->intr_eim = kvm_irqchip_in_kernel()
>                         && x86_iommu_ir_supported(x86_iommu) ?
>                                                 ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>       }
> -    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
> +    if (s->intr_eim == ON_OFF_AUTO_ON) {
>           if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>               error_setg(errp, "eim=on requires support on the KVM side"
>                                "(X2APIC_API, first shipped in v4.7)");

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


