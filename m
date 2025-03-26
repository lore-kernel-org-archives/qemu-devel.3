Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C52C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWJy-0006bC-NI; Wed, 26 Mar 2025 15:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txWJx-0006av-4Q
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:21:49 -0400
Received: from mail-co1nam11on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2416::629]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1txWJt-0002bH-PB
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 15:21:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4U01tJdvOLLL3eQgxeBGKh1GeIW7d6V/nPPPWp97nc9nXVUSS5/YDmL92I/BE0zLCCVckTRzSP70HAzISH3GV346BHcogLW6AMqvX182+n1NnKjlx/XjiA29DEeAOgfJpq/BSKL88DtZfdVAmNHaNgcFRo3iaEAfa14/Qdxe5+N7D1jN+2za8Ue1hqRKqpSpYbuHONhjU9JfGuMq6SyTTnmAATyt3kHCQgdIfI9dgSFbsMNEv4HNC9F8JpdMcYw9oH6fvQ7zkiRyHouXEbWvDpehC33cH8Mo2OHR5bAfMjzTp7QkI5caZtMga5f73948YDbgswA0dbMMz4bwfEyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBmPcL3llee/uIq0iS8kXNjzGEObcoZos35f/jqXzbI=;
 b=lr9FFiA7L3evJ43e3+Vd3z2bTVG4ChihCJMZrDlmqxAxH8j+uLkfyYlV6osnNGx25NjcY4OR1RQ7j78rk4zFxeLVzO5q9bfHVeqWkvt4ZN9G4ZDF+TssBpYACWFjOuHiOydYY0axtRE4D2rNVOSHjJSfsvBfa88slKnNXkkvbv3dVP9QIKW6i6tLJ0rAdxFyjg0cnJhdYLm7/a7djJfUhWtCPbg7libMOwa0s2FWZH4Ra2MxuILu0mNEMBVVQuJyDUCsYuf5wcItKgmdQwFQU1ThNB1x/R15vVN7d322OwtVbq89msDNVs5ZYdEUKO/MYFdMGxAgQayDESmOpzifDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBmPcL3llee/uIq0iS8kXNjzGEObcoZos35f/jqXzbI=;
 b=H+6Wtw9zOVLlW/opQcEwe92T369Izn/uLj9otgCRGVkzdYOmgWbffF3Xlhhg7RTlTnFrDUHdpBQiWW10bTpk8BwcAjTId+uiXqlYmTAAS8chKMKkxL5Mq7GhRwbfNfndP11SddmpZAyyLgFce1AtvZLQqqoTBHpqiftkRiZ6DG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:21:35 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 19:21:35 +0000
Message-ID: <9576dc01-e26c-1fc4-6534-ac79c71331b5@amd.com>
Date: Wed, 26 Mar 2025 14:21:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 2/8] migration: ram block cpr blockers
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 David Hildenbrand <david@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-3-farosas@suse.de>
 <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
