Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A3CC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 11:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl5Wb-0005vm-K5; Fri, 15 Mar 2024 07:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl5WL-0005Wq-By
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:14:46 -0400
Received: from mail-db8eur05on20727.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::727]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl5WE-0007EU-MV
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:14:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILXbbtAEOipDGkaOSWm4WXgGERwcTtLVbpxA96rpJYzvaVIWUIWPSJKukSbBHLGEN4cGHXi1J5xuGoorzqiY+UhZRlM8JstJ8WMNFv6UVZV9mqJ2dtTnoixqXKR5+oBYM9KC9lVkuPMWaw+7v7tKI5SkwuOHHtvOAPbN6k/mc2rXszrZn/M3NEkKyTaCxxFIXaaKv0F27ulW5JHoLtQOZYD6czb5fG4axqXRmxv+77B0bKKmeuTX66F0sxi8dsXtgOs6XMJUFVrLh15OA9bpgmBwA0lkPEN/iJvaUL1pjs6gMSGIlCzn+GrbZVEzz2EW322nGjaQh6E6PiRSeyp+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5doNikdmZV84z83lDU6iacKqEFs9x56zkFmrMn7fg8=;
 b=YO0d8k8l6seSxWm4Jur2U/PBdPVe3vdQNSUWsAqL0sx9rtH7CDvEGx6nGFplmpckmA7WQwl5jHivGAwZ4RedmKuoFDGNaWaVjlpjHP6NwG3UueoOM/z0pqs3OHlV0IaGxuLPyaNQQuFRLNivo5N6aGCwCZhYSuiBQtzTeXuc0NDwZIsZdwEhe9BZNbNvh/9Xm0aWW3iMp272T64RuAOQ2S/hSnIvYevJPD62qj80fyoVTCZQStfkoVh20Vu352mLdcRRHwNFAnpjL9Hver6bwaw5ZbJhLgp0A10sj7zxJGnZiF/it+8w3vznXeIqZvgozpBQU1jVuUYAvwYEUQC85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5doNikdmZV84z83lDU6iacKqEFs9x56zkFmrMn7fg8=;
 b=ga/KRJfUTcROaEMAsGl8/eHT9QLoFAliBUk1/AXX5IVS7kbpc1iTa+TwtOqe2YjUZkSaYNtO0lzPTWRx/XFmihRZPoRdLxugUjsDYNjGcFhlb3M90lNqvKSkyR3cQeh1a5BQsdJUVpfGfII6AaBMMFcQILiWqRBjTN969/K3TkxDtarxZONRLeemCL6pTUF/ygBV8v485VbeISJS/DjH3ln45uwpGzcEsu7sKztJBKfTyNbDyZs1kbxt49YLYUJ/qFrsEiCkgQ12kqbJCnRTv8jyrePqjbja0HZHQTJPTRDdqhgJltctmoOb8pnIZzHQ1/XUEacXhabjWAqZ12ac3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 11:14:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::dbee:6dba:615b:bfdb%7]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 11:14:29 +0000
Message-ID: <bebf17f7-d2d4-4da5-997f-d9cc530a3b26@virtuozzo.com>
Date: Fri, 15 Mar 2024 13:14:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] qga: introduce ga_run_command() helper for guest
 cmd execution
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
 <20240301172858.665135-3-andrey.drobyshev@virtuozzo.com>
 <ZeddShrMTUFjMoNl@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZeddShrMTUFjMoNl@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU2PR08MB10037:EE_
