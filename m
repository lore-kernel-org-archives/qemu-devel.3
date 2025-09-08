Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05646CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvhGL-0006Zz-BK; Mon, 08 Sep 2025 15:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uvhFs-0005uB-6e; Mon, 08 Sep 2025 15:10:23 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1uvhFj-0000aL-KE; Mon, 08 Sep 2025 15:10:17 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8116af074e2so295172085a.0; 
 Mon, 08 Sep 2025 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757358599; x=1757963399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BlwzNDX92c1a3IW6bCeNHKdJURvxCMSn2ZCp5ODe7AE=;
 b=bRczygB+3vPoijSmOM53w84UBdabunogVIRGbqysYdU+fcop10TBsMzdpW1JD8+Ato
 4MZyZITDcrlRX4maKTBXIp0N1nGTU7Vb5suLXt1K4NmehuWzzndgpvNrLAaNGHkhM5Lw
 FaEilANuNEB1TnvMHQF90AmOkWL0gNrXkjopvp5GJRtkENX7f8lk7kWxUCcxhZItUbfL
 YNPbnfsiHa3XLkWj4+1ywGV24SkD6EtiDNwa01bYJZcut22v/URpA8IwGi/q+MFUJ/br
 /mldeerghYqil56OPtXyQzbFB9BCUGTunXCbnldkYtCA4WqWOJ31wlBzOPKREUwicvPC
 S1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757358599; x=1757963399;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlwzNDX92c1a3IW6bCeNHKdJURvxCMSn2ZCp5ODe7AE=;
 b=Zf/5yMRrEg64C46Wl2rEuIf4f3Lhlng5gW0mAbCFqWjdl0kYVL4LQ8tUSIHHiV9Ngg
 uPcbP3v9BD09eN5dxTr7oHG5t4rTXX69qKgSj3JjiDbaFb4yyGSxIycuAT6zc0W0IReA
 nOinn7AeviZcb4z6q4UxVhOw9dUCv++mGR1jboy630Vp8vpSwGysIEh7oQUA5b3fL7vX
 ChahrddorJDXgVwH2OVWhGGhk8mjOYslbWZeth1p7ycTo5Vxfk1FUs56sb2msDeSHk5P
 yqMPCb1Ut0EbOI91UvozPtj/t/YhEs8tposgD4PYS+0yqyjHSzz6OwbaZqz9yqzK0bxR
 5TMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt9SL1bR6UVP8Wa2FUv7i7/a8wRSuREedG0hXpCAGmdNKtPDdrSMuHZPS6ynJh0YGfm9QqO/qcUuzG@nongnu.org
X-Gm-Message-State: AOJu0YyOjRvci6SlPFJKvSKvkFhuiAkilFl/9kN8DRyHRsbOsz13R4AD
 YUsBPPRmEzywCBX8PcXNG7K7TgN//+ESlRuyimlvKBHvjjC0/Fn1BlVN
X-Gm-Gg: ASbGnctLqbAh+w8uaIMKl4t34V/HSPtiLFDU9vNPNYJVBJ6p4GfiL5kAHdrdXlpM0Yp
 1u6lEmCQMhce1WmzyXLpBKDAOZwlAxoxcvYWfceirBKuqUqcQiQeHtKEXPQutxBagNy/n+xf2VD
 wWUtQ2g4IL9xl07GG7q9K5c8cYnc0Y9oegqdRtzAe0urbed3Yd9fOK6peks2ikpffqDx1dWr8Rk
 XBvcilGzMP2hhL88OVTRymamacrjeGyCEisvUa71zR6vEmm8FBNeT/mGwwCTdY7tUH7FhUqCsdm
 Vd88Hg2W0OG96VA9TFF95GpbaqTB7IGPv859YsZHxPWQpXqoFBpl152jUXxfUqqJeTIHEU/hqfy
 cO3MumDPpVNqa1vgJbEP+ZlQ5Wlru3Q==
X-Google-Smtp-Source: AGHT+IGQmObkBZ1TeAUFPkuy2GXRs2uOpjK9+voN+/GN1J18WSeUtj8v6qe7Ix4ORSybEDq1gePdDA==
X-Received: by 2002:a05:620a:708d:b0:80a:eb17:6385 with SMTP id
 af79cd13be357-813c70b3135mr825233685a.74.1757358598858; 
 Mon, 08 Sep 2025 12:09:58 -0700 (PDT)
Received: from [10.5.0.2] ([62.3.36.217]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-80aa6e4beddsm1122199485a.19.2025.09.08.12.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 12:09:58 -0700 (PDT)
Message-ID: <d5550d6c-d3cb-440a-b806-80dd11887dd8@gmail.com>
Date: Mon, 8 Sep 2025 15:09:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH 2/4] export/fuse: process FUSE-over-io_uring requests
To: Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd@bsbernd.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-3-hibriansong@gmail.com>
 <20250903115108.GD106431@fedora>
