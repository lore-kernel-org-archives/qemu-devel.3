Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXwW1-0001wY-9u; Wed, 15 Jan 2025 01:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwVz-0001wN-Jj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:04:31 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwVu-0003WB-6O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:04:28 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso107696155ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736921063; x=1737525863;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9m+h7vCnXdJ+7bbignD2SW8iPild0iEciISIAdo4r7w=;
 b=0RXLE/DGRQa+1xnbE5ncnlhxJPyPkmLBAgGU0XW2m73gsun+R9K/VoeTwTE7ciJKva
 6FOzC9QnvLf+ZB7ASeiW5+/T3enWI8ASzlQEfHPhwohBffIkhpV25Z1RXHMGXTLYyJ4o
 DwZNmirCxLhxF0zcxh4OsnFpN7+S/8xB+M+SuveBtBPC07qq6tMWdTJsvVOGm7IGqTWA
 I4RaUgMztEgI0uZX2nZCTwvzaxWs4fN+lskYAXl0C2ca4+aqlCYPmaeg4yvn5LCX+YqO
 MC/pmW302RJJLqj7Yy9Kz/vwBVApOIwZPJLMEqdrrW+J6JFtZuwq5mAsXzHfAQ2ncXhJ
 z26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736921064; x=1737525864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9m+h7vCnXdJ+7bbignD2SW8iPild0iEciISIAdo4r7w=;
 b=rlTlwmnr3KFbNGv3qkzOAtkbpGMRTvTwlydB/mqSpnb0IU6N0uzHVz6hmY128BfpwN
 lWqjdTfe2qhCJLcJfAI75fHHkm/IdOUfEDPh6AJGLAMO6DUtY/c0nHZTX26E4XJcKrUN
 QtlyKD2IlqCrzWqNAgnun1Saf7VSFAoJI2CLyjhwF2t6cJgUQExEIT2FVceGbx8Fzz+A
 aMjNPgDwCPnIh2GsXSM5nrCa3tByoSL6aXp+UUi6T8QlMbt8iT6szFSkJ3la8rZgtJbO
 GNo+Uiy7s9L0uZjZX1i9XXmyL+XaBuR5B/x/I2DipSTssGu0tY/x+qWeNtkIS2v4M72p
 U06A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbAxKOzbEX6mi4oMwp0UyieHwCmFAmG5MIAv+HuwofMMzVBoY5dCmOCg0FQsO+443fVV55p7LRGwTN@nongnu.org
X-Gm-Message-State: AOJu0YwxW1fgxulevVkCR+PslMDnY6Nq+DxTGH5DDg0JPo5ZMBFI/gJ3
 15bO5Wu7c0AwvkIwJ4sQn5TNXy8nwopmX7qVeJRkMJSNPV+nTy/SnXKksj0JU6k=
X-Gm-Gg: ASbGnctpJ2VERJ+ZJNTsb5uhHoudoHZ+OgwFjSHeqVyplPG6UYhSL8BoByAjW2ouLx8
 q0Ff2OhygOBC6OkNFG2qVYTAYqTZhbTar1+mK8MjD4J1VCoP0RELJDexg9YmhCaJJzt6esp18Js
 zRm7coy4xBEBzfAK5TUNTCcoJFetxVPcd/q9ZlgrxqMwosCROjJELmn91jF1akb1v8LhvG/jixh
 Pdqx+00xU7F9g+xzErvYHm83Jr8ZIXOh9KOxAA1QTt4zzevxHO2v9edEwhaadBaS2c=
X-Google-Smtp-Source: AGHT+IFNikn377Cs7IvAakq5lh2WOOFoqr5zGmjqAS9c0j711GO4N4PrkfP651PmVUdArp4aUVRMww==
X-Received: by 2002:a17:903:1cf:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-21a83f4cd36mr448785665ad.23.1736921063539; 
 Tue, 14 Jan 2025 22:04:23 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f25c6a7sm75745155ad.247.2025.01.14.22.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 22:04:23 -0800 (PST)
Message-ID: <d0601ef8-f959-4bea-8993-a9b5512fabe8@daynix.com>
Date: Wed, 15 Jan 2025 15:04:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tap: Use g_spawn_sync() and
 g_spawn_check_wait_status()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, devel@daynix.com
References: <20250104-glib-v2-0-12013f3e5782@daynix.com>
 <20250104-glib-v2-2-12013f3e5782@daynix.com> <Z3ujuV1jH_dSY9HZ@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z3ujuV1jH_dSY9HZ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/01/06 18:34, Daniel P. Berrangé wrote:
> On Sat, Jan 04, 2025 at 05:04:08PM +0900, Akihiko Odaki wrote:
>> g_spawn_sync() gives an informative message if it fails to execute
>> the script instead of reporting exiting status 1.
>>
>> g_spawn_check_wait_status() also gives an message easier to understand
>> than the raw value returned by waitpid().
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   net/tap.c | 169 ++++++++++++++++++++++++--------------------------------------
>>   1 file changed, 66 insertions(+), 103 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index ae1c7e398321..392a024f8ed9 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -385,56 +385,30 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>>       return s;
>>   }
>>   
>> -static void close_all_fds_after_fork(int excluded_fd)
>> +static void unset_cloexec(gpointer data)
>>   {
>> -    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
>> -                           excluded_fd};
>> -    unsigned int nskip = ARRAY_SIZE(skip_fd);
>> -
>> -    /*
>> -     * skip_fd must be an ordered array of distinct fds, exclude
>> -     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
>> -     * range
>> -     */
>> -    if (excluded_fd <= STDERR_FILENO) {
>> -        nskip--;
>> -    }
>> -
>> -    qemu_close_all_open_fd(skip_fd, nskip);
>> +    g_assert(!fcntl(GPOINTER_TO_INT(data), F_SETFD, 0));
>>   }
>>   
>>   static void launch_script(const char *setup_script, const char *ifname,
>>                             int fd, Error **errp)
>>   {
>> -    int pid, status;
>> -    char *args[3];
>> -    char **parg;
>> +    gint status;
>> +    gchar *argv[] = { (gchar *)setup_script, (gchar *)ifname, NULL };
>> +    g_autoptr(GError) error = NULL;
>>   
>>       /* try to launch network script */
>> -    pid = fork();
>> -    if (pid < 0) {
>> -        error_setg_errno(errp, errno, "could not launch network script %s",
>> -                         setup_script);
>> +    if (!g_spawn_sync(NULL, argv, NULL, G_SPAWN_CHILD_INHERITS_STDIN,
>> +                      unset_cloexec, GINT_TO_POINTER(fd),
>> +                      NULL, NULL, &status, &error)) {
> 
> This unset_cloexec callback is relying on knowledge of current internal
> impl details of g_spawn_sync. The API docs say that all file descriptors
> will be closed, except for stdin/out/err. We should not assume glib is
> doing this by setting O_CLOEXEC, as opposed to directly calling close().
> 
> If we need specific FDs to remain open, we neeed to be using the other
> g_spawn_async_with_pipes_and_fds API that accepts a list of FDs to remain
> open.

g_spawn_async_with_pipes_and_fds() is not available for 2.66 so we 
cannot use it.

An upstream developer says unsetting FD_CLOEXEC in the setup function is 
fine in such a scenario. They are not documenting that because new glib 
versions they are developing has g_spawn_async_with_pipes_and_fds(), 
which is a better alternative:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4452

Regards,
Akihiko Odaki

