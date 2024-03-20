Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA8C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyDO-00012b-If; Wed, 20 Mar 2024 11:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyDL-000120-DJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:50:51 -0400
Received: from mail-db8eur05on2111.outbound.protection.outlook.com
 ([40.107.20.111] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyDJ-0007TE-7O
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:50:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4R9vWQl625BAUnInnBHHUGx6XDyYPZPsyXBIg+v+Syukcv3S0PY7InQy6ATiwmbTR3jp1CHA3Zr7uExVddqPCnavhQcBceT0OTY76M99Mj2UmvWDfw2YRYbfgNS8JO6HWGAtRNpbRAlOqILQJxR4snoCEfPI2Y6X30P719hp9KWgUZUNRVSULxWjANiYe+L6RLy+b0ulnF7dDdYCsCWX06eTCC5OE7rH/+rlRAsJu5ss9sMHspOc7nS9+Q0TSNipd2Bpd2TZayNmr6FuFSSnqKCtTFKYDwSvPP0FftV/hRwjHxUc2DM/8aBKryfcJNgE5VqtA8mOvMsI9hW5wxgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtFcD+gsVPN36rZ4if3QJ5ZM8uZp0qzE5FfpOgqZR7A=;
 b=W7PHEiQhMdImOKcISVp+yZFq7Ztg6cNHjZxF0jDf+3YeR4OCHfEMtBz4F+7y2/R0rqVBWUkuxICKn2H/b0lyYbfaznbN+qsc+cu5EnuDgXZsIpX37tPG07gcROgH1EuVSPjcm8zmYSsH3qv/7gHMtCSiYBG6bT7dDcxxUcGoUPuahgKAj444Kw623CYWkQnX0436RFLdBseIcPvhDvmrdy9y4Dr5vFa2a5Y9S3fafGAKhnd4ZB6QDzpcLF6jyYIAVmAvGiPbbbxV/bsWIeEUGNHvwGMJxz+UJ1qQ+H7c5Bl19UZL06YGUZbHrX/MrDjZHSBZFH0W/EEZoPGiZmj+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtFcD+gsVPN36rZ4if3QJ5ZM8uZp0qzE5FfpOgqZR7A=;
 b=I9n1Mt9BBRXDII4YkhUrcvaKEQ6u135Avnmn3Cy6yCNmJL7sVqap1P0xmHHDEauJA7fnM8Konuaciu7EAScgctRE8d8EUn9obplC993EnDGkKvRiF8LTGEckFgLSGkSxlUdvGd+mvG/wMmjw9cVh9lppGBjijK7j9NOcTGV81wST7+r+M+G1z4EKRfL8FIL/rzvxdIOMgQcTAwQ8w6rL+2LuEeSr3jDN+PLTrF1pKS3VI6q0wD1K0Aw8kTuHEMTXDlrn0gCAf+KqbKx48+l6d2Pa50zY0NOm7AUQGmPpiQbRfTU5CJT+dx8gak4ocpLhpDBqEuUHxWwiPsxFZ94JMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAVPR08MB9700.eurprd08.prod.outlook.com
 (2603:10a6:102:31f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 15:45:38 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::787d:7732:63b:ff4d]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::787d:7732:63b:ff4d%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 15:45:37 +0000
Message-ID: <6abcd883-cb0d-4b11-a82b-33c515f7d4e6@virtuozzo.com>
Date: Wed, 20 Mar 2024 17:45:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-root' field
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
 <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com>
 <ZfnNbpubB0HpFDnj@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZfnNbpubB0HpFDnj@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::22) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAVPR08MB9700:EE_
