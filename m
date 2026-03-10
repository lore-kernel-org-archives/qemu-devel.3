Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C54FFCC9D6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrqh-0001vo-5w; Tue, 10 Mar 2026 03:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vzrqd-0001vX-UJ; Tue, 10 Mar 2026 03:49:48 -0400
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vzrqb-0001lI-Tf; Tue, 10 Mar 2026 03:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgVq3Lphu0lrmGYdTLUnnk9PV2GztzEjpIww0SzSJSje84ew6PqbRycpsUJPAhSmPegKUXJRf8w3+ABH6SBDp6G+jQPt9gM1f35yAmNZ3Spnk1riz8lIHrD/+fRnw42a8GARl5iVVbs/c6M+lQYeErVFztvkgvtpPRArYYu1dCLdPIEbva+iJ6ObbwoWlNLpcyjTy3jXp3KXb4QxK4dWKh3zmzz3B2faVkhzZp7sungR/xdiwTJdY05GAJwrTfK5XdY9Z0M8GXV8qTB5wsViBgX+HPY+H1byJ77e9p88rXvYbtgqg71X1QeDxwm2KZtAtxp74W8y4nszLHgoc1F3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XgIMbVFI1du/st2myWWcKdKfd6GaqHP6jxAzxrNtVQ=;
 b=LEg0soOEa6gXsjvWR0CIAhtdsuV++eIJvNB8aNecpiiYChMGs+qGlWiCOWP2FKcmy8WONP14ftskDd9tX6CaiMrTmkYe4FDV0OqLzM31ptU8l7ljsQkQDSZRN6iU67eE1zRr16lzEwNCR9bK2fped1LjBrV+0SIpL8VxgLifznqfbu1M/GSljlX7qtJsmZL1509RWLT/78ALWDg5Kk0ySU1juLxte0X0pEIUV8V7KUK7KSoya/Cw+Pd8jlH/8l4s+caQ9X8AW3nkuc22uJZE7+rU/h6ixAdTjC5QGqNQ0aoNiJodK5utjsTDC6Dd97oqI+Zookun4B0gneyphmyiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XgIMbVFI1du/st2myWWcKdKfd6GaqHP6jxAzxrNtVQ=;
 b=OGgBMZ12DEY8X+TZaBjEAjFsMkQ/Vjr6FFep1/lqfckO6A5jOWJxUhOP5kXMe/JyaaPl820sgxt7wfNkT4yseNyWhfcCVpItsC0USZusQdvknTkywVkOlwCTVDALEtmNdG9nt5noR78ICopBUCCmjHcbIyv4VA+7yjRy/YbOwGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GVAP278MB0087.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:24::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:49:41 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%8]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:49:41 +0000
Message-ID: <b4bfb38c-e94d-4833-aacd-af0b86f4327d@epfl.ch>
Date: Tue, 10 Mar 2026 08:49:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: add missing docstrings to qemu-plugin.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20260309-add-missing-plugin-docs-v1-1-41dddcd177c8@epfl.ch>
 <f624f3d9-aa11-406a-ac9b-f3fa2b103291@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <f624f3d9-aa11-406a-ac9b-f3fa2b103291@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms090705010101090805080203"
