Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2493D2E01E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3W9E-0003Sf-LK; Wed, 23 Oct 2024 03:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3W98-0003SI-8w
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:51:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3W96-0001HH-9N
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:51:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e4fa3ea7cso4943203b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729669866; x=1730274666;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4GXR6qGytaSuh23nLegj+k6vr06+QYcpd0vf/jDKDw=;
 b=OUx8e61H7Gn5XkKip42wo4MYgiic4xFKKfiilOiMMCIHUPnYOLlfdxF+sDZWlxaYmO
 CNEHHM/RfLCMuOFUzzenp+FytAVyqXrID0h7MzCS4uJu5cWdDkTf7N5Lwd6U4Zb2sQUT
 7Tk3SaU7mAyBJcmCi5wczDpU+THu4lLPGOJzxW94kAplKRc7WpkToZqQOWZSnk5VVMCs
 RxFcXdbed3EMdzAiT2/BtQhZvYIl202sXJ0VHT6b1biOgMerJxZL5vDQMqrbxDjOyH2Q
 Sx92YicowQGFlyxvsPpfNZX8bNqeVAinz30ebhYY8qn0ErM9LBITJEiSuGlsvtwNJ3I8
 bR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729669866; x=1730274666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4GXR6qGytaSuh23nLegj+k6vr06+QYcpd0vf/jDKDw=;
 b=g3kmSmmDSRQYjN45+eZBBm+aL4vOUk3SHzJjUBGV/chcjOmJktd+6YrlQvORUZPbSC
 LhgdlY0APan4umhL5A3I82Z0+yBXwTG4LYHWbMdUptXOoqUk1HCWEcz1zsKJmlkIyntA
 wyRSkDjPsr8SRweHBU6DMQmgkKKuNo4kMeiL4rRBIA/Acmr94VJe0FD/i3uMjbc/hoWC
 laLcyoApsYCwt5K1DBPKZeQYZCIDXxi9WQBv3OHYKIeF9fPi71z7Vvme+2bqzK9+KQi3
 xBiwXcZ2+Vk4lLNJA5EVxkGYPef525RYxcW3JlGBAUbAjOyKj6Z4z9/AisJEz6WC2PtX
 XNLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8aEr5lSFC8VGCwz9t5Dy5q10Hc3tFxJeDSd3DZTFQNngQz56JPv3xdxEfeKYJniN4FlULEcgcxXWK@nongnu.org
X-Gm-Message-State: AOJu0YzJQRxQ1aUBdqYbaqYJ6809wLwL1CXZQKeDgGplazp+DJhPjPh5
 4fMaoY/y+ce3zWE7BVeSwcSGOpa9Zaovu6Seq0gG+zNkhCBf7KgFLcpH0lllYiE=
X-Google-Smtp-Source: AGHT+IFpWjHdXOU1VJJgFPctJSN949WRUTNy35o2UVMYwVDc6PooAgtkvgZKcoTk1zHzlYFIqIUq7Q==
X-Received: by 2002:a05:6a00:2da7:b0:71d:d2a9:6ebf with SMTP id
 d2e1a72fcca58-72030b60ab3mr2707786b3a.6.1729669866226; 
 Wed, 23 Oct 2024 00:51:06 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec131386asm5801029b3a.44.2024.10.23.00.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 00:51:05 -0700 (PDT)
Message-ID: <74bc6290-e312-4933-9cc2-c24abe554151@daynix.com>
Date: Wed, 23 Oct 2024 16:51:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] virtio-gpu: Support asynchronous fencing
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-6-dmitry.osipenko@collabora.com>
 <9362f8ac-5616-4f6d-b424-3a2b679c2141@daynix.com>
 <f79ebab7-fe1c-419d-89d5-6238b0b36ba5@collabora.com>
 <c02c2bb3-c5fe-4675-bfc5-2b99fbf78f42@daynix.com>
 <44929f04-f45f-45ff-bd0b-e1a955fad34a@collabora.com>
 <5f9adf6c-2975-43c4-bd7d-df20370087e0@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <5f9adf6c-2975-43c4-bd7d-df20370087e0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/22 21:44, Dmitry Osipenko wrote:
> On 10/22/24 15:37, Dmitry Osipenko wrote:
>> On 10/22/24 08:11, Akihiko Odaki wrote:
>>> On 2024/10/19 6:31, Dmitry Osipenko wrote:
>>>> On 10/18/24 08:28, Akihiko Odaki wrote:
>>>>>> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
>>>>>> +                                      uint32_t ring_idx, uint64_t
>>>>>> fence)
>>>>>> +{
>>>>>> +    VirtIOGPU *g = opaque;
>>>>>
>>>>> What about taking the BQL here instead of having a QEMUBH?
>>>>
>>>> That will block virglrenderer thread writing the fence, which in turns
>>>> might block other virglrenderer threads.
>>>
>>> Looking at virglrenderer's source code, the thread writing the fence is
>>> the only thread it creates. Otherwise virglrenderer's code should be
>>> executed only in the QEMU thread calling virglrenderer's functions,
>>> which always holds the BQL. So taking the BQL here will not interfere
>>> with another thread.
>>
>> There are other problems with that BQL approach:
>>
>> 1. virgl_renderer_context_destroy() is executed from QEMU's main-loop
>> and it will terminate the virglrenderer's fence-sync threads which at
>> the same time will take the same BQL if fence fires while VM is shutting
>> down and then this condition will result in a deadlock.
> 
> I mixed up virgl_renderer_context_destroy() with
> virgl_renderer_cleanup() here, but actually
> virgl_renderer_context_destroy() will have the same deadlock issue.
> 

Thanks for explanation. This explains well why QEMUBH is needed.

Regards,
Akihiko Odaki

