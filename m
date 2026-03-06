Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6268F01835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVRZ-00083L-Vp; Fri, 06 Mar 2026 08:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vyVRW-00082W-O7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:42:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vyVRT-0006Ga-PZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772804530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XKhfAih6jfv9yK+mEQsJz6z4UPDnXGK5YiG2nfvnK2o=;
 b=UobRGcSHy/oWOkLqdYipai5kWvGkffxnHX85y8In/r7xpq7rms2SogJYz0KAvGgXv7eSEt
 8DZD6oKvD1g0TpWO3ePcqUpCIaBwCwEmRboqr3Hv67taRgN7TPVk/C1ar9cqOxAzmOOg+I
 TYClgVUcTBhwrebU2ksWp1jj7hPwGKs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-jhVUc_NpMrusOEyOfE3okQ-1; Fri, 06 Mar 2026 08:42:08 -0500
X-MC-Unique: jhVUc_NpMrusOEyOfE3okQ-1
X-Mimecast-MFC-AGG-ID: jhVUc_NpMrusOEyOfE3okQ_1772804527
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837a718f41so50023625e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772804527; x=1773409327; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKhfAih6jfv9yK+mEQsJz6z4UPDnXGK5YiG2nfvnK2o=;
 b=GkbW/QBNjFJcIMaV1kvJWTcE/3Pxj45alvk/HyAOrlXSs553DPHpWL+CYtB48AIR0N
 Oj9rQzIECsHgatZRPE146n1ydAFVGpFLNzy+qZHIXzCmtcq2QuPTHP43euj2A5V7LLHG
 56jqgcrz14CggSI+2F26hZAHaU856uVyxPEyXgdlhxtCO7BNRveo9TqBl/2peNqfXarm
 bUNZQmxvNBBzVnce6TPa6yHh6IP5fPj7ZRI4qJoIxOLLc42HcNmBn3SUeWpC/OEjyV6w
 zsdPuijtgA8TGNz16Hv6s570kRCwxaiQjGU8HcI/nxNJKc7ph8G5k1I989KkolRqVk/M
 yD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772804527; x=1773409327;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XKhfAih6jfv9yK+mEQsJz6z4UPDnXGK5YiG2nfvnK2o=;
 b=FzNfkgUGVUQE0AwcrhOW3f4xBKPJRCkj6TtRX3/v8fldRx39i0yuUnuY9Ki6pQkF3C
 UDUP4BfP70i0BbaMCi+mDLVOPm8jQ7A926Y711aa7RWLa/ipDkhGwlUxbhVBtw+nWJVM
 fx1sCA4vSE67swvEMQv/BDY+uU+KmKgpvsHH6AnePfE4RKXgEbyJ95Xs11/0wj/Oqc42
 Jt1R3gHQ92CZ6bKyUqsTqEn+2+P3muKxxjPdqNS6FU+TkG2YOFKwLruJFE0jAbdXJ5OB
 PMw7fkKTMzfy4YAGgRL30DVTodJY87npf2vFM2dVGZDgrO410Tp5hyGt6yBjunndy2R7
 VdaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAZEwFrRTcTr/N46xYqA17d/9vrr9BQYhVKXW/wm2FbE6bab+ZVnYKwdOE4XbUl9nF7qnhaMzGbTxe@nongnu.org
X-Gm-Message-State: AOJu0YzDmhELa+cZqkt8Kcd3R9iG2JyChPMtg5VcSeduY1zhMWh+CojO
 +jn1hYdIY3fy3WvpMGDt/l+28FqnN4AxOt0IfdFqkkVR2sm/RpjwprpNIK85XPLUY1yqNvmo7bg
 OqKuP1Uzx2ALALgfv6JU5B6mqHxKs0iunPeVfleerVHaxMQu3ppuzoC1x
