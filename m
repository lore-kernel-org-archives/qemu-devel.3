Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BCBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5HQ-0005BT-5Y; Tue, 07 Jul 2026 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh5HH-00051X-Ow
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh5HD-0002Lc-Do
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v2EEHFy2lMx8j06z1CGuOpXgndm2S9xPoAxMnDH3jGc=;
 b=ETE/9Aw992xHtHw+azGuQMlvQ1Z22PwJ7jR51aPjlCarCGeSGW239TV8U3NAAQWot3TIFN
 U6SZAXll7m5uj3ZRHB6X+vmuUixuGqrzW38zApJIhxvS/jRE8kZbaCb3H6WCHdznZbQvLN
 KJrJbNMb2n9xHDQH4jDvI3R6W+QK5p4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-PK7YNfqxMr-67UFTwqeatA-1; Tue, 07 Jul 2026 08:51:48 -0400
X-MC-Unique: PK7YNfqxMr-67UFTwqeatA-1
X-Mimecast-MFC-AGG-ID: PK7YNfqxMr-67UFTwqeatA_1783428708
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493b54823bdso4306475e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783428708; x=1784033508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=v2EEHFy2lMx8j06z1CGuOpXgndm2S9xPoAxMnDH3jGc=;
 b=coEHGPFAgSi8h1jRAvAY/JEZFXvHxmWjRYO1rUlERp8knO+cdQZYv1mCeMEqQVYnOE
 5zwdxZEmcQuMq5VrTj8stQkTtSUoj7GJtkmxritJC8mqn223coCK0GSwRfevzC1S1s86
 1wPsFf4xLMUPrhSDZj++T01oavWlbzrOl7EKmudu0Uzk299y1MbadLsdBdU9Mk/Mvab+
 L3wIYi9nnbydKuDtmPQC4UwvMa+umDvddu1L+nOW/gx9bOul8vLXbiCCZMTw+fcTRBSw
 qo7LeFH3twSm5V35UmR4rlts5tRQToE+PvX5pYY5rIKgsF5zL7+JAYZ8ed/uSE3wwKau
 h3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428708; x=1784033508;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v2EEHFy2lMx8j06z1CGuOpXgndm2S9xPoAxMnDH3jGc=;
 b=g3Mpr3tnNlFMA/FCccfIo/zhKUhuq4PWaY2jib91UdAAuiYZ6Nj3P1qTq3Af0IooPy
 Gi24seftS5BL9oQ4idCAmfz+FmuchoAxxWD6CAj7n/EtZ1YLq9kBjaksjVmMsniwZjQ4
 Q86BPT3O1LFZi2S9Eg4RP76cWFjDstYj8jUBK6s5GGOMC/Q/AtjgqNYlwKf1cYz/fmLh
 9HnT2mdX0oT8i7E8//HVtxcjXp/PyN8sr8io03QiU6r769wAmuh6wl20De+Aok6PBFpk
 kXCuUvFtO27iS5wb+5j465efMa7jihf3Qu3Na1ZfOXBVJfzWRXnaY7WOBy0E2DIlr89E
 yICw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxJRV2QsmhKFWEoZgRRIZR981bWh1Dvhryo3gu9290w94z/YecRnbBLZ8id1VWWKz3xi2YO/3qGixP@nongnu.org
X-Gm-Message-State: AOJu0Yw9/lxGQDFtai9uY4yBJKRl5QAkEgiz94TROba++Ms8oykJ0fda
 K+yvAqSQ+WQ76DKGJ9AzJv1rq0vawq/34pbnpzObFmPsygZAuTjFLMkaJy/pzOyCqU4fcAhKYOI
 dxDKVpd7FhzsQmLH7/yjyB7IwoJKNdyJwsAFZzCxDpK0/y5yZU+D+gkD6
X-Gm-Gg: AfdE7ckjQ3RM2JsWoGTDouNbbLBByxOh6/2UNsqBToA4+CgAiUdVMEM8plSxdPScWJ8
 anuCnCa2eMTRhHD0bW/yZtFdWffIvSH58HIIDYP3lgrtSJZHhkTjXxy6MkYwAejoEKYJpNwMxpI
 sG5EzwMnw4T5VIBkPFsCHfunvabXDdzG9N4fvwj1ZdlUOQQDZTVC9mN5FRO/nVve3tUYYs6MGMr
 MMLyQYA8d5yUPocpCxkGNBQEpcl8fKQ66lJQwH90SHYQxbOnAUlYPDGH+OU/jWbIHmEeWGN3Ap4
 6HK3HzMBJQGzJJVXwEJ+rinqq7a+Dsq99A42T3fGEQb+dxl0SU3J7V8vSeP4KZAMFDaxh7DxVHO
 UXFJwsCzgfbZ2z7/znTGKA5pr4JXiX5cS83LJG0gklqtM0qaA6Q==
