Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D00E94623
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 00:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpbRi-00041Y-7X; Mon, 09 Feb 2026 19:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpbRf-00040i-Tt
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 19:17:36 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpbRe-0001YY-7v
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 19:17:35 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-824484dba4dso218830b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 16:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770682652; x=1771287452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RsP5xhwt99Vex4Ko8NUlz6X6TGZrS6+gPnenynOgtQg=;
 b=PZCVzZe19IOm9+VJraFFrRWdigLeLQOAYlXThHQo/QUx+kupY0JR9LV5JJmKZYTUuU
 FEH9JOsKPfr5G6qwL190jvX+qIle1TZZgLVOe4aoP8Dojlh90ZD1NNLsUdf7jDaAaC1L
 9YT4AazNpk8Lb8n2NKVxbeKUXaH8uYjrvXcZF+HTSAqT/CpBpVWPXJhv7Aa+3xCI2S/G
 VoucSKWnS5ICQTPkjhhc/iqZVBYuhj+oJdZcw0vHR/plcQtFD6lbgwdA8apmgBOyHacI
 9tMXdyVeaVi6cVZDazNLxRde6F+xb1pUFEVUaiBqt7cgqjtBOfLxkb8IjHmpB1EV71w5
 gyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770682652; x=1771287452;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RsP5xhwt99Vex4Ko8NUlz6X6TGZrS6+gPnenynOgtQg=;
 b=TEOopZzvmcmbxP3idkNLysH1NEaimM8RtIOYxmAQrLbv+sJjpPhTe/fT/kDfcxRl9x
 sw80b5DVocdxEjxJDRwcj2O65QG558Ol26Oocv8tQoVALBI4YOWGHGLtgsywSUiqHxD8
 Y95kr9Rm5BoixrPuFEkGTflNNGCKd43EgZPfyj7nUkKvE2aYypnP5cfpG7wROvJ04E8V
 U6dnXBenV14SY6E7BM7+67ngrA8S6E26gMQ9I7gWMJIQc3E0Db+S6MRMoRyU3ct7Q47v
 YfK7r5OY268D+FuGGHNLiFH6yWmC6O97uK9ewPAXbgakRPQhpib47xKG9kmo9P+5ejR2
 PauQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfnsXf84vnHjA0O436WW6h73LEfjOzTusKE27OXa1xkOiNsXCLuvdNc/2ntQ8zUvdbyykgFrVHpHFq@nongnu.org
X-Gm-Message-State: AOJu0YxCPXnMIL9iZ7MBwp7U0ZgJggMxTLmcGcfildinUPur38mCq5bF
 XTHjIQZr2SVDMrJi9THyyosYpihII5DkRI/EhtN2ATMV5B/2kuEdqj5khV4WSXZPTWk=
X-Gm-Gg: AZuq6aLCf03Lc8c1Q26Ks9wzE/BHic58HuUTOQ8uvOSJ2Af3vrkxUFdnVFCDrzpp35Y
 bMfkctWRjtm+wqm91Cdfmu3AVtL4K/5qQsZ05WB6fEUba/6B9jSg0w7ADtA9QAEW8nvvhl2OAIm
 dczkQRSbMv7jJvONA/ToNvktzvqxrkltEjyJb2l+/biF17pxYlTlNIwFJqWe0mQmMnob9C9yckr
 VXcucJQ/tzCwJKv8jr0r2EClRqRfwk0rRhImFnShm/71OP7X9nYGEgEfQeZYJuEZXzsvL4s0bTU
 8LP2EmNSMYe9WTrvjFGzdf3LTEykyQcy9FigkWYoLur/1gdnf56+1GzdiVmaIccALkSV0AkV9gc
 Ox4T/ILgM9Ade+kbj0TKg+405NlBL3GQxJgA5zYpkgti7YxEh0aiP3+FLC70eKIZBxEYPF2BUWf
 rU/iKhpDSzApT8CLJg9dvzNlqpMauQLSOBpf7J4n2SHKISAgk6+Z724OVxLnB5xqqL0k7Qgs7m/
 ITiV+JKjg3K