X-MS-Office365-Filtering-Correlation-Id: d54260ed-e000-426f-c889-08dc48f4c9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLuZXC587s0wW7s3sJLxT78dP1WJwsftPiH1icdoAmWGkYNOQD39HjxJoVzaqfOMc6z8zHv4C3CUC3iih1f153S7Qu4sWbClAZ6fqBk6n9ZyAAN969KMjZYO6ftSceOLX57HBMPIi2xBg5VsFpIub9QuEQuEJWqzI50syehS2qE/EC9mqkaj35rGUBFWNBPtgRbfIR7CtYhm2nL2s29AYQ9cCjdvVApUNmJfltCbjrUXxPcQsWSKP4mzXE+FkBmjgluMJYsLRdkfpQnKA30mA58U5UFT+oxmVEtvl3ZwfBfcKr4z7hrdvSLJt/Hbl4R4WiS/3S04nVnoPniXI/rnI8uXcUQQ2b3TXQp7+rvkcWzG2qFrI8t360dyQYcPlEoYNwB8VpUKSx0SBNWBps+I2FzokMyunwBjI16Aia5fAuvolvDdwtNDKd95afCTFfSGuzcZTVxe1+76C68EE4zy1EPItF0C69U8mk8soVZphyCPJNcdndDXzHoRe9YYNLYc0+1GXjjJUxHEqJGrE2VtSQhvnDubzxP1Ddp3xeW15LDPyOMWRKrFO9auJjazawSj6Dl9+LUwCqdcef8AyBHD/SibnclxtqieWo2pSy5VJUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG1QNFJVQnlOekdMclNGUEs3MXl0SUhYT3ZMSVBQcTF6WUhyajg3Vkw2TU9t?=
 =?utf-8?B?VmRJeFB1QlY5S1h6UXN4ZnoyQjllYjB0NnhxVFJnTVhsajNWY2VSZ3N0cmlL?=
 =?utf-8?B?bXJEZWVRZUp1THk3cDJ6SkQwdnE2L1l6S2NsWDlvWTJRL3VVTEg0ZUttQzhG?=
 =?utf-8?B?c3dTelpPT1J0bGlaWTlTOWt1RnI1VXlLWTRGTDJoVzRlYS9SbTZBOStNaVIr?=
 =?utf-8?B?YnRuZGo5clhIOXo5OFF1NkhHcnVkcjZ1UDZJL0FFV2g5eFdXWUJzUXlBWHRu?=
 =?utf-8?B?ZElUaStNOGMrRHgrVVlTZ2VoYzNTQzFhdjZMYThycEo4M0VHRFF6d2c4MWw0?=
 =?utf-8?B?Y3lUS25ZeFllaE95Z3FvUXBaNmZHa2taTHR5alUzK3NGVktmek1RajdlTFFl?=
 =?utf-8?B?cC8rcVNqWEQraWhlT3MyRkg2QTNRNGZkRHVqNDJUdGhhRm4rZzF5VE4zNDg1?=
 =?utf-8?B?YWJtaWl1ZlJPeHIxSWdxam0vNjBOSGNzb0MwaWNyNWdiRmZYMURXaVE3UTJU?=
 =?utf-8?B?UVBJcXcvUWIwVFRtdUxEcEhpY2g3QTRQdjA4TG5RY1N2S01kcWxIRzhXZjA2?=
 =?utf-8?B?QndiNERZaGZYTjdIb2MwV2N5cFBSYklxckRRcFFvRUplbG9oKzlmK1Z6emJh?=
 =?utf-8?B?ZjJCYnJzZG9mRW1uaFdMUEUrc2U3TXNNUVRBb2tMY0RpNmx3KzdQenRKSFVS?=
 =?utf-8?B?Mm9STDg3R1h5T0NpYmphVWZVejhGVmpzeitUSmYwbHJSOFRuVHk3OEE4NHJV?=
 =?utf-8?B?cTBBYUdidXRYNnpWa2dqaFpFUmxMdCtsNDZHOEh2MFBoYnZjbnQySkc3djAw?=
 =?utf-8?B?MDBoVkZMaXlhaW5ENnY1ODljL0lQanhaWXFvMW90Kzc5czhoRGFzT1A3ZlJF?=
 =?utf-8?B?QzNxVk04bXFlWFNEeit0TW1SbThtbVdMV0FlcWFWNUowbG9nYXRkTG9PMUxu?=
 =?utf-8?B?cHpnbjRja1lWMWUzM01pdDFUajJEUHM2WkRWTk1jQTYwamZ3YjJCS3VaUTkz?=
 =?utf-8?B?ZEtvdklBOWFkQUpNOFJtMkxVNkdsZVZjN0RqSTZUNjdQdXduOURlK0hvaFBK?=
 =?utf-8?B?WHM2dUFMWE8xMkJjYUtUUTR4NmJ3TzRUSXVlRFY2WlIxVm9yckZOWit2SFdX?=
 =?utf-8?B?L3ZJNFRsUzhNT2M4SEYwSjFmR011WTVMTCtrRklDTzZqRmtlR1F6K2xKNmtp?=
 =?utf-8?B?Y0ZRTzNxbVBsK2YrTHdtWWhQTmNhbzkzM3NmdnhFeERJNmw0TmFSd1ZITGxB?=
 =?utf-8?B?aXl4RWRYS1dDeFFDMklNY2ZFcEIrUmppc2ZOSUcyT2FVRnNHUGxWSG9JWkZo?=
 =?utf-8?B?dE5zejBROS9YMU5zd2hiVHJ3bEdGYStKVXkzWUxsMU8rT0RIZFVqbDVzNFhr?=
 =?utf-8?B?djVEMGVPZTdzWU9Cemw3NmtlalVDN1RXbmdUNktBR2hTQ1V4S1FCNzB5cTJR?=
 =?utf-8?B?K3lFUXloT2RTSFIwRlNHVUhPdjIwOEFGSGtnL3BuUHQ2eStGZUxKQTdzYkNq?=
 =?utf-8?B?VFBoZHo3aVRUTEpEWGM4VkRmRVpIRjhaeTZrdk5ZR1hXaXFKK05UbWtsWWRZ?=
 =?utf-8?B?RXgvbTN4THQyeUg1OFIvYlNxZHdQa2JYY3EzY01nbjBEK2dhMEJBVjZtcHNs?=
 =?utf-8?B?czhSdXN0cUlGV0IwZUo4RE5lNjVLZjdFRnY2MWNMMmQrTVpIQTF3cTdZWXQ1?=
 =?utf-8?B?blNlWGpuMnpsaGxBbmFnYVl2aVgyQnVqMWJFTTVaNWsxcGNDSHVwTWNsMUJn?=
 =?utf-8?B?TnJaSUpqdGY1RlpRNGp1MDdHMmtUaFpHbHoxSEFWZFZPOGFKYkc5aEpKKzMz?=
 =?utf-8?B?VjhvUjd6UkR6aTl5WlBCWmNlZE96VkpCSWNadkpyOTdxdjFsY0NjcHk2RWFY?=
 =?utf-8?B?c3Q0YVNTUDVHZFNtOHllVURoeEJwcXlWQzduQ0k0eDc5NEZUTDA3blFNaTdD?=
 =?utf-8?B?OStWcmFJUHNzY2dLMnNqNGMyVWdMZ3pLTjc2cTJibms3SlF4NmFvekVCZnY5?=
 =?utf-8?B?OWZNenp2b2VvK1hFOE5DalVteExKR252RllUMHFURlo3RTNpTXhaekt4Vlov?=
 =?utf-8?B?S3RYNm1abjJ0V1Ftd0tnSzJUMVR0eVk2YWVLRC9hazQ5VlhFRXUxcHlWVTJq?=
 =?utf-8?B?TXdpUTNLU2xZdHRKd0VzbW82QTFVajFXUndkWk1YdjZsWnFaMExFV1RxY2tz?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54260ed-e000-426f-c889-08dc48f4c9e5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:45:37.7621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdLRAvnx2byZUJXvVbx5xtygLgV2obEUMYovi/1qPsLuyyR1AONGwbjS07WmXdiS7q+KBnf5GzzETg3iugcKflZErWbJrViXEmaNeORte5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9700