In-Reply-To: <829e27d6-eb6b-8a26-e982-0ba936888c6a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:806:121::10) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b6d8c6-f09c-4d21-be42-08dd6c9b6c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0dZRi9MeEpGenB4ZVNnR0w4L1BKcDZaTGxsNGZuSy9mTTZBRWJNMldMQmJR?=
 =?utf-8?B?bTdzclM5eGxSOFJsbWljb09DYUc1VUROS2lCMWd4TFRmdFZrRkJMSnRweU9q?=
 =?utf-8?B?bXlJeDNiSlA3QmVocVFXUFNnWGx3dU1JSGRKdzJYM3E1YkFLeHdIUkJ6bXlR?=
 =?utf-8?B?UVA2OFhpd1VFT2xXWXJ6M2RmMEJGdWlPY2RjZzYvR3Fza1lUOERaRFljaHN6?=
 =?utf-8?B?YVNPejNRR1VySEo0YmdTZVpUbk1PUmJMNjNCdmp2cnI3QVk3a3dwclFEeG56?=
 =?utf-8?B?V3BheG5OZWZKUkN5RjZZMnBMVDZ0NlFuQ242VzVvVjFncUdTcXZYN1lmM0tR?=
 =?utf-8?B?ZTI5UHJ0MjQrZzhRMk5OaVVzZ2RYZHhteTlBVmFPOStDaFpLZ2NHYWdDalli?=
 =?utf-8?B?eWpycGtsOWo2SEkwS2dveXgrWGVTTXZqQnIvRm41MXVoZEpEdGJmSEFUR3cz?=
 =?utf-8?B?ODRxbE9OUHVOaVRKODl6RUMrTEFEVHdKSTFXOElIWHpDKzFCMWJROUNXUXZD?=
 =?utf-8?B?ZHAzMGY5d204U0NVYXJ5eXhrempQODcvclVVeG0ydDFXTkQ2YmNLaFczRnN2?=
 =?utf-8?B?R082RDRvSXNRcmJkQzRrU2hhUGFlcUNTM3lSUFdiNU5OeDRZUXlNdnErRHV3?=
 =?utf-8?B?c1dYOVFBWUptbWREa2RmVXJrN28wYmYvWUs2UjlwUStsYTRPbUxwakZGa3Vm?=
 =?utf-8?B?L2ZJeFVZVUh2M2hJSmNoWnJEdXo2OHVoYjkxT0MxeW1ONlVOem9ETE0rdy83?=
 =?utf-8?B?WUpaRkFWbGlwK1F4bWMvMGZuL2dLM0k3VHNyRkJEbWpEbm5xL3JOS0ZVc1Zu?=
 =?utf-8?B?Vk1oakxBdlNJNVVJSXNrOUg5aGtodXNSc0ZsY0VmRUJFWE1MelovUGlialZD?=
 =?utf-8?B?R2tEZDU2ZHB5Y3JTQ2hIRHBPUWdyMGMvMDk1TVk2anY5VHlrL2p2STQwSk54?=
 =?utf-8?B?SzZkTnRUS01Zd296N0V4Wk5qbFVqUW5OdWhaU21OYldVcFRURnpNL1A1WGp6?=
 =?utf-8?B?ajdFUExCaDVydFcrQ3htV3BMbThEdS92cE1oQzQzb3p0OS9TdVdSK0dWTFJ0?=
 =?utf-8?B?MC9NQzA4cWpLME91UlJXUTdlREo1azhKalkxVUVlckZEdndPTXdIREh2dWF0?=
 =?utf-8?B?SzZlUXJNSCtaM1hVempqazVlQmEyQ2RuNUd5amtkT0pMZ0NmOFJaTHNFSUV6?=
 =?utf-8?B?bm9mdWh1UDYxMGIyQUUyZERZWnNJNXpiTVUvQWxXaWQvY1JpUklzQXV4dGd0?=
 =?utf-8?B?UTRzUlN4TVhJaDRYV0ZyelFhNzhmTDJGaUZlM214ZExWN1RXczhBOFJQdWhp?=
 =?utf-8?B?SWFiSUFXaUw0cUZBMEF0TXN0dmIyOFl2MmRYdkNXQjNwVXZiNmVRaThBNm5l?=
 =?utf-8?B?UjMybUpVUmozQ015TlhzeWpQTkpVZDNobzk1U2k4a1ZlejFFYzFaR0VsWnQ1?=
 =?utf-8?B?Nm9nWWdNdmtBem5meWtLVTI0TVVTUzlkQ3hRTFFUYlZPOVMzVDQ2QkFYc1pT?=
 =?utf-8?B?c1U0S0s4Z0UvcXJ6NlEvZlBQRzZTdmNBY1VsZDYycGFDbm5oTThJSS9JRnhl?=
 =?utf-8?B?Z2ZYZnFPNTRMUlhmc2NKWFpUVTNtenl0aS8xNHdnOHNyeXUweVFrVUM0b3JN?=
 =?utf-8?B?dzdyMGh0Y3ZmeWJUQlVLempGQ3lXbmNIdmN2SjVkRHhDWkszRmk3NDhzR2xx?=
 =?utf-8?B?YUphbWRnVURTSXJIZXVVaUt3bDRkMXFpTzNDbGNvUVVrRi9yeXhYVDBmU1Bs?=
 =?utf-8?B?ZXJKYXZZVVVPY2FMTENKYmtxRXFKcjk1UUl6V2xnOTUyaGUycEg3ajZ5MDZo?=
 =?utf-8?B?RVFLREFWSkE3NkhmR211NEIwUWdNNXI2WEJ3aTdMbDVyaGtNaEhueEpCQUlT?=
 =?utf-8?Q?P3qPX0zzQe6Sg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNXandlVzBUZkpHWUZMckx0cnlLVkE4VTZGUEZLQTVGV2dLZktyWUtiTDNi?=
 =?utf-8?B?SVp5TFlMaUVYc2ZlUzRnWjBwQlYyamR4V2tkbGoxSGFCZVBkRjFBMjB5OVFt?=
 =?utf-8?B?TWNXTTJrVGg4T1Y1NzZTZ251MXd6WUhZd3NwRzVLOE54UG9pOFg1S0xmS1Fn?=
 =?utf-8?B?T0hvcGE1MzhWMzBKS3MyU1VCanoyQjh5cnF3ZzlXWkIwRGR1dHRWcU9kazBL?=
 =?utf-8?B?NXc0bVhMd24wNmlRQ1A4YmpsaFFrZFJ4b2dET0c0cmtRSUdMcVFwSDFOQlIr?=
 =?utf-8?B?dHYvVExNU1I5cmlvdEIwSkllS21nZi9iQ2FKVkkyY2tTUVFQTkVQMkhEYWZ5?=
 =?utf-8?B?eGF2ODN0cVJacE1TQTlzNmtEaG5XZ0dXVnNGbnhyMVlsWDR1cEJlVUpYUWd4?=
 =?utf-8?B?L1VWVzFWSXpPWDcxcm91QVNnNitQbC9uSmMzVWJGdEdMeXg1VTBrQUhzQ3pG?=
 =?utf-8?B?YXcvb3VPNzRVYWp5ODBZNEJjQ1BYaUM1ZmFTVnN0amk0ODF3VHZTNDlJcTJu?=
 =?utf-8?B?aEkzcG1MQWhNRXJFY3RUTFdBWndVdHJUTXNJTDM5eDZ3cWdNQnA3ZlEvVEts?=
 =?utf-8?B?aXFQeERQaW8wM3FqTGNZNXV6TXhqaVFOeTNRdHo4K1lFZUFselBibFk4MWZ0?=
 =?utf-8?B?MWZlcSsweDZxcGhHRHVUM2dTb1FCRlpSamdSeWR4czlkWXRaMSs2ZFpNNXFy?=
 =?utf-8?B?VUdlYjZsWld6THVmeWdvc0Q3cWxLSGZyNDA1bjhQZWR1SnZQRWZlNlZ6VWtE?=
 =?utf-8?B?S2w2bVIvVXMyZWlROTRueG5XMkpnaXRWSzIrMCsvcm1kWGoxN3ZOcDZDSVRR?=
 =?utf-8?B?UDRoUWlJVEYxQmV3RGY3RGlwZmVTZGp0TXFJTFBxeDNUOVVJeG1FZWJDMDRD?=
 =?utf-8?B?U3dRT1RCeGpVUUpaZVBKRGIxZG50Z2J3MGVTajFQRUtKeVRwOGdIWjFucndZ?=
 =?utf-8?B?V3lRYk1zREU3R2RBdnNTZnZSWUQ4Q3Mybmt2ejNERmRTa3I1dDhVWXVXN1lq?=
 =?utf-8?B?eUtRVXR5QVZxRnZnNEs4cU1QWkw2Z0JFSzYyaHJySEFyZGxWZ3BzUkFxNDB4?=
 =?utf-8?B?WVAvNUw5TzVHcDFTMHNmdFpwT1I1eVBROFlRT1dnUnFsUHI4ai9FQWdGaFg4?=
 =?utf-8?B?SDRkbjA1YWNzQ1BCRU5jekYwVitqaDQ2aHJwNHowRXVsc3R1eldIblRRSFh2?=
 =?utf-8?B?UmdEbUF6SnViN1kwMEs5ZWkzY3hZb2o5SlFMbmZiaFE5TEpNRUdKaE9zdzhK?=
 =?utf-8?B?SzdKR0l2SW9rVXFKSGNVaWNxUGRvQm54cmwvQ3JISzRhbCtOOUI2bWJMSC9O?=
 =?utf-8?B?Q0lwa1pEWVN6dm1DbDdNenIzRFhiZVY3TDZlYlNQbG4zdGJCdi9zUGN1SXc3?=
 =?utf-8?B?T2RuR2M4cmtTQU9XYjBLNlZRc1VwTDFEMXJ0MldRN2E3bGF3Nm93UnZQSko1?=
 =?utf-8?B?cXdDSUZWem9OcmdWOUlFaVM3eDZMaWtjSzlSNm9mbVJmMmcxb24wQ0lob3JS?=
 =?utf-8?B?UlYyNHhKbm5JWElxeWxBUHQ4YW1XQkNuQzVQMTNaRDU5WjBkWGNmdnRCMHFD?=
 =?utf-8?B?KzdOa2Z0Rnc5eWczREV3ZFlhR0NBMHRPcUFlb3UweE9RTWJYK3llSWhiV1NG?=
 =?utf-8?B?OUxqN0tPK3ZPeHA4bTluVVpDVFdodU1QZVRRcTl3eGdaNTNHTG9ScWFQcDlP?=
 =?utf-8?B?OVhoUU8wTHVmNEZjdEoxVnlrOEJ6cDJMT2pKQzN2ZlVDNlJKaFMrKzRLZldj?=
 =?utf-8?B?Y3VuRFBzaS9TYnc5RzRZTTJKR0l4dnhJS1NTMEtIRlJUYTdoRmUrWk1hSzVy?=
 =?utf-8?B?T0dKeThjV3EvbGszUjBacEYyMzBaTFFmRURrN05tQzkyakc4citPeGhoMnNl?=
 =?utf-8?B?KythN200SEJvSERKNHNoSzg2ZlpTQXZqMllBNnBnQmNxeTFsKzkvYmtTZjg3?=
 =?utf-8?B?NDZrdmJrRi94M0E5Wm9QZVVYNGtRWnBSN2N1VnVnc0orRmhCN3BHL3VveEF2?=
 =?utf-8?B?Qm9uL0N0TVBHZk1zT1VCRmo0Y1dWYzlreHBPdHRaMGE3d0tWbXM2eUR6UXgz?=
 =?utf-8?B?M2t1QU5YWTVLVDdtSXBpT2pEazJCMm52YzVYT0pTZk1sZkY1VHpqN1UvVGsz?=
 =?utf-8?Q?sPJgDisZ5b3p4GRvKSH9UTpB8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6d8c6-f09c-4d21-be42-08dd6c9b6c3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:21:34.9415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBK0ZUq4Q+CiiUa9vF2Dd6/5EnKEwImThtYAE4XPPGkq1FRN+Zg/RUlmM0G+JTPowCMKdFhbusGsaOxPGv/cIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
