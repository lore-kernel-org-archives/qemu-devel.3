Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356E6CA1016
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 01:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvmt5-000520-4g; Mon, 08 Sep 2025 21:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uvmsy-0004zp-UI; Mon, 08 Sep 2025 21:11:04 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uvmsr-0004FU-C3; Mon, 08 Sep 2025 21:11:04 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-70ddadde494so43729936d6.1; 
 Mon, 08 Sep 2025 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757380253; x=1757985053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ktCClomFs2S9VrtLLUmDiBZKr6YRa5S9ldqkoFhO/E=;
 b=BPdJabNTGEx4+g4gBPqKjnUDdVNGTqb54HAEHEhc39qtgqUfgk5KXeRrKxlMYu7sCC
 nAd8XUgdrikidFk7JPGzb6wR9i6LUgcGG8U6r52jIDLxDWrSJC0AADNjmEDKAWXIuK+O
 tgfMPaufJhDuBGncD8sktFsIs+YpwtU8TKQmPNbQJjl4WrivydZPdYoaJiW3iSbbfBXy
 eOHAcD+vBxkIcaqMwh4X++LZE8L520pl4BfA0KMrBPzjGNwZQA9YJ8CxF30ekolwBlXY
 sRIpYCulrQLQZcblc4UcmjMX740waxb+TaHDKR4clDJlswtKwPMGfni79hg5xWXWAjZd
 a5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757380253; x=1757985053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ktCClomFs2S9VrtLLUmDiBZKr6YRa5S9ldqkoFhO/E=;
 b=v60e3xNr1LqOk8Rk+rjw09N6E3KTvFRNjkIlx7CK7Y5JLNtSgwliuGnwZt7OKdqDex
 6zT7IOTeX+fA5XKiHsBjrracEvQ+KIhlCiEsnkno3PBG/x09G3QnK9ZskibnhRO5X7gZ
 CSxCqQUXfrpB5ToJIvvWnq5ks2/D/cqfLhF9Yvi0aNtDPwuhEZ7TksBYN3VbJRTABdpj
 AR6uFJaiHxf+zBJ1DySU/uCBRAeZMpbqv/pIuXiDmKwzlFm0VCZxRkSIvhOzIRpnnHfG
 9KCexZnkQDZhc5/0OyO+s+xZUcKlHg0QodC/eC6N2npLS8xxXk8geqvPlqoOGsEuSDkJ
 NwIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeCyc5dPVE+1PAgR1YshE9xxxBiIzzKjJXAkVvAXoxeJSf6HLEyZgh0+O9LreYR8UQcU/pu+T0hsjZ@nongnu.org
X-Gm-Message-State: AOJu0Yz3rn6guv6FEqsbrB2FNVt7DQSpeSHNUgLpz97s6fmAsithed+X
 Ks3C8tXBlYktxL8awzsEVkNVjLatSa2JddpQNFBEphp1I+DXccHaos2vq7VJeA==
X-Gm-Gg: ASbGncuTojQiUjM7Fzhv0cEFj5Wwb0xvHLdkDA3+jkqX6cTFCkA/JMiPOm9sQtKhTLH
 JmNIE8m7rm35cqOjk2qTaONX21ERW08HHj9j+cjDZnpSPDPBAUjE6swEGzDcNzA+xzOa/fAEIhi
 BOcCZSoU07rxtA9DDS7pBfcn75R0Z1n8JJNqjKrksKIPQv9wfna/5MFozBtdMLgDFsDwm4jYmU+
 iGPgKaOiAv4m6FI+3WeCQYGZqSqA4vR4RU92tUkp8kfJQA8oKccQcgfWzZbgHJJvOhTjir0Jf1V
 l0c8kKLui7K1MwXs30bQc49aNReMv3SNnRzNfloqr8xIVqm+WW+M07yVZMq3zHmWNRYUHwqD40R
 uzTIhSA9pFtCGhlTYxNyBJbKzDDg+SW6GVpXDTT6rH8BRM7NFZekE4bb7+0DJ3CVbXWsM6f8caF
 f93zDnR3e9umo=
