Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2B2CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFX-0000u4-Og; Thu, 28 Aug 2025 13:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ureKd-0007CH-Bj; Thu, 28 Aug 2025 11:14:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ureKa-0005vq-JB; Thu, 28 Aug 2025 11:14:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57SEQvE92725986; Thu, 28 Aug 2025 08:14:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qkZ5xG+wwQZZSv2W/hJIhgfSf9rOeA0qpuQo0Yor2
 u4=; b=hB/CAChkcsNu0RwHKkAirQ9LD12eF1AK4BCBkgNqGKFUcQPTGOB8BWpOc
 +mN2DDIBTnyGoO0z3uLkaPva3rij+EhWyD70GMHns5e00Rztu0b5QR6OmZ9IKH5K
 5JbS/bsE0GKRLqTdCYVWoO0Vh6zoFNHyEjwWWuVEid5/U+oYHQnOCyxcEYMDzfUt
 62sfzT68TX0u5l9gPYbTiQPWNZs/RPZssf+oAUV4Xut9a+rAS5OscHS+iNalPxc8
 G5tL+mtGge++umJuAKp9/1wDHzGMrCcHx6F+8BMi0Ohn8HqVRnBTh2kM7wdZGQnV
 Wq3PahFGO0e88eVJIlzp0kz9gJu8A==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2113.outbound.protection.outlook.com [40.107.95.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t6kjtgcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 08:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqEy/+HJQfyEakrAzzG6DX8FWIzx0OpPG9oCfPYY4wMOyKfGHMXlwtpoNqZgKTJG6PJYp6mbHCoJm1KhvZ/43XjMmYwbgk6jfiYB/YVBwUP6vCt+eFjM9IWe4JdhAQZpumB08GFLmJaQT3hPhMjRq/W3Shb9Oe2/QBtfXlQ9lN2mGLW6L3tKWUYhnZebWVW+oUbW9JEayHObjMQ1+2oxUOZcnKN8qOEYKpXfgW7u40zPW/Km1lNxpoPhBNsTZ677nQa2NhyxwDHwH0jPlLRfgzhBCFwanaAl9PQfVNVYlJWR5uo25DJaNbhMz5e+qK2DRsLENGIVAe48iUAvt9BUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkZ5xG+wwQZZSv2W/hJIhgfSf9rOeA0qpuQo0Yor2u4=;
 b=rZTmYW25d3JPUVIXk0VvR2HdJF72CFJr7nfIdv8VpgRTH5exWDG8GHOEFK8G0kOcRoLgqH8GWBtrv7us8Dkg1IThlZoCPIaoLkIKK6FHwITUtTmsJsEE2X5+I1RsqL7M7SDhsNziyybCJMcXybtYT39DVtwAcSXO9ScUbFgsNyJ0uBDu6U/n1rw1laWdZbudrP3EHFP8VWOPNonaSJ/+tCyUfc40kUTr6r1Kgq+G65urPpDyWduFv8XpLB1yJhi73QJqelzykPIx6uw7X9R4HD8A7stR+RR5d1qtxIcfjaC0RQk+VIyNhZjoK2DE52PLP/vnSJi+eHkPGeJ0Go5ycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkZ5xG+wwQZZSv2W/hJIhgfSf9rOeA0qpuQo0Yor2u4=;
 b=gGayYlPyc//N/wWKB2LlvGePiNwYIHxhD1DL8dN63T5sLjggeq9zhbY0PjB+xboDwQaA/YRe4KR2CtApPqm7fjugNPIth3dQuZaDYvd9uZJrhxv/lRigNqKx63D7AnQfeYnJYjKWh+gpzBIk7rLJJVlj+uy844/UJ5znOP3KRZghjeSeh6ugZ6TLHKEPGPgtOvf5GlMCXy/+P4b8feX5V6hHj3kpNZqvz2uQHILkCWyRa4f5gJssnKWJdCzu7ZKBFFiPFaXAszb//0hQmN+M9IJwuCmqRoqnF4x+6FkTQpwE2YKQX4rkdpmysCFFA2PwLoSB/x9kKMQEj5r53EinHw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB9126.namprd02.prod.outlook.com (2603:10b6:8:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 15:14:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:14:12 +0000
Message-ID: <1a3457cf-978d-40f3-8b1d-163dab362e68@nutanix.com>
Date: Thu, 28 Aug 2025 16:14:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] vfio/container.c: use QOM casts where appropriate
To: John Levon <john.levon@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-10-mark.caveayland@nutanix.com>
 <aHZh7JmS9iEBkFBE@lent>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aHZh7JmS9iEBkFBE@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:205:1::47) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdc3599-ca6c-4977-4038-08dde6458b4f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|10070799003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVpGZWwvR0c4YndZanZ5U2dmMW4yTStXWHpMREpCYWE0VXV6eGhTRThHMkF0?=
 =?utf-8?B?ZnpTNmFrS09HVGxNZXJYZlBQNURYQWM2N3BJTjRGUFV6c1ZlNlM3VTg0cjFO?=
 =?utf-8?B?WUg3ZGx1NnN5dlZjaTRmN2c5QUJBOUFTcXJhbUtOTHVDVzk2NldackFqRHlh?=
 =?utf-8?B?MSs4dXZpbjlJWVg0MnVleFJaQjhWZUFvUk94a0o5ektvODZtcVRqQS9GbEFw?=
 =?utf-8?B?REo4dGQvNThhY0hmc1JvVUJWamd3T2ZEUFk2ZVpmanJkNDJPZHFPUGlxZjVj?=
 =?utf-8?B?Ny9ZMDRvTTdaNmFOQTBOempJOFBwSjNLU3NqaXFSZ05tbWdTMXYxc1g2T1Jv?=
 =?utf-8?B?YzhZQXlFazFOQk0zOUpLck1Mb3l5VHpKcll5N0FMVTR0cXA5ZDlhV2RvZFZj?=
 =?utf-8?B?Ly95NFNaMzI4b2tZaC9nS3FDcEwxMURyNksvQktlV3VkWmFmL2p4ZHg3ZW4z?=
 =?utf-8?B?MXY2S2pqYlIzLzJJVFRhYXI4dWdaY1cvTm5BeFpHdHE1ZkdhcE54a2taMmF6?=
 =?utf-8?B?TWREalEydVNVZC90MXQzYlQ2bEhiNzBCWlBYak1KdVJINEEvbzN1QmZmY2kw?=
 =?utf-8?B?WVJwM1BOY2g4VmRZQ2RxSS9OWUs2RVdlQ0Y3UnFSZThEeGVORmdldE4wVDBx?=
 =?utf-8?B?TTdMYzdNMGxtQjJSdFVwSVhUaFNWS3FobnlzTTMrVUg3RTZ3WGJ0MFRGMlly?=
 =?utf-8?B?Z09Dd1ZnMy9VdzQzNnNEZUZwSEhNT1pLUmZxdFJkK1BvYjZjMXhFOFNaWDlB?=
 =?utf-8?B?SUhkWkZkZ0N3OGJiR05PWEw2V01nQ1ZOaE9pRVgwKzMzVUozcFEwNXFidVNo?=
 =?utf-8?B?by9FeUJhcHMzUTMrL29GK3dWcDF2MWo5NW5iRjFBVEtGTWxWR2JQb2IvTU9C?=
 =?utf-8?B?OWxEbDJCUGkwRDNtRFc5ZHR4eEpVdllmajBiNnRsU3J1NEtXOEtISHlMSFZh?=
 =?utf-8?B?NHVtMHhPNWNFNTc2bmhpVmRQL1BZZzFoNVFpK2hYVjBuRytKUmUvd2NKQnBR?=
 =?utf-8?B?LytwdkNBU1d6T3JmV0NqKzJFMCs5T1ZVbkdMTC84bVBvaStyMHhVSzVGSVI3?=
 =?utf-8?B?Z2Y3bFh2bitDdVdaSFBhTjZhdWxZYVFXR3RHSDlpMERRS0d5SVRWWGdpQmhj?=
 =?utf-8?B?eDMxeXhGY2J4VUtUdkcrQWZCVUdicEV2aXlrOG93eWVSQTFXdExraFF2WHp5?=
 =?utf-8?B?cUNLMFdtbEt0Y3VoS3NkbnJiNE13QmQvcy8zbnJxRE9uazNnQm5nVHNORUdH?=
 =?utf-8?B?dzZkWGQzNmY2MHdvWHdaNzkxS0daMmtKYXhnQU16NnpkUjNRWnRvVS9xME9D?=
 =?utf-8?B?V2M0eTQ3MEh3RGhoUmkvWFFMak1DU1dDeEswd1U3SDU2bzlrb09TMDl0eW9k?=
 =?utf-8?B?M0hUNmNvMC9FMjVzYnhLN3dRSURNYVcxdDVzZWtnZE0xOVZ1ZDZkTW1lcXhG?=
 =?utf-8?B?Y01kUCtuZURZWFVqZFRzMVptR1RYNFZIQjR1SHIyS0Uxb3RHOS9ObTJzcmZK?=
 =?utf-8?B?UFBXSzloY2N0OFlYZFZJWTVLZ0lta2E0cHhsVHIrMUR5T0NEd3l1VTRra3o0?=
 =?utf-8?B?eEd3YUJHZ3F0QjZGbG4ybVNzRWdjSEZZRkZZRWYxNW0vUnFlbUcyRmVTOUZ5?=
 =?utf-8?B?VDhEdDRDVjV2aStSWWdGYy9JbXd5bk5DWTVaNzB4YTl1emVhR3hmNHNDQ2F4?=
 =?utf-8?B?L3BlNHluK1JENnMwaEN3eWRPSXpBOWo0b3BQMEhyeC9uMXdPVVVnYjN6azFB?=
 =?utf-8?B?TmlLZUJsa044L0FRckVuTVF0U0FVZmo5b1B4YnFCeEt0S1V3cjVDa2w4QUlN?=
 =?utf-8?B?eWJ6S0FXKzBwWTJLUi9KazRHc2RZNjBiOWNhUU43aEg1a1NLdTJsdG5FaFpM?=
 =?utf-8?B?Mzl5cEVVMjhDa2FCdzlwWkdpSVVXWUk5TlZmTDRVaGNHamNBbyt4cTVxeURL?=
 =?utf-8?Q?LCt3SCph6qk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFrdWl4Tmgrd3dWWFpWeXhveDJwZzlIYVZPUllVK0l1NUpWYW4ydkxudUEz?=
 =?utf-8?B?ZWw4RWRIcUVtS3lzcjNtRWZJRytLZzZtbDQvZFFDaGx3SG0rNXRPNGh1U2NG?=
 =?utf-8?B?cHNuQ0IzNnprQUpaMzlNd05IZTVGYUpWU0JzZTMvYnQxeEpVcURuRm9tNmd2?=
 =?utf-8?B?WTFIcVJqVWhTTm8weCtmc1BqUzNYUmRZM1YxZUNhRTFuMVV5N2ExSmFwbW04?=
 =?utf-8?B?d09oZUdtaHQ4RjBpR3ltZXZRNHhESXZ6N0NNVGI2SDZlMEtoMnIxRjJla0Ev?=
 =?utf-8?B?ZDR4RHpvUzhpTzZYSDBwb1o2cGdRb2IvOFpFR0tPWE80RkVZVDh1eDRWd3hi?=
 =?utf-8?B?cWI4ZldqbUdTSW1XWE9ENS9QamVYdG1XaTNNcm9uMld3OC82WW4yZmxYYUxO?=
 =?utf-8?B?ZzJ2RTJzYWRRUnNKQVBybTBqYXQ2UU53S25Vd1dQWnlHdXp1YVdVWmhDWmdL?=
 =?utf-8?B?a2FHUWcxampSc1E1TUNQM1ZEUXQ5YUNZczdvNXdqRDVFaVEwYzJqZmIyaSts?=
 =?utf-8?B?WjZWQ2x6eXNVM3R3SHI1TllrbVNscEE3TWs1bUFmUjBzL3hHcS9iU3MwL1hS?=
 =?utf-8?B?Y2xiVnpoNk1QVUh4V2ZVcWxpblNINFZvTGxVTkRpbm1CTXl6ZVhwQVBFdXJ0?=
 =?utf-8?B?eXhzcWd0b0YyK0JycHNsR1gxZWtrcGlWRzljZjRxc1pMWFArVTZUZTZuNzlD?=
 =?utf-8?B?b2lxUWhTejNRbVQrZDNYTXdqbVpXMHBYL0JpUTFjUWVVOC9MaXI2YkRhTEFW?=
 =?utf-8?B?d0xLY1VhbHFnUGtydk5peG0wWjkrSHBTcG84aGJrYmdTOUhDdDFjNjVyYkZ2?=
 =?utf-8?B?b0Z4UFo0QXYvbmJKOVZOemsvNnpnazMxV2VkU0pGWHEvTWU4SWNmTWJIeWhL?=
 =?utf-8?B?d0ViTUVabUxpTnlMaVhuN1hoc0hPTVgwdVh5S1EwT25IS1Y4RE1iMTBIYmti?=
 =?utf-8?B?bUQ1anl4WmlJY2dCVTBZUnBKZE9rYU5tc2hDampXcnY0UEpBMmhDL3lGRXNY?=
 =?utf-8?B?R1ZNcmhQSnNUei9wN2hWR2Y4NktKbk0vT2F2dFpUbDczRS9FblRmblBYRFZS?=
 =?utf-8?B?M2piZjZqN2VyWmRIa2s1dndEOFBrQnRDcTVjS3l2QXRHTGZxMVc3ZFQyOFY4?=
 =?utf-8?B?QmZERTBORFpxSzcwcG5HdlNhdXZXMWhKbXFkUHBkcjlkZzhkT0hGaU1MK3Jj?=
 =?utf-8?B?WWlScm9KeGtXeUlGeXdZZ1gvejJyRzFxQ21UclVIYi85eDZiR3A5SndrUWdG?=
 =?utf-8?B?bnFycXlneHVvQUVldU45OHZnQjNPK0xReTNNblBocVFBYlduZjcvbzNldW5H?=
 =?utf-8?B?Sm83V3FBR3piaGZDTElEQ09GR1g0OVM0TXNkNU5GalU5bVRWMSsrNG1XOXZG?=
 =?utf-8?B?NFJLZjlUM2U0TllsZ2V6TFJhQlErNFV5ODJWZkowSmxndFJqYTdlS2U1S2Nu?=
 =?utf-8?B?Vy9Va1hra1N5ZkVuTHVhTW1YRDQ5UHppaVltUUE2L3p5aEpkT3ZSUTVEcUFs?=
 =?utf-8?B?SGVEZmlpZS80Rk96NHpscXk3Q053aDhPMzZmSUhlSndYT0s1d08wWGJBeFc4?=
 =?utf-8?B?eHZLc21HaC9Ncy9SdFkyT0JNSVQyWDBxNjVFc2d0VG5HOHlqaXU3cU1xbEdQ?=
 =?utf-8?B?ZUh4WTdsZE02dXMyN0oxSXVScnlsUnk3L3RWY2VmZHNPS0lrcUJ5K0drQlRU?=
 =?utf-8?B?RGJqZEcxS2xsWjFBZmM1cUxXTm9vQmRHK1dMUlVMT1J6dXg5amFyRXBVek9S?=
 =?utf-8?B?b2xUcFMzaTlxYlB1WWFRbGRNTHpPbnlFQjZnU0xhN29DYmxaaXBxMzNhL2ln?=
 =?utf-8?B?dlZwYzlVcWRQYmRLbHFJdzlxc1pzL3JSWlVON3RUQW40OURWUnZKNnhQdHJK?=
 =?utf-8?B?dVB3b05hcG1ibmxYT0lDUU9xTXFObTd6LzNNcFNoUFZwRVczNWNISEJmMTV1?=
 =?utf-8?B?UGFrbVlxTnoxOHpZa0ZTbGdCMDFLWlVOVldHaktoQVQrYzF1cC85YkVncUV3?=
 =?utf-8?B?bEVlS04weUsxaHZrc1ZCVHRJbWNKMHFKSVIwL0o4UUNRQkVxTDR6eEJrVDFx?=
 =?utf-8?B?VzZXV2x0WnMzTGRkY1dtbFpSYWJKZWhGZmJCZTBWa3l3dVNTSCtDN2xkR3hF?=
 =?utf-8?B?eE1iQitUTVgyN2lTWmdmbEdtMzI2M082T0dBdmkwV0JwS3E4dFZ0akVmTWI2?=
 =?utf-8?B?Wm1xNG5zRGZBc0EzemlVSFltMGlFOEh3eENCOGZId1pOSkJESmpONjlHbnhj?=
 =?utf-8?B?cHBnMmNuOTZQRDRtVndQTlVJSFFBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdc3599-ca6c-4977-4038-08dde6458b4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:14:12.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfD20qfqZMqM3GiFEi+e8tlbTx5CoYH4Y5UF+z4rytrLcrnA5kgVY9L4wfQ+OfLu9Na/N2PNTGCiHnBOyYEmT42yKKLgg1K+OS2OhH14Zxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9126