X-ClientProxiedBy: GV0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GVAP278MB0087:EE_
X-MS-Office365-Filtering-Correlation-Id: cb789480-84c1-48da-4640-08de7e79968a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|786006|376014; 
X-Microsoft-Antispam-Message-Info: 0i3Q2rFwpDoO3zpFYjkhhA1UEloKwz8pTMxiL2wv7CN/0ROc4OMt+tQOXaGeCeUC0xZHooHeF6Yxjo92aBIOGbdugZDtbPy4DBNGhcgKjt+bTiFd+rPmEQ9QwfWPdWL0mdP4MAQD9ZYKtYZne4/vKatenJodWQivPkBsqrA08X64COS02SDyibBms0VqAlR3HTZqIT8PJui6dWPlvlls6QqtvdgLV3Rxizdzafh9VOE/ifmCj0OqY04LZAjVI0F1jZ+KtOFLXu4WVM9/3GXO4nfadeCIiZkqa1+bRjrvcsREtpCaXwwF+mOqlA4qs+5j4zJenrc/WDCqn2+ZemiT9m3XKRZGiQqMMdqOWZ2vqRbv0QHHyPvOOcPR1ow+4L+AByEFMY0SGWF1r8QEvkGW1E2o/EV3rx/P+1IWR59Ws2E/zum2gt1Uk7FhO7/smzlbvX4pPq5Av8kwwfexBtJH4DnYxTqSFFjj0L+V/mIVOsviLwh0p2w7XKgxIncwY/5sfoBM0g7ReRtZ/8krZiUmqVyWXxigcpLJ1RmpQ/n4B/NlVqtme/9JIMSPhWmYhNz21QriMTv7Tm72LCwNkxYnhJhu7EC4RfPBvWHoSt3ks8RFt9JABUXtJYPmZ9Uiy5V8j08mCFNPQoMhpMjXfSCrqgWZXHG+1nwE0ocSO/d3Ciu/fvXGx4RCJuQKie4pCFCRHR1GwVxt9c5HtwM758KIXx011BoQXCMhn65DgFTZPHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(786006)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDQvdmNTQmphQ1pzckV0MGYzelYrMzZyUG9ZenQ4bS9ZeERSY2lZK2kwK3lo?=
 =?utf-8?B?QitOM3VTeElGdWZkSndsZTFWSis1TjdBUEU5eFlrYXF3WWZKeWJkcDJrQmpP?=
 =?utf-8?B?ckU4RmFFZXZTQ3hEYVVsU0YvT2szUkxSRXVrcHBOdkZheVU3V0VxS3V3Q3R6?=
 =?utf-8?B?cWl5eGJhNXVBYVQrTTRPZzF6WmMyWFA2clpicjc2VnpXWkpYbUJLNlhWZytm?=
 =?utf-8?B?MGxCVU5wZDNFR215RmpUem9nQVZmTTk2NkdRQkUwa2VRYVN4UHUzZVhGbWcy?=
 =?utf-8?B?MWQvOXFNMjh1Tjh3TlZqOEphdFVUY1lDTnV6M3VHZllOM3kvL2hIZGFEVGpp?=
 =?utf-8?B?UVl6WXQ3dldWd2xQUDdiWXRrelg3V2ZNRXAxSlEycUhkQnZ0Q3d3TDB3S2FC?=
 =?utf-8?B?cXpPcnI5TnJ3bWdUaEk2MHg0aHZBS2IxVVJtWXJvM1k1RitDTCsvakVuN1Zr?=
 =?utf-8?B?US96b1VFRDZYRExEakRFZ0xhTHdTQTd5b1NjYmJpdEdmTmRSN25mdGFmNkpM?=
 =?utf-8?B?SXhsbldyNytRWHp4K0RBTFUzcmdHNUMxVmhBVis1YlNrWUVCOXZ5Ui9rdW8x?=
 =?utf-8?B?NXRtNWJNdEVRTEl4L3hLMC9tWTRqRC9ZelZsQVQyTEwwcTkxN1ZMa09VN3Br?=
 =?utf-8?B?eTBNcVFaMllvVEhzbEZsVElpSjdrQ0lJclJEUndLeUtLN0hmeHJuRlRXRDFw?=
 =?utf-8?B?TFZGQ0pFTkhJV1d4YmlDMVJOZC82dFVKZFh2RTNrZXFnZzkxVGVxL3hEd2Fw?=
 =?utf-8?B?SEg0YkZacis4aGVDNmdaVUkxbnVEb2FNWVEvellMM1RiN2p0TFJRVlRZR0dw?=
 =?utf-8?B?R0hrL1UrcFFpTEY5WWJJdXgzTEZybS9xaXpCRHFSdXU1Ynl3d0RDSU5DOWFY?=
 =?utf-8?B?UndLUmQ3UGRXZllnZlRUNCtzRllFNDJRbmJnOVhudEVrMGFOS0JSVnBOU3ZW?=
 =?utf-8?B?U1hIZEpvaXUvN3pwWnVudUlSdkNiWWhkTzRSRnBRSW55YW5UYVJraDh6SDA0?=
 =?utf-8?B?Q0grMXV0R0VyaTE5Nk5JSDRYZkR0RzVoN1BFeFZ4S3VJczhJTVZEZHBzT01r?=
 =?utf-8?B?YTNHaWF3V1pzTXl3Z0xWa0d2dGZNdHFtTlFuNVJQbG9zUWwxZExVSDBteXd6?=
 =?utf-8?B?YTNBRjNVcXU3cHIvc3E0eUtxa0FDUTB6NFJXdzB6RGt0QkEzek9heEJuSElo?=
 =?utf-8?B?bFNtTDVjeVRTK2YwWkF1THB3MUpPSllVdlBZcEZLTUVDbW1VZ3I3MXBpUm1G?=
 =?utf-8?B?VjUxMkxVT0pvTEVFQTZjNVU0aWFublZ2WFJGNkU2b2tGY2o2Y3hrRm9FVjRR?=
 =?utf-8?B?Rnd2bW54bVZVQ002WGNFeEppRFNzMmI0eE0wY3pLVStVZTR1SGtLcFp3WmFY?=
 =?utf-8?B?TEdlVW9pR05JWktpRWVqY0ZDU2x6SkRsQ1ArVE90TXRHeWI3eXVraDRYM0k0?=
 =?utf-8?B?bmpSR1V3STRuU1BVSW56MExzSzMrek45cmlXN3ZNWVUvU3UrOUQwanNJemJY?=
 =?utf-8?B?MU5uS2FaTmgwSDd6RDcyRjk1bi8vZDBpblBnekU4MDdUdUN4WkR6TU0wWnlO?=
 =?utf-8?B?QVhMSzkvWUNUM3gySUhMMWc5TytDQ3NmaHQ4Y1NGUE55UWowOTlOZU1nNDlI?=
 =?utf-8?B?MlZ4bHZmc2Iydmw4Ly9rdHRjYzdvZjZMM2FBbXBaY3ZibVZIc055SmVmT2RS?=
 =?utf-8?B?YTJKcEZYQVNiVmU2THZLUDV5QVFoTWhLY0ZmUHV6VXpPdTZRcnIxSEEwQkow?=
 =?utf-8?B?MGFpVVhMUjhQbkNoWmdVV3lvVnhYcE0xY3R0QzljdlpSaWszeDd0d0orOHF2?=
 =?utf-8?B?ODdhMDFXQndDWFdsTjRsU0FSWWVhSnh4K0Ztd2oyWmpGVHBNWUtqWURmNE9l?=
 =?utf-8?B?ZGlFVlVIODhTb20xdTh5eTNaaEdBZ3F1Mk9ubStmbjgrSnpDd3JwRjZhdTVU?=
 =?utf-8?B?SzQyaFlGQWhTZUtoOHJLY0dyZk9xOHFWcDBhYUlCd2lTSTlJeVpkbEpDY3NN?=
 =?utf-8?B?RHdYWG1zRHI2Sm5sQmhHOUMrcXBsanUyRkNqcWcvVlV0MTVIVmpsNzdPZzJT?=
 =?utf-8?B?WGtXamNGTXU1TlFsWDFuQ2R0NFpGdFEwL3Y4RVEzRmhPNzNJMlVmUitGbGFa?=
 =?utf-8?B?cjRYSTFXQXo4aUg4MzUyWmJxKzdxUm5lZmVEOTRuanRpeTBsa2RMa0prUGEy?=
 =?utf-8?B?RHFkOEtWZHBQK0tqOUR1MEgzU1NVY0dlY2JhM2VlY0d0UmV3Z2RqcXZnbUpD?=
 =?utf-8?B?SmhkT0t4RGlJL0ZhV0RTQzYxV3AzTVVCR3IrRnEzalBDVG0vUm50bHd1dFIr?=
 =?utf-8?B?aVUrdHVPQ3hsM2ZBN0RzRlBLTUpkdmJiK2hWeEpEb2ZNUTkrc3BSZz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: cb789480-84c1-48da-4640-08de7e79968a
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:49:41.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyxhfAlNz0ZD7IcouyWlDaFJkNPM6dorbdX2jIFEeUaoyTmjmrNndoZr1Ik0UN98ZDlbAyLwzSy5AQN5K1FXRD5aBpdGT1mEoM/uaiumWKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0087
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

