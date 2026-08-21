Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43F2C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxLGv-0004Ev-Ay; Fri, 21 Aug 2026 05:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wxLGt-0004EM-5U
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:10:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wxLGr-0006in-7i
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 05:10:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso9407855ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787303439; x=1787908239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U7Bn6hrmWAbG116V4Rb4gNtYTumscsBTWyz+VpWcxPI=;
 b=D3S6bWQlVYKHHcJ8/HOo4adVnYSna8dW/h7tcbOK1uvNc9iZycpiv8R/okUbstraUH
 U6lX5qCySMkXWudiBQoCcqvK6+Ay2TgW4385AXYwaaby6O+Z+jH5ecWtfJbWCcOS6pqA
 e7TGU1PesOhhIuj4ZKrV9h//4hYCDDUpxpRZaRnHs7j/WMoCXlG73peXQo/WFXwbujYP
 CWkfNdWKB7qkjnrd8TeNve1vA7g3EeFoKxwwMzOFK9EhO25BHAlXtCqZSoNO9fAR3kVl
 sdlWAV3/1D/wP6DCC7omJct9+s+r/HpINUSQSwWze/NCP5MsOI5tQixTeKaFkQIjdv7a
 f66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787303439; x=1787908239;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U7Bn6hrmWAbG116V4Rb4gNtYTumscsBTWyz+VpWcxPI=;
 b=YviVDfm3+M8SYq6DTXkTMOixEVpyZxlas+HSTglF2KOhiBaej75ANOF6pswVKb3059
 LTeS7pE1BU4yjc6xFnV8OohYCJ9hpH2DY1UVArCxIUpYDznQlVlhw31rV50cTWtjNy4g
 SXKOs0dynBR9CBNoI3I6ElUgYDv4ZKx4SEl/VPxIa/RroTVq4VxqDpz/rSqjTQnFqTOd
 IQ4mmMaGxgP6uF1y/ad/8kEjQchgS9lQZUtg3o/JD4k6iWU1H0Qe8411QEdL1BiySNtK
 ak/qtyOaLKTaZ+6YKROOE4se6yMrodYjHs2nSa026xhPBDYbbvmiSDGN1ndvJEoxoHZN
 81yw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou+RITzEBCYOAMHPOJoV/Sp+2fIgn8nsoGTeKB1PVIJZz9Z/K6jVcWWqHhf9e7WzSKZQPvEdIYFg6s@nongnu.org
X-Gm-Message-State: AFuF++kPsPdMGToCi3/+jRNCNQ0rd8vkT28aW2zDAIBvyG66IEcp8m9F
 3nbagN+bK+KEF4OswenGv9DMe5X9aE41CNKYeL8ed8z6BDWnz9/T7ziA
X-Gm-Gg: AR+sD12c+c1awrtxvzp6vHLDByGNL+f3yZEIoh1HtLgo4aAy6qK0uDxWufBxarJ1lIh
 if4cWt1sj32ZUe72sOy1SK1WscS86hO6XeKZvIXf2mIZlh2cnQtyVIH55KLDyiYGDdJJx3BJm4n
 alVsY4IWRYO2lVQ5cPxl0awsbA+PVCSnw4IRYaTDCsk+/0q5Y2ygPi+C12YB+WTy70XZ3cma6+c
 CkqDfkdMZiiX/3xZEXEQIZt+hhYVbpN0T+IPAKouVv5+sZ/3C67hoCao4MSiTCt6ieCoBlFKP/C
 R8Bt4U2qzm1IioddleXkKZ6EViTOM1RuFnrCPIeDLUiAm3wrkmo4McAL0kMbHxtgd6Btc8N7/Py
 N2rFRXIKje/bX3zqHhgcXwvoIDnA+J1PFmPM+sw6NChV+0TiBMljOOfpgXUOIrsqj+8Bwfob9fV
 ENuwMg4YT+MJZwnSQ5p34uzmuq8XnxFLhU0SCMGprhdK+F4JcPfQOzleljYKqTnjzz6QrSEV4P3
 A==
X-Received: by 2002:a17:902:e943:b0:2d2:da8e:9017 with SMTP id
 d9443c01a7336-2d64af5096bmr97644495ad.8.1787303438781; 
 Fri, 21 Aug 2026 02:10:38 -0700 (PDT)
