Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250F2C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlCW-0005cE-6u; Thu, 13 Jun 2024 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHlCT-0005bU-2x
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:13:13 -0400
Received: from mail-bn1nam02on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2407::62f]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHlCQ-0002I4-ER
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te6AvBAusKOiel/QxOhguqgKOViUmCX0+KEj4tYD/VMJeL9Qh277S5crdy/+/br80CF7+/w9Km+BaNQaLu0kQSazCgPtaDw+IiosbUX7la2LRY9nhqCXp6llgzGmcHm13H4mk+25mGUyedw5vJaPGqhiFda6xQfkDxkhw1siVlWmP0R2TnNGAlq9Tn3fnYJdmWev93cm43Mj+VCqQCfvlxUVd5e9878eKxGWV+IL6k9+oY61EBcXN8jUhIIkzD8A8GaNGyqfSqz4IDQTwdU2gijhwskl7dzED9ZSp4mFzOzY25gqumG25aGW6kk9mXYxYXUQcmvljRX0N4NKtRmFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBtWuwEznLVZOIJUkUmOP5vSykrxbX+0gGHSj3NoNS0=;
 b=fGxlQGjpwvCqu3JGP0oJPv6lunsEZs1GZeQxKzJ747bHnW8Tp5wYdCX7D7exyToBFrYA9gNurPmVuRnsOpmOskXsN8D2zovvFZ22MGb68xIuf7HyOP2x+Mo44KtYakAtrtC+wPAilaIyOW2kD0EvaIhq/siYMjmyN3bUyV7iSLDpHtoA+CPxCfr8hnOrwScEaBQSveg1wFweFkl3zukIjG97D8HVoN9rQ9Rs6xskTCo1QcUiRxjBhhaTWvbOu83BaqRs1MI1M4WOChtwlduHmgkTwvOsfxf7yPWmt8B/nJXm6NlTwgfiZI0Qq+Hs2qnP6OA0t6NQudszVc4Tk1A31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBtWuwEznLVZOIJUkUmOP5vSykrxbX+0gGHSj3NoNS0=;
 b=zMjXbttQm6bRXzI3vY6NWJYD6HUIP4uXrvXzAClAHJ2vtkhM0yljjH6N2ubiivHUhyGOvu+4p8YvqpBDSlNyi3EajmJ2JpjxJjdjIFq8Pfuz7fR9fiPZogcEWq2Ylme60852PwX0GkkZuSMLfgMbYrf28aCXIyPGc0KkQZv1Pew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 14:13:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 14:13:05 +0000
Message-ID: <e28c9874-8c23-4b6f-9ef0-13d46a72b603@amd.com>
Date: Thu, 13 Jun 2024 09:13:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] i386/cpu: Enable perfmon-v2 and RAS feature bits on
 EPYC-Genoa
