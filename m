Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE02C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9lW-00043S-8S; Mon, 17 Mar 2025 08:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9l7-0003wo-Hy
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:39:58 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com
 ([40.107.237.57] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9l5-0006Lc-19
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:39:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3FM9cKGyCBuCIeXXvdw4IiOJjpr6PZb0Ec1Unn5znnRgSrP9rFLQW0C5hmcuhEd/yf0Foa1E7dhfMGa4jGmuBNkS+UHifkfTmp6jZ7cQs04PCXr2kEFo3FVvaqo4pNcI2OC8kXSp667p3AOKoQNImXsiP6TtgxCB+qjiKuejg4wxM4A8KkUk/PAj7mtCuZFdN0Sl/7oug1e12DIG+BppTjDM59hnws1oJ0RDMBjAyN6+LHKbNDCos28+XqIyz5lVE7RV+hz42rXnagcqVb/1v/ielVanQ7qCl4ZdcyiaXBEHrpiHDzXOtwM73lFLQl3sXwTCKhYFTlyWX1J/ZInIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0T9F9PCdjr2UwnZonTJXw0xbjRnOFvcpBRXBBRuhco=;
 b=fpMyqqkwxv6tHJUJBsbT7CUdkOUW3Tl0Fn+pDDwdq71s6xARxYRuKnyxQYsgKI2TVXxL5WmNuriESOKOJlVraS+YZY5Z20D4rNyMYUbvxPV2hJj7PMMSWt8xIcjiPHHAYpI/m1DNNXcuaWUGZ0/EJykQuKLdsC3RO8bfCLq+kVyPiUYFPlk7pisN/V2FwxBel+WI6queVsxBYhGEe2pGEcfgSgbMAo2jJKOSAd793Vdz8W2oyO0avT4eHa1zM8Xzi7P/LinMJBIRb8cJbNRrMVcEwhyLZHQBZo6b/7/wv280kgQ40a+EameMg+XZoQUgXAz2PMXKaFITj3T6mLushQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0T9F9PCdjr2UwnZonTJXw0xbjRnOFvcpBRXBBRuhco=;
 b=xnzMZMY+OmLacwj9fmUbvFozwkqAvq4DC7Of1K1Ak6h5+TLq4QAjMIKMxsesNiicdoZixhDXQb4jQ0bsMkH8x4cpRv+j16dsSC20opY+jWBA5WLLi/dfHrgShiU2kKqmeTICjaZjzM6am3W1LeDenMaFIH4UEr6M1l20AbuNoAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:34:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:34:48 +0000
Message-ID: <0e234951-c5ec-441f-934a-39ad8348f912@amd.com>
Date: Mon, 17 Mar 2025 18:04:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] amd_iommu: Update bitmasks representing DTE reserved
 fields
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a626c38-ee04-4a07-d8f5-08dd65501afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUNmbXI0b3lrN1NiTmcycytFbWFXTkkrakxNOTBhbFpUSGsrY0dwWEFTZFdD?=
 =?utf-8?B?aEpnL01Bd3ZTczFVZzJMZTJYNHZCUkxzbFVwUHVVQzVxSDZleUg0dTFlbGtM?=
 =?utf-8?B?QmJpRkFvRGVNYndpQ0paMms4WUMxNmN0ZmpNZVRnSWU3QkRVQ2V4Y1AwbEtT?=
 =?utf-8?B?cjlhekVDMFhWeCtNVExsaFprMFM3VHNrYlVIN2oxajNJd0ZnSm0yelU5MUtJ?=
 =?utf-8?B?ZmJ1MFlvOXV5NVl0Y0VJaUlGeFlyUllUdmVFMFYwU0NjZzdSaFBVU3kwbUlD?=
 =?utf-8?B?Qm81L0VURkhWV29UVGZOVGkrQVdXS2xFN2l3YUpCK1NZNkVIL3VzSjB5UXU2?=
 =?utf-8?B?WkF5SjR5SE40S25hWjB5aVpxZERkYXdHdnBnZzZZYVJIUGtvNiswRGd2Z1cy?=
 =?utf-8?B?bjRJbnBvYllNcGNNLzZKNWFhaWhxNkVhQTlMdjYwK1llUTdSQjl1Yk9EZFpX?=
 =?utf-8?B?aVBZOWVCRUcySlFOelpHVU91NWdxaGR0d1NrZ1pwVDlrQzdCYkR2bzFkVXFp?=
 =?utf-8?B?VDBpRmZXV211MGcrYURqdWJLU2hPbjYxa0g0VUpiZ0JZTDFJdncxbktiQVVh?=
 =?utf-8?B?ZW02YWI1ZUZvQllvbmFVcll5UUlic3JqREV1K1lNbmREYzVuMUVsOHdkMU83?=
 =?utf-8?B?OWV4TW1QNEd6eXZodnJmVGxTT1NKTndPekR5dFhMeXMrVXdlczE4ODlYS2xW?=
 =?utf-8?B?TWtla0wyVXNacytjOGNlY2VqSzdjcFVaYVFmWDgrazdXTEpwbkNtK0V6alY3?=
 =?utf-8?B?L2JkSmhQZ2hvL2g5K2FmWVdCYWQ4d0pZTVA3RkFlSnBjdHRoREFiT3g3b2gr?=
 =?utf-8?B?VUdEVy9NUCs3WURDVjdCK3U5OGNyMzdXRzM5SFc4ZkJEd1lvc1hnUlVaMnMy?=
 =?utf-8?B?c0NxeXMrWmt6Yy8vSFdnTkRTNTUrdVJDOU1xTU5lTXhUV1Vyc0FuT2dGT0Nz?=
 =?utf-8?B?Mkwzd3dNRTd4UTlzb1NodzdTamJXbllaRFA2eEtLNStaUmRkTldJNG42RmlQ?=
 =?utf-8?B?dFFmdGZjd2Nhb1NIM3U0cnNYU3lib0xlOFdBdmVnYzNpaXFuQklaUE80eEVD?=
 =?utf-8?B?Q3Z0U001K3Vsc3FYNWpSU1R4NTNObldKZTZUTHI2Snlaa1lIeEdVQTNRTHVy?=
 =?utf-8?B?WEF0dy9iRXJjYkFFYUxQNVM0VEdrS01OK0FSbHlRQWYyd2QzUkFDYnNNdXlC?=
 =?utf-8?B?UzJ4a0xlS2syY2laZVkwdm5IOFhUMUNzcW85Q1pwK0dvZHpiU0pHSVBsanNw?=
 =?utf-8?B?bkViUUZjN1d1UUl6MVVqdjI1NnIyMzg4Wnl4YjE2UGtTdzFVQkxRU0laNnJk?=
 =?utf-8?B?Z3dWWnJHdC85TlhKeitwakNIOEZHaWVFbkJpQ3pPa0NMVitWQzdWcVpvN1VS?=
 =?utf-8?B?UFpRV2N2emJzd1NqYUdkQ0o2b3JoYmFGUDRVOTdoQmw3cEtnWEdUOFp3djBq?=
 =?utf-8?B?NC9mZW16Z0Exd0pPVkpVbHp1VWV2TWtLM2IwblhnYUh5UUlDLzU2QVZwTVdD?=
 =?utf-8?B?NFR3Z1d1VE9ka1FLSzRWV0ZudmhXbmF2TGFkUE9LK0ZjSEpuODRDbHNjQnNH?=
 =?utf-8?B?anYxS1NRK1dvd1JLcktVY1RaWWtEN1NXWERobVZCdlI5WlR5QU1YUEhJdmg5?=
 =?utf-8?B?M0NBUlpYdmVNM0l3OXRzajJlKzJ4cXhmWnVVK3ExQnZWaWVQMmQxNW5KQkQ1?=
 =?utf-8?B?bGpXY0lsTGc0b1VJQUlIUmlFOHo0Kzk2TU1vWmk3MmVUczh0OVNjd3NaUmtQ?=
 =?utf-8?B?V2VRaFg2d21MaERJWnc2NWsrUTlOMEEvQ3h0aUd3YS9XbTVjTXk2SnIwWHVD?=
 =?utf-8?B?ejN4S1FPcHFhOEVBZVYrRFlHR1MwYU9FRHJTekRXMXlDTlBCdWFMVGpubG4v?=
 =?utf-8?Q?WCAFthhqn5Hsd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJxRkpMNUxtclhaVWt2L2Q4NGloLzg0R0hCR3FzTHhyNDRGTXNacTJRb1l0?=
 =?utf-8?B?dzdveUJrajJmSWt5aERGWHdPTGZHeDBkbEdLeTErUE5Fc01vRUw1ZlBRU3Uw?=
 =?utf-8?B?ZnZuVU5WNlhKcm85U1JiSkhoTC9HYWZWdzNJNkhueWFTQXF3MExGSS9QNzYw?=
 =?utf-8?B?b1JLR0hiOFQxZG8vZ01vamZ0d1hzRFFVdVc0b2U4ZklsdmdTcnM1ay92Y1Zm?=
 =?utf-8?B?OHZDVnhNN0RFdUVMVVdvS2dFTDJoc1hjM0g4N0RXdFc2STV2RktwT0NpUlF4?=
 =?utf-8?B?eDFDOGVKMW04NFNObldsYmlUOGVuSmIyM3FpSWxlZlNicnhkM0w0RzFFOC96?=
 =?utf-8?B?RW0yMWRYaEZwblpsODBZYVd6TFhzdzh1MWd5SDI3Yzh5c3oyYTBmVTZIK1o1?=
 =?utf-8?B?YjVMWE5FM25VMnhCb1Z2T2pLeksxd0JTUGRDV05PSC9GeStERlk2WWNUUnJW?=
 =?utf-8?B?N1BSRzdNQVJBQUc1ZnBOQXBjby9BV0V6Q1NiUm92THdVUE1EUXRycWRJNkZV?=
 =?utf-8?B?Kzh1ZEpieUNuczFDdUhYbzNrcTdOTE5OSjFTNnZMT2gvbG1oMjI0NzJERzVm?=
 =?utf-8?B?bTl2VEJBNjZzZEtvTWpUOG43N2JrMmF3a1cveXRtSHI2NnUvR1dqcVN6V1dZ?=
 =?utf-8?B?M2xOcExDMEN6RERRc0E3L0NIcGwwZFd6NFZQZW1iQ0VHT1FnbGhId21nQ0lG?=
 =?utf-8?B?V2hEYVVCMEVOM29nakxJTnk4WHdQWUlJQ3VsQkwwNHMxM1pNNW1JbzVubUtZ?=
 =?utf-8?B?ZW8veWxLVkp4cVdIbHhaaFVtc2kyWWVjUWZXTEUzdEQ0RWVLNDgyL08rZlNR?=
 =?utf-8?B?R0RPeTRqMldQVEkveHVCR2ZlblI3aFJ3QjVZNFhWNlVDeTRUQ25Pak5YZXhH?=
 =?utf-8?B?bXNIRGdVY1JoSEVpK2VIRDNIMjAxaWZyUkMvL1VZUnNjL2F4NEw3ODcyV2Nz?=
 =?utf-8?B?QUYxYU1OM0JTczc2eWl5a0pVeGZ5NGJUdHRmNTVyeFdLS3A3emk5Vk4zNkpn?=
 =?utf-8?B?ejE3dzNTUXJPWU9RUmFta1UwUk9WRzY2eE8wM0lRNnNPT2dvTXNPRnpiWjUv?=
 =?utf-8?B?clJrUE5oZUpkcytrUW05ck9NbzRmc0R5elZEOStCNis4d0pTVTJQR2tsUjZp?=
 =?utf-8?B?dU9aZTA2bnRhbjRGR1pvT0J0WnBZZWlENEpnYnBza25JaWFUV3o4TGRJRjQv?=
 =?utf-8?B?UUdoTlZCSVhnbjBQSFRWK2xWV0hNa21DVUIvaTFmSEVQbzk1VHRWTHVlSkVz?=
 =?utf-8?B?anVPLzFCVFdlYVBMcnBpWGNLSzhTZVgveERnVDZBTXl4SVpOWlBITFMzSE9D?=
 =?utf-8?B?NDROdVFTckZRMlBaK0pQVlE0QzhGMlFLMlVLdUxsNkw0cTNPcW9SRXJ4WlF2?=
 =?utf-8?B?TDZSZGdNb2dZcTM3US9uaFRFZXNTYWVneGw5YXpJam52TkZUYnQyU01EdU4y?=
 =?utf-8?B?TExJWk5OU2E2NU1Jck5kZzFwdm01elFwVGU3VmtWZWdBc1hROXdsMk1JM1Uv?=
 =?utf-8?B?bmlRaTdvNTVEei9wNE4wTFN6NGNuanF3L1ZYK2QyaU0xQmxneTkyM2tvM3Nz?=
 =?utf-8?B?L01IUkNLREtGc2ViV2ZSRFEvMU4wczFNRzNTTU5rcUtjQmJWRCtNN05yUmIy?=
 =?utf-8?B?SjE2YVkvdHlPVzhSelVoRnJBUkxSMGdaL1NNMWNhUVFDUHJDWTVZRGhFZC9R?=
 =?utf-8?B?R1VybjdPWHJ5aml4cGVLeWtibTRLSlZISHlsWVdjSDU3Y3pObWtaNmd3d1pn?=
 =?utf-8?B?YnFlOHVtWnZEZUo1aHZRSVlUS3pYczAxK1RWbmxzRkt6U3JZZHNPSW9INHp0?=
 =?utf-8?B?a3M4Z1Z3Y2FyWHRJaDlqQTlUNTZRSzhQZW1uVEp2WW04MC8ydllaYndLK3NU?=
 =?utf-8?B?d1ZucTA2blZlQ1I0TStiUHZnNnRjU09uZ2RFZEtFLzFlSC8wdHVjYlFKbkJh?=
 =?utf-8?B?OHBVaEtzbE5tOFkzWTU4RmN0aW53UXpBa2wwSHk0Y0hyNFJua2liZERhS2F2?=
 =?utf-8?B?UGw2azZmQ2N0SjBpSGtYTXd3R0tiN3NPVnczSjZJcmtnZGpyQ0RjZEZDUE9r?=
 =?utf-8?B?c0FUVnNVVTc5RmxUYXpadGdpV05FNHlPanovUnJKM1ZUL0lDNHpydER1NHZS?=
 =?utf-8?Q?a4B829z9WyXO/3rBbuSUZuamt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a626c38-ee04-4a07-d8f5-08dd65501afe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:34:48.4860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQEKD6N2gF+qTq6C2kPIBouzZQdUnsMJAk8Qcv4bfgRjWMWunOPY372XKwG3YwnQx+eCzvs80Nrij+pHORtzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