--------------ms090705010101090805080203
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2026 18:25, Pierrick Bouvier wrote:
> On 3/9/26 9:21 AM, Florian Hofhammer wrote:
>> This patch adds docstrings for typedefs and function declarations in
>> include/plugins/qemu-plugin.h that were previously missing. This
>> resolves inconsistencies in the docs, e.g., the description for
>> qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb=
()
>> but code cache flush callbacks not being documented themselves.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>> Hi,
>>
>> While working on a QEMU plugin and browsing the online docs at
>> https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed tha=
t
>> some of the API functions were not actually documented.
>>
>> I went through the include/plugins/qemu-plugin.h header file and added=

>> docstrings where they were missing, hoping of course that I documented=

>> the correct functionality based on my understanding of the plugin
>> internals.
>>
>> I hope that's useful and I didn't miss anything!
>>
>=20
> Thanks for the effort, that's always welcome to add documentation on a =
public API like this!

No worries, it's also helping myself when I look up the APIs :)

>=20
>> Best regards,
>> Florian
>>
>> --=20
>> Florian Hofhammer
>> ---
>>   include/plugins/qemu-plugin.h | 98 +++++++++++++++++++++++++++++++++=
+++++-----
>>   1 file changed, 88 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plug=
in.h
>> index 827e8e1787..fcf5af52ed 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {
>>       QEMU_PLUGIN_CB_RW_REGS_PC,
>>   };
>>   +/**
>> + * enum qemu_plugin_mem_rw - type of memory access
>> + *
>> + * @QEMU_PLUGIN_MEM_R: memory read access only
>> + * @QEMU_PLUGIN_MEM_W: memory write access only
>> + * @QEMU_PLUGIN_MEM_RW: memory read and write access
>> + */
>>   enum qemu_plugin_mem_rw {
>>       QEMU_PLUGIN_MEM_R =3D 1,
>>       QEMU_PLUGIN_MEM_W,
>>       QEMU_PLUGIN_MEM_RW,
>>   };
>>   +/**
>> + * enum qemu_plugin_mem_value_type - size of memory value
>> + *
>> + * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value
>> + * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value
>> + */
>>   enum qemu_plugin_mem_value_type {
>>       QEMU_PLUGIN_MEM_VALUE_U8,
>>       QEMU_PLUGIN_MEM_VALUE_U16,
>> @@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {
>>       QEMU_PLUGIN_MEM_VALUE_U128,
>>   };
>>   -/* typedef qemu_plugin_mem_value - value accessed during a load/sto=
re */
>> +/**
>> + * typedef qemu_plugin_mem_value - value accessed during a load/store=

>> + *
>> + * @type: the memory access size
>> + * @data: the value accessed during the memory operation (value after=

>> + *        read/write)
>> + */
>>   typedef struct {
>>       enum qemu_plugin_mem_value_type type;
>>       union {
>> @@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(str=
uct qemu_plugin_tb *tb,
>>    * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
>>    * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
>>    */
>> -
>>   enum qemu_plugin_op {
>>       QEMU_PLUGIN_INLINE_ADD_U64,
>>       QEMU_PLUGIN_INLINE_STORE_U64,
>> @@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void=
);
>>   QEMU_PLUGIN_API
>>   void qemu_plugin_update_ns(const void *handle, int64_t time);
>>   +/**
>> + * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback func=
tion type
>> + * @id: plugin id
>> + * @vcpu_index: the executing vCPU
>> + * @num: the syscall number
>> + * @a1: the 1st syscall argument
>> + * @a2: the 2nd syscall argument
>> + * @a3: the 3rd syscall argument
>> + * @a4: the 4th syscall argument
>> + * @a5: the 5th syscall argument
>> + * @a6: the 6th syscall argument
>> + * @a7: the 7th syscall argument
>> + * @a8: the 8th syscall argument
>> + */
>>   typedef void
>>   (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int v=
cpu_index,
>>                                    int64_t num, uint64_t a1, uint64_t =
a2,
>> @@ -836,24 +871,61 @@ typedef bool
>>                                           uint64_t a6, uint64_t a7, ui=
nt64_t a8,
>>                                           uint64_t *sysret);
>>   -QEMU_PLUGIN_API
>> -void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>> -                                          qemu_plugin_vcpu_syscall_cb=
_t cb);
>> -
>> +/**
>> + * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return ca=
llback
>> + * function type
>> + * @id: plugin id
>> + * @vcpu_index: the executing vCPU
>> + * @num: the syscall number
>> + * @ret: the syscall return value
>> + */
>>   typedef void
>>   (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned i=
nt vcpu_idx,
>>                                        int64_t num, int64_t ret);
>>   +/**
>> + * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry =
callback
>> + * @id: plugin id
>> + * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t
>> + *
>> + * This registers a callback for every syscall executed by the guest.=
 The @cb
>> + * function is executed before a syscall is handled by the host.
>> + */
>>   QEMU_PLUGIN_API
>> -void
>> -qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>> -                                         qemu_plugin_vcpu_syscall_ret=
_cb_t cb);
>> +void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>> +                                          qemu_plugin_vcpu_syscall_cb=
_t cb);
>>   +/**
>> + * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall=
 filter
>> + * callback
>> + * @id: plugin id
>> + * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t
>> + *
>> + * This registers a callback for every syscall executed by the guest.=
 The @cb
>> + * function is executed before a syscall is handled by the host. If t=
he
>> + * callback returns true, the syscall is filtered and will not be exe=
cuted by
>> + * the host. The callback must then set the syscall return value via =
the
>> + * corresponding pointer passed to it.
>> + */
>>   QEMU_PLUGIN_API
>>   void
>>   qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
>>                                               qemu_plugin_vcpu_syscall=
_filter_cb_t cb);
>>   +/**
>> + * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall en=
try
>> + * callback
>> + * @id: plugin id
>> + * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t
>> + *
>> + * This registers a callback for every syscall executed by the guest.=
 The @cb
>> + * function is executed upon return from the host syscall before exec=
ution is
>> + * handed back to the guest.
>> + */
>> +QEMU_PLUGIN_API
>> +void
>> +qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>> +                                         qemu_plugin_vcpu_syscall_ret=
_cb_t cb);
>>     /**
>>    * qemu_plugin_insn_disas() - return disassembly string for instruct=
ion
>> @@ -861,7 +933,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_p=
lugin_id_t id,
>>    *
>>    * Returns an allocated string containing the disassembly
>>    */
>> -
>>   QEMU_PLUGIN_API
>>   char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
>>   @@ -888,6 +959,13 @@ QEMU_PLUGIN_API
>>   void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
>>                                  qemu_plugin_vcpu_simple_cb_t cb);
>>   +/**
>> + * qemu_plugin_register_flush_cb() - register code cache flush callba=
ck
>> + * @id: plugin ID
>> + * @cb: callback
>> + *
>> + * The @cb function is called every time the code cache is flushed.
>> + */
>=20
> Thanks, I was thinking to document this since someone asked a question =
on IRC a few weeks ago.
>=20
> May you add here:
> "This callback can be used to free resources associated with existing t=
ranslated blocks in a plugin. @cb is guaranteed to run with all cpus bein=
g stopped, thus no lock is required within it."

