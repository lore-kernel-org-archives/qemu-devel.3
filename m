Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DE1C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHcz9-0008Hb-O0; Thu, 13 Jun 2024 01:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHcz7-0008H8-Qg
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:26:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHcz5-0005Wm-MK
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:26:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f27eed98aso608760f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718256410; x=1718861210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yobwlrOkHR9+DqmoMVp71TUqw6XdoejQY6Yh/RxW3Io=;
 b=s2clC5KXku8YZKXVUqw7NCWFoEYD+mnwxf7jLmyI0lR5uz70zorj7Zu82ICHWiOTte
 c6X/2fnSvNfkXflSDIcphgCH2eLwXDnjZN94ichxQoKDYlUNuzUl2Vcn8wJyUkx3PxW1
 eQQjyFe+GmylheS8dK4U6bYHdGQCzkH0mktqqBZsTnFkaENJ/+4nxjBWvc06Z8cWraJd
 6pM0BkIiqZR0zLyXHjaIyPGmA6nVYcpCUhON9PEMqUN9qcFhnMuxFPPuOx73eXNpKJIF
 kzDq0Z0opSmlxIG2nbZHRVNmJXqbsJVpjxfkLI2lMDlpwMqWyzyiHkpAaZkXQI3s3Pip
 tSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718256410; x=1718861210;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yobwlrOkHR9+DqmoMVp71TUqw6XdoejQY6Yh/RxW3Io=;
 b=UWcfwL1cB0JjV+vy9w0o3/m8fCz52LPZhhUZdm2Vifkk68TH8A3a0ie9VrXLcxM8PS
 9A1Uh2UaqeD/Ij/t6DslJBhhZULMYPnmWDoXq8bzyjA06ad2XT5XQ3Byg9YuyICkEYby
 mAdLYUU3zsmrlQDj4WRcIIBrzabJ8tjiRPhqgp7vdL4xmd4oKEdFu9F7Y5+9AurR2tqF
 35T6xA85ykjIYd+CtGW98Kt4ub2yiKB9Xvk23GDmf2yHmM9JZcLNFFdsMaU7VUPjfP4b
 RS0Rw9o/ULkn97El/VTmwLlS+p7YW6SwmuSazuOIdY0sx/4xIP88FT7OW8cLS1Na89Q5
 8Veg==
X-Gm-Message-State: AOJu0YxPfyhBbWDU/HqFOO15QYeg8fimOT0lR82WFcu92TK+DoS1B2Fa
 UBwfpQmxhFoPmWxeQE5l9lgOA5NyyQvfLCQB0Q/epeFRCK6j3LzZHXgr00JjAE8=
X-Google-Smtp-Source: AGHT+IFY3lA5BqKYWj4i/bMnSOd3WuVytTq8IQ40FbIbhdHtfe4eWNytlDDp0ogdMnukytq+WiRoUw==
X-Received: by 2002:a5d:66d1:0:b0:35f:1bc5:6127 with SMTP id
 ffacd0b85a97d-35fdf79b273mr2416892f8f.23.1718256409741; 
 Wed, 12 Jun 2024 22:26:49 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f23cdsm597850f8f.77.2024.06.12.22.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 22:26:49 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:20:57 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v1] virtio-iommu: add error check before assert
User-Agent: meli 0.8.6
References: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
 <87o786xzma.fsf@draig.linaro.org>
In-Reply-To: <87o786xzma.fsf@draig.linaro.org>
Message-ID: <f074n.97fxykl1pml@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 12 Jun 2024 12:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> A fuzzer case discovered by Zheyu Ma causes an assert failure.
>>
>> Add a check before the assert, and respond with an error before moving
>> on to the next queue element.
>>
>> To reproduce the failure:
>>
>> cat << EOF | \
>> qemu-system-x86_64 \
>> -display none -machine accel=qtest -m 512M -machine q35 -nodefaults \
>> -device virtio-iommu -qtest stdio
>> outl 0xcf8 0x80000804
>> outw 0xcfc 0x06
>> outl 0xcf8 0x80000820
>> outl 0xcfc 0xe0004000
>> write 0x10000e 0x1 0x01
>> write 0xe0004020 0x4 0x00001000
>> write 0xe0004028 0x4 0x00101000
>> write 0xe000401c 0x1 0x01
>> write 0x106000 0x1 0x05
>> write 0x100001 0x1 0x60
>> write 0x100002 0x1 0x10
>> write 0x100009 0x1 0x04
>> write 0x10000c 0x1 0x01
>> write 0x100018 0x1 0x04
>> write 0x10001c 0x1 0x02
>> write 0x101003 0x1 0x01
>> write 0xe0007001 0x1 0x00
>> EOF
>>
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  hw/virtio/virtio-iommu.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 1326c6ec41..9b99def39f 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>  out:
>>          sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>>                            buf ? buf : &tail, output_size);
>> +        if (unlikely(sz != output_size)) {
>> +            tail.status = VIRTIO_IOMMU_S_DEVERR;
>> +            /* We checked that tail can fit earlier */
>> +            output_size = sizeof(tail);
>> +            g_free(buf);
>> +            buf = NULL;
>
>Hmm this is a similar pattern I noticed yesterday in:
>
>  Message-ID: <20240527133140.218300-2-frolov@swemel.ru>
>  Date: Mon, 27 May 2024 16:31:41 +0300
>  Subject: [PATCH] hw/net/virtio-net.c: fix crash in iov_copy()
>  From: Dmitry Frolov <frolov@swemel.ru>
>
>And I wonder if the same comment applies. Could we clean-up the loop
>with autofrees to avoid making sure all the g_free() calls are properly
>lined up?


The virtio-net.c patch adds an iov_size check for the virt queue element 
to make sure it can fit a header len. In this function, 
virtio_iommu_handle_command, a similar check is performed after popping 
the element after the queue. That's what the "we checked that tail can 
fit earlier" comment refers to.  Is this what you were referring to by 
any chance?

>
>> +            sz = iov_from_buf(elem->in_sg,
>> +                              elem->in_num,
>> +                              0,
>> +                              &tail,
>> +                              output_size);
>> +        }
>
>Isn't this the next element? Could we continue; instead?

It's not, the element is popped on the beginning of the for loop. I 
think we should not continue because we have written a VIRTIO error 
value for the guest and have to give it back as a response.


>
>>          assert(sz == output_size);
>>  
>>          virtqueue_push(vq, elem, sz);
>>
>> base-commit: 80e8f0602168f451a93e71cbb1d59e93d745e62e
>
>-- 
>Alex Bennée
>Virtualisation Tech Lead @ Linaro

