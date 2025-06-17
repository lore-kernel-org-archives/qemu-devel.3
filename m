Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A5BC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 17:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRaGW-0001uc-F0; Tue, 17 Jun 2025 13:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uRaGL-0001th-Q8
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:38:26 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uRaGI-0000Ed-5n
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 13:38:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748764d8540so5264621b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750181891; x=1750786691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VuemgY0fVVu6jMDUyH8KzEZYvFzJ+JUeJ+UMwyzDkSQ=;
 b=IdLoApBS5rO1sPWvZ/71TMTyz9bZ7lEzBOZYQ2DZebOE+6IdfrKpPcUAjux1HsgeC5
 c/JCQH7V+wkYfaYKPbXlpwI3U4f8UmUZkt8gI627WC0ce9YZvaC33Jkx0xq5jIV5SMik
 yvQ/2fcw6cM9fgxlTnoGThgzc86JYkqpxoa9IiGdOVNeIg6403iHS9mbZRFv40rUIE/2
 FRW78cADujBgZC8eGtI8Pr5ZlSgHT6DNjNiBj9xdzWU2y3CQix34RstvW8xi7F0b5w5G
 xd3cBPfCwyyBYBiw/4QLeg/vtH7EbcoqOENi1e8cy9on1uujwVMRE7JBE7Jzi7Cxhrdw
 aC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750181891; x=1750786691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VuemgY0fVVu6jMDUyH8KzEZYvFzJ+JUeJ+UMwyzDkSQ=;
 b=qIwPVND+eN+hg/eprppvw7QSyLU4YzKP13kpssx6IAmpKQCzS41+T7d01dpP8vSjwp
 jrjn9saPfnEF7KxFK1HKoN7f/yAgWh5MjHNJ5aPGD8waN2uOp+eeQPc7nqTSNd1HFTgL
 MqzTAG6b8NkznRHRYorqOt8lkRfMHBkZPxUDm/rH1FlFibuf/6bWk1Z/2VKhtqJ1rrjv
 SKi1kfDe93DVfgX7laZ8HavXKCg3fFeZIQDO0Fp7C5iL8L4/B0CGBt5zahUj18vAPT9f
 kbOCVbk/lrGRydTNvJ9LABkbDGtP7Eba9brNlzuRN9e89R00szirRBSbregWC56GmpI/
 1uYA==
X-Gm-Message-State: AOJu0YzDKpy6rDGDg+QVc42inys73CCa9dQ8iCBukVumInclyW+uzCtz
 DE1m1eotNfrGlG/JpVCY107S8olJEBHE9BlcQbvgIEtjUKbiP0M1YrbMpQ2JfA9JTQ4=
X-Gm-Gg: ASbGncvHcRfDf72J9k9ygyNIIe3eelBPr4DYyD89OuDRoG7R9MIuqgXTOv4gtANh063
 sLxMXTtprUInggwAIIOncGldZhCIfzrGa1P+1PJYhVyPEKG2AaO40nwU1mkxlB/L2eAv2hf9kTX
 iY8q3qD9+5CUFxkdhMJjOfaUZwcZ35OMLgCaDavdGugowOwyhU5oU069ctme9N6psIyQ47Iap02
 2X0W+W9jKhAUm4cIAqyaxEOlsPHtM2RlCJdRGdTJSbi17b/OwC0HpaD6bYblwg8gOBxki/gp/ML
 IIMWiWHZGZ2rZBHkzMGf092P4MSlXvRcYrUsFEYPy/RYld+LhvpSGyl6AaV3T7WPxP4Ny2C7MY8
 =
X-Google-Smtp-Source: AGHT+IF1eW5CIj9+xDj0t1GOMZPD7kBee7eEKy2IkrcAJk7KcgQDgg04iYtM7JZatMjRp5+n9+lPKQ==
X-Received: by 2002:a05:6a00:4fce:b0:746:31d1:f7d0 with SMTP id
 d2e1a72fcca58-7489cf7263bmr17207070b3a.9.1750181891274; 
 Tue, 17 Jun 2025 10:38:11 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7488ffeca93sm9143794b3a.20.2025.06.17.10.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 10:38:10 -0700 (PDT)
Message-ID: <3fe049b2-a962-4dc2-9373-570c35fb8355@linaro.org>
Date: Tue, 17 Jun 2025 10:38:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] plugins: Add memory hardware address read/write
 API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250611232409.2936521-1-rowanbhart@gmail.com>
 <20250611232409.2936521-6-rowanbhart@gmail.com>
 <87h60evf6t.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h60evf6t.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/17/25 3:24 AM, Alex Bennée wrote:
> Rowan Hart <rowanbhart@gmail.com> writes:
> 
>> From: novafacing <rowanbhart@gmail.com>
>>
>> This patch adds functions to the plugins API to allow plugins to read
>> and write memory via hardware addresses. The functions use the current
>> address space of the current CPU in order to avoid exposing address
>> space information to users. A later patch may want to add a function to
>> permit a specified address space, for example to facilitate
>> architecture-specific plugins that want to operate on them, for example
>> reading ARM secure memory.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> <snip>
>> +/**
>> + * qemu_plugin_write_memory_hwaddr() - write to memory using a hardware address
>> + *
>> + * @addr: A physical address to write to
>> + * @data: A byte array containing the data to write
>> + *
>> + * The contents of @data will be written to memory starting at the hardware
>> + * address @addr in the current address space for the current vCPU.
>> + *
>> + * This function does not guarantee consistency of writes, nor does it ensure
>> + * that pending writes are flushed either before or after the write takes place,
>> + * so callers should take care when calling this function in plugin callbacks to
>> + * avoid depending on the existence of data written using this function which
>> + * may be overwritten afterward. In addition, this function requires that the
>> + * pages containing the address are not locked. Practically, this means that you
>> + * should not write instruction memory in a current translation block inside a
>> + * callback registered with qemu_plugin_register_vcpu_tb_trans_cb.
>> + *
>> + * You can, for example, write instruction memory in a current translation block
>> + * in a callback registered with qemu_plugin_register_vcpu_tb_exec_cb, although
>> + * be aware that the write will not be flushed until after the translation block
>> + * has finished executing.  In general, this function should be used to write
>> + * data memory or to patch code at a known address, not in a current translation
>> + * block.
> 
> My main concern about the long list of caveats for writing memory is the
> user will almost certainly cause weird things to happen which will then
> be hard to debug. I can see the patcher example however it would be
> useful to know what other practical uses this interface provides.
>

I understand the concern that allowing modification of execution state 
through plugins opens the path for possible bugs. However, it 
significantly augment what is possible to do with them, especially for 
security researchers, as Rowan listed in his answer.
For once, we have someone motivated to contribute upstream instead of 
reinventing another downstream fork, so it should be encouraged.

As well, in case "weird things" happen and people file a bug report, 
they will be free to share their plugin, so we can reproduce and solve 
the problem. It should concern only users trying to modify state of 
execution though, so definitely not the majority of plugins users.

Pierrick

