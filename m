Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCB0C021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 00:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlHC2-0003LN-95; Thu, 20 Feb 2025 19:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tlHC0-0003K0-Ic
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 19:47:00 -0500
Received: from mail-dm6nam12on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2417::625]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tlHBy-0004yq-PM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 19:47:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv4roXUPrMk4IDMXPoONVru9MzHgur1QyHuQKfV6NLCuBLye4ykNnUV1/mEd2XIJ4Uy8PjRw9hkB9oL4k9hNQ0WugqxHJFcJtEQkf/XuC2OubnoolsnTijUK/XWFZ8XKg5vVgMc7x9RSawCVY9aEngnO+exSOV50FsavqTtwAsFec/lm1tHAShtk9thg+tbmV6W9AU8kjnQfurk+oVBdUrMiEoArMGLBzb9d/AMvUB4sbVph4ANfMVqBR5UXskuhdiZtzEGMDlhaZEl88xQMGvD3N61Bt2TrdWcRtdK4WOVbDDV56+6cP8veow9xIs+hAEIGNc54CNCjn5j95Xx9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2wn/n+AL2fgpS9GVWJMebVh49pV1hA46vqacqGDBEA=;
 b=lTR6WMLUtwNiz0R2N2wl0dgdyj6Hd7D91/WRqFst8WE4MA/x6gcYq46cqzu5I7hLaJPwHZS8L4ldcTtGGmN2Zz3UbdqfetFDKQd8eP4RCJC9vY6vD0SQfxJsy3sSJj/35c31ncWg9BeTbdyZfqj2bzGQhqhy5m9GoKwDB/j1b7xIQAC7QRfpVA62lxCxm0X/U2yvxkms4iSQksUXGeAThj3/KwR9osLFO/RCM2gHZAs0ePSwCKfyM/ljeLCDt2bzsXL2ZWF7hyjESFnNiZA/NXYTKdOilJd3ymbVIF94HqZUFHB1k9dXydWq6HS545Rx2JsKiQLr5q0tfv/aPks1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2wn/n+AL2fgpS9GVWJMebVh49pV1hA46vqacqGDBEA=;
 b=Phq+fTti1rOlwAjdb5zxNv3JXgY4GA0dWWCsMpLCYJc9nrVSsZoZR9jY3jsX/LK05zHsexEzwUdMh/w4VEfBE7zoqvcKPuCVYv0Mq4uIiQqNUobRyGmzJI06GU4tbdxzhTDKsjzqPNU/1iPwZh64wH0AjTV+N/XEm7YK8KK5FSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 00:46:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 00:46:53 +0000
Message-ID: <a35f2d83-7d78-4f2a-97f5-c06c71c34715@amd.com>
Date: Thu, 20 Feb 2025 18:46:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] target/i386: Update EPYC-Genoa for Cache property, 
 perfmon-v2, RAS and SVM feature bits