X-Gm-Gg: ATEYQzydSbhbdu2utLx56snQLzbulYmg51A6KDFYmMwqIVU1iWU53qAR6KWvuBB/025
 brHku50P/XSKasKGWs+UhSDqBITzg+pwVyppWVhsykB4XDilBSgGhLcvG4XeXI2DAUl91/z2llk
 dosA4Rn6mcJIec4MPhGcOqXEC9FoRFUh/XCDC1Owwy8xcwXKVFZpot44Z4CSakHeJH03VPUVwyd
 hyBH+iYoxgIDf7mlhhxhfrLF4WFvth8OXglB/qVxM+axg6745KdplCnefr9EJKYBKGM0Te6wJ/z
 WFSPuM6m1/lH+FQHdtlvSs4EMjbch5YHq68BiudWO4FJP4MJ588Ul82n/RcqLybU8idQ+d/37AQ
 goaRhXvktiKJb4orDCWVTm0zlR7nFtT38MjV8K+uCd+welsbIvm9HEWpsQdvL5QiFpuQXovUGC3
 4KAhEqc0+nj8AscmZL8KEOoCqmgIuSrBqhis0n9wyI+Von7/Jhgyo=
X-Received: by 2002:a05:600c:8218:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-48526958b30mr40575085e9.16.1772804526878; 
 Fri, 06 Mar 2026 05:42:06 -0800 (PST)
X-Received: by 2002:a05:600c:8218:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-48526958b30mr40574395e9.16.1772804526267; 
 Fri, 06 Mar 2026 05:42:06 -0800 (PST)
Received: from ?IPV6:2003:cf:d737:d076:615b:37d9:f4c0:4867?
 (p200300cfd737d076615b37d9f4c04867.dip0.t-ipconnect.de.
 [2003:cf:d737:d076:615b:37d9:f4c0:4867])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad2812sm194663545e9.1.2026.03.06.05.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 05:42:05 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------DHcHyZfWnVkaACiYEbRe9lES"
Message-ID: <1d11486a-f592-49ff-837a-346f7c493ca7@redhat.com>
Date: Fri, 6 Mar 2026 14:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_04/19=5D_nfs=3A_Run_co_BH_CB_in_the_cor?=
 =?UTF-8?Q?outine=E2=80=99s_AioContext?=
To: Peter Lieven <pl@dlhnet.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-5-hreitz@redhat.com>
 <EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------DHcHyZfWnVkaACiYEbRe9lES
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.03.26 20:24, Peter Lieven wrote:
>
>
>> Am 10.11.2025 um 16:48 schrieb Hanna Czenczek <hreitz@redhat.com>:
>>
>> Like in “rbd: Run co BH CB in the coroutine’s AioContext”, drop the
>> completion flag, yield exactly once, and run the BH in the coroutine’s
>> AioContext.
>>
>> (Can be reproduced with multiqueue by adding a usleep(100000) before the
>> `while (!task.complete)` loops.)
>>
>> Like in “iscsi: Run co BH CB in the coroutine’s AioContext”, this makes
>> nfs_co_generic_bh_cb() trivial, so we can drop it in favor of just
>> calling aio_co_wake() directly.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>> block/nfs.c | 41 ++++++++++++++++-------------------------
>> 1 file changed, 16 insertions(+), 25 deletions(-)
>>
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 0a7d38db09..1d3a34a30c 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -69,7 +69,6 @@ typedef struct NFSClient {
>> typedef struct NFSRPC {
>>     BlockDriverState *bs;
>>     int ret;
>> -    int complete;
>>     QEMUIOVector *iov;
>>     struct stat *st;
>>     Coroutine *co;
>> @@ -230,14 +229,6 @@ static void coroutine_fn 
>> nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
>>     };
>> }
>>
>> -static void nfs_co_generic_bh_cb(void *opaque)
>> -{
>> -    NFSRPC *task = opaque;
>> -
>> -    task->complete = 1;
>> -    aio_co_wake(task->co);
>> -}
>> -
>> /* Called (via nfs_service) with QemuMutex held.  */
>> static void
>> nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
>> @@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct nfs_context 
>> *nfs, void *data,
>>     if (task->ret < 0) {
>>         error_report("NFS Error: %s", nfs_get_error(nfs));
>>     }
>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
>> -                                     nfs_co_generic_bh_cb, task);
>> +
>> +    /*
>> +     * Safe to call: nfs_service(), which called us, is only run 
>> from the FD
>> +     * handlers, never from the request coroutine.  The request 
>> coroutine in
>> +     * turn will yield unconditionally.
>> +     * No need to release the lock, even if we directly enter the 
>> coroutine, as
>> +     * the lock is never re-taken after yielding.  (Note: If we do 
>> enter the
>> +     * coroutine, @task will probably be dangling once aio_co_wake() 
>> returns.)
>> +     */
>> +    aio_co_wake(task->co);
>> }
>>
>> static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t 
>> offset,
>> @@ -278,9 +277,7 @@ static int coroutine_fn 
>> nfs_co_preadv(BlockDriverState *bs, int64_t offset,
>>
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>
>>     if (task.ret < 0) {
>>         return task.ret;
>> @@ -328,9 +325,7 @@ static int coroutine_fn 
>> nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
>>
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>
>>     if (my_buffer) {
>>         g_free(buf);
>> @@ -358,9 +353,7 @@ static int coroutine_fn 
>> nfs_co_flush(BlockDriverState *bs)
>>
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>
>>     return task.ret;
>> }
>> @@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int ret, struct 
>> nfs_context *nfs, void *data,
>>     if (task->ret < 0) {
>>         error_report("NFS Error: %s", nfs_get_error(nfs));
>>     }
>> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
>> -                                     nfs_co_generic_bh_cb, task);
>> +    /* Safe to call, see nfs_co_generic_cb() */
>> +    aio_co_wake(task->co);
>> }
>>
>> static int64_t coroutine_fn 
>> nfs_co_get_allocated_file_size(BlockDriverState *bs)
>> @@ -748,9 +741,7 @@ static int64_t coroutine_fn 
>> nfs_co_get_allocated_file_size(BlockDriverState *bs)
>>
>>         nfs_set_events(client);
>>     }
>> -    while (!task.complete) {
>> -        qemu_coroutine_yield();
>> -    }
>> +    qemu_coroutine_yield();
>>
>>     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>> }
>> -- 
>> 2.51.1
>>
>
> Hallo Hanna,
>
> it has been a long time where I was inactive in Qemu development and I 
> should have checked this earlier, but it seems that this patch 
> accidentally broke libnfs usage with at least qemu cmdline tools like 
> qemu-img. Again, sorry for not testing this earlier, but I have only 
> recently entered the Qemu show again.
>
> I found this glitch while working on a patch to include libnfs v6 
> support in qemu to avoid dropping libnfs support.
>
> A simple call like:
>
> qemu-img create -f qcow2 nfs://nfsserver/image.qcow2 10G
>
> hangs forever in the second write request.

