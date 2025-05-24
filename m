Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6E6C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsb8-0002gx-3K; Sat, 24 May 2025 13:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsb5-0002gR-0g
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:23:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsb3-0007eI-66
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:23:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so10801335e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748107423; x=1748712223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QPVN03MEQeeCev+W1TFqfQKOU3QRbR/bOflVFVTI5a0=;
 b=Y1fZEG/oCzTbFM/4R9ZN59WpPCH5mwY+J9+ScikdV+ptsZsWHWF2olL9YDYaVfNfmG
 o0zYHqVrF7vStiJLqPp2m64vzchNoaDGoIRp0yaZ6pDY4Sjgw4qTWVa4RoJseeiVlNcO
 7zIH04nrSSETOJgh9hdQ2ZZuoeA7e0SQQFh2D+/A0xsHLYgnyUnFNtMUhQ0ZhOlC7DIm
 pMsXHyqWRVaJeTNkO4ajverili4ZhOCZuggdoDDui7vbez5sCGC6AhskHXxzYhp3IxUV
 FOq/MoMpWOSWdbLGaTN3TkM/nwcgA5T9FRIdM7gfeWEjnbmUFP1B5nBvfLusjzc1IRd9
 r66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107423; x=1748712223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QPVN03MEQeeCev+W1TFqfQKOU3QRbR/bOflVFVTI5a0=;
 b=ObZr9m+F19EEN9tNB8Dykt+RZdn7JxRz8Sq8f5lMAgZwwJwYok+CNU9S92d8hZJLr5
 i75bCu/SXfnN2Jx2EWdP3RtgGDieoLpYhKePYFiYhJt86U287JZeW42FBW2zT/touWvX
 Hjg7K7slKS9c2FduMCCrG3yEZUtWofJb25qwV2beCDzhok+mEOvkoLpl8RGAOWfXupm7
 9Xxph8sbxh97zmtAou+TUTwN0MJ5aFRauWz/XnR/lWr5OMOSWuZ5F9ojZj+ZEYBi0YFv
 5CvEYNHt8KqBxT0ilURgsCdxjiM8I6HJP3Pxej1bio1/YI4qojVE7xhRjqgh2h9HXtdx
 kq4A==
X-Gm-Message-State: AOJu0Yyn6eL6dLjTcumIcDE0tqFaOSBv/hJLNtzj5nQ6r91Tl3DxegQd
 wH06x+crfBZ1xk16OW+w0uipXHPSdTZB6YDYzvSvxPXdgBPueq5dqSL2wCzVzfCCzN15BYNYUzX
 VdlUkh58xaA==
X-Gm-Gg: ASbGncsQaFl8O8G16RDq5xm3oXK/5BagEK+I/ciM07ZX0JxkBq4Q75Hz045ztVhi9Pf
 D7xh3/00S98men8Q6M1gxzLp9CKXPguZEYQatMslRXXv0QCea8Mt+CtT9+fxTTL6YaRfjRg1RwJ
 v3EFxM1UXrEW7sW3UU5zUTPjOMCIJIpOerPwUq8XRk5+vW7ZAO4nU6FGOq/MN+A2t0Dqs9TlxgV
 S3ePpBKZdQ7kHPifBjx39WHLIseSz8rc5JjvuF/EWRojR3QkwHFfQI5M17tZrAHHJzgHZkYg7rj
 edeYlRWDTNPSsmH7mBOe2HWE4nAtN/ygmvAK+OOV8etPfjjLfykFmYdVLmMg6YSLVA==
X-Google-Smtp-Source: AGHT+IEz5Z2cf9MoZqGydP0KDC5X10iZT4CmqYNHeiph8CPrZpTGH3YSOCESE8vI8PKstfOothfdrA==
X-Received: by 2002:a5d:5848:0:b0:3a2:561a:41f1 with SMTP id
 ffacd0b85a97d-3a4cb4613cdmr3376387f8f.12.1748107423504; 
 Sat, 24 May 2025 10:23:43 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm15860588f8f.100.2025.05.24.10.23.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:23:43 -0700 (PDT)
Message-ID: <a142b4a4-0067-4dc9-88b4-00643a030ca5@linaro.org>
Date: Sat, 24 May 2025 18:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/25] target/mips: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <7e602c496a873fd55713eab740543683b69c98eb.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7e602c496a873fd55713eab740543683b69c98eb.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for MIPS targets. We consider the exceptions
> NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
> exceptions.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/mips/tcg/system/tlb_helper.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

