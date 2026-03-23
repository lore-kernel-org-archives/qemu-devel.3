Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C0AF483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ig6-00074S-Gk; Mon, 23 Mar 2026 13:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ify-00073E-7n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4ifw-0001s1-NV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774285366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ciZ1G3TT2OJ0QMILMLlSZieustja0FvVtFvn0z1/4b8=;
 b=GnD33FCqYA/inRIZvrllGheUvE20UVzbqeaUKIrBBGC2wppQPwZdgzeHaKHxsE94sQRapQ
 JVdL2/giZjKxMY9Hnvv5KaLdmy34MM0mwe5TIkdISrcC+CZ3Y0cl7Ri2FMr9MSIjLOrMoN
 YxDEM8kqRd7VcWMu4UazZciKwmyUt8M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-mvXQ0cFcOR65SevNlvX6ww-1; Mon, 23 Mar 2026 13:02:43 -0400
X-MC-Unique: mvXQ0cFcOR65SevNlvX6ww-1
X-Mimecast-MFC-AGG-ID: mvXQ0cFcOR65SevNlvX6ww_1774285362
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b4454b459so1863675f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774285362; x=1774890162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ciZ1G3TT2OJ0QMILMLlSZieustja0FvVtFvn0z1/4b8=;
 b=EkkpKD5sm+/IuhZqplIBF7uy/n1AgbpTpFKvVkUeumZxbL9uHp0f+WIoJXVabRscj5
 LnlbkSFHQKeFwgGujXqsyMbUwXSOYGmVwP9HjOBVkAgAunvthntDWhhfQAGFJH6hwPA6
 JRfVHCabXK4F4opUzz7p1yvp9opuoYLMnTH2YcQHMYDj0nrvUwf69r5Lp2fSJ46RNPfe
 5R+9LFs9X2u6PH4CU2g3TMkN8hoyX8phMJqiJuXFM4KapT5NpQqlYX1LcnGyfj3Wqws/
 71dxX5loM1hHKaWE4jKcyeKmQ2ANQFM4yVa6ld93CNDSZ5Z4+UrQpAHpKUINqTP6E9OJ
 hHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285362; x=1774890162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciZ1G3TT2OJ0QMILMLlSZieustja0FvVtFvn0z1/4b8=;
 b=CFLPeDVBazkwl6KbsmFR+Z2nAokO8wqtL6kG0udXZnDNSGybUgN2dw/1yYevai4qp8
 JJGlyAgGKTEYByfzbfoF2D7IpkmCVos4oS6jt/WOw6qslnf0uE95AEcL9wQu9TcoR7Sr
 NT9yH8nD8Fe5qDqTXWG6nhUdL+FmBjlfXz5ANwVLVdQOu1EnZie3UwoBiXZ3kyUD/Su/
 hvvdh3tG4ZQ6qULy+yfpuRZi2x+u2Y2KYSD9zn4y/I1qRjgSiLlAqnmQf+Uy92qvE3kW
 UvPURFSQ3grIfFS81nL00bB+e8DRV6t2gRcbrjB4S0KjrFNducLrnKe5rCP9OtkGd5p9
 0b6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ2I9J8r8aoTE3bLtPp2333BGuTihE7ULXBC1Dyi4yKeewbKLiMJ40hGVfTILkWusUlQ61uqtVOqjT@nongnu.org
X-Gm-Message-State: AOJu0YyGvnx179A1d6zYSZdAZSCNGxvuBywOnlXxXflFa6HFh+bULp0f
 pUs0q8Hh6Xauk0jS+isgyZLUBo94y2fYKOx9/pB+8DsRPdjqlsFNqipi6VXTqpTF+b2AfdDU+tr
 6rrRdp+5GwwaFh0X/Zi+Fem4h9zs9V8YcIPejp0Wo6yM7vRzfyO7nHX9Q
X-Gm-Gg: ATEYQzyBvDQW57aUXbPXuTDg1HlONI4VvXxAZaVyozQIGO089Kos0YNLjPovN68cBj7
 Op7VqJk/ft8vigbrmENlHwGgkm2v88d7hnlnPq6nL/M+dSNetIBwYUiqAlvD5HkG4WD6ftNzyXH
 C/5gc6Kpi2WKuwTrhbwf4vyjVNiwFeOyuI1hKvMmke6Zw1rDrgYAs0HRU+IU6dqq4W/3FpsYhCa
 UMQdCIH078Qgy7imvwB9Vjw5EbQkyAppI3GXCLWuUGzgBRq3rYmot11YhDBexwlD/1jwTfaT4zB
 I1cOSY36UZDYYDc8/wGZlWtIprH6Zt59M91aQRjqf+vqV0IlFlqfVY5uraa6MbwFoaZuwpDoi8n
 mb1aCqh+jpF9mOGUVmp3TXRP2AIvavMOu33IK2bAXIk1QRb2N1tbmSUg53e+BEQ9hh5nI0Aujoh
 RMsKK1UHahHflrhtYDAWBAsuON2Zu7/UmJULUPhUSb1ty0ERUh+Pw=
X-Received: by 2002:a5d:5846:0:b0:439:ca85:8848 with SMTP id
 ffacd0b85a97d-43b6424e499mr19572000f8f.16.1774285361627; 
 Mon, 23 Mar 2026 10:02:41 -0700 (PDT)