I sent a patch for this, which is basically the same as yours below: 
https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.html

Hanna

>
> I have not confirmed, but this might also hold true for libiscsi which 
> internally is quite identical (at least it was 3 years ago ;-))
>
> You are right, the coroutine can only yield once, but it seems that 
> the bottom half logic is still needed.
> Maybe you have an idea why? I remember that we had this differently 
> first and implemented it after Stefan pointed out that it might be needed.
> I will try to find the thread about this discussion.
>
> This patch here restores functionality for me:
>
> *diff --git a/block/nfs.c b/block/nfs.c*
>
> *index 1d3a34a30c..45731ea3da 100644*
>
> *--- a/block/nfs.c*
>
> *+++ b/block/nfs.c*
>
> @@ -75,6 +75,12 @@typedef struct NFSRPC {
>
> NFSClient *client;
>
>  } NFSRPC;
>
> +static void nfs_co_generic_bh_cb(void *opaque)
>
> +{
>
> + NFSRPC *task = opaque;
>
> + aio_co_wake(task->co);
>
> +}
>
> +
>
>  static int nfs_parse_uri(const char *filename, QDict *options, Error 
> **errp)
>
>  {
>
> g_autoptr(GUri) uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
>
> @@ -248,15 +254,8 @@nfs_co_generic_cb(int ret, struct nfs_context 
> *nfs, void *data,
>
> error_report("NFS Error: %s", nfs_get_error(nfs));
>
>      }
>
> -    /*
>
> -     * Safe to call: nfs_service(), which called us, is only run from 
> the FD
>
> -     * handlers, never from the request coroutine.  The request 
> coroutine in
>
> -     * turn will yield unconditionally.
>
> -     * No need to release the lock, even if we directly enter the 
> coroutine, as
>
> -     * the lock is never re-taken after yielding.  (Note: If we do 
> enter the
>
> -     * coroutine, @task will probably be dangling once aio_co_wake() 
> returns.)
>
> -     */
>
> - aio_co_wake(task->co);
>
> + replay_bh_schedule_oneshot_event(task->client->aio_context,
>
> +                               nfs_co_generic_bh_cb, task);
>
>  }
>
>  static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t 
> offset,
>
> @@ -716,8 +715,8 @@nfs_get_allocated_file_size_cb(int ret, struct 
> nfs_context *nfs, void *data,
>
>      if (task->ret < 0) {
>
> error_report("NFS Error: %s", nfs_get_error(nfs));
>
>      }
>
> -    /* Safe to call, see nfs_co_generic_cb() */
>
> - aio_co_wake(task->co);
>
> + replay_bh_schedule_oneshot_event(task->client->aio_context,
>
> +                               nfs_co_generic_bh_cb, task);
>
>  }
>
>  static int64_t coroutine_fn 
> nfs_co_get_allocated_file_size(BlockDriverState *bs)
>
>
>
>
> Best
>
> Peter
>
>