To: Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
References: <cover.1738869208.git.babu.moger@amd.com>
 <ded4e65f9c9109f0863d1a00888b1ba48fab1549.1738869208.git.babu.moger@amd.com>
 <Z7cad1GabzGG1pAp@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Z7cad1GabzGG1pAp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:6e::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f3e486-2402-47ef-fa63-08dd52113bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTgxWFFPcmFhVGhIVHlLTStLQXY4RFppRTlUakRjRjFLWFNramx3YmxNdTNt?=
 =?utf-8?B?YlZnQ1lSZTl3ejhVaFhWWEMrd2txeEkrRm5xUm9QKzFaSzJPMVFOT2JCVnVU?=
 =?utf-8?B?V0hGTGs0dnoyMWJKemlPcC9xaEdXSmVWcjZlQ1RVMWVJckxuY1R6YXUzL2VI?=
 =?utf-8?B?Z3VMRnF0dGVDQjZheEd0K2NYVjE1c2lqUmkwOWNOSUdaRVJPMGVjNFdLTWR5?=
 =?utf-8?B?RitER2FybndSR3h4Nk1ZaEFHd0xOeUhpUzdRODFLZ01TNWE5MStGUStxbyts?=
 =?utf-8?B?d051czFkcTRJNGwvbDNQSGhWUVF3U2piZGFwaVVZVUlVdGNTUFZaQ0t1ZkEw?=
 =?utf-8?B?aEQ1eVVqQ2d3TkhzVGdudWNRODN5aUxYK2Y3OUcxS2tPenZWNkRHOFRWd3g4?=
 =?utf-8?B?QlVwNkM0NS9xTi9HblkvSGljUFFTcHY0bSt5M0EyV1V2YWNwTnRWaVhzZXRm?=
 =?utf-8?B?Mm52Qnl6dmpiRkFJRzliNk1TTmt2TFRMMjN2YStLM2dSQk5MSWg3R200Y0Uw?=
 =?utf-8?B?OXNZMHF1czVuK2paSW9zNmV4WGxxZytNbDN0MUdlcE5iQW96RDBRUmdsSy9Y?=
 =?utf-8?B?YmJQRnlXRDZnYlBFbG1RcE1LclY2RnNPbU5JOEJKR21WWTFFV1FMNlJmNXZK?=
 =?utf-8?B?ODBVaWtlakZmcFhWR28rUHlmdVE0YXB6RlE0K3RzMFh5dlZMNmxLK3RNYmFO?=
 =?utf-8?B?am5PdlZ5akxMY1lqYkFQRnFGZjN2MnNYbFFmZXBDR1BHSWQrdTd2clgvQW0w?=
 =?utf-8?B?M1hWSjc0eit5SHZnQ0UvZ3k4K0FMeGdtTERadDVFbTlBME1pcWZhKy9QbFYy?=
 =?utf-8?B?OVErMlBRUS9ERWhSR0I4RFZ2MXlkVlJqMEZ2OGJGb01Sd3grL29zTDYxNi9z?=
 =?utf-8?B?VVRkcDZNaTFZeDhUQkxaSVVMczY3eE02N2pjV0NnQ1M2UkhxUlhJaHA4M3dH?=
 =?utf-8?B?a2gzbHFmak5QN1ZOSDhGdEJ6VFVsOGFCTXpWOEFjQWg4ejBvLzVnVEhQY1Jp?=
 =?utf-8?B?bUNrZGV5Wm9BcFJxYUZ2enVXaFRjZS9aaDd0VUMyN2dhS1g5aUVZQXc5aTdy?=
 =?utf-8?B?dUFmY1FHVFI1M3ZzamVoWE40WnVGbXBDUG1DN05DdWw1SmhFWW9zNEdCWVJl?=
 =?utf-8?B?V2U0MHQ1WlM4d1FrVXNKYW1aU3ZlYnRoNmZVTXMxM2ExT3FIejJWOThvUnVv?=
 =?utf-8?B?bjlZZnhhVHkxczRxdGJhVXA2bVlmM3dJTDA2WVNVeDFEeWNsTEM4M21TVWRL?=
 =?utf-8?B?MWE5OFJPN2lRVHRnY0JYTGtpaUcvYkdHOXZIZG12RkNYVDhBVkNoREpLUEh0?=
 =?utf-8?B?a0JOd0tlakRCRk5WQ2lrRjU2d2ljRlhTUkM4NThMc0pBT00rTmhlenV1ZVIv?=
 =?utf-8?B?VlJGNTJQVGQrRW5Bc1hVenpHMit4aFlWYnpPZGhyeG1KamJ2MWMyYk45RDFs?=
 =?utf-8?B?YjhId0s0Slh3blFmTFo2b1ZTeGREbUhTNGJ4S1J1NXp1QkljT2pKMnNTVzh5?=
 =?utf-8?B?U2x2anQrNjZxUERubG0zVEt0NnBLV0JidlY5OUxNMDhOakhHOG9KV2UyVWxl?=
 =?utf-8?B?VUIxZ3BQV0FzV1hSc2lSbmZrdk5VU3p6Ym9aNlgwQVhHUGhOSlV3TjBRQWVE?=
 =?utf-8?B?eTRwOU1tS1ZKZkVLVWN4RmRqcFZqL0RVajZMZW1jZWJnK1FvRHFyUWQ2M0ZN?=
 =?utf-8?B?VVNITExuS09heWpxa1IxVG05N2kvZG1TYWxJbkJnM1J1Y3VMNDQvMk1FTTlx?=
 =?utf-8?B?WjF5VTA5QXAxZkJnTnRiMzc5ZnRIcUlNMklTQ0orR3hSek1yTFlnL0VWOCs3?=
 =?utf-8?B?anhOaDMwQUdzMWNpamcrSFpRam1MdEM5Y3JWekpnckxaTEFaSlE2T2ZLWDdJ?=
 =?utf-8?Q?JmAO3vjmA6jj3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlVdzFYZkUva1A0amxLV3U5YkFDK3VLYTRzSnFZQXQrZnU2dDNzZ0dNaFAv?=
 =?utf-8?B?dWlJMUdHTVFZa3ZmUWhRR0Nvb1NNd1hTV0lUektRSjlUNkk4S2QyZGkyVnZN?=
 =?utf-8?B?SnJjWGpFSkdlS1gySEt1ckJMenhGKzNoajN3Tnh3M1pNNDd3bWVXS3QyWHc1?=
 =?utf-8?B?czFNVWtKbGNCMWxrRW9XUk5jWEN5Y2RwVXVUQmlxS0RBR0tSNzEyWW9NcW8z?=
 =?utf-8?B?WTMzT2EyaXp3d09QS0tpWnZZdDlPZ2FJQmpaNkc1SmtZU0ZVR1JXM0I0WjRF?=
 =?utf-8?B?UDJRU3F6SlNFVzFSRGowTE92K3RsL25keGNOSzZ1c0pJQ0huc0lUQ0c5TUN3?=
 =?utf-8?B?RG1iRmdhUjA4YkdFVldpRnZTazB0NlpJL3E0V3JCTHJQbmlpTXN2aWFxYzgv?=
 =?utf-8?B?R3JwalZza0pBTW9yelVUUnF2bXJlZXlzWEFTUDE1RUt1dTRJZUg0NUEvQmZa?=
 =?utf-8?B?L2NRcUxZRDJ2TjRZUFdubFZCQTlacTNvNk9XcUZxeUdCNXJ2WHhEZG94QThF?=
 =?utf-8?B?MHpsN0V2WFFJR1ArVXNoeXRvTThUOGRkZG5qNjBQYW9JazJ3S3FONi9IdW14?=
 =?utf-8?B?RWFEOE91Q3dNRVMxZ2p4Um01Qkx3RkxKcDEzbW02QXRpbnUydVFwM3RPVlVt?=
 =?utf-8?B?YmtkS2JuUC95M09nS005SDFjK3djNzJPVFZCUEo1MkhkMkdMaHZNbjJuNHFP?=
 =?utf-8?B?bFpDTGR0ei9sQ3BTRmVmMk8xSUFIYm5kOVFzdjE5dWZUOG1qVXF0aklmeEVi?=
 =?utf-8?B?OUR0WEdzMUNKbkFQbllqeDRubjd0cmdYaDZRN2dod3JxeHVDcTl2RDBneGsy?=
 =?utf-8?B?YzJXUEpDeUpRMk9uUHRsTk1BQkxFaTA0VE9CNDB3VEV1TnJFVjQvNm00ejQ0?=
 =?utf-8?B?V0tPbzZpUUZXd2htK3lNNERFMW12K1ZkVWowNDhzbWdneE1SNDZXcGY0TTk5?=
 =?utf-8?B?OXdkUmM0bVJiajF5QmdJWHAxcUs2Q2R4WjcvRjZRRCswY0dabDc3bDFPbEJZ?=
 =?utf-8?B?Z2ZZOVM1Z3lIdzZZQXlzeGxBQ1ZPOWMxc2lSRFRrTnNIRG9sZWpxbEdvdjdJ?=
 =?utf-8?B?YjcxYkhUcmg5WlFmdzNQVDk2QWs2MENZYXU1QjlUbHVML3I5WmdUZU5xNmIz?=
 =?utf-8?B?c0VEbjhxSDZkQjQ2MUFoSFN3QjhaRml5SUxKS2hpM2lzSnFhYWZyZG1PTFF5?=
 =?utf-8?B?UnlzNUtjTk5hQThnbXRXNnZyZ2h6L3ZEQlVjQnh5aSthcndKRjRLck5VSG81?=
 =?utf-8?B?YkZpSzZ0VEVvbExYZkhYMTZQdFU1UTN0RDlma1Mrb3NCRmE1QjhYKzlreFRV?=
 =?utf-8?B?Qit3dDJ1c21IVWJ4anVnK0NiT2RzMU1jZXVqUTZxeGJibDFqbTVPa00wZGpm?=
 =?utf-8?B?RUQxS04wSzBzMXlIN1RJN2FaNklXMVZsMkZXc3Z6WXU0YUxsVWh0WHBtMDVX?=
 =?utf-8?B?SURtbGxSenZGNzFwdzlacEJTbTNGblp0WkFyQTd0ZW1panRDQ0M1M3FidXgw?=
 =?utf-8?B?Mjh6Q0prck1pZkFWam00MFhTRHFCQ0xZUENrSG5GVXZJUHdsRit5WVF6emNr?=
 =?utf-8?B?T1N6a2tZYWNYdjhaM0QxK0hERDhobkFaaWlYaUkxNzZUWnRzNnBDandYYVJt?=
 =?utf-8?B?OTg1eTEwWWwzUGdYMnBnRFlJODJ1ZmVGa1UyNHYyMk5wUmRYVHZWaVI1ZERH?=
 =?utf-8?B?dmlPT3U0cit3OVFWMURwalVJV1BxSTFncDRKUGM3T1llRnh1R1ZQTGtCdis1?=
 =?utf-8?B?SUtrMjlRd0V0THY2cy9Pb2NxbzNQK1NkMHlXWmtuVlFrTE8vS0d4Y2NWSlVU?=
 =?utf-8?B?MDZIdlYrKy9WaGdEdzdsdS96WnlOYS9mMVE1bFVUcEZoYno4eXhvZno5UTNF?=
 =?utf-8?B?RENMTWo4bTJVSEpOOVBCbjlOS0lIcHNmbFFMOG5HbENCY1VPdTc1ZXErcFVN?=
 =?utf-8?B?bWdIaGpmb2R3SlJORE5Ca1IzUU82eXY5WXRPbTFoZ04rL2x1a2VpQzNhYlRh?=
 =?utf-8?B?ZFJoUFN4UVl0bUx4bUFpTS9MU3loVGNTUlJ2dWhJNkRKaVJRZ3BoYkJ1bEFF?=
 =?utf-8?B?cml5WHNjOGRycWhUOUxmSXdMa1pvSXZkbmJGMmNIdXozSFhmamgvVGsvUWhp?=
 =?utf-8?Q?Rc50uVyfKrhsO9QBHwGt4F0dH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f3e486-2402-47ef-fa63-08dd52113bef
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 00:46:53.1483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZY1ZXXqzL8C4UR3e2LCWxWgVMwpajT12LKffssTUwN15BQH1xGP+H/qJpz447qZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612
Received-SPF: permerror client-ip=2a01:111:f403:2417::625;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Zhao,

On 2/20/2025 6:05 AM, Zhao Liu wrote:
>> +static const CPUCaches epyc_genoa_v2_cache_info = {
>> +    .l1d_cache = &(CPUCacheInfo) {
>> +        .type = DATA_CACHE,
>> +        .level = 1,
>> +        .size = 32 * KiB,
>> +        .line_size = 64,
>> +        .associativity = 8,
>> +        .partitions = 1,
>> +        .sets = 64,
>> +        .lines_per_tag = 1,
>> +        .self_init = 1,
> 
> true.

Sure.

> 
>> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
>> +    },
>> +    .l1i_cache = &(CPUCacheInfo) {
>> +        .type = INSTRUCTION_CACHE,
>> +        .level = 1,
>> +        .size = 32 * KiB,
>> +        .line_size = 64,
>> +        .associativity = 8,
>> +        .partitions = 1,
>> +        .sets = 64,
>> +        .lines_per_tag = 1,
>> +        .self_init = 1,
> 
> true.

Sure.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 

Thanks
Babu

