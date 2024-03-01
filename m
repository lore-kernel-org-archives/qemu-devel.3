Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273B3C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 16:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6B6-0003G3-TQ; Fri, 01 Mar 2024 11:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6B4-0003FO-Jn
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:56:06 -0500
Received: from mail-db3eur04on2122.outbound.protection.outlook.com
 ([40.107.6.122] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6B2-0000Om-Em
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 11:56:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4rJq/LNCW4eJSb5aKq3+BNJg5Yv0dpqdsBx3SPoignh0rov7gjgMaN/FY1U/2ahrbV/dtCVAR3GJ3OnTBwcNBYssvYYIEpCX+AoJqoVJAEOGZZPn6pTBBq10r9cRiuihmCQlqIGXIV+X+iMxNKP4CvVpVpkwQCSFAHZj4qLcWCV0odshUmQ4acmtTk1AXulXg20gI/Smo8An4Pm01J8G35afs5eAIue6jC83/iAnnbNIiKudSg0lr/KvzPttGtk123vZImzfAvJYBWfFAHBnfare+sWlnP1IbTAwgcrRWNIKf6BnuV3arQeIC0Ir17kN+hNz6SyaxRhkLIaCIKnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABumhvyOuIG2NxpJ8acL1E0Gh5vVRx1noj+I6XnQw44=;
 b=l66Z1ztCjj5WtAWoG26KJJ+aWm8wgJAysUDC8eG+ZfTgYQuJYAtdW2+xuQIE043GyfblYA7ZIUnW67dlUnFgSbPkzc4RKuzBHisdtKV7TzTHdNTpTb5rzrD35Al1GhOCPvwf9jhe9BxYoNqb8sIr+3Cmd2qbqMXKtJwnjpEZaNKAzx9dKHDnQ8I+mkO5GGXZjc+wPA9xIY/pT0FVgI+71QveYS3wae/pDhhyhpmDYesaWGAJPYj/0v2w2plTXql/9kdN8du0BeNzufabdjcPSkQ0U9CfoXFhQd976wDhEIRnMdusjxy8dKhVwB9Gk68wqUHbowOmOkSHIoUSQhOVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABumhvyOuIG2NxpJ8acL1E0Gh5vVRx1noj+I6XnQw44=;
 b=P0KdA2msVs5dHaQs2aIHG68HgsHNapESlavYLtUS8F04Be35WGPAtXyu53DFs2hpOcL17ZDZ7U3VrU5vzggpyoFJ8wed9Ms51Fp4yCaYeNMfcwq5ebLzS9QE1GVdHTdQG7lcjmrkofpHZP5RomWydD5hcpMTZSGmg3uBwcmgeA1B+Sw+uDQjUkNafZiuGeIIea72V/VU0/2YtFFKJDdWIhRHE1lNorr0HzQnhRYNudFo7XlAFBOaQLtcd6639aje3vMIQw3JeGXef9vDfvRjGG+lnFr1yvUxEPwjT5Q6RYDKY8Tgthrk2ZPvoa+h43fzphbMiiEpAKHxJQPHPiMdKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9088.eurprd08.prod.outlook.com
 (2603:10a6:10:436::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:51:00 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 16:51:00 +0000
Message-ID: <87530747-5a61-41f4-9f5e-af49458a6a68@virtuozzo.com>
Date: Fri, 1 Mar 2024 18:51:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qga/commands-posix: return fsinfo values directly as
 reported by statvfs
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, den@virtuozzo.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
 <20240226165642.807350-2-andrey.drobyshev@virtuozzo.com>
 <CAPMcbCqf_fh67zRvarH2Y3tD-HPY=+O4nDC=6af+TGuMm1yj_Q@mail.gmail.com>
 <51cd548f-856e-402b-96b4-c8cfe1db30ef@virtuozzo.com>
 <CAMxuvaxwAqLyk6qF_=EHw0m-UOEcg6jRjVY-6=LdRdpYF16gvg@mail.gmail.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <CAMxuvaxwAqLyk6qF_=EHw0m-UOEcg6jRjVY-6=LdRdpYF16gvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9b9673-ee05-4bb9-a303-08dc3a0fc5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2UEHTYtaNnlMQQctqQXVx2bTog5Dz0osalbWyHx4369FNXNyBa9KwbHxZvO6oEXb1uOB5ze3gnGoDl5GALSdDAdLbl1OLpwe9kxP4A3HVIAhMoe+98wgBLhiJnJeUHjla4u4dshmnEv/+fzPPI55b1ESa8euYHER6IEEzLv0FLZKWkmkQggfc28fLfDVdxtOiePb1NiGmzrtCPicTFi6Ut2qDaHjAjgIWj5VoLM2PR6YsFWTNDL0Gw8aFGrhS0QZscUUIou3iGJTvNuMQkuxHgcgheB/8Ia+buCdRCaxW2xoVI/GzvUpFKPhzu2XJBzscyhdK/PrbtE+3JGFPAbyTSMxmjRQqfbjDEaGdor9xBfkO9BthBrxkUirtkmiuQciMqt5PsUECvrW+gpZPNz1ITesd4+dDXeWkJGMjSWTcluL0xFW05c8ln7OtLEGmmGeKNsgU8Xl6Ef3wsLbkUrqGUyBDVrfThfTnWrRn9w7zfJBQfTKPuvN7o0EYTAjXXnX2V+6LVLuEQ392xrlOPMhiEx6sGnGm350ffLVhs5my311+5a81zovokFLewz40hnM2Uis+oSo2vazQZ+wMQeMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ylh6bHpUcnFxOXNhOFoyUHlYdnkyOFBnOVBiaVhQeEpYUUxjRVJ0eDBUZXVO?=
 =?utf-8?B?SldJaEtsM0NDMU9QZzUrdUIzMXU2Z25pcDNpQmNxRmZXdVFZdEVGV0R3RVhh?=
 =?utf-8?B?RFpnb2RIZldQTUxtSUNvWEdsQVMwTXhrWmZoU1JXTjJpM3JBclpzN3Y2YUUr?=
 =?utf-8?B?dGhZTG94YXZqMTRUaEtjNkhiRGVCUFBXa1poODdYUFlFSkZKZHF3MllDT0Iw?=
 =?utf-8?B?cXJ1YVNpaEdBZ2NDMGRqY3dCSmNQSy9ta0V0U2plTUFWeGpnNmwyalF1bEFO?=
 =?utf-8?B?UnQrZXpMdHpXZUhicmlSZUFuUHhsSTJJTDdFOXFFcW1zTlU2Y3FaRVBIYVBl?=
 =?utf-8?B?c1hTck91VDhzSVFZNFpkWDY2VDhqM2JqTURsNVRlRkdQKzNHMjQ0bGhLN0lU?=
 =?utf-8?B?ckQremxSRzJ1U0NXUGtCTGlqV3A3aXJJWnI4YkFaa1NRc0pRVVJJdFdHZVJX?=
 =?utf-8?B?TkUwWXFycjZMWWFOOUpKbVRWZURoVUdjT0g1S1Zkdyt5RVVIK0RYblpaN1hn?=
 =?utf-8?B?VXB2RG9VOEliVGhqQlVHT3pxcmhiUS8xZ0pWMEd0N0N1ZTdpY1BoTGowR3lx?=
 =?utf-8?B?UTF5Q0Zxa09IVDJjWTMwZVJqOUVPRnpCZWkzREtzNk5OT3hOb3JkY25BdE1X?=
 =?utf-8?B?cGRKQzFyN1IvVWdrMEZMeWNBVE5XSk5TYmtPWTV2Wlg2YnF5eTBlUngzTGQ2?=
 =?utf-8?B?UHFvREwwUjI3RHdoOW02SU5qaldCWnZFbFU2blhJMlFTNy9taHdBTENjRFNW?=
 =?utf-8?B?bzVXck1aRytQaFlNSGtaTDl3OFhyc2lLUFFIYUt4cFVFRGs3WmFmaTY5ek9I?=
 =?utf-8?B?STNZc0l1d2VQSFBUU3A5MTRudTBlam50NWU3K3RGOWhZUElmRzJRbGJFMzhS?=
 =?utf-8?B?cmF0Y2NIdEcrVEk0c040LzNJTWNlMFYyenhUdnY1VDlFZXhrejdlV2ZwWFpZ?=
 =?utf-8?B?YncyaFRzdnFuVVlURWVwM2gyNHNUZW0wMXhUWEo0T2J3OWN5UXYvZUFTR24w?=
 =?utf-8?B?VU5GWGRjbWNQZEZOWVRzSW14TWZVcHFybG9nbkFvdkw0dXBHQ050aFYySmxB?=
 =?utf-8?B?VFpoSWgwWFhnbFFjcjBFVkFMM2p6bGJOV2k4WndOdno3WXVlcDZOL2RZMXdJ?=
 =?utf-8?B?N1lveXZYdWZnNzlLcllkRlJvdXJnWXlHbnJnU0FTeGJ4YVUrV29yT2JWZEI2?=
 =?utf-8?B?Y3RNYzFoM01xZk8wSUl6WUF1VEkrbVV4OVJ1bnJ4V1lObzZyQXo1MEF1Mm44?=
 =?utf-8?B?cFoxelZjSXhFdjNzVlRYVE1WRVJNUVFPeXVDR1ZBZEgxNWNyVE0yMkQraldw?=
 =?utf-8?B?N2gwYjJ4WU1YM2dTNXpCU0laOE5DVC90RHBxRDJmQkViYzRMOU5yc1VxOVpB?=
 =?utf-8?B?Q2NsYmdvanJtQzZpWDRkaCsyVDkvMEJmTFVmRjE1YmdkYkRvL0swMFB6NSsw?=
 =?utf-8?B?cnUxdDlCZFZIY05WOEZON3hUQ0hJVWNVSUVaRWxzQ0w4S2pVcmNScGRIRUNH?=
 =?utf-8?B?R3ova0JkcWtlNzhuSTJMVGRaUWNCMHZndUg5Q0d1dlk2Q0QyS21ybkZaTHdP?=
 =?utf-8?B?ZHliTXF3RVRNYXBhay9uc0Zwc3Mxdm5JQlNDbXhOVWdOVzAzSnVOcTI5K3Zh?=
 =?utf-8?B?aXFpNnVJMHh0NDNxcWFXMWNDRnJUSGJlRStKcUdTQllnaUZQU0pvTGl2Wnl2?=
 =?utf-8?B?Y0gzR0JLOExSUFp6N2swbE4xVGFiNC91akdyN0dhNDdFOGFlT2I1Y1c5ZS8x?=
 =?utf-8?B?Y2RQcHd4dmpqczd1OUtSQUp1RExGTEVaSWpESnV5KzREQmllSlI0Z2s5OEw1?=
 =?utf-8?B?L3YrNU5zNU5Md0pPZkpOeVl3V3FTOHVFSDhyVTlsdnhGRERiN2RhRmJReTNX?=
 =?utf-8?B?VGRYTG1zSFVaOC9rRVNZTEtFZ0dydytyUEcraHVpV1NBek9XTjNWYzhwbUNR?=
 =?utf-8?B?K042V2pmUHN4cVJCQkFNOUs2QzZNYlBIWnBUYmJMcEF6THBWYnl4ZDN6UDgr?=
 =?utf-8?B?WGE2RW5tQnVPUThLeFBhdXM0ODdhaG93U2kvT1RvRkUySnN4TlptaFRKNkgw?=
 =?utf-8?B?QjdGdTJPd0lJeTZjaTV4RUJ3VmNsemxmM3BZazQwVW5ieU5MdDZJR3NkVjJD?=
 =?utf-8?B?eGt5cWJQZkZhWTJLT0VpZXVCa0Uxd2FvVDV1d3hNb2lKWXlrZEhvcVBwQW5r?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9b9673-ee05-4bb9-a303-08dc3a0fc5d9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:50:59.9245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ty1GWie8QLhqbbhIC3A27yRV5RABAlCzI6lk1tfIfiqXxtdqV3gkuAGdol5mEb8NX+hzJaGiw/SJUbzeDkq+4eDG9WXoFUiYcfUzr3a+9E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9088
Received-SPF: pass client-ip=40.107.6.122;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

On 2/28/24 09:55, Marc-André Lureau wrote:
> [Вы нечасто получаете письма от marcandre.lureau@redhat.com. Узнайте, почему это важно, по адресу https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi
> 
> On Tue, Feb 27, 2024 at 4:38 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com> wrote:
>>
>>
>>
>> On 2/26/24 20:50, Konstantin Kostiuk wrote:
>>>
>>> Best Regards,
>>> Konstantin Kostiuk.
>>>
>>>
>>> On Mon, Feb 26, 2024 at 7:02 PM Andrey Drobyshev
>>> <andrey.drobyshev@virtuozzo.com <mailto:andrey.drobyshev@virtuozzo.com>>
>>> wrote:
>>>
>>>     Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
>>>     GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
>>>     used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail).
>>>     These calculations might be obscure for the end user and require one to
>>>     actually get into QGA source to understand how they're obtained. Let's
>>>     just report the values f_blocks, f_bfree, f_bavail (in bytes) from
>>>     statvfs() as they are, letting the user decide how to process them
>>>     further.
>>>
>>>     Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com
>>>     <mailto:yur@virtuozzo.com>>
>>>     Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com
>>>     <mailto:andrey.drobyshev@virtuozzo.com>>
>>>     ---
>>>      qga/commands-posix.c | 16 +++++++---------
>>>      qga/qapi-schema.json | 11 +++++++----
>>>      2 files changed, 14 insertions(+), 13 deletions(-)
>>>
>>>     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>>>     index 26008db497..752ef509d0 100644
>>>     --- a/qga/commands-posix.c
>>>     +++ b/qga/commands-posix.c
>>>     @@ -1554,8 +1554,7 @@ static GuestFilesystemInfo
>>>     *build_guest_fsinfo(strua5a0239ce5ct FsMount *mount,
>>>                                                     Error **errp)
>>>      {
>>>          GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
>>>     -    struct statvfs buf;
>>>     -    unsigned long used, nonroot_total, fr_size;
>>>     +    struct statvfs st;
>>>          char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
>>>                                          mount->devmajor, mount->devminor);
>>>
>>>     @@ -1563,15 +1562,14 @@ static GuestFilesystemInfo
>>>     *build_guest_fsinfo(struct FsMount *mount,
>>>          fs->type = g_strdup(mount->devtype);
>>>          build_guest_fsinfo_for_device(devpath, fs, errp);
>>>
>>>     -    if (statvfs(fs->mountpoint, &buf) == 0) {
>>>     -        fr_size = buf.f_frsize;
>>>     -        used = buf.f_blocks - buf.f_bfree;
>>>     -        nonroot_total = used + buf.f_bavail;
>>>     -        fs->used_bytes = used * fr_size;
>>>     -        fs->total_bytes = nonroot_total * fr_size;
>>>     +    if (statvfs(fs->mountpoint, &st) == 0) {
>>>     +        fs->total_bytes = st.f_blocks * st.f_frsize;
>>>     +        fs->free_bytes = st.f_bfree * st.f_frsize;
>>>     +        fs->avail_bytes = st.f_bavail * st.f_frsize;
>>>
>>>              fs->has_total_bytes = true;
>>>     -        fs->has_used_bytes = true;
>>>     +        fs->has_free_bytes = true;
>>>     +        fs->has_avail_bytes = true;
>>>          }
>>>
>>>          g_free(devpath);
>>>     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>>>     index b8efe31897..1cce3c1df5 100644
>>>     --- a/qga/qapi-schema.json
>>>     +++ b/qga/qapi-schema.json
>>>     @@ -1030,9 +1030,12 @@
>>>      #
>>>      # @type: file system type string
>>>      #
>>>     -# @used-bytes: file system used bytes (since 3.0)
>>>     +# @total-bytes: total file system size in bytes (since 8.3)
>>>      #
>>>     -# @total-bytes: non-root file system total bytes (since 3.0)
>>>     +# @free-bytes: amount of free space in file system in bytes (since 8.3)
>>>
>>>
>>> I don't agree with this as it breaks backward compatibility. If we want
>>> to get
>>> these changes we should release a new version with both old and new fields
>>> and mark old as deprecated to get a time for everyone who uses this
>>> API updates its solutions.
>>>
>>> A similar thing was with replacing the 'blacklist' command line.
>>> https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8affd13e5a20bc42 <https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8affd13e5a20bc42>
>>> Currently, we support both 'blacklist' and 'block-rpcs' command line options
>>> but the first one wrote a warning.
>>>
>>
>> I agree that marking the old values as deprecated does make sense.
>> Although my original intent with this patch is to make more sense of the
>> existing names (e.g. total-bytes to indicate true fs size instead of
>> just non-root fs).  If so, we'd eventually have to replace the original
>> total-bytes value with the one having new semantics.  Or we could rename
>> the existing value to smth like "total-bytes-nonroot".  But either way
>> breaks backward compatibility after all.  How would you suggest to
>> resolve it?
> 
> 
> Why break backward compatibility? Don't break other systems (win32)
> when you propose a patch.
> 
> QGA API aims to be cross-platform. Any system should be able to report
> some kind of meaningful used and total disk space. I don't see much
> reason to change that.
> 
> If we need Posix-specific values reported by statvfs(), we can have
> extra optional struct/fields.
> 
> Fwiw, I find it more obscure to report statvfs values :) Perhaps we
> should simply document better where those values are coming from,
> instead of reporting more system-specific details.
> 

Agreed, keeping API compatible with Win version is a valid point.  I've
checked Win32 API page for GetDiskFreeSpaceExA(), and it seems
TotalNumberOfBytes they return is exactly for the non-privileged user.
So that's probably the root for such a design:
https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getdiskfreespaceexa

Let me add an extra optional field then which we'd only fill on POSIX.
We might call it 'total-bytes-root' to highlight the difference.  I'd
also follow your advice and document where those values come from in
both POSIX and Win case.

I'll send this in v2.

Andrey

