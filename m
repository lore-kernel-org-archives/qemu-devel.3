Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C103F532EC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4wsO-0006OZ-WB; Tue, 24 Mar 2026 04:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4wsN-0006OA-Jn
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4wsL-00016c-Gz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774339951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICHirUpQxuQk99gTx4ZfYSn5+71PumbyOyIBnXo6Q9o=;
 b=EHMUL75LqRsB3qJqUkncoWVnD3dgMJnuqGLsbJJ5XVAt/3sZI9D6VxMfYE2k53eFzUohMC
 ggUOyu64yL8X1pR7vEoO4rGlv7utJycrOeXzSXjfbB02qeAdiZnd79QcVveBugwMW1woZ/
 VLzAzteAP0iUpccojWI5uQgTKI0OoqE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-BixhPtGiOJGfPhU0LDTr2g-1; Tue, 24 Mar 2026 04:12:29 -0400
X-MC-Unique: BixhPtGiOJGfPhU0LDTr2g-1
X-Mimecast-MFC-AGG-ID: BixhPtGiOJGfPhU0LDTr2g_1774339948
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b7ec737c1so1005017f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774339948; x=1774944748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ICHirUpQxuQk99gTx4ZfYSn5+71PumbyOyIBnXo6Q9o=;
 b=n1WXWvH65uYkmokvqbSadVFJZRxHExKZa288o6syrJI8HDZG5wkm93EQ2Y81mw1y6L
 pvCp0R4kzVceAQ9NiBY6NIROtQl2pjx/KSS42e6CJSWqHCZ4aF70E+cEJGTjdK3xDNIh
 Gtdv87REBsSqqst2u+7LjOwZQWjJPJCuUPjR/o3ihW9UU8F7fkVezD9aJvU9kXzk7zdP
 JHbHa2jpbn/DHrzHc6TkaL6xkaA5yi426LwnktYeFsPCfUuXiHjf54OeKtLmXn1dlgjh
 b7EHG9Ys8Fi5bUCwITlyJgbFDMKnDCui7+1iCBUFWWg1A5CxByqIqk0bc3Npl8CfcaUn
 fIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774339948; x=1774944748;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ICHirUpQxuQk99gTx4ZfYSn5+71PumbyOyIBnXo6Q9o=;
 b=eqNCOUCRli8RdYjnBT2LahoEJS1sHkg+9yRvv7G6my9Z3JUL2kkZC1KldF5GDjNTtN
 inPrThpU6yy3833lKDOTWdOv7Te9Yd/logxxKHg+p9BY2bJTwxjzt8a+ESKaEHKeamzD
 cKdKu9dBcS/Xu5vDetr+gpN7m7m3Axy0IxNa/VQucu0xIU1vA4XdlHH6X/ZMS2dAuRq1
 J/CNhiDZfQDylWvLweesc4HfpQSfd68YF+QFByZnufFP8GHYEPf7+X1Wfu/ngaC7gncd
 wiSzQPPcZTJxtLwTeoIY0pi4wzWeFCW2ltx4MNFK9EdCJbxXUdtzt6DPPWYg50bzjoVx
 OxuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzfNmGgM+2ZeMnmjnXpWejoWjsTFMakLgosMmd/YBrCLVMApdA1j/NBQ93Wnzf7/mpFmbc33wUmTgN@nongnu.org
X-Gm-Message-State: AOJu0YxvBAxEwOv80UuKvXnYuwWSTg9PNsarU2HvwZqFF/NrL2hzwHWr
 7PhpPF17VsST5KNaH5prmLv4PKO5zDzD0Y3tJZ+dq/mXu0Ij6/W73XnpSejEuDiGdI6p+rtNKCZ
 UEZssLKuJg/Pa+qdFnH31jkBrYNuAZnPgqcU0BbYKUIQDOHVVC0uzrIWw