Received-SPF: permerror client-ip=2a01:111:f403:2416::629;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.624, SPF_HELO_PASS=-0.001,
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

On 3/26/25 13:46, Tom Lendacky wrote:
> On 3/7/25 12:15, Fabiano Rosas wrote:
>> From: Steve Sistare <steven.sistare@oracle.com>
>>
>> Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
>> in the migration stream file and recreate them later, because the physical
>> memory for the blocks is pinned and registered for vfio.  Add a blocker
>> for volatile ram blocks.
>>
>> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
>> sufficient for CPR, but it has not been tested yet.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Message-ID: <1740667681-257312-1-git-send-email-steven.sistare@oracle.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/exec/memory.h   |  3 ++
>>  include/exec/ramblock.h |  1 +
>>  migration/savevm.c      |  2 ++
>>  system/physmem.c        | 66 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 72 insertions(+)
> 
> This patch breaks booting an SNP guest as it triggers the following
> assert:
> 
> qemu-system-x86_64: ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.
> 
> I tracked it to the err_setg() call in ram_block_add_cpr_blocker().
> It looks like the error message is unable to be printed because
> rb->cpr_blocker is NULL.
> 
> Adding aux-ram-share=on to the -machine object gets me past the error and
> therefore the assertion, but isn't that an incompatible change to how an
> SNP guest has to be started?

