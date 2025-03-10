Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700C2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trlsn-0004qq-Nk; Mon, 10 Mar 2025 18:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1trlsm-0004qZ-LE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:46:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1trlsk-0003Hc-Ph
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 18:46:00 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIpiu3012229;
 Mon, 10 Mar 2025 15:45:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7cY6eL696zYDzE4JC4lWURb5EoUgS/fPUAa+IrFPa
 Cg=; b=YxaQqK0mojXRJR8QO5dqKg5+tRPbg3i/mpZ4Tm9bQy/QSUL9xlPpiefdB
 RlkDoeKkvAtO9oOTmWUjiJl1C0SgDG8piyAhqjHy/3P+VQLgAq/UIrjsfX6clXhN
 NtN+vdYh3LRZCJGnj6pFY6np0djE6hdc8AFOz9MZGwWvcuPd5i40wAx5CypiUzMx
 wv4pDc/JcDZ+KZEkDLKWvpzDUikc+1xD+R/KLF04jBVC5mKwxiGio5i8/TRk/8sU
 R85kaoI4pJz4HWajgxppCnDTr5lAAtWvuVV/H3ZX2nB7ReX60JPMeJqA7PRpyfRi
 EinZrdS2NdaDV6NkbDS3Byo/ap1hw==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45a5qxrf07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExjBncGaA1XXTj6KGzQIa8TBu/AsUMyGrNxfZbgC6ESljH+smIHZtCfIU4ARSOVjheBgKn/SEaz9+fShlrr2ggU594M8bIZCnCJX5RXKfLcjJkqSFpoAms5nhL0Jjsp3ZkN6JfvBLUaPb7mYKsmVwDUgC4Mov9UZ5z/tTIRen408sczlthBkIFUBxUmLcDqwAO+pkrk33HeLD13G7abg/rRAPQYIej3C66CeqIrwbcnDzK+V+Ovqo1O3ZweB74Shg/Lrj5XnvzLeJZNN50Gni4ekxskfP5Tnj+mWMsWsvX5pAykgjLQn2JiDjmbbvPGH0bQMblMOAK3P8GRDNwDfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cY6eL696zYDzE4JC4lWURb5EoUgS/fPUAa+IrFPaCg=;
 b=QA7Mp+sjMC9Cf2rQ+iudCIoZEaVnY24FpEVCZpv2xy9STq745jAqVcRjTc44xz1hOFkvDmnNVp4tu9uL1jqsW2hYLpZkT36/ZFMYtjot/xlsa+hz6wUU40pdW8+cQ0O5P0bCihZfuDNpqvtZ88u0MkZYBiGej46ktVQbDyLmpV1tNd7zpsZJ5MnyVEJkatW/RnqdGNVX13kdbYJfMyfOeskVXKpXXgFqxbDIeHsMZfQY/gPn1T9Z9qcwOQ70QRkCgSKxplyfWH4LGTcW1Mu1ULeBHR3lQRwTqHCYZ7Gw2FlydJuJqiytS4VZ4/jI+rphYIh8xrciuSet6DVaBX0S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cY6eL696zYDzE4JC4lWURb5EoUgS/fPUAa+IrFPaCg=;
 b=wDAe5HoCZI+sGULNHc2cM2pnn3M0fYST9q6/esphF00bJ4DEDnDOmDkza2yvtN4QH8IqAP/DsJstr8eJyNDy2L9w5sE+KZxF+TO7H6Bn654AH8s4BallGtchXHsa+EeyVvSY9/mEegs1Ow+rMBBofKAdMfNGZdX8A+m2tNXOjFPs7EZVMIcwSZ9+DCNjEJgl02GAktHaPXgXeBB3BCnZdvPBRXw9QrmFDKoaDL9dk/Z8MSA3juA8SO+5LY7IZYAV4lwA3iMpsPOdcJb5ZOmWaV3klS+fqQDhhH3Ntilf0UwtQiZNvzw+MyS9fM6Tuk+cX8Lu55vl0w5ZcY1cXKM+1w==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by MW6PR02MB9820.namprd02.prod.outlook.com (2603:10b6:303:23c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:45:52 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%6]) with mapi id 15.20.8489.028; Mon, 10 Mar 2025
 22:45:50 +0000
