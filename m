Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C5C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp646-0005q7-JL; Wed, 29 Jul 2026 11:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wp642-0005p9-RP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wp63x-00069A-Fp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785338355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+ltmo4+aF3/fRqmq5GL63qBbwTYCnJGeLDFe6Zpz0SI=;
 b=eSNOSD0W5pfCxRmjZn11zNRlhesnoU76ptkqVZEG6YnHX+/XL+XhQBz2ANDRVqIRHztdGd
 BPEMMGqe6YGv14Y+Snw62hfwpVsdQNKigZLpyLlyilpYs9cV1F4G73u/PKo1xYTcdIhHxh
 SPNutXFNY4AlP9zl3tyi/WWC2a7y9Lw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ix4xT0MfNBSejVrGhu3k7Q-1; Wed, 29 Jul 2026 11:19:12 -0400
X-MC-Unique: ix4xT0MfNBSejVrGhu3k7Q-1
X-Mimecast-MFC-AGG-ID: ix4xT0MfNBSejVrGhu3k7Q_1785338351
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f8580ed9eso961615f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785338351; x=1785943151; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+ltmo4+aF3/fRqmq5GL63qBbwTYCnJGeLDFe6Zpz0SI=;
 b=FGQDTfYTPJTvjVTB9AcpMEii3ieIIjIZ/zCykJm9vM8lOpbpuJYQVmdTeS1T55BrHq
 tHlLME2SFhbqfHVv6t6vAM9DHrbf9CGDdncYViQowwyVHcN4xuVweKih13Rcguqb+14l
 Dwhn8189w9a1UHxhXPi6SocOy5OKQYUE4f2JQKw2+FKETDRevZ4pcL0wG07S5Jjw8Lpq
 Eh+5qSAI7dxeD7fSAPLezCEOx4VhqrQ9E6Lt1M6K6O962Cmx7o12iXv5EGT4ln8HIJY9
 SGICnDv68/KfLqCvrJhmTz5KitLFm/hqhtXqLHOlMXcjoTEUo9pn62rVV/91A3q2R6dF
 lOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338351; x=1785943151;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+ltmo4+aF3/fRqmq5GL63qBbwTYCnJGeLDFe6Zpz0SI=;
 b=UiVrO7INurH3zmJh/LI8+HLxdVHyaBU1A2db4fWzHE6RXa7RIL0nziMZYTfXMaGdWH
 oXE5I3TaP7P+0uSKBaKLm5vgQFvVTRebh3FsqkdfQ5r3BrjiEc1p/XODm75O7tRpDomQ
 BPRq+YryOb6TghR+Mwxd4hQdoGD+g48xmxmxbAxJIKjx+uECwdUH2ZdzWwjpizXplTzE
 AdulkmnHRxDsZyr4kjmmQ8o/kt65VMh6LEX8zoYYAxmdv/SxnhIqV/9eNqoaE2elsc/0
 2Tn5HA/YLF5PTZzsdnBbZuHQ8uuxXmO/l3mJ8Apf+U90wJEKo4abE64oBPx4pf1ENd6V
 ZMrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXVs92LwBqd9Rl3SKId7+d0k87msMJoRoQhL6dyHuhb/h9kHZ3eWbRlswJ+j92v2kkekDvIShiMGxQ@nongnu.org
X-Gm-Message-State: AOJu0YyZuW8AS63lC/8l8qYYtXvfpGmmEvI1Rpx4fxCfeY/l/4ZkM9TK
 s0CEgFtKDlmxpJ9OPneNxHsG/sxmP2gk3WXSs6m2RxHbmgtbsiOMIWGn8M+EB4OUWYi8b905r9R
 5vCnZxuIfIfmJqSh5HlocCm/yF4Ut5eIkXX0veIGdsv0VGRh7zsoDziie