--------------DHcHyZfWnVkaACiYEbRe9lES
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 03.03.26 20:24, Peter Lieven wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <br id="lineBreakAtBeginningOfMessage">
      <div><br>
        <blockquote type="cite">
          <div>Am 10.11.2025 um 16:48 schrieb Hanna Czenczek
            <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a>:</div>
          <br class="Apple-interchange-newline">
          <div>
            <div>Like in “rbd: Run co BH CB in the coroutine’s
              AioContext”, drop the<br>
              completion flag, yield exactly once, and run the BH in the
              coroutine’s<br>
              AioContext.<br>
              <br>
              (Can be reproduced with multiqueue by adding a
              usleep(100000) before the<br>
              `while (!task.complete)` loops.)<br>
              <br>
              Like in “iscsi: Run co BH CB in the coroutine’s
              AioContext”, this makes<br>
              nfs_co_generic_bh_cb() trivial, so we can drop it in favor
              of just<br>
              calling aio_co_wake() directly.<br>
              <br>
              Cc: <a class="moz-txt-link-abbreviated" href="mailto:qemu-stable@nongnu.org">qemu-stable@nongnu.org</a><br>
              Signed-off-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a><br>
              ---<br>
              block/nfs.c | 41 ++++++++++++++++-------------------------<br>
              1 file changed, 16 insertions(+), 25 deletions(-)<br>
              <br>
              diff --git a/block/nfs.c b/block/nfs.c<br>
              index 0a7d38db09..1d3a34a30c 100644<br>
              --- a/block/nfs.c<br>
              +++ b/block/nfs.c<br>
              @@ -69,7 +69,6 @@ typedef struct NFSClient {<br>
              typedef struct NFSRPC {<br>
                  BlockDriverState *bs;<br>
                  int ret;<br>
              -    int complete;<br>
                  QEMUIOVector *iov;<br>
                  struct stat *st;<br>
                  Coroutine *co;<br>
              @@ -230,14 +229,6 @@ static void coroutine_fn
              nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)<br>
                  };<br>
              }<br>
              <br>
              -static void nfs_co_generic_bh_cb(void *opaque)<br>
              -{<br>
              -    NFSRPC *task = opaque;<br>
              -<br>
              -    task-&gt;complete = 1;<br>
              -    aio_co_wake(task-&gt;co);<br>
              -}<br>
              -<br>
              /* Called (via nfs_service) with QemuMutex held.  */<br>
              static void<br>
              nfs_co_generic_cb(int ret, struct nfs_context *nfs, void
              *data,<br>
              @@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct
              nfs_context *nfs, void *data,<br>
                  if (task-&gt;ret &lt; 0) {<br>
                      error_report("NFS Error: %s", nfs_get_error(nfs));<br>
                  }<br>
              -
                 replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio_context,<br>
              -
                                                  nfs_co_generic_bh_cb,
              task);<br>
              +<br>
              +    /*<br>
              +     * Safe to call: nfs_service(), which called us, is
              only run from the FD<br>
              +     * handlers, never from the request coroutine.  The
              request coroutine in<br>
              +     * turn will yield unconditionally.<br>
              +     * No need to release the lock, even if we directly
              enter the coroutine, as<br>
              +     * the lock is never re-taken after yielding.  (Note:
              If we do enter the<br>
              +     * coroutine, @task will probably be dangling once
              aio_co_wake() returns.)<br>
              +     */<br>
              +    aio_co_wake(task-&gt;co);<br>
              }<br>
              <br>
              static int coroutine_fn nfs_co_preadv(BlockDriverState
              *bs, int64_t offset,<br>
              @@ -278,9 +277,7 @@ static int coroutine_fn
              nfs_co_preadv(BlockDriverState *bs, int64_t offset,<br>
              <br>
                      nfs_set_events(client);<br>
                  }<br>
              -    while (!task.complete) {<br>
              -        qemu_coroutine_yield();<br>
              -    }<br>
              +    qemu_coroutine_yield();<br>
              <br>
                  if (task.ret &lt; 0) {<br>
                      return task.ret;<br>
              @@ -328,9 +325,7 @@ static int coroutine_fn
              nfs_co_pwritev(BlockDriverState *bs, int64_t offset,<br>
              <br>
                      nfs_set_events(client);<br>
                  }<br>
              -    while (!task.complete) {<br>
              -        qemu_coroutine_yield();<br>
              -    }<br>
              +    qemu_coroutine_yield();<br>
              <br>
                  if (my_buffer) {<br>
                      g_free(buf);<br>
              @@ -358,9 +353,7 @@ static int coroutine_fn
              nfs_co_flush(BlockDriverState *bs)<br>
              <br>
                      nfs_set_events(client);<br>
                  }<br>
              -    while (!task.complete) {<br>
              -        qemu_coroutine_yield();<br>
              -    }<br>
              +    qemu_coroutine_yield();<br>
              <br>
                  return task.ret;<br>
              }<br>
              @@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int
              ret, struct nfs_context *nfs, void *data,<br>
                  if (task-&gt;ret &lt; 0) {<br>
                      error_report("NFS Error: %s", nfs_get_error(nfs));<br>
                  }<br>
              -
                 replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio_context,<br>
              -
                                                  nfs_co_generic_bh_cb,
              task);<br>
              +    /* Safe to call, see nfs_co_generic_cb() */<br>
              +    aio_co_wake(task-&gt;co);<br>
              }<br>
              <br>
              static int64_t coroutine_fn
              nfs_co_get_allocated_file_size(BlockDriverState *bs)<br>
              @@ -748,9 +741,7 @@ static int64_t coroutine_fn
              nfs_co_get_allocated_file_size(BlockDriverState *bs)<br>
              <br>
                      nfs_set_events(client);<br>
                  }<br>
              -    while (!task.complete) {<br>
              -        qemu_coroutine_yield();<br>
              -    }<br>
              +    qemu_coroutine_yield();<br>
              <br>
                  return (task.ret &lt; 0 ? task.ret : st.st_blocks *
              512);<br>
              }<br>
              -- <br>
              2.51.1<br>
              <br>
            </div>
          </div>
        </blockquote>
        <br>
      </div>
      <div>Hallo Hanna,</div>
      <div><br>
      </div>
      <div>it has been a long time where I was inactive in Qemu
        development and I should have checked this earlier, but it seems
        that this patch accidentally broke libnfs usage with at least
        qemu cmdline tools like qemu-img. Again, sorry for not testing
        this earlier, but I have only recently entered the Qemu show
        again.</div>
      <div><br>
      </div>
      <div>I found this glitch while working on a patch to include
        libnfs v6 support in qemu to avoid dropping libnfs support.</div>
      <div><br>
      </div>
      <div>A simple call like:</div>
      <div><br>
      </div>
      <div>qemu-img create -f qcow2 <a
          href="nfs://nfsserver/image.qcow2" moz-do-not-send="true"
          class="moz-txt-link-freetext">nfs://nfsserver/image.qcow2</a> 10G</div>
      <div><br>
      </div>
      <div>hangs forever in the second write request.</div>
    </blockquote>
    <br>
    I sent a patch for this, which is basically the same as yours below:
