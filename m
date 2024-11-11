Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F98D12D71
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 05:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tANEN-0006E1-5T; Mon, 11 Nov 2024 00:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1tANEK-0006Dl-HB
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:44:52 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com
 ([40.107.223.44] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1tANEI-000375-B1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 00:44:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVM+nTPzAhBIiwVZVKs7czHlHI6DR0v+yZ9tIk9iad/BlIpKw9saIDUDzh1a7//rsp3xRxPusvsjDbqYClRtb4HZVXsxA+vddxjpNgXn2v+UXJslkYTbH02nT1YkjI9AVL10z1RWPpx2czqaz1PoO24y37Zyl+AejZqBMiK7H4J13etITTTNXPDQyLSkPMnC+ogmUq5qHiQSTjEKPM3Myk1SmPxX3oqmplD+u7x0+BO4LffFNtdV/lhXKrRU4RB+1uWZxPwfU4MojY/mpn/mtsmgR9seqyZHUWS5VYrvL7rrljPNKYMY25CibOHPMG6aPuDnGPizMz825/LgxEntpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQBcpIx28W6qK7rVFrLaUjy9vF5S2awg+9Ph5EPM5fc=;
 b=OplT5ATGn0S00IA6KM398xv0CUk4m1XzNW/kB7JDDE92fz7LHtDMzYiGqVeA8NGwqNDo1rO3qW1K+aCIiqYGRi9THxQ/pzAe+KWWJbi3KM8H6VahDjTgYwOYTd0zhbRuTAp4I1QY+pkYi5ezOoB7HPEYK1RRPGrm96smkSnTr0uhX5evrdc4bOfxyOlg1mLn1wm60OeCuSZwV48wkwvdK1ncduVek3rhvAFUaFU26pbD3c70oRWTJAaP15tcu7loqZCg+KU5lI4MD3eoj5T1QzoruSOjR8ZYQSK2l2/w2kiQvpTF+94Ty/w2kz5xKPEbPOyIDrC2BAGlL9NqAVP3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQBcpIx28W6qK7rVFrLaUjy9vF5S2awg+9Ph5EPM5fc=;
 b=hZ5UziWd8pEmSogtuiuoXgZXINDNE90NgLbFGIYk5+VnSz8Hp/rheRpiv8QNV5YmAj2B5dfBVDADUej7nTA+rUoeERhsEc3wu3nh7lQm+sdoOKRHn55zAXs4tba4T7Ct1hZbc8eRo7sXKcZvNpLdYuh6pT78hrRKQkkqV++8XJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 05:39:43 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 05:39:43 +0000
Message-ID: <cebca38a-5896-e2a5-8a68-5edad5dc9d8c@amd.com>
Date: Mon, 11 Nov 2024 11:09:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PULL 32/65] amd_iommu: Check APIC ID > 255 for XTSup
Content-Language: en-US
To: Phil Dennis-Jordan <lists@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, sairaj.arunkodilkar@amd.com
References: <cover.1730754238.git.mst@redhat.com>
 <b12cb3819baf6d9ee8140d4dd6d36fa829e2c6d9.1730754238.git.mst@redhat.com>
 <CAGCz3vsrwGQ9v_ZFtteU9jeHpw7z5YATLDLbuKS=dpAzs3C_HA@mail.gmail.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <CAGCz3vsrwGQ9v_ZFtteU9jeHpw7z5YATLDLbuKS=dpAzs3C_HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|SA1PR12MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db7120f-429b-4ff3-cc45-08dd02133e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUxwQVRUVDMxK2JMZ3FVVGo3MkYzbTNYUktmeUZGWSt3RWY3YjNPZFFpUFhJ?=
 =?utf-8?B?VGNOSDNJa0hNdzQweVNCWnh5Z05zWGJGUWU4cE1qYm5jOXdSZXNCclhIbDl0?=
 =?utf-8?B?MXlLUmRDRUNpVFR1bVZIY0dha1B0VXRJSkhrVmdmQUZid2c3elhTV1F0Mnd0?=
 =?utf-8?B?MElVUHFpVDlCbk9HVUtpakIrRERqWE85dFgwUEdVa0pLNkVaVldML0NnUFA2?=
 =?utf-8?B?cDlIK1gxdHoycTBTd3FVK09TbitTWGhzYnRPQXBDMHNmb3gzMWVNWnJoY1dz?=
 =?utf-8?B?UkJTckRwMG1RaExIZDVETUJseUJCc1lhektIUDdUSDdtZWhQYU1DL2Q5aXNo?=
 =?utf-8?B?ZHhsV29QU0swNmdBNUhYemV6alhDQjN6bjE4UE1zVjZkNk5tS3BWaFZRbFdp?=
 =?utf-8?B?YytQU0lEV3RiOGszQ3MzcDh4QWMzclZqSWROV3h0eUcwdEFNdENoTWk4LzRL?=
 =?utf-8?B?ZmtwbkloS2pJNUJmTlc4RllwOU0xVGJQUExQb3E4T1EzYVdGUmRLcXljZVZ1?=
 =?utf-8?B?eEM4dm03dmIxNkZvV0xqY29FaUFFWm51eW9xdGI2YjdaUElabXp6L1ZoWDZ4?=
 =?utf-8?B?cXFRZEllK21KZldkcFkrTDdhbFQ3V0Zwa2dLNUVPbW0vY2h1L1l6ajVndWx3?=
 =?utf-8?B?cmk3N0FjMXFxRGhGbVplaDlDaWlBOVdGaU42cU02bzRyNWs2NHpnckpqRWlh?=
 =?utf-8?B?c2xobFpjREdZSE1qSVkxYjRhQUtyN3FsV2dENkNTek4vdkZGNGNQOVkrUkRP?=
 =?utf-8?B?VHYvd0RIK3hNdVF0YWR3SmQyZE15dHZ0eGR3ZWxyckVzbDdIaVNYTzdmNVpo?=
 =?utf-8?B?cVVZUWc1Ull3eXNqUEdlZ3hJQ3orbnU1RlNDQkV6bDh5VVpzQm9qYWtmTmJa?=
 =?utf-8?B?VkhrUldBRHg3NTJFMW1SOGNuYnhmS0U3YkNqRVBRQTJodlZ1bGFlLytJOHhY?=
 =?utf-8?B?clhYOVo3MzdUVGZMVmlBcDNXdnV5aDhMU1d5OFU5a1JMMmhxclZ2TVh3TFVv?=
 =?utf-8?B?cnJsY1JsTXo5M3BCaHB0TkZ2UGk3YWhSUEh5WFN3VHRVajhlYVRBdnp6czdE?=
 =?utf-8?B?ZExNR0dPL0VzVHVSVEdjMXRuOG96ckpFUUxlQXlyQmMrUFdVQmprUGtEazFh?=
 =?utf-8?B?L2JXSkk0b3RvK29taTF5bnhvZVhucHVUUGlpTHNTNk9uRGRzZ3BLeExsYmZl?=
 =?utf-8?B?aXozUnBUUHk4RGMvVEthUkNOQ09YejVQenIvZFpycWo3azZid3lYeWN0TFJv?=
 =?utf-8?B?N0F5cGVFZ2EvZ2N4cTU2NlA3emRXbUszUG8xeEQwSHlNQ0Foam9Qa2g3N3kr?=
 =?utf-8?B?MFZSNjdmcmM1TEg1ZGlva0hURysybXloUnd0b0tQOTBEYkZuc0lnbEdER1Iw?=
 =?utf-8?B?RGZjWXZpTlVLckY4NnlkTjNBTE9NN080eHNBL2xvY1dkaWltekd5aFU3MzRy?=
 =?utf-8?B?M2JDUWpBTVVRZWpNVXlmWGpKbFZFNThPUGhtWEx1RWkvWnNrelY2bElvcHVn?=
 =?utf-8?B?WERCdUdWNzdNRmZmN1NyK2dnNFdqY0hBQnhaeU5pVHltT2FaTlk2akJYWVRj?=
 =?utf-8?B?L0VKWWZGSk83TldYeFhOL1J1c1BvMEY4NC9aWVlZOFFXZUxBZnVydnFlVk5y?=
 =?utf-8?B?YmR1NzVaeUlKL250emgwd0krRFZsQjMxNityU1hveFpGS0tJclRKWXpFakdU?=
 =?utf-8?B?K2FHWVZzckw5WjNzUHQxdzMwaitoM3pMc1d4NVZHM0xycXJjVXZJMk84dmdr?=
 =?utf-8?Q?M0XeQpZFG9EBRvgHyFGQftOxyMR50BaPhLgTLZI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzMyUFFXUTVKR2F2L2I1dFpBTmtSUG1mQlMvdjh3NXdLQnR4VElWVW5QWkxy?=
 =?utf-8?B?Zi9UNXdYTGRDelN1bnhMdVM1NmRRMU52UExaUEZhWEZRQ2F3RWIweitpRlUv?=
 =?utf-8?B?enlHT2xPR1R5dllJNnBicnl1MCtMOHFDQmw2a3RNcGFZaHc2cE8vUXFkNkFz?=
 =?utf-8?B?a01ucmI2Q0VsdlNVRXhVbFhPVkRMNDB2MTExbUY3czNBdU9EdVJiL2ZUM2JM?=
 =?utf-8?B?d2VCOVl0SHFlVzlLV2Zabi95NmZnZy9XYktlL2JoNjRCUkVIa3FXZi9GSWxo?=
 =?utf-8?B?eEJLaGFzQVh6TkpETlV1RUhiZEN4NzBJTlFURWpoc0Znc0IraWNqR29TU0Jr?=
 =?utf-8?B?V2QxTHlVeVhzWXljWERicWZGNjZ0ZWhhUDRrT2hvNlRwT1RJODROUXFQWVl3?=
 =?utf-8?B?Y21NT0NiM3hxWVhCY1I4c1VpWFM1UkN4OVhMbEV0WVF4QmNoUFVyVDRuYUls?=
 =?utf-8?B?dGhSVTdTa1FpTjQwQU5QdXdGUkR1MU10K1BCZ1JkNWR0UmJITHp1RFZvWWFo?=
 =?utf-8?B?UVZhdXJ6RE4vZzBzRmJJVkQ5QWVsbC90SjJmSDZCRGtFU2p6bTlDanFKSE4r?=
 =?utf-8?B?S0Q3SVN6Q0FISEtLRndPRlJyWEhOSnhMWGFWVnNhaXNEUXRNRDgyRERWV0JN?=
 =?utf-8?B?UDFmaVFOK2txTTlONkZ2NTZmN1lIaSsrTlBPRWRMV2xHdUQ3TlRFV2d4RXBk?=
 =?utf-8?B?WGZTSktvZUlCZXkvM0VQM0NHVG4wSWhmSU5DNzNvNUE5Rjd2SlA3SkZpR2dl?=
 =?utf-8?B?SklpbDc4T1pvaFRxdkFVY0xuVHQxbXJoRUhvU25aNnZDRmd4OTBzSC9qZWdO?=
 =?utf-8?B?dWlOTmh3TS9TdG5vdGl5YkdzdFV5SnFnNnM3cWJ3T2twZWRJVkNZbW5TUG9I?=
 =?utf-8?B?a2s2dXlvTjIvLzhJVnM2MFd2ODQ3OEhXamt1VXZNdmtsMklvVDNScEVoV1J2?=
 =?utf-8?B?WVRwOC96VjhxWVMyQjQzRFJnWDc1cEFxT1VnUFA2aU5xaWQvY3NlanAxUUMz?=
 =?utf-8?B?WGpGUmwxRmZUZzNDNEtsMmJ1UGxCS1FvRjYwMG4vWWZUcW9nRnA3d2h0REJ0?=
 =?utf-8?B?cmcxY0dMZXZ3dlNIclNNa1hOZHhXM3B4Yzg0YXFRaTh4clRWelQ5VmQ5ZFpj?=
 =?utf-8?B?QmRmR1hVSVp5dU1PejFVbTNJKzRibmlqQ3J4K1dKMUFYZ3Q5UWxnQm5ZdVRK?=
 =?utf-8?B?OVhOZCs3aFdEbW9EK3UvYVRGTEhaWnE2SmZ0VkkzOTdmc1FFSjhzdnNGSnNS?=
 =?utf-8?B?ZVFYKzZLOVYrWUJNQmV3bTNvVFZReFJUTFY0cTVFcHRacTAyenlva2NNcGt4?=
 =?utf-8?B?Z3drTE1UaFRGbWlleTV0ZDNlRThVWHl0eUhLbndidDZGMlM5M2h0SVp0Tk91?=
 =?utf-8?B?Vm1zTFUrRjlSVDhocmpkWG1vcmtWS0QwQThQZXd3QjAvcWI3eU5ybTBqTFBu?=
 =?utf-8?B?c2ZLSmZvV2ZpL1pIT3FwbDMxS3d3YUJSU0M4QTk5UjI3Qlp6b1BxV2dSTjhh?=
 =?utf-8?B?Nk9Nb0NwajhDWnF3Q2dBek9ZOE54K2J1OUY1WmkzQVpFc3F4YTh0UmZ3VDl2?=
 =?utf-8?B?OVUrNHZLL2pQU3JXV0NidnVQUE95K1J1ZmFJWEtQVHNPc2xqdHA2VzFHSm9w?=
 =?utf-8?B?ZDU3cko1R1g5S243MDBpL01vYVA5VnhPYnBzZFA0aHdDMnFnVVMyakRrcWFK?=
 =?utf-8?B?T05oaXN1VmttcGdtbWtTRTZ3TVh4cXN5VElCdUpVRytyNElWNlovUzVrUE8x?=
 =?utf-8?B?RFFWZmozQmtTTGlDQWRNZFVVckttKytjR1g0VWlMNnpndnJrZ3k4bDVzcVFD?=
 =?utf-8?B?L1E3b2crbVV4QWZQcWZsUFE4aUhqNDJ1eVFQbkI2RlBhTkJKQkpTUkM3U1JS?=
 =?utf-8?B?alJvQ1RHTVFPU3JWRm4zcTlUbFZjajhOMGdOZ1dJNU5WOTA3RWM2ekh0ZWtp?=
 =?utf-8?B?RlVJYXFpaERUODFUZ1pKSlJTL3J5WHg3TUxWTGpDSzdSR01jWng1NW5WZlJ0?=
 =?utf-8?B?V0dXOUE4SjRiOHRjZ2JtWlBZWG1oODV3S0I3K3BIeXdvVUFueWVUU3RsdThI?=
 =?utf-8?B?cmlZb0Vic0luMlYxRGZtaEVsTFVNTXErMUZHR2Vjb3Q2WmM3Z25vcWVvdll2?=
 =?utf-8?Q?yO8ITO9RvbRMP7AtO0hT1AGRv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db7120f-429b-4ff3-cc45-08dd02133e57
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 05:39:43.3246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg30qhMzId5CyIerX0Jb01eRaV1vECwIB4Tyyx/08aSmmBBZxM2RcxtoLoAJCo40dM9wTCLaMQ8cpGJsbOJgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
Received-SPF: permerror client-ip=40.107.223.44;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.061, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Phil,

