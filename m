Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C8CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1RL-0004eR-Fe; Wed, 29 Oct 2025 04:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1RJ-0004ds-79
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:21:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1RG-0005wF-NK
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:21:52 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso1302893a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761726106; x=1762330906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k9eNJSkSUf1kp/nJB38Vc2UzKVYF9O+DLe/owaGIJTU=;
 b=MY+6djNof7z5/ZlLYpl7QowIuahenzi5JKYPQ4Om9CzyC/EDUXZrpWy0YyA6VnJePm
 02ixEBqdRJcmOOFMQm+tFA3DNFjn3QxipIXAPJB+MCPMkyNBj6iPaxUSB+i2yj7EPmM4
 9D6rh5UttlQgOoVMtpexrOkEhFENiT1bD8CqKBT5EzrF86OfZyfb5a8vMM3agOKBPu2F
 lsvSuv0wib9Ft9DAvHXEfBgOXeFp3lfikTuZUb9ctS3SFBCj9X+NpMSJuA2Rjy+x2Ny3
 qxU36HtMrYOMvATw+yA1htxtHB7LlsuK2m2iDYefrjXjwx52/TWQCnttNCjt4o1wzkp8
 n/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761726106; x=1762330906;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k9eNJSkSUf1kp/nJB38Vc2UzKVYF9O+DLe/owaGIJTU=;
 b=X44CKM5pbmJETU1UyvCNG4Q+/mmm3LW/xIT6Dv3jXWU/9MLIMB0SR2hnt+f3CcfoPF
 2eVTv8oHtL5XI9vhXMWNK+HM0ScC7p5F9J9CpMG6LFWyfen09yQvnu0kgB2p5+uva6a6
 lrG/IvKyRA9Dz4oPBXTMJBR93zCy67kAxWqRUqQoJuD4Pm9pmKqvohcmkIqPD58YDR0k
 fM8tdMmHlOgVGBO5ByfrIX3paOXaog6kiABuAqDCDJBWpvhzh5Eae2IgMmHjw/wIMujB
 eydCIS+SvrS2giS5k6BffAXj8sOt0zFvitLa5ltcsFHhZ7jMEW/XMDegTzguKWe+MtVQ
 Jvpw==
X-Gm-Message-State: AOJu0YzC9nkvnyzf2krdc3euCQ4qXUOwp/7m9OD8wVxJ8kA4zgjojdHX
 0LM3eKkiF+1nZ7Iukvni1V56GkJwIPeikIch08+7QIdVR/zvbLLsntfuAFrIOi0iqMpQIcQK3qG
 SP4niuz0=
X-Gm-Gg: ASbGncv/I31UTDhKY4z1r4zS3PaCYt7YgeYR35zNEVxAJ8jhpkmhj4AW/L/2THkgOgR
 Cn72tsgOI3jEQQ9UM7ttSbXtmfeU0VfivLD0aQKwRrAfS0KILml7TeXFYI9JEWCJWMldRpAtW3c
 FqtXHXPfTZ2Xa0fizs6YOaTgJxh1Bh2yQMGDrydizavARsJwt6cR324K7WnNS4SqtUs3a+CJZ9J
 txy9a85QLtbG6j9ufDWxWfoATXoV1aywluzI7v2PB6irwgZ4QEL1IO3xjTSdJWvczGvsqaExWEg
 eRPLSA3iTQNUnvCqXrCklB+1//jjJmHOttqhi/QJHdXewp+X8cQlqltqdlfQDmcIhwLq4W4zlRX
 YCJBRJ7FocoWTEXfdy97RMeMQCcWNRpIYo5XOHBaagV93zUOp+XhQ+ykesXcglq16rwOhaYQyTP
 e4knDiPuWwusMk3jwm
X-Google-Smtp-Source: AGHT+IGNUPbXdH/IYqRHbEldg++GT5Nf/YyMz7gn127hX2Ukzn1YuWFQQOMnWtTcGVnd5YHhku2ppw==
X-Received: by 2002:a17:907:9711:b0:aff:1586:14c2 with SMTP id
 a640c23a62f3a-b703bee0bbbmr248397166b.4.1761726106239; 
 Wed, 29 Oct 2025 01:21:46 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853c5bd8sm1350099266b.38.2025.10.29.01.21.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:21:45 -0700 (PDT)
Message-ID: <8a8ae864-b1e1-4918-8427-4ddf085b5005@linaro.org>
Date: Wed, 29 Oct 2025 09:21:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/25] system/memory: Introduce
 memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion.
> Introduce memory_region_get_address() to get it,
> similar to memory_region_set_address() to set it.
> 
> Suggested-by: Peter Maydell<peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/memory.h | 7 +++++++
>   system/memory.c         | 5 +++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I agree with Thomas that this should come first, and no new uses of mr->addr should be 
added in the first couple of patches.


r~