If I update the err_setg() call to use the errp parameter that is passed
into ram_block_add_cpr_blocker(), I get the following message and then
the guest launch terminates:

qemu-system-x86_64: Memory region pc.bios is not compatible with CPR.
share=on is required for memory-backend objects, and aux-ram-share=on is
required.

The qemu parameters I used prior to this patch that allowed an SNP guest
to launch were:

-machine type=q35,confidential-guest-support=sev0,memory-backend=ram1
-object memory-backend-memfd,id=ram1,size=16G,share=true,prealloc=false

With these parameters after this patch, the launch fails.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 78c4e0aec8..d09af58c97 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -3203,6 +3203,9 @@ bool ram_block_discard_is_disabled(void);
>>   */
>>  bool ram_block_discard_is_required(void);
>>  
>> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
>> +void ram_block_del_cpr_blocker(RAMBlock *rb);
>> +
>>  #endif
>>  
>>  #endif
>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>> index 0babd105c0..64484cd821 100644
>> --- a/include/exec/ramblock.h
>> +++ b/include/exec/ramblock.h
>> @@ -39,6 +39,7 @@ struct RAMBlock {
>>      /* RCU-enabled, writes protected by the ramlist lock */
>>      QLIST_ENTRY(RAMBlock) next;
>>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
>> +    Error *cpr_blocker;
>>      int fd;
>>      uint64_t fd_offset;
>>      int guest_memfd;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 5c4fdfd95e..ce158c3512 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3514,12 +3514,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
>>      qemu_ram_set_idstr(mr->ram_block,
>>                         memory_region_name(mr), dev);
>>      qemu_ram_set_migratable(mr->ram_block);
>> +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
>>  }
>>  
>>  void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
>>  {
>>      qemu_ram_unset_idstr(mr->ram_block);
>>      qemu_ram_unset_migratable(mr->ram_block);
>> +    ram_block_del_cpr_blocker(mr->ram_block);
>>  }
>>  
>>  void vmstate_register_ram_global(MemoryRegion *mr)
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 8c1736f84e..445981a1b4 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -70,7 +70,10 @@
>>  
>>  #include "qemu/pmem.h"
>>  
>> +#include "qapi/qapi-types-migration.h"
>> +#include "migration/blocker.h"
>>  #include "migration/cpr.h"
>> +#include "migration/options.h"
>>  #include "migration/vmstate.h"
>>  
>>  #include "qemu/range.h"
>> @@ -1903,6 +1906,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>              qemu_mutex_unlock_ramlist();
>>              goto out_free;
>>          }
>> +
>> +        error_setg(&new_block->cpr_blocker,
>> +                   "Memory region %s uses guest_memfd, "
>> +                   "which is not supported with CPR.",
>> +                   memory_region_name(new_block->mr));
>> +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
>> +                                  MIG_MODE_CPR_TRANSFER,
>> +                                  -1);
>>      }
>>  
>>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
>> @@ -4094,3 +4105,58 @@ bool ram_block_discard_is_required(void)
>>      return qatomic_read(&ram_block_discard_required_cnt) ||
>>             qatomic_read(&ram_block_coordinated_discard_required_cnt);
>>  }
>> +
>> +/*
>> + * Return true if ram is compatible with CPR.  Do not exclude rom,
>> + * because the rom file could change in new QEMU.
>> + */
>> +static bool ram_is_cpr_compatible(RAMBlock *rb)
>> +{
>> +    MemoryRegion *mr = rb->mr;
>> +
>> +    if (!mr || !memory_region_is_ram(mr)) {
>> +        return true;
>> +    }
>> +
>> +    /* Ram device is remapped in new QEMU */
>> +    if (memory_region_is_ram_device(mr)) {
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * A file descriptor is passed to new QEMU and remapped, or its backing
>> +     * file is reopened and mapped.  It must be shared to avoid COW.
>> +     */
>> +    if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +/*
>> + * Add a blocker for each volatile ram block.  This function should only be
>> + * called after we know that the block is migratable.  Non-migratable blocks
>> + * are either re-created in new QEMU, or are handled specially, or are covered
>> + * by a device-level CPR blocker.
>> + */
>> +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp)
>> +{
>> +    assert(qemu_ram_is_migratable(rb));
>> +
>> +    if (ram_is_cpr_compatible(rb)) {
>> +        return;
>> +    }
>> +
>> +    error_setg(&rb->cpr_blocker,
>> +               "Memory region %s is not compatible with CPR. share=on is "
>> +               "required for memory-backend objects, and aux-ram-share=on is "
>> +               "required.", memory_region_name(rb->mr));
>> +    migrate_add_blocker_modes(&rb->cpr_blocker, errp, MIG_MODE_CPR_TRANSFER,
>> +                              -1);
>> +}
>> +
>> +void ram_block_del_cpr_blocker(RAMBlock *rb)
>> +{
>> +    migrate_del_blocker(&rb->cpr_blocker);
>> +}

