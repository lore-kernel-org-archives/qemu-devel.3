Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED3DC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5U0-00020H-FA; Fri, 15 Mar 2024 07:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl5Ty-0001z0-J3
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:12:14 -0400
Received: from mail-am7eur03on2102.outbound.protection.outlook.com
 ([40.107.105.102] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl5Tp-000721-Ak
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:12:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCxFTawbiVUBCRzSVGZiSB+V0ktXY5ztCzCmB+UixI6Cgir0q7xbaYKhp9HMh+KdB7oyJml7m9RvLkWYHvDZErZGDe3fysRLU8FfLWZ0pNK8IG8l7h3NBTYfop9tAilqBbk8H9g9KGz9l7SS8YR8nhLmDhzpoQftOLlYDu/SSDy+o/VAXQH3AGZfxk6X/2QApUnyiHkz4OOTRVDAo/oOvkoNpeELaeYjPltwRXwyjYsseKQwpodlacLvHIYAfVJ01FCIVUbbQhQPqIjpbuRqfdTKupfZy569KrLU27Vg3Fyc8Kxh7keZn9+qEGNAAl3XMtTvxWg8Dg7fI9Hjm1CVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLw/ud88ElIVaAW779Eth2SujWWUppS1bb1ZhKtAIXk=;
 b=Ictk3pMwkcVxAA3fXfQn8w2Zr7mXI/qr1+EgErvaGZ/FlSeLpl/kjrysJXnn5ho+j1697p31vQ6k1B1ChPBApOZIVOLOFXY4z8BdE0AU5h3zVb/6nRbXa8naXnJ/lE6RHJxXTTY3tCJc2S77CXsSnPjGXZt9nVQF2hmSnZk2HKEmUiqmIwo/HzHt1ucF02RU5Umb9a5S/yrPQQIkU6saqSAt4Z6UD/e62tWdkb8VsLb1e6N7bkGZW/XZ7fH23wcFnqO4EhQxqsxMfbhVwCC6B/DCsiQhvgE9WX+3C89RqGftt2AS5Y1khnf9HiymO7Vv9EQOcUqsaLksSlEXJ9/fIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLw/ud88ElIVaAW779Eth2SujWWUppS1bb1ZhKtAIXk=;
 b=DJ8SCDystZ93dANKZEHpTeP8Y7RgJO3cwiZSQ1wS0GIZvUR+gTbIQvnVWbHwrw+9/mGV0Ue5sBLLTuD3Mci3i/3+iiq2c3P4GO4Pedb/tWsb/DNw+4VNGGgLGZDBH5jbaJ7Q8vYlUhfP85mcEWaikFviz87dstxpZz7ZDgWaMLALqmn8XbHqegMBqloIBQ6MI0DqLctltqE621idC4DnQO3LVP4aZ1sOnnKnZU/OFu6EGbfIW21KBbc8Tfoa6X74pz7r8wMFgkXngqQZ8GTaU0vzpOQz7CG2uxN2K96FPvo4UHwMOfAHyZKr6nil4rosKKC8arzv2y0V/rOJhSv1Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB8106.eurprd08.prod.outlook.com
 (2603:10a6:150:95::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 11:06:55 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 11:06:55 +0000
Message-ID: <00c7bc29-6360-4c7a-a112-bd827c6cdaa3@virtuozzo.com>
Date: Fri, 15 Mar 2024 13:06:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] qga/commands-posix: qmp_guest_set_user_password:
 use ga_run_command helper
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <20240301172858.665135-8-andrey.drobyshev@virtuozzo.com>
 <ZedmvqCQe4puhT3G@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZedmvqCQe4puhT3G@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bcd3fe-5530-452a-7f76-08dc44e0064d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSIGD4om1o4cy1bn6wgiioys5NyiZGt0tb4+XkVFF7i4H9Rf4N3mkMdPusL3ITjbPbOJwBJPwAEfbu6XgfYtHh8DM/+u3/5zCUxrHrYBYSeogshF/gMCtyZ4RUb15NZ+ECN//lxnoVkQH+d95rrrcX/3gdNzaOk1Jfl9VBy9fvq9ASRO+X0eHaxJGe3wDwokS8g2RVi0CfpM2hFA2GuB9CUII7Bg9g7UsFIEbb5vRBR0mBCTXfKubiHsGhCfSp63c06dgK92a3PgF0JIMREcd4lBbxp/2EWjO5TkVe0fhNFd8OGQzy8qIOetBfIL/8wwnAQgON+PvoOj/lL+Vv7MZhgazG3hJffcKpILGyQ67JiUGkYfD1RIYE/igQXJidOGTWcA1XZKeyy3cdB3X6+ftZbY1BJ4933EED/DZB+uMWDEfPzT7K8vupGsegLjTm8nXB//E00B57YuRBxBtOj6lKkoTsquehchZutBNPJX3VygZvj5+DafzVc2042lWe7e37kgkvfirs/F4VHjdr7BPo4p+ZAzZlDAjwC2bKEH+UPtKaiwHV/K3hpRMGjgAxlC0Ih7UsNe+EkBv864p2pLjY9OkbqUzV7Ev4hN/30v4Wdm6BjCzjnFvnAPb2Apu421tVLj8Obf2L7AmfM7SIoI/7vOuyxfTN528aut2ks95U0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEwxcXhXSnpJZ0thandISkhjYWdmVkd1M3haN0VFUjhKekEzMDVjOUpOUExC?=
 =?utf-8?B?WjR0enZ1RjFxa1pia3l0cmtuaTl0dWljT1Boa0NjNUhSUnBTVS9RWllPNFQ3?=
 =?utf-8?B?QnorVHdUTTUyc09Kb054b3loYUc0RTJPM2NsNlNiTFFDaHpzOWdNM1RndktQ?=
 =?utf-8?B?cjVNU0JpQnBFbWorbzJNNGV3azZzdkV3NzlzN0xnRUZ1WG00WGtrbnBsQTlU?=
 =?utf-8?B?QmUrc3RRWGJQT2U5VVJqME83aVR2R2oyYUNvUlpTWFRpRWRQaWVGVWZsU2Mv?=
 =?utf-8?B?K0JZb3BuK0VVUGttVVo3Yk5hOEU1WmlVbHAwM1JscWFvaVo1REpkR2xVNUxy?=
 =?utf-8?B?eWFqR2ZXak80eWFpYkVFWEFEYW4ycG5sMExDRHBBNmZHZGdIK0owS0N0V3V0?=
 =?utf-8?B?TlpuSllLanR2d1RBSThJNU43UWFsaWUybHh4cHJRRHR5Y0lKTDFVeHhVeUpB?=
 =?utf-8?B?T2RVMzBVYTZUdGxpS043cTBTYWhGZTV1elJKZVpSVi9YK0pCdmxFT0djdGtV?=
 =?utf-8?B?VjNWd2hBcmtnYjFvdTRUSjN0VlVwTjY5NnN4aDhlazhIcm44aXp6L3l2NnY2?=
 =?utf-8?B?UGxTM29zZVp5cUx5RDRYbHhOeXFZZUdYeTJQNVl0WllVRDRlTGZwTFdrQ1lZ?=
 =?utf-8?B?QzBsWXA0a1ZCYmZjUmpkandoMzMrV3NVSHFJM2owOEVDMlloVXdmZlZqTkpp?=
 =?utf-8?B?RjlWZ3JsTlE0b0EvN2JGclB4Yzk0YmpnZDJPd0dxNnhmekxzMmRJWVV4eWcw?=
 =?utf-8?B?V0JEM1M1RFFEcUpOTE9mOGtjWk1oZWQrRHZJSVpjS01MWXlYV0ZQQy9xSFM3?=
 =?utf-8?B?ck9QTUVYaWtaT1AyLzRDYWxlU1NyR1BVdU9DVzJQbENUbFI3QXo3NzZacGt1?=
 =?utf-8?B?VHFxRkZVMEVkTkRMenF1cnF0bGxFcnFYMDF2T1N6S2NRUUwxdTJLbm5GMy96?=
 =?utf-8?B?ek5DakJyTFRvcVJMeTJnNEwxRWErYkdkVm9NS29qYStDUHRScm5yRFBkaFpn?=
 =?utf-8?B?UXdlaHoveDI0ZktoeWhlbTRxdEl6WkNCb3JiaGJXc09LajhEanJzRFlHeHRm?=
 =?utf-8?B?SVgwZk5zbW04MUdoMFM0OW9aaU1qN3doWmUzejQxaVhoQVBUdm05RWtUc09o?=
 =?utf-8?B?cXJuRXR2T1VxbWNKM3krc3Q2SUlGajhoSFR5Y2w4WjB2YTVhR1dKMTl2RE9O?=
 =?utf-8?B?ckRJL2oxUUZkQ3hOd3Z3UGIwNmRJcmVEaDJqZlRKdURaUmxETXhwdUZZWm92?=
 =?utf-8?B?aVZsOG1EQVJMRmdVUm9PZGdxZC9kak5XMGw3M3FZK0ZmcWVvdmpoVG00VktT?=
 =?utf-8?B?VmR6ZFN5eFBWMmV3VjJzQ1ZLaVozc0lFVW5IcTZwOUFYeTNwbnZ1bGJDbU1l?=
 =?utf-8?B?Sjh1N2YydkQ4K0RXUVB3L0x2Zk95VWsvZ0NEbU9FWCtRT2gxSkpZWWNXUFFu?=
 =?utf-8?B?VDFma21Vd1lCcnpKN2lndDgzUFVEMzZxUTM2dkRCVWFyeC9WZDFGNkRRRkpy?=
 =?utf-8?B?K2FLRE1WUko4S1FqOWgrU0R1OWJnNi9EcDZ0YXpaY0pwdDhuWFpDSzhqVlVF?=
 =?utf-8?B?Q0VidlBkRmxqTWdzVkNyMHlUdEhLSmVZWlB1VC9hNG9HOTBwdWloZWQwYVU2?=
 =?utf-8?B?YnZiSFpKRnNGWGJWY1Z2dE5ZOGFRVVAwS2NkVFcxZkNCMDZZMmtuTlBlT2hJ?=
 =?utf-8?B?R3dtcWhKRERzZ2o4USs1Z3R2dDV4TGo5L3lhK0JNbG1idVI2OHdwVndMUlJ0?=
 =?utf-8?B?TlZ6dDJXQWl4RXk3M3Zyam1ZdE1ZM0pOT2pFTlNpanF4czluVm5CNHdvb2hy?=
 =?utf-8?B?UHdOK0krUWdWSzBWKzh3VWJLd3dXY3hoU2tBUG1QSzN4TTJFT0g5Y2ZTT0lH?=
 =?utf-8?B?V2xBQitqYVlERkdyNjlreCtCMDIwUVBTYnhJeXFBdkQxVC9tSVI0Y1UwQzBt?=
 =?utf-8?B?S2NEdzJoOEplSzdaSldkUDBoQzUxSTRrTERQUjJOdENOb3dzVExITnF2c1pl?=
 =?utf-8?B?bjhFZ2l6TnhtVkRPd2FYbmJ6ZGl6bHZKZ1pjSTlzajFRcVIxUEV3WHR1SXBV?=
 =?utf-8?B?WVhYLzFCVDBKVnUwbFp0dEJ0L2V6OGVmaGtZUVZ3TkswUXppTC9jRnphbzFP?=
 =?utf-8?B?ZzRtMk4wUGFyVjhLMElST2wxTkNBdXZzcXJDSEF6SHYxdnlFZGU5UnNyd1or?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bcd3fe-5530-452a-7f76-08dc44e0064d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 11:06:55.0418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWsuVxy08VdSNy//4/xYoR5McWKa6O0u8o63d0GQZd22x1jgRCBmfBrcX5lKoc/925nyxmInxGU9n5Bvp7KShD8trdial5XGiloHDf01kL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8106
Received-SPF: pass client-ip=40.107.105.102;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 3/5/24 20:38, Daniel P. Berrangé wrote:
> On Fri, Mar 01, 2024 at 07:28:58PM +0200, Andrey Drobyshev wrote:
>> There's no need to check for the existence of the "chpasswd", "pw"
>> executables, as the exec() call will do that for us.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qga/commands-posix.c | 96 ++++++--------------------------------------
>>  1 file changed, 13 insertions(+), 83 deletions(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index f3f4a05e2d..f2e9496b80 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -2144,14 +2144,8 @@ void qmp_guest_set_user_password(const char *username,
>>                                   Error **errp)
>>  {
>>      Error *local_err = NULL;
>> -    char *passwd_path = NULL;
>> -    pid_t pid;
>> -    int status;
>> -    int datafd[2] = { -1, -1 };
>> -    char *rawpasswddata = NULL;
>> +    g_autofree char *rawpasswddata = NULL;
>>      size_t rawpasswdlen;
>> -    char *chpasswddata = NULL;
>> -    size_t chpasswdlen;
>>
>>      rawpasswddata = (char *)qbase64_decode(password, -1, &rawpasswdlen, errp);
>>      if (!rawpasswddata) {
>> @@ -2162,95 +2156,31 @@ void qmp_guest_set_user_password(const char *username,
>>
>>      if (strchr(rawpasswddata, '\n')) {
>>          error_setg(errp, "forbidden characters in raw password");
>> -        goto out;
>> +        return;
>>      }
>>
>>      if (strchr(username, '\n') ||
>>          strchr(username, ':')) {
>>          error_setg(errp, "forbidden characters in username");
>> -        goto out;
>> +        return;
>>      }
>>
>>  #ifdef __FreeBSD__
>> -    chpasswddata = g_strdup(rawpasswddata);
>> -    passwd_path = g_find_program_in_path("pw");
>> +    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
>> +    const char *crypt_flag = (crypted) ? "-H" : "-h";
>> +    const char *argv[] = {"pw", "usermod", "-n", username,
>> +                          crypt_flag, "0", NULL};
>>  #else
>> -    chpasswddata = g_strdup_printf("%s:%s\n", username, rawpasswddata);
>> -    passwd_path = g_find_program_in_path("chpasswd");
>> +    g_autofree char *chpasswddata = g_strdup_printf("%s:%s\n", username,
>> +                                                    rawpasswddata);
>> +    const char *crypt_flag = (crypted) ? "-e" : NULL;
> 
> Style nit-pick - no '(...)' around 'crypted' is needed here, or
> the other place later in this method.
> 
> Yes, that was a pre-existing issue, but since you're refactoring
> the code, might as well kill the redundant brackets.
> 
> [...]

Sure, let's get rid of them. Thanks.