<a class="moz-txt-link-freetext" href="https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.html">https://lists.nongnu.org/archive/html/qemu-block/2026-01/msg00000.html</a><br>
    <br>
    Hanna<br>
    <br>
    <blockquote type="cite"
      cite="mid:EE9E2AC3-32F0-452D-AF2D-14BCBA48A3B2@dlhnet.de">
      <div><br>
      </div>
      <div>I have not confirmed, but this might also hold true for
        libiscsi which internally is quite identical (at least it was 3
        years ago ;-))</div>
      <div><br>
      </div>
      <div>You are right, the coroutine can only yield once, but it
        seems that the bottom half logic is still needed.</div>
      <div>Maybe you have an idea why? I remember that we had this
        differently first and implemented it after Stefan pointed out
        that it might be needed.</div>
      <div>I will try to find the thread about this discussion.</div>
      <div><br>
      </div>
      <div>This patch here restores functionality for me:</div>
      <div><br>
      </div>
      <div>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><b>diff
              --git a/block/nfs.c b/block/nfs.c</b></span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><b>index
              1d3a34a30c..45731ea3da 100644</b></span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><b>---
              a/block/nfs.c</b></span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><b>+++
              b/block/nfs.c</b></span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
style="font-variant-ligatures: no-common-ligatures; color: #38b9c7">@@
            -75,6 +75,12 @@</span><span
            style="font-variant-ligatures: no-common-ligatures"> typedef
            struct NFSRPC {</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">    
            NFSClient *client;</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> }
            NFSRPC;</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); min-height: 13px;"><span
            style="font-variant-ligatures: no-common-ligatures"> </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+static
            void nfs_co_generic_bh_cb(void *opaque)</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+{</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+   
            NFSRPC *task = opaque;</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+   
            aio_co_wake(task-&gt;co);</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+}</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> static
            int nfs_parse_uri(const char *filename, QDict *options,
            Error **errp)</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> {</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">    
            g_autoptr(GUri) uri = g_uri_parse(filename,
            G_URI_FLAGS_NONE, NULL);</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
style="font-variant-ligatures: no-common-ligatures; color: #38b9c7">@@
            -248,15 +254,8 @@</span><span
            style="font-variant-ligatures: no-common-ligatures">
            nfs_co_generic_cb(int ret, struct nfs_context *nfs, void
            *data,</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">        
            error_report("NFS Error: %s", nfs_get_error(nfs));</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">     }</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); min-height: 13px;"><span
            style="font-variant-ligatures: no-common-ligatures"> </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-    /*</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     *
            Safe to call: nfs_service(), which called us, is only run
            from the FD</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     *
            handlers, never from the request coroutine.  The request
            coroutine in</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     *
            turn will yield unconditionally.</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     *
            No need to release the lock, even if we directly enter the
            coroutine, as</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     *
            the lock is never re-taken after yielding.  (Note: If we do
            enter the</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     *
            coroutine, @task will probably be dangling once
            aio_co_wake() returns.)</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-     */</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-   
            aio_co_wake(task-&gt;co);</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+   
            replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio_context,</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+      
                                          nfs_co_generic_bh_cb, task);</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> }</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); min-height: 13px;"><span
            style="font-variant-ligatures: no-common-ligatures"> </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> static
            int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t
            offset,</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
