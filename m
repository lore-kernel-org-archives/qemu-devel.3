Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6F9D6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LNa-0006e1-El; Thu, 02 Apr 2026 12:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LNZ-0006dp-NP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:58:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LNY-0008OH-4Q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:58:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so11658415e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149126; x=1775753926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PgmWa17zg3wl86VAEWehxjVObkcS6lZ6anevd7bemmU=;
 b=GwJJFv+uG2VROdv+gXdr/bF97VuOkchYluhf6RmQ47Suftk6pAeXtn/nylFeW8Co3w
 2fheyP+9ZOsWusLeO5PGzDI7j6y8fkIfj3U3CTXzOlV425syWdBX02UwcqxJAXuqsJpw
 fSc8/6HoYdSiR7jKyj28JZLjt09nEpGGzgFP2UHxvaKZy7v9A68GCPiy01N1qRfAOF0A
 W8bWnMkIaPjJ5GrqyHWkLkQs6vp2qWjl64U373hZQGi4Gn/C/cj+0fU4xUG1ffnfgmKf
 1uYX7KB1K2WP05aePpj4ZsdvyrStn6iicL8hD8dBrZgcBWZ76+peJjjpUaIDScfdjiD2
 0/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149126; x=1775753926;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PgmWa17zg3wl86VAEWehxjVObkcS6lZ6anevd7bemmU=;
 b=ZMAT5HOQVOayhozI1PDwG0EDSAyH9YfuigVHytdMSaBwweGW6Sn5zKyqUC0lgTTM+c
 2GaLIZ7Bh1CRWI6qV1h8ba4tdvIpLfrdtfvRKjueAatDBOnBMNBfbFIKZ/lItiYOfYGZ
 0O5UEP+m7stCyYpkY7/7+nhet7p6goDODkzqNdm5uy0UJoRCxklGTEySDsO5OnQelCMD
 WiGmvykE/AD/fQkffjeA1UC5B4KYviUXVingPVrJvbjOdEahHA0TtvBw4kLL2N278cAp
 ag7yCCpo4/h1IJgZKM61WFJiXo+zQei6T9D3pwBBp+oQ4zgmakKoEGnawhSxj+llxisK
 8jJg==
X-Gm-Message-State: AOJu0YzUIi6uJgJbnunkoh5b4ZwQsJmDHbNjJltIKgtNFvMublLEE3Uz
 JkqAtvNqPDhmMzOVTKMv70J2BaEFC6PfcNsDXGmTBlD7tn0qZFgA1T/3KvWK6tLUUbw=
X-Gm-Gg: ATEYQzzJzNyDpXkUoBSdN882YPhXA0Y8Gi0MtPOi9XXaQMJ+hHMIQOXFa+07Enpf3ad
 sd/yfaNOnFfz6f2L4Uai19CAAyaQJyTtYqzhfg5AP8bT2sFD83xeOsX6Nc8LI88snb/xZNhPUO1
 DHc3dcq/9CB2gJGpsQt6CwieJHjFZAcr3UC76qJhQyxeCPC193pl9OVVGuSO/y4ncEnTPdtRInY
 eb5vlM1EwM6OVHUNh//1qUsl7Zx2M0IDSNOckZB9ZcVz1rCqJIHGWAGZ4j07kOwTzTSCelINQrC
 nsn1UEtFukv5vRSat5ar60V1ACDCzDuY+Tfcqxu1tJlpgvopPJ6HP8n4S0MG4VeLAgeyKLhDaVA
 xx3tC8wC298SxSd3vP5xTKqeN3GiWIz9HUptSN7YOWJVemPRkCKVPTISP0DDLCnR98Yt3xfycnv
 EDzF5XyjzXhDLoRPrJU9FeD9Xp7S0YxVofzg8R6ypamgubkmM4y5WCYBVLczgG5jD+8Q==
X-Received: by 2002:a05:600c:3797:b0:485:6e55:28b0 with SMTP id
 5b1f17b1804b1-4888e0ab5fcmr37293015e9.12.1775149125725; 
 Thu, 02 Apr 2026 09:58:45 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f843dsm8789827f8f.37.2026.04.02.09.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 09:58:45 -0700 (PDT)
Message-ID: <7d5edbe3-a9f7-4493-a316-50c0b8901a51@linaro.org>
Date: Thu, 2 Apr 2026 18:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: allow vhost-user backends to provide config
 space
To: Laurent Vivier <lvivier@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20260320163844.754762-1-lvivier@redhat.com>
 <CAJaqyWeqgO9fR+Xi5rtBw0VL=gaMBFa9N7wV20bYhEgq3SbMMw@mail.gmail.com>
 <844999be-3057-4753-8978-77074c3fe56c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <844999be-3057-4753-8978-77074c3fe56c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/4/26 12:24, Laurent Vivier wrote:
> On 3/31/26 13:33, Eugenio Perez Martin wrote:
>> On Fri, Mar 20, 2026 at 5:40 PM Laurent Vivier <lvivier@redhat.com> 
>> wrote:
>>>
>>> Remove the vDPA-only guard on vhost_net_get_config/set_config calls so
>>> any vhost backend that negotiates VHOST_USER_PROTOCOL_F_CONFIG can
>>> provide device configuration.
>>>
>>> To manage backends that don't support vhost_net_get_config/set_config,
>>> modify the stubs and vhost_net_get_config/vhost_net_set_config
>>> with NULL vhost_net parameter to return -ENOSYS.

[...]

>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>   hw/net/vhost_net-stub.c |  4 ++--
>>>   hw/net/vhost_net.c      |  8 ++++++++
>>>   hw/net/virtio-net.c     | 36 ++++++++++--------------------------
>>>   hw/virtio/vhost-user.c  | 31 +++++++++++--------------------
>>>   4 files changed, 31 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
>>> index 0740d5a2ebe6..6edc0a222f3b 100644
>>> --- a/hw/net/vhost_net-stub.c
>>> +++ b/hw/net/vhost_net-stub.c
>>> @@ -53,12 +53,12 @@ void vhost_net_get_features_ex(struct vhost_net 
>>> *net, uint64_t *features)
>>>   int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>>>                            uint32_t config_len)
>>>   {
>>> -    return 0;
>>> +    return -ENOSYS;
>>>   }
>>>   int vhost_net_set_config(struct vhost_net *net, const uint8_t *data,
>>>                            uint32_t offset, uint32_t size, uint32_t 
>>> flags)
>>>   {
>>> -    return 0;
>>> +    return -ENOSYS;
>>>   }
>>>
>>>   void vhost_net_ack_features_ex(struct vhost_net *net, const 
>>> uint64_t *features)
>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>> index a8ee18a91266..13f926b5cfb6 100644
>>> --- a/hw/net/vhost_net.c
>>> +++ b/hw/net/vhost_net.c
>>> @@ -42,11 +42,19 @@ void vhost_net_get_features_ex(struct vhost_net 
>>> *net, uint64_t *features)
>>>   int vhost_net_get_config(struct vhost_net *net,  uint8_t *config,
>>>                            uint32_t config_len)
>>>   {
>>> +    if (net == NULL) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       return vhost_dev_get_config(&net->dev, config, config_len, NULL);
>>>   }

[...]

> So I agree, according to the spec we shouldn't set any read-only 
> configuration field (including MAC address) in the realize.
> 
> I update the patch.

Could you also document these functions in "net/vhost_net.h"?

Thanks,

Phil.


