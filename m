Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56A1CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ux3-0002Ko-Q3; Thu, 16 Oct 2025 16:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9Uwz-0002Kf-C1
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:51:53 -0400
Received: from pc232-55.mailgun.net ([143.55.232.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9Uwt-0005L7-63
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:51:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760647890; x=1760655090; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From:
 References: Cc: To: To: Subject: Subject: MIME-Version: Date: Message-ID:
 Sender: Sender; 
 bh=BEb9fNHqVkrBOKq4uZb/3V81ghYdbp2HeXG60vsuL5M=;
 b=oPu+GqjEqEoOLhBNjn4ZLtk+VsD6EO/LxmttG/IXQu0l5EDjb5Lq4qkSrbR9S3mq/5eaonVLePz6eAkgIil9c4IPncfKgHWJpFFqRGAX03M62smHpfKTK4pwKo4bgHz8q+u98kzWydmRg5dSw08wINzKiu+CppJoRhVNdAhjyO1xa3CHwTGz2H9Y2rxK9oO4sb+1DmqBG+D2ngZMkeKXKUqODAyUfXJrR+I0w4SfeDazY15biOMTrav4J6vDtYnPTUtCSjFbLLjri4ht2t/ns/8AEnRSSBZ0cRCHmsjwePT29UKULdcQVlAcTzp9rzvtWs5l+r1I4B0dsO3Zhi/F2w==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 4ce8a49c8004b204f66ae3e14f08d0c10421585ac37c4eb2fe87bea52d74908e with SMTP id
 68f15ad2b50b98a5662b6f12; Thu, 16 Oct 2025 20:51:30 GMT
X-Mailgun-Sending-Ip: 143.55.232.55
Message-ID: <8d00eb96-97b0-42af-9e3b-645efbe909e2@yodel.dev>
Date: Thu, 16 Oct 2025 15:51:28 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] gdbstub/user-target: Map errno values from the host OS to
 GDB
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251015162520.15736-1-yodel.eldar@yodel.dev>
 <87o6q6j3oe.fsf@draig.linaro.org>
Content-Language: en-US
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <87o6q6j3oe.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.55;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-55.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Alex!

On 10/16/25 9:56 AM, Alex Bennée wrote:
> Yodel Eldar <yodel.eldar@yodel.dev> writes:
> 
>> This patch introduces the function "gdb_host_errno_to_gdb" that maps
>> host-dependent errno values to their GDB protocol-specific
>> representations as listed in the GDB manual [1].
>>
>> The stub now uses the correct GDB errno values in F reply packets.
>>
>> [1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2751
>> Reported-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>>   gdbstub/user-target.c | 93 +++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 89 insertions(+), 4 deletions(-)
>>
>> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
>> index 43231e695e..29feb0509c 100644
>> --- a/gdbstub/user-target.c
>> +++ b/gdbstub/user-target.c
>> @@ -302,6 +302,87 @@ static void hostio_reply_with_data(const void *buf, size_t n)
>>                             gdbserver_state.str_buf->len, true);
>>   }
>>   
>> +/*
>> + * Map host error numbers to their GDB protocol counterparts.
>> + * For the list of GDB File-I/O supported error numbers, please consult:
>> + * https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html
>> + */
>> +
>> +static int gdb_host_errno_to_gdb(int errnum)
>> +{
>> +    enum {
>> +        GDB_EPERM        =    1,
>> +        GDB_ENOENT       =    2,
>> +        GDB_EINTR        =    4,
>> +        GDB_EIO          =    5,
>> +        GDB_EBADF        =    9,
>> +        GDB_EACCES       =   13,
>> +        GDB_EFAULT       =   14,
>> +        GDB_EBUSY        =   16,
>> +        GDB_EEXIST       =   17,
>> +        GDB_ENODEV       =   19,
>> +        GDB_ENOTDIR      =   20,
>> +        GDB_EISDIR       =   21,
>> +        GDB_EINVAL       =   22,
>> +        GDB_ENFILE       =   23,
>> +        GDB_EMFILE       =   24,
>> +        GDB_EFBIG        =   27,
>> +        GDB_ENOSPC       =   28,
>> +        GDB_ESPIPE       =   29,
>> +        GDB_EROFS        =   30,
>> +        GDB_ENOSYS       =   88,
>> +        GDB_ENAMETOOLONG =   91,
>> +        GDB_EUNKNOWN     = 9999,
>> +    };
> 
> We have this enum in include/gdbstub/syscalls.h already.
> 

Thanks for pointing that out!

>> +
>> +    switch (errnum) {
>> +    case EPERM:
>> +        return GDB_EPERM;
>> +    case ENOENT:
>> +        return GDB_ENOENT;
>> +    case EINTR:
>> +        return GDB_EINTR;
>> +    case EIO:
>> +        return GDB_EIO;
>> +    case EBADF:
>> +        return GDB_EBADF;
>> +    case EACCES:
>> +        return GDB_EACCES;
>> +    case EFAULT:
>> +        return GDB_EFAULT;
>> +    case EBUSY:
>> +        return GDB_EBUSY;
>> +    case EEXIST:
>> +        return GDB_EEXIST;
>> +    case ENODEV:
>> +        return GDB_ENODEV;
>> +    case ENOTDIR:
>> +        return GDB_ENOTDIR;
>> +    case EISDIR:
>> +        return GDB_EISDIR;
>> +    case EINVAL:
>> +        return GDB_EINVAL;
>> +    case ENFILE:
>> +        return GDB_ENFILE;
>> +    case EMFILE:
>> +        return GDB_EMFILE;
>> +    case EFBIG:
>> +        return GDB_EFBIG;
>> +    case ENOSPC:
>> +        return GDB_ENOSPC;
>> +    case ESPIPE:
>> +        return GDB_ESPIPE;
>> +    case EROFS:
>> +        return GDB_EROFS;
>> +    case ENOSYS:
>> +        return GDB_ENOSYS;
>> +    case ENAMETOOLONG:
>> +        return GDB_ENAMETOOLONG;
>> +    default:
>> +        return GDB_EUNKNOWN;
>> +    }
>> +}
>> +
>>   void gdb_handle_v_file_open(GArray *params, void *user_ctx)
>>   {
>>       const char *filename = get_filename_param(params, 0);
>> @@ -315,7 +396,8 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
>>       int fd = open(filename, flags, mode);
>>   #endif
>>       if (fd < 0) {
>> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>> +        int gdb_errno = gdb_host_errno_to_gdb(errno);
>> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>>       } else {
>>           g_string_printf(gdbserver_state.str_buf, "F%x", fd);
>>       }
>> @@ -327,7 +409,8 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
>>       int fd = gdb_get_cmd_param(params, 0)->val_ul;
>>   
>>       if (close(fd) == -1) {
>> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>> +        int gdb_errno = gdb_host_errno_to_gdb(errno);
>> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>>           gdb_put_strbuf();
>>           return;
>>       }
>> @@ -350,7 +433,8 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
>>   
>>       ssize_t n = pread(fd, buf, bufsiz, offset);
>>       if (n < 0) {
>> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>> +        int gdb_errno = gdb_host_errno_to_gdb(errno);
>> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>>           gdb_put_strbuf();
>>           return;
>>       }
>> @@ -373,7 +457,8 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
>>       ssize_t n = readlink(filename, buf, BUFSIZ);
>>   #endif
>>       if (n < 0) {
>> -        g_string_printf(gdbserver_state.str_buf, "F-1,%x", errno);
>> +        int gdb_errno = gdb_host_errno_to_gdb(errno);
>> +        g_string_printf(gdbserver_state.str_buf, "F-1,%x", gdb_errno);
>>           gdb_put_strbuf();
>>           return;
>>       }
> 
> with that fixed:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 

Since your review, I've noticed that Richard Henderson already authored
a host-to-GDB errno mapping function in commit 7327e6023:
host_to_gdb_errno:target/m68k/m68k-semi.c; it's functionally identical
to the mapping proposed in this patch (albeit missing two errno values
that were undocumented in the GDB manual until recently), but written in
the context of semihosting for the m68k.

So as to avoid duplicating code, I'm considering exporting the existing
host_to_gdb_errno in a minor refactor to use that instead; do you think
that's a better route?

Thanks,
Yodel