X-Received: by 2002:a05:6a00:400b:b0:7b9:420:cc0f with SMTP id
 d2e1a72fcca58-82441610243mr11671437b3a.14.1770682652120; 
 Mon, 09 Feb 2026 16:17:32 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:bc29:21c6:e150:bc42?
 ([2001:8003:e109:dd00:bc29:21c6:e150:bc42])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418b842dsm13798503b3a.52.2026.02.09.16.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 16:17:31 -0800 (PST)
Message-ID: <bbb8625c-35a2-41e9-9b38-ce8286260251@linaro.org>
Date: Tue, 10 Feb 2026 10:17:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] include/hw/virtio/virtio-access.h: simplify
 virtio_access_is_big_endian
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-6-pierrick.bouvier@linaro.org>
 <31906e49-62b2-47a3-9cda-cd90d5e29f4a@linaro.org>
 <701835b4-3bfa-4f8b-b788-f6d1779bf48e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <701835b4-3bfa-4f8b-b788-f6d1779bf48e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 2/9/26 18:04, Pierrick Bouvier wrote:
> On 2/8/26 9:19 PM, Richard Henderson wrote:
>> On 2/7/26 08:19, Pierrick Bouvier wrote:
>>> virtio_is_big_endian already checks for VIRTIO_F_VERSION_1 feature, so
>>> this is redundant with big_endian_code.
>>> Also, clarify why we explicitly check for ppc64 and arm arch.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    include/hw/virtio/virtio-access.h | 17 ++++++-----------
>>>    1 file changed, 6 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
>>> index 1bea3445979..9aed3d1da4f 100644
>>> --- a/include/hw/virtio/virtio-access.h
>>> +++ b/include/hw/virtio/virtio-access.h
>>> @@ -22,21 +22,16 @@
>>>    #include "hw/virtio/virtio.h"
>>>    #include "hw/virtio/virtio-bus.h"
>>> +static inline bool legacy_virtio_is_biendian(void)
>>> +{
>>> +    return target_ppc64() || target_base_arm();
>>> +}
>>> +
>>>    static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>>>    {
>>> -    if (target_ppc64() || target_base_arm()) {
>>> +    if (target_big_endian() || legacy_virtio_is_biendian()) {
>>>            return virtio_is_big_endian(vdev);
>>>        }
>>
>> This now calls the hook for all big-endian, not just bi-endian.
>> I don't think you need to change anything here...
>>
> 
> If I'm correct, that's what original code was doing:
> 
> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>      return virtio_is_big_endian(vdev);
> #elif TARGET_BIG_ENDIAN
>      /* duplicated code for virtio_is_big_endian(vdev) */
>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>          /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>          return false;
>      }
>      return true;
> #else
>      return false;
> 
>  From what I understand, legacy virtio devices follow host endianness (thus considering 
> all big-endian arch), while virtio >= 1.0 devices are always little endian.
> 
> What did I miss to consider it should only be called for bi-endian arch?

   if (target_big_endian() || ...) {
     return virtio_is_big_endian(vdev);
   }

invokes virtio_is_big_endian for e.g. sparc, which it never did before.

The first #if defined(LEGACY_VIRTIO_IS_BIENDIAN) is exactly your 
legacy_virtio_is_biendian(), and is the only time that should ever be invoked.

Separately, you noticed that virtio_device_endian_needed already checks 
VIRTIO_F_VERSION_1, so checking it a second time here (possibly with the rest of the 
changes in this patch set), is unnecessary.  Which allows you do remove the big-endian 
check entirely.

I do think that (again, possibly with the rest of the changes in the patch set) the 
function virtio_access_is_big_endian should be merged into its single caller, so that (1) 
it's obvious no further check vs VERSION is required and (2) no further calls of 
virtio_access_is_big_endian can be introduced.


r~


