Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BADD47CDE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghjs-0003b2-RD; Fri, 16 Jan 2026 06:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghji-0003Wq-8i
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:11:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghjg-0004d7-QD
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:11:26 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso10503315e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768561882; x=1769166682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77cgBHRlUnShoBzWPACbQPJ12pA4mzmrLz5x0XftaM0=;
 b=WzRprK6IlA6xbZKEaQA4AWjhHwSwMJAiN/AzohE81JrecBDqetfTe+z2tRklC9ZPQd
 IT5e3aAgLX+qHszYno7zkGJg1Ua1JtET1h8kvO+kXtBUddNJOhGrnGSNS1s14Tf+cI6G
 +uE2rVmteC8tpJCgpwHao7Y8tWLsMmDziu9Qjg4S74WwOGz/I3o2KKw3LKvcidn6Z8rZ
 yUgYzLF6nA48efYCwCQTP7u42AawTaegR2x+W7pVl69Hd112ovkBeZbjLK4Tb4PP9+jZ
 vIh7FdWa+FQnr0Q9HBOZybXrBtqc0mtRfjQvQpeiWH/985zlRJlRV0a3vobiCAGVUvIU
 q9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768561882; x=1769166682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77cgBHRlUnShoBzWPACbQPJ12pA4mzmrLz5x0XftaM0=;
 b=ivdAN9W1/7VQMZwx3iZPyXjgIXF1lWID2D2pk/80puzzEx1KzNNnzdQ8NSMCFpWBOG
 8cq7vVcwvOH3b/zq+z9mJPAb6vxk/xDShAAogyA1u0dow56OVLrQmhK+nFJ7XdVIzYGU
 B3R38IBJt2UV0MXz+oH9qJvKuqSBb8K9QbYqPFgKpRIeuRElDm72C5VYj402gDG8HLxz
 z/8fJCxycbZRaVmMF9WgVOfX5dzm37+iCSsydM1R9CGExmzHVjxtkBWqNZzdFiTWN5z7
 NdD9idOOBWS9EynjztybbEpFxyafE/kMsx+7Ro2SxVLr4NkJhMskyUmJt6fRqdq/j5qZ
 De/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9HBoYfc3yFsraqEokolIzMme5st9K02DdYsDO+AF7rYrN7z8sKKsjpFEZNQYbCKf7k2YmrZBekdXl@nongnu.org
X-Gm-Message-State: AOJu0YzBkq/Bd36ZKvP3zlYVGcJHq14Bp9aIJ8JjDLZwoCL6AFKFVQtG
 AGPSsN2diu9Mvwus52OvmZ7gyaC3suEJXTiWiJCyZFcluctB1OUQMijuIUfnBwWEwAQ=
X-Gm-Gg: AY/fxX7O3AjHSIhx2OPspJ7kNKFEiF+SuchRpQDG8QCVCF82ZwxdFJffTxQ+zC8OuZV
 Isrcd0khKVpieST7fRGZjCqKX2I8a2oKSsaEr9977YSHk/cmmt4eLtHGnR31SO7nBXSpuLjUzlQ
 3fWwtgCLxGV3yVyxcdPpjzDIK2RUTI5jwnlCDniEmliskcq2dt192Joau+L546iD2GLnIBoQhud
 4B/XNkFcGJX2jGHyJOXWF+nGIdotWBAg3m18wmjgJ8g7v0Sk8e9YynvQYE2LXDTeZQWYG4K9KEN
 OLSs/FJRYhgz3GpoQI3q6e2BuUd67ZxyYuf54C6TM01L52O+TMsyzNpClHxwmzUY4/P/Q5fRjr8
 esLft65oaepwWabzwb3uVTm/4F4ajaRHRqI9xdfW32cyZPTkLp/+z/Sxezs6zA5Oy9dMM9QWEgE
 gtT2fcd4sq3M5nsdNIOwkmmm53sZ8qVhp3EmeYrKpvIlBeueESE9hsJw==
X-Received: by 2002:a05:600c:4693:b0:477:28c1:26ce with SMTP id
 5b1f17b1804b1-4801e2fe194mr33615535e9.7.1768561882275; 
 Fri, 16 Jan 2026 03:11:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879542sm39488275e9.4.2026.01.16.03.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 03:11:21 -0800 (PST)
Message-ID: <b5088bb5-80f7-4a7e-a5ec-d096a4b67bef@linaro.org>
Date: Fri, 16 Jan 2026 12:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wasm: Enable 64bit guests on TCI using wasm64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1768308374.git.ktokunaga.mail@gmail.com>
 <d848e36c-848e-4d3f-9b43-dbd14b1bbee6@linaro.org>
 <2ebf4582-630c-4f2d-980e-fd5216c4e9c9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2ebf4582-630c-4f2d-980e-fd5216c4e9c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/1/26 01:09, Richard Henderson wrote:
> On 1/16/26 08:59, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 13/1/26 14:54, Kohei Tokunaga wrote:
>>
>>> Kohei Tokunaga (4):
>>>    meson: Add wasm64 support to the --cpu flag
>>>    configure: Enable to propagate -sMEMORY64 flag to Emscripten
>>>    dockerfiles: Add support for wasm64 to the wasm Dockerfile
>>>    .gitlab-ci.d: Add build tests for wasm64
>>
>> Out of curiosity, since the series is fully reviewed, who is
>> going to merge it, Paolo or Richard?
>>
> 
> I've pulled this into my remove-32 branch, which I'll be re-posting 
> soon.  But if someone includes it into a PR first, that's fine too.

Oh OK great, I'll do that so less to carry then!