To: Zhao Liu <zhao1.liu@intel.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <cover.1718218999.git.babu.moger@amd.com>
 <1dc29da3f04b4639a3f0b36d0e97d391da9802a0.1718218999.git.babu.moger@amd.com>
 <ZmqbtLToD1ac7VO+@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZmqbtLToD1ac7VO+@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c220c6-ed98-4d5f-4aad-08dc8bb2f14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0kvdWo1OVJKc2o1TUZJdXFvUFpkbGk5QlN4eEh1cENaY1JLeks3N09kdUdD?=
 =?utf-8?B?ZFBQQ0Z0VkprTndZcks1eG5HVFAwbHZWS1YvbmxzRE05cm9Ra2d4T1dXNndK?=
 =?utf-8?B?YW01OEN4QXBCNVArV2dVL281am1WQ1hBMWZzRlNOd25VZTgwNUk2T2QrVVp3?=
 =?utf-8?B?ZnhWbmc0QTFIRi9MdDlCK3F4T3l4b2pLU0xCSncyNjBudVBoYVhZVjQxSHdz?=
 =?utf-8?B?NUZFenlMUXpKN2M2emdpYjBkeVRwaTJveWxsandvQ1M5Yk9XQkpWejIwSTND?=
 =?utf-8?B?eWlqZytXY3AxMUNCUFU0WG5MVHNwbUlTUjFDeEV5VkxkaXBscWlBVWxUNTN4?=
 =?utf-8?B?MDh0UHFqek52RjFpc3V3QVY3YmF3SVJwZnN3dUhaSmQ3bmVDOFFtZ3drNlNH?=
 =?utf-8?B?MnlVY3E2ZzV1aVZUZnVHbEVMd2tBcndxWUdVQkdpYUNmUjVTaXUvczQyVm1I?=
 =?utf-8?B?ajltRjF5dFNUcXVJSXFBMWV0K3RrL0UrSzR2anFuWXFKakwrTG9vd1JFRTd2?=
 =?utf-8?B?c2g2R0FoVTBxMFRJMTNycStkSDJOb2ViUm9WeW9xUkV1YU82VUQyL3NRRjdY?=
 =?utf-8?B?WWpLdEdrQkZhZXI3eDREQzZBeTk4T1htakRWVE82VytsNFVCell6SzgvSDhx?=
 =?utf-8?B?eFhUOEl0WGlIMzVCK2duY0ZJZExEeWZTYkpZTS9wTzZncXpNQWt2QzRCRmZF?=
 =?utf-8?B?dzY2YkN3WG04T1R6QXRFNUsxci9kM21UYnViOFVQaWdXSFIyRWRuQVkrNGxk?=
 =?utf-8?B?M0JnVDg5YStWSDFEdjc5NzYvdmRKRlo2WjZGYWRPK1lOZCtXNTNjUi9jYmxq?=
 =?utf-8?B?dk5vMldrYUlHY3BWeDA4TkhCVHNLSjYrS2RsU29ieGdITFZxWUEvaEpKZGxC?=
 =?utf-8?B?L0dGVDZTalNEa1R0ZDVHOHJkT2V1NVdPK1VaSU9vNGsyNzBMZFpyTzgvcWlL?=
 =?utf-8?B?dXAzeE1QWjJvWUg3VHYwelFXTlIyZTFEeWNhZDJFKzlxZDBjVzA4bDZyczZ3?=
 =?utf-8?B?SUFvOHBrQ29mWnJQOC9LZEs1aEFtTmQ4U3hMOFZLYThLOXZVMTN3VFBNWEhY?=
 =?utf-8?B?bFFVa09qSFRYcnFRZTJROXFjanZRMmhTODhGcXFyNk9VOHQ4R01DMVBOUXF1?=
 =?utf-8?B?VFVUKy95cCttWmlEWC9hUTdoQThaeG9IQWZ3MWhhbHNtU0JZejJabkpMZzdy?=
 =?utf-8?B?bjZ2cHhKY3ZwR1Y5WmpJL3o4dzdESUJpSTJLemQzRzNON3ZDeUk5aklENkFK?=
 =?utf-8?B?bjYxYWh1QmZ3di9aakFXN1pDa1hTTTVFVEVzajg2OWtDSHAwUGsrc0NvMlZa?=
 =?utf-8?B?UFpoQnF1L1dvREd2NjZyc0RUZ3p0VWdLMkVZKzdTMU14OVphcGpQSkZFdnIw?=
 =?utf-8?B?ZTE5K216dFE1V3c5UjBXbWt1Tk0wNk9vUGV6ZUl3YkJOSTB1VXFMNDN5d3ht?=
 =?utf-8?B?QWVmY1dReFZkd1pGRVQrUmtJc0JpZ1I2RjRYRFZHQVIraVMza0UvRFRPS1hy?=
 =?utf-8?B?WExNL1gxUHdrVVVkck9WWU5wNlYzRzE5ZXlVUExNK0w4K0UvejlDV2FYcHhr?=
 =?utf-8?B?czJpRVlxNmg0dzkreWNrL2pFbEdkV0xkY2c5ZFRGaFRiMVY1NWI4OFR3eDdI?=
 =?utf-8?B?VnJmL1dHblVkQUd1K0RTUHovUEhoaERsazg5MGpTMk5pb2lnNkFKa3daWVUw?=
 =?utf-8?Q?sJ5cEFX2at6OwrM04nUu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(1800799019)(366011)(376009); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmk0OFdlL044SU95dmxleVM4Y3RzRDRXTHE2VHJiRWVoU0VNVyswZFJtNUNt?=
 =?utf-8?B?eG9KOC9xcUtRLzhKLzhRNnBIWVU2UDkyaDZURUlmTG5VeDBhYzJOaldPbjJa?=
 =?utf-8?B?bVlyQ01VcWJ6OGp5ODAyM1p1UmZ2a2syd09pUStpdWlvODVLbU1VeEpCWkxx?=
 =?utf-8?B?c1N1anFJbWx4T2lXTzlVckE2bm9aYTR6ZWpLU0cyMW1ibzl2S002Z0ZDMFlC?=
 =?utf-8?B?NXlLL1pDMit3Q3dGODV2QTg3OUtWS0lyekMvV2FoTlVPc3pId3o3NnRQMWdo?=
 =?utf-8?B?TDFVZFJnb0pnbC83UDVaYmtMMzU4ZGNSRUhSU2l6YXNXRTRob0FuMW1nKzZY?=
 =?utf-8?B?UzA3Y2FhUE9jNGRrT21pQzlDSzRJUFdobkVzbjRFakhsbm1IRnJkU0poR3hF?=
 =?utf-8?B?V0NJUlBBWlBLRHdPc0dEMjZYVzY0N09GbE84dHVBYnA5REtTMk5uNGVVSW1G?=
 =?utf-8?B?anBZRUlsZHFYSW9tWm4zbVM2c2d3L09wKzI0aVZYeUVBN0psMVlISVhuR3Bv?=
 =?utf-8?B?SVh5K0lUa05RdWZTSGx1NVNBSk1JdnlkOVAyZUdpYWhkV3JERlorbld6QkxN?=
 =?utf-8?B?d0UzWjEyQ2RFemRVSHhhMkhDem1XVWh2dVZ5U3ZSd1ZWMXVLNEpCUTBwaENJ?=
 =?utf-8?B?bmtHc3c3Wmpzc3A5WkY4WGNaaCtUQURvUlpPUmh1T3FRRlpBZkZPZ1Y1bjVo?=
 =?utf-8?B?WVY4eXovbzZjQUNzVlZDWlk1WkErb25TRmlDd1NZc05NWWNwSmNOcTdka3JR?=
 =?utf-8?B?UTFkbUNOMExYZXhhR2pBdFQ2eTN5a0Y3cUJKN0VkQk45bHZjT3FsWTVuVy9a?=
 =?utf-8?B?anJtQ1NxS3A5THpjSFQvcmtrUGQrbFFDbzVXNDV5cVNFWHVxdVJSeGY0OXhi?=
 =?utf-8?B?UHRBYms0Z05qVlhsQ2pBeVh1elJsRStsbFh1WjFZSnEyZjRzWFdPVzVhMlUx?=
 =?utf-8?B?SjJPREFzM250czJ5ck9vR0Jlak0wUWVEQWdKS0ZrVm5NS0NDUjBhM1RjVFJO?=
 =?utf-8?B?U0MzM1kzZTRkSVY3c0JlU1NhcTM5K1EyVWNiVE5XNXVFc1hxdEN4SkU4bmdp?=
 =?utf-8?B?Zmh4ZHJlOUhSWVhlaEJFSzNQZ3MvYXhQUXdyNlZ5WHlNQjdVQTgwdDB6TFdp?=
 =?utf-8?B?WW80VEV6N0twZGVpaXlHQTR1MVpUTm1zOGdsSDBMRm5VUXVaTkwzR3dPMmdL?=
 =?utf-8?B?V01EckQ4YjFoZlhKMzEyNHFCOW1QNzdzcFJ2UVVNSTZFREM2cFMySHgvbXg1?=
 =?utf-8?B?YXJGWERMSU5mMU92b1VtYm5xNVVJMjUrRWdOciswUGxEeTFyaXByWWk4MDd1?=
 =?utf-8?B?bGo3Y2h0R3JEa1F1RFg2enNJWjFnN2hlbG5TWncwTmliVmFLTFpQODJuUmh3?=
 =?utf-8?B?ZXpoaWpIdDA2UW0wYklYUHluWkU5eG1NQ09MREVFV0FZMUdTWUltV29Db0hI?=
 =?utf-8?B?ODhZRXhBY0IzZ2ZMSFFaWFp0cFlTNjJKTU9nT0F0OVMwRk1GbEdNQnd5U29z?=
 =?utf-8?B?dE9VbDNJWisyL2htbDl1NzdhSkxkMFhmbys4ZkJ0K0Z0V2lPMGxnTW10VGg0?=
 =?utf-8?B?QUhPR25DKzY1NlNlOFZtNzNuWDc1MENkaHU2U2FWVWNQb2RELzZkSmNGZUJD?=
 =?utf-8?B?V1J5SDVoNGhIVmh4Q3ZOK2Jlbjd4ekkrMWpzWEFIaFg2eTZaVGVDL1c3bVAr?=
 =?utf-8?B?emtQNk9kUUJ6Z05pK3F0b3dzRTJhKzNhM0llUUV5V0YzUUl2NU9ENU03WXRD?=
 =?utf-8?B?WXZXdnZFNlBnclFINE9POEU3UnIyN01vRE5IbG1CclNjZ3F3TCtBY0h4emxO?=
 =?utf-8?B?TXAzQkwwQ0JJS2VSRVAwZ3lOeTRKTDRudnJ5TVAySUhrSUVQYlYzUWlPYnhK?=
 =?utf-8?B?cmpQTW04b04rL2J6dzRSLzYydTZsbVZLMlQxVnEwVTRLeXFLemZDaVNkdnU3?=
 =?utf-8?B?T2YxTFBDdzhTL29qUW52WHJCQngzYVJicTl0bFdMZ3dXWW5zR2diOWhKNzBJ?=
 =?utf-8?B?UTVkN2lzQUxQTkh6UHQzVzBiVVNFWGRMNExrRm9MMGZ6cFBWWkpkZmlFK0Y4?=
 =?utf-8?B?V2p2cTEwYXdUbWdOYVF4SFd1TDA1dE85VUpHb0l2Qm4rYmR1NW9DaHFiY2tj?=
 =?utf-8?Q?hs8k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c220c6-ed98-4d5f-4aad-08dc8bb2f14d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:13:04.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BPkNMTur00pXYcWVoOKh708PaWGe2xcHEpLrFqRJR6Z3Aw/KjEBHYl9Ui29BTpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
Received-SPF: permerror client-ip=2a01:111:f403:2407::62f;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/13/24 02:11, Zhao Liu wrote:
> On Wed, Jun 12, 2024 at 02:12:19PM -0500, Babu Moger wrote:
>> Date: Wed, 12 Jun 2024 14:12:19 -0500
>> From: Babu Moger <babu.moger@amd.com>
>> Subject: [PATCH 3/4] i386/cpu: Enable perfmon-v2 and RAS feature bits on
>>  EPYC-Genoa
>> X-Mailer: git-send-email 2.34.1
>>
>> Following feature bits are added on EPYC-Genoa-v2 model.
>>
>> perfmon-v2: Allows guests to make use of the PerfMonV2 features.
> 
> nit s/Allows/Allow/

Sure.

> 
>> SUCCOR: Software uncorrectable error containment and recovery capability.
>>             The processor supports software containment of uncorrectable errors
>>             through context synchronizing data poisoning and deferred error
>>             interrupts.
>>
>> McaOverflowRecov: MCA overflow recovery support.
>>
>> The feature details are available in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>>  target/i386/cpu.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 

-- 
Thanks
Babu Moger