X-Proofpoint-GUID: BEoCOi4Zhxc7yO_iqpaMHM_fQ9a8V2Pj
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=68b0724b cx=c_pps
 a=jYz/sJF3x8jN8fYGx11WiA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=2S4h9W6yfilagQDK4rIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BEoCOi4Zhxc7yO_iqpaMHM_fQ9a8V2Pj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDEyNyBTYWx0ZWRfX4ggomKJzrH9+
 AWw0yAjX9VXneNNqUHQgMxfg1/zB6tybAAJ2WrSxFpMsQyRneJGZPs74mP2LOCuT3ziwOqOFfP1
 tD+0nxflTKT0WkC58tNgfNcYDynZHKhAxEuqUcoDr9f9FiGVtWtEWyaIvbuwwo73DFxMQIvE8LZ
 l5hNrQEssnhrt2AC/trmtF9KvLzrHFvE2giGeGn5iWbeuea+h2ELrETOdIYpDv2O4Dv5B83S8UL
 2clreXscUqKBLsY7tngMtDrlmzk+x0Wf/cWzVTH14psCyxFt5qxyrhyBDLD1C/IJOzUKLO8kca6
 y0ge/bB2+iPorm+DBesjseviFfj8G5M2syQinuiy2o4ZPwyYch+GbKDDuRrasg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
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

On 15/07/2025 15:13, John Levon wrote:

> On Tue, Jul 15, 2025 at 10:25:49AM +0100, Mark Cave-Ayland wrote:
> 
>> Use QOM casts to convert between VFIOUserContainer and VFIOContainerBase instead
>> of accessing bcontainer directly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Patch subject should be  "vfio-user/container.c" not vfio/container.c
> 
> regards
> john

Ooops yes, I can easily fix that in v2. With that fixed, are you happy 
to give a SoB tag?


ATB,

Mark.