X-Received: by 2002:a5d:5846:0:b0:439:ca85:8848 with SMTP id
 ffacd0b85a97d-43b6424e499mr19571944f8f.16.1774285361087; 
 Mon, 23 Mar 2026 10:02:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03c:df99:cbc9:b444:8cfa?
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703343sm31997210f8f.19.2026.03.23.10.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 10:02:40 -0700 (PDT)
Message-ID: <d6622d0b-9198-47cf-8f80-42c4384a8883@redhat.com>
Date: Mon, 23 Mar 2026 18:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 1/3] linux-aio: Put all parameters into
 qemu_laiocb
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <20260318153206.171494-2-hreitz@redhat.com> <acFqulONusPdbQHY@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <acFqulONusPdbQHY@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23.03.26 17:36, Kevin Wolf wrote:
> Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
>> Put all request parameters into the qemu_laiocb struct, which will allow
>> re-submitting the tail of short reads/writes.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/linux-aio.c | 35 ++++++++++++++++++++++-------------
>>   1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/linux-aio.c b/block/linux-aio.c
>> index 53c3e9af8a..1f25339dc9 100644
>> --- a/block/linux-aio.c
>> +++ b/block/linux-aio.c
>> @@ -40,10 +40,15 @@ struct qemu_laiocb {
>>       Coroutine *co;
>>       LinuxAioState *ctx;
>>       struct iocb iocb;
>> +    int fd;
>>       ssize_t ret;
>> +    off_t offset;
>>       size_t nbytes;
>>       QEMUIOVector *qiov;
>> -    bool is_read;
>> +
>> +    int type;
> If you put fd and type next to each other, you'd avoid a hole in the
> struct.

And I assume pulling dev_max_batch forward, after qiov, yes.

>> +    BdrvRequestFlags flags;
>> +    uint64_t dev_max_batch;
>>       QSIMPLEQ_ENTRY(qemu_laiocb) next;
>>   };
>>   
>> @@ -87,7 +92,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
>>               ret = 0;
>>           } else if (ret >= 0) {
>>               /* Short reads mean EOF, pad with zeros. */
>> -            if (laiocb->is_read) {
>> +            if (laiocb->type == QEMU_AIO_READ) {
>>                   qemu_iovec_memset(laiocb->qiov, ret, 0,
>>                       laiocb->qiov->size - ret);
>>               } else {
>> @@ -367,23 +372,23 @@ static void laio_deferred_fn(void *opaque)
>>       }
>>   }
>>   
>> -static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
>> -                          int type, BdrvRequestFlags flags,
>> -                          uint64_t dev_max_batch)
>> +static int laio_do_submit(struct qemu_laiocb *laiocb)
>>   {
>>       LinuxAioState *s = laiocb->ctx;
>>       struct iocb *iocbs = &laiocb->iocb;
>>       QEMUIOVector *qiov = laiocb->qiov;
>> +    int fd = laiocb->fd;
>> +    off_t offset = laiocb->offset;
>>   
>> -    switch (type) {
>> +    switch (laiocb->type) {
>>       case QEMU_AIO_WRITE:
>>   #ifdef HAVE_IO_PREP_PWRITEV2
>>       {
>> -        int laio_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
>> +        int laio_flags = (laiocb->flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
>>           io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flags);
>>       }
>>   #else
>> -        assert(flags == 0);
>> +        assert(laiocb->flags == 0);
>>           io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
>>   #endif
>>           break;
>> @@ -399,7 +404,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
>>       /* Currently Linux kernel does not support other operations */
>>       default:
>>           fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
>> -                        __func__, type);
>> +                        __func__, laiocb->type);
>>           return -EIO;
>>       }
>>       io_set_eventfd(&laiocb->iocb, event_notifier_get_fd(&s->e));
>> @@ -407,7 +412,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
>>       QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, laiocb, next);
>>       s->io_q.in_queue++;
>>       if (!s->io_q.blocked) {
>> -        if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch)) {
>> +        if (s->io_q.in_queue >= laio_max_batch(s, laiocb->dev_max_batch)) {
>>               ioq_submit(s);
>>           } else {
>>               defer_call(laio_deferred_fn, s);
>> @@ -425,14 +430,18 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
>>       AioContext *ctx = qemu_get_current_aio_context();
>>       struct qemu_laiocb laiocb = {
>>           .co         = qemu_coroutine_self(),
>> -        .nbytes     = qiov ? qiov->size : 0,
>> +        .fd         = fd,
>> +        .offset     = offset,
>> +        .nbytes     = (qiov ? qiov->size : 0),
> Adding parentheses around the expression seems both unrelated and
> unnecessary.

True.  Sorry, artifact from a prior version, I think.

>>           .ctx        = aio_get_linux_aio(ctx),
>>           .ret        = -EINPROGRESS,
>> -        .is_read    = (type == QEMU_AIO_READ),
>>           .qiov       = qiov,
>> +        .type       = type,
>> +        .flags      = flags,
>> +        .dev_max_batch = dev_max_batch,
>>       };
>>   
>> -    ret = laio_do_submit(fd, &laiocb, offset, type, flags, dev_max_batch);
>> +    ret = laio_do_submit(&laiocb);
>>       if (ret < 0) {
>>           return ret;
>>       }
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks!

Hanna