X-MS-Office365-Filtering-Correlation-Id: 5015eed4-2acb-40a0-5a12-08dc44e114ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OI14fZ8c2lvn0HYGBhoPpR7WDJ/9UkcARvRfUcFZVDz4cA5/d1D7QRvwrDBJZDvlP7fYs7MiYXekZNcC1DYQ6FTsCuPK+fgwdOtRkWT0czz88wJ/KFRjFx0/yf4r5MGo384cw3shjugtEb+xMkKe3OLzwIDzgKecyIvNbP/pwt8DGOItwpLaKrdlkBTBHwY6lAeNQwxpiQU1jl/R6Exh71qy0e2UvxqF1Ej8MAugm94vPOMMtEXi1xMd+sCIN7V3I/jR+AJlWV4ATXfoxPdTu4Lvju5HGcyqgf1SykJY8QFCN1kkAE9HOnPxKf3NRi0SuyPKy9lcElhQH4pzf9NN5VkCC34KYxr/8yiTGm58jx8UmOBYxYUSgowCprCG/WJ/dd3DtWYtDcCbf22kHOwYF1VJQEX+KSQLpDRIJagNr6oNXUl+zpYY55EeZa46DLQHIkTeFiNfuurBU5++haK823CHdMCXMIDmaByC7YDYmyfdAZ4yVHTV+sIUY0gioXOaBhDIceCjetRDJpLLylrvuuHrP1lGzorhQymm9hdvLrWpQXFrjKrLFdAad6+IIY97LiMSSnNzp9W48IbgYsnQ5MmqOPMlcYIaGsvB5cTerMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkNGdkpTYmtWMk9YSDVoL2Q4RXZRd1N0VkFDZDNWY1prcGVaZm1YRVkrMDZv?=
 =?utf-8?B?b0lCSWZYSW45YjZZcjNrSHFmRVBaeFR4K2dhS0VJS1FpaWszUXpTTHRJVDZv?=
 =?utf-8?B?NXlScUhvZjJqMGNld0ZtQWtsYVhYQnNUZUxCQTNjRWZWbmJSV242alBmWVg5?=
 =?utf-8?B?SGxJdEdwMnVxOVN3cndRc0w5RXZFbThrSUlFNU1kaGJJQ3BCSHZPMEtHVkc4?=
 =?utf-8?B?ZWFJRVg0Z3A3aURTcEFlM0x5VjgxN2xLbnFNQ0t5MjRoQU9KUEQzOU4xR2I0?=
 =?utf-8?B?aWN5RXVqRUk4azVqeEF5dUN6Qk03WWpEaUJlV01CMjJCd0ppYXd0cEsveHNa?=
 =?utf-8?B?ZWs0emVnN2MwRTRQeXNzSm1ONGY1VDdvVFBmdUpJTjlweHJwOHRUZkFyQjJF?=
 =?utf-8?B?RjBPcTE5MjFJd3FieEhNWHJmSW56SFhvdzVJWk5lV0Q1WHcvYzd1cVptUmRC?=
 =?utf-8?B?Rm42TmtFYXdZNFdRLy9BU1ZiZVlhT0VENXlZT1pEMVpTTDZUbzk5d28zaEJO?=
 =?utf-8?B?KzZmM25Na01kUzFwRjVnN1pvMDBQOFZLd1RNZk82NDByOHcxZmpPZkpUK3Fo?=
 =?utf-8?B?TkFLcEVVNWg4Y3huZTd3VUVjN0c1Q3Z2VXhVUEwrWE9ndEN3UFg1bmd5UGxy?=
 =?utf-8?B?UG0wZ0JLeEM5ZGhtYXFDZlZiNHdUTFZHTnU0T0hHd00rTVJQYThyZ2U3U1pQ?=
 =?utf-8?B?bUlyQnNTZ3hjamxWWUxuMnBhVUZYNndXcnNmRTBwTDlyZjFTY3FHbjUrMjY2?=
 =?utf-8?B?UVZYelVaNjlybG96TVRTcE5YOG43UUlBeFQ3UGlRY1pJd21aYlFsdkZKWkVY?=
 =?utf-8?B?UlhPYndWb0d2OVFqcVNtY3dqQ21UQ3hsUmdrSWlmVXA5VjNzSVFDalJubGpZ?=
 =?utf-8?B?dXZIcjZSdXdITllxR25pMFJYZHlzVFg1Zk92QkJDL2RsVDRvbi8wTUFRdkcx?=
 =?utf-8?B?dWJJaUN1RXd5ZGxoeExBOUlSUlcxTGxJZzNEYlhTcXJxZlAyYnlWdnBUazNY?=
 =?utf-8?B?WlFOZTFGRnZHa01YNGdsV2lMczlReER0eGdEbUJ5dzlYVVFSdUVJOHlXR0RU?=
 =?utf-8?B?NzdnQWJKb0Qwb2cwTFo1eklvaFZSNDlXdE0vSjZPRnQzTHJvL09ldDM1WFFJ?=
 =?utf-8?B?UTF3Vi9PSG9vOGVYOStYeS95L0Q3RWwzd1Iwamo2SCtuMGNrN0R4V3JCb0xW?=
 =?utf-8?B?anpsbVFZTUluUTJYckZNc3VNRTlVN0FtOWpXRitITmpPUjNaTWJ0UzBqTzl4?=
 =?utf-8?B?M3AxRWdXS1dSbHRlMmtlbGd0endCWE54UmJCVnlNV0JjSVlGQVU5WFJxbXJi?=
 =?utf-8?B?cjAyeUhaTXQwYURRekxYdXBSdEN3a0FKUFUwVUVycFVVSlVhSzJqQnpTazJs?=
 =?utf-8?B?MnF6c2ppWnJTSEJYS2pGbG1ta1FTdlh1SDlkaXBOUFlrVWNMelZHNlFxMUVX?=
 =?utf-8?B?azFyVHJ5SEZhc3M1bnZPSldGbDRpN2ROdWZ2b01Xdjd6V2VIYkxoK1ZsK08z?=
 =?utf-8?B?WUZZUm9sbTJtN0FFNXdCbDRoeVpkUXp0Tm1tbUY2bWFqUk5ob1AzWVlSTUtp?=
 =?utf-8?B?OWJOUGFVNlpnUVRZNVhZdGk2VzVjeG1KbFZMUi9Kc1drVlBvLzlCVGlyWDhZ?=
 =?utf-8?B?Szg2eHNCQ1ZkY2M5T3gvM3p6TzkxM1lNck5lMWRYY0lBQU8yQmRUUTZyb2NE?=
 =?utf-8?B?MUdSQ0JqYnI5dHE0YjRCcnd4c2NGRWxCNUFHcXZ3SThvb2E2NjhHVTRyQVhL?=
 =?utf-8?B?emVHcEgzUXU1Sk96S3VxQlc3RzFwQk5oRzNzSWJlbkpseG5xeTI4TWdZaUk1?=
 =?utf-8?B?Njh1UUE5VXNYbWJiTnVFZFMreUdlNkh4dFA5ck0zbndTaXh1TTF2R21kODF5?=
 =?utf-8?B?ZzJiNVdzRkFHS2FHZ1BqUVZRUXJ6QTFpYTFEYTBnTTcxejlxM2hobmVPa1Qy?=
 =?utf-8?B?Y2g5elVPcUV6bmgrSWl2Q2t4VEhQeGJFbzJBVHNmbUVEY2RnZTVReXZNUXht?=
 =?utf-8?B?MVRMdStEdjk0b2JxakJ0LzJubUFFWkNwa092c1dIc0NqNGVzRWQzbGRMdERl?=
 =?utf-8?B?WUdVZ1RsSGpRcUt4aHMvbHIrNi8rWDhVdWw3b3FKYVRiK0xIQk9PKzRLZzMx?=
 =?utf-8?B?ckVIaHNmTDh3M3RDRVFsbjMyRDBycGZlYnJLdUkyU2paeWU0RjBUc1lManJm?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5015eed4-2acb-40a0-5a12-08dc44e114ee
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 11:14:29.0256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6ToJdwro76asyEKE12YSdtGwiLLLd8yjSLwW6K5bpfvOx90uN8Kjb+90PMvpDmj3Gz0gzKXYfTnXHLvOKIZ7ea9i/qv7N/2JjPtEQLHfnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10037
Received-SPF: pass client-ip=2a01:111:f400:7e1a::727;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/5/24 19:58, Daniel P. Berrangé wrote:
> On Fri, Mar 01, 2024 at 07:28:53PM +0200, Andrey Drobyshev wrote:
>> When executing guest commands in *nix environment, we repeat the same
>> fork/exec pattern multiple times.  Let's just separate it into a single
>> helper which would also be able to feed input data into the launched
>> process' stdin.  This way we can avoid code duplication.
>>
>> To keep the history more bisectable, let's replace qmp commands
>> implementations one by one.  Also add G_GNUC_UNUSED attribute to the
>> helper and remove it in the next commit.
>>
>> Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qga/commands-posix.c | 140 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 140 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 8207c4c47e..781498418f 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -76,6 +76,146 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
>>      g_assert(rpid == pid);
>>  }
>>
>> +static void ga_pipe_read_str(int fd[2], char **str, size_t *len)
>> +{
>> +    ssize_t n;
>> +    char buf[1024];
>> +    close(fd[1]);
>> +    fd[1] = -1;
>> +    while ((n = read(fd[0], buf, sizeof(buf))) != 0) {
>> +        if (n < 0) {
>> +            if (errno == EINTR) {
>> +                continue;
>> +            } else {
>> +                break;
> 
> This is a fatal error condition....
> 
>> +            }
>> +        }
>> +        *str = g_realloc(*str, *len + n);
>> +        memcpy(*str + *len, buf, n);
>> +        *len += n;
>> +    }
>> +    close(fd[0]);
>> +    fd[0] = -1;
> 
> ....and yet as far as the caller is concerned we're not indicating
> any sense of failure here. They're just being returned a partially
> read data stream as if it were successful. IMHO this needs to be
> reported properly.
>

Agreed.  We might make this helper return -errno in case of an erroneous
read from pipe, check the value in the caller and do error_setg_errno()
if smth went wrong.

> 
> Nothing in this method has NUL terminated 'str', so we are
> relying on the caller *always* honouring 'len', but.....
>

Agreed as well.  Let's allocate +1 additional byte and store '\0' in
there on every iteration, making sure our result is always
null-terminated. That way we won't need to check 'len' in the caller.

>> +}
>> +
>> +/*
>> + * Helper to run command with input/output redirection,
>> + * sending string to stdin and taking error message from
>> + * stdout/err.
>> + */
>> +G_GNUC_UNUSED
>> +static int ga_run_command(const char *argv[], const char *in_str,
>> +                          const char *action, Error **errp)
>> +{
>> +    pid_t pid;
>> +    int status;
>> +    int retcode = -1;
>> +    int infd[2] = { -1, -1 };
>> +    int outfd[2] = { -1, -1 };
>> +    char *str = NULL;
>> +    size_t len = 0;
>> +
>> +    if ((in_str && !g_unix_open_pipe(infd, FD_CLOEXEC, NULL)) ||
>> +        !g_unix_open_pipe(outfd, FD_CLOEXEC, NULL)) {
>> +        error_setg(errp, "cannot create pipe FDs");
>> +        goto out;
>> +    }
>> +
>> +    pid = fork();
>> +    if (pid == 0) {
>> +        char *cherr = NULL;
>> +
>> +        setsid();
>> +
>> +        if (in_str) {
>> +            /* Redirect stdin to infd. */
>> +            close(infd[1]);
>> +            dup2(infd[0], 0);
>> +            close(infd[0]);
>> +        } else {
>> +            reopen_fd_to_null(0);
>> +        }
>> +
>> +        /* Redirect stdout/stderr to outfd. */
>> +        close(outfd[0]);
>> +        dup2(outfd[1], 1);
>> +        dup2(outfd[1], 2);
>> +        close(outfd[1]);
>> +
>> +        execvp(argv[0], (char *const *)argv);
>> +
>> +        /* Write the cause of failed exec to pipe for the parent to read it. */
>> +        cherr = g_strdup_printf("failed to exec '%s'", argv[0]);
>> +        perror(cherr);
>> +        g_free(cherr);
>> +        _exit(EXIT_FAILURE);
>> +    } else if (pid < 0) {
>> +        error_setg_errno(errp, errno, "failed to create child process");
>> +        goto out;
>> +    }
>> +
>> +    if (in_str) {
>> +        close(infd[0]);
>> +        infd[0] = -1;
>> +        if (qemu_write_full(infd[1], in_str, strlen(in_str)) !=
>> +                strlen(in_str)) {
>> +            error_setg_errno(errp, errno, "%s: cannot write to stdin pipe",
>> +                             action);
>> +            goto out;
>> +        }
>> +        close(infd[1]);
>> +        infd[1] = -1;
>> +    }
>> +
>> +    ga_pipe_read_str(outfd, &str, &len);
>> +
>> +    ga_wait_child(pid, &status, errp);
>> +    if (*errp) {
>> +        goto out;
>> +    }
>> +
>> +    if (!WIFEXITED(status)) {
>> +        if (len) {
>> +            error_setg(errp, "child process has terminated abnormally: %s",
>> +                       str);
> 
> ...this is reading 'str' without honouring 'len', so is likely
> an array out of bounds read.
> 
>> +        } else {
>> +            error_setg(errp, "child process has terminated abnormally");
>> +        }
>> +        goto out;
>> +    }
>> +
>> +    retcode = WEXITSTATUS(status);
>> +
>> +    if (WEXITSTATUS(status)) {
>> +        if (len) {
>> +            error_setg(errp, "child process has failed to %s: %s",
>> +                       action, str);
> 
> Again, array out of bounds is likely
> 
>> +        } else {
>> +            error_setg(errp, "child process has failed to %s: exit status %d",
>> +                       action, WEXITSTATUS(status));
>> +        }
>> +        goto out;
>> +    }
>> +
>> +out:
>> +    g_free(str);
>> +
>> +    if (infd[0] != -1) {
>> +        close(infd[0]);
>> +    }
>> +    if (infd[1] != -1) {
>> +        close(infd[1]);
>> +    }
>> +    if (outfd[0] != -1) {
>> +        close(outfd[0]);
>> +    }
>> +    if (outfd[1] != -1) {
>> +        close(outfd[1]);
>> +    }
>> +
>> +    return retcode;
>> +}
>> +
>>  void qmp_guest_shutdown(const char *mode, Error **errp)
>>  {
>>      const char *shutdown_flag;
>> --
>> 2.39.3
>>
>>
> 
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