Received-SPF: permerror client-ip=40.107.237.57;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi Alejandro,


On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The DTE validation method verifies that all bits in reserved DTE fields are
> unset. Update them according to the latest definition available in AMD I/O
> Virtualization Technology (IOMMU) Specification - Section 2.2.2.1 Device
> Table Entry Format. Remove the magic numbers and use a macro helper to
> generate bitmasks covering the specified ranges for better legibility.
> 
> Note that some reserved fields specify that events are generated when they
> contain non-zero bits, or checks are skipped under certain configurations.
> This change only updates the reserved masks, checks for special conditions
> are not yet implemented.

Thanks! Eventually we should add some check in amdvi_get_dte(). We can do it later.


> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 7 ++++---
>  hw/i386/amd_iommu.h | 9 ++++++---
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 068eeb0cae..8b97abe28c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -848,9 +848,10 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
>  static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
>                                 uint64_t *dte)
>  {
> -    if ((dte[0] & AMDVI_DTE_LOWER_QUAD_RESERVED)
> -        || (dte[1] & AMDVI_DTE_MIDDLE_QUAD_RESERVED)
> -        || (dte[2] & AMDVI_DTE_UPPER_QUAD_RESERVED) || dte[3]) {
> +    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
> +        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
> +        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
> +        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
>          amdvi_log_illegaldevtab_error(s, devid,
>                                        s->devtab +
>                                        devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 4c708f8d74..8d5d882a06 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -25,6 +25,8 @@
>  #include "hw/i386/x86-iommu.h"
>  #include "qom/object.h"
>  
> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
> +
>  /* Capability registers */
>  #define AMDVI_CAPAB_BAR_LOW           0x04
>  #define AMDVI_CAPAB_BAR_HIGH          0x08
> @@ -162,9 +164,10 @@
>  #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf counters       */
>  
>  /* reserved DTE bits */
> -#define AMDVI_DTE_LOWER_QUAD_RESERVED  0x80300000000000fc
> -#define AMDVI_DTE_MIDDLE_QUAD_RESERVED 0x0000000000000100
> -#define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
> +#define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | GENMASK64(63, 63))
> +#define AMDVI_DTE_QUAD1_RESERVED        0
> +#define AMDVI_DTE_QUAD2_RESERVED        GENMASK64(53, 52)
> +#define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))


In vIOMMU case guest is not expected to set any value in DTE[3]. So I am
wondering whether to match the spec -OR- what is expected in vIOMMU context. If
we want to go with later then it complicates as there are many other fields like
GV, etc is not expected to be used.

So since this matches the spec I think we are good for now.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant




