Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55192CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCmB-0003aj-No; Thu, 18 Jun 2026 09:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waCmA-0003aM-LL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:27:22 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1waCm8-0004hE-Ap
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4TtppkmYfd1aE+vNbLEOdong+5cKJpJXGYs6oddkBxG2iJwvGGeqFYnKon2stYzjTDCuhW1O9B/WaNFduYWw/F+RqTdXiITQbHxOFxuWrx+dn/2ezlk+y77rB8LyyG7EBsvq/6cisP9DD+Ja8bjJ3d4WoGs9gFUCQA+EKf9dXQ/17hnrLqMws/BzivbXW24Yl0bgM2at04MbHiFIcD2FioUhwadq95JudxmxnHLqm+MrlI4MYFyr8q3nZXZroLAhOLlrIkz7ah4L1szRWn7pEB5vWN09LT2suNJj21tG966pX6VO/XACrIvOkWFQ72UEtHr2FCztK9Mc9dnvXJUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK4PapPxCHN1E9sNWYDPPscaJqjopkp1+fZN7UFMUOQ=;
 b=v0bS2R21rYgGmeCPN1Jbkft79ndOfrtHv0XZAMm0MyUFfTCuLwoggrvVjdqV6EoY+Ea63VvqWwFoOrUlxnUAUpJcBrphbOwDsO/EfW5u7fzZoJvwfoGtH8jaakxpGZXoqgX8F658QhL9wCeW4K1eq+7rncEBb0IW/3NaEAwoBfrTb35J5wlpdm2IFPjmJ66vurxptVptYTqFR2WA0RXoulNNq8WmaMtQTa3Mzv787474ghtQEJPtTI4V8Ij4Mcsz8p0mnrDkNLMWhgL08vNoh0G+vpowNN8QV2FYfBbtp1blsV5w+M3fFdSpV/eZmfPORPmOWwi+WQ+JPpmioOTsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK4PapPxCHN1E9sNWYDPPscaJqjopkp1+fZN7UFMUOQ=;
 b=EGBYJXMQ5WR3er4jEnLfDnbNKpnOtWM3MMLQZXogufaFMMjPQvP40tJbXN7UQreRCUF5JAgjar4VHcCk4MurG7vwTMfOPUov4DvIcF57Hy0wU1tLSF5KqHQm8I2QICitiYTZMH8YeUVr1RmnL7vxAIcU97rNWE00Zp6xLmBTRfTpaRbBiFPY/CncgpMuD/yriol2WupLzdVG3bkh05ibWL3ycb36s9HYc+GD31OVGvTxsoD0V1Vh30kdQ22uX0zH40URPy9tLYQk8iLfbhZy1LwE3ds43Ojpc+4lyJI2UmUdCNt7wrLEKeIoSmBlB+lGzm1h6zDL7nQ6nDblVYzwgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5826.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 13:27:15 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 13:27:15 +0000
Message-ID: <0ab1314d-5863-4172-8481-c2dd6d0c6947@virtuozzo.com>
Date: Thu, 18 Jun 2026 16:27:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] migration: stop VM earlier for CPR
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260612165110.431376-1-andrey.drobyshev@virtuozzo.com>
 <20260612165110.431376-3-andrey.drobyshev@virtuozzo.com>
 <1e0a1d0a-a5d2-4b9c-98a0-9875c6147bd2@oracle.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <1e0a1d0a-a5d2-4b9c-98a0-9875c6147bd2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e34e04-81d9-4187-71ca-08decd3d4fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|22082099003|18002099003|4133799003|4143699003;
X-Microsoft-Antispam-Message-Info: lzx2IJSjDd5qiP4KIMbYeFroL9JJOMuqkMJqTWn4xxLmMSe75amUUUEg7T7uMY98BrP80f/QHqy0Y5CJUU1E6X5r8otcXRtxT7W4+utmnhWtqxLIkAwiJ40loEif/uilliQaXBLizjEuZhgzNQsb4jSp6gKO4tbNkxPAiITC6j/Rf7tit+CMKt3tfEDElHTc07mPZ/HvidGyU2oU7uRiDospKbs7zqM/17jjMoQdUGenyljoQG70c62TKBDFkK7olHaeXwvzzD8nLIT1tR1Nb/K175dIrEY+bZsdjz62h2W6TKaPj3CXsLMSzjPQwuP9iOVRikPFllqeDBFK+6ELq3NV16hSKqzwLbMB6VDoNxjcdIwjHzBuh1jGzEwLk0NianQGlQdhQKA74Dv+b730+CRjwFHZ0C7Wu33stms9RPfIwec37bi17Pb/Tzo6uFFr6oeY7gen69H8K7ndHaixtodTgYrVfK2mhgEVio6mJWjFOSSsV4xdyM0gB3Wusn39nFt4oa4KqaNxxphUXxydPUhoByLhxnh7tlMekCqhwF5kcoze9ww5ItKV4C16NJKszFrX/h0TyKoYIByM/DrYRrv7dLO0czgR9L4lxAXdSApkspuJV2xItjGOdqFNKrgAKeg99YmAZx+q+/u50mNlQWCFRGM/Zb+hCvtWUamjVd64U8e22LAobcdW6wEEgEuQSKtaSiEkIiDX2zPdj8slUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(22082099003)(18002099003)(4133799003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFhrY3NNbEVvZDhJSmhwUWtSZjdxSUlXTndyMjk3UzQ3Njl1ejdoNXQ0ZGtN?=
 =?utf-8?B?YUJHbjZmWWJRdFZiazZYd29rS2xmZHczMUdmUXhrVU4zSEI0dVNvcjB0QllO?=
 =?utf-8?B?a0VUN295cTVTMHl3VDd1YVdWQnBwVmZHU2RmNTNsNFRjWTVBbmpaWW1QZUtR?=
 =?utf-8?B?WEp5SGZCWnowTE1mWGpQRXl6YlpNcDkzMGJnMUdBdW14ak0xNk5WZ3JveUxV?=
 =?utf-8?B?MGplSjBSazdyY0Nvc2M5aENPUHYrUHordFcrdk1pcXRKdVA1N1dyejhWQ0xK?=
 =?utf-8?B?cXFhdWF3ekxkOTZBOERWb1JzTEhPeTVkZlp6Z2FySmM3M1UwYkRpaFl1U2Nk?=
 =?utf-8?B?YjBCV215MGtyZ01nREV0SlFzVzhVTWpIR1A2R2hFU0NGNHRLZ3F6aUlIUHZm?=
 =?utf-8?B?ZmhjZUZEZElGYkZFcFdSeTdPN3ZTU3g1Y2xtUHZqSFh3WmVtVGRiOC8zdjNI?=
 =?utf-8?B?NWdZSGtFRVVGQ1pBY2Q5YzBlTFczQStDTk81cHVzVEZaNWRkbXJBM0t5WXla?=
 =?utf-8?B?UnpUbUxRZzk1M1FxT3NWM09rUHE2bnpRZ1pSeFBNRXgxbHM5NS9pYUJyMG5Y?=
 =?utf-8?B?V05zbjJ0MGJpdVVoMndmU1R1N2E3eXVIZzlTRlVsWjJiUmwxZE1mazhsNndR?=
 =?utf-8?B?NFhYNHV5dzFva282WXVoRDhZRVB1R0pMZTk3MFdUd3BFNkdzT2Q5amluajl5?=
 =?utf-8?B?a2NmK1pBVzk4bEQ2T25IRFhyWmhWQ0xvWEc5MG5ncWhVUzZhOUIzQTYybjVU?=
 =?utf-8?B?U1VhTCsyckF2b2ZFYjNzbWpLamRBcTFMZW5jcVpsUW1VV0cveVJpSFJDTGdV?=
 =?utf-8?B?Q1k2U3RZdUM2b2N5eVRHRkJKT1pld252MFBqT2xqdllnSFBRQkxDbFFTZWEy?=
 =?utf-8?B?d3B4YW14aFlJYnJRR0FUOC9sRmtIa3lmVnUrclllYkRyanlibFFob3pZbVho?=
 =?utf-8?B?c2pESG9rcjlGcXhGU1ROcVpFZ3V5b3dYVG1hVlZ3bFdGOFBHQ3k4WlBiK1hu?=
 =?utf-8?B?cFAvRno0UFhoQU5xYWxEOUJzQ1FBeUY0cCtHT3BQM1g5RThUdnpaWStuNzdm?=
 =?utf-8?B?VjhicFpySTRQUE9XcWt3ZUZhQWt0dHUxUlpNY0hXd2w0ck9BMnl5K0tOOE5H?=
 =?utf-8?B?N20zbGhYR0hzUDRuL3hqY2dtQkFXQ3JXRXF5UStwWHlxYkRxY1VPVVZaUmZk?=
 =?utf-8?B?ZUJiUkZwcFk4U2FjSTRTQy9WWFMrTFM5a1Y5aFNRaGFKWHl0Q3JMVjVDamdW?=
 =?utf-8?B?VWhVdUN6THlQNVBZdS85Ni9kdnpJOFUvdHVqWHZSM1VLVXFUaVlMaDJEK0pC?=
 =?utf-8?B?SW43eUxiMjM5Nzk5YmtXQmRKbmFQSDgrb21KVDNsaUk5K2t6M3dxaEs0akJO?=
 =?utf-8?B?cWlOWEZBVmJPVG9kUVF0dWxiQ2ZnS1MyZnZKQlUyUmpSZTRVL01ZTGVOZDFC?=
 =?utf-8?B?NGNwSWcwNzJXOHk3WE04TjZGZ0E2QTc5UFFIaHpXa242UzJ0N3dZcE1zN3cz?=
 =?utf-8?B?MDlhR0w3K2l1aVNvc3FpSlV1amhCcVFIcE4zME1vdEpxOEZ5RXdyaUhZaWh4?=
 =?utf-8?B?TzBXUVVtZHR6QUVTTGM4cnJzeGJOS1VWR1UzSW5GenRrRWFIcFlGZENza0I4?=
 =?utf-8?B?SnVOR1BoQjBrdmRXb2pCRVdSNzhodWgzOVNpVzc1amhaU2tGZDhyNmxkeHpu?=
 =?utf-8?B?Ym4waUJqRHVrelRCeENzeUE5amxRMUdGanF3cC9LUzg5NGt5YzRQb3J0U0gx?=
 =?utf-8?B?TkwxVXFzbXR0R1Y5cExqd3U2cUxoOFgrR2kweHJSbzdCQjB5VjlOUC9hakJy?=
 =?utf-8?B?RnFuV1BIL1JmcFI3WjNNNlJDZ1BNb0tPMHZreldTMFhVVFNQQjhaS2dxL1gx?=
 =?utf-8?B?cGxtUytmdEdZRFA5R2xpM3BMc2Y1UFhUeHhDeGlPTno0TFVYaCtyZmJSS2ZO?=
 =?utf-8?B?NXpZaFZIOTZwNXQzWTJ0cHBXMG4rY2hodUVla3JKU2R6SWFQU3JpL29veUd3?=
 =?utf-8?B?T0lpVitWNGRIUmdvZWhTU291aGVVdTZVLy9HdEtvZFJwemZMRkpMaWlaRjda?=
 =?utf-8?B?dlhBbjh5MWpPU1g2Z09GdzhvTzhWeHBCbXlzdXVKbEQvQnhmeXBEV1hoODNs?=
 =?utf-8?B?NXUzMnU1MUtRbzg1ek1jdmJ6b2V3NnpjbnFhTFYrRkVDeUsxLzY3U0lrNkdS?=
 =?utf-8?B?QVNVVHFTUENkbkRuUEpPbTljQ2IyQUl1RW5ITjEwV0dqdUFTL1R5K3ZPOEhM?=
 =?utf-8?B?dlFQZDJRZDFOUEZuVXZCTWREK0xCd055dkV3bUJmVkN4cEFjcCsyQlVLUHla?=
 =?utf-8?B?TU1IV1RickliNjlqeW1rajJtTHhnNGxrTXpUUExpclp0d2JNSi95VE5RUFRH?=
 =?utf-8?Q?C0VQU7ZBuc8brghk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e34e04-81d9-4187-71ca-08decd3d4fe6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:27:15.1437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwywiwKXUBiWzUqKUcvIwlaELu1uxoOj7Iy0B+A18YFTgK2CPBLiU5ExLIhwKPOHVryy+f9uHIahIk9n5mzmr7tb+WPhCCmxyCHc6yyli7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5826
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 6/16/26 9:19 AM, Dongli Zhang wrote:
> 
> 
> On 2026-06-12 9:51 AM, Andrey Drobyshev wrote:
>> For CPR-style migration, we need the VM to stop earlier on, before
>> cpr_state_save() fires.  That is to prevent the race between source I/O
>> and target device init, as well as make sure VHOST_RESET_OWNER and
>> VHOST_SET_OWNER are fired in the right order (cpr-transfer case).  Thus,
>> for CPR case migration, let's move the stop to qmp_migrate(), directly
>> before launching cpr_state_save().
>>
>> This patch is a rework of the change originally proposed by Steve and
>> Ben at [0].
>>
>> [0] https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/20260128-cpr-tap-v4-0-48e334d4216b@akamai.com__;!!ACWV5N9M2RV99hQ!McDgSIuX3a-mCdNkiaf0TCITdQB-bEHCppcpig8fe6BPBWlU7qkvjW5FhLN0twb2fq9pC2qDYPH_FQZJYglJy4C71FMad5DMog$ 
>>
>> Originally-by: Steve Sistare <steven.sistare@oracle.com>
>> Originally-by: Ben Chaney <bchaney@akamai.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  migration/migration.c | 73 +++++++++++++++++++++++++++++++++----------
>>  1 file changed, 56 insertions(+), 17 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3c70467d314..c02f1da8b0e 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1380,10 +1380,13 @@ static void migration_cleanup(MigrationState *s)
>>  
>>      /*
>>       * FAILED notification should have already happened.  Notify DONE if
>> -     * migration completed successfully.
>> +     * migration completed successfully.  On a failed/canceled path,
>> +     * resume VM for the CPR case.
>>       */
>>      if (!migration_has_failed(s)) {
>>          migration_call_notifiers(MIG_EVENT_DONE, NULL);
>> +    } else if (migrate_mode_is_cpr()) {
>> +        vm_resume(s->vm_old_state);
> 
> In migration_iteration_finish(), the VM is resumed only after
> migration_block_activate() succeeds. With this patch, CPR failure handling is
> moved to migration_cleanup(), where vm_resume() is called *unconditionally* for
> failed CPR migrations.
> 

You're right, thanks for noticing.  Theoretically we could just call
migration_block_activate() once again here and gate the resume by its
return value, since for an already activated block graph this new
activation attempt should be a no-op.  But I'd prefer a simple read-only
iteration over the graph, to check whether we've already done a
successful activation - and if we have, proceed with the resume.

>>      }
>>  
>>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>> @@ -2130,6 +2133,45 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       */
>>      Error *local_err = NULL;
>>  
>> +    /*
>> +     * CPR-transfer  ordering:
>> +     *
>> +     *   SOURCE                              TARGET
>> +     *   ------                              ------
>> +     *                                       cpr_state_load() blocks
>> +     *   |                                        |
>> +     *   |  1. migration_stop_vm()                |
>> +     *   |     VM stopped, devices quiesced       |
>> +     *   |                                        | Waiting for
>> +     *   |  2. notifiers (SETUP)                  | FDs from source
>> +     *   |     vhost_reset_owner() releases       |
>> +     *   |     device ownership                   |
>> +     *   |                                        |
>> +     *   |  3. cpr_state_save() ---- FDs -------> |
>> +     *   |                                        |
>> +     *   v                                        v
>> +     *   postmigrate                         Device init begins
>> +     *                                       - cpr_find_fd()
>> +     *                                       - vhost_dev_init()
>> +     *                                       - VHOST_SET_OWNER
>> +     *
>> +     * Step 3 is the synchronization/cut-over point. Target proceeds immediately
>> +     * upon receiving FDs, so steps 1-2 must complete otherwise:
> 
> Complete successfully?
> 
>> +     * - Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
>> +     * - Race between source I/O and target device init
>> +     *
>> +     *  We stop the VM early (before FD transfer) to prevent this race.
> 
> How about move some of comments to the commit message instead?
> 
> When reading this comment in the final code, I found the race description a bit
> confusing.
> 
> The vhost_dev_init change is introduced only in the next patch.
> 
> With this patch applied, the VM is already stopped at step 1 before SETUP and
> before cpr_state_save(), so a future reader may wonder why there is still a race
> between source I/O and target device init.
> 
> The race is the motivation for the change, not the behavior of the code after
> the change.
> 
> It may be clearer to keep the comment focused on the required ordering.
> 
> Thank you very much!
>

Agreed.  Let's move the motivational part + the diagram to the commit
message.

Andrey

> Dongli Zhang
> 
>> +     *  Unlike regular migration, CPR-transfer passes memory via FD (memfd)
>> +     *  rather than copying RAM, so early VM stop should have minimal downtime.
>> +     */
>> +    if (migrate_mode_is_cpr()) {
>> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto out;
>> +        }
>> +    }
>> +
>>      /* Notify before starting migration thread and before starting CPR */
>>      if (migration_call_notifiers(MIG_EVENT_SETUP, &local_err)) {
>>          goto out;
>> @@ -3482,13 +3524,19 @@ static void migration_iteration_finish(MigrationState *s)
>>           */
>>          migration_call_notifiers(MIG_EVENT_FAILED, NULL);
>>  
>> -        if (runstate_is_live(s->vm_old_state)) {
>> -            if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>> -                vm_start();
>> -            }
>> -        } else {
>> -            if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>> -                runstate_set(s->vm_old_state);
>> +        /*
>> +         * For cpr the VM resume on failure is centralized in
>> +         * migration_cleanup(), so don't resume here as well.
>> +         */
>> +        if (!migrate_mode_is_cpr()) {
>> +            if (runstate_is_live(s->vm_old_state)) {
>> +                if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>> +                    vm_start();
>> +                }
>> +            } else {
>> +                if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>> +                    runstate_set(s->vm_old_state);
>> +                }
>>              }
>>          }
>>          break;
>> @@ -3903,7 +3951,6 @@ void migration_start_outgoing(MigrationState *s)
>>      Error *local_err = NULL;
>>      uint64_t rate_limit;
>>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>> -    int ret;
>>  
>>      if (resume) {
>>          /* This is a resumed migration */
>> @@ -3944,14 +3991,6 @@ void migration_start_outgoing(MigrationState *s)
>>          return;
>>      }
>>  
>> -    if (migrate_mode_is_cpr()) {
>> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> -        if (ret < 0) {
>> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> -            goto fail;
>> -        }
>> -    }
>> -
>>      /*
>>       * Take a refcount to make sure the migration object won't get freed by
>>       * the main thread already in migration_shutdown().
> 


