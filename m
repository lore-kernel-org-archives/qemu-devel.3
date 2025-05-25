Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BC5C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJD90-00059W-7D; Sun, 25 May 2025 11:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD8r-00053q-Cc
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:01 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJD8p-0006ya-IB
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:20:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4d877dfb3so238791f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186397; x=1748791197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sUcRthyO7NQK7sZA75EGL4Oasjz/aYc7VVal8xGYmY0=;
 b=X2M5UV0+w96d5pN6o+/QanlIyNeV8WlX15GnWoRy8+uoPS1PRjasMWQvaoYvldBvht
 MnOccIMsmJCxHRR6+ejA6pdixzQq53h89WhCwMA9gSV0Rx/67dqW1WwfQ++TLj0MWT1v
 hJodE3J55MIyMmLafzrWIecnBixrmoSVU+bn2IU+CAk7lPKO+mw78tXdCGp04jeuQC6z
 4RyeYXHr3q5EjzVhkXKILk5ba6Bi4sQZm1mxfB0ySWT8SA/j5/8E8DoaqH1IvjjjJm3T
 5RK9KHB3SYN8LmTJC8gTdwoBNuL7BsITDvUImZ9Te+x4Qj8tujFU0/5vzLN4v3u6xvud
 aHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186397; x=1748791197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sUcRthyO7NQK7sZA75EGL4Oasjz/aYc7VVal8xGYmY0=;
 b=HBmHPxFFhQZlG7q/oL1zo43o3bl13qoiDtzqP8AliSJrB4Mu+YOmjANuSsiTpNVcf1
 B6UlFfGUXkHt11DwqHdDN0Z1Y7r34gAHRizzxM8/5FhImlXTlMYnFCrrlpH8QBlqDgMu
 BvZdkaa8K04d6/mpjAjmHl8aBl2n0dIr46CHKRTnes180jHddZYi3NCOkqD4xb25Efsz
 vRtEdqq09mUng1gvkzZUu35xT79KmvHFMPCM3r/X0kTokIJnZhaFy1EqdFFL3b5uH0mj
 sh2jCWz504NXMnoq0dhldnQBF+Lgnnb8PNJkH0You+EmVyWBSu42HwUsBxSpPxGOHP/9
 u0oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUujzi8RAZ1bw0E8XEZKD+EMJEmS1vEjIzjfmh+KywPbwzQx0IQ+dc/J8o4xoQsNG7ZHcjiznHYFhnv@nongnu.org
X-Gm-Message-State: AOJu0Yy4DyPTa0O9CDJdFKyvXqI759ZNBzH57TtEg1RIe4kWTCuMVaqk
 8NtHHXdNOdpVSFU5LeJGVny79yqvkEU8pTnv3fiD6Xk2pubMab/V5WQ9zbRhBUuOPJA=
X-Gm-Gg: ASbGncsrE6NCAeGtUx/jj4ix3dvhPGdKbHDaUeqUZ1lsjOyuxNO2q7hohKy5peBAhis
 j4TXpuJXTCqImewgkPY5hEORAn3t4q5gKNas+5QV6r4+fEphYuDE/peuJ9MLl4bvWyelYSOqQlc
 7cxKCdopEYzEiIo8ZMZfcLz/VjRANugTWx+jDRNf/TPmHAr7MxtIyB3j2bHBtMJXc/mjNxB5zgb
 ucu0RmtumBBLF17QZo/YXZyhP1tcWJDjtKIIFAmh4ztXooBGmj4gk3TATJ/yV/5UdWk2ux8O8Jm
 q27IVmj7Cou0PvNhh9o22tHTYoJLdIJ6Ivr9iecMY4gQrYncPM6358BeZiHBRHSCbE/sgsxNJJV
 UslI0zGMgRuuJDng0aKwi+eDbXylQME1P7x4yWw==
X-Google-Smtp-Source: AGHT+IFlT5i5kKk3Z0SM0a41dpKM6/SUmh8tZRBXgiz7PPSaXTpz+AAwwxzsDzMQnnTRJv/bi4kwdg==
X-Received: by 2002:a05:6000:2389:b0:3a4:d238:682b with SMTP id
 ffacd0b85a97d-3a4d2386cbamr2446821f8f.51.1748186397110; 
 Sun, 25 May 2025 08:19:57 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebd6fe86sm301311865e9.0.2025.05.25.08.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:19:56 -0700 (PDT)
Message-ID: <25d9fac2-66c2-4a55-b41c-d932c8a33dee@linaro.org>
Date: Sun, 25 May 2025 17:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] contrib/plugins: add a scaling factor to the ips
 arg
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-8-alex.bennee@linaro.org>
 <2aece273-04e9-48ee-aa97-dfe1d8c0d6d8@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2aece273-04e9-48ee-aa97-dfe1d8c0d6d8@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 22/5/25 06:45, Akihiko Odaki wrote:
> On 2025/05/22 1:42, Alex Bennée wrote:
>> It's easy to get lost in zeros while setting the numbers of
>> instructions per second. Add a scaling suffix to make things simpler.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> ---
>> v2
>>    - normalise the suffix before a full strcmp0
>>    - check endptr actually set
>>    - fix checkpatch
>>    - scale_entry -> ScaleEntry
>>    - drop hz from suffix
>> ---
>>   contrib/plugins/ips.c | 34 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>> index e5297dbb01..eb4418c25b 100644
>> --- a/contrib/plugins/ips.c
>> +++ b/contrib/plugins/ips.c
>> @@ -129,6 +129,18 @@ static void plugin_exit(qemu_plugin_id_t id, void 
>> *udata)
>>       qemu_plugin_scoreboard_free(vcpus);
>>   }
>> +typedef struct {
>> +    const char *suffix;
>> +    unsigned long multipler;
> 
> As I suggested for the previous version, let's use uint32_t or uint64_t.
> 
>> +} ScaleEntry;
>> +
>> +/* a bit like units.h but not binary */
>> +static 

const

>> ScaleEntry scales[] = {
>> +    { "k", 1000 },
>> +    { "m", 1000 * 1000 },
>> +    { "g", 1000 * 1000 * 1000 },
>> +};