Received-SPF: pass client-ip=40.107.20.111;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/19/24 19:37, Daniel P. Berrangé wrote:
> On Fri, Mar 15, 2024 at 02:29:40PM +0200, Andrey Drobyshev wrote:
>> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
>> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
>> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
>> returned by statvfs(3).  While on Windows guests that's all we can get
>> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
>> total file system size, as it's visible for root user.  Let's add an
>> optional field 'total-bytes-root' to GuestFilesystemInfo struct, which'd
>> only be reported on POSIX and represent f_blocks value as returned by
>> statvfs(3).
>>
>> While here, let's document better where those values come from in both
>> POSIX and Windows.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qga/commands-posix.c |  2 ++
>>  qga/commands-win32.c |  1 +
>>  qga/qapi-schema.json | 12 +++++++++++-
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 26008db497..8207c4c47e 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>>          nonroot_total = used + buf.f_bavail;
>>          fs->used_bytes = used * fr_size;
>>          fs->total_bytes = nonroot_total * fr_size;
>> +        fs->total_bytes_root = buf.f_blocks * fr_size;
>>  
>>          fs->has_total_bytes = true;
>> +        fs->has_total_bytes_root = true;
>>          fs->has_used_bytes = true;
>>      }
>>  
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index a1015757d8..9e820aad8d 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
>>      fs = g_malloc(sizeof(*fs));
>>      fs->name = g_strdup(guid);
>>      fs->has_total_bytes = false;
>> +    fs->has_total_bytes_root = false;
> 
> Can we use GetDiskSpaceInformationA to return this information
> on Windows ? In contrast to GetDiskFreeSpaceExA(), the
> DISK_SPACE_INFORMATION struct details both the real sizes
> and the current user available sizes.
> 