X-Received: by 2002:a05:600c:1d23:b0:493:bc4a:a14d with SMTP id
 5b1f17b1804b1-493e136e3b6mr25717075e9.19.1783428707709; 
 Tue, 07 Jul 2026 05:51:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1d23:b0:493:bc4a:a14d with SMTP id
 5b1f17b1804b1-493e136e3b6mr25716265e9.19.1783428706677; 
 Tue, 07 Jul 2026 05:51:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f32660sm54562735e9.2.2026.07.07.05.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 05:51:46 -0700 (PDT)
Message-ID: <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
Date: Tue, 7 Jul 2026 14:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz
 <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-5-bin.meng@processmission.com>
 <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/7/26 14:34, Philippe Mathieu-Daudé wrote:
> On 7/7/26 10:34, Bin Meng wrote:
>> Spansion flashes expose the number of dummy clock cycles through CR2V
>> register [1]. The value is a cycle count, not a byte count, so the
>> m25p80 model has to convert it to the number of whole SSI transfer
>> bytes consumed while collecting read command data.
>>
>> Add a helper that multiplies the CR2V dummy cycle count by the phase
>> width and rounds up non-byte-aligned counts, matching the byte-oriented
>> SSI model. The default eight-cycle configuration keeps the same byte
>> counts as before.
>>
>> [1] https://www.infineon.com/assets/row/public/documents/10/49/infineon-s25fs128s-s25fs256s-1-datasheet-en.pdf
>>
>> Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
>> Signed-off-by: Bin Meng <bin.meng@processmission.com>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>
>> ---
>>
>> Changes in v2:
>> - change spansion_extract_cfg_num_dummies() to spansion_extract_cfg_dummy_bytes()
>>    to avoid confusion
>> - use assert() when the dummy bit count is not byte-aligned
>>
>>   hw/block/m25p80.c | 32 ++++++++++++++++++++------------
>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index d7a9d79373..545e0b5728 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -1057,6 +1057,23 @@ static uint8_t macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
>>       return dummy_bits / 8;
>>   }
>> +static uint8_t spansion_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
>> +{
>> +    uint8_t dummy_bits;
>> +
>> +    dummy_bits = extract32(s->spansion_cr2v, SPANSION_DUMMY_CLK_POS,
>> +                            SPANSION_DUMMY_CLK_LEN);
>> +    dummy_bits *= bus_width;
>> +
>> +    /*
>> +     * Assert that the dummy bit count is byte-aligned
>> +     * as SSI core can only consume whole dummy bytes.
>> +     */
>> +    assert(dummy_bits % 8 == 0);
>> +
>> +    return dummy_bits / 8;
>> +}
>> +
>>   static void decode_fast_read_cmd(Flash *s)
>>   {
>>       s->needed_bytes = get_addr_length(s);
>> @@ -1075,10 +1092,7 @@ static void decode_fast_read_cmd(Flash *s)
>>           s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
>>           break;
>>       case MAN_SPANSION:
>> -        s->needed_bytes += extract32(s->spansion_cr2v,
>> -                                    SPANSION_DUMMY_CLK_POS,
>> -                                    SPANSION_DUMMY_CLK_LEN
>> -                                    );
>> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 1);
>>           break;
>>       case MAN_ISSI:
>>           /*
>> @@ -1111,10 +1125,7 @@ static void decode_dio_read_cmd(Flash *s)
>>           break;
>>       case MAN_SPANSION:
>>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
>> -        s->needed_bytes += extract32(s->spansion_cr2v,
>> -                                    SPANSION_DUMMY_CLK_POS,
>> -                                    SPANSION_DUMMY_CLK_LEN
>> -                                    );
>> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 2);
>>           break;
>>       case MAN_NUMONYX:
>>           s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
>> @@ -1151,10 +1162,7 @@ static void decode_qio_read_cmd(Flash *s)
>>           break;
>>       case MAN_SPANSION:
>>           s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
>> -        s->needed_bytes += extract32(s->spansion_cr2v,
>> -                                    SPANSION_DUMMY_CLK_POS,
>> -                                    SANSION_DUMMY_CLK_LEN
>> -                                    );
>> +        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 4);
>>           break;
>>       case MAN_NUMONYX:
>>           s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
> 
> This breaks the test_arm_emcraft_sf2 functional test:
> 
> not ok 1 test_emcraft_sf2.EmcraftSf2Machine.test_arm_emcraft_sf2
> 


No problem on my side.

C.