Message-ID: <a384ffc3-34c5-441e-9fdc-b82cf4238b22@nutanix.com>
Date: Tue, 11 Mar 2025 04:15:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, farosas@suse.de
References: <20250310011500.240782-1-manish.mishra@nutanix.com>
 <Z885hS6QmGOZYj7N@x1.local> <Z89CALrwKnHdO4hx@redhat.com>
 <Z89FjreYuRjEeX1f@x1.local>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z89FjreYuRjEeX1f@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|MW6PR02MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a202d4c-6720-4342-de0c-08dd60254e74
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|52116014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkRodTFURjRUMnZFdHJtMXZJUWsrbnpvYkxaZGJMZGJTdyt0QURPa2RsdTBH?=
 =?utf-8?B?RnFjM295azlQUFczcE5FTGFQWTdWSDZHcmp2Rmc3eFhtY3c1QTlEelh6V1Yw?=
 =?utf-8?B?MC9odG1DZWRKckFkcnNpSjVGK0JObzZSU0w4THpyZTNYVzdkcU9ud2RvNk94?=
 =?utf-8?B?akNlUU5mbmdNNTJHZHhYV2ZOWnVFNDNvbE1OaFNBdzhaRXRTQUJWSG04RDlD?=
 =?utf-8?B?M0dzamlPL3Q1aldVK1p2UzQ2M1VPRWQ4QkxpUHJ5b3JFcGtPelV3VWNPUEJN?=
 =?utf-8?B?bFJPMGYyUWZ2bkFuMTY1YnJsaFlYWmhuby9CYkhYd2ZiMHpJNG82RWFTVlZ0?=
 =?utf-8?B?a3d2SlNpR1VVcy8rMGhHWDVvMnNrQUdmMVJBN3Z1V0c3RThOUzlqZkJmSFE1?=
 =?utf-8?B?bm91bHo0NkZuaFFvY2RSQ3VSc3FpR3AzL0cwc1hvZ0YzT090L2lmd1lIeUZ1?=
 =?utf-8?B?UWpQZkFnV2haY1laNEdmYnRLS1dnZ2dMR0NHQ1ZMUjJQT0Y0MDRBUlB0cXlK?=
 =?utf-8?B?YmVVVUFCNzVZU2s0SUc2UWgyQjBwOEZuNVIzK3ZEZ0taTFhwRlgwczNMWk1q?=
 =?utf-8?B?UXR4UDl4cVpxMGxzK0puMVhoYlZabEp2YWM1a1BGbU9SZGUvdmV2VHBKV1la?=
 =?utf-8?B?Z0llaElnbWhkSFJuU1FVK3lPaDBLcWM5TlZuV0pyZ0t4Smw5L2dVdjFXQUd6?=
 =?utf-8?B?b04yRTdHN1J3THRPcm1mRTJxS25TQjJnOUxSR1l4cTBiRVQyWkpOUkIycDh5?=
 =?utf-8?B?WEljekhBWkh5OVZUeWVPYjg5U2F0TEZMOEFWRVpSbEIwZXZmMUZ2cG85MUNq?=
 =?utf-8?B?dHUxNXBXMXAyOTl1NkxvaENjck1rSjB6MGFtbG0zUWs2b3MyWDd2L3JhMCsz?=
 =?utf-8?B?b0wxU2k5eDhOOUMzZTFNcXkvMXhIVTZLY1pUVTBCakwxSXBZMFZTNCtQZ0Jx?=
 =?utf-8?B?V05Nc2lpQUdGMGY1bnozbGZtSG5WNnlvUEVTbU50UlJuNVoyWjZxUnRRUUpt?=
 =?utf-8?B?NTl5QndScEtjLyt4UDlTRG45dHhqaFpFWXlaeVc4Z1ptU1duQlA1Ny9GOEZC?=
 =?utf-8?B?b2FKRTBCWVloT2I1cldYYlBqVUZuSVdmdldySFpORHQrSERmUWxOVk0xY1dE?=
 =?utf-8?B?bE16NGNRVVg5OVNnWHBUcmUwbStGZjRqbERudS9MUi8rbjZOTjVaWTgzSnRQ?=
 =?utf-8?B?cGRwa2QwS1R0NnNaVWJLZWRteG9SYkx4Uk9tcDNBSkVMSHlzcnR6bVlWRVdr?=
 =?utf-8?B?bHlNREdpb3lRUGlheE1CZmExNUVDbTB4SnBYUVJtUlhna3lFbHV0SVkwbDVw?=
 =?utf-8?B?bzNKdk5nd0RqRjJCVFlPQUtQaXdKZS9jSTk1NjAzYU41akFIUU5vRkNGRDFT?=
 =?utf-8?B?RTB3QUxhNHJaRVlOc3g4OUx4NEpYM25iemF0My9na1JqSko0dUU2cDRCRjQ3?=
 =?utf-8?B?dVdoWVR5UVVXYjVuNWYzQ29ydktRVitDbVMvbzgzNWpaM0l6eVp0eHBsOFpq?=
 =?utf-8?B?SnVXNDkwck52eEZWQXduUHQ3NlNiY2wyT3NLMnNVZW9uWithVFNUYkxlZmdT?=
 =?utf-8?B?U3hZYzVSRC95eFZGNUsyMGROQW44LzIvZCtmNzc0QUhJNER6eFgvQ3BYSzZK?=
 =?utf-8?B?Q1o1dW9lZW0yNlp5dDFDTFhmVVVtZlJEdUhCOTUwSVZHb3N1ejNFbWxieS9X?=
 =?utf-8?B?NmF5clhtajYxMDNhSWxvRDNxUmdZUS92ZkZBdEVJWnNhWEU2ZlY4ZVZHdVpH?=
 =?utf-8?B?ZHIwMUZnU2FPU1VQQlczOG56TnprRHJ1YXhiNUZqdjZ1QTdPckhVSDZWODNt?=
 =?utf-8?B?dWI3NjlZZVdaNVdwMGpBQ3pMQTg3ZjVQemdtMnVKTnFPMlNtcThJcFQrc29N?=
 =?utf-8?Q?L57zwqAjZ1Avl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(52116014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVMVXZBMDZoN0xKZUNlRFoyU0VwQllZQngwcWhOeTEyVHNOL2ppTkMrT0hP?=
 =?utf-8?B?S0QzeUNkOTJhbDZidVNhbzQ4T1dmend0akJrWENDa25raUQySlFBTnBWeFlD?=
 =?utf-8?B?a01hR21MZFRvSVN4eWdYekVVL1drLzN3djJYSzRuQzIvUHE0R0gwbG9XVyt2?=
 =?utf-8?B?cHNiNWhoaDdSbEkvbkhvQmlIWUdsc3NmMnp3U1dhWExneU1qVnFqQksyaUJn?=
 =?utf-8?B?T0kyMHhJakVRWlhZL3FDMk5NMlp2eHJEZlZHazhJMVdud0g5MEVXb1E3VTRi?=
 =?utf-8?B?Tks0UEQ3UE0vL3p0T1RQN3dQZHNtZGJjYnJVRVl0bEhjV2tmbVRQVURZQXE5?=
 =?utf-8?B?Q2d3dUNrOStkVlpmajQzRFN4cHdtMHJrUU1ZbmkxRlcxcEIydzhlUHFFY3M2?=
 =?utf-8?B?bzVaV0NpVDdwN1pmajJ5NW1ST0lDWmFDNDNvUnpNWHowUExpR1VMVjZDTm9Q?=
 =?utf-8?B?cXJramUxd2tTU24wVWIxeHlBMytFK3IyQS9jZTZ4Nk1JTVo5WEtoMHBKUDlY?=
 =?utf-8?B?MC83bDBHMHJ1Vi9yZFdxZ2FEK3hmM05WSlg3b1JuTlpSblBtVW83YS9wTU53?=
 =?utf-8?B?WGhqNlRQNWc3ckRoMDN4Z3BicmdlUTh0aDRKRytWMlJubW9NU2pKSHJURUdQ?=
 =?utf-8?B?eDdvOUZMekN0NTJMQm1mTFQ4MFRFNFNCYURBaHQ3VUdYVER2U1k4eGRDaDRH?=
 =?utf-8?B?Y1J1YVB2V0pkdCtaNzBQelJIUjVoSjZmYk82WTJzdUNXcEhmNWlFZzhXMFh6?=
 =?utf-8?B?TCtlcU9UZ0ptSVdhclpBWEYrMHh6UFpwZUZrbUhvZXBPOWN3ZVNXNGdST2Rn?=
 =?utf-8?B?bm5CMmx0WlFCM2V5ZmNheC8zeTBDdWJsVUREWlVmY2lGWS9BOGRRTG10dG9X?=
 =?utf-8?B?aWIyY0xMVnU2MUNFcXE4Zml2ME5xTmRhbmhWdFczUUwrSFhiMEhOMnVpZ1RD?=
 =?utf-8?B?S1ZDVjlJN0MySURGa1BNd2tzZVpRS3BYN0JaSlM1YVU1cENLelViRjNZeW9j?=
 =?utf-8?B?V1RELzVuV0VCMGVsc0RpOTNFMTFYVXpZK1ZHczZRRmZzQWRHbEpGQm9VOXN3?=
 =?utf-8?B?emR5ajBERzM4OVlsWE9kVTBQcHFlU0ZUV0Q4dFFybWRra2Z5eVN0MTJrQ0th?=
 =?utf-8?B?d1hSM1FPUEdCenIzRU5OUytkYUVydWIrdlhwM3pwSUpIcTU1WmFLTEhNQXdq?=
 =?utf-8?B?aVZOWWtta3c2c1ZveFVKNXdUajNxNngwL3dGYmxCWnF2T2w0MWovN1JRa1cr?=
 =?utf-8?B?Ty95NFFnVUNQeE5zNWpiN011KzFhdFpzblFweS9iSzcwSzM4RUpITUd0NDBP?=
 =?utf-8?B?MTQ4Vm9jTEU0VmhWUzlNTDlpZ3NBRHhHZlo3VDFLKzkvM3ZLM3ViYVJOaVdF?=
 =?utf-8?B?SzBwdEFETVRqdksvcnpFZWx2NVR5M056dmppL2UyVkNFRkRzZ2hkSGphcjBm?=
 =?utf-8?B?R0ZnQlJHVUN1dDdwK0kzNjQzNnJSQlJNZnUyd2tsdkphMUhDYWh5S0ZtS3Fi?=
 =?utf-8?B?NHVWMUplVFVOd2F1OG1ETUhPb0gzWDV2UlJZSkdLZk1kd2JRTWZFSVlHeEVn?=
 =?utf-8?B?YkZQbkRuRmFQN2crMFlBcmpqYVcvM0krMHNYTFpJUGc2NFA2NElLTzdRbDNP?=
 =?utf-8?B?RWNUNGN5dmI2dzVWYjhvOWVGRndjQnRxSTVQTTRqNTJOTnJ0cytFdURrb3Ur?=
 =?utf-8?B?czVLdS91TWFuVzBSOGlZd2R1T3djZ0VRMGNqRm9kT0F5STFRc0hRVXArbi9D?=
 =?utf-8?B?bXRKM05id1liMWQ2L3dmZUFDWjFTTnUrTEJBd3lPNS9oV3RhOFVpUVd6UGlT?=
 =?utf-8?B?VEhkdGZIMTRrUDcwZWhTQ21PcGdLS1FpaWc4bFQxeUNXNzhzdzNvcUNiUkhC?=
 =?utf-8?B?eEpBWjYzMjFvMldWQXRYZVRmTmV5YXVxT3dxd1k5MGtkNFdmbWFHZTJnR2JJ?=
 =?utf-8?B?SXZpTjRUTy9xa1pLNFJBdXhCbzVRTGhTQWRuR2R3Q2t0bDl0eWU0YlZlL0FQ?=
 =?utf-8?B?dHk3c0VrblZ3S0gyTHN0NUovSldqak54TFkyNWw1dCtvZElQOFpwTnVkcDNj?=
 =?utf-8?B?T1diTktMODJrZ2tXMmtydG1lQmpLOGRQUVBvNlJyWnRTVGFJYkZUbFNrVy91?=
 =?utf-8?B?M2s3RWVqS293SXpMRnJNSExTZzhSSjNnYXA4bVErYnQyZ0NJcEl5TXh0bUJ0?=
 =?utf-8?B?ak5jL3BjK3UwbHJOYXNzR0NEQ3YxQXBKajE0VkpRelo1aDhJYmpCWmZqK2Vt?=
 =?utf-8?B?ZFNHQldEUXBSWkFMazV3SHpDd2h3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a202d4c-6720-4342-de0c-08dd60254e74
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:45:50.6650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55hpxsRe38WtgG1bxDmCNDmuHbcb8Q1XZI7GHSjYNQgmDW8qugMM2mwyku1QdDCEknWOO707BUvL5hzvdMAHRbTFwyNM4t0iSigFOnnNcHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9820
X-Authority-Analysis: v=2.4 cv=JInBs9Kb c=1 sm=1 tr=0 ts=67cf6ba3 cx=c_pps
 a=6eDru+6t2m7UgPRwoW7UVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=0ht2gxaf-8_oHjG7jI4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: js982ES00r7amQSUS7oSjRXezjhNFM4y
X-Proofpoint-ORIG-GUID: js982ES00r7amQSUS7oSjRXezjhNFM4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=manish.mishra@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Thanks Peter, Daniel

Are there any code pointers where something similar is done? I can 
follow that.

Thanks

Manish Mishra


On 11/03/25 1:33 am, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Mon, Mar 10, 2025 at 07:48:16PM +0000, Daniel P. Berrangé wrote:
>> Given this is in public API, the data needs to remain reported accurately
>> for the whole deprecation period. IOW, the patch to qiochannel needs to
>> preserve this data too.
> :-(
>
> We could potentially mark MigrationStats to be experimental as a whole and
> declare that in deprecate.rst too, then after two releases, we can randomly
> add / remove fields as wish without always need to go through the
> deprecation process, am I right?
>
> Maybe we should do that..
>
> Thanks,
>