Ok, thanks for the clarification! I wasn't aware of those detailed
semantics, will add it!

>=20
>>   QEMU_PLUGIN_API
>>   void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>>                                      qemu_plugin_simple_cb_t cb);
>>
>> ---
>> base-commit: 7608a95d2e0bd8c8d069ab77824d02586dd94648
>> change-id: 20260309-add-missing-plugin-docs-159d7ff315f9
>>
>=20
> Regards,
> Pierrick

Best regards,
Florian

--------------ms090705010101090805080203
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDMxMDA3NDk0MFowLwYJKoZI
hvcNAQkEMSIEICAOB4y7HC11gBsfMNILQzxuJwb6wj6e2rnfC6VKw6OUMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAENOP2Pf2WWK+nhgFWhavc1YnDP/
QzEDHVIWA9ErzfPZrUi2K6GF9D5F3Udukmwo62S6HeePN4ZOG1VKtum06wJqs6rs0vBNqLSc
Ywwplqttnf6mv/NDrcDBZy8fixxSA0w7aJNmVWXvIs6jtgTj+11ocsDPq2dj1TIOEaC9iXJR
kx/WSSBDFRHYDsKNNhmWkWzAQRxpy4lltmpPYYRQY3t6V/VxytCnnxJGVzij3KjAOOECo5eU
3kVardoa7+uI/vcgFa4zPcxnlJsb+O3tiJoOX8l5JY9HnLuyL8ZqndEJsIWe3LbMy46bVh1/
/I/zIZPn/gkOC+D8trepgB/TmfAAAAAAAAA=

--------------ms090705010101090805080203--