X-Gm-Gg: ATEYQzzBo58MLVnRxPEYzQqHJCoFJXpZzGRq6PoaVvSLXveh83NcpyB6OfnxqabarnG
 cF3E/YA/eVBGdVOfSEIHWHs/Nvizgg6R780i+eFO8PDC3LODcImz0rhwLf1b87XhX25v8d2WxLk
 4T8R08E9SEuqfmtea9Au+WRjCkxsZdrZpjuLSFBChvPN/Luu7/5Gc5e7dj2mu/ukoblBVUaOKnC
 jYjvPLm/e4aduVP+7flxniaZ4ENU8aTiYjxp1gLRKr9ktX47hLbYM32zcIrQECzbslP8EthtqY+
 YxrfuO4W8nhHL5qU2k//H4aT9NJ6OZBkJC6/k4F30G5PHtg6b2FqWfcS9J8Uv/vkUn/o0BNX5jP
 1PVGW5Eg7lI3zpUHykeE5E79Jo/FkN438nO0gwHF6IoFu7vFSrDzXG/iN3aKnmJrxtFNDS6ZwR8
 lBLDvnFncEjLyy54i/XrXArhZdqwPqQrxYXNCoRe/O34WiCkxZ+Ms=
X-Received: by 2002:a05:6000:2010:b0:43b:509c:51fe with SMTP id
 ffacd0b85a97d-43b6424e349mr22815927f8f.13.1774339947993; 
 Tue, 24 Mar 2026 01:12:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2010:b0:43b:509c:51fe with SMTP id
 ffacd0b85a97d-43b6424e349mr22815866f8f.13.1774339947348; 
 Tue, 24 Mar 2026 01:12:27 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03c:df99:cbc9:b444:8cfa?
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae016sm34646990f8f.4.2026.03.24.01.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 01:12:26 -0700 (PDT)
Message-ID: <9f951ced-6d40-4bd2-8cde-3b0be7503803@redhat.com>
Date: Tue, 24 Mar 2026 09:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 2/3] linux-aio: Resubmit tails of short
 reads/writes
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <20260318153206.171494-3-hreitz@redhat.com> <acF0V3W4aWhP-Zlg@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <acF0V3W4aWhP-Zlg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23.03.26 18:12, Kevin Wolf wrote:
> Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
>> Short reads/writes can happen.  One way to reproduce them is via our
>> FUSE export, with the following diff applied (%s/escaped // to apply --
>> if you put plain diffs in commit messages, git-am will apply them, and I
>> would rather avoid breaking FUSE accidentally via this patch):
>>
>> escaped diff --git a/block/export/fuse.c b/block/export/fuse.c
>> escaped index a2a478d293..67dc50a412 100644
>> escaped --- a/block/export/fuse.c
>> escaped +++ b/block/export/fuse.c
>> @@ -828,7 +828,7 @@ static ssize_t coroutine_fn GRAPH_RDLOCK
>>   fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
>>                const struct fuse_init_in_compat *in)
>>   {
>> -    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
>> +    const uint32_t supported_flags = FUSE_ASYNC_READ;
>>
>>       if (in->major != 7) {
>>           error_report("FUSE major version mismatch: We have 7, but kernel has %"
>> @@ -1060,6 +1060,8 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
>>       void *buf;
>>       int ret;
>>
>> +    size = MIN(size, 4096);
>> +
>>       /* Limited by max_read, should not happen */
>>       if (size > FUSE_MAX_READ_BYTES) {
>>           return -EINVAL;
>> @@ -1110,6 +1112,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
>>       int64_t blk_len;
>>       int ret;
>>
>> +    size = MIN(size, 4096);
>> +
>>       QEMU_BUILD_BUG_ON(FUSE_MAX_WRITE_BYTES > BDRV_REQUEST_MAX_BYTES);
>>       /* Limited by max_write, should not happen */
>>       if (size > FUSE_MAX_WRITE_BYTES) {
>>
>> Then:
>> $ ./qemu-img create -f raw test.raw 8k
>> Formatting 'test.raw', fmt=raw size=8192
>> $ ./qemu-io -f raw -c 'write -P 42 0 8k' test.raw
>> wrote 8192/8192 bytes at offset 0
>> 8 KiB, 1 ops; 00.00 sec (64.804 MiB/sec and 8294.9003 ops/sec)
>> $ hexdump -C test.raw
>> 00000000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
>> *
>> 00002000
>>
>> With aio=threads, short I/O works:
>> $ storage-daemon/qemu-storage-daemon \
>>      --blockdev file,node-name=test,filename=test.raw \
>>      --export fuse,id=exp,node-name=test,mountpoint=test.raw,writable=true
>>
>> Other shell:
>> $ ./qemu-io --image-opts -c 'read -P 42 0 8k' \
>>      driver=file,filename=test.raw,cache.direct=on,aio=threads
>> read 8192/8192 bytes at offset 0
>> 8 KiB, 1 ops; 00.00 sec (36.563 MiB/sec and 4680.0923 ops/sec)
>> $ ./qemu-io --image-opts -c 'write -P 23 0 8k' \
>>      driver=file,filename=test.raw,cache.direct=on,aio=threads
>> wrote 8192/8192 bytes at offset 0
>> 8 KiB, 1 ops; 00.00 sec (35.995 MiB/sec and 4607.2970 ops/sec)
>> $ hexdump -C test.raw
>> 00000000  17 17 17 17 17 17 17 17  17 17 17 17 17 17 17 17  |................|
>> *
>> 00002000
>>
>> But with aio=native, it does not:
>> $ ./qemu-io --image-opts -c 'read -P 23 0 8k' \
>>      driver=file,filename=test.raw,cache.direct=on,aio=native
>> Pattern verification failed at offset 0, 8192 bytes
>> read 8192/8192 bytes at offset 0
>> 8 KiB, 1 ops; 00.00 sec (86.155 MiB/sec and 11027.7900 ops/sec)
>> $ ./qemu-io --image-opts -c 'write -P 42 0 8k' \
>>      driver=file,filename=test.raw,cache.direct=on,aio=native
>> write failed: No space left on device
>> $ hexdump -C test.raw
>> 00000000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
>> *
>> 00001000  17 17 17 17 17 17 17 17  17 17 17 17 17 17 17 17  |................|
>> *
>> 00002000
>>
>> This patch fixes that.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/linux-aio.c | 61 ++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 53 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/linux-aio.c b/block/linux-aio.c
>> index 1f25339dc9..01621d4794 100644
>> --- a/block/linux-aio.c
>> +++ b/block/linux-aio.c
>> @@ -46,6 +46,10 @@ struct qemu_laiocb {
>>       size_t nbytes;
>>       QEMUIOVector *qiov;
>>   
>> +    /* For handling short reads/writes */
>> +    size_t total_done;
>> +    QEMUIOVector resubmit_qiov;
>> +
>>       int type;
>>       BdrvRequestFlags flags;
>>       uint64_t dev_max_batch;
>> @@ -73,28 +77,61 @@ struct LinuxAioState {
>>   };
>>   
>>   static void ioq_submit(LinuxAioState *s);
>> +static int laio_do_submit(struct qemu_laiocb *laiocb);
>>   
>>   static inline ssize_t io_event_ret(struct io_event *ev)
>>   {
>>       return (ssize_t)(((uint64_t)ev->res2 << 32) | ev->res);
>>   }
>>   
>> +/**
>> + * Retry tail of short requests.
>> + */
>> +static int laio_resubmit_short_io(struct qemu_laiocb *laiocb, size_t done)
>> +{
>> +    QEMUIOVector *resubmit_qiov = &laiocb->resubmit_qiov;
>> +
>> +    laiocb->total_done += done;
>> +
>> +    if (!resubmit_qiov->iov) {
>> +        qemu_iovec_init(resubmit_qiov, laiocb->qiov->niov);
>> +    } else {
>> +        qemu_iovec_reset(resubmit_qiov);
>> +    }
>> +    qemu_iovec_concat(resubmit_qiov, laiocb->qiov,
>> +                      laiocb->total_done, laiocb->nbytes - laiocb->total_done);
>> +
>> +    return laio_do_submit(laiocb);
>> +}
>> +
>>   /*
>>    * Completes an AIO request.
>>    */
>>   static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
>>   {
>> -    int ret;
>> +    ssize_t ret;
>>   
>>       ret = laiocb->ret;
>>       if (ret != -ECANCELED) {
>> -        if (ret == laiocb->nbytes) {
>> +        if (ret == laiocb->nbytes - laiocb->total_done) {
>>               ret = 0;
>> +        } else if (ret > 0 && (laiocb->type == QEMU_AIO_READ ||
>> +                               laiocb->type == QEMU_AIO_WRITE)) {
>> +            ret = laio_resubmit_short_io(laiocb, ret);
>> +            if (!ret) {
>> +                return;
>> +            }
>>           } else if (ret >= 0) {
>> -            /* Short reads mean EOF, pad with zeros. */
>> +            /*
>> +             * For normal reads and writes, we only get here if ret == 0, which
>> +             * means EOF for reads and ENOSPC for writes.
>> +             * For zone-append, we get here with any ret >= 0, which we just
>> +             * treat as ENOSPC, too (safer than resubmitting, probably, but not
>> +             * 100 % clear).
>> +             */
>>               if (laiocb->type == QEMU_AIO_READ) {
>> -                qemu_iovec_memset(laiocb->qiov, ret, 0,
>> -                    laiocb->qiov->size - ret);
>> +                qemu_iovec_memset(laiocb->qiov, laiocb->total_done, 0,
>> +                                  laiocb->qiov->size - laiocb->total_done);
>>               } else {
>>                   ret = -ENOSPC;
>>               }
>> @@ -102,6 +139,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
>>       }
>>   
>>       laiocb->ret = ret;
>> +    qemu_iovec_destroy(&laiocb->resubmit_qiov);
> Calling qemu_iovec_destroy() for a qiov that has potentially never been
> initialised feels a bit unsafe to me. It will work in practice for the
> current implementation, but maybe make this one conditional on
> laiocb->resubmit_qiov.iov, too? (Which is already making assumptions
> about the internals of QEMUIOVector, but that we'll have an iov after
> initialising the qiov with qemu_iovec_init() above will probably never
> change.)

Sure!

(For reference, the io-uring code calls qemu_iovec_destroy() the same 
way, but I agree.  I’ll make that change there, too.)

>>       /*
>>        * If the coroutine is already entered it must be in ioq_submit() and
>> @@ -380,23 +418,30 @@ static int laio_do_submit(struct qemu_laiocb *laiocb)
>>       int fd = laiocb->fd;
>>       off_t offset = laiocb->offset;
> I wonder if making it laiocb->offset + laiocb->total_done here wouldn't
> be more robust than having the addition in every call below.

I had it that way originally, but then decided to put it into the calls 
below to show better which ones can actually be retried.  Yes, the ones 
not retried (zone_append) will always have total_done == 0, but I found 
this clearer, personally.

Maybe I’ll make it two variables, original_offset and offset.

Hanna

>> +    if (laiocb->resubmit_qiov.iov) {
>> +        qiov = &laiocb->resubmit_qiov;
>> +    }
>> +
>>       switch (laiocb->type) {
>>       case QEMU_AIO_WRITE:
>>   #ifdef HAVE_IO_PREP_PWRITEV2
>>       {
>>           int laio_flags = (laiocb->flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
>> -        io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flags);
>> +        io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov,
>> +                         offset + laiocb->total_done, laio_flags);
>>       }
>>   #else
>>           assert(laiocb->flags == 0);
>> -        io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
>> +        io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov,
>> +                        offset + laiocb->total_done);
>>   #endif
>>           break;
>>       case QEMU_AIO_ZONE_APPEND:
>>           io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
>>           break;
>>       case QEMU_AIO_READ:
>> -        io_prep_preadv(iocbs, fd, qiov->iov, qiov->niov, offset);
>> +        io_prep_preadv(iocbs, fd, qiov->iov, qiov->niov,
>> +                       offset + laiocb->total_done);
>>           break;
>>       case QEMU_AIO_FLUSH:
>>           io_prep_fdsync(iocbs, fd);
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>