Received: from [10.3.188.167] ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d555b51sm16105875ad.7.2026.08.21.02.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 02:10:38 -0700 (PDT)
Message-ID: <06ee44fe-fc50-457e-895a-08a7f95fe67d@gmail.com>
Date: Fri, 21 Aug 2026 17:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] migration/rdma: Retry control sends on full queue
To: Peter Xu <peterx@redhat.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org,
 farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-4-yanfei.xu@bytedance.com>
 <aoYBhxpSL5w5gQcX@x1.local> <80b1c870-308f-4de4-ad53-c9ecfc91da24@gmail.com>
 <aocFifqrtiv900Yr@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aocFifqrtiv900Yr@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pl1-x62e.google.com
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


On 2026/8/20 21:47, Peter Xu wrote:
> On Thu, Aug 20, 2026 at 06:27:12PM +0800, Yanfei Xu wrote:
>> Hi peter,
>>
>> On 2026/8/20 03:18, Peter Xu wrote:
>>> On Mon, Aug 17, 2026 at 06:51:17PM +0800, Yanfei Xu wrote:
>>>> RAM writes and control messages share the send queue.  If
>>>> outstanding writes fill it, RDMA writes drain a completion and retry,
>>>> but control sends fail the migration.
>>>>
>>>> Drain one outstanding write and retry the control send on ENOMEM.
>>>>
>>>> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
>>>> ---
>>>>    migration/rdma.c | 12 +++++++++++-
>>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>>> index 6e8436ccc1..d1f44a5f55 100644
>>>> --- a/migration/rdma.c
>>>> +++ b/migration/rdma.c
>>>> @@ -1572,9 +1572,19 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
>>>>            memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
>>>>        }
>>>> -
>>>> +retry:
>>>>        ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
>>>> +    if (ret == ENOMEM && rdma->nb_sent) {
>>>> +        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
>>>> +        if (ret < 0) {
>>>> +            error_setg(errp, "rdma migration: failed to make room for "
>>>> +                       "control send");
>>>> +            return -1;
>>>> +        }
>>>> +        goto retry;
>>>> +    }
>>> Looks also correct, but two questions:
>>>
>>> - Should we provide a helper instead of duplicating the WRITE op handling?
>>>     I believe only WRITE wrids can be on the fly.
>> Yes, control message is syncronized, only WRITE can be on the fly. A helper
>> is a good suggestion. Will do.
>>
>>> - Could ENOMEM be returned when nb_sent==0?  If that check applies to WRITE
>>>     path too?
>> ENOMEM can be regarded as SQ is full to RDMA usage in qemu. Actually ENOMEM
>> is determined by provider and could have other meaning like
>> inline_data > qp->max_inline_data in mlx5. Based on qemu codes, I think it's
>> fine without nb_sent==0
> I'm not familiar with mlx5 impl that you're discussing here, but IIUC the
> point is we should be able to capture all recoverable faults and retry,
> meanwhile we should fail immediately on non-recoverable faults.
>
>  From the name of the errno (ENOMEM), I expect non-recoverable faults can
> happen with it.. unless this is something special to libibverbs to
> explicitly imply "queue full"..
>
> I wonder if it means this nb_sent!=0 check should indeed make sense, but I
> also wonder if we should add a number of retry so as to capture real ENOMEM
> errors otherwise that is not recoverable?  As long as it won't keep
> spinning with the same error then we should be good.

After a rough search of the rdma-core code I didn't find any place explicit
defining ENOMEM to post_send op as meaning "queue full" . You are right,
ENOMEM can be non-recoverable fault, and we should avoid infinitely waitting
in those cases.

ENOMEM && nb_sent==0 must not be the case "queue is full", so we can fail
fast. As for other non-recoverable faults, I think limit the times of retry
is neccessary.

Thanks for your suggestions!

>
>> In addition, I encountered this bug when I attempt to send dirty pages
>> belongs
>> to same chunk in parallel. That could more efficiently utilizes throughput
>> when
>> many scattered page in one chunk, and quickly exhausts SQ's WRs. Will post a
>> RFC with more data.
> Sure, I hope that still makes sure different versions of a same page will
> be still ordered.
Sure we can discuss in that serial.

Regards,
Yanfei
>
> Thanks,
>

