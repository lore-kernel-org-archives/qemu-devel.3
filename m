Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32F8CDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPjN-0002We-QI; Wed, 24 Jun 2026 11:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wcPjK-0002WI-P7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:41:35 -0400
Received: from mail-northeuropeazon11021089.outbound.protection.outlook.com
 ([52.101.65.89] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wcPjH-0007Pp-P0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:41:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzsMzrlFfMgtCsI+d8r8ZVtywxbdyUt1INWY7JUiccRBv2L7WSKjoZCgGcJ36LZIpRV54rBAKPkTsCnOlZs6UHs2iW37VQP5rzAWhRzF7AdncBZXo6sElIRcmDKRUWMFbQ1T0ddkqEs7zs4ym8g8ig4XjI1XFpChSLCn+GZq9iHBJIRiGniKD1UtHOy3unEr96ilNuXj3D4BJ/TZcDcv7zNjPDnklPCXa1HUbM8CfTgHtum+C47iBqfEOS3/FQZTF1KvrRFpNazla2/MWvtpKdJ3emy1+HI4dG6EvtViqR3AgmQopmk4XSbEG36n2+CdkFQe2K1dbWfGiHXOufE10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKJxOpXmAcRX/2xp1/aCwpqYjLErGONk9dSlR1tp7As=;
 b=vWm86/lSIZ/b8lR5+2NQfGI2gHMT88BXkZVJSsSnyvicbV2NfE2vVMwD0upwfMxVl1oyAZgKFO+zU7qCchvbVhR8ZNupgcG907+sQ9pt+XR+isZnNFBW40Tp0O8C26Zf3PKk/lwUE4fdHfs4uFPnIVjVVStO/ExyoWFI507cjxOiNuzhoLj28ExRu/0wD+Z5CSfWeHrmUiQ5ZHFrflk18JvLbz7VKcfkB7eUjckC+WPhTXq9OLq/0Kuw2OsZSx3OujedAXY+A2LKM14igTiBqwuLOn2ouMb+hsOpwl7VzMaUnwRQ3FYySgvK2HfH2PWpsvUx0AIz9IxflL2dzKNQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKJxOpXmAcRX/2xp1/aCwpqYjLErGONk9dSlR1tp7As=;
 b=KKsQ25ofn4C44XOPQFJSLb7N+tsuQIx6wJKNJSq4xyTXW6HLSSbQfE4urnSLFwphACM0OqDpLY6Py5E1Ar1U+FKrlgumcWpw0vDpt9Sr8j1oC3kuzx+VCvXCF3nmT77XktffhKjSMqXKGhDutCCBzI2guGRWpBK7py4s6qhdUnFNVUmCnWTOqeejQHV3ax9VjXZK77T1/lhIo2BI6oViUcEm7q4i+vcwKdQz1J113PsYYUVh/crSRACWydJZyr4xyNYtNpVlvg4I9BGwuODuutuZ2xNw/CDNNeSPD4sQpsj9S/TR4zKlEkywZyeb//Yx+GSnrb5Z+S3t21PzVFKn+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11567.eurprd08.prod.outlook.com
 (2603:10a6:800:2e9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 15:36:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 15:36:24 +0000
Message-ID: <2281dd77-414f-45bf-8cfb-47934ac0c658@virtuozzo.com>
Date: Wed, 24 Jun 2026 18:36:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] migration: stop VM earlier for CPR
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, peterx@redhat.com, dongli.zhang@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
References: <20260619105514.128812-1-andrey.drobyshev@virtuozzo.com>
 <20260619105514.128812-3-andrey.drobyshev@virtuozzo.com>
 <567d4d90-beea-4218-8e02-f867e10f6ffd@maciej.szmigiero.name>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <567d4d90-beea-4218-8e02-f867e10f6ffd@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI0PR08MB11567:EE_
X-MS-Office365-Filtering-Correlation-Id: e876521d-1317-49a8-8dfe-08ded20658fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: qcitn6nN3tkUWS0IO+1MZdBwwH8j/ksB3AwS7lM41oq+FMCcBYSYtO/dz1iQslpIKpO23P3U9chS4gjEXqv81dwlxtpDR9BwgCYAXeMriIyO3sVPioxdXhWWbGp81yNVruP+Ee7ek37s7z0QyLE0qTkXCI0EpbiEYJcIGE9jTA7JY6HsxHvOuJoZty0Bvs+u5fp0Q0MXZtROV8ao7Ik/uPLVjmL8RFTbdN8DCthbWaNLIp2S9eI4nqrfyC7a47noNANLT/jUDL6QkHdiKS3iwUHl0uJOqVhBp6EtYenNqxNVY81/kSH19WFi3BSHoQOsmHKarxz1JoPWsnWpd2LZeVCXVFktpp7vVTYan81G5CsYPMhOx0WGjQebVAflPqWQtk0VnSsYMhxCn3R3ynZ492x9v0ZdIMZF8vLO/XGjzoyaoXOn76O86ayVC1BiNG0a3QLXQimWcS6sez51tnMjyDjTa6XZP2FumVESv6UBHbo2klpxApCp3Eii+M1BCkhPiD5K6UDjr7t0Uomc38piIMORQ0XEB5AShv02rv4GfFO+anZGGHgpNlmBNx4llkw6QXl2HUAnQ61hhIu6wn/VnD2NKQTDOqGhI6UhTud398O3MbPduxsj80T8C+jTyTQRokJg9UwUlS6f92ZmbZbwN41gNUWtb12x8ysV1SGqhE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNmMU1YZHhIeGNnUkJKR1VwaldVRXo5YVBZN3hTQUN4cGpoRUFtUTZ5OEE0?=
 =?utf-8?B?Z2xMMUo4QUJMYlBCK0FRWG9LQjBQakxZQlZuTVFuUkw0U2MvZFNHMTBma2Yv?=
 =?utf-8?B?WllpL1FPQTRWNXRsRTNCMWZZSnR4V0pjRDVXcVhrZEh6Y3dRRFFDWXNaU3B4?=
 =?utf-8?B?bnVtZjJ6SEYvM1dtWU05SFZNaHpEYm9QQVpIWjUrbGJndEVLY05lNXAycXgy?=
 =?utf-8?B?c2kzbUpPdEJqRXZWaFJoQkVENVJ0TWRLRVFLSmxTMWtXSGQrN2pKeU9ONGFy?=
 =?utf-8?B?SjlRbk5ubG56ZTRlTjY4NnBTaUREQmZIbnZ5bmxmczdmQTBaRjVNQzl5dFlv?=
 =?utf-8?B?TTY0dkpmbmtJaE44NHE4NWtQOFFTaFY4TWtmNkREYnJtei9YWXJYcWljOVow?=
 =?utf-8?B?TW9yUFBBdFcxVHZWT0ViZ2Z1cmc4ZUlqcGd3SmtJOEl1TmNOb0NGZzR1TlFa?=
 =?utf-8?B?V1lab0hzNmhFK0NVWFAzekg5bDRoeVhMNGVIbVQycUdkVExGWTN0anFleEFB?=
 =?utf-8?B?Si9Lbnkyek82bGxwTWZZaGthWFEyT1Y0OFpZTnhoTjUzeUE1UFdQOTMwSzVN?=
 =?utf-8?B?Tm1oMytYTDJTVzNnVjd1WUsyTUJzdU9WV1RKT2ZaUXJzbEZRYnpNcUhrM3VY?=
 =?utf-8?B?akVDaFFlc0ZlZUdnVy9SMFZHWU1sNTVNSTNVNFRqc1lQN1V4SndUKzNhVmNK?=
 =?utf-8?B?dCsyUWk1ekJOb2llZmZhOVppRE5aNEwvL1F0eGdYL21HbXpnaklIZ2UyZldT?=
 =?utf-8?B?cUJ4cFFjZzEzL3BvTmFEekpNaTJhR2VUb0oyODlwYkdaNHRUdDlJcVU0Zkpt?=
 =?utf-8?B?N2NDanVVYUpHNHM4NUtpSzlQWEt5Qmg2Mjg0aEptSE1ORXdIMmFHa2Y3blZ1?=
 =?utf-8?B?cTV5TTl6WWdsVEl0ZHBxd1NLd1A3MzQ0VVV5NVowSGJNZzN2YUxSR0NhanlW?=
 =?utf-8?B?Nnk4eEU1cklwQmcwVmR1QzFLcCtmZ0FEaEdoWnpvdm1oajRoQzhEc1ZKVCtz?=
 =?utf-8?B?Yld2b2lEWUhicWdnc2FCNkRhby9pMndZOExqYUIvZmQ4UXNLK0FGTlo4NWY5?=
 =?utf-8?B?V3E1M1dRSXdKZ3dJa2FMeGNrcFlYTFNpTlkrOFhSVnpRUUZRcXM0V0pJV2tq?=
 =?utf-8?B?eStQcFZORm9nV0JpVDAxaGlVYVAyT2Voa2ZNZmtnSmFqRGdtTUNqN29wV240?=
 =?utf-8?B?WEpIVFFsUWxkc3RZTnZSQ3NpWEh4a2NtbWMzS012anlFYTJCekMwMk5FaCti?=
 =?utf-8?B?ODB6WUZFN1Z2dm9mQ1FXQTRwdEEycHZGTDdZRGxhbXlHQWw4UDV2NVg5K1ZN?=
 =?utf-8?B?dDE1NU5XTjlUU3RYVzEvSGlsWkVEUnNsTGRTd1p2UW8yZlN0c3owUDBBMDcx?=
 =?utf-8?B?WUtvR1htK2J2bHN4WWdpMFNReENRSFQ2NTZOQ0tqdTNBbFBabkxpSHZXaDVO?=
 =?utf-8?B?S1lrVGxnY1FoNHJEQS9OSVJyUzZFVm1aNFhsZVZQK0JXZVZxbFUrQmJaY1gv?=
 =?utf-8?B?YnVLR1VpSm5RUVVqZlZ1R2pNVjVuQVgzSFpyRWlIcXJxU09sUVRidkxKVHlh?=
 =?utf-8?B?b056K1BQbjllT0xSUUo1MGp0YkZvTnZYc1RNM3dtUUZaamJBamU5cnAzYjJG?=
 =?utf-8?B?bUQ3WWNUeWtLZTVVcThHTDFBa3FDcjkzUjRRL0lrZ3VPNllFbHRFRHFrQVlW?=
 =?utf-8?B?TkordjhQd3hoUVkyLzdnNGdMYWd1QlAvRXU4MHBGa3phbnFCRlBBNVN4elMv?=
 =?utf-8?B?bFJCR3NPcGNjMlB3TTVUSW12L09wY2w3ZHNkYjNLbzFRNVFvVHdLbnh5aTJn?=
 =?utf-8?B?djBOMkF4M0VLVXNoN3BTZnowNktoQU1rT29hcmloMUdvYW1CYTB5S0h5ZWhq?=
 =?utf-8?B?QldLK1BtNzdpdzgyQzhUZHo4aHo4dVQweVVaUFJyajlTNll0eDJtWk1oUDF3?=
 =?utf-8?B?RGVndWRQMm9Ha0w2YzFnTzdNbG9BbDFhcnk5VmJsaVYzMmcyK0d0bmprNUJ2?=
 =?utf-8?B?aVVLR3V2QmtSQXJEZ0U1bE8zNklMWWRlMkZXMVUrdUtaYU56NFZ1ZWM5bFBR?=
 =?utf-8?B?aHJWNFlMZVFlbkpJdHVhdW02Q0F1T3VUc1dKMDNJM3p4RlBLUGw0L0g4UnNG?=
 =?utf-8?B?S0RpMmdHMlBtcHBUNk8zUlNvRnMrTjg2ZVJlWEhXWVF1L1M1NzVJV2cyRFV6?=
 =?utf-8?B?dHFCY0hSc1V6VDI4dFVMMEdVSjJVYTNXQkEraGhMOFE1TGd3dmpPTTRRR1NP?=
 =?utf-8?B?eXV0UndWWFlZMHFGbXZKb2I1YkJEYnpxQmo5bmQrcExUTDJOb1gxdHFKSWRn?=
 =?utf-8?B?VFFtanAxMjJjdlRsV3J6WUxiek5EaURhNE1EUnBPWTFyampJdkYzb2xvMDN5?=
 =?utf-8?Q?feUx4ObS8xQOYybg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e876521d-1317-49a8-8dfe-08ded20658fd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:36:24.0112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nge9PSIGJaQ9U/Ckp2bCxDRIvmyvEhpckPZcGVjPXX5wKTG43UG5miCLI5+RpMMOqVCqsIjMxPJBaS4APWTf1+EOqfXGCZPSrciYFZCscLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11567
Received-SPF: pass client-ip=52.101.65.89;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 6/23/26 9:27 PM, Maciej S. Szmigiero wrote:
> On 19.06.2026 12:55, Andrey Drobyshev wrote:
>> During a CPR-style migration, we pass additional CPR state via an aux
>> migration channel (the cpr-transfer case).  That's done in cpr_state_save().
>> The main bulk of the migration is only sent afterwards - that's why we
>> call cpr_state_save() early on in qmp_migrate().
>>
>> Previous patch placed emitting the SETUP event before cpr_state_save(),
>> since devices must be properly shut down before we send their FDs to CPR
>> target.  However, for the proper shut down to take place, we should also
>> stop operating them beforehand, i.e. stop the VM.
>>
>> Thus the desirable order for cpr-transfer case looks as follows:
>>
>>    SOURCE                                  TARGET
>>    ------                                  ------
>>                                        cpr_state_load() blocks
>>      |                                        |
>>      |  1. migration_stop_vm()                |
>>      |     VM stopped, devices quiesced       |
>>      |                                        | Waiting for
>>      |  2. notifiers (SETUP)                  | FDs from source
>>      |     vhost_reset_owner() releases       |
>>      |     device ownership                   |
>>      |                                        |
>>      |  3. cpr_state_save() ---- FDs -------> |
>>      |                                        |
>>      v                                        v
>>    postmigrate                        Device init begins
>>                                       - cpr_find_fd()
>>                                       - vhost_dev_init()
>>                                       - VHOST_SET_OWNER
>>
>> So step 3 is the synchronization/cut-over point. Target proceeds immediately
>> upon receiving FDs, so steps 1-2 must complete successfully.  Otherwise:
>>
>>    * Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
>>    * Race between source I/O and target device init
>>
>> Let's stop the VM early (before FD transfer) to prevent this race.
>> Unlike regular migration, CPR-transfer passes memory via FD (memfd)
>> rather than copying RAM, so early VM stop should have minimal downtime.
> 
> Was this "minimum downtime impact" assertion actually tested/benchmark
> with VM under some serious load?
>
> I am especially curious how this interacts with VFIO devices that
> have a lot of data.

No, I don't have the exact numbers here, my claim was based on the fact
that early stop only adds SETUP notifiers + FDs transfer to the
downtime, which don't scale with RAM.  We can reword the commit message
to loosen the claim.

>> Since we call migration_stop_vm() from qmp_migrate() (i.e. from the main
>> thread), we should also balance it out by fallback resume outside of the
>> migration thread - i.e. resume in migration_iteration_finish() is not
>> enough.  One good place for this resume op is migration_cleanup().
>> However, in migration_iteration_finish() resume is gated by successful
>> block activation, so we additionally traverse the block graph nodes to
>> make sure activation did take place before doing vm_resume().
>>
>> This patch is a rework of the change originally proposed by Steve and
>> Ben at [0].
>>
>> [0] https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com
>>
>> Originally-by: Steve Sistare <steven.sistare@oracle.com>
>> Originally-by: Ben Chaney <bchaney@akamai.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
> Thanks,
> Maciej
> 