On 11/10/2024 4:36 PM, Phil Dennis-Jordan wrote:
> Hi,
> 
> This commit seems to be causing link errors, likely on all platforms
> where KVM is not available, but at minimum that's what I'm seeing when
> trying to build the staging branch on macOS.
> 
> ld: Undefined symbols:
>   _kvm_enable_x2apic, referenced from:
>       _amdvi_sysbus_realize in hw_i386_amd_iommu.c.o
> clang: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> 

Hmm,.

Thank you for reporting.

> On Mon, 4 Nov 2024 at 22:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> The XTSup mode enables x2APIC support for AMD IOMMU, which is needed
>> to support vcpu w/ APIC ID > 255.
>>
>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
>> Message-Id: <20240927172913.121477-6-santosh.shukla@amd.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  hw/i386/amd_iommu.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 38297376e7..13af7211e1 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -32,6 +32,7 @@
>>  #include "trace.h"
>>  #include "hw/i386/apic-msidef.h"
>>  #include "hw/qdev-properties.h"
>> +#include "kvm/kvm_i386.h"
>>
>>  /* used AMD-Vi MMIO registers */
>>  const char *amdvi_mmio_low[] = {
>> @@ -1651,6 +1652,16 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>      memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
>>                                          &s->mr_ir, 1);
>>
>> +    /* AMD IOMMU with x2APIC mode requires xtsup=on */
>> +    if (x86ms->apic_id_limit > 255 && !s->xtsup) {
>> +        error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>> +        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
>> +        exit(EXIT_FAILURE);
>> +    }
> 
> I suspect this last if() { … } block should be wrapped in an #ifdef
> CONFIG_KVM block? I don't know anything about this code though, so if
> this whole code path is generally a KVM-only feature, perhaps the KVM
> check should be implemented at the build system dependency level?
>

Could you please try below in your target system w/ clang and confirm back?

-----
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 13af7211e1..7081d448e4 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1657,9 +1657,12 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         error_report("AMD IOMMU with x2APIC confguration requires xtsup=on");
         exit(EXIT_FAILURE);
     }
-    if (s->xtsup && kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
-        error_report("AMD IOMMU xtsup=on requires support on the KVM side");
-        exit(EXIT_FAILURE);
+
+    if (s->xtsup) {
+           if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+               error_report("AMD IOMMU xtsup=on requires support on the KVM side");
+               exit(EXIT_FAILURE);
+           }
     }
 
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
-----

Thank you!
Santosh