style="font-variant-ligatures: no-common-ligatures; color: #38b9c7">@@
            -716,8 +715,8 @@</span><span
            style="font-variant-ligatures: no-common-ligatures">
            nfs_get_allocated_file_size_cb(int ret, struct nfs_context
            *nfs, void *data,</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">     if
            (task-&gt;ret &lt; 0) {</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">        
            error_report("NFS Error: %s", nfs_get_error(nfs));</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">     }</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-    /*
            Safe to call, see nfs_co_generic_cb() */</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(202, 51, 35);"><span
            style="font-variant-ligatures: no-common-ligatures">-   
            aio_co_wake(task-&gt;co);</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+   
            replay_bh_schedule_oneshot_event(task-&gt;client-&gt;aio_context,</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(57, 192, 38);"><span
            style="font-variant-ligatures: no-common-ligatures">+      
                                          nfs_co_generic_bh_cb, task);</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> }</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0); min-height: 13px;"><span
            style="font-variant-ligatures: no-common-ligatures"> </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"> static
            int64_t coroutine_fn
            nfs_co_get_allocated_file_size(BlockDriverState *bs)</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><br>
          </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><br>
          </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures"><br>
          </span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">Best</span></p>
        <p
style="margin: 0px; font-style: normal; font-variant-caps: normal; font-width: normal; font-size: 11px; line-height: normal; font-family: Menlo; font-size-adjust: none; font-kerning: auto; font-variant-alternates: normal; font-variant-ligatures: normal; font-variant-numeric: normal; font-variant-east-asian: normal; font-variant-position: normal; font-variant-emoji: normal; font-feature-settings: normal; font-optical-sizing: auto; font-variation-settings: normal; color: rgb(0, 0, 0);"><span
            style="font-variant-ligatures: no-common-ligatures">Peter</span></p>
      </div>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------DHcHyZfWnVkaACiYEbRe9lES--


