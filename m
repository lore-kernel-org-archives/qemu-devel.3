Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AB8C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 07:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVSu-0000ND-Bv; Tue, 01 Jul 2025 03:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWVSs-0000Mi-GE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWVSo-0004RX-An
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751355091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UNM7RW+fQfBPuOpabKwp+slo9/HtJNb/APwehBGEco=;
 b=NtjjL+g9zt7cPLhfFcOm++fWWTd2iGaNmDZOx+Qrtmvemrd0fF/OBZbcsHLjdD+Um0uvOQ
 kY0nThXBGtW04c7dywhWM1W1UlJK6NWKLFXEFu4yzRI2sxU+k4uJdBM4/cdFz/82E6PgKI
 ImJBDCNvZ3ToUnjs9cJHnb7jQx+tNQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-ELtiP-7dPmeg6KgzhQD6mA-1; Tue, 01 Jul 2025 03:31:30 -0400
X-MC-Unique: ELtiP-7dPmeg6KgzhQD6mA-1
X-Mimecast-MFC-AGG-ID: ELtiP-7dPmeg6KgzhQD6mA_1751355089
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2607910f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 00:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751355089; x=1751959889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9UNM7RW+fQfBPuOpabKwp+slo9/HtJNb/APwehBGEco=;
 b=vtpAmg2P5Kz9q/LWEz/mzts8gxhHKKoKyCoVJpQzD3Eh/y12HFAB0Y3Olb5j6cgPgO
 KIiaKwK8G18yze7Uxc0qcbshn3NIZycG5sYVMfW6jAOtMo1tyNy1gPTaC7y6RhUGy8jV
 Ke8LDQqTrBYTNG7At3BoVz5gJSL7rBi2lhXYUWceG8utOCL07bLCq/0JJqLZK67dhAj0
 q1iiuzgO8/MrUAHWdj4QTn7pLbVy+tU0NSPqTux6kcBiu9poh/3vIDmyp3l2JyfQcUR6
 Cz3v+eR/3RgcEuEnfFkcf5+ONGPwZ7OI0HEzclTkaYeejtG74VC3J8oFaXcwjBmEIj6x
 lI7A==
X-Gm-Message-State: AOJu0YwkO7GdM9pulCzNCFaGH403q7Pl/Xxca5Ff2MftUuUHEdDU0lro
 YNfdR5inw/5H3Y/7+ZJ8gp635ZzHLDYCWPCqLa5cwpkc2dHhOzDSsWbEnizQNgXNJ8d11MGLXMN
 1UaRQOZJZIZxSG7wAf/KFsZ68LgiWplTpNgou3G701pXonkLV6a0WOH0+
X-Gm-Gg: ASbGncshdLGjaRgs0ZTn5P+oYZSAEj8kcO6zZ2lnhxCfqIIVksBITQqV8ME5zyUjMCn
 kaXSvdtEiUZq9vQzUFWZc+h4xI9T/6lkls5C/QhbeuZOTdjs6m9eYJr5IOALj6Ppb9RybZIJQLs
 OWngrnKRCZyPC61njGaCsZAyFpcGa4aZ0UI+1S/rA4KGNiWv8vhvnYUu5CuXHxFYUZ6mJbdnlPw
 Z9QiLOtWwMlMWHZTn3eO9QBQPcCZoltz8dsbzI2Eov0CTqpptt2Nqgul/SSjVN0x5ErQI8cJrMQ
 R3cYTQurTwteVj0WajNCXCcf5SUFv1Epa2rEaoW4azZzjLjBvD6uvlOo/m+G4k5FF8E8Q/gYDbb
 MAFsZDoSZiDMzEuA28Z5bH24bHoFPRUKSi1QKZqfOHhYo7nNUqn8=
X-Received: by 2002:a05:6000:2d05:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3a8ffcc9dbcmr9562093f8f.33.1751355088902; 
 Tue, 01 Jul 2025 00:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8A0BtkNY/BURreIBIN7CA9kj9MdFTxXKeydcpEymhrUx7UZFhaRabP0kT/8wIyiTuKPtX1g==