X-Google-Smtp-Source: AGHT+IFt2xM6t8QPTTcQMQEXWhhvYqRYezERw/ncZpW4yzWlt6vdY8UUGptDV7ZzrHvW+S1B8Evj5w==
X-Received: by 2002:a05:6214:2aac:b0:731:bb3:776b with SMTP id
 6a1803df08f44-739211adf55mr88832116d6.3.1757380252693; 
 Mon, 08 Sep 2025 18:10:52 -0700 (PDT)
Received: from [10.36.181.110]
 (wn-campus-nat-129-97-124-110.dynamic.uwaterloo.ca. [129.97.124.110])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-728d6f8b338sm102818576d6.0.2025.09.08.18.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 18:10:52 -0700 (PDT)
Message-ID: <9948bdce-a50f-4b08-80bc-1be21c62f3c0@gmail.com>
Date: Mon, 8 Sep 2025 21:10:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
To: Bernd Schubert <bernd@bsbernd.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
 <20250903115108.GD106431@fedora>
 <d5550d6c-d3cb-440a-b806-80dd11887dd8@gmail.com>
 <f6ca7bc4-604c-43c8-ab81-7ef14762d8a1@bsbernd.com>
Content-Language: en-US
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <f6ca7bc4-604c-43c8-ab81-7ef14762d8a1@bsbernd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 9/8/25 3:45 PM, Bernd Schubert wrote:
> 
> 
> On 9/8/25 21:09, Brian Song wrote:
>>
>>
>> On 9/3/25 7:51 AM, Stefan Hajnoczi wrote:
>>> On Fri, Aug 29, 2025 at 10:50:23PM -0400, Brian Song wrote:
>>>> https://docs.kernel.org/filesystems/fuse-io-uring.html
>>>>
>>>> As described in the kernel documentation, after FUSE-over-io_uring
>>>> initialization and handshake, FUSE interacts with the kernel using
>>>> SQE/CQE to send requests and receive responses. This corresponds to
>>>> the "Sending requests with CQEs" section in the docs.
>>>>
>>>> This patch implements three key parts: registering the CQE handler
>>>> (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
>>>> process_request), and sending response results (fuse_uring_send_
>>>> response). It also merges the traditional /dev/fuse request handling
>>>> with the FUSE-over-io_uring handling functions.
>>>>
>>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>>>> ---
>>>>    block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
>>>>    1 file changed, 309 insertions(+), 148 deletions(-)
>>>>
>>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>>> index 19bf9e5f74..07f74fc8ec 100644
>>>> --- a/block/export/fuse.c
>>>> +++ b/block/export/fuse.c
>>>> @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>>>    };
>>>>    
>>>>    #ifdef CONFIG_LINUX_IO_URING
>>>> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
>>>> +
>>>> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
>>>
>>> This function appears to handle exactly one cqe. A singular function
>>> name would be clearer than a plural: co_fuse_uring_queue_handle_cqe().
>>>
>>>> +{
>>>> +    FuseRingEnt *ent = opaque;
>>>> +    FuseExport *exp = ent->rq->q->exp;
>>>> +
>>>> +    /* Going to process requests */
>>>> +    fuse_inc_in_flight(exp);
>>>
>>> What is the rationale for taking a reference here? Normally something
>>> already holds a reference (e.g. the request itself) and it will be
>>> dropped somewhere inside a function we're about to call, but we still
>>> need to access exp afterwards, so we temporarily take a reference.
>>> Please document the specifics in a comment.
>>>
>>> I think blk_exp_ref()/blk_exp_unref() are appropriate instead of
>>> fuse_inc_in_flight()/fuse_dec_in_flight() since we only need to hold
>>> onto the export and don't care about drain behavior.
>>>
>>
>> Stefan:
>>
>> When handling FUSE requests, we don’t want the FuseExport to be
>> accidentally deleted. Therefore, we use fuse_inc_in_flight in the CQE
>> handler to increment the in_flight counter, and when a request is
>> completed, we call fuse_dec_in_flight to decrement it. Once the last
>> request has been processed, fuse_dec_in_flight brings the in_flight
>> counter down to 0, indicating that the export can safely be deleted. The
>> usage of in_flight follows the same logic as in traditional FUSE request
>> handling.
>>
>> Since submitted SQEs for FUSE cannot be canceled, once we register or
>> commit them we must wait for the kernel to return a CQE. Otherwise, the
>> kernel may deliver a CQE and invoke its handler after the export has
>> already been deleted. For this reason, we directly call blk_exp_ref and
>> blk_exp_unref when submitting an SQE and when receiving its CQE, to
>> explicitly control the export reference and prevent accidental deletion.
>>
>> The doc/comment for co_fuse_uring_queue_handle_cqe:
>>
>> Protect FuseExport from premature deletion while handling FUSE requests.
>> CQE handlers inc/dec the in_flight counter; when it reaches 0, the
>> export can be freed. This follows the same logic as traditional FUSE.
>>
>> Since FUSE SQEs cannot be canceled, a CQE may arrive after commit even
>> if the export is deleted. To prevent this, we ref/unref the export
>> explicitly at SQE submission and CQE completion.
>>
>>>> +
>>>> +    /* A ring entry returned */
>>>> +    fuse_uring_co_process_request(ent);
>>>> +
>>>> +    /* Finished processing requests */
>>>> +    fuse_dec_in_flight(exp);
>>>> +}
>>>> +
>>>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>>>> +{
>>>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>>>> +    Coroutine *co;
>>>> +    FuseExport *exp = ent->rq->q->exp;
>>>> +
>>>> +    if (unlikely(exp->halted)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    int err = cqe_handler->cqe.res;
>>>> +
>>>> +    if (err != 0) {
>>>> +        /* -ENOTCONN is ok on umount  */
>>>> +        if (err != -EINTR && err != -EAGAIN &&
>>>> +            err != -ENOTCONN) {
>>>> +            fuse_export_halt(exp);
>>>> +        }
>>>
>>> How are EINTR and EAGAIN handled if they are silently ignored? When did
>>> you encounter these error codes?
>>
>> Bernd:
>>
>> I have the same question about this. As for how the kernel returns
>> errors, I haven’t studied each case yet. In libfuse it’s implemented the
>> same way, could you briefly explain why we choose to ignore these two
>> errors, and under what circumstances we might encounter them?
> 
> 
> I think I remember why I had added these. Initially the ring threads
> didn't inherit the signal handlers libfuse worker threads have. I had
> fixed that later and these error conditions are a left over.
> In libfuse idea is that the main thread gets all signals and then sets
> se->exited - worker thread, include ring threads are not supposed to get
> or handle signals at all, but have to monitor se->exited.
> 
> Good catch Stefan, I think I can remove these conditions in libfuse.
> 
> 
> Thanks,
> Bernd
> 

In libfuse:

static int fuse_uring_queue_handle_cqes(struct fuse_ring_queue *queue)
{
	struct fuse_ring_pool *ring_pool = queue->ring_pool;
	struct fuse_session *se = ring_pool->se;
	size_t num_completed = 0;
	struct io_uring_cqe *cqe;
	unsigned int head;
	int ret = 0;

	io_uring_for_each_cqe(&queue->ring, head, cqe) {
		int err = 0;

		num_completed++;

		err = cqe->res;
		if (err != 0) {
			if (err > 0 && ((uintptr_t)io_uring_cqe_get_data(cqe) ==
					(unsigned int)queue->eventfd)) {
				/* teardown from eventfd */
				return -ENOTCONN;
			}

			// XXX: Needs rate limited logs, otherwise log spam
			//fuse_log(FUSE_LOG_ERR, "cqe res: %d\n", cqe->res);

			/* -ENOTCONN is ok on umount  */
			if (err != -EINTR &&
			    err != -EAGAIN && err != -ENOTCONN) {
				se->error = cqe->res;

				/* return first error */
				if (ret == 0)
					ret = err;
			}

		} else {
			fuse_uring_handle_cqe(queue, cqe);
		}
	}

	if (num_completed)
		io_uring_cq_advance(&queue->ring, num_completed);

	return ret == 0 ? 0 : num_completed;
}

If err > 0 && ((uintptr_t)io_uring_cqe_get_data(cqe) == (unsigned 
int)queue->eventfd), it will return the negative value -ENOTCONN so that 
the caller sets se->exited = 1. Then, under what circumstances is err > 
0? When is err < 0? The current code also doesn't seem to handle the 
case where err is negative?