It seems that this API has only been included in mingw64 recently:
https://github.com/mingw-w64/mingw-w64/commit/66546556

Apparently since it happened there hasn't been a new release of mingw64,
so the latest version v11.0.1 still doesn't have it.  So I guess we have
no choice but to leave Win fields as-is for now and switch to the new
API later.

>>      fs->has_used_bytes = false;
>>      if (len == 0) {
>>          fs->mountpoint = g_strdup("System Reserved");
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index b8efe31897..093a5ab602 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -1031,8 +1031,18 @@
>>  # @type: file system type string
>>  #
>>  # @used-bytes: file system used bytes (since 3.0)
>> +#     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by statvfs(3)
>> +#     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as returned
>> +#       by GetDiskFreeSpaceEx()
>>  #
>>  # @total-bytes: non-root file system total bytes (since 3.0)
>> +#     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
>> +#       statvfs(3)
>> +#     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
>> +#
>> +# @total-bytes-root: total file system size in bytes (as visible for a
>> +#     priviledged user) (since 8.3)
>> +#     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)
> 
> I tend to wonder whether it is really a good idea to document
> our specific implementation details in the public API
> 
> I might suggest
> 
>   @total-bytes: filesystem capacity in bytes for unprivileged users
>   @total-bytes-root: filesystem capacity in bytes for privileged users
>

My initial intent was to get rid of the necessity to dig into the
sources in order to understand what those values mean.  But since we're
discussing changes in the implementation, I guess it is wise not to
mention those details indeed.

> also should we call it 'total-bytes-privilegd', to avoid UNIX specific
> terminology.
> 

Agreed.

>>  #
>>  # @disk: an array of disk hardware information that the volume lies
>>  #     on, which may be empty if the disk type is not supported
>> @@ -1042,7 +1052,7 @@
>>  { 'struct': 'GuestFilesystemInfo',
>>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
>> -           'disk': ['GuestDiskAddress']} }
>> +           '*total-bytes-root': 'uint64', 'disk': ['GuestDiskAddress']} }
>>  
>>  ##
>>  # @guest-get-fsinfo:
>> -- 
>> 2.39.3
>>
> 
> With regards,
> Daniel