Content-Language: en-US
In-Reply-To: <20250903115108.GD106431@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x72f.google.com
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



On 9/3/25 7:51 AM, Stefan Hajnoczi wrote:
> On Fri, Aug 29, 2025 at 10:50:23PM -0400, Brian Song wrote:
>> https://docs.kernel.org/filesystems/fuse-io-uring.html
>>
>> As described in the kernel documentation, after FUSE-over-io_uring
>> initialization and handshake, FUSE interacts with the kernel using
>> SQE/CQE to send requests and receive responses. This corresponds to
>> the "Sending requests with CQEs" section in the docs.
>>
>> This patch implements three key parts: registering the CQE handler
>> (fuse_uring_cqe_handler), processing FUSE requests (fuse_uring_co_
>> process_request), and sending response results (fuse_uring_send_
>> response). It also merges the traditional /dev/fuse request handling
>> with the FUSE-over-io_uring handling functions.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Brian Song <hibriansong@gmail.com>
>> ---
>>   block/export/fuse.c | 457 ++++++++++++++++++++++++++++++--------------
>>   1 file changed, 309 insertions(+), 148 deletions(-)
>>
>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>> index 19bf9e5f74..07f74fc8ec 100644
>> --- a/block/export/fuse.c
>> +++ b/block/export/fuse.c
>> @@ -310,6 +310,47 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
>>   };
>>   
>>   #ifdef CONFIG_LINUX_IO_URING
>> +static void coroutine_fn fuse_uring_co_process_request(FuseRingEnt *ent);
>> +
>> +static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
> 
> This function appears to handle exactly one cqe. A singular function
> name would be clearer than a plural: co_fuse_uring_queue_handle_cqe().
> 
>> +{
>> +    FuseRingEnt *ent = opaque;
>> +    FuseExport *exp = ent->rq->q->exp;
>> +
>> +    /* Going to process requests */
>> +    fuse_inc_in_flight(exp);
> 
> What is the rationale for taking a reference here? Normally something
> already holds a reference (e.g. the request itself) and it will be
> dropped somewhere inside a function we're about to call, but we still
> need to access exp afterwards, so we temporarily take a reference.
> Please document the specifics in a comment.
> 
> I think blk_exp_ref()/blk_exp_unref() are appropriate instead of
> fuse_inc_in_flight()/fuse_dec_in_flight() since we only need to hold
> onto the export and don't care about drain behavior.
> 

Stefan:

When handling FUSE requests, we don’t want the FuseExport to be 
accidentally deleted. Therefore, we use fuse_inc_in_flight in the CQE 
handler to increment the in_flight counter, and when a request is 
completed, we call fuse_dec_in_flight to decrement it. Once the last 
request has been processed, fuse_dec_in_flight brings the in_flight 
counter down to 0, indicating that the export can safely be deleted. The 
usage of in_flight follows the same logic as in traditional FUSE request 
handling.

Since submitted SQEs for FUSE cannot be canceled, once we register or 
commit them we must wait for the kernel to return a CQE. Otherwise, the 
kernel may deliver a CQE and invoke its handler after the export has 
already been deleted. For this reason, we directly call blk_exp_ref and 
blk_exp_unref when submitting an SQE and when receiving its CQE, to 
explicitly control the export reference and prevent accidental deletion.

The doc/comment for co_fuse_uring_queue_handle_cqe:

Protect FuseExport from premature deletion while handling FUSE requests. 
CQE handlers inc/dec the in_flight counter; when it reaches 0, the 
export can be freed. This follows the same logic as traditional FUSE.

Since FUSE SQEs cannot be canceled, a CQE may arrive after commit even 
if the export is deleted. To prevent this, we ref/unref the export 
explicitly at SQE submission and CQE completion.

>> +
>> +    /* A ring entry returned */
>> +    fuse_uring_co_process_request(ent);
>> +
>> +    /* Finished processing requests */
>> +    fuse_dec_in_flight(exp);
>> +}
>> +
>> +static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
>> +{
>> +    FuseRingEnt *ent = container_of(cqe_handler, FuseRingEnt, fuse_cqe_handler);
>> +    Coroutine *co;
>> +    FuseExport *exp = ent->rq->q->exp;
>> +
>> +    if (unlikely(exp->halted)) {
>> +        return;
>> +    }
>> +
>> +    int err = cqe_handler->cqe.res;
>> +
>> +    if (err != 0) {
>> +        /* -ENOTCONN is ok on umount  */
>> +        if (err != -EINTR && err != -EAGAIN &&
>> +            err != -ENOTCONN) {
>> +            fuse_export_halt(exp);
>> +        }
> 
> How are EINTR and EAGAIN handled if they are silently ignored? When did
> you encounter these error codes?

Bernd:

I have the same question about this. As for how the kernel returns 
errors, I haven’t studied each case yet. In libfuse it’s implemented the 
same way, could you briefly explain why we choose to ignore these two 
errors, and under what circumstances we might encounter them?

Thanks,
Brian