X-Received: by 2002:a05:6000:2d05:b0:3a4:e841:b236 with SMTP id
 ffacd0b85a97d-3a8ffcc9dbcmr9562066f8f.33.1751355088347; 
 Tue, 01 Jul 2025 00:31:28 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f?
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b5aesm12270877f8f.44.2025.07.01.00.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 00:31:27 -0700 (PDT)
Message-ID: <adb4880a-879c-4f77-a2b3-a1f2f62ca456@redhat.com>
Date: Tue, 1 Jul 2025 09:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/21] fuse: Implement multi-threading
To: Brian <hibriansong@gmail.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-19-hreitz@redhat.com>
 <a0842801-ac45-4708-9253-8ec600e9c4aa@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <a0842801-ac45-4708-9253-8ec600e9c4aa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27.06.25 03:08, Brian wrote:
>
>
> On 6/4/25 9:28 AM, Hanna Czenczek wrote:
>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>
>> We can use this to implement multi-threading.
>>
>> For configuration, we don't need any more information beyond the simple
>> array provided by the core block export interface: The FUSE kernel
>> driver feeds these FDs in a round-robin fashion, so all of them are
>> equivalent and we want to have exactly one per thread.
>>
>> These are the benchmark results when using four threads (compared to a
>> single thread); note that fio still only uses a single job, but
>> performance can still be improved because of said round-robin usage for
>> the queues.  (Not in the sync case, though, in which case I guess it
>> just adds overhead.)
>>
>> file:
>>    read:
>>      seq aio:   264.8k ±0.8k (+120 %)
>>      rand aio:  143.8k ±0.4k (+ 27 %)
>>      seq sync:   49.9k ±0.5k (-  5 %)
>>      rand sync:  10.3k ±0.1k (-  1 %)
>>    write:
>>      seq aio:   226.6k ±2.1k (+184 %)
>>      rand aio:  225.9k ±1.8k (+186 %)
>>      seq sync:   36.9k ±0.6k (- 11 %)
>>      rand sync:  36.9k ±0.2k (- 11 %)
>> null:
>>    read:
>>      seq aio:   315.2k ±11.0k (+18 %)
>>      rand aio:  300.5k ±10.8k (+14 %)
>>      seq sync:  114.2k ± 3.6k (-16 %)
>>      rand sync: 112.5k ± 2.8k (-16 %)
>>    write:
>>      seq aio:   222.6k ±6.8k (-21 %)
>>      rand aio:  220.5k ±6.8k (-23 %)
>>      seq sync:  117.2k ±3.7k (-18 %)
>>      rand sync: 116.3k ±4.4k (-18 %)
>>
>> (I don't know what's going on in the null-write AIO case, sorry.)
>>
>> Here's results for numjobs=4:
>>
>> "Before", i.e. without multithreading in QSD/FUSE (results compared to
>> numjobs=1):
>>
>> file:
>>    read:
>>      seq aio:   104.7k ± 0.4k (- 13 %)
>>      rand aio:  111.5k ± 0.4k (-  2 %)
>>      seq sync:   71.0k ±13.8k (+ 36 %)
>>      rand sync:  41.4k ± 0.1k (+297 %)
>>    write:
>>      seq aio:    79.4k ±0.1k (-  1 %)
>>      rand aio:   78.6k ±0.1k (±  0 %)
>>      seq sync:   83.3k ±0.1k (+101 %)
>>      rand sync:  82.0k ±0.2k (+ 98 %)
>> null:
>>    read:
>>      seq aio:   260.5k ±1.5k (-  2 %)
>>      rand aio:  260.1k ±1.4k (-  2 %)
>>      seq sync:  291.8k ±1.3k (+115 %)
>>      rand sync: 280.1k ±1.7k (+115 %)
>>    write:
>>      seq aio:   280.1k ±1.7k (±  0 %)
>>      rand aio:  279.5k ±1.4k (-  3 %)
>>      seq sync:  306.7k ±2.2k (+116 %)
>>      rand sync: 305.9k ±1.8k (+117 %)
>>
>> (As probably expected, little difference in the AIO case, but great
>> improvements in the sync case because it kind of gives it an artificial
>> iodepth of 4.)
>>
>> "After", i.e. with four threads in QSD/FUSE (now results compared to the
>> above):
>>
>> file:
>>    read:
>>      seq aio:   193.3k ± 1.8k (+ 85 %)
>>      rand aio:  329.3k ± 0.3k (+195 %)
>>      seq sync:   66.2k ±13.0k (-  7 %)
>>      rand sync:  40.1k ± 0.0k (-  3 %)
>>    write:
>>      seq aio:   219.7k ±0.8k (+177 %)
>>      rand aio:  217.2k ±1.5k (+176 %)
>>      seq sync:   92.5k ±0.2k (+ 11 %)
>>      rand sync:  91.9k ±0.2k (+ 12 %)
>> null:
>>    read:
>>      seq aio:   706.7k ±2.1k (+171 %)
>>      rand aio:  714.7k ±3.2k (+175 %)
>>      seq sync:  431.7k ±3.0k (+ 48 %)
>>      rand sync: 435.4k ±2.8k (+ 50 %)
>>    write:
>>      seq aio:   746.9k ±2.8k (+167 %)
>>      rand aio:  749.0k ±4.9k (+168 %)
>>      seq sync:  420.7k ±3.1k (+ 37 %)
>>      rand sync: 419.1k ±2.5k (+ 37 %)
>>
>> So this helps mainly for the AIO cases, but also in the null sync cases,
>> because null is always CPU-bound, so more threads help.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/export/fuse.c | 205 ++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 159 insertions(+), 46 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 44f0b796b3..cdec31f2a8 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -31,11 +31,14 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/main-loop.h"
>>   #include "system/block-backend.h"
>> +#include "system/block-backend.h"
>> +#include "system/iothread.h"
>>     #include <fuse.h>
>>   #include <fuse_lowlevel.h>
>>     #include "standard-headers/linux/fuse.h"
>> +#include <sys/ioctl.h>
>>     #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
>>   #include <linux/falloc.h>
>> @@ -50,12 +53,17 @@
>>   /* Small enough to fit in the request buffer */
>>   #define FUSE_MAX_WRITE_BYTES (4 * 1024)
>>   -typedef struct FuseExport {
>> -    BlockExport common;
>> +typedef struct FuseExport FuseExport;
>>   -    struct fuse_session *fuse_session;
>> -    unsigned int in_flight; /* atomic */
>> -    bool mounted, fd_handler_set_up;
>> +/*
>> + * One FUSE "queue", representing one FUSE FD from which requests 
>> are fetched
>> + * and processed.  Each queue is tied to an AioContext.
>> + */
>> +typedef struct FuseQueue {
>> +    FuseExport *exp;
>> +
>> +    AioContext *ctx;
>> +    int fuse_fd;
>>         /*
>>        * The request buffer must be able to hold a full write, and/or 
>> at least
>> @@ -66,6 +74,14 @@ typedef struct FuseExport {
>>                FUSE_MAX_WRITE_BYTES,
>>           FUSE_MIN_READ_BUFFER
>>       )];
>> +} FuseQueue;
>> +
>> +struct FuseExport {
>> +    BlockExport common;
>> +
>> +    struct fuse_session *fuse_session;
>> +    unsigned int in_flight; /* atomic */
>> +    bool mounted, fd_handler_set_up;
>>         /*
>>        * Set when there was an unrecoverable error and no requests 
>> should be read
>> @@ -74,7 +90,15 @@ typedef struct FuseExport {
>>        */
>>       bool halted;
>>   -    int fuse_fd;
>> +    int num_queues;
>> +    FuseQueue *queues;
>> +    /*
>> +     * True if this export should follow the generic export's 
>> AioContext.
>> +     * Will be false if the queues' AioContexts have been explicitly 
>> set by the
>> +     * user, i.e. are expected to stay in those contexts.
>> +     * (I.e. is always false if there is more than one queue.)
>> +     */
>> +    bool follow_aio_context;
>>         char *mountpoint;
>>       bool writable;
>> @@ -85,11 +109,11 @@ typedef struct FuseExport {
>>       mode_t st_mode;
>>       uid_t st_uid;
>>       gid_t st_gid;
>> -} FuseExport;
>> +};
>>     /* Parameters to the request processing coroutine */
>>   typedef struct FuseRequestCoParam {
>> -    FuseExport *exp;
>> +    FuseQueue *q;
>>       int got_request;
>>   } FuseRequestCoParam;
>>   @@ -102,11 +126,12 @@ static void fuse_export_halt(FuseExport *exp);
>>   static void init_exports_table(void);
>>     static int mount_fuse_export(FuseExport *exp, Error **errp);
>> +static int clone_fuse_fd(int fd, Error **errp);
>>     static bool is_regular_file(const char *path, Error **errp);
>>     static void read_from_fuse_fd(void *opaque);
>> -static void coroutine_fn fuse_co_process_request(FuseExport *exp);
>> +static void coroutine_fn fuse_co_process_request(FuseQueue *q);
>>     static void fuse_inc_in_flight(FuseExport *exp)
>>   {
>> @@ -136,8 +161,11 @@ static void fuse_attach_handlers(FuseExport *exp)
>>           return;
>>       }
>>   -    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
>> -                       read_from_fuse_fd, NULL, NULL, NULL, exp);
>> +    for (int i = 0; i < exp->num_queues; i++) {
>> +        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
>> +                           read_from_fuse_fd, NULL, NULL, NULL,
>> +                           &exp->queues[i]);
>> +    }
>>       exp->fd_handler_set_up = true;
>>   }
>>   @@ -146,8 +174,10 @@ static void fuse_attach_handlers(FuseExport *exp)
>>    */
>>   static void fuse_detach_handlers(FuseExport *exp)
>>   {
>> -    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
>> -                       NULL, NULL, NULL, NULL, NULL);
>> +    for (int i = 0; i < exp->num_queues; i++) {
>> +        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
>> +                           NULL, NULL, NULL, NULL, NULL);
>> +    }
>>       exp->fd_handler_set_up = false;
>>   }
>>   @@ -162,6 +192,11 @@ static void fuse_export_drained_end(void *opaque)
>>         /* Refresh AioContext in case it changed */
>>       exp->common.ctx = blk_get_aio_context(exp->common.blk);
>> +    if (exp->follow_aio_context) {
>> +        assert(exp->num_queues == 1);
>> +        exp->queues[0].ctx = exp->common.ctx;
>> +    }
>> +
>>       fuse_attach_handlers(exp);
>>   }
>>   @@ -192,8 +227,32 @@ static int fuse_export_create(BlockExport 
>> *blk_exp,
>>       assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
>>         if (multithread) {
>> -        error_setg(errp, "FUSE export does not support 
>> multi-threading");
>> -        return -EINVAL;
>> +        /* Guaranteed by common export code */
>> +        assert(mt_count >= 1);
>> +
>> +        exp->follow_aio_context = false;
>> +        exp->num_queues = mt_count;
>> +        exp->queues = g_new(FuseQueue, mt_count);
>> +
>> +        for (size_t i = 0; i < mt_count; i++) {
>> +            exp->queues[i] = (FuseQueue) {
>> +                .exp = exp,
>> +                .ctx = multithread[i],
>> +                .fuse_fd = -1,
>> +            };
>> +        }
>> +    } else {
>> +        /* Guaranteed by common export code */
>> +        assert(mt_count == 0);
>> +
>> +        exp->follow_aio_context = true;
>> +        exp->num_queues = 1;
>> +        exp->queues = g_new(FuseQueue, 1);
>> +        exp->queues[0] = (FuseQueue) {
>> +            .exp = exp,
>> +            .ctx = exp->common.ctx,
>> +            .fuse_fd = -1,
>> +        };
>>       }
>>         /* For growable and writable exports, take the RESIZE 
>> permission */
>> @@ -280,13 +339,23 @@ static int fuse_export_create(BlockExport 
>> *blk_exp,
>>         g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
>>   -    exp->fuse_fd = fuse_session_fd(exp->fuse_session);
>> -    ret = qemu_fcntl_addfl(exp->fuse_fd, O_NONBLOCK);
>> +    assert(exp->num_queues >= 1);
>> +    exp->queues[0].fuse_fd = fuse_session_fd(exp->fuse_session);
>> +    ret = qemu_fcntl_addfl(exp->queues[0].fuse_fd, O_NONBLOCK);
>>       if (ret < 0) {
>>           error_setg_errno(errp, -ret, "Failed to make FUSE FD 
>> non-blocking");
>>           goto fail;
>>       }
>>   +    for (int i = 1; i < exp->num_queues; i++) {
>> +        int fd = clone_fuse_fd(exp->queues[0].fuse_fd, errp);
>> +        if (fd < 0) {
>> +            ret = fd;
>> +            goto fail;
>> +        }
>> +        exp->queues[i].fuse_fd = fd;
>> +    }
>> +
>>       fuse_attach_handlers(exp);
>>       return 0;
>>   @@ -359,9 +428,42 @@ static int mount_fuse_export(FuseExport *exp, 
>> Error **errp)
>>       return 0;
>>   }
>>   +/**
>> + * Clone the given /dev/fuse file descriptor, yielding a second FD 
>> from which
>> + * requests can be pulled for the associated filesystem. Returns an 
>> FD on
>> + * success, and -errno on error.
>> + */
>> +static int clone_fuse_fd(int fd, Error **errp)
>> +{
>> +    uint32_t src_fd = fd;
>> +    int new_fd;
>> +    int ret;
>> +
>> +    /*
>> +     * The name "/dev/fuse" is fixed, see libfuse's lib/fuse_loop_mt.c
>> +     * (fuse_clone_chan()).
>> +     */
>> +    new_fd = open("/dev/fuse", O_RDWR | O_CLOEXEC | O_NONBLOCK);
>> +    if (new_fd < 0) {
>> +        ret = -errno;
>> +        error_setg_errno(errp, errno, "Failed to open /dev/fuse");
>> +        return ret;
>> +    }
>> +
>> +    ret = ioctl(new_fd, FUSE_DEV_IOC_CLONE, &src_fd);
>> +    if (ret < 0) {
>> +        ret = -errno;
>> +        error_setg_errno(errp, errno, "Failed to clone FUSE FD");
>> +        close(new_fd);
>> +        return ret;
>> +    }
>> +
>> +    return new_fd;
>> +}
>> +
>>   /**
>>    * Try to read a single request from the FUSE FD.
>> - * Takes a FuseExport pointer in `opaque`.
>> + * Takes a FuseQueue pointer in `opaque`.
>>    *
>>    * Assumes the export's in-flight counter has already been 
>> incremented.
>>    *
>> @@ -369,8 +471,9 @@ static int mount_fuse_export(FuseExport *exp, 
>> Error **errp)
>>    */
>>   static void coroutine_fn co_read_from_fuse_fd(void *opaque)
>>   {
>> -    FuseExport *exp = opaque;
>> -    int fuse_fd = exp->fuse_fd;
>> +    FuseQueue *q = opaque;
>> +    int fuse_fd = q->fuse_fd;
>> +    FuseExport *exp = q->exp;
>>       ssize_t ret;
>>       const struct fuse_in_header *in_hdr;
>>   @@ -378,8 +481,7 @@ static void coroutine_fn 
>> co_read_from_fuse_fd(void *opaque)
>>           goto no_request;
>>       }
>>   -    ret = RETRY_ON_EINTR(read(fuse_fd, exp->request_buf,
>> -                              sizeof(exp->request_buf)));
>> +    ret = RETRY_ON_EINTR(read(fuse_fd, q->request_buf, 
>> sizeof(q->request_buf)));
>>       if (ret < 0 && errno == EAGAIN) {
>>           /* No request available */
>>           goto no_request;
>> @@ -397,7 +499,7 @@ static void coroutine_fn 
>> co_read_from_fuse_fd(void *opaque)
>>           goto no_request;
>>       }
>>   -    in_hdr = (const struct fuse_in_header *)exp->request_buf;
>> +    in_hdr = (const struct fuse_in_header *)q->request_buf;
>>       if (unlikely(ret != in_hdr->len)) {
>>           error_report("Number of bytes read from FUSE device does 
>> not match "
>>                        "request size, expected %" PRIu32 " bytes, 
>> read %zi "
>> @@ -408,7 +510,7 @@ static void coroutine_fn 
>> co_read_from_fuse_fd(void *opaque)
>>           goto no_request;
>>       }
>>   -    fuse_co_process_request(exp);
>> +    fuse_co_process_request(q);
>>     no_request:
>>       fuse_dec_in_flight(exp);
>> @@ -417,16 +519,16 @@ no_request:
>>   /**
>>    * Try to read and process a single request from the FUSE FD.
>>    * (To be used as a handler for when the FUSE FD becomes readable.)
>> - * Takes a FuseExport pointer in `opaque`.
>> + * Takes a FuseQueue pointer in `opaque`.
>>    */
>>   static void read_from_fuse_fd(void *opaque)
>>   {
>> -    FuseExport *exp = opaque;
>> +    FuseQueue *q = opaque;
>>       Coroutine *co;
>>   -    co = qemu_coroutine_create(co_read_from_fuse_fd, exp);
>> +    co = qemu_coroutine_create(co_read_from_fuse_fd, q);
>>       /* Decremented by co_read_from_fuse_fd() */
>> -    fuse_inc_in_flight(exp);
>> +    fuse_inc_in_flight(q->exp);
>>       qemu_coroutine_enter(co);
>>   }
>>   @@ -451,6 +553,16 @@ static void fuse_export_delete(BlockExport 
>> *blk_exp)
>>   {
>>       FuseExport *exp = container_of(blk_exp, FuseExport, common);
>>   +    for (int i = 0; i < exp->num_queues; i++) {
>> +        FuseQueue *q = &exp->queues[i];
>> +
>> +        /* Queue 0's FD belongs to the FUSE session */
>> +        if (i > 0 && q->fuse_fd >= 0) {
>> +            close(q->fuse_fd);
>> +        }
>> +    }
>> +    g_free(exp->queues);
>> +
>>       if (exp->fuse_session) {
>>           if (exp->mounted) {
>>               fuse_session_unmount(exp->fuse_session);
>> @@ -1108,23 +1220,23 @@ static int fuse_write_buf_response(int fd, 
>> uint32_t req_id,
>>   /*
>>    * For use in fuse_co_process_request():
>>    * Returns a pointer to the parameter object for the given 
>> operation (inside of
>> - * exp->request_buf, which is assumed to hold a fuse_in_header first).
>> - * Verifies that the object is complete (exp->request_buf is large 
>> enough to
>> + * q->request_buf, which is assumed to hold a fuse_in_header first).
>> + * Verifies that the object is complete (q->request_buf is large 
>> enough to
>>    * hold it in one piece, and the request length includes the whole 
>> object).
>>    *
>> - * Note that exp->request_buf may be overwritten after yielding, so 
>> the returned
>> + * Note that q->request_buf may be overwritten after yielding, so 
>> the returned
>>    * pointer must not be used across a function that may yield!
>>    */
>> -#define FUSE_IN_OP_STRUCT(op_name, export) \
>> +#define FUSE_IN_OP_STRUCT(op_name, queue) \
>
> Should `q` actually be `queue` (i.e. the second parameter)?

Right!  (And before, the comment should call it `export`, not `exp`)

Thanks, I’ll fix it.

Hanna