X-Gm-Gg: AR+sD11XNwCwaJE/DYOdt5UZmAD9kVnuNj+HgEJc07RGG43h43NwABJYsQBepIdfYQs
 yhXpd5izT+P0pGGg/MibOJZMpAm1H1bJ+k7ViyFJeRMYCg7wwJkf6BIJOOmxcHUzJfjwHI7o27N
 NKwjsdveomX2/nT2y0Llb3d/e/gdTCp6v4qOdtza7ddOVdKiTVgdaL4qVyRw7BF/pULyskaKrwQ
 XjDda/XbUBaUqTaY4jaVshscLiXahhgeYArHe3N3/XOXFTygzSx/7sJPtuXakppyImcvYDf67Fi
 uJq8BAeZepdbdbpe5MXUFHf1nUy/9sMPdKrdsRT2MYiQUhLX0hNUDZF6WPI2CtXGa1rwe5s=
X-Received: by 2002:a05:600c:3b27:b0:496:c378:6420 with SMTP id
 5b1f17b1804b1-496c653a48fmr84187595e9.8.1785338350579; 
 Wed, 29 Jul 2026 08:19:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3b27:b0:496:c378:6420 with SMTP id
 5b1f17b1804b1-496c653a48fmr84187125e9.8.1785338350006; 
 Wed, 29 Jul 2026 08:19:10 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.51.53]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d8e826sm73945285e9.8.2026.07.29.08.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 08:19:08 -0700 (PDT)
Message-ID: <b0733bce-3902-47a1-a617-5f4aeda06fbe@redhat.com>
Date: Wed, 29 Jul 2026 17:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: validate blob iov size in
 create_blob
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260724035712.856636-1-marcandre.lureau@redhat.com>
 <bfcab7d8-c7ae-4c2a-be79-6bdc5c8faaf7@rsg.ci.i.u-tokyo.ac.jp>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bfcab7d8-c7ae-4c2a-be79-6bdc5c8faaf7@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 24/07/2026 08.26, Akihiko Odaki wrote:
> On 2026/07/24 12:57, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> virtio_gpu_resource_create_blob() stores the guest-controlled blob_size
>> without checking it against the total size of the iov backing entries.
>> Since both values are independently guest-controlled, a malicious guest
>> can set blob_size much larger than the actual iov backing. Subsequent
>> SET_SCANOUT_BLOB checks bounds against the inflated blob_size, allowing
>> a pixman surface to be created over the undersized buffer. Any display
>> refresh then reads past the actual allocation, potentially crashing
>> QEMU or leaking host memory contents depending on the backing type.
>>
>> Reject the resource early when the iov backing is smaller than the
>> declared blob_size.
> 
> The same invariant also needs to be enforced when backing is supplied
> by VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING and when blob migration state
> is loaded. Otherwise, newly attached backing or state received from an
> older source can bypass this fix.
> 
> The check cannot be unconditional at resource creation, however. The
> specification permits nr_entries == 0 so that backing can be attached
> later for swap-in/swap-out. As written, this patch rejects that valid
> request:
> 
>  > To facilitate drivers that support swap-in and swap-out, nr_entries
>  > may be zero and VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING may be
>  > subsequently used. VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING may be
>  > used to unassign memory entries.
> 
> https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html#x1-4120008

The patch that is proposed in 
https://gitlab.com/qemu-project/qemu/-/work_items/4112 also checks for 
res->iov_cnt > 0 ... would that fix your concerns?

  Thomas



> 
>>
>> Fixes: CVE-2026-66021
>> Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3945
>> Reported-by: "sundayjiang(蒋浩天)" <sundayjiang@tencent.com>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/display/virtio-gpu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index eac039c3c366..cc6dbd116618 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -372,6 +372,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU 
>> *g,
>>           return;
>>       }
>> +    if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: backing storage smaller than blob size\n",
>> +                      __func__);
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +        virtio_gpu_cleanup_mapping(g, res);
>> +        g_free(res);
>> +        return;
>> +    }
>> +
>>       virtio_gpu_init_udmabuf(res);
>>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>   }
> 
> 


